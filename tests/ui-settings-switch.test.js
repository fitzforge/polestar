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
