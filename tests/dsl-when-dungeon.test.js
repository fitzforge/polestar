'use strict';
// `when dungeon "<Name>"` steps and the solo route (docs/GUIDE_FORMAT.md, "Conditions checked during play"): a
// character who skips the dungeon never walks its steps, so the solo route's steps are placed as they are without
// them. The JS compiler side of forge-guide's dsl_when_dungeon.rs test; its tests/parity.sh keeps the two
// compilers' output equal.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { guideText, compile, plain } = require('./helpers/dsl');

// Where the guide's kill of Kobold Vermin (6) is placed: its spawn nearest the goal before it.
function killAt(lines) {
	const r = compile(guideText(lines));
	assert.deepEqual(r.errors, []);
	const kill = plain(r.guides[0].steps).flatMap((s) => s.goals).find((g) => g.t === 'kill');
	return [kill.x, kill.y];
}

test("a dungeon's steps leave the solo route's placing alone, and the runners' steps follow each other", () => {
	const solo = killAt(['step One', '  goto 45,34', 'step Two', '  kill 6']);
	assert.deepEqual(solo, [45.1, 33.9]);
	assert.deepEqual(
		killAt(['step One', '  goto 45,34', 'step Run', '  when dungeon "Ragefire Chasm"', '  goto 52,27', 'step Two', '  kill 6']),
		solo,
		"the solo route's kill is placed from its own last goal, as without the dungeon's step",
	);
	assert.deepEqual(
		killAt(['step One', '  goto 45,34', 'step Run', '  when dungeon "Ragefire Chasm"', '  goto 52,27', 'step Back', '  when dungeon "Ragefire Chasm"', '  kill 6']),
		[52.3, 26.8],
		"a dungeon's step after another is placed from the runner's last goal",
	);
	assert.deepEqual(
		killAt(['step One', '  goto 45,34', 'step Alone', '  when !dungeon "Ragefire Chasm"', '  goto 52,27', 'step Two', '  kill 6']),
		[52.3, 26.8],
		'a `when !dungeon` step is the solo route\'s own: the steps after it are placed from it',
	);
});
