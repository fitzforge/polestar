'use strict';
// Walking paths (addon/Polestar/Nav/Walk.lua): the arrow follows the walking
// router started from Shortest Path Forever's (addon/Polestar_Nav) instead of a
// straight line. A fake engine with deterministic callbacks stands in for
// Polestar_NavEngine: the arrow follows the path's points, straying asks
// again, a new target cancels the stale search, nothing is searched in
// combat, hand-made crossings and guide `goto`s win, and every failure (no
// engine, no data, unreachable, an error, the option off) is today's straight
// arrow. Runs the real Core/Init.lua + Nav/Nav.xml against tests/lua/stub_nav.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { runAddon, ADDONS } = require('./helpers/lua');

const NAV = { name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] };

// The fake engine, installed before the addon loads (Polestar_Nav's API.lua sets the same global).
// The fifth argument is the waterWalking flag or opts { waterWalking, profile, style }
// (Routing/Path.lua); a job keeps both. Answers carry job.yards (the drawn
// line's length) and job.hubs (fake.hubs: the hostile towns it enters).
const ENGINE = `
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
	-- fake.releases Path.ReleaseSurfaces.
	SurfacesAt = function(map, x, y, out)
		if fake.surfacesError then error("bad cluster") end
		if fake.undecoded then return nil end
		fake.reads = (fake.reads or 0) + 1
		local list = fake.surfaces and fake.surfaces(map, x, y) or {}
		for i, z in ipairs(list) do out[i], out[-i] = z, list[-i] or 0 end
		return #list
	end,
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
// settle(job, fn) answers a batch with fn(x, y) per target: a cost, or false,
// and the yards along that walk (job.yards[i]; the cost when fn gives none,
// as on a format 1 map).
const MANY = `
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

