---
section: forge
---
- The data build trusts recordings from the recording server more carefully:
  a spawn, a learned path, a drop chance, a quest's XP or a class trainer
  needs two players, and a player counts only once established: first seen
  3 days before their newest recording, 20 chunks sent, and real play
  (recordings on 3 different days, 2 hours in all, with positions and kills;
  `minContributorDays`, `minContributorChunks`, `minContributorPlayDays`,
  `minContributorHours`, `minContributorPos` and `minContributorKills` in
  `data/recordings/config.json`). Players registered from the same network
  on the same day count as one, and so does one player on many installs.
  Each needs 10 kills of their own behind a drop chance. Drop chances, quest
  XP and the calibration's kill pace are the median of each player's own
  value, so one player farming for hours can't pull them.
- `forge record import` of a file someone sent in needs `--vouch <name>` (it
  counts as that player) or `--anonymize` (it only fills gaps).
- `forge record pull` keeps each contributor's recordings apart, so nobody
  can overwrite another player's by reusing their install id, and removes
  the recordings of contributors who deleted their data or were blocked.
