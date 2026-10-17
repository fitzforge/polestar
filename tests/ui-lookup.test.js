'use strict';
// The Lookup section of the hub (addon/Polestar/UI/Lookup.lua) and its rows in the guide
// menu's search, against the fake Engine of tests/lua/stub_ui.lua and the fake
// Search / Codex / Lookup runtime of tests/lua/stub_lookup.lua; the last test
// runs the real runtime over the synthetic Codex pack (tests/fixtures/codex).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { writeCodexPack, sampleCodex } = require('./helpers/codex');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua', 'stub_lookup.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nlookupstub.install()\nstub.login()\nlocal UI, LK = Polestar.UI, Polestar.UI.Lookup\n${HELPERS}\n${script}`,
	}).emitted;
}

const HELPERS = `
local function shownRows(parent)
	local out = {}
	for _, f in ipairs(stub.frames) do
		if rawget(f, "Sub") and rawget(f, "Title") and f:IsShown() and f:GetParent() == parent then out[#out + 1] = f end
	end
	table.sort(out, function(a, b) return select(5, a:GetPoint(1)) > select(5, b:GetPoint(1)) end)
	return out
end
local function rowTexts(parent)
	local out = {}
	for _, r in ipairs(shownRows(parent)) do out[#out + 1] = r.Title:GetText() end
	return out
end
local function rowFor(parent, title)
	for _, r in ipairs(shownRows(parent)) do if r.Title:GetText() == title then return r end end
end
local function nav(key)
	for _, b in ipairs(PolestarPicker.navButtons) do if b.psKey == key and b:IsShown() then return b end end
end
local function lookupShown() return PolestarPicker:IsShown() and Polestar.UI.Picker.Section() == "Lookup" end
local function navKeys()
	local out = {}
	for _, b in ipairs(PolestarPicker.navButtons) do if b:IsShown() then out[#out + 1] = b.psKey end end
	return out
end
local function type_(text)
	local box = Polestar.UI.Picker.search
	box:SetText(text)
	stub.RunScript(box, "OnTextChanged", true)
end
`;

test('SHOW_LOOKUP opens the hub at Lookup on the query, results grouped by kind, the first selected', () => {
	const [out] = run(`
		Polestar.Lookup.Show("saber")
		local body = LK.results.Child
		emit({ shown = lookupShown(), query = LK.Query(), box = Polestar.UI.Picker.search:GetText(), groups = LK.shown.groups, rows = rowTexts(body),
			sel = LK.Selected() and LK.Selected().id, title = PolestarPicker.Title:GetText(), sub = PolestarPicker.Subtitle:GetText(),
			navs = navKeys(), mounts = nav("mount").Count:GetText(), codex = LK.root.CodexLine:GetText(), tabRow = PolestarPicker.TabRow:IsShown(),
			tip = rowFor(body, "Reins of the Striped Frostsaber").psTip,
			special = (function() for _, n in ipairs(UISpecialFrames) do if n == "PolestarPicker" then return true end end end)() })`);
	assert.equal(out.shown, true);
	assert.equal(out.query, 'saber');
	assert.equal(out.box, 'saber');
	assert.deepEqual(out.groups, [
		{ kind: 'mount', count: 6, shown: 5 },
		{ kind: 'item', count: 1, shown: 1 },
		{ kind: 'quest', count: 1, shown: 1 },
	]);
	assert.deepEqual(out.rows, [
		'Reins of the Striped Frostsaber', 'Reins of the Spotted Frostsaber', 'Reins of the Winterspring Frostsaber',
		'Reins of the Nightsaber', 'Reins of the Shadowsaber', 'Show all 6', 'Sabertooth Fang', 'Frostsaber Provisions',
	]);
	assert.equal(out.sel, 8631);
	assert.equal(out.title, 'Lookup');
	assert.match(out.sub, /^8 results for .saber.$/);
	assert.equal(out.mounts, '6');
	assert.deepEqual(out.navs, ['all', 'mount', 'item', 'quest'], 'the sidebar lists the kinds this search found');
	assert.equal(out.codex, '', 'a loaded Codex is not news');
	assert.equal(out.tabRow, false, 'no tabs, no tab row');
	assert.equal(out.tip, 'Double-click or press Enter to be guided to it.', 'the key that acts, in the row tooltip');
	assert.equal(out.special, true);
});

