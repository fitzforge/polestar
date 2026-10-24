//! Hand-off to Shortest Path Forever (addon/Polestar/Nav/Handoff.lua): with it installed, Polestar's target goes
//! to it through its public API and every guidance surface of Polestar's steps aside, so the two never guide at
//! once. A fake ShortestPathForever.API, written to its docs/api.md (v1.16.0: version 1, minor 1 with Subscribe,
//! false in combat, with Journeys off or for invalid input, Ended's reasons, Subscribe's next-frame callbacks),
//! stands in for the addon. Runs the real Core/Init.lua, Core/Data.lua, Theme, Nav/Nav.xml, the route lines and
//! the journey panel against tests/lua/stub_nav.lua (map 9000 "Testshire": 2000 yd across, 20 yd per map
//! percent, origin at its centre; the travel world's boat runs from Testshire Docks to Farland).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 9] =
	["Core/Init.lua", "Core/Data.lua", "Theme/Theme.xml", "Nav/Nav.xml", "Maps/FlightPaths.lua", "Maps/RouteStrokes.lua", "Maps/RouteLines.lua", "UI/UI.lua", "UI/JourneyPanel.lua"];

// Before any addon file: the fake Compat from Init.lua on (Data.lua and UI.lua read it at load), addon loading
// recorded, a fake walking engine, the world map's click handlers recorded, and the player's death state.
const EARLY: &str = r#"
loads = {}
local loadAddOn = C_AddOns.LoadAddOn
function C_AddOns.LoadAddOn(name) loads[#loads + 1] = name; return loadAddOn(name) end
do
	local load = loadfile
	function loadfile(file)
		local chunk, err = load(file)
		if not chunk or not file:match("[/\\]Polestar[/\\]Core[/\\]Init%.lua$") then return chunk, err end
		return function(name, ns)
			chunk(name, ns)
			ns.Compat = stub.nav.Compat
			ns.Compat.Readable = ns.Compat.Readable or function(v) return v end
			ns.Compat.AddOnPresent = ns.Compat.AddOnPresent or function() return false end
		end
	end
end
finds = 0
Polestar_NavEngine = {
	Find = function(map, from, to, callback) finds = finds + 1; return {} end,
	Cancel = function() end,
	Busy = function() return false end,
	Available = function() return true end,
}
stub.dead = false
function UnitIsDeadOrGhost(unit) return unit == "player" and stub.dead end
stub.canvas = { handlers = {} }
function WorldMapFrame.AddCanvasClickHandler(_, fn) table.insert(stub.canvas.handlers, fn) end
function WorldMapFrame.GetNormalizedCursorPosition() return 0.7, 0.3 end
function stub.canvasClick()
	local took = false
	for _, fn in ipairs(stub.canvas.handlers) do if fn(WorldMapFrame, "LeftButton") then took = true end end
	return took
end
"#;

// ShortestPathForever.API as docs/api.md has it. spf.calls records every call; spf.clear(), spf.replace(owner)
// and spf.arrive() are the player, another addon and the journey's end; spf.noWay() is its search finding no
// way to the stop (the journey stays, unguided: Active() false, its tracker "No way there from here."),
// spf.guide() its guidance on again, spf.corpseRun(on) its own corpse run guiding (Active() true whoever's
// journey waits behind it); subscribers hear of changes on the next frame.
const SPF: &str = r#"
spf = { calls = {}, ended = {}, subs = {}, journeys = true, reads = 0, guided = false }
local A = { version = 1, minor = 1 }
ShortestPathForever = { API = A }
local function number(v) return type(v) == "number" and v == v and math.abs(v) < math.huge end
local function point(map, x, y)
	return number(map) and map > 0 and map % 1 == 0 and number(x) and number(y) and x >= 0 and x <= 1 and y >= 0 and y <= 1
end
local function quest(v) return number(v) and v % 1 == 0 and v >= 1 end
local function valid(s)
	if type(s) ~= "table" or not point(s.map, s.x, s.y) then return false end
	if s.title ~= nil and type(s.title) ~= "string" then return false end
	if s.hold ~= nil and type(s.hold) ~= "boolean" then return false end
	if s.radius ~= nil and not (number(s.radius) and s.radius >= 0) then return false end
	if s.questID ~= nil and not quest(s.questID) then return false end
	if s.questIDs ~= nil then
		if type(s.questIDs) ~= "table" or #s.questIDs < 1 then return false end
		for _, q in ipairs(s.questIDs) do if not quest(q) then return false end end
	end
	if s.shapes ~= nil then
		if type(s.shapes) ~= "table" or #s.shapes < 1 then return false end
		for _, sh in ipairs(s.shapes) do
			if type(sh) ~= "table" or not point(sh.map, sh.x, sh.y) or not (number(sh.radius) and sh.radius >= 0) then return false end
		end
	end
	return true
end
local burst
function spf.changed(what)
	if not burst then
		burst = {}
		C_Timer.After(0, function()
			local changes = burst
			burst = nil
			for _, cb in ipairs(spf.subs) do cb(changes) end
		end)
	end
	burst[what] = true
end
local function start(owner, stops)
	if spf.owner and spf.owner ~= owner then spf.ended[spf.owner] = "replaced" end
	spf.ended[owner] = nil
	spf.owner, spf.stops, spf.index, spf.guided = owner, stops, 1, true
	spf.changed("started")
end
function A.NavigateRoute(owner, stops)
	table.insert(spf.calls, { op = "route", owner = owner, stops = stops })
	if spf.combatOnce then
		spf.combatOnce = nil
		stub.inCombat = true
	end
	if InCombatLockdown() or not spf.journeys or type(owner) ~= "string" or type(stops) ~= "table" or #stops < 1 or #stops > 64 then return false end
	for _, s in ipairs(stops) do if not valid(s) then return false end end
	start(owner, stops)
	return true
end
function A.Navigate(owner, map, x, y, title, kind)
	return A.NavigateRoute(owner, { { map = map, x = x, y = y, title = title, kind = kind } })
end
function A.CurrentStop(owner) spf.reads = spf.reads + 1; return spf.owner == owner and spf.index or nil end
function A.Cancel(owner)
	table.insert(spf.calls, { op = "cancel", owner = owner })
	if spf.owner ~= owner then return false end
	spf.ended[owner], spf.owner = "cancelled", nil
	spf.changed("ended")
	return true
end
function A.Active() spf.reads = spf.reads + 1; return spf.corpse or (spf.owner ~= nil and spf.guided) end
function A.Ended(owner) return spf.ended[owner] end
function A.Subscribe(cb)
	if type(cb) ~= "function" then error("callback must be a function", 2) end
	table.insert(spf.subs, cb)
	return function() end
end
function A.Estimate() return 60 end
function spf.clear()
	if spf.owner then spf.ended[spf.owner], spf.owner = "cleared", nil end
	spf.changed("ended")
end
function spf.replace(owner)
	start(owner, { { map = 9000, x = 0.1, y = 0.1 } })
end
function spf.arrive()
	if spf.owner then spf.ended[spf.owner], spf.owner = "arrived", nil end
	spf.changed("ended")
end
function spf.noWay()
	spf.guided = false
	spf.changed("active")
end
function spf.guide()
	if spf.owner then spf.guided = true end
	spf.changed("active")
end
function spf.corpseRun(on)
	spf.corpse = on
	spf.changed("active")
end
function spf.routes()
	local n = 0
	for _, c in ipairs(spf.calls) do if c.op == "route" then n = n + 1 end end
	return n
end
function spf.cancels()
	local n = 0
	for _, c in ipairs(spf.calls) do if c.op == "cancel" then n = n + 1 end end
	return n
end
function spf.last()
	for i = #spf.calls, 1, -1 do if spf.calls[i].op == "route" then return spf.calls[i] end end
end
"#;

// Minor 0: the same API without Subscribe.
fn spf_minor0() -> String {
	format!("{SPF}\nShortestPathForever.API.minor = nil\nShortestPathForever.API.Subscribe = nil\n")
}

const PRELUDE: &str = r#"
local N, nav = Polestar.Nav, stub.nav
local H = N.handoff
local JP = Polestar.UI.JourneyPanel
local floor = math.floor
nav.useTravelWorld()
-- The player at Testshire Docks; Farland (map 9001) lies over the sea: the boat.
nav.place(-850, 0)
local FARLAND = { map = 9001, x = 50, y = 20, label = "Farland camp", stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 }
local function copy(t) local c = {}; for k, v in pairs(t) do c[k] = v end; return c end
local function arrowShown() return N.arrow.frame:IsShown() and true or false end
local function legs() local l = N.GetRoute(); return l and #l or 0 end
local function sent() return spf and spf.routes() or 0 end
local function stop() local c = spf.last(); return c and c.stops[1] end
local function r4(v) return v and floor(v * 10000 + 0.5) / 10000 end
-- Polestar's own guidance, surface by surface.
local function surfaces()
	stub.advance(0.3)
	local trail = Polestar.Pins.GetTrail()
	return {
		arrow = arrowShown(),
		route = legs(),
		lines = #Polestar.RouteLines.GetPaths(),
		journey = JP.Route() ~= nil,
		trail = trail ~= nil,
		walk = finds > 0,
		pack = (function() for _, n in ipairs(loads) do if n == "Polestar_Nav" then return true end end return false end)(),
		way = SLASH_POLESTARWAY1 == "/way",
		shim = TomTom ~= nil and TomTom == N.tomtomShim,
	}
end
local function option()
	for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
		for _, c in ipairs(spec.controls) do if c.key == "nav.spfHandoff" then return c end end
	end
end
"#;

// The TomTom stand-in ("Let other addons set waypoints") is off by default; it is on here so its stepping aside
// is seen. Handing off is an option (off on a fresh profile); these tests hand off unless they say otherwise.
const SAVED: &str = "PolestarDB = { schema = 1, settings = { nav = { answerTomTom = true, spfHandoff = true } } }";
// A fresh profile: the defaults, the stand-in on to be seen.
const FRESH: &str = "PolestarDB = { schema = 1, settings = { nav = { answerTomTom = true } } }";

struct Opts<'a> {
	spf: Option<&'a str>,
	files: Vec<&'a str>,
	saved: &'a str,
}

