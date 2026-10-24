# golden/report

References for `forge-judge/tests/report_parity.rs` `report_equals_the_js_scripts_on_the_slice`: `forge judge report` against the route loop's JS scripts.

## Inputs (made by forge, in a temp tree)

- v1: the clean guide slice. That is `../guide/slice` with `../honest/drop.json`'s lines blanked, also written as the root's `guides/`.
- The root: `../world/root` plus an empty knowledge base. The base is synthetic: the tables forge reads, with no rows. The test runs without one, which reads the same.
- The sim dir: the golden slice worlds and `../sim/params.json`.
- `route/<race>.json` and `route/<race>.judge-improved.json.gz`:
  - They come from `forge sim route --faction F --start R --walks off` for Orc and Human (rust-retire @ a8f669093).
  - The route doc is cut to the two fields the report reads (`faction`, `start`).
  - The goal stream is the route's `judge-improved` stream, and the test puts it beside the route doc.
- `written/<race>/`: what `forge writer apply-route` rewrote in the clean slice (Orc: 3 guides, Human: 1). The test lays these files over a clean slice.

## References

- `<race>.ref.json` holds three parts:
  - `rows`: gmeasure.js for v1 and written, to 30 and 61.
  - `honest`: honest-sum.js, the fail findings of the race on the chain, from `honest-ref.js` with that tree's `playtest-honest.js`.
  - `stream`: sdiff.js, the order stream against the written walk.
- All of them ran on the v2-route judge tree @ 5af7bbbd6 (`git archive` of its `tools/` and `tests/helpers`), its `data/` the data slice. The JS kept the golden worlds (hash checked).
- `js/`: the scripts. They come from the route loop's scratch (gmeasure.js and honest-sum.js from its first round, sdiff.js from its second). The changes from those copies:
  - the judge tree and sim dir come from `JUDGE_ROOT` and `SIM`, not fixed paths;
  - sdiff.js prints `-` for an hour it never reaches;
  - sdiff.js and honest-sum.js write their numbers to `JSON_OUT`.
  The metrics are unchanged.
- Regenerate (not run in CI): `rust/tests/golden/report/regen.sh <v2-route checkout> [forge binary]`.

## Notes

- On the slice the written walk ends near level 16 (Orc) and 10 (Human), so the written walk never reaches level 30 (`h30` is null). The order stream reaches 30 only inside its final grind to 60. Its h30 therefore equals its h60, as the JS computes it.
- Writer bug: an earlier clean slice commented its dropped lines out (`# dropped: ...`) instead of blanking them. On that input, `forge writer apply-route` wrote the Fargodeep Mine step (collect 47, 60, complete 62) before the Goldshire step that accepts those quests. The route's own order had the accepts first. The written guides then failed to compile ("never accepted earlier"). With blank lines they compile. [INFERENCE: the writer treats a comment line inside a step as a block boundary.]

Not CI-provable: the r8 routes on the full data, and the checks (`checks: true`: the seed tests and lint on v1, see `../seed`).
