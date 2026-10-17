'use strict';
// The Dungeons section's data: the builder (tools/lib/codex/journal.js) on the
// synthetic fixture tests/fixtures/codex/dungeons.json, and the runtime
// (addon/Polestar/Dungeons/Dungeons.lua) reading its pack file inside a Codex
// pack, the way the client loads it.

const { test, before, after } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { fakeLocale } = require('./helpers/locale');
const { writeCodexPack } = require('./helpers/codex');
const { instanceMapsOf, zonePoint, chainOf, objectivesOf, buildJournal, emitJournal } = require('../tools/lib/codex/journal');

const { codex, inputs } = JSON.parse(fs.readFileSync(path.join(__dirname, 'fixtures', 'codex', 'dungeons.json'), 'utf8'));

// ---------------------------------------------------------------------------
// Builder
// ---------------------------------------------------------------------------

test('instanceMapsOf: instances only, their areas (inner: on the map itself), the zone holding the entrance, the corpse point', () => {
	const maps = [
		{ ID: '0', MapName_lang: 'Eastern Kingdoms', InstanceType: '0', CorpseMapID: '-1' },
		{ ID: '70', MapName_lang: 'Uldaman', InstanceType: '1', AreaTableID: '1337', CorpseMapID: '0', Corpse_0: '-6060.5', Corpse_1: '-2955', MaxPlayers: '10' },
		{ ID: '409', MapName_lang: 'Molten Core', InstanceType: '2', AreaTableID: '2717', CorpseMapID: '0', Corpse_0: '0', Corpse_1: '0', MaxPlayers: '40' },
	];
	const areas = [
		{ ID: '1337', AreaName_lang: 'Uldaman', ContinentID: '70', ParentAreaID: '0' },
		{ ID: '1338', AreaName_lang: 'Hall of the Keepers', ContinentID: '70', ParentAreaID: '1337' },
		{ ID: '1517', AreaName_lang: 'Uldaman', ContinentID: '0', ParentAreaID: '3' },
		{ ID: '2717', AreaName_lang: 'Molten Core', ContinentID: '409', ParentAreaID: '0' },
	];
	assert.deepEqual(instanceMapsOf(maps, areas), [
		{ id: 70, name: 'Uldaman', raid: false, players: 10, area: 1337, areas: [1337, 1338, 1517], inner: [1337, 1338], zones: [3], corpse: { c: 0, x: -6060.5, y: -2955 } },
		{ id: 409, name: 'Molten Core', raid: true, players: 40, area: 2717, areas: [2717], inner: [2717], zones: [], corpse: null },
	]);
	assert.deepEqual(instanceMapsOf(undefined, undefined), []);
});

test('zonePoint: the preferred zone holding the point, else the frame it sits nearest the middle of; continents skipped', () => {
	const frames = {
		1: { c: 0, left: 1000, right: 0, top: 1000, bottom: 0 },
		2: { c: 0, left: 600, right: -400, top: 1000, bottom: 0 },
		3: { c: 0, left: 30000, right: -30000, top: 30000, bottom: -30000 },
		4: { c: 1, left: 1000, right: 0, top: 1000, bottom: 0 },
	};
	assert.deepEqual(zonePoint(frames, 0, 500, 100), { map: 2, x: 50, y: 50, f: null });
	assert.deepEqual(zonePoint(frames, 0, 500, 100, [1]), { map: 1, x: 90, y: 50, f: null });
	assert.equal(zonePoint(frames, 0, 5000, 5000), null);
});

test('chainOf and objectivesOf', () => {
	// Every prerequisite, depth first, oldest first; cycles stop.
	assert.deepEqual(chainOf({ 3: { pre: [2] }, 2: { pre: [1] }, 1: { pre: [3] } }, {}, 3), [1, 2]);
	// All of `pre`/`preAll` and each `preAny` alternative, not only the first
	// (The Call to Command needs Duskwing and The Corpulent One), and the
	// breadcrumbs; the other side's are left out.
	const quests = { 6144: { pre: [6135, 6136] }, 6135: { pre: [6022] }, 6136: { preAny: [6042, 6133] }, 6022: {}, 6042: {}, 6133: { faction: 'A' } };
	assert.deepEqual(chainOf(quests, { 6144: { breadcrumbs: [5961] }, 5961: {} }, 6144, 'H'), [6022, 6135, 6042, 6136, 5961]);
	assert.deepEqual(chainOf(quests, {}, 6144, null), [6022, 6135, 6042, 6133, 6136]);
	const names = { npc: (id) => ({ 1: 'Kresh' })[id], item: (id) => ({ 2: 'Deviate Hide' })[id], object: () => 'Ancient Chest' };
	assert.deepEqual(
		objectivesOf([{ type: 'item', id: 2, count: 20 }, { type: 'kill', id: 1, count: 1 }, { type: 'object', id: 3 }, { type: 'event', text: 'Escort Muyoh' }], names),
		[{ k: 'item', id: 2, n: 20, name: 'Deviate Hide' }, { k: 'kill', id: 1, name: 'Kresh' }, { k: 'object', id: 3, name: 'Ancient Chest' }, { k: 'event', name: 'Escort Muyoh' }],
		'the facts, so each client composes the line in its language',
	);
	assert.equal(objectivesOf([], names), null);
});

