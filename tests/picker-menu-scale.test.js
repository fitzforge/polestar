'use strict';
// The guide picker keeps the skin's size in the game's UI units (pickerW
// beside the rail, pickerH: 1208 x 680 by default) and takes the Guides scale
// once; the settings window has its own size rule (W.ShellDefaultSize) and its
// own scale. Each scale draws inside its slider's range, whatever it holds, and
// the Guides scale is on screen on every page: in the header, or on the details
// pane's art where the pane holds the close button.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const SKIN = `local W, Theme = Polestar.Widgets, Polestar.Theme
local sw, sh = Theme.Metric("pickerW", 1120) + W.SHELL.rail, Theme.Metric("pickerH", W.SHELL.height)`;

const run = (scale) => runAddon({
	stubs: ['stub_world.lua'],
	addons: ['Polestar'],
	login: true,
	script: `
${SKIN}
Polestar.Set("ui.pickerScale", ${scale})
Polestar.UI.ShowPicker()
local f = PolestarPicker
emit({ w = f:GetWidth(), h = f:GetHeight(), scale = f:GetScale(), sw = sw, sh = sh })`,
}).emitted[0];

test('the picker opens at the skin\'s size, scaled once by the Guides scale', () => {
	const a = run(0.75);
	assert.equal(a.scale, 0.75);
	assert.equal(a.w, a.sw);
	assert.equal(a.h, a.sh);
	assert.deepEqual([a.sw, a.sh], [1208, 680], 'the default skin: 1120 beside the 88 rail, 680 tall');
	assert.equal(run(1).scale, 1);
});

test('the picker stays inside the screen at the largest Guides scale', () => {
	const a = run(1.4);
	assert.equal(a.scale, 1.4);
	assert.ok(a.w * a.scale <= 1920 && a.h * a.scale <= 1080, JSON.stringify(a));
});

test('a Guides scale outside the slider (an imported 0.1 or 9) draws at its nearest end, 70 % or 140 %', () => {
	assert.equal(run(0.1).scale, 0.7);
	assert.equal(run(9).scale, 1.4);
	assert.equal(run('"big"').scale, 1);
});

// The guides window keeps its size in UI units on any screen; the settings
// window takes its share of the screen (3840 x 2160 pixels under a 1920 x 1080
// UIParent: half the units).
const both = (physical) => runAddon({
	stubs: ['stub_world.lua'],
	addons: ['Polestar'],
	login: true,
	before: physical ? `function GetPhysicalScreenSize() return ${physical}, ${physical * 9 / 16} end` : '',
	script: `
