'use strict';
// Route simulator (docs/SIMULATION.md): model formulas, evaluator rules,
// search on a small synthetic world, calibration parsing and worker
// parallelism. The world is invented (tests/fixtures/sim/synthetic.js).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const xp = require('../tools/lib/game/xp');
const { buildWorld } = require('../tools/lib/sim/world');
const { compileRun, makeTables, K_ACCEPT } = require('../tools/lib/sim/run');
const { Evaluator, MAX_VISITS } = require('../tools/lib/sim/evaluate');
const { anneal, construct, converged } = require('../tools/lib/sim/search');
const { Rng } = require('../tools/lib/sim/rng');
const { PRIORS, effective, means, draws } = require('../tools/lib/sim/params');
const { compileSequence } = require('../tools/lib/sim/sequence');
const { parseForeverXp, ratioFit } = require('../tools/lib/sim/calibrate');
const { analyze, spearman } = require('../tools/lib/sim/robust');
const sim = require('../tools/lib/sim');
const syn = require('./fixtures/sim/synthetic');
const { tmpdir } = require('./helpers/tmp');

function world(opts = {}) {
	const w = buildWorld(syn.makeData(), { faction: 'Horde', bandWidth: opts.band || 5, extraStarts: syn.START });
	w.questXp = syn.questXpRows();
	return w;
}

function params(over = {}) {
	return { ...means(effective({ calibrated: {} })), ...over };
}

// opts.rules === false: no route rules (home first, away below 10), for
// tests of other rules on single packages.
function setup(opts = {}) {
	const w = opts.world || world(opts);
	const run = compileRun(w, { race: opts.race || 'Orc', cls: opts.cls || null, family: opts.family || 'solo' });
	if (opts.rules === false) {
		run.homeCount = 0;
		run.pkgHome.fill(0);
		run.pkgAway.fill(0);
	}
	const p = params(opts.params);
	return { w, run, p, ev: new Evaluator(run, makeTables(run, p), { catchUp: !!opts.catchUp }) };
}

function rulesWorld() {
	const w = buildWorld(syn.makeRulesData(), { faction: 'Horde', bandWidth: 5, extraStarts: syn.RULES_START });
	w.questXp = syn.questXpRows();
	return w;
}

const pkg = (run, key) => {
	const i = run.packages.findIndex((p) => p.key === key);
	assert.ok(i >= 0, `package ${key} in ${run.packages.map((p) => p.key).join(', ')}`);
	return i;
};

// ---------------------------------------------------------------- formulas

test('quest XP reduction steps: 100% to +5, then 80/60/40/20/10%', () => {
	const share = (d) => xp.questXpShare(10 + d, 10);
	assert.deepEqual([-3, 0, 5, 6, 7, 8, 9, 10, 15].map(share), [1, 1, 1, 0.8, 0.6, 0.4, 0.2, 0.1, 0.1]);
	assert.equal(xp.questXpAt(1000, 17, 10), 600);
});

test('mob XP: 45 + 5L at equal level, +5%/level above (max 4), zero-difference below, grey nothing, elites x2', () => {
	assert.equal(xp.mobXp(10, 10), 95);
	assert.equal(xp.mobXp(1, 1), 50);
	assert.equal(xp.mobXp(10, 12), Math.round(95 * 1.1));
	assert.equal(xp.mobXp(10, 20), Math.round(95 * 1.2)); // capped at +4 levels
	// zero difference at 10 is 7: one level below = 95 * (1 - 1/7)
	assert.equal(xp.zeroDiff(10), 7);
	assert.equal(xp.mobXp(10, 9), Math.round(95 * (6 / 7)));
	assert.equal(xp.greyLevel(10), 4);
	assert.equal(xp.mobXp(10, 4), 0);
	assert.equal(xp.mobXp(10, 5), Math.round(95 * (1 - 5 / 7)));
	assert.equal(xp.greyLevel(5), 0);
	assert.equal(xp.mobXp(40, 31), 0); // grey at 40: 40 - 8 - 1 = 31
	assert.equal(xp.mobXp(10, 10, true), 190);
});

test('XP table: Classic values, 60 levels, cumulative', () => {
	assert.equal(xp.LEVEL_XP.length, 60);
	assert.equal(xp.LEVEL_XP[1], 400);
	assert.equal(xp.LEVEL_XP[59], 209800);
	assert.equal(xp.CUM_XP[2], 400);
	assert.equal(xp.CUM_XP[60], xp.LEVEL_XP.reduce((a, b) => a + b, 0));
});

