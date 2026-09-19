---
title: "Breeding and Growth Guide"
order: 5
published: true
draft: false
published: true
draft: false
---
# Breeding and Growth Guide

Parent: [Gameplay Guides Index](/mod/alecs-animal-husbandry/gameplay-guides-index) | [Home](/mod/alecs-animal-husbandry/)

This page is your practical timing reference for line planning.

## How Breeding Starts
Breeding is **passive by default**. 

When two compatible animals (adult male and female of same species) meet breeding requirements, they will periodically produce offspring on their own. 

You can also crouch and feed [favorite food](/mod/alecs-animal-husbandry/animal-taming-reference) to breed manually. 

This is useful when:
- You want to breed a specific pair immediately.
- You have disabled passive breeding.

## How Breeding Is Gated
Your breeding pair must pass all of these checks:
- Tamed
- Adult
- One male, one female
- Not in combat
- Not sleeping
- Happiness above 80%
- Not on cooldown
- Not overcrowded

Manual breeding still respects these gates.
If crouch-feeding does not start breeding, the animal is usually blocked by one of the checks above.

Flying companions use the same breeding gates. They land before pairing and return to Flight mode after breeding if it remains selected. Keep clear ground near the pair so both companions can complete the landing and approach.

## Litter Size, Capacity, and Pending Births

Fertility intentionally rolls a litter from **zero through four offspring**. Zero is a normal biological result, not necessarily an error or a duplicated callback.

Manual and passive breeding use the same birth-job and capacity rules:

- `MaxNearbySameType` is a hard execution-time ceiling.
- Live nearby animals and children reserved by other pending litters both consume headroom.
- If a planned litter is larger than the remaining headroom, only the admitted number can spawn.
- One parent can belong to only one active birth job, and a job can claim its spawn callback only once.
- Capturing either parent into a Tamework-managed coop before birth cancels the pending job; the delayed callback also checks that both parents are still valid before spawning.

Example: with a maximum of eight matching animals, seven already nearby, and a rolled litter of four, only one child is admitted. Two pairs starting near the limit share the same reservations, so their combined result cannot exceed the cap.

## Adult Aging

Use these assets with the accompanying Tamework aging build. After juvenile
growth, animals progress through Adult, Prime, and Senior. The command panel
shows their stage and countdown. Wild-caught adults begin before Prime.

The default Animal Progression setting in `/tw settings` freezes animals at
Prime. Administrators can disable adult aging, enable the full lifecycle, and
optionally allow old-age death. Prime gives full domestic slaughter yield;
other adult stages give 50% of the otherwise calculated yield. Disabling aging
restores full adult yield. Natural old-age death uses ordinary drops without
the slaughter bonus.

These initial timings match Rune Husbandry for shared species. All durations
are eligible real time, independent of the world's day length. Senior lasts
as long as Prime; both durations matter only with the full lifecycle enabled.

| Animals | Adult to Prime | Prime duration | Senior duration |
| --- | ---: | ---: | ---: |
| Chicken, Desert Chicken, Bunny, Rabbit | 30 min | 6 h | 6 h |
| Pig, Turkey, Skrill | 45 min | 12 h | 12 h |
| Wild Pig | 60 min | 12 h | 12 h |
| Goat | 45 min | 18 h | 18 h |
| Sheep, Mouflon, Ram, Boar, Warthog | 60 min | 18 h | 18 h |
| Cow | 60 min | 24 h | 24 h |
| Bison, Camel, Horse | 75 min | 30 h | 30 h |
| Mosshorn, Plain Mosshorn, Trillodon | 90 min | 36 h | 36 h |
| Other neutral animals and beasts | 60 min | 18 h | 18 h |

For loaded animals, low hunger or thirst slows progress toward Prime and speeds
progress out of Prime. The lower need sets the rate; penalties do not stack.
At 50% or above, aging runs normally. At 25%, progress toward Prime is 50%
slower and progress out of Prime is 50% faster; at 0%, those changes are 75%.

The shared offline policy pauses progress during owner-offline grace, then
applies its configured multiplier. Unloaded animals age at the normal care
rate during eligible time without consuming food or water. Server downtime
and captured storage add no progress, and trading preserves age.

