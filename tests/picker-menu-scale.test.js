'use strict';
// The guide picker takes the settings window's size (W.ShellDefaultSize) and
// the Guides scale once, so at 75 % it is the same share of the screen as the
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
Polestar.Set("ui.pickerScale", ${scale})
Polestar.UI.ShowPicker()
local f = PolestarPicker
local dw, dh = W.ShellDefaultSize()
emit({ w = f:GetWidth(), h = f:GetHeight(), scale = f:GetScale(), dw = dw, dh = dh })`,
}).emitted[0];

test('the picker is the settings window size, scaled once by the Guides scale', () => {
	const a = run(0.75);
	assert.equal(a.scale, 0.75);
	assert.equal(a.w, a.dw);
	assert.equal(a.h, a.dh);
	assert.equal(run(1).scale, 1);
});

test('the picker stays inside the screen at a large Guides scale', () => {
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
Polestar.Set("ui.pickerScale", ${scale})
Polestar.Set("ui.menuScale", ${scale})
Polestar.UI.ShowPicker()
Polestar.UI.ShowOptions()
local p, o = PolestarPicker, PolestarOptions
emit({ pw = p:GetWidth(), ph = p:GetHeight(), ps = p:GetEffectiveScale(),
	ow = o:GetWidth(), oh = o:GetHeight(), os = o:GetEffectiveScale() })`,
}).emitted[0];

test('settings window and guide menu: same size; the settings window draws at 0.8 of its scale', () => {
	for (const physical of [0, 3840, 2560]) {
		for (const scale of [0.75, 1]) {
			const a = both(scale, physical);
			assert.equal(a.pw, a.ow, JSON.stringify([physical, scale, a]));
			assert.equal(a.ph, a.oh, JSON.stringify([physical, scale, a]));
			assert.ok(Math.abs(a.os - a.ps * 0.8) < 1e-9, JSON.stringify([physical, scale, a]));
		}
	}
});

const scales = (script, saved) => runAddon({
	stubs: ['stub_world.lua'],
	addons: ['Polestar'],
	login: true,
	saved: saved ? { Polestar: saved } : undefined,
	script: `
Polestar.UI.ShowPicker()
Polestar.UI.ShowOptions()
local p, o = PolestarPicker, PolestarOptions
${script}
emit({ p = p:GetScale(), o = o:GetScale(), pk = Polestar.Get("ui.pickerScale"), mk = Polestar.Get("ui.menuScale") })`,
}).emitted[0];

test('at menu scale 1 the settings window is 0.8 and the guides window 1.0', () => {
	const a = scales('');
	assert.equal(a.o, 0.8);
	assert.equal(a.p, 1);
});

test('each scale setting rescales only its own window, live', () => {
	const a = scales('Polestar.Set("ui.menuScale", 1.2)');
	assert.ok(Math.abs(a.o - 0.96) < 1e-9, JSON.stringify(a));
	assert.equal(a.p, 1);
	const b = scales('Polestar.Set("ui.pickerScale", 0.75)');
	assert.equal(b.p, 0.75);
	assert.equal(b.o, 0.8);
});

test('a saved menu scale is copied to the guides scale once; the settings scale stays as saved', () => {
	const a = scales('', 'PolestarDB = { schema = 1, settings = { ui = { menuScale = 0.75 } } }');
	assert.equal(a.pk, 0.75);
	assert.equal(a.mk, 0.75);
	assert.equal(a.p, 0.75);
	assert.ok(Math.abs(a.o - 0.6) < 1e-9, JSON.stringify(a));
	const b = scales('', 'PolestarDB = { schema = 1, settings = { ui = { menuScale = 1 } } }');
	assert.equal(b.p, 1);
	const c = scales('', 'PolestarDB = { schema = 1, settings = { ui = { menuScale = 0.75, pickerScale = 1.1 } } }');
	assert.equal(c.pk, 1.1);
});

// The shared default is 16:9 (1680 x 946 on a 1080p screen); the picker's
// extra width goes to its list pane, the sidebar and details pane keep theirs.
test('default size is 16:9 and the picker list pane takes the extra width', () => {
	const a = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		login: true,
		script: `
local W = Polestar.Widgets
local dw, dh = W.ShellDefaultSize()
Polestar.UI.ShowPicker()
local p = PolestarPicker
Polestar.UI.ShowOptions()
local o = PolestarOptions
emit({ dw = dw, dh = dh, pw = p:GetWidth(), ph = p:GetHeight(), body = p.BodyWidth, side = p.Sidebar:GetWidth(),
	oside = o.Sidebar:GetWidth(), omain = o.Main:GetWidth(), ow = o:GetWidth() })`,
	}).emitted[0];
	assert.ok(Math.abs(a.dw / a.dh - 16 / 9) < 0.02, JSON.stringify(a));
	assert.equal(a.pw, a.dw);
	// the list pane is what is left after the rail, sidebar and 372 details pane: ~1000 of 1680
	assert.ok(a.body > 900 && a.body < a.pw - a.side - 372, JSON.stringify(a));
	assert.ok(a.side < 400 && a.oside < 400, JSON.stringify(a));
	// the settings window's sidebar stays fixed (its main column is what grows)
	assert.equal(a.oside, a.side, JSON.stringify(a));
});
