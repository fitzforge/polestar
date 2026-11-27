'use strict';
// The dungeon kind (docs/DESIGN.md, "The Guide Window" and "The Dungeon Tracker"): outside, the window's
// regions (Core/KindDungeon.lua: the picture and name, one line only under the dungeon's floor, the way in
// with a key still missing; no range chip, group row or "Quests for the run"); inside, the run
// (Dungeons/Run.lua: bosses checked off as they die, "Loot <item> from <boss>" until it is in the bags,
// three minutes pass or the next boss is pulled) and the tracker (UI/DungeonTracker.lua: it shows while
// the guide window waits out the dungeon, docks into the window when that is shown, hides on leaving).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

// A Wailing Caverns of our own: two bosses with encounter ids, one (Skum) without, one optional.
const WORLD = `
local w = stub.world
w.level, w.race, w.raceName, w.faction = 19, "Tauren", "Tauren", "Horde"
w.class, w.className = "WARRIOR", "WARRIOR"
w.addMap(1413, { name = "The Barrens", c = 1, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.addMap(1456, { name = "Thunder Bluff", c = 1, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.moveTo(1413, 52, 30)
local Z = { [1413] = "bar", [1456] = "tb" }
Polestar.TravelCost = function(a, b)
	local za, zb = Z[a.map], Z[b.map]
	if not (za and zb) then return nil end
	if za == zb then return 5 + 4 * (math.abs(a.x - b.x) + math.abs(a.y - b.y)) end
	return 900
end
local NPCS = {
	[3446] = { id = 3446, name = "Ebru", faction = "H", spawns = { { map = 1413, x = 46, y = 36 } } },
	[5767] = { id = 5767, name = "Nara Wildmane", faction = "H", spawns = { { map = 1456, x = 75, y = 31 } } },
}
local QUESTS = {
	[1486] = { id = 1486, title = "Deviate Hides", level = 22, minLevel = 17, faction = "H",
		start = { npc = { 3446 }, object = {}, item = {} }, ["end"] = { npc = { 3446 }, object = {} },
		objectives = { { type = "item", id = 6443, count = 20, text = "Deviate Hide" } }, pre = {}, preAny = {} },
	[914] = { id = 914, title = "Leaders of the Fang", level = 22, minLevel = 18, faction = "H",
		start = { npc = { 5767 }, object = {}, item = {} }, ["end"] = { npc = { 5767 }, object = {} },
		objectives = { { type = "item", id = 9738, count = 1, text = "Gem of Cobrahn" }, { type = "item", id = 9739, count = 1, text = "Gem of Anacondra" } },
		pre = {}, preAny = {} },
	[1491] = { id = 1491, title = "Smart Drinks", level = 18, minLevel = 13, faction = "H",
		start = { npc = { 3446 }, object = {}, item = {} }, ["end"] = { npc = { 3446 }, object = {} },
		objectives = { { type = "item", id = 5056, count = 6, text = "Wailing Essence" } }, pre = {}, preAny = {} },
	[7001] = { id = 7001, title = "Skum's Fin", level = 20, minLevel = 15, faction = "H",
		start = { npc = { 3446 }, object = {}, item = {} }, ["end"] = { npc = { 3446 }, object = {} },
		objectives = { { type = "kill", id = 3674, count = 1, text = "Skum" } }, pre = {}, preAny = {} },
}
local PAGE = {
	key = "wailing-caverns", name = "Wailing Caverns", map = 43, minLevel = 17, maxLevel = 24, floor = 17, players = 5,
	zone = 1413, zoneName = "The Barrens", entrance = { map = 1413, x = 46.0, y = 36.0 },
	quests = {
		{ id = 1486, title = "Deviate Hides", faction = "Horde", level = 22, minLevel = 17, chain = {},
			objectives = { { k = "item", id = 6443, n = 20, name = "Deviate Hide" } } },
		{ id = 914, title = "Leaders of the Fang", faction = "Horde", level = 22, minLevel = 18, chain = {},
			objectives = { { k = "item", id = 9738, n = 1, name = "Gem of Cobrahn" }, { k = "item", id = 9739, n = 1, name = "Gem of Anacondra" } } },
		{ id = 1491, title = "Smart Drinks", faction = "Horde", level = 18, minLevel = 13, chain = {},
			objectives = { { k = "item", id = 5056, n = 6, name = "Wailing Essence" } } },
	},
}
local BOSSES = {
	{ order = 1, name = "Lady Anacondra", npc = 3671, encounter = 585, quests = { { id = 914, how = "item", item = 9739, itemName = "Gem of Anacondra" } } },
	{ order = 2, name = "Lord Cobrahn", npc = 3669, encounter = 586, quests = { { id = 914, how = "item", item = 9738, itemName = "Gem of Cobrahn" } } },
	{ order = 3, name = "Skum", npc = 3674 },
	{ order = 4, name = "Mutanus the Devourer", npc = 3654, encounter = 593, quests = { { id = 6981, how = "starts", item = 10441, itemName = "Glowing Shard" } } },
	{ order = 5, name = "Deviate Faerie Dragon", npc = 5912, role = "rare" },
}
local C = Polestar.Codex
C.Ready = function() return true end
C.Load = function() return true end
C.Quest = function(id) return QUESTS[id] end
C.Npc = function(id) return NPCS[id] end
C.Object = function() return nil end
C.Item = function() return nil end
local BY_ID = {}
for _, q in ipairs(PAGE.quests) do BY_ID[q.id] = q end
local D = Polestar.Dungeons
D.Load = function() return true end
D.Get = function(key) return key == PAGE.key and PAGE or nil end
D.List = function() return { PAGE } end
D.ForMap = function(map) return map == 43 and PAGE.key or nil end
D.Find = function(t) return (t == PAGE.name or t == PAGE.key) and PAGE.key or nil end
D.Quests = function(key) return key == PAGE.key and PAGE.quests or {} end
D.Quest = function(key, id) return key == PAGE.key and BY_ID[id] or nil end
D.Bosses = function(key) return key == PAGE.key and BOSSES or {} end
D.BestAt = function() return 20 end
D.Entrance = function() return 1413, 46.0, 36.0 end
D.Attunements = function() return ATTUNE or {} end
D.AttunementState = function(a) return { done = a.done } end
-- Inside: the stub's IsInInstance, and the instance's map.
Polestar.Compat.GetInstanceMapID = function() return w.inInstance and 43 or nil end
function enter()
	w.inInstance = true
	stub.fire("PLAYER_ENTERING_WORLD", false, false)
	stub.advance(0.3)
end
function leave()
	w.inInstance = false
	stub.fire("PLAYER_ENTERING_WORLD", false, false)
	stub.advance(0.3)
end
`;

