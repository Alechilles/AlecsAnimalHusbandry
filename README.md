[![Tamework](https://img.shields.io/curseforge/dt/1447962?label=Tamework&style=for-the-badge&logo=curseforge&color=rgb(241%2C100%2C54))](https://www.curseforge.com/hytale/mods/alecs-tamework)
[![Cats](https://img.shields.io/curseforge/dt/1432112?label=Cats&style=for-the-badge&logo=curseforge&color=rgb(241%2C100%2C54))](https://www.curseforge.com/hytale/mods/alecs-cats)
[![Nametags](https://img.shields.io/curseforge/dt/1464844?label=Nametags&style=for-the-badge&logo=curseforge&color=rgb(241%2C100%2C54))](https://www.curseforge.com/hytale/mods/alecs-nametags)
[![Animal Husbandry](https://img.shields.io/curseforge/dt/1480275?label=Animal%20Husbandry&style=for-the-badge&logo=curseforge&color=rgb(241%2C100%2C54))](https://www.curseforge.com/hytale/mods/alecs-animal-husbandry)

[![Discord](https://img.shields.io/discord/1468261809739005996?style=for-the-badge&logo=discord&logoColor=white&label=Join%20Discord&color=rgb(88,101,242))](https://discord.gg/E8n8RgTTdq)
[![Buy me a coffee](https://img.shields.io/badge/ko--fi-Support%20Me-ff5f5f?logo=ko-fi&style=for-the-badge)](https://ko-fi.com/alechilles)
[![Creator Code](https://img.shields.io/badge/Creator%20Code-Alec-00AEEF?style=for-the-badge)](https://hytale.com/)

[![Sponsored By HytaleModding Grant Program](https://github.com/user-attachments/assets/a03709e3-445a-4e58-8ec5-591688490c5d)](https://hytalemodding.dev/en/grants)

# Alec's Animal Husbandry!

## Wiki
- [Home](https://wiki.hytalemodding.dev/mod/alecs-animal-husbandry/animal-husbandry-wiki)
- [Start Here](https://wiki.hytalemodding.dev/mod/alecs-animal-husbandry/start-here)
- [Installation and Dependencies](https://wiki.hytalemodding.dev/mod/alecs-animal-husbandry/installation-and-dependencies)
- [Getting Started Guide](https://wiki.hytalemodding.dev/mod/alecs-animal-husbandry/getting-started-guide)
- [Items](https://wiki.hytalemodding.dev/mod/alecs-animal-husbandry/items-index)
- [Gameplay Guides](https://wiki.hytalemodding.dev/mod/alecs-animal-husbandry/gameplay-guides-index)
- [Reference Library](https://wiki.hytalemodding.dev/mod/alecs-animal-husbandry/reference-library-index)
- [Configuration](https://wiki.hytalemodding.dev/mod/alecs-animal-husbandry/configuration-index)

Animals in Hytale should feel alive, personal, and worth caring for. Alec's Animal Husbandry turns vanilla animals into a deep companion and management experience where taming, raising, and breeding all matter.

Current gameplay emphasis is on **Livestock** and **Beasts** (Predators) through command and combat companion systems.

## Getting Started

**1. Install requirements:**
- Alec's Animal Husbandry!
- Alec's Tamework! `v2.8.x`
- Alec's Nametags!

**2. Tame your first animal companion:**
- Approach with valid taming food and interact with the Animal.
- Once tamed, the animal becomes part of your companion system and can be directed.
- Press F with an empty hand or just anything other than food to command them to follow, stay, or wander.
- For mountable animals such as horses, hold Crouch and press F to mount!

**3. Create a good environment for your companions:**
- Build a safe enclosure with room for movement.
- Keep an accessible water source in the enclosure (water blocks and feed trough water both work).
- Keep your companions' preferred food type in a chest in the enclosure.
- If you use feed troughs, keep bucket refill items available so trough water can be replenished.
- Your animals will automatically eat and drink when they are hungry or thirsty.
- Water source blocks are still supported for now, but the long-term plan is to deprecate that path after feed trough hydration has been tested more broadly.

**4. Craft your command item:**
- Craft the **Animal Control Flute** at the Farmer's Workbench (Tier 2).
  - 12x Any Wood, 8x Fibre, 1x Concentrated Life Essence

**5. Bind and command:**
- Use the Animal Control Flute to link your tamed animals.
- Right-click with the Animal Control Flute. 
- From here you can: 
  - View your animal's stats such as happiness, hunger, thirst, traits and more.
  - Issue commands to all linked animals simultaneously.
  - Use per-companion panel actions such as `Recall`, `Set Home`, `Return Home`, `Unlink`, and `Revive` when available.
  - Use nearby-only safety actions `Release` and `Cull` from the linked panel when needed.
  - Recover companions that show a `LOST` status with strict respawn/recovery flow.
  - Set homes and command to return to home or recall to you.

**6. Beast progression path:**
- Craft tranquilizer gear (Tranquilizer Potion + Tranquilizer Arrows + Tranquilizer Shortbow).
- Bring a Beast to **20% HP or lower**, then apply tranquilizer to force sleep.
- Tame with the Beast's preferred food.
- Upgrade to the **Combat Beast Flute** at Farmer's Workbench Tier 6 (1x Concentrated Life Essence, 10x Wild Wisteria Logs, 2x Shadoweave Fabric Scrap, 10x Fire Essence).
- Wild Wisteria logs come from growing and harvesting a Wild Wisteria Tree after you unlock Farming Bench Tier 6.

**7. Companion transport:**
- Craft a **Soul Lantern** at Farmingbench Tier 2 (6x any wood, 2x void essence).
- Use it to capture/release your tamed Livestock and Beasts.

## Core Gameplay Flow

The intended loop is:
1. Tame animals you care about.
2. Keep them fed, watered, and happy.
3. Breed strong pairs (especially for Livestock) to build better bloodlines.
4. Raise offspring through full life stages.
5. Build stronger companion lines from healthier, happier, better-managed animals.

Animals are meant to feel like long-term farm companions, not disposable resource drops.

## Core Features

### Real Taming and Ownership
- Tame animals and make them part of your homestead, not just passive drops.
- Ownership is persistent and respected across companion interactions.
- Tamed variants are integrated into the broader husbandry progression loop.
- Bonded companions may be revived after a cooldown (optional and configurable).

### Needs and Happiness That Actually Matter
<img width="495" height="324" alt="Discord_xtdDoHHb6W" src="https://github.com/user-attachments/assets/e1dd722d-0eb0-4a28-8cc7-cc13300f72c8" />

- Supported animals run on active needs and happiness systems instead of shallow one-off interactions.
- Animals will **eat food from storage and drink from nearby water sources automatically**, including water blocks and feed trough water charges.
- Feed trough water can be refilled with compatible bucket items to keep passive hydration reliable.
- Happiness is influenced by several factors and works on an "equilibrium" system where it sits naturally at about 50, and various factors increase or decrease it.
- Animals will only breed if they are well taken care of and happy.

### Breeding, Traits, and Bloodlines (Livestock Focus)
<img width="649" height="119" alt="Discord_tBwiUZOqXi" src="https://github.com/user-attachments/assets/088f4c74-7cd3-478a-929a-5d9a64f3b76c" />

- Breed compatible livestock pairs and grow long-term lines.
- **Breeding happens passively** when animals are above the happiness threshold and the area is not overcrowded.
- Offspring roll and inherit traits, creating real variation between animals and lots of room for min-maxing.
- Livestock uses the primary husbandry trait profile, including economy-oriented traits like `Bounty`.
- Focus on maintaining a happy and bountiful herd that produces more per animal instead of mass farming shallow mobs.
- Traits from natural spawns have a lower cap, with a higher cap that can be reached through breeding animals with the same traits.
- Random attachments (such as fur color) are inherited, so babies will always match their parents (aside from a very small mutation chance).
- Parent and offspring behavior supports more natural herd and flock development.

### Full Life Stage Progression

<img width="330" height="198" alt="image" src="https://github.com/user-attachments/assets/0a652405-aa88-4caa-8bfd-affd77082f9e" />

- Young animals start as babies and slowly grow over time, advancing life stages when appropriate.
- Baby-to-adult progression is integrated into the companion system.
- Raising animals from early life to maturity is a core gameplay loop.

### Commandable Companions
<img width="451" height="517" alt="Discord_Hpi2BwGKhl" src="https://github.com/user-attachments/assets/fe43ecc3-30c3-4328-be3e-0b5143f415b7" />

- Direct behavior control with command modes like `Follow`, `Hold`, and `Idle`.
- Combat-oriented options (`Defend`, `Attack Target`) are available on species that are configured to support them.
- This is especially useful for Beasts that are intended to act as combat-capable companions.
- Utility command flow for `Set Home`, `Return Home`, `Recall`, and move-to-location control.
- Linked panel actions include per-companion `Revive` plus nearby-only `Release`/`Cull` safety actions.
- Linked panel status includes `LOST` handling with strict recovery through respawn flows.
- Companions can be recalled from anywhere, including cross-world travel when that behavior is enabled in Tamework travel settings.
- `Return Home` remains a same-world behavior.

### Beast Trait Profile

- Beasts use a dedicated trait config: `TwTraitConfig_AnimalHusbandry_Predator`.
- This profile is tuned around combat companions, with heavier emphasis on `Strength`, `Toughness`, and `Swiftness`.
- Economy-focused livestock traits such as `Bounty` are excluded from Beast rolls.
- Inheritance/mutation behavior remains consistent with the main husbandry trait system.

### Nametags
<img width="536" height="268" alt="image" src="https://github.com/user-attachments/assets/2311dbe5-02f0-4c93-8b58-d14ba60b7aa3" />

- Craft a (custom modeled and textured) Nametag item that can be used to name any tamed/owned NPC.

### Coop Integration
- Chicken coops maintain the animal's traits, attachments, and other metadata instead of getting reset on respawn.

## Tips For Best Results

- Keep food storage and water practical and accessible to reduce failed need-seeking.
- Avoid overcrowding if you want reliable passive breeding.
- Use command modes deliberately: `Hold` for structure, `Follow` for movement, `Idle` for free behavior.
- Breed for consistency, not just quantity; inheritance matters over time.

## Mid-Playthrough Worlds

Adding the mod to an existing world is supported.
- Pre-existing tamed animals can be bridged into Tamework ownership on first successful interaction/link.
- If an old tamed animal is not responding to owner-restricted actions, interact/link it once to migrate it.

## Species Scope
Core Livestock coverage includes the full vanilla `Template_Livestock` family:
- Bison
- Boar / Pig / Warthog lines
- Camel
- Chicken / Desert Chicken
- Cow
- Goat
- Horse
- Mouflon / Sheep / Ram lines
- Rabbit / Bunny
- Skrill
- Turkey

Expanded neutral wildlife coverage also includes the remaining vanilla `Template_Animal_Neutral` non-livestock roles, integrated into the same Animal Husbandry tame/companion systems:
- Antelope
- Armadillo
- Crab
- Deer Doe / Deer Stag
- Flamingo
- Hatworm
- Horse Skeleton / Horse Skeleton Armored
- Lizard Sand
- Lobster
- Moose Bull / Moose Cow
- Penguin
- Spark Living
- Tetrabird
- Tortoise
- Trillodon

Passive critter and cactee coverage now also includes:
- Cactee
- Frog Blue / Frog Green / Frog Orange
- Gecko
- Meerkat
- Mouse
- Snail Frost / Snail Magma
- Squirrel

Current Beast support includes broad tame-role coverage for vanilla predator/beast families, with dedicated Beast command/taming flow and Beast-specific trait tuning.

## Compatibility
- Requires Alec's Tamework! `2.8.x`
- Likely incompatible with mods that edit the same animal role assets (especially `Template_Livestock` and Beast role configs).

## Planned Next
- Easier configuration for non-modders.
  - In-game configuration UI.
- Expanded per-species tuning and behavior identity.
- Death over time from starvation and dehydration (optional toggle).
- Death from old age (optional toggle).
- Inbreeding penalties (optional toggle).
- Bonding/XP levels.
- Talent trees.
  - Unlock stat increases, new behaviors, and new abilities as the companion levels up.
- Expand support across more animal types, including broader Beast coverage.

## Hytame Shoutout

If you're looking for a simpler, more Minecraft-like taming and breeding experience, I highly recommend checking out [Hytame - Animal Breeding](https://www.curseforge.com/hytale/mods/hytame) by my friend Lait!



