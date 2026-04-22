---
title: "Getting Started Guide"
order: 3
published: true
draft: false
---
# Getting Started Guide

Parent: [Start Here](/mod/alecs-animal-husbandry/start-here) | [Home](/mod/alecs-animal-husbandry/)

## Quickstart Summary
1. Livestock and neutral wildlife are tamed identically to base Hytale: **feed their [favorite food](/mod/alecs-animal-husbandry/animal-taming-reference).**<br /> Aggressive predators (Beasts) [require more steps](#beast-taming) to weaken and capture, akin to Pokemon or Monster Hunter.

2. After taming, link neutral animals with [Animal Control Flute](/mod/alecs-animal-husbandry/animal-control-flute), and predators with [Combat Beast Flute](/mod/alecs-animal-husbandry/combat-beast-flute), to manage their health and happiness. Craft flutes at a Farming Bench.
   - Right-click with a flute to open the [command interface](#animal-management).
   - Left-click with a flute to link animals and issue group commands.
   - Interact (default keybind `F`) handles most other interactions.

3. Animals [need](#health-and-happiness) access to food, water, and protected space to roam and socialize.
   - Animals will only eat their preferred food (used for taming), or generic feed crafted at a Farming Bench.
   - Generic feed inhibits breeding due to unhappiness, but they won't starve.
   - Passive breeding occurs with high happiness and is toggled per animal in the command flute interface.

4. Safely transport animals with the Soul Lantern, crafted at a Farming Bench.
   * **Do not use the base game Capture Create!** This resets your animal's data.

> **Download [Voile](https://www.curseforge.com/hytale/mods/docs) (optional dependency) to view all documentation in game!**

## Taming
Livestock and neutral wildlife will tell you their favorite foods with `F` Interact, just like base Hytale. This will be the food you tame them with and what you must feed to sustain them.

<img width="400" alt="image" src="https://github.com/user-attachments/assets/aa562a8f-6228-487e-a360-cd8fb9953024" />

The [infographic below](https://www.reddit.com/r/hytale/comments/1rdv827/hytale_taming_cheat_sheet_updated_which_animal/) is a cheat sheet for the default Hytale tameable animals and their preferred food.

<img width="600" alt="image" src="https://github.com/user-attachments/assets/93ce174f-6098-4cee-943d-b5b163290a22" />

View [Animal Taming Reference](/mod/alecs-animal-husbandry/animal-taming-reference) for all animals tameable in Alec's Animal Husbandry!

## Animal Management 

* Interact (default keybind `F`) to cycle animals through `Follow`, `Hold`, and `Recall` states.

   <img width="320" height="242" alt="Follow, Stay, and Wander commands" src="https://github.com/user-attachments/assets/e08d486f-fc8d-405f-8ac8-298301a5d8ef" />

* To mount ridable animals, press `F` to interact while crouching.
* Right-click with a command flute to view your animal's stats, such as happiness, hunger, thirst, traits, and more.
 
<img width="800" alt="Tamework UI Showcase" src="https://github.com/user-attachments/assets/6d6564e7-7183-4843-9740-16374b486f37" />

   * Use per-companion panel actions such as Recall, Set Home, Return Home, Unlink, and Revive when available.
   * Recover companions that show a LOST status with the strict respawn/recovery flow.
   * Set homes, then command animals to return home or recall to you.
   * Select a group command from the command wheel, then left-click with a flute to issue commands to all linked and/or nearby animals simultaneously.
   * Use nearby-only mode to access actions Release and Cull from the Linked panel when needed.

<img width="640" height="484" alt="unlink-cull-process" src="https://github.com/user-attachments/assets/b353fe21-7122-4367-a0ba-952bd68b36e6" />

## Beast Taming
1. Craft Tranquilizer Potion at Lv2 Alchemy Workbench.
   - (Note: [Glowing Purple Mushrooms](/mod/alecs-animal-husbandry/glowing-purple-mushroom-spores) can be cultivated with seeds crafted at Lv6 Farming Bench)
2. Craft Tranquilizer Shortbow and Tranquilizer Arrows at Lv2 Weapon Bench.
3. Weaken the beast to < 20% HP, then shoot tranquilizer arrows until it sleeps.
4. Feed the sleeping beast its preferred food to complete the taming process.
5. Link beast with [Combat Beast Flute](/mod/alecs-animal-husbandry/combat-beast-flute) to manage health and happiness, and command up to 3 Active beasts at a time in combat.
   - (Note: Flute requires Wild Wisteria wood, grown from Wild Wisteria sapling, Lv6 Farming Bench). 

<img width="320" height="242" alt="Taming an Arctic Fox" src="https://github.com/user-attachments/assets/26e43c5c-1d01-42a6-8864-af94c042a7c1" />

Detailed recipes and per-species tranquilizer shot counts:
- [Items Index](/mod/alecs-animal-husbandry/items-index)
- [Beast Taming Reference](/mod/alecs-animal-husbandry/beast-taming-reference)


## Combat Management 
Combat Beasts have all the same commands as neutral animals, plus various attack modes. 
* **Attack Target** - Sics up to 3 Active beasts on a target
* **Aggressive** - Will attack anything that comes near
* **Defend** - Will attack anything that attacks you
  
   <img width="300" alt="Command Radial" src="https://github.com/user-attachments/assets/d2a2d023-7504-48b3-8dbe-9418578f27fd" />

## Health and Happiness 

* Hunger and thirst decay over time. If hunger or thirst reaches 0, your animal will start taking damage.
* Decay and damage rates can be adjusted in `/tw settings`. Lethality from malnourishment is toggled off by default. 

   <img width="583" height="696" alt="tw-settings" src="https://github.com/user-attachments/assets/1aa619d8-99f7-4c3f-827a-e66e7244c711" />

   > You can also use `/tw config` for more complex options.

* Feed animals by placing food in a feed trough.

* Fill a trough with water by right-clicking with a water bucket.


<img width="320" height="210" alt="Filling trough with food" src="https://github.com/user-attachments/assets/a1ccafe5-59dd-4645-8b39-bb326b119550" /> <img width="320" height="210" alt="filling trough with water" src="https://github.com/user-attachments/assets/960f80d9-140f-4ec3-9c1a-b47f5a205260" />


> Note: animals can drink from a water source block, but may drown. This is base Hytale behavior. Use water troughs to keep animals safe!


Animals must have room to move around, and will have varying preferences for population/herd size to meet their social needs. 

![Happiness](https://github.com/user-attachments/assets/e1dd722d-0eb0-4a28-8cc7-cc13300f72c8)


## Breeding
1. Keep compatible animals close enough.
2. Avoid overcrowding.
3. Maintain high care quality.
4. Track growth cycles so you can plan your next generation.
5. If you want to trigger breeding manually, **crouch and interact while holding the animal's preferred food**.

Use the detailed timings here:
- [Breeding and Growth Guide](/mod/alecs-animal-husbandry/breeding-and-growth-guide)




