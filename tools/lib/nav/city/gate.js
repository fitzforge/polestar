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
			for (let k = i === 1 ? 0 : 1; k <= n; k++) {
				const t = k / n;
				const x = ax + (bx - ax) * t;
				const y = ay + (by - ay) * t;
				if (az === null || bz === null) continue;
				const z = az + (bz - az) * t;
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
				if (under(v)) {
					m.under += seg;
					note('under', x, y, z);
				}
				if (cs.tz.length && people[v] < 1 && !cs.tz.some((q) => Math.abs(q - g.nz[v]) <= 5)) {
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

// Desire paths (P3) on the judge's grid: trail surfaces (3+ training people) at their length, the rest x3, plus the
// trail edges learned from grid holes 2+ training people stepped through.
function desire({ g, train, gaps }) {
	const mult = new Float32Array(g.n);
	for (let v = 0; v < g.n; v++) mult[v] = train[v] >= 3 ? 1 : 3;
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
		g.search([[a, 0]], [b], { mult, goal: g.local(t.B.wx, t.B.wy), extra });
		const p = g.pathTo(b);
		if (!p) return { ok: false, reason: 'no path' };
		return { ok: true, pts: tautPts(g, p) };
	};
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

function gate({ priv, nav, ground = null, grid, frames, spawnz, npcs = {}, maps = Object.keys(CITIES).map(Number), arms = ['GAME', 'WALK', 'E0', 'E2', 'P3'], policy = 'legacy', log = () => {} }) {
	const report = { nav: path.resolve(nav), policy, arms, maps: {} };
	const gn = gateNav(path.resolve(nav), priv);
	report.trails = gn.dir !== path.resolve(nav) ? 'training people only (<priv>/Trails-train.lua)' : "the folder's own";
	for (const map of maps) {
		const city = CITIES[map];
		const t0 = Date.now();
		const area = loadArea(priv, map, grid, frames);
		const { g, trips } = area;
		const { measure } = judge(area);
		const npcZ = spawnHeight(spawnz, city.c);
		const navRun = (dir, queries) => run.runQueries({ navDir: dir, queries }).results;
		const route = (id, from, to, extra = {}) => ({ type: 'route', id, map: city.c, from, to, profile: city.side, style: 'balanced', level: null, danger: null, ...extra });
		const A = (t, z) => [t.A.wx, t.A.wy, z === undefined ? null : z];
		const B = (t, z) => [t.B.wx, t.B.wy, z === undefined ? null : z];
		// trail floors (Path.TrailFloor) at every trip end, for WALK
		let tf = null;
		if (arms.includes('WALK')) {
			const q = [];
			trips.forEach((t) => {
				q.push({ type: 'trailfloor', id: `a${t.i}`, map: city.c, at: [t.A.wx, t.A.wy], reach: 4, near: null });
				q.push({ type: 'trailfloor', id: `b${t.i}`, map: city.c, at: [t.B.wx, t.B.wy], reach: 4, near: null });
			});
			tf = new Map(navRun(gn.dir, q).map((r) => [r.id, r.z]));
		}
		const startOf = (t, arm) => {
			if (arm === 'GAME' || arm === 'E2' || arm === 'G1') return t.A.z;
			if (arm === 'E0') return null;
			const nz = npcZ(t.A.npc, t.A.wx, t.A.wy);
			return nz !== null ? nz : tf.get(`a${t.i}`);
		};
		const goalOf = (t, arm) => {
			if (arm === 'E2' || arm === 'G1') return t.B.z;
			if (arm === 'E0') return null;
			const nz = npcZ(t.B.npc, t.B.wx, t.B.wy);
			if (nz !== null) return nz;
			return arm === 'WALK' ? tf.get(`b${t.i}`) : null;
		};
		const res = {};
		for (const arm of arms) {
			if (arm === 'P3') continue;
			const dir = arm === 'G1' ? ground : gn.dir;
			if (!dir) continue;
			const policied = arm === 'GAME' || arm === 'WALK';
			const first = navRun(dir, trips.map((t) => route(`${arm}|${t.i}`, A(t, startOf(t, arm)), B(t, goalOf(t, arm)), policied && policy === 'a2' ? { reach: 10 } : {})));
			if (policied && policy === 'legacy') {
				const again = [];
				first.forEach((r, k) => {
					const t = trips[k];
					const gz = goalOf(t, arm);
					if (gz === null || gz === undefined) return;
					const off = r.ok && r.pts.length && Math.abs(r.pts[r.pts.length - 1][2] - gz) > Z_OFF;
					if (!r.ok || off) again.push(k);
				});
				if (again.length) {
					const second = navRun(dir, again.map((k) => route(`${arm}|${k}|retry`, A(trips[k], startOf(trips[k], arm)), B(trips[k], null))));
					again.forEach((k, j) => (first[k] = { ...second[j], retried: true }));
				}
			}
			res[arm] = first;
		}
		const p3 = arms.includes('P3') ? desire(area) : null;
		const rows = trips.map((t, k) => {
			const realPts = tautPts(g, t.path);
			const real = measure(realPts);
			const tt = { ...t, real: real.yards };
			const row = { i: t.i, A: t.A, B: t.B, straight: t.straight, real: real.yards, arms: {} };
			for (const [arm, rs] of Object.entries(res)) {
				const r = rs[k];
				if (!r.ok) {
					row.arms[arm] = { ok: false, reason: r.reason, fail: 'no walk' };
					continue;
				}
				const mm = measure(r.pts);
				const x = { ok: true, ...mm, routerYards: r.yards, retried: !!r.retried, startZ: r.pts[0][2], endZ: r.pts[r.pts.length - 1][2], pts: r.pts.map((p) => p.map((v) => (v === null ? null : +v.toFixed(1)))) };
				x.fail = failOf(x, tt);
				row.arms[arm] = x;
			}
			if (p3) {
				const r = p3(t);
				if (!r.ok) row.arms.P3 = { ok: false, reason: r.reason, fail: 'no walk' };
				else {
					const x = { ok: true, ...measure(r.pts), startZ: r.pts[0][2], endZ: r.pts[r.pts.length - 1][2], pts: r.pts.map((p) => p.map((v) => +v.toFixed(1))) };
					x.fail = failOf(x, tt);
					row.arms.P3 = x;
				}
			}
			return row;
		});
		const npcName = (id) => (id && npcs[id] ? npcs[id].name : null);
		const pct = (wx, wy) => toMap(frames, map, wx, wy).map((v) => +v.toFixed(2));
		const summary = {};
		for (const arm of Object.keys(rows[0] ? rows[0].arms : {})) {
			const fails = rows.filter((r) => r.arms[arm].fail);
			const by = {};
			for (const r of fails) by[r.arms[arm].fail] = (by[r.arms[arm].fail] || 0) + 1;
			const walls = rows.filter((r) => r.arms[arm].ok && r.arms[arm].crossings > 0).length;
			const voids = rows.filter((r) => r.arms[arm].ok && r.arms[arm].void >= 6).length;
			summary[arm] = {
				fails: fails.length, pct: +(100 * fails.length / rows.length).toFixed(1), by, walls, void6: voids,
				list: fails.map((r) => ({ i: r.i, fail: r.arms[arm].fail, from: { npc: r.A.npc, name: npcName(r.A.npc), kind: r.A.kind, at: pct(r.A.wx, r.A.wy), z: +r.A.z.toFixed(1) }, to: { npc: r.B.npc, name: npcName(r.B.npc), kind: r.B.kind, at: pct(r.B.wx, r.B.wy), z: +r.B.z.toFixed(1) }, real: Math.round(r.real), yards: r.arms[arm].ok ? Math.round(r.arms[arm].yards) : null, retried: r.arms[arm].retried || false, where: r.arms[arm].at ? Object.fromEntries(Object.entries(r.arms[arm].at).map(([k2, v]) => [k2, [...pct(v[0], v[1]), v[2]]])) : null })),
			};
		}
		report.maps[map] = { name: city.name, trips: rows.length, summary, rows, seconds: Math.round((Date.now() - t0) / 1000) };
		log(`${city.name}: ${Object.entries(summary).map(([a, s]) => `${a} ${s.fails}/${rows.length}`).join(', ')} (${report.maps[map].seconds} s)`);
	}
	gn.done();
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

module.exports = { gate, compareReports, markdown, judge, tautPts, desire, COUNTED };
