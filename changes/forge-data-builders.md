---
section: forge
---
- The data builds moved to forge, and their JavaScript is gone: `forge data
  sources` downloads what they read into `data/sources` (the client tables,
  pfQuest at a pinned commit, EG Link, forever-vo, the CMaNGOS dump, web quest
  XP); `forge data build` fetches first unless `--offline` and stages each build
  behind the statistics gate (`--accept`), which `forge data check` reruns;
  `forge data itemdb`, `forge data talents build|check` and `forge data maps
  build|overlays` write the same files the JS did. `polestar data`, `dungeons`,
  `trainers`, `itemdb`, `talents`, `maps`, `gear build`, `codex build` (the
  release build) and `profession build` print their forge command and exit 2.
- `forge data codex --local-extras` builds the local comparison Codex (with
  the installed AtlasLoot, RareScanner and `dungeons.json`) into
  `data/local/codex-extras`, byte for byte as the JS build did; `polestar codex
  build --local-extras` now prints that command and exits 2.
