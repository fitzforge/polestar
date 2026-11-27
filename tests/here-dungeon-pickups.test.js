'use strict';
// While you're here, dungeon quests you pass (behavior.whileHereDungeons,
// Dungeons/Nearby.lua, Engine Own.hereDungeons): a dungeon's quest, or the
// first open quest of its chain, the character can take now, at its giver
// near the player, for a dungeon up to Dungeons.TAKE_AHEAD levels ahead.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

// opts: on (the setting), level, floor (the dungeon's), minLevel (the quest's),
// pre (a prerequisite before it), done (that prerequisite done).
const script = (o) => `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 42.5, 36.0)
w.setLevel(${o.level})
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({ id = "test/lvl", pack = "test", title = "Leveling", category = "Leveling", minLevel = 1, maxLevel = 60,
	steps = { { goals = { { t = "goto", map = 1429, x = 70, y = 70 } } } } })
local D = Polestar.Dungeons
D.IsEnabled = function() return true end
D.List = function()
	return { { key = "hall", name = "The Hall", kind = "dungeon", minLevel = ${o.floor}, maxLevel = ${o.floor + 8}, floor = ${o.floor}, quests = { A = 1, H = 0 } } }
end
D.EnemyCapital = function() return nil end
local quest = { id = 70, title = "Into the Hall", minLevel = ${o.minLevel} }
local giver = { kind = "npc", id = 240, name = "Marshal Dughan", map = 1429, x = 42.0, y = 35.1 }
local pre = ${o.pre ? `{ { id = 71, title = "Word from the Hall", minLevel = 5 } }` : '{}'}
D.PickupPlan = function(key)
	if key ~= "hall" then return nil end
	return { take = { { quest = quest, rec = quest, giver = giver, pre = pre } } }
end
D.PreDone = function() return ${o.done === false ? 'false' : 'true'} end
D.Giver = function(pq) if pq.id == 71 then return { kind = "npc", id = 241, name = "Brother Anton", map = 1429, x = 42.2, y = 35.4 } end end
stub.login()
Polestar.Set("behavior.whileHereDungeons", ${o.on ? 'true' : 'false'}); Polestar.Set("behavior.whileHereTurnins", true); Polestar.Set("ui.shown", true)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
local E = Polestar.Engine
E.OpenTab("test/lvl", true)
stub.advance(0.6); stub.advance(0.6)
local here = {}
for _, v in ipairs(E.GetWhileHereList()) do
	if v.here == "take" then here[#here + 1] = { quest = v.index, text = v.hereText, sub = v.hereSub } end
end
emit({ here = here })`;

const run = (o) => {
	const out = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: script(o) }).emitted[0];
	return { here: Array.isArray(out.here) ? out.here : Object.values(out.here || {}) };
};

test("a dungeon quest you can take now shows as a pick-up line at its giver, naming the dungeon", () => {
	const out = run({ on: true, level: 20, floor: 28, minLevel: 18 });
	assert.equal(out.here.length, 1, JSON.stringify(out));
	assert.equal(out.here[0].quest, 70);
	assert.match(out.here[0].text, /Into the Hall/);
	assert.match(out.here[0].text, /Marshal Dughan/);
	assert.equal(out.here[0].sub, 'For The Hall (levels 28-36), to carry until then');
});

test('off by default: no dungeon pick-up line', () => {
	const out = run({ on: false, level: 20, floor: 28, minLevel: 18 });
	assert.equal(out.here.length, 0, JSON.stringify(out));
});

test('a dungeon more than 10 levels ahead, or a quest the game gives only later, shows nothing', () => {
	assert.equal(run({ on: true, level: 15, floor: 28, minLevel: 10 }).here.length, 0, 'floor 13 levels ahead');
	assert.equal(run({ on: true, level: 20, floor: 28, minLevel: 24 }).here.length, 0, 'quest from level 24');
});

test("a chain's first open quest shows in its place, once its own prerequisites are done", () => {
	const out = run({ on: true, level: 20, floor: 28, minLevel: 18, pre: true });
	assert.equal(out.here.length, 1, JSON.stringify(out));
	assert.equal(out.here[0].quest, 71);
	assert.match(out.here[0].text, /Brother Anton/);
	assert.equal(run({ on: true, level: 20, floor: 28, minLevel: 18, pre: true, done: false }).here.length, 0, 'its prerequisite not done');
});
