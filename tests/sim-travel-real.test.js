'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs } = require('./helpers/data');
const sim = require('../tools/lib/sim');
const { runQueries } = require('../tools/lib/nav/eval/run');
const walks = require('../tools/lib/sim/walks');

const NAV_DIR = path.join(__dirname, '..', 'addon', 'Polestar_Nav');

// The real-data travel cases (spec R19, R21): the sim's walks against the
// router, and the walks players reported. They need a sim dir with walks
// (POLESTAR_SIM_DIR, default the sim command's data/sim) and its calibrated params.json.
const SIM = process.env.POLESTAR_SIM_DIR || path.join(__dirname, '..', 'data', 'sim');
const DATA = needs('quests.json', 'npcs.json', 'travel.json', 'spawnz.json');
const NAV = !fs.existsSync(path.join(__dirname, '..', 'data', 'local', 'nav4', 'index.json')) && 'no walking grid: data/local/nav4/index.json is missing';
const noWalks = (f) => !fs.existsSync(path.join(SIM, `walks-${f}.json`)) && `no walks in ${SIM} (sim walks --faction ${f} --sim ${SIM})`;
const skip = DATA || noWalks('horde');
const skipA = DATA || noWalks('alliance');

const worlds = {};
const load = (faction) => (worlds[faction] ||= sim.loadWorld({ faction, simDir: SIM, offline: true }).then((r) => r.world));

// A fresh evaluator for `race` that knows the flight masters `fps` (fp() nodes).
function evFor(world, race, fps = []) {
	const { mean } = sim.paramsFor(SIM, null);
	const { run, ev } = sim.makeRun(world, { race, params: mean });
	ev.reset();
	for (const p of runPts(run, ...fps)) ev.learnAt(p);
	return { run, ev };
}
function fp(world, re) {
	const index = world.nodes.findIndex((n) => n.kind === 'fp' && re.test(n.name));
	if (index < 0) return undefined;
	const n = world.nodes[index];
	return { ...n, index, wx: world.points[n.pt][2], wy: world.points[n.pt][3] };
}
// A quest giver's or ender's world point, by the NPC's name.
function npcPt(world, name) {
	for (const q of world.quests) {
		if (q.gName === name) return q.giver;
		if (q.eName === name) return q.ender;
	}
	return undefined;
}
// The giver or ender point nearest to (x, y) map percent on map `map`.
function nearPt(world, map, x, y) {
	let best;
	let bd = Infinity;
	for (const q of world.quests) {
		for (const [pos, pt] of [[q.gPos, q.giver], [q.ePos, q.ender]]) {
			if (!pos || pos.map !== map || pt == null) continue;
			const d = Math.hypot(pos.x - x, pos.y - y);
			if (d < bd) [bd, best] = [d, pt];
		}
	}
	return bd < 3 ? best : undefined;
}
// A world point or a flight master node -> its run point (a node: the run
// point nearest to it that the run counts as at that flight master).
function runPts(run, ...pts) {
	const r = pts.map((p) => {
		if (p == null) return undefined;
		if (typeof p === 'number') return run.ptIndex.get(p);
		let best;
		let bd = Infinity;
		for (let i = 0; i < run.pFp.length; i++) {
			if (run.pFp[i] !== p.index) continue;
			const d = Math.hypot(run.pX[i] - p.wx, run.pY[i] - p.wy);
			if (d < bd) [bd, best] = [d, i];
		}
		return best;
	});
	assert.ok(r.every((p) => p != null), 'every end is a run point');
	return r;
}

