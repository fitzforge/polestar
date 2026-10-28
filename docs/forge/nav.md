# How Forge walks the world

Forge plans a leveling route by trying orders of quests and timing each one in a model of the game
(see [model.md](model.md)). Most of that time is walking: from a quest giver to a camp, from the camp
to the next giver, from an inn to a flight master. This page explains how Forge works out those
walks. The code is the `forge-nav` crate (`rust/crates/forge-nav`). You run it through
`forge build` and `forge walks`.

The entry point for Forge as a whole is [FORGE.md](../FORGE.md).

## What a walk is

A **walk** is the way on foot between two **places** on the same landmass. Places are the world's
points: quest givers and enders, objective sites and camps, inns, flight masters, transport stops
and the starts. Forge's world stage builds them (see [data.md](data.md)).

For each walk Forge keeps two numbers:

- **yards**: how far the character walks, measured along the line the in-game arrow would draw;
- **cost**: the time it takes in seconds at running pace, plus penalties for things a player
  avoids (steep faces, swimming, enemy towns, zones far above their level).

A pair that no way connects is "not walkable". The model then falls back to the straight line
times a detour factor. Too many of those make routes look shorter or longer than they really are,
so "walks found" is one of the things we check.

Forge asks two sets of maps for walks:

- **our walking grid**, built from the game's data on your own machine;
- **Leffe's navigation maps**. Leffe made them and lets Polestar use what they give, with his
  permission. His maps are private: only people he gives access to have them. The walks they
  answered ship in the data pack's walk stores (numbers, no map geometry).

By default Forge uses both (the **hybrid**, described below) when Leffe's maps or his saved walks
are present, and our grid alone when neither is.

## Where the walks stage sits

`forge build` runs eight stages in order: grid, data, prepare, world, walks, routes, guides, report.
The walks stage
reads the world and writes, per faction:

| File in `<out>/walks/` | What it holds |
|---|---|
| `walks-<faction>.bin` | the walks the routes stage reads |
| `store-<faction>.psbn` | the walk store: every answer our grid has given, kept for the next build |
| `store-leffe-<faction>.psbn` | the same for Leffe's maps (hybrid and `--nav leffe` only), with each place's zone on his maps; without his maps, the data pack's copy is read and never written |

Like every stage, it is skipped when its inputs have not changed (the stage's key is in
`<out>/.forge/walks.key`). The key holds what the walks are made of, not the data at large:

- each world's **walk inputs** (`World::walks_key`): its points (continent, region, x, y, zone,
  height, in order), the places walked to (quest givers, enders and their alternatives, accept
  places, tasks, objective camps, packages, inns, nodes, starts, services, camps, the graveyards'
  Spirit Healers) and the zones' danger (`zoneMin`, `danger`);
- the walkers' answer versions (`MODEL_VERSION` in `walker.rs` and `f4walks.rs`) and the nav
  fingerprint (`POLESTAR_NAV_FP`);
- the backend, the grid's files and the prepare stage's key, the maps list (`PACK.json`), the
  AreaTable and `zones.json`, the extra pairs and, when used, Leffe's maps, his lift layer or the
  saved Leffe stores (their size and time).