impl Default for Opts<'_> {
	fn default() -> Self {
		Opts { spf: Some(SPF), files: FILES.to_vec(), saved: SAVED }
	}
}

fn run_all(script: &str, o: Opts) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		before: format!("{EARLY}{}", o.spf.unwrap_or("")),
		addons: vec![Addon::files("Polestar", &o.files)],
		saved: vec![("Polestar".into(), o.saved.into())],
		login: true,
		script: format!("{PRELUDE}{script}"),
	})
}

fn run(script: &str, o: Opts) -> Value {
	run_all(script, o).remove(0)
}

#[test]
fn without_shortest_path_forever_nothing_changes_polestar_guides_plans_walks_and_answers_tomtom_and_way_and_the_option_is_hidden() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		local s = surfaces()
		s.handedOff = N.HandedOff()
		s.option = option() ~= nil
		s.shown = option().needs()
		s.alert = (function()
			Polestar.Transit = { Now = function() return 0 end, Riding = function() return { kind = "boat", dock = "Farland Pier", arriveIn = 18, route = "r" } end }
			return N.alerts.Check()
		end)()
		emit(s)
	"#,
		Opts { spf: None, ..Default::default() },
	);
	assert_eq!(
		out,
		json!({
			"arrow": true, "route": 3, "lines": 3, "journey": true, "trail": false, "walk": true, "pack": true, "way": true, "shim": true,
			"handedOff": false, "option": true, "shown": false, "alert": true,
		})
	);
}

