'use strict';
// The release-safe Codex (`codex build` without --local-extras): dungeons and
// raids from the Forever client's tables (tools/lib/codex/instances.js), the
// retired rule from the client's Mount flags, rares from npc ranks, and a
// pack that says it may ship (meta, LICENSE-DATA.txt, pack's releaseRefusal).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { instanceFacts, buildInstances, curatedEntrances } = require('../tools/lib/codex/instances');
const { mergeCodex, clientFacts, buildCodex } = require('../tools/lib/codex/build');
const { releaseRefusal } = require('../tools/lib/codex/pack');
const { tmpdir } = require('./helpers/tmp');

// Westfall's live frame: world x north / y west -> map percent.
const WESTFALL = { c: 0, left: 2000, right: -1000, top: -9000, bottom: -12000 };

const TABLES = {
	Map: [
		{ ID: '36', MapName_lang: 'Deadmines', InstanceType: '1', MaxPlayers: '10', AreaTableID: '1581', CorpseMapID: '0', Corpse_0: '-10500', Corpse_1: '1100' },
		{ ID: '409', MapName_lang: 'Molten Core', InstanceType: '2', MaxPlayers: '40', AreaTableID: '2717', CorpseMapID: '0', Corpse_0: '0', Corpse_1: '0' },
		{ ID: '2784', MapName_lang: 'Demon Fall Canyon', InstanceType: '1', MaxPlayers: '5', AreaTableID: '0', CorpseMapID: '-1', Corpse_0: '0', Corpse_1: '0' },
		{ ID: '2999', MapName_lang: 'Ruins of Lordaeron', InstanceType: '1', MaxPlayers: '5', AreaTableID: '0', CorpseMapID: '-1', Corpse_0: '0', Corpse_1: '0' },
		{ ID: '13', MapName_lang: 'Test Dungeon', InstanceType: '1', MaxPlayers: '0', AreaTableID: '0', CorpseMapID: '-1', Corpse_0: '0', Corpse_1: '0' },
		{ ID: '0', MapName_lang: 'Eastern Kingdoms', InstanceType: '0' },
	],
	AreaTable: [
		{ ID: '40', AreaName_lang: 'Westfall', ContinentID: '0', ParentAreaID: '0' },
		{ ID: '1581', AreaName_lang: 'The Deadmines', ContinentID: '36', ParentAreaID: '0' },
		{ ID: '20', AreaName_lang: 'Deadmines', ContinentID: '0', ParentAreaID: '40' },
	],
	DungeonEncounter: [
		{ ID: '1', Name_lang: 'Edwin VanCleef', MapID: '36', DifficultyID: '0', OrderIndex: '2000' },
		{ ID: '2', Name_lang: "Rhahk'Zor", MapID: '36', DifficultyID: '0', OrderIndex: '0' },
		{ ID: '3', Name_lang: 'Sneeed', MapID: '36', DifficultyID: '1', OrderIndex: '1000' },
		{ ID: '4', Name_lang: "Rhahk'Zor", MapID: '36', DifficultyID: '201', OrderIndex: '0' },
		{ ID: '5', Name_lang: 'Ragnaros', MapID: '409', DifficultyID: '0', OrderIndex: '0' },
		{ ID: '6', Name_lang: 'Grimroot', MapID: '2784', DifficultyID: '0', OrderIndex: '0' },
		{ ID: '7', Name_lang: 'The Abandoned', MapID: '2999', DifficultyID: '0', OrderIndex: '0' },
		{ ID: '8', Name_lang: 'Witherfang and Bjork', MapID: '2999', DifficultyID: '0', OrderIndex: '1000' },
		{ ID: '9', Name_lang: 'Testwerk', MapID: '13', DifficultyID: '0', OrderIndex: '0' },
	],
	LFGDungeons: [
		{ ID: '5', Name_lang: 'Deadmines', TypeID: '0', ContentTuningID: '5240' },
		{ ID: '3272', Name_lang: 'Ruins of Lordaeron', TypeID: '0', ContentTuningID: '5256' },
		{ ID: '59', Name_lang: 'Westfall', TypeID: '4', ContentTuningID: '5146' },
	],
	ContentTuning: [
		{ ID: '5240', MinLevelSquish: '16' },
		{ ID: '5256', MinLevelSquish: '15' },
		{ ID: '5146', MinLevelSquish: '1' },
	],
	MapDifficulty: [
		{ ID: '1', MapID: '36', DifficultyID: '1', ContentTuningID: '5240', Message_lang: 'You must be at least level 10 to enter.' },
		{ ID: '2', MapID: '409', DifficultyID: '9', ContentTuningID: '0', Message_lang: 'You must be at least level 50 to enter.' },
	],
};
const ERA_MAPS = [{ ID: '0' }, { ID: '13' }, { ID: '36' }, { ID: '409' }, { ID: '2784' }];

