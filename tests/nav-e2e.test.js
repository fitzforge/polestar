'use strict';
// End to end: the arrow on Shortest Path Forever's real walking engine and
// Polestar's packed maps (maps 0 and 1, `nav pack`). The
// real Polestar (with TravelData, the guides' Era map frames, and the local
// crossings when built) loads the real Polestar_Nav on demand at login, its
// maps decoded by tests/lua/stub_encoding.lua the way the client decodes them;
// the stub world's maps are data/forever/map-frames.json's, and UnitPosition
// answers from the same place (x north, y west, z, the instance map id). A
// character in Goldshire is guided to the Fargodeep Mine; the engine's path
// must come back through Nav/Walk.lua, Nav/Travel.lua and Nav.Sample to the
// arrow. Every other arrow test fakes the engine (tests/nav-spf.test.js) and
// the other real-engine tests call it directly (tests/nav-vendor.test.js): a
// frame mismatch between the two (north/west swapped, a uiMapID for the
// instance id, a dropped height) passes those and fails only here. Checks
// name their docs/NAV_QA.md rows.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, tocFiles, ADDONS, ROOT } = require('./helpers/lua');
const { needs, DATA } = require('./helpers/data');
const { tmpdir } = require('./helpers/tmp');
const { findLua } = require('../tools/lib/lua');

function skipReason() {
	try {
		findLua();
	} catch (err) {
		return err.message;
	}
	const data = needs('map-frames.json', 'zones.json');
	if (data) return data;
	if (!fs.existsSync(path.join(ADDONS, 'Polestar_Nav', 'Nav', 'Nav.xml'))) return 'addon/Polestar_Nav has no walking maps (node tools/polestar.js nav pack and nav vendor)';
	if (!fs.existsSync(path.join(ADDONS, 'Polestar_Guides', 'MapFrames.lua'))) return 'addon/Polestar_Guides/MapFrames.lua not built (node tools/polestar.js compile)';
	return false;
}
const skip = skipReason();

// The stub world's maps: the live (Forever) frame where it differs, else Era's.
function mapsLua() {
	const frames = JSON.parse(fs.readFileSync(path.join(DATA, 'map-frames.json'), 'utf8'));
	const zones = JSON.parse(fs.readFileSync(path.join(DATA, 'zones.json'), 'utf8'));
	const all = { ...frames.era, ...frames.forever };
	return Object.entries(all).map(([id, f]) => {
		const z = zones[id] || {};
		return `w.addMap(${id}, { name = ${JSON.stringify(z.name || '')}, c = ${f.c}, left = ${f.left}, right = ${f.right}, top = ${f.top}, bottom = ${f.bottom}, parent = ${z.parent || 0}, mapType = ${z.type || 3} })`;
	}).join('\n');
}

let nsFile;
function before() {
	if (!nsFile) {
		// Appended to Polestar_Nav's files: keeps its namespace, for the snapped-node check.
		nsFile = path.join(tmpdir('polestar-nav-e2e-'), 'keep-ns.lua');
		fs.writeFileSync(nsFile, 'local _, ns = ...\nstub.navNs = ns\n');
	}
	return `local w = stub.world
${mapsLua()}
stub.packs.Polestar_Nav = { ${[...tocFiles('Polestar_Nav'), nsFile].map((f) => JSON.stringify(f)).join(', ')} }
-- UnitPosition: the world position the live map frame gives, z as set, the instance map id.
function UnitPosition(unit)
	if unit ~= "player" or not w.map or w.inInstance then return nil end
	local c, pos = C_Map.GetWorldPosFromMapPos(w.map, CreateVector2D(w.x / 100, w.y / 100))
	if not c then return nil end
	return pos.x, pos.y, w.z, c
end`;
}

const PRELUDE = `
local w, N, C = stub.world, Polestar.Nav, Polestar.Compat
local E = Polestar_NavEngine
local floor, sqrt = math.floor, math.sqrt
local function r1(v) return v and floor(v * 10 + 0.5) / 10 end
-- Every search the arrow asks for, with what it was asked and what came back.
local finds = {}
if E then -- nil when Polestar_Nav was not loaded (routing off)
	local realFind = E.Find
	E.Find = function(map, from, to, callback, water)
		local rec = { map = map, from = { from.x, from.y, from.z }, to = { to.x, to.y, to.z }, at = GetTime(), combat = InCombatLockdown() and true or false }
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
local GOLDSHIRE = { -9444.062, 77.667, 57.353 } -- UnitPosition in front of the Lion's Pride Inn (tests/nav-vendor.test.js)
local LOWER_MOUTH = { -9791.249, 164.438, 27.373 } -- the Fargodeep Mine's lower mouth, likewise
-- Goldshire, guided to the Fargodeep Mine (Elwynn, Era 39.5,82.4); frames run until the path is in.
local function guide(map, x, y, label)
	N.SetTarget(map or 1429, x or 39.5, y or 82.4, label or "Fargodeep Mine", "e")
	aim()
	local n = 0
	while not (finds[#finds] and finds[#finds].done) and n < 100 do stub.advance(0.05); n = n + 1 end
	return finds[#finds]
end
`;

