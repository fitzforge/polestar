---
section: forge
---
- `forge data gear` builds from release-safe sources only: Forever's item
  stats from the Forever client's tables (`--build`, the cached wago.tools
  tables, with the rows the server pushed, exported by `forge gamedata hotfix`
  into `data/sources/hotfix/<build>/`), racial traits from the client's
  racial spells, and which quests reward which gear from the Codex
  (`data/forever/codex`, sources only a local extra names left out). The
  ForeverLevelingBiS importer, its `--addons` input and its fixtures are gone.