function npcsJson() {
	return {
		639: { id: 639, name: 'Edwin VanCleef', level: 21, rank: 2, spawns: {}, source: ['pfquest', 'questie-forever'] },
		644: { id: 644, name: "Rhahk'Zor", level: 19, rank: 1, spawns: {}, source: ['pfquest'] },
		643: { id: 643, name: 'Sneed', level: 20, rank: 1, spawns: {}, source: ['pfquest'] },
		// Same name in the open world: the spawnless elite wins.
		9999: { id: 9999, name: "Rhahk'Zor", level: 5, spawns: { 1436: { f: 'e', pts: [[1, 1]] } }, source: ['pfquest'] },
		11502: { id: 11502, name: 'Ragnaros', level: 63, rank: 3, spawns: {}, source: ['pfquest'] },
		256001: { id: 256001, name: 'The Abandoned', spawns: {}, source: ['questie-forever'] },
		256002: { id: 256002, name: 'Witherfang', spawns: {}, source: ['questie-forever'] },
		256003: { id: 256003, name: 'Bjork', spawns: {}, source: ['questie-forever'] },
		// A Defias placed in the Deadmines (npcs.json `instances`, from QuestieDB / recordings).
		657: { id: 657, name: 'Defias Pirate', level: 18, spawns: {}, instances: [36], source: ['pfquest'] },
	};
}

function itemsJson() {
	return {
		5191: { id: 5191, name: 'Cruel Barb', drops: { npc: { 639: 17.5 }, object: {} }, vendors: [] },
		5193: { id: 5193, name: 'Cape of the Brotherhood', drops: { npc: { 639: 20.1 }, object: {} }, vendors: [] },
		4444: { id: 4444, name: 'World Green', drops: { npc: { 639: 0.02 }, object: {} }, vendors: [] },
		872: { id: 872, name: 'Rockslicer', drops: { npc: { 644: 9 }, object: {} }, vendors: [] },
	};
}

test('instanceFacts + buildInstances: dungeons and raids from the client tables, bosses matched to npcs.json, loot from drops', () => {
	const facts = instanceFacts(TABLES, ERA_MAPS);
	const { instances, bossInstance, npcInstance } = buildInstances(facts, {
		npcs: npcsJson(),
		items: itemsJson(),
		zones: { 1436: { id: 1436, name: 'Westfall', areaId: 40 } },
		frames: { 1436: WESTFALL },
	});
	assert.deepEqual(Object.keys(instances).sort(), ['deadmines', 'molten-core', 'ruins-of-lordaeron'], 'test maps and Season of Discovery maps (Demon Fall Canyon) stay out');
	const dm = instances.deadmines;
	assert.equal(dm.kind, 'dungeon');
	assert.equal(dm.forever, false);
	assert.equal(dm.map, 36);
	assert.equal(dm.areaId, 1581);
	assert.deepEqual(dm.levels, [10, 16, 21], 'entry from MapDifficulty, min from ContentTuning, max from the bosses');
	assert.deepEqual(dm.entrance, { map: 1436, x: 30, y: 50, f: null, approx: true }, 'the Corpse point on the zone holding it, approximate');
	assert.deepEqual(
		dm.bosses.map((b) => [b.name, b.npc, b.items]),
		[
			["Rhahk'Zor", 644, [872]],
			['Sneeed', 643, []],
			['Edwin VanCleef', 639, [5193, 5191]],
		],
		'difficulty 0/1 in OrderIndex order, one per name; a misspelt name matches within two letters; drops under 1% are world drops',
	);
	assert.deepEqual(instances['molten-core'].levels, [50, 60, 60]);
	assert.equal(instances['molten-core'].kind, 'raid');
	assert.equal(instances['molten-core'].entrance, null, 'no Corpse point, no recording, no guide: no entrance');
	const rl = instances['ruins-of-lordaeron'];
	assert.equal(rl.forever, true, 'absent from the Era client');
	assert.deepEqual(
		rl.bosses.map((b) => [b.name, b.npc]),
		[
			['The Abandoned', 256001],
			['Witherfang and Bjork', 256002],
		],
	);
	assert.equal(bossInstance[256003], 'ruins-of-lordaeron', "both NPCs of an 'A and B' encounter are bosses");
	assert.equal(npcInstance[657], 'deadmines', 'an NPC placed inside belongs to the instance');
	assert.equal(bossInstance[657], undefined);
});

