'use strict';
// `nav city gate`: a Polestar_Nav folder's walks in the capitals, scored on players' held-out walks (the gate every city
// pathing change runs). Private inputs (never committed): <priv>/<uiMap>/ from `nav city match` (density.bin,
// gaps.json, graph.json) and gate-trips.json (the frozen held-out trips: `nav city freeze`).
//
// Arms (each a way the addon asks the router; the gate counts GAME and WALK, the rest are references):
//   GAME  the player's floor known (the matched floor at the start), the goal at its NPC's spawn height; policy
//         `legacy` (Walk.lua before A2: a failed search, or one ending 30+ yd off the goal's height, asked again without
//         it) or `a2` (inside a capital never without it: to.reach = 10, the goal's level within 10 yd)
//   WALK  the floor unknown: the start from the NPC just talked to (spawn height) or Path.TrailFloor(reach 4), the goal
//         at its NPC's height or Path.TrailFloor; the same retry policy
//   E0    no height at either end;  E2  both ends at the true (matched) floors;  G1 --ground <dir>'s folder, true floors
//   P3    desire paths on the judge's grid (trails x1, the rest x3, learned trail edges): what the trail layer can reach
// A walk fails (headline) when it is not found, is a detour (1.3x the real route and 40+ yd longer), runs 10+ yd under
// the city (terrain nobody walks under a walked model surface 3-60 yd above: CityLifts' rule, tents and canopies are
// not "under") or on a floor nobody walks there, or ends 10+ yd off the player's floor. Walls and void (judged by the
// 2.08 yd grid, false positives both ways) are reported, not counted.
//
//   gate({ priv, nav, ground, grid, frames, spawnz, npcs, maps, arms, policy, log }) -> report
//   compareReports(base, cand) -> { pass, rows, newFails, fixed }

const fs = require('node:fs');
const path = require('node:path');
const { AreaGraph, CITIES, FLAG, CELL, toMap } = require('./graph');
const { spawnHeight } = require('./match');
const run = require('../eval/run');

const STEP = 2; // yd: line samples
const DZ = 6; // yd: a line point lies on a surface within this height (the two maps' heights differ up to ~5 yd)
const CLIMB = 2.5; // yd: a line sample between two points stays on the previous sample's surface this near (a 2 yd step up a 50 deg slope)
const OFF_CHORD = 3; // yd: a line sample is judged on the surface it follows where the chord has left that surface by more than this
const Z_OFF = 30; // yd, Nav/Walk.lua: a path ending this far off the goal's height missed its floor
const SETTLE = 5; // yd, Nav/Walk.lua's city.SETTLE: a followed floor's search starts on the trail floor this near it
const SPAWN_R = 15; // yd, Lookup.SpawnZ: an NPC goal's height is its nearest spawn's this close
const COUNTED = ['GAME', 'WALK'];

// The folder the gate runs: nav, with its Trails/Trails.lua replaced by <priv>/Trails-train.lua when that exists (the
// trail layer of the training people only: the shipped one counts the held-out people too, and would let the WALK arm
// see the walks it is judged on). A temporary folder of links beside links to nav's sibling map parts.
function gateNav(nav, priv) {
	const train = path.join(priv, 'Trails-train.lua');
	if (!fs.existsSync(train) || !fs.existsSync(path.join(nav, 'Trails'))) return { dir: nav, done: () => {} };
	const root = fs.mkdtempSync(path.join(require('node:os').tmpdir(), 'polestar-citygate-'));
	const dir = path.join(root, path.basename(nav));
	fs.mkdirSync(path.join(dir, 'Trails'), { recursive: true });
	for (const e of fs.readdirSync(nav)) if (e !== 'Trails') fs.symlinkSync(path.join(nav, e), path.join(dir, e));
	fs.symlinkSync(train, path.join(dir, 'Trails', 'Trails.lua'));
	for (const part of ['Polestar_Nav_EK', 'Polestar_Nav_Kalimdor']) {
		const p = path.join(path.dirname(nav), part);
		if (fs.existsSync(p)) fs.symlinkSync(p, path.join(root, part));
	}
	return { dir, done: () => fs.rmSync(root, { recursive: true, force: true }) };
}
function loadArea(priv, map, grid, frames) {
	const dir = path.join(priv, String(map));
	const g = AreaGraph.forMap(map, { grid, frames });
	const meta = JSON.parse(fs.readFileSync(path.join(dir, 'graph.json'), 'utf8'));
	if (meta.n !== g.n || meta.gi0 !== g.gi0 || meta.gj0 !== g.gj0) throw new Error(`${map}: ${dir} was matched on another grid (graph.json) than ${grid}`);
	const dens = fs.readFileSync(path.join(dir, 'density.bin'));
	const people = new Uint16Array(g.n);
	const train = new Uint16Array(g.n);
	for (let v = 0; v < g.n; v++) {
		people[v] = dens.readUInt16LE(12 * v);
		train[v] = dens.readUInt16LE(12 * v + 2);
	}
	const trips = JSON.parse(fs.readFileSync(path.join(dir, 'gate-trips.json'), 'utf8'));
	const gaps = JSON.parse(fs.readFileSync(path.join(dir, 'gaps.json'), 'utf8'));
	return { g, people, train, trips, gaps };
}

