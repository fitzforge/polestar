'use strict';
// Codex instance entrances (tools/lib/codex/instances.js chooseEntrance and
// the curated table data/codex/entrances.json): a recording beats the
// curated table, which beats a guide's goto, which beats the client's corpse
// point (where a ghost returns), kept only as an approximate last resort.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { instanceFacts, buildInstances, chooseEntrance, loadEntranceTable } = require('../tools/lib/codex/instances');
const { emitPack } = require('../tools/lib/codex/pack');

// Westfall's live frame: world x north / y west -> map percent.
const WESTFALL = { c: 0, left: 2000, right: -1000, top: -9000, bottom: -12000 };
const ZONES = { 1436: { id: 1436, name: 'Westfall', areaId: 40 } };
const CORPSE = { c: 0, x: -10500, y: 1100 }; // Westfall 30,50

const recorded = [{ map: 1436, x: 42.61, y: 71.84, n: 2 }, { map: 1436, x: 1, y: 1, n: 1 }];
const table = { key: 'deadmines', map: 1436, x: 42.5, y: 71.7, source: 'https://example.org' };
const guides = [{ label: 'The Deadmines portal, inside the Moonbrook mine', map: null, zone: 'Westfall', x: 38, y: 77.5 }];
const base = { name: 'Deadmines', zones: ZONES, frames: { 1436: WESTFALL }, prefer: [1436] };

test('chooseEntrance: recording > curated table > guide marker > corpse point (approximate)', () => {
	assert.deepEqual(chooseEntrance({ ...base, recorded, table, guides, corpse: CORPSE }), { map: 1436, x: 42.6, y: 71.8, f: null }, 'the most-seen recording');
	assert.deepEqual(chooseEntrance({ ...base, table, guides, corpse: CORPSE }), { map: 1436, x: 42.5, y: 71.7, f: null }, 'the curated table');
	assert.deepEqual(chooseEntrance({ ...base, guides, corpse: CORPSE }), { map: 1436, x: 38, y: 77.5, f: null }, "a guide's goto naming it");
	assert.deepEqual(chooseEntrance({ ...base, corpse: CORPSE }), { map: 1436, x: 30, y: 50, f: null, approx: true }, 'the corpse point, marked approximate');
	assert.equal(chooseEntrance({ ...base }), null, 'nothing known: no entrance');
});

test('the curated table: one entry per instance, each placed on a zone map with a public source', () => {
	const t = loadEntranceTable();
	const entries = Object.values(t);
	assert.ok(entries.length >= 30, `${entries.length} entries`);
	for (const e of entries) {
		assert.ok(Number.isInteger(e.map) && e.map > 0, `${e.key}: uiMap id`);
		assert.ok(e.x > 0 && e.x < 100 && e.y > 0 && e.y < 100, `${e.key}: map percent`);
		assert.match(e.source, /^https:\/\//, `${e.key}: source URL`);
		assert.ok(e.note, `${e.key}: note`);
	}
});

test('buildInstances: the Deadmines point at the Moonbrook entrance, not the corpse point in the mine', () => {
	const facts = instanceFacts({
		Map: [{ ID: '36', MapName_lang: 'Deadmines', InstanceType: '1', MaxPlayers: '10', AreaTableID: '1581', CorpseMapID: '0', Corpse_0: String(CORPSE.x), Corpse_1: String(CORPSE.y) }],
		AreaTable: [{ ID: '40', AreaName_lang: 'Westfall', ContinentID: '0', ParentAreaID: '0' }],
		DungeonEncounter: [{ ID: '1', Name_lang: 'Edwin VanCleef', MapID: '36', DifficultyID: '0', OrderIndex: '0' }],
		LFGDungeons: [{ ID: '5', Name_lang: 'Deadmines', TypeID: '0', ContentTuningID: '0' }],
	});
	const ctx = { zones: ZONES, frames: { 1436: WESTFALL }, curated: guides };
	const { instances } = buildInstances(facts, { ...ctx, entranceTable: loadEntranceTable() });
	assert.deepEqual(instances.deadmines.entrance, { map: 1436, x: 42.5, y: 71.7, f: null }, 'Moonbrook (the curated table beats the guide goto copying the corpse point)');
	assert.deepEqual(buildInstances(facts, ctx).instances.deadmines.entrance, { map: 1436, x: 38, y: 77.5, f: null }, 'without the table: the guide');
});

test('pack: an approximate entrance carries its flag', () => {
	const inst = (approx) => ({ key: 'deadmines', name: 'Deadmines', kind: 'dungeon', forever: false, areaId: 1581, map: 36, entrance: { map: 1436, x: 30, y: 50, f: null, ...(approx ? { approx } : {}) }, levels: null, bosses: [] });
	const line = (approx) => {
		const files = emitPack({ meta: { schema: 1 }, items: {}, npcs: {}, objects: {}, quests: {}, instances: { deadmines: inst(approx) }, zones: {}, factions: {}, spells: {}, frames: {} }, { version: '0', build: 'test' });
		const text = Object.values(files).join('\n');
		const m = text.match(/1436,300,500,[^;"]*/);
		return m && m[0];
	};
	assert.equal(line(true), '1436,300,500,,a');
	assert.equal(line(false), '1436,300,500,');
});