#[test]
fn h3_nav_qa_with_it_installed_the_target_goes_as_one_stop_and_every_polestar_guidance_surface_steps_aside() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		local s = surfaces()
		s.handedOff = N.HandedOff()
		s.shown = option().needs()
		local c = spf.last()
		s.owner = c.owner
		s.stops = #c.stops
		s.stop = { map = c.stops[1].map, x = r4(c.stops[1].x), y = r4(c.stops[1].y), title = c.stops[1].title, kind = c.stops[1].kind or false, hold = c.stops[1].hold or false }
		s.sent = sent()
		Polestar.Transit = { Now = function() return 0 end, Riding = function() return { kind = "boat", dock = "Farland Pier", arriveIn = 18, route = "r" } end }
		s.alert = N.alerts.Check()
		s.prompt = N.prompts and N.prompts.Wanted and N.prompts.Wanted() or false
		-- A Shift-click on the world map plans nothing: Shortest Path Forever takes it.
		nav.showWorldMap(9000)
		stub.keys.shift = true
		s.click = stub.canvasClick()
		stub.keys.shift = false
		s.target = N.GetTarget().label
		emit(s)
	"#,
		Opts::default(),
	);
	assert_eq!(
		out,
		json!({
			"arrow": false, "route": 0, "lines": 0, "journey": false, "trail": false, "walk": false, "pack": false, "way": false, "shim": false,
			"handedOff": true, "shown": true, "owner": "Polestar", "stops": 1,
			"stop": { "map": 9001, "x": 0.5, "y": 0.2, "title": "Farland camp", "kind": false, "hold": false },
			"sent": 1, "alert": false, "prompt": false, "click": false, "target": "Farland camp",
		})
	);
}

// #398 (Rawbowke): a target on the player's own continent, with no route planned, still drew the straight walk
// to it on the map and the minimap, beside Shortest Path Forever's own route.
#[test]
fn no_route_lines_while_handing_off_for_a_target_on_the_same_continent_too() {
	const NEAR: &str = r#"{ map = 9000, x = 50, y = 40, label = "Testshire well", stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 }"#;
	let script = r#"
		nav.setWaypoint(${NEAR})
		local s = surfaces()
		emit({ handedOff = N.HandedOff(), lines = s.lines, geometry = N.GetRouteGeometry() ~= nil })
	"#
	.replace("${NEAR}", NEAR);
	let mine = run(&script, Opts { spf: None, ..Default::default() });
	assert_eq!(mine, json!({ "handedOff": false, "lines": 1, "geometry": true }), "without it, Polestar draws the walk");
	let handed = run(&script, Opts::default());
	assert_eq!(handed, json!({ "handedOff": true, "lines": 0, "geometry": false }));
}

#[test]
fn mirrors_stay_out_while_handing_off_no_waypoint_in_its_tomtom_stand_in_no_blizzard_waypoint() {
	let out = run(
		r#"
		Polestar.Compat.AddOnPresent = function(name) return name == "TomTom" end
		nav.withTomTom()
		Polestar.Set("nav.blizzardWaypoint", true)
		nav.userWaypoints = {}
		nav.setWaypoint(copy(FARLAND))
		local adds = 0
		for _, c in ipairs(TomTom.calls) do if c.op == "add" then adds = adds + 1 end end
		local sets = 0
		for _, w in ipairs(nav.userWaypoints) do if w[1] == "set" then sets = sets + 1 end end
		Polestar.Set("nav.spfHandoff", false)
		local after = 0
		for _, c in ipairs(TomTom.calls) do if c.op == "add" then after = after + 1 end end
		emit({ adds = adds, sets = sets, after = after, sent = sent() })
	"#,
		Opts::default(),
	);
	assert_eq!(out["sent"], 1);
	assert_eq!(out["adds"], 0, "no TomTom waypoint: a second journey");
	assert_eq!(out["sets"], 0, "no Blizzard waypoint: a second arrow");
	assert_eq!(out["after"], 1, "the mirror is back with the hand-off off");
}

// Shortest Path Forever's own TomTom stand-in (its Core/TomTom.lua, on by default while TomTom is not
// installed): a waypoint set there starts a journey of its own, owner "TomTom"; removing it cancels that
// journey. It takes 20 waypoints at most, so a loop ends and can be counted.
fn spf_tomtom() -> String {
	SPF.to_string()
		+ r#"
TomTom = {}
local live, taken = nil, 0
function TomTom:AddWaypoint(map, x, y, opts)
	if taken >= 20 then return nil end
	taken = taken + 1
	if not ShortestPathForever.API.Navigate("TomTom", map, x, y, opts and opts.title) then return nil end
	live = { map, x, y, title = opts and opts.title }
	return live
end
function TomTom:RemoveWaypoint(uid)
	if uid ~= live then return false end
	live = nil
	ShortestPathForever.API.Cancel("TomTom")
	return true
end
"#
}

#[test]
fn its_tomtom_stand_in_gets_no_mirrored_waypoint_polestar_guides_and_does_not_step_aside_for_a_journey_it_started_itself_306() {
	let spf = spf_tomtom();
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		for _ = 1, 5 do stub.runTimers(); stub.advance(1.1) end
		local tomtom = 0
		for _, c in ipairs(spf.calls) do if c.owner == "TomTom" then tomtom = tomtom + 1 end end
		emit({ tomtom = tomtom, handedOff = N.HandedOff(), arrow = arrowShown(), owner = spf.owner or false })
	"#,
		Opts { saved: FRESH, spf: Some(&spf), ..Default::default() },
	);
	assert_eq!(out, json!({ "tomtom": 0, "handedOff": false, "arrow": true, "owner": false }));
}

#[test]
fn a_real_tomtom_beside_shortest_path_forever_still_gets_the_mirror() {
	let out = run(
		r#"
		Polestar.Compat.AddOnPresent = function(name) return name == "TomTom" end
		nav.withTomTom()
		nav.setWaypoint(copy(FARLAND))
		local adds = 0
		for _, c in ipairs(TomTom.calls) do if c.op == "add" then adds = adds + 1 end end
		emit({ adds = adds, handedOff = N.HandedOff() })
	"#,
		Opts { saved: FRESH, ..Default::default() },
	);
	assert_eq!(out, json!({ "adds": 1, "handedOff": false }));
}

