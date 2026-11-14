---
section: forge
---
- When the pack check refuses a tree the route writer wrote, every error it
  found is in `<tree>.pack-errors.txt` beside the tree (forge build's written
  check: `out/.forge/flow/<start>.pack-errors.txt`; apply-routes:
  `<out>/<start>.pack-errors.txt`), and the routes stage names every start
  the writer refused, not only the first. The message itself still names five.
