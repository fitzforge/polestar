'use strict';
// A fixed guide-window height (ui.heightMode "fixed", ui.height): the window
// is exactly that tall whatever the step holds, a long step's goals scroll
// inside it, in full and compact mode and with the gamepad's focus. "auto"
// keeps the window fitting the step. The grip drags the fixed height.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

// A guide whose first step is short and second long (a goal per quest).
const GUIDE = `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
local long = {}
for i = 1, 24 do long[i] = { t = "accept", quest = 100 + i, title = "Long Quest Number " .. i, npc = 197, npcName = "Marshal McBride" } end
Polestar.RegisterGuide({
	id = "test/fixed", pack = "test", title = "Fixed", minLevel = 1, maxLevel = 20,
	steps = {
		{ goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } },
		{ goals = long },
	},
})
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
local GF, F = Polestar.UI.GuideFrame, PolestarGuideFrame
Polestar.Set("ui.shown", true)
Polestar.Set("ui.wholeStep", true)
local function at(n)
	local E = Polestar.Engine
	for _ = 1, 4 do
		local i = E.GetStepIndex()
		if i == n then break elseif i < n then E.Next() else E.Prev() end
		stub.advance(0.6)
	end
	GF.Render(); GF.Layout(); stub.advance(1); GF.Layout()
	local goals = GF.parts.goals
	return { h = math.floor(F:GetHeight() + 0.5), over = goals.psOver and true or false }
end`;

function run(addons, script) {
	return runAddon({ stubs: ['stub_world.lua'], addons, script: `${GUIDE}\n${script}` }).emitted;
}

const combos = [];
for (const compact of [false, true]) combos.push({ compact });

for (const { compact } of combos) {
	const name = compact ? 'compact' : 'full';
	test(`fixed height: the window keeps its height with a short and a long step, the long one scrolls (${name})`, () => {
		const [out] = run(['Polestar'], `
Polestar.Set("ui.compact", ${compact})
local auto = { short = at(1), long = at(2) }
Polestar.Set("ui.heightMode", "fixed")
Polestar.Set("ui.height", 420)
local fixed = { short = at(1), long = at(2) }
Polestar.Set("ui.height", 260)
local small = at(2)
Polestar.Set("ui.height", 5)
local floor = at(1)
emit({ auto = auto, fixed = fixed, small = small, floor = floor, min = Polestar.UI.MIN_HEIGHT })`);
		assert.ok(out.auto.short.h < out.auto.long.h, `auto fits the step: ${out.auto.short.h} < ${out.auto.long.h}`);
		assert.equal(out.fixed.short.h, 420, 'a short step: the window stays the fixed height');
		assert.equal(out.fixed.long.h, 420, 'a long step: the window stays the fixed height');
		assert.equal(out.fixed.short.over, false, 'nothing to scroll on a short step');
		assert.equal(out.fixed.long.over, true, 'the long step scrolls inside');
		assert.deepEqual(out.small, { h: 260, over: true }, 'a new height applies at once');
		assert.equal(out.floor.h, out.min, 'never under UI.MIN_HEIGHT');
	});
}

test('fixed height ignores the height cap; auto keeps it; a stored mode wins over the default', () => {
	const [out] = run(['Polestar'], `
Polestar.Set("ui.maxHeight", 0.3)
local capped = at(2)
Polestar.Set("ui.heightMode", "fixed")
Polestar.Set("ui.height", 700)
local fixed = at(2)
emit({ capped = capped, cap = math.floor(GF.CapHeight() + 0.5), fixed = fixed, stored = Polestar.GetStored("ui.heightMode") })`);
	assert.ok(out.capped.h <= out.cap, `auto stays under the cap: ${out.capped.h} <= ${out.cap}`);
	assert.equal(out.fixed.h, 700, 'fixed: the set height, past the cap');
	assert.equal(out.stored, 'fixed');
});

test('in fixed mode the grip drags the height and saves ui.height; in auto it leaves the height alone', () => {
	const [out] = run(['Polestar'], `
local grip
for _, c in ipairs({ F:GetChildren() }) do if c:GetScript("OnMouseDown") == GF.ResizeStart then grip = c end end
assert(grip, "the grip")
local function drag(dy)
	stub.cursor = { 900, 500 }
	GF.ResizeStart(grip)
	stub.cursor = { 900, 500 - dy * F:GetEffectiveScale() }
	grip:GetScript("OnUpdate")(grip, 0.1)
	GF.ResizeStop(grip)
end
at(1)
drag(80)
local autoStored = Polestar.GetStored("ui.height") or false
Polestar.Set("ui.heightMode", "fixed")
Polestar.Set("ui.height", 400)
at(1)
drag(80)
emit({ autoStored = autoStored, height = Polestar.Get("ui.height"), h = math.floor(F:GetHeight() + 0.5), drag = GF.dragHeight or false })`);
	assert.equal(out.autoStored, false, 'auto: no height saved');
	assert.equal(out.height, 480, 'fixed: the drag saved');
	assert.equal(out.h, 480, 'the window follows');
	assert.equal(out.drag, false, 'no drag height left behind');
});

test('fixed height holds through the gamepad focus and Minimize', () => {
	const [out] = runAddon({
		stubs: ['stub_ui.lua', 'stub_gamepad.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: `uistub.install()\nstub.login()\nPolestar.Set("gamepad.withMouse", true)
uistub.setGuide(uistub.elwynn, 2)
local G, GF, F = Polestar.Gamepad, Polestar.UI.GuideFrame, PolestarGuideFrame
local function h() GF.Layout(); return math.floor(F:GetHeight() + 0.5) end
Polestar.Set("ui.heightMode", "fixed")
Polestar.Set("ui.height", 360)
Polestar.Set("ui.compact", true)
local compact = h()
G.StartFocus()
local focused = h()
stub.press("PAD4")
local minimized = h()
G.StopFocus()
emit({ compact = compact, focused = focused, minimized = minimized, back = h() })`,
	}).emitted;
	assert.deepEqual(out, { compact: 360, focused: 360, minimized: 360, back: 360 });
});
