---
section: contributors
---
- The tests now load the committed `addon/Polestar_Guides/Guides.lua` the
  way the game does and fail when it differs from what `compile` writes: a
  goal outside its step's `goals`, a goal of no known kind, or a guide whose
  steps, goal kinds and quests do not match its `.guide` file. A hand-spliced
  Guides.lua could break that and still load without an error, and the game
  never showed those goals. Needs no reference data, so CI runs it.
