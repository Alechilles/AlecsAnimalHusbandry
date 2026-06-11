# Changelog

## Unreleased

### Fixed
- Updated livestock hay/food-block seeking to use Tamework reachability preflight before entering movement, reducing cases where animals try to path to unreachable food blocks outside fences.

## 1.6.2 - Localization and Packaging Hotfix - 2026-06-09

### Added
- Added bundled French (France), French (Canada), and Brazilian Portuguese translations for Animal Husbandry items, Tamework config text, talents, traits, commands, interactions, and happiness labels.

### Changed
- Updated Animal Husbandry Tamework configs to use `server.lang` keys for player-facing talent, trait, command, interaction, and happiness text.
- Updated release metadata for Alec's Tamework `2.14.x`, Hytale `0.5.x`, Modtale `0.5.3`, and manifest version `1.6.2`.

### Fixed
- Fixed Windows-built release zips so packaged asset paths use game-compatible forward slashes, preventing zipped installs from hiding Animal Husbandry items such as the command flutes.
- Fixed the packaged Tamework dependency range so Animal Husbandry declares compatibility with the Tamework 2.14.x server build used by the latest package.

## 1.6.1 - Harvest Alarm and Asset Pack Hotfix - 2026-06-07

### Added
- Added a 256x256 in-game icon for the Animal Husbandry asset pack.

### Changed
- Updated livestock harvest templates to use Tamework harvest alarms and reset sensors, allowing harvest cooldown talents to scale reset timers without relying on base-game harvest alarms.
- Updated release metadata for Alec's Tamework `2.13.x`, Hytale `0.5.x`, Modtale `0.5.3`, and manifest version `1.6.1`.
- Added the asset pack icon to release packages and expanded optional CurseForge relationships for Alec's Cats and the MMO Taming Skill Pack.

## 1.6.0 - Companion Progression and Talent Trees - 2026-05-30

### Added
- Added Animal Husbandry leveling configs for all 92 checked-in tamed companion roles, split across harvest livestock, non-harvest livestock, neutral wildlife, critters, and combat Beasts.
- Added Animal Husbandry talent trees for all companion archetypes, with more talent options than available points and branching paths for conditioning, care, production, breeding, recovery, and combat specialization.
- Added utility talents for slower hunger/thirst decay, happiness gain, breeding cooldown, fertility, trait mutation chance, appearance mutation chance, harvest cooldown, revive cooldown, and restrained combat scaling.
- Added appearance mutation talent branches alongside trait mutation branches so players can opt into mutation-focused breeding paths without blocking the core breeding line.
- Added separate livestock progression and talent coverage for animals with harvest functionality versus livestock that cannot be harvested.
- Added carnivore and omnivore needs configs, with related feed-item and wiki updates for diet-specific companion care.

### Changed
- Tuned companion leveling around long-term but achievable goals: critters near 15 hours, neutral wildlife near 20 hours without combat, livestock near 30 hours, and Beasts near 30 hours when moderate combat use is included.
- Added 15-minute feed XP cooldowns and raised care/breeding/harvest XP values so regular care matters without letting repeated feed clicks dominate progression.
- Updated livestock harvest templates to use Tamework harvest alarms, allowing harvest cooldown talents to scale reset timers.
- Updated release metadata for Alec's Tamework `2.12.x`, Hytale `0.5.x`, and manifest version `1.6.0`.
- Updated README/wiki documentation to describe XP levels, passive talents, talent trees, traits, and progression config files as active systems.
- Updated taming reference and getting started wiki images to use Markdown image/link markup for cleaner rendering in feed tables and trough instructions.

### Fixed
- Fixed milk and other container-style harvest luck behavior so harvest bonuses can preserve the harvest cooldown instead of duplicating filled buckets.
- Fixed livestock harvest interactions so bucket/shears requirements route through the correct item-specific harvest checks.
- Fixed wolf combat spacing and retreat tuning so white and black wolves retain intended combat behavior after progression template changes.

