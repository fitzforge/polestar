'use strict';
// The new settings page's header, "Search first" (addon/Polestar_Options/UI/
// Grouped.lua, addon/Polestar/Theme/Widgets.lua): a breadcrumb line, then a
// wide search with the switch, Peek, Fold, Reload UI and the ··· menu; close
// in the window's top-right corner, as in every Polestar window;
// the resets in ··· (each naming its scope), Undo inline beside the title and
// on the reset rows, and no footer. The current page keeps its own header and
// footer. Against the real addon's modules and the fakes of
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
			local L = Polestar.L
			local W = Polestar.Widgets
			-- The dialogs opened, as asked for (the last one).
			local modal
			local realModal = W.Modal
			W.Modal = function(spec) modal = spec return realModal(spec) end
			${script}`,
	}).emitted;
}

test('the new page has a breadcrumb line and a search row, and no footer', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("qualityoflife")
		local f = O.frame
		-- Line two, right to left from the main column's pad: each tool anchored RIGHT to the one on its right.
		local names = { [G.Switch()] = "switch", [rawget(f, "HeaderMenu") or f] = "···" }
		local byRight = {}
		for _, w in ipairs(f.psHeadTools) do
			if w:IsShown() then
				local _, rel = w:GetPoint(1)
				byRight[rel] = w
			end
		end
		local tools, at = {}, f.Header
		while byRight[at] and byRight[at] ~= f.Search do
			at = byRight[at]
			table.insert(tools, 1, names[at] or at.psTip)
		end
		local cp, crel, crp, cx, cy = f.Close:GetPoint(1)
		local close = { cp, crel == f.Header, crp, cx, cy }
		emit({ crumb = f.Title:GetText(), footer = f.Footer:IsShown(), searchW = f.Search:GetWidth(), mainW = f.psMainW,
			tools = tools, searchLeftOfSwitch = byRight[G.Switch()] == f.Search or byRight[G.Switch()] == f.Install, scale = f.HeaderTools:IsShown(),
			crumbG = { G.Crumb() }, close = close })`);
	assert.equal(out.crumb, 'Quality of Life › Essentials');
	assert.deepEqual(out.crumbG, ['Quality of Life', 'Essentials']);
	assert.equal(out.footer, false);
	assert.ok(out.searchW > out.mainW * 0.5, `the wide search (${out.searchW} of ${out.mainW})`);
	// The header's Install button, where this window is wide enough for it, stands between the switch and the search.
	assert.deepEqual(out.tools.filter((t) => t !== 'Install'), ['switch', 'Peek', 'Fold', 'Reload UI', '···']);
	assert.deepEqual(out.close, ['TOPRIGHT', true, 'TOPRIGHT', -12, -12], 'close in the top-right corner');
	assert.equal(out.searchLeftOfSwitch, true, 'the search first, left of the switch');
	assert.equal(out.scale, false, 'Menu scale is in ···, not the header');
});

