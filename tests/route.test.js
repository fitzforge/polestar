'use strict';
// `polestar draft`: route generation on the synthetic Testvale fixture
// (tests/fixtures/route). The guide text is checked the way the compiler and
// engine will read it: DSL grammar, quest order, conditions.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { spawnSync } = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');

const { draft, loadData } = require('../tools/lib/route');
const { makeProjector } = require('../tools/lib/route/geo');
const { nearestNeighbour, twoOpt, planTour, pathLength } = require('../tools/lib/route/tour');
const { mobXp, questXpShare, baseQuestXp, gain } = require('../tools/lib/game/xp');
const { compileSources } = require('../tools/lib/dsl/project');
const dslData = require('../tools/lib/dsl/data');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { tmpdir } = require('./helpers/tmp');

const ROOT = path.resolve(__dirname, '..');
const FIXTURE = path.join(__dirname, 'fixtures', 'route');
const CLI = path.join(ROOT, 'tools', 'polestar.js');

const fixture = () => loadData(FIXTURE);
const BASE = { faction: 'Alliance', race: 'Human', zones: ['Testvale'], levels: [1, 8] };
const run = (opts = {}, data = fixture()) => draft(data, { ...BASE, ...opts });

// ---------------------------------------------------------------- DSL
// The compiler's own parser (tools/lib/dsl/parse.js): a draft parses with no
// errors (compileDraft below also rules out warnings).
function parse(text) {
	const diag = new Diagnostics();
	const guide = parseGuide(text, 'draft.guide', diag);
	assert.deepEqual(diag.list.filter((d) => d.severity === 'error').map((d) => `${d.line}: ${d.message}`), [], 'the draft parses cleanly');
	return guide;
}

// A class condition as its class list ('WARRIOR'), or null.
const classesOf = (only) => (only && only.classes ? only.classes.join(',') : null);

// Flat goal list with the effective class condition of each goal.
function goals(text) {
	const { steps } = parse(text);
	const out = [];
	steps.forEach((s, si) => {
		for (const g of s.goals) out.push({ ...g, step: si, title: s.title, only: classesOf(g.only) || classesOf(s.only) });
	});
	return out;
}

const questOf = (g) => (g.quest != null ? g.quest : null);

// Order invariants against the data: accept after a prerequisite's turn-in,
// objectives between accept and turn-in, turn-in after accept, each once.
function assertOrder(text, data) {
	const accepted = new Map();
	const turned = new Map();
	goals(text).forEach((g, i) => {
		const q = questOf(g);
		if (q == null) return;
		const raw = data.quests[String(q)];
		assert.ok(raw, `quest ${q} exists in data`);
		if (g.verb === 'accept') {
			assert.ok(!accepted.has(q), `quest ${q} accepted once`);
			const pre = (raw.pre || []).filter((p) => data.quests[String(p)]);
			if (pre.length) assert.ok(pre.some((p) => turned.has(p)), `accept ${q} comes after turning in one of ${pre}`);
			accepted.set(q, i);
		} else if (g.verb === 'turnin') {
			assert.ok(accepted.has(q), `turnin ${q} comes after accept ${q}`);
			assert.ok(!turned.has(q), `quest ${q} turned in once`);
			turned.set(q, i);
		} else {
			assert.ok(accepted.has(q) && !turned.has(q), `${g.verb} for quest ${q} lies between its accept and turn-in (line ${g.line})`);
		}
	});
	return { accepted, turned };
}

const ids = (text, verb) => goals(text).filter((g) => g.verb === verb).map((g) => g.quest);

// The real compiler (parse, resolve, validate) on a draft: no errors and no
// warnings; returns the compiled goals in order.
function compileDraft(text) {
	const { guides, diag } = compileSources([{ file: 'draft.guide', text }], dslData.loadData(FIXTURE));
	assert.deepEqual(diag.list.map((d) => `${d.line}: ${d.message}`), [], 'the draft compiles cleanly');
	return guides[0].steps.flatMap((s) => s.goals);
}

// ---------------------------------------------------------------- tests

