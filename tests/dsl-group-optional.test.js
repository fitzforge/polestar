'use strict';
// A step only players who chose the group way follow (`when group <quest>`,
// `when dungeon "<Name>"`) whose every goal is `optional` (the Monogrammed
// Sash, Margol's Horn): done at once, so that player got no arrow. The JS
// compiler side of forge-guide's dsl_validate.rs test; an error in our pack,
// a warning in others.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { guideText, lineOf, compile } = require('./helpers/dsl');

const SRC = guideText([
	'step Asked',
	'  when group 7',
	'  accept 7 optional',
	'  turnin 7 optional',
	'',
	'step Held',
	'  when group 7',
	'  accept 7',
	'  accept 783 optional',
	'',
	'step Solo',
	'  when !group 7',
	'  accept 7 optional',
	'',
	'step Talk',
	'  when group 7',
	'  note Ask around for a group.',
	'',
	'step Run',
	'  when dungeon "Ragefire Chasm"',
	'  turnin 783 optional',
]);

const msg = (what, at) =>
	`test.guide:${lineOf(SRC, at)}: every goal of this \`${what}\` step is \`optional\`: a step of optional goals only is done at once, so the player who chose it gets no arrow; drop \`optional\` (only that player sees the step)`;
const mine = (list) => list.filter((m) => m.includes('every goal of this'));

test('a group or dungeon step of optional goals only is an error in our pack and a warning in others', () => {
	const want = [msg('when group 7', '  accept 7 optional'), msg('when dungeon', '  turnin 783 optional')];
	const ours = compile(SRC);
	assert.deepEqual(mine(ours.errors), want, ours.text);
	const theirs = compile(SRC, undefined, { pack: 'someone' });
	assert.deepEqual(mine(theirs.errors), [], theirs.text);
	assert.deepEqual(mine(theirs.warnings), want, theirs.text);
});