test('Show all and the sidebar filter to one kind; arrows walk the results', () => {
	const [out] = run(`
		Polestar.Lookup.Show("saber")
		local body = LK.results.Child
		rowFor(body, "Show all 6"):Click()
		local filtered = { kind = LK.Kind(), rows = rowTexts(body), title = PolestarPicker.Title:GetText() }
		nav("all"):Click()
		local box = Polestar.UI.Picker.search
		stub.RunScript(box, "OnArrowPressed", "DOWN")
		stub.RunScript(box, "OnArrowPressed", "DOWN")
		local two = LK.Selected().id
		stub.RunScript(box, "OnArrowPressed", "UP")
		emit({ filtered = filtered, two = two, back = LK.Selected().id, kind = LK.Kind() })`);
	assert.equal(out.filtered.kind, 'mount');
	assert.equal(out.filtered.rows.length, 6);
	assert.equal(out.filtered.title, 'Mounts');
	assert.equal(out.kind, 'all');
	assert.equal(out.two, 13086);
	assert.equal(out.back, 8632);
});

test('typing waits for a pause before searching', () => {
	const [out] = run(`
		UI.ShowLookup()
		local before = lookupstub.queries
		type_("dea")
		type_("death")
		local during = { query = LK.Query(), queries = lookupstub.queries - before }
		stub.advance(0.3)
		emit({ during = during, query = LK.Query(), rows = rowTexts(LK.results.Child), sel = LK.Selected().id })`);
	assert.deepEqual(out.during, { query: '', queries: 0 });
	assert.equal(out.query, 'death');
	assert.deepEqual(out.rows, ["Deathcharger's Reins"]);
	assert.equal(out.sel, 13335);
});

test('what cannot be got: a muted chip carries it in the list and the hub search (the name keeps its colour), no guide in the details', () => {
	const [out] = run(`
		Polestar.Lookup.Show("saber")
		LK.SetKind("mount")
		local function row(title)
			local r = rowFor(LK.results.Child, title)
			return { status = r.Status:IsShown() and r.Status.Text:GetText() or false, alpha = r.Title:GetAlpha() }
		end
		local list = { live = row("Reins of the Striped Frostsaber"), nosource = row("Reins of the Shadowsaber"), retired = row("Reins of the Frostsaber"),
			last = rowTexts(LK.results.Child)[6] }
		rowFor(LK.results.Child, "Reins of the Frostsaber"):Click()
		local d = LK.detail
		local chip = LK.details.Status:IsShown() and LK.details.Status.Text:GetText()
		local buttons = { primary = LK.details.Primary:IsShown(), secondary = LK.details.Secondary:IsShown() }
		LK.details.Rows[1]:Click()
		local sourceGuide = LK.details.Rows[1].Guide:IsShown()
		stub.RunScript(Polestar.UI.Picker.search, "OnEnterPressed")
		LK.Guide(1)
		local calls = #lookupstub.calls
		UI.ShowPicker()
		Polestar.UI.Picker.ShowSection("Guides")
		Polestar.UI.Picker.SetQuery("reins of the frostsaber")
		local hub = {}
		for _, r in ipairs(shownRows(PolestarPicker.Scroll.Child)) do
			if r.psResult and r.psResult.id == 12302 then hub = { chip = r.Status:IsShown() and r.Status.Text:GetText(), alpha = r.Title:GetAlpha() } end
		end
		emit({ list = list, d = d, chip = chip, buttons = buttons, sourceGuide = sourceGuide, calls = calls, hub = hub })`);
	assert.deepEqual(out.list.live, { status: false, alpha: 1 });
	assert.deepEqual(out.list.nosource, { status: 'No known source', alpha: 1 });
	assert.deepEqual(out.list.retired, { status: 'No longer obtainable', alpha: 1 });
	assert.equal(out.list.last, 'Reins of the Frostsaber', 'retired last, as Search ranks it');
	assert.equal(out.d.status, 'retired');
	assert.equal(out.chip, 'No longer obtainable');
	assert.deepEqual(out.buttons, { primary: false, secondary: false });
	assert.equal(out.d.note, 'Not obtainable any more; shown for reference.');
	assert.deepEqual(out.d.sources.map((s) => [s.label, s.why, s.guide]), [['Lelanai', 'No longer obtainable', false]]);
	assert.equal(out.sourceGuide, false);
	assert.equal(out.calls, 0, 'Enter and Guide never build a guide to it');
	assert.deepEqual(out.hub, { chip: 'No longer obtainable', alpha: 1 });
});

