# Changelog

## 1.0.0 - 2026-03-07
### Added
- Full livestock integration baseline for Animal Husbandry role coverage.
- Tamework interaction config coverage for wild + tamed livestock role ids.
- Traits config coverage for wild + tamed livestock role ids.
- Pet custom interaction bridge via `TriggerNpcHook` (`TwHook_Pet`) with hook-driven NPC effects in `Template_Livestock`.
- Tamework coop integration config for `Coop_Chicken` with companion-aware intake policy.
- Release prep docs: final-state integration reference + V1 test checklist.

### Changed
- `manifest.json` version bumped to `1.0.0`.
- `Template_Animal_Neutral` and `Template_Livestock` now use interaction-config-first behavior for overlapping interaction pathways.
- `Template_Livestock` command/needs/breeding/flock bridge behavior aligned to the current Tamework-based V1 design.
- Tamed livestock role arrays normalized for tamed-family flock membership behavior.
- `Coop_Chicken` override now accepts tamed chicken-family role variants and disables wild auto-capture.

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