## 1.5.2 - Soul Lantern Icons + Beast Collars + Update 5 Compatibility - 2026-05-26

### Added
- Added curated Soul Lantern icon coverage and generated icon assets for Animal Husbandry capture/spawn flows, including shared role groups, base-only entries, and Aures livestock variants.
- Added tamed beast collar appearance support for tamed hyenas, black wolves, and white wolves.
- Added German localization coverage.
- Added the Soul Lantern icon batch manifest and source fallback support for regenerating icon overrides.

### Changed
- Reworked Soul Lantern spawner icon override data to use grouped role icon entries with default icons instead of the oversized per-role generated matrix.
- Updated beast taming, breeding/growth, animal taming reference, and glowing purple mushroom spore wiki documentation.
- Updated CurseForge publishing to upload changelogs as HTML.
- Updated release metadata for Hytale server `0.5.0`, Alec's Tamework `2.11.x`, and manifest version `1.5.2`.

### Fixed
- Adjusted Soul Lantern icon framing and replaced the earlier generated icon matrix with curated outputs and batch fallback data.
- Removed tracked macOS metadata files from the release tree so they are not packaged.

## 1.5.1 - Companion Command Compatibility + Memory Book Cleanup - 2026-05-15

### Added
- Added Alec's Cats longhair, shorthair, and bobtail variants to Animal Husbandry command flute and Soul Lantern compatibility.
- Added Celly's Baby Animals as an optional CurseForge relationship for release publishing.
- Added demo server join information to the README.

### Changed
- Updated `manifest.json` version to `1.5.1`.
- Simplified Animal Taming and Beast Taming reference wiki tables for cleaner in-game documentation rendering.

### Fixed
- Tamed Animal Husbandry creatures no longer opt into memory-book category listings, reducing clutter from player-owned animals.
- Livestock mode cycling no longer competes with bucket and shears interactions when players are trying to collect milk, water, or harvestables.

## 1.5.0 - Demo Server Prep + Gendered Breeding Support - 2026-05-04

### Added
- Enabled gender-aware breeding across livestock, neutral, and beast breeding configs, with different-gender pairing required by default and explicit adult gender labels for deer and moose variants.
- Added `AH_Demo_*` spawn marker assets for manually placing Animal Husbandry demo tetrabirds, cows, bison, normal foxes, cave raptors, cave rexes, turkeys, grizzly bears, and black wolves.

### Changed
- Updated release metadata to `1.5.0` and aligned the required Alec's Tamework dependency to `2.9.x`.
- Refreshed the README with the current CurseForge HTML layout, demo server information, wiki shortcuts, item links, and supported-animal coverage.

### Fixed
- Tamed livestock, critter, and predator templates now refresh their leash point when settling into `Idle` or `Hold`, so leash and wander behavior anchor to the current area after command transitions.

## 1.4.4 - Baby Role Coverage + Neutral Breeding Fixes - 2026-04-27

### Added
- Added command and Soul Lantern support for Celly's baby animal roles, including fox cubs, Arctic fox cubs, flamingo chicks, and tetrabird chicks.
- Added an Animal Husbandry wiki custom theme stylesheet for the HytaleModding wiki surface.

### Changed
- Deer doe/stag and moose bull/cow breeding now use complementary adult-role family overrides so those paired variants can breed together and produce either adult role.
- Refreshed the README and Getting Started wiki copy around settings presets, companion care, commandable animals, and planned systems.
- Reworked wiki homepage routing to use the lowercase `index.md` import contract and updated internal links accordingly.
- Aligned README/wiki dependency guidance with the required Alec's Tamework `v2.8.x` dependency.
- Updated `manifest.json` version to `1.4.4`.

## 1.4.3 - Template ID Cleanup + Cat Command Compatibility - 2026-04-20

### Changed
- Renamed the shared Animal Husbandry role templates to the `AH_Template_*` scheme and rewired role/template references plus compatibility notes to match the new ids.
- Pet cats from Alec's Cats can now be linked and commanded with both the `Animal Control Flute` and `Combat Beast Flute`.
- Refreshed the README/wiki getting-started and feed-trough guides with expanded animal-management guidance, corrected screenshots, and broken-image cleanup.
- Updated `manifest.json` version to `1.4.3`.

