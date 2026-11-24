'use strict';
// The settings window's grouped layout (addon/Polestar_Options/UI/Grouped.lua):
// the layout shows the same rows as the classic window in groups, switched on
// and off in the open window. Against the real addon's modules and the fakes of
// tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

function run(script, saved) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		saved: { Polestar: saved || 'PolestarDB = { settings = {} }' },
		addons: [{ name: 'Polestar', files: ALL }],
		script: `Polestar.UI.LoadOptions()
			uistub.install()
			stub.login()
			local O = Polestar.UI.Options
			${script}`,
	}).emitted;
}

test('the new page lists groups, each open on its pages, and a page shows its own tabs', () => {
	const [out] = run(`
		local G = O.Grouped
		PolestarDB.optionsLayout = "grouped"
		Polestar.UI.ShowOptions()
		O.Select("questing")
		local groups, open = {}, {}
		for _, it in ipairs(G.NavItems()) do
			if it.key and it.key:sub(1, 2) == "b:" then groups[#groups + 1] = it.key
			elseif it.key and it.indent then open[#open + 1] = it.key end
		end
		local tree = {}
		for _, g in ipairs(G.Tree()) do
			local keys = {}
			for _, p in ipairs(g.pages) do keys[#keys + 1] = p.key end
			tree[g.key] = keys
		end
		local p, t = G.Current()
		local tabs = {}
		for _, tt in ipairs(G.Tabs(p)) do tabs[#tabs + 1] = tt.name end
		local lookHas = false
		local has = {}
		for _, k in ipairs(tree.look) do has[k] = true end
		lookHas = has.guidewindow == true and has.alerts == true
		emit({ groups = groups, open = open, guidingPages = tree.guiding, crumb = O.frame.Title:GetText(), page = p.key,
			tab = t.name, tabs = tabs, lookHas = lookHas, navKey = G.NavKey() })`);
	assert.deepEqual(out.groups, ['b:guiding', 'b:qol', 'b:look', 'b:setup'], 'About and Guiding Stars stand at the foot, not as a group');
	assert.deepEqual(out.guidingPages, ['guide', 'questing', 'map', 'discovery']);
	assert.deepEqual(out.open, out.guidingPages, 'the group shown, Guiding, lists its pages');
	assert.equal(out.crumb, 'Guiding › Questing');
	assert.equal(out.page, 'questing');
	assert.equal(out.tab, out.tabs[0], 'a page opens on its first tab');
	// By name, not place: a branch may put a tab of its own (Essentials) before them.
	assert.deepEqual(out.tabs.filter((n) => ['Quests', 'Rewards & gear', 'Buttons'].includes(n)), ['Quests', 'Rewards & gear', 'Buttons']);
	assert.equal(out.navKey, 'questing', 'the page is lit in the sidebar');
	assert.equal(out.lookHas, true);
});

test('groups come from G.TREE: a fifth group and a moved page need only a table edit', () => {
	const [out] = run(`
		local G = O.Grouped
		PolestarDB.optionsLayout = "grouped"
		for i = #G.TREE, 1, -1 do
			local g = G.TREE[i]
			if g.key == "qol" then table.remove(G.TREE, i)
			elseif g.key == "guiding" then
				for j = #g.pages, 1, -1 do
					if g.pages[j] == "discovery" then table.remove(g.pages, j) end
				end
			end
		end
		G.TREE[#G.TREE + 1] = { key = "extra", pages = { "qualityoflife" } }
		G.Invalidate()
		Polestar.UI.ShowOptions()
		O.Select("qualityoflife")
		local crumbQol = O.frame.Title:GetText()
		local groups = {}
		for _, it in ipairs(G.NavItems()) do if it.key and it.key:sub(1, 2) == "b:" then groups[#groups + 1] = it.key end end
		local guiding = {}
		for _, g in ipairs(G.Tree()) do
			if g.key == "guiding" then for _, p in ipairs(g.pages) do guiding[#guiding + 1] = p.key end end
		end
		O.Select("discovery")
		local orphan = false
		for _, it in ipairs(G.NavItems()) do if it.key == "discovery" then orphan = true end end
		emit({ groups = groups, guidingPages = guiding, crumbQol = crumbQol, orphanShown = orphan and guiding[#guiding] == "discovery",
			crumbOrphan = O.frame.Title:GetText() })`);
	assert.deepEqual(out.groups, ['b:guiding', 'b:look', 'b:setup', 'b:extra']);
	assert.equal(out.guidingPages.includes('qualityoflife'), false);
	assert.ok(out.crumbQol.startsWith('Quality of Life \u203a ') && !out.crumbQol.includes('Quality of Life \u203a Quality of Life'),
		`the label falls back to the page name, said once, then the tab (${out.crumbQol})`);
	assert.equal(out.orphanShown, true, 'a page left out of G.TREE still appears, last in its classic group');
	assert.equal(out.crumbOrphan, 'Guiding › Discovery');
});

