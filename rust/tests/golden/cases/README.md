# golden/cases

References for `forge-judge/tests/cases_parity.rs` `slice_parity`.

- `cases-{horde-orc-warrior,alliance-human-warrior}.json.gz` hold the dumps that the removed `forge-judge/tests/js/cases-dump.js` wrote (git history at 734380d2a):
  - the route's run index and raw actions;
  - the case actions (`caseActions`);
  - each reported case's `checkCase` result on the route, and on an empty route.
- The cases are `tests/fixtures/sim/cases/reported.json` (in the repo), for the route's faction.
- The route: the greedy v2 smooth2 route (`sim route --class Warrior --no-walks --offline`) of Orc and Human. It runs in the golden slice worlds (`../world/expected`; the JS keeps them, their hash checked) with `../sim/params.json`, on the data slice `../world/root/data`. The default zone plans in `tools/lib/sim/v2/zoneplans` apply. The routes end early (Orc at level 48, Human at 16) because the slice has only five zones.
- Map frames for the place checks: `../world/root/data/forever/map-frames.json`.
- The JS: the `tools/` of rust-retire @ a8f669093 (the JS route search was removed later; 734380d2a still has it). cases.js is unchanged. One patch goes into the temp copy that makes the route: `v2Setup` compiles only the `rules.json` rules that the slice world can check. The other 36 of 39 name quests the slice lacks, and compileV2 fails closed on them. The world still reads every rule, so it is not rebuilt. The route is only an input: the test checks Rust `case_actions` and `check_case` on the dumped route.
- Regenerate (not run in CI): `JS_ROOT=<a checkout at 734380d2a> rust/tests/golden/cases/regen.sh`. It works in a temp tree.

Not CI-provable: the cases on full-data routes. Most reported cases name quests outside the five slice zones, so here they hold vacuously or are null. Also routes with walks, which need the walking grid.
