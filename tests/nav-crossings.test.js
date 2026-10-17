'use strict';
// Zone crossings in the travel planner (addon/Polestar/Nav/Travel.lua,
// Nav.RegisterCrossings): routes between zones go through crossing waypoints,
// captions follow the direction, open-ground pairs walk straight, approach
// chains are entered at their mouth, and the re-plan triggers. Runs the real
// Core/Init.lua + Nav/Nav.xml against tests/lua/stub_nav.lua's travel world.
//
// Map 9000 "Testshire" (wx, wy 1000..-1000) is split into two zones here:
// West Vale (9002, wy 1000..0) and East Vale (9003, wy 0..-1000), joined by a
// gate at (600, +-20).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ROOT } = require('./helpers/lua');
const { luaLiteral } = require('../tools/lib/travel/route');

const NAV = { name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] };

const PRELUDE = `
local N = Polestar.Nav
local A = N.arrow
local nav = stub.nav
local function target(wx, wy, label)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, label or "Target")
end
local function route()
	local legs, ci = N.GetRoute()
	local out = {}
	for i = ci or 1, legs and #legs or 0 do
		local l = legs[i]
		out[#out + 1] = l.kind .. "|" .. l.label
	end
	return out
end
local function known(...)
	local flags = Polestar.CharState().flags
	flags.taxi = {}
	for _, id in ipairs({ ... }) do flags.taxi[id] = true end
end
local ZONES = {
	[9002] = { name = "West Vale", c = 0, top = 1000, bottom = -1000, left = 1000, right = 0 },
	[9003] = { name = "East Vale", c = 0, top = 1000, bottom = -1000, left = 0, right = -1000 },
}
local GATE = { id = "gate", a = { map = 9002, c = 0, wx = 600, wy = 20, r = 15 }, b = { map = 9003, c = 0, wx = 600, wy = -20, r = 15 },
	ab = "Through the gate to East Vale" }
local function crossings(extra)
	local d = { complete = true, zones = ZONES, crossings = { GATE } }
	for k, v in pairs(extra or {}) do d[k] = v end
	N.RegisterCrossings(d)
end
`;

function run(script) {
	return runAddon({
		stubs: ['stub_nav.lua'],
		addons: [NAV],
		login: true,
		script: `${PRELUDE}
nav.faction = "Alliance"
nav.useTravelWorld()
${script}`,
	}).emitted;
}

test('a route into another zone goes through the crossing, not a straight line; no crossing data walks as before', () => {
	const [out] = run(`
		local r = {}
		nav.place(-500, 500)                             -- West Vale
		target(-500, -500, "Kobolds")                    -- East Vale
		r.before = route()
		crossings()
		target(-500, -500, "Kobolds")
		r.after = route()
		local legs = N.GetRoute()
		r.first = { legs[1].to.wx, legs[1].to.wy, legs[1].to.map, legs[1].radius, legs[1].waypoint }
		r.second = { legs[2].to.wx, legs[2].to.wy, legs[2].to.map }
		r.total = legs[1].seconds + legs[1].rest
		emit(r)`);
	assert.deepEqual(out.before, ['walk|Kobolds'], 'without crossing data: one straight walk');
	assert.deepEqual(out.after, ['walk|Through the gate to East Vale', 'walk|Through the gate to East Vale', 'walk|Kobolds']);
	assert.deepEqual(out.first, [600, 20, 9002, 15, true], 'the gate on the West Vale side, with its radius');
	assert.deepEqual(out.second, [600, -20, 9003]);
	const yards = Math.hypot(1100, 480) * 2 + 40;
	assert.ok(Math.abs(out.total - (yards * 1.25) / 7) < 3, `real seconds follow the walked line (${out.total} s)`);
});

test('captions follow the direction; a crossing without one says where it goes', () => {
	const [out] = run(`
		crossings()
		nav.place(-500, -500)                            -- East Vale, heading west
		target(-500, 500)
		emit(route())`);
	assert.deepEqual(out, ['walk|Go to West Vale', 'walk|Go to West Vale', 'walk|Target']);
});

