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

test('opening a "Then:" line brings it and its goals into sight', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 4)
		Polestar.Set("ui.wholeStep", false)
		Polestar.Set("ui.maxHeight", 0.01)
		GF.Render() GF.Layout()
		local goals = GF.parts.goals
		local line
		for _, o in ipairs(GF.CardItems()) do
			if o.psKey and o.psKey ~= "done" and o:IsShown() and o.psTitle == "Brother Neals" then line = o end
		end
		line:GetScript("OnClick")(line)
		stub.advance(1)
		local top, view = goals:GetVerticalScroll(), goals.psViewH
		local items, last = GF.CardItems(), nil
		for i, o in ipairs(items) do if o == line then last = items[i + 1] end end
		local y = GF.ItemTop(line)
		emit({ over = goals.psOver, top = top, view = view, y = y, rowY = last and GF.ItemTop(last), rowGoal = last and last.psGoal ~= nil })`);
	assert.equal(out.over, true, 'the goals area scrolls');
	assert.equal(out.rowGoal, true, 'the opened line has its goal under it');
	assert.ok(out.y >= out.top - 0.5, `the line is in sight: ${out.y} from ${out.top}`);
	assert.ok(out.rowY < out.top + out.view, `its goal is in sight: ${out.rowY} in ${out.top}+${out.view}`);
});

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
