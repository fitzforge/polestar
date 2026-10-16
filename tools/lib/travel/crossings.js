'use strict';
// Zone crossings: where walking may leave one zone for another.
//
// Three kinds of entry, all in map percent of the Era client maps:
//   crossings  a pair of points, one in each zone, at a tunnel, pass, bridge,
//              gate or lift, each with an arrival radius in yards; an optional
//              caption per direction ("ab": walking a -> b, "ba": b -> a) and
//              `oneWay` (a -> b only)
//   open       zone pairs whose shared border is walkable anywhere
//   chains     approach chains: ordered nodes with radius and caption (a cave
//              or a climb); nodes after the mouth are reachable only through
//              their own chain links ("open": "mouth"), or the last node is a
//              second mouth ("both")
//
// Sources: an optional local crossings file (data/local/crossings.json,
// gitignored; built into the local data addon Polestar_Travel, never
// committed or packaged) and zone changes in recorded play (learned paths,
// written into TravelData.lua). Every entry is validated here; errors name
// the entry. `recordedChain` drafts a chain from recorded walks for a person
// to check (`travel chain`); nothing uses a drafted chain unreviewed.

const fs = require('node:fs');
const { round, placePoint } = require('./geo');
const { packageVersion } = require('../dsl/project');
const { header } = require('../generated');

const LIMITS = {
	radiusMin: 3, // yards
	radiusMax: 100,
	pairYards: 1000, // between the two ends of a crossing
	hopYards: 600, // between consecutive chain nodes
	caption: 160, // characters
	offMap: [-50, 150], // map percent allowed with `offMap: true`
};

const KEYS = {
	top: ['schema', 'frame', 'source', 'build', 'crossings', 'open', 'chains'],
	crossing: ['id', 'a', 'b', 'ab', 'ba', 'oneWay'],
	end: ['map', 'x', 'y', 'radius', 'offMap'],
	open: ['a', 'b', 'oneWay'],
	chain: ['id', 'name', 'open', 'nodes'],
	node: ['map', 'x', 'y', 'radius', 'caption', 'back', 'offMap'],
};

const isObj = (v) => v !== null && typeof v === 'object' && !Array.isArray(v);

function unknownKeys(obj, allowed, where, errors) {
	for (const k of Object.keys(obj)) if (!allowed.includes(k)) errors.push(`${where}: unknown key "${k}"`);
}

function checkCaption(v, where, errors) {
	if (v === undefined) return undefined;
	if (typeof v !== 'string' || !v.trim()) {
		errors.push(`${where}: caption must be a non-empty string`);
		return undefined;
	}
	if (v.length > LIMITS.caption) errors.push(`${where}: caption longer than ${LIMITS.caption} characters`);
	// eslint-disable-next-line no-control-regex
	if (/[\u0000-\u001f]|\|[cCrRTtnH]/.test(v)) errors.push(`${where}: caption has control characters or | escape codes`);
	return v;
}

// One point: { map, x, y, radius, offMap } -> { map, x, y, r, c, wx, wy } or null.
function checkPoint(p, where, keys, frames, errors) {
	if (!isObj(p)) {
		errors.push(`${where}: expected an object`);
		return null;
	}
	unknownKeys(p, keys, where, errors);
	let ok = true;
	if (!Number.isInteger(p.map) || !frames.frame(p.map)) {
		errors.push(`${where}: map ${JSON.stringify(p.map)} is not a known uiMap id with a map frame`);
		ok = false;
	}
	for (const k of ['x', 'y']) {
		const v = p[k];
		if (typeof v !== 'number' || !Number.isFinite(v)) {
			errors.push(`${where}: ${k} must be a number`);
			ok = false;
			continue;
		}
		const [lo, hi] = p.offMap === true ? LIMITS.offMap : [0, 100];
		if (v < lo || v > hi) {
			errors.push(`${where}: ${k} ${v} outside ${lo}-${hi}${p.offMap === true ? '' : ' (set "offMap": true for a point past the map edge)'}`);
			ok = false;
		}
	}
	if (p.offMap !== undefined && typeof p.offMap !== 'boolean') errors.push(`${where}: offMap must be true or false`);
	if (typeof p.radius !== 'number' || !Number.isFinite(p.radius)) {
		errors.push(`${where}: radius (yards) is required`);
		ok = false;
	} else if (p.radius < LIMITS.radiusMin || p.radius > LIMITS.radiusMax) {
		errors.push(`${where}: radius ${p.radius} outside ${LIMITS.radiusMin}-${LIMITS.radiusMax} yd`);
		ok = false;
	}
	if (!ok) return null;
	const w = frames.toWorld(p.map, p.x, p.y);
	return { map: p.map, x: p.x, y: p.y, r: p.radius, c: w.c, wx: round(w.wx, 1), wy: round(w.wy, 1) };
}

