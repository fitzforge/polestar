'use strict';
// A guide's tab wears its category's glyph, the one the picker's category
// list draws (UI.CATEGORY_ICON); a dungeon's guides wear the dungeon mark.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const SCRIPT = `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
local cats = { "Leveling", "Class", "Professions", "Reputation" } -- six tabs at most (Engine.MAX_TABS)
for i, c in ipairs(cats) do
	Polestar.RegisterGuide({ id = "test/g" .. i, pack = "test", title = "Guide " .. c, category = c, minLevel = 1, maxLevel = 20,
		steps = { { goals = { { t = "accept", quest = 7 + i, title = "Quest " .. i } } } } })
end
Polestar.RegisterGuide({ id = "test/dg", pack = "test", title = "Guide dungeon", category = "Leveling", dungeon = "deadmines", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 40, title = "Quest dg" } } } } })
-- A dungeon's pick-up guide: the Lookup category, the dungeon's key (Dungeons/Pickup.lua).
Polestar.RegisterGuide({ id = "test/pickup", pack = "test", title = "Deadmines: pick up the quests", category = "Lookup", dungeon = "deadmines", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 41, title = "Quest pu" } } } } })
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
Polestar.Set("guideWindow.tabs", true)
local E = Polestar.Engine
for i = 1, #cats do E.OpenTab("test/g" .. i, false) end
E.OpenTab("test/dg", false)
E.OpenTab("test/pickup", false)
stub.advance(0.6)
local GF = Polestar.UI.GuideFrame
local UI = Polestar.UI
local function draw() GF.Layout(); if GF.Render then GF.Render() end; stub.advance(1) end
local function icons()
	draw()
	local out = {}
	for _, b in ipairs(GF.tabs or {}) do
		if b:IsShown() then out[#out + 1] = (b.Icon:GetTexture() or ""):match("([%w%-]+)$") or "" end
	end
	return out
end
local shared = {}
for k, v in pairs(UI.CATEGORY_ICON) do shared[k] = v end
emit({ tabs = icons(), picker = Polestar.UI.Picker.CATEGORY_ICON == UI.CATEGORY_ICON,
	map = shared, fallback = UI.CategoryIcon("Nonsense"), dungeon = UI.CategoryIcon({ category = "Leveling", dungeon = "x" }) })`;

test('each tab wears the picker category glyph of its guide; a dungeon guide and its pick-up guide wear the dungeon mark', () => {
	const [out] = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: SCRIPT }).emitted;
	assert.equal(out.picker, true, 'the picker reads the same table');
	assert.equal(out.fallback, 'icon-level');
	assert.equal(out.dungeon, 'icon-dungeon');
	assert.equal(out.map.Collectibles, 'icon-collect');
	// the dungeon guide and the dungeon's pick-up guide (category Lookup) wear the dungeon mark
	assert.deepEqual(out.tabs, ['icon-level', 'icon-train', 'icon-craft', 'icon-rep', 'icon-dungeon', 'icon-dungeon']);
});
