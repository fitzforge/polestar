'use strict';
// `nav city world-*`: the city gate's method over every zone: players' held-out recorded walks, sampled per zone and
// stratified, each map-matched on its own box of the grid (the trip's breadcrumbs plus PAD yd), and the router judged
// on them by the gate's rules (gate.js). PRIVATE inputs and outputs (<priv>/world/).
//
//   sampleWorld({ priv, frames, spawnz, zones, per, seed }) -> <priv>/world/candidates.json: per zone up to `per`
//     trips per stratum, held-out people only, round-robin over people. A trip: consecutive stops of one piece of
//     on-foot movement (an NPC window, a flight, a quest objective's tick, a gathered node, a dungeon's door), 50-1500
//     yd apart, purposeful (breadcrumbs' path at most 3x the straight line, no long wait). Strata, first that holds:
//       indoor    a breadcrumb the client called indoors (caves, mines, barrow dens, buildings, towers)
//       entrance  it ends at a dungeon or raid's door (the `enter` event)
//       town      both ends at NPCs with 4+ other NPC spawns within 50 yd (towns and camps)
//       open      the rest (split after matching: `cliff` when the matched walk rises or falls 25+ yd)
//   matchWorld({ priv, grid, frames, spawnz, log }) -> <priv>/world/trips.jsonl: each candidate matched on its box
//     (the real route, its floors) with the training people's movement through the box (up to DENSITY_PEOPLE people,
//     their breadcrumbs within NEAR yd of the trip's) as the box's walked surfaces (people per node, sparse).
//   worldAreas(priv, grid) -> iterator of { trip, area } (area as gate.js loadArea gives it: g, people, train, trips)

const fs = require('node:fs');
const path = require('node:path');
const { AreaGraph, CITIES, toWorld } = require('./graph');
const { spawnHeight, segmentsOf, makeMatcher, isTest, blankCut } = require('./match');

const STOPS = new Set(['progress', 'gather', 'loot', 'enter']);
const PAD = 100; // yd around a trip's breadcrumbs
const NEAR = 60; // yd: another person's breadcrumb counts for the box's density this close to the trip's
const DENSITY_PEOPLE = 20;
const MIN_STRAIGHT = 50;
const MAX_STRAIGHT = 1500;

function rng(seed) {
	let a = seed >>> 0;
	return () => {
		a = (a + 0x6d2b79f5) >>> 0;
		let t = a;
		t = Math.imul(t ^ (t >>> 15), t | 1);
		t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
		return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
	};
}

// The purposeful walks between consecutive stops of one piece of movement (seg): min-max yd apart (straight), the
// breadcrumbs' path at most 3x the straight line, no long wait, not from an NPC back to the same NPC.
function* stopWalks(seg, min, max) {
	let last = -1;
	for (let i = 0; i < seg.length; i++) {
		if (!seg[i].stop) continue;
		if (last >= 0) {
			const piece = seg.slice(last, i + 1);
			const A = piece[0];
			const B = piece[piece.length - 1];
			const straight = Math.hypot(A.wx - B.wx, A.wy - B.wy);
			let chords = 0;
			for (let q = 1; q < piece.length; q++) chords += Math.hypot(piece[q].wx - piece[q - 1].wx, piece[q].wy - piece[q - 1].wy);
			if (straight >= min && straight <= max && chords <= 3 * straight && B.t - A.t <= chords / 3 + 120 && !(A.npc && A.npc === B.npc)) yield { piece, A, B, straight };
		}
		last = i;
	}
}

// Up to `want` trips from lists (each person's trips, oldest first), one a person a round, people in a seeded order.
function roundRobin(lists, want, rand) {
	const order = lists.slice();
	for (let i = order.length - 1; i > 0; i--) {
		const j = Math.floor(rand() * (i + 1));
		[order[i], order[j]] = [order[j], order[i]];
	}
	const out = [];
	for (let r = 0; out.length < want; r++) {
		const round = order.filter((l) => l[r]).map((l) => l[r]);
		if (!round.length) break;
		out.push(...round.slice(0, want - out.length));
	}
	return out;
}

// The capitals are the city gate's; every other zone map (type 3) on a continent our grid has.
function worldZones(zones, frames) {
	return Object.entries(zones).filter(([id, z]) => z.type === 3 && !CITIES[id] && frames[id]).map(([id]) => Number(id)).sort((a, b) => a - b);
}

function readSessions(file) {
	if (!fs.existsSync(file)) return [];
	return fs.readFileSync(file, 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l));
}

