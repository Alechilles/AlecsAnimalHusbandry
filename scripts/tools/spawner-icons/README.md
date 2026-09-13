# Companion portrait generation

The dynamic icon assets cover supported roles by appearance. Every asset has an explicit default. Variant rules match only the selected major attachment slots, so eyes, markings, and other omitted details can differ from the live animal.

`animal_husbandry_soul_lantern.batch.json` pins the installed Aures and Celly archive versions. The file name is retained for existing tooling; its output is shared by captured items and both command panels.

## Refreshing

Prepare the base-game defaults before refreshing variant portraits (requires Pillow):

```powershell
python scripts/tools/spawner-icons/prepare_default_icons.py
```

This resamples the 46 model portraits to 64x64 item icons while preserving the original artwork and transparent margins. It updates the dynamic configs and batch defaults together. Use `--assets-zip` to select a different game archive. Do not point item portraits directly at 128x128 `Icons/ModelsGenerated` images: they display as truncated horizontal strips in the item-icon renderer.

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

## Current selection budget

The September 11, 2026 inputs generate 2,410 images across 59 passes. The complete config set covers 219 supported role IDs plus existing optional aliases, in 115 appearance groups. The table includes vanilla fallback passes; all other supported appearances use a default portrait.

| Source | Appearance | Mapped slots | Images |
| --- | --- | --- | ---: |
| Celly Baby Animals | Cow_Calf | BaseColor | 7 |
| Aures Livestock | Camel | BaseColor, Shell | 42 |
| Aures Livestock | Chicken | BaseColor | 14 |
| Aures Livestock | Chicken_Desert | Desert_Base | 18 |
| Aures Livestock | Cow | BaseColor | 8 |
| Aures Livestock | Goat | BaseColor, Horns | 70 |
| Aures Livestock | Mouflon | BaseColor, Fur | 48 |
| Aures Livestock | Pig | BaseColor | 18 |
| Aures Livestock | Rabbit | BaseColor | 29 |
| Aures Livestock | Ram | BaseColor, Horn | 42 |
| Aures Livestock | Sheep | BaseColor | 7 |
| Aures Livestock | Skrill | Skrill_Base | 14 |
| Aures Horses | Horse | 66BaseColor, Hair | 720 |
| Aures Horses | Horse_Skeleton | Undead_Base, Undead_Armor | 232 |
| Celly Baby Animals | Fox_Cub | Base, Paws | 48 |
| Celly Baby Animals | Fox_Arctic_Cub | Base, Paws | 48 |
| Celly Baby Animals | Flamingo_Chick | Base, Wings | 9 |
| Celly Baby Animals | Tetrabird_Chick | Base, Wings | 77 |
| Celly Beast Skins | Scorpion | Head, Base | 95 |
| Celly Beast Skins | Fox | Base, Paws | 48 |
| Celly Beast Skins | Fox_Arctic | Base, Paws | 48 |
| Celly Beast Skins | Wolf_Black | BaseColor | 6 |
| Celly Beast Skins | Wolf_White | BaseColor | 6 |
| Celly Beast Skins | Bear_Grizzly | Base | 5 |
| Celly Beast Skins | Bear_Polar | Base | 6 |
| Celly Beast Skins | Hyena | Base, Darkspots | 28 |
| Celly Beast Skins | Spider | Base, Feet | 30 |
| Celly Beast Skins | Crocodile | Base, Belly | 64 |
| Celly Critter Skins | Squirrel | Base | 6 |
| Celly Critter Skins | Meerkat | Base, Stripes | 9 |
| Celly Critter Skins | Mouse | Base, Tail | 36 |
| Celly Elemental Skins | Emberwulf | Base, Cracks | 25 |
| Celly Elemental Skins | Spark_Living | Base, Fire | 10 |
| Celly Elemental Skins (AH patch) | Dragon_Frost | Base, Ice | 90 |
| Celly Avian Skins | Owl_Brown | Base, Beakfeet | 36 |
| Celly Avian Skins | Owl_Snow | Base, Beakfeet | 36 |
| Celly Avian Skins | Bat | Base, Skin | 4 |
| Celly Avian Skins | Bat_Ice | Base, Frost | 4 |
| Celly Avian Skins | Crow | Base, Beakfeet | 16 |
| Celly Avian Skins | Raven | Base, Beakfeet | 16 |
| Celly Avian Skins | Hawk | Base, Fluff | 16 |
| Celly Wildlife Skins | Lizard_Sand | Base, Stripes | 35 |
| Celly Wildlife Skins | Flamingo | Base, Wings | 9 |
| Celly Wildlife Skins | Moose_Bull | Base, Fluff | 16 |
| Celly Wildlife Skins | Moose_Cow | Base, Fluff | 16 |
| Celly Wildlife Skins | Deer_Stag | Base, Antlers | 32 |
| Celly Wildlife Skins | Deer_Doe | Base, Antlers | 32 |
| Celly Wildlife Skins | Tetrabird | Base, Wings | 77 |
| Celly Wildlife Skins | Lobster | Base | 13 |
| Celly Wildlife Skins | Crab | Base, Shell | 64 |
| Base game | Camel | Shell | 6 |
| Base game | Camel_Calf | Shell | 6 |
| Base game | Cow | Fleece | 1 |
| Base game | Horse | Hair | 2 |
| Base game | Mosshorn_Plain | Flowers | 3 |
| Base game | Pig_Wild | Fur | 1 |
| Base game | Pig_Wild_Piglet | Fur | 4 |
| Base game | Sheep | Fleece | 1 |
| Base game | Hatworm | Hat | 1 |