// A flight's landing spot: the height of the flight master at the taxi node within 40 yd (TaxiNodes' height stands in
// for it in game), or null. taxi: travel.json's nodes ({ c, wx, wy, npc }); npcZ: spawnHeight(spawnz, c).
function landZ(taxi, npcZ, c, wx, wy) {
	let best = null;
	for (const n of taxi) {
		const d = n.c === c ? Math.hypot(n.wx - wx, n.wy - wy) : Infinity;
		if (d <= 40 && (!best || d < best.d)) best = { d, n };
	}
	return best ? npcZ(best.n.npc, best.n.wx, best.n.wy) : null;
}

// A trip's ends on the floor the game puts them on, where the matcher could only guess: a landing on its flight
// master's floor (the recording has only the taxi node's spot, and the matcher may put it on the ground under the
// tower, Orgrimmar's and Thunder Bluff's, where players then drop to), and an NPC's end the match had no spawn height
// for (Forever's own NPCs, whose heights came with the Forever TDB) on that NPC's. Each moves to the grid level
// nearest that height (within 8 yd) at its spot that players walk (walked(node): 3+ training people), else stays;
// `was` keeps the matched height.
function anchorEnds(g, t, taxi, npcZ, walked = () => true) {
	const fix = (e) => {
		const z = e.kind === 'land' ? landZ(taxi, npcZ, t.c, e.wx, e.wy) : !e.anchored && e.npc ? npcZ(e.npc, e.wx, e.wy) : null;
		const ci = z === null ? -1 : g.colIndex(e.wx, e.wy);
		if (ci < 0) return e;
		let node = -1;
		for (const v of g.colNodes(ci)) if (Math.abs(g.nz[v] - z) <= 8 && walked(v) && (node < 0 || Math.abs(g.nz[v] - z) < Math.abs(g.nz[node] - z))) node = v;
		return node < 0 || node === e.node ? e : { ...e, z: g.nz[node], node, was: e.z };
	};
	const A = fix(t.A);
	const B = fix(t.B);
	return A === t.A && B === t.B ? t : { ...t, A, B };
}

// Line scoring on the judge's grid.
function judge({ g, people, train }) {
	function nearSet(wx, wy, z) {
		const ci = g.colIndex(wx, wy);
		if (ci < 0) return { list: [], ci };
		const li = ci % g.W;
		const lj = (ci - li) / g.W;
		const list = [];
		for (let dj = -1; dj <= 1; dj++) {
			for (let di = -1; di <= 1; di++) {
				const a = li + di;
				const b = lj + dj;
				if (a < 0 || b < 0 || a >= g.W || b >= g.H) continue;
				for (const v of g.colNodes(b * g.W + a)) {
					const dz = Math.abs(g.nz[v] - z);
					if (dz <= DZ) list.push([dz + Math.hypot(di, dj) * CELL, v]);
				}
			}
		}
		list.sort((p, q) => p[0] - q[0]);
		return { list: list.map((p) => p[1]), ci };
	}
	function colStats(ci, r) {
		const li = ci % g.W;
		const lj = (ci - li) / g.W;
		const tz = [];
		let any = false;
		for (let dj = -r; dj <= r; dj++) {
			for (let di = -r; di <= r; di++) {
				const a = li + di;
				const b = lj + dj;
				if (a < 0 || b < 0 || a >= g.W || b >= g.H) continue;
				for (const v of g.colNodes(b * g.W + a)) {
					if (people[v] >= 1) any = true;
					if (people[v] >= 3) tz.push(g.nz[v]);
				}
			}
		}
		return { tz, any };
	}
	// under the city: terrain nobody walks (train < 3) under a walked (train >= 3) model surface 3-60 yd above
	function under(v) {
		if (!(g.nflags[v] & FLAG.TERRAIN) || train[v] >= 3) return false;
		for (const u of g.colNodes(g.ncol[v])) if (u !== v && (g.nflags[u] & (FLAG.WMO | FLAG.M2)) && train[u] >= 3 && g.nz[u] > g.nz[v] + 3 && g.nz[u] < g.nz[v] + 60) return true;
		return false;
	}
	// The heights a straight piece from a to b (n samples) walks on, followed from one end: each sample the surface a
	// step on from the previous one's (within CLIMB) nearest the chord's height; null where none is (a step, a gap).
	function follow(a, b, n, from) {
		const zs = new Array(n + 1).fill(null);
		const [k0, k1, dk] = from === 'a' ? [0, n, 1] : [n, 0, -1];
		let h = from === 'a' ? a[2] : b[2];
		zs[k0] = h;
		for (let k = k0 + dk; h !== null && k !== k1 + dk; k += dk) {
			const t = k / n;
			const chord = a[2] + (b[2] - a[2]) * t;
			const ci = g.colIndex(a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t);
			let best = null;
			if (ci >= 0) for (const v of g.colNodes(ci)) if (Math.abs(g.nz[v] - h) <= CLIMB && (best === null || Math.abs(g.nz[v] - chord) < Math.abs(best - chord))) best = g.nz[v];
			zs[k] = h = best;
		}
		return zs;
	}
	function measure(pts) {
		const m = { yards: 0, void: 0, crossings: 0, under: 0, wrongFloor: 0, offTrail: 0, at: {} };
		const note = (k, x, y, z) => {
			if (!m.at[k]) m.at[k] = [+x.toFixed(1), +y.toFixed(1), +z.toFixed(1)];
		};
		let prev = null;
		let prevPt = null;
		for (let i = 1; i < pts.length; i++) {
			const [ax, ay, az] = pts[i - 1];
			const [bx, by, bz] = pts[i];
			const L = Math.hypot(bx - ax, by - ay);
			m.yards += L;
			const n = Math.max(1, Math.ceil(L / STEP));
			// between two points the line follows the ground it walks on, as a player walking the drawn line does: a long
			// straight line over a slope that bends is not judged by its chord, which can run 15+ yd over or under the
			// ground. Where the surface followed from each end (follow) is the same one and the chord has left it by more
			// than OFF_CHORD, a sample is judged at that surface's height; elsewhere at the chord's.
			const fa = az === null || bz === null || n < 2 ? null : follow(pts[i - 1], pts[i], n, 'a');
			const fb = fa && follow(pts[i - 1], pts[i], n, 'b');
			for (let k = i === 1 ? 0 : 1; k <= n; k++) {
				const t = k / n;
				const x = ax + (bx - ax) * t;
				const y = ay + (by - ay) * t;
				if (az === null || bz === null) continue;
				const chord = az + (bz - az) * t;
				const on = fa && fa[k] !== null && fb[k] !== null && Math.abs(fa[k] - fb[k]) <= CLIMB ? fa[k] : null;
				const z = on !== null && Math.abs(on - chord) > OFF_CHORD ? on : chord;
				const seg = L / n;
				const { list, ci } = nearSet(x, y, z);
				if (ci < 0) continue;
				const cs = colStats(ci, 1);
				if (!cs.any && !colStats(ci, 3).any) m.offTrail += seg;
				if (!list.length) {
					m.void += seg;
					note('void', x, y, z);
					prev = null;
					continue;
				}
				const v = list[0];
				if (under(v) && !list.some((u) => people[u] >= 3)) {
					m.under += seg;
					note('under', x, y, z);
				}
				// on a floor nobody walks: people walk these columns (3+ on a level) but no walked surface lies within DZ of
				// the line's height (CityJoins: the shipped maps' heights sit between two floors of our grid, so the
				// nearest surface alone misjudges a line over the walked corridor)
				if (cs.tz.length && !list.some((u) => people[u] >= 3)) {
					m.wrongFloor += seg;
					note('wrongFloor', x, y, z);
				}
				if (prev !== null && !prev.some((p) => list.includes(p))) {
					const d0 = Math.hypot(x - prevPt[0], y - prevPt[1]);
					g.search(prev.map((p) => [p, 0]), list, { bound: 3 * d0 + 10 });
					if (!list.some((u) => g.d(u) <= 3 * d0 + 10)) {
						m.crossings++;
						note('wall', x, y, z);
					}
				}
				prev = list;
				prevPt = [x, y];
			}
		}
		return m;
	}
	return { measure };
}

