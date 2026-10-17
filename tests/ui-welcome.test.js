'use strict';
// The welcome (addon/Polestar/UI/Welcome.lua) against the real Core + Theme +
// UI manifests and the fake Engine of tests/lua/stub_ui.lua: once per new
// character (PolestarCharDB.welcomeSeen = 1), with setup and the route
// style only while the account has not had one (PolestarDB.welcomeSeen = 1);
// never in combat, never during a cinematic, never over the route choice;
// four pages (welcome, setup, route, start; two for a later character) with
// step dots; setup choices that write their settings, the scheme cards
// applying live; the route style's cards setting nav.routeStyle; a start
// page that names the suggested guide for the character, the beta callout
// while the routes are in beta, the Discord invite and guide packs; opened
// from About and by /polestar welcome.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

// Saved variables: an account that has had its welcome, a character Polestar
// knew before the welcome had a flag, one that has seen it, one still due.
const ACCOUNT_SEEN = 'PolestarDB = { schema = 1, settings = {}, welcomeSeen = 1 }';
const ACCOUNT_NEW = 'PolestarDB = { schema = 1, settings = {} }';
const CHAR_KNOWN = 'PolestarCharDB = { schema = 1 }';
const CHAR_SEEN = 'PolestarCharDB = { schema = 1, welcomeSeen = 1 }';
const CHAR_DUE = 'PolestarCharDB = { schema = 1, welcomeSeen = 0 }';

// uistub.install marks the welcome seen for every other UI test; here the
// account and the character keep what their saved variables (and the addon
// loading) made of them.
function run(script, opts = {}) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		saved: opts.saved && { Polestar: opts.saved },
		script: `local savedSeen = PolestarDB and PolestarDB.welcomeSeen
local savedChar = PolestarCharDB and PolestarCharDB.welcomeSeen
uistub.install()
Polestar.DB().welcomeSeen = savedSeen
Polestar.CharState().welcomeSeen = savedChar
${opts.before || ''}
stub.login()
local Wel = Polestar.UI.Welcome
function shown() return PolestarWelcome ~= nil and PolestarWelcome:IsShown() end
function title() return (select(4, Wel.Page())) end
function key() return (Wel.Page()) end
-- "2 of 4": the page's place, as the step dots show it.
function step() local _, at, n = Wel.Page(); return at .. " of " .. n end
-- The dots: how many show, which one is the accent capsule.
function dots()
	local n, on = 0, nil
	for i, d in ipairs(PolestarWelcome.Dots.list) do
		if d:IsShown() then
			n = n + 1
			if d.psOn then on = i end
		end
	end
	return n .. ":" .. tostring(on)
end
function titles()
	local out = {}
	repeat
		out[#out + 1] = title()
		if not PolestarWelcome.Next:IsShown() then break end
		PolestarWelcome.Next:Click()
	until not shown() or #out > 6
	return out
end
function plain(s) return (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
${script}`,
	}).emitted;
}

test('a new character sees the welcome once, shortly after login; opening it marks the character, closing it the account', () => {
	const [out] = run(`
		local atLogin = shown()
		stub.advance(3)
		local after = shown()
		local first = title()
		local at = { step = step(), dots = dots() }
		local open = { char = PolestarCharDB.welcomeSeen, account = PolestarDB.welcomeSeen or false }
		PolestarWelcome.Skip:Click()
		emit({ atLogin = atLogin, after = after, first = first, at = at, open = open, closed = not shown(),
			char = PolestarCharDB.welcomeSeen, account = PolestarDB.welcomeSeen })`);
	assert.deepEqual(out, { atLogin: false, after: true, first: 'Hello, Testchar', at: { step: '1 of 4', dots: '4:1' },
		open: { char: 1, account: false }, closed: true, char: 1, account: 1 },
	'a reload or logout with it still up does not show it again');
});

test('a character with saved data and no flag never gets it unasked, even on an account that never saw it', () => {
	const [out] = run('stub.advance(10)\nemit({ shown = shown(), char = PolestarCharDB.welcomeSeen, account = PolestarDB.welcomeSeen or false })', {
		saved: `${ACCOUNT_NEW}\n${CHAR_KNOWN}`,
	});
	assert.deepEqual(out, { shown: false, char: 1, account: false });
});

