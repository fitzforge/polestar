'use strict';
// The hub's Home (addon/Polestar/UI/Picker.lua), "resume first": the header
// says "Guides" and the character, the active tab is a wide card over its
// zone art with its full name, its current step, a progress line, Continue
// (one click back into the tab) and a ··· tab menu; the other tabs are rows
// with a small bar, three until "Show all N" on their label; the suggestions
// say why they are listed; the details pane follows Home (its top
// suggestion), while Browse keeps the last guide selected; a new character
// gets "Start here", the other guides for the level and buttons into the
// categories and Import; a name cut short reads whole in its tooltip; and
// Special thanks keeps the header's top right on every page. Against the real Core, Theme and UI
// and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];
const WESTFALL = 'forever/alliance/02-westfall';
const DARKSHORE = 'forever/alliance/03-darkshore';
const COOKING = 'forever/professions/cooking';
const EXPLORE = 'forever/exploration/eastern-kingdoms-1-30';
const LONG = 'test/alliance/long-name';

// A guide whose name and route run long: its title past any card's room, its
// goals over a dozen zones.
// Fourteen zones of one quest step each; Westfall five steps more (six: it
// quests there), Ashenvale five more of which one is a mage's (five for this
// warrior: it passes through).
const LONG_GUIDE = `
do
	local maps = { 1453, 1426, 1436, 1411, 1412, 1413, 1454, 1456, 1420, 1421, 1424, 1442, 1440, 1441 }
	local steps = {}
	for i, m in ipairs(maps) do
		steps[i] = { title = "Leg " .. i, goals = { { t = "accept", quest = 9000 + i, map = m, status = "pending", text = "Accept" } } }
	end
	for i = 1, 5 do
		steps[#steps + 1] = { title = "Westfall " .. i, goals = { { t = "turnin", quest = 9003, map = 1436, status = "pending", text = "Turn in" } } }
	end
	for i = 1, 5 do
		steps[#steps + 1] = { title = "Ashenvale " .. i, only = i == 1 and { classes = { "MAGE" } } or nil,
			goals = { { t = "kill", quest = 9100 + i, map = 1440, status = "pending", text = "Kill" } } }
	end
	uistub.guides[${JSON.stringify(LONG)}] = { id = ${JSON.stringify(LONG)}, pack = "guides",
		title = "The Long Road Through Every Kingdom Of The Eastern Continent And Back Again", faction = "Alliance",
		minLevel = 1, maxLevel = 20, category = "Leveling", zone = 1453, zoneName = "Stormwind City", author = "Polestar", version = 1, steps = steps }
	table.insert(uistub.order, ${JSON.stringify(LONG)})
end`;

