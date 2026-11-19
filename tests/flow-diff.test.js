'use strict';
// flow-diff's numbers (tools/lib/flowdiff/analyse.js, `polestar flow-diff`) on made-up plays: zone revisits across
// guides, one-quest trips, walks to a stop with nothing there, carried spans, travel and moved quests. The plays
// themselves (tools/lib/flowdiff/play.js) need two trees and data/forever; these only need the dumps' shape.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { Proj } = require('../tools/lib/flow/data');
const { measure, compare, narrow, renderMd, tripsOf, stopsOf, placed, travel } = require('../tools/lib/flowdiff/analyse');
const { traced, branchesOf } = require('../tools/lib/flowdiff/play');

// Two zones side by side on one continent, 10 yd per map percent: map 1 "West" from x 0 to 1,000 yd, map 2 "East"
// from 1,000 to 2,000. A place is [continent, the frame's top-to-bottom yards, left-to-right yards].
const ctx = {
	proj: new Proj({ era: { 1: { c: 0, top: 0, bottom: 1000, left: 0, right: 1000 }, 2: { c: 0, top: 0, bottom: 1000, left: 1000, right: 2000 } } }),
	zones: { 1: { name: 'West' }, 2: { name: 'East' } },
	nodes: new Map([[7, [0, 500, 1500, 2]]]),
	legs: {},
	tripYd: 300,
};

const act = (s, t, q, map, x, y) => ({ s, t, q, map, x, y, lv: 30 });
const steps = (n) => Array.from({ length: n }, (_, i) => ({ title: `Step ${i + 1}`, goals: [] }));

// A dump of two guides on one Horde branch, A then B.
function dump(a, b, { guideA = steps(10), guideB = steps(10) } = {}) {
	return {
		guides: { 'x/a': { title: 'A', steps: guideA, legs: null }, 'x/b': { title: 'B', steps: guideB, legs: null } },
		branches: [{ start: 'Orc', race: 'Orc', faction: 'Horde', guides: ['x/a', 'x/b'] }],
		plays: {
			'x/a|Horde': { race: 'Orc', cls: 'WARRIOR', ok: true, stuck: null, trace: a },
			'x/b|Horde': { race: 'Orc', cls: 'WARRIOR', ok: true, stuck: null, trace: b },
		},
	};
}

const westThenEast = [act(1, 'accept', 1, 1, 10, 10), act(2, 'kill', 1, 1, 12, 10), act(3, 'goto', null, 2, 10, 10), act(4, 'turnin', 1, 2, 10, 10)];

test('a guide that goes back into a zone the route had left is a new revisit, across guides', () => {
	const base = dump(westThenEast, [act(1, 'accept', 2, 2, 20, 20), act(2, 'turnin', 2, 2, 22, 20)]);
	const head = dump(westThenEast, [act(1, 'accept', 2, 2, 20, 20), act(2, 'kill', 2, 1, 50, 50), act(3, 'turnin', 2, 2, 22, 20)]);
	const diff = compare(measure(base, ctx), measure(head, ctx));
	assert.equal(diff.revisits.added.length, 2, 'back into West from East, then back into East');
	const west = diff.revisits.added.find((r) => r.zone === 'West');
	assert.deepEqual([west.guide, west.s, west.left, west.from, west.branches], ['x/b', 2, 'x/a', 'East', ['Orc/Horde']]);
	assert.equal(diff.blocking >= 2, true);
	const row = diff.guides.find((g) => g.guide === 'x/b');
	assert.deepEqual(row.head.zones, ['East', 'West', 'East']);
	assert.deepEqual(row.base.zones, ['East']);
});

test('a revisit the allow file names with a reason does not block', () => {
	const base = dump(westThenEast, [act(1, 'turnin', 3, 2, 20, 20)]);
	const head = dump(westThenEast, [act(1, 'turnin', 3, 2, 20, 20), act(2, 'turnin', 4, 1, 12, 10), act(3, 'turnin', 3, 2, 20, 20)]);
	const allow = [
		{ kind: 'revisit', guide: 'x/b', zone: 'West', reason: 'a hand-in on the way' },
		{ kind: 'revisit', guide: 'x/b', zone: 'East', reason: 'back to the road' },
		{ kind: 'trip', guide: 'x/b', quest: 4, reason: 'the hand-in is next to the road' },
	];
	const diff = compare(measure(base, ctx), measure(head, ctx), { allow });
	assert.equal(diff.blocking, 0);
	assert.equal(diff.revisits.added.find((r) => r.zone === 'West').allowed, 'a hand-in on the way');
});

