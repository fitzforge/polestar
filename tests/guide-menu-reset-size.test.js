'use strict';
// The guide window's menu (UI/GuideFrameMenu.lua): "Reset window size" puts
// the window's width, scale and height cap back to their defaults.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const script = (body) => `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({ id = "test/menu", pack = "test", title = "Menu", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } } } })
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local GF = Polestar.UI.GuideFrame
GF.Layout(); stub.advance(1)
${body}`;

test('Reset window size: greyed at the defaults; after a change it puts width, scale and height cap back, the place kept', () => {
	const out = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: script(`
		local W = Polestar.Widgets
		local function row()
			local items
			local show = W.ShowMenu
			W.ShowMenu = function(_, it) items = it end
			W.HideMenu()
			GF.OpenMenu(CreateFrame("Button", nil, UIParent))
			W.ShowMenu = show
			for _, it in ipairs(items or {}) do if it.text == "Reset window size" then return it end end
		end
		local before = row()
		Polestar.Set("ui.width", 500); Polestar.Set("ui.scale", 0.7); Polestar.Set("ui.maxHeight", 0.3)
		Polestar.Set("ui.pos", { 100, 600 })
		local after = row()
		after.onClick()
		emit({ before = before and before.disabled or false, after = after.disabled or false,
			width = Polestar.Get("ui.width"), scale = Polestar.Get("ui.scale"), maxHeight = Polestar.Get("ui.maxHeight"),
			stored = Polestar.GetStored("ui.width") or false, frameW = PolestarGuideFrame:GetWidth(),
			pos = Polestar.Get("ui.pos")[1], again = row().disabled or false })`) }).emitted[0];
	assert.equal(out.before, true, 'nothing to reset at the defaults');
	assert.equal(out.after, false);
	assert.deepEqual([out.width, out.scale, out.maxHeight, out.stored], [340, 1, 0.5, false], 'back to the defaults, nothing stored');
	assert.equal(out.frameW, 340, 'the window follows');
	assert.equal(out.pos, 100, 'the window stays where it was put');
	assert.equal(out.again, true);
});
