'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { buildReport } = require('../tools/lib/recording/report');

const guide = 'test/instance-travel';
const point = (x, map = 1429) => ({ map, x, y: 50 });
const snapshot = (t, reason, extra = {}) => ({
	t, e: 'step', v: 1, reason, guide, ...(reason === 'complete' ? {} : { step: 1 }),
	lvl: 1, xp: 0, xpMax: 400, ...extra,
});
const pos = (t, x) => ({ t, e: 'pos', ...point(x) });
const enter = (t, extra = {}) => ({ t, e: 'enter', inst: 36, kind: 'party', diff: 1, ...extra });

function session(schema, events) {
	return {
		schema, session: 'instance-travel', started: 1791000000,
		char: { name: 'Walker', realm: 'Test' }, events,
		// 1% of x is 10 yards.
		maps: { 1429: { left: 0, right: 1000, top: 1000, bottom: 0 } },
	};
}

// `enter` timestamps the instance transition, but its P is the last outdoor
// position cached by Finds.lua. A missing position at the loading screen can
// leave that cache behind later, fresh recorder samples.
const cases = [
	['stale entrance does not add a return trip', [snapshot(0, 'login', point(0)), pos(10, 2), enter(20, point(0)), pos(30, 4), snapshot(40, 'complete', point(4))], 40],
	['ending inside does not walk back to the cached entrance', [snapshot(0, 'login', point(0)), pos(10, 4), enter(20, point(0)), snapshot(30, 'complete')], 40],
	['entrance alone cannot anchor a later fresh position', [snapshot(0, 'login'), enter(10, point(0)), pos(20, 4), snapshot(30, 'complete', point(4))], 0],
	['old entrance on another map does not break a fresh trail', [snapshot(0, 'login', point(0)), pos(10, 2), enter(20, point(80, 1439)), pos(30, 4), snapshot(40, 'complete', point(4))], 40],
	['same-time entrance does not replace the fresh anchor', [snapshot(0, 'login', point(0)), pos(10, 2), enter(10, point(0)), pos(20, 4), snapshot(30, 'complete', point(4))], 40],
	['entrance without a position leaves the trail intact', [snapshot(0, 'login', point(0)), pos(10, 2), enter(20), pos(30, 4), snapshot(40, 'complete', point(4))], 40],
	['fresh portal between player samples keeps their distance', [snapshot(0, 'login', point(0)), pos(10, 2), enter(15, point(3)), pos(20, 4), snapshot(30, 'complete', point(4))], 40],
	// Fresh and stale entrance positions have no distinguishing timestamp. With
	// no later player sample, conservatively omit this otherwise valid movement.
	['sparse fresh entrance is conservatively omitted too', [snapshot(0, 'login', point(0)), enter(10, point(4)), snapshot(20, 'complete')], 0],
];

for (const schema of [1, 2]) {
	for (const [name, events, yards] of cases) {
		test(`record report schema ${schema}: ${name}`, () => {
			const input = session(schema, events);
			const before = structuredClone(input);
			const report = buildReport([input]);
			assert.equal(report.steps[0].medianYards, yards);
			// Keep the event and its time in the control, removing only its cached
			// coordinates: every report field should match that observation stream.
			const control = structuredClone(input);
			for (const e of control.events) if (e.e === 'enter') {
				delete e.map; delete e.x; delete e.y;
			}
			assert.deepEqual(report, buildReport([control]));
			assert.deepEqual(input, before, 'reporting does not change the recordings');
		});
	}
}

test('record report: an instance-entry timestamp still splits idle gaps and retains all accounting', () => {
	const input = session(2, [
		snapshot(0, 'login', point(0)),
		{ t: 10, e: 'combat', on: true },
		pos(20, 2),
		enter(200, point(0)),
		{ t: 390, e: 'combat', on: false },
		{ t: 395, e: 'turnin', q: 7, xpReward: 100 },
		{ t: 398, e: 'death' },
		pos(399, 4),
		snapshot(400, 'complete', { ...point(4), xp: 100 }),
	]);
	const report = buildReport([input]);
	const run = report.guides[0].runs[0];
	const step = report.steps[0];
	assert.equal(step.medianYards, 40);
	assert.equal(run.time, 400, 'enter keeps both idle gaps below the cap');
	assert.equal(run.combatShare, 380 / 400);
	assert.equal(run.xp, 100);
	assert.equal(step.turnins, 1);
	assert.equal(step.deaths, 1);
});
