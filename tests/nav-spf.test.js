'use strict';
// Walking paths (addon/Polestar/Nav/Walk.lua): the arrow follows the walking
// engine vendored from Shortest Path Forever (addon/Polestar_Nav) instead of a
// straight line. A fake engine with deterministic callbacks stands in for
// Polestar_NavEngine: the arrow follows the path's points, straying asks
// again, a new target cancels the stale search, nothing is searched in
// combat, hand-made crossings and guide `goto`s win, and every failure (no
// engine, no data, unreachable, an error, the option off) is today's straight
// arrow. Runs the real Core/Init.lua + Nav/Nav.xml against tests/lua/stub_nav.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const NAV = { name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] };

// The fake engine, installed before the addon loads (Polestar_Nav's API.lua sets the same global).
const ENGINE = `
fake = { calls = {}, avail = {} }
Polestar_NavEngine = {
	Find = function(map, from, to, callback, waterWalking)
		if fake.throw then error("boom") end
		local job = { map = map, from = from, to = to, callback = callback, waterWalking = waterWalking }
		fake.calls[#fake.calls + 1] = job
		return job
	end,
	Cancel = function(job) job.cancelled = true end,
	Busy = function() return false end,
	Available = function(c) return fake.avail[c] ~= false end,
}
function fake.last() return fake.calls[#fake.calls] end
-- Answer the last search with the path x1, y1, x2, y2, ... (UnitPosition frame).
function fake.resolve(...)
	local job, xy, points = fake.last(), { ... }, {}
	for i = 1, #xy - 1, 2 do points[#points + 1] = { map = job.map, x = xy[i], y = xy[i + 1] } end
	job.callback(points, 100, job)
end
function fake.fail(reason)
	local job = fake.last()
	job.callback(nil, reason, job)
end
`;

const PRELUDE = `
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
`;

// The planner's measures (Walk.Measure): the fake engine with Path.FindMany too.
// settle(job, fn) answers a batch with fn(x, y) per target (a cost, or false).
const MANY = `
Polestar_NavEngine.FindMany = function(map, from, targets, callback, waterWalking, reverse)
	local job = { many = true, map = map, from = from, targets = targets, callback = callback, waterWalking = waterWalking, reverse = reverse }
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
	local costs = {}
	for i, p in ipairs(job.targets) do costs[i] = fn(p.x, p.y) end
	job.callback(costs, nil, job)
end
-- Answer one Path.Find with the path x1, y1, x2, y2, ...
function fake.answer(job, ...)
	local xy, points = { ... }, {}
	for i = 1, #xy - 1, 2 do points[#points + 1] = { map = job.map, x = xy[i], y = xy[i + 1] } end
	job.callback(points, 100, job)
end
`;

function run(script, { engine = true, many = false } = {}) {
	return runAddon({
		stubs: ['stub_nav.lua'],
		before: engine ? ENGINE + (many ? MANY : '') : 'fake = { calls = {} }',
		addons: [NAV],
		login: true,
		script: `${PRELUDE}\n${script}`,
	}).emitted;
}

test('the arrow follows the path\'s points, with the yards left along it', () => {
	const [out] = run(`
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
		emit(r)`);
	assert.deepEqual(out.before, ['travel', 600, 0, -600], 'straight until the path is in');
	assert.deepEqual(out.ask, [1, 0, 0, 0, 0, -600], 'one search on the player\'s continent, player to target');
	assert.deepEqual(out.first, ['travel', 683, 100, -100], 'the first corner, and the whole path\'s length');
	assert.deepEqual(out.corner, ['travel', 541, 100, -500], 'a passed point gives way to the next');
	assert.deepEqual(out.along, ['travel', 341, 100, -500]);
	assert.equal(out.arrived, 'arrived', 'arrival is the target\'s radius, as before');
	assert.equal(out.calls, 1, 'walking along the path asks nothing more');
});

test('straying more than 25 yards from the path asks again, at most every 2 seconds, keeping the old path meanwhile', () => {
	const [out] = run(`
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
		emit(r)`);
	assert.equal(out.near, 1, '20 yards off is on the path');
	assert.deepEqual(out.strayAt, ['travel', 417, 0, -300], 'the old path until a new one arrives');
	assert.equal(out.tooSoon, 1, 'not again within 2 seconds of the last search');
	assert.equal(out.later, 2, 'asked again from where the player is');
	assert.deepEqual(out.from, [60, -200]);
	assert.deepEqual(out.after, ['travel', 460, 60, -600]);
});

