---
title: "Config Reference (Configuration)"
order: 2
published: true
draft: false
---
# Config Reference (Configuration)

Parent: [Configuration Index](/mod/alecs-animal-husbandry/configuration-index) | [Home](/mod/alecs-animal-husbandry/animal-husbandry-wiki)

This page is optional for players who want to tune behavior.
If you only want to play, use the main guides instead.

For command-level guidance first, see:
- [TW Settings](/mod/alecs-animal-husbandry/tw-settings) for curated global world settings.
- [TW Config](/mod/alecs-animal-husbandry/tw-config) for advanced family-by-family editor usage.

## Full Tamework Config Docs
For complete field-by-field documentation across all config families, use:
- [Alec's Tamework Config Reference Index](https://wiki.hytalemodding.dev/mod/alecs-tamework/config-reference-index)

## Active Animal Husbandry Config Files
These are the current (non-deprecated) `AH*` config assets in this repo.

### Core Family Files
| Family | Active File(s) |
|---|---|
| Global | `Server/Tamework/Global/AHGlobal.json` |
| Companion | `Server/Tamework/Companion/AHCompMain.json`<br>`Server/Tamework/Companion/AHCompNeutral.json` |
| Interactions | `Server/Tamework/Interactions/AHIntLivestock.json`<br>`Server/Tamework/Interactions/AHIntNeutral.json`<br>`Server/Tamework/Interactions/AHIntBeast.json`<br>`Server/Tamework/Interactions/AhIntCritter.json` |
| Command Items | `Server/Tamework/Items/Commands/AHCommLivestock.json`<br>`Server/Tamework/Items/Commands/AHCommBeast.json` |
| Needs | `Server/Tamework/Needs/AHNeedsMain.json`<br>`Server/Tamework/Needs/AHNeedsBeast.json` |
| Happiness | `Server/Tamework/Happiness/AHHappMain.json`<br>`Server/Tamework/Happiness/AHHappNeutral.json`<br>`Server/Tamework/Happiness/AHHappBeast.json` |
| Breeding | `Server/Tamework/Breeding/AHBreedLivestock.json`<br>`Server/Tamework/Breeding/AHBreedNeutral.json`<br>`Server/Tamework/Breeding/AHBreedBeast.json` |
| Traits | `Server/Tamework/Traits/AHTraitLivestock.json`<br>`Server/Tamework/Traits/AHTraitNeutral.json`<br>`Server/Tamework/Traits/AHTraitBeast.json` |

### Cohort Mapping (including Beast)
| Cohort | Interaction | Companion | Needs | Happiness | Breeding | Traits | Command |
|---|---|---|---|---|---|---|---|
| Livestock | `AHIntLivestock` | `AHCompMain` | `AHNeedsMain` | `AHHappMain` | `AHBreedLivestock` | `AHTraitLivestock` | `AHCommLivestock` |
| Neutral | `AHIntNeutral` | `AHCompNeutral` | `AHNeedsMain` | `AHHappNeutral` | `AHBreedNeutral` | `AHTraitNeutral` | n/a |
| Beast | `AHIntBeast` | `AHCompMain` | `AHNeedsBeast` | `AHHappBeast` | `AHBreedBeast` | `AHTraitBeast` | `AHCommBeast` |
| Critter | `AhIntCritter` | n/a | `AHNeedsMain` | `AHHappMain` | `AHBreedNeutral` | `AHTraitNeutral` | n/a |

## Deprecated Naming Note
Older `Tw*Config_AnimalHusbandry_*` asset ids/names are deprecated and were replaced by the `AH*` config file set above.

## Safety Tips Before Editing Configs
1. Make a backup of the file.
2. Change one section at a time.
3. Restart and verify startup logs.
4. Test one species before broad rollout.

## Fast Tuning Targets
- Too much breeding: raise BaseCooldownMinutes.
- Too little breeding: lower cooldown and improve care quality.
- Growth too slow/fast: tune TimeToFullGrownMinutes per role.
- Overcrowding: lower MaxNearbySameType on sensitive species.


