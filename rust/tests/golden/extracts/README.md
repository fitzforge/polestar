# CMaNGOS extracts golden

JS: a checkout of next at eb7b47840 (spawnz.json, quest_counts.json) and this worktree's tools/lib/travel/cmangos.js at 651ee7536 (= the sim-v2 m2a branch's; spawnz.2.json, training.json, gameobject_facts.json, graveyards.json, escort_paths.json).
Command: `node regen.js $POLESTAR_V1 <this checkout>` (calls the extractors on the dump's lines, serialized as each loader caches them).
Input: input/sources/cmangos/22b51464f162/classicdb.sql.gz, CMaNGOS classic-db (GPL-3.0, facts) rev 22b51464f162 cut by `node slice.js <full dump> <out> ../data/slice-ids.json`: CREATE TABLEs + rows of the extracted tables for the data slice's units/objects/quests, one class trainer per class with its trainer templates, graveyards whole, one escort path. The quest_template rows' text columns (Title, Details, Objectives, OfferRewardText, RequestItemsText, EndText, ObjectiveText1-4) are blanked (Title 'Quest'): no extract reads them.
transit.json (travel) is not covered here: travel reads the cached full extract.

quest_facts.json has no JS counterpart: it is the Rust extractor's own output (forge-data cmangos.rs extract_quest_facts, the public tier's CMaNGOS check), regenerated with `forge data extracts --sources input/sources --out <dir>` and reviewed by hand.

Test: rust/crates/forge-data/tests/extracts.rs (byte compare of every file in expected/). Regenerate only when the JS is the reference; CI never runs the generator.
