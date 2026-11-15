'use strict';
// The settings window's rows (addon/Polestar/Theme/Widgets.lua W.CompactRow
// and W.LayoutCompact, laid out in pairs by addon/Polestar_Options/UI/
// Options.lua): a label too long for its half wraps to a second line before
// it is cut, and the half beside it stands as tall, so the two hairlines
// meet. Against the real addon's modules and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml'];

// Opens the settings window on a test page (its controls: `controls`, Lua)
// after `before` (Lua), then runs `script` (Lua, `O` the window, `rows` the
// page's rows by key) and returns what it emits.
function onPage(controls, script, before = '') {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			${before}
			assert(Polestar.RegisterOptions({ page = "Rows", key = "rows", tab = "Tab", section = "Section", controls = ${controls} }))
			Polestar.UI.ShowOptions("rows")
			local O = Polestar.UI.Options
			local rows = O.Controls("rows", "Tab")
			${script}`,
	}).emitted[0];
}

const LONG = 'A setting whose label runs long enough that it needs a second line in its half of the row';

test('a long label wraps onto a second line before it is cut', () => {
	const out = onPage(`{
		{ kind = "toggle", key = "ui.compact", label = "${LONG}" },
		{ kind = "toggle", key = "ui.locked", label = "${LONG} and then much further on, past what two lines can hold" },
	}`, `local a, b = rows["ui.compact"], rows["ui.locked"]
		emit({ wrap = a.Label:GetWordWrap(), lines = a.Label:GetMaxLines(), twoLines = a.Label:GetNumLines(),
			cut = a.Label:IsTruncated(), longerCut = b.Label:IsTruncated(), longerLines = b.Label:GetNumLines() })`);
	assert.equal(out.wrap, true, 'the label wraps');
	assert.equal(out.lines, 2, 'at most two lines');
	assert.equal(out.twoLines, 2, 'the long label takes its second line');
	assert.equal(out.cut, false, 'a label that fits on two lines is not cut');
	assert.equal(out.longerLines, 2, 'a label longer still stops at two lines');
	assert.equal(out.longerCut, true, 'and only then is it cut');
});

test('a label on two lines makes its row taller, and the half beside it as tall', () => {
	const out = onPage(`{
		{ kind = "toggle", key = "ui.compact", label = "${LONG}" },
		{ kind = "toggle", key = "ui.locked", label = "Short" },
		{ kind = "toggle", key = "ui.growUp", label = "Short too" },
	}`, `local a, b, c = rows["ui.compact"], rows["ui.locked"], rows["ui.growUp"]
		local _, ay = a:GetPoint(1)
		emit({ a = a:GetHeight(), b = b:GetHeight(), c = c:GetHeight(), lines = a.Label:GetNumLines(),
			labelH = a.Label:GetStringHeight(), base = Polestar.Widgets.COMPACT_H })`,
	// The largest text size: two lines of label no longer fit in the 36px row.
	'Polestar.Set("ui.textSize", 1.4)');
	assert.equal(out.lines, 2);
	assert.ok(out.a > out.base, `the row grows past ${out.base} to hold two lines (${out.a})`);
	assert.ok(out.a >= out.labelH, 'the row holds the whole label');
	assert.equal(out.b, out.a, 'the half beside it is as tall, so the hairlines meet');
	assert.equal(out.c, out.base, 'the next row keeps the standard height');
});