test('C1, C2: a new target cancels the stale search, whose late answer is dropped, never reviving the old target', () => {
	const [out] = run(`
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
		emit(r)`);
	assert.equal(out.cancelled, true);
	assert.equal(out.calls, 2);
	assert.deepEqual(out.aim, ['travel', 500, 500, 0]);
	assert.deepEqual(out.late, ['travel', 500, 500, 0], 'the old target\'s path is never followed');
});

test('nothing is searched in combat; the search follows once combat ends', () => {
	const [out] = run(`
		local r = {}
		stub.inCombat = true
		nav.place(0, 0)
		target(0, -600)
		r.fight = aim()
		r.inCombat = calls()
		stub.inCombat = false
		aim()
		r.after = calls()
		emit(r)`);
	assert.deepEqual(out.fight, ['travel', 600, 0, -600], 'straight meanwhile');
	assert.equal(out.inCombat, 0);
	assert.equal(out.after, 1);
});

test('hand-made crossings win: the engine walks to the gate, the crossing itself is the data\'s', () => {
	const [out] = run(`
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
		local leg = Polestar.Nav.travel.CurrentLeg()
		r.handmade = leg.handmade == true
		emit(r)`);
	assert.deepEqual(out.toGate, [1, 600, 20], 'searched only up to the gate');
	assert.deepEqual(out.walk, ['travel', 1201, 0, 300], 'along the path to the gate');
	assert.deepEqual(out.crossing, ['travel', 45, 600, -20], 'straight through the gate to its other side');
	assert.equal(out.calls, 1, 'no search across the crossing');
	assert.equal(out.handmade, true);
});

test('a guide goal after a guide goto keeps the straight arrow from the mouth; the goto itself is walked', () => {
	const [out] = run(`
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
		emit(r)`);
	assert.equal(out.mouth, 1, 'the goto is a goal like any other');
	assert.deepEqual(out.inside, ['travel', 450, 0, -450], 'the goal after it is straight');
	assert.equal(out.insideCalls, 1);
	assert.equal(out.afterTalk, 2, 'after a located goal that is no goto, the engine walks again');
});

test('fallbacks: no engine, no data for the continent, unreachable, an error: the straight arrow', () => {
	const [none] = run(`
		nav.place(0, 0)
		target(0, -600)
		emit({ aim(), Polestar.Nav.Path == nil })`, { engine: false });
	assert.deepEqual(none, [['travel', 600, 0, -600], true]);

	const [out] = run(`
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
		emit(r)`);
	assert.deepEqual(out.nodata, [['travel', 600, 0, -600], 0]);
	assert.deepEqual(out.unreachable, ['travel', 500, 0, -500]);
	assert.equal(out.soon, 1, 'a failed search is not repeated at once');
	assert.equal(out.retry, 2, 'but again after 15 s and 25 yards');
	assert.deepEqual(out.error, ['travel', 440, 0, 400]);
});

test('nav.navRouting off: the straight arrow, the search in flight cancelled', () => {
	const [out] = run(`
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
		emit(r)`);
	assert.equal(out.default, true);
	assert.deepEqual(out.aim, ['travel', 600, 0, -600]);
	assert.equal(out.cancelled, true);
	assert.equal(out.calls, 1);
});

test('a ghost\'s walk is searched with water walking', () => {
	const [out] = run(`
		UnitIsGhost = function() return true end
		nav.place(0, 0)
		target(0, -600)
		N.Sample()
		emit(fake.last().waterWalking == true)`);
	assert.equal(out, true);
});

test('route geometry: the walk carries the engine\'s path once in, the straight line before; changes are announced', () => {
	const [out] = run(`
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
		emit(r)`);
	assert.equal(out.none, true);
	assert.deepEqual(out.straight, [1, 'walk', 2, true]);
	assert.equal(out.fired, true);
	assert.deepEqual(out.path, [[0, 0, 0], [0, 100, -100], [0, 100, -500], [0, 0, -600]]);
});

// ---------------------------------------------------------------------------
// Chokepoint steps (docs/NAV_QA.md, K1-K8):
// the walk the arrow is on is split where the engine's path passes a lift,
// gate, bridge, tunnel, pass or a cave or building mouth.

