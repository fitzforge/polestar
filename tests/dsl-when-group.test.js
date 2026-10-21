'use strict';
// `when group <quest>` on a step (docs/GUIDE_FORMAT.md, "Group quests"): the
// player is asked at the step whether to do that group quest; `when !group`
// is the solo alternative. The parser's predicate and errors
// (tools/lib/dsl/when.js), the quest check, the refusal on `next` and
// `skipto` lines (no step to ask at), the emitted table and the pack format.
// Fixture data: tests/fixtures/dsl/data.

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

test('`when group` and `when !group` parse one quest id', () => {
	const text = guideText(['step With a group', '  when group 783', '  accept 783', 'step The solo way', '  when !group 783', '  turnin 783']);
	const { ast, errors } = parse(text);
	assert.deepEqual(errors, []);
	assert.deepEqual(ast.steps[0].when, [{ k: 'group', q: 783, line: lineOf(text, 'when group 783') }]);
	assert.deepEqual(ast.steps[1].when, [{ k: 'group', neg: true, q: 783, line: lineOf(text, 'when !group 783') }]);
});

test('`when group` without one quest id is an error at its line', () => {
	for (const line of ['  when group', '  when group 0', '  when group 783,7', '  when !group Kobolds']) {
		const text = guideText(['step One', line, '  accept 783']);
		const { errors } = parse(text);
		assert.deepEqual(errors, [`${lineOf(text, line)}: \`group\` needs one quest id: group <quest>`], line);
	}
});

test('a quest not in the data warns; a step asking both ways warns that no character sees it', () => {
	const text = guideText(['step One', '  when group 99999', '  accept 783', 'step Two', '  when group 783', '  when !group 783', '  turnin 783']);
	const r = compile(text);
	assert.deepEqual(r.errors, [], r.text);
	assert.ok(r.warnings.includes(`test.guide:${lineOf(text, 'when group 99999')}: quest 99999 is not in data (new Forever content?)`), r.text);
	assert.ok(r.warnings.includes(`test.guide:${lineOf(text, 'when group 783')}: the step asks for \`group\` and \`!group\` of the same quest: no character sees it`), r.text);
});

test('`group` is refused on a `skipto` and on a `next` line: nobody is asked there', () => {
	const text = guideText(['step One', '  skipto end when group 783', '  note Go on.', 'step End', '  label end', '  note Done.']);
	const r = compile(text);
	assert.deepEqual(r.errors, [`test.guide:${lineOf(text, 'skipto end when group 783')}: \`skipto\` cannot wait for an answer: \`group\` asks the player at a step`]);

	const follower = ['guide t/b', 'title B', 'faction Horde', 'levels 10-20', 'zone Elwynn Forest', 'pitch B.', '', 'step Start', '  note Go on.', ''].join('\n');
	const main = ['guide t/main', 'title Main', 'faction Horde', 'levels 1-10', 'zone Elwynn Forest', 'next t/b when group 783', '', 'step Start', '  note Go on.', ''].join('\n');
	const n = compile({ 'main.guide': main, 'b.guide': follower });
	assert.ok(n.errors.some((e) => e.endsWith('`group` asks the player at a step of the guide: it cannot decide a `next` option')), n.text);
});

test('the emitted predicate carries the quest, and the pack is written in format 5', () => {
	const r = compile(guideText(['step One', '  when !group 783', '  accept 783']));
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(plain(r.guides[0].steps)[0].when, [{ k: 'group', neg: true, q: 783 }]);
	const lua = emitGuides([{ guide: r.guides[0], source: null }]);
	assert.match(lua, /\n\t\t\t\t\twhen = \{ \{ k = "group", neg = true, q = 783 \} \},\n/);
	assert.equal(formatFor(r.guides), MONEY_TASK_FORMAT);
});
