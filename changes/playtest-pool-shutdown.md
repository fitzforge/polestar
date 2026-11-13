---
section: contributors
---
- A failed playtest no longer starts extra Lua workers during cleanup and
  leaves the command hanging. Closing the pool cancels queued plays and
  removes their temporary programs while running plays finish (thanks shacklef00rd, #2165).