test('an open-ground pair walks straight across the border; a one-way pair only one way', () => {
	const [out] = run(`
		local r = {}
		crossings({ open = { 9002, 9003, 0 } })
		nav.place(-500, 500)
		target(-500, -500)
		r.open = route()
		N.RegisterTravelData({}, true)
		nav.useTravelWorld()
		crossings({ open = { 9002, 9003, 1 } })          -- West -> East only
		nav.place(-500, 500)
		target(-500, -500)
		r.oneWayWith = route()
		nav.place(-500, -500)
		target(-500, 500)
		r.oneWayAgainst = route()
		emit(r)`);
	assert.deepEqual(out.open, ['walk|Target']);
	assert.deepEqual(out.oneWayWith, ['walk|Target']);
	assert.deepEqual(out.oneWayAgainst, ['walk|Go to West Vale', 'walk|Go to West Vale', 'walk|Target']);
});

test('an approach chain is entered only at its mouth, and left the way it came', () => {
	const [out] = run(`
		local r = {}
		crossings({ chains = { { id = "den", name = "The Den", open = "mouth", nodes = {
			{ map = 9003, c = 0, wx = 0, wy = -300, r = 15, caption = "Enter the cave" },
			{ map = 9003, c = 0, wx = -100, wy = -300, r = 15, caption = "Follow the path" },
			{ map = 9003, c = 0, wx = -100, wy = -400, r = 15, caption = "Enter the Den" },
		} } } })
		nav.place(-100, -500)                            -- 90 yd from the target, but outside the cave
		target(-110, -410, "Den boss")                   -- inside, next to the last node
		r.into = route()
		local legs = N.GetRoute()
		r.firstTo = { legs[1].to.wx, legs[1].to.wy }
		nav.place(-105, -405)                            -- inside the cave
		target(300, -300, "Outside")
		r.out = route()
		nav.place(400, -700)                             -- an outside target is never reached through the cave
		target(300, -300, "Outside")
		r.outside = route()
		emit(r)`);
	assert.deepEqual(out.into, ['walk|Enter the cave', 'walk|Follow the path', 'walk|Den boss']);
	assert.deepEqual(out.firstTo, [0, -300], 'the first waypoint is the mouth');
	assert.deepEqual(out.out, ['walk|Follow the path out', 'walk|Follow the path out', 'walk|Outside']);
	assert.deepEqual(out.outside, ['walk|Outside']);
});

test('a crossing set that is not complete (recorded crossings) leaves walking as before', () => {
	const [out] = run(`
		N.RegisterCrossings({ complete = false, zones = ZONES, crossings = { GATE } })
		nav.place(-500, 500)
		target(-500, -500)
		emit({ route(), #(Polestar.Nav.travel.CrossingCounts()) })`);
	assert.deepEqual(out, [['walk|Target'], 0]);
});

test('the arrow shows the leg caption, aims at the waypoint, advances inside its radius and re-plans there', () => {
	const [out] = run(`
		local r, changes, advanced = {}, 0, 0
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		Polestar.On("ROUTE_ADVANCED", function() advanced = advanced + 1 end)
		crossings()
		nav.place(-500, 500)
		target(-500, -500, "Kobolds")
		stub.advance(0.2)
		r.walk = { A.GetMode(), A.distText:GetText(), A.labelText:GetText() }
		local before = changes
		nav.place(590, 30)                               -- 14 yd from the gate: inside its 15 yd radius
		stub.advance(0.2)
		r.advanced = advanced
		r.at = { A.distText:GetText(), A.labelText:GetText() }
		stub.advance(1.2)                                -- the ticker plans again from here
		r.replanned = changes - before
		r.route = route()
		nav.place(600, -40)                              -- through the gate, now in East Vale
		stub.fire("ZONE_CHANGED_NEW_AREA")
		r.zone = route()
		stub.advance(0.2)
		r.after = { A.labelText:GetText() }
		emit(r)`);
	assert.deepEqual(out.walk, ['travel', '1200 yd', 'Through the gate to East Vale']);
	assert.equal(out.advanced, 1);
	assert.deepEqual(out.at, ['51 yd', 'Through the gate to East Vale'], 'now aiming at the far side of the gate');
	assert.equal(out.replanned, 1, 'arriving at a waypoint plans again');
	assert.deepEqual(out.route, ['walk|Through the gate to East Vale', 'walk|Kobolds']);
	assert.deepEqual(out.zone, ['walk|Kobolds'], 'a zone change plans again');
	assert.deepEqual(out.after, ['Kobolds'], 'the last leg shows the target');
});

