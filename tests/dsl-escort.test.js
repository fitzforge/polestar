'use strict';
// Escort quests (docs/GUIDE_FORMAT.md, "Escort quests"): the compiled
// `escort` of a goal (tools/lib/dsl/escort.js), from the quest's own words or
// a quests.json `escort` that corrections.json sets.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, escortData } = require('./helpers/dsl');
const { DATA, needs } = require('./helpers/data');
const { isEscort } = require('../tools/lib/dsl/escort');

function guide(body) {
	return `${['guide t/escort', 'title Escort', 'faction Alliance', 'category Class', 'levels 1-60', 'zone Elwynn Forest', '', ...body].join('\n')}\n`;
}

// The compiled `escort` of the first step's goals (null: none).
function escorts(body) {
	const r = compile(guide(body), escortData());
	assert.deepEqual(r.errors, []);
	return r.guides[0].steps[0].goals.map((g) => g.escort || null);
}

test('an escort quest\'s accept, objective and complete goals are escort; its turn-in is not', () => {
	assert.deepEqual(escorts(['step S', '  accept 9700', '  kill 6 quest 9700.2', '  complete 9700', '  turnin 9700']), [true, true, true, null]);
});

test('a quest with no objectives whose objective text says escort is one (Forever\'s own escorts)', () => {
	assert.deepEqual(escorts(['step S', '  accept 9701', '  complete 9701', '  turnin 9701']), [true, true, null]);
});

test('an event objective that says nothing of an escort, a kill quest and a goal with no quest are not escort', () => {
	assert.deepEqual(escorts(['step S', '  accept 9704', '  complete 9704', '  accept 7', '  kill 6 quest 7', '  kill 6']), [null, null, null, null, null]);
});

test('a quests.json `escort` (corrections.json) wins over the quest\'s words, both ways', () => {
	assert.deepEqual(escorts(['step S', '  accept 9702', '  complete 9702', '  accept 9703', '  turnin 9703']), [true, true, null, null]);
});

test('the compiled escort reaches the pack: escort = true on the goal in Guides.lua', () => {
	const { emitGuides } = require('../tools/lib/dsl/emit');
	const r = compile(guide(['step S', '  accept 9700', '  turnin 9700']), escortData());
	const lua = emitGuides(r.guides.map((g) => ({ guide: g, source: 'test.guide' })));
	assert.match(lua, /t = "accept", quest = 9700, [^\n]*escort = true \},/);
	assert.doesNotMatch(lua, /t = "turnin", [^\n]*escort/);
});

// The reference data (data/forever, built on the contributor's machine) with
// corrections.json applied as `data build` applies them: the escorts the
// guides route by text, the ones worded otherwise, and Lost! (4492), whose
// copied objective says escort.
test('the reference data: escorts by their words and by corrections.json; Lost! is not one', { skip: needs('quests.json') }, () => {
	const quests = require(`${DATA}/quests.json`);
	const corrections = require('../tools/lib/data/corrections.json').quests;
	const corrected = (id) => ({ ...quests[id], ...((corrections[id] || {}).set || {}) });
	// Westfall's Defias Traitor, Miran in Loch Modan, Shay ($B before Escort),
	// and three of Forever's own escorts.
	for (const id of [155, 309, 2845, 87491, 99053, 99144]) assert.equal(isEscort(corrected(id)), true, `${id} ${quests[id].title}`);
	// A kill quest, a defence where the NPC stands (The Tome of Valor) and Lost!.
	for (const id of [7, 1651, 4492]) assert.equal(isEscort(corrected(id)), false, `${id} ${quests[id].title}`);
	// Every escort correction says what the quest's words do not.
	for (const [id, c] of Object.entries(corrections)) {
		if (!c.set || typeof c.set.escort !== 'boolean' || !quests[id]) continue;
		const { escort: _, ...uncorrected } = corrected(id);
		assert.notEqual(isEscort(uncorrected), c.set.escort, `${id}: the correction repeats what the text says`);
	}
});
