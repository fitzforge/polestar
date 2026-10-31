---
section: forge
---
- `forge record import` and `forge record pull` bring the Recorder's new
  chunked recordings into `data/recordings` (from this PC's game, a file a
  player sent in, or the recording server), with no character names, realms
  or account names. `node tools/polestar.js record import` and `record watch`
  are retired. The data build trusts other players' recordings only where it
  should: a spawn, a learned path or a drop chance replaces another source's
  only when two players saw it, and names from non-English clients never
  replace English ones. After a pull has stored everything, it tells the
  server, which then deletes those chunks after two weeks.