const yards = (a, b) => (a.c === b.c ? Math.hypot(a.wx - b.wx, a.wy - b.wy) : Infinity);

// doc: the parsed crossings file -> { errors, crossings, open, chains } (normalised, with world positions).
function validateCrossings(doc, frames) {
	const errors = [];
	const out = { errors, crossings: [], open: [], chains: [] };
	if (!isObj(doc)) {
		errors.push('crossings file: expected a JSON object');
		return out;
	}
	unknownKeys(doc, KEYS.top, 'crossings file', errors);
	if (doc.schema !== 1) errors.push(`crossings file: schema ${JSON.stringify(doc.schema)} (expected 1)`);
	if (doc.frame !== undefined && doc.frame !== 'e') errors.push(`crossings file: frame ${JSON.stringify(doc.frame)} (only "e", the Era client maps)`);
	const ids = new Map();
	const claim = (id, where) => {
		if (typeof id !== 'string' || !/^[a-z0-9][a-z0-9-]*$/.test(id)) {
			errors.push(`${where}: id ${JSON.stringify(id)} must be lower-case letters, digits and dashes`);
			return;
		}
		if (ids.has(id)) errors.push(`${where}: duplicate id "${id}" (also ${ids.get(id)})`);
		else ids.set(id, where);
	};
	const list = (k) => {
		if (doc[k] === undefined) return [];
		if (!Array.isArray(doc[k])) {
			errors.push(`crossings file: ${k} must be an array`);
			return [];
		}
		return doc[k];
	};

	list('crossings').forEach((e, i) => {
		const where = `crossings[${i}]${isObj(e) && typeof e.id === 'string' ? ` (${e.id})` : ''}`;
		if (!isObj(e)) {
			errors.push(`${where}: expected an object`);
			return;
		}
		unknownKeys(e, KEYS.crossing, where, errors);
		claim(e.id, where);
		const a = checkPoint(e.a, `${where}.a`, KEYS.end, frames, errors);
		const b = checkPoint(e.b, `${where}.b`, KEYS.end, frames, errors);
		const ab = checkCaption(e.ab, `${where}.ab`, errors);
		const ba = checkCaption(e.ba, `${where}.ba`, errors);
		if (e.oneWay !== undefined && typeof e.oneWay !== 'boolean') errors.push(`${where}: oneWay must be true or false`);
		if (!a || !b) return;
		if (a.c !== b.c) {
			errors.push(`${where}: the ends are on different continents (${a.c}, ${b.c})`);
			return;
		}
		if (a.map === b.map) {
			errors.push(`${where}: both ends are in zone ${a.map}; a crossing joins two zones`);
			return;
		}
		const d = yards(a, b);
		if (d > LIMITS.pairYards) {
			errors.push(`${where}: the ends are ${Math.round(d)} yd apart (more than ${LIMITS.pairYards})`);
			return;
		}
		out.crossings.push({ id: e.id, a, b, ab, ba, oneWay: e.oneWay === true });
	});

	const pairs = new Set();
	list('open').forEach((e, i) => {
		const where = `open[${i}]`;
		if (!isObj(e)) {
			errors.push(`${where}: expected an object`);
			return;
		}
		unknownKeys(e, KEYS.open, where, errors);
		const fa = Number.isInteger(e.a) && frames.frame(e.a);
		const fb = Number.isInteger(e.b) && frames.frame(e.b);
		if (!fa) errors.push(`${where}: a ${JSON.stringify(e.a)} is not a known uiMap id with a map frame`);
		if (!fb) errors.push(`${where}: b ${JSON.stringify(e.b)} is not a known uiMap id with a map frame`);
		if (e.oneWay !== undefined && typeof e.oneWay !== 'boolean') errors.push(`${where}: oneWay must be true or false`);
		if (!fa || !fb) return;
		if (e.a === e.b) return void errors.push(`${where}: a zone is not a pair with itself`);
		if (fa.c !== fb.c) return void errors.push(`${where}: ${e.a} and ${e.b} are on different continents`);
		const key = `${Math.min(e.a, e.b)}-${Math.max(e.a, e.b)}`;
		if (pairs.has(key)) return void errors.push(`${where}: duplicate open pair ${e.a} / ${e.b}`);
		pairs.add(key);
		out.open.push({ a: e.a, b: e.b, c: fa.c, oneWay: e.oneWay === true });
	});

	list('chains').forEach((e, i) => {
		const where = `chains[${i}]${isObj(e) && typeof e.id === 'string' ? ` (${e.id})` : ''}`;
		if (!isObj(e)) {
			errors.push(`${where}: expected an object`);
			return;
		}
		unknownKeys(e, KEYS.chain, where, errors);
		claim(e.id, where);
		if (e.name !== undefined && (typeof e.name !== 'string' || !e.name.trim())) errors.push(`${where}: name must be a non-empty string`);
		const open = e.open === undefined ? 'mouth' : e.open;
		if (open !== 'mouth' && open !== 'both') errors.push(`${where}: open must be "mouth" or "both"`);
		if (!Array.isArray(e.nodes) || e.nodes.length < 2) {
			errors.push(`${where}: a chain needs at least 2 nodes`);
			return;
		}
		const nodes = e.nodes.map((n, k) => {
			const p = checkPoint(n, `${where}.nodes[${k}]`, KEYS.node, frames, errors);
			const caption = checkCaption(n && n.caption, `${where}.nodes[${k}].caption`, errors);
			const back = checkCaption(n && n.back, `${where}.nodes[${k}].back`, errors);
			return p && { ...p, caption, back };
		});
		if (nodes.some((n) => !n)) return;
		for (let k = 1; k < nodes.length; k++) {
			const d = yards(nodes[k - 1], nodes[k]);
			if (!Number.isFinite(d)) return void errors.push(`${where}: nodes ${k - 1} and ${k} are on different continents`);
			if (d > LIMITS.hopYards) return void errors.push(`${where}: nodes ${k - 1} -> ${k} are ${Math.round(d)} yd apart (more than ${LIMITS.hopYards})`);
		}
		out.chains.push({ id: e.id, name: e.name || e.id, open, c: nodes[0].c, nodes });
	});
	return out;
}