test('buildInstances: a recorded encounter and entrance win; a guide goto names an entrance the client lacks', () => {
	const facts = instanceFacts(TABLES, ERA_MAPS);
	const { instances } = buildInstances(facts, {
		npcs: npcsJson(),
		items: itemsJson(),
		zones: { 1420: { id: 1420, name: 'Tirisfal Glades', areaId: 85 }, 1436: { id: 1436, name: 'Westfall', areaId: 40 } },
		frames: { 1436: WESTFALL },
		recorded: { 409: { entrances: [{ map: 1428, x: 33.01, y: 85.04, n: 3 }, { map: 1428, x: 1, y: 1, n: 1 }], encounters: { 5: { name: 'Ragnaros', npcs: [11502] } } } },
		curated: [
			{ label: 'Skycutter to Dalaran', map: null, zone: 'Tirisfal Glades', x: 1, y: 1 },
			{ label: 'The Ruins of Lordaeron, under the city', map: null, zone: 'Tirisfal Glades', x: 52.5, y: 66.1 },
		],
	});
	assert.deepEqual(instances['molten-core'].entrance, { map: 1428, x: 33, y: 85, f: null }, 'the most-seen recorded entrance');
	assert.deepEqual(instances['ruins-of-lordaeron'].entrance, { map: 1420, x: 52.5, y: 66.1, f: null });
});

test("curatedEntrances reads every goto with a label from the guides, with its zone", () => {
	const dir = tmpdir('polestar-entrances-');
	fs.writeFileSync(
		path.join(dir, 'a.guide'),
		'guide test/a\ntitle A\nzone Eastern Plaguelands\n\nstep Go\n  goto 47.9,23.8 "Stratholme Service Entrance"\n  goto 10,10\n',
	);
	assert.deepEqual(curatedEntrances(dir), [{ label: 'Stratholme Service Entrance', map: null, zone: 'Eastern Plaguelands', x: 47.9, y: 23.8 }]);
});