// String-pulled node path (a grid path's 8-way steps overstate its length up to 8%).
function tautPts(g, p) {
	const straight = (a, b) => {
		const [ax, ay] = g.xy(a);
		const [bx, by] = g.xy(b);
		const n = Math.max(1, Math.ceil(Math.hypot(bx - ax, by - ay) / (CELL / 3)));
		let cur = a;
		for (let k = 1; k <= n; k++) {
			const t = k / n;
			const ci = g.colIndex(ax + (bx - ax) * t, ay + (by - ay) * t);
			if (ci === g.ncol[cur]) continue;
			const zt = g.nz[a] + (g.nz[b] - g.nz[a]) * t;
			let next = -1;
			for (let q = g.adjStart[cur]; q < g.adjStart[cur + 1]; q++) {
				const u = g.adj[q];
				if (g.acls[q] === 4 || g.ncol[u] !== ci) continue;
				if (Math.abs(g.nz[u] - zt) <= 2.5 + Math.abs(g.nz[b] - g.nz[a]) * 0.1) {
					next = u;
					break;
				}
			}
			if (next < 0) return false;
			cur = next;
		}
		return cur === b;
	};
	const keep = [p[0]];
	let i = 0;
	while (i < p.length - 1) {
		let j = Math.min(p.length - 1, i + 80);
		while (j > i + 1 && !straight(p[i], p[j])) j--;
		keep.push(p[j]);
		i = j;
	}
	return keep.map((v) => [...g.xy(v), g.nz[v]]);
}

