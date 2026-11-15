---
section: authors
---
- `loop` now places a `skill` goal on the step's `goto` points too, so a
  gathering round is searched point by point as a kill or collect is. In a
  step with no kill, collect, interact or skill goal it places the `accept`,
  `turnin` and `talk` goals instead: the arrow leads along the points until
  the player meets a quest giver who walks. (thanks DomGrieco)
