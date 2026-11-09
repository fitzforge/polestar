---
section: authors
---
- `polestar export` writes a v2 import string (`!PS2!`): it carries the guide
  as you wrote it, so Polestar Studio can open it and `polestar decode` can
  write it back, and holds up to 250 steps and 300,000 characters. Players
  need Polestar 0.3.7; `export --v1` writes the older string (60 steps) that
  earlier versions read.