test('a vendor mount: facts, ranked sources with travel and price, the closed one dimmed with why', () => {
	const [out] = run(`
		Polestar.Lookup.Show(nil, "mount", 8631)
		emit({ query = LK.Query(), d = LK.detail, title = LK.details.Title:GetText(), color = { LK.details.Title:GetTextColor() } })`);
	assert.equal(out.query, 'Reins of the Striped Frostsaber');
	assert.equal(out.title, 'Reins of the Striped Frostsaber');
	assert.ok(out.color[2] > out.color[0] && out.color[2] > out.color[1], 'rare quality: blue');
	assert.ok(out.color[0] > 0, 'lifted toward the text colour to read on the ground');
	assert.deepEqual(out.d.facts, [
		['Type', 'Mount  \u00b7  Rare'],
		['Requires', 'Level 40'],
		['Sources', '2  \u00b7  1 open to you'],
	]);
	assert.deepEqual(
		out.d.sources.map((s) => [s.label, s.travel, s.facts ?? null, s.why ?? null, s.available]),
		[
			['Lelanai', '4 min', '80g', null, true],
			['Zachariah Post', '32 min', '80g  \u00b7  Limited stock', 'Horde only', false],
		],
	);
	assert.equal(out.d.primary, 'Guide me');
	assert.match(out.d.note, /Builds a guide to Lelanai/);
});

test('Guide me and a source\'s own Guide call Lookup.Guide and open the guide window', () => {
	const [out] = run(`
		Polestar.Lookup.Show(nil, "mount", 8631)
		LK.details.Rows[2]:Click()
		local pick = { sel = LK.detail.sources[2].guide, other = LK.detail.sources[1].guide }
		LK.details.Rows[2].Guide:Click()
		local afterSource = { call = lookupstub.calls[1], shown = lookupShown(), ui = Polestar.Get("ui.shown") }
		Polestar.Set("ui.shown", false)
		Polestar.Lookup.Show(nil, "mount", 8631)
		LK.details.Primary:Click()
		local primary = lookupstub.calls[2]
		Polestar.Lookup.Show(nil, "mount", 8631)
		stub.RunScript(Polestar.UI.Picker.search, "OnEnterPressed")
		emit({ pick = pick, afterSource = afterSource, primary = primary, enter = lookupstub.calls[3], shown = lookupShown(), ui = Polestar.Get("ui.shown") })`);
	assert.deepEqual(out.pick, { sel: true, other: false });
	assert.deepEqual(out.afterSource, { call: ['mount', 8631, 2], shown: false, ui: true });
	assert.deepEqual(out.primary, ['mount', 8631, false]);
	assert.deepEqual(out.enter, ['mount', 8631, false]);
	assert.equal(out.shown, false);
	assert.equal(out.ui, true);
});

test('a rare drop out of reach: chance, the reason, Guide me off; a curated guide says Open guide', () => {
	const [out] = run(`
		Polestar.Lookup.Show("deathcharger")
		local drop = LK.detail
		lookupstub.curated["mount:8631"] = "forever/alliance/02-westfall"
		Polestar.Lookup.Show(nil, "mount", 8631)
		local curated = LK.detail
		LK.details.Primary:Click()
		lookupstub.guideResult = "nosource"
		Polestar.Lookup.Show(nil, "mount", 13335)
		LK.details.Rows[1]:Click()
		LK.details.Rows[1].Guide:Click()
		emit({ drop = drop, curated = curated, call = lookupstub.calls[1], failed = LK.details.Note:GetText(), still = lookupShown() })`);
	assert.equal(out.drop.id, 13335);
	assert.deepEqual(
		out.drop.sources.map((s) => [s.label, s.facts ?? null, s.why ?? null, s.available]),
		[
			['Baron Rivendare', '0.1% drop chance', 'Needs level 58', false],
			["Ramstein's Reward", null, 'Needs level 60', false],
		],
	);
	assert.equal(out.drop.primary, 'Guide me');
	assert.equal(out.drop.enabled, false);
	assert.match(out.drop.note, /No source is open/);
	assert.equal(out.curated.primary, 'Open guide');
	// Neutral wording: the curated guide may come from a guide pack.
	assert.match(out.curated.note, /^A guide covers this: .*Westfall.*\.$/);
	assert.doesNotMatch(out.curated.note, /Polestar/);
	assert.deepEqual(out.call, ['mount', 8631, false]);
	assert.match(out.failed, /nosource/);
	assert.equal(out.still, true);
});