test('buildJournal: pages with quests from DungeonJournal, area and objectives; chains, rewards, bosses with tied quests, entrances', () => {
	const j = buildJournal(inputs, codex);
	assert.deepEqual(j.meta, { schema: 3, counts: { dungeons: 3, quests: 5, entrances: 2, attunements: 3 } });
	const wc = j.dungeons['wailing-caverns'];
	assert.equal(wc.zoneName, 'The Barrens');
	assert.equal(wc.players, 10);
	assert.deepEqual([wc.minLevel, wc.maxLevel], [17, 24]);
	assert.deepEqual(wc.quests.map((q) => q.id), [1486, 959, 914, 6981], 'level order; the hidden quest stays out');
	const [hides, docks, fang, shard] = wc.quests;
	assert.deepEqual(hides.objectives, [{ k: 'item', id: 6443, n: 20, name: 'Deviate Hide' }]);
	assert.equal(hides.shareable, true);
	assert.deepEqual(hides.rewards, {
		items: [{ id: 6480, name: 'Slick Deviate Leggings', quality: 2, choice: true }, { id: 918, name: 'Deviate Hide Pack', quality: 1, choice: true }],
		xp: 1600, money: 1800, rep: [],
	});
	assert.deepEqual(hides.start, { kind: 'npc', id: 5767, name: 'Nalpak', map: 1413, x: 46, y: 35.7, f: 'e', inside: false });
	assert.equal(docks.title, 'Trouble at the Docks', 'a quest filed under the area, not in DungeonJournal');
	assert.deepEqual(docks.objectives.map((o) => [o.k, o.name]), [['kill', 'Kresh']]);
	assert.equal(docks.start.name, 'Tonga Runetotem');
	assert.equal(fang.faction, 'H');
	assert.deepEqual(fang.chain, [1490]);
	assert.deepEqual(fang.rewards.rep, [{ faction: 81, name: 'Thunder Bluff', value: 250 }]);
	assert.equal(shard.inside, true);
	assert.deepEqual(shard.startItem, { id: 10441, name: 'Glowing Shard' });
	assert.equal(shard.shareable, false);
	assert.deepEqual(Object.keys(wc.chain), ['1490']);
	assert.equal(wc.chain[1490].start.name, 'Tonga Runetotem');
	assert.deepEqual(wc.bosses.map((b) => [b.order, b.name, b.level, b.quests.map((t) => `${t.id}:${t.how}${t.item ? `:${t.itemName}` : ''}`)]), [
		[1, 'Lady Anacondra', 20, ['914:item:Gem of Anacondra']],
		[2, 'Kresh', 20, ['959:kill']],
		[3, 'Lord Cobrahn', 20, ['914:item:Gem of Cobrahn']],
		[4, 'Mutanus the Devourer', 22, ['6981:starts:Glowing Shard']],
	]);
	const dm = j.dungeons.deadmines;
	assert.deepEqual(dm.entrance, { map: 1436, x: 42.5, y: 71.7, f: null }, "the client's corpse point, on its zone");
	assert.deepEqual(dm.quests.map((q) => [q.id, q.chain]), [[166, [155]]]);
	assert.equal(dm.chain[155].title, 'The Defias Brotherhood');
	assert.deepEqual(dm.bosses.map((b) => b.name), ['Edwin VanCleef'], 'trash is not a boss');
	const bh = j.dungeons['blackmaw-hold'];
	assert.equal(bh.forever, true);
	assert.deepEqual([bh.quests, bh.bosses, bh.entrance], [[], [], null]);
});

