'use strict';
// Chokepoints of each continent for the journey's named walk steps
// (docs/ARCHITECTURE.md, "Navigation grid", "Packing for the in-game
// engine"): lift landings, gates, bridges, tunnels, cave and building mouths
// and passes, found by the rules below on the grid and the arrow's aids; no
// place is named by hand.
//
//   const { chokepoints, chokepointsLua } = require('tools/lib/nav/chokepoints');
//   const list = chokepoints({ nav, c, aids, lifts, geo, areas });   // -> [entry]
//   chokepointsLua({ [c]: list }, source)                            // -> Nav/Chokepoints.lua
//
// An entry: { wx, wy, z, r, kind, name, area, zone, zoneArea, sides?, liftEnd?, lift?, liftObject?, pair? }
// in UnitPosition's frame (wx north, wy west), yards. name: the area
// (AreaTable, the chunk's area id) at the point, never empty (the zone's
// name when the area has none); zone: the zone the area belongs to; area,
// zoneArea: their AreaTable ids, so the client names them in its language
// (a side's zoneArea likewise); liftObject: the lift's GameObject entry.
//
// Rules (decided 2026-10-15):
// - lift: both landings of every lift of the grid (lifts.json, build.js
//   liftLinks), one entry per landing (landings within LIFT_SAME yd and
//   STEP in height are one); liftEnd 'top' or 'bottom' by height against the
//   other end, `pair` the index of the other end, `lift` the object's name.
// - cave, building, pass: the mouth of each approach chain of the aids
//   (aids.js): 'Enter the cave' a cave, 'Go inside' a building, 'Follow the
//   path' / 'Follow the path up' a pass; 'Take the lift' chains are lifts
//   already. A cave's or building's mouth is where the chain's line first
//   reaches an indoor surface (sampled every MOUTH_STEP yd from its first
//   node, the surface nearest the line's height), centred on the indoor
//   boundary around it, its radius reaching all of it (indoorMouth); a chain
//   that never does keeps its first node. Mouths of one kind within MERGE
//   yd are one.
// - bridge, tunnel, pass: each zone crossing of the aids at the middle of
//   its two ends, by its caption ('Cross the bridge', 'Walk through the
//   tunnel', else a pass), sides the two ends with their zones.
// - bridge (from the grid): a deck of model surfaces (WMO or M2, outdoors,
//   not swum) over a swim surface or with at least BRIDGE_DROP yd of air
//   under it, at least DECK_MIN columns, on average at most DECK_WIDTH yd
//   wide, at least SPAN_MIN yd long, at least WET_SHARE of it over a swim
//   surface, whose links to other ground form exactly two separate groups
//   at least ENDS_APART of its length apart (its two ends: a pier has one, a quay along
//   a shore one long one).
// - gate (from the grid): outdoor ground under a model (WMO) span at most
//   COVER yd above it, the covered stretch at least GATE_MIN columns, on
//   average at most GATE_WIDTH yd wide, whose links to uncovered outdoor
//   ground form exactly two groups (in and out through the arch; a porch
//   along a house front has one).
// - A grid bridge or gate within MERGE yd of an aids entry of the same kind
//   is that entry; an aids pass there becomes the gate or bridge. A grid
//   gate elsewhere is left out (covered outdoor ground is common in towns:
//   market stalls, arcades; a gate matters where the aids find a passage).
// r is the radius the path must pass within: at least R_MIN, at most R_MAX.

const { CELL, TILE_CELLS, NO_LINK, FLAG, DIRS, STEP, cellCentre, cellOf } = require('./grid/format');

const LIFT_SAME = 8; // yd
const MERGE = 25; // yd
const BRIDGE_DROP = 8; // yd of air under a deck
const DECK_THICK = 2; // yd: blocked spans this close under a deck are the deck itself
const DECK_MIN = 20; // columns (about 87 yd²)
const DECK_WIDTH = 15; // yd on average
const SPAN_MIN = 12; // yd from end to end
const WET_SHARE = 0.25; // of a bridge's deck over a swim surface (wall walks and balconies are over ground)
const ENDS_APART = 0.6; // of the span: how far apart a bridge's or gate's two ends lie
const COVER = 12; // yd from the ground to the span over it
const GATE_MIN = 6; // columns
const GATE_WIDTH = 14; // yd on average
const R_MIN = 6;
const R_MAX = 30;
const MOUTH_STEP = 2; // yd
const MOUTH_R = 10; // yd: the least radius of a cave's or building's mouth
const MOUTH_SPAN = 4; // yd of height the mouth's floor may vary across its width
const MOUTH_REACH = 20; // yd around the chain's entry the mouth is looked for

