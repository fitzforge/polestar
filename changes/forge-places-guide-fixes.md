---
section: forge
---
- Arrow points, roads, tips and level gates for the generated guides now
  live in two record files, `data/places.json` and `data/guide-fixes.json`,
  anchored on a quest's goal. `forge build` applies them every time it writes
  the guides, so a fix survives every new route; the fixes ledger says for each
  record whether it applied, and `forge data check-corrections` checks them.
  The eleven leveling-guide fixes merged since the guides were taken over
  (#646, #672, #674, #692) and #703's objective arrows are records now.
