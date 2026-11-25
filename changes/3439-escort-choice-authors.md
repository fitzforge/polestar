---
section: authors
---
- A required accept of an escort quest now asks Do it / Skip it at its step
  as a `when group` step does, unless a step of the guide asks about that
  quest itself (`when group` or `when !group`). The compiler puts players'
  median time and failure share on the accept (`escortSecs`, `escortFail`,
  from `data/recorded/escorts.json`); GUIDE_FORMAT.md, "Escort quests"
  (#3439).