const run = (script, opts = {}) => runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], login: true, script: WORLD + script, ...opts }).emitted;

test('inside: a boss with an encounter id dies, its gem is a loot reminder until the gem is in the bags', () => {
	const [m0, m1, m2] = run(`
w.onQuest(914, { { text = "Gem of Cobrahn: 0/1", type = "item", required = 1 }, { text = "Gem of Anacondra: 0/1", type = "item", required = 1 } }, "Leaders of the Fang")
enter()
local R = Polestar.Dungeons.Run
local function pick(m)
	local b = {}
	for _, x in ipairs(m.bosses) do b[#b + 1] = x.name .. ":" .. x.state end
	local loot = {}
	for _, e in ipairs(m.loot) do loot[#loot + 1] = e.itemName .. " from " .. e.boss .. " for " .. e.questTitle end
	local o = {}
	for _, q in ipairs(m.quests) do for _, x in ipairs(q.objectives) do o[#o + 1] = x.text .. " " .. x.cur .. "/" .. x.max .. " " .. tostring(x.boss) .. (x.pending and " pending" or "") end end
	return { bosses = b, loot = loot, done = m.bossesDone, total = m.bossesTotal, obj = o }
end
emit(pick(R.Model()))
stub.fire("ENCOUNTER_END", 586, "Lord Cobrahn", 1, 5, 1)
emit(pick(R.Model()))
w.items[9738] = 1
stub.fire("BAG_UPDATE_DELAYED")
emit(pick(R.Model()))
`);
	assert.deepEqual(m0.bosses, ['Lady Anacondra:next', 'Lord Cobrahn:ahead', 'Skum:ahead', 'Mutanus the Devourer:ahead', 'Deviate Faerie Dragon:ahead']);
	assert.equal(m0.total, 4, 'the rare after the encounters does not count');
	assert.deepEqual(m0.obj, ['Gem of Cobrahn 0/1 Lord Cobrahn', 'Gem of Anacondra 0/1 Lady Anacondra']);
	assert.deepEqual(m1.loot, ['Gem of Cobrahn from Lord Cobrahn for Leaders of the Fang']);
	assert.equal(m1.done, 1);
	assert.ok(m1.bosses.includes('Lord Cobrahn:dead'));
	assert.ok(m1.obj.includes('Gem of Cobrahn 0/1 Lord Cobrahn pending'));
	assert.equal(Object.keys(m2.loot).length, 0, 'looted: the reminder goes');
});