${SKIN}
Polestar.UI.ShowPicker()
Polestar.UI.ShowOptions()
local p, o = PolestarPicker, PolestarOptions
local dw, dh = W.ShellDefaultSize()
emit({ pw = p:GetWidth(), ph = p:GetHeight(), sw = sw, sh = sh, ow = o:GetWidth(), oh = o:GetHeight(), dw = dw, dh = dh })`,
}).emitted[0];

test('the guides window keeps the skin\'s size on any screen; the settings window follows the screen', () => {
	for (const physical of [0, 3840, 2560]) {
		const a = both(physical);
		assert.deepEqual([a.pw, a.ph], [a.sw, a.sh], JSON.stringify([physical, a]));
		assert.deepEqual([a.ow, a.oh], [a.dw, a.dh], JSON.stringify([physical, a]));
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

test('at menu scale 1 the settings window is 0.92 and the guides window 1.0', () => {
	const a = scales('');
	assert.equal(a.o, 0.92);
	assert.equal(a.p, 1);
});

test('each scale setting rescales only its own window, live', () => {
	const a = scales('Polestar.Set("ui.menuScale", 1.2)');
	assert.ok(Math.abs(a.o - 1.2 * 0.92) < 1e-9, JSON.stringify(a));
	assert.equal(a.p, 1);
	const b = scales('Polestar.Set("ui.pickerScale", 0.75)');
	assert.equal(b.p, 0.75);
	assert.equal(b.o, 0.92);
	const c = scales('Polestar.Set("ui.menuScale", 9)');
	assert.ok(Math.abs(c.o - 1.4 * 0.92) < 1e-9, JSON.stringify(c));
});

test('a saved menu scale is copied to the guides scale once, as it was saved', () => {
	const a = scales('', 'PolestarDB = { schema = 1, settings = { ui = { menuScale = 0.9 } } }');
	assert.equal(a.pk, 0.9);
	assert.equal(a.p, 0.9);
	const b = scales('', 'PolestarDB = { schema = 1, settings = { ui = { menuScale = 1 } } }');
	assert.equal(b.p, 1);
	const c = scales('', 'PolestarDB = { schema = 1, settings = { ui = { menuScale = 0.75, pickerScale = 1.1 } } }');
	assert.equal(c.pk, 1.1);
});

// #3789: the settings window draws at 0.92 x its setting. A release (0.4.2 and
// before) drew it at 1 x, the 0.4.3 previews at 0.8 x; a saved scale moves once
// (a release's divided by 0.92, a preview's by 1.15: a preview save had run
// "pickerScale"), within 70-140 %, so the window draws at the scale its player
// chose. The default window is wider and shorter (1546 x 870 at 1080p where a
// release drew 1300 x 946). The guides window keeps its own scale.
const drawn = (saved) => runAddon({
	stubs: ['stub_world.lua'],
	addons: ['Polestar'],
	login: true,
	saved: saved ? { Polestar: saved } : undefined,
	before: 'function GetPhysicalScreenSize() return 1920, 1080 end',
	script: `
Polestar.UI.ShowOptions()
local o = PolestarOptions
local per = 1080 / UIParent:GetHeight()
emit({ w = o:GetWidth() * o:GetScale() * per, h = o:GetHeight() * o:GetScale() * per, o = o:GetScale(), mk = Polestar.Get("ui.menuScale"),
	stored = PolestarDB.settings.ui and PolestarDB.settings.ui.menuScale, pk = Polestar.Get("ui.pickerScale"), ran = PolestarDB.migrations.menuScale092 })`,
}).emitted[0];
const near = (a, b, what) => assert.ok(Math.abs(a - b) < 1e-6, `${what}: ${a} is not ${b}`);

test('a release save\'s settings scale draws the settings window at the scale it drew in 0.4.2', () => {
	for (const s of [1.2, 1, 0.8]) {
		const r = drawn(`PolestarDB = { schema = 1, settings = { ui = { menuScale = ${s} } } }`);
		near(r.o, s, `saved ${s}: the window's scale`);
		near(r.mk, s / 0.92, `saved ${s}: the setting`);
		assert.equal(r.pk, s === 1 ? 1 : s, `saved ${s}: the guides window keeps the number it had`);
		assert.equal(r.ran, true);
	}
	const r100 = drawn('PolestarDB = { schema = 1, settings = { ui = { menuScale = 1 } } }');
	near(r100.w, 1680, 'saved 1: 16:9 at the scale 0.4.2 drew');
	near(r100.h, 946, 'saved 1: as tall as 0.4.2 drew it');
	const r80 = drawn('PolestarDB = { schema = 1, settings = { ui = { menuScale = 0.8 } } }');
	near(r80.w, 1680 * 0.8, 'saved 0.8: width');
	near(r80.h, 946 * 0.8, 'saved 0.8: height');
	// 0.4.2's 130 % and 140 % are past the slider's 140 % x 0.92: they draw at the most there is.
	const top = drawn('PolestarDB = { schema = 1, settings = { ui = { menuScale = 1.4 } } }');
	assert.equal(top.mk, 1.4);
	near(top.o, 1.4 * 0.92, 'saved 1.4: the window\'s scale');
});

