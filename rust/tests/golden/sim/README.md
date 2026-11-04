# golden/sim

References for the forge-sim tests: parity.rs, plus fidelity, counters, props, overrides and feedback_guards through tests/common. `tests/wasm/run.sh` uses them by default.

- `params.json`: a copy of Polestar's own calibration (the main checkout's data/sim/params.json, made by JS `sim calibrate`).
- `v1-{horde-orc,alliance-human}-off.json.gz`: v1's chain on the guide slice (`../guide/slice`).
  - The chain is walked by the JS judge (`tools/lib/judge/walk.js` walkChain) on the data slice (`../world/root`).
  - It is then replayed event by event on the JS v1 evaluator in the golden slice world (`../world/expected`), with walks off.
  - This is the removed `forge-sim/tests/js/v1chain.js` run on committed inputs.
- `world-{horde,alliance}-v1.json.gz`: the golden slice world as v1's evaluator saw it, kept where the world golden has since changed (the Horde's TaxiPath prices; both factions' kill camps before the one-camp rule). tests/common loads it when present, so the v1 parity replays the world the JS reference ran in.
- Regenerate (not run in CI): `JS_ROOT=<a checkout at 734380d2a> node rust/tests/golden/sim/regen.js`. This checkout no longer has the JS judge.

Not CI-provable:
- Walks on, which needs walks-<faction>.bin, made from the walking grid (client geometry).
- Parity A: the JS v2 route's events.
