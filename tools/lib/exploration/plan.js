'use strict';
// Exploration routes: for each guide in spec.js, per route (faction or both),
// the zones in spec order, and inside each zone a shortest tour over its
// overlay centres (nearest neighbour + 2-opt, route/tour.js) from where the
// player arrives towards the next zone they walk to.

const { makeProjector, dist } = require('../route/geo');
const { planTour } = require('../route/tour');
const { TOWNS, CAUTIONS } = require('./spec');

const MAX_GOALS_PER_STEP = 8;
// Area levels this far above a guide's top level get a warning.
const DANGER_MARGIN = 5;
const MAX_PLAYER_LEVEL = 60;
// Areas this far above a guide's top level (below the level cap) wait in a
// step of their own at the end of their zone, one the player can skip and
// come back to later (Feralas's level 60 Oneiros and Dream Bough in the
// 30-45 guide); they stay out of the zone's tour.
const LATER_MARGIN = 10;
const TAXI_SIDE = { 1: 'Alliance', 2: 'Horde', 3: 'both' };
const FACTIONS = ['Alliance', 'Horde'];

// ctx: { areas: { [map]: overlays }, continents: { [map]: continentMap },
//        zones: zones.json, frames: map-frames.json, travel: travel.json }
// Overlay centres are in each map's Forever (live) frame, so points project
// through `frames.forever` (Era bounds only for a map Forever has none for).
// ctx.live: the maps whose live frame is not their Era frame (moved by
// Forever, or Forever-only): their goals are written in the live frame.
function context({ areas, continents, zones, frames, travel }) {
	const era = (frames && frames.era) || {};
	const forever = (frames && frames.forever) || {};
	const project = makeProjector({ era: { ...era, ...forever } });
	const live = new Set();
	for (const map of Object.keys(areas)) {
		const e = era[map], f = forever[map];
		if (!e || (f && ['c', 'left', 'right', 'top', 'bottom'].some((k) => Math.abs(e[k] - f[k]) > 0.01))) live.add(Number(map));
	}
	const zoneId = new Map();
	for (const z of Object.values(zones)) if (z.type === 3 && !zoneId.has(z.name)) zoneId.set(z.name, z.id);
	return { areas: placeFallbacks(areas, travel, project), continents, zones, project, travel, zoneId, live };
}

// An overlay without a usable hit rect (centre from its texture, see
// areas.js) goes where a flight master or inn named like one of its areas
// stands on that map, when there is one: a spot surely inside the area.
function placeFallbacks(areas, travel, project) {
	const places = [
		...travel.taxi.nodes.map((n) => ({ ...n, name: n.short })),
		...travel.inns.flatMap((i) => i.names.map((name) => ({ ...i, name }))),
	];
	const out = {};
	for (const [map, list] of Object.entries(areas)) {
		const b = project.bounds(map);
		out[map] = list.map((o) => {
			if (!o.fromTexture) return o;
			const p = places.find((q) => String(q.map) === map && q.c === b.c && o.areas.some((a) => a.name === q.name));
			if (!p) return o;
			const x = Math.round(((p.wy - b.left) / (b.right - b.left)) * 1000) / 10;
			const y = Math.round(((p.wx - b.top) / (b.bottom - b.top)) * 1000) / 10;
			return { ...o, x, y, place: p.name };
		});
	}
	return out;
}

function mapOf(ctx, name) {
	const id = ctx.zoneId.get(name);
	if (!id) throw new Error(`exploration spec: unknown zone "${name}"`);
	if (!ctx.areas[id]) throw new Error(`exploration spec: ${name} (${id}) has no map overlays in the client tables`);
	return id;
}

// An overlay's area names, each once (AreaTable can give a zone area and its
// instance area the same name).
function areaNames(o) {
	return [...new Set(o.areas.map((a) => a.name))];
}

function areaLabel(o) {
	return areaNames(o).join(' / ');
}

// The lowest known level among an overlay's areas (any one of them reveals it).
function overlayLevel(o) {
	const lv = o.areas.map((a) => a.level).filter((l) => l > 0);
	return lv.length ? Math.min(...lv) : 0;
}

function isLater(o, maxLevel) {
	return maxLevel < MAX_PLAYER_LEVEL && overlayLevel(o) >= maxLevel + LATER_MARGIN;
}

function findArea(ctx, name) {
	for (const [map, list] of Object.entries(ctx.areas)) {
		const o = list.find((x) => x.areas.some((a) => a.name === name));
		if (o) return { map: Number(map), o };
	}
	return null;
}

function taxiNode(ctx, short) {
	const n = ctx.travel.taxi.nodes.find((t) => t.short === short);
	if (!n) throw new Error(`exploration spec: no flight master at "${short}" in travel.json`);
	return n;
}

function transportStop(ctx, name) {
	for (const t of ctx.travel.transports) for (const end of [t.a, t.b]) if (end.name === name) return end;
	throw new Error(`exploration spec: no transport stop "${name}" in travel.json`);
}

// World point of a travel.json place (world position as recorded).
function placePoint(p) {
	return { map: p.map, x: p.x, y: p.y, f: 'e', c: p.c, wx: p.wx, wy: p.wy };
}

// World point of a `from` / `start` spec.
function fromPoint(ctx, from) {
	if (from.taxi) return placePoint(taxiNode(ctx, from.taxi));
	if (from.stop) return placePoint(transportStop(ctx, from.stop));
	if (from.area) {
		const hit = findArea(ctx, from.area);
		if (!hit) throw new Error(`exploration spec: no map area "${from.area}"`);
		return ctx.project.point(hit.map, hit.o.x, hit.o.y, 'e');
	}
	throw new Error(`exploration spec: bad from ${JSON.stringify(from)}`);
}

