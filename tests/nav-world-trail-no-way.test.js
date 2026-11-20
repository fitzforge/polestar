'use strict';
// A goal the walking router finds no way to: the route's geometry says so (the real Walk and travel planner,
// a walking engine that answers as told), so the ground trail can tell that straight line from a route.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

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
local function target(wx, wy)
 local m, x, y = nav.mapPoint(wx, wy)
 N.SetTarget(m, x, y, "Target")
end
-- The current walk as the geometry gives it: { points, straight, unrouted }.
local function leg()
 local g = N.GetRouteGeometry()
 local l = g and g.legs and g.legs[1]
 return l and { #l.pts, l.straight or false, l.unrouted or false } or false
end
local function answer(points, reason) fake.calls[#fake.calls].callback(points, reason) end
${script}`,
	}).emitted;
}

test('a walk the search finds no way for is marked so in the geometry; one still being searched, and one found, are not', () => {
	const [r] = run(`
nav.place(50, -40); target(0, -600); N.Sample()
local r = { asked = #fake.calls, pending = leg() }
answer(nil, "unreachable")
r.lost = leg()
-- Asked again from further on (a failed search is, in time): still no way while that search runs,
stub.advance(16); nav.place(90, -40); N.Sample()
r.askedAgain = #fake.calls
Polestar.Fire("ROUTE_CHANGED")
r.again = leg()
-- and none when it answers the same.
answer(nil, "unreachable")
r.lostAgain = leg()
-- A path at last: a route like any other.
stub.advance(16); nav.place(130, -40); N.Sample()
answer({ { x = 130, y = -40 }, { x = 60, y = -300 }, { x = 0, y = -600 } })
r.found = leg()
emit(r)`);
	assert.equal(r.asked, 1);
	assert.deepEqual(r.pending, [2, true, false], 'searching: straight, and nothing said of it yet');
	assert.deepEqual(r.lost, [2, true, true], 'no way found: straight and unrouted');
	assert.equal(r.askedAgain, 2);
	assert.deepEqual(r.again, [2, true, true], 'still unrouted while it is asked again');
	assert.deepEqual(r.lostAgain, [2, true, true]);
	assert.deepEqual(r.found, [3, false, false], 'a path: neither');
});

test('another goal does not inherit it, and a goal dropped and taken up again is no longer taken for lost once a path was found', () => {
	const [r] = run(`
nav.place(50, -40); target(0, -600); N.Sample()
answer(nil, "unreachable")
local r = { lost = leg() }
-- A new goal, its search still running: not the lost one's line.
target(200, -300); N.Sample()
r.other = leg()
answer({ { x = 50, y = -40 }, { x = 200, y = -300 } })
r.otherFound = leg()
-- Back to the first goal, searched afresh: that a path came in since means nothing is known against it.
target(0, -600); N.Sample()
r.back = leg()
emit(r)`);
	assert.deepEqual(r.lost, [2, true, true]);
	assert.deepEqual(r.other, [2, true, false]);
	assert.deepEqual(r.otherFound, [2, false, false]);
	assert.deepEqual(r.back, [2, true, false]);
});