test('a 0.4.3 preview save (0.8 x its setting) keeps its size; a fresh install draws at 0.92', () => {
	const preview = drawn('PolestarDB = { schema = 1, migrations = { pickerScale = true }, settings = { ui = { menuScale = 1, pickerScale = 1.1 } } }');
	near(preview.o, 0.8, 'the preview drew 100 % at 0.8');
	near(preview.mk, 1 / 1.15, 'the setting');
	assert.equal(preview.pk, 1.1, 'the guides scale untouched');
	const was115 = drawn('PolestarDB = { schema = 1, migrations = { pickerScale = true }, settings = { ui = { menuScale = 1.15 } } }');
	assert.equal(was115.mk, 1, 'the preview\'s 115 % reads 100 %');
	assert.equal(was115.stored, undefined, 'the default, nothing stored');
	const low = drawn('PolestarDB = { schema = 1, migrations = { pickerScale = true }, settings = { ui = { menuScale = 0.75 } } }');
	assert.equal(low.mk, 0.7, 'within the slider: 65 % is 70 %');
	const fresh = drawn();
	assert.equal(fresh.o, 0.92);
	assert.equal(fresh.stored, undefined);
	near(fresh.w, 1680 * 0.92, 'the default window\'s width');
	near(fresh.h, 946 * 0.92, 'the default window\'s height');
	const once = drawn('PolestarDB = { schema = 1, migrations = { pickerScale = true, menuScale092 = true }, settings = { ui = { menuScale = 1.15 } } }');
	assert.equal(once.mk, 1.15, 'once: a scale saved after the move stays as it is');
});

test('a profile string moves its settings scale by the version it is from', () => {
	const [r] = runAddon({
		stubs: ['stub_world.lua', 'stub_encoding.lua'],
		addons: ['Polestar'],
		login: true,
		script: `
local P = Polestar.Profiles
local release = assert(P.Import(P.Pack('{"format":1,"migrations":["guideTextSize"],"settings":{"ui.menuScale":1.2}}')))
local preview = assert(P.Import(P.Pack('{"format":1,"migrations":["guideTextSize","pickerScale"],"settings":{"ui.menuScale":1.2}}')))
emit({ release = release.settings["ui.menuScale"], preview = preview.settings["ui.menuScale"] })`,
	}).emitted;
	near(r.release, 1.2 / 0.92, 'a release string');
	near(r.preview, 1.2 / 1.15, 'a preview string');
});

// The settings window's default is 16:9 (1680 x 946 on a 1080p screen), its
// sidebar fixed; the guides window's list pane is what the skin leaves it.
test('the settings window opens at 16:9; the guides window\'s panes keep the skin\'s widths', () => {
	const a = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		login: true,
		script: `
${SKIN}
local dw, dh = W.ShellDefaultSize()
Polestar.UI.ShowPicker()
local p = PolestarPicker
Polestar.UI.ShowOptions()
local o = PolestarOptions
emit({ dw = dw, dh = dh, pw = p:GetWidth(), sw = sw, side = p.Sidebar:GetWidth(), oside = o.Sidebar:GetWidth(), ow = o:GetWidth() })`,
	}).emitted[0];
	assert.ok(Math.abs(a.dw / a.dh - 16 / 9) < 0.02, JSON.stringify(a));
	assert.equal(a.ow, a.dw);
	assert.equal(a.pw, a.sw);
	assert.equal(a.oside, a.side, JSON.stringify(a));
});

