'use strict';
// The step number in the guide window's Up next rows (UI/GuideFrame.lua
// GF.FitNum): 22 wide unless a layout sets a narrower column; a three-digit
// step is drawn at 80% of the number size, then smaller until its measured
// text fits the column, so it never reads "1...".
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

test('an Up next three-digit step number is 20% smaller in the same column', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		script: `${GUIDE}
local function read(step)
	local r = goto(step)
	local _, size = r.Num:GetFont()
	return { shown = r:IsShown(), text = r.Num:GetText(), w = r.Num:GetWidth(), size = size, str = r.Num:GetUnboundedStringWidth() }
end
emit({ two = read(30), three = read(119), back = read(30) })`,
	}).emitted;
	assert.equal(out.two.shown, true, JSON.stringify(out));
	assert.equal(out.two.w, 22, 'two digits: the 22 px column');
	assert.equal(out.three.text, '120');
	assert.equal(out.three.w, 22, 'three digits: the same column');
	assert.ok(out.three.size <= Math.floor(out.two.size * 0.8 + 0.5), 'three digits at 80% or less: ' + JSON.stringify(out));
	assert.ok(out.three.str <= 21, 'the number fits its column: ' + JSON.stringify(out.three));
	assert.equal(out.back.size, out.two.size, 'two digits again: the full size');
});

test('a three-digit number steps down until its measured width fits the column', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		script: `${GUIDE}
local r = goto(119)
local res = {}
for _, col in ipairs({ 22, 18, 14, 8 }) do
	GF.FitNum(r, col)
	local _, size = r.Num:GetFont()
	res[#res + 1] = { col = col, size = size, str = r.Num:GetUnboundedStringWidth(), w = r.Num:GetWidth() }
end
r.Num:SetText("30"); GF.FitNum(r, 22)
local _, two = r.Num:GetFont()
r.Num:SetText("120"); r.Num.psColumn = 14; GF.FitNum(r)
local _, viaField = r.Num:GetFont()
emit({ res = res, two = two, base = r.Num.psNumBase, viaField = viaField, wField = r.Num:GetWidth(), strField = r.Num:GetUnboundedStringWidth() })`,
	}).emitted;
	const floorSize = Math.floor(out.base * 0.6 + 0.5);
	for (const c of out.res) {
		assert.equal(c.w, c.col, 'the column is the width asked');
		assert.ok(c.str <= c.col || c.size === floorSize, `width ${c.str} fits column ${c.col} (size ${c.size})`);
		assert.ok(c.size >= floorSize, 'never below 60% of the base');
	}
	assert.ok(out.res[2].size < out.res[0].size, 'a narrower column gives a smaller size: ' + JSON.stringify(out.res));
	assert.equal(out.two, out.base, 'two digits: the full size again');
	assert.equal(out.wField, 14, 'n.psColumn is the column when none is passed');
	assert.ok(out.strField <= 14);
});