test('inside: the reminder goes after three minutes, or when the next boss is pulled; a boss without an encounter id dies in the combat log', () => {
	const [timed, pulled, skum] = run(`
w.onQuest(914, { { text = "Gem of Cobrahn: 0/1", type = "item", required = 1 }, { text = "Gem of Anacondra: 0/1", type = "item", required = 1 } }, "Leaders of the Fang")
w.onQuest(7001, { { text = "Skum slain: 0/1", type = "monster", required = 1 } }, "Skum's Fin")
enter()
local R = Polestar.Dungeons.Run
stub.fire("ENCOUNTER_END", 586, "Lord Cobrahn", 1, 5, 1)
stub.advance(181)
emit(#R.Model().loot)
stub.fire("ENCOUNTER_END", 585, "Lady Anacondra", 1, 5, 1)
local before = #R.Model().loot
stub.fire("ENCOUNTER_START", 593, "Mutanus the Devourer", 1, 5)
emit({ before = before, after = #R.Model().loot })
CombatLogGetCurrentEventInfo = function() return 0, "UNIT_DIED", false, nil, nil, 0, 0, "Creature-0-1-43-1-3674-000000AB" end
stub.fire("COMBAT_LOG_EVENT_UNFILTERED")
local states = {}
for _, b in ipairs(R.Model().bosses) do states[b.name] = b.state end
emit(states)
`);
	assert.equal(timed, 0);
	assert.deepEqual(pulled, { before: 1, after: 0 });
	assert.equal(skum.Skum, 'dead');
	assert.equal(skum['Lady Anacondra'], 'dead');
});

test('inside: no quest held for the instance, no tracker; the kills are kept over a reload of the same run', () => {
	const out = run(`
enter()
local R = Polestar.Dungeons.Run
emit(R.Model() == nil)
w.onQuest(914, { { text = "Gem of Cobrahn: 0/1", type = "item", required = 1 }, { text = "Gem of Anacondra: 0/1", type = "item", required = 1 } }, "Leaders of the Fang")
stub.fire("ENCOUNTER_END", 585, "Lady Anacondra", 1, 5, 1)
stub.fire("PLAYER_ENTERING_WORLD", false, true)
stub.advance(0.3)
emit(R.Model().bossesDone)
`);
	assert.deepEqual(out, [true, 1]);
});

test('the tracker shows inside while the guide window waits out the dungeon, docks into the window when it is shown, and hides on leaving', () => {
	const out = run(`
w.onQuest(914, { { text = "Gem of Cobrahn: 0/1", type = "item", required = 1 }, { text = "Gem of Anacondra: 0/1", type = "item", required = 1 } }, "Leaders of the Fang")
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide({ id = "test/barrens", pack = "test", title = "The Barrens", minLevel = 17, maxLevel = 21,
	steps = { { goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } } } })
Polestar.Engine.SetGuide("test/barrens")
Polestar.Set("ui.shown", true)
Polestar.Set("ui.instance", "hide")
enter()
stub.advance(0.5)
local T = _G.PolestarDungeonTracker
local GF = Polestar.UI.GuideFrame
local F = _G.PolestarGuideFrame
emit({ tracker = T and T:IsShown() or false, window = F and F:IsShown() or false })
GF.ToggleInside()
stub.advance(0.5)
GF.Render()
emit({ tracker = T:IsShown(), window = F:IsShown(), docked = GF.RegionShown("tracker") })
leave()
stub.advance(0.5)
emit({ tracker = T:IsShown() })
`);
	assert.deepEqual(out[0], { tracker: true, window: false });
	assert.deepEqual(out[1], { tracker: false, window: true, docked: true });
	assert.deepEqual(out[2], { tracker: false });
});

