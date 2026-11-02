---
section: forge
---
- `forge build` no longer searches every route again after a late failure.
  The extra walk pairs a routes stage adds (the legs it priced with no walk)
  are walked in the same build and the routes written again on them from the
  same search, and the search key leaves those pairs out: a search is kept
  while they only grow, and run again only when one it ran with is gone. A
  c14 build that failed in its report grew 60 pairs, and its rerun searched
  for 45 minutes again.
- The writer checks every guide tree it writes as the pack and refuses one
  the pack check would (`the pack has errors:`), so a bad line (c14's bare
  `tip` in the Night Elf Teldrassil guide) stops the routes stage at its
  first write instead of the report 45 minutes later.