test('without the Codex pack the section says what is missing and still finds guides', () => {
	const [out] = run(`
		lookupstub.loaded, lookupstub.reason = false, "missing"
		UI.ShowLookup()
		local idle = { title = LK.detail.empty, note = LK.detail.note, list = LK.shown.empty, codex = LK.root.CodexLine:GetText(),
			navs = navKeys() }
		Polestar.UI.Picker.SetQuery("saber"); stub.advance(0.3)
		local none = LK.shown.empty
		Polestar.UI.Picker.SetQuery("west"); stub.advance(0.3)
		emit({ idle = idle, none = none, rows = rowTexts(LK.results.Child), sel = LK.detail.primary })`);
	assert.equal(out.idle.title, 'The Codex is not loaded');
	assert.match(out.idle.note, /^The Polestar_Codex addon is not installed\. .*Releases page.*not "Source code"/, 'a missing Codex points at the release download, not the source zip');
	assert.doesNotMatch(out.idle.note, /tools\/polestar|codex build/, 'no developer command in a player message');
	assert.match(out.idle.list, /search the guides/);
	assert.match(out.idle.codex, /Codex not installed/);
	assert.deepEqual(out.idle.navs, ['all'], 'no kind is offered that nothing was found in');
	assert.match(out.none, /Nothing matches .saber.\. Items, mounts, NPCs and quests are searched once the Codex loads\./);
	assert.deepEqual(out.rows, ['Westfall']);
	assert.equal(out.sel, 'Open in new tab');
});

test('a Codex that is installed but turned off says to enable it, not to download Polestar again', () => {
	const [out] = run(`
		lookupstub.loaded, lookupstub.reason = false, "disabled"
		UI.ShowLookup()
		emit({ note = LK.detail.note })`);
	assert.match(out.note, /turned off: enable it in the AddOns list/);
	assert.doesNotMatch(out.note, /Releases page/);
});

test('a guide result opens in a new tab, or among the hub\'s guides', () => {
	const [out] = run(`
		Polestar.Lookup.Show("west")
		LK.details.Primary:Click()
		local opened = uistub.calls[#uistub.calls]
		Polestar.Lookup.Show("west")
		LK.details.Secondary:Click()
		local P = Polestar.UI.Picker
		emit({ opened = opened, lookup = lookupShown(), picker = PolestarPicker:IsShown(), section = P.Section(), view = P.View(), sel = P.Selected() })`);
	assert.deepEqual(out.opened, ['OpenTab', 'forever/alliance/02-westfall']);
	assert.equal(out.lookup, false);
	assert.equal(out.picker, true);
	assert.equal(out.section, 'Guides');
	assert.equal(out.view, 'browse');
	assert.equal(out.sel, 'forever/alliance/02-westfall');
});

