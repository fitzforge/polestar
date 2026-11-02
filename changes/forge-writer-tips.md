---
section: forge
---
- `forge writer apply-route` writes where-notes and walk notes on goals (R9,
  `--no-tips`), `Careful:` tips from the quest notes (R10, `--no-warnings`),
  and `when onquest` on the hand-ins of quests picked up on the way (R3).
  `forge data build` writes `moves.json` (classic-db creature walks), and the
  compiler gives a walking NPC's goal its walk as its spawn spot.
- A grind top-up the route inserts (a `level` item with no v1 line) is written
  as a step of its own at the route's point, `when level<N.FF`, with a tip
  naming the hand-ins it tops up for.