### Fixed
- Tamed companions now clear their idle settle/sit posture before command-driven movement resumes, preventing sliding when follow/defend/move commands interrupt a resting idle animation.

## 1.4.2 - Arctic Fox Variant + Owner Retaliation Guard - 2026-04-13

### Added
- Added Arctic Fox as a tameable predator variant, including wild glacial/mountain spawns, tamed role support, custom model/texture assets, and full beast-side integration across interactions, needs, happiness, breeding, command items, soul lanterns, and traits.

### Fixed
- Fixed tamed combat companions retaliating against their owner after accidental hits during defend/combat flows or while waking from owner-caused damage.

### Changed
- Updated `manifest.json` version to `1.4.2`.

## 1.4.1 - Coop Fallback Restoration Hotfix - 2026-04-09

### Fixed
- Restored the temporary coop fallback assets (`Server/Farming/Coops/Coop_Chicken.json` and `Server/Tamework/Items/Coops/ACCoopChicken.json`) so coop flows remain stable when Alec's Coops is not enabled.

### Changed
- Updated `manifest.json` version to `1.4.1`.

## 1.4.0 - Multi-Food Feed Families + Timed Feed Happiness - 2026-04-08

### Added
- Added predator-specific needs/happiness config assets (`AHNeedsBeast`, `AHHappBeast`) so tamed predators can consume/use carnivore feed with dedicated impulse mappings.
- Added optional food classification parameters to tamed templates (`FoodFavorite`, `FoodGeneric`, `FoodPremium`) for role-driven feed impulse mapping without per-role config duplication.

### Changed
- Updated command item naming to **Animal Control Flute** (base) and **Combat Beast Flute** (upgrade), and aligned player-facing docs/localization.
- Updated command item progression recipes/bench tiers to the current design (`Animal Control Flute` on Farming Bench Tier 2, `Combat Beast Flute` on Farming Bench Tier 6 with Wild Wisteria log gate).
- Converted the base command item presentation from bag-style visuals/sounds to flute-style behavior and refreshed flute texture/icon differentiation between Animal Control and Combat Beast variants.
- Feed interactions now keep `AttractiveItemSet` as the baseline food family and also accept feed items by cohort (`Tw_Feed_Herbivore` for livestock/neutral/critter, `Tw_Feed_Carnivore` for predator).
- Passive needs consumption now includes feed items in container food ids (herbivore feed for default cohorts, carnivore feed for predator cohort).
- Happiness configs now use timed feed impulses (`HandFeedDurationMinutes`, `FeedImpulseDurationMinutes`) with param/item mappings so feed effects refresh instead of stacking.
- Enabled `HerbivoreFeed` and `CarnivoreFeed` asset-set toggles in `AHGlobal`.
- Expanded tamed livestock group matching for neutral/critter cohorts using wildcard suffixes and restored Mosshorn coverage in livestock interaction role lists.
- Removed the temporary coop fallback assets introduced in `1.3.4`.
- Updated release metadata to `1.4.0` and aligned required Alec's Tamework dependency to `2.8.x`.
- Rebalanced companion happiness around generic feed so baseline care remains below breeding readiness: generic feed impulses are now stronger negatives while active care boosts (hand-feed and pet) were tuned to let players push breeding readiness through intervention.
- Raised breeding happiness requirements from `70` to `80` across passive breeding configs and manual breed interaction gates for livestock, neutral, beast, and critter cohorts.
- Expanded wiki/README coverage for `1.4.0` command and care loops, including dedicated Feed Items + Feed Trough pages, generic-feed happiness penalty notes, and Wisteria-gated Combat Beast Flute progression guidance.

## 1.3.4 - Temporary Coop Fallback Packaging - 2026-04-03

