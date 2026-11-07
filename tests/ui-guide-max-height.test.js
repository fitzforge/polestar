'use strict';
// The guide window's height (ui.heightMode, ui.maxHeight): "fit" (the default)
// follows the step up to the height; "fixed" is always the height, like any
// resizable window; "auto" grows into all the free room on screen (under its
// top edge; with Grow upward, over its bottom edge) less a margin and the class
// quest card. The grip on the moving edge and the Options row (a slider with a
// number field) set the height. Against the real Core + Theme + UI manifests
// and the fake Engine (tests/lua/stub_ui.lua).
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const PRE = `
uistub.install()
stub.login()
local GF = Polestar.UI.GuideFrame
local CT = Polestar.UI.ClassToast
local F = PolestarGuideFrame
GetSpellTexture = function(id) return "Interface\\\\Icons\\\\spell-" .. id end
Polestar.Compat.GetMapName = function(id) return ({ [1411] = "Durotar", [1454] = "Orgrimmar" })[id] end
IsPlayerSpell = function() return false end
GetItemCount = function() return 0 end
Polestar.Compat.IsQuestCompleted = function() return false end
Polestar.Compat.IsOnQuest = function() return false end
local function G(t, f) f.t = t; return f end
local function q(t, id, title, npc, status) return G(t, { verb = t == "accept" and "Accept" or "Turn in", subject = title, subjectKind = "quest", quest = id, npcName = npc, status = status or "pending" }) end
local function add(g) uistub.guides[g.id] = g; table.insert(uistub.order, g.id) end
add({ id = "test/class/warlock", pack = "guides", title = "Warlock demons", category = "Class", classes = { "WARLOCK" }, minLevel = 1, maxLevel = 30,
	zone = 1411, zoneName = "Durotar", author = "Polestar", version = 1, steps = {
	{ title = "Ophek", goals = { q("accept", 1506, "Gan'rul's Summons", "Ophek") } },
	{ title = "Creature of the Void", goals = { q("turnin", 1506, "Gan'rul's Summons", "Gan'rul Bloodeye") } },
} })
-- A busy step: goals of mixed heights (one wraps), so a fixed scroll step lands mid-row.
local busy = {}
for i = 1, 14 do
	local subject = i % 4 == 0 and ("Scorpid Worker of the long dry gully past the ridge " .. i) or ("Mottled Boar " .. i)
	busy[#busy + 1] = G("kill", { verb = "Kill", subject = subject, subjectKind = "npc", npc = 3098 + i, progress = { cur = 0, max = 8 }, status = i == 12 and "active" or "pending" })
end
add({ id = "test/durotar", pack = "guides", title = "Durotar", faction = "Horde", category = "Leveling", minLevel = 1, maxLevel = 12,
	zone = 1411, zoneName = "Durotar", author = "Polestar", version = 1, steps = { { title = "Valley of Trials", goals = busy } } })
uistub.player.class, uistub.player.race, uistub.player.faction, uistub.player.level = "WARLOCK", "Orc", "Horde", 10
Polestar.Set("ui.wholeStep", true)
Polestar.Set("ui.maxHeight", 0.4)
uistub.setGuide("test/durotar", 1)
stub.advance(1)
local goals = GF.parts.goals
-- A short step: one goal, far under any height (a class guide: its quest card shows and counts against the height).
local function short() uistub.setGuide("test/class/warlock", 1); stub.advance(1) end
`;

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: PRE + script,
	}).emitted;
}

// The stub does not lay frames out: pin the window's top edge where the test says.
const TOP = `F.GetTop = function() return 460 end`;

test('the default (Follows the step) is as before: the slider sets the cap and a short step keeps the window short', () => {
	const [a, b, s] = run(`
		${TOP}
		emit({ mode = Polestar.Get("ui.heightMode"), cap = GF.CapHeight(), h = F:GetHeight() })
		Polestar.Set("ui.maxHeight", 0.9)
		emit({ cap = GF.CapHeight() })
		short()
		emit({ h = F:GetHeight(), cap = GF.CapHeight() })`);
	assert.equal(a.mode, 'fit');
	assert.equal(a.cap, 432, 'the share of the 1080 px screen, as before');
	assert.equal(b.cap, 972);
	assert.ok(s.h < s.cap - 100, 'a short step keeps the window short: ' + JSON.stringify(s));
});