// The optional local file: null when absent; throws with every error listed.
function readCrossingsFile(file, frames) {
	if (!file || !fs.existsSync(file)) return null;
	let doc;
	try {
		doc = JSON.parse(fs.readFileSync(file, 'utf8'));
	} catch (err) {
		throw new Error(`${file}: ${err.message}`);
	}
	const v = validateCrossings(doc, frames);
	if (v.errors.length) throw new Error(`${file}: ${v.errors.length} error(s)\n  ${v.errors.join('\n  ')}`);
	return v;
}

// Zone changes in recorded play -> crossings (our own data). steps: { c,
// from: { map, wx, wy }, to: { map, wx, wy }, session } where one breadcrumb
// is in `from.map` and the next in `to.map`. Steps of one zone pair within
// GRID yards of each other merge; each end is the mean of its points.
const RECORDED_GRID = 100;
const RECORDED_RADIUS = 20;

function recordedCrossings(steps, frames) {
	const groups = new Map();
	for (const s of steps) {
		const [lo, hi] = s.from.map < s.to.map ? [s.from, s.to] : [s.to, s.from];
		const mx = (lo.wx + hi.wx) / 2;
		const my = (lo.wy + hi.wy) / 2;
		const key = `${s.c}:${lo.map}:${hi.map}:${Math.floor(mx / RECORDED_GRID)}:${Math.floor(my / RECORDED_GRID)}`;
		let g = groups.get(key);
		if (!g) {
			g = { c: s.c, lo: lo.map, hi: hi.map, a: { x: 0, y: 0 }, b: { x: 0, y: 0 }, n: 0, sessions: new Set() };
			groups.set(key, g);
		}
		g.a.x += lo.wx;
		g.a.y += lo.wy;
		g.b.x += hi.wx;
		g.b.y += hi.wy;
		g.n += 1;
		g.sessions.add(s.session);
	}
	const keys = [...groups.keys()].sort();
	const seen = new Map();
	return keys.map((key) => {
		const g = groups.get(key);
		const base = `recorded-${g.lo}-${g.hi}`;
		const k = (seen.get(base) || 0) + 1;
		seen.set(base, k);
		const end = (map, sx, sy) => {
			const wx = round(sx / g.n, 1);
			const wy = round(sy / g.n, 1);
			const p = frames.toMap(map, g.c, wx, wy);
			return { map, x: p ? round(p.x, 2) : null, y: p ? round(p.y, 2) : null, r: RECORDED_RADIUS, c: g.c, wx, wy };
		};
		return {
			id: `${base}-${k}`,
			a: end(g.lo, g.a.x, g.a.y),
			b: end(g.hi, g.b.x, g.b.y),
			oneWay: false,
			steps: g.n,
			sessions: [...g.sessions].sort(),
		};
	});
}

