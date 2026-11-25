---
section: contributors
---
- The post-merge gates run `tests/perf.test.js` on its own with its timing
  budgets enforced, so a step change, guide open or catch-up over budget turns
  `next` red instead of leaving a warning nobody reads.
  `POLESTAR_PERF_WARN` lets a figure that is known to be over only warn while
  its issue is open (`burst`, #4066).