// Runs the scenario; its emitted record goes to the test's diagnostics (the numbers behind each check).
// shipped: only what the release zip carries (no local Polestar_Travel crossing data).
function run(t, script, { shipped = false } = {}) {
	const addons = ['Polestar', { name: 'Polestar_Guides', files: ['MapFrames.lua'] }];
	if (!shipped && fs.existsSync(path.join(ADDONS, 'Polestar_Travel', 'Polestar_Travel.toc'))) addons.push('Polestar_Travel');
	const [out] = runAddon({
		stubs: ['stub_world.lua', 'stub_encoding.lua', 'stub_packs.lua'],
		before: before(),
		addons,
		login: true,
		script: `${PRELUDE}\n${script}`,
	}).emitted;
	t.diagnostic(JSON.stringify(out));
	return out;
}

test('a: Polestar\'s world frame is the engine\'s: known UnitPosition spots and guide coordinates land on the engine\'s nodes, at their height, on instance map 0', { skip }, (t) => {
	const out = run(t, `
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
		emit(r)`);
	assert.equal(out.loads, 1, 'Data.Pack loaded Polestar_Nav once at login');
	assert.equal(out.engine, true);
	// Goldshire: Elwynn 42.0,65.0; the mine's lower mouth 39.5,80.0.
	assert.deepEqual(out.goldshire.map, [42, 65]);
	assert.deepEqual(out.lowerMouth.map, [39.5, 80]);
	for (const [name, s] of Object.entries({ goldshire: out.goldshire, lowerMouth: out.lowerMouth })) {
		assert.equal(s.c, 0, `${name}: Polestar's continent is UnitPosition's instance map id`);
		assert.ok(s.back < 0.01, `${name}: map -> world gives the UnitPosition back (${s.back})`);
		assert.ok(s.node < out.cs, `${name}: the engine's node is ${s.node.toFixed(2)} yd from Polestar's point (cells are ${out.cs.toFixed(2)} yd)`);
		assert.ok(s.dz < 3, `${name}: and at the height UnitPosition reads there (off by ${s.dz.toFixed(2)})`);
		assert.equal(s.swapped, true, `${name}: north and west swapped would be off the engine's map`);
	}
	assert.equal(out.mine.c, 0);
	assert.ok(out.mine.node < out.cs, `the guide's 39.5,82.4 snaps ${out.mine.node.toFixed(2)} yd away, within a cell`);
	assert.deepEqual(out.available, [true, false, false], 'the engine knows instance 0, not the uiMapIDs 1429/1415');
	assert.deepEqual(out.player, [0, out.player[1]]);
	assert.ok(out.player[1] < 0.01);
	assert.equal(out.ask.n, 1);
	assert.equal(out.ask.map, 0);
	assert.ok(out.ask.from < 0.01 && out.ask.to < 0.01, 'from the player, to the target, in the same yards');
	assert.equal(out.ask.z, 57.353, 'the player\'s height goes with the search');
	assert.equal(out.ask.toZ, undefined, 'a map target has no height');
	assert.ok(out.points >= 3 && Math.abs(out.secondZ - 57) < 15, `a ${out.points}-point path on the ground (z ${out.secondZ})`);
});