function run(script, before = '') {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()
stub.login()
${before}
local UI = Polestar.UI
local P = UI.Picker
local F
local function open() UI.ShowPicker(); F = PolestarPicker end
local function shownRows()
	local out = {}
	for _, f in ipairs({ F.Body:GetChildren() }) do
		if f:IsShown() and rawget(f, "psGuide") and not rawget(f, "Front") and rawget(f, "Note") then
			local _, _, _, _, y = f:GetPoint(1)
			out[#out + 1] = { y = -y, title = f.Title:GetText(), note = f.Note:GetText(), h = f:GetHeight(),
				icon = f.Icon:IsShown(), rule = f.Rule:IsShown(), bar = f.Mini:IsShown(), pct = f.Pct:IsShown() and f.Pct:GetText() or false,
				index = rawget(f, "psIndex") or false, sel = f.Selected:IsShown() }
		end
	end
	table.sort(out, function(a, b) return a.y < b.y end)
	return out
end
local function labels()
	local out = {}
	for _, f in ipairs({ F.Body:GetChildren() }) do
		if f:IsShown() and rawget(f, "Chevron") and rawget(f, "Rule") and not rawget(f, "psGuide") then
			local _, _, _, _, y = f:GetPoint(1)
			out[#out + 1] = { y = -y, text = f.Text:GetText(), count = f.Count:GetText(), h = f:GetHeight() }
		end
	end
	table.sort(out, function(a, b) return a.y < b.y end)
	return out
end
local function tip(frame)
	GameTooltip.lines = {}
	GameTooltip:Hide()
	stub.RunScript(frame, "OnEnter")
	local lines = GameTooltip:IsShown() and GameTooltip.lines or {}
	stub.RunScript(frame, "OnLeave")
	return lines
end
${script}`,
	}).emitted;
}

const BUSY = `uistub.openTabs({ { ${JSON.stringify(WESTFALL)}, 3 }, { uistub.elwynn, 5 }, { ${JSON.stringify(DARKSHORE)}, 2 }, { uistub.tailoring, 1 }, { ${JSON.stringify(COOKING)}, 1 } }, 2)`;

test('the header names the section and the character, not Home again', () => {
	const [busy, fresh] = run(`
		${BUSY}
		open()
		local a = { title = F.Title:GetText(), sub = F.Subtitle:GetText() }
		uistub.setGuide(nil)
		P.Recent()[1] = nil
		P.Render()
		emit(a)
		emit({ title = F.Title:GetText(), sub = F.Subtitle:GetText() })`);
	assert.deepEqual(busy, { title: 'Guides', sub: 'Level 4 Alliance  ·  5 open' });
	assert.deepEqual(fresh, { title: 'Guides', sub: 'Level 4 Alliance  ·  pick your first guide' });
});

test('the active tab is a card over its zone art: its name, its step, its progress, Continue and the tab menu', () => {
	const [out] = run(`
		${BUSY}
		open()
		local c = P.hero
		local _, _, _, x, y = c:GetPoint(1)
		local card = { shown = c:IsShown(), x = x, y = -y, w = c:GetWidth(), h = c:GetHeight(), eyebrow = c.Eyebrow:GetText(),
			title = c.Title:GetText(), range = c.Range:GetText(), step = c.Step:GetText(), pct = c.Pct:GetText(), go = c.Go.Label:GetText(),
			more = c.More:IsShown(), line = c.Line:IsShown(), art = c.Art:IsShown(), primary = rawget(c.Go, "psPrimary") == true }
		-- The tab menu under the ··· button.
		stub.RunScript(c.More, "OnClick")
		local menu = {}
		for _, it in ipairs(stub.lastMenu or {}) do menu[#menu + 1] = it.text end
		-- Continue: back into the tab, the guide window shown, the hub closed.
		uistub.calls = {}
		c.Go:Click()
		local calls = {}
		for _, call in ipairs(uistub.calls) do calls[#calls + 1] = call[1] .. "(" .. tostring(call[2]) .. ")" end
		emit({ card = card, menu = menu, calls = calls, hubShown = F:IsShown(), shownSetting = Polestar.Get("ui.shown") })`,
		// The menu's items, as W.ShowMenu is handed them.
		`Polestar.Widgets.ShowMenu = function(anchor, items) stub.lastMenu = items end`);
	assert.deepEqual(out.card, {
		shown: true, x: 32, y: 16, w: 506 - 64, h: 114, eyebrow: 'TAB 2  ·  ACTIVE', title: 'Elwynn Forest', range: '(1–13)',
		step: 'Step 5 of 8: Goldshire', pct: out.card.pct, go: 'Continue', more: true, line: true, art: true, primary: true,
	});
	assert.match(out.card.pct, /^\d+%$/);
	assert.deepEqual(out.menu, ['Close tab', 'Move left', 'Move right']);
	assert.deepEqual(out.calls, ['SelectTab(2)'], 'one click back into tab 2');
	assert.equal(out.hubShown, false);
	assert.equal(out.shownSetting, true);
});

test('the other tabs are compact rows with a small bar, three until "Show all N" on their label', () => {
	const [out] = run(`
		${BUSY}
		open()
		local before = { rows = shownRows(), labels = labels(), more = F.CardsMore:IsShown() and F.CardsMore.Label:GetText() }
		F.CardsMore:Click()
		local after = { rows = shownRows(), more = F.CardsMore.Label:GetText() }
		emit({ before = before, after = after })`);
	const tabsRows = out.before.rows.filter((r) => r.index);
	assert.deepEqual(tabsRows.map((r) => r.title), ['Westfall', 'Darkshore', 'Tailoring 1-300']);
	assert.deepEqual(tabsRows.map((r) => r.note), ['Tab 1', 'Tab 3', 'Tab 4']);
	for (const r of tabsRows) {
		assert.equal(r.h, 36);
		assert.ok(r.icon && r.bar, 'a glyph and a small bar');
		assert.match(r.pct, /^\d+%$/);
	}
	assert.deepEqual(tabsRows.map((r) => r.rule), [false, true, true], 'a hairline between rows');
	const [other] = out.before.labels;
	assert.deepEqual({ text: other.text, count: other.count, h: other.h }, { text: 'Other tabs', count: '4', h: 16 });
	assert.equal(other.y, 16 + 114 + 24, '24 under the card');
	assert.equal(tabsRows[0].y, other.y + 16 + 8, '8 under the label');
	assert.equal(out.before.more, 'Show all 4');
	assert.equal(out.after.rows.filter((r) => r.index).length, 4);
	assert.equal(out.after.more, 'Show fewer');
});

test('suggestions say why they are listed: the level they fit, or the open tab they follow', () => {
	const [out] = run(`
		uistub.player.level = 15
		uistub.suggestions = { ${JSON.stringify(EXPLORE)}, ${JSON.stringify(WESTFALL)} }
		uistub.openTabs({ { ${JSON.stringify(WESTFALL)}, 3 } }, 1)
		open()
		local l = labels()
		emit({ rows = shownRows(), labels = l })`);
	// The top suggestion is the Play next card (its reason is the card's); the rest stay rows.
	const sugg = out.rows.filter((r) => !r.index);
	assert.deepEqual(sugg.map((r) => [r.title, r.note]), [
		['Westfall', 'Tab 1'],
		['Darkshore', 'After Westfall'],
	]);
	assert.equal(out.labels.at(-1).text, 'Also for level 15');
});

// 900: no room for a note beside the chip, so it is left out; 1000: room for a cut one.
for (const [narrow, kept] of [[900, false], [1000, true]]) test(`a suggestion with a Group chip and a long note: nothing overlaps, the note gives way first (pickerW ${narrow})`, () => {
	const [out] = run(`
		uistub.guides[${JSON.stringify(LONG)}].next = uistub.elwynn
		uistub.guides[uistub.elwynn].group = true
		uistub.suggestions = { ${JSON.stringify(EXPLORE)} }
		uistub.openTabs({ { ${JSON.stringify(LONG)}, 1 } }, 1)
		-- A narrow list pane, as the menu scaled up leaves it.
		local metric = Polestar.Theme.Metric
		Polestar.Theme.Metric = function(k, d) if k == "pickerW" then return ${narrow} end return metric(k, d) end
		open()
		local row
		for _, f in ipairs({ F.Body:GetChildren() }) do
			if f:IsShown() and rawget(f, "psGuide") and f.psGuide.id == uistub.elwynn and rawget(f, "Note") and not rawget(f, "Front") then row = f end
		end
		local textX = 20
		local chipRight = textX + 24 + row.Title:GetWidth() + 5 + row.Range:GetStringWidth() + 6 + row.Group:GetWidth()
		emit({ chip = row.Group:IsShown(), chipRight = chipRight, noteLeft = row:GetWidth() - textX - row.Note:GetWidth(),
			noteW = row.Note:GetWidth(), titleW = row.Title:GetWidth(), full = row.Title:GetUnboundedStringWidth(),
			note = row.Note:GetText() })`, LONG_GUIDE);
	assert.ok(out.chip, 'the chip is drawn');
	assert.equal(out.note.startsWith('After The Long Road'), kept, out.note);
	assert.ok(out.chipRight <= out.noteLeft, `chip ends at ${out.chipRight}, note starts at ${out.noteLeft}`);
	assert.ok(out.titleW >= Math.min(out.full, 120), 'the title keeps a readable width');
	assert.ok(kept ? out.noteW >= 24 : out.noteW === 0, 'the note is cut, or left out when it has no room');
});

test('on Home the details show the top suggestion; Browse keeps the last guide selected', () => {
	const [out] = run(`
		uistub.suggestions = { uistub.elwynn, ${JSON.stringify(EXPLORE)} }
		uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
		open()
		P.SetCategory("Reputation")
		P.Select(uistub.stormwindRep)
		local browse = P.details.Title:GetText()
		P.SetView("home")
		local home = { title = P.details.Title:GetText(), sel = P.Selected() }
		local top
		for _, r in ipairs(shownRows()) do if r.sel then top = r.title end end
		-- A line picked on Home leads the pane until Home is left.
		for _, f in ipairs({ F.Body:GetChildren() }) do
			if f:IsShown() and rawget(f, "psGuide") and f.psGuide.id == uistub.elwynn and rawget(f, "Note") and not rawget(f, "Front") then f:Click() end
		end
		local picked = P.details.Title:GetText()
		P.SetView("browse")
		local back = P.details.Title:GetText()
		P.SetView("home")
		emit({ browse = browse, home = home, top = top, picked = picked, back = back, again = P.details.Title:GetText() })`);
	assert.equal(out.browse, 'Stormwind Reputation');
	assert.deepEqual(out.home, { title: 'Exploration: Eastern Kingdoms 1-30', sel: EXPLORE }, 'the top suggestion not open in a tab');
	assert.equal(out.top, 'Exploration: Eastern Kingdoms 1-30', 'its row is the selected one');
	assert.equal(out.picked, 'Elwynn Forest');
	assert.equal(out.back, 'Elwynn Forest', 'Browse shows the last guide selected');
	assert.equal(out.again, 'Exploration: Eastern Kingdoms 1-30', 'back on Home, the top suggestion again');
});

test('a new character: Start here with Load guide, the other guides for the level, then Leveling, Class, Professions and Import', () => {
	const [out] = run(`
		uistub.suggestions = { uistub.elwynn, ${JSON.stringify(EXPLORE)}, "forever/legacy/legacy-challenges" }
		open()
		local c = P.hero
		local acts = {}
		for _, f in ipairs({ F.Body:GetChildren() }) do
			if f:IsShown() and rawget(f, "psGo") then
				local _, _, _, x, y = f:GetPoint(1)
				acts[#acts + 1] = { x = x, y = -y, text = f.Label:GetText(), count = f.Count:IsShown() and f.Count:GetText() or false }
			end
		end
		table.sort(acts, function(a, b) return a.y < b.y or (a.y == b.y and a.x < b.x) end)
		local out = { eyebrow = c.Eyebrow:GetText(), title = c.Title:GetText(), step = c.Step:GetText(), meta = c.Meta:GetText(),
			go = c.Go.Label:GetText(), more = c.More:IsShown(), line = c.Line:IsShown(), rows = shownRows(), labels = labels(), acts = acts,
			details = P.details.Title:GetText() }
		uistub.calls = {}
		c.Go:Click()
		out.calls = {}
		for _, call in ipairs(uistub.calls) do out.calls[#out.calls + 1] = call[1] .. "(" .. tostring(call[2]) .. ")" end
		emit(out)`);
	assert.equal(out.eyebrow, 'START HERE');
	assert.equal(out.title, 'Elwynn Forest');
	assert.equal(out.step, "The leveling guide for your race's starting zone.");
	assert.match(out.meta, /^\d+ steps(  ·  \d+ quests?)?$/);
	assert.equal(out.go, 'Load guide');
	assert.ok(!out.more && !out.line, 'no tab menu, no progress');
	assert.deepEqual(out.labels.map((l) => l.text), ['Also for level 4', 'Find more']);
	assert.deepEqual(out.rows.map((r) => [r.title, r.note]), [
		['Exploration: Eastern Kingdoms 1-30', 'Fits level 4'],
		['Legacy Challenges', 'Fits level 4'],
	]);
	assert.deepEqual(out.acts.map((a) => [a.text, a.count]), [['Leveling', '6'], ['Professions', '3'], ['Import', false]],
		'the categories with guides for this character (the scenes have no Class guide), then Import');
	assert.ok(out.acts.every((a) => a.x >= 32), 'on the text column');
	const find = out.labels.find((l) => l.text === 'Find more');
	assert.equal(out.acts[0].y, find.y + 16 + 8);
	assert.equal(out.details, 'Elwynn Forest', 'the pane shows the card\'s guide, Load guide one click away');
	assert.deepEqual(out.calls, [`SetGuide(${'forever/alliance/human/01-elwynn-forest'})`]);
});

test('a name cut short reads whole in its tooltip: the tab card, a row, the Passes through fact and a community pack in the sidebar', () => {
	const [out] = run(`
		uistub.suggestions = { ${JSON.stringify(LONG)}, uistub.elwynn }
		uistub.openTabs({ { ${JSON.stringify(LONG)}, 2 }, { uistub.elwynn, 1 } }, 1)
		open()
		local c = P.hero
		local card = { cut = c.Title:IsTruncated(), w = c.Title:GetWidth(), tip = tip(c) }
		local row
		for _, f in ipairs({ F.Body:GetChildren() }) do
			if f:IsShown() and rawget(f, "psGuide") and f.psGuide.id == ${JSON.stringify(LONG)} and rawget(f, "Note") and not rawget(f, "Front") then row = f end
		end
		local rowOut = { cut = row.Title:IsTruncated(), tip = tip(row) }
		local short
		for _, f in ipairs({ F.Body:GetChildren() }) do
			if f:IsShown() and rawget(f, "psGuide") and f.psGuide.id == uistub.elwynn and rawget(f, "Note") and not rawget(f, "Front") then short = f end
		end
		local shortTip = tip(short)
		-- The Quests in and Passes through facts.
		P.Select(${JSON.stringify(LONG)})
		local facts = {}
		for _, f in ipairs(P.details.Facts) do
			if f.Label:IsShown() then facts[f.Label:GetText()] = { text = f.Value:GetText(), hit = f.Hit:IsShown(), tip = tip(f.Hit) } end
		end
		local zones, questsIn = facts["Passes through"], facts["Quests in"]
		-- A community pack's row in the sidebar: one line, its name whole on hover.
		local W = Polestar.Widgets
		W.ShellNav(F, { { key = "pack:x", label = "A Very Long Community Pack Title" .. "  \\194\\183  " .. "Its Author", icon = "layers", count = 3, oneLine = true },
			{ key = "pack:y", label = "Short", icon = "layers", count = 1, oneLine = true } }, nil, function() end)
		local long, small = F.navButtons[1], F.navButtons[2]
		emit({ card = card, row = rowOut, shortTip = shortTip, zones = zones, questsIn = questsIn,
			pack = { wrap = long.Label:GetWordWrap(), cut = long.Label:IsTruncated(), tip = tip(long), shortTip = tip(small) } })`, LONG_GUIDE);
	const name = 'The Long Road Through Every Kingdom Of The Eastern Continent And Back Again';
	assert.ok(out.card.cut, 'the card title is cut');
	assert.ok(out.card.w < 442, 'within the card');
	assert.equal(out.card.tip[0], `${name} (1–20)`);
	assert.ok(out.row.cut);
	assert.equal(out.row.tip[0], `${name} (1–20)`);
	assert.notEqual(out.shortTip[0], 'Elwynn Forest (1–13)', 'a whole name keeps its plain tooltip');
	assert.ok(out.zones && out.zones.hit, 'the Passes through fact is cut and takes the mouse');
	assert.ok(out.zones.text.endsWith('…'), out.zones.text);
	assert.equal(out.zones.tip[0], 'Passes through');
	assert.ok(!out.zones.tip[1].includes('…'));
	// Quests in: the one zone with six quest steps for this character, whole; the
	// other thirteen, Ashenvale's five warrior steps among them, in route order under Passes through.
	assert.equal(out.questsIn.text, 'Westfall');
	assert.equal(out.questsIn.hit, false, 'a whole value has no tooltip');
	const passes = out.zones.tip[1].split(' › ');
	assert.equal(passes.length, 13, out.zones.tip[1]);
	assert.ok(!passes.includes('Westfall'), out.zones.tip[1]);
	assert.equal(out.zones.text.split(' › ')[0], passes[0], 'route order, from the first zone');
	assert.equal(out.pack.wrap, false);
	assert.ok(out.pack.cut);
	assert.deepEqual(out.pack.tip, ['A Very Long Community Pack Title  ·  Its Author']);
	assert.ok(!out.pack.shortTip.length, 'a name that fits has no tooltip');
});

// A zone is under Quests in when the title names it (the guide writer's rule: its quest goals) or six steps
// carry a quest goal there for this character; the rest under Passes through, in route order.
const TITLED_GUIDE = `
do
	local steps = {}
	local function leg(map, n)
		for i = 1, n do
			steps[#steps + 1] = { title = "Leg " .. #steps, goals = { { t = "accept", quest = 9500 + #steps, map = map, status = "pending", text = "Accept" } } }
		end
	end
	leg(1441, 2) -- not in the title, two steps: passes through
	leg(1421, 1) -- "Silverpine & Elwynn Forest" names Silverpine Forest: quests in
	leg(1426, 6) -- not in the title, six steps: quests in
	leg(1440, 1) -- in the title: quests in
	leg(1420, 5) -- not in the title, five steps: passes through
	uistub.guides["test/alliance/titled"] = { id = "test/alliance/titled", pack = "guides", title = "Silverpine & Elwynn Forest, Ashenvale & Stranglethorn",
		faction = "Alliance", minLevel = 1, maxLevel = 20, category = "Leveling", zone = 1421, zoneName = "Silverpine Forest", author = "Polestar", version = 1, steps = steps }
	table.insert(uistub.order, "test/alliance/titled")
end`;

test('Quests in: the zones the title names and those with six quest steps; Passes through the rest, in route order', () => {
	const [out] = run(`
		uistub.suggestions = { "test/alliance/titled", uistub.elwynn }
		open()
		P.Select("test/alliance/titled")
		local facts = {}
		for _, f in ipairs(P.details.Facts) do
			if f.Label:IsShown() then facts[f.Label:GetText()] = f.Value:GetText() end
		end
		emit(facts)`, TITLED_GUIDE);
	assert.equal(out['Quests in'], 'Silverpine Forest › Dun Morogh › Ashenvale');
	assert.equal(out['Passes through'], 'Thousand Needles › Tirisfal Glades');
});

test('Special thanks is in the header on Home and every page, a new name each time the window opens; the hub is built on first open, not at login', () => {
	const [out] = run(`
		local before = PolestarPicker ~= nil
		Polestar.Credits = { supporters = { "Ann", "Bo", "Cy" }, contributors = {}, bugReporters = {}, translators = {}, ideas = {} }
		${BUSY}
		open()
		local t = F.ThanksLink
		local function at()
			local p, rel, rp, x, y = t:GetPoint(1)
			return { shown = t:IsShown(), header = rel == F.Header, p = p, rp = rp, x = x, y = y, name = t.Name:GetText() }
		end
		local home = at()
		P.SetView("browse")
		local browse = at()
		local names = { home.name }
		for i = 1, 4 do
			F:Hide()
			open()
			names[#names + 1] = t.Name:GetText()
		end
		emit({ before = before, home = home, browse = browse, names = names })`);
	assert.equal(out.before, false, 'no hub frame at login');
	for (const v of [out.home, out.browse]) {
		assert.deepEqual([v.shown, v.header, v.p, v.rp, v.x, v.y], [true, true, 'RIGHT', 'TOPRIGHT', -32, -26], JSON.stringify(v));
	}
	for (let i = 1; i < out.names.length; i++) assert.notEqual(out.names[i], out.names[i - 1], `a new name each open: ${out.names}`);
});

test('Home reads right in the game looks, Hearth and Halo too', () => {
	for (const skin of ['blizzard', 'hearth', 'halo']) {
		const [out] = run(`
			Polestar.Set("ui.skin", ${JSON.stringify(skin)})
			${BUSY}
			open()
			local c = P.hero
			emit({ skin = Polestar.Theme.SkinKey(), card = c:IsShown(), go = c.Go:IsShown(), rows = #shownRows() })`);
		assert.equal(out.skin, skin);
		assert.equal(out.card, true, skin);
		assert.equal(out.go, true, skin);
		assert.ok(out.rows >= 4, `${skin}: ${out.rows} rows`);
	}
});
