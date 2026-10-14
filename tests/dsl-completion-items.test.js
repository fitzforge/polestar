'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { emitGuides } = require('../tools/lib/dsl/emit');
const { compile, guideText } = require('./helpers/dsl');
const { runAddon } = require('./helpers/lua');

test('an authored completion item survives parsing, resolution and Lua emission', () => {
	const { guides, errors } = compile(guideText(['step', '  accept 7 doneitem 5175', '  turnin 7 doneitem 5175']));
	assert.deepEqual(errors, []);
	const lua = emitGuides(guides.map((guide) => ({ guide })));
	const [out] = runAddon({ script: `Polestar = { RegisterGuide = function(g) emit({ g.steps[1].goals[1].doneItem, g.steps[1].goals[2].doneItem }) end }\n${lua}` }).emitted;
	assert.deepEqual(out, [5175, 5175]);
});

test('completion item IDs must be positive integers and cannot be repeated', () => {
	for (const mod of ['doneitem 0', 'doneitem -1', 'doneitem 1.5', 'doneitem nope', 'doneitem', 'doneitem 5175 doneitem 5175']) {
		const d = new Diagnostics();
		parseGuide(guideText(['step', `  accept 7 ${mod}`]), 'bad.guide', d);
		assert.ok(d.sorted().some((x) => x.severity === 'error' && /malformed item id|duplicate `doneitem`/.test(x.message)), mod);
	}
});

test('the actual Dwarf guide covers every Earth Totem acquisition goal, including Sapta, without covering other quests', () => {
	const file = path.join(__dirname, '../guides/forever/alliance/dwarf-gnome/01-dun-morogh.guide');
	const d = new Diagnostics();
	const ast = parseGuide(fs.readFileSync(file, 'utf8'), file, d);
	assert.deepEqual(d.sorted().filter((x) => x.severity === 'error'), []);
	const goals = ast.steps.flatMap((s) => s.goals);
	const chain = goals.filter((g) => [94373, 94374, 94375].includes(g.quest) || (g.verb === 'use' && g.item === 6635));
	assert.equal(chain.length, 8);
	assert.ok(chain.every((g) => g.doneItem === 5175));
	assert.ok(goals.filter((g) => !chain.includes(g)).every((g) => g.doneItem === undefined));
});
