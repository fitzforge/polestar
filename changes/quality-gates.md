---
section: forge
---
- `forge data diff` compares a data build with the live release's, NPC by NPC
  and quest by quest (spawn points, roles, faction, givers and enders, levels,
  prerequisites), and fails on what a release must never ship: an NPC on your
  side listed as a rare, a faction leader or capital NPC spread over the city,
  an NPC jumping to dozens of new points, a hand-in moving without a
  correction. The release and every data refresh run it.
- `rust/scripts/scenes.sh` plays the release zip through the situations every
  player meets (a capital, ten fights, a flight, a full quest log, the first
  run, an update from the last version, automation switched off) and counts
  the chat lines, sounds, alerts and automatic actions each brings, with the
  work each event costs. The release runs it before it is played in game.
