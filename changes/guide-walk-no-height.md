---
section: players
---
- With no height from the game (Forever gives none), the arrow follows a
  guide step's saved walk as 0.4.1.1 did, without first checking it against
  a floor it can only guess. In 0.4.2 a guessed floor that missed the walk,
  or a goal standing above or below the walk's end, sent the step's walk to a
  live search (thanks Fitz).
