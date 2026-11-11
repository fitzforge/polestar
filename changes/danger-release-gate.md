---
section: contributors
---
- Release gate for danger at the spot: `node tools/danger-gate.js` checks
  every leveling guide's kill, collect and use goals against the hostile mobs
  around them at the route's level (mobs well above you, elites, rares, packs,
  high camps) and fails on any flag missing from the reviewed baseline,
  `data/danger-baseline.json`, where each row gives its reason and evidence.
  A new flag is fixed in the guide or reviewed into the baseline. (#1575)
