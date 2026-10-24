# golden/engine

References for `forge-judge/tests/engine_parity.rs` (`slice_*`) and `engine_rilua.rs` (`slice_orc_warrior_chain`).

- `orc.json`, `human.json`: the trace `forge-judge/tests/js/engine-chain.js` writes ({ files, trace, level, ms, luaMs }). It is this checkout's addon on `tests/lua/stub_world.lua`, through playtest.js's SIMULATE, in lua5.1, with each stuck step skipped. It plays the Orc and the Human Warrior chain from `forever/horde/orc-troll/01-durotar` and `forever/alliance/human/01-elwynn-forest` through `next`.
  - Guides: the clean guide slice, which is `../guide/slice` with `../honest/drop.json`'s lines blanked. The raw slice has compile errors on the slice data, so its pack holds no guide to play.
  - Data: `../world/root/data/forever`.
- `fx-warrior.json`, `fx-mage.json`: the same for engine_parity.rs's fixture guides (FIXTURES: skipto, when, only, along on Northshire quests), on the data slice.
- `rilua-orc/`: `engine-program.js`'s Lua program of the Orc chain: `program.lua`, the compiled pack (`pack/`) and `files.json`. The repository and pack paths are written as `@REPO@` and `@PACK@`, and the test fills them in. rilua plays it against this checkout's addon files. Its trace must equal both the Rust replay and `orc.json` (lua5.1).
- The JS and the addon: this checkout (rust-retire @ a8f669093).
- Regenerate (not run in CI): `rust/tests/golden/engine/regen.sh`. It needs node, lua5.1 and cargo, and writes the fixtures through engine_parity's `fixtures_*` tests.

Not CI-provable: the shipped and v2 chains on the full data (most of their quests are outside the slice), and the goal lines dropped from the clean slice.