test('the fixture route follows the DSL and the quest dependency order', () => {
	const data = fixture();
	for (const opts of [{}, { class: 'Warrior' }, { race: 'Dwarf', class: 'Priest' }, { levels: [7, 9] }, { keepBreadcrumbs: true }, { start: [30, 30] }, { startQuest: 105 }]) {
		const { text } = run(opts, data);
		const { header } = parse(text);
		assert.equal(header.faction, 'Alliance');
		const { accepted, turned } = assertOrder(text, data);
		compileDraft(text);
		// Everything accepted with a turn-in in the zone is turned in.
		for (const q of accepted.keys()) if (q !== 113) assert.ok(turned.has(q), `${JSON.stringify(opts)}: quest ${q} is turned in`);
	}
});

test('candidates: faction, race, profession, level cap, out-of-zone objectives and missing prerequisites are skipped', () => {
	const { text, report } = run();
	const seen = new Set(goals(text).map(questOf).filter((q) => q != null));
	for (const q of [110, 111, 112, 114, 116, 117, 119]) assert.ok(!seen.has(q), `quest ${q} is not in the route`);
	for (const q of [101, 102, 103, 104, 105, 115, 118, 120]) assert.ok(seen.has(q), `quest ${q} is in the route`);
	const reason = Object.fromEntries(report.excluded.map((e) => [e.id, e.reason]));
	assert.equal(reason[110], 'other race');
	assert.equal(reason[112], 'profession');
	assert.match(reason[114], /outside the zones/);
	assert.match(reason[116], /minimum level 20/);
	assert.match(reason[117], /prerequisite 999/);
	// Started by a Horde NPC: not a quest of this area for Alliance at all.
	assert.equal(reason[111], undefined);
	assert.ok(!seen.has(119));
});

test('race filtering follows the race bitmask', () => {
	assert.ok(!ids(run().text, 'accept').includes(110));
	assert.ok(ids(run({ race: 'Dwarf' }).text, 'accept').includes(110));
	assert.ok(ids(run({ race: 'Gnome' }).text, 'accept').every((q) => q !== 110));
	assert.throws(() => run({ race: 'Orc' }), /not a Alliance race/);
	// Skyborne has its own bit per side (2^32 Alliance): a Dwarf-only quest is not its.
	const r = run({ race: 'Skyborne' });
	assert.ok(!ids(r.text, 'accept').includes(110));
	assert.ok(!r.warnings.some((w) => /has no known bit/.test(w)));
	// A race with no known bit keeps only quests open to the whole faction.
	const n = run({ race: 'Newrace' });
	assert.ok(!ids(n.text, 'accept').includes(110));
	assert.ok(n.warnings.some((w) => /Newrace has no known bit/.test(w)));
	assert.ok(ids(run({ race: 'Skyborne:4' }).text, 'accept').includes(110), 'explicit race bit is honoured');
});

test('class quests: --class keeps only that class; without it they are gated with only', () => {
	const all = goals(run().text);
	const of = (list, q) => list.filter((g) => questOf(g) === q);
	assert.ok(of(all, 108).length >= 3 && of(all, 108).every((g) => g.only === 'WARRIOR'), 'warrior quest goals are only Warrior');
	assert.ok(of(all, 109).length >= 3 && of(all, 109).every((g) => g.only === 'PRIEST'), 'priest quest goals are only Priest');
	assert.ok(all.filter((g) => questOf(g) === 101).every((g) => g.only === null), 'normal quests are unconditional');

	const warrior = run({ class: 'Warrior' });
	const w = goals(warrior.text);
	assert.deepEqual(parse(warrior.text).header.classes, ['WARRIOR']);
	assert.ok(of(w, 108).length >= 3 && of(w, 108).every((g) => g.only === null));
	assert.equal(of(w, 109).length, 0);
	assert.equal(warrior.report.excluded.find((e) => e.id === 109).reason, 'other class');
	assert.throws(() => run({ class: 'Monk' }), /unknown class/);
});

test('exclusive groups: exactly one member is routed, preferring the one that unlocks follow-ups', () => {
	const data = fixture();
	const acc = ids(run({}, data).text, 'accept');
	assert.ok(acc.includes(107) && !acc.includes(106), '107 unlocks 118, so it wins');
	assert.ok(acc.includes(118));
	delete data.quests['118'];
	const acc2 = ids(run({}, data).text, 'accept');
	assert.equal(acc2.filter((q) => q === 106 || q === 107).length, 1, 'still exactly one of the pair');
	assert.ok(acc2.includes(106), 'tie on unlocks and XP: lowest id');
});

