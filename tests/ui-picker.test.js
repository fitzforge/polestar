'use strict';
// The guide menu (addon/Polestar/UI/Picker.lua): three panes in the Polestar
// shell, against the fake Engine and sample guides of tests/lua/stub_ui.lua.
// Rows mark a finished guide with a check and an open one with a muted
// "Tab N" note; the tab row always has an active tab (Browse for a category
// or a search); the details end in a facts block.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function run(script, { install = '' } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install(${install})\nstub.login()\nlocal UI, P = Polestar.UI, Polestar.UI.Picker\n${HELPERS}\n${script}`,
	}).emitted;
}

const HELPERS = `
local function kinds(entries)
	local out = {}
	for _, e in ipairs(entries) do
		out[#out + 1] = e.kind == "guide" and e.guide.title or ("[" .. e.text .. " " .. e.count .. "]")
	end
	return out
end
local function rows()
	local out = {}
	for _, f in ipairs(stub.frames) do
		if f.psGuide and rawget(f, "Range") and f:IsShown() and f:GetParent() == PolestarPicker.Scroll.Child then out[#out + 1] = f end
	end
	table.sort(out, function(a, b) return select(5, a:GetPoint(1)) > select(5, b:GetPoint(1)) end)
	return out
end
local function lines()
	local out = {}
	for _, r in ipairs(rows()) do
		local mark = r.Check:IsShown() and "\\226\\156\\147 " or ""
		local note = r.Note:GetText() ~= "" and (" | " .. r.Note:GetText()) or ""
		out[#out + 1] = mark .. r.Title:GetText() .. " " .. r.Range:GetText() .. note
	end
	return out
end
local function folders()
	local out = {}
	for _, f in ipairs(stub.frames) do
		if rawget(f, "Count") and rawget(f, "Rule") and not rawget(f, "Range") and f:IsShown() and f:GetParent() == PolestarPicker.Scroll.Child then out[#out + 1] = f end
	end
	table.sort(out, function(a, b) return select(5, a:GetPoint(1)) > select(5, b:GetPoint(1)) end)
	for i, f in ipairs(out) do out[i] = f.Text:GetText() .. " " .. f.Count:GetText() end
	return out
end
local function rowFor(title)
	for _, r in ipairs(rows()) do if r.psGuide.title == title then return r end end
end
local function lastCall(name)
	for i = #uistub.calls, 1, -1 do if uistub.calls[i][1] == name then return uistub.calls[i] end end
end
local function tab(key)
	for _, t in ipairs(PolestarPicker.tabButtons) do if t.psKey == key and t:IsShown() then return t end end
end
local function nav(key)
	for _, b in ipairs(PolestarPicker.navButtons) do if b.psKey == key and b:IsShown() then return b end end
end
local D = function() return P.details end
local TABS = { { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }
-- Guides past level 30, to show the bands; the two from 40-50 share a
-- minimum level (43), so the id decides their order, and are added out of it.
local function addBand(id, title, faction, lo, hi)
	uistub.guides[id] = { id = id, title = title, faction = faction, minLevel = lo, maxLevel = hi, category = "Leveling", zone = 0, zoneName = title,
		steps = { { title = "One", goals = { { t = "note", text = "One", status = "pending" } } } } }
	table.insert(uistub.order, id)
end
addBand("forever/horde/30-40/01-desolace", "Desolace & Hillsbrad Foothills", "Horde", 30, 33)
addBand("forever/alliance/30-40/02-desolace", "Desolace", "Alliance", 31, 34)
addBand("forever/alliance/40-50/03-feralas", "Feralas", "Alliance", 43, 46)
addBand("forever/alliance/40-50/02-badlands", "Badlands & The Hinterlands", "Alliance", 43, 44)
local westfall = uistub.guides["forever/alliance/02-westfall"]
westfall.pitch, westfall.pros, westfall.cons = "Farms and bandits.", { "Compact", "Flight path" }, { "Long walks" }
`;

test('browse: folders by faction and band, then by category; faction filter and band derivation', () => {
	const [out] = run(`
		local alliance = kinds(P.Entries("Alliance", "", "Leveling"))
		local horde = kinds(P.Entries("Horde", ""))
		local all = kinds(P.Entries("All", "", "Leveling"))
		uistub.player.race, uistub.player.faction = "Scourge", "Horde"
		emit({ alliance = alliance, all = all, horde = horde, undeadHorde = kinds(P.Entries("Horde", "", "Leveling")),
			bands = { { P.Band({ id = "forever/horde/30-40/01-desolace", minLevel = 12 }) }, { P.Band({ id = "a/b", minLevel = 44 }) }, { P.Band({ id = "a/b", minLevel = 29 }) } } })`);
	// Within a folder: faction, then minimum level, then id. On the player's own
	// faction, a Human sees no other race's start (Dun Morogh, Teldrassil, Zephras Isle).
	assert.deepEqual(out.alliance, [
		'[Alliance 1\u201330 3]', 'Elwynn Forest', 'Westfall', 'Darkshore',
		'[Alliance 30\u201340 1]', 'Desolace',
		'[Alliance 40\u201350 2]', 'Badlands & The Hinterlands', 'Feralas',
	]);
	// The player's faction first; every faction and every race's guides when all are listed.
	assert.deepEqual(out.all.filter((k) => k.startsWith('[')), ['[Alliance 1\u201330 6]', '[Alliance 30\u201340 1]', '[Alliance 40\u201350 2]', '[Horde 1\u201330 3]', '[Horde 30\u201340 1]']);
	// The other faction lists all of its guides, races included.
	assert.deepEqual(out.horde.filter((k) => k.startsWith('[')), ['[Horde 1\u201330 3]', '[Horde 30\u201340 1]', '[Professions 3]', '[Reputation 1]', '[Exploration 1]', '[Legacy 1]']);
	assert.ok(out.horde.includes('Durotar'));
	assert.ok(out.horde.includes('Orgrimmar Reputation') && !out.horde.includes('Stormwind Reputation'));
	// An Undead on the Horde list: the Orc and Troll start is left out, the shared guides stay.
	assert.ok(!out.undeadHorde.includes('Durotar') && out.undeadHorde.includes('The Barrens'));
	assert.deepEqual(out.bands, [[30, 40], [40, 50], [1, 30]]);
});

