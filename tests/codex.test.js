'use strict';
// Lookup's Codex: the pack emitter (tools/lib/codex/pack.js) round-trips
// through the in-game decoder (Lookup/Codex.lua), the merge
// (tools/lib/codex/build.js) applies precedence and dedupes sources on
// synthetic importer outputs, and Core/Data.lua loads packs on demand.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { writeCodexPack, sampleCodex } = require('./helpers/codex');
const { emitPack, foldName } = require('../tools/lib/codex/pack');

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Core/Data.lua', 'Core/Names.lua', 'Core/GuideTexts.lua', 'Core/Guides.lua', 'Lookup/Codex.lua'] };

function run(script, { before = '', pack } = {}) {
	return runAddon({
		before: `${pack ? pack.stubLua : ''}\n${before}`,
		addons: [FILES],
		script,
	}).emitted;
}

// JSON nulls are absent in Lua and empty lists encode as {} or [].
function norm(v) {
	if (Array.isArray(v)) return v.length ? v.map(norm) : [];
	if (v && typeof v === 'object') {
		const keys = Object.keys(v).filter((k) => v[k] !== null && v[k] !== undefined);
		if (!keys.length) return [];
		const out = {};
		for (const k of keys.sort()) out[k] = norm(v[k]);
		return out;
	}
	return v;
}

test('emitPack round-trips every record through Codex.lua', () => {
	const codex = sampleCodex();
	const pack = writeCodexPack(codex);
	try {
		const [loaded, got] = run(
			`
local ok, reason = Polestar.Codex.Load()
emit({ ok = ok, reason = reason, schema = Polestar.Codex.Meta().schema, frame = Polestar.MapFrames.era[1429] ~= nil })
local C = Polestar.Codex
local out = { items = {}, npcs = {}, objects = {}, quests = {}, instances = {}, zones = {}, factions = {}, spells = {} }
local ids = ${JSON.stringify({
				items: Object.keys(codex.items),
				npcs: Object.keys(codex.npcs),
				objects: Object.keys(codex.objects),
				quests: Object.keys(codex.quests),
				zones: Object.keys(codex.zones),
				factions: Object.keys(codex.factions),
				spells: Object.keys(codex.spells),
			})
				.replace(/\[/g, '{')
				.replace(/\]/g, '}')
				.replace(/"(\w+)":/g, '$1=')}
for _, id in ipairs(ids.items) do out.items[id] = C.Item(id) end
for _, id in ipairs(ids.npcs) do out.npcs[id] = C.Npc(id) end
for _, id in ipairs(ids.objects) do out.objects[id] = C.Object(id) end
for _, id in ipairs(ids.quests) do out.quests[id] = C.Quest(id) end
for _, id in ipairs(ids.zones) do out.zones[id] = C.Zone(id) end
for _, id in ipairs(ids.factions) do out.factions[id] = C.Faction(id) end
for _, id in ipairs(ids.spells) do out.spells[id] = C.Spell(id) end
out.instances.stratholme = C.Instance("stratholme")
emit(out)
`,
			{ pack },
		);
		assert.deepEqual(loaded, { ok: true, schema: 1, frame: true });
		const spells = {};
		for (const [id, s] of Object.entries(codex.spells)) spells[id] = { id: Number(id), ...s };
		const want = {
			items: codex.items,
			npcs: codex.npcs,
			objects: codex.objects,
			quests: codex.quests,
			instances: codex.instances,
			zones: codex.zones,
			factions: codex.factions,
			spells,
		};
		for (const k of Object.keys(want)) assert.deepEqual(norm(got[k]), norm(want[k]), k);
	} finally {
		pack.cleanup();
	}
});

test('Codex.Each walks one kind with names and item quality, and stops on false', () => {
	const pack = writeCodexPack(sampleCodex());
	try {
		const [each, stopped, names, loot] = run(
			`
local C = Polestar.Codex
local out = {}
for _, kind in ipairs({ "item", "mount", "pet", "recipe", "tabard", "npc", "rare", "quest", "zone", "instance", "treasure", "object" }) do
	local list = {}
	C.Each(kind, function(id, name, quality) list[#list + 1] = tostring(id) .. "=" .. name .. (quality and ("/" .. quality) or "") end)
	table.sort(list)
	out[kind] = list
end
emit(out)
local n = 0
C.Each("mount", function() n = n + 1; return false end)
emit(n)
emit({ C.Name("item", 13335), C.Name("npc", 61), C.Name("object", 2843), C.Name("instance", "stratholme"), C.Name("mount", 5976) == nil })
emit({ rare = C.Loot("rare", 61), npc = C.Loot("npc", 61), treasure = C.Loot("treasure", 2843), object = C.Loot("object", 2843),
	plain = #C.Loot("npc", 4730), wrongKind = #C.Loot("rare", 4730), missing = #C.Loot("npc", 1), badKind = #C.Loot("quest", 176) })
`,
			{ pack },
		);
		assert.deepEqual(each.mount, [
			"13086=Reins of the Winterspring Frostsaber/4",
			"13335=Deathcharger's Reins/4",
			'18245=Horn of the Black War Wolf/4',
			'8631=Reins of the Striped Frostsaber/3',
			'8632=Reins of the Spotted Frostsaber/3',
		]);
		assert.deepEqual(each.pet, ['8485=Cat Carrier (Bombay)/1']);
		assert.deepEqual(each.tabard, ['5976=Guild Tabard/1']);
		assert.deepEqual(each.recipe, ['6454=Manual: Strong Anti-Venom/1']);
		assert.equal(each.item.length, 7);
		assert.deepEqual(each.rare, ['61=Thuros Lightfingers']);
		assert.equal(each.npc.length, 9);
		assert.deepEqual(each.treasure, ['2843=Battered Chest']);
		assert.deepEqual(each.object, ['68=Wanted Poster']);
		assert.deepEqual(each.quest, ['176=Wanted: "Hogger"', '33=Wolves Across the Border']);
		assert.deepEqual(each.instance, ['stratholme=Stratholme']);
		assert.equal(each.zone.length, 7);
		assert.equal(stopped, 1);
		assert.deepEqual(names, ["Deathcharger's Reins", 'Thuros Lightfingers', 'Battered Chest', 'Stratholme', true]);
		assert.deepEqual(loot, { rare: [1933, 2933], npc: [1933, 2933], treasure: [1179], object: [1179], plain: 0, wrongKind: 0, missing: 0, badKind: 0 });
	} finally {
		pack.cleanup();
	}
});

