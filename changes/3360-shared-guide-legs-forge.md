---
section: contributors
---
- `forge guide bake` bakes a leveling guide both factions share once per
  faction, each without the other faction's steps; `legs.json` keeps its
  legs under `sides`, the compiler checks each side's hash and ships each
  side in its faction's race files, and a release names such a guide as
  unbaked until it has them (#3360).