// Where the polyline `pts` ({ wx, wy }) first stands on an indoor surface ->
// { wx, wy, z, r } or null; its height follows the surface it is on. The
// mouth is the indoor boundary there: within MOUTH_REACH yd, every MOUTH_STEP
// yd, indoor surfaces within MOUTH_SPAN of that height with outdoor ground
// at the same height a step away. Centred on them, its radius reaches the
// furthest (at least MOUTH_R), so a path entering anywhere across a wide
// mouth passes within it.
function indoorMouth(nav, c, pts) {
	let z;
	for (let i = 1; i < pts.length; i++) {
		const a = pts[i - 1];
		const b = pts[i];
		const n = Math.max(1, Math.ceil(Math.hypot(b.wx - a.wx, b.wy - a.wy) / MOUTH_STEP));
		for (let s = i === 1 ? 0 : 1; s <= n; s++) {
			const wx = a.wx + ((b.wx - a.wx) * s) / n;
			const wy = a.wy + ((b.wy - a.wy) * s) / n;
			const at = nav.snap(z === undefined ? { c, wx, wy, radius: 3 } : { c, wx, wy, z, radius: 3 });
			if (!at) continue;
			if (at.flags & FLAG.INDOOR) return mouthAround(nav, c, wx, wy, at.z);
			z = at.z;
		}
	}
	return null;
}

function mouthAround(nav, c, wx, wy, z) {
	const kind = (x, y) => {
		const q = nav.snap({ c, wx: x, wy: y, z, radius: 1 });
		if (!q || Math.abs(q.z - z) > MOUTH_SPAN) return 0;
		return q.flags & FLAG.INDOOR ? 2 : 1;
	};
	const edge = [];
	const R = Math.floor(MOUTH_REACH / MOUTH_STEP);
	for (let i = -R; i <= R; i++) {
		for (let j = -R; j <= R; j++) {
			if (i * i + j * j > R * R) continue;
			const x = wx + i * MOUTH_STEP;
			const y = wy + j * MOUTH_STEP;
			if (kind(x, y) !== 2) continue;
			if ([[1, 0], [-1, 0], [0, 1], [0, -1]].some(([di, dj]) => kind(x + di * MOUTH_STEP, y + dj * MOUTH_STEP) === 1)) edge.push([x, y]);
		}
	}
	if (!edge.length) return { wx, wy, z: round1(z), r: MOUTH_R };
	const mx = edge.reduce((s, p) => s + p[0], 0) / edge.length;
	const my = edge.reduce((s, p) => s + p[1], 0) / edge.length;
	const far = Math.max(...edge.map(([x, y]) => Math.hypot(x - mx, y - my)));
	return { wx: mx, wy: my, z: round1(z), r: Math.min(R_MAX, Math.max(MOUTH_R, Math.ceil(far + MOUTH_STEP))) };
}
const CAPTION_KIND = { 'Enter the cave': 'cave', 'Go inside': 'building', 'Follow the path up': 'pass', 'Follow the path': 'pass' };
const round1 = (v) => Math.round(v * 10) / 10;

// AreaTable rows -> (areaId) -> { name, area, zone, zoneArea } with names, never
// empty; area and zoneArea the ids of the rows the two names come from.
function areaNames(areaRows) {
	const rows = new Map(areaRows.map((r) => [Number(r.ID), r]));
	return (id) => {
		let r = rows.get(Number(id));
		if (!r) return null;
		const first = r;
		const name = r.AreaName_lang || r.ZoneName;
		const seen = new Set();
		while (Number(r.ParentAreaID) > 0 && rows.has(Number(r.ParentAreaID)) && !seen.has(r.ID)) {
			seen.add(r.ID);
			r = rows.get(Number(r.ParentAreaID));
		}
		const zone = r.AreaName_lang || r.ZoneName;
		return { name: name || zone, area: Number(name ? first.ID : r.ID), zone: zone || name, zoneArea: Number(zone ? r.ID : first.ID) };
	};
}

