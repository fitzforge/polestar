'use strict';
// What the JS tools keep of the names addons (`forge data names` builds them:
// rust/crates/forge-data/tests/data/names.rs tests the builder): usedIds,
// the ids Polestar's data names, and the release taking every names addon.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { tmpdir } = require('./helpers/tmp');
const { LOCALE_CODES } = require('../tools/lib/i18n/locales');
const names = require('../tools/lib/i18n/names');

const FIX = path.join(__dirname, 'fixtures', 'names');
const INPUTS = { guides: path.join(FIX, 'Guides.lua'), questdb: path.join(FIX, 'questdb'), codex: path.join(FIX, 'codex') };

test('the ids kept are the ones the compiled guides (their goals and their texts\' tokens), the quest database and the Codex name', () => {
	const ids = names.usedIds(INPUTS);
	const sorted = (s) => [...s].sort((a, b) => a - b);
	assert.deepEqual(sorted(ids.quest), [7, 33, 34, 35, 176], 'goal quests, pre, closedBy and preTitles, QuestDB and Codex quests');
	assert.deepEqual(sorted(ids.npc), [6, 197, 240, 299, 448], 'goal and candidate NPCs, the names its texts show as tokens, QuestDB and Codex NPCs');
	assert.deepEqual(sorted(ids.object), [68, 2843]);
	assert.deepEqual(sorted(ids.item), [750, 1528, 2862], 'goal items, the guide reward, QuestDB and Codex items');
	assert.deepEqual(ids.counts.guides, { quest: 4, npc: 4, object: 1, item: 3 });
	assert.throws(() => names.usedIds({ ...INPUTS, questdb: path.join(FIX, 'nowhere') }), /forge data questdb.*--questdb/s, 'a missing input says how to get it');
});

test('the release zip and install take every language folder that is built, after the Codex; the nine are committed, the old folders never ship', () => {
	const { releaseAddons } = require('../tools/lib/dsl/project');
	const { languageAddon } = require('../tools/lib/i18n/toc');
	const { fakeAddons } = require('./helpers/cli');
	const { ADDONS } = require('./helpers/lua');
	const dir = fakeAddons(tmpdir(), ['Polestar', 'Polestar_Guides', 'Polestar_Nav', 'Polestar_Codex', 'Polestar_frFR', 'Polestar_Names_deDE', 'Polestar_Guides_deDE']);
	const r = releaseAddons(dir);
	assert.deepEqual(r.names, ['Polestar', 'Polestar_Guides', 'Polestar_Nav', 'Polestar_Codex', 'Polestar_frFR']);
	assert.ok(r.skipped.includes('Polestar_deDE'), 'one not built is left out');
	const languages = LOCALE_CODES.map(languageAddon);
	const shipped = releaseAddons(ADDONS).names.filter((n) => languages.includes(n));
	assert.deepEqual(shipped, languages);
});
