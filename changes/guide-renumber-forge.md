---
section: forge
---
- `forge guide renumber` gives the leveling guides ids in the order players
  get them: `--plan` writes the table from the guides' route and titles,
  `--map` applies it in one go (files moved with their translations and seed
  copies, every reference rewritten, `guides/renamed.json` written for the
  players' saves), with a dry run that lists every change (docs/FORGE.md,
  "Renumbering the guides").
