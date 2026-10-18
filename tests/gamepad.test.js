'use strict';
// Playing Polestar with a gamepad (addon/Polestar/UI/Gamepad.lua and
// UI/GamepadGuide.lua; adapted from Ding! by Yendi): the guide window's
// focus mode, the navigation of every window, the combat lockout, the
// player's chords and the binding rows. The client is tests/lua/
// stub_gamepad.lua: a button goes to the frames reading the gamepad first,
// then the override bindings, then the game's own binding, as the client
// delivers it. Against the real Core, Theme and UI and the fakes of
// tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

// before: Lua run before the addon loads; atLogin: after uistub.install (which
// marks the welcome seen), before the login. The keyboard and mouse
// interface with a gamepad plugged in, and "Use with the keyboard and
// mouse" on (withMouse = false: left off, its default).
function run(script, before = '', atLogin = '', withMouse = true) {
	return runAddon({
		stubs: ['stub_ui.lua', 'stub_gamepad.lua'],
		before,
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()
${atLogin}
stub.login()
${withMouse ? 'Polestar.Set("gamepad.withMouse", true)' : ''}
local G, UI, GF = Polestar.Gamepad, Polestar.UI, Polestar.UI.GuideFrame
local pad = stub.pad
local function focused(frame)
	local w = G.Focused(frame)
	if not w then return nil end
	if w.psGoal then return w.psGoal.verb .. " " .. w.psGoal.subject end
	if w.psLabel then return w.psLabel end
	for _, k in ipairs({ "Text", "Label" }) do
		local fs = rawget(w, k)
		if type(fs) == "table" and fs.GetText then return fs:GetText() end
	end
	return "?"
end
local function count(t, v) local n = 0 for _, x in ipairs(t) do if x == v then n = n + 1 end end return n end
${script}`,
	}).emitted;
}

const NO_PAD = 'stub.pad.enabled = false';

test('the guide window never takes a button from the game while it is merely shown', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		emit({ shown = PolestarGuideFrame:IsShown(), overrides = stub.overrideCount(), up = stub.press("PADDUP"), a = stub.press("PAD1") })
	`);
	assert.deepEqual(out, { shown: true, overrides: 0, up: 'game', a: 'game' });
});

