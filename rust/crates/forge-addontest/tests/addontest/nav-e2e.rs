//! End to end: the arrow on Shortest Path Forever's real walking engine and Polestar's packed maps (maps 0 and 1,
//! `forge nav pack`). The real Polestar (with TravelData, the guides' Era map frames, and the local crossings when
//! built) loads the real Polestar_Nav on demand at login, its maps decoded by tests/lua/stub_encoding.lua the way
//! the client decodes them; the stub world's maps are data/forever/map-frames.json's, and UnitPosition answers from
//! the same place (x north, y west, z, the instance map id). A character in Goldshire is guided to the Fargodeep
//! Mine and into the Jasperlode Mine; the engine's path must come back through Nav/Walk.lua, Nav/Travel.lua and Nav.Sample to the arrow. Every
//! other arrow test fakes the engine (nav-spf.rs) and the other real-engine tests call it directly (nav-maps.rs): a
//! frame mismatch between the two (north/west swapped, a uiMapID for the instance id, a dropped height) passes those
//! and fails only here. Checks name their docs/NAV_QA.md rows. (Ported from tests/nav-e2e.test.js.)

use std::collections::{BTreeMap, HashMap};
use std::path::{Path, PathBuf};

use forge_addontest::locale::data_dir;
use forge_addontest::run::{addons_dir, toc_files};
use forge_addontest::tmp::TempDir;
use forge_addontest::{emitted, lua_string, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use regex::Regex;
use serde_json::Value;

/// Why the scenario cannot run here, or None.
fn skip_reason() -> Option<String> {
	if let Some(why) = forge_addontest::locale::needs(&["map-frames.json", "zones.json"]) {
		return Some(why);
	}
	if !addons_dir().join("Polestar_Nav/Nav/Nav.xml").exists() {
		return Some("addon/Polestar_Nav has no walking maps (forge nav pack)".into());
	}
	if !addons_dir().join("Polestar_Guides/MapFrames.lua").exists() {
		return Some("addon/Polestar_Guides/MapFrames.lua not built (forge compile)".into());
	}
	None
}

macro_rules! skip_unless_ready {
	() => {
		if let Some(why) = skip_reason() {
			eprintln!("skipped: {why}");
			return;
		}
	};
}

fn json_file(name: &str) -> Value {
	let p = data_dir().join(name);
	serde_json::from_str(&std::fs::read_to_string(&p).unwrap_or_else(|e| panic!("{}: {e}", p.display()))).unwrap()
}

/// A number as JS prints it (no ".0" on an integer).
fn js(v: f64) -> String {
	let s = format!("{v:?}");
	s.strip_suffix(".0").map(str::to_string).unwrap_or(s)
}

fn f(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}

fn strs(v: &Value) -> Vec<String> {
	v.as_array().map(|a| a.iter().map(|x| x.as_str().unwrap_or("").to_string()).collect()).unwrap_or_default()
}

// The stub world's maps: the live (Forever) frame where it differs, else Era's.
fn maps_lua() -> String {
	let frames = json_file("map-frames.json");
	let zones = json_file("zones.json");
	let mut all: BTreeMap<u64, Value> = BTreeMap::new();
	for set in ["era", "forever"] {
		for (id, fr) in frames[set].as_object().into_iter().flatten() {
			if let Ok(id) = id.parse() {
				all.insert(id, fr.clone());
			}
		}
	}
	all.iter()
		.map(|(id, fr)| {
			let z = &zones[id.to_string()];
			let name = z["name"].as_str().unwrap_or("");
			let parent = z["parent"].as_i64().filter(|p| *p != 0).unwrap_or(0);
			let ty = z["type"].as_i64().filter(|t| *t != 0).unwrap_or(3);
			format!(
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {}, parent = {parent}, mapType = {ty} }})",
				serde_json::to_string(name).unwrap(),
				js(f(&fr["c"])),
				js(f(&fr["left"])),
				js(f(&fr["right"])),
				js(f(&fr["top"])),
				js(f(&fr["bottom"]))
			)
		})
		.collect::<Vec<_>>()
		.join("\n")
}

/// Appended to Polestar_Nav's files: keeps its namespace, for the snapped-node check.
fn ns_file() -> (TempDir, PathBuf) {
	let tmp = TempDir::new("polestar-nav-e2e-");
	let p = tmp.path().join("keep-ns.lua");
	std::fs::write(&p, "local _, ns = ...\nstub.navNs = ns\n").unwrap();
	(tmp, p)
}

fn nav_files(ns: &Path) -> Vec<PathBuf> {
	let mut files = toc_files("Polestar_Nav").unwrap();
	files.push(ns.to_path_buf());
	files
}

fn before(files: &[PathBuf]) -> String {
	let list = files.iter().map(|p| lua_string(&p.to_string_lossy())).collect::<Vec<_>>().join(", ");
	format!(
		r#"local w = stub.world
stub.clientBuild = "70532" -- same client as the packaged navigation fixtures
{}
stub.packs.Polestar_Nav = {{ {list} }}
-- UnitPosition: the world position the live map frame gives, z as set, the instance map id.
function UnitPosition(unit)
	if unit ~= "player" or not w.map or w.inInstance then return nil end
	local c, pos = C_Map.GetWorldPosFromMapPos(w.map, CreateVector2D(w.x / 100, w.y / 100))
	if not c then return nil end
	return pos.x, pos.y, w.z, c
end"#,
		maps_lua()
	)
}

const PRELUDE: &str = r#"
local w, N, C = stub.world, Polestar.Nav, Polestar.Compat
local E = Polestar_NavEngine
local floor, sqrt = math.floor, math.sqrt
local function r1(v) return v and floor(v * 10 + 0.5) / 10 end
-- Every search the arrow asks for, with what it was asked (style: its opts.style; opts: the whole) and what came back.
local finds = {}
if E then -- nil when Polestar_Nav was not loaded (routing off)
	local realFind = E.Find
	E.Find = function(map, from, to, callback, water)
		local rec = { map = map, from = { from.x, from.y, from.z }, to = { to.x, to.y, to.z }, at = GetTime(), combat = InCombatLockdown() and true or false,
			style = type(water) == "table" and water.style or nil, opts = type(water) == "table" and water or nil }
		finds[#finds + 1] = rec
		return realFind(map, from, to, function(points, cost, job)
			rec.points, rec.cost, rec.done = points, cost, true
			callback(points, cost, job)
		end, water)
	end
end
-- Stand at world (wx, wy) on map, through the live frame, as the client reports it.
local function place(map, wx, wy, z)
	local c = C_Map.GetWorldPosFromMapPos(map, CreateVector2D(0.5, 0.5))
	local x, y = C.WorldToMap(c, wx, wy, map)
	w.moveTo(map, x, y)
	w.z = z
end
-- The arrow's sample: state, yards shown, the world point it aims at, measured along a path.
local function aim()
	local state, dist, _, dn, dw, measured = N.Sample()
	local _, px, py = C.GetPlayerWorldPosition()
	if not dn then return { state = state } end
	return { state = state, dist = dist, x = px + dn, y = py + dw, measured = measured == true }
end
-- The index of path point (x, y) in a search's answer, or nil.
local function indexOf(rec, x, y)
	for i, p in ipairs(rec and rec.points or {}) do
		if math.abs(p.x - x) < 1e-6 and math.abs(p.y - y) < 1e-6 then return i end
	end
end
-- Where on the path the arrow aims (Nav/Follow.lua: a point up to 35 yd from
-- the player along it, between points, a road's zigzag smoothed): the
-- fractional point index (k - 1 + t on segment k - 1 -> k) of the nearest spot
-- on the path, and the yards from it; nil without a path.
local function alongOf(rec, x, y)
	local pts = rec and rec.points or {}
	local best, at = math.huge, nil
	for k = 2, #pts do
		local a, b = pts[k - 1], pts[k]
		local dx, dy = b.x - a.x, b.y - a.y
		local l2 = dx * dx + dy * dy
		local t = l2 > 0 and math.max(0, math.min(1, ((x - a.x) * dx + (y - a.y) * dy) / l2)) or 0
		local d = sqrt((a.x + dx * t - x) ^ 2 + (a.y + dy * t - y) ^ 2)
		if d < best then best, at = d, k - 1 + t end
	end
	return at, best
end
local function length(points)
	local len = 0
	for i = 2, #points do len = len + sqrt((points[i].x - points[i - 1].x) ^ 2 + (points[i].y - points[i - 1].y) ^ 2) end
	return len
end
local function dist(ax, ay, bx, by) return sqrt((ax - bx) ^ 2 + (ay - by) ^ 2) end
-- Nearest distance from (x, y) to the polyline.
local function offPath(points, x, y)
	local best = math.huge
	for i = 2, #points do
		local a, b = points[i - 1], points[i]
		local dx, dy = b.x - a.x, b.y - a.y
		local l2 = dx * dx + dy * dy
		local t = l2 > 0 and math.max(0, math.min(1, ((x - a.x) * dx + (y - a.y) * dy) / l2)) or 0
		best = math.min(best, dist(a.x + dx * t, a.y + dy * t, x, y))
	end
	return best
end
local GOLDSHIRE = { -9444.062, 77.667, 57.353 } -- UnitPosition in front of the Lion's Pride Inn (nav-maps.rs)
local LOWER_MOUTH = { -9791.249, 164.438, 27.373 } -- the Fargodeep Mine's lower mouth, likewise
-- Goldshire, guided to the Fargodeep Mine (Elwynn, Era 39.5,82.4); frames run until the path is in.
local function guide(map, x, y, label)
	N.SetTarget(map or 1429, x or 39.5, y or 82.4, label or "Fargodeep Mine", "e")
	aim()
	local n = 0
	while not (finds[#finds] and finds[#finds].done) and n < 100 do stub.advance(0.05); n = n + 1 end
	return finds[#finds]
end
"#;

fn polestar_addons() -> Vec<Addon> {
	vec![Addon::name("Polestar"), Addon::files("Polestar_Guides", &["MapFrames.lua"])]
}

fn run_files(files: &[PathBuf], script: &str, shipped: bool, saved: Vec<(String, String)>) -> Value {
	let mut addons = polestar_addons();
	if !shipped && addons_dir().join("Polestar_Travel/Polestar_Travel.toc").exists() {
		addons.push(Addon::name("Polestar_Travel"));
	}
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua", "stub_encoding.lua", "stub_packs.lua"], before: before(files), addons, saved, login: true, script: format!("{PRELUDE}\n{script}") })
		.remove(0);
	eprintln!("{out}");
	out
}

// Runs the scenario; its emitted record goes to stderr (the numbers behind each check).
// shipped: only what the release zip carries (no local Polestar_Travel crossing data).
fn run(script: &str, shipped: bool) -> Value {
	let (_tmp, ns) = ns_file();
	run_files(&nav_files(&ns), script, shipped, vec![])
}

#[test]
fn an_ironforge_waypoint_across_the_signpost_is_not_a_visit_from_the_pavement() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Alliance"; w.setLevel(23)
		local function visited(x,y,X,Y)
			N.ClearTarget()
			place(1455,x,y,502.2124)
			local mx,my=C.WorldToMap(0,X,Y,1455)
			assert(N.SetTarget(1455,mx,my,"Street waypoint",nil,"npc",502.2124))
			for _=1,60 do
				if aim().state=="arrived" then return true end
				stub.advance(.05)
			end
			return false
		end
		local x,y,X,Y=-4868.99474,-1108.271,-4864.69926,-1105.791
		emit({outward=visited(x,y,X,Y), inward=visited(X,Y,x,y),
			open=visited(-4870.13149,-1108.40404,-4866.73738,-1111.79816), atGoal=visited(X,Y,X,Y)})"#,
		true,
	);
	assert_eq!(out, serde_json::json!({"outward":false,"inward":false,"open":true,"atGoal":true}));
}

// The arrow eases its turn onto the Ironforge trainer ramp as every other turn (Fitz, 0.4.2.1: 0.4.1.1's manners;
// 0.4.2 snapped it at a sharp turn beside a mapped wall): along the whole approach the shown bearing never moves more
// than MAX_TURN (3.5 rad/s) allows in a frame, it trails the walk's bearing somewhere on the way (it eased, it did not
// jump), and standing a second at the end it has settled on the ramp. Since #3513 the aim looks past the next point,
// so the walk's bearing itself turns gradually and the shown one keeps up with it closely.
#[test]
fn the_displayed_arrow_eases_onto_the_ironforge_trainer_ramp_and_settles_on_it() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction="Alliance"; w.setLevel(23); w.facing=2.34
		local x,y=-4821.1,-1152.4
		place(1455,x,y,502.3)
		local mx,my=C.WorldToMap(0,-4876.6,-1149.2,1455)
		assert(N.SetTarget(1455,mx,my,"Trainer",nil,"npc",512.5))
		for _=1,500 do aim();stub.advance(.05) end
		local function gap(a,b) return math.abs(math.atan2(math.sin(a-b), math.cos(a-b))) end
		local prev, step, lag = nil, 0, 0
		-- Approach on the pavement and walk on down the ramp past the bend.
		for _,p in ipairs({{-4822.9167,-1156.25},{-4827.0833,-1160.4167},{-4835.4167,-1160.4167},{-4860.5958,-1135.2313}}) do
			local ax,ay=x,y; local n=math.ceil(dist(ax,ay,p[1],p[2])/.32)
			for i=1,n do
				x,y=ax+(p[1]-ax)*i/n,ay+(p[2]-ay)*i/n
				place(1455,x,y,502.18);stub.advance(.05)
				local cur, goal = N.arrow.GetTurn()
				if prev then step = math.max(step, gap(cur, prev)) end
				prev, lag = cur, math.max(lag, gap(cur, goal))
			end
		end
		local state,_,a,_,_,measured=N.Sample()
		for _=1,20 do stub.advance(.05) end
		local _,_,a2=N.Sample()
		local settled=N.arrow.GetAngle()+w.facing
		emit({travel=state=="travel" and measured==true, requestedWest=math.sin(a+w.facing), step=step, lag=lag,
			gap=gap(settled, a2+w.facing)})"#,
		true,
	);
	assert_eq!(out["travel"], true);
	assert!(f(&out["requestedWest"]) < -0.5, "the walk has turned onto the ramp");
	assert!(f(&out["step"]) <= 3.5 * 0.05 + 1e-6, "the shown bearing never snaps (at most MAX_TURN a frame): {out}");
	assert!(f(&out["lag"]) > 0.05, "it trails the walk's bearing on the way: eased, not jumped: {out}");
	assert!(f(&out["gap"]) < 0.05, "a second later the arrow has settled on the ramp: {out}");
}

// The arrow aims past the aisle's first turn (13 yd on: 0.4.2 held it there, #3509) but never through the solid
// corner (0.4.1.1 aimed straight at the far end): the farthest point along the walk the player can walk to straight.
// With the client's height and with Forever's 0, flagged indoors or not.
#[test]
fn guidance_takes_the_open_aisle_at_the_ironforge_roost_with_or_without_an_indoor_flag() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Alliance"; w.setLevel(23)
		local a, b = {-4856.25,-1131.25,502.20826}, {-4831.25,-1156.25,502.20923}
		local function departure(p, q, height)
			N.ClearTarget()
			place(1455, p[1], p[2], height and p[3] or 0)
			local mx, my = C.WorldToMap(0, q[1], q[2], 1455)
			assert(N.SetTarget(1455, mx, my, "Roost", nil, "npc", q[3]))
			for _ = 1, 500 do aim(); stub.advance(.05) end
			local h = aim()
			assert(h.state == "travel" and h.measured and dist(p[1], p[2], h.x, h.y) > 2)
			return { heading = math.deg(math.atan2(h.y-p[2], h.x-p[1])), ahead = dist(p[1], p[2], h.x, h.y) }
		end
		local function both(indoors, height)
			w.indoors = indoors
			return {outward = departure(a, b, height), inward = departure(b, a, height)}
		end
		emit({indoors = both(true, true), outdoors = both(false, true), indoorsZ0 = both(true, false), outdoorsZ0 = both(false, false)})"#,
		true,
	);
	// A body swept two yards from these two spots meets solid geometry in these
	// sectors. Leave a margin at the measured edges; do not pin a particular path.
	for mode in ["indoors", "outdoors", "indoorsZ0", "outdoorsZ0"] {
		let outward = f(&out[mode]["outward"]["heading"]);
		let inward = f(&out[mode]["inward"]["heading"]);
		assert!(!(-52.0..=113.0).contains(&outward), "{mode}: outward heading {outward} cuts the solid corner");
		assert!(!(4.0..=144.0).contains(&inward), "{mode}: return heading {inward} cuts the solid corner");
		for way in ["outward", "inward"] {
			let ahead = f(&out[mode][way]["ahead"]);
			assert!(ahead > 15.0, "{mode}: the {way} aim lies past the aisle's first turn 13 yd on, not on it ({ahead:.1} yd)");
		}
	}
}

