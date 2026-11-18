'use strict';
// The default guide window's audit fixes, in addon/Polestar/UI/GuideFrame*.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test("a finished guide's window offers the next guide as the guide-end window names it", () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		script: `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
local steps = { { goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } } }
Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "A", minLevel = 1, maxLevel = 10, next = "test/b", steps = steps })
Polestar.RegisterGuide({ id = "test/b", pack = "test", title = "Westfall", minLevel = 10, maxLevel = 17, steps = steps })
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local E, GF = Polestar.Engine, Polestar.UI.GuideFrame
E.SetGuide("test/a")
E.Skip()
GF.Render(); GF.Layout(); stub.advance(1)
local empty = GF.parts.empty
emit({ shown = empty:IsShown(), text = empty.Text:GetText(), go = empty.Primary:IsShown() and empty.Primary.Label:GetText() })`,
	}).emitted;
	assert.equal(out.shown, true, 'the complete page');
	assert.match(out.text, /^Next: \|c[0-9a-f]{8}Westfall \(10–17\)\|r$/);
	assert.equal(out.go, 'Continue', 'the window holds the button');
});