test('inside, the guide window hidden: a quest here used with an item in the bags puts it on the quest item button', () => {
	const [out] = run(`
QUESTS[7001].objectives[1].useItem = 5000
w.items[5000] = 1
w.onQuest(7001, { { text = "Skum slain: 0/1", type = "monster", required = 1 } }, "Skum's Fin")
Polestar.Set("ui.shown", true)
Polestar.Set("ui.instance", "hide")
enter()
stub.advance(1)
local b = _G.PolestarQuestItemButton
emit({ item = Polestar.UI.DungeonTracker.UseItem(), shown = b and b:IsShown() or false, button = b and b.itemID or false })
`);
	assert.deepEqual(out, { item: 5000, shown: true, button: 5000 });
});

test('in a fight the counts update but the tracker keeps its height until the fight ends', () => {
	const [out] = run(`
w.onQuest(914, { { text = "Gem of Cobrahn: 0/1", type = "item", required = 1 }, { text = "Gem of Anacondra: 0/1", type = "item", required = 1 } }, "Leaders of the Fang")
Polestar.Set("ui.shown", false)
enter()
stub.advance(0.5)
local T = _G.PolestarDungeonTracker
local before = T:GetHeight()
stub.inCombat = true
stub.fire("PLAYER_REGEN_DISABLED")
-- Both gems: the quest folds to one line, so the tracker would shrink.
w.progress(914, 1, 1)
w.progress(914, 2, 1)
stub.advance(0.5)
local during = T:GetHeight()
local texts = {}
for _, r in ipairs(Polestar.UI.DungeonTracker.Model().quests) do texts[#texts + 1] = tostring(r.done) end
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
stub.advance(0.5)
emit({ before = before, during = during, after = T:GetHeight(), done = table.concat(texts, ",") })
`);
	assert.equal(out.during, out.before, 'no jump mid-pull');
	assert.equal(out.done, 'true', 'the counts kept up');
	assert.ok(out.after < out.before, `shrinks once the fight ends: ${out.before} -> ${out.after}`);
});

const OUTSIDE = `
local E = Polestar.Engine
local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
`;

test('outside: the pick-up guide is a dungeon guide of the picture and name and the step: no range chip, group row, "Quests for the run" or entrance region', () => {
	const [out] = run(OUTSIDE + `
Polestar.Set("ui.shown", true)
Polestar.Dungeons.PickUp("wailing-caverns")
stub.advance(0.5)
local GF = Polestar.UI.GuideFrame
GF.Render() GF.Layout()
local function look()
	local shown = {}
	for _, id in ipairs({ "brief", "ready", "pickups", "entrance" }) do shown[id] = GF.RegionShown(id) end
	local texts = {}
	local function add(fs) if fs and fs:IsShown() then texts[#texts + 1] = plain(fs:GetText()) end end
	local brief, ready = GF.RegionFrame("brief"), GF.RegionFrame("ready")
	if GF.RegionShown("brief") then add(brief.Name); if brief.Line:IsShown() then add(brief.Line.Text) end end
	if GF.RegionShown("ready") then add(ready.Level.Text) end
	return { shown = shown, texts = texts }
end
local rows = {}
for _, r in ipairs(GF.rows) do
	if r:IsShown() and r.psGoal then rows[#rows + 1] = r.psGoal.t end
end
local standard = look()
local brief = GF.RegionFrame("brief")
local chip = { range = rawget(brief, "Range") ~= nil, facts = rawget(brief, "Facts") ~= nil }
Polestar.Set("ui.compact", true)
GF.Render() GF.Layout()
emit({ kind = E.GuideKind(), standard = standard, compact = look(), chip = chip, rows = rows,
	hasPickups = GF.RegionFrame("pickups") ~= nil, hasEntrance = GF.RegionFrame("entrance") ~= nil,
	models = { E.KindModel("pickups", nil, "dungeon") ~= nil, E.KindModel("entrance", nil, "dungeon") ~= nil } })
`);
	assert.equal(out.kind, 'dungeon');
	assert.deepEqual(out.standard.shown, { brief: true, ready: false, pickups: false, entrance: false }, 'level 19 is over the floor of 17: the brief alone');
	assert.deepEqual(out.compact.shown, { brief: true, ready: false, pickups: false, entrance: false });
	assert.deepEqual(out.chip, { range: false, facts: false }, 'the brief is the picture and the name alone');
	assert.equal(out.hasPickups, false);
	assert.equal(out.hasEntrance, false, 'no entrance region: the way in is the pick-up guide\'s last step');
	assert.deepEqual(out.models, [false, false], 'no pickups or entrance model any more');
	assert.deepEqual(out.standard.texts, ['Wailing Caverns']);
	for (const t of out.compact.texts) assert.doesNotMatch(t, /Quests for the run|your level|Group|best at|Level \d|Entrance/, `nothing the hub already shows: ${t}`);
	assert.ok(out.rows.length >= 1 && out.rows.every((t) => t === 'accept'), `the step's own accepts: ${out.rows}`);
});

