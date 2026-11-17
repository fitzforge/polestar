---
section: contributors
---
- `node tools/polestar.js flow-diff --base <ref>` plays the leveling route
  before and after a change, each tree through its own engine, and shows
  what the change does to the route's flow: the zones each guide walks, new
  trips back into a zone the route had left, steps that send the player far
  for one quest or to a place with nothing to do, quests carried for more
  guides, walking and flying time, and where each moved quest went. A pull
  request that moves a quest pastes its table; a new revisit or trip needs a
  reason in `data/flow-diff-allow.json` (docs/ROUTE-FEEL.md, "Flow diff").