// --- approach chains from recorded walks ------------------------------------------
//
// A candidate approach chain for one target, from the recorded walks that
// reach it, for a person to check in game before it goes into the crossings
// file. Every pass a walk makes within REACH yards of the target gives two
// approaches: the walk up to its closest point and, with `reverse`, the walk
// after it, reversed (a way out is not always a way in: a drop down a cliff is
// one way), each followed back `within` yards; a shorter one does not count. It leaves the straight line where it has walked WASTE yards more than
// a straight walk to the target (the arrow's line) would have; from there to
// the target is its chain, simplified (Douglas-Peucker, `tolerance` yards)
// into nodes. Walks from different sides meet at the real mouth, so the
// shortest chain is the candidate. An approach that keeps to the straight
// line is reported but does not cancel the others: recordings have no height,
// so a walk that followed the bad arrow onto the hill above a cave looks
// straight too. `sessions` keeps only the walks of those sessions.
const CHAIN = { reach: 30, within: 300, tolerance: 8, waste: 20, mouthRadius: 15, radius: 10 };

const dist = (a, b) => Math.hypot(a.wx - b.wx, a.wy - b.wy);

function segDist(p, a, b) {
	const dx = b.wx - a.wx;
	const dy = b.wy - a.wy;
	const len2 = dx * dx + dy * dy;
	const k = len2 ? Math.max(0, Math.min(1, ((p.wx - a.wx) * dx + (p.wy - a.wy) * dy) / len2)) : 0;
	return Math.hypot(p.wx - (a.wx + k * dx), p.wy - (a.wy + k * dy));
}