test('one quest far from the work before and after it is a one-quest trip; one next to it is not', () => {
	const acts = (x) => placed([act(1, 'accept', 1, 1, 10, 10), act(1, 'accept', 2, 1, 10, 10), act(2, 'kill', 3, 1, x, 10), act(3, 'turnin', 1, 1, 10, 12), act(3, 'turnin', 2, 1, 10, 12)], ctx);
	const g = { steps: steps(3) };
	const far = tripsOf('x/a', stopsOf(acts(60), g), 300);
	assert.equal(far.length, 1);
	assert.deepEqual([far[0].kind, far[0].quest, far[0].s, far[0].fromYd, far[0].toYd], ['one-quest', 3, 2, 500, 500]);
	assert.deepEqual(tripsOf('x/a', stopsOf(acts(20), g), 300), [], '100 yards away is on the way');
	assert.deepEqual(tripsOf('x/a', stopsOf(acts(60), g), 600), [], '--trip-yd 600');
	// Another zone counts as far, however close.
	const east = placed([act(1, 'accept', 1, 1, 99, 10), act(2, 'kill', 3, 2, 1, 10), act(3, 'turnin', 1, 1, 99, 11)], ctx);
	assert.equal(tripsOf('x/a', stopsOf(east, g), 300)[0].zone, 'East');
});

test('a walk to a place with nothing to do, out of the way, is an empty trip (#2154)', () => {
	const g = { steps: steps(4) };
	// Tarren Mill (10,10) -> a walk to Strahnbrad (10,60) -> the ruins (40,15): 500 + 541 - 304 yd out of the way.
	const held = placed([act(1, 'turnin', 1, 1, 10, 10), act(2, 'goto', null, 1, 10, 60), act(3, 'kill', 2, 1, 40, 15)], ctx);
	const [trip] = tripsOf('x/a', stopsOf(held, g), 300);
	assert.deepEqual([trip.kind, trip.s, trip.quest, trip.detourYd], ['empty', 2, null, 737]);
	// A walk on the way to the work is none.
	const onWay = placed([act(1, 'turnin', 1, 1, 10, 10), act(2, 'goto', null, 1, 25, 12), act(3, 'kill', 2, 1, 40, 15)], ctx);
	assert.deepEqual(tripsOf('x/a', stopsOf(onWay, g), 300), []);
	// Nor is a walk to a flight master.
	const flight = placed([act(1, 'turnin', 1, 1, 10, 10), act(2, 'goto', null, 1, 10, 60), { s: 2, t: 'fly', node: 7 }, act(3, 'kill', 2, 2, 40, 15)], ctx);
	assert.deepEqual(tripsOf('x/a', stopsOf(flight, g), 300), []);
	// The diff: the head's engine passes the walk, so the trip is gone.
	const base = dump([act(1, 'turnin', 1, 1, 10, 10), act(2, 'goto', null, 1, 10, 60), act(3, 'kill', 2, 1, 40, 15)], []);
	const head = dump([act(1, 'turnin', 1, 1, 10, 10), act(3, 'kill', 2, 1, 40, 15)], []);
	const diff = compare(measure(base, ctx), measure(head, ctx));
	assert.equal(diff.trips.gone.length, 1);
	assert.equal(diff.trips.added.length, 0);
	assert.equal(diff.blocking, 0);
	const row = diff.guides.find((x) => x.guide === 'x/a');
	assert.ok(row.head.travel.walk < row.base.travel.walk, 'less walking');
	assert.match(renderMd(diff), /Trips gone[\s\S]*a walk with nothing there/);
});

test('a quest handed in more guides after its accept is carried longer', () => {
	const base = dump([act(1, 'accept', 5, 1, 10, 10), act(2, 'turnin', 5, 1, 10, 10)], [act(1, 'accept', 6, 2, 10, 10)]);
	const head = dump([act(1, 'accept', 5, 1, 10, 10)], [act(1, 'accept', 6, 2, 10, 10), act(2, 'turnin', 5, 2, 10, 10)]);
	const diff = compare(measure(base, ctx), measure(head, ctx));
	assert.deepEqual(diff.carried, [{ quest: 5, branch: 'Orc/Horde', base: { from: 'x/a', to: 'x/a', span: 0 }, head: { from: 'x/a', to: 'x/b', span: 1 } }]);
	assert.match(renderMd(diff), /quest 5 \(Orc\/Horde\): within x\/a, now x\/a -> x\/b \(1 guide on\)/);
});

test('an accept written in another step is a moved quest: old place -> new place', () => {
	const a = steps(3);
	a[0].goals = [{ t: 'accept', q: 9 }];
	const b = steps(3);
	b[2].goals = [{ t: 'accept', q: 9 }];
	const diff = compare(measure(dump([], [], { guideA: a }), ctx), measure(dump([], [], { guideB: b }), ctx));
	assert.deepEqual(diff.moved, [{ quest: 9, verb: 'accept', from: [{ guide: 'x/a', step: 1, title: 'Step 1' }], to: [{ guide: 'x/b', step: 3, title: 'Step 3' }] }]);
	assert.match(renderMd(diff), /accept 9: x\/a step 1 "Step 1" -> x\/b step 3 "Step 3"/);
});