// A straight path west from (0, 0) to the target at (0, -600), with a bridge,
// a nameless cave mouth, a lift (bottom then top landing) along it, and
// chokepoints the split must leave out.
const CHOKES = `
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
`;

const SPLIT = `
nav.useTravelWorld()
${CHOKES}
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
`;

test('K1, K5: a walk is split at the chokepoints on its path, each step named, snapped onto the path', () => {
	const [out] = run(`${SPLIT}
		local legs = N.GetRoute()
		emit({ labels = labels(), first = { legs[1].to.wx, legs[1].to.wy, legs[1].step, legs[1].choke.kind, legs[1].choke.name },
			cave = legs[2].choke.name, lift = { legs[4].kind, legs[4].side, legs[4].to.wy } })`);
	assert.deepEqual(out.labels, [
		'walk|Cross the bridge to Lakeshire',
		'walk|Walk to the cave mouth in Testshire',
		'walk|Walk to The Great Lift, Bottom',
		'lift|Take The Great Lift',
		'walk|Target',
	], 'off-path, start and doubled chokepoints left out; a nameless one is named by its zone, never "Unknown"');
	assert.deepEqual(out.first, [0, -150, 'bridge', 'bridge', 'Lakeshire'], 'K5: the step ends on the path, not at the chokepoint 8 yd off it');
	assert.equal(out.cave, 'Testshire');
	assert.deepEqual(out.lift, ['lift', 'bottom', -520], 'the ride goes to the paired landing');
});

test('K2: the steps stay the same over 10 position updates along a leg, and advance as each is reached', () => {
	const [out] = run(`${SPLIT}
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
		emit({ same = same, calls = calls(), next = Polestar.Nav.travel.CurrentLabel() })`);
	assert.equal(out.same, true);
	assert.equal(out.calls, 1, 'no new search on the way');
	assert.equal(out.next, 'Walk to the cave mouth in Testshire');
});

test('K3, K6: walk steps carry no wait and their times sum exactly to the walk; a lift step carries its timetable wait and caption', () => {
	const [out] = run(`
		nav.useTravelWorld()
		${CHOKES}
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
			total = legs[1].seconds + legs[1].rest, caption = Polestar.Nav.travel.CurrentLabel() })`);
	assert.equal(out.walkSecs, Math.round(600 / 7), 'the pieces add up to the path at run speed');
	assert.equal(out.walkYards, 600);
	assert.deepEqual(out.lift, [60, 7]);
	assert.deepEqual(out.asked, ['lift', 7, 'bottom']);
	assert.equal(out.total, Math.round(600 / 7) + 60);
	assert.equal(out.caption, 'Take The Great Lift\nLeaves in about 0:40');
});

test('K4: a lift\'s side comes from the path\'s direction, not the player\'s height', () => {
	const [out] = run(`
		nav.useTravelWorld()
		${CHOKES}
		nav.place(0, -600)
		target(0, 0)
		N.Sample()
		fake.resolve(0, -600, 0, -300, 0, 0)
		local legs = N.GetRoute()
		local lift
		for _, l in ipairs(legs) do if l.kind == "lift" then lift = l end end
		emit({ legs[1].label, lift.side, lift.to.wy })`);
	assert.deepEqual(out, ['Walk to The Great Lift, Top', 'top', -500]);
});

test('K7: legs under a few yards are dropped and every ETA stays finite', () => {
	const [out] = run(`${SPLIT}
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
		emit({ finite = finite, short = short })`);
	assert.equal(out.finite, true);
	assert.equal(out.short, 0);
});

test('second review: a walk leg takes the engine path\'s length once it arrives', () => {
	const [out] = run(`
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
		emit(r)`);
	assert.deepEqual(out.straight, ['walk', 750, 107, 107, 1], 'straight x1.25 at 7 yd/s before the path');
	const path = 2 * Math.hypot(300, 300);
	assert.deepEqual(out.path, ['walk', Math.round(path), Math.round(path / 7), Math.round(path / 7), 1], 'the path\'s yards, at the same pace');
	assert.equal(out.changes, 1, 'one ROUTE_CHANGED, as a split fires');
	assert.deepEqual(out.progress, [Math.round(path / 7), Math.round(path)], 'Progress agrees with the leg');
	assert.equal(out.calls, 1);
	assert.deepEqual(out.failed, out.straight, 'the search failed: the planner\'s straight estimate again');
	assert.equal(out.again[1], Math.round(Math.hypot(300, 260) + Math.hypot(300, 350)));
	assert.equal(out.cleared[1], Math.round(610 * 1.25), 'the straight estimate again once the path is cleared');
});

