# Livestock Template and Role Final State

Last updated: 2026-03-06

## Purpose
This document intentionally captures only the final solutions we kept.
It excludes failed attempts and intermediate iterations.

Use this as the implementation reference when redoing this work with Hytalor patches.

## Scope
- `Server/NPC/Roles/_Core/Templates/Template_Livestock.json`
- `Server/NPC/Roles/_Core/Templates/Template_Animal_Neutral.json`
- `Server/NPC/Roles/Creature/Livestock/**`

## Final Decisions
- Template parameters are the source of truth.
- Role files only override template parameters through `Modify` values.
- If `InteractionConfigId` is set, Tamework interaction flow is used for overlapping interaction branches.
- If `InteractionConfigId` is empty, vanilla interaction branches remain active.

## Template_Animal_Neutral (Final)
- Added `InteractionConfigId` parameter.
- Added Tamework interaction prompt/action path for tame flow when `!isEmpty(InteractionConfigId) && IsTameable`.
- Kept vanilla tame flow as fallback when `IsTameable && isEmpty(InteractionConfigId)`.
- Tame role swap is still driven by `TameRoleChange`, set per role through template modifies.

## Template_Livestock (Final)
- Added command capability parameters with default `false`:
- `CanFollow`
- `CanHold`
- `CanDefend`
- `CanAttackTarget`
- `CanMoveToLocation`
- `CanReturnHome`
- `CanRecall`
- `CanSetHome`
- `CanBreedPair`
- Added `InteractionConfigId` parameter and Tamework interaction prompt/action path.
- Gated vanilla overlapping interaction branches behind `isEmpty(InteractionConfigId)`.
- Added command behavior bridges:
- Follow/Recall via `Component_Tamework_Instruction_Follow_Simple_TP`
- Hold behavior
- Defend/Attack Target state flow
- Move To Location / Return Home / Recall support via `Component_Tamework_Instruction_Command_Move`
- Added breeding-pair state flow via `Component_Tamework_Instruction_Breeding_Pair`, gated by `CanBreedPair`.
- Added needs-seek flow:
- `Component_Tamework_Instruction_Needs_Seek_Resource_Sensor`
- `Component_Tamework_Instruction_Needs_Seek_Resource`
- Added/used `FoodItemIDs` for needs-seek food item overrides.
- Final flock setup in template:
- `FlockSpawnTypes` derives from `FlockArray`
- `FlockAllowedNPC` derives from `FlockArray`
- `FlockSpawnTypesRandom` is `false`
- Final attractive-item seekfood behavior uses `Component_Tamework_Instruction_SeekFood_PlayerFollow` (core Tamework component reference).

## Role Definitions (Final)
- Cow pilot cleanup:
- Removed redundant parameter definitions from tamed cow role files.
- Kept role-specific values in `Modify` blocks.
- Added explicit mount-anchor modifies on `Tamed_Cow`.
- All livestock roles (base and tamed) now set:
- `InteractionConfigId: TwInteractionConfig_AnimalHusbandry`
- Tamed livestock flock arrays are normalized to tamed role IDs (no untamed role IDs in tamed flock arrays).
- Command availability for tamed livestock is controlled through per-role `Can*` modifies.
- `CanFollow`, `CanHold`, `CanMoveToLocation`, `CanReturnHome`, `CanRecall`, `CanSetHome`, and `CanBreedPair` are enabled for the current tamed livestock set.
- `CanDefend` and `CanAttackTarget` remain per-role toggles.

## External Core Dependencies to Carry Forward
These are outside this mod override path but must be kept aligned for equivalent behavior:
- `Alec's Tamework!/Server/NPC/Roles/_Core/Components/Component_Tamework_Instruction_Follow_Simple_TP.json`
- `Alec's Tamework!/Server/NPC/Roles/_Core/Components/Component_Tamework_Instruction_SeekFood_PlayerFollow.json`

## Patch Migration Checklist (Hytalor)
- Patch `Template_Animal_Neutral` with the final `InteractionConfigId` + tame-path gating model.
- Patch `Template_Livestock` with:
- final command gates
- command state bridges
- needs-seek flow
- flock fields (`FlockAllowedNPC`, `FlockSpawnTypesRandom=false`)
- final seekfood component reference
- Patch livestock roles to keep values in `Modify` blocks (no redundant template param declarations in roles).
- Patch all livestock role `InteractionConfigId` values to `TwInteractionConfig_AnimalHusbandry`.
- Patch all tamed livestock `FlockArray` values to tamed-role IDs.
- Keep core Tamework component behavior in sync for follow teleport and seekfood-player-follow stability.

## Validation Targets After Rebuild
- Taming uses Tamework path and performs correct role swap.
- Feed/harvest/mount run through Tamework interaction path when `InteractionConfigId` is set.
- Attractive-item following does not bounce between `Idle` and `SeekFood.GiveUp`.
- Needs-seek transitions are stable (no rapid idle/needs oscillation).
- Newborn livestock join parent flock correctly.
- Command modes (follow/hold/home/move/recall) honor per-role `Can*` toggles.