test('emitPack is deterministic and splits large groups across files', () => {
	const codex = sampleCodex();
	assert.deepEqual(emitPack(codex, { version: '1' }), emitPack(sampleCodex(), { version: '1' }));
	const big = { meta: {}, items: {} };
	for (let id = 1; id <= 9000; id++) big.items[id] = { id, name: `Item ${id}`, quality: 1, kind: 'item', spell: null, reqLevel: null, sources: [] };
	const files = emitPack(big, { version: '1' });
	const toc = files['Polestar_Codex.toc'];
	assert.match(toc, /^## Interface: 16001$/m);
	assert.match(toc, /^## LoadOnDemand: 1$/m);
	assert.match(toc, /^## Dependencies: Polestar$/m);
	assert.match(toc, /^## Title: Polestar Codex$/m);
	assert.deepEqual(
		toc.split('\n').filter((l) => l.endsWith('.lua')),
		['Meta.lua', 'Items1.lua', 'Items2.lua', 'Items3.lua', 'Index.lua'],
	);
	// Long strings, not table constructors: one Register call per chunk with the id range.
	assert.match(files['Items2.lua'], /^C\.Register\("item", "\\n4001\\t1\\tItem 4001\\n4002\\t/m);
	assert.match(files['Items2.lua'], /, 4001, 8000\)$/m);
	const pack = writeCodexPack(big);
	try {
		const [got] = run(
			`
local C = Polestar.Codex
local out = {}
for _, id in ipairs({ 1, 4000, 4001, 8000, 8001, 9000 }) do
	local r = C.Item(id)
	out[#out + 1] = C.Name("item", id) .. "|" .. r.name .. "|" .. r.quality
end
out[#out + 1] = tostring(C.Item(9001)) .. "|" .. tostring(C.Name("item", 0)) .. "|" .. tostring(C.Name("item", "x"))
local n = 0
C.Each("item", function() n = n + 1 end)
out[#out + 1] = n
emit(out)
`,
			{ pack },
		);
		assert.deepEqual(got, ['Item 1|Item 1|1', 'Item 4000|Item 4000|1', 'Item 4001|Item 4001|1', 'Item 8000|Item 8000|1', 'Item 8001|Item 8001|1', 'Item 9000|Item 9000|1', 'nil|nil|nil', 9000]);
	} finally {
		pack.cleanup();
	}
});

test('Codex.Index serves one search blob per kind and never loads the pack', () => {
	const codex = sampleCodex();
	codex.items[8632].status = 'retired';
	const pack = writeCodexPack(codex);
	try {
		const [before, blobs] = run(
			`
local C = Polestar.Codex
emit({ C.Index("mount") == nil, C.IsLoaded() })
C.Load()
local out = {}
for _, k in ipairs({ "item", "mount", "pet", "recipe", "tabard", "npc", "rare", "quest", "zone", "instance", "treasure", "object", "faction", "spell" }) do
	out[k] = C.Index(k) or false
end
emit(out)
`,
			{ pack },
		);
		assert.deepEqual(before, [true, false]);
		const lines = (k) => blobs[k].split('\n').filter(Boolean);
		assert.deepEqual(lines('mount'), [
			'\x02reins of the striped frostsaber\x018631,3,,31',
			'\x02reins of the spotted frostsaber\x018632,3,r,31',
			'\x02reins of the winterspring frostsaber\x0113086,4,,36',
			'\x02deathchargers reins\x0113335,4,,20',
			'\x02horn of the black war wolf\x0118245,4,,26',
		]);
		assert.deepEqual(lines('quest'), ['\x02wolves across the border\x0133,,,24', '\x02wanted hogger\x01176,,,16']);
		assert.deepEqual(lines('instance'), ['\x02stratholme\x01stratholme,,,10']);
		assert.deepEqual(lines('rare'), ['\x02thuros lightfingers\x0161,,,19']);
		assert.deepEqual(lines('treasure'), ['\x02battered chest\x012843,,,14']);
		assert.equal(lines('zone').length, 7);
		assert.equal(lines('npc').length, 9);
		assert.equal(lines('item').length, 7);
		assert.equal(blobs.object, false, 'objects, factions and spells are not searched');
		assert.equal(blobs.faction, false);
		assert.equal(blobs.spell, false);
	} finally {
		pack.cleanup();
	}
});

test('foldName folds names exactly like Search.Fold (without its leading space)', () => {
	const names = [
		'Reins of the Striped Frostsaber', "Deathcharger's Reins", "Zul'Gurub", 'Ahn\u2019Qiraj', 'Señor Ñandú',
		'Ægis Øre Straße', 'Œuvre Ÿ', 'Хоггер Ёлка ёж', '霍格', 'Ironforge - East', 'A.B.C. 123', 'Test×Thing ÷ 2', '  spaced  out  ', '',
		'[Tag] (Old) 1/2', 'Ünder-Café', 'Tab\tName\nNext', 'ÿþ', 'ALL CAPS!', '"Quoted" & co.', 'Über_Thing~#5',
	];
	const [lua] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Core/Data.lua', 'Core/Names.lua', 'Core/GuideTexts.lua', 'Core/Guides.lua', 'Core/Search.lua'] }],
		script: `
local names = ${'{ ' + names.map((n) => JSON.stringify(n).replace(/\\u([0-9a-f]{4})/gi, (_, h) => String.fromCharCode(parseInt(h, 16)))).join(', ') + ' }'}
local out = {}
for i, n in ipairs(names) do out[i] = (Polestar.Search.Fold(n):gsub("^ ", "")) end
emit(out)
`,
	}).emitted;
	assert.deepEqual(names.map(foldName), lua);
	assert.equal(foldName('Señor Ñandú'), 'senor nandu');
	assert.equal(foldName('Ahn\u2019Qiraj'), 'ahnqiraj');
});

// ---------------------------------------------------------------------------
// Data.Pack / Data.Info
// ---------------------------------------------------------------------------

test('Data.Pack reports a missing pack once and never retries it', () => {
	const [first, second, calls, info] = run(`
local n = 0
local load = C_AddOns.LoadAddOn
C_AddOns.LoadAddOn = function(name) n = n + 1; return load(name) end
emit({ Polestar.Data.Pack("Polestar_Codex") })
emit({ Polestar.Data.Pack("Polestar_Codex") })
emit(n)
emit(Polestar.Data.Info("Polestar_Codex"))
`);
	assert.deepEqual(first, [false, 'missing']);
	assert.deepEqual(second, [false, 'missing']);
	assert.equal(calls, 1);
	assert.deepEqual(info, { loaded: false, reason: 'missing' });
});

test('Data.Pack waits out combat, then loads once and reports memory', () => {
	const pack = writeCodexPack(sampleCodex());
	try {
		const [inCombat, codexInCombat, after, again, calls, info, fired] = run(
			`
local n = 0
local load = C_AddOns.LoadAddOn
C_AddOns.LoadAddOn = function(name) n = n + 1; return load(name) end
function UpdateAddOnMemoryUsage() end
function GetAddOnMemoryUsage(name) return name == "Polestar_Codex" and 1234.5 or 0 end
local fired = 0
Polestar.On("CODEX_LOADED", function(meta) fired = fired + (meta and 1 or 0) end)
stub.inCombat = true
emit({ Polestar.Data.Pack("Polestar_Codex") })
emit({ Polestar.Codex.Load() })
stub.inCombat = false
emit({ Polestar.Data.Pack("Polestar_Codex") })
emit({ Polestar.Codex.Load() })
Polestar.Codex.Load()
emit(n)
emit(Polestar.Data.Info("Polestar_Codex"))
emit(fired)
`,
			{ pack },
		);
		assert.deepEqual(inCombat, [false, 'combat']);
		assert.deepEqual(codexInCombat, [false, 'combat']);
		assert.deepEqual(after, [true]);
		assert.deepEqual(again, [true]);
		assert.equal(calls, 1);
		assert.deepEqual(info, { loaded: true, memoryKB: 1234.5 });
		assert.equal(fired, 1);
	} finally {
		pack.cleanup();
	}
});

test('Data.Pack passes LoadAddOn reasons through in lower case', () => {
	const [disabled, raised] = run(`
C_AddOns.LoadAddOn = function(name)
	if name == "Broken" then error("boom") end
	return false, "DISABLED"
end
emit({ Polestar.Data.Pack("Polestar_Codex") })
emit({ Polestar.Data.Pack("Broken") })
`);
	assert.deepEqual(disabled, [false, 'disabled']);
	assert.deepEqual(raised, [false, 'error']);
});

// A player who copies only some of the release zip's folders, or an old one
// over a new one, is told at login. The stub's default TOC version is
// "0.1.0-test" for every addon, Polestar included.
function loginWith(addons) {
	return runAddon({
		before: `stub.addons = { ${addons.map((a) => `{ name = "${a.name}" }`).join(', ')} }
${addons.filter((a) => a.version).map((a) => `stub.addonMeta["${a.name}"] = { Version = "${a.version}" }`).join('\n')}`,
		addons: [FILES],
		login: true,
		script: `
local missing, stale = Polestar.Data.CheckInstall()
local said = {}
for _, m in ipairs(stub.messages) do if m:find("installed incompletely", 1, true) then said[#said + 1] = m end end
emit({ missing = table.concat(missing, ","), stale = table.concat(stale, ","), said = said })`,
	}).emitted[0];
}

test('a complete install of one version says nothing at login; the optional data packs may be absent', () => {
	const out = loginWith([{ name: 'Polestar' }, { name: 'Polestar_Guides' }, { name: 'Polestar_Codex' }]);
	assert.equal(out.missing, '');
	assert.equal(out.stale, '');
	assert.equal(Object.keys(out.said).length, 0);
});

test('a missing Codex and a Guides folder from an old zip are named once in chat, with how to reinstall', () => {
	const out = loginWith([{ name: 'Polestar' }, { name: 'Polestar_Guides', version: '0.2.1' }, { name: 'Polestar_QuestDB' }]);
	assert.equal(out.missing, 'Polestar_Codex');
	assert.equal(out.stale, 'Polestar_Guides (0.2.1)');
	assert.equal(out.said.length, 1);
	assert.match(out.said[0], /Polestar_Codex not installed; Polestar_Guides \(0\.2\.1\) from another version/);
	assert.match(out.said[0], /delete every Polestar folder.*not "Source code"/);
});

// ---------------------------------------------------------------------------
// Merge (tools/lib/codex/build.js) on synthetic importer outputs
// ---------------------------------------------------------------------------

const fs = require('node:fs');
const path = require('node:path');
const { mergeCodex, clientFacts, buildCodex, cluster } = require('../tools/lib/codex/build');
const { tmpdir } = require('./helpers/tmp');

function syntheticInputs() {
	const era = { left: 0, right: -1000, top: 1000, bottom: 0, c: 1 };
	const forever = {
		zones: { 1438: { id: 1438, name: 'Teldrassil' }, 1423: { id: 1423, name: 'Eastern Plaguelands' }, 1429: { id: 1429, name: 'Elwynn Forest' } },
		factions: { 589: { id: 589, name: 'Wintersaber Trainers', side: 'Alliance' } },
		mapFrames: { era: { 1438: era, 1429: era } },
		meta: { builtAt: '2026-01-01T00:00:00.000Z', sources: [{ name: 'pfQuest', revision: 'abc', license: 'MIT' }] },
		npcs: {
			4730: { id: 4730, name: 'Lelanai', level: 35, faction: 'A', roles: ['vendor'], spawns: { 1438: { f: 'e', pts: [[25.2, 50.1], [25.3, 50.2], [70, 70]] } }, source: ['questie-forever'] },
			7747: { id: 7747, name: 'World Mount Vendor', level: 10, faction: 'AH', roles: ['vendor'], spawns: {} },
			10440: { id: 10440, name: 'Baron Rivendare', level: 62, rank: 1, faction: null, spawns: {} },
			61: { id: 61, name: 'Thuros Lightfingers', level: 11, rank: 4, faction: null, spawns: {} },
			99: { id: 99, name: 'Nobody', level: 1, faction: null, spawns: {} },
			1: { id: 1, name: 'Waypoint (Only GM can see it)', level: 1, spawns: {} },
			5164: { id: 5164, name: 'Grumnus Steelshaper', level: 60, faction: 'A', roles: ['trainer'], spawns: { 1429: { f: 'e', pts: [[50, 42.8]] } } },
			198: { id: 198, name: 'Khelden Bremen', level: 10, faction: 'A', roles: ['trainer'], spawns: { 1429: { f: 'l', pts: [[49.7, 39.6]] } } },
		},
		objects: {
			2843: { id: 2843, name: 'Battered Chest', roles: ['chest'], spawns: { 1429: { f: 'e', pts: [[63.5, 56.1]] } } },
			500: { id: 500, name: 'Some Door', spawns: { 1429: { f: 'e', pts: [[1, 1]] } } },
		},
		items: {
			8631: { id: 8631, name: 'Reins of the Striped Frostsaber', drops: { npc: {}, object: {} }, vendors: [4730, 7747], source: ['pfquest', 'questie-forever'] },
			13335: { id: 13335, name: "Deathcharger's Reins", drops: { npc: { 10440: 0.02 }, object: {} }, vendors: [7747], source: ['pfquest'] },
			13086: { id: 13086, name: 'Reins of the Winterspring Frostsaber', drops: { npc: {}, object: {} }, vendors: [4730], source: ['pfquest'] },
			2933: { id: 2933, name: 'Seal of Wrynn', drops: { npc: {}, object: {} }, vendors: [], source: ['pfquest'] },
			17: { id: 17, name: 'Martin Fury', drops: { npc: {}, object: {} }, vendors: [] },
			38: { id: 38, name: 'OLDRecruit\'s Belt', drops: { npc: {}, object: {} }, vendors: [] },
			2862: { id: 2862, name: 'Rough Sharpening Stone', drops: { npc: {}, object: {} }, vendors: [] },
			16342: { id: 16342, name: "Sergeant's Cape", drops: { npc: {}, object: {} }, vendors: [] },
			20000: { id: 20000, name: 'Wintersaber Trinket', drops: { npc: {}, object: {} }, vendors: [4730] },
			20001: { id: 20001, name: 'Wintersaber Reward', drops: { npc: {}, object: {} }, vendors: [] },
			20002: { id: 20002, name: 'Wintersaber Hat', drops: { npc: {}, object: {} }, vendors: [] },
			1179: { id: 1179, name: 'Ice Cold Milk', drops: { npc: {}, object: { 2843: 25 } }, vendors: [] },
		},
		quests: {
			176: { id: 176, title: 'Wanted: "Hogger"', level: 11, minLevel: 5, races: 77, classes: null, start: { npc: [], object: [68], item: [] }, end: { npc: [240], object: [] }, pre: [1], preAll: [33], preAny: [7, 783], objectives: [{ type: 'item', id: 1931, count: null, text: 'Huge Gnoll Claw' }], zone: 1429 },
			// QuestieDB requiredMinRep 3000 (Friendly) and a reputation objective 9000 (Honored): the rewards need Honored.
			9001: { id: 9001, title: 'Frostsaber Errand', level: 60, minLevel: 55, races: null, classes: null, start: { npc: [4730], object: [], item: [] }, end: { npc: [4730], object: [] }, pre: [], objectives: [], zone: 1438, minRep: { faction: 589, value: 3000 }, reputation: { faction: 589, value: 9000 }, rewards: { items: [20002] }, source: ['questie-forever'] },
		},
		professions: {
			164: { id: 164, name: 'Blacksmithing', trainers: { Alliance: [5164] }, ranks: [], recipes: [{ spell: 2660, name: 'Rough Sharpening Stone', item: 2862, learnedAt: 1 }] },
		},
		trainers: { 198: { id: 198, name: 'Khelden Bremen', classes: ['MAGE'] } },
		dungeons: {
			source: { name: 'ForeverDungeonJournal', version: '1.0' },
			dungeons: [{ key: 'stratholme', name: 'Stratholme', levels: { min: 45, max: 60 }, entrance: { map: 1423, x: 27.43, y: 11.61, f: 'l' }, bosses: [], quests: [{ id: 5212, title: 'The Medallion of Faith', rewards: { items: [], choices: [13335] } }] }],
		},
	};
	const atlasloot = {
		meta: { version: 'Forever 1.60.1', licence: 'GPL-2.0' },
		instances: [
			{ key: 'Stratholme', name: 'Stratholme', kind: 'dungeon', forever: true, areaId: 2017, levels: [37, 58, 60], bosses: [{ name: 'Baron Rivendare', npc: [10440], items: [{ item: 13335, chance: 0.1 }] }] },
		],
		droprates: {},
		collections: [{ group: 'Mounts', section: 'Drops', item: 13335, faction: null }],
		crafting: [],
		factions: [{ factionId: 589, name: 'Wintersaber Trainers', rewards: [{ item: 13086, standing: 7 }, { item: 20000, standing: 6 }, { item: 20001, standing: 5 }] }],
		pvp: [{ group: 'PvP', item: 18876, faction: 'A', rank: 14, honor: null }],
	};
	const rarescanner = {
		meta: { version: '1.60.1.b7', licence: 'All Rights Reserved' },
		rares: [
			{ npc: 61, name: null, map: 1429, x: 89.4, y: 79.3, points: [[89.4, 79.3], [89.6, 79.5], [69.6, 79.4]], loot: [2933] },
			{ npc: 61, name: null, map: 100001, x: 1, y: 1, points: [], loot: [] },
			{ npc: 777777, name: 'Far Away Rare', map: 100001, x: 5, y: 5, points: [], loot: [] },
		],
		treasures: [{ object: 2843, name: null, map: 1429, x: 63.5, y: 56.1, points: [], loot: [2933, 424242] }],
		mounts: {},
		pets: {},
	};
	const flbis = {
		meta: { version: 'v0.5.1-beta', licence: 'MIT' },
		items: { 2933: { name: 'Seal of Wrynn', sources: [{ type: 'quest', id: 176, name: 'Wanted: "Hogger"' }] } },
		quests: { 176: { name: 'Wanted: "Hogger"', rewards: { choices: [2933, 1933] } } },
	};
	const client = clientFacts({
		Item: [
			{ ID: '8631', ClassID: '15', SubclassID: '5', InventoryType: '0' },
			{ ID: '13086', ClassID: '15', SubclassID: '5', InventoryType: '0' },
			{ ID: '13335', ClassID: '15', SubclassID: '0', InventoryType: '0' },
			{ ID: '2933', ClassID: '4', SubclassID: '0', InventoryType: '11' },
		],
		ItemSparse: [
			{ ID: '8631', Display_lang: 'Reins of the Striped Frostsaber', OverallQualityID: '3', RequiredLevel: '40', BuyPrice: '800000' },
			{ ID: '13086', Display_lang: 'Reins of the Winterspring Frostsaber', OverallQualityID: '4', RequiredLevel: '60', BuyPrice: '1000000', MinFactionID: '589', MinReputation: '7' },
			{ ID: '13335', Display_lang: "Deathcharger's Reins", OverallQualityID: '4', RequiredLevel: '60' },
			{ ID: '2933', Display_lang: 'Seal of Wrynn', OverallQualityID: '2', RequiredLevel: '0', RequiredSkill: '164', RequiredSkillRank: '150' },
			{ ID: '18876', Display_lang: "Grand Marshal's Claymore", OverallQualityID: '4', RequiredLevel: '60', RequiredPVPRank: '18' },
			{ ID: '16342', Display_lang: 'Sergeant\'s Cape', OverallQualityID: '3', RequiredLevel: '30', RequiredPVPRank: '7' },
			{ ID: '99999', Display_lang: 'Dishonoured Thing', OverallQualityID: '1', RequiredLevel: '0', RequiredPVPRank: '1' },
		],
		ItemEffect: [
			{ ID: '1', TriggerType: '0', SpellID: '55884' },
			{ ID: '2', TriggerType: '6', SpellID: '8394' },
			{ ID: '3', TriggerType: '6', SpellID: '17481' },
		],
		ItemXItemEffect: [
			{ ItemID: '8631', ItemEffectID: '1' },
			{ ItemID: '8631', ItemEffectID: '2' },
			{ ItemID: '13335', ItemEffectID: '3' },
		],
		SpellEffect: [
			{ SpellID: '8394', Effect: '6', EffectAura: '78' },
			{ SpellID: '17481', Effect: '6', EffectAura: '78' },
			{ SpellID: '13819', Effect: '6', EffectAura: '78' },
			{ SpellID: '5784', Effect: '6', EffectAura: '78' },
		],
		SpellName: [
			{ ID: '8394', Name_lang: 'Striped Frostsaber' },
			{ ID: '17481', Name_lang: 'Deathcharger' },
			{ ID: '13819', Name_lang: 'Summon Warhorse' },
			{ ID: '5784', Name_lang: 'Summon Felsteed' },
		],
		SkillLine: [{ ID: '164', DisplayName_lang: 'Blacksmithing' }],
		SkillLineAbility: [
			{ SkillLine: '777', Spell: '13819', ClassMask: '2' },
			{ SkillLine: '777', Spell: '5784', ClassMask: '0' },
			{ SkillLine: '777', Spell: '8394', ClassMask: '0' },
		],
	});
	return { forever, atlasloot, rarescanner, flbis, client };
}

test('mergeCodex applies precedence, dedupes sources and keeps provenance', () => {
	const codex = mergeCodex(syntheticInputs());
	const it = codex.items;
	// Vendor: the GM vendor without spawns is left out; cost from the client.
	assert.deepEqual(it[8631].sources, [{ type: 'vendor', npc: 4730, cost: 800000, from: ['questie', 'pfquest'] }]);
	assert.equal(it[8631].kind, 'mount');
	assert.equal(it[8631].spell, 8394);
	assert.equal(it[8631].quality, 3);
	// Drop: data/forever (pfQuest) and AtlasLoot dedupe to one source; AtlasLoot's
	// chance and pfQuest's rank tie (Era), the first-ranked keeps its chance.
	const drops = it[13335].sources.filter((s) => s.type === 'drop');
	assert.equal(drops.length, 1);
	assert.equal(drops[0].npc, 10440);
	assert.equal(drops[0].instance, 'stratholme');
	assert.deepEqual(drops[0].from, ['atlasloot', 'pfquest']);
	assert.equal(it[13335].kind, 'mount');
	// Quest rewards from dungeons.json; the AtlasLoot Mounts collection makes it a mount.
	assert.deepEqual(it[13335].sources.find((s) => s.type === 'quest'), { type: 'quest', quest: 5212, choice: true, from: ['dungeons'] });
	// Rep: the client's MinReputation (Exalted = 8) beats AtlasLoot's 7; the vendor is the quartermaster.
	assert.deepEqual(it[13086].sources.find((s) => s.type === 'rep'), { type: 'rep', faction: 589, standing: 8, npc: 4730, from: ['client', 'atlasloot'] });
	// Purchase requirements from ItemSparse: MinReputation 7 = Exalted = standing 8.
	assert.deepEqual([it[13086].repFaction, it[13086].repStanding, it[13086].reqSkill, it[13086].reqSkillRank], [589, 8, null, null]);
	assert.deepEqual([it[2933].repFaction, it[2933].repStanding, it[2933].reqSkill, it[2933].reqSkillRank], [null, null, 164, 150]);
	// Gossip-gated vendor items (nothing in ItemSparse) take the reputation reward's faction and standing.
	assert.deepEqual([it[20000].repFaction, it[20000].repStanding], [589, 6]);
	assert.deepEqual([it[20001].repFaction, it[20001].repStanding], [null, null], 'a reputation reward nobody sells is not a purchase requirement');
	// A quest's gate (QuestieDB requiredMinRep, a reputation objective: the higher) is a rep
	// source naming no vendor, and stays on the quest, not on the item's purchase.
	assert.deepEqual(it[20002].sources, [
		{ type: 'quest', quest: 9001, from: ['questie'] },
		{ type: 'rep', faction: 589, standing: 6, from: ['questie'] },
	]);
	assert.deepEqual([it[20002].repFaction, it[20002].repStanding], [null, null]);
	assert.deepEqual([codex.quests[9001].repFaction, codex.quests[9001].repStanding], [589, 6]);
	assert.equal(codex.quests[176].repFaction, undefined, 'an ungated quest carries no standing');
	// Quest source from FLB items and FLB quest rewards dedupe (choice kept); RareScanner loot adds a drop.
	assert.deepEqual(it[2933].sources, [
		{ type: 'quest', quest: 176, choice: true, from: ['flbis'] },
		{ type: 'drop', npc: 61, from: ['rarescanner'] },
	]);
	assert.equal(it[17].sources.length, 0, 'source-less items stay searchable');
	// Client RequiredPVPRank (5..18) becomes the title rank (1..14) and dedupes with AtlasLoot's.
	assert.deepEqual(it[18876].sources, [{ type: 'pvp', rank: 14, from: ['client', 'atlasloot'] }]);
	assert.deepEqual(it[16342].sources, [{ type: 'pvp', rank: 3, from: ['client'] }]);
	assert.equal(it[99999], undefined, 'dishonoured ranks are not PvP rewards (and the item has no other source or Forever name)');
	assert.equal(it[38], undefined, 'junk names without sources are dropped');
	// Craft from professions.json, profession named by its skillLine.
	assert.deepEqual(it[2862].sources, [{ type: 'craft', spell: 2660, skillLine: 164, profession: 'Blacksmithing', skill: 1, from: ['forever'] }]);
});

test('mergeCodex marks retired mounts (Era vendor stock no collection or curated guide lists) and source-less items', () => {
	const inputs = syntheticInputs();
	const items = inputs.forever.items;
	items[12302] = { id: 12302, name: 'Reins of the Frostsaber', drops: { npc: {}, object: {} }, vendors: [4730], source: ['pfquest', 'questie-forever'] };
	items[269681] = { id: 269681, name: 'Empyrean Galestrider', drops: { npc: {}, object: {} }, vendors: [4730], source: ['questie-forever'] };
	for (const id of ['12302', '269681']) {
		inputs.client.items[id] = { ...inputs.client.items[8631], name: items[id].name };
	}
	inputs.curated = [8631];
	const it = mergeCodex(inputs).items;
	assert.equal(it[12302].kind, 'mount');
	assert.equal(it[12302].status, 'retired', 'only Era vendor rows, in no collection list and no curated guide');
	assert.equal(it[8631].status, null, 'a curated guide collects it');
	assert.equal(it[13335].status, null, 'listed by AtlasLoot and dropped');
	assert.equal(it[269681].status, null, 'Forever-only vendor rows are trusted');
	assert.equal(it[17].status, 'nosource');
	assert.equal(it[2933].status, null, 'not a collectible: never retired');
});

test('item status round-trips through the pack and reaches Codex.Each', () => {
	const codex = sampleCodex();
	const ids = Object.keys(codex.items).filter((id) => codex.items[id].kind === 'mount').slice(0, 2);
	codex.items[ids[0]].status = 'retired';
	codex.items[ids[1]].status = 'nosource';
	const pack = writeCodexPack(codex);
	try {
		const [recs, each] = run(
			`
local C = Polestar.Codex
emit({ C.Item(${ids[0]}).status, C.Item(${ids[1]}).status, C.Item(${ids[0]}).quality })
local out = {}
C.Each("mount", function(id, name, quality, status) out[tostring(id)] = (status or "-") .. "/" .. tostring(quality) end)
emit(out)
`,
			{ pack },
		);
		assert.deepEqual(recs, ['retired', 'nosource', codex.items[ids[0]].quality]);
		assert.equal(each[ids[0]], `retired/${codex.items[ids[0]].quality}`);
		assert.equal(each[ids[1]], `nosource/${codex.items[ids[1]].quality}`);
		assert.ok(Object.entries(each).filter(([id]) => !ids.includes(id)).every(([, v]) => v.startsWith('-/')));
	} finally {
		pack.cleanup();
	}
});

test('mergeCodex builds npcs, rares, instances, quests, spells and frames', () => {
	const codex = mergeCodex(syntheticInputs());
	const n = codex.npcs;
	assert.equal(n[1], undefined, 'GM npcs are dropped');
	assert.equal(n[99], undefined, 'unreferenced npcs without spawns or roles are dropped');
	assert.equal(n[777777], undefined, 'RareScanner rows outside Forever zones are dropped');
	assert.equal(n[61].rare, true);
	assert.deepEqual(n[61].loot, [2933], 'RareScanner loot, items the Codex knows');
	assert.deepEqual(n[4730].loot, [], 'only rares carry loot');
	assert.deepEqual(n[61].spawns, [
		{ map: 1429, x: 89.5, y: 79.4, f: null },
		{ map: 1429, x: 69.6, y: 79.4, f: null },
	]);
	assert.deepEqual(n[4730].spawns, [
		{ map: 1438, x: 25.3, y: 50.2, f: 'e' },
		{ map: 1438, x: 70, y: 70, f: 'e' },
	]);
	assert.deepEqual(n[198].spawns, [{ map: 1429, x: 49.7, y: 39.6, f: null }], 'live-frame spawns carry f = null');
	assert.deepEqual(n[5164].roles, ['trainer', 'trainer:164']);
	assert.deepEqual(n[198].roles, ['class:MAGE', 'trainer']);
	assert.equal(n[10440].boss, true);
	assert.equal(n[10440].instance, 'stratholme');
	const s = codex.instances.stratholme;
	assert.deepEqual(s.entrance, { map: 1423, x: 27.4, y: 11.6, f: null });
	assert.deepEqual(s.bosses, [{ name: 'Baron Rivendare', npc: 10440, items: [13335] }]);
	assert.equal(s.areaId, 2017);
	const q = codex.quests[176];
	assert.deepEqual(q.pre, [33]);
	assert.deepEqual(q.preAny, [7, 783]);
	assert.equal(q.faction, 'A');
	assert.deepEqual(q.choices, [1933, 2933]);
	assert.equal(codex.quests[5212].title, 'The Medallion of Faith');
	assert.deepEqual(codex.spells[8394], { kind: 'mount', item: 8631, name: 'Striped Frostsaber', class: null });
	assert.deepEqual(codex.spells[13819], { kind: 'mount', item: null, name: 'Summon Warhorse', class: 'PALADIN' });
	assert.deepEqual(codex.spells[5784], { kind: 'mount', item: null, name: 'Summon Felsteed', class: 'WARLOCK' });
	assert.deepEqual(Object.keys(codex.objects), ['2843']);
	assert.equal(codex.objects[2843].treasure, true);
	assert.deepEqual(codex.objects[2843].loot, [1179, 2933], 'known chance first; unknown items (424242) dropped');
	assert.deepEqual(Object.keys(codex.frames).sort(), ['1429', '1438']);
});

test('cluster merges nearby points, biggest first', () => {
	assert.deepEqual(cluster([[10, 10], [11, 10], [50, 50], [10.5, 11]]), [
		{ x: 10.5, y: 10.3, n: 3 },
		{ x: 50, y: 50, n: 1 },
	]);
});

test('buildCodex writes deterministic JSON and a pack whose memory it measures', async () => {
	const tmp = tmpdir('polestar-codex-build-');
	const run = (n) =>
		buildCodex({ inputs: syntheticInputs(), outDir: path.join(tmp, `out${n}`), packDir: path.join(tmp, `pack${n}`, 'Polestar_Codex'), version: '1.0.0', measure: n === 1 });
	const a = await run(1);
	const b = await run(2);
	const files = fs.readdirSync(path.join(tmp, 'out1')).sort();
	assert.deepEqual(files, ['factions.json', 'frames.json', 'instances.json', 'items.json', 'journal.json', 'meta.json', 'npcs.json', 'objects.json', 'quests.json', 'spells.json', 'zones.json']);
	for (const f of files.filter((f) => f !== 'meta.json')) {
		assert.equal(fs.readFileSync(path.join(tmp, 'out1', f), 'utf8'), fs.readFileSync(path.join(tmp, 'out2', f), 'utf8'), f);
	}
	for (const f of fs.readdirSync(a.packDir)) assert.equal(fs.readFileSync(path.join(a.packDir, f), 'utf8'), fs.readFileSync(path.join(b.packDir, f), 'utf8'), f);
	const meta = JSON.parse(fs.readFileSync(path.join(tmp, 'out1', 'meta.json'), 'utf8'));
	assert.equal(meta.counts.mount, 3);
	assert.equal(meta.counts.rare, 1);
	assert.equal(meta.counts.instance, 1);
	assert.ok(meta.coverage.share > 0 && meta.coverage.share < 1);
	assert.ok(meta.pack.bytes > 0);
	assert.ok(meta.pack.memoryKB > 0 && meta.pack.memoryKBDecoded > meta.pack.memoryKB, JSON.stringify(meta.pack));
	assert.ok(meta.sources.some((s) => s.name === 'AtlasLootClassic' && s.licence === 'GPL-2.0'));
	const toc = fs.readFileSync(path.join(a.packDir, 'Polestar_Codex.toc'), 'utf8');
	assert.match(toc, /^Meta\.lua$/m);
});

test('curatedRepGates: a collectible guide reaching a standing before it buys the item gates that vendor', () => {
	const { curatedRepGates } = require('../tools/lib/codex/build');
	const dir = tmpdir('polestar-codex-gates-');
	fs.writeFileSync(path.join(dir, 'saber.guide'), [
		'guide x/saber', 'collects 13086', '', 'step Rep', '  rep "Wintersaber Trainers" Exalted', '  talk 10618',
		'step Buy', '  buy 13086 npc 10618                 -- Rivern Frostwind', '  buy 99 npc 10618',
	].join('\n'));
	fs.writeFileSync(path.join(dir, 'plain.guide'), ['guide x/plain', 'step A', '  rep 589 Honored', '  buy 5 npc 1'].join('\n'));
	assert.deepEqual(curatedRepGates(dir), { 13086: [{ npc: 10618, faction: null, factionName: 'Wintersaber Trainers', standing: 8 }] });
});

test('mergeCodex: an NPC casting a spell that creates the item hands it out (gift)', () => {
	const inputs = syntheticInputs();
	delete inputs.atlasloot;
	inputs.client.creates = { 20001: [21357] };
	inputs.wowhead = { npc: {}, object: {}, item: {}, spell: { 21357: { id: 21357, usedBy: [4730, 424242] } } };
	const it = mergeCodex(inputs).items;
	assert.deepEqual(it[20001].sources, [{ type: 'gift', npc: 4730, spell: 21357, from: ['wowhead'] }], 'an NPC the data does not know is left out');
});

test('mergeCodex: a Wowhead list row gives the level of an NPC nothing else does, only the level', () => {
	const inputs = syntheticInputs();
	delete inputs.atlasloot;
	inputs.forever.npcs[7747].level = null;
	const row = (id, level) => ({ id, name: 'x', location: [1], level, classification: 'rare', boss: true, change: { status: 'new', lines: [] } });
	inputs.wowhead = { npc: {}, object: {}, item: {}, spell: {}, listed: { npc: { 7747: row(7747, [9, 10]), 4730: row(4730, [50, 50]) } } };
	const { npcs } = mergeCodex(inputs);
	assert.deepEqual([npcs[7747].level, npcs[7747].levelMax, npcs[7747].rare, npcs[7747].boss], [9, 10, false, false]);
	assert.equal(npcs[4730].level, 35, "the data's level stays");
});
