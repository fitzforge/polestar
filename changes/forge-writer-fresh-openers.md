---
section: forge
---
- The route writer reads the chain in the route's order: a guide v1's `next`
  links do not reach no longer sits after every guide they do. Silverpine
  (12-15) after the Barrens (15-21) left the Druids' Strange Lockbox step at
  12-15, before the Barrens' accept of Trial of the Sea Lion it is for
  (#1386). A step for a quest its players only take in guides they don't play
  is now gated `when onquest` instead of left as it was.
- Every guide stands on its own: the writer lists accepts in a guide's first
  10 steps that need a quest only an earlier guide hands in, which a player
  loading the guide fresh cannot take. `forge writer apply-route
  --fresh-openers move` takes each to the guide's later visit to its giver
  where there is one; `off` skips the check.
