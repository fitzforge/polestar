'use strict';
// `level N grind <npc>` (docs/GUIDE_FORMAT.md): the level goal names the mob it is reached on and takes that mob's
// spawn place and areas as a kill of it would, so the arrow leads to the nearest area, not the step's goto. The JS
// compiler side of forge-guide's dsl_resolve.rs test; tests/parity.sh keeps the two compilers' output equal.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { guideText, lineOf, compile, plain } = require('./helpers/dsl');

test('a grind level goal takes its mob\'s spawn areas as a kill would, and warns without spawns', () => {
	const r = compile(guideText(['step One', '  goto 47.6,35.1', '  level 12 grind 6 -- grind on Kobold Vermin', '  kill 6']));
	assert.deepEqual(r.errors, []);
	assert.deepEqual(r.warnings.filter((w) => w.includes('already leads')), [], "the goto is the grind's fallback, no redundant goto");
	const [, level, kill] = plain(r.guides[0].steps)[0].goals;
	assert.deepEqual([level.t, level.level, level.grind, level.npcName, level.note], ['level', 12, 6, 'Kobold Vermin', 'grind on Kobold Vermin']);
	assert.deepEqual([level.map, level.x, level.y, level.f], [1429, 49, 32.4, 'e'], "the spawn nearest the goto, as `kill 6`'s");
	// The kill's spots without its alternatives: a grind keeps the places the arrow picks.
	assert.deepEqual(level.spots, kill.spots.filter((s) => !s.alt));
	assert.ok(level.spots.length > 0);

	const text = guideText(['step One', '  goto 47.6,35.1', '  level 12 grind 99999']);
	const none = compile(text);
	assert.deepEqual(none.errors, []);
	const goal = plain(none.guides[0].steps)[0].goals[1];
	assert.deepEqual([goal.grind, goal.map, goal.spots], [99999, undefined, undefined]);
	assert.deepEqual(
		none.warnings.filter((w) => w.includes('grind 99999')),
		[`test.guide:${lineOf(text, 'level 12 grind 99999')}: \`grind 99999\` has no known spawns here: the arrow keeps the step's goto`],
	);
	assert.equal(compile(guideText(['step One', '  kill 6 grind 6'])).errors.filter((e) => e.includes('grind')).length, 1, '`grind` on a kill');
});