// Desire paths on the judge's grid: trail surfaces (3+ training people) cheap, the rest x3, plus the trail edges learned
// from grid holes 2+ training people stepped through. cost: 'x3' (P3: a trail step at its length), 'sqrt' (P4: Redfern
// 2011's length / sqrt(people), as 3 people = its length, floored at 0.4), 'classes' (P5: the shipped weight classes,
// 3-9 people x1, 10-49 x0.7, 50+ x0.5).
const TRAIL_COST = {
	x3: (p) => 1,
	sqrt: (p) => Math.max(0.4, Math.sqrt(3 / p)),
	classes: (p) => (p >= 50 ? 0.5 : p >= 10 ? 0.7 : 1),
};
function desire({ g, train, gaps }, cost = 'x3') {
	const mult = new Float32Array(g.n);
	for (let v = 0; v < g.n; v++) mult[v] = train[v] >= 3 ? TRAIL_COST[cost](train[v]) : 3;
	const at = (wx, wy, z) => {
		const vs = g.levels(wx, wy, 1).filter((v) => Math.abs(g.nz[v] - z) <= 1);
		return vs.length ? vs[0] : -1;
	};
	const groups = new Map();
	for (const x of gaps) {
		if (x.test) continue;
		const a = at(x.a[0], x.a[1], x.za);
		const b = at(x.b[0], x.b[1], x.zb);
		if (a < 0 || b < 0 || a === b) continue;
		const k = `${Math.round((x.a[0] + x.b[0]) / 20)},${Math.round((x.a[1] + x.b[1]) / 20)},${Math.round((g.nz[a] + g.nz[b]) / 8)}`;
		if (!groups.has(k)) groups.set(k, { who: new Set(), steps: [] });
		groups.get(k).who.add(x.who);
		groups.get(k).steps.push([a, b, x.chord]);
	}
	const extra = new Map();
	for (const { who, steps } of groups.values()) {
		if (who.size < 2) continue;
		for (const [a, b, len] of steps) {
			for (const [u, v] of [[a, b], [b, a]]) {
				if (!extra.has(u)) extra.set(u, []);
				extra.get(u).push([v, len]);
			}
		}
	}
	const floorAt = (wx, wy) => {
		const cs = g.levels(wx, wy, 2);
		if (!cs.length) return -1;
		const ci = g.colIndex(wx, wy);
		const li = ci % g.W;
		const lj = (ci - li) / g.W;
		let ref = -1;
		let bs = 0;
		for (let dj = -2; dj <= 2; dj++) {
			for (let di = -2; di <= 2; di++) {
				const a = li + di;
				const b = lj + dj;
				if (a < 0 || b < 0 || a >= g.W || b >= g.H) continue;
				for (const v of g.colNodes(b * g.W + a)) {
					if (train[v] > bs) {
						bs = train[v];
						ref = v;
					}
				}
			}
		}
		if (bs >= 3) return ref;
		if (ref < 0) {
			const wmo = cs.filter((v) => g.nflags[v] & (FLAG.WMO | FLAG.M2));
			return (wmo.length ? wmo : cs).reduce((x, y) => (g.nz[y] > g.nz[x] ? y : x));
		}
		return cs.reduce((x, y) => (Math.abs(g.nz[y] - g.nz[ref]) < Math.abs(g.nz[x] - g.nz[ref]) ? y : x));
	};
	return (t) => {
		const a = floorAt(t.A.wx, t.A.wy);
		const b = floorAt(t.B.wx, t.B.wy);
		if (a < 0 || b < 0) return { ok: false, reason: 'no surface' };
		g.search([[a, 0]], [b], { mult, hmin: Math.min(1, TRAIL_COST[cost](1e9)), goal: g.local(t.B.wx, t.B.wy), extra });
		const p = g.pathTo(b);
		if (!p) return { ok: false, reason: 'no path' };
		return { ok: true, pts: tautPts(g, p) };
	};
}

// The judge's desire-path arms among arms: P3 x3, P4 length / sqrt(people), P5 weight classes.
const PROTO = { P3: 'x3', P4: 'sqrt', P5: 'classes' };
function protosFor(area, arms) {
	return Object.fromEntries(arms.filter((a) => PROTO[a]).map((a) => [a, desire(area, PROTO[a])]));
}

const DET = (x, real) => x.yards / real > 1.3 && x.yards - real > 40;
const endOff = (x, t) => (x.startZ !== null && Math.abs(x.startZ - t.A.z) > 10) || (x.endZ !== null && Math.abs(x.endZ - t.B.z) > 10);
function failOf(x, t) {
	if (!x || !x.ok) return 'no walk';
	if (DET(x, t.real)) return 'detour';
	if (x.under >= 10) return 'under the city';
	if (x.wrongFloor >= 10) return 'unwalked floor';
	if (endOff(x, t)) return 'end off the floor';
	return null;
}

