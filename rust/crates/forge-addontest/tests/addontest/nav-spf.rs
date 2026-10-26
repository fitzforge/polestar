//! Walking paths (addon/Polestar/Nav/Walk.lua): the arrow follows the walking router started from Shortest Path
//! Forever's (addon/Polestar_Nav) instead of a straight line. A fake engine with deterministic callbacks stands
//! in for Polestar_NavEngine: the arrow follows the path's points, straying asks again, a new target cancels
//! the stale search, nothing is searched in combat, hand-made crossings and guide `goto`s win, and every
//! failure (no engine, no data, unreachable, an error, the option off) is today's straight arrow. Runs the
//! real Core/Init.lua + Nav/Nav.xml against tests/lua/stub_nav.lua.

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, is_match, truthy, Addon, RunAddon};
use serde_json::{json, Value};

// The fake engine, installed before the addon loads (Polestar_Nav's API.lua sets the same global).
// The fifth argument is the waterWalking flag or opts { waterWalking, profile, style }
// (Routing/Path.lua); a job keeps both. Answers carry job.yards (the drawn
// line's length) and job.hubs (fake.hubs: the hostile towns it enters).
const ENGINE: &str = r#"
fake = { calls = {}, avail = {} }
local function opts(job, o)
	job.opts = o
	if type(o) == "table" then
		job.waterWalking, job.profile = o.waterWalking, o.profile
	else
		job.waterWalking = o
	end