test('outside: no ready row at or above the floor; under it, one line "Level 15: come back at 17" in Standard and Compact', () => {
	const [at, under, atFloor] = run(OUTSIDE + `
Polestar.Set("ui.shown", true)
Polestar.Dungeons.PickUp("wailing-caverns")
stub.advance(0.5)
local GF = Polestar.UI.GuideFrame
local function ready()
	GF.Render() GF.Layout()
	local f = GF.RegionFrame("ready")
	return { shown = GF.RegionShown("ready"), model = E.KindModel("ready", nil, "dungeon") ~= nil,
		text = f and GF.RegionShown("ready") and plain(f.Level.Text:GetText()) or false, h = f and GF.RegionShown("ready") and f:GetHeight() or 0 }
end
emit(ready())
w.level = 15
local standard = ready()
Polestar.Set("ui.compact", true)
local compact = ready()
w.level = 17
emit({ standard = standard, compact = compact })
emit(ready())
`);
	assert.deepEqual(at, { shown: false, model: false, text: false, h: 0 }, 'level 19, floor 17');
	assert.equal(under.standard.shown, true);
	assert.equal(under.standard.text, 'Level 15: come back at 17');
	assert.equal(under.compact.shown, true);
	assert.equal(under.compact.text, 'Level 15: come back at 17');
	assert.ok(under.standard.h > 0 && under.standard.h <= 24, `one 24px line: ${under.standard.h}`);
	assert.equal(atFloor.shown, false, 'level 17 is the floor itself: not under it');
});

test('outside: the way in is the last step\'s row; its sub-line says the instance count only at 4 of 5 and 5 of 5', () => {
	const [out] = run(OUTSIDE + `
Polestar.Set("ui.shown", true)
Polestar.Dungeons.PickUp("wailing-caverns")
stub.advance(0.5)
local GF = Polestar.UI.GuideFrame
E.Goto(E.GetStepCount())
stub.advance(0.6)
local function way(used)
	Polestar.Maps.GetInstanceStatus = function() return { inHour = used, perHour = 5 } end
	GF.Render() GF.Layout()
	for _, r in ipairs(GF.rows) do
		if r:IsShown() and r.psGoal and r.psGoal.t == "goto" then
			return { text = plain(r.Text:GetText()), sub = r.Sub:IsShown() and plain(r.Sub:GetText()) or false }
		end
	end
	return false
end
local out = {}
for used = 0, 5 do out[used + 1] = way(used) end
emit({ out = out, entrance = GF.RegionShown("entrance") })
`);
	assert.equal(out.entrance, false);
	for (const used of [0, 1, 2, 3]) assert.ok(out.out[used] && !/instances this hour/.test(out.out[used].sub || ''), `${used} of 5: no count line: ${JSON.stringify(out.out[used])}`);
	for (const used of [4, 5]) assert.match(out.out[used].sub, new RegExp(`instances this hour: ${used} of 5`), `${used} of 5 says it`);
	assert.match(out.out[0].text, /Wailing Caverns/, 'the way in is a plain goal row');
});

