---
section: contributors
---
- `data/recorded-unlocks.json` lists quests that players' recordings show
  offered only right after a hand-in and refused, by gossip window, to at
  least three people who hadn't handed any of those in (counts of people
  only). The prerequisite-order check in `tests/guides-reported.test.js`
  plays every leveling path with them as extra prerequisites, so a guide
  that accepts such a quest too early fails even when the quest data names
  no prerequisite (#1299: This Land Was Their Land before Defeat Nek'rosh).
