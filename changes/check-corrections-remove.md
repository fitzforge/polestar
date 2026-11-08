---
section: contributors
---
- `forge data check-corrections` no longer reports a `remove: true` quest
  correction as "no quest in the data": the build itself takes that quest
  out, so its absence is the record working. A correction that sets fields
  on a missing quest, or links to a removed one, is still an error.