function nodesOf(ctx, map) {
	return ctx.areas[map].map((o) => ({ o, pt: ctx.project.point(map, o.x, o.y, 'e') }));
}

function centroid(nodes) {
	const n = nodes.length;
	return { ...nodes[0].pt, wx: nodes.reduce((s, x) => s + x.pt.wx, 0) / n, wy: nodes.reduce((s, x) => s + x.pt.wy, 0) / n };
}

// Split a tour into steps of at most MAX_GOALS_PER_STEP, evenly sized.
function chunks(list) {
	const n = Math.ceil(list.length / MAX_GOALS_PER_STEP);
	const size = Math.ceil(list.length / n);
	const out = [];
	for (let i = 0; i < list.length; i += size) out.push(list.slice(i, i + size));
	return out;
}

// Flight masters on a zone map: { both: neutral ones, Alliance, Horde }.
function flightMasters(ctx, map) {
	const out = { both: [], Alliance: [], Horde: [] };
	for (const n of ctx.travel.taxi.nodes.slice().sort((a, b) => a.id - b.id)) {
		if (n.map !== map) continue;
		const key = TAXI_SIDE[n.faction];
		if (key) out[key].push(`${n.short} (${n.npcName})`);
	}
	return out;
}

// Travel text per faction: { both, Alliance, Horde } (missing keys empty).
function travelLines(travel) {
	if (!travel) return {};
	if (typeof travel === 'string') return { both: travel };
	return travel;
}

// Per-goal warnings: the other faction's town, a known hazard, an area above
// the guide's level band. `side` = the faction the step is for, or null.
function goalNotes(o, side, maxLevel) {
	const names = areaNames(o);
	const notes = [];
	for (const owner of FACTIONS) {
		if (side === owner) continue;
		const town = names.find((n) => TOWNS[owner].includes(n));
		if (!town) continue;
		const other = owner === 'Alliance' ? 'Horde' : 'Alliance';
		notes.push(side ? `${owner} guards: touch the edge of ${town} and move on` : `${owner} town: ${other} characters only need to touch its edge (guards)`);
	}
	for (const n of names) if (CAUTIONS[n]) notes.push(CAUTIONS[n]);
	const lv = overlayLevel(o);
	if (lv >= Math.min(maxLevel + DANGER_MARGIN, MAX_PLAYER_LEVEL + 1)) notes.push(`level ${lv} area, well above this guide's range`);
	if (names.length > 1) notes.push('any one of these names counts');
	return notes;
}

// One route (list of visits) -> planned visits with ordered overlay tours.
function planRoute(ctx, guide, route, side) {
	const visits = route.visits.map((v) => ({ ...v, map: mapOf(ctx, v.zone) }));
	const out = [];
	let at = null;
	visits.forEach((v, i) => {
		const nodes = nodesOf(ctx, v.map);
		const first = i === 0 ? route.start : v.from;
		let start = first ? fromPoint(ctx, first) : at;
		const pick = (name, what) => {
			const k = rest.findIndex((n) => n.o.areas.some((a) => a.name === name));
			if (k < 0) throw new Error(`exploration spec: ${what} area "${name}" is not in ${v.zone}`);
			const [node] = rest.splice(k, 1);
			return node;
		};
		const rest = nodes.slice();
		const head = first && first.area ? [pick(first.area, 'start')] : [];
		const tail = v.exit ? [pick(v.exit.area, 'exit')] : [];
		if (!start) start = centroid(nodes);
		// Walk towards the exit, or the next zone unless the player travels
		// there another way.
		const next = visits[i + 1];
		let end = tail.length ? tail[0].pt : null;
		if (!end && next && !next.from) {
			const c = centroid(rest.length ? rest : nodes);
			const target = nodesOf(ctx, next.map);
			end = target.reduce((b, n) => (dist(c, n.pt) < dist(c, b.pt) ? n : b)).pt;
			if (end.c !== start.c) end = null;
		}
		const max = guide.levels[1];
		const now = rest.filter((n) => !isLater(n.o, max));
		const order = [...head, ...planTour(head.length ? head[0].pt : start, now, end), ...tail];
		at = order[order.length - 1].pt;
		const later = rest.filter((n) => isLater(n.o, max));
		const levels = nodes.map((n) => overlayLevel(n.o)).filter((l) => l > 0);
		const goal = (n) => ({ ...n.o, notes: goalNotes(n.o, side, max) });
		out.push({
			zone: v.zone,
			map: v.map,
			travel: travelLines(v.travel),
			tip: v.tip || null,
			fps: flightMasters(ctx, v.map),
			levels: levels.length ? [Math.min(...levels), Math.max(...levels)] : null,
			steps: chunks(order.map(goal)),
			later: later.length ? planTour(at, later, null).map(goal) : [],
		});
	});
	return out;
}

// -> [{ side: 'Alliance'|'Horde'|null, visits }]
function planGuide(ctx, guide) {
	const out = [];
	for (const key of ['both', ...FACTIONS]) {
		const route = guide.routes[key];
		if (!route) continue;
		const side = key === 'both' ? null : key;
		out.push({ side, visits: planRoute(ctx, guide, route, side) });
	}
	return out;
}

module.exports = { context, planGuide, planRoute, goalNotes, overlayLevel, isLater, areaLabel, chunks, MAX_GOALS_PER_STEP };
