'use strict';
// The new settings page's Essentials tabs (addon/Polestar_Options/UI/
// Essentials.lua, drawn by UI/Grouped.lua): Guide, Questing, Quality of Life,
// Guide window and Alerts & toasts open on an Essentials tab, first in the
// bar with the star, holding the settings players reach for first as live
// references to their home rows, each with a muted link to its home tab. On
// Guide window and Alerts & toasts the page's Presets come first. The current
// page keeps its own tabs. Against the real addon's modules and the fakes of
// tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const ALL = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml',
	'QoL/QoL.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml', 'Alts/Alts.xml'];

// The picks of the settings review (docs/superpowers/specs/2026-11-17-settings-ia-review.md §5).
const PICKS = {
	guide: ['behavior.whileHere', 'nav.arrow', 'nav.travel', 'nav.routeLines', 'nav.routeStyle',
		'behavior.autoSelectGuide', 'behavior.guideEnd', 'behavior.routeChoice', 'behavior.skipGrey', 'behavior.dungeons'],
	questing: ['behavior.autoAccept', 'behavior.autoTurnin', 'qol.skipGossip', 'qol.rewardHighlight', 'qol.rewardAutoPick',
		'qol.rewardEquip', 'qol.itemButton', 'qol.targetButton', 'qol.questTooltips', 'party.show'],
	qualityoflife: ['qol.sellJunk', 'qol.autoRepair', 'qol.bagSpace', 'maps.flightTimer', 'qol.flightAutoOpen',
		'qol.xpTracker', 'qol.deathHelper', 'qol.acceptSummon', 'qol.declineDuels'],
	guidewindow: ['ui.scale', 'ui.width', 'guideWindow.bgOpacity', 'ui.combat', 'ui.instance', 'ui.upcoming',
		'ui.showNotes', 'ui.guideTextSize', 'ui.compact', 'ui.locked'],
	alerts: ['rares.alerts', 'rares.treasureAlerts', 'nav.alerts', 'nav.alertBanner', 'dungeons.headsUp',
		'toasts.stack', 'toasts.headsup.place', 'rares.soundKit', 'nav.alertSound', 'ui.classCardSound'],
};

// Picks registered with their module's data (left out until it loads).
const OPTIONAL = { guide: ['behavior.dungeons'] };

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
			local K = O.Kit
			local W = Polestar.Widgets
			local L = Polestar.L
			-- The folder tabs on screen: their labels and icons.
			local function bar()
				local out = { labels = {}, icons = {} }
				local f = rawget(O.frame, "FolderTabs")
				for _, b in ipairs(f and f:IsShown() and f.buttons or {}) do
					if b:IsShown() then
						out.labels[#out.labels + 1] = b.psTip
						out.icons[#out.icons + 1] = b.psIcon
					end
				end
				return out
			end
			-- The row of the Essentials tab on screen holding setting key.
			local function essentialsRow(key)
				local _, t = G.Current()
				for _, sec in ipairs(t.sections) do
					for _, c in ipairs(sec.controls) do
						if c.key == key and rawget(c, "ref") then return O.view.cache[c], c end
					end
				end
			end
			${script}`,
	}).emitted;
}

test('the five pages open on Essentials, the review\'s picks, each a registered setting', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		local pages = {}
		for page, keys in pairs(G.ESSENTIALS) do
			O.Select(page)
			local p, t = G.Current()
			local b = bar()
			-- A group of one page (Quality of Life) shows its tabs as sidebar rows, no folder tabs.
			if #b.labels == 0 then
				for _, it in ipairs(G.NavItems()) do
					if it.indent and it.key:sub(1, 2) == "t:" then b.labels[#b.labels + 1] = it.label end
				end
				b.icons[1] = G.TabIcon(p, G.Tabs(p)[1])
			end
			local unregistered, unavailable = {}, {}
			for _, key in ipairs(keys) do
				local home = O.HomeControl(key)
				if not home then
					unregistered[#unregistered + 1] = key
				elseif not K.available(home) then
					unavailable[#unavailable + 1] = key
				end
			end
			local rows, sections = {}, {}
			for _, sec in ipairs(t.sections) do
				sections[#sections + 1] = sec.name
				for _, c in ipairs(sec.name == L["Most used"] and sec.controls or {}) do
					if rawget(c, "ref") and rawget(c, "essentials") and K.available(c) then rows[#rows + 1] = c.key end
				end
			end
			local inTabs = false
			for _, pt in ipairs(p.tabs) do if pt == t then inTabs = true end end
			local essentialsTabs = 0
			for _, l in ipairs(b.labels) do if l == L["Essentials"] then essentialsTabs = essentialsTabs + 1 end end
			pages[page] = { opened = t.name, firstTab = b.labels[1], icon = b.icons[1], rows = rows, sections = sections,
				unregistered = unregistered, unavailable = unavailable, keys = keys, inTabs = inTabs, essentialsTabs = essentialsTabs,
				preview = G.HasPreview(p) and G._side():IsShown() or false }
		end
		emit({ pages = pages })`);
	assert.deepEqual(Object.keys(out.pages).sort(), Object.keys(PICKS).sort());
	for (const [page, e] of Object.entries(out.pages)) {
		assert.deepEqual(Object.values(e.unregistered), [], `${page}: every pick is a registered setting`);
		assert.deepEqual(e.keys, PICKS[page], `${page}: the review's picks`);
		// Shown while its module has it to set: the dungeons' choice needs leveling guides with dungeons.
		const optional = OPTIONAL[page] || [];
		const unavailable = Object.values(e.unavailable);
		for (const k of unavailable) assert.ok(optional.includes(k), `${page}: ${k} is unavailable and not an optional pick`);
		assert.deepEqual(e.rows, PICKS[page].filter((k) => !unavailable.includes(k)), `${page}: a row for each pick, in order`);
		assert.ok(e.rows.length >= 6 && e.rows.length <= 10, `${page}: ${e.rows.length}`);
		assert.equal(e.firstTab, 'Essentials', page);
		assert.equal(e.opened, 'Essentials', page);
		assert.equal(e.icon, 'emblem', `${page}: the emblem's star`);
		assert.equal(e.essentialsTabs, 1, `${page}: one Essentials tab`);
		assert.equal(e.inTabs, false, `${page}: the tab is not one of the page's registered tabs (counted once)`);
	}
	for (const page of ['guidewindow', 'alerts']) {
		assert.equal(out.pages[page].sections[0], 'Presets', `${page}: Presets first`);
	}
	assert.equal(out.pages.guidewindow.preview, true, 'the guide window\'s Essentials keeps its preview');
});

