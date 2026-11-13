---
section: forge
---
- Forge reads the live WoW: Forever client (product `wowf`, folder
  `_forever_`) and falls back to the old beta product `wow_classic_beta`
  only when no `wowf` is installed. `forge doctor` no longer reports a game
  folder with `wowf` as having no Forever client; it marks the build it
  reads, and the grid build, `forge data build`, `forge data publish`,
  `forge gamedata` and `forge nav` pick the same product.
