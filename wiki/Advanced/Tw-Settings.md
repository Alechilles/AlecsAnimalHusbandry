---
title: "TW Settings"
order: 3
published: true
draft: false
---
# TW Settings

Parent: [Configuration Index](/mod/alecs-animal-husbandry/configuration-index) | [Home](/mod/alecs-animal-husbandry/animal-husbandry-wiki)

Use `/tw settings` for **global world-level settings** that affect how Tamework behaves across your save.

This command is meant for server owners/admins who want to tune safety and progression defaults without editing raw JSON files.

## Scope and Persistence
- `/tw settings` is global for the world/save, not just one species.
- Changes apply to all Tamework-based mods loaded in that world (including Animal Husbandry).
- Values are persisted in Tamework settings files and survive restarts.

## What You Can Configure (Full Detail)

### 1) Population Limits
- **Population limit per player owned total**: max owned companions per player (`0` = unlimited).
- **Population scope**: enforce that cap per world or globally across worlds.

### 2) SimpleClaims Integration
- **SimpleClaims enabled**: enables claim-aware cap/protection checks.
- **Claim limit per chunk**: max owned companions in a single claim chunk.
- **Claim limit total**: max owned companions across the claim.
- **Breeding requires claim**: blocks breeding if not in valid claim context.
- **Protect tamed from non-members**: prevents claim non-members from damaging protected tamed companions.

### 3) Ownership Damage Protection
- **Block owner damage**: owner cannot damage their own tamed companions.
- **Block all player damage if owned**: all players are blocked from damaging owned companions.
- **Invulnerable if owned**: owned companions become fully invulnerable to damage sources that respect this policy.

### 4) Capture/Spawn/Command Ownership Rules
- **Capture clears owner**: captured NPC loses ownership metadata.
- **Spawn sets owner**: spawned NPC is assigned to the using player.
- **Capture requires owner**: capture allowed only when owner checks pass.
- **Spawn requires owner**: spawn allowed only when owner checks pass.
- **Interaction requires owner**: interactions require owner checks.
- **Linking requires owner**: command-linking requires owner checks.

### 5) Needs Tick and Needs Damage
- **Needs damage enabled**: enable starvation/dehydration damage model.
- **Needs tick policy mode**:
  - `OwnerOnlineGraceThenDecay`
  - `AnyLoadedPlayer`
- **Owner offline grace hours**: grace window before full decay behavior.
- **Owner offline decay multiplier**: scales decay after grace.
- **Needs damage model**:
  - `MinOnlyPercent`
  - `MinOnlyFlat`
- **Dual need rule**:
  - `UseHigherOnly`
  - `SumBoth`
- **Starvation damage per minute**: starvation damage rate.
- **Dehydration damage per minute**: dehydration damage rate.
- **Needs damage lethal**: allows needs damage to kill companions.

### 6) Revive System
- **Revive system enabled**: enables command-linked revive flow and related cooldown behavior.

### 7) Crash Telemetry Toggles
- **Telemetry enabled**: enables/disables crash telemetry upload behavior.
- **Telemetry breadcrumbs enabled**: enables/disables breadcrumb capture for richer crash context.

## When To Use `/tw settings` vs `/tw config`
- Use `/tw settings` for world-wide policy and safety defaults.
- Use `/tw config` for role/item-specific tuning and advanced behavior authoring.

## Related Pages
- [TW Config](/mod/alecs-animal-husbandry/tw-config)
- [Config Reference (Configuration)](/mod/alecs-animal-husbandry/config-reference-configuration)
