'use strict';
// The options window (addon/Polestar/UI/Options.lua): built-in pages, the
// options registry other modules use, the two-column grid, search, the
// footer, and the Blizzard Settings entry.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { fakeLocale } = require('./helpers/locale');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function run(script, { install = '', before = '', between = '' } = {}) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		before,
		addons: [{ name: 'Polestar', files: FILES }],
		script: `${between}\nuistub.install(${install})\nstub.login()\nlocal UI, O = Polestar.UI, Polestar.UI.Options\n${HELPERS}\n${script}`,
	}).emitted;
}

const HELPERS = `
local function lastCall(name)
	for i = #uistub.calls, 1, -1 do if uistub.calls[i][1] == name then return uistub.calls[i] end end
end
local function navLabels()
	local out = {}
	for _, b in ipairs(PolestarOptions.navButtons) do if b:IsShown() then out[#out + 1] = b.Label:GetText() end end
	return out
end
local function footer()
	local out = {}
	for _, side in ipairs({ "left", "right" }) do
		for _, b in ipairs(PolestarOptions.footerButtons[side]) do if b:IsShown() then out[#out + 1] = b.Label:GetText() end end
	end
	return out
end
local function footerButton(text)
	for _, side in ipairs({ "left", "right" }) do
		for _, b in ipairs(PolestarOptions.footerButtons[side]) do if b:IsShown() and b.Label:GetText() == text then return b end end
	end
end
`;

// A module page, registered the way Quests/Gear/Maps/QoL do.
const FAKE_PAGE = `
Polestar.RegisterDefaults("fake", { markers = true, size = 1, colour = { 1, 0.5, 0 }, mode = "auto" })
local clicks = 0
uifake = { clicks = function() return clicks end }
Polestar.RegisterOptions({ page = "Quests", icon = "icon-accept", order = 30, tab = "Map", section = "Markers", controls = {
	{ kind = "toggle", key = "fake.markers", label = "Objective markers", help = "Pins for quest objectives." },
	{ kind = "slider", key = "fake.size", label = "Marker size", min = 0.5, max = 2, step = 0.05, format = "%.2fx",
		disabled = function() return not Polestar.Get("fake.markers") end },
	{ kind = "dropdown", key = "fake.mode", label = "Weights", choices = { { value = "auto", label = "Automatic" }, { value = "manual", label = "Manual" } } },
	{ kind = "color", key = "fake.colour", label = "Marker colour" },
	{ kind = "button", label = "Reset lockouts", help = "Forget saved lockouts.", onClick = function() clicks = clicks + 1 end },
} })
`;

test('pages: by order, a page with nothing to set left out, Recorder and About last; tabs and sections', () => {
	const [out] = run(`
		Polestar.RegisterOptions({ page = "Gear", icon = "star", order = 40, section = "Weights", controls = {} })
		UI.ShowOptions()
		emit({ nav = navLabels(), pages = O.Pages(), title = PolestarOptions.Title:GetText(),
			tabs = (function() local t = {} for _, b in ipairs(PolestarOptions.tabButtons) do if b:IsShown() then t[#t + 1] = b.Label:GetText() end end return t end)(),
			footer = footer() })`, { between: FAKE_PAGE });
	// Questing, Discovery and Quality of Life fill from modules not loaded
	// here; Gear registered no control: all left out of the list. Community guides
	// (a custom page) and Integrations (which says when it has nothing) are
	// always there.
	assert.deepEqual(out.nav, ['Guide', 'Appearance', 'Map', 'Quests', 'Integrations', 'Community guides', 'Gamepad', 'Recorder', 'About']);
	assert.equal(out.title, 'Guide');
	assert.deepEqual(out.tabs, ['Window', 'Arrow & routes', 'Automation']);
	assert.deepEqual(out.pages.find((p) => p.name === 'Quests'), { name: 'Quests', key: 'quests', builtin: false, tabs: ['Map'] });
	assert.deepEqual(out.footer, ['Reset page', 'Reload UI', 'Close']);
});

// Options > Integrations: a section per supported addon, there only while
// that addon is installed or loaded; with none, one line says so.
test('Integrations lists Questie only when it is installed or loaded, else says none is', () => {
	const show = `
		UI.ShowOptions("integrations")
		local headers = {}
		for _, h in ipairs(O.view.headers) do if h:IsShown() then headers[#headers + 1] = h.Text:GetText() end end
		local toggle = O.Controls("integrations")["routePlan.questie"]
		emit({ title = PolestarOptions.Title:GetText(), headers = headers, empty = O.view.empty,
			line = rawget(O.view, "Empty") and O.view.Empty:IsShown() and O.view.Empty:GetText() or nil,
			toggle = toggle ~= nil and toggle:IsShown() or false, on = Polestar.Get("routePlan.questie"),
			nav = navLabels() })`;
	const [none] = run(show);
	assert.equal(none.title, 'Integrations');
	assert.ok(none.nav.includes('Integrations'));
	assert.deepEqual(Object.values(none.headers), []);
	assert.equal(none.empty, true);
	assert.equal(none.line, 'None of the addons Polestar works with is installed.');
	assert.equal(none.toggle, false);

	const [loaded] = run(`stub.addonsLoaded.Questie = true\n${show}`);
	assert.deepEqual(loaded.headers, ['Questie']);
	assert.equal(loaded.empty, false);
	assert.equal(loaded.line, undefined);
	assert.equal(loaded.toggle, true);
	assert.equal(loaded.on, false, 'planned turn-ins stay off until the player turns them on');

	// Installed and enabled but loading after Polestar counts too.
	const [installed] = run(`
		table.insert(stub.addons, { name = "Questie" })
		function C_AddOns.DoesAddOnExist(name) return name == "Questie" end
		${show}`);
	assert.deepEqual(installed.headers, ['Questie']);
	assert.equal(installed.toggle, true);
});

