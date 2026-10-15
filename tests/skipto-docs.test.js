'use strict';
// Phase 3, Task 3.4: documentation of `skipto` and `done <label>`.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const read = (f) => fs.readFileSync(path.join(__dirname, '..', 'docs', f), 'utf8');

test('GUIDE_FORMAT.md documents skipto and done', () => {
	const doc = read('GUIDE_FORMAT.md');
	assert.match(doc, /^\| `skipto <label> when <expr>` \|/m);
	assert.match(doc, /^### Jumps: `skipto` and `done`$/m);
	for (const phrase of ['arrives', 'saved', 'does not undo', '`done <label>`', 'not skipped']) assert.ok(doc.includes(phrase), phrase);
	assert.match(doc, /^\| `done <label>` \|/m, '`when` atoms table row');
});

test('PACK_FORMAT.md lists skips and the done node under Format 2', () => {
	const doc = read('PACK_FORMAT.md');
	const f2 = doc.slice(doc.indexOf('## Format 2'), doc.indexOf('## Versioning'));
	assert.match(f2, /\{ "done", label \}/);
	assert.match(f2, /`skips`/);
	assert.match(f2, /bad skipto/);
	assert.match(f2, /"jump"/);
});

test('ARCHITECTURE.md mentions SetDoneResolver', () => {
	assert.match(read('ARCHITECTURE.md'), /SetDoneResolver/);
});
