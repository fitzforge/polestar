# golden/guide

Expected output of the JS compiler for `forge/tests/guide_parity.rs`. The Rust test compares every pack file and diagnostics.json byte for byte.

- Inputs:
  - `rust/crates/forge-guide/tests/fixtures/mini`: the committed mini fixture.
  - `slice/`: copies of Polestar's own guides from this checkout (GPL-3.0): pack.json, `forever/horde/orc-troll/01-durotar` and `02-the-barrens`, `forever/horde/02-the-barrens` and `forever/alliance/human/01-elwynn-forest`. Their comments and tips are in our own words, without site links or quotes (same line numbers as the originals). Three gotos come from the data slice's spawns at the place: Jasperlode Mine 61.5,54.1 (a Copper Vein and Kobold Miners), Burning Blade Coven 45.3,55.7 (Vile Familiars and Felstalkers), Skull Rock 55.0,9.8 (a Burning Blade Fanatic).
  - Data: `../world/root/data/forever`. Its `../sources` gives the area names.
- `expected/<name>/`: the output of `regen.sh`, which runs `rust/crates/forge-guide/tests/js-ref.js` (this checkout's tools/lib/dsl, rust-retire @ a8f669093) with `--data rust/tests/golden/world/root/data/forever`. Run it from the repo root; it is not run in CI.
- Since format 8 (mem/guides, #693), Polestar's own pack (both inputs compile as it) is written for memory by forge only: packed spawn spots and the faction parts `Polestar_Guides_Alliance` / `_Horde` (docs/PACK_FORMAT.md, "Format 8"), here `pack_Alliance` / `pack_Horde` beside `pack` (a part takes the out folder's name, as the pack folder does). The JS compiler never learnt it, so `expected/<name>/` is forge's output from then on (`forge guide compile --guides <input> --data rust/tests/golden/world/root/data/forever --out <dir>/pack --force --format json`, the parity test's own command); `regen.sh` would write the format-3 layout back.
- The slice data has no QuestieDB, so the slice guides compile with "not in data" errors. That is expected: the diagnostics are part of the parity check. The sim and judge goldens play this same slice.
