---
section: contributors
---
- A pull request that changes a guide now commits the recompiled guides and
  their translation files (`forge i18n guides sync`, then `forge guide
  compile`) with the change, so `next` never waits for a recompile after a
  merge (CONTRIBUTING.md, "Fixing a guide").
