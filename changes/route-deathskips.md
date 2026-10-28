---
section: forge
---
- `forge build --deathskips` (and `forge sim route|shared|widen --deathskips`,
  off by default) plans deathskips: through level 10, a leg may die at a camp
  of mobs within 400 yards and go on from the graveyard the game sends that
  death to, where that beats the leg by 30 seconds. The world build has the
  graveyard table for it (each faction's graveyards, the zones linked to them
  and their Spirit Healers), and the guides write each one as a `die` step.
