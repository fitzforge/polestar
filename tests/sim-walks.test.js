'use strict';
// Routed walks (tools/lib/sim/walks.js, docs/legacy/SIMULATION-js.md §1 "Walks"): the
// walking router's yards between the world's points replace the straight
// line × detour where `sim walks` has routed them. On the invented world of
// tests/fixtures/sim/synthetic.js, with the router's answers stubbed.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const { buildWorld } = require('../tools/lib/sim/world');
const { compileRun, makeTables } = require('../tools/lib/sim/run');
const { Travel } = require('../tools/lib/sim/travel');
const { effective, means } = require('../tools/lib/sim/params');
const walks = require('../tools/lib/sim/walks');
const { buildLookup } = require('../tools/lib/sim/walklookup');
const sim = require('../tools/lib/sim');
const syn = require('./fixtures/sim/synthetic');
const { tmpdir } = require('./helpers/tmp');

function world() {
	const w = buildWorld(syn.makeData(), { faction: 'Horde', bandWidth: 5, extraStarts: syn.START });
	w.questXp = syn.questXpRows();
	w.dataHash = 'test-world';
	return w;
}

const params = (over = {}) => ({ ...means(effective({ calibrated: {} })), ...over });

// A walking-maps folder with a PACK.json naming the synthetic world's continent.
function navDir(extra = '') {
	const dir = tmpdir('sim-walks-nav-');
	fs.writeFileSync(path.join(dir, 'PACK.json'), JSON.stringify({ format: 2, maps: { 1: {} }, note: extra }));
	return dir;
}

// The router stubbed: every walk is `factor` × the straight line (cost = yards).
function fakeRouter(w, factor) {
	return ({ queries }) => ({
		results: queries.map((q) => {
			const yards = q.targets.map((t) => Math.round(Math.hypot(t[0] - q.from[0], t[1] - q.from[1]) * factor * 10) / 10);
			return { type: 'many', id: q.id, ok: true, yards, costs: yards.slice() };
		}),
	});
}

// The router stubbed per level band: yards `factor` × the straight line, cost 3x yards below level 15.
function fakeRouterBands(w, factor) {
	let calls = 0;
	const fn = ({ queries }) => {
		calls += queries.length;
		return { results: queries.map((q) => ({ type: 'many', id: q.id, ok: true,
			yards: q.targets.map((t) => Math.round(Math.hypot(t[0] - q.from[0], t[1] - q.from[1]) * factor * 10) / 10),
			costs: q.targets.map((t) => Math.round(Math.hypot(t[0] - q.from[0], t[1] - q.from[1]) * factor * (q.level < 15 ? 3 : 1) * 10) / 10) })) };
	};
	fn.calls = () => calls;
	return fn;
}

// A level-40 zone (99199) across the land between Testvale (y -500 to -770)
// and Farfield (y -1300 to -1900): the 200-yd cells at y -1200 to -1000.
function ridge(w) {
	const g = w.danger.find((d) => d.region === 10);
	const gy = Math.floor(-1100 / g.cell) - g.gy0;
	for (let gx = 0; gx < g.nx; gx++) g.z[gx * g.ny + gy] = 99199;
	w.zoneMin = { ...w.zoneMin, 99199: 40 };
	return w;
}

// Word to the Warden (503): Elder Testa in Testvale to Warden Fieldy in Farfield, 1000 yd east.
function wardenLeg(w, run) {
	const q = w.quests.find((x) => x.id === 503);
	const idx = new Map(Array.from(run.ptList, (p, i) => [p, i]));
	return { a: idx.get(q.giver), b: idx.get(q.ender), wa: q.giver, wb: q.ender };
}

test('walk queries: every later point on the same landmass within the radius, one search per point, as the faction', () => {
	const w = world();
	w.points[3][5] = 12.5; // a point with a height sends it
	const { points, queries } = walks.walkQueries(w, { radius: 4000, maps: new Set([1]) });
	assert.ok(points.length >= 3);
	assert.deepEqual(points, points.slice().sort((a, b) => a - b));
	for (const q of queries) {
		assert.equal(q.type, 'many');
		assert.equal(q.profile, 'Horde');
		assert.equal(q.style, 'balanced');
		assert.equal(q.level, undefined, 'the base walk has no zone danger');
		assert.ok(q.ids.every((t) => t > Number(q.id)), 'only later points: each pair is searched once');
		assert.equal(q.ids.length, q.targets.length);
		assert.deepEqual(q.from, [w.points[q.src][2], w.points[q.src][3], q.src === 3 ? 12.5 : null]);
		q.ids.forEach((t, k) => assert.deepEqual(q.targets[k], [w.points[t][2], w.points[t][3], t === 3 ? 12.5 : null]));
	}
	assert.ok(queries.some((q) => q.ids.includes(3)), 'the point with a height is walked to');
	assert.equal(walks.walkQueries(w, { radius: 100, anchorRadius: 100, maps: new Set([1]) }).queries.every((q) => q.ids.every((t) => Math.hypot(w.points[t][2] - w.points[Number(q.id)][2], w.points[t][3] - w.points[Number(q.id)][3]) <= 100)), true);
	assert.equal(walks.walkQueries(w, { radius: 4000, maps: new Set([0]) }).points.length, 0, 'a continent without walking maps is not routed');
});

test('walk queries: anchors (starts, docks, inns, services) pair up to the anchor radius, other points to the radius', () => {
	const w = world();
	const anchors = walks.anchorPoints(w);
	assert.ok(anchors.has(w.starts.Orc.pt) && anchors.has(1), 'the start and the dock are anchors');
	const svc = w.points.findIndex((p, i) => p[0] === 1 && !anchors.has(i) && i > 2);
	w.services.repair.push({ pt: svc, npc: 1 });
	assert.ok(walks.anchorPoints(w).has(svc), 'a service point is an anchor');
	const pairs = (o) => walks.walkQueries(w, { maps: new Set([1]), ...o }).queries.flatMap((q) => q.ids.map((t) => [q.src, t]));
	const near = pairs({ radius: 1000, anchorRadius: 1000 });
	const far = pairs({ radius: 1000, anchorRadius: 12000 });
	const d = ([a, b]) => Math.hypot(w.points[a][2] - w.points[b][2], w.points[a][3] - w.points[b][3]);
	assert.ok(near.every((p) => d(p) <= 1000));
	const extra = far.filter((p) => d(p) > 1000);
	assert.ok(extra.length > 0, 'anchor pairs beyond the radius');
	const now = walks.anchorPoints(w);
	assert.ok(extra.every(([a, b]) => now.has(a) && now.has(b)), 'only anchor to anchor goes further');
});

