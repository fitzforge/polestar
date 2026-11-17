'use strict';
// Drops and loot in a release Codex: a boss's own table before Forever's
// world-drop pool (tools/lib/codex/instances.js), a rare's or treasure's own
// drops first and LOOT_CAP, what each cap cuts (evidence.cut) and the reason
// parity gives those rows (tools/lib/codex/build.js, parity.js).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { instanceFacts, buildInstances } = require('../tools/lib/codex/instances');
const { clientFacts, mergeCodex } = require('../tools/lib/codex/build');
const { buildJournal, emitJournal } = require('../tools/lib/codex/journal');
const { compareCodex } = require('../tools/lib/codex/parity');
const dungeonsFixture = require('./fixtures/codex/dungeons.json');

const TABLES = {
	Map: [{ ID: '249', MapName_lang: "Onyxia's Lair", InstanceType: '2', MaxPlayers: '40', AreaTableID: '2159', CorpseMapID: '-1', Corpse_0: '0', Corpse_1: '0' }],
	AreaTable: [{ ID: '2159', AreaName_lang: "Onyxia's Lair", ContinentID: '249', ParentAreaID: '0' }],
	DungeonEncounter: [{ ID: '1', Name_lang: 'Onyxia', MapID: '249', DifficultyID: '0', OrderIndex: '0' }],
	LFGDungeons: [],
	ContentTuning: [],
	MapDifficulty: [],
};

test("buildInstances: a boss's own Forever drop table (any rate) before the world-drop pool (commondrop, 1% or more)", () => {
	const drop = (item, count, common = false) => ({ item, count, outof: 1000, common });
	const { instances } = buildInstances(instanceFacts(TABLES, [{ ID: '249' }]), {
		npcs: { 10184: { id: 10184, name: 'Onyxia', level: 63, rank: 3, spawns: {}, source: ['pfquest'] } },
		items: { 17966: { id: 17966, name: 'Onyxia Hide Backpack', drops: { npc: { 10184: 84 } }, vendors: [] } },
		web: {
			npc: {
				10184: {
					id: 10184,
					name: 'Onyxia',
					spawns: {},
					drops: [drop(17682, 214, true), drop(13007, 75, true), drop(17962, 33), drop(4411, 5), drop(9999, 5, true)],
				},
			},
		},
	});
	assert.deepEqual(
		instances['onyxias-lair'].bosses[0].items,
		[17966, 17962, 4411, 17682, 13007],
		'own table by chance (a 0.5% schematic too), then world books and blues; a pool item under 1% is no boss loot',
	);
});

