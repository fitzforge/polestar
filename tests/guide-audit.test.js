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

test("a banner's second action that would be cut takes its own line, and the banner grows for it", () => {
	const [narrow, wide] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local banner = GF.parts.banner
		local function lay(width)
			local h = GF.LayoutBanner(width, true, "lost", { title = "Kobold Camp Cleanup" })
			local later, jump = banner.Later, banner.Jump
			local _, _, _, x, y = later:GetPoint(1)
			local _, _, _, _, jy = jump:GetPoint(1)
			return { h = h, x = x, y = y, jy = jy, cut = later.Label:GetWidth() > 0
				and later.Label:GetWidth() < later.Label:GetUnboundedStringWidth() }
		end
		emit(lay(260))
		emit(lay(560))`);
	assert.equal(wide.x > 0, true, 'at 560 the second action sits beside the first');
	assert.equal(wide.y, wide.jy);
	assert.equal(narrow.x, 0, 'at 260 it starts its own line');
	assert.ok(narrow.y < narrow.jy, `under the first: ${narrow.y} below ${narrow.jy}`);
	assert.equal(narrow.cut, false, 'its label is whole');
	assert.equal(narrow.h - wide.h >= 22, true, `the banner grows by its line: ${narrow.h} vs ${wide.h}`);
});
