//! Walking paths (addon/Polestar/Nav/Walk.lua): the arrow follows the walking router started from Shortest Path
//! Forever's (addon/Polestar_Nav) instead of a straight line. A fake engine with deterministic callbacks stands
//! in for Polestar_NavEngine: the arrow follows the path's points, straying asks again, a new target cancels
//! the stale search, nothing is searched in combat, and hand-made crossings and guide `goto`s win.
//! A missing or pending walking route has no bearing; opting out keeps the direct compass. Runs the
//! real Core/Init.lua + Nav/Nav.xml against tests/lua/stub_nav.lua.

use forge_addontest::names::language_pack;
use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, is_match, lua_string, truthy, Addon, RunAddon};
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
	-- The walking grid's line check (Path.Sight): fake.sight(x1, y1, z1, x2, y2, z2, profile) -> true | false; nil
	-- without it (no line known: the corridor as before). fake.sights counts the checks.
	Sight = function(map, x1, y1, z1, x2, y2, z2, profile)
		fake.sights = (fake.sights or 0) + 1
		if fake.sight then return fake.sight(x1, y1, z1, x2, y2, z2, profile) end
		return nil
	end,
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
	job.yards, job.hubs, job.avoided = length(points), fake.hubs or {}, fake.avoided or {}
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
Polestar_NavEngine.FindMany = function(map, from, targets, callback, o, reverse, progress)
	local job = { many = true, map = map, from = from, targets = targets, callback = callback, reverse = reverse, progress = progress }
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
		-- This fixture's walks are polylines with one segment. An uncredited
		-- answer remains usable for neither faction, even if it carries a cost.
		if c and not job.unchecked then
			local o = job.opts
			if Polestar.Nav.danger.Blocked(job.map, job.from.x, job.from.y, p.x, p.y, o.profile, o.walkLevel) then
				c, y = false, false
			else
				job.walkChecked = true
			end
		end
		costs[i] = c
		if y == nil then y = c end
		yards[i] = y
	end
	job.yards = yards
	job.callback(costs, nil, job)
end
-- Answer one Path.Find with the path x1, y1, x2, y2, ...
function fake.answer(job, ...) fake.answerXY(job, { ... }) end
-- Inspect the live request, not the nth Find: while a ticket is withheld the
-- arrow can have a separate, short-lived request directly to the target.
function fake.walk(sx, sy, tx, ty)
	local j = assert(fake.last(), "no walking request")
	assert(not (j.many or j.cancelled or j.answered) and j.map == 0
		and math.abs(j.from.x - sx) < .01 and math.abs(j.from.y - sy) < .01
		and math.abs(j.to.x - tx) < .01 and math.abs(j.to.y - ty) < .01, "unexpected walking request")
	return j
