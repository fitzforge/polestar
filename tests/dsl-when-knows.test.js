'use strict';
// `when knows <spell>` on a step (docs/GUIDE_FORMAT.md, "Conditions checked
// during play"): the step applies while the character knows the spell. The
// parser's predicate and errors (tools/lib/dsl/when.js), the emitted table
// and the pack format. 100 is Charge (Rank 1); the id is taken as written.

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

test('`when knows` parses a spell id, with or without `!`', () => {
	const text = guideText(['step One', '  when !knows 100', '  when knows 6673', '  accept 783']);
	const { ast, errors } = parse(text);
	assert.deepEqual(errors, []);
	assert.deepEqual(ast.steps[0].when, [
		{ k: 'knows', neg: true, spell: 100, line: lineOf(text, 'when !knows 100') },
		{ k: 'knows', spell: 6673, line: lineOf(text, 'when knows 6673') },
	]);
});

test('`when knows` without one spell id is an error at its line', () => {
	for (const line of ['  when knows', '  when knows 0', '  when knows Charge', '  when knows 100 2', '  when !knows spell 100']) {
		const text = guideText(['step One', line, '  accept 783']);
		const { errors } = parse(text);
		assert.deepEqual(errors, [`${lineOf(text, line)}: \`knows\` needs a spell id: knows <spell>`], line);
	}
});

test('a step that asks for a spell and its `!` warns that no character sees it', () => {
	const text = guideText(['step One', '  when knows 100', '  when !knows 100', '  accept 783']);
	const r = compile(text);
	assert.ok(r.warnings.includes(`test.guide:${lineOf(text, 'when knows 100')}: the step asks for \`knows\` and \`!knows\` of the same spell: no character sees it`), r.text);
});

test('the emitted predicate carries the spell, on a step or a `next` option, and the pack is written in format 5', () => {
	const r = compile(guideText(['step One', '  when !knows 100', '  accept 783']));
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(plain(r.guides[0].steps)[0].when, [{ k: 'knows', neg: true, spell: 100 }]);
	const lua = emitGuides([{ guide: r.guides[0], source: null }]);
	assert.match(lua, /\n\t\t\t\t\twhen = \{ \{ k = "knows", neg = true, spell = 100 \} \},\n/);
	assert.equal(formatFor(r.guides), MONEY_TASK_FORMAT);
	assert.equal(formatFor([{ steps: [], nextWhen: { 'x/y': [{ k: 'knows', spell: 100 }] } }]), MONEY_TASK_FORMAT);
});
