---
section: players
---
- A "Go to" step with a known height (a cellar's stairs, an upper floor)
  counts as reached only on its floor when the game tells Polestar how high
  you stand. When it doesn't (no height, a height of 0, or the same height
  wherever you walk), the step counts as reached within its radius on the
  map as in 0.4.1, and the arrow shows no "up" or "down" for it, so no step
  waits for a floor check the game can't answer. A bug report's Where line
  says which it is, and the Recorder notes it once a session.
