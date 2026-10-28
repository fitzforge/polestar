---
section: forge
---
- `forge build` reads the Forever client tables (zones, map frames, races,
  factions, items) at the build its walking grid was built from, from a copy
  saved under `data/sources/client-tables/<build>/`, not from whatever client
  is installed. Uninstalling the beta client quietly switched the zones and
  map frames to Classic Era's (Zephras Isle gone); now a build reads the same
  tables whatever you install. `--forever-tables client` refreshes the copy
  from an installed client at that build, `--forever-tables wago` reads the
  wago.tools cache; the log names the source and build, and tables of another
  build stop the build unless `--allow-build-mismatch`. `--until data` stops
  after the data stage. `forge doctor` says whether the grid's build is saved.
