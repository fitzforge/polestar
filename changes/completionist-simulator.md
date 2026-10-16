---
section: authors
---
- `sim run --objective completionist`: the simulator's completionist route
  (every eligible quest, elites included, in the least time) on its own world
  (`sim world --objective completionist`): each zone's quests in level tiers
  (a visit does every quest the character can take, the rest is a return
  visit), walked in 5-level slices, a 40-quest log, a return to a zone counted
  an hour, XP lost to grey quests charged as grinding time; a coverage report
  per zone with a reason for every quest it leaves out; `sim export` turns it
  into the Completionist pack's guides (packs/completionist, built and zipped
  with `pack packs/completionist`). docs/SIMULATION.md, "Completionist
  routes".