// The window open in the classic layout, then switched to the grouped one and
// back, as the header's switch does: what each shows.
test('the switch lays the open window out in groups and back, with the same rows', () => {
	const [out] = run(`
		local G = O.Grouped
		Polestar.UI.ShowOptions("guide")
		local function rows()
			local n = 0
			for _, w in pairs(O.view.cache) do if w:IsShown() then n = n + 1 end end
			return n
		end
		G.SetOn(true)
		local nav = {}
		for _, it in ipairs(G.NavItems()) do if it.key then nav[#nav + 1] = it.key end end
		local on = { layout = PolestarDB.optionsLayout, title = O.frame.Title:GetText(), rows = rows() }
		O.Select("b:look")
		local look = { title = O.frame.Title:GetText(), rows = rows() }
		-- A setting off its default shows under Changed; the window's search keeps the groups.
		Polestar.Set("nav.arrowScale", 1.3)
		O.Select("arrow")
		G.Filter("changed")
		local changed = {}
		for c, w in pairs(O.view.cache) do if w:IsShown() and c.key then changed[#changed + 1] = c.key end end
		G.Filter("all")
		O.SetQuery("sclae")
		local titles = {}
		for _, g in ipairs(O.results.groups) do titles[#titles + 1] = g.title end
		O.SetQuery("")
		local back = O.frame.Title:GetText()
		-- LB / RB run on from a page's last tab into the next page.
		O.Select("guidewindow")
		for _ = 1, 4 do O.StepTab(1) end
		local stepped = O.frame.Title:GetText()
		local _, steppedTab = G.Current()
		-- A row's jump lands on its page's tab.
		local w = O.JumpTo("ui.width")
		local _, jumpTab = G.Current()
		local jumped = { title = O.frame.Title:GetText(), tab = jumpTab.name, shown = w ~= nil and w:IsShown() }
		G.SetOn(false)
		emit({ nav = nav, on = on, look = look, changed = changed, titles = titles, back = back,
			stepped = stepped, steppedTab = steppedTab.name, jumped = jumped,
			off = { layout = PolestarDB.optionsLayout or false, title = O.frame.Title:GetText() } })`);
	assert.deepEqual(out.nav, ['b:guiding', 'guide', 'questing', 'map', 'discovery', 'b:qol', 'b:look', 'b:setup', 'about', 'thanks', 'profile'],
		'four groups, Guiding open on its pages, then About, Guiding Stars and the profile at the foot');
	assert.equal(out.on.layout, 'grouped', 'the choice is saved for the account');
	assert.equal(out.on.title, 'Guiding › Guide', 'the Guide page stays on screen');
	assert.ok(out.on.rows > 0 && out.look.rows > 0, 'the pages show their rows');
	assert.equal(out.look.title, 'Look › Guide window', "a group opens on its first page");
	assert.ok(out.changed.includes('nav.arrowScale'), 'Changed lists the row off its default');
	assert.ok(out.titles.length > 0 && out.titles.every((t) => t.split(' › ').length >= 2), 'search results say where each lives here');
	assert.ok(out.titles.some((t) => t.startsWith('Alerts & toasts › ')), `by page and tab: ${out.titles.join(' | ')}`);
	assert.equal(out.back, 'Look › Arrow', 'closing the search comes back to the page it left');
	assert.equal(out.stepped, 'Look › Theme', "RB runs on from Guide window's last tab into Theme");
	assert.equal(out.steppedTab, 'Colour');
	assert.deepEqual(out.jumped, { title: 'Look › Guide window', tab: 'Window', shown: true }, "a jump to a setting opens its page's tab on its row");
	assert.deepEqual(out.off, { layout: false, title: 'Guide window' }, 'switched off, the classic page on screen is back');
});

