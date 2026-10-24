//! Maps module (addon/Polestar/Maps): travel pin layers built from the travel data, the flight timer (learning
//! real durations, falling back to estimates), the instance tracker (hourly window, runs, lockouts) and its
//! options. Runs Core, Theme, Nav and Maps against stub_world.lua + stub_maps.lua with the small travel world in
//! stub.maps.travel.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 4] = ["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Maps/Maps.xml"];

const PRELUDE: &str = r#"
local M = Polestar.Maps
local m = stub.maps
local w = stub.world
Polestar.Nav.RegisterTravelData(m.travel, true)
local function known(...)
	local flags = Polestar.CharState().flags
	flags.taxi = {}
	for _, id in ipairs({ ... }) do flags.taxi[id] = true end
end
-- A tooltip that records what a pin's tooltip function wrote.
local function tip(fn)
	local lines = {}
	local t = {}
	function t:SetText(s) lines[#lines + 1] = s end
	function t:AddLine(s) lines[#lines + 1] = s end
	function t:AddDoubleLine(l, r) lines[#lines + 1] = l .. " | " .. r end
	fn(t)
	return lines
end
"#;

// travelPins: turn the travel icon layers on (they are off by default).
const TRAVEL_PINS: &str = "PolestarDB = { schema = 1, settings = { maps = { taxiPins = true, dockPins = true, innPins = true } } }";

fn run_with(script: &str, faction: &str, travel_pins: bool) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_maps.lua"],
		before: format!("stub.maps.useWorld(); stub.maps.place(0, 800); stub.world.faction = \"{faction}\""),
		addons: vec![Addon::files("Polestar", &FILES)],
		saved: if travel_pins { vec![("Polestar".into(), TRAVEL_PINS.into())] } else { vec![] },
		login: true,
		script: format!("{PRELUDE}{script}"),
	})
	.remove(0)
}

fn run(script: &str) -> Value {
	run_with(script, "Alliance", false)
}

// ---------------------------------------------------------------------------
// Travel pins
// ---------------------------------------------------------------------------

