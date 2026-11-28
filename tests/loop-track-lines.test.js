'use strict';
// The farming loop being walked on the maps (Maps/RouteLines.lua, Nav/Layers.lua; Engine.GetLoopTrack; Polestar
// 0.4.4): one closed track through its points in order, drawn as a flight is, with a small mark on each point, on
// zone maps and the minimap only (never a continent map, as the dense pins); nothing once no loop is walked.
// Runs Core/Init.lua, Core/LoopTrack.lua, Nav/Nav.xml and the route line files against tests/lua/stub_nav.lua
// (map 9000: 2000 yards across, origin at its centre).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function run(continent) {
	return runAddon({
		stubs: ['stub_nav.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/LoopTrack.lua', 'Nav/Nav.xml', 'Maps/FlightPaths.lua', 'Maps/RouteStrokes.lua', 'Maps/RouteSparkle.lua', 'Maps/RouteLines.lua'] }],
		login: true,
		script: `local R, nav = Polestar.RouteLines, stub.nav
Polestar.Set("nav.lineStyle", "dots")
Polestar.Set("ui.reduceMotion", true)
WorldMapFrame:GetCanvas():SetSize(1000, 1000)
C_Map.GetMapInfo = function(id) return { mapID = id, mapType = ${continent ? 2 : 3}, name = "Testshire" } end
${continent ? 'Polestar.Compat.GetContinentMap = function(m) return m end' : ''}
local stops = {}
for i, p in ipairs({ { 200, -200 }, { 200, 200 }, { -200, 200 }, { -200, -200 } }) do
	local _, x, y = nav.mapPoint(p[1], p[2])
	stops[i] = { wx = p[1], wy = p[2], x = x, y = y }
end
local T = Polestar.LoopTrack.Build(0, stops)
T.map = 9000
local walked = T
Polestar.Engine.GetLoopTrack = function() return walked end
nav.viewRadius = 400
nav.place(200, 0)
Polestar.Fire("WAYPOINT_CHANGED")
Polestar.Nav.layers.Update()
nav.showWorldMap(9000)
stub.advance(0.3)
local function marks()
	local n = 0
	for _, pin in ipairs(nav.pins()) do if pin.data.layer.name == "nav.loop" then n = n + 1 end end
	return n
end
local p = R.GetLoopPaths()[1]
local r = { paths = #R.GetLoopPaths(), kind = p and p.kind or false, closed = p and p.x[1] == p.x[p.n] and p.y[1] == p.y[p.n] or false,
	world = R.GetStrokes("world").n, minimap = R.GetStrokes("minimap").n, marks = marks(),
	minimapMarks = #(Polestar.Pins.GetLayer("nav.loop") or {}) }
walked = nil
Polestar.Fire("WAYPOINT_CHANGED")
Polestar.Nav.layers.Update()
stub.advance(0.3)
r.gonePaths, r.goneWorld, r.goneMarks = #R.GetLoopPaths(), R.GetStrokes("world").n, marks()
emit(r)`,
	}).emitted[0];
}

test('the loop being walked draws closed on the zone map and the minimap, a mark on each point', () => {
	const out = run(false);
	assert.equal(out.paths, 1);
	assert.equal(out.kind, 'flight', 'in the flight lines\' style');
	assert.equal(out.closed, true, 'the track closes from the last point to the first');
	assert.ok(out.world > 20, `zone map: ${out.world} strokes`);
	assert.ok(out.minimap > 5, `minimap: ${out.minimap} strokes`);
	assert.equal(out.marks, 4, 'a mark on each of its four points');
	assert.equal(out.minimapMarks, 4);
	assert.deepEqual([out.gonePaths, out.goneWorld, out.goneMarks], [0, 0, 0], 'no loop walked: nothing drawn');
});

test('on a continent map the loop is not drawn; the minimap keeps it', () => {
	const out = run(true);
	assert.equal(out.paths, 1);
	assert.equal(out.world, 0, 'no strokes on a continent map');
	assert.equal(out.marks, 0, 'no marks there either');
	assert.ok(out.minimap > 5, `minimap: ${out.minimap} strokes`);
});
