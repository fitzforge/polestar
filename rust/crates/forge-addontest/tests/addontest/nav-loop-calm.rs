//! A farming loop walked on the real walking maps (as nav-arrow-calm.rs): the Red Cloud Mesa copper loop and
//! Mulgore's herb starter loop (the Mining and Herbalism guides' own lines), each walked three laps along its track
//! at run speed. Every 0.1 s the shown bearing (Arrow.GetTurn) is logged against the track's direction 20 yd ahead.
//! A swing is the bearing moving more than 45° within a second while that direction moves less than 15°, off the
//! loop's corners (25 yd before one to 10 yd past it). Also counted: the walking searches asked (each target the
//! arrow gets is one) and the targets the loop gave, against its corners.

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

use super::nav_e2e::{before, nav_files, ns_file, skip_reason, PRELUDE};

const SCENARIO: &str = r#"
w.faction = "Horde"
w.setLevel(30)
local function wrapd(a) return (a + 540) % 360 - 180 end
local TURN_BEFORE, TURN_AFTER, AHEAD = 25, 10, 20
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.Set("nav.travel", true)
local function walkLoop(name, goal, pts)
	local packed = {}
	for i, p in ipairs(pts) do packed[i] = p[1] .. "," .. p[2] .. ",,60" end
	local id = "test/" .. name
	goal.candidates = { { map = 1412, x = pts[1][1], y = pts[1][2], f = "e", faction = "H", lvl = { min = 2, max = 2 }, lap = 300, gain = 1, yield = 1, spotsPacked = table.concat(packed, ";") } }
	Polestar.RegisterGuide({ id = id, pack = "test", title = name, category = "Professions", minLevel = 1, maxLevel = 60, steps = {
		{ title = name, goals = { goal } }, { goals = { { t = "level", level = 60 } } } } })
	-- The track in world yards, closed.
	local xs, ys, along = {}, {}, { 0 }
	for i, p in ipairs(pts) do
		local _, wx, wy = C.MapToWorld(1412, p[1], p[2], "e")
		xs[i], ys[i] = wx, wy
	end
	xs[#xs + 1], ys[#ys + 1] = xs[1], ys[1]
	for i = 2, #xs do along[i] = along[i - 1] + dist(xs[i - 1], ys[i - 1], xs[i], ys[i]) end
	local lap = along[#xs]
	local function at(s)
		s = s % lap
		for i = 2, #xs do
			if along[i] >= s then
				local t = (s - along[i - 1]) / (along[i] - along[i - 1])
				return xs[i - 1] + (xs[i] - xs[i - 1]) * t, ys[i - 1] + (ys[i] - ys[i - 1]) * t
			end
		end
	end
	local corners = {}
	for i = 1, #pts do
		local p = i == 1 and #xs - 1 or i - 1
		local inH = math.deg(math.atan2(ys[i] - ys[p], xs[i] - xs[p]))
		local outH = math.deg(math.atan2(ys[i + 1] - ys[i], xs[i + 1] - xs[i]))
		if math.abs(wrapd(outH - inH)) >= 45 then corners[#corners + 1] = along[i] end
	end
	local function onTurn(s)
		local m = s % lap
		for _, c in ipairs(corners) do
			local d = (m - c + lap / 2) % lap - lap / 2
			if d >= -TURN_BEFORE and d <= TURN_AFTER then return true end
		end
		return false
	end
	place(1412, xs[1], ys[1], 0)
	stub.advance(0.5)
	Polestar.Engine.SetGuide(id)
	for _ = 1, 60 do stub.advance(0.1) end
	-- Off the track: 100 yd beside the first leg's middle, walked to the arrow's rejoin point until on the track.
	local mx, my = at(along[2] / 2)
	local nx, ny = -(ys[2] - ys[1]) / along[2], (xs[2] - xs[1]) / along[2]
	local ox, oy = mx + nx * 100, my + ny * 100
	place(1412, ox, oy, 0)
	stub.advance(0.6)
	local r0, rejoinTargets, rlast, rT = #finds, 0, nil, 0
	while rT < 60 do
		local _, tx, ty = N.GetTargetWorld()
		local key = tx and (r1(tx) .. "," .. r1(ty))
		if key ~= rlast then rejoinTargets, rlast = rejoinTargets + 1, key end
		if Polestar.Engine.LoopOnTrack() then break end
		local d = dist(ox, oy, tx, ty)
		ox, oy = ox + (tx - ox) / d * 0.7, oy + (ty - oy) / d * 0.7
		place(1412, ox, oy, 0)
		stub.advance(0.1)
		rT = rT + 0.1
	end
	local rejoin = { searches = #finds - r0, targets = rejoinTargets, seconds = r1(rT), onTrack = Polestar.Engine.LoopOnTrack() }
	place(1412, xs[1], ys[1], 0)
	for _ = 1, 10 do stub.advance(0.1) end
	local f0, targets, lastT = #finds, 0, nil
	local samples, s, T = {}, 0, 0
	while s < 3 * lap do
		s = s + 0.7
		local x, y = at(s)
		local hx, hy = at(s + 3)
		w.facing = math.atan2(hy - y, hx - x) % (2 * math.pi)
		place(1412, x, y, 0)
		stub.advance(0.1)
		T = T + 0.1
		local tc, tx, ty = N.GetTargetWorld()
		local key = tx and (r1(tx) .. "," .. r1(ty))
		if key ~= lastT then targets, lastT = targets + 1, key end
		local ax, ay = at(s + AHEAD)
		samples[#samples + 1] = { t = T, s = s, b = math.deg(N.arrow.GetTurn()), h = math.deg(math.atan2(ay - y, ax - x)), m = N.arrow.GetMode(), turn = onTurn(s) }
	end
	local swings, worst, list = 0, 0, {}
	local i, n = 1, #samples
	while i <= n do
		local a, hit = samples[i], nil
		if a.m == "travel" and not a.turn and a.t > 1.5 then
			local maxA, maxH, j, bad = 0, 0, i + 1, false
			while j <= n and samples[j].t - a.t <= 1.0 + 1e-6 do
				local q = samples[j]
				if q.m ~= "travel" or q.turn then bad = true break end
				maxA = math.max(maxA, math.abs(wrapd(q.b - a.b)))
				maxH = math.max(maxH, math.abs(wrapd(q.h - a.h)))
				j = j + 1
			end
			if not bad and maxA > 45 and maxH < 15 then
				swings, hit = swings + 1, j
				worst = math.max(worst, maxA)
				if #list < 5 then list[#list + 1] = { t = r1(a.t), s = r1(a.s % lap), swing = r1(maxA) } end
			end
		end
		i = hit or (i + 1)
	end
	local modes = {}
	for _, q in ipairs(samples) do modes[q.m] = (modes[q.m] or 0) + 1 end
	return { name = name, lap = r1(lap), laps = 3, points = #pts, corners = #corners, seconds = r1(T), samples = n, swings = swings, worst = r1(worst),
		searches = #finds - f0, targets = targets, modes = modes, list = list, rejoin = rejoin }
end
local out = {}
out[1] = walkLoop("Red Cloud Mesa copper", { t = "collect", item = 2770, itemName = "Copper Ore", count = 9999, gather = { rank = 1, skill = "Mining", skillLine = 186 } },
	{ { 49.0, 92.8 }, { 49.2, 87.7 }, { 41.8, 79.8 }, { 41.2, 82.0 } })
out[2] = walkLoop("Mulgore herbs", { t = "collect", item = 2447, itemName = "Peacebloom", count = 9999, gather = { rank = 1, skill = "Herbalism", skillLine = 182 } },
	{ { 44.0, 82.8 }, { 47.1, 86.7 }, { 49.4, 88.8 }, { 46.5, 74.3 }, { 37.7, 77.8 }, { 41.6, 81.8 }, { 42.8, 79.5 } })
emit(out)
"#;

#[test]
fn walking_a_farming_loop_three_laps_the_arrow_never_swings_on_a_straight_and_its_target_moves_once_a_leg() {
	if let Some(why) = skip_reason() {
		eprintln!("skipped: {why}");
		return;
	}
	let (_tmp, ns) = ns_file();
	let files = nav_files(&ns);
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_encoding.lua", "stub_packs.lua"],
		before: format!("{}\nstub.world.faction, stub.world.race, stub.world.raceName = \"Horde\", \"Tauren\", \"Tauren\"", before(&files)),
		addons: vec![Addon::name("Polestar"), Addon::files("Polestar_Guides", &["Pack.lua", "MapFrames.lua"])],
		saved: vec![],
		login: true,
		script: format!("{PRELUDE}\n{SCENARIO}"),
	})
	.remove(0);
	let _ = addons_dir();
	let mut bad = vec![];
	for walk in out.as_array().into_iter().flatten() {
		eprintln!("{}", serde_json::to_string(walk).unwrap());
		let name = walk["name"].as_str().unwrap_or("");
		if walk["swings"].as_i64() != Some(0) {
			bad.push(format!("{name}: {} swings over 45° on a straight: {}", walk["swings"], walk["list"]));
		}
		let legs = walk["points"].as_i64().unwrap_or(0) * 3;
		if walk["targets"].as_i64().unwrap_or(i64::MAX) > legs + 1 {
			bad.push(format!("{name}: {} targets for {legs} legs walked", walk["targets"]));
		}
		// Off the track: one rejoin point, held until the player is back on the track.
		let rejoin = &walk["rejoin"];
		if rejoin["onTrack"] != true || rejoin["targets"].as_i64().unwrap_or(i64::MAX) > 2 {
			bad.push(format!("{name}: the rejoin from 100 yd off: {rejoin}"));
		}
	}
	assert!(bad.is_empty(), "{}", bad.join("\n"));
}
