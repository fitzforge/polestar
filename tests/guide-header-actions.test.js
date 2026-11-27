'use strict';
// The guide window's header actions (UI/GuideFrame.lua, GuideFrameWindow.lua,
// GuideFrameMenu.lua): each of Lookup, Nearby services, Settings, Quick
// settings, Hand in and Choose guide is a button in the header or a row in
// the guide menu, by the player's switch; the shown buttons line up from the
// menu leftwards with no gap, Skip left of the last. Against the real Core,
// Theme and UI and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()\nlocal GF, UI, W = Polestar.UI.GuideFrame, Polestar.UI, Polestar.Widgets
uistub.setGuide(uistub.elwynn, 3)
local nav = GF.menuButton:GetParent()
local KEYS = { "Lookup", "Report", "Nearby", "AllSteps", "Settings", "QuickSettings", "HandIn", "ChooseGuide" }
-- The menu's rows as text, and the header: which buttons show, and what each
-- shown one (and Skip) sits left of.
local function snap()
	local got
	local show = W.ShowMenu
	W.ShowMenu = function(_, items) got = items end
	GF.OpenMenu(GF.menuButton)
	W.ShowMenu = show
	local rows = {}
	for _, it in ipairs(got) do if it.text then rows[#rows + 1] = it.text end end
	local names = { [nav.Menu] = "Menu" }
	for _, k in ipairs(KEYS) do names[nav[k]] = k end
	local shown, leftOf = {}, {}
	for _, k in ipairs(KEYS) do
		if nav[k]:IsShown() then
			shown[#shown + 1] = k
			local _, rel = nav[k]:GetPoint(1)
			leftOf[k] = names[rel] or "?"
		end
	end
	local _, rel = nav.Skip:GetPoint(1)
	leftOf.Skip = names[rel] or "?"
	return { rows = rows, shown = shown, leftOf = leftOf }
end
${script}`,
	}).emitted;
}

const MOVED = ['settingsButton', 'quickSettingsButton', 'handInButton', 'chooseGuideButton'];

test('by default Lookup and Nearby services are in the header, the menu has Settings, Quick settings, Hand in and Choose guide', () => {
	const [out] = run('emit(snap())');
	for (const k of ['Lookup', 'Nearby']) assert.ok(out.shown.includes(k), `${k} in the header: ${out.shown}`);
	for (const k of ['Settings', 'QuickSettings', 'HandIn', 'ChooseGuide']) assert.ok(!out.shown.includes(k), `${k} not in the header: ${out.shown}`);
	for (const t of ['Settings', 'Quick settings', 'Choose guide']) assert.ok(out.rows.includes(t), `${t} in the menu: ${out.rows}`);
	assert.ok(out.rows.some((t) => t.startsWith('Hand in') || t === 'None to hand in'), `a hand-in row: ${out.rows}`);
	assert.ok(!out.rows.includes('Lookup'), 'Lookup is in the header, not the menu');
	assert.ok(!out.rows.some((t) => t.startsWith('Nearby services')), 'Nearby is in the header, not the menu');
});

test('each switch moves its action between the header and the menu, and the header closes up', () => {
	const [out] = run(`
		Polestar.Set("guideWindow.lookupButton", false)
		Polestar.Set("nav.nearbyButton", false)
		${MOVED.map((k) => `Polestar.Set("guideWindow.${k}", true)`).join('\n')}
		GF.Render()
		emit(snap())`);
	assert.ok(!out.shown.includes('Lookup') && !out.shown.includes('Nearby'), `Lookup and Nearby left the header: ${out.shown}`);
	for (const k of ['Settings', 'QuickSettings', 'HandIn', 'ChooseGuide']) assert.ok(out.shown.includes(k), `${k} in the header: ${out.shown}`);
	assert.ok(out.rows.includes('Lookup'), `Lookup in the menu: ${out.rows}`);
	assert.ok(out.rows.some((t) => t.startsWith('Nearby services')), `Nearby services in the menu: ${out.rows}`);
	for (const t of ['Settings', 'Quick settings', 'Choose guide', 'None to hand in']) assert.ok(!out.rows.includes(t), `${t} left the menu: ${out.rows}`);
	assert.ok(!out.rows.some((t) => t.startsWith('Hand in')), `no hand-in row: ${out.rows}`);
	// No gap: each shown button sits left of the one shown before it, the first left of the menu.
	let prev = 'Menu';
	for (const k of out.shown) {
		assert.equal(out.leftOf[k], prev, `${k} sits left of ${prev}`);
		prev = k;
	}
	assert.equal(out.leftOf.Skip, prev, 'Skip sits left of the last button shown');
});

test('All steps off in the header is a row in the menu, and Nearby services opens its own page from there', () => {
	const [out] = run(`
		Polestar.Set("guideWindow.allStepsButton", false)
		Polestar.Set("nav.nearbyButton", false)
		GF.Render()
		local s = snap()
		local opened
		local open = GF.OpenNearby
		local got
		local show = W.ShowMenu
		W.ShowMenu = function(_, items) got = items end
		GF.OpenMenu(GF.menuButton)
		W.ShowMenu = show
		for _, it in ipairs(got) do
			if it.text and it.text:find("Nearby services", 1, true) then
				W.ShowMenu = function(_, items) opened = #items end
				it.onClick()
				W.ShowMenu = show
			end
		end
		emit({ rows = s.rows, opened = opened or 0 })`);
	assert.ok(out.rows.includes('All steps'), `All steps in the menu: ${out.rows}`);
	assert.ok(out.opened > 0, 'the Nearby services row opens the services');
});
