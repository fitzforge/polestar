//! Journeys (addon/Polestar/Nav/Journey.lua, Nearby.lua): plan to anywhere from the world map and minimap, the
//! public Nav API, the TomTom stand-in and following TomTom's arrow, /way, nearby services, and the death helper
//! handing a picked point back. Runs Core/Init.lua + Nav/Nav.xml against tests/lua/stub_nav.lua, plus a
//! continent map, a world map canvas with click handlers and mouse foci. Test names cite the rows of
//! docs/NAV_QA.md they guard.

use std::collections::HashSet;

use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

// Map 9100 "Testland" (continent type) holds 9000 "Testshire" at x, y 25..75; 9002 "The Barrens" lies west of
// it. The world map canvas records its click handlers; stub.canvasClick / stub.pinClick run them as
// Blizzard_MapCanvas does.
const WORLD: &str = r#"
local nav = stub.nav
nav.maps[9100] = { c = 0, top = 2000, bottom = -2000, left = 2000, right = -2000, name = "Testland" }
nav.maps[9002] = { c = 0, top = 1000, bottom = -1000, left = 3000, right = 1000, name = "The Barrens" }
nav.Compat.SKILL_LINES = { mining = 186, alchemy = 171, riding = 762 }
local types = { [9100] = 2, [9000] = 3, [9001] = 3, [9002] = 3 }
function C_Map.GetMapInfo(id)
	local m = nav.maps[id]
	if m then return { mapID = id, name = m.name, mapType = types[id], parentMapID = id == 9100 and 0 or 9100 } end
end
function C_Map.GetMapInfoAtPosition(map, x, y)
	if map == 9100 and x >= 0.25 and x <= 0.75 and y >= 0.25 and y <= 0.75 then
		return { mapID = 9000, mapType = 3, name = "Testshire" }
	end
end
function C_Map.GetBestMapForUnit() return 9000 end
function C_Map.GetMapChildrenInfo(root)
	if root ~= 9100 then return {} end
	return { { mapID = 9000, name = "Testshire", mapType = 3 }, { mapID = 9002, name = "The Barrens", mapType = 3 },
		{ mapID = 9003, name = "Test Ridge", mapType = 3 } }
end
stub.canvas = { handlers = {}, pinHandlers = {}, cursor = { 0.5, 0.5 }, over = true }
local map = WorldMapFrame
function map.AddCanvasClickHandler(_, fn) table.insert(stub.canvas.handlers, fn) end
function map.AddGlobalPinMouseActionHandler(_, fn) table.insert(stub.canvas.pinHandlers, fn) end
function map.GetNormalizedCursorPosition() return stub.canvas.cursor[1], stub.canvas.cursor[2] end
function map.ScrollContainer.IsMouseOver() return stub.canvas.over end
MapCanvasMixin = { MouseAction = { Click = 1 } }
stub.foci = {}
function GetMouseFoci() return stub.foci end
function stub.canvasClick(button)
	local took = false
	for _, fn in ipairs(stub.canvas.handlers) do if fn(WorldMapFrame, button or "LeftButton") then took = true end end
	return took
end
function stub.pinClick(button)
	local took = false
	for _, fn in ipairs(stub.canvas.pinHandlers) do if fn(WorldMapFrame, 1, button or "LeftButton") then took = true end end
	return took
end
stub.menus = {}
Menu = { ModifyMenu = function(tag, fn) stub.menus[tag] = fn end }
"#;

const PRELUDE: &str = r#"
local N = Polestar.Nav
local API = N.API
local J = N.journey
local nav = stub.nav
local function label() local t = N.GetTarget(); return t and t.label or false end
local function said(text)
	for _, m in ipairs(stub.messages) do if m:find(text, 1, true) then return true end end
	return false
end
local function keys(shift, alt, ctrl) stub.keys.shift, stub.keys.alt, stub.keys.ctrl = shift or false, alt or false, ctrl or false end
"#;

fn run_with(script: &str, before: &str, saved: Option<&str>, login: bool) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		before: format!("{WORLD}{before}"),
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		login,
		script: format!("{PRELUDE}{script}"),
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, "", None, true)
}

fn near(a: &Value, b: f64) -> bool {
	a.as_f64().is_some_and(|a| (a - b).abs() <= 1e-6)
}

// ---------------------------------------------------------------------------
// Plan to anywhere
// ---------------------------------------------------------------------------

