'use strict';
// The pack docs keep up with the code: docs/PACK_FORMAT.md (the contract)
// names every goal verb the runtime reads (Core/Guides.lua's REQUIRED table,
// Polestar.Guides.VERBS) and every guide and goal key the compiler writes
// (tools/lib/dsl/emit.js); docs/PACKS.md (the handbook) names every problem
// kind and pack status the Guide packs page can show.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { GUIDE_KEYS, GOAL_KEYS } = require('../tools/lib/dsl/emit');

const ROOT = path.join(__dirname, '..');
const read = (rel) => fs.readFileSync(path.join(ROOT, rel), 'utf8');
// A name counts when the doc writes it as code: `accept`.
const names = (text, name) => text.includes(`\`${name}\``);

function missing(text, list) {
	return list.filter((name) => !names(text, name));
}

test('PACK_FORMAT.md names every goal verb the runtime reads', () => {
	const [verbs] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Core/Data.lua', 'Core/Names.lua', 'Core/GuideTexts.lua', 'Core/Guides.lua'] }],
		script: 'local out = {} for k in pairs(Polestar.Guides.VERBS) do out[#out + 1] = k end table.sort(out) emit(out)',
	}).emitted;
	assert.ok(verbs.length >= 20, `expected the runtime's verb list, got ${JSON.stringify(verbs)}`);
	assert.deepEqual(missing(read('docs/PACK_FORMAT.md'), verbs), []);
});

test('PACK_FORMAT.md names every guide and goal key the compiler writes', () => {
	assert.ok(Array.isArray(GUIDE_KEYS) && GUIDE_KEYS.length, 'emit.js exports GUIDE_KEYS');
	assert.ok(Array.isArray(GOAL_KEYS) && GOAL_KEYS.length, 'emit.js exports GOAL_KEYS');
	const doc = read('docs/PACK_FORMAT.md');
	assert.deepEqual(missing(doc, GUIDE_KEYS), []);
	assert.deepEqual(missing(doc, GOAL_KEYS), []);
});

test('PACKS.md names every problem kind and pack status', () => {
	const doc = read('docs/PACKS.md');
	assert.deepEqual(missing(doc, ['pack-refused', 'guide-refused', 'no-guides']), []);
	assert.deepEqual(missing(doc, ['on', 'off', 'disabled', 'not-loaded', 'too-new', 'refused', 'broken']), []);
});
