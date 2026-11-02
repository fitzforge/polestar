---
section: forge
---
- Class training: a training stop no longer drops a class whose trainer is not
  in town because some later stop exists; it is left out only when the next
  stop comes within four levels of the class's last training, else the line
  sends it to its nearest trainer (Horde Druids and Paladins went untrained
  from 39.5 to 51 and 47). v1's trip for classes the route's stops have no
  trainer for (the Dwarf Shamans' tram to Ironforge) is kept.
- v1's training behind its own `level` line (the level-20 ranks) waits for the
  route's training at that level and is written with it, instead of a guide
  early; a class detour hands a quest in once (the Warlocks' 876, written
  twice).
- A class accept a level or less above the route, in a guide that does not
  pass its zone again at that level, is written where it is behind a `level`
  line, not carried into another band (the Druids' Cat Form from Darkshore to
  the Hinterlands). A step's `level` line gates only accepts it covers; the
  step's hand-ins go before such a gate.
- A hand-in moved after its item, when its NPC is in another zone the guide
  passes later anyway, goes there (the Shamans' Brine after the Ashenvale
  fountain). A step waiting on a quest v1 takes in an earlier step keeps its own
  step and `when` (the rare Gold Pickup Schedule and Manhunt), and a class
  accept only moves to a step of the route's own lines.
- The route check has a `training-gap` warning: a class's walk with more than
  four levels between trainings.
- A v1 step in a zone the route's walk crosses, near where the walk enters it,
  is done on the walk at that crossing: the Warlocks' Takar the Seer in the
  Barrens on the walk from Theramore to Thousand Needles, not a trip back from
  the Mirage Raceway by way of Stonetalon.
- v1's class steps at the place of the route's step that leaves town by tram,
  boat or zeppelin go after that step's work, with the way out a step of its
  own after them: the Dwarf Paladins' Ironforge steps after "The Deeprun Tram"
  (flight path, training, Magni), not before it and back to Gryth.
- A class's v1 step with no pass of the route through its zone goes right
  after its v1 step before (when only the route's added quests are written
  since): the Shamans' Ironforge training and the Night Elf Druids' flight to
  Sentinel Hill straight after the Stormwind stop, not after Theocritus in
  Elwynn (Rev15A1 B1, B2).
- Classes away on a detour come back only to a step of theirs: the Shamans in
  Ironforge are not walked to the other classes' Goldshire training (B3).
- Classes away in a city with their trainer train there before the route's
  training stop, which leaves them out, as does the route's way to it: the
  Rogues in Stormwind at the end of Duskwood, not walked to Goldshire (B4).
- A city's class trainer within 500 yd of the route's training stop counts as
  there (Orgrimmar's Hunter, Mage, Priest, Shaman and Warrior trainers no longer
  get trips of their own "to Orgrimmar"), and a kept class's own trip names the
  stop's town as the place without its trainer, not the zone (Razor Hill, not
  Durotar, which has Mai'ah).
- A class's training step closing a guide (the Druids' Darnassus training
  after Rut'theran Village) stays at the end of that guide, not carried into
  the next one to its first named line (Felwood, after the Emerald Sanctuary).
- v1's training line the route trains by in another city counts its quests
  the route takes elsewhere (or leaves out) as done, so the route's own city
  trains: Stormwind at 57.9 for v1's Ironforge step, for the classes with a
  trainer there; the Shamans train at the route's Ironforge stop right after.
- Classes away train per class where their trainer is: the Rogues in Stormwind
  even when they share a detour with the Shamans off to Ironforge.