test('··· holds Settings scale, Move frames and the two resets, each naming its scope', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("qualityoflife")
		local items = {}
		for _, it in ipairs(G.MenuItems()) do items[#items + 1] = it.text end
		local danger = {}
		for _, it in ipairs(G.MenuItems()) do if it.danger then danger[#danger + 1] = it.text end end
		O.AskResetPage(O.page)
		local pageText = modal and modal.text
		-- "Reset this page…" from ··· names the page on screen.
		O.Select("questing")
		modal = nil
		G.MenuItems()[3].onClick()
		local menuText = modal and modal.text
		Polestar.Set("nav.arrowScale", 1.3)
		O.AskResetAll()
		local allText = modal and modal.text
		-- The ··· button opens them as a menu.
		local opened
		local show = W.ShowMenu
		W.ShowMenu = function(anchor, list) opened = #list return show(anchor, list) end
		O.frame.HeaderMenu:Click()
		W.ShowMenu = show
		emit({ items = items, danger = danger, pageText = pageText, menuText = menuText, allText = allText, opened = opened })`);
	assert.deepEqual(out.items, ['Settings scale', 'Move frames', 'Reset this page…', 'Reset all settings…']);
	assert.deepEqual(out.danger, ['Reset this page…', 'Reset all settings…']);
	assert.match(out.pageText, /Quality of Life/);
	assert.match(out.pageText, /Other pages keep theirs/);
	assert.match(out.menuText, /Questing/, '··· resets the page on screen');
	assert.match(out.allText, /Default/);
	assert.equal(out.opened, 3, 'three rows; Menu scale is the menu\'s slider');
});

test('the header\'s icon tools are one box and one glyph, on one line at one gap from the pad', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("b:guiding")
		local f = O.frame
		local chain = {}
		-- Right to left from the main column's pad: each tool's RIGHT on the LEFT of the one before.
		local prev = f.Header
		for _, b in ipairs({ f.HeaderMenu, f.ReloadButton, f.FoldButton, f.PeekButton, G.Switch() }) do
			local p, rel, rp, x, y = b:GetPoint(1)
			chain[#chain + 1] = { after = rel == prev, p = p, rp = rp, gap = -x, y = y, w = b:GetWidth(), h = b:GetHeight(),
				glyph = rawget(b, "Icon") and b.Icon:GetWidth() or false, glyphH = rawget(b, "Icon") and b.Icon:GetHeight() or false }
			prev = b
		end
		emit(chain)`);
	const [first, ...rest] = out;
	assert.equal(first.after, true, 'the first on the header');
	assert.deepEqual([first.p, first.rp, first.gap], ['RIGHT', 'TOPRIGHT', 32], 'on the main column\'s pad');
	for (const t of rest) {
		assert.equal(t.after, true, 'chained right to left');
		assert.deepEqual([t.p, t.rp, t.y], ['RIGHT', 'LEFT', 0], 'on one line');
		assert.equal(t.gap, 8, 'one gap');
	}
	for (const t of out.slice(0, 4)) {
		assert.deepEqual([t.w, t.h], [24, 24], 'one box');
		assert.deepEqual([t.glyph, t.glyphH], [16, 16], 'one glyph size');
	}
});

test('Reset all on a profile with no changes says "Nothing to reset" and offers no reset', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("b:guiding")
		-- A profile with nothing changed (a first login stores a route line's look).
		for k in pairs(PolestarDB.settings) do PolestarDB.settings[k] = nil end
		O.AskResetAll()
		emit({ modal = { text = modal.text, action = modal.action } })`, 'PolestarDB = { optionsLayout = "grouped" }');
	// emit drops a nil field: no action reads as null.
	assert.deepEqual({ text: out.modal.text, action: out.modal.action ?? null }, { text: 'Nothing to reset', action: null });
});

test('a profile whose only stored value equals its default has nothing to reset', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("b:guiding")
		for k in pairs(PolestarDB.settings) do PolestarDB.settings[k] = nil end
		-- Stored as it is by default (written past ns.Set, which drops a default).
		PolestarDB.settings.nav = { arrowScale = Polestar.GetDefault("nav.arrowScale") }
		O.AskResetAll()
		emit({ text = modal.text, action = modal.action or false })`);
	assert.deepEqual(out, { text: 'Nothing to reset', action: false });
});

