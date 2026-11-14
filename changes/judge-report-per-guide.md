---
section: forge
---
- `forge judge report` (and `forge build`'s report) adds two tables to each
  start, for the base guides and the written ones side by side: every guide's
  model minutes on the walk to 60, the quests it hands in and its level range
  (`minutesByGuide` in report.json), and every timed quest's minutes from its
  accept to its hand-in against its time limit (`timed`). A route round can
  then say how much each change costs or saves, guide by guide, and how much
  room each timed hand-in leaves (docs/forge/judge.md, "Reading report.md and
  report.json").
