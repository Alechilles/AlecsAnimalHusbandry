---
title: "Saddles and Blankets"
order: 12
published: true
draft: false
---
# Saddles and Blankets

Parent: [Items Index](/mod/alecs-animal-husbandry/items-index) | [Animal Husbandry Wiki](/mod/alecs-animal-husbandry/)

Owners can customize supported tamed animals directly from the interaction prompt.

## Saddle

Craft an `AH_Saddle` at a Tier 1 Farming Bench using:

- 4 Light Leather
- 2 Wool Bolts

Hold the saddle and interact with a supported tamed animal you own. One saddle is consumed and the saddle remains part of that animal's saved appearance.

## Colored Blankets

Hold any full wool cloth block and interact with a supported tamed animal you own. One block is consumed and its color becomes the animal's blanket color. Applying a different color replaces the previous blanket; applying the currently equipped color consumes nothing.

All 20 full wool colors are supported. Half blocks, stairs, and other shaped cloth variants are not accepted.

Blankets do not require a saddle. Saddle and blanket selections persist through normal Tamework capture, respawn, and model synchronization flows.

## Current Model Coverage

The equipment interaction automatically appears only when the animal's current model exposes the required attachment slot. The included first-party saddle and blanket model patches cover horses, deer, and moose; additional Animal Husbandry model patches can use the same interaction without new Java logic.