// A reference whose home section's switch is off says so on its section,
// with the way to that switch; a section whose own header holds the switch
// shows no line.
test("at 860 wide the longest page breadcrumb reads whole in German and Russian", () => {
	const P = require('../tools/commands/preview');
	const { audit, describe, fontsFor, localeCodepoints, localeLua, interfaceFile } = require('../tools/preview/fit');
	const { LOCALES } = require('../tools/lib/i18n/locales');
	const fonts = fontsFor(1.15);
	const metrics = P.metricsLua(fonts, localeCodepoints(Object.keys(LOCALES).map(interfaceFile)));
	const panel = { roots: ['PolestarOptions'] };
	for (const locale of ['deDE', 'ruRU']) {
		const { emitted } = runAddon({
			stubs: ['stub_ui.lua'],
			before: P.panelBefore(panel, `${metrics}\n${localeLua(locale)}`),
			addons: [{ name: 'Polestar', files: P.FILES }],
			script: `uistub.install()
				stub.login()
				PolestarDB.optionsLayout = "grouped"
				Polestar.Set("ui.optionsSize", { 860, 800 })
				Polestar.UI.ShowOptions()
				local f, O = PolestarOptions, Polestar.UI.Options
				local long, most = nil, 0
				local keys = {}
				for _, g in ipairs(O.Grouped.Tree()) do for _, p in ipairs(g.pages) do keys[#keys + 1] = p.key end end
				for _, key in ipairs(keys) do
					O.Select(key)
					Polestar.Theme.SetFontScale(f.Title, nil)
					local w = f.Title:GetUnboundedStringWidth()
					if w > most then long, most = key, w end
				end
				O.Select(long)
				stub.advance(1)
				emit({ title = f.Title:GetText(), label = f.HeaderTools:IsShown() })
				preview.emit()`,
		});
		const [{ title, label }, dump] = emitted;
		assert.equal(label, false, `${locale}: no scale in the header for "${title}"`);
		const cut = audit(dump, panel.roots, fonts, ['cut']).filter((f) => f.text === title && f.over >= 1);
		assert.deepEqual(cut.map(describe), [], `${locale}: "${title}" reads whole`);
	}
});

// Each tab of Guide window names its sections once, so none reads as "Tab ›
// Section"; a map entry's `title` renames a section there and keeps its rows,
// the ones registered in it.
test("a long tab's index lights its last sections at the end, and folds what doesn't fit under More", () => {
	const [out] = run(`
		local G = O.Grouped
		Polestar.UI.ShowOptions("guide")
		G.SetOn(true)
		-- A tab of many sections: 36 rows, over the index's 30.
		for i = 1, 12 do
			local rows = {}
			for j = 1, 3 do rows[j] = { kind = "button", button = "Go", label = "Row " .. j, onClick = function() end } end
			assert(Polestar.RegisterOptions({ page = "Long", key = "long", tab = "Tab", section = "Section number " .. i, controls = rows }))
		end
		O.Select("long")
		local sf = O.frame.Scroll
		local last
		for _, c in ipairs(O.view.cards) do if c:IsShown() and (not last or (c.psTop or 0) > (last.psTop or 0)) then last = c end end
		local range = math.max(0, (sf.psContent or 0) - (sf.psView or 0))
		local function links()
			local lit, final, n = nil, nil, 0
			for _, s in ipairs({ Polestar.Widgets.ShellPreviewSlot(O.frame):GetChildren() }) do
				if rawget(s, "Count") then
					for _, l in ipairs({ s:GetChildren() }) do
						if l:IsShown() and rawget(l, "psOn") ~= nil then
							n = n + 1
							final = l.Label:GetText()
							if l.psOn then lit = l.Label:GetText() end
						end
					end
				end
			end
			return { lit = lit, final = final, n = n }
		end
		Polestar.Widgets.ScrollTo(sf, range)
		local atEnd = links()
		Polestar.Widgets.ScrollTo(sf, 0)
		local atTop = links()
		-- A narrow window: the links fold under More.
		O.frame:SetWidth(860)
		O.Select("long")
		Polestar.Widgets.ScrollTo(sf, math.max(0, (sf.psContent or 0) - (sf.psView or 0)))
		local narrow = links()
		narrow.entries = #Polestar.UI.Options.Grouped._entries()
		emit({ top = last.psTop or 0, bottom = (last.psTop or 0) + last:GetHeight(), range = range, view = sf.psView or 0,
			lastName = last.psSection and last.psSection.name, atEnd = atEnd, atTop = atTop, narrow = narrow, more = Polestar.L["More"] })`);
	assert.ok(out.atEnd.n > 2, `the tab has an index (${out.atEnd.n} links)`);
	assert.ok(out.range + out.view <= out.bottom + 64, `no empty run past the last section (${out.range} + ${out.view} vs ${out.bottom})`);
	assert.equal(out.atEnd.lit, out.atEnd.final, 'scrolled to the end, the last link is lit');
	assert.notEqual(out.atTop.lit, out.atEnd.lit, 'at the top another one is');
	assert.ok(out.narrow.n < out.narrow.entries, `narrow: More stands for the folded ones (${out.narrow.n} links of ${out.narrow.entries})`);
	assert.equal(out.narrow.lit, out.narrow.final, 'narrow: More, last, is lit');
	assert.notEqual(out.narrow.final, out.more, 'and takes the lit section\'s name');
});