#[test]
fn plan_anywhere_shift_click_on_the_world_map_points_the_arrow_there_named_after_the_zone_the_same_spot_again_lets_it_go() {
	let out = run(r#"
		nav.setWaypoint({ map = 9000, x = 50, y = 50, label = "Guide step", stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 })
		nav.showWorldMap(9000)
		keys(true)
		stub.canvas.cursor = { 0.7, 0.3 }
		local took = stub.canvasClick()
		local t = N.GetTarget()
		emit({ took = took, label = t.label, x = t.x, y = t.y, map = t.map, override = N.IsOverride() })
		stub.canvas.cursor = { 0.705, 0.3 } -- 10 yd away: the same spot
		stub.canvasClick()
		emit({ label = label(), override = N.IsOverride() })
		keys(false)
		emit({ took = stub.canvasClick(), label = label() })
	"#);
	assert_eq!(out[0], json!({ "took": true, "label": "Testshire 70, 30", "x": 70, "y": 30, "map": 9000, "override": true }));
	assert_eq!(out[1], json!({ "label": "Guide step", "override": false }));
	assert_eq!(out[2], json!({ "took": false, "label": "Guide step" }), "a plain click stays the map's own");
}

#[test]
fn plan_anywhere_a_continent_click_lands_on_the_zone_under_it_c13_open_sea_prints_a_line_and_plans_nothing() {
	let out = run(r#"
		nav.showWorldMap(9100)
		keys(true)
		stub.canvas.cursor = { 0.6, 0.4 } -- world (400, -400): Testshire (70, 30)
		stub.canvasClick()
		local t = N.GetTarget()
		emit({ map = t.map, x = t.x, y = t.y, label = t.label })
		N.ClearTarget()
		stub.messages = {}
		stub.canvas.cursor = { 0.1, 0.1 }
		emit({ took = stub.canvasClick(), target = N.GetTarget() == nil, said = said("No route can be planned to that spot.") })
	"#);
	let zone = &out[0];
	assert_eq!(zone["map"], 9000);
	assert!(near(&zone["x"], 70.0) && near(&zone["y"], 30.0), "{zone}");
	assert_eq!(zone["label"], "Testshire 70, 30");
	assert_eq!(out[1], json!({ "took": true, "target": true, "said": true }));
}

#[test]
fn plan_anywhere_shift_click_with_a_chat_edit_box_open_links_into_chat_and_plans_nothing_row_8() {
	let out = run(r#"
		ChatEdit_GetActiveWindow = function() return {} end
		nav.showWorldMap(9000)
		keys(true)
		stub.canvas.cursor = { 0.7, 0.3 }
		local canvas = stub.canvasClick()
		N.SetTarget(9000, 60, 60, "Picked")
		local pin = stub.pinClick()
		emit({ canvas = canvas, pin = pin, label = label() })
	"#);
	assert_eq!(out[0], json!({ "canvas": false, "pin": false, "label": "Picked" }));
}

#[test]
fn plan_anywhere_shift_click_on_the_planned_spot_s_own_pin_lets_it_go_pins_take_canvas_clicks() {
	let out = run(r#"
		nav.showWorldMap(9000)
		keys(true)
		stub.canvas.cursor = { 0.7, 0.3 }
		stub.canvasClick()
		local targetPin
		for _, p in ipairs(nav.pins()) do if p.data.layer.name == "nav.target" then targetPin = p end end
		nav.click(targetPin, "LeftButton")
		emit({ pin = targetPin ~= nil, target = N.GetTarget() == nil })
	"#);
	assert_eq!(out[0], json!({ "pin": true, "target": true }));
}

#[test]
fn plan_anywhere_alt_click_plans_over_map_icons_by_their_name_and_leaves_polestar_s_clickable_pins_alone_row_9() {
	let out = run(r#"
		nav.showWorldMap(9000)
		keys(false, true)
		stub.canvas.cursor = { 0.25, 0.75 }
		stub.fire("GLOBAL_MOUSE_DOWN", "LeftButton")
		local t = N.GetTarget()
		emit({ x = t.x, y = t.y, label = t.label })
		stub.foci = { { pinTemplate = "FlightPointPinTemplate", poiInfo = { name = "West Hold" },
			GetMap = function() return WorldMapFrame end, GetPosition = function() return 0.1, 0.5 end } }
		stub.fire("GLOBAL_MOUSE_DOWN", "LeftButton")
		t = N.GetTarget()
		emit({ x = t.x, y = t.y, label = t.label })
		Polestar.Pins.SetLayer("test.click", { { map = 9000, x = 90, y = 90, onClick = function() end } })
		for _, p in ipairs(nav.pins()) do if p.data.layer.name == "test.click" then stub.foci = { p } end end
		stub.canvas.cursor = { 0.9, 0.9 }
		stub.fire("GLOBAL_MOUSE_DOWN", "LeftButton")
		emit(label())
		stub.foci = {}
		keys(true, true) -- Shift with Alt is neither
		stub.fire("GLOBAL_MOUSE_DOWN", "LeftButton")
		emit(label())
	"#);
	assert_eq!(out[0], json!({ "x": 25, "y": 75, "label": "Testshire 25, 75" }));
	assert_eq!(out[1], json!({ "x": 10, "y": 50, "label": "West Hold" }));
	assert_eq!(out[2], "West Hold");
	assert_eq!(out[3], "West Hold");
}

#[test]
fn plan_anywhere_shift_click_on_the_minimap_goes_to_the_spot_under_the_cursor_off_its_face_prints_a_line_c13() {
	let out = run(r#"
		nav.viewRadius = 200
		keys(true)
		stub.cursor = { 70 + 35, 70 } -- half the radius east of the centre: 100 yd east
		stub.RunScript(Minimap, "OnMouseUp", "LeftButton")
		local t = N.GetTarget()
		emit({ x = t.x, y = t.y, label = t.label })
		stub.cursor = { 70 + 36, 70 } -- 3 yd away: the same spot
		stub.RunScript(Minimap, "OnMouseUp", "LeftButton")
		emit(N.GetTarget() == nil)
		stub.messages = {}
		stub.cursor = { 70 + 65, 70 + 65 } -- the corner of a round minimap
		stub.RunScript(Minimap, "OnMouseUp", "LeftButton")
		emit({ target = N.GetTarget() == nil, said = said("No route can be planned to that spot.") })
	"#);
	let spot = &out[0];
	assert!(near(&spot["x"], 55.0) && near(&spot["y"], 50.0), "{spot}");
	assert_eq!(spot["label"], "Testshire 55, 50");
	assert_eq!(out[1], true);
	assert_eq!(out[2], json!({ "target": true, "said": true }));
}

#[test]
fn plan_anywhere_off_in_settings_map_clicks_are_the_map_s_own() {
	let out = run(r#"
		Polestar.Set("nav.mapPlan", false)
		nav.showWorldMap(9000)
		keys(true)
		local took = stub.canvasClick()
		stub.RunScript(Minimap, "OnMouseUp", "LeftButton")
		keys(false, true)
		stub.fire("GLOBAL_MOUSE_DOWN", "LeftButton")
		emit({ took = took, target = N.GetTarget() == nil })
	"#);
	assert_eq!(out[0], json!({ "took": false, "target": true }));
}

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

#[test]
fn api_navigate_checks_its_input_sets_the_target_and_names_the_owner_cancel_only_for_that_owner() {
	let out = run(r#"
		emit({ API.Navigate("", 9000, 0.5, 0.5), API.Navigate("A", 9000, 1.5, 0.5), API.Navigate("A", 12345, 0.5, 0.5),
			API.Navigate("A", 9000, 0.5, 0.5, 7), API.Navigate("A", 9000.5, 0.5, 0.5), N.GetTarget() == nil, API.Active() })
		local ok = API.Navigate("Helper", 9000, 0.25, 0.75, "Camp")
		local t = N.GetTarget()
		local active, owner = API.Active()
		emit({ ok = ok, x = t.x, y = t.y, label = t.label, active = active, owner = owner })
		emit({ other = API.Cancel("Someone"), mine = API.Cancel("Helper"), target = N.GetTarget() == nil, again = API.Cancel("Helper") })
	"#);
	assert_eq!(out[0], json!([false, false, false, false, false, true, false]));
	assert_eq!(out[1], json!({ "ok": true, "x": 25, "y": 75, "label": "Camp", "active": true, "owner": "Helper" }));
	assert_eq!(out[2], json!({ "other": false, "mine": true, "target": true, "again": false }));
}

#[test]
fn api_a_target_replaced_is_not_the_owner_s_until_the_same_spot_comes_back_the_death_helper_hands_it_back() {
	let out = run(r#"
		API.Navigate("Helper", 9000, 0.25, 0.75, "Camp")
		N.SetTarget(9000, 70, 50, "Your corpse")
		local active, owner = API.Active()
		emit({ active = active, owner = owner or false, cancel = API.Cancel("Helper"), label = label() })
		N.SetTarget(9000, 25, 75, "Camp")
		active, owner = API.Active()
		emit({ owner = owner or false, cancel = API.Cancel("Helper") })
	"#);
	assert_eq!(out[0], json!({ "active": true, "owner": false, "cancel": false, "label": "Your corpse" }));
	assert_eq!(out[1], json!({ "owner": "Helper", "cancel": true }));
}

#[test]
fn api_estimate_answers_in_seconds_from_the_player_or_a_given_point_and_refuses_bad_input() {
	let out = run(r#"
		local a = API.Estimate(nil, nil, nil, 9000, 0.5, 0.6)       -- 200 yd south of the player
		local b = API.Estimate(nil, nil, nil, 9000, 0.5, 0.6)
		local c = API.Estimate(9000, 0.5, 0.1, 9000, 0.5, 0.6)       -- 1000 yd
		local bad, why = API.Estimate(nil, nil, nil, 9000, 2, 0.5)
		local bad2, why2 = API.Estimate(9000, -1, 0.5, 9000, 0.5, 0.5)
		emit({ a = a, b = b, c = c, bad = bad or false, why = why, bad2 = bad2 or false, why2 = why2 })
	"#);
	let out = &out[0];
	assert!(out["a"].as_f64().is_some_and(|a| a > 0.0 && a.is_finite()), "a {}", out["a"]);
	assert_eq!(out["a"], out["b"], "the same question answers the same");
	assert!(out["c"].as_f64().unwrap() > out["a"].as_f64().unwrap(), "a longer walk takes longer");
	assert_eq!(json!([out["bad"], out["why"], out["bad2"], out["why2"]]), json!([false, "invalid", false, "invalid"]));
}

#[test]
fn api_a_route_sent_while_a_ghost_is_taken_without_error_c11() {
	let out = run(r#"
		function UnitIsGhost() return true end
		function UnitIsDeadOrGhost() return true end
		emit({ ok = API.Navigate("Helper", 9000, 0.3, 0.3, "Camp"), label = label() })
	"#);
	assert_eq!(out[0], json!({ "ok": true, "label": "Camp" }));
}

// ---------------------------------------------------------------------------
// TomTom stand-in
// ---------------------------------------------------------------------------

// The stand-in is off by default ("Let other addons set waypoints"): these tests turn it on as a player would.
const ANSWER: Option<&str> = Some("PolestarDB = { schema = 1, settings = { nav = { answerTomTom = true } } }");

#[test]
fn tomtom_stand_in_off_by_default_so_no_tomtom_global_an_addon_reading_tomtom_db_would_error_and_no_way() {
	let out = run(r#"
		emit({ tomtom = TomTom == nil, answering = J.AnsweringTomTom(), way = SLASH_POLESTARWAY1 == nil,
			default = Polestar.Get("nav.answerTomTom") })
	"#);
	assert_eq!(out[0], json!({ "tomtom": true, "answering": false, "way": true, "default": false }));
}

#[test]
fn tomtom_stand_in_other_addons_waypoints_point_the_arrow_one_at_a_time_corpse_and_polestar_s_own_are_ignored_row_7() {
	let out = run_with(
		r#"
		emit(TomTom == N.tomtomShim)
		local uid = TomTom:AddWaypoint(9000, 0.25, 0.75, { title = "Quest giver", from = "Helper" })
		local t = N.GetTarget()
		local _, owner = API.Active()
		emit({ x = t.x, y = t.y, label = t.label, owner = owner, valid = TomTom:IsValidWaypoint(uid),
			exists = TomTom:WaypointExists(9000, 0.25, 0.75, "Quest giver"), from = uid.from })
		emit({ removed = TomTom:RemoveWaypoint(uid), target = N.GetTarget() == nil, valid = TomTom:IsValidWaypoint(uid) })
		emit({ corpse = TomTom:AddWaypoint(9000, 0.5, 0.5, { title = "My Corpse", corpse = true }) == nil,
			mirror = TomTom:AddWaypoint(9000, 0.5, 0.5, { from = "Polestar" }) == nil, target = N.GetTarget() == nil,
			bad = TomTom:AddWaypoint(9000, 0.5, 0.5, "nope") == nil })
		TomTom:AddZWaypoint(0, 9000, 30, 40, "Old style")
		t = N.GetTarget()
		emit({ x = t.x, y = t.y, label = t.label })
		TomTom:ClearAllWaypoints()
		emit(N.GetTarget() == nil)
		Polestar.Set("nav.answerTomTom", false)
		emit(TomTom == nil)
	"#,
		"",
		ANSWER,
		true,
	);
	assert_eq!(out[0], true);
	assert_eq!(out[1], json!({ "x": 25, "y": 75, "label": "Quest giver", "owner": "TomTom", "valid": true, "exists": true, "from": "Helper" }));
	assert_eq!(out[2], json!({ "removed": true, "target": true, "valid": false }));
	assert_eq!(out[3], json!({ "corpse": true, "mirror": true, "target": true, "bad": true }));
	assert_eq!(out[4], json!({ "x": 30, "y": 40, "label": "Old style" }));
	assert_eq!(out[5], true);
	assert_eq!(out[6], true);
}

#[test]
fn tomtom_stand_in_polestar_s_own_targets_are_never_mirrored_into_it_no_loop() {
	let out = run_with(
		r#"
		N.SetTarget(9000, 60, 60, "Picked")
		local n = 0
		for _, byKey in pairs(TomTom.waypoints) do for _ in pairs(byKey) do n = n + 1 end end
		local _, owner = API.Active()
		emit({ label = label(), waypoints = n, owner = owner or false })
	"#,
		"",
		ANSWER,
		true,
	);
	assert_eq!(out[0], json!({ "label": "Picked", "waypoints": 0, "owner": false }));
}

#[test]
fn tomtom_stand_in_a_tomtom_switched_off_in_the_addons_list_does_not_count_an_enabled_one_does_row_7() {
	let disabled = run_with("emit(TomTom == N.tomtomShim)", r#"stub.addons = { { name = "TomTom", reason = "DISABLED", enabled = false } }"#, ANSWER, true);
	let enabled = run_with("emit(TomTom == nil)", r#"stub.addons = { { name = "TomTom" } }"#, ANSWER, true);
	assert_eq!(disabled[0], true);
	assert_eq!(enabled[0], true);
}

#[test]
fn tomtom_stand_in_other_tomtom_methods_are_harmless_no_ops_fields_such_as_tomtom_db_are_not_provided_security_l7() {
	let out = run_with(
		r#"
		local ok, err = pcall(function()
			return TomTom:SetCustomClickCallback("x"), TomTom:AddCustomCallback(), TomTom.GetCurrentWaypoint(TomTom)
		end)
		emit({ ok = ok, err = err or false, db = TomTom.db == nil, profile = TomTom.profile == nil,
			add = type(TomTom.AddWaypoint), target = N.GetTarget() == nil })
	"#,
		"",
		ANSWER,
		true,
	);
	assert_eq!(out[0], json!({ "ok": true, "err": false, "db": true, "profile": true, "add": "function", "target": true }));
}

#[test]
fn tomtom_stand_in_the_global_is_taken_at_login_and_an_addon_s_own_tomtom_compatible_global_keeps_it_security_l7() {
	let out = run_with(
		r#"
		emit(TomTom == nil)
		TomTom = { AddWaypoint = function() return "theirs" end, RemoveWaypoint = function() end }
		stub.loggedIn = true
		stub.fire("PLAYER_LOGIN")
		emit({ theirs = TomTom.AddWaypoint() == "theirs", answering = J.AnsweringTomTom() })
	"#,
		"",
		ANSWER,
		false,
	);
	assert_eq!(out[0], true, "nothing set before every addon has loaded");
	assert_eq!(out[1], json!({ "theirs": true, "answering": false }));
}

// A TomTom 4.3.12-shaped fake (its SetCrazyArrow, ClearWaypoint and RemoveWaypoint called through the table,
// AddWaypoint pointing the arrow when crazy).
const REAL_TOMTOM: &str = r#"
TomTom = { valid = {}, adds = {} }
function TomTom:SetCrazyArrow(uid) self.arrow = uid end
function TomTom:ClearWaypoint(uid) self.valid[uid] = nil end
function TomTom:RemoveWaypoint(uid) self:ClearWaypoint(uid) end
function TomTom:IsValidWaypoint(uid) return self.valid[uid] == true end
function TomTom:AddWaypoint(m, x, y, opts)
	opts = opts or {}
	local uid = { m, x, y, title = opts.title, from = opts.from or "?" }
	for k, v in pairs(opts) do if uid[k] == nil then uid[k] = v end end
	self.valid[uid] = true
	table.insert(self.adds, uid)
	if opts.crazy ~= false then self:SetCrazyArrow(uid) end
	return uid
end
"#;
const FOLLOW: Option<&str> = Some("PolestarDB = { schema = 1, settings = { nav = { followTomTom = true } } }");

#[test]
fn follow_tomtom_restores_the_arrow_s_waypoint_one_frame_after_player_entering_world_never_mirrored_back_row_7() {
	let out = run_with(
		r#"
		local uid = TomTom:AddWaypoint(9000, 0.25, 0.75, { title = "Saved", from = "TomTom/way" }) -- TomTom's login restore
		emit(N.GetTarget() == nil)
		stub.loggedIn = true
		stub.fire("PLAYER_LOGIN")
		stub.fire("PLAYER_ENTERING_WORLD", true, false)
		emit(N.GetTarget() == nil)
		stub.runTimers()
		emit({ label = label(), adds = #TomTom.adds, shim = TomTom == N.tomtomShim })
	"#,
		REAL_TOMTOM,
		FOLLOW,
		false,
	);
	assert_eq!(out[0], true);
	assert_eq!(out[1], true, "not before a frame has passed");
	assert_eq!(out[2], json!({ "label": "Saved", "adds": 1, "shim": false }));
}

#[test]
fn follow_tomtom_remove_all_ends_it_the_corpse_arrow_and_polestar_s_own_mirror_are_ignored_off_means_never_row_7() {
	let out = run_with(
		r#"
		stub.runTimers()
		local uid = TomTom:AddWaypoint(9000, 0.25, 0.75, { title = "Guide pin", from = "Helper" })
		emit(label())
		TomTom:AddWaypoint(9000, 0.5, 0.5, { title = "My Corpse", corpse = true })
		emit(label())
		N.SetTarget(9000, 60, 60, "Picked") -- Bridges mirrors it (from = "Polestar", crazy off unless the TomTom arrow is used)
		TomTom:SetCrazyArrow(TomTom.adds[#TomTom.adds])
		emit({ label = label(), from = TomTom.adds[#TomTom.adds].from })
		TomTom:SetCrazyArrow(uid)
		TomTom:ClearWaypoint(uid) -- "Remove all waypoints" clears through ClearWaypoint alone
		emit(N.GetTarget() == nil)
		Polestar.Set("nav.followTomTom", false)
		TomTom:AddWaypoint(9000, 0.1, 0.1, { title = "Ignored", from = "Helper" })
		emit(N.GetTarget() == nil)
	"#,
		REAL_TOMTOM,
		FOLLOW,
		true,
	);
	assert_eq!(out[0], "Guide pin");
	assert_eq!(out[1], "Guide pin");
	assert_eq!(out[2], json!({ "label": "Picked", "from": "Polestar" }));
	assert_eq!(out[3], true);
	assert_eq!(out[4], true);
}

// ---------------------------------------------------------------------------
// /way
// ---------------------------------------------------------------------------

#[test]
fn way_x_y_on_your_map_mapid_a_zone_named_inside_its_name_an_ambiguous_name_reset_row_7() {
	let out = run_with(
		r##"
		emit(SLASH_POLESTARWAY1)
		local way = SlashCmdList.POLESTARWAY
		way("45 61 Camp")
		local t = N.GetTarget()
		emit({ map = t.map, x = t.x, y = t.y, label = t.label })
		way("#9000 10,5 20")
		t = N.GetTarget()
		emit({ map = t.map, x = t.x, y = t.y, label = t.label })
		way("barrens 50, 50")
		t = N.GetTarget()
		emit({ map = t.map, x = t.x, y = t.y })
		stub.messages = {}
		way("test 10 10")
		emit(said("test could be Test Ridge, Testshire."))
		way("reset")
		emit(N.GetTarget() == nil)
	"##,
		"",
		ANSWER,
		true,
	);
	assert_eq!(out[0], "/way");
	assert_eq!(out[1], json!({ "map": 9000, "x": 45, "y": 61, "label": "Camp" }));
	assert_eq!(out[2], json!({ "map": 9000, "x": 10.5, "y": 20, "label": "Testshire 11, 20" }));
	assert_eq!(out[3], json!({ "map": 9002, "x": 50, "y": 50 }));
	assert_eq!(out[4], true);
	assert_eq!(out[5], true);
}

#[test]
fn way_left_alone_when_another_addon_has_it() {
	let out = run_with("emit(SLASH_POLESTARWAY1 == nil)", r#"SLASH_OTHERWAY1 = "/WAY""#, ANSWER, true);
	assert_eq!(out[0], true);
}

// ---------------------------------------------------------------------------
// Nearby services
// ---------------------------------------------------------------------------

const CODEX: &str = r#"
local npcs = {
	[1] = { id = 1, name = "Near Smith", faction = "A", spawns = { { map = 9000, x = 55, y = 50 } } },
	[2] = { id = 2, name = "Far Smith", faction = "AH", spawns = { { map = 9000, x = 90, y = 50 }, { map = 9000, x = 52, y = 50 } } },
	[3] = { id = 3, name = "Horde Smith", faction = "H", spawns = { { map = 9000, x = 50, y = 51 } } },
	[4] = { id = 4, name = "Deep Smith", instance = "Deadmines", spawns = { { map = 9000, x = 50, y = 50.5 } } },
	[5] = { id = 5, name = "Reagent Ruth", faction = "A", spawns = { { map = 9000, x = 40, y = 50 } } },
	[6] = { id = 6, name = "Miner Mo", spawns = { { map = 9000, x = 60, y = 60 } } },
}
local roles = { repair = { 1, 2, 3, 4 }, vendor = { 1, 5 }, ["trainer:186"] = { 6 } }
stub.codexLoaded = true
Polestar.Codex = {
	IsLoaded = function() return stub.codexLoaded end,
	Load = function() stub.codexLoaded = true; return true end,
	WithRole = function(r) return roles[r] or {} end,
	Npc = function(id) return npcs[id] end,
}
Polestar.QoL = { data = { reagentVendors = { [5] = true } } }
nav.faction = "Alliance"
local Near = N.nearby
"#;

#[test]
fn nearby_the_nearest_spawn_of_each_friendly_npc_outside_instances_ranked_by_travel_time() {
	let out = run(&[
		CODEX,
		r#"
		Near.Go("repair")
		emit(label())
		Near.Go("reagents")
		emit(label())
		Near.Command("trainer mining")
		emit(label())
		N.ClearTarget()
		Near.Command("Mining")
		emit(label())
		nav.Engine.NearestClassTrainer = function() return { npc = 9, npcName = "Trainer Tess", map = 9000, x = 45, y = 50 } end
		Near.Command("class")
		emit(label())
	"#,
	]
	.concat());
	assert_eq!(out[0], "Far Smith", "its second spawn is 40 yd away; the Horde and dungeon smiths never count");
	assert_eq!(out[1], "Reagent Ruth", "only vendors listed as reagent vendors");
	assert_eq!(out[2], "Miner Mo");
	assert_eq!(out[3], "Miner Mo", "a profession alone means its trainer");
	assert_eq!(out[4], "Trainer Tess");
}

// A French client whose names pack lands after the first /polestar near: the Codex then names its NPCs in
// French (Codex drops its records on NAMES_LOADED), and so must the places Nearby kept.
#[test]
fn nearby_a_names_pack_landing_late_renames_the_places_a_learned_npc_name_too() {
	let out = run(&[
		CODEX,
		r#"
		function GetLocale() return "frFR" end
		Near.Go("repair")
		emit(label())
		npcs[2].name = "Forgeron lointain"
		Polestar.Fire("NAMES_LOADED")
		Near.Go("repair")
		emit(label())
		npcs[2].name = "Forgeron du lointain"
		Polestar.Fire("NAME_LEARNED", "npc", 2)
		Near.Go("repair")
		emit(label())
	"#,
	]
	.concat());
	assert_eq!(out[0], "Far Smith");
	assert_eq!(out[1], "Forgeron lointain");
	assert_eq!(out[2], "Forgeron du lointain");
}

#[test]
fn nearby_rank_estimates_only_the_nearest_few_and_the_quickest_by_route_wins_over_the_nearest_by_line() {
	let out = run(r#"
		local Near = N.nearby
		local places, asked = {}, {}
		for i = 1, 10 do places[i] = { id = i, c = 0, wx = i * 10, wy = 0 } end
		places[11] = { id = 11, c = 1, wx = 0, wy = 0 } -- another continent
		local best, s = Near.Rank(places, { c = 0, wx = 0, wy = 0 }, function(p)
			asked[#asked + 1] = p.id
			return p.id == 3 and 5 or 100
		end)
		local none = Near.Rank({}, { c = 0, wx = 0, wy = 0 }, function() return 1 end)
		local straight, s2 = Near.Rank({ { id = 1, c = 0, wx = 70, wy = 0 } }, { c = 0, wx = 0, wy = 0 }, function() return nil end)
		emit({ best = best.id, s = s, asked = asked, none = none == nil, straight = straight.id, s2 = s2 })
	"#);
	assert_eq!(out[0], json!({ "best": 3, "s": 5, "asked": [1, 2, 3, 4, 5, 6], "none": true, "straight": 1, "s2": 10 }));
}

#[test]
fn nearby_no_codex_combat_and_nothing_known_each_say_their_own_line_c14() {
	let out = run(&[
		r#"
		Polestar.Codex = nil
		stub.messages = {}
		emit({ ok = N.nearby.Go("bank"), said = said("Nearby services need the Polestar Codex addon, which is not installed") })
	"#,
		CODEX,
		r#"
		stub.codexLoaded = false
		stub.inCombat = true
		stub.messages = {}
		emit({ ok = Near.Go("bank"), said = said("Nearby services can be looked up after combat."), loaded = stub.codexLoaded })
		stub.inCombat = false
		stub.messages = {}
		emit({ ok = Near.Go("stable"), said = said("No stable master known for your faction.") })
		stub.messages = {}
		Near.Command("spaceport")
		emit(said("Usage: /polestar near"))
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "ok": false, "said": true }));
	assert_eq!(out[1], json!({ "ok": false, "said": true, "loaded": false }));
	assert_eq!(out[2], json!({ "ok": false, "said": true }));
	assert_eq!(out[3], true);
}

#[test]
fn nearby_each_codex_failure_says_its_own_line_missing_disabled_empty_any_other_load_reason_review_p2_7_c14() {
	let out = run(&[
		CODEX,
		r#"
		local function try(loadReason, roleList)
			stub.codexLoaded = loadReason == nil
			Polestar.Codex.Load = function() return false, loadReason end
			Polestar.Codex.WithRole = function() return roleList or {} end
			stub.messages = {}
			local _, why = Near.Find("bank")
			Near.Go("bank")
			return { why = why, line = stub.messages[#stub.messages] or false }
		end
		emit(try("missing"))
		emit(try("disabled"))
		emit(try("interface_version"))
		emit(try(nil, {})) -- loaded, but no NPC has any role: a broken Codex
	"#,
	]
	.concat());
	let (missing, disabled, other, empty) = (&out[0], &out[1], &out[2], &out[3]);
	assert_eq!(missing["why"], "missing");
	assert!(is_match(text(&missing["line"]), r"need the Polestar Codex addon, which is not installed"));
	assert_eq!(disabled["why"], "disabled");
	assert!(is_match(text(&disabled["line"]), r"turn it on in the AddOns list"));
	assert_eq!(other["why"], "interface_version");
	assert!(is_match(text(&other["line"]), r"could not load the Polestar Codex \(interface_version\)"));
	assert_eq!(empty["why"], "empty");
	assert!(is_match(text(&empty["line"]), r"could not read the Polestar Codex: reinstall Polestar"));
	let lines: HashSet<String> = out.iter().map(|o| o["line"].to_string()).collect();
	assert_eq!(lines.len(), 4, "four different lines");
	assert!(out.iter().all(|o| !is_match(text(&o["line"]), r"known for your faction")), "never \"none known\" for a Codex failure");
}

#[test]
fn nearby_the_tracking_menus_carry_a_nearby_services_submenu_with_every_kind_picking_one_sets_the_target() {
	let out = run(&[
		CODEX,
		r#"
		local function node(text, fn)
			local n = { text = text, fn = fn, kids = {} }
			function n:CreateButton(t, f) local k = node(t, f); table.insert(self.kids, k); return k end
			return n
		end
		local root = node("root")
		stub.menus.MENU_MINIMAP_TRACKING(nil, root)
		local sub = root.kids[1]
		local texts = {}
		for _, k in ipairs(sub.kids) do texts[#texts + 1] = k.text end
		local trainers = {}
		for _, k in ipairs(sub.kids[1].kids) do trainers[#trainers + 1] = k.text end
		sub.kids[4].fn() -- Repair
		local world = stub.menus.MENU_WORLD_MAP_TRACKING ~= nil
		Polestar.Set("nav.nearbyMenu", false)
		local empty = node("root")
		stub.menus.MENU_MINIMAP_TRACKING(nil, empty)
		emit({ title = sub.text, texts = texts, trainers = trainers, label = label(), world = world, off = #empty.kids })
	"#,
	]
	.concat());
	let out = &out[0];
	assert_eq!(out["title"], "Nearby services");
	assert_eq!(out["texts"], json!(["Profession trainer", "Class trainer", "Weapon master", "Repair", "Reagents", "Vendor", "Innkeeper", "Bank", "Auction house", "Flight master", "Stable master"]));
	assert_eq!(out["trainers"], json!(["Nearest", "Alchemy", "Mining"]), "no riding trainer");
	assert_eq!(out["label"], "Far Smith");
	assert_eq!(out["world"], true);
	assert_eq!(out["off"], 0);
}

#[test]
fn nearby_a_trip_ends_at_the_service_or_on_back_to_the_guide_and_the_arrow_is_back_on_the_guide_another_target_ends_it_quietly() {
	let out = run(&[
		CODEX,
		r#"
		local trips = 0
		Polestar.On("NEARBY_TRIP", function() trips = trips + 1 end)
		Near.Go("repair")
		local going = Near.Trip()
		local onTrip = { name = going and going.name, label = going and going.label, override = N.IsOverride() }
		Polestar.Fire("NAV_ARRIVED", N.GetTarget())
		local before = Near.Trip() ~= nil
		stub.runTimers()
		local arrived = { trip = Near.Trip() == nil, override = N.IsOverride(), said = said("At Far Smith: the arrow is back on the guide.") }
		Near.Go("vendor")
		local backed = { ended = Near.EndTrip(), trip = Near.Trip() == nil, override = N.IsOverride(), said = said("The arrow is back on the guide."), again = Near.EndTrip() }
		Near.Go("vendor")
		N.SetTarget(9000, 10, 10, "Elsewhere")
		emit({ onTrip = onTrip, before = before, arrived = arrived, backed = backed, replaced = Near.Trip() == nil, label = label(), trips = trips })
	"#,
	]
	.concat());
	let out = &out[0];
	assert_eq!(out["onTrip"], json!({ "name": "Far Smith", "label": "Repair", "override": true }));
	assert_eq!(out["before"], true, "the arrival is drawn first");
	assert_eq!(out["arrived"], json!({ "trip": true, "override": false, "said": true }));
	assert_eq!(out["backed"], json!({ "ended": true, "trip": true, "override": false, "said": true, "again": false }));
	assert_eq!(out["replaced"], true);
	assert_eq!(out["label"], "Elsewhere");
	assert_eq!(out["trips"], 6, "start and end of each of the three trips");
}

#[test]
fn nearby_weapon_masters_the_class_s_weapons_a_master_of_its_side_teaches_known_or_not_and_the_nearest_master_of_the_one_picked() {
	let out = run(&[
		CODEX,
		r#"
		local C = Polestar.Compat
		local info = { name = "Testchar", level = 12, faction = "Alliance", class = "ROGUE" }
		C.GetPlayerInfo = function() return info end
		Polestar.Gear = { PROFICIENCY = { ROGUE = { weapons = { [2] = true, [3] = true, [4] = true, [7] = true, [13] = true, [15] = true, [16] = true, [18] = true } } } }
		C.IsPlayerSpell = function(id) return id == 1180 end -- daggers
		C.GetSkillRank = function() return nil end
		local function names(list)
			local out = {}
			for _, w in ipairs(list) do out[#out + 1] = w.label .. (w.known and " known" or "") end
			return out
		end
		local rogue = names(Near.Weapons())
		-- Woo Ping (Stormwind) teaches swords; Bixi Wobblebonk (Ironforge) daggers.
		local codexNpc = Polestar.Codex.Npc
		Polestar.Codex.Npc = function(id)
			if id == 11867 then return { id = id, name = "Woo Ping", faction = "A", spawns = { { map = 9000, x = 60, y = 50 } } } end
			if id == 13084 then return { id = id, name = "Bixi Wobblebonk", faction = "A", spawns = { { map = 9000, x = 70, y = 50 } } } end
			return codexNpc(id)
		end
		Near.Go("weapon", 43)
		local swords = label()
		local said1 = said("Nearest weapon master (swords): Woo Ping")
		info.faction = "Horde"
		local horde = names(Near.Weapons())
		info.class, info.level = "WARRIOR", 12
		Polestar.Gear.PROFICIENCY.WARRIOR = { weapons = { [0] = true, [6] = true, [7] = true } }
		local polearms
		for _, w in ipairs(Near.Weapons()) do if w.label == "Polearms" then polearms = w.level end end
		local listed
		for _, e in ipairs(Near.MenuItems()) do if e.weapons then listed = #e.weapons end end
		Polestar.Gear = nil
		emit({ rogue = rogue, swords = swords, said = said1, horde = horde, polearms = polearms, listed = listed, none = #Near.Weapons() })
	"#,
	]
	.concat());
	let out = &out[0];
	assert_eq!(out["rogue"], json!(["Swords", "Maces", "Daggers known", "Fist weapons", "Bows", "Crossbows", "Guns", "Thrown"]), "a rogue, Alliance side");
	assert_eq!(out["swords"], "Woo Ping");
	assert_eq!(out["said"], true);
	assert_eq!(out["horde"], json!(["Swords", "Maces", "Daggers known", "Fist weapons", "Bows", "Crossbows", "Guns", "Thrown"]), "the Horde's masters teach them all too");
	assert_eq!(out["polearms"], 20, "polearms from level 20");
	assert_eq!(out["listed"], 3, "the guide window lists the weapon master with its weapons");
	assert_eq!(out["none"], 0, "no gear tables: no weapons");
}

#[test]
fn nearby_the_guide_window_s_list_puts_the_everyday_services_first_then_a_trainer_for_each_profession_the_character_has() {
	let out = run(&[
		CODEX,
		r#"
		local function texts()
			local out = {}
			for _, e in ipairs(Near.MenuItems()) do out[#out + 1] = e.separator and "-" or e.label end
			return out
		end
		local MINING = 186
		Polestar.Compat.GetSkillRank = function(line) if line == MINING then return 75, 150 end end
		local items = Near.MenuItems()
		local miningKey
		for _, e in ipairs(items) do if e.line == MINING then miningKey = e.key end end
		emit({ texts = texts(), key = miningKey })
		Polestar.Compat.GetSkillRank = function() return nil end
		emit(texts())
	"#,
	]
	.concat());
	let (mining, none) = (&out[0], &out[1]);
	assert_eq!(mining["texts"], json!(["Vendor", "Repair", "Innkeeper", "Flight master", "Class trainer", "Mining trainer", "-", "Reagents", "Bank", "Auction house", "Stable master"]));
	assert_eq!(mining["key"], "trainer");
	assert_eq!(
		*none,
		json!(["Vendor", "Repair", "Innkeeper", "Flight master", "Class trainer", "Profession trainer", "-", "Reagents", "Bank", "Auction house", "Stable master"]),
		"no profession yet: the nearest trainer of any"
	);
}

// ---------------------------------------------------------------------------
// Corpse: the death helper hands a picked point back
// ---------------------------------------------------------------------------

#[test]
fn death_helper_a_point_picked_before_dying_comes_back_after_resurrecting_on_the_same_step_only() {
	let run2 = |script: &str| {
		emitted(&RunAddon {
			stubs: vec!["stub_qol.lua"],
			addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "QoL/QoL.xml"])],
			login: true,
			script: ["local q = stub.qol\nlocal QoL = Polestar.QoL\n", script].concat(),
			..Default::default()
		})
		.remove(0)
	};
	let back = run2(
		r#"
			q.Nav.IsOverride = function() return q.nav.target ~= nil and q.nav.target.label == "Picked" end
			QoL.SetData({ spiritHealers = { { 0, 20, 0, 9000, 50, 49 } }, flightMasters = {} })
			q.player = { c = 0, wx = 0, wy = 0 }
			q.nav.target = { map = 9000, x = 30, y = 30, label = "Picked", kind = "manual", stepIndex = q.engine.step }
			local _, cx, cy = q.mapPoint(0, -400)
			q.corpse = { cx, cy }
			q.level = 30
			q.ghost = true
			stub.fire("PLAYER_ALIVE")
			local during = q.nav.target.label
			q.ghost = false
			stub.fire("PLAYER_UNGHOST")
			emit({ during = during, after = q.nav.target and q.nav.target.label, releases = q.nav.releases })
		"#,
	);
	let moved = run2(
		r#"
			q.Nav.IsOverride = function() return q.nav.target ~= nil and q.nav.target.label == "Picked" end
			QoL.SetData({ spiritHealers = { { 0, 20, 0, 9000, 50, 49 } }, flightMasters = {} })
			q.player = { c = 0, wx = 0, wy = 0 }
			q.nav.target = { map = 9000, x = 30, y = 30, label = "Picked", kind = "manual", stepIndex = -1 }
			q.level = 8
			q.ghost = true
			stub.fire("PLAYER_ALIVE")
			q.ghost = false
			stub.fire("PLAYER_UNGHOST")
			emit({ after = q.nav.target and q.nav.target.label or false, releases = q.nav.releases })
		"#,
	);
	assert_eq!(back, json!({ "during": "Your corpse", "after": "Picked", "releases": 0 }));
	assert_eq!(moved, json!({ "after": false, "releases": 1 }));
}
