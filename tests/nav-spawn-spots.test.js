'use strict';
// The target's other spawn spots on the world map (addon/Polestar/Nav/Layers.lua,
// layer nav.spots) and the Map pins switch that hides them (nav.spawnSpots, #2034).
// Runs the real Core/Init.lua + Nav/Nav.xml against tests/lua/stub_nav.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function run(script) {
	return runAddon({
		stubs: ['stub_nav.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] }],
		login: true,
		script: `local N, nav = Polestar.Nav, stub.nav
local spots = {}
for i, p in ipairs({ { 200, 0 }, { 0, 300 }, { -200, 0 } }) do
	local _, x, y = nav.mapPoint(p[1], p[2])
	spots[i] = { x = x, y = y, r = 60, n = 2 }
end
local m, x, y = nav.mapPoint(200, 0)
local function marks()
	local n = 0
	for _, pin in ipairs(nav.pins()) do if pin.data.layer.name == "nav.spots" then n = n + 1 end end
	return n
end
${script}`,
	}).emitted[0];
}

test('Spawn spots on by default marks the other spots; off hides them and on brings them back, the target pin stays', () => {
	const out = run(`
		local r = { default = Polestar.Get("nav.spawnSpots") }
		nav.setWaypoint({ map = m, x = x, y = y, label = "Collect Raptor Head", stepIndex = 1, goalIndex = 1,
			kind = "collect", area = 60, search = true, spots = spots, spot = 1, r = 8 })
		nav.showWorldMap(9000)
		r.on = marks()
		Polestar.Set("nav.spawnSpots", false)
		r.off = marks()
		r.target = #Polestar.Pins.GetLayer("nav.target") > 0
		Polestar.Set("nav.spawnSpots", true)
		r.back = marks()
		emit(r)`);
	assert.equal(out.default, true);
	assert.equal(out.on, 2, 'the two spots the arrow is not on');
	assert.equal(out.off, 0);
	assert.equal(out.target, true, 'the target pin is not a spawn spot');
	assert.equal(out.back, 2);
});
