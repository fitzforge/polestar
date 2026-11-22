# Changelog

All notable changes to this data set. The format follows Keep a Changelog
(https://keepachangelog.com/en/1.1.0/); versions are CalVer (YYYY.MM.N).

## [2026.11.2] - 2026-11-21

This release follows 2026.11.1.

`quest_objective` loses 903 rows and gains 525. Most of the loss is one rule: a quest's starting
item, or the item an NPC hands over for the quest, is no longer counted as one of its objectives.
Those quests now list only their real objectives, or none, so "quests with objectives" falls from
4,184 to 3,817. A quest's own starting item is still in `quest_start`. The other removed rows
belong to quests that are not in the game on Forever (now removed), objective lists rewritten by
a correction or by players' recordings, objectives no independent source holds, and later rows of
a quest renumbered after an earlier row went. The schema is unchanged.

Compared with release 2026.11.1.

### Added

- item: 2580 rows
- mechanic: 2 rows
- npc: 2079 rows
- object: 296 rows
- quest: 685 rows
- quest_end: 718 rows
- quest_objective: 525 rows
- quest_prereq: 740 rows
- quest_start: 639 rows
- spawn: 14762 rows
- step: 7 rows

### Removed

- mechanic: 4 rows
- npc: 8 rows
- quest: 5 rows
- quest_end: 51 rows
- quest_objective: 903 rows
- quest_prereq: 1 rows
- quest_reward: 1 rows
- quest_start: 83 rows
- spawn: 3265 rows
- step: 1 rows

### Changed

- item.name: 84 values
- item.quest_item: 7 values
- mechanic.params: 1 values
- npc.level_max: 1177 values
- npc.level_min: 1203 values
- npc.name: 26 values
- npc.rank: 175 values
- npc.subname: 13 values
- object.name: 1 values
- quest.classes: 18 values
- quest.level: 32 values
- quest.min_level: 124 values
- quest.races: 56 values
- quest.repeatable: 10 values
- quest.side: 27 values
- quest.title: 16 values
- quest.xp: 447 values
- quest.zone_area: 11 values
- quest_objective.count: 144 values
- quest_objective.kind: 230 values
- quest_objective.target: 194 values
- quest_prereq.breadcrumb: 1 values
- quest_prereq.mode: 23 values
- spawn.x: 10254 values
- spawn.y: 10296 values
- spawn.z: 4692 values

### Coverage

- quests published: 5967 of 6093 (97.9%)
- quests with giver: 5694 of 6093 (93.5%)
- quests with turn-in: 5715 of 6093 (93.8%)
- quests with objectives: 3817 of 6093 (62.6%)
- quest title: 5953 of 6093 (97.7%)
- quest level: 5940 of 6093 (97.5%)
- quest min_level: 5747 of 6093 (94.3%)
- quest races: 5965 of 6093 (97.9%)
- quest classes: 5965 of 6093 (97.9%)
- quest side: 5967 of 6093 (97.9%)
- quest xp: 4862 of 6093 (79.8%)
- quest zone_area: 4287 of 6093 (70.4%)
- quest type: 4603 of 6093 (75.5%)
- quest money_copper: 815 of 6093 (13.4%)
- quests with prerequisites (known chain links): 3325 of 3370 (98.7%)
- npcs published: 15310 of 15830 (96.7%)
- npc faction_template: 10758 of 15830 (68.0%)
- npc level: 12925 of 15830 (81.6%)
- npcs with spawns (of npcs with a known spawn): 9441 of 9478 (99.6%)
- objects with spawns (of objects with a known spawn): 6963 of 7034 (99.0%)
- items with drop sources (of items with a known dropper): 1771 of 10815 (16.4%)

### Not published (no independent source holds the value)

- npc.name: 1 values
- quest.classes: 2 values
- quest.end: 69 values
- quest.level: 11 values
- quest.min_level: 11 values
- quest.objectives: 21 values
- quest.races: 2 values
- quest.start: 126 values
- quest.title: 11 values
- quest.xp: 69 values

## [2026.11.1] - 2026-11-02

Rows per table.

### Rows

- quest: 5287 rows
- quest_start: 5407 rows
- quest_end: 5134 rows
- quest_objective: 6338 rows
- quest_prereq: 3811 rows
- quest_reward: 6200 rows
- npc: 13239 rows
- object: 10437 rows
- spawn: 88761 rows
- item: 23344 rows
- item_source: 38105 rows
- ui_map: 59 rows
- mechanic: 3401 rows
- step: 2409 rows
- note: 0 rows

### Coverage

- quests published: 5287 of 5408 (97.8%)
- quests with giver: 5184 of 5408 (95.9%)
- quests with turn-in: 5066 of 5408 (93.7%)
- quests with objectives: 4184 of 5408 (77.4%)
- quest title: 5284 of 5408 (97.7%)
- quest level: 5279 of 5408 (97.6%)
- quest min_level: 5277 of 5408 (97.6%)
- quest races: 5286 of 5408 (97.7%)
- quest classes: 5283 of 5408 (97.7%)
- quest side: 5287 of 5408 (97.8%)
- quest xp: 4293 of 5408 (79.4%)
- quest zone_area: 3915 of 5408 (72.4%)
- quest type: 4604 of 5408 (85.1%)
- quest money_copper: 815 of 5408 (15.1%)
- quests with prerequisites (known chain links): 2795 of 2877 (97.1%)
- npcs published: 13239 of 13660 (96.9%)
- npc faction_template: 10757 of 13660 (78.7%)
- npc level: 11212 of 13660 (82.1%)
- npcs with spawns (of npcs with a known spawn): 8539 of 8602 (99.3%)
- objects with spawns (of objects with a known spawn): 6683 of 6714 (99.5%)
- items with drop sources (of items with a known dropper): 1771 of 9441 (18.8%)

### Not published (no independent source holds the value)

- npc.name: 7 values
- npc.npc_level: 90 values
- quest.classes: 4 values
- quest.end: 31 values
- quest.level: 6 values
- quest.min_level: 6 values
- quest.races: 1 values
- quest.start: 8 values
- quest.xp: 65 values

## [2026.10.1] - 2026-10-24

First release.

### Added

- quest: 5287 rows
- quest_start: 5367 rows
- quest_end: 5099 rows
- quest_objective: 6340 rows
- quest_prereq: 3811 rows
- quest_reward: 6200 rows
- npc: 13239 rows
- object: 10437 rows
- spawn: 88645 rows
- item: 23344 rows
- item_source: 38105 rows
- ui_map: 59 rows
- mechanic: 3398 rows
- step: 2409 rows
- note: 0 rows

### Coverage

- quests published: 5287 of 5408 (97.8%)
- quests with giver: 5147 of 5408 (95.2%)
- quests with turn-in: 5033 of 5408 (93.1%)
- quests with objectives: 4186 of 5408 (77.4%)
- quest title: 5284 of 5408 (97.7%)
- quest level: 5279 of 5408 (97.6%)
- quest min_level: 5277 of 5408 (97.6%)
- quest races: 5286 of 5408 (97.7%)
- quest classes: 5284 of 5408 (97.7%)
- quest side: 5287 of 5408 (97.8%)
- quest xp: 4293 of 5408 (79.4%)
- quest zone_area: 3915 of 5408 (72.4%)
- quest type: 4604 of 5408 (85.1%)
- quest money_copper: 815 of 5408 (15.1%)
- quests with prerequisites (known chain links): 2795 of 2877 (97.1%)
- npcs published: 13239 of 13660 (96.9%)
- npc faction_template: 10757 of 13660 (78.7%)
- npc level: 11126 of 13660 (81.4%)
- npcs with spawns (of npcs with a known spawn): 8539 of 8602 (99.3%)
- objects with spawns (of objects with a known spawn): 6683 of 6714 (99.5%)
- items with drop sources (of items with a known dropper): 1771 of 9441 (18.8%)

### Not published (no independent source holds the value)

- npc.name: 7 values
- npc.npc_level: 90 values
- quest.classes: 3 values
- quest.end: 43 values
- quest.level: 6 values
- quest.min_level: 6 values
- quest.races: 1 values
- quest.start: 30 values
- quest.xp: 65 values