// Grid scan of one continent: deck (bridge) and covered (gate) columns -> components -> entries.
function gridChokepoints(nav, c, place) {
	const tiles = nav.index.continents[c].tiles;
	const deck = new Map(); // `${col}_${row}:${k}` -> { e, z, wx, wy }
	const cover = new Map();
	const key = (col, row, k) => `${col}_${row}:${k}`;
	for (const tk of tiles) {
		const [col, row] = tk.split('_').map(Number);
		const t = nav.tile(c, col, row);
		if (!t) continue;
		const { first, z, ceil, flags } = t;
		for (let k = 0; k < TILE_CELLS * TILE_CELLS; k++) {
			let haveDeck = false;
			let haveCover = false;
			for (let e = first[k + 1] - 1; e >= first[k]; e--) {
				const f = flags[e];
				if (f & (FLAG.BLOCKED | FLAG.SWIM | FLAG.INDOOR)) continue;
				const model = f & (FLAG.WMO | FLAG.M2);
				if (model && !haveDeck) {
					// Under it, past the deck's own (model) spans: a swim surface, or air down to BRIDGE_DROP.
					let below = e - 1;
					while (below >= first[k] && flags[below] & FLAG.BLOCKED && !(flags[below] & (FLAG.SWIM | FLAG.TERRAIN)) && z[e] - z[below] <= DECK_THICK) below--;
					if (below >= first[k] && (flags[below] & FLAG.SWIM || z[e] - z[below] >= BRIDGE_DROP)) {
						const p = cellCentre(col, row, k & 255, k >> 8);
						deck.set(key(col, row, k), { e, z: z[e], wx: p.wx, wy: p.wy, col, row, k, wet: !!(flags[below] & FLAG.SWIM) });
						haveDeck = true;
					}
				}
				if (!model && !haveCover && e + 1 < first[k + 1] && flags[e + 1] & FLAG.WMO && ceil[e] - z[e] <= COVER) {
					const p = cellCentre(col, row, k & 255, k >> 8);
					cover.set(key(col, row, k), { e, z: z[e], wx: p.wx, wy: p.wy, col, row, k });
					haveCover = true;
				}
			}
		}
	}
	const neighbour = (q, d) => {
		let i = (q.k & 255) + DIRS[d][0];
		let j = (q.k >> 8) + DIRS[d][1];
		let { col, row } = q;
		if (i < 0) (col--, (i += 256));
		else if (i > 255) (col++, (i -= 256));
		if (j < 0) (row--, (j += 256));
		else if (j > 255) (row++, (j -= 256));
		return { col, row, k: j * 256 + i };
	};
	const out = [];
	for (const [set, kind, min, width] of [[deck, 'bridge', DECK_MIN, DECK_WIDTH], [cover, 'gate', GATE_MIN, GATE_WIDTH]]) {
		const seen = new Set();
		for (const [start, q0] of [...set].sort((a, b) => (a[0] < b[0] ? -1 : 1))) {
			if (seen.has(start)) continue;
			seen.add(start);
			const comp = [q0];
			const contacts = [];
			for (let x = 0; x < comp.length; x++) {
				const q = comp[x];
				const t = nav.tile(c, q.col, q.row);
				for (let d = 0; d < 8; d++) {
					const code = t.links[q.e * 8 + d];
					if (code === NO_LINK) continue;
					const n = neighbour(q, d);
					const nk = key(n.col, n.row, n.k);
					const other = set.get(nk);
					if (other && Math.abs(other.z - q.z) <= 1.6) {
						if (!seen.has(nk)) {
							seen.add(nk);
							comp.push(other);
						}
						continue;
					}
					const t2 = nav.tile(c, n.col, n.row);
					if (!t2) continue;
					const e2 = t2.first[n.k] + (code & 31);
					if (t2.flags[e2] & (FLAG.SWIM | FLAG.INDOOR | FLAG.BLOCKED)) continue;
					const p = cellCentre(n.col, n.row, n.k & 255, n.k >> 8);
					contacts.push({ wx: p.wx, wy: p.wy, z: t2.z[e2] });
				}
			}
			if (comp.length < min) continue;
			// Extent: the two columns furthest apart (from the first, then from that one).
			const far = (a) => comp.reduce((b, q) => (Math.hypot(q.wx - a.wx, q.wy - a.wy) > Math.hypot(b.wx - a.wx, b.wy - a.wy) ? q : b), a);
			const A = far(comp[0]);
			const B = far(A);
			const span = Math.hypot(A.wx - B.wx, A.wy - B.wy) + CELL;
			if ((comp.length * CELL * CELL) / span > width) continue;
			if (kind === 'bridge' && (span < SPAN_MIN || comp.filter((q) => q.wet).length < WET_SHARE * comp.length)) continue;
			// Contact groups (columns within 2 cells are one group).
			const groups = [];
			for (const p of contacts) {
				const g = groups.filter((gr) => gr.some((x) => Math.hypot(x.wx - p.wx, x.wy - p.wy) <= 2.5 * CELL));
				if (!g.length) groups.push([p]);
				else {
					const merged = [].concat(...g, [p]);
					for (const gr of g) groups.splice(groups.indexOf(gr), 1);
					groups.push(merged);
				}
			}
			if (groups.length !== 2) continue;
			// The ends lie at opposite ends: their centres at least ENDS_APART of the span apart.
			const centre = (gr) => [gr.reduce((s, p) => s + p.wx, 0) / gr.length, gr.reduce((s, p) => s + p.wy, 0) / gr.length];
			const [c1, c2] = groups.map(centre);
			if (kind === 'bridge' && Math.hypot(c1[0] - c2[0], c1[1] - c2[1]) < ENDS_APART * span) continue;
			const mx = comp.reduce((s, q) => s + q.wx, 0) / comp.length;
			const my = comp.reduce((s, q) => s + q.wy, 0) / comp.length;
			const mid = comp.reduce((b, q) => (Math.hypot(q.wx - mx, q.wy - my) < Math.hypot(b.wx - mx, b.wy - my) ? q : b), comp[0]);
			const sides = groups.map((gr) => {
				const p = gr[gr.length >> 1];
				return { wx: round1(p.wx), wy: round1(p.wy), area: place(p.wx, p.wy).name };
			});
			out.push({ wx: round1(mid.wx), wy: round1(mid.wy), z: round1(mid.z), r: Math.round(Math.min(R_MAX, Math.max(R_MIN, span / 2))), kind, ...place(mid.wx, mid.wy), sides });
		}
	}
	return out;
}