// Closing the window after a Guide window or Look setting changed offers a
// reload (recommended, skippable); a Guiding or Arrow setting doesn't, nor
// does the window stepping aside for Move frames.
test('closing after a Guide window or Look change offers a reload; Guiding and Arrow changes do not', () => {
	const [out] = run(`
		local G = O.Grouped
		local W = Polestar.Widgets
		local asked = {}
		local modal = W.Modal
		W.Modal = function(spec) asked[#asked + 1] = { title = spec.title, action = spec.action, cancel = spec.cancel } end
		Polestar.UI.ShowOptions("guide")
		G.SetOn(true)
		Polestar.Set("qol.xpTracker", false)
		O.frame:Hide(); G._offerReload()
		local guiding = #asked
		Polestar.UI.ShowOptions("guide")
		Polestar.Set("nav.arrowScale", 1.3)
		O.frame:Hide(); G._offerReload()
		local arrow = #asked
		Polestar.UI.ShowOptions("guide")
		Polestar.Set("ui.scale", 1.2)
		O.frame:Hide(); G._offerReload()
		local look = #asked
		O.frame:Hide(); G._offerReload()
		W.Modal = modal
		emit({ guiding = guiding, arrow = arrow, look = look, again = #asked, first = asked[1] })`);
	assert.equal(out.guiding, 0, 'a Guiding setting asks nothing');
	assert.equal(out.arrow, 0, 'an Arrow setting asks nothing');
	assert.equal(out.look, 1, 'a Guide window or Look setting asks once');
	assert.equal(out.again, 1, 'and not again with nothing new');
	assert.deepEqual(out.first, { title: 'Reload to finish?', action: 'Reload UI', cancel: 'Not now' });
});

// The sidebar is a tree: the group shown is open on its pages, a page picked
// there is the one shown and lit; another group opens in its place.
test('the sidebar opens the group shown on its pages, and a page picked there is shown', () => {
	const [out] = run(`
		local G = O.Grouped
		PolestarDB.optionsLayout = "grouped"
		Polestar.UI.ShowOptions()
		O.Select("b:look")
		local function keys()
			local out, open, pages = {}, {}, {}
			for _, it in ipairs(G.NavItems()) do
				if it.key then out[#out + 1] = it.key end
				if it.open then open[#open + 1] = it.key end
				if it.indent then pages[#pages + 1] = it.key end
			end
			return out, open, pages
		end
		local _, lookOpen, lookPages = keys()
		local second = lookPages[2]
		-- The page's sidebar row clicked.
		local row
		for _, b in ipairs(O.frame.navButtons) do if b:IsShown() and b.psKey == second then row = b end end
		stub.RunScript(row, "OnClick")
		local lit
		for _, b in ipairs(O.frame.navButtons) do if b:IsShown() and b.psOn then lit = b.psKey end end
		local p = G.Current()
		local band = G.NavKey()
		O.Select("b:guiding")
		local _, guidingOpen, guidingPages = keys()
		emit({ lookOpen = lookOpen, lookPages = lookPages, second = second, lit = lit, band = band,
			shown = p.key, title = O.frame.Title:GetText(), guidingOpen = guidingOpen, guidingPages = guidingPages })`);
	assert.deepEqual(out.lookOpen, ['b:look'], 'Look is open');
	assert.deepEqual(out.lookPages.slice(0, 3), ['guidewindow', 'theme', 'arrow'], 'with its pages, and no other group\'s');
	assert.ok(!out.lookPages.includes('guide'));
	assert.equal(out.lit, out.second, 'the page clicked is lit in the sidebar');
	assert.equal(out.band, out.second);
	assert.equal(out.shown, out.second, 'and shown');
	assert.deepEqual(out.guidingOpen, ['b:guiding'], 'another group opens in its place');
	assert.ok(!out.guidingPages.includes('theme'), "Look's pages fold away");
});

