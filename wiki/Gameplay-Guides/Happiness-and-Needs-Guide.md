---
title: "Happiness and Needs Guide"
order: 3
published: true
draft: false
---
# Happiness and Needs Guide

Parent: [Gameplay Guides Index](/mod/alecs-animal-husbandry/gameplay-guides-index) | [Home](/mod/alecs-animal-husbandry/)

This guide explains how to keep companions stable and breeding-ready.

## Why This Matters
- Needs and happiness are core progression gates.
- If needs drop too low, happiness suffers.
- Low happiness blocks breeding and slows long-term line improvement.
- Server settings can enable or disable starvation and dehydration damage,
  including whether that damage can be lethal.

## Default Need Decay
- Hunger: **1 per minute**
- Thirst: **1.3 per minute**

These values add up quickly on larger farms or mixed Beast/livestock setups.

## Keeping Needs Stable
1. Keep accessible water sources inside enclosures.
2. Keep the species' preferred food accessible in storage inside enclosures.
3. Keep pathing clear so companions can actually reach food/water.
4. Avoid overcrowding in one pen.

Flying companion note:
- Tamed flying companions automatically land before eating or drinking.
- Hungry flying companions show their preferred-food thought bubble; thirsty flying companions show a water thought bubble.
- Leave enough open ground near food, troughs, and water for a safe landing and short grounded approach.
- If Flight mode is still selected, they take off again after the care activity finishes.

Feed trough note:
- Feed trough water charges can be consumed for hydration and refilled with water buckets.
- Troughs are useful in enclosed pens where natural water access is awkward.
- Feed crafting and generic feed happiness notes: [Feed Items](/mod/alecs-animal-husbandry/feed-items)
- Trough mechanics and bucket refill details: [Feed Trough](/mod/alecs-animal-husbandry/feed-trough)

See food preferences here:
- [Animal Taming Reference](/mod/alecs-animal-husbandry/animal-taming-reference)
- [Beast Taming Reference](/mod/alecs-animal-husbandry/beast-taming-reference)

## Happiness and Breeding
- Breeding checks include a happiness gate (commonly **70** in current configs).
- Pair matching will fail if happiness is too low.
- Stable care loops (food, water, safe enclosure, low stress) keep breeding cadence predictable.

See breeding timings and cooldown behavior:
- [Breeding and Growth Guide](/mod/alecs-animal-husbandry/breeding-and-growth-guide)

## Fast Checklist
1. Food available and in range.
2. Water available and reachable.
3. No obvious enclosure/pathing block.
4. Companion is tamed, adult, and not in combat/sleep when breeding is expected.

## Server Experience Presets
Server administrators can use `/tw settings` to choose `Simplified
(Minecraft-like)`, `Easier`, `Full Experience`, `Hardcore`, or `Custom`.
Selecting a preset fills the settings form immediately; review it, then use
**Apply** to save it. Presets change experience, aging, revival, recall
teleportation, and needs damage, while ownership, population, and claim rules
stay as configured.

`Hardcore` enables full adult aging and old-age death for supported animals,
disables revives and recall teleportation, and sets starvation and dehydration
damage to 10% and 15% of maximum health per minute. The standard presets
restore revives and recall teleportation and turn off old-age death. Custom
server settings can differ.

> [Screenshot Placeholder: Companion panel with stable hunger, thirst, and happiness]
> [Screenshot Placeholder: Food chest + water source layout that supports continuous care]
