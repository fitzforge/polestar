'use strict';
// Reference answers of the Node format-4 reader (tools/lib/nav/nav4: the port of Leffe's reader) for forge-nav's
// f4 parity (tests/f4_parity.rs, F4_REF=<out.json>): the acceptance walks that resolve to world points, random pairs
// 100-2000 yd apart on both continents from the v1 goal streams' positions, and FindMany batches (one source, up to
// 50 targets within 4000 yd, with limit and chains). Validate 'tolerant' (the pipeline's mode). Each route runs
// twice (cold: the first pass, the cache filling; warm: the second) for the timings.
// node f4-ref.js <node repo> <Nav dir> <goal streams dir> <out.json> [pairs=200] [batches=20] [seed=7]
const fs = require('node:fs');
const path = require('node:path');
const [repo, navArg, streams, out, pairsArg, batchesArg, seedArg] = process.argv.slice(2);
const nav4 = require(path.join(repo, 'tools/lib/nav/nav4'));
const { openPack, STRIDE } = require(path.join(repo, 'tools/lib/nav/nav4/pack'));
const { openStore } = require(path.join(repo, 'tools/lib/nav/nav4/store'));
const { Router } = require(path.join(repo, 'tools/lib/nav/nav4/router'));
const { resolveRoutes } = require(path.join(repo, 'tools/lib/nav/eval/run'));
const { Geo } = require(path.join(repo, 'tools/lib/planner/geo'));

const nPairs = Number(pairsArg || 200), nBatches = Number(batchesArg || 20);
let seed = Number(seedArg || 7);
const rnd = () => (seed = (Math.imul(seed, 1103515245) + 12345) >>> 0) / 4294967296;
const pick = (a) => a[Math.floor(rnd() * a.length)];

const dir = nav4.navFolder(navArg);
const pack = openPack(dir);
const store = openStore({ pack, cacheMB: 1024 });
const router = new Router(store, { validate: 'tolerant' });

// The acceptance walks with world ends (zone-map ends through map-frames.json, as eval/run.js resolves them).
const data = path.join(repo, 'data', 'forever');
const geo = new Geo(JSON.parse(fs.readFileSync(path.join(data, 'map-frames.json'), 'utf8')), JSON.parse(fs.readFileSync(path.join(data, 'zones.json'), 'utf8')));
const acceptance = JSON.parse(fs.readFileSync(path.join(repo, 'tools/lib/nav/eval/acceptance.json'), 'utf8')).routes;
const routes = [];
let skipped = [];
for (const r of acceptance) {
	try {
		const [w] = resolveRoutes([r], geo);
		if (!pack.maps.includes(w.map)) {
			skipped.push(`${r.id}: map ${w.map} not in the pack`);
			continue;
		}
		routes.push({ id: `acc:${r.id}`, map: w.map, from: w.from, to: w.to, profile: w.profile, style: 'balanced', danger: w.danger });
	} catch (e) {
		skipped.push(`${r.id}: ${e.message}`);
	}
}

// Goal positions of the v1 streams, by continent, with their faction.
const goals = { 0: [], 1: [] };
const seen = new Set();
for (const f of fs.readdirSync(streams).filter((f) => /^v1-.*-on\.json$/.test(f)).sort()) {
	const s = JSON.parse(fs.readFileSync(path.join(streams, f), 'utf8'));
	const faction = /alliance/.test(f) ? 'Alliance' : 'Horde';
	for (const g of s.goals || []) {
		const w = g.w;
		if (!w || !(w.c in goals)) continue;
		const key = `${w.c}|${w.wx.toFixed(2)}|${w.wy.toFixed(2)}`;
		if (seen.has(key)) continue;
		seen.add(key);
		goals[w.c].push({ x: w.wx, y: w.wy, faction });
	}
}
const dist = (a, b) => Math.hypot(a.x - b.x, a.y - b.y);
const STYLES = ['balanced', 'balanced', 'fastest', 'roads'];
for (let i = 0; i < nPairs; i++) {
	const c = i % 2 === 0 ? 0 : 1;
	for (let tries = 0; tries < 10000; tries++) {
		const a = pick(goals[c]), b = pick(goals[c]);
		const d = dist(a, b);
		if (d < 100 || d > 2000) continue;
		routes.push({ id: `pair:${i}`, map: c, from: [a.x, a.y, null], to: [b.x, b.y, null], profile: a.faction, style: pick(STYLES), danger: null });
		break;
	}
}