test('band queries: only pairs whose line crosses a zone 4+ levels above the band, grouped by target zone, at the band\'s level', () => {
	const w = ridge(world());
	const base = walks.walkQueries(w, { maps: new Set([1]) });
	const b10 = walks.walkQueries(w, { maps: new Set([1]), band: 10 });
	const b40 = walks.walkQueries(w, { maps: new Set([1]), band: 40 });
	assert.equal(b40.queries.length, 0, 'a level-40 zone is no danger at band 40');
	assert.ok(b10.queries.length > 0);
	const all = base.queries.reduce((n, q) => n + q.ids.length, 0);
	const crossing = b10.queries.reduce((n, q) => n + q.ids.length, 0);
	assert.ok(crossing > 0 && crossing < all, `${crossing} of ${all} pairs cross the ridge`);
	for (const q of b10.queries) {
		assert.equal(q.level, 10);
		const zones = new Set(q.ids.map((t) => w.points[t][4]));
		assert.equal(zones.size, 1, 'one target zone per query');
		assert.deepEqual(q.to, q.targets[0], 'the first target names the target zone');
		const sy = w.points[q.src][3];
		for (const t of q.ids) assert.ok((sy > -1000) !== (w.points[t][3] > -1000), 'the line crosses the ridge');
	}
});

test('build: the routed yards and cost of every pair; a walk the router cannot find is left out', async () => {
	const w = world();
	const nav = navDir();
	const router = fakeRouter(w, 2);
	const failing = (o) => {
		const r = router(o);
		r.results[0].yards[0] = false;
		r.results[0].costs[0] = false;
		return r;
	};
	const { doc, routed, cached, failed } = await walks.buildWalks(w, { navDir: nav, snap: null, bands: [30], runQueries: failing });
	assert.equal(doc.schema, walks.WALKS_SCHEMA);
	assert.equal(doc.schema, 4);
	assert.equal(doc.zones, null, 'a stubbed router builds no zones');
	assert.equal(doc.faction, 'Horde');
	assert.equal(doc.dataHash, 'test-world');
	assert.equal(doc.nav, walks.navFingerprint(nav));
	assert.deepEqual(doc.bands, [0, 30]);
	assert.deepEqual(doc.pairs['30'], [], 'no zone to cross: band 30 is the base walk');
	const all = walks.walkQueries(w, { maps: new Set([1]) }).queries.reduce((n, q) => n + q.targets.length, 0);
	assert.equal(doc.pairs['0'].length / 5, all - 1);
	assert.equal(routed, all);
	assert.equal(cached, 0);
	assert.equal(failed, 1);
	for (let i = 0; i < doc.pairs['0'].length; i += 5) {
		assert.ok(doc.pairs['0'][i] < doc.pairs['0'][i + 1]);
		assert.equal(doc.pairs['0'][i + 2], doc.pairs['0'][i + 3], 'cost as the router says');
		assert.equal(doc.pairs['0'][i + 4], 0, 'no heights: every walk both ways');
	}
});

test('build: each base walk\'s yards per zone: one zone\'s whole where every way stays in its cells, else the grid route\'s shares × the walk\'s yards; the lookup reads them', async () => {
	const w = world();
	const nav = navDir();
	const asked = [];
	const zoneQueries = (ask) => ask.map((q) => (asked.push(q), { k: q.k, z: q.k % 2 ? [7, 0.25, 8, 0.75] : null }));
	const { doc } = await walks.buildWalks(w, { navDir: nav, snap: null, bands: [], runQueries: fakeRouter(w, 2), zoneQueries });
	const base = doc.pairs['0'];
	assert.equal(doc.zones.length, base.length / 5);
	for (let k = 0; k < doc.zones.length; k++) {
		const q = asked.find((x) => x.k === k);
		if (!q) {
			const z = doc.zones[k];
			assert.ok(z === null || (z.length === 2 && z[1] === base[5 * k + 2]), `pair ${k}: one zone's whole walk (${z})`);
			continue;
		}
		if (k % 2) assert.deepEqual(doc.zones[k], [7, Math.round(0.25 * base[5 * k + 2] * 10) / 10, 8, Math.round(0.75 * base[5 * k + 2] * 10) / 10]);
		else assert.equal(doc.zones[k], null, 'no route: none (the straight line stands in)');
	}
	assert.ok(asked.some((x) => x.k % 2), 'the synthetic world has zone borders to route across');
	assert.ok(doc.zones.some((z, k) => z && !asked.find((x) => x.k === k)), 'and walks inside one zone, not routed');
	const lk = buildLookup(doc, w.points.length);
	const k = asked.find((x) => x.k % 2).k;
	assert.deepEqual(lk.zones(base[5 * k], base[5 * k + 1]), doc.zones[k]);
	assert.deepEqual(lk.zones(base[5 * k + 1], base[5 * k]), doc.zones[k], 'a both-ways walk both ways');
});