test("buildJournal: kp's report: a game event's quest (the Darkmoon Faire's Copper Modulator) is on no page through an item that drops inside", () => {
	const c = structuredClone(codex);
	const i = structuredClone(inputs);
	// Copper Modulator: here only Sneed's Shredder in the Deadmines drops it.
	c.npcs[642] = { id: 642, name: "Sneed's Shredder", level: 20, faction: null, instance: 'deadmines', roles: [], spawns: [] };
	c.npcs[14841] = { id: 14841, name: 'Rinling', level: 55, faction: null, instance: null, roles: [], spawns: [{ map: 1412, x: 38, y: 44.3, f: 'e' }] };
	c.items[4363] = { id: 4363, name: 'Copper Modulator', quality: 1, kind: 'item', sources: [{ type: 'drop', npc: 642, instance: 'deadmines', chance: 0.54 }] };
	const quest = (id, title) => ({
		id, title, level: 60, minLevel: 1, faction: null, races: null, classes: null,
		start: { npc: [14841], object: [], item: [] }, end: { npc: [14841], object: [] },
		objectives: [{ type: 'item', id: 4363, count: null, text: 'Copper Modulator' }], pre: [], preAny: [], rewards: [], choices: [],
	});
	c.quests[7894] = quest(7894, 'Copper Modulator');
	i.forever.quests[7894] = { event: 5, repeatable: true, source: ['pfquest', 'questie-forever'] };
	c.quests[90001] = quest(90001, 'Spare Parts');
	c.quests[90002] = quest(90002, 'Filed Under the Mines');
	i.forever.quests[90002] = { area: 1581, event: 86, source: ['questie-forever'] };
	const pages = buildJournal(i, c).dungeons;
	const on = (id) => Object.keys(pages).filter((k) => pages[k].quests.some((q) => q.id === id));
	assert.deepEqual(on(7894), [], 'the Faire ticket turn-in is on no page');
	assert.deepEqual(on(90001), ['deadmines'], 'without an event the same item ties the quest to the Deadmines');
	assert.deepEqual(on(90002), ['deadmines'], 'an event quest filed under the instance stays');
});

test('buildJournal: a stray drop (only Wowhead records it, under 5%) ties no quest to a dungeon; a quest drop does', () => {
	const c = structuredClone(codex);
	const i = structuredClone(inputs);
	c.npcs[16014] = { id: 16014, name: 'Mux Manascrambler', level: 60, faction: null, instance: null, roles: [], spawns: [{ map: 1446, x: 52, y: 28, f: 'e' }] };
	c.npcs[642] = { id: 642, name: "Sneed's Shredder", level: 20, faction: null, instance: 'deadmines', roles: [], spawns: [] };
	const item = (id, name, from, chance) => ({ id, name, quality: 1, kind: 'item', sources: [{ type: 'drop', npc: 642, instance: 'deadmines', chance, from }] });
	c.items[16203] = item(16203, 'Greater Eternal Essence', ['wowhead'], 1.2);
	c.items[90010] = item(90010, 'Shredder Gear', ['questie', 'pfquest', 'wowhead'], 1.2);
	c.items[90011] = item(90011, 'Shredder Plate', ['wowhead'], 40);
	const quest = (id, title, itemId) => ({
		id, title, level: 60, minLevel: 55, faction: null, races: null, classes: null,
		start: { npc: [16014], object: [], item: [] }, end: { npc: [16014], object: [] },
		objectives: [{ type: 'item', id: itemId, count: 4 }], pre: [], preAny: [], rewards: [], choices: [],
	});
	c.quests[8921] = quest(8921, 'The Ectoplasmic Distiller', 16203);
	c.quests[90012] = quest(90012, 'Gears', 90010);
	c.quests[90013] = quest(90013, 'Plates', 90011);
	const dm = buildJournal(i, c).dungeons.deadmines.quests.map((q) => q.id);
	assert.ok(!dm.includes(8921), "the essence a boss drops 1.2% of the time on Wowhead's list ties nothing");
	assert.ok(dm.includes(90012), 'a drop QuestieDB or pfQuest records does');
	assert.ok(dm.includes(90013), 'and a common one only Wowhead records');
});