### Added
- Added temporary coop fallback assets directly in Animal Husbandry (`Server/Farming/Coops/Coop_Chicken.json` and `Server/Tamework/Items/Coops/ACCoopChicken.json`) so coop worlds remain stable when Alec's Coops is not enabled.

### Changed
- Updated fallback coop item config priority strategy so Alec's Coops can override Animal Husbandry when both are enabled.
- Updated `manifest.json` version to `1.3.4`.

## 1.3.3 - Tamework Config ID Refactor - 2026-04-02

### Changed
- Renamed Animal Husbandry Tamework config assets to concise `AH*` ids/file names across interactions, breeding, companion, global, happiness, needs, traits, command item, and soul-lantern spawner config files.
- Rewired wild/tamed role assets and shared templates to remove legacy `TwInteractionConfig_*` references and run the Tamework interaction flow through the renamed config assets.
- Updated `manifest.json` version to `1.3.3`.

## 1.3.2 - Alec's Cats Soul Lantern Compatibility + Update 4 Compatibility Cleanup - 2026-03-26

### Added
- Added Soul Lantern capture/spawner support for Alec's Cats roles in `AnimalHusbandry_Soul_Lantern`.

### Changed
- Removed the Animal Husbandry coop override assets (`Coop_Chicken` and `TwCoopConfig_AnimalHusbandry_Coop_Chicken`) now that they are no longer needed.
- Updated release metadata compatibility to `ServerVersion`/`gameVersions` `2026.03.26-89796e57b`.
- Updated `manifest.json` version to `1.3.2`.
- Refreshed dependency install documentation links in the wiki.

### Fixed
- Removed `NextTargetRange` from `AH_Template_Predator` because it no longer exists on the base-game component.
- Increased throw-speed values in shared livestock/neutral templates to satisfy current minimum throw-speed requirements.

## 1.3.1 - Aures Spawner Icons + Neutral Needs Consolidation - 2026-03-24

### Added
- Added Animal Husbandry soul-lantern icon override coverage for Aures livestock/companion variants by wiring attachment-driven generated icon mappings in `AnimalHusbandry_Soul_Lantern`.
- Added animation override hooks across animal and predator role assets to align role animation behavior with current template wiring.

### Changed
- Consolidated neutral-animal needs handling into `TwNeedsConfig_AnimalHusbandry` and removed the separate `TwNeedsConfig_AnimalHusbandry_Neutral` split.
- Updated livestock command-bag item + ingredient visuals to align with base `Tool_Feedbag` presentation.
- Refreshed README/wiki navigation structure and links (index/frontmatter layout updates and current wiki slugs).

### Fixed
- Fixed Tetrabird preferred-food wiring so wild and tamed Tetrabird roles now point to the intended berry-based attractive item + particle set.

## 1.3.0 - Neutral/Critter Cohort Expansion - 2026-03-19

### Added
- Added Animal Husbandry integration for the remaining AH_Template_Animal_Neutral base-game roles by introducing wild override + Tamed_ role pairs for Antelope, Armadillo, Crab, Deer_Doe, Deer_Stag, Flamingo, Hatworm, Horse_Skeleton, Horse_Skeleton_Armored, Lizard_Sand, Lobster, Moose_Bull, Moose_Cow, Penguin, Spark_Living, Tetrabird, Tortoise, and Trillodon.
- Added Animal Husbandry integration for the passive critter/cactee cohort via wild override + Tamed_ role pairs for Cactee, Frog_Blue, Frog_Green, Frog_Orange, Gecko, Meerkat, Mouse, Squirrel, Snail_Frost, and Snail_Magma.

