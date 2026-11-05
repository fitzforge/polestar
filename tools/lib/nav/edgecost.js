'use strict';
// The walking router's cost model (router.js over path.js): what one step of a walk costs, for one
// metric. Everything a search, the walk graphs (router.js prepare) and a contraction hierarchy
// (the Rust router) price comes from here; port this file term by term.
//
// A metric is { faction: 'Alliance' | 'Horde' | null, danger: { [uiMapID]: multiplier } | null }
// over a move profile (move.js: on foot, a mount, ...). An edge of the fine graph is one step
// between two surfaces of the navigation grid (a link to a neighbouring column, a fall, a lift
// ride); its cost is a static weight on that directed edge:
//
//   edgeCost(edge, metric) = seconds × ground × swim × hub × danger
//
//   seconds  the step's time for the move profile (move.js linkSeconds, fallSeconds, liftSeconds):
//            its 3D length at the profile's outdoor, indoor or swim speed, times the link class's
//            slope multiplier (WALK.slopeMul: a 35-50° slope 2 times, a 50-60° link FACE times, a
//            climbed 60-80° link CLIMB times), times FACE on a land link touching a FLAG.STEEP
//            column (terrain the client slides off: pack.js's face rule approximated, so a walk
//            goes round a face where it can and over it where it must), plus JUMP_SECONDS for a
//            jump. One-way moves (falls, lifts' rides, climbs) are edges with no edge back.
//   ground   ROAD (Routing/Costs.lua's Balanced road, 0.8) for a step into a road column that is
//            not swum: a road way is taken up to 1 / 0.8 = 1.25 times longer than the shortest.
//            Road columns: the roads layer (data/local/nav-layers/roads) through roadmask.js
//            (hysteresis, gaps bridged), as the walking maps' road class (pack.js nodeClass).
//            Slope, indoor and city classes of the maps are not ported: `seconds` already prices
//            slopes and faces by time.
//   swim     SWIM (2.02) for a step into a swum surface: Routing/Path.lua counts a swum yard as
//            Nav<map>.lua's swim factor (3) running yards, and `seconds` already counts it at swim
//            speed (RUN / SWIM_SPEED = 1.48 times a run), so 3 × SWIM_SPEED / RUN more: a walk
//            goes round by a bridge or a ford rather than swim a river as the arrow's would.
//   hub      HUB (Routing/Costs.lua HUB, 20) for a step into a column inside a hub hostile to the
//            metric's faction (the other side's: the hubs layer's disks, a column counting when a
//            disk reaches its square, as pack.js markHubs counts a cell). Kept out of, never
//            closed. No faction: none is hostile.
//   danger   the metric's multiplier of the zone of the column entered (router.js dangerOf: a zone
//            whose lowest level is well above the character's), 1 elsewhere.
//
// The ground and hub terms of a column are one class byte (costs.js layout: bit 0 road, HUB_ALLIANCE,
// HUB_HORDE; router.js groundOf builds it per tile), so `ground × swim × hub` is stepMult(byte,
// flags, faction). Every term is a property of the surface a step enters, so the weights stay static and
// directed, and a coarse edge (graph/<c>.bin.gz, between two abstract nodes) costs the sum of its fine
// path's edge weights for that metric: router.js prepare searches every tile's edges again per
// faction (the walk graphs: ground and hub exact). Danger on a coarse edge: its seconds times
// Σ over zones of (the share of its way's seconds spent stepping into that zone's columns) × the
// zone's multiplier (the zone mix router.js prepare measures on the factionless way; path.js
// coarseDanger), so the sum of its way's danger-weighted steps.
//
// Ends, the snap (path.js snap's `stand`, Routing/PathGrid.lua snap): a point with a height stands
// on an open surface within STAND_DZ (10) yd of it within STAND_RADIUS (36) yd, by distance plus
// twice the height gap, before the nearest surface of any height.
//
// The search's heuristic divides by the profile's fastest speed and multiplies by MIN_MULT (the
// smallest multiplier, ROAD), so it never overstates a remaining cost.
//
// Ends (not a cost term; path.js settleCandidates, the attach step): an end in a pocket the walk cannot
// leave or enter (a ledge, a doorway the grid shut one way) moves to the nearest surface within
// SETTLE_RADIUS yd, at most SETTLE_RISE above it and SETTLE_DROP below, outside the end's own pocket
// (Routing/Path.lua settle: SNAP cells, ZTOL, DROP), up to SETTLE_TRIES of them.

const Costs = require('./costs');
const { FLAG } = require('./grid/format');
const { RUN, SWIM: SWIM_SPEED } = require('./move');

// This model's name in the walk graphs' and zone mixes' files (router.js): bump it when a term
// changes, so they are searched again.
const MODEL = 2;
const ROAD = Costs.MULT[Costs.CLASS.ROAD]; // 0.8
const HUB = Costs.HUB; // 20
const ROAD_BIT = Costs.CLASS.ROAD; // the class byte's base class: road (1) or normal (0)
const SWIM = (3 * SWIM_SPEED) / RUN; // pack.js SWIM (Nav<map>.lua's swim, 3 running yards a swum yard) over swim speed's own
const MIN_MULT = Math.min(ROAD, 1);
const FACE = 40;
const CLIMB = 1000;
// The walk graphs' move-profile overrides (move.js linkSeconds: faceMul, slopeMul by stored link code:
// walk, steep, swim, jump, -, -, climb, slope).
const WALK = { faceMul: FACE, slopeMul: [1, FACE, 1, 1, 1, 1, CLIMB, 2] };
const SETTLE_RADIUS = 25; // yd (Path.lua: SNAP 6 cells of 4.17 yd)
const SETTLE_RISE = 10; // yd (PathGrid.lua ZTOL)
const SETTLE_DROP = 30; // yd (Path.lua DROP)
const SETTLE_TRIES = 8; // (Path.lua RETRIES)

// The bits of the class byte hostile to faction (Costs.lua Mult): an Alliance hub's to Horde, a Horde hub's
// to Alliance; 0 without a faction.
const hostileBits = (faction) => (faction === 'Horde' ? Costs.HUB_ALLIANCE : faction === 'Alliance' ? Costs.HUB_HORDE : 0);

// ground × swim × hub of a step into a surface with flags `flags` in a column of class byte `cls`, for faction.
function stepMult(cls, flags, faction) {
	let m = flags & FLAG.SWIM ? SWIM : (cls & 7) === ROAD_BIT ? ROAD : 1;
	if (cls & hostileBits(faction)) m *= HUB;
	return m;
}

// One fine edge's weight: edge { seconds, cls (the entered column's class byte), flags (the entered
// surface's), zone (the entered column's uiMapID) }, metric { faction, danger }.
function edgeCost(edge, metric) {
	const d = metric.danger && metric.danger[edge.zone];
	return edge.seconds * stepMult(edge.cls, edge.flags, metric.faction) * (d || 1);
}

// A metric's key: the walk graph and caches it is priced by (faction and the danger table).
function metricKey({ faction = null, danger = null } = {}) {
	const dz = danger && Object.keys(danger).length ? Object.keys(danger).sort((a, b) => a - b).map((z) => `${z}:${danger[z]}`).join(',') : '';
	return `${faction || '-'}|${dz}`;
}

module.exports = { MODEL, ROAD, HUB, SWIM, ROAD_BIT, MIN_MULT, FACE, CLIMB, WALK, SETTLE_RADIUS, SETTLE_RISE, SETTLE_DROP, SETTLE_TRIES, hostileBits, stepMult, edgeCost, metricKey };
