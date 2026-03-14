# Traits and Stats Guide

Traits are multipliers that shape companion performance.
A trait value above/below 1.0 changes outcomes depending on the effect type.

## How Trait Rolling Works
Livestock selection defaults:
- Max traits per NPC: **4**
- Duplicate traits: **False**

Beast selection defaults:
- Max traits per NPC: **4**
- Duplicate traits: **False**

## Inheritance Defaults
Livestock:
- Inheritance chance: **0.75**
- Mutation chance: **0.1**

Beasts:
- Inheritance chance: **0.75**
- Mutation chance: **0.1**

## Livestock Trait Table
| Trait | Effect | Natural Range | Bred Range | Default | Practical Direction |
|---|---|---|---|---:|---|
| Disposition | How strongly positive actions increase happiness | 0.9-1.1 | 0.7-1.3 | 1 | Higher is better |
| Fertility | Breeding readiness/throughput speed | 0.85-1.2 | 0.5-2 | 1 | Higher is better |
| Health | Maximum health pool | 0.95-1.25 | 0.85-1.75 | 1 | Higher is better |
| Size | Visual/body scale | 0.8-1.2 | 0.85-1.35 | 1 | Situational |
| Swiftness | Movement speed | 0.85-1.25 | 0.6-2 | 1 | Higher is better |
| Toughness | Damage received | 0.9-1.1 | 0.6-1.4 | 1 | Lower is better |
| Strength | Damage dealt | 0.95-1.1 | 0.85-1.3 | 1 | Higher is better |
| Bounty | Chance of bonus harvest drops | 1-1.25 | 1-2 | 1 | Higher is better |


## Beast Trait Table
| Trait | Effect | Natural Range | Bred Range | Default | Practical Direction |
|---|---|---|---|---:|---|
| Disposition | How strongly positive actions increase happiness | 0.9-1.1 | 0.7-1.3 | 1 | Higher is better |
| Fertility | Breeding readiness/throughput speed | 0.85-1.2 | 0.5-2 | 1 | Higher is better |
| Health | Maximum health pool | 0.95-1.25 | 0.85-1.75 | 1 | Higher is better |
| Size | Visual/body scale | 0.8-1.2 | 0.85-1.35 | 1 | Situational |
| Swiftness | Movement speed | 0.85-1.3 | 0.6-2.1 | 1 | Higher is better |
| Toughness | Damage received | 0.85-1.1 | 0.55-1.5 | 1 | Lower is better |
| Strength | Damage dealt | 0.95-1.2 | 0.75-1.5 | 1 | Higher is better |


## Per-Mob Trait Profile Assignment
Every species is assigned to one profile for trait rolling.

| Mob | Trait Profile | Notes |
|---|---|---|
| Bison | Livestock Profile | Includes production trait Bounty |
| Boar | Livestock Profile | Includes production trait Bounty |
| Camel | Livestock Profile | Includes production trait Bounty |
| Chicken | Livestock Profile | Includes production trait Bounty |
| Chicken Desert | Livestock Profile | Includes production trait Bounty |
| Cow | Livestock Profile | Includes production trait Bounty |
| Goat | Livestock Profile | Includes production trait Bounty |
| Horse | Livestock Profile | Includes production trait Bounty |
| Mouflon | Livestock Profile | Includes production trait Bounty |
| Pig | Livestock Profile | Includes production trait Bounty |
| Pig Wild | Livestock Profile | Includes production trait Bounty |
| Ram | Livestock Profile | Includes production trait Bounty |
| Sheep | Livestock Profile | Includes production trait Bounty |
| Skrill | Livestock Profile | Includes production trait Bounty |
| Turkey | Livestock Profile | Includes production trait Bounty |
| Warthog | Livestock Profile | Includes production trait Bounty |
| Bear Grizzly | Beast Profile | Combat-focused profile (no Bounty) |
| Bear Polar | Beast Profile | Combat-focused profile (no Bounty) |
| Crocodile | Beast Profile | Combat-focused profile (no Bounty) |
| Emberwulf | Beast Profile | Combat-focused profile (no Bounty) |
| Fen Stalker | Beast Profile | Combat-focused profile (no Bounty) |
| Fox | Beast Profile | Combat-focused profile (no Bounty) |
| Hyena | Beast Profile | Combat-focused profile (no Bounty) |
| Larva Silk | Beast Profile | Combat-focused profile (no Bounty) |
| Leopard Snow | Beast Profile | Combat-focused profile (no Bounty) |
| Molerat | Beast Profile | Combat-focused profile (no Bounty) |
| Raptor Cave | Beast Profile | Combat-focused profile (no Bounty) |
| Rat | Beast Profile | Combat-focused profile (no Bounty) |
| Rex Cave | Beast Profile | Combat-focused profile (no Bounty) |
| Scorpion | Beast Profile | Combat-focused profile (no Bounty) |
| Slug Magma | Beast Profile | Combat-focused profile (no Bounty) |
| Snake Cobra | Beast Profile | Combat-focused profile (no Bounty) |
| Snake Marsh | Beast Profile | Combat-focused profile (no Bounty) |
| Snake Rattle | Beast Profile | Combat-focused profile (no Bounty) |
| Snapdragon | Beast Profile | Combat-focused profile (no Bounty) |
| Spider | Beast Profile | Combat-focused profile (no Bounty) |
| Spider Cave | Beast Profile | Combat-focused profile (no Bounty) |
| Tiger Sabertooth | Beast Profile | Combat-focused profile (no Bounty) |
| Toad Rhino | Beast Profile | Combat-focused profile (no Bounty) |
| Toad Rhino Magma | Beast Profile | Combat-focused profile (no Bounty) |
| Wolf Black | Beast Profile | Combat-focused profile (no Bounty) |
| Wolf White | Beast Profile | Combat-focused profile (no Bounty) |
| Yeti | Beast Profile | Combat-focused profile (no Bounty) |

## Base Stat Note
This mod primarily defines **trait multipliers** and progression behavior.
Base species HP/damage/speed values come from the role assets they inherit from.
Use this page to understand the modifier ranges your lines can roll and inherit.

## Reading Traits in Practice
- DamageTakenMultiplier: lower is tankier.
- DamageDealtMultiplier: higher hits harder.
- MoveSpeedMultiplier: higher improves chase/reposition.
- FertilityMultiplier: higher helps breeding throughput.
- HarvestDoubleDropChanceMultiplier: higher improves production value.

## Breeding Strategy
1. Keep your best breeder pairs separated and protected.
2. Replace average breeders with offspring that improve priority traits.
3. Avoid blindly maximizing every trait; pick role-specific goals.
4. Track line outcomes over several generations before pruning.

> [Screenshot Placeholder: Companion panel trait list with values]
> [Screenshot Placeholder: Side-by-side comparison of two breeding candidates]