test('moving more than 50 yd re-plans once the plan is 30 s old, at most once a second, and only with crossing data', () => {
	const [out] = run(`
		local r, changes = {}, 0
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		local function walk(seconds)
			for _ = 1, seconds do
				local p = nav.player
				nav.place(p.wx + 5, p.wy - 1)
				stub.advance(1)
			end
		end
		nav.place(-500, 500)
		target(-500, -500)
		local c0 = changes
		walk(40)                                         -- 200 yd in 40 s, no crossing data
		r.plain = changes - c0
		crossings()
		nav.place(-500, 500)
		target(-500, -500)
		c0 = changes
		walk(25)
		r.early = changes - c0                           -- moved 125 yd, but the plan is younger than 30 s
		walk(6)
		r.late = changes - c0
		walk(5)
		r.after = changes - c0                           -- the new plan is young again
		emit(r)`);
	assert.equal(out.plain, 0, 'no crossing data: no movement re-plans');
	assert.equal(out.early, 0);
	assert.equal(out.late, 1);
	assert.equal(out.after, 1);
});

test('learning a flight path re-plans with it', () => {
	const [out] = run(`
		ERR_NEWTAXIPATH = "New flight path discovered!"
		known(2)
		nav.place(0, 785)                                -- at West Hold, not yet known
		target(0, -780)
		local before = route()
		stub.fire("UI_INFO_MESSAGE", 0, "Something else")
		local other = route()
		stub.fire("UI_INFO_MESSAGE", 0, ERR_NEWTAXIPATH)
		emit({ before = before, other = other, after = route(), saved = Polestar.CharState().flags.taxi[1] == true })`);
	assert.deepEqual(out.before, ['walk|Target']);
	assert.deepEqual(out.other, ['walk|Target']);
	assert.deepEqual(out.after, ['fly|Fly to East Hold', 'walk|Target']);
	assert.equal(out.saved, true);
});

test('a flight lands in the right zone: the walk after it crosses at the gate', () => {
	const [out] = run(`
		crossings()
		known(1, 2)
		nav.place(0, 600)                                -- West Vale, near West Hold
		target(500, 300, "Mine")                         -- West Vale, far from the gate
		local west = route()
		target(-500, -500, "Camp")                       -- East Vale: fly to East Hold, walk from there
		emit({ west = west, east = route() })`);
	assert.deepEqual(out.west, ['walk|Mine']);
	assert.deepEqual(out.east, ['walk|Walk to the flight master', 'fly|Fly to East Hold', 'walk|Camp']);
});

