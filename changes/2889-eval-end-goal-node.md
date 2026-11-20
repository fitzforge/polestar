---
section: contributors
---
- `nav eval`'s `end` check now measures where a walk leaves the walking maps
  from the node the goal stands on (the harness's new `goal`), with the line's
  last segment judged walkable on our grid, instead of from the line's
  previous point: straightening can draw the last stretch as one long segment
  (#2889's hollow read 31 yd short of the Draconia).
