'use strict';
// `when` checks and documentation: ids a `when`
// names are checked against reference data like goal ids are, and the
// format-2 language is documented where authors and maintainers look.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { compile, guideText } = require('./helpers/dsl');

const DOCS = path.join(__dirname, '..', 'docs');
const read = (f) => fs.readFileSync(path.join(DOCS, f), 'utf8');

function diags(lines) {
	return compile(guideText(lines));
}

test('a `when` naming a quest or item missing from data warns at the `when` line, without failing', () => {
	const r = diags(['step One', '  when onquest 99999 or has 99998 x2', '  accept 783']);
	assert.deepEqual(r.errors, []);
	const text = guideText(['step One', '  when onquest 99999 or has 99998 x2', '  accept 783']);
	const line = text.split('\n').findIndex((l) => l.trim().startsWith('when ')) + 1;
	assert.ok(r.warnings.some((w) => w === `test.guide:${line}: \`when\`: quest 99999 is not in data (new Forever content?)`), r.text);
	assert.ok(r.warnings.some((w) => w === `test.guide:${line}: \`when\`: item 99998 is not in data (new Forever content?)`), r.text);
});

test('ids that are in data, and ready/turnedin quests nested anywhere, are checked the same way', () => {
	assert.deepEqual(diags(['step One', '  when onquest 783 and has 750', '  accept 783']).warnings.filter((w) => w.includes('`when`')), []);
	const r = diags(['step One', '  when not (ready 99997 or turnedin 99996)', '  accept 783']);
	assert.equal(r.warnings.filter((w) => /`when`: quest 9999[67] is not in data/.test(w)).length, 2, r.text);
});

test('GUIDE_FORMAT.md documents `when` and every keyword of its language', () => {
	const doc = read('GUIDE_FORMAT.md');
	assert.match(doc, /^### `when`/m);
	for (const kw of ['onquest', 'ready', 'turnedin', 'has', 'level', 'skill', 'rep', 'zone', 'not', 'and', 'or']) {
		assert.match(doc, new RegExp(`\`${kw}\\b`), `GUIDE_FORMAT.md should mention \`${kw}\``);
	}
});

test('PACK_FORMAT.md documents format 2 and what reads it', () => {
	const doc = read('PACK_FORMAT.md');
	assert.match(doc, /^## Format 2/m);
	assert.match(doc, /Format 2 is read by Polestar 0\.3\.0 and\s+later/);
	assert.match(doc, /`when`/);
});

test('ARCHITECTURE.md has the Predicate contract Core/Predicate.lua points at', () => {
	const doc = read('ARCHITECTURE.md');
	assert.match(doc, /^### Predicate/m);
	for (const name of ['Validate', 'Eval', 'NewEnv', 'NewPass', 'PassEnv']) assert.match(doc, new RegExp(`Predicate\\.${name}|P\\.${name}|\\b${name}\\(`), name);
});
