---
section: contributors
---
- `tools/lib/route/prereq-order.js` plays every leveling path (each start and
  each `next` option) as every race and class it is for, with group quests
  both answered and skipped, and reports an accept whose blocking
  prerequisites that path hasn't handed in yet. Lint's check counts a hand-in
  on any branch into a guide. `tests/guides-reported.test.js` runs it over
  all guides, so a guide that takes a quest before its chain fails the tests.
