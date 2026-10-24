'use strict';
// The arrow's sprite sheet against the media tool's layout (tools/media/nav
// arrow3dLayout): the frames and texture coordinates the addon computes
// (addon/Polestar/Nav) match the generated sheet. The rest of the navigation
// tests are rust/crates/forge-addontest/tests/addontest/nav.rs.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const NAV = { name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] };
const PRELUDE = `
local N = Polestar.Nav
local A = N.arrow
local Pins = Polestar.Pins
local function targetPin() return Pins.GetMinimapFrames("nav.target")[1] end
local nav = stub.nav
local function target(wx, wy, label)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, label or "T")
end
local function wp(wx, wy, label, extra)
	local m, x, y = nav.mapPoint(wx, wy)
	local t = { map = m, x = x, y = y, label = label, stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 }
	for k, v in pairs(extra or {}) do t[k] = v end
	return t
end
local function pinPoint()
	local f = targetPin()
	if not f then return { shown = false } end
	local _, _, _, x, y = f:GetPoint(1)
	return { x = x, y = y, edge = f.edge:IsShown(), edgeRot = f.edge:GetRotation(), shown = f:IsShown() }
end
`;

function run(script, opts = {}) {
	return runAddon({
		stubs: ['stub_nav.lua'],
		addons: [NAV],
		before: opts.before,
		saved: opts.saved,
		login: true,
		script: PRELUDE + script,
	}).emitted;
}

function near(actual, expected, eps = 1e-6, msg = '') {
	assert.ok(Math.abs(actual - expected) <= eps, `${msg} expected ${expected}, got ${actual}`);
}


const FRAMES = 100;

test('sheet frames: rounding, wraparound and texture coordinates match the generated sheet', () => {
	const [out] = run(`
		local d = math.pi / 180
		local angles = { 0, 1.7 * d, 1.9 * d, 90 * d, 180 * d, -90 * d, 357 * d, 359 * d, 2 * math.pi, -0.5 * d, -2 * d, 7 * math.pi }
		local frames, coords = {}, {}
		for i, a in ipairs(angles) do frames[i] = N.ArrowFrame(a) end
		for _, f in ipairs({ 0, 25, 99 }) do coords[#coords + 1] = { N.ArrowFrameCoords(f) } end
		emit({ frames = frames, coords = coords })`);
	assert.deepEqual(out.frames, [0, 0, 1, 25, 50, 75, 99, 0, 0, 0, 99, 50]);
	const { arrow3dLayout: L } = require('../tools/media/nav');
	const cellCoords = (f) => {
		const col = f % L.cols;
		const row = Math.floor(f / L.cols);
		return [(col * L.cell) / L.size, ((col + 1) * L.cell) / L.size, (row * L.cell) / L.size, ((row + 1) * L.cell) / L.size];
	};
	assert.equal(L.frames, FRAMES);
	out.coords.forEach((c, i) => {
		const want = cellCoords([0, 25, 99][i]);
		c.forEach((v, k) => near(v, want[k], 1e-9, `frame ${[0, 25, 99][i]} coord ${k}`));
	});
});
