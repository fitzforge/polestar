'use strict';
// Real UI + QoL, with the UI Engine contract and the QoL harness's combat
// protection. The state driver below models the client's secure visibility
// update; ordinary addon calls still fail if they mutate protected frames.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const SECURE_VISIBILITY = `
local M = stub.Methods
-- The client derives a frame's width from its left/right anchors. The
-- general UI stub does not solve anchors; rows use this one shared-parent
-- case, while explicit point coordinates below exercise the hit routing.
local getWidth = M.GetWidth
function M.GetWidth(self)
	if (self.width or 0) > 0 then return getWidth(self) end
	local left, right
	for i = 1, self:GetNumPoints() do
		local point, relative, _, x = self:GetPoint(i)
		if point == "TOPLEFT" then left = { relative, x } end
		if point == "TOPRIGHT" then right = { relative, x } end
	end
	if left and right and left[1] == right[1] and left[1] then
		return left[1]:GetWidth() + right[2] - left[2]
	end
	return getWidth(self)
end
for _, name in ipairs({ "SetSize", "SetWidth", "SetHeight", "SetParent", "SetFrameStrata", "SetFrameLevel", "EnableMouse" }) do
	local original = M[name]
	M[name] = function(self, ...)
		local nt = Polestar and Polestar.UI and Polestar.UI.NameTargets
		local owned = nt and nt.holder and (self == nt.holder or self:GetParent() == nt.holder)
		if owned and self.secure and stub.inCombat then error("protected call in combat: " .. name, 2) end
		if original then return original(self, ...) end
	end
end
local drivers = {}
local function applyDriver(frame)
	local show = not stub.inCombat
	if frame.shown ~= show then
		-- Client-owned state changes bypass insecure Show/Hide calls.
		frame.shown = show
		stub.RunScript(frame, show and "OnShow" or "OnHide")
	end
end
function RegisterStateDriver(frame, state, condition)
	assert(not stub.inCombat, "RegisterStateDriver in combat")
	assert(state == "visibility" and condition:gsub("%s", "") == "[combat]hide;show", "unsupported test state driver")
	drivers[frame] = condition
	applyDriver(frame)
end
function UnregisterStateDriver(frame, state)
	assert(not stub.inCombat, "UnregisterStateDriver in combat")
	drivers[frame] = nil
end
function stub.qol.combat(on)
	stub.inCombat = on and true or false
	for frame in pairs(drivers) do applyDriver(frame) end
	stub.fire(on and "PLAYER_REGEN_DISABLED" or "PLAYER_REGEN_ENABLED")
end
`;

const HELPERS = `
local GF, NT, q = Polestar.UI.GuideFrame, Polestar.UI.NameTargets, stub.qol
local F = PolestarGuideFrame
local function settle() stub.advance(0.1) end
local function rowFor(subject)
	for _, row in ipairs(GF.rows) do if row:IsShown() and row.psGoal and row.psGoal.subject == subject then return row end end
end
local function targetFor(owner)
	for _, b in ipairs(NT.buttons) do if b.psOwner == owner and b:IsVisible() then return b end end
