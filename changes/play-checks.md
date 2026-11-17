---
section: authors
---
- `forge guide lint` checks the kinds of step players kept getting stuck on,
  as errors in Polestar's guides (warnings in other packs and in `compile`):
  a required hand-in taken straight from the bags with no `when has` for its
  item, a gated step that hands its item over before its other goals, a
  `kill` on a talk objective, a hand-in no earlier goal works, an accept the
  giver cannot offer there or that sits two levels above the route, and a
  `use` whose item only optional or skippable steps get. A step that is right
  as written goes in `data/lint-allow.json` with its reason (GUIDE_FORMAT.md,
  "Validation").
