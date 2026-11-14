---
section: authors
---
- `forge guide lint` warns about an accept of a quest its giver offers only
  while another quest is in the log (the quest data's `parent`) when the chain
  never takes that quest before it, or hands it in before it, unless the step
  has `when onquest` for it.