test('Menu scale is a slider in ··· itself: a drag writes ui.menuScale when it ends and leaves the menu open; the rows carry glyphs on one text edge', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("b:guiding")
		local b = O.frame.HeaderMenu
		b:Click()
		local f = b.psSlider
		local menu = f and f:GetParent()
		local res = { slider = f ~= nil, open = W.MenuShown(b), inMenu = menu ~= nil and W.MenuShown() and menu:IsShown(),
			shown = f ~= nil and f:IsShown(), key = f and f.psSpec.key, kind = f and f.psKind }
		local lo, hi = f.Slider:GetMinMaxValues()
		res.range = { lo, hi, f.psStep }
		local before = Polestar.Get("ui.menuScale")
		local v = (before == 1.2) and 0.9 or 1.2
		stub.RunScript(f.Slider, "OnMouseDown")
		f.Slider.value = v
		stub.RunScript(f.Slider, "OnValueChanged", v, true)
		res.during = Polestar.Get("ui.menuScale") == before
		stub.RunScript(f.Slider, "OnMouseUp")
		res.after = math.abs((Polestar.Get("ui.menuScale") or 0) - v) < 1e-6
		res.got = Polestar.Get("ui.menuScale")
		res.stillOpen = W.MenuShown(b) and f:IsShown()
		res.value = f.Value:GetText()
		-- The rows under it: a glyph each, their text on the slider label's edge.
		local _, _, _, sx = f:GetPoint(1)
		local rows = {}
		for _, r in ipairs(menu.rows) do
			if r:IsShown() then
				local _, _, _, rx, ry = r:GetPoint(1)
				local _, _, _, tx = r.Text:GetPoint(1)
				rows[#rows + 1] = { text = r.Text:GetText(), icon = r.Icon:IsShown(), textX = rx + tx, top = -ry }
			end
		end
		res.sliderX, res.rows, res.sliderH = sx, rows, f:GetHeight()
		-- Another list in the shared menu leaves the slider out.
		W.ShowMenu(b, { { text = "Other" } })
		stub.RunScript(f, "OnUpdate", 0)
		res.otherHides = not f:IsShown()
		W.HideMenu()
		emit(res)`);
	assert.equal(out.slider, true, 'a slider row in the menu');
	assert.equal(out.open, true);
	assert.equal(out.inMenu, true, 'a part of the open menu');
	assert.equal(out.shown, true);
	assert.equal(out.key, 'ui.menuScale');
	assert.equal(out.kind, 'slider');
	assert.deepEqual(out.range, [0.7, 1.4, 0.05]);
	assert.equal(out.during, true, 'nothing written during the drag (it rescales the menu)');
	assert.equal(out.after, true, 'written when the drag ends');
	assert.equal(out.stillOpen, true, 'the menu stays open');
	assert.match(out.value, /^\d+%$/);
	assert.deepEqual(out.rows.map((r) => r.text), ['Move frames', 'Reset this page…', 'Reset all settings…']);
	assert.ok(out.rows.every((r) => r.icon), 'each row has its glyph');
	assert.ok(out.rows.every((r) => r.textX === out.sliderX), 'every text on the slider label\'s edge');
	assert.ok(out.rows[0].top >= out.sliderH, 'the rows under the slider');
	assert.equal(out.otherHides, true, 'another list in the menu leaves it out');
});

test('search with no hits says "No settings match" and offers Clear', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("b:guiding")
		O.SetQuery("zzqqxx")
		local v = O.Kit.searchView()
		local empty = v.Empty:GetText()
		local clear = rawget(v, "Clear")
		local shown = clear and clear:IsShown() or false
		if clear then clear:Click() end
		emit({ empty = empty, shown = shown, afterClear = O.Kit.query(), box = O.frame.Search:GetText() or "" })`);
	assert.match(out.empty, /^No settings match/);
	assert.equal(out.shown, true);
	assert.equal(out.afterClear, '');
	assert.equal(out.box, '');
});

test('search hits name "page › tab"', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("b:guiding")
		O.SetQuery("flight")
		local titles = {}
		for _, g in ipairs(O.results.groups) do titles[#titles + 1] = g.title end
		emit({ titles = titles })`);
	assert.ok(out.titles.length > 0);
	assert.ok(out.titles.every((t) => t.split(' › ').length >= 2), out.titles.join(' | '));
	assert.ok(out.titles.includes('Quality of Life › Travel'), out.titles.join(' | '));
});

test('reset-all keeps the other profile and the account-wide window state', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("b:guiding")
		local P = Polestar.Profiles
		P.New("Raid")
		P.Switch("Raid")
		Polestar.Set("nav.arrowScale", 1.3)
		P.Switch("Default")
		Polestar.Set("nav.arrowScale", 1.2)
		G.Pin("nav.arrowScale", true)
		local held = O.ResetAll()
		emit({ otherKept = PolestarDB.profiles.Raid.nav.arrowScale, active = Polestar.Get("nav.arrowScale"), held = #held,
			db = { layout = PolestarDB.optionsLayout, pins = PolestarDB.optionsPins } })`);
	assert.equal(out.otherKept, 1.3);
	assert.equal(out.active, 1);
	assert.ok(out.held >= 1, 'what it reset is held for Undo');
	assert.deepEqual(out.db, { layout: 'grouped', pins: ['nav.arrowScale'] });
});