// One step of goals around (50, 40): wolves for quest 101 in two spawn spots, boars for 102 overlapping the
// first, quest 103's far away, 104's done.
const GUIDE: &str = r#"
local WOLVES = { t = "kill", quest = 101, map = 9000, r = 8, spots = { { x = 50, y = 40, r = 30 }, { x = 55, y = 40, r = 20 } } }
local BOARS = { t = "collect", quest = 102, map = 9000, r = 8, spots = { { x = 52, y = 41, r = 10 } } }
local FAR = { t = "kill", quest = 103, map = 9000, r = 8, spots = { { x = 10, y = 10, r = 10 } } }
local DONE = { t = "collect", quest = 104, map = 9000, r = 8, spots = { { x = 50, y = 41, r = 10 } } }
local GOALS = {
	{ t = "accept", quest = 100, map = 9000, x = 40, y = 40 },
	{ t = "turnin", quest = 99, map = 9000, x = 41, y = 40 },
	WOLVES, BOARS, FAR, DONE,
	{ t = "train", map = 9000, x = 42, y = 40 },
	{ t = "sethome", map = 9000, x = 43, y = 40 },
	{ t = "getfp", map = 9000, x = 44, y = 40 },
	{ t = "talk", map = 9000, x = 45, y = 40 },
	{ t = "kill", map = 9000, x = 46, y = 40 },
}
nav.Engine.GetGuide = function() return { steps = { { goals = GOALS } } } end
nav.engine.views[1] = { goals = {
	{ index = 3, status = "active" }, { index = 4, status = "active" }, { index = 5, status = "active" }, { index = 6, status = "done" },
} }
local function wp(g, extra)
	local goal = GOALS[g]
	local w = { map = goal.map, x = goal.x, y = goal.y, label = goal.t .. " " .. g, stepIndex = 1, goalIndex = g, kind = goal.t, r = 8 }
	for k, v in pairs(extra or {}) do w[k] = v end
	return w
end
local function shape(s)
	local out = { kind = s.kind or false, hold = s.hold or false, radius = s.radius or false, questID = s.questID or false, questIDs = s.questIDs or false }
	if s.shapes then
		out.shapes = {}
		for i, sh in ipairs(s.shapes) do out.shapes[i] = { sh.map, r4(sh.x), r4(sh.y), sh.radius } end
	end
	return out
end
"#;

#[test]
fn each_goal_s_stop_its_kind_and_for_an_objective_area_hold_radius_its_spawn_spots_as_shapes_and_the_quests_it_stands_for() {
	let script = GUIDE.to_string()
		+ r#"
		local r = {}
		for _, g in ipairs({ 1, 2, 7, 8, 9, 10 }) do
			nav.setWaypoint(wp(g))
			r[GOALS[g].t] = shape(stop())
		end
		nav.setWaypoint(wp(3, { x = 50, y = 40, area = 30, search = 40 }))
		r.wolves = shape(stop())
		-- A kill without a spawn area (one spot NPC): an ordinary objective stop.
		nav.setWaypoint(wp(11))
		r.plainKill = shape(stop())
		-- Hand-set targets: an explicit kind; a flight master, the inn and a dock they stand at.
		N.SetTarget(9000, 30, 30, "Deadmines", nil, "dungeon")
		r.dungeon = stop().kind
		N.SetTarget(9000, 10.5, 50, "West Hold")
		r.taxi = stop().kind
		local m, x, y = nav.mapPoint(-505, -700)
		N.SetTarget(m, x, y, "Inn")
		r.inn = stop().kind
		m, x, y = nav.mapPoint(-900, 10)
		N.SetTarget(m, x, y, "Docks")
		r.dock = stop().kind
		emit(r)
	"#;
	let out = run(&script, Opts::default());
	let plain = |kind: Value| {
		let mut v = json!({ "hold": false, "radius": false, "questID": false, "questIDs": false });
		v["kind"] = kind;
		v
	};
	assert_eq!(out["accept"], plain(json!("pickup")));
	assert_eq!(out["turnin"], plain(json!("turnin")));
	assert_eq!(out["train"], plain(json!("trainer")));
	assert_eq!(out["sethome"], plain(json!("innkeeper")));
	assert_eq!(out["getfp"], plain(json!("flightmaster")));
	assert_eq!(out["talk"], plain(json!(false)));
	assert_eq!(
		out["wolves"],
		json!({
			"kind": "objective", "hold": true, "radius": 38, "questID": 101, "questIDs": [101, 102],
			"shapes": [[9000, 0.5, 0.4, 38], [9000, 0.55, 0.4, 28]],
		})
	);
	assert_eq!(out["plainKill"], plain(json!("objective")));
	assert_eq!(out["dungeon"], "dungeon");
	assert_eq!(out["taxi"], "flightmaster");
	assert_eq!(out["dock"], "boat");
	assert_eq!(out["inn"], "innkeeper");
}

#[test]
fn no_churn_the_same_stop_is_sent_once_whatever_re_announces_it_a_moved_target_goes_again() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		local first = sent()
		nav.setWaypoint(copy(FARLAND))
		N.Refresh()
		stub.advance(3)
		local again = sent()
		Polestar.Set("nav.arrowScale", 1.2)
		local settings = sent()
		local moved = copy(FARLAND)
		moved.x = 55
		nav.setWaypoint(moved)
		emit({ first = first, again = again, settings = settings, moved = sent() })
	"#,
		Opts::default(),
	);
	assert_eq!(out, json!({ "first": 1, "again": 1, "settings": 1, "moved": 2 }));
}

#[test]
fn combat_nothing_is_sent_in_a_fight_and_a_stop_refused_because_one_began_goes_when_it_ends() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		local base = sent()
		stub.inCombat = true
		local moved = copy(FARLAND)
		moved.x = 60
		nav.setWaypoint(moved)
		local inFight = sent() - base
		local arrow = arrowShown()
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		local after = { sent() - base, r4(stop().x) }
		-- The call itself meets the fight's first moment: refused, then sent after it.
		spf.combatOnce = true
		local again = copy(FARLAND)
		again.x = 65
		nav.setWaypoint(again)
		local refused = { sent() - base, N.HandedOff() }
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ inFight = inFight, arrow = arrow, after = after, refused = refused, retried = { sent() - base, r4(stop().x), spf.owner } })
	"#,
		Opts::default(),
	);
	assert_eq!(out["inFight"], 0, "no call in combat");
	assert_eq!(out["arrow"], false, "and Polestar's arrow stays out");
	assert_eq!(out["after"], json!([1, 0.6]));
	assert_eq!(out["refused"], json!([2, true]), "refused in combat: still handed off, waiting");
	assert_eq!(out["retried"], json!([3, 0.65, "Polestar"]));
}

#[test]
fn no_target_the_journey_is_cancelled() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		nav.setWaypoint(nil)
		emit({ cancels = spf.cancels(), owner = spf.owner or false, ended = spf.ended.Polestar })
	"#,
		Opts::default(),
	);
	assert_eq!(out, json!({ "cancels": 1, "owner": false, "ended": "cancelled" }));
}