// The sim's walk is its router's `many` yards × its smoothing (walks.js smoothOf): the build asks
// a one-to-many search (Lua FindMany, or the node router's routeMany: the cell path of the
// cost-best way), the arrow walks a drawn, smoothed line. So the walks agree with their router
// when each one is the router's `many` yards for its ends, sent as the build sends them (sendAt:
// the stored height, then the grid's for a pair it could not walk), to the stored 0.1 yd; and the
// smoothing is the drawn line's share of those yards when the sample's median route ÷ many lies
// within 1% of it. One pair's own share spreads (Lua: 0.92 to 1.00 on this sample, 2026-10-20;
// p10 0.94, p90 0.98), so a single walk can be 4% off its drawn line while the walks are exact;
// a per-pair bound would test that spread, not them.
test('sim walks are their router\'s many yards × its smoothing, and that is the median share of the drawn line, on a fixed sample', { skip: skip || NAV }, async () => {
	const world = await load('Horde');
	assert.ok(world.walkBands, `the walks in ${SIM} are not for this world and these walking maps (walks.js walksUsable): rerun sim walks`);
	const doc = walks.readWalks(SIM, 'Horde');
	const smooth = walks.smoothOf(doc);
	// The base band (no danger): every routed pair is in it, and the router
	// prices it the same way without a level.
	const band = world.walkBands['0'];
	const NW = world.points.length;
	const keys = [...band.keys()].filter((k) => Math.floor(k / NW) < k % NW).sort((x, y) => x - y);
	assert.ok(keys.length, 'the base band has walks');
	const sample = keys.filter((_, i) => i % Math.max(1, Math.floor(keys.length / 50)) === 0).slice(0, 50);
	const P = world.points;
	const snap = walks.gridSnap(world, walks.openGrid());
	// Pair i's drawn route and one-to-many search, its ends sent at their stored heights (full: the grid's).
	const ask = (full, list) => {
		const at = walks.sendAt(P, snap, full);
		return list.flatMap((i) => {
			const a = Math.floor(sample[i] / NW);
			const b = sample[i] % NW;
			const q = { map: P[a][0], from: at(a), profile: 'Horde', style: 'balanced' };
			return [{ ...q, type: 'route', id: `r${i}`, to: at(b), level: null }, { ...q, type: 'many', id: `m${i}`, targets: [at(b)] }];
		});
	};
	let run = (queries) => runQueries({ navDir: NAV_DIR, queries }).results;
	if (doc.router === 'node') {
		const router = require('../tools/lib/nav/router').open(walks.GRID_DIR, { zones: walks.zonesOf(world), fingerprint: false });
		const pt = (q, p) => ({ c: q.map, wx: p[0], wy: p[1], z: p[2] });
		run = (queries) => queries.map((q) => {
			if (q.type === 'many') return walks.nodeAnswer(router, q, world.zoneMin);
			const r = router.route(pt(q, q.from), pt(q, q.to), { faction: q.profile });
			return { id: q.id, ok: r.ok, reason: r.reason, yards: r.yards };
		});
	}
	const manyYd = (r) => (r && r.ok && typeof r.yards[0] === 'number' && r.yards[0] >= 0 ? r.yards[0] : null);
	const all = sample.map((_, i) => i);
	const got = new Map(run(ask(false, all)).map((r) => [r.id, r]));
	const retry = all.filter((i) => manyYd(got.get(`m${i}`)) == null);
	if (retry.length) for (const r of run(ask(true, retry))) got.set(r.id, r);
	const shares = [];
	for (const i of all) {
		const sy = band.get(sample[i])[0];
		const many = manyYd(got.get(`m${i}`));
		if (many == null) return assert.fail(`pair ${i}: the router could not walk a walk the sim has`);
		assert.ok(Math.abs(many * smooth - sy) <= 0.1, `pair ${i}: router ${many} yd × ${smooth}, sim ${sy.toFixed(1)} yd`);
		const r = got.get(`r${i}`);
		if (!r.ok) return assert.fail(`pair ${i}: the router walks it but could not draw it (${r.reason})`);
		shares.push(r.yards / many);
	}
	shares.sort((x, y) => x - y);
	const median = shares[Math.floor((shares.length - 1) / 2)];
	assert.ok(Math.abs(median - smooth) <= 0.01, `median route ÷ many ${median.toFixed(3)}, smoothing ${smooth}`);
});

test('R19: a Tauren at the Thunder Bluff flight master flies to Camp Taurajo, no lift or Mulgore leg', { skip }, async () => {
	const world = await load('Horde');
	const tb = fp(world, /Thunder Bluff/);
	const tj = fp(world, /Taurajo/);
	assert.ok(tb && tj, 'both flight masters are world nodes');
	const { run, ev } = evFor(world, 'Tauren', [tb, tj]);
	const [a, b] = runPts(run, tb, tj);
	const seconds = ev.travel.leg(a, b, ev.D, false, 30);
	assert.ok(Number.isFinite(seconds));
	assert.equal(ev.travel.lastMode, 1, 'network (a flight), not a walk');
});

test('R19: Varimathras to the Undercity flight master walks inside the city with the lifts', { skip, todo: 'blocked on #420: Royal Quarter unreachable in the packed maps' }, async () => {
	const world = await load('Horde');
	const v = npcPt(world, 'Varimathras');
	const uc = fp(world, /^Undercity$/);
	assert.ok(v != null && uc, 'Varimathras and the Undercity flight master are world points');
	const { run, ev } = evFor(world, 'Undead');
	const [a, b] = runPts(run, v, uc);
	const seconds = ev.travel.leg(a, b, ev.D, false, 30);
	assert.ok(Number.isFinite(seconds));
	assert.equal(ev.travel.lastMode, 0, 'a walk inside the city');
	assert.ok(run.walkRun && run.walkRun[a * ev.travel.NP + b] >= 0, 'the walk is a routed one (lifts), not a straight line');
});

