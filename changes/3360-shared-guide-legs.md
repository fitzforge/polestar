---
section: contributors
---
- `forge guide bake` bakes the legs of a leveling guide both factions share
  (Shen'dralas, Mount Hyjal) once per faction, each without the other
  faction's steps, and the build ships each faction's legs in its own race
  files; before, those guides got no baked legs at all. `legs.json` keeps a
  shared guide's legs under `sides` (#3360).
