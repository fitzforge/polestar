# Route simulation and optimization (the JavaScript simulator)

> [!NOTE]
> This describes the JavaScript simulator (`node tools/polestar.js sim`) that made the routes of
> releases up to 0.2.x. Routes are now made by Polestar Forge: see [FORGE.md](../FORGE.md).
> Of the commands below only `sim compare` is still in the repository; the rest, the v2 code,
> `sim serve` and the native CCH addon were removed (commit 734380d2a still has them).

Goal: find, for each faction and each race's start, the 1-60 leveling route
that reaches 60 in the least /played time under one explicit model of the
game, by simulating very large numbers of complete routes; measure how robust
the winners are to the model's uncertainty, and score Polestar's own routes
under the same model.

"Proven" here means: best found under the model, after a search large enough
that more search stops improving it, and still best (or within a stated margin)
across thousands of plausible variations of the model's parameters. Real-world
proof comes from recorded play (`record report`); `sim calibrate` fits the
model's kill time to the same recordings.

Code: `tools/lib/sim/` (Node ≥24, CommonJS, zero npm dependencies,
`worker_threads` for parallel search). CLI: `node tools/polestar.js sim <cmd>`.
Outputs: `data/sim/` and `data/bench/` (both gitignored).

## 1. World model (built once per faction, cached in data/sim/world-<faction>.json)

- **Quests** available to the faction (quests.json race/class masks; class
  quests kept with their class): level, minLevel, prerequisites, exclusive
  quests, next links, giver and ender positions (world coordinates
  via map-frames.json), objectives with workload:
  - kill N of a mob: N kills at the mob's spawn clusters (npcs.json levels).
    A kill objective on an NPC of the character's faction that gives or ends
    the quest, or whose objective text opens with speak/listen/talk/hear/
    show/wait/watch, is Questie's kill credit for a conversation (Kalaran
    Windblade 3441/3453, Tirion Fordring 5742, the faction leaders of
    93739/93963): one interaction at the NPC, never elite; in such a quest
    the other faction's NPC is that faction's counterpart and costs nothing.
    A deed on an NPC of the character's own faction proper (A or H; text
    opening with find/heal/use/locate/keep searching: healing Grunt Kor'ja,
    waking Lazy Peons) is one interaction per credit. A friendly-flagged NPC
    that is really fought (the AH Threshwackonator 2078) stays a kill;
  - collect N items: N / (drop chance) kills of the best dropper, or N object
    uses for object sources, or a purchase from the friendly vendor nearest
    the quest giver. A source on another landmass than the quest giver is
    used only when the giver's has none. Drops without a recorded rate
    (Forever creatures, `null` in items.json) count at 30%, quest-only items
    (`questItem`) at 60%, unless a dropper of the item with a recorded rate
    lives on the giver's landmass or has no open-world site (Kum'isha's
    sphere: 0.01% recorded, one null dropper, stays rare); on Zephras Isle,
    where every recorded strider is on another continent, Galestrider (null)
    is the source of 92553's meat;
  - quest-starting items: the expected kills of the best solo dropper; with no
    recorded rate for the item at all, its droppers count at the same 30% /
    60% (91741 Nibbled-On Book, 97281 A Simmering Storm), elites still not.
    An item handed over by another quest's turn-in (the data has no quest
    rewards; `startItemFrom` in tools/lib/sim/solo.js: the Paladin Tome of
    Divinity 1642/1646 from 1641/1645) starts the quest at that quest's ender
    once it is done;
  - interact/use/event: one visit (plus the object's site); an event counted
    in its text ("Free 6 Webbed Forsaken", "Motivate 5 Deathguards") is that
    many interactions;
  - escorts and defend events: a fixed duration (parameter), run where they
    start. An escort is the guides' (tools/lib/dsl/escort.js `isEscort`: an
    event objective or the objective text says "escort", a corrections.json
    `escort` wins: Lost! 4492 is none); one with no event objective is one
    run at its giver (a friendly NPC's kill credit is the arrival: Tooga
    reaching Torta, 1560; no objectives: 96204, whose one event objective
    has `oi` -1, as no raw objective stands behind it). A defend event
    (protect, defend, keep safe, guide safely, lead to safety, escape: 667
    Death From Below, 98430) is timed the same but is no escort
    (`quest.escort`); both take the high XP tier;
- **Placement**: zone map frames overlap (the Barrens map covers Durotar),
  so one spawn can be recorded on two maps. Such a spawn counts once, on the
  map most spawn records around it use (every NPC and object, 150 yd cells),
  then the map most of the entity's own spawns use, then the map where it
  lies furthest from the edge. Two of the Valley of Trials' Lazy Peons are
  also recorded on the Barrens map; they stay in Durotar, so Lazy Peons is a
  Durotar 1-5 quest, not a Barrens one. Gryphon Master Talonaxe stays in The
  Hinterlands (9.75, 44.47, not Hillsbrad 94.3, 3.5).
- **Givers in several places** (Minor Manifestation of Earth: the Valley of
  Trials and Mulgore): the quest starts at the giver's site nearest its
  turn-in (Call of Earth 1518 in the valley, 1521 in Mulgore).
- **Several givers or enders** (Cenarion Aid 8254: Brother Joshua in
  Stormwind and High Priest Rohan in Ironforge; the two Wanted Posters of
  Tanaris): the route search uses the first friendly one the data lists,
  and the world also keeps every friendly one by entity (`gAlt`, `eAlt`:
  `{ "npc:<id>": point }`, only when there is more than one), so a guide is
  scored at the one it names (§5).
- **Child quests** (Questie `parentQuest`): a child is offered only while
  its parent is in the log, so the parent is not its prerequisite and the
  child is accepted after the parent's accept and before its turn-in. A
  parent whose objective items are its children's rewards turns in after
  them (`turninAfter` in tools/lib/sim/solo.js: Stranglethorn Fever 348
  after 349; The Green Hills of Stranglethorn 338 after chapters 339-342).
- **Prerequisites**: the canonical blocking prerequisites of
  tools/lib/data/prereqs.js, the ones the guide compiler and validator use:
  preAll all-of, preAny (else pfQuest's `pre`) any-of; breadcrumbs (an
  any-of group holding one is optional as a whole: 788 Cutting Teeth needs
  neither 787 nor 4641), exclusive quests, the parent and quests nobody can
  start (786's 785) never block. A DungeonJournal-only quest (no quests.json
  record) keeps its journal chain. A quest with no prerequisite data at all
  (no pre/preAny/preAll/breadcrumbs/breadcrumbFor) gets an implied any-of
  over every quest whose `next` it is (e.g. 5093/5094/5095 -> 5096, never
  only the first). `world.preRules` counts each rule.
- **Exclusive quests** are one-way: quests.json `excl` merges pfQuest's
  `close` (symmetric, both sides list each other) and Questie's exclusiveTo
  (one-way). A quest is unavailable while any quest of its own `excl` is in
  the log or done; taking it closes nothing else. So 287 stays open after
  282 and 322 after 324, while 526 (excl 322, 324) closes once 324 is taken
  and 5601/5142 close each other.
- **Tasks** group a quest's objectives by site (spawn clusters, 70 yd).
- **Hubs**: givers and enders clustered (150 yd), with flight masters, inns
  and class trainers nearby (trainers.json, TravelData).
