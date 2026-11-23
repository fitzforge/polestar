---
section: authors
---
- Dungeon runs in leveling guides: lint counts a `when dungeon` step's goals,
  and those of quests accepted only there, as a party's work like `when
  group` (its elite kills are no longer errors), and a hand-in behind `when
  complete` or `when onquest` as no solo work. `polestar playtest --dungeon
  "<Name>"` plays the guides as a character who chose those dungeons, and the
  honest playtest no longer plays `when dungeon` steps for one who chose
  none; it also credits a `talk <npc> quest Q.O` line's objective, so those
  turn-ins no longer read as unfinished. docs/GUIDE_FORMAT.md, "Dungeon
  steps", shows a run's three parts.