#[test]
fn the_player_s_clear_another_addon_s_journey_and_an_arrival_stand_until_polestar_s_target_changes() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		local base = sent()
		local r = {}
		spf.clear()
		stub.runTimers()
		nav.setWaypoint(copy(FARLAND))
		stub.advance(3)
		r.cleared = { sent() - base, spf.owner or false }
		local moved = copy(FARLAND)
		moved.x = 70
		nav.setWaypoint(moved)
		r.changed = { sent() - base, spf.owner }
		spf.replace("Questie")
		stub.runTimers()
		stub.advance(3)
		r.replaced = { sent() - base, spf.owner }
		-- Gone, it is not cancelled either: that journey is someone else's.
		nav.setWaypoint(nil)
		r.cancels = spf.cancels()
		moved = copy(FARLAND)
		moved.x = 75
		nav.setWaypoint(moved)
		spf.arrive()
		stub.runTimers()
		stub.advance(3)
		r.arrived = { sent() - base, spf.owner or false }
		emit(r)
	"#,
		Opts::default(),
	);
	assert_eq!(out["cleared"], json!([0, false]), "cleared: the same target is not sent again");
	assert_eq!(out["changed"], json!([1, "Polestar"]), "a new target is");
	assert_eq!(out["replaced"], json!([1, "Questie"]));
	assert_eq!(out["cancels"], 0);
	assert_eq!(out["arrived"], json!([2, false]));
}

#[test]
fn without_subscribe_minor_0_the_end_is_polled_on_nav_s_tick() {
	let spf = spf_minor0();
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		spf.clear()
		stub.advance(1.5)
		nav.setWaypoint(nil)
		emit({ cancels = spf.cancels(), subscribed = #spf.subs })
	"#,
		Opts { spf: Some(&spf), ..Default::default() },
	);
	assert_eq!(out, json!({ "cancels": 0, "subscribed": 0 }));
}

#[test]
fn a_corpse_run_is_never_sent_alive_again_the_same_target_is_not_sent_twice() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		local base, cancels = sent(), spf.cancels()
		stub.dead = true
		stub.fire("PLAYER_DEAD")
		N.SetTarget(9000, 20, 20, "Your corpse")
		N.SetTarget(9000, 22, 20, "Spirit Healer")
		local dead = { sent() - base, spf.cancels() - cancels, arrowShown() }
		stub.dead = false
		N.ReleaseTarget()
		stub.fire("PLAYER_UNGHOST")
		local alive = { sent() - base, spf.cancels() - cancels, N.GetTarget().label }
		local moved = copy(FARLAND)
		moved.x = 70
		nav.setWaypoint(moved)
		emit({ dead = dead, alive = alive, after = sent() - base })
	"#,
		Opts::default(),
	);
	assert_eq!(out["dead"], json!([0, 0, false]), "no hand-off call while dead, and no Polestar arrow");
	assert_eq!(out["alive"], json!([0, 0, "Farland camp"]));
	assert_eq!(out["after"], 1);
}

#[test]
fn refused_journeys_off_in_shortest_path_forever_polestar_guides_that_target_itself_and_hands_back_once_a_stop_is_taken() {
	let out = run(
		r#"
		spf.journeys = false
		nav.setWaypoint(copy(FARLAND))
		local off = { N.HandedOff(), arrowShown(), legs(), sent() }
		stub.advance(2)
		off[5] = sent()
		spf.journeys = true
		stub.fire("ZONE_CHANGED_NEW_AREA")
		local back = { N.HandedOff(), sent(), legs(), spf.owner }
		stub.advance(0.3)
		back[5] = arrowShown()
		emit({ off = off, back = back })
	"#,
		Opts::default(),
	);
	assert_eq!(out["off"], json!([false, true, 3, 1, 1]), "Polestar guides; the refused stop is not offered on every tick");
	assert_eq!(out["back"], json!([true, 2, 0, "Polestar", false]));
}

#[test]
fn no_way_there_235_a_stop_it_took_but_guides_nothing_to_is_guided_by_polestar_itself_until_it_guides_again() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		local before = { N.HandedOff(), arrowShown() }
		spf.noWay()
		stub.runTimers()
		stub.advance(0.3)
		local noWay = { N.HandedOff(), arrowShown(), legs(), sent(), spf.owner, spf.cancels() }
		-- Its guidance on again (its tracker's header): Polestar steps aside.
		spf.guide()
		stub.runTimers()
		stub.advance(0.3)
		local back = { N.HandedOff(), arrowShown(), legs(), sent() }
		-- No way again, and the player clears that journey: Polestar goes on guiding.
		spf.noWay()
		stub.runTimers()
		spf.clear()
		stub.runTimers()
		stub.advance(3)
		local cleared = { N.HandedOff(), arrowShown(), sent() }
		-- The next target goes and is taken: handed off again.
		local moved = copy(FARLAND)
		moved.x = 60
		nav.setWaypoint(moved)
		stub.advance(0.3)
		local taken = { N.HandedOff(), arrowShown(), sent() }
		-- No way, then another addon's journey replaces it: that one guides.
		spf.noWay()
		stub.runTimers()
		spf.replace("Questie")
		stub.runTimers()
		stub.advance(0.3)
		local replaced = { N.HandedOff(), arrowShown(), spf.owner }
		emit({ before = before, noWay = noWay, back = back, cleared = cleared, taken = taken, replaced = replaced })
	"#,
		Opts::default(),
	);
	assert_eq!(out["before"], json!([true, false]));
	assert_eq!(out["noWay"], json!([false, true, 3, 1, "Polestar", 0]), "Polestar guides; its journey is left in place, not resent");
	assert_eq!(out["back"], json!([true, false, 0, 1]));
	assert_eq!(out["cleared"], json!([false, true, 1]), "clearing its unguided journey leaves Polestar guiding");
	assert_eq!(out["taken"], json!([true, false, 2]));
	assert_eq!(out["replaced"], json!([true, false, "Questie"]));
}

#[test]
fn no_way_there_without_subscribe_minor_0_found_on_nav_s_tick() {
	let spf = spf_minor0();
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		spf.noWay()
		stub.advance(1.5)
		emit({ N.HandedOff(), arrowShown() })
	"#,
		Opts { spf: Some(&spf), ..Default::default() },
	);
	assert_eq!(out, json!([false, true]));
}