- **Travel graph**: walking (the walking router's routed walks where `sim
  walks` has them, below; else the straight line × detour factor, per continent),
  flights between known flight paths (TravelData flight times), boats,
  zeppelins and trams (wait + ride, data/forever/travel.json), hearthstone
  (bind, 60 min cooldown, parameter). All-pairs shortest paths over the
  transport nodes are precomputed per known-flight-path set; a leg is
  walk-to-node + network + walk-from-node (the network part must use a
  flight or a ride), or walking, whichever is cheaper. The nodes a point
  walks to or from are, of its eight nearest in a straight line, the three
  a walk reaches, fewest yards first (travel.js; the straight-line three
  only where none walks): on Teldrassil's tree top the dock, portal and
  flight master of Rut'theran below it are nearer than the Darnassus portal,
  and with them 162 of its points reached no other landmass (2026-10-21: a
  Night Elf route stranded there). A place the
  character cannot reach (another landmass with no transport, e.g. back to
  Zephras Isle) skips the step and is counted (`unreachable`).
- **Drop scale**: one drop-rate table per item (items.json `dropScale`),
  never rates from two tables mixed: QuestieDB's server (CMaNGOS) rates
  when they rate any of the item's droppers (`server`: the quest-active
  loot chance), else its observed table (`observed`), else pfQuest's
  (`pfquest`); Questie's manual per-NPC corrections are kept (`corrected`
  when only they rate it). Every other dropper of the item has no rate
  (null: the 30/60% guess), and an item no table rates is `null`. The two
  Questie tables are different scales (one item's rates: 100 vs
  0.37), so a merged item would price one camp against another wrongly.
- **Heights**: world points carry a height (`z`) from CMaNGOS classic-db's
  spawns (spawnz.json: the entity's spawn within 15 yd; a flight node's
  and an inn's from their flight master and innkeeper) and travel.json's
  ends; every other point (Forever-only NPCs, a spawn moved since classic,
  a site's or camp's centre, event spots, hub centres) takes the local
  walking grid's floor (data/local/nav4, `gridFloor`): the column the
  router snaps a point without a height to, and of its storeys (open
  surfaces more than 3 yd apart) the one nearest the height of the
  entity's spawn within 70 yd when there is one, else the router's own
  pick (its lowest indoor floor, else the terrain's top). `heights` counts
  the points by source (`source`, `floor`, `hinted`: a storey picked by a
  nearby spawn, `ambiguous`: several storeys and no spawn, `none`: off the
  grid); the world's hash includes the grid's (`gridFingerprint`). A
  Forever-only NPC upstairs (the Zephras watchtower's, #363) has no height
  of its own, so it stands on the router's floor until a spawn height
  exists. A point's key (`pointKey`) includes the height, so a mesa top
  and its foot, or two floors of
  one x, y, are different points (heights are keyed in 3 yd steps,
  `Z_STEP`, so heights a few yards apart share a point and two close
  heights either side of a step are two).
  City points use the city's own map frame (tools/lib/maps/inner.js, the
  rule the Codex uses).
- **Camps** (tools/lib/sim/camps.js): every kill and item objective's
  sources (its hostile, non-elite, non-rare mobs (droppers at 1% or more,
  or unrated) and objects, merged) clustered by single linkage
  on the spawns themselves: two spawns within 80 yd chain into one camp,
  and a camp spans at most 350 yd (a cluster that would grow beyond starts
  a new camp), centred on a real spawn. A camp records its spawn count,
  extent (`radius`: yards from its point to the farthest member spawn),
  level range, respawn time (classic-db, per spawn) and sources. Camps are
  shared: a camp is its geometry and source set, so objectives with the
  same sources use the same camps, and each objective's drop chances sit
  beside its camp list (`objCamps`: `[objective, camps, { 'npc:2022': 37 }]`).
- **Objectives** (`quest.objs`): one entry per raw objective the quest
  keeps, `{ oi, type, id, count, item, questItem, camps, chances, task }`:
  its index in quests.json's objectives, its kind (`kill`, `item`,
  `object`, `event`, or `talk` for kill credit at a friendly NPC), the
  target (npc, item, object or event id), the count asked, the item and
  whether it drops only on the quest, its camps and drop chances (as in
  `objCamps`), and the index of the task holding its work. Every event
  objective points at the one task placed for them, and any one trigger
  completes the quest: count tasks, not `objs`, as units of work.
- **Quest kinds** (`quest.kind`): `startItem` (accepted from an item:
  a drop, or another quest's turn-in), `delivery` (no objectives, turned in
  elsewhere), `talk` (no objectives, turned in to the giver), else `work`.
- **Exclusion codes**: every quest left out carries a code (`faction`,
  `elite`, `dungeon`, `unplaceable`, `unsourced-item`, ...) beside its
  reason; `sim world` prints the counts. An item objective is
  `unsourced-item` only when nothing names a source: no dropper, object or
  vendor, no hand-out by the quest (start item, source or required items),
  not a turn-in-after parent's, not another quest's reward, not out of
  a container (items.json `containers`) and no NPC the guides name handing
  it over (rules.json `handover`: Patience 99141's three reports, a talk at
  each NPC).
- **Services and training** (tools/lib/sim/services.js): friendly class
  trainers (per class), repair, food and drink, ammunition vendors and
  innkeepers as `{ pt, npc }` per site (`world.services`, Zephras Isle's
  included); flight masters are the faction's flight nodes (with their
  npc). `world.serviceSet` lists the services at each point (trainers as
  `trainer:CLASS`). Class training costs per level come from classic-db
  (data/forever/training.json, `world.training`); `world.classes` is keyed
  by the race labels `starts` uses (Undead, not Scourge).
- **Transit** (travel.json `transit`, the addon's Nav/Transit.lua data):
  lifts as rides between their bottom and top points, the Deeprun Tram
  with its boarding and leaving time (`pre` + `post`) added to the ride,
  and walk-in portals one way. Dock, tram and portal points take the
  height travel.json gives their ends (the board point's, else the
  stop's), so walks to them are routed on the right floor. Each lift end
  has its own zone map: a city's lift (Thunder Bluff, Undercity) has the
  city on its busier floor and the zone around the shaft on the other
  (Mulgore below the bluffs, Tirisfal above the Undercity); any other lift
  end takes the map most particular to the spawns on its floor (the Great
  Lift: Thousand Needles below, the Barrens above). A portal is kept only
  when both its ends lie within 1,500 yd of one of the faction's flight
  nodes or inns (the Darnassus portals are the Alliance's).
- **Walks** (`sim walks`, tools/lib/sim/walks.js; binary schema 5, JSON schemas 2-4 still load):
  the walking router walks every pair of the world's points (quest givers, enders, objective
  sites, package steps and the anchors) up to 4,000 yd apart (`--radius`) on the same landmass,
  and up to 12,000 yd between two anchors (inns, transport nodes, starts and service points;
  `--anchor-radius`), as the faction (its hostile towns cost more) in the arrow's default route
  style (balanced): one one-to-many search per point, on worker threads, into
  `data/sim/walks-<faction>.bin` (`--json` also writes `walks-<faction>.json` to read).
  - **Routers** (`--router`): `lua` (the default: the shipped router; see below) or `node`, opt-in
    until it walks the shipped router's routes (roads, enemy towns, bridges). `node` is tools/lib/nav/router.js over the local
    walking grid (data/local/nav4, format 2): path.js's `routeMany` (the start's tile searched
    whole, the abstract graph, then each goal's tile), the decoded tiles and graphs held once in
    SharedArrayBuffers for every worker (`router.share`). `lua` is the arrow's own router
    (addon/Polestar_Nav, `Path.FindMany`) run by `nav eval`'s harness in LuaJIT workers, about
    1.4 GB each. The node router's cost model is tools/lib/nav/edgecost.js, one static weight per
    directed step (the one place it is written down, for the Rust port too): time, faces (pack.js's
    face rule, approximated: a land link onto a steep column or up a 50-60° slope costs 40 times, a
    climb 1000 times), roads (Costs.lua Balanced's 0.8 on the walking maps' road columns: the roads
    layer through roadmask.js, `<grid>/walk/roads-<c>-<tag>.bin`), swimming (3 running yards a swum
    yard in all, the maps' swim factor), hostile hubs (20 times inside the other side's hub disks)
    and zone danger (by the chunk's zone, from AreaTable, as the walking maps' zone field). The
    abstract graph is repriced once per grid and faction with those terms
    (`<grid>/walk/<c>-<graph>-<tag>.f32`, `router.prepare`), so its edges cost what their way on the
    grid does; zone danger on it by each edge's zone mix (the shares of its way's seconds per zone,
    `<grid>/walk/<c>-<graph>-<tag>.mix`). An end in a pocket the walk cannot leave or enter is moved
    to the nearest surface around it that works, as Routing/Path.lua settles one, and an end with a
    height stands on a surface at that height within 36 yd, as its snap does. `sim walks --parity N`
    compares the two on N sampled pairs of both factions and every band (yards, cost, walkable,
    one-way) into `data/sim/walks-parity.json` (`--dir`: the node router's grid).
  - **From the router** (tools/lib/sim/walktables.js, step E): a run that finds no walks for its
    world (`loadWalks` from `v2Walks` and `loadWorld`) asks the router for them itself, no
    `sim walks` stage: each (faction, band) table by `router.distanceRows` (the js backend, or the
    contraction hierarchy's), kept in the shared store (`cas.js`, kind `walktable`) under a key of
    the router (fingerprint, backend, `metricKey`), the band's danger and its place pairs (place
    keys with the coordinates sent), then assembled into the same walks document. A changed world
    with the same places, grid and weights reads every table back; a base walk keeps its zone
    cells, so a new danger grid re-routes nothing. Needs `nav prepare` on the grid
    ($POLESTAR_GRID names another grid than data/local/nav4).
  - **Zones**: each base walk also carries its yards per zone (`zones`: the zones of
    world.danger's 200 yd cells). The node router returns the cells its path crosses with
    every walk, so the zone shares are recounted from those cells whenever the danger grid
    changes, without routing. The lua router has no path from `FindMany`: a walk whose every
    possible way stays in one zone's cells is that zone's whole; any other is routed on the
    local grid (`nav.route`) and its yards split as that route falls, kept in
    `data/sim/walkzones-<faction>.json`. The faction-territory cost and case C67 read them.
  - **Bands**: band 0 is the base walk, without zone danger, for every
    pair. Each danger band (character levels 10, 20, 30, 40, 50 by
    default, `--bands`; band b stands for levels b-5 to b+5) re-routes only
    the pairs whose straight line crosses a zone, other than the two end
    zones, at least 4 levels above b (where the router's danger starts),
    one search per point and target zone; every other pair walks band 0's.
  - **Cost and yards**: each walk keeps the router's cost (time with its penalties; the node
    router's is seconds × 7, yards at walking pace) and its yards. A walk's yards are the routed
    yards × the router's smoothing (the doc's `smooth`: node 0.961, measured on 558 base walks,
    p10 0.941, p90 1.028; lua 0.965, on 67 pairs: the walk search measures the grid's steps, the
    arrow walks the smoothed, drawn line) × `routeMul` (prior 1 ± 0.05: a player strays a
    little from the line).
    v1's search reads band 30 where it was re-routed, else band 0; walks
    to and from transport nodes, between nodes and the order of a
    package's steps use them too. A longer walk, or one the router could
    not find, keeps the straight line × detour.
  - **Heights**: where the local walking grid is built (data/local/nav4),
    each point is sent at the x, y of the grid's walkable surface for it
    with its own height, so a point a few yards inside a wall or prop is
    still walked to; a pair the router cannot walk is asked once more with
    the surface's height too (the grid's floor and the stored height
    disagree at lift landings and z-less city points).
  - **One-way walks** (descents, #363): a base pair whose ends' stored
    heights differ by more than 15 yd (`ONE_WAY_DZ`) is searched from its
    other end too (one search per start, after the base walks). Where the
    two directions' yards or costs differ by more than 2% of the shorter
    (`SAME_REL`, at least 1; inside `routeMul`'s ±5%), each is kept as a
    one-way walk (`[a, b, yards, cost, 1]`; a both-ways walk is
    `[a, b, yards, cost, 0]`), so a slope or a drop walked down is priced
    shorter than the way back up; where they are alike, or only one walks,
    that walk serves both ways. The cache's key order is a search's
    direction, so a rebuild asks neither direction twice. Danger bands stay
    one search, both ways. A schema 2 file (pairs of 4, all both ways) is
    still used; a walks id records the height threshold (`:dz15`).
  - **Cache by place**: every answer, failures too, is kept keyed by place (continent, x, y and
    height rounded to 2 yd) and band, with the walking maps', route style's and danger's
    fingerprints: `data/sim/walkcache-node-<faction>.bin` (node: typed arrays, each band walk
    with the multipliers of every zone it could have entered, the zones within its cost's
    ellipse) or `walkcache-<faction>.json` (lua). A rebuild on a changed world routes only the
    pairs it has not asked before; on the node router a band walk is routed again only where
    the multiplier of a zone it could have entered moved (lua: a changed danger fingerprint
    re-routes every band walk); walks from places no longer in the world are pruned. A changed
    world whose points and walking maps are all cached gets its walks file reassembled from
    the cache when it is loaded (`loadWalks`), with no routing. The walks file is used only on
    the world (data hash) and walking maps it was built on, and a search result records
    whether it was searched with walks (`--no-walks` walks the straight line × detour anyway).
  - **Failure report** (`sim walks --report`): the cached walks of a band
    the router could not make, by why: `separate` (the ends lie in
    different grid regions, or the grid's route either way rides a lift,
    which the sim rides as a network ride, or climbs where the pack closes
    the climb, or has no path one way; two ends of one city in different
    grid regions count as `unknown`, not `separate`), `noHeight`, `offGrid` and
    `unknown`, with the 20 worst unknown walks and a `walkGap` list of the
    places reached only over closed climbs (Shadow Hold, Thunder Bluff's
    rise: the sim can't walk there yet). It exits 1 when `unknown` is over
    0.5% of the band's cached walks whose two ends are current places.
  - **Walks to camps**: the camps any kept objective works at
    (`quest.objs[].camps`) are walk points too, with shorter reaches: a camp
    walks to any other point up to 1,500 yd away (`CAMP_RADIUS`) and to
    another camp up to 600 yd (`CAMP_CAMP_RADIUS`); a camp point that is
    also another kind of walk point keeps that point's reach. They are
    routed on top of the existing walks, so the cache by place routes only
    the new pairs; `sim walks` logs each band's camp points and pairs.
  - **Walk lookup** (tools/lib/sim/walklookup.js): the walks as the
    simulator's workers hold them, one compact table per band (each point's
    neighbours sorted in typed arrays; a both-ways walk under both ends, a
    one-way walk under its start only) instead of Maps. `get(a, b)` gives
    the one-way walk from a to b where there is one, else the both-ways walk.
    Its yards are the router's × `SMOOTH` and its cost as stored, as
    attaching the walks gives them; a pair stored twice keeps its last walk.
    A band other than 0 falls back to band 0's walk for a pair it did not
    re-route. The simulator (next) reads its walks here.
  Why route them: measured on the 3,103 walking legs the default guides of
  the 8 starts use (2026-10-17), the straight line × 1.3 is right on
  average (routed 1.31 Eastern Kingdoms, 1.34 Kalimdor) but wrong both
  ways, about 2.1 h per start too slow within zones (open ground is nearer
  1.1-1.2) and 2.1 h too fast between them, nearly all of it 97 legs
  straight through a mountain or a cliff (Silithus to Feralas: 1,785 yd
  straight, 13,807 walked; the Barrens to Thousand Needles: 325 and
  4,168). A factor per zone or per pair of zones fixed neither, so the
  walks are routed one by one. With walks the search needs longer to
  settle: `--paths 3000000` (the default 1,000,000 stopped Human at a
  route 5 h worse).
- **Areas** (`world.areas`, `world.pointArea`; tools/lib/sim/areas.js): the
  places a route chooses between. Every point the simulator stops at (quest
  givers and enders with their alternatives, task and accept points,
  objective camps, service NPCs, inns and transport nodes) belongs to
  one area of its region (`pointArea`; -1 only for a point that is none of these), built greedily and deterministically:
  1. **Hubs**: a hub seeds an area when it has at least 3 givers or owns a
     flight master or inn (the nearest hub listing it); seeds closer than
     200 yd (half the 400 yd town span) merge into the one with more
     givers, so a town is one hub area.
  2. **Towns first**: every point within 200 yd of a hub seed on its region
     joins the nearest one, inns included.
  3. **The rest**, by complete linkage: a point joins the nearest area whose
     every member is within 250 yd of it, or starts a new one.
  Distances are straight lines (walks to camps are routed after the world
  is built), so areas do not follow walls. An area records its point (the
  member nearest its centre), members, whether it is a town, and how many
  of its members are givers, enders, camps, services, nodes and tasks.
  Each world records the builder that made it (`builderVersion`, now 23);
  the real-data tests fail on an older one.
- **Travel safety**: each zone's level is the P10 of its hostile normal-rank
  spawns (the `maps build` ZoneLevels heuristic, tools/lib/maps/zonelevels.js),
  and each 200-yard cell of a landmass belongs to the zone with the most NPC
  spawns in it (gaps filled from neighbours up to 600 yd). A direct walk
  whose straight line (sampled every 200 yd) crosses a zone, other than the
  ones it starts and ends in, whose minimum level is 5 or more above the
  character costs `deathRisk` seconds per such zone (deaths, corpse runs,
  detours; prior 300 ± 150 s), so the flight/boat path wins when it is safer.
  Crossed zones are sampled once per point pair and cached (measured cost:
  0.22-0.29 ms per full route evaluation, vs 0.20-0.24 ms without).
- **Packages**: the unit the route search orders. A package is one visit to one
  zone doing a set of quests: built by splitting each zone's quests by quest
  level into bands (default width 5, parameter) and keeping chains inside a
  package when their levels allow; every quest belongs to exactly one package
  per split. Each package precomputes: entry hub, internal task order
  (nearest neighbour + 2-opt, as `draft` does), internal walking distance,
  per-quest kill counts by mob level, quest XP tier estimates, and the flight
  paths and inn it offers.

### Solo filter (tools/lib/sim/solo.js)

The solo world keeps only quests a levelling character can do alone. Each
exclusion has one category, counted by `sim world` (`world.solo.counts`):

| category | rule |
|---|---|
| dungeon, raid, pvp | the quest's Questie area (zoneOrSort) lies in an instance (an area on a map with Map.csv InstanceType 1 / 2 / 3, the instance map's own area, or an entrance subzone named after the instance: Gnomeregan 133, Uldaman 1517), or it is a dungeons.json dungeon quest, **and** its giver or ender has no open-world site or one of its objectives cannot be placed in the open world (no open-world spawns, drops only inside, an item made nowhere, an event without a place). The area is the quest's story zone, so talk breadcrumbs and outer-cave quests whose work is outside stay (2864 Tran'rek, 721 A Sign of Hope, 709 Solution to Doom, 6562/6563, 8263, the Unending Torment chain in the Undercity) while 92421/92422 (work inside the Ruins of Lordaeron) stay out. Forever client build 1.60.1.70338 (wago.tools, cached in data/sources/wago/). |
| elite | a kill objective on an elite (rank 1-3); or a collect objective or quest-starting item whose only droppers are elites or mobs 5+ levels above the quest level |
| rareDrop | a collect objective whose every dropper is below 1%, a rare spawn (rank 4), or a friendly NPC with a low "drop" rate (killed by the other faction) |
| reputation | needs more than Friendly (3000) with a faction |
| repeatable | a repeatable quest without a recorded reward that no other quest needs |

Every quest counts once. A repeatable another quest needs (349 for 348's
turn-in) is kept and gives no XP unless its reward is recorded. A quest
whose prerequisite was excluded is unreachable at run time, so a chain after
an excluded quest goes with it (the Mau'ari E'ko chain after 969). The
Forever client's QuestInfo table (1 Elite, 41 PvP, 62 Raid, 81 Dungeon)
only names the types; which quest has which type, and suggested group
sizes, are server data that neither the client tables nor QuestieDB carry,
so the types are derived from areas and objectives as above. The compiler
applies the same dungeon/raid rule from the data (`instanceQuest`, without
dungeons.json) to tell players which goals are a dungeon or raid run
(GUIDE_FORMAT.md, "Group content").

`OVERRIDES` in solo.js is the explicit hook for what the data cannot
express: `exclude` (Naxxramas-era Argent Dawn turn-ins 9124-9142 and
armaments 9221-9228; Luck Be With You 969, whose shards lie among the
Frostmaul giants; Brann Bronzebeard's Lost Letter 8308, whose non-elite
droppers are hive-event spawns; Concerted Efforts 8371/8385 and the Eastern
Plaguelands tower captures 9664/9665 (PvP); the corrupted plant quests and
their Salve via ... turn-ins, Smokey LaRue's crafted 6026/6041 and the
Midsummer flame thefts 9324-9326/9330-9332, without a category), `allow`
(keep a quest whatever the rules say, the profession rule included: the
Cooking rank 1 quests 384 and 4161, whose cooking trainer the starting-zone
guides visit; Unending Torment 97291, whose Blisterweed has no data) and
`turninAfter` (348 after 349, 338 after 339-342, 812 after 813, 5060 after
5059, 1190 after 1191: the children pay no XP but the parent needs their
work). The dungeon family re-admits dungeons.json's quests as dungeon
packages.

### Starts (route rules)

- **Zephras Isle is Skyborne-only**: quests whose giver, ender, quest-starting
  drop or objective sites are on the isle maps (2521, 2665) are closed to
  every other race. The isle's exits (Horde airship to Mulgore, Alliance
  zeppelin + portal to Stormwind) are one way.
- **Home first**: a route must run its home packages before any other: the
  start zone's first band (1-5, chains kept with it) for the Era races, every
  Zephras Isle package for the Skyborne (who leave the isle at about level
  12, after it). A route that puts another package first is infeasible;
  construction draws only home packages while any are left.
- **No continent change before level 10**: a package on another continent
  than the start, or on another starting island (Teldrassil for non-Night
  Elves, Zephras Isle), entered below level 10 makes the character grind to
  10 first (counted). Dwarves/Gnomes and Orcs/Trolls leave their continent
  at 10+.
- **Catch-up (robustness only)**: when `sim robust` re-evaluates a route
  under a parameter draw, a package in which nothing could be done because
  every available quest is above the level gate (`gateGap`) makes the
  character grind to the gate's level and run it then: the route is followed
  as a plan, under-levelled, as a player would. Without it one gated package
  skipped the rest of the route and the character ground to 60 (the old
  Tauren robustness tail, 90% interval 93-225 h). The search does not use it
  (it would turn the gate into "grind to any package": a trial run let the
  Human route grind 6 -> 26 before Duskwood).
- Guide sequences (`sim compare`) are scored as written: only travel, levels
  and prerequisites apply, not these route rules. Their `optional` goals are
  left out (§5).

### Rules (data/rules.json)

Game facts players reported that the data can't show: timers, gates,
item-gated steps, purchases, patrols and rides. The file is hand-maintained
(`{ "schema": 1, "rules": [...] }`); each rule has an `id`, a `kind`, its
kind's fields, a `fact` in plain words and a `source` (`refs`: the issues,
PRs or tests it comes from, `credit`: the players who reported it, and
optionally the `guide` line it fixed). The kinds and their required fields:

| kind | fields |
|---|---|
| `before`, `together` | `a`, `b`: `{ quest, step: accept\|turnin\|objective }` |
| `notBefore` | `quest`, `level` |
| `afterTurnin` | `quest`, `after` |
| `at` | `quest`, `objective`, `map`, `x`, `y` |
| `avoid` | `npc` |
| `timer` | `item`, `seconds`, `from`, `to` (step refs) |
| `skip` | `quest`, `reason` |
| `requires` | `quest`, `item`, `place` (`{ map, x, y }`) |
| `buy` | `item`, `vendor` (optional `price`, `stock`, `quest`) |
| `make` | `item`, `from` (`[{ item, count }]`; optional `tool`, `quest`) |
| `patrol` | `npc`, `path` (`[{ map, x, y }]`) |
| `ride` | `quest`, `from`, `to` (places; optional `seconds`, the taxi path's time otherwise) |
| `exclusive` | `quest`, `closes` (quest ids) |
| `classLock` | `quest`, `classes` (class file names) |
| `learn` | `quest`, `trainer`, `skill` (optional `cost`): a paid lesson the quest needs |
| `handover` | `quest`, `objective` (0-based), `item`, `npc`: the NPC who hands the objective's item over in gossip (the guide's `collect <item> quest <q>.<n> npc <id>`); the world builder counts the item sourced, a talk at the NPC |

A rule seen only in recorded runs carries `unconfirmed: '<why>'` (a soft
rule). `checkRules` checks every rule before a route uses it, and fails
closed: an unknown kind, a missing or malformed field, a missing `fact` or
source refs, or a quest, NPC or item id found neither in the world nor in
data/forever (the other faction's ids), is an error, never skipped; with no
id set to check against, every id is an error. `rulesFor` indexes the rules
by quest, NPC and item. The simulator (next) reads the checked rules.

### Acceptance cases (tests/fixtures/sim/cases/reported.json)

Every reported route problem as a checkable property of a route's action
list (`tools/lib/sim/cases.js`), with its faction, source refs and the
reporters' credit. An action is `{ t, level, area, pt, act, quest?,
objective?, camp?, npc?, item?, via? }`; a ref picks actions by any of
quest, step (`accept`, `turnin` or `objective`: a kill, loot or use),
objective, item, npc, camp, area and act; `objective` is the index in
quests.json's objectives (`oi`), and `camp` a world camp id
(`caseActions` turns a v2 route's actions into these). A visit is a run of
work in one area; travel that comes back to the same area doesn't end it.
The properties:

- `before` (a's first action comes before b's), `beforeOrSameVisit` (before
  b's, or in b's visit: within a visit the order is the NPCs' walking
  order), `sameVisit`, `notBefore` (no accept below a level), `never`, `taken`;
- `singleVisit`: a set of quests done in one visit, moving between their
  own areas allowed; `steps` limits which of their actions count and
  `match` (refs) which objective's;
- `campOf` / `notCampOf`: an objective's camp work within (or not within)
  some yards of a map place; `onLeg`: an action done on a walk leg;
  `boundAt`: every hearth goes to the inn last bound, optionally among
  named inns; `hearthSpacing`: consecutive hearths at least the
  hearthstone's cooldown (or `minSec`) of play apart (#576); `mode`: trips
  from one place to another use a travel act and not others.

A case marked `todo` (a reason) is not checkable yet. Loading checks ids
(unique), faction, property, source refs and the `steps` and `match`
lists. A case need only be satisfiable by some feasible route (today's
guides may fail it), never impossible by construction.

## 2. Character and XP/time model (parameters with priors in data/sim/params.json)

- XP to level: the Classic table (tools/lib/game/xp.js, shared by every tool).
- Quest XP: the client's QuestXP table (wago.tools DB2 `QuestXP`, cached under
  data/sources/wago) at the quest's level and an estimated difficulty tier:
  breadcrumbs (no objectives, talk to someone) low, normal kill/collect quests
  middle, chain ends, escorts and group quests high; recorded quest XP
  (quests.json `xp`) overrides the estimate. Reduced by level difference:
  100% up to quest level + 5, then 80/60/40/20/10%.
- Kill XP: the Classic mob formula (45 + 5 × level, ±5% per level of
  difference above, zero-difference table below, nothing for grey), elites ×2,
  rested XP optional.
- Kill time: per-level base time (fight + downtime) × level-difference factor
  × class factor; travel between mobs inside a site from spawn density.
- Speeds: run 7 yd/s, mount ×1.6 from `mountLevel` (default 40), flight and
  transport times from TravelData.
- Grinding fills gaps: when no package is worth doing, the character grinds at
  the best site for its level (kill XP per hour at Δ = 0..+2). "Grinding" is
  only killing for XP with no quest involved; kills for objectives and drops
  are quest work (`xpSplit.kill`).
- **Shared kill credit** (game rule): a kill counts for every quest in the
  log that wants that mob. Kills (and drops) for one kill or collect
  objective also count for the other active quests' objectives on the same
  mob whose site is within 100 yd (`SHARE_R`, run.js), up to what each still
  needs; that objective then needs only the rest, and one fully covered
  needs no trip. Kills before a quest is accepted give it nothing. The kill
  XP is earned once (`sharedKills` in results: the kills saved).
- Route policies (not measurements; reported times stay real): routes are
  compared by time to 60 with every hour of grinding counted 2.5 times
  (`grindWeight`) and every move into another zone counted 7.5 minutes more
  (`zoneChange`, `zoneChanges` in results). So a route grinds only where no
  quest is nearly as good, takes a hub's quests, does them in one go and
  hands them in, and switches zones only when it is clearly worth it. With
  neither, the search ground wherever the next quests were barely better
  (Orc consensus: 46 h of grinding in 129 h) or flew across continents for a
  single quest (Orc at 40-60: 32 visits in 41-50 and 62 in 51-60, 58
  hearthstone uses). The values come from a sweep on the Orc and Human
  searches (600k routes each): a stronger zone weight brought grinding back
  (Human 23 h at 600 s with weight 2), a stronger grind weight brought the
  single-quest trips back; 450 s and 2.5 gave Orc 121.5 h with 2.9 h of
  grinding and 22 visits for one quest or none, Human 120.7 h with 10.2 h
  and 23.
- Quest log limit 40 (Forever's client: `MAXIMUM_NUM_QUESTS_LOG_CAN_ACCEPT = 40`
  for its Camelot game type, `Blizzard_APIDocumentationGenerated/QuestConstantsDocumentation.lua`;
  the quest log shows N/40; issue #30): a package that needs more open
  quests is split. It is a world option (`maxOpen`, recorded in the world
  file; a world with another limit is rebuilt). The results up to 0.2.5
  were searched at 20. The evaluator holds the log to it across the whole
  route: an accept with the log full waits (deferred like an accept above
  the character's level: taken in the same pass once a turn-in frees a
  slot, else in the package's second pass or a later return; still full
  there, it is skipped and counted). A stopgap until sim v2 plans the log:
  when the log is full, the character abandons the lowest-level quest in
  it at least 6 levels below it (`ABANDON_GAP`, evaluate.js; its reward is
  already reduced), losing that quest's progress, and waits only when none
  is that low. Without it, quests a route accepts and never hands in (65
  in the 200k-route Orc time route) filled the log for good: today's best
  routes went from 123.5 to 173.3 h. Results report `logPeak` (at most the
  limit), `logDeferred` (accepts that waited), `logSkipped`,
  `logAbandoned` and `acceptedNeverTurnedIn` (accepted at some point, not
  turned in by 60: wasted accepts).
- Every parameter has a prior (mean and spread). Calibration (§4) narrows
  them.

### Objectives (`--objective time|smooth`)

What the search minimises is set by the policy parameters above; the
objective chooses them (params.js `OBJECTIVES`, one place). Reported times
stay real under either.

| objective | zoneChange | zoneReturn | spotReturn | grindWeight | wastedAccept |
|---|---|---|---|---|---|
| `time` (default) | 450 s | 0 | 0 | 2.5 | 0 |
| `smooth` | 900 s | 1800 s | 900 s | 4 | 600 s |

- `zoneReturn`: seconds per move back into a zone the route was in earlier
  and left (the first entry is free).
- `spotReturn`: seconds per return to a spot already worked: work (accept,
  objective, turn-in) in a 250 yd cell (`SPOT_CELL`, run.js) where work was
  done in an earlier stretch. A stretch ends when the character moves more
  than 600 yd (`SPOT_LEAVE`, evaluate.js) from where it began.
- `grindWeight` 4 under smooth: grinding never moves, so with the return
  penalties alone (2.5) the search ground instead of questing. Horde Orc,
  200,000 routes, seed 1: time 123.5 h to 60 with 9.3 h of grinding, 105
  zone changes, 73 zone returns, 507 spot returns; smooth at 2.5: 131.3 h,
  52.4 h, 38, 8, 219; at 4: 127.4 h, 28.8 h, 57, 25, 365; at 6: 126.5 h,
  16.3 h, 85, 50, 433.
- `wastedAccept`: seconds per quest accepted and never handed in (given
  up for a full log, or still in the log at 60). Taking a quest only to
  drop it is not smooth: Horde Orc, 100,000 routes with walks, the smooth
  objective without it gave up 42 quests and left 63 never handed in.

Smooth results are their own files (`<faction>-<race>-<class>-smooth.json`,
`consensus-<faction>-smooth.json`, `compare-…-smooth.json`), so the two
objectives never overwrite each other. Results, `sim compare` rows and the
`sim run` report carry the smoothness counters next to the hours:
`zoneChanges`, `zoneReturns`, `spotReturns`, `sharedKills` and the quest
log counters above.

`--param key=value` (repeatable) sets any parameter of params.js after the
objective's preset, fixed at that value (also in robustness draws); an
unknown key is an error. A variant gets its own result files only with
`--tag <name>`: `sim run --objective smooth --param grindWeight=6 --tag g6`
writes `horde-orc-any-smooth-g6.json`, and `robust`, `compare` and
`consensus` with the same `--tag` read and write that variant. Results
record `overrides` and `tag`.

## 3. Route evaluation and search

- A **route** is an ordered list of packages starting at the race's start zone
  at level 1. `evaluate(route, params) -> { seconds, levelAt[t], timeTo[10..60],
  xpSplit {quest, kill, grind}, travelSeconds, perPackage[] }`, deterministic for
  given params, fast (target ≤ 1 ms per full route) so millions run in minutes
  across 16 cores.
- Feasibility: prerequisites done earlier (or inside the same package), level
  ≥ minLevel on arrival (else grind first, counted). A package runs up to
  three times: a return does only what opened since, so quest chains that go
  to another zone and back are kept (Scholomance and the Argent Dawn turn-ins,
  Loramus in Azshara); home packages run once.
  A package runs in its tour order (by place); an accept still too low for
  the character is taken as soon as the level allows, within the same walk,
  and does right away the objectives and turn-in the tour has already passed,
  and any passed accept its turn-in opens (Lazy Peons, then Thazz'ril's Pick
  at the same foreman). A second pass does only what is still too low after
  the whole tour (grinding first).
- **Search**, per faction and start race (class factor as a parameter):
  1. randomized greedy construction (next package chosen with probability
     ∝ exp(XP per hour of package incl. travel to it / τ); a package already
     run is a candidate again and scores only what opened since);
  2. local search on the best routes (swap, insert, drop, add, replace,
     merge; add and replace also bring returns) and simulated annealing;
  3. restarts until the best route stops improving over the last N% of samples
     (report the convergence curve);
  4. at least 10^6 evaluated routes per faction by default (`--paths`).
- **Robustness**: draw K parameter sets from the (calibrated) priors (default
  K = 2000), re-evaluate the top routes under each, and report each route's
  win rate, mean and 90% interval of time to 60, and which parameters flip the
  ranking.

### Zone plans (`sim zoneplan`, `sim route --zone-plan`; tools/lib/sim/v2/zoneplan.js)

The plain greedy picks the best next area anywhere, so its zones fragment
(V2vsShipped: 236 zone changes on the Horde Orc route's guide text against the
shipped guides' 117). A zone plan gives the route zone-level structure: an
ordered list of blocks `{ map, zone, from }` (map: the zone's uiMap id; from:
the level the block starts at), in `data/sim/zoneplan-<faction>-<race>-<class>.json`
(schema 1, with the dataHash it was made on).

- `sim zoneplan --faction F --race R --class C [--stream FILE]` seeds one from
  the shipped default chain for the start (the loader the guide-text metrics
  use) or from a guide-text goal stream: consecutive goals in one zone are a
  visit, a visit of fewer than 3 goals is a pass through and is dropped, and
  neighbours in the same zone merge; each block starts at the level the v1
  model reaches there along the guide.
- `sim route --zone-plan FILE` runs the greedy inside the current block
  (State scalar `zoneBlock`, journaled): its candidates are the block zone's
  areas and the class trainer's trip; other work waits for its block or is
  done in passing on a leg. **Training:** a trip is due 2 levels behind
  (services.js `TRAIN_BEHIND`, 4 until 2026-10-21: the routes trained about 5
  times to 60, the shipped Warrior guides 23-24). Under a plan it goes to the
  nearest class trainer in the block's zone, first (decide.js
  `ctx.trainArea`; a trainer area has no XP, so the ranking never chose it),
  never to one outside the block (that trip, 6 levels behind until
  2026-10-21, cost the Orc route 30 zone changes and returns; at 4 levels
  behind and first, 5 guide zone changes, 2 continent changes and a case).
  A leg to a trainer's area trains on arrival, not in passing. A trip, or
  a detour to a trainer off the walk (beyond 60 yd, up to 300), is taken
  only when a due rank is worth it (Services.worthDue, compile.js
  `trainWorth`: a new ability or a rank of the class's core spells,
  tools/lib/game/core-spells.json, from training.json `spells`, the TDB's
  sniffed class lists named from the client's SpellName); a trainer on the
  walk or at a stop trains any due rank, and nothing due is no step. The
  train action carries the levels it trained (`from`, `to`) and what the
  ranks it couldn't buy still cost (`short`); the guide's step lists the
  spells ("Train: Heroic Strike (Rank 3), Charge (new)"). **Town training**
  (decide.js townTrain): where a network leg sets foot in a
  town (its first and last node, a boat or zeppelin landing, a walk between
  two flight masters, the hearth's inn), at 2 levels behind with a rank worth
  it due, a class trainer within 600 yd is walked to and back (paid) and
  trains; a landing mid-leg splits the leg's travel action in two (the first
  `part: 1`), so the guide trains in the town the player stands in (placed
  after the whole leg it counted 2 more continent changes). The Orc Warrior
  trained at 4, 6, 9, 10, 20, 28, 43, ... before (15 levels without), at
  most 6 levels apart with it. At 6 levels behind (`TRAIN_FAR`) the trip
  leaves the block for the nearest trainer, first: the classes whose
  trainers the route's towns don't hold (Druids, Shamans, Paladins). The
  audit summary's `trainGap` is the longest a due rank waits for its trainer
  (`trainGapAt` its level; a stretch where the class list teaches nothing,
  the Tauren Druid's 8-14, waits for nothing). The block's zone takes the whole hub: a quest
  whose turn-in and work lie in the zone is accepted however far its giver
  stands (the accept rule's reach checks R1 and R3 are lifted; the +2 level
  window and the worth rule stay). So are blocks ahead (sweep.js
  `planAhead`, 2026-10-21): a quest whose work lies in zones of blocks from
  this one on and whose turn-in lies in a block at or after the last of
  them, each starting at most 5 levels (`PLAN_AHEAD`) above the quest's, is
  accepted too (Horde 5 starts: grind 55.9 -> 54.6 h, zone changes and
  returns -0.4). The route moves to the next block when no
  work in the zone beats grinding and its level has reached the next block's
  `from`; until then it grinds in the zone (a camp elsewhere only when the
  zone has none). A block's work is judged from inside its zone: from
  outside it, as from the zone's nearest candidate area (decide.js
  blockBeatsGrind; the trip there and the zone change are the plan's,
  decided already), for the hand-over and for the decision's grind check
  alike. A block left in the decision it was entered counts as a
  plan skip (`planSkips`). The last block is the plan's tail: the route stays
  in its zone to 60 and grinds there once its work is done (no clean-up
  trips across continents after it).
  A quest given in a zone no block covers is not taken (reason `no-block`).
  A block is not skipped, nor ground in from outside, only because its zone
  can't be walked to from where the route stands (a walk-graph gap,
  2026-10-21: a Night Elf route left at a Teldrassil point whose walks reach
  only Teldrassil and Darnassus skipped every block to the tail and ground
  149 h): the route first gets out (decide.js `escapeStranded`), by the
  cheapest of a walk to a nearby area whose walks reach the zone, the
  hearthstone (its cooldown waited out) or a deathskip, and logs a
  `stranded` action; the route audit counts them (`stranded`, a gate
  check: 0).
- **Grinding under a plan** follows the plan's block count: a block reached
  below the level the seed guide had there finds its work gated and grinds
  (e199342a0 world, routed walks: the shipped seed's 77 blocks ground Orc
  61 h, Human 56 h, the plain greedy 27 h and 34 h; the greedy's own 185-block
  visit sequence as a plan, 26 h and 34 h). The quests the plan routes missed
  were nearly all in zones the plan has, at other levels (reason `no-block`:
  6 and 58 quests, 8,000 and 22,000 XP).
- `sim zoneplan --refine N` adds blocks (up to N blocks in all; 0: no cap)
  to the seed for that XP (zoneplan.js refineZonePlan): the quests the plain
  greedy route hands in and the plan's route doesn't, by zone and level
  bucket; a block of the zone for the largest of them, at the plan's place
  for the level, is kept when the route grinds less and no smoothness metric
  rises (the guard: zone changes, zone returns, continent returns, same-mob
  splits no higher than the starting plan's). `--from FILE` refines that plan
  instead of a fresh seed. Each trial is a route run (about 2 s), so a
  refinement takes minutes. Horde, 2026-10-21: guarded without same-mob
  splits, 5 starts' grind 60.3 -> 54.0 h at equal zone changes and returns,
  but the Orc guide's same-mob splits 51 -> 63 and continent changes 20 -> 22;
  with them, nothing added. The default plans are not refined.
- **Grind targets** (compile.js `cGrindNpc`, grind.js): a camp is ground on
  an NPC that stands there for anyone. Rares (rank 4 or role rare), NPCs
  with one spawn in the world (event or quest-only spawns: Murkdeep) and NPCs
  a quest summons by an item (mechanics `summon-by-item`, no static spawn:
  Ishamuhale) are no grind targets. A camp with none is no grind camp, and a
  grind step is named after the camp's grind NPC (PRScan P-d).
- **Knowledge-base places** (compile.js `atKbPlace`): a single-drop item
  objective whose driving mechanics step loots it at a named place keeps only
  its camps within 300 yd of that place (470 Digging Through the Ooze: the
  oozes at Ironbeard's Tomb, not the zone's 18 ooze camps; PRScan P-c, #628).
  It applies to 19 Horde and 9 Alliance objectives.
- **Class value** (compile.js `classValue`, RouteLessons 8): a class quest
  that teaches a spell (the knowledge base's `rewardSpell`) and every class
  quest before it in its chain are worth a quarter of a level's XP more than
  their XP (sweep.js `acceptXpAt`) and are taken however grey. Orc Warrior:
  The Affray (Berserker Stance), refused grey at 40 after The Islander's late
  hand-in, is done, at no measurable cost (measured with the TDB's reward
  spells before the field reached data/forever).
- **Guides a player can follow** (`sim guides`; v2/export.js, checked by
  v2/exportcheck.js; the 2026-10-21 playable audit of Orc and Human 1-20):
  every move to another zone or hub is a step: a walk names where to, a
  flight is `fly` (with `getfp` where it is learned), a boat, zeppelin, tram,
  lift or portal is a step at its dock, a leg of several hops one step a hop
  (a leg a town stop splits, `part: 1`, by each part's own hops), and the
  way's accepts and turn-ins at the leg's end come after it. An item-started
  quest is `collect <item>` then `accept Q item <item>`, after the route's
  kills at the dropper's camp; a dropper 3+ levels up (sweep.js `START_ABOVE`,
  which the route no longer takes) or elite only `when has <item>`. A quest
  several NPCs give names the one at the route's stop (`accept Q npc N`,
  `object N`) and the step is titled by it. A capture is a `use` of the
  quest's item on the mob; a quest's parts from the knowledge base come in its
  order; an `along` objective the next turn-in needs holds a step before it.
  Held-only items (compile.js `heldOnly`: a quest item, or an item objective
  no vendor sells and fewer than 200 creatures drop, as items.json's
  `questItem` misses some, Flask of Oil and Murloc Eye; cloth drops for
  anyone) are never bagged before the accept, and a quest whose item
  objective nothing in the world gives (compile.js `unsourced`: An Apple
  Treat's applejack, the reward of a repeatable left out) is left out. Tips
  are cleaned (`cleanTips`: no addon or site, raw id, "the data", other
  faction, class or race; counts from the objectives). `checkSteps` lists
  what is left per start in `<dir>/checks.json` and prints `checks:`; all 51
  starts print `none`. Cost: Orc Warrior 144.6 -> 146.3 h, Human 144.4 ->
  144.7 h (mostly the unsourced quests left out, 0.8 and 0.7 h; the
  held-only items and the dropper gate move each 0.3 h or less).
- **Default plan:** `sim route`, `sim guides`, `sim cases` and `sim search`
  (every runRoute without an explicit plan) use the start's plan in
  tools/lib/sim/v2/zoneplans/ (`<faction>-<race>-<class>.json`, else
  `<faction>-<race>.json`); `--no-zone-plan` runs the plain greedy. The plans
  there are the shipped seed for every race start: at e199342a0 + point work,
  the gate (Orc / Human Warrior, guide text, bar = shipped) has zone changes
  97/115 (bar 117/124), returns within 3 levels 16/17 (23/23), quests per
  visit 11.2/11.3 (10.5/11.1) and same-mob splits 73/88 (52/97) against the
  greedy's 261/254, 89/81, 6.0/6.4 and 124/124. Continent changes 28/34 stay
  over the bar (20/26). A seed merged from the shipped start and another guide's
  order after L12 (`--stream`) had 22/27 continent changes but failed more
  rows (returns 28, quests per visit 9.7, Alliance zone changes 131).
- `sim zoneplan --stream FILE` merges: the race's start from the shipped
  chain up to its first block at level 12 or more whose zone the stream also
  plans, the stream's order from there.
- **Compacting** (zoneplan.js `compactZonePlan`, applied by every seed and
  to the default plans since 2026-10-21): a block whose zone a block at most
  2 levels earlier already works is dropped, so the route does not leave a
  zone and come back a level later (the guides' 50s: Felwood, Winterspring,
  the Plaguelands and the capitals between them). Horde, routed walks, 5
  starts: zone changes/returns 73.8/41.8 -> 62.0/30.0, grind 38.7 -> 42.8 h;
  Orc guide text (solo / group): zone changes 126 -> 115 / 124 -> 107, back
  within 3 levels 30 -> 16 / 29 -> 15 (bar 117, 23). Orc 77 blocks -> 63,
  Human 86 -> 72.
- **Continent runs** (zoneplan.js `compactContinents`, after compacting, in
  every seed and all ten default plans): a run of up to 3 blocks on one
  continent between runs on the other moves to the next run on its continent
  starting within 3 levels (else after the previous one ending within 3
  levels), unless the move lifts some block's level by more than 2
  (`CONT_LIFT`: the blocks after a moved run follow it; a Kalimdor run at 39-40
  moved to 42 left its quests 3 levels late or grey). Horde 5 starts:
  continent returns 9.4 -> 4.0 (the 3-level moves: grind +2.7 h; with the lift
  cap, 2026-10-21: grind 54.5 -> 52.4 h, hours 144.0 -> 142.8). Alliance 5
  starts: continent returns 8.6 -> 2.6, grind 50.0 -> 48.6 h. Guide text Orc /
  Human continent changes 18 / 26 -> 16 / 20 (bar 20).

### The v2 search (`sim search`; tools/lib/sim/v2/search.js, alns.js, searchpool.js)

`sim search --faction F [--race R] [--class C] [--tries N] [--seed S]
[--workers W]` searches one start's v2 routes on every core:

- A route is the list of areas it goes to, in order, read as a queue: a
  decision takes the first of the next 8 that is one of its candidates
  (dropping the ones before it), and leaves a free slot, or nothing found, to
  the k-th ranked area (k = 0: the greedy). A change that puts visits in or
  takes them out leaves the rest of the list in order. A replay restores the
  checkpoint before the first changed area and steps on. The budget,
  `--tries` (default 5,000,000 a pass), counts decisions replayed, never time.
- A decision's leg (tools/lib/sim/v2/travel2.js `trip`) walks, flies or
  takes a quest ride, or takes the hearthstone to the inn last bound and goes
  on from there when that is cheaper (v1's rule: a leg over 2 min, the hearth
  30 s cheaper, off its 60 min cooldown). The ranking prices legs without the
  hearth: it would carry no cooldown value and lure the greedy back to the
  bound hub. Through `deathskipLevel` (10: Forever gives no resurrection
  sickness through 10) a leg can also be a deathskip: die where it starts,
  release and take the Spirit Healer at the graveyard the server picks (the
  closest on the continent of those CMaNGOS links to the death's zone for the
  faction, tools/lib/sim/graveyards.js; only graveyards with a Spirit Healer
  spawn within 100 yd), then go on from the run point nearest it; it costs
  `deathskipSec` (60 s, an estimate: being killed, releasing, the healer) plus
  the walk to that point, and is taken 30 s cheaper than the leg. The ranking
  prices legs without it (priced, it reordered the greedy into more errand
  trips for under an hour to 20 over all starts). Its action is `deathskip`, the leg on
  from the graveyard carries `via: 'deathskip'`, and the route counts them
  (`deathskips`). From `mountLevel` (40) the character is mounted, free
  and without a riding trainer step: every walk at `mountMul` (1.6×) run
  speed, plus a 3 s summon per walked part (the walks carry no indoor or cave
  share, so no part is run on foot). With riding in the data (`world.riding`,
  training.json `riding`) the route is on foot until its riding stop instead:
  once at the level with the gold, the nearest riding trainer of the race is a
  stop (decide.js 6b), however far: riding trainers are race-locked (their
  gossip's race condition, training.json `riding.trainers[].races`); a race
  with none takes those with no race condition (Genn Fairweather for the
  Skyborne), else any, said unconfirmed in the guide. The stop pays the
  skill's copper (100 g, the sniffed lists' price; the classic-converted lists
  say 90 g) and mounts; the guide
  trains there (`train <npc>`, `skill Riding 75`) and adds a step at the mount
  vendor beside it with an optional `buy` of the mount, for if learning gave
  none (as the in-game checks found). A flight takes its taxi legs' yards
  along their paths at 30 yd/s plus 2 s a hop (the addon planner's model)
  and `flightOverhead` once; travel.json's taxi `cost` is the price in
  copper, which v1 still reads as seconds.
- Faction territory (tools/lib/sim/v2/territory.js): a zone with the other
  faction's AreaTable `FactionGroupMask` (2 Alliance, 4 Horde, on the zone's
  top-level row) weighs 1; a contested zone (mask 0) leans to a faction, and
  weighs 0.4 to the other, when only that faction is at home there (a flight
  master of its own or 2+ quest givers open only to it): Thousand Needles leans
  Horde (one Alliance giver), and Redridge and Wetlands lean Alliance; the
  Blasted Lands are listed shared (`SHARED`: the Dark Portal staging ground,
  though Forever gives the Horde no quests of its own there); every other
  contested zone weighs 0. Subzone rows read 0 almost
  everywhere (the Crossroads too), so a neutral town is a flight master open
  to both factions (Ratchet, Marshal's Refuge): 250 yd round it weigh 0. The
  seconds walked (each walked part's routed walk's yards per zone, from the
  walks file; the straight line sampled every 100 yd where a part has no
  routed walk, counted as `territoryFallback`) and worked there, each × its
  weight, are `territorySec` (each travel action carries its own as `terr`
  and `enemy`, seconds per weighted zone); smooth2
  counts each `territory` (3) × `territoryPvp` (1; a PvP realm's weight is a
  later option) more. The ranking prices a candidate's leg and work with the
  same function. No quest work in a weight-1 zone: compile drops a quest whose
  giver, ender, a task point or an objective's every camp lies there
  (`enemy-zone`, its chain cut at the step before) and its camps there; class
  quests stay and pay the cost, as walking through does.
- The cost: the route's time, grinding counted grindWeight times, zone
  changes and returns, spot returns, wasted accepts, a cost per area visit,
  the route audit's findings and the XP lost to late turn-ins. Grinding has
  no cap (Fitz 2026-10-20): grindWeight prices it. Each level
  short of 60, wasted accept over 5 (one abandoned:
  a quest still in the log at 60 is not wasted, its time is in the route's
  hours; `openAt60` counts them) or log slot over 40 counts 1,000 h: a route
  past the limits is ranked, not dropped; feasible means none.
- Two passes, each a tournament of up to 2,000 randomised greedy
  constructions (k geometric, P(k = 0) = 0.6; at most 40% of the pass's
  budget) and adaptive large neighbourhood search on its best 8 routes. A
  move rebuilds a window of 4-40 areas (greedy with randomised k, or
  another trajectory's areas from the same level), takes every visit to
  one zone, hub, hunting ground or quest level band out and puts them back as
  one block where one of their stays began (the best of up to 4 places), or
  rebuilds 4-40 areas drawn at random (40/40/20%). A move is kept when its
  cost is within T × the best's of the best, T falling from 2% to 0 over the
  trajectory's budget (record-to-record travel); a pass stops once its best
  (the smooth pass's at each ε) is unchanged for 20% of its budget.
- The time pass (the time objective) finds T_fast, the fastest feasible
  route. The smooth pass (smooth2) runs two trajectories at each ε = 0, 8, 15
  and 25%, each paying quadratically for time over (1 + ε) × T_fast: smoothness
  comes before speed, so the list reaches routes a quarter slower. The
  passes' rounds run together, so T_fast falls as either finds a faster
  feasible route.
- Every feasible route replayed joins an archive of the routes no other beats
  on both time and cost; the short list takes, at each ε, the smoothest within
  (1 + ε) × T_fast, judged with the full route audit. A search is determined
  by the world, parameters, rules, start, seed and budget, on any number of
  workers.
- It writes `data/sim/results2/<faction>-<race>-<class>.json`: the four routes
  (actions, pass observations, metrics, audit summary, the start's cases),
  each pass's greedy, tournament and ALNS bests, the archive and the
  convergence. `sim cases --result FILE [--eps E]` and `sim audit --result
  FILE [--eps E]` judge one of its routes.

## 4. Calibration

- From quest data: quests.json rewards against the QuestXP-table estimate
  (`questEstScale`) and Forever-observed rewards from the installed
  ForeverDungeonJournal (`--fdj <dir>`; `questXpScale`).
- From recordings (data/recordings): kill rates (`killSec1`, `killSec60`).
- `extraKill` (incidental kill XP, the main unobserved XP source) is a fixed
  prior in params.js (0.043 ± 0.038, fitted 2026-10-12 against level
  checkpoints).

Only the fitted parameter values are kept (data/sim/params.json).

## 5. Baselines (scored under the same model)

- Polestar: the compiled guides (default route and every route choice),
  against the best route found (solo and with dungeons).
- **Guides are scored on what they require.** A guide's `optional` goals are
  left out: an optional quest (its accept is optional) whole, any other
  optional goal by itself. Most are quests started by rare drops (the OOX
  beacons, A Strange Red Key, the ritual totems at about 3%), the Green Hills
  of Stranglethorn pages, profession and bag quests and rares: counting them
  as done assumed every player gets every rare drop. Until 0.2.4 they were
  counted, which made the guides look about 8 h (Horde) and 5 h (Alliance)
  faster than what a player following them can expect; joelwurtz found it
  (issue #30). `sim compare --with-optional` (and `sim bench
  --with-optional`) scores them as done, the old way, to show what the
  extras can save. Elite and dungeon quests are outside the solo world, so
  they stay out either way. Search results (best found, consensus) are not
  guides and are unchanged.
- **Guides are scored at the giver and ender they name.** A compiled
  accept or turn-in carries its NPC or object (`accept 8254 npc 11406`, or
  the one the compiler placed it at), and a quest with several is scored
  there, not at the world's first. Guides used to be scored at the
  first, a trip the player never makes: Horde guides were charged the walk
  to the Steamwheedle Port poster for the two Tanaris wanted quests they
  take in the Gadgetzan square, and class guides the trip to another city's
  trainer (Rohan for Cenarion Aid was scored by moving him in the data).
  About 0.1 h to 60 for most starts and up to 0.9 h for Horde Warriors.
- A pack (`sim compare --pack <dir>`, or the pack folder as the one
  argument): its chain, after our chain up to the pack's first level when it
  starts above 1, under the same model
  (`data/bench/compare-<faction>-<race>-<pack id>.json`).

## 6. CLI

```
sim world   [--faction F] [--rebuild]               build/cache the world model (data/sim/world-<faction>.json)
sim walks   [--faction F] [--radius Y] [--anchor-radius Y] [--bands B] [--workers W]  route the world's walks
            with the walking router (data/sim/walks-<faction>.json; run, robust, compare, bench and
            consensus use them; answers cached in data/sim/walkcache-<faction>.json)
sim walks --report [--faction F] [--band B] [--dir D]  why band B's cached walks failed (separate,
            noHeight, offGrid, unknown; walkGap list); exits 1 when unknown is over 0.5%
