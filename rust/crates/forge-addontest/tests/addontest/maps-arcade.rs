//! Freedoom Arcade on flights (addon/Polestar/Maps/Arcade.lua): the card under the flight timer, the game opened
//! through FreedoomArcadeAPI or else the standalone addon's slash command (never toggled closed), the game put
//! away 10 seconds before landing, on the landing itself and in a fight on the way, and Polestar_Arcade, the copy in
//! Polestar's download: loaded on demand, never beside the standalone addon, its commands left to whoever has them.
//! With the setting off nothing of it is made or loaded, and flights leave nothing behind. Runs Core, Theme, Nav and
//! Maps against stub_world.lua + stub_maps.lua (the small travel world: West Hold to Mid Camp, flown here in a set
//! time).

use forge_addontest::run::addons_dir;
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

// Frames made by Maps/Arcade.lua itself (a CreateFrame called from that file), counted from before the addon loads.
const COUNT_FRAMES: &str = r#"
arcadeFrames = 0
local createFrame = CreateFrame
CreateFrame = function(...)
	local info = debug.getinfo(2, "S")
	if info and info.source:find("Maps/Arcade.lua", 1, true) then arcadeFrames = arcadeFrames + 1 end
	return createFrame(...)
end
"#;

fn run_with(script: &str, saved: Option<&str>) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_maps.lua"],
		before: format!("stub.maps.useWorld(); stub.maps.place(0, 800); stub.world.faction = \"Alliance\"\n{COUNT_FRAMES}"),
		addons: vec![Addon::files("Polestar", &FILES)],
		saved: saved.map(|s| vec![("Polestar".into(), s.into())]).unwrap_or_default(),
		login: true,
		script: format!("{PRELUDE}{script}"),
	})
	.remove(0)
}

const OFF: &str = "PolestarDB = { schema = 1, settings = { maps = { flightArcade = false } } }";

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

// The setting off: nothing of the Arcade is made at login or on a flight (no driver, no card), Polestar_Arcade stays
// unloaded and nothing runs. On, nothing is made at login either: the first flight makes what it needs.
#[test]
fn with_the_setting_off_a_flight_makes_and_loads_nothing() {
	let flight = r#"
		present("Polestar_Arcade", { reason = "DEMAND_LOADED" })
		local atLogin = arcadeFrames
		takeoff(300)
		stub.advance(60)
		local inFlight = { frames = arcadeFrames, trip = A.Trip() ~= nil, card = stub.frame("PolestarArcadeOffer") ~= nil }
		land()
		emit({ atLogin = atLogin, inFlight = inFlight, after = arcadeFrames,
			loaded = C_AddOns.IsAddOnLoaded("Polestar_Arcade"), engine = FreedoomArcade ~= nil, chat = chat() })"#;
	let off = run_with(flight, Some(OFF));
	assert_eq!(off, json!({ "atLogin": 0, "inFlight": { "frames": 0, "trip": false, "card": false }, "after": 0, "loaded": false, "engine": false, "chat": {} }));
	let on = run(flight);
	assert_eq!(on["atLogin"], 0, "nothing made before the first flight");
	assert_eq!(on["inFlight"]["trip"], true);
	assert_eq!(on["inFlight"]["card"], true);
	assert_eq!(on["loaded"], false, "the card alone loads nothing of the game");
}

// The setting off, the game opened on a flight anyway (the command, or Play with "Don't ask again"): Polestar still
// puts it away before landing, since it opened it.
#[test]
fn the_game_opened_on_a_flight_with_the_setting_off_is_still_put_away() {
	let out = run_with(
		r#"
		local f = standalone(true)
		takeoff(300)
		local before = A.Trip() ~= nil
		Polestar.RunCommand("arcade")
		local open = f:IsShown()
		stub.advance(300 - 1 - 9)
		local landing = f:IsShown()
		land()
		emit({ before = before, open = open, landing = landing, trip = A.Trip() ~= nil, calls = calls, chat = chat() })"#,
		Some(OFF),
	);
	assert_eq!(
		out,
		json!({ "before": false, "open": true, "landing": false, "trip": false, "calls": ["Open", "Close:true"],
			"chat": ["Polestar: Landed. Freedoom Arcade is saved and paused: type /doom to continue."] })
	);
}