test('a later login of a character that has seen it does not show it', () => {
	const [out] = run('stub.advance(10)\nemit({ shown = shown() })', { saved: `${ACCOUNT_SEEN}\n${CHAR_SEEN}` });
	assert.equal(out.shown, false);
});

test('a new character on an account that has had its welcome gets it without setup or the route style; /polestar welcome shows every page', () => {
	const [out] = run(`
		stub.advance(3)
		local login = titles()
		local loginDots = dots()
		SlashCmdList.POLESTAR("welcome")
		local asked = titles()
		emit({ login = login, loginDots = loginDots, asked = asked, askedDots = dots(), char = PolestarCharDB.welcomeSeen })`, { saved: ACCOUNT_SEEN });
	assert.deepEqual(out.login, ['Hello, Testchar', 'Elwynn Forest']);
	assert.equal(out.loginDots, '2:2');
	assert.deepEqual(out.asked, ['Hello, Testchar', 'Make it yours', 'Route style', 'Elwynn Forest']);
	assert.equal(out.askedDots, '4:4');
	assert.equal(out.char, 1);
});

test('a due welcome that never opened shows at the next login', () => {
	const [out] = run('stub.advance(3)\nemit({ shown = shown() })', { saved: `${ACCOUNT_SEEN}\n${CHAR_DUE}` });
	assert.equal(out.shown, true);
});

test('an account that saw the old beta notice still gets the welcome on a new character, and the old flag goes', () => {
	const [out] = run('stub.advance(3)\nemit({ shown = shown(), old = PolestarDB.betaNoticeSeen or false })', {
		saved: 'PolestarDB = { schema = 1, settings = {}, betaNoticeSeen = true }',
	});
	assert.deepEqual(out, { shown: true, old: false });
});

test('the first page greets the character by name, says what Polestar does and shows its three parts', () => {
	const [out] = run(`
		Wel.Show()
		local F = PolestarWelcome
		local named = title()
		local parts = {}
		for _, s in ipairs({ "The guide window", "The arrow", "Every guide", "/polestar guides", "Goals tick off as you play.",
			"Leveling guides for World of Warcraft: Forever", "who to talk to" }) do
			parts[s] = uistub.findText(F, s) ~= nil
		end
		F:Hide()
		uistub.player = {}
		Wel.Show()
		emit({ named = named, parts = parts, anonymous = title() })`);
	assert.equal(out.named, 'Hello, Testchar');
	assert.equal(out.anonymous, 'Welcome to Polestar', 'without a name');
	for (const [part, found] of Object.entries(out.parts)) assert.equal(found, true, part);
});

test('the start page names the suggested guide on its painting, for this character, leaving out what is unknown', () => {
	const [out] = run(`
		local g = uistub.guides[uistub.suggest]
		local function facts() return plain(PolestarWelcome.pages.start.Hero.For:GetText()) end
		local function again() PolestarWelcome:Hide(); Wel.Show("start"); return facts() end
		Wel.Show("start")
		local h = PolestarWelcome.pages.start.Hero
		local first = { title = title(), chip = h.Chip:IsShown() and h.Chip.Text:GetText(), facts = facts(),
			start = PolestarWelcome.Start.Label:GetText() }
		g.title = "First Steps"
		local other = again()
		uistub.player = { name = "Testchar", level = 7 }
		local levelOnly = again()
		uistub.player = {}
		Polestar.Compat.GetZoneText = function() return nil end
		local nothing = again()
		uistub.suggest = nil
		local none = again()
		emit({ first = first, other = other, levelOnly = levelOnly, nothing = nothing,
			none = { title = title(), facts = none, chip = h.Chip:IsShown(), start = PolestarWelcome.Start.Label:GetText() } })`);
	assert.deepEqual(out.first, { title: 'Elwynn Forest', chip: 'Levels 1\u201313',
		facts: 'Your first guide, for your level 4 Human Warrior', start: 'Start guide' }, 'a guide named for the zone already says where');
	assert.equal(out.other, 'Your first guide, for your level 4 Human Warrior in Elwynn Forest');
	assert.equal(out.levelOnly, 'Your first guide, for your level 7 character in Elwynn Forest');
	assert.equal(out.nothing, 'Your first guide');
	assert.deepEqual(out.none, { title: 'Choose your first guide', facts: 'Polestar has no guide to suggest for where you are.',
		chip: false, start: 'Choose a guide' });
});