test('K8: a hand-made crossing, chain node or guide goto at the same spot keeps its own caption', () => {
	const [out] = run(`
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
		emit(out)`);
	assert.deepEqual(out, ['Cross the bridge to Kept Bridge', 'The mouth']);
});

test("K4: a packed lift's landings a few yards apart: the side boarded comes from the path's height, the ride goes to the other landing", () => {
	const [out] = run(`
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
		emit(r)`);
	assert.deepEqual(out.down, ['Walk to Undervator, Top', 'top', -300], 'going down: board at the top landing, ride to the bottom one');
});

// Floors (docs/NAV_QA.md Z1-Z3): a guide goal at an NPC or object carries its
// spawn's height (`z`, the compiler's) on the Engine's waypoint, and the walk
// to it is searched with that height.
const Z_WAYPOINT = `
local m, x, y = nav.mapPoint(0, -600)
local function goal(z, step) nav.setWaypoint({ map = m, x = x, y = y, z = z, label = "Andron", stepIndex = step or 1, goalIndex = 1, kind = "turnin", r = 5 }) end
-- Answer the last search with points { x, y, z }, ...
local function answer(...)
	local job, pts = fake.last(), {}
	for i, p in ipairs({ ... }) do pts[i] = { map = job.map, x = p[1], y = p[2], z = p[3] } end
	job.callback(pts, 100, job)
end
`;

test('Z1: the Engine waypoint\'s height goes to the walking engine with the target; a hand-set target has none', () => {
	const [out] = run(`${Z_WAYPOINT}
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
		emit(r)`);
	assert.deepEqual(out.withZ, [1, -66, -66], 'the target keeps the waypoint\'s z, and the search asks for it');
	assert.deepEqual(out.kept, ['travel', 1], 'a path ending on that floor is used as it is');
	assert.deepEqual(out.hand, [2, true, true], 'the same spot set by hand: searched again, without a height');
});

test('Z2: a search with the height that fails is asked once more without it, and that answer stands', () => {
	const [out] = run(`${Z_WAYPOINT}
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
		emit(r)`);
	assert.deepEqual(out.retry, [2, true], 'one more search, without z');
	assert.deepEqual(out.used.slice(0, 2), ['travel', Math.round(Math.hypot(100, 300) + Math.hypot(100, 300))], 'its path is the arrow\'s');
	assert.equal(out.calls, 2);
	assert.deepEqual(out.stray, [3, true], 'later searches for the same goal stay without the height');
});

test('Z2: a failure without the height too is the straight arrow, with no third search', () => {
	const [out] = run(`${Z_WAYPOINT}
		nav.place(0, 0)
		goal(-66)
		N.Sample()
		fake.fail("unreachable")
		fake.fail("unreachable")
		emit({ aim(), calls() })`);
	assert.deepEqual(out, [['travel', 600, 0, -600], 2]);
});

test('Z2: a path searched with the height that ends more than 30 yards above or below it is asked again without it', () => {
	const [out] = run(`${Z_WAYPOINT}
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
		emit(r)`);
	assert.deepEqual(out.retry, [2, true, 0], 'asked again without z; the off-floor path is not followed');
	assert.deepEqual(out.used.slice(2), [100, -300], 'the answer without z is the arrow\'s path');
	assert.equal(out.within, 3, 'another goal with a height: searched with it');
	assert.deepEqual(out.close, [3, 'travel'], '25 yards off is within 30: kept');
});

// Walks into the target priced by the walking engine (Walk.Measure, Travel.Remeasured).
// Three flight masters on Testshire, all known, both factions: Home Roost
// (900, 900) where the player stands, Ridge Roost (0, 300) and Road Roost
// (0, -700), each 1700 yards' flight from home. The target (0, 0) is 300 yd
// straight from Ridge Roost and 700 from Road Roost, so straight x1.25 the
// route lands at Ridge Roost; the engine finds Ridge Roost's walk crossing a
// ridge (2000 yd) and Road Roost's short (750 yd).
const TERRAIN = `
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
`;