test('outside: a key still missing is a step of its own before the way in; none once it is owned', () => {
	const [missing, withSteps, owned] = run(OUTSIDE + `
local function steps(attune)
	ATTUNE = attune
	local def = Polestar.Dungeons.PickupGuide("wailing-caverns")
	local out = {}
	for i, s in ipairs(def.steps) do
		local kinds = {}
		for _, g in ipairs(s.goals) do kinds[#kinds + 1] = g.t .. (g.entrance and ":entrance" or "") end
		out[i] = { s.title, table.concat(kinds, ",") }
	end
	return out
end
local KEY = { kind = "key", name = "Prison Cell Key", item = { name = "Prison Cell Key" }, done = false }
-- The page lists no steps for it (the attunement guide builds none): one step naming it.
Polestar.Dungeons.AttuneGuide = function() return nil, "nothing" end
emit(steps({ KEY }))
-- The attunement guide's steps, less its closing way in: the steps come before this guide's own.
Polestar.Dungeons.AttuneGuide = function()
	return { steps = { { title = "Cell Keeper", goals = { { t = "accept", quest = 7001 } } },
		{ title = "Wailing Caverns", goals = { { t = "note", text = "Not open yet." }, { t = "goto", entrance = true, map = 1413, x = 46, y = 36 } } } } }
end
emit(steps({ KEY }))
KEY.done = true
emit(steps({ KEY }))
`);
	const last = (s) => s[s.length - 1];
	assert.deepEqual(last(missing), ['Wailing Caverns', 'goto:entrance,note'], 'the way in stays last');
	assert.deepEqual(missing[missing.length - 2], ['Prison Cell Key', 'note'], 'a step naming the key, just before the way in');
	assert.deepEqual(withSteps[withSteps.length - 2], ['Cell Keeper', 'accept,note'], "the attunement guide's step, its closing notes kept on it");
	assert.ok(!withSteps.some((s) => s[0] === 'Wailing Caverns' && s[1] === 'note,goto:entrance'), 'its own closing step is dropped for this guide\'s');
	assert.ok(!owned.some((s) => s[0] === 'Prison Cell Key' || s[0] === 'Cell Keeper'), 'no key step once the key is owned');
});

test('outside: under the floor and alone', () => {
	const [ready] = run(OUTSIDE + `
w.level = 15
emit(E.KindModel("ready", { guide = { dungeon = "wailing-caverns" } }, "dungeon"))
`);
	assert.deepEqual(ready, { level: 15, floor: 17 });
});

test('docked: the head names the dungeon unless the open guide is its own; an item boss row shows its glyph and names the item on hover', () => {
	const [other, own] = run(`
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide({ id = "test/barrens", pack = "test", title = "The Barrens", minLevel = 17, maxLevel = 21,
	steps = { { goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } } } })
Polestar.Engine.SetGuide("test/barrens")
Polestar.Set("ui.shown", true)
local GF = Polestar.UI.GuideFrame
Polestar.UI.DungeonTracker.ShowSample(true)
stub.advance(0.5)
GF.Render()
local function look()
	local v = GF.RegionFrame("tracker").psView
	local rows = {}
	for i = 1, v.Bosses.n do
		local r = v.Bosses.Lines[i]
		rows[i] = { text = r.Right:GetText() or "", glyph = r.RightIcon:IsShown(), hit = r.Hit:IsShown(), tip = r.Hit.psTip }
	end
	return { head = v.Head:IsShown(), name = v.Head.Name:GetText(), right = v.Bosses.Right:GetText(), rows = rows }
end
emit(look())
Polestar.Dungeons.PickUp("wailing-caverns")
stub.advance(0.5)
GF.Render()
emit(look())
`);
	assert.equal(other.head, true, 'a leveling guide open: the head says which dungeon the list is');
	assert.equal(other.name, 'Wailing Caverns');
	assert.match(other.right, /in kill order/);
	assert.equal(own.head, false, "the dungeon's own guide names it in its tab");
	assert.match(own.right, /^2 \/ 8/, 'and the count and time move to the bosses heading');
	// Anacondra (dead, item): the glyph alone, the item on hover; Cobrahn (loot pending) and Mutanus (starts a quest) say it.
	assert.deepEqual(other.rows[0], { text: '', glyph: true, hit: true, tip: 'Gem of Anacondra' });
	assert.match(other.rows[1].text, /loot it/);
	assert.equal(other.rows[1].hit, false);
	assert.match(other.rows[7].text, /starts a quest/);
});