// Under the tree: the pinned settings, each a live control ({ pin = key }),
// and the profile card at the sidebar's foot ({ profile = name }). A row's
// flag pins it; the pin is saved for the account and its sidebar label goes
// to the setting.
test('pinned settings sit under the tree, with the profile last', () => {
	const [out] = run(`
		local G = O.Grouped
		PolestarDB.optionsLayout = "grouped"
		Polestar.UI.ShowOptions()
		O.Select("arrow")
		local function order()
			local out = {}
			for _, it in ipairs(G.NavItems()) do
				if it.heading then out[#out + 1] = "h:" .. it.label
				elseif it.fill then out[#out + 1] = "fill"
				elseif it.pin then out[#out + 1] = "pin:" .. it.pin
				elseif it.profile then out[#out + 1] = "profile:" .. it.profile
				elseif it.key and not it.indent then out[#out + 1] = it.key end
			end
			return out
		end
		local empty = order()
		-- The flag on a row, as its hover shows it, clicked.
		local row = O.JumpTo("nav.arrowScale")
		G._placePin(row, row.psControl)
		local flag
		for _, k in ipairs({ row:GetChildren() }) do if rawget(k, "psKey") == "nav.arrowScale" then flag = k end end
		flag:Click()
		local pinned = order()
		local saved = PolestarDB.optionsPins and PolestarDB.optionsPins[1]
		O.Select("b:guiding")
		G.NavSelect("p:nav.arrowScale")
		local went = O.frame.Title:GetText()
		G.Pin("nav.arrowScale", false)
		emit({ empty = empty, pinned = pinned, saved = saved or false, went = went, after = PolestarDB.optionsPins[1] or false })`);
	const L = { pinned: 'h:Pinned', hint: 'h:Pin a setting with the flag on its row.' };
	assert.deepEqual(out.empty, ['b:guiding', 'b:qol', 'b:look', 'b:setup', L.pinned, L.hint, 'fill', 'about', 'thanks', 'profile:Default'], 'with none pinned the heading says how');
	assert.deepEqual(out.pinned.slice(4), [L.pinned, 'pin:nav.arrowScale', 'fill', 'about', 'thanks', 'profile:Default'], 'a pinned setting under its heading');
	assert.equal(out.saved, 'nav.arrowScale', 'saved for the account');
	assert.equal(out.went, 'Look › Arrow', "its sidebar row goes to the setting's page");
	assert.equal(out.after, false, 'and unpins');
});

