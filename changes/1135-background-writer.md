---
section: forge
---
- A `background` record in data/guide-fixes.json makes a slow, zone-wide
  collection a goal of the whole stay: the writer lists the objective on the
  way from the quest's accept to the step that hands it in, puts a finish
  step at the record's point right before it (`when !has <item> x<count>`
  for an item), and adds the record's mention to the steps between that pass
  the dropping mobs. `forge data check-corrections` checks the record.
