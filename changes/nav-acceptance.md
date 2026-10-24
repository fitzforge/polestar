---
section: contributors
---
- The walking-map rebuild has an acceptance set to be judged against:
  `tools/lib/nav/eval/acceptance.json` (reported walks, underworld caves,
  chokepoint walks), a broad random sample, chokepoint checks and
  `judge-pr.sh`, which measures a nav pull request against today's maps. The
  planner's acceptance cases are ignored tests in forge-addontest's
  nav-e2e (`-- --ignored acceptance`) until the rebuild lands.
