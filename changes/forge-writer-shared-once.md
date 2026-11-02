---
section: forge
---
- `forge build` writes each faction's shared guides once for all its starts
  (the canonical start's run and every race's and class's own ways), not
  once per start: the guides stage and the routes stage's check on the
  written guides take about a fifth of the writer time they did, with the
  same guides. `POLESTAR_BUILD_TIMES=1` prints where a build spends its time
  (each start's search, post passes and check rounds, the writer's parts)
  and keeps it in `<out>/.forge/timings-<stage>.json`.
