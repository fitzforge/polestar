---
section: contributors
---
- The danger gate (`node tools/danger-gate.js`) reads the recordings archive
  (`--archive <dir>`, the session files) and takes players' word for who is a
  threat: an NPC players met as friendly and never as hostile, or one nobody
  has ever met where the data places it although 15 or more people passed its
  spawns on foot, no longer counts around a goal; one players met as hostile,
  or that killed one of them, counts even where the data has it friendly. The
  data's side of an NPC is the side it serves, empty for hostile mobs but also
  for friendly-to-both NPCs that sell nothing, for many of Forever's new NPCs
  and for templates placed where the game has none, so level-60 Pack Mules on
  the Lakeridge Highway, the Territorial Terrans of the Stormrage Barrow Dens
  or town criers and city NPCs were flagged as camps of mobs 30 to 50 levels
  over the route. The gate lists what the census settles, and the baseline
  drops 95 rows that no longer flag. The Infernal the quest data placed in the
  starting zones and capitals (npc 278863) has no spawns any more: no player
  has ever met it there (#1575).
