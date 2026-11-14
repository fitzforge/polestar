---
section: contributors
---
- A route-feel check for route changes: node tools/flow-audit.js plays every
  start and class through the compiled guides, with dungeons off or on
  (every dungeon quest, or only those on the way) and with each route
  choice, and counts what a player feels as bad flow: walking back and
  forth, quests walked past and taken later, quests carried into later
  guides or picked up long before their work, and trips made only for
  dungeon quests. Its gate fails a release whose guides got worse than the
  shipped ones without a stated reason in data/flow-gate.json
  (docs/ROUTE-FEEL.md).