// A release build's inputs: data/forever, FLBiS and the client; no AtlasLoot,
// RareScanner or dungeons.json.
function releaseInputs() {
	const npcs = {
		...npcsJson(),
		4730: { id: 4730, name: 'Lelanai', level: 35, faction: 'A', roles: ['vendor'], spawns: { 1438: { f: 'e', pts: [[25.2, 50.1]] } }, source: ['questie-forever'] },
		61: { id: 61, name: 'Thuros Lightfingers', level: 11, rank: 4, spawns: { 1429: { f: 'e', pts: [[89.4, 79.3]] } }, source: ['pfquest'] },
		462: { id: 462, name: 'Vultros', level: 26, rank: 2, spawns: { 1436: { f: 'e', pts: [[60, 30]] } }, source: ['pfquest'] },
		100: { id: 100, name: 'Gruff Swiftbite', level: 12, rank: 1, spawns: { 1429: { f: 'e', pts: [[25, 70]] } }, source: ['pfquest'] },
	};
	const vendorItem = (id, name, source) => ({ id, name, drops: { npc: {}, object: {} }, vendors: [4730], source });
	const items = {
		...itemsJson(),
		2933: { id: 2933, name: 'Seal of Wrynn', drops: { npc: { 61: 35 }, object: {} }, vendors: [] },
		1179: { id: 1179, name: 'Ice Cold Milk', drops: { npc: {}, object: { 2843: 25 } }, vendors: [] },
		5200: { id: 5200, name: 'Pirate Hat', drops: { npc: { 657: 4.5 }, object: {} }, vendors: [] },
		12302: vendorItem(12302, 'Reins of the Frostsaber', ['pfquest', 'questie-forever']),
		2411: vendorItem(2411, 'Black Stallion Bridle', ['pfquest', 'questie-forever']),
		8631: vendorItem(8631, 'Reins of the Striped Frostsaber', ['pfquest', 'questie-forever']),
		269681: vendorItem(269681, 'Empyrean Galestrider', ['questie-forever']),
	};
	const mountItem = (id, name, spell) => [
		{ ID: String(id), ClassID: '15', SubclassID: '5', InventoryType: '0' },
		{ ID: String(id), Display_lang: name, OverallQualityID: '3', RequiredLevel: '40' },
		{ ID: String(id), TriggerType: '6', SpellID: String(spell), ParentItemID: String(id) },
	];
	const rows = [mountItem(12302, 'Reins of the Frostsaber', 16056), mountItem(2411, 'Black Stallion Bridle', 470), mountItem(8631, 'Reins of the Striped Frostsaber', 8394), mountItem(269681, 'Empyrean Galestrider', 1286024)];
	const client = clientFacts({
		Item: rows.map((r) => r[0]),
		ItemSparse: rows.map((r) => r[1]),
		ItemEffect: rows.map((r) => r[2]),
		Mount: [
			{ ID: '46', Name_lang: 'Frostsaber', Flags: '64', SourceSpellID: '16056' },
			{ ID: '9', Name_lang: 'Black Stallion', Flags: '0', SourceSpellID: '470' },
			{ ID: '26', Name_lang: 'Striped Frostsaber', Flags: '64', SourceSpellID: '8394' },
			{ ID: '2955', Name_lang: 'Empyrean Galestrider', Flags: '64', SourceSpellID: '1286024' },
		],
		BattlePetSpecies: [],
	});
	client.instances = instanceFacts(TABLES, ERA_MAPS);
	return {
		forever: {
			zones: { 1429: { id: 1429, name: 'Elwynn Forest' }, 1436: { id: 1436, name: 'Westfall', areaId: 40 }, 1438: { id: 1438, name: 'Teldrassil' } },
			factions: {},
			mapFrames: { era: {}, forever: { 1436: WESTFALL } },
			meta: { sources: [{ name: 'pfQuest', revision: 'abc', license: 'MIT' }] },
			npcs,
			objects: { 2843: { id: 2843, name: 'Battered Chest', roles: ['chest'], spawns: { 1429: { f: 'e', pts: [[63.5, 56.1]] } } } },
			items,
			quests: {},
			instances: {},
			dungeons: null,
		},
		atlasloot: null,
		rarescanner: null,
		flbis: null,
		client,
		curated: [8631],
		entrances: [],
	};
}

test('release merge: retired = Era vendor stock whose Mount row the Forever client hides until known; a curated guide or Forever-only row keeps it', () => {
	const it = mergeCodex(releaseInputs()).items;
	assert.equal(it[12302].kind, 'mount');
	assert.equal(it[12302].status, 'retired', 'Mount.Flags 0x40 and only Era vendor rows');
	assert.equal(it[2411].status, null, 'Black Stallion: still sold, its Mount row is not hidden');
	assert.equal(it[8631].status, null, 'a curated guide collects it');
	assert.equal(it[269681].status, null, 'Forever-only vendor rows are trusted');
});