// Players and macros still type the old page names (/polestar options
// navigation); each lands on the page and tab that holds those settings now.
test('old page keys open the page and tab that hold their settings now', () => {
	const [out] = run(`
		local function at(key)
			UI.ShowOptions(key)
			local tab
			for name, v in pairs(O.page.views) do if v == O.view then tab = name end end
			return PolestarOptions.Title:GetText() .. " > " .. tab
		end
		local out = {}
		for _, k in ipairs({ "guidewindow", "navigation", "automation", "appearance", "map", "recorder", "nav", "behaviour", "General" }) do out[k] = at(k) end
		emit(out)`);
	assert.deepEqual(out, {
		guidewindow: 'Guide > Window',
		navigation: 'Guide > Arrow & routes',
		automation: 'Guide > Automation',
		appearance: 'Appearance > Colour & type',
		map: 'Map > Guide & quests',
		recorder: 'Recorder > ',
		nav: 'Guide > Arrow & routes',
		behaviour: 'Guide > Automation',
		General: 'Guide > Window',
	});
	const [mods] = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml', 'QoL/QoL.xml',
			'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml'] }],
		script: `uistub.install()\nstub.login()\nlocal UI, O = Polestar.UI, Polestar.UI.Options
		local out = {}
		for _, k in ipairs({ "quests", "gear", "lookup", "dungeons", "rares", "qualityoflife" }) do
			UI.ShowOptions(k)
			local tab
			for name, v in pairs(O.page.views) do if v == O.view then tab = name end end
			out[k] = PolestarOptions.Title:GetText() .. " > " .. tab
		end
		emit(out)`,
	}).emitted;
	assert.deepEqual(mods, {
		quests: 'Questing > Quests',
		gear: 'Questing > Rewards & gear',
		lookup: 'Discovery > Lookup',
		dungeons: 'Discovery > Dungeons',
		rares: 'Discovery > Rares',
		qualityoflife: 'Quality of Life > Travel',
	});
});

// A translated client: the page titles change, the keys players type do not.
test('page keys stay English on a translated client: /polestar options quests, gear, lookup and /polestar packs', () => {
	const [out] = runAddon({
		stubs: ['stub_ui.lua'],
		before: fakeLocale('itIT', {
			Guide: 'Leitfaden',
			Appearance: 'Darstellung',
			Questing: 'Questen',
			Discovery: 'Entdecken',
			'Quality of Life': 'Komfort',
			'Community guides': 'Community-Guides',
			About: 'Über',
			Quests: 'Aufträge',
			'Rewards & gear': 'Belohnungen & Ausrüstung',
			Lookup: 'Nachschlagen',
		}),
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Quests/Quests.xml', 'Gear/Gear.xml', 'Maps/Maps.xml', 'QoL/QoL.xml',
			'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml', 'Rares/Rares.xml'] }],
		script: `uistub.install()\nstub.login()\nlocal O = Polestar.UI.Options
		local function at(cmd)
			SlashCmdList.POLESTAR(cmd)
			local tab
			for name, v in pairs(O.page.views) do if v == O.view then tab = name end end
			return O.page.key .. ": " .. PolestarOptions.Title:GetText() .. " > " .. tab
		end
		local out = {}
		for _, cmd in ipairs({ "options quests", "options gear", "options lookup", "options appearance", "options qualityoflife", "options about", "packs" }) do out[cmd] = at(cmd) end
		local keys = {}
		for _, p in ipairs(O.Pages()) do keys[#keys + 1] = p.key end
		out.keys = keys
		emit(out)`,
	}).emitted;
	assert.deepEqual(out, {
		'options quests': 'questing: Questen > Aufträge',
		'options gear': 'questing: Questen > Belohnungen & Ausrüstung',
		'options lookup': 'discovery: Entdecken > Nachschlagen',
		'options appearance': 'appearance: Darstellung > Colour & type',
		'options qualityoflife': 'qualityoflife: Komfort > Travel',
		'options about': 'about: Über > ',
		packs: 'guidepacks: Community-Guides > ',
		keys: ['guide', 'appearance', 'map', 'questing', 'discovery', 'qualityoflife', 'integrations', 'guidepacks', 'gamepad', 'recorder', 'about'],
	});
});

test('registered controls read and write settings; disabled functions follow other settings', () => {
	const [out] = run(`
		UI.ShowOptions("quests")
		local c = O.Controls("quests")
		local size = c["fake.size"]
		local before = size:IsEnabled()
		c["fake.markers"]:Click()
		local after = size:IsEnabled()
		stub.RunScript(size.Slider, "OnValueChanged", 1.5, true)
		local blocked = Polestar.Get("fake.size")
		c["fake.markers"]:Click()
		stub.RunScript(size.Slider, "OnValueChanged", 1.52, true)
		c["fake.mode"].Button:Click()
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Manual" then r:Click() end end
		c["Reset lockouts"]:Click()
		emit({ before = before, after = after, blocked = blocked, size = Polestar.Get("fake.size"), mode = Polestar.Get("fake.mode"),
			label = c["fake.mode"].Button.Label:GetText(), clicks = uifake.clicks(), rowH = c["fake.markers"]:GetHeight() })`, { between: FAKE_PAGE });
	assert.equal(out.before, true);
	assert.equal(out.after, false, 'disabled while markers are off');
	assert.equal(out.blocked, 1, 'a disabled slider does not write');
	assert.equal(out.size, 1.5);
	assert.equal(out.mode, 'manual');
	assert.equal(out.label, 'Manual');
	assert.equal(out.clicks, 1);
	assert.equal(out.rowH, 40);
});