## Livestock Breeding and Growth Reference
After breeding, animals will be unable to breed for the duration of their breeding cooldown.

Default livestock pairing/cooldown profile:
- Base cooldown: **45 minutes**
- Random delay: **0-300 sec**

| Mob | Baby Stage | Base Breeding Cooldown | Random Delay Window | Time to Full Grown |
|---|---|---:|---|---:|
| Bison | Bison Calf | 45 min | 0-300 sec | 150 min |
| Boar | Boar Piglet | 45 min | 0-300 sec | 90 min |
| Camel | Camel Calf | 45 min | 0-300 sec | 135 min |
| Chicken | Chicken Chick | 45 min | 0-300 sec | 60 min |
| Chicken Desert | Chicken Desert Chick | 45 min | 0-300 sec | 60 min |
| Cow | Cow Calf | 45 min | 0-300 sec | 120 min |
| Goat | Goat Kid | 45 min | 0-300 sec | 90 min |
| Horse | Horse Foal | 45 min | 0-300 sec | 150 min |
| Mouflon | Mouflon Lamb | 45 min | 0-300 sec | 90 min |
| Pig | Pig Piglet | 45 min | 0-300 sec | 90 min |
| Pig Wild | Pig Wild Piglet | 45 min | 0-300 sec | 90 min |
| Ram | Ram Lamb | 45 min | 0-300 sec | 90 min |
| Sheep | Sheep Lamb | 45 min | 0-300 sec | 90 min |
| Skrill | Skrill Chick | 45 min | 0-300 sec | 75 min |
| Turkey | Turkey Chick | 45 min | 0-300 sec | 80 min |
| Warthog | Warthog Piglet | 45 min | 0-300 sec | 90 min |


## Beast Breeding and Growth Reference

| Mob | Base Breeding Cooldown | Random Delay Window | Time to Full Grown | Max Nearby Same Type |
|---|---:|---|---:|---:|
| Bear Grizzly | 90 min | 270-810 sec | 180 min | 3 |
| Bear Polar | 90 min | 270-810 sec | 180 min | 3 |
| Crocodile | 100 min | 300-900 sec | 200 min | 4 |
| Emberwulf | 85 min | 255-765 sec | 220 min | 2 |
| Fen Stalker | 95 min | 285-855 sec | 170 min | 4 |
| Fox | 60 min | 180-540 sec | 90 min | 6 |
| Hyena | 75 min | 225-675 sec | 120 min | 5 |
| Larva Silk | 50 min | 150-450 sec | 60 min | 8 |
| Leopard Snow | 85 min | 255-765 sec | 140 min | 4 |
| Molerat | 55 min | 165-495 sec | 80 min | 7 |
| Raptor Cave | 80 min | 240-720 sec | 130 min | 5 |
| Rat | 45 min | 135-405 sec | 50 min | 10 |
| Rex Cave | 110 min | 330-990 sec | 210 min | 2 |
| Scorpion | 70 min | 210-630 sec | 100 min | 6 |
| Slug Magma | 50 min | 150-450 sec | 60 min | 8 |
| Snake Cobra | 60 min | 180-540 sec | 90 min | 7 |
| Snake Marsh | 55 min | 165-495 sec | 80 min | 7 |
| Snake Rattle | 60 min | 180-540 sec | 90 min | 7 |
| Snapdragon | 100 min | 300-900 sec | 190 min | 3 |
| Spider | 65 min | 195-585 sec | 90 min | 6 |
| Spider Cave | 70 min | 210-630 sec | 100 min | 6 |
| Tiger Sabertooth | 90 min | 270-810 sec | 160 min | 3 |
| Toad Rhino | 80 min | 240-720 sec | 130 min | 4 |
| Toad Rhino Magma | 85 min | 255-765 sec | 140 min | 4 |
| Wolf Black | 70 min | 210-630 sec | 120 min | 5 |
| Wolf White | 70 min | 210-630 sec | 120 min | 5 |
| Yeti | 120 min | 360-1080 sec | 220 min | 2 |


> [Screenshot Placeholder: Breeding pair ready state on two companions]
> [Screenshot Placeholder: Newborn/juvenile stage beside adult parent]