test('Fixed: the window is the height, for a short step and a long one, and follows a new height', () => {
	const [shortStep, tall, longStep] = run(`
		Polestar.Set("ui.heightMode", "fixed")
		Polestar.Set("ui.maxHeight", 0.7)
		short()
		emit({ h = F:GetHeight(), cap = GF.CapHeight() - CT.Reserved(), over = goals.psOver })
		Polestar.Set("ui.maxHeight", 0.8)
		emit({ h = F:GetHeight(), cap = GF.CapHeight() - CT.Reserved() })
		Polestar.Set("ui.maxHeight", 0.5)
		uistub.setGuide("test/durotar", 1)
		stub.advance(1)
		emit({ h = F:GetHeight(), cap = GF.CapHeight() - CT.Reserved(), over = goals.psOver })`);
	assert.equal(shortStep.h, shortStep.cap, 'one goal, the window still the height: ' + JSON.stringify(shortStep));
	assert.equal(shortStep.over, false, 'nothing to scroll');
	assert.equal(tall.h, tall.cap, 'a new height resizes it: ' + JSON.stringify(tall));
	assert.equal(longStep.h, longStep.cap, 'a long step keeps the height: ' + JSON.stringify(longStep));
	assert.equal(longStep.over, true, 'and scrolls');
});

test('Fixed with Grow upward never passes the top of the screen (#666)', () => {
	const [c] = run(`
		Polestar.Set("ui.heightMode", "fixed")
		Polestar.Set("ui.maxHeight", 0.9)
		Polestar.Set("ui.growUp", true)
		Polestar.Set("ui.pos", { 100, 600 })
		emit({ h = F:GetHeight(), top = UIParent:GetTop() })`);
	assert.ok(c.h <= c.top - 600 + 0.5, 'the window ends at the top of the screen at most: ' + JSON.stringify(c));
});

test('Automatic: the cap is the room under the top edge less the margin, and the slider is ignored', () => {
	const [on, moved, fitted] = run(`
		${TOP}
		Polestar.Set("ui.maxHeight", 0.9)
		Polestar.Set("ui.heightMode", "auto")
		emit({ cap = GF.CapHeight(), h = F:GetHeight(), over = goals.psOver })
		F.GetTop = function() return 700 end
		Polestar.Set("ui.pos", { 100, 700 })
		emit({ cap = GF.CapHeight(), h = F:GetHeight() })
		Polestar.Set("ui.heightMode", "fit")
		emit({ cap = GF.CapHeight() })`);
	assert.equal(on.cap, 460 - 24);
	assert.equal(on.over, true, 'the busy step is longer than the room, so it scrolls');
	assert.ok(on.h <= on.cap + 0.5, JSON.stringify(on));
	assert.equal(moved.cap, 700 - 24, 'moving the window re-measures the room');
	assert.ok(moved.h > on.h + 1, 'and the window takes the room: ' + JSON.stringify([on, moved]));
	assert.equal(fitted.cap, 972, 'back to Follows the step, the slider rules');
});

test('Automatic with Grow upward: the room is the one over the pinned bottom edge', () => {
	const [c] = run(`
		Polestar.Set("ui.heightMode", "auto")
		Polestar.Set("ui.growUp", true)
		Polestar.Set("ui.pos", { 100, 200 })
		emit({ cap = GF.CapHeight(), point = (F:GetPoint(1)) })`);
	assert.equal(c.point, 'BOTTOMLEFT');
	assert.equal(c.cap, 1080 - 200 - 24);
});