sim calibrate [--fdj DIR]                            fit parameters to quest data and recordings
sim run     --faction F [--race R] [--class C] [--paths N] [--workers W] [--seed S] [--dungeons]
            [--jobs J] [--anneal A] [--max-paths M] [--objective time|smooth] [--param K=V ...] [--tag T]
sim robust  --faction F [--race R] [--class C] [--draws K] [--top N] [--objective O]   robustness of the top routes
sim compare --faction F [--race R] [--class C] [--guides DIR] [--pack DIR | DIR] [--to 10,20,30] [--with-optional]
            [--objective O]   Polestar's routes vs the best found, same model
sim bench   --faction F [--race R] [--class C]      bracket table: zones, levels, quests per 10 levels
sim export  --result <file> --out <dir>             zone-by-zone skeleton guides + visits.json for authors
sim consensus --faction F [--dungeons] [--evals N] [--objective O]   one 12-60 route shared by the faction's starts (+ exports)
(robust, compare and consensus take --param and --tag too)
```

Less common options: `--fdj <dir>` (calibrate: the ForeverDungeonJournal
folder, default the installed one), `--band <levels>` (level width of the
world's quest packages, default 5; a new width rebuilds the world), `--jobs
<n>` (run: search jobs per round, default 32), `--anneal <n>` (run:
annealing evaluations per job, default 6000), `--max-paths <n>` (run: hard
cap on evaluated routes, default 3x `--paths`), `--guides <dir>` (compare:
the guides folder to score, default `guides/`), `--pack <dir>` or a pack
folder as the one argument (compare: also score a pack's chain, after
our chain up to its first level when it starts above 1; written to
`data/bench/compare-<faction>-<race>-<pack id>.json`), `--to <levels>`
(compare: levels to show, default 10,20,30,40,50,60), `--top <n>` (robust:
routes re-evaluated), `--dungeons` (run, robust and consensus: the
dungeon-inclusive family, needs `data/forever/dungeons.json`), `--offline`
(never download the QuestXP table), `--radius <yards>` (walks: route every
pair of points up to this far apart, default 4000), `--no-walks` (walk the
straight line × detour even with a walks file), `--quiet` (less output); `--data <dir>`
and `--sim <dir>` move the reference data and simulator outputs (default
`data/forever`, `data/sim`).

**What is rebuilt when.** The world file is keyed by `dataHash`: a hash of
what the builder reads (`world.js worldInputs`): the data/forever files by
content (quests, npcs, objects, items, zones, map-frames, travel, trainers,
dungeons, training, races, mechanics, spawnz; not meta.json, whose `builtAt`
moves on every build), the walking grid, the rules' hand-overs, the gameobject
facts, the client instance tables and `BUILDER_VERSION`. A data build that
changes nothing keeps the world and its walks; a hand edit rebuilds them. The
world keeps the digests (`inputs`), so a rebuild and a stale result name what
changed. A kept v2 route (`sim cases`, `sim audit`, `sim guides`) is checked
against `dataHash`, the walks' content id (set when they are written), the
walking maps, rules.json, params.json, its zone plan's blocks and
`engineHash`: the code the route runs (the require closure of v2/sim.js,
compile, the pass observer, the zone plans, the walk lookup and params.js),
so an edit to export, search, cases or the command keeps it.

**The shared store.** Built worlds, the world build's floors and the walks files
are also kept in one store shared by every worktree (`tools/lib/sim/cas.js`:
`$POLESTAR_CAS`, else `~/.cache/polestar/cas`; `off`: none), by the hash of what
they were made from: a world by its `dataHash`, faction, band width, open cap and
the world builder's code; walks by the world's `dataHash`, the faction, the router
and its walking maps (what `walksUsable` checks). A worktree's `data/sim` that
lacks a fitting world or walks file takes it from the store, a reflink on btrfs
(no bytes copied), and what it builds goes in. So a new worktree or a rebase with
the same inputs starts warm: a fresh worktree's first Horde route took 2.1 s with
the store, against 18 s and no walks at all (straight line × detour, until a
1.2 h `sim walks`) without it. A scratch sim dir (not a worktree's `data/sim`)
keeps its artifacts to itself. `sim cas` shows the store; `sim cas gc` drops what
wasn't used for 30 days, then the least recently used until it is under 20 GB.
`POLESTAR_CAS_SKIP=walks` (a comma list of kinds) keeps those kinds out of the store,
neither read nor written, while the others stay shared.

**Rebuilding everything.** `node tools/rebuild.js [--tree DIR] [--run DIR] [--jobs N]`
runs every stage unattended, from the reference data to guides ready for the client.
The stages are data, worlds, walks, routes, guides, sweep, playtest, client, gate and
report. Each command is memory-admitted (`/tmp/ctl/light.sh`). Each stage is logged in
`RUN/logs/` and timed in `RUN/state.json`, and `--resume RUN` starts again at the stage
that crashed (only the stages the run was started with). Checks never stop it; only a
crash does.

- **data:** a shift is taken unless it looks corrupt (a count down by half or to 0).
  The stage refuses a tree without a `.rebuild-tree` file (one made for rebuilds,
  never a worktree others work in) unless `--data-here`.
- **walks:** the router's tables for the world, from `data/sim` or the store. Failing
  that, walks assembled from a seeded walk cache with no routing (`--seed-sim`,
  `tools/rebuild-walks.js`), reported as stale and kept out of the store; it never
  runs the walk build.
- **routes:** `sim route` for every start, N at a time.
- **guides:** `writer-sweep --dump`.
- **sweep:** `writer-sweep --repair all --check all`.
- **playtest:** the stub client.
- **client:** every start's guides compiled into `RUN/client/Polestar_Guides`, to copy
  into the client.
- **gate:** the judge's scorecard.
- **report:** `RUN/REPORT.md` (per start pass/fail, findings by rule, scorecard,
  timings), with a local copy and a dashboard note.

**The sim server.** `sim serve` keeps each faction's world, the compiled
runs and the walks with their lookup in one process, keyed by those
hashes, and reloads a code tree's modules when one of its `tools/` or
`data/forever/` files changes. `sim ask <sim command>` (route, audit,
cases, guides, zoneplan) sends a command to it and prints what a local run
prints; without a server it runs locally. `--root DIR` names the code tree,
so one server serves several worktrees and the gate's snapshots;
`--script FILE` runs a script's exported `main(args)` there (the judge's
route and case scripts). Walks, search, run and `world --rebuild` are
refused: run them directly. Its worker threads run the commands that fan
out (a start, a class and start zone, or a refine trial a task); each thread
keeps at most ~400 MB of values, least recently used let go first and made
again, the same, when asked for. One server runs per code tree and data set, in
its own capped scope; it exits after 20 minutes without a request, and
`sim serve --status` / `--stop` report on it and end it (docs/ARCHITECTURE.md,
"Sim server").

**Metamorphic checks.** `tools/lib/sim/metamorphic.js` checks relations that hold
whatever the route: the same greedy route twice on one compiled run (R1), runRoute
and the search's replay engine giving the same route (R2), a route given its own
decisions as `--route` giving itself (R3), a partial replay from a checkpoint
giving a fresh replay's route (R4), and a recompiled run giving the kept one's
route (R5). A failure is a simulator bug. `sim ask --script
tools/lib/sim/metamorphic.js -- horde orc` runs them on a start in the sim server
(about 4 s warm); tests/sim-v2-metamorphic.test.js runs them on the synthetic
world.

**Finding the commit that moved a metric.** `sim bisect horde.sameMobApart <good> <bad>`
bisects bad's first-parent line after good: each probe is a commit's greedy route
and audit for the gate start (Horde Orc or Alliance Human Warrior), built from
`git archive` into `data/local/bisect/trees/` and run in the sim server when one
answers. The metric is a route document's `metrics.<name>`, a top-level field
(`hours`) or an audit count (`hubSplits`). The probes run on their own sim dir
(`--sim`, default `data/local/bisect/sim`, seeded with `data/sim`'s walks), so an
older commit that builds its own world never writes into `data/sim`. The gate's
metric history (`/tmp/judge/history.js`) prints the `sim bisect` line for a shift.

**Shrinking a failing case.** `sim shrink <case>` cuts a failing case (a metamorphic
relation, `R3`, or a reported case id, `C03e`) to the fewest zones, then quests,
that still fail it, by delta debugging (ddmin, `tools/lib/sim/shrink.js`): the world
keeps its points, camps and walks and only quests are left out (a case's own quest
stays). It writes `data/sim/shrink/<case>-<start>.json`. R3 on Horde Orc goes from
1,804 quests to 2 (750 The Hunt Continues, 753 A Humble Task, Mulgore) in 25 runs,
3 s; C03e to 5 Durotar quests in 18 runs.

**Tuning the weights.** `sim tune [--budget N] [--seed S] [--starts horde-orc,...]
[--params k,...] [--workers W]` races configurations of the smooth objective's weights
(default: zoneChange, zoneReturn, grindWeight, escortWeight, stepCost, territory) by
iterated racing (irace, `tools/lib/sim/tune.js`): Latin-hypercube samples between a
quarter and four times each default, then samples around the best so far with a
shrinking spread; each configuration runs on one start after another (six Warriors by
default) and is dropped once a paired t-test says it is worse than the best. A
configuration is scored against the default on the same start: the weighted mean of
hours, zone changes, zone returns, split same-mob work, continent returns and grinding
hours as ratios (smoothed so a small count's change of one does not decide), plus 1 for
each player-report case it fails that the default passes and 10 for a route that does
not reach the level. A case failing that the default passes is also a hard limit: such
a configuration never wins. It runs on its own worker pool (`--workers`, default 2; a
server's, asked through `sim ask`) and writes `data/sim/tune/tune-seed<S>.json`: the best, every
configuration that raced on every start without breaking a case, best first
(`candidates`, each with its measures per start), and a table per start; the last line is
the best's `--param` line. The route measures are a poor stand-in for the gate's guide-text
ones: the best route configurations (route score 0.988) came out neutral to worse on the
gate (1.005). The judge's `tunegate.js --race` runs the same racer (`tune()` takes the
measures, `limits` and `runTrials`) on the gate itself: a trial is one faction's gate
(rerun.sh with `GATE_PARAMS`), the measures the gate's guide-text ones and the hours, and
hours more than 1 % over the default's on a start are out, as a broken case is, so
smoothness is never bought with time. A tuned configuration is never adopted by the tool:
its finalists' rows go to a person, who chooses.

`sim run` writes `data/sim/results/<faction>-<race>-<class>.json`
(`…-dungeons.json` with `--dungeons`, `…-smooth.json` with `--objective
smooth`) and prints a
report: the best route as zone visits with level ranges and times, time to
each tenth level, XP split, travel share, the smoothness counters,
convergence, and the comparison.

`sim export` writes one `.guide` skeleton per zone visit (accepts, objectives,
turn-ins in the simulator's order, plus `getfp`, `sethome`, `hearth` and
`level` steps where it learned a flight path, bound or used the hearthstone,
or ground) and `visits.json`: per visit the level range, time, packages,
quests in order (id, title, level, giver/ender name, hub = its flight master
or inn or "near" the nearest one, map position), binds, flight paths,
hearthstone uses, grind stops (where, from-to level, minutes) and dungeons.
The simulator grinds where it stands (a rate per level, no place), which
can be a capital city, so each grind stop also gets a `spot`: the nearest
camp on the landmass (6+ spawns of one normal quest mob within 120 yd; quest
mobs keep out town guards and event spawns) with mobs from one level below
the character to two above, nearer and bigger preferred. The skeleton's
`level` step names that camp. The skeletons compile with the guide compiler
(0 errors).

## 7. Consensus route

`sim consensus --faction F` builds one route from level 12 to 60 that every
start of the faction can follow: each start keeps its own best route up to
its level-12 point (and all its home packages); the shared part is one
package sequence run in order by every start (a package a start already ran
or does not have is skipped for it; no deferral).

- **Cross-evaluation bound**: each start's own 12-60 sequence is run as the
  shared route by every start; the best row sum is the bound the consensus
  must beat (reported as a matrix).
- **Search**: simulated annealing (swap, move, reverse, drop, add from any
  start's route) for the summed time to 60 of every start, 2 rounds of 32
  jobs on worker threads (round 1 from the seeds: those sequences and the
  median order of the packages most starts share; round 2 from the best),
  1.2M suffix evaluations by default (`--evals`); deterministic for any
  number of workers. Packages that do nothing for any start are dropped.
- **Report**: each start's consensus time vs its own best (hours lost), the
  realised visit order per start (zone, levels, quests, hours), and its
  **route choices**: level stretches where its own route gains more than
  1 h on the consensus, with the zones each route visits there.

Outputs: data/sim/consensus-<faction>.json and .md, and per start an export
of the consensus route under data/sim/export/consensus-<faction>-<race>/.
Export place names (`hub`, grind `near`) are the nearest named map area
(subzone or town, client WorldMapOverlay/AreaTable) on the point's own zone
map.

## 8. Results: world f7bd5e2cccab (final run, 2026-10-13)

Every number below comes from one world: data hash
`f7bd5e2cccab91eb0a8f2bd4b4b673b58eb8af13`, both factions, builder 18
(builder 17 plus friendly kill credit for find/heal/use/locate objectives,
escorts named "escape", counted events as `use`, quests started from an
item another quest rewards), with the route policies of §2 (grinding
counted 2.5 times, 7.5 minutes per zone change), run from a frozen copy of
the repository. Results record the hash; anything from another world
(bde7513ac7b8 and earlier) is refused. The Forever rank corrections that
came after the run (22 NPCs, see Known limitations) are in the current data
but not in this world.

These are **model estimates in /played hours**, not measurements: no
recordings exist yet, so time parameters keep their priors (only quest XP
is calibrated; `extraKill` is a fixed prior, §4), and Forever's 30-60
content is not in the data. Rankings under the model are what the numbers
support; absolute hours are not.

### Solo filter counts

| faction | quests | dungeon | raid | pvp | elite | rareDrop | reputation | repeatable | kept no-XP repeatables |
|---|---|---|---|---|---|---|---|---|---|
| Horde | 1654 | 165 | 12 | 88 | 128 | 8 | 30 | 72 | 12 |
| Alliance | 1886 | 171 | 12 | 89 | 128 | 5 | 30 | 58 | 14 |

### Per start (hours to 60, solo)

| start | best found | consensus | guides (grinding) | previous guides (grinding) |
|---|---|---|---|---|
| Orc | 119.4 | 120.5 | 122.9 (14.3) | 128.0 (44.1) |
| Tauren | 120.4 | 120.2 | 122.4 (13.8) | 127.9 (44.8) |
| Undead | 120.8 | 120.6 | 123.5 (13.9) | 127.9 (43.1) |
| Skyborne H | 120.2 | 120.1 | 122.8 (13.1) | 127.7 (41.8) |
| Human | 119.6 | 119.1 | 128.7 (28.5) | 133.3 (61.4) |
| Dwarf | 119.5 | 119.5 | 129.3 (28.4) | 133.1 (61.8) |
| NightElf | 120.0 | 119.5 | 129.3 (28.8) | 133.7 (62.5) |
| Skyborne A | 121.2 | 119.6 | 129.0 (27.7) | 133.0 (60.4) |

Guides: each race's default chain as written (`sim compare --guides`),
counting their optional goals as done (the scoring until 0.2.4, §5),
grinding at their own `level` steps. The leveling guides were rebuilt from
this run's consensus exports with a flow pass the model does not make:
side trips for one or two small quests behind a flight, boat, hearth or long
ride were dropped, every hub is one loop, and where the level then falls
short a `level` step names a camp (with an optional dungeon past 20
minutes at 40+). That costs 2.0-2.7 h (Horde) and 9.1-9.8 h (Alliance)
against the consensus, almost all of it grinding: the Alliance 44-50 has
few solo quests left once the Booty Bay, Shimmering Flats and OOX trips are
gone (the longest stop is 48 to 50 at the Un'Goro gorillas). The previous
guides (written against builder 15, scored on this world) are 3.8-5.5 h
slower with 29-34 h more grinding.

Consensus time to 10/20/30/40/50/60 (h):

| start | 10 | 20 | 30 | 40 | 50 | 60 |
|---|---|---|---|---|---|---|
| Orc | 2.3 | 11.3 | 26.7 | 52.3 | 81.6 | 120.5 |
| Tauren | 1.9 | 11.1 | 26.5 | 52.1 | 81.4 | 120.2 |
| Undead | 2.4 | 11.5 | 26.9 | 52.5 | 81.8 | 120.6 |
| Skyborne H | 2.1 | 11.2 | 26.5 | 52.2 | 81.5 | 120.1 |
| Human | 2.2 | 9.3 | 23.9 | 48.8 | 80.0 | 119.1 |
| Dwarf | 2.0 | 9.7 | 24.3 | 49.2 | 80.4 | 119.5 |
| NightElf | 2.1 | 10.0 | 24.3 | 49.2 | 80.4 | 119.5 |
| Skyborne A | 2.1 | 9.6 | 24.4 | 49.3 | 80.5 | 119.6 |

On world bde7513a (builder 17, grinding and zone changes at face value) the
consensus was 128.7-128.9 h (Horde) and 129.7-130.5 h (Alliance) with about
46 h of grinding: returns to a zone and the grind policy save 8-11 h.

### Consensus and convergence

- Horde: 173 shared packages from level 12; bound (Skyborne's own 12-60)
  542.7 summed policy cost, consensus 542.6. Alliance: 169 packages; bound
  (Dwarf's own) 591.9, consensus 591.9. 1.2M evaluations each.
- Searches: 3.46-9.03M routes per start. Human and Skyborne H reached the
  route cap (3x the 3M paths) still improving (last improvement at 99% and
  96% of the evaluations); the others converged (last improvement at
  72-98%).

### Robustness (2000 parameter draws, top 10 routes per start)

| start | #1 wins | #1 within 1% | #1 cost 5-95% (h) |
|---|---|---|---|
| Orc | 37% | 99% | 121.8-241.8 |
| Tauren | 13% | 30% | 130.5-248.5 |
| Undead | 31% | 98% | 128.7-259.4 |
| Skyborne H | 24% | 57% | 121.9-199.0 |
| Human | 17% | 93% | 129.3-207.5 |
| Dwarf | 31% | 81% | 126.9-195.4 |
| NightElf | 29% | 69% | 129.2-209.5 |
| Skyborne A | 24% | 86% | 128.3-193.6 |

Costs include the route policies (hours plus the weighted grinding and zone
changes), so they sit above the hours. The top routes are close: the best
found route is within 1% of each draw's best in 30-99% of draws, and no
route wins a majority.

### Dungeon family

Horde only (the Skyborne and Alliance dungeon searches were stopped):
Orc 120.0, Tauren 120.4, Undead 121.8 h, never ahead of the solo best
found. Under the model dungeons do not beat questing solo.

### Second search (verification)

The same pipeline run again to test whether the first search's routes are
as good as the method gets: another random seed (2), up to twice the routes
(`--paths 6000000`, cap 18M), and the current data with the 22 rank
corrections, world `165d88c5eaaa`. Best found / consensus, hours to 60:

| start | first search | second search | guides on the second world (grinding) |
|---|---|---|---|
| Orc | 119.4 / 120.5 | 120.7 / 117.8 | 123.0 (14.4) |
| Tauren | 120.4 / 120.2 | 119.1 / 117.4 | 122.5 (13.9) |
| Undead | 120.8 / 120.6 | 119.0 / 118.1 | 123.5 (14.0) |
| Skyborne H | 120.2 / 120.1 | 117.3 / 117.3 | 122.9 (13.2) |
| Human | 119.6 / 119.1 | 120.7 / 118.8 | 128.7 (28.5) |
| Dwarf | 119.5 / 119.5 | 120.8 / 118.8 | 129.3 (28.4) |
| NightElf | 120.0 / 119.5 | 120.9 / 118.9 | 129.2 (28.8) |
| Skyborne A | 121.2 / 119.6 | 118.6 / 118.6 | 129.0 (27.7) |

- Searches: 6.54-18.07M routes per start; Horde Tauren, Undead and
  Skyborne and Alliance Skyborne reached the cap still improving (last
  improvement at 95-100% of the evaluations).
- Consensus: Horde 167 shared packages, 531.4 summed policy cost (bound
  531.6); Alliance 169 packages, 586.9 (bound 587.3).
- Robustness: the best found route stays within 1% of each draw's best in
  48-100% of draws; win rates 9-78%.
- The two searches' consensus routes differ by at most 2.8 h (Horde) and
  1.0 h (Alliance), every start within 117.3-121.2 h: the top of the search
  space is flat, and more search still finds small gains. The guides score
  the same on both worlds (within 0.1 h); against the second consensus they
  cost 5.1-5.6 h (Horde) and 9.9-10.5 h (Alliance), almost all of it the
  grinding the flow rules add.

### Third and fourth searches (0.2.0)

Two more independent searches checked the routes again before 0.2.0, with
the guides as they ship scored on the fourth world:

- Third: seed 3, `--paths 10000000` (cap 30M), world `5a8503dbb43a`; 17.7-30.2M
  routes per start, seven of eight reached the cap still improving.
- Fourth: seed 4, `--paths 6000000` (cap 18M), world `329281f957a5`, the data
  0.2.0 ships with; every start reached the cap still improving.

Guide columns count the optional goals as done (the scoring until 0.2.4;
the hours for what the guides require are in the next section).

| start | third: best / consensus | fourth: best / consensus | guides 0.2.0 on the fourth world (grinding) | guides 0.1.0 there (grinding) |
|---|---|---|---|---|
| Orc | 117.7 / 116.8 | 119.6 / 117.3 | 123.8 (16.1) | 123.0 (14.4) |
| Tauren | 118.3 / 116.5 | 117.1 / 116.8 | 123.2 (15.6) | 122.5 (13.9) |
| Undead | 119.3 / 117.0 | 118.8 / 117.4 | 124.3 (15.7) | 123.5 (14.0) |
| Skyborne H | 116.3 / 116.3 | 116.8 / 116.8 | 123.6 (14.7) | 122.9 (13.2) |
| Human | 119.2 / 116.8 | 119.3 / 118.9 | 128.2 (28.7) | 128.7 (28.5) |
| Dwarf | 117.4 / 117.3 | 119.8 / 118.8 | 128.7 (28.6) | 129.3 (28.4) |
| NightElf | 119.0 / 117.5 | 119.1 / 119.1 | 128.7 (28.9) | 129.2 (28.8) |
| Skyborne A | 118.2 / 117.3 | 119.0 / 118.4 | 129.1 (27.9) | 129.0 (27.7) |

- Robustness: the best found route stays within 1% of each draw's best in
  87-100% (third) and 76-100% (fourth) of draws.
- Across the four searches every start's best found route lies within
  116.3-121.2 h and every consensus within 116.3-120.6 h.
- Against the fourth consensus the guides cost 6.4-6.9 h (Horde) and
  9.3-10.7 h (Alliance). The Horde guides lost 0.7-0.8 h against 0.1.0 by
  dropping quests a player cannot take (a chain started by a dungeon drop,
  quests removed from the game, a chain without its first quest) and moving
  the level-35 Dustwallow quests from 30 to 39; the Alliance guides gained
  about 0.5 h from a northern Stranglethorn loop and the Shimmering Flats.
- The third world predates the data correction that places Sulhasa in the
  southern Barrens, so it charges the Horde guides a trip to Un'Goro Crater
  for Field to Clear (about 0.9 h); the fourth world has the correction.

### Guides scored on what they require (0.2.4)

Since 0.2.4 the guides are scored without their optional goals (§5,
issue #30). On world `5eef72140b61` (the data 0.2.4 ships with), each
race's default chain (`sim compare`, and `--with-optional` for the last
column; `--guides` with the guides of tag v0.1.0 for the middle one):

| start | guides 0.2.4 (grinding) | guides 0.1.0 (grinding) | guides 0.2.4 with optionals (grinding) | guides 0.1.0 with optionals |
|---|---|---|---|---|
| Orc | 131.1 (34.2) | 128.5 (29.7) | 122.8 (14.0) | 123.0 |
| Tauren | 130.1 (34.2) | 127.8 (29.1) | 121.9 (13.9) | 122.4 |
| Undead | 131.5 (33.8) | 128.9 (29.1) | 123.3 (13.6) | 123.4 |
| Skyborne H | 130.1 (32.8) | 128.3 (28.2) | 122.3 (12.7) | 122.9 |
| Human | 132.5 (37.0) | 132.1 (35.5) | 127.5 (26.0) | 129.1 |
| Dwarf | 133.1 (36.9) | 132.6 (35.5) | 128.2 (26.0) | 129.6 |
| NightElf | 133.0 (37.1) | 132.6 (35.6) | 128.1 (26.1) | 129.6 |
| Skyborne A | 133.5 (36.2) | 132.5 (34.5) | 129.0 (25.6) | 129.8 |

- The optional extras are worth 7.8-8.3 h (Horde) and 4.5-5.0 h (Alliance)
  to a player who gets every one; almost all of it comes back as grinding
  (about 20 h more for the Horde, 11 h for the Alliance) where the extras'
  experience is missing. The largest for the Orc chain: The Green Hills of
  Stranglethorn and its chapters (2.4 h together), A Strange Red Key
  (0.9 h), the OOX-09 and OOX-17 chains (0.9 and 0.8 h), Winterfall
  Firewater (0.8 h).
- Against the fourth consensus (its own world) the guides cost 13.3-14.1 h
  (Horde) and 13.6-15.1 h (Alliance).
- With the optionals the guides of 0.2.4 and 0.1.0 are within 0.6 h
  (Horde); without them 0.1.0 is 1.8-2.6 h faster for the Horde, because
  the later guides marked more of their quests optional. The Alliance
  guides of 0.2.4 are 0.4-1.0 h slower without and 0.8-1.6 h faster with.
- The search's best and consensus routes were searched on earlier worlds,
  so the README's charts show only the guides.

## Known limitations

- **No recordings**: time parameters (kill time, travel detours, talk and
  interact times) are priors, not measurements. Absolute hours are model
  estimates; the robustness interval is wide.
- **Forever 30-60 content is missing** (Riverglades, Shen'dralas, Mount
  Hyjal, the rest of the Wetlands expansion): the beta caps at 30 and the
  data has none of it. Results are "Era + known Forever quests".
- **Forever NPC ranks**: QuestieDB's Forever store gives every Forever NPC
  rank 0; the corrections carry the web quest database's Forever ranks for the 305 Forever
  NPCs that quests need, and every quest NPC (4,432) was checked against
  the web quest database's Forever pages on 2026-10-13 (22 Era NPCs Forever reclassified, e.g.
  Bruuz now elite).
- **Quest types are derived**: the client's QuestInfo names Elite, PvP,
  Raid and Dungeon, but which quest has which type (and suggested group
  sizes) is server data; the filter infers them from areas, objectives and
  droppers, plus the explicit listings.
- **Child quests** follow Questie's parentQuest; parents whose turn-in
  needs a child's reward or effect are listed by hand (`turninAfter`: 348,
  338, 812, 5060, 1190).
- **Bag items**: cloth donations and items bought or carried over are
  modelled as gathered where they drop, so scoring a guide that hands them
  in from the bags adds trips the player does not make.
- **Walks the router can't make**: a walk inside one grid region that
  only closed climbs connect (Shadow Hold in Felwood, Thunder Bluff's
  rise) is counted `separate` and listed as a walk gap by `sim walks
  --report`; it keeps the straight line × detour until the pack decides
  those climbs.
- **Per-mob danger isn't in the router yet** (its own nav plan): walks
  carry zone danger by level band only.
- **Search depth**: see convergence above; Human and Skyborne H were still
  improving at the route cap.

## 9. Refresh (launch day)

Results are labelled "Era + known Forever quests": Forever's 30-60 content
(Riverglades, Shen'dralas, Mount Hyjal, the rest of the Wetlands expansion)
is not in the data yet (the beta caps at 30). When it lands:

```
node tools/polestar.js data build
node tools/polestar.js sim world --rebuild
node tools/polestar.js sim calibrate
node tools/polestar.js sim run --faction horde
node tools/polestar.js sim run --faction alliance
node tools/polestar.js sim run --faction horde --dungeons && node tools/polestar.js sim run --faction alliance --dungeons
node tools/polestar.js sim robust --faction horde && node tools/polestar.js sim robust --faction alliance
node tools/polestar.js sim consensus --faction horde && node tools/polestar.js sim consensus --faction alliance
```

then re-export (`sim export`) the starts the guides follow.

### Keeping the guides' fixes

The guides are hand-written from the exports, and a refresh re-applies a new
route to them. It keeps every fix a guide's header documents (its "Order
changes against the export", "Deviations from the export" or "Local order
fixed by hand" list): those orders answer player reports and things the
model does not see, such as a cave's mouth, a quest item that vanishes
after a while, or a delivery that belongs on the way out of a starting
glen. A refresh that changes such a stretch changes the header too, and
says why the new order still holds.

Two checks enforce it:

- `tests/guides-reported.test.js` (and `tests/guides-caves.test.js` for
  cave mouths) pins each player-reported fix on the compiled guide: goal
  order and where the arrow leads, one case per report. A refresh that
  undoes one fails the suite.
- Lint warns when a guide carries a timed quest item (items.json
  `duration`, the Forever client's ItemSparse DurationInInventory) longer
  than it lasts: from the goal that gets it (an `accept` that hands it
  over, a `collect`, a `buy`) to each later goal that spends it (a `turnin`
  that needs it, a `use`), timed from the latest goal that got more of it.
  The time is this model's (§2, at the priors): the straight line × the
  detour factor at run (or mounted) speed, flights from travel.json plus
  `flightOverhead`, the hearthstone cast, `talkSec` and `interactSec`, and
  kill time with the walk between mobs of the goal's spawn areas for kills
  and drops; other characters' and `optional` goals, grinding and legs
  across continents are left out, so the estimate errs short
  (`tools/lib/dsl/timed.js`).

When a guide is wrong because the data is (a giver, a spawn, a drop chance),
the fix belongs in `forever-db/corrections/` as well as in the
guide: the simulator builds its world from the data, so only a corrected
record keeps the next search, export and refresh from reproducing the
mistake.
