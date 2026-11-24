---
section: players
---
- Smoother frames while the arrow finds a walk on a busy machine: the walking
  search now takes only what your game's frame leaves free, so it no longer
  turns a full frame into a dropped one (with the game at 15 ms a frame, the
  search pushed every frame it ran in past 16.7 ms; now, in our testing,
  about 1 in 100). A new goal still gets its route in a few seconds.
  `/polestar perf` now names the timers and calls it showed as "?", and says
  what else happened in a slow frame no handler accounts for (thanks Fitz,
  #3640).