test('terrain: one reversed FindMany from the target prices the walks into it; the route then lands where the walk is short, once', () => {
	const [out] = run(`${TERRAIN}
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
		emit(r)`, { many: true });
	assert.deepEqual(out.before, { lands: 'Ridge Roost, Testshire', yards: 375, seconds: 54, engine: false }, 'straight x1.25 before the measure');
	assert.equal(out.batch.n, 1, 'one batch for the target');
	assert.equal(out.batch.map, 0);
	assert.deepEqual(out.batch.from, [0, 0], 'from the target');
	assert.equal(out.batch.reverse, true, 'reversed: each cost is the walk from that place to the target');
	assert.equal(out.batch.water, false);
	assert.deepEqual(out.batch.targets.slice().sort(), [[0, -700], [0, 300], [900, 900], [900, 900]].sort(), 'the player and the three flight masters');
	assert.equal(out.changes, 1, 'one replan once the measure lands');
	assert.deepEqual(out.after, { lands: 'Road Roost, Testshire', yards: 750, seconds: 107, engine: 'cost' }, 'Road Roost: its measured walk, at 7 yd/s');
	assert.deepEqual(out.again, out.after, 'later plans keep the measure: no flip-flop');
	assert.equal(out.batches, 1, 'and ask for no second batch');
});

test('terrain: a measure that keeps the way keeps the route and its progress, its later walk taking the measured price (review 8)', () => {
	const [out] = run(`${TERRAIN}
		nav.place(900, 900)
		target(0, 0)
		N.Sample()
		local legs = N.GetRoute()
		local before = changes
		fake.settle(fake.of(true)[1], function(x, y) return math.floor(math.sqrt(x * x + y * y) * 1.1) end)
		local after = N.GetRoute()
		local r = route()
		emit({ same = legs == after, changes = changes - before, lands = r.lands, yards = r.yards, seconds = r.seconds, engine = r.engine })`, { many: true });
	assert.deepEqual(out, { same: true, changes: 1, lands: 'Ridge Roost, Testshire', yards: 330, seconds: 47, engine: 'cost' }, 'the same legs, the last walk at its measure (300 x 1.1) instead of straight x1.25');
});

test('terrain fallbacks: a place the engine finds no walk from, or none found at all, keeps the straight estimate', () => {
	const [out] = run(`${TERRAIN}
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
		emit(r)`, { many: true });
	assert.deepEqual(out.one, { lands: 'Ridge Roost, Testshire', yards: 375, seconds: 54, engine: false });
	assert.equal(out.none.lands, 'Ridge Roost, Testshire');
	assert.equal(out.none.engine, false);
	assert.equal(out.batches, 2, 'a target whose measure found nothing is not asked again');
});

test('terrain: nothing is measured in combat (owed until it ends) or while Shortest Path Forever guides', () => {
	const [out] = run(`${TERRAIN}
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
		emit(r)`, { many: true });
	assert.equal(out.fight, 0, 'no search at all in combat');
	assert.equal(out.after, 1, 'the owed measure once combat ends');
	assert.equal(out.handedOff, 1, 'nothing more while handed off');
});

test('terrain: a new target cancels the stale measure; a measured target is kept and not asked again', () => {
	const [out] = run(`${TERRAIN}
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
		emit(r)`, { many: true });
	assert.equal(out.cancelled, true);
	assert.equal(out.stale, false, 'the old target\'s measure never prices the new one');
	assert.equal(out.back, 3, 'the first target, never measured, is asked again');
	assert.equal(out.first, 'Road Roost, Testshire');
	assert.equal(out.kept, 3, 'the second target\'s measure is kept');
	assert.equal(out.second, 'cost');
});

// A crossing world (as complete crossing data lays it out): West Vale and
// East Vale meet at a gate (600, 20) / (600, -20). The player stands 100 yd
// from Home Roost (900, 900) in West Vale; the target (600, -300) lies in
// East Vale. The route: walk to Home Roost, fly to Gate Roost (400, 300),
// walk to the gate, through it (hand-made), on to the target (hand-made:
// from a crossing end).
const CROSSING = `
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
`;

