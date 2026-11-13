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
