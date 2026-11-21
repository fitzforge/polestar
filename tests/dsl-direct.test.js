'use strict';
// #2318: a direct hand-in has no accept goal to carry its minimum quest level.
// Keep this contract in step with forge-guide's dsl_resolve.rs.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { loadData } = require('../tools/lib/dsl/data');
const { emitGuides } = require('../tools/lib/dsl/emit');
const { compile, guideText, DATA_DIR } = require('./helpers/dsl');

function questData(minLevel) {
	const data = loadData(DATA_DIR);
	data.quests[783].level = 10;
	if (minLevel === undefined) delete data.quests[783].minLevel;
	else data.quests[783].minLevel = minLevel;
	return data;
}

function resolved(lines, minLevel) {
	const r = compile(guideText(['step S', ...lines]), questData(minLevel));
	assert.deepEqual(r.errors, [], r.text);
	return r;
}

test('direct hand-ins carry the minimum quest level into compiled Lua', () => {
	const r = resolved(['  turnin 783 direct'], 7);
	const g = r.guides[0].steps[0].goals[0];
	assert.equal(g.direct, true);
	assert.equal(g.minLevel, 7);
	assert.equal(g.qlvl, 10, 'quest difficulty still controls grey-quest skipping');
	const lua = emitGuides(r.guides.map((guide) => ({ guide, source: null })));
	assert.match(lua, /\{ t = "turnin", [^\n]+minLevel = 7, qlvl = 10, [^\n]*direct = true/);
});

test('ordinary hand-ins leave the minimum level on their accept goal', () => {
	const r = resolved(['  accept 783', '  turnin 783'], 7);
	const [accept, turnin] = r.guides[0].steps[0].goals;
	assert.equal(accept.minLevel, 7);
	assert.equal(turnin.minLevel, undefined);
	assert.equal(turnin.qlvl, undefined);
	assert.equal(turnin.direct, undefined);
});

test('direct hand-ins omit absent and zero minimum levels', () => {
	for (const minLevel of [undefined, 0]) {
		const r = resolved(['  turnin 783 direct'], minLevel);
		const g = r.guides[0].steps[0].goals[0];
		assert.equal(g.minLevel, undefined);
		assert.equal(g.qlvl, 10);
		assert.equal(g.direct, true);
	}
});
