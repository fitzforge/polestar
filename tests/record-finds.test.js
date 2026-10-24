'use strict';
// Recorded finds (addon/Polestar_Recorder/Finds.lua events) through
// `record import` and `data build` (tools/lib/data/recordings.js applyFinds):
// drop chances from kills and loot windows merged across sessions, ranks,
// levels, rare roles and spawns, treasures, instances and encounters, quest
// rewards; and a session recorded by the addon itself, imported and built.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { applyRecordings } = require('../tools/lib/data/recordings');
const { importFile } = require('../tools/lib/recording/import');
const { forge } = require('./helpers/cli');
const { runAddon } = require('./helpers/lua');
const { tmpdir } = require('./helpers/tmp');

const FIX = path.join(__dirname, '..', 'rust', 'tests', 'fixtures', 'data');

// The fixture world after pfQuest (see data.test.js): wolves 3 and 4 drop
// Wolf Pelt (50) at 45.5 % and 80 %, object 600 is a Peacebloom herb, 500 an
// altar giving the quest item 53.
function db() {
	return {
		quests: { 7: { id: 7, title: 'Kobold Camp Cleanup', level: 2, minLevel: null, races: null, classes: null, start: { npc: [823], object: [], item: [] }, end: { npc: [823], object: [] }, pre: [], excl: [], next: null, objectives: [], objectiveText: null, zone: 1429, xp: 450, skill: null, event: null, source: ['pfquest'] } },
		npcs: {
			3: { id: 3, name: 'Fixture Wolf', level: 3, levelMax: 4, faction: null, spawns: { 1429: { f: 'e', pts: [[20, 30]] } } },
			4: { id: 4, name: 'Fixture Wolf Alpha', level: 5, faction: null, spawns: { 1429: { f: 'e', pts: [[10, 10]] } } },
		},
		objects: {
			500: { id: 500, name: 'Fixture Altar', spawns: { 1429: { f: 'e', pts: [[30.12, 40.99]] } } },
			600: { id: 600, name: 'Peacebloom', roles: ['herb'], spawns: { 1429: { f: 'e', pts: [[33.3, 44.4]] } } },
		},
		items: {
			50: { id: 50, name: 'Wolf Pelt', drops: { npc: { 3: 45.5, 4: 80 }, object: { 600: 2.5 } }, vendors: [], source: ['pfquest'] },
			53: { id: 53, name: 'Altar Dust', drops: { npc: {}, object: { 500: 100 } }, vendors: [] },
			// a dropper whose chance no source gives (pfQuest refloot at 0)
			60: { id: 60, name: 'Molten Fragment', drops: { npc: { 3: null }, object: {} }, vendors: [] },
		},
		zones: {},
		factions: {},
		instances: {},
	};
}

const at = (x, y, map = 1429) => ({ map, x, y });
const slain = (npc, extra = {}) => ({ e: 'slain', npc, npcName: 'Fixture Wolf', cls: 'normal', npcLvl: 3, ...at(50, 50), ...extra });
const drop = (src, items, extra = {}) => ({ e: 'drop', ...src, items: items.map((item) => (typeof item === 'number' ? { item, n: 1 } : item)), ...at(50, 50), ...extra });
const session = (file, events) => ({ file, rec: { schema: 1, events } });