// The flag stays while the pointer goes from the row to it: across the row's
// reset (the row hears OnLeave on entering its own parts) and onto the flag,
// and goes once the pointer is on neither (POL-54).
test("a row's pin stays while the pointer moves onto it and goes once it leaves both", () => {
	const [out] = run(`
		PolestarDB.optionsLayout = "grouped"
		Polestar.UI.ShowOptions()
		O.Select("arrow")
		Polestar.Set("nav.arrowScale", 1.4)
		local row = O.JumpTo("nav.arrowScale")
		local onRow, onFlag = false, false
		row.IsMouseOver = function() return onRow end
		local function hover() onRow = true stub.RunScript(row, "OnEnter") end
		hover()
		local flag
		for _, k in ipairs({ row:GetChildren() }) do if rawget(k, "psKey") == "nav.arrowScale" then flag = k end end
		flag.IsMouseOver = function() return onFlag end
		local seen = {}
		local reset = rawget(row, "ResetB")
		seen.reset = reset ~= nil and reset:IsShown() or false
		-- On the reset, inside the row: the row hears OnLeave.
		stub.RunScript(row, "OnLeave")
		stub.advance(0.1)
		seen.onReset = flag:IsShown()
		-- On the flag.
		onRow, onFlag = false, true
		stub.advance(0.1)
		seen.onFlag = flag:IsShown()
		-- Off both, from the flag.
		onFlag = false
		stub.RunScript(flag, "OnLeave")
		seen.offFlag = flag:IsShown()
		-- Off both, from the reset (only the reset hears OnLeave).
		hover()
		stub.RunScript(row, "OnLeave")
		onRow = false
		stub.advance(0.1)
		seen.offReset = flag:IsShown()
		-- Off both, from the row itself.
		hover()
		onRow = false
		stub.RunScript(row, "OnLeave")
		seen.offRow = flag:IsShown()
		Polestar.Set("nav.arrowScale", nil)
		emit(seen)`);
	assert.equal(out.reset, true, 'the changed row shows its reset next to the flag');
	assert.equal(out.onReset, true, 'the flag stays while the pointer crosses the reset');
	assert.equal(out.onFlag, true, 'and while it is on the flag');
	assert.equal(out.offFlag, false, 'it goes when the pointer leaves the flag for elsewhere');
	assert.equal(out.offReset, false, 'it goes when the pointer leaves the row by its reset');
	assert.equal(out.offRow, false, 'it goes when the pointer leaves the row');
});

// The Preview panel: only a page with a live preview has one (and its
// Preview button); Guiding's pages and Setup's have neither, and their rows
// take the width. The button hides the panel for the account.
test('the Preview panel stands only beside a page with a live preview, and its button hides it for the account', () => {
	const [out] = run(`
		local G = O.Grouped
		PolestarDB.optionsLayout = "grouped"
		Polestar.Set("ui.optionsSize", { 1500, 900 })
		Polestar.UI.ShowOptions()
		local names = {}
		for _, key in ipairs({ "guide", "guidewindow", "arrow", "theme", "profiles" }) do
			O.Select(key)
			local b = G.PreviewButton()
			names[key] = (b and b:IsShown()) and b.Label:GetText() or false
		end
		O.Select("guidewindow")
		local narrowed = O.frame.BodyWidth
		local b = G.PreviewButton()
		local shownTip = b.psTip
		stub.RunScript(b, "OnClick")
		emit({ names = names, hidden = PolestarDB.optionsPreviewHidden or false, shownTip = shownTip, hiddenTip = b.psTip,
			still = b:IsShown(), grew = O.frame.BodyWidth > narrowed })`);
	assert.deepEqual(out.names, { guide: false, guidewindow: 'Preview', arrow: 'Preview', theme: 'Preview', profiles: false });
	assert.equal(out.shownTip, 'Hide preview');
	assert.equal(out.hidden, true, 'hidden, saved for the account');
	assert.equal(out.hiddenTip, 'Show preview', 'the button stays, to show it again');
	assert.equal(out.still, true);
	assert.equal(out.grew, true, 'the rows take the width');
	// Not chosen yet, a narrow window keeps the panel off its rows; the button shows it.
	const [narrow] = run(`
		local G = O.Grouped
		Polestar.Set("ui.optionsSize", { 860, 800 })
		Polestar.UI.ShowOptions()
		O.Select("guidewindow")
		local b = G.PreviewButton()
		local tip = b.psTip
		stub.RunScript(b, "OnClick")
		emit({ tip = tip, after = b.psTip, saved = PolestarDB.optionsPreviewHidden })`, 'PolestarDB = { settings = {}, optionsLayout = "grouped" }');
	assert.deepEqual(narrow, { tip: 'Show preview', after: 'Hide preview', saved: false }, 'narrow: hidden until the button shows it, then saved shown');
});