test('the hub\'s guide search lists Codex matches under its guides; one opens the Lookup section at it', () => {
	const [out] = run(`
		UI.ShowPicker()
		Polestar.UI.Picker.SetQuery("saber"); stub.advance(0.3)
		local body = PolestarPicker.Scroll.Child
		local rows = {}
		for _, r in ipairs(shownRows(body)) do rows[#rows + 1] = r.Title:GetText() .. " | " .. r.Sub:GetText() end
		local empty = PolestarPicker.Empty and PolestarPicker.Empty:IsShown()
		local count = UI.LookupCount()
		rowFor(body, "Frostsaber Provisions"):Click()
		emit({ rows = rows, count = count, empty = empty, picker = PolestarPicker:IsShown(), lookup = lookupShown(), sel = LK.Selected(), query = LK.Query() })`);
	assert.deepEqual(out.rows, [
		'Reins of the Striped Frostsaber | Mount  \u00b7  Vendor \u00b7 Darnassus',
		'Reins of the Spotted Frostsaber | Mount  \u00b7  Vendor \u00b7 Darnassus',
		'Reins of the Winterspring Frostsaber | Mount  \u00b7  Reputation \u00b7 Winterspring',
		'Sabertooth Fang | Item  \u00b7  Drop \u00b7 Stranglethorn Vale',
		'Frostsaber Provisions | Quest  \u00b7  Level 60 \u00b7 Winterspring',
		'Look up everything for \u201csaber\u201d | ',
	]);
	assert.equal(out.count, 5);
	assert.ok(!out.empty, 'no "No guides match" over the Codex rows');
	assert.equal(out.picker, true);
	assert.equal(out.lookup, true);
	assert.deepEqual(out.sel, { kind: 'quest', id: 4970 });
	assert.equal(out.query, 'saber');
});

test('clearing the hub\'s search takes its Codex matches away: none stay drawn over the guide list', () => {
	const [out] = run(`
		UI.ShowPicker()
		Polestar.UI.Picker.SetQuery("saber"); stub.advance(0.3)
		local body = PolestarPicker.Scroll.Child
		local before = rowFor(body, "Frostsaber Provisions") and true or false
		Polestar.UI.Picker.SetQuery(""); stub.advance(0.3)
		local stale = {}
		for _, r in ipairs(shownRows(body)) do
			local t = r.Title and r.Title:GetText() or ""
			if t:find("saber") or t:find("Look up everything") then stale[#stale + 1] = t end
		end
		emit({ before = before, stale = table.concat(stale, " / "), count = UI.LookupCount(), total = UI.LookupTotal() })`);
	assert.equal(out.before, true);
	assert.equal(out.stale, '');
	assert.equal(out.count, 0);
	assert.equal(out.total, 0);
});

test('with the real Search, Codex and Lookup runtime over the sample pack', () => {
	const pack = writeCodexPack(sampleCodex());
	try {
		const [out] = runAddon({
			stubs: ['stub_ui.lua'],
			before: pack.stubLua,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Lookup/Lookup.xml', 'UI/UI.xml'] }],
			script: `uistub.install()\nstub.login()
local LK = Polestar.UI.Lookup
Polestar.Lookup.Show("saber")
local search = { groups = LK.shown.groups, sel = LK.Selected().kind, codex = LK.root.CodexLine:GetText() }
Polestar.Lookup.Show(nil, "mount", 13335)
emit({ search = search, title = LK.detail.title, query = LK.Query(), sources = LK.detail.sources, primary = LK.detail.primary })`,
		}).emitted;
		assert.deepEqual(out.search.groups, [{ kind: 'mount', count: 3, shown: 3 }]);
		assert.equal(out.search.sel, 'mount');
		assert.equal(out.search.codex, '');
		assert.equal(out.title, "Deathcharger's Reins");
		assert.equal(out.query, "Deathcharger's Reins");
		assert.equal(out.sources[0].label, 'Baron Rivendare');
		assert.equal(out.sources[0].facts, '0.1% drop chance');
		assert.equal(out.sources[0].available, false);
		assert.ok(out.sources[0].why, 'says why it is out of reach');
		assert.equal(out.primary, 'Guide me');
	} finally {
		pack.cleanup();
	}
});

