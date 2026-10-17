'use strict';
// The Codex's bosses beyond the client's encounters (tools/lib/codex/instances.js):
// NPCs and chests tied to their instance by Wowhead's `location` (an area on
// the instance's map) or npcs.json / objects.json `instances`, with their
// role (rare, event, optional); an encounter naming no NPC taking its chest;
// the boss shape { name, npc, items, object?, role? } through the pack
// (tools/lib/codex/pack.js -> Lookup/Codex.lua, old and new refs), the
// Dungeons journal (tools/lib/codex/journal.js), the Bosses tab, and parity's
// reason for a boss Forever's sources do not make one.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { instanceFacts, buildInstances } = require('../tools/lib/codex/instances');
const { buildJournal, emitJournal } = require('../tools/lib/codex/journal');
const { runAddon } = require('./helpers/lua');
const { writeCodexPack, sampleCodex } = require('./helpers/codex');
const { fakeLocale } = require('./helpers/locale');

const TABLES = {
	Map: [{ ID: '230', MapName_lang: 'Blackrock Depths', InstanceType: '1', MaxPlayers: '5', AreaTableID: '1584', CorpseMapID: '-1', Corpse_0: '0', Corpse_1: '0' }],
	AreaTable: [
		{ ID: '1584', AreaName_lang: 'Blackrock Depths', ContinentID: '230', ParentAreaID: '0' },
		{ ID: '25', AreaName_lang: 'Blackrock Mountain', ContinentID: '0', ParentAreaID: '46' },
	],
	DungeonEncounter: [
		{ ID: '1', Name_lang: 'Lord Roccor', MapID: '230', DifficultyID: '1', OrderIndex: '0' },
		{ ID: '2', Name_lang: 'The Seven', MapID: '230', DifficultyID: '1', OrderIndex: '1' },
		{ ID: '3', Name_lang: 'Magmus', MapID: '230', DifficultyID: '1', OrderIndex: '2' },
	],
};

function ctx() {
	const quality = { 11920: 3, 11945: 3, 11946: 3, 1000: 1, 1001: 2, 2776: 2, 1529: 2, 7146: 2 };
	return {
		npcs: {
			9025: { id: 9025, name: 'Lord Roccor', level: 51, rank: 1, spawns: {}, instances: [230] },
			9476: { id: 9476, name: 'Watchman Doomgrip', level: 55, rank: 1, spawns: {}, instances: [230] },
			// No static spawn in QuestieDB or pfQuest: Wowhead alone places it (an event).
			9027: { id: 9027, name: 'Gorosh the Dervish', level: 56, rank: 1, spawns: {} },
			8923: { id: 8923, name: 'Panzor the Invincible', level: 57, rank: 4, spawns: {}, instances: [230] },
			8900: { id: 8900, name: 'Doomforge Arcanasmith', level: 52, rank: 1, spawns: {}, instances: [230] },
			9028: { id: 9028, name: 'Grizzle', level: 56, rank: 1, spawns: {} },
			// A shorter encounter name: of two spawnless NPCs it starts, the one placed inside.
			9938: { id: 9938, name: 'Magmus the Molten', level: 55, rank: 1, spawns: {}, instances: [230] },
			9939: { id: 9939, name: 'Magmus the Molten (Spell Visual)', level: 55, rank: 1, spawns: {} },
		},
		objects: {
			169243: { id: 169243, name: 'Chest of The Seven' },
			160845: { id: 160845, name: 'Dark Coffer', instances: [230] },
			174565: { id: 174565, name: 'Dark Coffer' },
			9000: { id: 9000, name: 'Ordinary Crate', instances: [230] },
			// Neither a gathering node nor a one-item quest object is a boss.
			1734: { id: 1734, name: 'Gold Vein', roles: ['mine'], instances: [230] },
			103821: { id: 103821, name: "Doan's Strongbox", instances: [230] },
		},
		items: {
			11920: { id: 11920, drops: { npc: {}, object: { 169243: null } } },
			11945: { id: 11945, drops: { npc: {}, object: { 160845: 20 } } },
			// Two ids of one chest: still its own loot.
			11946: { id: 11946, drops: { npc: {}, object: { 160845: 10, 174565: 10 } } },
			1000: { id: 1000, drops: { npc: {}, object: { 9000: 50 } } },
			1001: { id: 1001, drops: { npc: { 9027: 12 }, object: {} } },
			2776: { id: 2776, drops: { npc: {}, object: { 1734: 100 } } },
			1529: { id: 1529, drops: { npc: {}, object: { 1734: 50 } } },
			7146: { id: 7146, drops: { npc: {}, object: { 103821: 100 } } },
		},
		quality: (id) => quality[id] ?? null,
		wowhead: {
			npc: {
				9476: { id: 9476, name: 'Watchman Doomgrip', boss: true, location: [1584], spawns: {}, drops: [] },
				9027: { id: 9027, name: 'Gorosh the Dervish', classification: 'elite', boss: true, location: [1584], spawns: {}, drops: [] },
				8901: { id: 8901, name: 'Anvilrage Reservist', classification: 'elite', boss: false, location: [1584], spawns: {}, drops: [] },
				// Placed somewhere that is no instance of ours.
				9028: { id: 9028, name: 'Grizzle', boss: true, location: [25], spawns: {}, drops: [] },
				// Known to Wowhead only.
				16059: { id: 16059, name: 'Theldren', level: [60, 60], classification: 'elite', boss: true, location: [1584], spawns: {}, drops: [] },
			},
			object: { 169243: { id: 169243, name: 'Chest of The Seven', location: [1584], spawns: {}, drops: [] } },
		},
	};
}

