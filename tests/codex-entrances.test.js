'use strict';
// Codex instance entrances (tools/lib/codex/instances.js chooseEntrance and
// the curated table data/codex/entrances.json): a curated entry read from
// players' recordings beats the Recorder's raw entry points, a recording beats
// any other curated entry, which beats a guide's goto, which beats the
// client's corpse point (where a ghost returns), kept only as an approximate
// last resort.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { instanceFacts, buildInstances, chooseEntrance, loadEntranceTable } = require('../tools/lib/codex/instances');
const { emitPack } = require('../tools/lib/codex/pack');
const { isSourceCitation } = require('../tools/lib/codex/web');
const { writeCodexPack } = require('./helpers/codex');
const { runAddon } = require('./helpers/lua');

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

// WorldFloor (the world gate's Wetlands door walks): the Excavation Site's door lies in the hillside 100 yd over
// Thelgen Rock; the table's z rides along when the chosen point lies within 30 yd of its entry's, and the city gate
// takes the same doors (gate.js doorsOf) for walks that end going in.
test("chooseEntrance: a table entry's door floor rides along within 30 yd; the gate's doors are those entries as world points", () => {
	const WETLANDS = { c: 0, left: -389.583, right: -4525, top: -2147.917, bottom: -4904.167 };
	const door = { key: 'excavation-site-wetlands', map: 1437, x: 50.7, y: 61.1, z: 140, source: 'https://example.org' };
	const at = { name: 'Excavation Site: Wetlands', zones: {}, frames: { 1437: WETLANDS }, prefer: [1437], table: door };
	assert.equal(chooseEntrance(at).z, 140);
	assert.equal(chooseEntrance({ ...at, recorded: [{ map: 1437, x: 50.72, y: 61.12, n: 119 }] }).z, 140, 'a recording beside it');
	assert.equal(chooseEntrance({ ...at, recorded: [{ map: 1437, x: 47.8, y: 56.2, n: 3 }] }).z, undefined, '185 yd off: none');
	const { doorsOf } = require('../tools/lib/nav/city/gate');
	const [d] = doorsOf({ entrances: [door, { key: 'deadmines', map: 1436, x: 42.5, y: 71.7 }] }, { 1437: WETLANDS });
	assert.deepEqual([d.c, Math.round(d.wx), Math.round(d.wy), d.z], [0, -3832, -2486, 140]);
});

// #3562, #2447: inside a capital the most-seen recorded point can be far from the door (Orgrimmar's south gate,
// 86 entries, against 57 + 14 in the Cleft of Shadow; Ironforge 15.1,86.0, 166, against 80 below the city). There
// the most-seen point within 60 yd of the table's door wins; outside the capitals the most-seen point anywhere does.
test("chooseEntrance: inside a capital the recorded point at the table's door beats a bigger one elsewhere in the city (#3562, #2447)", () => {
	const ORGRIMMAR = { c: 1, left: -3680.601, right: -5083.206, top: 2273.877, bottom: 1338.461 };
	const IRONFORGE = { c: 0, left: -713.591, right: -1504.216, top: -4569.241, bottom: -5096.846 };
	const rfc = { key: 'ragefire-chasm', map: 1454, x: 52.6, y: 49, source: 'https://example.org' };
	const rfcRec = [{ map: 1454, x: 49.35, y: 95.11, n: 86 }, { map: 1454, x: 52.01, y: 49.46, n: 57 }, { map: 1454, x: 52.13, y: 49.42, n: 14 }];
	const at = { name: 'Ragefire Chasm', zones: {}, frames: { 1454: ORGRIMMAR }, prefer: [1454] };
	assert.deepEqual(chooseEntrance({ ...at, recorded: rfcRec, table: rfc }), { map: 1454, x: 52, y: 49.5, f: null });
	assert.deepEqual(chooseEntrance({ ...at, recorded: rfcRec }), { map: 1454, x: 49.4, y: 95.1, f: null }, 'no table entry: the most-seen point');
	const thanes = { key: 'the-hall-of-thanes', map: 1455, x: 28.3, y: 47.6, z: 399, source: 'https://example.org' };
	const thanesRec = [{ map: 1455, x: 15.1, y: 86.01, n: 166 }, { map: 1455, x: 28.37, y: 47.7, n: 80 }, { map: 1455, x: 32.69, y: 44.94, n: 9 }];
	const e = chooseEntrance({ name: 'The Hall of Thanes', zones: {}, frames: { 1455: IRONFORGE }, prefer: [1455], recorded: thanesRec, table: thanes });
	assert.deepEqual(e, { map: 1455, x: 28.4, y: 47.7, f: null, z: 399 }, "the door below the city, with the table's floor");
	const WETLANDS = { c: 0, left: -389.583, right: -4525, top: -2147.917, bottom: -4904.167 };
	const field = { key: 'excavation-site-wetlands', map: 1437, x: 50.7, y: 61.1, source: 'https://example.org' };
	const fieldRec = [{ map: 1437, x: 40, y: 40, n: 9 }, { map: 1437, x: 50.72, y: 61.12, n: 3 }];
	assert.deepEqual(chooseEntrance({ name: 'x', zones: {}, frames: { 1437: WETLANDS }, prefer: [1437], recorded: fieldRec, table: field }), { map: 1437, x: 40, y: 40, f: null }, 'outside the capitals: the most-seen point');
});