#[test]
fn stonefire_does_not_send_a_player_on_the_vendor_floor_back_out_for_an_incomplete_walk() {
	skip_unless_ready!();
	let result = run(
		r#"
		w.faction = "Alliance"; w.setLevel(23)
		local gx, gy, gz = -4842.3, -861, 502
		local mx, my = C.WorldToMap(0, gx, gy, 1455)
		local function from(x, y, z, indoors)
			N.ClearTarget()
			w.indoors = indoors
			place(1455, x, y, z)
			local before = #finds
			assert(N.SetTarget(1455, mx, my, "Gwenna", nil, "npc", gz))
			for i = 1, 500 do aim(); stub.advance(.05) end
			local hud = aim()
			local job = finds[#finds]
			assert(#finds > before and job.done)
			local pts = job.points
			local tip = pts and pts[#pts]
			return { state = hud.state, bearing = hud.x ~= nil, caption = N.noWalk or false,
				closer = tip and dist(tip.x, tip.y, gx, gy) < dist(x, y, gx, gy) or false }
		end
		emit({ street = from(-4821.1, -1152.4, 502.3, false),
			door = from(-4850.1763, -875.7260, 501.9138, true) })"#,
		true,
	);
	let street = &result["street"];
	assert_eq!(street["state"], "travel");
	assert!(street["bearing"] == true && street["closer"] == true, "the mapped approach from the flightmaster still guides");
	let door = &result["door"];
	assert!(
		(door["state"] == "travel" && door["bearing"] == true && door["closer"] == true)
			// #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
			|| (door["state"] == "travel" && door["bearing"] == true && door["caption"] == "unmapped"),
		"guide a better approach or withhold the arrow; don't leave the vendor's floor for a dead end farther away: {door}"
	);
}

#[test]
fn an_ironforge_trainer_on_another_floor_needs_more_than_a_walk_to_the_spot_under_her() {
	skip_unless_ready!();
	let result = run(
		r#"
		w.faction = "Alliance"; w.setLevel(23); w.indoors = true
		local gx, gy, gz = -4876.6, -1149.2, 512.5
		local mx, my = C.WorldToMap(0, gx, gy, 1455)
		local function from(x, y, z)
			N.ClearTarget()
			place(1455, x, y, z)
			local before = #finds
			assert(N.SetTarget(1455, mx, my, "Nissa", nil, "npc", gz))
			for i = 1, 500 do aim(); stub.advance(.05) end
			local hud = aim()
			local job = #finds > before and finds[#finds]
			local pts = job and job.done and job.points
			local tip = pts and pts[#pts]
			return { state = hud.state, bearing = hud.x ~= nil, climbs = tip and tip.z > z + 1 or false }
		end
		emit({ lower = from(-4872.2417, -1150.0642, 505.7699), upper = from(gx, gy, 512.4368) })"#,
		true,
	);
	let lower = &result["lower"];
	assert!(
		(lower["state"] == "travel" && lower["bearing"] == true && lower["climbs"] == true) || (lower["state"] == "unmapped" && lower["bearing"] == false),
		"don't point along the bottom floor if the walk ends there: {lower}"
	);
	assert_eq!(result["upper"]["state"], "arrived");
}

// A goto with a height is done only when the client's position is on its floor (Nav.AllowGuideArrival). At the
// guides' gotos on raised floors, in a cellar and beside NPCs on decks (the steps `polestar playtest` held after
// #3210, while its simulated player had no height), a player standing on the walking map's floor at the point
// completes the step; one twelve yards off on the same floor does not. Telf Joolam's goto carries his height,
// 2.2 yd above the slope at its point: the step completes beside him.
#[test]
fn a_goto_with_a_height_is_reached_on_its_floor_in_the_cellar_on_the_rises_and_beside_npcs_on_decks() {
	skip_unless_ready!();
	let out = run(
		&format!(
			r#"
		{TEST_PACK}
		{TEST_SOURCE}
		w.race, w.raceName, w.class, w.className, w.faction = "Orc", "Orc", "WARRIOR", "Warrior", "Horde"; w.setLevel(30)
		-- name, map, Era x, y, the goal's height; where the player stands when not at the point (live frame)
		local points = {{
			{{ "The cellar stairs", 1420, 61.66, 51.5, 34.3 }},
			{{ "Cairne's tent", 1456, 60.3, 51.7, 163.9 }},
			{{ "Thunder Bluff's central rise", 1456, 47.0, 49.8, 177 }},
			{{ "Ratchet", 1413, 62.3, 39.1, 23.2 }},
			{{ "Gan'rul Bloodeye", 1454, 48.3, 45.3, -14.8 }},
			{{ "Ormak Grimshot", 1454, 66.0, 18.5, 58.8 }},
			{{ "Telf Joolam", 1411, 38.5, 59.0, 168.2, 38.51, 58.9 }},
		}}
		local steps = {{}}
		for i, p in ipairs(points) do steps[i] = {{ title = p[1], goals = {{ {{ t = "goto", text = p[1], map = p[2], x = p[3], y = p[4], f = "e", z = p[5] }} }} }} end
		steps[#steps + 1] = {{ title = "End", goals = {{ {{ t = "goto", text = "End", map = 1454, x = 50, y = 50, f = "e" }} }} }}
		assert(Polestar.RegisterGuide({{ id = "test/floors", pack = "test", title = "Floors", category = "Leveling", minLevel = 1, maxLevel = 60, steps = steps }}))
		local G = Polestar.Engine
		G.SetGuide("test/floors")
		local out = {{}}
		for i, p in ipairs(points) do
			G.Goto(i)
			local c = C.MapToWorld(p[2], p[3], p[4], "e")
			local sx, sy = select(2, C.MapToWorld(p[2], p[3], p[4], "e"))
			if p[6] then sx, sy = select(2, C.MapToWorld(p[2], p[6], p[7])) end
			-- The walking map's floor nearest the goal's height at (x, y), read once its maps are in. Meanwhile the
			-- client gives a height 50 yd above the goal's: with none at all the goto is reached by map distance
			-- (Nav.lua heightless), and this probe stands at the point.
			local function floorAt(x, y)
				local s, k = {{}}, nil
				for _ = 1, 200 do
					place(p[2], x, y, p[5] + 50)
					aim(); stub.advance(.05)
					k = N.Path and N.Path.SurfacesAt(c, x, y, s)
					if k and k > 0 then break end
				end
				local best
				for j = 1, k or 0 do if not best or math.abs(s[j] - p[5]) < math.abs(best - p[5]) then best = s[j] end end
				return best
			end
			local floor = floorAt(sx, sy)
			local off = false
			for _, d in ipairs({{ {{ 12, 0 }}, {{ -12, 0 }}, {{ 0, 12 }}, {{ 0, -12 }} }}) do
				local near = floor and floorAt(sx + d[1], sy + d[2])
				if near and math.abs(near - floor) <= 2 then
					G.Goto(i)
					place(p[2], sx + d[1], sy + d[2], near)
					stub.fire("ZONE_CHANGED_NEW_AREA") -- arrived from the last point (a boat or a zeppelin away)
					for _ = 1, 40 do aim(); stub.advance(.05) end
					off = G.GetStepIndex() == i
					break
				end
			end
			local reached = false
			if floor then
				G.Goto(i)
				place(p[2], sx, sy, floor)
				for _ = 1, 200 do
					aim(); stub.advance(.05)
					if G.GetStepIndex() ~= i then reached = true; break end
				end
			end
			out[#out + 1] = {{ name = p[1], z = p[5], floor = floor and r1(floor), heldOff = off, reached = reached }}
		end
		emit(out)"#
		),
		true,
	);
	for p in out.as_array().unwrap() {
		let floor = p["floor"].as_f64().unwrap_or_else(|| panic!("no walking floor where the player stands: {p}"));
		assert!((floor - f(&p["z"])).abs() <= 2.0, "the goal's height is the floor where the player stands: {p}");
		assert_eq!(p["heldOff"], true, "twelve yards off on the same floor is not there: {p}");
		assert_eq!(p["reached"], true, "standing on the floor completes the goto: {p}");
	}
}

#[test]
fn a_polestars_world_frame_is_the_engines_known_unitposition_spots_and_guide_coordinates_land_on_the_engines_nodes_at_their_height_on_instance_map_0() {
	skip_unless_ready!();
	let out = run(
		r#"
		local r = { loads = stub.packLoads.Polestar_Nav, engine = N.Path == E }
		r.cs = stub.navNs.PathGrid.State(0).cs
		local ns = stub.navNs
		local G = ns.PathGrid
		local st = G.State(0)
		-- The engine's node a point snaps to: its centre and height.
		local function node(x, y, z)
			local k, lc = G.locate(st, x, y)
			if not k then return { outside = true } end
			local n = G.snap(st, k, lc, x, y, z)
			if not n then return { offmesh = true } end
			local cell = G.cellOf(st, k, n)
			local cx = st.x0 + (floor(k / st.ny) * st.C + floor(cell / st.C) + 0.5) * st.cs
			local cy = st.y0 + ((k % st.ny) * st.C + cell % st.C + 0.5) * st.cs
			return { d = dist(cx, cy, x, y), z = G.zOf(G.grid(st, k), n) }
		end
		local function spot(map, ux, uy, uz)
			-- UnitPosition -> Polestar's map coordinates -> Polestar's world point -> the engine's node there.
			local x, y = C.WorldToMap(0, ux, uy, map)
			local c, wx, wy = C.MapToWorld(map, x, y, "e")
			local n = node(wx, wy, uz)
			return { map = { r1(x), r1(y) }, c = c, back = dist(wx, wy, ux, uy), node = n.d, dz = n.z and math.abs(n.z - uz), swapped = node(wy, wx, uz).outside == true }
		end
		r.goldshire = spot(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
		r.lowerMouth = spot(1429, LOWER_MOUTH[1], LOWER_MOUTH[2], LOWER_MOUTH[3])
		local c, mx, my = C.MapToWorld(1429, 39.5, 82.4, "e")
		r.mine = { c = c, node = node(mx, my).d }
		r.available = { E.Available(c), E.Available(1429), E.Available(1415) }
		-- What the arrow asks: the player's UnitPosition (with its height) on instance 0, to Polestar's target point.
		place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
		local pc, px, py = C.GetPlayerWorldPosition()
		r.player = { pc, dist(px, py, GOLDSHIRE[1], GOLDSHIRE[2]) }
		local f = guide()
		r.ask = { n = #finds, map = f.map, from = dist(f.from[1], f.from[2], GOLDSHIRE[1], GOLDSHIRE[2]), z = f.from[3], to = dist(f.to[1], f.to[2], mx, my), toZ = f.to[3] }
		r.points = #f.points
		r.secondZ = f.points[2].z
		emit(r)"#,
		false,
	);
	assert_eq!(out["loads"], 1, "Data.Pack loaded Polestar_Nav once at login");
	assert_eq!(out["engine"], true);
	// Goldshire: Elwynn 42.0,65.0; the mine's lower mouth 39.5,80.0.
	assert_eq!(out["goldshire"]["map"], serde_json::json!([42, 65]));
	assert_eq!(out["lowerMouth"]["map"], serde_json::json!([39.5, 80]));
	let cs = f(&out["cs"]);
	for name in ["goldshire", "lowerMouth"] {
		let s = &out[name];
		assert_eq!(s["c"], 0, "{name}: Polestar's continent is UnitPosition's instance map id");
		assert!(f(&s["back"]) < 0.01, "{name}: map -> world gives the UnitPosition back ({})", s["back"]);
		assert!(f(&s["node"]) < cs, "{name}: the engine's node is {:.2} yd from Polestar's point (cells are {cs:.2} yd)", f(&s["node"]));
		assert!(f(&s["dz"]) < 3.0, "{name}: and at the height UnitPosition reads there (off by {:.2})", f(&s["dz"]));
		assert_eq!(s["swapped"], true, "{name}: north and west swapped would be off the engine's map");
	}
	assert_eq!(out["mine"]["c"], 0);
	assert!(f(&out["mine"]["node"]) < cs, "the guide's 39.5,82.4 snaps {:.2} yd away, within a cell", f(&out["mine"]["node"]));
	assert_eq!(out["available"], serde_json::json!([true, false, false]), "the engine knows instance 0, not the uiMapIDs 1429/1415");
	assert_eq!(out["player"][0], 0);
	assert!(f(&out["player"][1]) < 0.01);
	assert_eq!(out["ask"]["n"], 1);
	assert_eq!(out["ask"]["map"], 0);
	assert!(f(&out["ask"]["from"]) < 0.01 && f(&out["ask"]["to"]) < 0.01, "from the player, to the target, in the same yards");
	assert_eq!(f(&out["ask"]["z"]), 57.353, "the player's height goes with the search");
	assert!(out["ask"]["toZ"].is_null(), "a map target has no height");
	let (points, second_z) = (f(&out["points"]), f(&out["secondZ"]));
	assert!(points >= 3.0 && (second_z - 57.0).abs() < 15.0, "a {points}-point path on the ground (z {second_z})");
}

// The Jasperlode Mine's lower mouth in Polestar_Nav's Chokepoints.lua (a doorway: its indoor floor with outdoor
// ground at its height beside it): the walk from Goldshire into the mine (the Kobold Geomancer chain's last stop,
// Era 61.13,49.28) is split there (a named cave step), the walk to the mouth first, then the mine itself (Ruling 26
// of pathing v2: the format 2 path passes within the mouth's radius). This was the Fargodeep Mine's walk until maps
// format 3: its "mouth" at -9842.4,135.3 lay 30 yd inside the mine on its bottom floor (Bernice's Necklace's chain
// starts there, indoors, and gives no mouth since 8006432ed), and the guide's 39.5,82.4 (no height) now ends at the
// mine's lower door, on the ground outside, short of any mouth. Since the chokepoints stand on the street, not on the
// terrain buried under it (forge-nav's top surface under the open sky, 2026-10-25), the mouth is 13 yd further out,
// 15 yd across.
const MINE_MOUTH: [f64; 3] = [-9191.3, -604.0, 15.0];
const IN_THE_MINE: &str = r#"guide(1429, 61.13, 49.28, "Jasperlode Mine")"#;

#[test]
fn b_e_f_the_arrow_aims_along_the_engine_path_ahead_of_the_player_the_route_lines_and_the_journey_carry_the_same_path_split_at_the_mines_mouth() {
	skip_unless_ready!();
	let out = run(
		&r#"
		local r = {}
		place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
		local f = @GUIDE
		stub.advance(0.2) -- the arrow's own samples (20 Hz)
		local a = aim()
		local pts = f.points
		local _, tx, ty = N.GetTargetWorld()
		local at, off = alongOf(f, a.x, a.y)
		r.aim = { state = a.state, along = at, n = #pts, measured = a.measured, dist = a.dist, off = off, ahead = dist(a.x, a.y, GOLDSHIRE[1], GOLDSHIRE[2]), toTarget = dist(a.x, a.y, tx, ty) }
		r.path = { length = length(pts), straight = dist(GOLDSHIRE[1], GOLDSHIRE[2], tx, ty), endGap = dist(pts[#pts].x, pts[#pts].y, tx, ty) }
		r.left = { walk = N.walk.Left(0, tx, ty), along = length(pts) }
		r.shown = { text = N.arrow.distText:GetText(), want = Polestar.FormatDistance(floor(a.dist + 0.5)), visible = PolestarNavArrow:IsShown() }
		-- e: the route lines' walk legs are the arrow's walk: the engine's path points as Follow.Smooth kept them (it
		-- drops only corners a straight walkable line skips, and adds none), in order, the player first and the mine's
		-- mouth between the pieces.
		local g = N.GetRouteGeometry()
		local along, walks, current = {}, 0, nil
		for _, leg in ipairs(g.legs) do
			if leg.kind == "walk" then
				walks = walks + 1
				if leg.current then current = leg end
				for _, p in ipairs(leg.pts) do along[#along + 1] = p end
			end
		end
		local last, inOrder, extra, kept = 0, true, 0, 0
		for _, q in ipairs(along) do
			local i = nil
			for j, p in ipairs(pts) do
				if q[1] == 0 and q[2] == p.x and q[3] == p.y then i = j break end
			end
			if not i then
				extra = extra + 1
			elseif i < last then
				inOrder = false
			else
				if i > last then kept = kept + 1 end
				last = i
			end
		end
		r.geometry = { legs = #g.legs, walks = walks, inOrder = inOrder, extra = extra, kept = kept, lastKept = last,
			first = dist(current.pts[1][2], current.pts[1][3], GOLDSHIRE[1], GOLDSHIRE[2]) }
		-- f: the journey's legs.
		local legs, ci = N.GetRoute()
		local T = N.travel
		local list, finite, sum, yards = {}, true, 0, 0
		for i = ci, #legs do
			local l = legs[i]
			list[#list + 1] = { l.kind, l.label, l.seconds, l.yards }
			if l.seconds ~= l.seconds or l.seconds == math.huge or l.yards ~= l.yards then finite = false end
			sum, yards = sum + l.seconds, yards + l.yards
		end
		local ps, py = T.Progress()
		local first = legs[ci]
		r.first = { step = first.step, choke = first.choke and first.choke.name, mouth = dist(first.to.wx, first.to.wy, @MX, @MY), tail = first.tail }
		r.journey = { legs = list, finite = finite, sum = sum, yards = yards, total = first.seconds + first.rest, progress = { ps, py }, remaining = T.Remaining(a.dist, true), speed = py and ps and py / ps,
			whole = first.parent and first.parent.leg.yards }
		r.finds = #finds
		emit(r)"#
			.replace("@GUIDE", IN_THE_MINE)
			.replace("@MX", &js(MINE_MOUTH[0]))
			.replace("@MY", &js(MINE_MOUTH[1])),
		false,
	);
	let (aim, path, first, journey) = (&out["aim"], &out["path"], &out["first"], &out["journey"]);
	// b
	assert_eq!(aim["state"], "travel");
	assert_eq!(aim["measured"], true, "the distance is along the path");
	assert!(f(&aim["along"]) > 1.0, "the arrow aims ahead along the path (at point {:.2} of {}), not at the target", f(&aim["along"]), aim["n"]);
	assert!(f(&aim["ahead"]) <= 35.5, "within 35 yd of the player ({:.1} yd)", f(&aim["ahead"]));
	assert!(f(&aim["toTarget"]) > 50.0, "the aimed point is {:.0} yd short of the target", f(&aim["toTarget"]));
	assert!(f(&aim["off"]) < 2.0, "and on the path, a road's zigzag smoothed ({:.2} yd off)", f(&aim["off"]));
	assert!(f(&path["endGap"]) < 10.0, "the path ends {:.1} yd from the target", f(&path["endGap"]));
	// The walk is split at the mine's mouth: the first piece ends there.
	assert_eq!(first["step"], "cave");
	assert_eq!(first["choke"], "Jasperlode Mine");
	assert!(f(&first["mouth"]) <= MINE_MOUTH[2], "the first piece ends {:.1} yd from the mine's mouth", f(&first["mouth"]));
	// The arrow's walk is the engine's path straightened once (Follow.Smooth): never longer, and what it measures and
	// shows is along it.
	let (raw, tail, d, len) = (f(&path["length"]), f(&first["tail"]), f(&aim["dist"]), f(&out["left"]["walk"]));
	assert!(len <= raw + 0.5 && len >= f(&path["straight"]), "the walk {len:.1} yd: the engine's path {raw:.1} yd straightened, the straight line {:.0} yd", f(&path["straight"]));
	assert!((d - (len - tail)).abs() < 0.5, "the arrow shows the walk's length to the mouth ({d:.1} vs {len:.1} less {tail:.1} after it)");
	assert_eq!(out["shown"]["text"], out["shown"]["want"], "the arrow's distance text is that length");
	// e
	assert_eq!(out["geometry"]["walks"], 2, "two walk pieces on the route lines");
	assert_eq!(out["geometry"]["inOrder"], true, "their points are the engine's path's, in order");
	assert!(f(&out["geometry"]["extra"]) <= 2.0, "no point but the player's place and the mine's mouth is added ({})", out["geometry"]["extra"]);
	assert!(f(&out["geometry"]["kept"]) >= 2.0 && out["geometry"]["lastKept"] == aim["n"], "the path's end is kept ({} of {})", out["geometry"]["lastKept"], aim["n"]);
	assert!(f(&out["geometry"]["first"]) < 0.01, "starting where the player stands");
	// f (K1, K6, K7)
	assert_eq!(out["finds"], 1);
	let legs = journey["legs"].as_array().unwrap();
	assert_eq!(legs.len(), 2, "the walk to the mouth, then the mine");
	for l in legs {
		let label = l[1].as_str().unwrap_or("");
		assert!(!label.is_empty() && label != "Unknown", "K1: the {} leg is named ({label})", l[0]);
		assert!(l[2].as_f64().is_some_and(f64::is_finite) && l[3].as_f64().is_some_and(f64::is_finite), "K7: finite ({} s, {} yd)", l[2], l[3]);
	}
	assert_eq!(journey["finite"], true);
	assert_eq!(journey["sum"], journey["total"], "K6: the pieces' times add up to the walk's");
	assert!(journey["progress"].as_array().unwrap().iter().all(|v| v.as_f64().is_some_and(f64::is_finite)), "K7: the walk's progress is finite");
	assert!((f(&journey["progress"][1]) - (len - tail)).abs() < 0.5, "and measured along the walk to the mouth");
	assert!(f(&journey["remaining"]).is_finite());
	// f: once the path is in, the whole walk is measured along it (the sum of its pieces), at the planner's 7 yd/s.
	let (yards, sum) = (f(&journey["yards"]), f(&journey["sum"]));
	assert!((yards - len).abs() <= 1.0, "the pieces add up to {yards} yd, the path {len:.1} yd");
	assert!((sum - yards / 7.0).abs() <= 1.0, "{sum} s for {yards} yd");
	assert!(f(&journey["whole"]) > yards, "the walk's straight estimate ({} yd) stays on the whole walk", journey["whole"]);
}

#[test]
fn second_review_after_the_path_arrives_the_arrow_the_panels_step_times_and_the_header_total_agree() {
	skip_unless_ready!();
	let out = run(
		&r#"
		place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
		@GUIDE
		stub.advance(0.2)
		local a = aim()
		local legs, ci = N.GetRoute()
		local T = N.travel
		local view = Polestar.UI.JourneyPanel.Compute(legs, ci)
		local steps = 0
		for i = 1, view.n do steps = steps + view.secs[i] end
		emit({ arrow = T.Remaining(a.dist, true), n = view.n, leg = view.secs[1], rest = legs[ci].rest, steps = steps, header = view.total, planned = legs[ci].seconds + legs[ci].rest })"#
			.replace("@GUIDE", IN_THE_MINE),
		false,
	);
	let header = f(&out["header"]);
	assert_eq!(out["n"], 2, "the walk to the mouth, then the mine");
	assert!((f(&out["arrow"]) - header).abs() <= 1.0, "arrow {} s, header {header} s", out["arrow"]);
	assert_eq!(out["steps"], out["header"], "the steps add up to the header ({} s, {header} s)", out["steps"]);
	assert!((f(&out["leg"]) + f(&out["rest"]) - header).abs() <= 1.0, "the current step and the rest after it ({} + {} s), header {header} s", out["leg"], out["rest"]);
	assert!((f(&out["planned"]) - header).abs() <= 1.0, "the legs' planned times ({} s) and the header ({header} s)", out["planned"]);
}

// A new waypoint's walk is drawn before the planner's measures run (Routing/PathJobs.lua: a drawn search comes
// first): set at Razor Hill towards Sen'jin Village, Walk.Measure's batch (FindMany) has not had a slice when the
// arrow's search answers, and it still completes afterwards.
#[test]
fn the_arrows_walk_find_answers_before_walk_measures_batch_findmany_gets_any_slice_and_the_batch_completes_after_it() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		local _, px, py = C.MapToWorld(1411, 51.85, 43.49, "e")
		place(1411, px, py, 11.7)
		local many, atFind = {}, nil
		local realMany = E.FindMany
		E.FindMany = function(...)
			local job = realMany(...)
			many[#many + 1] = job
			return job
		end
		-- The batches' slices so far, taken when the arrow's walk answers (a pump may go on to them in the same frame).
		local realFind = E.Find
		E.Find = function(map, from, to, callback, opts)
			return realFind(map, from, to, function(...)
				if not atFind then
					atFind = {}
					for i, job in ipairs(many) do atFind[i] = job.frames end
				end
				return callback(...)
			end, opts)
		end
		N.SetTarget(1411, 56.31, 75.11, "Sen'jin Village", "e")
		aim()
		local n = 0
		while n < 2000 and not (atFind and #many > 0 and many[#many].done) do stub.advance(0.05); aim(); n = n + 1 end
		emit({ found = finds[1] and finds[1].points ~= nil, batches = #many, atFind = atFind or {}, done = many[1] and many[1].done or false })"#,
		false,
	);
	assert_eq!(out["found"], true, "the arrow's walk is found");
	assert!(f(&out["batches"]) >= 1.0, "Walk.Measure asked for a batch");
	for frames in out["atFind"].as_array().into_iter().flatten() {
		assert_eq!(*frames, 0, "no batch slice before the arrow's walk answered");
	}
	assert_eq!(out["done"], true, "the batch completes after it");
}

// 0.4.2.1: the walk's sketch (Path.FindCoarse, drawn while the walk is searched) for a player's walk (opts.walkLevel)
// is the entrance graph's shape again, answered in the slice it gets, not a full checked walk search: from Razor Hill
// towards Sen'jin Village it answers in one frame with points.coarse. The checked walk replaces it when it lands.
#[test]
fn a_players_walk_sketch_across_clusters_answers_in_one_slice_as_a_coarse_shape() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"; w.setLevel(11)
		local _, px, py = C.MapToWorld(1411, 51.85, 43.49, "e")
		local _, gx, gy = C.MapToWorld(1411, 56.31, 75.11, "e")
		local got, frames = nil, 0
		E.FindCoarse(1, { x = px, y = py, z = 11.7 }, { x = gx, y = gy }, function(points) got = points or false end,
			{ profile = "Horde", walkLevel = 11 })
		while got == nil and frames < 200 do stub.advance(0.05); frames = frames + 1 end
		emit({ frames = frames, points = type(got) == "table" and #got or 0, coarse = type(got) == "table" and got.coarse or false })"#,
		false,
	);
	assert_eq!(out["coarse"], true, "the sketch is the coarse shape: {out}");
	assert!(f(&out["points"]) >= 2.0, "it has a line: {out}");
	assert!(f(&out["frames"]) <= 1.0, "answered in the first slice: {out}");
}

// Fitz, 0.4.2.1 candidate: the route line as in 0.4.1.1, drawn as soon as the walk's sketch is in, the checked walk
// replacing it when it lands. 0.4.2 left the map without a line for the whole search ("no line until checked").
// The arrow's own search is held here, so only the sketch is in: from Razor Hill towards Sen'jin Village.
#[test]
fn the_route_line_draws_the_walks_sketch_while_its_search_is_still_out() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"; w.setLevel(11)
		local _, px, py = C.MapToWorld(1411, 51.85, 43.49, "e")
		place(1411, px, py, 11.7)
		for _ = 1, 40 do aim(); stub.advance(0.05) end
		local held = 0
		E.Find = function() held = held + 1 return { held = true } end
		N.SetTarget(1411, 56.31, 75.11, "Sen'jin Village", "e")
		local n, a = 0, aim()
		local function drawn()
			local g = N.GetRouteGeometry()
			local l = g and g.legs and g.legs[1]
			return l and l.current and #l.pts or 0
		end
		while drawn() < 3 and n < 100 do a = aim(); stub.advance(0.05); n = n + 1 end
		emit({ held = held > 0, state = a.state, points = drawn() })"#,
		false,
	);
	assert_eq!(out["held"], true, "the arrow's own search is out: {out}");
	assert!(f(&out["points"]) >= 3.0, "the sketch is drawn while the walk is searched: {out}");
}

// One continent's walking maps at a time (Fitz, 2026-10-25: 137 MB in the AddOn Memory readout with both of Leffe's
// continents): a journey to the other continent searches and measures only the walks on the player's own, so only its
// part of Polestar_Nav loads (Polestar_Nav_EK in Brill, its regions inside it, unpacked as its walks touch them); the
// walk at the far end keeps the planner's straight estimate. The other part loads once the player is there
// (Nav/Walk.lua canSearch, Path.Resident). No other addon loads: 0.4.2's region addons are gone (#3396).
#[test]
fn a_journey_to_the_other_continent_loads_only_the_players_continents_walking_maps_the_other_part_on_arrival() {
	skip_unless_ready!();
	if !addons_dir().join("Polestar_Nav_Kalimdor").is_dir() {
		eprintln!("skipped: no continent parts (the walking maps are not Leffe's)");
		return;
	}
	let out = run(
		r#"
		w.setLevel(20)
		w.faction = "Horde"
		local loads, asked = {}, {}
		local load = C_AddOns.LoadAddOn
		C_AddOns.LoadAddOn = function(name) loads[#loads + 1] = name return load(name) end
		for _, name in ipairs({ "FindMany", "FindCoarse", "FindCost" }) do
			local real = E[name]
			E[name] = function(map, ...) asked[map] = (asked[map] or 0) + 1 return real(map, ...) end
		end
		place(1420, 2249.1, 236.8, 41.3) -- Brill
		N.SetTarget(1411, 56.31, 75.11, "Sen'jin Village", "e")
		for _ = 1, 400 do aim() stub.advance(0.05) end
		local legs, ci = N.GetRoute()
		local far, finite = 0, true
		for i = ci or 1, legs and #legs or 0 do
			local l = legs[i]
			if l.kind == "walk" and l.from.c == 1 and l.to.c == 1 then far = far + 1 end
			if l.seconds ~= l.seconds or l.seconds == math.huge then finite = false end
		end
		local finds1 = 0
		for _, rec in ipairs(finds) do if rec.map == 1 then finds1 = finds1 + 1 end end
		local r = { loads = table.concat(loads, ","), resident1 = E.Resident(1), far = far, finite = finite, finds1 = finds1, asked1 = asked[1] or 0, asked0 = asked[0] or 0 }
		-- Off the zeppelin at Razor Hill: Kalimdor's part loads with the first walk there.
		local _, px, py = C.MapToWorld(1411, 51.85, 43.49, "e")
		place(1411, px, py, 11.7)
		for _ = 1, 200 do aim() stub.advance(0.05) end
		r.arrived = { loads = table.concat(loads, ","), resident1 = E.Resident(1) }
		emit(r)"#,
		false,
	);
	let loads = out["loads"].as_str().unwrap_or_default();
	assert_eq!(loads, "Polestar_Nav_EK", "in Brill only the Eastern Kingdoms' part loads");
	assert_eq!(out["resident1"], false);
	assert_eq!((f(&out["finds1"]), f(&out["asked1"])), (0.0, 0.0), "nothing is searched or measured on Kalimdor from Brill");
	assert!(f(&out["asked0"]) > 0.0, "the walks on the Eastern Kingdoms are");
	assert!(f(&out["far"]) >= 1.0 && out["finite"] == true, "the walk on Kalimdor stays in the journey, timed by its estimate");
	assert_eq!(out["arrived"]["loads"], "Polestar_Nav_EK,Polestar_Nav_Kalimdor", "Kalimdor's part loads on arrival");
	assert_eq!(out["arrived"]["resident1"], true);
}

// Forever's client answers UnitPosition with a height of exactly 0 (reported from Ratchet's flight master,
// 2026-10-16, where the ground is at 12 yd). Taken as real, the search started on the nearest surface within 10 yd
// of 0, 20 yd down the slope towards the harbour, and the line went there and back.
#[test]
fn z1_a_height_of_0_from_unitposition_is_no_height_the_walk_to_mebok_mizzyrix_starts_from_the_ground_never_out_towards_the_harbour() {
	skip_unless_ready!();
	let out = run(
		r#"
		local c, sx, sy = C.MapToWorld(1413, 63.07, 37.08, "e")
		place(1413, sx, sy, 0)
		local f = guide(1413, 62.37, 37.62, "Mebok Mizzyrix")
		-- The first search goes before the player's cluster is decoded (no height); once the floor reads
		-- the ground it is asked once more from there (Ruling 36b).
		for _ = 1, 100 do
			local last = finds[#finds]
			if last.done and last.from[3] then f = last break end
			stub.advance(0.05)
			aim()
		end
		local east = 0
		for _, p in ipairs(f.points) do if sy - p.y > east then east = sy - p.y end end
		emit({ c = c, z = f.from[3], east = east, n = #f.points })"#,
		false,
	);
	assert_eq!(out["c"], 1);
	// Never the 0 as a height: the ground under the player (z 12), which the walking floor (#234) reads there (one surface).
	assert!((f(&out["z"]) - 12.0).abs() <= 3.0, "searched from the ground's height ({})", out["z"]);
	assert!(f(&out["east"]) < 3.0, "no point of the path is east of the player, towards the harbour ({:.1} yd east, {} points)", f(&out["east"]), out["n"]);
}

#[test]
fn b_where_the_straight_line_is_blocked_thelsamar_to_the_stonewrought_dam_the_arrow_follows_the_detour() {
	skip_unless_ready!();
	let out = run(
		r#"
		local c, sx, sy = C.MapToWorld(1432, 35.5, 47, "e")
		place(1432, sx, sy)
		local f = guide(1432, 48, 15, "Stonewrought Dam")
		local a = aim()
		local _, tx, ty = N.GetTargetWorld()
		local at = alongOf(f, a.x, a.y)
		emit({ map = f.map, n = #f.points, length = length(f.points), straight = dist(sx, sy, tx, ty), along = at,
			toTarget = dist(a.x, a.y, tx, ty), endGap = dist(f.points[#f.points].x, f.points[#f.points].y, tx, ty), dist = a.dist,
			second = dist(sx, sy, f.points[2].x, f.points[2].y), ahead = dist(sx, sy, a.x, a.y) })"#,
		false,
	);
	let (len, straight, d, second) = (f(&out["length"]), f(&out["straight"]), f(&out["dist"]), f(&out["second"]));
	assert_eq!(out["map"], 0);
	assert!(len > straight * 1.2, "path {len:.0} yd against {straight:.0} yd straight");
	// The arrow aims along the detour, never straight at the target, and no further than 35 yd from the player.
	assert!(f(&out["along"]) > 1.0, "the arrow aims along the detour (at point {:.2} of {})", f(&out["along"]), out["n"]);
	assert!(f(&out["ahead"]) <= 35.5, "no further than 35 yd away ({:.1} yd)", f(&out["ahead"]));
	assert!(f(&out["toTarget"]) > 100.0);
	assert!(f(&out["endGap"]) < 10.0);
	// Measured along the path from where the player stands on it (within the passed first segment).
	assert!(d <= len + 0.5 && d > len - second - 0.5, "the yards shown ({d:.1}) are the detour's ({len:.1})");
}

// #1422 (sesgoe): from the Great Forge in Ironforge (47.58,52.97), the arrow to Afadra Dunwall (Ironforge 33.20,47.90,
// the Hall of Thanes' pick-up guide) pointed straight across the city, 117 yd. The walking maps walk to her spot (her
// spawn's floor, 464.8) through the halls, about 175 yd: the arrow aims along that walk, not straight at her.
#[test]
fn issue_1422_from_the_great_forge_the_arrow_to_afadra_dunwall_follows_the_walk_through_the_halls() {
	skip_unless_ready!();
	let out = run(
		r#"
		local _, sx, sy = C.MapToWorld(1455, 47.58, 52.97, "e")
		place(1455, sx, sy)
		local f = guide(1455, 33.2, 47.9, "Afadra Dunwall")
		for _ = 1, 10 do stub.advance(0.1); aim() end
		local a = aim()
		local _, tx, ty = N.GetTargetWorld()
		local pts = f and f.points or {}
		-- How far the aim turns from the straight line to her: the cosine between the two bearings.
		local ax, ay, bx, by = (a.x or sx) - sx, (a.y or sy) - sy, tx - sx, ty - sy
		local la, lb = sqrt(ax * ax + ay * ay), sqrt(bx * bx + by * by)
		emit({ map = f and f.map or false, n = #pts, length = length(pts), straight = lb, state = a.state,
			cos = la > 0 and (ax * bx + ay * by) / (la * lb) or 1, offPath = #pts > 1 and offPath(pts, a.x or sx, a.y or sy) or -1,
			endGap = #pts > 0 and dist(pts[#pts].x, pts[#pts].y, tx, ty) or -1 })"#,
		true,
	);
	let (len, straight) = (f(&out["length"]), f(&out["straight"]));
	assert_eq!(out["map"], 0, "the walking engine searched the walk");
	assert!(len > straight * 1.2, "a walk through the halls ({len:.0} yd), not the straight line ({straight:.0} yd)");
	assert!(f(&out["endGap"]) < 10.0, "the walk ends at her spot");
	assert!(f(&out["offPath"]) < 2.0, "the arrow aims at a point on the walk ({} yd off it)", out["offPath"]);
	assert!(f(&out["cos"]) < 0.87, "the walk's first stretch leads away from the straight line to her (cos {})", out["cos"]);
}

// #1650 (Rheuz): from the Suspicious Barrel at the Stonewrought Dam's east end, the walk back west to Chief Engineer
// Hinderweir VII (Loch Modan, Era 46.05,13.61, his height 310.3). A few yards north-east of the barrel the maps have
// no surface at the dam's level (the slope's foot), and the nearest surface without a height is the ridge above,
// which the maps join only to Grim Batol: searched from there with no height, the walk went round through the
// Wetlands and back in through Dun Algaz (5,600 yd). The walking floor keeps the dam's height over those cells.
#[test]
fn the_walk_from_the_suspicious_barrel_to_hinderweir_keeps_the_dams_height_off_its_edge_400_yd_along_the_dam_never_round_by_grim_batol_1650() {
	skip_unless_ready!();
	let out = run(
		r#"
		Polestar.Set("nav.travel", false)
		local _, bx, by = C.MapToWorld(1432, 56.05, 13.24, "e")
		local _, sx, sy = C.MapToWorld(1432, 57.5, 13, "e")
		place(1432, bx, by, 0)
		local function hinderweir()
			-- A new goal searches at once from where the player stands.
			N.ClearTarget()
			stub.advance(0.05)
			local n0 = #finds
			N.SetTarget(1432, 46.05, 13.61, "Chief Engineer Hinderweir VII", "e", nil, 310.3)
			aim()
			local n = 0
			while not (#finds > n0 and finds[#finds].done) and n < 400 do stub.advance(0.05); aim(); n = n + 1 end
			local f = finds[#finds]
			local north = -math.huge
			for _, p in ipairs(f.points or {}) do if p.x > north then north = p.x end end
			return { z = f.from[3], yards = length(f.points or {}), north = north, finds = #finds }
		end
		-- At the barrel with the target set a few seconds (the arrow's Walk.Aim reads the floor; the dam's cells
		-- there hold more than one level, so walking the first steps settles it), then north-east off the dam's edge.
		hinderweir()
		for _ = 1, 20 do stub.advance(0.3); aim() end
		local r = {}
		local steps = 20
		for i = 1, steps do
			place(1432, bx + (sx - bx) * i / steps, by + (sy - by) * i / steps, 0)
			stub.advance(0.3)
			aim()
		end
		r.edge = hinderweir()
		r.barrelX = bx
		emit(r)"#,
		false,
	);
	let ez = &out["edge"]["z"];
	assert!(ez.is_number(), "off the dam's edge the walk starts at a height, never without one ({ez})");
	assert!((f(ez) - 308.0).abs() <= 8.0, "the dam's height (302-314), not the ridge's (340): {ez}");
	let yards = f(&out["edge"]["yards"]);
	assert!(yards < 600.0, "about 400 yd along the dam, not 5,600 round by Grim Batol ({yards:.0} yd)");
	assert!(f(&out["edge"]["north"]) < f(&out["barrelX"]) + 100.0, "no point of the walk goes north over the ridge");
}

#[test]
fn c_walking_the_path_point_by_point_moves_the_aim_forward_along_it_never_asks_the_engine_again_and_arrives() {
	skip_unless_ready!();
	let out = run(
		r#"
		place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
		local f = guide()
		local pts = f.points
		local seen, backwards, last, steps, states = 0, 0, 0, 0, {}
		local function look()
			local a = aim()
			states[a.state] = (states[a.state] or 0) + 1
			if a.x then
				local at = alongOf(f, a.x, a.y)
				if at then
					if at < last - 1e-6 then backwards = backwards + 1 end
					last = at
					seen = seen + 1
				end
			end
			return a
		end
		for i = 2, #pts do
			local a, b = pts[i - 1], pts[i]
			local n = math.max(1, math.ceil(dist(a.x, a.y, b.x, b.y) / 4))
			for s = 1, n do
				local t = s / n
				place(1429, a.x + (b.x - a.x) * t, a.y + (b.y - a.y) * t, a.z and b.z and a.z + (b.z - a.z) * t or nil)
				stub.advance(0.5) -- 8 yd/s: the arrow samples on its own meanwhile
				look()
				steps = steps + 1
			end
		end
		emit({ n = #pts, seen = seen, last = last, backwards = backwards, finds = #finds, steps = steps, final = aim().state, states = states })"#,
		false,
	);
	assert_eq!(out["backwards"], 0, "the aimed point never goes back along the path");
	assert!(f(&out["seen"]) > 0.0 && f(&out["last"]) > f(&out["n"]) - 2.0, "it reached the path's last piece (point {:.2} of {})", f(&out["last"]), out["n"]);
	assert_eq!(out["finds"], 1, "{} steps along the path, no new search", out["steps"]);
	assert_eq!(out["final"], "arrived");
}

// A stray with nothing ahead on the path in sight (Path.Sight answering false everywhere: walls, a cliff): more than
// 25 yd off asks again. In open ground with a point ahead in sight, up to 100 yd off asks nothing (Nav/Follow.lua's
// sight, #1107; nav-spf a8-a13).
#[test]
fn d_30_yards_off_the_path_asks_once_after_the_2_s_throttle_keeping_the_old_path_meanwhile_the_arrow_follows_the_new_path() {
	skip_unless_ready!();
	let out = run(
		r#"
		local r = {}
		place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
		local f = guide()
		E.Sight = function() return false end -- nothing in sight
		local a, b = f.points[1], f.points[2]
		-- Up to 40 yd along the first segment (at most half of it), then 35 yd off it, square to it, on the side
		-- farther from the rest of the path.
		local L = dist(a.x, a.y, b.x, b.y)
		local ux, uy = (b.x - a.x) / L, (b.y - a.y) / L
		local along = math.min(40, L / 2)
		local ox, oy = a.x + ux * along - uy * 35, a.y + uy * along + ux * 35
		local px, py = a.x + ux * along + uy * 35, a.y + uy * along - ux * 35
		if offPath(f.points, px, py) > offPath(f.points, ox, oy) then
			ox, oy = px, py
		end
		place(1429, ox, oy)
		r.off = offPath(f.points, ox, oy)
		local s = aim()
		local at, gap = alongOf(f, s.x, s.y)
		r.soon = { finds = #finds, along = at, gap = gap, since = GetTime() - f.at }
		stub.advance(1)
		aim()
		r.stillSoon = #finds
		stub.advance(1.5)
		aim()
		r.after = #finds
		local g = finds[#finds]
		local n = 0
		while not g.done and n < 100 do stub.advance(0.05); n = n + 1 end
		s = aim()
		local nat, ngap = alongOf(g, s.x, s.y)
		r.new = { from = dist(g.from[1], g.from[2], ox, oy), along = nat, gap = ngap, n = #g.points, since = GetTime() - f.at }
		stub.advance(5)
		aim()
		r.settled = #finds
		emit(r)"#,
		false,
	);
	assert!(f(&out["off"]) > 30.0, "{:.1} yd off the path", f(&out["off"]));
	assert_eq!(out["soon"]["finds"], 1, "not within 2 s of the last search ({:.2} s)", f(&out["soon"]["since"]));
	assert!(f(&out["soon"]["gap"]) < 0.5, "the old path is kept meanwhile: the arrow aims on it ({})", out["soon"]);
	assert_eq!(out["stillSoon"], 1);
	assert_eq!(out["after"], 2, "one new search once 2 s have passed");
	assert!(f(&out["new"]["from"]) < 0.01, "from where the player stands");
	assert!(f(&out["new"]["gap"]) < 0.5 && f(&out["new"]["along"]) > 0.0 && f(&out["new"]["along"]) < 3.0, "the arrow aims along the new path's first stretch ({})", out["new"]);
	assert_eq!(out["settled"], 2, "on the new path nothing more is asked");
}

#[test]
fn g_row_6_c17_no_search_starts_in_combat_the_old_path_is_kept_and_one_runs_after_combat() {
	skip_unless_ready!();
	let out = run(
		r#"
		local r = {}
		place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
		local f = guide()
		stub.advance(3)
		stub.inCombat = true
		stub.fire("PLAYER_REGEN_DISABLED")
		local a, b = f.points[1], f.points[2]
		local L = dist(a.x, a.y, b.x, b.y)
		local ux, uy = (b.x - a.x) / L, (b.y - a.y) / L
		local ox, oy = a.x + ux * 60 - uy * 40, a.y + uy * 60 + ux * 40
		place(1429, ox, oy)
		stub.advance(5)
		local s = aim()
		r.fight = { finds = #finds, along = alongOf(f, s.x, s.y), state = s.state }
		-- A new target in combat: straight at it until its walk is found, never the old walk's bearing.
		N.SetTarget(1429, 39.5, 80.0, "Lower mouth", "e")
		stub.advance(2)
		s = aim()
		r.newTarget = { finds = #finds, state = s.state, bearing = s.x ~= nil }
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		aim()
		r.after = #finds
		local g = finds[#finds]
		local n = 0
		while not g.done and n < 100 do stub.advance(0.05); n = n + 1 end
		s = aim()
		local at, off = alongOf(g, s.x, s.y)
		r.follow = { combat = g.combat, from = dist(g.from[1], g.from[2], ox, oy), along = at, off = off }
		emit(r)"#,
		false,
	);
	assert_eq!(out["fight"]["finds"], 1, "nothing asked in combat");
	assert!(f(&out["fight"]["along"]) > 1.0, "the old path is kept");
	assert_eq!(out["newTarget"], serde_json::json!({ "finds": 1, "state": "routing", "bearing": true }));
	assert_eq!(out["after"], 2, "one search once combat ends");
	assert_eq!(out["follow"]["combat"], false);
	assert!(f(&out["follow"]["from"]) < 0.01);
	assert!(f(&out["follow"]["along"]) > 1.0 && f(&out["follow"]["off"]) < 2.0, "the arrow follows it");
}

// PG5K's report (#3409): following a walk, a fight pulls the player off it onto ground the walking map doesn't
// cover, and the walk asked again from there is refused. 0.4.2 then showed no bearing and no line, and asked again
// only once the player had gone 25 yd from that spot or the step changed ("it will stop updating, and I can fix it
// by clicking manually on the step"). Now the arrow points straight and draws its line meanwhile, as 0.4.1.1 did,
// and a player standing 6 yd on, back on the mapped ground, has the walk asked again.
#[test]
fn a_walk_refused_after_a_fight_off_the_walking_map_points_straight_and_is_asked_again_once_the_player_stands_back_on_it() {
	skip_unless_ready!();
	let out = run(
		r#"
		local r = {}
		-- The arrow's own walk to the target (the planner's re-plans aside: a new plan is a new walk, asked at once).
		Polestar.Set("nav.travel", false)
		place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
		local walk = guide()
		local _, tx, ty = N.GetTargetWorld()
		for _ = 1, 100 do stub.advance(0.05); aim() end
		r.following = { got = walk and walk.points and #walk.points or 0, state = aim().state }
		-- The fight: 39 yd off the walk by the mine, off the walking map. No height, as Forever's client gives none.
		place(1429, -9816.173, 171.327)
		local s
		for _ = 1, 100 do stub.advance(0.05); s = aim() end
		local g = N.GetRouteGeometry()
		local leg = g and g.legs and g.legs[1]
		r.refused = { finds = #finds, cost = finds[#finds].cost, state = s.state, measured = s.measured,
			atTarget = s.x and dist(s.x, s.y, tx, ty) < 1 or false, line = N.CanDrawGroundApproach(),
			straight = leg and leg.straight or false, pts = leg and #leg.pts or 0 }
		-- The fight goes on there for 8 s: past the floor's own re-ask (a floor found within 5 s of a search asked
		-- without one asks once more, Ruling 36b), which would otherwise answer for the step back.
		for _ = 1, 160 do stub.advance(0.05); aim() end
		r.stillRefused = { finds = #finds, state = aim().state }
		-- Six yards on, back on the mapped ground, standing still there for 20 s.
		place(1429, -9822.173, 171.327)
		for _ = 1, 400 do stub.advance(0.05); aim() end
		local f = finds[#finds]
		local n = 0
		while f and not f.done and n < 100 do stub.advance(0.05); n = n + 1 end
		s = aim()
		r.after = { finds = #finds, got = f and f.points and #f.points or 0, from = f and dist(f.from[1], f.from[2], -9822.173, 171.327), state = s.state, measured = s.measured }
		emit(r)"#,
		false,
	);
	assert!(out["following"]["got"].as_u64().unwrap_or(0) > 1 && out["following"]["state"] == "travel", "a walk to follow first ({})", out["following"]);
	assert_eq!(out["refused"]["cost"], "no safe walking route", "the walk asked again off the walking map is refused ({})", out["refused"]);
	assert_eq!(out["refused"]["state"], "travel", "the arrow points meanwhile ({})", out["refused"]);
	assert_eq!(out["refused"]["measured"], false);
	assert_eq!(out["refused"]["atTarget"], true, "straight at the target");
	assert_eq!(out["refused"]["line"], true, "and its line is drawn");
	assert_eq!(out["refused"]["straight"], true, "straight, from the player");
	assert_eq!(out["refused"]["pts"], 2);
	assert_eq!(out["stillRefused"]["state"], "travel", "still straight there ({})", out["stillRefused"]);
	assert!(out["after"]["finds"].as_u64() > out["stillRefused"]["finds"].as_u64(), "asked again from the mapped ground ({})", out["after"]);
	assert!(f(&out["after"]["from"]) < 0.01, "from where the player stands now");
	assert!(out["after"]["got"].as_u64().unwrap_or(0) > 1, "a walk this time");
	assert_eq!(out["after"]["state"], "travel");
	assert_eq!(out["after"]["measured"], true, "the arrow follows it");
}

#[test]
fn z1_a_guide_goal_at_andron_gant_is_walked_to_his_floor_with_his_height_without_it_to_the_cheapest_floor_there_his_own_too_by_the_lift() {
	skip_unless_ready!();
	let out = run(
		r#"
		local r = {}
		local ANDRON = { 1389.34, 347.315, -65.96 } -- his CMaNGOS spawn; the guides' 54.81,76.33 (Era) on the Undercity's map
		-- His quests are the Horde's: Undercity is the player's own capital (an
		-- Alliance profile prices it as a hostile town, x20, and walks elsewhere).
		w.faction = "Horde"
		-- The walk itself, from Brill: without route planning the arrow searches player to target
		-- (with it, Undercity's entrance chain takes the last stretch straight).
		Polestar.Set("nav.travel", false)
		place(1420, 2269, 260, 34)
		-- The last search for Andron's point, once it is in: what it was asked and the
		-- engine's last point before the goal itself (the floor the walk ends on).
		local function toAndron()
			local n = 0
			local function last()
				for i = #finds, 1, -1 do
					local f = finds[i]
					if dist(f.to[1], f.to[2], ANDRON[1], ANDRON[2]) < 1 then return f end
				end
			end
			aim()
			while not (last() and last().done) and n < 400 do stub.advance(0.05); aim(); n = n + 1 end
			local f = last()
			local pts = f and f.points or {}
			return { z = f and f.to[3], endZ = #pts >= 3 and r1(pts[#pts - 1].z) or nil, asked = #finds, aim = aim().state }
		end
		Polestar.Fire("WAYPOINT_CHANGED", { map = 1458, x = 54.81, y = 76.33, f = "e", z = ANDRON[3], label = "Andron Gant", kind = "turnin", r = 5 })
		r.withZ = toAndron()
		r.targetZ = select(4, N.GetTargetWorld())
		N.SetTarget(1458, 54.81, 76.33, "Andron Gant", "e")
		r.withoutZ = toAndron()
		emit(r)"#,
		false,
	);
	assert_eq!(f(&out["targetZ"]), -65.96, "the target keeps the waypoint's height");
	assert_eq!(f(&out["withZ"]["z"]), -65.96, "the walk to him is searched with his height");
	assert_eq!(out["withZ"]["asked"], 1, "once: the path it found ends near that height");
	let end_z = f(&out["withZ"]["endZ"]);
	assert!((end_z - f(&out["withZ"]["z"])).abs() <= 4.0, "and ends on his floor ({end_z})");
	assert_eq!(out["withZ"]["aim"], "travel");
	// Set by hand the point has no height of its own; in the Undercity (a capital) the walk goes to the floor players
	// walk at it (the trail floor, Walk.lua city.GoalZ), on his level.
	let hand_z = f(&out["withoutZ"]["z"]);
	assert!((hand_z - f(&out["withZ"]["z"])).abs() <= 4.0, "the same point set by hand goes to the trail floor on his level ({hand_z})");
	assert!((f(&out["withoutZ"]["endZ"]) - end_z).abs() <= 4.0, "and ends on his floor as well, by the lift ({})", out["withoutZ"]["endZ"]);
}

// #1024 (Pilk): Apothecary Zamah stands in the Pools of Vision, under Spirit Rise in Thunder Bluff (her spawn
// height 112; the shaman trainers' hut right above her at 138). On the shipped maps her point has four surfaces:
// Spirit Rise (138, outdoors), the Pools of Vision (112 and 126, indoors) and a roof (158). Walked to from the
// flight master with her height the path ends in the Pools; without it (the pick-up guide's goals had none) it
// ends up on Spirit Rise, out of the cave.
#[test]
fn z1_a_walk_to_apothecary_zamah_with_her_height_ends_in_the_pools_of_vision_without_it_on_spirit_rise_above_1024() {
	skip_unless_ready!();
	let script = r#"
local Path = Polestar_NavEngine
local ZAMAH = { -995.4, 278.6, 112 } -- her CMaNGOS spawn (the Forever server's agrees)
local FLIGHT = { -1196.8, 29.1 }     -- Thunder Bluff's flight master, on the mesa
local s, a, n = {}, {}, nil
for _ = 1, 50 do n = Path.SurfacesAt(1, ZAMAH[1], ZAMAH[2], s, a); if n then break end; stub.advance(0.1) end
local surfaces = {}
for i = 1, n or 0 do surfaces[i] = { z = s[i], area = Path.AreaName(1, a[i]) or false } end
local function lastZ(z)
	local pts = Path.FindSync(1, { x = FLIGHT[1], y = FLIGHT[2] }, { x = ZAMAH[1], y = ZAMAH[2], z = z })
	return pts and #pts >= 3 and pts[#pts - 1].z or false
end
emit({ surfaces = surfaces, withZ = lastZ(ZAMAH[3]), withoutZ = lastZ(nil) })"#;
	let out = emitted(&RunAddon { stubs: vec!["stub_encoding.lua"], addons: vec![Addon::name("Polestar_Nav")], script: script.into(), ..Default::default() }).remove(0);
	eprintln!("{out}");
	let pools: Vec<f64> = out["surfaces"].as_array().unwrap().iter().filter(|s| s["area"] == "The Pools of Vision").map(|s| f(&s["z"])).collect();
	assert!(pools.iter().any(|z| (z - 112.0).abs() <= 4.0), "her point has the Pools of Vision's floor at her height: {}", out["surfaces"]);
	let (with_z, without_z) = (f(&out["withZ"]), f(&out["withoutZ"]));
	assert!((with_z - 112.0).abs() <= 8.0, "with her height the walk ends in the Pools of Vision ({with_z})");
	assert!(without_z > 130.0, "without it, on Spirit Rise above her ({without_z})");
}

#[test]
fn k1_a_walk_into_a_cave_is_split_at_its_mouth_from_polestar_navs_chokepoints_lua_the_step_named_by_the_cave() {
	skip_unless_ready!();
	let out = run(
		r#"
		local c, sx, sy = C.MapToWorld(1426, 46.7, 53.0, "e")
		place(1426, sx, sy, 401.5)
		-- A goal inside the cave with its height (a guide's spawn point): the engine walks in, not over the hill above.
		Polestar.Fire("WAYPOINT_CHANGED", { map = 1426, x = 41.18, y = 50.28, f = "e", z = 355, label = "Grizzled Den", kind = "turnin", r = 5 })
		aim()
		local n = 0
		while not (finds[#finds] and finds[#finds].done) and n < 200 do stub.advance(0.05); aim(); n = n + 1 end
		N.walk.Split()
		local legs, ci = N.GetRoute()
		local list = {}
		for i = ci, #legs do
			local l = legs[i]
			list[#list + 1] = { kind = l.kind, label = l.label, step = l.step, choke = l.choke and l.choke.name, seconds = l.seconds }
		end
		local caves = 0
		for _, e in ipairs(PolestarNavChokepoints and PolestarNavChokepoints[0] or {}) do if e.kind == "cave" then caves = caves + 1 end end
		emit({ legs = list, caves = caves, points = finds[#finds] and finds[#finds].points and #finds[#finds].points })"#,
		false,
	);
	assert!(f(&out["caves"]) > 50.0, "Chokepoints.lua loads with Polestar_Nav ({} caves on map 0)", out["caves"]);
	let legs = out["legs"].as_array().unwrap();
	let cave = legs.iter().find(|l| l["step"] == "cave").unwrap_or_else(|| panic!("a cave step: {}", out["legs"]));
	assert_eq!(cave["choke"], "The Grizzled Den");
	assert!(cave["label"].as_str().unwrap().contains("Grizzled Den"));
	assert!(legs.iter().all(|l| l["label"].as_str().is_some_and(|s| !s.is_empty() && s != "Unknown")), "K1: every step is named");
}

// Missing or damaged map bytes must not turn a pending walking route into a direct bearing.
fn nav_dir() -> PathBuf {
	addons_dir().join("Polestar_Nav/Nav")
}

#[test]
fn the_walking_maps_load_on_demand_only_with_walk_real_paths_on_nav_navrouting_off_polestar_nav_is_never_loaded() {
	skip_unless_ready!();
	let (_tmp, ns) = ns_file();
	let files = nav_files(&ns);
	let run1 = |routing: bool, level: u8| {
		let addons = polestar_addons();
		emitted(&RunAddon {
			stubs: vec!["stub_world.lua", "stub_encoding.lua", "stub_packs.lua"],
			before: format!("{}\nstub.world.level = {level}", before(&files)),
			addons,
			saved: vec![("Polestar".into(), format!("PolestarDB = {{ schema = 1, settings = {{ nav = {{ navRouting = {routing} }} }} }}"))],
			login: true,
			script: format!(
				"{PRELUDE}{}",
				r#"
			place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
			N.SetTarget(1429, 39.5, 82.4, "Fargodeep Mine", "e")
			for _ = 1, 40 do stub.advance(0.05); aim() end
			emit({ loads = stub.packLoads.Polestar_Nav or 0, data = PolestarPathData ~= nil, chokepoints = PolestarNavChokepoints ~= nil, finds = #finds, state = aim().state })"#
			),
		})
		.remove(0)
	};
	// The mine has kobolds, but the walk from Goldshire does not enter an enemy settlement.
	let off = run1(false, 8);
	assert_eq!(serde_json::json!([off["loads"], off["data"], off["chokepoints"], off["finds"]]), serde_json::json!([0, false, false, 0]), "routing off: no maps in memory, no search");
	assert_eq!(off["state"], "travel", "the arrow still points (straight)");
	assert_eq!(run1(false, 1)["state"], "travel", "ordinary enemies do not suppress the compass");
	let on = run1(true, 1);
	assert_eq!(serde_json::json!([on["loads"], on["data"], on["chokepoints"]]), serde_json::json!([1, true, true]), "routing on: loaded once at login");
	assert_eq!(on["state"], "travel", "a level-one Alliance character is guided from Goldshire");
	assert!(f(&on["finds"]) >= 1.0);
}

// Map 0's part files: in its part addon (maps format 5: Polestar_Nav_EK) or in Polestar_Nav/Nav.
fn parts_dir() -> PathBuf {
	forge_nav::pack::part_of(0).map(|p| addons_dir().join(p)).filter(|d| d.is_dir()).unwrap_or_else(nav_dir)
}

// The part file holding the cluster (ADT tile) of a world point on map 0, and that cluster's index.
fn cluster_file(wx: f64, wy: f64) -> (i64, Option<String>) {
	let meta = std::fs::read_to_string(nav_dir().join("Nav0.lua")).unwrap();
	let num = |k: &str| -> i64 { Regex::new(&format!(r"\t{k} = (-?\d+),")).unwrap().captures(&meta).unwrap()[1].parse().unwrap() };
	let t = 1600.0 / 3.0;
	let k = ((wx / t).floor() as i64 - num("cx0")) * num("ny") + ((wy / t).floor() as i64 - num("cy0"));
	let part = Regex::new(r"^Nav0_\d+\.lua$").unwrap();
	let needle = format!("data.packed.grid[{}] = ", k + 1);
	let mut names: Vec<String> = std::fs::read_dir(parts_dir()).unwrap().filter_map(|e| e.ok()).map(|e| e.file_name().to_string_lossy().into_owned()).filter(|n| part.is_match(n)).collect();
	names.sort();
	let file = names.into_iter().find(|n| String::from_utf8_lossy(&std::fs::read(parts_dir().join(n)).unwrap()).contains(&needle));
	(k, file)
}

const WALK_COMPASS: &str = r#"
	local pin, tracked, published = nil, false, 0
	function C_Map.SetUserWaypoint(value) pin = value end
	function C_Map.GetUserWaypoint() return pin end
	function C_Map.ClearUserWaypoint() pin = nil; tracked = false end
	C_SuperTrack = C_SuperTrack or {}
	function C_SuperTrack.IsSuperTrackingUserWaypoint() return tracked end
	function C_SuperTrack.SetSuperTrackedUserWaypoint(value)
		tracked = value
		if value then published = published + 1 end
	end
	Polestar.Set("nav.blizzardWaypoint", true)
	-- straight: no walk can be found there, so the arrow points straight at the goal and says why (#3409, Fitz's
	-- ruling: as before 0.4.2): -> "<state>|<Nav.noWalk>" once settled.
	local function checkWalk(named, straight)
		w.setLevel(8)
		place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
		if named then
			local x, y = C.WorldToMap(0, LOWER_MOUTH[1], LOWER_MOUTH[2], 1429)
			N.SetTarget(1429, x, y, "Lower mine mouth", nil, "object", LOWER_MOUTH[3])
		else
			N.SetTarget(1429, 39.5, 82.4, "Fargodeep Mine", "e")
		end
		local first = aim()
		if straight then
			for _ = 1, 120 do stub.advance(.05); aim() end
			local settled = aim()
			assert(settled.state ~= "travel" or settled.x ~= nil, "a straight bearing")
			return settled.state .. "|" .. tostring(N.noWalk)
		end
		-- Until the walk is found: the straight bearing, as 0.4.1.1 pointed; no waypoint published.
		assert(first.state == "routing" and published == 0, "unchecked waypoint bearing")
		for _, leg in ipairs(N.GetRouteGeometry().legs) do
			assert(not leg.current or #leg.pts == 0, "current walk drew an unchecked route")
		end
		local manual = { uiMapID = 1429, position = CreateVector2D(.18, .27) }
		C_Map.SetUserWaypoint(manual); C_SuperTrack.SetSuperTrackedUserWaypoint(true)
		for _ = 1, 120 do stub.advance(.05); aim() end
		local settled = aim()
		assert(settled.state == "routing" and published == 1)
		assert(pin == manual and tracked, "an independent waypoint must keep guiding")
		return settled.state
	end"#;

const DAMAGED_MAP: &str = r#"
	local state = checkWalk(false, true)
	local f = finds[#finds]
	emit({ state = state, available = E.Available(0), points = f and f.points and #f.points or 0, cost = f and f.cost })"#;

fn with_maps(files: &[PathBuf], script: &str) -> Value {
	with_maps_and(files, "", script)
}

fn with_maps_and(files: &[PathBuf], extra: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_encoding.lua", "stub_packs.lua"],
		before: format!("{}\n{extra}", before(files)),
		addons: polestar_addons(),
		login: true,
		script: format!("{PRELUDE}\n{WALK_COMPASS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn missing_walking_engine_points_straight_and_says_why() {
	skip_unless_ready!();
	let out = with_maps_and(&[], "stub.packs.Polestar_Nav = nil", "emit(checkWalk(false, true))");
	// #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
	assert_eq!(out, "travel|unmapped");
}

#[test]
fn combat_login_waits_for_the_named_walk_then_follows_it() {
	skip_unless_ready!();
	let (_tmp, ns) = ns_file();
	let out = with_maps_and(
		&nav_files(&ns),
		"stub.inCombat = true",
		r#"local cold = checkWalk(true)
		assert(not stub.packLoads.Polestar_Nav, "do not load walking data in combat")
		stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED")
		for _ = 1, 120 do stub.advance(.05); aim() end
		local a = aim()
		local _, x, y = N.GetTargetWorld()
		emit({cold, a.state, a.measured, a.x and dist(a.x, a.y, x, y) > 1})"#,
	);
	assert_eq!(out, serde_json::json!(["routing", "travel", true, true]));
}

#[test]
fn missing_continent_pack_does_not_publish_a_waypoint_before_the_arrow_samples() {
	skip_unless_ready!();
	let (_tmp, ns) = ns_file();
	let part = forge_nav::pack::part_of(0).unwrap();
	let out = with_maps_and(&nav_files(&ns), &format!("stub.packs.{part} = {{}}"), "emit(checkWalk(false, true))");
	// #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
	assert_eq!(out, "travel|unmapped");
}

#[test]
fn a_map_with_no_walking_data_points_straight_and_says_why_when_routing_is_enabled() {
	skip_unless_ready!();
	let (_tmp, ns) = ns_file();
	let mine = Regex::new(r"[\\/]Nav0(_\d+)?\.lua$").unwrap();
	let files: Vec<PathBuf> = nav_files(&ns).into_iter().filter(|p| !mine.is_match(&p.to_string_lossy())).collect();
	let out = with_maps(&files, DAMAGED_MAP);
	assert_eq!(out["available"], false, "no data for map 0");
	// #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
	assert_eq!(out["state"], "travel|unmapped");
}

#[test]
fn a_corrupted_grid_block_finds_no_path_through_it_and_the_arrow_points_straight() {
	skip_unless_ready!();
	let (k, file) = cluster_file(-9444.062, 77.667);
	let file = file.expect("Goldshire's cluster is in one part file");
	let tmp = TempDir::new("polestar-nav-bad-");
	let bad = tmp.path().join(&file);
	let bytes = std::fs::read(parts_dir().join(&file)).unwrap();
	// A block that is not zlib: as the metadata's literals carry blocks (zlib bytes, or base64).
	let zlib = std::fs::read_to_string(nav_dir().join("Nav0.lua")).unwrap().contains("\n\tblocks = \"zlib\",\n");
	let re = regex::bytes::Regex::new(&format!(r"(?m-u)^data\.packed\.grid\[{}\] = \{{.*\}}$", k + 1)).unwrap();
	let block = if zlib { "not zlib" } else { "bm90IHpsaWI=" };
	let broken = re.replace(&bytes, format!("data.packed.grid[{}] = {{\"{block}\"}}", k + 1).as_bytes()).into_owned();
	assert_ne!(broken, bytes);
	std::fs::write(&bad, broken).unwrap();
	let (_ns_tmp, ns) = ns_file();
	let swap = |p: PathBuf| if p.file_name().is_some_and(|n| n.to_string_lossy() == file) && p.starts_with(parts_dir()) { bad.clone() } else { p };
	let out = if parts_dir() == nav_dir() {
		with_maps(&nav_files(&ns).into_iter().map(swap).collect::<Vec<_>>(), DAMAGED_MAP)
	} else {
		let part = forge_nav::pack::part_of(0).unwrap();
		let list: Vec<String> = toc_files(part).unwrap().into_iter().map(swap).map(|p| lua_string(&p.to_string_lossy())).collect();
		with_maps_and(&nav_files(&ns), &format!("stub.packs.{part} = {{ {} }}", list.join(", ")), DAMAGED_MAP)
	};
	assert_eq!(out["available"], true, "the map is there");
	assert_eq!(out["points"], 0, "no path through the broken cluster ({})", out["cost"]);
	// #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
	assert_eq!(out["state"], "travel|unmapped");
}

/// Geo.toWorld (tools/lib/planner/geo.js): the frame of f's set first ("e": Era, else the live one), the other when
/// the map has none -> (c, wx, wy).
fn to_world(frames: &Value, map: i64, x: f64, y: f64, era: bool) -> Option<(i64, f64, f64)> {
	let (a, b) = if era { ("era", "forever") } else { ("forever", "era") };
	let key = map.to_string();
	let fr = frames[a].get(&key).or_else(|| frames[b].get(&key))?;
	Some((fr["c"].as_i64()?, f(&fr["top"]) + (f(&fr["bottom"]) - f(&fr["top"])) * (y / 100.0), f(&fr["left"]) + (f(&fr["right"]) - f(&fr["left"])) * (x / 100.0)))
}

#[test]
fn every_one_of_the_49_zones_the_guides_walk_in_routes_on_the_shipped_maps_and_zephras_isle_too() {
	skip_unless_ready!();
	let frames = json_file("map-frames.json");
	let src = std::fs::read_to_string(addons_dir().join("Polestar_Guides/Guides.lua")).unwrap();
	// A goal's coordinates are in the Era frame with f = "e", else the live (Forever) frame (Compat.MapToWorld); its
	// height, when the guide carries one (an NPC's or object's spawn), goes with it, as the arrow sends it
	// (Nav.GetTargetWorld), and a walk with them that finds nothing is asked once more without them, as the arrow does
	// (Z2): William MacGregor (Westfall 57.71,53.94, z 33) stands on his house's floor (34), under the ground's own
	// surface there (38), a pocket no walk leaves; without his height the walk started on it.
	struct W {
		c: i64,
		wx: f64,
		wy: f64,
		z: Option<String>,
	}
	let re = Regex::new(r#"map = (\d+), x = ([\d.]+), y = ([\d.]+)(?:, z = (-?[\d.]+))?(, f = "e")?"#).unwrap();
	let mut by_zone: BTreeMap<i64, Vec<W>> = BTreeMap::new();
	for m in re.captures_iter(&src) {
		let map: i64 = m[1].parse().unwrap();
		let Some((c, wx, wy)) = to_world(&frames, map, m[2].parse().unwrap(), m[3].parse().unwrap(), m.get(5).is_some()) else { continue };
		if c != 0 && c != 1 {
			continue;
		}
		let z = m.get(4).map(|z| js(z.as_str().parse::<f64>().unwrap()));
		by_zone.entry(map).or_default().push(W { c, wx, wy, z });
	}
	// Per zone, up to 6 candidate pairs; the zone passes when one routes (a goal can stand on a ledge or a tree only its own quest reaches).
	let mut zones: Vec<(i64, i64, Vec<(&W, &W)>)> = Vec::new();
	for (map, ws) in &by_zone {
		let mut pairs = Vec::new();
		'outer: for i in 0..ws.len() {
			for j in i + 1..ws.len() {
				if pairs.len() >= 6 {
					break 'outer;
				}
				let d = (ws[i].wx - ws[j].wx).hypot(ws[i].wy - ws[j].wy);
				if ws[i].c == ws[j].c && (80.0..=400.0).contains(&d) {
					pairs.push((&ws[i], &ws[j]));
				}
			}
		}
		if !pairs.is_empty() {
			let c = pairs[0].0.c;
			zones.push((*map, c, pairs));
		}
	}
	let z_of = |w: &W| w.z.clone().unwrap_or_else(|| "nil".into());
	let lua = zones
		.iter()
		.map(|(map, c, pairs)| {
			let ps = pairs.iter().map(|(a, b)| format!("{{ {:.2}, {:.2}, {:.2}, {:.2}, {}, {} }}", a.wx, a.wy, b.wx, b.wy, z_of(a), z_of(b))).collect::<Vec<_>>().join(", ");
			format!("{{ {map}, {c}, {{ {ps} }} }}")
		})
		.collect::<Vec<_>>()
		.join(",\n");
	let zeph = to_world(&frames, 2521, 50.0, 50.0, false).unwrap();
	let zeph2 = to_world(&frames, 2521, 45.0, 60.0, false).unwrap();
	let script = r#"
local Path = Polestar_NavEngine
local out = { failed = {}, n = 0 }
for _, z in ipairs({ @ZONES }) do
	out.n = out.n + 1
	local ok = false
	for _, p in ipairs(z[3]) do
		-- As the arrow asks (Nav/Walk.lua): with the goals' heights, once more without them when that finds nothing (Z2).
		local pts = Path.FindSync(z[2], { x = p[1], y = p[2], z = p[5] }, { x = p[3], y = p[4], z = p[6] })
			or Path.FindSync(z[2], { x = p[1], y = p[2] }, { x = p[3], y = p[4] })
		if pts then ok = true break end
	end
	if not ok then out.failed[#out.failed + 1] = z[1] end
end
local pts, cost = Path.FindSync(2991, { x = @ZX, y = @ZY }, { x = @Z2X, y = @Z2Y })
out.zephras = pts and cost or tostring(cost)
emit(out)"#
		.replace("@ZONES", &lua)
		.replace("@Z2X", &js(zeph2.1))
		.replace("@Z2Y", &js(zeph2.2))
		.replace("@ZX", &js(zeph.1))
		.replace("@ZY", &js(zeph.2));
	let out = emitted(&RunAddon { stubs: vec!["stub_encoding.lua"], addons: vec![Addon::name("Polestar_Nav")], script, ..Default::default() }).remove(0);
	// The 49 zones of Eastern Kingdoms and Kalimdor the guides walk in (uiMapIDs), pinned so none drops out unseen.
	const ZONES: [i64; 49] = [
		1411, 1412, 1413, 1416, 1417, 1418, 1419, 1420, 1421, 1422, 1423, 1424, 1425, 1426, 1427, 1428, 1429, 1430, 1431, 1432, 1433, 1434, 1435, 1436, 1437, 1438, 1439, 1440, 1441, 1442, 1443, 1444,
		1445, 1446, 1447, 1448, 1449, 1450, 1451, 1452, 1453, 1454, 1455, 1456, 1457, 1458, 2482, 2548, 2652,
	];
	assert_eq!(zones.iter().map(|z| z.0).collect::<Vec<_>>(), ZONES.to_vec(), "the zones tested");
	assert_eq!(out["n"], ZONES.len());
	let failed: Vec<Value> = match &out["failed"] {
		Value::Array(a) => a.clone(),
		Value::Object(o) => o.values().cloned().collect(),
		_ => vec![],
	};
	assert!(failed.is_empty(), "every zone routes: failed {failed:?}");
	assert!(out["zephras"].as_f64().is_some_and(|c| c > 100.0), "Zephras Isle routes on its map ({})", out["zephras"]);
}

// From the Crossroads to Ashenvale 40,70, Sun Rock looks close across the ridge.
// Hold the ticket until the ground is priced, then draw the shorter checked
// Splintertree walk rather than the straight line from either landing.
#[test]
fn ashenvale_40_70_from_the_crossroads_the_route_lands_where_the_engines_walk_is_short_and_its_last_walk_follows_the_engines_path() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		w.setLevel(30)
		Polestar.CharState().flags.taxi = { [22] = true, [23] = true, [25] = true, [29] = true, [58] = true, [61] = true, [77] = true }
		local by = {}
		for _, n in ipairs(N.GetTravelData().taxi) do by[n.id] = n end
		local xr, sun, splinter = by[25], by[29], by[61]
		place(xr.map, xr.wx, xr.wy)
		-- Where the route lands, its last walk, and how the route lines draw that walk.
		local function route()
			local legs, ci = N.GetRoute()
			if not legs then return nil end
			local fly, walk
			for i = ci, #legs do
				if legs[i].kind == "fly" then fly = legs[i] end
				if legs[i].kind == "walk" then walk = legs[i] end
			end
			local g = N.GetRouteGeometry().legs
			local last = g[#g]
			return { lands = fly and fly.to.name, yards = walk.yards, engine = walk.engine or false, kind = last.kind, n = #last.pts,
				first = { last.pts[1][2], last.pts[1][3] }, final = { last.pts[#last.pts][2], last.pts[#last.pts][3] } }
		end
		N.SetTarget(1440, 40, 70, "Fitz's marker", "e")
		local cold = aim()
		-- (The arrow points straight at the marker meanwhile: no route or line drawn.)
		local r = { cold = cold.state, unchecked = route() ~= nil or #N.GetRouteGeometry().legs > 0 }
		for _ = 1, 400 do
			stub.advance(0.05); aim()
			r.after = route()
			if r.after and r.after.engine == "path" then break end
		end
		local tc, tx, ty, tz = N.GetTargetWorld()
		r.target = { tx, ty }
		r.splinter = { splinter.wx, splinter.wy }
		local cost = N.walk.Measured(tc, tx, ty, false, tz)
		r.measured = { sun = cost(1, sun.wx, sun.wy, false, sun.z), splinter = cost(1, splinter.wx, splinter.wy, false, splinter.z) }
		r.straight = { sun = dist(sun.wx, sun.wy, tx, ty), splinter = dist(splinter.wx, splinter.wy, tx, ty) }
		-- The engine's walk from Sun Rock Retreat: how far it runs from the straight line over the ridge.
		local pts = E.FindSync(1, { x = sun.wx, y = sun.wy }, { x = tx, y = ty })
		local dx, dy = tx - sun.wx, ty - sun.wy
		local off = 0
		for _, p in ipairs(pts) do
			local s = math.max(0, math.min(1, ((p.x - sun.wx) * dx + (p.y - sun.wy) * dy) / (dx * dx + dy * dy)))
			off = math.max(off, dist(sun.wx + dx * s, sun.wy + dy * s, p.x, p.y))
		end
		r.sunPath = { length = length(pts), off = off }
		emit(r)"#,
		true,
	);
	let gap = |a: &Value, b: &Value| (f(&a[0]) - f(&b[0])).hypot(f(&a[1]) - f(&b[1]));
	assert_eq!(out["cold"], "routing");
	assert_eq!(out["unchecked"], false, "no unchecked flight or straight line before the landing walk is priced");
	let (m_sun, m_spl) = (f(&out["measured"]["sun"]), f(&out["measured"]["splinter"]));
	assert!(
		f(&out["sunPath"]["off"]) > 150.0,
		"the engine's walk from Sun Rock Retreat runs {:.0} yd off that straight line ({:.0} yd against {:.0} straight)",
		f(&out["sunPath"]["off"]),
		f(&out["sunPath"]["length"]),
		f(&out["straight"]["sun"])
	);
	assert!(m_sun > m_spl + 150.0, "measured: Sun Rock Retreat {m_sun:.0} yd, Splintertree Post {m_spl:.0} yd (straight {:.0} and {:.0})", f(&out["straight"]["sun"]), f(&out["straight"]["splinter"]));
	let after = &out["after"];
	assert_eq!(after["lands"], "Splintertree Post, Ashenvale", "the terrain favours Splintertree Post");
	assert_eq!(after["engine"], "path", "its last walk is priced by its path");
	assert_eq!(after["kind"], "walk");
	assert!(f(&after["n"]) > 2.0, "drawn along the engine's {} points, not straight", after["n"]);
	assert!(gap(&after["first"], &out["splinter"]) < 15.0 && gap(&after["final"], &out["target"]) < 15.0, "from Splintertree Post to the marker");
	assert!((f(&after["yards"]) - m_spl).abs() < m_spl * 0.15, "{} yd along the path, {m_spl:.0} measured", after["yards"]);
}

// Both Ashenvale flights are known and affordable. The ridge reverses the choice
// made using straight lines at one marker; neither landing reaches the other.
#[test]
fn ashenvale_west_of_astranaar_prices_safe_walks_before_suggesting_a_flight() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		w.setLevel(1)
		w.setMoney(530)
		Polestar.CharState().flags.taxi = { [22] = true, [23] = true, [25] = true, [58] = true, [61] = true, [77] = true }
		Polestar.CharState().flags.taxiSeen = { [1] = true }
		local data = N.GetTravelData()
		local by, flights = data.taxiById, data.flights[25]
		local xr = by[25]
		place(xr.map, xr.wx, xr.wy)
		local function flightTime(id)
			for i = 1, #flights, 2 do if flights[i] == id then return flights[i+1] / 30 + 2 end end
			error("missing direct flight")
		end
		local function scene(x, y, refused)
			N.SetTarget(1440, x, y, "Behind the ridge", "e")
			local c, tx, ty, tz = N.GetTargetWorld()
			local pending = aim()
			assert(pending.state == "routing" and not N.GetRoute() and #N.GetRouteGeometry().legs == 0,
				"offered an itinerary before its onward walk was priced")
			for _ = 1, 600 do
				local legs, ci = N.GetRoute()
				if legs and legs[ci].kind == "fly" then
					local n, cost = legs[ci].to, N.walk.Measured(c, tx, ty, false, tz)
					assert(not refused and cost and type(cost(c, n.wx, n.wy, false, n.z)) == "number", "sold an unchecked landing")
				end
				stub.advance(.05); aim()
			end
			local cost = assert(N.walk.Measured(c, tx, ty, false, tz))
			local straight, measured = {}, {}
			for _, id in ipairs({58, 61}) do
				local n = by[id]
				local price, _, policy = cost(c, n.wx, n.wy, false, n.z)
				if refused then
					assert(price == false, "landing did not explicitly refuse the walk")
				else
					assert(type(price) == "number" and policy.profile == "Horde" and policy.walkLevel == 1)
					straight[id] = flightTime(id) + 1.25*dist(n.wx, n.wy, tx, ty)/7
					measured[id] = flightTime(id) + price/7
				end
			end
			local legs, ci = N.GetRoute()
			local drawn = N.GetRouteGeometry().legs
			if refused then
				-- #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
				assert(not legs and aim().state == "travel" and N.noWalk ~= nil and #drawn == 1)
			else
				assert(straight[58] < straight[61] and measured[58] > measured[61], "terrain must reverse the landing")
				assert(legs[ci].kind == "fly" and legs[ci].to.id == 61 and legs[ci+1].engine == "path")
				local pts = drawn[#drawn].pts
				assert(drawn[#drawn].kind == "walk" and #pts > 2)
				assert(dist(pts[1][2], pts[1][3], by[61].wx, by[61].wy) < 1 and dist(pts[#pts][2], pts[#pts][3], tx, ty) < 1)
				for i = 2, #pts do assert(not N.danger.Blocked(c, pts[i-1][2], pts[i-1][3], pts[i][2], pts[i][3], "Horde")) end
			end
		end
		scene(30, 70, false)
		scene(35, 75, true)
		emit(true)"#,
		true,
	);
	assert_eq!(out, true);
}

// The road share of a drawn line, as `nav eval` measures it (tools/lib/nav/eval/metrics.js offRoad): a line piece
// (<= 2 yd) is on the road when a road column (weight 128+) of data/local/nav-layers/roads lies within 8 yd of it;
// pieces over columns the layer does not know are left out. None when the layer is not built.
struct Roads {
	dir: PathBuf,
	tiles: HashMap<String, Option<Vec<u8>>>,
}

const ADT: f64 = 1600.0 / 3.0;
const TILE_CELLS: f64 = 256.0;
const CELL: f64 = ADT / TILE_CELLS;

impl Roads {
	fn load() -> Option<Roads> {
		let dir = forge_addontest::run::root().join("data/local/nav-layers/roads");
		dir.exists().then(|| Roads { dir, tiles: HashMap::new() })
	}
	fn at(&mut self, c: i64, wx: f64, wy: f64) -> Option<u8> {
		let gi = ((32.0 * ADT - wy) / CELL).floor() as i64;
		let gj = ((32.0 * ADT - wx) / CELL).floor() as i64;
		let (col, row) = (gi.div_euclid(256), gj.div_euclid(256));
		let (i, j) = (gi - col * 256, gj - row * 256);
		let key = format!("{c}/{col}_{row}");
		let dir = &self.dir;
		let t = self.tiles.entry(key).or_insert_with(|| std::fs::read(dir.join(c.to_string()).join(format!("{col}_{row}.bin"))).ok());
		t.as_ref().and_then(|t| t.get((j * 256 + i) as usize).copied())
	}
	fn on_road(&mut self, pts: &[(f64, f64)], map: i64) -> f64 {
		let reach = (8.0 / CELL).ceil() as i64;
		let mut around = Vec::new();
		for dx in -reach..=reach {
			for dy in -reach..=reach {
				if (dx as f64).hypot(dy as f64) * CELL <= 8.0 {
					around.push((dx as f64 * CELL, dy as f64 * CELL));
				}
			}
		}
		let (mut off, mut known) = (0.0, 0.0);
		for w in pts.windows(2) {
			let ((ax, ay), (bx, by)) = (w[0], w[1]);
			let l = (bx - ax).hypot(by - ay);
			let n = (l / 2.0).ceil().max(1.0) as usize;
			for k in 0..n {
				let t = (k as f64 + 0.5) / n as f64;
				let (x, y) = (ax + (bx - ax) * t, ay + (by - ay) * t);
				if self.at(map, x, y).is_none() {
					continue;
				}
				known += l / n as f64;
				if !around.iter().any(|(dx, dy)| self.at(map, x + dx, y + dy).unwrap_or(0) >= 128) {
					off += l / n as f64;
				}
			}
		}
		1.0 - if known > 0.0 { off / known } else { 0.0 }
	}
}

fn line_length(pts: &[(f64, f64)]) -> f64 {
	pts.windows(2).map(|w| (w[1].0 - w[0].0).hypot(w[1].1 - w[0].1)).sum()
}

// Route styles (nav.routeStyle, Nav/Walk.lua): the corpus route road-goldshire-sentinelhill walked by the arrow in
// Balanced, then switched to Roads mid-walk. The road share is nav eval's offRoad (8 yd of a road column of
// data/local/nav-layers/roads), checked only where that layer is built, against the spec's acceptance for this route
// (off road at most 0.2; on the shipped maps Roads is about 89% on road, Balanced about 45%).
#[test]
fn route_styles_goldshire_to_sentinel_hill_keeps_to_the_road_with_roads_and_cuts_across_with_balanced_switching_mid_walk_searches_again() {
	skip_unless_ready!();
	let out = run(
		r#"
		-- The whole walk is the arrow's (the corpus route): the planner, which walks
		-- the Elwynn-Westfall crossing by hand, is off.
		Polestar.Set("nav.travel", false)
		Polestar.Set("nav.routeStyle", "balanced")
		w.moveTo(1429, 42, 65)
		w.z = nil
		N.SetTarget(1436, 56.5, 47.5, "Sentinel Hill")
		local target = N.GetTarget()
		local _, tx, ty = N.GetTargetWorld()
		-- The arrow's own walk to the target, once a search after the first 'after' is in.
		local function settle(after)
			for _ = 1, 600 do
				aim()
				local f = finds[#finds]
				if #finds > after and f.done and dist(f.to[1], f.to[2], tx, ty) < 1 then return f end
				stub.advance(0.05)
			end
		end
		local function line(f)
			local pts = {}
			for i, p in ipairs(f.points or {}) do pts[i] = { p.x, p.y, p.z or false } end
			return pts
		end
		local function drawn()
			local n, legs = 0, N.GetRouteGeometry().legs
			for _, leg in ipairs(legs) do if leg.kind == "walk" then n = n + #leg.pts end end
			return { points = n, legs = #legs }
		end
		local r = {}
		local bal = settle(0)
		assert(bal, "the Balanced walk is never in")
		r.balanced = { style = bal.style or false, map = bal.map, pts = line(bal), drawn = drawn() }
		local before = #finds
		Polestar.Set("nav.routeStyle", "roads")
		aim()
		r.switched = { drawn = drawn(), sameTarget = N.GetTarget() == target }
		local road = settle(before)
		r.roads = road and { style = road.style or false, map = road.map, pts = line(road), from = dist(road.from[1], road.from[2], bal.from[1], bal.from[2]), drawn = drawn() } or false
		r.sameTarget = N.GetTarget() == target
		emit(r)"#,
		true,
	);
	assert_eq!(out["balanced"]["style"], "balanced", "the Balanced walk is searched in Balanced");
	assert!(out["roads"].is_object(), "the switch searched the walk again");
	assert_eq!(out["roads"]["style"], "roads", "in Roads");
	let pts = |rec: &Value| -> Vec<(f64, f64)> { rec["pts"].as_array().unwrap().iter().map(|p| (f(&p[0]), f(&p[1]))).collect() };
	let balanced = pts(&out["balanced"]);
	let roads = pts(&out["roads"]);
	assert!(out["sameTarget"] == true && out["switched"]["sameTarget"] == true, "without a new target");
	assert!(f(&out["roads"]["from"]) < 1.0, "from where the player stands");
	assert!(f(&out["balanced"]["drawn"]["points"]) > 2.0 * f(&out["balanced"]["drawn"]["legs"]), "the Balanced walk is drawn along its path");
	assert_eq!(f(&out["switched"]["drawn"]["points"]), 0.0, "the switch drops the Balanced line without drawing an unchecked shortcut");
	assert_ne!(out["roads"]["pts"], out["balanced"]["pts"], "the Roads walk differs from the Balanced one");
	let (lb, lr) = (line_length(&balanced), line_length(&roads));
	eprintln!("Balanced {lb:.0} yd, Roads {lr:.0} yd");
	assert!(lr > lb, "the Roads walk ({lr:.0} yd) is longer than the Balanced one ({lb:.0} yd)");
	let Some(mut layer) = Roads::load() else {
		eprintln!("no data/local/nav-layers/roads: the road share is not checked");
		return;
	};
	let sr = layer.on_road(&roads, out["roads"]["map"].as_i64().unwrap());
	let sb = layer.on_road(&balanced, out["balanced"]["map"].as_i64().unwrap());
	eprintln!("on road: Balanced {:.1}%, Roads {:.1}%", sb * 100.0, sr * 100.0);
	assert!(sr >= 0.8, "the Roads walk keeps {:.1}% of its length within 8 yd of a road (off road at most 0.2)", sr * 100.0);
	assert!(sb < sr, "the Balanced walk's road share ({:.1}%) is lower", sb * 100.0);
}

// Zone danger (#195, Nav/Danger.lua, Nav/Walk.lua): a level 20 Horde character in Tirisfal (75.92,68.39, the live
// frame) walking to the Spring Well (Hillsbrad 62.18,20.79, the guides' Era frame). Without danger the router's way
// runs through Western Plaguelands (uiMap 1422, 51+); with the addon's danger table the drawn walk keeps out of it,
// sampled every 20 yd with Path.ZoneAt.
#[test]
fn zone_danger_195_tirisfal_to_the_spring_well_at_level_20_as_horde_walks_no_yard_of_western_plaguelands() {
	skip_unless_ready!();
	let out = run(
		r#"
		Polestar.Set("nav.travel", false)
		w.setLevel(20)
		w.faction = "Horde"
		w.moveTo(1420, 75.92, 68.39)
		w.z = nil
		N.SetTarget(1424, 62.18, 20.79, "The Spring Well", "e")
		local _, tx, ty = N.GetTargetWorld()
		local f
		for _ = 1, 1200 do
			aim()
			local last = finds[#finds]
			if last and last.done and dist(last.to[1], last.to[2], tx, ty) < 1 then f = last break end
			stub.advance(0.05)
		end
		assert(f and f.points and #f.points > 1, "the walk is never in")
		-- Yards of a line, and of it in zone 1422 (sampled every 20 yd).
		local function measure(map, pts)
			local yards, wpl = 0, 0
			for i = 2, #pts do
				local ax, ay, bx, by = pts[i - 1][1], pts[i - 1][2], pts[i][1], pts[i][2]
				local d = dist(ax, ay, bx, by)
				yards = yards + d
				local n = math.max(1, math.ceil(d / 20))
				for k = 0, n - 1 do
					local s = (k + 0.5) / n
					if E.ZoneAt(map, ax + (bx - ax) * s, ay + (by - ay) * s) == 1422 then wpl = wpl + d / n end
				end
			end
			return { yards = floor(yards + 0.5), wpl = floor(wpl + 0.5) }
		end
		local drawn = {}
		for _, leg in ipairs(N.GetRouteGeometry().legs) do
			if leg.kind == "walk" then
				for _, p in ipairs(leg.pts) do drawn[#drawn + 1] = { p[2], p[3] } end
			end
		end
		local o = f.opts or {}
		local danger = {}
		for id, m in pairs(o.danger or {}) do danger[#danger + 1] = id .. "=" .. m end
		table.sort(danger)
		local r = { map = f.map, profile = o.profile or false, danger = table.concat(danger, ","),
			startZone = E.ZoneAt(f.map, f.from[1], f.from[2]) or false, goalZone = E.ZoneAt(f.map, tx, ty) or false }
		local line = {}
		for i, p in ipairs(f.points) do line[i] = { p.x, p.y } end
		r.after = measure(f.map, line)
		r.drawn = measure(f.map, drawn)
		-- The same walk without danger: what #195 reported.
		local pts = E.FindSync(f.map, { x = f.from[1], y = f.from[2], z = f.from[3] }, { x = f.to[1], y = f.to[2], z = f.to[3] }, { profile = o.profile, style = o.style })
		local before = {}
		for i, p in ipairs(pts or {}) do before[i] = { p.x, p.y } end
		r.before = measure(f.map, before)
		emit(r)"#,
		true,
	);
	eprintln!("without danger {} yd ({} in Western Plaguelands); with it {} yd ({})", out["before"]["yards"], out["before"]["wpl"], out["after"]["yards"], out["after"]["wpl"]);
	assert_eq!(out["profile"], "Horde");
	assert_eq!(out["startZone"], 1420, "the walk starts in Tirisfal");
	assert_eq!(out["goalZone"], 1424, "and ends in Hillsbrad");
	assert!(Regex::new(r"(^|,)1422=20(,|$)").unwrap().is_match(out["danger"].as_str().unwrap()), "Western Plaguelands is far above level 20 (x20): {}", out["danger"]);
	assert!(f(&out["before"]["wpl"]) > 0.0, "without danger the walk crosses Western Plaguelands (#195)");
	assert_eq!(out["after"]["wpl"], 0, "with it the searched walk keeps out");
	assert_eq!(out["drawn"]["wpl"], 0, "and so does the drawn line");
	assert!(f(&out["drawn"]["yards"]) > 0.0);
}

// The walking floor (#234, Ruling 36). Forever's UnitPosition gives no height (z 0), so a search from the player
// started on whichever surface near them was cheapest: at the Den's camp in the Valley of Trials (the reporter's
// 42.9,67.6) the rock top over the Den (z 73), whence Fastest crossed the hill to Hana'zua through the pass. Walk now
// follows the surface under the player (Path.SurfacesAt) and starts the search from it. FLOOR_WALK walks the player
// in 2 yd steps 0.3 s apart to each point of a list, the arrow sampling each step, with UnitPosition's z 0.
const FLOOR_WALK: &str = r#"
local function walkTo(map, pts)
	local _, x0, y0 = C.GetPlayerWorldPosition()
	for _, p in ipairs(pts) do
		local n = math.max(1, math.ceil(dist(x0, y0, p[1], p[2]) / 2))
		for i = 1, n do
			place(map, x0 + (p[1] - x0) * i / n, y0 + (p[2] - y0) * i / n, 0)
			stub.advance(0.3)
			aim()
		end
		x0, y0 = p[1], p[2]
	end
end
-- The arrow's walk to (map, wx, wy) at height z, once its search is in.
local function walkFor(map, wx, wy, label, z)
	local c = C_Map.GetWorldPosFromMapPos(map, CreateVector2D(0.5, 0.5))
	local x, y = C.WorldToMap(c, wx, wy, map)
	local before = #finds
	N.SetTarget(map, x, y, label, nil, "npc", z)
	for _ = 1, 1200 do
		aim()
		local f = finds[#finds]
		if #finds > before and f.done and dist(f.to[1], f.to[2], wx, wy) < 1 then return f end
		stub.advance(0.05)
	end
end
-- The highest point of a search's line within r yd of (x, y).
local function highest(f, x, y, r)
	local top = -math.huge
	for _, p in ipairs(f.points or {}) do
		if p.z and dist(p.x, p.y, x, y) <= r and p.z > top then top = p.z end
	end
	return top
end
"#;

fn floor_den(style: &str) {
	skip_unless_ready!();
	// DEN: the reporter's spot at the Den's camp (ground z 39.2, the rock top 73 within a cell); HANAZUA: the goal.
	let script = r#"
		Polestar.Set("nav.travel", false)
		Polestar.Set("nav.routeStyle", "@STYLE")
		w.setLevel(3)
		w.faction = "Horde"
		local DEN, HANAZUA = { -574.567, -4230.838 }, { -397.8, -4109, 50.3 }
		local r = {}
		-- No history: standing at the camp from the first sample.
		place(1411, DEN[1], DEN[2], 0)
		local f = walkFor(1411, HANAZUA[1], HANAZUA[2], "Hana'zua", HANAZUA[3])
		r.fresh = { z = f.from[3] or false, top = highest(f, DEN[1], DEN[2], 60), yards = floor(length(f.points)) }
		-- Walked in: from 42 yd out on the valley floor (one surface, z 38), a walk the arrow follows.
		N.SetTarget(1411, 30, 70, "Valley")
		place(1411, DEN[1] - 30, DEN[2] - 30, 0)
		stub.advance(3)
		aim()
		walkTo(1411, { { DEN[1], DEN[2] } })
		f = walkFor(1411, HANAZUA[1], HANAZUA[2], "Hana'zua", HANAZUA[3])
		r.walked = { z = f.from[3] or false, top = highest(f, DEN[1], DEN[2], 60), yards = floor(length(f.points)) }
		emit(r)"#
		.replace("@STYLE", style);
	let out = run(&format!("{FLOOR_WALK}{script}"), true);
	eprintln!(
		"{style}: no history {} yd (highest within 60 yd of the start {}); walked in {} yd ({}), from z {}",
		out["fresh"]["yards"], out["fresh"]["top"], out["walked"]["yards"], out["walked"]["top"], out["walked"]["z"]
	);
	assert_eq!(out["fresh"]["z"], false, "no walking history: searched without a height, as before");
	assert!((f(&out["walked"]["z"]) - 39.2).abs() <= 3.0, "walked in: searched from the camp's ground ({})", out["walked"]["z"]);
	assert!(f(&out["walked"]["top"]) <= 55.0, "and the drawn line never stands on the rock top (highest within 60 yd: {})", out["walked"]["top"]);
}

#[test]
fn t_234_floor_fastest_at_the_dens_camp_walked_in_from_the_valley_floor_the_walk_to_hanazua_never_starts_on_the_rock_top() {
	floor_den("fastest");
}

#[test]
fn t_234_floor_balanced_at_the_dens_camp_walked_in_from_the_valley_floor_the_walk_to_hanazua_never_starts_on_the_rock_top() {
	floor_den("balanced");
}

// #1784: Silverpine Forest's covered bridge north-east of the Sepulcher (deck 56, the river at 33, the roof and its
// eaves at 60-64). Walked onto from the south bank (60) along its west side, the floor follow took the eave a yard or
// two above the bank (nearer than the deck) and climbed the roof; the arrow's walk on from there to the Hardened Tumor
// (north-east) turned back south to the bank first. Now on a bridge the follow keeps the deck.
#[test]
fn t_1784_floor_walked_onto_silverpines_covered_bridge_from_the_south_bank_the_walk_north_starts_on_the_deck_not_the_roof() {
	skip_unless_ready!();
	let script = r#"
		Polestar.Set("nav.travel", false)
		w.setLevel(17)
		w.faction = "Horde"
		local r = {}
		-- From the bank south of the bridge (one surface, z 60), north along its west side to the middle of the deck.
		N.SetTarget(1421, 50, 20, "North")
		place(1421, 818, 1364, 0)
		stub.advance(3)
		aim()
		walkTo(1421, { { 843, 1364 } })
		local f = walkFor(1421, 991.9, 1043.4, "Hardened Tumor", nil)
		local south = math.huge
		for _, p in ipairs(f.points or {}) do if p.x < south then south = p.x end end
		r.z = f.from[3] or false
		r.south = south
		r.top = highest(f, 843, 1364, 15)
		emit(r)"#;
	let out = run(&format!("{FLOOR_WALK}{script}"), true);
	eprintln!("from z {}, southernmost path point {}, highest within 15 yd {}", out["z"], out["south"], out["top"]);
	assert!((f(&out["z"]) - 56.0).abs() <= 3.0, "the walk starts on the deck ({})", out["z"]);
	assert!(f(&out["south"]) >= 838.0, "and never turns back south off the bridge ({})", out["south"]);
	assert!(f(&out["top"]) <= 59.0, "nor stands on the roof ({})", out["top"]);
}

// The pattern sweep's worst Undercity start (hop|forever/class/rogue/plundering-the-plunderers|17, real z -62.2, its
// column -62/5/63): a player who rode the south lift down (the floor unknown at a lift) and walked to it along the
// router's own way, indoors (IsIndoors), keeps the lower level.
#[test]
fn t_234_floor_off_the_undercitys_south_lift_indoors_the_walk_to_the_plundering_start_keeps_the_lower_level_and_the_search_from_there_starts_on_it() {
	skip_unless_ready!();
	let out = run(
		&format!(
			"{FLOOR_WALK}{}",
			r#"
		Polestar.Set("nav.travel", false)
		w.setLevel(16)
		w.faction = "Horde"
		IsIndoors = function() return 1 end
		local START = { 1435.6, 72, -62.2 }
		local LIFT = { 1544.2, 240.8, -41 }
		local way = E.FindSync(0, { x = LIFT[1], y = LIFT[2], z = LIFT[3] }, { x = START[1], y = START[2], z = START[3] }, { profile = "Horde" })
		local pts = {}
		for i = 2, #way do pts[#pts + 1] = { way[i].x, way[i].y } end
		place(1420, LIFT[1], LIFT[2], 0)
		local mx, my = C.WorldToMap(0, START[1], START[2], 1420)
		local before = #finds
		N.SetTarget(1420, mx, my, "The plundering start", nil, "npc")
		for _ = 1, 100 do aim(); stub.advance(.05) end
		local a = aim()
		local r = { atLift = N.walk.Floor(0, LIFT[1], LIFT[2]) or false,
			atLiftAim = a.state, atLiftBearing = a.x ~= nil, atLiftFinds = #finds - before }
		walkTo(1420, pts)
		local f = walkFor(1420, -160.1, 774.2, "The plundering goal")
		local first = f.points and f.points[2]
		r.walked = { z = f.from[3] or false, top = highest(f, START[1], START[2], 60), yards = floor(length(f.points or {})), second = first and first.z or false }
		a = aim()
		r.lowerAim = a.measured and a.x and offPath(f.points, a.x, a.y) < .02 or false
		-- At the same horizontal position, an observed upper floor wins over any trail.
		place(1420, LIFT[1], LIFT[2], 55.2)
		f = walkFor(1420, START[1], START[2], "The plundering start", START[3])
		r.wrong = { from = f.from[3], answer = f.cost, bearing = aim().x ~= nil }
		emit(r)"#
		),
		true,
	);
	eprintln!("at the lift {}; walked in: from z {}, highest within 60 yd {}, {} yd", out["atLift"], out["walked"]["z"], out["walked"]["top"], out["walked"]["yards"]);
	assert_eq!(out["atLift"], false, "at the lift the floor is unknown");
	// #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
	assert_eq!(out["atLiftAim"], "travel");
	assert_eq!(out["atLiftBearing"], true);
	assert_eq!(out["atLiftFinds"], 0, "no flat search can tell which deck the player is standing on");
	assert_eq!(out["lowerAim"], true, "the walking bearing follows the lower-floor path");
	// #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
	assert_eq!(out["wrong"], serde_json::json!({"from":55.2, "answer":"no safe walking route", "bearing":true}));
	assert!((f(&out["walked"]["z"]) + 62.2).abs() <= 3.0, "searched from the lower level ({})", out["walked"]["z"]);
	assert!(f(&out["walked"]["top"]) < -20.0, "the drawn line's first 60 yd stay down there (highest {})", out["walked"]["top"]);
}

// Lifts (Fitz, 2026-10-23): the walking grid has no link between a lift's landings, so from the Undercity's lower
// floor to Brill the walk went out through the sewers. The router joins the landings of Polestar_Nav's lift
// chokepoints; the way in and out is one fixed chain (crossings.json, undercity-south-lift: Fitz's own walk), from the
// south lift's bottom landing up through the entrance hall and out of the front, both ways (its three nodes over the
// Ruins' courtyard and gate since 2026-10-25: three more legs out).
#[test]
fn lifts_from_the_undercitys_lower_floor_to_brill_the_walk_goes_to_the_south_lift_rides_it_up_and_follows_the_fixed_way_out_from_brill_in_the_same_way_down() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(20)
		w.faction = "Horde"
		IsIndoors = function() return 1 end
		place(1458, 1575, 240, -43) -- no supporting floor at this supplied height on the ring
		N.SetTarget(1420, 61.9, 52.3, "Brill")
		for _ = 1, 600 do
			aim()
			stub.advance(0.05)
		end
		local legs, ci = N.GetRoute()
		local route = {}
		for i = ci, #legs do route[#route + 1] = legs[i].kind .. "|" .. legs[i].label end
		-- The plan names the correct boarding point; that does not certify the walk to it.
		local f
		for _, rec in ipairs(finds) do
			if dist(rec.from[1], rec.from[2], 1575, 240) < 5 then f = rec end
		end
		local r = { route = route, to = { r1(f.to[1]), r1(f.to[2]), f.to[3] },
			approach = { f.cost, f.points ~= nil, aim().x ~= nil } }
		-- Observe the player at each landing, independently of the refused approach.
		IsFalling = function() return false end
		local function at(x, y, z)
			place(1458, x, y, z)
			local state = N.Sample()
			local leg = N.travel.CurrentLeg()
			return { state, leg.kind, N.travel.CurrentLabel():match("^[^\n]+") }
		end
		-- With a height from the client, its deck rule (240b852ada).
		r.wrongBoard = at(1553.1, 240.6, 55.2) -- above the planned boarding deck, still on the walk
		r.board = at(1544.8, 240.6, -41.4)
		r.retreat = at(1512, 240.6, -41.4)
		r.receive = at(1553.1, 240.6, 55.2)
		r.leave = at(1586, 241.2, 60)
		-- With no height (Forever's UnitPosition gives 0, read as none): the 2D rule, as before 0.4.2 (Main,
		-- 2026-11-21: every 0.4.2 report shows height 0, so the deck rule is dormant on real clients).
		N.ClearTarget()
		place(1458, 1575, 240, 0)
		N.SetTarget(1420, 61.9, 52.3, "Brill")
		for _ = 1, 600 do aim() stub.advance(0.05) end
		r.unknownApproach = at(1520, 240.6, 0) -- 25 yd off the landing: the ride is shown
		r.unknownBoard = at(1544.8, 240.6, 0) -- at the boarding landing
		r.unknownRide = at(1548, 240.6, 0) -- on the car, either deck
		r.unknownLeave = at(1586, 241.2, 0) -- 41 yd off the boarding landing: the ride is over
		-- And back in: from Brill's road to the canal by the auction house.
		place(1420, 2262, 236, 34)
		N.SetTarget(1458, 59.17, 39.05, "The canal") -- by the auction house: no hall over it (a target with no height under the hall is taken for the hall)
		for _ = 1, 600 do aim() stub.advance(0.05) end
		legs, ci = N.GetRoute()
		r.back = {}
		for i = ci, #legs do r.back[#r.back + 1] = legs[i].kind .. "|" .. legs[i].label end
		emit(r)"#,
		true,
	);
	let want = [
		"walk|Walk to the lift",
		"lift|Ride the elevator up",
		"walk|Follow the path out",
		"walk|Follow the path out",
		"walk|Follow the path out",
		"walk|Follow the path out",
		"walk|Follow the path out",
		"walk|Follow the path out",
		"walk|Follow the path out",
		"walk|Follow the path out",
		"walk|Brill",
	];
	assert_eq!(strs(&out["route"]), want, "to the south lift, up, and out along the fixed way");
	assert_eq!(out["to"], serde_json::json!([1544.8, 240.6, -41.4]), "the request is for the lower landing");
	// #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
	assert_eq!(out["approach"], serde_json::json!(["no safe walking route", false, true]));
	assert_eq!(out["unknownApproach"], serde_json::json!(["travel", "walk", "Ride the elevator up"]));
	assert_eq!(out["unknownBoard"], serde_json::json!(["instruction", "lift", "Ride the elevator up"]));
	assert_eq!(out["unknownRide"], serde_json::json!(["instruction", "lift", "Ride the elevator up"]));
	assert_eq!(out["unknownLeave"], serde_json::json!(["travel", "walk", "Follow the path out"]));
	assert_eq!(out["wrongBoard"], serde_json::json!(["travel", "walk", "Walk to the lift"]));
	for stage in ["board", "retreat", "receive"] {
		assert_eq!(out[stage], serde_json::json!(["instruction", "lift", "Ride the elevator up"]), "{stage}");
	}
	assert_eq!(out["leave"], serde_json::json!(["travel", "walk", "Follow the path out"]));
	let back = strs(&out["back"]);
	let down = back.iter().position(|s| s == "lift|Ride the elevator down");
	assert!(down.is_some_and(|d| d > 0 && back[d - 1] == "walk|Walk to the lift"), "in by the same way, down the south lift: {}", back.join(", "));
	assert_eq!(back.last().map(String::as_str), Some("walk|The canal"));
}

// The Mesa Elevator with no height from the client, as on Forever (every 0.4.2 report says "height zero"). On the way
// from Red Rocks up to Cairne's tent, 0.4.2 said "The last steps here aren't mapped" at the elevator's bottom landing
// and never showed the ride (the deck rule of 240b852ada needs the client's height). Main, 2026-11-21: with no height
// the lift takes 0.4.1.1's 2D rule: the ride is shown within 30 yd of its landing and is over 30 yd from it. The player
// stands at the foot of the bluff (the route's first crossing end from Red Rocks), where the walk up is split at the lift.
#[test]
fn lifts_with_no_client_height_red_rocks_to_cairnes_tent_rides_the_mesa_elevator_and_walks_on_from_the_top() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(10)
		w.faction = "Horde"
		place(1412, -964.8, -116.5, 0) -- the foot of the bluff, on the way from Red Rocks
		N.SetTarget(1456, 60.3, 51.7, "Cairne's tent", "e")
		for _ = 1, 600 do aim() stub.advance(0.05) end
		local legs, ci = N.GetRoute()
		local route, lift = {}, nil
		for i = ci, #(legs or {}) do
			route[#route + 1] = legs[i].kind
			if legs[i].kind == "lift" and not lift then lift = legs[i] end
		end
		local r = { route = route, height = C.PlayerHeight() }
		if lift then
			local f = lift.from
			local function at(x, y)
				place(1412, x, y, 0)
				local state = N.Sample()
				local leg = N.travel.CurrentLeg()
				return { state, leg and leg.kind or false, (N.travel.CurrentLabel() or ""):match("^[^\n]+") or "" }
			end
			-- toward the target, on the map: the top deck is over the bottom one
			local _, tx, ty = C.MapToWorld(1456, 60.3, 51.7, "e")
			local d = dist(f.wx, f.wy, tx, ty)
			local ux, uy = (tx - f.wx) / d, (ty - f.wy) / d
			r.board = at(f.wx, f.wy)
			r.ride = at(f.wx + ux * 3, f.wy + uy * 3)
			r.leave = at(f.wx + ux * 35, f.wy + uy * 35)
		end
		emit(r)"#,
		true,
	);
	assert_eq!(out["height"], "zero", "the stub gives Forever's height of 0");
	assert!(strs(&out["route"]).iter().any(|k| k == "lift"), "the way up rides a lift: {}", strs(&out["route"]).join(", "));
	assert_eq!(out["board"], serde_json::json!(["instruction", "lift", "Ride the elevator up"]), "at the bottom landing the ride is shown");
	assert_eq!(out["ride"], serde_json::json!(["instruction", "lift", "Ride the elevator up"]), "on the car, still the ride");
	assert_eq!(out["leave"][1], "walk", "30 yd off the landing the ride is over and the walk goes on: {}", out["leave"]);
}

// #2516 (Trak, 0.4.0 triage): at the Ruins of Lordaeron's portal (Tirisfal 63.2,67.5, live), where the client reports
// the Undercity's map, the route went to the Undervator, down into the city, along to the south lift and up it, out
// along the fixed way and back to the portal: 1.1k yd for a few. The near walk (#1543) was off because the south
// lift's chain joins the Undercity and Tirisfal; with the player's floor 70 yd above the chain's bottom landing, the
// walk goes straight there. From the city's floor the way out stays the lift (the test above).
#[test]
fn ruins_of_lordaeron_at_the_portal_on_the_undercitys_map_the_route_walks_to_it_never_down_the_undervator_2516() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(20)
		w.faction = "Horde"
		place(1458, 1797, 180, 71) -- a few yards from the portal, on the corridor's floor
		N.SetTarget(1420, 63.2, 67.5, "Ruins of Lordaeron", "l")
		for _ = 1, 600 do
			aim()
			stub.advance(0.05)
		end
		local legs, ci = N.GetRoute()
		local route = {}
		for i = ci or 1, #(legs or {}) do route[#route + 1] = legs[i].kind .. "|" .. legs[i].label end
		emit({ map = C_Map.GetBestMapForUnit("player"), route = route })"#,
		true,
	);
	assert_eq!(out["map"], serde_json::json!(1458), "the client reports the Undercity's map there");
	assert_eq!(strs(&out["route"]), ["walk|Ruins of Lordaeron"], "one walk to the portal");
}

// Fitz's spot (2026-10-23): the Trade Quarter's centre, 12 yd on the map from the crossing's end in the entrance hall
// above it (r 30). The planner dropped the walk to that end as already walked and the arrow went on along the
// crossing's hand-made walk, straight north through the Ruins' footprint. An end with a height is reached only on its
// floor: the player's (the client's height, else the followed floor, Walk.Floor) within 20 yd of it; with the floor
// unknown, within 5 yd. Every Undercity cell has indoor layers more than 10 yd apart, so the floor is found by walking
// (Nav/Walk.lua's candidate floors): a few steps on the ring.
#[test]
fn lifts_at_the_trade_quarters_centre_under_the_entrance_hall_the_walk_to_brill_still_rides_a_lift_up_and_a_few_steps_on_the_ring_find_the_floor() {
	skip_unless_ready!();
	let out = run(
		&format!(
			"{FLOOR_WALK}{}",
			r#"
		w.setLevel(20)
		w.faction = "Horde"
		IsIndoors = function() return 1 end
		local function route()
			local legs, ci = N.GetRoute()
			local out = {}
			for i = ci, #legs do out[#out + 1] = legs[i].kind .. "|" .. legs[i].label .. (legs[i].handmade and " (hand-made)" or "") end
			return out
		end
		local function settle() for _ = 1, 400 do aim() stub.advance(0.05) end end
		local r = {}
		place(1458, 1631.17, 245.19, 0) -- no height (Forever's client), the floor not followed yet: just logged in
		N.SetTarget(1420, 61.9, 52.3, "Brill")
		settle()
		r.unknown = route()
		walkTo(1458, { { 1629, 238 }, { 1625, 228 }, { 1620, 218 }, { 1615, 206 }, { 1612, 200 } }) -- along the ring's floor
		settle()
		r.walked = route()
		-- Away and back (the floor followed is dropped), the client giving the height this time.
		place(1458, 1500, 100, 0)
		stub.advance(5)
		place(1458, 1631.17, 245.19, -43.1)
		N.SetTarget(1458, 50, 50, "Elsewhere")
		settle()
		N.SetTarget(1420, 61.9, 52.3, "Brill")
		settle()
		r.known = route()
		emit(r)"#
		),
		true,
	);
	let rides = |rt: &[String]| rt.iter().position(|s| s == "lift|Ride the elevator up").is_some_and(|i| i > 0);
	let (known, unknown, walked) = (strs(&out["known"]), strs(&out["unknown"]), strs(&out["walked"]));
	assert!(rides(&known), "height known: the walk rides a lift up ({})", known.join(", "));
	assert_eq!(unknown.first().map(String::as_str), Some("walk|Walk to the lift"), "floor unknown: not taken for the hall above, to the lift");
	assert!(rides(&unknown), "and up it ({})", unknown.join(", "));
	assert!(rides(&walked), "a few steps on the ring: the floor is found and the walk rides a lift up ({})", walked.join(", "));
}

// Fitz in the Trade Quarter (2026-10-25, the first build on Leffe's maps, 1458 67.1,49.8, 18 yd from the south lift's
// bottom): the minimap's trail went the short way to the lift, but the arrow said 175 m and pointed backwards. His
// floor there (-48) took no area of ours within 3 yd, so the client's subzone ("Trade Quarter") named a ledge at 13 and
// the walk started up there. Within 6 yd it takes the Trade Quarter's (as the floor at -42 does): the followed floor is
// the city's, and the arrow aims along it to the lift. (Leffe's surface at -47 there is a pocket no walk leaves, so the
// search from it finds nothing and is asked once more without the height: from the floor at -42, 67 yd.) Indoors the
// arrow aims at the walk's next turn round the lift shaft, not across it (Nav/Follow.lua, a checked indoor path's turns).
#[test]
fn lifts_in_the_trade_quarter_by_the_south_lift_the_subzone_names_the_citys_floor_and_the_arrow_aims_along_it_to_the_lift() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(20)
		w.faction = "Horde"
		IsIndoors = function() return 1 end
		w.setZone("Undercity", "Trade Quarter")
		local c, sx, sy = C.MapToWorld(1458, 67.1, 49.8, "e")
		place(1458, sx, sy, 0)
		N.SetTarget(1420, 61.9, 52.3, "Brill")
		for _ = 1, 400 do aim() stub.advance(0.05) end
		local legs, ci = N.GetRoute()
		local f
		for _, rec in ipairs(finds) do
			if dist(rec.from[1], rec.from[2], sx, sy) < 3 and rec.done and rec.points then f = rec end
		end
		local a = aim()
		local lx, ly = 1544.8, 240.6 -- the south lift's bottom landing
		local along, off = alongOf(f, a.x or sx, a.y or sy)
		local top = -math.huge
		for _, p in ipairs(f and f.points or {}) do if p.z then top = math.max(top, p.z) end end
		emit({ floor = N.walk.Floor(0, sx, sy) or false, first = legs[ci].kind .. "|" .. legs[ci].label, yards = f and floor(length(f.points)) or false, top = top,
			shown = a.dist and floor(a.dist) or false, along = along or false, off = off or false, lift = floor(dist(sx, sy, lx, ly)) })"#,
		true,
	);
	assert_eq!(out["first"], "walk|Walk to the lift");
	assert!(out["floor"] != false && f(&out["floor"]) < -40.0, "the followed floor is the city's ({}), not the ledge at 13", out["floor"]);
	assert!(f(&out["yards"]) < 100.0, "the short way to the lift's door, round its shaft ({} yd, {} straight)", out["yards"], out["lift"]);
	assert!(f(&out["top"]) < -30.0, "on the city's floor all the way (highest {})", out["top"]);
	assert!(f(&out["shown"]) < 80.0, "the arrow shows {} yd (175 m in the first build)", out["shown"]);
	assert!(f(&out["off"]) < 1.0, "the arrow aims at a point on the walk ({} yd off it)", out["off"]);
	assert!(f(&out["along"]) > 1.5, "ahead along the walk to the lift, never back (at point {} of it, 1 is the start)", out["along"]);
}

// Fitz in the canals (2026-10-23, after 21b658260): by the auction house (1628, 305, z -62 by the server; Forever's
// client gives no height) and on round the canal ring, the walk to Tirisfal lost its lift at some spots and pointed
// at the entrance hall's level. Along the ring the canal (-62) and the walkway over it (-45) lie under every step, so
// the candidate floors never come down to one and the floor stays unknown; a search without a height started from
// whichever surface near the player was cheapest, roofs and the Ruins' ground included. Indoors, a search from the
// player with the floor unknown starts only on the candidate floors (Path.Find's from.floors).
#[test]
fn lifts_walking_the_undercitys_canal_ring_from_the_auction_house_with_no_height_every_plan_rides_a_lift_up_and_from_fitzs_canal_spot_from_the_first_plan() {
	skip_unless_ready!();
	let out = run(
		&format!(
			"{FLOOR_WALK}{}",
			r#"
		w.setLevel(30)
		w.faction = "Horde"
		IsIndoors = function() return 1 end
		local cx, cy = 1590, 240
		local r0 = math.sqrt((1628.02 - cx) ^ 2 + (305.49 - cy) ^ 2)
		local a0 = math.atan2(305.49 - cy, 1628.02 - cx)
		place(1458, 1628.02, 305.49, 0)
		N.SetTarget(1420, 61, 42, "Tirisfal Glades 61, 42")
		local seen, bad = 0, {}
		for k = 1, 12 do
			local a = a0 - k * 0.12
			walkTo(1458, { { cx + r0 * math.cos(a), cy + r0 * math.sin(a) } })
			for _ = 1, 60 do aim() stub.advance(0.05) end
			local legs, ci = N.GetRoute()
			local ride = false
			for i = ci, #legs do if legs[i].kind == "lift" then ride = true end end
			seen = seen + 1
			if not ride then bad[#bad + 1] = k end
		end
		-- A fresh start (the floor followed dropped: a jump of more than 30 yd) at the canal by the auction house, no
		-- walking. (His other spot, the walkway near the south lift at 1584, 243, -52, lies under the entrance hall:
		-- with no height and no walking history nothing tells the two apart yet.)
		local fresh = {}
		for _, p in ipairs({ { 1628.02, 305.49 } }) do
			place(1458, 1500, 100, 0)
			stub.advance(3)
			aim()
			place(1458, p[1], p[2], 0)
			for _ = 1, 200 do aim() stub.advance(0.05) end
			local legs, ci = N.GetRoute()
			local ride = false
			for i = ci, #legs do if legs[i].kind == "lift" then ride = true end end
			fresh[#fresh + 1] = ride
		end
		emit({ seen = seen, bad = table.concat(bad, ", "), fresh = fresh })"#
		),
		true,
	);
	assert_eq!(out["fresh"], serde_json::json!([true]), "standing at Fitz's canal spot with no walking history: the ride up from the first plan");
	assert_eq!(out["seen"], 12);
	assert_eq!(out["bad"], "", "every step round the ring keeps the ride up (lost at steps {})", out["bad"]);
}

// #2244 (Reaperwest, a Spanish (Latin America) client): in the Undercity the floor is the surface the client's subzone
// names (Nav/Walk.lua named), and the walking maps name their areas in English, so on every other language no subzone
// matched: in the Apothecarium (1458 50.7,71.0) the walk to the bat handler (1458 63.2,48.6) started from a floor above
// the player and the arrow pointed at the wall. With its language folder's Subzones.lua a client in another language
// starts each walk where an English client does: in the Apothecarium on its floor, on the canal by the auction house
// (the canal ring test's spot) on the levels its subzone names. At each spot the client names the subzone of the
// lowest floor, the one the player stands on: its row's name in the client's language, `names` (English name -> the
// client's).
fn undercity_starts(locale: &str, names: &[(&str, &str)]) -> Value {
	let (_tmp, ns) = ns_file();
	let mut b = before(&nav_files(&ns));
	if locale != "enUS" {
		let folder = forge_guide::toc::language_addon(locale);
		let list = toc_files(&folder).unwrap().iter().map(|p| lua_string(&p.to_string_lossy())).collect::<Vec<_>>().join(", ");
		b = format!("function GetLocale() return {} end\nstub.packs.{folder} = {{ {list} }}\n{b}", lua_string(locale));
	}
	let names = names.iter().map(|(en, l)| format!("[{}] = {}", lua_string(en), lua_string(l))).collect::<Vec<_>>().join(", ");
	let script = format!(
		r#"
		w.setLevel(30)
		w.faction = "Horde"
		IsIndoors = function() return 1 end
		local NAMES = {{ {names} }}
		local floors
		do
			local find = E.Find
			E.Find = function(map, from, ...)
				local f = {{}}
				for i, z in ipairs(from.floors or {{}}) do f[i] = r1(z) end
				table.sort(f)
				floors = f
				return find(map, from, ...)
			end
		end
		-- The subzone the client shows on the lowest floor at (wx, wy): that floor's row in the client's language.
		local function subzoneAt(wx, wy)
			local z, areas, n = {{}}, {{}}, nil
			for _ = 1, 200 do
				n = E.SurfacesAt(0, wx, wy, z, areas)
				if n then break end
				stub.advance(0.05)
			end
			local lo, en = math.huge, nil
			for i = 1, n or 0 do
				local name = areas[i] ~= 0 and E.AreaName(0, areas[i])
				if name and z[i] < lo then lo, en = z[i], name end
			end
			return en and NAMES[en] or ("no client name for " .. tostring(en))
		end
		-- The first search from (wx, wy) to the bat handler: its start height ("none": unknown), the floors it may
		-- start on and its yards.
		local subs = {{}}
		local function start(wx, wy)
			N.ClearTarget()
			place(1458, 1500, 100, 0)
			w.subzone = nil
			stub.advance(3)
			aim()
			local sub = subzoneAt(wx, wy)
			subs[#subs + 1] = sub
			w.subzone = sub
			place(1458, wx, wy, 0)
			local n = #finds
			floors = nil
			N.SetTarget(1458, 63.2, 48.6, "Michael Garrett")
			for _ = 1, 200 do
				aim()
				stub.advance(0.05)
			end
			for i = n + 1, #finds do
				local f = finds[i]
				if dist(f.from[1], f.from[2], wx, wy) < 3 then
					return {{ z = f.from[3] and r1(f.from[3]) or "none", floors = f.from[3] == nil and floors or {{}}, yards = f.points and floor(length(f.points)) or false }}
				end
			end
			return "no search from the spot"
		end
		local r = {{ apothecarium = start(1423.47, 386.79), canal = start(1628.02, 305.49) }}
		r.subs = subs
		emit(r)"#
	);
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_encoding.lua", "stub_packs.lua"],
		before: b,
		addons: polestar_addons(),
		login: true,
		script: format!("{PRELUDE}\n{script}"),
		..Default::default()
	})
	.remove(0);
	eprintln!("{locale}: {out}");
	out
}

/// The Undercity's areas at the two spots in English.
const UNDERCITY: [&str; 4] = ["The Apothecarium", "Canals", "Trade Quarter", "Ruins of Lordaeron"];

/// An English client's starts, then `locale`'s, its client naming the Undercity's areas `names` (UNDERCITY's order,
/// as the client's tables give them): the same starts, the Apothecarium's from its floor.
fn undercity_starts_as_in_english(locale: &str, names: [&str; 4], apothecarium: &str) {
	skip_unless_ready!();
	let english = undercity_starts("enUS", &UNDERCITY.map(|n| (n, n)));
	let start = &english["apothecarium"];
	assert_eq!(english["subs"][0], "The Apothecarium", "the player stands on the Apothecarium's floor");
	assert!(start["z"].is_number() && f(&start["yards"]) > 400.0, "English: from the Apothecarium's floor, out up the ramps: {start}");
	let local = undercity_starts(locale, &std::array::from_fn::<_, 4, _>(|i| (UNDERCITY[i], names[i])));
	assert_eq!(local["subs"][0], apothecarium);
	assert_eq!((&local["apothecarium"], &local["canal"]), (&english["apothecarium"], &english["canal"]), "{locale}: the starts an English client gets");
}

#[test]
fn undercity_a_spanish_latin_america_client_starts_its_walks_on_the_floors_an_english_client_does_2244() {
	undercity_starts_as_in_english("esMX", ["El Apothecarium", "Canales", "Barrio del Comercio", "Ruinas de Lordaeron"], "El Apothecarium");
}

#[test]
fn undercity_a_german_client_starts_its_walks_on_the_floors_an_english_client_does_2244() {
	undercity_starts_as_in_english("deDE", ["Das Apothekarium", "Die Kanäle", "Das Handwerksviertel", "Die Ruinen von Lordaeron"], "Das Apothekarium");
}

#[test]
fn undercity_a_russian_client_starts_its_walks_on_the_floors_an_english_client_does_2244() {
	undercity_starts_as_in_english("ruRU", ["Квартал аптекарей", "Каналы", "Торговый квартал", "Руины Лордерона"], "Квартал аптекарей");
}

#[test]
fn undercity_a_simplified_chinese_client_starts_its_walks_on_the_floors_an_english_client_does_2244() {
	undercity_starts_as_in_english("zhCN", ["炼金房", "运河", "贸易区", "洛丹伦废墟"], "炼金房");
}

// Far waypoints (Fitz, 2026-10-23): every walk leg of the route is drawn along the ground as soon as the route is
// planned, before the planner's measure is in (Nav/Walk.lua pumpShapes: Path.FindCoarse's sketch over the entrance
// graph, a walk inside one cluster its own path), and no later. Before, a walk from a crossing's far end was hand-made
// (drawn and walked straight) and the others were searched only after the measure: from Mulgore below Thunder Bluff a
// straight line across Mulgore and straight segments north along the Stonetalon range. A walk leg drawn with two
// points is only one the engine's own path walks straight, or one on another continent than the player's while its
// walking maps are not loaded (they load when the player gets there: one continent's at a time).
const SHAPES: &str = r#"
-- The walk legs as drawn when the measure's batch answers (before any later walk's own search may run): label, the
-- points, and the ends of a two-point one; checked afterwards against the engine's path between those ends.
local realMany, atMeasure = E.FindMany, nil
E.FindMany = function(map, from, targets, callback, ...)
	return realMany(map, from, targets, function(...)
		if not atMeasure then
			atMeasure = {}
			local g = N.GetRouteGeometry()
			local legs, ci = N.GetRoute()
			local pc = C.GetPlayerWorldPosition()
			for i, l in ipairs(g and g.legs or {}) do
				local leg = legs and legs[ci + i - 1]
				if l.kind == "walk" and leg and leg.kind == "walk" then
					local p = l.pts
					local far = leg.from.c ~= pc and not E.Resident(leg.from.c)
					atMeasure[#atMeasure + 1] = { label = leg.label, n = #p, handmade = leg.handmade or false, far = far, ends = #p == 2 and not far and { p[1][1], p[1][2], p[1][3], p[2][2], p[2][3] } or nil }
				end
			end
		end
		return callback(...)
	end, ...)
end
local function shapes(steps)
	local n = 0
	while not atMeasure and n < (steps or 400) do aim(); stub.advance(0.05); n = n + 1 end
	local out = {}
	for _, l in ipairs(atMeasure or {}) do
		local engine
		if l.ends then
			local e = l.ends
			local full = E.FindSync(e[1], { x = e[2], y = e[3] }, { x = e[4], y = e[5] }, { profile = w.faction })
			engine = full and #full or 0
		end
		out[#out + 1] = { label = l.label, n = l.n, handmade = l.handmade, engine = engine, far = l.far }
	end
	return out
end
"#;

fn check_shapes(legs: &Value, min: usize) {
	let legs = legs.as_array().cloned().unwrap_or_default();
	eprintln!(
		"{}",
		legs.iter()
			.map(|l| format!(
				"{}: {} points{}{}",
				l["label"].as_str().unwrap_or(""),
				l["n"],
				if l["engine"].is_null() { String::new() } else { format!(" (engine {})", l["engine"]) },
				if l["handmade"] == true { " hand-made" } else { "" },
			) + if l["far"] == true { " (another continent)" } else { "" })
			.collect::<Vec<_>>()
			.join("; ")
	);
	assert!(legs.len() >= min, "the route walks {} legs", legs.len());
	for l in &legs {
		let n = f(&l["n"]);
		assert!(n > 2.0 || (n == 2.0 && (l["far"] == true || l["engine"].as_f64().is_some_and(|e| e <= 2.0))), "{}: drawn with {n} points while the engine's path has {}", l["label"], l["engine"]);
	}
}

#[test]
fn far_waypoints_from_mulgore_below_thunder_bluff_to_stonetalon_every_walk_leg_follows_the_ground_before_the_planners_measure_is_in() {
	skip_unless_ready!();
	let out = run(
		&format!(
			"{SHAPES}{}",
			r#"
		w.setLevel(20)
		w.faction = "Horde"
		-- A flight map has opened in Kalimdor and listed none: every leg walks (no flight it may have, #1795).
		Polestar.CharState().flags.taxiSeen = { [1] = true }
		place(1412, -975, -107, nil)
		N.SetTarget(1442, 47.5, 61.5, "Stonetalon", "e")
		emit(shapes())"#
		),
		true,
	);
	check_shapes(&out, 4);
	assert!(out.as_array().unwrap().iter().any(|l| l["label"] == "Walk to Stonetalon Mountains" && l["handmade"] != true), "the walk on from the Barrens crossing is the engine's");
}

#[test]
fn an_alliance_walk_from_ironforge_to_guarded_brill_is_routed_as_before_0_4_2() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(20)
		w.faction = "Alliance"
		local _, px, py = C.MapToWorld(1426, 53.3, 35.0, "e")
		place(1426, px, py, nil)
		N.SetTarget(1420, 61.9, 52.3, "Brill", "e")
		for _ = 1, 300 do aim(); stub.advance(.05) end
		local a = aim()
		emit({ state = a.state, bearing = a.x ~= nil, itinerary = N.GetRoute() ~= nil, target = N.GetTarget().label, caption = N.noWalk or false })"#,
		true,
	);
	// Main, 2026-11-21, Fitz: "go back to our original danger pathing": a route into the Horde's town, as before 0.4.2
	// (0.4.2: no itinerary, "unsafe").
	assert_eq!(out, serde_json::json!({"state":"travel","bearing":true,"itinerary":true,"target":"Brill","caption":false}));
}

// Thunder Bluff (Fitz, 2026-10-23, TB 52.2,31.1 off the north lift's top): the walk on from the mesa crossing's far
// end was hand-made, so the map drew it straight from the landing to the target and, once the ride was over, the
// arrow pointed straight at it too. The player starts on the ground below the lift, at height 60 (the walking maps have
// no surface at 68 there, 8 yd up, and a walk does not start from a floor it cannot reach), and is seen on the bottom
// landing's deck before the ride (the lift leg waits for its boarding floor).
#[test]
fn lifts_the_walk_on_from_thunder_bluffs_lift_crossing_is_the_engines_drawn_along_its_path_and_walked_along_it_off_the_top_landing() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(30)
		w.faction = "Horde"
		place(1412, -1010, -70, 60)
		N.SetTarget(1456, 40, 60, "Thunder Bluff 40, 60", "e")
		for _ = 1, 200 do aim(); stub.advance(0.05) end
		local function last()
			local legs, ci = N.GetRoute()
			local g = N.GetRouteGeometry().legs
			local leg = legs[#legs]
			return { label = leg.label, handmade = leg.handmade or false, n = #g[#g].pts, current = #legs == ci }
		end
		local r = { before = last() }
		local legs, ci = N.GetRoute()
		r.route = {}
		for i = ci, #legs do r.route[#r.route + 1] = legs[i].kind .. "|" .. legs[i].label end
		-- On the bottom landing's deck (the lift leg starts once the player is seen there), the ride, then off the top
		-- landing: 45 yd from the bottom one.
		place(1412, -1036.5, -53.1, 69.3)
		for _ = 1, 20 do aim(); stub.advance(0.05) end
		place(1456, -1040.6, -49, 140.7)
		for _ = 1, 20 do aim(); stub.advance(0.05) end
		for k = 1, 8 do
			place(1456, -1040.6 - k * 4, -49 + k * 4, 140.7)
			for _ = 1, 10 do aim(); stub.advance(0.05) end
		end
		r.after = last()
		r.aim = aim()
		emit(r)"#,
		true,
	);
	let route = strs(&out["route"]);
	assert!(route.iter().any(|s| s == "lift|Ride the elevator up"), "the walk rides the lift: {}", route.join(", "));
	assert_eq!(out["before"]["label"], "Thunder Bluff 40, 60");
	assert_eq!(out["before"]["handmade"], false, "the walk on from the crossing's far end is the engine's");
	assert!(f(&out["before"]["n"]) > 2.0, "drawn along its path before the ride ({} points)", out["before"]["n"]);
	assert_eq!(out["after"]["current"], true, "off the lift, the walk to the target is the arrow's");
	assert!(f(&out["after"]["n"]) > 2.0, "drawn along its path ({} points)", out["after"]["n"]);
	assert_eq!(out["aim"]["measured"], true, "and the arrow follows the path, not a straight line");
}

// #1053 (troders, beside Arch Druid Hamuul Runetotem in his hut on Elder Rise: the arrow 358 yd, the journey 720 yd,
// back over the bridge and round again) and #1023 (Pilk, beside Nara Wildmane): the turn-in came up in the Barrens, so
// the player's walk to Hamuul was measured from there (thousands of yards, through Mulgore and up a lift), and within
// 400 yd of a target nothing is measured again. That far measure less the yards moved stood for the player's walk in
// Thunder Bluff, dearer than a walk to the north lift's top and the measured walk in from there; at the lift top the
// walk went back to the hut, and at the hut back to the lift top. Within 400 yd the player's walk is straight.
#[test]
fn a_turn_in_set_in_the_barrens_walked_to_from_thunder_bluffs_flight_master_arrives_beside_hamuul_runetotem_never_back_to_the_lift_1053() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		w.setLevel(17)
		local HAMUUL = { -1049.0, -303.7 } -- 1456 78.6,28.6
		local function route()
			local legs, ci = N.GetRoute()
			local list = {}
			for i = ci or 1, #(legs or {}) do list[#list + 1] = legs[i].kind .. "|" .. legs[i].label end
			return list
		end
		-- At Tonga Runetotem in the Barrens (the step's accept): the turn-in comes up and is measured from there.
		local _, bx, by = C.MapToWorld(1413, 52.3, 31.9, "e")
		place(1413, bx, by, 0)
		for _ = 1, 40 do stub.advance(0.05); aim() end
		Polestar.Fire("WAYPOINT_CHANGED", { map = 1456, x = 78.6, y = 28.6, f = "e", label = "Hamuul Runetotem", kind = "turnin", r = 5 })
		for _ = 1, 600 do aim(); stub.advance(0.05) end
		local tc, tx, ty, tz = N.GetTargetWorld()
		local r = { measured = N.walk.Measured(tc, tx, ty, false, tz) ~= nil }
		-- Flown to Thunder Bluff, 365 yd from him.
		place(1456, -1197.2, 29.7, 0)
		for _ = 1, 100 do aim(); stub.advance(0.05) end
		r.landed = route()
		-- Along the arrow's path into the hut (indoors there), then at the report's spot (78.28,28.52) beside him.
		local f = finds[#finds]
		local _, x0, y0 = C.GetPlayerWorldPosition()
		for _, p in ipairs(f and f.points or {}) do
			local k = math.max(1, math.ceil(dist(x0, y0, p.x, p.y) / 2))
			for i = 1, k do
				local x, y = x0 + (p.x - x0) * i / k, y0 + (p.y - y0) * i / k
				w.indoors = dist(x, y, HAMUUL[1], HAMUUL[2]) < 12
				place(1456, x, y, 0)
				stub.advance(0.3)
				aim()
			end
			x0, y0 = p.x, p.y
		end
		w.indoors = true
		place(1456, -1048.45, -300.38, 0)
		for _ = 1, 200 do aim(); stub.advance(0.05) end
		r.beside = { state = aim().state, route = route() }
		emit(r)"#,
		true,
	);
	assert_eq!(out["measured"], true, "the walk to Hamuul was measured from the Barrens");
	assert_eq!(out["landed"], serde_json::json!(["walk|Hamuul Runetotem"]), "from the flight master, the walk to him: not by the north lift's top");
	assert_eq!(out["beside"]["state"], "arrived", "beside him in his hut, arrived");
	assert_eq!(out["beside"]["route"], serde_json::json!(["walk|Hamuul Runetotem"]), "with nothing to walk back to");
}

// Ironforge's gate (Fitz, 2026-10-23, a Tauren after a /reload at the gate): the client says outdoors in the gate's
// arch, where the cell holds the city's floor (an indoor city class, 497) and the mountain's ground over it (620, the
// one outdoor surface), so the floor was seeded on the mountain and the walk to Loch Modan was searched and drawn from
// there, east over the mountains behind the city. Check the road to Kharanos on a friendly player and the same
// departure on Horde. A cross-continent destination can choose a flight before the gate and never exercise this road.
#[test]
fn ironforge_gate_after_reload_uses_the_road_below_the_mountain_and_horde_walks_out_too() {
	skip_unless_ready!();
	let scene = r#"
		w.setLevel(30)
		w.faction = "@FACTION"
		IsIndoors = function() return nil end
		place(1426, -5010, -850, nil)
		N.SetTarget(1426, 50, 50, "Anywhere", "e")
		for _ = 1, 40 do aim(); stub.advance(0.1) end
		for k = 1, 6 do
			place(1426, -5010 - k * 2, -850 + k * 3, nil)
			for _ = 1, 4 do aim(); stub.advance(0.1) end
		end
		place(1426, -5022.45, -831.61, nil)
		local n = #finds
		N.SetTarget(1426, 46.8, 52.5, "Kharanos", "e")
		for _ = 1, 100 do aim(); stub.advance(0.05) end
		local f
		for i = n + 1, #finds do
			if dist(finds[i].from[1], finds[i].from[2], -5022.45, -831.61) < 3 and finds[i].done then f = finds[i] end
		end
		local top = -math.huge
		for _, p in ipairs(f and f.points or {}) do
			if p.z and dist(p.x, p.y, -5022.45, -831.61) < 400 then top = math.max(top, p.z) end
		end
		local a = aim()
		emit({ from = f and f.from[3] or false, top = top > -math.huge and top or false, n = f and f.points and #f.points or 0,
			state = a.state, bearing = a.x ~= nil, measured = a.measured == true, caption = N.noWalk or false })"#;
	let friendly = run(&scene.replace("@FACTION", "Alliance"), true);
	assert_eq!(friendly["measured"], true, "Alliance follows the searched road out");
	assert!(f(&friendly["n"]) > 2.0, "the walk out is searched");
	assert!(friendly["from"] == false || f(&friendly["from"]) < 520.0, "searched from the gate's floor or without a height ({})", friendly["from"]);
	assert!(f(&friendly["top"]) < 520.0, "the first 400 yd stay on the road below the gate ({})", friendly["top"]);
	let enemy = run(&scene.replace("@FACTION", "Horde"), true);
	// Main, 2026-11-21, Fitz: "go back to our original danger pathing": Horde walks out too, as before 0.4.2 (0.4.2:
	// "unsafe", no walk).
	assert_eq!(enemy["state"], "travel");
	assert_eq!(enemy["measured"], true, "a searched walk out: {enemy}");
	assert_eq!(enemy["caption"], false);
	assert!(f(&enemy["n"]) > 2.0, "the walk out is searched");
}

// Inside Ironforge (Fitz, 2026-10-23): the walk from the Commons to the city's crossing end at the gate stays in one
// cluster, the city's many floors under the mountain, so it is searched whole (no sketch) and it was slow: the
// same-cluster walk searched an A* from every start surface to every goal surface, and one to a surface the start's
// floor never joins (the mountain's ground over the gate) expanded all the start reaches. A goal the start's endpoint
// tree (a Dijkstra over the cluster, already run) never reached when it ran dry is out of reach: no A* for it. Same
// answer; a fraction of the work. The capitals' step joins (#2916) join more of the city's floors (4 floors and 41
// arcs more in the Eastern Kingdoms), so the start's tree has more to expand: 49,231 -> 50,218 for the same path; the
// limit went from 50,000 to 51,000 with them.
#[test]
fn inside_ironforge_the_walk_from_the_commons_to_the_gate_searches_no_goal_floor_out_of_the_starts_reach_with_the_same_path() {
	skip_unless_ready!();
	let out = run(
		r#"
		local r = {}
		local from, to, o = { x = -4980.5, y = -1013.9 }, { x = -4980, y = -885 }, { profile = "Horde", style = "balanced" }
		local p, cost, n = E.FindSync(0, from, to, o)
		r.flat = { n = n, points = p and #p or 0, yards = floor(length(p or {})) }
		p, cost, n = E.FindSync(0, { x = from.x, y = from.y, z = 502 }, to, o)
		r.floor = { n = n, points = p and #p or 0, yards = floor(length(p or {})) }
		emit(r)"#,
		true,
	);
	let (flat, fl) = (&out["flat"], &out["floor"]);
	assert!(f(&flat["points"]) > 2.0 && f(&flat["yards"]) < 200.0, "the walk out through the city ({} yd)", flat["yards"]);
	assert!(f(&flat["n"]) < 51000.0, "without a height, {} expansions (83,679 with a search to every goal surface)", flat["n"]);
	assert_eq!((&fl["points"], &fl["yards"]), (&flat["points"], &flat["yards"]), "from the floor: the same path");
	assert!(f(&fl["n"]) < 5000.0, "from the floor, its endpoint search kept: {} expansions (22,145 before)", fl["n"]);
}

// Stormwind (Fitz, 2026-10-23, a Tauren in the Trade District at -8833,623, z 93.7): the cell holds the street (94,
// the indoor city class, as all of Stormwind's streets) and the canal level under it (59, the one outdoor surface),
// and the client says outdoors in the open street. The floor was seeded on the canal level, and the walk to a waypoint
// east of Goldshire went west through the city, over the mountains north-west of it, down the coast and through
// Westfall. Outdoors says nothing of a city's floors. Alliance should walk out on the street. Main, 2026-11-21, Fitz:
// "go back to our original danger pathing": Horde walks out too, as before 0.4.2 (0.4.2: "unsafe", no walk).
fn stormwind_street(faction: &str) {
	skip_unless_ready!();
	let out = run(
		&r#"
			w.setLevel(30)
			w.faction = "@FACTION"
			IsIndoors = function() return nil end
			place(1453, -8833.07, 622.78, nil)
			for _ = 1, 30 do aim(); stub.advance(0.05) end
			N.SetTarget(1429, 56, 66, "East of Goldshire", "e")
			for _ = 1, 200 do aim(); stub.advance(0.05) end
			local f
			for _, rec in ipairs(finds) do
				if dist(rec.from[1], rec.from[2], -8833.07, 622.78) < 3 and rec.done then f = rec end
			end
			local north = -math.huge
			for _, p in ipairs(f and f.points or {}) do north = math.max(north, p.x) end
			local a = aim()
			emit({ from = f and f.from[3] or false, yards = floor(length(f and f.points or {})), n = f and f.points and #f.points or 0,
				north = north > -math.huge and floor(north) or false, state = a.state, bearing = a.x ~= nil, measured = a.measured == true, caption = N.noWalk or false })"#
			.replace("@FACTION", faction),
		true,
	);
	if faction == "Horde" {
		assert_eq!(out["state"], "travel");
		assert_eq!(out["measured"], true, "a searched walk out of the city: {out}");
		assert_eq!(out["caption"], false);
		assert!(f(&out["n"]) >= 2.0, "the walk out is searched");
		return;
	}
	assert_eq!(out["measured"], true, "Alliance follows the street on the searched path");
	assert!(f(&out["n"]) >= 2.0, "the walk out is searched");
	assert!(out["from"] == false || f(&out["from"]) > 80.0, "searched from the street or without a height ({})", out["from"]);
	assert!(f(&out["yards"]) < 600.0, "to the gate through the city ({} yd; over the mountains and down the coast it was over 4,000)", out["yards"]);
	assert!(f(&out["north"]) < -8700.0, "never north out of the city ({})", out["north"]);
}

#[test]
fn horde_walks_out_of_stormwinds_trade_district_as_before_0_4_2() {
	stormwind_street("Horde");
}

#[test]
fn t_234_floor_alliance_in_stormwinds_trade_district_outdoors_the_walk_out_starts_on_the_street_and_goes_through_the_gate() {
	stormwind_street("Alliance");
}

// #1970 (GabZ, 0.3.7.2): a level 16 mage in Elwynn (38.79,55.71 on the live map), bound in Stormwind, guided to Jennea
// Cannon (Stormwind 49.56,85.80 live, her spawn height 29.7) for a turn-in: "Hearthstone to Stormwind: saves 62 min",
// a few minutes' walk away. Jennea and the other mage trainers stand in the Wizard's Sanctum's chamber, 76 yd under
// its ground floor, reached only by the tower's portals (classic-db areatrigger_teleport 704 from the top room down,
// 702 back up). No walking map (nor Polestar's walking grid) has the chamber's floor: her goal landed on the terrain
// buried under the Mage Quarter, which the maps join to the inn's (225 yd) and to Elwynn only by a way round of 26 km,
// so the plan hearthed. The chamber is a place only portals reach now (crossings.json `wizards-sanctum-chamber`: its
// box and height range), so the plan walks: up the tower (the chain `wizards-sanctum-tower`, from the stairs' top to
// the portal), through the portal down, to her.
#[test]
fn issue_1970_a_mage_in_elwynn_bound_in_stormwind_walks_to_jennea_cannon_in_the_wizards_sanctum_no_hearthstone() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(16)
		w.faction = "Alliance"
		w.bind("Stormwind City")
		w.addItem(6948, 1)
		IsIndoors = function() return nil end
		local _, sx, sy = C.MapToWorld(1429, 38.79, 55.71)
		place(1429, sx, sy, nil)
		for _ = 1, 30 do aim(); stub.advance(0.05) end
		Polestar.Fire("WAYPOINT_CHANGED", { map = 1453, x = 49.56, y = 85.80, z = 29.7, label = "Jennea Cannon", kind = "turnin", r = 5 })
		for _ = 1, 600 do aim(); stub.advance(0.05) end
		local legs, ci = N.GetRoute()
		local route = {}
		for i = ci or 1, legs and #legs or 0 do route[#route + 1] = legs[i].kind .. "|" .. legs[i].label end
		emit({ route = route })"#,
		true,
	);
	let route = strs(&out["route"]);
	assert!(!route.iter().any(|l| l.starts_with("hearth|")), "no Hearthstone for a walk of minutes: {}", route.join(", "));
	assert!(route.iter().any(|l| l == "portal|Take the portal to Wizard's Sanctum"), "through the tower's portal down: {}", route.join(", "));
	assert_eq!(route.last().map(String::as_str), Some("walk|Jennea Cannon"), "and the walk to her: {}", route.join(", "));
}

/// #1970: the walk to Jennea Cannon in the Wizard's Sanctum's chamber from where `start` puts the player (Stormwind,
/// bound there, the Hearthstone ready): the route's legs from the current one, "kind|label".
fn sanctum_route(start: &str) -> Vec<String> {
	let script = [
		r#"
		w.setLevel(16)
		w.faction = "Alliance"
		w.bind("Stormwind City")
		w.addItem(6948, 1)
		IsIndoors = function() return nil end
		"#,
		start,
		r#"
		for _ = 1, 30 do aim(); stub.advance(0.05) end
		Polestar.Fire("WAYPOINT_CHANGED", { map = 1453, x = 49.56, y = 85.80, z = 29.7, label = "Jennea Cannon", kind = "turnin", r = 5 })
		for _ = 1, 600 do aim(); stub.advance(0.05) end
		local legs, ci = N.GetRoute()
		local route = {}
		for i = ci or 1, legs and #legs or 0 do route[#route + 1] = legs[i].kind .. "|" .. legs[i].label end
		emit({ route = route })"#,
	]
	.concat();
	strs(&run(&script, true)["route"])
}

// #1970: from anywhere in Stormwind the walk into the chamber is the stairs, the portal down and a walk to her, never one
// over the terrain buried under the city (the inn's buried ground joins hers at 225 yd), nor the Hearthstone for it.
#[test]
fn issue_1970_from_the_mage_quarter_the_inn_and_the_gate_the_walk_to_jennea_cannon_ends_through_the_sanctums_portal() {
	skip_unless_ready!();
	for (from, start) in
		[("the Mage Quarter's street", "place(1453, -8990, 820, 105)"), ("the Gilded Rose", "place(1453, -8867.7, 673.6, 98)"), ("the city's gate", "place(1453, -9092.1, 395.1, nil)")]
	{
		let route = sanctum_route(start);
		let n = route.len();
		assert!(!route.iter().any(|l| l.starts_with("hearth|")), "from {from}: no Hearthstone: {}", route.join(", "));
		assert!(route.iter().any(|l| l == "walk|Walk to the portal"), "from {from}: up the tower to the portal: {}", route.join(", "));
		assert!(
			n >= 2 && route[n - 2] == "portal|Take the portal to Wizard's Sanctum" && route[n - 1] == "walk|Jennea Cannon",
			"from {from}: the portal down, then the walk to her: {}",
			route.join(", ")
		);
	}
}

// #1970: the arrow leads to the Sanctum's portal and stays on it, "Take the portal", while the player stands in the top
// room (the portal's landing lies 6 yd from its entrance on the map); once the portal has put them in the chamber
// (seen by its step onto the landing) it points straight at Jennea Cannon, a plan made there stays in the chamber,
// and a goal outside leads back up through the portal there and out by the stairs.
#[test]
fn issue_1970_the_arrow_stays_on_the_sanctums_portal_until_the_player_is_through_it_then_points_at_jennea_cannon() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(16)
		w.faction = "Alliance"
		IsIndoors = function() return nil end
		local PORTAL, LANDING, JENNEA, UP = { -9020.1, 880.5 }, { -9017.5, 885.9 }, { -8989.7, 861.9 }, { -9023.3, 892.4 }
		local function route()
			local legs, ci = N.GetRoute()
			local out = {}
			for i = ci or 1, legs and #legs or 0 do out[#out + 1] = legs[i].kind .. "|" .. legs[i].label end
			return out
		end
		local function at(p)
			local a = aim()
			return { state = a.state, leg = route()[1] or "none", off = a.x and r1(dist(a.x, a.y, p[1], p[2])) or false }
		end
		local function ticks(n) for _ = 1, n do aim(); stub.advance(0.05) end end
		place(1453, -8990, 820, 105)
		ticks(30)
		Polestar.Fire("WAYPOINT_CHANGED", { map = 1453, x = 49.56, y = 85.80, z = 29.7, label = "Jennea Cannon", kind = "turnin", r = 5 })
		ticks(200)
		local r = { street = route() }
		place(1453, -9009.4, 867.7, 147.1) -- the stairs' top
		ticks(60)
		r.stairs = at(PORTAL)
		place(1453, -9020.1, 880.5, 148.6) -- at the portal
		ticks(100)
		r.portal = at(PORTAL)
		r.before = N.travel.place or false
		place(1453, LANDING[1], LANDING[2], 29.6) -- through it
		ticks(20)
		r.inside = at(JENNEA)
		r.place = N.travel.place or false
		N.travel.Replan()
		ticks(20)
		r.replanned = route()
		-- a goal outside: back up through the portal there
		local sx, sy = C.WorldToMap(0, -8990, 820, 1453)
		Polestar.Fire("WAYPOINT_CHANGED", { map = 1453, x = sx, y = sy, z = 105, label = "Out", kind = "goto", r = 5 })
		ticks(100)
		r.out = route()
		r.up = at(UP)
		place(1453, -9014.9, 873.3, 148.6) -- the portal up puts them in the top room
		ticks(20)
		r.after = N.travel.place or false
		r.outAfter = route()
		emit(r)"#,
		true,
	);
	let leg = |k: &str| out[k]["leg"].as_str().unwrap_or("").to_string();
	assert!(strs(&out["street"]).iter().any(|l| l == "portal|Take the portal to Wizard's Sanctum"), "from the street, by the portal: {out}");
	assert_eq!(leg("stairs"), "walk|Walk to the portal", "at the stairs' top: {out}");
	assert!(f(&out["stairs"]["off"]) < 2.0, "the arrow points at the portal: {out}");
	assert_eq!((out["portal"]["state"].as_str(), leg("portal").as_str()), (Some("instruction"), "portal|Take the portal to Wizard's Sanctum"), "at the portal, 5 s on: {out}");
	assert!(f(&out["portal"]["off"]) < 2.0, "the arrow stays on the portal: {out}");
	assert_eq!(out["before"], false, "the top room is not the chamber: {out}");
	assert_eq!(out["place"], "wizards-sanctum-chamber", "the portal's step put the player in the chamber: {out}");
	assert_eq!(leg("inside"), "walk|Jennea Cannon", "through the portal: {out}");
	assert!(f(&out["inside"]["off"]) < 2.0, "the arrow points straight at her: {out}");
	assert_eq!(strs(&out["replanned"]), vec!["walk|Jennea Cannon".to_string()], "a plan made in the chamber walks to her: {out}");
	let way_out = strs(&out["out"]);
	assert_eq!(way_out.first().map(String::as_str), Some("portal|Take the portal to Wizard's Sanctum tower"), "out: the portal up, a few yards off: {out}");
	assert_eq!(out["up"]["state"], "instruction", "out: take the portal up: {out}");
	assert!(f(&out["up"]["off"]) < 2.0, "the arrow points at the portal up: {out}");
	assert_eq!(out["after"], false, "the portal up took the player out of the chamber: {out}");
	assert!(!strs(&out["outAfter"]).iter().any(|l| l.starts_with("portal|")), "out of the chamber, no portal left: {out}");
}

// Main, 2026-11-21, Fitz: "go back to our original danger pathing": off the tram in Stormwind, either faction walks
// through the city (0.4.2: Horde "unsafe", no walk).
#[test]
fn the_stormwind_tram_exit_offers_the_city_walk_to_both_factions() {
	skip_unless_ready!();
	for side in ["Horde", "Alliance"] {
		let out = run(
			&r#"
			w.setLevel(30)
			w.faction = @SIDE
			IsIndoors = function() return nil end
			local _, x, y = C.MapToWorld(1453, 68.73, 31.27)
			place(1453, x, y, nil)
			for _ = 1, 30 do aim(); stub.advance(0.05) end
			assert(N.SetTarget(1429, 56, 66, "East of Goldshire", "e"))
			for _ = 1, 300 do aim(); stub.advance(0.05) end
			local a = aim()
			local legs, ci = N.GetRoute()
			emit({ state = a.state, bearing = a.x ~= nil, caption = N.noWalk or false,
				leg = legs and legs[ci] and legs[ci].kind or false })"#
				.replace("@SIDE", &lua_string(side)),
			true,
		);
		assert_eq!(out, serde_json::json!({ "state": "travel", "bearing": true, "caption": false, "leg": "walk" }), "{side}");
	}
}

// The capital's gate should be recognized as hostile only for the visiting faction.
#[test]
fn hostile_towns_every_capitals_crossing_end_lies_in_its_town_for_the_other_faction_never_for_its_own() {
	skip_unless_ready!();
	let ends: [(&str, i32, i32, i32, &str); 8] = [
		("Stormwind", 0, -9047, 449, "Alliance"),
		("Ironforge", 0, -4980, -885, "Alliance"),
		("Darnassus", 1, 9985, 2031, "Alliance"),
		("Orgrimmar gate", 1, 1484, -4417, "Horde"),
		("Orgrimmar west", 1, 1709, -3933, "Horde"),
		("Undercity", 0, 1642, 240, "Horde"),
		("Thunder Bluff", 1, -1289, 144, "Horde"),
		("Thunder Bluff north", 1, -1069, -17, "Horde"),
	];
	let list = ends.iter().map(|(n, c, x, y, side)| format!("{{ {}, {c}, {x}, {y}, {} }}", lua_string(n), lua_string(side))).collect::<Vec<_>>().join(", ");
	let out = run(
		&r#"
		place(1429, -9460, 60, nil)
		for _ = 1, 5 do aim(); stub.advance(0.05) end
		local r = {}
		for _, e in ipairs({ @ENDS }) do
			local other = e[5] == "Alliance" and "Horde" or "Alliance"
			r[#r + 1] = { e[1], E.HubAt(e[2], e[3], e[4], other) or false, E.HubAt(e[2], e[3], e[4], e[5]) or false }
		end
		emit(r)"#
			.replace("@ENDS", &list),
		true,
	);
	for e in out.as_array().unwrap() {
		let name = &e[0];
		assert!(e[1] != false && !e[1].is_null(), "{name}: in the town for the other faction");
		assert_eq!(e[2], false, "{name}: not for its own");
	}
}

// A map click on William MacGregor's house in Westfall (57.71,53.94): a waypoint without a height. The cell holds the
// house floor (34) and the ground's surface over it (38), 4 yd apart: one surface to a search without a height, which
// started on the 38, a pocket no walk leaves, and found nothing. An end without a height whose walk finds nothing is
// walked again from each other surface of its cell (Routing/Path.lua runAny).
#[test]
fn a_waypoint_without_a_height_on_william_macgregors_house_routes_to_and_from_it_the_other_surface_of_its_cell_is_tried() {
	skip_unless_ready!();
	let out = run(
		r#"
		local house, hill = { x = -10658.6, y = 996.8 }, { x = -10509, y = 1045 }
		local a = E.FindSync(0, house, hill)
		local b = E.FindSync(0, hill, house)
		local c = E.FindSync(0, { x = house.x, y = house.y, z = 33 }, hill)
		emit({ from = a and #a or 0, to = b and #b or 0, z = a and a[1].z or false, withZ = c and #c or 0 })"#,
		true,
	);
	assert!(f(&out["from"]) > 2.0, "from the house without a height ({} points)", out["from"]);
	assert!(f(&out["to"]) > 2.0, "to the house without a height ({} points)", out["to"]);
	assert!(out["z"] != false && f(&out["z"]) < 36.0, "starting on the house floor ({})", out["z"]);
	assert!(f(&out["withZ"]) > 2.0, "with his height as before");
}

// ---- nav acceptance: the planner's half (tools/lib/nav/eval/acceptance.json holds the walks) ----
// The open ones are #[ignore]d, so the suite stays green; run them with
// `cargo test -p forge-addontest --test addontest acceptance -- --ignored`.
// A route on Teldrassil: its legs' kinds, the portal and boat it takes, and every walk leg joining Rut'theran
// Village (within 450 yd of 8680,1000, at the foot of the tree) to the top of the tree, which no one can walk.
const TELDRASSIL_ROUTE: &str = r#"
local RUT = { 8680, 1000 }
local function route(map, x, y, tmap, tx, ty, label)
	local c, wx, wy = C.MapToWorld(map, x, y, "e")
	place(map, wx, wy)
	N.SetTarget(tmap, tx, ty, label, "e")
	for _ = 1, 400 do stub.advance(0.05); aim() end
	local legs, ci = N.GetRoute()
	local r = { kinds = {}, transports = {}, treeWalks = 0 }
	for i = ci or 1, #(legs or {}) do
		local l = legs[i]
		r.kinds[#r.kinds + 1] = l.kind
		if l.transport then r.transports[#r.transports + 1] = tostring(l.transport.id) end
		if l.kind == "walk" and l.from and l.to then
			local lowA = dist(l.from.wx, l.from.wy, RUT[1], RUT[2]) < 450
			local lowB = dist(l.to.wx, l.to.wy, RUT[1], RUT[2]) < 450
			if lowA ~= lowB then r.treeWalks = r.treeWalks + 1 end
		end
	end
	N.ClearTarget()
	for _ = 1, 5 do stub.advance(0.05) end
	finds = {}
	return r
end
"#;

fn teldrassil_route(from: (i64, f64, f64), to: (i64, f64, f64, &str)) -> Value {
	run(&format!("{TELDRASSIL_ROUTE}\nw.faction = \"Alliance\"\nemit(route({}, {}, {}, {}, {}, {}, \"{}\"))", from.0, js(from.1), js(from.2), to.0, js(to.1), js(to.2), to.3), true)
}

/// #568 / #579 (EpicTibbles): Dolanaar to the Darnassus fishing trainer walked down to Rut'theran and took the portal up.
/// The new maps have no walk from the top of the tree to the portal; the planner priced it straight until the
/// router's `unreachable` answer took the portal out (Travel.WalkUnreachable).
#[test]
fn acceptance_568_from_dolanaar_to_the_darnassus_fishing_trainer_the_route_walks_in_through_the_gate_never_down_to_the_rutheran_portal() {
	skip_unless_ready!();
	let out = teldrassil_route((1438, 56.73, 61.90), (1457, 47.89, 56.65, "Fishing trainer"));
	let kinds = strs(&out["kinds"]);
	assert!(kinds.iter().all(|k| k == "walk") && !kinds.is_empty(), "it walks all the way ({})", kinds.join(", "));
	assert_eq!(f(&out["treeWalks"]), 0.0, "no walk leg joins Rut'theran to the top of the tree");
}

/// #568: a player who does stand in Rut'theran Village keeps the portal up to the trainer (the router walks them to it).
#[test]
fn t_568_from_rutheran_village_to_the_darnassus_fishing_trainer_the_route_still_takes_the_portal_up() {
	skip_unless_ready!();
	let out = teldrassil_route((1438, 55.6, 90.6), (1457, 47.89, 56.65, "Fishing trainer"));
	let kinds = strs(&out["kinds"]);
	assert!(kinds.iter().any(|k| k == "portal"), "the portal up ({})", kinds.join(", "));
}

/// #1564 (Phear, Night Elf Hunter 12, 0.3.5): in the south of Darnassus (38.76,70.66), bound for Oben
/// Rageclaw at Ban'ethil Barrow Den (Teldrassil 44.94,61.59, The Sleeping Druid), the arrow led to the portal,
/// which only goes down to Rut'theran Village; the way is out through the city's gate and down the road.
#[test]
fn t_1564_from_darnassus_to_banethil_barrow_den_the_route_walks_out_through_the_gate_never_down_the_rutheran_portal() {
	skip_unless_ready!();
	let out = teldrassil_route((1457, 38.76, 70.66), (1438, 44.94, 61.59, "Oben Rageclaw"));
	let kinds = strs(&out["kinds"]);
	assert!(kinds.iter().all(|k| k == "walk") && !kinds.is_empty(), "it walks all the way ({}; {})", kinds.join(", "), strs(&out["transports"]).join(", "));
	assert_eq!(f(&out["treeWalks"]), 0.0, "no walk leg joins Rut'theran to the top of the tree");
}

/// #989 (Dante): off the Auberdine boat in Rut'theran Village, bound for Melithar Staghelm (The Woodland
/// Protector, Teldrassil 59.92,42.47), the route walked straight up the tree; through the portal up to
/// Darnassus, it sent the player back down the portal, and so on. The Rut'theran landing's walk was
/// priced straight while the engine had found none. One target throughout, as in the game.
#[test]
fn t_989_rutheran_village_to_teldrassil_takes_the_portal_up_and_from_its_landing_never_the_portal_down() {
	skip_unless_ready!();
	let out = run(
		&format!(
			r#"{TELDRASSIL_ROUTE}
			w.faction = "Alliance"
			local function at(map, x, y)
				local c, wx, wy = C.MapToWorld(map, x, y, "e")
				place(map, wx, wy)
				for _ = 1, 400 do stub.advance(0.05); aim() end
				local legs, ci = N.GetRoute()
				local r = {{ kinds = {{}}, transports = {{}}, treeWalks = 0 }}
				for i = ci or 1, #(legs or {{}}) do
					local l = legs[i]
					r.kinds[#r.kinds + 1] = l.kind
					if l.transport then r.transports[#r.transports + 1] = tostring(l.transport.id) end
					if l.kind == "walk" and l.from and l.to then
						local lowA = dist(l.from.wx, l.from.wy, RUT[1], RUT[2]) < 450
						local lowB = dist(l.to.wx, l.to.wy, RUT[1], RUT[2]) < 450
						if lowA ~= lowB then r.treeWalks = r.treeWalks + 1 end
					end
				end
				return r
			end
			N.SetTarget(1438, 59.92, 42.47, "Melithar Staghelm", "e")
			local up = at(1438, 56.01, 89.84)
			local down = at(1457, 30.75, 41.39)
			emit({{ up = up, down = down }})"#
		),
		true,
	);
	let (up, down) = (&out["up"], &out["down"]);
	assert!(strs(&up["transports"]).iter().any(|t| t == "portal-darnassus"), "from Rut'theran: the portal up ({})", strs(&up["kinds"]).join(", "));
	assert_eq!(f(&up["treeWalks"]), 0.0, "from Rut'theran: no walk leg up the tree ({})", strs(&up["kinds"]).join(", "));
	assert!(strs(&down["transports"]).is_empty(), "from the landing in Darnassus: no portal ({})", strs(&down["transports"]).join(", "));
	assert_eq!(f(&down["treeWalks"]), 0.0, "from Darnassus: no walk leg joins Rut'theran to the top of the tree");
}

/// #1761 (zpectral): on Teldrassil's southern rim (60.2,71.6), bound for Vesprystus, the flight master in Rut'theran
/// Village (58.4,93.93) at the foot of the tree, the arrow drew a walk straight down the trunk. No walk joins the two
/// (the walking grid reaches neither from the other) and the fall from the rim kills (recorded descents); the
/// way down is through Darnassus and its portal. Rut'theran is an area of Teldrassil's map no walk joins to the rest
/// (crossings.json `areas`): a zone of its own to the planner. From Dolanaar too.
fn rutheran_flight_master_from(from: (i64, f64, f64)) {
	skip_unless_ready!();
	let out = teldrassil_route(from, (1438, 58.4, 93.93, "Vesprystus"));
	let (kinds, transports) = (strs(&out["kinds"]), strs(&out["transports"]));
	assert!(transports.iter().any(|t| t == "portal-ruttheran"), "the Darnassus portal down ({}; {})", kinds.join(", "), transports.join(", "));
	assert_eq!(f(&out["treeWalks"]), 0.0, "no walk leg joins the top of the tree to Rut'theran ({}; {})", kinds.join(", "), transports.join(", "));
}

#[test]
fn t_1761_from_teldrassils_rim_to_the_rutheran_flight_master_the_route_takes_the_darnassus_portal_down_never_a_walk_off_the_tree() {
	rutheran_flight_master_from((1438, 60.2, 71.6));
}

#[test]
fn t_1761_from_dolanaar_to_the_rutheran_flight_master_the_route_takes_the_darnassus_portal_down_never_a_walk_off_the_tree() {
	rutheran_flight_master_from((1438, 55.9, 59.8));
}

// Same pattern (controller handover): Dolanaar <-> Auberdine must not walk between the top of Teldrassil and the
// Rut'theran dock; the way is Darnassus' portal and the boat (or a flight from Rut'theran).
fn dolanaar_auberdine(from: (i64, f64, f64), to: (i64, f64, f64, &str)) {
	skip_unless_ready!();
	let out = teldrassil_route(from, to);
	let kinds = strs(&out["kinds"]);
	assert!(!kinds.is_empty(), "a route is planned");
	assert_eq!(f(&out["treeWalks"]), 0.0, "no walk leg joins Rut'theran to the top of the tree ({}; {})", kinds.join(", "), strs(&out["transports"]).join(", "));
}

#[test]
fn acceptance_dolanaar_auberdine_from_dolanaar_to_auberdine_no_walk_leg_joins_the_top_of_teldrassil_to_rutheran() {
	dolanaar_auberdine((1438, 56.73, 61.9), (1439, 36.8, 44.3, "Auberdine"));
}

#[test]
fn acceptance_dolanaar_auberdine_from_auberdine_to_dolanaar_no_walk_leg_joins_the_top_of_teldrassil_to_rutheran() {
	dolanaar_auberdine((1439, 36.8, 44.3), (1438, 55.9, 59.8, "Dolanaar"));
}

/// A Horde character at `level` with no flight path known walks from Tarren Mill (Hillsbrad 60.79,19.92) to
/// `to` (uiMapID, x, y, name): a flight map has opened in the Eastern Kingdoms and listed none (flags.taxiSeen), so
/// no flight master there is one it may have (#1795). The planned legs' kinds and the yards each zone's ground takes of the walk legs
/// (by uiMapID, the router's own zone field every 20 yd), and Nav.danger.Mult at that level for Alterac Mountains.
/// `p10`: price every zone from its P10 as before #1490 (Maps.GetZoneLevels without the danger floor).
fn tarren_mill_walk(level: u32, to: (u32, f64, f64, &str), p10: bool, travel: Option<bool>) -> Value {
	let check_ground = travel.is_some();
	let travel = travel.unwrap_or(true);
	run(
		&format!(
			r#"
		if {p10} then
			local get = Polestar.Maps.GetZoneLevels
			Polestar.Maps.GetZoneLevels = function(id) local lo, hi = get(id) return lo, hi, lo end
		end
		w.faction = "Horde"
		w.setLevel({level})
		local c, wx, wy = C.MapToWorld(1424, 60.79, 19.92, "e")
		place(1424, wx, wy)
		Polestar.CharState().flags.taxi = {{}}
		Polestar.CharState().flags.taxiSeen = {{ [0] = true }}
		if not {travel} then Polestar.Set("nav.travel", false) end
		N.SetTarget({}, {}, {}, "{}", "e")
		for _ = 1, 600 do stub.advance(0.05); aim() end
		local legs, ci = N.GetRoute()
		local kinds, yards = {{}}, {{}}
		local _, tx, ty = N.GetTargetWorld()
		local lastX, lastY, off = wx, wy, 0
		local chord = {{ {{x=wx,y=wy}}, {{x=tx,y=ty}} }}
		if {check_ground} then
			assert(aim().measured and (not {travel} or (legs and legs[ci])))
		end
		for i = ci or 1, #(legs or {{}}) do kinds[#kinds + 1] = legs[i].kind end
		for _, leg in ipairs(N.GetRouteGeometry().legs) do
			if leg.kind == "walk" then
				local pts = leg.pts
				if {check_ground} then
					assert(#pts >= 2 and dist(lastX, lastY, pts[1][2], pts[1][3]) < 1, "gap between drawn legs")
					lastX, lastY = pts[#pts][2], pts[#pts][3]
				end
				for i = 2, #pts do
					local ax, ay, bx, by = pts[i - 1][2], pts[i - 1][3], pts[i][2], pts[i][3]
					if {check_ground} then off = math.max(off, offPath(chord, bx, by)) end
					local d = dist(ax, ay, bx, by)
					local n = math.max(1, math.ceil(d / 20))
					for k = 0, n - 1 do
						local s = (k + 0.5) / n
						local z = tostring(E.ZoneAt(c, ax + (bx - ax) * s, ay + (by - ay) * s) or 0)
						yards[z] = (yards[z] or 0) + d / n
					end
				end
			end
		end
		if {check_ground} then assert(dist(lastX, lastY, tx, ty) < 1 and off > 100, "incomplete or straight fallback") end
		for z, y in pairs(yards) do yards[z] = floor(y + 0.5) end
		local price
		if not {travel} then
			local f = finds[#finds]
			assert(f and f.done and f.points and #f.points > 2 and type(f.cost) == "number")
			assert(dist(f.from[1], f.from[2], wx, wy) < 1 and dist(f.to[1], f.to[2], tx, ty) < 1)
			price = f.cost
		end
		emit({{ kinds = kinds, yards = yards, price = price, alterac = N.danger.Mult({level}, 1416) }})"#,
			to.0,
			js(to.1),
			js(to.2),
			to.3
		),
		true,
	)
}

/// #566 (dogoku), Horde, level 24: from Tarren Mill (Hillsbrad 60.79,19.92) to Nurse Neela in Brill (Tirisfal
/// 61.82,52.83) with no flight path known to Polestar, the route walked 1471 yd through Western Plaguelands (levels
/// 51-57) and 1399 yd through Alterac Mountains: the planner's straight walks between zone crossings never counted
/// the zones of their own two ends (Danger.Along), so a walk from one Plaguelands crossing to the next was safe ground.
#[test]
fn zone_danger_566_tarren_mill_to_brill_at_level_24_with_no_flight_path_known_walks_no_yard_of_western_plaguelands() {
	skip_unless_ready!();
	let out = tarren_mill_walk(24, (1420, 61.82, 52.83, "Nurse Neela"), false, None);
	let kinds = strs(&out["kinds"]);
	assert!(!kinds.is_empty() && kinds.iter().all(|k| k == "walk"), "it walks ({})", kinds.join(", "));
	assert!(out["yards"]["1420"].as_f64().unwrap_or(0.0) > 0.0, "to Tirisfal: {}", out["yards"]);
	assert_eq!(out["yards"]["1422"].as_f64().unwrap_or(0.0), 0.0, "no yard of Western Plaguelands (51-57): {}", out["yards"]);
}

// #1728: the old walk south from Camp Taurajo to Feegly cut through Bael Modan's Alliance guards.
// A paid alternative to Freewind still needs a walk from the upper Great Lift. The same ticket
// is usable if the flight master is the destination rather than a transfer to that walk.
// Main, 2026-11-21, Fitz: "go back to our original danger pathing": the guards refuse no walk, so a walking route may
// stand at once; no flight is sold before its onward walk is priced.
#[test]
fn camp_taurajo_does_not_sell_a_flight_on_an_unchecked_walk_to_feegly_1728() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		w.setLevel(27)
		Polestar.CharState().flags.taxi = { [22] = true, [23] = true, [25] = true, [77] = true }
		place(1413, -2380.7, -1882.7, 95.8)
		function GetTaxiMapID() return 1414 end
		C_TaxiMap = C_TaxiMap or {}
		function C_TaxiMap.GetAllTaxiNodes()
			return { {nodeID=77,state=0,slotIndex=1}, {nodeID=25,state=1,slotIndex=2}, {nodeID=30,state=1,slotIndex=3} }
		end
		stub.fire("TAXIMAP_OPENED", 0)
		N.SetTarget(1413, 48.97, 86.31, "Feegly", "e")
		local a = aim()
		local legs = N.GetRoute()
		local sold = false
		for _, l in ipairs(legs or {}) do if l.kind == "fly" then sold = true end end
		local waiting = { state=a.state, bearing=a.x~=nil, sold=sold }
		local x, y = C.WorldToMap(1, -5407.7, -2414.3, 1441)
		N.SetTarget(1441, x, y, "Freewind flight master")
		local nextAim, leg = aim(), N.travel.CurrentLeg()
		emit({ waiting=waiting, flight=leg and leg.kind, node=leg and leg.to.id, ticket=leg and leg.taxiOffer~=nil, state=nextAim.state })"#,
		true,
	);
	assert_eq!(out["waiting"], serde_json::json!({"state":"routing","bearing":true,"sold":false}));
	assert_eq!((out["state"].as_str(), out["flight"].as_str(), out["node"].as_i64(), out["ticket"].as_bool()), (Some("instruction"), Some("fly"), Some(30), Some(true)));
}

#[test]
fn camp_taurajo_uses_its_checked_road_instead_of_flying_back_to_a_more_distant_landing() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		w.setLevel(27)
		Polestar.CharState().flags.taxi = { [22]=true, [23]=true, [25]=true, [77]=true }
		local _, px, py = C.MapToWorld(1413,44.64,58.88,"e")
		place(1413,px,py,95.9006)
		-- Same southern road, on the open side of the Bael guards.
		local x,y = C.WorldToMap(1,-3906.25,-2135.4166666666665,1413)
		N.SetTarget(1413,x,y,"Barrens road",nil,nil,92)
		local c,gx,gy,gz=N.GetTargetWorld()
		local xr
		for _,n in ipairs(N.GetTravelData().taxi) do if n.id==25 then xr=n end end
		local rx,ry=xr.wx,xr.wy
		local pc,walkYards,xc,remoteYards,checked,farChecked; local flew=false
		for i=1,1800 do
			local a=aim(); local legs,ci=N.GetRoute()
			for k=ci or 1,#(legs or {}) do if legs[k].kind=="fly" then flew=true end end
			local cost=N.walk.Measured(c,gx,gy,false,gz)
			if cost then
				pc,walkYards,checked=cost(c,px,py,true,95.9006)
				xc,remoteYards,farChecked=cost(c,rx,ry,false,xr.z)
				if type(pc)=="number" and type(xc)=="number" and a.measured then break end
				if pc and xc==nil then N.walk.Measure(c,gx,gy,false,{{wx=px,wy=py,z=95.9006,start=true},{wx=rx,wy=ry,z=xr.z,chosen=true}},gz) end
			end
			stub.advance(.05)
		end
		local a=aim()
		emit({walk=walkYards,remote=remoteYards,checked=type(checked)=="table" and type(farChecked)=="table",measured=a.measured,visible=a.x~=nil,
			straight=dist(rx,ry,gx,gy),direct=dist(px,py,gx,gy),flew=flew})"#,
		true,
	);
	assert_eq!(out["flew"], false, "never send the player back to a distant flight master: {out}");
	assert_eq!((&out["measured"], &out["visible"], &out["checked"]), (&Value::Bool(true), &Value::Bool(true), &Value::Bool(true)));
	assert!(f(&out["straight"]) > 3000.0 && f(&out["walk"]) > f(&out["direct"]) && f(&out["remote"]) > f(&out["walk"]), "both walks are priced on their own ground: {out}");
}

// A later walk's own search that finds nothing (its answer kept as `false`) while that walk's sketch
// (Path.FindCoarse) is still out: the sketch's answer indexed the `false` and raised "attempt to index local
// 'was' (a boolean value)" (Nav/Walk.lua pumpShapes, found replaying players' walks). The sketch never goes over the
// walk's own answer, a failed one included.
#[test]
fn a_later_walks_failed_search_answered_before_its_sketch_is_kept_and_raises_no_error() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(20)
		w.faction = "Horde"
		local held, failed = {}, 0
		local realFind = E.Find
		E.FindCoarse = function(map, from, to, callback) held[#held + 1] = callback return { held = true } end
		E.Find = function(map, from, to, callback, opts)
			local _, px, py = C.GetPlayerWorldPosition()
			if math.sqrt((from.x - px) ^ 2 + (from.y - py) ^ 2) < 30 then return realFind(map, from, to, callback, opts) end
			failed = failed + 1
			C_Timer.After(0, function() callback(nil) end)
			return { failed = true }
		end
		place(1412, -975, -107, nil)
		N.SetTarget(1442, 47.5, 61.5, "Stonetalon", "e")
		for _ = 1, 600 do aim(); stub.advance(0.05) end
		local errors = {}
		for _, cb in ipairs(held) do
			local ok, err = pcall(cb, nil, "none")
			if not ok then errors[#errors + 1] = tostring(err) end
		end
		for _ = 1, 20 do aim(); stub.advance(0.05) end
		emit({ held = #held, failed = failed, errors = errors })"#,
		false,
	);
	assert!(f(&out["held"]) >= 1.0 && f(&out["failed"]) >= 1.0, "a sketch out and a later walk's search failed: {out}");
	assert!(out["errors"].as_array().map_or(out["errors"] == serde_json::json!({}), |a| a.is_empty()), "no Lua error: {out}");
}

/// #1490 (Malifax), replayed: from Tarren Mill to Archmage Modera's image at the Dalaran wall
/// (Silverpine 68.6,45.2, where 0.3.6 places her) at level 26. Alterac Mountains' lowest level is 24 (the P10,
/// pulled down by the Lordamere Lake murlocs and the bears on the Hillsbrad border), so from level 21 up the zone
/// never counted as dangerous while Strahnbrad, the Crushridge ogres and the Syndicate are 30-40. With its danger
/// floor (30) it costs x3 at 26: both travel plans walk, the floor's with fewer yards of Alterac, as in 0.4.1.1 (Main,
/// 2026-11-21, Fitz: "go back to our original danger pathing"; 0.4.2's guarded-crossing approaches, which kept both
/// plans on the southern border's road, went with the enemy-ground veto). The walking-only arrow to the same marker
/// still crosses Alterac, but spends fewer yards there when priced at x3.
#[test]
fn zone_danger_1490_alterac_counts_from_its_danger_floor_at_level_26_the_walk_to_modera_crosses_less_of_it() {
	skip_unless_ready!();
	let to = (1421, 68.6, 45.2, "Image of Archmage Modera");
	let now = tarren_mill_walk(26, to, false, Some(true));
	let before = tarren_mill_walk(26, to, true, Some(true));
	eprintln!("1490 replay: floor {now}\n             P10 {before}");
	let alterac = |v: &Value| v["yards"]["1416"].as_f64().unwrap_or(0.0);
	assert_eq!((now["alterac"].clone(), before["alterac"].clone()), (serde_json::json!(3), serde_json::json!(1)), "x3 from the floor, x1 from the P10");
	for v in [&now, &before] {
		let kinds = strs(&v["kinds"]);
		assert!(!kinds.is_empty() && kinds.iter().all(|k| k == "walk"), "expected a real all-ground itinerary, got {v}");
	}
	assert!(alterac(&now) < alterac(&before), "fewer yards of Alterac Mountains: {} with the floor, {} without", alterac(&now), alterac(&before));
	let direct = tarren_mill_walk(26, to, false, Some(false));
	let unweighted = tarren_mill_walk(26, to, true, Some(false));
	assert!(alterac(&direct) > 0.0 && alterac(&direct) < alterac(&unweighted), "soft cost, not exclusion: {direct} vs {unweighted}");
	assert!(f(&direct["price"]) > f(&unweighted["price"]), "the walking engine must charge for traversing Alterac");
}

/// #3447 (0.4.2.1 arrow audit): a Horde 30 on Battle of Hillsbrad, at Tarren Mill (Hillsbrad 60.79,19.92), sent by the
/// guide to Farmer Kalaba in Hillsbrad Fields (35.05,46.20), the Alliance's farm: 0.4.2 refused every walk into it, a
/// straight bearing with "No safe walking route" the whole 800 yd. Main, 2026-11-21, Fitz: "go back to our original
/// danger pathing": the walk in, with the hostile-town caption, and from Kalaba the walk back out to High Executor
/// Darthalia (62.3,20.3), as before 0.4.2.
#[test]
fn enemy_ground_3447_hillsbrad_fields_is_walked_into_and_out_of() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		w.setLevel(30)
		Polestar.CharState().flags.taxi = {}
		Polestar.CharState().flags.taxiSeen = { [0] = true }
		local c, mx, my = C.MapToWorld(1424, 60.79, 19.92, "e")
		place(1424, mx, my)
		local function go(x, y, label)
			Polestar.Fire("WAYPOINT_CHANGED", { map = 1424, x = x, y = y, f = "e", label = label, kind = "kill", r = 5 })
			local a, n = aim(), 0
			while not a.measured and n < 400 do stub.advance(0.05); n = n + 1; a = aim() end
			local legs, ci = N.GetRoute()
			local kinds = {}
			for i = ci or 1, #(legs or {}) do kinds[#kinds + 1] = legs[i].kind end
			local walk = legs and legs[ci]
			local _, tx, ty = N.GetTargetWorld()
			local geo, last = N.GetRouteGeometry().legs, nil
			for _, leg in ipairs(geo) do if leg.kind == "walk" then last = leg.pts[#leg.pts] end end
			return { state = a.state, measured = a.measured, caption = N.noWalk or false, kinds = table.concat(kinds, ","),
				hub = walk and N.travel.HubText(walk) or false, reaches = last ~= nil and dist(last[2], last[3], tx, ty) < 1 }
		end
		local into = go(35.05, 46.20, "Farmer Kalaba")
		local _, kx, ky = C.MapToWorld(1424, 35.05, 46.20, "e")
		place(1424, kx, ky)
		local out = go(62.3, 20.3, "High Executor Darthalia")
		emit({ into = into, out = out })"#,
		true,
	);
	assert_eq!(
		out["into"],
		serde_json::json!({"state":"travel","measured":true,"caption":false,"kinds":"walk","hub":"Hostile town: Hillsbrad Fields","reaches":true}),
		"into the guide's goal on enemy ground"
	);
	assert_eq!(
		(&out["out"]["state"], &out["out"]["measured"], &out["out"]["caption"], &out["out"]["kinds"], &out["out"]["reaches"]),
		(&serde_json::json!("travel"), &serde_json::json!(true), &serde_json::json!(false), &serde_json::json!("walk"), &serde_json::json!(true)),
		"out of it, back to Tarren Mill: {}",
		out["out"]
	);
}

/// A walk that passes Southshore, from the road north of the town to the road south of it, for a Horde 30. 0.4.2
/// refused any walk through it. Main, 2026-11-21, Fitz: "go back to our original danger pathing": a route, round the
/// town where the router finds a way or through it, said either way, as before 0.4.2.
#[test]
fn a_horde_walk_past_southshore_is_a_route_with_its_warning() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		w.setLevel(30)
		Polestar.CharState().flags.taxi = {}
		Polestar.CharState().flags.taxiSeen = { [0] = true }
		place(1424, -416, -533)
		local x, y = C.WorldToMap(0, -1216, -533, 1424)
		N.SetTarget(1424, x, y, "South of Southshore")
		local a, n = aim(), 0
		while not a.measured and n < 400 do stub.advance(0.05); n = n + 1; a = aim() end
		local legs, ci = N.GetRoute()
		local walk = legs and legs[ci]
		emit({ state = a.state, measured = a.measured, caption = N.noWalk or false, kind = walk and walk.kind or false,
			said = walk and (N.travel.HubText(walk) or N.travel.AvoidText(walk)) or false })"#,
		true,
	);
	assert_eq!(
		(&out["state"], &out["measured"], &out["caption"], &out["kind"]),
		(&serde_json::json!("travel"), &serde_json::json!(true), &serde_json::json!(false), &serde_json::json!("walk")),
		"a walk: {out}"
	);
	assert!(out["said"].as_str().unwrap_or("").contains("Southshore"), "the town named: {out}");
}

/// Fitz in game (2026-11-21): a waypoint set by hand in Dalaran (Alterac Mountains 20.83,78.21), a guarded hub, from
/// the road east of it (17.26,64.29) on a Horde 30, said "No safe walking route". Main, 2026-11-21, Fitz: "go back to
/// our original danger pathing": a route in, with the hostile-town caption; the walking maps reach the pin.
#[test]
fn a_pin_set_by_hand_in_dalaran_is_a_route_with_its_warning() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		w.setLevel(30)
		Polestar.CharState().flags.taxi = {}
		Polestar.CharState().flags.taxiSeen = { [0] = true }
		local c, px, py = C.MapToWorld(1416, 17.26, 64.29, "e")
		place(1416, px, py)
		N.SetTarget(1416, 20.83, 78.21, "Dalaran pin", "e")
		local a, n = aim(), 0
		while not a.measured and n < 400 do stub.advance(0.05); n = n + 1; a = aim() end
		local legs, ci = N.GetRoute()
		local said
		for i = ci or 1, #(legs or {}) do said = said or N.travel.HubText(legs[i]) end
		local _, tx, ty = N.GetTargetWorld()
		local geo, last = N.GetRouteGeometry().legs, nil
		for _, leg in ipairs(geo) do if leg.kind == "walk" then last = leg.pts[#leg.pts] end end
		emit({ state = a.state, measured = a.measured, caption = N.noWalk or false, said = said or false,
			reaches = last ~= nil and dist(last[2], last[3], tx, ty) < 1 })"#,
		true,
	);
	assert_eq!(out, serde_json::json!({"state":"travel","measured":true,"caption":false,"said":"Hostile town: Dalaran","reaches":true}));
}

/// #3450 (0.4.2.1 arrow audit): an Alliance Skyborne at Rathiril Sunlance in Shen'dar Village (Zephras Isle 44.96,46.29)
/// sent to Coriella Calmbreeze (43.05,43.30), 150 yd away past the corner of the village's guard posts (the Horde's on
/// the ground data). 0.4.2 refused the straight line through them and sent the player 1,600 yd to a portal, then
/// straight to her again wherever the line came clear: never arriving. Main, 2026-11-21, Fitz: "go back to our original
/// danger pathing": her walk, as before 0.4.2.
#[test]
fn near_target_3450_coriella_is_a_walk_not_a_portal() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Alliance"
		w.setLevel(4)
		local c, rx, ry = C.MapToWorld(2521, 44.96, 46.29)
		place(2521, rx, ry)
		for _ = 1, 20 do stub.advance(0.05); aim() end
		Polestar.Fire("WAYPOINT_CHANGED", { map = 2521, x = 43.05, y = 43.30, label = "Coriella Calmbreeze", kind = "talk", r = 5 })
		local a, n = aim(), 0
		while not a.measured and n < 400 do stub.advance(0.05); n = n + 1; a = aim() end
		local legs, ci = N.GetRoute()
		local kinds = {}
		for i = ci or 1, #(legs or {}) do kinds[#kinds + 1] = legs[i].kind end
		emit({ kinds = table.concat(kinds, ","), state = a.state, measured = a.measured, caption = N.noWalk or false,
			yards = floor(a.dist or 0) })"#,
		true,
	);
	let kinds = out["kinds"].as_str().unwrap_or("");
	assert!(kinds.is_empty() || kinds.split(',').all(|k| k == "walk"), "no portal, only the walk: {out}");
	assert_eq!((&out["state"], &out["measured"], &out["caption"]), (&serde_json::json!("travel"), &serde_json::json!(true), &serde_json::json!(false)), "her walk: {out}");
	assert!(f(&out["yards"]) < 400.0, "a walk of a few hundred yards, not a portal's 3 km: {out}");
}

/// #1972 (Rexen, Dwarf Shaman 37, 0.3.7.2): on "Go to Watcher Biggs" (Swamp of Sorrows 26.7,59.8 on the game's map), at
/// Stormwind the arrow said to fly to Darkshire, and at Darkshire to fly on to Lakeshire and walk through the
/// Riverglades round the coast, past Farholde Keep's flight master. From Darkshire the way is the walk east along the
/// road through Deadwind Pass; from Stormwind, the flight to Darkshire and that walk. Flight paths known: Stormwind,
/// Sentinel Hill, Lakeshire, Ironforge and Darkshire (flight maps opened on both continents).
#[test]
fn t_1972_from_darkshire_watcher_biggs_is_the_walk_through_deadwind_pass_not_a_flight_to_lakeshire_and_the_coast() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(37)
		w.faction = "Alliance"
		w.race, w.raceName = "Dwarf", "Dwarf"
		local flags = Polestar.CharState().flags
		flags.taxi = { [2] = true, [4] = true, [5] = true, [6] = true, [12] = true }
		flags.taxiSeen = { [0] = true, [1] = true }
		local function route()
			local legs, ci = N.GetRoute()
			local out = {}
			for i = ci or 1, legs and #legs or 0 do
				local l = legs[i]
				out[#out + 1] = l.kind .. "|" .. tostring(l.label) .. "|" .. tostring(l.seconds) .. "|" .. tostring(l.engine)
			end
			return out
		end
		local function from(map, x, y)
			N.ClearTarget()
			local _, px, py = C.MapToWorld(map, x, y, "e")
			place(map, px, py, nil)
			for _ = 1, 10 do aim(); stub.advance(0.05) end
			N.SetTarget(1435, 26.7, 59.8, "Watcher Biggs", "e")
			for _ = 1, 400 do aim(); stub.advance(0.05) end
			local r = { route = route() }
			-- The walks the engine measured into the target, from the flight masters of the way.
			local tc, tx, ty, tz = N.GetTargetWorld()
			local measured = N.walk.Measured(tc, tx, ty, false, tz)
			if measured then
				r.measured = {}
				local names = { Darkshire = "darkshire", Lakeshire = "lakeshire", ["Farholde Keep"] = "farholde" }
				for _, node in ipairs(N.GetTravelData().taxi) do
					local name = names[node.name]
					if name then
						local cost, yd = measured(node.c, node.wx, node.wy, false, node.z)
						r.measured[name] = { cost = cost or false, yards = yd or false }
					end
				end
			end
			return r
		end
		emit({ darkshire = from(1431, 77.6, 44.4), stormwind = from(1453, 66.3, 62.7) })"#,
		true,
	);
	let darkshire = strs(&out["darkshire"]["route"]);
	assert!(!darkshire.is_empty() && darkshire.iter().all(|l| l.starts_with("walk|")), "from Darkshire: on foot ({darkshire:?}, measured {})", out["darkshire"]["measured"]);
	let stormwind = strs(&out["stormwind"]["route"]);
	assert!(stormwind.iter().any(|l| l.starts_with("fly|Fly to Darkshire")), "from Stormwind: the flight to Darkshire ({stormwind:?})");
	assert!(!stormwind.iter().any(|l| l.contains("Lakeshire")), "never Lakeshire ({stormwind:?})");
}

/// #1834 (Konky88, Troll Shaman 35, 0.3.6): in Booty Bay (Stranglethorn 27.11,76.93) on the Stranglethorn Vale step
/// "Grom'gol", bound for Commander Aggro'gosh (32.17,28.90) with Grom'gol's flight path known and "Use TomTom's arrow"
/// on, he walked up the coast: Polestar's plan flew from Booty Bay's flight master, but TomTom's arrow, which guides
/// in its place, was handed only the far target. While TomTom's arrow guides a route, its waypoint is the current
/// leg's stop: Booty Bay's flight master, then the target once the last walk begins (in Grom'gol).
#[test]
fn t_1834_with_tomtom_s_arrow_tomtom_is_handed_booty_bays_flight_master_for_the_flight_to_gromgol_not_the_far_target() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		w.race, w.raceName = "Troll", "Troll"
		w.setLevel(35)
		Polestar.CharState().flags.taxi = { [18] = true, [20] = true } -- Booty Bay and Grom'gol (Horde)
		local adds = {}
		stub.addonsLoaded.TomTom = true -- TomTom itself, loaded (only TomTom gets the mirror)
		TomTom = {}
		function TomTom:AddWaypoint(m, x, y, opts) adds[#adds + 1] = { map = m, x = x * 100, y = y * 100, title = opts.title, crazy = opts.crazy }; return #adds end
		function TomTom:RemoveWaypoint() end
		Polestar.Set("nav.tomtom", true)
		Polestar.Set("nav.useTomTomArrow", true)
		local _, bx, by = C.MapToWorld(1434, 27.11, 76.93)
		place(1434, bx, by, 0)
		N.SetTarget(1434, 32.17, 28.90, "Accept The Defense of Grom'gol")
		for _ = 1, 400 do stub.advance(0.05); aim() end
		local legs, ci = N.GetRoute()
		local kinds = {}
		for i = ci or 1, #(legs or {}) do kinds[#kinds + 1] = legs[i].kind end
		local first = adds[1]
		local last = adds[#adds]
		-- Landed in Grom'gol: the last walk, to the target itself.
		local _, gx, gy = C.MapToWorld(1434, 32.51, 29.28)
		place(1434, gx, gy, 0)
		stub.fire("ZONE_CHANGED_NEW_AREA")
		for _ = 1, 100 do stub.advance(0.05); aim() end
		emit({ kinds = kinds, guides = N.TomTomArrowGuides(), atBootyBay = last, first = first, landed = adds[#adds], n = #adds })"#,
		true,
	);
	assert!(strs(&out["kinds"]).iter().any(|k| k == "fly"), "the plan flies ({:?})", out["kinds"]);
	assert_eq!(out["guides"], true, "TomTom's arrow guides");
	let at = &out["atBootyBay"];
	let d = (f(&at["x"]) - 26.82).hypot(f(&at["y"]) - 77.0);
	assert!(d < 0.3, "TomTom's waypoint is Booty Bay's flight master (26.82,77), not Commander Aggro'gosh: {at}");
	let landed = &out["landed"];
	let dl = (f(&landed["x"]) - 32.17).hypot(f(&landed["y"]) - 28.9);
	assert!(dl < 0.3, "in Grom'gol it is the target: {landed}");
}

/// #2156 (Joogz, Orc Shaman 34) / #2377 (DJ, Tauren Hunter 34): Horde players bound for Gnomeregan were flown to
/// Hammerfall and walked through Dun Morogh, though Scooty's Transpolyporter in Booty Bay puts a player carrying the
/// Goblin Transponder (9173, from Gnomer-gooooone!) on the Train Depot's pad by Gnomeregan's back door. A Troll at
/// Scooty (Stranglethorn 27.60,77.44), Booty Bay, Grom'gol, Hammerfall and Orgrimmar known, guided to Gnomeregan's
/// door (Dun Morogh 24.3,39.8): `transponder` puts the item in the bags. The route's legs, "kind|label".
fn gnomeregan_from_booty_bay(transponder: bool) -> Vec<String> {
	let script = format!(
		r#"
		w.faction = "Horde"
		w.race, w.raceName = "Troll", "Troll"
		w.setLevel(34)
		Polestar.CharState().flags.taxi = {{ [17] = true, [18] = true, [20] = true, [23] = true }}
		Polestar.CharState().flags.taxiSeen = {{ [0] = true, [1] = true }}
		{}
		local _, bx, by = C.MapToWorld(1434, 27.60, 77.44)
		place(1434, bx, by, nil)
		N.SetTarget(1426, 24.3, 39.8, "Enter Gnomeregan")
		for _ = 1, 400 do stub.advance(0.05); aim() end
		local legs, ci = N.GetRoute()
		local route = {{}}
		for i = ci or 1, legs and #legs or 0 do route[#route + 1] = legs[i].kind .. "|" .. legs[i].label end
		emit({{ route = route }})"#,
		if transponder { "w.addItem(9173, 1)" } else { "" }
	);
	strs(&run(&script, true)["route"])
}

#[test]
fn issue_2156_with_the_goblin_transponder_the_way_to_gnomeregan_from_booty_bay_is_scootys_transpolyporter() {
	skip_unless_ready!();
	let route = gnomeregan_from_booty_bay(true);
	assert!(route.iter().any(|l| l == "portal|Take the portal to Gnomeregan"), "the Transpolyporter: {}", route.join(", "));
	assert!(!route.iter().any(|l| l.starts_with("fly|")), "no flight to Hammerfall: {}", route.join(", "));
	let without = gnomeregan_from_booty_bay(false);
	assert!(!without.iter().any(|l| l.starts_with("portal|")), "no Goblin Transponder, no Transpolyporter: {}", without.join(", "));
}

/// #1242 (joshvette001) / #1829 (derschroeb): on the way to the Deeprun Tram in Stormwind, the arrow led up into the
/// Keep's Royal Gallery. The tram's Stormwind end lies down its building in the Dwarven District, past the door
/// (66.47,34.03 on the game's map), under the gallery; the walking grid let the walk from the street south of the door
/// (#1829's spot in the canals, 70.14,47.26) cut across to it, so the arrow pointed at the Keep. An approach chain
/// (crossings.json `deeprun-tram-stormwind`, from players' recorded walks in) seals the end: the walk goes to the door,
/// then in.
#[test]
fn t_1242_from_the_canals_the_walk_to_the_deeprun_tram_goes_through_its_door_not_across_to_the_end_under_the_keep() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Alliance"
		w.race, w.raceName = "Human", "Human"
		w.setLevel(22)
		local DOOR = { -8390.0, 568.0 }
		local _, px, py = C.MapToWorld(1453, 70.14, 47.26)
		place(1453, px, py, nil)
		N.SetTarget(1455, 30.0, 62.0, "Ironforge")
		for _ = 1, 400 do stub.advance(0.05); aim() end
		local legs, ci = N.GetRoute()
		local r = { kinds = {}, viaDoor = false }
		for i = ci or 1, #(legs or {}) do
			local l = legs[i]
			r.kinds[#r.kinds + 1] = l.kind
			if l.kind == "walk" and l.to and dist(l.to.wx, l.to.wy, DOOR[1], DOOR[2]) < 8 then r.viaDoor = true end
		end
		-- The first search: from the canals, it must end at the door, not at the tram's end.
		local f = finds[1]
		local last = f and f.points and f.points[#f.points]
		r.firstTo = last and { floor(last.x), floor(last.y) } or false
		r.firstToDoor = last and dist(last.x, last.y, DOOR[1], DOOR[2]) or false
		emit(r)"#,
		true,
	);
	assert!(strs(&out["kinds"]).iter().any(|k| k == "tram"), "the route takes the tram ({:?})", out["kinds"]);
	assert_eq!(out["viaDoor"], true, "a walk leg ends at the tram building's door: {out}");
	assert!(f(&out["firstToDoor"]) < 10.0, "the first walk ends at the door: {out}");
}

// #1543: Darkcloud Pinnacle, Thousand Needles. Lakota Windsong (10646, 37.95,26.45, z 83.7) stands on the pinnacle's
// top, which the walking maps join to the Barrens' plateau past the Great Lift's top (the climb from the canyon floor
// over the rope bridges is a TravelData chain). From the Barrens' side of the lift (44.64,89.30, MrM00se's place,
// 380 yd from her: too near for the engine to measure the walk) the planner's zone rule (the Barrens to Thousand
// Needles: through a crossing) sent the player down the lift, and from its foot the arrow's walk led up it again.
// A Horde player at level 28: from there the walk on to her (the near walk, which the arrow's own search finds short
// along the plateau), neither the crossing nor the lift; from the pinnacle's top one walk; from the canyon floor and
// the lift's foot, a route that ends with the walk to her and never takes the crossing back down.
#[test]
fn darkcloud_pinnacle_from_the_great_lifts_top_the_route_to_lakota_windsong_walks_on_never_back_down_the_lift_1543() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(28)
		w.faction = "Horde"
		local function legs()
			local out = {}
			local L, ci = N.GetRoute()
			for i = ci or 1, #(L or {}) do
				local l = L[i]
				out[#out + 1] = l.kind .. "|" .. tostring(l.label) .. (l.crossing and ("|" .. l.crossing) or "")
			end
			return out
		end
		local function plan(map, x, y, z)
			w.moveTo(map, x, y)
			w.z = z
			for _ = 1, 10 do aim(); stub.advance(0.05) end
			N.SetTarget(1441, 37.95, 26.45, "Lakota Windsong", "e", nil, 83.7)
			for _ = 1, 300 do aim(); stub.advance(0.05) end
			return legs()
		end
		emit({
			top = plan(1441, 38.11, 26.87, 83),
			barrens = plan(1413, 44.64, 89.30, 90),
			floor = plan(1441, 31.2, 36.72, -46),
			lift = plan(1441, 31.92, 24.22, -44),
		})"#,
		true,
	);
	let legs = |k: &str| strs(&out[k]);
	assert_eq!(legs("top"), ["walk|Lakota Windsong"], "on the pinnacle: one walk");
	let barrens = legs("barrens");
	assert!(barrens.last().is_some_and(|x| x == "walk|Lakota Windsong"), "from the lift's top: on to her ({barrens:?})");
	assert!(!barrens.iter().any(|x| x.starts_with("lift|") || x.ends_with("|carbonite-the-barrens--thousand-needles")), "from the lift's top: along the plateau, not back down the lift ({barrens:?})");
	for k in ["floor", "lift"] {
		let l = legs(k);
		assert!(!l.is_empty(), "{k}: a route");
		assert!(l.last().is_some_and(|x| x == "walk|Lakota Windsong"), "{k}: on to her ({l:?})");
		assert!(!l.iter().any(|x| x.ends_with("|carbonite-the-barrens--thousand-needles")), "{k}: never the crossing back down ({l:?})");
	}
}

#[test]
fn mesa_elevator_boards_the_departure_floor_in_both_directions() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		w.setLevel(28)
		local function boarding(x, y, z, tx, ty, tz)
			N.SetTarget(nil)
			w.moveTo(1441, x, y)
			w.z = z
			for _ = 1, 10 do aim(); stub.advance(0.05) end
			N.SetTarget(1441, tx, ty, "Destination", "e", nil, tz)
			for _ = 1, 300 do aim(); stub.advance(0.05) end
			local legs = N.GetRoute()
			for _, leg in ipairs(legs or {}) do
				if leg.kind == "lift" then return { leg.side, leg.to.z > leg.from.z } end
			end
			return false
		end
		local up = boarding(31.92, 24.22, -44, 37.95, 26.45, 83.7)
		local down = boarding(37.95, 26.45, 83.7, 31.92, 24.22, -44)
		emit({up, down})"#,
		true,
	);
	assert_eq!(out, serde_json::json!([["bottom", true], ["top", false]]));
}

// Two reports from 0.3.7.2 on Darkcloud Pinnacle (Thousand Needles), Horde at level 30. #2391: on the pinnacle, the
// route to the Document Chest up on its mesas went down the lift to the ground under them. #2292: from the Great
// Lift's top, the route to the Grimtotem camps by Arnak Grimtotem went into the Barrens and back again. Since 0.4.0's
// walking maps (the pinnacle's paths and bridges joined) the route walks on across the mesas: never a lift, never the
// crossing back into the Barrens, and the arrow's own walk to the chest stays up on the pinnacle.
#[test]
fn darkcloud_pinnacle_the_routes_to_the_document_chest_and_the_grimtotem_camps_keep_to_the_mesas_never_down_a_lift_2391_2292() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(30)
		w.faction = "Horde"
		local function plan(map, x, y, z, tx, ty, label)
			N.SetTarget(nil)
			w.moveTo(map, x, y)
			w.z = z
			for _ = 1, 10 do aim(); stub.advance(0.05) end
			for i = #finds, 1, -1 do finds[i] = nil end
			N.SetTarget(1441, tx, ty, label, "e")
			for _ = 1, 300 do aim(); stub.advance(0.05) end
			local out, L, ci = {}, N.GetRoute()
			for i = ci or 1, #(L or {}) do
				local l = L[i]
				out[#out + 1] = l.kind .. "|" .. tostring(l.label) .. (l.crossing and ("|" .. l.crossing) or "")
			end
			-- The lowest point of the arrow's own walks (searched from where the player stands).
			local low
			for _, rec in ipairs(finds) do
				for _, pt in ipairs(rec.points or {}) do
					if pt.z and (not low or pt.z < low) then low = pt.z end
				end
			end
			return { legs = out, low = low or false }
		end
		emit({
			chest = plan(1441, 38.11, 26.87, 83, 39.34, 41.53, "Document Chest"),
			camps = plan(1413, 44.77, 90.53, 90, 35.0, 31.5, "Grimtotem camps"),
			mesa = plan(1441, 38.11, 26.87, 83, 35.0, 31.5, "Grimtotem camps"),
		})"#,
		true,
	);
	for (k, label) in [("chest", "walk|Document Chest"), ("camps", "walk|Grimtotem camps"), ("mesa", "walk|Grimtotem camps")] {
		let l = strs(&out[k]["legs"]);
		assert!(l.last().is_some_and(|x| x == label), "{k}: the route ends with the walk there ({l:?})");
		assert!(!l.iter().any(|x| x.starts_with("lift|")), "{k}: never a lift ({l:?})");
		assert!(!l.iter().any(|x| x.starts_with("walk|Walk to The Barrens")), "{k}: never back into the Barrens ({l:?})");
	}
	// From the lift's top the crossing into Thousand Needles once; on the pinnacle, none.
	let crossing = |k: &str| strs(&out[k]["legs"]).iter().filter(|x| x.ends_with("|carbonite-the-barrens--thousand-needles")).count();
	assert!(crossing("camps") <= 1, "from the lift's top: across once");
	assert_eq!((crossing("chest"), crossing("mesa")), (0, 0), "on the pinnacle: no crossing");
	assert!(f(&out["chest"]["low"]) > 70.0, "the arrow's walk to the chest stays on the pinnacle (lowest {})", out["chest"]["low"]);
}

// #1543's near walk where the walking engine finds it long or none (the 0.3.7 border sweep's worst pairs): the route
// keeps the crossing's way, as before #1543. A Horde player at level 30 on Alterac's ridge, 395 yd above a goal in the
// Undercity (no walk joins them: the unchecked near walk flipped the arrow 127 times between itself and the crossing),
// on Searing Gorge's rim 350 yd above a Badlands goal (the walk 3.6k yd round: the player never got there), and in
// Tanaris 200 yd from a goal down in Un'Goro Crater (1.4k yd round the rim: never got there).
#[test]
fn a_near_target_over_a_closed_zone_border_with_a_long_walk_or_none_keeps_the_crossings_way_1543() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(30)
		w.faction = "Horde"
		-- Flight maps opened on both continents, none listing a flight path: these starts walk (no flight it may have, #1795).
		Polestar.CharState().flags.taxiSeen = { [0] = true, [1] = true }
		local function legs()
			local out = {}
			local L, ci = N.GetRoute()
			for i = ci or 1, #(L or {}) do
				local l = L[i]
				out[#out + 1] = l.kind .. "|" .. tostring(l.label) .. (l.crossing and ("|" .. l.crossing) or "")
			end
			return out
		end
		local function case(smap, swx, swy, sz, tmap, tx, ty, tz)
			N.ClearTarget()
			place(smap, swx, swy, sz)
			for _ = 1, 10 do aim(); stub.advance(0.05) end
			N.SetTarget(tmap, tx, ty, "Target", "e", nil, tz)
			for _ = 1, 200 do aim(); stub.advance(0.05) end
			local first = legs()
			for _ = 1, 200 do aim(); stub.advance(0.05) end
			return { first = first, later = legs() }
		end
		emit({
			alterac = case(1416, 1409.8, -244.6, 180, 1458, 75.34, 73.13, -62.3),
			gorge = case(1427, -6353.5, -2294.4, 390, 1418, 18.6, 42.9, nil),
			ungoro = case(1446, -7916.9, -2302.1, 10, 1449, 71.64, 75.96, -254.3),
		})"#,
		true,
	);
	for (k, crossing) in [("alterac", "alterac-mountains--silverpine-forest-lake"), ("gorge", "carbonite-searing-gorge--badlands"), ("ungoro", "carbonite-tanaris--un-goro-crater")] {
		let first = strs(&out[k]["first"]);
		assert!(first.iter().any(|x| x.ends_with(&format!("|{crossing}"))), "{k}: through the crossing ({first:?})");
		assert_eq!(strs(&out[k]["later"]), first, "{k}: the same way 10 s on");
	}
}

// The 0.3.8 border sweep's Ashenvale start 250 yd from a Darkshore goal (an Alliance player at UnitPosition (4085,
// 109.5), the goal at Darkshore 44.7,92): the walk there is short (260 yd), so the near walk over the closed border is
// planned (#1543), and its path, five points over open ground, is split at the Ashenvale pass, 40 yd along a piece of
// the path past its point before the pass. The first piece aimed no further than that point, so a player following
// the arrow stopped there, the arrow at their feet and the piece's end out of reach. It aims on to the pass's spot on
// the path: following the arrow (7 yd a second toward its aim, on the walking maps' ground, as the sweep walks), the
// player gets to the goal.
#[test]
fn following_the_arrow_from_ashenvale_to_a_darkshore_goal_250_yd_over_the_border_the_walk_split_at_the_pass_arrives() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Alliance"
		w.race, w.raceName = "Human", "Human"
		local G = stub.navNs.PathGrid
		-- The walking maps' surface at (x, y) nearest height h: its height, or nil off the maps.
		local function ground(c, x, y, h)
			local st = G.State(c)
			local k, lc
			if st then k, lc = G.locate(st, x, y) end
			if not k then return nil end
			local n = G.snap(st, k, lc, x, y, h)
			return n and G.zOf(G.grid(st, k), n) or nil
		end
		local c, x, y, z = 1, 4085, 109.5, 14
		local map = N.danger.ZoneAt(c, x, y) or 1440
		place(map, x, y, z)
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.advance(1)
		N.Sample()
		N.SetTarget(1439, 44.7, 92, "Goal", "e")
		local _, tx, ty = N.GetTargetWorld()
		for _ = 1, 100 do N.Sample(); stub.advance(0.05) end
		local pass, still, arrived, stalled = false, 0, false, false
		for t = 1, 90 do
			for _ = 1, 20 do N.Sample(); stub.advance(0.05) end
			local legs, ci = N.GetRoute()
			local leg = legs and legs[ci or 1]
			if leg and leg.choke and leg.choke.kind == "pass" then pass = true end
			if dist(x, y, tx, ty) <= 10 then arrived = t break end
			local _, _, _, dn, dw = N.Sample()
			if not dn then break end
			local da = sqrt(dn * dn + dw * dw)
			if da < 0.5 then still = still + 1 else still = 0 end
			if still >= 5 then stalled = t break end
			local step = math.min(7, da)
			x, y = x + dn / da * step, y + dw / da * step
			z = ground(c, x, y, z) or z
			local zm = N.danger.ZoneAt(c, x, y) or map
			place(zm, x, y, z)
			if zm ~= map then
				map = zm
				stub.fire("ZONE_CHANGED_NEW_AREA")
			end
		end
		emit({ pass = pass, arrived = arrived, stalled = stalled, left = floor(dist(x, y, tx, ty)) })"#,
		true,
	);
	assert_eq!(out["pass"], true, "the walk is split at the Ashenvale pass: {out}");
	assert_eq!(out["stalled"], false, "the arrow never stays on the player's feet: {out}");
	assert!(out["arrived"].as_f64().is_some(), "following the arrow gets the player to the goal: {out}");
}

// Following the arrow as the 0.4.0 border sweep does: 7 yd a second toward its aim, on the walking maps' ground nearest
// the last height, the client's zone under the player, for up to `secs` seconds. -> { arrived = seconds | false,
// stalled = second | false (5 s with the aim on the player's feet), left = yards, flips = the route's back-and-forths
// (its current leg A, then B, then A again within 30 s; a leg is its kind, crossing, end and the legs after it),
// keys = the first 12 changes ("second:key") }.
const FOLLOW_ARROW: &str = r#"
local G = stub.navNs.PathGrid
local function ground(c, x, y, h)
	local st = G.State(c)
	local k, lc
	if st then k, lc = G.locate(st, x, y) end
	if not k then return nil end
	local n = G.snap(st, k, lc, x, y, h)
	return n and G.zOf(G.grid(st, k), n) or nil
end
local function routeKey()
	local legs, ci = N.GetRoute()
	local l = legs and legs[ci or 1]
	if not l then return "-" end
	local to = l.to
	return string.format("%d:%s%s:%s", #legs - (ci or 1), l.kind, l.crossing and ("@" .. l.crossing) or "",
		to and to.wx and string.format("%d,%d", floor(to.wx / 15 + 0.5), floor(to.wy / 15 + 0.5)) or "?")
end
function follow(c, x, y, z, secs)
	local map = N.danger.ZoneAt(c, x, y)
	place(map, x, y, z)
	stub.fire("ZONE_CHANGED_NEW_AREA")
	local _, tx, ty = N.GetTargetWorld()
	for _ = 1, 100 do N.Sample(); stub.advance(0.05) end
	local still, flips, keys, hist, last = 0, 0, {}, {}, nil
	local function done(r)
		r.flips, r.keys = flips, keys
		return r
	end
	for t = 1, secs do
		for _ = 1, 20 do N.Sample(); stub.advance(0.05) end
		local k = routeKey()
		if last and k ~= last then
			for j = #hist, 1, -1 do
				local h = hist[j]
				if t - h[1] > 30 then break end
				if h[2] == k and h[3] == last then flips = flips + 1 break end
			end
			hist[#hist + 1] = { t, last, k }
			if #keys < 12 then keys[#keys + 1] = t .. ":" .. k end
		end
		last = k
		if dist(x, y, tx, ty) <= 10 then return done({ arrived = t, stalled = false, left = 0 }) end
		local _, _, _, dn, dw = N.Sample()
		if not dn then break end
		local da = sqrt(dn * dn + dw * dw)
		if da < 0.5 then still = still + 1 else still = 0 end
		if still >= 5 then return done({ arrived = false, stalled = t, left = floor(dist(x, y, tx, ty)) }) end
		local step = math.min(7, da)
		if da > 0 then x, y = x + dn / da * step, y + dw / da * step end
		z = ground(c, x, y, z) or z
		local zm = N.danger.ZoneAt(c, x, y) or map
		place(zm, x, y, z)
		if zm ~= map then
			map = zm
			stub.fire("ZONE_CHANGED_NEW_AREA")
		end
	end
	return done({ arrived = false, stalled = false, left = floor(dist(x, y, tx, ty)) })
end
"#;

// The border sweep's Badlands rim start 250 yd from a Burning Steppes goal (an Alliance player at UnitPosition
// (-7397.3, -3052), height 376; the goal at Burning Steppes 95.09,31.56): the walk down to it turns through a
// switchback of points 4 yd apart. The arrow aimed at a corner on the far side of it; the player walked to that spot,
// but their place on the path stayed on the segment before (a later one takes over only when 4 yd nearer, so the two
// sides of a hairpin don't swap), and the arrow kept aiming at the spot they stood on. Once the player reaches the
// arrow's aim, their place moves up to it: following the arrow, they get to the goal.
#[test]
fn following_the_arrow_down_a_switchback_from_the_badlands_rim_to_a_burning_steppes_goal_never_stops_at_its_own_aim() {
	skip_unless_ready!();
	let out = run(
		&[
			FOLLOW_ARROW,
			r#"
		w.faction = "Alliance"
		w.race, w.raceName = "Human", "Human"
		place(1418, -7397.3, -3052, 376)
		stub.advance(1)
		N.Sample()
		N.SetTarget(1428, 95.09, 31.56, "Goal", "e", nil, 131.3)
		emit(follow(0, -7397.3, -3052, 376, 240))"#,
		]
		.concat(),
		true,
	);
	assert_eq!(out["stalled"], false, "the arrow never stays on the player's feet: {out}");
	assert!(out["arrived"].as_f64().is_some(), "following the arrow gets the player to the goal: {out}");
}

// #2081: a level 39 Horde player on the Maker's Terrace (Badlands 48.82,8.33) guided to the Ancient Chest just inside
// Uldaman's cave mouth (Badlands 39.34,18.82, height 212.2): the arrow pointed toward Loch Modan, then Uldaman, and
// at Uldaman's entrance back toward Loch Modan. The walk itself is there (about 540 yd, never north into Loch Modan).
// Following the arrow, the route never goes back and forth, and the player gets to the chest.
#[test]
fn t_2081_following_the_arrow_from_the_maker_s_terrace_to_uldaman_s_ancient_chest_never_flips_and_arrives() {
	skip_unless_ready!();
	let out = run(
		&[
			FOLLOW_ARROW,
			r#"
		w.faction = "Horde"
		w.race, w.raceName = "Scourge", "Undead"
		w.level = 39
		local _, v = C_Map.GetWorldPosFromMapPos(1418, CreateVector2D(0.4882, 0.0833))
		local x, y = v.x, v.y
		local z = ground(0, x, y, nil) or 0
		place(1418, x, y, z)
		stub.advance(1)
		N.Sample()
		N.SetTarget(1418, 39.34, 18.82, "Ancient Chest", "e", nil, 212.2)
		emit(follow(0, x, y, z, 240))"#,
		]
		.concat(),
		true,
	);
	assert_eq!(out["flips"], 0, "the route never goes back and forth: {out}");
	assert_eq!(out["stalled"], false, "the arrow never stays on the player's feet: {out}");
	assert!(out["arrived"].as_f64().is_some(), "following the arrow gets the player to the chest: {out}");
}

/// #1919 (Jaesais, Skyborne Druid 20, 0.3.7, Cat Form, "The relics of the Barrow Dens"): leaving the Stormrage Barrow
/// Dens (Moonglade), the arrow pointed through the den's wall at the next goal outside until he was out. The walking
/// maps join the den to the world nowhere. An approach chain (crossings.json `stormrage-barrow-dens`: Polestar's walking
/// grid's way from the mouth down the ramp and the tunnel, which players' recorded walks take) leads out: from the
/// Relic of the Claw, on the den's floor, the route's legs follow the chain back to the mouth before the walk on.
#[test]
fn t_1919_from_the_relic_of_the_claw_the_route_leaves_the_stormrage_barrow_dens_by_its_mouth() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Alliance"
		w.race, w.raceName = "NightElf", "Night Elf"
		w.setLevel(20)
		local MOUTH = { 7540.7, -3024.1 } -- Moonglade 71.17,61.77
		place(1450, 7459.4, -3117.8, 439) -- the Relic of the Claw's alcove, on the den's floor
		N.SetTarget(1450, 54.5, 75.0, "The Great Cat Spirit")
		for _ = 1, 400 do stub.advance(0.05); aim() end
		local legs, ci = N.GetRoute()
		local r = { legs = {}, viaMouth = false }
		for i = ci or 1, #(legs or {}) do
			local l = legs[i]
			r.legs[#r.legs + 1] = l.kind .. "|" .. (l.step or "") .. (l.handmade and "|hand" or "")
			if l.to and dist(l.to.wx, l.to.wy, MOUTH[1], MOUTH[2]) < 13 then r.viaMouth = true end
		end
		local l1 = legs and legs[ci or 1]
		r.firstChain = l1 and l1.step == "chain" or false
		r.firstTo = l1 and l1.to and dist(l1.to.wx, l1.to.wy, 7459.4, -3117.8) or false
		emit(r)"#,
		true,
	);
	assert_eq!(out["viaMouth"], true, "a leg ends at the den's mouth: {out}");
	assert_eq!(out["firstChain"], true, "the first leg is the chain's, inside the den: {out}");
	assert!(f(&out["firstTo"]) < 60.0, "the first leg goes to a node near the relic, not across the rock to the target: {out}");
}

/// #1341 (Ban'ethil Barrow Den, Teldrassil): inside the den the arrow pointed through the rock at the next goal, and
/// from outside it sent players round the hills; no walk of the walking maps (nor of Polestar's walking grid) joins the
/// den to the hollow. An approach chain (crossings.json `banethil-barrow-den`: players' recorded way in at the mouth,
/// then the grid's way through the den) leads out: from Oben Rageclaw the route's legs follow the chain back to the
/// mouth before the walk to Dolanaar.
#[test]
fn t_1341_from_oben_rageclaw_the_route_leaves_the_banethil_barrow_den_by_its_mouth() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Alliance"
		w.race, w.raceName = "NightElf", "Night Elf"
		w.setLevel(10)
		local MOUTH = { 9876.1, 1550.8 } -- Teldrassil 44.46,57.61
		place(1438, 9741.0, 1526.4, 1280.4) -- Oben Rageclaw, in the den's depths
		N.SetTarget(1438, 56.0, 59.0, "Dolanaar")
		for _ = 1, 400 do stub.advance(0.05); aim() end
		local legs, ci = N.GetRoute()
		local r = { legs = {}, viaMouth = false }
		for i = ci or 1, #(legs or {}) do
			local l = legs[i]
			r.legs[#r.legs + 1] = l.kind .. "|" .. (l.step or "") .. (l.handmade and "|hand" or "")
			if l.to and dist(l.to.wx, l.to.wy, MOUTH[1], MOUTH[2]) < 9 then r.viaMouth = true end
		end
		local l1 = legs and legs[ci or 1]
		r.firstChain = l1 and l1.step == "chain" or false
		emit(r)"#,
		true,
	);
	assert_eq!(out["viaMouth"], true, "a leg ends at the den's mouth: {out}");
	assert_eq!(out["firstChain"], true, "the first leg is the chain's, inside the den: {out}");
}

/// #2005 (ddos, Tauren Druid 21, 0.3.7.2, Cat Form): bound for the relics in the Stormrage Barrow Dens, the arrow led
/// out of the valley and round over the mountains to the hilltop above them. The den's approach chain
/// (`stormrage-barrow-dens`) takes the walk to the den's mouth first: from the lake shore west of the den the route's
/// legs reach the mouth, then follow the chain in to the Relic of the Claw.
#[test]
fn t_2005_from_the_lake_shore_the_route_to_the_relic_of_the_claw_goes_in_by_the_stormrage_barrow_dens_mouth() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		w.race, w.raceName = "Tauren", "Tauren"
		w.setLevel(21)
		local MOUTH = { 7540.7, -3024.1 } -- Moonglade 71.17,61.77
		place(1450, 7537.1, -2904.7, 462) -- the lake shore west of the den, Moonglade 66.0,62.0
		N.SetTarget(1450, 75.2, 67.2, "Relic of the Claw")
		for _ = 1, 400 do stub.advance(0.05); aim() end
		local legs, ci = N.GetRoute()
		local r = { legs = {}, viaMouth = false, chainLegs = 0 }
		for i = ci or 1, #(legs or {}) do
			local l = legs[i]
			r.legs[#r.legs + 1] = l.kind .. "|" .. (l.step or "") .. (l.handmade and "|hand" or "")
			if l.to and dist(l.to.wx, l.to.wy, MOUTH[1], MOUTH[2]) < 13 then r.viaMouth = true end
			if l.step == "chain" then r.chainLegs = r.chainLegs + 1 end
		end
		emit(r)"#,
		true,
	);
	assert_eq!(out["viaMouth"], true, "a leg ends at the den's mouth: {out}");
	assert!(f(&out["chainLegs"]) >= 2.0, "the walk in follows the chain's nodes: {out}");
}

// Following the arrow with no height from the client, as on Forever (UnitPosition's 0, read as none): 7 yd a second
// toward its aim, the height left at 0, for up to `secs` seconds. -> { arrived = seconds | false, left = yards to the
// target, outs = seconds the label said "Follow the path out", near = seconds within `r` yd of (ax, ay), far = seconds
// over `R` yd from it after the first near one }.
const FLAT_FOLLOW: &str = r#"
function flatFollow(c, x, y, secs, reach, ax, ay, r, R)
	local map = N.danger.ZoneAt(c, x, y)
	place(map, x, y, 0)
	local _, tx, ty = N.GetTargetWorld()
	local outs, near, far = 0, 0, 0
	for t = 1, secs do
		for _ = 1, 20 do N.Sample(); stub.advance(0.05) end
		if dist(x, y, tx, ty) <= reach then return { arrived = t, left = 0, outs = outs, near = near, far = far } end
		local _, _, _, dn, dw = N.Sample()
		if (N.travel.CurrentLabel() or ""):match("^[^\n]*") == "Follow the path out" then outs = outs + 1 end
		if not dn then break end
		local da = sqrt(dn * dn + dw * dw)
		if da > 0 then
			local step = math.min(7, da)
			x, y = x + dn / da * step, y + dw / da * step
		end
		if ax then
			local d = dist(x, y, ax, ay)
			if d <= r then near = near + 1 elseif near > 0 and d > R then far = far + 1 end
		end
		local zm = N.danger.ZoneAt(c, x, y) or map
		place(zm, x, y, 0)
		if zm ~= map then
			map = zm
			stub.fire("ZONE_CHANGED_NEW_AREA")
		end
	end
	return { arrived = false, left = floor(dist(x, y, tx, ty)), outs = outs, near = near, far = far }
end
"#;

/// #3449 (0.4.2, every Night Elf): at Ban'ethil Barrow Den's mouth, the step to the Chest of the Raven Claw (in the
/// den's lower east room, 64 yd off and 50 yd down) showed "Follow the path out" and a bearing that swung back and
/// forth; the chest was never reached. With no height from the client, the walk into the den (the walking maps join
/// it now) took the player down the entrance ramp, where the followed floor put them inside the den's approach chain;
/// the chest lies off every chain, so the plan sent them out by the chain and back in by the walk, and at the mouth
/// the followed floor, fallen to the hall under it, never let the chain's last node count. A start inside a chain now
/// keeps the arrow's live walk to the target (or the engine's measured one), and with no client height a chain node is
/// reached on the map: following the arrow, the player walks the den to the chest, never told to go out.
#[test]
fn t_3449_with_no_client_height_from_the_banethil_barrow_den_s_mouth_the_arrow_walks_the_den_to_the_raven_claw_chest() {
	skip_unless_ready!();
	let out = run(
		&[
			FLAT_FOLLOW,
			r#"
		w.faction = "Alliance"
		w.race, w.raceName = "NightElf", "Night Elf"
		w.setLevel(5)
		place(1438, 9873.2, 1555.3, 0) -- at the den's mouth, where the step before ends
		stub.advance(1)
		N.Sample()
		N.SetTarget(1438, 45.61, 57.35, "Chest of the Raven Claw", "e", nil, 1278.8)
		local r = flatFollow(1, 9873.2, 1555.3, 240, 5)
		r.height = C.PlayerHeight()
		emit(r)"#,
		]
		.concat(),
		true,
	);
	assert_eq!(out["height"], "zero", "the stub gives Forever's height of 0: {out}");
	assert!(out["arrived"].as_f64().is_some(), "following the arrow gets the player to the chest: {out}");
	assert_eq!(out["outs"], 0, "never \"Follow the path out\" on the way: {out}");
}

/// #3449: leaving Ban'ethil Barrow Den with no height from the client. From Oben Rageclaw the route follows the den's
/// chain out to its mouth (#1341); the followed floor fell 26 yd to the hall under the mouth on the last stretch of the
/// ramp, so the mouth's node (height 1329) never counted as reached and the arrow circled it ("Follow the path out").
/// With no client height a chain node is reached on the map: the player passes the mouth and walks on out.
#[test]
fn t_3449_with_no_client_height_from_oben_rageclaw_the_arrow_leads_out_past_the_banethil_barrow_den_s_mouth() {
	skip_unless_ready!();
	let out = run(
		&[
			FLAT_FOLLOW,
			r#"
		w.faction = "Alliance"
		w.race, w.raceName = "NightElf", "Night Elf"
		w.setLevel(10)
		local MOUTH = { 9876.1, 1550.8 } -- Teldrassil 44.46,57.61
		place(1438, 9741.0, 1526.4, 0) -- Oben Rageclaw, in the den's depths
		stub.advance(1)
		N.Sample()
		N.SetTarget(1438, 56.0, 59.0, "Dolanaar")
		emit(flatFollow(1, 9741.0, 1526.4, 240, 10, MOUTH[1], MOUTH[2], 10, 60))"#,
		]
		.concat(),
		true,
	);
	assert!(f(&out["near"]) >= 1.0, "the way out passes the den's mouth: {out}");
	assert!(f(&out["far"]) >= 1.0, "past the mouth the player walks on out, never circling it: {out}");
}

/// #3448 (0.4.2, Northshire, no height from the client): after Llane Beshere's training the first walk to the kobold
/// camp was refused (the router's departure rule: a start with no height on the Abbey's indoor ground) and the player
/// standing there got a straight line for 10 to 30 s. The followed floor had been dropped: the player walked a yard
/// past the last floor read before the arrow said Arrived, and the stop outlasted FRESH (2 s). Walking in to Llane by
/// the arrow at run speed (7 yd a second in frames of 0.05 s), standing 3 s at him, then the next goal: its first walk
/// starts on the followed floor and is found.
#[test]
fn t_3448_with_no_client_height_after_llane_beshere_the_first_walk_to_the_kobold_camp_is_found_at_once() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Alliance"
		w.race, w.raceName = "Human", "Human"
		w.setLevel(4)
		local x, y = -8871.5, -151.1 -- by the wolves north of the Abbey
		place(1429, x, y, 0)
		stub.advance(1)
		N.Sample()
		local mx, my = C.WorldToMap(0, -8916.3, -203.8, 1429)
		N.SetTarget(1429, mx, my, "Llane Beshere", nil, "npc", 82.3)
		local arrived = false
		for i = 1, 1200 do
			local state, _, _, dn, dw = N.Sample()
			if state == "arrived" then arrived = i * 0.05 break end
			if dn then
				local da = sqrt(dn * dn + dw * dw)
				if da > 0 then
					local step = math.min(0.35, da)
					x, y = x + dn / da * step, y + dw / da * step
					place(1429, x, y, 0)
				end
			end
			stub.advance(0.05)
		end
		-- A step on into his range, then the training: 3 s at the trainer with the arrow at Arrived (no floor check).
		local tx, ty = -8916.3, -203.8
		local d = dist(x, y, tx, ty)
		x, y = x + (tx - x) / d * 1.5, y + (ty - y) / d * 1.5
		place(1429, x, y, 0)
		for _ = 1, 60 do N.Sample(); stub.advance(0.05) end
		local before = #finds
		local kx, ky = C.WorldToMap(0, -8780.5, -160.4, 1429)
		N.SetTarget(1429, kx, ky, "Kobold Vermin", nil, nil, 82)
		local first, t = nil, 0
		while t < 100 do
			N.Sample(); stub.advance(0.05); t = t + 1
			for i = before + 1, #finds do
				if finds[i].done and dist(finds[i].to[1], finds[i].to[2], -8780.5, -160.4) < 3 then first = first or finds[i] end
			end
			if first then break end
		end
		emit({ arrived = arrived, at = { r1(x), r1(y) }, height = C.PlayerHeight(), answered = first ~= nil,
			fromZ = first and first.from[3] or false, points = first and first.points and #first.points or 0,
			blocked = tostring(N.walk.blockedReason) })"#,
		true,
	);
	assert_eq!(out["height"], "zero", "the stub gives Forever's height of 0: {out}");
	assert!(out["arrived"].as_f64().is_some(), "the arrow leads to Llane: {out}");
	assert!(out["fromZ"].as_f64().is_some(), "the first walk starts on the followed floor: {out}");
	assert!(f(&out["points"]) >= 2.0, "and is found, never refused: {out}");
}

// The walk from the player's spot (map coordinates in `frame`: "e" era, nil live) to a goal point with its compiled
// height (the goal's `z`, docs/GUIDE_FORMAT.md "Heights"): where it ends (yards from the goal in the plane, its
// height), its length and its cost ("unreachable" when the walking maps have no way there).
const HEIGHT_WALK: &str = r#"
local function heightWalk(frame, map, x, y, tmap, tx, ty, z, label)
	N.ClearTarget()
	for _ = 1, 5 do stub.advance(0.05) end
	local _, px, py = C.MapToWorld(map, x, y, frame)
	local _, wx, wy = C.MapToWorld(tmap, tx, ty, frame)
	place(map, px, py, 0)
	local f = walkFor(tmap, wx, wy, label, z)
	local q = f or finds[#finds]
	local pts = q and q.points or {}
	local last = pts[#pts]
	local r = { cost = q and q.cost or false, found = last ~= nil }
	if last then r.d, r.z, r.yards = floor(dist(last.x, last.y, wx, wy)), r1(last.z), floor(length(pts)) end
	return r
end
"#;

/// #2454 (Onrevax, Human Paladin 36, 0.3.7.2, Cloak of the Divine Storm, "Summoner's Salt"): in the Redridge
/// Canyons (28.44,23.44 live), 200 yd below the north-west Blackrock camp, the line led where he could not pass.
/// In 0.3.7.2 the collect (23.5,12.0 live) had no height. 0.4.0 compiles it with the camp's floor (z 163.9, the
/// nearest Summoner's spawn): the walk from his spot climbs round to the camp (about 1,070 yd) and ends on its floor,
/// as it does from Lakeshire. `flat`: the same walk without the height, printed beside it.
#[test]
fn t_2454_from_the_redridge_canyons_the_walk_to_the_summoners_camp_ends_on_the_camps_floor() {
	skip_unless_ready!();
	let out = run(
		&format!(
			"{FLOOR_WALK}{HEIGHT_WALK}{}",
			r#"
		Polestar.Set("nav.travel", false)
		w.faction = "Alliance"
		w.race, w.raceName = "Human", "Human"
		w.setLevel(36)
		-- The compiled collect (addon/Polestar_Guides_Alliance, cloak-of-the-divine-storm): 1433 23.5,12 live, z 163.9.
		local GOAL = { 1433, 23.5, 12.0, 163.9 }
		emit({
			fromSpot = heightWalk(nil, 1433, 28.44, 23.44, GOAL[1], GOAL[2], GOAL[3], GOAL[4], "Summoner's Salt"),
			fromLakeshire = heightWalk(nil, 1433, 26.5, 44.5, GOAL[1], GOAL[2], GOAL[3], GOAL[4], "Summoner's Salt "),
			flat = heightWalk(nil, 1433, 28.44, 23.44, GOAL[1], GOAL[2], GOAL[3], nil, "Summoner's Salt  "),
		})"#
		),
		true,
	);
	eprintln!("2454: {out}");
	assert_eq!(out["fromSpot"]["found"], true, "a walk from his spot is found: {out}");
	assert!(f(&out["fromSpot"]["d"]) < 15.0, "it ends at the camp: {out}");
	assert!((f(&out["fromSpot"]["z"]) - 163.9).abs() < 8.0, "on the camp's floor: {out}");
	assert_eq!(out["fromLakeshire"]["found"], true, "so does the walk from Lakeshire: {out}");
	assert!(f(&out["fromLakeshire"]["d"]) < 15.0, "ending at the camp: {out}");
}

/// #2451 (Conflict, Scourge Rogue 28, 0.3.7.2, Ashenvale & Thousand Needles, "Splithoof Hold"): from the southern
/// Barrens (43.75,60.89), bound for the Ancient Brazier deep in Splithoof Hold's cave (Thousand Needles 42.0,31.5),
/// the line kept leading towards Razorfen Downs. In 0.3.7.2 the use and collect had no height, so the walk ended on
/// whichever surface over the point was cheapest (a shorter walk, not into the cave); 0.4.0 compiles them with the
/// brazier's floor (z -70.5, the object's spawn): the walk ends at the brazier, in the cave.
#[test]
fn t_2451_from_the_southern_barrens_the_walk_to_the_ancient_brazier_ends_in_splithoof_holds_cave() {
	skip_unless_ready!();
	let out = run(
		&format!(
			"{FLOOR_WALK}{HEIGHT_WALK}{}",
			r#"
		Polestar.Set("nav.travel", false)
		w.faction = "Horde"
		w.race, w.raceName = "Scourge", "Undead"
		w.setLevel(28)
		emit({
			withZ = heightWalk("e", 1413, 43.75, 60.89, 1441, 42.0, 31.5, -70.5, "Ancient Brazier"),
			flat = heightWalk("e", 1413, 43.75, 60.89, 1441, 42.0, 31.5, nil, "Ancient Brazier "),
		})"#
		),
		true,
	);
	eprintln!("2451: {out}");
	assert_eq!(out["withZ"]["found"], true, "a walk is found: {out}");
	assert!(f(&out["withZ"]["d"]) < 15.0, "it ends at the brazier: {out}");
	assert!((f(&out["withZ"]["z"]) + 70.5).abs() < 8.0, "on the cave's floor: {out}");
}

/// #2470 (Syllirra, Orc Warlock 29, 0.3.7.2, Ashenvale & Thousand Needles, "The Screeching Canyon"): dead in the
/// Screeching Canyon (Thousand Needles 26.63,53.55 live), the ghost at the Windbreak Canyon graveyard (56.18,50.15
/// live, 1,304 yd away) was led round through Tanaris, "26:59 total time". The walk on 0.4.0's maps, printed.
#[test]
fn t_2470_from_the_windbreak_graveyard_the_walk_to_a_corpse_in_the_screeching_canyon_stays_in_thousand_needles() {
	skip_unless_ready!();
	let out = run(
		&format!(
			"{FLOOR_WALK}{HEIGHT_WALK}{}",
			r#"
		Polestar.Set("nav.travel", false)
		w.faction = "Horde"
		w.race, w.raceName = "Orc", "Orc"
		w.setLevel(29)
		emit({ corpse = heightWalk(nil, 1441, 56.18, 50.15, 1441, 26.63, 53.55, nil, "Your corpse") })"#
		),
		true,
	);
	eprintln!("2470: {out}");
	assert_eq!(out["corpse"]["found"], true, "a walk is found: {out}");
	assert!(f(&out["corpse"]["d"]) < 15.0, "it ends at the corpse: {out}");
	// 0.4.0's maps: about 1,720 yd across the canyons; a walk round through Tanaris is several times that.
	assert!(f(&out["corpse"]["yards"]) < 2200.0, "it stays in Thousand Needles: {out}");
}

// 0.4.1's border sweep (#2048): an Alliance player at level 24 in the Riverglades, 250 yd north of a Redridge goal
// (Redridge 46.1,37.3, the Alliance Redridge guide's goal 292), follows the arrow along the zone line. Each zone change
// planned again before the walking engine had searched the last plan's walk, and an unsearched live walk was never
// kept, so the route went from the crossing's way (86 s) to the walk straight there (63 s) and back every second, 224
// times in 4 minutes, and the player never got there. The live walk is priced by its estimate until its path is in:
// the walk straight there stays, and the player arrives. The sweep's own start (-8865.1, -2682) is off the walking
// maps (the surface at 230 there is a pocket no walk leaves; from the ground at 201 the nearest node is 18 yd away and
// 11 yd down), and a start the maps cannot prove gives no bearing, so the player starts on that nearest node.
#[test]
fn following_the_arrow_from_the_riverglades_along_the_zone_line_to_a_redridge_goal_never_flips_and_arrives_2048() {
	skip_unless_ready!();
	let out = run(
		&[
			FOLLOW_ARROW,
			r#"
		w.faction = "Alliance"
		w.race, w.raceName = "Human", "Human"
		w.setLevel(24)
		Polestar.CharState().flags.taxiSeen = { [0] = true, [1] = true }
		local x, y = -8877.1, -2668.8
		local z = ground(0, x, y, 190) or 0
		place(N.danger.ZoneAt(0, x, y), x, y, z)
		stub.advance(1)
		N.Sample()
		N.SetTarget(1433, 46.1, 37.3, "Goal", "l")
		emit(follow(0, x, y, z, 240))"#,
		]
		.concat(),
		true,
	);
	assert!(f(&out["flips"]) <= 1.0, "the route goes back and forth {} times: {out}", out["flips"]);
	assert!(out["arrived"].as_f64().is_some(), "following the arrow gets the player to the goal: {out}");
}

// The border sweep (#1543, #2048; a measuring tool, not a check: `--ignored`). NAV_SWEEP_GOALS names a JSON file of
// guide goals, each { id, faction, level, c, gx, gy, tmap, tx, ty, tf, tz, cand = [[x, y] x 8] } (the 8 points 250 yd
// round the goal); NAV_SWEEP_OUT where the results go (JSON); NAV_SWEEP_THREADS how many runs at once (default 4),
// NAV_SWEEP_LIMIT the most starts (default all). A goal's start is its first candidate in another zone than the goal
// (Nav.danger.ZoneAt, the walking maps' zone field) standing on the walking maps' ground; from there the player
// follows the arrow as FOLLOW_ARROW does, walking only (flight maps seen on both continents, none listing a flight
// path), for up to 240 s. Each result: { id, arrived, stalled, left, flips, keys }.
#[test]
#[ignore]
fn border_sweep() {
	skip_unless_ready!();
	let (Ok(goals), Ok(out_file)) = (std::env::var("NAV_SWEEP_GOALS"), std::env::var("NAV_SWEEP_OUT")) else {
		eprintln!("skipped: NAV_SWEEP_GOALS and NAV_SWEEP_OUT name the goals and the results");
		return;
	};
	let threads: usize = std::env::var("NAV_SWEEP_THREADS").ok().and_then(|v| v.parse().ok()).unwrap_or(4);
	let limit: usize = std::env::var("NAV_SWEEP_LIMIT").ok().and_then(|v| v.parse().ok()).unwrap_or(usize::MAX);
	let goals: Value = serde_json::from_str(&std::fs::read_to_string(&goals).unwrap()).unwrap();
	let tmp = TempDir::new("polestar-border-sweep-");
	let lua_file = |name: &str, v: &Value| {
		let p = tmp.path().join(name);
		std::fs::write(&p, format!("return {}", forge_addontest::run::lua_value(v))).unwrap();
		p.to_string_lossy().to_string()
	};
	// The starts, in one run.
	let gfile = lua_file("goals.lua", &goals);
	let picked = run(
		&format!(
			r#"
		local G = stub.navNs.PathGrid
		local function ground(c, x, y, h)
			local st = G.State(c)
			local k, lc
			if st then k, lc = G.locate(st, x, y) end
			if not k then return nil end
			local n = G.snap(st, k, lc, x, y, h)
			return n and G.zOf(G.grid(st, k), n) or nil
		end
		-- Both continents' parts loaded (the client loads a part where the player stands).
		C_AddOns.LoadAddOn("Polestar_Nav_EK")
		C_AddOns.LoadAddOn("Polestar_Nav_Kalimdor")
		stub.advance(1)
		local out, seen = {{}}, {{ goals = 0, zoned = 0 }}
		for _, g in ipairs(dofile({gfile})) do
			local gz = N.danger.ZoneAt(g.c, g.gx, g.gy)
			seen.goals = seen.goals + 1
			if gz then seen.zoned = seen.zoned + 1 end
			for k, p in ipairs(gz and g.cand or {{}}) do
				local z = N.danger.ZoneAt(g.c, p[1], p[2])
				local h = z and z ~= gz and ground(g.c, p[1], p[2], nil)
				if h then
					out[#out + 1] = {{ id = (g.id .. " /" .. k), faction = g.faction, level = g.level, c = g.c, x = p[1], y = p[2], z = h,
						zone = z, goalZone = gz, tmap = g.tmap, tx = g.tx, ty = g.ty, tf = g.tf, tz = g.tz }}
					break
				end
			end
		end
		emit({{ starts = out, seen = seen }})"#,
			gfile = lua_string(&gfile)
		),
		true,
	);
	eprintln!("border sweep: goals {}", picked["seen"]);
	let mut starts: Vec<Value> = picked["starts"].as_array().cloned().unwrap_or_default();
	starts.truncate(limit);
	eprintln!("border sweep: {} starts", starts.len());
	let chunks: Vec<Vec<Value>> = starts.chunks(20).map(|c| c.to_vec()).collect();
	let next = std::sync::atomic::AtomicUsize::new(0);
	let results = std::sync::Mutex::new(Vec::<Value>::new());
	std::thread::scope(|s| {
		for _ in 0..threads {
			s.spawn(|| loop {
				let i = next.fetch_add(1, std::sync::atomic::Ordering::SeqCst);
				let Some(chunk) = chunks.get(i) else { break };
				let sfile = lua_file(&format!("chunk{i}.lua"), &Value::Array(chunk.clone()));
				let out = run(
					&[
						FOLLOW_ARROW,
						&format!(
							r#"
		local out = {{}}
		for _, s in ipairs(dofile({sfile})) do
			N.ClearTarget()
			w.faction = s.faction
			if s.faction == "Horde" then w.race, w.raceName = "Orc", "Orc" else w.race, w.raceName = "Human", "Human" end
			w.setLevel(s.level)
			Polestar.CharState().flags.taxiSeen = {{ [0] = true, [1] = true }}
			place(s.zone, s.x, s.y, s.z)
			stub.advance(1)
			N.Sample()
			N.SetTarget(s.tmap, s.tx, s.ty, "Goal", s.tf, nil, s.tz)
			local r = follow(s.c, s.x, s.y, s.z, 240)
			r.id = s.id
			out[#out + 1] = r
		end
		emit(out)"#,
							sfile = lua_string(&sfile)
						),
					]
					.concat(),
					true,
				);
				results.lock().unwrap().extend(out.as_array().cloned().unwrap_or_default());
			});
		}
	});
	let results = results.into_inner().unwrap();
	std::fs::write(&out_file, serde_json::to_string(&results).unwrap()).unwrap();
	let arrived = results.iter().filter(|r| r["arrived"].as_f64().is_some()).count();
	let stalled = results.iter().filter(|r| r["stalled"].as_f64().is_some()).count();
	let flips: f64 = results.iter().map(|r| r["flips"].as_f64().unwrap_or(0.0)).sum();
	eprintln!("border sweep: {} starts, {arrived} arrived, {stalled} stalled, {flips} flips -> {out_file}", results.len());
}
