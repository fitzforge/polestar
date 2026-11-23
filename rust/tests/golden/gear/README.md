# gear build golden

Command: `forge data gear --root input/root --build 1.60.1.70790 --offline --built-at 2026-10-22T00:00:00.000Z`,
run on a copy of `input/root`; `expected/` holds the six files it writes (by path under the root) and
its stdout without the final newline (`stdout.txt`). There is no other implementation to compare
with: when the output changes on purpose, regenerate `expected/` with the command and read the diff.

Inputs (all under `input/root`):
- `data/sources/wago/1.60.1.70790/`: the Forever client's tables (wago.tools, build 1.60.1.70790, game
  data © Blizzard Entertainment, used as facts), cut to: `ItemSparse`, `Item`, `ItemXItemEffect`,
  `ItemEffect` rows of the 19 items below; the racial skill lines' `SkillLine` and
  `SkillLineAbility` rows with their spells' `SpellEffect`, `SpellName` and `SpellEquippedItems`
  rows (plus the items' equip spells' `SpellEffect` rows); `RandPropPoints`, `ItemArmorQuality`,
  `ItemArmorShield`, `ItemArmorTotal` and the `ItemDamage*` rows of the item levels used;
  `ArmorLocation` whole.
- `data/sources/hotfix/1.60.1.70790/`: the client's hotfix rows (`forge gamedata hotfix --product wowf
  --table <T> --status all --out ...`) of those items: Serpent's Shoulders (retuned) and the two
  rewards of Light's Justice (92421), which only the server's hotfixes hold.
- `data/forever/codex/`: the Codex (`forge data codex`, release build of 2026-11-06, no
  ForeverLevelingBiS) cut to those items, the quests their quest sources name and the NPCs their drop
  sources name; `data/forever/zones.json` (the UiMaps used) and `data/forever/meta.json` (pfQuest's
  source record, for the notice).
- `addon/Polestar_ItemDB/Items.lua`: `forge data itemdb`'s file (Classic Era client tables), cut to 15
  items (the count in its header says so).
- `addon/Polestar/Gear/Weights.lua`: Polestar's own.
- `package.json`: the version that goes into the TOC.
- `data/sources/wowsims/`: the wowsims cache (MIT; LICENSE kept), with the warrior, mage and rogue
  files of every cached commit; the other specs' bands are Polestar's own weights.

The 19 items cover: items as in Era, retuned (a hotfix, a new item level), Forever-only items (pushed
by hotfix), a caster staff (Flags_4 0x300: lower damage, spell power), a caster healing mace
(0x400), a bow (ItemDamageRanged), armor, a shield, a cloak. The racial lines give the Human's
Spirit, the Tauren's health (stamina) and the Gnome's mana (intellect, for its mana classes only).

Test: rust/crates/forge-data/tests/data/gear.rs, which byte-compares them. A second test builds
without the hotfix folder: the three pushed rows are missing and the report names the gap.
