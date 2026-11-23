'use strict';
// Quest work handed in only by a later guide of the chain carries that
// guide's id (`carriedTo`), when every route of every character the goal
// applies to hands it in there: the Engine says to keep it and lists it at
// the guide's end. The JS compiler side of forge-guide's dsl_validate.rs
// (quest_work_handed_in_only_by_a_later_guide_carries_that_guides_id);
// tests/parity.sh keeps the two compilers' output equal.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, plain } = require('./helpers/dsl');
const { emitGuides } = require('../tools/lib/dsl/emit');

function text(id, body, extra = []) {
	return `${[`guide ${id}`, `title ${id}`, 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', ...extra, '', ...body].join('\n')}\n`;
}

const carried = (r, id) =>
	plain(r.guides.find((g) => g.id === id).steps)
		.flatMap((s) => s.goals)
		.map((g) => g.carriedTo || null);

test('quest work handed in only by a later guide carries that guide id', () => {
	const one = text('t/one', ['step S', '  accept 7', '  accept 33', '  kill 6 quest 7.1', '  collect 750 x8 quest 33.1', '  turnin 33'], ['next t/two']);
	const deep = compile({ '1.guide': one, '2.guide': text('t/two', ['step S', '  level 2'], ['next t/three']), '3.guide': text('t/three', ['step S', '  turnin 7']) });
	assert.deepEqual(carried(deep, 't/one'), [null, null, 't/three', null, null]);
	assert.match(emitGuides(deep.guides.map((guide) => ({ guide, source: null }))), /carriedTo = "t\/three"/);
});

test('route choices: only one guide that every route hands it in at', () => {
	const choice = (two, three, extra = {}) => {
		const start = text('t/one', ['step S', '  accept 7', '  kill 6 quest 7.1'], ['next t/two, t/three']);
		const r = compile({ '1.guide': start, '2.guide': text('t/two', two, ['pitch Two', ...(extra.two || [])]), '3.guide': text('t/three', three, ['pitch Three', ...(extra.three || [])]), ...extra.files });
		return carried(r, 't/one')[1];
	};
	assert.equal(choice(['step S', '  level 2'], ['step S', '  turnin 7']), null, 'the route through t/two never hands it in');
	assert.equal(choice(['step S', '  turnin 7'], ['step S', '  turnin 7']), null, 'two guides hand it in');
	const four = { two: ['next t/four'], three: ['next t/four'], files: { '4.guide': text('t/four', ['step S', '  turnin 7']) } };
	assert.equal(choice(['step S', '  level 2'], ['step S', '  level 3'], four), 't/four', 'both routes meet where it is handed in');
});

test('a race branch counts for its own characters; an abandon or a hand-in later in the guide carries nothing', () => {
	const raced = compile({
		'1.guide': text('t/one', ['step S', '  accept 7', '  kill 6 quest 7.1', '  kill 6 quest 7.1 only Dwarf'], ['race Human, Dwarf', 'next t/two']),
		'2.guide': text('t/two', ['step S', '  turnin 7'], ['race Dwarf']),
	});
	assert.deepEqual(carried(raced, 't/one').slice(1), [null, 't/two'], 'a Human cannot follow t/two');
	const dropped = compile({
		'1.guide': text('t/one', ['step S', '  accept 7', '  kill 6 quest 7.1'], ['next t/two']),
		'2.guide': text('t/two', ['step S', '  abandon 7'], ['next t/three']),
		'3.guide': text('t/three', ['step S', '  accept 7', '  turnin 7']),
	});
	assert.equal(carried(dropped, 't/one')[1], null);
	const here = compile({
		'1.guide': text('t/one', ['step S', '  accept 7', '  kill 6 quest 7.1', 'step T', '  turnin 7'], ['next t/two']),
		'2.guide': text('t/two', ['step S', '  turnin 7']),
	});
	assert.equal(carried(here, 't/one')[1], null);
});
