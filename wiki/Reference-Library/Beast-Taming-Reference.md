---
title: "Beast Taming Reference"
order: 2
published: true
draft: false
---
# Beast Taming Reference

Parent: [Reference Library Index](/mod/alecs-animal-husbandry/reference-library-index) | [Home](/mod/alecs-animal-husbandry/)
Related hub: [Items Index](/mod/alecs-animal-husbandry/items-index)

This page is a practical quick-reference for Beast taming.

![Beast Taming Gear](https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/d7b61c44-e95e-4e07-85d9-8f984b82784c.png)

## Required Items
* [Tranquilizer Potion](/mod/alecs-animal-husbandry/tranquilizer-potion)
* [Tranquilizer Arrows](/mod/alecs-animal-husbandry/tranquilizer-arrows)
* [Tranquilizer Shortbow](/mod/alecs-animal-husbandry/tranquilizer-shortbow)
* [Preferred food](#beast-taming-and-feeding-table) (see table below)
* [Combat Beast Flute](/mod/alecs-animal-husbandry/combat-beast-flute) (Recommended)

[![Beast Taming Demo Video](https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/49863e5d-433c-4bc3-8de2-b79649f62499.png)](https://www.youtube.com/watch?v=Yo5Aemwwjfo)

## Beast Taming Steps
1. Brew [Tranquilizer Potion](/mod/alecs-animal-husbandry/tranquilizer-potion) at Alchemy bench.
    * Note: [Glowing Purple Mushrooms](/mod/alecs-animal-husbandry/glowing-purple-mushroom-spores) can be cultivated via Farming Workbench.

2. Craft [Tranquilizer Shortbow](/mod/alecs-animal-husbandry/tranquilizer-shortbow) and [Tranquilizer Arrows](/mod/alecs-animal-husbandry/tranquilizer-arrows) at Weapons bench.
3. Weaken beast by attacking until its health is 20% or less. 
4. Shoot beast with tranquilizer arrows until it falls asleep. 
    - It doesn't matter if you build the tranquilizer stacks or get it below 20% first.

5. Once asleep, feed its [preferred food](#beast-taming-and-feeding-table) to complete the taming process.
    - You can `F` interact while beast is asleep to check its preferred food.


6. Left-click with [Combat Beast Flute](/mod/alecs-animal-husbandry/combat-beast-flute) to link your newly tamed beast!

<br/>

<img width="320" height="242" alt="Taming an Arctic Fox" src="https://github.com/user-attachments/assets/26e43c5c-1d01-42a6-8864-af94c042a7c1" />


<br/>

You can press `F` on a tamed Beast to quick-toggle simple modes (`Follow`, `Hold`, `Idle`), just like livestock and neutral animals..
 


## Tranquilizer Shot Math
- Tranquilizer duration per hit: **30 seconds**
- Hits stack duration
- Shots needed: **ceiling(tranquilizer threshold / 30)**
- Values below assume steady hit pressure without long gaps

## Beast Taming and Feeding Table
| Beast | Preferred | Food | Threshold (seconds) | Shots Needed |
|---|---:|:---|---:|---:|
| Larva Silk | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/602b7010-3923-487f-8d30-9aa58ab94a74.png" /> | Egg | 20 | 1 |
| Rat | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/bc41d0a4-9fbd-4ecb-b764-59d753829645.png" /> | Raw Pork | 20 | 1 |
| Fox | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/8ff8c654-3b8c-4cf5-bd9f-41fd8172fe4f.png" /> | Raw Chicken | 50 | 2 |
| Molerat | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/602b7010-3923-487f-8d30-9aa58ab94a74.png" /> | Egg | 50 | 2 |
| Slug Magma | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/1e97c2d0-7bcf-4409-9857-6e418d6b600d.png" /> | Raw Wildmeat | 50 | 2 |
| Snake Cobra | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/602b7010-3923-487f-8d30-9aa58ab94a74.png" /> | Egg | 50 | 2 |
| Snake Marsh | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/602b7010-3923-487f-8d30-9aa58ab94a74.png" /> | Egg | 50 | 2 |
| Snake Rattle | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/602b7010-3923-487f-8d30-9aa58ab94a74.png" /> | Egg | 50 | 2 |
| Spider | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/8ff8c654-3b8c-4cf5-bd9f-41fd8172fe4f.png" /> | Raw Chicken | 50 | 2 |
| Spider Cave | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/8ff8c654-3b8c-4cf5-bd9f-41fd8172fe4f.png" /> | Raw Chicken | 50 | 2 |
| Fen Stalker | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/3e6f6d42-7c69-4024-900a-365c79f1a608.png" /> | Raw Fish | 80 | 3 |
| Hyena | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/1e97c2d0-7bcf-4409-9857-6e418d6b600d.png" /> | Raw Wildmeat | 80 | 3 |
| Leopard Snow | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/1e97c2d0-7bcf-4409-9857-6e418d6b600d.png" /> | Raw Wildmeat | 80 | 3 |
| Raptor Cave | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/8ff8c654-3b8c-4cf5-bd9f-41fd8172fe4f.png" /> | Raw Chicken | 80 | 3 |
| Scorpion | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/8ff8c654-3b8c-4cf5-bd9f-41fd8172fe4f.png" /> | Raw Chicken | 80 | 3 |
| Wolf Black | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/1e97c2d0-7bcf-4409-9857-6e418d6b600d.png" /> | Raw Wildmeat | 80 | 3 |
| Wolf White | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/1e97c2d0-7bcf-4409-9857-6e418d6b600d.png" /> | Raw Wildmeat | 80 | 3 |
| Bear Grizzly | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/3e6f6d42-7c69-4024-900a-365c79f1a608.png" /> | Raw Fish | 110 | 4 |
| Bear Polar | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/3e6f6d42-7c69-4024-900a-365c79f1a608.png" /> | Raw Fish | 110 | 4 |
| Crocodile | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/3e6f6d42-7c69-4024-900a-365c79f1a608.png" /> | Raw Fish | 110 | 4 |
| Emberwulf | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/1e97c2d0-7bcf-4409-9857-6e418d6b600d.png" /> | Raw Wildmeat | 110 | 4 |
| Snapdragon | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/3ec3fe46-1b80-4333-a213-0489cee35787.png" /> | Raw Beef | 110 | 4 |
| Tiger Sabertooth | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/1e97c2d0-7bcf-4409-9857-6e418d6b600d.png" /> | Raw Wildmeat | 110 | 4 |
| Toad Rhino | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/3e6f6d42-7c69-4024-900a-365c79f1a608.png" /> | Raw Fish | 110 | 4 |
| Toad Rhino Magma | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/3ec3fe46-1b80-4333-a213-0489cee35787.png" /> | Raw Beef | 110 | 4 |
| Yeti | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/3ec3fe46-1b80-4333-a213-0489cee35787.png" /> | Raw Beef | 140 | 5 |
| Rex Cave | <img src="https://wiki.hytalemodding.dev/storage/mods/019ce94e-972f-717d-8881-7a3d542de0c3/files/3ec3fe46-1b80-4333-a213-0489cee35787.png" /> | Raw Beef | 170 | 6 |