test('an Essentials row is a live reference to its home row, with a muted tab name that links home', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("guidewindow")
		local row = essentialsRow("ui.scale")
		row.Slider.value = 1.3
		stub.RunScript(row.Slider, "OnValueChanged", 1.3, true)
		stub.RunScript(row.Slider, "OnMouseUp")
		local value = Polestar.Get("ui.scale")
		local link = rawget(row, "psAfter")
		local tabLink = link and link.Label:GetText()
		local r, g, b = Polestar.Theme.Color("textMuted")
		local lr, lg, lb = 0, 0, 0
		if link then lr, lg, lb = link.Label:GetTextColor() end
		local muted = math.abs(lr - r) < 0.01 and math.abs(lg - g) < 0.01 and math.abs(lb - b) < 0.01
		-- Changed once in the Changed view's count, not twice.
		local count
		for _, e in ipairs(G.ChangedPages()) do if e.page.key == "guidewindow" then count = e.count end end
		stub.RunScript(link, "OnClick")
		local p, t = G.Current()
		local crumb = table.concat({ G.Crumb() }, " > ")
		local home = O.view.cache[O.HomeControl("ui.scale")]
		-- A home on another page names the page too (a pick of the guide window's on Questing).
		table.insert(G.ESSENTIALS.questing, "ui.scale")
		G.Invalidate()
		O.Select("questing")
		local other = rawget(essentialsRow("ui.scale"), "psAfter")
		other = other and other.Label:GetText()
		table.remove(G.ESSENTIALS.questing)
		G.Invalidate()
		emit({ value = value, tabLink = tabLink, muted = muted, page = p.key, tab = t.name, crumb = crumb,
			homeValue = home and home.Slider:GetValue(), count = count, other = other })`);
	assert.equal(out.value, 1.3, 'set through the Essentials row');
	assert.equal(out.homeValue, 1.3, 'read at home');
	assert.equal(out.tabLink, 'Window');
	assert.equal(out.muted, true, 'the tab name in textMuted');
	assert.equal(out.count, 1, 'counted once');
	assert.equal(out.page, 'guidewindow');
	assert.equal(out.tab, 'Window');
	assert.equal(out.crumb, 'Look > Guide window');
	assert.equal(out.other, 'Guide window \u203a Window', 'a home on another page: "Page › Tab"');
});

// Every setting that adds a line to a game tooltip, from wherever its home is.
const TOOLTIPS = ['qol.questTooltips', 'gear.tooltip', 'gear.pickTooltip', 'lookup.tooltip', 'lookup.mounts',
	'talents.tooltip', 'qol.itemMarks'];

test('Quality of Life\'s Essentials gathers the tooltip settings in a Tooltips card after Most used', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("qualityoflife")
		local _, t = G.Current()
		local sections, rows, links = {}, {}, {}
		for _, sec in ipairs(t.sections) do
			sections[#sections + 1] = sec.name
			if sec.name == L["Tooltips"] then
				for _, c in ipairs(sec.controls) do
					if rawget(c, "ref") and rawget(c, "essentials") then rows[#rows + 1] = c.key end
				end
			end
		end
		local row = essentialsRow("gear.tooltip")
		local link = row and rawget(row, "psAfter")
		-- Set through the card, read at home.
		local before = Polestar.Get("lookup.tooltip")
		local mark = essentialsRow("lookup.tooltip")
		if mark then stub.RunScript(mark, "OnClick") end
		local soon = Polestar.Talents and Polestar.Talents.SOON or not Polestar.Talents
		emit({ sections = sections, rows = rows, link = link and link.Label:GetText(),
			flipped = Polestar.Get("lookup.tooltip") ~= before, soon = soon })`);
	const most = out.sections.indexOf('Most used');
	assert.ok(most >= 0, out.sections.join(', '));
	assert.equal(out.sections[most + 1], 'Tooltips', 'the Tooltips card right after Most used');
	// Talent plans are coming soon (Talents.lua, T.SOON): no setting, no row, until they are there.
	const expected = out.soon ? TOOLTIPS.filter((k) => k !== 'talents.tooltip') : TOOLTIPS;
	assert.deepEqual(out.rows, expected, 'a reference for each tooltip setting registered, in order');
	assert.equal(out.link, 'Questing \u203a Rewards & gear', 'each row names its home');
	assert.equal(out.flipped, true, 'the card\'s row sets the setting itself');
});

