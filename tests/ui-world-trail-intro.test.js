'use strict';
// The ground trail's introduction: a window that says what the trail is, with
// the switch and four looks that apply at a click. It never opens by itself:
// the Ground trail page's Introduction row and /polestar trail intro open it.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/WorldTrail.lua', 'UI/UI.xml'];

function run(script, opts = {}) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: opts.files || FILES }, ...(opts.addons || [])],
		saved: opts.saved && { Polestar: opts.saved },
		script: `uistub.install()
local UI = Polestar.UI
local TI = UI.WorldTrailIntro
local function shown() return PolestarTrailIntro ~= nil and PolestarTrailIntro:IsShown() end
${script}`,
	}).emitted;
}

test('it never opens by itself: not at a login, not after What\'s new or Install, a fight or a loading screen, and it keeps no flag', () => {
	// An account that has had its Install and read the newest notes.
	const [quiet] = run(`stub.login()
		local result = { atLogin = shown() }
		stub.advance(30); result.later = shown()
		stub.inCombat = true; stub.fire("PLAYER_REGEN_DISABLED")
		stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED")
		stub.fire("PLAYER_ENTERING_WORLD", false, false)
		stub.fire("CINEMATIC_STOP")
		stub.advance(30); result.afterEvents = shown()
		result.built = PolestarTrailIntro ~= nil
		result.pending = TI.Pending()
		result.flag = PolestarDB.worldTrailIntroSeen
		result.trail = Polestar.Get("nav.worldTrail")
		emit(result)`);
	assert.deepEqual(quiet, { atLogin: false, later: false, afterEvents: false, built: false, pending: false, trail: false });
	// An account that updated: What's new opens, and nothing follows it.
	const [notes] = run(`PolestarDB.whatsNewSeen = "0.0.1"
		stub.login(); stub.advance(3.2)
		local result = { notes = PolestarWhatsNew:IsShown() }
		PolestarWhatsNew:Hide(); stub.advance(30)
		result.after = shown()
		emit(result)`);
	assert.deepEqual(notes, { notes: true, after: false });
	// A new account: Install opens, has no row for the trail, and nothing follows it.
	const [install] = run(`PolestarDB.welcomeSeen = nil; PolestarCharDB.welcomeSeen = 0
		stub.login(); stub.advance(2.2)
		local result = { install = PolestarWelcome ~= nil and PolestarWelcome:IsShown() }
		UI.Welcome.Show("route")
		result.row = rawget(PolestarWelcome, "WorldTrail") ~= nil
		PolestarWelcome:Hide(); stub.advance(30)
		result.after = shown()
		result.flag = PolestarDB.worldTrailIntroSeen
		emit(result)`);
	assert.deepEqual(install, { install: true, row: false, after: false });
});

test('its switch is the trail\'s own: a click turns it on, right-click puts the default back, and closing changes nothing', () => {
	const [out] = run(`stub.login()
		TI.Show()
		local row = PolestarTrailIntro.Switch
		local result = { open = shown(), off = Polestar.Get("nav.worldTrail") == false, desc = row.Desc:GetText() ~= "" }
		row:Click(); result.on = Polestar.Get("nav.worldTrail")
		row:Click("RightButton"); result.reset = Polestar.Get("nav.worldTrail")
		row:Click()
		PolestarTrailIntro.Close:Click()
		result.closed, result.kept = not shown(), Polestar.Get("nav.worldTrail")
		emit(result)`);
	assert.deepEqual(out, { open: true, off: true, desc: true, on: true, reset: false, closed: true, kept: true });
});