test('Automatic: the class card still comes off the room', () => {
	const [before, shown, gone] = run(`
		${TOP}
		Polestar.Set("ui.maxHeight", 0.9)
		Polestar.Set("ui.heightMode", "auto")
		emit({ h = F:GetHeight(), cap = GF.CapHeight() })
		CT.Show(1506)
		stub.advance(1)
		local _, _, _, _, y = CT.frame:GetPoint(1)
		emit({ h = F:GetHeight(), cap = GF.CapHeight(), card = CT.frame:GetHeight(), y = math.abs(y) })
		CT.frame.Later:Click()
		stub.advance(1)
		emit({ h = F:GetHeight() })`);
	assert.ok(before.h <= before.cap + 0.5, JSON.stringify(before));
	assert.ok(shown.h + shown.y + shown.card <= shown.cap + 0.5, `window, gap and card keep to the room: ${JSON.stringify(shown)}`);
	assert.ok(shown.h < before.h - 0.5, 'the goals give up the room the card takes');
	assert.ok(Math.abs(gone.h - before.h) < 0.5, 'dismissed, the window takes it back');
});

test('Automatic near the bottom of the screen keeps a floor of 30% of it', () => {
	const [c] = run(`
		F.GetTop = function() return 100 end
		Polestar.Set("ui.heightMode", "auto")
		emit({ cap = GF.CapHeight() })`);
	assert.equal(c.cap, 324);
});

test('setting a height under Automatic switches to Fixed; under the other modes the mode stays', () => {
	const [auto, fit] = run(`
		Polestar.Set("ui.heightMode", "auto")
		Polestar.Set("ui.maxHeight", 0.7)
		emit({ mode = Polestar.Get("ui.heightMode"), cap = GF.CapHeight() })
		Polestar.Set("ui.heightMode", "fit")
		Polestar.Set("ui.maxHeight", 0.6)
		emit({ mode = Polestar.Get("ui.heightMode") })`);
	assert.equal(auto.mode, 'fixed');
	assert.equal(auto.cap, 756);
	assert.equal(fit.mode, 'fit');
});

// The grip on the window's moving edge: a drag sets the height too.
// The cursor y runs up the screen, as in the game.
const DRAG = `
local grip = GF.grip
local function drag(x0, y0, x1, y1)
	stub.cursor = { x0, y0 }
	stub.RunScript(grip, "OnMouseDown", "LeftButton")
	stub.cursor = { x1, y1 }
	stub.RunScript(grip, "OnUpdate", 0)
end
local function drop() stub.RunScript(grip, "OnMouseUp", "LeftButton") end
local function gripAt() local p, rel, rp = grip:GetPoint(1); return { p = p, rp = rp, onF = rel == F } end
`;

test('the grip sits on the edge that moves: the bottom right, or with Grow upward just over the top right', () => {
	const [down, up, back] = run(`${DRAG}
		emit(gripAt())
		Polestar.Set("ui.growUp", true)
		emit(gripAt())
		Polestar.Set("ui.growUp", false)
		emit(gripAt())`);
	assert.deepEqual(down, { p: 'BOTTOMRIGHT', rp: 'BOTTOMRIGHT', onF: true });
	assert.deepEqual(up, { p: 'BOTTOMRIGHT', rp: 'TOPRIGHT', onF: true });
	assert.deepEqual(back, down);
});

test('dragging the grip down sets the height by how far it moved, the top edge pinned, and the line shows it', () => {
	const [mid, done] = run(`${DRAG}
		drag(500, 600, 500, 500)
		local line = GF.limitLine
		emit({ max = Polestar.Get("ui.maxHeight"), cap = GF.CapHeight(), line = line:IsShown(), text = line.Text:GetText() })
		drop()
		emit({ line = line:IsShown(), max = Polestar.Get("ui.maxHeight") })`);
	assert.equal(mid.cap, 532, 'the 432 px height grew by the 100 px drag');
	assert.ok(Math.abs(mid.max - 532 / 1080) < 1e-6, JSON.stringify(mid));
	assert.equal(mid.line, true);
	assert.equal(mid.text, '532 px');
	assert.equal(done.line, false, 'the line goes away on release');
	assert.ok(Math.abs(done.max - 532 / 1080) < 1e-6, 'and the height stays');
});

