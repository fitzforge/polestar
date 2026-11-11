'use strict';
// Gathering routes: score zones for a skill band by expected skill-ups per
// yard walked, and turn the winning zone's nodes into a short loop of goto
// waypoints (weighted density clusters ordered as a closed tour).

const { makeProjector, dist } = require('../../route/geo');
const { planTour, pathLength } = require('../../route/tour');
const { bandWeight, FOREVER_NODES } = require('./tables');

const DEDUPE_YARDS = 5;
// A lap shorter than this outruns node respawns, so short laps score as if
// they were this long (yards).
const MIN_LAP_YARDS = 3000;

function projector(data) {
	return makeProjector(data.mapFrames || data['map-frames'] || {});
}

// Every spawn of a spawns record: `pts` (the reference data's evenly spread
// points, at most its cap per map) and `more` (the rest).
function allPoints(s) {
	return s ? [...(s.pts || []), ...(s.more || [])] : [];
}

// Every spawn on `map` of the objects whose name is in `table` ({ name: req })
// and whose roles include `role`, weighted for the band [from, to). A point's
// `up` is the nodes of its kind it stands for: the zone's nodes up at once
// (`abundance`, node-abundance.json: { name: { up } } for the map) spread over
// the kind's points, so a point listed for six pooled kinds counts for the one
// node the server puts there; a kind the zone's table lacks counts nothing. A
// map with no table, or whose table holds none of `table`'s kinds (Teldrassil's
// lists its herbs only, not its Amber), splits each point among the kinds
// listed at it. `w` is `up` times the band weight.
function nodePoints(objects, project, { table, role, map, from, to, abundance = null }) {
	const { raw, count } = mapNodes(objects, project, table, role, map);
	const ab = abundance && Object.keys(table).some((k) => abundance[k]) ? abundance : null;
	const out = [];
	for (const p of raw) {
		const bw = bandWeight(p.req, from, to);
		if (bw <= 0) continue;
		const up = ab ? (ab[p.name] ? ab[p.name].up / count.get(p.name) : 0) : p.share;
		if (up <= 0) continue;
		out.push({ name: p.name, req: p.req, up, w: bw * up, pt: p.pt });
	}
	return out;
}

// The deduplicated node points of `table` on `map` with each kind's count and
// each point's share of the kinds listed at it; cached per objects/project.
const nodeCache = new WeakMap();
function mapNodes(objects, project, table, role, map) {
	if (!nodeCache.has(objects)) nodeCache.set(objects, new Map());
	const cache = nodeCache.get(objects);
	const key = `${role}|${map}|${Object.keys(table).length}`;
	const hit = cache.get(key);
	if (hit && hit.project === project && hit.table === table) return hit;
	const raw = [];
	for (const o of Object.values(objects)) {
		// Forever's own nodes carry no role in the data: their name in the table is enough.
		if (!(o.roles && o.roles.includes(role)) && !FOREVER_NODES.has(o.name)) continue;
		const req = table[o.name];
		if (req === undefined) continue;
		const s = o.spawns && o.spawns[String(map)];
		if (!s) continue;
		for (const [x, y] of allPoints(s)) {
			const pt = project.point(map, x, y, s.f);
			if (raw.some((p) => p.name === o.name && dist(p.pt, pt) < DEDUPE_YARDS)) continue;
			raw.push({ name: o.name, req, pt });
		}
	}
	const count = new Map();
	for (const p of raw) {
		count.set(p.name, (count.get(p.name) || 0) + 1);
		p.share = 1 / new Set(raw.filter((q) => dist(q.pt, p.pt) < DEDUPE_YARDS).map((q) => q.name)).size;
	}
	const out = { project, table, raw, count };
	cache.set(key, out);
	return out;
}

// Greedy weighted clustering: seed = point with the heaviest neighbourhood.
function weightedClusters(points, radius, project) {
	let rest = points.slice().sort((a, b) => a.pt.x - b.pt.x || a.pt.y - b.pt.y || a.name.localeCompare(b.name));
	const out = [];
	while (rest.length) {
		let best = 0;
		let bestW = -1;
		for (let i = 0; i < rest.length; i++) {
			let w = 0;
			for (const p of rest) if (dist(rest[i].pt, p.pt) <= radius) w += p.w;
			if (w > bestW + 1e-9) {
				bestW = w;
				best = i;
			}
		}
		const seed = rest[best];
		const members = rest.filter((p) => dist(seed.pt, p.pt) <= radius);
		rest = rest.filter((p) => dist(seed.pt, p.pt) > radius);
		const x = members.reduce((s, p) => s + p.pt.x, 0) / members.length;
		const y = members.reduce((s, p) => s + p.pt.y, 0) / members.length;
		// Nodes of each kind the cluster holds (a pooled point counts its share).
		const counts = {};
		for (const p of members) counts[p.name] = (counts[p.name] || 0) + (p.up === undefined ? 1 : p.up);
		out.push({
			pt: project.point(seed.pt.map, Math.round(x * 10) / 10, Math.round(y * 10) / 10, seed.pt.f),
			w: bestW,
			counts,
		});
	}
	return out;
}

// Expected skill-ups per yard for one lap over every useful node in the zone.
// `perPoint`: yards a stop at each point costs on top of the walk (a beast to
// kill before it can be skinned), so a zone of many low-value points does not
// win on density alone.
function scorePoints(points, { perPoint = 0 } = {}) {
	if (!points.length) return { gain: 0, length: Infinity, score: 0 };
	const gain = points.reduce((s, p) => s + p.w, 0);
	const start = points[0].pt;
	const order = planTour(start, points.slice(1), start);
	const length = Math.max(1, pathLength(start, order, start));
	const stops = perPoint * points.reduce((s, p) => s + (p.up === undefined ? 1 : p.up), 0);
	return { gain, length, score: gain / (Math.max(length, MIN_LAP_YARDS) + stops) };
}

// A loop of at most `maxStops` cluster waypoints covering `cover` of the
// zone's skill-up weight, starting from the cluster nearest `entry`. `rare`:
// kinds that never lead a waypoint (build.js `rareKinds`): a cluster holding
// at least half its nodes of them is left out while three others remain.
function loop(points, project, { radius = 110, maxStops = 12, cover = 0.85, entry = null, rare = null } = {}) {
	let cl = weightedClusters(points, radius, project);
	if (rare && rare.size) {
		const kept = cl.filter((c) => {
			let all = 0;
			let few = 0;
			for (const [name, n] of Object.entries(c.counts)) {
				all += n;
				if (rare.has(name)) few += n;
			}
			return few * 2 < all;
		});
		if (kept.length >= 3) cl = kept;
	}
	const total = cl.reduce((s, c) => s + c.w, 0);
	const keep = [];
	let acc = 0;
	for (const c of cl) {
		if (keep.length >= maxStops || (keep.length >= 3 && acc >= cover * total)) break;
		keep.push(c);
		acc += c.w;
	}
	if (!keep.length) return [];
	let first = keep[0];
	if (entry) {
		for (const c of keep) if (dist(entry, c.pt) < dist(entry, first.pt)) first = c;
	}
	const rest = keep.filter((c) => c !== first);
	return [first, ...planTour(first.pt, rest, first.pt)];
}

module.exports = { projector, allPoints, nodePoints, weightedClusters, scorePoints, loop };