test('a registration made after the window exists shows up; a malformed one is refused', () => {
	const [out] = run(`
		UI.ShowOptions()
		Polestar.RegisterDefaults("late", { thing = true })
		local ok = Polestar.RegisterOptions({ page = "Maps", icon = "icon-explore", order = 20, controls = { { kind = "toggle", key = "late.thing", label = "Late thing" } } })
		local bad, err = Polestar.RegisterOptions({ page = "Broken", controls = { { kind = "wheel", key = "x" } } })
		local bad2 = Polestar.RegisterOptions({ page = "Broken", controls = { { kind = "button", label = "No handler" } } })
		local nav = navLabels()
		UI.ShowOptions("maps")
		emit({ ok = ok, bad = bad, err = err, bad2 = bad2, nav = nav, controls = (function() local n = 0 for _ in pairs(O.Controls("maps")) do n = n + 1 end return n end)() })`);
	assert.equal(out.ok, true);
	assert.equal(out.bad, false);
	assert.match(out.err, /unknown kind wheel/);
	assert.equal(out.bad2, false);
	assert.ok(out.nav.includes('Maps') && !out.nav.includes('Broken'));
	assert.equal(out.controls, 1);
});

test('a registered page may give its own key, which opens it whatever its title; a key that is not a string is refused', () => {
	const [out] = run(`
		Polestar.RegisterDefaults("mine", { thing = true })
		local ok = Polestar.RegisterOptions({ page = "Mein Addon", key = "myaddon", controls = { { kind = "toggle", key = "mine.thing", label = "Thing" } } })
		local bad, err = Polestar.RegisterOptions({ page = "Broken", key = 5, controls = {} })
		UI.ShowOptions("myaddon")
		emit({ ok = ok, bad = bad, err = err, key = O.page.key, title = PolestarOptions.Title:GetText() })`);
	assert.deepEqual(out, { ok: true, bad: false, err: 'RegisterOptions: key must be a string', key: 'myaddon', title: 'Mein Addon' });
});

test('built-in controls write settings and follow changes made elsewhere', () => {
	const [out] = run(`
		UI.ShowOptions("guide")
		local c = O.Controls("guide")
		c["ui.compact"]:Click()
		local compact = Polestar.Get("ui.compact")
		Polestar.Set("ui.showNotes", false)
		local followed = c["ui.showNotes"].checked
		local notesOpen = c["ui.notesOpen"]:IsEnabled()
		O.Select("guide", "Automation")
		O.Controls("guide", "Automation")["behavior.skipGrey"]:Click()
		O.Select("guide", "Arrow & routes")
		local nav = O.Controls("guide", "Arrow & routes")
		Polestar.Set("nav.tomtom", false)
		UI.ShowOptions("appearance")
		local look = O.Controls("appearance")
		look["ui.accent"]:Click("LeftButton")
		local info = ColorPickerFrame.info
		ColorPickerFrame.GetColorRGB = function() return 0.9, 0.3, 0.1 end
		info.swatchFunc()
		local picked = Polestar.Get("ui.accent")
		info.cancelFunc()
		O.Select("appearance", "Windows")
		local win = O.Controls("appearance", "Windows")
		win["ui.style"].Button:Click()
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Transparent" then r:Click() end end
		stub.RunScript(win["ui.scale"].Slider, "OnValueChanged", 1.234, true)
		O.Select("appearance", "Arrow")
		emit({ compact = compact, followed = followed, notesOpen = notesOpen, style = Polestar.Get("ui.style"),
			scale = Polestar.Get("ui.scale"), picked = picked, cancelled = Polestar.Get("ui.accent"), skipGrey = Polestar.Get("behavior.skipGrey"),
			tomtomArrow = nav["nav.useTomTomArrow"]:IsEnabled(), arrowStyle = O.Controls("appearance", "Arrow")["nav.arrowStyle"].Button.Label:GetText() })`);
	assert.equal(out.compact, true);
	assert.equal(out.followed, false);
	assert.equal(out.notesOpen, false, 'Expand step tips greys out with the tips off');
	assert.equal(out.style, 'transparent');
	assert.equal(out.scale, 1.25, 'slider values snap to the step');
	assert.deepEqual(out.picked, [0.9, 0.3, 0.1]);
	assert.equal(out.cancelled, false, 'cancel restores the previous value: no custom accent');
	assert.equal(out.skipGrey, true);
	assert.equal(out.tomtomArrow, false);
	assert.equal(out.arrowStyle, '3D');
});

test('the lock for the arrow, buttons and timers sits under Lock window, off by default, and says Shift-drag still moves them', () => {
	const [out] = run(`
		UI.ShowOptions("guide")
		local w = O.Controls("guide", "Window")["ui.lockHud"]
		local groups = O.Search("lock")
		local labels, help = {}, nil
		for _, g in ipairs(groups) do
			if g.title == "Guide  \\194\\183  Window" then
				for _, c in ipairs(g.controls) do
					labels[#labels + 1] = c.label
					if c.key == "ui.lockHud" then help = c.help end
				end
			end
		end
		local default = Polestar.Get("ui.lockHud")
		w:Click()
		emit({ labels = labels, help = help, default = default, clicked = Polestar.Get("ui.lockHud"), label = w.Label:GetText() })`);
	assert.deepEqual(out.labels, ['Lock window', 'Lock arrow and buttons']);
	assert.equal(out.help, 'Stops stray drags on the arrow, the action buttons and the flight and instance timers. Shift-drag still moves them.');
	assert.equal(out.default, false);
	assert.equal(out.clicked, true);
	assert.equal(out.label, 'Lock arrow and buttons');
});