test('level gating inserts a level step only when the estimated XP falls short', () => {
	const data = fixture();
	const text = run({}, data).text;
	const list = goals(text);
	const levels = list.filter((g) => g.verb === 'level').map((g) => g.level);
	assert.deepEqual(levels, [6, 7]);
	const at = (pred) => list.findIndex(pred);
	assert.ok(at((g) => g.verb === 'level' && g.level === 6) < at((g) => g.verb === 'accept' && g.quest === 120));
	assert.ok(at((g) => g.verb === 'level' && g.level === 7) < at((g) => g.verb === 'accept' && g.quest === 115));
	// The grind step stands at an objective area with coordinates.
	const grind = parse(text).steps.find((s) => s.goals.some((g) => g.verb === 'level'));
	assert.equal(grind.goals[0].verb, 'goto');
	assert.equal(grind.goals[0].text, 'Bandit Lookout');

	// Plenty of XP from the same quests: no grinding.
	const rich = fixture();
	for (const q of Object.values(rich.quests)) q.xp = 5000;
	assert.equal(goals(run({}, rich).text).filter((g) => g.verb === 'level').length, 0);
	// No level gates: no grinding either.
	const open = fixture();
	open.quests['115'].minLevel = 1;
	open.quests['120'].minLevel = 1;
	assert.equal(goals(run({}, open).text).filter((g) => g.verb === 'level').length, 0);
	// Starting high enough: no grinding.
	assert.equal(goals(run({ levels: [7, 9] }).text).filter((g) => g.verb === 'level').length, 0);
});

test('objective steps: kill/collect linked to the quest objective, planned at the densest spawn cluster', () => {
	const { text, plan } = run();
	const { steps } = parse(text);
	const kobolds = steps.find((s) => s.goals.some((g) => g.verb === 'kill' && g.quest === 101));
	assert.equal(kobolds.title, 'Kobold Vermin');
	// The kill leads there itself (spawn areas from the data): no goto first.
	assert.equal(kobolds.goals[0].verb, 'kill');
	const ev = plan.events.find((e) => (e.goals || []).some((g) => g.verb === 'kill' && g.q.id === 101));
	assert.deepEqual([ev.pt.x, ev.pt.y], [30, 30], 'the 6-spawn camp, not the 2 stragglers at 70,70');
	const kill = kobolds.goals.find((g) => g.verb === 'kill');
	assert.deepEqual([kill.npc, kill.count, kill.oi], [5, 8, 1]);
	// Wolf pelts (item drop) and the wolf kills share one stop.
	const wolves = steps.find((s) => s.goals.some((g) => g.verb === 'collect' && g.quest === 102));
	assert.ok(wolves.goals.some((g) => g.verb === 'kill' && g.quest === 107));
	// Item-started quest: accept with its item at the drop source.
	const letter = steps.find((s) => s.goals.some((g) => g.verb === 'accept' && g.quest === 120));
	assert.equal(letter.goals.find((g) => g.verb === 'accept').item, 701);
	assert.equal(letter.goals[0].verb, 'goto');
});

test('hubs: everything available at an NPC is accepted in one step, follow-ups flow on turn-in', () => {
	const { steps } = parse(run().text);
	assert.equal(steps[0].title, 'Marshal Ash');
	assert.deepEqual(steps[0].goals.map((g) => `${g.verb} ${g.quest}`), ['accept 101', 'accept 107']);
	const back = steps.find((s) => s.goals.some((g) => g.verb === 'turnin' && g.quest === 101));
	const order = back.goals.map((g) => `${g.verb} ${g.quest}`);
	assert.ok(order.indexOf('turnin 101') < order.indexOf('accept 103'), 'follow-up accepted in the same visit');
	assert.ok(order.indexOf('turnin 107') < order.indexOf('accept 118'));
});

