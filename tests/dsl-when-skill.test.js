'use strict';
// `when skill <Profession> <N>` on a step (docs/GUIDE_FORMAT.md, "Conditions
// checked during play"): the step applies while the character's rank in that
// profession is N or more. The parser's predicate and errors
// (tools/lib/dsl/when.js), the resolver's skill line from the professions
// (data.professionNamed, professions.json or the Classic built-ins) and its
// warnings, the emitted table and the pack format.
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

test('`when skill` and `when !skill` parse with the profession quoted or bare, one or more words', () => {
	const text = guideText(['step One', '  when skill Cooking 50', '  accept 783', 'step Two', '  when !skill "First Aid" 1', '  when skill First Aid 75', '  accept 7']);
	const { ast, errors } = parse(text);
	assert.deepEqual(errors, []);
	assert.deepEqual(ast.steps[0].when, [{ k: 'skill', name: 'Cooking', n: 50, line: lineOf(text, 'when skill Cooking 50') }]);
	assert.deepEqual(ast.steps[1].when, [
		{ k: 'skill', neg: true, name: 'First Aid', n: 1, line: lineOf(text, 'when !skill "First Aid" 1') },
		{ k: 'skill', name: 'First Aid', n: 75, line: lineOf(text, 'when skill First Aid 75') },
	]);
});

test('`when skill` without a profession or a rank of 1 or more is an error at its line', () => {
	for (const line of ['  when skill', '  when skill Cooking', '  when skill 50', '  when skill Cooking 0', '  when !skill "First Aid"']) {
		const text = guideText(['step One', line, '  accept 783']);
		const { errors } = parse(text);
		assert.deepEqual(errors, [`${lineOf(text, line)}: \`skill\` needs a profession and a rank of 1 or more: skill <Profession> <N>`], line);
	}
});

test('the resolver gives the profession its skill line and data name, case aside; an unknown one warns and keeps the name', () => {
	const text = guideText(['step One', '  when skill first aid 1', '  when !skill Cooking 50', '  accept 783', 'step Two', '  when skill Cookery 1', '  turnin 783']);
	const r = compile(text);
	assert.deepEqual(r.errors, [], r.text);
	const steps = plain(r.guides[0].steps);
	// First Aid from professions.json, Cooking from the Classic built-ins.
	assert.deepEqual(steps[0].when, [{ k: 'skill', name: 'First Aid', n: 1, skillLine: 129 }, { k: 'skill', neg: true, name: 'Cooking', n: 50, skillLine: 185 }]);
	assert.deepEqual(steps[1].when, [{ k: 'skill', name: 'Cookery', n: 1 }]);
	assert.deepEqual(r.warnings.filter((w) => w.includes('profession')), [
		`test.guide:${lineOf(text, 'when skill Cookery 1')}: profession "Cookery" is not in data: the predicate reads the skill by that name, in English only`,
	]);
});

test('a step that asks for a skill rank and its `!` warns that no character sees it', () => {
	const text = guideText(['step One', '  when skill Mining 50', '  when !skill Mining 50', '  accept 783']);
	const r = compile(text);
	assert.ok(r.warnings.includes(`test.guide:${lineOf(text, 'when skill Mining 50')}: the step asks for \`skill\` and \`!skill\` of the same profession and rank: no character sees it`), r.text);
});

test('the emitted predicate carries the skill line, and the pack is written in format 5, on a step or a `next` line', () => {
	const r = compile(guideText(['step One', '  when !skill Mining 1', '  accept 783']));
	assert.deepEqual(r.errors, [], r.text);
	const lua = emitGuides([{ guide: r.guides[0], source: null }]);
	assert.match(lua, /\n\t\t\t\t\twhen = \{ \{ k = "skill", neg = true, n = 1, name = "Mining", skillLine = 186 \} \},\n/);
	assert.equal(formatFor(r.guides), MONEY_TASK_FORMAT);

	const follower = ['guide t/miner', 'title Miner', 'faction Horde', 'levels 10-20', 'zone Elwynn Forest', 'pitch For miners.', '', 'step Start', '  note Go on.', ''].join('\n');
	const main = ['guide t/main', 'title Main', 'faction Horde', 'levels 1-10', 'zone Elwynn Forest', 'next t/miner when skill Mining 1', '', 'step Start', '  note Go on.', ''].join('\n');
	const n = compile({ 'main.guide': main, 'miner.guide': follower });
	assert.deepEqual(n.errors, [], n.text);
	assert.deepEqual(plain(n.guides.find((g) => g.id === 't/main').nextWhen), { 't/miner': [{ k: 'skill', name: 'Mining', n: 1, skillLine: 186 }] });
	assert.equal(formatFor(n.guides), MONEY_TASK_FORMAT);
});
