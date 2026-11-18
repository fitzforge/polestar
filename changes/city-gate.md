---
section: contributors
---
- Walks in the six capitals can now be scored against players' recorded walks:
  `node tools/polestar.js nav city gate` (private recordings stay outside the
  repository).
  A replay that would load shipped trails now requires the training-only
  layer, so walkers held out for scoring do not influence the result.
  An NPC interaction matched to an unsupported floor is scored on the
  NPC's level when other players walked it at the interaction point.