function sampleWorld({ priv, frames, spawnz, zones, per = 6, seed = 1, log = () => {} }) {
	const rand = rng(seed);
	const out = { seed, per, zones: {}, trips: [] };
	const byTile = new Map(); // NPC spawns per 50 yd cell, for towns
	for (const [, list] of Object.entries(spawnz)) {
		for (const [c, x, y] of list) {
			const k = `${c}|${Math.floor(x / 50)}|${Math.floor(y / 50)}`;
			byTile.set(k, (byTile.get(k) || 0) + 1);
		}
	}
	const crowd = (c, x, y) => {
		let n = 0;
		for (let i = -1; i <= 1; i++) for (let j = -1; j <= 1; j++) n += byTile.get(`${c}|${Math.floor(x / 50) + i}|${Math.floor(y / 50) + j}`) || 0;
		return n;
	};
	for (const zone of zones) {
		const c = frames[String(zone)].c;
		const npcZ = spawnHeight(spawnz, c);
		const sessions = readSessions(path.join(priv, `${zone}.jsonl`));
		const strata = { indoor: new Map(), entrance: new Map(), town: new Map(), open: new Map() };
		for (const s of sessions) {
			if (!isTest(s.who)) continue;
			for (const seg of segmentsOf(s, zone, frames, npcZ, blankCut(), { stops: STOPS })) {
				for (const { piece, A, B, straight } of stopWalks(seg, MIN_STRAIGHT, MAX_STRAIGHT)) {
					if (piece.filter((x) => x.kind === 'pos').length < 2) continue;
					const stratum = piece.some((x) => x.flags !== null && x.flags & 4) ? 'indoor' : B.kind === 'enter' ? 'entrance' : A.npc && B.npc && crowd(c, A.wx, A.wy) >= 5 && crowd(c, B.wx, B.wy) >= 5 ? 'town' : 'open';
					const m = strata[stratum];
					if (!m.has(s.who)) m.set(s.who, []);
					m.get(s.who).push({ zone, c, who: s.who, fac: s.fac, stratum, straight, samples: piece });
				}
			}
		}
		const counts = {};
		for (const [name, m] of Object.entries(strata)) {
			const lists = [...m.values()].map((l) => l.sort((a, b) => a.samples[0].t - b.samples[0].t));
			const got = roundRobin(lists, name === 'open' ? 2 * per : per, rand);
			out.trips.push(...got);
			counts[name] = got.length;
		}
		out.zones[zone] = { sessions: sessions.length, ...counts };
		log(`world sample ${zone}: ${sessions.length} sessions; ${JSON.stringify(counts)}`);
	}
	out.trips.forEach((t, i) => (t.i = i));
	const dir = path.join(priv, 'world');
	fs.mkdirSync(dir, { recursive: true });
	fs.writeFileSync(path.join(dir, 'candidates.json'), JSON.stringify(out));
	return out;
}

const boxOf = (pts, c) => ({
	c,
	wxMin: Math.min(...pts.map((p) => p.wx)) - PAD, wxMax: Math.max(...pts.map((p) => p.wx)) + PAD,
	wyMin: Math.min(...pts.map((p) => p.wy)) - PAD, wyMax: Math.max(...pts.map((p) => p.wy)) + PAD,
});

// Distance from a point to the trip's breadcrumb polyline.
function nearTrip(samples) {
	return (x, y) => {
		let best = Infinity;
		for (let i = 1; i < samples.length; i++) {
			const a = samples[i - 1];
			const b = samples[i];
			const dx = b.wx - a.wx;
			const dy = b.wy - a.wy;
			const L2 = dx * dx + dy * dy;
			const t = L2 ? Math.max(0, Math.min(1, ((x - a.wx) * dx + (y - a.wy) * dy) / L2)) : 0;
			best = Math.min(best, Math.hypot(x - a.wx - t * dx, y - a.wy - t * dy));
		}
		return best;
	};
}

// Every session of maps (one uiMap, or a capital and the zone outside it), a session's rows on both merged in time.
function areaSessions(priv, maps) {
	const bySid = new Map();
	for (const m of maps) {
		for (const s of readSessions(path.join(priv, `${m}.jsonl`))) {
			const have = bySid.get(s.sid);
			if (have) have.ev = have.ev.concat(s.ev).sort((a, b) => a[0] - b[0]);
			else bySid.set(s.sid, s);
		}
	}
	return [...bySid.values()];
}

