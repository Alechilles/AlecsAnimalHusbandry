# Troubleshooting

## "My animals won't breed"
Check these first:
1. They are tamed and adult.
2. Happiness is above threshold.
3. They are not sleeping or in combat.
4. Cooldown + random delay window has elapsed.
5. Nearby same-type limits are not exceeded.

## "They keep getting unhappy"
Common causes:
- Food chest not in range.
- Water source too far or inaccessible.
- Overcrowded enclosure.
- Repeated damage/combat events.

## "Commands don't seem to work"
Check:
1. The companion is linked to the item.
2. You are the owner.
3. The role is allowed by that command item config.
4. For attack commands, your target is valid.

## "Server fails on startup"
- Read the first SEVERE asset validation line in server log.
- Most common causes are bad internal references, invalid JSON types, or missing dependency mods.

## "Flute item exists but I can't craft it"
Check:
1. You are at Weapon Bench Tier 2 and have Armory bow-diagram access.
2. You have the required inputs (Livestock Command Bag, bamboo trunk, fibre, heavy leather, shadoweave fabric scrap, life essence).
3. Alec's Tamework is installed and loaded correctly.

Recipe details:
- [Beast Command Flute](/mod/alecs-animal-husbandry/items-beast-command-flute)

## "I can't craft tranquilizer bow/arrows/potion"
Check:
1. Alec's Tamework is installed and enabled.
2. The active Tamework global config enables the tranquilizer item sets (shortbow, arrows, and potion).
3. You are using the right benches: Alchemy Bench Tier 2 for potion, Weapon Bench Tier 2 for arrows, and Weapon Bench Tier 2 + Armory for bow.
4. Your server/client has been restarted after config edits.
5. Logs do not show missing-asset validation errors.

Recipe details:
- [Tranquilizer Potion](/mod/alecs-animal-husbandry/items-tranquilizer-potion)
- [Tranquilizer Arrows](/mod/alecs-animal-husbandry/items-tranquilizer-arrows)
- [Tranquilizer Shortbow](/mod/alecs-animal-husbandry/items-tranquilizer-shortbow)

## Recovery Workflow
1. Revert last config edit.
2. Confirm startup succeeds.
3. Re-apply changes incrementally.
4. Re-test with one species before scaling.

> [Screenshot Placeholder: Example server error line and corrected config snippet]