test('focus mode: the D-pad picks a line, A points the arrow there, X shows its details, LB / RB look at other steps, B gives the gamepad back', () => {
	const [start, moved, aimed, details, stepped, left] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		Polestar.Bindings.Focus()
		emit({ focusing = G.IsFocusing(), line = focused(PolestarGuideFrame), overrides = stub.overrideCount(), hints = PolestarPadHints:IsVisible() })
		stub.press("PADDDOWN")
		emit({ line = focused(PolestarGuideFrame) })
		stub.press("PADDUP")
		stub.press("PAD1")
		emit({ aim = uistub.aim, game = #pad.ran })
		local row = G.Focused(PolestarGuideFrame)
		stub.press("PAD3")
		local opened = GameTooltip.owner == row and row.Hover:IsShown() and table.concat(GameTooltip.lines, "\\n"):find("Kobold Camp Cleanup", 1, true) ~= nil
		stub.press("PAD3")
		emit({ opened = opened, closed = not row.Hover:IsShown() })
		stub.press("PADRSHOULDER")
		local after = Polestar.Engine.GetStepIndex()
		stub.press("PADLSHOULDER")
		emit({ next = after, back = Polestar.Engine.GetStepIndex(), line = focused(PolestarGuideFrame) })
		stub.press("PAD2")
		emit({ focusing = G.IsFocusing(), overrides = stub.overrideCount(), hints = PolestarPadHints:IsVisible(), down = stub.press("PADDDOWN") })
	`);
	assert.deepEqual(start, { focusing: true, line: 'Kill Kobold Vermin', overrides: 11, hints: true });
	assert.deepEqual(moved, { line: 'Collect Tough Wolf Meat' });
	assert.deepEqual(aimed, { aim: [3, 3], game: 0 });
	assert.deepEqual(details, { opened: true, closed: true });
	assert.deepEqual(stepped, { next: 4, back: 3, line: 'Kill Kobold Vermin' });
	assert.deepEqual(left, { focusing: false, overrides: 0, hints: false, down: 'game' });
});

test('focus mode: on the quest item\'s line A is the item button\'s own secure click; Y minimizes the window and ends the mode', () => {
	const [used, minimized] = run(`
		local item = CreateFrame("Button", "PolestarQuestItemButton", UIParent)
		item.itemID = 750
		local clicks = 0
		item:SetScript("OnClick", function(_, _, down) if down then clicks = clicks + 1 end end)
		Polestar.QoL = { Buttons = { item = item } }
		uistub.setGuide(uistub.elwynn, 3)
		G.StartFocus()
		stub.press("PADDDOWN")
		local line = focused(PolestarGuideFrame)
		stub.press("PAD1")
		emit({ line = line, clicks = clicks, aim = uistub.aim ~= nil })
		stub.press("PAD4")
		emit({ compact = Polestar.Get("ui.compact"), focusing = G.IsFocusing(), overrides = stub.overrideCount() })
	`);
	assert.deepEqual(used, { line: 'Collect Tough Wolf Meat', clicks: 1, aim: false });
	assert.deepEqual(minimized, { compact: true, focusing: false, overrides: 0 });
});

test('combat: the gamepad goes back to the game before the lockdown, nothing is set in a fight, and focus mode cannot start in one', () => {
	const [fight, after] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		G.StartFocus()
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.inCombat = true
		local a = stub.press("PAD1")
		local started = G.StartFocus()
		UI.ShowOptions("guide")
		emit({ focusing = G.IsFocusing(), overrides = stub.overrideCount(), a = a, started = started, blocked = #pad.blocked, options = PolestarOptions:IsShown() })
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ focusing = G.IsFocusing(), owner = G.owner == PolestarOptions, overrides = stub.overrideCount(), blocked = #pad.blocked })
	`);
	assert.deepEqual(fight, { focusing: false, overrides: 0, a: 'game', started: false, blocked: 0, options: true });
	assert.deepEqual(after, { focusing: false, owner: true, overrides: 11, blocked: 0 });
});

test('bindings change only out of combat: in a fight a button, a chord or an unbind is refused untouched, and works after it', () => {
	const [fight, after] = run(`
		pad.saved.N = "POLESTAR_TOGGLE"
		local saves = pad.saves
		stub.inCombat = true
		local bound = G.Bind("POLESTAR_NEXT", "PAD3")
		local chord = G.Bind("POLESTAR_MENU", "PADLSHOULDER+PADDUP")
		local unbound = G.Unbind("POLESTAR_TOGGLE", false)
		emit({ bound = bound, chord = chord, unbound = unbound, next = #G.BindingKeys("POLESTAR_NEXT"), menu = #G.BindingKeys("POLESTAR_MENU"), toggle = G.BindingKeys("POLESTAR_TOGGLE")[1], blocked = #pad.blocked, saves = pad.saves - saves })
		stub.inCombat = false
		emit({ chord = G.Bind("POLESTAR_MENU", "PADLSHOULDER+PADDUP"), menu = G.BindingKeys("POLESTAR_MENU")[1] })
	`);
	assert.deepEqual(fight, { bound: false, chord: false, unbound: false, next: 0, menu: 0, toggle: 'N', blocked: 0, saves: 0 });
	assert.deepEqual(after, { chord: true, menu: 'PADLSHOULDER+PADDUP' });
});

test('a window holds the gamepad only while it is open: the options take the buttons, B closes them and gives every button back', () => {
	const [open, closed] = run(`
		UI.ShowOptions("gamepad")
		stub.advance(0.3)
		emit({ owner = G.owner == PolestarOptions, overrides = stub.overrideCount(), line = focused(PolestarOptions), b = PolestarPadBadge:IsVisible() })
		stub.press("PAD2")
		emit({ shown = PolestarOptions:IsShown(), overrides = stub.overrideCount(), owner = G.owner, up = stub.press("PADDUP") })
	`);
	assert.deepEqual(open, { owner: true, overrides: 11, line: 'Button names', b: true });
	assert.deepEqual(closed, { shown: false, overrides: 0, up: 'game' });
});

// The game's gamepad turned on and a pad plugged in, the keyboard and mouse
// interface, "Use with the keyboard and mouse" left off: a mouse player's
// windows show no focus ring, hint bar or B chip, and take no button; on
// from the Gamepad page, they do.
test('with the keyboard and mouse interface the gamepad stays out of Polestar\'s windows until the player asks for it', () => {
	const [off, on] = run(`
		UI.ShowOptions("gamepad")
		stub.advance(0.3)
		emit({ active = G.IsActive(), owner = G.owner ~= nil, overrides = stub.overrideCount(), hints = PolestarPadHints ~= nil and PolestarPadHints:IsVisible() or false, b = PolestarPadBadge ~= nil and PolestarPadBadge:IsVisible() or false })
		Polestar.Set("gamepad.withMouse", true)
		stub.advance(0.3)
		emit({ active = G.IsActive(), owner = G.owner == PolestarOptions, hints = PolestarPadHints:IsVisible() })
	`, '', '', false);
	assert.deepEqual(off, { active: false, owner: false, overrides: 0, hints: false, b: false });
	assert.deepEqual(on, { active: true, owner: true, hints: true });
});

test('options with a gamepad: down moves, A switches a toggle, Y restores its default, left / right step a dropdown and a slider, LB / RB change tabs', () => {
	const [toggled, dropdown, tabs, slider] = run(`
		UI.ShowOptions("gamepad")
		stub.advance(0.3)
		stub.press("PADDDOWN")
		stub.press("PADDDOWN")
		local line = focused(PolestarOptions)
		stub.press("PAD1")
		local off = Polestar.Get("gamepad.hints")
		local bar = PolestarPadHints:IsShown()
		stub.press("PAD4")
		emit({ line = line, off = off, bar = bar, back = Polestar.Get("gamepad.hints") })
		stub.press("PADDUP")
		stub.press("PADDUP")
		stub.press("PADDRIGHT")
		local one = Polestar.Get("gamepad.glyphs")
		stub.press("PADDRIGHT")
		local two = Polestar.Get("gamepad.glyphs")
		stub.press("PADDLEFT")
		emit({ line = focused(PolestarOptions), one = one, two = two, back = Polestar.Get("gamepad.glyphs") })
		stub.press("PADRSHOULDER")
		local tab = { focused(PolestarOptions) }
		stub.press("PADLSHOULDER")
		stub.press("PADLSHOULDER")
		emit({ keys = tab[1], page = UI.Options.page.key, line = focused(PolestarOptions) })
		stub.press("PAD2")
		UI.ShowOptions("guide")
		stub.advance(0.3)
		local slider
		for _ = 1, 30 do
			local w = G.Focused(PolestarOptions)
			if w and w.psStep then slider = w break end
			stub.press("PADDDOWN")
		end
		local before = Polestar.Get(slider.psPath)
		stub.press("PADDRIGHT")
		emit({ path = slider.psPath, before = before, after = Polestar.Get(slider.psPath) })
	`);
	assert.deepEqual(toggled, { line: 'Button hints', off: false, bar: false, back: true });
	assert.deepEqual(dropdown, { line: 'Button names', one: 'xbox', two: 'playstation', back: 'xbox' });
	assert.equal(tabs.keys, 'Next step', 'RB: the Key bindings tab, its first row');
	assert.notEqual(tabs.page, 'gamepad', 'LB past the first tab: the page before');
	assert.equal(slider.after, slider.before + 1);
});

test('turning "Navigate Polestar\'s windows" off with the gamepad gives every button back at once', () => {
	const [out] = run(`
		UI.ShowOptions("gamepad")
		stub.advance(0.3)
		stub.press("PADDDOWN")
		local line = focused(PolestarOptions)
		stub.press("PAD1")
		emit({ line = line, navigate = Polestar.Get("gamepad.navigate"), overrides = stub.overrideCount(), shown = PolestarOptions:IsShown(), down = stub.press("PADDDOWN") })
	`);
	assert.deepEqual(out, { line: "Navigate Polestar's windows", navigate: false, overrides: 0, shown: true, down: 'game' });
});

test('the guide menu: the focus starts on the selected guide, LB / RB step the rail\'s sections, X loads the focused guide', () => {
	const [start, sections, loaded] = run(`
		local P = UI.Picker
		UI.ShowPicker()
		stub.advance(0.3)
		local w = G.Focused(PolestarPicker)
		emit({ guide = w and w.psGuide and w.psGuide.id, selected = P.Selected() })
		stub.press("PADRSHOULDER")
		local second = P.Section()
		stub.press("PADLSHOULDER")
		emit({ second = second, back = P.Section() })
		stub.advance(0.3)
		stub.press("PAD3")
		emit({ calls = uistub.calls, shown = PolestarPicker:IsShown(), overrides = stub.overrideCount() })
	`);
	assert.equal(start.guide, start.selected);
	assert.notEqual(sections.second, 'Guides');
	assert.equal(sections.back, 'Guides');
	assert.deepEqual(loaded, { calls: [['SetGuide', start.selected]], shown: false, overrides: 0 });
});

test('a menu over a window holds the gamepad until B, then the window has it back where it was', () => {
	const [menu, back] = run(`
		UI.ShowOptions("gamepad")
		stub.advance(0.3)
		stub.press("PAD1")
		emit({ menu = PolestarMenu:IsShown(), owner = G.owner == PolestarMenu, line = focused(PolestarMenu) })
		stub.press("PAD2")
		emit({ menu = PolestarMenu:IsShown(), owner = G.owner == PolestarOptions, line = focused(PolestarOptions), options = PolestarOptions:IsShown() })
	`);
	assert.deepEqual(menu, { menu: true, owner: true, line: 'Automatic' });
	assert.deepEqual(back, { menu: false, owner: true, line: 'Button names', options: true });
});

test('combat with a window open: the window stays for the mouse, the gamepad goes back to the game, and comes back after the fight', () => {
	const [fight, after] = run(`
		UI.ShowOptions("guide")
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.inCombat = true
		emit({ shown = PolestarOptions:IsShown(), overrides = stub.overrideCount(), down = stub.press("PADDDOWN"), ring = PolestarPadRing:IsVisible(), blocked = #pad.blocked })
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ overrides = stub.overrideCount(), down = stub.press("PADDDOWN") })
	`);
	assert.deepEqual(fight, { shown: true, overrides: 0, down: 'game', ring: false, blocked: 0 });
	assert.deepEqual(after, { overrides: 11, down: 'frame' });
});

test('without a gamepad nothing is taken and the help speaks of the mouse and the keyboard', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		local started = G.StartFocus()
		UI.ShowOptions("gamepad")
		UI.Options.Select("gamepad", "Key bindings")
		local row = UI.Options.Controls("gamepad", "Key bindings")["Next step"]
		row:Click()
		local waiting = row.Value:GetText()
		stub.key("ESCAPE")
		emit({ started = started, overrides = stub.overrideCount(), waiting = waiting, how = row.psTipLines[#row.psTipLines], capturing = G.IsCapturing(), chord = G.Store().chords.POLESTAR_OPTIONS })
	`, NO_PAD);
	assert.equal(out.started, false);
	assert.equal(out.overrides, 0);
	assert.equal(out.waiting, 'Press a key…');
	assert.match(out.how, /^Click, then press a key/);
	assert.equal(out.capturing, false, 'Escape cancels');
	assert.equal(out.chord, undefined, 'no default chord without a gamepad');
});

test('binding rows: a button alone binds as the game does, tap B cancels, two buttons make a chord, a key used elsewhere asks before replacing it, Y unbinds', () => {
	const [single, cancel, chord, conflict, unbound] = run(`
		UI.ShowOptions("gamepad")
		UI.Options.Select("gamepad", "Key bindings")
		local rows = UI.Options.Controls("gamepad", "Key bindings")
		local nextRow, prevRow, itemRow = rows["Next step"], rows["Previous step"], rows["Use quest item"]
		itemRow:Click()
		local waiting = itemRow.Value:GetText()
		stub.press("PAD3")
		emit({ waiting = waiting, saved = pad.saved.PAD3, overrides = stub.overrideCount() })
		nextRow:Click()
		stub.press("PAD2")
		emit({ capturing = G.IsCapturing(), keys = #G.BindingKeys("POLESTAR_NEXT") })
		nextRow:Click()
		stub.press("PADLSHOULDER", true)
		stub.press("PADDRIGHT", true)
		stub.press("PADDRIGHT", false)
		stub.press("PADLSHOULDER", false)
		emit({ chord = G.Store().chords.POLESTAR_NEXT, game = pad.saved.PADDRIGHT, shown = G.KeyText("POLESTAR_NEXT") })
		prevRow:Click()
		stub.press("PADLSHOULDER", true)
		stub.press("PADDRIGHT", true)
		stub.press("PADDRIGHT", false)
		stub.press("PADLSHOULDER", false)
		local asks = prevRow.Value:GetText()
		local still = G.Store().chords.POLESTAR_NEXT
		prevRow:Click()
		emit({ asks = asks, still = still, prev = G.Store().chords.POLESTAR_PREV, next = G.Store().chords.POLESTAR_NEXT or false })
		prevRow:Click("RightButton")
		emit({ prev = G.Store().chords.POLESTAR_PREV or false, label = prevRow.Value:GetText() })
	`);
	assert.deepEqual(single, { waiting: 'Press a button…', saved: 'CLICK PolestarQuestItemButton:LeftButton', overrides: 11 });
	assert.deepEqual(cancel, { capturing: false, keys: 0 });
	assert.deepEqual(chord, { chord: 'PADLSHOULDER+PADDRIGHT', shown: 'LB + D-pad right' });
	assert.equal(conflict.still, 'PADLSHOULDER+PADDRIGHT', 'nothing replaced before the second press');
	assert.match(conflict.asks, /^Used by Next step\. A again/);
	assert.deepEqual([conflict.prev, conflict.next], ['PADLSHOULDER+PADDRIGHT', false]);
	assert.deepEqual(unbound, { prev: false, label: 'Not bound' });
});

test('the quest item\'s secure click takes no chord: a second button joins only one the game makes a modifier, and is refused in words otherwise', () => {
	const [refused, combo] = run(`
		stub.cvars.GamePadEmulateShift = "PADLTRIGGER"
		UI.ShowOptions("gamepad")
		UI.Options.Select("gamepad", "Key bindings")
		local row = UI.Options.Controls("gamepad", "Key bindings")["Use quest item"]
		row:Click()
		stub.press("PADRSHOULDER", true)
		stub.press("PAD1", true)
		local said = row.Value:GetText()
		stub.press("PAD1", false)
		stub.press("PADRSHOULDER", false)
		emit({ said = said, capturing = G.IsCapturing() })
		stub.press("PADLTRIGGER", true)
		stub.press("PAD1", true)
		stub.press("PAD1", false)
		stub.press("PADLTRIGGER", false)
		emit({ saved = pad.saved["SHIFT-PAD1"], text = G.KeyText("CLICK PolestarQuestItemButton:LeftButton") })
	`);
	assert.match(refused.said, /^RB \+ A: this action takes one button, or one with LT/);
	assert.equal(refused.capturing, true);
	assert.deepEqual(combo, { saved: 'CLICK PolestarQuestItemButton:LeftButton', text: 'LT + A' });
});

test('chords in play: a chord the player bound opens its window, its second button never reaches the game, and with the other shoulder held it is the game\'s', () => {
	const [out] = run(`
		local unasked = G.Store().chords.POLESTAR_OPTIONS or false
		G.Bind("POLESTAR_OPTIONS", "PADRSHOULDER+PADDUP")
		pad.saved.PADDUP = "MOVEFORWARD"
		stub.press("PADLSHOULDER", true)
		stub.chord("PADRSHOULDER", "PADDUP")
		stub.press("PADLSHOULDER", false)
		local both = { opened = PolestarOptions ~= nil and PolestarOptions:IsShown(), game = count(pad.ran, "MOVEFORWARD") }
		stub.chord("PADRSHOULDER", "PADDUP")
		local opened = PolestarOptions and PolestarOptions:IsShown()
		emit({ unasked = unasked, both = both, opened = opened, game = count(pad.ran, "MOVEFORWARD"), shown = G.KeyText("POLESTAR_OPTIONS") })
	`);
	assert.equal(out.unasked, false, 'no chord is bound before the player binds one');
	assert.deepEqual(out.both, { opened: false, game: 1 }, 'LB + RB + Up is not RB + Up');
	assert.deepEqual({ opened: out.opened, game: out.game, shown: out.shown }, { opened: true, game: 1, shown: 'RB + D-pad up' });
});

test('a chord does nothing in a fight: its window stays shut and its button reaches the game; after the fight it works', () => {
	const [fight, after] = run(`
		G.Bind("POLESTAR_MENU", "PADRSHOULDER+PADDUP")
		pad.saved.PADDUP = "MOVEFORWARD"
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.inCombat = true
		stub.chord("PADRSHOULDER", "PADDUP")
		emit({ picker = PolestarPicker ~= nil and PolestarPicker:IsShown(), game = count(pad.ran, "MOVEFORWARD"), blocked = #pad.blocked })
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.chord("PADRSHOULDER", "PADDUP")
		emit({ picker = PolestarPicker ~= nil and PolestarPicker:IsShown(), game = count(pad.ran, "MOVEFORWARD") })
	`);
	assert.deepEqual(fight, { picker: false, game: 1, blocked: 0 });
	assert.deepEqual(after, { picker: true, game: 1 });
});

// The character's welcome still due: it shows by itself after the login.
const WELCOME_DUE = 'Polestar.CharState().welcomeSeen = 0';

test('a window that shows by itself waits: the welcome at login takes no button until the focus binding gives it the gamepad', () => {
	const [shown, asked] = run(`
		G.Bind("POLESTAR_FOCUS", "PADRSTICK")
		stub.advance(2.5)
		local hint = PolestarPadHints:IsVisible() and PolestarPadHints:GetParent() == PolestarWelcome
		emit({ shown = PolestarWelcome:IsShown(), owner = G.owner ~= nil, overrides = stub.overrideCount(), a = stub.press("PAD1"), still = PolestarWelcome:IsShown(), hint = hint })
		Polestar.Bindings.Focus()
		emit({ owner = G.owner == PolestarWelcome, focusing = G.IsFocusing(), overrides = stub.overrideCount(), next = G.Focused(PolestarWelcome) == PolestarWelcome.Next, down = stub.press("PADDDOWN") })
	`, '', WELCOME_DUE);
	assert.deepEqual(shown, { shown: true, owner: false, overrides: 0, a: 'game', still: true, hint: true });
	assert.deepEqual(asked, { owner: true, focusing: false, overrides: 11, next: true, down: 'frame' });
});

test('a window that shows by itself while a Polestar window holds the gamepad takes it over', () => {
	const [out] = run(`
		UI.ShowOptions("gamepad")
		stub.advance(0.3)
		stub.advance(2.5)
		emit({ welcome = PolestarWelcome:IsShown(), owner = G.owner == PolestarWelcome })
	`, '', WELCOME_DUE);
	assert.deepEqual(out, { welcome: true, owner: true });
});

test('an error in a binding row as a fight starts still gives every button back first', () => {
	const [out] = run(`
		UI.ShowOptions("gamepad")
		UI.Options.Select("gamepad", "Key bindings")
		local row = UI.Options.Controls("gamepad", "Key bindings")["Next step"]
		row:Click()
		local capturing = G.IsCapturing()
		row.Refresh = function() error("row broke") end
		local ok, err = pcall(stub.fire, "PLAYER_REGEN_DISABLED")
		stub.inCombat = true
		emit({ capturing = capturing, ok = ok, err = tostring(err), owner = G.owner or false, overrides = stub.overrideCount(), input = PolestarPadInput:IsShown(), capture = PolestarPadCapture:IsShown(), a = stub.press("PAD1"), blocked = #pad.blocked })
	`);
	assert.equal(out.capturing, true);
	assert.equal(out.ok, false, 'the error is reported');
	assert.match(out.err, /row broke/);
	assert.deepEqual(
		{ owner: out.owner, overrides: out.overrides, input: out.input, capture: out.capture, a: out.a, blocked: out.blocked },
		{ owner: false, overrides: 0, input: false, capture: false, a: 'game', blocked: 0 },
	);
});

// Forever's gamepad interface (ns.GamepadUI), on as the addon loads.
const GAMEPAD_UI = `Enum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }
C_InputInterfaceStyle = { GetCurrentStyle = function() return 1 end }`;

test('with the gamepad interface no override binding is set: the window\'s frame alone reads its buttons, and A on the quest item\'s line is no secure click', () => {
	const [options, focus] = run(`
		UI.ShowOptions("gamepad")
		stub.advance(0.3)
		local first = focused(PolestarOptions)
		local down = stub.press("PADDDOWN")
		emit({ owner = G.owner == PolestarOptions, overrides = stub.overrideCount(), first = first, down = down, line = focused(PolestarOptions), b = stub.press("PAD2"), shown = PolestarOptions:IsShown() })
		local item = CreateFrame("Button", "PolestarQuestItemButton", UIParent)
		item.itemID = 750
		local clicks = 0
		item:SetScript("OnClick", function(_, _, down) if down then clicks = clicks + 1 end end)
		Polestar.QoL = { Buttons = { item = item } }
		uistub.setGuide(uistub.elwynn, 3)
		G.StartFocus()
		stub.press("PADDDOWN")
		local line = focused(PolestarGuideFrame)
		emit({ focusing = G.IsFocusing(), line = line, a = stub.press("PAD1"), clicks = clicks, overrides = stub.overrideCount(), saves = pad.saves })
	`, GAMEPAD_UI);
	assert.deepEqual(options, { owner: true, overrides: 0, first: 'Button names', down: 'frame', line: "Navigate Polestar's windows", b: 'frame', shown: false });
	assert.deepEqual(focus, { focusing: true, line: 'Collect Tough Wolf Meat', a: 'frame', clicks: 0, overrides: 0, saves: 0 });
});

test('with the gamepad interface no chord is bound unasked, and a chord on LB or RB is the game\'s own', () => {
	const [out] = run(`
		local function who(key) local w = G.WhoUses("POLESTAR_OPTIONS", key) return w and w.kind or false end
		emit({ chord = G.Store().chords.POLESTAR_OPTIONS or false, rb = who("PADRSHOULDER+PADDUP"), lb = who("PADLSHOULDER+PADDUP"), face = who("PADLSHOULDER+PAD1"), lt = who("PADLTRIGGER+PADDUP") })
	`, GAMEPAD_UI);
	assert.deepEqual(out, { chord: false, rb: 'gamepad', lb: 'gamepad', face: 'gamepad', lt: false });
});

test('button names follow the gamepad: Xbox letters, PlayStation shapes when it says so, or the player\'s choice', () => {
	const [out] = run(`
		local xbox = G.KeyName("SHIFT-PAD1")
		pad.labelStyle = "Shapes"
		local ps = G.KeyName("PAD1")
		Polestar.Set("gamepad.glyphs", "xbox")
		emit({ xbox = xbox, ps = ps, chosen = G.KeyName("PAD1"), chord = G.KeyName("PADLSHOULDER+PADDUP") })
	`, 'stub.cvars.GamePadEmulateShift = "PADLTRIGGER"');
	assert.deepEqual(out, { xbox: 'LT + A', ps: 'Cross', chosen: 'A', chord: 'LB + D-pad up' });
});

test('the welcome turns its pages with LB / RB and starts on Next', () => {
	const [out] = run(`
		UI.Welcome.Show("welcome")
		stub.advance(0.3)
		local first = G.Focused(PolestarWelcome) == PolestarWelcome.Next
		local _, at = UI.Welcome.Page()
		stub.press("PADRSHOULDER")
		local _, at2 = UI.Welcome.Page()
		stub.press("PADLSHOULDER")
		local _, at3 = UI.Welcome.Page()
		emit({ first = first, at = at, at2 = at2, at3 = at3 })
	`);
	assert.deepEqual(out, { first: true, at: 1, at2: 2, at3: 1 });
});

test('B on the bar for marking the right spot goes back to the report, as Cancel does: the player\'s words and the step they reported kept', () => {
	const [out] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText("The vermin were all by the tents.")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		F.Mark:Click()
		uistub.setStep(4)
		stub.press("PAD2")
		emit({ bar = PolestarMark:IsShown(), report = F:IsShown(), desc = F.Desc:GetText(), context = F.Context:GetText() })
	`);
	assert.deepEqual(out, { bar: false, report: true, desc: 'The vermin were all by the tents.', context: 'Step 3 of 8  ·  Kobold Camp  ·  Elwynn Forest' });
});

test('the report window starts on Copy report, the way to report on Discord, once the player said what went wrong', () => {
	const [empty, said] = run(`
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		stub.advance(0.3)
		emit({ copy = G.Focused(PolestarReport) == PolestarReport.Copy, mark = G.Focused(PolestarReport) == PolestarReport.Mark })
		PolestarReport.Desc:SetText("The vermin were all by the tents.")
		stub.RunScript(PolestarReport.Desc, "OnTextChanged", true)
		PolestarReport:Hide()
		UI.ShowReport()
		stub.advance(0.3)
		emit({ copy = G.Focused(PolestarReport) == PolestarReport.Copy })
	`);
	assert.deepEqual(empty, { copy: false, mark: true }, 'nothing typed: Copy report waits, and the pad starts on Mark, never on the close button');
	assert.deepEqual(said, { copy: true });
});

test('the welcome\'s route style cards: the D-pad reaches them, A picks one, Y puts Balanced back', () => {
	const [out] = run(`
		UI.Welcome.Show("route")
		stub.advance(0.3)
		local card
		for _ = 1, 20 do
			local w = G.Focused(PolestarWelcome)
			if w and w.psStyle == "roads" then card = w break end
			stub.press("PADDDOWN")
		end
		stub.press("PAD1")
		local picked = { Polestar.Get("nav.routeStyle"), card and card.psSelected or false }
		stub.press("PAD4")
		emit({ reached = card ~= nil, picked = picked, reset = Polestar.Get("nav.routeStyle") or "balanced",
			balanced = PolestarWelcome.Styles[2].psSelected or false, roads = card and card.psSelected or false })
	`);
	assert.deepEqual(out, { reached: true, picked: ['roads', true], reset: 'balanced', balanced: true, roads: false },
		'Y puts Balanced back and moves the pick to its card');
});