test('Fixed: the window follows the grip while it is dragged, even on a short step', () => {
	const [c] = run(`${DRAG}
		Polestar.Set("ui.heightMode", "fixed")
		short()
		drag(500, 600, 500, 500)
		emit({ h = F:GetHeight(), cap = GF.CapHeight(), card = CT.Reserved() })
		drop()`);
	assert.equal(c.cap, 532);
	assert.equal(c.h + c.card, 532, 'the window itself is resized: ' + JSON.stringify(c));
});

test('with Grow upward the height grows by dragging up, and the line sits over the pinned bottom edge', () => {
	const [c] = run(`${DRAG}
		Polestar.Set("ui.growUp", true)
		Polestar.Set("ui.pos", { 100, 200 })
		drag(500, 600, 500, 700)
		local _, _, _, _, y = GF.limitLine:GetPoint(1)
		emit({ cap = GF.CapHeight(), point = (GF.limitLine:GetPoint(1)), y = y })
		drop()`);
	assert.equal(c.cap, 532);
	assert.equal(c.point, 'BOTTOMLEFT');
	assert.equal(c.y, 532);
});

test('the height stays between 30% and 100% of the screen', () => {
	const [lo, hi] = run(`${DRAG}
		drag(500, 600, 500, 900)
		emit({ max = Polestar.Get("ui.maxHeight") })
		drop()
		drag(500, 600, 500, -900)
		emit({ max = Polestar.Get("ui.maxHeight") })
		drop()`);
	assert.equal(lo.max, 0.3);
	assert.equal(hi.max, 1);
});

test('only a vertical drag changes the height; a sideways one leaves it as it was', () => {
	const [c] = run(`${DRAG}
		drag(500, 600, 560, 601)
		emit({ max = Polestar.Get("ui.maxHeight"), w = F:GetWidth() })
		drop()`);
	assert.equal(c.max, 0.4);
	assert.ok(c.w > 340, 'the width still follows: ' + c.w);
});

test('a vertical drag under Automatic switches to Fixed from the room it had; a sideways drag does not', () => {
	const [side, vert] = run(`${DRAG}
		${TOP}
		Polestar.Set("ui.heightMode", "auto")
		drag(500, 600, 560, 600)
		emit({ mode = Polestar.Get("ui.heightMode") })
		drop()
		drag(500, 600, 500, 500)
		emit({ mode = Polestar.Get("ui.heightMode"), cap = GF.CapHeight() })
		drop()`);
	assert.equal(side.mode, 'auto');
	assert.equal(vert.mode, 'fixed');
	assert.equal(vert.cap, 460 - 24 + 100, 'it starts from the room Automatic had');
});

test('Lock window locks the height drag too', () => {
	const [c] = run(`${DRAG}
		Polestar.Set("ui.locked", true)
		drag(500, 600, 500, 400)
		emit({ max = Polestar.Get("ui.maxHeight"), line = GF.limitLine and GF.limitLine:IsShown() or false, grip = GF.grip:IsShown() })`);
	assert.equal(c.max, 0.4);
	assert.equal(c.line, false);
	assert.equal(c.grip, false);
});

// The Options row on the height: a slider with a number field, always shown, between the track and the text.
const ROWS = `
Polestar.UI.ShowOptions("guide")
local function find(f, key, out) for _, c in ipairs({ f:GetChildren() }) do if c.psPath == key then out[#out + 1] = c end find(c, key, out) end return out end
local function rowOf(key) for _, r in ipairs(find(UIParent, key, {})) do if rawget(r, "Slider") then return r end end end
local slider = rowOf("ui.maxHeight")
local field = slider.ValueField
local function typeIn(text)
	field:SetFocus()
	stub.RunScript(field, "OnEditFocusGained")
	field:SetText(text)
	stub.RunScript(field, "OnEnterPressed")
	field:ClearFocus()
	stub.RunScript(field, "OnEditFocusLost")
end
`;