test('search covers titles, zones, categories and player-facing race names; typing selects the first result', () => {
	const [out] = run(`
		UI.ShowPicker()
		local function guides(q, cat)
			local t = {}
			for _, e in ipairs(P.Entries("All", q, cat)) do if e.kind == "guide" then t[#t + 1] = e.guide.title end end
			return t
		end
		P.SetView("current")
		P.SetQuery("elwynn")
		local r = { view = P.View(), shown = lines(), selected = P.Selected(), title = PolestarPicker.Title:GetText(),
			subtitle = PolestarPicker.Subtitle:GetText(), browseOn = tab("browse").psSelected }
		emit({ r = r, multi = guides("elwynn riding"), reputation = guides("reputation"), upper = guides("PROFESSIONS"),
			undead = guides("undead"), nightelf = guides("night elf"), profInLeveling = #guides("tailoring", "Leveling") })`);
	assert.deepEqual(out.multi, ['Horse'], 'every word must match: the zone and a keyword');
	assert.deepEqual(out.reputation, ['Stormwind Reputation', 'Orgrimmar Reputation']);
	assert.deepEqual(out.upper, ['Cooking 1-300', 'First Aid 1-300', 'Tailoring 1-300']);
	assert.deepEqual(out.undead, ['Tirisfal Glades'], '"Scourge" is found as Undead');
	assert.deepEqual(out.nightelf, ['Teldrassil']);
	assert.equal(out.profInLeveling, 0);
	assert.deepEqual(out.r, {
		view: 'browse', shown: ['Elwynn Forest (1\u201313)', 'Horse (40\u201360)'], selected: 'forever/alliance/human/01-elwynn-forest', title: 'Search',
		subtitle: '2 results for \u201celwynn\u201d', browseOn: true,
	});
});

test('left pane: the rail holds the sections and Options; the sidebar holds the categories in order, Favourites last', () => {
	const [out] = run(`
		UI.ShowPicker()
		local labels, rail = {}, {}
		for _, b in ipairs(PolestarPicker.navButtons) do
			if b:IsShown() then labels[#labels + 1] = b.Label:GetText() .. " " .. b.Count:GetText() end
		end
		for _, b in ipairs(PolestarPicker.railButtons) do
			if b:IsShown() then rail[#rail + 1] = b.Label:GetText() .. (b.Bar:IsShown() and "*" or "") end
		end
		local icon = nav("Favorites").Icon:GetTexture()
		nav("Professions"):Click()
		local r = { view = P.View(), category = P.Category(), title = PolestarPicker.Title:GetText(), folders = folders(), lines = lines(),
			navOn = nav("Professions").Bar:IsShown(), tabOn = tab("home").psSelected or false, browseOn = tab("browse").psSelected,
			tabs = {}, footer = PolestarPicker.Footer:IsShown(), subtitle = PolestarPicker.Subtitle:GetText() }
		for _, t in ipairs(PolestarPicker.tabButtons) do if t:IsShown() then r.tabs[#r.tabs + 1] = t.Label:GetText() end end
		tab("home"):Click()
		r.home = { view = P.View(), homeOn = tab("home").psSelected }
		tab("browse"):Click()
		r.back = { view = P.View(), category = P.Category(), browseOn = tab("browse").psSelected }
		for _, b in ipairs(PolestarPicker.railButtons) do if b:IsShown() and b.psKey == "Options" then b:Click() end end
		local sections = {}
		for i, s in ipairs(P.Sections()) do sections[i] = s.label or s.key end
		emit({ cats = P.categories, labels = labels, rail = rail, sections = sections, icon = icon, r = r, options = PolestarOptions:IsShown(), picker = PolestarPicker:IsShown() })`);
	assert.deepEqual(out.cats, ['All', 'Leveling', 'Professions', 'Reputation', 'Exploration', 'Legacy', 'Collectibles', 'Favorites'], 'dungeons have their own section, not a category');
	// Sections (Home first, Guides built in, then the registered ones by order) are on the rail, Options at its foot.
	assert.equal(out.sections[0], 'Home');
	assert.equal(out.sections[1], 'Guides');
	assert.equal(out.sections[2], 'Lookup');
	// Import is a foot section: above Options, not among the sections at the top.
	assert.deepEqual(out.rail, ['Options', 'Import', 'Home', 'Guides*', ...out.sections.slice(2).filter((s) => s !== 'Import')]);
	assert.deepEqual(out.labels, ['All guides 13', 'Leveling 6', 'Professions 3', 'Reputation 1', 'Exploration 1', 'Legacy 1', 'Collectibles 1', 'Favourites 0']);
	assert.match(out.icon, /\\star$/);
	assert.deepEqual(out.r, {
		view: 'browse', category: 'Professions', title: 'Professions', folders: ['Professions 3'],
		lines: ['Cooking 1-300 (5\u201360)', 'First Aid 1-300 (5\u201360)', 'Tailoring 1-300 (5\u201360)'], navOn: true, tabOn: false, browseOn: true,
		tabs: ['Guides', 'Browse', 'Current', 'Recent'], footer: false, subtitle: 'Alliance  \u00b7  3 guides',
		home: { view: 'home', homeOn: true }, back: { view: 'browse', category: 'Professions', browseOn: true },
	});
	assert.equal(out.options, true);
	assert.equal(out.picker, false);
});

