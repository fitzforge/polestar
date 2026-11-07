---
section: players
---
- The arrow uses much less memory and CPU on long walks: when you ride off
  the drawn line, the walking router now reuses its work between searches,
  asks for the walk again less often, and near the target measures only your
  own walk again instead of every flight master's. A long walk off the line
  makes about a fifth of the garbage it did in 0.3.4, which is what pushed
  Polestar_Nav's AddOn Memory figure up.