// One continent's chokepoints.
// nav: openNav on the grid; aids: aids.json's doc (or null); lifts: lifts.json's list for c;
// geo: planner Geo (aids points are map percent, frame 'e'); areas: areaNames(AreaTable rows).
function chokepoints({ nav, c, aids, lifts = [], geo, areas }) {
	const place = (wx, wy) => {
		const p = cellOf(wx, wy);
		const t = nav.tile(c, p.col, p.row);
		return (t && areas(t.areas[(p.j >> 4) * 16 + (p.i >> 4)])) || { name: '', zone: '' };
	};
	const zOf = (wx, wy) => {
		const s = nav.snap({ c, wx, wy, radius: 15 });
		return s ? round1(s.z) : null;
	};
	const list = [];
	// Lifts.
	const landings = [];
	for (const L of lifts) {
		const ends = [L.a, L.b].map((x) => {
			const p = cellCentre(x.col, x.row, x.k & 255, x.k >> 8);
			let i = landings.findIndex((y) => y.id === L.id && Math.hypot(y.wx - p.wx, y.wy - p.wy) <= LIFT_SAME && Math.abs(y.z - x.z) <= STEP);
			if (i < 0) {
				landings.push({ id: L.id, lift: L.name, wx: p.wx, wy: p.wy, z: x.z });
				i = landings.length - 1;
			}
			return i;
		});
		const [a, b] = ends;
		landings[a].pair ??= b;
		landings[b].pair ??= a;
		landings[a].liftEnd = landings[a].z > landings[b].z ? 'top' : 'bottom';
		landings[b].liftEnd = landings[b].z > landings[a].z ? 'top' : 'bottom';
	}
	const base = list.length;
	for (const L of landings) {
		list.push({ wx: round1(L.wx), wy: round1(L.wy), z: round1(L.z), r: R_MIN, kind: 'lift', ...place(L.wx, L.wy), lift: L.lift, liftObject: L.id, liftEnd: L.liftEnd, pair: base + L.pair });
	}
	const near = (wx, wy, kind) => list.findIndex((x) => x.kind === kind && Math.hypot(x.wx - wx, x.wy - wy) <= MERGE);
	const world = (p) => geo.toWorld(p.map, p.x, p.y, 'e');
	// Aids: chain mouths, a cave's or building's moved in to where it turns indoor.
	for (const ch of (aids && aids.chains) || []) {
		const n0 = ch.nodes[0];
		const kind = CAPTION_KIND[n0.caption];
		const w = kind && world(n0);
		if (!w || w.c !== c) continue;
		let at = { wx: w.wx, wy: w.wy, z: zOf(w.wx, w.wy), r: Math.max(R_MIN, Math.min(R_MAX, n0.radius || R_MIN)) };
		if (kind === 'cave' || kind === 'building') {
			const mouth = indoorMouth(nav, c, ch.nodes.map(world).filter((p) => p && p.c === c));
			if (mouth) at = mouth;
		}
		if (near(at.wx, at.wy, kind) >= 0) continue;
		list.push({ wx: round1(at.wx), wy: round1(at.wy), z: at.z, r: at.r, kind, ...place(at.wx, at.wy) });
	}
	// Aids: zone crossings.
	for (const x of (aids && aids.crossings) || []) {
		const a = world(x.a);
		const b = world(x.b);
		if (!a || !b || a.c !== c || b.c !== c) continue;
		const caption = x.ab || x.ba || '';
		if (/lift/i.test(caption)) continue;
		const kind = /bridge/i.test(caption) ? 'bridge' : /tunnel/i.test(caption) ? 'tunnel' : 'pass';
		const wx = (a.wx + b.wx) / 2;
		const wy = (a.wy + b.wy) / 2;
		if (near(wx, wy, kind) >= 0) continue;
		const sides = [[a, x.a], [b, x.b]].map(([p]) => {
			const at = place(p.wx, p.wy);
			return { wx: round1(p.wx), wy: round1(p.wy), area: at.zone, ...(at.zoneArea ? { zoneArea: at.zoneArea } : {}) };
		});
		list.push({ wx: round1(wx), wy: round1(wy), z: zOf(wx, wy), r: Math.max(R_MIN, Math.min(R_MAX, x.a.radius || R_MIN)), kind, ...place(wx, wy), sides });
	}
	// The grid's bridges and gates; an aids pass where one stands becomes it.
	for (const g of gridChokepoints(nav, c, place)) {
		if (near(g.wx, g.wy, g.kind) >= 0) continue;
		const pass = near(g.wx, g.wy, 'pass');
		if (pass >= 0) {
			list[pass] = { ...list[pass], kind: g.kind, wx: g.wx, wy: g.wy, z: g.z, ...place(g.wx, g.wy) };
			continue;
		}
		if (g.kind === 'bridge') list.push(g);
	}
	for (const x of list) {
		if (x.z === null) delete x.z;
		if (!x.name) [x.name, x.area] = x.zone ? [x.zone, x.zoneArea] : [x.kind, undefined];
		if (!x.zone) [x.zone, x.zoneArea] = [x.name, x.area];
		for (const s of x.sides || []) {
			if (s.area) continue;
			s.area = x.zone;
			if (x.zoneArea) s.zoneArea = x.zoneArea;
		}
		for (const k of ['area', 'zoneArea']) if (!x[k]) delete x[k];
	}
	return list;
}

