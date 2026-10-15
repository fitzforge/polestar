'use strict';
// compiler support for the `done <label>` atom in
// expressions and the `skipto <label> when <expr>` step line.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { compile, guideText, plain, fixtureData } = require('./helpers/dsl');
const { lexLine } = require('../tools/lib/dsl/lexer');
const { parsePredicate } = require('../tools/lib/dsl/predicate');
const { readManifest } = require('../tools/lib/pack/manifest');
const { buildPackFiles, packFormat } = require('../tools/lib/dsl/project');

const MINI = path.join(__dirname, 'fixtures', 'packs', 'mini');

const parse = (s) => parsePredicate(lexLine(s).tokens);

function stepsOf(lines) {
	const r = compile(guideText(lines));
	assert.deepEqual(r.errors, [], r.text);
	return plain(r.guides[0].steps);
}
const errorsOf = (lines) => compile(guideText(lines)).errors.join('\n');

test('`done <label>` parses to { done, label }', () => {
	assert.deepEqual(parse('done camp').value, ['done', 'camp']);
	assert.deepEqual(parse('not done Camp_2 and onquest 7').value, ['all', ['not', ['done', 'Camp_2']], ['onquest', 7]]);
	assert.match(parse('done').errors[0], /label/);
	assert.match(parse('done a.b').errors[0], /label/);
	assert.match(parse('done "camp"').errors[0], /label/);
});

test('a `done` label must exist in the guide (it may be earlier or later)', () => {
	const steps = stepsOf(['step A', '  label camp', '  accept 783', 'step B', '  when done camp', '  turnin 783', 'step C', '  when not done later', '  kill 6', 'step D', '  label later', '  accept 7']);
	assert.deepEqual(steps[1].when, ['done', 'camp']);
	assert.deepEqual(steps[2].when, ['not', ['done', 'later']]);
	assert.match(errorsOf(['step A', '  when done nowhere', '  accept 783']), /`when`: unknown label "nowhere"/);
});

test('`skipto <label> when <expr>` collects jumps in order on the step', () => {
	const steps = stepsOf([
		'step A', '  accept 783', '  skipto end when turnedin 783', '  skipto mid when level >= 5 and has 750',
		'step B', '  label mid', '  kill 6',
		'step C', '  label end', '  accept 7',
	]);
	assert.deepEqual(steps[0].skips, [
		{ to: 'end', when: ['turnedin', 783] },
		{ to: 'mid', when: ['all', ['level', '>=', 5], ['item', 750, '>=', 1]] },
	]);
	assert.equal(steps[1].skips, undefined);
});

test('skipto errors', () => {
	assert.match(errorsOf(['step A', '  skipto', '  accept 783']), /`skipto` needs a label and a condition: skipto <label> when <condition>/);
	assert.match(errorsOf(['step A', '  skipto end', '  accept 783', 'step B', '  label end', '  kill 6']), /`skipto` needs a label and a condition/);
	assert.match(errorsOf(['step A', '  skipto end if level > 2', '  accept 783', 'step B', '  label end', '  kill 6']), /`skipto` needs a label and a condition/);
	assert.match(errorsOf(['step A', '  skipto end when', '  accept 783', 'step B', '  label end', '  kill 6']), /`skipto`: empty when expression/);
	assert.match(errorsOf(['step A', '  skipto nowhere when level > 2', '  accept 783']), /unknown label "nowhere"/);
	assert.match(errorsOf(['step A', '  label here', '  accept 783', 'step B', '  skipto here when level > 2', '  kill 6']), /`skipto here` must name a later step/);
	assert.match(errorsOf(['step A', '  skipto end when skill Basketweaving > 1', '  accept 783', 'step B', '  label end', '  kill 6']), /unknown profession "Basketweaving"/);
});

test('Guides.lua carries skips after along; a pack with skips is format 3', () => {
	const { manifest } = readManifest(MINI);
	const r = compile(guideText(['guide mini/s', 'title S', 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest', '',
		'step A', '  accept 783', '  skipto end when turnedin 783', 'step B', '  label end', '  kill 6']), fixtureData(), { pack: 'mini' });
	assert.deepEqual(r.errors, [], r.text);
	const files = buildPackFiles({ guides: r.guides, manifest, data: fixtureData() });
	assert.match(files['Guides.lua'], /skips = \{ \{ to = "end", when = \{ "turnedin", 783 \} \} \},\n\t*goals = \{/);
	assert.equal(packFormat(r.guides), 3);
});