test('changing the suggestion source ranks a cached search again', () => {
	const pack = writeCodexPack(sampleCodex());
	try {
		const [before, after] = runAddon({
			stubs: ['stub_ui.lua'],
			before: pack.stubLua,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Lookup/Lookup.xml', 'UI/UI.xml'] }],
			// The real registry: the ranking follows its suggestion source.
			script: `uistub.install()\nPolestar.Guides = uistub.realGuides\nstub.login()
local LK = Polestar.UI.Lookup
${HELPERS}
Polestar.RegisterPack({ addon = "Polestar_Other", id = "other", format = 1, title = "Other", author = "O", version = "1", license = "MIT" })
local function g(id, extra)
	local def = { id = id, pack = "other", title = id, steps = { { goals = { { t = "note", text = "x" } } } } }
	for k, v in pairs(extra) do def[k] = v end
	assert(Polestar.RegisterGuide(def))
end
g("other/sabers", { category = "Collectibles", collects = { 13086 } })
g("other/route", { category = "Leveling", minLevel = 1, maxLevel = 60 })
Polestar.Lookup.Show("frostsaber")
emit(rowTexts(LK.results.Child)[1])
Polestar.Set("behavior.suggestFrom", "other")
emit(rowTexts(LK.results.Child)[1])`,
		}).emitted;
		assert.notEqual(before, 'Reins of the Winterspring Frostsaber');
		assert.equal(after, 'Reins of the Winterspring Frostsaber', 'the source\'s guide collects it: first');
	} finally {
		pack.cleanup();
	}
});

test('a dungeon also opens in the Dungeons section: beside the guide to its entrance, or alone', () => {
	const [out] = run(`
		local opened = {}
		Polestar.Dungeons = { Open = function(key) opened[#opened + 1] = key end }
		table.insert(lookupstub.entities, { kind = "instance", id = "stratholme", title = "Stratholme", subtitle = "Dungeon \\194\\183 45-60" })
		lookupstub.sources["instance:stratholme"] = {
			{ type = "world", src = { type = "world" }, label = "Stratholme", detail = "Entrance \\194\\183 Eastern Plaguelands", map = 1423, x = 27, y = 11, available = true, guideable = true },
		}
		Polestar.Lookup.Show(nil, "instance", "stratholme")
		local both = { primary = LK.detail.primary, secondary = LK.details.Secondary:IsShown() and LK.details.Secondary.Label:GetText() }
		LK.details.Secondary:Click()
		local after = { opened = opened[1], shown = lookupShown() }
		lookupstub.sources["instance:stratholme"] = {}
		Polestar.UI.Lookup.Select(nil)
		Polestar.Lookup.Show(nil, "instance", "stratholme")
		local alone = { primary = LK.detail.primary, secondary = LK.details.Secondary:IsShown() }
		stub.RunScript(Polestar.UI.Picker.search, "OnEnterPressed")
		emit({ both = both, after = after, alone = alone, enter = opened[2] })`);
	assert.deepEqual(out.both, { primary: 'Guide me', secondary: 'Open dungeon' });
	// The Dungeons section takes over the hub itself; Lookup closes nothing.
	assert.deepEqual(out.after, { opened: 'stratholme', shown: true });
	assert.deepEqual(out.alone, { primary: 'Open dungeon', secondary: false });
	assert.equal(out.enter, 'stratholme');
});

test('an empty search lists the recent lookups (newest first, at most 10), never a data set', () => {
	const [out] = run(`
		UI.ShowLookup()
		local first = { rows = #rowTexts(LK.results.Child), empty = LK.shown.empty, queries = lookupstub.queries }
		Polestar.Lookup.Show(nil, "mount", 8631)
		Polestar.Lookup.Show(nil, "mount", 13335)
		-- Typing selects the first result for you: that is no lookup of yours.
		Polestar.UI.Picker.SetQuery("lelanai"); stub.advance(0.3)
		local auto = #LK.Recent()
		-- A click is.
		rowFor(LK.results.Child, "Lelanai"):Click()
		Polestar.UI.Picker.SetQuery(""); stub.advance(0.3)
		local recent = { rows = rowTexts(LK.results.Child), folder = LK.shown.rows, empty = LK.shown.empty, navs = navKeys() }
		for i = 1, 12 do Polestar.Lookup.Show(nil, "mount", 8631 + (i % 2)); Polestar.Lookup.Show(nil, "npc", 10440) end
		emit({ first = first, auto = auto, recent = recent, saved = Polestar.CharState().ui.recentLookups[1].title, n = #LK.Recent() })`);
	assert.equal(out.first.rows, 0);
	assert.match(out.first.empty, /Type a name in the search box/);
	assert.equal(out.first.queries, 0, 'nothing is searched for an empty box');
	assert.equal(out.auto, 2);
	assert.deepEqual(out.recent.rows, ['Lelanai', "Deathcharger's Reins", 'Reins of the Striped Frostsaber']);
	assert.match(out.recent.empty, /Type a name/, 'the hint under the recent lookups');
	assert.deepEqual(out.recent.navs, ['all']);
	assert.equal(out.saved, 'Baron Rivendare');
	assert.ok(out.n <= 10);
});

