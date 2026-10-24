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
use forge_addontest::{emitted, lua_string, Addon, RunAddon};
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
			return { d = dist(cx, cy, x, y), z = st.z[k][n + 1] }
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
// mine's lower door, on the ground outside, short of any mouth.
const MINE_MOUTH: [f64; 3] = [-9178.9, -599.5, 13.0];
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
		-- e: the route lines' walk legs are the engine's path, the player first:
		-- every path point, in order, along the pieces' points (the mouth between them).
		local g = N.GetRouteGeometry()
		local along, walks, current = {}, 0, nil
		for _, leg in ipairs(g.legs) do
			if leg.kind == "walk" then
				walks = walks + 1
				if leg.current then current = leg end
				for _, p in ipairs(leg.pts) do along[#along + 1] = p end
			end
		end
		local k, inOrder = 1, true
		for _, p in ipairs(pts) do
			while along[k] and not (along[k][1] == 0 and along[k][2] == p.x and along[k][3] == p.y) do k = k + 1 end
			if not along[k] then inOrder = false break end
		end
		r.geometry = { legs = #g.legs, walks = walks, inOrder = inOrder, first = dist(current.pts[1][2], current.pts[1][3], GOLDSHIRE[1], GOLDSHIRE[2]) }
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
	let (len, tail, d) = (f(&path["length"]), f(&first["tail"]), f(&aim["dist"]));
	assert!((d - (len - tail)).abs() < 0.5, "the arrow shows the path's length to the mouth ({d:.1} vs {len:.1} less {tail:.1} after it)");
	assert!(len >= f(&path["straight"]), "path {len:.0} yd, straight {:.0} yd", f(&path["straight"]));
	assert!((f(&out["left"]["walk"]) - len).abs() < 0.5, "Walk.Left is the whole path left");
	assert_eq!(out["shown"]["text"], out["shown"]["want"], "the arrow's distance text is that length");
	// e
	assert_eq!(out["geometry"]["walks"], 2, "two walk pieces on the route lines");
	assert_eq!(out["geometry"]["inOrder"], true, "their points carry the engine's path, point for point, in order");
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
	assert!((f(&journey["progress"][1]) - (len - tail)).abs() < 0.5, "and measured along the engine's path to the mouth");
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

#[test]
fn d_30_yards_off_the_path_asks_once_after_the_2_s_throttle_keeping_the_old_path_meanwhile_the_arrow_follows_the_new_path() {
	skip_unless_ready!();
	let out = run(
		r#"
		local r = {}
		place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
		local f = guide()
		local a, b = f.points[1], f.points[2]
		-- 40 yd along the first segment, then 35 yd off it, square to it.
		local L = dist(a.x, a.y, b.x, b.y)
		local ux, uy = (b.x - a.x) / L, (b.y - a.y) / L
		local ox, oy = a.x + ux * 40 - uy * 35, a.y + uy * 40 + ux * 35
		place(1429, ox, oy)
		r.off = offPath(f.points, ox, oy)
		local s = aim()
		r.soon = { finds = #finds, index = indexOf(f, s.x, s.y), since = GetTime() - f.at }
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
		r.new = { from = dist(g.from[1], g.from[2], ox, oy), index = indexOf(g, s.x, s.y), oldIndex = indexOf(f, s.x, s.y), n = #g.points, gap = GetTime() - f.at }
		stub.advance(5)
		aim()
		r.settled = #finds
		emit(r)"#,
		false,
	);
	assert!(f(&out["off"]) > 30.0, "{:.1} yd off the path", f(&out["off"]));
	assert_eq!(out["soon"]["finds"], 1, "not within 2 s of the last search ({:.2} s)", f(&out["soon"]["since"]));
	assert!(f(&out["soon"]["index"]) >= 2.0, "the old path is kept meanwhile");
	assert_eq!(out["stillSoon"], 1);
	assert_eq!(out["after"], 2, "one new search once 2 s have passed");
	assert!(f(&out["new"]["from"]) < 0.01, "from where the player stands");
	assert_eq!(out["new"]["index"], 2, "the arrow aims at the new path's next point");
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
		-- A new target in combat: the straight arrow, no search either.
		N.SetTarget(1429, 39.5, 80.0, "Lower mouth", "e")
		stub.advance(2)
		s = aim()
		local _, tx, ty = N.GetTargetWorld()
		r.newTarget = { finds = #finds, straight = dist(s.x, s.y, tx, ty) < 0.01 }
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
	assert_eq!(out["newTarget"], serde_json::json!({ "finds": 1, "straight": true }));
	assert_eq!(out["after"], 2, "one search once combat ends");
	assert_eq!(out["follow"]["combat"], false);
	assert!(f(&out["follow"]["from"]) < 0.01);
	assert!(f(&out["follow"]["along"]) > 1.0 && f(&out["follow"]["off"]) < 2.0, "the arrow follows it");
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
	assert!(out["withoutZ"]["z"].is_null(), "the same point set by hand has no height");
	assert_eq!(out["withoutZ"]["asked"], 2);
	assert!((f(&out["withoutZ"]["endZ"]) - end_z).abs() <= 4.0, "and ends on his floor as well, by the lift ({})", out["withoutZ"]["endZ"]);
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

// Review conditions for shipping Polestar's maps (nav-maps): the maps load only with routing on; all of a map's files
// missing from Nav.xml, or a corrupted grid block, leave the straight arrow, never a Lua error (one missing part file:
// nav-load.rs); every zone the guides walk in routes.
fn nav_dir() -> PathBuf {
	addons_dir().join("Polestar_Nav/Nav")
}

#[test]
fn the_walking_maps_load_on_demand_only_with_walk_real_paths_on_nav_navrouting_off_polestar_nav_is_never_loaded() {
	skip_unless_ready!();
	let (_tmp, ns) = ns_file();
	let files = nav_files(&ns);
	let run1 = |routing: bool| {
		let addons = polestar_addons();
		emitted(&RunAddon {
			stubs: vec!["stub_world.lua", "stub_encoding.lua", "stub_packs.lua"],
			before: before(&files),
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
	let off = run1(false);
	assert_eq!(serde_json::json!([off["loads"], off["data"], off["chokepoints"], off["finds"]]), serde_json::json!([0, false, false, 0]), "routing off: no maps in memory, no search");
	assert_eq!(off["state"], "travel", "the arrow still points (straight)");
	let on = run1(true);
	assert_eq!(serde_json::json!([on["loads"], on["data"], on["chokepoints"]]), serde_json::json!([1, true, true]), "routing on: loaded once at login");
	assert!(f(&on["finds"]) >= 1.0);
}

// The part file holding the cluster (ADT tile) of a world point on map 0, and that cluster's index.
fn cluster_file(wx: f64, wy: f64) -> (i64, Option<String>) {
	let meta = std::fs::read_to_string(nav_dir().join("Nav0.lua")).unwrap();
	let num = |k: &str| -> i64 { Regex::new(&format!(r"\t{k} = (-?\d+),")).unwrap().captures(&meta).unwrap()[1].parse().unwrap() };
	let t = 1600.0 / 3.0;
	let k = ((wx / t).floor() as i64 - num("cx0")) * num("ny") + ((wy / t).floor() as i64 - num("cy0"));
	let part = Regex::new(r"^Nav0_\d+\.lua$").unwrap();
	let needle = format!("data.packed.grid[{}] = ", k + 1);
	let mut names: Vec<String> = std::fs::read_dir(nav_dir()).unwrap().filter_map(|e| e.ok()).map(|e| e.file_name().to_string_lossy().into_owned()).filter(|n| part.is_match(n)).collect();
	names.sort();
	let file = names.into_iter().find(|n| std::fs::read_to_string(nav_dir().join(n)).unwrap().contains(&needle));
	(k, file)
}

const STRAIGHT: &str = r#"
	place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
	local f = guide()
	for _ = 1, 20 do stub.advance(0.05) end
	local a = aim()
	local _, tx, ty = N.GetTargetWorld()
	emit({ state = a.state, toTarget = a.x and dist(a.x, a.y, tx, ty), measured = a.measured, available = E and E.Available(0), points = f and f.points and #f.points or 0, cost = f and f.cost })"#;

fn with_maps(files: &[PathBuf], script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_encoding.lua", "stub_packs.lua"],
		before: before(files),
		addons: polestar_addons(),
		login: true,
		script: format!("{PRELUDE}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_map_whose_files_are_all_missing_from_nav_xml_leaves_the_straight_arrow_on_that_map_with_no_lua_error() {
	skip_unless_ready!();
	let (_tmp, ns) = ns_file();
	let mine = Regex::new(r"[\\/]Nav0(_\d+)?\.lua$").unwrap();
	let files: Vec<PathBuf> = nav_files(&ns).into_iter().filter(|p| !mine.is_match(&p.to_string_lossy())).collect();
	let out = with_maps(&files, STRAIGHT);
	assert_eq!(out["available"], false, "no data for map 0");
	assert_eq!(out["state"], "travel");
	assert!(f(&out["toTarget"]) < 1.0, "the arrow points at the goal itself ({})", out["toTarget"]);
	assert_ne!(out["measured"], true, "its distance is the straight one");
}

#[test]
fn a_corrupted_grid_block_of_the_map_leaves_the_straight_arrow_for_that_walk_with_no_lua_error() {
	skip_unless_ready!();
	let (k, file) = cluster_file(-9444.062, 77.667);
	let file = file.expect("Goldshire's cluster is in one part file");
	let tmp = TempDir::new("polestar-nav-bad-");
	let bad = tmp.path().join(&file);
	let text = std::fs::read_to_string(nav_dir().join(&file)).unwrap();
	let re = Regex::new(&format!(r"(?m)^data\.packed\.grid\[{}\] = \{{[^}}]*\}}$", k + 1)).unwrap();
	let broken = re.replace(&text, format!("data.packed.grid[{}] = {{\"bm90IHpsaWI=\"}}", k + 1).as_str()).into_owned();
	assert_ne!(broken, text);
	std::fs::write(&bad, broken).unwrap();
	let (_ns_tmp, ns) = ns_file();
	let files: Vec<PathBuf> = nav_files(&ns).into_iter().map(|p| if p.file_name().is_some_and(|n| n.to_string_lossy() == file) { bad.clone() } else { p }).collect();
	let out = with_maps(&files, STRAIGHT);
	assert_eq!(out["available"], true, "the map is there");
	assert_eq!(out["points"], 0, "no path through the broken cluster ({})", out["cost"]);
	assert_eq!(out["state"], "travel");
	assert!(f(&out["toTarget"]) < 1.0, "the arrow points at the goal itself ({})", out["toTarget"]);
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

// Fitz, 2026-10-16: a map marker near Astranaar; the route landed at a flight point south-west of it and drew a
// straight dotted walk over the Ashenvale/Stonetalon ridge. Until his coordinates come, the case from the
// description, with what the release zip carries (no local crossing data): a Horde character at the Crossroads who
// knows Sun Rock Retreat, Splintertree Post and Zoram'gar Outpost, guided to Ashenvale 40,70, just north-east of the
// ridge. Without crossing data for Kalimdor, straight x1.25 the route lands at Sun Rock Retreat, south-west, and
// walks over the ridge; the engine's walk from there runs 365 yd off that line, and from Splintertree Post it is 240
// yd shorter. With complete crossing data (Carbonite's, in TravelData.lua) Sun Rock Retreat's walk must take the
// Talondeep Path and the straight plan lands at Splintertree Post already; either way the measured plan lands there
// and draws its last walk along the engine's path.
#[test]
fn ashenvale_40_70_from_the_crossroads_the_route_lands_where_the_engines_walk_is_short_and_its_last_walk_follows_the_engines_path() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		Polestar.CharState().flags.taxi = { [22] = true, [23] = true, [25] = true, [29] = true, [58] = true, [61] = true, [77] = true }
		local by = {}
		for _, n in ipairs(N.GetTravelData().taxi) do by[n.id] = n end
		local xr, sun, splinter = by[25], by[29], by[61]
		place(xr.map, xr.wx, xr.wy)
		-- Where the route lands, its last walk, and how the route lines draw that walk.
		local function route()
			local legs, ci = N.GetRoute()
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
		aim()
		local covered = N.travel.CrossingCounts()
		local r = { before = route(), kalimdorCrossings = false }
		for _, c in ipairs(covered) do if c == 1 then r.kalimdorCrossings = true end end
		local n = 0
		while n < 400 and route().engine ~= "path" do stub.advance(0.05); aim(); n = n + 1 end
		r.after = route()
		local tc, tx, ty = N.GetTargetWorld()
		r.target = { tx, ty }
		r.splinter = { splinter.wx, splinter.wy }
		local cost = N.walk.Measured(tc, tx, ty, false)
		r.measured = { sun = cost(1, sun.wx, sun.wy), splinter = cost(1, splinter.wx, splinter.wy) }
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
	if out["kalimdorCrossings"] != true {
		assert_eq!(out["before"]["lands"], "Sun Rock Retreat, Stonetalon Mountains", "straight x1.25 lands south-west of the ridge");
	}
	assert_eq!(out["before"]["n"], 2, "and draws its last walk straight");
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

// The cause itself, pinned (review of travel-terrain): a Horde character at the Crossroads who knows Splintertree
// Post and Zoram'gar Outpost (not Sun Rock Retreat), guided to targets west of Astranaar. At one of them the walk
// from the landing straight x1.25 picks measures dearer than straight x1.25 (a ridge in the way: its path goes round,
// over 100 yd off the line) and the measured route lands elsewhere; where the walk measures within x1.25 the landing
// stays. Which target shows it depends on the shipped maps: on 0.2.4's Ashenvale 35,75 (Splintertree Post 1.38 x
// straight); on the re-packed maps, which close steep faces, Ashenvale 30,70 (Zoram'gar Outpost 1.62 x, its path
// round the ridge 590 yd off the straight line), while 35,75 now sits in a pocket every landing reaches about 3 x
// straight and Splintertree Post is still the least of them, so it stays.
#[test]
fn ashenvale_west_of_astranaar_where_a_ridge_makes_the_straight_choices_measured_walk_dearer_than_straight_x1_25_the_measured_route_lands_elsewhere() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.faction = "Horde"
		Polestar.CharState().flags.taxi = { [22] = true, [23] = true, [25] = true, [58] = true, [61] = true, [77] = true }
		local by, byName = {}, {}
		for _, n in ipairs(N.GetTravelData().taxi) do by[n.id] = n; byName[n.name] = n end
		local xr = by[25]
		place(xr.map, xr.wx, xr.wy)
		local function lands()
			local legs, ci = N.GetRoute()
			local fly
			for i = ci, #legs do if legs[i].kind == "fly" then fly = legs[i] end end
			return fly and fly.to.name or false
		end
		local r = {}
		for _, g in ipairs({ { 30, 70 }, { 35, 75 } }) do
			N.SetTarget(1440, g[1], g[2], "Behind the ridge", "e")
			aim()
			local before = lands()
			local tc, tx, ty = N.GetTargetWorld()
			local n = 0
			while n < 400 and not N.walk.Measured(tc, tx, ty, false) do stub.advance(0.05); aim(); n = n + 1 end
			local node = before and byName[before]
			local cost = N.walk.Measured(tc, tx, ty, false)
			local m = node and cost and cost(1, node.wx, node.wy)
			local off = 0
			if node and m then
				-- How far the engine's walk from that landing runs from the straight line.
				local pts = E.FindSync(1, { x = node.wx, y = node.wy }, { x = tx, y = ty }) or {}
				local dx, dy = tx - node.wx, ty - node.wy
				for _, p in ipairs(pts) do
					local s = math.max(0, math.min(1, ((p.x - node.wx) * dx + (p.y - node.wy) * dy) / (dx * dx + dy * dy)))
					off = math.max(off, dist(node.wx + dx * s, node.wy + dy * s, p.x, p.y))
				end
			end
			r[#r + 1] = { at = g, before = before, after = lands(), measured = m or false, straight = node and dist(node.wx, node.wy, tx, ty) or false, off = off }
		end
		emit(r)"#,
		true,
	);
	let mut ridges = 0;
	for c in out.as_array().unwrap() {
		if c["before"] == false || c["measured"] == false || c["before"].is_null() || c["measured"].is_null() {
			continue;
		}
		let ratio = f(&c["measured"]) / f(&c["straight"]);
		if ratio > 1.25 && c["after"] != c["before"] {
			ridges += 1;
			assert!(f(&c["off"]) > 100.0, "{}: the walk from {} goes round ({:.0} yd off the straight line, {ratio:.2} x)", c["at"], c["before"], f(&c["off"]));
		}
		if ratio <= 1.25 {
			assert_eq!(c["after"], c["before"], "{}: no ridge ({ratio:.2} x), the same landing", c["at"]);
		}
	}
	assert!(ridges >= 1, "a ridge makes one straight choice's walk dearer than straight x1.25, and the measured route lands elsewhere");
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
	assert_eq!(f(&out["switched"]["drawn"]["points"]), 2.0 * f(&out["switched"]["drawn"]["legs"]), "the switch drops the Balanced line at once: straight until the Roads walk is in");
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
		local f = walkFor(1420, START[1], START[2], "The plundering start")
		local r = { atLift = f.from[3] or false }
		walkTo(1420, pts)
		f = walkFor(1420, -160.1, 774.2, "The plundering goal")
		local first = f.points and f.points[2]
		r.walked = { z = f.from[3] or false, top = highest(f, START[1], START[2], 60), yards = floor(length(f.points or {})), second = first and first.z or false }
		emit(r)"#
		),
		true,
	);
	eprintln!("at the lift {}; walked in: from z {}, highest within 60 yd {}, {} yd", out["atLift"], out["walked"]["z"], out["walked"]["top"], out["walked"]["yards"]);
	assert_eq!(out["atLift"], false, "at the lift the floor is unknown");
	assert!((f(&out["walked"]["z"]) + 62.2).abs() <= 3.0, "searched from the lower level ({})", out["walked"]["z"]);
	assert!(f(&out["walked"]["top"]) < -20.0, "the drawn line's first 60 yd stay down there (highest {})", out["walked"]["top"]);
}

// Lifts (Fitz, 2026-10-23): the walking grid has no link between a lift's landings, so from the Undercity's lower
// floor to Brill the walk went out through the sewers. The router joins the landings of Polestar_Nav's lift
// chokepoints; the way in and out is one fixed chain (crossings.json, undercity-south-lift: Fitz's own walk), from the
// south lift's bottom landing up through the entrance hall and out of the front, both ways.
#[test]
fn lifts_from_the_undercitys_lower_floor_to_brill_the_walk_goes_to_the_south_lift_rides_it_up_and_follows_the_fixed_way_out_from_brill_in_the_same_way_down() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(20)
		w.faction = "Horde"
		IsIndoors = function() return 1 end
		place(1458, 1575, 240, -43) -- the Trade Quarter's ring, its height known
		N.SetTarget(1420, 61.9, 52.3, "Brill")
		for _ = 1, 600 do
			aim()
			stub.advance(0.05)
		end
		local legs, ci = N.GetRoute()
		local route = {}
		for i = ci, #legs do route[#route + 1] = legs[i].kind .. "|" .. legs[i].label end
		-- The arrow's own search: the last from where the player stands (the later walks are searched too).
		local f
		for _, rec in ipairs(finds) do
			if dist(rec.from[1], rec.from[2], 1575, 240) < 5 then f = rec end
		end
		local ride, yards = false, length(f and f.points or {})
		for i = 2, f and #f.points or 0 do
			local a, b = f.points[i - 1], f.points[i]
			if a.z and b.z and a.z < -30 and b.z > 50 and dist(a.x, a.y, b.x, b.y) < 15 then ride = true end
		end
		local r = { route = route, yards = floor(yards), to = f and { r1(f.to[1]), r1(f.to[2]), f.to[3] or false } }
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
		"walk|Brill",
	];
	assert_eq!(strs(&out["route"]), want, "to the south lift, up, and out along the fixed way");
	assert_eq!(out["to"], serde_json::json!([1544.8, 240.6, -41.4]), "the arrow's walk ends at the south lift's bottom landing");
	assert!(f(&out["yards"]) < 150.0, "and stays in the city ({} yd; out through the sewers it was over 1,000)", out["yards"]);
	let back = strs(&out["back"]);
	let down = back.iter().position(|s| s == "lift|Ride the elevator down");
	assert!(down.is_some_and(|d| d > 0 && back[d - 1] == "walk|Walk to the lift"), "in by the same way, down the south lift: {}", back.join(", "));
	assert_eq!(back.last().map(String::as_str), Some("walk|The canal"));
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

// Far waypoints (Fitz, 2026-10-23): every walk leg of the route is drawn along the ground as soon as the route is
// planned, before the planner's measure is in (Nav/Walk.lua pumpShapes: Path.FindCoarse's sketch over the entrance
// graph, a walk inside one cluster its own path), and no later. Before, a walk from a crossing's far end was hand-made
// (drawn and walked straight) and the others were searched only after the measure: from Mulgore below Thunder Bluff a
// straight line across Mulgore and straight segments north along the Stonetalon range. A walk leg drawn with two
// points is only one the engine's own path walks straight.
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
			for i, l in ipairs(g and g.legs or {}) do
				local leg = legs and legs[ci + i - 1]
				if l.kind == "walk" and leg and leg.kind == "walk" then
					local p = l.pts
					atMeasure[#atMeasure + 1] = { label = leg.label, n = #p, handmade = leg.handmade or false, ends = #p == 2 and { p[1][1], p[1][2], p[1][3], p[2][2], p[2][3] } or nil }
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
		out[#out + 1] = { label = l.label, n = l.n, handmade = l.handmade, engine = engine }
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
				if l["handmade"] == true { " hand-made" } else { "" }
			))
			.collect::<Vec<_>>()
			.join("; ")
	);
	assert!(legs.len() >= min, "the route walks {} legs", legs.len());
	for l in &legs {
		let n = f(&l["n"]);
		assert!(n > 2.0 || (n == 2.0 && l["engine"].as_f64().is_some_and(|e| e <= 2.0)), "{}: drawn with {n} points while the engine's path has {}", l["label"], l["engine"]);
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
		place(1412, -975, -107, nil)
		N.SetTarget(1442, 47.5, 61.5, "Stonetalon", "e")
		emit(shapes())"#
		),
		true,
	);
	check_shapes(&out, 4);
	assert!(out.as_array().unwrap().iter().any(|l| l["label"] == "Go to Stonetalon Mountains" && l["handmade"] != true), "the walk on from the Barrens crossing is the engine's");
}

#[test]
fn far_waypoints_from_the_ironforge_gate_to_tirisfal_every_walk_leg_follows_the_ground_before_the_planners_measure_is_in() {
	skip_unless_ready!();
	let out = run(
		&format!(
			"{SHAPES}{}",
			r#"
		w.setLevel(20)
		w.faction = "Alliance"
		local _, px, py = C.MapToWorld(1426, 53.3, 35.0, "e")
		place(1426, px, py, nil)
		N.SetTarget(1420, 61.9, 52.3, "Brill", "e")
		emit(shapes())"#
		),
		true,
	);
	check_shapes(&out, 6);
}

// Thunder Bluff (Fitz, 2026-10-23, TB 52.2,31.1 off the north lift's top): the walk on from the mesa crossing's far
// end was hand-made, so the map drew it straight from the landing to the target and, once the ride was over, the
// arrow pointed straight at it too.
#[test]
fn lifts_the_walk_on_from_thunder_bluffs_lift_crossing_is_the_engines_drawn_along_its_path_and_walked_along_it_off_the_top_landing() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(30)
		w.faction = "Horde"
		place(1412, -1010, -70, 68)
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
		-- The ride, then off the top landing: 45 yd from the bottom one.
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

// Ironforge's gate (Fitz, 2026-10-23, a Tauren after a /reload at the gate): the client says outdoors in the gate's
// arch, where the cell holds the city's floor (an indoor city class, 497) and the mountain's ground over it (620, the
// one outdoor surface), so the floor was seeded on the mountain and the walk to Loch Modan was searched and drawn from
// there, east over the mountains behind the city. An outdoor match seeds only below every indoor surface.
#[test]
fn t_234_floor_after_a_reload_in_ironforges_gate_the_walk_out_starts_on_the_gates_floor_and_takes_the_road_never_over_the_mountains() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(30)
		w.faction = "Horde"
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
		N.SetTarget(1413, 44, 80, "The Barrens 44, 80", "e")
		for _ = 1, 100 do aim(); stub.advance(0.05) end
		local f
		for i = n + 1, #finds do
			if dist(finds[i].from[1], finds[i].from[2], -5022.45, -831.61) < 3 and finds[i].done then f = finds[i] end
		end
		local top = -math.huge
		for _, p in ipairs(f and f.points or {}) do
			if p.z and dist(p.x, p.y, -5022.45, -831.61) < 400 then top = math.max(top, p.z) end
		end
		emit({ from = f and f.from[3] or false, top = top, n = f and f.points and #f.points or 0 })"#,
		true,
	);
	assert!(f(&out["n"]) > 2.0, "the walk out is searched");
	assert!(out["from"] == false || f(&out["from"]) < 520.0, "searched from the gate's floor or without a height ({})", out["from"]);
	assert!(f(&out["top"]) < 520.0, "its first 400 yd stay on the road below the gate (highest {}; over the mountains it climbs past 600)", out["top"]);
}

// Inside Ironforge (Fitz, 2026-10-23): the walk from the Commons to the city's crossing end at the gate stays in one
// cluster, the city's many floors under the mountain, so it is searched whole (no sketch) and it was slow: the
// same-cluster walk searched an A* from every start surface to every goal surface, and one to a surface the start's
// floor never joins (the mountain's ground over the gate) expanded all the start reaches. A goal the start's endpoint
// tree (a Dijkstra over the cluster, already run) never reached when it ran dry is out of reach: no A* for it. Same
// answer; a fraction of the work.
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
	assert!(f(&flat["n"]) < 50000.0, "without a height, {} expansions (83,679 with a search to every goal surface)", flat["n"]);
	assert_eq!((&fl["points"], &fl["yards"]), (&flat["points"], &flat["yards"]), "from the floor: the same path");
	assert!(f(&fl["n"]) < 5000.0, "from the floor, its endpoint search kept: {} expansions (22,145 before)", fl["n"]);
}

// Stormwind (Fitz, 2026-10-23, a Tauren in the Trade District at -8833,623, z 93.7): the cell holds the street (94,
// the indoor city class, as all of Stormwind's streets) and the canal level under it (59, the one outdoor surface),
// and the client says outdoors in the open street. The floor was seeded on the canal level, and the walk to a waypoint
// east of Goldshire went west through the city, over the mountains north-west of it, down the coast and through
// Westfall. Outdoors says nothing of a city's floors: the floor stays unknown there, and the walk takes the gate. Both
// factions (Stormwind is hostile to the Horde).
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
			emit({ from = f and f.from[3] or false, yards = floor(length(f and f.points or {})), n = f and f.points and #f.points or 0, north = floor(north) })"#
			.replace("@FACTION", faction),
		true,
	);
	assert!(f(&out["n"]) >= 2.0, "the walk out is searched");
	assert!(out["from"] == false || f(&out["from"]) > 80.0, "searched from the street or without a height ({})", out["from"]);
	assert!(f(&out["yards"]) < 600.0, "to the gate through the city ({} yd; over the mountains and down the coast it was over 4,000)", out["yards"]);
	assert!(f(&out["north"]) < -8700.0, "never north out of the city ({})", out["north"]);
}

#[test]
fn t_234_floor_horde_in_stormwinds_trade_district_outdoors_the_walk_out_starts_on_the_street_and_goes_through_the_gate() {
	stormwind_street("Horde");
}

#[test]
fn t_234_floor_alliance_in_stormwinds_trade_district_outdoors_the_walk_out_starts_on_the_street_and_goes_through_the_gate() {
	stormwind_street("Alliance");
}

// Stormwind as Horde (Fitz's trail round the city, 2026-10-23): from the Deeprun Tram's entrance (his mark, Stormwind
// 68.73,31.27 on the live map) the walk out to the gate took over 6,000 yd over the walls and round the mountains,
// because every step on the city's guarded ground costs a Horde walk twenty times over, and the shortest way off it is
// not the gate. A walk that starts or ends in the other faction's town is priced as for no faction (opts.homeHub): out
// through the streets and the gate, as an Alliance player walks it, the town still named on the leg.
#[test]
fn hostile_towns_a_tauren_at_the_deeprun_tram_walks_out_of_stormwind_through_its_streets_and_gate_as_an_alliance_player_does_the_town_still_named() {
	skip_unless_ready!();
	let out = run(
		r#"
		w.setLevel(30)
		w.faction = "Horde"
		IsIndoors = function() return nil end
		local _, tx, ty = C.MapToWorld(1453, 68.73, 31.27)
		place(1453, tx, ty, nil)
		for _ = 1, 30 do aim(); stub.advance(0.05) end
		N.SetTarget(1429, 56, 66, "East of Goldshire", "e")
		for _ = 1, 300 do aim(); stub.advance(0.05) end
		local f
		for _, rec in ipairs(finds) do
			if dist(rec.from[1], rec.from[2], tx, ty) < 3 and rec.done then f = rec end
		end
		local legs, ci = N.GetRoute()
		local named = {}
		for i = ci, #legs do
			for _, h in ipairs(legs[i].hubs or {}) do named[#named + 1] = h.name end
		end
		local alliance = E.FindSync(0, { x = f.from[1], y = f.from[2] }, { x = f.to[1], y = f.to[2] }, { profile = "Alliance" })
		local route = {}
		for i = ci, #legs do route[#route + 1] = legs[i].kind .. "|" .. legs[i].label .. "|" .. floor(legs[i].to.wx) .. "," .. floor(legs[i].to.wy) end
		emit({ route = route, from = { floor(tx), floor(ty) }, yards = floor(length(f.points or {})), opts = f.opts and f.opts.homeHub or false, alliance = floor(length(alliance or {})), named = table.concat(named, ", ") })"#,
		true,
	);
	assert_eq!(out["opts"], true, "the walk from inside the hostile town is priced as for no faction");
	assert!((f(&out["yards"]) - f(&out["alliance"])).abs() <= 20.0, "the Alliance player's way out ({} yd against {}; over the walls it was over 6,000)", out["yards"], out["alliance"]);
	assert!(out["named"].as_str().unwrap_or("").contains("Stormwind City"), "and the town is still named on the walk");
}

// Every capital's crossing end (crossings.json: the walks between a capital and its zone) lies on the capital's
// guarded ground (the maps' hubs), so a walk into or out of any capital by its gate is priced as for no faction for a
// player of the other one (Path.HubAt, opts.homeHub), and as before for its own.
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
// Open until the walking-map rebuild lands: #[ignore]d, so the suite stays green; run them with
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
#[test]
#[ignore = "open: #579 holds the fix until the walking-map rebuild"]
fn acceptance_568_from_dolanaar_to_the_darnassus_fishing_trainer_the_route_walks_in_through_the_gate_never_down_to_the_rutheran_portal() {
	skip_unless_ready!();
	let out = teldrassil_route((1438, 56.73, 61.90), (1457, 47.89, 56.65, "Fishing trainer"));
	let kinds = strs(&out["kinds"]);
	assert!(kinds.iter().all(|k| k == "walk") && !kinds.is_empty(), "it walks all the way ({})", kinds.join(", "));
	assert_eq!(f(&out["treeWalks"]), 0.0, "no walk leg joins Rut'theran to the top of the tree");
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
#[ignore = "open until the walking-map rebuild"]
fn acceptance_dolanaar_auberdine_from_dolanaar_to_auberdine_no_walk_leg_joins_the_top_of_teldrassil_to_rutheran() {
	dolanaar_auberdine((1438, 56.73, 61.9), (1439, 36.8, 44.3, "Auberdine"));
}

#[test]
#[ignore = "open until the walking-map rebuild"]
fn acceptance_dolanaar_auberdine_from_auberdine_to_dolanaar_no_walk_leg_joins_the_top_of_teldrassil_to_rutheran() {
	dolanaar_auberdine((1439, 36.8, 44.3), (1438, 55.9, 59.8, "Dolanaar"));
}
