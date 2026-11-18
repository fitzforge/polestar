'use strict';
// The guide picker takes the settings window's size (W.ShellDefaultSize) and
// the Menu scale once, so at 75 % it is the same share of the screen as the
// settings window (it was 1188 x 640 beside the settings window's 1300 x 946).
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const run = (scale) => runAddon({
	stubs: ['stub_world.lua'],
	addons: ['Polestar'],
	login: true,
	script: `
local W = Polestar.Widgets
Polestar.Set("ui.menuScale", ${scale})
Polestar.UI.ShowPicker()
local f = PolestarPicker
local dw, dh = W.ShellDefaultSize()
emit({ w = f:GetWidth(), h = f:GetHeight(), scale = f:GetScale(), dw = dw, dh = dh })`,
}).emitted[0];

test('the picker is the settings window size, scaled once by the Menu scale', () => {
	const a = run(0.75);
	assert.equal(a.scale, 0.75);
	assert.equal(a.w, a.dw);
	assert.equal(a.h, a.dh);
	assert.equal(run(1).scale, 1);
});

test('the picker stays inside the screen at a large Menu scale', () => {
	const a = run(2);
	assert.equal(a.scale, 2);
	assert.ok(a.w * a.scale <= 1920 && a.h * a.scale <= 1080, JSON.stringify(a));
});
