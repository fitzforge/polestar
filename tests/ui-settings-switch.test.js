'use strict';
// The settings window's "New settings page" switch (addon/Polestar_Options/
// UI/Grouped.lua): it stands after Menu scale in the window's header, moves
// to the icon buttons beside the search while it is on, and keeps the choice
// for the account (PolestarDB.optionsLayout). Against the real addon's
// modules and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

function run(script, saved) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: saved || 'PolestarDB = { settings = {} }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			${script}`,
	}).emitted;
}

// The stub has no layout (GetLeft is 0), so the placement is read from the anchors:
// each header tool is anchored RIGHT to the one on its right.
test('the switch reads "New settings page" and stands where each page puts it', () => {
	const [out, again] = run(`
		Polestar.UI.ShowOptions("guide")
		local f, G = O.frame, O.Grouped
		local sw, scale = G.Switch(), f.HeaderTools
		local function rightOf(w) local _, rel = w:GetPoint(1) return rel end
		local classic = { label = sw.Label:GetText(), afterScale = rightOf(scale) == sw, beforeClose = rightOf(sw) == f.Close }
		G.SetOn(true)
		local tools = f.psHeadTools
		emit({ classic = classic, afterSearch = rightOf(f.Search) == sw,
			switchBeforeSearch = (function() for i, t in ipairs(tools) do if t == f.Search then return tools[i - 1] == sw end end end)(),
			tip = sw.Sw.psTip })
		G.SetOn(false)
		emit({ back = rightOf(sw) == f.Close, afterScale = rightOf(scale) == sw })`);
	assert.deepEqual(out.classic, { label: 'New settings page', afterScale: true, beforeClose: true });
	assert.equal(out.afterSearch, true, 'on: right of the search');
	assert.equal(out.switchBeforeSearch, true, 'on: the icon button next to the search');
	assert.equal(out.tip, 'New settings page');
	assert.equal(again.back, true, 'off: back before the close button');
	assert.equal(again.afterScale, true, 'off: back after the scale');
});

test('the choice is kept for the account and an open window shows its page again', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions("guide")
		local G = O.Grouped
		local before = G.On()
		G.SetOn(true)
		local on = { on = G.On(), saved = PolestarDB.optionsLayout, page = O.page and O.page.key }
		G.SetOn(false)
		emit({ before = before, on = on, off = { on = G.On(), saved = PolestarDB.optionsLayout, page = O.page and O.page.key } })`);
	assert.equal(out.before, false, 'off by default');
	assert.deepEqual(out.on, { on: true, saved: 'grouped', page: 'guide' });
	assert.deepEqual(out.off, { on: false, page: 'guide' });
});

test('a saved choice shows the switch on when the window opens', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions("guide")
		emit({ on = O.Grouped.On(), checked = O.Grouped.Switch().Sw.checked })`, 'PolestarDB = { settings = {}, optionsLayout = "grouped" }');
	assert.equal(out.on, true);
	assert.equal(out.checked, true);
});