test('buildJournal tolerates missing inputs; emitJournal writes one file of summaries and page sources', () => {
	assert.deepEqual(buildJournal({}, {}).dungeons, {});
	const [file] = emitJournal(buildJournal(inputs, codex));
	assert.equal(file.name, 'Dungeons1.lua');
	assert.match(file.text, /^local D = Polestar and Polestar\.Dungeons$/m);
	assert.match(file.text, /\["wailing-caverns"\]="return \{/);
	assert.equal(emitJournal(buildJournal({}, {}))[0].name, 'Dungeons1.lua');
});

// ---------------------------------------------------------------------------
// Runtime
// ---------------------------------------------------------------------------

let pack;
before(() => {
	pack = writeCodexPack(codex, { extraFiles: emitJournal(buildJournal(inputs, codex)) });
});
after(() => pack && pack.cleanup());

const FILES = ['Core/Core.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml'];

function run(script, { withPack = true } = {}) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: withPack ? pack.stubLua : '',
		addons: [{ name: 'Polestar', files: FILES }],
		script: `stub.login()\nlocal D = Polestar.Dungeons\n${script}`,
	}).emitted;
}

test('runtime: loads on demand; List in level order from summaries; Get; Entrance', () => {
	const [out] = run(`
local before = D.Meta() ~= nil
local ok = D.Load()
local list = {}
for _, d in ipairs(D.List()) do list[#list + 1] = { d.key, d.minLevel, d.quests.A, d.quests.H, d.bosses, d.forever, d.zoneName or false } end
local wc = D.Get("wailing-caverns")
emit({ before = before, ok = ok, list = list, wc = { wc.name, wc.players, wc.entrance.map, wc.entrance.x }, entrance = { D.Entrance("deadmines") },
	none = D.Get("nowhere") == nil, find = D.Find("wailing") })`);
	assert.equal(out.before, false);
	assert.equal(out.ok, true);
	assert.deepEqual(out.list, [
		['deadmines', 17, 1, 0, 1, false, 'Westfall'],
		['wailing-caverns', 17, 3, 4, 4, false, 'The Barrens'],
		['blackmaw-hold', 55, 0, 0, 0, true, false],
	]);
	assert.deepEqual(out.wc, ['Wailing Caverns', 10, 1413, 46]);
	assert.deepEqual(out.entrance, [1436, 42.5, 71.7]);
	assert.equal(out.none, true);
	assert.equal(out.find, 'wailing-caverns');
});

test('runtime: Quests by faction with every field a card needs; Quest resolves chain quests; Bosses with tied quests', () => {
	const [out] = run(`
local function ids(list) local t = {} for i, q in ipairs(list) do t[i] = q.id end return t end
local fang = D.Quest("wailing-caverns", 914)
local items = {}
for i, it in ipairs(fang.rewards.items) do items[i] = { it.id, it.name, it.quality, it.choice } end
local pre = D.Quest("wailing-caverns", fang.chain[1])
local bosses = {}
for _, b in ipairs(D.Bosses("wailing-caverns")) do
	local t = {}
	for _, q in ipairs(b.quests) do t[#t + 1] = q.id .. ":" .. q.how end
	bosses[#bosses + 1] = { b.order, b.name, b.level, t }
end
local shard = D.Quest("wailing-caverns", 6981)
emit({ all = ids(D.Quests("wailing-caverns")), a = ids(D.Quests("wailing-caverns", "A")), h = ids(D.Quests("wailing-caverns", "H")),
	fang = { fang.title, fang.level, fang.minLevel, fang.faction, fang.shareable, D.ObjectiveText(fang), fang.start.name, fang.start.map, fang.finish.name,
		fang.rewards.xp, fang.rewards.money, fang.rewards.rep[1].name, fang.rewards.rep[1].value }, items = items,
	pre = { pre.title, pre.start.name, pre.start.x }, shard = { shard.inside, shard.startItem.name, shard.start.kind }, bosses = bosses,
	missing = D.Quest("wailing-caverns", 1) == nil, noPage = #D.Quests("nowhere") })`);
	assert.deepEqual(out.all, [1486, 959, 914, 6981]);
	assert.deepEqual(out.a, [1486, 959, 6981]);
	assert.deepEqual(out.h, [1486, 959, 914, 6981]);
	assert.deepEqual(out.fang, ['Leaders of the Fang', 22, 18, 'H', true, 'Collect Gem of Cobrahn\nCollect Gem of Anacondra', 'Nara Wildmane', 1456, 'Nara Wildmane', 2350, 3500, 'Thunder Bluff', 250]);
	assert.deepEqual(out.items, [[6505, 'Crescent Staff', 3, true], [6504, 'Wingblade', 3, true]]);
	assert.deepEqual(out.pre, ['Nara Wildmane', 'Tonga Runetotem', 52.2]);
	assert.deepEqual(out.shard, [true, 'Glowing Shard', 'item']);
	assert.deepEqual(out.bosses, [[1, 'Lady Anacondra', 20, ['914:item']], [2, 'Kresh', 20, ['959:kill']], [3, 'Lord Cobrahn', 20, ['914:item']], [4, 'Mutanus the Devourer', 22, ['6981:starts']]]);
	assert.equal(out.missing, true);
	assert.equal(out.noPage, 0);
});