// The router's answers for trips ({ i, c, side, A, B }) under each arm but the desire paths: { arm: [answer per trip] }.
// dirs: { nav (the gate's folder), ground (G1's), spf (a Shortest Path Forever checkout: the SPF arm, true floors) }.
// taxi: travel.json's flight master nodes ({ c, wx, wy, npc }): a landing's height is its flight master's spawn height.
async function runArms({ trips, arms, dirs, spawnz, policy, taxi = [] }) {
	const navRun = (dir, queries) => (queries.length ? run.runQueries({ navDir: dir, queries }).results : []);
	const route = (t, id, from, to, extra = {}) => ({ type: 'route', id, map: t.c, from, to, profile: t.side || null, style: 'balanced', level: null, danger: null, ...extra });
	const A = (t, z) => [t.A.wx, t.A.wy, z === undefined ? null : z];
	const B = (t, z) => [t.B.wx, t.B.wy, z === undefined ? null : z];
	const npcZs = new Map();
	const npcZ = (t, e) => {
		if (!npcZs.has(t.c)) npcZs.set(t.c, spawnHeight(spawnz, t.c, SPAWN_R));
		return npcZs.get(t.c)(e.npc, e.wx, e.wy);
	};
	// what Walk.lua knows of a stop's height (CityFloor's NpcFloor): the NPC whose window was just open, from its spawns
	// within 10 yd of the player, the nearest one's height unless they span more than 10 yd of height; or at a landing
	// its flight master's (TaxiNodes' height stands in for it in game)
	const npcFloor = (t, e) => {
		const s = e.npc && spawnz[String(e.npc)];
		if (!s) return null;
		let best = null;
		let lo = Infinity;
		let hi = -Infinity;
		for (const [sc, x, y, z] of s) {
			const d = sc === t.c ? Math.hypot(x - e.wx, y - e.wy) : Infinity;
			if (d > 10) continue;
			lo = Math.min(lo, z);
			hi = Math.max(hi, z);
			if (!best || d < best.d) best = { d, z };
		}
		return best && hi - lo <= 10 ? best.z : null;
	};
	const hint = (t, e) => {
		if (e.kind !== 'land') return npcFloor(t, e);
		if (!npcZs.has(t.c)) npcZs.set(t.c, spawnHeight(spawnz, t.c, SPAWN_R));
		return landZ(taxi, npcZs.get(t.c), t.c, e.wx, e.wy);
	};
	// --policy a2 is Walk.lua's floor rules (#2911 in the capitals, WorldFloor's outside them). A goal with a height,
	// anywhere: the router's reach (10 yd on its level), and a walk that ends off its floor kept; in a capital (Walk's
	// inCity) never asked again without the height, elsewhere asked once more without it only when no walk is found at
	// all (the maps miss the floor's join: a walk off its floor beats none). In a capital only (the trail layer's): a
	// goal without a height on the trail floor (city.GoalZ); a start's followed floor settled on the trail floor
	// (city.Settle) and WALK's start retries. A trip's cityA / cityB (false: that end lies outside the capitals;
	// world.js' world, boundary and reported trips) say where; unset, in one.
	const a2 = policy === 'a2';
	const cityA = (t) => a2 && t.cityA !== false;
	const cityB = (t) => a2 && t.cityB !== false;
	// WALK (CityFloor's rules): with a hint, the trail floor within 4 yd near it when that lies within 4 yd of the hint,
	// else the hint; without one, the trail floor anywhere within 4 yd; the goal at its NPC's height, else the trail floor
	// (a GAME goal in a capital too, under a2)
	const goalTrail = (t, arm) => arm === 'WALK' || (arm === 'GAME' && cityB(t));
	// GAME's start in a capital under a2 (a followed floor) settles on the trail floor within SETTLE yd of it
	const settle = (t, arm) => arm === 'GAME' && cityA(t);
	let tf = new Map();
	if (arms.includes('WALK') || (arms.includes('GAME') && a2)) {
		const q = [];
		for (const t of trips) {
			q.push({ type: 'trailfloor', id: `a${t.i}`, map: t.c, at: [t.A.wx, t.A.wy], reach: 4, near: hint(t, t.A) });
			q.push({ type: 'trailfloor', id: `b${t.i}`, map: t.c, at: [t.B.wx, t.B.wy], reach: 4, near: null });
			if (cityA(t)) q.push({ type: 'trailfloor', id: `s${t.i}`, map: t.c, at: [t.A.wx, t.A.wy], reach: 4, near: t.A.z });
		}
		tf = new Map(navRun(dirs.nav, q).map((r) => [r.id, r.z]));
	}
	const startOf = (t, arm) => {
		if (settle(t, arm)) {
			const z = tf.get(`s${t.i}`);
			return z !== null && z !== undefined && Math.abs(z - t.A.z) <= SETTLE ? z : t.A.z;
		}
		if (arm === 'GAME' || arm === 'E2' || arm === 'G1' || arm === 'SPF') return t.A.z;
		if (arm === 'E0') return null;
		const z = tf.get(`a${t.i}`);
		const h = hint(t, t.A);
		const has = z !== null && z !== undefined;
		if (h === null || h === undefined) return has ? z : null;
		return has && Math.abs(z - h) <= 4 ? z : h;
	};
	const goalOf = (t, arm) => {
		if (arm === 'E2' || arm === 'G1' || arm === 'SPF') return t.B.z;
		if (arm === 'E0') return null;
		const nz = npcZ(t, t.B);
		if (nz !== null) return nz;
		return goalTrail(t, arm) ? tf.get(`b${t.i}`) : null;
	};
	const res = {};
	for (const arm of arms) {
		if (PROTO[arm]) continue;
		const queries = trips.map((t) => route(t, `${arm}|${t.i}`, A(t, startOf(t, arm)), B(t, goalOf(t, arm)), (arm === 'GAME' || arm === 'WALK') && a2 ? { reach: 10 } : {}));
		if (arm === 'SPF') {
			if (!dirs.spf) continue;
			const { harness } = require('../eval/broad');
			res.SPF = (await harness({ navDir: dirs.spf, queries, lua: run.findInterpreter(), tag: 'citygate', spf: true })).results;
			continue;
		}
		const dir = arm === 'G1' ? dirs.ground : dirs.nav;
		if (!dir) continue;
		const first = navRun(dir, queries);
		if (arm === 'GAME' || arm === 'WALK') {
			const again = [];
			first.forEach((r, k) => {
				if (cityB(trips[k])) return;
				const gz = goalOf(trips[k], arm);
				if (gz === null || gz === undefined) return;
				const off = r.ok && r.pts.length && Math.abs(r.pts[r.pts.length - 1][2] - gz) > Z_OFF;
				if (!r.ok || (off && !a2)) again.push(k);
			});
			const second = navRun(dir, again.map((k) => route(trips[k], `${arm}|${trips[k].i}|retry`, A(trips[k], startOf(trips[k], arm)), B(trips[k], null))));
			again.forEach((k, j) => (first[k] = { ...second[j], retried: true }));
		}
		// a2 (CityFloor's Walk.lua): a WALK whose guessed start height can't reach the goal is asked again starting on
		// any surface within 10 yd of that height (from.floors), then with no start height
		if (arm === 'WALK' && a2) {
			for (const step of ['floors', 'none']) {
				const again = [];
				first.forEach((r, k) => {
					const sz = startOf(trips[k], arm);
					if (!r.ok && cityA(trips[k]) && sz !== null && sz !== undefined) again.push(k);
				});
				const ask = (t) => route(t, `${arm}|${t.i}|${step}`, A(t, null), B(t, goalOf(t, arm)), step === 'floors' ? { reach: 10, floors: [startOf(t, arm)] } : { reach: 10 });
				const second = navRun(dir, again.map((k) => ask(trips[k])));
				again.forEach((k, j) => {
					if (second[j].ok || step === 'none') first[k] = { ...second[j], retried: step };
				});
			}
		}
		res[arm] = first;
	}
	return res;
}

