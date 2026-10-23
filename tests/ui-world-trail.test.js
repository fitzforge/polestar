'use strict';
// Native controls for the optional in-world trail. Map line style stays separate.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function run(script, saved) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/WorldTrail.lua', 'UI/UI.xml'] }],
		saved: saved && { Polestar: saved },
		script: `uistub.install()\nstub.login()\nlocal UI, O = Polestar.UI, Polestar.UI.Options\n${script}`,
	}).emitted;
}

test('Ground trail aliases and slash command open Appearance without a duplicate Guide switch', () => {
 const [out] = run(`
  local result = {}
  local function at()
   local tab
   for name, view in pairs(O.page.views) do if view == O.view then tab = name end end
   return PolestarOptions.Title:GetText() .. " > " .. (tab or "")
  end
  UI.ShowOptions("groundtrail"); result.groundtrail = at()
  UI.ShowOptions("worldtrail"); result.worldtrail = at()
  SlashCmdList.POLESTAR("trail"); result.slash = at()
  UI.ShowOptions("navigation")
  result.guideSwitch = O.Controls("guide", "Arrow & routes")["nav.worldTrail"] ~= nil
  result.guideTab = false
  for _, button in ipairs(PolestarOptions.tabButtons) do
   if button:IsShown() and button.Label:GetText() == "Ground trail" then result.guideTab = true end
  end
  emit(result)`);
 assert.deepEqual(out, { groundtrail:'Appearance > Ground trail', worldtrail:'Appearance > Ground trail',
  slash:'Appearance > Ground trail', guideSwitch:false, guideTab:false });
});

test('Ground trail is opt-in with native searchable Appearance controls without changing the map style', () => {
	const [out] = run(`
		Polestar.Set("nav.lineStyle", "dots")
		UI.ShowOptions("groundtrail")
		local controls = O.Controls("appearance", "Ground trail")
		local row = controls["nav.worldTrail"]
		local result = { found = row ~= nil, off = Polestar.Get("nav.worldTrail") == false }
		result.controls = {}
		for key in pairs(controls) do
			if key:find("^nav%.") then result.controls[#result.controls + 1] = key end
		end
		table.sort(result.controls)
		result.mapStyle = Polestar.Get("nav.lineStyle")
		local _, matches = O.Search("Sparkle spacing")
		result.search = matches > 0
		emit(result)`);
	assert.equal(out.found, true, 'one master switch in Appearance, Ground trail');
	assert.equal(out.off, true);
	assert.equal(out.mapStyle, 'dots');
	assert.equal(out.search, true);
	assert.deepEqual(out.controls, [
		'nav.worldTrail', 'nav.worldTrailAhead', 'nav.worldTrailColor', 'nav.worldTrailFade',
		'nav.worldTrailFlow', 'nav.worldTrailGap', 'nav.worldTrailIndoors', 'nav.worldTrailIntensity',
		'nav.worldTrailLength', 'nav.worldTrailLift', 'nav.worldTrailMax', 'nav.worldTrailSight',
		'nav.worldTrailSize', 'nav.worldTrailSubtlety', 'nav.worldTrailWidth',
	]);
});

test('the existing setup offers the ground trail explicitly, without turning it on first', () => {
	const [out] = run(`
		Polestar.UI.Welcome.Show("setup")
		local row = rawget(PolestarWelcome, "WorldTrail")
		local result = { found = row ~= nil, off = Polestar.Get("nav.worldTrail") == false }
		if row then
			row:Click()
			result.on = Polestar.Get("nav.worldTrail")
			row:Click("RightButton")
			result.resetOff = Polestar.Get("nav.worldTrail") == false
		end
		emit(result)`);
	assert.deepEqual(out, { found: true, off: true, on: true, resetOff: true });
});

test('native sliders, saved looks and confirmed reset work without changing map or guide settings', () => {
	const [out] = run(`
		Polestar.Set("nav.lineStyle", "sparkle")
		Polestar.Set("ui.scale", 1.2)
		UI.ShowOptions("groundtrail")
		local c = O.Controls("appearance", "Ground trail")
		local result = { controlsOff = not Polestar.Widgets.Enabled(c["nav.worldTrailIntensity"]),
			noSavedLook = not c["Use custom look"]:IsEnabled() }
		c["nav.worldTrail"]:Click()
		result.controlsOn = Polestar.Widgets.Enabled(c["nav.worldTrailIntensity"])
		stub.RunScript(c["nav.worldTrailIntensity"].Slider, "OnValueChanged", 1, true)
		stub.RunScript(c["nav.worldTrailSize"].Slider, "OnValueChanged", 28, true)
		stub.RunScript(c["nav.worldTrailLength"].Slider, "OnValueChanged", 75, true)
		c["Save custom look"]:Click()
		result.savedLookReady = c["Use custom look"]:IsEnabled()
		stub.RunScript(c["nav.worldTrailIntensity"].Slider, "OnValueChanged", 0.2, true)
		c["Use custom look"]:Click()
		result.restored = { Polestar.Get("nav.worldTrailIntensity"), Polestar.Get("nav.worldTrailSize"), Polestar.Get("nav.worldTrailLength") }
		c["Reset ground trail"]:Click()
		result.firstClickKeepsTrail = Polestar.Get("nav.worldTrail")
		c["Reset ground trail"]:Click()
		result.resetOff = Polestar.Get("nav.worldTrail") == false
		result.mapStyle = Polestar.Get("nav.lineStyle")
		result.scale = Polestar.Get("ui.scale")
		emit(result)`);
	assert.deepEqual(out, { controlsOff: true, noSavedLook: true, controlsOn: true, savedLookReady: true,
		restored: [1, 28, 75], firstClickKeepsTrail: true, resetOff: true, mapStyle: 'sparkle', scale: 1.2 });
});
