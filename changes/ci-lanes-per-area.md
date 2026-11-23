---
section: contributors
---
- CI runs what a pull request changes: a guide, addon, data or test-file
  change takes forge from the cache and runs only the Node tests it can
  break, and the addon's Lua tests run in four shards from cached test
  binaries; Rust is built and tested only when Rust changes (#3310).