test('the field is always shown, holds the px, and sits between the track and the text without covering either', () => {
	const [c] = run(`${ROWS}
		local _, trackRel = slider.Slider:GetPoint(1)
		local fp, fieldRel, frp = field:GetPoint(1)
		emit({ shown = field:IsShown(), value = slider.Value:IsShown(), text = field:GetText(), label = slider.Value:GetText(),
			trackOnField = trackRel == field, fieldOnValue = fieldRel == slider.Value, fp = fp, frp = frp })`);
	assert.equal(c.shown, true);
	assert.equal(c.value, true, 'the text stays');
	assert.equal(c.text, '432');
	assert.match(c.label, /^px .* 40%$/, c.label);
	assert.equal(c.trackOnField, true, 'the track ends at the field');
	assert.deepEqual([c.fieldOnValue, c.fp, c.frp], [true, 'RIGHT', 'LEFT'], 'the field ends where the text starts');
});

test('typing a height applies it on Enter and clamps it; the slider and the field follow', () => {
	const [b, lo, hi] = run(`${ROWS}
		typeIn("600")
		emit({ max = Polestar.Get("ui.maxHeight"), field = field:GetText(), label = slider.Value:GetText(), slider = slider.Slider:GetValue() })
		typeIn("50")
		emit({ max = Polestar.Get("ui.maxHeight"), field = field:GetText() })
		typeIn("5000")
		emit({ max = Polestar.Get("ui.maxHeight"), field = field:GetText() })`);
	assert.ok(Math.abs(b.max - 600 / 1080) < 1e-9);
	assert.equal(b.field, '600');
	assert.match(b.label, /56%$/);
	assert.ok(Math.abs(b.slider - 600 / 1080) < 1e-9, 'the slider follows');
	assert.equal(lo.max, 0.3);
	assert.equal(lo.field, '324', 'the corrected value is shown');
	assert.equal(hi.max, 1);
	assert.equal(hi.field, '1080');
});

test('a height between two 1% steps (402 px) is kept, and the field still says 402', () => {
	const [c] = run(`${ROWS}
		typeIn("402")
		-- The game's slider keeps its value on the 1% step and reports that (0.37 for 402 of 1080 px).
		stub.RunScript(slider.Slider, "OnValueChanged", 0.37, false)
		emit({ field = field:GetText(), label = slider.Value:GetText(), max = Polestar.Get("ui.maxHeight") })`);
	assert.ok(Math.abs(c.max - 402 / 1080) < 1e-9, 'the typed height is kept: ' + c.max);
	assert.equal(c.field, '402');
	assert.match(c.label, /37%$/);
});

test('Escape and an empty or non-numeric field put the old number back', () => {
	const [esc, empty, junk] = run(`${ROWS}
		field:SetFocus()
		field:SetText("900")
		stub.RunScript(field, "OnEscapePressed")
		field:ClearFocus()
		stub.RunScript(field, "OnEditFocusLost")
		emit({ max = Polestar.Get("ui.maxHeight"), field = field:GetText() })
		typeIn("")
		emit({ max = Polestar.Get("ui.maxHeight"), field = field:GetText() })
		typeIn("abc")
		emit({ max = Polestar.Get("ui.maxHeight"), field = field:GetText() })`);
	for (const r of [esc, empty, junk]) {
		assert.equal(r.max, 0.4);
		assert.equal(r.field, '432');
	}
});

test('the field follows a drag of the grip, and typing a height under Automatic switches to Fixed', () => {
	const [dragged, typed] = run(`${DRAG}${ROWS}
		drag(500, 600, 500, 500)
		drop()
		emit({ field = field:GetText() })
		Polestar.Set("ui.heightMode", "auto")
		typeIn("700")
		emit({ mode = Polestar.Get("ui.heightMode"), max = Polestar.Get("ui.maxHeight") })`);
	assert.equal(dragged.field, '532');
	assert.equal(typed.mode, 'fixed');
	assert.ok(Math.abs(typed.max - 700 / 1080) < 1e-9);
});

