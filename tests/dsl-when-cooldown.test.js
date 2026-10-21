'use strict';
// `when cooldown item <item>` and `when cooldown spell <spell>` on a step
// (docs/GUIDE_FORMAT.md, "Conditions checked during play"): the step applies
// while the item or spell is on cooldown. The parser's predicate and errors
// (tools/lib/dsl/when.js), the resolver's item check, the emitted table and
// the pack format. Fixture data: tests/fixtures/dsl/data (6948, the
// Hearthstone, is in its items).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { emitGuides } = require('../tools/lib/dsl/emit');
const { formatFor, MONEY_TASK_FORMAT } = require('../tools/lib/pack/format');
const { compile, guideText, lineOf, plain } = require('./helpers/dsl');

function parse(text) {
	const diag = new Diagnostics();
	const ast = parseGuide(text, 'x.guide', diag);
	return { ast, errors: diag.sorted().filter((d) => d.severity === 'error').map((d) => `${d.line}: ${d.message}`) };
}

test('`when cooldown` parses an item or a spell, with or without `!`', () => {
	const text = guideText(['step One', '  when !cooldown item 6948', '  when cooldown SPELL 8690', '  accept 783']);
	const { ast, errors } = parse(text);
	assert.deepEqual(errors, []);
	assert.deepEqual(ast.steps[0].when, [
		{ k: 'cooldown', neg: true, item: 6948, line: lineOf(text, 'when !cooldown item 6948') },
		{ k: 'cooldown', spell: 8690, line: lineOf(text, 'when cooldown SPELL 8690') },
	]);
});

test('`when cooldown` without `item` or `spell` and one id is an error at its line', () => {
	for (const line of ['  when cooldown', '  when cooldown 6948', '  when cooldown item', '  when cooldown item 0', '  when cooldown item 6948 2', '  when !cooldown quest 783']) {
		const text = guideText(['step One', line, '  accept 783']);
		const { errors } = parse(text);
		assert.deepEqual(errors, [`${lineOf(text, line)}: \`cooldown\` needs an item or spell id: cooldown item <item> or cooldown spell <spell>`], line);
	}
});

test('an item not in the data warns as for `has`; a spell is taken as written', () => {
	const text = guideText(['step One', '  when cooldown item 6948', '  when !cooldown item 99999', '  when cooldown spell 8690', '  accept 783']);
	const r = compile(text);
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(plain(r.guides[0].steps)[0].when, [{ k: 'cooldown', item: 6948 }, { k: 'cooldown', neg: true, item: 99999 }, { k: 'cooldown', spell: 8690 }]);
	assert.deepEqual(r.warnings.filter((w) => w.includes('not in data')), [`test.guide:${lineOf(text, 'when !cooldown item 99999')}: item 99999 is not in data (new Forever content?)`]);
});

test('a step that asks for a cooldown and its `!` warns that no character sees it', () => {
	const text = guideText(['step One', '  when cooldown item 6948', '  when !cooldown item 6948', '  accept 783']);
	const r = compile(text);
	assert.ok(r.warnings.includes(`test.guide:${lineOf(text, 'when cooldown item 6948')}: the step asks for \`cooldown\` and \`!cooldown\` of the same item: no character sees it`), r.text);
});

test('the emitted predicate carries the item or spell, and the pack is written in format 5', () => {
	const r = compile(guideText(['step One', '  when !cooldown item 6948', '  when cooldown spell 8690', '  accept 783']));
	assert.deepEqual(r.errors, [], r.text);
	const lua = emitGuides([{ guide: r.guides[0], source: null }]);
	assert.match(lua, /\n\t\t\t\t\twhen = \{ \{ k = "cooldown", neg = true, item = 6948 \}, \{ k = "cooldown", spell = 8690 \} \},\n/);
	assert.equal(formatFor(r.guides), MONEY_TASK_FORMAT);
});