test('build: the router is sent the grid\'s x, y with the point\'s own height; a failed pair is asked once more with the full surface; the cache stays keyed by the raw point', async () => {
	const w = world();
	const nav = navDir();
	const sim = tmpdir('walks-snap-');
	const P = w.points;
	const pts = walks.walkQueries(w, { maps: new Set([1]) }).points;
	const [first, moved] = pts;
	// The grid's surface for `moved` is 6 yd east of it and 3 yd up; every other point has none (sent raw).
	const surface = [P[moved][2], P[moved][3] + 6, (P[moved][5] || 0) + 3];
	const snap = (pt) => (pt === moved ? { wx: surface[0], wy: surface[1], z: surface[2], region: 1 } : null);
	const firstTry = [surface[0], surface[1], P[moved][5]];
	// The router walks to `moved` only on the surface's height.
	const onMoved = (t) => t[0] === surface[0] && t[1] === surface[1];
	const sent = [];
	const router = (o) => {
		sent.push(...o.queries);
		const r = fakeRouter(w, 2)(o);
		r.results.forEach((res, i) => {
			const q = o.queries[i];
			const bad = (t) => onMoved(t) && t[2] !== surface[2];
			res.yards = res.yards.map((y, k) => (bad(q.from) || bad(q.targets[k]) ? false : y));
			res.costs = res.yards.slice();
		});
		return r;
	};
	const out = await walks.buildWalks(w, { navDir: nav, snap, cacheDir: sim, bands: [], runQueries: router });
	assert.deepEqual(sent.find((q) => q.id === String(moved)).from, firstTry, 'from: the grid\'s x, y, the point\'s height');
	const q0 = sent.find((q) => q.id === String(first));
	assert.deepEqual(q0.from, [P[first][2], P[first][3], P[first][5]], 'no surface: the raw point');
	assert.deepEqual(q0.targets[0], firstTry, 'as a target: the grid\'s x, y, the point\'s height');
	const retries = sent.filter((q) => q.id.endsWith(':z'));
	assert.ok(retries.length > 0, 'failed pairs asked again');
	assert.ok(retries.every((q) => q.targets.every((t) => !onMoved(t) || t[2] === surface[2]) && (!onMoved(q.from) || q.from[2] === surface[2])), 'with the full surface');
	assert.equal(out.failed, 0, 'every pair recovered');
	assert.ok(out.recovered > 0 && out.recovered === retries.reduce((n, q) => n + q.targets.length, 0));
	const cache = JSON.parse(fs.readFileSync(path.join(sim, 'walkcache-horde.json'), 'utf8'));
	const km = cache.keys.indexOf(walks.keyOf(P, moved));
	assert.ok(km >= 0, 'keyed by the raw point');
	for (let i = 0; i < cache.pairs.length; i += 5) if (cache.pairs[i] === km || cache.pairs[i + 1] === km) assert.ok(cache.pairs[i + 3] >= 0, 'the retry\'s answer is cached');
});

test('walks are routed once per band, carry cost and yards, and a rebuild routes only new pairs', async () => {
	const w = ridge(world());
	const nav = navDir();
	const sim = tmpdir('walks-v2-');
	const router = fakeRouterBands(w, 1.5);
	const first = await walks.buildWalks(w, { navDir: nav, snap: null, cacheDir: sim, bands: [10, 30], runQueries: router });
	assert.ok(first.routed > 0 && first.cached === 0);
	assert.deepEqual(Object.keys(first.doc.pairs).sort(), ['0', '10', '30']);
	const p10 = first.doc.pairs['10'];
	assert.ok(p10.length > 0 && p10[3] > p10[2], 'cost at level 10 is above yards in this stub ([a, b, yards, cost])');
	const before = router.calls();
	const again = await walks.buildWalks(w, { navDir: nav, snap: null, cacheDir: sim, bands: [10, 30], runQueries: router });
	assert.equal(router.calls(), before, 'nothing routed twice');
	assert.equal(again.cached, first.routed);
	assert.deepEqual(again.doc.pairs, first.doc.pairs);
});

test('camps become walk endpoints with their own radii, and a rebuild routes only the new camp pairs', async () => {
	const w = world();
	const nav = navDir();
	const sim = tmpdir('walks-camps-');
	const router = fakeRouterBands(w, 1.2);
	// Build without camps first (as M1 did), then with camps.
	const before = await walks.buildWalks(w, { navDir: nav, cacheDir: sim, bands: [0], runQueries: router, snap: null, camps: false });
	const calls0 = router.calls();
	const after = await walks.buildWalks(w, { navDir: nav, cacheDir: sim, bands: [0], runQueries: router, snap: null });
	assert.ok(after.routed > 0, 'new camp pairs routed');
	assert.equal(after.cached, before.routed + before.failed, 'every M1 pair came from the cache');
	assert.ok(router.calls() > calls0);
	const campPts = new Set(w.camps.map((c) => c.pt));
	const pairs = after.doc.pairs['0'];
	let campPairs = 0;
	for (let i = 0; i < pairs.length; i += 5) if (campPts.has(pairs[i]) || campPts.has(pairs[i + 1])) campPairs++;
	assert.ok(campPairs > 0);
	// Every M1 walk is still in the new walks.
	const now = new Set();
	for (let i = 0; i < pairs.length; i += 5) now.add(`${pairs[i]}|${pairs[i + 1]}`);
	const old = before.doc.pairs['0'];
	for (let i = 0; i < old.length; i += 5) assert.ok(now.has(`${old[i]}|${old[i + 1]}`), 'an M1 walk kept');
});

test('walk queries: a camp used by a kept objective is a walk point, 1,500 yd to other places and 600 yd to another camp; earlier walk points keep their pairs', () => {
	const w = world();
	const maps = new Set([1]);
	const plain = new Set(walks.walkPoints(w, maps, { camps: false }));
	const used = new Set(w.quests.flatMap((q) => (q.objs || []).flatMap((o) => o.camps)).map((id) => w.camps[id].pt));
	const pts = walks.walkPoints(w, maps);
	for (const pt of used) assert.ok(pts.includes(pt), 'a used camp is a walk point');
	const camp = new Set([...used].filter((pt) => !plain.has(pt)));
	assert.ok(camp.size > 0, 'camps add points');
	const d = (a, b) => Math.hypot(w.points[a][2] - w.points[b][2], w.points[a][3] - w.points[b][3]);
	const pairs = walks.walkQueries(w, { maps }).queries.flatMap((q) => q.ids.map((t) => [q.src, t]));
	const withCamp = pairs.filter(([a, b]) => camp.has(a) || camp.has(b));
	assert.ok(withCamp.length > 0);
	for (const [a, b] of withCamp) assert.ok(d(a, b) <= (camp.has(a) && camp.has(b) ? 600 : 1500), `camp pair ${a}-${b} within its radius`);
	// Points that were walk points before camps keep every pair they had (anchors to 12,000 yd).
	const m1 = walks.walkQueries(w, { maps, camps: false }).queries.flatMap((q) => q.ids.map((t) => `${q.src}|${t}`));
	const all = new Set(pairs.map(([a, b]) => `${a}|${b}`));
	assert.ok(m1.every((k) => all.has(k)));
	const short = walks.walkQueries(w, { maps, radius: 1000 }).queries.flatMap((q) => q.ids.map((t) => [q.src, t]));
	assert.ok(short.filter(([a, b]) => camp.has(a) || camp.has(b)).every(([a, b]) => d(a, b) <= 1000), 'the camp radii never exceed the radius');
	// A camp beyond 1,500 yd of a place is not walked to it; two camps 600+ yd apart neither.
	const far = [...camp].flatMap((c) => pts.filter((p) => p !== c && w.points[p][0] === w.points[c][0] && w.points[p][1] === w.points[c][1] && d(p, c) > 1500 && d(p, c) <= 4000));
	assert.ok(far.length > 0, 'the fixture has a camp 1,500-4,000 yd from a place');
});

