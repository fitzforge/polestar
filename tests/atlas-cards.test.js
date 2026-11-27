'use strict';
// The Atlas layout's cards above the guide window (While you're here, Along
// the way, Optional): a row's click points the arrow there, also over a point
// picked by hand; the row the arrow points at is lit (the core's mark), not
// underlined; each card is as
// tall as its rows wrap to, the rows one under the other.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

// The Atlas skin and layout alone, from their folders in Polestar_Skins (since 0.4.3, #3507).
const ATLAS = { name: 'Polestar_Skins', files: ['Skins/Atlas/Atlas.lua', 'Layouts/Atlas/Atlas.lua'] };

const GUIDE = `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({
	id = "test/cards", pack = "test", title = "Cards", minLevel = 1, maxLevel = 20,
	steps = {
		{ goals = {
			{ t = "goto", map = 1429, x = 0.40, y = 0.30, text = "Go to the hill" },
			{ t = "goto", map = 1429, x = 0.497, y = 0.394, optional = true },
		} },
		{ goals = { { t = "goto", map = 1429, x = 0.2, y = 0.2 } } },
	},
})
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
local T, GF, E, Nav = Polestar.Theme, Polestar.UI.GuideFrame, Polestar.Engine, Polestar.Nav
E.GetAlong = function()
	return { { index = 1, title = "Wolves", goals = {
		{ index = 1, step = 1, t = "loot", text = "Collect Stringy Wolf Meat", status = "active", optional = true, progress = { cur = 2, max = 10 }, map = 1429, x = 0.48, y = 0.44 },
		{ index = 2, step = 1, t = "kill", text = "Kill Plainstrider", status = "active", progress = { cur = 3, max = 7 }, map = 1429, x = 0.5, y = 0.5 },
		{ index = 3, step = 1, t = "loot", text = "Collect Shiny Junk from Junk Pile by the road to the south of the farm", status = "active", map = 1429, x = 0.52, y = 0.5 },
	} } }
end
Polestar.Set("ui.shown", true)
Polestar.Set("ui.width", 280)
T.SetLayout("atlas")
local function draw()
	GF.Layout()
	if GF.Render then GF.Render() end
	GF.Layout()
	stub.advance(1)
	GF.Layout()
end
draw()
local parts = T.GuideParts()
local stack
for _, c in ipairs({ parts.window:GetChildren() }) do if rawget(c, "cards") then stack = c end end
-- A row's target underline: the shown texture under its text, if any.
local function underlined(r)
	for _, t in ipairs({ r:GetRegions() }) do
		if t:GetObjectType() == "Texture" and t:IsShown() and t:GetHeight() <= 1.5 and t:GetWidth() >= 8 then
			local _, rel = t:GetPoint(1)
			if rel == r.Text then return true end
		end
	end
	return false
end
-- A row's target mark: the core's mark shown with its light (GuideFrame.MarkRow).
local function lit(r)
	local m = rawget(r, "Mark")
	local l = m and rawget(m, "psLit")
	return (m and m:IsShown() and l and l:IsShown()) and true or false
end
local function aimed(r) return { lit = lit(r), line = underlined(r) } end`;

const run = (script) => runAddon({
	stubs: ['stub_world.lua'],
	addons: ['Polestar', ATLAS],
	script: `${GUIDE}\n${script}`,
}).emitted[0];

test('an Optional row click points the arrow over a point picked by hand, and lights the row', () => {
	const out = run(`
local r = stack.opt.Rows[1]
Nav.SetTarget(1429, 0.1, 0.1, "Mine")
local before = aimed(r)
stub.RunScript(r, "OnClick", "LeftButton")
stub.advance(0.5)
local t = Nav.GetTarget()
emit({ before = before, x = t.x, y = t.y, override = Nav.IsOverride(), line = aimed(r), mouse = r:IsMouseEnabled() })`);
	assert.deepEqual(out.before, { lit: false, line: false }, 'not lit before');
	assert.deepEqual([out.x, out.y], [0.497, 0.394], 'the arrow on the optional goal');
	assert.equal(out.override, false, 'the hand-set point gave way');
	assert.deepEqual(out.line, { lit: true, line: false }, 'the row shows it is the target: lit, no underline');
	assert.equal(out.mouse, true, 'the row takes the mouse');
});

