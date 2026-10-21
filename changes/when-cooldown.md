---
section: authors
---
- `when cooldown item 6948` makes a step depend on a cooldown: it applies
  while the Hearthstone (or any item, or a spell with `cooldown spell <id>`)
  is cooling down, and `when !cooldown item 6948` while it is ready. The
  global cooldown does not count, and Polestar looks again when the cooldown
  runs out. A pack using it is written in pack format 5 (Polestar 0.3.0).
