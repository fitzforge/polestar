'use strict';
// Smooth routes (docs/legacy/SIMULATION-js.md "Objectives"): shared kill credit, the
// return penalties of the smooth objective and the 40-quest log. The world
// is invented (tests/fixtures/sim/synthetic.js): Elder Testa gives Rat
// Trouble (8 Burrow Rats) and Choice One (4 rats, same camp); Word to the
// Warden ends 1000 yd away in Farfield.

const { test } = require('node:test');
const assert = require('node:assert/strict');

const { buildWorld } = require('../tools/lib/sim/world');
const { compileRun, makeTables, K_ACCEPT, K_TASK, K_TURNIN } = require('../tools/lib/sim/run');
const { Evaluator } = require('../tools/lib/sim/evaluate');
const { effective, means } = require('../tools/lib/sim/params');
const syn = require('./fixtures/sim/synthetic');

function world(data = syn.makeData(), opts = {}) {
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START, ...opts });
	w.questXp = syn.questXpRows();
	return w;
}

function evaluator(objective = 'time', w = world()) {
	const run = compileRun(w, { race: 'Orc' });
	return new Evaluator(run, makeTables(run, means(effective({ calibrated: {} }, null, objective))));
}

// Quest helpers: index, giver, objective task and its point, ender.
function quest(ev, id) {
	const r = ev.run;
	const q = r.qIndex.get(id);
	const t = r.qTask0[q];
	return { q, giver: r.qGiver[q], task: t, site: t < r.qTask1[q] ? r.taskPt[t] : -1, ender: r.qEnder[q] };
}
const accept = (ev, x) => ev.step(K_ACCEPT, x.q, -1, x.giver);
const work = (ev, x) => ev.step(K_TASK, x.q, x.task, x.site);
const turnin = (ev, x) => ev.step(K_TURNIN, x.q, -1, x.ender);

// Seconds Choice One's objective takes after Rat Trouble's, both at the rat camp.
function choiceOneSeconds(ev, bothFirst) {
	const rats = quest(ev, 501);
	const choice = quest(ev, 506);
	ev.reset();
	accept(ev, rats);
	if (bothFirst) accept(ev, choice);
	work(ev, rats);
	if (!bothFirst) accept(ev, choice);
	const t0 = ev.time;
	work(ev, choice);
	assert.equal(ev.taskDone[choice.task], 1);
	return ev.time - t0;
}

test('shared kill credit: kills for one quest count for another active quest on the same mob camp', () => {
	const ev = evaluator();
	const alone = choiceOneSeconds(ev, false);
	assert.ok(alone > 0, 'Choice One needs its own 4 kills when taken after the rats were killed');
	assert.equal(ev.sharedKills, 0, 'kills before a quest is accepted give it nothing');
	const shared = choiceOneSeconds(ev, true);
	assert.equal(ev.sharedKills, 4, 'the 8 rats for Rat Trouble cover Choice One\'s 4');
	assert.equal(shared, 0, 'nothing left to kill, no trip');
	assert.ok(shared < alone);
});

test('shared kill credit: partial credit leaves only the rest, and is undone by restore()', () => {
	const data = syn.makeData();
	data.quests[506].objectives[0].count = 12; // more rats than Rat Trouble's 8
	const ev = evaluator('time', world(data));
	const rats = quest(ev, 501);
	const choice = quest(ev, 506);
	const w = ev.run.taskW0[choice.task];
	ev.reset();
	ev.journaling = true;
	accept(ev, rats);
	accept(ev, choice);
	const s = ev.snapshot();
	work(ev, rats);
	assert.equal(ev.killed[w], 8);
	assert.equal(ev.sharedKills, 8);
	ev.restore(s);
	assert.equal(ev.killed[w], 0);
	assert.equal(ev.sharedKills, 0);
	// Done in full after the credit: only 4 of the 12 are killed.
	work(ev, rats);
	const t0 = ev.time;
	work(ev, choice);
	const partial = ev.time - t0;
	ev.restore(s);
	const t1 = ev.time;
	work(ev, choice);
	const full = ev.time - t1;
	assert.ok(partial > 0 && partial < full / 2, `${partial} s for 4 of 12 vs ${full} s for all 12`);
});

// Rat Trouble and Word to the Warden, in two orders: done in one go, or off
// to Farfield first and back to the rats and Elder Testa (a zone return and
// a return to the Elder's spot).
function plan(ev, back) {
	const rats = quest(ev, 501);
	const word = quest(ev, 503);
	ev.reset();
	accept(ev, rats);
	accept(ev, word);
	if (back) turnin(ev, word);
	work(ev, rats);
	turnin(ev, rats);
	if (!back) turnin(ev, word);
	ev.finish();
	return { cost: ev.costNow(), seconds: ev.levelTimes[60], grind: ev.grindSec, zoneChanges: ev.zoneChanges, zoneReturns: ev.zoneReturns, spotReturns: ev.spotReturns };
}

test('return penalties: a route back to a zone and a spot already worked costs more under smooth, nothing extra under time', () => {
	for (const objective of ['time', 'smooth']) {
		const ev = evaluator(objective);
		const once = plan(ev, false);
		const back = plan(ev, true);
		assert.equal(once.zoneReturns, 0);
		assert.equal(once.spotReturns, 0);
		assert.equal(back.zoneReturns, 1);
		assert.equal(back.spotReturns, 1);
		const p = ev.p;
		const base = (x) => x.seconds + (p.grindWeight - 1) * x.grind + p.zoneChange * x.zoneChanges;
		if (objective === 'time') {
			assert.equal(p.zoneReturn, 0);
			assert.equal(p.spotReturn, 0);
			assert.equal(once.cost, base(once));
			assert.equal(back.cost, base(back));
		} else {
			assert.equal(once.cost, base(once));
			assert.equal(back.cost, base(back) + p.zoneReturn + p.spotReturn);
			assert.ok(back.cost - once.cost > base(back) - base(once));
		}
	}
});

