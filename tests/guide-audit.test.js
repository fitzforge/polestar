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
local pn = Polestar.UI.GuideFrame.PlayNext
local card, other = pn.card(), pn.other()
local snap = { shown = empty:IsShown(), text = empty.Text:GetText(), go = empty.Primary:IsShown() and empty.Primary.Label:GetText(),
	card = card:IsShown(), title = card.Title:GetText(), why = card.Why:GetText(), steps = card.Steps:GetText(),
	start = card.Start.Label:GetText(), default = card.Start.psDefault, other = other:IsShown(), otherText = other.Label:GetText(),
	height = card:GetHeight(), secondary = empty.Secondary:IsShown() }
card.Start.psAction()
snap.now = E.GetGuide().id
emit(snap)`,
	}).emitted;
	assert.equal(out.shown, true, 'the complete page');
	assert.match(out.text, /^\|c[0-9a-f]{8}A \(1–10\)\|r is done\.$/);
	assert.equal(out.go, false, 'no Continue button: the card has the Start');
	assert.equal(out.secondary, false, 'no Browse guides button');
	assert.equal(out.card, true, 'the Play next card');
	assert.match(out.title, /^Westfall \|c[0-9a-f]{8}\(10–17\)\|r$/);
	assert.match(out.why, /^Next in your route · your level \d+$/);
	assert.equal(out.start, 'Start');
	assert.equal(out.default, true, 'a gamepad starts on Start');
	assert.equal(out.other, true, 'the quiet Other guides link');
	assert.equal(out.otherText, 'Other guides');
	assert.equal(out.now, 'test/b', 'Start goes on to the next guide');
});
