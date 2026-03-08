# Alec's Animal Husbandry!
![Alec&#39;s Animal Husbandry! Banner](https://github.com/user-attachments/assets/271f1ff0-b865-4631-848e-e43fed26a0c8)



Livestock in Hytale should feel alive, personal, and worth caring for. Alec's Animal Husbandry turns vanilla livestock into a deep companion and farm-management experience where taming, raising, and breeding all matter.

## Getting Started

1. **Install requirements:**
- Alec's Animal Husbandry!
- Alec's Tamework! `v2.2.x`
- Alec's Nametags!

2. **Tame your first livestock:**
- Approach with valid taming food and interact with the Animal.
- Once tamed, the animal becomes part of your companion system and can be directed.
- Press F with an empty hand or just anything other than food to command them to follow, stay, or wander.

3. **Create a good environment for your companions:**
- Build a safe enclosure with room for movement.
- Keep an accessible water source in the enclosure.
- Keep your companions' preferred food type in a chest in the enclosure.
- Your animals will automatically eat and drink when they are hungry or thirsty.

4. **Craft your command item:**
- Craft the Animal Husbandry Command Bag at the Farmer's Workbench.
  - 10x Wheat, 5x Any Vegetable, 5x Any Fruit, 10x Essence of Life

5. **Bind and command:**
- Use the command bag to link your tamed livestock.
- Right-click with the command bag. 
- From here you can: 
  - View your animal's stats such as happiness, hunger, thirst, traits and more.
  - Issue commands to all linked animals simultaneously.
  - Revive deceased companions.
  - Set homes and command to return to home or recall to you.

## Core Gameplay Flow

The intended loop is:
1. Tame livestock you care about.
2. Keep them fed, watered, and happy.
3. Breed strong pairs to build better bloodlines.
4. Raise offspring through full life stages.
5. Harvest from healthier, happier, better-bred animals.

Animals are meant to feel like long-term farm companions, not disposable resource drops.

## Core Features

### Real Taming and Ownership
- Tame livestock and make them part of your homestead, not just passive farm drops.
- Ownership is persistent and respected across companion interactions.
- Tamed variants are integrated into the broader husbandry progression loop.
- Bonded companions may be revived after a cooldown (optional and configurable).

### Needs and Happiness That Actually Matter
<img width="495" height="324" alt="Discord_xtdDoHHb6W" src="https://github.com/user-attachments/assets/e1dd722d-0eb0-4a28-8cc7-cc13300f72c8" />

- Livestock run on active needs and happiness systems instead of shallow one-off interactions.
- Animals will **eat food from storage and water from water blocks automatically** when they are hungry or thirsty.
- Happiness is influenced by several factors and works on an "equilibrium" system where it sits naturally at about 50, and various factors increase or decrease it.
- Animals will only breed if they are well taken care of and happy.

### Breeding, Traits, and Bloodlines
<img width="649" height="119" alt="Discord_tBwiUZOqXi" src="https://github.com/user-attachments/assets/088f4c74-7cd3-478a-929a-5d9a64f3b76c" />

- Breed compatible livestock pairs and grow long-term lines.
- **Breeding happens passively** when animals are above the happiness threshold and the area is not overcrowded.
- Offspring roll and inherit traits, creating real variation between animals and lots of room for min-maxing.
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
- Utility command flow for `Set Home`, `Return Home`, `Recall`, and move-to-location control.
- Mobs may be sent home and recalled from anywhere in the same world, **even if they are currently unloaded**.

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
- Pre-existing tamed livestock can be bridged into Tamework ownership on first successful interaction/link.
- If an old tamed animal is not responding to owner-restricted actions, interact/link it once to migrate it.

## V1 Species Scope
Version `1.0.0` covers the full vanilla `Template_Livestock` family, including:
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

## Compatibility
- Requires Alec's Tamework! `2.2.x`
- Likely incompatible with most mods that edit the livestock mobs' individual roles and Template_Livestock.

## Coming After V1
- Capture/Spawn items for all supported mobs (very soon).
- Replace placeholder command item with Shakuhashi flute including command sound effects played by a **real traditional Japanese musician**.
- Easier configuration for non-modders.
  - In-game configuration UI.
- Expanded per-species tuning and behavior identity.
- Death over time from starvation and dehydration (optional toggle).
- Death from old age (optional toggle).
- Inbreeding penalties (optional toggle).
- Bonding/XP levels.
- Talent trees.
  - Unlock stat increases, new behaviors, and new abilities as the companion levels up.
- Integrate with more animal types outside of Livestock.