function sessions() {
	const one = [
		...Array.from({ length: 6 }, () => slain(3)),
		slain(3, { denied: true }), // someone else's corpse: not a kill for drop chances
		drop({ npc: 3 }, [50, 54, 60]),
		drop({ npc: 3 }, [50]),
		drop({ npc: 3 }, [50]),
		drop({ npc: 3 }, [{ item: 56, n: 2 }], { gather: 'skin' }), // skinning: no drop of the wolf
		slain(4, { npcName: 'Fixture Wolf Alpha', npcLvl: 5 }),
		slain(4, { npcName: 'Fixture Wolf Alpha', npcLvl: 6 }),
		drop({ npc: 4 }, [50]),
		{ e: 'rare', npc: 6, npcName: 'Fixture Rare', cls: 'rareelite', npcLvl: 12, src: 'nameplate', ...at(33, 44) },
		slain(6, { npcName: 'Fixture Rare', cls: 'rareelite', npcLvl: 12, ...at(33.5, 44.5) }),
		drop({ npc: 6 }, [55], at(33.5, 44.5)),
		drop({ object: 600 }, [57], { gather: 'herb', ...at(33.3, 44.4) }),
		drop({ object: 700 }, [58, { item: 59, n: 1, q: true }], at(25.1, 30.2)),
		drop({ object: 500 }, [{ item: 53, n: 1, q: true }], at(30.5, 41)),
		{ e: 'treasure', object: 701, objName: 'Battered Chest', src: 'vignette', ...at(60, 70) },
		{ e: 'enter', inst: 36, instName: 'Deadmines', instType: 'party', diff: 1, ...at(42.5, 71.8) },
		{ e: 'enter', inst: 36, instName: 'Deadmines', instType: 'party', diff: 1 }, // a /reload inside: no position
		{ e: 'slain', npc: 639, npcName: 'Edwin VanCleef', cls: 'elite', npcLvl: 21, inst: 36, diff: 1 },
		{ e: 'drop', npc: 639, npcName: 'Edwin VanCleef', items: [{ item: 5191, n: 1 }], inst: 36, diff: 1 },
		{ e: 'encounter', enc: 1736, encName: 'Edwin VanCleef', diff: 1, size: 5, ok: true, inst: 36, npcs: [639] },
		{ e: 'accept', q: 7, npc: 823, items: [2575], choices: [2577, 2578], rewardMoney: 75, ...at(48.2, 41.9) },
	];
	const two = [
		...Array.from({ length: 6 }, () => slain(3, { npcLvl: 5 })),
		drop({ npc: 3 }, [50]),
		drop({ npc: 3 }, [50]),
		drop({ npc: 3 }, [50]),
		{ e: 'enter', inst: 36, instName: 'Deadmines', instType: 'party', diff: 1, ...at(42.6, 71.9) },
		{ e: 'encounter', enc: 1736, encName: 'Edwin VanCleef', diff: 1, size: 5, ok: true, inst: 36, npcs: [639] },
		{ e: 'turnin', q: 7, npc: 823, xpReward: 450, money: 75, items: [2575], choices: [2577], rewardMoney: 75, ...at(48.2, 41.9) },
	];
	return [session('a.json', one), session('b.json', two)];
}

test('drop chances are loots over kills, merged across sessions; small samples only fill gaps', () => {
	const d = db();
	const stats = applyRecordings(d, sessions(), { liveMaps: { has: () => false } });
	// Wolf 3: 12 kills (the denied one left out), 6 windows with a pelt: 50 % replaces 45.5 %.
	assert.equal(d.items[50].drops.npc[3], 50);
	assert.deepEqual(d.items[50].seen, { npc: { 3: { n: 6, of: 12 }, 4: { n: 1, of: 2 } } });
	// Wolf 4: one pelt in two kills is too few to replace pfQuest's 80 %.
	assert.equal(d.items[50].drops.npc[4], 80);
	assert.deepEqual(d.items[50].source, ['pfquest', 'recorder']);
	// Items nothing else knew: the recorded chance fills them.
	assert.deepEqual(d.items[54].drops, { npc: { 3: 8.33 }, object: {} });
	assert.equal(d.items[60].drops.npc[3], 8.33, 'an unknown chance is filled by any sample');
	assert.deepEqual(d.items[55].drops.npc, { 6: 100 });
	assert.equal(d.items[56], undefined, 'skinning loot is not a drop');
	assert.deepEqual(d.items[5191].drops.npc, { 639: 100 });
	// Objects: windows with the item over windows opened.
	assert.equal(d.items[57].drops.object[600], 100);
	assert.deepEqual(d.items[58].seen, { object: { 700: { n: 1, of: 1 } } });
	assert.equal(d.items[53].drops.object[500], 100);
	assert.deepEqual(
		{ kills: stats.recordedKills, loots: stats.recordedLoots, sightings: stats.recordedSightings, chances: stats.recordedDropChances, treasures: stats.recordedTreasures, instances: stats.recordedInstances, encounters: stats.recordedEncounters },
		{ kills: 17, loots: 12, sightings: 2, chances: 8, treasures: 2, instances: 1, encounters: 1 },
	);
});

