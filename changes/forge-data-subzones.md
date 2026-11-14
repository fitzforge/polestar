---
section: forge
---
- `forge data subzones` writes the walking maps' areas in each client
  language, as the game names the subzone there (`Subzones.lua` in the
  language folders, from the client's own WMOAreaTable and AreaTable at the
  client build the data is built from, stopping on data from another): run
  it after `forge nav pack` (#2244).