test('the Along the way row the arrow points at is lit, the others not', () => {
	const out = run(`
local rows = {}
for _, r in ipairs(GF.alongRows) do if r:IsShown() then rows[#rows + 1] = r end end
local r = rows[2]
Nav.SetTarget(1429, 0.5, 0.5, "There")
stub.advance(0.5)
local on = {}
for i, x in ipairs(rows) do on[i] = aimed(x) end
Nav.SetTarget(1429, 0.1, 0.1, "Elsewhere")
stub.advance(0.5)
emit({ on = on, off = aimed(r) })`);
	assert.deepEqual(out.on.map((x) => x.lit), [false, true, false], 'the row at the target');
	assert.ok(out.on.every((x) => !x.line), 'no underline');
	assert.deepEqual(out.off, { lit: false, line: false }, 'the mark goes with the target');
});

test('Along the way rows take their wrapped height: even air, the card holds them', () => {
	const out = run(`
local along = parts.along
local rows = {}
for _, r in ipairs(GF.alongRows) do if r:IsShown() then rows[#rows + 1] = r end end
local list = {}
for _, r in ipairs(rows) do
	local _, _, _, _, y = r:GetPoint(1)
	local _, _, _, _, ty = r.Text:GetPoint(1)
	list[#list + 1] = { y = y, h = r:GetHeight(), top = -ty, text = r.Text:GetStringHeight() }
end
emit({ rows = list, height = along:GetHeight() })`);
	const rows = out.rows;
	assert.equal(rows.length, 3);
	assert.ok(rows.some((r) => r.text > 20), 'a row wraps');
	for (let i = 0; i < rows.length; i++) {
		const r = rows[i];
		assert.ok(r.top + r.text <= r.h - r.top + 0.5, `row ${i + 1}: its text inside it, as much air under as over (${JSON.stringify(r)})`);
		if (i > 0) assert.equal(rows[i].y, rows[i - 1].y - rows[i - 1].h, `row ${i + 1} right under row ${i}`);
	}
	const last = rows[rows.length - 1];
	assert.ok(out.height >= -last.y + last.h, `the card holds its last row: ${out.height} vs ${-last.y + last.h}`);
});

test("While you're here rows take their wrapped height once the count leaves the line", () => {
	const out = run(`
E.GetWhileHereList = function()
	return {
		{ step = 2, index = 1, here = "work", t = "loot", quest = 0, map = 1429, x = 0.49, y = 0.25,
			text = "Collect Shiny Junk from Junk Pile near the mine", progress = { cur = 1, max = 4 }, yards = 60 },
		{ step = 2, index = 2, here = "turnin", t = "turnin", quest = 0, map = 1429, x = 0.52, y = 0.3,
			hereText = "Hand in Mining Consultant to Kelsey Fargo", yards = 185 },
	}
end
GF.FillHere(E)
draw()
local here = parts.here
local list = {}
for i = 1, 2 do
	local r = here.Rows[i]
	local _, _, _, _, y = r:GetPoint(1)
	list[i] = { y = y, h = r:GetHeight(), text = r.Text:GetStringHeight(), shown = r:IsShown(), sub = r.Sub:IsShown() and r.Sub:GetAlpha() > 0 }
end
Nav.SetTarget(1429, 0.52, 0.3, "Kelsey")
stub.advance(0.5)
emit({ rows = list, height = here:GetHeight(), lines = { aimed(here.Rows[1]), aimed(here.Rows[2]) } })`);
	const [a, b] = out.rows;
	assert.ok(a.shown && b.shown, 'both rows shown');
	assert.equal(a.sub, false, 'no step line');
	assert.ok(a.text > 20, `the first row wraps: ${JSON.stringify(a)}`);
	assert.ok(a.h >= a.text + 8, `row 1 holds its text, air over and under: ${JSON.stringify(a)}`);
	assert.equal(b.y, a.y - a.h, 'row 2 right under row 1');
	assert.ok(out.height >= -b.y + b.h, `the card holds its last row: ${out.height}`);
	assert.deepEqual(out.lines, [{ lit: false, line: false }, { lit: true, line: false }], 'the row at the target is lit, not underlined');
});