test('QuestXP table parses the DB2 CSV layout', () => {
	const rows = xp.parseQuestXp(syn.questXpCsv());
	assert.deepEqual(rows[10], [0, 100, 200, 400, 600, 800, 1000, 1200, 0, 0]);
});

// ---------------------------------------------------------------- world

test('world: quests, tasks by site, packages by zone and band, breadcrumb turn-in in the other zone', () => {
	const w = world();
	assert.deepEqual(w.quests.map((q) => q.id).sort(), [501, 502, 503, 504, 505, 506, 507, 508, 601]);
	const fox = w.quests.find((q) => q.id === 502);
	assert.equal(fox.tasks.length, 1);
	const [kind, level, kills] = fox.tasks[0].work[0];
	assert.equal(kind, 'kill');
	assert.equal(level, 4);
	assert.equal(kills, 10); // 5 pelts at 50%
	const keys = w.packages.map((p) => p.key).sort();
	assert.deepEqual(keys, ['Dungeon: Test Hollow', 'Farfield 1-5', 'Farfield 6-10', 'Testvale 1-5']);
	const far = w.packages.find((p) => p.key === 'Farfield 1-5');
	assert.deepEqual(far.quests, [503]); // the breadcrumb's turn-in lives with its zone
	// Exclusive quests: each lists the other (pfQuest `close` is symmetric).
	assert.deepEqual(w.quests.find((q) => q.id === 506).excl, [507]);
	assert.deepEqual(w.quests.find((q) => q.id === 507).excl, [506]);
});

test('`next` implies an any-of prerequisite over every quest that leads there, only for a quest without prerequisite data (regression: 5093/5094/5095 -> 5096)', () => {
	// Three breadcrumbs (no objectives) from the elder to the warden, each
	// with next = 804; 804 itself records no prerequisite.
	const data = syn.makeData();
	const base = data.quests[503];
	for (const id of [801, 802, 803]) data.quests[id] = { ...base, id, title: `Lead ${id}`, next: 804 };
	data.quests[804] = { ...data.quests[504], id: 804, title: 'Warden Chain', pre: [] };
	const build = (d) => {
		const w = buildWorld(d, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START });
		w.questXp = syn.questXpRows();
		return w;
	};
	const w = build(data);
	const q = w.quests.find((x) => x.id === 804);
	assert.equal(q.preRule, 'next');
	assert.deepEqual(q.pre, [801, 802, 803]);
	// Any one of them opens it: only 803 done.
	const { run, ev } = setup({ world: w, rules: false, params: { gateGap: 10 } });
	ev.reset();
	ev.done[run.qIndex.get(803)] = 1;
	assert.equal(ev.prereqOk(run.qIndex.get(804)), true);
	ev.done[run.qIndex.get(803)] = 0;
	assert.equal(ev.prereqOk(run.qIndex.get(804)), false);
	// Questie's breadcrumb list is prerequisite data: they never block, and
	// nothing is implied.
	const d2 = JSON.parse(JSON.stringify(data));
	d2.quests[804].pre = [801, 802, 803];
	d2.quests[804].breadcrumbs = [801, 802, 803];
	const q2 = build(d2).quests.find((x) => x.id === 804);
	assert.equal(q2.preRule, 'canonical');
	assert.deepEqual(q2.pre, []);
	const d3 = JSON.parse(JSON.stringify(data));
	d3.quests[804].breadcrumbs = [801];
	assert.deepEqual(build(d3).quests.find((x) => x.id === 804).pre, []);
});

