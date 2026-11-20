---
section: players
---
- A guide waypoint with a known height no longer counts as reached just
  because you walked underneath it. The arrow distinguishes a walk that
  reaches its target from one that stops on a nearby ledge.
  If you're already on a vendor's floor, a walk that ends farther away
  won't send you back outside. Standing beneath a trainer no longer starts
  a short walk that ends on the same lower floor without reaching the stairs.
  A steering shortcut must reach the requested storey, not just a floor
  close in height. This keeps the decks beneath Nissa Firestone distinct.
  At bends such as the Ironforge gryphon roost, the arrow follows the aisle
  even when the game doesn't flag it as indoors. On open ground it can
  still point farther ahead when the map shows a clear straight walk.
  From the Ironforge flight master, the walking map goes around the
  gryphon perch. Farther down the street, the arrow keeps the turn
  around the signpost instead of pointing through it.
- With real-path routing on, missing walking data no longer sends the
  arrow straight across unmapped ground. Turning routing off still shows
  the compass direction unless the ground segment crosses an enemy settlement or cannot be checked.
- A walk no longer starts with an unchecked shortcut to a distant mapped
  floor, and the travel planner does not count that shortcut as a transfer.
- Walking routes avoid the other faction's towns and guarded hubs. Flights
  may pass over them. The planner prefers a way around a zone far above
  your level, but ordinary enemies, elites and bosses do not block walks.
  Missing faction ownership alone no longer blocks a mapped walk.
  Guard checks are available immediately, even when logging in during combat,
  without loading a continent's walking maps.
- If a waypoint arrow would point straight through an enemy town, Polestar
  keeps its own guidance instead. Boarding a flight no longer hands the
  destination to another arrow as if you were meant to walk there.
- The arrow waits for a walking route instead of pointing straight at the
  goal while the maps load. It no longer hands that unchecked direction
  to a waypoint arrow, including when combat delays the search.
- On the approach to Darkcloud Pinnacle, the Mesa Elevator now tells you
  to ride up from the canyon floor and down from the top.
- A route to or from a boat deck no longer borrows a walking price from
  the same spot on another floor. Before suggesting a flight with an onward
  walk, the planner waits while the walk from that landing is being checked.
  Replanning no longer offers the ticket if that check found only a road
  on another floor or returned no verified price. You can still fly to the landing itself.
- At a capital lift, the arrow no longer borrows the floor under the car when
  the client has not reported your height. It waits to say “ride up” or
  “ride down” until you are on the boarding deck.
- When an enemy town lies between you and a zone crossing, the planner
  checks for a walk around the town rather than treating the straight line
  as the only approach. Higher-level zones can still be crossed on foot.
  Passing beside the corner of an enemy capital is allowed; touching its
  boundary with the player's shoulders is not.
  When you walk beside an enemy boundary or step back onto safe ground,
  the arrow points along the checked walk without swinging into town.
