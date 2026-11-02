---
section: forge
---
- A writer or judge change no longer searches every route again: the routes
  stage keeps its finished searches in `out/.forge/routes-search/` under a
  key of what the search reads and the planner's own code (a hash of
  forge-sim and the crates it is built from, not the forge binary), and
  reuses them, running only the check on the written guides again. The log
  names the searches it reused. A finished search now keeps its hub batches,
  so a route finished from it undoes them under the written check as the
  search itself does.

The key walk (`files_under`) now visits each real directory once and in sorted order. A link
back up the tree (`data/sources/sources -> data/sources`) made it walk ~40 levels of copies and
hash them under a different set each build, so the data, world and routes keys never matched.
