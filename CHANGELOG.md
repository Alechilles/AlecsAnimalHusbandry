# Changelog

## Unreleased
### Added
- Added first-pass predator role coverage by overriding all vanilla predator roles (`Template_Predator` lineage) in Animal Husbandry.
- Added `Tamed_` predator role variants for all supported predator roles, currently wired to `Template_Predator_Tamed`.
- Added `Template_Predator_Tamed` by copying `Template_Cat_Pet` from Alec's Cats for predator-tamed behavior.

### Changed
- Wild predator role overrides now include taming + interaction wiring (`IsTameable`, `TameRoleChange`, `InteractionConfigId`).
- Added a `Template_Predator` override with Tamework interaction support so predator tame flows can execute at template level.
- Added missing predator/command parameter definitions to `Template_Predator_Tamed` so tamed predator role fields (for example `Tamed_Wolf_Black`) resolve cleanly.
- Added `TargetRange` and `CombatFleeIfTooCloseDistance` parameter definitions to `Template_Predator_Tamed` to fix runtime parameter-resolution errors (for example `Tamed_Bear_Grizzly`).
- Added dedicated predator interaction config `TwInteractionConfig_AnimalHusbandry_Predator` and wired predator roles to it.
- Predator taming now requires the target NPC to be below 20% health (`NpcHealthPercent` with `LessThan 20.0`).
- Updated Animal Husbandry interaction and command-role allowlists to include the new predator role variants.
- Added tamed predator role coverage to `Needs`, `Happiness`, `Breeding`, and `Companion` config role-id lists.
- `Template_Livestock` sleep wake routing now preserves sleep origin: wake returns to `Idle` when sleep started from idle/follow, and returns to `Hold` when sleep started from hold.
- Exposed `IsTameable`, `TameRoleChange`, and `InteractionConfigId` as parameters in chained predator base roles (`Bear_Grizzly`, `Snake_Marsh`, `Spider`) so child variants can override tame settings without parameter visibility errors.
- `TwInteractionConfig_AnimalHusbandry_Predator` role allowlist now contains only predator and tamed-predator roles (livestock role IDs removed).
- `TwInteractionConfig_AnimalHusbandry` role allowlist now excludes predator and tamed-predator roles so predator handling is isolated to the dedicated predator interaction config.
- Predator taming now additionally requires `Sleep.Tranquilized`; `Template_Predator` now forces tranquilized predators into `Sleep.Tranquilized` while `Tw_Status_Tranquilized` is active and wakes them when the effect ends.
- Added `TranquilizerSleepThresholdSeconds` to `Template_Predator` so per-role tuning can require longer remaining tranquilizer duration (supporting higher-hit tranquilizer thresholds through effect-duration stacking).
- Added `TranquilizerSleepHealthRange` to `Template_Predator` and gated tranquilizer-forced sleep by health ratio (default `[0, 0.2]`, so predators only fall asleep at 20% health or lower unless overridden per role).
- Tranquilizer sleep threshold behavior in `Template_Predator` now latches eligibility while the effect is active: once the duration threshold is met, dropping health into `TranquilizerSleepHealthRange` will trigger sleep without requiring an additional tranquilizer hit.

## 1.0.3 - UpdateChecker + Art/Docs Refresh - 2026-03-11
### Added
- Added CurseForge update-check metadata in `manifest.json` (`UpdateChecker.CurseForge = 1480275`) so supported clients can detect newer versions.

### Changed
- Updated `manifest.json` version to `1.0.3`.
- Refreshed README shields/badges and added a Hytame recommendation section in the docs.
- Updated `Common/Items/AnimalHusbandry/Shakuhachi.bbmodel` with the latest in-progress model changes.

## 1.0.2 - 2026-03-08
### Added
- New "no-correct-food" tame hint interaction that shows preferred-food thought-bubble particles (`AttractiveItemSetParticles`) instead of silently failing.
- Added Animal Husbandry-themed command item art/model assets.

### Changed
- Updated `manifest.json` version to `1.0.2`.
- Animal Husbandry command bag recipe moved to the Farmer's Workbench and aligned to feed-bag-style ingredient expectations.
- README onboarding and feature sections expanded for clearer player-facing setup and gameplay flow.

### Fixed
- Tame interaction gating now correctly applies untamed-only checks (`IsNotTamed`), so already-tamed livestock no longer show unusable tame prompts.

## 1.0.1 - 2026-03-07
### Fixed
- Added missing files for `AnimalHusbandry_Command_Item`.

## 1.0.0 - 2026-03-07
### Added
- Full livestock integration baseline for Animal Husbandry role coverage.
- Tamework interaction config coverage for wild + tamed livestock role ids.
- Traits config coverage for wild + tamed livestock role ids.
- Pet custom interaction bridge via `TriggerNpcHook` (`TwHook_Pet`) with hook-driven NPC effects in `Template_Livestock`.
- Tamework coop integration config for `Coop_Chicken` with companion-aware intake policy.
- Dedicated Animal Husbandry command bag item + recipe with a livestock role allowlist command config.
- Release prep docs: final-state integration reference + V1 test checklist.

### Changed
- `manifest.json` version bumped to `1.0.0`.
- `manifest.json` server version identifier normalized to lowercase format.
- `Template_Animal_Neutral` and `Template_Livestock` now use interaction-config-first behavior for overlapping interaction pathways.
- `Template_Livestock` command/needs/breeding/flock bridge behavior aligned to the current Tamework-based V1 design.
- Tamed livestock role arrays normalized for tamed-family flock membership behavior.
- `Coop_Chicken` override now accepts tamed chicken-family role variants while keeping vanilla wild auto-capture parity.
- Breeding cadence tuned for V1 with shorter base breeding cooldown and family-specific growth durations.

### Fixed
- Follow teleport reliability and seekfood player-follow stability through finalized component wiring.
- Parent/newborn flock continuity for tamed livestock family roles.


## 0.1.0 - 2026-03-01
### Added
- Initial project scaffold for Alec's Animal Husbandry.
- Base mod metadata (`manifest.json`) with dependency on Alec's Tamework `2.2.x`.
- Starter documentation (`README.md`, `CHANGELOG.md`).
- Starter language pack scaffold (`Server/Languages/en-US/server.lang`).
- Disabled starter Tamework config stubs for livestock interactions, happiness, breeding, and traits.