test('a spawn recorded on two overlapping zone maps counts once, in the zone its neighbourhood is recorded on (regression: Lazy Peons in The Barrens 1-5)', () => {
	// Bigmap's frame covers Testvale and Farfield, the way the Barrens map
	// covers Durotar. Two of the twelve Burrow Rats are recorded again on
	// Bigmap, where they lie further from the map's edge than on Testvale.
	const BIG = 99109;
	const data = syn.makeData();
	data.zones[BIG] = { id: BIG, name: 'Bigmap', areaId: null, parent: null, type: 3 };
	const big = { c: 1, left: 500, right: -2500, top: 1500, bottom: -500 };
	data['map-frames'].era[BIG] = big;
	const vale = data['map-frames'].era[syn.VALE];
	const onBig = ([x, y]) => {
		const wy = vale.left + ((vale.right - vale.left) * x) / 100;
		const wx = vale.top + ((vale.bottom - vale.top) * y) / 100;
		return [((wy - big.left) * 100) / (big.right - big.left), ((wx - big.top) * 100) / (big.bottom - big.top)];
	};
	data.npcs[10].spawns[BIG] = { f: 'e', pts: data.npcs[10].spawns[syn.VALE].pts.slice(0, 2).map(onBig) };
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START });
	const zonesOf = (id) => w.packages.filter((p) => p.steps.some((s) => s[1] === id)).map((p) => p.zoneName);
	assert.deepEqual(zonesOf(501), ['Testvale']);
});

test('a quest giver standing in several places is met at the site nearest the turn-in (regression: Call of Earth 1518 in Mulgore)', () => {
	const data = syn.makeData();
	// Two spawns in Testvale (the bigger site), one in Farfield next to the warden.
	data.npcs[6] = { id: 6, name: 'Wandering Herald', level: 10, faction: 'AH', spawns: { [syn.VALE]: { f: 'e', pts: [[80, 50], [81, 50]] }, [syn.FIELD]: { f: 'e', pts: [[45, 50]] } } };
	data.quests[509] = { ...data.quests[503], id: 509, title: "Herald's Errand", start: { npc: [6], object: [], item: [] }, end: { npc: [2], object: [] }, zone: syn.FIELD };
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START });
	const accept = w.packages.filter((p) => p.steps.some((s) => s[0] === 0 && s[1] === 509)).map((p) => p.zoneName);
	assert.deepEqual(accept, ['Farfield']);
});

test('evaluation is a pure function of (world, route, params): races A, B, A in one process, any evaluation history', () => {
	const w = rulesWorld();
	const routeOf = (run) => [...Array(run.P).keys()].sort((a, b) => run.pkgHome[b] - run.pkgHome[a] || a - b);
	const evalRace = (race) => {
		const { run, ev } = setup({ world: w, race });
		return ev.evaluate(routeOf(run), { detail: true });
	};
	const a1 = evalRace('Orc');
	const b = evalRace('Skyborne');
	const a2 = evalRace('Orc');
	assert.deepEqual(a2, a1);
	assert.notDeepEqual(b.seconds, a1.seconds);
	// Same evaluator after other routes (other learning orders) = fresh one.
	const { run, ev } = setup({ world: w });
	const route = routeOf(run);
	const fresh = ev.cost(route);
	for (let i = 0; i < 5; i++) construct(ev, new Rng(i), { tau: 0.3 });
	assert.equal(ev.cost(route), fresh);
	assert.equal(JSON.stringify(world().quests), JSON.stringify(world().quests), 'building a world does not mutate shared data');
});

test('run: class quests only for their class; "any" keeps quests open to 5+ classes', () => {
	assert.equal(setup().run.qIndex.has(508), false);
	assert.equal(setup({ cls: 'Mage' }).run.qIndex.has(508), true);
	assert.equal(setup({ cls: 'Warrior' }).run.qIndex.has(508), false);
});

// ---------------------------------------------------------------- evaluator

test('evaluator is deterministic for given params', () => {
	const { run, ev } = setup();
	const route = [pkg(run, 'Testvale 1-5'), pkg(run, 'Farfield 1-5'), pkg(run, 'Farfield 6-10')];
	const a = ev.evaluate(route, { detail: true });
	const b = ev.evaluate(route, { detail: true });
	assert.deepEqual(a, b);
	const { ev: ev2 } = setup();
	assert.deepEqual(ev2.evaluate(route, { detail: true }), a);
	assert.ok(a.feasible);
	assert.equal(a.levelTimes[60], a.seconds);
	assert.ok(a.timeTo[10] > 0 && a.timeTo[10] < a.timeTo[20]);
	assert.ok(a.xpSplit.quest > 0 && a.xpSplit.kill > 0 && a.xpSplit.grind > 0);
});

