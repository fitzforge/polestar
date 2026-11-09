---
section: forge
---

- `forge release pack` stops when a guide changed since its walking legs were
  baked, naming each such guide, instead of shipping them without legs.
  `--bake` (with `--grid` and `--leffe` for the maps `guides/legs.json` was
  baked on) bakes just those guides, updates `legs.json` and its
  `GENERATED.json` hash, then packs.