// The local crossings (addon/Polestar_Travel, built by `travel build` from the
// optional local crossings file) with the committed TravelData.lua: real
// routes go through the real gates, and planning stays cheap.
const LOCAL = path.join(ROOT, 'addon', 'Polestar_Travel', 'Crossings.lua');
const DATA = path.join(ROOT, 'data', 'forever', 'map-frames.json');
test('the local crossings route real trips through their gates, within the planner budget', { skip: !(fs.existsSync(LOCAL) && fs.existsSync(DATA)) && 'no local crossings built' }, () => {
	const era = JSON.parse(fs.readFileSync(DATA, 'utf8')).era;
	const world = (map, x, y) => {
		const b = era[String(map)];
		return { c: b.c, wx: b.top + ((b.bottom - b.top) * y) / 100, wy: b.left + ((b.right - b.left) * x) / 100, map };
	};
	const trips = [
		['Horde', world(1411, 52, 43), world(1454, 50, 60)], // Razor Hill -> Orgrimmar
		['Horde', world(1413, 52, 30), world(1441, 40, 40)], // the Crossroads -> Thousand Needles (the Great Lift)
		['Alliance', world(1429, 42, 65), world(1453, 60, 60)], // Goldshire -> Stormwind
		['Alliance', world(1426, 47, 52), world(1432, 35, 47)], // Kharanos -> Thelsamar
	];
	const [out] = runAddon({
		stubs: ['stub_nav.lua'],
		addons: [NAV],
		login: true,
		script: `
			assert(loadfile(${luaLiteral(LOCAL)}))("Polestar_Travel", {})
			local N = Polestar.Nav
			local list, crossings, open, chains = N.travel.CrossingCounts()
			local out = { covered = list, crossings = crossings, open = open, chains = chains, routes = {} }
			local trips = ${luaLiteral(trips)}
			local t0 = os.clock()
			for i, t in ipairs(trips) do
				local legs = N.PlanRoute({ c = t[2].c, wx = t[2].wx, wy = t[2].wy, map = t[2].map, faction = t[1] == "Horde" and 2 or 1,
					known = {}, target = { c = t[3].c, wx = t[3].wx, wy = t[3].wy, map = t[3].map, label = "Target" } })
				local r = {}
				for _, l in ipairs(legs or {}) do r[#r + 1] = l.label end
				out.routes[i] = r
			end
			out.ms = (os.clock() - t0) * 1000 / #trips
			emit(out)`,
	}).emitted;
	assert.deepEqual(out.covered, [0, 1]);
	assert.ok(out.crossings >= 40 && out.open >= 8 && out.chains >= 7, JSON.stringify(out));
	assert.deepEqual(out.routes[0], ['Enter Orgrimmar', 'Enter Orgrimmar', 'Target']);
	assert.equal(out.routes[1][0], 'Enter the Thousand Needles and ride the elevator down');
	assert.deepEqual(out.routes[2], ['Enter Stormwind City', 'Enter Stormwind City', 'Target']);
	assert.ok(out.routes[3].some((l) => /Loch Modan/.test(l)), `Dun Morogh -> Loch Modan crosses a tunnel: ${out.routes[3]}`);
	assert.ok(out.ms < 20, `a plan with crossings took ${out.ms.toFixed(1)} ms`);
});

test('a start already past a crossing\'s near end walks on to its far end, never back', () => {
	const [out] = run(`
		local r = {}
		local ROAD = { id = "road", a = { map = 9002, c = 0, wx = 600, wy = 300, r = 15 }, b = { map = 9003, c = 0, wx = 600, wy = -300, r = 15 } }
		crossings({ crossings = { ROAD } })
		nav.place(-500, 500)                             -- West Vale, before the road
		target(-500, -500, "Kobolds")
		r.before = route()
		nav.place(600, 100)                              -- on the road: 200 yd past its West Vale end, still in West Vale
		target(-500, -500, "Kobolds")
		r.on = route()
		local legs = N.GetRoute()
		r.firstTo = { legs[1].to.wx, legs[1].to.wy, legs[1].radius, legs[1].waypoint }
		nav.place(300, 100)                              -- 300 yd off the road: not on it
		target(-500, -500, "Kobolds")
		local off = N.GetRoute()
		r.offTo = { off[1].to.wx, off[1].to.wy }
		emit(r)`);
	assert.deepEqual(out.before, ['walk|Go to East Vale', 'walk|Go to East Vale', 'walk|Kobolds']);
	assert.deepEqual(out.on, ['walk|Go to East Vale', 'walk|Kobolds'], 'straight on to the far end');
	assert.deepEqual(out.firstTo, [600, -300, 15, true]);
	assert.deepEqual(out.offTo, [600, 300], 'off the road the near end comes first, as before');
});

