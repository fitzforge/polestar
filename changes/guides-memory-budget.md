---
section: contributors
---
- A memory budget for the compiled guide pack (`tests/guides-memory.test.js`):
  it loads `addon/Polestar_Guides/Guides.lua` under the test interpreter and
  weighs what stays resident, so a change that costs memory per goal or per
  step shows up in the suite. It also reports what one faction's share of the
  pack weighs, the figure a faction-only load would have to beat (#60).