async function gate({ priv, nav, ground = null, spf = null, grid, frames, spawnz, taxi = [], npcs = {}, maps = Object.keys(CITIES).map(Number), arms = ['GAME', 'WALK', 'E0', 'E2', 'P3'], policy = 'legacy', log = () => {} }) {
	const report = { nav: path.resolve(nav), policy, arms, maps: {} };
	const gn = gateNav(path.resolve(nav), priv);
	report.trails = gn.dir !== path.resolve(nav) ? 'training people only (<priv>/Trails-train.lua)' : "the folder's own";
	try {
		for (const map of maps) {
			const city = CITIES[map];
			const t0 = Date.now();
			const area = loadArea(priv, map, grid, frames);
			const npcZc = spawnHeight(spawnz, city.c, SPAWN_R);
			const trips = area.trips.map((t) => anchorEnds(area.g, { ...t, c: city.c, side: city.side }, taxi, npcZc, (v) => area.train[v] >= 3));
			const res = await runArms({ trips, arms, dirs: { nav: gn.dir, ground, spf }, spawnz, policy, taxi });
			const rows = scoreRows(area, trips, res, protosFor(area, arms));
			const summary = summarize(rows, map, frames, npcs);
			report.maps[map] = { name: city.name, trips: rows.length, summary, rows, seconds: Math.round((Date.now() - t0) / 1000) };
			log(`${city.name}: ${Object.entries(summary).map(([a, s]) => `${a} ${s.fails}/${rows.length}`).join(', ')} (${report.maps[map].seconds} s)`);
		}
	} finally {
		gn.done();
	}
	return report;
}

