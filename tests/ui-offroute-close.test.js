'use strict';
// The guide window's off-route line ("3 quests aren't part of your route"):
// its × closes it, and it comes back when more quests are off the route.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('the off-route line closes with its × and comes back with more quests off the route', () => {
	const [out] = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({ id = "test/off", pack = "test", title = "Off", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } },
		{ goals = { { t = "accept", quest = 33, title = "Wolves Across the Border" } } } } })
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local off = { { quest = 101, title = "A" }, { quest = 102, title = "B" }, { quest = 103, title = "C" } }
Polestar.RoutePlan.OffRoute = function() return off end
local GF = Polestar.UI.GuideFrame
local F = _G.PolestarGuideFrame
local function line()
	local found
	local function walk(f)
		for _, c in ipairs({ f:GetChildren() }) do
			if type(c) == "table" then
				if rawget(c, "psRoom") and c:IsShown() then found = c end
				walk(c)
			end
		end
	end
	walk(F)
	return found
end
local function step(i) GF.LookAt(i); stub.advance(0.5); GF.Refill(); stub.advance(0.5) end
step(2)
local before = line()
local closeShown = before and before.Close and before.Close:IsShown() or false
if before and before.Close then before.Close:GetScript("OnClick")(before.Close, "LeftButton") end
stub.advance(0.5)
local after = line()
-- Same count on another step: still closed. One more off the route: back.
step(1)
local same = line()
off[4] = { quest = 104, title = "D" }
step(2)
local more = line()
emit({ before = before ~= nil, closeShown = closeShown, after = after ~= nil, same = same ~= nil, more = more ~= nil })` }).emitted;
	assert.deepEqual(out, { before: true, closeShown: true, after: false, same: false, more: true });
});