### Changed
- Wired the new neutral-role cohort into Animal Husbandry Tamework role allowlists/config coverage (interaction, traits, companion, needs, happiness, breeding, command bag, and soul lantern capture/spawn lists) plus AH_Livestock_Tamed membership.
- Extended the same allowlist/config coverage to the passive critter/cactee cohort (critter interaction config, traits, companion, needs, happiness, breeding, command bag, soul lantern capture/spawn, and AH_Livestock_Tamed group membership).
- Passive critter/cactee roles now use dedicated critter templates (`AH_Template_Animal_Critter`, `AH_Template_Critter_Tamed`) and a slimmed interaction config (`TwInteractionConfig_AnimalHusbandry_Critter`) focused on tame/feed/breed/mode-cycle.
- Split that neutral cohort into a dedicated Tamework config set (`TwInteractionConfig_AnimalHusbandry_Neutral`, `TwCompanionConfig_AnimalHusbandry_Neutral`, `TwNeedsConfig_AnimalHusbandry_Neutral`, `TwHappinessConfig_AnimalHusbandry_Neutral`, `TwTraitConfig_AnimalHusbandry_Neutral`, `TwBreedingConfig_AnimalHusbandry_Neutral`) and rewired neutral roles to use the neutral interaction config id.
- Spark Living now uses shared Tamework `Want_Food_Charcoal` thought-bubble particles (blank thought cloud + base-game charcoal icon).
- Enabled mounting support for selected neutral `Tamed_` roles (`Horse_Skeleton`, `Horse_Skeleton_Armored`, `Moose_Bull`, `Moose_Cow`, `Trillodon`, `Deer_Stag`, `Antelope`, `Tetrabird`, `Tortoise`) with per-role mount anchor offsets.

## 1.2.0 - Companion Mounting + Interaction Reliability - 2026-03-16
### Added
- Added mounting support for select larger tamed companions, including bison, mosshorns, wolves, grizzly and polar bears, sabertooths, snow leopards, cave raptors, and cave rexes.

### Fixed
- Fixed `AH_Template_Predator_Tamed` so predator interaction prompts/actions forward the configured Tamework interaction inputs, restoring crouch-mount prompts and mount execution for predator companions marked as mountable.
- Restored livestock harvest interactions to require configured harvest interaction context in the shared Animal Husbandry Tamework interaction config.

## 1.1.2 - Livestock Spawn Compatibility Hotfix - 2026-03-16
### Fixed
- Added missing NPC group assets for `AH_Livestock_Tamed` and `AH_Predator_Tamed` so custom attitude groups resolve during startup on current builds.
- Updated `AH_Predator_Tamed` to use wildcard predator role patterns so current builds resolve the tamed predator group without TagSet member warnings.
- Updated wild livestock role overrides to expose tame parameters locally (`IsTameable`, `TameRoleChange`, `InteractionConfigId`) so `AH_Template_Animal_Neutral` children no longer fail asset validation with private-parameter errors.
- Added explicit wild `Mosshorn` and `Mosshorn_Plain` role overrides with local tame parameters so those base-game livestock roles follow the same current-build compatibility rules.

### Changed
- Clarified wiki guidance for manual breeding so players know crouch-feeding with preferred food can trigger breeding immediately when normal breeding gates are met.

## 1.1.1 - Tranquilizer Asset Sets Hotfix - 2026-03-15
### Added
- Added `TwGlobalConfig_AnimalHusbandry` to explicitly enable Alec's Tamework tranquilizer asset sets so the tranquilizer potion, arrows, and shortbow are available when Animal Husbandry is installed.

### Changed
- Refreshed README links to use the current CurseForge URL and cleaner wiki index labels.

## 1.1.0 - Beast Taming Expansion + Command Flute - 2026-03-14
### Added
- Added first-pass Beast role coverage by overriding all vanilla Beast roles (`AH_Template_Predator` lineage) in Animal Husbandry.
- Added `Tamed_` Beast role variants for all supported Beast roles, currently wired to `AH_Template_Predator_Tamed`.
- Added `AH_Template_Predator_Tamed` by copying `Template_Cat_Pet` from Alec's Cats for Beast-tamed behavior.
- Added Beast-compatible Soul Lantern spawner support (`AnimalHusbandry_Soul_Lantern` + filled variant + spawner config) with Animal Husbandry-specific localization and icon.
- Added a new Animal Husbandry wiki item page for Nametag usage and integration context.