test('the sidebar is one compact block on one edge: the lockup (wordmark, tagline under it), the search with its foot on the band line, navigation 12px under that; the version on the rail\'s foot line', () => {
	const [out] = run(`
		UI.ShowPicker()
		local F = PolestarPicker
		local function pt(r, i) local p, _, _, x, y = r:GetPoint(i or 1); return { p, x, y } end
		local opt
		for _, b in ipairs(F.railButtons) do if b:IsShown() and b.psKey == "Options" then opt = b end end
		local _, _, _, _, optY = opt:GetPoint(1)
		local _, _, _, _, labelY = opt.Label:GetPoint(1)
		local _, _, _, _, iconY = opt.Icon:GetPoint(1)
		local navFirst = F.navButtons[1]
		emit({ wordmark = pt(F.Wordmark), tagline = pt(F.Tagline), search = pt(F.Search), navTop = F.psNavTop, navX = select(4, navFirst.Icon:GetPoint(1)),
			status = pt(F.Status), optLabelBottom = optY + opt:GetHeight() + iconY - opt.Icon:GetHeight() + labelY - opt.Label:GetStringHeight(),
			emblem = pt(F.Emblem), firstRail = (function() for _, b in ipairs(F.railButtons) do if b:IsShown() and b.psKey == "Home" then local _, _, _, _, y = b:GetPoint(1); return -y end end end)() })`);
	const edge = 24;
	assert.deepEqual(out.wordmark, ['TOPLEFT', edge - 2, -22], 'the wordmark\'s ink (2px into its box) sits on the sidebar edge');
	assert.deepEqual(out.tagline, ['TOPLEFT', edge, -52], 'the tagline under the wordmark, on the same edge');
	assert.deepEqual(out.search, ['TOPLEFT', edge, -(112 - 30)], 'the search ends on the header band\'s 112 line');
	assert.equal(out.navTop, 112 + 12, 'navigation 12px under the search');
	assert.equal(out.navX, edge, 'navigation icons on the same edge');
	assert.deepEqual(out.status, ['BOTTOMLEFT', edge, 23]);
	assert.equal(out.optLabelBottom, 23, 'the version shares the line of the rail\'s Options label');
	assert.equal(out.firstRail, out.navTop, 'the first section sits level with the first category');
	assert.deepEqual(out.emblem, ['TOP', 0, -(47 - 18)], 'the emblem centred on the title line, like the lockup beside it');
});

test('the search placeholder is the first wording that fits the box, refitted on resize; the last is cut when none fits', () => {
	const [out] = run(`
		UI.ShowPicker()
		local box = PolestarPicker.Search
		local ph = box.Placeholder
		local function at(w)
			box:SetWidth(w)
			stub.RunScript(box, "OnSizeChanged", w, 30)
			return { ph:GetText(), ph:GetStringWidth() <= w - 40 }
		end
		emit({ wide = at(400), mid = at(185), narrow = at(60) })`);
	// The stub measures 6px a character at the label's size (12); the
	// placeholder has the box's width less 40px (its left inset and padding).
	assert.deepEqual(out.wide, ['Search guides, items, NPCs', true]);
	assert.deepEqual(out.mid, ['Search guides, items', true], 'the full wording (156px) would overflow 145px: the shorter one shows');
	assert.deepEqual(out.narrow, ['Search', true], 'the last wording, cut to the box when even it is too long');
});

test('the hub fits: every section on the rail above the foot (Import, Options), every category in the sidebar above the status line', () => {
	const [out] = run(`
		-- Fill the rail to seven sections above its foot of two (Import,
		-- Options): the docs/SUITE.md ones (Guides, Lookup, Dungeons, Rares)
		-- and stand-ins for more.
		local i = 0
		while #P.RailItems() < 7 do
			i = i + 1
			local key = i == 1 and "Rares" or ("Extra" .. i)
			UI.RegisterSection({ key = key, label = key, icon = "compact", order = 50 + i,
				build = function(parent) end, render = function() end,
				nav = function() return { { key = "a", label = "A" }, { key = "b", label = "B" } }, "a" end })
		end
		local all = {}
		for k, s in ipairs(P.RailItems()) do all[k] = s.key end
		UI.ShowPicker()
		P.SetCategory("All")
		local H = PolestarPicker:GetHeight()
		local function bottomOf(b) local _, _, _, _, y = b:GetPoint(1); return -y + b:GetHeight() end
		local function topOfFoot(b) local _, _, _, _, y = b:GetPoint(1); return H - 2 - (y + b:GetHeight()) end
		local foot = {}
		for _, item in ipairs(P.FootItems()) do foot[item.key] = true end
		local railBottom, options, keys = 0, nil, {}
		for _, b in ipairs(PolestarPicker.railButtons) do
			if b:IsShown() then
				if foot[b.psKey] then options = math.min(options or math.huge, topOfFoot(b)) else
					railBottom = math.max(railBottom, bottomOf(b))
					keys[#keys + 1] = b.psKey
				end
			end
		end
		local navBottom, navTop = 0, PolestarPicker.psNavTop
		for _, b in ipairs(PolestarPicker.navButtons) do
			if b:IsShown() then local _, _, _, _, y = b:GetPoint(1); navBottom = math.max(navBottom, navTop - y + b:GetHeight()) end
		end
		local _, _, _, _, statusY = PolestarPicker.Status:GetPoint(1)
		P.ShowSection("Rares")
		local sectionNav = {}
		for _, b in ipairs(PolestarPicker.navButtons) do if b:IsShown() then sectionNav[#sectionNav + 1] = b.psKey end end
		emit({ keys = keys, all = all, railBottom = railBottom, options = options, navBottom = navBottom, statusTop = H - 2 - statusY - 14,
			sectionNav = sectionNav, railOn = (function() for _, b in ipairs(PolestarPicker.railButtons) do if b:IsShown() and b.Bar:IsShown() then return b.psKey end end end)(),
			details = P.details:IsShown(), list = PolestarPicker.Content:IsShown() })`);
	assert.equal(out.all.length, 7);
	assert.deepEqual(out.keys, out.all, 'seven sections fit the rail above its foot of two');
	assert.ok(out.railBottom <= out.options, `rail ends at ${out.railBottom}, Options starts at ${out.options}`);
	assert.ok(out.navBottom <= out.statusTop, `categories end at ${out.navBottom}, the status line starts at ${out.statusTop}`);
	assert.deepEqual(out.sectionNav, ['a', 'b'], 'a section\'s own index replaces the categories');
	assert.equal(out.railOn, 'Rares');
	assert.equal(out.details, false);
	assert.equal(out.list, false);
});

