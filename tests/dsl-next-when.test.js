'use strict';
// `next <id> when <expr>` header lines. Every `next` line
// adds to the guide's route options in order; a line with `when` names one
// guide and makes that option conditional (format 2).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { compile, plain, fixtureData } = require('./helpers/dsl');
const { readManifest } = require('../tools/lib/pack/manifest');
const { buildPackFiles, packFormat } = require('../tools/lib/dsl/project');

const MINI = path.join(__dirname, 'fixtures', 'packs', 'mini');

const guide = (id, nextLines, levels = '1-10') =>
	[`guide ${id}`, `title ${id}`, 'faction Alliance', `levels ${levels}`, 'zone Elwynn Forest', ...nextLines, '', 'step One', '  accept 783', ''].join('\n');

function build(nextLines) {
	return compile({
		'a.guide': guide('t/a', nextLines),
		'x.guide': guide('t/x', [], '10-20'),
		'y.guide': guide('t/y', [], '10-20'),
		'z.guide': guide('t/z', [], '10-20'),
	});
}
const gA = (r) => plain(r.guides.find((g) => g.id === 't/a'));

test('several `next` lines combine in order; `when` makes an option conditional', () => {
	const r = build(['next t/x when Mage', 'next t/y when not turnedin 783', 'next t/z']);
	assert.deepEqual(r.errors, [], r.text);
	const a = gA(r);
	assert.equal(a.next, 't/x');
	assert.deepEqual(a.nextChoices, ['t/x', 't/y', 't/z']);
	assert.deepEqual(a.nextWhen, { 't/x': ['class', ['MAGE']], 't/y': ['not', ['turnedin', 783]] });
});

test('a single conditional `next` still becomes a choice list (so the condition is checked)', () => {
	const r = build(['next t/x when level >= 10']);
	assert.deepEqual(r.errors, [], r.text);
	const a = gA(r);
	assert.deepEqual(a.nextChoices, ['t/x']);
	assert.deepEqual(a.nextWhen, { 't/x': ['level', '>=', 10] });
});

test('plain `next` lists behave as before (no nextWhen)', () => {
	const a = gA(build(['next t/x, t/y']));
	assert.deepEqual(a.nextChoices, ['t/x', 't/y']);
	assert.equal(a.nextWhen, undefined);
	const b = gA(build(['next t/x']));
	assert.equal(b.next, 't/x');
	assert.equal(b.nextChoices, undefined);
});

test('errors', () => {
	assert.match(build(['next t/x, t/y when Mage']).errors.join('\n'), /`next \.\.\. when` names one guide/);
	assert.match(build(['next t/x when']).errors.join('\n'), /`next`: empty when expression/);
	assert.match(build(['next t/x when Wizard']).errors.join('\n'), /`next`: unknown condition "Wizard"/);
	assert.match(build(['next t/x when Mage', 'next t/x']).errors.join('\n'), /`next` names the same guide twice/);
	assert.match(build(['next t/nowhere when Mage']).errors.join('\n'), /t\/nowhere/);
});

test('Guides.lua carries nextWhen; a pack with it is format 2', () => {
	const { manifest } = readManifest(MINI);
	const src = (id, extra, levels = '1-10') => [`guide ${id}`, `title ${id}`, 'faction Alliance', `levels ${levels}`, 'zone Elwynn Forest', ...extra, '', 'step One', '  accept 783', ''].join('\n');
	const r = compile({ 'a.guide': src('mini/a', ['next mini/b when Mage', 'next mini/c']), 'b.guide': src('mini/b', [], '10-20'), 'c.guide': src('mini/c', [], '10-20') }, fixtureData(), { pack: 'mini' });
	assert.deepEqual(r.errors, [], r.text);
	const files = buildPackFiles({ guides: r.guides, manifest, data: fixtureData() });
	assert.match(files['Guides.lua'], /nextChoices = \{ "mini\/b", "mini\/c" \},\n\t*nextWhen = \{ \["mini\/b"\] = \{ "class", \{ "MAGE" \} \} \},\n/);
	assert.equal(packFormat(r.guides), 2);
});
