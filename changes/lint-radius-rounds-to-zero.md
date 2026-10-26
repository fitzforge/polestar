---
section: authors
---
- Lint refuses a radius below 0.005 (`kill 6 r 0.004`): the pack writes it with
  two decimals as `r = 0`, which the addon refused at load ("bad radius").
