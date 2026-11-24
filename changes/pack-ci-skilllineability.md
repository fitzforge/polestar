---
section: authors
---
- A community pack's CI workflow (the one `polestar new` writes) lints and
  playtests on a fresh runner again: `forge data build` now fetches the
  client's SkillLineAbility table with SpellName, which the guide lint reads
  beside the data (thanks creazy231 for the report, #3572).
