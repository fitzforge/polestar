'use strict';
// Observational provenance: real decoder, Walk, follower and travel planner.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const B = require('../tools/lib/nav/bake');
const { runAddon } = require('./helpers/lua');

const LEG = { pts: [[0, 0, 10], [100, -100, 20], [100, -500, 20], [0, -600, 10]], cls: [0, 5, 0], floor: [0, 2, 0], tail: 0, strip: [10, 10.25, 10.5, 10.75] };
const encoded = B.encodeLeg(LEG);
function run(script) {
	return runAddon({
		stubs: ['stub_nav.lua'],
		before: `fake = { calls = {} }
Polestar_NavEngine = {
 Find = function(map, from, to, callback, opts)
  local j = { map = map, from = from, to = to, callback = callback, opts = opts }
  fake.calls[#fake.calls + 1] = j; return j
 end,
 Cancel = function(j) j.cancelled = true end,
 Busy = function() return false end,
 Available = function() return true end,
}`,
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] }],
		login: true,
		script: `
local N, nav = Polestar.Nav, stub.nav
local W = N.walk
local guide = { id = "t/g", legs = { [1] = ${JSON.stringify(encoded)}, [2] = ${JSON.stringify(encoded)} } }
Polestar.Engine.GetGuide = function() return guide end
nav.engine.views[1] = { goals = { { map = 9000, x = 80, y = 50 } } }
nav.engine.views[2] = nav.engine.views[1]
local function target()
 local m, x, y = nav.mapPoint(0, -600)
 N.SetTarget(m, x, y, "Target")
end
local function start()
 nav.place(50, -40); target(); N.Sample()
end
${script}`,
	}).emitted;
}

test('accepted baked route owns original arrays and fractional 2D origin; progress is observational', () => {
	const [r] = run(`
start()
assert(type(W.WorldTrail) == "function", "Walk.WorldTrail provenance getter missing")
local s, p = W.WorldTrail()
assert(s and p, "accepted baked walk has provenance")
local along, off = W.Progress(0, 0, -600)
local old = p.along
p.along = -999
local s2, p2 = W.WorldTrail()
emit({ xs = s.xs, ys = s.ys, zs = s.zs, cls = s.cls, floor = s.floor, strip = s.strip,
 n = s.n, m = s.m, stripYd = s.stripYd, distances = s.distances,
 trimSegment = s.trimSegment, trimT = s.trimT, trimOffset = s.trimOffset,
 guide = s.guide, step = s.step, id = s.id, generation = s.generation,
 along = old, off = p2.off, sourceAlong = p2.sourceAlong,
 same = s == s2, fresh = p ~= p2, unchanged = p2.along == along and p2.off == off,
 calls = #fake.calls })`);
	assert.deepEqual(r.xs, LEG.pts.map(p => p[0]));
	assert.deepEqual(r.ys, LEG.pts.map(p => p[1]));
	assert.deepEqual(r.zs, LEG.pts.map(p => p[2]));
	assert.deepEqual(r.cls, LEG.cls);
	assert.deepEqual(r.floor, LEG.floor);
	assert.deepEqual(r.strip, LEG.strip);
	assert.equal(r.n, 4); assert.equal(r.m, 4); assert.equal(r.stripYd, 2);
	assert.equal(r.trimSegment, 1); assert.equal(r.trimT, 0.45);
	assert.ok(Math.abs(r.trimOffset - Math.hypot(45, 45)) < 1e-8);
	assert.ok(Math.abs(r.distances[1] - Math.hypot(100, 100)) < 1e-8, 'XY, not decoder 3D left');
	assert.equal(r.sourceAlong, r.trimOffset + r.along);
	assert.equal(r.guide, 't/g'); assert.equal(r.step, 1);
	assert.equal(typeof r.id, 'number'); assert.equal(typeof r.generation, 'number');
	assert.equal(r.same, true); assert.equal(r.fresh, true); assert.equal(r.unchanged, true);
	assert.equal(r.calls, 0);
});

test('reroute intent retires baked provenance through pending, combat, failure and same-endpoint dynamic replacement', () => {
	for (const combat of [false, true]) {
		const [r] = run(`
start()
local old = W.WorldTrail()
stub.inCombat = ${combat}
nav.place(300, -300); N.Sample()
local pending = W.WorldTrail() == nil
local callsDeferred = #fake.calls
stub.inCombat = false
N.Sample()
local j = fake.calls[#fake.calls]
assert(j, "reroute queued")
j.callback({ { x = 300, y = -300 }, { x = 100, y = -400 }, { x = 0, y = -600 } })
N.Sample()
local dynamic = W.WorldTrail() == nil
W.Clear(); nav.place(50, -40); N.Sample()
local fresh = W.WorldTrail()
emit({ pending = pending, dynamic = dynamic, callsDeferred = callsDeferred,
 renewed = fresh and fresh.generation ~= old.generation or false,
 retained = old.xs[2] == 100 and old.strip[2] == 10.25 })`);
		assert.equal(r.pending, true); assert.equal(r.dynamic, true);
		assert.equal(r.callsDeferred, combat ? 0 : 1);
		assert.equal(r.renewed, true); assert.equal(r.retained, true);
	}
	const [r] = run(`
start(); nav.place(300, -300); N.Sample()
fake.calls[#fake.calls].callback(nil)
nav.place(50, -40); N.Sample()
emit(W.WorldTrail() == nil)`);
	assert.equal(r, true);
});

