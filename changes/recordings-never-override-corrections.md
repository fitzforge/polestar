---
section: forge
---
- Players' recordings never override our corrections: the data build puts
  every corrected value back after the recordings overlay, lists each value
  the recordings disagreed with in its warnings, and the knowledge base ranks
  corrections above recordings. A correction's value is now copied into the
  record, so a later stage can no longer edit the correction itself.
- `forge record resession` re-reads every archived upload into the session
  files, so record kinds an older forge skipped (refusals, group size, spawns,
  gathering, failed quests) come back without a new pull.
- The recordings folder's `config.json` takes an `exclude` list of
  contributors the maintainer's audit rejected: their sessions never count and
  never make their cohort count.