test('release merge: rares from npc ranks (4 rare, 2 rare elite) with spawns and drops; instance NPCs are not rares; treasures from chest objects', () => {
	const codex = mergeCodex(releaseInputs());
	const n = codex.npcs;
	assert.equal(n[61].rare, true);
	assert.deepEqual(n[61].loot, [2933]);
	assert.deepEqual(n[61].spawns, [{ map: 1429, x: 89.4, y: 79.3, f: 'e' }]);
	assert.equal(n[462].rare, true, 'rank 2: rare elite');
	assert.equal(n[462].elite, true);
	assert.equal(n[100].rare, false, 'rank 1: elite only');
	assert.equal(n[639].rare, false, 'Edwin VanCleef is ranked rare elite, but he is a Deadmines boss');
	assert.equal(n[639].boss, true);
	assert.equal(n[657].instance, 'deadmines', 'a mob placed inside');
	assert.deepEqual(codex.items[5200].sources, [{ type: 'drop', npc: 657, chance: 4.5, instance: 'deadmines', from: ['forever'] }], "the mob's drop names its instance");
	assert.equal(codex.objects[2843].treasure, true);
	assert.deepEqual(codex.objects[2843].loot, [1179]);
	const drop = codex.items[5191].sources.find((s) => s.type === 'drop');
	assert.deepEqual(drop, { type: 'drop', npc: 639, chance: 17.5, instance: 'deadmines', from: ['forever'] });
	assert.deepEqual(codex.instances.deadmines.bosses.at(-1), { name: 'Edwin VanCleef', npc: 639, items: [5193, 5191], encounter: 1 });
});

test('buildCodex: a release build says so in its meta and ships its notices; a --local-extras build is refused by pack', async () => {
	const tmp = tmpdir('polestar-codex-release-');
	const safe = await buildCodex({ inputs: releaseInputs(), outDir: path.join(tmp, 'out'), packDir: path.join(tmp, 'safe', 'Polestar_Codex'), version: '1.0.0', measure: false });
	assert.equal(safe.codex.meta.localExtras, false);
	assert.ok(!safe.codex.meta.sources.some((s) => /AtlasLoot|RareScanner|DungeonJournal/.test(s.name)));
	const notice = fs.readFileSync(path.join(safe.packDir, 'LICENSE-DATA.txt'), 'utf8');
	assert.match(notice, /^Polestar Codex: third-party notices/);
	assert.match(notice, /^pfQuest\n-------\nVersion: abc\nLicence: MIT$/m);
	assert.doesNotMatch(notice, /LOCAL BUILD/);
	assert.equal(releaseRefusal(safe.packDir), null);

	const local = { ...releaseInputs(), localExtras: true, atlasloot: { meta: { version: 'Forever 1.60.1', licence: 'GPL-2.0' }, instances: [], collections: [], crafting: [], factions: [], pvp: [] } };
	const x = await buildCodex({ inputs: local, outDir: path.join(tmp, 'outx'), packDir: path.join(tmp, 'local', 'Polestar_Codex'), version: '1.0.0', measure: false });
	assert.equal(x.codex.meta.localExtras, true);
	assert.match(fs.readFileSync(path.join(x.packDir, 'LICENSE-DATA.txt'), 'utf8'), /LOCAL BUILD \(--local-extras\)/);
	assert.match(releaseRefusal(x.packDir), /--local-extras build/);
	assert.match(releaseRefusal(path.join(tmp, 'nowhere')), /not built/);
});

