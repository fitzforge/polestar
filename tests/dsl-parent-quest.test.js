'use strict';
// The Valik rule (0.3.7): a child quest (`parent` in the data: Valik 535 under Infiltration 533) is offered only
// while its parent is in the log. The JS compiler side of dsl_validate.rs's parent test (tests/parity.sh keeps the
// two compilers' output equal): the accept carries `inLog` with the parent's title, and lint warns when the chain
// does not hold the parent there.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { fixtureData, guideText, lineOf, compile, plain } = require('./helpers/dsl');
const { Data } = require('../tools/lib/dsl/data');

function parentData() {
	const base = fixtureData();
	const quest = (id, title, extra) => ({ ...base.quests[7], id, title, pre: [], objectives: [], ...extra });
	const quests = { ...base.quests, 9341: quest(9341, 'The Parent'), 9340: quest(9340, 'The Child', { pre: [9341], parent: 9341 }) };
	return new Data({ quests, npcs: base.npcs, objects: base.objects, items: base.items, zones: base.zones, 'map-frames': base.mapFrames, meta: base.meta }, { dir: base.dir });
}

const parentWarnings = (r) => r.warnings.filter((w) => w.includes('is offered only while'));

test("a child quest's accept carries its parent as inLog, and lint says when the chain does not hold it", () => {
	const data = parentData();
	const held = compile(guideText(['step A', '  accept 9341', 'step B', '  accept 9340']), data);
	const g = plain(held.guides[0].steps)[1].goals[0];
	assert.deepEqual([g.inLog, g.preTitles, g.pre], [9341, { 9341: 'The Parent' }, undefined]);
	assert.deepEqual(parentWarnings(held), []);
	assert.deepEqual(parentWarnings(compile(guideText(['step B', '  when onquest 9341', '  accept 9340']), data)), []);
	const never = guideText(['step B', '  accept 9340']);
	assert.deepEqual(parentWarnings(compile(never, data)), [`test.guide:${lineOf(never, '  accept 9340')}: quest 9340 is offered only while 9341 (The Parent) is in the log, but the chain never takes that quest before it`]);
	const handed = guideText(['step A', '  accept 9341', '  turnin 9341', 'step B', '  accept 9340']);
	assert.deepEqual(parentWarnings(compile(handed, data)), [`test.guide:${lineOf(handed, '  accept 9340')}: quest 9340 is offered only while 9341 (The Parent) is in the log, but the chain hands that quest in earlier`]);
});