// In Classic the kit draws its frame 3 in from each frame's edge (the chat
// rim's clear outer pixels, Theme.KitSeam). The cards above stand that much
// closer, so 5 shows between the drawn frames as in the house look, and the
// top bar's progress line starts inside the window's drawn frame.
test('in Classic the cards above stand closer by both rims, and the progress line stays inside the frame', () => {
	const out = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', ATLAS],
		script: `${GUIDE}
local function read()
	draw()
	local seam = T.KitSeam and T.KitSeam(parts.window) or 0
	local lineX
	for _, t in ipairs({ parts.nav:GetRegions() }) do
		if t:GetObjectType() == "Texture" and t:IsShown() and t:GetDrawLayer() == "ARTWORK" and t:GetHeight() <= 2.5 and t:GetHeight() > 0 then
			local p, rel, _, x = t:GetPoint(1)
			if rel == parts.nav and p == "BOTTOMLEFT" then lineX = x end
		end
	end
	local _, rel, _, _, y = stack:GetPoint(1)
	return { seam = seam, gap = rel == parts.window and y or false, lineX = lineX or false }
end
local house = read()
Polestar.Set("ui.skin", "classic")
stub.advance(0.5)
local classic = read()
emit({ house = house, classic = classic })`,
	}).emitted[0];
	assert.equal(out.house.seam, 0, JSON.stringify(out));
	assert.equal(out.house.gap, 5, 'the house look: 5 between the window and the cards');
	assert.ok(out.classic.seam > 0, 'Classic has a clear rim: ' + JSON.stringify(out));
	assert.equal(out.classic.gap, 5 - 2 * out.classic.seam, 'Classic: closer by both rims');
	assert.equal(out.house.lineX, 0, 'the house look: the progress line from the window\'s edge');
	assert.equal(out.classic.lineX, out.classic.seam, 'Classic: the progress line starts inside the rim');
});

// A card folds to its heading (a click on it) and opens again (a click on
// the folded card); the fold is kept per card (ui.atlasFolded.<card>), the
// × still closes the card for the step.
test('a card folds to its heading and count, and a click opens it again', () => {
	const out = run(`
local function card(f)
	local b = f:GetParent()
	return { shown = f:IsShown(), h = b:GetHeight() }
end
local optional = stack.opt
local openH = optional:GetParent():GetHeight()
local head = optional:GetParent().Fold
local headShown = head:IsShown()
stub.RunScript(head, "OnClick", "LeftButton")
draw()
local strip = stack.folds and stack.folds.opt
local folded = { opt = optional:IsShown(), strip = strip and strip:IsShown() or false, text = strip and strip.Label:GetText() or false,
	h = strip and strip:GetParent():GetHeight() or 0, saved = Polestar.Get("ui.atlasFolded.opt") }
local alongShown = parts.along:IsShown()
stub.RunScript(strip, "OnClick", "LeftButton")
draw()
emit({ openH = openH, headShown = headShown, folded = folded, alongShown = alongShown,
	reopened = optional:IsShown(), stripAfter = strip:IsShown(), saved = Polestar.Get("ui.atlasFolded.opt") or false })`);
	assert.equal(out.headShown, true, "the open card's heading folds it");
	assert.equal(out.folded.opt, false, 'folded: its rows hide');
	assert.equal(out.folded.strip, true, 'folded: its heading strip shows');
	assert.equal(out.folded.text, 'OPTIONAL  ·  1', 'the heading and its count');
	assert.ok(out.folded.h < out.openH, `the folded card is shorter: ${out.folded.h} vs ${out.openH}`);
	assert.equal(out.folded.saved, true, 'the fold is kept');
	assert.equal(out.alongShown, true, 'the other cards stay open');
	assert.equal(out.reopened, true, 'a click on the folded card opens it');
	assert.equal(out.stripAfter, false);
	assert.equal(out.saved, false);
});
