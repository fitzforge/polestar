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

test('the foot line names a later step as "Next step:", this step\'s next person as "Then:"', () => {
	const [later, here] = run(`
		local function after(step, whole)
			uistub.setGuide(uistub.elwynn, step)
			Polestar.Set("ui.wholeStep", whole)
			GF.Render() GF.Layout()
			return GF.parts.after.Text:GetText()
		end
		emit(after(3, false))
		emit(after(4, true))`);
	assert.match(later, /^Next step: .*Marshal McBride/);
	assert.match(here, /^Then: .*Eagan Peltskinner/);
});
