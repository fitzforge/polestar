//! Freedoom Arcade on flights (addon/Polestar/Maps/Arcade.lua): the card under the flight timer, the game opened
//! through FreedoomArcadeAPI or else the standalone addon's slash command (never toggled closed), the game put
//! away 10 seconds before landing, and Polestar_Arcade, the copy in Polestar's download: loaded on demand, never
//! beside the standalone addon, its commands left to whoever has them. Runs Core, Theme, Nav and Maps against
//! stub_world.lua + stub_maps.lua (the small travel world: West Hold to Mid Camp, flown here in a set time).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 5] = ["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Maps/Maps.xml", "../Polestar_Options/Maps/Options.lua"];

const PRELUDE: &str = r#"
local M, A = Polestar.Maps, Polestar.Arcade
local m = stub.maps
Polestar.Nav.RegisterTravelData(m.travel, true)
Polestar.CharState().flags.taxi = { [1] = true, [2] = true, [3] = true }
local function present(name, entry)
	entry = entry or {}
	entry.name = name
	stub.addons[#stub.addons + 1] = entry
end
-- The standalone addon as the client has it today: its window, hidden, and its command, which toggles it;
-- withApi adds FreedoomArcadeAPI version 1. Every call is noted.
local calls = {}
local function standalone(withApi)
	present("FreedoomArcade", { loaded = true })
	local f = CreateFrame("Frame", "FreedoomArcadeFrame", UIParent)
	f:Hide()
	SlashCmdList.FREEDOOMARCADE = function(msg)
		calls[#calls + 1] = "slash:" .. msg
		if f:IsShown() then f:Hide() else f:Show() end
	end
	if withApi then
		FreedoomArcadeAPI = {
			version = 1,
			Open = function() calls[#calls + 1] = "Open"; f:Show(); return true end,
			Close = function(save) calls[#calls + 1] = "Close:" .. tostring(save); f:Hide(); return save == true end,
			IsOpen = function() return f:IsShown() end,
		}
	end
	return f
end
-- Boards a flight from West Hold to Mid Camp this character has flown in `seconds`.
local function takeoff(seconds)
	M.CharTable("flightTimes")["1>3"] = seconds
	m.openTaxi(1, { 3, 2 })
	TakeTaxiNode(2)
	m.board()
	stub.advance(1)
end
local function land()
	m.place(600, 0)
	m.land()
	stub.advance(1)
end
-- The card under the flight timer: "ask", "row" or false (not shown).
local function card()
	local c = stub.frame("PolestarArcadeOffer")
	return c ~= nil and c:IsShown() and c.mode or false
end
local notices = {}
local show = Polestar.Nav.alerts.ShowNotice
Polestar.Nav.alerts.ShowNotice = function(title, line, seconds)
	notices[#notices + 1] = { title, line, seconds }
	return show(title, line, seconds)
end
local function chat()
	local out = {}
	for _, s in ipairs(stub.messages) do
		if s:find("Freedoom Arcade") then out[#out + 1] = (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
	end
	return out
end
"#;

fn run_with(script: &str, saved: Option<&str>) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_maps.lua"],
		before: "stub.maps.useWorld(); stub.maps.place(0, 800); stub.world.faction = \"Alliance\"".into(),
		addons: vec![Addon::files("Polestar", &FILES)],
		saved: saved.map(|s| vec![("Polestar".into(), s.into())]).unwrap_or_default(),
		login: true,
		script: format!("{PRELUDE}{script}"),
	})
	.remove(0)
}

fn run(script: &str) -> Value {
	run_with(script, None)
}

// The standalone addon without the API: Play runs its command once (it toggles), a second Play leaves the
// open window alone, and 10 seconds before landing the banner only warns: nothing presses its keys or reaches
// into it, so it stays open and no "continue" line follows.
#[test]
fn without_the_api_play_opens_by_the_command_once_and_landing_only_warns() {
	let out = run(r#"
		local f = standalone(false)
		takeoff(300)
		local asked = card()
		stub.frame("PolestarArcadeOffer").Ask.Play:Click()
		local afterPlay = { card = card(), open = f:IsShown() }
		A.Open()
		local again = f:IsShown()
		stub.advance(300 - 1 - 9)
		local landing = { open = f:IsShown(), card = card() }
		land()
		emit({ asked = asked, afterPlay = afterPlay, again = again, calls = calls, landing = landing, notices = notices, chat = chat() })"#);
	assert_eq!(out["asked"], "ask");
	assert_eq!(out["afterPlay"], json!({ "card": false, "open": true }));
	assert_eq!(out["again"], true, "a second Play never toggles the window closed");
	assert_eq!(out["calls"], json!(["slash:"]));
	assert_eq!(out["landing"], json!({ "open": true, "card": false }));
	assert_eq!(out["notices"], json!([["Landing in 10 seconds", "Close Freedoom Arcade to get your keys back.", 10]]));
	assert_eq!(out["chat"], json!({}), "nothing said after the landing");
}

// With FreedoomArcadeAPI: Play calls Open(); 10 seconds before arrival the banner warns and Close(true) saves,
// pauses and closes it; on landing one chat line says how to go on.
#[test]
fn with_the_api_landing_saves_pauses_and_closes_and_the_landing_says_how_to_continue() {
	let out = run(r#"
		local f = standalone(true)
		takeoff(300)
		A.Play()
		local open = f:IsShown()
		stub.advance(300 - 1 - 12)
		local before = { open = f:IsShown(), calls = #calls }
		stub.advance(3)
		local after = f:IsShown()
		land()
		emit({ open = open, before = before, after = after, calls = calls, notices = notices, chat = chat() })"#);
	assert_eq!(out["open"], true);
	assert_eq!(out["before"], json!({ "open": true, "calls": 1 }));
	assert_eq!(out["after"], false);
	assert_eq!(out["calls"], json!(["Open", "Close:true"]));
	assert_eq!(out["notices"], json!([["Landing in 10 seconds", "Freedoom Arcade is saved and paused.", 10]]));
	assert_eq!(out["chat"], json!(["Polestar: Landed. Freedoom Arcade is saved and paused: type /doom to continue."]));
}

// Under a minute to go: no card and no row, the whole flight.
#[test]
fn a_flight_under_a_minute_offers_nothing() {
	let out = run(r#"
		standalone(true)
		takeoff(50)
		local seen = card()
		stub.advance(20)
		emit({ seen = seen, later = card(), asked = A.Trip().asked, calls = calls })"#);
	assert_eq!(out, json!({ "seen": false, "later": false, "asked": false, "calls": {} }));
}

// After "Not now" the row stays under the timer until a minute is left; then nothing.
#[test]
fn not_now_leaves_the_row_until_a_minute_is_left() {
	let out = run(r#"
		standalone(true)
		takeoff(120)
		local first = card()
		stub.frame("PolestarArcadeOffer").Ask.Later:Click()
		local row = card()
		stub.advance(62)
		emit({ first = first, row = row, late = card(), setting = Polestar.Get("maps.flightArcade") })"#);
	assert_eq!(out, json!({ "first": "ask", "row": "row", "late": false, "setting": true }));
}

// The setting off: nothing on a flight. "Don't ask again" turns it off from the card.
#[test]
fn the_setting_off_offers_nothing_and_dont_ask_again_turns_it_off() {
	let off = run_with(
		r#"
		standalone(true)
		takeoff(300)
		emit({ card = card(), calls = calls })"#,
		Some("PolestarDB = { schema = 1, settings = { maps = { flightArcade = false } } }"),
	);
	assert_eq!(off, json!({ "card": false, "calls": {} }));
	let never = run(r#"
		standalone(true)
		takeoff(300)
		local c = stub.frame("PolestarArcadeOffer")
		c.Ask.Never:SetChecked(true)
		c.Ask.Later:Click()
		local now = card()
		stub.advance(5)
		emit({ now = now, later = card(), setting = Polestar.Get("maps.flightArcade"), calls = calls })"#);
	assert_eq!(never, json!({ "now": false, "later": false, "setting": false, "calls": {} }));
}

// Neither copy there: no card, and /polestar arcade says why.
#[test]
fn with_no_copy_of_the_game_nothing_is_offered() {
	let out = run(r#"
		takeoff(300)
		local seen = card()
		Polestar.RunCommand("arcade")
		emit({ available = A.Available(), seen = seen, chat = chat() })"#);
	assert_eq!(out, json!({ "available": false, "seen": false, "chat": ["Polestar: Freedoom Arcade can't open: its folder Polestar_Arcade is missing or turned off."] }));
}

// In a fight or an instance the card waits.
#[test]
fn no_card_in_a_fight() {
	let out = run(r#"
		standalone(true)
		stub.inCombat = true
		takeoff(300)
		emit({ card = card() })"#);
	assert_eq!(out, json!({ "card": false }));
}

// Polestar_Arcade, the copy in the download: not loaded at login (nothing of it in memory); the first Play loads
// it, its own saved variables and window name, minimap button hidden, the commands its own while nobody has
// them, the window in Polestar's look; on landing it is saved, paused and closed through its API.
#[test]
fn polestar_arcade_loads_on_the_first_play_only_and_is_put_away_before_landing() {
	let out = run(r#"
		present("Polestar_Arcade", { reason = "DEMAND_LOADED" })
		local atLogin = { loaded = C_AddOns.IsAddOnLoaded("Polestar_Arcade"), engine = FreedoomArcade ~= nil, api = FreedoomArcadeAPI ~= nil, which = A.Which() }
		takeoff(300)
		local asked = card()
		A.Play()
		local win = _G.Polestar_ArcadeFrame
		local played = {
			loaded = C_AddOns.IsAddOnLoaded("Polestar_Arcade"), version = FreedoomArcadeAPI and FreedoomArcadeAPI.version,
			open = win ~= nil and win:IsShown(), standaloneWindow = _G.FreedoomArcadeFrame ~= nil,
			saved = type(Polestar_ArcadeDB) == "table", standaloneSaved = FreedoomArcadeDB ~= nil,
			minimapHidden = Polestar_ArcadeDB and Polestar_ArcadeDB.minimapHidden,
			commands = { SLASH_FREEDOOMARCADE1, SLASH_FREEDOOMARCADE2, SLASH_FREEDOOMARCADE3 },
			dressed = _G.PolestarArcadeFrame ~= nil and _G.PolestarArcadeFrame.Title:GetText(),
		}
		stub.advance(300 - 1 - 9)
		local landing = { open = win:IsShown(), paused = FreedoomArcade.G.state ~= "level" or FreedoomArcade.G.paused }
		land()
		emit({ atLogin = atLogin, asked = asked, played = played, landing = landing, notices = notices, chat = chat() })"#);
	assert_eq!(out["atLogin"], json!({ "loaded": false, "engine": false, "api": false, "which": "Polestar_Arcade" }));
	assert_eq!(out["asked"], "ask");
	assert_eq!(
		out["played"],
		json!({
			"loaded": true, "version": 1, "open": true, "standaloneWindow": false, "saved": true, "standaloneSaved": false,
			"minimapHidden": true, "commands": ["/arcade", "/freedoom", "/doom"], "dressed": "Freedoom Arcade by petllama"
		})
	);
	assert_eq!(out["landing"], json!({ "open": false, "paused": true }));
	assert_eq!(out["notices"], json!([["Landing in 10 seconds", "Freedoom Arcade is saved and paused.", 10]]));
	assert_eq!(out["chat"], json!(["Polestar: Landed. Freedoom Arcade is saved and paused: type /doom to continue."]));
}

// The standalone addon installed and enabled: Polestar opens that one and never loads its own copy.
#[test]
fn with_the_standalone_addon_installed_polestar_arcade_is_never_loaded() {
	let out = run(r#"
		present("Polestar_Arcade", { reason = "DEMAND_LOADED" })
		local f = standalone(true)
		A.Open()
		emit({ which = A.Which(), open = f:IsShown(), ours = C_AddOns.IsAddOnLoaded("Polestar_Arcade"), engine = FreedoomArcade ~= nil, calls = calls })"#);
	assert_eq!(out, json!({ "which": "FreedoomArcade", "open": true, "ours": false, "engine": false, "calls": ["Open"] }));
}

// Someone else holds the commands (the standalone addon turned off but its command kept by another addon):
// our copy loads and leaves them as they are.
#[test]
fn polestar_arcade_never_takes_commands_another_addon_registered() {
	let out = run(r#"
		present("Polestar_Arcade", { reason = "DEMAND_LOADED" })
		local theirs = function() end
		SlashCmdList.FREEDOOMARCADE = theirs
		A.Open()
		emit({ loaded = C_AddOns.IsAddOnLoaded("Polestar_Arcade"), kept = SlashCmdList.FREEDOOMARCADE == theirs, ours = SLASH_FREEDOOMARCADE1 or false })"#);
	assert_eq!(out, json!({ "loaded": true, "kept": true, "ours": false }));
}
