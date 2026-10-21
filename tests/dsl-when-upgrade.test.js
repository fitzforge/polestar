'use strict';
// `when upgrade <item>` on a step (docs/GUIDE_FORMAT.md, "Gear upgrades"):
// the step is for characters Polestar's gear advice says the item would
// help. The parser's predicate and errors (tools/lib/dsl/when.js), the
// resolver's item check and contradiction warning, the emitted table and the
// pack format. Fixture data: tests/fixtures/dsl/data.

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

test('`when upgrade` and `when !upgrade` parse with one item id', () => {
	const text = guideText(['step With', '  when upgrade 750', '  accept 783', 'step Without', '  when !upgrade 750', '  accept 7']);
	const { ast, errors } = parse(text);
	assert.deepEqual(errors, []);
	assert.deepEqual(ast.steps[0].when, [{ k: 'upgrade', item: 750, line: lineOf(text, 'when upgrade 750') }]);
	assert.deepEqual(ast.steps[1].when, [{ k: 'upgrade', neg: true, item: 750, line: lineOf(text, 'when !upgrade 750') }]);
});

test('`when upgrade` without one item id is an error at its line', () => {
	for (const line of ['  when upgrade', '  when !upgrade', '  when upgrade 0', '  when upgrade 750 x2', '  when upgrade 750,159', '  when upgrade sword']) {
		const text = guideText(['step One', line, '  accept 783']);
		const { ast, errors } = parse(text);
		assert.deepEqual(errors, [`${lineOf(text, line)}: \`upgrade\` needs one item id: upgrade <item>`], line);
		assert.equal(ast.steps[0].goals.length, 1);
	}
});

test('the resolver keeps the item and warns about one the data does not know', () => {
	const text = guideText(['step One', '  when upgrade 750', '  accept 783', 'step Two', '  when !upgrade 777777', '  turnin 783']);
	const r = compile(text);
	assert.deepEqual(r.errors, [], r.text);
	const steps = plain(r.guides[0].steps);
	assert.deepEqual(steps[0].when, [{ k: 'upgrade', item: 750 }]);
	assert.deepEqual(steps[1].when, [{ k: 'upgrade', neg: true, item: 777777 }]);
	const at = (s) => `test.guide:${lineOf(text, s)}: `;
	assert.deepEqual(r.warnings.filter((w) => w.includes('not in data')), [`${at('when !upgrade 777777')}item 777777 is not in data (new Forever content?)`]);
});

test('a step that asks for `upgrade` and `!upgrade` of the same item warns that no character sees it', () => {
	const text = guideText(['step One', '  when upgrade 750', '  when !upgrade 750', '  accept 783']);
	const r = compile(text);
	assert.ok(r.warnings.includes(`test.guide:${lineOf(text, 'when upgrade 750')}: the step asks for \`upgrade\` and \`!upgrade\` of the same item: no character sees it`), r.text);
});

test('the emitted predicate carries the item, and the pack is written in format 5', () => {
	const r = compile(guideText(['step One', '  when !upgrade 750', '  accept 783']));
	assert.deepEqual(r.errors, [], r.text);
	const lua = emitGuides([{ guide: r.guides[0], source: null }]);
	assert.match(lua, /\n\t\t\t\t\twhen = \{ \{ k = "upgrade", neg = true, item = 750 \} \},\n/);
	assert.equal(formatFor(r.guides), MONEY_TASK_FORMAT);
});

test('`next <id> when upgrade` resolves the same way and needs format 5', () => {
	const follower = ['guide t/geared', 'title Geared', 'faction Alliance', 'levels 10-20', 'zone Elwynn Forest', 'pitch With the item.', '', 'step Start', '  note Go on.', ''].join('\n');
	const main = ['guide t/main', 'title Main', 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', 'next t/geared when !upgrade 750', '', 'step Start', '  note Go on.', ''].join('\n');
	const r = compile({ 'main.guide': main, 'geared.guide': follower });
	assert.deepEqual(r.errors, [], r.text);
	const g = r.guides.find((x) => x.id === 't/main');
	assert.deepEqual(plain(g.nextWhen), { 't/geared': [{ k: 'upgrade', neg: true, item: 750 }] });
	assert.equal(formatFor(r.guides), MONEY_TASK_FORMAT);
});
