'use strict';
// Documentation of format-2 `label` and `along`: authors find them in GUIDE_FORMAT.md, pack authors in
// PACK_FORMAT.md, maintainers in ARCHITECTURE.md.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const DOCS = path.join(__dirname, '..', 'docs');
const read = (f) => fs.readFileSync(path.join(DOCS, f), 'utf8');

test('GUIDE_FORMAT.md documents label and along', () => {
	const doc = read('GUIDE_FORMAT.md');
	assert.match(doc, /^\| `label <name>` \|/m, 'Steps directive table row for label');
	assert.match(doc, /^\| `along( \[until <label>\])?` \|/m, 'Steps directive table row for along');
	assert.match(doc, /^### Along the way: `along` and `label`$/m);
	for (const phrase of ['never hold', 'Along the way', 'until', 'later step', 'format 2']) assert.ok(doc.includes(phrase), phrase);
	assert.match(doc, /duplicate label|unknown label/);
});

test('PACK_FORMAT.md lists label and along under Format 2', () => {
	const doc = read('PACK_FORMAT.md');
	const f2 = doc.slice(doc.indexOf('## Format 2'), doc.indexOf('## Versioning'));
	assert.ok(f2.length > 0);
	assert.match(f2, /`label`/);
	assert.match(f2, /`along`/);
	assert.match(f2, /bad along|bad label/);
});

test('ARCHITECTURE.md documents GetAlong and AimAlong', () => {
	const doc = read('ARCHITECTURE.md');
	assert.match(doc, /Polestar\.Engine\.GetAlong\(\)/);
	assert.match(doc, /Polestar\.Engine\.AimAlong\(/);
});
