# dungeons build golden

JS: a checkout of next at eb7b47840 (next pipeline).
Command: `sh regen.sh $POLESTAR_V1 <scratch dir>` (`dungeons build --source input/ForeverDungeonJournal --data <copy of ../data/expected>`).
Input: input/ForeverDungeonJournal is synthetic (no DungeonJournal file): tests/fixtures/dungeonjournal's Test Mine plus a synthetic Ragefire Chasm, in DungeonJournal 1.6.0's layout.

Test: rust/crates/forge-data/tests/dungeons.rs (byte compare of every file in expected/). Regenerate only when the JS is the reference; CI never runs the generator.
