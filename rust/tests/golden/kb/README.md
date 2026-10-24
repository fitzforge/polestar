# data build --kb golden (sim-v2 pipeline, knowledge base)

JS: a scratch copy of the sim-v2 m2a checkout's `tools/` and `tests/helpers/` (809b246e1). The knowledge base (tools/lib/data/kb.js) and the m2a data build exist only there. The m2a checkout itself is only read, never written.
Command: `node regen.js <that copy>`. It builds in a scratch root that it assembles from the inputs below. The test assembles the same layout. Details:
- builtAt 2026-10-22T00:00:00.000Z; offline;
- no QuestieDB, no web XP, no web zone lists;
- the root path is written as `<root>`, and ../data/input as `<data>`.

Inputs. They are the data golden's (`../data/input`: pfQuest, client table slices, recordings, corrections, data/mechanics-public.json) plus:
- `../extracts/expected/*`: the CMaNGOS classic-db caches of the same slice (GPL facts), read as `sources/cmangos/22b51464f162`.
- `../trainers/expected/trainers.json`: the trainers.json the knowledge base adds to.
- `input/sources/forever-tdb/extract.json`: the Forever TrinityCore world DB extract (advocaite/TrinityCore `forever`, GPL-2.0, used as facts).
  - Quests, spawns, names, loot, vendors and trainers are cut to the data slice's ids.
  - The class training tables are whole.
  - There is no world.sqlite.
- `input/sources/eg-link/d98f94821b69/`: the EG Link output (Efficient Games, CC BY 4.0). index.json is cut to the three newest builds, and their datasets are cut to the slice's quests, units, objects and items.
- `input/sources/wago/`: QuestXP.csv (Era) verbatim; Forever Item.csv and SpellName.csv cut to the items and the extract's training spells.
- `input/local/`: synthetic files written for this golden. They are quest-mechanics.json, quest-steps.json, web-verdicts.json and forever-tdb/analysis/mechanics.json, for a few slice quests. Between them they cover: kinds kept by two sources, a TDB-confirmed kind, a TDB-refuted kind, a web-refuted kind, a TDB-added kind, a low-confidence param, steps and gotchas.
- `input/sim/world-{horde,alliance}.json`: synthetic quest lists (the sim-v2 world's quests).
- Not read: facts.sqlite, forever-vo, QuestieDB, web quest-database pages.
- `slice.js <data/sources> input` cut input/sources.

expected/:
- the data files, including trainers.json only when the knowledge base changed it;
- `verify-in-game.json`;
- `kb-rows.txt`: every row of the KB sqlite as `<table>\t<JSON array>`, with tables in creation order and rows by rowid.

Files over 64 KiB are gzipped.

Test: rust/crates/forge-data/tests/kb.rs. It compares byte for byte, and dumps the Rust KB sqlite the same way. Regenerate only when the JS is the reference; CI never runs the generator.

Since the JS reference, the Rust KB has moved on in ways the expected files record (re-blessed with `FORGE_GOLDEN_BLESS=1`):
- the `sources` rows for the client tiers (client, client.cache) and the check-only alternatives (cmangos, tdb.inherited, eg.objectives, factoruide.web), with their `alternatives` rows;
- inherited TDB objective counts are filled through the alternatives (the same 52 `changes`, earlier in rowid order), so meta.json's `tdb.countsFilled` is 0;
- the `steps` table's source and evidence columns.
The m2a JS reads mechanics corrections from corrections.json's `mechanics`: for a regen, put forever-db/corrections/mechanics.json back there in the scratch root.
