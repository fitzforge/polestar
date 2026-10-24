//! Playing Polestar with a gamepad (addon/Polestar/UI/Gamepad.lua and UI/GamepadGuide.lua; adapted from Ding! by
//! Yendi): the guide window's focus mode, the navigation of every window, the combat lockout, the player's chords
//! and the binding rows. The client is tests/lua/stub_gamepad.lua: a button goes to the frames reading the gamepad
//! first, then the override bindings, then the game's own binding, as the client delivers it. Against the real
//! Core, Theme and UI and the fakes of tests/lua/stub_ui.lua.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const PRELUDE: &str = r#"local G, UI, GF = Polestar.Gamepad, Polestar.UI, Polestar.UI.GuideFrame
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
"#;

// before: Lua run before the addon loads; at_login: after uistub.install (which marks the welcome seen), before
// the login. The keyboard and mouse interface with a gamepad plugged in, and "Use with the keyboard and mouse" on
// (with_mouse = false: left off, its default).
fn run_with(script: &str, before: &str, at_login: &str, with_mouse: bool) -> Vec<Value> {
	let mouse = if with_mouse { r#"Polestar.Set("gamepad.withMouse", true)"# } else { "" };
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua", "stub_gamepad.lua"],
		before: before.into(),
		addons: vec![Addon::files("Polestar", FILES)],
		script: format!("uistub.install()\n{at_login}\nstub.login()\n{mouse}\n{PRELUDE}{script}"),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, "", "", true)
}

const NO_PAD: &str = "stub.pad.enabled = false";

#[test]
fn the_guide_window_never_takes_a_button_from_the_game_while_it_is_merely_shown() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		emit({ shown = PolestarGuideFrame:IsShown(), overrides = stub.overrideCount(), up = stub.press("PADDUP"), a = stub.press("PAD1") })
	"#);
	assert_eq!(out[0], json!({ "shown": true, "overrides": 0, "up": "game", "a": "game" }));
}

