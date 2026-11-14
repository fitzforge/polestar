---
section: forge
---
- `forge build` runs its routes stage to the end again in a checkout with a
  seed: it read the seeded copy of the guides (`.forge/input-guides`) under
  that folder's name, and the route writer, which looks each line up as
  `guides/forever/...`, stopped at the first written check ("no guide
  input-guides/..."). The routes name the guides' files as `guides/...` again,
  whatever the folder is called.
