---
section: contributors
---
- `talents build` takes one plan file per class in `talents/forever/` and
  writes them all into `Builds.lua`, one class after another; every class's
  tree is known by its class skill line. Two stray talents in the client's
  tables are left out: a second Lightning Reflexes far off the Hunter tree
  and a second Holy Specialization below the Priest's Shadow column. Kept,
  they made the Hunter tree a fourth spec column and the Priest tree an
  eighth row. Rows a few units apart (Warlock's first and fourth) count as
  one, and a line the client only draws (a TraitEdge of type 0, VisualOnly)
  is no prerequisite: the Druid's Nature's Majesty and Nature's Splendor
  each seemed to need the other, so neither could be planned
  (thanks jnickles85-bit).
