---
section: forge
---
- `forge build --walks-serial` runs the walks stage's two passes (our grid's
  and Leffe's maps') one after the other instead of side by side, for about
  half the peak memory and the same walks; `--leffe-cache <MB>` sets the size
  of Leffe's decoded map cache there. With `--starts` one faction at a time,
  a route round fits a smaller memory budget.