test('the ✕ and Escape close it and mark it seen too', () => {
	const [out] = run(`
		stub.advance(3)
		PolestarWelcome.Close:Click()
		local x = { closed = not shown(), seen = PolestarCharDB.welcomeSeen }
		PolestarCharDB.welcomeSeen = 0
		Wel.Show()
		local special = false
		for _, n in ipairs(UISpecialFrames) do if n == "PolestarWelcome" then special = true end end
		PolestarWelcome:Hide()
		emit({ x = x, special = special, seen = PolestarCharDB.welcomeSeen })`);
	assert.deepEqual(out, { x: { closed: true, seen: 1 }, special: true, seen: 1 });
});

test('in combat it waits for the fight to end', () => {
	const [out] = run(`
		stub.advance(3)
		local during = { shown = shown(), char = PolestarCharDB.welcomeSeen }
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ during = during, after = shown(), seen = PolestarDB.welcomeSeen or false })`, { before: 'stub.inCombat = true' });
	assert.deepEqual(out, { during: { shown: false, char: 0 }, after: true, seen: false });
});

// A new character's first login plays the intro cinematic. As it starts, the
// client's CinematicFrame opens as a full-screen panel: CloseAllWindows hides
// every special window (the welcome is one) and the UI hides until it ends.
const CINEMATIC = `
function InCinematic() return stub.cinematic == true end
function cinematic(on)
	stub.cinematic = on
	if on then
		for _, name in ipairs(UISpecialFrames) do local f = _G[name]; if f and f:IsShown() then f:Hide() end end
		stub.fire("CINEMATIC_START", true, 0)
	else
		stub.fire("CINEMATIC_STOP")
	end
end`;

test('the intro cinematic does not use it up: closed as the cinematic starts, it comes back on the same page after it', () => {
	const [out] = run(`
		stub.advance(3)
		PolestarWelcome.Next:Click()
		local before = { shown = shown(), step = step() }
		cinematic(true)
		stub.advance(5)
		local during = { shown = shown(), account = PolestarDB.welcomeSeen or false }
		cinematic(false)
		stub.advance(2)
		emit({ before = before, during = during, after = shown(), step = step(), key = key(),
			account = PolestarDB.welcomeSeen or false })`, { before: CINEMATIC });
	assert.deepEqual(out, {
		before: { shown: true, step: '2 of 4' },
		during: { shown: false, account: false },
		after: true, step: '2 of 4', key: 'setup', account: false,
	});
});

test('a cinematic playing when the welcome is due holds it until the cinematic ends', () => {
	const [out] = run(`
		cinematic(true)
		stub.advance(3)
		local during = { shown = shown(), char = PolestarCharDB.welcomeSeen }
		cinematic(false)
		stub.advance(2)
		emit({ during = during, after = shown(), first = title(), char = PolestarCharDB.welcomeSeen })`, { before: CINEMATIC });
	assert.deepEqual(out, { during: { shown: false, char: 0 }, after: true, first: 'Hello, Testchar', char: 1 });
});

test('it never opens over the route choice: it waits for that window to close, and steps aside if one opens', () => {
	const [out] = run(`
		local E = Polestar.Engine
		E.GetRouteChoice = function(id)
			return { from = id, options = { { id = "a", title = "A", recommended = true }, { id = "b", title = "B" } } }
		end
		E.PendingRouteChoice = function() return "x" end
		local RC = Polestar.UI.RouteChoice
		Polestar.Fire("ROUTE_CHOICE", "x")
		stub.advance(3)
		local underChoice = shown()
		RC.Hide()
		local afterChoice = shown()
		PolestarWelcome.Next:Click()
		Polestar.Fire("ROUTE_CHOICE", "x")
		local overWelcome = { welcome = shown(), choice = RC.IsShown(), char = PolestarCharDB.welcomeSeen }
		RC.Hide()
		emit({ underChoice = underChoice, afterChoice = afterChoice, overWelcome = overWelcome, back = shown(), key = key(),
			step = step() })`, { saved: ACCOUNT_SEEN });
	assert.equal(out.underChoice, false);
	assert.equal(out.afterChoice, true);
	assert.deepEqual(out.overWelcome, { welcome: false, choice: true, char: 1 }, 'stepped aside, already marked shown');
	assert.equal(out.back, true);
	assert.equal(out.key, 'start', 'it comes back on the page it left');
	assert.equal(out.step, '2 of 2', 'with the pages it started with');
});