test('categories: left out without a guide for any faction; faded with a tip when empty only for this faction', () => {
	const [out] = run(`
		-- No Legacy guide at all; the only collectible (Horse) is Alliance only.
		for i = #uistub.order, 1, -1 do
			local g = uistub.guides[uistub.order[i]]
			if g and g.category == "Legacy" then table.remove(uistub.order, i) end
		end
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.pickerFaction", "Horde")
		UI.ShowPicker()
		P.SetCategory("All")
		local collectibles = nav("Collectibles")
		emit({ cats = P.categories, legacy = nav("Legacy") ~= nil, collectibles = { collectibles.psTip, collectibles:GetAlpha(), collectibles.Count:IsShown() },
			leveling = nav("Leveling").psTip or false })`);
	assert.deepEqual(out.cats, ['All', 'Leveling', 'Professions', 'Reputation', 'Exploration', 'Collectibles', 'Favorites']);
	assert.equal(out.legacy, false);
	assert.deepEqual(out.collectibles, ['None for Horde; switch the filter to All.', 0.55, false]);
	assert.equal(out.leveling, false);
});

test('selecting a guide shows its details and loads nothing; the selection is remembered', () => {
	const [out] = run(`
		uistub.openTabs(TABS, 1)
		UI.ShowPicker()
		P.SetCategory("Leveling")
		local before = #uistub.calls
		rowFor("Westfall"):Click()
		local d = D()
		local chips = {}
		for _, c in ipairs(d.Chips) do if c:IsShown() then chips[#chips + 1] = c.Text:GetText() end end
		local pros = {}
		for _, b in ipairs(d.Pros) do if b.Text:IsShown() then pros[#pros + 1] = b.Text:GetText() end end
		local r = { title = d.Title:GetText(), eyebrow = rawget(d, "Category") ~= nil, track = d.Prog:IsShown(), chips = chips, facts = P.detail.facts,
			progress = d.ProgLabel:GetText(), pitch = d.Pitch:GetText(), pros = pros, cons = d.Cons[1].Text:GetText(),
			load = d.Load.Label:GetText(), newTab = d.NewTab:IsShown() and d.NewTab:IsEnabled(), selectedRow = rowFor("Westfall").Selected:IsShown(),
			calls = #uistub.calls - before, open = PolestarPicker:IsShown(), tip = rowFor("Westfall").psTip }
		-- A route choice next.
		westfall.nextChoices = { "forever/alliance/30-40/02-desolace", "forever/alliance/40-50/03-feralas" }
		P.Render()
		r.choice = P.detail.facts[#P.detail.facts]
		westfall.nextChoices = nil
		-- An open guide: its tab and step; Continue alone at full width.
		rowFor("Elwynn Forest"):Click()
		r.open1 = { progress = d.ProgLabel:GetText(), pct = d.ProgPct:GetText(), track = d.Prog:IsShown(), load = d.Load.Label:GetText(), newTab = d.NewTab:IsShown(),
			loadWidth = d.Load.psFixedWidth, facts = P.detail.facts }
		PolestarPicker:Hide()
		r.saved = Polestar.CharState().ui.pickerSelected
		UI.ShowPicker()
		r.again = d.Title:GetText()
		emit(r)`);
	assert.deepEqual(out, {
		title: 'Westfall', eyebrow: false, track: false, chips: ['Levels 12\u201317', 'Alliance'], facts: [['Steps', '17'], ['Zones', 'Westfall'], ['Next', 'Darkshore (16\u201321)']], progress: 'Not started',
		pitch: 'Farms and bandits.', pros: ['Compact', 'Flight path'], cons: 'Long walks', load: 'Load guide', newTab: true, selectedRow: true,
		calls: 0, open: true, tip: 'Double-click a guide or press Enter to load it.',
		choice: ['Next', 'Your choice: Desolace or Feralas'],
		open1: {
			progress: 'Open in tab 1  \u00b7  step 3 of 8', pct: '29%', track: true, load: 'Continue', newTab: false, loadWidth: 324,
			facts: [['Steps', '8'], ['Quests', '4'], ['Zones', 'Elwynn Forest'], ['Next', 'Westfall (12\u201317)']],
		},
		saved: 'forever/alliance/human/01-elwynn-forest', again: 'Elwynn Forest',
	});
});

