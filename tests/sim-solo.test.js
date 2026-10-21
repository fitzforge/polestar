'use strict';
// Simulator world builder (docs/SIMULATION.md §1 "Solo filter", placement,
// vendors, child quests, prerequisites, exclusive quests) on the invented
// world of tests/fixtures/sim.

const { test } = require('node:test');
const assert = require('node:assert/strict');

const { buildWorld } = require('../tools/lib/sim/world');
const { compileRun, makeTables } = require('../tools/lib/sim/run');
const { Evaluator } = require('../tools/lib/sim/evaluate');
const { effective, means } = require('../tools/lib/sim/params');
const solo = require('../tools/lib/sim/solo');
const os = require('node:os');
const path = require('node:path');
const syn = require('./fixtures/sim/synthetic');

const { VALE, FIELD } = syn;
const OVERLAP = 99106; // a map overlapping Testvale's east edge

// The base data plus test quests (ids 9xx), mobs and items. Quest helper:
// given and turned in by Elder Testa (npc 1) in Testvale unless overridden.
function data(extra = {}) {
	const d = syn.makeData();
	const base = d.quests[501];
	const q = (id, title, x) => ({ ...base, id, title, objectives: [], ...x });
	Object.assign(d.npcs, {
		20: { id: 20, name: 'Elite Brute', level: 5, rank: 1, faction: null, spawns: { [VALE]: { f: 'e', pts: [[30, 70], [31, 70]] } } },
		21: { id: 21, name: 'High Wolf', level: 12, faction: null, spawns: { [VALE]: { f: 'e', pts: [[40, 70], [41, 70]] } } },
		22: { id: 22, name: 'Rare Beast', level: 4, rank: 4, faction: null, spawns: { [VALE]: { f: 'e', pts: [[45, 70]] } } },
		30: { id: 30, name: 'Far Vendor', level: 10, faction: 'AH', spawns: { [FIELD]: { f: 'e', pts: [[90, 90]] } } },
		31: { id: 31, name: 'Near Vendor', level: 10, faction: 'AH', spawns: { [VALE]: { f: 'e', pts: [[52, 52]] } } },
		23: { id: 23, name: 'Crypt Lurker', level: 5, faction: null, spawns: {} }, // inside an instance only
	});
	Object.assign(d.items, {
		200: { id: 200, name: 'Brute Tooth', drops: { npc: { 20: 80 }, object: {} }, vendors: [] },
		201: { id: 201, name: 'Wolf Fang', drops: { npc: { 21: 80 }, object: {} }, vendors: [] },
		202: { id: 202, name: 'Mixed Fang', drops: { npc: { 20: 90, 10: 40 }, object: {} }, vendors: [] },
		203: { id: 203, name: 'Lucky Stone', drops: { npc: { 10: 0.5 }, object: {} }, vendors: [] },
		204: { id: 204, name: 'Rare Hide', drops: { npc: { 22: 50 }, object: {} }, vendors: [] },
		205: { id: 205, name: 'Spice', drops: { npc: {}, object: {} }, vendors: [30, 31] },
		206: { id: 206, name: 'Brute Letter', drops: { npc: { 20: 50 }, object: {} }, vendors: [] },
	});
	Object.assign(d.quests, {
		901: q(901, 'In the Crypt', { area: 7001, objectives: [{ type: 'kill', id: 23, count: 2 }] }),
		902: q(902, 'Raid Boss', { area: 7002, objectives: [{ type: 'kill', id: 23, count: 2 }] }),
		903: q(903, 'Battleground Marks', { area: 7003, objectives: [{ type: 'kill', id: 23, count: 2 }] }),
		904: q(904, 'Brute Force', { objectives: [{ type: 'kill', id: 20, count: 1 }] }),
		905: q(905, 'Brute Teeth', { objectives: [{ type: 'item', id: 200, count: 2 }] }),
		906: q(906, 'Wolf Fangs', { level: 5, objectives: [{ type: 'item', id: 201, count: 2 }] }),
		907: q(907, 'Mixed Fangs', { objectives: [{ type: 'item', id: 202, count: 2 }] }),
		908: q(908, 'Lucky Stone', { objectives: [{ type: 'item', id: 203, count: 1 }] }),
		909: q(909, 'Rare Hide', { objectives: [{ type: 'item', id: 204, count: 1 }] }),
		910: q(910, 'Exalted Turn-in', { reputation: { faction: 529, value: 42000 }, objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		911: q(911, 'Friendly Turn-in', { reputation: { faction: 529, value: 3000 }, objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		912: q(912, 'Listed Out', { objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		913: q(913, 'Repeat Nothing', { repeatable: true, objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		914: q(914, 'Repeat Paid', { repeatable: true, xp: 300, objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		915: q(915, 'Repeat Needed', { repeatable: true, objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		916: q(916, 'After the Repeat', { pre: [915], objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		917: q(917, 'Spice Run', { objectives: [{ type: 'item', id: 205, count: 1 }] }),
		918: q(918, 'Brute Letter', { start: { npc: [], object: [], item: [206] }, objectives: [{ type: 'kill', id: 10, count: 1 }] }),
		919: q(919, 'Allowed Brute', { objectives: [{ type: 'kill', id: 20, count: 1 }] }),
	});
	Object.assign(d.quests, extra);
	d.questAreas = { build: 'test', areas: { 7001: 'dungeon', 7002: 'raid', 7003: 'pvp' } };
	return d;
}

const OVR = {
	exclude: [{ ids: [912], category: 'reputation', reason: 'test listing' }],
	allow: [{ ids: [919], reason: 'test allow' }],
	turninAfter: {},
};

function build(d, overrides = OVR) {
	const w = buildWorld(d, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START, overrides });
	w.questXp = syn.questXpRows();
	return w;
}

const has = (w, id) => w.quests.some((q) => q.id === id);
const why = (w, id) => w.excluded.find((e) => e.id === id) || null;

test('solo filter: instance areas (dungeon, raid, PvP), elite targets, elite or high droppers, rare drops, reputation, listings', () => {
	const w = build(data());
	assert.equal(why(w, 901).category, 'dungeon');
	assert.equal(why(w, 902).category, 'raid');
	assert.equal(why(w, 903).category, 'pvp');
	assert.equal(why(w, 904).category, 'elite'); // kill an elite
	assert.equal(why(w, 905).category, 'elite'); // item only from an elite
	assert.equal(why(w, 906).category, 'elite'); // item only from a mob 5+ levels above the quest (12 vs 5)
	assert.ok(has(w, 907)); // an elite and a normal dropper: the normal one
	const mixed = w.quests.find((q) => q.id === 907);
	assert.deepEqual(mixed.tasks[0].work[0].slice(0, 4), ['kill', 2, 5, 0]); // 2 items at 40% from Burrow Rats
	assert.equal(why(w, 908).category, 'rareDrop'); // 0.5%
	assert.equal(why(w, 909).category, 'rareDrop'); // a rare spawn (rank 4) is no source
	assert.equal(why(w, 910).category, 'reputation'); // above Friendly
	assert.ok(has(w, 911)); // Friendly is reachable by questing
	assert.equal(why(w, 912).category, 'reputation'); // explicit listing
	assert.equal(why(w, 918).category, 'elite'); // quest-starting item only from an elite
	assert.ok(has(w, 919)); // allowlist wins over the rules
	assert.equal(w.quests.find((q) => q.id === 919).elite, true);
	// Counts per category.
	assert.deepEqual(w.solo.counts, { dungeon: 1, raid: 1, pvp: 1, elite: 4, rareDrop: 2, reputation: 2, repeatable: 1 });
	// The base quests are untouched.
	for (const id of [501, 502, 503, 504, 505]) assert.ok(has(w, id), `base quest ${id}`);
});

test('group world (--elites): elite targets, elite or high droppers and elite-dropped starts stay in, elite fights marked; instances and rare drops still out', () => {
	const w = buildWorld(data(), { faction: 'Horde', bandWidth: 5, extraStarts: syn.START, overrides: OVR, variant: 'group' });
	for (const id of [904, 905, 906, 918]) assert.ok(has(w, id), `quest ${id} kept`);
	// An elite fight marks the quest, also the one that drops its starting
	// item (918: the party kills the elite to take it); a mob 5+ levels above
	// (906) is no elite fight.
	for (const id of [904, 905, 918]) assert.equal(w.quests.find((q) => q.id === id).elite, true, `quest ${id} marked elite`);
	assert.equal(w.quests.find((q) => q.id === 906).elite, false);
	assert.equal(why(w, 901).category, 'dungeon');
	assert.equal(why(w, 908).category, 'rareDrop');
	assert.equal(w.solo.counts.elite, 0);
	// Its own cache file and data hash: solo results never replay on it.
	const { worldFile, dataHash } = require('../tools/lib/sim/world');
	assert.match(worldFile('/sim', 'Horde', 'group'), /world-horde-group\.json$/);
	assert.match(worldFile('/sim', 'Horde'), /world-horde\.json$/);
	const dir = path.join(os.tmpdir(), 'ps-hash-none'); // no data there: the hash still differs by variant
	assert.notEqual(dataHash(dir, null, 'group'), dataHash(dir, null));
	assert.equal(dataHash(dir, null, 'solo'), dataHash(dir, null));
});

test('solo filter: repeatables count once; without a reward they are dropped unless another quest needs them (then no XP)', () => {
	const w = build(data());
	assert.equal(why(w, 913).category, 'repeatable');
	assert.ok(has(w, 914));
	assert.ok(has(w, 915));
	assert.equal(w.quests.find((q) => q.id === 915).noXp, true);
	assert.equal(w.solo.repeatNoXp, 1);
	const run = compileRun(w, { race: 'Orc' });
	const t = makeTables(run, means(effective({ calibrated: {} })));
	assert.equal(t.qFull[run.qIndex.get(915)], 0);
	assert.equal(t.qFull[run.qIndex.get(914)], 300);
	assert.ok(run.qIndex.has(916));
});

test('solo filter: a quest after an excluded one is unreachable at run time', () => {
	const d = data({ 920: { ...syn.makeData().quests[501], id: 920, title: 'After the Brute', pre: [904], objectives: [{ type: 'kill', id: 10, count: 2 }] } });
	const w = build(d);
	assert.ok(has(w, 920));
	assert.equal(compileRun(w, { race: 'Orc' }).qIndex.has(920), false);
});

test('solo filter: dungeons.json quests leave the solo world and come back as dungeon packages in the dungeon family', () => {
	const d = data();
	// 601 is the fixture dungeon's quest; put it in the quest data as well,
	// its objective inside the dungeon.
	d.quests[601] = { ...d.quests[504], id: 601, title: 'Into the Hollow', objectives: [{ type: 'kill', id: 23, count: 1 }] };
	const w = build(d);
	assert.equal(why(w, 601).category, 'dungeon');
	const q = w.quests.find((x) => x.id === 601);
	assert.ok(q && q.dungeon === 0, 'readmitted as a dungeon quest');
	assert.equal(compileRun(w, { race: 'Orc' }).qIndex.has(601), false);
	assert.ok(compileRun(w, { race: 'Orc', family: 'dungeons' }).qIndex.has(601));
});

test('solo filter: instance areas from the client Map/AreaTable rows (instance maps, entrance subzones by name)', () => {
	const maps = [
		{ ID: '0', MapName_lang: 'Eastern Kingdoms', InstanceType: '0', AreaTableID: '0' },
		{ ID: '90', MapName_lang: 'Gnomeregan', InstanceType: '1', AreaTableID: '721' },
		{ ID: '309', MapName_lang: "Zul'Gurub", InstanceType: '2', AreaTableID: '0' },
		{ ID: '489', MapName_lang: 'Warsong Gulch', InstanceType: '3', AreaTableID: '3277' },
	];
	const areas = [
		{ ID: '1', AreaName_lang: 'Dun Morogh', ContinentID: '0', ParentAreaID: '0' },
		{ ID: '133', AreaName_lang: 'Gnomeregan', ContinentID: '0', ParentAreaID: '1' },
		{ ID: '1977', AreaName_lang: "Zul'Gurub", ContinentID: '309', ParentAreaID: '0' },
	];
	assert.deepEqual(solo.instanceAreas(maps, areas), { 721: 'dungeon', 3277: 'pvp', 133: 'dungeon', 1977: 'raid' });
});

test('placement: a spawn on two overlapping maps goes to the map it lies furthest inside (Aerie Peak regression)', () => {
	const d = data();
	d.zones[OVERLAP] = { id: OVERLAP, name: 'Overlap Hills', areaId: null, parent: null, type: 3 };
	// Testvale spans wy 0..-1000, Overlap Hills -900..-1900: Testvale (99, 50) = Overlap (9, 50).
	d['map-frames'].era[OVERLAP] = { c: 1, left: -900, right: -1900, top: 1000, bottom: 0 };
	d.npcs[40] = { id: 40, name: 'Gryphon Master', level: 10, faction: 'AH', spawns: { [VALE]: { f: 'e', pts: [[99, 50]] }, [OVERLAP]: { f: 'e', pts: [[9, 50]] } } };
	d.quests[930] = { ...d.quests[501], id: 930, title: 'Hills Errand', start: { npc: [40], object: [], item: [] }, end: { npc: [40], object: [] } };
	const w = build(d);
	const q = w.quests.find((x) => x.id === 930);
	assert.equal(q.zone, OVERLAP);
	assert.equal(w.points[q.giver][4], OVERLAP);
});

test('vendors: a buy objective goes to the friendly vendor nearest the giver, not the first listed', () => {
	const w = build(data());
	const q = w.quests.find((x) => x.id === 917);
	assert.deepEqual(q.tasks[0].work, [['buy']]);
	assert.equal(w.points[q.tasks[0].pt][4], VALE); // Near Vendor (Testvale), not Far Vendor (Farfield)
});

test('child quests: accepted only while the parent is in the log; the parent waits for the children it needs', () => {
	const d = data();
	const base = d.quests[501];
	d.quests[940] = { ...base, id: 940, title: 'Fever', next: 941, children: [941], objectives: [{ type: 'kill', id: 10, count: 2 }] };
	d.quests[941] = { ...base, id: 941, title: 'Fever Fangs', pre: [940], parent: 940, repeatable: true, objectives: [{ type: 'item', id: 100, count: 1 }] };
	const w = build(d, { ...OVR, turninAfter: { 940: [941] } });
	const child = w.quests.find((x) => x.id === 941);
	assert.equal(child.inLog, 940);
	assert.deepEqual(child.pre, []); // the parent is not a prerequisite (it must not be turned in yet)
	assert.deepEqual(w.quests.find((x) => x.id === 940).after, [941]);
	assert.equal(w.preRules.children, 1);
	// Package order: accept parent, accept child, turn in child, then the parent.
	const pk = w.packages.find((p) => p.quests.includes(940));
	const at = (kind, id) => pk.steps.findIndex((s) => s[0] === kind && s[1] === id);
	assert.ok(at(0, 940) < at(0, 941));
	assert.ok(at(2, 941) < at(2, 940));
	// Evaluator: no child without the parent in the log; no parent turn-in before the child.
	const run = compileRun(w, { race: 'Orc' });
	const ev = new Evaluator(run, makeTables(run, { ...means(effective({ calibrated: {} })), gateGap: 10 }));
	ev.reset();
	const P = run.qIndex.get(940);
	const C = run.qIndex.get(941);
	assert.equal(ev.prereqOk(C), false);
	ev.active[P] = 1;
	assert.equal(ev.prereqOk(C), true);
	for (let i = run.qTask0[P]; i < run.qTask1[P]; i++) ev.taskDone[i] = 1;
	ev.step(2, P, -1, run.qEnder[P]);
	assert.equal(ev.done[P], 0, 'parent held until the child is turned in');
	ev.done[C] = 1;
	ev.step(2, P, -1, run.qEnder[P]);
	assert.equal(ev.done[P], 1);
});

// A test quest given and turned in by Elder Testa, no objectives unless given.
const extraQuest = (id, title, x) => ({ ...syn.makeData().quests[501], id, title, objectives: [], ...x });

function evaluator(w) {
	const run = compileRun(w, { race: 'Orc' });
	const ev = new Evaluator(run, makeTables(run, { ...means(effective({ calibrated: {} })), gateGap: 10 }));
	ev.reset();
	return { run, ev };
}

test('prerequisites: the canonical blocking prerequisites (regression: 788 needed its breadcrumb 787, 786 needed unstartable 785); journal chains for DungeonJournal-only quests', () => {
	const d = data({
		951: extraQuest(951, 'Cutting Teeth', { pre: [952, 953], breadcrumbs: [953], objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		952: extraQuest(952, 'Report to the City'),
		953: extraQuest(953, 'Cutting Teeth Lead', { breadcrumbFor: 951 }),
		954: extraQuest(954, 'Thwarting Aggression', { pre: [955], objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		955: extraQuest(955, 'Nobody Gives This', { start: { npc: [], object: [], item: [] } }),
	});
	d.dungeons.dungeons[0].quests[0].chain = [504];
	const w = build(d);
	const q = (id) => w.quests.find((x) => x.id === id);
	// An any-of group holding a breadcrumb is optional as a whole.
	assert.deepEqual([q(951).pre, q(951).preAll, q(951).preRule], [[], [], 'canonical']);
	// A prerequisite nobody can start does not block.
	assert.deepEqual(q(954).pre, []);
	assert.equal(why(w, 955).reason, 'no located quest giver');
	const { run, ev } = evaluator(w);
	assert.equal(ev.prereqOk(run.qIndex.get(951)), true);
	assert.ok(run.qIndex.has(954) && ev.prereqOk(run.qIndex.get(954)));
	// The DungeonJournal-only quest 601 keeps its journal chain.
	assert.deepEqual([q(601).pre, q(601).preRule], [[504], 'journal']);
	assert.equal(w.preRules.journal, 1);
});

test('exclusive quests are one-way: a quest is closed while one of its own `excl` is taken or done; taking it closes nothing (regression: 287 after 282, 322 after 324)', () => {
	const d = data({
		961: extraQuest(961, 'One-Way', { excl: [962], objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		962: extraQuest(962, 'Main Chain', { objectives: [{ type: 'kill', id: 10, count: 2 }] }),
	});
	const w = build(d);
	assert.deepEqual(w.quests.find((x) => x.id === 961).excl, [962]);
	assert.deepEqual(w.quests.find((x) => x.id === 962).excl, []);
	const { run, ev } = evaluator(w);
	const A = run.qIndex.get(961);
	const B = run.qIndex.get(962);
	ev.active[A] = 1;
	assert.equal(ev.prereqOk(B), true, 'taking 961 leaves 962 open');
	ev.reset();
	ev.active[B] = 1;
	assert.equal(ev.prereqOk(A), false, '962 in the log closes 961');
	ev.reset();
	ev.done[B] = 1;
	assert.equal(ev.prereqOk(A), false, '962 done closes 961');
	// Symmetric pair (506/507): either closes the other, through the evaluator.
	const S = run.qIndex.get(506);
	const T = run.qIndex.get(507);
	ev.reset();
	ev.step(0, S, run.qAccept[S], run.qGiver[S]);
	assert.equal(ev.active[S], 1);
	ev.step(0, T, run.qAccept[T], run.qGiver[T]);
	assert.equal(ev.active[T], 0);
});

test('quest-starting items: droppers without any recorded rate count at the assumed rate; elites still do not (regression: 91741 Nibbled-On Book)', () => {
	const d = data({
		931: extraQuest(931, 'Nibbled Book', { start: { npc: [], object: [], item: [208] }, objectives: [{ type: 'kill', id: 10, count: 1 }] }),
		932: extraQuest(932, 'Brute Note', { start: { npc: [], object: [], item: [209] }, objectives: [{ type: 'kill', id: 10, count: 1 }] }),
		933: extraQuest(933, 'Mixed Note', { start: { npc: [], object: [], item: [210] }, objectives: [{ type: 'kill', id: 10, count: 1 }] }),
	});
	Object.assign(d.items, {
		208: { id: 208, name: 'Nibbled Book', drops: { npc: { 10: null }, object: {} }, vendors: [] },
		209: { id: 209, name: 'Brute Note', drops: { npc: { 20: null }, object: {} }, vendors: [] },
		210: { id: 210, name: 'Mixed Note', drops: { npc: { 10: null, 11: 5 }, object: {} }, vendors: [] },
	});
	const w = build(d);
	const book = w.quests.find((x) => x.id === 931);
	assert.ok(book, 'located from its null-rate dropper');
	assert.deepEqual(book.accept.work[0].slice(0, 4), ['kill', 2, 100 / 30, 0]);
	assert.equal(why(w, 932).category, 'elite'); // the only dropper is an elite
	// Next to a recorded rate, the null-rate dropper is no evidence: the fox at 5%.
	assert.deepEqual(w.quests.find((x) => x.id === 933).accept.work[0].slice(0, 3), ['kill', 4, 20]);
});

test('kill credit on an NPC of the faction is one interaction, never elite; a hostile elite stays a fight (regression: 3441, 5742, 93739; 2078 stays out)', () => {
	const d = data({
		927: extraQuest(927, 'Divine Retribution', { start: { npc: [24], object: [], item: [] }, end: { npc: [24], object: [] }, objectiveText: 'Listen as Kalaran tells his story.', objectives: [{ type: 'kill', id: 24, count: null }] }),
		928: extraQuest(928, 'A Word with the Warden', { objectiveText: 'Speak with Warden Fieldy.', objectives: [{ type: 'kill', id: 2, count: null }] }),
		929: extraQuest(929, "Gyromast's Revenge", { objectiveText: 'Find the Threshwackonator and lead it back.', objectives: [{ type: 'kill', id: 25, count: null }] }),
		934: extraQuest(934, 'Scout Hunt', { objectives: [{ type: 'kill', id: 26, count: 3 }] }),
		938: extraQuest(938, 'Desperate Times', { objectiveText: 'Speak with Kalaran and follow his instructions.', objectives: [{ type: 'kill', id: 24, count: null }, { type: 'kill', id: 26, count: null }] }),
	});
	Object.assign(d.npcs, {
		24: { id: 24, name: 'Kalaran', level: 48, rank: 1, faction: 'AH', spawns: { [VALE]: { f: 'e', pts: [[60, 40]] } } },
		25: { id: 25, name: 'Threshwackonator', level: 20, rank: 1, faction: 'AH', spawns: { [VALE]: { f: 'e', pts: [[62, 40]] } } },
		26: { id: 26, name: 'Alliance Scout', level: 4, faction: 'A', spawns: { [VALE]: { f: 'e', pts: [[64, 40], [65, 40]] } } },
	});
	const w = build(d);
	const q = (id) => w.quests.find((x) => x.id === id);
	assert.deepEqual(q(927).tasks.map((t) => t.work), [[['use', 1]]]);
	assert.equal(q(927).elite, false);
	assert.deepEqual(q(928).tasks[0].work, [['use', 1]]);
	assert.equal(w.points[q(928).tasks[0].pt][4], FIELD); // at the warden
	assert.equal(why(w, 929).category, 'elite');
	assert.equal(q(934).tasks[0].work[0][0], 'kill'); // the other faction's NPC is fought
	// In a conversation quest the other faction's NPC is its counterpart: no work.
	assert.deepEqual(q(938).tasks.flatMap((t) => t.work), [['use', 1]]);
});

test('rescues read as escorts, counted events as that many interactions, deeds on own-faction NPCs as interactions, a handed-over starting item at its giver (regression: 98430, 98389, Lazy Peons, Tome of Divinity 1642)', () => {
	const d = data({
		940: extraQuest(940, 'Out of the Den', { objectiveText: 'Help Perith escape the den, and report his safety.', objectives: [{ type: 'event', id: null, count: null, text: 'Escort Perith out of the den', map: VALE, f: 'e', x: 70, y: 30 }] }),
		941: extraQuest(941, 'Webbed', { objectiveText: 'Free the webbed victims.', objectives: [{ type: 'event', id: null, count: null, text: 'Free 6 Webbed Victims', map: VALE, f: 'e', x: 72, y: 30 }] }),
		942: extraQuest(942, 'Lazy Grunts', { objectiveText: 'Use the blackjack on Lazy Grunts when they sleep.', objectives: [{ type: 'kill', id: 27, count: 5 }] }),
		943: extraQuest(943, 'Tome Turn-in', { repeatable: true, objectives: [{ type: 'kill', id: 10, count: 1 }] }),
		944: extraQuest(944, 'The Tome', { start: { npc: [], object: [], item: [207] }, end: { npc: [2], object: [] } }),
	});
	d.npcs[27] = { id: 27, name: 'Lazy Grunt', level: 4, faction: 'H', spawns: { [VALE]: { f: 'e', pts: [[66, 40], [67, 40]] } } };
	d.items[207] = { id: 207, name: 'Tome', drops: { npc: {}, object: {} }, vendors: [] };
	const w = build(d, { ...OVR, startItemFrom: { 944: 943 } });
	const q = (id) => w.quests.find((x) => x.id === id);
	assert.deepEqual(q(940).tasks.map((t) => t.work), [[['escort']]]);
	assert.equal(q(940).escort, true);
	assert.deepEqual(q(941).tasks.map((t) => t.work), [[['use', 6]]]);
	assert.deepEqual(q(942).tasks.map((t) => t.work), [[['use', 5]]]);
	assert.ok(has(w, 943), 'the no-XP repeatable stays: its turn-in hands over the tome');
	assert.equal(q(944).startFrom, 943);
	assert.deepEqual(q(944).preAll, [943]);
	assert.equal(q(944).giver, q(943).ender, 'the tome quest starts where the tome is handed over');
});

test('instance areas and dungeons.json mark candidates: only work outside the open world makes a dungeon/pvp quest (regression: 2864, 721, 8263, 6562, 97289)', () => {
	const d = data({
		921: extraQuest(921, 'Crypt Rumours', { area: 7001 }), // talk-only, both ends outside
		922: extraQuest(922, 'Crypt Approach', { area: 7001, objectives: [{ type: 'kill', id: 10, count: 2 }] }),
		923: extraQuest(923, 'Crypt Relic', { area: 7001, objectives: [{ type: 'item', id: 207, count: 1 }] }),
		924: extraQuest(924, 'Basin Care Package', { area: 7003 }),
		925: extraQuest(925, 'Inner Warden', { area: 7001, start: { npc: [23], object: [], item: [] } }),
	});
	d.items[207] = { id: 207, name: 'Crypt Relic', drops: { npc: {}, object: {} }, vendors: [] };
	// 601 (dungeons.json) with its objective in the open world stays a solo quest.
	d.quests[601] = { ...d.quests[504], id: 601, title: 'Into the Hollow', objectives: [{ type: 'kill', id: 12, count: 1 }] };
	const w = build(d);
	for (const id of [921, 922, 924, 601]) assert.ok(has(w, id), `quest ${id} kept`);
	assert.equal(w.quests.find((x) => x.id === 601).dungeon, undefined);
	assert.equal(why(w, 923).category, 'dungeon'); // its item exists nowhere outside
	assert.equal(why(w, 925).category, 'dungeon'); // its giver is inside
	assert.equal(why(w, 901).category, 'dungeon'); // its mob is inside
});

test('turninAfter: parents wait for the no-XP children whose work they need (812 <- 813, 5060 <- 5059, 1190 <- 1191)', () => {
	const kill = [{ type: 'kill', id: 10, count: 2 }];
	const d = data({
		812: extraQuest(812, 'Need for a Cure', { objectives: kill }),
		813: extraQuest(813, 'Finding the Antidote', { parent: 812, repeatable: true, objectives: [{ type: 'item', id: 100, count: 1 }] }),
		5060: extraQuest(5060, 'Locked Away', { objectives: kill }),
		5059: extraQuest(5059, 'Locked Away (outhouse)', { repeatable: true, objectives: kill }),
		1190: extraQuest(1190, 'Keeping Pace', { objectives: kill }),
		1191: extraQuest(1191, "Zamek's Distraction", { repeatable: true, objectives: kill }),
	});
	const w = build(d, solo.OVERRIDES);
	for (const [parent, kid] of [[812, 813], [5060, 5059], [1190, 1191]]) {
		assert.deepEqual(w.quests.find((x) => x.id === parent).after, [kid]);
		assert.equal(w.quests.find((x) => x.id === kid).noXp, true, `${kid} kept, no XP`);
	}
	const { run, ev } = evaluator(w);
	const P = run.qIndex.get(5060);
	ev.active[P] = 1;
	for (let i = run.qTask0[P]; i < run.qTask1[P]; i++) ev.taskDone[i] = 1;
	ev.step(2, P, -1, run.qEnder[P]);
	assert.equal(ev.done[P], 0, '5060 held until 5059 is turned in');
	ev.done[run.qIndex.get(5059)] = 1;
	ev.step(2, P, -1, run.qEnder[P]);
	assert.equal(ev.done[P], 1);
	// Without the override 813 is a no-XP repeatable nobody needs.
	assert.equal(why(build(d), 813).category, 'repeatable');
});

test('allow also bypasses the profession rule: Cooking rank 1 quests 384 and 4161 stay, 7321 does not', () => {
	const cook = { skill: 185, skillLevel: 1, objectives: [{ type: 'kill', id: 10, count: 2 }] };
	const d = data({ 384: extraQuest(384, 'Beer Basted Boar Ribs', cook), 4161: extraQuest(4161, 'Recipe of the Kaldorei', cook), 7321: extraQuest(7321, 'Cooking Unverified', cook) });
	const w = build(d, solo.OVERRIDES);
	assert.ok(has(w, 384) && has(w, 4161));
	assert.equal(why(w, 7321).reason, 'profession');
	assert.equal(why(build(d), 384).reason, 'profession'); // not allowed: excluded
});

test('null-rate droppers: skipped only when a recorded dropper lives on the giver\'s landmass (regression: 92553 Galestrider on Zephras Isle; Kum\'isha stays rare)', () => {
	const ISLE = 99107;
	const d = data({
		935: extraQuest(935, 'Restocking the Larders', { level: 5, start: { npc: [27], object: [], item: [] }, end: { npc: [27], object: [] }, objectives: [{ type: 'item', id: 211, count: 8 }] }),
		936: extraQuest(936, 'To Serve', { objectives: [{ type: 'item', id: 212, count: 1 }] }),
		937: extraQuest(937, 'Sweet Amber', { objectives: [{ type: 'item', id: 213, count: 1 }] }),
	});
	d.zones[ISLE] = { id: ISLE, name: 'Testisle', areaId: null, parent: null, type: 3 };
	d['map-frames'].era[ISLE] = { c: 5, left: 0, right: -1000, top: 1000, bottom: 0 };
	Object.assign(d.npcs, {
		27: { id: 27, name: 'Isle Cook', level: 10, faction: 'AH', spawns: { [ISLE]: { f: 'e', pts: [[50, 50]] } } },
		28: { id: 28, name: 'Galestrider', level: 5, faction: null, spawns: { [ISLE]: { f: 'e', pts: [[30, 30], [31, 30], [32, 30]] } } },
	});
	Object.assign(d.items, {
		211: { id: 211, name: 'Strider Meat', drops: { npc: { 12: 35, 28: null }, object: {} }, vendors: [] },
		212: { id: 212, name: 'Flawless Sphere', questItem: true, drops: { npc: { 11: 0.01, 10: null }, object: {} }, vendors: [] },
		213: { id: 213, name: 'Truesilver Bar', drops: { npc: { 23: 75, 10: null }, object: {} }, vendors: [] }, // recorded only from a mob with no open-world site
	});
	const w = build(d);
	const meat = w.quests.find((x) => x.id === 935);
	assert.equal(w.points[meat.tasks[0].pt][4], ISLE, 'farmed on the isle');
	assert.deepEqual(meat.tasks[0].work[0].slice(0, 3), ['kill', 5, (8 * 100) / 30]);
	assert.equal(why(w, 936).category, 'rareDrop');
	assert.equal(why(w, 937).reason, 'item objective 213 drops only outside the open world');
});