test('search finds settings by label and help across pages, registered ones included', () => {
	const [out] = run(`
		UI.ShowOptions()
		local box = PolestarOptions.Search
		box:SetText("arrow")
		stub.RunScript(box, "OnTextChanged", true)
		local titles = {}
		for _, g in ipairs(O.results.groups) do titles[#titles + 1] = g.title end
		local arrow = { titles = titles, count = O.results.count, title = PolestarOptions.Title:GetText(), sub = PolestarOptions.Subtitle:GetText(),
			tabRow = PolestarOptions.TabRow:IsShown(), footer = footer() }
		local groups, n = O.Search("pins objectives")
		local help = { n = n, label = groups[1] and groups[1].controls[1].label }
		local _, none = O.Search("zzzz")
		local found = {}
		for _, q in ipairs({ "border", "band", "shadow", "arrow colour", "arrival colour" }) do found[q] = select(2, O.Search(q)) end
		box:SetText("")
		stub.RunScript(box, "OnTextChanged", true)
		emit({ arrow = arrow, help = help, none = none, found = found, back = PolestarOptions.Title:GetText() })`, { between: FAKE_PAGE });
	assert.deepEqual(out.arrow.titles, ['Guide  \u00b7  Window', 'Guide  \u00b7  Arrow & routes','Appearance  \u00b7  Arrow', 'Map  \u00b7  Guide & quests', 'Gamepad  \u00b7  Key bindings']);
	assert.equal(out.arrow.title, 'Search');
	assert.equal(out.arrow.sub, `${out.arrow.count} settings match`);
	assert.equal(out.arrow.tabRow, false);
	assert.deepEqual(out.arrow.footer, ['Reload UI', 'Close']);
	assert.deepEqual(out.help, { n: 1, label: 'Objective markers' }, 'help text is searchable');
	assert.equal(out.none, 0);
	for (const [q, n] of Object.entries(out.found)) assert.ok(n >= 1, `search finds "${q}"`);
	assert.equal(out.back, 'Guide');
});

test('Reset page asks twice and resets only that page', () => {
	const [out] = run(`
		Polestar.Set("ui.compact", true)
		Polestar.Set("nav.arrowScale", 1.5)
		UI.ShowOptions("guide")
		local b = footerButton("Reset page")
		b:Click()
		local armed = { b.Label:GetText(), Polestar.Get("ui.compact") }
		b:Click()
		emit({ armed = armed, compact = Polestar.Get("ui.compact"), arrow = Polestar.Get("nav.arrowScale") })`);
	assert.deepEqual(out.armed, ['Click again to confirm', true]);
	assert.equal(out.compact, false);
	assert.equal(out.arrow, 1.5, 'the arrow\'s look is on Appearance, not reset with Guide');
});

test('a tab whose module is not loaded is left out; a page with nothing at all says so', () => {
	const [out] = run(`
		UI.ShowOptions("navigation")
		local tabs = {}
		for _, b in ipairs(PolestarOptions.tabButtons) do if b:IsShown() then tabs[#tabs + 1] = b.Label:GetText() end end
		local landed = PolestarOptions.Title:GetText()
		UI.ShowOptions("discovery")
		emit({ tabs = tabs, landed = landed, empty = O.view.empty, controls = (function() local n = 0 for _ in pairs(O.Controls("discovery")) do n = n + 1 end return n end)() })`, { install: '{ noNav = true }' });
	assert.equal(out.landed, 'Guide');
	assert.deepEqual(out.tabs, ['Window', 'Automation'], 'no dead Arrow & routes tab without Nav');
	assert.equal(out.empty, true);
	assert.equal(out.controls, 0);
});

test('Recorder page: not installed, then live counts and a stop control', () => {
	const [missing] = run(`
		UI.ShowOptions("recorder")
		emit({ text = O.view.Refresh and select(1, (function() for _, r in ipairs({ O.view:GetRegions() }) do if r.text and r.text:find("not loaded") then return r.text end end end)()) })`);
	assert.match(missing.text, /The Polestar Recorder addon is not loaded/);
	const [out] = run(`
		stub.addonsLoaded.Polestar_Recorder = true
		PolestarRecorderDB = { enabled = true, current = "b", sessions = { a = { events = {} }, b = { char = { name = "Testchar" }, events = { {}, {}, {} } } } }
		local sent = {}
		PolestarRecorder_Command = function(arg) sent[#sent + 1] = arg; if arg == "off" then PolestarRecorderDB.enabled = false end end
		UI.ShowOptions("recorder")
		local values = {}
		for _, f in ipairs({ O.view:GetChildren() }) do if rawget(f, "Value") and f:IsShown() then values[f.Label:GetText()] = f.Value:GetText() end end
		local stop
		for _, f in ipairs({ O.view:GetChildren() }) do if rawget(f, "Title") and f.Title:GetText() == "Stop recording" then stop = f end end
		stop:Click()
		emit({ values = values, sent = sent, after = stop.Title:GetText() })`);
	assert.deepEqual(out.values, { Status: 'Recording', 'Sessions stored': '2', 'Events this session': '3', Character: 'Testchar' });
	assert.deepEqual(out.sent, ['off']);
	assert.equal(out.after, 'Start recording');
});

test('About: Reset all settings asks twice; Reset positions clears saved positions', () => {
	const [out] = run(`
		Polestar.Set("ui.scale", 1.4)
		Polestar.Set("ui.pos", { 10, 20 })
		UI.ShowOptions("about")
		local reset = O.view.ResetAll
		reset:Click()
		local after1 = { Polestar.Get("ui.scale"), reset.Title:GetText() }
		reset:Click()
		O.ResetPositions()
		emit({ after1 = after1, after2 = Polestar.Get("ui.scale"), pos = Polestar.Get("ui.pos") or false, arrow = lastCall("ResetArrowPosition") })`);
	assert.deepEqual(out.after1, [1.4, 'Click again to confirm']);
	assert.equal(out.after2, 1);
	assert.equal(out.pos, false);
	assert.deepEqual(out.arrow, ['ResetArrowPosition']);
});

