---
title: "Config Reference (Configuration)"
order: 2
published: true
draft: false
---
# Config Reference (Configuration)

Parent: [Configuration Index](/mod/alecs-animal-husbandry/configuration-index) | [Home](/mod/alecs-animal-husbandry/)

This page is optional for players who want to tune behavior.
If you only want to play, use the main guides instead.

For command-level guidance first, see:
- [TW Settings](/mod/alecs-animal-husbandry/tw-settings) for curated global world settings.
- [TW Config](/mod/alecs-animal-husbandry/tw-config) for advanced family-by-family editor usage.

## Full Tamework Config Docs
For complete field-by-field documentation across all config families, use:
- [Alec's Tamework Config Reference Index](https://wiki.hytalemodding.dev/mod/alecs-tamework/config-reference-index)

## Bird flight formations

The aerial role templates expose these NPC role parameters. They are edited in
role JSON, rather than through a `Tw*Config` asset.

| Parameter | Default | Meaning |
| --- | --- | --- |
| `FlightFormation` | `None` | `None`, `Loose`, `Cluster`, or `Chevron`. Ducks select `Chevron`; bluebirds select `Loose`; hawks and vultures retain `Loose` as their alert-flight fallback; pigeons, sparrows, and green finches select `Cluster`. |
| `FlightFormationSpacing` | `3` | Distance between formation positions in blocks; must be positive. |
| `FlightFormationTightness` | `0.6` | How strongly birds return to their positions; greater than zero and at most one. |
| `FlockLeaderLeashDistance` | `80` blocks, wild only | Shared home radius for wild flock leaders during idle flight, airborne target watching, and grounded home checks. Ordinary `WanderRadius` still controls lone birds. A larger leader radius reduces forced boundary turns without making the flock walk back to a smaller home area after landing. |
| `FlightCruiseRelativeSpeed` | `0.25` wild / `0.3` tamed | Ambient flight speed as a fraction of `MaxSpeed`. Cruise steering uses `max(FlightCruiseRelativeSpeed, 4 / MaxSpeed)` to preserve the original 4 blocks/second level-flight minimum when formation steering allows lower speeds. Faster species settings remain in effect. Ducks use about `0.667` with `MaxSpeed: 6`. |
| `FlightCruiseMaxHeadingChange` | `60` wild / `90` tamed | Maximum turn angle between ambient flight segments. Ducks use `30` for gentler routes. |
| `FlightCruiseMinSegmentTime` / `FlightCruiseMaxSegmentTime` | `6` / `10` seconds | Time per ambient flight segment before choosing another direction. Obstacles and the wander boundary can shorten a segment. |

Set these values in the species role's `Modify` map. `Loose` produces a compact
group with gentle drift and staggered heights above and below the leader;
`Cluster` produces a denser irregular group with gentle drift; `Chevron` produces two level arms behind the flock leader. Formation positions
ease around turns. The formation flight controller caps turning at 90 degrees/second
(or the configured limit if lower), including during landing and recovery.
Wild formations apply during cruising and end when the leader starts landing.
Tamed formations apply during airborne idle. Both also keep flying in formation
while alerted to a target that has not triggered fleeing; leaders and lone birds
continue cruising. Close-threat fleeing and obstacle recovery take priority.
Grounded birds retain their watch behavior, and individual commands keep their
existing movement. Both require a flying flock leader and the matching Tamework
build with flight formation support. Formation-enabled species have a lower
minimum airspeed, allowing followers to catch up or slow down into position.
Wild and tamed hawks and vultures enable `IndependentFlightRoaming`. During idle
flight, followers share the leader's home leash point and choose independent waypoints
around that home using
`IndependentFlightRoamRadiusRange` (default `[40, 70]` blocks) and
`IndependentFlightRetargetTimeRange` (default `[10, 20]` seconds). This takes
priority over formation slots while retaining flock membership, normal flight
pace, and obstacle avoidance. Other birds keep their configured formations.
The leader keeps its normal idle route without dragging the followers' roaming
area along. Raptors gather around the same shared home point
specifically for Kettle episodes; alerts retain the existing Loose fallback.
Visual spacing and terrain behavior still need in-game tuning.

See Tamework's [Flight Formation Guide](https://wiki.hytalemodding.dev/mod/alecs-tamework/flight-formation-guide)
for integration details.

## Thermal circling (Kettle)

Wild and tamed hawks and vultures can enter daytime Kettle episodes during idle
flight. Kettle uses a base pace of about 3.2 blocks/second on level flight,
with each bird flying at 70–115% of that pace (capped at maximum flight speed).
Hawks and vultures glide for 10.5 seconds, then flap for 1.5
seconds, with flock members offset so they do not all flap together.
The leader circles around its home point. Nearby flock members begin joining
after individual 2–20 second delays,
using individual radii of 65–150% of the configured radius and distinct height
bands across the configured altitude range. Members alternate clockwise and
counterclockwise orbit directions, keeping their direction while membership is stable.
Height differences persist for the
whole episode instead of every bird eventually reaching the same ceiling.
During the final 30 seconds, followers depart after individual 2–25 second
delays and resume roaming; they cannot rejoin the same ending episode. The
leader continues circling until the episode ends. Kettle beacon checks are
non-consuming so landing, join-delay, and orbit checks can read the same signal. Landing,
threat responses, recovery, and companion commands retain priority.

The aerial templates expose `KettleEnabled` (default `false`),
`KettleRelativeSpeed` (default `0.8` of maximum flight speed), `KettleRadius`
(default `18` blocks), `KettleAltitudeRange` (default `[15, 28]` above the leader's
home point), `KettleCooldownRange` (default `[120, 240]` seconds of cooldown after an episode), and `KettleDurationRange` (default `[180, 420]` seconds).

The initial wait is 60–120 seconds. Later episodes last 3–7 minutes, with
a 2–4 minute cooldown afterward. The cooldown is paused during circling and
resumes when eligible idle flight next checks that the episode has ended. Wild birds defer their normal timed landing while
a Kettle episode is running. Threats, recovery, nighttime, and companion
commands can still interrupt an episode.

## Wild bird flock sizes

Natural world spawns use species-specific weighted flock assets under
`Server/NPC/Flocks/AH_Flock_*.json`. These ranges include the leader. Small and
medium groups are more common than the largest groups; hawks have an 85% chance
of spawning alone or as a pair. Terrain and spawn limits can produce fewer birds.
Existing birds are not resized, and tamed group limits are unchanged.

| Bird | Initial group range |
| --- | --- |
| Sparrow | 4–12 |
| Green finch, pigeon | 3–10 |
| Crow | 2–7 |
| Raven | 1–4 |
| Bluebird, parrot | 2–6 |
| Duck | 2–8 |
| Flamingo | 4–12 |
| Penguin | 5–14 |
| Hawk | 1–4, usually 1–2 |
| Vulture | 2–7 |
| Brown owl, snowy owl | 1–2, usually 1 |
| Woodpecker | 1–3, usually 1 |
| Chicken | 3–8 |
| Desert chicken | 3–7 |
| Turkey | 3–9 |

These are game-scale choices informed by bird social behavior, not literal
wild flock measurements. Social birds receive larger ranges, while solitary
and pair-oriented birds receive smaller ranges. See Cornell's
[hawk flocking overview](https://www.allaboutbirds.org/news/do-hawks-flock-together/),
[raven life history](https://www.allaboutbirds.org/guide/Common_Raven/lifehistory),
and San Diego Zoo's [flamingo guide](https://animals.sandiegozoo.org/animals/flamingo).

Archaeopteryx retains its parent-and-young spawning, Tetrabird retains 2–4,
and Pterodactyl and Skrill retain singleton spawning. Bats are unchanged.

`MinSize` sets the first size and successive `SizeWeights` entries weight each
next size. For example, `MinSize: 1` with `SizeWeights: [55, 30, 10, 5]` means
55% one bird, 30% two, 10% three, and 5% four. Natural spawn overrides change
only the selected bird entries' `Flock` references; other spawn settings retain
their release 0.6.3 values. Mods overriding the same world spawn assets may
conflict with these assignments.

## Active Animal Husbandry Config Files

These are the current (non-deprecated) `AH*` config assets in this repo.

### Core Family Files
| Family | Active File(s) |
|---|---|
| Global | `Server/Tamework/Global/AHGlobal.json` |
| Companion | `Server/Tamework/Companion/AHCompMain.json`<br>`Server/Tamework/Companion/AHCompNeutral.json` |
| Interactions | `Server/Tamework/Interactions/AHIntLivestock.json`<br>`Server/Tamework/Interactions/AHIntNeutral.json`<br>`Server/Tamework/Interactions/AHIntBeast.json`<br>`Server/Tamework/Interactions/AhIntCritter.json` |
| Command Items | `Server/Tamework/Items/Commands/AHCommLivestock.json`<br>`Server/Tamework/Items/Commands/AHCommBeast.json` |
| Needs | `Server/Tamework/Needs/AHNeedsMain.json`<br>`Server/Tamework/Needs/AHNeedsBeast.json` |
| Happiness | `Server/Tamework/Happiness/AHHappMain.json`<br>`Server/Tamework/Happiness/AHHappNeutral.json`<br>`Server/Tamework/Happiness/AHHappBeast.json` |
| Breeding | `Server/Tamework/Breeding/AHBreedLivestock.json`<br>`Server/Tamework/Breeding/AHBreedNeutral.json`<br>`Server/Tamework/Breeding/AHBreedBeast.json` |
| Traits | `Server/Tamework/Traits/AHTraitLivestock.json`<br>`Server/Tamework/Traits/AHTraitLivestockGeneral.json`<br>`Server/Tamework/Traits/AHTraitNeutral.json`<br>`Server/Tamework/Traits/AHTraitBeast.json` |
| Leveling | `Server/Tamework/Leveling/AHLevelLivestock.json`<br>`Server/Tamework/Leveling/AHLevelLivestockGeneral.json`<br>`Server/Tamework/Leveling/AHLevelNeutral.json`<br>`Server/Tamework/Leveling/AHLevelCritter.json`<br>`Server/Tamework/Leveling/AHLevelBeast.json` |
| Talents | `Server/Tamework/Talents/AHTalentLivestock.json`<br>`Server/Tamework/Talents/AHTalentLivestockGeneral.json`<br>`Server/Tamework/Talents/AHTalentNeutral.json`<br>`Server/Tamework/Talents/AHTalentCritter.json`<br>`Server/Tamework/Talents/AHTalentBeast.json` |

### Group Mapping (including Beast)
| Group | Interaction | Companion | Needs | Happiness | Breeding | Traits | Leveling | Talents | Command |
|---|---|---|---|---|---|---|---|---|---|
| Livestock (harvest-capable) | `AHIntLivestock` | `AHCompMain` | `AHNeedsMain` | `AHHappMain` | `AHBreedLivestock` | `AHTraitLivestock` | `AHLevelLivestock` | `AHTalentLivestock` | `AHCommLivestock` |
| Livestock (general) | `AHIntLivestock` | `AHCompMain` | `AHNeedsMain` | `AHHappMain` | `AHBreedLivestock` | `AHTraitLivestockGeneral` | `AHLevelLivestockGeneral` | `AHTalentLivestockGeneral` | `AHCommLivestock` |
| Neutral | `AHIntNeutral` | `AHCompNeutral` | `AHNeedsMain` | `AHHappNeutral` | `AHBreedNeutral` | `AHTraitNeutral` | `AHLevelNeutral` | `AHTalentNeutral` | `AHCommLivestock` |
| Beast | `AHIntBeast` | `AHCompMain` | `AHNeedsBeast` | `AHHappBeast` | `AHBreedBeast` | `AHTraitBeast` | `AHLevelBeast` | `AHTalentBeast` | `AHCommBeast` |
| Critter | `AhIntCritter` | `AHCompNeutral` | `AHNeedsMain` | `AHHappMain` | `AHBreedNeutral` | `AHTraitNeutral` | `AHLevelCritter` | `AHTalentCritter` | `AHCommLivestock` |

Harvest-capable livestock configs cover chicken, cow, mosshorn, sheep, and skrill families. General livestock configs cover livestock families without harvest interactions, so they do not roll Bounty traits or spend points on harvest-only talents.

## Deprecated Naming Note
Older `Tw*Config_AnimalHusbandry_*` asset ids/names are deprecated and were replaced by the `AH*` config file set above.

## Safety Tips Before Editing Configs
1. Make a backup of the file.
2. Change one section at a time.
3. Restart and verify startup logs.
4. Test one species before broad rollout.

## Fast Tuning Targets
- Too much breeding: raise BaseCooldownMinutes.
- Too little breeding: lower cooldown and improve care quality.
- Growth too slow/fast: tune TimeToFullGrownMinutes per role.
- Leveling too slow/fast: tune BaseXp, GrowthFactor, and each XpSources section.
- Talents too strong/weak: tune TalentPoints and the multipliers in the active AHTalent config.
- Overcrowding: lower MaxNearbySameType on sensitive species.