test('b, e, f: the arrow aims at the engine path\'s next point; the route lines and the journey carry the same path', { skip }, (t) => {
	const out = run(t, `
		local r = {}
		place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
		local f = guide()
		stub.advance(0.2) -- the arrow's own samples (20 Hz)
		local a = aim()
		local pts = f.points
		local _, tx, ty = N.GetTargetWorld()
		r.aim = { state = a.state, index = indexOf(f, a.x, a.y), n = #pts, measured = a.measured, dist = a.dist, off = offPath(pts, a.x, a.y), toTarget = dist(a.x, a.y, tx, ty) }
		r.path = { length = length(pts), straight = dist(GOLDSHIRE[1], GOLDSHIRE[2], tx, ty), endGap = dist(pts[#pts].x, pts[#pts].y, tx, ty) }
		r.left = { walk = N.walk.Left(0, tx, ty), along = length(pts) }
		r.shown = { text = N.arrow.distText:GetText(), want = Polestar.FormatDistance(floor(a.dist + 0.5)), visible = PolestarNavArrow:IsShown() }
		-- e: the route lines' walk leg is the engine's path, the player first.
		local g = N.GetRouteGeometry()
		local walk
		for _, leg in ipairs(g.legs) do if leg.kind == "walk" and leg.current then walk = leg end end
		local same = #walk.pts == #pts
		for i, p in ipairs(walk.pts) do
			if not pts[i] or p[1] ~= 0 or p[2] ~= pts[i].x or p[3] ~= pts[i].y then same = false end
		end
		r.geometry = { legs = #g.legs, n = #walk.pts, same = same, first = dist(walk.pts[1][2], walk.pts[1][3], GOLDSHIRE[1], GOLDSHIRE[2]) }
		-- f: the journey's legs.
		local legs, ci = N.GetRoute()
		local T = N.travel
		local list, finite, sum = {}, true, 0
		for i = ci, #legs do
			local l = legs[i]
			list[#list + 1] = { l.kind, l.label, l.seconds, l.yards }
			if l.seconds ~= l.seconds or l.seconds == math.huge or l.yards ~= l.yards then finite = false end
			sum = sum + l.seconds
		end
		local ps, py = T.Progress()
		r.journey = { legs = list, finite = finite, sum = sum, total = legs[ci].seconds + legs[ci].rest, progress = { ps, py }, remaining = T.Remaining(a.dist, true), speed = py and ps and py / ps,
			yards = legs[ci].yards, seconds = legs[ci].seconds, straight = { legs[ci].straightYards, legs[ci].straightSeconds } }
		r.finds = #finds
		emit(r)`);
	// b
	assert.equal(out.aim.state, 'travel');
	assert.equal(out.aim.measured, true, 'the distance is along the path');
	assert.equal(out.aim.index, 2, `the arrow aims at the path's second point (of ${out.aim.n}), not the target`);
	assert.ok(out.aim.toTarget > 50, `the aimed point is ${out.aim.toTarget.toFixed(0)} yd short of the target`);
	assert.ok(out.aim.off < 1e-6, 'and on the path');
	assert.ok(out.path.endGap < 10, `the path ends ${out.path.endGap.toFixed(1)} yd from the target`);
	assert.ok(Math.abs(out.aim.dist - out.path.length) < 0.5, `the arrow shows the path's length (${out.aim.dist.toFixed(1)} vs ${out.path.length.toFixed(1)})`);
	assert.ok(out.path.length >= out.path.straight, `path ${out.path.length.toFixed(0)} yd, straight ${out.path.straight.toFixed(0)} yd`);
	assert.ok(Math.abs(out.left.walk - out.path.length) < 0.5, 'Walk.Left is the path left');
	assert.equal(out.shown.text, out.shown.want, 'the arrow\'s distance text is that path length');
	// e
	assert.equal(out.geometry.same, true, 'the walk leg\'s points are the engine\'s path, point for point');
	assert.ok(out.geometry.first < 0.01, 'starting where the player stands');
	// f (K1, K6, K7)
	assert.equal(out.finds, 1);
	assert.ok(out.journey.legs.length >= 1);
	for (const [kind, label, seconds, yards] of out.journey.legs) {
		assert.ok(typeof label === 'string' && label !== '' && label !== 'Unknown', `K1: the ${kind} leg is named (${label})`);
		assert.ok(Number.isFinite(seconds) && Number.isFinite(yards), `K7: finite (${seconds} s, ${yards} yd)`);
	}
	assert.equal(out.journey.finite, true);
	assert.equal(out.journey.sum, out.journey.total, 'K6: the legs\' times add up to the walk\'s');
	assert.ok(out.journey.progress.every(Number.isFinite), 'K7: the walk\'s progress is finite');
	assert.ok(Math.abs(out.journey.progress[1] - out.path.length) < 0.5, 'and measured along the engine\'s path');
	assert.ok(Number.isFinite(out.journey.remaining));
	// f: once the path is in, the walk leg is measured along it, at the planner's 7 yd/s.
	assert.ok(Math.abs(out.journey.yards - out.path.length) <= 1, `the walk leg is ${out.journey.yards} yd, the path ${out.path.length.toFixed(1)} yd`);
	assert.ok(Math.abs(out.journey.seconds - out.journey.yards / 7) <= 1, `${out.journey.seconds} s for ${out.journey.yards} yd`);
	assert.ok(out.journey.straight[0] > out.journey.yards, `its straight estimate (${out.journey.straight[0]} yd) is kept for when the path goes`);
});