test('four looks as cards: the one in use is marked, a click applies one without turning the trail on, right-click puts the default look back', () => {
	const [out] = run(`stub.login()
		TI.Show()
		local W = Polestar.WorldTrail
		local cards = PolestarTrailIntro.Cards
		local function names() local t = {}; for i, c in ipairs(cards) do t[i] = c.Name:GetText() end; return t end
		local function marked() local t = {}; for i, c in ipairs(cards) do t[i] = c.psSelected and true or false end; return t end
		local result = { names = names(), fresh = marked() }
		cards[2]:Click()
		result.picked = { look = W.CurrentLook(), marked = marked(), on = Polestar.Get("nav.worldTrail"),
			gap = Polestar.Get("nav.worldTrailGap"), flow = Polestar.Get("nav.worldTrailFlow") }
		cards[4]:Click(); result.ribbon = { W.CurrentLook(), Polestar.Get("nav.worldTrailColor") }
		Polestar.Set("nav.worldTrailLength", 60) -- tuned by hand: none of the four
		result.tuned = marked()
		cards[3]:Click("RightButton")
		result.reset = { look = W.CurrentLook(), marked = marked(), length = Polestar.Get("nav.worldTrailLength") }
		W.ApplyPreset("fel"); result.other = marked() -- a look that has no card
		emit(result)`);
	assert.deepEqual(out.names, ['Stardust', 'Breadcrumbs', 'Whisper', 'Ribbon']);
	assert.deepEqual(out.fresh, [true, false, false, false]);
	assert.deepEqual(out.picked, { look: 'breadcrumbs', marked: [false, true, false, false], on: false, gap: 3, flow: 0 });
	assert.deepEqual(out.ribbon, ['ribbon', 'arcane']);
	assert.deepEqual(out.tuned, [false, false, false, false]);
	assert.deepEqual(out.reset, { look: 'stardust', marked: [true, false, false, false], length: 20 });
	assert.deepEqual(out.other, [false, false, false, false]);
});

test('each card previews its own look: its reach, spacing and colour, drifting only where the look flows and never under reduced motion', () => {
	const [out] = run(`stub.login()
		TI.Show()
		local W = Polestar.WorldTrail
		local function facts(c)
			local n, far, r, g, b = 0, 0
			for _, t in ipairs(c.Marks) do
				if t:IsShown() then
					n = n + 1
					local _, _, _, x = t:GetPoint(1)
					if x > far then far = x end
					r, g, b = t:GetVertexColor()
				end
			end
			return { n = n, used = c.psUsed, far = far / c.psW, rgb = { r, g, b } }
		end
		local function places(c)
			local t = {}
			for i, m in ipairs(c.Marks) do
				if m:IsShown() then local _, _, _, x, y = m:GetPoint(1); t[#t + 1] = x; t[#t + 1] = y end
			end
			return t
		end
		local function moved(a, b)
			if #a ~= #b then return true end
			for i = 1, #a do if math.abs(a[i] - b[i]) > 1e-6 then return true end end
			return false
		end
		local cards = PolestarTrailIntro.Cards
		local result = { looks = {} }
		for i, c in ipairs(cards) do result.looks[c.psLook] = facts(c) end
		local before = {}
		for i, c in ipairs(cards) do before[i] = places(c) end
		stub.advance(0.5)
		result.drift = {}
		for i, c in ipairs(cards) do result.drift[c.psLook] = moved(before[i], places(c)) end
		Polestar.Set("ui.reduceMotion", true)
		for i, c in ipairs(cards) do before[i] = places(c) end
		stub.advance(0.5)
		result.reduced = {}
		for i, c in ipairs(cards) do result.reduced[c.psLook] = moved(before[i], places(c)) end
		result.gold = W.ColorOf("gold").rgb; result.arcane = W.ColorOf("arcane").rgb
		emit(result)`);
	const { stardust, breadcrumbs, whisper, ribbon } = out.looks;
	for (const [name, look] of Object.entries(out.looks)) {
		assert.ok(look.n > 0 && look.n === look.used, `${name} draws its sparkles: ${look.n}`);
		assert.ok(look.n <= 44, `${name} stays under the cards' ceiling: ${look.n}`);
	}
	assert.ok(breadcrumbs.n < stardust.n && breadcrumbs.n < ribbon.n, 'Breadcrumbs is the sparsest');
	assert.ok(ribbon.far > breadcrumbs.far && breadcrumbs.far > stardust.far && stardust.far > whisper.far,
		`reach in order, Ribbon the longest and Whisper the shortest: ${[ribbon.far, breadcrumbs.far, stardust.far, whisper.far]}`);
	assert.deepEqual(stardust.rgb, out.gold);
	assert.deepEqual(ribbon.rgb, out.arcane);
	assert.deepEqual(out.drift, { stardust: true, breadcrumbs: false, whisper: true, ribbon: true }, 'Breadcrumbs holds still, the others drift');
	assert.deepEqual(out.reduced, { stardust: false, breadcrumbs: false, whisper: false, ribbon: false });
});

