---
section: authors
---
- `forge guide compile` and `lint`, `forge i18n guides sync`, `check` and
  `stats`, and the node tools and tests that load the reference data stop with
  one error when that data was read from a Forever client build whose tables
  are not in the sources beside it (`data/sources/wago/<build>`: SpellName and
  SkillLineAbility when the data has the build's spell names, and AreaTable).
  They used to go on without them, writing spell names as words and places
  without their area, so guide texts changed, good translations of them read
  as stale and tests failed for the wrong reason (docs/TRANSLATING.md, "Guide
  texts").