#[test]
fn dead_or_a_ghost_its_guiding_nothing_is_its_corpse_run_s_business_polestar_s_arrow_stays_out() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		stub.dead = true
		stub.fire("PLAYER_DEAD")
		spf.noWay()
		stub.runTimers()
		stub.advance(0.3)
		local dead = { N.HandedOff(), arrowShown() }
		stub.dead = false
		stub.fire("PLAYER_UNGHOST")
		spf.guide()
		stub.runTimers()
		stub.advance(0.3)
		emit({ dead = dead, alive = { N.HandedOff(), arrowShown(), sent() } })
	"#,
		Opts::default(),
	);
	assert_eq!(out["dead"], json!([true, false]));
	assert_eq!(out["alive"], json!([true, false, 1]));
}

#[test]
fn no_way_the_journey_cleared_then_the_player_starts_one_in_it_polestar_steps_aside_again() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		spf.noWay()
		stub.runTimers()
		spf.clear()
		stub.runTimers()
		stub.advance(0.3)
		local cleared = { N.HandedOff(), arrowShown() }
		spf.replace("player")
		stub.runTimers()
		stub.advance(0.3)
		emit({ cleared = cleared, player = { N.HandedOff(), arrowShown(), sent() } })
	"#,
		Opts::default(),
	);
	assert_eq!(out["cleared"], json!([false, true]));
	assert_eq!(out["player"], json!([true, false, 1]), "one arrow: its journey guides, Polestar's steps aside");
}

#[test]
fn no_way_then_a_death_its_corpse_run_guides_and_polestar_s_arrow_steps_aside_alive_with_still_no_way_polestar_guides() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		spf.noWay()
		stub.runTimers()
		local noWay = { N.HandedOff(), arrowShown() }
		stub.dead = true
		stub.fire("PLAYER_DEAD")
		N.SetTarget(9000, 20, 20, "Your corpse")
		spf.corpseRun(true)
		stub.runTimers()
		stub.advance(0.3)
		local dead = { N.HandedOff(), arrowShown() }
		-- Back in the body: the corpse run ends; its journey to Polestar's stop resumes and still finds no way.
		stub.dead = false
		N.ReleaseTarget()
		spf.corpseRun(false)
		stub.fire("PLAYER_UNGHOST")
		stub.runTimers()
		stub.advance(0.3)
		emit({ noWay = noWay, dead = dead, alive = { N.HandedOff(), arrowShown(), N.GetTarget().label, sent() } })
	"#,
		Opts::default(),
	);
	assert_eq!(out["noWay"], json!([false, true]));
	assert_eq!(out["dead"], json!([true, false]), "one arrow: its corpse run");
	assert_eq!(out["alive"], json!([false, true, "Farland camp", 1]));
}

#[test]
fn off_by_default_235_with_it_installed_polestar_guides_and_sends_nothing_the_option_shows_off() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		local s = surfaces()
		s.handedOff = N.HandedOff()
		s.shown = option().needs()
		s.on = Polestar.Get("nav.spfHandoff")
		s.sent = sent()
		emit(s)
	"#,
		Opts { saved: FRESH, ..Default::default() },
	);
	assert_eq!(
		out,
		json!({
			"arrow": true, "route": 3, "lines": 3, "journey": true, "trail": false, "walk": true, "pack": true, "way": true, "shim": true,
			"handedOff": false, "shown": true, "on": false, "sent": 0,
		})
	);
}

#[test]
fn the_hand_off_off_polestar_guides_again_and_its_journey_is_cancelled_on_again_the_stop_goes_back() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		Polestar.Set("nav.spfHandoff", false)
		local off = surfaces()
		off.cancels = spf.cancels()
		off.owner = spf.owner or false
		Polestar.Set("nav.spfHandoff", true)
		local on = { N.HandedOff(), sent(), spf.owner, legs() }
		stub.advance(0.3)
		on[5] = arrowShown()
		-- Polestar_Nav loaded while it was off: still no search for a new target,
		-- even when its distance is asked (the target pin's tooltip).
		finds = 0
		local m, x, y = nav.mapPoint(-850, -300)
		nav.setWaypoint({ map = m, x = x, y = y, label = "Docks road", stepIndex = 1, goalIndex = 2, kind = "goto", r = 8 })
		N.GetDistance()
		stub.advance(3)
		on[6] = finds
		emit({ off = off, on = on })
	"#,
		Opts::default(),
	);
	assert_eq!(
		out["off"],
		json!({
			"arrow": true, "route": 3, "lines": 3, "journey": true, "trail": false, "walk": true, "pack": true, "way": true, "shim": true,
			"cancels": 1, "owner": false,
		})
	);
	assert_eq!(out["on"], json!([true, 2, "Polestar", 0, false, 0]));
}

// The guidance options that do nothing while it guides, by settings key.
const GREYED: [&str; 23] = [
	"nav.arrow",
	"nav.arrowEta",
	"nav.arrivalSound",
	"nav.travel",
	"nav.navRouting",
	"nav.routeLines",
	"nav.teleports",
	"nav.blizzardWaypoint",
	"nav.tomtom",
	"nav.useTomTomArrow",
	"nav.arrowStyle",
	"nav.arrowScale",
	"nav.arrowAlpha",
	"nav.trailDots",
	"nav.mapPlan",
	"nav.routeStyle",
	"nav.answerTomTom",
	"nav.alerts",
	"nav.alertBanner",
	"nav.alertSound",
	"nav.alertFlash",
	"nav.castPrompt",
	"nav.journeySteps",
];

const OPTIONS: &str = r#"
Polestar.Set("nav.routeLines", false) -- trailDots' own condition out of the way
Polestar.Set("nav.tomtom", true)
-- The options window's own widgets, every page that holds a nav option.
local O, W = Polestar.UI.Options, Polestar.Widgets
local function controls()
	local out = {}
	Polestar.UI.ShowOptions("guide")
	for _, at in ipairs({ { "guide", "Arrow & routes" }, { "appearance", "Arrow" }, { "map", "Guide & quests" }, { "integrations" } }) do
		O.Select(at[1], at[2])
		for key, w in pairs(O.Controls(at[1], at[2])) do out[key] = w end
	end
	return out