end
local function targets()
	local out = {}
	for _, b in ipairs(NT.buttons) do
		if b:IsVisible() then out[#out + 1] = { name = b.psName, macro = b:GetAttribute("macrotext1"), type = b:GetAttribute("type1") } end
	end
	return out
end
local function lastCall(name)
	for i = #uistub.calls, 1, -1 do if uistub.calls[i][1] == name then return uistub.calls[i] end end
end
local function callCount(name)
	local count = 0
	for _, c in ipairs(uistub.calls) do if c[1] == name then count = count + 1 end end
	return count
end
local function postClick(button, mouse, down)
	stub.RunScript(button, "PostClick", mouse, down)
end
local function menuItems()
	local items = {}
	if PolestarMenu and PolestarMenu:IsShown() then
		for _, row in ipairs(PolestarMenu.rows) do
			if row:IsShown() then items[#items + 1] = row.Text:GetText() end
		end
	end
	return items
end
local function pickMenu(text)
	assert(PolestarMenu and PolestarMenu:IsShown(), "missing context menu")
	for _, row in ipairs(PolestarMenu.rows) do
		if row:IsShown() and row.Text:GetText() == text then row:Click(); return end
	end
	error("missing menu item: " .. text)
end
-- Hit-test the ordinary row, its real child controls and its independent
-- overlay by geometry and frame level. Equal levels are an ambiguous test
-- failure: the feature must not depend on client creation-order tie breaks.
local function rowHit(row, x, y)
	local candidates = { row, row:GetChildren() }
	for _, b in ipairs(NT.buttons) do if b.psOwner == row then candidates[#candidates + 1] = b end end
	local best, level
	for _, f in ipairs(candidates) do
		if f:IsVisible() then
			local scale = f:GetEffectiveScale() / UIParent:GetEffectiveScale()
			local l, t, w, h = f:GetLeft() * scale, f:GetTop() * scale, f:GetWidth() * scale, f:GetHeight() * scale
			if f.psOwner then l, t = f.psLeft, f.psTop end
			if x >= l and x < l + w and y > t - h and y <= t then
				local z = f:GetFrameLevel()
				assert(z ~= level, "ambiguous frame-level ordering")
				if not level or z > level then best, level = f, z end
			end
		end
	end
	return best
end
`;

function run(script, { before = '', enabled = true } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua', 'stub_qol.lua'],
		before: `${SECURE_VISIBILITY}\n${before}`,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml', 'QoL/QoL.xml'] }],
		script: `uistub.install()\nstub.login()\n${enabled ? 'Polestar.Set("qol.guideNameTarget", true)' : ''}\n${HELPERS}\n${script}`,
	}).emitted;
}

test('each enabled mob or item-source objective uses the shared target macro with marking off by default', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		local kill = targetFor(rowFor("Kobold Vermin"))
		local collect = targetFor(rowFor("Tough Wolf Meat"))
		emit({ enabled = Polestar.GetDefault("qol.guideNameTarget"), marking = Polestar.GetDefault("qol.markTarget"),
			kill = kill and { name = kill.psName, kind = kill.psKind, macro = kill:GetAttribute("macrotext1"), type = kill:GetAttribute("type1") },
			collect = collect and { name = collect.psName, kind = collect.psKind, macro = collect:GetAttribute("macrotext1") },
			expected = Polestar.QoL.Buttons.TargetMacro({ "Kobold Vermin" }, 1),
			header = targetFor(GF.parts.person) ~= nil })`);
	assert.equal(out.enabled, false);
	assert.equal(out.marking, false);
	assert.equal(out.kill?.name, 'Kobold Vermin');
	assert.equal(out.kill.kind, 'mob');
	assert.equal(out.kill.type, 'macro');
	assert.equal(out.kill.macro, out.expected);
	assert.doesNotMatch(out.kill.macro, /Young Wolf/);
	assert.doesNotMatch(out.kill.macro, /\/tm/);
	assert.equal(out.collect?.name, 'Young Wolf');
	assert.equal(out.collect.kind, 'mob');
	assert.match(out.collect.macro, /\/targetexact Young Wolf(?:\n|$)/);
	assert.doesNotMatch(out.collect.macro, /Kobold Vermin|targetexact Tough Wolf Meat/);
	assert.equal(out.header, false, 'a field-place header is not an NPC');
});

