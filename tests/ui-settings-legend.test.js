'use strict';
// The new settings page's card titles, "Legend" (W.LegendHeader and
// W.PillSwitch in addon/Polestar/Theme/Widgets.lua, laid out by
// addon/Polestar_Options/UI/Options.lua's layoutSections with
// { legend = true } from UI/Grouped.lua): the section title in the card's
// top border, "N changed" and Reset at its right only while the section has
// changes, a module's switch as a 64x26 pill before them, and a module that
// is off folded to its title, the pill and one grey line. A jump into such a
// card shows the row dimmed under that line. The current page keeps its band
// header. Against the real addon's modules and the fakes of
// tests/lua/stub_ui.lua; the stub has no layout (GetLeft is 0), so order is
// read from the anchors.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

function run(script, saved) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: saved || 'PolestarDB = { settings = {}, optionsLayout = "grouped" }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local G = O.Grouped
			-- The card on screen titled name.
			local function cardNamed(name)
				for _, card in ipairs(O.view.cards) do
					if card:IsShown() and card.psName == name then return card end
				end
			end
			-- The section card of setting key's row, on its page.
			local function rowPage(key)
				local c = O.ControlByKey(key)
				O.Select(c.page.key, c.tab)
				return c
			end
			${script}`,
	}).emitted;
}

test('a Legend header shows "N changed" and Reset only while its section has changes', () => {
	const [out] = run(`
		assert(Polestar.RegisterOptions({ page = "Legend", key = "legendpage", tab = "Tab", section = "Section", controls = {
			{ kind = "toggle", key = "ui.notesOpen", label = "One" },
			{ kind = "toggle", key = "ui.wholeStep", label = "Two" },
			{ kind = "toggle", key = "ui.growUp", label = "Three" },
		} }))
		Polestar.UI.ShowOptions()
		local function look()
			O.Select("legendpage", "Tab")
			local lg = rawget(cardNamed("Section"), "Legend")
			return { count = lg.Count:IsShown() and lg.Count:GetText() or false, reset = lg.Reset:IsShown() }
		end
		local clean = look()
		Polestar.Set("ui.notesOpen", not Polestar.Get("ui.notesOpen"))
		Polestar.Set("ui.wholeStep", not Polestar.Get("ui.wholeStep"))
		local changed = look()
		local lg = rawget(cardNamed("Section"), "Legend")
		local title = lg.Title:GetText()
		lg.Reset:GetScript("OnClick")(lg.Reset)
		local afterReset = look()
		-- The reset offers its Undo as a section's Reset does.
		local chip = rawget(O.frame, "UndoChip")
		local undo = chip ~= nil and chip:IsShown() and O.Undo()
		local back = look()
		emit({ clean = clean, changed = changed, afterReset = afterReset, title = title,
			header = cardNamed("Section").Header:IsShown(), undo = undo, back = back })`);
	assert.deepEqual(out.clean, { count: false, reset: false });
	assert.deepEqual(out.changed, { count: '2 changed', reset: true });
	assert.deepEqual(out.afterReset, { count: false, reset: false });
	assert.equal(out.title, 'Section');
	assert.equal(out.header, false, 'no band header under the Legend');
	assert.equal(out.undo, true, 'the Legend Reset offers Undo');
	assert.deepEqual(out.back, { count: '2 changed', reset: true }, 'Undo puts both back');
});

test('a module switch is a 64x26 pill with ON or OFF inside, before the count', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		local c = rowPage("rares.founder")
		Polestar.Set("rares.founder", not Polestar.Get("rares.founder"))
		local card = cardNamed(c.psSection.name)
		local lg = rawget(card, "Legend")
		local p = lg.Pill
		local _, _, _, px = p:GetPoint(1)
		local _, _, _, cx = lg.Count:GetPoint(1)
		local on = { w = p:GetWidth(), h = p:GetHeight(), text = p.Text:GetText() }
		p:GetScript("OnClick")(p, "LeftButton")
		local afterClick = Polestar.Get("rares.enabled")
		local off = rawget(cardNamed(c.psSection.name), "Legend").Pill.Text:GetText()
		-- The click folds the card at once.
		local note = rawget(cardNamed(c.psSection.name), "OffNote")
		local folded = note and note:IsShown() and not O.view.cache[c]:IsShown() or false
		emit({ pill = on, pillRight = px, countLeft = cx - lg.Count:GetStringWidth(), anchor = select(1, p:GetPoint(1)),
			countAnchor = select(1, lg.Count:GetPoint(1)), afterClick = afterClick, off = off, folded = folded })`);
	assert.deepEqual(out.pill, { w: 64, h: 26, text: 'ON' });
	assert.equal(out.anchor, 'RIGHT');
	assert.equal(out.countAnchor, 'RIGHT');
	assert.ok(out.pillRight <= out.countLeft, `pill right ${out.pillRight} before the count's left ${out.countLeft}`);
	assert.equal(out.afterClick, false, 'a click turns the module off');
	assert.equal(out.off, 'OFF');
	assert.equal(out.folded, true, 'the click folds the card');
});