test('a step put in before a quest does not move it; a later visit to a town of the same name does', () => {
	const town = (q) => ({ title: 'Tarren Mill', goals: q ? [{ t: 'accept', q }] : [] });
	const field = { title: 'Field', goals: [{ t: 'turnin', q: 7 }] };
	const base = [town(1), field, town(2), field, town(null)];
	const inserted = [town(null), town(1), field, town(2), field, town(null)];
	const later = [town(1), field, town(null), field, town(2)];
	const moved = (b) => compare(measure(dump([], [], { guideA: base }), ctx), measure(dump([], [], { guideA: b }), ctx)).moved.filter((m) => m.from.length || m.to.length);
	assert.deepEqual(moved(inserted), []);
	assert.deepEqual(moved(later), [{ quest: 2, verb: 'accept', from: [{ guide: 'x/a', step: 3, title: 'Tarren Mill' }], to: [{ guide: 'x/a', step: 5, title: 'Tarren Mill' }] }]);
});

test('--guides keeps only what concerns the named guides, and what blocks is counted again', () => {
	const base = dump(westThenEast, [act(1, 'accept', 2, 2, 20, 20), act(2, 'turnin', 2, 2, 22, 20)]);
	const head = dump([...westThenEast, act(5, 'turnin', 8, 1, 50, 50)], [act(1, 'accept', 2, 2, 20, 20), act(2, 'kill', 2, 1, 50, 50), act(3, 'turnin', 2, 2, 22, 20)]);
	const diff = compare(measure(base, ctx), measure(head, ctx));
	assert.ok(diff.revisits.added.some((r) => r.guide === 'x/a') && diff.revisits.added.some((r) => r.guide === 'x/b'));
	narrow(diff, (id) => id.includes('x/a'));
	assert.deepEqual(diff.guides.map((g) => g.guide), ['x/a']);
	assert.ok(diff.revisits.added.every((r) => r.guide === 'x/a'));
	assert.equal(diff.blocking, diff.revisits.added.length + diff.trips.added.length);
});

test('travel: walking at 7 yd/s, a baked leg when it runs from where the player stands, flights at 30 yd/s', () => {
	const acts = placed([act(1, 'accept', 1, 1, 10, 10), act(2, 'kill', 1, 1, 10, 80), act(3, 'goto', null, 1, 10, 80), { s: 3, t: 'fly', node: 7 }], ctx);
	const plain = travel(acts, null);
	assert.equal(plain.yd, 700);
	assert.equal(plain.walk, 100);
	assert.equal(Math.round(plain.fly), Math.round((Math.hypot(500 - 800, 1500 - 100) * 1.25) / 30 + 30));
	assert.equal(travel(placed([act(1, 'accept', 1, 1, 10, 10), act(2, 'kill', 1, 1, 10, 80)], ctx), { 2: 'not a leg' }).yd, 700, 'a leg that does not decode is no leg');
});

test('the play traces SIMULATE through its own act() and skips quests first', () => {
	const sim = 'local function act(i, g, r)\n\tlocal t = g.t\nend\nfor _, g in ipairs(view.goals) do\n\tif g.status ~= "done" and g.status ~= "na" and not g.optional then open = g; break end\nend\n';
	assert.doesNotMatch(traced(sim, []), /SkipQuest|"skipped"/);
	const out = traced(sim, [533]);
	assert.match(out, /local function act\(i, g, r\)\n\tFLOW_ACT\(i, g, r\)/);
	assert.match(out, /Polestar\.Engine\.SkipQuest\(q\)/);
	assert.match(out, /g\.status ~= "na" and g\.status ~= "skipped" and not g\.optional/, 'a skipped goal is left alone');
	assert.match(out, /emit\(FLOW\)\n$/);
	assert.throws(() => traced('emit({})', []), /can't trace/);
	assert.throws(() => traced('local function act(i, g, r)\nend\n', [533]), /can't skip/);
});

test('branches: each start race down its guides\' default `next`, experimental choices left out', () => {
	const g = (id, extra) => ({ id, category: 'Leveling', faction: 'Horde', ...extra });
	const guides = [
		g('h/orc', { races: ['Orc', 'Troll'], next: 'h/barrens' }),
		g('h/barrens', { nextChoices: ['polestar-experimental/x', 'h/stv'] }),
		g('h/stv', {}),
	];
	assert.deepEqual(
		branchesOf(guides).map((b) => [b.start, b.guides.join(' > ')]),
		[
			['Orc', 'h/orc > h/barrens > h/stv'],
			['Troll', 'h/orc > h/barrens > h/stv'],
		],
	);
});
