---
section: authors
---
- `when dungeon "<Name>" all` marks a step of a dungeon's every-quest route:
  the dungeon's quests off the way (a detour, a flight, another hub). A
  character who runs the dungeon takes them unless they chose "Only quests on
  my way" for it; plain `when dungeon` steps are the quests on the way.
  `!dungeon` takes no `all`. The compiler copies a run's `allQuests` minutes
  and XP from data/dungeon-runs.json into the guide that holds the run
  (`dungeonAll`), so the guide window can say what the opt-out saves.