test('route cost counts every hour of grinding grindWeight times and every move into another zone zoneChange seconds; reported times stay real', () => {
	const route = (run) => [pkg(run, 'Testvale 1-5'), pkg(run, 'Farfield 1-5'), pkg(run, 'Farfield 6-10')];
	const plain = setup({ params: { grindWeight: 1, zoneChange: 0 } });
	const r = plain.ev.evaluate(route(plain.run));
	assert.ok(r.grindSeconds > 0, 'the route grinds (to 60 after its last package)');
	assert.ok(r.zoneChanges >= 1, 'Testvale -> Farfield is a zone change');
	assert.equal(plain.ev.cost(route(plain.run)), r.seconds);
	const weighted = setup({ params: { grindWeight: 3, zoneChange: 600 } });
	const w = weighted.ev.evaluate(route(weighted.run));
	assert.equal(w.seconds, r.seconds, 'the policies change no reported time');
	assert.equal(w.zoneChanges, r.zoneChanges);
	assert.equal(weighted.ev.cost(route(weighted.run)), r.seconds + 2 * r.grindSeconds + 600 * r.zoneChanges);
});

test('feasibility: a package runs up to MAX_VISITS times and a return does what opened since; a home package runs once (regression: chains that leave a zone and come back)', () => {
	const data = syn.makeData();
	const base = data.quests[501];
	// Elder -> warden (Farfield) -> elder again.
	data.quests[711] = { ...base, id: 711, title: 'Rats First', level: 2, minLevel: 1, objectives: [{ type: 'kill', id: 10, count: 4 }] };
	data.quests[712] = { ...data.quests[503], id: 712, title: 'Tell the Warden', level: 3, minLevel: 1, start: { npc: [2], object: [], item: [] }, end: { npc: [2], object: [] }, pre: [711], zone: syn.FIELD };
	data.quests[713] = { ...base, id: 713, title: 'Back to the Elder', level: 3, minLevel: 1, objectives: [{ type: 'kill', id: 10, count: 4 }], pre: [712] };
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START });
	w.questXp = syn.questXpRows();
	const { run, ev } = setup({ world: w, rules: false, params: { gateGap: 10 } });
	const vale = pkg(run, 'Testvale 1-5');
	const field = pkg(run, 'Farfield 1-5');
	const back = run.qIndex.get(713);
	assert.equal(ev.evaluate([vale, field]).feasible, true);
	assert.equal(ev.done[back], 0, 'Back to the Elder is not offered on the first visit');
	const twice = ev.evaluate([vale, field, vale]);
	assert.equal(twice.feasible, true);
	assert.equal(ev.done[back], 1, 'the return picks it up');
	assert.equal(ev.evaluate([vale, field, vale, field, vale]).feasible, true);
	assert.equal(MAX_VISITS, 3);
	const fourth = ev.evaluate([vale, field, vale, field, vale, vale]);
	assert.equal(fourth.feasible, false);
	assert.equal(fourth.seconds, Infinity);
	const homed = setup({ world: w });
	assert.equal(homed.run.pkgHome[vale], 1);
	assert.equal(homed.ev.evaluate([vale, vale]).feasible, false);
});

test('consensus: a suffix package the prefix ran is that same visit once, then a return; up to MAX_VISITS runs; home packages once', () => {
	const { entries } = require('../tools/lib/sim/consensus');
	const c = { prefix: ['Home', 'Field'], idx: new Map([['Home', 0], ['Field', 1], ['Ridge', 2]]), run: { pkgHome: [1, 0, 0] } };
	const suffix = ['Field', 'Ridge', 'Field', 'Home', 'Ridge', 'Ridge', 'Ridge', 'Elsewhere'];
	assert.deepEqual(entries(c, suffix), [
		[0, -1], [1, -1], // prefix
		[2, 1], // Ridge
		[1, 2], // Field again: a return (its first suffix entry is the prefix visit)
		[2, 4], [2, 5], // Ridge twice more; a fourth run and the home package are left out
	]);
});

test('feasibility: a prerequisite done later does not count; exclusive quests only once', () => {
	const { run, ev } = setup({ params: { gateGap: 10 }, rules: false });
	const vale = pkg(run, 'Testvale 1-5');
	const far6 = pkg(run, 'Farfield 6-10');
	const done = (route) => {
		const r = ev.evaluate(route, { detail: true });
		return r.perPackage.reduce((s, x) => s + x.quests, 0);
	};
	// 504 and 505 share a package (chain); 505 needs 504: both done (grinding the gaps).
	ev.evaluate([far6]);
	assert.equal(ev.done[run.qIndex.get(504)], 1);
	assert.equal(ev.done[run.qIndex.get(505)], 1);
	// Testvale: 501, 502, one of 506/507, and 503 accepted (turned in elsewhere).
	ev.evaluate([vale]);
	assert.equal(ev.done[run.qIndex.get(506)] + ev.done[run.qIndex.get(507)], 1);
	assert.equal(ev.active[run.qIndex.get(503)], 1);
	assert.equal(done([vale]), 3);
	// The breadcrumb turn-in package before its accept: nothing to turn in.
	const far1 = pkg(run, 'Farfield 1-5');
	assert.equal(done([far1, vale]), 3);
	assert.equal(done([vale, far1]), 4);
});