test('second review: after the path arrives the arrow, the panel\'s leg time and the header total agree', { skip }, (t) => {
	const out = run(t, `
		place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
		guide()
		stub.advance(0.2)
		local a = aim()
		local legs, ci = N.GetRoute()
		local T = N.travel
		local view = Polestar.UI.JourneyPanel.Compute(legs, ci)
		emit({ arrow = T.Remaining(a.dist, true), leg = view.secs[1], header = view.total, planned = legs[ci].seconds + legs[ci].rest })`);
	assert.ok(Math.abs(out.arrow - out.header) <= 1, `arrow ${out.arrow} s, header ${out.header} s`);
	assert.ok(Math.abs(out.leg - out.header) <= 1, `leg ${out.leg} s, header ${out.header} s`);
	assert.ok(Math.abs(out.planned - out.header) <= 1, `the legs' planned times (${out.planned} s) and the header (${out.header} s)`);
});

// Forever's client answers UnitPosition with a height of exactly 0 (reported
// from Ratchet's flight master, 2026-10-16, where the ground is at 12 yd).
// Taken as real, the search started on the nearest surface within 10 yd of 0,
// 20 yd down the slope towards the harbour, and the line went there and back.
test('Z1: a height of 0 from UnitPosition is no height: the walk to Mebok Mizzyrix starts from the ground at Ratchet\'s flight master, never out towards the harbour', { skip }, (t) => {
	const out = run(t, `
		local c, sx, sy = C.MapToWorld(1413, 63.07, 37.08, "e")
		place(1413, sx, sy, 0)
		local f = guide(1413, 62.37, 37.62, "Mebok Mizzyrix")
		local east = 0
		for _, p in ipairs(f.points) do if sy - p.y > east then east = sy - p.y end end
		emit({ c = c, z = f.from[3], east = east, n = #f.points })`);
	assert.equal(out.c, 1);
	assert.equal(out.z, undefined, 'searched without a height');
	assert.ok(out.east < 3, `no point of the path is east of the player, towards the harbour (${out.east.toFixed(1)} yd east, ${out.n} points)`);
});

test('b: where the straight line is blocked (Thelsamar to the Stonewrought Dam) the arrow follows the detour', { skip }, (t) => {
	const out = run(t, `
		local c, sx, sy = C.MapToWorld(1432, 35.5, 47, "e")
		place(1432, sx, sy)
		local f = guide(1432, 48, 15, "Stonewrought Dam")
		local a = aim()
		local _, tx, ty = N.GetTargetWorld()
		emit({ map = f.map, n = #f.points, length = length(f.points), straight = dist(sx, sy, tx, ty), index = indexOf(f, a.x, a.y),
			toTarget = dist(a.x, a.y, tx, ty), endGap = dist(f.points[#f.points].x, f.points[#f.points].y, tx, ty), dist = a.dist,
			second = dist(sx, sy, f.points[2].x, f.points[2].y) })`);
	assert.equal(out.map, 0);
	assert.ok(out.length > out.straight * 1.2, `path ${out.length.toFixed(0)} yd against ${out.straight.toFixed(0)} yd straight`);
	// The path's second point is the start cell's centre; within Walk.lua's POINT_REACH (5 yd) it counts as passed.
	assert.equal(out.index, out.second > 5 ? 2 : 3, `the arrow aims at the detour's first corner (of ${out.n} points; the second is ${out.second.toFixed(1)} yd away)`);
	assert.ok(out.toTarget > 100);
	assert.ok(out.endGap < 10);
	// Measured along the path from where the player stands on it (within the passed first segment).
	assert.ok(out.dist <= out.length + 0.5 && out.dist > out.length - out.second - 0.5, `the yards shown (${out.dist.toFixed(1)}) are the detour's (${out.length.toFixed(1)})`);
});

test('c: walking the path point by point advances the aim, never asks the engine again, and arrives', { skip }, (t) => {
	const out = run(t, `
		place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
		local f = guide()
		local pts = f.points
		local seen, backwards, last, steps, states = {}, 0, 1, 0, {}
		local function look()
			local a = aim()
			states[a.state] = (states[a.state] or 0) + 1
			if a.x then
				local i = indexOf(f, a.x, a.y)
				if i then
					if i < last then backwards = backwards + 1 end
					last = i
					seen[#seen + 1] = i
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
		local distinct = {}
		for _, i in ipairs(seen) do if distinct[#distinct] ~= i then distinct[#distinct + 1] = i end end
		emit({ n = #pts, distinct = distinct, backwards = backwards, finds = #finds, steps = steps, final = aim().state, states = states })`);
	assert.equal(out.backwards, 0, 'the aimed point never goes back');
	assert.deepEqual(out.distinct, Array.from({ length: out.n - 1 }, (_, i) => i + 2), `the aim went through every point after the first, in order, to the last (of ${out.n})`);
	assert.equal(out.finds, 1, `${out.steps} steps along the path, no new search`);
	assert.equal(out.final, 'arrived');
});