end
local function greyed(keys)
	local cs, r = controls(), {}
	for _, k in ipairs(keys) do
		local w = cs[k]
		r[k] = w and not W.Enabled(w) or (not w and "missing")
	end
	return r
end
local function said(text)
	for _, m in ipairs(stub.messages) do if m:find(text, 1, true) then return true end end
	return false
end
local function command(line)
	stub.messages = {}
	SlashCmdList.POLESTAR(line)
	return said("Shortest Path Forever is guiding.")
end
"#;

fn lua_list(keys: &[&str]) -> String {
	format!("{{ {} }}", keys.iter().map(|k| serde_json::to_string(k).unwrap()).collect::<Vec<_>>().join(", "))
}

#[test]
fn while_it_guides_the_options_that_do_nothing_there_are_greyed_out_and_say_why_without_it_they_are_not() {
	let script = OPTIONS.to_string()
		+ &r#"
		nav.setWaypoint(copy(FARLAND))
		local cs = controls()
		emit({ greyed = greyed(${GREYED}), kept = greyed({ "nav.distanceUnit", "nav.shareTransit", "nav.worldPins", "nav.followTomTom", "nav.nearbyMenu" }),
			why = cs["nav.mapPlan"].psControl.help:find("Greyed out while Shortest Path Forever guides", 1, true) ~= nil,
			whyNoHelp = cs["nav.arrowScale"].psControl.help ~= nil })"#
			.replace("${GREYED}", &lua_list(&GREYED));
	let files: Vec<&str> = FILES.iter().copied().filter(|f| !f.starts_with("UI/")).chain(["UI/UI.xml"]).collect();
	let on = run(&script, Opts { files: files.clone(), ..Default::default() });
	let without = run(&script, Opts { spf: None, files, ..Default::default() });
	let all = |v: bool| Value::Object(GREYED.iter().map(|k| (k.to_string(), json!(v))).collect());
	assert_eq!(on["greyed"], all(true));
	assert_eq!(
		on["kept"],
		json!({ "nav.distanceUnit": false, "nav.shareTransit": false, "nav.worldPins": false, "nav.followTomTom": true, "nav.nearbyMenu": false }),
		"options that still act stay (Follow TomTom is greyed only by its own condition: no TomTom here)"
	);
	assert_eq!(on["why"], true);
	assert_eq!(on["whyNoHelp"], true);
	assert_eq!(without["greyed"], all(false));
	assert_eq!(without["kept"], on["kept"]);
}

#[test]
fn while_it_guides_commands_that_would_show_polestar_s_arrow_or_route_say_why_in_one_line_instead() {
	let script = OPTIONS.to_string()
		+ r#"
		nav.setWaypoint(copy(FARLAND))
		Polestar.Set("nav.arrow", false)
		local r = {}
		r.show = command("arrow show")
		r.showSet = Polestar.Get("nav.arrow")
		r.toggle = command("arrow")
		r.toggleSet = Polestar.Get("nav.arrow")
		r.route = command("route")
		r.skip = command("skipleg")
		r.hide = command("arrow hide")
		emit(r)"#;
	let on = run(&script, Opts::default());
	let without = run(&script, Opts { spf: None, ..Default::default() });
	assert_eq!(on, json!({ "show": true, "showSet": false, "toggle": true, "toggleSet": false, "route": true, "skip": true, "hide": false }));
	assert_eq!(without, json!({ "show": false, "showSet": true, "toggle": false, "toggleSet": false, "route": false, "skip": false, "hide": false }));
}

#[test]
fn no_arrival_chime_from_polestar_while_it_guides_its_own_arrival_says_so_without_it_the_chime_plays() {
	let script = r#"
		local m, x, y = nav.mapPoint(-850, 5)
		stub.sounds = {}
		nav.setWaypoint({ map = m, x = x, y = y, label = "Here", stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 })
		N.GetDistance() -- the target pin's tooltip asks, the arrow too when it shows
		emit(#stub.sounds)"#;
	assert_eq!(json!(run_all(script, Opts::default())), json!([0]));
	assert_eq!(json!(run_all(script, Opts { spf: None, ..Default::default() })), json!([1]));
}

// Pathing v2: Polestar guides by default with Shortest Path Forever installed; handing off is an option. While a
// journey of Shortest Path Forever's own runs (one the player started there, or another addon's), Polestar steps
// aside as it does when handing off, so the two never guide at once.

#[test]
fn a_journey_the_player_starts_in_shortest_path_forever_polestar_steps_aside_until_it_ends_and_never_asks_in_combat() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		local r = {}
		r.before = { N.HandedOff(), arrowShown(), legs() }
		-- The player's own journey (his owner, not Polestar's).
		spf.replace("ShortestPathForever")
		stub.runTimers()
		local s = surfaces()
		r.during = { N.HandedOff(), s.arrow, s.route, s.lines, s.journey }
		spf.arrive()
		stub.runTimers()
		s = surfaces()
		r.after = { N.HandedOff(), s.arrow, s.route, s.lines, s.journey }
		-- In combat his API is never called: the news waits for combat's end.
		stub.inCombat = true
		local reads = spf.reads
		spf.replace("ShortestPathForever")
		stub.runTimers()
		stub.advance(2)
		r.fight = { spf.reads - reads, N.HandedOff() }
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		r.ended = { N.HandedOff() }
		r.sent = sent()
		emit(r)
	"#,
		Opts { saved: FRESH, ..Default::default() },
	);
	assert_eq!(out["before"], json!([false, true, 3]), "Polestar guides");
	assert_eq!(out["during"], json!([true, false, 0, 0, false]), "it steps aside while his journey runs");
	assert_eq!(out["after"], json!([false, true, 3, 3, true]), "and guides again when it ends");
	assert_eq!(out["fight"], json!([0, false]), "no call in combat");
	assert_eq!(out["ended"], json!([true]), "after combat it steps aside");
	assert_eq!(out["sent"], 0, "with the option off Polestar never sends");
}

#[test]
fn without_subscribe_minor_0_his_journey_is_noticed_on_nav_s_tick() {
	let spf = spf_minor0();
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		spf.replace("ShortestPathForever")
		stub.advance(1.5)
		local during = N.HandedOff()
		spf.arrive()
		stub.advance(1.5)
		emit({ during, N.HandedOff() })
	"#,
		Opts { saved: FRESH, spf: Some(&spf), ..Default::default() },
	);
	assert_eq!(out, json!([true, false]));
}