test('level gate: below minLevel within the gap the character grinds first (counted); robustness catches up a package above the gate', () => {
	const { run, ev } = setup({ params: { gateGap: 10 }, rules: false });
	const far6 = pkg(run, 'Farfield 6-10');
	const r = ev.evaluate([far6], { detail: true });
	assert.ok(r.perPackage[0].grind > 0, 'grind before the level 5 quest');
	assert.ok(r.perPackage[0].levelIn < 5 && r.perPackage[0].levelOut >= 5);
	assert.equal(r.perPackage[0].catchUp, 0);
	// With the default gap (2 levels) a level-1 character cannot take them yet.
	const { run: run2, ev: ev2 } = setup({ rules: false });
	const r2 = ev2.evaluate([pkg(run2, 'Farfield 6-10')], { detail: true });
	assert.equal(r2.perPackage[0].quests, 0);
	// Followed as a plan (robustness): nothing in the package is available,
	// so the character grinds to the gate (level 3 for the minLevel-5 quest)
	// and runs the package then.
	const { run: run3, ev: ev3 } = setup({ rules: false, catchUp: true });
	const r3 = ev3.evaluate([pkg(run3, 'Farfield 6-10')], { detail: true });
	assert.ok(r3.perPackage[0].catchUp > 0);
	assert.equal(r3.perPackage[0].quests, 2);
	assert.equal(r3.catchUpSeconds, r3.perPackage[0].catchUp);
});

test('a deferred accept is taken as soon as the level allows, in the same walk (regression: Orc to Razor Hill at 2, then back into the valley)', () => {
	const { run, ev } = setup({ rules: false });
	const fox = run.qIndex.get(502); // Fox Pelts: minimum level 2, offered with the level-1 quests
	assert.ok(run.qMinLevel[fox] > 1);
	const events = [];
	ev.hook = (k, q) => events.push({ k, q, level: ev.level });
	ev.evaluate([pkg(run, 'Testvale 1-5')]);
	ev.hook = null;
	const up = events.findIndex((e) => e.level >= run.qMinLevel[fox]);
	const accept = events.findIndex((e) => e.k === K_ACCEPT && e.q === fox);
	assert.ok(up >= 0 && accept > up, `level ${run.qMinLevel[fox]} at step ${up}, Fox Pelts accepted at step ${accept}`);
	assert.equal(accept, up + 1, 'taken right after the step that reached its level, not after the rest of the tour');
});

test('a quest taken late does the objectives and follow-ups the tour already passed right away, not in a second pass from the end of the tour (regression: Encroachment, Thazz\'ril\'s Pick)', () => {
	const data = syn.makeData();
	// Fox Pelts (minimum level 2) leads to Fox Tails at the same elder; the
	// tour passes the foxes and the elder before the rats bring level 2.
	data.quests[510] = { ...data.quests[502], id: 510, title: 'Fox Tails', pre: [502], minLevel: 1 };
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START });
	w.questXp = syn.questXpRows();
	const { run, ev } = setup({ world: w, rules: false });
	const late = [];
	ev.hook = (k, q) => {
		if (!ev.defer) late.push(`${k}:${run.quests[q].title}`);
	};
	const r = ev.evaluate([pkg(run, 'Testvale 1-5')]);
	ev.hook = null;
	assert.equal(ev.done[run.qIndex.get(510)], 1, 'Fox Tails done');
	assert.ok(r.questsDone >= 3);
	assert.deepEqual(late, [], 'nothing left for a second pass');
});