So a data fix that moves and adds no place (a quest's text, xp, prerequisites, a rule) skips the
stage. One that adds places (#735: an objective made a kill adds its camp) reruns it, and the walk
stores answer every pair they already hold by its ends: only the pairs of the new places are routed
(a few hundred, seconds, where the whole world is about 2 M pairs per faction and an hour and a half).
A changed walker version, grid, map or danger table still walks again.

`walks-<faction>.bin` is indexed by the world's point ids, so its header carries both the world's
`dataHash` and its `walksKey`. Its readers (the routes stage, the writer, `--walks-from`) check the
walks against the world by `walksKey` (files without one: by `dataHash`).

A world whose places all moved (a rebuilt data set: new map frames or spawn sources shift nearly
every place by a few yards) has new ends everywhere, and the stores have no walk for them: that
build walks everything again.

## Our walking grid

### The files

The grid lives in `data/local/nav4` (or wherever `--grid` or `POLESTAR_GRID` points). It is
built from the installed client, so it is never in the data pack or in git.

| Path | What it is |
|---|---|
| `index.json` | the client build, when the grid was built (`builtAt`), and each continent's tiles and sizes |
| `lifts.json` | the lifts (elevators) found in the client's transport animations, with both ends |
| `tiles/<c>/<col>_<row>.nav.gz` | one file per map tile: the walkable surfaces and their links |
| `graph/<c>.bin.gz` | the continent's abstract graph (below) |
| `walk/roads-<c>-<tag>.bin` | the road mask: which columns are road |
| `walk/<c>-0-<tag>.f32` | the walk graph: each abstract edge's seconds, for one faction |
| `walk/<c>-0-<tag>.mix` | the zone mix: how each abstract edge's seconds split across zones |
| `cch/<c>-0-<hash>.cch` | the CCH bundle (optional, below) |
| `cch/<bundle>.<tag>.yards`, `.cells` | each abstract edge's yards and zone cells (optional; no longer produced, below) |

The hubs layer, `nav-layers/hubs.json`, sits next to the grid folder. It marks each faction's towns
and outposts. The roads and hubs layers are optional and come from `forge nav layers roads|hubs`
(see [The ground layers](#the-ground-layers-forge-nav-layers)):
without them the walk graphs have no road preference and no hostile-hub avoidance.

`<c>` is the continent's map id: 0 is the Eastern Kingdoms, 1 Kalimdor, 2991 Zephras Isle.

### Tiles, columns and floors

The game splits each continent into tiles about 533 yards square. The grid cuts each tile into
256 × 256 **columns**, about 2.08 yards wide.

A column holds a stack of **surfaces**: every place a character can stand at that x, y, lowest
first, up to 31. Open ground has one. A building has one per floor, plus the roof. A bridge has the
bridge and the river bed. Each surface records its height, the height of whatever is above it,
and flags: terrain or building, indoor, water (swim), steep, blocked.

Each surface has **links** to the surfaces next to it in the eight directions. A link has a kind:

- walk,
- steep (a slope of 50-60°),
- swim,
- jump (a small step up),
- climb (very steep),
- indoor,
- lift.

**Falls** are links you can only take downwards, such as stepping off a ledge.

So "floors" are just surfaces stacked in one column. When the world stage needs a height for a
place that has none of its own, it asks the grid for that column's floors and picks one
(`forge_nav::floors`).

### Regions and the abstract graph

Searching 65,536 columns per tile across a whole continent is far too slow. So the grid also has an
**abstract graph**:

- **Nodes** are entrances on tile borders. The Eastern Kingdoms have about 78,000 and Kalimdor
  about 100,000.
- **Edges** join the nodes of one tile (priced by searching inside the tile) and the nodes either
  side of a border.

A **region** is a set of surfaces that can reach each other. Two places in different regions have
no walk.

The walk graph (`.f32`) prices every abstract edge for one faction with the cost model below. The
zone mix (`.mix`) records how much of each edge's time is spent in each zone, so danger can be
priced later without searching the tiles again.

### Legs

A **leg** is a place's way into the abstract graph:

- A **start leg** searches the start's tile outwards from the place and records the time and yards
  to each node it reaches.
- A **goal leg** searches the goal's tile backwards, towards the place.

A place in a small **pocket** reaches no node of its tile. Examples are a ledge, a closed room, or
a point that is a few yards inside a wall. Such a place is moved, or **settled**, to the nearest
surface within 25 yards (up to 10 yards higher or 30 lower) that does reach the graph.

Legs are computed on threads. They are cached per place, so a place with many walks is searched
once.

## Answering a walk on our grid

For each pair the store does not already know, the walker (`walker.rs`) does this:

1. **Snap** both ends to a surface: the column under the place's x, y, then the floor nearest its
   height. A place with no height takes the column's usual floor: inside a building its lowest
   indoor floor; outdoors the top surface under the open sky, else the highest terrain. Under a
   city's streets, a harbour's decks or a bridge lies the terrain the models were built over
   (Stormwind's, Booty Bay's, Darnassus's); a place there stands on the street, not on that buried
   ground.
2. **Straight line.** If the straight line between the ends is plain walking all the way, that
   line is the walk. Plain means no road, water, steep face, enemy town or danger. This idea is
   adapted from Factoruide's route search. We only accept the line when its cost is within 0.2 % of
   the best possible. In practice almost every walk crosses a road, water or a slope, so the line
   answers well under 1 % of walks.
3. **Legs** for both ends (from the cache when possible).
4. **Search** the abstract graph from the start leg's nodes to every goal leg's nodes. There are two
   searches:
   - A **Dijkstra search** over the abstract graph that prices each edge as it reads it: seconds ×
     the danger of the zones the edge crosses. This is used for every danger band.
   - The **CCH** for danger-free walks (below).
5. **Yards and zone cells.** Yards are the legs' yards plus each edge's yards. The walk also records
   its yards per 200-yard **zone cell**, so the model can tell how long a walk spends in each zone.
   Walked yards are the searched yards × 0.961, because the arrow's smoothed line is a little
   shorter than the column-by-column path.
6. **Retry.** A pair that cannot be walked at the places' own heights is asked once more at their
   surfaces' heights. This helps at lift landings and in cities, where a place's stored height and
   the floor can disagree.

A walk inside one tile takes the tile search's own way when that is cheaper than any way through
the graph.

### The CCH

A **CCH** (customizable contraction hierarchy) is the abstract graph preprocessed once so that
shortest-way queries become very fast. Preprocessing ignores costs and writes a bundle per
continent (`cch/<c>-0-<hash>.cch`, 640-710 MB). Before use, the bundle is **customized** with one
set of edge costs, which takes about 4 seconds and 0.7 GB per continent.

Forge customizes once per faction for the danger-free base walks. It does this only when:

- the bundle and the edge yards files exist,
- the walk is danger-free, and
- the call has at least 1,500 rows (start places) on that continent.

Otherwise the Dijkstra search answers. Both give the same costs. Danger bands never customize a
metric: danger is priced inside the Dijkstra search instead. This removes the old per-band
customizations, about 30 minutes a faction.

Without the edge yards files the walker cannot use the CCH. It then joins the graph's nodes with
small cell-by-cell searches to measure yards. This is exact but slower. Zephras Isle runs this way.
The edge yards files were written only by the removed Node CCH backend (`tools/lib/nav/cch.js`),
so they are no longer produced: a fresh grid stays on the Dijkstra path until a Rust writer exists.

## The cost model

A walk's cost is time, with penalties. Each step costs the seconds it takes (running at 7 yards a
second, swimming slower, a small cost per jump or fall) times the multiplier of the surface it
enters (`cost.rs`):

| Ground | Multiplier |
|---|---|
| road | 0.8 (players prefer roads) |
| water | about 2.0 (three running yards per swum yard, in all) |
| a steep face, walking onto it | 40 |
| a climb | 1000 |
| inside the other faction's town or outpost | 20 |
| a dangerous zone (below) | 3 or 20 |

The road mask, the hubs layer and the faction decide which columns get which multiplier. Walks are
priced in the arrow's default route style ("balanced").

## Danger

A level 12 character should not cut through a level 30 zone. Forge prices that in **danger
bands**:

- Band 0 is the base walk with no danger, for every pair.
- Bands 10, 20, 30, 40 and 50 each stand for character levels 5 below to 5 above the band.

A band only re-walks the pairs whose straight line crosses a zone that is at least 4 levels above
it. Every other pair uses band 0's walk.

For a band at level L, a zone whose lowest level is:

- more than L + 10 costs × 20;
- L + 4 or more costs × 3;
- anything else costs nothing extra.

The zones of the two ends are exempt: you have to walk into the zone your quest is in.

The danger is applied inside the search, edge by edge, using the zone mix, so no table is built per
band. Zone levels come from the world stage. The zone of each column comes from the game's area
table.

## The walk store: walks asked, never tabulated

The old pipeline built a full table of every place against every place for each band. That took
about 100 minutes per faction, and any change threw it all away. Forge instead asks for the walks a
world needs, and keeps every answer in a **walk store** (`store.rs`).

An answer is stored under:

- **its two ends**: continent, x, y, the place's own height and the surface's height;
- **its model**: everything else that decides the answer.

For our grid the model is:

- the grid's id (the client build and `builtAt` from `index.json`);
- the ground (cost model version, road mask, hubs, faction);
- the move profile and the route style;
- the smoothing factor;
- the zones tag;
- the danger table;
- the walker's answer version (`MODEL_VERSION` in `walker.rs`).

For Leffe's maps the model is a content hash of his pack (its `Nav.xml` and map files), the
faction, the danger table, the smoothing factor and `MODEL_VERSION` in `f4walks.rs`.

Answers are never keyed by source code or by a place's number. So:

- a quest fix or a new place asks only the pairs that are new (the walks stage above);
- a comment change costs nothing;
- a new danger level for a zone re-asks only that band's pairs that cross it;
- a rebuilt grid has a new `builtAt`, so every answer for it is asked again.

An end is matched exactly: the world file's coordinates (rounded to 0.1 yd as the world writes
them), our grid's snapped column for our walks. A place moved by 0.1 yd is a new end.

The store is one binary file (PSBN: a small JSON header and typed sections; `STORE_SCHEMA` 2 in
`store.rs`), read whole and written back after the stage (to a temporary file, then renamed). It
holds the answers' zone cells too. A faction's store is a few hundred MB.

The routes stage's walk misses (`walks/extra-pairs.json`, [routes.md](routes.md)) are kept by their
ends' places too (`schema` 2: each pair as two `[continent, x, y, height]`), and read back as the
point ids of the world at hand; a file of point ids (no `schema`) is of an unknown world and is read
as empty.

When you build from the public data pack with Leffe's maps, Forge copies the pack's Leffe stores
into `<out>/walks/` first (his walks are kept by his maps' content); our grid's stores are built by
each contributor on their own grid.

Warm, a stored walk is answered in about a tenth of a microsecond.

## Leffe's navigation maps

Leffe's navigation maps are a separate set of walking maps for the game. Leffe made
them and lets Polestar use what they give. His maps are **private**: they are never in the
repository, the data pack or a release. What ships is derived from them: the walks they answered
(the data pack's Leffe walk stores) and the baked legs drawn on them. Both are credited wherever
Forge uses them: the build log, the walks stats (`nav: { backend, pack }`) and the report's data
sources. Licences and every other credit are in [rust/NOTICE.md](../../rust/NOTICE.md) and the
data pack's `manifest.json`.

Forge reads them at build time, and `forge nav pack --leffe` condenses them into the in-game walking maps (below,
"The walking maps"); the files themselves never ship. The reader (`forge_nav::f4`)
is a bit-for-bit port of his own reader: same search order, same ties, same arithmetic. It walks
his maps with his costs. Danger uses the same rule as ours, priced inside his search, with the
ends' zones exempt (`f4walks.rs`).

### Where Forge finds them

In this order:

1. `--leffe <dir>` on `forge build`;
2. the `POLESTAR_LEFFE_NAV` environment variable.

The folder must hold `Nav/Nav.xml` (or `Nav.xml` directly). The maps are about 1 GB.

### Without his maps: his saved walks

Every walk a build asks of his maps is kept in `store-leffe-<faction>.psbn` by its two ends and
his pack's content key, and the store also keeps each place's zone on his maps (the danger bands'
tables are priced over it). `forge data pack` ships those stores. A build without his maps
(`stage::Nav::HybridSaved`, `SavedF4Backend` in `f4walks.rs`):

- finds them in the data pack's `walks/` (else in `<out>/walks/` from an earlier build with his
  maps), for every faction;
- runs the hybrid with his saved walks in place of his maps: a walk the store holds is his; a walk
  it lacks (a place new since the pack was built) has no answer from him, so the hybrid takes our
  grid's, exactly as when his maps have no way;
- reads the store and never writes it, so a later build with his maps still asks him those walks;
- uses the pack and lift layer (below) his store holds the most walks of, at the current answer
  version (a store keeps older packs' and versions' walks too).

The legs stage needs his maps; without them the legs are drawn on our grid.

### Lifts: Leffe's lift layer

His walking graph has no lift edges on purpose. The lifts are a transport layer on top of it, as in
Shortest Path Forever: **Leffe's lift layer**, a `lifts.json` (every lift car with both landings,
found by the grid builder in the client's transport animations) and the reviewed lift rule of his
travel planner. Forge splices it into his search (`forge_nav::f4::lifts`, credited to Leffe's lift
layer):

- **Where it is found.** `lift-layer/lifts.json` in the folder that holds `Nav/`, else in a
  `lift-layer/` folder beside it (as in his handoff: the pack folder and `lift-layer/` side by side).
  The build log says which file it used, or why it used none.
- **Only on its own build.** The file names each landing by a cell of the grid that built the pack,
  so Forge uses a layer only on that build: it knows each layer by its content (SHA-256) and the
  grid build config it was found on, which must be the pack's `PACK.json` `grid.buildConfig`. Any
  other layer or pack is refused (one log line, no lifts). A car whose landing does not stand on his
  walkable surface (within 3 yd of its height) is left out.
- **A ride is priced as our grid's.** Each car is one ride each way between its two landings:
  15 s of wait and boarding plus 4 yd/s of shaft, as seconds × the run speed, times the multiplier
  of the surface it lands on (a hostile hub, a dangerous zone). A landing joins his graph through
  his own search from the entrances of its map piece, as a walk's ends do.
- **The floor rule.** Thunder Bluff's bluff (uiMap 1456) and its ground (1412), the Undercity (1458)
  and the Ruins of Lordaeron (1420) are joined only by their lifts (Leffe's reviewed rule). A walk
  whose ends lie on opposite sides takes one: a way through an incidental entrance, the Undercity's
  sewer pipe, never stands in. Thunder Bluff's walks may take either Mesa Elevator (every car of
  both). The Undercity's take the **south Undervator only**: it is the in-game planner's one way in
  and out (`undercity-south-lift`, Fitz, 2026-10-25), so walk times match what the player is made
  to do; the east and west Undervators are left out of the walks.
- **Sides.** A point of known height is inside when it is within 400 yd of one of the city's
  shafts (or on its map) and on the city's side of its middle height: above 102 for the bluff,
  below 7.45 for the Undercity. Walk ends carry no map of their own, and his zone layer gives the
  Ruins' map over the whole Undercity, so the 400 yd footprint does the work: the Undercity's floors
  reach 350 yd from its shafts, and no ground outside lies below its middle within 650 yd. A point of
  unknown height over the footprint is on neither side (no rule); Tal's heightless flight path is on
  the bluff. A car of the layer that would join a city's sides anywhere but at its shafts is left
  out.
- **Legs.** A baked leg over a lift has a segment of the lift move from landing to landing, as our
  grid's legs do.

Walks that no lift serves are answered exactly as without the layer: the landings sit on a heap of
their own that the search takes from only when it is strictly cheaper.

### What they do well and what they lack

On our acceptance walks (cities, caves, buildings with several floors, choke points, lifts):

- Where both find a way, his are usually a little longer: the median is about 1.03 times our
  yards, because he walks the ground's contour.
- He finds coast and ridge paths our grid misses, and jumps and drops we lack.
- His walking graph has **no lifts** of its own; Forge splices them in from Leffe's lift layer
  (above). Without the layer, Thunder Bluff's rises and the Undercity below the ruins are islands
  or a sewer detour on his maps.
- Some city parts are not joined to the rest: parts of Orgrimmar, Thunder Bluff's rises,
  Darnassus's upper tiers, Ironforge's Military Ward, and some caves.

That is why the default is the hybrid, not his maps alone.

## Choosing the backend

| Backend | What answers each walk |
|---|---|
| `grid` | our walking grid only |
| `leffe` | Leffe's navigation maps only |
| `hybrid` | Leffe's maps, unless his maps have no way or his way costs more than 1.2 × ours; then our grid |

The hybrid (`hybrid.rs`) works on whole walks:

1. Both backends build a full walks file for the same world, each from its own store.
2. The two files are merged walk by walk.

It does not splice our grid's lifts or links into his graph; his lifts come from Leffe's lift
layer. A walk his maps cannot do well is taken entirely from our grid.

Both cost models price a yard about the same on the acceptance walks, so the costs can be compared
directly. Most base walks come from Leffe's maps; the rest come from our grid, either because his
maps have no way or because his way is a detour.

The hybrid never finds fewer walks than our grid. In the model it is a little slower than our grid
alone, because it keeps his slightly longer walks. That is a difference in walking style, not
missing walks.

How to choose:

- `forge build --nav grid|leffe|hybrid`. Without `--nav`, the build uses `hybrid` when it finds
  Leffe's maps or his saved walks for every faction, and `grid` when it finds neither. Asking for
  `leffe` without his maps, or `hybrid` with neither, is an error.
- `forge walks walks` (the stage on its own) reads `POLESTAR_NAV`: `grid`, `leffe` or `hybrid`.
  Without it, it uses `hybrid` when `POLESTAR_LEFFE_NAV` names Leffe's Nav folder or his saved
  walks lie beside the store (`<store>-leffe.<ext>`), else `grid`.

## Flights, boats, lifts and hearthstones

Walks are on foot, inside one landmass. Everything else comes from the travel data
(`travel.json`, built by `forge data travel`; see [data.md](data.md)):

- flight paths and their flight times;
- boats, zeppelins and the Deeprun Tram (wait plus ride);
- walk-in portals (one way);
- the hearthstone (bind point, cooldown).

The model joins them: a trip is walk to a transport node, ride the network, walk from the last node.
If walking all the way is cheaper, it walks (see [model.md](model.md)). The travel data's stops take
their heights from the grid (`forge data travel --grid <dir>`), so walks to a dock or a tower top
start on the right floor.

Lifts are in both places:

- Our grid has them as lift links (from `lifts.json`). Its walks ride a lift like any other step,
  with a wait.
- The travel data also lists them as rides.

## Memory and time

Approximate, on 8 threads; yours will differ.

| What | Bound |
|---|---|
| grid tiles held in memory | 640 tiles (LRU) during walks; 2,048 when reading floors for the world |
| one customized CCH metric | about 0.7 GB per continent, base walks only |
| Leffe's decoded map pieces | a byte-bounded cache: 2,048 MB in `forge build` and on the hybrid; `POLESTAR_LEFFE_NAV_CACHE_MB` for `forge walks walks` with `POLESTAR_NAV=leffe` (default 1,024) |
| pairs sent to the walker at once | 150,000 |
| peak memory, one faction | about 5-6 GB |
| a faction from an empty store | tens of minutes on our grid, longer on Leffe's maps or the hybrid |
| a faction after a quest fix | a few minutes: only the new pairs are routed |

`forge build --threads N` (default 8) sets the threads; `forge walks walks` uses 8. If a machine
runs out of memory, lower `--threads` first. With `forge walks walks` on Leffe's maps alone you can
also lower `POLESTAR_LEFFE_NAV_CACHE_MB`; `forge build` keeps the cache at 2,048 MB.

## Running it

Build everything, letting Forge pick the backend:

```sh
forge build --guides guides/forever --out out
```

Force a backend, or point at another grid or at Leffe's maps:

```sh
forge build --guides guides/forever --out out --nav grid
forge build --guides guides/forever --out out --nav hybrid --leffe ~/leffe-nav --grid data/local/nav4
```

The build log names the backend (`walks backend: Hybrid (Leffe's navigation maps …)`). It prints one
stats line per faction with:

- `asked`, `stored` (from the store), `routed` (newly walked) and `straight` (answered by the
  straight line);
- per band, `failed` (not walkable);
- `storeAnswers` (the store's size before and after);
- `wallS` (seconds).

On the hybrid the line also has `grid`, `leffe` and `hybrid`. The `hybrid` part counts, per band,
the walks taken from each backend: `leffeNone` (his maps had no way) and `leffeDetour` (his way cost
over 1.2 × ours).

Run the world and walks stages on their own, from a checkout (`data/sim` here is any folder):

```sh
forge walks world . data/local/nav4 data/sim horde
forge walks walks . data/local/nav4 data/sim horde data/sim/store-horde.psbn forge-walks-1
POLESTAR_NAV=hybrid POLESTAR_LEFFE_NAV=~/leffe-nav/Nav forge walks walks . data/local/nav4 data/sim horde data/sim/store-horde.psbn forge-walks-1
```

`forge walks walks` takes:

- `<root> <grid> <simDir> <faction> <store> <navFp> [bands]`;
- it reads `<simDir>/world-<faction>.json` and writes `<simDir>/walks-<faction>.bin`;
- `navFp` is a free tag written into the walks file's header;
- `bands` is a comma list (default `0,10,20,30,40,50`);
- on the hybrid, Leffe's answers go to a second store beside `<store>`, named `<store's stem>-leffe.bin`.

Merge two walks files of the same world yourself (the last argument is the slack, default 1.2):

```sh
forge walks hybrid walks-grid.bin walks-leffe.bin walks-hybrid.bin 1.2
```

Check the grid's floors against the old builder's floors cache:

```sh
forge walks floors-parity data/local/nav4 floors.json
```

### Looking at one walk

To see a single walk on our grid, the repository's Node tools can draw a route between two map
points. `<map>` is a uiMapID (1411 is Durotar), and the coordinates are map percent:

```sh
node tools/polestar.js nav path 1411 52.0,43.0 1411 45.0,12.0 --dir data/local/nav4
```

It prints yards, seconds by kind of ground, falls and the simplified points. Add `--json` for
everything.

Four `forge-nav` examples look at the grid itself (`cargo build --profile quick -p forge-nav
--examples`, then `rust/target/quick/examples/<name>`):

- `gridab <grid> [<Leffe's Nav folder>] < queries.jsonl`: each query (`{id, map, from, to, profile}`,
  world ends `[x, y, z|null]`) drawn as the guide bake draws a leg, on our grid and on Leffe's maps:
  yards of the simplified line, cost and points per side.
- `gridcol <grid> <map> <wx> <wy> [radius] [zlo zhi]`: every surface of the columns around a point:
  height, room above, flags, slope, region and its size, and each direction's link.
- `trailfollow <grid> < walks.jsonl`: follows a recorded walk (positions, no heights) through the
  grid's links. A break is a place the player walked where the grid has no way from one column to
  the next; it also gives each position the height it was followed at.
- `snapcheck <grid> walks.jsonl follow.jsonl`: how often a place without a height is put on another
  floor than the recorded walk was on.

## Rebuilding the grid

You need the grid once per client build. `forge build` builds it itself from the installed game
into `<out>/grid` (the grid stage, keyed by the client's build, the map frames, zones and objects:
skipped while they are unchanged) unless `--grid` or `POLESTAR_GRID` names one. On its own:

```sh
forge nav grid --out data/local/nav4                 # every continent map-frames.json names
forge nav grid --out data/local/nav4 --continents 0,1 --force
```

It writes the tiles, the graph, `index.json` and `lifts.json`, the same bytes as the Node builder
(`node tools/polestar.js nav build`), and keeps tiles already built unless `--force`. Before it
builds, it checks that the install holds every file those continents use (as
`forge gamedata check`); an incomplete install is refused, since the grid would be wrong where the
files are missing: run the launcher's Scan and Repair, or pass `--allow-incomplete` (to `forge nav
grid` or `forge build`).

The walk graphs, road masks and zone mixes come from `forge nav prepare`, also a stage of
`forge build` (between the grid and the walks). The road and hub layers it reads are optional and
made by `forge nav layers`; without them the walk graphs have no road preference and no hostile-hub
avoidance:

```sh
forge nav layers roads
forge nav layers hubs --dir data/local/nav4
forge nav prepare --dir data/local/nav4
```

- `forge nav layers` writes the road and hub layers to `data/local/nav-layers` (see
  [The ground layers](#the-ground-layers-forge-nav-layers)).
- `forge nav prepare` writes `walk/`: road masks, the walk graphs and the zone mixes. It also writes `cch/`: each
  continent's CCH bundle (`<c>-0-<graph sha>.cch`) and, for the Alliance and Horde walk profiles, each edge's
  yards and zone cells (`<bundle>.<ground key>.yards` and `.cells`). Without these files, walks take the slow
  per-row path.
- Every file is byte-identical to the Node builders' output (router.js prepare, cch.js prepare and
  prepareYards). `forge build` runs it as its `prepare` stage, keyed by the grid and layers.
- Times on 6 threads, under 8 GB, for Eastern Kingdoms and Kalimdor:
  - walk graphs: about 18 minutes;
  - bundles: about 2 minutes each;
  - yards: 4 to 5 minutes per continent and faction.

To check a bundle against Dijkstra, use the `navcch` tool in `forge-devtools`:

```sh
cargo build --release --manifest-path rust/Cargo.toml -p forge-devtools --bin navcch
rust/target/release/navcch check data/local/nav4/graph/0.bin.gz 0 data/local/nav4/cch/0-0-local.cch 200
```

`build` takes about two minutes and 1.8 GB per continent. `check` compares CCH answers with a plain
Dijkstra search. The walker finds any `cch/<c>-0-*.cch` file. Without the edge yards files next to
the bundle, it still uses the Dijkstra search; nothing writes those files any more (see
[The CCH](#the-cch)).

A rebuilt grid has a new `builtAt`. Every walk is asked again on the next build, and the data
pack's stores no longer match it.

## The walking maps (forge nav pack, forge nav check)

The arrow's walking routes in game run on the walking maps in `addon/Polestar_Nav`. Shipped: maps
format 5, Leffe's navigation maps condensed for the game. Without `--leffe`: Polestar's own from our
grid (maps format 2: per walkable surface a ground class, road, gentle or steep slope, indoor, indoor
city and the Alliance and Horde hubs; every graph edge priced per faction; format 3 adds each
surface's WMO group area). `forge nav pack` writes them from the grid and the ground layers:

```sh
forge nav pack --dir <grid> --date 2026-10-25 --leffe <Leffe's maps>    # what ships
forge nav pack --dir <grid> --date 2026-10-23                           # our grid's maps
forge nav check
```

- `--leffe <dir>` (his format-4 Nav folder, or the folder holding it: the same client build and
  cells as the grid) takes the maps from his: his surfaces, floors, classes, zones and entrance graph,
  his jumps and drops as each cluster's one-way `arc` field, and each of his surfaces the named area of
  the grid's surface in the same cell nearest in height (maps format 5, PACK.json format 5; each map's
  `leffe` entry counts what came over). The chokepoints stay the grid's. `--leffe-maps 0,1,2991` names
  the maps taken from his (default all three); the others are the grid's, byte for byte, so one
  continent can go back to our grid if his maps walk it wrong. About 90 s for the three maps.
  The rules are in [ARCHITECTURE.md](../ARCHITECTURE.md), "Leffe's navigation maps in game".
- `--dir` is the grid (format 4: it needs each surface's slope), `--layers` the ground layers
  (default `data/local/nav-layers`, below), `--out` the addon folder (default `addon/Polestar_Nav`),
  `--cells` the cells per ADT tile (default 128, 4.17 yd), `--date` the date in the generated headers
  (default today, UTC). The same grid, layers, cells and date give the same bytes.
- It writes `Nav/Nav<map>.lua` and its parts for maps 0, 1 and 2991, `Nav/Chokepoints.lua` (lift
  landings, bridges, gates, tunnels, cave and building mouths, passes: from the grid, its
  `lifts.json` and the arrow's `aids.json` beside it), `PACK.json` (grid build, cells, date, sizes and
  the sha256 of every file) and `Nav/Nav.xml`; files of ours the new pack no longer has are removed.
  The capitals, zones and place names come from `data/forever` (zones.json, map-frames.json) and the
  newest cached `AreaTable.csv` under `data/sources/wago`.
- A grid with area sidecars (`forge nav grid`'s `tiles/<c>/<tile>.area.gz`, a WMOAreaTable row per
  entry, and `areas.json`, each row's subzone name) packs maps format 3 (PACK.json format 3): each
  surface's area is its entries' commonest row (ties: the lower id), packed as the class field is
  (`area`, 3-symbol ids, run-length), and the metadata names the rows (`areaNames`). Only rows with a
  name are packed (others as none): the planner matches a surface's area by name to the client's
  subzone, and the unnamed rows were over half the field (about 0.6 MB of Polestar_Nav's resident
  memory). A grid without sidecars, or whose rows have no names, packs format 2.
- The writer is a port of the Node writer (tools/lib/nav/pack.js, chokepoints.js): on the 1.60.1.70532
  grid every file is byte-identical to it (rust/tests/golden/nav-pack and its opt-in real-grid test);
  a format 3 grid differs from the last JS writer only by the unnamed rows left out.
  It takes about 2 minutes for the three maps.
- `forge nav check` compares the folder with its `PACK.json`: every listed file present and unchanged,
  none unlisted, `Nav/Nav.xml` listing them in order, the chokepoints last. Exit 1 when one differs.

The format itself (clusters, cells, entrances, faces, classes, the zone field) is written in each
`Nav<map>.lua`'s header and in [ARCHITECTURE.md](../ARCHITECTURE.md), "Packing for the in-game engine".

## The ground layers (forge nav layers)

Two optional layers shape the walks and the walking maps' classes:

```sh
forge nav layers roads [--c 0|1] [--wow <game folder>]
forge nav layers roads --allowlist
forge nav layers hubs --dir data/local/nav4
```

- **roads**: per grid column, how much of the ground the client paints with a road texture (0-255;
  road from 128), from each tile's tex0 ADT in the installed client and the reviewed allowlist
  `data/road-textures.json`; texture names come from the wowdev community listfile, downloaded once
  to `data/sources/listfile` (`--offline` never downloads). It writes
  `nav-layers/roads/<c>/<col>_<row>.bin` and `index.json`. `--allowlist` rewrites the allowlist from
  every texture both maps use (a path naming a road, path, cobble, street or trail; one naming dirt,
  footprint, brick or gravel, or listed under `reviewed`, when its shape is a road's), with every
  measure for review; never with `--c`.
- **hubs**: each faction's towns and outposts, from its guards and service NPCs in the CMaNGOS
  classic-db spawns and creature templates (the cached dump under `data/sources/cmangos`), judged by
  the client's FactionTemplate table and named by the AreaTable area under them (the grid's area
  ids; the tables cached for the grid's build under `data/sources/wago`). It writes
  `nav-layers/hubs.json`.
- Both are ports of the Node layers (tools/lib/nav/layers): byte-identical on
  rust/tests/golden/nav-layers, and `hubs.json` on the 1.60.1.70425 grid.

## When it goes wrong

**`the data pack has no navigation grid (it is built from your own client) and no client … was found: pass --wow <client> or --grid <dir> (or POLESTAR_GRID)`**
The pack never ships a grid, and `forge build` found no game client to build one from. Pass
`--wow` with your game folder, or build a grid (above) and pass `--grid`.

**`walker: no walk graph … for continent N (… router.js prepare builds it)`**
The grid has no `walk/` files for the current `builtAt`. This happens after `nav build` when
`nav prepare` was not run. Run `forge nav prepare --dir <grid>` (or let `forge build` do it).

**`expected one road mask tag in <grid>/walk, found [...]`**
There is no road mask, or there are masks from two road layers. Run `forge nav prepare` after
`forge nav layers roads`. Delete the stale `walk/roads-0-*.bin`, keeping the newest.

**`--nav Hybrid: Leffe's navigation maps not found (…), and no saved Leffe walks`**
Pass `--leffe <dir>` or set `POLESTAR_LEFFE_NAV` (his maps, if Leffe gave you access), or run
`forge data fetch` for his saved walks. The maps' folder must contain `Nav/Nav.xml` or `Nav.xml`.

**`POLESTAR_NAV=leffe needs POLESTAR_LEFFE_NAV=<Leffe's Nav folder>`** (or `POLESTAR_NAV=hybrid needs …`)
Same, for `forge walks walks`.

**`<store>: no saved walks on Leffe's maps`**
The saved Leffe store holds no walk of his. Fetch the data pack again, or build with `--nav grid`.

**`hybrid: the two walks documents are of different worlds`**
`forge walks hybrid` was given walks files built from different worlds. Rebuild both from the same
`world-<faction>.json`.

**Missing tiles from a partial install.** The game client downloads its files in the background. If
it was not finished when the grid was built:

- the files it could not read count as missing, and the builder warns about them;
- those tiles are empty or absent;
- places there get no floor (the world's `heights` counts them as `none`);
- walks there fail, and the routes fall back to straight lines.

`forge gamedata check --maps 0,1,2991` (or `forge doctor`) lists the missing files per map and the
tiles they touch before you build. The grid builder refuses an incomplete install unless it is told
`--allow-incomplete`. Let the launcher finish, or run its Scan and Repair. Then rebuild the affected
continent with
`nav build --out data/local/nav4 --continents <c> --force` and run `nav prepare` again.

**Many walks "not walkable" in one area.** Look at one with `nav path`. Common causes:

- a place inside a wall or prop that settles into a pocket;
- a lift our grid does not join;
- a rope bridge with no link.

If it is a grid gap, fix the grid. If it is a bad place, fix the place in the data (see
[data.md](data.md)).

**Out of memory.** Lower `--threads`. With `forge walks walks` on Leffe's maps alone, also lower
`POLESTAR_LEFFE_NAV_CACHE_MB`.

**The walks stage runs every time.** Its key covers the grid's files by path, size and modification
time. Something that touches the grid folder (a copy, a sync tool) changes the key. The store still
answers every pair, so the rerun is fast, but it does run.

## Changing it

| File in `rust/crates/forge-nav/src` | What it does |
|---|---|
| `grid.rs`, `floors.rs` | read the grid's files; heights for the world |
| `legs.rs`, `space.rs` | snap, pocket settle, start and goal legs, cell-by-cell pieces |
| `cost.rs` | the cost model and the danger rule |
| `walker.rs` | the search on our grid, the straight-line check, the CCH use |
| `cch/` | the CCH (bundle, customization, queries); the `navcch` tool is in `forge-devtools` |
| `store.rs`, `psbn.rs` | the walk store and its file format |
| `walkdoc.rs`, `lookup.rs` | which pairs a world asks, the bands, the `walks-<faction>.bin` file |
| `f4/`, `f4walks.rs` | the reader for Leffe's navigation maps and its walks backend |
| `hybrid.rs`, `stage.rs` | the hybrid merge; the entry points `forge build` and `forge walks` call |

Rules for changes:

- If you change what a backend answers for the same ends, bump `MODEL_VERSION` (`walker.rs` for our
  grid, `f4walks.rs` for Leffe's maps). Old answers then stop matching and are asked again. Do not
  key answers on anything else.
- If you change what the walks stage writes, bump `WALKS_VERSION` in the `forge` crate.
- Keep the store's key the ends plus the model. Anything that does not change an answer must not
  be in the key.
- The parity tests in `rust/crates/forge-nav/tests` compare against the old pipeline's saved
  answers and need a grid, so they do not run on CI. Run them with
  `cargo test --release -p forge-nav --test <name>`, before and after a change to legs, the
  walker or the store.
