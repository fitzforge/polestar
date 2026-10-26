---
section: contributors
---
- guidecheck moved to forge: `forge guide check <dir>` (with `--json`, `--fix`,
  `--data`) reads written guides as a player would and gives each line that
  lacks what it needs its cheapest repair, with the same rules, messages and
  repairs; travel steps are left to the writer's travel pass in `forge build`.
  The toolchain no longer has an npm dependency (clingo-wasm is gone).