test('trial moves undo exactly (journal)', () => {
	const { run, ev } = setup();
	ev.reset();
	ev.journaling = true;
	ev.runPackage(pkg(run, 'Testvale 1-5'));
	const s = ev.snapshot();
	const before = [ev.done.slice(), ev.active.slice(), ev.taskDone.slice(), ev.usedPkg.slice()];
	ev.runPackage(pkg(run, 'Farfield 1-5'));
	ev.runPackage(pkg(run, 'Farfield 6-10'));
	ev.restore(s);
	assert.deepEqual([ev.done, ev.active, ev.taskDone, ev.usedPkg], before);
	assert.equal(ev.time, s.time);
});

test('sequences: guide events replay with the same rules', () => {
	const { run, ev } = setup();
	const seq = compileSequence(run, [
		{ t: 'accept', q: 501 }, { t: 'turnin', q: 501 }, { t: 'accept', q: 503 }, { t: 'turnin', q: 503 },
		{ t: 'level', level: 6, xp: 0 }, { t: 'accept', q: 999 },
	]);
	assert.deepEqual(seq.unknown, [999]);
	const r = ev.evaluateSequence(seq, { honorCheckpoints: true });
	assert.equal(r.questsDone, 2);
	assert.ok(r.levelTimes[6] > 0);
});

test('dungeons: only in the dungeon family; a run gives party-shared elite XP and completes its quests', () => {
	const solo = setup();
	assert.equal(solo.run.packages.some((p) => p.key.startsWith('Dungeon:')), false);
	assert.equal(solo.run.qIndex.has(601), false);
	const { run, ev, p } = setup({ family: 'dungeons', params: { gateGap: 10 }, rules: false });
	const d = pkg(run, 'Dungeon: Test Hollow');
	const r = ev.evaluate([pkg(run, 'Farfield 6-10'), d], { detail: true });
	assert.equal(r.dungeonsRun, 1);
	assert.equal(ev.done[run.qIndex.get(601)], 1);
	const rec = r.perPackage[1];
	assert.ok(rec.dungeon >= (p.dungeonFormUp + p.dungeonRunLow) * 60 - 1e-6);
	assert.ok(r.xpDungeon > 0);
	// A sequence turning the quest in runs the dungeon first.
	const seq = compileSequence(run, [{ t: 'accept', q: 601 }, { t: 'turnin', q: 601 }]);
	assert.deepEqual(Array.from(seq.kind), [0, 4, 2]);
});

// ---------------------------------------------------------------- starts and travel safety

test('Zephras Isle is Skyborne-only: its quests are closed to other races, its exit is one way', () => {
	const w = rulesWorld();
	const orc = setup({ world: w });
	const sky = setup({ world: w, race: 'Skyborne' });
	assert.equal(orc.run.qIndex.has(701), false);
	assert.equal(sky.run.qIndex.has(701), true);
	assert.equal(orc.run.packages.some((p) => p.zone === syn.ISLE), false);
	// One ride, isle -> mainland.
	const exits = w.rides.filter((r) => r[4] === 'Zephras Isle airship');
	assert.equal(exits.length, 1);
	assert.equal(w.points[w.nodes[exits[0][0]].pt][4], syn.ISLE);
	const { run, ev } = sky;
	ev.reset();
	const isle = run.qGiver[run.qIndex.get(701)];
	const vale = run.qGiver[run.qIndex.get(501)];
	assert.ok(Number.isFinite(ev.travel.leg(isle, vale, ev.D, false, 1)));
	assert.equal(ev.travel.leg(vale, isle, ev.D, false, 1), Infinity);
});

test('home first: the starting area (Skyborne: the isle) before any other package', () => {
	const w = rulesWorld();
	const sky = setup({ world: w, race: 'Skyborne' });
	const isle = pkg(sky.run, 'Zephras Isle 1-5');
	const vale = pkg(sky.run, 'Testvale 1-5');
	assert.deepEqual(sky.run.packages.filter((p, i) => sky.run.pkgHome[i]).map((p) => p.key), ['Zephras Isle 1-5']);
	assert.equal(sky.ev.evaluate([vale, isle]).feasible, false);
	assert.equal(sky.ev.cost([vale, isle]), Infinity);
	assert.ok(sky.ev.evaluate([isle, vale]).feasible);
	const orc = setup({ world: w });
	assert.deepEqual(orc.run.packages.filter((p, i) => orc.run.pkgHome[i]).map((p) => p.key), ['Testvale 1-5']);
	assert.equal(orc.ev.evaluate([pkg(orc.run, 'Farfield 1-5'), pkg(orc.run, 'Testvale 1-5')]).feasible, false);
	// Construction starts with the home packages.
	const c = construct(orc.ev, new Rng(3), { tau: 0.2 });
	assert.equal(c.route[0], pkg(orc.run, 'Testvale 1-5'));
	const cs = construct(sky.ev, new Rng(3), { tau: 0.2 });
	assert.equal(cs.route[0], isle);
});