test('compareCodex: per-kind match against the internal build, missing and different rows, reasons, and what needs recording', () => {
	const { compareCodex, summary, markdown } = require('../tools/lib/codex/parity');
	const theirs = {
		instances: {
			stockade: { name: 'The Stockade', areaId: 717, levels: [15, 24, 32], entrance: { map: 1453, x: 52.4, y: 70 }, bosses: [{ name: 'Bazil Thredd', npc: 1716, items: [2926, 3] }, { name: 'Trash', npc: null, items: [9] }] },
			'alcaz-prison': { name: 'Alcaz Prison', forever: true, bosses: [] },
		},
		items: {
			2926: { name: 'Head of Bazil Thredd', kind: 'item', sources: [{ type: 'drop', npc: 1716, chance: 100, from: ['atlasloot'] }] },
			3: { name: 'Thing', kind: 'item', sources: [{ type: 'rep', faction: 1, from: ['atlasloot'] }] },
		},
		npcs: { 61: { name: 'Thuros', rare: true, level: 11, spawns: [{ map: 1429, x: 89, y: 79 }], loot: [2926] }, 62: { name: 'Gone', rare: true } },
		objects: {},
		journal: { dungeons: { stockade: { name: 'The Stockade', quests: [{ id: 386, title: 'What Comes Around', start: { map: 1453, x: 10, y: 10 }, rewards: { items: [{ id: 1 }], xp: 900 } }] } } },
	};
	const ours = {
		instances: { 'stormwind-stockade': { name: 'Stormwind Stockade', areaId: 717, levels: [15, 23, 29], entrance: { map: 1453, x: 50.4, y: 66.2 }, bosses: [{ name: 'Bazil Thredd', npc: 1716, items: [2926] }] } },
		items: { 2926: { name: 'Head of Bazil Thredd', kind: 'item', sources: [{ type: 'drop', npc: 1716, chance: 100, from: ['pfquest'] }] }, 3: { name: 'Thing', kind: 'item', sources: [] } },
		npcs: { 61: { name: 'Thuros', rare: true, level: 11, spawns: [{ map: 1429, x: 89.4, y: 79.3 }], loot: [] } },
		objects: {},
		journal: { dungeons: { 'stormwind-stockade': { quests: [{ id: 386, start: { map: 1453, x: 10.5, y: 10 }, rewards: { items: [{ id: 1 }], xp: 900 } }] } } },
	};
	const r = compareCodex(ours, theirs);
	assert.equal(r.instanceMap.stockade, 'stormwind-stockade');
	const s = Object.fromEntries(Object.entries(summary(r)).map(([k, v]) => [k, { total: v.total, match: v.match, share: v.share }]));
	assert.deepEqual(s.instances, { total: 2, match: 1, share: 0.5 });
	assert.deepEqual(s['instance entrances'], { total: 1, match: 0, share: 0 }, 'a corpse point is no entrance: a different place does not match');
	assert.equal(r.kinds['instance entrances'].different[0].reason, undefined);
	assert.deepEqual(s.bosses, { total: 1, match: 1, share: 1 }, 'Trash is no boss');
	assert.deepEqual(s['boss loot items'], { total: 2, match: 1, share: 0.5 });
	assert.deepEqual(s['drop chances'], { total: 1, match: 1, share: 1 });
	assert.deepEqual(s.rares, { total: 2, match: 1, share: 0.5 });
	assert.deepEqual(s['rare positions'], { total: 1, match: 1, share: 1 });
	assert.deepEqual(s['items: rep'], { total: 1, match: 0, share: 0 });
	assert.deepEqual([s['journal quests'].share, s['quest givers'].share, s['quest rewards'].share, s['quest XP'].share], [1, 1, 1, 1]);
	assert.deepEqual(r.needsRecording.map((n) => [n.kind, n.event]), [['instance', 'enter, encounter'], ['rare', 'rare, slain + drop']]);
	assert.match(markdown(r), /^\| instances \| 2 \| 1 \| 50\.0% \| 0 \| 0 \| 1 \| 0 \| 0 \|$/m);

	// Checked against Wowhead Forever and the client: what Forever lacks is the internal build's error, not a gap.
	const verify = { wowhead: { npc: { 62: { classification: 'normal', drops: [], spawns: {} } }, object: {}, item: { 3: { rep: [], pvpRank: null } } }, clientInstances: new Set() };
	const v = compareCodex(ours, theirs, verify);
	assert.deepEqual(v.kinds.instances.internalOnly, { confirmed: 0, notInForever: 1, unverified: 0 });
	assert.deepEqual(v.kinds.rares.internalOnly, { confirmed: 0, notInForever: 1, unverified: 0 });
	// A tooltip without a standing proves nothing: the gate sits on the vendor or the quest.
	assert.deepEqual(v.kinds['items: rep'].internalOnly, { confirmed: 0, notInForever: 0, unverified: 1 });
	assert.deepEqual(v.kinds['items: rep'].missing.map((x) => x.id), [3]);
	assert.deepEqual(v.needsRecording, [], 'nothing to record for what Forever does not have');
});