// #4032 (devanpy): Blackmaw Hold's portal is at the far end of a cave whose mouth is at Azshara 39,33.7. The Recorder's
// entry points (37.57,38.68, twice) are the last point it noted outside, 530 yd from the portal; the table's entry,
// read from where players' walks end before they go in, carries the cave floor's height there, so the arrow's walk goes
// in by the mouth. Krol'dok Stronghold's table entry (the small cave on the hill) likewise beats the 63 entries noted
// 220 yd south of it.
test("chooseEntrance: a table entry read from players' recordings beats the Recorder's entry points (#4032)", () => {
	const t = loadEntranceTable();
	const AZSHARA = { c: 1, left: -3277.083, right: -8347.916, top: 5341.667, bottom: 1960.417 };
	const blackmaw = { name: 'Blackmaw Hold', zones: {}, frames: { 1447: AZSHARA }, prefer: [1447], table: t['blackmaw-hold'] };
	const recorded = [{ map: 1447, x: 37.57, y: 38.68, n: 2 }, { map: 1447, x: 44.48, y: 31.86, n: 1 }];
	assert.deepEqual(chooseEntrance({ ...blackmaw, recorded }), { map: 1447, x: 35, y: 23.5, f: null, z: 166 });
	const RIVERGLADES = { c: 0, left: -1891.666, right: -6741.666, top: -6466.666, bottom: -9700 };
	const kroldok = chooseEntrance({ name: "Krol'dok Stronghold", zones: {}, frames: { 2548: RIVERGLADES }, prefer: [2548], table: t['kroldok-stronghold'], recorded: [{ map: 2548, x: 36.88, y: 44.1, n: 63 }, { map: 2548, x: 37.49, y: 37.99, n: 29 }] });
	assert.deepEqual(kroldok, { map: 2548, x: 37.5, y: 38.2, f: null });
});

test('a continent recording must land at the dungeon’s known zone', () => {
	const frames = {
		1415: { c: 0, left: 16000, right: -19199.9, top: 7466.6, bottom: -16000 },
		1424: { c: 0, left: 1066.667, right: -2133.333, top: 400, bottom: -1733.333 },
		1435: { c: 0, left: -2222.917, right: -4516.667, top: -9620.833, bottom: -11150 },
	};
	const temple = { name: 'Sunken Temple', frames, table: { map: 1435, x: 69.9, y: 53.5 } };
	const swamp = { map: 1435, x: 61.51, y: 49.32, n: 3 };
	assert.deepEqual(chooseEntrance({ ...temple, recorded: [{ map: 1415, x: 45.17, y: 33.14, n: 5 }, swamp] }), { ...temple.table, f: null });
	assert.deepEqual(chooseEntrance({ ...temple, recorded: [swamp] }), { map: 1435, x: 61.5, y: 49.3, f: null });
	assert.deepEqual(chooseEntrance({ ...temple, recorded: [{ map: 1415, x: 55.778, y: 76.02984, n: 3 }] }), { map: 1435, x: 61.5, y: 49.3, f: null });
	const ocean = [{ map: 1415, x: 1, y: 1, n: 8 }];
	assert.deepEqual(chooseEntrance({ ...temple, recorded: ocean }), { ...temple.table, f: null }, 'no zone contains this point');
	assert.equal(chooseEntrance({ ...temple, table: null, prefer: [1435], recorded: ocean }), null, 'a known zone also rules out the ocean without a table entry');
});

test('zone recordings must fall inside the entrance frame, even when map IDs differ', () => {
	const frames = {
		1426: { c: 0, left: 1802.083, right: -3122.917, top: -3877.083, bottom: -7160.417 },
		1427: { c: 0, left: -322.917, right: -2554.167, top: -6100, bottom: -7587.5 },
	};
	const table = { map: 1427, x: 34.8, y: 85.3 };
	const choose = (y) => chooseEntrance({ name: 'Blackrock Depths', table, frames, recorded: [{ map: 1426, x: 46.78, y, n: 1 }] });
	assert.deepEqual(choose(50.13), { ...table, f: null }, 'the reported point is north of Searing Gorge');
	assert.deepEqual(choose(85), { map: 1426, x: 46.8, y: 85, f: null }, 'the two maps overlap here; keep the recording');
	frames[1426].c = 1;
	assert.deepEqual(choose(85), { ...table, f: null }, 'overlapping coordinates on a different continent do not count');
});