test('npcs and objects: rank, levels, rare role, spawns, treasures, instances and encounters', () => {
	const d = db();
	applyRecordings(d, sessions(), { liveMaps: { has: () => false } });
	// Kill levels widen the range; a normal classification is rank 0.
	assert.deepEqual([d.npcs[3].level, d.npcs[3].levelMax, d.npcs[3].rank], [3, 5, 0]);
	assert.deepEqual(d.npcs[3].spawns, { 1429: { f: 'e', pts: [[20, 30]] } }, 'kill positions never join existing spawns');
	// A rare seen only in Forever: rank, role, the sighting and the kill as spawns.
	assert.deepEqual(d.npcs[6], {
		id: 6, name: 'Fixture Rare', level: 12, rank: 2, faction: null, roles: ['rare'],
		spawns: { 1429: { f: 'l', pts: [[33, 44]] } },
	});
	assert.deepEqual(d.npcs[639], { id: 639, name: 'Edwin VanCleef', level: 21, rank: 1, faction: null, spawns: {}, instances: [36], encounter: 1736 });
	// Objects: a loot window with a non-quest item is a chest, a quest box is not.
	assert.deepEqual(d.objects[700], { id: 700, name: null, roles: ['chest'], spawns: { 1429: { f: 'l', pts: [[25.1, 30.2]] } } });
	assert.deepEqual(d.objects[701], { id: 701, name: 'Battered Chest', roles: ['chest'], spawns: { 1429: { f: 'l', pts: [[60, 70]] } } });
	assert.deepEqual(d.objects[500].roles, undefined);
	// Era spawns on an unchanged map frame take the opened position in.
	assert.deepEqual(d.objects[500].spawns, { 1429: { f: 'e', pts: [[30.12, 40.99], [30.5, 41]] } });
	assert.deepEqual(d.objects[600].roles, ['herb']);
	assert.deepEqual(d.instances, {
		36: {
			id: 36, name: 'Deadmines', type: 'party',
			entrances: [{ map: 1429, x: 42.55, y: 71.85, n: 2 }],
			encounters: { 1736: { name: 'Edwin VanCleef', npcs: [639], kills: 2 } },
			source: ['recorder'],
		},
	});
});

test('a map whose frame changed keeps its Era spawns apart from recorded points', () => {
	const d = db();
	applyRecordings(d, sessions(), { liveMaps: { has: (m) => m === 1429 } });
	assert.deepEqual(d.objects[500].spawns, { 1429: { f: 'e', pts: [[30.12, 40.99]] } });
	assert.deepEqual(d.npcs[6].spawns, { 1429: { f: 'l', pts: [[33, 44]] } });
});

test('quest frame rewards: the turn-in wins over the accept', () => {
	const d = db();
	applyRecordings(d, sessions());
	assert.deepEqual(d.quests[7].rewards, { items: [2575], choices: [2577], money: 75 });
	assert.deepEqual(Object.keys(d.quests[7]).slice(-5), ['xp', 'rewards', 'skill', 'event', 'source']);
});

