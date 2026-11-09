//! The welcome (addon/Polestar/UI/Welcome.lua) against the real Core + Theme + UI manifests and the fake Engine
//! of tests/lua/stub_ui.lua: once per new character (PolestarCharDB.welcomeSeen = 1), with setup and the route
//! style only while the account has not had one (PolestarDB.welcomeSeen = 1); never in combat, never during a
//! cinematic, never over the route choice; four pages (welcome, setup, route, start; two for a later character)
//! with step dots; setup choices that write their settings, the scheme cards applying live; the route style's
//! cards setting nav.routeStyle; a start page that names the suggested guide for the character, the beta callout
//! while the routes are in beta, the Discord invite and guide packs; opened from About and by /polestar welcome.

use std::collections::HashSet;

use forge_addontest::{emitted, truthy, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// Saved variables: an account that has had its welcome, a character Polestar knew before the welcome had a
// flag, one that has seen it, one still due.
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
-- "2 of 4": the page's place, as the step dots show it.
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
	until not shown() or #out > 6
	return out
end
function plain(s) return (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end"#;

// uistub.install marks the welcome seen for every other UI test; here the account and the character keep what
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
fn a_new_character_sees_the_welcome_once_shortly_after_login_opening_it_marks_the_character_closing_it_the_account() {
	let out = run(r#"
		local atLogin = shown()
		stub.advance(3)
		local after = shown()
		local first = title()
		local at = { step = step(), dots = dots() }
		local open = { char = PolestarCharDB.welcomeSeen, account = PolestarDB.welcomeSeen or false }
		PolestarWelcome.Skip:Click()
		emit({ atLogin = atLogin, after = after, first = first, at = at, open = open, closed = not shown(),
			char = PolestarCharDB.welcomeSeen, account = PolestarDB.welcomeSeen })"#);
	assert_eq!(
		out,
		json!({ "atLogin": false, "after": true, "first": "Hello, Testchar", "at": { "step": "1 of 4", "dots": "4:1" },
			"open": { "char": 1, "account": false }, "closed": true, "char": 1, "account": 1 }),
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
fn a_new_character_on_an_account_that_has_had_its_welcome_gets_it_without_setup_or_the_route_style_polestar_welcome_shows_every_page() {
	let out = run_with(
		r#"
		stub.advance(3)
		local login = titles()
		local loginDots = dots()
		SlashCmdList.POLESTAR("welcome")
		local asked = titles()
		emit({ login = login, loginDots = loginDots, asked = asked, askedDots = dots(), char = PolestarCharDB.welcomeSeen })"#,
		Some(ACCOUNT_SEEN.to_string()),
		"",
	);
	assert_eq!(out["login"], json!(["Hello, Testchar", "Elwynn Forest"]));
	assert_eq!(out["loginDots"], "2:2");
	assert_eq!(out["asked"], json!(["Hello, Testchar", "Make it yours", "Route style", "Elwynn Forest"]));
	assert_eq!(out["askedDots"], "4:4");
	assert_eq!(out["char"], 1);
}

#[test]
fn a_due_welcome_that_never_opened_shows_at_the_next_login() {
	let out = run_with("stub.advance(3)\nemit({ shown = shown() })", Some(format!("{ACCOUNT_SEEN}\n{CHAR_DUE}")), "");
	assert_eq!(out["shown"], true);
}

#[test]
fn an_account_that_saw_the_old_beta_notice_still_gets_the_welcome_on_a_new_character_and_the_old_flag_goes() {
	let out =
		run_with("stub.advance(3)\nemit({ shown = shown(), old = PolestarDB.betaNoticeSeen or false })", Some("PolestarDB = { schema = 1, settings = {}, betaNoticeSeen = true }".to_string()), "");
	assert_eq!(out, json!({ "shown": true, "old": false }));
}

#[test]
fn the_first_page_greets_the_character_by_name_says_what_polestar_does_and_shows_its_three_parts() {
	let out = run(r#"
		Wel.Show()
		local F = PolestarWelcome
		local named = title()
		local body = F.pages.welcome.Body
		local function said(fs) return fs ~= nil and fs:IsShown() and (fs:GetText() or "") ~= "" end
		local cards = {}
		for i, c in ipairs(body.Cards) do
			cards[i] = { shown = c:IsShown(), title = said(c.Title), line = said(c.Desc), media = c.Media:IsShown() }
		end
		local line = said(body.Line)
		F:Hide()
		uistub.player = {}
		Wel.Show()
		emit({ named = named, line = line, cards = cards, anonymous = title() })"#);
	assert_eq!(out["named"], "Hello, Testchar");
	assert_eq!(out["anonymous"], "Welcome to Polestar", "without a name");
	assert_eq!(out["line"], true, "a line on what Polestar does");
	let part = json!({ "shown": true, "title": true, "line": true, "media": true });
	assert_eq!(out["cards"], json!([part, part, part]), "three parts, each a card with its miniature, title and line");
}

#[test]
fn the_start_page_names_the_suggested_guide_on_its_painting_for_this_character_leaving_out_what_is_unknown() {
	let out = run(r#"
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
fn the_and_escape_close_it_and_mark_it_seen_too() {
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

// A new character's first login plays the intro cinematic. As it starts, the client's CinematicFrame opens as
// a full-screen panel: CloseAllWindows hides every special window (the welcome is one) and the UI hides until
// it ends.
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
			"before": { "shown": true, "step": "2 of 4" },
			"during": { "shown": false, "account": false },
			"after": true, "step": "2 of 4", "key": "setup", "account": false,
		})
	);
}

#[test]
fn a_cinematic_playing_when_the_welcome_is_due_holds_it_until_the_cinematic_ends() {
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
	assert_eq!(out["key"], "start", "it comes back on the page it left");
	assert_eq!(out["step"], "2 of 2", "with the pages it started with");
}

#[test]
fn four_pages_with_next_and_back_and_the_step_dots_the_last_page_holds_the_guide_buttons() {
	let out = run(r#"
		Wel.Show()
		local F = PolestarWelcome
		local keys, steps, marks, buttons = {}, {}, {}, {}
		for i = 1, 4 do
			keys[i], steps[i], marks[i] = key(), step(), dots()
			buttons[i] = { skip = F.Skip:IsShown(), back = F.Back:IsShown(), next = F.Next:IsShown(),
				start = F.Start:IsShown(), browse = F.Browse:IsVisible() }
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
			idle = Polestar.Anim.Active() })"#);
	assert_eq!(out["keys"], json!(["welcome", "setup", "route", "start"]));
	assert_eq!(out["steps"], json!(["1 of 4", "2 of 4", "3 of 4", "4 of 4"]));
	assert_eq!(out["marks"], json!(["4:1", "4:2", "4:3", "4:4"]), "the current page is the accent capsule");
	assert_eq!(
		out["buttons"],
		json!([
			{ "skip": true, "back": false, "next": true, "start": false, "browse": false },
			{ "skip": true, "back": true, "next": true, "start": false, "browse": false },
			{ "skip": true, "back": true, "next": true, "start": false, "browse": false },
			{ "skip": false, "back": true, "next": false, "start": true, "browse": true },
		])
	);
	assert_eq!(out["back"], json!({ "key": "route", "height": out["height"].clone() }), "the window keeps its height between pages");
	assert_eq!(out["first"], "welcome", "Back stops at the first page");
	assert_eq!(out["idle"], 0, "nothing runs per frame once it has settled");
}

#[test]
fn the_beta_callout_on_the_start_page_follows_ns_routesbeta() {
	let out = run(r#"
		Wel.Show("start")
		local F = PolestarWelcome
		local n = F.pages.start.Body.Beta
		local function note() return { chip = n.Chip:IsShown(), head = n.Head:IsShown(), text = n.Text:IsShown() and (n.Text:GetText() or "") ~= "" } end
		local beta = note()
		F:Hide()
		Polestar.routesBeta = false
		Wel.Show("start")
		emit({ beta = beta, proven = note() })"#);
	assert_eq!(out["beta"], json!({ "chip": true, "head": true, "text": true }), "the note and its Beta chip while the routes are in beta");
	assert_eq!(out["proven"], json!({ "chip": false, "head": false, "text": false }));
}

#[test]
fn the_start_page_invites_the_player_to_the_discord_community_its_mark_and_the_invite_as_a_link_that_opens_the_copy_window() {
	let out = run(r#"
		Wel.Show("start")
		local F = PolestarWelcome
		local n = F.pages.start.Body.Discord
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
fn the_start_page_says_what_community_guides_are_with_a_link_to_browse_them() {
	let out = run(r#"
		Wel.Show("start")
		local F = PolestarWelcome
		local n = F.pages.start.Body.Packs
		emit({ head = n.Head:IsShown() and (n.Head:GetText() or "") ~= "", line = n.Text:IsShown() and (n.Text:GetText() or "") ~= "",
			link = n.Link == F.Browse and F.Browse:IsVisible() })"#);
	assert_eq!(out, json!({ "head": true, "line": true, "link": true }));
}

#[test]
fn the_setup_page_writes_its_settings_quest_automation_both_ways_the_login_guide_and_the_scheme_from_its_cards() {
	let out = run(r#"
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
			stillShown = shown() })"#);
	assert_eq!(out["start"], json!({ "title": "Make it yours", "on": true, "desc": true, "login": true }), "descriptions shown inline");
	assert_eq!(out["off"], json!([false, false, false]), "one switch turns both accepting and turning in off");
	assert_eq!(out["on"], json!([true, true, true]));
	assert_eq!(out["partly"], false, "on only while both are on");
	assert_eq!(out["guide"], false);
	assert_eq!(out["cards"], json!(["Dusk", "Night", "Graphite"]), "one card per scheme on offer");
	assert_eq!(out["selected"], "Dusk");
	assert_eq!(out["scheme"], "graphite");
	assert_eq!(out["now"], "Graphite", "the clicked card is marked at once");
	assert_eq!(out["live"], true, "the window re-themes in front of the player");
	assert_ne!(out["reset"], "graphite", "right-click puts the default back");
	assert_eq!(out["stillShown"], true);
}

#[test]
fn right_clicking_the_quest_automation_switch_puts_accepting_and_turning_in_back_to_their_defaults() {
	let out = run(r#"
		Wel.Show("setup")
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
			cards = cards, fresh = fresh, roads = roads, reset = reset, options = options,
			fits = F.pages.route:GetHeight() <= F.pages.setup:GetHeight() })"#);
	assert!(truthy(&out["title"]), "the page has a title");
	assert_eq!(out["note"], true, "the note under the title");
	assert_eq!(out["foot"], true, "the footnote under the cards");
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
	assert_eq!(out["fits"], true, "the route page fits in the window setup sizes");
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

#[test]
fn the_start_page_start_guide_opens_the_suggested_guide_browse_guides_opens_the_picker_both_close_it() {
	let out = run(r#"
		Wel.Show("start")
		local F = PolestarWelcome
		F.Start:Click()
		local opened
		for _, c in ipairs(uistub.calls) do if c[1] == "OpenTab" or c[1] == "SetGuide" then opened = c[2] end end
		local closed = not shown()
		Wel.Show("start")
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
		Wel.Show("start")
		PolestarWelcome.Start:Click()
		emit({ picker = PolestarPicker ~= nil and PolestarPicker:IsShown(), closed = not shown() })"#);
	assert_eq!(none, json!({ "picker": true, "closed": true }));
}

#[test]
fn show_takes_a_page_by_key_or_by_number_among_the_pages_shown() {
	let out = run(r#"
		Wel.Show(4)
		local four = key()
		Wel.Show("setup")
		local setup = key()
		Wel.Show("beta")
		emit({ four = four, setup = setup, unknown = key() })"#);
	assert_eq!(out, json!({ "four": "start", "setup": "setup", "unknown": "welcome" }));
}

#[test]
fn about_and_polestar_welcome_reopen_it_on_its_first_page() {
	let out = run(r#"
		stub.advance(3)
		PolestarWelcome.Next:Click()
		PolestarWelcome.Skip:Click()
		Polestar.UI.ShowOptions("about")
		Polestar.UI.Options.view.Welcome:Click()
		local about = { shown = shown(), title = title(), step = step() }
		PolestarWelcome:Hide()
		SlashCmdList.POLESTAR("welcome")
		emit({ about = about, command = shown(), title = title() })"#);
	assert_eq!(out, json!({ "about": { "shown": true, "title": "Hello, Testchar", "step": "1 of 4" }, "command": true, "title": "Hello, Testchar" }));
}

// The route line's look on the setup page (with the route lines: Maps/RouteLines.lua, stood in for here by its
// choices and default): a card per style with its preview, the one in use marked, a click applying it,
// right-click the default; the sparkles' preview drifts while it shows and holds still under reduced motion.
#[test]
fn the_setup_page_offers_the_route_line_as_line_dots_or_sparkles_each_previewed_a_click_applies_it() {
	let out = run(r#"
		Polestar.RegisterDefaults("nav", { lineStyle = "line" })
		Polestar.RouteLines = { DOT_COLORS = {}, STYLE_CHOICES = {
			{ value = "line", label = "Line" }, { value = "dots", label = "Dots" }, { value = "sparkle", label = "Sparkles" } } }
		Wel.Show("setup")
		local F = PolestarWelcome
		local function names()
			local out, on = {}, nil
			for _, c in ipairs(F.Looks) do
				out[#out + 1] = c.Name:GetText()
				if c.psSelected then on = c.Name:GetText() end
			end
			return out, on
		end
		local cards, selected = names()
		local spark = F.Looks[3]
		local function at() local _, _, _, x, y = spark.Marks[1]:GetPoint(1); return x .. "," .. y end
		local a = at()
		stub.advance(0.3)
		local moved = at() ~= a
		Polestar.Set("ui.reduceMotion", true)
		stub.advance(0.1)
		local b = at()
		stub.advance(0.3)
		local still = at() == b
		F.Looks[2]:Click()
		local _, now = names()
		local set = Polestar.Get("nav.lineStyle")
		F.Looks[2]:Click("RightButton")
		local _, reset = names()
		emit({ cards = cards, selected = selected, lines = #F.Looks[1].Marks, dots = #F.Looks[2].Marks > 10, moved = moved, still = still,
			now = now, set = set, reset = reset, note = uistub.findText(F, "easiest to follow") ~= nil,
			fits = F.pages.route:GetHeight() <= F.pages.setup:GetHeight() })"#);
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
	assert_eq!(out["fits"], true, "the route page still fits the window setup sizes");
}
