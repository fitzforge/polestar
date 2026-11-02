---
section: forge
---
- `forge guide compile` and `forge release pack` now quote any table key that
  is not a plain Lua identifier, as the JS compiler has since #750. Keys that
  are plain identifiers are written as before.