test('a Class guide\'s details lead with its reward (item and spell icons, quality colour, the game\'s tooltip on hover) and why', () => {
	const out = run(`
		local id = "forever/class/warlock/test"
		uistub.guides[id] = { id = id, pack = "guides", title = "An Imp's Request", category = "Class", folder = "Warlock", minLevel = 50, maxLevel = 54,
			zone = 1429, zoneName = "Felwood",
			reward = { { spell = 23161, spellName = "Summon Dreadsteed" }, { item = 20536, itemName = "Soul Harvester", quality = 3, choice = true },
				{ item = 20534, itemName = "Abyss Shard", quality = 3, choice = true }, { text = "Summon Incubus" } },
			why = "A staff, an off-hand or a robe for the 50s.",
			steps = { { title = "One", goals = { { t = "note", text = "One", status = "pending" } } } } }
		table.insert(uistub.order, id)
		ITEM_QUALITY_COLORS = { [3] = { r = 0, g = 0.44, b = 0.87 } }
		Polestar.Compat.ItemIcon = function(item) return item == 20536 and 135139 or nil end
		Polestar.Compat.SpellIcon = function(spell) return spell == 23161 and 132238 or nil end
		local tips = {}
		GameTooltip.SetHyperlink = function(_, link) tips[#tips + 1] = link end
		GameTooltip.SetSpellByID = function(_, spell) tips[#tips + 1] = "spell:" .. spell end
		Polestar.Set("ui.pickerFaction", "All")
		UI.ShowPicker()
		P.Select(id)
		local d = D()
		local tiles = {}
		for _, t in ipairs(d.Rewards) do
			if t:IsShown() then
				stub.RunScript(t, "OnEnter")
				tiles[#tiles + 1] = { t.Name:GetText(), t.Icon:GetTexture() }
			end
		end
		emit({ reward = P.detail.reward, facts = { P.detail.facts[1], P.detail.facts[2], P.detail.facts[3] }, tiles = tiles, tips = tips,
			blue = select(3, d.Rewards[3].Name:GetTextColor()) > 0.8 })
		P.Select("forever/alliance/02-westfall")
		local shown = 0
		for _, t in ipairs(d.Rewards) do if t:IsShown() then shown = shown + 1 end end
		emit({ shown = shown, reward = P.detail.reward == nil, first = P.detail.facts[1][1] })`);
	const [rows, after] = out;
	assert.deepEqual(rows.reward, [
		{ kind: 'spell', id: 23161, name: 'Summon Dreadsteed' },
		{ kind: 'text', name: 'Summon Incubus' },
		{ kind: 'item', id: 20536, name: 'Soul Harvester', choice: true },
		{ kind: 'item', id: 20534, name: 'Abyss Shard', choice: true },
	]);
	assert.deepEqual(rows.facts, [
		['Reward', 'Summon Dreadsteed, Summon Incubus'],
		['Choose one', 'Soul Harvester, Abyss Shard'],
		['Why', 'A staff, an off-hand or a robe for the 50s.'],
	]);
	assert.equal(rows.tiles.length, 4);
	assert.equal(rows.tiles[0][1], 132238, 'the spell\'s icon');
	assert.equal(rows.tiles[2][1], 135139, 'the item\'s icon');
	assert.deepEqual(rows.tips, ['spell:23161', 'item:20536', 'item:20534'], 'items and spells show the game\'s tooltip; words none');
	assert.equal(rows.blue, true, 'a rare item in its quality colour');
	assert.deepEqual(after, { shown: 0, reward: true, first: 'Steps' });
});

test('reward tiles: an uncached item\'s tooltip fills in when the item arrives, the pane asks for its items, and modified clicks act as on any item or spell button', () => {
	const [out] = run(`
		local id = "forever/class/warlock/test"
		uistub.guides[id] = { id = id, pack = "guides", title = "An Imp's Request", category = "Class", folder = "Warlock", minLevel = 50, maxLevel = 54,
			reward = { { spell = 691, spellName = "Summon Felhunter" }, { item = 20536, itemName = "Soul Harvester", quality = 3, choice = true },
				{ item = 20534, itemName = "Abyss Shard", quality = 3, choice = true } },
			steps = { { title = "One", goals = { { t = "note", text = "One", status = "pending" } } } } }
		table.insert(uistub.order, id)
		local cached, requested, spellsRequested = {}, {}, {}
		local names = { [20536] = "Soul Harvester", [20534] = "Abyss Shard" }
		local function link(item) return "|cff0070dd|Hitem:" .. item .. "::::::::50:::::|h[" .. names[item] .. "]|h|r" end
		local C = Polestar.Compat
		C.RequestItem = function(item) if cached[item] then return true end requested[#requested + 1] = item; return false end
		C.ItemLink = function(item) return cached[item] and link(item) or nil end
		C.RequestSpell = function(spell) spellsRequested[#spellsRequested + 1] = spell; return false end
		C.SpellLink = function(spell) return "|cff71d5ff|Hspell:" .. spell .. ":0|h[Summon Felhunter]|h|r" end
		GameTooltip.GetOwner = function(self) return self.owner end
		GameTooltip.IsOwned = function(self, f) return self.owner == f end
		GameTooltip.SetHyperlink = function(self, l)
			local item = tonumber(l:match("item:(%d+)"))
			self.lines = { cached[item] and names[item] or "Retrieving item information" }
		end
		GameTooltip.SetSpellByID = function(self, spell) self.lines = { "spell " .. spell } end
		local calls = {}
		function IsModifiedClick(kind)
			if kind == "CHATLINK" then return stub.keys.shift == true end
			if kind == "DRESSUP" then return stub.keys.ctrl == true end
			return (stub.keys.shift or stub.keys.ctrl or stub.keys.alt) and true or false
		end
		ChatFrameUtil = { InsertLink = function(l) calls[#calls + 1] = "chat " .. l; return true end }
		function DressUpItemLink(l) calls[#calls + 1] = "dressup " .. l; return true end
		function HandleModifiedItemClick(l)
			if IsModifiedClick("CHATLINK") and ChatFrameUtil.InsertLink(l) then return true end
			if IsModifiedClick("DRESSUP") then return DressUpItemLink(l) end
			return false
		end
		Polestar.Hooks.ItemClick("test", function(_, item) if IsAltKeyDown() then calls[#calls + 1] = "guide " .. item end end)
		Polestar.Set("ui.pickerFaction", "All")
		UI.ShowPicker()
		P.Select(id)
		local d = D()
		local r = { requested = requested, spellsRequested = spellsRequested }
		local spell, harvester, shard = d.Rewards[1], d.Rewards[2], d.Rewards[3]
		stub.RunScript(harvester, "OnEnter")
		r.before = { GameTooltip.lines[1], GameTooltip:IsShown() }
		cached[20536] = true
		stub.fire("GET_ITEM_INFO_RECEIVED", 20534, true)
		r.other = GameTooltip.lines[1]
		stub.fire("GET_ITEM_INFO_RECEIVED", 20536, true)
		r.after = { GameTooltip.lines[1], GameTooltip.owner == harvester }
		stub.RunScript(harvester, "OnLeave")
		stub.fire("GET_ITEM_INFO_RECEIVED", 20536, true)
		r.left = GameTooltip:IsShown()
		cached[20534] = true
		stub.RunScript(spell, "OnEnter")
		stub.fire("SPELL_DATA_LOAD_RESULT", 691, true)
		r.spellTip = GameTooltip.lines[1]
		stub.keys.ctrl = true; stub.RunScript(harvester, "OnClick", "LeftButton"); stub.keys.ctrl = false
		stub.keys.shift = true; stub.RunScript(harvester, "OnClick", "LeftButton"); stub.RunScript(spell, "OnClick", "LeftButton"); stub.keys.shift = false
		stub.keys.alt = true; stub.RunScript(harvester, "OnClick", "LeftButton")
		cached[20534] = false
		stub.RunScript(shard, "OnClick", "LeftButton"); stub.keys.alt = false
		stub.RunScript(harvester, "OnClick", "LeftButton")
		r.calls = calls
		emit(r)`);
	assert.deepEqual(out.requested.slice(0, 2), [20536, 20534], 'the pane asks for its reward items as it paints them');
	assert.deepEqual(out.spellsRequested.slice(0, 1), [691], 'and for its spells');
	assert.deepEqual(out.before, ['Retrieving item information', true]);
	assert.equal(out.other, 'Retrieving item information', 'another item arriving leaves the tooltip alone');
	assert.deepEqual(out.after, ['Soul Harvester', true], 'the item arriving fills the tooltip in');
	assert.equal(out.left, false, 'nothing reopens once the cursor has left');
	assert.equal(out.spellTip, 'spell 691');
	assert.deepEqual(out.calls, [
		'dressup |cff0070dd|Hitem:20536::::::::50:::::|h[Soul Harvester]|h|r',
		'chat |cff0070dd|Hitem:20536::::::::50:::::|h[Soul Harvester]|h|r',
		'chat |cff71d5ff|Hspell:691:0|h[Summon Felhunter]|h|r',
		'guide 20536',
		'guide 20534',
	], 'Ctrl tries it on, Shift links the item or spell, Alt still guides (an uncached item too); a plain click does nothing');
});

