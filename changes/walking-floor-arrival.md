---
section: players
---
- A guide waypoint with a known height no longer counts as reached just
  because you walked underneath it. The arrow distinguishes a walk that
  reaches its target from one that stops on a nearby ledge.
- With real-path routing on, missing walking data no longer sends the
  arrow straight across unmapped ground. Turning routing off still shows
  the compass direction unless the ground segment crosses an enemy settlement or cannot be checked.
- A walk no longer starts with an unchecked shortcut to a distant mapped
  floor, and the travel planner does not count that shortcut as a transfer.
- Walking routes avoid the other faction's towns and guarded hubs. Flights
  may pass over them. The planner prefers a way around a zone far above
  your level, but ordinary enemies, elites and bosses do not block walks.
  Missing faction ownership alone no longer blocks a mapped walk.
- If a waypoint arrow would point straight through an enemy town, Polestar
  keeps its own guidance instead. Boarding a flight no longer hands the
  destination to another arrow as if you were meant to walk there.
- The arrow waits for a walking route instead of pointing straight at the
  goal while the maps load. It no longer hands that unchecked direction
  to a waypoint arrow, including when combat delays the search.