test('walk cache: keyed by place, so a moved point re-routes only its own pairs and a failure is not asked again', async () => {
	const w = world();
	const nav = navDir();
	const sim = tmpdir('walks-v2-');
	let fail = true;
	const router = (o) => {
		const r = fakeRouter(w, 2)(o);
		if (fail) r.results[0].yards[0] = false;
		return r;
	};
	const first = await walks.buildWalks(w, { navDir: nav, snap: null, cacheDir: sim, bands: [30], runQueries: router });
	assert.equal(first.failed, 1);
	const cache = JSON.parse(fs.readFileSync(path.join(sim, 'walkcache-horde.json'), 'utf8'));
	assert.equal(cache.schema, 2);
	assert.equal(cache.nav, walks.navFingerprint(nav));
	assert.equal(cache.style, 'balanced');
	assert.equal(cache.pairs.length / 5, first.routed);
	assert.ok(cache.keys.every((k) => /^\d+:-?\d+:-?\d+:(n|-?\d+)$/.test(k)));
	assert.ok(cache.pairs.some((v, i) => i % 5 === 3 && v === -1), 'the failure is stored');
	fail = false;
	const moved = world();
	const pt = moved.quests.find((q) => q.id === 503).ender;
	moved.points[pt][2] += 50;
	const second = await walks.buildWalks(moved, { navDir: nav, snap: null, cacheDir: sim, bands: [30], runQueries: router });
	const own = walks.walkQueries(moved, { maps: new Set([1]) }).queries.reduce((n, q) => n + q.ids.filter((t) => t === pt || q.src === pt).length, 0);
	assert.equal(second.routed, own, 'only the moved point\'s pairs');
	assert.equal(second.failed, 1, 'the failure comes from the cache');
	assert.equal(second.cached + second.routed, first.routed);
});

// The router stubbed, counting the pairs it is asked per band (0: the base walk).
function countingRouter(w) {
	const asked = {};
	const fn = (o) => {
		for (const q of o.queries) asked[q.level || 0] = (asked[q.level || 0] || 0) + q.targets.length;
		return fakeRouterBands(w, 1.5)(o);
	};
	fn.asked = asked;
	return fn;
}

test('walk cache: band walks routed with other zone levels are routed again, base walks come from the cache', async () => {
	const nav = navDir();
	const sim = tmpdir('walks-v2-');
	const first = countingRouter();
	await walks.buildWalks(ridge(world()), { navDir: nav, snap: null, cacheDir: sim, bands: [10], runQueries: first });
	assert.ok(first.asked[0] > 0 && first.asked[10] > 0);
	// The world rebuilt: Testvale's zone level changed (zone levels sent to the router differ).
	const w2 = ridge(world());
	w2.zoneMin = { ...w2.zoneMin, 99101: 3 };
	const second = countingRouter();
	const r = await walks.buildWalks(w2, { navDir: nav, snap: null, cacheDir: sim, bands: [10], runQueries: second });
	assert.equal(second.asked[0], undefined, 'base walks (no danger) from the cache');
	assert.equal(second.asked[10], first.asked[10], 'every band walk routed again');
	assert.equal(r.cached, first.asked[0]);
	// The same zone levels again: nothing routed.
	const third = countingRouter();
	await walks.buildWalks(w2, { navDir: nav, snap: null, cacheDir: sim, bands: [10], runQueries: third });
	assert.deepEqual(third.asked, {});
});

test('walk cache: pruned by place: a smaller run keeps a bigger run\'s walks, a moved point\'s walks go', async () => {
	const nav = navDir();
	const sim = tmpdir('walks-v2-');
	const file = path.join(sim, 'walkcache-horde.json');
	const read = () => {
		const c = JSON.parse(fs.readFileSync(file, 'utf8'));
		const by = {};
		for (let i = 0; i < c.pairs.length; i += 5) by[c.pairs[i + 2]] = (by[c.pairs[i + 2]] || 0) + 1;
		return { by, keys: new Set(c.keys.filter((k, i) => c.pairs.some((v, j) => j % 5 < 2 && v === i))) };
	};
	await walks.buildWalks(ridge(world()), { navDir: nav, snap: null, cacheDir: sim, bands: [10], runQueries: fakeRouterBands(null, 1.5) });
	const before = read().by;
	assert.ok(before[0] > 0 && before[10] > 0);
	// A smaller radius and no bands: it asks fewer pairs, every cached walk stays.
	const small = await walks.buildWalks(ridge(world()), { navDir: nav, snap: null, cacheDir: sim, bands: [], radius: 500, anchorRadius: 500, runQueries: fakeRouterBands(null, 1.5) });
	assert.equal(small.routed, 0);
	assert.ok(small.cached < before[0], 'the smaller run asks fewer pairs');
	assert.deepEqual(read().by, before, 'the bigger run\'s walks are kept');
	// The quest ender moved 50 yd: its old place's walks are dropped, its new place's routed.
	const moved = ridge(world());
	const pt = moved.quests.find((q) => q.id === 503).ender;
	const P = moved.points;
	const oldKey = `${P[pt][0]}:${Math.round(P[pt][2] / 2)}:${Math.round(P[pt][3] / 2)}:${P[pt][5] == null ? 'n' : Math.round(P[pt][5] / 2)}`;
	assert.ok(read().keys.has(oldKey));
	P[pt][2] += 50;
	const r = await walks.buildWalks(moved, { navDir: nav, snap: null, cacheDir: sim, bands: [10], runQueries: fakeRouterBands(null, 1.5) });
	assert.ok(r.routed > 0);
	const after = read();
	assert.ok(!after.keys.has(oldKey), 'the old place\'s walks are pruned');
	assert.deepEqual(after.by, before, 'its walks are replaced one for one');
});