test('Appearance: every look control is searchable; menu scale applies when the drag ends', () => {
	const [out] = run(`
		UI.ShowOptions("appearance")
		local look = O.Controls("appearance")
		O.Select("appearance", "Windows")
		local keys = {}
		for k in pairs(O.Controls("appearance")) do keys[#keys + 1] = k end
		table.sort(keys)
		local s = O.Controls("appearance", "Windows")["ui.menuScale"]
		stub.RunScript(s.Slider, "OnValueChanged", 1.2, true)
		local during = { PolestarOptions:GetScale(), s.Value:GetText() }
		stub.RunScript(s.Slider, "OnMouseUp")
		local after = PolestarOptions:GetScale()
		O.Select("appearance", "Colour & type")
		Polestar.Set("ui.brightness", 0.3)
		local bright = look["ui.brightness"].Value:GetText()
		look["ui.brightness"]:Click("RightButton")
		look["ui.scheme"].Button:Click()
		local choices = {}
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then choices[#choices + 1] = r.Text:GetText() end end
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Graphite" then r:Click() end end
		local found = {}
		for _, q in ipairs({ "colour scheme", "accent", "background colour", "brightness", "background opacity", "font", "menu scale" }) do
			local _, n = O.Search(q)
			found[q] = n
		end
		emit({ keys = keys, during = during, after = after, stored = Polestar.Get("ui.menuScale"), bright = bright,
			reset = Polestar.Get("ui.brightness"), choices = choices, scheme = Polestar.Get("ui.scheme"),
			bgNote = look["ui.bgColor"].Note:GetText(), found = found })`);
	assert.ok(!out.keys.includes('ui.matchAccent') && !out.keys.includes('ui.matchFont'), 'without EllesmereUI its follow toggles are left out');
	assert.deepEqual(out.during, [1, '120%']);
	assert.equal(out.after, 1.2);
	assert.equal(out.stored, 1.2);
	assert.equal(out.bright, '+30%');
	assert.equal(out.reset, 0, 'right-click resets');
	assert.deepEqual(out.choices, ['Dusk', 'Night', 'Graphite']);
	assert.equal(out.scheme, 'graphite');
	assert.equal(out.bgNote, 'Graphite', 'the swatch names the scheme its colour comes from');
	for (const [q, n] of Object.entries(out.found)) assert.ok(n >= 1, `search finds "${q}"`);
});

// The sidebar's page list must never run into the version and stage chip at
// its foot, however many pages register, in either font and at any menu
// scale: the list scrolls in its own area, which ends on the footer bar's
// line, and the selected page is scrolled into view. The hub's sidebar is the
// same shell.
test('the sidebar page list never reaches the version line: it scrolls, the selected page in view', () => {
	const [out] = run(`
		local W, SH = Polestar.Widgets, Polestar.Widgets.SHELL
		Polestar.RegisterDefaults("many", { on = true })
		for i = 1, 14 do
			Polestar.RegisterOptions({ page = "Module " .. i, order = 60 + i, controls = { { kind = "toggle", key = "many.on", label = "On" } } })
		end
		local function measure(F)
			local side = F:GetHeight() - 2
			local sf = F.NavScroll
			local view, content, scroll = sf.psView, sf.psContent, sf:GetVerticalScroll()
			local floor = F.psNavTop + view
			local statusTop = side - SH.foot - F.Status:GetStringHeight()
			local chipTop = side - SH.foot - F.Status:GetStringHeight() / 2 - W.CHIP_H / 2
			local activeTop, clipped = nil, true
			for _, b in ipairs(F.navButtons) do
				if b:IsShown() then
					if b:GetParent() ~= sf.Child then clipped = false end
					if b.Bar:IsShown() then local _, _, _, _, y = b:GetPoint(1); activeTop = -y end
				end
			end
			return { floor = floor, foot = math.min(statusTop, chipTop), overflow = content > view, clipped = clipped,
				activeIn = activeTop ~= nil and activeTop >= scroll and activeTop + 40 <= scroll + view + 0.01, bar = sf.Bar:IsShown() }
		end
		local out = {}
		for _, font in ipairs({ "game", "inter" }) do
			for _, scale in ipairs({ 0.7, 1, 1.4 }) do
				Polestar.Set("ui.font", font)
				Polestar.Set("ui.menuScale", scale)
				UI.ShowOptions("about")
				out[#out + 1] = measure(PolestarOptions)
				UI.ShowOptions("guide")
				out[#out + 1] = measure(PolestarOptions)
			end
		end
		-- The hub: a section whose index holds thirty entries, the last selected.
		local items = {}
		for i = 1, 30 do items[i] = { key = "k" .. i, label = "Entry " .. i } end
		UI.RegisterSection({ key = "Many", label = "Many", icon = "gear", order = 90, nav = function() return items, "k30" end,
			build = function(parent) end, render = function() end })
		UI.ShowPicker()
		UI.Picker.ShowSection("Many")
		out[#out + 1] = measure(PolestarPicker)
		emit(out)`);
	for (const [i, m] of out.entries()) {
		assert.ok(m.floor <= m.foot, `case ${i}: the list ends at ${m.floor}, the version starts at ${m.foot}`);
		assert.equal(m.overflow, true, `case ${i}: more pages than room`);
		assert.equal(m.clipped, true, `case ${i}: rows sit in the scroll area`);
		assert.equal(m.bar, true, `case ${i}: the scroll bar shows`);
		assert.equal(m.activeIn, true, `case ${i}: the selected page is in view`);
	}
});