test('d: 30+ yards off the path asks once, after the 2 s throttle, keeping the old path meanwhile; the arrow follows the new path', { skip }, (t) => {
	const out = run(t, `
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
		emit(r)`);
	assert.ok(out.off > 30, `${out.off.toFixed(1)} yd off the path`);
	assert.equal(out.soon.finds, 1, `not within 2 s of the last search (${out.soon.since.toFixed(2)} s)`);
	assert.ok(out.soon.index >= 2, 'the old path is kept meanwhile');
	assert.equal(out.stillSoon, 1);
	assert.equal(out.after, 2, 'one new search once 2 s have passed');
	assert.ok(out.new.from < 0.01, 'from where the player stands');
	assert.equal(out.new.index, 2, 'the arrow aims at the new path\'s next point');
	assert.equal(out.settled, 2, 'on the new path nothing more is asked');
});

test('g (row 6, C17): no search starts in combat, the old path is kept, and one runs after combat', { skip }, (t) => {
	const out = run(t, `
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
		r.fight = { finds = #finds, index = indexOf(f, s.x, s.y), state = s.state }
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
		r.follow = { combat = g.combat, from = dist(g.from[1], g.from[2], ox, oy), index = indexOf(g, s.x, s.y) }
		emit(r)`);
	assert.equal(out.fight.finds, 1, 'nothing asked in combat');
	assert.ok(out.fight.index >= 2, 'the old path is kept');
	assert.deepEqual(out.newTarget, { finds: 1, straight: true });
	assert.equal(out.after, 2, 'one search once combat ends');
	assert.equal(out.follow.combat, false);
	assert.ok(out.follow.from < 0.01);
	assert.equal(out.follow.index, 2, 'the arrow follows it');
});

test('Z1: a guide goal at Andron Gant (Undercity, Rogues\' Quarter) is walked to his floor with his height, to the street above without it', { skip }, (t) => {
	const out = run(t, `
		local r = {}
		local ANDRON = { 1389.34, 347.315, -65.96 } -- his CMaNGOS spawn; the guides' 54.81,76.33 (Era) on the Undercity's map
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
		emit(r)`);
	assert.equal(out.targetZ, -65.96, 'the target keeps the waypoint\'s height');
	assert.equal(out.withZ.z, -65.96, 'the walk to him is searched with his height');
	assert.equal(out.withZ.asked, 1, 'once: the path it found ends near that height');
	assert.ok(Math.abs(out.withZ.endZ - out.withZ.z) <= 4, `and ends on his floor (${out.withZ.endZ})`);
	assert.equal(out.withZ.aim, 'travel');
	assert.equal(out.withoutZ.z, undefined, 'the same point set by hand has no height');
	assert.equal(out.withoutZ.asked, 2);
	assert.ok(out.withoutZ.endZ > 20, `and ends on the street ${out.withoutZ.endZ - out.withZ.endZ} yd above him (${out.withoutZ.endZ})`);
});

test('K1: a walk into a cave is split at its mouth from Polestar_Nav\'s Chokepoints.lua, the step named by the cave (Kharanos into the Grizzled Den)', { skip }, (t) => {
	const out = run(t, `
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
		emit({ legs = list, caves = caves, points = finds[#finds] and finds[#finds].points and #finds[#finds].points })`);
	assert.ok(out.caves > 50, `Chokepoints.lua loads with Polestar_Nav (${out.caves} caves on map 0)`);
	const cave = out.legs.find((l) => l.step === 'cave');
	assert.ok(cave, `a cave step: ${JSON.stringify(out.legs)}`);
	assert.equal(cave.choke, 'The Grizzled Den');
	assert.match(cave.label, /Grizzled Den/);
	assert.ok(out.legs.every((l) => typeof l.label === 'string' && l.label !== '' && l.label !== 'Unknown'), 'K1: every step is named');
});

// Review conditions for shipping Polestar's maps (nav-maps): the maps load only with routing on; all of a
// map's files missing from Nav.xml, or a corrupted grid block, leave the straight arrow, never a Lua error
// (one missing part file: tests/nav-load.test.js); every zone the guides walk in routes.
const NAV_DIR = path.join(ADDONS, 'Polestar_Nav', 'Nav');

