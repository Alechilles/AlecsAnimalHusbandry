#!/usr/bin/env python3
"""Materialize effective Hytale models for the spawner-icon renderer.

The renderer consumes standalone model JSON, while model assets commonly inherit
their Model, Texture, default attachments, and attachment sets.  This tool keeps
that inheritance work out of the renderer by writing one isolated model cache per
batch entry and a matching batch manifest.
"""

from __future__ import annotations

import argparse
import copy
import json
import os
import posixpath
import re
import sys
import zipfile
from dataclasses import dataclass
from pathlib import Path, PurePosixPath
from typing import Any


_VARIABLE = re.compile(r"\$\{([A-Za-z_][A-Za-z0-9_]*)\}")


class PreparationError(ValueError):
    """A manifest or source asset cannot be prepared without guessing."""


def _read_json_bytes(data: bytes, label: str) -> dict[str, Any]:
    try:
        value = json.loads(data.decode("utf-8-sig"))
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise PreparationError(f"Invalid JSON in {label}: {exc}") from exc
    if not isinstance(value, dict):
        raise PreparationError(f"Expected a JSON object in {label}")
    return value


def _read_json_file(path: Path) -> dict[str, Any]:
    try:
        return _read_json_bytes(path.read_bytes(), str(path))
    except OSError as exc:
        raise PreparationError(f"Could not read {path}: {exc}") from exc


def _expand_variables(value: str, manifest_dir: Path) -> str:
    variables = {"MANIFEST_DIR": str(manifest_dir), **os.environ}

    def replace(match: re.Match[str]) -> str:
        name = match.group(1)
        if name not in variables:
            raise PreparationError(f"Unknown variable ${{{name}}}")
        return variables[name]

    return _VARIABLE.sub(replace, value)


def _absolute_source_path(value: str, manifest_dir: Path) -> str:
    """Expand a normal path or the outer part of a zip-root path."""
    expanded = _expand_variables(value, manifest_dir)
    outer, inner = _split_archive_root(expanded)
    path = Path(outer)
    if not path.is_absolute():
        path = manifest_dir / path
    path = path.resolve()
    if inner is None:
        return str(path)
    cleaned_inner = posixpath.normpath(inner.replace("\\", "/")).lstrip("/")
    if cleaned_inner == ".":
        cleaned_inner = ""
    return f"{path}!{cleaned_inner}"


def _split_archive_root(value: str) -> tuple[str, str | None]:
    """Split only a .zip! asset root; mod directory names may contain '!'."""
    match = re.match(r"(?is)^(.*\.zip)!(.*)$", value)
    if match is None:
        return value, None
    return match.group(1), match.group(2)


def _model_key(value: str) -> str:
    normalized = value.replace("\\", "/").strip().lstrip("/")
    if normalized.lower().endswith(".json"):
        normalized = normalized[:-5]
    normalized = posixpath.normpath(normalized)
    if not normalized or normalized == "." or normalized == ".." or normalized.startswith("../"):
        raise PreparationError(f"Invalid model path {value!r}")
    return normalized


def _file_key(value: str) -> str:
    return f"{_model_key(value)}.json"


@dataclass(frozen=True)
class LoadedModel:
    source_id: str
    relative_path: str  # Includes .json, relative to this source's modelsRoot.
    value: dict[str, Any]


