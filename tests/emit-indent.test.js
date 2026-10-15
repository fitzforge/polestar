'use strict';
// Guides.lua indentation is exact: guide keys sit three tabs deep inside
// RegisterGuide({ ... }), every kind of value alike. Format-1 output must not
// change when format-2 keys are added (the other emit tests match with \t*,
// so they cannot catch a shifted line).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { compile, fixtureData } = require('./helpers/dsl');
const { readManifest } = require('../tools/lib/pack/manifest');
const { buildPackFiles } = require('../tools/lib/dsl/project');

const MINI = path.join(__dirname, 'fixtures', 'packs', 'mini');
const src = (id, extra, levels = '1-6') => [`guide ${id}`, `title ${id}`, 'faction Alliance', ...extra, `levels ${levels}`, 'zone Elwynn Forest', '', 'step One', '  accept 783', ''].join('\n');

test('every guide key of Guides.lua is indented by exactly three tabs', () => {
	const { manifest } = readManifest(MINI);
	const r = compile({
		'a.guide': src('mini/a', ['race Human, Dwarf', 'keywords wolf, meat', 'next mini/b, mini/c', 'next mini/d when Mage']),
		'b.guide': src('mini/b', [], '5-10'), 'c.guide': src('mini/c', [], '5-10'), 'd.guide': src('mini/d', [], '5-10'),
	}, fixtureData(), { pack: 'mini' });
	assert.deepEqual(r.errors, [], r.text);
	const lua = buildPackFiles({ guides: r.guides, manifest, data: fixtureData() })['Guides.lua'];
	for (const key of ['id', 'races', 'keywords', 'next', 'nextChoices', 'nextWhen', 'steps']) {
		assert.match(lua, new RegExp(`\\n\\t\\t\\t${key} = `), `${key} at three tabs`);
		assert.doesNotMatch(lua, new RegExp(`\\n\\t\\t\\t\\t+${key} = `), `${key} not deeper`);
	}
});