test('the release journal emits encounter loot before the Lookup cap and skips world drops, quest items and materials', () => {
	const drop = (item, count, common = false) => ({ item, count, outof: 1000, common });
	const add = (id, name, npc, object = {}) => ({ id, name, drops: { npc, object } });
	const facts = instanceFacts({ ...TABLES, DungeonEncounter: [
		{ ...TABLES.DungeonEncounter[0], Name_lang: 'Onyxia and Guardian' },
		{ ...TABLES.DungeonEncounter[0], ID: '2', Name_lang: 'The Secrets', OrderIndex: '1' },
	] }, [{ ID: '249' }]);
	const { instances } = buildInstances(facts, {
		npcs: { 10184: { name: 'Onyxia' }, 10185: { name: 'Guardian' } },
		objects: { 80: { name: 'Chest of The Secrets', instances: [249] }, 81: { name: 'Chest of The Secrets', instances: [249] } },
		items: {
			700: add(700, 'Helm from both', { 10184: 8, 10185: 2 }),
			701: add(701, 'Weapon', { 10185: 0.2 }),
			702: add(702, 'World gear', { 10184: 2 }),
			703: add(703, 'Shared gear', { 10184: 12, 42: 0.01 }),
			704: { ...add(704, 'Recipe: Quest item', { 10184: 90 }), questItem: true },
			705: add(705, 'Trade material', { 10184: 80 }),
			706: add(706, 'Schematic: Example', { 10184: null }),
			707: add(707, 'Chest ring', {}, { 80: 10, 81: 20 }),
			708: add(708, 'Chest cloak', {}, { 81: 2 }),
			709: add(709, 'Common chest drop', {}, { 80: 50 }),
			711: add(711, 'Signature white hammer', { 10184: 20 }),
		},
		client: { ...clientFacts({ Item: [{ ID: '710', ClassID: '4', InventoryType: '9' }] }), items: {
			700: { classId: 4, quality: 3 }, 701: { classId: 2, quality: 2 }, 702: { classId: 2, quality: 3 }, 703: { classId: 2, quality: 3 },
			705: { classId: 7, quality: 3 }, 707: { classId: 4, quality: 3 }, 708: { classId: 4, quality: 3 }, 709: { classId: 4, quality: 3 },
			711: { classId: 2, quality: 1, inventoryType: 17 },
		} },
		web: {
			npc: { 10184: { drops: [drop(702, 20, true), ...Array.from({ length: 30 }, (_, i) => drop(800 + i, 100))] }, 10185: { drops: [drop(710, 15)] } },
			object: { 80: { drops: [drop(709, 500, true), drop(710, 15)] } },
		},
	});
	const raw = instances['onyxias-lair'].bosses;
	assert.equal(raw[0].items.length, 30);
	assert.ok(!raw[0].items.includes(700));
	assert.deepEqual(raw[1].items, [709, 707, 710]);
	const journal = buildJournal({}, { instances });
	assert.deepEqual(journal.dungeons['onyxias-lair'].bosses.map((b) => [b.name, b.loot]), [
		['Onyxia and Guardian', [711, 700, 710, 701, 706]], ['The Secrets', [707, 708, 710]],
	]);
	assert.match(emitJournal(journal)[0].text, /loot\s*=\s*\{\s*711,\s*700,\s*710,\s*701,\s*706/);
});

test('a curated dungeon boss keeps its generated loot', () => {
	const { inputs, codex } = structuredClone(dungeonsFixture);
	codex.instances['wailing-caverns'].bosses[0].loot = [6480, 918];
	const page = buildJournal(inputs, codex).dungeons['wailing-caverns'];
	assert.deepEqual(page.bosses[0].loot, [6480, 918]);
	assert.equal(page.bosses[0].name, 'Lady Anacondra');
});

// A rare with 160 shared drops and one of its own at an unknown rate; an item
// twelve NPCs drop.
function inputs() {
	const npcs = { 61: { id: 61, name: 'Thuros Lightfingers', level: 11, rank: 4, spawns: { 1429: { f: 'e', pts: [[89.4, 79.3]] } }, source: ['pfquest'] } };
	const items = { 1933: { id: 1933, name: 'Staff of Conjuring', drops: { npc: { 61: null }, object: {} }, vendors: [] } };
	for (let i = 0; i < 160; i++) items[3000 + i] = { id: 3000 + i, name: `Shared ${i}`, drops: { npc: { 61: 50 - i * 0.25, 62: 1 }, object: {} }, vendors: [] };
	const sheep = {};
	for (let n = 0; n < 12; n++) {
		npcs[500 + n] = { id: 500 + n, name: `Mob ${n}`, level: 10, spawns: { 1429: { f: 'e', pts: [[10 + n, 10]] } }, source: ['pfquest'] };
		sheep[500 + n] = 20 - n;
	}
	npcs[62] = { id: 62, name: 'Gnoll', level: 10, spawns: { 1429: { f: 'e', pts: [[30, 30]] } }, source: ['pfquest'] };
	items[2589] = { id: 2589, name: 'Linen Cloth', drops: { npc: sheep, object: {} }, vendors: [] };
	return {
		forever: { zones: { 1429: { id: 1429, name: 'Elwynn Forest' } }, factions: {}, mapFrames: { era: {}, forever: {} }, meta: {}, npcs, objects: {}, items, quests: {}, instances: {}, dungeons: null },
		atlasloot: null,
		rarescanner: null,
		client: null,
		curated: [],
		entrances: [],
	};
}

test('release merge: a rare lists its own drops first, then by chance, up to LOOT_CAP; evidence.cut records what each cap left out', () => {
	const codex = mergeCodex(inputs());
	const loot = codex.npcs[61].loot;
	assert.equal(loot[0], 1933, 'its own drop (nothing else drops it) leads, its rate unknown');
	assert.equal(loot.length, 150);
	assert.deepEqual(loot.slice(1, 3), [3000, 3001], 'then best chance first');
	assert.deepEqual(codex.evidence.cut.rare[61], [3149, 3150, 3151, 3152, 3153, 3154, 3155, 3156, 3157, 3158, 3159]);
	assert.equal(codex.items[2589].sources.filter((s) => s.type === 'drop').length, 10);
	assert.deepEqual(codex.evidence.cut.drop[2589], [510, 511], "an item's droppers past the cap, least likely last");
});

test('compareCodex: a confirmed drop or loot row the cap cut carries the reason and counts in internalOnly.cut', () => {
	const ours = mergeCodex(inputs());
	const theirs = {
		items: { 2589: { id: 2589, name: 'Linen Cloth', sources: [{ type: 'drop', npc: 511, chance: 9 }] }, 3159: { id: 3159, name: 'Shared 159', sources: [] } },
		npcs: { 61: { id: 61, name: 'Thuros Lightfingers', rare: true, loot: [3159] }, 511: { id: 511, name: 'Mob 11' } },
		objects: {},
		instances: {},
	};
	const drops = [{ item: 2589, count: 9, outof: 100 }, { item: 3159, count: 1, outof: 100 }];
	const verify = { web: { npc: { 511: { drops: [drops[0]] }, 61: { drops: [drops[1]] } }, object: {}, item: {} }, clientInstances: new Set() };
	const r = compareCodex(ours, theirs, verify);
	assert.deepEqual(r.kinds['drop chances'].internalOnly, { confirmed: 1, notInForever: 0, unverified: 0, cut: 1 });
	assert.match(r.kinds['drop chances'].missing[0].reason, /^cut by a cap/);
	assert.deepEqual(r.kinds['rare loot'].internalOnly, { confirmed: 1, notInForever: 0, unverified: 0, cut: 1 });
	const plain = compareCodex({ ...ours, evidence: undefined }, theirs, verify);
	assert.equal(plain.kinds['rare loot'].missing[0].reason, undefined, 'without the build evidence (codex parity from disk) no reason');
});