// The world gate: every matched world trip (world.js), the arms run once over all of them, each trip judged on its box;
// report.maps holds one entry per stratum (indoor, entrance, town, cliff, open), report.zones the failures per zone.
// set: 'world' (the zones' strata) or 'boundary' (walks across a capital's entrance: one row per capital).
async function gateWorld({ priv, nav, ground = null, spf = null, grid, frames, spawnz, taxi = [], npcs = {}, arms = ['GAME', 'E0', 'E2', 'SPF'], policy = 'legacy', strata = null, set = 'world', log = () => {} }) {
	const { readWorldTrips, worldAreas } = require('./world');
	const report = { nav: path.resolve(nav), policy, arms, world: set, maps: {}, zones: {} };
	const t0 = Date.now();
	const all = readWorldTrips(priv, set).filter((t) => !strata || strata.includes(t.stratum));
	const keep = new Set(all.map((t) => t.i));
	const npcZc = new Map();
	const zOf = (c) => npcZc.get(c) || npcZc.set(c, spawnHeight(spawnz, c, SPAWN_R)).get(c);
	const trips = all.map((t) => {
		// which ends lie in a capital (a2's rules hold there only): a boundary walk's inner end; no world or reported one
		const s = { ...t, side: t.fac === 'Alliance' || t.fac === 'Horde' ? t.fac : null, cityA: t.stratum === 'boundary' && t.cross === 'out', cityB: t.stratum === 'boundary' && t.cross === 'in' };
		if (!(s.A.kind === 'land' || s.A.npc || s.B.npc)) return s;
		const walked = new Set(s.density.filter(([, n]) => n >= 3).map(([v]) => v));
		return anchorEnds(new AreaGraph(s.box, { grid }), s, taxi, zOf(s.c), (v) => walked.has(v));
	});
	const byI = new Map(trips.map((t) => [t.i, t]));
	const gn = gateNav(path.resolve(nav), priv);
	let res;
	try {
		res = await runArms({ trips, arms: arms.filter((a) => !PROTO[a]), dirs: { nav: gn.dir, ground, spf }, spawnz, policy, taxi });
	} finally {
		gn.done();
	}
	log(`world: ${trips.length} trips routed (${((Date.now() - t0) / 1000).toFixed(0)} s); judging`);
	const byStratum = new Map();
	let k = 0;
	for (const { trip: stored, area } of worldAreas(priv, grid, set)) {
		if (!keep.has(stored.i)) continue;
		const trip = byI.get(stored.i);
		const idx = k++;
		const one = Object.fromEntries(Object.entries(res).map(([arm, rs]) => [arm, [rs[idx]]]));
		const [row] = scoreRows(area, [trip], one);
		row.zone = trip.zone;
		row.cross = trip.cross;
		const key = trip.stratum === 'boundary' ? `${CITIES[trip.zone] ? CITIES[trip.zone].name : trip.zone} entrance` : trip.stratum === 'reported' ? trip.case : trip.stratum;
		if (!byStratum.has(key)) byStratum.set(key, []);
		byStratum.get(key).push(row);
		if (k % 100 === 0) log(`world: judged ${k}/${trips.length}`);
	}
	for (const [stratum, rows] of byStratum) {
		const summary = {};
		for (const arm of Object.keys(rows[0].arms)) {
			const fails = rows.filter((r) => r.arms[arm].fail);
			const by = {};
			for (const r of fails) by[r.arms[arm].fail] = (by[r.arms[arm].fail] || 0) + 1;
			summary[arm] = {
				fails: fails.length, pct: +(100 * fails.length / rows.length).toFixed(1), by,
				list: fails.map((r) => ({ i: r.i, zone: r.zone, cross: r.cross, fail: r.arms[arm].fail, from: { npc: r.A.npc, kind: r.A.kind, at: toMap(frames, r.zone, r.A.wx, r.A.wy).map((v) => +v.toFixed(2)), z: r.A.z }, to: { npc: r.B.npc, kind: r.B.kind, at: toMap(frames, r.zone, r.B.wx, r.B.wy).map((v) => +v.toFixed(2)), z: r.B.z }, real: Math.round(r.real), yards: r.arms[arm].ok ? Math.round(r.arms[arm].yards) : null })),
			};
			for (const r of rows) {
				const z = (report.zones[r.zone] = report.zones[r.zone] || {});
				const a = (z[arm] = z[arm] || { trips: 0, fails: 0 });
				a.trips++;
				if (r.arms[arm].fail) a.fails++;
			}
		}
		report.maps[stratum] = { name: stratum, trips: rows.length, summary, rows };
	}
	report.seconds = Math.round((Date.now() - t0) / 1000);
	return report;
}

// Rows of scored arms: res { arm: [router answer per trip] } (pts, yards, retried), protos { arm: trip -> answer } (the
// judge's own desire paths).
function scoreRows(area, trips, res, protos = {}) {
	const { measure } = judge(area);
	// 0.01 yd: --remeasure re-scores these, and the judge's 10 yd thresholds sit close to some walks
	const keep = (pts) => pts.map((p) => p.map((v) => (v === null ? null : +v.toFixed(2))));
	// an end asked without a height has none on its own point: the walk's height there is its nearest point's that has one
	const zAt = (pts, from, step) => {
		for (let i = from; i >= 0 && i < pts.length; i += step) if (pts[i][2] !== null && pts[i][2] !== undefined) return pts[i][2];
		return null;
	};
	const score = (r, tt) => {
		if (!r.ok) return { ok: false, reason: r.reason, fail: 'no walk' };
		const x = { ok: true, ...measure(r.pts), routerYards: r.yards === undefined ? null : r.yards, retried: !!r.retried, startZ: zAt(r.pts, 0, 1), endZ: zAt(r.pts, r.pts.length - 1, -1), pts: keep(r.pts) };
		x.fail = failOf(x, tt);
		return x;
	};
	// an end anchorEnds moved (a landing onto its tower, an NPC onto its floor) joins the recorded route by the graph's
	// own walk between the two (players drop off the tower; a walk can't): the real route is that plus the recorded one
	const realPath = (t) => {
		let p = t.path;
		const join = (from, to) => {
			area.g.search([[from, 0]], [to], { bound: 600 });
			return area.g.pathTo(to);
		};
		if (t.A.was !== undefined && t.A.node !== p[0]) {
			const pre = join(t.A.node, p[0]);
			if (pre) p = pre.concat(p.slice(1));
		}
		if (t.B.was !== undefined && t.B.node !== p[p.length - 1]) {
			const post = join(p[p.length - 1], t.B.node);
			if (post) p = p.slice(0, -1).concat(post);
		}
		return p;
	};
	return trips.map((t, k) => {
		const real = measure(tautPts(area.g, realPath(t)));
		const tt = { ...t, real: real.yards };
		const row = { i: t.i, A: t.A, B: t.B, straight: t.straight, real: real.yards, arms: {} };
		for (const [arm, rs] of Object.entries(res)) row.arms[arm] = score(rs[k], tt);
		for (const [arm, fn] of Object.entries(protos)) row.arms[arm] = score(fn(t), tt);
		return row;
	});
}

