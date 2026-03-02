# Alec's Animal Husbandry!

A player-facing livestock mod that brings Alec's Tamework taming, breeding, and companion systems to vanilla Hytale livestock.

## Status
- Scaffold started.
- Initial Tamework config files are present but intentionally disabled (`"Enabled": false`) until per-species tuning is complete.

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
- Alec's Tamework! `2.1.x`

## Initial Layout
- `Server/Tamework/Interactions/AnimalHusbandry/`
- `Server/Tamework/Happiness/AnimalHusbandry/`
- `Server/Tamework/Breeding/AnimalHusbandry/`
- `Server/Tamework\Traits/AnimalHusbandry/`
- `Server/Languages/en-US/`

## Next Steps
1. Implement and enable the Cow pilot interactions/config set.
2. Validate full tame/feed/breed/raise loop with persistence.
3. Generalize to the rest of the V1 livestock families.