test('crossings: the walk from a crossing end is priced by the measure but stays hand-made; later non-hand-made walks are searched after the arrow\'s own, drawn and priced by their path', () => {
	const [out] = run(`${CROSSING}
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
		r.finds = #fake.of(false)
		T.Replan()
		r.replanned = legsNow()
		r.cached = #fake.of(false)
		emit(r)`, { many: true });
	assert.deepEqual(out.plan.map((l) => [l[0], l[1]]), [['walk', false], ['fly', false], ['walk', false], ['walk', true], ['walk', true]], 'to Home Roost, fly, to the gate, through it, on to the target');
	assert.deepEqual(out.order, ['many', 'find'], 'the measure, then the arrow\'s own walk to Home Roost');
	assert.equal(out.places, 5, 'the player, both flight masters and both crossing ends');
	assert.equal(out.waitOwn, 1, 'later walks wait for the arrow\'s own search');
	assert.deepEqual(out.leg, [2, 400, 300, 600, 20], 'then Gate Roost to the gate is searched');
	assert.deepEqual(out.straight.slice(2), [['walk', 2], ['walk', 2], ['walk', 2]], 'straight until its path is in');
	const path = 100 + Math.hypot(100, 280);
	assert.deepEqual(out.priced[2], ['walk', false, Math.round(path), 'path'], 'priced by its path');
	assert.deepEqual(out.drawn[2], ['walk', 3], 'drawn along it');
	assert.deepEqual(out.drawn.slice(3), [['walk', 2], ['walk', 2]], 'the hand-made walks stay straight');
	assert.equal(out.finds, 2, 'the hand-made walks are never searched');
	assert.deepEqual(out.replanned[4], ['walk', true, Math.floor(280 * 1.1), 'cost'], 'the last walk, from the crossing end, is priced by the measure');
	assert.deepEqual(out.replanned[2], ['walk', false, Math.round(path), 'path'], 'a fresh plan takes the kept path');
	assert.equal(out.cached, 2, 'and searches nothing again');
});

test('later walks: a search whose walk leaves the route is cancelled; none starts in combat', () => {
	const [out] = run(`${CROSSING}
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
		emit(r)`, { many: true });
	assert.equal(out.fight, 1, 'no later walk is searched in combat');
	assert.equal(out.after, 2, 'it is once combat ends');
	assert.equal(out.cancelled, true, 'a new target drops it');
});

// Review of travel-terrain (2026-10-16): each fix with the test that fails without it.

test('review 1: past 50 yd from where it was measured, the player\'s walk is never priced above the straight distance, and the next plan measures it again', () => {
	const [out] = run(`${TERRAIN}
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
		emit(r)`, { many: true });
	assert.equal(out.here, 660);
	assert.equal(out.closer, 560, 'the measure less the yards moved, while it beats straight');
	assert.equal(out.aside, 500, 'never above the straight distance x1.0 (not straight x1.25)');
	assert.equal(out.batches, 2, 'walked away: measured again with the next plan');
	assert.ok(out.points.some(([x, y]) => x === 300 && y === 400), 'from where the player now stands');
});

// Two gates between West Vale and East Vale: North Gate (600, +-20) and South
// Gate (-600, +-20). The player (0, 500) in West Vale, the target (100, -500)
// in East Vale: straight, the north gate is nearer; the engine finds the walk
// from the north gate's far end long (a ridge) and the south one's short.
const GATES = `
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
`;

test('review 2: a measure that sends the route through another crossing replaces it (not "the same way")', () => {
	const [out] = run(`${GATES}
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
		emit(r)`, { many: true });
	assert.equal(out.before, 'north');
	assert.equal(out.after, 'south', 'the measured way goes through the south gate');
});

test('review 3: the last walk to a target after a guide goto is never searched, drawn or priced along an engine path', () => {
	const [out] = run(`${TERRAIN}
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
		emit(r)`, { many: true });
	assert.equal(out.finds, 1, 'only the arrow\'s own walk is searched');
	assert.deepEqual(out.last, ['walk', 'cost', 2], 'priced by the measure, drawn straight from the mouth');
});

// A boat from Testshire Docks (-900, 0) to Farland Pier (c1: 400, 0); on Farland,
// Pier Roost (300, 0) flies to Far Roost (-400, 0); the target (-400, -300).
const BOAT = `
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
`;

