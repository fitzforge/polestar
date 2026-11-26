---
section: contributors
---
- The addon's Lua tests find the checkout they run in when they run, not when
  they are built, so a target folder shared by two checkouts no longer tests
  the other checkout's addon (#4068).
