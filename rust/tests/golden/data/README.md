# data build golden

JS: the release `data build` as it last stood before its deletion (rust-nojs at 0045325f6): next's pipeline plus the item rules (`dropScale`), spawn heights with respawn times and training.json it took over from m2a.
Command: `node regen.js $POLESTAR_V1` (buildData: offline, no QuestieDB, no web XP, no web zone lists, forever tables via wago CSVs, builtAt 2026-10-22T00:00:00.000Z). The input folder's absolute path in meta.json warnings is written as `<input>`.
Inputs (input/, cut by `node slice.js <data/sources> input`; zones Durotar 14, Elwynn 12, Ragefire Chasm 2437):
- pfQuest/ (MIT, shagu/pfQuest; LICENSE kept): units/objects spawning there, quests they start/end, their objective items/refloot, areatriggers, meta, enUS names; entries verbatim.
- sources/wago/1.15.9.70003, 1.60.1.70450: Blizzard client table rows (UiMap, UiMapAssignment, Faction, ChrRaces/ChrClasses/CharBaseInfo, Map whole; AreaTable top-level + the zones' areas; ItemSparse cut to the items; Item and SpellName cut to the ItemSparse ids).
- sources/cmangos/22b51464f162/spawnz.json, spawnz.2.json, training.json: CMaNGOS classic-db (GPL facts) extracts of ../extracts' dump slice (copies of ../extracts/expected).
- recordings/: Polestar's own synthetic sessions (a-d from tests/fixtures/data, e/f written for this golden).
- forever-db/corrections/<section>.json: synthetic entries in the corrections schema (values made up for the test); mechanics.json holds the mechanics correction (read by ../kb).
- data/mechanics-public.json: a synthetic, empty public mechanics layer.
slice-ids.json: the chosen ids (read by ../extracts/slice.js).

Test: rust/crates/forge-data/tests/data_build.rs (byte compare of every file in expected/). Regenerate only when the JS is the reference; CI never runs the generator.

Since rust-edits, corrections apply without QuestieDB (the JS skipped them), so expected/ is the JS output plus the slice's corrections, written by the Rust build (`FORGE_GOLDEN_BLESS=1 cargo test -p forge-data --test data_build`). The difference from the JS output is exactly the corrected records (quests 1919, 2861, 2936; NPCs 43, 5891; object 3239, each tagged `polestar-correction`), `counts.corrections` and one more era spawn point (NPC 5891's added map). The creation and unused rules are pinned by ../data-corrections.
