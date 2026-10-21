'use strict';
// sim calibrate, dungeon runs (tools/lib/sim/calibrate.js): the Recorder's
// `enter` and `leave` events timed into runs, and the clear-time and
// form-up parameters fitted from them.

const test = require('node:test');
const assert = require('node:assert/strict');
const { dungeonRuns, dungeonRunFits } = require('../tools/lib/sim/calibrate');
const { PRIORS } = require('../tools/lib/sim/params');

const enter = (t, inst, party = 3, lvl = 20) => ({ e: 'enter', t, inst, instType: 'party', party, lvl });
const leave = (t, inst) => ({ e: 'leave', t, inst });

test('dungeonRuns: a corpse run is one run; a logout inside, a raid and a long gap are not', () => {
	const runs = dungeonRuns([
		{ e: 'turnin', t: 0 },
		enter(600, 36),
		leave(1800, 36),
		enter(2100, 36), // back in within 15 min: the same run
		leave(4200, 36),
		{ e: 'turnin', t: 9000 },
		{ e: 'enter', t: 9600, inst: 409, instType: 'raid', party: 3 },
		leave(12000, 409),
		enter(20000, 33, 1, 25), // solo, no leave: a logout inside
	]);
	assert.deepEqual(runs, [{ inst: 36, minutes: 60, lvl: 20, party: 3, formUp: 10 }]);
});

test('dungeonRunFits: least squares over a spread of levels, a ratio to the priors without one, form-up from three runs', () => {
	const spread = dungeonRunFits([
		{ minutes: 40, lvl: 15, formUp: 6 },
		{ minutes: 50, lvl: 35, formUp: 8 },
		{ minutes: 60, lvl: 55, formUp: 10 },
	]);
	assert.equal(spread.runs, 3);
	assert.ok(Math.abs(spread.low - 40) < 1e-9 && Math.abs(spread.high - 60) < 1e-9, JSON.stringify(spread));
	assert.equal(spread.formUp, 8);
	const one = dungeonRunFits([{ minutes: 70, lvl: 15, formUp: null }]);
	assert.equal(one.low, PRIORS.dungeonRunLow[0] * 2);
	assert.equal(one.high, PRIORS.dungeonRunHigh[0] * 2);
	assert.equal(one.formUp, undefined, 'one run says nothing about form-up');
	assert.deepEqual(dungeonRunFits([]), { runs: 0 });
});
