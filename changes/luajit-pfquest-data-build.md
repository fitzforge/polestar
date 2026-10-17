---
section: contributors
---
- `data build` works with LuaJIT, the Lua the setup steps suggest on Windows
  and macOS: LuaJIT allows one function 65536 constants, fewer than pfQuest's
  `db/units.lua` holds, and the loader now splits such a file so it loads.
  When a file still cannot load, the error says to set `LUA` to a Lua 5.1
  interpreter.