function matchWorld({ priv, grid, frames, spawnz, set = 'world', log = () => {} }) {
	const dir = path.join(priv, set);
	const cand = JSON.parse(fs.readFileSync(path.join(dir, 'candidates.json'), 'utf8'));
	const outFile = path.join(dir, 'trips.jsonl');
	const fd = fs.openSync(outFile, 'w');
	const byZone = new Map();
	for (const t of cand.trips) {
		const key = (t.maps || [t.zone]).join('+');
		if (!byZone.has(key)) byZone.set(key, []);
		byZone.get(key).push(t);
	}
	const stats = { trips: 0, matched: 0, failed: 0, strata: {} };
	const t0 = Date.now();
	for (const trips of byZone.values()) {
		const maps = trips[0].maps || [trips[0].zone];
		const zone = trips[0].zone;
		const sessions = areaSessions(priv, maps).filter((s) => !isTest(s.who));
		const c = frames[String(zone)].c;
		const npcZ = spawnHeight(spawnz, c);
		// the training people's pieces, once per area
		const pieces = [];
		const area = maps.length > 1 ? new Set(maps) : zone;
		for (const s of sessions) for (const seg of segmentsOf(s, area, frames, npcZ)) pieces.push({ who: s.who, seg });
		for (const t of trips) {
			stats.trips++;
			const g = new AreaGraph(boxOf(t.samples, c), { grid });
			const m = makeMatcher(g);
			const st = blankCut();
			st.matched = 0;
			st.jumps = 0;
			const seg = t.samples;
			const pcs = m.viterbi(seg, st);
			const whole = pcs.length === 1 && pcs[0].from === 0 && pcs[0].to === seg.length - 1 ? pcs[0] : null;
			if (!whole) {
				stats.failed++;
				continue;
			}
			const { full } = m.expand(seg, whole, st, null, 0, true);
			// density: up to DENSITY_PEOPLE training people's breadcrumbs near the trip
			const near = nearTrip(seg);
			const people = new Map();
			const seen = new Set();
			for (const { who, seg: s2 } of pieces) {
				if (seen.size >= DENSITY_PEOPLE && !seen.has(who)) continue;
				let run = [];
				const runs = [];
				for (const x of s2) {
					if (near(x.wx, x.wy) <= NEAR) run.push(x);
					else if (run.length) {
						runs.push(run);
						run = [];
					}
				}
				if (run.length) runs.push(run);
				for (const r of runs) {
					if (r.length < 2) continue;
					seen.add(who);
					for (const pc of m.viterbi(r, st)) {
						const ex = m.expand(r, pc, st, null, 0, false);
						for (const v of new Set(ex.full)) {
							if (!people.has(v)) people.set(v, new Set());
							people.get(v).add(who);
						}
					}
				}
			}
			const nz = (v) => +g.nz[v].toFixed(1);
			const zs = full.map((v) => g.nz[v]);
			const stratum = t.stratum === 'open' && Math.max(...zs) - Math.min(...zs) >= 25 ? 'cliff' : t.stratum;
			const A = seg[0];
			const B = seg[seg.length - 1];
			const rec = {
				i: t.i, zone, c, stratum, box: boxOf(t.samples, c), straight: t.straight, who: t.who, fac: t.fac, maps: t.maps, cross: t.cross, case: t.case,
				A: { wx: A.wx, wy: A.wy, z: nz(whole.nodes[0]), node: whole.nodes[0], kind: A.kind, npc: A.npc },
				B: { wx: B.wx, wy: B.wy, z: nz(whole.nodes[whole.nodes.length - 1]), node: whole.nodes[whole.nodes.length - 1], kind: B.kind, npc: B.npc },
				path: full, samples: seg.map((x) => [+x.wx.toFixed(1), +x.wy.toFixed(1)]), densityPeople: seen.size,
				density: [...people].map(([v, w]) => [v, w.size]),
			};
			fs.writeSync(fd, JSON.stringify(rec) + '\n');
			stats.matched++;
			stats.strata[stratum] = (stats.strata[stratum] || 0) + 1;
			if (stats.trips % 25 === 0) log(`${set} match: ${stats.trips}/${cand.trips.length} (${stats.matched} matched) ${((Date.now() - t0) / 1000).toFixed(0)} s`);
		}
	}
	fs.closeSync(fd);
	return stats;
}

// Each matched trip of a set (world, boundary) with its area (a graph of its box and the box's walked surfaces), for
// gate.js's judge.
function* worldAreas(priv, grid, set = 'world') {
	for (const trip of readWorldTrips(priv, set)) {
		const g = new AreaGraph(trip.box, { grid });
		const people = new Uint16Array(g.n);
		for (const [v, p] of trip.density) people[v] = p;
		yield { trip, area: { g, people, train: people, trips: [trip], gaps: [] } };
	}
}

function readWorldTrips(priv, set = 'world') {
	const file = path.join(priv, set, 'trips.jsonl');
	return fs.readFileSync(file, 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l));
}

