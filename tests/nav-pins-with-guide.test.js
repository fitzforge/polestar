'use strict';
// "Hide the pins with the guide" (nav.hidePinsWithGuide): hiding the guide
// window (ui.shown) takes the guide's map pins off the world map and the
// minimap (Nav/Layers.lua, Nav.PinsHiddenWithGuide), and showing it brings
// them back. Off, the pins ignore the window, as before.
// Runs the real Core/Init.lua + Nav/Nav.xml against tests/lua/stub_nav.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function run(script) {
	return runAddon({
		stubs: ['stub_nav.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] }],
		login: true,
		script: `local N, nav, P = Polestar.Nav, stub.nav, Polestar.Pins
local m, x, y = nav.mapPoint(200, 0)
nav.setWaypoint({ map = m, x = x, y = y, label = "Talk to Marshal Dughan", stepIndex = 1, goalIndex = 1, kind = "talk", r = 8 })
nav.showWorldMap(9000)
local function world()
	local n = 0
	for _, pin in ipairs(nav.pins()) do if pin.data.layer.name == "nav.target" then n = n + 1 end end
	return n
end
local function minimap() return #P.GetMinimapFrames("nav.target") end
${script}`,
	}).emitted[0];
}

test('Off by default: hiding the guide window leaves the target pin on both maps', () => {
	const out = run(`
		local r = { default = Polestar.Get("nav.hidePinsWithGuide"), world = world(), minimap = minimap() }
		Polestar.Set("ui.shown", false)
		r.hiddenWorld, r.hiddenMinimap, r.gone = world(), minimap(), N.PinsHiddenWithGuide()
		emit(r)`);
	assert.equal(out.default, false);
	assert.equal(out.world, 1);
	assert.ok(out.minimap > 0, 'the target pin is on the minimap');
	assert.equal(out.hiddenWorld, 1);
	assert.equal(out.hiddenMinimap, out.minimap);
	assert.equal(out.gone, false);
});

test('On: hiding the guide window takes the target pin off both maps, showing it brings it back', () => {
	const out = run(`
		Polestar.Set("nav.hidePinsWithGuide", true)
		local r = { world = world(), minimap = minimap() }
		Polestar.Set("ui.shown", false)
		r.hiddenWorld, r.hiddenMinimap, r.gone = world(), minimap(), N.PinsHiddenWithGuide()
		Polestar.Set("ui.shown", true)
		r.backWorld, r.backMinimap = world(), minimap()
		Polestar.Set("ui.shown", false)
		Polestar.Set("nav.hidePinsWithGuide", false)
		r.offWorld = world()
		emit(r)`);
	assert.equal(out.world, 1);
	assert.ok(out.minimap > 0);
	assert.equal(out.gone, true);
	assert.equal(out.hiddenWorld, 0);
	assert.equal(out.hiddenMinimap, 0);
	assert.equal(out.backWorld, 1);
	assert.equal(out.backMinimap, out.minimap);
	assert.equal(out.offWorld, 1, 'turning the switch off while hidden brings the pin back');
});
