---
section: forge
---
- `forge release credits` also writes the translators (every locale's
  `translators`, with its locale and language, from the same list as the
  locale tooling) and the ideas (`data/credits.json` `ideas`:
  `{ "name", "ref" }`, someone whose idea shipped without their pull request
  merging) to `Core/Credits.lua`. `forge i18n` lists the languages as
  interface keys, so the page shows each in the player's language
  (docs/forge/release.md, "The credits").
