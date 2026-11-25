---
section: contributors
---
- The quest database's memory test pre-grows Lua's string table before it
  measures, so its read figure is the quest pack's own and no longer jumps by
  the table's doubling when other strings are added (#3762; thanks
  shacklef00rd, #4008).
