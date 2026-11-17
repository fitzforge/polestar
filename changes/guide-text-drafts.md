---
section: contributors
---
- Translators: when a guide text's English changes, `forge i18n guides sync`
  writes its old translation as a `-- was:` comment right above the new,
  empty line, matching the texts with their names read as words, so a
  sentence that differs by one name starts from the old translation instead
  of from nothing (thanks soulrocha for the idea and the measurements, #1315).
