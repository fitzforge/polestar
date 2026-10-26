---
section: forge
---
- Releasing the addon moved to Forge: `forge release version`, `forge release
  pack` (the release zips and SHA256SUMS, now byte-identical on every
  machine), `forge release notes`, `forge release credits` and `forge
  changelog add|check|show|build`. The old `version`, `changelog`, `release`
  and `credits` commands print the forge command instead, and CI checks the
  changelog fragments with `forge changelog check`.