test('attach gives v1 band 30 yards and M2 every band; yards are the router\'s × SMOOTH, costs as routed', async () => {
	const w = ridge(world());
	const nav = navDir();
	const sim = tmpdir('walks-v2-');
	const { doc } = await walks.buildWalks(w, { navDir: nav, snap: null, cacheDir: sim, bands: [10, 30], runQueries: fakeRouterBands(w, 1.5) });
	walks.writeWalks(sim, doc);
	walks.attachWalks(w, sim, { navDir: nav });
	assert.ok(w.walks instanceof Map && w.walks.size > 0);
	assert.ok(w.walkBands['10'] instanceof Map);
	const [k, v] = w.walkBands['10'].entries().next().value;
	assert.ok(Array.isArray(v) && v.length === 2 && Number.isFinite(k));
	assert.deepEqual(Object.keys(w.walkBands).sort(), ['0', '10', '30']);
	assert.equal(w.walks.size, w.walkBands['0'].size);
	assert.equal(walks.SMOOTH, 0.965);
	const NW = w.points.length;
	const p10 = doc.pairs['10'];
	assert.deepEqual(w.walkBands['10'].get(p10[0] * NW + p10[1]), [p10[2] * walks.SMOOTH, p10[3]], 'band walk: smoothed yards, routed cost');
	const cache = JSON.parse(fs.readFileSync(path.join(sim, 'walkcache-horde.json'), 'utf8'));
	const ka = cache.keys.indexOf(walks.keyOf(w.points, p10[0]));
	const kb = cache.keys.indexOf(walks.keyOf(w.points, p10[1]));
	const row = cache.pairs.findIndex((x, i) => i % 5 === 0 && ((x === ka && cache.pairs[i + 1] === kb) || (x === kb && cache.pairs[i + 1] === ka)) && cache.pairs[i + 2] === 10);
	assert.equal(cache.pairs[row + 3], p10[2], 'the cache keeps the router\'s yards');
});

test('attach: v1 walks are band 30\'s where it was re-routed, else the base walk', async () => {
	const w = ridge(world());
	const nav = navDir();
	const sim = tmpdir('walks-v2-');
	// Band 30 walks round the ridge: twice the base walk.
	const router = ({ queries }) => ({ results: queries.map((q) => {
		const yards = q.targets.map((t) => Math.hypot(t[0] - q.from[0], t[1] - q.from[1]) * (q.level === 30 ? 4 : 2));
		return { type: 'many', id: q.id, ok: true, yards, costs: yards };
	}) });
	const { doc } = await walks.buildWalks(w, { navDir: nav, snap: null, cacheDir: sim, bands: [30], runQueries: router });
	walks.writeWalks(sim, doc);
	walks.attachWalks(w, sim, { navDir: nav });
	const NW = w.points.length;
	const b30 = doc.pairs['30'];
	assert.ok(b30.length > 0);
	for (let i = 0; i < b30.length; i += 5) {
		assert.equal(w.walks.get(b30[i] * NW + b30[i + 1]), b30[i + 2] * walks.SMOOTH);
		assert.equal(w.walks.get(b30[i + 1] * NW + b30[i]), b30[i + 2] * walks.SMOOTH);
	}
	const base = doc.pairs['0'];
	const rerouted = new Set();
	for (let i = 0; i < b30.length; i += 5) rerouted.add(b30[i] * NW + b30[i + 1]);
	let plain = 0;
	for (let i = 0; i < base.length; i += 5) {
		if (rerouted.has(base[i] * NW + base[i + 1])) continue;
		assert.equal(w.walks.get(base[i] * NW + base[i + 1]), base[i + 2] * walks.SMOOTH);
		plain++;
	}
	assert.ok(plain > 0);
	assert.match(w.walksId, /:0-30:dz15$/);
});

test('attach: used on the world and walking maps it was built on, not on another', async () => {
	const w = world();
	const nav = navDir();
	const dir = tmpdir('sim-walks-');
	walks.writeWalks(dir, (await walks.buildWalks(w, { navDir: nav, snap: null, runQueries: fakeRouter(w, 2) })).doc);
	const notes = [];
	assert.ok(walks.attachWalks(w, dir, { navDir: nav, log: (m) => notes.push(m) }));
	assert.ok(w.walksId);
	const other = { ...world(), dataHash: 'another-world' };
	assert.equal(walks.attachWalks(other, dir, { navDir: nav, log: (m) => notes.push(m) }), null);
	assert.equal(other.walks, null);
	assert.equal(other.walkBands, null);
	assert.equal(walks.attachWalks(world(), dir, { navDir: navDir('rebuilt maps'), log: (m) => notes.push(m) }), null);
	assert.equal(walks.attachWalks(world(), tmpdir('sim-walks-none-'), { navDir: nav, log: (m) => notes.push(m) }), null);
	assert.match(notes.join('\n'), /another world/);
	assert.match(notes.join('\n'), /other walking maps/);
	assert.match(notes.join('\n'), /straight line × detour/);
});

test('attach: walks routed by other router code (Routing/, same maps) are not used', async () => {
	const w = world();
	const nav = navDir();
	const dir = tmpdir('sim-walks-');
	walks.writeWalks(dir, (await walks.buildWalks(w, { navDir: nav, snap: null, runQueries: fakeRouter(w, 2) })).doc);
	const edited = navDir();
	fs.mkdirSync(path.join(edited, 'Routing'));
	fs.writeFileSync(path.join(edited, 'Routing', 'Costs.lua'), '-- other costs\n');
	assert.ok(walks.attachWalks(world(), dir, { navDir: navDir() }), 'same maps and code');
	assert.equal(walks.attachWalks(world(), dir, { navDir: edited }), null);
});

test('travel: a routed walk costs the router\'s yards (× routeMul), the rest the straight line × detour', async () => {
	const w = world();
	const nav = navDir();
	const dir = tmpdir('sim-walks-');
	const plain = compileRun(w, { race: 'Orc' });
	const p = params();
	const { a, b } = wardenLeg(w, plain);
	const straight = new Travel(plain, makeTables(plain, p));
	const d = Math.hypot(plain.pX[a] - plain.pX[b], plain.pY[a] - plain.pY[b]);
	assert.ok(Math.abs(straight.leg(a, b, straight.base[0], false) - (d * p.detour1) / p.runSpeed) < 1e-3);

	// The router says the walk is 3x the straight line (a ridge in the way).
	walks.writeWalks(dir, (await walks.buildWalks(w, { navDir: nav, snap: null, runQueries: fakeRouter(w, 3) })).doc);
	walks.attachWalks(w, dir, { navDir: nav });
	const routed = compileRun(w, { race: 'Orc' });
	const r = wardenLeg(w, routed);
	const tr = new Travel(routed, makeTables(routed, p));
	const yd = w.walks.get(r.wa * w.points.length + r.wb);
	assert.ok(Math.abs(yd - d * 3 * walks.SMOOTH) < 1, `${yd} routed yards (× SMOOTH) for a ${d.toFixed(0)} yd line`);
	assert.ok(Math.abs(tr.leg(r.a, r.b, tr.base[0], false) - yd / p.runSpeed) < 1e-3);
	assert.ok(Math.abs(tr.leg(r.b, r.a, tr.base[0], false) - yd / p.runSpeed) < 1e-6, 'a pair is walked both ways');
	const slow = new Travel(routed, makeTables(routed, params({ routeMul: 1.1 })));
	assert.ok(Math.abs(slow.leg(r.a, r.b, slow.base[0], false) - (yd * 1.1) / p.runSpeed) < 1e-3);
});