// A landing sooner than the timer said (or a game reopened in the last 10 seconds): the landing puts it away.
#[test]
fn the_landing_puts_away_a_game_still_open() {
	let out = run(r#"
		local f = standalone(true)
		takeoff(300)
		A.Play()
		stub.advance(60)
		local open = f:IsShown()
		land()
		emit({ open = open, after = f:IsShown(), card = card(), trip = A.Trip() ~= nil, calls = calls, chat = chat() })"#);
	assert_eq!(
		out,
		json!({ "open": true, "after": false, "card": false, "trip": false, "calls": ["Open", "Close:true"],
			"chat": ["Polestar: Landed. Freedoom Arcade is saved and paused: type /doom to continue."] })
	);
}

// A fight on the way: the game is saved, paused and closed at once (keys back for the fight), one line says how to go
// on; no card in the fight; the row comes back after it; the landing has nothing more to say.
#[test]
fn a_fight_on_the_way_puts_the_game_away() {
	let out = run(r#"
		local f = standalone(true)
		takeoff(300)
		A.Play()
		stub.advance(5)
		stub.inCombat = true
		stub.fire("PLAYER_REGEN_DISABLED")
		local fight = { open = f:IsShown(), card = card() }
		stub.advance(2)
		local during = card()
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.advance(1)
		local after = card()
		land()
		emit({ fight = fight, during = during, after = after, calls = calls, chat = chat() })"#);
	assert_eq!(
		out,
		json!({ "fight": { "open": false, "card": false }, "during": false, "after": "row", "calls": ["Open", "Close:true"],
			"chat": ["Polestar: Freedoom Arcade is saved and paused for the fight: type /doom to continue."] })
	);
}

// Donkeyman's report (#2899): once a fight had paused the game, every later fight ended with "combat over. Type
// /doom to get back to Doom." until the game was resumed. Only the fight that paused it says so, once; a game
// Polestar put away on landing never does.
#[test]
fn only_the_fight_that_paused_the_game_ends_with_the_reminder_2899() {
	let out = run(r#"
		present("Polestar_Arcade", { reason = "DEMAND_LOADED" })
		local function fight()
			stub.inCombat = true
			stub.fire("PLAYER_REGEN_DISABLED")
			stub.advance(1)
			stub.inCombat = false
			stub.fire("PLAYER_REGEN_ENABLED")
			stub.advance(1)
		end
		local function since(n)
			local all, out = chat(), {}
			for i = n + 1, #all do out[#out + 1] = all[i] end
			return out
		end
		takeoff(300)
		A.Play()
		FreedoomArcade.G.InitNew(2, 1, 1)
		stub.advance(300)
		land()
		local n = #chat()
		fight(); fight()
		local afterLanding = since(n)
		FreedoomArcadeAPI.Open()
		n = #chat()
		fight()
		local paused = since(n)
		n = #chat()
		fight(); fight()
		emit({ afterLanding = afterLanding, paused = paused, later = since(n), level = FreedoomArcade.G.state })"#);
	assert_eq!(out["level"], "level", "the game is in a level, so a fight saves and pauses it");
	assert_eq!(out["afterLanding"], json!({}), "fights after the landing say nothing");
	assert_eq!(
		out["paused"],
		json!(["Freedoom Arcade: you're in combat! Game saved and paused. Type /doom to come back, P to resume.", "Freedoom Arcade: combat over. Type /doom to get back to Doom."])
	);
	assert_eq!(out["later"], json!({}), "later fights with the game put away say nothing");
}

// A zone border crossed in the air leaves the game alone; a loading screen ends the flight and puts it away.
#[test]
fn a_loading_screen_ends_the_flight_and_puts_the_game_away_a_zone_border_does_not() {
	let out = run(r#"
		local f = standalone(true)
		takeoff(300)
		A.Play()
		stub.advance(5)
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.fire("ZONE_CHANGED")
		stub.advance(2)
		local border = f:IsShown()
		stub.fire("PLAYER_LEAVING_WORLD")
		stub.world.onTaxi = false
		stub.fire("PLAYER_ENTERING_WORLD", false, false)
		stub.advance(1)
		emit({ border = border, after = f:IsShown(), flight = Polestar.Maps.GetFlight() ~= nil, trip = A.Trip() ~= nil, calls = calls, chat = chat() })"#);
	assert_eq!(
		out,
		json!({ "border": true, "after": false, "flight": false, "trip": false, "calls": ["Open", "Close:true"],
			"chat": ["Polestar: Landed. Freedoom Arcade is saved and paused: type /doom to continue."] })
	);
}

// Flight after flight with the card, the game opened and put away: no frame and no memory left behind by any of them.
#[test]
fn flights_leave_nothing_behind() {
	let out = run(r#"
		local f = standalone(true)
		local function flight()
			takeoff(120)
			A.Play()
			stub.advance(120)
			land()
			for k in pairs(stub.messages) do stub.messages[k] = nil end
			for k in pairs(notices) do notices[k] = nil end
			for k in pairs(calls) do calls[k] = nil end
		end
		for _ = 1, 3 do flight() end
		collectgarbage("collect"); collectgarbage("collect")
		local frames, made, kb = #stub.frames, arcadeFrames, collectgarbage("count")
		for _ = 1, 25 do flight() end
		collectgarbage("collect"); collectgarbage("collect")
		emit({ frames = #stub.frames - frames, made = arcadeFrames - made, kb = collectgarbage("count") - kb,
			open = f:IsShown(), trip = A.Trip() ~= nil, card = card() })"#);
	assert_eq!(out["frames"], 0, "{out}");
	assert_eq!(out["made"], 0, "{out}");
	assert!(out["kb"].as_f64().unwrap() < 24.0, "memory grew over 25 flights: {out}");
	assert_eq!(out["open"], false);
	assert_eq!(out["trip"], false);
	assert_eq!(out["card"], false);
}

// No taint: neither Polestar's flight code nor the game it ships calls a protected function, a secure template or a
// binding function (the game takes the keys with its own window's keyboard, which is the player's while it shows,
// and is put away by hiding it); and Polestar_Arcade played through a flight with a fight leaves the game's frames and
// tables alone.
const PROTECTED: &[&str] = &[
	r"Cast\w*",
	r"Use(Action|Item\w*|Container\w*|InventoryItem|Toy\w*)",
	r"(Target|Assist|Focus|Interact)Unit",
	r"Target(Nearest|Last)\w*",
	r"(Clear)?Target",
	r"(Start)?Attack(Target)?",
	r"Pet\w+",
	r"SpellStopCasting",
	r"SpellTarget\w*",
	r"(JumpOrAscend|Ascend|Descend|SitStandOrDescend)St\w+",
	r"(Move(Forward|Backward)|Strafe(Left|Right)|Turn(Left|Right)|CameraOrSelectOrMove|TurnOrAction|Pitch(Up|Down))St\w+",
	r"Toggle(Run|AutoRun|PVP)",
	r"RunMacro\w*",
	r"(Pickup|Place)Action",
	r"ChangeActionBarPage",
	r"SetBinding\w*",
	r"(Set|Clear)OverrideBinding\w*",
	r"SetPropagateKeyboardInput",
	r"RegisterStateDriver",
	r"RegisterAttributeDriver",
	r"SetAttribute",
	r"Secure\w*",
	r"securecall",
	r"hooksecurefunc",
	r"(Force)?Quit",
	r"Logout",
];

#[test]
fn neither_the_flight_code_nor_the_game_calls_a_protected_function() {
	// A call or a method call (frame:SetAttribute(...)); a field of the game's own (D.Target) is its own.
	let call = regex::Regex::new(&format!(r"(^|[^\w.])({})\s*\(", PROTECTED.join("|"))).unwrap();
	let template = regex::Regex::new(r#""Secure\w*Template""#).unwrap();
	let comment = regex::Regex::new(r"--.*$").unwrap();
	let dir = addons_dir();
	let mut files = vec![dir.join("Polestar/Maps/Arcade.lua")];
	let mut src: Vec<_> = std::fs::read_dir(dir.join("Polestar_Arcade/src")).unwrap().map(|e| e.unwrap().path()).collect();
	src.sort();
	files.extend(src);
	let mut found = vec![];
	for file in &files {
		let text = std::fs::read_to_string(file).unwrap();
		for (i, line) in text.lines().enumerate() {
			let code = comment.replace(line, "");
			if call.is_match(&code) || template.is_match(&code) {
				found.push(format!("{}:{}: {}", file.strip_prefix(&dir).unwrap().display(), i + 1, line.trim()));
			}
		}
	}
	assert!(found.is_empty(), "protected calls:\n{}", found.join("\n"));
	let out = run(r#"
		present("Polestar_Arcade", { reason = "DEMAND_LOADED" })
		takeoff(300)
		A.Play()
		stub.advance(5)
		stub.inCombat = true
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.advance(1)
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		A.Play()
		stub.advance(300)
		land()
		emit({ open = _G.Polestar_ArcadeFrame:IsShown(), underGameFrames = stub.underGameFrames, mapWrites = stub.mapWrites })"#);
	assert_eq!(out, json!({ "open": false, "underGameFrames": {}, "mapWrites": {} }));
}

// Every Lua file the game loads (its TOC) opens with whose work it is and its licence, and the licence and credit
// files those notices name are in the folder: a file added from upstream or rebuilt by the asset tools without the
// notice fails here.
#[test]
fn every_file_of_the_game_names_its_authors_and_licence() {
	let dir = addons_dir().join("Polestar_Arcade");
	for f in ["LICENSE", "CREDITS.md", "FREEDOOM-COPYING.txt", "FREEDOOM-CREDITS.txt"] {
		assert!(dir.join(f).is_file(), "{f} is missing from Polestar_Arcade");
	}
	let toc = std::fs::read_to_string(dir.join("Polestar_Arcade.toc")).unwrap();
	let mut missing = vec![];
	for line in toc.lines().map(str::trim).filter(|l| !l.is_empty() && !l.starts_with('#')) {
		let path = dir.join(line.replace('\\', "/"));
		let text = std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("{line}: {e}"));
		let head: String = text.lines().take(4).collect::<Vec<_>>().join("\n");
		let whose = head.contains("petllama") || head.contains("Contributors to the Freedoom project");
		let licence = head.contains("GPL") || head.contains("BSD licence: see FREEDOOM-COPYING.txt");
		if !(head.starts_with("-- ") && whose && licence) {
			missing.push(line.to_string());
		}
	}
	assert!(missing.is_empty(), "files without the notice: {missing:?}");
}
