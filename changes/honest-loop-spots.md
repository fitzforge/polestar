---
section: authors
---
- `polestar playtest --honest` no longer reports "nothing there drops it"
  for a `loop` step's `collect` whose source stands at a later spot of the
  loop than the first (Gordo's Report in Tirisfal Glades): it checks every
  spot, as `forge judge` does (thanks neopterygii).