#[test]
fn pin_layers_come_from_the_travel_data_own_faction_and_neutral_flight_masters_known_vs_undiscovered() {
	let out = run_with(
		r#"
		known(1)
		w.bind("West Hold")
		M.RefreshTravelPins()
		local P = Polestar.Pins
		local taxi = {}
		for _, p in ipairs(P.GetLayer("maps.taxi")) do
			taxi[#taxi + 1] = { id = p.nodeID, known = p.known, icon = p.icon, c = p.c, wx = p.wx, wy = p.wy }
		end
		local docks = {}
		for _, p in ipairs(P.GetLayer("maps.docks")) do docks[#docks + 1] = p.transport .. ">" .. p.dest end
		local inns = {}
		for _, p in ipairs(P.GetLayer("maps.inns")) do inns[#inns + 1] = { bound = p.bound, glow = p.glow or false, icon = p.icon } end
		local g = { Polestar.Theme.Color("success") }
		local a = { Polestar.Theme.Color("warning") }
		local layer = P.GetLayer("maps.taxi")
		emit({ taxi = taxi, docks = docks, inns = inns,
			knownColor = layer[1].color[1] == g[1] and layer[1].color[2] == g[2],
			unknownColor = layer[2].color[1] == a[1] and layer[2].color[2] == a[2],
			minimap = #P.GetMinimapFrames("maps.taxi") })"#,
		"Alliance",
		true,
	);
	assert_eq!(
		out["taxi"],
		json!([
			{ "id": 1, "known": true, "icon": "icon-fly", "c": 0, "wx": 0, "wy": 800 },
			{ "id": 2, "known": false, "icon": "icon-fly", "c": 0, "wx": 0, "wy": -800 },
			{ "id": 3, "known": false, "icon": "icon-fly", "c": 0, "wx": 600, "wy": 0 },
		]),
		"the Horde-only Red Fort is left out"
	);
	assert_eq!(out["docks"], json!(["boat-west>Far Isle", "boat-west>West Dock"]), "the Horde zeppelin is left out");
	assert_eq!(out["inns"], json!([{ "bound": true, "glow": true, "icon": "icon-hearth" }, { "bound": false, "glow": false, "icon": "icon-hearth" }]));
	assert_eq!(out["knownColor"], true);
	assert_eq!(out["unknownColor"], true);
	assert_eq!(out["minimap"], 0, "minimap travel icons are off by default");
}

#[test]
fn tooltips_name_destinations_with_learned_or_estimated_flight_times_and_where_boats_go() {
	let out = run_with(
		r#"
		known(1, 3)
		M.LearnFlight(1, 3, nil, nil, 41.4)
		M.RefreshTravelPins()
		local P = Polestar.Pins
		local west = P.GetLayer("maps.taxi")[1]
		local dock = P.GetLayer("maps.docks")[1]
		local inn = P.GetLayer("maps.inns")[2]
		emit({ west = tip(west.tooltip), dock = tip(dock.tooltip), inn = tip(inn.tooltip) })"#,
		"Alliance",
		true,
	);
	assert_eq!(
		out["west"],
		json!([
			"West Hold, Testshire",
			"Flight master, known",
			" ",
			"Flights from here",
			"East Hold (not discovered) | ~1:42", // 3000 yd at 30 yd/s + 2 s
			"Mid Camp | 0:41",                    // learned
		])
	);
	assert_eq!(out["dock"], json!(["Boat to Far Isle", "From West Dock", "Ride | 1:40", "Departs about every | 5:20"]));
	assert_eq!(out["inn"], json!(["Mid Camp", "Inn"]));
}

#[test]
fn the_horde_sees_its_own_and_neutral_nodes_settings_drop_and_restore_layers() {
	let out = run_with(
		r#"
		known()
		M.RefreshTravelPins()
		local P = Polestar.Pins
		local ids = {}
		for _, p in ipairs(P.GetLayer("maps.taxi")) do ids[#ids + 1] = p.nodeID end
		local docks = {}
		for _, p in ipairs(P.GetLayer("maps.docks")) do docks[#docks + 1] = p.transport end
		Polestar.Set("maps.taxiPins", false)
		stub.runTimers()
		local off = P.GetLayer("maps.taxi") == nil
		Polestar.Set("maps.taxiPins", true)
		Polestar.Set("maps.travelMinimap", true)
		stub.runTimers()
		emit({ ids = ids, docks = docks, off = off, back = #P.GetLayer("maps.taxi") })"#,
		"Horde",
		true,
	);
	assert_eq!(out["ids"], json!([3, 4]));
	assert_eq!(out["docks"], json!(["zeppelin-red", "zeppelin-red"]));
	assert_eq!(out["off"], true);
	assert_eq!(out["back"], 2);
}

#[test]
fn discovering_a_flight_master_on_the_taxi_map_recolours_its_pin() {
	let out = run_with(
		r#"
		known(1)
		M.RefreshTravelPins()
		local before = Polestar.Pins.GetLayer("maps.taxi")[3].known
		m.openTaxi(3, { 1 })
		stub.runTimers()
		emit({ before = before, after = Polestar.Pins.GetLayer("maps.taxi")[3].known })"#,
		"Alliance",
		true,
	);
	assert_eq!(out, json!({ "before": false, "after": true }));
}

// ---------------------------------------------------------------------------
// Flight timer
// ---------------------------------------------------------------------------

const FLY: &str = r#"
local function fly(from, slotTo, reach, wx, wy, seconds)
	m.openTaxi(from, reach)
	TakeTaxiNode(slotTo)
	m.board()
	stub.advance(0.5)
	local dest, left, source = M.GetFlight()
	local f = stub.frame("PolestarFlightTimer")
	local shown = { dest = dest, left = left and math.floor(left + 0.5), source = source,
		text = f and f.Time:GetText(), title = f and f.Dest:GetText(), visible = f and f:IsShown() }
	stub.advance(seconds - 0.5)
	m.place(wx, wy)
	m.land()
	stub.advance(0.5)
	shown.after = M.GetFlight() or false
	shown.frameAfter = f and f:IsShown()
	return shown
end
"#;

#[test]
fn the_flight_timer_estimates_an_unflown_route_then_learns_and_prefers_the_real_duration() {
	let out = run(&[
		FLY,
		r#"
		known(1, 2, 3)
		local first = fly(1, 2, { 3, 2 }, 600, 0, 40)      -- West Hold -> Mid Camp, 40 s
		local learned = Polestar.CharState().flightTimes["1>3"]
		local second = fly(1, 2, { 3, 2 }, 600, 0, 40)
		emit({ first = first, learned = learned, second = second })"#,
	]
	.concat());
	// 1000 yd / 30 yd/s + 2 s = 35 s estimated.
	assert_eq!(out["first"]["dest"], "Mid Camp");
	assert_eq!(out["first"]["source"], "estimate");
	assert_eq!(out["first"]["left"], 35);
	assert_eq!(out["first"]["text"], "~0:35");
	assert_eq!(out["first"]["title"], "Mid Camp");
	assert_eq!(out["first"]["visible"], true);
	assert_eq!(out["first"]["after"], false);
	assert_eq!(out["first"]["frameAfter"], false);
	let learned = out["learned"].as_f64().unwrap();
	assert!((40.0..=41.0).contains(&learned), "learned {}", out["learned"]);
	assert_eq!(out["second"]["source"], "learned");
	assert_eq!(out["second"]["left"], out["learned"]);
	assert_eq!(out["second"]["text"], format!("0:{}", out["learned"]).as_str());
}

#[test]
fn estimates_route_only_over_known_flight_masters() {
	let out = run(r#"
		local all = M.EstimateFlight(1, 2, 1, { [1] = true, [2] = true, [3] = true })
		local direct = M.EstimateFlight(1, 2, 1, { [1] = true, [2] = true })
		local horde = M.EstimateFlight(1, 4, 1, { [1] = true, [3] = true, [4] = true })
		emit({ all = all, direct = direct, horde = horde or false })"#);
	assert_eq!(out["all"], 71, "via Mid Camp: 2 x (1000/30 + 2)");
	assert_eq!(out["direct"], 102, "Mid Camp unknown: the long direct leg");
	assert_eq!(out["horde"], false, "an Alliance character cannot fly to a Horde node");
}

#[test]
fn a_flight_that_does_not_end_at_its_destination_is_not_learned_the_timer_counts_past_zero_as_landing() {
	let out = run(&[
		FLY,
		r#"
		known(1, 2, 3)
		local f = fly(1, 2, { 3, 2 }, 0, -800, 50)        -- landed at East Hold instead
		local times = Polestar.CharState().flightTimes or {}
		m.openTaxi(1, { 3 })
		TakeTaxiNode(2)
		m.board()
		stub.advance(36)
		local late = stub.frame("PolestarFlightTimer").Time:GetText()
		local during = Polestar.CharState().flightNow
		emit({ learned = times["1>3"] or false, late = late, during = during and during.to or false })"#,
	]
	.concat());
	assert_eq!(out["learned"], false);
	assert_eq!(out["late"], "landing");
	assert_eq!(out["during"], 3, "the flight in progress is saved for a reload");
}

#[test]
fn the_flight_timer_stays_out_of_the_way_when_disabled() {
	let out = run(&[
		FLY,
		r#"
		Polestar.Set("maps.flightTimer", false)
		known(1, 3)
		local f = fly(1, 1, { 3 }, 600, 0, 40)
		emit({ visible = f.visible or false, learned = (Polestar.CharState().flightTimes or {})["1>3"] or false })"#,
	]
	.concat());
	assert_eq!(out, json!({ "visible": false, "learned": false }));
}

// ---------------------------------------------------------------------------
// Instance tracker
// ---------------------------------------------------------------------------

#[test]
fn the_hourly_window_counts_entries_in_the_last_hour_and_says_when_a_slot_frees() {
	let out = run(r#"
		local now = 100000
		local e = {}
		for _, ago in ipairs({ 3500, 3000, 1800, 600, 60 }) do e[#e + 1] = { t = now - ago } end
		local a = { M.InstanceWindow(e, now, 5, 30) }
		local b = { M.InstanceWindow(e, now + 100, 5, 30) }      -- the oldest has dropped out
		local c = { M.InstanceWindow(e, now, 3, 0) }             -- a lower cap: two must drop first
		local d = { M.InstanceWindow({}, now, 5, 30) }
		-- the daily cap: 4 entries over the last day, cap 4
		local day = { { t = now - 80000 }, { t = now - 50000 }, { t = now - 7200 }, { t = now - 100 } }
		local f = { M.InstanceWindow(day, now, 5, 4) }
		emit({ a = a, b = b, c = c, d = d, f = f })"#);
	assert_eq!(out["a"], json!([5, 5, 100, 100]));
	assert_eq!(out["b"], json!([4, 5, 0, 500]));
	assert_eq!(out["c"], json!([5, 5, 1800, 100]));
	assert_eq!(out["d"], json!([0, 0, 0]));
	assert_eq!(out["f"], json!([1, 4, 6400, 3500]));
}

#[test]
fn entering_counts_once_per_instance_re_entering_continues_the_run_a_reset_starts_a_new_one() {
	let out = run(r#"
		local function st() local s = M.GetInstanceStatus(); return { s.inHour, s.wait } end
		local steps = {}
		m.enter("The Deadmines", 36)
		steps[#steps + 1] = st()
		m.jump(300)
		m.leave()                                  -- corpse run
		m.jump(120)
		m.enter("The Deadmines", 36)
		steps[#steps + 1] = st()
		m.leave()
		stub.fire("CHAT_MSG_SYSTEM", "The Deadmines has been reset.")
		m.enter("The Deadmines", 36)
		steps[#steps + 1] = st()
		m.leave()
		m.enter("Wailing Caverns", 43)
		m.leave()
		m.enter("Shadowfang Keep", 33)
		m.leave()
		m.enter("Blackfathom Deeps", 48)
		m.leave()
		steps[#steps + 1] = st()
		m.jump(3600)
		steps[#steps + 1] = st()
		local runs = Polestar.CharState().instanceRuns
		emit({ steps = steps, runs = #runs, firstTime = runs[1].time, firstReset = runs[1].reset or false,
			entries = #PolestarDB.instances.entries, char = PolestarDB.instances.entries[1].char })"#);
	assert_eq!(out["steps"][0], json!([1, 0]));
	assert_eq!(out["steps"][1], json!([1, 0]), "going back into the same instance does not count");
	assert_eq!(out["steps"][2], json!([2, 0]), "after a reset it is a new instance");
	assert_eq!(out["steps"][3], json!([5, 3600 - 420]), "capped: the first entry frees a slot 420 s later");
	assert_eq!(out["steps"][4], json!([0, 0]));
	assert_eq!(out["runs"], 5);
	assert_eq!(out["firstTime"], 300, "time inside, not the corpse run");
	assert_eq!(out["firstReset"], true);
	assert_eq!(out["entries"], 5);
	assert_eq!(out["char"], "Testchar-Test Realm");
}

#[test]
fn a_run_records_its_time_and_experience_across_a_level_up() {
	let out = run(r#"
		w.level, w.xp, w.xpMax = 20, 300, 400
		stub.fire("PLAYER_XP_UPDATE", "player")
		m.enter("Razorfen Kraul", 47)
		m.addXP(50)
		m.addXP(120)                -- 370 + 120: levels to 21 with 90 into the next
		m.jump(900)
		local live = M.RunSeconds(M.GetInstanceStatus().run)
		m.leave()
		m.addXP(40)                 -- outside: not part of the run
		local run = Polestar.CharState().instanceRuns[1]
		emit({ xp = run.xp, time = run.time, live = live, level = run.level })"#);
	assert_eq!(out, json!({ "xp": 170, "time": 900, "live": 900, "level": 20 }));
}

#[test]
fn a_different_instance_copy_seen_in_a_creature_guid_splits_a_resumed_run_and_counts_it() {
	let out = run(r#"
		m.enter("The Stockade", 34)
		w.units.target = "Creature-0-4372-34-100-1706-0000AAAA"
		stub.fire("PLAYER_TARGET_CHANGED")
		m.jump(600)
		m.leave()
		m.jump(60)
		m.enter("The Stockade", 34)              -- looks like the same run...
		w.units.target = "Creature-0-4372-34-200-1706-0000BBBB"
		stub.fire("PLAYER_TARGET_CHANGED")      -- ...but it is another copy
		local s = M.GetInstanceStatus()
		local runs = Polestar.CharState().instanceRuns
		emit({ inHour = s.inHour, runs = #runs, firstTime = runs[1].time, zones = { runs[1].zone, runs[2].zone } })"#);
	assert_eq!(out, json!({ "inHour": 2, "runs": 2, "firstTime": 600, "zones": ["100", "200"] }));
}

#[test]
fn saved_raid_lockouts_count_down_and_the_slash_command_reports_everything() {
	let out = run(r#"
		m.saved = { { name = "Molten Core", id = 1, reset = 200000, total = 10, done = 4, difficultyName = "40 Player" },
			{ name = "Onyxia's Lair", id = 2, reset = 5000, locked = false } }
		RequestRaidInfo()
		stub.runTimers()
		m.jump(1000)
		local locks = M.GetSavedLockouts()
		m.enter("Ragefire Chasm", 389)
		stub.messages = {}
		SlashCmdList.POLESTAR("instances")
		stub.runTimers()
		emit({ locks = locks, messages = stub.messages })"#);
	assert_eq!(out["locks"].as_array().unwrap().len(), 1, "only locked instances");
	assert_eq!(out["locks"][0]["name"], "Molten Core");
	assert_eq!(out["locks"][0]["resetIn"], 199000);
	let all = out["messages"].as_array().unwrap().iter().map(text).collect::<Vec<_>>().join("\n");
	assert!(is_match(&all, r"Instances this hour: 1/5"));
	assert!(is_match(&all, r"Last 24 hours: 1/30"));
	assert!(is_match(&all, r"Ragefire Chasm \(Testchar-Test Realm\)"));
	assert!(is_match(&all, r"Molten Core \(40 Player\): resets in 2d 7h, 4/10"));
	assert!(is_match(&all, r"Forever may differ"));
}

#[test]
fn the_compact_tracker_is_off_until_a_player_turns_it_on_then_shows_while_it_matters_and_follows_its_settings() {
	let out = run(r#"
		local f = stub.frame("PolestarInstanceTracker")
		m.enter("Ragefire Chasm", 389)
		local default = f:IsShown()
		Polestar.Set("maps.instanceDisplay", true)
		local inside = { shown = f:IsShown(), count = f.Count:GetText(), run = f.Run:GetText() }
		m.leave()
		local after = f:IsShown()
		Polestar.Set("maps.instanceDisplay", false)
		local off = f:IsShown()
		Polestar.Set("maps.instanceDisplay", true)
		Polestar.Set("maps.perHour", 1)
		local capped = f.Wait:GetText()
		m.jump(3601)
		stub.advance(1.1)
		emit({ default = default, inside = inside, after = after, off = off, capped = capped, expired = f:IsShown() })"#);
	assert_eq!(out["default"], false, "off by default, even inside a new instance");
	assert_eq!(out["inside"], json!({ "shown": true, "count": "1/5 this hour", "run": "Ragefire Chasm" }));
	assert_eq!(out["after"], true, "still shown while an entry is inside the hour");
	assert_eq!(out["off"], false);
	assert_eq!(out["capped"], "next in 1:00:00", "the only entry is a second old");
	assert_eq!(out["expired"], false, "hidden once the hour has passed");
}

#[test]
fn with_the_lock_on_only_a_shift_drag_moves_the_flight_timer_and_the_instance_tracker() {
	let out = run(&[
		FLY,
		r#"
		known(1, 3)
		fly(1, 1, { 3 }, 600, 0, 40)
		local function drag(f)
			stub.RunScript(f, "OnDragStart")
			local started = f.moving == true
			f:StopMovingOrSizing()
			return started
		end
		local r = {}
		for _, name in ipairs({ "PolestarFlightTimer", "PolestarInstanceTracker" }) do
			local f = stub.frame(name)
			Polestar.Set("ui.lockHud", false)
			stub.keys.shift = false
			local unlocked = drag(f)
			Polestar.Set("ui.lockHud", true)
			local locked = drag(f)
			stub.keys.shift = true
			r[name] = { unlocked, locked, drag(f), f:IsMouseEnabled() }
		end
		emit(r)"#,
	]
	.concat());
	assert_eq!(
		out,
		json!({
			"PolestarFlightTimer": [true, false, true, true],
			"PolestarInstanceTracker": [true, false, true, true],
		}),
		"unlocked: a plain drag; locked: only with Shift held"
	);
}

#[test]
fn with_the_lock_on_a_drag_that_does_not_move_the_flight_timer_or_the_instance_tracker_does_not_save_its_spot() {
	let out = run(&[
		FLY,
		r#"
		known(1, 3)
		fly(1, 1, { 3 }, 600, 0, 40)
		Polestar.Set("ui.lockHud", true)
		local r = {}
		for name, key in pairs({ PolestarFlightTimer = "maps.timerPos", PolestarInstanceTracker = "maps.trackerPos" }) do
			local f = stub.frame(name)
			stub.keys.shift = false
			stub.RunScript(f, "OnDragStart")
			stub.RunScript(f, "OnDragStop")
			local refused = Polestar.Get(key)
			stub.keys.shift = true
			stub.RunScript(f, "OnDragStart")
			stub.RunScript(f, "OnDragStop")
			r[name] = { refused, type(Polestar.Get(key)) }
		end
		emit(r)"#,
	]
	.concat());
	assert_eq!(
		out,
		json!({
			"PolestarFlightTimer": [false, "table"],
			"PolestarInstanceTracker": [false, "table"],
		}),
		"a plain drag leaves the saved spot alone; a Shift-drag still saves it"
	);
}

// ---------------------------------------------------------------------------
// World map zone info
// ---------------------------------------------------------------------------

#[test]
fn the_world_map_shows_zone_ranges_on_the_continent_the_hovered_zone_and_player_cursor_coordinates() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_maps.lua"],
		before: "stub.maps.useWorld(); stub.maps.withMapCanvas(); stub.maps.place(0, 800); stub.world.level = 8".into(),
		addons: vec![Addon::files("Polestar", &FILES)],
		login: true,
		script: r#"
			local M, m = Polestar.Maps, stub.maps
			M.RegisterZoneLevels({ [9000] = { 10, 20, 50, 50 } })
			local function labels()
				local out = {}
				for _, f in ipairs(stub.frames) do
					if f.parent == stub.maps.canvas and rawget(f, "Range") and f:IsShown() then
						local p = f.points[1]
						out[#out + 1] = { name = f.Name:GetText(), range = f.Range:GetText(), x = p.x, y = p.y, scale = f:GetScale() }
					end
				end
				return out
			end
			local bar = stub.frame("PolestarMapInfo")
			m.showMap(9100)
			m.cursor = { 0.4, 0.3 }
			stub.advance(0.2)
			local continent = { labels = labels(), zone = bar.Zone:GetText(), coords = bar.Coords:GetText() }
			m.canvasScale = 2
			stub.runMapFrame(WorldMapFrame, 0)
			local zoomed = labels()
			m.cursor = nil
			m.showMap(9000)
			stub.advance(0.2)
			local zone = { labels = #labels(), zone = bar.Zone:GetText(), coords = bar.Coords:GetText() }
			Polestar.Set("maps.coords", false)
			Polestar.Set("maps.zoneLevels", false)
			emit({ continent = continent, zoomed = zoomed, zone = zone, hidden = not bar:IsShown() })"#
			.into(),
		..Default::default()
	});
	let out = &out[0];
	assert_eq!(out["continent"]["labels"], json!([{ "name": "Testshire", "range": "10–20", "x": 400, "y": -300, "scale": 1 }]));
	assert_eq!(out["continent"]["zone"], "Testshire  10–20");
	assert_eq!(out["continent"]["coords"], "Player 42.0, 30.0     Cursor 40.0, 30.0");
	assert_eq!(out["zoomed"], json!([{ "name": "Testshire", "range": "10–20", "x": 800, "y": -600, "scale": 0.5 }]), "labels keep their size when zooming");
	assert_eq!(out["zone"]["labels"], 0, "labels are for continent maps");
	assert_eq!(out["zone"]["zone"], "Testshire  10–20");
	assert_eq!(out["zone"]["coords"], "Player 10.0, 50.0");
	assert_eq!(out["hidden"], true);
}

// ---------------------------------------------------------------------------
// Options
// ---------------------------------------------------------------------------

fn sorted_strings(v: &Value) -> Vec<String> {
	let mut keys: Vec<String> = v.as_array().unwrap().iter().map(|s| text(s).to_string()).collect();
	keys.sort();
	keys
}

#[test]
fn every_maps_setting_is_registered_with_a_label_and_help_map_features_on_the_map_page_flights_and_instances_under_quality_of_life() {
	let out = run(r#"
		local pages, missing = {}, {}
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			for _, c in ipairs(spec.controls) do
				if c.key and c.key:find("^maps%.") then
					if not (c.label and c.help) then missing[#missing + 1] = c.key end
					pages[spec.page] = pages[spec.page] or {}
					table.insert(pages[spec.page], c.key)
				end
			end
		end
		emit({ pages = pages, missing = table.concat(missing, ",") })"#);
	assert_eq!(out["missing"], "");
	let mut pages: Vec<&str> = out["pages"].as_object().unwrap().keys().map(String::as_str).collect();
	pages.sort();
	assert_eq!(pages, vec!["Map", "Quality of Life"]);
	let mut want: Vec<String> = [
		"maps.coords",
		"maps.dockPins",
		"maps.dungeonPins",
		"maps.innPins",
		"maps.minimapButton",
		"maps.minimapCoords",
		"maps.reveal",
		"maps.taxiPins",
		"maps.travelMinimap",
		"maps.zoneLevels",
		"maps.servicePins",
		"maps.serviceMinimap",
	]
	.iter()
	.map(|s| s.to_string())
	.chain(["repair", "mailbox", "class", "weapon", "auctioneer", "banker", "battlemaster", "spirithealer", "stablemaster", "trainer", "vendor"].iter().map(|key| format!("maps.serviceFilters.{key}")))
	.collect();
	want.sort();
	assert_eq!(sorted_strings(&out["pages"]["Map"]), want);
	assert_eq!(sorted_strings(&out["pages"]["Quality of Life"]), vec!["maps.flightTimer", "maps.instanceDisplay", "maps.instances", "maps.perDay", "maps.perHour"]);
}