test('four pages with Next and Back and the step dots; the last page holds the guide buttons', () => {
	const [out] = run(`
		Wel.Show()
		local F = PolestarWelcome
		local keys, steps, marks, buttons = {}, {}, {}, {}
		for i = 1, 4 do
			keys[i], steps[i], marks[i] = key(), step(), dots()
			buttons[i] = { skip = F.Skip:IsShown(), back = F.Back:IsShown(), next = F.Next:IsShown(),
				start = F.Start:IsShown(), browse = F.Browse:IsShown() }
			if i < 4 then F.Next:Click() end
		end
		local height = F:GetHeight()
		F.Back:Click()
		local back = { key = key(), height = F:GetHeight() }
		F.Back:Click()
		F.Back:Click()
		F.Back:Click()
		local first = key()
		stub.advance(1)
		emit({ keys = keys, steps = steps, marks = marks, buttons = buttons, height = height, back = back, first = first,
			idle = Polestar.Anim.Active() })`);
	assert.deepEqual(out.keys, ['welcome', 'setup', 'route', 'start']);
	assert.deepEqual(out.steps, ['1 of 4', '2 of 4', '3 of 4', '4 of 4']);
	assert.deepEqual(out.marks, ['4:1', '4:2', '4:3', '4:4'], 'the current page is the accent capsule');
	assert.deepEqual(out.buttons, [
		{ skip: true, back: false, next: true, start: false, browse: false },
		{ skip: true, back: true, next: true, start: false, browse: false },
		{ skip: true, back: true, next: true, start: false, browse: false },
		{ skip: false, back: true, next: false, start: true, browse: true },
	]);
	assert.deepEqual(out.back, { key: 'route', height: out.height }, 'the window keeps its height between pages');
	assert.equal(out.first, 'welcome', 'Back stops at the first page');
	assert.equal(out.idle, 0, 'nothing runs per frame once it has settled');
});

test('the beta callout on the start page follows ns.routesBeta', () => {
	const [out] = run(`
		Wel.Show("start")
		local F = PolestarWelcome
		local p = F.pages.start
		local beta = { chip = p.Beta.Chip:IsShown() and p.Beta.Chip.Text:GetText(),
			text = uistub.findText(F, "nobody has followed them through the live game yet") ~= nil,
			report = plain(p.Beta.Text:GetText()):find("/polestar skip and tell us on Discord", 1, true) ~= nil }
		F:Hide()
		Polestar.routesBeta = false
		Wel.Show("start")
		emit({ beta = beta, proven = { chip = p.Beta.Chip:IsShown(), head = uistub.findText(F, "still in beta") ~= nil } })`);
	assert.deepEqual(out.beta, { chip: 'BETA', text: true, report: true });
	assert.deepEqual(out.proven, { chip: false, head: false });
});

test('the start page invites the player to the Discord community: its mark, and the invite as a link that opens the copy window', () => {
	const [out] = run(`
		Wel.Show("start")
		local F = PolestarWelcome
		local mark = F.pages.start.Discord.Mark
		local r, g, b = mark:GetVertexColor()
		local dr, dg, db = Polestar.Theme.Color("discord")
		local link = F.Discord
		local seen = { link = link:IsVisible() and link.Label:GetText(),
			head = uistub.findText(F, "Join us on Discord") ~= nil, line = uistub.findText(F, "Feedback, bug reports and news") ~= nil,
			mark = mark:IsVisible() and tostring(mark:GetTexture()):find("discord", 1, true) ~= nil,
			own = r == dr and g == dg and b == db, kind = link:GetObjectType() }
		link:Click()
		emit({ seen = seen, copy = PolestarCopy ~= nil and PolestarCopy:IsShown() and PolestarCopy.Box:GetText(),
			shared = Polestar.DiscordURL })`);
	assert.deepEqual(out.seen, { link: 'discord.gg/vMbee6F2e9', head: true, line: true, mark: true, own: true, kind: 'Button' },
		'the address reads as a link, not a field');
	assert.ok(out.shared && out.copy === out.shared, `the copy window holds the shared invite: ${out.copy}`);
});

