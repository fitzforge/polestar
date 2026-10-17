# Polestar Nav: credits

Polestar's arrow walks real paths because of
[Shortest Path Forever](https://github.com/cjber/shortest-path-forever) by
**Cillian Berragan** ([cjber](https://github.com/cjber),
[cillian.dev](https://cillian.dev)). He baked walking maps of the continents
from the game client and wrote a router that finds a walking route over them
in a couple of milliseconds a frame, so the game never stutters: round
mountains, through the right gate, down into the mine and not over the
cliff. It is excellent work, and he said yes when we asked to use it:
"Definitely feel free to use my pathing logic, really appreciate you asking
me as well! Feel free to contribute" (2026-10-15). His permission, given
directly to Fitz, is recorded in
[shortest-path-forever#143](https://github.com/cjber/shortest-path-forever/issues/143).
Thank you, Cillian.

If you like walking routes, try his addon too:
[Shortest Path Forever on CurseForge](https://www.curseforge.com/wow/addons/shortest-path-forever)
plans whole journeys with flights, boats, zeppelins, portals and live
departure times.

## What came from Shortest Path Forever

Version 1.16.0, commit
[b1ad5bd](https://github.com/cjber/shortest-path-forever/commit/b1ad5bd4bf579c781937af0e25f5233cc94b3726),
GPL-3.0-or-later, Copyright (C) 2026 Cillian Berragan.

**The router.** Polestar's walking router started from Shortest Path Forever
v1.16.0 by Cillian Berragan, with thanks; Polestar maintains it since
2026-10-16. `Routing/PathGrid.lua`, `Routing/Path.lua` and
`Routing/PathJobs.lua` began as his files of that commit (with one mechanical
change: the data global is `PolestarPathData`); since then they are
Polestar's code, changed here and no longer copied from upstream: a step is
priced by the ground class of the node it enters and the player's faction
(`Routing/Costs.lua`, Polestar's). Each keeps his copyright and the GPL notice
under a header line saying where it started.

## Polestar's walking maps, grown from his format

The walking maps of Eastern Kingdoms (`Nav/Nav0*.lua`), Kalimdor
(`Nav/Nav1*.lua`) and Zephras Isle (`Nav/Nav2991*.lua`, his until
2026-10-16) are Polestar's: its navigation grid, built from the
Forever client's terrain, water and model collision (`nav build`), written in
Polestar's map format 2 (his format plus a ground class per surface and
per-faction graph costs) by `tools/lib/nav/pack.js`, which started as a port of his
`tools/baker/gen_nav.py` and `tools/pack_nav.py` (Portions Copyright (C) 2026
Cillian Berragan, GPL-3.0-or-later, used with his permission). They cut each
map tile into 128 x 128 cells (4.17 yd, his are 8 yd), so the routes keep to
doors and gates, never swim across open sea, and the router runs on them.
`Nav/Chokepoints.lua` (the lifts, bridges, gates, tunnels, cave and
building mouths and passes a walk is split at) is Polestar's too. `nav pack`
writes them with `PACK.json` (the grid's client build, the cells, the date and
the sha256 of every file) and `Nav/Nav.xml`; `nav check` checks them.
Polestar's other files here are `API.lua` (with the memory ceilings for the
finer maps) and `Polestar_Nav.toc`.

Polestar does not copy his journey planner or tracker: its own travel planner
(flights, boats, hearth) asks this router only for the walking legs
(`addon/Polestar/Nav/Walk.lua`, which also carries his copyright notice).

Also adapted from his work (v1.15.0, GPL-3.0-or-later, with the same
permission), outside this folder, each file saying so at its top:

- `addon/Polestar/Maps/RouteStrokes.lua`: the route-line geometry of his
  `UI/Strokes.lua` and `UI/FlightLines.lua`.
- `addon/Polestar/Maps/RouteLines.lua`: the map and minimap painters of his
  `UI/Route.lua`.
- `addon/Polestar/Nav/Prompts.lua`: his cast prompt (`UI/Arrow.lua`) and
  "complete this step" (`SkipJourneyStep`, `Journey/Journey.lua`).
- `addon/Polestar/Nav/Alerts.lua`: his transport alerts (`UI/Alert.lua`).
- `addon/Polestar/QoL/Flight.lua`: the flight-route line and choosing a
  flight master's node by ID (`Transport/Taxi.lua`).
- `addon/Polestar/Nav/Journey.lua`: journey input and the way commands
  (`Journey/JourneyInput.lua`, `Core/API.lua`, `Core/TomTom.lua`,
  `Core/Way.lua`).
- `addon/Polestar/Nav/Nearby.lua`: nearby places (`UI/Nearby.lua`).
- `addon/Polestar/UI/JourneyPanel.lua`: the journey tracker's step wording,
  "leaves in about" and a header summing whole-second step times
  (`UI/Tracker.lua`, `Journey/JourneySteps.lua`).
- `addon/Polestar/Nav/Transit.lua`: boat, zeppelin and tram timing and
  teleports (`Transport/Model.lua`, `Timetable.lua`, `Observer.lua`,
  `Sync.lua`, `Teleports.lua`).
- `tools/lib/travel/timetable.js` and `tools/lib/travel/cmangos.js`: his
  transit generators (`tools/gen_routes.py`, `tools/gen_transit.py`).

## With Shortest Path Forever installed too

Polestar Nav always reads its own maps (`PolestarPathData`), never his
`ShortestPathForeverPathData`: his engine evicts decoded entries from its
tables while it works, which would pull them from under a search of ours. So
with both addons installed, each holds its own copy of the maps.

## Licence

Everything in this folder is GPL-3.0-or-later (`LICENSE`). Polestar's
guide-pack exception does not apply here, and nothing from this folder goes
into a guide pack.
