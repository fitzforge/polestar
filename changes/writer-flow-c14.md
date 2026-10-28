---
section: forge
---
- The guide writer keeps a town visit in one piece: a class step or a v1 step
  the route does not take, far from the town, goes after the visit instead of
  between two stops there; a guide is not cut inside one town visit; a flight
  path or bind learnt on arrival goes in the town loop, at the step nearest its
  NPC; a buy is written where the route buys, not with the hand-in it is for.
- A class's flight out and back with nothing done in between is not written;
  nor is v1's step that only learns a flight path the route does not go for; a
  flight path learnt in one guide is not learnt again in the next.
- v1's bare `collect` of an item one of the route's quests asks for is tagged
  with that quest; a guide's comment block is written once per guide.
- Shared route: a start's own guide before the shared chain that the route
  leaves with no line keeps only its class steps (Orc and Troll's Barrens
  guide); a shared guide a start plays in its own part becomes its own guide
  (Night Elves' Darkshore); a start's own level or training event keeps its own
  target instead of taking another start's.
- A start's class step under its level is not held or deferred into the
  shared guides (where it was lost): it stays in the start's guide behind a
  `level` line (the Dwarf Paladins' Tome of Divinity). A class line beside
  another audience's same line is only dropped as a duplicate when both are
  for the same characters; a class list and a race list share characters.
- Class and field steps go to the town or seed step they belong to: Perrine's
  Chest at the Scarlet camp, the Warriors' scales right after Far Watch; the
  Undercity counts as here from the Ruins of Lordaeron. A class accept ahead
  of a prerequisite handed in in a later guide moves there with its chain.
- A Druid's way to Moonglade is its teleport, written `goto` to where it lands
  labelled "Cast Teleport: Moonglade" (`forge judge` reads a teleport goto as
  no walk). Class lists in a start guide name only the classes its races play.
- A start's arrival at the shared chain takes its class steps before
  everyone's way in with it (the Night Elf Warriors' Stormwind step no longer
  cuts off everyone's boat); a quest the shared order never accepts is for the
  starts that carry it in (Telf's Call of Fire for Tauren Shamans only); route
  fixes' `after` rules hold inside a hub visit; a class's run of steps stays
  in v1's order when it is written right after its previous step.
- No walk for everyone is written to a v1 step of nothing but optional lines
  or quests the route does not take (The Collector, Manhunt).
- A shared guide a start plays in its own part (the Night Elves' Darkshore)
  comes before the join guide in the chain the writer cuts by, so its lines
  (the Auberdine accepts) are not written into the join guide the start does
  not keep.
- Fewer trips back and forth in the written guides: classes away rejoin
  where the route goes on (not where it left from) and not at all when they
  are already there; a class or race step between two lines at one NPC, or a
  riding trainer's step mid-visit, goes after the visit (v1's travel for
  everyone stays in place); a class trip for some races' lines only is theirs;
  the same way for two races is not merged ahead of one race's own flight.