test('the NPC header follows the focused giver and ordinary guide frames stay unprotected', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 4)
		settle()
		local first = targetFor(GF.parts.person)
		local before = first and { name = first.psName, macro = first.psMacro, holder = first:GetParent() == NT.holder,
			root = NT.holder:GetParent() == UIParent, secure = first.secure == true }
		uistub.goal(4, 1).status, uistub.goal(4, 2).status = "done", "done"
		uistub.update()
		settle()
		local next = targetFor(GF.parts.person)
		local ordinary = not F.secure and not GF.parts.person.secure
		for _, row in ipairs(GF.rows) do ordinary = ordinary and not row.secure end
		emit({ before = before, next = next and next.psName, ordinary = ordinary })`);
	assert.equal(out.before?.name, 'Marshal McBride');
	assert.match(out.before.macro, /\/targetexact Marshal McBride(?:\n|$)/);
	assert.equal(out.before.holder, true);
	assert.equal(out.before.root, true);
	assert.equal(out.before.secure, true);
	assert.equal(out.next, 'Eagan Peltskinner');
	assert.equal(out.ordinary, true);
});

test('shared mob and NPC mark settings update overlays and their hovered tooltip', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		local b = assert(targetFor(rowFor("Kobold Vermin")))
		stub.RunScript(b, "OnEnter")
		local unmarked = GameTooltip.lines[#GameTooltip.lines]
		Polestar.Set("qol.markTarget", true)
		Polestar.Set("qol.markMob", "7")
		local marked = { macro = b.psMacro, hint = GameTooltip.lines[#GameTooltip.lines], hover = b.psOwner.Hover:IsShown() }
		uistub.setStep(4)
		settle()
		Polestar.Set("qol.markNpc", "6")
		local npc = assert(targetFor(GF.parts.person))
		local header = { kind = npc.psKind, macro = npc.psMacro }
		stub.RunScript(npc, "OnEnter")
		Polestar.Set("qol.markTarget", false)
		emit({ unmarked = unmarked, marked = marked, header = header,
			off = { macro = npc.psMacro, hint = GameTooltip.lines[#GameTooltip.lines], hover = GF.parts.person.Hover:IsShown() } })`);
	assert.match(out.unmarked, /target Kobold Vermin/);
	assert.doesNotMatch(out.unmarked, /mark/);
	assert.match(out.marked.macro, /\/tm[^\n]* !7$/);
	assert.match(out.marked.hint, /target and mark Kobold Vermin/);
	assert.equal(out.marked.hover, true);
	assert.equal(out.header.kind, 'npc');
	assert.match(out.header.macro, /\/tm[^\n]* !6$/);
	assert.doesNotMatch(out.off.macro, /\/tm/);
	assert.match(out.off.hint, /target Marshal McBride/);
	assert.doesNotMatch(out.off.hint, /mark/);
	assert.equal(out.off.hover, true);
});

test('the NPC header wash responds to delegated hover, survives cycle refresh, and clears on every exit', () => {
	const [out] = run(`
		Polestar.Set("qol.markTarget", true)
		Polestar.Set("qol.markNpc", "cycle")
		uistub.setGuide(uistub.elwynn, 4)
		settle()
		local header = GF.parts.person
		local wash = assert(header.Hover, "the header needs an ordinary hover texture")
		local b = assert(targetFor(header))
		stub.RunScript(b, "OnEnter")
		local entered = wash:IsShown()
		local before = b.psMacro
		postClick(b, "LeftButton", false)
		local cycled = { hover = wash:IsShown(), changed = b.psMacro ~= before }
		stub.RunScript(b, "OnLeave")
		local left = not wash:IsShown()
		stub.RunScript(b, "OnEnter")
		F:Hide()
		local hidden = not wash:IsShown()
		F:Show()
		stub.RunScript(assert(targetFor(header)), "OnEnter")
		q.combat(true)
		local combat = not wash:IsShown()
		q.combat(false)
		stub.RunScript(assert(targetFor(header)), "OnEnter")
		Polestar.Set("qol.guideNameTarget", false)
		local disabled = not wash:IsShown()
		-- Native header hover still works with the opt-in feature disabled.
		stub.RunScript(header, "OnEnter")
		local ordinary = wash:IsShown()
		stub.RunScript(header, "OnLeave")
		local ordinaryLeft = not wash:IsShown()
		Polestar.Set("qol.guideNameTarget", true)
		stub.RunScript(assert(targetFor(header)), "OnEnter")
		uistub.goal(4, 1).status, uistub.goal(4, 2).status = "done", "done"
		uistub.update()
		settle()
		emit({ entered = entered, cycled = cycled, left = left, hidden = hidden, combat = combat,
			disabled = disabled, ordinary = ordinary, ordinaryLeft = ordinaryLeft,
			reused = not wash:IsShown(), nextName = targetFor(header).psName, layer = wash:GetDrawLayer() })`);
	assert.equal(out.entered, true);
	assert.deepEqual(out.cycled, { hover: true, changed: true });
	for (const key of ['left', 'hidden', 'combat', 'disabled', 'ordinary', 'ordinaryLeft', 'reused']) assert.equal(out[key], true, key);
	assert.equal(out.nextName, 'Eagan Peltskinner');
	assert.equal(out.layer, 'BACKGROUND', 'delegated OnEnter cannot light a native HIGHLIGHT texture');
});