test('a short line round a cliff is not a short walk', async () => {
	const w = world();
	const nav = navDir();
	const dir = tmpdir('sim-walks-');
	walks.writeWalks(dir, (await walks.buildWalks(w, { navDir: nav, snap: null, runQueries: fakeRouter(w, 50) })).doc);
	walks.attachWalks(w, dir, { navDir: nav });
	const run = compileRun(w, { race: 'Orc' });
	const p = params();
	const tr = new Travel(run, makeTables(run, p));
	const P = Array.from(run.ptList);
	// Two points under 400 yd apart: the straight line says walk, the router says 50x round.
	let pair = null;
	for (let i = 0; i < P.length && !pair; i++) {
		for (let j = i + 1; j < P.length; j++) {
			const d = Math.hypot(run.pX[i] - run.pX[j], run.pY[i] - run.pY[j]);
			if (d > 20 && d < 300 && run.pR[i] === run.pR[j] && w.walks.has(P[i] * w.points.length + P[j])) {
				pair = [i, j, d];
				break;
			}
		}
	}
	assert.ok(pair, 'a short pair in the synthetic world');
	const [i, j, d] = pair;
	assert.ok(Math.abs(tr.leg(i, j, tr.base[0], false) - (w.walks.get(P[i] * w.points.length + P[j]) * p.routeMul) / p.runSpeed) < 1e-3);
	assert.ok(tr.leg(i, j, tr.base[0], false) > (d * p.detour1 * 10) / p.runSpeed);
});

test('a search result replays only with the walks it was searched with', () => {
	const w = world();
	w.walksId = null;
	sim.assertFresh({ dataHash: 'test-world' }, w);
	w.walksId = 'abc:balanced:4000';
	assert.throws(() => sim.assertFresh({ dataHash: 'test-world' }, w), /without routed walks/);
	sim.assertFresh({ dataHash: 'test-world', walks: 'abc:balanced:4000' }, w);
	w.walksId = null;
	assert.throws(() => sim.assertFresh({ dataHash: 'test-world', walks: 'abc:balanced:4000' }, w), /with other routed walks/);
});

test('failed walks are classified; only unexplained ones count against the gate', () => {
	const w = world();
	const P = w.points;
	const [a, b, c] = [0, 1, 2].map((i) => i);
	const cache = new Map([
		[`${walks.keyOf(P, a)}|${walks.keyOf(P, b)}|30`, [-1, -1]],
		[`${walks.keyOf(P, a)}|${walks.keyOf(P, c)}|30`, [-1, -1]],
		[`${walks.keyOf(P, b)}|${walks.keyOf(P, c)}|30`, [500, 500]],
	]);
	const snap = (pt) => (pt === a ? { region: 1 } : pt === b ? { region: 2 } : { region: 1 });
	const r = walks.classifyFailures(w, cache, { band: 30, snap });
	assert.equal(r.total, 2);
	assert.equal(r.separate, 1);
	assert.equal(r.unknown, 1);
});

test('two ends of one city in different regions are unexplained; an end that does not snap is off the grid or lacks a height', () => {
	const w = world();
	const P = w.points.map((p) => p.slice());
	P[0][4] = P[1][4] = 1458;
	P[0][5] = 10;
	P[1][5] = 12;
	P[2][5] = null;
	P[3][5] = 5;
	const ww = { points: P };
	const k = (i) => walks.keyOf(P, i);
	const cache = new Map([
		[`${k(0)}|${k(1)}|0`, [-1, -1]],
		[`${k(0)}|${k(2)}|0`, [-1, -1]],
		[`${k(0)}|${k(3)}|0`, [-1, -1]],
	]);
	const snap = (pt) => (pt === 0 ? { region: 1 } : pt === 1 ? { region: 2 } : null);
	const r = walks.classifyFailures(ww, cache, { band: 0, snap, cityMaps: new Set([1458]) });
	assert.deepEqual([r.total, r.unknown, r.noHeight, r.offGrid, r.separate], [3, 1, 1, 1, 0]);
	assert.deepEqual(r.pairs.unknown, [[0, 1]]);
});

test('same-region failures: a lift either way, a climb the pack closes or no grid path one way is another region (a closed climb also a walk gap); any other grid walk is unexplained', () => {
	const w = world();
	const P = w.points;
	const k = (i) => walks.keyOf(P, i);
	const fail = (a, b) => [`${k(a)}|${k(b)}|0`, [-1, -1]];
	const cache = new Map([fail(0, 1), fail(0, 2), fail(0, 3), fail(0, 4), fail(0, 5), fail(0, 6)]);
	const snap = () => ({ region: 1 });
	const lift = { ok: true, byClass: { walk: 20, lift: 30, climb: 0 } };
	const walk = { ok: true, byClass: { walk: 50, lift: 0, fall: 2, climb: 0 } };
	const climb = { ok: true, byClass: { walk: 50, lift: 0, fall: 0, climb: 4 } };
	const none = { ok: false, reason: 'no path', byClass: null };
	// (from, to) -> the grid's route: 1 lift both ways, 2 lift one way and a walk back, 3 no path back,
	// 4 no path either way, 5 a walk both ways, 6 a fall down and a closed climb back up.
	const ways = {
		'0>1': lift, '1>0': lift, '0>2': lift, '2>0': walk, '0>3': walk, '3>0': none, '0>4': none, '4>0': none,
		'0>5': walk, '5>0': walk, '0>6': walk, '6>0': climb,
	};
	const asked = [];
	const route = (a, b) => (asked.push(`${a}>${b}`), ways[`${a}>${b}`]);
	const r = walks.classifyFailures(w, cache, { band: 0, snap, route });
	assert.deepEqual([r.total, r.separate, r.unknown], [6, 5, 1]);
	assert.deepEqual(r.pairs.separate.map(([, b]) => b).sort(), [1, 2, 3, 4, 6]);
	assert.deepEqual(r.pairs.unknown.map(([, b]) => b), [5]);
	assert.deepEqual(r.walkGap, [[0, 6]], 'only the closed climb is a walk gap');
	assert.ok(asked.includes('1>0') && asked.includes('5>0'), 'both directions asked');
	assert.equal(walks.classifyFailures(w, cache, { band: 0, snap }).unknown, 6, 'no route: unexplained, as before');
});

