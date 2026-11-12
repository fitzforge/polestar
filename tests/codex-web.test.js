'use strict';
// The cached Forever facts the Codex reads (tools/lib/codex/web.js):
// pages and list rows from data/sources/web/codex/, nothing fetched; and the
// curated tables' citations of the web quest database.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { loadWeb, chanceOf, isWebCitation, isSourceCitation, citationText } = require('../tools/lib/codex/web');
const { loadJournalQuests } = require('../tools/lib/codex/journal');
const { tmpdir } = require('./helpers/tmp');

function writePage(sourcesDir, type, id, facts) {
	const file = path.join(sourcesDir, 'web', 'codex', type, `${id}.json`);
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(file, JSON.stringify({ id, type, ...facts }));
}

test('loadWeb keeps the list rows apart from the pages (listed)', () => {
	const sourcesDir = tmpdir('polestar-web-load-');
	writePage(sourcesDir, 'npc', 5, { name: 'Paged', level: [3, 3], classification: 'rare', boss: false, location: [1], spawns: { 1: [[1, 2]] }, drops: [] });
	writePage(sourcesDir, 'npc', 7, { notFound: true });
	const file = path.join(sourcesDir, 'web', 'codex', 'lists', 'npc.json');
	fs.mkdirSync(path.dirname(file), { recursive: true });
	const listed = (id) => ({ id, name: `Listed ${id}`, location: [2], level: [9, 10], classification: 'elite', boss: true, react: null, kind: 7, change: { status: 'new', lines: [] } });
	fs.writeFileSync(file, JSON.stringify({ type: 'npc', chunks: [{ lo: 0, hi: 25000, rows: [listed(5), listed(6)] }] }));
	const wh = loadWeb(sourcesDir);
	assert.equal(wh.npc[5].name, 'Paged', 'a page stays the page');
	assert.equal(wh.npc[6], undefined, 'a row is no page: parity reads pages only');
	assert.equal(wh.npc[7], undefined, 'a page the source had not is no entity');
	assert.deepEqual(Object.keys(wh.listed.npc), ['5', '6']);
	assert.deepEqual(wh.listed.npc[6].level, [9, 10]);
});

test('loadWeb without a cache gives empty facts', () => {
	assert.deepEqual(loadWeb(tmpdir('polestar-web-none-')), { npc: {}, object: {}, item: {}, spell: {}, listed: {} });
});

test('chanceOf is the looted share in percent, 2 decimals', () => {
	assert.equal(chanceOf({ count: 1, outof: 3 }), 33.33);
});

test('isWebCitation takes { edition, kind, id } and guide { edition, kind, ref } only', () => {
	assert.ok(isWebCitation({ edition: 'forever', kind: 'quest', id: 7848 }));
	assert.ok(isWebCitation({ edition: 'forever', kind: 'npc', id: 9023, note: "'can be found in Blackrock Depths'" }));
	assert.ok(isWebCitation({ edition: 'classic', kind: 'guide', ref: 'some-reputation-guide' }));
	assert.ok(!isWebCitation('https://warcraft.wiki.gg/wiki/Crescent_Key'), 'a URL is no citation object');
	assert.ok(!isWebCitation({ edition: 'retail', kind: 'quest', id: 1 }));
	assert.ok(!isWebCitation({ edition: 'forever', kind: 'quest', id: 1.5 }));
	assert.ok(!isWebCitation({ edition: 'forever', kind: 'guide', id: 3 }));
	assert.ok(!isWebCitation({ edition: 'forever', kind: 'quest', id: 3, note: 4 }));
});

test('citationText names the edition, kind and id, never a URL', () => {
	assert.equal(citationText({ edition: 'forever', kind: 'quest', id: 4743, note: 'no reward' }), 'Forever quest 4743 (no reward)');
	assert.equal(citationText({ edition: 'classic', kind: 'guide', ref: 'a-guide' }), 'Classic guide "a-guide"');
	assert.equal(citationText('wago.tools ItemSparse'), 'wago.tools ItemSparse');
});

test("isSourceCitation takes a source cited the corrections' way, { kind, ref }, and nothing else", () => {
	assert.ok(isSourceCitation({ kind: 'recording', ref: '15 people entered the instance at 21.6,27.7' }));
	assert.ok(isSourceCitation({ kind: 'tdb', ref: 'gameobject 103664 spawned in map 189' }));
	assert.ok(!isSourceCitation({ kind: 'recording' }), 'a ref is needed');
	assert.ok(!isSourceCitation({ kind: 'recording', ref: '' }));
	assert.ok(!isSourceCitation({ kind: 'wiki', ref: 'a page' }), 'a kind the corrections know');
	assert.ok(!isSourceCitation({ kind: 'recording', ref: 'x', note: 'y' }), 'nothing else');
	assert.ok(!isSourceCitation('players\' recordings'));
});

// #1832: The Drowned City's quests whose objective items the quest data places on no mob or object inside are on its
// page through the cited table, each from players' recordings of their objectives inside; Wound Dressings (Mageweave
// Cloth, which drops everywhere) is no dungeon quest.
test("the journal-quests table: The Drowned City's quests no rule places, from players' recordings (#1832)", () => {
	const rows = loadJournalQuests();
	const on = rows.filter((r) => r.instance === 'the-drowned-city');
	assert.deepEqual(on.map((r) => r.quest).sort((a, b) => a - b), [95775, 95787, 95788, 95789, 96774, 97130]);
	for (const r of on) assert.equal(r.source.kind, 'recording', `${r.quest}: players' recordings`);
	assert.ok(!rows.some((r) => r.quest === 96081), 'Wound Dressings is no dungeon quest');
});

// Rituals of Power (Mage): its book is taken from an object that stands only inside the Scarlet Monastery, which no rule
// ties to a dungeon, so the cited table puts it on the Scarlet Monastery's page.
test("the journal-quests table: Rituals of Power is on the Scarlet Monastery's page", () => {
	const row = loadJournalQuests().find((r) => r.quest === 1951);
	assert.ok(row, 'a row for Rituals of Power');
	assert.equal(row.instance, 'scarlet-monastery');
	assert.equal(row.source.kind, 'tdb', "the world database's spawn of the book");
});
