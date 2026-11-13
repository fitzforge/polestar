'use strict';
// Dragging the guide window (addon/Polestar/UI/GuideFrame.lua): on the drop
// the window is pinned where it stands, to the fraction of a unit, so it does
// not move and its text does not shift on the pixel grid. Against the real
// Core, Theme and UI and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()\nlocal GF = Polestar.UI.GuideFrame\n${script}`,
	}).emitted;
}

for (const growUp of [false, true]) {
	test(`the window stays exactly where it is dropped (${growUp ? 'grow upward' : 'grow downward'})`, () => {
		const [out] = run(`
			Polestar.Set("ui.growUp", ${growUp})
			local F = PolestarGuideFrame
			local nav = GF.parts.nav
			stub.RunScript(nav, "OnDragStart")
			-- Where the game's mover leaves it, between whole units.
			F.x, F.y = 412.37, 288.62
			local left, corner = F:GetLeft(), ${growUp} and F:GetBottom() or F:GetTop()
			stub.RunScript(nav, "OnDragStop")
			local point, _, _, x, y = F:GetPoint(1)
			local pos = Polestar.Get("ui.pos")
			emit({ left = left, corner = corner, point = point, x = x, y = y, pos = { pos[1], pos[2] } })`);
		assert.equal(out.point, growUp ? 'BOTTOMLEFT' : 'TOPLEFT');
		assert.equal(out.x, out.left, 'pinned at its left edge, unrounded');
		assert.equal(out.y, out.corner, 'pinned at its corner, unrounded');
		assert.deepEqual(out.pos, [out.left, out.corner], 'saved as it stands');
	});
}

for (const growUp of [false, true]) {
	test(`a new scale keeps the window's corner where it stands, unrounded (${growUp ? 'grow upward' : 'grow downward'})`, () => {
		const [out] = run(`
			Polestar.Set("ui.growUp", ${growUp})
			local F = PolestarGuideFrame
			local nav = GF.parts.nav
			-- Dropped between whole units, as the drag test above leaves it.
			stub.RunScript(nav, "OnDragStart")
			F.x, F.y = 412.37, 288.62
			stub.RunScript(nav, "OnDragStop")
			local left, corner = F:GetLeft(), ${growUp} and F:GetBottom() or F:GetTop()
			Polestar.Set("ui.scale", 1.3)
			local point, _, _, x, y = F:GetPoint(1)
			local pos = Polestar.Get("ui.pos")
			emit({ left = left, corner = corner, point = point, x = x, y = y, pos = { pos[1], pos[2] } })`);
		assert.equal(out.point, growUp ? 'BOTTOMLEFT' : 'TOPLEFT');
		assert.ok(out.left > 0 && out.corner > 0, 'the window stands somewhere');
		assert.ok(Math.abs(out.x - out.left / 1.3) < 1e-9, `pinned at left / 1.3, unrounded (${out.x})`);
		assert.ok(Math.abs(out.y - out.corner / 1.3) < 1e-9, `pinned at its corner / 1.3, unrounded (${out.y})`);
		assert.deepEqual(out.pos, [out.x, out.y], 'saved as it is pinned');
	});
}
