'use strict';
// Special thanks is on About, under the credits (addon/Polestar_Options/UI/Options.lua, addon/Polestar/UI/Thanks.lua).
// Against the real addon's modules and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml'];

// Opens the settings window, runs `script` (Lua, `O` the window) and returns what it emits.
function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local UI, O = Polestar.UI, Polestar.UI.Options
			UI.ShowOptions()
			${script}`,
	}).emitted[0];
}

test('Special thanks is on About, under the credits, not in the footer', () => {
	const out = run(`Polestar.Credits = { supporters = { "Ann" }, contributors = {}, bugReporters = {} }
		UI.ShowOptions("about")
		local v = O.view
		local name = v.Thanks:IsShown() and v.Thanks.Label:GetText()
		v.Thanks:Click()
		emit({ footer = rawget(PolestarOptions, "ThanksLink") ~= nil, name = name, page = O.page.key })`);
	assert.equal(out.footer, false, 'no thanks line in the footer');
	assert.equal(out.name, 'Ann', 'About names a supporter');
	assert.equal(out.page, 'thanks', 'and the name opens Guiding Stars');
});
