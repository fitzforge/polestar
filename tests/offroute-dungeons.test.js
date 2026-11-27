'use strict';
// #4288: "N quests aren't part of your route" can leave dungeon quests out
// (guideWindow.offRouteDungeons off): a dungeon's quest, or one that leads to
// it (Dungeons.QuestMark), is kept for a later run, not counted off the route.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('the off-route list leaves dungeon quests out when Count dungeon quests is off', () => {
	const [out] = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({ id = "test/off", pack = "test", title = "Off", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } } } })
stub.login()
w.onQuest(7, nil, "Kobold Camp Cleanup")
w.onQuest(101, nil, "The Defias Brotherhood")
w.onQuest(102, nil, "Red Linen Goods")
w.onQuest(103, nil, "The Unsent Letter")
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
-- 101: a dungeon's own quest; 103: one that leads to it.
Polestar.Dungeons.QuestMark = function(q)
	if q == 101 then return { key = "deadmines" } end
	if q == 103 then return { key = "deadmines", quest = 101 } end
end
local P = Polestar.RoutePlan
local function ids()
	local list = P.OffRoute("test/off")
	if not list then return false end
	local out = {}
	for i, r in ipairs(list) do out[i] = r.quest end
	return out
end
local counted = ids()
Polestar.Set("guideWindow.offRouteDungeons", false)
local left = ids()
Polestar.Set("guideWindow.offRouteDungeons", true)
emit({ counted = counted, left = left, back = ids() })
` }).emitted;
	assert.deepEqual(out.counted, [101, 102, 103], JSON.stringify(out));
	assert.deepEqual(out.left, [102]);
	assert.deepEqual(out.back, [101, 102, 103]);
});
