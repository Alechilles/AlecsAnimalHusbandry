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

Hold the saddle and interact with a supported tamed animal you own. One saddle is consumed and the saddle remains part of that animal's saved appearance. To remove it, interact with an empty hand; the same `AH_Saddle` item is returned to your active hotbar slot.

## Colored Blankets

Hold any full wool cloth block and interact with a supported tamed animal you own. One block is consumed and its color becomes the animal's blanket color. Applying a different color replaces the previous blanket; applying the currently equipped color consumes nothing.

When a different color is applied, the previously equipped wool block is returned. Interact with an empty hand to remove a blanket and receive its exact color back.

All 20 full wool colors are supported. Half blocks, stairs, and other shaped cloth variants are not accepted.

Blankets do not require a saddle. Saddle and blanket selections persist through normal Tamework capture, respawn, and model synchronization flows.

Saddles and blankets are equipment, not inherited appearance traits. Offspring keep their model's unequipped defaults even when either parent is equipped.

Petting takes priority over empty-hand removal. If Pet is ready, the first interaction pets the animal and starts the Pet cooldown. The next interaction removes equipment. When both a saddle and blanket are equipped, the saddle is removed first and the following interaction removes the blanket.

## Current Model Coverage

Saddles are supported on every animal listed in the [Mountable Mobs Reference](/mod/alecs-animal-husbandry/mountable-mobs-reference), including alternate models such as polar bears, plain mosshorns, armored skeleton horses, cave spiders, and the wolf-family big cats.

Blankets are supported on horses, deer and antelope, moose, mosshorns, and skeleton horses. The equipment interaction appears only when the animal's current model exposes the matching attachment slot, so unsupported blanket models do not show a misleading prompt.