end
Polestar_NavEngine = {
	Find = function(map, from, to, callback, o)
		if fake.throw then error("boom") end
		local job = { map = map, from = from, to = to, callback = callback }
		opts(job, o)
		fake.calls[#fake.calls + 1] = job
		return job
	end,
	Cancel = function(job) job.cancelled = true end,
	Busy = function() return false end,
	Available = function(c) return fake.avail[c] ~= false end,
	-- The walkable surfaces under (x, y): fake.surfaces(map, x, y) -> { z, ..., [-i] = marks } (none without it;
	-- marks as Path.SurfacesAt's: 2 indoor, 1 water, 0 when left out); nil while fake.undecoded (the cluster not
	-- decoded: the router queues its decode), an error with fake.surfacesError. fake.reads counts the reads,
	-- fake.releases Path.ReleaseSurfaces. With fake.areaNames ({ [id] = name }: a map with areas, Path.AreaFormat 3)
	-- list.area[i] is surface i's AreaTable id, into the caller's areas.
	SurfacesAt = function(map, x, y, out, areas)
		if fake.surfacesError then error("bad cluster") end
		if fake.undecoded then return nil end
		fake.reads = (fake.reads or 0) + 1
		local list = fake.surfaces and fake.surfaces(map, x, y) or {}
		for i, z in ipairs(list) do
			out[i], out[-i] = z, list[-i] or 0
			if areas then areas[i] = list.area and list.area[i] or 0 end
		end
		return #list
	end,
	AreaFormat = function() return fake.areaNames and 3 or nil end,
	AreaName = function(map, id) return fake.areaNames and fake.areaNames[id] or nil end,
	ReleaseSurfaces = function() fake.releases = (fake.releases or 0) + 1 end,
}
fake.opts = opts
function fake.last() return fake.calls[#fake.calls] end
-- The path's length, as Find's job.yards gives it.
local function length(points)
	local yards = 0
	for i = 2, #points do yards = yards + math.sqrt((points[i].x - points[i - 1].x) ^ 2 + (points[i].y - points[i - 1].y) ^ 2) end
	return yards
end
-- Answer a search with the path x1, y1, x2, y2, ... (UnitPosition frame); its
-- cost (100) is never its yards, as on format 2 maps.
local function answer(job, xy)
	local points = {}
	for i = 1, #xy - 1, 2 do points[#points + 1] = { map = job.map, x = xy[i], y = xy[i + 1] } end
	job.yards, job.hubs = length(points), fake.hubs or {}
	job.callback(points, 100, job)
end
fake.answerXY = answer
-- Answer the last search.
function fake.resolve(...) answer(fake.last(), { ... }) end
function fake.fail(reason)
	local job = fake.last()
	job.callback(nil, reason, job)
end
"#;

const PRELUDE: &str = r#"
local N = Polestar.Nav
local nav = stub.nav
local floor = math.floor
local function target(wx, wy, label)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, label or "Target")
end
-- state, yards shown, and the world point the arrow aims at (rounded).
local function aim()
	local state, dist, _, dn, dw = N.Sample()
	local p = nav.player
	if not dn then return { state } end
	return { state, floor(dist + 0.5), floor(p.wx + dn + 0.5), floor(p.wy + dw + 0.5) }
end
local function calls() return #fake.calls end
"#;

// The planner's measures (Walk.Measure): the fake engine with Path.FindMany too.
// settle(job, fn) answers a batch with fn(x, y) per target: a cost, or false,
// and the yards along that walk (job.yards[i]; the cost when fn gives none,
// as on a format 1 map).
const MANY: &str = r#"
Polestar_NavEngine.FindMany = function(map, from, targets, callback, o, reverse)
	local job = { many = true, map = map, from = from, targets = targets, callback = callback, reverse = reverse }
	fake.opts(job, o)
	fake.calls[#fake.calls + 1] = job
	return job
end
-- The searches of one kind: many = true for batches, false for Path.Find.
function fake.of(many)
	local out = {}
	for _, job in ipairs(fake.calls) do if (job.many == true) == many then out[#out + 1] = job end end
	return out
end
function fake.settle(job, fn)
	local costs, yards = {}, {}
	for i, p in ipairs(job.targets) do
		local c, y = fn(p.x, p.y)
		costs[i] = c
		if y == nil then y = c end
		yards[i] = y
	end
	job.yards = yards
	job.callback(costs, nil, job)
end
-- Answer one Path.Find with the path x1, y1, x2, y2, ...
function fake.answer(job, ...) fake.answerXY(job, { ... }) end
"#;

fn run_with(script: &str, engine: bool, many: bool) -> Value {
	let before = if engine { format!("{ENGINE}{}", if many { MANY } else { "" }) } else { "fake = { calls = {} }".to_string() };
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		before,
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		login: true,
		script: format!("{PRELUDE}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn run(script: &str) -> Value {
	run_with(script, true, false)
}

fn run_many(script: &str) -> Value {
	run_with(script, true, true)
}

/// A number (NaN for anything else, as JS arithmetic on undefined).
fn num(v: &Value) -> f64 {
	v.as_f64().unwrap_or(f64::NAN)
}

/// JS Math.round.
fn round(x: f64) -> i64 {
	(x + 0.5).floor() as i64
}

/// The first `n` items of an array (`slice(0, n)`).
fn head(v: &Value, n: usize) -> Value {
	Value::Array(v.as_array().unwrap().iter().take(n).cloned().collect())
}

/// The items of an array from `n` on (`slice(n)`).
fn tail(v: &Value, n: usize) -> Value {
	Value::Array(v.as_array().unwrap().iter().skip(n).cloned().collect())
}

// The arrow aims along the path (Nav/Follow.lua): at a point up to 35 yd away
// on the way to the next corner, not at the corner itself. aim()'s point
// (out[2], out[3]) lies in the direction from (px, py) to (tx, ty), within 1 degree.
fn heads(out: &Value, (px, py): (f64, f64), (tx, ty): (f64, f64), msg: &str) {
	let a = (num(&out[3]) - py).atan2(num(&out[2]) - px);
	let b = (ty - py).atan2(tx - px);
	let mut d = (a - b).abs() * 180.0 / std::f64::consts::PI;
	if d > 180.0 {
		d = 360.0 - d;
	}
	assert!(d <= 1.0, "{msg}: the aim ({}, {}) is {d:.1} degrees off ({tx}, {ty})", out[2], out[3]);
}

#[test]
fn the_arrow_follows_the_path_s_points_with_the_yards_left_along_it() {
	let out = run(r#"
		local r = {}
		nav.place(0, 0)
		target(0, -600)
		r.before = aim()
		local job = fake.last()
		r.ask = { calls(), job.map, floor(job.from.x), floor(job.from.y), floor(job.to.x + 0.5), floor(job.to.y + 0.5) }
		fake.resolve(0, 0, 100, -100, 100, -500, 0, -600)
		r.first = aim()
		nav.place(100, -100)
		r.corner = aim()
		nav.place(100, -300)
		r.along = aim()
		nav.place(0, -598)
		r.arrived = aim()[1]
		r.calls = calls()
		emit(r)"#);
	assert_eq!(out["before"], json!(["travel", 600, 0, -600]), "straight until the path is in");
	assert_eq!(out["ask"], json!([1, 0, 0, 0, 0, -600]), "one search on the player's continent, player to target");
	assert_eq!(out["first"][1], 683, "the whole path's length");
	heads(&out["first"], (0.0, 0.0), (100.0, -100.0), "toward the first corner");
	assert_eq!(out["corner"][1], 541);
	heads(&out["corner"], (100.0, -100.0), (100.0, -500.0), "a passed point gives way to the next");
	assert_eq!(out["along"][1], 341);
	heads(&out["along"], (100.0, -300.0), (100.0, -500.0), "along the second leg");
	assert_eq!(out["arrived"], "arrived", "arrival is the target's radius, as before");
	assert_eq!(out["calls"], 1, "walking along the path asks nothing more");
}

// The look-ahead (Walk.lua's AHEAD 30, PAD 10): the arrow aims up to 30 yd
// along the path while every path point on the way stays within 10 yd of the
// line to it. LOOK samples the arrow from (x, y): its offset to the aim point
// (dx, dy), the yards shown and Walk.Left for the target (tx, ty).
const LOOK: &str = r#"
local function look(x, y, tx, ty)
	nav.place(x, y)
	local state, dist, _, dn, dw = N.Sample()
	local c = N.GetTargetWorld()
	return { state = state, dx = dn, dy = dw, dist = dist, left = N.walk.Left(c, tx, ty) }
end
-- Answer the last search with points { x, y[, z] }, ...
local function answerZ(pts)
	local job, out = fake.last(), {}
	for i, p in ipairs(pts) do out[i] = { map = job.map, x = p[1], y = p[2], z = p[3] } end
	job.callback(out, 100, job)
end
"#;

// Degrees between the aim (dx, dy) and straight down -y.
fn off_straight(s: &Value) -> f64 {
	num(&s["dx"]).atan2(-num(&s["dy"])).abs() * 180.0 / std::f64::consts::PI
}

#[test]
fn a_wiggly_road_points_3_yd_either_side_of_the_line_every_4_yd_keeps_the_arrow_straight_the_yards_shown_are_the_path_s() {
	let out = run(&[
		LOOK,
		r#"
		local pts = { { 0, 0 } }
		for i = 1, 100 do pts[#pts + 1] = { (i % 2 == 1) and 3 or -3, -4 * i } end
		pts[#pts + 1] = { 0, -404 }
		nav.place(0, 0)
		target(0, -404)
		N.Sample()
		answerZ(pts)
		local r = {}
		for y = 0, -300, -1 do r[#r + 1] = look(0, y, 0, -404) end
		emit({ samples = r, pts = pts })"#,
	]
	.concat());
	let pts: Vec<(f64, f64)> = out["pts"].as_array().unwrap().iter().map(|p| (num(&p[0]), num(&p[1]))).collect();
	let d = |a: (f64, f64), b: (f64, f64)| (a.0 - b.0).hypot(a.1 - b.1);
	let mut worst: f64 = 0.0;
	for (k, s) in out["samples"].as_array().unwrap().iter().enumerate() {
		let p = (0.0, 0.0 - k as f64);
		worst = worst.max(off_straight(s));
		// Walk.Left: straight to the end of the segment the player is on, then
		// along the path from it. On a zigzag the segment the player projects
		// onto may be either neighbour of a point, so within one point's spacing.
		let i = pts.iter().position(|q| q.1 < p.1).unwrap();
		let mut want = d(pts[i], p);
		for j in i..pts.len() - 1 {
			want += d(pts[j], pts[j + 1]);
		}
		assert_eq!(s["state"], "travel");
		assert!((num(&s["left"]) - want).abs() <= 6.0, "Walk.Left at y {}: {} against {}", p.1, s["left"], want);
		assert!((num(&s["dist"]) - num(&s["left"])).abs() < 1e-6, "the yards shown are Walk.Left");
	}
	assert!(worst <= 3.0, "the arrow stays within 3 degrees of straight (worst {worst:.1})");
}

#[test]
fn a_real_90_degree_corner_still_turns_the_arrow_gradually_from_within_30_yd_fully_at_the_corner() {
	let out = run(&[
		LOOK,
		r#"
		local pts = {}
		for i = 0, 25 do pts[#pts + 1] = { 0, -4 * i } end      -- south to (0, -100)
		for i = 1, 25 do pts[#pts + 1] = { 4 * i, -100 } end     -- then east to (100, -100)
		nav.place(0, 0)
		target(100, -100)
		N.Sample()
		answerZ(pts)
		emit({ far = look(0, -40, 100, -100), near = look(0, -85, 100, -100), at = look(0, -97, 100, -100) })"#,
	]
	.concat());
	assert!(off_straight(&out["far"]) < 1.0, "60 yd before the corner: straight on ({:.1})", off_straight(&out["far"]));
	let near = off_straight(&out["near"]);
	assert!(near > 25.0 && near < 70.0, "15 yd before it: turning toward it ({near:.1})");
	assert!(num(&out["near"]["dy"]) < -5.0, "still ahead along the road, not across the corner");
	let at = off_straight(&out["at"]);
	assert!(at > 70.0, "at the corner: along the new road ({at:.1})");
}

// Coming at the path from the side (loney's walk in the Wetlands, 0.2.6): the
// path was searched from 25 yd east of the road and runs west to it, then
// south down it. The player cuts the corner at 45 degrees and walks down the
// road 6 yd to its side, never within 5 yd of the joining points. The arrow
// never points back behind the player (north), and stays within 60 degrees
// of the road once they are beside it.
#[test]
fn approaching_the_path_at_45_degrees_and_walking_beside_the_road_the_arrow_never_points_back_at_a_node_behind() {
	let out = run(&[
		LOOK,
		r#"
		local pts = {}
		for x = 25, 1, -6 do pts[#pts + 1] = { x, 0 } end
		for i = 1, 60 do pts[#pts + 1] = { 0, -6 * i } end
		nav.place(25, 0)
		target(0, -360)
		N.Sample()
		answerZ(pts)
		local r = {}
		local x, y = 25, 0
		while x > -6 do
			x, y = x - 0.5, y - 0.5
			r[#r + 1] = { x = x, y = y, s = look(x, y, 0, -360) }
		end
		for _ = 1, 100 do
			y = y - 2
			r[#r + 1] = { x = x, y = y, s = look(x, y, 0, -360), beside = true }
		end
		emit(r)"#,
	]
	.concat());
	let mut worst: f64 = 0.0;
	for e in out.as_array().unwrap() {
		let s = &e["s"];
		assert_eq!(s["state"], "travel");
		assert!(num(&s["dy"]) < 0.0, "at ({}, {}) the arrow points back north (aim offset {:.1}, {:.1})", e["x"], e["y"], num(&s["dx"]), num(&s["dy"]));
		if truthy(&e["beside"]) {
			worst = worst.max(off_straight(s));
		}
	}
	assert!(worst <= 60.0, "beside the road the arrow stays within 60 degrees of it (worst {worst:.1})");
}

#[test]
fn the_look_ahead_never_aims_onto_another_floor_path_heights_or_past_a_split_walk_s_chokepoint() {
	let floors = run(&[
		LOOK,
		r#"
		local pts = {}
		for i = 0, 50 do pts[#pts + 1] = { 0, -4 * i, i <= 5 and 0 or 20 } end -- past y -20, a floor 20 yd up
		nav.place(0, 0)
		target(0, -200)
		N.Sample()
		answerZ(pts)
		local flat = look(0, 0, 0, -200)
		-- The same straight road on one floor looks the whole 30 yd ahead.
		target(0, -201)
		N.Sample()
		for _, p in ipairs(pts) do p[3] = 0 end
		pts[#pts + 1] = { 0, -201, 0 }
		answerZ(pts)
		emit({ floor = flat, open = look(0, 0, 0, -201) })"#,
	]
	.concat());
	assert!(num(&floors["floor"]["dy"]) >= -20.0, "stops at the last point on the player's floor (aim {} yd)", floors["floor"]["dy"]);
	assert!(num(&floors["open"]["dy"]) < -20.0, "one floor: further ahead (aim {} yd)", floors["open"]["dy"]);

	let split = run(&[
		LOOK,
		"\n\t\tnav.useTravelWorld()\n\t\t",
		CHOKES,
		r#"
		local pts = {}
		for i = 0, 150 do pts[#pts + 1] = { 0, -4 * i } end
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		answerZ(pts)
		local legs, ci = N.GetRoute()
		-- Walk down the road to 11 yd short of the bridge (its piece ends within 10), the arrow sampling each yard.
		local furthest = 0
		for y = 0, -139, -1 do
			local s = look(0, y, 0, -600)
			if y + s.dy < furthest then furthest = y + s.dy end
		end
		emit({ leg = legs[ci].choke and legs[ci].choke.kind, furthest = furthest })"#,
	]
	.concat());
	assert_eq!(split["leg"], "bridge", "the first piece ends at the bridge (y -150)");
	assert!(num(&split["furthest"]) >= -148.0, "the aim never passes the path point before the bridge (y -148; furthest {})", split["furthest"]);
}

#[test]
fn straying_more_than_25_yards_from_the_path_asks_again_at_most_every_2_seconds_keeping_the_old_path_meanwhile() {
	let out = run(r#"
		local r = {}
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		fake.resolve(0, 0, 0, -300, 0, -600)
		nav.place(20, -200)
		aim()
		r.near = calls()
		nav.place(60, -200)
		r.strayAt = aim()
		r.tooSoon = calls()
		stub.advance(3)
		aim()
		r.later = calls()
		local job = fake.last()
		r.from = { floor(job.from.x), floor(job.from.y) }
		fake.resolve(60, -200, 60, -600, 0, -600)
		r.after = aim()
		emit(r)"#);
	assert_eq!(out["near"], 1, "20 yards off is on the path");
	assert_eq!(out["strayAt"][0], "travel");
	assert!(out["strayAt"][2] == 0 && num(&out["strayAt"][3]) < -200.0, "the old path, ahead, until a new one arrives (aim {}, {})", out["strayAt"][2], out["strayAt"][3]);
	assert_eq!(out["tooSoon"], 1, "not again within 2 seconds of the last search");
	assert_eq!(out["later"], 2, "asked again from where the player is");
	assert_eq!(out["from"], json!([60, -200]));
	assert_eq!(out["after"][1], 460);
	heads(&out["after"], (60.0, -200.0), (60.0, -600.0), "along the new path");
}

#[test]
fn c1_c2_a_new_target_cancels_the_stale_search_whose_late_answer_is_dropped_never_reviving_the_old_target() {
	let out = run(r#"
		local r = {}
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		local stale = fake.last()
		target(500, 0)
		r.aim = aim()
		r.cancelled = stale.cancelled == true
		r.calls = calls()
		stale.callback({ { map = 0, x = 0, y = 0 }, { map = 0, x = 0, y = -300 } }, 1, stale)
		r.late = aim()
		emit(r)"#);
	assert_eq!(out["cancelled"], true);
	assert_eq!(out["calls"], 2);
	assert_eq!(out["aim"], json!(["travel", 500, 500, 0]));
	assert_eq!(out["late"], json!(["travel", 500, 500, 0]), "the old target's path is never followed");
}

#[test]
fn nothing_is_searched_in_combat_the_search_follows_once_combat_ends() {
	let out = run(r#"
		local r = {}
		stub.inCombat = true
		nav.place(0, 0)
		target(0, -600)
		r.fight = aim()
		r.inCombat = calls()
		stub.inCombat = false
		aim()
		r.after = calls()
		emit(r)"#);
	assert_eq!(out["fight"], json!(["travel", 600, 0, -600]), "straight meanwhile");
	assert_eq!(out["inCombat"], 0);
	assert_eq!(out["after"], 1);
}

#[test]
fn hand_made_crossings_win_the_engine_walks_to_the_gate_the_crossing_itself_is_the_data_s_its_line_is_searched_once_for_the_map() {
	let out = run(r#"
		local r = {}
		N.RegisterCrossings({ complete = true,
			zones = {
				[9002] = { name = "West Vale", c = 0, top = 1000, bottom = -1000, left = 1000, right = 0 },
				[9003] = { name = "East Vale", c = 0, top = 1000, bottom = -1000, left = 0, right = -1000 },
			},
			crossings = { { id = "gate", a = { map = 9002, c = 0, wx = 600, wy = 20, r = 15 }, b = { map = 9003, c = 0, wx = 600, wy = -20, r = 15 },
				ab = "Through the gate to East Vale" } } })
		nav.place(-500, 500)
		target(-500, -500, "Kobolds")
		aim()
		local job = fake.last()
		r.toGate = { calls(), floor(job.to.x + 0.5), floor(job.to.y + 0.5) }
		fake.resolve(-500, 500, 0, 300, 600, 20)
		r.walk = aim()
		nav.place(600, 25)
		r.crossing = aim()
		r.calls = calls()
		local line = fake.last()
		r.line = { floor(line.from.x + 0.5), floor(line.from.y + 0.5), floor(line.to.x + 0.5), floor(line.to.y + 0.5) }
		fake.answerXY(line, { 600, 20, 610, 0, 600, -20 })
		r.crossingAfter = aim()
		local legs = N.GetRouteGeometry().legs
		r.drawn = #legs[1].pts
		local leg = Polestar.Nav.travel.CurrentLeg()
		r.handmade = leg.handmade == true
		emit(r)"#);
	assert_eq!(out["toGate"], json!([1, 600, 20]), "searched only up to the gate");
	assert_eq!(out["walk"][1], 1201);
	heads(&out["walk"], (-500.0, 500.0), (0.0, 300.0), "along the path to the gate");
	assert_eq!(out["crossing"], json!(["travel", 45, 600, -20]), "straight through the gate to its other side");
	assert_eq!(out["calls"], 2, "one more search: the crossing's line");
	assert_eq!(out["line"], json!([600, 20, 600, -20]), "from end to end");
	assert_eq!(out["crossingAfter"], json!(["travel", 45, 600, -20]), "the arrow still goes straight through the gate");
	assert_eq!(out["drawn"], 3, "the map draws the crossing along its path");
	assert_eq!(out["handmade"], true);
}

#[test]
fn a_guide_goal_after_a_guide_goto_keeps_the_straight_arrow_from_the_mouth_the_goto_itself_is_walked() {
	let out = run(r#"
		local r = {}
		local m, mx, my = nav.mapPoint(0, -400)     -- the mouth
		local _, ix, iy = nav.mapPoint(0, -450)     -- inside
		local _, ox, oy = nav.mapPoint(200, -450)   -- an NPC in the open
		local guide = { steps = {
			{ goals = { { t = "goto", map = m, x = mx, y = my } } },
			{ goals = { { t = "accept", quest = 1 }, { t = "collect", map = m, x = ix, y = iy } } },
			{ goals = { { t = "talk", map = m, x = ox, y = oy }, { t = "kill", map = m, x = ix, y = iy } } },
		} }
		Polestar.Engine.GetGuide = function() return guide end
		nav.place(0, 0)
		nav.setWaypoint({ map = m, x = mx, y = my, label = "Mouth", stepIndex = 1, goalIndex = 1, kind = "goto", r = 5 })
		aim()
		r.mouth = calls()
		nav.setWaypoint({ map = m, x = ix, y = iy, label = "Inside", stepIndex = 2, goalIndex = 2, kind = "collect", r = 5 })
		r.inside = aim()
		r.insideCalls = calls()
		nav.setWaypoint({ map = m, x = ix, y = iy, label = "Inside", stepIndex = 3, goalIndex = 2, kind = "kill", r = 5 })
		aim()
		r.afterTalk = calls()
		emit(r)"#);
	assert_eq!(out["mouth"], 1, "the goto is a goal like any other");
	assert_eq!(out["inside"], json!(["travel", 450, 0, -450]), "the goal after it is straight");
	assert_eq!(out["insideCalls"], 1);
	assert_eq!(out["afterTalk"], 2, "after a located goal that is no goto, the engine walks again");
}

#[test]
fn fallbacks_no_engine_no_data_for_the_continent_unreachable_an_error_the_straight_arrow() {
	let none = run_with(
		r#"
		nav.place(0, 0)
		target(0, -600)
		emit({ aim(), Polestar.Nav.Path == nil })"#,
		false,
		false,
	);
	assert_eq!(none, json!([["travel", 600, 0, -600], true]));

	let out = run(r#"
		local r = {}
		fake.avail[0] = false
		nav.place(0, 0)
		target(0, -600)
		r.nodata = { aim(), calls() }
		fake.avail[0] = nil
		target(0, -500)
		aim()
		fake.fail("unreachable")
		r.unreachable = aim()
		nav.place(0, -40)
		stub.advance(5)
		aim()
		r.soon = calls()
		stub.advance(15)
		aim()
		r.retry = calls()
		fake.throw = true
		target(0, 400)
		r.error = aim()
		emit(r)"#);
	assert_eq!(out["nodata"], json!([["travel", 600, 0, -600], 0]));
	assert_eq!(out["unreachable"], json!(["travel", 500, 0, -500]));
	assert_eq!(out["soon"], 1, "a failed search is not repeated at once");
	assert_eq!(out["retry"], 2, "but again after 15 s and 25 yards");
	assert_eq!(out["error"], json!(["travel", 440, 0, 400]));
}

#[test]
fn nav_navrouting_off_the_straight_arrow_the_search_in_flight_cancelled() {
	let out = run(r#"
		local r = {}
		r.default = Polestar.Get("nav.navRouting")
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		local job = fake.last()
		Polestar.Set("nav.navRouting", false)
		r.aim = aim()
		r.cancelled = job.cancelled == true
		target(0, -500)
		aim()
		r.calls = calls()
		emit(r)"#);
	assert_eq!(out["default"], true);
	assert_eq!(out["aim"], json!(["travel", 600, 0, -600]));
	assert_eq!(out["cancelled"], true);
	assert_eq!(out["calls"], 1);
}

#[test]
fn a_ghost_s_walk_is_searched_with_water_walking() {
	let out = run(r#"
		UnitIsGhost = function() return true end
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		emit(fake.last().waterWalking == true)"#);
	assert_eq!(out, true);
}

#[test]
fn route_geometry_the_walk_carries_the_engine_s_path_once_in_the_straight_line_before_changes_are_announced() {
	let out = run(r#"
		local r, fired = {}, 0
		Polestar.On("NAV_ROUTE_GEOMETRY", function() fired = fired + 1 end)
		r.none = N.GetRouteGeometry() == nil
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		local g = N.GetRouteGeometry()
		r.straight = { #g.legs, g.legs[1].kind, #g.legs[1].pts, g.legs[1].current }
		local before = fired
		fake.resolve(0, 0, 100, -100, 100, -500, 0, -600)
		r.fired = fired > before
		g = N.GetRouteGeometry()
		local pts = {}
		for _, p in ipairs(g.legs[1].pts) do pts[#pts + 1] = { p[1], floor(p[2] + 0.5), floor(p[3] + 0.5) } end
		r.path = pts
		emit(r)"#);
	assert_eq!(out["none"], true);
	assert_eq!(out["straight"], json!([1, "walk", 2, true]));
	assert_eq!(out["fired"], true);
	assert_eq!(out["path"], json!([[0, 0, 0], [0, 100, -100], [0, 100, -500], [0, 0, -600]]));
}

// ---------------------------------------------------------------------------
// Chokepoint steps (docs/NAV_QA.md, K1-K8):
// the walk the arrow is on is split where the engine's path passes a lift,
// gate, bridge, tunnel, pass or a cave or building mouth.

// A straight path west from (0, 0) to the target at (0, -600), with a bridge,
// a nameless cave mouth, a lift (bottom then top landing) along it, and
// chokepoints the split must leave out.
const CHOKES: &str = r#"
PolestarNavChokepoints = { [0] = {
	{ wx = 8, wy = -150, r = 10, kind = "bridge", name = "Bridge Hollow", zone = "Testshire",
		sides = { { wx = 0, wy = -100, area = "Westbrook" }, { wx = 0, wy = -200, area = "Lakeshire" } } },
	{ wx = 0, wy = -400, r = 10, kind = "cave", name = "", zone = "Testshire" },
	{ wx = 0, wy = -500, r = 10, kind = "lift", name = "Lift Bottom", liftEnd = "bottom", lift = "The Great Lift", pair = 4 },
	{ wx = 0, wy = -520, r = 10, kind = "lift", name = "Lift Top", liftEnd = "top", lift = "The Great Lift", pair = 3 },
	{ wx = 200, wy = -300, r = 10, kind = "gate", name = "Far Gate", zone = "Testshire" },  -- off the path
	{ wx = 0, wy = -10, r = 10, kind = "pass", name = "Start Pass", zone = "Testshire" },   -- at the start
	{ wx = 0, wy = -405, r = 10, kind = "tunnel", name = "Twin", zone = "Testshire" },      -- 5 yd past the cave
} }
"#;

const SPLIT_TAIL: &str = r#"
local function labels()
	local legs, ci = N.GetRoute()
	local out = {}
	for i = ci or 1, legs and #legs or 0 do out[#out + 1] = legs[i].kind .. "|" .. legs[i].label end
	return out
end
nav.place(0, 0)
target(0, -600)
N.Sample()
fake.resolve(0, 0, 0, -300, 0, -600)
"#;

fn split() -> String {
	format!("\nnav.useTravelWorld()\n{CHOKES}{SPLIT_TAIL}")
}

#[test]
fn k1_k5_a_walk_is_split_at_the_chokepoints_on_its_path_each_step_named_snapped_onto_the_path() {
	let out = run(&format!(
		"{}{}",
		split(),
		r#"
		local legs = N.GetRoute()
		emit({ labels = labels(), first = { legs[1].to.wx, legs[1].to.wy, legs[1].step, legs[1].choke.kind, legs[1].choke.name },
			cave = legs[2].choke.name, lift = { legs[4].kind, legs[4].side, legs[4].to.wy } })"#
	));
	assert_eq!(
		out["labels"],
		json!(["walk|Cross the bridge to Lakeshire", "walk|Walk to the cave mouth in Testshire", "walk|Walk to The Great Lift, Bottom", "lift|Ride the elevator up", "walk|Target",]),
		"off-path, start and doubled chokepoints left out; a nameless one is named by its zone, never \"Unknown\""
	);
	assert_eq!(out["first"], json!([0, -150, "bridge", "bridge", "Lakeshire"]), "K5: the step ends on the path, not at the chokepoint 8 yd off it");
	assert_eq!(out["cave"], "Testshire");
	assert_eq!(out["lift"], json!(["lift", "bottom", -520]), "the ride goes to the paired landing");
}

// The Undercity's canals lie under the Ruins: a chokepoint there is no stop for a walk over the Ruins above it.
#[test]
fn a_chokepoint_more_than_30_yd_above_or_below_the_path_is_no_stop_one_on_the_paths_floor_is() {
	let out = run(r#"
		nav.useTravelWorld()
		PolestarNavChokepoints = { [0] = {
			{ wx = 0, wy = -200, z = -52, r = 10, kind = "cave", name = "Canal Below", zone = "Testshire" },
			{ wx = 0, wy = -400, z = 58, r = 10, kind = "cave", name = "Ruins Door", zone = "Testshire" },
		} }
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		local job, pts = fake.last(), {}
		for _, p in ipairs({ { 0, 0, 60 }, { 0, -300, 61 }, { 0, -600, 60 } }) do pts[#pts + 1] = { map = job.map, x = p[1], y = p[2], z = p[3] } end
		job.callback(pts, 100, job)
		local legs, ci = N.GetRoute()
		local out = {}
		for i = ci or 1, legs and #legs or 0 do out[#out + 1] = legs[i].kind .. "|" .. legs[i].label end
		emit(out)"#);
	assert_eq!(out, json!(["walk|Walk to the Ruins Door cave mouth", "walk|Target"]));
}

#[test]
fn k2_the_steps_stay_the_same_over_10_position_updates_along_a_leg_and_advance_as_each_is_reached() {
	let out = run(&format!(
		"{}{}",
		split(),
		r#"
		local first, legs0 = labels(), N.GetRoute()
		local same = true
		for i = 1, 10 do
			nav.place(1, -10 * i)
			N.Sample()
			stub.advance(1)
			local now = labels()
			if #now ~= #first or now[1] ~= first[1] or N.GetRoute() ~= legs0 then same = false end
		end
		nav.place(0, -148)
		N.Sample()
		emit({ same = same, calls = calls(), next = Polestar.Nav.travel.CurrentLabel() })"#
	));
	assert_eq!(out["same"], true);
	assert_eq!(out["calls"], 1, "no new search on the way");
	assert_eq!(out["next"], "Walk to the cave mouth in Testshire");
}

#[test]
fn k3_k6_walk_steps_carry_no_wait_and_their_times_sum_exactly_to_the_walk_a_lift_step_carries_its_timetable_wait_and_caption() {
	let out = run(&[
		"\n\t\tnav.useTravelWorld()\n\t\t",
		CHOKES,
		r#"
		local asked
		Polestar.Transit = {
			Now = function() return 100 end,
			LiftNear = function() return 7, "The Great Lift" end,
			NextDeparture = function(kind, id, now, side) asked = { kind, id, side } return 40, 20 end,
			Caption = function(kind, id, now, side) return "Leaves in about 0:40" end,
		}
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		fake.resolve(0, 0, 0, -300, 0, -600)
		local legs = N.GetRoute()
		local walkSecs, walkYards, lift = 0, 0, nil
		for _, l in ipairs(legs) do
			if l.kind == "walk" then walkSecs, walkYards = walkSecs + l.seconds, walkYards + l.yards else lift = l end
		end
		for _, wy in ipairs({ -150, -400, -500 }) do
			nav.place(0, wy)
			N.Sample()
			N.Sample()
		end
		emit({ walkSecs = walkSecs, walkYards = walkYards, lift = { lift.seconds, lift.lift }, asked = asked,
			total = legs[1].seconds + legs[1].rest, caption = Polestar.Nav.travel.CurrentLabel() })"#,
	]
	.concat());
	assert_eq!(out["walkSecs"], round(600.0 / 7.0), "the pieces add up to the path at run speed");
	assert_eq!(out["walkYards"], 600);
	assert_eq!(out["lift"], json!([60, 7]));
	assert_eq!(out["asked"], json!(["lift", 7, "bottom"]));
	assert_eq!(out["total"], round(600.0 / 7.0) + 60);
	assert_eq!(out["caption"], "Ride the elevator up\nLeaves in about 0:40");
}

#[test]
fn k4_a_lift_s_side_comes_from_the_path_s_direction_not_the_player_s_height() {
	let out = run(&[
		"\n\t\tnav.useTravelWorld()\n\t\t",
		CHOKES,
		r#"
		nav.place(0, -600)
		target(0, 0)
		N.Sample()
		fake.resolve(0, -600, 0, -300, 0, 0)
		local legs = N.GetRoute()
		local lift
		for _, l in ipairs(legs) do if l.kind == "lift" then lift = l end end
		emit({ legs[1].label, lift.side, lift.to.wy })"#,
	]
	.concat());
	assert_eq!(out, json!(["Walk to The Great Lift, Top", "top", -500]));
}

#[test]
fn a_lift_ride_says_which_way_up_from_the_bottom_down_from_the_top_within_30_yd_of_the_landing_the_walk_shows_the_ride() {
	let out = run(&[
		"\n\t\tnav.useTravelWorld()\n\t\t",
		CHOKES,
		r#"
		local T = Polestar.Nav.travel
		local function ride()
			for _, l in ipairs(N.GetRoute()) do if l.kind == "lift" then return l.label end end
		end
		local function walkTo(wy)
			nav.place(0, wy)
			N.Sample()
			return T.CurrentLabel()
		end
		local r = {}
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		fake.resolve(0, 0, 0, -300, 0, -600)
		r.up = ride()
		walkTo(-150)
		walkTo(-400)
		r.far = walkTo(-440)
		r.near = walkTo(-480)
		r.back = walkTo(-440)
		nav.place(0, -600)
		target(0, 0)
		N.Sample()
		fake.resolve(0, -600, 0, -300, 0, 0)
		r.down = ride()
		r.nearTop = walkTo(-540)
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["up"], "Ride the elevator up");
	assert_eq!(out["down"], "Ride the elevator down");
	assert_eq!(out["far"], "Walk to The Great Lift, Bottom", "60 yd off: still the walk");
	assert_eq!(out["near"], "Ride the elevator up", "20 yd from the bottom landing: the ride");
	assert_eq!(out["back"], "Walk to The Great Lift, Bottom", "walked back off: the walk again");
	assert_eq!(out["nearTop"], "Ride the elevator down");
}

#[test]
fn k7_legs_under_a_few_yards_are_dropped_and_every_eta_stays_finite() {
	let out = run(&format!(
		"{}{}",
		split(),
		r#"
		local T = Polestar.Nav.travel
		local finite = true
		local legs = N.GetRoute()
		for i = 1, #legs do
			local s, y = T.Progress()
			if s ~= s or s == math.huge or (y and (y ~= y or y == math.huge)) then finite = false end
			if legs[i].seconds ~= legs[i].seconds or legs[i].yards ~= legs[i].yards then finite = false end
			T.SkipLeg()
		end
		local short = 0
		for _, l in ipairs(legs) do if l.kind == "walk" and l.yards < 20 then short = short + 1 end end
		emit({ finite = finite, short = short })"#
	));
	assert_eq!(out["finite"], true);
	assert_eq!(out["short"], 0);
}

#[test]
fn second_review_a_walk_leg_takes_the_engine_path_s_length_once_it_arrives() {
	let out = run(r#"
		nav.useTravelWorld()
		local T = Polestar.Nav.travel
		local function walk()
			local legs, ci = N.GetRoute()
			local l = legs[ci]
			return { l.kind, l.yards, l.seconds, l.seconds + l.rest, #legs }
		end
		local r, changes = {}, 0
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		r.straight = walk()
		local before = changes
		fake.resolve(0, 0, 300, -300, 0, -600)
		r.changes = changes - before
		r.path = walk()
		N.Sample() -- the arrow's next frame
		local s, y = T.Progress()
		r.progress = { floor(s + 0.5), floor(y + 0.5) }
		r.calls = calls()
		-- Strayed, asked again, and that search fails: back to the straight estimate.
		nav.place(0, -40)
		stub.advance(3)
		N.Sample()
		fake.fail("unreachable")
		r.failed = walk()
		-- A path again, then the option off (the path cleared): straight again.
		target(0, -650)
		N.Sample()
		fake.resolve(0, -40, 300, -300, 0, -650)
		r.again = walk()
		Polestar.Set("nav.navRouting", false)
		r.cleared = walk()
		emit(r)"#);
	assert_eq!(out["straight"], json!(["walk", 750, 107, 107, 1]), "straight x1.25 at 7 yd/s before the path");
	let path = 2.0 * 300f64.hypot(300.0);
	assert_eq!(out["path"], json!(["walk", round(path), round(path / 7.0), round(path / 7.0), 1]), "the path's yards, at the same pace");
	assert_eq!(out["changes"], 1, "one ROUTE_CHANGED, as a split fires");
	assert_eq!(out["progress"], json!([round(path / 7.0), round(path)]), "Progress agrees with the leg");
	assert_eq!(out["calls"], 1);
	assert_eq!(out["failed"], out["straight"], "the search failed: the planner's straight estimate again");
	assert_eq!(out["again"][1], round(300f64.hypot(260.0) + 300f64.hypot(350.0)));
	assert_eq!(out["cleared"][1], round(610.0 * 1.25), "the straight estimate again once the path is cleared");
}

#[test]
fn k8_a_hand_made_crossing_chain_node_or_guide_goto_at_the_same_spot_keeps_its_own_caption() {
	let out = run(r#"
		nav.useTravelWorld()
		PolestarNavChokepoints = { [0] = {
			{ wx = 0, wy = -575, r = 10, kind = "cave", name = "Goto Cave", zone = "Testshire" },
			{ wx = 0, wy = -300, r = 10, kind = "gate", name = "Chain Gate", zone = "Testshire" },
			{ wx = 0, wy = -150, r = 10, kind = "bridge", name = "Kept Bridge", zone = "Testshire" },
		} }
		N.RegisterCrossings({ complete = false, chains = { { id = "c", name = "C", nodes = {
			{ map = 9000, c = 0, wx = 0, wy = -310, r = 10, caption = "Enter" }, { map = 9000, c = 0, wx = 50, wy = -310, r = 10 } } } } })
		local m, x, y = nav.mapPoint(0, -600)
		nav.place(0, 0)
		nav.setWaypoint({ map = m, x = x, y = y, label = "The mouth", stepIndex = 1, goalIndex = 1, kind = "goto", r = 5 })
		N.Sample()
		fake.resolve(0, 0, 0, -300, 0, -600)
		local legs, ci = N.GetRoute()
		local out = {}
		for i = ci, #legs do out[#out + 1] = legs[i].label end
		emit(out)"#);
	assert_eq!(out, json!(["Cross the bridge to Kept Bridge", "The mouth"]));
}

#[test]
fn k4_a_packed_lift_s_landings_a_few_yards_apart_the_side_boarded_comes_from_the_path_s_height_the_ride_goes_to_the_other_landing() {
	let out = run(r#"
		nav.useTravelWorld()
		PolestarNavChokepoints = { [0] = {
			{ wx = 0, wy = -300, z = 0, r = 6, kind = "lift", name = "Ruins", zone = "Testshire", lift = "Undervator", liftEnd = "bottom", pair = 2 },
			{ wx = 0, wy = -308, z = 90, r = 6, kind = "lift", name = "Ruins", zone = "Testshire", lift = "Undervator", liftEnd = "top", pair = 1 },
		} }
		local function liftLeg()
			for _, l in ipairs(N.GetRoute()) do if l.kind == "lift" then return l end end
		end
		local r = {}
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		local job = fake.last()
		job.callback({ { map = 0, x = 0, y = 0, z = 90 }, { map = 0, x = 0, y = -200, z = 90 }, { map = 0, x = 0, y = -304, z = 45 },
			{ map = 0, x = 0, y = -400, z = 0 }, { map = 0, x = 0, y = -600, z = 0 } }, 1, job)
		local l = liftLeg()
		r.down = { N.GetRoute()[1].label, l.side, l.to.wy }
		emit(r)"#);
	assert_eq!(out["down"], json!(["Walk to Undervator, Top", "top", -300]), "going down: board at the top landing, ride to the bottom one");
}

// Floors (docs/NAV_QA.md Z1-Z3): a guide goal at an NPC or object carries its
// spawn's height (`z`, the compiler's) on the Engine's waypoint, and the walk
// to it is searched with that height.
const Z_WAYPOINT: &str = r#"
local m, x, y = nav.mapPoint(0, -600)
local function goal(z, step) nav.setWaypoint({ map = m, x = x, y = y, z = z, label = "Andron", stepIndex = step or 1, goalIndex = 1, kind = "turnin", r = 5 }) end
-- Answer the last search with points { x, y, z }, ...
local function answer(...)
	local job, pts = fake.last(), {}
	for i, p in ipairs({ ... }) do pts[i] = { map = job.map, x = p[1], y = p[2], z = p[3] } end
	job.callback(pts, 100, job)
end
"#;

#[test]
fn z1_the_engine_waypoint_s_height_goes_to_the_walking_engine_with_the_target_a_hand_set_target_has_none() {
	let out = run(&[
		Z_WAYPOINT,
		r#"
		local r = {}
		nav.place(0, 0)
		goal(-66)
		N.Sample()
		r.withZ = { calls(), fake.last().to.z, select(4, N.GetTargetWorld()) }
		answer({ 0, 0, 34 }, { 0, -590, -66 }, { 0, -600, -66 })
		r.kept = { aim()[1], calls() }
		target(0, -600, "By hand")
		N.Sample()
		r.hand = { calls(), fake.last().to.z == nil, select(4, N.GetTargetWorld()) == nil }
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["withZ"], json!([1, -66, -66]), "the target keeps the waypoint's z, and the search asks for it");
	assert_eq!(out["kept"], json!(["travel", 1]), "a path ending on that floor is used as it is");
	assert_eq!(out["hand"], json!([2, true, true]), "the same spot set by hand: searched again, without a height");
}

#[test]
fn t_180_a_target_set_by_hand_at_an_npc_with_its_height_nav_settarget_s_z_a_class_trainer_a_goal_s_row_is_searched_with_it() {
	let out = run(&[
		Z_WAYPOINT,
		r#"
		local r = {}
		nav.place(0, 0)
		N.SetTarget(m, x, y, "Trainer", nil, "trainer", -66)
		N.Sample()
		r.withZ = { calls(), fake.last().to.z, select(4, N.GetTargetWorld()), N.GetTarget().z }
		N.SetTarget(m, x, y, "Trainer", nil, "trainer", "high")
		N.Sample()
		r.bad = N.GetTarget().z == nil
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["withZ"], json!([1, -66, -66, -66]));
	assert_eq!(out["bad"], true, "only a number is a height");
}

#[test]
fn z2_a_search_with_the_height_that_fails_is_asked_once_more_without_it_and_that_answer_stands() {
	let out = run(&[
		Z_WAYPOINT,
		r#"
		local r = {}
		nav.place(0, 0)
		goal(-66)
		N.Sample()
		fake.fail("unreachable")
		r.retry = { calls(), fake.last().to.z == nil }
		fake.resolve(0, 0, 100, -300, 0, -600)
		r.used = aim()
		r.calls = calls()
		nav.place(-60, -200)
		stub.advance(3)
		aim()
		r.stray = { calls(), fake.last().to.z == nil }
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["retry"], json!([2, true]), "one more search, without z");
	assert_eq!(head(&out["used"], 2), json!(["travel", round(100f64.hypot(300.0) + 100f64.hypot(300.0))]), "its path is the arrow's");
	assert_eq!(out["calls"], 2);
	assert_eq!(out["stray"], json!([3, true]), "later searches for the same goal stay without the height");
}

#[test]
fn z2_a_failure_without_the_height_too_is_the_straight_arrow_with_no_third_search() {
	let out = run(&[
		Z_WAYPOINT,
		r#"
		nav.place(0, 0)
		goal(-66)
		N.Sample()
		fake.fail("unreachable")
		fake.fail("unreachable")
		emit({ aim(), calls() })"#,
	]
	.concat());
	assert_eq!(out, json!([["travel", 600, 0, -600], 2]));
}

#[test]
fn z2_a_path_searched_with_the_height_that_ends_more_than_30_yards_above_or_below_it_is_asked_again_without_it() {
	let out = run(&[
		Z_WAYPOINT,
		r#"
		local r = {}
		nav.place(0, 0)
		goal(-66)
		N.Sample()
		-- the last engine point before the goal stands on the street, 100 yd above
		answer({ 0, 0, 34 }, { 50, -300, 34 }, { 0, -590, 34 }, { 0, -600, -66 })
		r.retry = { calls(), fake.last().to.z == nil, aim()[3] }
		fake.resolve(0, 0, 100, -300, 0, -600)
		r.used = aim()
		goal(-50, 2)
		N.Sample()
		r.within = calls()
		answer({ 0, 0, 34 }, { 0, -590, -25 }, { 0, -600, -50 })
		r.close = { calls(), aim()[1] }
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["retry"], json!([2, true, 0]), "asked again without z; the off-floor path is not followed");
	heads(&out["used"], (0.0, 0.0), (100.0, -300.0), "the answer without z is the arrow's path");
	assert_eq!(out["within"], 3, "another goal with a height: searched with it");
	assert_eq!(out["close"], json!([3, "travel"]), "25 yards off is within 30: kept");
}

// Walks into the target priced by the walking engine (Walk.Measure, Travel.Remeasured).
// Three flight masters on Testshire, all known, both factions: Home Roost
// (900, 900) where the player stands, Ridge Roost (0, 300) and Road Roost
// (0, -700), each 1700 yards' flight from home. The target (0, 0) is 300 yd
// straight from Ridge Roost and 700 from Road Roost, so straight x1.25 the
// route lands at Ridge Roost; the engine finds Ridge Roost's walk crossing a
// ridge (2000 yd) and Road Roost's short (750 yd).
const TERRAIN: &str = r#"
local T = N.travel
N.RegisterTravelData({ build = "test",
	taxi = {
		{ 1, 0, 900, 900, 9000, 5, 5, 3, "Home Roost, Testshire" },
		{ 2, 0, 0, 300, 9000, 35, 50, 3, "Ridge Roost, Testshire" },
		{ 3, 0, 0, -700, 9000, 85, 50, 3, "Road Roost, Testshire" },
	},
	flights = { 1, 2, 1700, 2, 1, 1700, 1, 3, 1700, 3, 1, 1700 },
}, true)
Polestar.CharState().flags.taxi = { [1] = true, [2] = true, [3] = true }
local function at(x, y, ax, ay) return math.abs(x - ax) < 0.01 and math.abs(y - ay) < 0.01 end
-- The engine's walks into (0, 0): the ridge from Ridge Roost.
local function terrain(x, y)
	if at(x, y, 0, 300) then return 2000 end
	if at(x, y, 0, -700) then return 750 end
	return math.floor(math.sqrt(x * x + y * y) * 1.1)
end
-- The route: where it lands, and its last walk's yards, seconds and pricing.
local function route()
	local legs, ci = N.GetRoute()
	if not legs then return {} end
	local fly, walk
	for i = ci, #legs do
		if legs[i].kind == "fly" then fly = legs[i] end
		if legs[i].kind == "walk" then walk = legs[i] end
	end
	return { lands = fly and fly.to.name, yards = walk and walk.yards, seconds = walk and walk.seconds, engine = walk and walk.engine or false }
end
local changes = 0
Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
"#;

#[test]
fn terrain_one_reversed_findmany_from_the_target_prices_the_walks_into_it_the_route_then_lands_where_the_walk_is_short_once() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		nav.place(900, 900)
		target(0, 0)
		N.Sample()
		r.before = route()
		local many = fake.of(true)
		local job = many[1]
		local pts = {}
		for _, p in ipairs(job.targets) do pts[#pts + 1] = { floor(p.x + 0.5), floor(p.y + 0.5) } end
		r.batch = { n = #many, map = job.map, from = { floor(job.from.x + 0.5), floor(job.from.y + 0.5) }, reverse = job.reverse == true, water = job.waterWalking == true, targets = pts }
		local before = changes
		fake.settle(job, terrain)
		r.changes = changes - before
		r.after = route()
		-- Planned again (a zone change, a landing): the same measure, no new batch, the same way.
		T.Replan()
		r.again = route()
		r.batches = #fake.of(true)
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["before"], json!({ "lands": "Ridge Roost, Testshire", "yards": 375, "seconds": 54, "engine": false }), "straight x1.25 before the measure");
	assert_eq!(out["batch"]["n"], 1, "one batch for the target");
	assert_eq!(out["batch"]["map"], 0);
	assert_eq!(out["batch"]["from"], json!([0, 0]), "from the target");
	assert_eq!(out["batch"]["reverse"], true, "reversed: each cost is the walk from that place to the target");
	assert_eq!(out["batch"]["water"], false);
	let mut got = out["batch"]["targets"].as_array().unwrap().clone();
	got.sort_by_key(|v| v.to_string());
	let mut want = vec![json!([0, -700]), json!([0, 300]), json!([900, 900]), json!([900, 900])];
	want.sort_by_key(|v| v.to_string());
	assert_eq!(got, want, "the player and the three flight masters");
	assert_eq!(out["changes"], 1, "one replan once the measure lands");
	assert_eq!(out["after"], json!({ "lands": "Road Roost, Testshire", "yards": 750, "seconds": 107, "engine": "cost" }), "Road Roost: its measured walk, at 7 yd/s");
	assert_eq!(out["again"], out["after"], "later plans keep the measure: no flip-flop");
	assert_eq!(out["batches"], 1, "and ask for no second batch");
}

#[test]
fn terrain_a_measure_that_keeps_the_way_keeps_the_route_and_its_progress_its_later_walk_taking_the_measured_price_review_8() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		nav.place(900, 900)
		target(0, 0)
		N.Sample()
		local legs = N.GetRoute()
		local before = changes
		fake.settle(fake.of(true)[1], function(x, y) return math.floor(math.sqrt(x * x + y * y) * 1.1) end)
		local after = N.GetRoute()
		local r = route()
		emit({ same = legs == after, changes = changes - before, lands = r.lands, yards = r.yards, seconds = r.seconds, engine = r.engine })"#,
		]
		.concat(),
	);
	assert_eq!(
		out,
		json!({ "same": true, "changes": 1, "lands": "Ridge Roost, Testshire", "yards": 330, "seconds": 47, "engine": "cost" }),
		"the same legs, the last walk at its measure (300 x 1.1) instead of straight x1.25"
	);
}

#[test]
fn terrain_fallbacks_a_place_the_engine_finds_no_walk_from_or_none_found_at_all_keeps_the_straight_estimate() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		nav.place(900, 900)
		target(0, 0)
		N.Sample()
		-- Ridge Roost unreachable (a tower the engine cannot snap from): not left out, straight x1.25.
		fake.settle(fake.of(true)[1], function(x, y) if at(x, y, 0, 300) then return false end return terrain(x, y) end)
		r.one = route()
		-- Another target: nothing found from anywhere (the target snapped off the ground).
		target(0, 50)
		N.Sample()
		fake.settle(fake.of(true)[2], function() return false end)
		r.none = route()
		T.Replan()
		r.batches = #fake.of(true)
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["one"], json!({ "lands": "Ridge Roost, Testshire", "yards": 375, "seconds": 54, "engine": false }));
	assert_eq!(out["none"]["lands"], "Ridge Roost, Testshire");
	assert_eq!(out["none"]["engine"], false);
	assert_eq!(out["batches"], 2, "a target whose measure found nothing is not asked again");
}

#[test]
fn terrain_nothing_is_measured_in_combat_owed_until_it_ends_or_while_shortest_path_forever_guides() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		stub.inCombat = true
		nav.place(900, 900)
		target(0, 0)
		N.Sample()
		N.Refresh()
		r.fight = #fake.calls
		stub.inCombat = false
		N.Refresh()
		r.after = #fake.of(true)
		N.HandedOff = function() return true end
		target(0, 50)
		N.Sample()
		N.Refresh()
		r.handedOff = #fake.calls
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["fight"], 0, "no search at all in combat");
	assert_eq!(out["after"], 1, "the owed measure once combat ends");
	assert_eq!(out["handedOff"], 1, "nothing more while handed off");
}

#[test]
fn terrain_a_new_target_cancels_the_stale_measure_a_measured_target_is_kept_and_not_asked_again() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		nav.place(900, 900)
		target(0, 0)
		local first = fake.of(true)[1]
		target(0, -100)
		r.cancelled = first.cancelled == true
		local second = fake.of(true)[2]
		-- The stale batch's late answer is dropped.
		fake.settle(first, terrain)
		r.stale = route().engine
		fake.settle(second, function(x, y) return math.floor(math.sqrt(x * x + (y + 100) ^ 2) * 1.1) end)
		target(0, 0)
		r.back = #fake.of(true)
		fake.settle(fake.of(true)[3], terrain)
		r.first = route().lands
		target(0, -100)
		r.kept = #fake.of(true)
		r.second = route().engine
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["cancelled"], true);
	assert_eq!(out["stale"], false, "the old target's measure never prices the new one");
	assert_eq!(out["back"], 3, "the first target, never measured, is asked again");
	assert_eq!(out["first"], "Road Roost, Testshire");
	assert_eq!(out["kept"], 3, "the second target's measure is kept");
	assert_eq!(out["second"], "cost");
}

// A crossing world (as complete crossing data lays it out): West Vale and
// East Vale meet at a gate (600, 20) / (600, -20). The player stands 100 yd
// from Home Roost (900, 900) in West Vale; the target (600, -300) lies in
// East Vale. The route: walk to Home Roost, fly to Gate Roost (400, 300),
// walk to the gate, through it (hand-made), on to the target (hand-made:
// from a crossing end).
const CROSSING: &str = r#"
local T = N.travel
N.RegisterTravelData({ build = "test",
	taxi = {
		{ 1, 0, 900, 900, 9000, 5, 5, 3, "Home Roost, Testshire" },
		{ 2, 0, 400, 300, 9000, 35, 30, 3, "Gate Roost, Testshire" },
	},
	flights = { 1, 2, 600, 2, 1, 600 },
}, true)
N.RegisterCrossings({ complete = true,
	zones = {
		[9002] = { name = "West Vale", c = 0, top = 1000, bottom = -1000, left = 1000, right = 0 },
		[9003] = { name = "East Vale", c = 0, top = 1000, bottom = -1000, left = 0, right = -1000 },
	},
	crossings = { { id = "gate", a = { map = 9002, c = 0, wx = 600, wy = 20, r = 15 }, b = { map = 9003, c = 0, wx = 600, wy = -20, r = 15 },
		ab = "Through the gate to East Vale" } } })
Polestar.CharState().flags.taxi = { [1] = true, [2] = true }
local function legsNow()
	local legs, ci = N.GetRoute()
	local out = {}
	for i = ci, #legs do
		local l = legs[i]
		out[#out + 1] = { l.kind, l.handmade == true, l.yards, l.engine or false }
	end
	return out
end
local function lines()
	local out = {}
	for _, leg in ipairs(N.GetRouteGeometry().legs) do out[#out + 1] = { leg.kind, #leg.pts } end
	return out
end
"#;

#[test]
fn crossings_later_walks_are_searched_after_the_arrow_s_own_drawn_and_priced_by_their_path_the_walk_on_from_a_crossing_s_far_end_too_the_crossing_itself_is_searched_for_its_line_never_priced_by_it() {
	let out = run_many(
		&[
			CROSSING,
			r#"
		local r = {}
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		r.plan = legsNow()
		r.order = {}
		for _, job in ipairs(fake.calls) do r.order[#r.order + 1] = job.many and "many" or "find" end
		local batch = fake.of(true)[1]
		r.places = #batch.targets
		local own = fake.of(false)[1]
		fake.settle(batch, function(x, y) return math.floor(math.sqrt((x - 600) ^ 2 + (y + 300) ^ 2) * 1.1) end)
		r.waitOwn = #fake.of(false)
		fake.answer(own, 900, 800, 900, 900)
		local finds = fake.of(false)
		r.leg = { #finds, floor(finds[2].from.x), floor(finds[2].from.y), floor(finds[2].to.x), floor(finds[2].to.y) }
		r.straight = lines()
		fake.answer(finds[2], 400, 300, 500, 300, 600, 20)
		r.priced = legsNow()
		r.drawn = lines()
		finds = fake.of(false)
		r.cross = { #finds, floor(finds[3].from.x), floor(finds[3].from.y), floor(finds[3].to.x), floor(finds[3].to.y) }
		fake.answer(finds[3], 600, 20, 610, 0, 600, -20)
		finds = fake.of(false)
		r.onward = { #finds, floor(finds[4].from.x), floor(finds[4].from.y), floor(finds[4].to.x), floor(finds[4].to.y) }
		r.crossPriced = legsNow()[4]
		fake.answer(finds[4], 600, -20, 650, -150, 600, -300)
		r.final = legsNow()
		r.finalDrawn = lines()
		T.Replan()
		r.replanned = legsNow()
		r.cached = #fake.of(false)
		emit(r)"#,
		]
		.concat(),
	);
	let plan: Vec<Value> = out["plan"].as_array().unwrap().iter().map(|l| json!([l[0], l[1]])).collect();
	assert_eq!(
		json!(plan),
		json!([["walk", false], ["fly", false], ["walk", false], ["walk", true], ["walk", false]]),
		"to Home Roost, fly, to the gate, through it (hand-made), on to the target (the engine's)"
	);
	assert_eq!(out["order"], json!(["many", "find"]), "the measure, then the arrow's own walk to Home Roost");
	assert_eq!(out["places"], 5, "the player, both flight masters and both crossing ends");
	assert_eq!(out["waitOwn"], 1, "later walks wait for the arrow's own search");
	assert_eq!(out["leg"], json!([2, 400, 300, 600, 20]), "then Gate Roost to the gate is searched");
	assert_eq!(tail(&out["straight"], 2), json!([["walk", 2], ["walk", 2], ["walk", 2]]), "straight until its path is in");
	let path = 100.0 + 100f64.hypot(280.0);
	assert_eq!(out["priced"][2], json!(["walk", false, round(path), "path"]), "priced by its path");
	assert_eq!(out["drawn"][2], json!(["walk", 3]), "drawn along it");
	assert_eq!(out["cross"], json!([3, 600, 20, 600, -20]), "then the crossing, end to end, for its line");
	assert_eq!(out["onward"], json!([4, 600, -20, 600, -300]), "then the walk on from its far end");
	assert_eq!(out["crossPriced"], json!(["walk", true, 50, false]), "the crossing keeps its straight price");
	let onward = 50f64.hypot(130.0) + 50f64.hypot(150.0);
	assert_eq!(out["final"][4], json!(["walk", false, round(onward), "path"]), "the walk on is priced by its path");
	assert_eq!(tail(&out["finalDrawn"], 3), json!([["walk", 3], ["walk", 3]]), "and both are drawn along theirs");
	assert_eq!(out["replanned"][2], json!(["walk", false, round(path), "path"]), "a fresh plan takes the kept paths");
	assert_eq!(out["replanned"][4], json!(["walk", false, round(onward), "path"]), "the walk on too");
	assert_eq!(out["cached"], 4, "and searches nothing again");
}

#[test]
fn later_walks_a_search_whose_walk_leaves_the_route_is_cancelled_none_starts_in_combat() {
	let out = run_many(
		&[
			CROSSING,
			r#"
		local r = {}
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		fake.settle(fake.of(true)[1], function(x, y) return math.floor(math.sqrt((x - 600) ^ 2 + (y + 300) ^ 2) * 1.1) end)
		stub.inCombat = true
		fake.answer(fake.of(false)[1], 900, 800, 900, 900)
		N.Refresh()
		r.fight = #fake.of(false)
		stub.inCombat = false
		N.Refresh()
		r.after = #fake.of(false)
		local leg = fake.of(false)[2]
		target(0, 900)
		r.cancelled = leg.cancelled == true
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["fight"], 1, "no later walk is searched in combat");
	assert_eq!(out["after"], 2, "it is once combat ends");
	assert_eq!(out["cancelled"], true, "a new target drops it");
}

// Review of travel-terrain (2026-10-16): each fix with the test that fails without it.

#[test]
fn review_1_past_50_yd_from_where_it_was_measured_the_player_s_walk_is_never_priced_above_the_straight_distance_and_the_next_plan_measures_it_again() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		nav.place(0, 600)
		target(0, 0)
		N.Sample()
		fake.settle(fake.of(true)[1], function(x, y) return math.floor(math.sqrt(x * x + y * y) * 1.1) end)
		local cost = N.walk.Measured(0, 0, 0, false)
		r.here = cost(0, 0, 600, true)
		r.closer = cost(0, 0, 500, true)
		-- 360 yd sideways and closer: the measure less the yards moved (299) is under the straight 500.
		r.aside = cost(0, 300, 400, true)
		nav.place(300, 400)
		T.Replan()
		local again = fake.of(true)
		local pts = {}
		for _, p in ipairs(again[#again].targets) do pts[#pts + 1] = { floor(p.x + 0.5), floor(p.y + 0.5) } end
		r.batches, r.points = #again, pts
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["here"], 660);
	assert_eq!(out["closer"], 560, "the measure less the yards moved, while it beats straight");
	assert_eq!(out["aside"], 500, "never above the straight distance x1.0 (not straight x1.25)");
	assert_eq!(out["batches"], 2, "walked away: measured again with the next plan");
	assert!(out["points"].as_array().unwrap().iter().any(|p| p[0] == 300 && p[1] == 400), "from where the player now stands");
}

// Two gates between West Vale and East Vale: North Gate (600, +-20) and South
// Gate (-600, +-20). The player (0, 500) in West Vale, the target (100, -500)
// in East Vale: straight, the north gate is nearer; the engine finds the walk
// from the north gate's far end long (a ridge) and the south one's short.
const GATES: &str = r#"
local T = N.travel
N.RegisterTravelData({ build = "test" }, true)
N.RegisterCrossings({ complete = true,
	zones = {
		[9002] = { name = "West Vale", c = 0, top = 1000, bottom = -1000, left = 1000, right = 0 },
		[9003] = { name = "East Vale", c = 0, top = 1000, bottom = -1000, left = 0, right = -1000 },
	},
	crossings = {
		{ id = "north", a = { map = 9002, c = 0, wx = 600, wy = 20, r = 15 }, b = { map = 9003, c = 0, wx = 600, wy = -20, r = 15 } },
		{ id = "south", a = { map = 9002, c = 0, wx = -600, wy = 20, r = 15 }, b = { map = 9003, c = 0, wx = -600, wy = -20, r = 15 } },
	} })
local function crossing()
	local legs, ci = N.GetRoute()
	for i = ci, #legs do if legs[i].crossing then return legs[i].crossing end end
end
"#;

#[test]
fn review_2_a_measure_that_sends_the_route_through_another_crossing_replaces_it_not_the_same_way() {
	let out = run_many(
		&[
			GATES,
			r#"
		local r = {}
		nav.place(0, 500)
		target(100, -500)
		N.Sample()
		r.before = crossing()
		fake.settle(fake.of(true)[1], function(x, y)
			if math.abs(x - 600) < 1 and math.abs(y + 20) < 1 then return 2400 end
			return math.floor(math.sqrt((x - 100) ^ 2 + (y + 500) ^ 2) * 1.1)
		end)
		r.after = crossing()
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["before"], "north");
	assert_eq!(out["after"], "south", "the measured way goes through the south gate");
}

#[test]
fn review_3_the_last_walk_to_a_target_after_a_guide_goto_is_never_searched_drawn_or_priced_along_an_engine_path() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		local m, mx, my = nav.mapPoint(0, 280)   -- the mouth, a guide goto
		local _, ix, iy = nav.mapPoint(0, 0)     -- inside
		local guide = { steps = {
			{ goals = { { t = "goto", map = m, x = mx, y = my } } },
			{ goals = { { t = "collect", map = m, x = ix, y = iy } } },
		} }
		Polestar.Engine.GetGuide = function() return guide end
		nav.place(900, 800)
		nav.setWaypoint({ map = m, x = ix, y = iy, label = "Inside", stepIndex = 2, goalIndex = 1, kind = "collect", r = 5 })
		N.Sample()
		fake.settle(fake.of(true)[1], function(x, y) return math.floor(math.sqrt(x * x + y * y) * 1.1) end)
		fake.answer(fake.of(false)[1], 900, 800, 900, 900)
		local legs = N.GetRoute()
		local g = N.GetRouteGeometry().legs
		r.finds = #fake.of(false)
		r.last = { legs[#legs].kind, legs[#legs].engine or false, #g[#g].pts }
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["finds"], 1, "only the arrow's own walk is searched");
	assert_eq!(out["last"], json!(["walk", "cost", 2]), "priced by the measure, drawn straight from the mouth");
}

// A boat from Testshire Docks (-900, 0) to Farland Pier (c1: 400, 0); on Farland,
// Pier Roost (300, 0) flies to Far Roost (-400, 0); the target (-400, -300).
const BOAT: &str = r#"
local T = N.travel
N.RegisterTravelData({ build = "test",
	taxi = {
		{ 1, 1, 300, 0, 9001, 50, 20, 3, "Pier Roost, Farland" },
		{ 2, 1, -400, 0, 9001, 50, 90, 3, "Far Roost, Farland" },
	},
	flights = { 1, 2, 800, 2, 1, 800 },
	transports = {
		{ id = "boat-test", kind = "boat", faction = 3, ab = 60, ba = 60, waitA = 30, waitB = 30,
			a = { "Testshire Docks", 0, -900, 0, 9000, 50, 95 }, b = { "Farland Pier", 1, 400, 0, 9001, 50, 10 } },
	},
}, true)
Polestar.CharState().flags.taxi = { [1] = true, [2] = true }
local function kinds()
	local legs, ci = N.GetRoute()
	local out = {}
	for i = ci, #legs do out[#out + 1] = legs[i].kind end
	return table.concat(out, " ")
end
local function farland() N.SetTarget(9001, 80, 90, "Target") end
"#;

#[test]
fn review_4_after_route_advanced_off_the_boat_the_arrow_s_own_walk_is_searched_before_any_later_walk() {
	let out = run_many(
		&[
			BOAT,
			r#"
		local r = {}
		fake.avail[1] = false -- nothing searched on Farland until the boat lands
		nav.place(-900, 0)
		farland()
		N.Sample()
		r.aboard = { kinds(), #fake.calls }
		fake.avail[1] = true
		nav.place(400, 0, 1)
		N.Sample()
		local after = {}
		for _, job in ipairs(fake.calls) do after[#after + 1] = { floor(job.to.x + 0.5), floor(job.to.y + 0.5) } end
		r.first = after
		fake.answer(fake.of(false)[1], 400, 0, 300, 0)
		local leg = fake.of(false)[2]
		r.then_ = leg and { floor(leg.from.x + 0.5), floor(leg.to.x + 0.5), floor(leg.to.y + 0.5) }
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["aboard"], json!(["boat walk fly walk", 0]));
	assert_eq!(out["first"], json!([[300, 0]]), "the arrow's walk to Pier Roost first, alone");
	assert_eq!(out["then_"], json!([-400, -400, -300]), "then Far Roost to the target");
}

#[test]
fn a_walk_to_a_boat_whose_end_has_a_board_point_is_searched_to_the_deck_with_the_deck_s_height_a_later_walk_too() {
	let out = run_many(
		r#"
		N.RegisterTravelData({ build = "test",
			taxi = {
				{ 1, 1, 300, 0, 9001, 50, 20, 3, "Pier Roost, Farland" },
				{ 2, 1, -400, 0, 9001, 50, 90, 3, "Far Roost, Farland" },
			},
			flights = { 1, 2, 800, 2, 1, 800 },
			transports = {
				{ id = "boat-test", kind = "boat", faction = 3, ab = 60, ba = 60, waitA = 30, waitB = 30,
					a = { "Testshire Docks", 0, -900, 0, 9000, 50, 95, "e", nil, { wx = -890, wy = 10, z = 5.9 } },
					b = { "Farland Pier", 1, 400, 0, 9001, 50, 10, "e", nil, { wx = 410, wy = 5, z = 4.5 } } },
			},
		}, true)
		Polestar.CharState().flags.taxi = { [1] = true, [2] = true }
		local r = {}
		nav.place(-600, 0)
		N.SetTarget(9001, 80, 90, "Target")
		N.Sample()
		local job = fake.of(false)[1]
		r.arrow = { job and job.to.x, job and job.to.y, job and (job.to.z or "none") }
		-- On Farland at Far Roost: fly to Pier Roost, then the later walk to the pier's deck.
		fake.calls = {}
		nav.place(-400, -20, 1)
		N.SetTarget(9000, 60, 90, "Testshire")
		N.Sample()
		local legs, ci = N.GetRoute()
		local kinds = {}
		for i = ci, #legs do kinds[#kinds + 1] = legs[i].kind end
		r.kinds = table.concat(kinds, " ")
		fake.settle(fake.of(true)[1], function() return false end) -- measured: nothing found, straight as planned
		fake.answer(fake.of(false)[1], -400, -20, -400, 0)
		local later = fake.of(false)[2]
		r.later = { later and later.to.x, later and later.to.y, later and (later.to.z or "none") }
		emit(r)"#,
	);
	assert_eq!(out["arrow"], json!([-890, 10, 5.9]), "the deck, not the ship's stop in the water under it");
	assert!(is_match(out["kinds"].as_str().unwrap(), r"^walk fly walk boat"));
	assert_eq!(out["later"], json!([410, 5, 4.5]), "the later walk from the flight master to the deck");
}

#[test]
fn the_walk_off_a_boat_whose_end_has_a_board_point_is_searched_and_measured_from_the_deck_with_the_deck_s_height() {
	let out = run_many(
		r#"
		N.RegisterTravelData({ build = "test",
			taxi = {
				{ 1, 1, 300, 0, 9001, 50, 20, 3, "Pier Roost, Farland" },
				{ 2, 1, -400, 0, 9001, 50, 90, 3, "Far Roost, Farland" },
			},
			flights = { 1, 2, 800, 2, 1, 800 },
			transports = {
				{ id = "boat-test", kind = "boat", faction = 3, ab = 60, ba = 60, waitA = 30, waitB = 30,
					a = { "Testshire Docks", 0, -900, 0, 9000, 50, 95, "e", nil, { wx = -890, wy = 10, z = 5.9 } },
					b = { "Farland Pier", 1, 400, 0, 9001, 50, 10, "e", nil, { wx = 410, wy = 5, z = 4.5 } } },
			},
		}, true)
		Polestar.CharState().flags.taxi = { [1] = true, [2] = true }
		local r = {}
		nav.place(-600, 0)
		N.SetTarget(9001, 80, 90, "Target")
		N.Sample()
		local legs, ci = N.GetRoute()
		local kinds = {}
		for i = ci, #legs do kinds[#kinds + 1] = legs[i].kind end
		r.kinds = table.concat(kinds, " ")
		local batch = fake.of(true)[1]
		r.measured = "none"
		for _, p in ipairs(batch and batch.targets or {}) do
			if p.x == 410 and p.y == 5 then r.measured = p.z or "no z" end
		end
		fake.settle(batch, function() return false end)
		fake.answer(fake.of(false)[1], -600, 0, -890, 10)
		local later = fake.of(false)[2]
		r.later = later and { later.from.x, later.from.y, later.from.z or "none" }
		emit(r)"#,
	);
	assert!(is_match(out["kinds"].as_str().unwrap(), r"^walk boat walk"));
	assert_eq!(out["later"], json!([410, 5, 4.5]), "the walk off the boat starts on the far deck, at its height");
	assert_eq!(out["measured"], 4.5, "the measure into the target from the far deck carries its height");
}

#[test]
fn review_5_the_target_s_height_goes_with_the_measure_once_more_without_it_when_it_finds_nothing_and_with_the_last_walk_s_search() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		local m, x, y = nav.mapPoint(0, 0)
		nav.place(900, 800)
		nav.setWaypoint({ map = m, x = x, y = y, z = -40, label = "Below", stepIndex = 1, goalIndex = 1, kind = "turnin", r = 5 })
		N.Sample()
		local first = fake.of(true)[1]
		r.batchZ = first.from.z
		fake.settle(first, function() return false end)
		local second = fake.of(true)[2]
		r.retryZ = second and (second.from.z or "none")
		fake.settle(second, function(px, py) return math.floor(math.sqrt(px * px + py * py) * 1.1) end)
		fake.answer(fake.of(false)[1], 900, 800, 900, 900)
		local leg = fake.of(false)[2]
		r.legZ = leg.to.z
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["batchZ"], -40, "from the target at its height");
	assert_eq!(out["retryZ"], "none", "a batch with it that finds nothing: once more without it");
	assert_eq!(out["legZ"], -40, "the last walk is searched to the target's floor");
}

#[test]
fn review_6_a_target_inside_an_approach_chain_is_walked_from_its_mouth_by_the_chain_s_straight_link_never_priced_by_the_measure() {
	let out = run_many(
		r#"
		local T = N.travel
		N.RegisterTravelData({ build = "test" }, true)
		N.RegisterCrossings({ complete = true,
			zones = { [9002] = { name = "West Vale", c = 0, top = 1000, bottom = -1000, left = 1000, right = -1000 } },
			chains = { { id = "cave", name = "The Den", nodes = {
				{ map = 9002, c = 0, wx = 0, wy = 200, r = 10, caption = "Into the Den" },
				{ map = 9002, c = 0, wx = 0, wy = 0, r = 10 },
			} } } })
		nav.place(0, 900)
		target(0, 10)
		N.Sample()
		fake.settle(fake.of(true)[1], function() return 999 end)
		T.Replan() -- a fresh plan with the measure (the mouth's walk measured 999 yd)
		local legs = N.GetRoute()
		local last = legs[#legs]
		emit({ #legs, last.handmade == true, last.yards, last.engine or false })"#,
	);
	assert_eq!(out, json!([2, true, round(190.0 * 1.25), false]));
}

#[test]
fn review_7_a_later_walk_searched_alive_is_not_the_ghost_s_water_walking_its_path_is_kept_per_water_mode() {
	let out = run_many(
		&[
			CROSSING,
			r#"
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		fake.settle(fake.of(true)[1], function(x, y) return math.floor(math.sqrt((x - 600) ^ 2 + (y + 300) ^ 2) * 1.1) end)
		fake.answer(fake.of(false)[1], 900, 800, 900, 900)
		fake.answer(fake.of(false)[2], 400, 300, 500, 300, 600, 20)
		local from, to = { c = 0, wx = 400, wy = 300 }, { c = 0, wx = 600, wy = 20 }
		local alive = N.walk.LegPath(from, to)
		UnitIsGhost = function() return true end
		emit({ alive = alive and floor(alive + 0.5), ghost = N.walk.LegPath(from, to) or false })"#,
		]
		.concat(),
	);
	assert_eq!(out["alive"], round(100.0 + 100f64.hypot(280.0)));
	assert_eq!(out["ghost"], false);
}

#[test]
fn review_10_a_later_walk_priced_by_its_path_times_the_boat_after_it_again_by_the_timetable() {
	let out = run_many(
		r#"
		local T = N.travel
		N.RegisterTravelData({ build = "test",
			taxi = {
				{ 1, 0, 900, 900, 9000, 5, 5, 3, "Home Roost, Testshire" },
				{ 2, 0, -700, 0, 9000, 50, 85, 3, "Dock Roost, Testshire" },
			},
			flights = { 1, 2, 1700, 2, 1, 1700 },
			transports = {
				{ id = "boat-test", kind = "boat", faction = 3, ab = 60, ba = 60, waitA = 30, waitB = 30,
					a = { "Testshire Docks", 0, -900, 0, 9000, 50, 95 }, b = { "Farland Pier", 1, 400, 0, 9001, 50, 10 } },
			},
		}, true)
		Polestar.CharState().flags.taxi = { [1] = true, [2] = true }
		-- The boat leaves at 1000 s and sails 60 s.
		Polestar.Transit.Now = function() return 0 end
		Polestar.Transit.NextDeparture = function(kind, id, at) if kind == "boat" then return 1000 - at, 60 end end
		local function legsNow()
			local legs, ci = N.GetRoute()
			local out = {}
			for i = ci, #legs do out[#out + 1] = { legs[i].kind, legs[i].seconds } end
			return out
		end
		nav.place(900, 800)
		N.SetTarget(9001, 50, 50, "Farland")
		N.Sample()
		local before = legsNow()
		local batch = fake.of(true)[1]
		fake.settle(batch, function() return false end) -- Farland measured: nothing found, straight as planned
		fake.answer(fake.of(false)[1], 900, 800, 900, 900)
		-- Dock Roost to the docks: 400 yd along the path, 250 straight x1.25.
		fake.answer(fake.of(false)[2], -700, 0, -800, 100, -800, -100, -900, 0)
		emit({ before = before, after = legsNow() })"#,
	);
	let walk_before = num(&out["before"][2][1]);
	let walk_after = num(&out["after"][2][1]);
	assert_eq!(out["before"][2][0], "walk");
	assert!(walk_after > walk_before, "the walk to the docks along its path ({walk_after} s, straight {walk_before} s)");
	assert_eq!(out["after"][3][0], "boat");
	// Its leg times up to the boat's landing: the boat still leaves at 1000 s and lands at 1060.
	let landing = |legs: &Value| -> f64 { legs.as_array().unwrap().iter().take(4).map(|l| num(&l[1])).sum() };
	assert!((landing(&out["before"]) - 1060.0).abs() <= 2.0, "planned: lands at {} s", landing(&out["before"]));
	assert_eq!(landing(&out["after"]), 1060.0, "retimed: the wait shrinks by the longer walk");
}

#[test]
fn test_gap_a_measure_that_lands_on_a_boat_is_weighed_once_ashore() {
	let out = run_many(
		&[
			BOAT,
			r#"
		local r = {}
		local function farCost(x, y)
			if math.abs(x + 400) < 1 and math.abs(y) < 1 then return 2000 end
			return math.floor(math.sqrt((x + 400) ^ 2 + (y + 300) ^ 2) * 1.1)
		end
		-- The boat: boarded at the docks, the measure lands mid-sea.
		nav.place(-900, 0)
		farland()
		N.Sample()
		local legs = N.GetRoute()
		fake.settle(fake.of(true)[1], farCost)
		r.atSea = { N.GetRoute() == legs, kinds() }
		N.Refresh()
		r.stillAtSea = kinds()
		nav.place(400, 0, 1)
		N.Sample()
		N.Refresh()
		r.ashore = kinds()
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["atSea"], json!([true, "boat walk fly walk"]), "the route stays while sailing");
	assert_eq!(out["stillAtSea"], "boat walk fly walk", "and on a Refresh at sea");
	assert_eq!(out["ashore"], "walk", "ashore it is weighed: the walk from the pier beats Far Roost's ridge");
}

#[test]
fn test_gap_a_taxi_defers_the_measure_s_replan_to_the_landing() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		nav.place(900, 900)
		target(0, 0)
		N.Sample()
		local legs = N.GetRoute()
		nav.taxi = true
		N.Refresh()
		fake.settle(fake.of(true)[1], terrain)
		local inAir = { N.GetRoute() == legs, route().lands }
		nav.taxi = false
		N.Refresh()
		emit({ inAir = inAir, landed = route().lands })"#,
		]
		.concat(),
	);
	assert_eq!(out["inAir"], json!([true, "Ridge Roost, Testshire"]));
	assert_eq!(out["landed"], "Road Roost, Testshire");
}

#[test]
fn test_gap_handed_off_to_shortest_path_forever_refresh_cancels_the_measure_and_the_later_walk_in_flight() {
	let out = run_many(
		&[
			CROSSING,
			r#"
		local r = {}
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		local batch = fake.of(true)[1]
		N.HandedOff = function() return true end
		N.Refresh()
		r.measure = batch.cancelled == true
		N.HandedOff = function() return false end
		target(600, -301)
		N.Sample()
		fake.settle(fake.of(true)[2], function(x, y) return math.floor(math.sqrt((x - 600) ^ 2 + (y + 301) ^ 2) * 1.1) end)
		fake.answer(fake.of(false)[#fake.of(false)], 900, 800, 900, 900)
		local leg = fake.of(false)[#fake.of(false)]
		r.legFrom = { floor(leg.from.x), floor(leg.from.y) }
		N.HandedOff = function() return true end
		N.Refresh()
		r.leg = leg.cancelled == true
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["measure"], true);
	assert_eq!(out["legFrom"], json!([400, 300]), "the later walk was in flight");
	assert_eq!(out["leg"], true);
}

// Pathing v2 (docs/ARCHITECTURE.md, "In-game walking routes"): searches are
// priced for the player's faction; the router's cost chooses, its yards time
// (on format 2 maps a road walk costs less than its yards, a steep one more);
// hostile towns a walk enters are said; a later rule scales walk costs.

#[test]
fn profile_every_search_carries_the_player_s_faction_as_opts_profile_a_neutral_faction_sends_none_and_still_routes() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		nav.faction = "Horde"
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		local job = fake.of(false)[1]
		r.horde = { job.profile or false, type(job.opts), job.waterWalking == true }
		fake.resolve(0, 0, 100, -300, 0, -600)
		r.hordeAim = aim()[1]
		nav.faction = "Neutral"
		target(0, -300)
		N.Sample()
		job = fake.of(false)[#fake.of(false)]
		r.none = { job.profile or false, job.waterWalking == true }
		fake.resolve(0, 0, 50, -150, 0, -300)
		r.noneAim = aim()
		nav.faction = "Alliance"
		nav.place(900, 900)
		target(0, 0)
		N.Sample()
		local many = fake.of(true)
		r.batch = many[#many].profile or false
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["horde"], json!(["Horde", "table", false]), "the arrow's own walk: opts {{ waterWalking, profile }}");
	assert_eq!(out["hordeAim"], "travel");
	assert_eq!(out["none"], json!([false, false]), "neutral or unread: no profile");
	assert_eq!(head(&out["noneAim"], 2), json!(["travel", 316]), "and it routes");
	heads(&out["noneAim"], (0.0, 0.0), (50.0, -150.0), "along its path");
	assert_eq!(out["batch"], "Alliance", "the planner's measure too");
}

#[test]
fn cost_and_yards_the_measure_s_cost_picks_the_landing_its_yards_time_the_walk_a_road_walk_costs_less_than_its_yards() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		nav.place(900, 900)
		target(0, 0)
		N.Sample()
		-- Road Roost: 750 yd along a road, costing 600 (x0.8). Ridge Roost: 500 yd
		-- over rough ground, costing 650. Flights are alike: the cheaper walk wins.
		fake.settle(fake.of(true)[1], function(x, y)
			if at(x, y, 0, -700) then return 600, 750 end
			if at(x, y, 0, 300) then return 650, 500 end
			local d = math.sqrt(x * x + y * y)
			return math.floor(d * 1.3), math.floor(d)
		end)
		emit(route())"#,
		]
		.concat(),
	);
	assert_eq!(out, json!({ "lands": "Road Roost, Testshire", "yards": 750, "seconds": 107, "engine": "cost" }), "chosen by cost (600 < 650), shown and timed by its 750 yards at 7 yd/s");
}

#[test]
fn cost_and_yards_a_searched_walk_is_measured_by_the_path_s_yards_never_its_cost() {
	let out = run_many(
		&[
			CROSSING,
			r#"
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		fake.settle(fake.of(true)[1], function(x, y) return math.floor(math.sqrt((x - 600) ^ 2 + (y + 300) ^ 2) * 1.1) end)
		fake.answer(fake.of(false)[1], 900, 800, 900, 900)
		fake.answer(fake.of(false)[2], 400, 300, 500, 300, 600, 20)
		local legs, ci = N.GetRoute()
		emit({ legs[ci].yards, legs[ci].seconds, legs[ci + 2].yards, legs[ci + 2].seconds })"#,
		]
		.concat(),
	);
	let path = 100.0 + 100f64.hypot(280.0);
	assert_eq!(out, json!([100, 14, round(path), round(path / 7.0)]), "the engine's cost (100 for each) is not a distance");
}

#[test]
fn travel_walkcosthook_a_registered_rule_scales_a_walk_s_cost_never_its_time() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		nav.place(900, 900)
		target(0, 0)
		N.Sample()
		r.before = route()
		local seen = 0
		T.WalkCostHook(function(leg, cost)
			seen = seen + 1
			if at(leg.from.wx, leg.from.wy, 0, 300) and at(leg.to.wx, leg.to.wy, 0, 0) then return cost * 4 end
			return cost
		end)
		T.Replan()
		r.after = route()
		r.seen = seen > 0
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["before"], json!({ "lands": "Ridge Roost, Testshire", "yards": 375, "seconds": 54, "engine": false }));
	assert_eq!(
		out["after"],
		json!({ "lands": "Road Roost, Testshire", "yards": 875, "seconds": 125, "engine": false }),
		"the walk from Ridge Roost costs four times as much: the route lands at Road Roost, timed as before"
	);
	assert_eq!(out["seen"], true);
}

#[test]
fn hostile_towns_a_walk_whose_path_enters_one_carries_it_leg_hubs_the_arrow_says_hostile_town_name_once_when_the_walk_starts() {
	let out = run_many(
		&[
			CROSSING,
			r#"
		local r = {}
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		fake.settle(fake.of(true)[1], function(x, y) return math.floor(math.sqrt((x - 600) ^ 2 + (y + 300) ^ 2) * 1.1) end)
		fake.hubs = { { id = 12, name = "Southshore" } }
		fake.answer(fake.of(false)[1], 900, 800, 900, 900)
		fake.hubs = { { id = 13, name = "Tarren Mill" } }
		fake.answer(fake.of(false)[2], 400, 300, 500, 300, 600, 20)
		fake.hubs = nil
		local legs, ci = N.GetRoute()
		r.current = legs[ci].hubs and legs[ci].hubs[1].name or false
		r.later = legs[ci + 2].hubs and legs[ci + 2].hubs[1].name or false
		r.none = legs[ci + 1].hubs ~= nil
		stub.advance(0.3)
		r.said = N.arrow.labelText:GetText()
		stub.advance(15)
		r.after = N.arrow.labelText:GetText()
		T.Replan()
		stub.advance(0.3)
		r.again = N.arrow.labelText:GetText()
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["current"], "Southshore", "the arrow's own walk");
	assert_eq!(out["later"], "Tarren Mill", "a later walk, from its own search");
	assert_eq!(out["none"], false, "a flight has none");
	assert_eq!(out["said"], "Walk to the flight master\nHostile town: Southshore");
	assert_eq!(out["after"], "Walk to the flight master", "said once, then the step alone");
	assert_eq!(out["again"], "Walk to the flight master", "a fresh plan of the same walk does not say it again");
}

#[test]
fn hostile_towns_every_piece_of_a_split_walk_carries_them_so_the_step_after_a_chokepoint_still_says_so() {
	let out = run(&format!(
		"{}{}{}",
		r#"
		fake.hubs = { { id = 12, name = "Southshore" } }
		"#,
		split(),
		r#"
		fake.hubs = nil
		local T = N.travel
		local legs, ci = N.GetRoute()
		local first = T.HubText(legs[ci])
		nav.place(0, -160)
		N.Sample()
		legs, ci = N.GetRoute()
		emit({ first = first, ci = ci, after = T.HubText(legs[ci]) or false })"#
	));
	assert_eq!(out["first"], "Hostile town: Southshore");
	assert!(num(&out["ci"]) > 1.0, "past the bridge");
	assert_eq!(out["after"], "Hostile town: Southshore");
}

#[test]
fn hostile_towns_a_fresh_search_of_the_same_walk_with_the_same_towns_changes_nothing_no_route_changed() {
	let out = run_many(
		&[
			CROSSING,
			r#"
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		fake.settle(fake.of(true)[1], function(x, y) return math.floor(math.sqrt((x - 600) ^ 2 + (y + 300) ^ 2) * 1.1) end)
		fake.hubs = { { id = 12, name = "Southshore" } }
		fake.answer(fake.of(false)[1], 900, 800, 900, 900)
		local changes = 0
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		-- Stray, so the arrow searches again; back on the spot when the answer comes.
		nav.place(950, 850)
		N.Sample()
		stub.advance(3)
		N.Sample()
		local finds = fake.of(false)
		local again = finds[#finds]
		nav.place(900, 800)
		fake.hubs = { { id = 12, name = "Southshore" } } -- the same towns, a new table
		fake.answer(again, 900, 800, 900, 900)
		local legs, ci = N.GetRoute()
		emit({ searches = #finds, changes = changes, hubs = N.travel.HubText(legs[ci]) })"#,
		]
		.concat(),
	);
	assert!(num(&out["searches"]) >= 3.0, "searched again");
	assert_eq!(out["changes"], 0);
	assert_eq!(out["hubs"], "Hostile town: Southshore");
}

#[test]
fn hostile_towns_the_arrow_says_them_once_for_a_split_walk_not_again_at_each_step() {
	let out = run(&format!(
		"{}{}{}",
		r#"
		fake.hubs = { { id = 12, name = "Southshore" } }
		"#,
		split(),
		r#"
		fake.hubs = nil
		local function said() return (N.arrow.labelText:GetText() or ""):find("Hostile town", 1, true) ~= nil end
		stub.advance(0.3)
		local first = said()
		stub.advance(10)
		local quiet = said()
		nav.place(0, -160)
		N.Sample()
		stub.advance(0.3)
		local _, ci = N.GetRoute()
		emit({ first = first, quiet = quiet, ci = ci, again = said() })"#
	));
	assert_eq!(out["first"], true, "said as the walk starts");
	assert_eq!(out["quiet"], false);
	assert!(num(&out["ci"]) > 1.0, "past the bridge");
	assert_eq!(out["again"], false, "not said again at the next step");
}

#[test]
fn hostile_towns_a_walk_that_is_the_whole_route_a_target_inside_southshore_says_so_once_on_the_arrow_too() {
	let out = run(r#"
		local r = {}
		nav.place(0, 0)
		target(0, -600, "Quest in Southshore")
		N.Sample()
		fake.hubs = { { id = 12, name = "Southshore" } }
		fake.resolve(0, 0, 100, -100, 100, -500, 0, -600)
		fake.hubs = nil
		local legs = N.GetRoute()
		r.nlegs = legs and #legs or 0
		r.active = N.travel.Active()
		stub.advance(0.3)
		r.said = N.arrow.labelText:GetText()
		stub.advance(15)
		r.after = N.arrow.labelText:GetText()
		N.travel.Replan()
		stub.advance(0.3)
		r.again = N.arrow.labelText:GetText()
		emit(r)"#);
	assert_eq!(out["nlegs"], 1, "a lone walk");
	assert_eq!(out["active"], false, "no route to follow");
	assert_eq!(out["said"], "Quest in Southshore\nHostile town: Southshore");
	assert_eq!(out["after"], "Quest in Southshore", "said once, then the target alone");
	assert_eq!(out["again"], "Quest in Southshore", "a fresh plan of the same walk does not say it again");
}

#[test]
fn hostile_towns_two_towns_of_the_same_name_are_named_once() {
	let out = run(r#"
		local hubs = { { id = "a", name = "Goldshire" }, { id = "b", name = "Lakeshire" }, { id = "c", name = "Goldshire" } }
		emit(N.travel.HubText({ kind = "walk", hubs = hubs }))"#);
	assert_eq!(out, "Hostile town: Goldshire, Lakeshire");
}

#[test]
fn hostile_towns_each_is_named_in_the_client_s_language_by_its_area_compat_getareaname_else_by_the_packed_name_a_shown_name_once() {
	let out = run(r#"
		local de = { [271] = "S\195\188derstade", [272] = "Tarrens M\195\188hle" }
		Polestar.Compat.GetAreaName = function(id) return de[id] end
		local hubs = {
			{ id = "a", name = "Southshore", areaId = 271 },
			{ id = "b", name = "Hammerfall", areaId = 999 },
			{ id = "c", name = "Tarren Mill", areaId = 272 },
			{ id = "d", name = "Southshore copy", areaId = 271 },
			{ id = "e", name = "Hammerfall" },
		}
		emit(N.travel.HubText({ kind = "walk", hubs = hubs }))"#);
	assert_eq!(out, "Hostile town: S\u{fc}derstade, Hammerfall, Tarrens M\u{fc}hle");
}

// Route styles (nav.routeStyle): the saved style goes to every search as
// opts.style; Routing/Costs.lua (Polestar_Nav, loaded here beside the fake
// engine) reads anything but the three as Balanced.
const COSTS_TAIL: &str = r#"
chunk("Polestar_Nav", {})
local Costs = Polestar_NavCosts
local function styles(jobs)
	local out = {}
	for i, job in ipairs(jobs) do out[i] = { job.opts.style or false, Costs.Style(job.opts.style) } end
	return out
end
"#;

fn costs() -> String {
	let file = serde_json::to_string(&addons_dir().join("Polestar_Nav").join("Routing").join("Costs.lua")).unwrap();
	format!("\nlocal chunk = assert(loadfile({file})){COSTS_TAIL}")
}

#[test]
fn a_saved_route_style_that_is_none_of_the_three_walks_as_balanced_without_an_error() {
	let out = run_many(&format!(
		"{CROSSING}{}{}",
		costs(),
		r#"
		local r = {}
		Polestar.Set("nav.routeStyle", "Sideways")
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		fake.settle(fake.of(true)[1], function(x, y) return math.floor(math.sqrt((x - 600) ^ 2 + (y + 300) ^ 2) * 1.1) end)
		fake.answer(fake.of(false)[1], 900, 800, 900, 900)
		r.aim = aim()[1]
		fake.answer(fake.of(false)[2], 400, 300, 500, 300, 600, 20)
		r.drawn = lines()[3]
		r.styles = styles(fake.calls)
		emit(r)"#
	));
	assert_eq!(
		out["styles"],
		json!([["Sideways", "balanced"], ["Sideways", "balanced"], ["Sideways", "balanced"], ["Sideways", "balanced"]]),
		"the measure, the arrow's own walk, the later walk and the crossing's line carry the saved value, which the router reads as Balanced"
	);
	assert_eq!(out["aim"], "travel", "the arrow routes");
	assert_eq!(out["drawn"], json!(["walk", 3]), "and the later walk is drawn along its path");
}

#[test]
fn changing_the_route_style_mid_walk_drops_the_old_lines_re_plans_at_once_and_measures_and_searches_every_walk_again_in_the_new_style() {
	let out = run_many(&format!(
		"{CROSSING}{}{}",
		costs(),
		r#"
		local r = {}
		local changes = 0
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		local measure = function(x, y) return math.floor(math.sqrt((x - 600) ^ 2 + (y + 300) ^ 2) * 1.1) end
		fake.settle(fake.of(true)[1], measure)
		fake.answer(fake.of(false)[1], 900, 800, 880, 850, 900, 900)
		fake.answer(fake.of(false)[2], 400, 300, 500, 300, 600, 20)
		r.before = { lines = lines(), calls = #fake.calls }
		local seen, version = changes, T.version
		local calls = #fake.calls
		Polestar.Set("nav.routeStyle", "roads")
		r.replanned = { changed = changes > seen, version = T.version > version }
		r.lines = lines()
		N.Sample()
		-- [3]: the crossing's line, searched before the change (cancelled by it)
		local batch, own = fake.of(true)[2], fake.of(false)[4]
		r.asked = { #fake.calls - calls, batch and batch.opts.style, own and own.opts.style, own and floor(own.to.x), own and floor(own.to.y) }
		if batch then fake.settle(batch, measure) end
		if own then fake.answer(own, 900, 800, 880, 850, 900, 900) end
		local leg = fake.of(false)[5]
		r.leg = leg and { leg.opts.style, floor(leg.from.x), floor(leg.from.y), floor(leg.to.x), floor(leg.to.y) } or false
		r.straight = lines()[3]
		if leg then fake.answer(leg, 400, 300, 450, 250, 600, 20) end
		r.after = lines()
		local before = #fake.calls
		Polestar.Set("nav.routeStyle", "roads")
		r.same = #fake.calls - before
		emit(r)"#
	));
	assert_eq!(head(&out["before"]["lines"], 3), json!([["walk", 3], ["flight", 2], ["walk", 3]]), "Balanced: the arrow's walk and the later walk drawn along their paths");
	assert_eq!(out["replanned"], json!({ "changed": true, "version": true }), "re-planned at once");
	assert_eq!(head(&out["lines"], 3), json!([["walk", 2], ["flight", 2], ["walk", 2]]), "no Balanced line stays: straight until the Roads paths are in");
	assert_eq!(out["asked"], json!([2, "roads", "roads", 900, 900]), "the walks into the target measured again and the arrow's own walk searched again, in Roads");
	assert_eq!(out["leg"], json!(["roads", 400, 300, 600, 20]), "the later walk searched again, in Roads");
	assert_eq!(out["straight"], json!(["walk", 2]));
	assert_eq!(head(&out["after"], 3), json!([["walk", 3], ["flight", 2], ["walk", 3]]), "drawn along the Roads paths");
	assert_eq!(out["same"], 0, "setting the same style again searches nothing");
}

// Zone danger (Nav/Danger.lua, Nav/Walk.lua): the zones the router's maps
// carry (Path.ZoneAt, faked here by area: y >= 500 the player's and Home
// Roost's, y < 0 the target's, else a zone without levels) and their level
// ranges (Maps.GetZoneLevels, faked) at the player's level make the danger
// table every search carries: a zone whose lowest level is at least the
// player's + 4 costs x3, more than + 10 x20 (Ruling 35); the walk's own start and goal
// zones never count.
const DANGER: &str = r#"
local D = N.danger
nav.level = 20
Polestar.Compat.GetPlayerInfo = function() return { name = "Testchar", level = nav.level, faction = nav.faction } end
local zoneLevels = { [1422] = { 51, 57 }, [1421] = { 10, 19 }, [1424] = { 20, 33 }, [1416] = { 30, 39 } }
Polestar.Maps = Polestar.Maps or {}
Polestar.Maps.GetZoneLevels = function(id) local v = id and zoneLevels[id] if v then return v[1], v[2] end end
Polestar.Maps.EachZoneLevels = function()
	local id
	return function()
		local v
		id, v = next(zoneLevels, id)
		if id ~= nil then return id, v[1], v[2] end
	end
end
fake.zones = { home = 1421, target = 1424, between = 1497 }
Polestar_NavEngine.ZoneAt = function(map, x, y)
	if y >= 500 then return fake.zones.home elseif y < 0 then return fake.zones.target end
	return fake.zones.between
end
-- A search's danger table, "uiMap=mult,..." by uiMapID (false: none).
local function dz(job)
	local t = job and job.opts and job.opts.danger
	if type(t) ~= "table" then return false end
	local ids = {}
	for id, m in pairs(t) do ids[#ids + 1] = id .. "=" .. m end
	table.sort(ids)
	return table.concat(ids, ",")
end
local function sig(t, s)
	return { dz({ opts = { danger = t } }), s }
end
"#;

#[test]
fn zone_danger_x3_from_the_player_s_level_4_x20_above_10_a_zone_without_levels_or_no_level_is_never_dangerous() {
	let out = run_many(
		&[
			DANGER,
			r#"
		local r = {}
		zoneLevels = { [9001] = { 23, 30 }, [9002] = { 24, 30 }, [9003] = { 30, 40 }, [9004] = { 31, 40 } }
		r.mult = { D.Mult(20, 9001), D.Mult(20, 9002), D.Mult(20, 9003), D.Mult(20, 9004), D.Mult(20, 1497), D.Mult(20, nil), D.Mult(nil, 9004) }
		r.table = sig(D.Table(20, nil, nil))
		r.none = sig(D.Table(40, nil, nil))
		r.cached = D.Table(20, nil, nil) == D.Table(20, nil, nil)
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["mult"], json!([1, 3, 3, 20, 1, 1, 1]));
	assert_eq!(out["table"], json!(["9002=3,9003=3,9004=20", "9002=3,9003=3,9004=20"]), "every zone above 1, and its signature");
	assert_eq!(out["none"], json!([false, ""]), "none: nil, an empty signature");
	assert_eq!(out["cached"], true, "kept per level and zone pair");
}

#[test]
fn zone_danger_at_level_20_every_search_carries_the_zones_far_above_x20_and_dangerous_x3_minus_the_walk_s_own_start_and_goal_zones() {
	let out = run_many(
		&[
			CROSSING,
			DANGER,
			r#"
		local r = {}
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		local batch, own = fake.of(true)[1], fake.of(false)[1]
		r.batch, r.own = dz(batch), dz(own)
		fake.settle(batch, function(x, y) return math.floor(math.sqrt((x - 600) ^ 2 + (y + 300) ^ 2) * 1.1) end)
		fake.answer(own, 900, 800, 900, 900)
		local leg = fake.of(false)[2]
		r.leg = { dz(leg), floor(leg.from.x), floor(leg.from.y) }
		-- Review focus 1: a goal inside a dangerous zone is walked to; its zone does not count.
		fake.zones.target = 1416
		target(600, -250)
		N.Sample()
		local many = fake.of(true)
		r.inside = dz(many[#many])
		r.unit = {
			sig(D.Table(20, 1421, 1424)),
			sig(D.Table(20, 1422, 1421)),
			sig(D.Table(20, 1421, 1416)),
			sig(D.Table(20, 1422, 1416)),
			D.Mult(20, 1497),
		}
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["batch"], "1416=3,1422=20", "the measure into the target");
	assert_eq!(out["own"], "1416=3,1422=20", "the arrow's own walk");
	assert_eq!(out["leg"], json!(["1416=3,1422=20", 400, 300]), "a later walk, from a zone without levels");
	assert_eq!(out["inside"], "1422=20", "a target inside Alterac (dangerous) is measured without its own zone");
	assert_eq!(
		out["unit"],
		json!([["1416=3,1422=20", "1416=3,1422=20"], ["1416=3", "1416=3"], ["1422=20", "1422=20"], [false, ""], 1,]),
		"the start's and the goal's zones never count; a zone without levels is absent"
	);
}

#[test]
fn zone_danger_a_level_up_drops_the_walks_re_plans_at_once_and_measures_and_searches_every_walk_again_with_the_new_level_s_table() {
	let out = run_many(
		&[
			CROSSING,
			DANGER,
			r#"
		local r = {}
		local changes = 0
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		local measure = function(x, y) return math.floor(math.sqrt((x - 600) ^ 2 + (y + 300) ^ 2) * 1.1) end
		fake.settle(fake.of(true)[1], measure)
		fake.answer(fake.of(false)[1], 900, 800, 880, 850, 900, 900)
		fake.answer(fake.of(false)[2], 400, 300, 500, 300, 600, 20)
		r.before = { lines = lines(), danger = dz(fake.of(false)[2]) }
		local seen, version, calls = changes, T.version, #fake.calls
		-- PLAYER_LEVEL_UP's level stands while the client's still reads 20 (UnitLevel lags the event).
		stub.fire("PLAYER_LEVEL_UP", 27)
		r.replanned = { changed = changes > seen, version = T.version > version }
		r.lines = lines()
		N.Sample()
		-- [3]: the crossing's line, searched before the change (cancelled by it)
		local batch, own = fake.of(true)[2], fake.of(false)[4]
		r.asked = { #fake.calls - calls, dz(batch), dz(own), own and floor(own.to.x), own and floor(own.to.y) }
		if batch then fake.settle(batch, measure) end
		if own then fake.answer(own, 900, 800, 880, 850, 900, 900) end
		local leg = fake.of(false)[5]
		r.leg = leg and { dz(leg), floor(leg.from.x), floor(leg.from.y), floor(leg.to.x), floor(leg.to.y) } or false
		if leg then fake.answer(leg, 400, 300, 450, 250, 600, 20) end
		r.after = lines()
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(head(&out["before"]["lines"], 3), json!([["walk", 3], ["flight", 2], ["walk", 3]]), "at 20: the walks drawn along their paths");
	assert_eq!(out["before"]["danger"], "1416=3,1422=20");
	assert_eq!(out["replanned"], json!({ "changed": true, "version": true }), "re-planned at once");
	assert_eq!(head(&out["lines"], 3), json!([["walk", 2], ["flight", 2], ["walk", 2]]), "no line priced at 20 stays: straight until the new paths are in");
	assert_eq!(out["asked"], json!([2, "1422=20", "1422=20", 900, 900]), "the walks into the target measured again and the arrow's own walk searched again, at 27 (Alterac no longer dangerous)");
	assert_eq!(out["leg"], json!(["1422=20", 400, 300, 600, 20]), "the later walk searched again at 27");
	assert_eq!(head(&out["after"], 3), json!([["walk", 3], ["flight", 2], ["walk", 3]]), "drawn along the new paths");
}

// The planner's straight estimates (Nav/Danger.lua Danger.Along, Nav/Travel.lua):
// the zone every 100 yd along a straight walk (the middle of each 100 yd
// piece), its share in a dangerous zone x3, in a far-above one x20; the
// zones of its two ends never count, nor the player's and the target's.
#[test]
fn zone_danger_danger_along_samples_a_straight_line_every_100_yd_its_ends_zones_never_counting_without_a_table_path_zoneat_or_length_it_is_1() {
	let out = run_many(
		&[
			DANGER,
			r#"
		local r = {}
		-- West of x = 100 zone a, to x = 700 zone b, east of it zone c. Each
		-- layout is a new Path.ZoneAt: Danger keeps the zones it read per chunk
		-- for one Path.ZoneAt (the maps' zones never change).
		local asked = 0
		local function layout(zb)
			Polestar_NavEngine.ZoneAt = function(map, x, y)
				asked = asked + 1
				if x < 100 then return 1421 elseif x < 700 then return zb end
				return 1424
			end
		end
		layout(1422)
		local far = { [1422] = 20, [1416] = 3 }
		r.far = D.Along(far, 0, 0, 0, 1200, 0)
		r.asked = asked
		r.again = D.Along(far, 0, 0, 0, 1200, 0)
		r.askedAgain = asked
		layout(1416)
		r.dangerous = D.Along(far, 0, 0, 0, 1200, 0)
		layout(1422)
		r.endsNever = D.Along({ [1421] = 20, [1422] = 20, [1424] = 20 }, 0, 0, 0, 1200, 0)
		r.fromInside = D.Along(far, 0, 150, 0, 1350, 0)
		r.noTable = D.Along(nil, 0, 0, 0, 1200, 0)
		r.still = D.Along(far, 0, 300, 0, 300, 0)
		r.level = D.Level()
		stub.fire("PLAYER_LEVEL_UP", 23)
		r.levelUp = D.Level()
		Polestar_NavEngine.ZoneAt = nil
		r.noZoneAt = D.Along(far, 0, 0, 0, 1200, 0)
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["far"], 0.5 * 20.0 + 0.5, "half its 12 samples in a far-above zone");
	assert_eq!(out["dangerous"], 0.5 * 3.0 + 0.5, "half in a dangerous one");
	assert_eq!(out["endsNever"], 0.5 * 20.0 + 0.5, "the zones of its two ends never count");
	assert_eq!(json!([out["again"], out["asked"], out["askedAgain"]]), json!([10.5, 14, 14]), "its two ends and 12 samples asked once; the same line again asks nothing");
	assert_eq!(out["fromInside"], 1, "a line from inside the far-above zone: its own start zone");
	assert_eq!(out["noTable"], 1);
	assert_eq!(out["still"], 1, "no length");
	assert_eq!(out["noZoneAt"], 1, "no maps: today's estimate");
	assert_eq!(json!([out["level"], out["levelUp"]]), json!([20, 23]), "the level: the client's, or PLAYER_LEVEL_UP's when higher (one source for Walk and Travel)");
}

#[test]
fn zone_danger_the_planner_s_straight_walk_1200_yd_through_a_zone_far_above_costs_t_x_10_5_through_a_dangerous_one_t_x_2_timed_as_before_the_player_s_and_target_s_zones_never_count_without_path_zoneat_it_is_today_s(
) {
	let out = run_many(
		&[
			TERRAIN,
			DANGER,
			r#"
		local r = {}
		Polestar.CharState().flags.taxi = {}
		-- Along the walk from (0, 1200) to (0, 0): the start's zone from y = 1100,
		-- another to y = 500 (half the walk's 12 samples), the target's below.
		-- A new Path.ZoneAt per layout (Danger keeps the zones per chunk for one).
		local function layout(home, between, there)
			Polestar_NavEngine.ZoneAt = function(map, x, y)
				if y >= 1100 then return home elseif y > 500 then return between end
				return there
			end
		end
		local cost, secs
		T.WalkCostHook(function(w, c)
			if at(w.from.wx, w.from.wy, 0, 1200) and at(w.to.wx, w.to.wy, 0, 0) then cost, secs = c, w.seconds end
			return c
		end)
		nav.place(0, 1200)
		target(0, 0)
		N.Sample()
		local function ratio()
			cost, secs = nil, nil
			T.Replan()
			if not cost then return false end
			return { math.floor(cost / secs * 1000 + 0.5) / 1000, math.floor(secs * 1000 + 0.5) / 1000, route().seconds }
		end
		layout(1421, 1422, 1424)
		r.far = ratio()
		layout(1421, 1416, 1424)
		r.dangerous = ratio()
		layout(1421, 1497, 1424)
		r.none = ratio()
		layout(1422, 1422, 1416)
		r.ends = ratio()
		-- Routing turned off after the engine loaded (Nav.Path stays): today's estimate at once.
		layout(1421, 1422, 1424)
		Polestar.Set("nav.navRouting", false)
		r.routingOff = ratio()
		Polestar.Set("nav.navRouting", true)
		r.routingOn = ratio()
		Polestar_NavEngine.ZoneAt = nil
		r.noZoneAt = ratio()
		emit(r)"#,
		]
		.concat(),
	);
	let t = round(1200.0 * 1.25 / 7.0 * 1000.0) as f64 / 1000.0;
	assert_eq!(out["far"], json!([10.5, t, 214]), "t x (0.5 x 20 + 0.5), its time as before");
	assert_eq!(out["dangerous"], json!([2, t, 214]), "t x (0.5 x 3 + 0.5)");
	assert_eq!(out["none"], json!([1, t, 214]), "a zone without levels");
	assert_eq!(out["ends"], json!([1, t, 214]), "the player's and the target's zones never count");
	assert_eq!(out["noZoneAt"], json!([1, t, 214]), "no maps: today's estimate");
	assert_eq!(json!([out["routingOff"], out["routingOn"]]), json!([[1, t, 214], [10.5, t, 214]]), "routing off: today's estimate; on again: priced again");
}

#[test]
fn zone_danger_on_a_continent_with_crossing_data_the_straight_walk_from_a_flight_master_to_the_gate_takes_its_share_too() {
	let out = run_many(
		&[
			CROSSING,
			DANGER,
			r#"
		local r = {}
		local at = function(x, y, ax, ay) return math.abs(x - ax) < 0.01 and math.abs(y - ay) < 0.01 end
		-- A far-above band 450 < x < 550 north of y = 0: Gate Roost (400, 300) to
		-- the gate (600, 20) is 344 yd, its 4 samples at x 425, 475, 525, 575.
		Polestar_NavEngine.ZoneAt = function(map, x, y)
			if x > 450 and x < 550 and y > 0 then return 1422 end
			return 1497
		end
		local seen = {}
		T.WalkCostHook(function(w, c)
			if at(w.from.wx, w.from.wy, 400, 300) and at(w.to.wx, w.to.wy, 600, 20) then seen.gate = math.floor(c / w.seconds * 1000 + 0.5) / 1000 end
			if at(w.from.wx, w.from.wy, 900, 800) and at(w.to.wx, w.to.wy, 900, 900) then seen.home = math.floor(c / w.seconds * 1000 + 0.5) / 1000 end
			return c
		end)
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		r.gate, r.home = seen.gate or false, seen.home or false
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["gate"], (2.0 * 20.0 + 2.0) / 4.0, "half its samples in the band");
	assert_eq!(out["home"], 1, "the walk to Home Roost crosses none");
}

// The walking floor (#234, Ruling 36): Forever gives no player height, so
// Walk follows the surface under the player (Path.SurfacesAt, faked here by
// fake.surfaces) and starts the arrow's search, and the player's place in the
// planner's measure, from it. Testshire's ground is at 40; the overhang tests
// lay a rock top at 72 over x -10..10, y -40..-15.
const FLOORS: &str = r#"
-- The arrow searches player to target (the planner, which re-plans on its own time, is off).
if not KEEP_PLAN then Polestar.Set("nav.travel", false) end
-- Walk from the player's spot to (x1, y1) in 2 yd steps 0.3 s apart, the arrow sampling each.
local function walk(x1, y1)
	local p = nav.player
	local x0, y0, c = p.wx, p.wy, p.c
	local n = math.max(1, math.ceil(math.sqrt((x1 - x0) ^ 2 + (y1 - y0) ^ 2) / 2))
	for i = 1, n do
		nav.place(x0 + (x1 - x0) * i / n, y0 + (y1 - y0) * i / n, c)
		stub.advance(0.3)
		N.Sample()
	end
end
-- The height the next search starts from: a new target, asked from here ("none": no height).
local goals = 0
local function startZ()
	goals = goals + 1
	target(-500, 500 - goals * 10)
	N.Sample()
	local z = fake.last().from.z
	if z == nil then return "none" end
	return z
end
local function overhang(map, x, y)
	if x >= -10 and x <= 10 and y <= -15 and y >= -40 then return { 40, 72 } end
	return { 40 }
end
"#;

#[test]
fn t_234_floor_seeded_where_the_cell_has_one_surface_it_stays_on_the_ground_under_a_rock_top_a_first_cell_with_two_stays_unknown_today_s_search() {
	let out = run(&[
		FLOORS,
		r#"
		local r = {}
		fake.surfaces = overhang
		nav.place(0, 50)
		r.seed = startZ()
		walk(0, -25)
		r.under = startZ()
		-- Standing still nothing is read; moving, at most one read a 0.25 s.
		local reads = fake.reads
		for _ = 1, 10 do stub.advance(0.3) N.Sample() end
		r.still = fake.reads - reads
		reads = fake.reads
		for i = 1, 10 do nav.place(0, -25 - i * 0.2) stub.advance(0.02) N.Sample() end
		r.quick = fake.reads - reads
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["seed"], 40, "one surface: the floor is its height");
	assert_eq!(out["under"], 40, "under the rock top (40 and 72) the walk starts from the ground walked in on");
	assert_eq!(out["still"], 0, "standing still reads nothing");
	assert!(num(&out["quick"]) <= 1.0, "{} reads in 0.2 s", out["quick"]);
	let first = run(&[
		FLOORS,
		r#"
		fake.surfaces = overhang
		nav.place(0, -25)
		emit({ z = startZ() })"#,
	]
	.concat());
	assert_eq!(first["z"], "none", "first seen under the rock: unknown, searched without a height as today");
}

#[test]
fn t_234_floor_climbs_a_ramp_onto_a_bridge_falls_off_its_side_to_the_ground_and_stays_there_under_the_bridge() {
	let out = run(&[
		FLOORS,
		r#"
		local r = {}
		-- A ramp from y -20 (40) to y -60 (60), a bridge at 60 over the ground from y -60 to -100 for x -6..6.
		fake.surfaces = function(map, x, y)
			if y <= -20 and y > -60 and x >= -6 and x <= 6 then return { 40 + (-20 - y) / 2 } end
			if y <= -60 and y >= -100 and x >= -6 and x <= 6 then return { 40, 60 } end
			return { 40 }
		end
		nav.place(0, 0)
		r.seed = startZ()
		walk(0, -80)
		r.bridge = startZ()
		walk(20, -80)
		r.fell = startZ()
		walk(0, -80)
		r.under = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out, json!({ "seed": 40, "bridge": 60, "fell": 40, "under": 40 }));
}

#[test]
fn t_234_floor_a_jump_of_30_yd_another_continent_or_a_stale_floor_no_reading_for_2_s_while_moving_is_unknown_again() {
	let out = run(&[
		FLOORS,
		r#"
		local r = {}
		fake.surfaces = overhang
		nav.place(0, 50)
		startZ()
		walk(0, -12)
		r.edge = startZ()
		nav.place(0, 50)
		stub.advance(0.3)
		N.Sample()
		nav.place(0, -25)
		r.jump = startZ()
		nav.place(0, 50)
		startZ()
		walk(0, -12)
		nav.place(0, -13, 1)
		N.SetTarget(9001, 50, 50, "Farland")
		N.Sample()
		nav.place(0, -15, 0)
		r.continent = startZ()
		nav.place(0, 50)
		startZ()
		walk(0, -12)
		-- In an instance the arrow samples nothing: 3 s later, 8 yd on.
		nav.instance = true
		nav.place(0, -20)
		stub.advance(3)
		nav.instance = false
		r.stale = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out, json!({ "edge": 40, "jump": "none", "continent": "none", "stale": "none" }));
}

#[test]
fn t_234_floor_a_search_with_the_tracked_height_that_finds_nothing_is_asked_once_more_without_it_and_that_answer_stands() {
	let out = run(&[
		FLOORS,
		r#"
		local r = {}
		fake.surfaces = overhang
		nav.place(0, 50)
		r.z = startZ()
		local n = calls()
		fake.fail("unreachable")
		r.retry = { calls() - n, fake.last().from.z == nil }
		fake.resolve(0, 50, -500, 490)
		r.aim = aim()[1]
		r.calls = calls() - n
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["z"], 40);
	assert_eq!(out["retry"], json!([1, true]), "once more, without the height");
	assert_eq!(out["aim"], "travel");
	assert_eq!(out["calls"], 1, "no third search");
}

#[test]
fn t_234_floor_the_planner_s_measure_takes_the_player_s_place_at_the_tracked_floor() {
	let out = run_many(
		&[
			"KEEP_PLAN = true\n",
			TERRAIN,
			FLOORS,
			r#"
		fake.surfaces = function() return { 40 } end
		nav.place(900, 900)
		-- A walk first (the arrow reads the floor), then the target the planner measures.
		target(900, 850)
		N.Sample()
		target(0, 0)
		N.Sample()
		local many = fake.of(true)
		local job = many[#many]
		-- The player's place (Home Roost's flight master stands there too, without a height).
		local z = "missing"
		for _, p in ipairs(job.targets) do
			if math.abs(p.x - 900) < 0.01 and math.abs(p.y - 900) < 0.01 and (z == "missing" or p.z) then z = p.z or "none" end
		end
		emit({ z = z })"#,
		]
		.concat(),
	);
	assert_eq!(out["z"], 40);
}

#[test]
fn t_234_floor_a_lift_resets_it_off_the_lift_indoors_it_seeds_on_the_one_indoor_surface_the_undercity_under_tirisfal_s_ground_never_overriding_a_followed_floor() {
	let out = run(&[
		FLOORS,
		r#"
		local r = {}
		-- A lift at (0, 0): the shaft holds the top (62, indoor) and the bottom (-41, indoor); the city
		-- (-62, indoor) runs under Tirisfal's outdoor ground (64) for y < -20, and the city past y -40
		-- under a second indoor level (6) as well.
		local lift = Polestar.Transit.LiftNear
		Polestar.Transit.LiftNear = function(c, x, y, yards)
			if x * x + y * y <= (yards or 8) ^ 2 then return "lift-test", "Test lift" end
		end
		fake.surfaces = function(map, x, y)
			if y > -12 then return { 62, -41, [-1] = 2, [-2] = 2 } end
			if y > -20 then return { 64, -41, [-2] = 2 } end
			if y > -40 then return { 64, -62, [-2] = 2 } end
			return { 64, -62, 6, [-2] = 2, [-3] = 2 }
		end
		nav.indoors = true
		nav.place(0, 30)
		r.top = startZ()
		walk(0, 0)
		r.lift = startZ()
		walk(0, -30)
		r.city = startZ()
		walk(0, -60)
		r.followed = startZ()
		-- Outdoors at the doorway for a moment: a followed floor stays.
		nav.indoors = false
		walk(0, -64)
		r.doorway = startZ()
		-- Without the client's indoor state, or with two indoor levels apart, it stays unknown.
		nav.indoors = nil
		nav.place(0, -30)
		stub.advance(3)
		r.unread = startZ()
		nav.indoors = true
		nav.place(0, -60)
		stub.advance(3)
		r.two = startZ()
		Polestar.Transit.LiftNear = lift
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["top"], "none", "the shaft's two landings: unknown");
	assert_eq!(out["lift"], "none", "at the lift: unknown");
	assert_eq!(out["city"], -62, "off the lift, indoors: the one indoor surface under the outdoor ground");
	assert_eq!(out["followed"], -62, "followed past a second indoor level");
	assert_eq!(out["doorway"], -62, "the indoor state never overrides a followed floor");
	assert_eq!(out["unread"], "none");
	assert_eq!(out["two"], "none", "two indoor surfaces apart: unknown");
}

#[test]
fn t_234_floor_while_its_cluster_is_decoding_path_surfacesat_nil_the_floor_is_kept_where_it_was_read_used_within_5_yd_of_there_lost_past_30_yd_and_followed_again_once_the_cluster_is_in_an_error_is_unknown(
) {
	let out = run(&[
		FLOORS,
		r#"
		local r = {}
		fake.surfaces = overhang
		nav.place(0, 50)
		r.seed = startZ()
		fake.undecoded = true
		walk(0, 47)
		r.near = startZ()
		walk(0, 30)
		r.far = startZ()
		fake.undecoded = false
		walk(0, -25)
		r.under = startZ()
		-- Reseeded at (0, 50), then 36 yd walked with the cluster still decoding: lost, so under the rock it is unknown.
		nav.place(0, 50)
		stub.advance(3)
		startZ()
		fake.undecoded = true
		walk(0, 14)
		fake.undecoded = false
		nav.place(0, -20)
		stub.advance(0.3) N.Sample()
		r.lost = startZ()
		nav.place(0, 50)
		stub.advance(3)
		startZ()
		fake.surfacesError = true
		walk(0, 45)
		r.error = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out, json!({ "seed": 40, "near": 40, "far": "none", "under": 40, "lost": "none", "error": "none" }));
}

#[test]
fn t_234_floor_a_goal_s_height_off_its_floor_is_dropped_keeping_the_tracked_start_a_tracked_start_that_finds_nothing_is_dropped_keeping_the_goal_s_height() {
	let out = run(&[
		FLOORS,
		r#"
		local r = {}
		fake.surfaces = function() return { 40 } end
		nav.place(0, 50)
		startZ()
		local m, x, y = nav.mapPoint(-500, 500)
		local function ask()
			local j = fake.last()
			return { j.from.z or "none", j.to.z or "none" }
		end
		N.SetTarget(m, x, y, "Trainer", nil, "trainer", -66)
		N.Sample()
		r.first = ask()
		-- Found, but its last engine point stands 100 yd above the goal.
		local job, pts = fake.last(), {}
		for i, p in ipairs({ { 0, 50, 40 }, { -400, 450, 34 }, { -500, 500, -66 } }) do pts[i] = { map = job.map, x = p[1], y = p[2], z = p[3] } end
		job.callback(pts, 100, job)
		r.offFloor = ask()
		N.SetTarget(m, x, y, "Trainer 2", nil, "trainer", -60)
		N.Sample()
		fake.fail("unreachable")
		r.startFailed = ask()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["first"], json!([40, -66]));
	assert_eq!(out["offFloor"], json!([40, "none"]), "off the goal's floor: the goal's height goes, the tracked start stays");
	assert_eq!(out["startFailed"], json!(["none", -60]), "nothing found: the tracked start goes, the goal's height stays");
}

// Fitz in the Undercity (2026-10-23): its cells hold the canal, the ring's walkway and the entrance hall stacked, and
// walking tells them apart only where one ends. Each indoor surface of a map with areas carries its WMO group's
// AreaTable id, and the client's subzone names the level the player is on ("Canals", "The Trade Quarter", the hall's
// "Ruins of Lordaeron"): that surface is the floor at once, and it overrides a floor followed onto the wrong level.
#[test]
fn t_234_floor_on_a_map_with_areas_the_floor_is_the_surface_the_client_s_subzone_names_at_once_it_corrects_a_wrong_followed_floor() {
	let out = run(&[
		FLOORS,
		r#"
		nav.indoors = true
		SUB = ""
		Polestar.Compat.GetZoneText = function() return "Undercity", SUB ~= "" and SUB or nil end -- the names come from the pack (Path.AreaName)
		local stack = function() return { 62, -45, -62, [-1] = 2, [-2] = 2, [-3] = 2, area = { 153, 1600, 1601 } } end -- WMOAreaTable rows
		fake.surfaces = stack
		local r = {}
		local function fresh(sub)
			SUB = sub
			nav.place(0, 300)
			stub.advance(3)
			N.Sample()
			nav.place(0, 50)
			stub.advance(0.3)
			N.Sample()
			return startZ()
		end
		r.noAreas = fresh("Ruins of Lordaeron")
		Polestar.Compat.GetAreaName = function() return "An AreaTable name" end -- never asked: the ids are WMOAreaTable rows
		fake.areaNames = { [153] = "Ruins of Lordaeron", [1600] = "The Trade Quarter", [1601] = "Canals" }
		r.hall = fresh("Ruins of Lordaeron")
		r.ring = fresh("The Trade Quarter")
		r.canal = fresh("Canals")
		r.none = fresh("")
		fake.surfaces = function() return { 62, -45, -62, [-1] = 2, [-2] = 2, [-3] = 2, area = { 153, 1600, 1600 } } end
		r.shared = fresh("The Trade Quarter")
		local fl = N.walk.Floors(0, 0, 50)
		table.sort(fl)
		r.sharedFloors = fl
		-- Followed onto the hall's level by mistake (one surface there, the hall's), then back over the stack in the ring.
		fake.surfaces = function(map, x, y) if y > 40 and y < 60 then return { 62, [-1] = 2, area = { 153 } } end return stack() end
		SUB = "The Trade Quarter"
		r.wrong = fresh("Ruins of Lordaeron")
		SUB = "The Trade Quarter"
		walk(0, 30)
		r.corrected = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["noAreas"], "none", "a map without areas: the stack is ambiguous, unknown (movement decides)");
	assert_eq!(out["hall"], 62);
	assert_eq!(out["ring"], -45);
	assert_eq!(out["canal"], -62);
	assert_eq!(out["none"], "none", "no subzone: unknown");
	assert_eq!(out["shared"], "none", "the subzone names two levels: unknown");
	assert_eq!(out["sharedFloors"], json!([-62, -45]), "but the floors the player may be on are those two (Walk.Floors), never the hall");
	assert_eq!(out["wrong"], 62);
	assert_eq!(out["corrected"], -45, "the subzone names the ring: the floor followed on the hall's level is corrected");
}

#[test]
fn t_234_floor_the_router_may_drop_the_floor_s_cluster_when_the_target_is_cleared_or_the_arrow_has_not_updated_for_2_s() {
	let out = run(&[
		FLOORS,
		r#"
		local r = {}
		fake.surfaces = function() return { 40 } end
		nav.place(0, 50)
		startZ()
		fake.releases = 0
		-- In an instance the arrow samples nothing (no Walk.Aim); the 1 s ticker refreshes.
		nav.instance = true
		stub.advance(1.5)
		Polestar.Nav.Refresh()
		r.fresh = fake.releases
		stub.advance(1.6)
		Polestar.Nav.Refresh()
		r.stale = fake.releases
		nav.instance = false
		N.Sample()
		N.ClearTarget()
		r.cleared = fake.releases
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["fresh"], 0, "within 2 s of the arrow's last update: kept");
	assert_eq!(out["stale"], 1, "past 2 s: released once");
	assert!(num(&out["cleared"]) >= 2.0, "the target cleared: released");
}

#[test]
fn t_234_floor_a_style_change_or_a_level_up_clears_the_walk_but_keeps_the_floor_s_cluster_the_arrow_goes_on() {
	let out = run(&[
		FLOORS,
		r#"
		fake.surfaces = function() return { 40 } end
		nav.place(0, 50)
		startZ()
		fake.releases = 0
		Polestar.Set("nav.routeStyle", "roads")
		N.Sample()
		stub.fire("PLAYER_LEVEL_UP", 11)
		N.Sample()
		emit({ releases = fake.releases, z = startZ() })"#,
	]
	.concat());
	assert_eq!(out, json!({ "releases": 0, "z": 40 }));
}

#[test]
fn t_234_floor_ruling_36b_a_search_sent_without_a_height_then_the_floor_found_within_5_s_is_asked_once_more_with_it_once() {
	let out = run(&[
		FLOORS,
		r#"
		local r = {}
		fake.surfaces = function() return { 40 } end
		-- Arrived: the cluster still decoding when the target is set.
		fake.undecoded = true
		nav.place(0, 50)
		r.first = startZ()
		local n = calls()
		fake.undecoded = false
		for _ = 1, 10 do stub.advance(0.3) N.Sample() end
		r.reasked = { calls() - n, fake.last().from.z or "none" }
		walk(0, 30)
		r.after = calls() - n
		-- Past 5 s the floor found asks nothing.
		fake.undecoded = true
		nav.place(400, 400)
		r.late = startZ()
		n = calls()
		stub.advance(6) N.Sample()
		fake.undecoded = false
		for _ = 1, 10 do stub.advance(0.3) N.Sample() end
		r.lateCalls = calls() - n
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["first"], "none", "searched at once, without a height");
	assert_eq!(out["reasked"], json!([1, 40]), "once more, from the floor");
	assert_eq!(out["after"], 1, "and not again");
	assert_eq!(out["late"], "none");
	assert_eq!(out["lateCalls"], 0, "a floor found more than 5 s after the search asks nothing");
}

// Arrow body (POINT_REACH=20, PAD=12, AHEAD=45): the player has a 20 yd body
// so path points within it are always treated as passed; the wider look-ahead
// corridor keeps the arrow from going sideways on an offset path; a switchback
// with legs 15 yd apart keeps the arrow on the near leg, not cutting across.

#[test]
fn a1_arrow_aims_forward_when_12_yd_off_path_wider_pad_12_corridor_vs_old_pad_10() {
	// Player at (8,13); path (0,0)→(10,0)→(30,0)→(60,0).
	// Old PAD=10: lateral deviation of (10,0) from player→(30,0) line ≈10.2 yd > 10
	//   → look-ahead pins aim at (10,0) — sideways (aim_x=10).
	// New PAD=12: 10.2 yd < 12 → look-ahead spans to (30,0) — forward (aim_x≥20).
	let out = run(r#"
		local r = {}
		nav.place(8, 13)
		target(60, 0)
		aim()
		fake.resolve(0,0, 10,0, 30,0, 60,0)
		r.aim = aim()
		emit(r)"#);
	assert_eq!(out["aim"][0], "travel");
	assert!(num(&out["aim"][2]) >= 20.0, "aim_x {} should be ≥20 (forward), not stuck at 10", out["aim"][2]);
}

#[test]
fn a2_player_12_yd_off_a_straight_path_arrow_within_30_of_forward_with_wider_look_ahead() {
	// Player at (50,12); path points every 10 yd from (0,0) to (100,0).
	// Old AHEAD=30: budget exhausted after 1-2 points → aim ≈(55,0), ~67° off east.
	// New AHEAD=45: look-ahead reaches (85,0) → ≈18° off east.
	let out = run(r#"
		local r = {}
		nav.place(50, 12)
		target(100, 0)
		aim()
		fake.resolve(0,0, 10,0, 20,0, 30,0, 40,0, 50,0, 60,0, 70,0, 80,0, 90,0, 100,0)
		r.aim = aim()
		emit(r)"#);
	assert_eq!(out["aim"][0], "travel");
	assert!(num(&out["aim"][2]) >= 70.0, "aim_x {} should be ≥70 (≤30° off east from x=50), not stuck near 55", out["aim"][2]);
}

#[test]
fn a4_switchback_with_legs_15_yd_apart_pad_12_keeps_the_arrow_on_the_near_leg() {
	// Player at (70,0) near end of leg1 (x=0..100,y=0); leg2 is at y=-15.
	// With PAD=20 the corridor would span to y=-15 and aim toward leg2 (cutting the
	// switchback). With PAD=12 the across check fails (≈13.4 yd > 12) and aim stays
	// on leg1 (y=0 or very close).
	let out = run(r#"
		local r = {}
		nav.place(70, 0)
		target(0, -15)
		aim()
		-- leg1: x=0..100 y=0 (points every 10 yd); turn (100,-15); leg2: x=100..0 y=-15
		fake.resolve(
			0,0, 10,0, 20,0, 30,0, 40,0, 50,0, 60,0, 70,0, 80,0, 90,0, 100,0,
			100,-15, 90,-15, 80,-15, 70,-15, 60,-15, 50,-15, 40,-15, 30,-15, 20,-15, 10,-15, 0,-15)
		r.aim = aim()
		emit(r)"#);
	assert_eq!(out["aim"][0], "travel");
	assert!(num(&out["aim"][3]) >= -12.0, "aim_y {} should be ≥-12 (near leg1 at y=0, not cut to leg2 at y=-15)", out["aim"][3]);
}