test('R19: Kadrak to the Crossroads is a walk that crosses no dangerous Ashenvale zone', { skip }, async () => {
	const world = await load('Horde');
	const k = npcPt(world, 'Kadrak');
	const xr = fp(world, /^Crossroads$/);
	assert.ok(k != null && xr, 'Kadrak and the Crossroads flight master are world points');
	const { run, ev } = evFor(world, 'Orc');
	const [a, b] = runPts(run, k, xr);
	const seconds = ev.travel.leg(a, b, ev.D, false, 30);
	assert.ok(Number.isFinite(seconds));
	assert.equal(ev.travel.lastMode, 0, 'a walk');
	assert.equal(ev.travel.lastRisk, 0, 'no dangerous zone crossed');
});

test('R19: Stormwind Dwarven District to Ironforge takes the Deeprun Tram', { skip: skipA, todo: 'depends on #338 (the tram)' }, async () => {
	const world = await load('Alliance');
	const tram = world.rides.find((r) => /tram/i.test(String(r[4])));
	assert.ok(tram, 'the tram is a ride');
	const sw = nearPt(world, 1453, 63, 36);
	const ifp = fp(world, /Ironforge/);
	assert.ok(sw != null && ifp, 'a Dwarven District point and the Ironforge flight master');
	const { run, ev } = evFor(world, 'Human');
	const [a, b] = runPts(run, sw, ifp);
	const seconds = ev.travel.leg(a, b, ev.D, false, 30);
	assert.ok(Number.isFinite(seconds));
	assert.equal(ev.travel.lastMode, 1, 'network (the tram), not a walk');
	// The path is not exposed: bound the time by the tram's ride and wait plus
	// generous walks to and from its stops.
	const P = world.points;
	const [sa, sb] = [world.nodes[tram[0]].pt, world.nodes[tram[1]].pt];
	const yd = (p, q) => Math.hypot(P[p][2] - P[q][2], P[p][3] - P[q][3]);
	const walkTo = Math.min(yd(sw, sa) + yd(sb, ifp.pt), yd(sw, sb) + yd(sa, ifp.pt));
	assert.ok(seconds <= tram[2] + tram[3] + (3 * walkTo) / ev.travel.speed(false), `${seconds} s is more than the tram and its walks`);
});

test('R21 A1: Duskwood, Sven\'s camp to the Sentinel Hill flight master is a walk across the river', { skip: skipA, todo: 'zone crossings (#371, #421)' }, async () => {
	const world = await load('Alliance');
	const sven = npcPt(world, 'Sven Yorgen');
	const sh = fp(world, /Sentinel Hill/);
	assert.ok(sven != null && sh, 'Sven and the Sentinel Hill flight master are world points');
	const { run, ev } = evFor(world, 'Human', [sh]);
	const [a, b] = runPts(run, sven, sh);
	const seconds = ev.travel.leg(a, b, ev.D, false, 25);
	assert.ok(Number.isFinite(seconds));
	assert.equal(ev.travel.lastMode, 0, 'a walk, not hearth + flight');
	assert.ok(seconds <= (2 * 523) / ev.travel.speed(false), `${seconds} s is far more than a 523 yd walk`);
});

test('R21 A2: Eastvale to Darkshire walks over the Darkshire bridge, not through Redridge', { skip: skipA, todo: 'zone crossings (#371, #421)' }, async () => {
	const world = await load('Alliance');
	const ev0 = nearPt(world, 1429, 81, 66);
	const ds = fp(world, /Darkshire/);
	assert.ok(ev0 != null && ds, 'an Eastvale point and the Darkshire flight master');
	const { run, ev } = evFor(world, 'Human');
	const [a, b] = runPts(run, ev0, ds);
	const seconds = ev.travel.leg(a, b, ev.D, false, 20);
	assert.ok(Number.isFinite(seconds));
	assert.equal(ev.travel.lastMode, 0, 'a walk');
	assert.equal(ev.travel.lastRisk, 0, 'no dangerous zone (Redridge) crossed');
	const P = world.points;
	const straight = Math.hypot(P[ev0][2] - P[ds.pt][2], P[ev0][3] - P[ds.pt][3]);
	assert.ok(seconds <= (1.6 * straight) / ev.travel.speed(false), `${seconds} s: the walk detours (Redridge?)`);
});
