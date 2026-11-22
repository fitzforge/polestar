---
section: contributors
---
- `questdb_memory` settles Lua's string table one doubling above the addon's
  own strings before it measures, so `read` no longer jumps 256 KiB when the
  addon's string count drifts past a power of two.