test('Load guide replaces the current tab, Open in new tab adds one; double-click and Enter load', () => {
	const [out] = run(`
		uistub.openTabs(TABS, 1)
		Polestar.Set("ui.shown", false)
		local r = {}
		UI.ShowPicker(); P.SetCategory("Leveling"); P.Select("forever/alliance/02-westfall")
		D().Load:Click()
		r.load = { lastCall("SetGuide"), Polestar.Get("ui.shown"), PolestarPicker:IsShown() }
		UI.ShowPicker(); P.Select("forever/alliance/dwarf-gnome/01-dun-morogh")
		D().NewTab:Click()
		r.newTab = { lastCall("OpenTab"), PolestarPicker:IsShown() }
		UI.ShowPicker(); P.SetCategory("Professions")
		stub.RunScript(rowFor("Cooking 1-300"), "OnDoubleClick", "LeftButton")
		r.double = { lastCall("SetGuide"), PolestarPicker:IsShown() }
		UI.ShowPicker(); P.SetQuery("darkshore")
		stub.RunScript(PolestarPicker.Search, "OnEnterPressed")
		r.enter = { lastCall("SetGuide"), PolestarPicker:IsShown() }
		emit(r)`);
	assert.deepEqual(out.load, [['SetGuide', 'forever/alliance/02-westfall'], true, false]);
	assert.deepEqual(out.newTab, [['OpenTab', 'forever/alliance/dwarf-gnome/01-dun-morogh'], false]);
	assert.deepEqual(out.double, [['SetGuide', 'forever/professions/cooking'], false]);
	assert.deepEqual(out.enter, [['SetGuide', 'forever/alliance/03-darkshore'], false]);
});

test('from the guide window\'s +, loading opens a new tab; faction buttons write the filter; no tabs API, no new-tab button', () => {
	const [out] = run(`
		uistub.openTabs(TABS, 1)
		UI.ShowPicker({ newTab = true })
		local r = { subtitle = PolestarPicker.Subtitle:GetText(), newTabMode = P.IsNewTabMode() }
		for _, b in ipairs(PolestarPicker.factionButtons) do if b.psKey == "Horde" then b:Click() end end
		r.filter = Polestar.Get("ui.pickerFaction")
		P.SetCategory("Leveling")
		P.Select("forever/horde/orc-troll/01-durotar")
		r.primary = { load = D().Load.psPrimary or false, newTab = D().NewTab.psPrimary or false }
		r.tip = rowFor("Durotar").psTip
		stub.RunScript(rowFor("Durotar"), "OnDoubleClick", "LeftButton")
		r.call = lastCall("OpenTab")
		r.tabs = #select(1, Polestar.Engine.GetTabs())
		emit(r)`);
	assert.deepEqual(out, {
		subtitle: 'Pick a guide to open in a new tab.', newTabMode: true, filter: 'Horde', primary: { load: false, newTab: true },
		call: ['OpenTab', 'forever/horde/orc-troll/01-durotar'], tabs: 4,
		tip: 'Double-click a guide or press Enter to open it in a new tab.',
	});
	const [plain] = run(`
		UI.ShowPicker(); P.Select("forever/alliance/02-westfall")
		emit({ newTab = D().NewTab:IsShown(), load = D().Load.Label:GetText(), primary = D().Load.psPrimary or false })`, { install: '{ noTabs = true }' });
	assert.deepEqual(plain, { newTab: false, load: 'Load guide', primary: true });
});