test('no continent change before level 10: the character grinds to 10 before leaving', () => {
	const { run, ev } = setup({ world: rulesWorld() });
	assert.equal(run.pkgAway[pkg(run, 'Farcoast 1-5')], 1);
	assert.equal(run.pkgAway[pkg(run, 'Farfield 1-5')], 0);
	let acceptLevel = null;
	ev.hook = (k, q) => {
		if (k === 0 && run.quests[q].id === 702) acceptLevel = ev.level;
	};
	const r = ev.evaluate([pkg(run, 'Testvale 1-5'), pkg(run, 'Farcoast 1-5')], { detail: true });
	ev.hook = null;
	assert.ok(r.perPackage[0].levelOut < 10);
	assert.ok(acceptLevel >= 10, `accepted at ${acceptLevel}`);
	assert.ok(r.perPackage[1].grind > 0);
});

test('travel safety: walking across a zone 5+ levels above costs deathRisk per zone', () => {
	const w = rulesWorld();
	assert.equal(w.zoneMin[syn.HIGHCRAG], 30);
	assert.equal(w.zoneMin[syn.VALE], undefined); // too few hostile spawns for a range
	const { run, ev, p } = setup({ world: w });
	ev.reset();
	const field = run.qGiver[run.qIndex.get(504)];
	const beyond = run.qGiver[run.qIndex.get(703)];
	const low = ev.travel.leg(field, beyond, ev.D, false, 5);
	assert.equal(ev.travel.lastRisk, 1);
	const high = ev.travel.leg(field, beyond, ev.D, false, 26);
	assert.equal(ev.travel.lastRisk, 0);
	assert.ok(Math.abs(low - high - p.deathRisk) < 1e-6, `${low} vs ${high}`);
	// Zones the leg starts or ends in do not count.
	const crag = setup({ world: w, params: { deathRisk: 0 } });
	crag.ev.reset();
	assert.ok(Math.abs(crag.ev.travel.leg(field, beyond, crag.ev.D, false, 5) - high) < 1e-6);
});

test('guide sequences: no route rules; an unreachable step is skipped, not an infinite trip (regression)', () => {
	const { run, ev } = setup({ world: rulesWorld(), race: 'Skyborne' });
	// Leaves the isle (one way), then a step back on the isle.
	const seq = compileSequence(run, [
		{ t: 'accept', q: 701 }, { t: 'accept', q: 501 }, { t: 'turnin', q: 501 }, { t: 'complete', q: 701 }, { t: 'turnin', q: 701 },
	]);
	const r = ev.evaluateSequence(seq, { honorCheckpoints: true });
	assert.ok(Number.isFinite(r.seconds) && Number.isFinite(r.travelSeconds));
	assert.ok(r.levelTimes[10] > 0);
	assert.ok(r.unreachable >= 1);
	assert.equal(r.questsDone, 1);
	// The home-first rule is for routes only: a sequence may start anywhere.
	const seq2 = compileSequence(run, [{ t: 'accept', q: 501 }, { t: 'turnin', q: 501 }]);
	const r2 = ev.evaluateSequence(seq2, { honorCheckpoints: true });
	assert.ok(Number.isFinite(r2.seconds));
});

// ---------------------------------------------------------------- search

function permutations(items) {
	if (items.length <= 1) return [items];
	const out = [];
	items.forEach((x, i) => {
		for (const p of permutations(items.slice(0, i).concat(items.slice(i + 1)))) out.push([x, ...p]);
	});
	return out;
}

test('search recovers the known optimum of a small world (exhaustive check)', () => {
	const { run, ev } = setup({ band: 2 });
	const all = [...Array(run.P).keys()];
	assert.ok(run.P >= 4 && run.P <= 7, `packages: ${run.P}`);
	let best = Infinity;
	// Every ordered subset.
	for (let mask = 1; mask < 1 << run.P; mask++) {
		const sub = all.filter((i) => mask & (1 << i));
		for (const p of permutations(sub)) best = Math.min(best, ev.cost(p));
	}
	const rng = new Rng(42);
	let found = Infinity;
	for (let r = 0; r < 4; r++) {
		const c = construct(ev, rng, { tau: 0.2 });
		const a = anneal(ev, rng, c, { evals: 1500, t0: 300, t1: 1 });
		found = Math.min(found, a.seconds);
	}
	assert.ok(Math.abs(found - best) < 1e-6, `search ${found} vs optimum ${best}`);
});