test('inline Undo restores a page reset, then leaves after 10 s', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("qualityoflife", L["Travel"])
		local f = O.frame
		Polestar.Set("maps.flightTimer", false)
		Polestar.Set("qol.sellJunk", false)
		O.ResetPage(O.page)
		local chip = f.UndoChip
		local rowUndo = false
		for c, w in pairs(O.view.cache) do
			if c.key == "maps.flightTimer" and rawget(w, "UndoB") and w.UndoB:IsShown() then rowUndo = true end
		end
		local chipParent = chip:GetParent() == f.Header and "Header" or chip:GetParent() == f.Footer and "Footer" or "?"
		local beside = select(2, chip:GetPoint(1)) == f.Title
		local reset = { Polestar.Get("maps.flightTimer"), Polestar.Get("qol.sellJunk") }
		O.Undo()
		local restored = { Polestar.Get("maps.flightTimer"), Polestar.Get("qol.sellJunk") }
		local rowAfterUndo = false
		for c, w in pairs(O.view.cache) do if rawget(w, "UndoB") and w.UndoB:IsShown() then rowAfterUndo = true end end
		O.ResetPage(O.page)
		local shownNow = chip:IsShown()
		stub.advance(10.5)
		local rowLeft = false
		for c, w in pairs(O.view.cache) do if rawget(w, "UndoB") and w.UndoB:IsShown() then rowLeft = true end end
		emit({ chipParent = chipParent, beside = beside, rowUndo = rowUndo, reset = reset, restored = restored,
			rowAfterUndo = rowAfterUndo, shownNow = shownNow, goneAfter10 = chip:IsShown(), rowLeft = rowLeft })`);
	assert.equal(out.chipParent, 'Header');
	assert.equal(out.beside, true, 'beside the title');
	assert.equal(out.rowUndo, true);
	assert.deepEqual(out.reset, [true, true], 'the page reset');
	assert.deepEqual(out.restored, [false, false]);
	assert.equal(out.rowAfterUndo, false);
	assert.equal(out.shownNow, true);
	assert.equal(out.goneAfter10, false);
	assert.equal(out.rowLeft, false);
});

test('the current page keeps its footer and builds no ···', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions("guide")
		local f = O.frame
		local foot = {}
		for _, b in ipairs(f.footerButtons.left) do if b:IsShown() then foot[#foot + 1] = b.Label:GetText() end end
		emit({ footer = f.Footer:IsShown(), menu = rawget(f, "HeaderMenu") ~= nil, scale = f.HeaderTools:IsShown(),
			move = f.MoveButton:IsShown(), foot = foot })`, 'PolestarDB = { settings = {} }');
	assert.equal(out.footer, true);
	assert.equal(out.menu, false);
	assert.equal(out.scale, true);
	assert.equal(out.move, true);
	assert.ok(out.foot.includes('Reload UI'));
});

test('switched off, the footer, the scale and Move frames come back; the new tools go', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("b:guiding")
		local f = O.frame
		G.SetOn(false)
		emit({ footer = f.Footer:IsShown(), scale = f.HeaderTools:IsShown(), move = f.MoveButton:IsShown(),
			menu = f.HeaderMenu:IsShown(), title = f.Title:GetText() })`);
	const { title, ...rest } = out;
	assert.deepEqual(rest, { footer: true, scale: true, move: true, menu: false });
	assert.ok(!title.includes(' › '), 'the classic title again');
});

// The Changed view hides the page it was opened from: ··· offers no reset
// of it there, and LB / RB step on from that page's tab.
test('in the Changed view, Reset this page… is off and LB / RB step on from the page it was opened from', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		-- The tab by name: another tab may stand first on the page.
		O.Select("questing", "Quests")
		local onPage = G.MenuItems()[3].disabled or false
		Polestar.Set("nav.arrowScale", 1.3)
		G.Filter("changed")
		local item = G.MenuItems()[3]
		local inView = { text = item.text, disabled = item.disabled or false }
		G.StepTab(1)
		local p, t = G.Current()
		emit({ onPage = onPage, inView = inView, page = p.key, tab = t.name })`);
	assert.equal(out.onPage, false, 'on a page it resets that page');
	assert.deepEqual(out.inView, { text: 'Reset this page…', disabled: true });
	assert.equal(out.page, 'questing');
	assert.equal(out.tab, 'Rewards & gear', 'the tab after the one the view was opened from');
});