test('wasted accepts: a quest taken and never handed in costs wastedAccept under smooth, nothing under time', () => {
	for (const objective of ['time', 'smooth']) {
		const ev = evaluator(objective);
		const rats = quest(ev, 501);
		const word = quest(ev, 503);
		const run = (handIn) => {
			ev.reset();
			accept(ev, rats);
			accept(ev, word);
			work(ev, rats);
			turnin(ev, rats);
			if (handIn) turnin(ev, word);
			ev.finish();
			return { cost: ev.costNow(), never: ev.neverTurnedIn(), seconds: ev.levelTimes[60], grind: ev.grindSec, zoneChanges: ev.zoneChanges, zoneReturns: ev.zoneReturns, spotReturns: ev.spotReturns };
		};
		const left = run(false);
		assert.equal(left.never, 1);
		assert.equal(run(true).never, 0);
		const p = ev.p;
		const base = left.seconds + (p.grindWeight - 1) * left.grind + p.zoneChange * left.zoneChanges + (p.zoneReturn || 0) * left.zoneReturns + (p.spotReturn || 0) * left.spotReturns;
		assert.equal(left.cost, base + (objective === 'smooth' ? p.wastedAccept : 0));
		if (objective === 'smooth') assert.ok(p.wastedAccept > 0);
	}
});

test('quest log 40: a hub with 41 quests splits into two packages, 40 stay one', () => {
	const hub = (n) => {
		const data = syn.makeData();
		// Testvale 1-5 already has six accepts at Elder Testa.
		for (let i = 0; i < n - 6; i++) {
			const id = 9000 + i;
			data.quests[id] = { ...data.quests[501], id, title: `Rat Count ${i}`, objectives: [{ type: 'kill', id: 10, count: 1 }] };
		}
		return world(data).packages.filter((p) => p.key.startsWith('Testvale 1-5')).map((p) => [p.key, p.steps.filter((s) => s[0] === K_ACCEPT).length]);
	};
	assert.deepEqual(hub(40), [['Testvale 1-5', 40]]);
	assert.deepEqual(hub(41), [['Testvale 1-5a', 40], ['Testvale 1-5b', 1]]);
	assert.equal(world().maxOpen, 40);
});

test('quest log: a full log defers an accept until a turn-in frees a slot, never above the cap', () => {
	const run = (cap) => {
		const ev = evaluator();
		ev.run.logCap = cap;
		return ev.evaluate([0, 1, 2]);
	};
	const free = run(40);
	const tight = run(2);
	assert.ok(free.logPeak > 2);
	assert.equal(tight.logPeak, 2);
	assert.ok(tight.logDeferred > 0, 'accepts waited for a slot');
	assert.equal(tight.questsDone, free.questsDone, 'and were taken within the package once one opened');
	assert.equal(tight.acceptedNeverTurnedIn, 0);
});

test('quest log: a full log skips an accept, or abandons a quest 6+ levels below the character (its progress lost)', () => {
	const ev = evaluator();
	ev.run.logCap = 2;
	const rats = quest(ev, 501); // level 2
	const pelts = quest(ev, 502); // level 4
	const word = quest(ev, 503);
	ev.reset();
	accept(ev, rats);
	accept(ev, pelts);
	work(ev, rats);
	accept(ev, word);
	assert.equal(ev.active[word.q], 0, 'level 1: nothing low enough to give up');
	assert.equal(ev.logSkipped, 1);
	ev.reset();
	accept(ev, rats);
	accept(ev, pelts);
	work(ev, rats);
	ev.level = 9; // Rat Trouble (2) is 7 below, Fox Pelts (4) 5
	accept(ev, word);
	assert.equal(ev.active[word.q], 1);
	assert.equal(ev.active[rats.q], 0, 'the lowest quest 6+ levels below goes');
	assert.equal(ev.active[pelts.q], 1);
	assert.equal(ev.taskDone[rats.task], 0, 'its objective must be done again');
	assert.equal(ev.logAbandoned, 1);
	assert.equal(ev.open, 2);
	assert.equal(ev.result().acceptedNeverTurnedIn, 3);
});

test('--param overrides apply after the objective, unknown keys fail, --tag keeps variants apart', () => {
	const { parseOverrides, tagName } = require('../tools/lib/sim/params');
	const sim = require('../tools/lib/sim');
	const over = parseOverrides(['grindWeight=6', 'zoneReturn=0']);
	const eff = effective({ calibrated: {} }, null, 'smooth', over);
	assert.deepEqual(eff.grindWeight, { mean: 6, sd: 0, lo: 6, hi: 6 });
	assert.equal(eff.zoneReturn.mean, 0);
	assert.equal(eff.spotReturn.mean, 900, 'the rest of the preset stays');
	assert.throws(() => parseOverrides(['grindWeigth=6']), /unknown parameter grindWeigth/);
	assert.throws(() => parseOverrides(['grindWeight=x']), /not a number/);
	assert.throws(() => tagName('a/b'), /--tag/);
	const files = [['time', null], ['smooth', null], ['smooth', 'g6'], ['time', 'g6']].map(([o, t]) => require('node:path').basename(sim.resultFile('/x', 'Horde', 'Orc', null, 'solo', o, t)));
	assert.deepEqual(files, ['horde-orc-any.json', 'horde-orc-any-smooth.json', 'horde-orc-any-smooth-g6.json', 'horde-orc-any-g6.json']);
});
