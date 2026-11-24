---
section: contributors
---
- Every merge into next runs the gates that need the merged tree on the
  release data: the whole Node suite, guide lint, all the addon's Lua tests,
  playtest, the route-speed gate and the arrow's cadence and stretch gates.
  A failing gate turns the badge in docs/CI.md red and files an issue
  (#3310).