// Douglas-Peucker over world points; a hop longer than a chain allows is split too.
function simplify(pts, eps) {
	const keep = new Set([0, pts.length - 1]);
	const split = (i, j) => {
		let far = -1;
		let farD = eps;
		for (let k = i + 1; k < j; k++) {
			const d = segDist(pts[k], pts[i], pts[j]);
			if (d > farD) {
				farD = d;
				far = k;
			}
		}
		if (far < 0 && j - i > 1 && dist(pts[i], pts[j]) > LIMITS.hopYards) far = (i + j) >> 1;
		if (far < 0) return;
		keep.add(far);
		split(i, far);
		split(far, j);
	};
	split(0, pts.length - 1);
	return [...keep].sort((a, b) => a - b).map((k) => pts[k]);
}

// way: walked points ending at the one closest to the target -> null (it
// starts within `within` yards) or { yards, path } (path null: the walk
// keeps to the straight line).
function approach(way, target, within) {
	let s = way.length - 1;
	while (s >= 0 && dist(way[s], target) <= within) s--;
	if (s < 0) return null;
	const pts = way.slice(s);
	const end = pts[pts.length - 1];
	const walked = new Array(pts.length).fill(0); // yards walked from i to the end
	for (let i = pts.length - 2; i >= 0; i--) walked[i] = walked[i + 1] + dist(pts[i], pts[i + 1]);
	const waste = (i) => walked[i] - dist(pts[i], end); // never grows along the walk
	let d = 0;
	while (d < pts.length - 1 && waste(0) - waste(d + 1) <= CHAIN.waste) d++;
	if (d === pts.length - 1) return { yards: 0, path: null };
	return { yards: walked[d], path: pts.slice(d) };
}

// walks: paths.js recordedWalks; target: { map, x, y } (Era frame);
// sessions: session ids to keep (all when unset); reverse: count ways out ->
// { chain: a crossings-file chain entry or null, approaches: [{ session,
// direction: 'in'|'out', yards, mouth: { map, x, y } | null }], nearest:
// yards from the target to the closest breadcrumb on its continent, or null }.
function recordedChain({ walks, target, frames, within = CHAIN.within, tolerance = CHAIN.tolerance, id, name, sessions, reverse = false }) {
	const t = frames.toWorld(target.map, target.x, target.y);
	if (!t) throw new Error(`no Era map frame for map ${target.map}`);
	const place = (p) => {
		const m = placePoint(frames, p.c, p.wx, p.wy, { prefer: [p.map] });
		if (!m) throw new Error(`no zone map holds the recorded point (${round(p.wx, 1)}, ${round(p.wy, 1)})`);
		return m;
	};
	const approaches = [];
	let nearest = null;
	let best = null;
	const keep = sessions && new Set(sessions);
	for (const { session, points } of walks) {
		if (keep && !keep.has(session)) continue;
		// Visits: runs of points within REACH, each at its closest point; a walk
		// may come back. Each visit's way in starts where the last one ended.
		const visits = [];
		for (let i = 0; i < points.length; i++) {
			if (points[i].c !== t.c) continue;
			const d = dist(points[i], t);
			if (nearest === null || d < nearest) nearest = d;
			if (d > CHAIN.reach) continue;
			const v = visits[visits.length - 1];
			if (v && v.last === i - 1) {
				v.last = i;
				if (d < dist(points[v.at], t)) v.at = i;
			} else visits.push({ first: i, last: i, at: i });
		}
		visits.forEach((v, k) => {
			const from = k > 0 ? visits[k - 1].last : 0;
			const to = k < visits.length - 1 ? visits[k + 1].first : points.length - 1;
			const ways = [['in', points.slice(from, v.at + 1)]];
			if (reverse) ways.push(['out', points.slice(v.at, to + 1).reverse()]);
			for (const [direction, way] of ways) {
				const a = approach(way, t, within);
				if (!a) continue;
				approaches.push({ session, direction, yards: Math.round(a.yards), mouth: a.path && place(a.path[0]) });
				if (a.path && (!best || a.yards < best.yards)) best = a;
			}
		});
	}
	if (!best) return { chain: null, approaches, nearest };

	const pts = simplify(best.path, tolerance);
	const nodes = pts.map((p, i) => {
		const hops = [pts[i - 1], pts[i + 1]].filter(Boolean).map((q) => dist(p, q));
		const radius = Math.max(LIMITS.radiusMin, Math.min(i === 0 ? CHAIN.mouthRadius : CHAIN.radius, Math.floor(Math.min(...hops) / 2)));
		// Unset captions take the addon's translated default ("Follow the path").
		return { ...place(p), radius, ...(i === 0 && name ? { caption: `Go to ${name}` } : {}) };
	});
	const slug = (s) => String(s).toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '');
	const chain = {
		id: id || (name && slug(name)) || `recorded-chain-${target.map}-${Math.round(target.x)}-${Math.round(target.y)}`,
		...(name ? { name } : {}),
		open: 'mouth',
		nodes,
	};
	return { chain, approaches, nearest };
}