test('a slider without opts.edit is as before: no field, the track ends at the text, a click on the value does nothing', () => {
	const [c] = run(`${ROWS}
		local other = rowOf("ui.upcoming")
		local before = Polestar.Get("ui.upcoming")
		stub.RunScript(other.Value, "OnMouseUp")
		stub.RunScript(other.Value, "OnMouseDown")
		local _, trackRel = other.Slider:GetPoint(1)
		emit({ field = rawget(other, "ValueField") ~= nil, trackOnValue = trackRel == other.Value, shown = other.Value:IsShown(),
			text = other.Value:GetText(), kept = Polestar.Get("ui.upcoming") == before })`);
	assert.equal(c.field, false);
	assert.equal(c.trackOnValue, true);
	assert.equal(c.shown, true);
	assert.equal(c.text, '0');
	assert.equal(c.kept, true);
});

test('a focused field is not overwritten when the setting changes under it', () => {
	const [c] = run(`${ROWS}
		field:SetFocus()
		field:SetText("77")
		Polestar.Set("ui.maxHeight", 0.6)
		emit({ field = field:GetText() })`);
	assert.equal(c.field, '77');
});

// Fixed with the progress bar under the last goal (ui.footAt "goals", the default) or on the edge.
const ANCHORS = `
local foot, body = GF.parts.foot, GF.parts.body
local function at(f) local p, rel, rp = f:GetPoint(1); return { p = p, rp = rp, rel = rel == F and "F" or rel == body and "body" or rel == foot and "foot" or "other" } end
local function snap() return { h = F:GetHeight(), cap = GF.CapHeight() - CT.Reserved(), body = body:GetHeight(), foot = at(foot), bodyAt = at(body) } end
`;

test('Fixed: on a short step the progress bar sits right under the last goal, the free room below it, the window still the height', () => {
	const [c] = run(`${ANCHORS}
		Polestar.Set("ui.heightMode", "fixed")
		Polestar.Set("ui.maxHeight", 0.8)
		short()
		emit(snap())`);
	assert.deepEqual(c.foot, { p: 'TOPLEFT', rp: 'BOTTOMLEFT', rel: 'body' }, 'the bar hangs from the goals');
	assert.equal(c.h, c.cap, 'the window keeps its height: ' + JSON.stringify(c));
	assert.ok(c.body < c.cap - 200, 'the goals keep to their own height: ' + JSON.stringify(c));
});

test('Fixed with Grow upward: the goals sit on the bar at the pinned bottom edge, the free room above them', () => {
	const [c] = run(`${ANCHORS}
		Polestar.Set("ui.heightMode", "fixed")
		Polestar.Set("ui.maxHeight", 0.8)
		Polestar.Set("ui.growUp", true)
		short()
		emit(snap())`);
	assert.deepEqual(c.foot, { p: 'BOTTOMLEFT', rp: 'BOTTOMLEFT', rel: 'F' }, 'the bar on the pinned edge');
	assert.deepEqual(c.bodyAt, { p: 'BOTTOMLEFT', rp: 'TOPLEFT', rel: 'foot' }, 'the goals on the bar');
	assert.equal(c.h, c.cap);
});

test('Fixed with the bar on the edge, and Follows the step: the bar on the window edge as before', () => {
	const [edge, fit] = run(`${ANCHORS}
		Polestar.Set("ui.heightMode", "fixed")
		Polestar.Set("ui.maxHeight", 0.8)
		Polestar.Set("ui.footAt", "edge")
		short()
		emit(snap())
		Polestar.Set("ui.footAt", "goals")
		Polestar.Set("ui.heightMode", "fit")
		emit(snap())`);
	assert.deepEqual(edge.foot, { p: 'BOTTOMLEFT', rp: 'BOTTOMLEFT', rel: 'F' });
	assert.equal(edge.h, edge.cap);
	assert.deepEqual(fit.foot, { p: 'BOTTOMLEFT', rp: 'BOTTOMLEFT', rel: 'F' }, 'Follows the step is unchanged');
	assert.deepEqual(fit.bodyAt.rel, 'other', 'the goals under the step bar, as before');
});