test('an Essentials row keeps the whole column for its label, the path to its home on a line under it', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("qualityoflife")
		local function look(key)
			local row = essentialsRow(key)
			local link = rawget(row, "psAfter")
			local label = row.Label
			local _, rel, relPoint = link:GetPoint(1)
			return { whole = label:GetWidth() + 0.5 >= W.TextWidth(label), under = rel == label and relPoint == "BOTTOMLEFT",
				tall = row:GetHeight() >= math.ceil(label:GetStringHeight() + link.Label:GetStringHeight()) }
		end
		emit({ long = look("lookup.tooltip"), gear = look("gear.pickTooltip"), short = look("qol.sellJunk") })`);
	for (const k of ['long', 'gear', 'short']) {
		assert.equal(out[k].whole, true, `${k}: the whole label`);
		assert.equal(out[k].under, true, `${k}: the path under the label`);
		assert.equal(out[k].tall, true, `${k}: the row holds both lines`);
	}
});

test('Quality of Life has a Tooltips row in the sidebar: every tooltip setting, each linking home', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("qualityoflife")
		local rows = {}
		for _, it in ipairs(G.NavItems()) do
			if it.indent and it.key:sub(1, 2) == "t:" and it.key:find("^t:qualityoflife") then rows[#rows + 1] = it.label end
		end
		O.Select("qualityoflife", L["Tooltips"])
		local _, t = G.Current()
		local cards, links, children = {}, {}, {}
		for _, sec in ipairs(t.sections) do
			local keys = {}
			for _, c in ipairs(sec.controls) do
				if K.available(c) then
					keys[#keys + 1] = c.key
					local row = O.view.cache[c]
					local link = row and rawget(row, "psAfter")
					links[c.key] = link and link:IsShown() and link.Label:GetText() or false
					if rawget(c, "child") then children[#children + 1] = c.key end
				end
			end
			if #keys > 0 then cards[#cards + 1] = { name = sec.name, keys = keys } end
		end
		emit({ rows = rows, tab = t.name, cards = cards, links = links, children = children })`);
	const at = out.rows.indexOf('Tooltips');
	assert.ok(at > 0, out.rows.join(', '));
	assert.equal(out.rows[at - 1], 'Quests', 'Tooltips right after Quests');
	assert.equal(out.tab, 'Tooltips');
	assert.deepEqual(out.cards, [
		{ name: 'Quests', keys: ['qol.questTooltips', 'qol.questDropChance', 'qol.questTooltipsNpc', 'qol.questTooltipsReplace'] },
		// Mounts (and the talent plan once it is out) share Items: a section of one row breaks the layout rules.
		{ name: 'Items', keys: ['gear.tooltip', 'gear.pickTooltip', 'lookup.tooltip', 'qol.itemMarks', 'lookup.mounts'] },
	]);
	assert.deepEqual(out.children, ['qol.questDropChance', 'qol.questTooltipsNpc', 'qol.questTooltipsReplace'], 'the quest options under Quest tooltips');
	assert.equal(out.links['qol.questTooltips'], 'Questing \u203a Quests');
	assert.equal(out.links['gear.tooltip'], 'Questing \u203a Rewards & gear');
	assert.equal(out.links['qol.itemMarks'], 'Vendors');
});

