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

const LONG = 'A setting name long enough to need a second line';

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

test('Move is a glyph in the extras column, and the label sits beside its control', () => {
	const out = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			Polestar.UI.ShowOptions("guide")
			local rows = Polestar.UI.Options.Controls("guide")
			local w = rows["ui.launcher"]
			local m = w.MoveButton
			local inExtras = false
			for _, e in ipairs(w.psExtras or {}) do if e == m then inExtras = true end end
			local function at() local p, _, _, x = w.Track:GetPoint(1); return p, x end
			local tp, tx = at()
			local mp, _, _, mx = m:GetPoint(1)
			local wide = { width = w:GetWidth(), track = { tp, tx }, move = { mp, mx }, label = w.Label:GetWidth(), switchW = w.Track:GetWidth() }
			-- A half too narrow for the label column: the control back on the right edge.
			Polestar.Widgets.LayoutRow(w, 300)
			local np, nx = at()
			emit({ glyph = m.psMove == true, text = rawget(m, "Text") ~= nil, icon = tostring(m.Icon:GetTexture()), inExtras = inExtras,
				wide = wide, narrow = { np, nx } })`,
	}).emitted[0];
	assert.equal(out.glyph, true, 'Move is the extras column\'s glyph');
	assert.equal(out.text, false, 'it has no text label');
	assert.match(out.icon, /move$/, 'it draws the move glyph');
	assert.equal(out.inExtras, true, 'it stands with the row\'s extras');
	const { width, track, move, label, switchW } = out.wide;
	assert.equal(label, 196, 'the label takes its 196px column');
	assert.equal(track[0], 'RIGHT');
	const controlLeft = width + track[1] - switchW;
	assert.equal(controlLeft, 16 + 196 + 10, 'the switch stands 10px after the label column');
	assert.equal(move[0], 'LEFT');
	assert.ok(move[1] > controlLeft + 168, `Move stands right of the control zone (${move[1]})`);
	assert.ok(move[1] + 20 <= width - 16, 'and inside the half');
	assert.deepEqual(out.narrow, ['RIGHT', -16], 'a narrow half keeps its control on the right edge');
});
