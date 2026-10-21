---
section: authors
---
- `when group 6284` puts a group quest to the player: when the route gets
  there, the guide asks whether to do it with a group or skip it, and
  `when !group 6284` is the solo way to the same objective. Put it on the
  quest's accept step: skipping it drops the quest's turn-in and objectives
  too. Not on a `next` line or a `skipto`. A pack using it is written in pack
  format 5 (Polestar 0.3.0).
