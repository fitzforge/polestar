---
section: contributors
---
- The capitals scenes no longer stop on a Codex without friendly rares (the
  data build leaves them out since #2985): the minimap vignette goes to the
  city elite the client calls rare, the scene checks counts (no friendly
  Codex rare in a city), and it opens the Rares section and the rare pins in
  each city. `questdb_memory` builds the quest id list before the collector
  stops, so `read` no longer counts a doubling of Lua's string table
  (256 KiB) that the list's throwaway strings set off.