test('decoder reuse and partial failed decode cannot rewrite a retained snapshot', () => {
	const other = B.encodeLeg({ pts: [[20, 40, 30], [40, 80, 50]], cls: [7], floor: [3], tail: 2, strip: [40, 42] });
	const [r] = run(`
start()
local s = W.WorldTrail()
guide.legs[3] = ${JSON.stringify(other)}
guide.legs[4] = ${JSON.stringify(other.slice(0, -2))}
nav.engine.views[3], nav.engine.views[4] = nav.engine.views[1], nav.engine.views[1]
assert(N.BakedLeg(3), "different valid decode")
assert(N.BakedLeg(4) == nil, "partial failing decode")
local fresh = W.WorldTrail()
emit({ xs = s.xs, zs = s.zs, cls = s.cls, floor = s.floor, strip = s.strip,
 same = fresh == s, n = s.n, m = s.m })`);
	assert.deepEqual(r.xs, LEG.pts.map(p => p[0])); assert.deepEqual(r.zs, LEG.pts.map(p => p[2]));
	assert.deepEqual(r.cls, LEG.cls); assert.deepEqual(r.floor, LEG.floor); assert.deepEqual(r.strip, LEG.strip);
	assert.equal(r.same, true); assert.equal(r.n, 4); assert.equal(r.m, 4);
});

test('same-coordinate step, guide and target changes cannot borrow old provenance', () => {
	const [r] = run(`
start()
local r = {}
nav.engine.step = 2; N.Sample(); r.step = W.WorldTrail() == nil
nav.engine.step = 1
guide = { id = "t/other", legs = guide.legs }; N.Sample(); r.guide = W.WorldTrail() == nil
W.Clear(); nav.place(50, -40); N.Sample()
local s = W.WorldTrail(); assert(s and s.guide == "t/other")
target(); r.target = W.WorldTrail() == nil
N.Sample(); r.noRebind = W.WorldTrail() == nil
emit(r)`);
	assert.deepEqual(r, { step: true, guide: true, target: true, noRebind: true });
});

test('getter gates handoff, continent, inactive states and unsupported current walks without work', () => {
	const [r] = run(`
start()
local r = {}
local legs, ci = N.GetRoute()
local leg = legs[ci]
local function absent(k) r[k] = W.WorldTrail() == nil end
local handoff = N.HandedOff
N.HandedOff = function() return true end; absent("handoff"); N.HandedOff = handoff
nav.place(50, -40, 1); absent("continent"); nav.place(50, -40)
nav.taxi = true; absent("taxi"); nav.taxi = false
nav.instance = true; absent("instance"); nav.instance = false
leg.kind = "fly"; absent("nonwalk"); leg.kind = "walk"
leg.parent = {}; absent("split"); leg.parent = nil
leg.handmade = true; absent("handmade"); leg.handmade = nil
local targetGetter = N.GetTarget
N.GetTarget = function() return nil end; absent("noTarget"); N.GetTarget = targetGetter
local routeGetter = N.GetRoute
N.GetRoute = function() return nil end; absent("inactive"); N.GetRoute = routeGetter
local function forbidden() error("getter performed navigation or terrain work") end
N.BakedLeg = forbidden
N.Path.Find, N.Path.SurfacesAt, N.Path.ReleaseSurfaces = forbidden, forbidden, forbidden
N.follow.Step = forbidden
W.Floor = forbidden
local s, p = W.WorldTrail(); r.observation = s ~= nil and p ~= nil
emit(r)`);
	assert.deepEqual(r, { handoff: true, continent: true, taxi: true, instance: true,
		nonwalk: true, split: true, handmade: true, noTarget: true, inactive: true, observation: true });
});

test('mutable active target identity is checked, not just the endpoint or object reference', () => {
	const [r] = run(`
start()
local t = N.GetTarget()
t.goalIndex = 2
emit(W.WorldTrail() == nil)`);
	assert.equal(r, true);
});

test('progress follows Aim freshly; Clear, changed goal and cancelled native callbacks never resurrect the snapshot', () => {
	const [r] = run(`
start()
local s, p = W.WorldTrail()
nav.place(100, -100); N.Sample()
nav.place(100, -300); N.Sample()
local s2, p2 = W.WorldTrail()
local along, off = W.Progress(0, 0, -600)
local r = { stable = s == s2, moved = p2.along > p.along,
 matched = p2.along == along and p2.off == off, retained = p.along == 0 }
nav.place(300, -300); N.Sample()
local job = fake.calls[#fake.calls]
W.Clear(); r.clear = W.WorldTrail() == nil
job.callback({ { x = 0, y = 0 }, { x = 0, y = -600 } })
r.cancelled = job.cancelled and W.WorldTrail() == nil
nav.place(50, -40); N.Sample()
local m, x, y = nav.mapPoint(0, -300)
N.SetTarget(m, x, y, "Other goal"); N.Sample()
r.otherGoal = W.WorldTrail() == nil
emit(r)`);
	assert.deepEqual(r, { stable: true, moved: true, matched: true, retained: true,
		clear: true, cancelled: true, otherGoal: true });
});