test('pointing at a Tooltips row shows a sample game tooltip with the line it adds, live as it is switched', () => {
	const [out] = run(`
		-- A tooltip frame as the client's GameTooltipTemplate makes it (the stub's GameTooltip's methods).
		PolestarSampleTooltip = CreateFrame("GameTooltip", "PolestarSampleTooltip", UIParent)
		for _, m in ipairs({ "SetOwner", "ClearLines", "AddLine", "AddDoubleLine", "SetText", "GetOwner" }) do
			PolestarSampleTooltip[m] = GameTooltip[m]
		end
		Polestar.UI.ShowOptions()
		O.Select("qualityoflife", L["Tooltips"])
		local tip = PolestarSampleTooltip
		local row = O.view.cache[(function()
			local _, t = G.Current()
			for _, sec in ipairs(t.sections) do
				for _, c in ipairs(sec.controls) do if c.key == "lookup.tooltip" then return c end end
			end
		end)()]
		stub.RunScript(row, "OnEnter")
		local on = { shown = tip:IsShown(), owner = tip:GetOwner() == row, lines = tip.lines }
		Polestar.Set("lookup.tooltip", false)
		local off = { lines = tip.lines }
		stub.RunScript(row, "OnLeave")
		emit({ on = on, off = off, hidden = not tip:IsShown() })`);
	assert.equal(out.on.shown, true, 'the sample shows');
	assert.equal(out.on.owner, true, 'beside the row');
	const line = out.on.lines.find((l) => l.startsWith('From '));
	assert.ok(line, `the line the setting adds: ${out.on.lines.join(' / ')}`);
	assert.equal(out.on.lines.at(-1), 'Preview');
	const offLine = out.off.lines.find((l) => l.startsWith('From '));
	assert.ok(offLine, 'still there, switched off');
	assert.equal(out.off.lines.at(-1), 'Off', 'says it is off');
	assert.equal(out.hidden, true, 'hidden as the pointer leaves');
});

test('LB / RB step on from Essentials after the tab is built again', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("questing")
		local _, before = G.Current()
		G.Invalidate()
		G.StepTab(1)
		local p, t = G.Current()
		emit({ before = before.name, page = p.key, tab = t.name })`);
	assert.equal(out.before, 'Essentials');
	assert.equal(out.page, 'questing');
	assert.equal(out.tab, 'Quests', 'the next tab after Essentials, not the first page');
});

test('the page opens on the tab the player picked last', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("questing", "Rewards & gear")
		O.Select("guide")
		O.Select("questing")
		local _, t = G.Current()
		emit({ tab = t.name })`);
	assert.equal(out.tab, 'Rewards & gear');
});

test('the current page shows no Essentials tab on Questing, and keeps its own Essentials sets', () => {
	const [out] = run(`
		Polestar.UI.ShowOptions()
		O.Select("questing")
		local tabs = {}
		for _, t in ipairs(K.shownTabs(K.pageByKey("questing"))) do tabs[#tabs + 1] = t.name end
		local function keysOf(page)
			O.Select(page, L["Essentials"])
			local _, t = K.current()
			local out = {}
			for _, sec in ipairs(t.sections) do
				for _, c in ipairs(sec.controls) do if c.key then out[#out + 1] = c.key end end
			end
			return out
		end
		emit({ classicTabs = tabs, folder = rawget(O.frame, "FolderTabs") ~= nil and O.frame.FolderTabs:IsShown(),
			guidewindow = keysOf("guidewindow"), alerts = keysOf("alerts"), essentials = G.EssentialsTab(K.pageByKey("questing")) ~= nil })`,
	'PolestarDB = { settings = {} }');
	assert.equal(out.classicTabs.includes('Essentials'), false);
	assert.equal(out.essentials, false, 'no Essentials tab while the new page is off');
	assert.ok(out.guidewindow.includes('guideWindow.idleAlpha'), 'the current guide window set as it was');
	assert.ok(out.alerts.includes('toasts.stack'), 'the current alerts set, with All alerts\' line');
});
