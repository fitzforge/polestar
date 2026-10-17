---
section: contributors
---
- CONTRIBUTING.md and the guide-fix skill say Guides.lua is only ever what
  compile writes, never a hand edit or a spliced hunk, and give a recipe for
  keeping only your change when your reference data differs from the branch's:
  compile the guides before and after it with the same data and git merge-file
  the difference into the committed file.