test('buildInstances: Wowhead location ties NPCs and chests to the instance; bosses after the encounters carry their role; an NPC-less encounter takes its chest', () => {
	const facts = instanceFacts(TABLES, [{ ID: '230' }]);
	const { instances, bossInstance, npcInstance } = buildInstances(facts, ctx());
	const brd = instances['blackrock-depths'];
	assert.deepEqual(brd.bosses, [
		{ name: 'Lord Roccor', npc: 9025, items: [], encounter: 1 },
		{ name: 'The Seven', npc: null, items: [11920], object: 169243, encounter: 2 },
		{ name: 'Magmus', npc: 9938, items: [], encounter: 3 },
		{ name: 'Watchman Doomgrip', npc: 9476, items: [], role: 'optional' },
		{ name: 'Gorosh the Dervish', npc: 9027, items: [1001], role: 'event' },
		{ name: 'Panzor the Invincible', npc: 8923, items: [], role: 'rare' },
		{ name: 'Theldren', npc: 16059, items: [], role: 'event' },
		{ name: 'Dark Coffer', npc: null, items: [11945, 11946], object: 160845, role: 'optional' },
	]);
	assert.equal(brd.levels[2], 60, "the highest boss level, Wowhead's for an NPC only it knows");
	assert.equal(bossInstance[9027], 'blackrock-depths');
	assert.equal(bossInstance[16059], 'blackrock-depths');
	assert.equal(bossInstance[9028], undefined, 'Wowhead places Grizzle elsewhere');
	assert.equal(npcInstance[8901], 'blackrock-depths', 'an NPC Wowhead places inside belongs to the instance');
	assert.equal(bossInstance[8901], undefined, 'neither ranked, flagged nor with loot of its own: no boss');
	assert.equal(npcInstance[8900], 'blackrock-depths');
});

const LUA_FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Core/Data.lua', 'Core/Names.lua', 'Core/GuideTexts.lua', 'Core/Guides.lua', 'Lookup/Codex.lua'] };

test('the pack carries chest bosses and roles; an encounter boss keeps the old bare npc ref', () => {
	const codex = sampleCodex();
	const strat = codex.instances.stratholme;
	strat.bosses = [
		{ name: 'Baron Rivendare', npc: 10440, items: [13335] },
		{ name: 'Stratholme Courier', npc: 11082, items: [], role: 'event' },
		{ name: 'Skul', npc: 10393, items: [], role: 'rare' },
		{ name: 'Postbox', npc: null, items: [13335], object: 176346, role: 'optional' },
	];
	const pack = writeCodexPack(codex);
	try {
		const text = fs.readFileSync(pack.files.find((f) => /Instances/.test(path.basename(f))), 'utf8');
		assert.match(text, /Baron Rivendare,10440,13335;/, 'an encounter boss: the old shape, bare npc id');
		assert.match(text, /Postbox,o176346x,13335/);
		const [got] = runAddon({
			before: pack.stubLua,
			addons: [LUA_FILES],
			script: `Polestar.Codex.Load()
local out = {}
for i, b in ipairs(Polestar.Codex.Instance("stratholme").bosses) do out[i] = { b.name, b.npc or false, b.object or false, b.role or false, #b.items } end
emit(out)`,
		}).emitted;
		assert.deepEqual(got, [
			['Baron Rivendare', 10440, false, false, 1],
			['Stratholme Courier', 11082, false, 'event', 0],
			['Skul', 10393, false, 'rare', 0],
			['Postbox', false, 176346, 'optional', 1],
		]);
	} finally {
		pack.cleanup();
	}
});

// The Dungeons fixture's Wailing Caverns, built the release way (no
// dungeons.json): its bosses from the Codex instance.
function releaseFixture() {
	const fixture = JSON.parse(fs.readFileSync(path.join(__dirname, 'fixtures', 'codex', 'dungeons.json'), 'utf8'));
	delete fixture.inputs.forever.dungeons;
	fixture.codex.instances['wailing-caverns'].bosses = [
		{ name: 'Lady Anacondra', npc: 3671, items: [9739] },
		{ name: 'Serpent Cache', npc: null, items: [9738], object: 900300, role: 'optional' },
		{ name: 'Kresh', npc: 3653, items: [], role: 'rare' },
	];
	return fixture;
}