test('runtime: another language reads the objective line in its own words and names', () => {
	const { emitted: [out] } = runAddon({
		stubs: ['stub_world.lua'],
		before: `${pack.stubLua}\n${fakeLocale('itIT', { 'Collect %s': 'Raccogli %s' })}`,
		addons: [{ name: 'Polestar', files: FILES }],
		script: `stub.login()
local D = Polestar.Dungeons
Polestar.Names.Add("itIT", "item", { [5423] = "Gemma di Cobrahn" })
local fang = D.Quest("wailing-caverns", 914)
local ids = {}
for i, o in ipairs(fang.objectives) do ids[i] = o.id end
Polestar.Names.Add("itIT", "objective", { [777] = "Scorta$B$Bil mercante, $N." })
emit({ D.ObjectiveText(fang), ids, D.ObjectiveText({ id = 777, objectives = { { k = "event", name = "Escort the merchant" } } }) })`,
	});
	assert.match(out[0] || out[1] || '', /^Raccogli /, 'the template is the client language\'s');
	assert.match(out[2], /^Scorta il mercante, [^$]*\.$/, 'an event reads the quest\'s own summary, its tokens filled');
});

test('runtime: Open fires SHOW_DUNGEON; GuideTo and GuideToPoint set the arrow; the setting stops it; without the pack it says why', () => {
	const [out] = run(`
local nav = {}
Polestar.Nav = { SetTarget = function(map, x, y, label) nav[#nav + 1] = { map, x, y, label } return true end }
local fired = {}
Polestar.On("SHOW_DUNGEON", function(key) fired[#fired + 1] = key or "home" end)
D.Open("deadmines")
D.Open()
local g1 = D.GuideTo("wailing-caverns")
local g2 = D.GuideToPoint(D.Quest("wailing-caverns", 1486).start)
local g3 = D.GuideTo("blackmaw-hold")
Polestar.Set("dungeons.enabled", false)
local opened = D.Open("deadmines")
local ok, reason = D.Load()
emit({ fired = fired, nav = nav, g = { g1, g2, g3 }, opened = opened, reason = reason, list = #D.List() })`);
	assert.deepEqual(out.fired, ['deadmines', 'home']);
	assert.deepEqual(out.nav, [[1413, 46, 36.4, 'Wailing Caverns'], [1413, 46, 35.7, 'Nalpak']]);
	assert.deepEqual(out.g, [true, true, false]);
	assert.equal(out.opened, false);
	assert.equal(out.reason, 'off');
	assert.equal(out.list, 0);
	const [none] = run('local ok, reason = D.Load(); emit({ ok = ok, reason = reason, list = #D.List() })', { withPack: false });
	assert.equal(none.ok, false);
	assert.equal(typeof none.reason, 'string');
	assert.equal(none.list, 0);
});

test('runtime: only the open page is decoded (timing in the harness)', () => {
	const [out] = run(`
D.Load()
local t0 = os.clock()
local list = D.List()
local t1 = os.clock()
local q = D.Quests("wailing-caverns", "H")
local b = D.Bosses("wailing-caverns")
local t2 = os.clock()
local same = D.Quests("wailing-caverns") == D.Quests("wailing-caverns")
emit({ list = #list, quests = #q, bosses = #b, listMs = (t1 - t0) * 1000, pageMs = (t2 - t1) * 1000 })`);
	assert.equal(out.list, 3);
	assert.equal(out.quests, 4);
	assert.ok(out.listMs < 50 && out.pageMs < 50, `list ${out.listMs} ms, page ${out.pageMs} ms`);
});

test('runtime: a page without objective facts (an older Codex pack) keeps its English line', () => {
	const [out] = run(`
local old = D.ObjectiveText({ id = 1, objective = "Kill 5 Kobolds" })
local none = D.ObjectiveText({ id = 2 }) == nil
emit({ old, none })`);
	assert.deepEqual(out, ['Kill 5 Kobolds', true]);
});