class ModelSource:
    def __init__(self, source_id: str, root: str):
        self.source_id = source_id
        self.root = root
        outer, inner = _split_archive_root(root)
        self.archive_path = Path(outer) if inner is not None else None
        self.directory = None if inner is not None else Path(outer)
        self.archive_root = inner.strip("/") if inner is not None else None
        self._paths: dict[str, str] | None = None
        self._basenames: dict[str, list[str]] | None = None

        if self.directory is not None and not self.directory.is_dir():
            raise PreparationError(f"Source {source_id!r} modelsRoot is not a directory: {self.directory}")
        if self.archive_path is not None and not self.archive_path.is_file():
            raise PreparationError(f"Source {source_id!r} archive does not exist: {self.archive_path}")

    def _index(self) -> None:
        if self._paths is not None:
            return
        paths: dict[str, str] = {}
        basenames: dict[str, list[str]] = {}
        if self.directory is not None:
            candidates = (path.relative_to(self.directory).as_posix() for path in self.directory.rglob("*.json"))
        else:
            assert self.archive_path is not None
            prefix = f"{self.archive_root}/" if self.archive_root else ""
            try:
                with zipfile.ZipFile(self.archive_path) as archive:
                    candidates = [
                        name[len(prefix):]
                        for name in archive.namelist()
                        if name.startswith(prefix) and name.lower().endswith(".json") and not name.endswith("/")
                    ]
            except (OSError, zipfile.BadZipFile) as exc:
                raise PreparationError(f"Could not index archive {self.archive_path}: {exc}") from exc
        for relative in candidates:
            key = _model_key(relative)
            if key in paths:
                raise PreparationError(f"Duplicate model path {key!r} in source {self.source_id!r}")
            paths[key] = f"{key}.json"
            basenames.setdefault(PurePosixPath(key).name, []).append(key)
        self._paths = paths
        self._basenames = basenames

    def find(self, reference: str) -> str | None:
        self._index()
        assert self._paths is not None and self._basenames is not None
        key = _model_key(reference)
        if key in self._paths:
            return self._paths[key]
        if "/" in key:
            return None
        candidates = self._basenames.get(key, [])
        if len(candidates) > 1:
            raise PreparationError(
                f"Model name {reference!r} is ambiguous in source {self.source_id!r}: {', '.join(sorted(candidates))}"
            )
        return self._paths[candidates[0]] if candidates else None

    def load(self, relative_path: str) -> dict[str, Any]:
        path = _file_key(relative_path)
        if self.directory is not None:
            return _read_json_file(self.directory / Path(path))
        assert self.archive_path is not None and self.archive_root is not None
        entry = posixpath.join(self.archive_root, path) if self.archive_root else path
        try:
            with zipfile.ZipFile(self.archive_path) as archive:
                return _read_json_bytes(archive.read(entry), f"{self.archive_path}!{entry}")
        except KeyError as exc:
            raise PreparationError(f"Missing {entry} in archive {self.archive_path}") from exc
        except (OSError, zipfile.BadZipFile) as exc:
            raise PreparationError(f"Could not read archive {self.archive_path}: {exc}") from exc

    def read_relative(self, relative_path: str) -> dict[str, Any]:
        """Read a patch relative to modelsRoot; supports ../ inside zip roots."""
        cleaned = relative_path.replace("\\", "/")
        if self.directory is not None:
            return _read_json_file((self.directory / cleaned).resolve())
        assert self.archive_path is not None and self.archive_root is not None
        entry = posixpath.normpath(posixpath.join(self.archive_root, cleaned)).lstrip("/")
        if entry == ".." or entry.startswith("../"):
            raise PreparationError(f"Patch path escapes archive root: {relative_path!r}")
        try:
            with zipfile.ZipFile(self.archive_path) as archive:
                return _read_json_bytes(archive.read(entry), f"{self.archive_path}!{entry}")
        except KeyError as exc:
            raise PreparationError(f"Missing {entry} in archive {self.archive_path}") from exc
        except (OSError, zipfile.BadZipFile) as exc:
            raise PreparationError(f"Could not read archive {self.archive_path}: {exc}") from exc


class EffectiveModels:
    def __init__(self, sources: dict[str, ModelSource], base_source_id: str = "baseGame"):
        self.sources = sources
        self.base_source_id = base_source_id
        self._cache: dict[tuple[str, str], dict[str, Any]] = {}

    def _find(self, source_id: str, reference: str, *, fallback: bool) -> LoadedModel | None:
        source = self.sources.get(source_id)
        if source is None:
            raise PreparationError(f"Unknown source {source_id!r}")
        relative = source.find(reference)
        if relative is not None:
            return LoadedModel(source_id, relative, source.load(relative))
        if fallback and source_id != self.base_source_id:
            base = self.sources.get(self.base_source_id)
            if base is None:
                raise PreparationError(f"Source {source_id!r} could not find {reference!r}; no baseGame source exists")
            relative = base.find(reference)
            if relative is not None:
                return LoadedModel(self.base_source_id, relative, base.load(relative))
        return None

    @staticmethod
    def _merge(parent: dict[str, Any], child: dict[str, Any]) -> dict[str, Any]:
        """Apply asset inheritance without deep-merging map fields.

        Ordinary object sections retain omitted direct properties. RandomAttachmentSets
        is a map field in the model codec, so an explicit child map replaces it.
        """
        result = copy.deepcopy(parent)
        for key, child_value in child.items():
            if key == "Parent":
                continue
            parent_value = result.get(key)
            if (
                isinstance(parent_value, dict)
                and isinstance(child_value, dict)
                and key != "RandomAttachmentSets"
            ):
                replacement = copy.deepcopy(parent_value)
                replacement.update(copy.deepcopy(child_value))
                result[key] = replacement
            else:
                result[key] = copy.deepcopy(child_value)
        return result

    def resolve(self, source_id: str, reference: str) -> dict[str, Any]:
        loaded = self._find(source_id, reference, fallback=True)
        if loaded is None:
            raise PreparationError(f"Could not find model {reference!r} in source {source_id!r} or baseGame")
        return self._resolve_loaded(loaded, ())

    def _resolve_loaded(self, loaded: LoadedModel, stack: tuple[tuple[str, str], ...]) -> dict[str, Any]:
        key = (loaded.source_id, _model_key(loaded.relative_path))
        cached = self._cache.get(key)
        if cached is not None:
            return copy.deepcopy(cached)
        if key in stack:
            cycle = " -> ".join(f"{source}:{path}" for source, path in (*stack, key))
            raise PreparationError(f"Cyclic model Parent chain: {cycle}")

        raw = loaded.value
        parent_reference = raw.get("Parent")
        if parent_reference is None:
            effective = copy.deepcopy(raw)
            effective.pop("Parent", None)
        else:
            if not isinstance(parent_reference, str) or not parent_reference.strip():
                raise PreparationError(f"Invalid Parent in {loaded.source_id}:{loaded.relative_path}")
            if parent_reference.casefold() == "super":
                if loaded.source_id == self.base_source_id:
                    raise PreparationError(f"Parent 'super' has no lower-priority base source for {loaded.relative_path}")
                parent = self._find(self.base_source_id, loaded.relative_path, fallback=False)
            else:
                parent = self._find(loaded.source_id, parent_reference, fallback=True)
            if parent is None:
                raise PreparationError(
                    f"Missing Parent {parent_reference!r} for {loaded.source_id}:{loaded.relative_path}"
                )
            effective = self._merge(self._resolve_loaded(parent, (*stack, key)), raw)
        self._cache[key] = copy.deepcopy(effective)
        return effective