test('the start page says what guide packs are and where to learn more', () => {
	const [out] = run(`
		Wel.Show("start")
		local F = PolestarWelcome
		local t = plain(F.pages.start.Packs.Text:GetText())
		emit({ head = uistub.findText(F, "Guide packs") ~= nil,
			others = t:find("made by other players for Polestar", 1, true) ~= nil,
			addon = t:find("installed like any other", 1, true) ~= nil,
			where = t:find("/polestar guides under Guide packs", 1, true) ~= nil,
			author = t:find("credited to their author, who supports them", 1, true) ~= nil,
			more = t:find("Options > Guide packs", 1, true) ~= nil })`);
	assert.deepEqual(out, { head: true, others: true, addon: true, where: true, author: true, more: true });
});

test('the setup page writes its settings: quest automation both ways, the login guide, and the scheme from its cards', () => {
	const [out] = run(`
		Wel.Show("setup")
		local get = Polestar.Get
		local F = PolestarWelcome
		local start = { title = title(), on = F.AutoQuest.checked,
			desc = uistub.findText(F, "Never picks between rewards") ~= nil, login = uistub.findText(F, "when no tab is open") ~= nil }
		F.AutoQuest:Click()
		local off = { get("behavior.autoAccept"), get("behavior.autoTurnin"), F.AutoQuest.checked }
		F.AutoQuest:Click()
		local on = { get("behavior.autoAccept"), get("behavior.autoTurnin"), F.AutoQuest.checked }
		Polestar.Set("behavior.autoTurnin", false)
		local partly = F.AutoQuest.checked
		F.AutoGuide:Click()
		local guide = get("behavior.autoSelectGuide")
		local cards, selected = {}, nil
		for i, c in ipairs(F.Schemes) do
			if c:IsShown() then
				cards[#cards + 1] = c.Name:GetText()
				if c.psSelected then selected = c.Name:GetText() end
			end
		end
		local before = { Polestar.Theme.Color("bg") }
		F.Schemes[3]:Click()
		local after = { Polestar.Theme.Color("bg") }
		local now
		for _, c in ipairs(F.Schemes) do if c.psSelected then now = c.Name:GetText() end end
		F.Schemes[3]:Click("RightButton")
		emit({ start = start, off = off, on = on, partly = partly, guide = guide, cards = cards, selected = selected,
			scheme = F.Schemes[3].psValue, now = now, live = before[1] ~= after[1], reset = get("ui.scheme") or "default",
			stillShown = shown() })`);
	assert.deepEqual(out.start, { title: 'Make it yours', on: true, desc: true, login: true }, 'descriptions shown inline');
	assert.deepEqual(out.off, [false, false, false], 'one switch turns both accepting and turning in off');
	assert.deepEqual(out.on, [true, true, true]);
	assert.equal(out.partly, false, 'on only while both are on');
	assert.equal(out.guide, false);
	assert.deepEqual(out.cards, ['Dusk', 'Night', 'Graphite'], 'one card per scheme on offer');
	assert.equal(out.selected, 'Dusk');
	assert.equal(out.scheme, 'graphite');
	assert.equal(out.now, 'Graphite', 'the clicked card is marked at once');
	assert.equal(out.live, true, 'the window re-themes in front of the player');
	assert.notEqual(out.reset, 'graphite', 'right-click puts the default back');
	assert.equal(out.stillShown, true);
});

test('right-clicking the quest automation switch puts accepting and turning in back to their defaults', () => {
	const [out] = run(`
		Wel.Show("setup")
		local get = Polestar.Get
		local F = PolestarWelcome
		F.AutoQuest:Click()
		local off = { get("behavior.autoAccept"), get("behavior.autoTurnin") }
		F.AutoQuest:Click("RightButton")
		local reset = { get("behavior.autoAccept"), get("behavior.autoTurnin"), F.AutoQuest.checked }
		F.AutoQuest:Click("RightButton")
		emit({ off = off, reset = reset, again = { get("behavior.autoAccept"), get("behavior.autoTurnin"), F.AutoQuest.checked } })`);
	assert.deepEqual(out.off, [false, false]);
	assert.deepEqual(out.reset, [true, true, true]);
	assert.deepEqual(out.again, [true, true, true], 'from the defaults, right-click leaves them as they are');
});

