---
section: contributors
---
- The prerequisite-order check in `tests/guides-reported.test.js` also takes
  the prerequisites players' recordings teach (`data/recorded/quests.json`,
  from `forge record learn`): an accept needs one of them, or one of the
  quest data's own prerequisites, handed in first. A guide that takes such a
  quest too early now fails even when the quest data names no prerequisite
  (#1299: This Land Was Their Land before Defeat Nek'rosh). A quest whose
  prerequisites a correction sets keeps the correction's.