// The capitals' entrances: each capital with the zone outside its gate. A walk that crosses the client's map switch
// (zone map <-> capital map) in either direction is a boundary trip: the floor and the route must carry across it.
const ENTRANCES = { 1455: 1426, 1453: 1429, 1454: 1411, 1458: 1420, 1456: 1412, 1457: 1438 };

// <priv>/boundary/candidates.json: per capital up to `per` held-out walks between stops that cross its entrance (stops
// as the world's; up to 2500 yd apart: a walk in from the zone's road), round-robin over people.
function sampleBoundary({ priv, frames, spawnz, per = 25, seed = 1, log = () => {} }) {
	const rand = rng(seed);
	const out = { seed, per, cities: {}, trips: [] };
	for (const [city, zone] of Object.entries(ENTRANCES).map(([a, b]) => [Number(a), b])) {
		const c = frames[String(city)].c;
		const npcZ = spawnHeight(spawnz, c);
		const maps = [city, zone];
		const byWho = new Map();
		for (const s of areaSessions(priv, maps)) {
			if (!isTest(s.who)) continue;
			for (const seg of segmentsOf(s, new Set(maps), frames, npcZ, blankCut(), { stops: STOPS })) {
				for (const { piece, A, B, straight } of stopWalks(seg, MIN_STRAIGHT, 2500)) {
					const onMaps = new Set(piece.map((x) => x.m));
					if (!onMaps.has(city) || !onMaps.has(zone) || piece.length - 2 < 2) continue;
					if (!byWho.has(s.who)) byWho.set(s.who, []);
					byWho.get(s.who).push({ zone: city, maps, c, who: s.who, fac: s.fac, stratum: 'boundary', cross: A.m === city ? 'out' : B.m === city ? 'in' : 'through', straight, samples: piece });
				}
			}
		}
		const got = roundRobin([...byWho.values()], per, rand);
		out.trips.push(...got);
		out.cities[city] = { people: byWho.size, trips: got.length };
		log(`boundary sample ${city} (with ${zone}): ${byWho.size} held-out people cross it; ${got.length} trips`);
	}
	out.trips.forEach((t, i) => (t.i = i));
	const dir = path.join(priv, 'boundary');
	fs.mkdirSync(dir, { recursive: true });
	fs.writeFileSync(path.join(dir, 'candidates.json'), JSON.stringify(out));
	return out;
}

// tools/lib/nav/city/reported.json's cases (players' reports): each case's zone's held-out walks between stops (20-1500
// yd apart) that pass within r yd of its place (with end: finish there), up to `per` a case, round-robin over people
// -> <priv>/reported/candidates.json (stratum 'reported', case: its id).
function sampleReported({ priv, frames, spawnz, per = 12, seed = 1, log = () => {} }) {
	const rand = rng(seed);
	const { cases } = JSON.parse(fs.readFileSync(path.join(__dirname, 'reported.json'), 'utf8'));
	const out = { seed, per, cases: {}, trips: [] };
	for (const k of cases) {
		const npcZ = spawnHeight(spawnz, k.c);
		const byWho = new Map();
		for (const s of readSessions(path.join(priv, `${k.zone}.jsonl`))) {
			if (!isTest(s.who)) continue;
			for (const seg of segmentsOf(s, k.zone, frames, npcZ, blankCut(), { stops: STOPS })) {
				for (const { piece, B, straight } of stopWalks(seg, 20, MAX_STRAIGHT)) {
					const hit = k.end ? Math.hypot(B.wx - k.at[0], B.wy - k.at[1]) <= k.r : nearTrip(piece)(k.at[0], k.at[1]) <= k.r;
					if (!hit || piece.length < 3) continue;
					if (!byWho.has(s.who)) byWho.set(s.who, []);
					byWho.get(s.who).push({ zone: k.zone, c: k.c, who: s.who, fac: s.fac, stratum: 'reported', case: k.id, straight, samples: piece });
				}
			}
		}
		const got = roundRobin([...byWho.values()], per, rand);
		out.trips.push(...got);
		out.cases[k.id] = { issue: k.issue, people: byWho.size, trips: got.length };
		log(`reported sample ${k.id} (${k.issue}): ${byWho.size} held-out people walked it; ${got.length} trips`);
	}
	out.trips.forEach((t, i) => (t.i = i));
	const dir = path.join(priv, 'reported');
	fs.mkdirSync(dir, { recursive: true });
	fs.writeFileSync(path.join(dir, 'candidates.json'), JSON.stringify(out));
	return out;
}

module.exports = { sampleWorld, sampleBoundary, sampleReported, matchWorld, worldAreas, readWorldTrips, worldZones, ENTRANCES, STOPS };