for (const newTab of [false, true]) {
	for (const hidden of [false, true]) {
		test(`${newTab ? '+' : 'Choose guide'} clears Lookup search with the hub ${hidden ? 'hidden' : 'open'}`, () => {
			const [out] = run(`
				uistub.openTabs(TABS, 1)
				UI.ShowLookup({ query = "saber" })
				local lookup = P.Query()
				-- The client also fires this callback for programmatic text changes.
				local box, setText = P.search, P.search.SetText
				box.SetText = function(self, text)
					setText(self, text)
					stub.RunScript(self, "OnTextChanged", false)
				end
				if ${hidden} then PolestarPicker:Hide() end
				local first, render = nil, P.Render
				P.Render = function(...)
					if not first and PolestarPicker:IsShown() then first = { P.Section(), P.Query() } end
					return render(...)
				end
				local GF = UI.GuideFrame
				if ${newTab} then
					GF.parts.strip.Add:Click()
				else
					GF.menuButton:Click()
					for _, r in ipairs(PolestarMenu.rows) do
						if r:IsShown() and r.Text:GetText() == "Choose guide" then r:Click(); break end
					end
				end
				local r = { lookup = lookup, first = first, section = P.Section(), query = P.Query(),
					search = P.search:GetText(), newTab = P.IsNewTabMode(), lookupQuery = UI.Lookup.Query() }
				P.Select("forever/alliance/02-westfall")
				P.LoadSelected()
				r.loaded = lastCall("${newTab ? 'OpenTab' : 'SetGuide'}")
				emit(r)`);
			assert.deepEqual(out, {
				lookup: 'saber', first: ['Guides', ''], section: 'Guides', query: '', search: '',
				newTab, lookupQuery: 'saber', loaded: [newTab ? 'OpenTab' : 'SetGuide', 'forever/alliance/02-westfall'],
			});
		});
	}
}

test('explicit destinations preserve the menu policy before and after a section is picked', () => {
	const [out] = run(`
		UI.ShowPicker({ section = "Lookup" })
		P.SetQuery("saber")
		UI.ShowPicker({ section = "Guides" })
		PolestarPicker:Hide()
		Polestar.Bindings.Menu()
		local initial = P.Section()
		P.ShowSection("Lookup")
		UI.ShowPicker({ section = "Guides" })
		PolestarPicker:Hide()
		Polestar.Bindings.Menu()
		emit({ initial = initial, picked = P.Section() })`);
	assert.deepEqual(out, { initial: 'Home', picked: 'Guides' });
});

test('Home: Continue cards for the open tabs and the suggested guides; a card selects, a double-click continues', () => {
	const [out] = run(`
		uistub.player.level = 10
		uistub.openTabs(TABS, 1)
		UI.ShowPicker()
		local cards = {}
		for _, f in ipairs(stub.frames) do
			if f.psIndex and rawget(f, "Pct") and f:IsShown() and f:GetParent() == PolestarPicker.Scroll.Child then cards[#cards + 1] = f end
		end
		table.sort(cards, function(a, b) return a.psIndex < b.psIndex end)
		local info = {}
		for i, c in ipairs(cards) do info[i] = { c.Title:GetText(), c.Step:GetText(), c.Pct:GetText(), c.Note:GetText() } end
		local r = { view = P.View(), homeOn = tab("home").psSelected, folders = folders(), suggested = lines(), info = info, shown = P.shown.cards }
		cards[2]:Click()
		r.selected = { P.Selected(), D().Title:GetText(), PolestarPicker:IsShown() }
		stub.RunScript(cards[2], "OnDoubleClick", "LeftButton")
		r.continued = { lastCall("SetGuide"), select(2, Polestar.Engine.GetTabs()), PolestarPicker:IsShown() }
		emit(r)`);
	assert.equal(out.view, 'home');
	assert.equal(out.homeOn, true);
	assert.deepEqual(out.folders, ['Continue 3', 'Suggested for you 2']);
	// The guide for the player's level is always suggested, open or not (its
	// row says "Tab 1"); level 10 is within two levels of its follow-up (12).
	assert.deepEqual(out.suggested, ['Elwynn Forest (1\u201313) | Tab 1', 'Westfall (12\u201317)']);
	assert.equal(out.shown, 3);
	assert.deepEqual(out.info, [
		['Elwynn Forest', 'Step 3 of 8', '29%', 'Tab 1'],
		['Tailoring 1-300', 'Step 2 of 4', '25%', 'Tab 2'],
		['Stormwind Reputation', 'Step 2 of 2', '50%', 'Tab 3'],
	]);
	assert.deepEqual(out.selected, ['forever/professions/tailoring', 'Tailoring 1-300', true]);
	assert.deepEqual(out.continued, [['SetGuide', 'forever/professions/tailoring'], 2, false]);
});

// "Suggested for you" always names the guide for the player's level, even
// when it is open; a follow-up only joins it near the end: at level 9,
// Elwynn Forest (1-13) open must not send the player on to Westfall (12-17).
test('Home always suggests the guide for the player\'s level, and its follow-up only within two levels', () => {
	const [out] = run(`
		uistub.player.level = 9
		uistub.openTabs(TABS, 1)
		UI.ShowPicker()
		emit({ folders = folders(), suggested = lines() })`);
	assert.deepEqual(out.folders, ['Continue 3', 'Suggested for you 1']);
	assert.deepEqual(out.suggested, ['Elwynn Forest (1\u201313) | Tab 1']);
});

test('Current lists the open tabs (tab and progress; check when finished); Recent keeps the last 10 loaded', () => {
	const [out] = run(`
		uistub.openTabs(TABS, 1)
		uistub.complete()
		UI.ShowPicker()
		tab("current"):Click()
		local r = { view = P.View(), current = lines() }
		tab("recent"):Click()
		r.recent = lines()
		r.stored = Polestar.CharState().ui.recentGuides[1]
		-- Every guide that becomes the loaded one goes to the front, once.
		local ids = {}
		for _, id in ipairs(uistub.order) do ids[#ids + 1] = id end
		for i = 1, 12 do Polestar.Fire("GUIDE_CHANGED", ids[i]) end
		Polestar.Fire("GUIDE_CHANGED", ids[5])
		Polestar.Fire("GUIDE_CHANGED", nil)
		local list = Polestar.CharState().ui.recentGuides
		r.count, r.first, r.second, r.unique = #list, list[1], list[2], true
		local seen = {}
		for _, id in ipairs(list) do if seen[id] then r.unique = false end; seen[id] = true end
		r.rows = #rows()
		emit(r)`);
	assert.equal(out.view, 'current');
	assert.deepEqual(out.current, [
		'\u2713 Elwynn Forest (1\u201313) | Tab 1  \u00b7  100%',
		'Tailoring 1-300 (5\u201360) | Tab 2  \u00b7  25%',
		'Stormwind Reputation (12\u201360) | Tab 3  \u00b7  50%',
	]);
	assert.deepEqual(out.recent, ['\u2713 Elwynn Forest (1\u201313) | Tab 1']);
	assert.equal(out.stored, 'forever/alliance/human/01-elwynn-forest');
	assert.equal(out.count, 10);
	assert.equal(out.first, 'forever/alliance/skyborne/01-zephras-isle');
	assert.equal(out.second, 'forever/legacy/legacy-challenges');
	assert.equal(out.unique, true);
	assert.equal(out.rows, 10);
});

