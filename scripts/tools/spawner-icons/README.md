# Companion portrait generation

The dynamic icon assets cover supported roles by appearance. Every asset has an explicit default. Variant rules match only the selected major attachment slots, so eyes, markings, and other omitted details can differ from the live animal.

`animal_husbandry_soul_lantern.batch.json` pins the installed Aures and Celly archive versions. The file name is retained for existing tooling; its output is shared by captured items and both command panels.

## Refreshing

From the Animal Husbandry repository, first resolve parented models and the calf/frost-dragon skin patches into temporary renderer inputs:

```powershell
python scripts/tools/spawner-icons/prepare_models.py --batch-manifest scripts/tools/spawner-icons/animal_husbandry_soul_lantern.batch.json --output-dir .tmp/dynamic-icons/prepared
```

Then generate candidates with the sibling Tamework tool. Use absolute paths for `--asset-root`, `--dynamic-icons-output-dir`, `--manifest-out`, and `--renderer-jobs-out`. Direct the asset root at a staging folder so existing mappings remain valid until rendering succeeds:

```text
python ../alecstamework/scripts/tools/generate_spawner_icon_overrides.py
  --batch-manifest .tmp/dynamic-icons/prepared/effective.batch.json
  --asset-root <absolute staging folder>
  --dynamic-icons-output-dir <absolute staging folder>/Server/Tamework/DynamicIcons
  --dynamic-icon-id-prefix AH_DynamicIcon
  --manifest-out <absolute work folder>/manifest.json
  --renderer-jobs-out <absolute work folder>/jobs.json
```

Load `jobs.json` in Blockbench using **Run Tamework Dynamic Icon Batch (From Jobs JSON)**. Use the current Tamework renderer plugin and Hytale Models plugin. After inspecting samples and checking the completed batch for failures, copy the generated PNGs and dynamic configs into this pack together. Default-only configs are maintained directly and are not replaced by the variant batch.

## Keeping combinations manageable

- Start with coat/body color. Add one major feature such as hair, horns, wings, shell, or body pattern where it improves recognition.
- `keepAttachmentSets` controls which slots multiply the variants. Keep a complete useful palette for those slots.
- `renderAttachmentDefaults` retains representative omitted anatomy/details without adding matching predicates or multiplying images. Review the actual options when updating a source archive; the manifest records explicit choices.
- Aures horses use coat and hair: 720 combinations instead of 2,246,400 across every slot. Rabbits use coat only: 29 instead of 42,021. Skeleton horses also vary armor because it changes much of the silhouette.
- The per-entry ceiling is 1,000. Check the total count and inspect first/last variants for each appearance before copying outputs.
- A base-game fallback entry follows more specific skin rules where one existed. Every generated asset carries its own `iconDefault` so unmatched appearances still have a portrait.

Prepared model JSON is render-only data. The helper resolves whole-field ModelAsset inheritance, keeps static attachments as fixed rendering choices, and reads the exact attachment maps from the two declared upstream patches. It does not modify NPCs, apply patches to the game, or copy these temporary descriptors into the asset pack.
