---
section: authors
---
- Guide format 10: add `area <npc> ["Label"]` or `area @x,y @x,y @x,y …
  ["Label"]` inside a step to shade where to hunt on the world map and the
  minimap while the step is current: the hull of that mob's spawns in the
  step's zone, or of 3 to 64 points you draw. An area never holds the step.
  A mob with no spawns in the zone is a lint warning and the area is left
  out. Needs Polestar 0.3.7.
