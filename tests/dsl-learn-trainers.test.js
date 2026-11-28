'use strict';
// `learn <spell> npc <id>,<id>…`: the trainers who teach a recipe, when that is fewer than its rank's (the trainer
// a player started with teaches only the first recipes of a profession). They become the goal's smart-target
// `candidates`, so the arrow takes the nearest of the character's faction. The Rust twin: forge-guide's
// tests/guide/dsl_learn_trainers.rs.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { guideText, compile, plain } = require('./helpers/dsl');

const goalOf = (r) => plain(r.guides[0].steps)[0].goals[0];
const BOTH = ['guide t/both', 'title Both', 'levels 1-10', 'zone Elwynn Forest', ''];

test('a learn names several trainers: each is a candidate of its own faction, and none is pinned', () => {
	const r = compile(guideText([...BOTH, 'step Learn Heavy Linen Bandage', '  learn 3276 npc 5150,3373']));
	assert.deepEqual(r.errors, [], r.text);
	const g = goalOf(r);
	assert.equal(g.npc, undefined);
	assert.deepEqual(g.candidates.map((c) => [c.npc, c.faction]).sort(), [[3373, 'H'], [5150, 'A']]);
});

test('one npc still pins the learn to that trainer', () => {
	const r = compile(guideText([...BOTH, 'step Learn Heavy Linen Bandage', '  learn 3276 npc 5150']));
	assert.deepEqual(r.errors, [], r.text);
	assert.equal(goalOf(r).npc, 5150);
	assert.equal(goalOf(r).candidates, undefined);
});