test('the route page: three styles with what each does, Balanced picked on a fresh account; a click sets nav.routeStyle, right-click puts Balanced back, Options moves the pick', () => {
	const [out] = run(`
		Wel.Show("route")
		local get = Polestar.Get
		local F = PolestarWelcome
		local function pick()
			local on
			for _, c in ipairs(F.Styles) do if c.psSelected then on = c.Name:GetText() end end
			return on
		end
		local cards = {}
		for i, c in ipairs(F.Styles) do
			cards[i] = { c.Name:GetText(), c.Desc:GetText(), c.psChip and c.psChip:IsShown() and c.psChip.Text:GetText() or false }
		end
		local fresh = pick()
		F.Styles[3]:Click()
		local roads = { get("nav.routeStyle"), pick() }
		F.Styles[3]:Click("RightButton")
		local reset = { get("nav.routeStyle") or "balanced", pick() }
		Polestar.Set("nav.routeStyle", "fastest")
		local options = pick()
		local route = F.pages.route
		local function said(w) return w ~= nil and w:IsShown() and (w:GetText() or "") ~= "" end
		emit({ title = title(), note = said(route.Hero.Sub), foot = said(route.Foot),
			cards = cards, fresh = fresh, roads = roads, reset = reset, options = options,
			fits = F.pages.route:GetHeight() <= F.pages.setup:GetHeight() })`);
	assert.ok(out.title, 'the page has a title');
	assert.equal(out.note, true, 'the note under the title');
	assert.equal(out.foot, true, 'the footnote under the cards');
	assert.equal(out.cards.length, 3, 'three cards');
	for (const [name, desc] of out.cards) assert.ok(name && desc, `${name}: a name and a description`);
	assert.equal(new Set(out.cards.map((c) => c[1])).size, 3, 'three different descriptions');
	assert.deepEqual(out.cards.filter((c) => c[2]).map((c) => c[0]), ['Balanced'], 'the Recommended chip on Balanced only');
	assert.equal(out.fresh, 'Balanced', 'Balanced is picked on a fresh account');
	assert.deepEqual(out.roads, ['roads', 'Roads'], 'a click sets the style and moves the pick');
	assert.deepEqual(out.reset, ['balanced', 'Balanced'], 'right-click puts Balanced back');
	assert.equal(out.options, 'Fastest', 'a style changed in Options moves the pick');
	assert.equal(out.fits, true, 'the route page fits in the window setup sizes');
});

test('the start page: Start guide opens the suggested guide, Browse guides opens the picker, both close it', () => {
	const [out] = run(`
		Wel.Show("start")
		local F = PolestarWelcome
		F.Start:Click()
		local opened
		for _, c in ipairs(uistub.calls) do if c[1] == "OpenTab" or c[1] == "SetGuide" then opened = c[2] end end
		local closed = not shown()
		Wel.Show("start")
		F.Browse:Click()
		emit({ opened = opened, suggest = uistub.suggest, closed = closed,
			picker = PolestarPicker ~= nil and PolestarPicker:IsShown(), browseClosed = not shown(), seen = PolestarDB.welcomeSeen })`);
	assert.equal(out.opened, out.suggest);
	assert.equal(out.closed, true);
	assert.equal(out.picker, true);
	assert.equal(out.browseClosed, true);
	assert.equal(out.seen, 1);

	const [none] = run(`
		uistub.suggest = nil
		Wel.Show("start")
		PolestarWelcome.Start:Click()
		emit({ picker = PolestarPicker ~= nil and PolestarPicker:IsShown(), closed = not shown() })`);
	assert.deepEqual(none, { picker: true, closed: true });
});

test('Show takes a page by key or by number among the pages shown', () => {
	const [out] = run(`
		Wel.Show(4)
		local four = key()
		Wel.Show("setup")
		local setup = key()
		Wel.Show("beta")
		emit({ four = four, setup = setup, unknown = key() })`);
	assert.deepEqual(out, { four: 'start', setup: 'setup', unknown: 'welcome' });
});

test('About and /polestar welcome reopen it on its first page', () => {
	const [out] = run(`
		stub.advance(3)
		PolestarWelcome.Next:Click()
		PolestarWelcome.Skip:Click()
		Polestar.UI.ShowOptions("about")
		Polestar.UI.Options.view.Welcome:Click()
		local about = { shown = shown(), title = title(), step = step() }
		PolestarWelcome:Hide()
		SlashCmdList.POLESTAR("welcome")
		emit({ about = about, command = shown(), title = title() })`);
	assert.deepEqual(out, { about: { shown: true, title: 'Hello, Testchar', step: '1 of 4' }, command: true, title: 'Hello, Testchar' });
});
