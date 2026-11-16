'use strict';
// polestar playtest --persona (tools/lib/playtest-personas.js): the imperfect
// players. Their tables and variants from a guide and the data; a play that
// loses the item a direct hand-in takes is stuck unless the hand-in's step
// waits for the item (An Apple Treat); the command's options.
//
// The plays need data/forever and Lua 5.1; they skip without them.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { quiet } = require('./helpers/cli');
const { needs, DATA } = require('./helpers/data');
const { findLua } = require('../tools/lib/lua');
const cmd = require('../tools/commands/playtest');
const { Data, loadData } = require('../tools/lib/dsl/data');
const { buildSimPack, playGuide, SIMULATE, luaValue } = require('../tools/lib/playtest');
const { personaTables, personaVariants, updatePoints } = require('../tools/lib/playtest-personas');

const hasLua = (() => {
	try {
		return !!findLua();
	} catch {
		return false;
	}
})();
const skip = needs('quests.json', 'items.json') || (!hasLua && 'no Lua 5.1');

// 100: handed in on the spot for a Thunder Applejack (900), which only 101 (the still, a direct hand-in for
// apples, 901) hands over. 102: started by a letter (902). 103: an ordinary quest; 104 repeatable.
const quest = (id, extra) => ({ id, title: `Quest ${id}`, start: { npc: [1], object: [], item: [] }, objectives: [], ...extra });
const data = new Data({
	quests: {
		100: quest(100, { direct: true, objectives: [{ type: 'item', id: 900, count: 1 }] }),
		101: quest(101, { direct: true, repeatable: true, objectives: [{ type: 'item', id: 901, count: 4 }], web: { items: [[900, 1]] } }),
		102: quest(102, { start: { npc: [], object: [], item: [902] } }),
		103: quest(103, { pre: [99] }),
		104: quest(104, { repeatable: true }),
		99: quest(99),
	},
	items: { 900: { id: 900, name: 'Thunder Applejack', drops: { npc: {}, object: {} }, vendors: [] }, 901: { id: 901, name: 'Apple', drops: { npc: {}, object: {} }, vendors: [5] }, 902: { id: 902, name: 'Letter', drops: { npc: { 7: 1 }, object: {} }, vendors: [] } },
});
const step = (title, goals) => ({ title, goals });
const guide = {
	id: 't/g',
	steps: [
		step('Farm', [{ t: 'buy', item: 901 }]),
		step('Still', [{ t: 'turnin', quest: 101, direct: true, optional: true }, { t: 'collect', item: 900 }]),
		step('Garrison', [{ t: 'turnin', quest: 100, direct: true }, { t: 'accept', quest: 103 }, { t: 'accept', quest: 104 }]),
		step('Loot', [{ t: 'collect', item: 902, optional: true }]),
		step('Read', [{ t: 'accept', quest: 102 }]),
	],
};

test('the tables: what direct hand-ins and item-started accepts take, and the items only quests hand over', () => {
	assert.deepEqual(personaTables(guide, data), { needs: { 100: { 900: 1 }, 101: { 901: 4 }, 102: { 902: 1 } }, gives: { 900: [101] }, rewards: { 101: [900] }, restock: {}, carried: [900, 902] });
	// A step that leads to the item's source (the letter's dropper, npc 7) gives it back there.
	const looted = { id: 't/l', steps: [step('Loot', [{ t: 'kill', npc: 7 }, { t: 'accept', quest: 102 }])] };
	assert.deepEqual(personaTables(looted, data).restock, { 1: [902] });
});

test('skip plays every step that gets an item a later goal hands over, then an even sample of the rest', () => {
	assert.deepEqual(
		personaVariants('skip', guide, data, 3).map((v) => v.persona.skip),
		[1, 2, 4],
	);
	assert.match(personaVariants('skip', guide, data, 3)[0].variant, /^skips step 1 "Farm"$/);
});

test('lost loses each carried item after the step that gets it, or carries none into the guide', () => {
	const v = personaVariants('lost', guide, data);
	assert.deepEqual(
		v.map((x) => [x.variant, x.persona.lose ?? null, x.persona.lack ?? null]),
		[
			['loses Thunder Applejack (900) after getting it', 900, null],
			['loses Letter (902) after getting it', 902, null],
		],
	);
});

test('elsewhere did each quest the guide offers, with the chain before it, never a repeatable one', () => {
	const v = personaVariants('elsewhere', guide, data, 8);
	assert.deepEqual(
		v.map((x) => [x.variant, x.before]),
		[
			['did 100 (Quest 100) before the guide', 'w.complete({100})'],
			['did 102 (Quest 102) before the guide', 'w.complete({102})'],
			['did 103 (Quest 103) before the guide', 'w.complete({103,99})'],
		],
	);
});

test('update leaves the old guide at points spread over its steps, never its first', () => {
	assert.deepEqual(updatePoints({ steps: new Array(100) }, 3), [25, 50, 75]);
	assert.deepEqual(updatePoints({ steps: new Array(2) }, 3), [2]);
	assert.deepEqual(updatePoints({ steps: [1] }, 3), []);
});

test('--persona names known personas; update needs --from; not with --honest', async () => {
	for (const [args, re] of [
		[['--persona', 'nope'], /--persona must be skip, lost, elsewhere, update or all \(got "nope"\)/],
		[['--persona', 'update'], /the update persona needs --from/],
		[['--persona', 'skip', '--honest'], /does not go with --honest/],
		[['--persona', 'skip', '--sample', '0'], /--sample must be a whole number/],
	]) {
		const { result, out } = await quiet(() => cmd.run(args));
		assert.equal(result, 2, args.join(' '));
		assert.match(out, re);
	}
});

// An Apple Treat (91738), handed in on the spot for the Thunder Applejack (247824).
const appleGuide = (gate) => `guide forever/alliance/apple-test
title Apple
faction Alliance
levels 7-10
zone Elwynn Forest

step Westbrook
  collect 247824 x1 @24.6,58.0

step Road
  goto 30.0,60.0

step Garrison
${gate ? '  when has 247824\n' : ''}  turnin 91738 direct

step After
  goto 40.0,60.0
`;

let realData = null;
const playApple = (gate, persona) => {
	realData = realData || loadData(DATA);
	const pack = buildSimPack([{ file: 'apple.guide', text: appleGuide(gate) }], realData);
	try {
		assert.ok(!pack.diag.hasErrors(), JSON.stringify(pack.diag.errors));
		const g = pack.guides[0];
		const t = personaTables(g, realData);
		const [out] = playGuide(pack, g, { race: 'Human', faction: 'Alliance', cls: 'WARRIOR', script: `PERSONA = ${luaValue({ needs: t.needs, gives: t.gives, ...persona })}\n${SIMULATE}` });
		return out;
	} finally {
		pack.dispose();
	}
};

test('a play that loses the Applejack is held at An Apple Treat; the gated step passes; nothing lost plays through', { skip }, () => {
	const lost = playApple(false, { lose: 247824 });
	assert.equal(lost.done, false);
	assert.equal(lost.stuck.title, 'Garrison');
	assert.equal(lost.stuck.t, 'turnin');
	assert.equal(playApple(true, { lose: 247824 }).done, true);
	assert.equal(playApple(false, {}).done, true);
	// Skipping the step that gets it is the same.
	assert.equal(playApple(false, { skip: 1 }).stuck.title, 'Garrison');
	assert.equal(playApple(true, { skip: 1 }).done, true);
});
