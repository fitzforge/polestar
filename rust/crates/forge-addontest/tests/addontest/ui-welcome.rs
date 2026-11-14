//! Install (addon/Polestar/UI/Welcome.lua, the welcome it grew out of) against the real Core + Theme + UI
//! manifests and the fake Engine of tests/lua/stub_ui.lua: once per new character (PolestarCharDB.welcomeSeen =
//! 1), every page while the account has not had it (PolestarDB.welcomeSeen = 1), the character's own choices
//! after that; never in combat (a fight sends it aside), never during a cinematic, never over the route choice;
//! the welcome, Questing, Groups and dungeons, Your route, Your look and the last page, with "Install · Step 2
//! of 6", the step dots, Skip install, Back, Next and Finish; each choice writing its real setting at once, its
//! default picked on a fresh account; Enter, Backspace and Escape; scaled down to fit a small screen; opened by
//! /polestar install (and /polestar welcome), About's Install tile, the settings window's Install button and its
//! search.

use std::collections::HashSet;

use forge_addontest::{emitted, truthy, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// Saved variables: an account that has had its Install, a character Polestar knew before Install had a flag,
// one that has seen it, one still due.
const ACCOUNT_SEEN: &str = "PolestarDB = { schema = 1, settings = {}, welcomeSeen = 1 }";
const ACCOUNT_NEW: &str = "PolestarDB = { schema = 1, settings = {} }";
const CHAR_KNOWN: &str = "PolestarCharDB = { schema = 1 }";
const CHAR_SEEN: &str = "PolestarCharDB = { schema = 1, welcomeSeen = 1 }";
const CHAR_DUE: &str = "PolestarCharDB = { schema = 1, welcomeSeen = 0 }";

const HEAD: &str = r#"local savedSeen = PolestarDB and PolestarDB.welcomeSeen
local savedChar = PolestarCharDB and PolestarCharDB.welcomeSeen
uistub.install()
Polestar.DB().welcomeSeen = savedSeen
Polestar.CharState().welcomeSeen = savedChar"#;

const TAIL: &str = r#"stub.login()
local Wel = Polestar.UI.Welcome
function shown() return PolestarWelcome ~= nil and PolestarWelcome:IsShown() end
function title() return (select(4, Wel.Page())) end
function key() return (Wel.Page()) end
-- "2 of 5": the page's place, as the footer says it.
function step() local _, at, n = Wel.Page(); return at .. " of " .. n end
-- The dots: how many show, which one is the accent capsule (the one wider than the rest, once its width has
-- grown: the width it is going to).
function dots()
	local n, on, widest, ties = 0, nil, 0, 0
	for i, d in ipairs(PolestarWelcome.Dots.list) do
		if d:IsShown() then
			n = n + 1
			local w = d.psW or d:GetWidth()
			if w > widest then on, widest, ties = i, w, 1 elseif w == widest then ties = ties + 1 end
		end
	end
	if ties > 1 then on = nil end
	return n .. ":" .. tostring(on)
end
function titles()
	local out = {}
	repeat
		out[#out + 1] = title()
		if not PolestarWelcome.Next:IsShown() then break end
		PolestarWelcome.Next:Click()
	until not shown() or #out > 8
	return out
end
function plain(s) return (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
-- The names of a group's option cards shown, and the one picked.
function cards(g)
	local names, picked = {}, nil
	for _, c in ipairs(g.cards) do
		if c:IsShown() then
			names[#names + 1] = c.Name:GetText()
			if c.psSelected then picked = c.Name:GetText() end
		end
	end
	return { names = names, picked = picked or false, shown = g.Title:IsShown() }
end
function card(g, name)
	for _, c in ipairs(g.cards) do if c:IsShown() and c.Name:GetText() == name then return c end end
end
-- The stat weights of a Warrior, as Gear/Weights.lua has them, without the rest of Gear.
function warrior()
	Polestar.Gear = { CLASSES = { WARRIOR = { specs = { { key = "arms", label = "Arms" }, { key = "fury", label = "Fury" },
		{ key = "protection", label = "Protection (tank)" } } } }, Client = { PlayerClass = function() return "WARRIOR" end },
		Scales = { List = function() return { { id = 7, name = "Mine" } } end } }
	Polestar.RegisterDefaults("gear", { enabled = true, spec = { WARRIOR = "auto", MAGE = "auto" } })
end"#;

// uistub.install marks Install seen for every other UI test; here the account and the character keep what
// their saved variables (and the addon loading) made of them.
fn run_with(script: &str, saved: Option<String>, before: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		saved: saved.map(|s| ("Polestar".to_string(), s)).into_iter().collect(),
		script: format!("{HEAD}\n{before}\n{TAIL}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn run(script: &str) -> Value {
	run_with(script, None, "")
}

#[test]
fn a_new_character_sees_install_once_shortly_after_login_opening_it_marks_the_character_closing_it_the_account() {
	let out = run(r#"
		local atLogin = shown()
		stub.advance(3)
		local after = shown()
		local first = title()
		local at = { step = step(), dots = dots(), text = PolestarWelcome.Step:GetText() }
		local open = { char = PolestarCharDB.welcomeSeen, account = PolestarDB.welcomeSeen or false }
		PolestarWelcome.Skip:Click()
		emit({ atLogin = atLogin, after = after, first = first, at = at, open = open, closed = not shown(),
			char = PolestarCharDB.welcomeSeen, account = PolestarDB.welcomeSeen, skip = PolestarWelcome.Skip.Label:GetText() })"#);
	assert_eq!(
		out,
		json!({ "atLogin": false, "after": true, "first": "Hello, Testchar",
			"at": { "step": "1 of 5", "dots": "5:1", "text": "Install  \u{b7}  Step 1 of 5" },
			"open": { "char": 1, "account": false }, "closed": true, "char": 1, "account": 1, "skip": "Skip install" }),
		"a reload or logout with it still up does not show it again"
	);
}

#[test]
fn a_character_with_saved_data_and_no_flag_never_gets_it_unasked_even_on_an_account_that_never_saw_it() {
	let out = run_with("stub.advance(10)\nemit({ shown = shown(), char = PolestarCharDB.welcomeSeen, account = PolestarDB.welcomeSeen or false })", Some(format!("{ACCOUNT_NEW}\n{CHAR_KNOWN}")), "");
	assert_eq!(out, json!({ "shown": false, "char": 1, "account": false }));
}

#[test]
fn a_later_login_of_a_character_that_has_seen_it_does_not_show_it() {
	let out = run_with("stub.advance(10)\nemit({ shown = shown() })", Some(format!("{ACCOUNT_SEEN}\n{CHAR_SEEN}")), "");
	assert_eq!(out["shown"], false);
}

#[test]
fn a_later_character_gets_its_own_choices_alone_the_stat_weights_of_its_class_polestar_install_shows_every_page() {
	let out = run_with(
		r#"
		warrior()
		stub.advance(3)
		local login = titles()
		local loginDots = dots()
		SlashCmdList.POLESTAR("welcome")
		PolestarWelcome.Next:Click()
		local rows = { quest = PolestarWelcome.AutoQuest:IsShown(), gear = cards(PolestarWelcome.Gear).names }
		PolestarWelcome:Hide()
		emit({ login = login, loginDots = loginDots, rows = rows, char = PolestarCharDB.welcomeSeen,
			ahead = plain(PolestarWelcome.pages.welcome.Body.Ahead:GetText()) })"#,
		Some(ACCOUNT_SEEN.to_string()),
		"",
	);
	assert_eq!(out["login"], json!(["Hello, Testchar", "Questing", "Elwynn Forest"]), "the welcome, the character's own choice, the last page");
	assert_eq!(out["loginDots"], "3:3");
	assert_eq!(out["rows"], json!({ "quest": true, "gear": ["Automatic (talents)", "Arms", "Fury", "Protection (tank)"] }), "asked for, every row");
	assert_eq!(out["char"], 1);

	// Without a choice of its own (no Gear here): the welcome and the last page, as before.
	let none = run_with("stub.advance(3)\nlocal login = titles()\nemit({ login = login, ahead = plain(PolestarWelcome.pages.welcome.Body.Ahead:GetText()) })", Some(ACCOUNT_SEEN.to_string()), "");
	assert_eq!(none["login"], json!(["Hello, Testchar", "Elwynn Forest"]));
	assert_eq!(none["ahead"], "Your settings come with you from your other characters.");
}

#[test]
fn a_later_characters_questing_page_holds_its_stat_weights_alone_the_accounts_switches_stay_out() {
	let out = run_with(
		r#"
		warrior()
		stub.advance(3)
		local ahead = plain(PolestarWelcome.pages.welcome.Body.Ahead:GetText())
		PolestarWelcome.Next:Click()
		local F = PolestarWelcome
		emit({ ahead = ahead, title = title(), rows = { F.AutoQuest:IsShown(), F.SkipGrey:IsShown(), F.AutoGuide:IsShown() },
			gear = cards(F.Gear), keep = F.pages.questing.Body.Keep:IsShown() })"#,
		Some(ACCOUNT_SEEN.to_string()),
		"",
	);
	assert_eq!(out["ahead"], "Your settings come with you from your other characters. Next, the choice that is this character's own.");
	assert_eq!(out["title"], "Questing");
	assert_eq!(out["rows"], json!([false, false, false]), "the account's settings are not asked again");
	assert_eq!(out["gear"], json!({ "names": ["Automatic (talents)", "Arms", "Fury", "Protection (tank)"], "picked": "Automatic (talents)", "shown": true }));
	assert_eq!(out["keep"], true);
}

#[test]
fn a_due_install_that_never_opened_shows_at_the_next_login() {
	let out = run_with("stub.advance(3)\nemit({ shown = shown() })", Some(format!("{ACCOUNT_SEEN}\n{CHAR_DUE}")), "");
	assert_eq!(out["shown"], true);
}

#[test]
fn an_account_that_saw_the_old_beta_notice_still_gets_install_on_a_new_character_and_the_old_flag_goes() {
	let out =
		run_with("stub.advance(3)\nemit({ shown = shown(), old = PolestarDB.betaNoticeSeen or false })", Some("PolestarDB = { schema = 1, settings = {}, betaNoticeSeen = true }".to_string()), "");
	assert_eq!(out, json!({ "shown": true, "old": false }));
}

#[test]
fn the_first_page_greets_the_character_by_name_says_what_polestar_does_shows_its_three_parts_and_what_the_next_pages_do() {
	let out = run(r#"
		Wel.Show()
		local F = PolestarWelcome
		local named = title()
		local body = F.pages.welcome.Body
		local function said(fs) return fs ~= nil and fs:IsShown() and (fs:GetText() or "") ~= "" end
		local parts = {}
		for i, c in ipairs(body.Cards) do
			parts[i] = { shown = c:IsShown(), title = said(c.Title), line = said(c.Desc), media = c.Media:IsShown() }
		end
		local line = said(body.Line)
		local ahead = plain(body.Ahead:GetText())
		F:Hide()
		uistub.player = {}
		Wel.Show()
		emit({ named = named, line = line, cards = parts, anonymous = title(), ahead = ahead })"#);
	assert_eq!(out["named"], "Hello, Testchar");
	assert_eq!(out["anonymous"], "Welcome to Polestar", "without a name");
	assert_eq!(out["line"], true, "a line on what Polestar does");
	let part = json!({ "shown": true, "title": true, "line": true, "media": true });
	assert_eq!(out["cards"], json!([part, part, part]), "three parts, each a card with its miniature, title and line");
	assert_eq!(out["ahead"], "The next pages set Polestar up for how you play. Each choice works at once, and Skip install keeps everything as it is.");
}

#[test]
fn the_last_page_names_the_suggested_guide_on_its_painting_for_this_character_leaving_out_what_is_unknown() {
	let out = run(r#"
		local g = uistub.guides[uistub.suggest]
		local function facts() return plain(PolestarWelcome.pages.finish.Hero.For:GetText()) end
		local function again() PolestarWelcome:Hide(); Wel.Show("finish"); return facts() end
		Wel.Show("finish")
		local h = PolestarWelcome.pages.finish.Hero
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
			none = { title = title(), facts = none, chip = h.Chip:IsShown(), start = PolestarWelcome.Start.Label:GetText() } })"#);
	assert_eq!(
		out["first"],
		json!({ "title": "Elwynn Forest", "chip": "Levels 1\u{2013}13",
			"facts": "Your first guide, for your level 4 Human Warrior", "start": "Start guide" }),
		"a guide named for the zone already says where"
	);
	assert_eq!(out["other"], "Your first guide, for your level 4 Human Warrior in Elwynn Forest");
	assert_eq!(out["levelOnly"], "Your first guide, for your level 7 character in Elwynn Forest");
	assert_eq!(out["nothing"], "Your first guide");
	assert_eq!(
		out["none"],
		json!({ "title": "Choose your first guide", "facts": "Polestar has no guide to suggest for where you are.",
			"chip": false, "start": "Choose a guide" })
	);
}

#[test]
fn the_close_button_and_escape_close_it_and_mark_it_seen_too() {
	let out = run(r#"
		stub.advance(3)
		PolestarWelcome.Close:Click()
		local x = { closed = not shown(), seen = PolestarCharDB.welcomeSeen }
		PolestarCharDB.welcomeSeen = 0
		Wel.Show()
		local special = false
		for _, n in ipairs(UISpecialFrames) do if n == "PolestarWelcome" then special = true end end
		PolestarWelcome:Hide()
		emit({ x = x, special = special, seen = PolestarCharDB.welcomeSeen })"#);
	assert_eq!(out, json!({ "x": { "closed": true, "seen": 1 }, "special": true, "seen": 1 }));
}

#[test]
fn in_combat_it_waits_for_the_fight_to_end() {
	let out = run_with(
		r#"
		stub.advance(3)
		local during = { shown = shown(), char = PolestarCharDB.welcomeSeen }
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ during = during, after = shown(), seen = PolestarDB.welcomeSeen or false })"#,
		None,
		"stub.inCombat = true",
	);
	assert_eq!(out, json!({ "during": { "shown": false, "char": 0 }, "after": true, "seen": false }));
}

#[test]
fn a_fight_that_starts_with_it_up_sends_it_aside_unmarked_and_it_comes_back_on_the_same_page_after() {
	let out = run(r#"
		stub.advance(3)
		PolestarWelcome.Next:Click()
		PolestarWelcome.Next:Click()
		local before = { key = key(), step = step() }
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.inCombat = true
		local during = { shown = shown(), account = PolestarDB.welcomeSeen or false }
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ before = before, during = during, after = { shown = shown(), key = key(), step = step() },
			account = PolestarDB.welcomeSeen or false })"#);
	assert_eq!(
		out,
		json!({ "before": { "key": "route", "step": "3 of 5" }, "during": { "shown": false, "account": false },
			"after": { "shown": true, "key": "route", "step": "3 of 5" }, "account": false }),
		"never over a fight, and the fight does not use it up"
	);
}

// A new character's first login plays the intro cinematic. As it starts, the client's CinematicFrame opens as
// a full-screen panel: CloseAllWindows hides every special window (Install is one) and the UI hides until it
// ends.
const CINEMATIC: &str = r#"
function InCinematic() return stub.cinematic == true end
function cinematic(on)
	stub.cinematic = on
	if on then
		for _, name in ipairs(UISpecialFrames) do local f = _G[name]; if f and f:IsShown() then f:Hide() end end
		stub.fire("CINEMATIC_START", true, 0)
	else
		stub.fire("CINEMATIC_STOP")
	end
end"#;

#[test]
fn the_intro_cinematic_does_not_use_it_up_closed_as_the_cinematic_starts_it_comes_back_on_the_same_page_after_it() {
	let out = run_with(
		r#"
		stub.advance(3)
		PolestarWelcome.Next:Click()
		local before = { shown = shown(), step = step() }
		cinematic(true)
		stub.advance(5)
		local during = { shown = shown(), account = PolestarDB.welcomeSeen or false }
		cinematic(false)
		stub.advance(2)
		emit({ before = before, during = during, after = shown(), step = step(), key = key(),
			account = PolestarDB.welcomeSeen or false })"#,
		None,
		CINEMATIC,
	);
	assert_eq!(
		out,
		json!({
			"before": { "shown": true, "step": "2 of 5" },
			"during": { "shown": false, "account": false },
			"after": true, "step": "2 of 5", "key": "questing", "account": false,
		})
	);
}

#[test]
fn a_cinematic_playing_when_install_is_due_holds_it_until_the_cinematic_ends() {
	let out = run_with(
		r#"
		cinematic(true)
		stub.advance(3)
		local during = { shown = shown(), char = PolestarCharDB.welcomeSeen }
		cinematic(false)
		stub.advance(2)
		emit({ during = during, after = shown(), first = title(), char = PolestarCharDB.welcomeSeen })"#,
		None,
		CINEMATIC,
	);
	assert_eq!(out, json!({ "during": { "shown": false, "char": 0 }, "after": true, "first": "Hello, Testchar", "char": 1 }));
}

#[test]
fn it_never_opens_over_the_route_choice_it_waits_for_that_window_to_close_and_steps_aside_if_one_opens() {
	let out = run_with(
		r#"
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
			step = step() })"#,
		Some(ACCOUNT_SEEN.to_string()),
		"",
	);
	assert_eq!(out["underChoice"], false);
	assert_eq!(out["afterChoice"], true);
	assert_eq!(out["overWelcome"], json!({ "welcome": false, "choice": true, "char": 1 }), "stepped aside, already marked shown");
	assert_eq!(out["back"], true);
	assert_eq!(out["key"], "finish", "it comes back on the page it left");
	assert_eq!(out["step"], "2 of 2", "with the pages it started with");
}

#[test]
fn the_pages_with_install_step_n_of_m_the_step_dots_skip_install_back_and_next_the_last_page_finishes() {
	let out = run(r#"
		Wel.Show()
		local F = PolestarWelcome
		local keys, steps, texts, marks, buttons = {}, {}, {}, {}, {}
		for i = 1, 5 do
			keys[i], steps[i], marks[i], texts[i] = key(), step(), dots(), F.Step:GetText()
			buttons[i] = { skip = F.Skip:IsShown(), back = F.Back:IsShown(), next = F.Next:IsShown(),
				finish = F.Finish:IsShown(), start = F.Start:IsShown(), browse = F.Browse:IsVisible() }
			if i < 5 then F.Next:Click() end
		end
		local height = F:GetHeight()
		local tallest = 0
		for _, k in ipairs(keys) do local P = F.pages[k]; tallest = math.max(tallest, P.Hero:GetHeight() + P.Body:GetHeight() + 24) end
		F.Back:Click()
		local back = { key = key(), height = F:GetHeight() }
		for _ = 1, 4 do F.Back:Click() end
		local first = key()
		stub.advance(1)
		emit({ keys = keys, steps = steps, texts = texts, marks = marks, buttons = buttons, height = height, back = back, first = first,
			fits = math.abs(height - (math.ceil(tallest) + 56 + 2)) < 0.01, idle = Polestar.Anim.Active() })"#);
	assert_eq!(out["keys"], json!(["welcome", "questing", "route", "look", "finish"]));
	assert_eq!(out["steps"], json!(["1 of 5", "2 of 5", "3 of 5", "4 of 5", "5 of 5"]));
	assert_eq!(out["texts"][2], "Install  \u{b7}  Step 3 of 5", "the footer names the flow and the step");
	assert_eq!(out["marks"], json!(["5:1", "5:2", "5:3", "5:4", "5:5"]), "the current page is the accent capsule");
	let mid = json!({ "skip": true, "back": true, "next": true, "finish": false, "start": false, "browse": false });
	assert_eq!(
		out["buttons"],
		json!([
			{ "skip": true, "back": false, "next": true, "finish": false, "start": false, "browse": false },
			mid, mid, mid,
			{ "skip": false, "back": true, "next": false, "finish": true, "start": true, "browse": true },
		])
	);
	assert_eq!(out["back"], json!({ "key": "look", "height": out["height"].clone() }), "the window keeps its height between pages");
	assert_eq!(out["fits"], true, "the window takes the tallest page");
	assert_eq!(out["first"], "welcome", "Back stops at the first page");
	assert_eq!(out["idle"], 0, "nothing runs per frame once it has settled");
}

#[test]
fn every_choice_page_says_skip_install_keeps_its_settings_and_skipping_keeps_them_as_they_are() {
	let out = run(r#"
		Polestar.RegisterDefaults("nav", { routeStyle = "balanced" })
		stub.advance(3)
		local keep = {}
		local F = PolestarWelcome
		for _ = 1, 3 do
			F.Next:Click()
			local b = F.pages[key()].Body
			keep[#keep + 1] = b.Keep:IsShown() and b.Keep:GetText() or false
		end
		local get = Polestar.Get
		local function now() return { get("behavior.autoAccept"), get("behavior.autoTurnin"), get("behavior.skipGrey"),
			get("behavior.autoSelectGuide"), get("ui.scheme"), get("nav.routeStyle") } end
		local before = now()
		F.Skip:Click()
		local skipped = { now = now(), closed = not shown(), stored = next(PolestarDB.settings) == nil }
		-- A choice made before Skip install stays made: each works at once.
		Wel.Show("questing")
		F.SkipGrey:Click()
		F.Skip:Click()
		emit({ keep = keep, before = before, skipped = skipped, kept = get("behavior.skipGrey") })"#);
	let line = json!("Skip install keeps these as they are.");
	assert_eq!(out["keep"], json!([line, line, line]), "Questing, Your route, Your look");
	assert_eq!(out["before"], json!([true, true, false, true, "dusk", "balanced"]), "the defaults, picked on a fresh account");
	assert_eq!(out["skipped"], json!({ "now": out["before"].clone(), "closed": true, "stored": true }), "nothing written");
	assert_eq!(out["kept"], true);
}

#[test]
fn the_questing_page_writes_quest_automation_both_ways_grey_quests_the_login_guide_and_the_stat_weights_of_the_class() {
	let out = run(r#"
		warrior()
		Wel.Show("questing")
		local get = Polestar.Get
		local F = PolestarWelcome
		local start = { title = title(), on = F.AutoQuest.checked, grey = F.SkipGrey.checked, guide = F.AutoGuide.checked,
			desc = uistub.findText(F, "Never picks between rewards") ~= nil, login = uistub.findText(F, "when no tab is open") ~= nil,
			greyDesc = uistub.findText(F, "unless a later quest needs them first") ~= nil }
		F.AutoQuest:Click()
		local off = { get("behavior.autoAccept"), get("behavior.autoTurnin"), F.AutoQuest.checked }
		F.AutoQuest:Click()
		local on = { get("behavior.autoAccept"), get("behavior.autoTurnin"), F.AutoQuest.checked }
		Polestar.Set("behavior.autoTurnin", false)
		local partly = F.AutoQuest.checked
		F.SkipGrey:Click()
		F.AutoGuide:Click()
		local gear = cards(F.Gear)
		card(F.Gear, "Fury"):Click()
		local fury = { get("gear.spec.WARRIOR"), cards(F.Gear).picked, get("gear.spec.MAGE") }
		card(F.Gear, "Fury"):Click("RightButton")
		local reset = { get("gear.spec.WARRIOR"), cards(F.Gear).picked }
		Polestar.Set("gear.spec.WARRIOR", "custom:7")
		Wel.Show("questing")
		local custom = cards(F.Gear)
		emit({ start = start, off = off, on = on, partly = partly, grey = get("behavior.skipGrey"), guide = get("behavior.autoSelectGuide"),
			gear = gear, fury = fury, reset = reset, custom = custom })"#);
	assert_eq!(out["start"], json!({ "title": "Questing", "on": true, "grey": false, "guide": true, "desc": true, "login": true, "greyDesc": true }), "the defaults picked, descriptions shown inline");
	assert_eq!(out["off"], json!([false, false, false]), "one switch turns both accepting and turning in off");
	assert_eq!(out["on"], json!([true, true, true]));
	assert_eq!(out["partly"], false, "on only while both are on");
	assert_eq!(out["grey"], true);
	assert_eq!(out["guide"], false);
	assert_eq!(out["gear"], json!({ "names": ["Automatic (talents)", "Arms", "Fury", "Protection (tank)"], "picked": "Automatic (talents)", "shown": true }));
	assert_eq!(out["fury"], json!(["fury", "Fury", "auto"]), "the class's own weights, at once; other classes keep theirs");
	assert_eq!(out["reset"], json!(["auto", "Automatic (talents)"]), "right-click puts Automatic back");
	assert_eq!(out["custom"]["picked"], "Custom: Mine", "a custom scale in use shows as a card of its own");
}

#[test]
fn right_clicking_the_quest_automation_switch_puts_accepting_and_turning_in_back_to_their_defaults() {
	let out = run(r#"
		Wel.Show("questing")
		local get = Polestar.Get
		local F = PolestarWelcome
		F.AutoQuest:Click()
		local off = { get("behavior.autoAccept"), get("behavior.autoTurnin") }
		F.AutoQuest:Click("RightButton")
		local reset = { get("behavior.autoAccept"), get("behavior.autoTurnin"), F.AutoQuest.checked }
		F.AutoQuest:Click("RightButton")
		emit({ off = off, reset = reset, again = { get("behavior.autoAccept"), get("behavior.autoTurnin"), F.AutoQuest.checked } })"#);
	assert_eq!(out["off"], json!([false, false]));
	assert_eq!(out["reset"], json!([true, true, true]));
	assert_eq!(out["again"], json!([true, true, true]), "from the defaults, right-click leaves them as they are");
}

// Dungeons in the route turned on (held back as they ship: Core/Init.lua's switch; the held_back_* test below).
#[test]
fn the_groups_page_shows_once_the_guides_have_dungeons_or_group_quests_and_writes_each_choice() {
	let out = run(r#"
		Polestar.dungeonRoute = true
		Wel.Show()
		local without = titles()
		PolestarWelcome:Hide()
		uistub.groupQuests = { { quest = 101, title = "Elite" } }
		Wel.Show("groups")
		local F = PolestarWelcome
		local get = Polestar.Get
		local quests = { title = title(), dungeons = cards(F.Dungeons).shown, quests = cards(F.GroupQuests),
			target = F.MarkTarget:IsVisible() }
		card(F.GroupQuests, "Do them with a group"):Click()
		local doThem = { get("behavior.groupQuests"), cards(F.GroupQuests).picked }
		card(F.GroupQuests, "Skip them"):Click()
		local skipThem = get("behavior.groupQuests")
		card(F.GroupQuests, "Skip them"):Click("RightButton")
		local reset = { get("behavior.groupQuests"), cards(F.GroupQuests).picked }
		-- "Dungeons in my route": once the setting exists and the guides have dungeons.
		Polestar.RegisterDefaults("behavior", { dungeons = "skip" })
		uistub.guideDungeons = { [1581] = true }
		Wel.Show("groups")
		local dungeons = cards(F.Dungeons)
		card(F.Dungeons, "Run them"):Click()
		local run = { get("behavior.dungeons"), cards(F.Dungeons).picked }
		card(F.Dungeons, "Ask me"):Click()
		local ask = get("behavior.dungeons")
		Wel.Show()
		emit({ without = without, quests = quests, doThem = doThem, skipThem = skipThem, reset = reset, dungeons = dungeons,
			run = run, ask = ask, pages = titles() })"#);
	assert!(!out["without"].as_array().unwrap().contains(&json!("Groups and dungeons")), "nothing to ask, no page: {}", out["without"]);
	assert_eq!(
		out["quests"],
		json!({ "title": "Groups and dungeons", "dungeons": false, "target": false,
			"quests": { "names": ["Ask me at each", "Do them with a group", "Skip them"], "picked": "Ask me at each", "shown": true } })
	);
	assert_eq!(out["doThem"], json!(["do", "Do them with a group"]), "a click writes behavior.groupQuests at once");
	assert_eq!(out["skipThem"], "skip");
	assert_eq!(out["reset"], json!(["ask", "Ask me at each"]), "right-click puts the default back");
	assert_eq!(out["dungeons"], json!({ "names": ["Skip them", "Ask me", "Run them"], "picked": "Skip them", "shown": true }), "the solo route picked on a fresh account");
	assert_eq!(out["run"], json!(["run", "Run them"]));
	assert_eq!(out["ask"], "ask");
	assert_eq!(out["pages"][2], "Groups and dungeons", "after Questing");
}

// Held back (Core/Init.lua's switch off, as it ships): guides with dungeons in their route and Run them saved, yet
// the page is Groups, about group quests only: no dungeon question, no word of dungeons; the saved answer stays.
#[test]
fn held_back_the_groups_page_asks_about_group_quests_only_and_names_no_dungeon() {
	let out = run(r#"
		Polestar.RegisterDefaults("behavior", { dungeons = "skip" })
		Polestar.Set("behavior.dungeons", "run")
		uistub.guideDungeons = { [1581] = true }
		uistub.groupQuests = { { quest = 101, title = "Elite" } }
		Wel.Show("groups")
		local F = PolestarWelcome
		local texts = {}
		local function walk(f)
			for _, r in ipairs({ f:GetRegions() }) do
				if r.GetText and r:IsVisible() and r:GetText() then texts[#texts + 1] = r:GetText() end
			end
			for _, c in ipairs({ f:GetChildren() }) do walk(c) end
		end
		walk(F)
		local dungeonWords = {}
		for _, t in ipairs(texts) do if t:lower():find("dungeon") then dungeonWords[#dungeonWords + 1] = t end end
		emit({ title = title(), dungeons = cards(F.Dungeons).shown, quests = cards(F.GroupQuests).shown, words = dungeonWords,
			route = Polestar.Get("behavior.dungeons") })"#);
	assert_eq!(out, json!({ "title": "Groups", "dungeons": false, "quests": true, "words": [], "route": "run" }));
}

// Targeting (with QoL): the target button, a preview of its face and plate, who it targets as its child, its mark
// and ping; a line says the step key targets the same without it and Move frames moves it. Each switch writes
// its setting; with the button off, who it targets waits on it.
#[test]
fn the_targeting_page_offers_the_target_button_who_it_targets_its_mark_and_ping_and_says_what_the_step_key_and_move_frames_do() {
	let out = run(r#"
		Wel.Show()
		local without = titles()
		PolestarWelcome:Hide()
		Polestar.RegisterDefaults("qol", { targetButton = true, targetPlate = true, markTarget = true, pingTarget = false })
		Wel.Show("targeting")
		local F = PolestarWelcome
		local body = F.pages.targeting.Body
		local function on(row) return row:IsShown() and row.checked or false end
		local start = { title = title(), button = on(F.TargetButton), plate = on(F.TargetPlate), mark = on(F.MarkTarget),
			ping = on(F.PingTarget), note = body.StepKey:GetText(), stage = body.Stage:IsShown() }
		F.TargetPlate:Click()
		local plate = Polestar.Get("qol.targetPlate")
		F.TargetPlate:Click("RightButton")
		F.TargetButton:Click()
		local off = Polestar.Get("qol.targetButton")
		F.TargetPlate:Click()
		local plateWhileOff = Polestar.Get("qol.targetPlate")
		F.TargetButton:Click("RightButton")
		F.MarkTarget:Click()
		F.PingTarget:Click()
		Wel.Show()
		emit({ without = without, start = start, plate = plate, off = off, plateWhileOff = plateWhileOff,
			after = { Polestar.Get("qol.markTarget"), Polestar.Get("qol.pingTarget"), Polestar.Get("qol.targetButton") }, pages = titles() })"#);
	assert!(!out["without"].as_array().unwrap().contains(&json!("Targeting")), "no QoL, no page: {}", out["without"]);
	assert_eq!(
		out["start"],
		json!({ "title": "Targeting", "button": true, "plate": true, "mark": true, "ping": false, "stage": true,
			"note": "The step key targets the same names without the button. Move frames, in Settings, moves the button." }),
		"their defaults, the preview and the line on the step key and Move frames"
	);
	assert_eq!(out["plate"], false, "who it targets writes qol.targetPlate");
	assert_eq!(out["off"], false, "the button's switch writes qol.targetButton");
	assert_eq!(out["plateWhileOff"], true, "with the button off, who it targets waits on it");
	assert_eq!(out["after"], json!([false, true, true]), "mark and ping write their settings; right-click put the button back");
	assert_eq!(out["pages"][2], "Targeting", "after Questing");
}

#[test]
fn the_route_page_three_styles_with_what_each_does_balanced_picked_on_a_fresh_account_a_click_sets_nav_routestyle_right_click_puts_balanced_back_options_moves_the_pick() {
	let out = run(r#"
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
		emit({ title = title(), note = said(route.Hero.Sub), foot = said(route.Body.Foot),
			cards = cards, fresh = fresh, roads = roads, reset = reset, options = options })"#);
	assert_eq!(out["title"], "Your route");
	assert_eq!(out["note"], true, "the note under the title");
	assert_eq!(out["foot"], true, "the footnote under the styles");
	let cards = out["cards"].as_array().unwrap();
	assert_eq!(cards.len(), 3, "three cards");
	for c in cards {
		assert!(truthy(&c[0]) && truthy(&c[1]), "{}: a name and a description", c[0]);
	}
	assert_eq!(cards.iter().map(|c| c[1].to_string()).collect::<HashSet<_>>().len(), 3, "three different descriptions");
	let chips: Vec<Value> = cards.iter().filter(|c| truthy(&c[2])).map(|c| c[0].clone()).collect();
	assert_eq!(json!(chips), json!(["Balanced"]), "the Recommended chip on Balanced only");
	assert_eq!(out["fresh"], "Balanced", "Balanced is picked on a fresh account");
	assert_eq!(out["roads"], json!(["roads", "Roads"]), "a click sets the style and moves the pick");
	assert_eq!(out["reset"], json!(["balanced", "Balanced"]), "right-click puts Balanced back");
	assert_eq!(out["options"], "Fastest", "a style changed in Options moves the pick");
}

#[test]
fn the_route_page_map_is_the_websites_demo_each_style_its_own_walk_a_switch_leaves_a_ghost_and_replays_the_trail() {
	let out = run(r#"
		-- Whatever the character's zone: the site's one example.
		uistub.guides[uistub.suggest].zone = 1412
		Wel.Show("route")
		local m = PolestarWelcome.RouteMap
		-- A set's shown lines' ends, in px on the map.
		local function drawn(set)
			local pts = {}
			for i, l in ipairs(set) do
				if l:IsShown() then
					if i == 1 then pts[#pts + 1] = ("%.1f,%.1f"):format(l.startPoint[3], l.startPoint[4]) end
					pts[#pts + 1] = ("%.1f,%.1f"):format(l.endPoint[3], l.endPoint[4])
				end
			end
			return pts
		end
		local function shown(set)
			local n = 0
			for _, l in ipairs(set) do if l:IsShown() then n = n + 1 end end
			return n
		end
		local first = { place = plain(m.Place:GetText()), trail = drawn(m.TrailCore),
			ghost = shown(m.GhostLines), road = shown(m.RoadLines), note = plain(m.Note:GetText()) }
		local seen = {}
		for _, s in ipairs({ "fastest", "roads", "balanced" }) do
			local before = Polestar.Get("nav.routeStyle") or "balanced"
			PolestarWelcome.Styles[s == "fastest" and 1 or s == "balanced" and 2 or 3]:Click()
			local just = { running = Polestar.Anim.IsRunning(m, "value"), share = m.psShare, ghost = m.psGhost,
				ghostLines = shown(m.GhostLines), roadAlpha = m.Road:GetAlpha() }
			stub.advance(0.2)
			local mid = { share = m.psShare, trail = shown(m.TrailCore) }
			stub.advance(2)
			seen[s] = { before = before, just = just, mid = mid, trail = drawn(m.TrailCore), after = m.psShare,
				ghostAlpha = m.Ghost:GetAlpha(), note = plain(m.Note:GetText()) }
		end
		Polestar.Set("ui.reduceMotion", true)
		Polestar.Set("nav.routeStyle", "roads")
		local reduced = { running = Polestar.Anim.IsRunning(m, "value"), share = m.psShare, trail = drawn(m.TrailCore),
			ghost = m.psGhost, ghostAlpha = m.Ghost:GetAlpha(), roadAlpha = m.Road:GetAlpha() }
		emit({ first = first, seen = seen, reduced = reduced })"#);
	assert_eq!(out["first"]["place"], "Elwynn Forest", "the site's zone, whatever the character's");
	assert_eq!(out["first"]["note"], "Go to Westfall \u{b7} 1519 yd", "where the walk goes, and Balanced's yards");
	assert_eq!(out["first"]["trail"], out["seen"]["balanced"]["trail"], "a fresh account sees Balanced's walk");
	assert_eq!(out["first"]["ghost"], 0, "no ghost before a switch");
	assert!(out["first"]["road"].as_u64().unwrap() > 0, "the dotted road under the trail");
	let trails: Vec<&Value> = ["fastest", "balanced", "roads"].iter().map(|s| &out["seen"][s]["trail"]).collect();
	assert_eq!(trails.iter().map(|p| p.to_string()).collect::<HashSet<_>>().len(), 3, "each style its own walk");
	for (s, p) in ["fastest", "balanced", "roads"].iter().zip(&trails) {
		let pts = p.as_array().unwrap();
		assert_eq!(pts[0], trails[0][0], "{s}: every style starts at the same place");
		assert_eq!(&pts[pts.len() - 1], trails[0].as_array().unwrap().last().unwrap(), "{s}: and ends at the same place");
		let o = &out["seen"][s];
		assert_eq!(o["just"]["running"], true, "{s}: a switch replays the trail");
		assert_eq!(o["just"]["share"], 0.0, "{s}: from the start");
		assert_eq!(o["just"]["ghost"], o["before"], "{s}: the last style's walk is the ghost");
		assert!(o["just"]["ghostLines"].as_u64().unwrap() > 0, "{s}: drawn dashed");
		assert_eq!(o["just"]["roadAlpha"], 0.0, "{s}: the new road fades in");
		let mid = o["mid"]["share"].as_f64().unwrap();
		assert!(mid > 0.0 && mid < 1.0, "{s}: part of the trail on the way: {o}");
		assert_eq!(o["after"], 1.0, "{s}: whole once replayed");
		assert_eq!(o["ghostAlpha"], 0.55, "{s}: the ghost settles faint");
	}
	let notes: HashSet<String> = ["fastest", "balanced", "roads"].iter().map(|s| out["seen"][s]["note"].to_string()).collect();
	assert_eq!(notes.len(), 3, "the note gives each style's own yards: {notes:?}");
	assert_eq!(out["reduced"]["running"], false, "under reduced motion no replay");
	assert_eq!(out["reduced"]["share"], 1.0, "the trail is whole at once");
	assert_eq!(out["reduced"]["trail"], out["seen"]["roads"]["trail"], "and it is Roads' walk");
	assert_eq!(out["reduced"]["ghost"], "balanced", "the last style left as the ghost");
	assert_eq!(out["reduced"]["ghostAlpha"], 0.55, "at once faint");
	assert_eq!(out["reduced"]["roadAlpha"], 1.0, "the road at once");
}

// The route line's look on the route page (with the route lines: Maps/RouteLines.lua, stood in for here by its
// choices and default): a card per style with its preview, the one in use marked, a click applying it,
// right-click the default; the sparkles' preview drifts while it shows and holds still under reduced motion.
#[test]
fn the_route_page_offers_the_route_line_as_line_dots_or_sparkles_each_previewed_a_click_applies_it() {
	let out = run(r#"
		Polestar.RegisterDefaults("nav", { lineStyle = "line" })
		Polestar.RouteLines = { DOT_COLORS = {}, STYLE_CHOICES = {
			{ value = "line", label = "Line" }, { value = "dots", label = "Dots" }, { value = "sparkle", label = "Sparkles" } } }
		Wel.Show("route")
		local F = PolestarWelcome
		local function names()
			local out, on = {}, nil
			for _, c in ipairs(F.Lines) do
				out[#out + 1] = c.Name:GetText()
				if c.psSelected then on = c.Name:GetText() end
			end
			return out, on
		end
		local cards, selected = names()
		local spark = F.Lines[3]
		local function at() local _, _, _, x, y = spark.Marks[1]:GetPoint(1); return x .. "," .. y end
		local a = at()
		stub.advance(0.3)
		local moved = at() ~= a
		Polestar.Set("ui.reduceMotion", true)
		stub.advance(0.1)
		local b = at()
		stub.advance(0.3)
		local still = at() == b
		F.Lines[2]:Click()
		local _, now = names()
		local set = Polestar.Get("nav.lineStyle")
		F.Lines[2]:Click("RightButton")
		local _, reset = names()
		emit({ cards = cards, selected = selected, lines = #F.Lines[1].Marks, dots = #F.Lines[2].Marks > 10, moved = moved, still = still,
			now = now, set = set, reset = reset, note = uistub.findText(F, "world map and the minimap") ~= nil, title = title() })"#);
	assert_eq!(out["cards"], json!(["Line", "Dots", "Sparkles"]));
	assert_eq!(out["selected"], "Line", "the default marked");
	assert_eq!(out["lines"], 6, "the line's preview: one piece a stretch of its path");
	assert_eq!(out["dots"], true);
	assert_eq!(out["moved"], true, "the sparkles drift toward the goal");
	assert_eq!(out["still"], true, "and hold still under reduced motion");
	assert_eq!(out["now"], "Dots");
	assert_eq!(out["set"], "dots");
	assert_eq!(out["reset"], "Line", "right-click: the default again");
	assert_eq!(out["note"], true);
	assert_eq!(out["title"], "Your route");
}

#[test]
fn the_look_page_lists_the_looks_beside_a_preview_loads_them_only_once_shown_and_a_click_puts_a_look_on_live() {
	let out = run(r#"
		Wel.Show()
		local before = Polestar.UI.Options ~= nil
		PolestarWelcome:Hide()
		Wel.Show("look")
		local F = PolestarWelcome
		local p = F.pages.look.Body
		local names, picked = {}, nil
		for _, r in ipairs(F.Skins) do
			if r:IsShown() then
				names[#names + 1] = r.Name:GetText()
				if r.psSelected then picked = r.Name:GetText() end
			end
		end
		local function find(name) for _, r in ipairs(F.Skins) do if r.Name:GetText() == name then return r end end end
		local loaded = { options = Polestar.UI.Options ~= nil, card = Polestar.Theme.DrawSkinCard ~= nil, art = p.Preview.Art:IsShown() }
		local fresh = { picked = picked, preview = p.PreviewName:GetText(), scheme = p.SchemeTitle:IsShown(), cards = #F.Schemes }
		-- The pointer previews a look without putting it on.
		stub.RunScript(find("Blizzard"), "OnEnter")
		local hover = { preview = p.PreviewName:GetText(), line = p.PreviewLine:GetText() ~= "", skin = Polestar.Get("ui.skin") }
		stub.RunScript(find("Blizzard"), "OnLeave")
		local left = p.PreviewName:GetText()
		find("Blizzard"):Click()
		local now = { skin = Polestar.Get("ui.skin"), live = Polestar.Theme.SkinId(), picked = find("Blizzard").psSelected,
			preview = p.PreviewName:GetText(), scheme = p.SchemeTitle:IsShown(), shown = shown() }
		find("Blizzard"):Click("RightButton")
		emit({ before = before, names = names, loaded = loaded, fresh = fresh, hover = hover, left = left, now = now,
			reset = { Polestar.Get("ui.skin"), p.SchemeTitle:IsShown() }, title = title() })"#);
	assert_eq!(out["before"], false, "nothing of the settings' addon before the page shows");
	assert_eq!(out["title"], "Your look");
	let names = out["names"].as_array().unwrap();
	for look in ["Polestar", "Halo", "Hearth", "WoW Forever", "Blizzard", "Classic"] {
		assert!(names.contains(&json!(look)), "{look} listed: {names:?}");
	}
	assert_eq!(out["loaded"], json!({ "options": true, "card": true, "art": true }), "the settings' skin picker draws the preview");
	assert_eq!(out["fresh"], json!({ "picked": "Polestar", "preview": "Polestar", "scheme": true, "cards": 3 }), "the house look picked, its schemes offered");
	assert_eq!(out["hover"], json!({ "preview": "Blizzard", "line": true, "skin": "polestar" }), "previewed, not put on");
	assert_eq!(out["left"], "Polestar", "back to the look in use");
	assert_eq!(
		out["now"],
		json!({ "skin": "blizzard", "live": "blizzard", "picked": true, "preview": "Blizzard", "scheme": false, "shown": true }),
		"put on at once; the house look's schemes go with it"
	);
	assert_eq!(out["reset"], json!(["polestar", true]), "right-click puts the house look back");
}

#[test]
fn the_look_page_offers_the_colour_scheme_from_its_cards_live_and_the_gamepads_button_names_while_a_gamepad_is_in_use() {
	let out = run(r#"
		Wel.Show("look")
		local get = Polestar.Get
		local F = PolestarWelcome
		local schemes, selected = {}, nil
		for _, c in ipairs(F.Schemes) do
			if c:IsShown() then
				schemes[#schemes + 1] = c.Name:GetText()
				if c.psSelected then selected = c.Name:GetText() end
			end
		end
		local before = { Polestar.Theme.Color("bg") }
		F.Schemes[3]:Click()
		local after = { Polestar.Theme.Color("bg") }
		local now
		for _, c in ipairs(F.Schemes) do if c.psSelected then now = c.Name:GetText() end end
		F.Schemes[3]:Click("RightButton")
		local mouse = cards(F.Glyphs).shown
		Polestar.Gamepad.IsActive = function() return true end
		Wel.Show("look")
		local pad = cards(F.Glyphs)
		card(F.Glyphs, "PlayStation (shapes)"):Click()
		emit({ schemes = schemes, selected = selected, scheme = F.Schemes[3].psValue, now = now, live = before[1] ~= after[1],
			reset = get("ui.scheme") or "default", mouse = mouse, pad = pad, glyphs = get("gamepad.glyphs") })"#);
	assert_eq!(out["schemes"], json!(["Dusk", "Night", "Graphite"]), "one card per scheme on offer");
	assert_eq!(out["selected"], "Dusk");
	assert_eq!(out["scheme"], "graphite");
	assert_eq!(out["now"], "Graphite", "the clicked card is marked at once");
	assert_eq!(out["live"], true, "the window re-themes in front of the player");
	assert_ne!(out["reset"], "graphite", "right-click puts the default back");
	assert_eq!(out["mouse"], false, "no gamepad, no button names");
	assert_eq!(out["pad"], json!({ "names": ["Automatic", "Xbox (A, B, X, Y)", "PlayStation (shapes)"], "picked": "Automatic", "shown": true }));
	assert_eq!(out["glyphs"], "playstation");
}

// A skin that brings its own ground colours leaves a scheme nothing to change: the look page offers no scheme
// under it; a skin that leaves the grounds to the scheme keeps the cards.
#[test]
fn the_look_page_leaves_the_colour_scheme_out_under_a_skin_that_brings_its_own_grounds() {
	let out = run(r#"
		local T = Polestar.Theme
		local function n() local k = 0 for _, c in ipairs(PolestarWelcome.Schemes) do if c:IsShown() then k = k + 1 end end return k end
		Wel.Show("look")
		local house = n()
		local own = T.SkinToken
		T.SkinToken = function(name) if name == "bg" then return 0.91, 0.86, 0.75, 1 end end
		Wel.Show("look")
		local paper = { n = n(), title = PolestarWelcome.pages.look.Body.SchemeTitle:IsShown() }
		T.SkinToken = function(name) if name == "glow" then return 1, 0.5, 0, 1 end end
		Wel.Show("look")
		local trim = n()
		T.SkinToken = own
		emit({ house = house, paper = paper, trim = trim })"#);
	assert_eq!(out["house"], 3, "the house look: its schemes");
	assert_eq!(out["paper"], json!({ "n": 0, "title": false }), "its own grounds: a scheme would change nothing");
	assert_eq!(out["trim"], 3, "the grounds left to the scheme: its cards stay");
}

#[test]
fn the_last_page_says_all_is_set_with_no_reload_finish_closes_it_and_start_guide_shows_while_the_guide_is_not_open() {
	let out = run(r#"
		Wel.Show("finish")
		local F = PolestarWelcome
		local p = F.pages.finish.Body
		local first = { start = F.Start:IsShown(), finish = F.Finish:IsShown(), head = p.Next.Head:GetText(),
			text = plain(p.Next.Text:GetText()) }
		F.Finish:Click()
		local finished = { closed = not shown(), seen = PolestarDB.welcomeSeen, char = PolestarCharDB.welcomeSeen }
		uistub.setGuide(uistub.suggest)
		Wel.Show("finish")
		emit({ first = first, finished = finished, open = { start = F.Start:IsShown(), finish = F.Finish:IsShown(),
			text = plain(p.Next.Text:GetText()) } })"#);
	assert_eq!(
		out["first"],
		json!({ "start": true, "finish": true, "head": "You're all set",
			"text": "Everything you chose works already, with no reload. Start guide opens the guide window on the right. The arrow points at your first stop." })
	);
	assert_eq!(out["finished"], json!({ "closed": true, "seen": 1, "char": 1 }), "Finish closes it, a close like any other");
	assert_eq!(
		out["open"],
		json!({ "start": false, "finish": true,
			"text": "Everything you chose works already, with no reload. Your guide is open in the guide window on the right. The arrow points at your next stop." }),
		"the guide open already: no Start guide"
	);
}

#[test]
fn the_last_page_says_where_to_change_it_all_later_and_points_to_the_recorder_each_link_opening_its_settings() {
	let out = run(r#"
		Wel.Show("finish")
		local F = PolestarWelcome
		local p = F.pages.finish.Body
		local function note(n) return { head = n.Head:IsShown() and n.Head:GetText(), text = n.Text:IsShown() and plain(n.Text:GetText()), link = n.Link:IsVisible() and n.Link.Label:GetText() } end
		local later, recorder = note(p.Later), note(p.Recorder)
		F.Settings:Click()
		local settings = { closed = not shown(), page = Polestar.UI.Options and Polestar.UI.Options.page and Polestar.UI.Options.page.key }
		Wel.Show("finish")
		F.Recorder:Click()
		emit({ later = later, recorder = recorder, settings = settings,
			rec = { closed = not shown(), page = Polestar.UI.Options.page.key, enabled = PolestarRecorderDB == nil } })"#);
	assert_eq!(
		out["later"],
		json!({ "head": "Change it later", "link": "Settings",
			"text": "Every choice here is in Settings, and its search finds any setting by name. Install opens again from there, or with /polestar install." })
	);
	assert_eq!(out["recorder"]["head"], "Help improve the routes");
	assert_eq!(out["recorder"]["link"], "Recorder");
	assert!(truthy(&out["recorder"]["text"]), "what the Recorder is");
	assert_eq!(out["settings"]["closed"], true);
	assert!(truthy(&out["settings"]["page"]), "the settings window opens: {}", out["settings"]);
	assert_eq!(out["rec"], json!({ "closed": true, "page": "recorder", "enabled": true }), "its page in Settings, nothing switched on");
}

#[test]
fn the_beta_callout_on_the_last_page_follows_ns_routesbeta() {
	let out = run(r#"
		Wel.Show("finish")
		local F = PolestarWelcome
		local n = F.pages.finish.Body.Beta
		local function note() return { chip = n.Chip:IsShown(), head = n.Head:IsShown(), text = n.Text:IsShown() and (n.Text:GetText() or "") ~= "" } end
		local beta = note()
		F:Hide()
		Polestar.routesBeta = false
		Wel.Show("finish")
		emit({ beta = beta, proven = note() })"#);
	assert_eq!(out["beta"], json!({ "chip": true, "head": true, "text": true }), "the note and its Beta chip while the routes are in beta");
	assert_eq!(out["proven"], json!({ "chip": false, "head": false, "text": false }));
}

#[test]
fn the_last_page_invites_the_player_to_the_discord_community_its_mark_and_the_invite_as_a_link_that_opens_the_copy_window() {
	let out = run(r#"
		Wel.Show("finish")
		local F = PolestarWelcome
		local n = F.pages.finish.Body.Discord
		local mark = n.Glyph
		local r, g, b = mark:GetVertexColor()
		local dr, dg, db = Polestar.Theme.Color("discord")
		local link = F.Discord
		local seen = { link = link:IsVisible() and link.Label:GetText(),
			head = n.Head:IsShown() and (n.Head:GetText() or "") ~= "", line = n.Text:IsShown() and (n.Text:GetText() or "") ~= "",
			mark = mark:IsVisible() and tostring(mark:GetTexture()):find("discord", 1, true) ~= nil,
			own = r == dr and g == dg and b == db, kind = link:GetObjectType() }
		link:Click()
		emit({ seen = seen, copy = PolestarCopy ~= nil and PolestarCopy:IsShown() and PolestarCopy.Box:GetText(),
			shared = Polestar.DiscordURL })"#);
	assert_eq!(out["seen"], json!({ "link": "discord.gg/polestar", "head": true, "line": true, "mark": true, "own": true, "kind": "Button" }), "the address reads as a link, not a field");
	assert!(truthy(&out["shared"]) && out["copy"] == out["shared"], "the copy window holds the shared invite: {}", out["copy"]);
}

#[test]
fn the_last_page_says_what_community_guides_are_with_a_link_to_browse_them() {
	let out = run(r#"
		Wel.Show("finish")
		local F = PolestarWelcome
		local n = F.pages.finish.Body.Packs
		emit({ head = n.Head:IsShown() and (n.Head:GetText() or "") ~= "", line = n.Text:IsShown() and (n.Text:GetText() or "") ~= "",
			link = n.Link == F.Browse and F.Browse:IsVisible() })"#);
	assert_eq!(out, json!({ "head": true, "line": true, "link": true }));
}

#[test]
fn the_last_page_start_guide_opens_the_suggested_guide_browse_guides_opens_the_picker_both_close_it() {
	let out = run(r#"
		Wel.Show("finish")
		local F = PolestarWelcome
		F.Start:Click()
		local opened
		for _, c in ipairs(uistub.calls) do if c[1] == "OpenTab" or c[1] == "SetGuide" then opened = c[2] end end
		local closed = not shown()
		Wel.Show("finish")
		F.Browse:Click()
		emit({ opened = opened, suggest = uistub.suggest, closed = closed,
			picker = PolestarPicker ~= nil and PolestarPicker:IsShown(), browseClosed = not shown(), seen = PolestarDB.welcomeSeen })"#);
	assert_eq!(out["opened"], out["suggest"]);
	assert_eq!(out["closed"], true);
	assert_eq!(out["picker"], true);
	assert_eq!(out["browseClosed"], true);
	assert_eq!(out["seen"], 1);

	let none = run(r#"
		uistub.suggest = nil
		Wel.Show("finish")
		PolestarWelcome.Start:Click()
		emit({ picker = PolestarPicker ~= nil and PolestarPicker:IsShown(), closed = not shown() })"#);
	assert_eq!(none, json!({ "picker": true, "closed": true }));
}

#[test]
fn enter_takes_next_and_finish_backspace_goes_back_every_other_key_goes_on_to_the_game() {
	let out = run(r#"
		Wel.Show()
		local F = PolestarWelcome
		local passed = {}
		F.SetPropagateKeyboardInput = function(_, on) passed[#passed + 1] = on end
		local function press(k) passed = {}; stub.RunScript(F, "OnKeyDown", k); return passed[1] end
		local enter = press("ENTER")
		local afterEnter = key()
		local back = press("BACKSPACE")
		local afterBack = key()
		local w = press("W")
		local esc = press("ESCAPE")
		local unmoved = key()
		Wel.Show(5)
		local last = key()
		press("ENTER")
		emit({ enter = enter, afterEnter = afterEnter, back = back, afterBack = afterBack, w = w, esc = esc, unmoved = unmoved,
			last = last, finished = not shown(), seen = PolestarDB.welcomeSeen })"#);
	assert_eq!(
		out,
		json!({ "enter": false, "afterEnter": "questing", "back": false, "afterBack": "welcome", "w": true, "esc": true,
			"unmoved": "welcome", "last": "finish", "finished": true, "seen": 1 }),
		"Enter and Backspace are its own; the rest (Escape too, which closes it through the game) goes on"
	);
}

#[test]
fn taller_than_the_screen_it_scales_itself_down_to_fit_and_back_up_on_a_screen_with_room() {
	let out = run(r#"
		Wel.Show()
		local F = PolestarWelcome
		local roomy = F:GetScale()
		F:Hide()
		-- A large UI scale: 1080 screen pixels at 2 are 540 UI units.
		local h = UIParent.height
		UIParent.height = 540
		Wel.Show()
		local small = { scale = F:GetScale(), fits = F:GetHeight() * F:GetScale() <= 540 - 48 + 0.01 }
		F:Hide()
		UIParent.height = h
		Wel.Show()
		emit({ roomy = roomy, small = small, again = F:GetScale() })"#);
	assert_eq!(out["roomy"], 1.0);
	assert!(out["small"]["scale"].as_f64().unwrap() < 1.0, "scaled down: {}", out["small"]);
	assert_eq!(out["small"]["fits"], true, "the whole window on the screen, a margin round it");
	assert_eq!(out["again"], 1.0);
}

#[test]
fn show_takes_a_page_by_key_or_by_number_among_the_pages_shown() {
	let out = run(r#"
		Wel.Show(4)
		local four = key()
		Wel.Show("questing")
		local questing = key()
		Wel.Show("beta")
		emit({ four = four, questing = questing, unknown = key() })"#);
	assert_eq!(out, json!({ "four": "look", "questing": "questing", "unknown": "welcome" }));
}

#[test]
fn polestar_install_its_welcome_alias_and_abouts_install_tile_reopen_it_on_its_first_page_with_every_page() {
	let out = run(r#"
		stub.advance(3)
		PolestarWelcome.Next:Click()
		PolestarWelcome.Skip:Click()
		Polestar.UI.ShowOptions("about")
		local tile = Polestar.UI.Options.view.Install
		local about = { label = tile.Title:GetText() }
		tile:Click()
		about.shown, about.title, about.step = shown(), title(), step()
		PolestarWelcome:Hide()
		SlashCmdList.POLESTAR("install")
		local install = { shown = shown(), title = title(), step = step() }
		PolestarWelcome:Hide()
		SlashCmdList.POLESTAR("welcome")
		emit({ about = about, install = install, welcome = { shown = shown(), title = title(), step = step() } })"#);
	let first = json!({ "shown": true, "title": "Hello, Testchar", "step": "1 of 5" });
	assert_eq!(out["about"], json!({ "label": "Install", "shown": true, "title": "Hello, Testchar", "step": "1 of 5" }));
	assert_eq!(out["install"], first);
	assert_eq!(out["welcome"], first, "its old name still opens it");
}

#[test]
fn the_settings_windows_header_has_an_install_button_and_its_search_finds_install_by_install_setup_wizard_and_first_run() {
	let out = run(r#"
		Polestar.UI.ShowOptions("guide")
		local win = PolestarOptions
		local b = win.Install
		local header = { shown = b ~= nil and b:IsShown(), label = b and b.Label:GetText(), inHeader = b and b:GetParent() == win.Header }
		b:Click()
		header.opens = shown() and title() == "Hello, Testchar"
		PolestarWelcome:Hide()
		-- Too narrow a window for it beside the page's title: left out, back with the room.
		Polestar.Set("ui.optionsSize", { 860, 600 })
		header.narrow = b:IsShown()
		Polestar.Set("ui.optionsSize", nil)
		header.wide = b:IsShown()
		local O = Polestar.UI.Options
		local found = {}
		for _, q in ipairs({ "install", "setup", "wizard", "first run" }) do
			local groups = O.Search(q)
			local hit
			for _, g in ipairs(groups) do
				for _, c in ipairs(g.controls) do if c.button == "Install" then hit = hit or { title = g.title, label = c.label } end end
			end
			found[q] = hit or false
		end
		for _, g in ipairs(O.Search("wizard")) do
			for _, c in ipairs(g.controls) do if c.button == "Install" then c.onClick() end end
		end
		emit({ header = header, found = found, opened = shown() and step() })"#);
	assert_eq!(out["header"], json!({ "shown": true, "label": "Install", "inHeader": true, "opens": true, "narrow": false, "wide": true }));
	let hit = json!({ "title": "About  \u{b7}  Install", "label": "Set Polestar up again" });
	assert_eq!(out["found"], json!({ "install": hit.clone(), "setup": hit.clone(), "wizard": hit.clone(), "first run": hit }));
	assert_eq!(out["opened"], "1 of 5", "the result opens it, every page");
}