### Changed
- Wild Beast role overrides now include taming + interaction wiring (`IsTameable`, `TameRoleChange`, `InteractionConfigId`).
- Added a `AH_Template_Predator` override with Tamework interaction support so Beast tame flows can execute at template level.
- Added missing Beast/command parameter definitions to `AH_Template_Predator_Tamed` so tamed Beast role fields (for example `Tamed_Wolf_Black`) resolve cleanly.
- Added `TargetRange` and `CombatFleeIfTooCloseDistance` parameter definitions to `AH_Template_Predator_Tamed` to fix runtime parameter-resolution errors (for example `Tamed_Bear_Grizzly`).
- Added dedicated Beast interaction config `TwInteractionConfig_AnimalHusbandry_Predator` and wired Beast roles to it.
- Beast taming now requires the target NPC to be below 20% health (`NpcHealthPercent` with `LessThan 20.0`).
- Updated Animal Husbandry interaction and command-role allowlists to include the new Beast role variants.
- Added tamed Beast role coverage to `Needs`, `Happiness`, `Breeding`, and `Companion` config role-id lists.
- `AH_Template_Livestock` sleep wake routing now preserves sleep origin: wake returns to `Idle` when sleep started from idle/follow, and returns to `Hold` when sleep started from hold.
- Exposed `IsTameable`, `TameRoleChange`, and `InteractionConfigId` as parameters in chained Beast base roles (`Bear_Grizzly`, `Snake_Marsh`, `Spider`) so child variants can override tame settings without parameter visibility errors.
- `TwInteractionConfig_AnimalHusbandry_Predator` role allowlist now contains only Beast and tamed-Beast roles (livestock role IDs removed).
- `TwInteractionConfig_AnimalHusbandry` role allowlist now excludes Beast and tamed-Beast roles so Beast handling is isolated to the dedicated Beast interaction config.
- Beast taming now additionally requires `Sleep.Tranquilized`; `AH_Template_Predator` now forces tranquilized Beasts into `Sleep.Tranquilized` while `Tw_Status_Tranquilized` is active and wakes them when the effect ends.
- Added `TranquilizerSleepThresholdSeconds` to `AH_Template_Predator` so per-role tuning can require longer remaining tranquilizer duration (supporting higher-hit tranquilizer thresholds through effect-duration stacking).
- Added `TranquilizerSleepHealthRange` to `AH_Template_Predator` and gated tranquilizer-forced sleep by health ratio (default `[0, 0.2]`, so Beasts only fall asleep at 20% health or lower unless overridden per role).
- Tranquilizer sleep threshold behavior in `AH_Template_Predator` now latches eligibility while the effect is active: once the duration threshold is met, dropping health into `TranquilizerSleepHealthRange` will trigger sleep without requiring an additional tranquilizer hit.
- Updated Beast tamed template spawner item bindings to use Animal Husbandry Soul Lantern IDs instead of cat-specific spawner IDs.
- Updated command-item crafting quality/bench presentation for command bag and Beast command flute (`Uncommon`/`Rare`, Farmer's Workbench tier 2 for flute recipe).
- Expanded wiki index pages to include Nametag under companion utility and item navigation.

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
- Pet custom interaction bridge via `TriggerNpcHook` (`TwHook_Pet`) with hook-driven NPC effects in `AH_Template_Livestock`.
- Tamework coop integration config for `Coop_Chicken` with companion-aware intake policy.
- Dedicated Animal Husbandry command bag item + recipe with a livestock role allowlist command config.
- Release prep docs: final-state integration reference + V1 test checklist.

### Changed
- `manifest.json` version bumped to `1.0.0`.
- `manifest.json` server version identifier normalized to lowercase format.
- `AH_Template_Animal_Neutral` and `AH_Template_Livestock` now use interaction-config-first behavior for overlapping interaction pathways.
- `AH_Template_Livestock` command/needs/breeding/flock bridge behavior aligned to the current Tamework-based V1 design.
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



