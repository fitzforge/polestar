'use strict';
// The waypoint arrow's Colour by facing (addon/Polestar/Nav/Arrow.lua,
// nav.arrowFacingColor, #2380). Runs the real Core/Init.lua + Nav/Nav.xml
// against tests/lua/stub_nav.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function run(script) {
	return runAddon({
		stubs: ['stub_nav.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] }],
		login: true,
		script: `local N, nav = Polestar.Nav, stub.nav\nlocal A = N.arrow\n${script}`,
	}).emitted[0];
}

test('Colour by facing: green facing the goal, amber across, red turned away, blended between; the skins\' darts too; off, the arrow\'s own colour (#2380)', () => {
	const out = run(`
		local r = {}
		Polestar.Set("nav.travel", false)
		nav.place(0, 0)
		local m, x, y = nav.mapPoint(0, 600)
		N.SetTarget(m, x, y, "Goal")
		local part = A.sheet
		local function at(f)
			nav.facing = f
			stub.advance(0.1)
			local cr, cg, cb = part:GetVertexColor()
			return { cr, cg, cb }
		end
		r.default = Polestar.Get("nav.arrowFacingColor")
		r.off = at(math.pi / 2)
		Polestar.Set("nav.arrowFacingColor", true)
		r.ahead, r.side, r.half, r.away = at(math.pi / 2), at(0), at(math.pi / 4), at(3 * math.pi / 2)
		Polestar.Set("nav.arrowStyle", "halo")
		part = A.dart
		r.dartAway = at(3 * math.pi / 2)
		Polestar.Set("nav.arrowFacingColor", false)
		r.dartOff = at(math.pi / 2)
		r.rgb = { arrow = { N.RGB("arrow") }, success = { N.RGB("success") }, warning = { N.RGB("warning") }, danger = { N.RGB("danger") } }
		emit(r)`);
	const { rgb } = out;
	assert.equal(out.default, false, 'off by default');
	assert.deepEqual(out.off, rgb.arrow, 'off: the arrow\'s own colour');
	assert.deepEqual(out.ahead, rgb.success);
	assert.deepEqual(out.side, rgb.warning);
	assert.deepEqual(out.away, rgb.danger);
	for (let i = 0; i < 3; i++) {
		const mid = (rgb.success[i] + rgb.warning[i]) / 2;
		assert.ok(Math.abs(out.half[i] - mid) < 1e-6, `45 degrees off: halfway from green to amber (${out.half})`);
	}
	assert.deepEqual(out.dartAway, rgb.danger, 'a skin\'s dart is tinted too, not drawn in its art\'s own colours');
	assert.notDeepEqual(out.dartOff, rgb.danger, 'off again: the dart leaves the facing colour');
});