const batches = [];
for (let i = 0; i < nBatches; i++) {
	const c = i % 2 === 0 ? 0 : 1;
	const a = pick(goals[c]);
	const near = goals[c].filter((g) => g !== a && dist(a, g) <= 4000);
	const targets = [];
	while (targets.length < 50 && near.length) targets.push(near.splice(Math.floor(rnd() * near.length), 1)[0]);
	batches.push({ id: `many:${i}`, map: c, from: [a.x, a.y, null], targets: targets.map((t) => [t.x, t.y, null]), profile: a.faction, style: i % 4 === 3 ? 'fastest' : 'balanced', limit: i % 2 === 0 ? 2500 : null });
}

const point = (p) => ({ x: p[0], y: p[1], z: p[2] });
const shape = (res) => ({ ok: res.ok, reason: res.reason, pts: res.pts, cost: res.cost, yards: res.yards, wet: res.wet ?? null, jumps: res.jumps ?? null, hubs: res.hubs ? res.hubs.map((h) => h.id) : null, events: res.events ?? null });
const optsOf = (r) => ({ profile: r.profile, style: r.style, danger: r.danger || undefined });

// index.js chainCells, over the router's map state.
function chainCells(st, from, to, chain, total) {
	const pts = [from.x, from.y];
	const at = [0, 0, 0];
	for (const id of chain) {
		const k = Math.floor(id / STRIDE);
		st.geometry(st.grid(k), k, st.entranceNode(id), at);
		pts.push(at[0], at[1]);
	}
	pts.push(to.x, to.y);
	const acc = new Map();
	let flat = 0;
	for (let i = 0; i + 3 < pts.length; i += 2) {
		const ax = pts[i], ay = pts[i + 1], dx = pts[i + 2] - ax, dy = pts[i + 3] - ay;
		const len = Math.hypot(dx, dy);
		if (!len) continue;
		const steps = Math.ceil(len / 4);
		for (let s = 0; s < steps; s++) {
			const t = (s + 0.5) / steps;
			const key = (Math.floor((ax + dx * t) / 200) + 512) * 1024 + Math.floor((ay + dy * t) / 200) + 512;
			acc.set(key, (acc.get(key) || 0) + len / steps);
		}
		flat += len;
	}
	if (!flat) return [(Math.floor(from.x / 200) + 512) * 1024 + Math.floor(from.y / 200) + 512, total];
	const o = [];
	for (const [key, yd] of acc) o.push(key, (yd / flat) * total);
	return o;
}

const t0 = performance.now();
const outRoutes = routes.map((r) => ({ ...r, res: null, msCold: 0, msWarm: 0 }));
for (const pass of ['msCold', 'msWarm'])
	for (const r of outRoutes) {
		const t = performance.now();
		const res = nav4.routeOn(router, { map: r.map, ...point(r.from) }, { map: r.map, ...point(r.to) }, optsOf(r));
		r[pass] = performance.now() - t;
		if (pass === 'msCold') r.res = shape(res);
	}
const outMany = batches.map((q) => {
	const from = point(q.from), targets = q.targets.map(point);
	const opts = { profile: q.profile, style: q.style, limit: q.limit, chains: true };
	let t = performance.now();
	const res = router.routeMany(q.map, from, targets, opts);
	const msCold = performance.now() - t;
	t = performance.now();
	router.routeMany(q.map, from, targets, opts);
	const msWarm = performance.now() - t;
	const st = router.state(q.map);
	const cells = targets.map((b, i) => (res.yards[i] === false ? null : chainCells(st, from, b, (res.chains && res.chains[i]) || [], res.yards[i])));
	const minus = (v) => (v === false ? -1 : v);
	return { ...q, res: { costs: res.costs.map(minus), yards: res.yards.map(minus), jumps: res.jumps.map(minus), reasons: res.reasons, chains: res.chains, cells }, msCold, msWarm };
});
const report = {
	note: "forge-nav f4 parity: the Node format-4 reader's answers (validate 'tolerant')",
	dir,
	skipped,
	routes: outRoutes,
	many: outMany,
	stats: store.stats(),
	totalMs: performance.now() - t0,
	rssMB: process.memoryUsage().rss / 1048576,
	peakRssMB: process.resourceUsage().maxRSS / 1024,
};
fs.writeFileSync(out, JSON.stringify(report));
const ok = outRoutes.filter((r) => r.res.ok).length;
console.log(`${outRoutes.length} routes (${ok} ok, ${skipped.length} acceptance skipped), ${outMany.length} batches -> ${out} in ${(report.totalMs / 1000).toFixed(1)} s`);
for (const s of skipped) console.log(`  skipped ${s}`);