test('review 4: after ROUTE_ADVANCED (off the boat) the arrow\'s own walk is searched before any later walk', () => {
	const [out] = run(`${BOAT}
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
		emit(r)`, { many: true });
	assert.deepEqual(out.aboard, ['boat walk fly walk', 0]);
	assert.deepEqual(out.first, [[300, 0]], 'the arrow\'s walk to Pier Roost first, alone');
	assert.deepEqual(out.then_, [-400, -400, -300], 'then Far Roost to the target');
});

test('review 5: the target\'s height goes with the measure (once more without it when it finds nothing) and with the last walk\'s search', () => {
	const [out] = run(`${TERRAIN}
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
		emit(r)`, { many: true });
	assert.equal(out.batchZ, -40, 'from the target at its height');
	assert.equal(out.retryZ, 'none', 'a batch with it that finds nothing: once more without it');
	assert.equal(out.legZ, -40, 'the last walk is searched to the target\'s floor');
});

test('review 6: a target inside an approach chain is walked from its mouth by the chain\'s straight link, never priced by the measure', () => {
	const [out] = run(`
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
		emit({ #legs, last.handmade == true, last.yards, last.engine or false })`, { many: true });
	assert.deepEqual(out, [2, true, Math.round(190 * 1.25), false]);
});

test('review 7: a later walk searched alive is not the ghost\'s (water walking): its path is kept per water mode', () => {
	const [out] = run(`${CROSSING}
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		fake.settle(fake.of(true)[1], function(x, y) return math.floor(math.sqrt((x - 600) ^ 2 + (y + 300) ^ 2) * 1.1) end)
		fake.answer(fake.of(false)[1], 900, 800, 900, 900)
		fake.answer(fake.of(false)[2], 400, 300, 500, 300, 600, 20)
		local from, to = { c = 0, wx = 400, wy = 300 }, { c = 0, wx = 600, wy = 20 }
		local alive = N.walk.LegPath(from, to)
		UnitIsGhost = function() return true end
		emit({ alive = alive and floor(alive + 0.5), ghost = N.walk.LegPath(from, to) or false })`, { many: true });
	assert.equal(out.alive, Math.round(100 + Math.hypot(100, 280)));
	assert.equal(out.ghost, false);
});

test('review 10: a later walk priced by its path times the boat after it again by the timetable', () => {
	const [out] = run(`
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
		emit({ before = before, after = legsNow() })`, { many: true });
	const walkBefore = out.before[2][1];
	const walkAfter = out.after[2][1];
	assert.equal(out.before[2][0], 'walk');
	assert.ok(walkAfter > walkBefore, `the walk to the docks along its path (${walkAfter} s, straight ${walkBefore} s)`);
	assert.equal(out.after[3][0], 'boat');
	// Its leg times up to the boat's landing: the boat still leaves at 1000 s and lands at 1060.
	const landing = (legs) => legs.slice(0, 4).reduce((sum, l) => sum + l[1], 0);
	assert.ok(Math.abs(landing(out.before) - 1060) <= 2, `planned: lands at ${landing(out.before)} s`);
	assert.equal(landing(out.after), 1060, 'retimed: the wait shrinks by the longer walk');
});

test('test gap: a measure that lands on a boat is weighed once ashore', () => {
	const [out] = run(`${BOAT}
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
		emit(r)`, { many: true });
	assert.deepEqual(out.atSea, [true, 'boat walk fly walk'], 'the route stays while sailing');
	assert.equal(out.stillAtSea, 'boat walk fly walk', 'and on a Refresh at sea');
	assert.equal(out.ashore, 'walk', 'ashore it is weighed: the walk from the pier beats Far Roost\'s ridge');
});

test('test gap: a taxi defers the measure\'s replan to the landing', () => {
	const [out] = run(`${TERRAIN}
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
		emit({ inAir = inAir, landed = route().lands })`, { many: true });
	assert.deepEqual(out.inAir, [true, 'Ridge Roost, Testshire']);
	assert.equal(out.landed, 'Road Roost, Testshire');
});

test('test gap: handed off to Shortest Path Forever, Refresh cancels the measure and the later walk in flight', () => {
	const [out] = run(`${CROSSING}
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
		emit(r)`, { many: true });
	assert.equal(out.measure, true);
	assert.deepEqual(out.legFrom, [400, 300], 'the later walk was in flight');
	assert.equal(out.leg, true);
});