// A journey of Polestar's left running in Shortest Path Forever from 0.2.4, which handed off by default (Ruling
// 27 of pathing v2).
fn leftover() -> String {
	SPF.to_string()
		+ r#"
spf.owner, spf.stops, spf.index, spf.guided = "Polestar", { { map = 9000, x = 0.5, y = 0.5 } }, 1, true
"#
}

#[test]
fn a_polestar_journey_left_over_from_0_2_4_is_cancelled_once_at_login_with_the_option_off_after_combat_in_a_fight_never_with_it_on() {
	let script = r#"
		nav.setWaypoint(copy(FARLAND))
		local r = { cancels = spf.cancels(), owner = spf.owner or false }
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.runTimers()
		r.after = spf.cancels()
		r.guides = arrowShown() or (stub.advance(0.3) or arrowShown())
		r.handedOff = N.HandedOff()
		emit(r)"#;
	let left = leftover();
	let off = run(script, Opts { saved: FRESH, spf: Some(&left), ..Default::default() });
	assert_eq!(off, json!({ "cancels": 1, "owner": false, "after": 1, "guides": true, "handedOff": false }), "option off: one Cancel, Polestar guides");
	let fight_spf = format!("{left}\nstub.inCombat = true\n");
	let fight = run(script, Opts { saved: FRESH, spf: Some(&fight_spf), ..Default::default() });
	assert_eq!(fight["cancels"], 0, "in combat at login: nothing called");
	assert_eq!(fight["after"], 1, "the cancel once combat ends");
	assert_eq!(fight["handedOff"], false);
	let on = run(script, Opts { spf: Some(&left), ..Default::default() });
	assert_eq!(on["cancels"], 0, "option on: the hand-off keeps it");
	assert_eq!(on["after"], 0);
}

// Every call to his API made in combat, by name (spf.fight).
const COUNT_FIGHT: &str = r#"
spf.fight = {}
for name, fn in pairs(ShortestPathForever.API) do
	if type(fn) == "function" then
		ShortestPathForever.API[name] = function(...)
			if InCombatLockdown() then table.insert(spf.fight, name) end
			return fn(...)
		end
	end
end
"#;

#[test]
fn a_reload_in_combat_nothing_of_his_api_is_called_subscribe_included_and_an_option_toggled_in_the_fight_waits_for_its_end() {
	let spf = format!("{SPF}{COUNT_FIGHT}\nstub.inCombat = true\n");
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		local r = {}
		Polestar.Set("nav.spfHandoff", true)
		Polestar.Set("nav.spfHandoff", false)
		stub.runTimers()
		r.fight = table.concat(spf.fight, ",")
		r.subs = #spf.subs
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.runTimers()
		r.after = #spf.subs
		emit(r)"#,
		Opts { saved: FRESH, spf: Some(&spf), ..Default::default() },
	);
	assert_eq!(out, json!({ "fight": "", "subs": 0, "after": 1 }), "subscribed once combat ends");
}

#[test]
fn the_hand_off_turned_off_in_a_fight_polestar_stays_stepped_aside_while_its_journey_runs_there_cancelled_when_the_fight_ends_never_in_it_then_polestar_guides() {
	let spf = format!("{SPF}{COUNT_FIGHT}");
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		local r = { owner = spf.owner or false }
		stub.inCombat = true
		Polestar.Set("nav.spfHandoff", false)
		local m, x, y = nav.mapPoint(-850, -300)
		nav.setWaypoint({ map = m, x = x, y = y, label = "Docks road", stepIndex = 1, goalIndex = 2, kind = "goto", r = 8 })
		stub.runTimers()
		stub.advance(0.3)
		r.inFight = { N.HandedOff(), arrowShown() }
		r.fight = table.concat(spf.fight, ",")
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.advance(0.3)
		r.cancels, r.ownerAfter = spf.cancels(), spf.owner or false
		r.after = { N.HandedOff(), arrowShown() }
		emit(r)"#,
		Opts { spf: Some(&spf), ..Default::default() },
	);
	assert_eq!(out, json!({ "owner": "Polestar", "inFight": [true, false], "fight": "", "cancels": 1, "ownerAfter": false, "after": [false, true] }));
}

#[test]
fn no_way_there_then_the_hand_off_turned_off_in_a_fight_polestar_s_arrow_guiding_the_unguided_journey_keeps_guiding_through_it() {
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		spf.noWay()
		stub.runTimers()
		stub.advance(0.3)
		local r = { before = { N.HandedOff(), arrowShown() } }
		stub.inCombat = true
		Polestar.Set("nav.spfHandoff", false)
		stub.runTimers()
		stub.advance(0.3)
		r.inFight = { N.HandedOff(), arrowShown() }
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.advance(0.3)
		r.after = { N.HandedOff(), arrowShown() }
		emit(r)"#,
		Opts::default(),
	);
	assert_eq!(out["before"], json!([false, true]));
	assert_eq!(out["inFight"], json!([false, true]), "its journey guides nothing: Polestar does not step aside");
	assert_eq!(out["after"], json!([false, true]));
}

#[test]
fn a_reload_in_combat_with_a_0_2_4_journey_left_over_polestar_steps_aside_until_the_fight_ends_and_the_journey_is_cancelled_so_the_two_never_guide_at_once() {
	let spf = format!("{}{COUNT_FIGHT}\nstub.inCombat = true\n", leftover());
	let out = run(
		r#"
		nav.setWaypoint(copy(FARLAND))
		local r = {}
		stub.advance(1.5)
		r.fight = { N.HandedOff(), arrowShown(), spf.owner or false, table.concat(spf.fight, ",") }
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.advance(0.3)
		r.after = { N.HandedOff(), arrowShown(), spf.owner or false, spf.cancels() }
		emit(r)"#,
		Opts { saved: FRESH, spf: Some(&spf), ..Default::default() },
	);
	assert_eq!(out["fight"], json!([true, false, "Polestar", ""]), "in the fight: his leftover guides alone");
	assert_eq!(out["after"], json!([false, true, false, 1]), "after it: cancelled once, Polestar guides");
}