#[test]
fn focus_mode_the_d_pad_picks_a_line_a_points_the_arrow_there_x_shows_its_details_lb_rb_look_at_other_steps_b_gives_the_gamepad_back() {
	let out = run(r#"
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
		local opened = GameTooltip.owner == row and row.Hover:IsShown() and table.concat(GameTooltip.lines, "\n"):find("Kobold Camp Cleanup", 1, true) ~= nil
		stub.press("PAD3")
		emit({ opened = opened, closed = not row.Hover:IsShown() })
		stub.press("PADRSHOULDER")
		local after = Polestar.Engine.GetStepIndex()
		stub.press("PADLSHOULDER")
		emit({ next = after, back = Polestar.Engine.GetStepIndex(), line = focused(PolestarGuideFrame) })
		stub.press("PAD2")
		emit({ focusing = G.IsFocusing(), overrides = stub.overrideCount(), hints = PolestarPadHints:IsVisible(), down = stub.press("PADDDOWN") })
	"#);
	assert_eq!(out[0], json!({ "focusing": true, "line": "Kill Kobold Vermin", "overrides": 11, "hints": true }));
	assert_eq!(out[1], json!({ "line": "Collect Tough Wolf Meat" }));
	assert_eq!(out[2], json!({ "aim": [3, 3], "game": 0 }));
	assert_eq!(out[3], json!({ "opened": true, "closed": true }));
	assert_eq!(out[4], json!({ "next": 4, "back": 3, "line": "Kill Kobold Vermin" }));
	assert_eq!(out[5], json!({ "focusing": false, "overrides": 0, "hints": false, "down": "game" }));
}

#[test]
fn focus_mode_on_the_quest_item_s_line_a_is_the_item_button_s_own_secure_click_y_minimizes_the_window_and_ends_the_mode() {
	let out = run(r#"
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
	"#);
	assert_eq!(out[0], json!({ "line": "Collect Tough Wolf Meat", "clicks": 1, "aim": false }));
	assert_eq!(out[1], json!({ "compact": true, "focusing": false, "overrides": 0 }));
}

#[test]
fn combat_the_gamepad_goes_back_to_the_game_before_the_lockdown_nothing_is_set_in_a_fight_and_focus_mode_cannot_start_in_one() {
	let out = run(r#"
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
	"#);
	assert_eq!(out[0], json!({ "focusing": false, "overrides": 0, "a": "game", "started": false, "blocked": 0, "options": true }));
	assert_eq!(out[1], json!({ "focusing": false, "owner": true, "overrides": 11, "blocked": 0 }));
}

#[test]
fn focus_mode_in_a_dungeon_where_the_window_waits_hidden_opens_it_there_and_starts() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		Polestar.Set("ui.instance", "hide")
		uistub.instance = "party"
		stub.fire("PLAYER_ENTERING_WORLD", false, false)
		local hidden = not PolestarGuideFrame:IsShown()
		emit({ hidden = hidden, started = G.StartFocus(), shown = PolestarGuideFrame:IsShown() })
	"#);
	assert_eq!(out[0], json!({ "hidden": true, "started": true, "shown": true }));
}

#[test]
fn bindings_change_only_out_of_combat_in_a_fight_a_button_a_chord_or_an_unbind_is_refused_untouched_and_works_after_it() {
	let out = run(r#"
		pad.saved.N = "POLESTAR_TOGGLE"
		local saves = pad.saves
		stub.inCombat = true
		local bound = G.Bind("POLESTAR_NEXT", "PAD3")
		local chord = G.Bind("POLESTAR_MENU", "PADLSHOULDER+PADDUP")
		local unbound = G.Unbind("POLESTAR_TOGGLE", false)
		emit({ bound = bound, chord = chord, unbound = unbound, next = #G.BindingKeys("POLESTAR_NEXT"), menu = #G.BindingKeys("POLESTAR_MENU"), toggle = G.BindingKeys("POLESTAR_TOGGLE")[1], blocked = #pad.blocked, saves = pad.saves - saves })
		stub.inCombat = false
		emit({ chord = G.Bind("POLESTAR_MENU", "PADLSHOULDER+PADDUP"), menu = G.BindingKeys("POLESTAR_MENU")[1] })
	"#);
	assert_eq!(out[0], json!({ "bound": false, "chord": false, "unbound": false, "next": 0, "menu": 0, "toggle": "N", "blocked": 0, "saves": 0 }));
	assert_eq!(out[1], json!({ "chord": true, "menu": "PADLSHOULDER+PADDUP" }));
}

#[test]
fn a_window_holds_the_gamepad_only_while_it_is_open_the_options_take_the_buttons_b_closes_them_and_gives_every_button_back() {
	let out = run(r#"
		UI.ShowOptions("gamepad")
		stub.advance(0.3)
		emit({ owner = G.owner == PolestarOptions, overrides = stub.overrideCount(), line = focused(PolestarOptions), b = PolestarPadBadge:IsVisible() })
		stub.press("PAD2")
		emit({ shown = PolestarOptions:IsShown(), overrides = stub.overrideCount(), owner = G.owner, up = stub.press("PADDUP") })
	"#);
	assert_eq!(out[0], json!({ "owner": true, "overrides": 11, "line": "Button names", "b": true }));
	assert_eq!(out[1], json!({ "shown": false, "overrides": 0, "up": "game" }));
}

// The game's gamepad turned on and a pad plugged in, the keyboard and mouse interface, "Use with the keyboard and
// mouse" left off: a mouse player's windows show no focus ring, hint bar or B chip, and take no button; on from
// the Gamepad page, they do.
#[test]
fn with_the_keyboard_and_mouse_interface_the_gamepad_stays_out_of_polestar_s_windows_until_the_player_asks_for_it() {
	let out = run_with(
		r#"
		UI.ShowOptions("gamepad")
		stub.advance(0.3)
		emit({ active = G.IsActive(), owner = G.owner ~= nil, overrides = stub.overrideCount(), hints = PolestarPadHints ~= nil and PolestarPadHints:IsVisible() or false, b = PolestarPadBadge ~= nil and PolestarPadBadge:IsVisible() or false })
		Polestar.Set("gamepad.withMouse", true)
		stub.advance(0.3)
		emit({ active = G.IsActive(), owner = G.owner == PolestarOptions, hints = PolestarPadHints:IsVisible() })
	"#,
		"",
		"",
		false,
	);
	assert_eq!(out[0], json!({ "active": false, "owner": false, "overrides": 0, "hints": false, "b": false }));
	assert_eq!(out[1], json!({ "active": true, "owner": true, "hints": true }));
}

#[test]
fn options_with_a_gamepad_down_moves_a_switches_a_toggle_y_restores_its_default_left_right_step_a_dropdown_and_a_slider_lb_rb_change_tabs() {
	let out = run(r#"
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
	"#);
	let (toggled, dropdown, tabs, slider) = (&out[0], &out[1], &out[2], &out[3]);
	assert_eq!(toggled, &json!({ "line": "Button hints", "off": false, "bar": false, "back": true }));
	assert_eq!(dropdown, &json!({ "line": "Button names", "one": "xbox", "two": "playstation", "back": "xbox" }));
	assert_eq!(tabs["keys"], "Next step", "RB: the Key bindings tab, its first row");
	assert_ne!(tabs["page"], "gamepad", "LB past the first tab: the page before");
	assert_eq!(slider["after"].as_f64().unwrap(), slider["before"].as_f64().unwrap() + 1.0);
}

#[test]
fn turning_navigate_polestar_s_windows_off_with_the_gamepad_gives_every_button_back_at_once() {
	let out = run(r#"
		UI.ShowOptions("gamepad")
		stub.advance(0.3)
		stub.press("PADDDOWN")
		local line = focused(PolestarOptions)
		stub.press("PAD1")
		emit({ line = line, navigate = Polestar.Get("gamepad.navigate"), overrides = stub.overrideCount(), shown = PolestarOptions:IsShown(), down = stub.press("PADDDOWN") })
	"#);
	assert_eq!(out[0], json!({ "line": "Navigate Polestar's windows", "navigate": false, "overrides": 0, "shown": true, "down": "game" }));
}

#[test]
fn the_guide_menu_the_focus_starts_on_the_selected_guide_lb_rb_step_the_rail_s_sections_x_loads_the_focused_guide() {
	let out = run(r#"
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
	"#);
	let (start, sections, loaded) = (&out[0], &out[1], &out[2]);
	assert_eq!(start["guide"], start["selected"]);
	assert_ne!(sections["second"], "Guides");
	assert_eq!(sections["back"], "Guides");
	let selected = start["selected"].clone();
	assert_eq!(loaded, &json!({ "calls": [["SetGuide", selected]], "shown": false, "overrides": 0 }));
}

#[test]
fn a_menu_over_a_window_holds_the_gamepad_until_b_then_the_window_has_it_back_where_it_was() {
	let out = run(r#"
		UI.ShowOptions("gamepad")
		stub.advance(0.3)
		stub.press("PAD1")
		emit({ menu = PolestarMenu:IsShown(), owner = G.owner == PolestarMenu, line = focused(PolestarMenu) })
		stub.press("PAD2")
		emit({ menu = PolestarMenu:IsShown(), owner = G.owner == PolestarOptions, line = focused(PolestarOptions), options = PolestarOptions:IsShown() })
	"#);
	assert_eq!(out[0], json!({ "menu": true, "owner": true, "line": "Automatic" }));
	assert_eq!(out[1], json!({ "menu": false, "owner": true, "line": "Button names", "options": true }));
}

#[test]
fn combat_with_a_window_open_the_window_stays_for_the_mouse_the_gamepad_goes_back_to_the_game_and_comes_back_after_the_fight() {
	let out = run(r#"
		UI.ShowOptions("guide")
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.inCombat = true
		emit({ shown = PolestarOptions:IsShown(), overrides = stub.overrideCount(), down = stub.press("PADDDOWN"), ring = PolestarPadRing:IsVisible(), blocked = #pad.blocked })
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ overrides = stub.overrideCount(), down = stub.press("PADDDOWN") })
	"#);
	assert_eq!(out[0], json!({ "shown": true, "overrides": 0, "down": "game", "ring": false, "blocked": 0 }));
	assert_eq!(out[1], json!({ "overrides": 11, "down": "frame" }));
}

#[test]
fn without_a_gamepad_nothing_is_taken_and_the_help_speaks_of_the_mouse_and_the_keyboard() {
	let out = run_with(
		r#"
		uistub.setGuide(uistub.elwynn, 3)
		local started = G.StartFocus()
		UI.ShowOptions("gamepad")
		UI.Options.Select("gamepad", "Key bindings")
		local row = UI.Options.Controls("gamepad", "Key bindings")["Next step"]
		row:Click()
		local waiting = row.Value:GetText()
		stub.key("ESCAPE")
		emit({ started = started, overrides = stub.overrideCount(), waiting = waiting, how = row.psTipLines[#row.psTipLines], capturing = G.IsCapturing(), chord = G.Store().chords.POLESTAR_OPTIONS })
	"#,
		NO_PAD,
		"",
		true,
	);
	let out = &out[0];
	assert_eq!(out["started"], false);
	assert_eq!(out["overrides"], 0);
	assert_eq!(out["waiting"], "Press a key…");
	assert!(is_match(text(&out["how"]), r"^Click, then press a key"));
	assert_eq!(out["capturing"], false, "Escape cancels");
	assert!(out["chord"].is_null(), "no default chord without a gamepad");
}

#[test]
fn binding_rows_a_button_alone_binds_as_the_game_does_tap_b_cancels_two_buttons_make_a_chord_a_key_used_elsewhere_asks_before_replacing_it_y_unbinds() {
	let out = run(r#"
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
	"#);
	let (single, cancel, chord, conflict, unbound) = (&out[0], &out[1], &out[2], &out[3], &out[4]);
	assert_eq!(single, &json!({ "waiting": "Press a button…", "saved": "CLICK PolestarQuestItemButton:LeftButton", "overrides": 11 }));
	assert_eq!(cancel, &json!({ "capturing": false, "keys": 0 }));
	assert_eq!(chord, &json!({ "chord": "PADLSHOULDER+PADDRIGHT", "shown": "LB + D-pad right" }));
	assert_eq!(conflict["still"], "PADLSHOULDER+PADDRIGHT", "nothing replaced before the second press");
	assert!(is_match(text(&conflict["asks"]), r"^Used by Next step\. A again"));
	assert_eq!(json!([conflict["prev"].clone(), conflict["next"].clone()]), json!(["PADLSHOULDER+PADDRIGHT", false]));
	assert_eq!(unbound, &json!({ "prev": false, "label": "Not bound" }));
}

#[test]
fn the_quest_item_s_secure_click_takes_no_chord_a_second_button_joins_only_one_the_game_makes_a_modifier_and_is_refused_in_words_otherwise() {
	let out = run(r#"
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
	"#);
	let (refused, combo) = (&out[0], &out[1]);
	assert!(is_match(text(&refused["said"]), r"^RB \+ A: this action takes one button, or one with LT"));
	assert_eq!(refused["capturing"], true);
	assert_eq!(combo, &json!({ "saved": "CLICK PolestarQuestItemButton:LeftButton", "text": "LT + A" }));
}

#[test]
fn chords_in_play_a_chord_the_player_bound_opens_its_window_its_second_button_never_reaches_the_game_and_with_the_other_shoulder_held_it_is_the_game_s() {
	let out = run(r#"
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
	"#);
	let out = &out[0];
	assert_eq!(out["unasked"], false, "no chord is bound before the player binds one");
	assert_eq!(out["both"], json!({ "opened": false, "game": 1 }), "LB + RB + Up is not RB + Up");
	assert_eq!(json!({ "opened": out["opened"].clone(), "game": out["game"].clone(), "shown": out["shown"].clone() }), json!({ "opened": true, "game": 1, "shown": "RB + D-pad up" }));
}

#[test]
fn a_chord_does_nothing_in_a_fight_its_window_stays_shut_and_its_button_reaches_the_game_after_the_fight_it_works() {
	let out = run(r#"
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
	"#);
	assert_eq!(out[0], json!({ "picker": false, "game": 1, "blocked": 0 }));
	assert_eq!(out[1], json!({ "picker": true, "game": 1 }));
}

// The character's welcome still due: it shows by itself after the login.
const WELCOME_DUE: &str = "Polestar.CharState().welcomeSeen = 0";

#[test]
fn a_window_that_shows_by_itself_waits_the_welcome_at_login_takes_no_button_until_the_focus_binding_gives_it_the_gamepad() {
	let out = run_with(
		r#"
		G.Bind("POLESTAR_FOCUS", "PADRSTICK")
		stub.advance(2.5)
		local hint = PolestarPadHints:IsVisible() and PolestarPadHints:GetParent() == PolestarWelcome
		emit({ shown = PolestarWelcome:IsShown(), owner = G.owner ~= nil, overrides = stub.overrideCount(), a = stub.press("PAD1"), still = PolestarWelcome:IsShown(), hint = hint })
		Polestar.Bindings.Focus()
		emit({ owner = G.owner == PolestarWelcome, focusing = G.IsFocusing(), overrides = stub.overrideCount(), next = G.Focused(PolestarWelcome) == PolestarWelcome.Next, down = stub.press("PADDDOWN") })
	"#,
		"",
		WELCOME_DUE,
		true,
	);
	assert_eq!(out[0], json!({ "shown": true, "owner": false, "overrides": 0, "a": "game", "still": true, "hint": true }));
	assert_eq!(out[1], json!({ "owner": true, "focusing": false, "overrides": 11, "next": true, "down": "frame" }));
}

#[test]
fn a_window_that_shows_by_itself_while_a_polestar_window_holds_the_gamepad_takes_it_over() {
	let out = run_with(
		r#"
		UI.ShowOptions("gamepad")
		stub.advance(0.3)
		stub.advance(2.5)
		emit({ welcome = PolestarWelcome:IsShown(), owner = G.owner == PolestarWelcome })
	"#,
		"",
		WELCOME_DUE,
		true,
	);
	assert_eq!(out[0], json!({ "welcome": true, "owner": true }));
}

#[test]
fn an_error_in_a_binding_row_as_a_fight_starts_still_gives_every_button_back_first() {
	let out = run(r#"
		UI.ShowOptions("gamepad")
		UI.Options.Select("gamepad", "Key bindings")
		local row = UI.Options.Controls("gamepad", "Key bindings")["Next step"]
		row:Click()
		local capturing = G.IsCapturing()
		row.Refresh = function() error("row broke") end
		local ok, err = pcall(stub.fire, "PLAYER_REGEN_DISABLED")
		stub.inCombat = true
		emit({ capturing = capturing, ok = ok, err = tostring(err), owner = G.owner or false, overrides = stub.overrideCount(), input = PolestarPadInput:IsShown(), capture = PolestarPadCapture:IsShown(), a = stub.press("PAD1"), blocked = #pad.blocked })
	"#);
	let out = &out[0];
	assert_eq!(out["capturing"], true);
	assert_eq!(out["ok"], false, "the error is reported");
	assert!(is_match(text(&out["err"]), r"row broke"));
	assert_eq!(
		json!({
			"owner": out["owner"].clone(),
			"overrides": out["overrides"].clone(),
			"input": out["input"].clone(),
			"capture": out["capture"].clone(),
			"a": out["a"].clone(),
			"blocked": out["blocked"].clone(),
		}),
		json!({ "owner": false, "overrides": 0, "input": false, "capture": false, "a": "game", "blocked": 0 })
	);
}

// Forever's gamepad interface (ns.GamepadUI), on as the addon loads.
const GAMEPAD_UI: &str = r#"Enum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }
C_InputInterfaceStyle = { GetCurrentStyle = function() return 1 end }"#;

#[test]
fn with_the_gamepad_interface_no_override_binding_is_set_the_window_s_frame_alone_reads_its_buttons_and_a_on_the_quest_item_s_line_is_no_secure_click() {
	let out = run_with(
		r#"
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
	"#,
		GAMEPAD_UI,
		"",
		true,
	);
	assert_eq!(out[0], json!({ "owner": true, "overrides": 0, "first": "Button names", "down": "frame", "line": "Navigate Polestar's windows", "b": "frame", "shown": false }));
	assert_eq!(out[1], json!({ "focusing": true, "line": "Collect Tough Wolf Meat", "a": "frame", "clicks": 0, "overrides": 0, "saves": 0 }));
}

#[test]
fn with_the_gamepad_interface_no_chord_is_bound_unasked_and_a_chord_on_lb_or_rb_is_the_game_s_own() {
	let out = run_with(
		r#"
		local function who(key) local w = G.WhoUses("POLESTAR_OPTIONS", key) return w and w.kind or false end
		emit({ chord = G.Store().chords.POLESTAR_OPTIONS or false, rb = who("PADRSHOULDER+PADDUP"), lb = who("PADLSHOULDER+PADDUP"), face = who("PADLSHOULDER+PAD1"), lt = who("PADLTRIGGER+PADDUP") })
	"#,
		GAMEPAD_UI,
		"",
		true,
	);
	assert_eq!(out[0], json!({ "chord": false, "rb": "gamepad", "lb": "gamepad", "face": "gamepad", "lt": false }));
}

#[test]
fn button_names_follow_the_gamepad_xbox_letters_playstation_shapes_when_it_says_so_or_the_player_s_choice() {
	let out = run_with(
		r#"
		local xbox = G.KeyName("SHIFT-PAD1")
		pad.labelStyle = "Shapes"
		local ps = G.KeyName("PAD1")
		Polestar.Set("gamepad.glyphs", "xbox")
		emit({ xbox = xbox, ps = ps, chosen = G.KeyName("PAD1"), chord = G.KeyName("PADLSHOULDER+PADDUP") })
	"#,
		r#"stub.cvars.GamePadEmulateShift = "PADLTRIGGER""#,
		"",
		true,
	);
	assert_eq!(out[0], json!({ "xbox": "LT + A", "ps": "Cross", "chosen": "A", "chord": "LB + D-pad up" }));
}

#[test]
fn the_welcome_turns_its_pages_with_lb_rb_and_starts_on_next() {
	let out = run(r#"
		UI.Welcome.Show("welcome")
		stub.advance(0.3)
		local first = G.Focused(PolestarWelcome) == PolestarWelcome.Next
		local _, at = UI.Welcome.Page()
		stub.press("PADRSHOULDER")
		local _, at2 = UI.Welcome.Page()
		stub.press("PADLSHOULDER")
		local _, at3 = UI.Welcome.Page()
		emit({ first = first, at = at, at2 = at2, at3 = at3 })
	"#);
	assert_eq!(out[0], json!({ "first": true, "at": 1, "at2": 2, "at3": 1 }));
}

#[test]
fn b_on_the_bar_for_marking_the_right_spot_goes_back_to_the_report_as_cancel_does_the_player_s_words_and_the_step_they_reported_kept() {
	let out = run(r#"
		uistub.setGuide(uistub.elwynn, 3)
		UI.ShowReport()
		local F = PolestarReport
		F.Desc:SetText("The vermin were all by the tents.")
		stub.RunScript(F.Desc, "OnTextChanged", true)
		F.Mark:Click()
		uistub.setStep(4)
		stub.press("PAD2")
		emit({ bar = PolestarMark:IsShown(), report = F:IsShown(), desc = F.Desc:GetText(), context = F.Context:GetText() })
	"#);
	assert_eq!(out[0], json!({ "bar": false, "report": true, "desc": "The vermin were all by the tents.", "context": "Step 3 of 8  ·  Kobold Camp  ·  Elwynn Forest" }));
}

#[test]
fn the_report_window_starts_on_copy_report_the_way_to_report_on_discord_once_the_player_said_what_went_wrong() {
	let out = run(r#"
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
	"#);
	assert_eq!(out[0], json!({ "copy": false, "mark": true }), "nothing typed: Copy report waits, and the pad starts on Mark, never on the close button");
	assert_eq!(out[1], json!({ "copy": true }));
}

#[test]
fn the_welcome_s_route_style_cards_the_d_pad_reaches_them_a_picks_one_y_puts_balanced_back() {
	let out = run(r#"
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
	"#);
	assert_eq!(out[0], json!({ "reached": true, "picked": ["roads", true], "reset": "balanced", "balanced": true, "roads": false }), "Y puts Balanced back and moves the pick to its card");
}
