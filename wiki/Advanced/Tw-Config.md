---
title: "TW Config"
order: 4
published: true
draft: false
---
# TW Config

Parent: [Configuration Index](/mod/alecs-animal-husbandry/configuration-index) | [Home](/mod/alecs-animal-husbandry/animal-husbandry-wiki)

Use `/tw config` when you want **intermediate-to-advanced, highly granular control** over Tamework behavior.

Unlike `/tw settings`, this editor is built for per-family/per-asset tuning (role behavior, item bindings, progression rules, and system-level policy assets).

## Who Should Use It
- Server owners, pack maintainers, and modders who are comfortable with config systems.
- Anyone tuning role-specific behavior beyond global defaults.

## What `/tw config` Controls (By Config Type)

| Config Type | What You Can Configure | Full Reference |
|---|---|---|
| `TwGlobalConfig` | Global defaults, shared policy switches, and asset-set gates used by all Tamework systems. | [Tamework Config Reference Index](https://wiki.hytalemodding.dev/mod/alecs-tamework/config-reference-index) |
| `TwCompanionConfig` | Role-scoped companion policy, ownership behavior, command/revive/travel behavior. | [Tamework Config Reference Index](https://wiki.hytalemodding.dev/mod/alecs-tamework/config-reference-index) |
| `TwInteractionConfig` | Interaction flows (`Tame`, `Feed`, `Breed`, `Mount`, custom effects/requirements). | [Interactions.md](https://github.com/Alechilles/AlecsTamework/blob/main/docs/Interactions.md) |
| `TwSpawnerConfig` | Capture/spawn item behavior, role allowlists, owner rules, icon overrides, cooldown/distance. | [Spawner-Config.md](https://github.com/Alechilles/AlecsTamework/blob/main/docs/Spawner-Config.md) |
| `TwNameItemConfig` | Naming-item validation rules, ownership/tamed gates, character limits, random pool linkage. | [Naming-Items.md](https://github.com/Alechilles/AlecsTamework/blob/main/docs/Naming-Items.md) |
| `TwNamesConfig` | Name pools used by naming systems for random suggestions. | [Naming-Items.md](https://github.com/Alechilles/AlecsTamework/blob/main/docs/Naming-Items.md) |
| `TwCommandItemConfig` | Command tool linking, recipient filters, command lists/steps, linked panel behavior. | [Command-Items.md](https://github.com/Alechilles/AlecsTamework/blob/main/docs/Command-Items.md) |
| `TwHappinessConfig` | Happiness values, equilibrium, impulses, and modifiers by role/cohort. | [Tamework Config Reference Index](https://wiki.hytalemodding.dev/mod/alecs-tamework/config-reference-index) |
| `TwNeedsConfig` | Hunger/thirst decay, manual/passive refill behavior, tick policy, and needs-damage model. | [Tamework Config Reference Index](https://wiki.hytalemodding.dev/mod/alecs-tamework/config-reference-index) |
| `TwBreedingConfig` | Breeding eligibility, cooldown timing, offspring lifecycle and role-family growth controls. | [Tamework Config Reference Index](https://wiki.hytalemodding.dev/mod/alecs-tamework/config-reference-index) |
| `TwTraitConfig` | Trait pools, weights, inheritance rules, and role-specific trait behavior. | [Tamework Config Reference Index](https://wiki.hytalemodding.dev/mod/alecs-tamework/config-reference-index) |
| `TwCoopConfig` | Managed coop behavior, accepted role sets, and coop intake/release policy. | [Tamework Config Reference Index](https://wiki.hytalemodding.dev/mod/alecs-tamework/config-reference-index) |
| `TwDebugConfig` | Debug default toggles for runtime diagnostics commands and debugging workflows. | [Tamework Config Reference Index](https://wiki.hytalemodding.dev/mod/alecs-tamework/config-reference-index) |

## Important Notes
- `/tw config` is intended for granular tuning and can significantly change gameplay feel.
- Make small changes, then test in-world before broader rollout.
- Keep backups of known-good config states.

## Where Config Assets Live
- Full family path/discovery rules: [Config-Discovery.md](https://github.com/Alechilles/AlecsTamework/blob/main/docs/Config-Discovery.md)

## `/tw settings` vs `/tw config`
- `/tw settings`: curated global world-level toggles and policy defaults.
- `/tw config`: advanced per-family/per-asset editing and behavior authoring.

## Related Pages
- [TW Settings](/mod/alecs-animal-husbandry/tw-settings)
- [Config Reference (Configuration)](/mod/alecs-animal-husbandry/config-reference-configuration)