test('classifyFailuresParallel: same counts as the serial classify on mixed failures across cores', async () => {
	const w = world();
	const P = w.points;
	const k = (i) => walks.keyOf(P, i);
	const cache = new Map([
		[`${k(0)}|${k(1)}|0`, [-1, -1]], // regions 0 vs 1 → separate
		[`${k(0)}|${k(2)}|0`, [-1, -1]], // regions 0 vs 0 → same-region (needs routing)
		[`${k(1)}|${k(2)}|0`, [-1, -1]], // regions 1 vs 0 → separate
		[`${k(0)}|${k(3)}|0`, [-1, -1]], // pt 3 does not snap, P[3][5]==null → noHeight
	]);
	// Minimal snap objects that pass nav.route's ensureSnapped check (entry+tile present).
	const mkSnap = (region) => ({ region, c: 0, wx: 0, wy: 0, z: 0, tile: { col: 0, row: 0 }, cell: { i: 0, j: 0 }, layer: 0, entry: 0, flags: 0 });
	// pt 0 → region 0, pt 1 → region 1, pt 2 → region 0, pt 3 → null (no snap)
	const snap = (pt) => (pt === 0 ? mkSnap(0) : pt === 1 ? mkSnap(1) : pt === 2 ? mkSnap(0) : null);
	// Serial with route = ok:false: same-region pair (0,2) → !ok → separate.
	const serial = walks.classifyFailures(w, cache, { band: 0, snap, route: () => ({ ok: false, byClass: null }) });
	// Parallel with an empty navDir: nav unavailable → workers return ok:false → same result.
	const emptyDir = tmpdir('classify-parallel-nav-');
	const parallel = await walks.classifyFailuresParallel(w, cache, { band: 0, snap, navDir: emptyDir, workers: 4 });
	assert.deepEqual(
		[parallel.total, parallel.separate, parallel.noHeight, parallel.offGrid, parallel.unknown],
		[serial.total, serial.separate, serial.noHeight, serial.offGrid, serial.unknown],
		'parallel and serial produce identical counts',
	);
	assert.equal(parallel.walkGap.length, serial.walkGap.length);
});

// The router stubbed with heights: a walk down (from above its end) is `down` × the straight
// line, any other `up` × (cost = yards); `fail(from, to)` makes a walk unwalkable. Keeps every query.
function slopeRouter(down, up, fail = () => false) {
	const asked = [];
	const fn = ({ queries }) => ({
		results: queries.map((q) => {
			asked.push(q);
			const yards = q.targets.map((t) => (fail(q.from, t) ? -1 : Math.round(Math.hypot(t[0] - q.from[0], t[1] - q.from[1]) * (q.from[2] != null && t[2] != null && q.from[2] > t[2] ? down : up) * 10) / 10));
			return { type: 'many', id: q.id, ok: true, yards, costs: yards.slice() };
		}),
	});
	fn.asked = asked;
	return fn;
}

// The synthetic world with a base pair's ends 90 yd apart in height (hi above lo) and a third
// point exactly ONE_WAY_DZ below hi.
function slopes() {
	const w = world();
	const q = walks.walkQueries(w, { maps: new Set([1]) }).queries.find((x) => x.ids.length >= 2);
	const [hi, lo, near] = [q.src, q.ids[0], q.ids[1]];
	w.points[hi][5] = 100;
	w.points[lo][5] = 10;
	w.points[near][5] = 100 - walks.ONE_WAY_DZ;
	return { w, hi, lo, near };
}

const rowsOf = (arr) => Array.from({ length: arr.length / 5 }, (_, i) => arr.slice(i * 5, i * 5 + 5));

test('one-way walks: a pair whose ends differ by more than ONE_WAY_DZ in height is searched from both ends, each direction priced as walked', async () => {
	const { w, hi, lo, near } = slopes();
	const P = w.points;
	const NW = P.length;
	const nav = navDir();
	const sim = tmpdir('walks-oneway-');
	const router = slopeRouter(1, 3);
	const first = await walks.buildWalks(w, { navDir: nav, snap: null, cacheDir: sim, bands: [], runQueries: router });
	const at = (pt) => [P[pt][2], P[pt][3], P[pt][5]];
	const back = router.asked.filter((q) => q.id.startsWith('d'));
	assert.ok(back.some((q) => q.id === `d${lo}` && q.targets.some((t) => t.join() === at(hi).join())), 'the way back up is searched from its own start');
	assert.ok(!back.some((q) => q.id === `d${near}` && q.targets.some((t) => t.join() === at(hi).join())), 'ends ONE_WAY_DZ apart: one search');
	assert.ok(first.oneWay.pairs >= 1 && first.oneWay.searches === back.length && first.oneWay.directed >= 2);
	const rows = rowsOf(first.doc.pairs['0']);
	const d = Math.hypot(P[hi][2] - P[lo][2], P[hi][3] - P[lo][3]);
	const down = rows.find((r) => r[0] === hi && r[1] === lo);
	const up = rows.find((r) => r[0] === lo && r[1] === hi);
	assert.ok(down && Math.abs(down[2] - d) < 0.1 && down[4] === 1, 'down: one-way');
	assert.ok(up && Math.abs(up[2] - 3 * d) < 0.2 && up[4] === 1, 'back up: one-way');
	assert.equal(rows.find((r) => r[0] === hi && r[1] === near)[4], 0, 'a pair at one height walks both ways');
	assert.ok(!rows.some((r) => r[0] === near && r[1] === hi));
	// The lookup and attachWalks give each direction its own walk.
	const L = buildLookup(first.doc, NW);
	assert.ok(Math.abs(L.yd(hi, lo, 0) - down[2] * walks.SMOOTH) < 0.01);
	assert.ok(Math.abs(L.yd(lo, hi, 0) - up[2] * walks.SMOOTH) < 0.01);
	assert.ok(Math.abs(L.yd(lo, hi, 30) - up[2] * walks.SMOOTH) < 0.01, 'a band without the pair falls back to the base walk in its direction');
	walks.writeWalks(sim, first.doc);
	walks.attachWalks(w, sim, { navDir: nav });
	assert.equal(w.walks.get(hi * NW + lo), down[2] * walks.SMOOTH);
	assert.equal(w.walks.get(lo * NW + hi), up[2] * walks.SMOOTH);
	assert.deepEqual(w.walkBands['0'].get(lo * NW + hi), [up[2] * walks.SMOOTH, up[3]]);
	assert.equal(walks.walkYards(w, near, hi), walks.walkYards(w, hi, near));
	// The cache key's order is the search's direction: a rebuild routes nothing.
	const cache = walks.cachedWalks(sim, 'Horde');
	const k = (pt) => walks.keyOf(P, pt);
	assert.equal(cache.get(`${k(hi)}|${k(lo)}|0`)[0], down[2]);
	assert.equal(cache.get(`${k(lo)}|${k(hi)}|0`)[0], up[2]);
	const n = router.asked.length;
	const again = await walks.buildWalks(w, { navDir: nav, snap: null, cacheDir: sim, bands: [], runQueries: router });
	assert.equal(router.asked.length, n, 'nothing routed twice');
	assert.equal(again.cached, first.routed);
	assert.deepEqual(again.doc.pairs, first.doc.pairs);
});

