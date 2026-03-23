---
title: "Config Reference (Advanced)"
order: 2
published: true
draft: false
---
# Config Reference (Advanced)

Parent: [Animal Husbandry Wiki](/mod/alecs-animal-husbandry/readme)

This page is optional for players who want to tune behavior.
If you only want to play, use the main guides instead.

## Main Tamework Config Areas Used by Animal Husbandry
- Server/Tamework/Breeding
- Server/Tamework/Traits
- Server/Tamework/Needs
- Server/Tamework/Happiness
- Server/Tamework/Companion

## Neutral Cohort Config Set
The neutral wildlife batch uses dedicated files so it can be tuned separately from core livestock:
- `TwInteractionConfig_AnimalHusbandry_Neutral`
- `TwCompanionConfig_AnimalHusbandry_Neutral`
- `TwNeedsConfig_AnimalHusbandry_Neutral`
- `TwHappinessConfig_AnimalHusbandry_Neutral`
- `TwTraitConfig_AnimalHusbandry_Neutral`
- `TwBreedingConfig_AnimalHusbandry_Neutral`

## Critter Cohort Config Set
The passive critter/cactee batch uses a dedicated interaction config and critter-focused templates:
- `TwInteractionConfig_AnimalHusbandry_Critter`
- `Template_Animal_Critter_AH`
- `Template_Critter_Tamed`

## Important Breeding Key Formats
Preferred keys:
- Cooldowns.BaseCooldownMinutes
- OffspringLifecycle.TimeToFullGrownMinutes
- OffspringLifecycle.BabyStartScale
- OffspringLifecycle.AdolescentStartScale
- OffspringLifecycle.AdultStartScale
- OffspringLifecycle.AdolescentSwitchScale
- OffspringLifecycle.AdultSwitchScale

Still supported for compatibility:
- BaseCooldownSeconds
- DefaultTimeToFullGrownSeconds
- DefaultBabyStartScale
- DefaultAdolescentStartScale
- DefaultAdultStartScale
- DefaultAdolescentSwitchScale
- DefaultAdultSwitchScale
- TimeToFullGrownSeconds

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