test('Favorites: the star in the details toggles a guide in CharState().ui.favoriteGuides and the Favorites category', () => {
	const [out] = run(`
		UI.ShowPicker()
		P.Select("forever/alliance/02-westfall")
		local star = D().Star
		local r = { before = star.psActive or false }
		star:Click()
		r.after = { star.psActive, star.psTip, Polestar.CharState().ui.favoriteGuides["forever/alliance/02-westfall"], nav("Favorites").Count:GetText() }
		nav("Favorites"):Click()
		r.list = lines()
		r.folders = folders()
		star:Click()
		r.removed = { Polestar.CharState().ui.favoriteGuides["forever/alliance/02-westfall"] or false, #rows(), PolestarPicker.Empty:IsShown() }
		emit(r)`);
	assert.deepEqual(out, {
		before: false,
		after: [true, 'Remove from favourites', true, '1'],
		list: ['Westfall (12\u201317)'], folders: ['Alliance 1\u201330 1'],
		removed: [false, 0, true],
	});
});

test('the details art: the zone\'s painting from the client around the guide\'s focus; the night band without it', () => {
	const [out] = run(`
		C_Map = C_Map or {}
		C_Map.GetMapArtLayers = function(id)
			if id == 1436 then return { { layerWidth = 1002, layerHeight = 668, tileWidth = 256, tileHeight = 256 } } end
			return {}
		end
		C_Map.GetMapArtLayerTextures = function() local t = {}; for i = 1, 12 do t[i] = 200000 + i end; return t end
		uistub.guides["forever/alliance/02-westfall"].zone = 1436
		Polestar.Engine.GuideFocus = function(id) if id == "forever/alliance/02-westfall" then return 56, 47 end end
		UI.ShowPicker()
		P.Select("forever/alliance/02-westfall")
		local a = D().Art
		local tiles = 0
		for _, t in ipairs(a.Tiles) do if t:IsShown() then tiles = tiles + 1 end end
		local _, _, _, cx = a.Canvas:GetPoint(1)
		local r = { painted = P.detail.art, band = a.Band:IsShown(), tiles = tiles, first = a.Tiles[1]:GetTexture(), cw = a.Canvas:GetWidth(), cx = cx, w = a:GetWidth() }
		P.Select("forever/alliance/03-darkshore")
		local shown = 0
		for _, t in ipairs(a.Tiles) do if t:IsShown() then shown = shown + 1 end end
		r.other = { painted = P.detail.art, band = a.Band:IsShown(), tiles = shown }
		Polestar.CharState().ui.pickerSelected = "gone"
		PolestarPicker:Hide()
		Polestar.Engine.SetGuide(nil)
		uistub.suggest = nil
		UI.ShowPicker()
		r.none = { P.detail == nil, D().EmptyTitle:IsShown(), a.Band:IsShown(), D().Load:IsShown() }
		emit(r)`);
	assert.equal(out.painted, true);
	assert.equal(out.band, false);
	assert.ok(out.tiles > 0 && out.tiles < 12, `only the tiles that meet the art are drawn (${out.tiles} of 12)`);
	assert.ok(out.first > 200000 && out.first <= 200012, 'tiles come from the zone\'s art layer');
	// The focus (56%) sits at the band's centre, the painting never showing past its edge.
	assert.ok(Math.abs(-out.cx + out.w / 2 - 0.56 * out.cw) < 0.5, `centre ${out.cx}`);
	assert.deepEqual(out.other, { painted: false, band: true, tiles: 0 });
	assert.deepEqual(out.none, [true, true, true, false]);
});

// A `next` option with `when` is offered only while it holds
// (Engine.RouteOffered): the "Next" fact and the follow-ups Home suggests
// name only the options offered now.
test('the Next fact and the suggested follow-ups list only the options offered now', () => {
	const [out] = run(`
		uistub.player.level = 10
		uistub.openTabs(TABS, 1)
		local desolace, feralas = "forever/alliance/30-40/02-desolace", "forever/alliance/40-50/03-feralas"
		local offered = {}
		Polestar.Engine.RouteOffered = function(from, id) return offered[id] ~= false end
		UI.ShowPicker()
		local r = { suggested = lines() }
		offered["forever/alliance/02-westfall"] = false
		P.Render()
		r.hidden = lines()
		P.SetCategory("Leveling")
		rowFor("Westfall"):Click()
		westfall.nextChoices, westfall.nextWhen = { desolace, feralas }, { [feralas] = { { k = "level", op = ">=", n = 43 } } }
		P.Render()
		r.both = P.detail.facts[#P.detail.facts]
		offered[feralas] = false
		P.Render()
		r.one = P.detail.facts[#P.detail.facts]
		offered[desolace] = false
		P.Render()
		r.none = P.detail.facts[#P.detail.facts][1]
		westfall.nextChoices, westfall.nextWhen = nil, nil
		emit(r)`);
	assert.deepEqual(out.suggested, ['Elwynn Forest (1\u201313) | Tab 1', 'Westfall (12\u201317)']);
	assert.deepEqual(out.hidden, ['Elwynn Forest (1\u201313) | Tab 1']);
	assert.deepEqual(out.both, ['Next', 'Your choice: Desolace or Feralas']);
	assert.deepEqual(out.one, ['Next', 'Desolace (31\u201334)']);
	assert.notEqual(out.none, 'Next');
});