test('train visits at even levels when a trainer is known', () => {
	const warrior = goals(run({ class: 'Warrior' }).text).filter((g) => g.verb === 'train');
	assert.ok(warrior.length >= 2, 'periodic visits');
	assert.ok(warrior.every((g) => g.npc === 4 && g.only === null));
	const all = goals(run().text).filter((g) => g.verb === 'train');
	assert.ok(all.some((g) => g.npc === 4 && g.only === 'WARRIOR'));
	assert.ok(all.some((g) => g.npc === 12 && g.only === 'PRIEST'));
	// No trainer data: none, unless given explicitly.
	const data = fixture();
	delete data.npcs['4'].title;
	assert.equal(goals(run({ class: 'Warrior' }, data).text).filter((g) => g.verb === 'train').length, 0);
	assert.ok(goals(run({ class: 'Warrior', trainers: [['Warrior', 4]] }, data).text).some((g) => g.verb === 'train' && g.npc === 4));
	assert.equal(goals(run({ class: 'Rogue' }).text).filter((g) => g.verb === 'train').length, 0);
});

test('breadcrumbs out of the area become a final optional accept only with keepBreadcrumbs', () => {
	assert.ok(!ids(run().text, 'accept').includes(113));
	const { steps } = parse(run({ keepBreadcrumbs: true }).text);
	const last = steps[steps.length - 1];
	assert.equal(last.title, 'Marshal Ash');
	const tail = last.goals[last.goals.length - 1];
	assert.deepEqual([tail.verb, tail.quest, tail.optional], ['accept', 113, true], 'the guide ends on the optional accept');
	assert.equal(goals(run({ keepBreadcrumbs: true }).text).filter((g) => g.optional).length, 1);
});

test('done quests satisfy prerequisites and drop out of the route', () => {
	const { text } = run({ done: [101] });
	assert.ok(!ids(text, 'accept').includes(101));
	assert.ok(ids(text, 'accept').includes(103), 'follow-up of a done quest is available');
	assert.equal(goals(text).filter((g) => g.verb === 'turnin' && g.quest === 103).length, 1);
	const after107 = run({ done: [107] });
	assert.ok(!ids(after107.text, 'accept').includes(106), 'a done quest closes its exclusive group');
	assert.ok(ids(after107.text, 'accept').includes(118), 'and unlocks its follow-up');
	assert.match(after107.report.excluded.find((e) => e.id === 106).reason, /exclusive with 107 \(done\)/);
});

test('world distances come from the Era map bounds, not raw map percent', () => {
	// A 4000 x 500 yard map: 10% east is 400 yd, 30% south is 150 yd.
	const data = {
		zones: { 1: { id: 1, name: 'Longvale', type: 3 } },
		'map-frames': { era: { 1: { c: 0, left: 2000, right: -2000, top: 250, bottom: -250 } } },
		npcs: {
			1: { id: 1, name: 'Giver', faction: 'AH', spawns: { 1: { f: 'e', pts: [[50, 50]] } } },
			2: { id: 2, name: 'East Rat', level: 1, spawns: { 1: { f: 'e', pts: [[60, 50]] } } },
			3: { id: 3, name: 'South Rat', level: 1, spawns: { 1: { f: 'e', pts: [[50, 80]] } } },
			4: { id: 4, name: 'Far Ender', faction: 'AH', spawns: { 1: { f: 'e', pts: [[90, 50]] } } },
		},
		objects: {},
		items: {},
		quests: {
			1: { id: 1, title: 'Rats', level: 1, minLevel: 1, start: { npc: [1] }, end: { npc: [4] }, objectives: [{ type: 'kill', id: 2, count: 1 }, { type: 'kill', id: 3, count: 1 }] },
		},
	};
	const titles = parse(draft(data, { ...BASE, zones: ['Longvale'], levels: [1, 2] }).text).steps.map((s) => s.title);
	assert.deepEqual(titles, ['Giver', 'South Rat', 'East Rat', 'Far Ender']);
	const p = makeProjector(data['map-frames']);
	const a = p.point(1, 0, 0);
	const b = p.point(1, 100, 100);
	assert.deepEqual([a.wx, a.wy, b.wx, b.wy], [250, 2000, -250, -2000]);
});

function rng(seed) {
	let s = seed >>> 0;
	return () => {
		s = (s + 0x6d2b79f5) >>> 0;
		let t = s;
		t = Math.imul(t ^ (t >>> 15), t | 1);
		t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
		return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
	};
}

