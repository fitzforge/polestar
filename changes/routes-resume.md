---
section: forge
---
- A routes stage that dies part way (out of memory, a reboot, a kill) is
  resumed by the next `forge build` with the same inputs: each start's
  finished search is kept as soon as it is done, the free search saves its
  members every 2 minutes and the edit descent its edits, all under
  `out/.forge/routes-resume/` for the stage's key, and a rerun goes on from
  them to the same routes an uninterrupted run makes. `forge sim route`
  does the same beside its `--out` file. Checkpoints of other inputs or of
  another forge binary are never read.
