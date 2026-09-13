#!/usr/bin/env python3
"""Prepare model portraits for the client's 64x64 item-icon atlas (requires Pillow)."""

import argparse
import json
import os
from io import BytesIO
from pathlib import Path
from zipfile import ZipFile

from PIL import Image


MODEL_PREFIX = "Icons/ModelsGenerated/"
ITEM_PREFIX = "Icons/ItemsGenerated/AnimalHusbandry/Portraits/BaseGame/Defaults/"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--asset-root", type=Path, default=Path(__file__).resolve().parents[3])
    parser.add_argument("--assets-zip", type=Path, default=Path(os.path.expandvars(
        "${APPDATA}/Hytale/install/release/package/game/latest/Assets.zip")))
    args = parser.parse_args()
    configs = sorted((args.asset_root / "Server/Tamework/DynamicIcons").glob("*.json"))
    manifest = args.asset_root / "scripts/tools/spawner-icons/animal_husbandry_soul_lantern.batch.json"
    replacements = {}
    for path in configs:
        icon = json.loads(path.read_text(encoding="utf-8-sig")).get("IconDefault", "")
        for prefix in (MODEL_PREFIX, ITEM_PREFIX):
            if icon.startswith(prefix):
                name = icon.removeprefix(prefix)
                replacements[MODEL_PREFIX + name] = ITEM_PREFIX + name

    with ZipFile(args.assets_zip) as assets:
        for source, target in sorted(replacements.items()):
            with Image.open(BytesIO(assets.read("Common/" + source))) as image:
                # Resample the full image, preserving transparent margins and composition.
                icon = image.convert("RGBA").resize((64, 64), Image.Resampling.LANCZOS)
                destination = args.asset_root / "Common" / target
                destination.parent.mkdir(parents=True, exist_ok=True)
                icon.save(destination)

    # Publish mappings after every image has been prepared; preserve file formatting.
    for path in [*configs, manifest]:
        original = path.read_bytes()
        updated = original
        for source, target in replacements.items():
            updated = updated.replace(source.encode(), target.encode())
        if updated != original:
            path.write_bytes(updated)
    print(f"Prepared {len(replacements)} default item portraits at 64x64; updated configs and batch.")


if __name__ == "__main__":
    main()
