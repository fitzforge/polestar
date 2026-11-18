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

// The settings window and the guide menu share one rule: the same size and
// scale, also on a screen where the skin's own picker size is the bigger one
// (3840 x 2160 pixels under a 1920 x 1080 UIParent: 975 x 710 units).
const both = (scale, physical) => runAddon({
	stubs: ['stub_world.lua'],
	addons: ['Polestar'],
	login: true,
	before: physical ? `function GetPhysicalScreenSize() return ${physical}, ${physical * 9 / 16} end` : '',
	script: `
Polestar.Set("ui.menuScale", ${scale})
Polestar.UI.ShowPicker()
Polestar.UI.ShowOptions()
local p, o = PolestarPicker, PolestarOptions
emit({ pw = p:GetWidth(), ph = p:GetHeight(), ps = p:GetEffectiveScale(),
	ow = o:GetWidth(), oh = o:GetHeight(), os = o:GetEffectiveScale() })`,
}).emitted[0];

test('settings window and guide menu: same size and scale at 75 % and 100 %', () => {
	for (const physical of [0, 3840, 2560]) {
		for (const scale of [0.75, 1]) {
			const a = both(scale, physical);
			assert.equal(a.pw, a.ow, JSON.stringify([physical, scale, a]));
			assert.equal(a.ph, a.oh, JSON.stringify([physical, scale, a]));
			assert.equal(a.ps, a.os, JSON.stringify([physical, scale, a]));
		}
	}
});
