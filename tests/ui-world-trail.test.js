'use strict';
// The settings page of the optional in-world trail. Map line style stays separate.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function run(script, saved) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/WorldTrail.lua', 'UI/UI.xml'] }],
		saved: saved && { Polestar: saved },
		script: `uistub.install()\nstub.login()\nPolestar.UI.LoadOptions()\nlocal UI, O = Polestar.UI, Polestar.UI.Options\n${script}`,
	}).emitted;
}

test('the Ground trail page opens by its key, by /polestar trail and from a note about its switch, with no second switch under Guide', () => {
 const [out] = run(`
  local result = {}
  local function at()
   local tab
   for name, view in pairs(O.page.views) do if view == O.view then tab = name end end
   return O.page.key .. ": " .. PolestarOptions.Title:GetText() .. " > " .. (tab or "")
  end
  UI.ShowOptions("groundtrail"); result.groundtrail = at()
  UI.ShowOptions("guide")
  SlashCmdList.POLESTAR("trail"); result.slash = at()
  -- What a What's new note about the trail (setting = "nav.worldTrail") opens.
  UI.ShowOptions("guide")
  UI.ShowSetting("nav.worldTrail"); result.note = at()
  UI.ShowOptions("navigation")
  result.guideSwitch = O.Controls("guide", "Arrow & routes")["nav.worldTrail"] ~= nil
  result.pages = 0
  for _, p in ipairs(O.Pages()) do
   if p.key == "groundtrail" then result.pages = result.pages + 1; result.tabs = p.tabs end
  end
  emit(result)`);
 assert.deepEqual(out, { groundtrail:'groundtrail: Ground trail > Trail', slash:'groundtrail: Ground trail > Trail',
  note:'groundtrail: Ground trail > Trail', guideSwitch:false, pages:1, tabs:['Trail'] });
});