test('one kind shows a page of 50 and Show more adds the next; only the rows in view are drawn and subtitled', () => {
	const [out] = run(`
		lookupstub.many(120)
		Polestar.Lookup.Show("steed")
		local all = { groups = LK.shown.groups, painted = LK.painted, subtitled = lookupstub.subtitled }
		LK.SetKind("mount")
		local page1 = { rows = LK.shown.rows, painted = LK.painted, more = rowTexts(LK.results.Child)[LK.painted] }
		LK.More()
		local page2 = LK.shown.rows
		LK.More()
		local page3 = { rows = LK.shown.rows, last = rowTexts(LK.results.Child)[LK.painted] }
		emit({ all = all, page1 = page1, page2 = page2, page3 = page3, subtitled = lookupstub.subtitled })`);
	assert.deepEqual(out.all.groups, [{ kind: 'mount', count: 120, shown: 5 }]);
	assert.equal(out.page1.rows, 50);
	assert.ok(out.page1.painted < 30, `drawn ${out.page1.painted} rows, not all 50`);
	assert.equal(out.page2, 100);
	assert.equal(out.page3.rows, 120);
	assert.ok(out.subtitled < 60, `subtitles asked for ${out.subtitled} rows, only those drawn`);
});

test('while the Codex loads the section says so, and searches again once it has', () => {
	const [out] = run(`
		lookupstub.loaded, lookupstub.reason = false, "loading"
		Polestar.Lookup.Show("saber")
		local loading = { empty = LK.shown.empty, codex = LK.root.CodexLine:GetText(), rows = #rowTexts(LK.results.Child) }
		lookupstub.loaded, lookupstub.reason = true, nil
		Polestar.Fire("CODEX_LOADED", {})
		emit({ loading = loading, rows = LK.shown.rows, empty = LK.shown.empty or false })`);
	assert.equal(out.loading.empty, 'Loading the Codex\u2026');
	assert.equal(out.loading.codex, 'Loading the Codex\u2026');
	assert.equal(out.loading.rows, 0);
	assert.ok(out.rows > 0, 'the search ran again');
	assert.equal(out.empty, false);
});

// A French client whose names pack lands with results up: the search runs
// again and the rows take the client's names.
test('a names pack landing late searches again and the rows take the new names', () => {
	const [out] = run(`
		Polestar.Lookup.Show("lelanai")
		local before = rowTexts(LK.results.Child)
		for _, e in ipairs(lookupstub.entities) do if e.id == 4730 then e.title = "Lelanai la dresseuse" end end
		Polestar.Fire("NAMES_LOADED")
		emit({ before = before, after = rowTexts(LK.results.Child) })`);
	assert.ok(out.before.some((t) => t.startsWith('Lelanai') && !t.includes('dresseuse')));
	assert.ok(out.after.some((t) => t.includes('Lelanai la dresseuse')));
});

test('Lookup turned off in Options: guides only, the section says where to turn it on, nothing loads the Codex', () => {
	const [out] = run(`
		lookupstub.loaded, lookupstub.reason = false, "off"
		local loads = 0
		Polestar.Codex.Load = function() loads = loads + 1; return false, "off" end
		UI.ShowLookup()
		local idle = { title = LK.detail.empty, note = LK.detail.note, codex = LK.root.CodexLine:GetText() }
		Polestar.UI.Picker.SetQuery("saber"); stub.advance(0.3)
		local none = LK.shown.empty
		Polestar.Lookup.Show(nil, "mount", 8631)
		emit({ idle = idle, none = none, loads = loads })`);
	assert.equal(out.idle.title, 'Lookup is turned off');
	assert.match(out.idle.note, /Options > Discovery > Lookup/);
	assert.equal(out.idle.codex, 'Lookup is off: searching guides only');
	assert.match(out.none, /Nothing matches .saber.\. Lookup is turned off in Options > Discovery > Lookup/);
	assert.equal(out.loads, 0);
});
