'use strict';
// documentation of conditional `next`, the mode/xprate/xp
// atoms, fractional level goals and the Play style settings.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const read = (f) => fs.readFileSync(path.join(__dirname, '..', 'docs', f), 'utf8');

test('GUIDE_FORMAT.md: conditional next, the new atoms, fractional levels', () => {
	const doc = read('GUIDE_FORMAT.md');
	assert.match(doc, /`next <id> when <(expr|condition)>`/);
	for (const atom of ['mode <', 'xprate <op>', 'xp <op>']) assert.ok(doc.includes(atom), atom);
	for (const m of ['hardcore', 'ssf', 'ah', 'group']) assert.ok(doc.includes(`\`${m}\``), m);
	assert.match(doc, /`level <L>\.<frac>`/);
	assert.match(doc, /`level <L>\+<XP>`/);
	assert.match(doc, /Play style/);
});

test('GUIDE_CHEATSHEET.md: one row each for next … when and fractional level', () => {
	const doc = read('GUIDE_CHEATSHEET.md');
	assert.match(doc, /^\| `next <id> when <condition>` \|/m);
	assert.match(doc, /^\| `level <N>\.<fraction>` \/ `level <N>\+<XP>` \|/m);
});

test('PACK_FORMAT.md: the new nodes and the frac goal key under Format 2', () => {
	const doc = read('PACK_FORMAT.md');
	const f2 = doc.slice(doc.indexOf('## Format 2'), doc.indexOf('## Versioning'));
	for (const node of ['{ "mode", key }', '{ "xprate", op, n }', '{ "xp", op, v }']) assert.ok(f2.includes(node), node);
	assert.match(f2, /`frac`/);
	assert.match(f2, /`nextWhen`/);
});
