'use strict';
// Match the guide/arrow visibility contract without changing the trail preference.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const files = [
	'Core/Init.lua', 'Nav/WorldTrail.lua', 'Maps/RouteSparkle.lua',
	'Maps/WorldTrailMath.lua', 'Maps/WorldTrailTerrain.lua', 'Maps/WorldTrailRender.lua',
];

test('the trail hides immediately with the guide and recovers while steering without a route change', () => {
	const [out] = runAddon({
		stubs: ['stub_world_trail.lua'],
		addons: [{ name: 'Polestar', files }],
		script: `
local W = stub.worldTrail
W.install(); stub.login()
local R = Polestar.WorldTrail.Render
Polestar.Set("nav.worldTrail", true)
stub.advance(2.1)
local g = R.GroundFrame()
local out = { before = g.used }
Polestar.Set("ui.shown", false)
out.guideHidden = not Polestar.GuideShown()
out.hidden = g.used
out.frameHidden = not g:IsShown()
out.idle = g:GetScript("OnUpdate") == nil
out.why = R.Why()
-- A route/settings rebuild must not restart a hidden painter.
R.Rebuild(); Polestar.Set("nav.worldTrailSize", 16); stub.advance(.2)
out.rebuiltHidden = g.used
out.rebuiltIdle = g:GetScript("OnUpdate") == nil
out.preference = Polestar.Get("nav.worldTrail")
-- Recover with unchanged geometry and ordinary right-mouse steering.
Polestar.Set("ui.shown", true)
W.looking = true; W.right = true; W.speed = 7
for i = 1, 30 do W.px = W.px + .35; stub.advance(.05) end
out.recovered = g.used
out.shown = g:IsShown()
out.errors = #Polestar.Errors()
out.writes = W.writes
emit(out)`,
	}).emitted;
	assert.ok(out.before > 0);
	assert.equal(out.guideHidden, true);
	assert.equal(out.hidden, 0, 'hide clears sprites before another painter tick');
	assert.equal(out.frameHidden, true);
	assert.equal(out.idle, true, 'hidden trail has no painter callback');
	assert.equal(out.why, 'the guide is hidden');
	assert.equal(out.rebuiltHidden, 0);
	assert.equal(out.rebuiltIdle, true);
	assert.equal(out.preference, true, 'visibility is not a settings migration');
	assert.ok(out.recovered > 0, 'show restores the existing route while steering');
	assert.equal(out.shown, true);
	assert.equal(out.errors, 0);
	assert.equal(out.writes, 0);
});

test("hiding Polestar hides the trail at once, stops its painter and brings it back as it was", () => {
	const [out] = runAddon({
		stubs: ['stub_world_trail.lua'],
		addons: [{ name: 'Polestar', files }],
		script: `
local W = stub.worldTrail
W.install(); stub.login()
local R = Polestar.WorldTrail.Render
Polestar.Set("nav.worldTrail", true)
stub.advance(2.1)
local g = R.GroundFrame()
local out = { before = g.used, onLayer = g:GetParent() == Polestar.UIParent and Polestar.UIParent ~= UIParent }
Polestar.SetHidden(true) -- the minimap button's click, /polestar hide
out.hidden = { used = g.used, visible = g:IsVisible(), idle = g:GetScript("OnUpdate") == nil, why = R.Why() }
-- A route or settings rebuild must not bring a hidden trail back.
R.Rebuild(); Polestar.Set("nav.worldTrailSize", 16); stub.advance(.3)
out.rebuilt = { used = g.used, visible = g:IsVisible() }
out.preference = Polestar.Get("nav.worldTrail")
Polestar.SetHidden(false)
W.looking = true; W.right = true; W.speed = 7
for i = 1, 30 do W.px = W.px + .35; stub.advance(.05) end
out.back = { drawn = g.used > 0, visible = g:IsVisible() }
out.errors = #Polestar.Errors()
out.writes = W.writes
emit(out)`,
	}).emitted;
	assert.ok(out.before > 0);
	assert.equal(out.onLayer, true, "the trail's frame is a child of Polestar's layer, not of the game's UIParent");
	assert.deepEqual(out.hidden, { used: 0, visible: false, idle: true, why: 'the guide is hidden' });
	assert.deepEqual(out.rebuilt, { used: 0, visible: false });
	assert.equal(out.preference, true, 'hiding Polestar does not change the setting');
	assert.deepEqual(out.back, { drawn: true, visible: true });
	assert.equal(out.errors, 0);
	assert.equal(out.writes, 0);
});

test('a hidden guide at login stays idle and a UI reset restores only an enabled trail', () => {
	const [out] = runAddon({
		stubs: ['stub_world_trail.lua'],
		addons: [{ name: 'Polestar', files }],
		script: `
local W = stub.worldTrail
W.install()
Polestar.Set("nav.worldTrail", true)
Polestar.Set("ui.shown", false)
stub.login(); stub.advance(2.1)
local R = Polestar.WorldTrail.Render
local function visible()
 local g = R.GroundFrame()
 return g and g:IsShown() and g.used > 0 or false
end
local out = { hiddenAtLogin = not visible() }
Polestar.ResetSettings("ui"); stub.advance(.2)
out.uiReset = visible()
Polestar.Set("ui", { shown = false }); stub.advance(.2)
out.sectionHidden = not visible()
Polestar.Set("nav.worldTrail", false)
Polestar.ResetSettings("ui"); stub.advance(.2)
out.disabledStillHidden = not visible()
Polestar.Set("nav.worldTrail", true); stub.advance(.2)
out.reenabled = visible()
Polestar.ResetSettings(); stub.advance(.2)
out.globalResetOff = not visible() and not Polestar.Get("nav.worldTrail")
out.errors = #Polestar.Errors()
emit(out)`,
	}).emitted;
	assert.deepEqual(out, {
		hiddenAtLogin: true, uiReset: true, sectionHidden: true,
		disabledStillHidden: true, reenabled: true, globalResetOff: true, errors: 0,
	});
});