// Move frames is the second item of the header's ··· menu (unlock mode, the
// window steps aside and comes back); the new page has no footer.
test('Move frames is in ··· and opens unlock mode; the new page shows no footer', () => {
	const [out] = run(`
		PolestarDB.optionsLayout = "grouped"
		Polestar.UI.ShowOptions()
		O.Select("b:look")
		local f = O.frame
		local foot = {}
		for _, side in ipairs({ "left", "right" }) do
			for _, b in ipairs(f.footerButtons[side]) do if b:IsShown() then foot[#foot + 1] = b.Label:GetText() end end
		end
		local item = O.Grouped.MenuItems()[2]
		item.onClick()
		local M = Polestar.Movers
		local unlocked, away = M.IsUnlocked(), not f:IsShown()
		M.Lock()
		emit({ foot = #foot, footer = f.Footer:IsShown(), text = item.text, header = f.MoveButton:IsShown(), unlocked = unlocked,
			away = away, back = f:IsShown(), title = f.Title:GetText() })`);
	assert.equal(out.foot, 0, 'no footer button shows');
	assert.equal(out.footer, false);
	assert.equal(out.text, 'Move frames');
	assert.equal(out.header, false, 'not a header button on the new page');
	assert.equal(out.unlocked, true, 'unlock mode is on');
	assert.equal(out.away, true, 'the window steps aside');
	assert.equal(out.back, true, 'and comes back when it ends');
	assert.equal(out.title, 'Look › Guide window', 'on the page it left');
});

// The stub has no layout (GetLeft is 0), so the placement is read from the anchors:
// each header tool is anchored RIGHT to the one on its right.
test('the switch reads "New settings page" and stands where each page puts it', () => {
	const [out, again] = run(`
		Polestar.UI.ShowOptions("guide")
		local f, G = O.frame, O.Grouped
		local sw, scale = G.Switch(), f.HeaderTools
		local function rightOf(w) local _, rel = w:GetPoint(1) return rel end
		local classic = { label = sw.Label:GetText(), afterScale = rightOf(scale) == sw, beforeClose = rightOf(sw) == f.Close }
		G.SetOn(true)
		local tools = f.psHeadTools
		local at
		for i, t in ipairs(tools) do if t == f.Search then at = i end end
		emit({ classic = classic, notAfterScale = not scale:IsShown(),
			switchBeforeSearch = tools[at - 1] == sw, tip = sw.Sw.psTip })
		G.SetOn(false)
		emit({ back = rightOf(sw) == f.Close })`);
	assert.deepEqual(out.classic, { label: 'New settings page', afterScale: true, beforeClose: true });
	assert.equal(out.notAfterScale, true, 'new page: the scale is in ···, not between it and close');
	assert.equal(out.switchBeforeSearch, true, 'new page: the icon button next to the search, on its right');
	assert.equal(out.tip, 'New settings page');
	assert.equal(again.back, true, 'switched off: back after the scale');
});

test('the new page says Settings, never Options', () => {
	const [out] = run(`
		PolestarDB.optionsLayout = "grouped"
		Polestar.UI.ShowOptions()
		local texts = {}
		for _, key in ipairs({ "b:guiding", "b:qol", "b:look", "b:setup" }) do O.Select(key); for _, t in ipairs(O.Grouped.NewPageText(O.frame)) do texts[#texts + 1] = t end end
		emit({ texts = texts })`);
	assert.deepEqual(out.texts.filter((t) => /\bOptions\b/.test(t)), []);
});

test('the halves split on one hairline per run of halves, at the column split, none of them overlapping', () => {
	const [out] = run(`
		PolestarDB.optionsLayout = "grouped"
		Polestar.UI.ShowOptions()
		O.Select("questing")
		local view = O.view
		local mids, left, right = {}, nil, nil
		for _, t in ipairs(view.mids or {}) do
			if t:IsShown() then
				local _, _, _, x, y = t:GetPoint(1)
				mids[#mids + 1] = { x = x, top = -y, h = t:GetHeight() }
			end
		end
		local pairs_ = 0
		for c, w in pairs(view.cache) do if w:IsShown() and rawget(w, "psPair") then pairs_ = pairs_ + 1 end end
		emit({ mids = mids, pairs = pairs_ })`);
	assert.ok(out.mids.length >= 1, 'a hairline down the halves');
	assert.ok(out.mids.length < out.pairs, 'one per run, not one per pair of rows');
	out.mids.sort((a, b) => a.top - b.top);
	for (const [i, m] of out.mids.entries()) {
		if (i) assert.ok(m.top >= out.mids[i - 1].top + out.mids[i - 1].h, 'hairlines do not overlap');
	}
});

