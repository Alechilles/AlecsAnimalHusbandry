# V1.0.0 Release Checklist

Use this while validating `Alec's Animal Husbandry!` for `1.0.0`.

## 1. Startup and Asset Load
- Server starts with no `SEVERE` validation errors from Animal Husbandry assets.
- `Template_Livestock` and `Template_Animal_Neutral` load successfully.
- `TwInteractionConfig_AnimalHusbandry` resolves for expected wild and tamed livestock.

## 2. Taming Flow
- Wild livestock can be tamed through Tamework interaction flow.
- Successful tame swaps role to correct tamed role id.
- Tamed entities show expected owner/tamed component state in debug UI.

## 3. Petting Hook Flow
- Pet prompt appears only when expected by interaction requirements.
- Pet interaction emits `TwHook_Pet`.
- NPC applies pet animation + particles and sets `Pet_Ready` alarm.
- Re-petting is blocked until `Pet_Ready` clears.

## 4. Feed, Harvest, Mount
- Feed interaction works through Tamework interaction config.
- Harvest interactions (including bucket replacement where configured) work on eligible species.
- Mount interaction works without role-change crash regressions.
- Mounted posture resets correctly (no sleep/graze posture lock while moving).

## 5. Command Behaviors
- Mode cycle transitions correctly: Follow -> Hold -> Idle.
- Follow teleport fallback works when NPC is out of follow range.
- Set Home / Return Home / Recall / Move To Location behave correctly for roles with flags enabled.
- Defend/Attack Target only activate on roles that explicitly enable those flags.

## 6. Needs, Happiness, Breeding, Traits
- Needs-seek food/water transitions are stable (no rapid idle/seek oscillation loops).
- Happiness values move as expected from feed/pet/needs effects.
- Breeding pairs produce expected offspring roles (adult -> calf mappings).
- Newborns join expected family flock behavior.
- Trait roll/inheritance appears on configured role sets (wild+tamed scope for traits).

## 7. Coverage Sweep
- Spot-check all major livestock families:
- Bison
- Boar/Pig/Warthog families
- Camel
- Chicken/Desert Chicken
- Cow
- Goat
- Horse
- Mouflon/Sheep/Ram
- Rabbit/Bunny
- Skrill
- Turkey

## 8. Coop Integration
- `TwCoopConfig_AnimalHusbandry_Coop_Chicken` loads and resolves for `Coop_Chicken`.
- Captured untamed livestock are denied by coop intake policy.
- Captured companions without owner data are denied by coop intake policy.
- Captured companions owned by another player are denied by coop intake policy.
- Captured tamed/owned livestock are accepted into the coop.

## 9. Release Metadata
- `manifest.json` version is `1.0.0`.
- `CHANGELOG.md` includes final `1.0.0` summary.
- `README.md` reflects current V1 scope and known exclusions.

## 10. Deferred Items (Not Blocking V1)
- Additional per-species override config layering.