test('the curated table: one entry per instance, each placed on a zone map with a public source', () => {
	const t = loadEntranceTable();
	const entries = Object.values(t);
	assert.ok(entries.length >= 30, `${entries.length} entries`);
	for (const e of entries) {
		assert.ok(Number.isInteger(e.map) && e.map > 0, `${e.key}: uiMap id`);
		assert.ok(e.x > 0 && e.x < 100 && e.y > 0 && e.y < 100, `${e.key}: map percent`);
		assert.ok(typeof e.source === 'string' ? /^https:\/\//.test(e.source) : isSourceCitation(e.source), `${e.key}: a source URL or a source cited the corrections' way`);
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

// The City of Dalaran has a way in for each faction (#706): the Horde's
// tunnel on the western wall, the Alliance's pipe in Cantrips & Crows.
const DALARAN = { key: 'city-of-dalaran', map: 1416, x: 8.5, y: 59.2, source: 'https://example.org', A: { map: 1416, x: 14.68, y: 62.99, source: 'https://example.org' } };

test("chooseEntrance: a table entry's Alliance way in rides along as entrance.A, whichever point wins", () => {
	const e = chooseEntrance({ name: 'City of Dalaran', table: DALARAN });
	assert.deepEqual(e, { map: 1416, x: 8.5, y: 59.2, f: null, A: { map: 1416, x: 14.7, y: 63 } });
	const rec = chooseEntrance({ name: 'City of Dalaran', table: DALARAN, recorded: [{ map: 1416, x: 8.6, y: 59.3, n: 1 }] });
	assert.deepEqual(rec.A, { map: 1416, x: 14.7, y: 63 }, 'a recording keeps the Alliance way in');
	assert.equal(chooseEntrance({ ...base, table }).A, undefined, 'one way in: no A');
});

// #3348: Blackrock Mountain has a door on each side, open to both factions; each Blackrock instance lists the other
// door, which rides along as entrance.doors (the arrow takes the nearer, Polestar/Dungeons' Dungeons.Entrance).
test("chooseEntrance: a table entry's other doors ride along as entrance.doors, and Blackrock's instances have both", () => {
	const brd = { key: 'blackrock-depths', map: 1427, x: 34.8, y: 85.3, source: 'https://example.org', doors: [{ map: 1428, x: 29.41, y: 38.3, source: 'https://example.org' }] };
	assert.deepEqual(chooseEntrance({ name: 'Blackrock Depths', table: brd }).doors, [{ map: 1428, x: 29.4, y: 38.3 }]);
	assert.deepEqual(chooseEntrance({ name: 'Blackrock Depths', table: brd, recorded: [{ map: 1427, x: 34.9, y: 85, n: 19 }] }).doors, [{ map: 1428, x: 29.4, y: 38.3 }], 'a recording keeps them');
	assert.equal(chooseEntrance({ ...base, table }).doors, undefined, 'one way in: no doors');
	const t = loadEntranceTable();
	const at = (e) => [e.map, e.x, e.y].join(' ');
	for (const k of ['blackrock-depths', 'blackrock-spire', 'molten-core', 'blackwing-lair']) {
		const e = t[k];
		const all = [at(e), ...(e.doors || []).map(at)].sort();
		assert.deepEqual(all, ['1427 34.8 85.3', '1428 29.4 38.3'], `${k}: the Searing Gorge and Burning Steppes doors`);
		for (const d of e.doors) assert.ok(/^https:\/\//.test(d.source) && d.note, `${k}: each door has a source and a note`);
	}
});

test('the curated table: the City of Dalaran sends the Alliance in through Cantrips & Crows, inside the city', () => {
	const d = loadEntranceTable()['city-of-dalaran'];
	assert.ok(d && d.A, 'an Alliance way in');
	assert.deepEqual([d.A.map, d.A.x, d.A.y], [1416, 14.7, 63]);
	assert.match(d.A.source, /^https:\/\//);
	assert.ok(d.A.note);
});

// The decoder handing it to an Alliance character only is
// rust/crates/forge-addontest/tests/addontest/dungeons-pickup.rs.
test('pack: the Alliance way in follows the entrance', () => {
	const inst = { key: 'city-of-dalaran', name: 'City of Dalaran', kind: 'dungeon', forever: true, areaId: 279, map: 2959, entrance: { map: 1416, x: 8.5, y: 59.2, f: null, A: { map: 1416, x: 14.7, y: 63 } }, levels: null, bosses: [] };
	const codex = { meta: { schema: 1 }, items: {}, npcs: {}, objects: {}, quests: {}, instances: { 'city-of-dalaran': inst }, zones: {}, factions: {}, spells: {}, frames: {} };
	const text = Object.values(emitPack(codex, { version: '0', build: 'test' })).join('\n');
	assert.match(text, /1416,85,592,,,1416,147,630/);
});

test('Lookup keeps the underground floor for the Hall of Thanes entrance (#2447)', (t) => {
	const key = 'the-hall-of-thanes';
	const map = 1455;
	const ironforge = { c: 0, left: -713.591, right: -1504.216, top: -4569.241, bottom: -5096.846 };
	const entrance = chooseEntrance({
		name: 'The Hall of Thanes', frames: { [map]: ironforge }, table: loadEntranceTable()[key],
		recorded: [{ map, x: 28.26, y: 47.64, n: 54 }],
	});
	const instance = { key, name: 'The Hall of Thanes', kind: 'dungeon', forever: true, map: 3065, entrance, bosses: [] };
	const npc = { id: 261311, name: 'Plunder', instance: key, spawns: [] };
	const item = { id: 271098, name: 'Golemguard Chest', kind: 'item', sources: [
		{ type: 'drop', npc: npc.id, instance: key, from: ['curated'] },
	] };
	const pack = writeCodexPack({
		meta: { schema: 1 }, items: { [item.id]: item }, npcs: { [npc.id]: npc }, objects: {},
		quests: {}, instances: { [key]: instance }, zones: {}, factions: {}, spells: {}, frames: { [map]: ironforge },
	});
	t.after(pack.cleanup);
	const [result] = runAddon({
		stubs: ['stub_world.lua'],
		before: `${pack.stubLua}
local w = stub.world
w.addMap(1455, { name = "Ironforge", c = 0, left = -713.591, right = -1504.216, top = -4569.241, bottom = -5096.846 })
w.level, w.faction = 14, "Alliance"
w.moveTo(1455, 47.64, 52.51)`,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Lookup/Lookup.xml'] }],
		login: true,
		script: `
local key = "the-hall-of-thanes"
local L, C = Polestar.Lookup, Polestar.Codex
local item = assert(L.BuildGuide("item", 271098))
local dungeon = assert(L.BuildGuide("instance", key))
local function point(p)
	return { p.map, p.x, p.y, p.z or false }
end
emit({ entrance = point(C.Instance(key).entrance), item = point(item.steps[1].goals[1]),
	dungeon = point(dungeon.steps[1].goals[1]) })`,
	}).emitted;
	const door = [1455, 28.3, 47.6, 399];
	assert.deepEqual(result, { entrance: door, item: door, dungeon: door });
});

// #1832: The Drowned City's way in is where players' recordings enter it: Sunken Hollow, due west of Grom'gol.
test("the curated table: The Drowned City's way in is where players enter it, at Sunken Hollow west of Grom'gol (#1832)", () => {
	const d = loadEntranceTable()['the-drowned-city'];
	assert.ok(d, 'an entry for the Forever dungeon');
	assert.equal(d.instance, 2970, 'the client Map id players enter');
	assert.deepEqual([d.map, d.x, d.y], [1434, 21.6, 27.7], 'Stranglethorn Vale, where players enter');
	assert.equal(d.source.kind, 'recording', 'cited from players\' recordings');
	assert.ok(isSourceCitation(d.source));
});

// #4432: The Shaper's Terrace (Forever's, instance map 3001) had no entrance at all, so a ghost's arrow pointed 232 yd
// off; its way in is on Un'Goro Crater's northern edge, where players' recordings enter it and the reporter stood.
test("the curated table: The Shaper's Terrace's way in is on Un'Goro Crater's northern edge, where players enter it (#4432)", () => {
	const d = loadEntranceTable()['the-shapers-terrace'];
	assert.ok(d, 'an entry for the Forever dungeon');
	assert.equal(d.instance, 3001, 'the client Map id players enter');
	assert.deepEqual([d.map, d.x, d.y], [1449, 48.2, 5.5], "Un'Goro Crater, where players enter");
	assert.equal(d.source.kind, 'recording', "cited from players' recordings");
	assert.ok(isSourceCitation(d.source));
	const UNGORO = { c: 1, left: 533.333, right: -3166.667, top: -5966.667, bottom: -8433.333 };
	assert.deepEqual(chooseEntrance({ name: "The Shaper's Terrace", zones: {}, frames: { 1449: UNGORO }, prefer: [1449], table: d }), { map: 1449, x: 48.2, y: 5.5, f: null }, 'the table entry, not nothing');
});