test('a module that is off folds its card to the title, the pill and one grey line', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		local c = rowPage("rares.founder")
		Polestar.Set("rares.enabled", false)
		c = rowPage("rares.founder")
		local card = cardNamed(c.psSection.name)
		local shown = 0
		for _, ctl in ipairs(c.psSection.controls) do
			local w = O.view.cache[ctl]
			if w and w:IsShown() then shown = shown + 1 end
		end
		local lg = rawget(card, "Legend")
		emit({ line = rawget(card, "OffNote") and card.OffNote:IsShown() and card.OffNote:GetText() or false, rowsShown = shown,
			pill = lg.Pill:IsShown() and lg.Pill.Text:GetText(), title = lg.Title:GetText() })`);
	assert.equal(out.line, 'Rares is off. Turn it on to change its settings.');
	assert.equal(out.rowsShown, 0);
	assert.equal(out.pill, 'OFF');
	assert.equal(out.title, 'When a rare shows up');
});

test('a jump to a row of a module that is off shows it dimmed under the hint', () => {
	const [out] = run(`
		Polestar.Set("rares.enabled", false)
		Polestar.UI.ShowOptions()
		local c = O.ControlByKey("rares.founder")
		O.SetQuery(c.label)
		O.JumpTo("rares.founder")
		local w = O.view.cache[c]
		local card = cardNamed(c.psSection.name)
		-- Another row of that card stays folded away.
		local other = O.view.cache[c.psSection.controls[1]]
		local folded = { shown = w and w:IsShown() or false, alpha = w and w:GetAlpha() or 1, compact = w and w.psCompact or false, off = w and w.psOff or false,
			hint = (rawget(card, "OffNote") and card.OffNote:IsShown() or false), otherShown = other and other:IsShown() or false }
		-- The module on again: the card opens, the row at full strength.
		Polestar.Set("rares.enabled", true)
		card = cardNamed(c.psSection.name)
		emit({ folded = folded, unfolded = { alpha = w:GetAlpha(), shown = w:IsShown(), hint = card.OffNote:IsShown(), off = w.psOff or false,
			otherShown = O.view.cache[c.psSection.controls[1]]:IsShown() } })`);
	const { folded, unfolded } = out;
	assert.equal(folded.shown, true);
	assert.ok(folded.alpha <= 0.5, `alpha ${folded.alpha}`);
	// The row is disabled (its module is off): never brighter than its disabled
	// alpha (a full row's 0.45; a compact half keeps 1 and dims its parts).
	assert.equal(folded.alpha, Math.min(folded.compact ? 1 : 0.45, 0.5));
	if (folded.compact) assert.equal(folded.off, true, 'a compact half keeps its parts dimmed');
	assert.equal(folded.hint, true);
	assert.equal(folded.otherShown, false);
	assert.deepEqual(unfolded, { alpha: 1, shown: true, hint: false, off: false, otherShown: true });
});

test('the border gaps are thin strips of the card fill, not boxes of the window ground', () => {
	const [out] = run(`
		local W = Polestar.Widgets
		local roles = {}
		local realColor = W.Color
		W.Color = function(region, name, alpha) roles[region] = name return realColor(region, name, alpha) end
		Polestar.UI.ShowOptions()
		local c = rowPage("rares.founder")
		Polestar.Set("rares.founder", not Polestar.Get("rares.founder"))
		local lg = rawget(cardNamed(c.psSection.name), "Legend")
		W.Color = realColor
		local out = {}
		for _, name in ipairs({ "TitleGround", "RightGround" }) do
			local t = lg[name]
			out[name] = { h = t:GetHeight(), role = roles[t], shown = t:IsShown() }
		end
		emit(out)`);
	for (const name of ['TitleGround', 'RightGround']) {
		assert.ok(out[name].h <= 3, `${name} ${out[name].h} px tall`);
		assert.equal(out[name].role, 'panel', name);
		assert.equal(out[name].shown, true, name);
	}
});

test('the search on the new page shows a module that is off dimmed under the hint', () => {
	const [out] = run(`
		Polestar.Set("rares.enabled", false)
		Polestar.UI.ShowOptions()
		local c = O.ControlByKey("rares.founder")
		O.SetQuery(c.label)
		local v = O.Kit.searchView()
		local w = v.cache[c]
		local note
		for _, card in ipairs(v.cards) do
			if card:IsShown() and rawget(card, "OffNote") and card.OffNote:IsShown() then note = card.OffNote:GetText() end
		end
		emit({ shown = w and w:IsShown() or false, alpha = w and w:GetAlpha() or 1, note = note or false })`);
	assert.equal(out.shown, true);
	assert.ok(out.alpha <= 0.5, `alpha ${out.alpha}`);
	assert.equal(out.note, 'Rares is off. Turn it on to change its settings.');
});

test('the current page keeps its band header', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		local c = rowPage("rares.founder")
		local card = cardNamed(c.psSection.name)
		local lg = rawget(card, "Legend")
		Polestar.Set("rares.enabled", false)
		c = rowPage("rares.founder")
		local w = O.view.cache[c]
		emit({ legend = lg ~= nil and lg:IsShown() or false, header = card.Header:IsShown(),
			switch = card.psToggle ~= nil and card.psToggle.psHeaderSwitch == true,
			rowShown = w and w:IsShown() or false, offNote = rawget(card, "OffNote") and card.OffNote:IsShown() or false })`,
	'PolestarDB = { settings = {} }');
	assert.equal(out.legend, false);
	assert.equal(out.header, true);
	assert.equal(out.switch, true);
	assert.equal(out.rowShown, true, 'the current page shows the rows of a module that is off');
	assert.equal(out.offNote, false);
});
