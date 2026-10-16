'use strict';
// Completionist routes (docs/SIMULATION.md "Completionist"): the completionist
// world, the eligible set and its exclusive choices, the evaluator's
// completionist rules (no grind to 60, going on at 60, the grey charge, the
// miss charge), construction and the coverage report, on the invented world
// of tests/fixtures/sim.

const { test } = require('node:test');
const assert = require('node:assert/strict');

const { buildWorld } = require('../tools/lib/sim/world');
const { compileRun, makeTables, sliceOrder, K_TURNIN } = require('../tools/lib/sim/run');
const { planOrder } = require('../tools/lib/sim/tour');
const { Evaluator, SHARE } = require('../tools/lib/sim/evaluate');
const { construct } = require('../tools/lib/sim/search');
const { Rng } = require('../tools/lib/sim/rng');
const { effective, means } = require('../tools/lib/sim/params');
const { coverage, coverageMarkdown } = require('../tools/lib/sim/completionist');
const { completionistGuides, straightTurnins } = require('../tools/lib/sim/completionist-guides');
const { executedSteps } = require('../tools/lib/sim/export');
const { LEVEL_XP } = require('../tools/lib/game/xp');
const syn = require('./fixtures/sim/synthetic');

const { VALE } = syn;

// The base world plus an elite quest, a quest whose item only an elite
// drops, a quest after it, a profession quest and a one-way exclusion.
function data() {
	const d = syn.makeData();
	const base = d.quests[501];
	const q = (id, title, x) => ({ ...base, id, title, objectives: [], ...x });
	Object.assign(d.npcs, {
		20: { id: 20, name: 'Elite Brute', level: 5, rank: 1, faction: null, spawns: { [VALE]: { f: 'e', pts: [[30, 70], [31, 70]] } } },
	});
	Object.assign(d.items, {
		200: { id: 200, name: 'Brute Tooth', drops: { npc: { 20: 80 }, object: {} }, vendors: [] },
	});
	Object.assign(d.quests, {
		904: q(904, 'Brute Force', { level: 5, objectives: [{ type: 'kill', id: 10, count: 2 }, { type: 'kill', id: 20, count: 1 }] }),
		905: q(905, 'Brute Teeth', { level: 5, objectives: [{ type: 'item', id: 200, count: 2 }] }),
		906: q(906, 'After the Teeth', { level: 5, pre: [905], objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		907: q(907, 'Tailoring Order', { skill: { id: 197, value: 50 }, objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		961: q(961, 'One-Way', { excl: [962], objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		962: q(962, 'Main Chain', { objectives: [{ type: 'kill', id: 10, count: 2 }] }),
	});
	return d;
}

function build(variant) {
	const w = buildWorld(data(), { faction: 'Horde', bandWidth: 5, extraStarts: syn.START, variant });
	w.questXp = syn.questXpRows();
	return w;
}

function setup(over = {}) {
	const w = build('completionist');
	const run = compileRun(w, { race: 'Orc', cls: null, family: 'completionist' });
	const p = { ...means(effective({ calibrated: {} })), ...over };
	return { w, run, p, ev: new Evaluator(run, makeTables(run, p)) };
}

test('the completionist world keeps elite quests (marked elite) and every other exclusion; the leveling world is unchanged', () => {
	const solo = build();
	const comp = build('completionist');
	const ids = (w) => w.quests.map((q) => q.id);
	for (const id of [904, 905]) assert.ok(!ids(solo).includes(id), `${id} not in the leveling world`);
	// 906 is there, but unreachable at run time (after the excluded 905).
	assert.ok(!compileRun(solo, { race: 'Orc' }).qIndex.has(906));
	assert.equal(solo.excluded.find((e) => e.id === 904).category, 'elite');
	for (const id of [904, 905, 906]) assert.ok(ids(comp).includes(id), `${id} in the completionist world`);
	assert.equal(comp.quests.find((q) => q.id === 904).elite, true);
	assert.equal(comp.quests.find((q) => q.id === 905).elite, true);
	assert.equal(comp.quests.find((q) => q.id === 906).elite, false);
	// Professions stay out of both (crafting is not modelled).
	assert.equal(comp.excluded.find((e) => e.id === 907).reason, 'profession');
	assert.equal(solo.variant, 'solo');
	assert.equal(comp.variant, 'completionist');
	// Tasks name the objectives they hold (raw.objectives indices).
	const brute = comp.quests.find((q) => q.id === 904);
	assert.deepEqual(brute.tasks.flatMap((t) => t.objs).sort(), [0, 1]);
});

test('completionist packages follow each zone\'s own level tiers: a quest more than 8 levels above the tier opens a return visit; a chain stays with its predecessor within 2 levels; the log holds 40', () => {
	const d = data();
	const base = d.quests[501];
	const q = (id, title, x) => ({ ...base, id, title, objectives: [{ type: 'kill', id: 10, count: 2 }], ...x });
	Object.assign(d.quests, {
		971: q(971, 'Follow-up', { level: 11, minLevel: 11, pre: [501] }),
		972: q(972, 'Too Late', { level: 12, minLevel: 12 }),
		973: q(973, 'Return Visit', { level: 22, minLevel: 20 }),
	});
	const w = buildWorld(d, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START, variant: 'completionist' });
	const pkgOf = (id) => w.packages.filter((p) => p.dungeon === undefined && p.zone === VALE && p.quests.includes(id));
	const first = pkgOf(501)[0];
	assert.ok(first, 'quest 501 has a package in the vale');
	assert.ok(pkgOf(971).includes(first), 'the chain quest at 11 stays in its predecessor\'s first tier (1 + 8 + 2)');
	assert.ok(!pkgOf(972).includes(first), 'a quest at 12 without a chain opens the next tier');
	assert.ok(!pkgOf(973).includes(first) && !pkgOf(973).includes(pkgOf(972)[0]), 'a quest at 20 is a later return visit');
	assert.match(pkgOf(973)[0].key, / 20-20$/);
	// About 35 quests open at once in one zone (25 chores at level 1 and the
	// vale's own): one package at 40, where 20 would split it.
	const big = data();
	for (let i = 0; i < 25; i++) big.quests[980 + i] = q(980 + i, `Chore ${i}`, { level: 1, minLevel: 1 });
	const bw = buildWorld(big, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START, variant: 'completionist' });
	const holding = bw.packages.filter((p) => p.quests.some((id) => id >= 980 && id < 1005));
	assert.equal(holding.filter((p) => p.zone === VALE).length, 1);
});

test('a completionist zone visit is walked by level: its 1-5 quests before its 6-10 ones, chains in their prerequisite\'s slice or later', () => {
	// Points on a line: the level 7 hub (x 0) sits between the start and the
	// level 1 camp (x 100); a single tour from the hub does the level 7 quest
	// first. 12 (level 3) follows 11 (level 8): a chain keeps its order.
	const at = (x) => x;
	const step = (q, kind, x, quest = {}) => ({ kind, q, task: kind === 'task' ? 0 : -1, pt: at(x), quest: { pre: [], ...quest } });
	const sub = [
		step(7, 'accept', 0), step(7, 'task', 1), step(7, 'turnin', 0),
		step(8, 'accept', 2), step(8, 'turnin', 2),
		step(1, 'accept', 100), step(1, 'task', 101), step(1, 'turnin', 100),
		step(11, 'accept', 3), step(11, 'turnin', 3),
		step(12, 'accept', 104, { pre: [11] }), step(12, 'turnin', 104, { pre: [11] }),
	];
	const levels = { 7: 7, 8: 7, 1: 1, 11: 8, 12: 3 };
	const worldById = new Map(Object.entries(levels).map(([id, l]) => [Number(id), { minLevel: l }]));
	const dist = (a, b) => Math.abs(a - b);
	const order = sliceOrder(sub, worldById, 5, dist).map((s) => `${s.kind} ${s.q}`);
	const pos = (x) => order.indexOf(x);
	assert.ok(pos('turnin 1') < pos('accept 7') && pos('turnin 1') < pos('accept 8'), order.join(', '));
	assert.ok(pos('turnin 11') < pos('accept 12'), order.join(', '));
	// Without slices the nearest-neighbour tour starts at the level 7 hub.
	const flat = planOrder(sub, { dist }).map((s) => `${s.kind} ${s.q}`);
	assert.ok(flat.indexOf('accept 7') < flat.indexOf('accept 1'));
});

test('eligible set: one quest of a two-way exclusive choice (most dependents, then reward, then id), one-way exclusions stay; class quests left to the Class guides', () => {
	const { run } = setup();
	// 506/507 list each other: a real choice; equal in every way, so the lower id.
	assert.deepEqual(run.branches, [{ kept: 506, dropped: [507] }]);
	assert.ok(run.qIndex.has(506));
	assert.ok(!run.qIndex.has(507));
	// 961 lists 962 only: an order (961 first), both eligible.
	assert.ok(run.qIndex.has(961) && run.qIndex.has(962));
	assert.ok(!run.qIndex.has(508), 'the Mage quest is the Class guides\'');
	assert.ok(run.qIndex.has(904) && run.qIndex.has(906));
	assert.throws(() => compileRun(build(), { race: 'Orc', family: 'completionist' }), /completionist world/);
});

test('exclusive choice: the branch more quests depend on is kept', () => {
	const d = data();
	d.quests[970] = { ...d.quests[501], id: 970, title: 'After Choice Two', pre: [507], objectives: [{ type: 'kill', id: 10, count: 2 }] };
	const w = buildWorld(d, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START, variant: 'completionist' });
	w.questXp = syn.questXpRows();
	const run = compileRun(w, { race: 'Orc', family: 'completionist' });
	assert.deepEqual(run.branches, [{ kept: 507, dropped: [506] }]);
});

test('completionist evaluation: no grind to 60, the cost is time plus the grey and miss charges', () => {
	const { run, ev, p } = setup();
	const r = ev.evaluate([]);
	assert.equal(r.grindSeconds, 0, 'nothing ground after the last package');
	assert.equal(r.missed, run.Q);
	assert.equal(ev.cost([]), p.missWeight * run.Q);
	// A quest turned in 10+ levels above its level loses 90% of its XP: that
	// XP's grinding time at the quest's level is charged greyWeight times.
	ev.reset();
	ev.level = 15;
	const qi = run.qIndex.get(501);
	ev.active[qi] = 1;
	for (let t = run.qTask0[qi]; t < run.qTask1[qi]; t++) ev.taskDone[t] = 1;
	ev.step(K_TURNIN, qi, -1, run.qEnder[qi]);
	assert.equal(ev.done[qi], 1);
	const full = ev.t.qFull[qi];
	assert.equal(SHARE[15 - 2], 0.1);
	assert.ok(Math.abs(ev.xpLost - full * 0.9) < 1e-6);
	assert.ok(Math.abs(ev.greySec - (full * 0.9) / ev.t.grindRate[2]) < 1e-6);
	assert.equal(ev.greyQuests, 1);
	const before = ev.policyCost();
	ev.p = { ...ev.p, greyWeight: 2 };
	assert.ok(Math.abs(ev.policyCost() - before - ev.greySec) < 1e-6);
});

test('a completionist route may return to a package up to six runs (chains bouncing between zones); a leveling route three', () => {
	const { run, ev } = setup();
	const home = [...run.packages.keys()].filter((p) => run.pkgHome[p]);
	const away = [...run.packages.keys()].find((p) => !run.pkgHome[p] && run.packages[p].dungeon === undefined);
	assert.ok(away != null);
	const rep = (n) => [...home, ...Array(n).fill(away)];
	assert.ok(Number.isFinite(ev.cost(rep(6))), 'six runs are feasible');
	assert.equal(ev.cost(rep(7)), Infinity);
	const solo = build();
	const lrun = compileRun(solo, { race: 'Orc' });
	const lev = new Evaluator(lrun, makeTables(lrun, means(effective({ calibrated: {} }))));
	const lhome = [...lrun.packages.keys()].filter((p) => lrun.pkgHome[p]);
	const laway = [...lrun.packages.keys()].find((p) => !lrun.pkgHome[p] && lrun.packages[p].dungeon === undefined);
	assert.ok(Number.isFinite(lev.cost([...lhome, ...Array(3).fill(laway)])));
	assert.equal(lev.cost([...lhome, ...Array(4).fill(laway)]), Infinity);
});

test('completionist evaluation goes on at 60: no more XP, quests still count, all their XP charged', () => {
	const { run, ev } = setup();
	ev.reset();
	ev.level = 59;
	ev.xp = LEVEL_XP[59] - 1;
	ev.gain(10);
	assert.equal(ev.level, 60);
	assert.equal(ev.capped, true);
	assert.equal(ev.finished, false);
	ev.gain(5000);
	assert.equal(ev.xp, 0);
	const qi = run.qIndex.get(502);
	ev.active[qi] = 1;
	for (let t = run.qTask0[qi]; t < run.qTask1[qi]; t++) ev.taskDone[t] = 1;
	ev.step(K_TURNIN, qi, -1, run.qEnder[qi]);
	assert.equal(ev.questsDone, 1);
	assert.ok(Math.abs(ev.xpLost - ev.t.qFull[qi]) < 1e-6);
});

test('construction completes every eligible quest of a small world, elites included', () => {
	const { run, ev } = setup();
	const r = construct(ev, new Rng(7), { tau: 0.1 });
	const res = ev.evaluate(r.route);
	assert.equal(res.feasible, true);
	assert.equal(res.missed, 0, `missed: ${run.quests.filter((q, i) => !ev.done[i]).map((q) => q.id).join(', ')}`);
	assert.equal(res.questsDone, run.Q);
	assert.equal(r.seconds, ev.cost(r.route));
});

test('coverage: eligible vs routed per zone, every other quest of the race with one reason', () => {
	const { w, run, ev } = setup();
	const { route } = construct(ev, new Rng(7), { tau: 0.1 });
	const d = data();
	const cov = coverage({ world: w, run, ev, route, data: d });
	assert.equal(cov.summary.eligible, run.Q);
	assert.equal(cov.summary.routed, run.Q);
	assert.equal(cov.summary.missed, 0);
	assert.equal(cov.summary.optional, 2); // 904, 905
	const reason = (id) => (cov.out.find((o) => o.id === id) || {}).reason;
	assert.equal(reason(507), 'alternative');
	assert.equal(reason(508), 'class');
	assert.equal(reason(907), 'profession');
	assert.equal(reason(601), 'dungeon');
	const vale = cov.zones.find((z) => z.zone === 'Testvale');
	assert.ok(vale.eligible > 0 && vale.routed === vale.eligible);
	const md = coverageMarkdown(cov);
	assert.match(md, /\| Testvale \| \d+ \| \d+ \| 2 \| 0 \|/);
	assert.match(md, /## Exclusive choices/);
	assert.match(md, /\| 506 \| 507 \|/);
});

test('export: Completionist guides follow the guide conventions (category, folder, objective goals, optional elites with the tip, chained)', () => {
	const { w, run, ev } = setup();
	const { route } = construct(ev, new Rng(7), { tau: 0.1 });
	const d = data();
	const entries = executedSteps(ev, run, route);
	const cov = coverage({ world: w, run, ev, route, data: d });
	const guides = completionistGuides({ world: w, run, data: d, entries, meta: { faction: 'Horde', race: 'Orc', label: 'test route' }, place: () => null, coverage: cov, base: 'completionist/horde/orc' });
	assert.ok(guides.length >= 1);
	const text = guides.map((g) => g.text).join('\n');
	const g0 = guides[0].text;
	assert.match(g0, /^guide completionist\/horde\/orc\/01-testvale(-farfield)?\n/);
	assert.match(g0, /\ncategory Completionist\n/);
	assert.match(g0, /\nfolder Completionist · Orc 1-20\n/);
	// The chain's first step warns against "Skip grey quests" (the other starts are grey by then); later guides do not.
	assert.match(g0, /\nstep [^\n]+\n {2}tip Every quest counts here, grey ones too: keep Options > Automation > "Skip grey quests" off\./);
	for (const g of guides.slice(1)) assert.doesNotMatch(g.text, /Skip grey quests/);
	if (guides.length > 1) assert.match(g0, new RegExp(`\\nnext ${guides[1].id}\\n`));
	// Objectives as goals tied to the quest; the elite quest's goals optional, with the tip.
	assert.match(text, /\n {2}kill 10 quest 501\.1\n/);
	assert.match(text, /\n {2}collect 100 quest 502\.1\n/);
	assert.match(text, /\n {2}accept 904 optional\n/);
	assert.match(text, /\n {2}kill 20 quest 904\.2 optional\n/);
	assert.match(text, /\n {2}kill 10 quest 904\.1 optional\n/);
	assert.match(text, /\n {2}turnin 904 optional\n/);
	assert.match(text, /\n {2}tip Elite Brute \(level 5\) is elite: grouping up is advised unless you are well above level 5\.\n/);
	assert.match(text, /# Optional \(elite: grouping up is advised\): Brute Force \(904; Elite Brute 5\)/);
	// The profession quest is a note, not a goal.
	assert.match(text, /note "Profession quests here, for players with the skill: Tailoring Order \(a profession\)\."/);
	assert.doesNotMatch(text, /accept 907/);
	// Every step holds a goal that is not optional (a note never holds one).
	for (const g of guides) {
		for (const step of g.text.split('\nstep ').slice(1)) {
			const goals = step.split('\n').slice(1).map((l) => l.trim()).filter((l) => l && !/^(tip|zone|note) /.test(l));
			assert.ok(goals.some((l) => !/ optional$/.test(l)), `a step of optional goals only:\n${step}`);
		}
	}
});

test('export: a timed quest item is followed by the rest of its quest (an escort\'s complete, the turn-in that spends it), with how long it lasts', () => {
	const data = {
		items: { 10439: { id: 10439, name: "Durnan's Scalding Mornbrew", duration: 300 }, 50: { id: 50, name: 'Fresh Fish', duration: 600 } },
		quests: { 3364: { id: 3364, sourceItem: 10439, objectives: [] }, 70: { id: 70, objectives: [{ type: 'item', id: 50 }, { type: 'kill', id: 9 }] } },
	};
	const g = (text, q) => ({ text, q });
	const steps = [
		{ title: 'Nori', goals: [g('accept 3364', 3364), g('accept 70', 70)] },
		{ title: 'Pond', goals: [g('collect 50 quest 70.1', 70)] },
		{ title: 'Wolves', goals: [g('kill 9 quest 70.2', 70)] },
		{ title: 'Durnan', goals: [g('turnin 3364', 3364), g('turnin 70', 70)] },
	];
	const out = straightTurnins(steps, data);
	assert.deepEqual(out.map((s) => [s.title, s.goals.map((x) => x.text)]), [
		['Nori', ['accept 3364', 'accept 70']],
		['Durnan', ['turnin 3364']],
		['Pond', ['collect 50 quest 70.1']],
		['Wolves', ['kill 9 quest 70.2']],
		['Durnan', ['turnin 70']],
	]);
	assert.equal(out[1].goals[0].tip, "Durnan's Scalding Mornbrew lasts 5 minutes: go straight on with it.");
	// An escort with a canteen: its complete and turn-in come up before the raft.
	data.items[11804] = { id: 11804, name: "Spraggle's Canteen", duration: 1500 };
	data.quests[4491] = { id: 4491, sourceItem: 11804, objectives: [{ type: 'event' }] };
	const esc = straightTurnins([
		{ title: 'Ringo', goals: [g('accept 4491', 4491)] },
		{ title: 'A Wrecked Raft', goals: [g('accept 3844', 3844)] },
		{ title: "Marshal's Refuge", goals: [g('complete 4491', 4491), g('turnin 3844', 3844)] },
		{ title: 'Spraggle Frock', goals: [g('turnin 4491', 4491)] },
	], data);
	assert.deepEqual(esc.map((s) => [s.title, s.goals.map((x) => x.text)]), [
		['Ringo', ['accept 4491']],
		["Marshal's Refuge", ['complete 4491']],
		['Spraggle Frock', ['turnin 4491']],
		['A Wrecked Raft', ['accept 3844']],
		["Marshal's Refuge", ['turnin 3844']],
	]);
	// The route hearths to the turn-in: left as it is (walking there is slower).
	const viaInn = [
		{ title: 'Nori', goals: [g('accept 3364', 3364)] },
		{ title: 'Wolves', goals: [g('kill 9 quest 70.2', 70)] },
		{ title: 'Back to Anvilmar', goals: [{ text: 'hearth "Anvilmar"' }] },
		{ title: 'Durnan', goals: [g('turnin 3364', 3364)] },
	];
	assert.deepEqual(straightTurnins(viaInn, data).map((s) => s.title), ['Nori', 'Wolves', 'Back to Anvilmar', 'Durnan']);
	// Two timed items from one step: both go straight on.
	data.quests[71] = { id: 71, sourceItem: 50, objectives: [] };
	const two = straightTurnins([
		{ title: 'Nori', goals: [g('accept 3364', 3364), g('accept 71', 71)] },
		{ title: 'Wolves', goals: [g('kill 9 quest 70.2', 70)] },
		{ title: 'Durnan', goals: [g('turnin 3364', 3364)] },
		{ title: 'Pond', goals: [g('turnin 71', 71)] },
	], data);
	assert.deepEqual(two.map((s) => [s.title, s.goals.map((x) => x.text)]), [
		['Nori', ['accept 3364', 'accept 71']],
		['Pond', ['turnin 71']],
		['Durnan', ['turnin 3364']],
		['Wolves', ['kill 9 quest 70.2']],
	]);
});