test('Ground trail is opt-in with native searchable controls on its own page without changing the map style', () => {
	const [out] = run(`
		Polestar.Set("nav.lineStyle", "dots")
		UI.ShowOptions("groundtrail")
		local controls = O.Controls("groundtrail", "Trail")
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
	assert.equal(out.found, true, 'one master switch, in the header of the page\'s first section');
	assert.equal(out.off, true);
	assert.equal(out.mapStyle, 'dots');
	assert.equal(out.search, true);
	assert.deepEqual(out.controls, [
		'nav.worldTrail', 'nav.worldTrailAhead', 'nav.worldTrailColor', 'nav.worldTrailFade',
		'nav.worldTrailFlow', 'nav.worldTrailGap', 'nav.worldTrailIndoors', 'nav.worldTrailIntensity',
		'nav.worldTrailLength', 'nav.worldTrailLift', 'nav.worldTrailMax', 'nav.worldTrailSight',
		'nav.worldTrailSize', 'nav.worldTrailSubtlety', 'nav.worldTrailWaypoint', 'nav.worldTrailWidth',
	]);
});

// The trail reads the camera's angle from the marker of a waypoint Polestar sets, and says so where it is switched
// off: a row in the page, never a window.
test('the trail has its own waypoint switch, on by default, and the page warns in a row of its own while it is off', () => {
	const [out] = run(`
		UI.ShowOptions("groundtrail")
		local warning = "The trail's waypoint is off. The trail reads the camera's angle from it, and without it the trail is drawn short once you have moved the camera."
		local function state()
			local c = O.Controls("groundtrail", "Trail")
			local row = c[warning]
			return { warned = row ~= nil and row:IsVisible() or false, switch = c["nav.worldTrailWaypoint"] ~= nil,
				enabled = c["nav.worldTrailWaypoint"] ~= nil and Polestar.Widgets.Enabled(c["nav.worldTrailWaypoint"]) or false }
		end
		local result = { default = Polestar.Get("nav.worldTrailWaypoint"), game = Polestar.Get("nav.blizzardWaypoint") }
		result.off = state()                                   -- the trail off: its switch is there, dimmed, and no warning
		Polestar.Set("nav.worldTrail", true); result.on = state()
		Polestar.Set("nav.worldTrailWaypoint", false); result.blind = state()
		Polestar.Set("nav.worldTrail", false); result.blindOff = state().warned -- said with the trail off too
		Polestar.Set("nav.worldTrail", true)
		local c = O.Controls("groundtrail", "Trail")
		c[warning].Button:Click()                              -- "Turn on"
		result.fixed = state(); result.after = Polestar.Get("nav.worldTrailWaypoint")
		result.gameAfter = Polestar.Get("nav.blizzardWaypoint")
		result.popups = Polestar.UI.WorldTrailIntro and Polestar.UI.WorldTrailIntro.frame and Polestar.UI.WorldTrailIntro.frame:IsShown() or false
		emit(result)`);
	assert.equal(out.default, true, 'on by default');
	assert.deepEqual(out.off, { warned: false, switch: true, enabled: false });
	assert.deepEqual(out.on, { warned: false, switch: true, enabled: true });
	assert.deepEqual(out.blind, { warned: true, switch: true, enabled: true }, 'the warning shows while that switch is off');
	assert.equal(out.blindOff, true);
	assert.deepEqual(out.fixed, { warned: false, switch: true, enabled: true });
	assert.equal(out.after, true, 'its button turns the switch on');
	assert.equal(out.game, false);
	assert.equal(out.gameAfter, false, 'the player\'s own Blizzard waypoint setting is never touched');
	assert.equal(out.popups, false, 'nothing opens by itself');
});

test('native sliders, saved looks and confirmed reset work without changing map or guide settings', () => {
	const [out] = run(`
		Polestar.Set("nav.lineStyle", "sparkle")
		Polestar.Set("ui.scale", 1.2)
		UI.ShowOptions("groundtrail")
		local c = O.Controls("groundtrail", "Trail")
		local look = c["Look"]
		local function offered(name)
			look.Button:Click() -- opens the list
			local found = false
			for _, r in ipairs(PolestarMenu.rows) do
				if r:IsShown() and r.Text:GetText() == name then found = true end
			end
			Polestar.Widgets.HideMenu()
			return found
		end
		local function pick(name)
			look.Button:Click()
			for _, r in ipairs(PolestarMenu.rows) do
				if r:IsShown() and r.Text:GetText() == name then r:Click(); return end
			end
			error("no such look in the list: " .. name)
		end
		local result = { controlsOff = not Polestar.Widgets.Enabled(c["nav.worldTrailIntensity"]) }
		c["nav.worldTrail"]:Click()
		result.noSavedLook = not offered("Your saved look")
		result.controlsOn = Polestar.Widgets.Enabled(c["nav.worldTrailIntensity"])
		stub.RunScript(c["nav.worldTrailIntensity"].Slider, "OnValueChanged", 1, true)
		stub.RunScript(c["nav.worldTrailSize"].Slider, "OnValueChanged", 28, true)
		stub.RunScript(c["nav.worldTrailLength"].Slider, "OnValueChanged", 75, true)
		c["Save custom look"].Button:Click()
		result.savedLookReady = offered("Your saved look")
		stub.RunScript(c["nav.worldTrailIntensity"].Slider, "OnValueChanged", 0.2, true)
		pick("Your saved look")
		result.restored = { Polestar.Get("nav.worldTrailIntensity"), Polestar.Get("nav.worldTrailSize"), Polestar.Get("nav.worldTrailLength") }
		c["Reset ground trail"].Button:Click()
		result.firstClickKeepsTrail = Polestar.Get("nav.worldTrail")
		assert(Polestar.Widgets.ModalShown(), "reset asks in the native dialog")
		PolestarModal.Box.Cancel:Click()
		assert(Polestar.Get("nav.worldTrail"), "cancel preserves the trail")
		c["Reset ground trail"].Button:Click()
		PolestarModal.Box.Action:Click()
		result.resetOff = Polestar.Get("nav.worldTrail") == false
		result.mapStyle = Polestar.Get("nav.lineStyle")
		result.scale = Polestar.Get("ui.scale")
		emit(result)`);
	assert.deepEqual(out, { controlsOff: true, noSavedLook: true, controlsOn: true, savedLookReady: true,
		restored: [1, 28, 75], firstClickKeepsTrail: true, resetOff: true, mapStyle: 'sparkle', scale: 1.2 });
});

test('ground-trail action rows name the action instead of generic Run buttons', () => {
 const [out] = run(`
  UI.ShowOptions("groundtrail")
  local c = O.Controls("groundtrail", "Trail")
  emit({ save = c["Save custom look"].Button.Label:GetText(),
   reset = c["Reset ground trail"].Button.Label:GetText(),
   applyRows = c["Lantern"] ~= nil or c["Use custom look"] ~= nil })`);
 assert.deepEqual(out, { save: 'Save', reset: 'Reset', applyRows: false });
});

test('the Look row names the look in use, lists every look and applies one in a click', () => {
	const [out] = run(`
		UI.ShowOptions("groundtrail")
		local c = O.Controls("groundtrail", "Trail")
		local look = c["Look"]
		local function shown() return look.Button.Label:GetText() end
		local function list()
			look.Button:Click()
			local names = {}
			for _, r in ipairs(PolestarMenu.rows) do
				if r:IsShown() then names[#names + 1] = r.Text:GetText() end
			end
			Polestar.Widgets.HideMenu()
			return names
		end
		local function pick(name)
			look.Button:Click()
			for _, r in ipairs(PolestarMenu.rows) do
				if r:IsShown() and r.Text:GetText() == name then r:Click(); return end
			end
			error("no such look in the list: " .. name)
		end
		local result = { off = not Polestar.Widgets.Enabled(look), label = look.Label:GetText() }
		c["nav.worldTrail"]:Click()
		result.on = Polestar.Widgets.Enabled(look)
		result.fresh, result.looks = shown(), list()
		pick("Breadcrumbs")
		result.picked = { shown(), Polestar.Get("nav.worldTrailGap"), Polestar.Get("nav.worldTrailFlow"), Polestar.Get("nav.worldTrailLength") }
		result.stillOn = Polestar.Get("nav.worldTrail")
		stub.RunScript(c["nav.worldTrailGap"].Slider, "OnValueChanged", 2.5, true)
		result.tuned, result.tunedList = shown(), list()
		pick("Custom")
		result.customKeeps = Polestar.Get("nav.worldTrailGap")
		c["Save custom look"].Button:Click()
		result.saved = shown()
		pick("Ribbon")
		result.ribbon = { shown(), Polestar.Get("nav.worldTrailColor") }
		look:Click("RightButton")
		result.reset = { shown(), Polestar.Get("nav.worldTrailGap"), Polestar.Get("nav.worldTrailColor"), Polestar.Get("nav.worldTrail") }
		local _, matches = O.Search("breadcrumbs")
		result.search = matches > 0
		emit(result)`);
	assert.equal(out.off, true, 'dimmed with the rest while the trail is off');
	assert.equal(out.label, 'Look');
	assert.equal(out.on, true);
	assert.equal(out.fresh, 'Stardust');
	assert.deepEqual(out.looks, ['Stardust', 'Breadcrumbs', 'Whisper', 'Ribbon', 'Lantern', 'Witcher', 'Fairy', 'Fel']);
	assert.deepEqual(out.picked, ['Breadcrumbs', 3, 0, 35]);
	assert.equal(out.stillOn, true);
	assert.equal(out.tuned, 'Custom');
	assert.deepEqual(out.tunedList, ['Stardust', 'Breadcrumbs', 'Whisper', 'Ribbon', 'Lantern', 'Witcher', 'Fairy', 'Fel', 'Custom']);
	assert.equal(out.customKeeps, 2.5, 'picking Custom changes nothing');
	assert.equal(out.saved, 'Your saved look');
	assert.deepEqual(out.ribbon, ['Ribbon', 'arcane']);
	assert.deepEqual(out.reset, ['Stardust', 1.4, 'gold', true], 'right-click puts the default look back and leaves the switch');
	assert.equal(out.search, true, 'a look is found by its name in the settings search');
});