def _pointer_value(document: dict[str, Any], pointer: str) -> Any:
    if not isinstance(pointer, str) or not pointer.startswith("/"):
        raise PreparationError(f"Patch pointer must begin with '/': {pointer!r}")
    # Accept the documented compact form Value[/RandomAttachmentSets] as well as
    # an ordinary JSON pointer.
    normalized = re.sub(r"\[/?([^\]]+)\]", r"/\1", pointer)
    current: Any = document
    for token in normalized.split("/")[1:]:
        token = token.replace("~1", "/").replace("~0", "~")
        if isinstance(current, list):
            try:
                current = current[int(token)]
            except (ValueError, IndexError) as exc:
                raise PreparationError(f"Patch pointer does not select an array item: {pointer!r}") from exc
        elif isinstance(current, dict) and token in current:
            current = current[token]
        else:
            raise PreparationError(f"Patch pointer does not exist: {pointer!r}")
    return current


def _apply_attachment_sets_patch(
    model: dict[str, Any], entry: dict[str, Any], sources: dict[str, ModelSource]
) -> None:
    patch_spec = entry.get("attachmentSetsPatch")
    if patch_spec is None:
        return
    if not isinstance(patch_spec, dict):
        raise PreparationError("attachmentSetsPatch must be an object")
    source_id = patch_spec.get("source")
    patch_path = patch_spec.get("path")
    pointer = patch_spec.get("pointer")
    if not all(isinstance(value, str) and value for value in (source_id, patch_path, pointer)):
        raise PreparationError("attachmentSetsPatch requires nonempty source, path, and pointer strings")
    source = sources.get(source_id)
    if source is None:
        raise PreparationError(f"attachmentSetsPatch names unknown source {source_id!r}")
    value = _pointer_value(source.read_relative(patch_path), pointer)
    if not isinstance(value, dict):
        raise PreparationError("attachmentSetsPatch pointer must select a RandomAttachmentSets map")
    model["RandomAttachmentSets"] = copy.deepcopy(value)


def _prepare_static_attachments(model: dict[str, Any], entry: dict[str, Any]) -> None:
    defaults = model.get("DefaultAttachments")
    if defaults is None or defaults == []:
        return
    if not isinstance(defaults, list):
        raise PreparationError("DefaultAttachments must be an array when present")
    visible = [attachment for attachment in defaults if attachment != {}]
    if not visible:
        return
    for attachment in visible:
        if not isinstance(attachment, dict):
            raise PreparationError("DefaultAttachments entries must be objects")
        if not isinstance(attachment.get("Model"), str) or not attachment["Model"]:
            raise PreparationError("Visible DefaultAttachments entries require Model")
        if not isinstance(attachment.get("Texture"), str) or not attachment["Texture"]:
            raise PreparationError("Visible DefaultAttachments entries require Texture")
    attachment_sets = model.get("RandomAttachmentSets")
    if attachment_sets is None:
        attachment_sets = {}
        model["RandomAttachmentSets"] = attachment_sets
    if not isinstance(attachment_sets, dict):
        raise PreparationError("RandomAttachmentSets must be an object when present")
    fixed = entry.setdefault("renderAttachmentDefaults", {})
    if not isinstance(fixed, dict):
        raise PreparationError("renderAttachmentDefaults must map set names to option names")
    original_sets = list(attachment_sets)
    for index, attachment in enumerate(visible):
        set_id = f"__IconStatic{index}"
        if set_id in attachment_sets or set_id in fixed:
            raise PreparationError(f"Reserved static attachment set collision: {set_id}")
        attachment_sets[set_id] = {"Default": copy.deepcopy(attachment)}
        fixed[set_id] = "Default"
    kept = entry.get("keepAttachmentSets")
    if kept is None:
        entry["keepAttachmentSets"] = original_sets
    elif not isinstance(kept, list):
        raise PreparationError("keepAttachmentSets must be an array when present")



