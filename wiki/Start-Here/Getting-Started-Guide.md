---
title: "Getting Started Guide"
order: 3
published: true
draft: false
---
# Getting Started Guide

Parent: [Start Here](/mod/alecs-animal-husbandry/start-here) | [Home](/mod/alecs-animal-husbandry/animal-husbandry-wiki)

## Quickstart Summary
1. Livestock and Neutral wildlife are tamed identically to base Hytale: **feed their [favorite food](/mod/alecs-animal-husbandry/animal-taming-reference).** </br> Aggressive predators (Beasts) [require more steps](#beast-taming) to weaken and capture, akin to Pokemon or Monster Hunter. 


2. After taming, link neutral animals with [Animal Control Flute](/mod/alecs-animal-husbandry/animal-control-flute), and predators with [Combat Beast Flute](/mod/alecs-animal-husbandry/combat-beast-flute), to manage their health and happiness. Craft flutes at farming bench.
   - Right-click with flute to open the [command interface](#animal-management). 
   - Left-click with flute to link animals and issue group commands. 
   - Interact (default keybind `F`) will manage most other interactions. 

2. Animals [need](#health-and-happiness) access to food, water, and protected space to roam and socialize. 
   - Animals will only eat their preferred food (used for taming), or generic feed crafted at farming bench. 
   - Generic feed inhibits breeding due to unhappiness, but they won't starve. 
   - Passive breeding occurs with high happiness, and is toggled per-animal in the command flute interface. 
   
4. Safely transport animals with Soul Latern, crafted at Farming Bench.
   * **Do not use base game Capture Create!** This resets your animal's data.
   



> **Download [Voile](https://www.curseforge.com/hytale/mods/docs) (optional dependency) to view all documentation ingame!** 

# Taming
Livestock and neutral wildlife will tell you their favorite foods with `F` Interact, just like base Hytale. This will be the food you tame them with and what you must feed to sustain them.
![alt text](Hytale2026-04-18_00-16-01.png)
> The [infographic below](https://www.reddit.com/r/hytale/comments/1rdv827/hytale_taming_cheat_sheet_updated_which_animal/) is a cheatsheet for the default Hytale tameable animals and their preferred food. 


![Food Preferences](default-food-cheatsheet.png)


View [Animal Taming Reference](/mod/alecs-animal-husbandry/animal-taming-reference) for all animals tameable in Alec's Animal Husbandry! 



## Animal Management 

* Interact (default keybind `F`) to cycle animals through `Follow`, `Hold`, and `Recall` states.

   ![alt text](follow-stay-wander.gif)

* To mount ridable animals, press ``F`` interact while crouching. 
* Right-click with command flute to view your animal's stats such as happiness, hunger, thirst, traits and more.

![alt text](image.png)
   * Use per-companion panel actions such as Recall, Set Home, Return Home, Unlink, and Revive when available.
 
* Recover companions that show a LOST status with strict respawn/recovery flow.
* Set homes and command to return to home or recall to you.
* Select a group command from the command wheel, then Left-click with flute to issue commands to all linked and/or nearby animals simultaneously.

* Use nearby-only mode to access actions Release and Cull from the Linked panel when needed.

    ![alt text](unlink-cull-process.gif)


## Beast Taming
1. Craft Tranquilizer Potion at Lv2 Alchemy workbench 
   - (Note: [Glowing Purple Mushrooms](/mod/alecs-animal-husbandry/glowing-purple-mushroom-spores) can be cultivated with seeds crafted at Lv6 Farming Bench)
2. Craft Tranquilizer Shortbow and Tranquilizer Arrows at Lv2 Weapon Bench.
3. Weaken beast to < 20% HP, then shoot tranquilizer arrow until it sleeps.
4. Feed preferred food to sleeping beast to complete the taming process.
5. Link beast with [Combat Beast Flute](/mod/alecs-animal-husbandry/combat-beast-flute) to manage health and happiness, and command up to 3 Active beasts at a time in combat.
   - (Note: Flute requires Wild Wisteria wood, grown from Wild Wisteria sapling, Lv6 Farming Bench). 

![alt text](taming_arctic_fox.gif)

Detailed recipes and per-species tranquilizer shot counts:
- [Items Index](/mod/alecs-animal-husbandry/items-index)
- [Beast Taming Reference](/mod/alecs-animal-husbandry/beast-taming-reference)


## Combat Management 
Combat Beasts have all the same commands as neutral animals, plus various attack modes. 
* **Attack Target** - Sics up to 3 Active beasts on a target
* **Aggressive** - Will attack anything that comes near
* **Defend** - Will attack anything that attacks you
   ![alt text](image-1.png)

# Health and Happiness 

* Hunger and thirst decay over time. If Hunger or Thirst reach 0, your animal will start taking damage. 
* Decay and damage rates can be adjusted in `/tw settings`. Lethality from malnourishment is toggled off by default. 

   ![alt text](tw-settings.png)

   > You can also `/tw config` for more complex options.

* Feed animals by placing food in a feed trough or chest (legacy). 

* Fill a trough with water by right-clicking with water bucket. 


![alt text](fill-feed-trough.gif) ![alt text](fill-water-tough.gif)

> Note: animals can drink from water source block, but may drown. This is base Hytale behavior. Use water troughs to keep animals safe!


Animals must have room to move around, and will have varying preferences for population/herd size to meet their social needs. 

   >![alt text](image-2.png)


## Breeding
1. Keep compatible animals close enough.
2. Avoid overcrowding.
3. Maintain high care quality.
4. Track growth cycles so you can plan your next generation.
5. If you want to trigger breeding manually, **crouch and interact while holding the animal's preferred food**.

Use the detailed timings here:
- [Breeding and Growth Guide](/mod/alecs-animal-husbandry/breeding-and-growth-guide)




