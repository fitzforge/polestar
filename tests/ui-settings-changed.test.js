'use strict';
// The new settings page's Changed view (addon/Polestar_Options/UI/Grouped.lua):
// the All / Changed filter covers the whole window, and Changed shows one
// Legend card per page with changes, in sidebar order, titled
// "Group › Page", each with its count, its Reset (the page's, with Undo) and
// a link to the page. The tab bar holds All and one jump tab per page. Close,
// Esc and the switch leave the view for the page it was opened from.
// Against the real addon's modules and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

function run(script) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: 'PolestarDB = { settings = {}, optionsLayout = "grouped" }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			local G = O.Grouped
			local W = O.frame
			-- The cards on screen, in order.
			local function cards()
				local out = {}
				for _, card in ipairs(O.view.cards) do if card:IsShown() then out[#out + 1] = card end end
				return out
			end
			local function titles()
				local out = {}
				for _, card in ipairs(cards()) do local lg = rawget(card, "Legend"); out[#out + 1] = lg and lg.Title:GetText() or "?" end
				return out
			end
			-- The folder tabs drawn, left to right.
			local function tabs()
				local out = {}
				local ft = rawget(O.frame, "FolderTabs")
				if not (ft and ft:IsShown()) then return out end
				for _, b in ipairs(ft.buttons) do if b:IsShown() then out[#out + 1] = b.Label:GetText() end end
				return out
			end
			local function cardOf(page)
				for _, card in ipairs(cards()) do if card.psPage and card.psPage.key == page then return card end end
			end
			-- The test login (an account from before them) stores a line style, turns the spawn markers off and keeps
			-- Skip grey quests off; every setting starts at its default here.
			Polestar.Set("nav.lineStyle", nil)
			Polestar.Set("mobMarkers.enabled", nil)
			Polestar.Set("behavior.skipGrey", nil)
			Polestar.UI.ShowOptions("qualityoflife")
			${script}`,
	}).emitted;
}

test('Changed: one card per page with changes, in sidebar order, titled "Group › Page"', () => {
	const [out] = run(`
		Polestar.Set("nav.arrowScale", 1.3)
		Polestar.Set("behavior.skipGrey", false)
		G.Filter("changed")
		local filters, changedCount = {}, nil
		local list = G._filters()
		for i = #list, 1, -1 do
			local b = list[i]
			if b:IsShown() then
				filters[#filters + 1] = b.Label:GetText()
				if b.Label:GetText() == Polestar.L["Changed"] then changedCount = tostring(b.Count:GetText()) end
			end
		end
		-- A row names its tab only on a page of more than one tab.
		local tabNameShown, multiTab = {}, {}
		for _, card in ipairs(cards()) do
			local p = card.psPage
			for c, w in pairs(O.view.cache) do
				if w:IsShown() and c.page == p and rawget(w, "Label") then
					local t = rawget(c, "psSection") and c.psSection.psTab
					local name = t and t.name or ""
					tabNameShown[#tabNameShown + 1] = name ~= "" and w.Label:GetText():sub(1, #name + 1) == name .. " " or false
					multiTab[#multiTab + 1] = #O.Kit.shownTabs(p) > 1
				end
			end
		end
		local pages = {}
		for _, e in ipairs(G.ChangedPages()) do pages[#pages + 1] = e.page.key .. "=" .. e.count end
		-- The icons of the jump tabs: each a glyph, none twice.
		local icons, seen, twice = {}, {}, false
		for _, b in ipairs(O.frame.FolderTabs.buttons) do
			if b:IsShown() then
				if seen[b.psIcon] then twice = true end
				seen[b.psIcon] = true
				icons[#icons + 1] = b.psIcon
			end
		end
		emit({ titles = titles(), filters = filters, changedCount = changedCount, jumpTabs = tabs(), pages = pages,
			tabNameShown = tabNameShown, multiTab = multiTab, counts = { cards()[1].Legend.Count:GetText(), cards()[2].Legend.Count:GetText() },
			twice = twice, icons = icons, crumb = O.frame.Title:GetText() })`);
	assert.deepEqual(out.titles, ['Guiding › Guide', 'Look › Arrow']);
	assert.deepEqual(out.filters, ['All', 'Changed'], 'no New');
	assert.equal(out.changedCount, '2');
	assert.deepEqual(out.pages, ['guide=1', 'arrow=1']);
	assert.deepEqual(out.jumpTabs, ['All', 'Guide 1', 'Arrow 1']);
	assert.deepEqual(out.counts, ['1 changed', '1 changed']);
	assert.ok(out.multiTab.length === 2, 'both changed rows are on screen');
	assert.deepEqual(out.tabNameShown, out.multiTab, "a row's tab name only when its page has more than one tab");
	assert.equal(out.twice, false, `every icon in the bar is unique: ${out.icons.join(', ')}`);
	assert.equal(out.crumb, 'Changed');
});

test('a card resets its page, offers Undo, and its link opens the page', () => {
	const [out] = run(`
		Polestar.Set("nav.arrowScale", 1.3)
		Polestar.Set("behavior.skipGrey", false)
		G.Filter("changed")
		local lg = cardOf("arrow").Legend
		lg.Reset:GetScript("OnClick")(lg.Reset)
		local afterReset = Polestar.GetStored("nav.arrowScale")
		local chip = rawget(O.frame, "UndoChip")
		local undo = chip ~= nil and chip:IsShown() and O.Undo()
		local back = titles()
		local open = rawget(cardOf("arrow"), "Open")
		open:GetScript("OnClick")(open)
		emit({ afterReset = afterReset, undo = undo, back = back, linkTitle = O.frame.Title:GetText() })`);
	assert.equal(out.afterReset ?? null, null, 'the setting is back at its default (nothing stored)');
	assert.equal(out.undo, true);
	assert.deepEqual(out.back, ['Guiding › Guide', 'Look › Arrow'], 'Undo brings the card back');
	assert.equal(out.linkTitle, 'Look › Arrow');
});

test('Esc and close return to the page you came from', () => {
	const [out] = run(`
		Polestar.Set("nav.arrowScale", 1.3)
		G.Filter("changed")
		local inView = O.frame.Title:GetText()
		O.frame:GetScript("OnKeyDown")(O.frame, "ESCAPE")
		local back = O.frame.Title:GetText()
		G.Filter("changed")
		O.frame.Close:GetScript("OnClick")(O.frame.Close)
		local closed = { title = O.frame.Title:GetText(), shown = O.frame:IsShown() }
		-- On the page, Esc is the window's own again.
		local key = O.frame:GetScript("OnKeyDown")
		if key then key(O.frame, "ESCAPE") end
		emit({ inView = inView, back = back, closed = closed, page = O.frame.Title:GetText() })`);
	assert.equal(out.inView, 'Changed');
	assert.equal(out.back, 'Quality of Life › Essentials');
	assert.deepEqual(out.closed, { title: 'Quality of Life › Essentials', shown: true });
	assert.equal(out.page, 'Quality of Life › Essentials');
});

test('turning the switch off in the Changed view returns to the current page at the same page and tab', () => {
	const [out] = run(`
		Polestar.Set("nav.arrowScale", 1.3)
		-- From a page's second tab.
		local tabs = O.Kit.shownTabs(O.Kit.pageByKey("guidewindow"))
		O.Select("guidewindow", tabs[2].name)
		G.Filter("changed")
		local inView = O.frame.Title:GetText()
		G.SetOn(false)
		local p, t = O.Kit.current()
		local off = { layout = PolestarDB.optionsLayout or false, page = p and p.key, tab = t and t.name }
		-- Back on: the page, not the Changed view.
		G.SetOn(true)
		local _, onTab = G.Current()
		emit({ inView = inView, off = off, second = tabs[2].name, on = { title = O.frame.Title:GetText(), tab = onTab.name } })`);
	assert.equal(out.inView, 'Changed');
	assert.deepEqual(out.off, { layout: false, page: 'guidewindow', tab: out.second });
	assert.deepEqual(out.on, { title: 'Look › Guide window', tab: out.second }, 'switched back on, the page is on screen, not Changed');
});

test('resetting a card in the Changed view drops it and its jump tab; the last one leaves the empty state', () => {
	const [out] = run(`
		Polestar.Set("nav.arrowScale", 1.3)
		Polestar.Set("behavior.skipGrey", false)
		G.Filter("changed")
		local lg = cardOf("arrow").Legend
		lg.Reset:GetScript("OnClick")(lg.Reset)
		local afterOne = { cards = #cards(), tabs = tabs() }
		lg = cardOf("guide").Legend
		lg.Reset:GetScript("OnClick")(lg.Reset)
		local v = O.view
		emit({ afterOne = afterOne, empty = rawget(v, "Empty") ~= nil and v.Empty:IsShown(), left = #cards(),
			text = rawget(v, "Empty") and v.Empty:GetText() })`);
	assert.deepEqual(out.afterOne, { cards: 1, tabs: ['All', 'Guide 1'] });
	assert.equal(out.empty, true);
	assert.equal(out.left, 0);
	assert.equal(out.text, 'Every setting at its default');
});

test('a setting changed while the Changed view is open lays it out again', () => {
	const [out] = run(`
		Polestar.Set("nav.arrowScale", 1.3)
		G.Filter("changed")
		local before = titles()
		Polestar.Set("behavior.skipGrey", false)
		emit({ before = before, after = titles() })`);
	assert.deepEqual(out.before, ['Look › Arrow']);
	assert.deepEqual(out.after, ['Guiding › Guide', 'Look › Arrow']);
});

// A section's switch shown as a reference (the Arrow page's "Show arrow",
// a home on Guide) counts where its home is: one change, one card, one
// count, one dot.
test('a section switch that is a reference counts once, at its home', () => {
	const [out] = run(`
		G.SetNavAll(true)
		local out = {}
		for _, key in ipairs({ "nav.arrow", "party.panel", "maps.flightTimer", "rares.alerts", "nav.routeLines", "nav.upcomingPins" }) do
			Polestar.Set(key, not Polestar.Get(key))
			local pages, nav, dots = {}, {}, {}
			for _, e in ipairs(G.ChangedPages()) do pages[#pages + 1] = e.page.key .. "=" .. e.count end
			for _, it in ipairs(G.NavItems()) do if it.indent and it.count then nav[#nav + 1] = (it.key:match("^t:([^\t]*)") or it.key) .. "=" .. it.count end end
			for _, p in ipairs(O.Kit.pages) do
				for _, t in ipairs(p.custom and {} or G.Tabs(p)) do if G.TabDot(t) then dots[#dots + 1] = p.key end end
			end
			G.Filter("changed")
			local list = titles()
			G.Back()
			Polestar.Set(key, nil)
			out[key] = { pages = pages, nav = nav, dots = dots, cards = list }
		end
		emit(out)`);
	for (const [key, o] of Object.entries(out)) {
		assert.equal(o.pages.length, 1, `${key}: one page counts it: ${o.pages.join(', ')}`);
		assert.match(o.pages[0], /=1$/, `${key}: counted once`);
		assert.deepEqual(o.nav, o.pages, `${key}: the sidebar counts it once`);
		assert.equal(o.cards.length, 1, `${key}: one card: ${o.cards.join(', ')}`);
		assert.deepEqual(o.dots, [o.pages[0].split('=')[0]], `${key}: one tab dot, at its home`);
	}
	assert.deepEqual(out['nav.arrow'].pages, ['guide=1']);
	assert.deepEqual(out['nav.arrow'].cards, ['Guiding › Guide']);
});

// Reset this page puts back the settings homed on it: a reference to
// another page's setting is left for that page.
test('Reset this page leaves the settings homed on other pages alone', () => {
	const [out] = run(`
		local K = O.Kit
		local sounds = Polestar.Rares.SOUNDS
		local kit = sounds[#sounds].value
		Polestar.Set("rares.soundKit", kit)
		Polestar.Set("nav.arrivalSound", not Polestar.Get("nav.arrivalSound"))
		O.ResetPage(K.pageByKey("alerts"))
		O.ResetPage(K.pageByKey("arrow"))
		local kept = { kit = Polestar.GetStored("rares.soundKit") ~= nil, chime = Polestar.GetStored("nav.arrivalSound") ~= nil }
		O.ResetPage(K.pageByKey("discovery"))
		O.ResetPage(K.pageByKey("guide"))
		emit({ kept = kept, cleared = { kit = Polestar.GetStored("rares.soundKit") ~= nil, chime = Polestar.GetStored("nav.arrivalSound") ~= nil } })`);
	assert.deepEqual(out.kept, { kit: true, chime: true }, 'Alerts and Arrow keep what Discovery and Guide hold');
	assert.deepEqual(out.cleared, { kit: false, chime: false }, 'their home pages put them back');
});