test('buildJournal: a chest boss and the roles reach the page; the chest ties the quest whose item it holds', () => {
	const { inputs, codex } = releaseFixture();
	const page = buildJournal(inputs, codex).dungeons['wailing-caverns'];
	assert.deepEqual(
		page.bosses.map((b) => [b.name, b.npc, b.object, b.role]),
		[
			['Lady Anacondra', 3671, undefined, undefined],
			['Serpent Cache', null, 900300, 'optional'],
			['Kresh', 3653, undefined, 'rare'],
		],
	);
	assert.deepEqual(page.bosses[1].quests, [{ id: 914, how: 'item', item: 9738, itemName: 'Gem of Cobrahn' }]);
});

// The Wailing Caverns' Bosses tab, each shown row's name and facts.
function bossRows(before = '') {
	const { inputs, codex } = releaseFixture();
	const pack = writeCodexPack(codex, { extraFiles: emitJournal(buildJournal(inputs, codex)) });
	try {
		return runAddon({
			stubs: ['stub_ui.lua'],
			before: `${pack.stubLua}\n${before}`,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Gear/Gear.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml'] }],
			script: `uistub.install()
stub.login()
local DS = Polestar.UI.DungeonsSection
Polestar.Dungeons.Open("wailing-caverns")
DS.SetTab("bosses")
local out = {}
for _, r in ipairs(DS.bossRows) do if r:IsShown() then out[#out + 1] = { r.Name:GetText(), r.Level:GetText() } end end
emit(out)`,
		}).emitted[0];
	} finally {
		pack.cleanup();
	}
}

test('Bosses tab: a chest says Chest, the bosses after the encounters their role; an encounter shows its level alone', () => {
	assert.deepEqual(bossRows(), [
		['Lady Anacondra', 'Level 20'],
		['Serpent Cache', 'Chest  \u00b7  Optional'],
		['Kresh', 'Level 20  \u00b7  Rare'],
	]);
});

test('Bosses tab: a chest boss is translated under its own key, apart from the Chest gear slot', () => {
	const rows = bossRows(`${fakeLocale('itIT', { 'boss: Chest': 'Truhe', Optional: 'Optional', 'Level %d': 'Stufe %d' })}\nCHESTSLOT = "Brust"`);
	assert.deepEqual(rows[1], ['Serpent Cache', 'Truhe  \u00b7  Optional']);
	assert.deepEqual(rows[0], ['Lady Anacondra', 'Stufe 20']);
});

test('compareCodex: a chest boss matches by its object name; a confirmed missing boss Forever places outside or ranks ordinary says so', () => {
	const { compareCodex } = require('../tools/lib/codex/parity');
	const ours = {
		instances: { 'blackrock-depths': { name: 'Blackrock Depths', bosses: [{ name: 'The Seven', npc: null, object: 169243, items: [] }] } },
		objects: { 169243: { id: 169243, name: 'Chest of The Seven' } },
		npcs: {},
		items: {},
	};
	const theirs = {
		instances: {
			'blackrock-depths': {
				name: 'Blackrock Depths',
				bosses: [
					{ name: 'Chest of The Seven', npc: 9034, items: [] },
					{ name: 'Techbot', npc: 6231, items: [] },
					{ name: 'Fel Steed', npc: 3864, items: [] },
					{ name: 'Gyth', npc: 10339, items: [] },
				],
			},
		},
		objects: {},
		npcs: {},
		items: {},
	};
	const npc = {
		6231: { classification: 'elite', boss: false, location: [], spawns: { 1415: [[43.1, 52.8]] }, drops: [] },
		3864: { classification: 'elite', boss: false, location: [1584], spawns: {}, drops: [{ item: 932, count: 1, outof: 10 }] },
		10339: { classification: 'elite', boss: true, location: [1584], spawns: {}, drops: [] },
	};
	const r = compareCodex(ours, theirs, { wowhead: { npc, object: {}, item: {} }, clientInstances: new Set(), instanceAreas: new Set([1584]) });
	const b = r.kinds.bosses;
	assert.equal(b.match, 1, 'The Seven is the Chest of The Seven');
	assert.deepEqual(b.internalOnly, { confirmed: 3, notInForever: 0, unverified: 0, notBoss: 2 });
	const why = Object.fromEntries(b.missing.map((m) => [m.id, m.reason]));
	assert.equal(why['blackrock-depths/6231'], "Forever's sources place it outside the instance (map 1415)");
	assert.match(why['blackrock-depths/3864'], /^Wowhead Forever ranks it an ordinary elite NPC/);
	assert.equal(why['blackrock-depths/10339'], undefined, 'Wowhead flags Gyth a boss inside: a real gap');
});