end
function fake.answerWalk(...)
	local xy = { ... }
	local j = fake.walk(xy[1], xy[2], xy[#xy - 1], xy[#xy])
	assert(j.from.z == nil and j.to.z == nil, "this fixture supplies no floor evidence")
	for i = 3, #xy, 2 do
		assert(not Polestar.Nav.danger.Blocked(j.map, xy[i - 2], xy[i - 1], xy[i], xy[i + 1], j.profile), "blocked test segment")
	end
	j.answered = true
	fake.answerXY(j, xy)
end
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

// Control when a job completes, but ask the actual router for its answer. These
// isolated tiles have known floors and no inter-tile links. Missing ground,
// including a different deck at the same XY, is not a successful transfer.
const PRICED: &str = r#"
local solver = Polestar_NavEngine
N.Path = fake.pending
local frames = {}
solver.after = function(fn) frames[#frames + 1] = fn end
local function finish(j)
	local result
	local function done(value, reason, answer)
		result = { value = value, reason = reason, job = answer }
		j.callback(value, reason, answer)
	end
	if j.many then solver.FindMany(j.map, j.from, j.targets, done, j.opts, j.reverse)
	else solver.Find(j.map, j.from, j.to, done, j.opts) end
	while #frames > 0 do table.remove(frames, 1)() end
	return assert(result)
end
"#;

fn run_priced(script: &str) -> Value {
	use forge_nav::pack::encode::{encode_heights, run_length};
	// Keep even a cell corner within the router's five-yard endpoint limit.
	// Heights are tenths of a yard.
	const SIDE: usize = 80;
	let ground = [1; SIDE * SIDE];
	let heights = |z| lua_string(&encode_heights(&ground, &[z; SIDE * SIDE], SIDE).unwrap());
	let world = format!(
		r#"local function continent(cy0)
			return {{ cells = {SIDE}, nx = 4, ny = 3, cx0 = -2, cy0 = cy0, swim = 2, zstep = .1, grid = {{}}, height = {{}} }}
		end
		PolestarPathData = {{ [1] = continent(-.75) }}
		local function tile(c, wx, wy, h)
			local d = PolestarPathData[c]
			local side = 1600 / 3
			local k = math.floor(wx / side - d.cx0) * d.ny + math.floor(wy / side - d.cy0) + 1
			d.grid[k], d.height[k] = {}, h
		end
		function fake.testshire(cy0)
			PolestarPathData[0] = continent(cy0)
			tile(0, -890, 10, {}); tile(0, 900, 900, {}); tile(0, 0, 0, {})
		end
		fake.testshire(-.75)
		tile(1, -400, 0, {}); tile(1, 410, 5, {})
		"#,
		lua_string(&run_length(&[16; SIDE * SIDE])),
		heights(59),
		heights(0),
		heights(0),
		heights(45),
		heights(45)
	);
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua", "stub_encoding.lua"],
		before: format!("{ENGINE}{MANY}\nfake.pending = Polestar_NavEngine\n{world}"),
		addons: vec![
			Addon::files("Polestar_Nav", &["Routing/Costs.lua", "Routing/PathGrid.lua", "Routing/Path.lua", "Routing/PathJobs.lua", "API.lua"]),
			Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"]),
		],
		login: true,
		script: format!("{PRELUDE}{PRICED}\n{script}"),
		..Default::default()
	})
	.remove(0)
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
	assert_eq!(out["before"], json!(["routing", 600, 0, -600]), "straight at the target until a route is found, as 0.4.1.1");
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

// While the walk is searched the arrow points straight at the target at once (#3518); when the walk lands, the arrow
// turns from the heading it shows onto the walk's, eased as every turn (#3525, Fitz: 0.4.1.1's manners), never a snap.
#[test]
fn when_the_walk_lands_the_arrow_eases_from_its_straight_bearing_onto_the_walk() {
	let out = run(r#"
		local function gap(a, b) return math.abs(math.atan2(math.sin(a - b), math.cos(a - b))) end
		nav.place(0, 0)
		target(0, -600)
		for _ = 1, 4 do aim(); stub.advance(0.05) end
		local shown, goal = N.arrow.GetTurn()
		local r = { mode = N.arrow.GetMode(), straight = gap(shown, goal) }
		fake.resolve(0, 0, 100, -100, 100, -500, 0, -600)
		aim(); stub.advance(0.05)
		local now, walk = N.arrow.GetTurn()
		r.mode2, r.turned, r.step, r.behind = N.arrow.GetMode(), gap(walk, goal), gap(now, shown), gap(now, walk)
		for _ = 1, 40 do aim(); stub.advance(0.05) end
		local late, walk2 = N.arrow.GetTurn()
		r.settled = gap(late, walk2)
		emit(r)"#);
	assert_eq!(out["mode"], "routing", "the walk is still searched: {out}");
	assert!(num(&out["straight"]) < 1e-6, "straight at the target at once: {out}");
	assert_eq!(out["mode2"], "travel");
	assert!(num(&out["turned"]) > 0.5, "the walk's first point lies well off the straight line: {out}");
	assert!(num(&out["step"]) <= 3.5 * 0.05 + 1e-6, "from the shown heading at most MAX_TURN a frame, not a snap: {out}");
	assert!(num(&out["behind"]) > 0.3, "still turning onto the walk: {out}");
	assert!(num(&out["settled"]) < 0.01, "and settles on it: {out}");
}

// 0.4.2 held the arrow on the current piece of every searched (checked) walk: it pointed at the walk's next point and
// swung round at each one (#3509, Fitz on 0.4.2.1: "we don't actually point at the first waypoint, but one further
// away; this stops the 90-degree angles"). With no height from the client (Forever's 0), outdoors and indoors, the
// corridor's aim runs on past the first corner of a two-corner walk, as in 0.4.1.1: with no floor read freely, with
// one up to the farthest point the walking map's line reaches (a wall past 0, -20 here: never pointing into it).
#[test]
fn a_checked_walk_s_arrow_aims_past_its_first_corner_with_no_height_kept_in_reach_of_walls() {
	let out = run(r#"
		-- Each case on its own stretch of ground, ox yards along x (a floor is read only where the player has moved).
		local function walk(ox, indoors, surfaces, sight)
			nav.indoors, fake.surfaces, fake.sight = indoors, surfaces, sight
			N.ClearTarget()
			nav.place(ox, 0)
			target(ox + 12, -120)
			N.Sample()
			local job = fake.last()
			job.walkChecked = true
			-- Two corners 12 yd apart, each turning 45 degrees.
			fake.resolve(ox, 0, ox, -12, ox + 12, -24, ox + 12, -120)
			nav.place(ox, -2)
			stub.advance(0.3)
			local s = aim()
			if s[3] then s[3] = s[3] - ox end
			return s
		end
		local floor0 = function() return { 0 } end
		local wall = function(x1, y1, z1, x2, y2) return y2 >= -20 end
		local r = {}
		r.outdoors, r.indoors = walk(-300, false), walk(-100, true)
		r.outdoorsWall, r.indoorsWall = walk(100, false, floor0, wall), walk(300, true, floor0, wall)
		emit(r)"#);
	for mode in ["outdoors", "indoors"] {
		let s = &out[mode];
		assert_eq!(s[0], "travel", "{mode}: {s}");
		assert!(num(&s[3]) < -24.0 && num(&s[2]) > 10.0, "{mode}: the aim lies past both corners, not on the first at 0, -12 (aim {}, {})", s[2], s[3]);
	}
	for mode in ["outdoorsWall", "indoorsWall"] {
		let s = &out[mode];
		assert_eq!(s[0], "travel", "{mode}: {s}");
		let (x, y) = (num(&s[2]), num(&s[3]));
		assert!(x > 2.0 && y < -14.0 && y >= -21.0, "{mode}: the aim lies past the first corner, short of the wall (aim {x}, {y})");
	}
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
	assert!(num(&split["furthest"]) >= -150.0, "the aim never passes the bridge's spot on the path (y -150; furthest {})", split["furthest"]);
}

// A split walk's chokepoint far along a piece of a sparse path (0.3.8's border sweep, an Ashenvale pass 40 yd past the
// path's point before it): once past that point, or standing on it, the piece aims on to the chokepoint's spot on the
// path, never beyond it; held at the point, the piece's end was out of reach, and a player who walked to the point and
// stood a hair short of it had the arrow at their feet (0.4.0's border sweep: starts that had arrived stopped there).
// A pass 5 yd off a path of three points (0, 0), (0, -100), (0, -300): its spot (0, -160), 60 yd past the middle point.
#[test]
fn a_split_walk_s_piece_aims_on_to_its_chokepoint_far_along_a_piece_of_a_sparse_path_once_on_or_past_the_point_before_it() {
	let out = run(&[
		LOOK,
		r#"
		nav.useTravelWorld()
		PolestarNavChokepoints = { [0] = { { wx = 5, wy = -160, r = 10, kind = "pass", name = "Hollow Pass", zone = "Testshire" } } }
		nav.place(0, 0)
		target(0, -300)
		N.Sample()
		answerZ({ { 0, 0 }, { 0, -100 }, { 0, -300 } })
		local legs, ci = N.GetRoute()
		local first = legs[ci].choke and legs[ci].choke.kind
		local hair = look(0, -100 + 1e-7, 0, -300)
		local past = look(0, -100 - 1e-3, 0, -300)
		local on = look(0, -140, 0, -300)
		emit({ first = first, hair = hair, past = past, on = on })"#,
	]
	.concat());
	assert_eq!(out["first"], "pass", "the walk is split at the pass");
	assert!(num(&out["hair"]["dy"]) < -20.0, "a hair short of the middle point: on toward the pass, not at the player's feet ({} yd)", out["hair"]["dy"]);
	assert!(num(&out["past"]["dy"]) < -20.0, "just past the middle point: on along the path toward the pass ({} yd)", out["past"]["dy"]);
	assert!(-140.0 + num(&out["on"]["dy"]) >= -160.0 - 1e-6, "20 yd short of it: the aim stops at the pass's spot ({} yd on)", out["on"]["dy"]);
	assert!(num(&out["on"]["dy"]) < -15.0, "and reaches it ({} yd on)", out["on"]["dy"]);
}

// Until the player is past the path's point before the chokepoint (or on it), the piece's aim stops at that point, as
// at any stop, even within a few yards of it: let on sooner, it cut the corner there (0.4.0's border sweep: off the
// ramp down into Un'Goro Crater, onto a ledge). A path (0, 0), (0, -100), (20, -140), (20, -300) with a corner at
// (0, -100): a pass halfway along the next piece, at (10, -120), and one at the corner's far point (20, -140), where
// the chokepoint lies at the end of the piece before it.
#[test]
fn a_split_walk_s_piece_stops_at_the_point_before_its_chokepoint_until_the_player_is_past_it_never_cutting_the_corner() {
	let out = run(&[
		LOOK,
		r#"
		nav.useTravelWorld()
		local function walk(px, py)
			PolestarNavChokepoints = { [0] = { { wx = px, wy = py, r = 10, kind = "pass", name = "Hollow Pass", zone = "Testshire" } } }
			N.ClearTarget()
			nav.place(0, 0)
			target(20, -300)
			N.Sample()
			answerZ({ { 0, 0 }, { 0, -100 }, { 20, -140 }, { 20, -300 } })
			local legs, ci = N.GetRoute()
			return { first = legs[ci].choke and legs[ci].choke.kind or false, back = look(0, -90, 20, -300), near = look(0, -97, 20, -300),
				on = look(0, -100 + 1e-7, 20, -300), past = look(1, -102, 20, -300) }
		end
		emit({ mid = walk(10, -120), far = walk(20, -140) })"#,
	]
	.concat());
	for (name, case) in [("halfway along the next piece", &out["mid"]), ("at the next point", &out["far"])] {
		assert_eq!(case["first"], "pass", "{name}: the walk is split at the pass");
		assert!(num(&case["back"]["dx"]).abs() < 0.5, "{name}: 10 yd before the corner the aim holds at it (dx {})", case["back"]["dx"]);
		assert!(num(&case["near"]["dx"]).abs() < 0.5, "{name}: 3 yd before it too (dx {})", case["near"]["dx"]);
		assert!(num(&case["on"]["dx"]) > 1.0, "{name}: on the corner it goes on toward the pass, not at the player's feet (dx {})", case["on"]["dx"]);
		assert!(num(&case["past"]["dx"]) > 1.0, "{name}: past the corner it goes on toward the pass (dx {})", case["past"]["dx"]);
	}
}

// Outdoors a floor change the player came within REACH of stays passed for the path (0.4.0's border sweep: a dip 9
// yd deep right after a walk's start, walked by at its edge toward an aim beyond it; once 5 yd past it the place on
// the path stayed behind it for good and the arrow pointed at the player's feet). A path (0, 0, 0), (0, -8, -9) (the
// dip: steeper than 45 degrees, a floor), (0, -29, 0), (0, -200, 0): 1 yd short of the dip's point, then 6 yd past it.
#[test]
fn outdoors_a_dip_walked_by_at_its_edge_stays_passed_the_player_s_place_on_the_path_moves_on() {
	let out = run(&[
		LOOK,
		r#"
		local function walk(indoors)
			nav.indoors = indoors
			N.ClearTarget()
			nav.place(0, 0)
			target(0, -200)
			N.Sample()
			answerZ({ { 0, 0, 0 }, { 0, -8, -9 }, { 0, -29, 0 }, { 0, -200, 0 } })
			local c = N.GetTargetWorld()
			look(0.5, -7, 0, -200)
			local near = N.walk.Progress(c, 0, -200)
			look(0.5, -14, 0, -200)
			return { near = near and math.floor(near + 0.5) or -1, past = (N.walk.Progress(c, 0, -200) or -1) }
		end
		emit({ outdoors = walk(false), indoors = walk(true) })"#,
	]
	.concat());
	assert_eq!(out["outdoors"]["near"], 7, "1 yd short of the dip: 7 yd along ({})", out["outdoors"]);
	assert!(num(&out["outdoors"]["past"]) > 13.0, "6 yd past it: on along the path beyond it ({})", out["outdoors"]);
	// Indoors (stairs, the Undercity's levels) a floor still holds until the player is within REACH of it.
	assert!(num(&out["indoors"]["past"]) <= 8.5, "indoors the place stays at the floor's point ({})", out["indoors"]);
}

// A drop at the end of the player's own segment, a point they have not reached, stops the aim there (0.4.0's border
// sweep: below Thunder Bluff, a walk to a lift that dropped into a hollow first). Measured from the drop's own floor,
// the path beyond it lay on the aim's floor, so the aim ran on past the drop, the player walked to it along the top,
// and their place on the path stayed behind the drop with the arrow at their feet. A path (0, 0, 0), (0, -12, -20)
// (a drop steeper than 45 degrees), (0, -60, -20), (0, -200, -20): from the start the aim holds at the drop's point;
// within REACH of it, on down the path.
#[test]
fn the_aim_stops_at_a_drop_that_ends_the_player_s_own_segment_until_they_reach_it() {
	let out = run(&[
		LOOK,
		r#"
		nav.place(0, 0)
		target(0, -200)
		N.Sample()
		answerZ({ { 0, 0, 0 }, { 0, -12, -20 }, { 0, -60, -20 }, { 0, -200, -20 } })
		emit({ start = look(0, 0, 0, -200), near = look(0, -8, 0, -200) })"#,
	]
	.concat());
	assert!(num(&out["start"]["dy"]) >= -12.0 - 1e-6, "from the start the aim holds at the drop's point ({} yd on)", out["start"]["dy"]);
	assert!(num(&out["near"]["dy"]) < -20.0, "within REACH of it, on down the path ({} yd on)", out["near"]["dy"]);
}

// A pass the walk has passed stays passed when the walk is searched again from beside it (0.4.0's border sweep: the
// route's step went from the target to the pass and back as the pass, a few yards ahead on the new path, was
// reached at once). The pass of the case above, on a path (0, 0), (0, -100), (0, -300), passed at (0, -170); the
// player then strays 40 yd off it, and the walk searched again from there goes back past the pass, 73 yd on: no
// step to it again. Out past AGAIN (100 yd on) it would be one.
#[test]
fn a_pass_the_walk_has_passed_stays_passed_when_the_walk_is_searched_again_beside_it() {
	let out = run(&[
		LOOK,
		r#"
		nav.useTravelWorld()
		PolestarNavChokepoints = { [0] = { { wx = 5, wy = -160, r = 10, kind = "pass", name = "Hollow Pass", zone = "Testshire" } } }
		nav.place(0, 0)
		target(0, -300)
		N.Sample()
		answerZ({ { 0, 0 }, { 0, -100 }, { 0, -300 } })
		local function step()
			local legs, ci = N.GetRoute()
			return { n = #legs - ci, pass = legs[ci].choke and legs[ci].choke.kind or false }
		end
		local r = { first = step() }
		look(0, -170, 0, -300)                         -- past the pass: on to the target
		r.past = step()
		local asked = #fake.calls
		stub.advance(3)
		look(40, -175, 0, -300)                        -- 40 yd off the path: searched again from here
		r.asked = #fake.calls > asked
		answerZ({ { 40, -175 }, { 0, -140 }, { 0, -300 } })
		r.again = step()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["first"], json!({ "n": 1, "pass": "pass" }), "the walk is split at the pass");
	assert_eq!(out["past"], json!({ "n": 0, "pass": false }), "past it, on to the target");
	assert_eq!(out["asked"], true, "straying searches the walk again");
	assert_eq!(out["again"], json!({ "n": 0, "pass": false }), "the new path goes back past the pass: no step to it again");
}

// The two zones and the gate the zone replan cases walk through: West Vale and East Vale, joined by a gate at
// (600, +-20); from (-500, 500) in West Vale to Kobolds at (-500, -500) in East Vale. walk(gate, direct): the walk to
// the gate is answered with the path `gate` (from the start), which dips into East Vale at (0, -10); there a zone
// change plans again (the target walked to straight: it saves minutes), the walk to the target is answered with
// `direct` (from (0, -10)), and a step back into West Vale at (-3, 4), beside that walk, plans again. -> the route's
// labels before, in East Vale and back in West Vale.
const ZONE_REPLAN: &str = r#"
N.RegisterCrossings({ complete = true,
	zones = {
		[9002] = { name = "West Vale", c = 0, top = 1000, bottom = -1000, left = 1000, right = 0 },
		[9003] = { name = "East Vale", c = 0, top = 1000, bottom = -1000, left = 0, right = -1000 },
	},
	crossings = { { id = "gate", a = { map = 9002, c = 0, wx = 600, wy = 20, r = 15 }, b = { map = 9003, c = 0, wx = 600, wy = -20, r = 15 },
		ab = "Through the gate to East Vale" } } })
local function route()
	local legs, ci = N.GetRoute()
	local out = {}
	for i = ci or 1, legs and #legs or 0 do out[#out + 1] = legs[i].label end
	return out
end
local function walk(gate, direct)
	local r = {}
	nav.place(-500, 500)
	target(-500, -500, "Kobolds")
	aim()
	fake.resolve(unpack(gate))
	r.west = route()
	nav.place(-250, 245)
	aim()
	nav.place(0, -10)                              -- in East Vale, on the walk
	aim()
	stub.fire("ZONE_CHANGED")
	r.east = route()
	aim()
	fake.resolve(unpack(direct))
	aim()
	nav.place(-3, 4)                               -- a step back into West Vale, beside that walk
	aim()
	stub.fire("ZONE_CHANGED")
	r.back = route()
	return r
end
"#;

// Planned again for a zone change, the route goes another way only when that saves time (Travel.Replan's soft
// replan, keepLive): planned from each side of a zone border the player's walk crosses, the two ways differed only
// in the zone the plan started in, and the arrow turned back at every step across it (0.4.0's border sweep: from
// Stonetalon Mountains into the Barrens, up to 118 times in 4 minutes). With straight walks: in East Vale the target
// is walked to straight (it saves minutes: taken); a step back over the border, the way through the gate is planned
// again from West Vale, and the walk the player is on stays.
#[test]
fn a_zone_change_on_the_walk_keeps_the_route_unless_the_fresh_plan_saves_time() {
	let out = run(&[ZONE_REPLAN, r#"emit(walk({ -500, 500, 0, -10, 600, 20 }, { 0, -10, -500, -500 }))"#].concat());
	assert_eq!(out["west"], json!(["Through the gate to East Vale", "Through the gate to East Vale", "Kobolds"]), "{out}");
	assert_eq!(out["east"], json!(["Kobolds"]), "in East Vale the target is walked to straight: it saves minutes");
	assert_eq!(out["back"], json!(["Kobolds"]), "a step back over the border keeps the walk the player is on");
}

// A fresh plan prices a walk it has not searched by its straight line, the live one by its path. With winding walks
// (the walk to the gate 1,410 yd on from (0, -10), the walk to the target 2,526 yd): the way through the gate, left
// for the straight walk in East Vale, is planned again from West Vale at its straight-line 329 s, against the 363 s
// along the path the player is on, and would be taken back; it costs what its walk had left when it was left (421 s),
// so the walk the player is on stays (0.4.0's border sweep: from Stonetalon Mountains into the Barrens, a walk through
// a pass 351 s along its path but 60 s by its straight line, against the walk to the crossing).
#[test]
fn a_way_the_route_left_costs_what_its_walk_had_left_when_a_zone_change_plans_it_again() {
	let out = run(&[ZONE_REPLAN, r#"emit(walk({ -500, 500, 0, -10, 0, -400, 600, -400, 600, 20 }, { 0, -10, 0, -950, -950, -950, -500, -500 }))"#].concat());
	assert_eq!(out["east"], json!(["Kobolds"]), "in East Vale the target is walked to straight: {out}");
	assert_eq!(out["back"], json!(["Kobolds"]), "the way through the gate costs what its walk had left: the walk the player is on stays");
}

// The path for the hillside cases: a corner 100 yd on and 10 yd lower (a hillside, not a floor), then on round it.
const HILLSIDE: &str = r#"
local pts = { { 0, 0, 0 }, { 0, -100, -10 }, { 60, -180, -20 }, { 60, -400, -30 } }
local function cut(indoors)
	nav.indoors = indoors
	nav.place(0, 0)
	target(60, -400)
	N.Sample()
	answerZ(pts)
	-- Cutting the corner straight from (0, -60) toward (60, -180), never within 17 yd of it: the worst aim against
	-- the way walked, and the samples aiming at the corner, once past it.
	local worst, atCorner = -1, 0
	local ux, uy = 1 / math.sqrt(5), -2 / math.sqrt(5)
	for k = 0, 50 do
		local x, y = 1.2 * k, -60 - 2.4 * k
		local s = look(x, y, 60, -400)
		if y < -100 then
			local l = math.sqrt(s.dx * s.dx + s.dy * s.dy)
			local back = -(s.dx * ux + s.dy * uy) / l
			if back > worst then worst = back end
			if math.abs(x + s.dx) < 1 and math.abs(y + s.dy + 100) < 1 then atCorner = atCorner + 1 end
		end
	end
	return { worst = worst, atCorner = atCorner }
end
"#;

#[test]
fn a_hillside_corner_cut_wide_never_holds_the_arrow_back_on_it_outdoors_or_indoors() {
	let outdoors = run(&[LOOK, HILLSIDE, "\n\t\temit(cut(false))"].concat());
	// 0.3.6: a corner 6+ yd lower held the projection until the player came within 5 yd of it, so past it the arrow
	// pointed back at it (Fitz in Desolace, 0.3.7). Outdoors a slope this gentle is no floor.
	assert!(num(&outdoors["worst"]) < 0.0, "outdoors the arrow never points back against the way walked (worst {})", outdoors["worst"]);
	assert_eq!(outdoors["atCorner"], 0, "outdoors it never aims at the corner once past it");
	// 0.3.8 (the arrow replay): indoors too, a gentle slope that runs on is no floor (a tunnel's or a mine's corner, a
	// city's ramp: 772 such places on the baked legs held it; Follow.Mark finds no part of this path above another).
	let indoors = run(&[LOOK, HILLSIDE, "\n\t\temit(cut(true))"].concat());
	assert!(num(&indoors["worst"]) < 0.0, "indoors the arrow never points back against the way walked (worst {})", indoors["worst"]);
	assert_eq!(indoors["atCorner"], 0, "indoors it never aims at the corner once past it");
}

// Indoors where the path doubles back over itself, any 6 yd is still a floor (Follow.Mark): a switchback ramp down 7
// yd over 30 yd south, 8 yd east across the turn and back north 7 yd lower (a spiral stair, the Undercity's ramps).
// Walking down the upper ramp and drifting east to its edge, 1 yd from the lower one and 7 yd from its own line, the
// player's place stays on the upper ramp: the lower one is never taken for it (it would be with 45° at every point
// indoors: nothing then holds the place at the ramp's turn).
const SWITCHBACK: &str = r#"
local pts = { { 0, 0, 0 }, { 0, -30, -7 }, { 8, -30, -7.5 }, { 8, 0, -14 }, { 8, 40, -14 } }
local function down(indoors)
	nav.indoors = indoors
	nav.place(0, 0)
	target(8, 40)
	N.Sample()
	answerZ(pts)
	look(0, 0, 8, 40)
	local c = N.GetTargetWorld()
	local out = {}
	for k = 1, 6 do
		look(math.min(7, 1.5 * k), -3 * k, 8, 40)
		local along = N.walk.Progress(c, 8, 40)
		out[#out + 1] = along and math.floor(along + 0.5) or -1
	end
	return out
end
"#;

#[test]
fn indoors_where_the_path_doubles_back_over_itself_the_player_s_place_never_jumps_to_the_ramp_below() {
	let out = run(&[LOOK, SWITCHBACK, "\n\t\temit(down(true))"].concat());
	let along: Vec<f64> = out.as_array().unwrap().iter().map(num).collect();
	assert!(along.iter().all(|a| (0.0..=30.0).contains(a)), "on the upper ramp (0-30 yd along), never the lower (38 yd on): {along:?}");
}

// The path for the look ahead on the path: 160 yd straight on, a right-angle corner, then 340 yd on, in open ground
// with the floor under the player known. The player walks the first piece toward the corner, a yard every 0.3 s (the
// floor is read every 0.25 s). The path's first 60 yd go by with nothing in sight: past the way onto the road (its
// first 50 yd, `join`, looked along up to 150 yd), holding no point from there. Then `sight` stands for the walking
// grid's line check. The aim at 0, -20 (dx, dy from the player) and the line reads over the last 20 yd.
const CORNER: &str = r#"
fake.surfaces = function() return { 0 } end
local function walkToCorner(sight)
	fake.sight = function() return false end
	nav.place(0, 100)
	target(400, -60)
	N.Sample()
	answerZ({ { 0, 100, 0 }, { 0, -60, 0 }, { 80, -60, 0 }, { 400, -60, 0 } })
	local s
	for y = 100, -20, -1 do
		if y == 40 then fake.sight = sight end
		if y == 0 then fake.sights = 0 end
		nav.place(0, y)
		stub.advance(0.3)
		s = look(0, y, 400, -60)
	end
	return { dx = s.dx, dy = s.dy, sights = fake.sights }
end
"#;

#[test]
fn on_the_path_in_open_ground_the_arrow_aims_40_yd_along_to_a_point_it_can_walk_to_straight() {
	// At 0, -20, 40 yd before the corner, with every line clear: the look runs 40 yd along, to the corner.
	let open = run(&[LOOK, CORNER, "\n\t\temit(walkToCorner(function() return true end))"].concat());
	// 0.3.7: on the path the corridor's aim stopped 35 yd from the player (aim 0, -35), short of the corner (Fitz,
	// 0.3.8: "set the arrow's point further away from the player").
	assert!(num(&open["dy"]) < -38.0 && num(&open["dx"]).abs() < 1.0, "the arrow aims 40 yd along, at the corner (aim {}, {})", open["dx"], open["dy"]);
	// With no clear line (a wall, a cliff, indoors) the corridor's aim stands, as before.
	let walled = run(&[LOOK, CORNER, "\n\t\temit(walkToCorner(function() return false end))"].concat());
	assert!(num(&walled["dy"]) > -36.0 && num(&walled["dx"]).abs() < 1.0, "with nothing further in sight the corridor's aim stands (aim {}, {})", walled["dx"], walled["dy"]);
	// Cheap: looked for again only after the player moves 2 yd, one line read each in open ground.
	assert!(num(&open["sights"]) <= 22.0, "{} line reads over 20 yd walked", open["sights"]);
}

// A path that steps across the walking grid's cells at a slant (10 yd on, 4 yd across, 20 times: what straightening
// leaves where the straight line crosses costlier ground), to a building's corner, then 220 yd along its side.
const STAIRS: &str = r#"
local function stairs(sight)
	nav.place(0, 0)
	target(300, -200)
	N.Sample()
	local pts = { { 0, 0, 0 } }
	for i = 1, 20 do
		pts[#pts + 1] = { 4 * (i - 1), -10 * i, 0 }
		pts[#pts + 1] = { 4 * i, -10 * i, 0 }
	end
	pts[#pts + 1] = { 300, -200, 0 }
	fake.sight, fake.sights = sight, 0
	answerZ(pts)
	local reads = fake.sights
	local s = look(0, 0, 300, -200)
	return { left = s.left, reads = reads }
end
-- The building: a line into x > 81 while y > -199 is blocked; every other line is clear.
local function building(x1, y1, z1, x2, y2)
	for k = 0, 50 do
		local x, y = x1 + (x2 - x1) * k / 50, y1 + (y2 - y1) * k / 50
		if x > 81 and y > -199 then return false end
	end
	return true
end
"#;

#[test]
fn a_path_stepping_across_the_grid_is_smoothed_once_as_it_lands_to_its_real_bends_a_building_s_corner_stays() {
	let open = run(&[LOOK, STAIRS, "\n\t\temit(stairs(building))"].concat());
	// 0.3.7: the path kept all 40 steps (500 yd to walk, the drawn line turning 90° at each). Smoothed: straight to the
	// building's corner (149 + 66 yd: one line runs 150 yd at most), then along it: 436 yd.
	assert!(num(&open["left"]) < 440.0, "the stairs are smoothed to straight lines ({} yd left)", open["left"]);
	// The corner is a real bend: the line across it is blocked, so it stays (cut, 360 yd).
	assert!(num(&open["left"]) > 430.0, "the building's corner stays ({} yd left)", open["left"]);
	// Cheap: once per path, a line read per stretch when each first candidate is clear.
	assert!(num(&open["reads"]) <= 4.0, "{} line reads to smooth it", open["reads"]);
	// Nothing in sight (walls everywhere, or clusters not decoded): the path as it came.
	let walled = run(&[LOOK, STAIRS, "\n\t\temit(stairs(function() return false end))"].concat());
	assert!((num(&walled["left"]) - 500.0).abs() < 1.0, "with no clear line nothing is dropped ({} yd left)", walled["left"]);
	// Bounded: 64 line reads at most for one path, here 41 points with none clear (about 5 each unbounded).
	assert!(num(&walled["reads"]) <= 64.0, "{} line reads for 41 points with none clear", walled["reads"]);
}

#[test]
fn a_search_landing_100_yd_behind_a_player_running_down_a_steep_slope_is_followed_from_where_they_are_now() {
	let out = run(&[
		LOOK,
		r#"
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		answerZ({ { 0, 0, 100 }, { 0, -600, -300 } })
		stub.advance(3)
		local before = calls()
		-- 60 yd off the path: asked again from here.
		look(60, -100, 0, -600)
		local asked = calls() - before
		-- Running on down the slope while it is searched (the old path meanwhile, no other search).
		for y = -110, -200, -10 do look(60, y, 0, -600) end
		local again = calls() - before
		-- It lands: from where it was asked, straight down the slope, 12 yd lower every 10 yd (steeper than 45°:
		-- each corner a floor by the follower's rule even outdoors), then across to the target.
		local pts = {}
		for i = 0, 50 do pts[#pts + 1] = { 60, -100 - 10 * i, 100 - 12 * i } end
		pts[#pts + 1] = { 0, -600, -500 }
		answerZ(pts)
		local s = look(60, -200, 0, -600)
		local later
		for y = -201, -230, -1 do later = look(60, y, 0, -600) end
		emit({ asked = asked, again = again, s = s, later = later, urgent = fake.last().urgent == true })"#,
	]
	.concat());
	assert_eq!(out["asked"], 1, "straying asks once");
	assert_eq!(out["again"], 1, "no second search while the first runs");
	// 0.3.6: the follower started at the late path's start, 100 yd back up the slope, held there by the first
	// steep corner, and pointed back until the player stopped (Fitz, 0.3.7).
	let (dx, dy) = (num(&out["s"]["dx"]), num(&out["s"]["dy"]));
	assert!(dy < 0.0 && dx.abs() < 1.0, "at once the arrow points on down the slope (aim {dx}, {dy})");
	let (lx, ly) = (num(&out["later"]["dx"]), num(&out["later"]["dy"]));
	assert!(ly < 0.0 && lx.abs() < 1.0, "and keeps doing so (aim {lx}, {ly})");
	assert!(num(&out["s"]["dist"]) < 500.0, "the yards shown are from the player on, not from the search's start (dist {})", out["s"]["dist"]);
	assert_eq!(out["urgent"], true, "the arrow's own search is urgent (sliced before the later legs')");
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

// 0.3.5: on a walk of more than 2,000 yd a stray asks again at most every 10 seconds (each ask searches the whole walk;
// a mounted player cutting corners re-asked every 2 s, ~1 MB of garbage a second); a stray long after the last ask
// still asks at once, and a shorter walk keeps the 2 seconds (above).
#[test]
fn on_a_walk_of_more_than_2000_yards_a_stray_asks_again_at_most_every_10_seconds() {
	let out = run(r#"
		local r = {}
		-- The arrow's own searches only (the planner, whose later walks are searched too, is off).
		Polestar.Set("nav.travel", false)
		nav.place(0, 0)
		target(0, -3000)
		N.Sample()
		fake.resolve(0, 0, 0, -1500, 0, -3000)
		stub.advance(12)
		nav.place(60, -200)
		aim()
		r.first = calls()
		fake.resolve(60, -200, 60, -1500, 0, -3000)
		nav.place(120, -300)
		aim()
		r.at = calls()
		stub.advance(3)
		aim()
		r.three = calls()
		stub.advance(8)
		aim()
		r.eleven = calls()
		local job = fake.last()
		r.from = { floor(job.from.x), floor(job.from.y) }
		emit(r)"#);
	assert_eq!(out["first"], 2, "the first stray, 12 s after the last ask: asked at once");
	assert_eq!(out["at"], 2, "straying again right after: not yet");
	assert_eq!(out["three"], 2, "3 s later on a 2,800 yd walk: not yet");
	assert_eq!(out["eleven"], 3, "11 s after the last ask: asked again");
	assert_eq!(out["from"], json!([120, -300]));
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
	assert_eq!(out["aim"], json!(["routing", 500, 500, 0]), "straight at the new target");
	assert_eq!(out["late"], json!(["routing", 500, 500, 0]), "the old target's path is never followed");
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
	assert_eq!(out["fight"], json!(["routing", 600, 0, -600]), "straight at the target while its walk waits for the fight's end");
	assert_eq!(out["inCombat"], 0);
	assert_eq!(out["after"], 1);
}

// The skycutter from Zephras Isle to Dalaran carries the player 25 yd a second for about 70 s with no taxi and no
// speed of their own (Transit.Carried): straying from the walk the whole way, each search (every 2 s before) would
// start from a point the ship leaves at once, and each floor read had the router decode the cluster under it. Nothing
// is searched or read while carried; once the player moves on their own, one search from where they are.
#[test]
fn carried_by_a_ship_the_game_gives_no_taxi_for_nothing_is_searched_or_read_one_search_once_off() {
	let out = run(r#"
		local r = {}
		-- The arrow's own searches only (the planner, whose later walks are searched too, is off).
		Polestar.Set("nav.travel", false)
		-- UnitPosition as Compat reads it (Transit samples it each second), and the player's own speed.
		Polestar.Compat.GetPlayerUnitPosition = function() local p = nav.player return p.wx, p.wy, nil, p.c end
		OWN = 0
		function GetUnitSpeed(unit) if unit == "player" then return OWN, 7, 0, 0 end end
		fake.surfaces = function() return { 0 } end
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		fake.resolve(0, 0, 0, -300, 0, -600)
		stub.advance(3)
		aim()
		local before, reads = calls(), fake.reads or 0
		-- Aboard: 25 yd a second, for 20 s; along the walk until the ride is seen (two samples), then off it.
		for t = 1, 20 do
			if t <= 2 then nav.place(0, -25 * t) else nav.place(25 * (t - 2), -50 - 10 * (t - 2)) end
			stub.advance(1)
			aim()
			if t == 2 then reads = fake.reads or 0 end
		end
		r.riding = calls() - before
		r.reads = (fake.reads or 0) - reads
		r.carried = Polestar.Transit.Carried()
		-- Off the ship, walking on.
		OWN = 7
		nav.place(507, -200)
		stub.advance(1)
		aim()
		r.off = calls() - before
		local job = fake.last()
		r.from = { floor(job.from.x), floor(job.from.y) }
		emit(r)"#);
	assert_eq!(out["carried"], true, "the ride is seen");
	assert_eq!(out["riding"], 0, "no search while carried");
	assert_eq!(out["reads"], 0, "no floor read while carried");
	assert_eq!(out["off"], 1, "one search once off");
	assert_eq!(out["from"], json!([507, -200]));
}

// A search asked as the ship sets off (two samples before the ride is seen) starts from a point the ride leaves:
// once the ride is seen it is dropped, so the router stops on it, and asked again from where the player is once off.
#[test]
fn carried_a_search_under_way_when_the_ride_is_seen_is_dropped_and_asked_again_once_off() {
	let out = run(r#"
		local r = {}
		Polestar.Set("nav.travel", false)
		Polestar.Compat.GetPlayerUnitPosition = function() local p = nav.player return p.wx, p.wy, nil, p.c end
		OWN = 0
		function GetUnitSpeed(unit) if unit == "player" then return OWN, 7, 0, 0 end end
		fake.surfaces = function() return { 0 } end
		nav.place(0, 0)
		stub.advance(1)
		target(0, -600)
		aim()
		local job, before = fake.last(), calls()
		for t = 1, 5 do
			nav.place(25 * t, 0)
			stub.advance(1)
			aim()
		end
		r.cancelled = job.cancelled == true
		r.riding = calls() - before
		OWN = 7
		nav.place(130, 0)
		stub.advance(1)
		aim()
		r.off = calls() - before
		local again = fake.last()
		r.from = { floor(again.from.x), floor(again.from.y) }
		emit(r)"#);
	assert_eq!(out["cancelled"], true, "the search from the ride's start is dropped");
	assert_eq!(out["riding"], 0, "none while carried");
	assert_eq!(out["off"], 1, "one once off");
	assert_eq!(out["from"], json!([130, 0]));
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
fn a_guide_goal_after_a_reached_guide_goto_keeps_the_straight_arrow_from_the_mouth_the_goto_itself_is_walked() {
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
		local reached = false
		Polestar.Engine.GetGuide = function() return guide end
		Polestar.Engine.GoalDone = function(s, g) return reached and s == 1 and g == 1 end
		nav.place(0, 0)
		nav.setWaypoint({ map = m, x = mx, y = my, label = "Mouth", stepIndex = 1, goalIndex = 1, kind = "goto", r = 5 })
		aim()
		r.mouth = calls()
		-- #914: the goal inside aimed at (a row click) before the mouth is reached
		nav.setWaypoint({ map = m, x = ix, y = iy, label = "Inside", stepIndex = 2, goalIndex = 2, kind = "collect", r = 5 })
		aim()
		r.ahead = calls()
		reached = true
		nav.setWaypoint({ map = m, x = ix, y = iy, label = "Inside", stepIndex = 2, goalIndex = 2, kind = "collect", r = 5 })
		r.inside = aim()
		r.insideCalls = calls()
		nav.setWaypoint({ map = m, x = ix, y = iy, label = "Inside", stepIndex = 3, goalIndex = 2, kind = "kill", r = 5 })
		aim()
		r.afterTalk = calls()
		emit(r)"#);
	assert_eq!(out["mouth"], 1, "the goto is a goal like any other");
	assert_eq!(out["ahead"], 2, "before the goto is reached, the goal after it is walked by the engine");
	assert_eq!(out["inside"], json!(["travel", 450, 0, -450]), "once it is reached, the goal after it is straight");
	assert_eq!(out["insideCalls"], 2);
	assert_eq!(out["afterTalk"], 3, "after a located goal that is no goto, the engine walks again");
}

#[test]
fn unavailable_and_failed_walks_point_straight_and_are_asked_again_later() {
	let none = run_with(
		r#"
		nav.place(0, 0)
		target(0, -600)
		emit({ aim(), Polestar.Nav.Path == nil })"#,
		false,
		false,
	);
	// #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
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
	// #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
	assert_eq!(out["nodata"], json!([["travel", 600, 0, -600], 0]));
	assert_eq!(out["unreachable"], json!(["travel", 500, 0, -500]));
	assert_eq!(out["soon"], 1, "a failed search is not repeated at once");
	assert_eq!(out["retry"], 2, "but again after 15 s and 5 yards");
	assert_eq!(out["error"], json!(["travel", 440, 0, 400]));
}

// #3409, Fitz's ruling: wherever no walk is found the arrow points straight, as before 0.4.2, and says why under
// its label; the line is drawn straight. Here a walk refused with a reason (Safe's blockedReason). Main, 2026-11-21,
// Fitz: "go back to our original danger pathing": no reason is the other faction's ground any more, and the arrow
// says what it says for any walk it did not find (0.4.2: "No safe walking route").
#[test]
fn a_walk_refused_with_a_reason_points_straight_says_why_and_draws_its_line() {
	let out = run(r#"
		local r = {}
		nav.place(0, 0)
		target(0, -500)
		aim()
		local job = fake.last()
		job.blockedReason = "hostile town"
		job.callback(nil, "no safe walking route", job)
		r.aim = aim()
		local a = N.arrow
		a:Refresh()
		r.label = a.labelText:GetText()
		r.line = N.CanDrawGroundApproach()
		local g = N.GetRouteGeometry()
		local leg = g and g.legs and g.legs[1]
		r.drawn = { leg and leg.straight or false, leg and #leg.pts or 0 }
		emit(r)"#);
	assert_eq!(out["aim"], json!(["travel", 500, 0, -500]), "straight at the target");
	assert!(out["label"].as_str().unwrap_or("").contains("The last steps here aren't mapped"), "and why: {}", out["label"]);
	assert_eq!(out["line"], true);
	assert_eq!(out["drawn"], json!([true, 2]), "its line straight from the player");
}

// #3448: a walk refused with no policy reason (no blockedReason: the router's departure rule) is asked again once 2 s
// later, the player standing still; refused again, it waits as any failed search (15 s and 5 yd). A refusal on policy
// is not asked again standing still.
#[test]
fn a_refusal_no_policy_gave_is_asked_again_once_after_2_s_standing_still_a_policy_refusal_is_not() {
	let out = run(r#"
		local r = {}
		nav.place(0, 0)
		target(0, -500)
		aim()
		local job = fake.last()
		job.callback(nil, "no safe walking route", job)
		r.refused = { aim(), calls() }
		stub.advance(1); aim()
		r.at1 = calls()
		stub.advance(1.2); aim()
		r.at2 = calls()
		job = fake.last()
		job.callback(nil, "no safe walking route", job)
		stub.advance(5); aim()
		r.again = calls()
		target(0, 400)
		aim()
		job = fake.last()
		job.blockedReason = "hostile town"
		job.callback(nil, "no safe walking route", job)
		local before = calls()
		stub.advance(5); aim()
		r.policy = calls() - before
		emit(r)"#);
	assert_eq!(out["refused"], json!([["travel", 500, 0, -500], 1]), "refused: straight at the target");
	assert_eq!(out["at1"], 1, "not at once");
	assert_eq!(out["at2"], 2, "asked again 2 s later, standing still");
	assert_eq!(out["again"], 2, "once: refused again, it waits as any failed search");
	assert_eq!(out["policy"], 0, "a refusal on policy is not asked again standing still");
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
fn route_geometry_has_no_current_chord_before_the_path_arrives() {
	let out = run(r#"
		local r, fired = {}, 0
		Polestar.On("NAV_ROUTE_GEOMETRY", function() fired = fired + 1 end)
		r.none = N.GetRouteGeometry() == nil
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		local g = N.GetRouteGeometry()
		local points = 0
		for _, leg in ipairs(g.legs) do if leg.current then points = points + #leg.pts end end
		r.pendingPoints = points
		local before = fired
		fake.resolve(0, 0, 100, -100, 100, -500, 0, -600)
		r.fired = fired > before
		g = N.GetRouteGeometry()
		local pts = {}
		for _, p in ipairs(g.legs[1].pts) do pts[#pts + 1] = { p[1], floor(p[2] + 0.5), floor(p[3] + 0.5) } end
		r.path = pts
		emit(r)"#);
	assert_eq!(out["none"], true);
	assert_eq!(out["pendingPoints"], 0);
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

// A character with the riding skill (line 762), set before the split names its steps.
const RIDER: &str = "\nPolestar.Compat.GetSkillRank = function(line) if line == 762 then return 75, 75 end end\n";

#[test]
fn a_character_who_can_ride_rides_to_a_cave_mouth_the_walk_to_a_lift_s_landing_still_says_walk() {
	let out = run(&format!(
		"{RIDER}{}{}",
		split(),
		r#"
		emit(labels())"#
	));
	assert_eq!(
		out,
		json!(["walk|Cross the bridge to Lakeshire", "walk|Ride to the cave mouth in Testshire", "walk|Walk to The Great Lift, Bottom", "lift|Ride the elevator up", "walk|Target",]),
		"the cave mouth reads ride; the bridge keeps its caption and the walk to the lift still says walk"
	);
}

// A ghost walks: with the riding skill too, the split walk's cave mouth reads walk.
#[test]
fn a_ghost_who_can_ride_still_walks_to_a_cave_mouth() {
	let out = run(&format!(
		"{RIDER}UnitIsGhost = function() return true end\n{}{}",
		split(),
		r#"
		emit(labels())"#
	));
	assert_eq!(
		out,
		json!(["walk|Cross the bridge to Lakeshire", "walk|Walk to the cave mouth in Testshire", "walk|Walk to The Great Lift, Bottom", "lift|Ride the elevator up", "walk|Target",]),
		"a ghost reads walk at the cave mouth"
	);
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

// #1046: a building mouth is named after its area, so the Gallows' End Tavern's door read "Walk to
// the Brill entrance", the town's way in. With an inn's innkeeper beside it, it is the inn's door.
#[test]
fn a_building_mouth_beside_an_inn_s_innkeeper_is_the_inn_s_entrance() {
	let out = run(r#"
		nav.useTravelWorld()
		Polestar.Nav.RegisterTravelData({ inns = { { names = { "Gallows' End Tavern", "Testshire" }, npc = 901, c = 0, wx = 20, wy = -310, map = 9000, x = 50, y = 50, f = "e" } } })
		PolestarNavChokepoints = { [0] = {
			{ wx = 0, wy = -300, r = 10, kind = "building", name = "Testshire", zone = "Testshire" },
			{ wx = 0, wy = -450, r = 10, kind = "building", name = "Westbrook Keep", zone = "Testshire" },
		} }
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		fake.resolve(0, 0, 0, -300, 0, -600)
		local legs, ci = N.GetRoute()
		local out = {}
		for i = ci or 1, legs and #legs or 0 do out[#out + 1] = legs[i].kind .. "|" .. legs[i].label end
		emit(out)"#);
	assert_eq!(
		out,
		json!(["walk|Walk to the Testshire Inn entrance", "walk|Walk to the Westbrook Keep entrance", "walk|Target"]),
		"the inn's door says Inn; a building with no innkeeper by it keeps its area's name"
	);
}

// #2863 (Edet in the Ruins of Andorhal): a house's door there is named after the ruins, so the walk to it read
// "Walk to the Ruins of Andorhal entrance" while the player stood in the ruins, as if it were the way into them.
// A mouth named after the subzone the player is in is just the entrance; one named after another place keeps it.
#[test]
fn a_building_or_cave_mouth_named_after_the_subzone_the_player_is_in_is_just_the_entrance_2863() {
	let out = run(r#"
		nav.useTravelWorld()
		nav.Compat.GetZoneText = function() return "Testshire", "Ruins of Testshire" end
		PolestarNavChokepoints = { [0] = {
			{ wx = 0, wy = -200, r = 10, kind = "building", name = "Ruins of Testshire", zone = "Testshire" },
			{ wx = 0, wy = -300, r = 10, kind = "cave", name = "Ruins of Testshire", zone = "Testshire" },
			{ wx = 0, wy = -450, r = 10, kind = "building", name = "Westbrook Keep", zone = "Testshire" },
		} }
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		fake.resolve(0, 0, 0, -200, 0, -300, 0, -450, 0, -600)
		local legs, ci = N.GetRoute()
		local out = {}
		for i = ci or 1, legs and #legs or 0 do out[#out + 1] = legs[i].kind .. "|" .. legs[i].label end
		emit(out)"#);
	assert_eq!(
		out,
		json!(["walk|Walk to the entrance", "walk|Walk to the cave mouth", "walk|Walk to the Westbrook Keep entrance", "walk|Target"]),
		"the mouths in the player's own subzone say no name; another place's door keeps its name"
	);
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

// Z2: a goal's height that finds no walk at all is asked once more without it (the maps miss its floor's join: a walk
// to the spot beats the straight arrow), and the arrow says the last steps aren't mapped.
#[test]
fn z2_a_search_with_the_height_that_fails_is_asked_once_more_without_it_and_that_answer_stands() {
	let out = run(&[
		Z_WAYPOINT,
		r#"
		local r = {}
		nav.place(0, 0)
		goal(-66)
		N.Sample()
		r.first = { fake.last().to.z, fake.last().to.reach or false }
		fake.fail("unreachable")
		r.retry = { calls(), fake.last().to.z == nil }
		fake.resolve(0, 0, 100, -300, 0, -600)
		r.used = aim()
		r.calls = calls()
		r.said = (N.walk.Unmapped())
		nav.place(-60, -200)
		stub.advance(3)
		aim()
		r.stray = { calls(), fake.last().to.z == nil }
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["first"], json!([-66, 10]), "at the goal's height, with the router's reach");
	assert_eq!(out["retry"], json!([2, true]), "one more search, without z");
	assert_eq!(head(&out["used"], 2), json!(["travel", round(100f64.hypot(300.0) + 100f64.hypot(300.0))]), "its path is the arrow's");
	assert_eq!(out["calls"], 2);
	assert_eq!(out["said"], true, "its walk ends on whichever floor the maps join there: said");
	assert_eq!(out["stray"], json!([3, true]), "later searches for the same goal stay without the height");
}

#[test]
fn z2_a_failure_without_the_height_too_points_straight_with_no_third_search() {
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
	// #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
	assert_eq!(out, json!([["travel", 600, 0, -600], 2]));
}

// WorldFloor (2026-11-18): a walk searched with the goal's height (and the router's reach) that ends more than 30 yd
// above or below it stands: the one asked again without the height ended on whichever floor was cheapest at the spot,
// no nearer the goal's (the world gate's barrow dens, mines and cliffs). The arrow says the last steps aren't mapped.
#[test]
fn z2_a_path_searched_with_the_height_that_ends_more_than_30_yards_above_or_below_it_stands_and_the_arrow_says_so() {
	let out = run(&[
		Z_WAYPOINT,
		r#"
		local r = {}
		nav.place(0, 0)
		goal(-66)
		N.Sample()
		-- the last engine point before the goal stands on the street, 100 yd above
		answer({ 0, 0, 34 }, { 50, -300, 34 }, { 0, -590, 34 }, { 0, -600, -66 })
		r.kept = { calls(), aim()[1], (N.walk.Unmapped()) }
		r.used = aim()
		goal(-50, 2)
		N.Sample()
		r.within = calls()
		answer({ 0, 0, 34 }, { 0, -590, -25 }, { 0, -600, -50 })
		r.close = { calls(), aim()[1], (N.walk.Unmapped()) }
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["kept"], json!([1, "travel", true]), "no search without z; the walk is followed, said");
	heads(&out["used"], (0.0, 0.0), (50.0, -300.0), "the walk with the height is the arrow's path");
	assert_eq!(out["within"], 2, "another goal with a height: searched with it");
	assert_eq!(out["close"], json!([2, "travel", false]), "25 yards off is within 30: kept, nothing said");
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
		r.pending = N.GetRoute() == nil
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
	assert_eq!(out["pending"], true, "no flight while the walks from its landings are being checked");
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

// A target within 400 yd of the player (MEASURE_NEAR) is not measured (0.3.2: a batch is about a second of router
// work, and a guide sets such a waypoint at every turn-in): its plan keeps the straight estimate, and the arrow's own
// walk is still searched and followed. A far target from the same spot is measured as before.
#[test]
fn terrain_a_target_within_400_yd_of_the_player_is_not_measured_its_arrow_still_follows_the_engines_walk_a_far_one_is() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		nav.place(200, 250)
		target(0, 0)
		N.Sample()
		r.near = { batches = #fake.of(true), finds = #fake.of(false), route = route() }
		local find = fake.of(false)[1]
		fake.answer(find, 200, 250, 150, 50, 0, 0)
		r.aim = aim()
		target(0, -1000)
		N.Sample()
		r.far = { batches = #fake.of(true) }
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["near"]["batches"], 0, "no measure 320 yd from the target: {out}");
	assert!(num(&out["near"]["finds"]) >= 1.0, "the arrow's own walk is searched: {out}");
	assert_eq!(out["near"]["route"]["engine"], false, "the plan keeps the straight estimate: {out}");
	assert_eq!(out["aim"][0], "travel", "{out}");
	assert_eq!(out["aim"][1], 364, "the yards shown are the engine's walk (206 + 158): {out}");
	assert_eq!(out["far"]["batches"], 1, "a target 1,266 yd away is measured: {out}");
}

#[test]
fn terrain_a_measure_that_keeps_the_way_keeps_the_route_and_its_progress_its_later_walk_taking_the_measured_price_review_8() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		-- Only Ridge is known on the first visit. Its checked walk can be used
		-- again while learning Road's flight path adds an origin to the batch.
		local flags = Polestar.CharState().flags
		flags.taxi[3], flags.taxiSeen = nil, { [0] = true }
		nav.place(900, 900)
		target(0, 0)
		fake.settle(fake.of(true)[1], function(x, y) if at(x, y, 0, 300) then return 360 end return terrain(x, y) end)
		N.ClearTarget()
		nav.taxiMap = { mapID = 9000, nodes = { { 1, 0 }, 2, 3 } }
		stub.fire("TAXIMAP_OPENED", 1)
		nav.taxiMap = nil
		stub.fire("TAXIMAP_CLOSED")

		nav.place(900, 860)
		target(0, 0)
		local legs, first = N.GetRoute()
		local r = { before = route(), approach = legs[first].kind }
		local many = fake.of(true)
		r.batches, r.origins = #many, #many[2].targets
		nav.place(900, 900)
		N.Sample()
		local _, ci = N.GetRoute()
		r.advanced = ci > first and legs[ci].kind == "fly"

		local before = changes
		fake.settle(many[2], function(x, y) return math.floor(math.sqrt(x * x + y * y) * 1.1) end)
		local after, index = N.GetRoute()
		r.same, r.progress, r.changes, r.after = legs == after, ci == index, changes - before, route()
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["before"], json!({ "lands": "Ridge Roost, Testshire", "yards": 360, "seconds": 51, "engine": "cost" }));
	assert_eq!(out["batches"], 2, "the newly known landing triggers a fresh measure");
	assert_eq!(out["origins"], 4, "the player and all three landings");
	assert_eq!(out["approach"], "walk");
	assert_eq!(out["advanced"], true, "the player reached the flight master before the price arrived");
	assert_eq!(out["same"], true, "the existing legs stay");
	assert_eq!(out["progress"], true, "do not rewind the completed approach");
	assert_eq!(out["changes"], 1, "publish the updated price once");
	assert_eq!(out["after"], json!({ "lands": "Ridge Roost, Testshire", "yards": 330, "seconds": 47, "engine": "cost" }));
}

#[test]
fn a_refused_landing_cannot_win_on_a_straight_estimate_and_no_safe_walk_leaves_no_landing() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		nav.place(900, 900)
		target(0, 0)
		N.Sample()
		-- No walk descends from Ridge Roost. Use the landing with a measured way instead.
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
	assert_eq!(out["one"], json!({ "lands": "Road Roost, Testshire", "yards": 750, "seconds": 107, "engine": "cost" }));
	assert!(out["none"]["lands"].is_null(), "no landing has a walk to the second target: {out}");
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
		local before = changes
		fake.settle(first, terrain)
		r.staleDropped = changes == before and N.GetRoute() == nil and N.walk.Measured(0, 0, 0, false) == nil
		fake.settle(second, function(x, y) return math.floor(math.sqrt(x * x + (y + 100) ^ 2) * 1.1) end)
		r.priced = route()
		target(0, 0)
		r.back = #fake.of(true)
		fake.settle(fake.of(true)[3], terrain)
		r.first = route().lands
		target(0, -100)
		r.kept = #fake.of(true)
		r.second = route()
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["cancelled"], true);
	assert_eq!(out["staleDropped"], true, "the late answer neither caches a price nor publishes a route");
	assert_eq!(out["priced"], json!({ "lands": "Ridge Roost, Testshire", "yards": 440, "seconds": 63, "engine": "cost" }));
	assert_eq!(out["back"], 3, "the first target, never measured, is asked again");
	assert_eq!(out["first"], "Road Roost, Testshire");
	assert_eq!(out["kept"], 3, "the second target's measure is kept");
	assert_eq!(out["second"], out["priced"], "the cached price restores the same landing and yards");
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
-- A paid route appears when its final walk is measured. Only the following
-- arrow frame requests the walk to the flight master; later legs wait for it.
local function releaseCrossing(batch)
	assert(batch.reverse and batch.from.x == 600 and N.GetRoute() == nil)
	fake.settle(batch, function(x, y)
		return math.floor(math.sqrt((x - batch.from.x)^2 + (y - batch.from.y)^2) * 1.1)
	end)
	assert(N.GetRoute(), "the checked walk should release the ticket")
	stub.advance(.1)
	return fake.walk(900, 800, 900, 900)
end
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
		r.waiting = N.GetRoute() == nil
		r.order = {}
		for _, job in ipairs(fake.calls) do r.order[#r.order + 1] = job.many and "many" or "find" end
		local batch = fake.of(true)[1]
		r.places = #batch.targets
		r.direct = #fake.of(false)
		local own = releaseCrossing(batch)
		r.plan = legsNow()
		r.waitOwn = { #fake.of(false), own.urgent == true }
		fake.answerWalk(900, 800, 900, 900)
		local leg = fake.walk(400, 300, 600, 20)
		r.leg = { #fake.of(false), floor(leg.from.x), floor(leg.from.y), floor(leg.to.x), floor(leg.to.y) }
		r.straight = lines()
		fake.answerWalk(400, 300, 500, 300, 600, 20)
		r.priced = legsNow()
		r.drawn = lines()
		local cross = fake.walk(600, 20, 600, -20)
		r.cross = { #fake.of(false), floor(cross.from.x), floor(cross.from.y), floor(cross.to.x), floor(cross.to.y) }
		fake.answerWalk(600, 20, 610, 0, 600, -20)
		local onward = fake.walk(600, -20, 600, -300)
		r.onward = { #fake.of(false), floor(onward.from.x), floor(onward.from.y), floor(onward.to.x), floor(onward.to.y) }
		r.crossPriced = legsNow()[4]
		fake.answerWalk(600, -20, 650, -150, 600, -300)
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
	assert_eq!(out["waiting"], true, "no flight before the onward price");
	assert_eq!(out["order"], json!(["many"]), "the measure alone while the ticket waits (#3369)");
	assert_eq!(out["direct"], 0, "no walk straight to the target meanwhile");
	assert_eq!(out["places"], 5, "the player, both flight masters and both crossing ends");
	assert_eq!(out["waitOwn"], json!([1, true]), "then the flight-master walk; no later search yet");
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
		releaseCrossing(fake.of(true)[1])
		stub.inCombat = true
		fake.answerWalk(900, 800, 900, 900)
		N.Refresh()
		r.fight = #fake.of(false)
		stub.inCombat = false
		N.Refresh()
		r.after = #fake.of(false)
		local leg = fake.walk(400, 300, 600, 20)
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
fn a_numeric_walk_price_without_ground_checks_cannot_move_the_landing() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		nav.place(900, 900)
		target(0, 0)
		N.Sample()
		local job = fake.of(true)[1]
		job.unchecked = true
		fake.settle(job, terrain)
		local measured = N.walk.Measured(0, 0, 0, false)
		local before = route().lands or false
		T.Replan()
		emit({ before = before, replanned = route().lands or false, quoted = measured and measured(0, 0, -700) or false })"#,
		]
		.concat(),
	);
	assert_eq!(out, json!({"before":false,"replanned":false,"quoted":false}), "an unverified number never sells a ticket, including after a refresh");
}

#[test]
fn a_checked_measure_is_not_reused_after_the_start_moves_and_the_next_plan_measures_again() {
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
		r.closer = cost(0, 0, 500, true) or false
		r.aside = cost(0, 300, 400, true) or false
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
	assert_eq!(out["closer"], false, "the remaining walk was not checked from this spot");
	assert_eq!(out["aside"], false, "a lateral move has no certified connector");
	assert_eq!(out["batches"], 2, "walked away: measured again with the next plan");
	assert!(out["points"].as_array().unwrap().iter().any(|p| p[0] == 300 && p[1] == 400), "from where the player now stands");
}

// #1053, #1023 (Thunder Bluff: beside Hamuul Runetotem on Elder Rise, beside Nara Wildmane): the player's walk into
// the target was measured from far away, and within 400 yd of the target (MEASURE_NEAR) it is never measured again.
// Until 0.3.5 that far measure less the yards moved stood for the player's walk there, so a winding walk measured
// from another zone still counted thousands of yards beside the target: the route went to a place with a short
// measured walk in (the lift top across the bridge, Mulgore below) and back, and from there back again. Within 400 yd
// of the target the player's walk keeps the straight estimate, as for a target set that near.
#[test]
fn terrain_beside_a_target_measured_from_far_away_the_player_s_walk_is_straight_never_the_far_measure_less_the_yards_moved_1053() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		nav.place(900, 900)
		target(0, 0)
		N.Sample()
		-- A winding walk of 5,000 yd from where the player was; the flight masters' as on the terrain.
		fake.settle(fake.of(true)[1], function(x, y)
			if at(x, y, 900, 900) then return 5000 end
			return terrain(x, y)
		end)
		local cost = N.walk.Measured(0, 0, 0, false)
		r.beside = cost(0, 0, 20, true) or false
		nav.place(0, 20)
		T.Replan()
		local legs, ci = N.GetRoute()
		r.legs = {}
		for i = ci, #legs do r.legs[#r.legs + 1] = { legs[i].kind .. "|" .. legs[i].label, legs[i].yards, legs[i].engine or false } end
		r.batches = #fake.of(true)
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["beside"], false, "20 yd from the target: no measure for the player's walk (was 5,000 less 1,259 moved): {out}");
	assert_eq!(out["legs"], json!([["walk|Target", 25, false]]), "the walk in at its straight estimate (20 x 1.25), not the far measure's 3,741 yd: {out}");
	assert_eq!(out["batches"], 1, "and nothing measured again that near: {out}");
}

// 0.3.5: the player alone walked away from where their walk was measured: only their walk is measured again (a batch
// of one, from the target, reversed), the other places' measured walks kept. Until 0.3.4 each such replan near the
// target ran the whole 16-place batch again: 20-70 MB of the router's garbage each time.
#[test]
fn the_player_alone_walked_away_only_the_player_s_walk_is_measured_again_the_places_walks_kept() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		nav.place(0, 600)
		target(0, 0)
		N.Sample()
		local first = fake.of(true)[1]
		r.firstN = #first.targets
		fake.settle(first, terrain)
		nav.place(300, 400)
		T.Replan()
		local many = fake.of(true)
		local job = many[#many]
		local pts = {}
		for _, p in ipairs(job.targets) do pts[#pts + 1] = { floor(p.x + 0.5), floor(p.y + 0.5) } end
		r.batches, r.points = #many, pts
		r.from, r.reverse = { floor(job.from.x + 0.5), floor(job.from.y + 0.5) }, job.reverse == true
		r.style = job.opts.style == first.opts.style
		fake.settle(job, function() return 600, 590 end)
		local cost = N.walk.Measured(0, 0, 0, false)
		local function price(x, y, player)
			local c, yards = cost(0, x, y, player)
			return { c, yards }
		end
		r.road = price(0, -700)
		r.ridge = price(0, 300)
		r.home = price(900, 900)
		r.player = price(300, 400, true)
		T.Replan()
		r.after = #fake.of(true)
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["firstN"], 4, "the first batch: the player and the three flight masters");
	assert_eq!(out["batches"], 2, "walked away: measured again");
	assert_eq!(out["points"], json!([[300, 400]]), "the player's walk alone");
	assert_eq!(out["from"], json!([0, 0]), "from the target");
	assert_eq!(out["reverse"], true);
	assert_eq!(out["style"], true, "with the first batch's opts");
	assert_eq!(out["road"], json!([750, 750]), "Road Roost's walk kept");
	assert_eq!(out["ridge"], json!([2000, 2000]), "Ridge Roost's walk kept");
	assert_eq!(out["home"], json!([1400, 1400]), "Home Roost's walk kept");
	assert_eq!(out["player"], json!([600, 590]), "the player's new walk and its yards");
	assert_eq!(out["after"], 2, "planned again from there: no further batch");
}

// Carried (Transit.Carried, the skycutter to Dalaran), the planner measures nothing from the player: the batch under
// way when the ride is seen (from the target to where the ship set off) is dropped, the plans on the way start none,
// and the first plan once off measures.
#[test]
fn carried_nothing_is_measured_from_the_player_the_batch_under_way_is_dropped_the_first_plan_once_off_measures() {
	let out = run_many(
		&[
			TERRAIN,
			r#"
		local r = {}
		Polestar.Compat.GetPlayerUnitPosition = function() local p = nav.player return p.wx, p.wy, nil, p.c end
		OWN = 0
		function GetUnitSpeed(unit) if unit == "player" then return OWN, 7, 0, 0 end end
		nav.place(0, 600)
		stub.advance(1)
		target(0, 0)
		N.Sample()
		local first = fake.of(true)[1]
		-- Aboard, 50 yd a second; the plan made again on the way.
		for t = 1, 6 do
			nav.place(50 * t, 600 - 33 * t)
			stub.advance(1)
			T.Replan()
		end
		r.dropped = first.cancelled == true
		r.carried = Polestar.Transit.Carried()
		r.riding = #fake.of(true)
		OWN = 7
		nav.place(305, 400)
		stub.advance(1)
		T.Replan()
		local many = fake.of(true)
		r.off = #many
		r.reverse = many[#many].reverse == true
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["dropped"], true, "the batch under way when the ride is seen is dropped: {out}");
	assert_eq!(out["carried"], true);
	assert_eq!(out["riding"], 1, "no batch while carried: {out}");
	assert_eq!(out["off"], 2, "the first plan once off measures: {out}");
	assert_eq!(out["reverse"], true);
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
		Polestar.Engine.GoalDone = function(s, g) return s == 1 and g == 1 end -- the mouth reached (checked off)
		nav.place(900, 800)
		nav.setWaypoint({ map = m, x = ix, y = iy, label = "Inside", stepIndex = 2, goalIndex = 1, kind = "collect", r = 5 })
		N.Sample()
		r.pending = N.GetRoute() == nil and #fake.of(false) == 0
		fake.settle(fake.of(true)[1], function(x, y) return math.floor(math.sqrt(x * x + y * y) * 1.1) end)
		stub.advance(.1)
		fake.answerWalk(900, 800, 900, 900)
		local legs = N.GetRoute()
		local g = N.GetRouteGeometry().legs
		r.finds = #fake.of(false)
		r.last = { legs[#legs].kind, legs[#legs].engine or false, #g[#g].pts }
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["pending"], true, "no premature flight and no direct search past the guide's way in");
	assert_eq!(out["finds"], 1, "only the arrow's own walk is searched");
	assert_eq!(out["last"], json!(["walk", "cost", 2]), "priced by the measure, drawn straight from the mouth");
}

// #1128 (Fitz, Tirisfal's "The Barrens" step from Orgrimmar): the step before is the zeppelin tower's goto in
// Tirisfal, reached, so the Barrens goto counted as following a way in and the arrow drew a straight line across
// Durotar; a hand-set waypoint walked. Only a reached goto on the target's continent within 500 yards is a way in.
#[test]
fn a_reached_goto_is_a_way_in_only_on_the_target_s_continent_and_near_it_1128_the_zeppelin_tower_before_the_barrens() {
	let out = run_many(
		r#"
		local m, tx, ty = nav.mapPoint(0, 0)          -- the target
		local function follows(goto)
			local guide = { steps = {
				{ goals = { goto } },
				{ goals = { { t = "goto", map = m, x = tx, y = ty } } },
			} }
			Polestar.Engine.GetGuide = function() return guide end
			Polestar.Engine.GoalDone = function(s, g) return s == 1 and g == 1 end -- the earlier goto reached
			return N.walk.FollowsGoto({ map = m, x = tx, y = ty, stepIndex = 2, goalIndex = 1, kind = "goto" })
		end
		local _, nx, ny = nav.mapPoint(0, 280)         -- a cave's mouth, 280 yd off
		local _, fx, fy = nav.mapPoint(0, 900)         -- 900 yd off, same continent
		emit({
			near = follows({ t = "goto", map = m, x = nx, y = ny }),
			far = follows({ t = "goto", map = m, x = fx, y = fy }),
			other = follows({ t = "goto", map = 9001, x = 50, y = 50 }),
		})"#,
	);
	assert_eq!(out, json!({ "near": true, "far": false, "other": false }));
}

// #1338 (Jaesais, Cure Poison in Darnassus): a building's door is the way in to an NPC upstairs, and a step
// often has two goals at that NPC (an optional turn-in before the accept). The goal at the NPC's own spot is no
// waypoint of its own, so the accept still follows the door; a goal elsewhere in between still ends the way in.
#[test]
fn a_way_in_reaches_past_goals_at_the_target_s_own_spot_1338_the_optional_turn_in_before_the_accept() {
	let out = run_many(
		r#"
		local m, tx, ty = nav.mapPoint(0, 0)          -- the NPC upstairs
		local _, dx, dy = nav.mapPoint(0, 25)         -- the building's door, a guide goto
		local _, ox, oy = nav.mapPoint(0, 60)         -- another NPC outside
		local function follows(between)
			local guide = { steps = {
				{ goals = { { t = "goto", map = m, x = dx, y = dy } } },
				{ goals = { between, { t = "accept", map = m, x = tx, y = ty } } },
			} }
			Polestar.Engine.GetGuide = function() return guide end
			Polestar.Engine.GoalDone = function(s, g) return s == 1 and g == 1 end -- the door reached
			return N.walk.FollowsGoto({ map = m, x = tx, y = ty, stepIndex = 2, goalIndex = 2, kind = "accept" })
		end
		emit({
			same = follows({ t = "turnin", map = m, x = tx, y = ty }),
			elsewhere = follows({ t = "turnin", map = m, x = ox, y = oy }),
		})"#,
	);
	assert_eq!(out, json!({ "same": true, "elsewhere": false }));
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
	let out = run_priced(
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
		assert(finish(fake.of(true)[1]).job.walkChecked) -- the walk from the far deck into Testshire
		assert(finish(fake.of(false)[1]).job.walkChecked)
		local later = fake.of(false)[2]
		r.later = { later and later.to.x, later and later.to.y, later and (later.to.z or "none") }
		local path = finish(later)
		r.deck = { path.job.walkChecked, path.value[#path.value].z }
		local from, to = { c = 1, wx = 300, wy = 0 }, { c = 1, wx = 410, wy = 5, z = 4.5 }
		r.priced = N.walk.LegPath(from, to) ~= nil
		to.z = -12
		r.otherFloor = N.walk.LegPath(from, to) ~= nil
		emit(r)"#,
	);
	assert_eq!(out["arrow"], json!([-890, 10, 5.9]), "the deck, not the ship's stop in the water under it");
	assert!(is_match(out["kinds"].as_str().unwrap(), r"^walk fly walk boat"));
	assert_eq!(out["later"], json!([410, 5, 4.5]), "the later walk from the flight master to the deck");
	assert_eq!(out["deck"], json!([true, 4.5]));
	assert_eq!(out["priced"], true);
	assert_eq!(out["otherFloor"], false, "the searched deck is not the floor underneath it");
}

#[test]
fn the_walk_off_a_boat_whose_end_has_a_board_point_is_searched_and_measured_from_the_deck_with_the_deck_s_height() {
	let out = run_priced(
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
		assert(finish(batch).job.walkChecked) -- Far Roost has a walk to the goal; the deck need not have a direct one
		assert(finish(fake.of(false)[1]).job.walkChecked)
		local later = fake.of(false)[2]
		r.later = later and { later.from.x, later.from.y, later.from.z or "none" }
		r.checked = finish(later).job.walkChecked
		local from, to = { c = 1, wx = 410, wy = 5, z = 4.5 }, { c = 1, wx = 300, wy = 0 }
		r.priced = N.walk.LegPath(from, to) ~= nil
		from.z = -12
		r.otherFloor = N.walk.LegPath(from, to) ~= nil
		emit(r)"#,
	);
	assert!(is_match(out["kinds"].as_str().unwrap(), r"^walk boat walk"));
	assert_eq!(out["later"], json!([410, 5, 4.5]), "the walk off the boat starts on the far deck, at its height");
	assert_eq!(out["measured"], 4.5, "the measure into the target from the far deck carries its height");
	assert_eq!(out["checked"], true);
	assert_eq!(out["priced"], true);
	assert_eq!(out["otherFloor"], false, "a walk from the deck cannot start below it");
}

#[test]
fn a_walk_found_only_on_the_surface_cannot_sell_a_flight_to_a_target_below_it() {
	let out = run_priced(
		&[
			TERRAIN,
			r#"
		local r = {}
		fake.testshire(-.25) -- Ridge Roost and the target share the same walkable tile at z=0
		local m, x, y = nav.mapPoint(0, 0)
		nav.place(900, 800)
		nav.setWaypoint({ map = m, x = x, y = y, z = -40, label = "Below", stepIndex = 1, goalIndex = 1, kind = "turnin", r = 5 })
		N.Sample()
		local first = fake.of(true)[1]
		r.batchZ = { first.from.z, first.from.reach or false }
		first.callback(nil, "error", first) -- no per-place verdict, unlike an explicit refusal at -40
		local second = fake.of(true)[2]
		r.retryZ = second and (second.from.z or "none")
		local flat = finish(second)
		for i, p in ipairs(second.targets) do
			if p.x == 0 and p.y == 300 then r.flat = { flat.job.walkChecked, flat.job.yards[i] } end
		end
		r.before = route().lands or false
		T.Replan()
		r.below = route().lands or false
		local measured = N.walk.Measured(0, 0, 0, false, -40)
		r.price = measured and measured(0, 0, 300) or false
		-- Same horizontal trip, but the target is now on the floor the road reaches.
		nav.setWaypoint({ map = m, x = x, y = y, z = 0, label = "Surface", stepIndex = 2, goalIndex = 1, kind = "turnin", r = 5 })
		N.Sample()
		local surface = fake.of(true)[3]
		assert(surface.from.z == 0 and finish(surface).job.walkChecked)
		r.surface = route()
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["batchZ"], json!([-40, 10]), "from the target at its height, with the router's reach (WorldFloor)");
	assert_eq!(out["retryZ"], "none", "a batch with it that finds nothing: once more without it");
	assert_eq!(out["flat"], json!([true, 300]), "there really is a walk from Ridge Roost, but only on the surface");
	assert_eq!(out["before"], false);
	assert_eq!(out["below"], false, "replanning cannot sell a ticket for a road forty yards above the goal");
	assert_eq!(out["price"], false);
	assert_eq!(out["surface"]["lands"], "Ridge Roost, Testshire");
	assert_eq!(out["surface"]["yards"], 300);
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
		releaseCrossing(fake.of(true)[1])
		fake.answerWalk(900, 800, 900, 900)
		fake.answerWalk(400, 300, 500, 300, 600, 20)
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
	let out = run_priced(
		r#"
		-- The only connection on this tile is a narrow dogleg from the flight master to the pier.
		local d = PolestarPathData[0]
		d.grid[1], d.height[1] = nil, nil
		local bucket = floor((17067 + 700) / 64) * 1024 + floor(17067 / 64)
		local line = "0.1:-700,0,5.9;-800,100,5.9;-800,-100,5.9;-900,0,5.9;"
		d.localWalk = { lines = { [bucket] = C_EncodingUtil.EncodeBase64(C_EncodingUtil.CompressString(line)) } }
		N.RegisterTravelData({ build = "test",
			taxi = {
				{ 1, 0, 900, 900, 9000, 5, 5, 3, "Home Roost, Testshire" },
				{ 2, 0, -700, 0, 9000, 50, 85, 3, "Dock Roost, Testshire" },
			},
			taxiZ = { [2] = 5.9 },
			flights = { 1, 2, 1700, 2, 1, 1700 },
			transports = {
				{ id = "boat-test", kind = "boat", faction = 3, ab = 60, ba = 60, waitA = 30, waitB = 30,
					a = { "Testshire Docks", 0, -900, 0, 9000, 50, 95, "e", nil, 5.9 }, b = { "Farland Pier", 1, 400, 0, 9001, 50, 10 } },
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
		assert(finish(batch).job.walkChecked) -- Farland Pier to the target
		assert(finish(fake.of(false)[1]).job.walkChecked)
		local walk = finish(fake.of(false)[2])
		assert(walk.job.walkChecked and math.abs(walk.job.yards - (200 + 200 * math.sqrt(2))) < .001)
		emit({ before = before, after = legsNow() })"#,
	);
	let walk_before = num(&out["before"][2][1]);
	let walk_after = num(&out["after"][2][1]);
	assert_eq!(out["before"][2][0], "walk");
	assert!(walk_after > walk_before, "the walk to the docks along its path ({walk_after} s, straight {walk_before} s)");
	assert_eq!((walk_before, walk_after), (36.0, 69.0));
	assert_eq!(out["after"][3][0], "boat");
	// Its leg times up to the boat's landing: the boat still leaves at 1000 s and lands at 1060.
	let landing = |legs: &Value| -> f64 { legs.as_array().unwrap().iter().take(4).map(|l| num(&l[1])).sum() };
	assert!((landing(&out["before"]) - 1060.0).abs() <= 2.0, "planned: lands at {} s", landing(&out["before"]));
	assert_eq!(landing(&out["after"]), 1060.0, "retimed: the wait shrinks by the longer walk");
}

// #3369: a route with a flight is held until the walk from its landing into the target is checked
// (Travel.lua plan, waitForWalk). Meanwhile the arrow starts no walk straight to the target (in the game that
// search took the frames the check needed: 12 s and more), the router checks the landing first, and the route
// is offered as soon as that one price is in, while the batch goes on with the other places.
#[test]
fn a_held_flight_route_is_offered_once_its_landing_is_priced_and_the_arrow_never_searches_the_direct_walk_meanwhile() {
	let out = run_priced(
		r#"
		N.RegisterTravelData({ build = "test",
			taxi = {
				{ 1, 0, 900, 900, 9000, 5, 5, 3, "Home Roost, Testshire" },
				{ 2, 0, -700, 0, 9000, 50, 85, 3, "Dock Roost, Testshire" },
			},
			taxiZ = { [2] = 5.9 },
			flights = { 1, 2, 1700, 2, 1, 1700 },
		}, true)
		Polestar.CharState().flags.taxi = { [1] = true, [2] = true }
		local function kinds()
			local legs, ci = N.GetRoute()
			if not legs then return false end
			local out = {}
			for i = ci, #legs do out[#out + 1] = legs[i].kind end
			return table.concat(out, " ")
		end
		local r = {}
		nav.place(900, 800)
		local m, x, y = nav.mapPoint(-890, 10)
		N.SetTarget(m, x, y, "Pier")
		r.held = { (N.Sample()), kinds(), #fake.of(false) }
		local batch = assert(fake.of(true)[1], "the walks into the target are measured")
		local li
		for i, p in ipairs(batch.targets) do if p.first then li = i end end
		r.first = li and { batch.targets[li].x, batch.targets[li].y } or false
		-- The router's answer for the landing alone, published while the batch goes on (FindMany's progress).
		local one = finish({ many = true, map = batch.map, from = batch.from, targets = { batch.targets[li] }, opts = batch.opts,
			reverse = batch.reverse, callback = function() end })
		local partial = {}
		partial[li] = one.value[1]
		r.priced = type(partial[li]) == "number"
		batch.progress(partial, nil, batch)
		r.offered = kinds()
		N.Sample()
		local walk = fake.of(false)[1]
		r.arrow = walk and { walk.to.x, walk.to.y } or false
		assert(finish(walk).job.walkChecked)
		r.walking = (N.Sample())
		assert(finish(batch).job.walkChecked)
		r.after = kinds()
		emit(r)"#,
	);
	assert_eq!(out["held"], json!(["routing", false, 0]), "held for the landing's walk: no route and no walk straight to the target");
	assert_eq!(out["first"], json!([-700, 0]), "the landing is the batch's first search");
	assert_eq!(out["priced"], true);
	assert_eq!(out["offered"], "walk fly walk", "offered once the landing's walk is priced, the batch still running");
	assert_eq!(out["arrow"], json!([900, 900]), "the arrow walks to the flight master");
	assert_eq!(out["walking"], "travel");
	assert_eq!(out["after"], "walk fly walk", "the finished batch keeps the route");
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
		-- Take a taxi from Ridge to Home independently of the recommended walk.
		nav.place(0, 300)
		target(0, -200)
		N.Sample()
		local legs, ci = N.GetRoute()
		local r = { departure = legs[ci].kind }
		nav.taxi = true
		N.Refresh()
		nav.place(900, 900)
		local before = changes
		fake.settle(fake.of(true)[1], function(x, y)
			if at(x, y, 0, 300) then return 2000 end
			return math.floor(math.sqrt(x * x + (y + 200) ^ 2) * 1.1)
		end)
		N.Refresh()
		r.deferred = N.GetRoute() == legs and changes == before and not route().lands
		nav.taxi = false
		N.Refresh()
		r.landed = route()
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["departure"], "walk");
	assert_eq!(out["deferred"], true, "the checked price does not replace the route in the air");
	assert_eq!(out["landed"], json!({ "lands": "Road Roost, Testshire", "yards": 550, "seconds": 79, "engine": "cost" }));
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
		releaseCrossing(fake.of(true)[2])
		fake.answerWalk(900, 800, 900, 900)
		local leg = fake.walk(400, 300, 600, 20)
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
fn searches_carry_the_player_faction_and_an_unknown_faction_gets_the_straight_bearing() {
	let out = run_priced(
		&[
			TERRAIN,
			r#"
		local r = {}
		nav.faction = "Horde"
		nav.place(0, 0)
		target(0, -300)
		N.Sample()
		local job = fake.of(false)[1]
		r.horde = { job.profile or false, type(job.opts), job.waterWalking == true }
		assert(finish(job).job.walkChecked)
		r.hordeAim = aim()[1]
		nav.faction = "Neutral"
		target(0, -200)
		local function hud()
			local a = N.arrow
			a:Refresh()
			local mode, dist, angle, dn, dw = N.Sample()
			return { mode, dist ~= nil or angle ~= nil or dn ~= nil or dw ~= nil, a.GetMode(), a.dial:IsVisible(), a.distText:GetText() }
		end
		r.pending = hud()
		local refused = finish(fake.of(false)[2])
		r.reason = refused.job.blockedReason
		r.settled = hud()
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
	assert_eq!(out["pending"], json!(["routing", true, "routing", true, "Finding a walking route"]), "straight at the target meanwhile");
	assert_eq!(out["reason"], "unknown faction");
	// #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
	assert_eq!(out["settled"], json!(["travel", true, "travel", true, "200 yd"]));
	assert_eq!(out["batch"], "Alliance", "the planner's measure too");
}

// The arrow's hourglass follows the catch-up only: while it says "Finding a walking route" there is none (the
// arrow already points straight), the catch-up still brings it (the text hidden) and takes it away again.
#[test]
fn the_arrow_shows_no_hourglass_while_it_finds_a_walking_route_only_for_the_catch_up() {
	let out = run_priced(
		&[
			TERRAIN,
			r#"
		nav.faction = "Horde"
		nav.place(0, 0)
		target(0, -300)
		N.Sample()
		local a = N.arrow
		local function look()
			a:Refresh()
			local mode = N.Sample()
			return { mode, a.GetMode(), a.glass:IsShown(), a.IsBusy(), a.distText:GetText(), a.distText:GetAlpha() }
		end
		local r = {}
		r.routing = look()
		Polestar.Fire("CATCH_UP", true)
		r.catchUp = look()
		Polestar.Fire("CATCH_UP", false)
		r.after = look()
		assert(finish(fake.of(false)[1]).job.walkChecked)
		r.route = look()
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["routing"], json!(["routing", "routing", false, false, "Finding a walking route", 1]), "no hourglass in the routing wait");
	assert_eq!(out["catchUp"], json!(["routing", "routing", true, true, "Finding a walking route", 0]), "the catch-up brings it and hides the text");
	assert_eq!(out["after"], json!(["routing", "routing", false, false, "Finding a walking route", 1]), "and takes it away");
	assert_eq!(out["route"], json!(["travel", "travel", false, false, "300 yd", 1]));
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
		-- No walk straight to the target while the ticket waits for its onward price (#3369).
		assert(#fake.of(false) == 0)
		releaseCrossing(fake.of(true)[1])
		fake.answerWalk(900, 800, 900, 900)
		fake.answerWalk(400, 300, 500, 300, 600, 20)
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
		fake.settle(fake.of(true)[1], function(x, y)
			if at(x, y, 0, 300) then return 330 end
			return terrain(x, y)
		end)
		r.before = route()
		local seen = 0
		T.WalkCostHook(function(leg, cost)
			seen = seen + 1
			if at(leg.from.wx, leg.from.wy, 0, 300) and at(leg.to.wx, leg.to.wy, 0, 0) then return cost * 4 end
			if at(leg.from.wx, leg.from.wy, 0, -700) and at(leg.to.wx, leg.to.wy, 0, 0) then return cost * 0.9 end
			return cost
		end)
		T.Replan()
		r.after = route()
		r.seen = seen > 0
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["before"], json!({ "lands": "Ridge Roost, Testshire", "yards": 330, "seconds": 47, "engine": "cost" }));
	assert_eq!(out["after"], json!({ "lands": "Road Roost, Testshire", "yards": 750, "seconds": 107, "engine": "cost" }), "the hook changes the landing, not the chosen walk's measured yards or time");
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
		releaseCrossing(fake.of(true)[1])
		-- Reported names exercise the captions; they never authorize a segment.
		fake.hubs = { { id = 12, name = "Southshore" } }
		fake.answerWalk(900, 800, 900, 900)
		fake.hubs = { { id = 13, name = "Tarren Mill" } }
		fake.answerWalk(400, 300, 500, 300, 600, 20)
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
fn detours_a_walk_that_goes_round_a_hostile_town_carries_it_as_leg_hubs_avoided_text_for_the_journey_and_no_warning_from_the_arrow() {
	let out = run_many(
		&[
			CROSSING,
			r#"
		local r = {}
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		releaseCrossing(fake.of(true)[1])
		fake.avoided = { { id = 12, name = "Southshore" } }
		fake.answerWalk(900, 800, 870, 850, 900, 900)
		fake.avoided = nil
		local legs, ci = N.GetRoute()
		local leg = legs[ci]
		r.avoided = leg.hubs and leg.hubs.avoided and leg.hubs.avoided[1].name or false
		r.entered = leg.hubs and #leg.hubs or false
		r.hostile = T.HubText(leg) or false
		r.text = T.AvoidText(leg) or false
		r.noneElsewhere = legs[ci + 1].hubs == nil
		stub.advance(0.3)
		r.said = N.arrow.labelText:GetText()
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["avoided"], "Southshore", "the walk's leg carries the town it goes round");
	assert_eq!(out["entered"], 0, "it enters none");
	assert_eq!(out["hostile"], false, "so there is no hostile-town text");
	assert_eq!(out["text"], "Detour around Southshore");
	assert_eq!(out["noneElsewhere"], true, "a walk with no detour carries none");
	assert_eq!(out["said"], "Walk to the flight master", "the arrow says nothing of it: the caption is display only");
}

#[test]
fn detours_a_split_walk_shows_the_detour_on_the_one_piece_that_passes_the_town_every_piece_still_carries_the_towns_it_enters() {
	let out = run(&format!(
		"{}{}{}",
		r#"
		fake.hubs = { { id = 13, name = "Tarren Mill" } }
		fake.avoided = { { id = 12, name = "Southshore", x = 0, y = -300 } }
		"#,
		split(),
		r#"
		fake.hubs, fake.avoided = nil, nil
		local T = N.travel
		local legs, ci = N.GetRoute()
		local walks, shown, entered = 0, {}, 0
		for i = 1, #legs do
			if legs[i].kind == "walk" then
				walks = walks + 1
				if T.AvoidText(legs[i]) then shown[#shown + 1] = i end
				if T.HubText(legs[i]) then entered = entered + 1 end
			end
		end
		emit({ walks = walks, shown = shown, entered = entered, text = T.AvoidText(legs[shown[1] or 1]) or false, label = shown[1] and legs[shown[1]].label or false })"#
	));
	assert_eq!(out["walks"], 4, "the bridge, the cave, the lift's foot and the target");
	assert_eq!(out["shown"], json!([2]), "once, on the piece from the bridge to the cave mouth, which passes (0, -300)");
	assert_eq!(out["text"], "Detour around Southshore");
	assert_eq!(out["entered"], 4, "the town the path enters stays on every piece");
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
		releaseCrossing(fake.of(true)[1])
		fake.hubs = { { id = 12, name = "Southshore" } }
		fake.answerWalk(900, 800, 900, 900)
		local changes = 0
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		-- Stray, so the arrow searches again; back on the spot when the answer comes.
		nav.place(950, 850)
		N.Sample()
		stub.advance(3)
		N.Sample()
		local again = fake.walk(950, 850, 900, 900)
		nav.place(900, 800)
		fake.hubs = { { id = 12, name = "Southshore" } } -- the same towns, a new table
		fake.answerWalk(950, 850, 900, 800, 900, 900)
		local legs, ci = N.GetRoute()
		emit({ urgent = again.urgent == true, changes = changes, hubs = N.travel.HubText(legs[ci]) })"#,
		]
		.concat(),
	);
	assert_eq!(out["urgent"], true, "the arrow searched again from the stray position");
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
		releaseCrossing(fake.of(true)[1])
		fake.answerWalk(900, 800, 900, 900)
		r.aim = aim()[1]
		fake.answerWalk(400, 300, 500, 300, 600, 20)
		r.drawn = lines()[3]
		r.styles = styles(fake.calls)
		emit(r)"#
	));
	assert_eq!(out["styles"], json!(vec![["Sideways", "balanced"]; 4]), "the measure, flight-master walk, later walk and crossing all carry the saved style");
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
		releaseCrossing(fake.of(true)[1])
		fake.answerWalk(900, 800, 880, 850, 900, 900)
		fake.answerWalk(400, 300, 500, 300, 600, 20)
		local stale = fake.walk(600, 20, 600, -20)
		r.before = { lines = lines(), calls = #fake.calls }
		local seen, version = changes, T.version
		local calls = #fake.calls
		Polestar.Set("nav.routeStyle", "roads")
		r.replanned = { changed = changes > seen, version = T.version > version }
		r.pending = { N.GetRoute() == nil, #lines(), stale.cancelled == true }
		N.Sample()
		local batch = fake.of(true)[2]
		local direct = #fake.of(false)
		local own = releaseCrossing(batch)
		r.asked = { #fake.calls - calls, batch.opts.style, own.opts.style, #fake.of(false) - direct }
		fake.answerWalk(900, 800, 880, 850, 900, 900)
		local leg = fake.walk(400, 300, 600, 20)
		r.leg = { leg.opts.style, floor(leg.from.x), floor(leg.from.y), floor(leg.to.x), floor(leg.to.y) }
		r.straight = lines()[3]
		fake.answerWalk(400, 300, 450, 250, 600, 20)
		r.after = lines()
		local before = #fake.calls
		Polestar.Set("nav.routeStyle", "roads")
		r.same = #fake.calls - before
		emit(r)"#
	));
	assert_eq!(head(&out["before"]["lines"], 3), json!([["walk", 3], ["flight", 2], ["walk", 3]]), "Balanced: the arrow's walk and the later walk drawn along their paths");
	assert_eq!(out["replanned"], json!({ "changed": true, "version": true }), "re-planned at once");
	assert_eq!(out["pending"], json!([true, 0, true]), "the old ticket and lines are gone; the crossing search is cancelled");
	assert_eq!(out["asked"], json!([2, "roads", "roads", 1]), "the new measure, then the flight-master walk (no walk straight to the target), both in Roads");
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

/// #1490: a zone with a danger floor (Maps.GetZoneLevels' third value: Alterac Mountains, P10 24, floor 30) is
/// priced from the floor: dangerous from 26 down, far above under 20; the zones without one from their P10.
#[test]
fn zone_danger_a_zone_s_danger_floor_prices_it_alterac_at_24_with_floor_30_is_dangerous_from_26_down() {
	let out = run_many(
		&[
			DANGER,
			r#"
		local levels = { [9001] = { 24, 39, 30 }, [9002] = { 24, 39 } }
		Polestar.Maps.GetZoneLevels = function(id) local v = id and levels[id] if v then return v[1], v[2], v[3] or v[1] end end
		emit({
			floor = { D.Mult(27, 9001), D.Mult(26, 9001), D.Mult(21, 9001), D.Mult(20, 9001), D.Mult(19, 9001) },
			plain = { D.Mult(21, 9002), D.Mult(20, 9002), D.Mult(13, 9002) },
		})"#,
		]
		.concat(),
	);
	assert_eq!(out["floor"], json!([1, 3, 3, 3, 20]), "30 >= L + 4 from 26 down, > L + 10 under 20");
	assert_eq!(out["plain"], json!([1, 3, 20]), "without a floor its lowest level, 24, as before");
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
		local batch = fake.of(true)[1]
		local own = releaseCrossing(batch)
		r.batch, r.own = dz(batch), dz(own)
		fake.answerWalk(900, 800, 900, 900)
		local leg = fake.walk(400, 300, 600, 20)
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
		releaseCrossing(fake.of(true)[1])
		fake.answerWalk(900, 800, 880, 850, 900, 900)
		local firstLeg = fake.walk(400, 300, 600, 20)
		fake.answerWalk(400, 300, 500, 300, 600, 20)
		local stale = fake.walk(600, 20, 600, -20)
		r.before = { lines = lines(), danger = dz(firstLeg) }
		local seen, version, calls = changes, T.version, #fake.calls
		-- PLAYER_LEVEL_UP's level stands while the client's still reads 20 (UnitLevel lags the event).
		stub.fire("PLAYER_LEVEL_UP", 27)
		r.replanned = { changed = changes > seen, version = T.version > version }
		r.pending = { N.GetRoute() == nil, #lines(), stale.cancelled == true }
		N.Sample()
		local batch = fake.of(true)[2]
		local direct = #fake.of(false)
		local own = releaseCrossing(batch)
		r.asked = { #fake.calls - calls, dz(batch), dz(own), #fake.of(false) - direct }
		fake.answerWalk(900, 800, 880, 850, 900, 900)
		local leg = fake.walk(400, 300, 600, 20)
		r.leg = { dz(leg), floor(leg.from.x), floor(leg.from.y), floor(leg.to.x), floor(leg.to.y) }
		fake.answerWalk(400, 300, 450, 250, 600, 20)
		r.after = lines()
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(head(&out["before"]["lines"], 3), json!([["walk", 3], ["flight", 2], ["walk", 3]]), "at 20: the walks drawn along their paths");
	assert_eq!(out["before"]["danger"], "1416=3,1422=20");
	assert_eq!(out["replanned"], json!({ "changed": true, "version": true }), "re-planned at once");
	assert_eq!(out["pending"], json!([true, 0, true]), "no stale lines or ticket after the level change");
	assert_eq!(out["asked"], json!([2, "1422=20", "1422=20", 1]), "the new measure and the arrow's walk use level 27 (no walk straight to the target)");
	assert_eq!(out["leg"], json!(["1422=20", 400, 300, 600, 20]), "the later walk searched again at 27");
	assert_eq!(head(&out["after"], 3), json!([["walk", 3], ["flight", 2], ["walk", 3]]), "drawn along the new paths");
}

// The planner's straight estimates (Nav/Danger.lua Danger.Along, Nav/Travel.lua):
// the zone every 100 yd along a straight walk (the middle of each 100 yd
// piece), its share in a dangerous zone x3, in a far-above one x20; the
// zones of its own two ends count like any other (#566: a walk between two
// crossings inside Western Plaguelands); the table leaves out the player's and
// the target's.
#[test]
fn zone_danger_danger_along_samples_a_straight_line_every_100_yd_its_ends_zones_counting_too_without_a_table_path_zoneat_or_length_it_is_1() {
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
		r.ends = D.Along({ [1421] = 20, [1422] = 20, [1424] = 20 }, 0, 0, 0, 1200, 0)
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
	assert_eq!(out["ends"], 20.0, "the zones of its two ends count too (#566)");
	assert_eq!(json!([out["again"], out["asked"], out["askedAgain"]]), json!([10.5, 12, 12]), "its 12 samples asked once; the same line again asks nothing");
	assert!((out["fromInside"].as_f64().unwrap() - (5.0 * 20.0 + 7.0) / 12.0).abs() < 1e-9, "a line from inside the far-above zone: its 5 samples there count (#566): {}", out["fromInside"]);
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
		nav.addGround(0, 1, -1, 1201, -1)
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

// #1650: off a ledge's edge onto cells with no surface at the floor's level (a blocked cell at a cliff's foot, then
// cells whose only surface is a ridge 35 yd above), the floor is kept within 25 yd of where it was last on a
// surface, so the search starts on the ledge, not on the ridge the router snaps to without a height. Farther on the
// ridge's cells the floor is lost and seeds on the ridge; back down, it follows the drop to the ledge.
#[test]
fn t_1650_floor_kept_over_cells_with_no_surface_at_its_level_within_25_yd_of_the_last_one_farther_lost_and_seeded_again() {
	let out = run(&[
		FLOORS,
		r#"
		local r = {}
		fake.surfaces = function(map, x, y)
			if y <= -20 and y > -24 then return {} end
			if y <= -24 then return { 75 } end
			return { 40 }
		end
		nav.place(0, 50)
		r.seed = startZ()
		walk(0, -22)
		r.blocked = startZ()
		walk(0, -40)
		r.ridgeNear = startZ()
		walk(0, -60)
		r.ridgeFar = startZ()
		walk(0, 0)
		r.back = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out, json!({ "seed": 40, "blocked": 40, "ridgeNear": 40, "ridgeFar": 75, "back": 40 }));
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
fn t_234_floor_a_goal_s_height_off_its_floor_stands_a_tracked_start_that_finds_nothing_is_dropped_keeping_the_goal_s_height() {
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
		-- Found, but its last engine point stands 100 yd above the goal: it stands (WorldFloor), no search again.
		local job, pts = fake.last(), {}
		for i, p in ipairs({ { 0, 50, 40 }, { -400, 450, 34 }, { -500, 500, -66 } }) do pts[i] = { map = job.map, x = p[1], y = p[2], z = p[3] } end
		local n = calls()
		job.callback(pts, 100, job)
		r.offFloor = { calls() - n, (N.walk.Unmapped()) }
		N.SetTarget(m, x, y, "Trainer 2", nil, "trainer", -60)
		N.Sample()
		fake.fail("unreachable")
		r.startFailed = ask()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["first"], json!([40, -66]));
	assert_eq!(out["offFloor"], json!([0, true]), "off the goal's floor: the walk stands, said");
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

// Reaperwest in the Apothecarium on a Spanish (Latin America) client (#2244): the client names the subzone in its
// own language ("El Apothecarium") and the walking maps name their areas in English, so on every other language no
// floor matched and the walk started from a floor above. The language folder's Subzones.lua (`forge data
// subzones`) names each area as that language's client does; a row it does not name is named as in English. The
// rows and names are the Undercity's, as the Forever client's tables give them.
const UNDERCITY: &str = r#"
nav.indoors = true
SUB = ""
Polestar.Compat.GetZoneText = function() return "Undercity", SUB ~= "" and SUB or nil end
-- The Apothecarium's floor, the canal ring's walkway over it, the Ruins' hall, and a row the language folder does
-- not name (its name in that language is the English one).
fake.areaNames = { [141154] = "The Apothecarium", [141153] = "Canals", [141070] = "Ruins of Lordaeron", [9001] = "Bandit Hideout" }
fake.surfaces = function() return { -85, -64, 62, 80, [-1] = 2, [-2] = 2, [-3] = 2, [-4] = 2, area = { 141154, 141153, 141070, 9001 } } end
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
"#;

/// `script` on a client in `locale` whose language folder names the Undercity's rows (the Apothecarium, Canals,
/// Ruins of Lordaeron) `names`, with Core/Names.lua in; the script loads the folder (Core/Locale.lua at startup).
fn run_in(locale: &str, names: [&str; 3], script: &str) -> Value {
	let pack = language_pack(locale, &[], &[(141154, names[0]), (141153, names[1]), (141070, names[2])]);
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		before: format!("{ENGINE}\nfunction GetLocale() return {} end\n{}", lua_string(locale), pack.stub_lua),
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Core/LuaChunks.lua", "Core/Names.lua", "Nav/Nav.xml"])],
		login: true,
		script: format!("{PRELUDE}\n{FLOORS}\n{UNDERCITY}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

/// On a client in `locale` whose folder names the Apothecarium, Canals and Ruins of Lordaeron `names`: the floor each
/// subzone in that language names at once, the English name of a translated row naming none, a row the folder does
/// not name by its English name.
fn floors_named_in(locale: &str, names: [&str; 3]) {
	let out = run_in(
		locale,
		names,
		&format!(
			r#"
			C_AddOns.LoadAddOn(Polestar.Names.PackName())
			local r = {{}}
			r.apothecarium = fresh({})
			r.canal = fresh({})
			r.ruins = fresh({})
			r.english = fresh("The Apothecarium")
			r.same = fresh("Bandit Hideout")
			r.none = fresh("")
			emit(r)"#,
			lua_string(names[0]),
			lua_string(names[1]),
			lua_string(names[2])
		),
	);
	assert_eq!(out["apothecarium"], -85, "{locale}: the Apothecarium's floor at once");
	assert_eq!(out["canal"], -64, "{locale}: the canal ring's walkway");
	assert_eq!(out["ruins"], 62, "{locale}: the Ruins' hall");
	assert_eq!(out["english"], "none", "{locale}: a row named in this language is no longer named in English");
	assert_eq!(out["same"], 80, "{locale}: a row the folder does not name keeps its English name");
	assert_eq!(out["none"], "none", "{locale}: no subzone: unknown");
}

#[test]
fn t_2244_floor_on_a_spanish_latin_america_client_its_subzone_names_the_floor() {
	floors_named_in("esMX", ["El Apothecarium", "Canales", "Ruinas de Lordaeron"]);
}

#[test]
fn t_2244_floor_on_a_german_client_its_subzone_names_the_floor() {
	floors_named_in("deDE", ["Das Apothekarium", "Die Kanäle", "Die Ruinen von Lordaeron"]);
}

#[test]
fn t_2244_floor_on_a_russian_client_its_subzone_names_the_floor() {
	floors_named_in("ruRU", ["Квартал аптекарей", "Каналы", "Руины Лордерона"]);
}

#[test]
fn t_2244_floor_on_a_simplified_chinese_client_its_subzone_names_the_floor() {
	floors_named_in("zhCN", ["炼金房", "运河", "洛丹伦废墟"]);
}

#[test]
fn t_2244_floor_the_language_folder_refused_in_combat_leaves_the_floor_to_movement_until_it_loads_never_keeping_the_english_names() {
	let out = run_in(
		"esMX",
		["El Apothecarium", "Canales", "Ruinas de Lordaeron"],
		r#"
		Polestar.Data = { Pack = function() return false, "combat" end }
		local r = {}
		r.pending = fresh("El Apothecarium")
		Polestar.Data.Pack = function(name) return C_AddOns.LoadAddOn(name) end
		stub.fire("PLAYER_REGEN_ENABLED")
		r.loaded = fresh("El Apothecarium")
		emit(r)"#,
	);
	assert_eq!(out["pending"], "none", "the folder not in: the rows' English names, no match");
	assert_eq!(out["loaded"], -85, "once it is in, its names: the English ones read meanwhile were not kept");
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

// The arrow's corridor (Nav/Follow.lua: PAD 20, CORNER_PAD 10, TURN 60°, AHEAD 45):
// a road's wiggles up to 20 yd to the side stay inside it, so the arrow points
// down the road; the wider look-ahead keeps it from going sideways on an offset
// path; a real corner or a switchback (the path turning more than 60° from the
// line to the aim) still stops it at the corner.

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
fn a4_switchback_with_legs_15_yd_apart_keeps_the_arrow_on_the_near_leg() {
	// Player at (70,0) near end of leg1 (x=0..100,y=0); leg2 is at y=-15.
	// Within PAD (20) the corridor alone would span to leg2; the turn down to it
	// (63° from the line to the aim) makes it a corner, so the aim cuts inside by
	// CORNER_PAD at most and stays near leg1.
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

// Fitz, 2026-11-03: the arrow felt tight, swinging at every bend of a road. A
// bend 13 yd to the side and back is a wiggle: the arrow points on down the
// road past it, 35 yd out (with PAD 12 it stopped at the bend and pointed aside).
#[test]
fn a5_a_road_bending_13_yd_aside_and_back_keeps_the_arrow_pointing_down_the_road() {
	let out = run(r#"
		local r = {}
		nav.place(0, 0)
		target(80, 0)
		aim()
		fake.resolve(0,0, 8,0, 20,13, 32,0, 80,0)
		r.aim = aim()
		emit(r)"#);
	assert_eq!(out["aim"][0], "travel");
	assert!(num(&out["aim"][2]) >= 33.0, "aim_x {} should be past the bend (≥33), not held at it", out["aim"][2]);
	assert!(num(&out["aim"][3]).abs() <= 3.0, "aim_y {} should be back on the road (|y| ≤ 3)", out["aim"][3]);
}

// Fitz, 2026-11-03: walking 12 yd beside a straight path, the arrow points
// along it from where he is (the body), not back to the line: the aim is
// carried sideways by his offset.
#[test]
fn a6_walking_12_yd_beside_a_straight_path_the_arrow_points_along_it_not_back_to_it() {
	let out = run(r#"
		local r = {}
		nav.place(50, 12)
		target(200, 0)
		aim()
		fake.resolve(0,0, 40,0, 80,0, 120,0, 160,0, 200,0)
		r.aim = aim()
		emit(r)"#);
	assert_eq!(out["aim"][0], "travel");
	assert!(num(&out["aim"][2]) > 70.0, "aim_x {} should be well ahead", out["aim"][2]);
	assert!((num(&out["aim"][3]) - 12.0).abs() <= 1.0, "aim_y {} should stay at his 12 yd offset (parallel to the path)", out["aim"][3]);
}

// Fitz, 2026-11-03 (the Barrens, the road just east of him): a path searched
// from where he stood ran 20 yd east to the road, then south along it, and the
// arrow held him to that join. Outdoors the first turn near the path's start is
// joining the road: the arrow aims on down the road, so he merges at an angle.
#[test]
fn a7_outdoors_the_turn_onto_the_road_near_the_path_start_is_cut_the_arrow_aims_down_the_road() {
	let out = run(r#"
		local r = {}
		nav.place(0, 0)
		target(20, -200)
		aim()
		fake.resolve(0,0, 20,0, 20,-40, 20,-80, 20,-120, 20,-160, 20,-200)
		r.aim = aim()
		emit(r)"#);
	assert_eq!(out["aim"][0], "travel");
	assert!(num(&out["aim"][3]) <= -20.0, "aim_y {} should be down the road (≤ -20), not the join at (20, 0)", out["aim"][3]);
}

// Fitz, 2026-11-07 (0.3.4, Tirisfal, running to the "At War With The Scarlet Crusade" turn-in): running up a hillside
// beside the path, the arrow pointed 90° back to it while the trail and the target lay ahead and to his right.
// Nav/Follow.lua's sight: outdoors, with the floor under the player known (fake.surfaces), a player more than 15 and
// at most 100 yd off the path aims at the furthest point ahead on it they can walk to in a straight line
// (fake.sight stands in for Path.Sight, the walking grid's line check), and asks for no new path meanwhile. RUN walks
// the player down -y at x from y0 to y1 a yard at a time, 0.3 s apart (the floor is read every 0.25 s): the largest
// turn toward the path (x 0; degrees from straight ahead), each aim { x, y, aim x, aim y }, the yards shown at each
// sample, and the searches asked.
const RUN: &str = r#"
fake.surfaces = function() return { 0 } end
local function run(x, y0, y1)
	local worst, asked, aims, yards = -180, #fake.calls, {}, {}
	for y = y0, y1, -1 do
		nav.place(x, y)
		stub.advance(0.3)
		local _, dist, _, dn, dw = N.Sample()
		if dn then
			local deg = math.deg(math.atan2(x > 0 and -dn or dn, -dw))
			if deg > worst then worst = deg end
			aims[#aims + 1] = { x, y, x + dn, y + dw }
			yards[#yards + 1] = dist
		end
	end
	return { worst = worst, asked = #fake.calls - asked, aims = aims, yards = yards }
end
-- A straight path down -y from (0, 0) to (0, -400), a point every 40 yd; the target at its end.
local function straight(px, py)
	nav.place(px, py)
	target(0, -400)
	N.Sample()
	fake.resolve(0,0, 0,-40, 0,-80, 0,-120, 0,-160, 0,-200, 0,-240, 0,-280, 0,-320, 0,-360, 0,-400)
end
"#;

fn aims(out: &Value) -> Vec<[f64; 4]> {
	out["aims"].as_array().unwrap().iter().map(|a| [num(&a[0]), num(&a[1]), num(&a[2]), num(&a[3])]).collect()
}

#[test]
fn a8_running_20_to_90_yd_beside_the_path_in_open_ground_the_arrow_never_turns_more_than_45_degrees_back_to_it_and_asks_no_new_path() {
	for d in [20, 30, 40, 60, 90] {
		let out = run(&format!(
			r#"{RUN}
		fake.sight = function() return true end
		straight({d}, 0)
		fake.sights = 0
		local r = run({d}, 0, -200)
		r.sights = fake.sights
		emit(r)"#
		));
		let worst = num(&out["worst"]);
		assert!(worst <= 45.0, "{d} yd beside the path: the arrow turns {worst:.1}° back to it");
		assert_eq!(out["asked"], 0, "{d} yd beside it in open ground: no new path");
		assert!(num(&out["sights"]) <= 110.0, "{d} yd: about one line read per 2 yd run ({})", out["sights"]);
	}
	// Past 100 yd the corridor holds as before: a new path from where the player is.
	let far = run(&[RUN, "\n\t\tfake.sight = function() return true end\n\t\tstraight(120, 0)\n\t\temit(run(120, 0, -20))"].concat());
	assert!(num(&far["asked"]) >= 1.0, "120 yd off: asked again ({})", far["asked"]);
}

// The screenshot's other half: a path searched again from 40 yd beside the road (roads cost less) runs straight
// across to it, then down it; the arrow held him to that first piece (RADIUS 35 stopped the aim on it, so the road
// join could not be cut) and pointed 90° left while he ran on. It aims down the road, and nothing is asked again.
#[test]
fn a8_a_path_searched_again_from_40_yd_beside_the_road_runs_across_to_it_first_the_arrow_aims_down_the_road_not_across() {
	let out = run(&[
		RUN,
		r#"
		fake.sight = function() return true end
		nav.place(40, -100)
		target(0, -400)
		N.Sample()
		fake.resolve(40,-100, 0,-100, 0,-150, 0,-200, 0,-250, 0,-300, 0,-350, 0,-400)
		emit(run(40, -100, -140))"#,
	]
	.concat());
	let worst = num(&out["worst"]);
	assert!(worst <= 45.0, "the arrow turns {worst:.1}° toward the road");
	assert_eq!(out["asked"], 0, "no new path while the road ahead is in sight");
}

// A cliff between the player and the path (x 15, the whole way): no line from below it reaches the path, so the
// corridor holds as before: the arrow turns back to the path and, past 25 yd off it, a new path is asked for.
#[test]
fn a9_beside_the_path_below_a_cliff_the_arrow_stays_tight_back_to_the_path_and_a_new_path_is_asked_for() {
	let out = run(&[
		RUN,
		r#"
		fake.sight = function(x1, y1, z1, x2, y2) return (x1 - 15) * (x2 - 15) > 0 end
		straight(30, 0)
		emit(run(30, 0, -60))"#,
	]
	.concat());
	let worst = num(&out["worst"]);
	assert!(worst > 45.0, "below the cliff the arrow turns back to the path ({worst:.1}°), as before");
	assert!(num(&out["asked"]) >= 1.0, "30 yd off with nothing in sight: asked again ({})", out["asked"]);
}

// A river (y -100 to -140) crossed by a bridge (x 0): beside the road on the near bank, 30 yd from it, the arrow
// aims at the bridge's near end at the most, never across the water to the bridge or the far bank.
#[test]
fn a10_beside_the_road_to_a_bridge_the_arrow_aims_at_the_bridge_head_never_across_the_river() {
	let out = run(&[
		RUN,
		r#"
		-- A line that enters the river is clear only on the bridge.
		fake.sight = function(x1, y1, z1, x2, y2)
			local wet = math.min(y1, y2) < -100 and math.max(y1, y2) > -140
			return not wet or (math.abs(x1) <= 3 and math.abs(x2) <= 3)
		end
		nav.place(30, 0)
		target(0, -300)
		N.Sample()
		fake.resolve(0,0, 0,-40, 0,-80, 0,-100, 0,-140, 0,-180, 0,-220, 0,-260, 0,-300)
		emit(run(30, 0, -95))"#,
	]
	.concat());
	let all = aims(&out);
	for [x, y, ax, ay] in &all {
		assert!(*ay >= -100.01, "at ({x}, {y}) the arrow aims across the river at ({ax:.1}, {ay:.1})");
	}
	let [_, _, ax, ay] = *all.last().unwrap();
	assert!(ax.hypot(ay + 100.0) <= 1.0, "on the bank beside it: at the bridge head ({ax:.1}, {ay:.1})");
	assert_eq!(out["asked"], 0, "the bridge head in sight: no new path");
}

// A building (x -20 to 20, y -100 to -140) entered by its door at (0, -100), the target inside: running past it
// 30 yd to the side, the arrow aims at the door at the most, never through a wall or into the room behind it
// (Path.Sight refuses indoor ground; the threshold at y -100 is outside).
#[test]
fn a11_beside_the_path_into_a_building_the_arrow_aims_at_the_door_never_through_a_wall() {
	let out = run(&[
		RUN,
		r#"
		-- A line ending inside (indoor ground) or crossing the walls is never clear.
		fake.sight = function(x1, y1, z1, x2, y2)
			return not (y2 < -100 and y2 > -140 and x2 > -20 and x2 < 20)
		end
		nav.place(30, 0)
		target(-12, -125)
		N.Sample()
		fake.resolve(0,0, 0,-40, 0,-80, 0,-100, 0,-125, -12,-125)
		emit(run(30, 0, -90))"#,
	]
	.concat());
	let all = aims(&out);
	for [x, y, ax, ay] in &all {
		let inside = *ay < -100.01 && ax.abs() < 20.0;
		assert!(!inside, "at ({x}, {y}) the arrow aims through the wall at ({ax:.1}, {ay:.1})");
	}
	let [_, _, ax, ay] = *all.last().unwrap();
	assert!(ax.hypot(ay + 100.0) <= 2.0, "30 yd beside the door: at the door ({ax:.1}, {ay:.1})");
}

// The largest step back along the path (yards north: the path runs down -y) between one aim and the next.
fn back_step(all: &[[f64; 4]]) -> f64 {
	all.windows(2).map(|w| w[1][3] - w[0][3]).fold(0.0, f64::max)
}

// The walk out of Goldshire on the real maps (nav-e2e c): on the path within its first 50 yd (the road's join), the
// walking grid closed the long lines now and then (a lamp post, a fence post), and the arrow swung from the
// corridor's aim ahead back to a point in sight a few yards on. Here the lines longer than 12 yd are closed on every
// other 6 yd of the walk: the aim never moves back along the path.
#[test]
fn a12_on_the_path_near_its_start_a_short_point_in_sight_never_pulls_the_aim_back_behind_the_corridors() {
	let out = run(&[
		RUN,
		r#"
		fake.sight = function(x1, y1, z1, x2, y2) return math.abs(y2 - y1) <= 12 or math.floor(-y1 / 6) % 2 == 0 end
		straight(0, 0)
		emit(run(0, 0, -45))"#,
	]
	.concat());
	let all = aims(&out);
	let back = back_step(&all);
	assert!(back <= 1e-6, "the aim went {back:.1} yd back along the path");
	assert_eq!(out["asked"], 0);
}

// Beside the path, a step the grid closes for a few yards (a fence post between the player and the path) no longer
// drops the aim from the point in sight to the corridor's, 18 yd ahead instead of 150: the point last seen stays the
// aim until it is seen again (or SIGHT_HOLD yards on).
#[test]
fn a13_beside_the_path_a_line_closed_for_a_few_yards_holds_the_point_last_seen_the_aim_never_swings_back() {
	let out = run(&[
		RUN,
		r#"
		fake.sight = function(x1, y1) return not (y1 <= -50 and y1 > -55) end
		straight(30, 0)
		emit(run(30, 0, -80))"#,
	]
	.concat());
	let all = aims(&out);
	let back = back_step(&all);
	assert!(back <= 1e-6, "the aim went {back:.1} yd back along the path");
	let worst = num(&out["worst"]);
	assert!(worst <= 45.0, "the arrow turns {worst:.1}° back to the path");
	assert_eq!(out["asked"], 0, "no new path meanwhile");
}

// A player following the arrow beside a path with a bend (0.3.6; Discord after 0.3.5: "facing the wrong direction 90%
// of the time and just rotates randomly"): east 50 yd, up and over an 80 yd hump, down and east to the target at
// (300, 0), every line in sight. Following the point in sight brings them back toward the path's climb; 0.3.5 looked
// for it only while they were more than 15 yd off (BODY), so a player wobbling across 15 yd flipped the arrow 37-57°
// between it and the corridor's aim, again and again. WOBBLE walks them a yard at a time toward the aim, 0.3 s apart,
// pushed j yd to a side drawn from a fixed seed (Park-Miller): the largest change of aim between two samples
// (degrees), how many were over 30°, the yards shown at each sample, and the searches asked.
const WOBBLE: &str = r#"
fake.surfaces = function() return { 0 } end
fake.sight = function() return true end
local function wobble(j)
	nav.place(0, 0)
	target(300, 0)
	N.Sample()
	fake.resolve(0,0, 50,0, 100,80, 200,80, 250,0, 300,0)
	local asked, seed, x, y, last, worst, swings, yards = #fake.calls, 7, 0, 0, nil, 0, 0, {}
	for _ = 1, 400 do
		nav.place(x, y)
		stub.advance(0.3)
		local state, dist, _, dn, dw = N.Sample()
		if state ~= "travel" or not dn or dist < 15 then break end
		yards[#yards + 1] = dist
		local a = math.deg(math.atan2(dw, dn))
		if last then
			local swing = math.abs((a - last + 540) % 360 - 180)
			if swing > worst then worst = swing end
			if swing > 30 then swings = swings + 1 end
		end
		last = a
		local d = math.sqrt(dn * dn + dw * dw)
		local ux, uy = dn / d, dw / d
		seed = (seed * 16807) % 2147483647
		local side = j * (2 * seed / 2147483647 - 1)
		x, y = x + ux - side * uy, y + uy + side * ux
	end
	return { worst = worst, swings = swings, yards = yards, asked = #fake.calls - asked }
end
"#;

#[test]
fn a14_following_the_arrow_back_toward_the_path_with_a_wobble_the_arrow_never_flips_between_the_point_in_sight_and_the_corridor() {
	for j in ["0", "0.5", "1"] {
		let out = run(&format!("{WOBBLE}\n\t\temit(wobble({j}))"));
		let worst = num(&out["worst"]);
		assert!(worst <= 30.0, "wobble {j} yd: the arrow swings {worst:.1}° between two samples ({} times over 30°)", out["swings"]);
		assert!(out["yards"].as_array().unwrap().len() > 100, "wobble {j} yd: the walk ran ({:?} samples)", out["yards"]);
	}
}

// The most the yards shown ever stood above the lowest shown before them: the yards counting up while the player
// closes on the target.
fn counted_up(out: &Value) -> f64 {
	let mut least = f64::INFINITY;
	let mut up: f64 = 0.0;
	for y in out["yards"].as_array().unwrap().iter().map(num) {
		least = least.min(y);
		up = up.max(y - least);
	}
	up
}

// Discord after 0.3.5: "it also counts up yds instead of counting down sometimes when approaching a destination".
// Running beside the path with a point ahead in sight, the arrow aims at that point and nothing is searched again
// (#1107), but the yards went straight to the end of the segment the player projects onto, which can lie behind
// them (the road's join), then along the path: on #1107's own walk (a8's second) they rose 17 yd over 40 yd run
// toward the target. They now go the way the arrow points: straight to the point in sight, then along the path.
#[test]
fn a15_beside_the_road_with_a_point_ahead_in_sight_the_yards_count_down_as_the_player_runs_toward_the_target() {
	let out = run(&[
		RUN,
		r#"
		fake.sight = function() return true end
		nav.place(40, -100)
		target(0, -400)
		N.Sample()
		fake.resolve(40,-100, 0,-100, 0,-150, 0,-200, 0,-250, 0,-300, 0,-350, 0,-400)
		emit(run(40, -100, -160))"#,
	]
	.concat());
	let up = counted_up(&out);
	assert!(up <= 1.0, "the yards counted up {up:.1} yd while the player ran 60 yd toward the target");
	assert_eq!(out["asked"], 0, "no new path while the road ahead is in sight (#1107)");
}

// Straight at the target past a path that bulges 80 yd to the side (east 80 yd, 100 yd down, back): the arrow aims
// across at a point in sight on the bulge, and the yards shown never rise as the player closes on the target (0.3.5:
// 14 yd up while the path swung away), the switch back to the path's own aim included.
#[test]
fn a15_running_straight_at_the_target_past_a_bulge_in_the_path_the_yards_never_count_up() {
	let out = run(&[
		RUN,
		r#"
		fake.sight = function() return true end
		nav.place(0, -20)
		target(0, -300)
		N.Sample()
		fake.resolve(0,0, 0,-20, 80,-60, 80,-160, 0,-200, 0,-300)
		emit(run(0, -20, -190))"#,
	]
	.concat());
	let up = counted_up(&out);
	assert!(up <= 1.0, "the yards counted up {up:.1} yd while the player ran straight at the target");
}

// a14's walk (following the arrow over the hump with a wobble): the yards never count up, through every switch
// between the point in sight and the corridor's aim.
#[test]
fn a15_following_the_arrow_over_a_bend_with_a_wobble_the_yards_never_count_up() {
	for j in ["0", "0.5", "1"] {
		let out = run(&format!("{WOBBLE}\n\t\temit(wobble({j}))"));
		let up = counted_up(&out);
		assert!(up <= 1.0, "wobble {j} yd: the yards counted up {up:.1} yd");
	}
}

// #1543's near walk over a closed zone border, probed first (Walk.Probe, Travel.NearWalk). The target 200 yd east of
// the player in West Vale, over its border with East Vale; the gate 1100 yd north.
const NEAR: &str = r#"
local T = N.travel
N.RegisterCrossings({ complete = true,
	zones = {
		[9002] = { name = "West Vale", c = 0, top = 1000, bottom = -1000, left = 1000, right = 0 },
		[9003] = { name = "East Vale", c = 0, top = 1000, bottom = -1000, left = 0, right = -1000 },
	},
	crossings = { { id = "gate", a = { map = 9002, c = 0, wx = 600, wy = 20, r = 15 }, b = { map = 9003, c = 0, wx = 600, wy = -20, r = 15 },
		ab = "Through the gate to East Vale" } } })
local function route()
	local legs, ci = N.GetRoute()
	local out = {}
	for i = ci or 1, legs and #legs or 0 do out[#out + 1] = legs[i].kind .. "|" .. legs[i].label end
	return out
end
-- Every field of a value, nested tables included (keys sorted, five levels deep), as one string.
local function dump(v, depth)
	if type(v) ~= "table" then return tostring(v) end
	depth = depth or 0
	if depth > 4 then return "{...}" end
	local keys = {}
	for k in pairs(v) do keys[#keys + 1] = k end
	table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
	local out = {}
	for i, k in ipairs(keys) do out[i] = tostring(k) .. "=" .. dump(v[k], depth + 1) end
	return "{" .. table.concat(out, ",") .. "}"
end
-- The engine's latest search for the near walk: to the target, not the arrow's own (urgent).
local function probe()
	for i = #fake.calls, 1, -1 do
		local job = fake.calls[i]
		if not job.urgent and job.to and floor(job.to.x + 0.5) == -500 and floor(job.to.y + 0.5) == -100 then return job end
	end
end
-- From (-500, 100) to `label` at (-500, -100): the route's legs, every field of them, and the route's version.
local function start(label)
	N.ClearTarget()
	nav.place(-500, 100)
	target(-500, -100, label)
	aim()
	local legs = N.GetRoute()
	return legs, dump(legs), T.version
end
local SHORT = { -500, 100, -520, 0, -500, -100 }                -- 204 yd
local LONG = { -500, 100, 600, 20, 600, -20, -500, -100 }       -- round by the gate, 2246 yd
"#;

// The plan is the gate's way while the engine is asked, apart from the arrow's own search, for the walk to the target.
// A short path plans the near walk, one leg, which later plans keep, out to 700 yd from the target (where the planner
// alone would take the gate); a long one or none changes nothing (the same legs, untouched, no new route), and later
// plans keep the gate's way.
#[test]
fn the_near_walk_over_a_closed_zone_border_is_planned_only_once_the_engine_finds_it_short_1543() {
	let out = run(&format!(
		"{NEAR}{}",
		r#"
		local function try(label, answer)
			local legs, before, version = start(label)
			local res = { planned = route(), probed = probe() ~= nil }
			answer(probe())
			aim()
			local after = N.GetRoute()
			res.after = route()
			res.untouched = rawequal(after, legs) and dump(after) == before and T.version == version
			T.Replan()
			res.again = route()
			return res
		end
		local r = {}
		r.short = try("Short", function(job) fake.answerXY(job, SHORT) end)
		nav.place(-500, 450)
		T.Replan()
		r.hold = route()
		r.long = try("Long", function(job) fake.answerXY(job, LONG) end)
		r.none = try("None", function(job) job.callback(nil, "unreachable", job) end)
		emit(r)"#
	));
	let gate = |label: &str| json!(["walk|Through the gate to East Vale", "walk|Through the gate to East Vale", format!("walk|{label}")]);
	assert_eq!(out["short"]["planned"], gate("Short"), "planned the gate's way");
	assert_eq!(out["short"]["probed"], true, "the engine is asked for the walk to the target");
	assert_eq!(out["short"]["after"], json!(["walk|Short"]), "a 204 yd path: the near walk, one leg");
	assert_eq!(out["short"]["again"], json!(["walk|Short"]), "and planned again");
	assert_eq!(out["hold"], json!(["walk|Short"]), "550 yd off, past 400: the walk found short holds");
	for (k, label) in [("long", "Long"), ("none", "None")] {
		assert_eq!(out[k]["planned"], gate(label), "{k}: planned the gate's way");
		assert_eq!(out[k]["probed"], true, "{k}: the engine asked");
		assert_eq!(out[k]["after"], gate(label), "{k}: still the gate's way");
		assert_eq!(out[k]["untouched"], true, "{k}: the same legs, every field as it was, no new route");
		assert_eq!(out[k]["again"], gate(label), "{k}: and the next plan keeps it");
	}
}

// A near walk longer than 1.5 x straight + 100 yd but never out of the hold (at most 2 x 700 less the straight yards)
// is weighed against the way without it, whose last walk (from the gate's far end) the engine is asked for too: from
// 1,100 yd west of the gate, the 1,000 yd walk round the hill beats the gate's way (1,100 yd to the gate, its far
// end 1,100 yd from the target) and is planned; 100 yd from the gate, the gate's way (130 yd there, 130 yd on) beats
// the same walk and stays, untouched. Darkcloud Pinnacle's plateau walk is the real case (nav-e2e).
#[test]
fn a_longer_near_walk_that_stays_within_the_hold_is_planned_only_when_the_way_without_it_measures_longer_still_1543() {
	let out = run(&format!(
		"{NEAR}{}",
		r#"
		local function probeTo(x, y, after)
			for i = #fake.calls, (after or 0) + 1, -1 do
				local job = fake.calls[i]
				if not job.urgent and job.to and floor(job.to.x + 0.5) == x and floor(job.to.y + 0.5) == y then return job, i end
			end
		end
		local function try(sx, label, ty, path, rest)
			N.ClearTarget()
			nav.place(sx, 100)
			target(sx, ty, label)
			aim()
			local legs, before = N.GetRoute(), nil
			before = dump(legs)
			local first, at = probeTo(sx, ty)
			fake.answerXY(first, path)
			aim()
			local second = probeTo(sx, ty, at)
			if second then fake.answerXY(second, rest) end
			aim()
			local after = N.GetRoute()
			return { asked = second ~= nil, after = route(), untouched = rawequal(after, legs) and dump(after) == before }
		end
		emit({
			far = try(-500, "Far", -100, { -500, 100, -100, 100, -100, -100, -500, -100 }, { 600, -20, -500, -100 }),
			near = try(500, "Near", -100, { 500, 100, 100, 100, 100, -100, 500, -100 }, { 600, -20, 500, -100 }),
		})"#
	));
	assert_eq!(out["far"]["asked"], true, "the gate's last walk is measured");
	assert_eq!(out["far"]["after"], json!(["walk|Far"]), "1,000 yd round the hill beats the gate's 2,200: the near walk");
	assert_eq!(out["near"]["asked"], true, "the gate's last walk is measured");
	assert_eq!(out["near"]["after"], json!(["walk|Through the gate to East Vale", "walk|Through the gate to East Vale", "walk|Near"]), "the gate's 300 yd beat 1,000: the gate's way");
	assert_eq!(out["near"]["untouched"], true, "the same legs, every field as it was, no new route");
}

// A near walk the engine finds long leaves the plan byte for byte the one made with no near walk at all (no engine to
// ask): every field of every leg, before the answer and after it.
#[test]
fn a_dropped_near_walk_leaves_the_plan_byte_identical_to_the_one_without_it_1543() {
	let script = format!(
		"{NEAR}{}",
		r#"
		local legs, before, version = start("Kobolds")
		local job = probe()
		if job then fake.answerXY(job, LONG) end
		aim()
		local after = N.GetRoute()
		emit({ probed = job ~= nil, route = route(), before = before, after = dump(after), untouched = rawequal(after, legs) and T.version == version })"#
	);
	let with = run(&script);
	let without = run_with(&script, false, false);
	assert_eq!((with["probed"].clone(), without["probed"].clone()), (json!(true), json!(false)), "the engine asked only when there is one");
	assert_eq!(with["route"], json!(["walk|Through the gate to East Vale", "walk|Through the gate to East Vale", "walk|Kobolds"]));
	assert_eq!(with["before"], without["before"], "planned: every field of every leg as with no near walk at all");
	assert_eq!(with["after"], without["after"], "after the long answer: still");
	assert_eq!(with["untouched"], true, "the same legs, no new route");
}

// The capitals (Nav/Walk.lua `city`): Ironforge's zone over Testshire's world (wx -300..300, wy 300..-700: the
// planner's zone frames, Travel.ZoneOf), and the router's trail floor (Path.TrailFloor) as fake.trail(map, x, y,
// reach, near) -> z; every ask is kept in fake.trailAsks ({ reach, near }). FLOORS' startZ() targets lie outside it.
const CITY: &str = r#"
N.RegisterCrossings({ zones = { [1455] = { name = "Ironforge", c = 0, top = 300, bottom = -300, left = 300, right = -700 } } })
fake.trailAsks = {}
Polestar_NavEngine.TrailFloor = function(map, x, y, reach, near)
	fake.trailAsks[#fake.trailAsks + 1] = { reach = reach, near = near or false }
	if fake.trail then return fake.trail(map, x, y, reach, near) end
	return nil
end
-- NPCs the client names (UnitGUID): UNIT[token] = creature id; the Codex's spawns: SPAWNS[id] = { { wx, wy, z }, ... }.
UNIT, SPAWNS = {}, {}
UnitGUID = function(unit)
	local id = UNIT[unit]
	return id and ("Creature-0-1-0-1-" .. id .. "-0000000001") or nil
end
Polestar.Codex = {
	IsLoaded = function() return true end,
	Npc = function(id)
		local list = SPAWNS[id]
		if not list then return nil end
		local spawns = {}
		for i, s in ipairs(list) do
			local m, x, y = nav.mapPoint(s[1], s[2])
			spawns[i] = { map = m, x = x, y = y, z = s[3] }
		end
		return { id = id, spawns = spawns }
	end,
}
-- Off somewhere and back after a while: the floor is unknown again where the player stands.
local function away(wx, wy)
	local p = nav.player
	nav.place(wx, wy)
	stub.advance(3)
	N.Sample()
	nav.place(p.wx, p.wy)
	stub.advance(3)
end
"#;

// Phase A1 (CityPaths, 2026-11-18): with no height (a loading screen into the city, a cell whose levels lie apart) a
// walk in a capital started on whichever surface was cheapest at the spot: 33-66% of recorded city walks started or
// ended on another floor or under the city. There the floor people walk on (the trail floor within 4 yd) picks the
// surface; outside the capitals nothing changes.
#[test]
fn city_a1_in_a_capital_a_walk_from_an_unknown_floor_starts_on_the_trail_floor_outside_the_capitals_as_before() {
	let out = run(&[
		FLOORS,
		CITY,
		r#"
		local r = {}
		-- The street (72) over the ground it was built on (40), 32 yd apart everywhere: seed cannot tell.
		fake.surfaces = function() return { 40, 72 } end
		fake.trail = function() return 72.5, 3 end
		nav.place(0, 50)
		r.city = startZ()
		r.reach = fake.trailAsks[1] and fake.trailAsks[1].reach or false
		-- Outside the capital (the trails have nothing there either way): unknown, searched without a height.
		nav.place(600, 50)
		stub.advance(3)
		r.outside = startZ()
		-- The trails silent in the capital: as before.
		fake.trail = nil
		nav.place(0, 60)
		stub.advance(3)
		r.silent = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["city"], 72.5, "the surface the trail floor (72.5) says, the search from the trail floor itself");
	assert_eq!(out["reach"], 4, "the floor people walk on within 4 yd");
	assert_eq!(out["outside"], "none");
	assert_eq!(out["silent"], "none");
}

// A1 at the goal: a hand-set target in a capital (a map click, no height) is searched to the trail floor at it, with
// the router's reach (A2); one outside keeps no height.
#[test]
fn city_a1_a_goal_without_a_height_in_a_capital_ends_on_the_trail_floor_with_the_reach() {
	let out = run(&[
		FLOORS,
		CITY,
		r#"
		local r = {}
		fake.surfaces = function() return { 40 } end
		fake.trail = function(map, x, y) if x < -50 then return 61 end return 40 end
		nav.place(0, 50)
		target(-100, 100)
		N.Sample()
		r.city = { fake.last().to.z or "none", fake.last().to.reach or false }
		target(-500, 100)
		N.Sample()
		r.outside = { fake.last().to.z or "none", fake.last().to.reach or false }
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["city"], json!([61, 10]));
	assert_eq!(out["outside"], json!(["none", false]));
}

// Phase A2, #2860 (Ironforge, the cooking trainer): his platform in the Great Forge is reached by no walk on the maps;
// the search at his height failed, and the one asked again without it went out of the gate and over the mountain
// (3,515 yd for a 356 yd walk). In a capital the goal's height stays: the router's reach (10 yd) ends the walk at the
// nearest surface on its level it reaches. With none, the arrow says the last steps aren't mapped
// and the walk is not marked unreachable (the plan would go round it).
#[test]
fn city_a2_a_capital_s_goal_keeps_its_height_with_the_reach_and_says_the_last_steps_are_not_mapped_2860() {
	let out = run(&[
		FLOORS,
		CITY,
		r#"
		local r = {}
		fake.surfaces = function() return { 40 } end
		nav.place(0, 50)
		startZ()
		local m, x, y = nav.mapPoint(-100, -500)
		local function said()
			local text = "The last steps here aren't mapped"
			return N.arrow.distText:GetText() == text or (N.arrow.labelText:GetText() or ""):find(text, 1, true) ~= nil
		end
		N.travel.WalkUnreachable = function() r.unreachable = true end
		N.SetTarget(m, x, y, "Daryl Riknussun", nil, "trainer", 66)
		N.Sample()
		r.asked = { fake.last().to.z, fake.last().to.reach or false }
		local n = calls()
		-- The tracked start found nothing: once more from the surfaces near its height, then from none, the goal's kept.
		fake.fail("unreachable")
		r.startRetry = { calls() - n, fake.last().from.z or "none", fake.last().from.floors and fake.last().from.floors[1] or false, fake.last().to.z, fake.last().to.reach or false }
		fake.fail("unreachable")
		r.flatRetry = { calls() - n, fake.last().from.z or "none", fake.last().from.floors and fake.last().from.floors[1] or false, fake.last().to.z }
		n = calls()
		fake.fail("unreachable")
		N.Sample()
		stub.advance(0.3)
		r.failed = { calls() - n, aim()[1], (N.walk.Unmapped()), said(), r.unreachable or false }
		-- Found through the reach (job.reached): its walk is the arrow's, said.
		N.SetTarget(m, x, y, "Daryl Riknussun", nil, "trainer", 65)
		N.Sample()
		n = calls()
		fake.last().reached = { x = -95, y = -495, z = 60 }
		fake.resolve(0, 50, -95, -495)
		N.Sample()
		stub.advance(0.3)
		r.reached = { calls() - n, aim()[1], (N.walk.Unmapped()), said() }
		-- Found on its floor: nothing said.
		N.SetTarget(m, x, y, "Daryl Riknussun", nil, "trainer", 64)
		N.Sample()
		fake.resolve(0, 50, -100, -500)
		N.Sample()
		stub.advance(0.3)
		r.onFloor = { (N.walk.Unmapped()), said() }
		-- Ending 100 yd above it: kept (no search without the height), said.
		N.SetTarget(m, x, y, "Daryl Riknussun", nil, "trainer", 63)
		N.Sample()
		n = calls()
		local job, pts = fake.last(), {}
		for i, p in ipairs({ { 0, 50, 40 }, { -95, -490, 163 }, { -100, -500, 63 } }) do pts[i] = { map = job.map, x = p[1], y = p[2], z = p[3] } end
		job.callback(pts, 100, job)
		N.Sample()
		r.offFloor = { calls() - n, (N.walk.Unmapped()) }
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["asked"], json!([66, 10]), "at his height, with the router's reach");
	assert_eq!(out["startRetry"], json!([1, "none", 40, 66, 10]), "the tracked start's retry: from the surfaces near its floor, his height kept");
	assert_eq!(out["flatRetry"], json!([2, "none", false, 66]), "then from no start height, his height kept");
	// #3409, Fitz's ruling: wherever no walk is found the arrow points straight and says why, as before 0.4.2.
	assert_eq!(out["failed"], json!([0, "travel", true, true, false]), "no heightless search; the straight bearing, the missing walk explained");
	assert_eq!(out["reached"], json!([0, "travel", true, true]), "the walk to the nearest reachable surface on his level, said");
	assert_eq!(out["onFloor"], json!([false, false]));
	assert_eq!(out["offFloor"], json!([0, true]), "kept, said");
}

// Outside the capitals (WorldFloor): the goal's height takes the router's reach too; one that finds no walk at all is
// asked once more without it (Z2), and that walk, ending on whichever floor the maps join there, is said.
#[test]
fn city_a2_outside_the_capitals_a_goal_s_height_takes_the_reach_and_finding_nothing_is_asked_again_without_it_said() {
	let out = run(&[
		FLOORS,
		CITY,
		r#"
		fake.surfaces = function() return { 40 } end
		nav.place(600, 50)
		startZ()
		local m, x, y = nav.mapPoint(-500, -500)
		N.SetTarget(m, x, y, "Trainer", nil, "trainer", 66)
		N.Sample()
		local reach = fake.last().to.reach or false
		fake.fail("unreachable") -- the tracked start's retry, the goal's height kept
		local n = calls()
		fake.fail("unreachable")
		local flat = { calls() - n, fake.last().to.z or "none" }
		fake.resolve(600, 50, -500, -500)
		N.Sample()
		emit({ reach, flat, (N.walk.Unmapped()) })"#,
	]
	.concat());
	assert_eq!(out, json!([10, [1, "none"], true]));
}

// A2 in the planner (the 8:20 travel line of #2860 was its measure): a measure into a capital's target goes from its
// height with the reach and is never asked again without it (the straight estimates stand); the last walk's search
// takes the reach too.
#[test]
fn city_a2_the_measure_into_a_capital_s_target_keeps_its_height_with_the_reach_2860() {
	let out = run_many(
		&[
			TERRAIN,
			CITY,
			r#"
		local r = {}
		-- All of Testshire in the capital here: the plan walks as it does without zones.
		N.RegisterCrossings({ zones = { [1455] = { name = "Ironforge", c = 0, top = 1000, bottom = -1000, left = 1000, right = -1000 } } })
		local m, x, y = nav.mapPoint(0, 0)
		nav.place(900, 800)
		nav.setWaypoint({ map = m, x = x, y = y, z = -40, label = "Daryl Riknussun", stepIndex = 1, goalIndex = 1, kind = "trainer", r = 5 })
		N.Sample()
		local first = fake.of(true)[1]
		r.batch = { first.from.z, first.from.reach or false }
		fake.settle(first, function() return false end)
		r.batches = #fake.of(true)
		emit(r)"#,
		]
		.concat(),
	);
	assert_eq!(out["batch"], json!([-40, 10]));
	assert_eq!(out["batches"], 1, "no batch without the height");
}

// Phase A3 (BV Addon Suite - Routing's idea): the NPC the player talked to or targeted (else the newest in a nameplate
// or moused over) within 15 s, its spawn within 30 yd, gives the floor; an NPC with spawns on two levels there says
// nothing; with trails, the trail floor on the NPC's level. Only in the capitals.
#[test]
fn city_a3_an_npc_beside_the_player_gives_the_floor_from_its_spawn_height_ambiguous_or_stale_ones_none() {
	let out = run(&[
		FLOORS,
		CITY,
		r#"
		local r = {}
		fake.surfaces = function() return { 40, 43.5, 72 } end
		SPAWNS[5159] = { { 10, 60, 41 } }
		SPAWNS[5160] = { { 10, 60, 41 }, { 10, 75, 73 } }
		SPAWNS[5162] = { { 3, 53, 41 }, { 10, 75, 73 } }
		nav.place(0, 50)
		UNIT.target = 5159
		stub.fire("PLAYER_TARGET_CHANGED")
		r.targeted = startZ()
		-- Two spawns on two levels within 30 yd: nothing.
		UNIT.target = 5160
		stub.fire("PLAYER_TARGET_CHANGED")
		away(0, 250)
		r.ambiguous = startZ()
		-- Its window opened (the player beside it): only its spawns within 10 yd count, the one at 41.
		UNIT.npc = 5162
		stub.fire("GOSSIP_SHOW")
		away(0, 250)
		r.talked = startZ()
		UNIT.npc = nil
		stub.advance(16)
		-- A nameplate: the newest one.
		UNIT.target = nil
		stub.fire("PLAYER_TARGET_CHANGED")
		UNIT.nameplate3 = 5159
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate3")
		away(0, 250)
		r.plate = startZ()
		-- 16 s later: stale.
		stub.advance(16)
		away(0, 250)
		r.stale = startZ()
		-- With trails: asked on the NPC's level, taken within 4 yd of the NPC's height, else the NPC's height.
		fake.trail = function(map, x, y, reach, near) if near then return 43.5, 2 end return 72, 3 end
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate3")
		fake.trailAsks = {}
		away(0, 250)
		r.trail = startZ()
		r.near = false
		for _, a in ipairs(fake.trailAsks) do if a.near == 41 then r.near = 41 end end
		fake.trail = function(map, x, y, reach, near) if near then return 47, 2 end return 72, 3 end
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate3")
		away(0, 250)
		r.farTrail = startZ()
		-- Outside the capital an NPC there says nothing.
		SPAWNS[5161] = { { 600, 60, 41 } }
		fake.trail = nil
		UNIT.target = 5161
		nav.place(600, 50)
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.advance(3)
		r.outside = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out["targeted"], 40, "the targeted NPC's spawn (41): the surface at 40");
	assert_eq!(out["ambiguous"], "none");
	assert_eq!(out["talked"], 40, "talked to: its spawn within 10 yd (41), not the one 25 yd off at 73");
	assert_eq!(out["plate"], 40);
	assert_eq!(out["stale"], "none");
	assert_eq!(out["near"], 41, "the trail floor asked on the NPC's level");
	assert_eq!(out["trail"], 43.5, "that trail floor (43.5), 2.5 yd over the NPC's");
	assert_eq!(out["farTrail"], 40, "a trail floor 6 yd off the NPC's height: the NPC's (41), the surface at 40 (and 7 yd off that floor: no settling)");
	assert_eq!(out["outside"], "none");
}

// Walking in through a capital's gate (Fitz, 2026-11-18: Dun Morogh into Ironforge, Durotar into Orgrimmar): the floor
// followed outside carries across the zone's edge and the indoor flag's flip; the city's hints (trails, NPCs) only seed
// a floor that is unknown, never move a followed one.
#[test]
fn city_walking_in_through_a_gate_the_floor_followed_outside_carries_across_the_city_s_hints_never_move_it() {
	let out = run(&[
		FLOORS,
		CITY,
		r#"
		local r = {}
		-- Outside (wx > 300) one surface; inside the gate two, the street (40) and the mountain over it (300).
		fake.surfaces = function(map, x, y) if x > 300 then return { 40 } end return { 40, 300, [-1] = 2 } end
		fake.trail = function() return 300, 1 end
		nav.place(360, 0)
		r.outside = startZ()
		walk(250, 0)
		nav.indoors = true
		walk(200, 0)
		r.inside = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out, json!({ "outside": 40, "inside": 40 }));
}

// A flight's landing in a capital (CityLifts, 2026-11-18: Thunder Bluff's tower top at 176.9 over the ground at 145.7,
// the Undercity's bat platform over its ring): both levels are walked, so the trails can't tell them; the flight point's
// own height (TravelData's taxiZ, TaxiNodes) is the floor for the first LAND_SECONDS (30) within 20 yd of the landing.
#[test]
fn city_after_a_flight_lands_in_a_capital_the_floor_is_the_flight_point_s_height_for_30_s() {
	let out = run(&[
		FLOORS,
		CITY,
		r#"
		local r = {}
		fake.surfaces = function() return { 145.7, 176.9 } end
		fake.trail = function(map, x, y, reach, near) if near then return near, 2 end return 145.7, 3 end
		local m, mx, my = nav.mapPoint(10, 60)
		N.RegisterTravelData({ taxi = { { 901, 0, 10, 60, m, mx, my, 3, "Tower, Ironforge" } }, taxiZ = { [901] = 176.9 } })
		r.node = N.GetTaxiNode(901).z
		-- Taken from a flight master 600 yd off (control lost there), landed at the tower (control back).
		nav.place(600, 62)
		stub.fire("PLAYER_CONTROL_LOST")
		nav.taxi = true
		stub.advance(60)
		nav.place(12, 62)
		nav.taxi = false
		stub.fire("PLAYER_CONTROL_GAINED")
		r.landed = startZ()
		-- 40 s on, the floor lost (a jump away and back): the trails' answer again.
		stub.advance(40)
		away(0, 250)
		r.later = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out, json!({ "node": 176.9, "landed": 176.9, "later": 145.7 }));
}

// CityLifts, 2026-11-18 (the Undercity's Trade Quarter by the south lift): Leffe's maps hold a pocket surface at -47 a
// few yards under the walkway people walk at -43 (75 recorded players against 2), and the floor followed there reads
// the pocket. In a capital a search from a followed floor starts on the trail floor within 5 yd of it; the follower
// keeps what it reads. Farther, or outside the capitals, the followed floor.
#[test]
fn city_a1_in_a_capital_a_followed_floor_starts_its_search_on_the_trail_floor_within_5_yd() {
	let out = run(&[
		FLOORS,
		CITY,
		r#"
		local r = {}
		fake.surfaces = function() return { 40 } end
		fake.trail = function(map, x, y, reach, near) return near and near + 4.5 or 44.5, 2 end
		nav.place(0, 50)
		r.near = startZ()
		fake.trail = function(map, x, y, reach, near) return near and near + 6 or 46, 2 end
		stub.advance(1)
		r.far = startZ()
		fake.trail = function(map, x, y, reach, near) return near and near + 4.5 or 44.5, 2 end
		nav.place(600, 50)
		stub.advance(3)
		r.outside = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out, json!({ "near": 44.5, "far": 40, "outside": 40 }));
}

// The Undercity lies under Tirisfal Glades (CityLifts2, 2026-11-18): the zone a point there reads is Tirisfal's, so no
// capital rule ran in it. A point in the Undercity's own map frame is in the capital.
#[test]
fn city_the_undercity_under_tirisfal_s_ground_is_a_capital_by_its_own_map_frame() {
	let out = run(&[
		FLOORS,
		r#"
		local r = {}
		nav.maps[1458] = { c = 0, top = 300, bottom = -300, left = 300, right = -700, name = "Undercity" }
		N.RegisterCrossings({ zones = { [1420] = { name = "Tirisfal Glades", c = 0, top = 900, bottom = -900, left = 900, right = -900 } } })
		Polestar_NavEngine.TrailFloor = function(map, x, y, reach, near) return 72.5, 3 end
		fake.surfaces = function() return { 40, 72 } end
		nav.place(0, 50)
		r.inside = startZ()
		nav.place(600, 50)
		stub.advance(3)
		r.tirisfal = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out, json!({ "inside": 72.5, "tirisfal": "none" }));
}

// #2215, Booty Bay (WorldFloor, replayed on the shipped maps from players' walks): the docks' deck (8) lies 8 yd over
// the bay's water surface (0), within ZTOL, and seed took the lowest, the water; the follow kept it under the piers
// all the way to Fleet Master Seahorn. Water is a floor only to a swimmer (Compat.IsSwimming); a ghost walks on it.
#[test]
fn world_on_booty_bay_s_docks_the_floor_is_the_deck_not_the_water_under_it_a_swimmer_s_is_the_water_2215() {
	let out = run(&[
		FLOORS,
		CITY,
		r#"
		local r = {}
		fake.surfaces = function() return { 8, 0, [-2] = 1 } end
		nav.place(600, 50)
		r.dry = startZ()
		nav.swimming = true
		away(600, 250)
		r.swimming = startZ()
		nav.swimming = nil
		away(600, 250)
		r.out = startZ()
		fake.surfaces = function() return { 0, [-1] = 1 } end
		away(600, 250)
		r.onlyWater = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out, json!({ "dry": 8, "swimming": 0, "out": 8, "onlyWater": 0 }));
}

// #2215 (WorldFloor): where floors stack (Booty Bay's docks, piers and huts), walking up a ramp over a deck that runs on
// under it keeps the follow on the deck: beside Fleet Master Seahorn the floor followed from the docks stayed 20 yd
// under his. The NPC whose window the player opens (within interact range of it, its spawn within 10 yd) corrects a
// followed floor more than 6 yd off its height, once per window, standing still too; a targeted NPC never does.
#[test]
fn world_talking_to_an_npc_puts_a_followed_floor_more_than_6_yd_off_its_height_right_a_target_never_2215() {
	let out = run(&[
		FLOORS,
		CITY,
		r#"
		local r = {}
		-- The docks' deck alone east of 650; west of it the bank's floor (29) over the deck.
		fake.surfaces = function(map, x) if x > 650 then return { 8 } end return { 8, 29 } end
		SPAWNS[2487] = { { 600, 52, 28.8 } }
		nav.place(700, 50)
		startZ()
		walk(602, 50)
		r.followed = startZ()
		UNIT.target = 2487
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.advance(0.3)
		N.Sample()
		r.targeted = startZ()
		UNIT.npc = 2487
		stub.fire("GOSSIP_SHOW")
		stub.advance(0.3)
		N.Sample()
		r.talked = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out, json!({ "followed": 8, "targeted": 8, "talked": 29 }));
}

// Outside the capitals (WorldFloor): with the floor unknown (a loading screen, a cell whose floors lie apart: Booty
// Bay's hut at 25 between the deck at 6 and the roof at 36), the NPC whose window the player just opened seeds it;
// a nameplate or a target there says nothing.
#[test]
fn world_outside_the_capitals_the_npc_talked_to_seeds_an_unknown_floor_a_nameplate_says_nothing() {
	let out = run(&[
		FLOORS,
		CITY,
		r#"
		local r = {}
		fake.surfaces = function() return { 6, 25, 36 } end
		SPAWNS[2495] = { { 600, 52, 25.4 } }
		nav.place(600, 50)
		UNIT.nameplate1 = 2495
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		away(600, 250)
		r.plate = startZ()
		UNIT.npc = 2495
		stub.fire("GOSSIP_SHOW")
		away(600, 250)
		r.talked = startZ()
		emit(r)"#,
	]
	.concat());
	assert_eq!(out, json!({ "plate": "none", "talked": 25 }));
}