test('left release advances the clicked kind after navigation even when navigation reuses its overlay', () => {
	const [out] = run(`
		Polestar.Set("qol.markTarget", true)
		Polestar.Set("qol.markMob", "cycle")
		Polestar.Set("qol.markNpc", "4")
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		local row = rowFor("Kobold Vermin")
		local b = assert(targetFor(row))
		local events = {}
		Polestar.On("QOL_TARGET_MARK_CHANGED", function(kind) events[#events + 1] = { kind, callCount("AimGoal") } end)
		local click = row:GetScript("OnClick")
		row:SetScript("OnClick", function(self, mouse)
			click(self, mouse)
			if mouse == "LeftButton" then uistub.setStep(4) end
		end)
		postClick(b, "LeftButton", true)
		local pressed = #events
		postClick(b, "LeftButton", false)
		local released = #events
		local aimed = lastCall("AimGoal")
		postClick(b, "RightButton", false)
		emit({ pressed = pressed, released = released, events = events, aimed = aimed,
			reused = b.psOwner == GF.parts.person, kind = b.psKind, name = b.psName,
			macro = b.psMacro, nextMob = Polestar.QoL.Buttons.MarkLine("mob") })`);
	assert.equal(out.pressed, 0);
	assert.equal(out.released, 1);
	assert.equal(out.events.length, 1, 'right release does not advance marking');
	assert.equal(out.events[0][0], 'mob', 'retain the kind that the secure click actually used');
	assert.ok(out.events[0][1] >= 1, 'navigation happens before shared mark refresh');
	assert.deepEqual(out.aimed, ['AimGoal', 3, 3]);
	assert.equal(out.reused, true);
	assert.equal(out.kind, 'npc');
	assert.equal(out.name, 'Marshal McBride');
	assert.match(out.macro, /\/tm[^\n]* !4$/);
	assert.match(out.nextMob, /\/tm[^\n]* ~2$/);
});

test('place and object rows never receive a name-target overlay', () => {
	const [out] = run(`
		local step = uistub.guides[uistub.elwynn].steps[3]
		step.goals = {
			{ t = "goto", verb = "Go to", subject = "Goldshire", subjectKind = "place", status = "active", map = 1429, x = 42.1, y = 65.9 },
			{ t = "interact", verb = "Open", subject = "Supply Chest", subjectKind = "object", object = 123,
				objectName = "Supply Chest", status = "active", map = 1429, x = 42.1, y = 65.9 },
		}
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		emit(#targets())`);
	assert.equal(out, 0);
});

