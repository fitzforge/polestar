'use strict';
// The step number in the guide window's Up next rows (UI/GuideFrame.lua
// GF.FitNumColumn): a 22 px column that grows to the widest number shown, up
// to the verb glyph, so a three-digit step (or a raised Up next size) keeps
// the row's number size and never reads "1...".
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const GUIDE = `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
local steps = {}
for i = 1, 130 do steps[i] = { goals = { { t = "note", text = "Step note " .. i } } } end
Polestar.RegisterGuide({ id = "test/long", pack = "test", title = "Long", minLevel = 1, maxLevel = 20, steps = steps })
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
local GF = Polestar.UI.GuideFrame
Polestar.Set("ui.shown", true)
Polestar.Set("ui.upcoming", 1)
Polestar.Set("ui.upcomingOpen", true)
local function goto(step)
	Polestar.Engine.Goto(step)
	stub.advance(1)
	GF.Render()
	GF.Layout()
	stub.advance(1)
	return GF.upRows[1]
end`;

function read(size) {
	return runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		script: `${GUIDE}
Polestar.Set("guideWindow.upSize", ${size})
local function read(step)
	local r = goto(step)
	local _, size = r.Num:GetFont()
	local left = r.Num:GetLeft() or 0
	return { shown = r:IsShown(), text = r.Num:GetText(), w = r.Num:GetWidth(), size = size,
		str = r.Num:GetUnboundedStringWidth(), right = left + r.Num:GetWidth(), icon = r.Icon:GetLeft() }
end
emit({ two = read(30), three = read(119), back = read(30) })`,
	}).emitted[0];
}

test('a three-digit Up next number keeps the row\'s number size, its column 22 px or wider', () => {
	const out = read(1);
	assert.equal(out.two.shown, true, JSON.stringify(out));
	assert.equal(out.two.w, 22, 'two digits: the 22 px column');
	assert.equal(out.three.text, '120');
	assert.equal(out.three.size, out.two.size, 'three digits at the same size');
	assert.ok(out.three.w >= 22 && out.three.str <= out.three.w, 'the number fits its column: ' + JSON.stringify(out.three));
	assert.equal(out.back.w, 22, 'two digits again: the 22 px column');
});

test('at the largest Up next size the column grows to the glyph, and only what still overflows is drawn smaller, not under 11 px', () => {
	const out = read(1.8);
	assert.ok(out.three.w > 22, 'the column grew: ' + JSON.stringify(out.three));
	assert.ok(out.three.str <= out.three.w, 'the number fits: ' + JSON.stringify(out.three));
	assert.ok(out.three.size >= 11, 'never under 11 px: ' + JSON.stringify(out.three));
	assert.ok(out.three.size >= out.two.size * 0.9, 'only a little smaller than two digits: ' + JSON.stringify(out));
	assert.equal(out.back.size, out.two.size, 'two digits again: the full size');
	assert.equal(out.back.w, out.two.w, 'two digits again: the same column');
});

test('at the large Up next sizes the smaller size is the same on every render, and the fit never shares the window\'s height-fit table', () => {
	for (const size of [1.75, 1.8]) {
		const out = runAddon({
			stubs: ['stub_world.lua'],
			addons: ['Polestar'],
			script: `${GUIDE}
Polestar.Set("guideWindow.upSize", ${size})
local r = goto(119)
local sizes, fits = {}, true
for i = 1, 6 do
	GF.Render(); GF.Layout(); stub.advance(0.2)
	local _, s = r.Num:GetFont()
	sizes[i] = s
	if r.Num:GetUnboundedStringWidth() > r.Num:GetWidth() then fits = false end
end
local stray = false
for k in pairs(GF.fit or {}) do if type(k) == "table" then stray = true end end
emit({ sizes = sizes, fits = fits, stray = stray })`,
		}).emitted[0];
		assert.equal(new Set(out.sizes).size, 1, `${size}: one size on every render: ${JSON.stringify(out.sizes)}`);
		assert.equal(out.fits, true, `${size}: the number fits its column on every render`);
		assert.equal(out.stray, false, `${size}: no font string keys in GF.fit`);
	}
});

test('a new font face or outline measures the number again; a plain redraw does not', () => {
	const out = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		script: `${GUIDE}
Polestar.Set("guideWindow.upSize", 1.8)
local r = goto(119)
local n, count = r.Num, 0
local measure = n.GetUnboundedStringWidth
n.GetUnboundedStringWidth = function(self) count = count + 1; return measure(self) end
-- The measures a change brings (its own repaint, then a redraw).
local function after(key, value)
	count = 0
	if key then Polestar.Set(key, value) end
	GF.Render(); GF.Layout(); stub.advance(0.2)
	return count
end
local same = after()
local face = after("ui.font", "inter")
local outline = after("ui.fontOutline", "thick")
emit({ same = same, face = face, outline = outline, fits = n:GetUnboundedStringWidth() <= n:GetWidth() })`,
	}).emitted[0];
	assert.equal(out.same, 0, 'a plain redraw keeps the measured width: ' + JSON.stringify(out));
	assert.ok(out.face > 0, 'a new face measures again: ' + JSON.stringify(out));
	assert.ok(out.outline > 0, 'a new outline measures again: ' + JSON.stringify(out));
	assert.equal(out.fits, true);
});