// Window border, band and shadow are the player's: each change repaints
// every open window at once, and a right-click on the control restores the
// house look.
test('window border, band and shadow repaint every window live; right-click restores each', () => {
	const [out] = run(`
		local T = Polestar.Theme
		uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
		UI.ShowOptions("appearance")
		O.Select("appearance", "Windows")
		local c = O.Controls("appearance", "Windows")
		local GF = PolestarGuideFrame
		local wins = { options = PolestarOptions, guide = GF }
		local bands = { options = PolestarOptions.Band, guide = Polestar.UI.GuideFrame.parts.band }
		local function look()
			local o = {}
			for name, f in pairs(wins) do
				local e = f.psBorder[1]
				local r, g, b, a = e:GetVertexColor()
				local _, _, _, ba = bands[name]:GetVertexColor()
				o[name] = { border = e:IsShown(), colour = { r, g, b, a }, px = e:GetHeight(), band = ba, shadow = f.psShadow ~= nil and f.psShadow:IsShown() }
			end
			return o
		end
		local out = { house = look(), hairline = { T.Color("border") }, accent = { T.Accent() } }
		c["ui.border"]:Click(); out.noBorder = look(); c["ui.border"]:Click()
		c["ui.borderAccent"]:Click(); out.accentBorder = look()
		stub.RunScript(c["ui.borderSize"].Slider, "OnValueChanged", 3, true); out.thick = look()
		c["ui.band"]:Click(); c["ui.shadow"]:Click(); out.bare = look()
		c["ui.borderColor"]:Click("LeftButton")
		ColorPickerFrame.GetColorRGB = function() return 0.2, 0.9, 0.4 end
		ColorPickerFrame.info.swatchFunc()
		out.own = { look = look(), accentOff = Polestar.Get("ui.borderAccent") }
		for _, k in ipairs({ "ui.borderColor", "ui.borderSize", "ui.band", "ui.shadow" }) do c[k]:Click("RightButton") end
		out.reset = look()
		emit(out)`);
	const round = (c) => c.map((v) => Math.round(v * 1000) / 1000);
	for (const w of ['options', 'guide']) {
		assert.deepEqual({ ...out.house[w], colour: round(out.house[w].colour) }, { border: true, colour: round(out.hairline), px: 1, band: 1, shadow: true }, `${w}: the house look`);
		assert.equal(out.noBorder[w].border, false, `${w}: border off`);
		assert.deepEqual(round(out.accentBorder[w].colour), round([...out.accent, 0.8]), `${w}: accent border`);
		assert.equal(out.thick[w].px, 3, `${w}: 3px border`);
		assert.equal(out.bare[w].band, 0, `${w}: band off`);
		assert.equal(out.bare[w].shadow, false, `${w}: shadow off`);
		assert.deepEqual(round(out.own.look[w].colour), [0.2, 0.9, 0.4, 1], `${w}: own border colour`);
		assert.deepEqual({ ...out.reset[w], colour: round(out.reset[w].colour) }, { border: true, colour: round(out.hairline), px: 1, band: 1, shadow: true }, `${w}: right-click restored the house look`);
	}
	assert.equal(out.own.accentOff, false, 'picking an own border colour turns the accent border off');
});

test('switching the font lays the page out again: a label that now wraps grows its row and moves the rows below', () => {
	const [out] = run(`
		Polestar.Set("ui.font", "game")
		UI.ShowOptions("guide")
		local c = O.Controls("guide")
		local row, below = c["ui.shown"], c["ui.locked"]
		local function top(w) local _, _, _, _, y = w:GetPoint(1) return y end
		local before = { h = row:GetHeight(), below = top(below), lines = row.Label:GetStringHeight() }
		-- Inter set four times wider than the game font, as a font change can.
		local M = stub.Methods
		local function wide(self) return (self.font and tostring(self.font[1]):find("Inter")) and 4 or 1 end
		M.GetUnboundedStringWidth = function(self)
			return #tostring(self.text or "") * ((self.font and self.font[2]) or 12) * 0.5 * wide(self)
		end
		M.GetStringHeight = function(self)
			local size, w = (self.font and self.font[2]) or 12, self.width or 0
			if w <= 0 then return size end
			local lines = 0
			for line in (tostring(self.text or "") .. "\\n"):gmatch("([^\\n]*)\\n") do
				lines = lines + math.max(1, math.ceil(#line * size * 0.5 * wide(self) / w))
			end
			return lines * size
		end
		Polestar.Set("ui.font", "inter")
		emit({ before = before, after = { h = row:GetHeight(), below = top(below), lines = row.Label:GetStringHeight() } })`);
	assert.equal(out.before.h, 40);
	assert.ok(out.after.lines > out.before.lines, `the label wraps: ${out.before.lines} -> ${out.after.lines}`);
	assert.ok(out.after.h > out.before.h, `its row grows: ${out.before.h} -> ${out.after.h}`);
	assert.ok(out.after.below < out.before.below, `the rows below move down: ${out.before.below} -> ${out.after.below}`);
});

test('a Blizzard Settings category opens the options window', () => {
	const [out] = run(`
		local cat
		for _, c in ipairs(Settings.categories) do if c.name == "Polestar" then cat = c end end
		local open
		for _, child in ipairs(cat.frame.children) do if type(child.Label) == "table" and child.Label:GetText() == "Open Polestar settings" then open = child end end
		open:Click()
		emit({ registered = cat ~= nil, opened = PolestarOptions:IsShown() })`);
	assert.deepEqual(out, { registered: true, opened: true });
});

test('in combat the Settings canvas button leaves the protected game panel alone', () => {
	const [out] = run(`
		local hidden = 0
		SettingsPanel = CreateFrame("Frame", "SettingsPanel", UIParent)
		HideUIPanel = function(f) hidden = hidden + 1; f:Hide() end
		local cat
		for _, c in ipairs(Settings.categories) do if c.name == "Polestar" then cat = c end end
		local open
		for _, child in ipairs(cat.frame.children) do if type(child.Label) == "table" and child.Label:GetText() == "Open Polestar settings" then open = child end end
		stub.inCombat = true
		open:Click()
		local inCombat = { hidden = hidden, opened = PolestarOptions:IsShown(), hint = #stub.messages > 0 }
		PolestarOptions:Hide()
		stub.inCombat = false
		open:Click()
		emit({ inCombat = inCombat, hidden = hidden, opened = PolestarOptions:IsShown() })`);
	assert.deepEqual(out.inCombat, { hidden: 0, opened: true, hint: true });
	assert.equal(out.hidden, 1);
	assert.equal(out.opened, true);
});