// A reference whose home section's switch is off says so on its section,
// with the way to that switch; a section whose own header holds the switch
// shows no line.
test('a reference waiting on a switch in another tab shows the dependency line and its way there', () => {
	const [out] = run(`
		local G = O.Grouped
		local L = Polestar.L
		PolestarDB.optionsLayout = "grouped"
		Polestar.Set("nav.routeLines", false)
		Polestar.Set("maps.instances", false)
		Polestar.UI.ShowOptions()
		local function lineFor(key)
			local text = string.format(L["Turn on %s first."], O.Kit.labelOf(O.HomeControl(key)))
			for c, w in pairs(O.view.cache) do
				if w:IsShown() and c.kind == "button" and c.label == text then return c end
			end
		end
		O.Select("trackers", L["Instances & XP"])
		local own = lineFor("maps.instances") ~= nil
		-- Map pins › Essentials › Numbered pins holds its switch in its header:
		-- off, the card folds to its pill and line, with no dependency line.
		Polestar.Set("nav.upcomingPins", false)
		O.Select("mappins", L["Essentials"])
		local pinsCard
		for _, card in ipairs(O.view.cards) do
			if card:IsShown() and card.psName == L["Numbered pins"] then pinsCard = card end
		end
		local pinsLg = pinsCard and rawget(pinsCard, "Legend")
		local pins = { note = pinsCard and rawget(pinsCard, "OffNote") and pinsCard.OffNote:IsShown() or false,
			pill = pinsLg and pinsLg.Pill and pinsLg.Pill:IsShown() or false, line = lineFor("nav.upcomingPins") ~= nil }
		-- A section with no switch of its own (a card whose own header holds
		-- the switch folds while it is off, the line with it): Trackers ›
		-- Essentials' time format waits on the flight timer's switch.
		Polestar.Set("maps.flightTimer", false)
		O.Select("trackers", L["Essentials"])
		local line = lineFor("maps.flightTimer")
		local went, tab
		if line then
			line.onClick()
			went = O.frame.Title:GetText()
			tab = select(2, G.Current()).name
		end
		Polestar.Set("maps.flightTimer", true)
		O.Select("trackers", L["Essentials"])
		local still = false
		for c, w in pairs(O.view.cache) do if w:IsShown() and c == line then still = true end end
		emit({ own = own, line = line and line.button or false, went = went or false, tab = tab or false, still = still, pins = pins })`);
	assert.deepEqual(out.pins, { note: true, pill: true, line: false }, 'Numbered pins folds to its pill and line, no dependency line');
	assert.equal(out.own, false, "no line where the card's own header holds the switch");
	assert.equal(out.line, 'Look › Trackers', "the line's button names the switch's group and page");
	assert.equal(out.went, 'Look › Trackers', 'and goes there');
	assert.equal(out.tab, 'Travel', "on the switch's tab");
	assert.equal(out.still, false, 'with the switch on, the line is gone');
});

// #2541 (skez): the number beside a page read as a notification, or a setting
// that needed attention. Each mark on the sidebar says what it is when hovered:
// the count, settings changed from their default there; the ring, new settings.
test('the sidebar\'s count and ring say what they are when hovered (#2541)', () => {
	const [out] = run(`
		local G = O.Grouped
		PolestarDB.optionsLayout = "grouped"
		Polestar.Set("nav.arrowScale", 1.3)
		Polestar.UI.ShowOptions()
		O.Select("questing")
		local function row(key)
			for _, b in ipairs(PolestarOptions.navButtons) do if b:IsShown() and b.psKey == key then return b end end
		end
		-- What the row's tooltip says (W.SimpleTip shows psTip).
		local function hover(b) return b.psTip or false end
		local function itemOf(key)
			for _, it in ipairs(G.NavItems()) do if it.key == key then return it end end
		end
		-- A page with a change and one without (Questing: none changed here).
		local changed, plain
		for _, it in ipairs(G.NavItems()) do
			if it.indent and it.count and not changed then changed = it.key end
			if it.indent and not it.count and not it.new and not plain then plain = it.key end
		end
		emit({ changed = changed or false, count = changed and itemOf(changed).count or false, new = changed and itemOf(changed).new or false,
			changedTip = changed and hover(row(changed)) or false, plainTip = plain and hover(row(plain)) or false })`);
	assert.ok(out.changed, 'a page in the open group counts the changed arrow scale');
	const both = out.new ? '\nNew settings on this page' : '';
	assert.equal(out.changedTip, `Settings on this page changed from their default${both}`, `the count explains itself (${out.count}), and a ring beside it`);
	assert.equal(out.plainTip, false, 'a row with no mark has no tooltip');
});