test('on a light look the previews keep a dark ground, so the sparkles show in every look', () => {
	// Vellum, a skin in the download: paper grounds and dark ink. A skin's look registers where Polestar holds the
	// arrow's, the pins' and the route lines' settings too (the skin audit loads the same files for it).
	const LIGHT = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Maps/FlightPaths.lua', 'Maps/RouteStrokes.lua', 'Maps/RouteSparkle.lua', 'Maps/RouteLines.lua', 'UI/UI.xml'];
	const probe = `stub.login()
		TI.Show()
		local T = Polestar.Theme
		local c = PolestarTrailIntro.Cards[1]
		local function rgb(t) local r, g, b = t:GetVertexColor(); return { r, g, b } end
		local ground, gold = rgb(c.Ground), Polestar.WorldTrail.ColorOf("gold").rgb
		local sr, sg, sb = T.Color("sidebar")
		emit({ skin = Polestar.Get("ui.skin"), light = T.IsLightPalette(T.Palette()), ground = ground, sidebar = { sr, sg, sb }, tip = T.TIP_GROUND,
			sparkle = T.Contrast(gold, ground), onSidebar = T.Contrast(gold, { sr, sg, sb }),
			start = T.Contrast(rgb(c.Start), ground), goal = T.Contrast(rgb(c.Goal), ground), errors = #Polestar.Errors() })`;
	const near = (a, b) => a.every((v, i) => Math.abs(v - b[i]) < 1e-6);
	const [dark] = run(probe);
	assert.equal(dark.light, false);
	assert.ok(near(dark.ground, dark.sidebar), `a dark look's own sidebar is the ground: ${dark.ground} vs ${dark.sidebar}`);
	assert.ok(dark.sparkle > 4.5, `gold reads on it: ${dark.sparkle}`);
	const [light] = run(probe, { files: LIGHT, addons: ['Polestar_Skin_Vellum'], saved: 'PolestarDB = { schema = 1, welcomeSeen = 99, settings = { ui = { skin = "vellum" } } }' });
	assert.deepEqual({ skin: light.skin, light: light.light, errors: light.errors }, { skin: 'vellum', light: true, errors: 0 });
	assert.ok(light.onSidebar < 2, `gold on the look's own paper all but vanishes: ${light.onSidebar}`);
	assert.ok(near(light.ground, light.tip), `the preview keeps the dark ground: ${light.ground}`);
	assert.ok(light.sparkle > 4.5 && light.start > 4.5 && light.goal >= 3, `sparkles and marks read on it: ${[light.sparkle, light.start, light.goal]}`);
});

