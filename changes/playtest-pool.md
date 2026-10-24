---
section: contributors
---
- `playtest` (and `tests/guides.test.js`) plays on a pool of long-lived
  lua5.1 processes, each play in a fresh environment, several at once
  (`POLESTAR_PLAY_WORKERS`, default up to 8): the full playtest set gives the
  same results as one process per play, about four times faster.
