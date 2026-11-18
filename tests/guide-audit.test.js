'use strict';
// The default guide window's audit fixes, in
// addon/Polestar/UI/GuideFrame*.lua. Against the real Core, Theme and UI and
// the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()\nlocal GF = Polestar.UI.GuideFrame\n${script}`,
	}).emitted;
}

test('the divider lines show in the opaque window only', () => {
	const [opaque, clear] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local p = GF.parts
		local function rules(style)
			Polestar.Set("ui.style", style)
			GF.ApplyStyle()
			return { nav = p.nav.Rule:IsShown(), xp = GF.xp.Rule:IsShown(), banner = p.banner.Rule:IsShown() }
		end
		emit(rules("standard"))
		emit(rules("transparent"))`);
	assert.deepEqual(opaque, { nav: true, xp: true, banner: true });
	assert.deepEqual(clear, { nav: false, xp: false, banner: false });
});
