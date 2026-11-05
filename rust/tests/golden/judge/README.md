# golden/judge

References for `forge-judge/tests/judge_parity.rs` and `judge_simlevels.rs`.

- `<case>.json.gz`: the dumps that the removed `forge-judge/tests/js/judge-ref.js` made (git history at 734380d2a): chain, goals, passed by, returns.
  - Cases: orc61, orc12, human61 and human10, all Warrior.
  - They come from the JS judge `judgeWalk` of the v2-route branch @ 5af7bbbd6 (its `tools/` and `tests/helpers` taken with `git archive 5af7bbbd6` into a scratch folder, given as POLESTAR_JS).
  - Inputs: the guide slice (`../guide/slice`) and the data slice (`../world/root`). The sim world is the golden slice world with `../sim/params.json`. There is no grid, so no subzones.
  - File names are relative to the guide slice.
- Regenerate (not run in CI): `POLESTAR_JS=<checkout of v2-route> node rust/tests/golden/judge/regen.js`.