test('skipping a crossing\'s near end walks on; later plans near the crossing walk on too, farther off the near end comes first again', () => {
	const [out] = run(`
		local r, changes = {}, 0
		local ROAD = { id = "road", a = { map = 9002, c = 0, wx = 600, wy = 300, r = 15 }, b = { map = 9003, c = 0, wx = 600, wy = -300, r = 15 } }
		crossings({ crossings = { ROAD } })
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		nav.place(-500, 500)
		target(-500, -500, "Kobolds")
		stub.advance(0.2)
		local c0 = changes
		N.travel.SkipLeg()
		stub.advance(1.2)
		r.replanned = changes - c0
		r.skip = route()
		local function first()
			local legs = N.GetRoute()
			return { legs[1].to.wx, legs[1].to.wy }
		end
		nav.place(450, 200)                              -- off the road, but nearer its far end than its ends are apart
		stub.fire("ZONE_CHANGED")
		r.near = first()
		nav.place(300, 500)                              -- elsewhere in West Vale, farther from the far end than that
		stub.fire("ZONE_CHANGED")
		r.far = first()
		nav.place(450, 200)
		target(-400, -500, "Elsewhere")                  -- another target: the near end counts again
		r.other = first()
		emit(r)`);
	assert.equal(out.replanned, 0, 'skipping the near end moves on without planning back to it');
	assert.deepEqual(out.skip, ['walk|Go to East Vale', 'walk|Kobolds']);
	assert.deepEqual(out.near, [600, -300], 'near the crossing the skipped end stays skipped');
	assert.deepEqual(out.far, [600, 300], 'far from it the skip never walks straight over the zone border');
	assert.deepEqual(out.other, [600, 300]);
});

// #237: on the Gold Road north out of the Barrens the real crossing's two ends
// (Nav/TravelData.lua, carbonite-ashenvale--the-barrens) are about 510 yd
// apart. Past the Barrens end, a plan made again before the client says
// Ashenvale (a subzone change, or 50 yd walked once the plan is 30 s old) must
// keep heading north, not send the player back to the Barrens end.
test('the Barrens to Ashenvale road: plans made between the crossing\'s ends keep heading north (#237)', () => {
	const [out] = runAddon({
		stubs: ['stub_nav.lua'],
		addons: [NAV],
		login: true,
		script: `
			local N, nav = Polestar.Nav, stub.nav
			nav.faction = "Horde"
			nav.maps[1413] = { name = "The Barrens", c = 1, top = 1612.5, bottom = -5143.75, left = 2622.917, right = -7510.417 }
			nav.maps[1440] = { name = "Ashenvale", c = 1, top = 4672.917, bottom = 829.167, left = 1700, right = -4066.667 }
			-- The client calls everything here the Barrens until the player is through.
			function nav.Compat.GetPlayerMapPosition()
				local p, b = nav.player, nav.maps[1413]
				return 1413, (p.wy - b.left) / (b.right - b.left) * 100, (p.wx - b.top) / (b.bottom - b.top) * 100
			end
			local function first()
				local legs, ci = N.GetRoute()
				local l = legs and legs[ci or 1]
				return l and { l.to.wx, l.to.wy } or nil
			end
			local r, back = {}, {}
			nav.place(500, -2290, 1)                         -- the Gold Road, south of the crossing
			N.SetTarget(1440, 68.60, 89.10, "Kadrak")       -- the report's waypoint
			local legs = N.GetRoute()
			local near, far = legs[1].to, legs[2].to
			r.ends = { legs[1].waypoint, legs[2].waypoint, math.floor(math.sqrt((far.wx - near.wx) ^ 2 + (far.wy - near.wy) ^ 2)) }
			-- Walk north up the road at running speed from the Barrens end, still in the Barrens.
			nav.place(near.wx - 5, near.wy, 1)
			stub.advance(0.2)
			stub.advance(1.2)
			for wx = near.wx, near.wx + 280, 7 do
				nav.place(wx, -2290, 1)
				stub.advance(1)
				local f = first()
				if f and f[1] == near.wx and f[2] == near.wy then back[#back + 1] = math.floor(wx) end
			end
			r.back = table.concat(back, ",")
			-- The report's spot: a subzone change there plans again.
			nav.place(1042, -2292, 1)
			stub.fire("ZONE_CHANGED")
			r.zone = first()
			r.far = { far.wx, far.wy }
			emit(r)`,
	}).emitted;
	assert.deepEqual(out.ends.slice(0, 2), [true, true], 'the route goes through the crossing');
	assert.ok(out.ends[2] > 400, `the crossing's ends are far apart (${out.ends[2]} yd)`);
	assert.equal(out.back, '', 'walking north, no plan sends the player back to the Barrens end (the wx where one did)');
	assert.deepEqual(out.zone, out.far, 'a subzone change between the ends keeps heading for the Ashenvale end');
});
