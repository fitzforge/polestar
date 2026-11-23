'use strict';
// Install is on About's tile, not in the settings window's header (addon/Polestar_Options/UI/Options.lua).
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

test('Install is on About, not in the header', () => {
	const out = run(`local win = PolestarOptions
		local inHeader = false
		for _, f in ipairs({ win.Header:GetChildren() }) do
			if rawget(f, "Label") and f.Label.GetText and f.Label:GetText() == Polestar.L["Install"] and f:IsShown() then inHeader = true end
		end
		UI.ShowOptions("about")
		local tile = O.view.Install
		emit({ inHeader = inHeader, tile = tile ~= nil and tile:IsShown() })`);
	assert.equal(out.inHeader, false, 'the header has no Install button');
	assert.equal(out.tile, true, 'About\'s Install tile sets Polestar up again');
});
