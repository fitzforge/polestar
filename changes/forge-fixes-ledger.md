---
section: forge
---
- Every build applies the fixes of one checkout and says so: corrections,
  public mechanics and route fixes (data/route-fixes.json, now read at run
  time instead of built into forge) come from the checkout being built, and
  fixes.md lists the commit of each input and every fix record as applied,
  redundant, unused, stale, left out or undone; forge build --strict fails on
  the ones that no longer apply.
