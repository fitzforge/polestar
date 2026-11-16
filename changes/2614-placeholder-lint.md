---
section: authors
---
- `forge guide lint` and `compile` fail on any of the game's placeholder names
  ("[DNT] Kill Credit", "Credit", "PvP Tower Credit Marker", "Trigger
  Ichman", "<UNUSED>", `[PH]`, `(DND)`) in a name or text a guide shows, and
  `forge data build` fails on any left in the quest data a player can read.
  A `kill` or `talk` on such a target is read by its quest-log line and named
  by its objective's words, not the placeholder (#2614).
