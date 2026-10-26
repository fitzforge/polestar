# gear build golden

JS: this checkout's tools/ (rust-retire, a8f669093).
Command: `sh regen.sh <this checkout>`. The JS reads package.json, Weights.lua, Polestar_ItemDB and the wowsims cache from its own checkout. So regen.sh copies `<checkout>/tools` and `input/root` into a scratch root and runs the `gear build` command module there with `--addons input/AddOns`. `pin-date.js` pins `builtAt` to 2026-10-22T00:00:00.000Z.

Inputs:
- `AddOns/ForeverLevelingBiS/`: synthetic, MIT, written for this golden (see its LICENSE). It copies the addon's file layout (Data/{Items,Quests,Tables,Overrides}.lua, Racials.lua, TOC) but no content. ForeverLevelingBiS is now "All rights reserved"; only its MIT versions may be read, and no MIT copy was at hand. The items and quests are real ids from the slice zones, with invented values. They cover:
  - unchanged, retuned and new items;
  - an override that hides an item, one that edits an item and one that adds an item;
  - quest, drop and crafted sources, plus an unknown source type and an unknown profession;
  - a non-equippable item;
  - racial stat multipliers and weapon crit.
- `root/addon/Polestar_ItemDB/Items.lua`: this checkout's file (`itemdb build`, Blizzard client tables as facts), cut to 15 items (the count in its header says so).
- `root/addon/Polestar/Gear/Weights.lua`: Polestar's own, copied from this checkout.
- `root/package.json`: the version (0.2.6) that goes into the TOC.
- `root/data/sources/wowsims/`: the wowsims cache (MIT; LICENSE kept). It keeps manifest.json and the warrior, mage and rogue files of every cached commit. The other specs are absent, so their bands are Polestar's own weights.

expected/: the six files it writes, by path under the root, plus `stdout.txt`.

Test: rust/crates/forge-data/tests/gear.rs, which byte-compares them. A second test checks the refusal: with a non-MIT LICENSE (the current addon's notice), the build stops with "ForeverLevelingBiS <version> is not MIT-licensed; the gear data stays as last built from an MIT version". Regenerate only when the JS is the reference; CI never runs the generator.

Since the JS command was retired, the generated files' first line names `forge data gear` instead of `node tools/polestar.js gear build`; expected/ is the JS output with that line (and the byte counts that include it) as forge writes it.
