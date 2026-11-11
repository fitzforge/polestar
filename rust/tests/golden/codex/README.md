# codex build golden (release build)

JS: a scratch copy of this checkout's `tools/` (rust-retire, a8f669093) and `tests/helpers/`, with `tools/lib/codex/build.js` and `pack.js` taken from next @ eb7b47840. The Rust port follows next's Codex: mailboxes, and the battlemaster spawns. This checkout's two files predate it; the other codex modules are the same in both.
Command: `node regen.js <that JS tree>`. It calls `buildCodex` the way `codex build --offline` does, with the inputs the test gives the Rust build:
- data: `../world/root/data/forever` plus `../professions/expected/professions.json`, in one folder;
- sources: `input/sources`;
- guides: `../guide/slice/forever`;
- version 0.2.6;
- no pack memory measure (`meta.pack.memoryKB` is null);
- no `--local-extras` build to compare with.

`builtAt` is the world slice's meta.json value.

Inputs:
- `sources/wago/1.60.1.70450` (the 16 tables the Codex reads) and `sources/wago/1.15.9.70003` (Item, ItemSparse, ItemEffect, Map): Blizzard client table rows, verbatim. `node slice.js <data/sources> input` cut them:
  - whole: SkillLine, Map, DungeonEncounter, LFGDungeons, MapDifficulty, ContentTuning, Mount, BattlePetSpecies;
  - AreaTable: the top-level areas plus the slice zones' sub-areas;
  - SkillLineAbility: First Aid, riding and companions;
  - items: the world slice's, the items of the gear golden's synthetic item list (from when the Codex read it), and the items that teach the first 10 mounts and pets and those skills' spells;
  - the spell rows those need.
- `root/data/codex/*.json`: copies of this checkout's curated tables (attunements, entrances, journal quests, rep gates). The Rust build reads them from its root; regen.js checks that they match the JS tree's.
- There is no web quest database cache (`sources/web`).

expected/: `codex/*.json`, `Polestar_Codex/*` and `warnings.txt`. Files over 64 KiB are gzipped (`<name>.gz`).

When the curated tables moved out of tools/ to data/codex/, the source names in `codex/meta.json`, `Polestar_Codex/Meta.lua` and `Polestar_Codex/LICENSE-DATA.txt` (which name each table's path) were updated by hand to the new paths, in the Rust and the JS builders alike; nothing else changed. A regen needs a JS tree with that move (its tables in `data/codex/`).

Test: rust/crates/forge-data/tests/data/codex.rs. It byte-compares every file.

Since the JS command was retired, the generated files' first line names `forge data codex` instead of `node tools/polestar.js codex build`; expected/ is the JS output with that line (and the byte counts that include it) as forge writes it.

When ForeverLevelingBiS left the Codex (2026-11), expected/ was rewritten by the Rust build (`FORGE_GOLDEN_BLESS=1 cargo test -p forge-data --test data codex::`): its synthetic item sources, their items and the source's notice went; nothing else changed. The Rust build is the reference now (the JS generators above predate the change), so later changes are blessed the same way and reviewed in the diff.

Spawn heights (#1024, blessed the same way): NPC and object places in `codex/npcs.json` and `objects.json` gained `z` from the world slice's spawnz.json, the pack records (Npcs, Objects, Rares, Treasures) their trailing `z` field, and `meta.json`'s pack bytes grew with them; nothing else changed.

Elites at objects (#1778): four objectives in `codex/quests.json` (an object to use or an item only objects give, among hostile elites in the world slice) gained `elites`, their Quests1 records the `w` fields, and `meta.json`'s pack bytes grew by those 49 bytes; nothing else changed.