test('#180: a target set by hand at an NPC with its height (Nav.SetTarget\'s z: a class trainer, a goal\'s row) is searched with it', () => {
	const [out] = run(`${Z_WAYPOINT}
		local r = {}
		nav.place(0, 0)
		N.SetTarget(m, x, y, "Trainer", nil, "trainer", -66)
		N.Sample()
		r.withZ = { calls(), fake.last().to.z, select(4, N.GetTargetWorld()), N.GetTarget().z }
		N.SetTarget(m, x, y, "Trainer", nil, "trainer", "high")
		N.Sample()
		r.bad = N.GetTarget().z == nil
		emit(r)`);
	assert.deepEqual(out.withZ, [1, -66, -66, -66]);
	assert.equal(out.bad, true, 'only a number is a height');
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

test('a walk to a boat whose end has a board point is searched to the deck, with the deck\'s height; a later walk too', () => {
	const [out] = run(`
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
		emit(r)`, { many: true });
	assert.deepEqual(out.arrow, [-890, 10, 5.9], 'the deck, not the ship\'s stop in the water under it');
	assert.match(out.kinds, /^walk fly walk boat/);
	assert.deepEqual(out.later, [410, 5, 4.5], 'the later walk from the flight master to the deck');
});

test('the walk off a boat whose end has a board point is searched and measured from the deck, with the deck\'s height', () => {
	const [out] = run(`
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
		emit(r)`, { many: true });
	assert.match(out.kinds, /^walk boat walk/);
	assert.deepEqual(out.later, [410, 5, 4.5], 'the walk off the boat starts on the far deck, at its height');
	assert.equal(out.measured, 4.5, 'the measure into the target from the far deck carries its height');
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

// Pathing v2 (docs/ARCHITECTURE.md, "In-game walking routes"): searches are
// priced for the player's faction; the router's cost chooses, its yards time
// (on format 2 maps a road walk costs less than its yards, a steep one more);
// hostile towns a walk enters are said; a later rule scales walk costs.

test('profile: every search carries the player\'s faction as opts.profile; a neutral faction sends none and still routes', () => {
	const [out] = run(`${TERRAIN}
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
		emit(r)`, { many: true });
	assert.deepEqual(out.horde, ['Horde', 'table', false], 'the arrow\'s own walk: opts { waterWalking, profile }');
	assert.equal(out.hordeAim, 'travel');
	assert.deepEqual(out.none, [false, false], 'neutral or unread: no profile');
	assert.deepEqual(out.noneAim, ['travel', 316, 50, -150], 'and it routes');
	assert.equal(out.batch, 'Alliance', 'the planner\'s measure too');
});

test('cost and yards: the measure\'s cost picks the landing, its yards time the walk (a road walk costs less than its yards)', () => {
	const [out] = run(`${TERRAIN}
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
		emit(route())`, { many: true });
	assert.deepEqual(out, { lands: 'Road Roost, Testshire', yards: 750, seconds: 107, engine: 'cost' },
		'chosen by cost (600 < 650), shown and timed by its 750 yards at 7 yd/s');
});

test('cost and yards: a searched walk is measured by the path\'s yards, never its cost', () => {
	const [out] = run(`${CROSSING}
		nav.place(900, 800)
		target(600, -300)
		N.Sample()
		fake.settle(fake.of(true)[1], function(x, y) return math.floor(math.sqrt((x - 600) ^ 2 + (y + 300) ^ 2) * 1.1) end)
		fake.answer(fake.of(false)[1], 900, 800, 900, 900)
		fake.answer(fake.of(false)[2], 400, 300, 500, 300, 600, 20)
		local legs, ci = N.GetRoute()
		emit({ legs[ci].yards, legs[ci].seconds, legs[ci + 2].yards, legs[ci + 2].seconds })`, { many: true });
	const path = 100 + Math.hypot(100, 280);
	assert.deepEqual(out, [100, 14, Math.round(path), Math.round(path / 7)], 'the engine\'s cost (100 for each) is not a distance');
});

test('Travel.WalkCostHook: a registered rule scales a walk\'s cost, never its time', () => {
	const [out] = run(`${TERRAIN}
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
		emit(r)`, { many: true });
	assert.deepEqual(out.before, { lands: 'Ridge Roost, Testshire', yards: 375, seconds: 54, engine: false });
	assert.deepEqual(out.after, { lands: 'Road Roost, Testshire', yards: 875, seconds: 125, engine: false },
		'the walk from Ridge Roost costs four times as much: the route lands at Road Roost, timed as before');
	assert.equal(out.seen, true);
});

test('hostile towns: a walk whose path enters one carries it (leg.hubs); the arrow says "Hostile town: <name>" once, when the walk starts', () => {
	const [out] = run(`${CROSSING}
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
		emit(r)`, { many: true });
	assert.equal(out.current, 'Southshore', 'the arrow\'s own walk');
	assert.equal(out.later, 'Tarren Mill', 'a later walk, from its own search');
	assert.equal(out.none, false, 'a flight has none');
	assert.equal(out.said, 'Walk to the flight master\nHostile town: Southshore');
	assert.equal(out.after, 'Walk to the flight master', 'said once, then the step alone');
	assert.equal(out.again, 'Walk to the flight master', 'a fresh plan of the same walk does not say it again');
});

test('hostile towns: every piece of a split walk carries them, so the step after a chokepoint still says so', () => {
	const [out] = run(`
		fake.hubs = { { id = 12, name = "Southshore" } }
		${SPLIT}
		fake.hubs = nil
		local T = N.travel
		local legs, ci = N.GetRoute()
		local first = T.HubText(legs[ci])
		nav.place(0, -160)
		N.Sample()
		legs, ci = N.GetRoute()
		emit({ first = first, ci = ci, after = T.HubText(legs[ci]) or false })`);
	assert.equal(out.first, 'Hostile town: Southshore');
	assert.ok(out.ci > 1, 'past the bridge');
	assert.equal(out.after, 'Hostile town: Southshore');
});

test('hostile towns: a fresh search of the same walk with the same towns changes nothing (no ROUTE_CHANGED)', () => {
	const [out] = run(`${CROSSING}
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
		emit({ searches = #finds, changes = changes, hubs = N.travel.HubText(legs[ci]) })`, { many: true });
	assert.ok(out.searches >= 3, 'searched again');
	assert.equal(out.changes, 0);
	assert.equal(out.hubs, 'Hostile town: Southshore');
});

test('hostile towns: the arrow says them once for a split walk, not again at each step', () => {
	const [out] = run(`
		fake.hubs = { { id = 12, name = "Southshore" } }
		${SPLIT}
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
		emit({ first = first, quiet = quiet, ci = ci, again = said() })`);
	assert.equal(out.first, true, 'said as the walk starts');
	assert.equal(out.quiet, false);
	assert.ok(out.ci > 1, 'past the bridge');
	assert.equal(out.again, false, 'not said again at the next step');
});

test('hostile towns: a walk that is the whole route (a target inside Southshore) says so once on the arrow too', () => {
	const [out] = run(`
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
		emit(r)`);
	assert.equal(out.nlegs, 1, 'a lone walk');
	assert.equal(out.active, false, 'no route to follow');
	assert.equal(out.said, 'Quest in Southshore\nHostile town: Southshore');
	assert.equal(out.after, 'Quest in Southshore', 'said once, then the target alone');
	assert.equal(out.again, 'Quest in Southshore', 'a fresh plan of the same walk does not say it again');
});

test('hostile towns: two towns of the same name are named once', () => {
	const [out] = run(`
		local hubs = { { id = "a", name = "Goldshire" }, { id = "b", name = "Lakeshire" }, { id = "c", name = "Goldshire" } }
		emit(N.travel.HubText({ kind = "walk", hubs = hubs }))`);
	assert.equal(out, 'Hostile town: Goldshire, Lakeshire');
});

test('hostile towns: each is named in the client\'s language by its area (Compat.GetAreaName), else by the packed name, a shown name once', () => {
	const [out] = run(`
		local de = { [271] = "S\\195\\188derstade", [272] = "Tarrens M\\195\\188hle" }
		Polestar.Compat.GetAreaName = function(id) return de[id] end
		local hubs = {
			{ id = "a", name = "Southshore", areaId = 271 },
			{ id = "b", name = "Hammerfall", areaId = 999 },
			{ id = "c", name = "Tarren Mill", areaId = 272 },
			{ id = "d", name = "Southshore copy", areaId = 271 },
			{ id = "e", name = "Hammerfall" },
		}
		emit(N.travel.HubText({ kind = "walk", hubs = hubs }))`);
	assert.equal(out, 'Hostile town: S\u00fcderstade, Hammerfall, Tarrens M\u00fchle');
});

// Route styles (nav.routeStyle): the saved style goes to every search as
// opts.style; Routing/Costs.lua (Polestar_Nav, loaded here beside the fake
// engine) reads anything but the three as Balanced.
const COSTS = `
local chunk = assert(loadfile(${JSON.stringify(path.join(ADDONS, 'Polestar_Nav', 'Routing', 'Costs.lua'))}))
chunk("Polestar_Nav", {})
local Costs = Polestar_NavCosts
local function styles(jobs)
	local out = {}
	for i, job in ipairs(jobs) do out[i] = { job.opts.style or false, Costs.Style(job.opts.style) } end
	return out
end
`;

test('a saved route style that is none of the three walks as Balanced, without an error', () => {
	const [out] = run(`${CROSSING}${COSTS}
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
		emit(r)`, { many: true });
	assert.deepEqual(out.styles, [['Sideways', 'balanced'], ['Sideways', 'balanced'], ['Sideways', 'balanced']],
		'the measure, the arrow\'s own walk and the later walk carry the saved value, which the router reads as Balanced');
	assert.equal(out.aim, 'travel', 'the arrow routes');
	assert.deepEqual(out.drawn, ['walk', 3], 'and the later walk is drawn along its path');
});

test('changing the route style mid-walk drops the old lines, re-plans at once, and measures and searches every walk again in the new style', () => {
	const [out] = run(`${CROSSING}${COSTS}
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
		local batch, own = fake.of(true)[2], fake.of(false)[3]
		r.asked = { #fake.calls - calls, batch and batch.opts.style, own and own.opts.style, own and floor(own.to.x), own and floor(own.to.y) }
		if batch then fake.settle(batch, measure) end
		if own then fake.answer(own, 900, 800, 880, 850, 900, 900) end
		local leg = fake.of(false)[4]
		r.leg = leg and { leg.opts.style, floor(leg.from.x), floor(leg.from.y), floor(leg.to.x), floor(leg.to.y) } or false
		r.straight = lines()[3]
		if leg then fake.answer(leg, 400, 300, 450, 250, 600, 20) end
		r.after = lines()
		Polestar.Set("nav.routeStyle", "roads")
		r.same = #fake.calls
		emit(r)`, { many: true });
	assert.deepEqual(out.before.lines.slice(0, 3), [['walk', 3], ['flight', 2], ['walk', 3]], 'Balanced: the arrow\'s walk and the later walk drawn along their paths');
	assert.deepEqual(out.replanned, { changed: true, version: true }, 're-planned at once');
	assert.deepEqual(out.lines.slice(0, 3), [['walk', 2], ['flight', 2], ['walk', 2]], 'no Balanced line stays: straight until the Roads paths are in');
	assert.deepEqual(out.asked, [2, 'roads', 'roads', 900, 900], 'the walks into the target measured again and the arrow\'s own walk searched again, in Roads');
	assert.deepEqual(out.leg, ['roads', 400, 300, 600, 20], 'the later walk searched again, in Roads');
	assert.deepEqual(out.straight, ['walk', 2]);
	assert.deepEqual(out.after.slice(0, 3), [['walk', 3], ['flight', 2], ['walk', 3]], 'drawn along the Roads paths');
	assert.equal(out.same, 6, 'setting the same style again searches nothing');
});

// Zone danger (Nav/Danger.lua, Nav/Walk.lua): the zones the router's maps
// carry (Path.ZoneAt, faked here by area: y >= 500 the player's and Home
// Roost's, y < 0 the target's, else a zone without levels) and their level
// ranges (Maps.GetZoneLevels, faked) at the player's level make the danger
// table every search carries: a zone whose lowest level is at least the
// player's + 4 costs x3, more than + 10 x20 (Ruling 35); the walk's own start and goal
// zones never count.
const DANGER = `
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
`;

test('zone danger: x3 from the player\'s level + 4, x20 above + 10; a zone without levels, or no level, is never dangerous', () => {
	const [out] = run(`${DANGER}
		local r = {}
		zoneLevels = { [9001] = { 23, 30 }, [9002] = { 24, 30 }, [9003] = { 30, 40 }, [9004] = { 31, 40 } }
		r.mult = { D.Mult(20, 9001), D.Mult(20, 9002), D.Mult(20, 9003), D.Mult(20, 9004), D.Mult(20, 1497), D.Mult(20, nil), D.Mult(nil, 9004) }
		r.table = sig(D.Table(20, nil, nil))
		r.none = sig(D.Table(40, nil, nil))
		r.cached = D.Table(20, nil, nil) == D.Table(20, nil, nil)
		emit(r)`, { many: true });
	assert.deepEqual(out.mult, [1, 3, 3, 20, 1, 1, 1]);
	assert.deepEqual(out.table, ['9002=3,9003=3,9004=20', '9002=3,9003=3,9004=20'], 'every zone above 1, and its signature');
	assert.deepEqual(out.none, [false, ''], 'none: nil, an empty signature');
	assert.equal(out.cached, true, 'kept per level and zone pair');
});

test('zone danger: at level 20 every search carries the zones far above (x20) and dangerous (x3), minus the walk\'s own start and goal zones', () => {
	const [out] = run(`${CROSSING}${DANGER}
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
		emit(r)`, { many: true });
	assert.equal(out.batch, '1416=3,1422=20', 'the measure into the target');
	assert.equal(out.own, '1416=3,1422=20', 'the arrow\'s own walk');
	assert.deepEqual(out.leg, ['1416=3,1422=20', 400, 300], 'a later walk, from a zone without levels');
	assert.equal(out.inside, '1422=20', 'a target inside Alterac (dangerous) is measured without its own zone');
	assert.deepEqual(out.unit, [
		['1416=3,1422=20', '1416=3,1422=20'],
		['1416=3', '1416=3'],
		['1422=20', '1422=20'],
		[false, ''],
		1,
	], 'the start\'s and the goal\'s zones never count; a zone without levels is absent');
});

test('zone danger: a level-up drops the walks, re-plans at once, and measures and searches every walk again with the new level\'s table', () => {
	const [out] = run(`${CROSSING}${DANGER}
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
		local batch, own = fake.of(true)[2], fake.of(false)[3]
		r.asked = { #fake.calls - calls, dz(batch), dz(own), own and floor(own.to.x), own and floor(own.to.y) }
		if batch then fake.settle(batch, measure) end
		if own then fake.answer(own, 900, 800, 880, 850, 900, 900) end
		local leg = fake.of(false)[4]
		r.leg = leg and { dz(leg), floor(leg.from.x), floor(leg.from.y), floor(leg.to.x), floor(leg.to.y) } or false
		if leg then fake.answer(leg, 400, 300, 450, 250, 600, 20) end
		r.after = lines()
		emit(r)`, { many: true });
	assert.deepEqual(out.before.lines.slice(0, 3), [['walk', 3], ['flight', 2], ['walk', 3]], 'at 20: the walks drawn along their paths');
	assert.equal(out.before.danger, '1416=3,1422=20');
	assert.deepEqual(out.replanned, { changed: true, version: true }, 're-planned at once');
	assert.deepEqual(out.lines.slice(0, 3), [['walk', 2], ['flight', 2], ['walk', 2]], 'no line priced at 20 stays: straight until the new paths are in');
	assert.deepEqual(out.asked, [2, '1422=20', '1422=20', 900, 900], 'the walks into the target measured again and the arrow\'s own walk searched again, at 27 (Alterac no longer dangerous)');
	assert.deepEqual(out.leg, ['1422=20', 400, 300, 600, 20], 'the later walk searched again at 27');
	assert.deepEqual(out.after.slice(0, 3), [['walk', 3], ['flight', 2], ['walk', 3]], 'drawn along the new paths');
});

// The planner's straight estimates (Nav/Danger.lua Danger.Along, Nav/Travel.lua):
// the zone every 100 yd along a straight walk (the middle of each 100 yd
// piece), its share in a dangerous zone x3, in a far-above one x20; the
// zones of its two ends never count, nor the player's and the target's.
test('zone danger: Danger.Along samples a straight line every 100 yd, its ends\' zones never counting; without a table, Path.ZoneAt or length it is 1', () => {
	const [out] = run(`${DANGER}
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
		emit(r)`, { many: true });
	assert.equal(out.far, 0.5 * 20 + 0.5, 'half its 12 samples in a far-above zone');
	assert.equal(out.dangerous, 0.5 * 3 + 0.5, 'half in a dangerous one');
	assert.equal(out.endsNever, 0.5 * 20 + 0.5, 'the zones of its two ends never count');
	assert.deepEqual([out.again, out.asked, out.askedAgain], [10.5, 14, 14], 'its two ends and 12 samples asked once; the same line again asks nothing');
	assert.equal(out.fromInside, 1, 'a line from inside the far-above zone: its own start zone');
	assert.equal(out.noTable, 1);
	assert.equal(out.still, 1, 'no length');
	assert.equal(out.noZoneAt, 1, 'no maps: today\'s estimate');
	assert.deepEqual([out.level, out.levelUp], [20, 23], 'the level: the client\'s, or PLAYER_LEVEL_UP\'s when higher (one source for Walk and Travel)');
});

test('zone danger: the planner\'s straight walk 1200 yd through a zone far above costs t x 10.5, through a dangerous one t x 2, timed as before; the player\'s and target\'s zones never count; without Path.ZoneAt it is today\'s', () => {
	const [out] = run(`${TERRAIN}${DANGER}
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
		emit(r)`, { many: true });
	const t = Math.round(1200 * 1.25 / 7 * 1000) / 1000;
	assert.deepEqual(out.far, [10.5, t, 214], 't x (0.5 x 20 + 0.5), its time as before');
	assert.deepEqual(out.dangerous, [2, t, 214], 't x (0.5 x 3 + 0.5)');
	assert.deepEqual(out.none, [1, t, 214], 'a zone without levels');
	assert.deepEqual(out.ends, [1, t, 214], 'the player\'s and the target\'s zones never count');
	assert.deepEqual(out.noZoneAt, [1, t, 214], 'no maps: today\'s estimate');
	assert.deepEqual([out.routingOff, out.routingOn], [[1, t, 214], [10.5, t, 214]], 'routing off: today\'s estimate; on again: priced again');
});

test('zone danger: on a continent with crossing data the straight walk from a flight master to the gate takes its share too', () => {
	const [out] = run(`${CROSSING}${DANGER}
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
		emit(r)`, { many: true });
	assert.equal(out.gate, (2 * 20 + 2) / 4, 'half its samples in the band');
	assert.equal(out.home, 1, 'the walk to Home Roost crosses none');
});

// The walking floor (#234, Ruling 36): Forever gives no player height, so
// Walk follows the surface under the player (Path.SurfacesAt, faked here by
// fake.surfaces) and starts the arrow's search, and the player's place in the
// planner's measure, from it. Testshire's ground is at 40; the overhang tests
// lay a rock top at 72 over x -10..10, y -40..-15.
const FLOORS = `
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
`;

test('#234 floor: seeded where the cell has one surface, it stays on the ground under a rock top; a first cell with two stays unknown (today\'s search)', () => {
	const [out] = run(`${FLOORS}
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
		emit(r)`);
	assert.equal(out.seed, 40, 'one surface: the floor is its height');
	assert.equal(out.under, 40, 'under the rock top (40 and 72) the walk starts from the ground walked in on');
	assert.equal(out.still, 0, 'standing still reads nothing');
	assert.ok(out.quick <= 1, `${out.quick} reads in 0.2 s`);
	const [first] = run(`${FLOORS}
		fake.surfaces = overhang
		nav.place(0, -25)
		emit({ z = startZ() })`);
	assert.equal(first.z, 'none', 'first seen under the rock: unknown, searched without a height as today');
});

test('#234 floor: climbs a ramp onto a bridge, falls off its side to the ground, and stays there under the bridge', () => {
	const [out] = run(`${FLOORS}
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
		emit(r)`);
	assert.deepEqual(out, { seed: 40, bridge: 60, fell: 40, under: 40 });
});

test('#234 floor: a jump of 30+ yd, another continent or a stale floor (no reading for 2 s while moving) is unknown again', () => {
	const [out] = run(`${FLOORS}
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
		emit(r)`);
	assert.deepEqual(out, { edge: 40, jump: 'none', continent: 'none', stale: 'none' });
});

test('#234 floor: a search with the tracked height that finds nothing is asked once more without it, and that answer stands', () => {
	const [out] = run(`${FLOORS}
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
		emit(r)`);
	assert.equal(out.z, 40);
	assert.deepEqual(out.retry, [1, true], 'once more, without the height');
	assert.equal(out.aim, 'travel');
	assert.equal(out.calls, 1, 'no third search');
});

test('#234 floor: the planner\'s measure takes the player\'s place at the tracked floor', () => {
	const [out] = run(`KEEP_PLAN = true
${TERRAIN}${FLOORS}
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
		emit({ z = z })`, { many: true });
	assert.equal(out.z, 40);
});

test('#234 floor: a lift resets it; off the lift, indoors, it seeds on the one indoor surface (the Undercity under Tirisfal\'s ground), never overriding a followed floor', () => {
	const [out] = run(`${FLOORS}
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
		emit(r)`);
	assert.equal(out.top, 'none', 'the shaft\'s two landings: unknown');
	assert.equal(out.lift, 'none', 'at the lift: unknown');
	assert.equal(out.city, -62, 'off the lift, indoors: the one indoor surface under the outdoor ground');
	assert.equal(out.followed, -62, 'followed past a second indoor level');
	assert.equal(out.doorway, -62, 'the indoor state never overrides a followed floor');
	assert.equal(out.unread, 'none');
	assert.equal(out.two, 'none', 'two indoor surfaces apart: unknown');
});

test('#234 floor: while its cluster is decoding (Path.SurfacesAt nil) the floor is kept where it was read, used within 5 yd of there, lost past 30 yd, and followed again once the cluster is in; an error is unknown', () => {
	const [out] = run(`${FLOORS}
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
		emit(r)`);
	assert.deepEqual(out, { seed: 40, near: 40, far: 'none', under: 40, lost: 'none', error: 'none' });
});

test('#234 floor: a goal\'s height off its floor is dropped keeping the tracked start; a tracked start that finds nothing is dropped keeping the goal\'s height', () => {
	const [out] = run(`${FLOORS}
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
		emit(r)`);
	assert.deepEqual(out.first, [40, -66]);
	assert.deepEqual(out.offFloor, [40, 'none'], 'off the goal\'s floor: the goal\'s height goes, the tracked start stays');
	assert.deepEqual(out.startFailed, ['none', -60], 'nothing found: the tracked start goes, the goal\'s height stays');
});

test('#234 floor: the router may drop the floor\'s cluster when the target is cleared or the arrow has not updated for 2 s', () => {
	const [out] = run(`${FLOORS}
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
		emit(r)`);
	assert.equal(out.fresh, 0, 'within 2 s of the arrow\'s last update: kept');
	assert.equal(out.stale, 1, 'past 2 s: released once');
	assert.ok(out.cleared >= 2, 'the target cleared: released');
});

test('#234 floor: a style change or a level-up clears the walk but keeps the floor\'s cluster (the arrow goes on)', () => {
	const [out] = run(`${FLOORS}
		fake.surfaces = function() return { 40 } end
		nav.place(0, 50)
		startZ()
		fake.releases = 0
		Polestar.Set("nav.routeStyle", "roads")
		N.Sample()
		stub.fire("PLAYER_LEVEL_UP", 11)
		N.Sample()
		emit({ releases = fake.releases, z = startZ() })`);
	assert.deepEqual(out, { releases: 0, z: 40 });
});

test('#234 floor (Ruling 36b): a search sent without a height, then the floor found within 5 s, is asked once more with it, once', () => {
	const [out] = run(`${FLOORS}
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
		emit(r)`);
	assert.equal(out.first, 'none', 'searched at once, without a height');
	assert.deepEqual(out.reasked, [1, 40], 'once more, from the floor');
	assert.equal(out.after, 1, 'and not again');
	assert.equal(out.late, 'none');
	assert.equal(out.lateCalls, 0, 'a floor found more than 5 s after the search asks nothing');
});
