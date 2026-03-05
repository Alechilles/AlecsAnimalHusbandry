# Alec's Animal Husbandry!

A player-facing livestock mod that brings Alec's Tamework taming, breeding, and companion systems to vanilla Hytale livestock.

## Status
- Scaffold started.
- Core integration kickoff complete:
  - Base `AnimalHusbandry` Tamework configs are enabled.
  - Pilot scope is currently limited to the tamed Cow family roles (`Tamed_Cow`, `Tamed_Cow_Calf`).
  - `Template_Livestock` now includes additive `TameworkInteractPrompt` + `TameworkInteract` hook points while vanilla interaction branches remain for fallback/parity migration.

## Version 1 Scope
V1 targets the full vanilla Livestock template set:
- Bison + Bison_Calf
- Chicken + Chicken_Chick
- Chicken_Desert + Chicken_Desert_Chick
- Cow + Cow_Calf
- Pig family (`Pig*` roles)
- Sheep + Sheep_Lamb
- Mouflon + Mouflon_Lamb
- Turkey + Turkey_Chick
- Goat + Goat_Kid
- Rabbit
- Camel + Camel_Calf
- Deer family (`Deer_Stag`, `Deer_Doe`)

## Requirements
- Alec's Tamework! `2.2.x`

## Initial Layout
- `Server/Tamework/Interactions/AnimalHusbandry/`
- `Server/Tamework/Happiness/AnimalHusbandry/`
- `Server/Tamework/Breeding/AnimalHusbandry/`
- `Server/Tamework/Traits/AnimalHusbandry/`
- `Server/Languages/en-US/`

## Next Steps
1. Validate Cow pilot parity for tame/feed/harvest/mount plus progression persistence.
2. Migrate overlapping vanilla interaction branches incrementally (feed -> harvest -> mount) once parity is confirmed.
3. Expand base `AnimalHusbandry` role coverage to the full V1 livestock set.
4. Add species-specific child config assets (`..._AnimalHusbandry_<MobName>`) only when per-mob overrides are needed.
