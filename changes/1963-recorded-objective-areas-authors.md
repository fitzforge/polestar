---
section: authors
---
- A kill, collect or interact goal bound to a quest objective takes its spawn
  areas from where players' recordings agree the objective is done
  (`data/recorded/quests.json`), and `forge guide compile` warns when a
  hand-placed point lies more than 60 yards outside every such place: the
  compiled goal leads there (docs/GUIDE_FORMAT.md, "Spawn areas", Recorded)
  (#1963).
