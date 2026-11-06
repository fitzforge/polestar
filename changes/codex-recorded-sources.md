---
section: forge
---
- `forge data codex` no longer reads ForeverLevelingBiS or any installed addon
  for a release build. It reads the item sources players' recordings show
  from the committed snapshot `data/codex/recorded.json` (only players the
  data build counts; `--recordings <dir>` rewrites it from a recordings
  folder), and a collectible guide's `buy` step names the item's vendor.
  `forge release pack` refuses a Codex that still names ForeverLevelingBiS.