function summarize(rows, map, frames, npcs) {
	const npcName = (id) => (id && npcs[id] ? npcs[id].name : null);
	const pct = (wx, wy) => toMap(frames, map, wx, wy).map((v) => +v.toFixed(2));
	const summary = {};
	for (const arm of Object.keys(rows[0] ? rows[0].arms : {})) {
		const fails = rows.filter((r) => r.arms[arm].fail);
		const by = {};
		for (const r of fails) by[r.arms[arm].fail] = (by[r.arms[arm].fail] || 0) + 1;
		summary[arm] = {
			fails: fails.length, pct: +(100 * fails.length / rows.length).toFixed(1), by,
			walls: rows.filter((r) => r.arms[arm].ok && r.arms[arm].crossings > 0).length,
			void6: rows.filter((r) => r.arms[arm].ok && r.arms[arm].void >= 6).length,
			list: fails.map((r) => {
				const x = r.arms[arm];
				const end = (e) => ({ npc: e.npc, name: npcName(e.npc), kind: e.kind, at: pct(e.wx, e.wy), z: +e.z.toFixed(1) });
				return { i: r.i, fail: x.fail, from: end(r.A), to: end(r.B), real: Math.round(r.real), yards: x.ok ? Math.round(x.yards) : null, retried: x.retried || false, where: x.at ? Object.fromEntries(Object.entries(x.at).map(([k, v]) => [k, [...pct(v[0], v[1]), v[2]]])) : null };
			}),
		};
	}
	return summary;
}

// An earlier report scored again with today's judge (a rule changed): its router answers (kept lines) re-measured and
// the desire-path arms routed again; nothing runs the router.
function remeasure(report, { priv, grid, frames, npcs = {}, protos: extraArms = [], log = () => {} }) {
	for (const [map, m] of Object.entries(report.maps)) {
		const area = loadArea(priv, Number(map), grid, frames);
		const byI = new Map(area.trips.map((t) => [t.i, t]));
		// the stored rows keep the ends the gate anchored (anchorEnds)
		const trips = m.rows.map((r) => ({ ...byI.get(r.i), A: r.A, B: r.B }));
		const res = {};
		for (const arm of Object.keys(m.rows[0].arms)) if (!PROTO[arm]) res[arm] = m.rows.map((r) => r.arms[arm]);
		const protos = protosFor(area, [...new Set([...Object.keys(m.rows[0].arms), ...extraArms])]);
		m.rows = scoreRows(area, trips, res, protos);
		m.summary = summarize(m.rows, Number(map), frames, npcs);
		log(`${m.name}: ${Object.entries(m.summary).map(([a, s]) => `${a} ${s.fails}/${m.rows.length}`).join(', ')} (measured again)`);
	}
	return report;
}

// cand vs base: per city and counted arm, fewer or equal failures; and the trips that newly fail.
function compareReports(base, cand) {
	const rows = [];
	let pass = true;
	for (const [map, c] of Object.entries(cand.maps)) {
		const b = base.maps[map];
		if (!b) continue;
		for (const arm of Object.keys(c.summary)) {
			const bs = b.summary[arm];
			if (!bs) continue;
			const bf = new Set(bs.list.map((x) => x.i));
			const cf = new Set(c.summary[arm].list.map((x) => x.i));
			const newFails = [...cf].filter((i) => !bf.has(i));
			const fixed = [...bf].filter((i) => !cf.has(i));
			const worse = c.summary[arm].fails > bs.fails;
			if (worse && COUNTED.includes(arm)) pass = false;
			rows.push({ map: +map, name: c.name, arm, base: bs.fails, cand: c.summary[arm].fails, newFails, fixed, counted: COUNTED.includes(arm) });
		}
	}
	return { pass, rows };
}

// Formats a report (and a comparison) as Markdown for GATE.md.
function markdown(report, cmp = null) {
	const lines = [];
	const arms = [...new Set(Object.values(report.maps).flatMap((m) => Object.keys(m.summary)))];
	lines.push(`| City | trips | ${arms.map((a) => (COUNTED.includes(a) ? `**${a}**` : a)).join(' | ')} |`, `|---|---:|${arms.map(() => '---:').join('|')}|`);
	let tot = 0;
	const sums = Object.fromEntries(arms.map((a) => [a, 0]));
	for (const m of Object.values(report.maps)) {
		tot += m.trips;
		lines.push(`| ${m.name} | ${m.trips} | ${arms.map((a) => { const s = m.summary[a]; if (!s) return '-'; sums[a] += s.fails; return `${s.fails} (${s.pct}%)`; }).join(' | ')} |`);
	}
	lines.push(`| **all** | ${tot} | ${arms.map((a) => `${sums[a]} (${(100 * sums[a] / tot).toFixed(1)}%)`).join(' | ')} |`);
	if (cmp) {
		lines.push('', `Against the baseline: ${cmp.pass ? 'PASS (no counted arm worse in any city)' : 'FAIL (a counted arm got worse)'}`);
		for (const r of cmp.rows.filter((x) => x.counted && (x.newFails.length || x.fixed.length))) lines.push(`- ${r.name} ${r.arm}: ${r.base} -> ${r.cand}; newly failing ${r.newFails.join(', ') || 'none'}; fixed ${r.fixed.join(', ') || 'none'}`);
	}
	return lines.join('\n');
}

module.exports = { gate, gateWorld, remeasure, compareReports, markdown, judge, tautPts, desire, anchorEnds, COUNTED };
