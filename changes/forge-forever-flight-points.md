---
section: forge
---
- `forge data travel` adds the flight points of the WoW Forever client: its
  TaxiNodes rows the Classic Era table lacks (kept by the same faction and
  character-bit rule, none it retired) and their flights from its TaxiPath
  and TaxiPathNode. Every Era node, flight and flight length stays as it was.
  A node on a map Forever added, which has no Era frame, carries `"l"` in
  TravelData.lua: its x, y are on the live frame. `forge data sources --only
  builders` fetches the Forever build's TaxiNodes and TaxiPath; without them
  the build warns and leaves the Forever flight points out.