def _expanded_source(source: dict[str, Any], manifest_dir: Path, cache_dir: Path) -> dict[str, Any]:
    output = copy.deepcopy(source)
    for key in ("commonRoot", "commonRoots"):
        value = output.get(key)
        if isinstance(value, str):
            output[key] = _absolute_source_path(value, manifest_dir)
        elif isinstance(value, list):
            if not all(isinstance(item, str) for item in value):
                raise PreparationError(f"{key} must contain only strings")
            output[key] = [_absolute_source_path(item, manifest_dir) for item in value]
        elif value is not None:
            raise PreparationError(f"{key} must be a string or array of strings")
    output["modelsRoot"] = str(cache_dir.resolve())
    return output


def _safe_name(value: str) -> str:
    safe = re.sub(r"[^A-Za-z0-9._-]+", "_", value).strip("._")
    return safe or "entry"


def prepare(manifest_path: Path, output_dir: Path) -> Path:
    manifest_path = manifest_path.resolve()
    manifest = _read_json_file(manifest_path)
    raw_sources = manifest.get("sources")
    raw_entries = manifest.get("entries")
    if not isinstance(raw_sources, dict) or not isinstance(raw_entries, list):
        raise PreparationError("Batch manifest requires sources object and entries array")

    sources: dict[str, ModelSource] = {}
    source_specs: dict[str, dict[str, Any]] = {}
    for source_id, source_spec in raw_sources.items():
        if not isinstance(source_id, str) or not isinstance(source_spec, dict):
            raise PreparationError("sources must map string ids to objects")
        models_root = source_spec.get("modelsRoot")
        if not isinstance(models_root, str) or not models_root:
            raise PreparationError(f"Source {source_id!r} requires a modelsRoot")
        sources[source_id] = ModelSource(source_id, _absolute_source_path(models_root, manifest_path.parent))
        source_specs[source_id] = source_spec
    if "baseGame" not in sources:
        raise PreparationError("Batch manifest requires a baseGame source for parent fallback")

    resolver = EffectiveModels(sources)
    prepared_manifest = copy.deepcopy(manifest)
    prepared_manifest["sources"] = {}
    prepared_entries: list[dict[str, Any]] = []
    output_dir.mkdir(parents=True, exist_ok=True)

    for index, raw_entry in enumerate(raw_entries):
        if not isinstance(raw_entry, dict):
            raise PreparationError(f"Entry {index} must be an object")
        entry = copy.deepcopy(raw_entry)
        source_id = entry.get("source")
        model_reference = entry.get("model")
        if not isinstance(source_id, str) or source_id not in sources:
            raise PreparationError(f"Entry {index} names an unknown source")
        if not isinstance(model_reference, str) or not model_reference:
            raise PreparationError(f"Entry {index} requires a model string")
        model = resolver.resolve(source_id, model_reference)
        _apply_attachment_sets_patch(model, entry, sources)
        _prepare_static_attachments(model, entry)
        entry.pop("attachmentSetsPatch", None)

        entry_id = entry.get("id")
        label = str(entry_id) if isinstance(entry_id, str) and entry_id else f"entry_{index}"
        generated_source_id = f"effective_{index:03d}_{_safe_name(label)}"
        cache_dir = output_dir / "Models" / generated_source_id
        output_path = cache_dir / Path(_file_key(model_reference))
        output_path.parent.mkdir(parents=True, exist_ok=True)
        output_path.write_text(json.dumps(model, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

        prepared_manifest["sources"][generated_source_id] = _expanded_source(
            source_specs[source_id], manifest_path.parent, cache_dir
        )
        entry["source"] = generated_source_id
        prepared_entries.append(entry)

    prepared_manifest["entries"] = prepared_entries
    result_path = output_dir / "effective.batch.json"
    result_path.write_text(json.dumps(prepared_manifest, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    return result_path


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--batch-manifest", required=True, type=Path)
    parser.add_argument("--output-dir", required=True, type=Path)
    args = parser.parse_args(argv)
    try:
        result = prepare(args.batch_manifest, args.output_dir)
    except PreparationError as exc:
        print(f"prepare_models.py: {exc}", file=sys.stderr)
        return 2
    print(result)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