test('on request it opens at once, again and again: /polestar trail intro, the Introduction row in the settings, and Trail settings leads there', () => {
	const [out] = run(`stub.login()
		Polestar.UI.LoadOptions()
		local O = UI.Options
		local result = {}
		local said = #stub.messages -- the test client's own login lines
		SlashCmdList.POLESTAR("trail intro"); result.command = shown()
		result.title = PolestarTrailIntro.Hero.Title:GetText()
		result.sub = PolestarTrailIntro.Hero.Sub:GetText()
		result.switch = PolestarTrailIntro.Switch.Label:GetText()
		TI.Hide(); result.hidden = not shown()
		UI.ShowOptions("groundtrail")
		local c = O.Controls("groundtrail", "Trail")
		result.rowButton = c["Introduction"].Button.Label:GetText()
		c["Introduction"].Button:Click(); result.fromOptions = shown()
		PolestarOptions:Hide()
		result.buttons = { PolestarTrailIntro.Settings.Label:GetText(), PolestarTrailIntro.GotIt.Label:GetText() }
		result.hint = PolestarTrailIntro.Hint:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
		result.note = PolestarTrailIntro.Body.LookNote:GetText()
		PolestarTrailIntro.Settings:Click()
		local tab
		for name, view in pairs(O.page.views) do if view == O.view then tab = name end end
		result.settings = { closed = not shown(), options = PolestarOptions:IsShown(), page = O.page.key, tab = tab }
		result.said = #stub.messages - said
		emit(result)`);
	assert.deepEqual(out, {
		command: true, title: 'Ground trail',
		sub: 'Optional sparkles on the ground ahead of you, along your route.',
		switch: 'Show a ground trail',
		hidden: true, rowButton: 'Show', fromOptions: true, buttons: ['Trail settings', 'Got it'],
		hint: 'Change it later with /polestar trail',
		note: 'Four to start from. A click applies one; right-click puts Stardust back.',
		settings: { closed: true, options: true, page: 'groundtrail', tab: 'Trail' }, said: 0,
	});
});

test('asked for in a fight or during a cinematic it opens when that ends, and without the trail there is no introduction', () => {
	const [fight] = run(`stub.login()
		stub.inCombat = true
		TI.Show()
		local result = { during = shown(), pending = TI.Pending() }
		stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED")
		result.after, result.left = shown(), TI.Pending()
		TI.Hide()
		stub.inCombat = true; TI.Show(); TI.Hide() -- asked for, then let go
		stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED")
		result.letGo = shown()
		emit(result)`);
	assert.deepEqual(fight, { during: false, pending: true, after: true, left: false, letGo: false });
	const [cinematic] = run(`stub.login()
		local real = InCinematic
		InCinematic = function() return true end
		TI.Show()
		local result = { during = shown(), pending = TI.Pending() }
		InCinematic = real
		stub.fire("CINEMATIC_STOP"); stub.advance(1.2)
		result.after = shown()
		emit(result)`);
	assert.deepEqual(cinematic, { during: false, pending: true, after: true });
	const [none] = run(`stub.login(); stub.advance(20)
		Polestar.UI.WorldTrailIntro.Show()
		SlashCmdList.POLESTAR("welcome")
		emit({ shown = shown(), errors = #Polestar.Errors() })`,
		{ files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] });
	assert.deepEqual(none, { shown: false, errors: 0 });
});

test('it says the trail is in beta and what it does to the game\'s waypoint while it is on, in the page and not in a tooltip', () => {
	const [out] = run(`stub.login()
		TI.Show()
		local F = PolestarTrailIntro
		emit({ shown = shown(), chip = F.Hero.Chip:IsShown() and F.Hero.Chip.Text:GetText(), cost = F.Body.Cost:IsShown() and F.Body.Cost:GetText(),
			below = F.Body.Cost:GetTop() <= F.Switch:GetBottom(), above = F.Body.Cost:GetBottom() >= F.Body.LookTitle:GetTop(),
			trail = Polestar.Get("nav.worldTrail") })`);
	assert.equal(out.shown, true);
	assert.equal(out.chip, 'BETA');
	assert.match(out.cost, /^Beta\. /);
	assert.match(out.cost, /sets the game's waypoint/);
	assert.match(out.cost, /quests you accept meanwhile are not tracked by the game/);
	assert.match(out.cost, /drawn short once you have moved the camera/);
	assert.equal(out.below && out.above, true, 'between the switch and the looks');
	assert.equal(out.trail, false, 'and showing it turns nothing on');
});