test('2-opt never lengthens a route and removes crossings', () => {
	const p = makeProjector({ era: { 1: { c: 0, left: 1000, right: -1000, top: 1000, bottom: -1000 } } });
	const rand = rng(7);
	for (let k = 0; k < 200; k++) {
		const n = 2 + Math.floor(rand() * 14);
		const nodes = Array.from({ length: n }, () => ({ pt: p.point(1, rand() * 100, rand() * 100) }));
		const start = p.point(1, rand() * 100, rand() * 100);
		const end = k % 2 ? p.point(1, rand() * 100, rand() * 100) : null;
		for (const order of [nodes, nearestNeighbour(start, nodes)]) {
			const before = pathLength(start, order, end);
			const after = twoOpt(start, order, end);
			assert.ok(pathLength(start, after, end) <= before + 1e-9, `case ${k}: 2-opt lengthened the route`);
			assert.deepEqual(after.slice().sort((x, y) => nodes.indexOf(x) - nodes.indexOf(y)), nodes, 'same nodes, each once');
		}
		assert.ok(pathLength(start, planTour(start, nodes, end), end) <= pathLength(start, nearestNeighbour(start, nodes), end) + 1e-9);
	}
	// A crossing path on a square gets uncrossed.
	const sq = [[0, 0], [100, 100], [100, 0], [0, 100]].map(([x, y]) => ({ pt: p.point(1, x, y) }));
	const fixed = twoOpt(p.point(1, 0, 0), sq.slice(1), null);
	assert.ok(pathLength(p.point(1, 0, 0), fixed, null) < pathLength(p.point(1, 0, 0), sq.slice(1), null));
});

test('exploration objectives: a goto at the nearest in-zone trigger, between accept and turn-in', () => {
	const { text, report } = run();
	const list = goals(text);
	const at = (verb, q) => list.findIndex((g) => g.verb === verb && g.quest === q);
	const scout = list.findIndex((g) => g.verb === 'goto' && g.text === 'Scout the Old Mine');
	assert.ok(at('accept', 121) >= 0 && at('accept', 121) < scout && scout < at('turnin', 121), 'goto lies between accept and turn-in');
	assert.deepEqual([list[scout].x, list[scout].y], [40, 12], 'of the two triggers, the one nearer Farmer Bell (51,50.5)');
	assert.equal(list[scout].frame, undefined, 'Era-frame trigger: the guide default frame');
	assert.equal(list.filter((g) => g.verb === 'goto' && g.text === 'Scout the Old Mine').length, 1, 'one stop for the exploration, not one per trigger');
	const compiled = compileDraft(text).filter((g) => g.t === 'goto' && g.text === 'Scout the Old Mine');
	assert.deepEqual(compiled.map((g) => [g.map, g.x, g.y, g.f]), [[9001, 40, 12, 'e']]);

	const reason = Object.fromEntries(report.excluded.map((e) => [e.id, e.reason]));
	assert.equal(reason[122], 'exploration objective outside the zones (map 9002)');
	assert.equal(reason[123], 'exploration objective has no location in data');
	// With its map in the route, the trigger there is used.
	const both = run({ zones: ['Testvale', 'Farshore'] });
	const steps = parse(both.text).steps;
	const far = steps.find((s) => s.goals.some((g) => g.verb === 'goto' && g.text === 'Scout the Far Shore'));
	assert.equal(far.goals.find((g) => g.verb === 'goto').zone.name, 'Farshore');
	assertOrder(both.text, fixture());
	compileDraft(both.text);
});

test('object objectives: interact with the quest link, no count', () => {
	const { text } = run();
	const line = text.split('\n').find((l) => /^\s+interact 52\b/.test(l));
	assert.equal(line.trim(), 'interact 52 quest 124.1');
	const g = compileDraft(text).find((x) => x.t === 'interact');
	assert.deepEqual([g.object, g.quest, g.oi, g.count], [52, 124, 1, undefined]);
});

test('coordinates from live-frame (recorded) spawns are marked live', () => {
	const data = fixture();
	data.npcs['10'].spawns['9001'].f = 'l';
	const { text } = run({}, data);
	// The grind spot of the Bandit Lookouts (kill objectives get no goto).
	const bandits = goals(text).filter((g) => g.verb === 'goto' && g.text === 'Bandit Lookout');
	assert.ok(bandits.length > 0);
	for (const g of bandits) assert.equal(g.frame, 'live');
	const scout = goals(text).find((g) => g.verb === 'goto' && g.text === 'Scout the Old Mine');
	assert.equal(scout.frame, undefined);
});

