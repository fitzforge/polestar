'use strict';
// Travel ending at a step snapshot belongs to the segment active before it.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { buildReport } = require('../tools/lib/recording/report');

const A = 'synthetic/a';
const B = 'synthetic/b';
const maps = { 1: { left: 0, right: 1000, top: 0, bottom: 1000 }, 2: { left: 0, right: 1000, top: 0, bottom: 1000 } };
const pos = (t, x, map = 1) => ({ e: 'pos', t, map, x, y: 50 });
const step = (t, n, x, guide = A, reason = 'step') => ({ ...pos(t, x), e: 'step', guide, step: n, reason, lvl: 1, xp: 0, xpMax: 400 });
const session = (events, started = 1) => ({ schema: 2, session: `movement-${started}`, started, char: { id: 'synthetic-player' }, maps, events });
const report = (events) => buildReport([session(events)]);
const row = (r, n, guide = A) => r.steps.find((s) => s.guide === guide && s.step === n);

test('incoming travel and detour rankings belong to the step just completed', () => {
	const r = report([step(0, 1, 10), step(100, 2, 80), step(200, 3, 90), step(300, 4, 90)]);
	assert.deepEqual([1, 2, 3].map((n) => row(r, n).medianYards), [700, 100, 0]);
	assert.deepEqual(r.detours.map((s) => s.step), [1]);
	assert.deepEqual([1, 2, 3].map((n) => row(r, n).medianTime), [100, 100, 100]);
});

test('a tab switch keeps the preceding walk on the previously active guide', () => {
	const r = report([step(0, 1, 50), step(100, 1, 60, B, 'guide'), step(200, 2, 60), step(300, 2, 60, B, 'guide')]);
	assert.equal(row(r, 1, A).medianYards, 100);
	assert.equal(row(r, 1, B).medianYards, 0);
});

test('same-step reload snapshots retain all movement in the continued pass', () => {
	const r = report([step(0, 1, 50), step(100, 1, 60, A, 'login'), step(200, 2, 70), step(300, 3, 70)]);
	assert.equal(row(r, 1).passes, 1);
	assert.equal(row(r, 1).medianYards, 200);
	assert.equal(row(r, 2).medianYards, 0);
});

test('walking during a revisit stays out of the frontier step pass', () => {
	const r = report([step(0, 1, 50), step(100, 2, 50), step(200, 1, 60), step(300, 2, 90), step(400, 3, 90)]);
	assert.equal(row(r, 1).medianYards, 0);
	assert.equal(row(r, 1).revisits, 1);
	assert.equal(row(r, 1).revisitTime, 100);
	assert.equal(row(r, 2).medianYards, 100);
});

test('the first positioned guide snapshot does not inherit earlier unassigned travel', () => {
	const r = report([pos(0, 40), step(100, 1, 50), step(200, 2, 50)]);
	assert.equal(row(r, 1).medianYards, 0);
});

test('taxi resets, map changes and teleport-speed jumps keep their existing exclusions', () => {
	const r = report([
		step(0, 1, 10),
		{ e: 'taxi', t: 50, fromNode: 1, toNode: 2 },
		{ ...pos(100, 80), e: 'land' }, // first position after the taxi reset starts a new trail
		pos(200, 90), // 100 yards walked after landing
		pos(300, 10, 2), // another map: no connecting distance
		pos(400, 20, 2), // 100 yards on that map
		pos(401, 90, 2), // 700 yd/s: teleport, not walking
		pos(500, 90, 2),
		{ ...step(600, 2, 90), map: 2 },
	]);
	assert.equal(row(r, 1).medianYards, 200);
});

test('a new session continues the pass without measuring movement while logged out', () => {
	const r = buildReport([
		session([step(0, 1, 50), pos(100, 60)]),
		session([step(0, 1, 10, A, 'login'), pos(100, 20), step(200, 2, 20)], 10000),
	]);
	assert.equal(row(r, 1).passes, 1);
	assert.equal(row(r, 1).medianYards, 200);
	assert.equal(row(r, 1).medianTime, 300);
});
