---
section: players
---
- Polestar does less every frame: standing still, the arrow checks your
  position half as often, and walking, the minimap's pins and route line move
  when they would move a visible amount, not every frame (in our testing,
  about 80% less work for the minimap while walking). /polestar perf report
  now keeps its five largest frames for the report. (thanks Fitz, #3881)
