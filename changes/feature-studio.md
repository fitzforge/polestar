---
section: contributors
---
- `polestar studio` renders a feature as it looks in game without logging
  in: scripted scenarios (a character, a place, a guide some steps in, the
  bags, bars and party, then a ding, a hover or a party member's message) run
  the real addon on the test client, with spells, items and tooltips from the
  client's own tables and client art from a local cache that is never
  committed. `--serve` shows them on a local page that re-renders on every
  Lua change; `--checkout` renders another branch's worktree. See
  tools/README.md, "The Feature Studio".
