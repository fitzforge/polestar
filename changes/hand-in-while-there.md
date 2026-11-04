---
section: forge
---
- Hand in while there: a quest finished within 160 yards of its turn-in NPC is
  handed in before the route walks 300 yards or more away, not on a trip back
  (Sarkoth at Hana'zua). Waiting stays when the follow-up needs a level not
  reached yet or the route returns to that NPC anyway. The route planner moves
  and guards it, `forge judge check` reports it as `finished-near` (a blocker to
  level 30, a warning above) and `forge sim route --audit` lists it on written
  routes.
- A turn-in whose NPC stands on a loop's way is written inside the area step,
  right after the goal that finishes the quest, when it adds at most 40 yards
  and saves a walk back later.
- Guide titles leave out the capitals and zones the guide hardly quests in;
  a race's lead-in to the shared guide of the same zone is merged into it.