// The addon records a session in the stub world; `record import` and
// `forge data build` turn it into facts the Codex reads.
test('a recorded session with a rare, kills and loot imports and builds into npcs, items and objects facts', async (t) => {
	const sv = runAddon({
		stubs: ['stub_recorder.lua'],
		addons: ['Polestar_Recorder'],
		login: true,
		script: `
			local function unit(token, guid, name, cls, lvl)
				stub.setUnit(token, guid, name)
				stub.world.units[token].cls, stub.world.units[token].lvl = cls, lvl
			end
			stub.moveTo(33, 44)
			local rare = stub.creature(6, "Fixture Rare")
			unit("nameplate1", rare, "Fixture Rare", "rare", 12)
			stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
			unit("target", rare, "Fixture Rare", "rare", 12)
			stub.fire("PLAYER_TARGET_CHANGED")
			stub.partyKill(rare)
			stub.world.loot = { { name = "Rare Fang", item = 55, src = { rare, 1 } } }
			stub.fire("LOOT_OPENED", false, false)
			stub.fire("LOOT_CLOSED")
			stub.moveTo(50, 50)
			for i = 1, 10 do
				local w = stub.creature(3, "Fixture Wolf")
				unit("target", w, "Fixture Wolf", "normal", 4)
				stub.fire("PLAYER_TARGET_CHANGED")
				stub.partyKill(w)
				stub.world.loot = i <= 4 and { { name = "Wolf Pelt", item = 50, src = { w, 1 } } } or {}
				stub.fire("LOOT_OPENED", false, false)
				stub.fire("LOOT_CLOSED")
			end
			stub.moveTo(25.1, 30.2)
			stub.world.loot = { { name = "Linen Cloth", item = 58, count = 2, src = { (stub.gameObject(700)), 2 } } }
			stub.fire("LOOT_OPENED", false, false)
			stub.fire("PLAYER_LOGOUT")
			emit(stub.serialize(PolestarRecorderDB))`,
	}).emitted[0];
	const dir = tmpdir('polestar-finds-');
	const svDir = path.join(dir, 'WTF', 'Account', 'TEST', 'SavedVariables');
	fs.mkdirSync(svDir, { recursive: true });
	fs.writeFileSync(path.join(svDir, 'Polestar_Recorder.lua'), `PolestarRecorderDB = ${sv}\n`);
	const recordings = path.join(dir, 'recordings');
	const imported = importFile(path.join(svDir, 'Polestar_Recorder.lua'), { outDir: recordings });
	assert.equal(imported.sessions.length, 1);
	const drop = JSON.parse(fs.readFileSync(imported.sessions[0].file, 'utf8')).events.find((e) => e.e === 'drop');
	assert.deepEqual(drop.items, [{ item: 55, n: 1 }], 'loot lists survive the SavedVariables round trip');

	const outDir = path.join(dir, 'forever');
	const r = forge(['data', 'build', '--offline', '--no-questie', '--no-forever', '--no-web-xp', '--no-web-zones', '--pfquest', path.join(FIX, 'pfquest'), '--sources', path.join(FIX, 'sources'), '--recordings', recordings, '--out', outDir, '--built-at', '2026-01-01T00:00:00Z']);
	if (!r) return t.skip('no forge binary (rust/target/release/forge or $FORGE)');
	assert.equal(r.status, 0, r.stderr);
	const read = (name) => JSON.parse(fs.readFileSync(path.join(outDir, `${name}.json`), 'utf8'));
	const meta = read('meta');
	const npcs = read('npcs');
	const items = read('items');
	const objects = read('objects');
	assert.deepEqual(npcs[6], { id: 6, name: 'Fixture Rare', level: 12, rank: 4, faction: null, roles: ['rare'], spawns: { 1429: { f: 'l', pts: [[33, 44]] } } });
	assert.equal(npcs[3].rank, 0);
	assert.deepEqual(items[55].drops.npc, { 6: 100 });
	// 4 pelts in 10 kills (empty corpses count): enough kills to replace pfQuest's 45.5 %.
	assert.equal(items[50].drops.npc[3], 40);
	assert.deepEqual(items[50].seen.npc[3], { n: 4, of: 10 });
	assert.deepEqual(objects[700], { id: 700, name: null, roles: ['chest'], spawns: { 1429: { f: 'l', pts: [[25.1, 30.2]] } } });
	assert.deepEqual(read('instances'), {});
	assert.deepEqual(
		[meta.counts.recordedKills, meta.counts.recordedLoots, meta.counts.recordedSightings, meta.counts.recordedTreasures],
		[11, 6, 1, 1],
	);
});