// The Guides scale is a button of sizes beside the close button: on Guides,
// where the details pane holds the close button, on its art left of the star,
// the star's dark ground widened for it; on Lookup in the header beside the
// close button; in the game's looks (the frame's own close) the same places.
test('the Guides scale is a button beside the close button on every page: on the details art on Guides, in the header elsewhere', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		login: true,
		script: `
local UI = Polestar.UI
UI.ShowPicker()
local f, d = PolestarPicker, UI.Picker.details
local t = f.HeaderTools
local function at()
	local p, rel, rp, x = t:GetPoint(1)
	return { shown = t:IsVisible(), art = t:GetParent() == d.Art.Over, header = t:GetParent() == f.Header,
		star = rel == d.Star, close = rel == f.Close, p = p, rp = rp, x = x, ground = d.Scrim:GetWidth(),
		button = t:GetObjectType() == "Button", slider = rawget(t, "Thumb") ~= nil }
end
local guides = at()
UI.Picker.ShowSection("Lookup")
local lookup = at()
UI.Picker.ShowSection(nil)
local back = at()
Polestar.Set("ui.skin", "blizzard")
UI.Picker.ShowSection("Lookup")
local gameLookup = at()
UI.Picker.ShowSection(nil)
local game = at()
emit({ guides = guides, lookup = lookup, back = back, gameLookup = gameLookup, game = game })`,
	}).emitted;
	const g = out.guides;
	assert.deepEqual([g.shown, g.button, g.slider, g.art, g.star, g.p, g.rp, g.x], [true, true, false, true, true, 'RIGHT', 'LEFT', -4], JSON.stringify(g));
	assert.equal(g.ground, 100, 'the star and close\'s ground (68) widened by the button\'s 32');
	const l = out.lookup;
	assert.deepEqual([l.shown, l.header, l.close, l.p, l.rp, l.x], [true, true, true, 'RIGHT', 'LEFT', -4], JSON.stringify(l));
	assert.deepEqual([out.back.art, out.back.ground], [true, 100], 'back on the art with Guides');
	assert.deepEqual([out.gameLookup.header, out.gameLookup.close], [true, true], 'the game\'s looks: where the frame\'s close is');
	assert.deepEqual([out.game.art, out.game.star, out.game.ground], [true, true, 68], 'the game\'s looks: the star\'s ground (36) widened by 32');
});

// Its click lists the sizes, the current one ticked (a saved size between the
// steps listed too); a pick sets it (100 % back to the default), right-click
// resets, the wheel steps by 5 % inside 70-140 %.
test('the Guides scale button opens the sizes, the current one ticked; a pick, right-click and the wheel set it', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		login: true,
		script: `
local W = Polestar.Widgets
Polestar.Set("ui.pickerScale", 0.75)
Polestar.UI.ShowPicker()
local f = PolestarPicker
local t = f.HeaderTools
local items
local show = W.ShowMenu
W.ShowMenu = function(anchor, list, opts) items = list return show(anchor, list, opts) end
local function sizes()
	t:Click("LeftButton")
	local out = {}
	for _, it in ipairs(items) do out[#out + 1] = (it.checked and "*" or "") .. it.text end
	return out
end
local r = { first = sizes() }
items[6].onClick()
r.picked = { Polestar.Get("ui.pickerScale"), f:GetScale(), sizes() }
for _, it in ipairs(items) do if it.text == "100%" then it.onClick() end end
r.default = { Polestar.Get("ui.pickerScale"), PolestarDB.settings.ui and PolestarDB.settings.ui.pickerScale }
Polestar.Set("ui.pickerScale", 1.3)
t:Click("RightButton")
r.reset = Polestar.Get("ui.pickerScale")
Polestar.Set("ui.pickerScale", 1.4)
stub.RunScript(t, "OnMouseWheel", 1)
r.top = Polestar.Get("ui.pickerScale")
stub.RunScript(t, "OnMouseWheel", -1)
r.down = Polestar.Get("ui.pickerScale")
emit(r)`,
	}).emitted;
	assert.deepEqual(out.first, ['70%', '*75%', '80%', '90%', '100%', '110%', '120%', '130%', '140%']);
	assert.equal(out.picked[0], 1.1);
	assert.equal(out.picked[1], 1.1, 'the window rescales');
	assert.deepEqual(out.picked[2], ['70%', '80%', '90%', '100%', '*110%', '120%', '130%', '140%'], 'a size on the steps: no extra row');
	assert.deepEqual(out.default, [1], '100 % is the default, nothing stored (emit drops the nil)');
	assert.equal(out.reset, 1);
	assert.equal(out.top, 1.4, 'held at 140 %');
	assert.equal(out.down, 1.35);
});
