'use strict';
// The other-tab card (#2783, UI/OtherTab.lua): with two tabs open, the
// active tab's window shows a card once the other tab's next step is within
// 30 yd, keeps it until that step is past 300 yd, switches to that tab on a
// click, and shows nothing with guideWindow.otherTabNear off.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

// Map 1429 is 3000 yd wide: 1 of x is 30 yd. The other tab's step is at
// 50, 50; the active one's far off.
const SCRIPT = `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
local function at(yd) w.moveTo(1429, 50 + yd / 30, 50) end
at(400)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({ id = "test/main", pack = "test", title = "Main", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "goto", map = 1429, x = 10, y = 90, r = 5 } } } } })
Polestar.RegisterGuide({ id = "test/side", pack = "test", title = "Side Trip", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "goto", map = 1429, x = 50, y = 50, r = 5 } } } } })
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local E, GF, OT = Polestar.Engine, Polestar.UI.GuideFrame, Polestar.UI.OtherTabCard
E.OpenTab("test/main", true)
E.OpenTab("test/side", false)
local function active() local _, a = E.GetTabs() return E.GetTabs()[a].guideId end
local function draw() GF.Layout(); if GF.Render then GF.Render() end; stub.advance(1.1); GF.Layout() end
local function shown()
	local f = OT.Frame()
	return (OT.Shown() and f and f:IsVisible()) and true or false
end
draw()
`;

const run = (script, addons = ['Polestar']) => runAddon({ stubs: ['stub_world.lua'], addons, script: `${SCRIPT}\n${script}` }).emitted[0];

test('shown within 30 yd, kept to 300 yd, hidden past it', () => {
	const out = run(`
local r = { active = active() }
r.far = shown()
at(25) draw() r.near = shown()
r.title = OT.Frame().Title:GetText()
local _, _, _, _, py = GF.parts.person:GetPoint(1)
r.under = -(py or 0) >= OT.Frame():GetHeight()
at(100) draw() r.mid = shown()
at(350) draw() r.gone = shown()
at(100) draw() r.back = shown()
emit(r)`);
	assert.equal(out.active, 'test/main');
	assert.equal(out.far, false, 'not at 400 yd');
	assert.equal(out.near, true, 'shown at 25 yd');
	assert.match(out.title, /Side Trip/, 'names the other tab');
	assert.equal(out.under, true, 'the step\'s header sits under the card');
	assert.equal(out.mid, true, 'kept at 100 yd');
	assert.equal(out.gone, false, 'hidden at 350 yd');
	assert.equal(out.back, false, 'not again at 100 yd until within 30');
});

test('a click switches to the other tab', () => {
	const out = run(`
at(25) draw()
local before = shown()
stub.RunScript(OT.Frame(), "OnClick", "LeftButton")
draw()
emit({ before = before, active = active() })`);
	assert.equal(out.before, true);
	assert.equal(out.active, 'test/side');
});

test('the setting off hides it', () => {
	const out = run(`
at(25) draw()
local before = shown()
Polestar.Set("guideWindow.otherTabNear", false) draw()
local off = shown()
Polestar.Set("guideWindow.otherTabNear", true) draw()
emit({ before = before, off = off, on = shown() })`);
	assert.deepEqual(out, { before: true, off: false, on: true });
});