test('the walking maps load on demand only with Walk real paths on (nav.navRouting off: Polestar_Nav is never loaded)', { skip }, () => {
	const run1 = (routing) => runAddon({
		stubs: ['stub_world.lua', 'stub_encoding.lua', 'stub_packs.lua'],
		before: before(),
		addons: ['Polestar', { name: 'Polestar_Guides', files: ['MapFrames.lua'] }],
		saved: { Polestar: `PolestarDB = { schema = 1, settings = { nav = { navRouting = ${routing} } } }` },
		login: true,
		script: `${PRELUDE}
			place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
			N.SetTarget(1429, 39.5, 82.4, "Fargodeep Mine", "e")
			for _ = 1, 40 do stub.advance(0.05); aim() end
			emit({ loads = stub.packLoads.Polestar_Nav or 0, data = PolestarPathData ~= nil, chokepoints = PolestarNavChokepoints ~= nil, finds = #finds, state = aim().state })`,
	}).emitted[0];
	const off = run1(false);
	assert.deepEqual([off.loads, off.data, off.chokepoints, off.finds], [0, false, false, 0], 'routing off: no maps in memory, no search');
	assert.equal(off.state, 'travel', 'the arrow still points (straight)');
	const on = run1(true);
	assert.deepEqual([on.loads, on.data, on.chokepoints], [1, true, true], 'routing on: loaded once at login');
	assert.ok(on.finds >= 1);
});

// The part file holding the cluster (ADT tile) of a world point on map 0, and that cluster's index.
function clusterFile(wx, wy) {
	const meta = fs.readFileSync(path.join(NAV_DIR, 'Nav0.lua'), 'utf8');
	const num = (k) => Number(new RegExp(`\\t${k} = (-?\\d+),`).exec(meta)[1]);
	const T = 1600 / 3;
	const k = (Math.floor(wx / T) - num('cx0')) * num('ny') + (Math.floor(wy / T) - num('cy0'));
	const file = fs.readdirSync(NAV_DIR).find((f) => /^Nav0_\d+\.lua$/.test(f) && fs.readFileSync(path.join(NAV_DIR, f), 'utf8').includes(`data.packed.grid[${k + 1}] = `));
	return { k, file };
}

function withMaps(files, script) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_encoding.lua', 'stub_packs.lua'],
		before: before().replace(/stub\.packs\.Polestar_Nav = \{[^\n]*\}/, `stub.packs.Polestar_Nav = { ${files.map((f) => JSON.stringify(f)).join(', ')} }`),
		addons: ['Polestar', { name: 'Polestar_Guides', files: ['MapFrames.lua'] }],
		login: true,
		script: `${PRELUDE}\n${script}`,
	}).emitted[0];
}

const STRAIGHT = `
	place(1429, GOLDSHIRE[1], GOLDSHIRE[2], GOLDSHIRE[3])
	local f = guide()
	for _ = 1, 20 do stub.advance(0.05) end
	local a = aim()
	local _, tx, ty = N.GetTargetWorld()
	emit({ state = a.state, toTarget = a.x and dist(a.x, a.y, tx, ty), measured = a.measured, available = E and E.Available(0), points = f and f.points and #f.points or 0, cost = f and f.cost })`;

test('a map whose files are all missing from Nav.xml (every Nav0*.lua) leaves the straight arrow on that map, with no Lua error', { skip }, () => {
	const files = [...tocFiles('Polestar_Nav'), nsFile].filter((f) => !/[\\/]Nav0(_\d+)?\.lua$/.test(f));
	const out = withMaps(files, STRAIGHT);
	assert.equal(out.available, false, 'no data for map 0');
	assert.equal(out.state, 'travel');
	assert.ok(out.toTarget < 1, `the arrow points at the goal itself (${out.toTarget})`);
	assert.notEqual(out.measured, true, 'its distance is the straight one');
});

test('a corrupted grid block of the map leaves the straight arrow for that walk, with no Lua error', { skip }, () => {
	const { k, file } = clusterFile(-9444.062, 77.667);
	assert.ok(file, 'Goldshire\'s cluster is in one part file');
	const bad = path.join(tmpdir('polestar-nav-bad-'), file);
	fs.writeFileSync(bad, fs.readFileSync(path.join(NAV_DIR, file), 'utf8').replace(new RegExp(`^data\\.packed\\.grid\\[${k + 1}\\] = \\{[^}]*\\}$`, 'm'), `data.packed.grid[${k + 1}] = {"bm90IHpsaWI="}`));
	assert.notEqual(fs.readFileSync(bad, 'utf8'), fs.readFileSync(path.join(NAV_DIR, file), 'utf8'));
	const files = [...tocFiles('Polestar_Nav'), nsFile].map((f) => (path.basename(f) === file ? bad : f));
	const out = withMaps(files, STRAIGHT);
	assert.equal(out.available, true, 'the map is there');
	assert.equal(out.points, 0, `no path through the broken cluster (${out.cost})`);
	assert.equal(out.state, 'travel');
	assert.ok(out.toTarget < 1, `the arrow points at the goal itself (${out.toTarget})`);
});

