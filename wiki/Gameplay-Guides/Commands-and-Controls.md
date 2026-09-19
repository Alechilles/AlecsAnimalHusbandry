---
title: "Commands and Controls"
order: 4
published: true
draft: false
---
# Commands and Controls

Parent: [Gameplay Guides Index](/mod/alecs-animal-husbandry/gameplay-guides-index) | [Home](/mod/alecs-animal-husbandry/)

## Primary Input Behavior
- **Left-click (Primary):** select an owned animal while aiming at it, or issue the selected command to this flute's selected animals.
- **Right-click (Secondary):** open this flute's companion panel and command menu.
- **F (Interact):** quick-toggle simple companion modes on both livestock and Beasts (`Follow`, `Hold`, `Idle`).

## Owned Companion Panel and Selection
Ordinary command flutes show your owned companions automatically. Owning an
animal and selecting it for a command are separate: use the checkbox on its
card or left-click it with the appropriate flute to select it.

- Each physical flute remembers its own selected animals. Clearing a flute's
  selection stops its commands without giving up ownership.
- `In World`, `Stored`, `Lost / Dead`, and `All` tabs divide the companion
  list. `In World` includes loaded and currently unloaded animals. Their counts
  reflect the current search and Nearby-only filter, not the number selected
  for commands.
- Selected cards appear first. Nearby-only, search, status tabs, and sorting
  only change what you see; they never change the selected recipients.
- A flute can show an owned animal that it cannot command. Read the card's
  restriction before issuing a command.

## Shared Groups
Groups belong to the player and are shared by compatible flutes. Use **Add
group** to choose a name and color, then use an animal's group picker to add
or remove memberships. An animal may belong to several groups or none.

- Left-click a group shortcut to replace this flute's selection with that
  group's members.
- Right-click a group shortcut to add its members to the current selection.
- A highlighted group has all of its eligible members selected. Several groups
  can be highlighted at once.

Changing a group does not select command recipients, and changing selection
does not change group memberships.

## Animal Control Flute Commands
Item page: [Animal Control Flute](/mod/alecs-animal-husbandry/animal-control-flute)

- Follow
- Follow Close
- Hold
- Recall
- Move To Ping
- Set Home
- Return Home
- Idle

## Combat Beast Flute Commands
Item page: [Combat Beast Flute](/mod/alecs-animal-husbandry/combat-beast-flute)

- Follow
- Follow Close
- Hold
- Recall
- Move To Ping
- Defend
- Aggressive
- Attack Target
- Idle

## Following distance

**Follow** keeps companions in a compact formation that moves toward your location without rotating when you turn. Animals can exchange slots and spacing accounts for each animal's size.

**Follow Close** uses the original direct follow behavior, including the species' previous distances, flying orbit, and catch-up/teleport behavior. Select it beside Follow in either flute menu. The direct interaction cycle and Recall still select ordinary Follow.

**Defend** uses the formation while following between fights. Combat movement takes priority when a threat is engaged.

These options require the matching Tamework development build.

## Limits and Gating
- Owned companions appear in the panel automatically; each flute's selection
  determines which compatible companions receive its commands.
- Commands require tame + ownership checks.
- Combat Beast Flute has stricter active/cooldown settings than the Animal Control Flute.

## Companion Panel Actions
- You can manage companions one-by-one with `Recall`, `Set Home`, `Return Home`, and `Revive`.
- `Release` can be offered for an eligible owned companion. `Cull` requires an
  owned, loaded companion nearby.
- If a companion shows `LOST`, use respawn/recovery instead of recall/return-home.

## Captured and Cooped Companions
Tracked companions, and compatible filled capture items in your inventory, can
appear as stored cards while captured. Owned companions in a coop can also
show their stored status and location. Release an animal from its capture item
or coop before commanding it; Recall does not remove it from storage.

If a tracked companion is captured, its card can remain visible even when the
capture process clears ownership. That card is read-only and does not mean the
former owner can command the animal. If another player successfully releases
the companion and becomes its owner, the former owner's flute records are
removed. Trading the item alone, or a failed release, keeps the card visible.

## Shoulder Riding

Use `To Me` on a supported owned companion's card to place the animal on your
shoulder. Use it again to set the companion down.

- Supported critters: frogs, geckos, meerkats, mice, and squirrels.
- Supported flying companions: bluebirds, sparrows, parrots, ravens, crows, green finches, woodpeckers, brown and snow owls, bats and ice bats, pigeons, ducks, archaeopteryxes, and hawks.
- Pterodactyls and vultures are too large for shoulder riding.

## Flying Companions

Supported flying companions have a Ground/Flight button on their companion card.

- **Ground mode:** the companion lands and uses its slower grounded movement.
- **Flight mode:** `Idle` uses aerial wandering, `Follow` uses a flying formation and `Follow Close` uses the original orbit, and `Hold` hovers in place.
- Changing between `Idle`, `Follow`, `Hold`, `Move To Ping`, and home/recall orders does not change the selected Ground/Flight mode.
- Food, water, sleep, and breeding require a safe landing. These activities temporarily take control, and the companion takes off again afterward if Flight mode remains selected.
- These passive vanilla flyers do not receive combat commands.

Supported species and favorite foods: [Flying Companions Taming and Food Preference Table](/mod/alecs-animal-husbandry/animal-taming-reference#flying-companions-taming-and-food-preference-table)

## Related Pages
- [Items Index](/mod/alecs-animal-husbandry/items-index)
- [Animal Taming Reference](/mod/alecs-animal-husbandry/animal-taming-reference)
- [Beast Taming Reference](/mod/alecs-animal-husbandry/beast-taming-reference)
- [Mountable Mobs Reference](/mod/alecs-animal-husbandry/mountable-mobs-reference)

> [Screenshot Placeholder: Command radial/menu with highlighted options]
> [Screenshot Placeholder: Attack Target use on a selected hostile]




