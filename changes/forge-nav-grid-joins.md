---
section: forge
---
- `forge nav pack --leffe` puts listed walks from Polestar's walking grid
  into Leffe's maps where his maps cut them off (grid joins,
  `rust/crates/forge-nav/src/pack/joins.json`: two places and why, per
  join). Each join is routed on the grid both ways (one it walks one way
  only goes back along the same cells, unless a step back rises over the
  walk slope) and only what his maps lack goes in: a floor in a cell, an
  arc, entrances and an edge across a cluster border, the entrances'
  edges, and one component for the places it joins. A way with a climb
  his maps lack, or off his maps, is refused; one his maps already make
  adds nothing. The log and PACK.json count what went in
  (docs/forge/nav.md, "Grid joins").
