'use strict';
// A dungeon's pick-up guide hands nothing in: with only it open in a tab, a
// finished quest of that dungeon is still one no open guide hands in
// (RoutePlan.Carried, the guide menu's hand-in row and the Quest room's
// carried list). With the dungeon's hand-in guide open, that guide hands it in.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const script = (kind) => `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setLevel(15)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({ id = "test/lvl", pack = "test", title = "Leveling", category = "Leveling", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 8, title = "Quest a" } } }, { goals = { { t = "accept", quest = 9, title = "Quest b" } } } } })
Polestar.RegisterGuide({ id = "test/dun", pack = "test", title = "Hall: ${kind}", category = "Lookup", dungeon = "hall", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 60, title = "Quest c" } } } } })
Polestar.Guides.Get("test/dun").lookup = { kind = "${kind}", id = "hall" }
local D = Polestar.Dungeons
D.Meta = function() return {} end
D.Get = function(key) if key == "hall" then return { key = "hall", name = "The Hall" } end end
D.Quests = function(key) if key == "hall" then return { { id = 50 } } end return {} end
w.accept(50, { { type = "monster", text = "Kill", need = 1 } }, "Dungeon quest")
w.finish(50)
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
local E = Polestar.Engine
E.OpenTab("test/dun", false)
E.OpenTab("test/lvl", true)
stub.advance(0.6)
Polestar.RoutePlan.Invalidate()
local active = E.GetGuide()
local list = Polestar.RoutePlan.Carried()
local ids = {}
for _, c in ipairs(list or {}) do ids[#ids + 1] = c.quest end
emit({ active = active and active.id, ready = Polestar.Compat.IsQuestReadyForTurnIn(50), carried = list and ids or "nil", n = list and #list or -1,
	status = Polestar.RoutePlan.GetTurnIn(50).status,
	describe = Polestar.RoutePlan.Describe(Polestar.RoutePlan.GetTurnIn(50)) })`;

const run = (kind) => runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: script(kind) }).emitted[0];

test('with only the dungeon pick-up guide open, its finished quest is one no open guide hands in', () => {
	const out = run('pickup');
	assert.equal(out.active, 'test/lvl');
	assert.equal(out.ready, true);
	assert.equal(out.status, 'other', 'still kept off the cleanup list');
	assert.deepEqual(out.carried, [50]);
	assert.match(out.describe, /^No turn-in in this route/, 'the caption agrees: ' + out.describe);
	assert.match(out.describe, /The Hall: hand in the quests/, "and names the dungeon's hand-in guide");
});

test('with the dungeon hand-in guide open, that guide hands it in', () => {
	const out = run('handin');
	assert.equal(out.ready, true);
	assert.equal(out.n, 0);
	assert.match(out.describe, /^Turn in at The Hall: hand in the quests/);
});

// While you're here: a finished dungeon quest at its ender near the player.
// The sub-line is set when the line is first built, so the quest is finished
// after the tabs are open.
const hereScript = (kind) => `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 42.5, 36.0)
w.setLevel(15)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({ id = "test/lvl", pack = "test", title = "Leveling", category = "Leveling", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "goto", map = 1429, x = 70, y = 70 } } } } })
Polestar.RegisterGuide({ id = "test/dun", pack = "test", title = "Hall: ${kind}", category = "Lookup", dungeon = "hall", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 60, title = "Quest c" } } } } })
Polestar.Guides.Get("test/dun").lookup = { kind = "${kind}", id = "hall" }
local D = Polestar.Dungeons
D.Meta = function() return {} end
D.Get = function(key) if key == "hall" then return { key = "hall", name = "The Hall" } end end
D.Quests = function(key) if key == "hall" then return { { id = 50 } } end return {} end
local X = Polestar.Codex
X.Load = function() return true end
X.IsLoaded = function() return true end
X.Quest = function(id) return { id = id, title = "Quest " .. id, faction = "A", level = 14, xp = 1000, ["end"] = id == 50 and { npc = { 240 } } or nil } end
Polestar.Lookup.QuestEnd = function(ends)
	if ends and ends.npc and ends.npc[1] == 240 then return { npc = 240, name = "Marshal Dughan", spawn = { map = 1429, x = 42.0, y = 35.1 } } end
end
w.accept(50, { { type = "monster", text = "Kill", need = 1 } }, "Dungeon quest")
stub.login()
Polestar.Set("behavior.whileHereTurnins", true); Polestar.Set("ui.shown", true)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
local E = Polestar.Engine
E.OpenTab("test/dun", false)
E.OpenTab("test/lvl", true)
stub.advance(0.6)
w.finish(50)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6); stub.advance(0.6)
Polestar.RoutePlan.Invalidate()
stub.advance(0.6)
local here = {}
for _, v in ipairs(E.GetWhileHereList()) do if v.index == 50 then here[#here + 1] = v.hereSub or false end end
emit({ here = here })`;

test("While you're here: with only the pick-up guide open, the dungeon quest is not handed in on the route ahead; with the hand-in guide, later", () => {
	const pickup = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: hereScript('pickup') }).emitted[0];
	assert.deepEqual(pickup.here, ['Not handed in on the route ahead'], JSON.stringify(pickup));
	const handin = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: hereScript('handin') }).emitted[0];
	assert.deepEqual(handin.here, ['Handed in later on the route'], 'with the hand-in guide open it is: ' + JSON.stringify(handin));
});