test('one-way walks: two directions alike, or only one walkable, make one walk both ways', async () => {
	const { w, hi, lo } = slopes();
	const P = w.points;
	const nav = navDir();
	const pair = (doc) => rowsOf(doc.pairs['0']).filter((r) => (r[0] === hi && r[1] === lo) || (r[0] === lo && r[1] === hi));
	const alike = await walks.buildWalks(w, { navDir: nav, snap: null, bands: [], runQueries: slopeRouter(2, 2) });
	assert.equal(alike.oneWay.directed, 0);
	assert.deepEqual(pair(alike.doc).map((r) => [r[0], r[1], r[4]]), [[hi, lo, 0]]);
	// The climb back up is not walkable: the drop is the walk both ways (as a pair's one search was).
	const climb = (from, to) => from[2] === P[lo][5] && to[2] === P[hi][5];
	const drop = await walks.buildWalks(w, { navDir: nav, snap: null, bands: [], runQueries: slopeRouter(1, 3, climb) });
	const d = Math.hypot(P[hi][2] - P[lo][2], P[hi][3] - P[lo][3]);
	const [r] = pair(drop.doc);
	assert.ok(pair(drop.doc).length === 1 && r[0] === hi && r[1] === lo && r[4] === 0 && Math.abs(r[2] - d) < 0.1);
	// The drop is the search back (from lo, the later point): still the walk both ways.
	const fall = (from, to) => from[2] === P[hi][5] && to[2] === P[lo][5];
	const up = await walks.buildWalks(w, { navDir: nav, snap: null, bands: [], runQueries: slopeRouter(1, 3, fall) });
	const [u] = pair(up.doc);
	assert.ok(pair(up.doc).length === 1 && u[0] === hi && u[1] === lo && u[4] === 0 && Math.abs(u[2] - 3 * d) < 0.2);
});

// #579: a pair walked neither way whose ends differ by more than UNWALK_DZ (hi and
// lo, 90 yd: a cliff top and its foot) is listed unwalkable, and the lookup prices no
// walk on foot; one failed at a smaller height difference keeps the straight line.
test('unwalkable: a cliff pair walked neither way is listed, a level one is not', async () => {
	const { w, hi, lo, near } = slopes();
	const P = w.points;
	const nav = navDir();
	const both = (from, to) => (from[2] === P[lo][5] && to[2] === P[hi][5]) || (from[2] === P[hi][5] && to[2] === P[lo][5]) || (from[2] === P[near][5] && to[2] === P[hi][5]) || (from[2] === P[hi][5] && to[2] === P[near][5]);
	const { doc } = await walks.buildWalks(w, { navDir: nav, snap: null, bands: [], runQueries: slopeRouter(1, 3, both) });
	const listed = (a, b) => { for (let i = 0; i + 1 < doc.unwalkable.length; i += 2) if ((doc.unwalkable[i] === a && doc.unwalkable[i + 1] === b) || (doc.unwalkable[i] === b && doc.unwalkable[i + 1] === a)) return true; return false; };
	assert.ok(listed(hi, lo), 'the cliff pair');
	assert.ok(!listed(hi, near), 'a pair ONE_WAY_DZ apart is a gap, not a cliff');
	const L = buildLookup(doc, P.length);
	assert.equal(L.yd(lo, hi, 0), Infinity);
	assert.equal(L.yd(near, hi, 0), -1);
});

test('old walks documents (schema 2: pairs of 4, both ways) still load and price as before', async () => {
	const w = world();
	const nav = navDir();
	const dir = tmpdir('sim-walks-old-');
	const { doc } = await walks.buildWalks(w, { navDir: nav, snap: null, bands: [], runQueries: fakeRouter(w, 2) });
	walks.writeWalks(dir, doc);
	walks.attachWalks(w, dir, { navDir: nav });
	const now = new Map(w.walks);
	const old = { ...doc, schema: 2, pairs: { 0: rowsOf(doc.pairs['0']).flatMap((r) => r.slice(0, 4)) } };
	delete old.oneWayDz;
	assert.equal(walks.walksUsable(old, w, nav), null, 'schema 2 is usable');
	assert.equal(walks.pairStride(old), 4);
	walks.writeWalks(dir, old);
	walks.attachWalks(w, dir, { navDir: nav });
	assert.deepEqual(w.walks, now);
	assert.doesNotMatch(w.walksId, /:dz/, 'an old file keeps its walks id');
	const L = buildLookup(old, w.points.length);
	for (const [key, yd] of now) assert.ok(Math.abs(L.yd(Math.floor(key / w.points.length), key % w.points.length, 0) - yd) < 0.01);
	assert.match(walks.walksUsable({ ...old, schema: 1 }, w, nav), /schema 1/);
});
