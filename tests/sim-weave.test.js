'use strict';
// sim weave (docs/SIMULATION.md, "Weave"): each dungeon tried at every place
// of a searched route, its best spot and what it saves, and the recommended set.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { buildWorld } = require('../tools/lib/sim/world');
const { effective, means } = require('../tools/lib/sim/params');
const { compileRun, makeTables } = require('../tools/lib/sim/run');
const { Evaluator } = require('../tools/lib/sim/evaluate');
const { weave } = require('../tools/lib/sim/weave');
const sim = require('../tools/lib/sim');
const syn = require('./fixtures/sim/synthetic');

function world() {
	const data = syn.makeData();
	data.dungeons = syn.dungeonsDoc();
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START });
	w.questXp = syn.questXpRows();
	return w;
}

async function searched(w, params) {
	return sim.runCharacter({ world: w, faction: 'Horde', race: 'Orc', paths: 400, workers: 1, write: false, benchMs: 0, params });
}

test('weave: every dungeon gets its best spot in the route and the time it saves or costs', async () => {
	const w = world();
	assert.equal(w.dungeons.length, 1);
	const params = { ...means(effective({ calibrated: {} })), gateGap: 10 };
	const res = await searched(w, params);
	const out = weave({ world: w, res, cls: null, params });
	assert.equal(out.dungeons.length, 1);
	const d = out.dungeons[0];
	assert.equal(d.name, 'Test Hollow');
	assert.ok(d.at >= 0 && d.at <= res.best.route.length);
	assert.ok(Number.isFinite(d.seconds));
	// The delta is the woven route's time to 60 against the route alone, both
	// replayed in the dungeon family.
	const run = compileRun(w, { race: 'Orc', cls: null, family: 'dungeons' });
	const ev = new Evaluator(run, makeTables(run, params), { catchUp: true });
	const base = sim.routeFromKeys(run, res.best.route);
	assert.equal(out.base, ev.evaluate(base).seconds);
	const dk = run.packages.findIndex((p) => p.key === d.key);
	assert.equal(d.seconds, ev.evaluate([...base.slice(0, d.at), dk, ...base.slice(d.at)]).seconds);
	assert.equal(d.delta, d.seconds - out.base);
	// The recommended set holds exactly the dungeons that save time.
	assert.deepEqual(out.chosen.map((c) => c.name), d.delta < -1 ? ['Test Hollow'] : []);
	assert.ok(out.seconds <= out.base);
});

test('weave: a dungeon that costs time is not recommended', async () => {
	const w = world();
	// A clear that takes hours and gives no trash XP never pays.
	const params = { ...means(effective({ calibrated: {} })), gateGap: 10, dungeonRunLow: 600, dungeonRunHigh: 600, dungeonTrash: 0 };
	const res = await searched(w, params);
	const out = weave({ world: w, res, cls: null, params });
	assert.ok(out.dungeons[0].delta > 0);
	assert.deepEqual(out.chosen, []);
	assert.equal(out.seconds, out.base);
});

test('weave uncertainty: each placed dungeon under parameter draws, with its interval, share of draws that save time and drivers', async () => {
	const { uncertainty } = require('../tools/lib/sim/weave');
	const w = world();
	const params = { ...means(effective({ calibrated: {} })), gateGap: 10 };
	const res = await searched(w, params);
	res.priors = effective({ calibrated: {} });
	const out = weave({ world: w, res, cls: null, params });
	const u = uncertainty({ world: w, res, cls: null, dungeons: out.dungeons, k: 20, seed: 3 });
	assert.equal(u.length, out.dungeons.filter((d) => d.at >= 0).length);
	for (const x of u) {
		assert.ok(x.saves >= 0 && x.saves <= 1);
		assert.ok(x.p5 <= x.p95);
		assert.ok(x.drivers.length <= 3);
	}
	// Same seed, same numbers.
	assert.deepEqual(uncertainty({ world: w, res, cls: null, dungeons: out.dungeons, k: 20, seed: 3 }), u);
});