test('targeting is off by default and ordinary row actions remain available without overlays', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		local row = rowFor("Kobold Vermin")
		row:Click("LeftButton")
		row:Click("RightButton")
		local items, beforePick = menuItems(), callCount("ToggleGoal")
		pickMenu("Tick it done")
		emit({ enabled = Polestar.Get("qol.guideNameTarget"), count = #NT.buttons, holder = NT.holder ~= nil,
			items = items, beforePick = beforePick, aim = lastCall("AimGoal"), tick = lastCall("ToggleGoal") })`, { enabled: false });
	assert.equal(out.enabled, false);
	assert.equal(out.count, 0);
	assert.equal(out.holder, false);
	assert.deepEqual(out.aim, ['AimGoal', 3, 3]);
	assert.deepEqual(out.items, ['Tick it done', 'Skip this quest']);
	assert.equal(out.beforePick, 0, 'right-click opens the menu without ticking the goal');
	assert.deepEqual(out.tick, ['ToggleGoal', 3, 3]);
});

test('icon, text, subline and whitespace target the row while checkbox, Skip and next-spot win hit testing', () => {
	const [out] = run(`
		local goal = uistub.guides[uistub.elwynn].steps[3].goals[3]
		goal.optional, goal.spots, goal.note = true, 2, "Stay near the mine entrance."
		uistub.setGuide(uistub.elwynn, 3)
		local row = assert(rowFor("Kobold Vermin"))
		row.x, row.y = 100, 200
		row:SetSize(340, 64)
		row:SetFrameLevel(7)
		row.Check.x, row.Check.y = 410, 239
		row.Skip.x, row.Skip.y = 366, 239
		row.Alt.x, row.Alt.y = 340, 239
		settle()
		local b = assert(targetFor(row))
		local hits = {}
		for _, point in ipairs({ {115,252}, {165,252}, {165,221}, {425,210} }) do
			hits[#hits + 1] = rowHit(row, point[1], point[2]) == b
		end
		local controls = {}
		for _, c in ipairs({ row.Check, row.Skip, row.Alt }) do
			controls[#controls + 1] = rowHit(row, c:GetLeft() + c:GetWidth() / 2, c:GetBottom() + c:GetHeight() / 2) == c
		end
		local heights = { row:GetFrameLevel(), b:GetFrameLevel(), row.Check:GetFrameLevel(), row.Skip:GetFrameLevel(), row.Alt:GetFrameLevel() }
		stub.RunScript(b, "OnEnter")
		local hover, hint = row.Hover:IsShown(), GameTooltip.lines[#GameTooltip.lines]
		stub.RunScript(b, "OnLeave")
		local left = not row.Hover:IsShown()
		local aimBefore = callCount("AimGoal")
		row.Alt:Click()
		row.Skip:Click()
		row.Check:Click()
		local controlAim = callCount("AimGoal") - aimBefore
		row:SetFrameLevel(12)
		settle()
		emit({ hits = hits, controls = controls, heights = heights, nextLevels = { b:GetFrameLevel(), row.Check:GetFrameLevel() },
			hover = hover, left = left, hint = hint, controlAim = controlAim,
			spot = lastCall("CycleSpot"), skip = lastCall("SkipGoal"), tick = lastCall("ToggleGoal") })`);
	assert.deepEqual(out.hits, [true, true, true, true]);
	assert.deepEqual(out.controls, [true, true, true]);
	assert.deepEqual(out.heights, [7, 8, 9, 9, 9]);
	assert.deepEqual(out.nextLevels, [13, 14]);
	assert.equal(out.hover, true);
	assert.equal(out.left, true);
	assert.match(out.hint, /target Kobold Vermin/);
	assert.doesNotMatch(out.hint, /mark/);
	assert.equal(out.controlAim, 0);
	assert.deepEqual(out.spot, ['CycleSpot', 3, 3]);
	assert.deepEqual(out.skip, ['SkipGoal', 3, 3]);
	assert.deepEqual(out.tick, ['ToggleGoal', 3, 3]);
});

test('the real gear-reward link remains above the objective overlay and keeps its item click', () => {
	const [out] = run(`
		Polestar.Gear = { IsEnabled = function() return true end,
			QuestPick = function() return { entry = { id = 750 }, upgrade = false } end }
		Polestar.Set("gear.rewards", true)
		uistub.setGuide(uistub.elwynn, 4)
		local row = assert(rowFor("Kobold Camp Cleanup"))
		local gear = assert(row.psGearPick, "real GearPick frame missing")
		row.x, row.y = 100, 200
		row:SetSize(340, 64)
		row.Check.x, row.Check.y = 410, 239
		gear.x, gear.y = 134, 216
		settle()
		local b = assert(targetFor(row))
		local hit = rowHit(row, 160, 223)
		local clicked
		Polestar.Widgets.ItemClick = function(id) clicked = id end
		local before = callCount("AimGoal")
		hit:Click("LeftButton")
		emit({ gear = hit == gear, above = gear:GetFrameLevel() > b:GetFrameLevel(), clicked = clicked,
			ordinary = not gear.secure, navigation = callCount("AimGoal") - before })`);
	assert.equal(out.gear, true);
	assert.equal(out.above, true);
	assert.equal(out.clicked, 750);
	assert.equal(out.ordinary, true);
	assert.equal(out.navigation, 0);
});

test('objective clicks retain row navigation and the quest right-click menu', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		local row = rowFor("Kobold Vermin")
		local button = assert(targetFor(row), "missing mob overlay")
		local before = callCount("AimGoal")
		postClick(button, "LeftButton", true)
		local pressed = callCount("AimGoal")
		postClick(button, "LeftButton", false)
		local released = callCount("AimGoal")
		local aim = lastCall("AimGoal")
		postClick(button, "RightButton", false)
		local items, beforePick = menuItems(), callCount("ToggleGoal")
		pickMenu("Tick it done")
		local right = lastCall("ToggleGoal")
		row.Check:Click()
		local checkbox = row.Check:IsShown()
		local wholeRow = button.psRegion == row and button.psWholeRow
		postClick(assert(targetFor(row)), "RightButton", false)
		pickMenu("Skip this quest")
		emit({ before = before, pressed = pressed, released = released, aim = aim, right = right, items = items, beforePick = beforePick,
			skip = lastCall("SkipQuest"),
			check = lastCall("ToggleGoal"), checkbox = checkbox, useOnKeyDown = button:GetAttribute("useOnKeyDown"),
			noRightMacro = button:GetAttribute("type2") == nil, wholeRow = wholeRow })`);
	assert.equal(out.pressed, out.before, 'a press does not duplicate navigation');
	assert.equal(out.released, out.before + 1);
	assert.deepEqual(out.aim, ['AimGoal', 3, 3]);
	assert.deepEqual(out.items, ['Tick it done', 'Skip this quest']);
	assert.equal(out.beforePick, 0, 'the overlay delegates right-click without ticking the goal');
	assert.deepEqual(out.right, ['ToggleGoal', 3, 3]);
	assert.deepEqual(out.check, ['ToggleGoal', 3, 3]);
	assert.deepEqual(out.skip, ['SkipQuest', 7, true]);
	assert.equal(out.checkbox, true);
	assert.equal(out.useOnKeyDown, false);
	assert.equal(out.noRightMacro, true);
	assert.equal(out.wholeRow, true);
});

test('a non-quest objective still toggles completion directly through the overlay', () => {
	const [out] = run(`
		uistub.guides[uistub.elwynn].steps[3].goals[3].quest = nil
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		local row = assert(rowFor("Kobold Vermin"))
		assert(not row.psGoal.quest, "fixture should have no quest")
		postClick(assert(targetFor(row)), "RightButton", false)
		emit({ tick = lastCall("ToggleGoal"), menu = PolestarMenu and PolestarMenu:IsShown() or false })`);
	assert.deepEqual(out.tick, ['ToggleGoal', 3, 3]);
	assert.equal(out.menu, false);
});

test('name overlays track region movement and guide scale, hide with the guide, and return on show', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		local row = rowFor("Kobold Vermin")
		row.x, row.y = 100, 200
		settle()
		local button = assert(targetFor(row), "missing mob overlay")
		local function geometry()
			local _, anchor, _, x, y = button:GetPoint(1)
			return { x = x, y = y, w = button:GetWidth(), h = button:GetHeight(), root = anchor == UIParent }
		end
		local first = geometry()
		row.x, row.y = 160, 250
		settle()
		local moved = geometry()
		F:SetScale(1.5)
		settle()
		local scaled = geometry()
		F:Hide()
		local hidden = #targets()
		F:Show()
		settle()
		emit({ first = first, moved = moved, scaled = scaled, hidden = hidden, shown = #targets() })`);
	assert.equal(out.first.root, true);
	assert.equal(out.moved.x - out.first.x, 60);
	assert.equal(out.moved.y - out.first.y, 50);
	for (const field of ['x', 'y', 'w', 'h']) assert.ok(Math.abs(out.scaled[field] - out.moved[field] * 1.5) < 0.001, field);
	assert.equal(out.hidden, 0);
	assert.ok(out.shown > 0);
});

test('a failed name click reports the NPC once; successful clicks, right clicks and combat stay quiet', () => {
	const [out] = run(`
		local goal = uistub.guides[uistub.elwynn].steps[3].goals[4]
		goal.subject = "Khazgorm's Journal"
		goal.text = "Kill Prospector Khazgorm for Khazgorm's Journal"
		goal.source = { kind = "npc", name = "Prospector Khazgorm", enemy = true, inText = true }
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		local button = assert(targetFor(rowFor("Khazgorm's Journal")), "missing journal overlay")
		local messages = {}
		UIErrorsFrame.AddMessage = function(_, text) messages[#messages + 1] = text end
		local before = callCount("AimGoal")
		q.target = false
		postClick(button, "LeftButton", true)
		local pressed = #messages
		postClick(button, "LeftButton", false)
		local failed = #messages
		local navigated = callCount("AimGoal") - before
		q.target = true
		postClick(button, "LeftButton", false)
		q.target = false
		postClick(button, "RightButton", false)
		q.combat(true)
		postClick(button, "LeftButton", false)
		emit({ pressed = pressed, failed = failed, navigated = navigated, messages = messages })`);
	assert.equal(out.pressed, 0);
	assert.equal(out.failed, 1);
	assert.equal(out.navigated, 1);
	assert.deepEqual(out.messages, ['Prospector Khazgorm not found nearby.']);
});

test('a Shift-, Ctrl- or Alt-click runs no macro: it navigates like a row click, with no "not found" and no mark advance', () => {
	const [out] = run(`
		Polestar.Set("qol.markTarget", true)
		Polestar.Set("qol.markMob", "cycle")
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		local button = assert(targetFor(rowFor("Kobold Vermin")), "missing mob overlay")
		local messages, marks = {}, 0
		UIErrorsFrame.AddMessage = function(_, text) messages[#messages + 1] = text end
		Polestar.On("QOL_TARGET_MARK_CHANGED", function() marks = marks + 1 end)
		local before = callCount("AimGoal")
		q.target = false
		for _, key in ipairs({ "shift", "ctrl", "alt" }) do
			stub.keys[key] = true
			postClick(button, "LeftButton", false)
			stub.keys[key] = false
		end
		local modified = { messages = #messages, marks = marks, navigated = callCount("AimGoal") - before }
		postClick(button, "LeftButton", false)
		emit({ modified = modified, plain = { messages = #messages, marks = marks } })`);
	assert.deepEqual(out.modified, { messages: 0, marks: 0, navigated: 3 });
	assert.deepEqual(out.plain, { messages: 1, marks: 1 }, 'an unmodified click still reports and advances');
});

test('a failed name click falls back to chat when the error display is unavailable', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		local button = assert(targetFor(rowFor("Kobold Vermin")), "missing mob overlay")
		local messages = {}
		Polestar.Print = function(text) messages[#messages + 1] = text end
		UIErrorsFrame = nil
		q.target = false
		postClick(button, "LeftButton", false)
		emit(messages)`);
	assert.deepEqual(out, ['Kobold Vermin not found nearby.']);
});

test('combat hides secure overlays while the unprotected guide updates, then uses the latest goal mapping', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		local before = targets()
		local old = {}
		for i, button in ipairs(NT.buttons) do old[i] = button:GetAttribute("macrotext1") end
		q.combat(true)
		uistub.setStep(4)
		Polestar.Set("ui.width", 420)
		Polestar.Set("ui.scale", 1.2)
		Polestar.Set("qol.markTarget", true)
		Polestar.Set("qol.markNpc", "6")
		uistub.update()
		settle()
		rowFor("Kobold Camp Cleanup"):Click("LeftButton")
		local unchanged = true
		for i, button in ipairs(NT.buttons) do unchanged = unchanged and button:GetAttribute("macrotext1") == old[i] end
		local during = { visible = #targets(), unchanged = unchanged, title = GF.parts.person.Name:GetText(), shown = F:IsShown(), aim = lastCall("AimGoal") }
		q.combat(false)
		settle()
		emit({ before = before, during = during, after = targets(), header = targetFor(GF.parts.person).psName })`);
	assert.ok(out.before.length > 0);
	assert.deepEqual(out.during, { visible: 0, unchanged: true, title: 'Marshal McBride', shown: true, aim: ['AimGoal', 4, 1] });
	assert.equal(out.header, 'Marshal McBride');
	assert.ok(out.after.length > 0);
	for (const target of out.after) {
		assert.doesNotMatch(target.macro, /Kobold Vermin|Young Wolf/);
		assert.match(target.macro, /\/tm[^\n]*!?6$/);
	}
});

test('loading the guide during combat creates no name overlays until combat ends', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		local before = { count = #NT.buttons, holder = NT.holder ~= nil }
		q.combat(false)
		settle()
		emit({ before = before, after = targets() })`, { before: 'stub.inCombat = true' });
	assert.deepEqual(out.before, { count: 0, holder: false });
	assert.ok(out.after.length > 0);
});

test('disabling clickable names leaves normal row actions and prevents overlays after combat', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		settle()
		Polestar.Set("qol.guideNameTarget", false)
		local hidden = #targets()
		rowFor("Kobold Vermin"):Click("LeftButton")
		local aim = lastCall("AimGoal")
		Polestar.Set("qol.guideNameTarget", true)
		local enabled = #targets()
		q.combat(true)
		Polestar.Set("qol.guideNameTarget", false)
		uistub.setStep(4)
		q.combat(false)
		settle()
		emit({ hidden = hidden, aim = aim, enabled = enabled, after = #targets() })`);
	assert.equal(out.hidden, 0);
	assert.deepEqual(out.aim, ['AimGoal', 3, 3]);
	assert.ok(out.enabled > 0);
	assert.equal(out.after, 0);
});
