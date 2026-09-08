---
title: "Traits and Stats Guide"
order: 6
published: true
draft: false
---
# Traits and Stats Guide

Parent: [Gameplay Guides Index](/mod/alecs-animal-husbandry/gameplay-guides-index) | [Home](/mod/alecs-animal-husbandry/)

Most traits are multipliers that shape companion performance.
A trait value above/below 1.0 changes outcomes depending on the effect type.

## Flat disposition (development build)

Disposition is now a flat mood adjustment in the coordinated development build,
which requires the matching Tamework update. It does not scale food, petting,
hand-feeding, damage or environmental effects. Historical genetic scores remain
unchanged: 0.7 maps to -10 happiness, 1.0 to zero, and 1.3 to +10. Natural scores
0.9-1.1 map to about -3.33 through +3.33. The tables below retain genetic-score
ranges rather than happiness points.

Existing animals, including captured animals, retain their traits and purchased
talent IDs. Conversion happens when the runtime reads the score; no reroll or save
rewrite is needed. Mood converges toward the new target normally. Existing timed
effects keep their recorded amount until refresh or expiry, with no timer reset.

Happiness talents now add flat mood bonuses: Controlled Temper/Bright Eyes +2.3,
Steady Nerves/Caretaker Bond +3.7, Gentle Disposition/Calm Temper +2.7, and
Barn Favorite/Trusted Companion +4.3. Purchased bonuses add together, and their
other effects remain unchanged. These are tuning values for testing, not a claim
that the development build has been deployed to public servers.

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
| Disposition | Flat mood adjustment (development build) | 0.9-1.1 | 0.7-1.3 | 1 | Higher is better |
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
| Disposition | Flat mood adjustment (development build) | 0.9-1.1 | 0.7-1.3 | 1 | Higher is better |
| Fertility | Breeding readiness/throughput speed | 0.85-1.2 | 0.5-2 | 1 | Higher is better |
| Health | Maximum health pool | 0.95-1.25 | 0.85-1.75 | 1 | Higher is better |
| Size | Visual/body scale | 0.8-1.2 | 0.85-1.35 | 1 | Situational |
| Swiftness | Movement speed | 0.85-1.3 | 0.6-2.1 | 1 | Higher is better |
| Toughness | Damage received | 0.85-1.1 | 0.55-1.5 | 1 | Lower is better |
| Strength | Damage dealt | 0.95-1.2 | 0.75-1.5 | 1 | Higher is better |

## Base Stat Note
This mod defines **trait multipliers**, XP leveling, and passive talent behavior.
Base species HP/damage/speed values come from the role assets they inherit from.
Use this page to understand the modifier ranges your lines can roll and inherit; leveling and talents add modest long-term bonuses on top of those inherited base stats.

## Breeding Strategy
1. Keep your best breeder pairs separated and protected.
2. Replace average breeders with offspring that improve priority traits.
3. Avoid blindly maximizing every trait; pick role-specific goals.
4. Track line outcomes over several generations before pruning.

> [Screenshot Placeholder: Companion panel trait list with values]
> [Screenshot Placeholder: Side-by-side comparison of two breeding candidates]