const luaStr = (s) => `"${String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"')}"`;

// { [c]: entries } -> Chokepoints.lua (global PolestarNavChokepoints); `gen`
// is its first line (generated.js header).
function chokepointsLua(byMap, gen, global = 'PolestarNavChokepoints') {
	const field = (k, v) => (typeof v === 'number' ? `${k} = ${v}` : typeof v === 'string' ? `${k} = ${luaStr(v)}` : `${k} = { ${v.map((s) => `{ ${Object.entries(s).map(([a, b]) => field(a, b)).join(', ')} }`).join(', ')} }`);
	const lines = [
		gen,
		'-- Chokepoints a walk passes, for its named steps (tools/lib/nav/chokepoints.js; Nav/Walk.lua reads them).',
		'-- Per continent: { wx, wy, z, r, kind, name, area?, zone, zoneArea?, sides?, liftEnd?, lift?, liftObject?, pair? } in UnitPosition\'s frame',
		'-- (area, zoneArea: AreaTable ids of name and zone, for their names in the client\'s language; liftObject: the lift\'s GameObject)',
		'-- (wx north, wy west), yards; kind lift | gate | bridge | tunnel | cave | building | pass; pair indexes this list.',
		`${global} = ${global} or {}`,
	];
	for (const c of Object.keys(byMap).map(Number).sort((a, b) => a - b)) {
		lines.push(`${global}[${c}] = {`);
		for (const x of byMap[c]) {
			const keys = ['wx', 'wy', 'z', 'r', 'kind', 'name', 'area', 'zone', 'zoneArea', 'lift', 'liftObject', 'liftEnd', 'pair', 'sides'].filter((k) => x[k] !== undefined);
			lines.push(`\t{ ${keys.map((k) => field(k, k === 'pair' ? x[k] + 1 : x[k])).join(', ')} },`);
		}
		lines.push('}');
	}
	return `${lines.join('\n')}\n`;
}

module.exports = { chokepoints, chokepointsLua, areaNames, gridChokepoints, MERGE, R_MIN, R_MAX };
