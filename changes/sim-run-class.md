---
section: contributors
---
- `sim run` and `sim robust` take `--class` in any case, as `sim compare` and
  `sim bench` do: they passed it on as typed, so `--class priest` missed the
  class table and searched as if the Priest's own quests were not there, and
  a name that is not a class is now refused instead of doing the same.