test('XP heuristics: Forever level-difference rules (players\' recordings: half from 8 over on)', () => {
	assert.equal(questXpShare(10, 5), 1);
	assert.equal(questXpShare(11, 5), 0.8);
	assert.equal(questXpShare(20, 5), 0.5);
	assert.equal(baseQuestXp(1), 100);
	assert.equal(baseQuestXp(10), 800);
	assert.equal(mobXp(10, 10), 95);
	assert.equal(mobXp(10, 14), Math.round(95 * 1.2));
	assert.equal(mobXp(10, 4), 0, 'grey mob');
	const s = { level: 1, xp: 0 };
	assert.equal(gain(s, 1350), 2);
	assert.deepEqual(s, { level: 3, xp: 50 });
});

test('output is deterministic, independent of data key order', () => {
	const a = run({ keepBreadcrumbs: true }).text;
	const b = run({ keepBreadcrumbs: true }).text;
	assert.equal(a, b);
	const shuffled = fixture();
	for (const k of ['quests', 'npcs', 'objects', 'items']) {
		shuffled[k] = Object.fromEntries(Object.entries(shuffled[k]).reverse().map(([id, v]) => {
			if (v.spawns) for (const sp of Object.values(v.spawns)) sp.pts = sp.pts.slice().reverse();
			return [id, v];
		}));
	}
	assert.equal(run({ keepBreadcrumbs: true }, shuffled).text, a);
});

test('CLI: draft writes the same guide to stdout and --out, and rejects bad arguments', () => {
	const args = ['draft', '--data', FIXTURE, '--faction', 'Alliance', '--race', 'Human', '--zone', 'Testvale', '--levels', '1-8', '--next', 'forever/alliance/human/02-next', '--quiet'];
	const out = spawnSync(process.execPath, [CLI, ...args], { encoding: 'utf8' });
	assert.equal(out.status, 0, out.stderr);
	const { id, header } = parse(out.stdout);
	assert.equal(id, 'forever/alliance/human/testvale-1-8');
	assert.deepEqual(header, {
		title: 'Testvale 1-8', faction: 'Alliance', races: ['Human'],
		levels: { min: 1, max: 8 }, zone: { name: 'Testvale', line: 6 }, next: ['forever/alliance/human/02-next'],
	});
	const dir = tmpdir('polestar-route-');
	const file = path.join(dir, 'sub', 'draft.guide');
	const r = spawnSync(process.execPath, [CLI, ...args.filter((a) => a !== '--quiet'), '--out', file], { encoding: 'utf8' });
	assert.equal(r.status, 0, r.stderr);
	assert.equal(r.stdout, '');
	assert.equal(fs.readFileSync(file, 'utf8'), out.stdout);
	assert.match(r.stderr, /quests routed/);
	assert.match(r.stderr, /skipped 112 "Fishing Lessons": profession/);
	// --done from a previous guide's turn-ins.
	const d = spawnSync(process.execPath, [CLI, ...args, '--done', file], { encoding: 'utf8' });
	assert.equal(d.status, 1, 'every quest done: nothing left to route');
	assert.match(d.stderr, /no quest is available/);
	for (const bad of [
		['--levels', '8-1'],
		['--levels', 'x'],
		['--start', '10,10', '--start-quest', '101'],
		['--bogus'],
		['--id', 'Bad Id'],
	]) {
		const base = ['draft', '--data', FIXTURE, '--faction', 'Alliance', '--race', 'Human', '--zone', 'Testvale'];
		const withLevels = bad[0] === '--levels' ? bad : ['--levels', '1-8', ...bad];
		const r = spawnSync(process.execPath, [CLI, ...base, ...withLevels], { encoding: 'utf8' });
		assert.notEqual(r.status, 0, `rejects ${bad.join(' ')}`);
	}
	const unknownZone = spawnSync(process.execPath, [CLI, 'draft', '--data', FIXTURE, '--faction', 'Alliance', '--race', 'Human', '--zone', 'Nowhere', '--levels', '1-8'], { encoding: 'utf8' });
	assert.equal(unknownZone.status, 1);
	assert.match(unknownZone.stderr, /unknown zone "Nowhere"/);
});