// --- Lua -----------------------------------------------------------------------

function luaStr(s) {
	return `"${String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, '\\n').replace(/\r/g, '\\r')}"`;
}

const num = (n) => String(Object.is(n, -0) ? 0 : n);

function endLua(p) {
	return `{ map = ${p.map}, c = ${p.c}, wx = ${num(p.wx)}, wy = ${num(p.wy)}, r = ${num(p.r)} }`;
}

// Zone info the planner needs for every zone a set mentions: name and frame
// (to place a point whose map is not a zone), plus `wild`: the other zone
// maps of a covered continent (no crossing data; walked as before). `live`:
// map-frames.json `forever`, the frames of the maps Forever redrew (Stormwind
// City with its harbour) or added (Mount Hyjal): a zone's rectangle is the
// one in game, and a zone only Forever has is wild.
function zoneTable(set, frames, { complete, live = {} }) {
	const maps = new Set();
	for (const e of set.crossings) maps.add(e.a.map).add(e.b.map);
	for (const e of set.open) maps.add(e.a).add(e.b);
	for (const ch of set.chains) for (const n of ch.nodes) maps.add(n.map);
	const frameOf = (map) => live[String(map)] || frames.frame(map);
	const zones = [...maps].sort((a, b) => a - b).map((map) => {
		const f = frameOf(map);
		return { map, name: frames.name(map) || String(map), c: f.c, top: f.top, bottom: f.bottom, left: f.left, right: f.right };
	});
	const wild = [];
	if (complete) {
		const covered = new Set(zones.map((z) => z.c));
		const ids = new Set([...frames.frames.keys(), ...Object.keys(live).map(Number)]);
		for (const id of ids) {
			const z = frames.zones[String(id)];
			if (z && z.type === 3 && covered.has(frameOf(id).c) && !maps.has(id)) wild.push(id);
		}
		wild.sort((a, b) => a - b);
	}
	return { zones, wild };
}

