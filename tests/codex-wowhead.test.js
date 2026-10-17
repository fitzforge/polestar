'use strict';
// The cached Wowhead Forever facts the Codex reads (tools/lib/codex/wowhead.js):
// pages and list rows from data/sources/wowhead/codex/, nothing fetched.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { loadWowhead, chanceOf } = require('../tools/lib/codex/wowhead');
const { tmpdir } = require('./helpers/tmp');

function writePage(sourcesDir, type, id, facts) {
	const file = path.join(sourcesDir, 'wowhead', 'codex', type, `${id}.json`);
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(file, JSON.stringify({ id, type, ...facts }));
}

test('loadWowhead keeps the list rows apart from the pages (listed)', () => {
	const sourcesDir = tmpdir('polestar-wh-load-');
	writePage(sourcesDir, 'npc', 5, { name: 'Paged', level: [3, 3], classification: 'rare', boss: false, location: [1], spawns: { 1: [[1, 2]] }, drops: [] });
	writePage(sourcesDir, 'npc', 7, { notFound: true });
	const file = path.join(sourcesDir, 'wowhead', 'codex', 'lists', 'npc.json');
	fs.mkdirSync(path.dirname(file), { recursive: true });
	const listed = (id) => ({ id, name: `Listed ${id}`, location: [2], level: [9, 10], classification: 'elite', boss: true, react: null, kind: 7, change: { status: 'new', lines: [] } });
	fs.writeFileSync(file, JSON.stringify({ type: 'npc', chunks: [{ lo: 0, hi: 25000, rows: [listed(5), listed(6)] }] }));
	const wh = loadWowhead(sourcesDir);
	assert.equal(wh.npc[5].name, 'Paged', 'a page stays the page');
	assert.equal(wh.npc[6], undefined, 'a row is no page: parity reads pages only');
	assert.equal(wh.npc[7], undefined, 'a page Wowhead had not is no entity');
	assert.deepEqual(Object.keys(wh.listed.npc), ['5', '6']);
	assert.deepEqual(wh.listed.npc[6].level, [9, 10]);
});

test('loadWowhead without a cache gives empty facts', () => {
	assert.deepEqual(loadWowhead(tmpdir('polestar-wh-none-')), { npc: {}, object: {}, item: {}, spell: {}, listed: {} });
});

test('chanceOf is the looted share in percent, 2 decimals', () => {
	assert.equal(chanceOf({ count: 1, outof: 3 }), 33.33);
});
