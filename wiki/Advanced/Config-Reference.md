---
title: "Config Reference (Configuration)"
order: 2
published: true
draft: false
---
# Config Reference (Configuration)

Parent: [Configuration Index](/mod/alecs-animal-husbandry/configuration-index) | [Home](/mod/alecs-animal-husbandry/)

This page is optional for players who want to tune behavior.
If you only want to play, use the main guides instead.

For command-level guidance first, see:
- [TW Settings](/mod/alecs-animal-husbandry/tw-settings) for curated global world settings.
- [TW Config](/mod/alecs-animal-husbandry/tw-config) for advanced family-by-family editor usage.

## Full Tamework Config Docs
For complete field-by-field documentation across all config families, use:
- [Alec's Tamework Config Reference Index](https://wiki.hytalemodding.dev/mod/alecs-tamework/config-reference-index)

## Bird flight formations

The aerial role templates expose these NPC role parameters. They are edited in
role JSON, rather than through a `Tw*Config` asset.

| Parameter | Default | Meaning |
| --- | --- | --- |
| `FlightFormation` | `None` | `None`, `Loose`, or `Chevron`. Ducks select `Chevron`; other species retain their existing flight behavior by default. |
| `FlightFormationSpacing` | `3` | Distance between formation positions in blocks; must be positive. |
| `FlightFormationTightness` | `0.6` | How strongly birds return to their positions; greater than zero and at most one. |

Set these values in the species role's `Modify` map. `Loose` produces a compact
group with gentle drift; `Chevron` produces two arms behind the flock leader.
Wild formations apply during cruising and end when the leader starts landing.
Tamed formations apply during airborne idle; individual commands keep their
existing movement. Both require a flying flock leader and the matching Tamework
build with flight formation support. Formation-enabled species have a lower
minimum airspeed, allowing followers to catch up or slow down into position.
Visual spacing and terrain behavior still need in-game tuning.

See Tamework's [Flight Formation Guide](https://wiki.hytalemodding.dev/mod/alecs-tamework/flight-formation-guide)
for integration details.

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
| Traits | `Server/Tamework/Traits/AHTraitLivestock.json`<br>`Server/Tamework/Traits/AHTraitLivestockGeneral.json`<br>`Server/Tamework/Traits/AHTraitNeutral.json`<br>`Server/Tamework/Traits/AHTraitBeast.json` |
| Leveling | `Server/Tamework/Leveling/AHLevelLivestock.json`<br>`Server/Tamework/Leveling/AHLevelLivestockGeneral.json`<br>`Server/Tamework/Leveling/AHLevelNeutral.json`<br>`Server/Tamework/Leveling/AHLevelCritter.json`<br>`Server/Tamework/Leveling/AHLevelBeast.json` |
| Talents | `Server/Tamework/Talents/AHTalentLivestock.json`<br>`Server/Tamework/Talents/AHTalentLivestockGeneral.json`<br>`Server/Tamework/Talents/AHTalentNeutral.json`<br>`Server/Tamework/Talents/AHTalentCritter.json`<br>`Server/Tamework/Talents/AHTalentBeast.json` |

### Group Mapping (including Beast)
| Group | Interaction | Companion | Needs | Happiness | Breeding | Traits | Leveling | Talents | Command |
|---|---|---|---|---|---|---|---|---|---|
| Livestock (harvest-capable) | `AHIntLivestock` | `AHCompMain` | `AHNeedsMain` | `AHHappMain` | `AHBreedLivestock` | `AHTraitLivestock` | `AHLevelLivestock` | `AHTalentLivestock` | `AHCommLivestock` |
| Livestock (general) | `AHIntLivestock` | `AHCompMain` | `AHNeedsMain` | `AHHappMain` | `AHBreedLivestock` | `AHTraitLivestockGeneral` | `AHLevelLivestockGeneral` | `AHTalentLivestockGeneral` | `AHCommLivestock` |
| Neutral | `AHIntNeutral` | `AHCompNeutral` | `AHNeedsMain` | `AHHappNeutral` | `AHBreedNeutral` | `AHTraitNeutral` | `AHLevelNeutral` | `AHTalentNeutral` | `AHCommLivestock` |
| Beast | `AHIntBeast` | `AHCompMain` | `AHNeedsBeast` | `AHHappBeast` | `AHBreedBeast` | `AHTraitBeast` | `AHLevelBeast` | `AHTalentBeast` | `AHCommBeast` |
| Critter | `AhIntCritter` | `AHCompNeutral` | `AHNeedsMain` | `AHHappMain` | `AHBreedNeutral` | `AHTraitNeutral` | `AHLevelCritter` | `AHTalentCritter` | `AHCommLivestock` |

Harvest-capable livestock configs cover chicken, cow, mosshorn, sheep, and skrill families. General livestock configs cover livestock families without harvest interactions, so they do not roll Bounty traits or spend points on harvest-only talents.

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
- Leveling too slow/fast: tune BaseXp, GrowthFactor, and each XpSources section.
- Talents too strong/weak: tune TalentPoints and the multipliers in the active AHTalent config.
- Overcrowding: lower MaxNearbySameType on sensitive species.