// The N.RegisterCrossings({...}) call for a set (lines, no trailing newline).
function crossingsLua(set, frames, { complete, live }) {
	const { zones, wild } = zoneTable(set, frames, { complete, live });
	const L = [];
	L.push('N.RegisterCrossings({');
	if (complete) L.push('\t-- the continents this set covers walk between zones only through it');
	L.push(`\tcomplete = ${complete ? 'true' : 'false'},`);
	L.push('\t-- uiMap = { name, continent, frame (Forever\'s where it redrew the map, else Era\'s) }');
	L.push('\tzones = {');
	for (const z of zones) L.push(`\t\t[${z.map}] = { name = ${luaStr(z.name)}, c = ${z.c}, top = ${num(z.top)}, bottom = ${num(z.bottom)}, left = ${num(z.left)}, right = ${num(z.right)} },`);
	L.push('\t},');
	if (wild.length) {
		L.push('\t-- other zones on these continents (no crossing data: walked as before)');
		L.push(`\twild = { ${wild.join(', ')} },`);
	}
	L.push('\t-- id, ends a and b (uiMap, continent, world yards, arrival radius), captions a->b and b->a, oneWay');
	L.push('\tcrossings = {');
	for (const e of set.crossings) {
		const parts = [`id = ${luaStr(e.id)}`, `a = ${endLua(e.a)}`, `b = ${endLua(e.b)}`];
		if (e.ab) parts.push(`ab = ${luaStr(e.ab)}`);
		if (e.ba) parts.push(`ba = ${luaStr(e.ba)}`);
		if (e.oneWay) parts.push('oneWay = true');
		L.push(`\t\t{ ${parts.join(', ')} },`);
	}
	L.push('\t},');
	if (set.open.length) {
		L.push('\t-- zone a, zone b, one way (1: a -> b only)');
		L.push('\topen = {');
		for (const e of set.open) L.push(`\t\t${e.a}, ${e.b}, ${e.oneWay ? 1 : 0},`);
		L.push('\t},');
	}
	if (set.chains.length) {
		L.push('\t-- nodes: uiMap, continent, world yards, radius, caption walking in, caption walking out');
		L.push('\tchains = {');
		for (const ch of set.chains) {
			L.push(`\t\t{ id = ${luaStr(ch.id)}, name = ${luaStr(ch.name)}, open = ${luaStr(ch.open)}, nodes = {`);
			for (const n of ch.nodes) {
				const parts = [`map = ${n.map}`, `c = ${n.c}`, `wx = ${num(n.wx)}`, `wy = ${num(n.wy)}`, `r = ${num(n.r)}`];
				if (n.caption) parts.push(`caption = ${luaStr(n.caption)}`);
				if (n.back) parts.push(`back = ${luaStr(n.back)}`);
				L.push(`\t\t\t{ ${parts.join(', ')} },`);
			}
			L.push('\t\t} },');
		}
		L.push('\t},');
	}
	L.push('})');
	return L;
}

const TRAVEL_ADDON = 'Polestar_Travel';

// The local data addon: { 'Polestar_Travel.toc': text, 'Crossings.lua': text }.
function emitTravelAddon(set, frames, live) {
	const toc = [
		'## Interface: 16001',
		'## Title: Polestar Travel (local)',
		'## Notes: Zone crossings for Polestar\'s travel planner, built from an optional local crossings file. Local use only.',
		'## Author: Polestar',
		`## Version: ${packageVersion()}`,
		'## Category: Quests',
		'## Dependencies: Polestar',
		'',
		'Crossings.lua',
		'',
	].join('\n');
	const counts = `${set.crossings.length} crossing(s), ${set.open.length} open-ground pair(s), ${set.chains.length} approach chain(s)`;
	const lua = [
		header('lua', 'travel build', 'the optional local crossings file (data/local/crossings.json)'),
		`-- ${counts}. Local use only: never committed or packaged.`,
		'',
		'local N = Polestar and Polestar.Nav',
		'if not (N and N.RegisterCrossings) then return end',
		'',
		...crossingsLua(set, frames, { complete: true, live }),
		'',
	].join('\n');
	return { [`${TRAVEL_ADDON}.toc`]: toc, 'Crossings.lua': lua };
}

// Per continent counts, for reports.
function crossingCounts(set) {
	const out = {};
	const bump = (c, k) => {
		out[c] = out[c] || { crossings: 0, open: 0, chains: 0, chainNodes: 0 };
		out[c][k] += 1;
	};
	for (const e of set.crossings) bump(e.a.c, 'crossings');
	for (const e of set.open) bump(e.c, 'open');
	for (const ch of set.chains) {
		bump(ch.c, 'chains');
		out[ch.c].chainNodes += ch.nodes.length;
	}
	return out;
}

module.exports = {
	LIMITS,
	TRAVEL_ADDON,
	validateCrossings,
	readCrossingsFile,
	recordedCrossings,
	recordedChain,
	crossingsLua,
	emitTravelAddon,
	crossingCounts,
};