test('convergence rule: no improvement over the last share of evaluations', () => {
	assert.equal(converged([[100, 10], [200, 9], [300, 9], [400, 9]], 0.25, 0.001), true);
	assert.equal(converged([[100, 10], [200, 9], [300, 9], [400, 8]], 0.25, 0.001), false);
});

test('workers give the same result as one thread for a seed', async () => {
	const root = tmpdir('polestar-sim-');
	const dirs = syn.writeDataDir(root);
	const base = { ...dirs, offline: true, extraStarts: syn.START, faction: 'Horde', race: 'Orc', paths: 3000, seed: 9, jobsPerRound: 6, constructions: 2, anneal: 150, benchMs: 0, write: false, bandWidth: 2 };
	const one = await sim.runCharacter({ ...base, workers: 1 });
	const many = await sim.runCharacter({ ...base, workers: 3 });
	assert.equal(many.evaluatedRoutes, one.evaluatedRoutes);
	assert.deepEqual(many.best.route, one.best.route);
	assert.equal(many.best.seconds, one.best.seconds);
	assert.deepEqual(many.curve, one.curve);
	assert.deepEqual(many.elite, one.elite);
});

// ---------------------------------------------------------------- params, calibration, robustness

test('parameter draws are seeded and stay inside bounds', () => {
	const eff = effective({ calibrated: { extraKill: { mean: 0.3, sd: 0.05 } } }, 'Hunter');
	assert.equal(eff.extraKill.mean, 0.3);
	assert.equal(eff.classFactor.mean, 0.8);
	const a = draws(eff, 200, 5);
	assert.deepEqual(a, draws(eff, 200, 5));
	for (const d of a) for (const [k, [, , lo, hi]] of Object.entries(PRIORS)) assert.ok(d[k] >= lo && d[k] <= hi, k);
});

test('calibration: Forever XP table parsing and robust ratio fit', () => {
	const text = 'FDJ.FOREVER_QUEST_XP_FALLBACK = {\n    [101] = 500, -- a\n    [102] = 1250,\n}\nFDJ.OTHER = { [5] = 1 }\n';
	assert.deepEqual([...parseForeverXp(text)], [[101, 500], [102, 1250]]);
	const f = ratioFit([0.8, 0.8, 0.8, 0.8, 2]);
	assert.ok(Math.abs(f.mean - 0.8) < 1e-9);
	assert.equal(f.n, 5);
});

test('robustness summary: win rates, intervals, flip correlations', () => {
	const dr = [];
	const secs = [];
	for (let i = 0; i < 100; i++) {
		const x = (i + 0.5) / 100;
		dr.push({ ...params(), grindEff: x });
		secs.push([100 + 10 * x, 105]); // route 1 wins while grindEff < 0.5
	}
	const r = analyze(secs, dr, ['a', 'b']);
	assert.equal(r.routes[0].winRate, 0.5);
	assert.equal(r.flips[0].param, 'grindEff');
	assert.ok(r.flips[0].rhoDiff > 0.99);
	assert.ok(Math.abs(spearman([1, 2, 3], [3, 2, 1]) + 1) < 1e-12);
});

test('a transport end with a board point (a ship lying off its pier) has its dock node on the deck', () => {
	const d = syn.makeRulesData();
	const t = d.travel.transports.find((x) => x.id === 'zeppelin-test');
	t.kind = 'boat';
	t.a.board = { wx: 912, wy: -100, z: 5.9 };
	const w = buildWorld(d, { faction: 'Horde', bandWidth: 5, extraStarts: syn.RULES_START });
	const dock = (name) => w.points[w.nodes.find((n) => n.kind === 'dock' && n.name.startsWith(name)).pt];
	assert.deepEqual([0, 2, 3].map((i) => dock('Testvale tower')[i]), [1, 912, -100], 'walked to the deck');
	assert.deepEqual([0, 2, 3].map((i) => dock('Farcoast tower')[i]), [0, 900, -100], 'no board point: the stop');
});
