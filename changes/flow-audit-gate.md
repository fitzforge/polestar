---
section: contributors
---
- A route-feel check for route changes: node tools/flow-audit.js plays every
  start and class through the compiled guides, on the default route and with
  each route choice the guides offer (with dungeons in the route too, when
  asked), and counts what a player feels as bad flow: walking back and
  forth, quests walked past and taken later, quests carried into later
  guides or picked up long before their work, and trips made only for
  dungeon quests. Its gate fails a release whose guides got worse than the
  shipped ones without a stated reason in data/flow-gate.json
  (docs/ROUTE-FEEL.md).