test('every one of the 49 zones the guides walk in routes on the shipped maps (one walk between two of its located goals, 80-400 yd apart), and Zephras Isle on his', { skip }, () => {
	const { Geo } = require('../tools/lib/planner/geo');
	const geo = new Geo(JSON.parse(fs.readFileSync(path.join(DATA, 'map-frames.json'), 'utf8')), JSON.parse(fs.readFileSync(path.join(DATA, 'zones.json'), 'utf8')));
	const src = fs.readFileSync(path.join(ADDONS, 'Polestar_Guides', 'Guides.lua'), 'utf8');
	const byZone = new Map();
	// A goal's coordinates are in the Era frame with f = "e", else the live (Forever) frame (Compat.MapToWorld).
	for (const m of src.matchAll(/map = (\d+), x = ([\d.]+), y = ([\d.]+)(?:, z = -?[\d.]+)?(, f = "e")?/g)) {
		const w = geo.toWorld(+m[1], +m[2], +m[3], m[4] ? 'e' : 'l');
		if (!w || ![0, 1].includes(w.c)) continue;
		if (!byZone.has(+m[1])) byZone.set(+m[1], []);
		byZone.get(+m[1]).push(w);
	}
	// Per zone, up to 6 candidate pairs; the zone passes when one routes (a goal can stand on a ledge or a tree only its own quest reaches).
	const zones = [];
	for (const [map, ws] of [...byZone].sort((a, b) => a[0] - b[0])) {
		const pairs = [];
		for (let i = 0; i < ws.length && pairs.length < 6; i++) {
			for (let j = i + 1; j < ws.length && pairs.length < 6; j++) {
				const d = Math.hypot(ws[i].wx - ws[j].wx, ws[i].wy - ws[j].wy);
				if (ws[i].c === ws[j].c && d >= 80 && d <= 400) pairs.push([ws[i], ws[j]]);
			}
		}
		if (pairs.length) zones.push({ map, c: pairs[0][0].c, pairs });
	}
	const lua = zones.map((z) => `{ ${z.map}, ${z.c}, { ${z.pairs.map(([a, b]) => `{ ${a.wx.toFixed(2)}, ${a.wy.toFixed(2)}, ${b.wx.toFixed(2)}, ${b.wy.toFixed(2)} }`).join(', ')} } }`).join(',\n');
	const zeph = geo.toWorld(2521, 50, 50, 'l');
	const zeph2 = geo.toWorld(2521, 45, 60, 'l');
	const [out] = runAddon({
		stubs: ['stub_encoding.lua'],
		addons: ['Polestar_Nav'],
		script: `
local Path = Polestar_NavEngine
local out = { failed = {}, n = 0 }
for _, z in ipairs({ ${lua} }) do
	out.n = out.n + 1
	local ok = false
	for _, p in ipairs(z[3]) do
		local pts = Path.FindSync(z[2], { x = p[1], y = p[2] }, { x = p[3], y = p[4] })
		if pts then ok = true break end
	end
	if not ok then out.failed[#out.failed + 1] = z[1] end
end
local pts, cost = Path.FindSync(2991, { x = ${zeph.wx}, y = ${zeph.wy} }, { x = ${zeph2.wx}, y = ${zeph2.wy} })
out.zephras = pts and cost or tostring(cost)
emit(out)`,
	}).emitted;
	// The 49 zones of Eastern Kingdoms and Kalimdor the guides walk in (uiMapIDs), pinned so none drops out unseen.
	const ZONES = [1411, 1412, 1413, 1416, 1417, 1418, 1419, 1420, 1421, 1422, 1423, 1424, 1425, 1426, 1427, 1428, 1429, 1430, 1431, 1432, 1433, 1434, 1435, 1436, 1437, 1438, 1439, 1440, 1441, 1442, 1443, 1444, 1445, 1446, 1447, 1448, 1449, 1450, 1451, 1452, 1453, 1454, 1455, 1456, 1457, 1458, 2482, 2548, 2652];
	assert.deepEqual(zones.map((z) => z.map), ZONES, 'the zones tested');
	assert.equal(out.n, ZONES.length);
	assert.deepEqual(Object.values(out.failed), [], 'every zone routes');
	assert.ok(typeof out.zephras === 'number' && out.zephras > 100, `Zephras Isle routes on his map (${out.zephras})`);
});