// With the gamepad interface, a panel closed from addon code leaves the
// gamepad's focus blocked (Core/Init.lua, GamepadUI): B closes it.
test('with the gamepad interface the Settings canvas button leaves the game panel alone', () => {
	const [out] = run(`
		local hidden = 0
		SettingsPanel = CreateFrame("Frame", "SettingsPanel", UIParent)
		HideUIPanel = function(f) hidden = hidden + 1; f:Hide() end
		local cat
		for _, c in ipairs(Settings.categories) do if c.name == "Polestar" then cat = c end end
		local open
		for _, child in ipairs(cat.frame.children) do if type(child.Label) == "table" and child.Label:GetText() == "Open Polestar settings" then open = child end end
		open:Click()
		emit({ hidden = hidden, opened = PolestarOptions:IsShown(), hint = stub.messages[#stub.messages] })`,
		{ before: 'Enum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }; C_InputInterfaceStyle = { GetCurrentStyle = function() return 1 end }' });
	assert.equal(out.hidden, 0);
	assert.equal(out.opened, true);
	assert.match(out.hint, /Close the game menu to see Polestar's settings\.$/);
});

test('hiding a window mid-drag on its scroll bar ends the drag', () => {
	const [out] = run(`
		UI.ShowOptions("navigation")
		local bar = PolestarOptions.Scroll.Bar
		Polestar.Widgets.SetScrollContent(PolestarOptions.Scroll, 2000, 400)
		stub.RunScript(bar, "OnMouseDown", "LeftButton")
		local dragging = bar:IsShown() and bar:GetScript("OnUpdate") ~= nil
		-- The client fires OnHide on the bar when its window hides (Escape);
		-- the stub does not cascade, so hide the bar itself.
		bar:Hide()
		emit({ dragging = dragging, after = bar:GetScript("OnUpdate") ~= nil })`);
	assert.deepEqual(out, { dragging: true, after: false });
});

// From the settings there must be a way back: the hub's rail stays, Options
// marked, and a section returns to the hub. Each window opens where the
// other stood, so the rail does not jump between them.
test('the settings carry the hub rail: a section goes back to the hub, in the same place', () => {
	const [out] = run(`
		local function rail(f)
			local out = {}
			for _, b in ipairs(f.railButtons) do if b:IsShown() then out[#out + 1] = b.psKey .. (b.Bar:IsShown() and "*" or "") end end
			return out
		end
		local function place(f) local p, rel, rp, x, y = f:GetPoint(1) return { p, rel == UIParent, rp, x, y } end
		local function railButton(f, key) for _, b in ipairs(f.railButtons) do if b:IsShown() and b.psKey == key then return b end end end
		UI.ShowPicker()
		local hub, settings = PolestarPicker, nil
		hub.x, hub.y = 200, 100
		railButton(hub, "Options"):Click()
		settings = PolestarOptions
		local opened = { shown = settings:IsShown(), hubHidden = not hub:IsShown(), rail = rail(settings), at = place(settings) }
		settings.x, settings.y = 300, 50
		railButton(settings, "Guides"):Click()
		emit({ opened = opened, back = { shown = hub:IsShown(), settingsHidden = not settings:IsShown(), at = place(hub),
			section = UI.Picker.ActiveSection() and UI.Picker.ActiveSection().key or "Guides" } })`);
	assert.equal(out.opened.shown, true);
	assert.equal(out.opened.hubHidden, true);
	assert.ok(out.opened.rail.includes('Guides') && out.opened.rail.includes('Options*'), `rail: ${out.opened.rail}`);
	assert.deepEqual(out.opened.at, ['TOPLEFT', true, 'BOTTOMLEFT', 200, 100 + 680]);
	assert.equal(out.back.shown, true);
	assert.equal(out.back.settingsHidden, true);
	assert.deepEqual(out.back.at, ['TOPLEFT', true, 'BOTTOMLEFT', 300, 50 + 680]);
	assert.equal(out.back.section, 'Guides');
});

// The page subtitle wraps between the main column's pads, two lines at most,
// the rest cut with an ellipsis; the hub's narrower column bounds it too.
test('a shell subtitle wraps to two lines within the main column and cuts the rest', () => {
	const [out] = run(`
		local W = Polestar.Widgets
		UI.ShowOptions("appearance")
		local f = PolestarOptions
		local s = f.Subtitle
		local page = { text = s:GetText(), width = s:GetWidth(), lines = s:GetNumLines(), wrap = s:GetWordWrap(), height = s:GetHeight() }
		local long = string.rep("A long subtitle that runs on. ", 12)
		W.ShellTitle(f, "Title", long)
		local cut = { text = s:GetText(), lines = s:GetNumLines() }
		UI.ShowPicker()
		emit({ page = page, cut = cut, bodyWidth = f.BodyWidth, hub = { width = PolestarPicker.Subtitle:GetWidth(), bodyWidth = PolestarPicker.BodyWidth } })`);
	assert.match(out.page.text, /^Colours, type, window frames and the arrow\./);
	assert.equal(out.page.wrap, true);
	assert.equal(out.page.width, out.bodyWidth);
	assert.ok(out.page.lines <= 2, `${out.page.lines} lines`);
	assert.ok(out.page.height < 112 - 66, `box ${out.page.height}px`);
	assert.equal(out.cut.lines, 2);
	assert.match(out.cut.text, /^A long subtitle that runs on\. .*\S\u2026$/);
	assert.equal(out.hub.width, out.hub.bodyWidth);
});

test('Distances: the arrow row picks yards or metres; right-click restores yards', () => {
	const [out] = run(`
		UI.ShowOptions("guide")
		O.Select("guide", "Arrow & routes")
		local row = O.Controls("guide", "Arrow & routes")["nav.distanceUnit"]
		local before = row.Button.Label:GetText()
		row.Button:Click()
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Metres" then r:Click() end end
		local picked, label = Polestar.Get("nav.distanceUnit"), row.Button.Label:GetText()
		row:Click("RightButton")
		emit({ before = before, picked = picked, label = label, reset = Polestar.Get("nav.distanceUnit") })`,
		{ between: 'Polestar.RegisterDefaults("nav", { distanceUnit = "yards" })' });
	assert.deepEqual(out, { before: "Yards (the game's unit)", picked: 'metres', label: 'Metres', reset: 'yards' });
});

test('Guide, Window: In dungeons keeps the window or hides it in dungeons and raids; right-click restores Keep visible', () => {
	const [out] = run(`
		UI.ShowOptions("guide")
		local row = O.Controls("guide")["ui.instance"]
		local before = row.Button.Label:GetText()
		row.Button:Click()
		local choices = {}
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then choices[#choices + 1] = r.Text:GetText() end end
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Hide" then r:Click() end end
		local picked = Polestar.Get("ui.instance")
		row:Click("RightButton")
		emit({ label = row.Label:GetText(), before = before, choices = choices, picked = picked, reset = Polestar.Get("ui.instance") })`);
	assert.deepEqual(out, { label: 'In dungeons', before: 'Keep visible', choices: ['Keep visible', 'Hide'], picked: 'hide', reset: 'show' });
});

// Discovery, Dungeons: which dungeons the leveling guides' `when dungeon`
// steps take this character through (Dungeons/Dungeons.lua, Engine.ChooseDungeon).
test('Discovery, Dungeons: a toggle per Classic dungeon for leveling guides, all off, chosen per character in the client\'s language', () => {
	const [out] = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml'] }],
		script: `uistub.install()\nstub.login()\n${HELPERS}\nlocal UI, O, E = Polestar.UI, Polestar.UI.Options, Polestar.Engine
		Polestar.Names.Instance = function(id) if id == 389 then return "Огненная пропасть" end end
		UI.ShowOptions("dungeons")
		local c = O.Controls("discovery", "Dungeons")
		local labels, on = {}, 0
		for _, d in ipairs(Polestar.Dungeons.ROUTE) do
			local row = c[d[1] == 389 and "Огненная пропасть" or d[2]]
			labels[#labels + 1] = row and row.Label:GetText() or ("missing " .. d[2])
			if row and row.checked then on = on + 1 end
		end
		local rfc, dm = c["Огненная пропасть"], c["The Deadmines"]
		rfc:Click()
		dm:Click()
		local saved = {}
		for k, v in pairs(PolestarCharDB.dungeons) do saved[k] = v end
		local clicked = { rfc = rfc.checked, chosen = E.DungeonChosen(389), dm = E.DungeonChosen(36), saved = saved }
		local account = PolestarDB.settings.dungeons or false
		dm:Click("RightButton")
		local right = { dm = dm.checked, chosen = E.DungeonChosen(36) }
		local _, found = O.Search("Огненная")
		local b = footerButton("Reset page")
		b:Click(); b:Click()
		emit({ title = PolestarOptions.Title:GetText(), labels = labels, on = on, clicked = clicked, right = right, found = found,
			reset = { rfc = rfc.checked, chosen = E.DungeonChosen(389), saved = PolestarCharDB.dungeons },
			account = account })`,
	}).emitted;
	assert.equal(out.title, 'Discovery');
	assert.deepEqual(out.labels, ['Огненная пропасть', 'Wailing Caverns', 'The Deadmines', 'Shadowfang Keep', 'Blackfathom Deeps', 'The Stockade', 'Gnomeregan', 'Razorfen Kraul',
		'Scarlet Monastery', 'Razorfen Downs', 'Uldaman', "Zul'Farrak", 'Maraudon', 'Sunken Temple', 'Blackrock Depths', 'Blackrock Spire', 'Dire Maul', 'Scholomance', 'Stratholme']);
	assert.equal(out.on, 0, 'every dungeon is off by default: the solo route');
	assert.deepEqual(out.clicked, { rfc: true, chosen: true, dm: true, saved: { 389: true, 36: true } });
	assert.deepEqual(out.right, { dm: false, chosen: false }, 'right-click puts it back to off');
	assert.equal(out.found, 1, 'search finds the dungeon by the name it shows');
	assert.deepEqual(out.reset, { rfc: false, chosen: false, saved: {} }, 'Reset page turns the choices off too');
	assert.equal(out.account, false, 'the choice is per character, never an account setting');
});

// Guide, Automation: the answer for every group quest (`when group`), shown
// once a guide for the character has one; and the offer of a Class guide
// when it opens (QoL/ClassQuests.lua), always there.
test('Guide, Automation: an answer for all group quests while a guide has one; the class-quest offer', () => {
	const [none] = run(`
		UI.ShowOptions("guide")
		O.Select("guide", "Automation")
		local c = O.Controls("guide", "Automation")
		emit({ group = c["behavior.groupQuests"] ~= nil, offer = c["behavior.offerClassQuests"] ~= nil })`);
	assert.deepEqual(none, { group: false, offer: true }, 'no group-quest answer while no guide has a group quest');
	const [out] = run(`
		uistub.groupQuests = { { quest = 7, title = "Kobold Camp Cleanup" } }
		UI.ShowOptions("guide")
		O.Select("guide", "Automation")
		local c = O.Controls("guide", "Automation")
		local dd = c["behavior.groupQuests"]
		emit({ shown = dd ~= nil, label = dd and dd.Button.Label:GetText() or false, value = Polestar.Get("behavior.groupQuests") })`);
	assert.deepEqual(out, { shown: true, label: 'Ask me at each', value: 'ask' });
});