// Fitz, 2026-10-16: a map marker near Astranaar; the route landed at a flight
// point south-west of it and drew a straight dotted walk over the
// Ashenvale/Stonetalon ridge. Until his coordinates come, the case from the
// description, with what the release zip carries (no local crossing data): a
// Horde character at the Crossroads who knows Sun Rock Retreat, Splintertree
// Post and Zoram'gar Outpost, guided to Ashenvale 40,70, just north-east of
// the ridge. Without crossing data for Kalimdor, straight x1.25 the route
// lands at Sun Rock Retreat, south-west, and walks over the ridge; the
// engine's walk from there runs 365 yd off that line, and from Splintertree
// Post it is 240 yd shorter. With complete crossing data (Carbonite's, in
// TravelData.lua) Sun Rock Retreat's walk must take the Talondeep Path and
// the straight plan lands at Splintertree Post already; either way the
// measured plan lands there and draws its last walk along the engine's path.
test('Ashenvale 40,70 from the Crossroads: the route lands where the engine\'s walk is short (Splintertree Post, not Sun Rock Retreat over the ridge), and its last walk follows the engine\'s path', { skip }, (t) => {
	const out = run(t, `
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
		emit(r)`, { shipped: true });
	const gap = (a, b) => Math.hypot(a[0] - b[0], a[1] - b[1]);
	if (!out.kalimdorCrossings) assert.equal(out.before.lands, 'Sun Rock Retreat, Stonetalon Mountains', 'straight x1.25 lands south-west of the ridge');
	assert.equal(out.before.n, 2, 'and draws its last walk straight');
	assert.ok(out.sunPath.off > 150, `the engine's walk from Sun Rock Retreat runs ${out.sunPath.off.toFixed(0)} yd off that straight line (${out.sunPath.length.toFixed(0)} yd against ${out.straight.sun.toFixed(0)} straight)`);
	assert.ok(out.measured.sun > out.measured.splinter + 150, `measured: Sun Rock Retreat ${out.measured.sun.toFixed(0)} yd, Splintertree Post ${out.measured.splinter.toFixed(0)} yd (straight ${out.straight.sun.toFixed(0)} and ${out.straight.splinter.toFixed(0)})`);
	assert.equal(out.after.lands, 'Splintertree Post, Ashenvale', 'the terrain favours Splintertree Post');
	assert.equal(out.after.engine, 'path', 'its last walk is priced by its path');
	assert.equal(out.after.kind, 'walk');
	assert.ok(out.after.n > 2, `drawn along the engine's ${out.after.n} points, not straight`);
	assert.ok(gap(out.after.first, out.splinter) < 15 && gap(out.after.final, out.target) < 15, 'from Splintertree Post to the marker');
	assert.ok(Math.abs(out.after.yards - out.measured.splinter) < out.measured.splinter * 0.15, `${out.after.yards} yd along the path, ${out.measured.splinter.toFixed(0)} measured`);
});

// The cause itself, pinned (review of travel-terrain): a Horde character at the
// Crossroads who knows Splintertree Post and Zoram'gar Outpost (not Sun Rock
// Retreat), guided to targets west of Astranaar. At one of them the walk from
// the landing straight x1.25 picks measures dearer than straight x1.25 (a
// ridge in the way: its path goes round, over 100 yd off the line) and the
// measured route lands elsewhere; where the walk measures within x1.25 the
// landing stays. Which target shows it depends on the shipped maps: on 0.2.4's
// Ashenvale 35,75 (Splintertree Post 1.38 x straight); on the re-packed maps,
// which close steep faces, Ashenvale 30,70 (Zoram'gar Outpost 1.62 x, its path
// round the ridge 590 yd off the straight line), while 35,75 now sits in a
// pocket every landing reaches about 3 x straight and Splintertree Post is
// still the least of them, so it stays.
test('Ashenvale west of Astranaar: where a ridge makes the straight choice\'s measured walk dearer than straight x1.25, the measured route lands elsewhere', { skip }, (t) => {
	const out = run(t, `
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
		emit(r)`, { shipped: true });
	let ridges = 0;
	for (const c of Object.values(out)) {
		if (!c.before || !c.measured) continue;
		const ratio = c.measured / c.straight;
		if (ratio > 1.25 && c.after !== c.before) {
			ridges++;
			assert.ok(c.off > 100, `${c.at}: the walk from ${c.before} goes round (${c.off.toFixed(0)} yd off the straight line, ${ratio.toFixed(2)} x)`);
		}
		if (ratio <= 1.25) assert.equal(c.after, c.before, `${c.at}: no ridge (${ratio.toFixed(2)} x), the same landing`);
	}
	assert.ok(ridges >= 1, 'a ridge makes one straight choice\'s walk dearer than straight x1.25, and the measured route lands elsewhere');
});
