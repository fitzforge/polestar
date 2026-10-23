'use strict';
// Camera-only port: accepted 0.4.8 assertions, exercised in Polestar's Lua harness.
const { test, after } = require('node:test');
let luaAssertions = 0;
after(() => console.log(`Lua assertions: ${luaAssertions}`));
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const fs = require('node:fs');
const path = require('node:path');
const ROOT = path.join(__dirname, '..');
const base = ['Core/Init.lua', 'Nav/WorldTrail.lua', 'Maps/RouteSparkle.lua'];
const checks = `
local NS = Polestar.WorldTrail
local T = NS.Trail
local assertions = 0
local function ok(cond, note) assertions = assertions + 1; assert(cond, note or "assertion failed") end
local function near(a,b,note,eps) ok(math.abs(a-b) <= (eps or 1e-6), (note or "mismatch") .. ": got " .. tostring(a) .. ", expected " .. tostring(b)) end
local function geometry()
 return { legs = {
 {kind="walk", current=true, pts={{0,0,0},{0,100,0},{0,100,0},{0,100,50}}},
 {kind="hearth", pts={{0,100,50},{1,0,0}}},
 {kind="flight", pts={{1,0,0},{1,0,300},{0,5,5},{0,5,25}}} } }
end
local function settings(over)
 local db = NS.Settings()
 for k,v in pairs(over or {}) do db[k]=v end
 return db
end
`;
function pure(script) {
 assert.ok(fs.existsSync(path.join(ROOT, 'addon/Polestar/Maps/WorldTrailMath.lua')), 'camera world-trail math must be implemented');
 const result = runAddon({addons:[{name:'Polestar',files:[...base, 'Maps/WorldTrailMath.lua']}], script: checks + script + '\nemit(assertions)'}).emitted[0];
 luaAssertions += result;
 return result;
}

test("paths skip jumps, dedupe points and split at continents", () => { assert.ok(pure(`
	local current = T.BuildPaths(geometry(), false)
	ok(#current == 1, "current leg only"); ok(current[1].current)
	near(current[1].n, 3, "duplicate point dropped"); near(current[1].total, 150)
	local all = T.BuildPaths(geometry(), true)
	ok(#all == 3, "walk + flight split in two; hearth skipped, got " .. #all)
	ok(all[2].c == 1 and all[3].c == 0, "continent split"); near(all[2].total, 300); near(all[3].total, 20)
	ok(#T.BuildPaths(nil, true) == 0 and #T.BuildPaths({ legs = {} }, true) == 0, "no route, no paths")
`) > 0); });

test("first leg counts as current when none is flagged", () => { assert.ok(pure(`
	local g = geometry()
	g.legs[1].current = nil
	ok(#T.BuildPaths(g, false) == 1)
`) > 0); });

test("nearest and point at", () => { assert.ok(pure(`
	local p = T.BuildPaths(geometry(), false)[1]
	local along, dist = T.Nearest(p, 0, 40, 3)
	near(along, 40); near(dist, 3)
	along = T.Nearest(p, 0, 120, 30); near(along, 130)
	ok(T.Nearest(p, 1, 0, 0) == nil, "other continent")
	local x, y, nx, ny = T.PointAt(p, 125)
	near(x, 100); near(y, 25); near(nx, -1); near(ny, 0)
	x, y = T.PointAt(p, -5); near(x, 0); near(y, 0)
	x, y = T.PointAt(p, 999); near(x, 100); near(y, 50)
`) > 0); });

test("emit spaces sparkles, starts at the player and fades the ends", () => { assert.ok(pure(`
	local p = T.BuildPaths(geometry(), false)[1]
	local got = {}
	local n = T.Emit(p, 30, 10, 0, 1000, function(x, y, k, nx, ny, fade) got[#got + 1] = { x = x, y = y, k = k, fade = fade } end)
	near(n, #got)
	ok(got[1].k == 4 and got[1].x == 40, "first sparkle after the start (sparkle 3 at the start has fade 0)")
	near(got[#got].k, 14, "last sparkle a spacing before the end (sparkle 15 on the goal fades to 0)")
	for i = 2, #got do near(got[i].k - got[i - 1].k, 1, "consecutive") end
	ok(got[1].fade == 1, "a full spacing in")
	local half = {}
	T.Emit(p, 35, 10, 0, 1000, function(_, _, k, _, _, fade) half[#half + 1] = fade end)
	near(half[1], 0.5, "half a spacing in fades by half")
	near(T.Emit(p, 0, 10, 0, 3, function() end), 3, "limit")
	near(T.Emit(p, 0, 10, 0, 100, function() return false end), 1, "callback stops early")
`) > 0); });

test("flow keeps sparkle identity as it moves toward the goal", () => { assert.ok(pure(`
	local p = T.BuildPaths(geometry(), false)[1]
	local before, after = {}, {}
	T.Emit(p, 0, 10, 0.25, 1000, function(x, y, k) before[k] = y == 0 and x or 100 + y end)
	T.Emit(p, 0, 10, 0.75, 1000, function(x, y, k) after[k] = y == 0 and x or 100 + y end)
	local moved = 0
	for k, a in pairs(after) do
		if before[k] then near(a - before[k], 5, "sparkle " .. k .. " moves 5 yards on"); moved = moved + 1 end
	end
	ok(moved > 10, "most sparkles persist")
`) > 0); });

test("style responds to intensity, density and subtlety", () => { assert.ok(pure(`
	local db = settings({})
	local base = T.Style(db)
	db.density = 10; ok(T.Style(db).spacing < base.spacing, "denser is closer")
	db.density = 1; ok(T.Style(db).spacing > base.spacing)
	db = settings({ subtlety = 1 })
	local quiet = T.Style(db)
	ok(quiet.halo == 0 and quiet.size < base.size and quiet.twinkle < base.twinkle and quiet.flow < base.flow, "subtle is calmer")
	db = settings({ intensity = 0 }); near(T.Style(db).alpha, 0)
	for k = 1, 200 do
		local a, s = T.Sparkle(k, k * 0.37, base, 1)
		ok(a >= 0 and a <= 1 and s > 0, "sparkle in range")
	end
	near(T.Hash(7, 1), T.Hash(7, 1), "hash is stable")
`) > 0); });

test("camera solve recovers yaw and pitch from one marker", () => { assert.ok(pure(`
	local focal = T.Focal(90, 1080)
	near(T.Focal(90, 1080), 540 / 0.5625, "90 degrees across 16:9", 1e-6)
	for _, case in ipairs({ { 0.3, 0.25, 120, 40 }, { 2.5, 0.5, -200, 80 }, { -1.2, 0.1, 80, -300 }, { 3.1, 0.6, -150, -20 } }) do
		local yaw, pitch, gx, gy = case[1], case[2], case[3], case[4]
		local cam = T.Camera(yaw, pitch, 18, focal, 1920, 1080)
		local ax, ay = T.Project(cam, gx, gy, 0)
		ok(ax, "goal in front")
		local y2, p2, miss = T.SolveCamera(gx, gy, ax, ay, 18, focal, 1920, 1080, yaw - 0.3, 0.3, false)
		ok(y2, "solved")
		local dy = (y2 - yaw + math.pi) % (2 * math.pi) - math.pi
		near(dy, 0, "yaw", 1e-4); near(p2, pitch, "pitch", 1e-4); ok(miss < 0.01)
		-- A near goal: yaw only, pitch held.
		local y3 = T.SolveCamera(gx, gy, ax, ay, 18, focal, 1920, 1080, yaw + 0.2, pitch, true)
		near((y3 - yaw + math.pi) % (2 * math.pi) - math.pi, 0, "yaw alone", 1e-4)
	end
	-- A waypoint 12 yards up: solved with its height, the pitch is right; taken as level, it is off.
	local cam2 = T.Camera(0.4, 0.3, 18, focal, 1920, 1080)
	local hx, hy = T.Project(cam2, 150, 40, 12)
	local _, ph = T.SolveCamera(150, 40, hx, hy, 18, focal, 1920, 1080, 0.2, 0.3, false, 12)
	near(ph, 0.3, "pitch with the height", 1e-4)
	local _, pl = T.SolveCamera(150, 40, hx, hy, 18, focal, 1920, 1080, 0.2, 0.3, false)
	ok(math.abs(pl - 0.3) > 0.03, "pitch without it is off")
	-- Facing north, a point ahead is centred and a point to the west is left of centre.
	local cam = T.Camera(0, 0.3, 15, focal, 1920, 1080)
	local x = T.Project(cam, 50, 0, 0); near(x, 960, "ahead is centred")
	ok(T.Project(cam, 50, 10, 0) < 960, "west is left when facing north")
	ok(T.Project(cam, -40, 0, 0) == nil, "behind the camera")
	local _, yNear = T.Project(cam, 5, 0, 0)
	local _, yFar = T.Project(cam, 60, 0, 0)
	ok(yNear < 540 and yNear < yFar, "the ground near the feet is below the centre and rises with distance")
`) > 0); });

test("smoothing takes the zigzag out of a grid-stepped route", () => { assert.ok(pure(`
	local pts = {}
	for i = 0, 20 do pts[#pts + 1] = { 0, i * 4, (i % 2) * 4 } end -- a 4-yard staircase zigzag
	local p = T.BuildPaths({ legs = { { kind = "walk", current = true, pts = pts } } }, false)[1]
	local q = T.Smooth(p, 2)
	near(q.xs[1], p.xs[1]); near(q.ys[1], p.ys[1]); near(q.xs[q.n], p.xs[p.n]); near(q.ys[q.n], p.ys[p.n])
	local function wiggle(path)
		local m = 0
		for i = 1, path.n do if path.xs[i] > 8 and path.xs[i] < 72 then m = math.max(m, math.abs(path.ys[i] - 2)) end end
		return m
	end
	ok(wiggle(q) < wiggle(p) * 0.6, "the zigzag shrinks: " .. wiggle(p) .. " -> " .. wiggle(q))
	ok(T.Smooth(nil) == nil)
`) > 0); });

test('shared sparkle math aliases; world style and hinted U-fold nearest remain distinct', () => {
 assert.ok(pure(`
 ok(T.PointAt == Polestar.RouteSparkle.PointAt)
 ok(T.Emit == Polestar.RouteSparkle.Emit)
 ok(T.Hash == Polestar.RouteSparkle.Hash)
 ok(T.Sparkle == Polestar.RouteSparkle.Twinkle)
 near(T.Style(settings()).max, 200, "world ceiling, not map 140")
 local pts = {}; for x=0,200,10 do pts[#pts+1]={0,x,0} end
 for x=200,0,-10 do pts[#pts+1]={0,x,5} end
 local p=T.BuildPaths({legs={{kind="walk",pts=pts,current=true}}})[1]
 local a,d=T.Nearest(p,0,20,4,20)
 near(a,20); near(d,4, "hint avoids snapping to returning fold")
 a=T.Nearest(p,0,20,4); ok(a>300, "full scan would jump")
 near(T.DistanceFade(0,30,1),1); near(T.DistanceFade(30,30,1),0)
 `) > 0);
});

function runtime(script, before = '') {
 assert.ok(fs.existsSync(path.join(ROOT, 'addon/Polestar/Maps/WorldTrailRender.lua')), 'camera world-trail renderer must be implemented');
 const files=[...base, 'Maps/WorldTrailMath.lua'];
 if (fs.existsSync(path.join(ROOT, 'addon/Polestar/Maps/WorldTrailTerrain.lua'))) files.push('Maps/WorldTrailTerrain.lua');
 files.push('Maps/WorldTrailRender.lua');
 const result = runAddon({stubs:['stub_world_trail.lua'], before, addons:[{name:'Polestar',files}], script: checks + `
 local W=stub.worldTrail
 W.install()
 stub.login()
 local R=NS.Render
 local function enable() Polestar.Set("nav.worldTrail",true) end
 local function frame(dt) stub.advance(dt or 0.05) end
 local function holdLeft() W.left=true; frame(.05); frame(.30) end
 ` + script + '\nassert(#Polestar.Errors()==0, \"no swallowed runtime errors\"); emit(assertions)'}).emitted[0];
 luaAssertions += result;
 return result;
}
test('disabled creates no owner; enable, no-route and re-enable stop and resume the actual painter', () => {
 assert.ok(runtime(`
 ok(R.GroundFrame()==nil, "no owner while disabled")
 local ownersBefore=#stub.frames
 enable(); frame(2.1)
 near(#stub.frames,ownersBefore+1,"only the ground owner is created")
 local g=R.GroundFrame(); ok(g and g.used>0,"actual ground stars")
 local pool=#g.stars; frame(0.5); near(#g.stars,pool,"reuse pool")
 Polestar.Set("nav.worldTrailMax",10); frame(); ok(g.used<=10)
 Polestar.Set("nav.worldTrail",false); ok(g.used==0 and not g:GetScript("OnUpdate"),"disabled: detach OnUpdate")
 local count=#stub.frames; frame(0.5); near(#stub.frames,count)
 enable(); frame(); ok(g.used>0,"resume")
 W.route=nil; Polestar.Fire("NAV_ROUTE_GEOMETRY"); ok(g.used==0 and not g:GetScript("OnUpdate"),"no route stops work")
 W.route={legs={{kind="walk",current=true,pts={{0,0,0},{0,200,0}}}}}; Polestar.Fire("NAV_ROUTE_GEOMETRY"); frame(); ok(g.used>0)
 near(W.writes,0); ok(g:GetParent()==UIParent)
 local n=#stub.frames; ok(R.Start()); near(#stub.frames,n,"Start is idempotent")
 `)>0);
});
test('world painting retains the accepted forty-updates-per-second ceiling', () => {
 assert.ok(runtime(`
 enable(); frame(2.1)
 local baseEmit, draws = T.Emit, 0
 T.Emit = function(...) draws = draws + 1; return baseEmit(...) end
 for i=1,100 do frame(0.001) end
 T.Emit = baseEmit
 ok(draws > 0 and draws <= 5, "at most forty paints per second, not one per display frame: " .. draws)
 `)>0);
});

test('startup settle cannot complete while loading; overlapping events keep full two seconds after loading', () => {
 assert.ok(runtime(`
 enable(); frame(1)
 stub.fire("LOADING_SCREEN_ENABLED"); frame(1.1)
 ok(not R.Settled(),"startup timer must not settle during active loading")
 ok(R.GroundFrame().used==0)
 stub.fire("LOADING_SCREEN_ENABLED"); stub.fire("PLAYER_ENTERING_WORLD"); frame(3)
 ok(not R.Settled(),"entering-world cannot end an active load")
 stub.fire("LOADING_SCREEN_DISABLED"); frame(1)
 stub.fire("LOADING_SCREEN_ENABLED"); frame(1.1)
 ok(not R.Settled(),"stale post-load timer cancelled logically")
 stub.fire("LOADING_SCREEN_DISABLED"); frame(1.95); ok(not R.Settled())
 frame(0.1); ok(R.Settled()); ok(R.GroundFrame().used>0)
 `)>0);
});
test('standalone coexistence suppresses rendering without reading its DB or creating map owners', () => {
 assert.ok(runtime(`
 enable(); frame(3); ok(R.GroundFrame()==nil)
 ok(R.Why():find("ForeverSparkleTrail"),"diagnostic names competing addon")
 near(W.writes,0)
 `, 'stub.addonsLoaded.ForeverSparkleTrail=true; ForeverSparkleTrailDB=setmetatable({}, {__index=function() error("no legacy DB reads") end})')>0);
});

test("accepted terrain shared-reader and sight regressions", () => { assert.ok(runtime(`
	ok(NS.Terrain ~= nil, "guarded terrain adapter must be implemented")
	local Tr = NS.Terrain
	local calls, wallX = 0, nil
	local hill = false
	Polestar_NavEngine = { HasData = function() return true end, SurfacesAt = function(c, x, y, out)
		calls = calls + 1
		if wallX and x >= wallX and x < wallX + 8.4 then return 0 end -- two cells of wall
		if hill and x >= 30 and x < 40 then out[1], out[-1] = 20, 0; return 1 end
		out[1], out[-1] = 0, 0
		return 1
	end }
	PolestarPathData = { [0] = { cx0 = -30, cy0 = -14, nx = 42, ny = 23, cells = 128 } }
	Tr.Reset()
	ok(Tr.Begin(0, 10, 2, 0, true), "begins in a known tile")
	local before = calls
	ok(Tr.Cell(10, 2) and calls == before, "the player's cell is cached")
	ok(Tr.Cell(10 + 600, 2) == nil and calls == before, "a cell in another tile is unknown, not read")
	ok(Tr.Cell(-100000, 2) == nil and calls == before, "off the grid: not read")
	ok(Tr.Sees(10, 2, 2, 50, 2, 1, false) == true, "open ground is in view")
	Tr.Reset(); wallX = 30; Tr.Begin(0, 10, 2, 0, true)
	ok(Tr.Sees(10, 2, 2, 50, 2, 1, false) == false, "a wall two cells thick blocks")
	Tr.Reset(); wallX = nil; Polestar_NavEngine.SurfacesAt = function(c, x, y, out)
		calls = calls + 1
		if x >= 30 and x < 33 then return 0 end -- one cell: a post
		out[1], out[-1] = 0, 0
		return 1
	end
	Tr.Begin(0, 10, 2, 0, true)
	ok(Tr.Sees(10, 2, 2, 50, 2, 1, false) == true, "a lone post doesn't")
	Tr.Reset(); Polestar_NavEngine.SurfacesAt = function(c, x, y, out)
		if x >= 30 and x < 40 then out[1], out[-1] = 20, 0; return 1 end
		out[1], out[-1] = 0, 0
		return 1
	end
	Tr.Begin(0, 10, 2, 0, true)
	ok(Tr.Sees(10, 2, 2, 50, 2, 1, false) == false, "a hill rising over the line blocks")
	Tr.Reset(); Polestar_NavEngine.SurfacesAt = function(c, x, y, out)
		if x >= 30 and x < 40 then out[1], out[-1] = -30, 0; return 1 end
		out[1], out[-1] = 0, 0
		return 1
	end
	Tr.Begin(0, 10, 2, 0, true)
	ok(Tr.Sees(10, 2, 2, 50, 2, 1, false) == true, "a gully below the line doesn't")
	Tr.Reset(); Polestar_NavEngine.SurfacesAt = function(c, x, y, out)
		out[1], out[-1] = 0, (x >= 30 and x < 40) and 2 or 0 -- a building's floor at street height
		return 1
	end
	Tr.Begin(0, 10, 2, 0, true)
	ok(Tr.Sees(10, 2, 2, 50, 2, 1, false) == false, "looking from the street through a building's walls is blocked")
	ok(Tr.Sees(32, 2, 2, 38, 2, 1, true) == true, "inside the building, its floor is open")
	-- From a ledge 20 yards up, a ray down over a strip of unwalkable slope still sees the route below.
	Tr.Reset(); Polestar_NavEngine.SurfacesAt = function(c, x, y, out)
		if x < 20 then out[1], out[-1] = 20, 0; return 1 end -- the ledge
		if x < 32 then return 0 end                          -- the steep bank: nothing walkable
		out[1], out[-1] = 0, 0                                -- the valley floor
		return 1
	end
	Tr.Begin(0, 10, 2, 0, true)
	ok(Tr.Sees(10, 2, 30, 50, 2, 1, false, 20) == true, "looking down off a ledge isn't blocked by the bank")
	ok(Tr.Sees(10, 2, 2, 50, 2, 1, false, 0) == false, "but the same bank blocks a ray at its foot")
	-- Reads: none unless allowed, none in a tile without data, the player's cell at most every 0.25 s.
	Tr.Reset(); calls = 0
	Polestar_NavEngine.SurfacesAt = function(c, x, y, out) calls = calls + 1; out[1], out[-1] = 0, 0; return 1 end
	ok(Tr.Begin(0, 10, 2, 0, false) and calls == 0, "no reads while not allowed")
	ok(Tr.Cell(14, 2) == nil and calls == 0, "and nothing unknown is read")
	Tr.Begin(0, 10, 2, 0, true); local c1 = calls
	Tr.Begin(0, 10.5, 2, 0.1, true); ok(calls == c1, "not again within 0.25 s")
	Tr.Begin(0, 10.5, 2, 0.3, true); ok(calls == c1, "nor after 0.25 s without moving a yard")
	Tr.Begin(0, 12, 2, 0.6, true); ok(calls == c1 + 1, "after moving a yard")
	-- Stepping into the next tile: nothing read there for half a second.
	local edge = 30 * 1600 / 3 -- x of the next tile's border from the grid origin
	local nx = -30 * 1600 / 3 + 31 * 1600 / 3 + 1
	Tr.Begin(0, nx, 2, 1, true); local c2 = calls
	ok(Tr.Cell(nx + 2, 2) == nil and calls == c2, "a tile just stepped into isn't read")
	Tr.Begin(0, nx, 2, 1.6, true)
	ok(Tr.Cell(nx + 2, 2) ~= nil and calls > c2, "it is after half a second in it")
	-- A tile without data is never read (its read would drop Polestar's tile).
	Tr.Reset(); calls = 0
	PolestarPathData[0].packed = { grid = { [31 * 23 + 14 + 1] = "x" } } -- only the tile at kx 31, ky 14 has data
	ok(Tr.Begin(0, 10, 2, 5, true) and calls == 0, "the player's tile has no data: not read")
	PolestarPathData[0].packed = nil
	-- In a hall: the city floor under the ray, rock (the mountain top) far over it: open.
	Tr.Reset(); Polestar_NavEngine.SurfacesAt = function(c, x, y, out)
		out[1], out[-1], out[2], out[-2] = 0, 2, 268, 0
		return 2
	end
	Tr.Begin(0, 10, 2, 10, true)
	ok(Tr.Sees(10, 2, 12, 50, 2, 1, true, 0) == true, "a hall's high ceiling doesn't block")
	Polestar_NavEngine.SurfacesAt = function(c, x, y, out)
		if x >= 30 and x < 40 then out[1], out[-1] = 268, 0; return 1 end -- solid rock between halls
		out[1], out[-1], out[2], out[-2] = 0, 2, 268, 0
		return 2
	end
	Tr.Reset(); Tr.Begin(0, 10, 2, 10, true)
	ok(Tr.Sees(10, 2, 12, 50, 2, 1, true, 0) == false, "rock between halls does")
	-- A camera ray skips its boom (the game keeps it clear) but not the ground beside the player.
	Tr.Reset(); Polestar_NavEngine.SurfacesAt = function(c, x, y, out)
		if x >= 18 and x < 27 and y > 28 and y < 32 then return 0 end -- a wall the camera boom passes through
		if x >= 33 and x < 41 and y > 14 and y < 26 then return 0 end -- a building beside the player
		out[1], out[-1] = 0, 0
		return 1
	end
	Tr.Begin(0, 30, 30, 20, true)
	ok(Tr.Sees(15, 30, 8, 55, 30, 1, false, 0, 30, 30) == true, "the boom behind the player is clear")
	ok(Tr.Sees(15, 30, 8, 55, 30, 1, false, 0) == false, "(the same wall blocks an eye ray)")
	ok(Tr.Sees(15, 30, 8, 55, 5, 1, false, 0, 30, 30) == false, "a building beside the player still blocks")
	Polestar_NavEngine, PolestarPathData = nil, nil
	Tr.Reset()
`) > 0); });

test('actual marker calibration, held pitch, scale/clamp fallback and unmeasured left-drag recovery', () => {
 assert.ok(runtime(`
 enable(); W.marker=true; W.pin={uiMapID=947,position={x=.5,y=.5}}; W.yaw=.15; W.pitch=.3; frame(2.1)
 near(R.CameraState().yaw,.15,"far marker yaw",1e-3); near(R.CameraState().pitch,.3,"calibrated pitch",1e-3)
 ok(R.CameraState().locked and R.CameraState().source=="marker")
 W.px=110; W.pitch=.5; frame(); near(R.CameraState().pitch,.3,"near marker holds pitch",1e-3)
 W.clamped=true; frame(); ok(R.CameraState().source:find("^facing"))
 holdLeft(); ok(R.Why():find("turned away")); near(R.GroundFrame().used,0)
 W.left=false; frame(); ok(R.Why():find("turned away"),"release is not recovery")
 W.looking=true; frame(); ok(R.Why()==nil); W.looking=false
 W.marker=false; W.speed=7; holdLeft(); W.left=false; frame(1.6); ok(R.Why()==nil,"walking recovers")
 W.marker=true; W.clamped=false; W.px=10; W.pitch=.3; W.scale=2
 local T=NS.Trail; local x,y=T.Project(T.Camera(.15,.3,W.zoom,T.Focal(90,1080),1920,1080),190,0,0)
 W.center={x/2,y/2}; frame(); ok(R.CameraState().source=="marker"); near(R.CameraState().yaw,.15,"effective scale",1e-3)
 W.secret=W.center[1]; frame(); ok(R.CameraState().source:find("^facing"),"secret marker rejected")
 W.secret=nil; W.center={2,200}; frame(); ok(R.CameraState().source:find("^facing"),"edge marker rejected")
 near(W.writes,0)
 `)>0);
});

test("accepted renderer heights, bridge floor, fixed samples, sight spring and route-reader gates", () => { assert.ok(runtime(`

 ok(NS.Terrain~=nil,"terrain required")
 UIParent:SetSize(140,140)
 NS.ApplyPreset("lantern")
 W.py=2; W.facing=.6
 W.route={legs={{kind="walk",current=true,pts={{0,0,0},{0,60,0},{0,60,60}}}}}
 enable(); frame(2.1)
	local function spritesY()
		for _, t in ipairs(NS.Render.GroundFrame().stars) do t:Hide() end
		frame(0.3)
		local sum, n = 0, 0
		for _, t in ipairs(NS.Render.GroundFrame().stars) do if t:IsShown() and t.points[1] and t.points[1].relPoint == "BOTTOMLEFT" then sum, n = sum + t.points[1].y, n + 1 end end
		return n > 0 and sum / n or nil
	end
	local flatY = spritesY()
	local engine = W.engine
	engine(function(c, x, y, out) out[1], out[2], out[-1], out[-2] = x * 0.2, x * 0.2 + 9, 0, 0; return 2 end)
	local hillY = spritesY()
	local pr = NS.Render.Probe()
	ok(pr.floor and math.abs(pr.floor - 2) < 1e-6, "the floor under the player is the lower surface: " .. tostring(pr.floor))
	ok(pr.rise and pr.rise > 3 and pr.rise < 9, "the ground rises ahead, under the bridge: " .. tostring(pr.rise))
	ok(flatY and hillY and hillY > flatY, "the trail climbs on screen: " .. tostring(flatY) .. " -> " .. tostring(hillY))
	-- Walking over 4.17 yd cells that step up a yard each: the trail moves smoothly.
	local getPos = Polestar.Compat.GetPlayerWorldPosition
	local function walk()
		local prevY, worst = nil, 0
		for step = 0, 16 do
			local x = 10 + step * 0.25
			Polestar.Compat.GetPlayerWorldPosition = function() return 0, x, 2 end
			local y = spritesY()
			if prevY and y then worst = math.max(worst, math.abs(y - prevY)) end
			prevY = y
		end
		return worst
	end
	engine(nil)
	local flatWorst = walk()
	engine(function(c, x, y, out) out[1] = math.floor(x / 4.17); return 1 end)
	local stepWorst = walk()
	Polestar.Compat.GetPlayerWorldPosition = getPos
	ok(stepWorst < flatWorst + 0.6, "no jumps crossing cells: " .. stepWorst .. " px vs " .. flatWorst .. " on flat ground")
	engine(nil)
	-- Fit to view: a wall across the route 25 yards ahead. The drawn length eases
	-- down to what is in sight, never jumping; taken away, it grows back only
	-- after half a second, smoothly.
	Polestar.Compat.GetPlayerWorldPosition = function() return 0, 10, 0 end
	NS.db.groundLength = 50
	local wall = true
	local function cellX(x) return math.floor((x + 29.5 * 1600 / 3) / (1600 / 3 / 128)) end
	engine(function(c, x, y, out)
		if wall and cellX(x) >= cellX(35) and cellX(x) <= cellX(44) then return 0 end -- whole cells, as the maps are
		out[1], out[-1] = 0, 0
		return 1
	end)
	for _ = 1, 6 do frame(0.05) end
	local S = NS.Render.Sight()
	ok(S.visible and S.visible <= 32 and S.visible >= 20, "in sight up to the wall: " .. tostring(S.visible))
	local prev, maxStep, turns, dir = S.drawn, 0, 0, 0
	for _ = 1, 60 do
		frame(0.05)
		local d = S.drawn - prev
		maxStep = math.max(maxStep, math.abs(d))
		local nd = d > 1e-6 and 1 or d < -1e-6 and -1 or 0
		if nd ~= 0 and dir ~= 0 and nd ~= dir then turns = turns + 1 end
		if nd ~= 0 then dir = nd end
		prev = S.drawn
	end
	ok(turns == 0, "eases without bouncing: " .. turns .. " turns")
	ok(math.abs(S.drawn - S.target) < 0.5, "settles at the wall: " .. S.drawn .. " vs " .. S.target)
	ok(maxStep <= 15 * 0.05 + 1e-9, "never faster than 15 yd/s: " .. maxStep)
	wall = false
	NS.Terrain.Reset()
	local held = S.drawn
	for _ = 1, 6 do frame(0.05) end
	ok(math.abs(S.drawn - held) < 1e-9, "holds for a moment before growing")
	for _ = 1, 100 do frame(0.05) end
	ok(S.drawn > 45, "grows back out in the open: " .. S.drawn)
	-- Walking at the wall: the trail's end stays put in the world (no saw-tooth).
	wall = true
	NS.Terrain.Reset(); NS.Render.ResetGround()
	local px = 10
	Polestar.Compat.GetPlayerWorldPosition = function() return 0, px, 0 end
	for _ = 1, 40 do frame(1 / 60) end
	local ends, flips, lastDir, prevEnd = {}, 0, 0, nil
	for _ = 1, 150 do
		px = px + 7 / 60
		frame(1 / 60)
		local e = px + S.drawn
		if prevEnd then
			local d = e - prevEnd
			local nd = d > 0.02 and 1 or d < -0.02 and -1 or 0
			if nd ~= 0 and lastDir ~= 0 and nd ~= lastDir then flips = flips + 1 end
			if nd ~= 0 then lastDir = nd end
		end
		prevEnd = e
		ends[#ends + 1] = e
	end
	local hi, back = -math.huge, 0
	for _, e in ipairs(ends) do hi = math.max(hi, e); back = math.max(back, hi - e) end
	ok(back < 1, "the end doesn't wander back (most it slips back: " .. back .. " yd)")
	ok(math.abs(ends[#ends] - ends[#ends - 30]) < 1.5, "and stays put near the wall: " .. ends[#ends - 30] .. " -> " .. ends[#ends])
	px = 10
	-- On a boat leg (or any leg Polestar isn't walking) the maps are never read.
	local reads = 0
	engine(function(c, x, y, out) reads = reads + 1; out[1], out[-1] = 0, 0; return 1 end)
	W.route = { legs = { { kind = "boat", current = true, pts = { { 0, 0, 0 }, { 0, 60, 0 }, { 0, 60, 60 } } } } }
	Polestar.Fire("NAV_ROUTE_GEOMETRY")
	for _ = 1, 30 do frame(0.05) end
	ok(reads == 0, "no map reads on a boat leg: " .. reads)
	W.route = { legs = { { kind = "walk", current = true, pts = { { 0, 0, 0 }, { 0, 60, 0 }, { 0, 60, 60 } } } } }
	Polestar.Fire("NAV_ROUTE_GEOMETRY")
	for _ = 1, 10 do frame(0.05) end
	ok(reads > 0, "and read again on a walk")
	-- On a bridge (surfaces 0 and 9 under it), the floor followed up the ramp is kept when the route changes.
	engine(function(c, x, y, out)
		if x < 12 then out[1], out[-1] = math.max(0, (x - 4) * 1.2), 0; return 1 end -- the ramp up
		out[1], out[2], out[-1], out[-2] = 0, 9, 0, 0; return 2                     -- the bridge over the road
	end)
	for step = 0, 40 do
		local x = 4 + step * 0.25
		Polestar.Compat.GetPlayerWorldPosition = function() return 0, x, 0 end
		frame(0.3)
	end
	ok(NS.Render.Probe().floor == 9, "on the bridge: " .. tostring(NS.Render.Probe().floor))
	Polestar.Fire("NAV_ROUTE_GEOMETRY")
	for _ = 1, 5 do frame(0.3) end
	ok(NS.Render.Probe().floor == 9, "still on the bridge after a route change: " .. tostring(NS.Render.Probe().floor))
	engine(function(c, x, y, out) out[1], out[-1] = 0, 0; return 1 end)
	Polestar.Compat.GetPlayerWorldPosition = function() return 0, 10, 0 end
	-- Polestar not reading its floor (arrow off, or arrived): the maps are not read.
	local nreads = 0
	engine(function(c, x, y, out) nreads = nreads + 1; out[1], out[-1] = 0, 0; return 1 end)
	local originalGet=Polestar.Get
	Polestar.Set("nav.arrow", false)
	for _ = 1, 10 do frame(0.05) end
	ok(nreads == 0, "no reads with Polestar's arrow off: " .. nreads)
	Polestar.Set("nav.arrow", true)
	Polestar.Nav.GetTarget = function() return { r = 8 } end
	Polestar.Nav.TargetOffset = function() return 6, 0 end
	for _ = 1, 10 do frame(0.05) end
	ok(nreads == 0, "nor on arrival")
	Polestar.Nav.TargetOffset = function() return 200, 0 end
	for _ = 1, 10 do frame(0.05) end
	ok(nreads > 0, "read again on the way")
	Polestar.Get, Polestar.Nav.GetTarget, Polestar.Nav.TargetOffset = originalGet, nil, nil
	-- With no maps at all the trail keeps its full length (nothing is judged).
	engine(nil)
	NS.db.groundLength = 40
	for _ = 1, 40 do frame(0.05) end
	ok(S.drawn and math.abs(S.drawn - 40) < 0.5, "no maps: the full length, not cut: " .. tostring(S.drawn))
	NS.db.groundSight=false; frame(0.05)
	ok(S.drawn == nil and NS.db.groundSight == false, "sight off: the set length")
	NS.db.groundSight=true
	engine(nil)

`) > 0); });

test('terrain unknown/empty distinction, eviction stop and bounded cell cache', () => {
 assert.ok(runtime(`
 local Tr=NS.Terrain; local calls=0; local evicted=false
 W.engine(function(c,x,y,out)
  calls=calls+1
  if evicted then return nil end
  if x>15 and x<22 then return 0 end
  out[1],out[-1]=0,0; return 1
 end)
 ok(Tr.Begin(0,10,2,0,true)); ok(Tr.Cell(18,2)==false,"known empty")
 ok(Tr.Cell(900,2)==nil,"other tile unknown")
 evicted=true; local n=calls; ok(Tr.Cell(25,2)==nil); near(calls,n+1)
 ok(not Tr.Live()); Tr.Cell(30,2); near(calls,n+1,"stop after shared tile eviction")
 evicted=false; Tr.Begin(0,10,2,.3,true); ok(Tr.Live())
 local cs=1600/3/128
 -- More than 6000 unique cells, all inside the accepted player tile.
 for x=0,79 do for y=0,79 do Tr.Cell(-260+x*cs,-260+y*cs) end end
 local before=calls; Tr.Cell(-260,-260); ok(calls>before,"old cache entries evicted at the cap")
 W.engine(nil); ok(not Tr.Begin(0,10,2,1,true)); ok(Tr.Cell(10,2)==nil)
 `)>0);
});
test('reader gates cover route distance, arrival margin, taxi, routing, handoff and transports; disabled does no terrain work', () => {
 assert.ok(runtime(`
 local reads=0
 enable(); frame(2.1)
 local function engine() W.engine(function(c,x,y,out) reads=reads+1; out[1],out[-1]=0,0; return 1 end) end
 local function blocked(note)
  engine(); reads=0; frame(.3); near(reads,0,note)
 end
 W.taxi=true; blocked("taxi"); W.taxi=false
 W.py=26; blocked("over 25 yd off route"); W.py=0
 W.px=195; blocked("under 10 yd remaining"); W.px=10
 Polestar.Set("nav.navRouting",false); blocked("walking routes off"); Polestar.Set("nav.navRouting",true)
 Polestar.Nav.UsingTomTomArrow=function() return true end; blocked("TomTom arrow"); Polestar.Nav.UsingTomTomArrow=nil
 Polestar.Nav.HandedOff=function() return true end; blocked("handed off"); Polestar.Nav.HandedOff=nil
 Polestar.Transit={Riding=function() return true end}; blocked("riding transport"); Polestar.Transit=nil
 Polestar.Nav.GetTarget=function() return {r=8,area=2} end
 Polestar.Nav.TargetOffset=function() return 16,0 end; blocked("arrival plus hysteresis margin")
 Polestar.Nav.GetTarget=nil; Polestar.Nav.TargetOffset=nil
 engine(); frame(.3); ok(reads>0,"reads resume when all gates admit")
 Polestar.Set("nav.worldTrail",false); reads=0; frame(1); near(reads,0,"disabled terrain work")
 `)>0);
});
test('camera width/gap/max limits, zoom projection, indoors and late standalone suppression use the actual owner', () => {
 assert.ok(runtime(`
 enable(); frame(2.1)
 local g=R.GroundFrame()
 Polestar.Set("nav.worldTrailFlow",0); Polestar.Set("nav.worldTrailWidth",0); frame(); local thin=g.used
 Polestar.Set("nav.worldTrailWidth",2); frame(); ok(g.used>thin,"near scatter widens")
 Polestar.Set("nav.worldTrailGap",.3); Polestar.Set("nav.worldTrailMax",10); frame(); ok(g.used<=10)
 Polestar.Set("nav.worldTrailMax",200); frame(); ok(g.used>10 and g.used<=200)
 local size=g.stars[1]:GetWidth(); W.zoom=30; frame(); ok(g.stars[1]:GetWidth()<size,"zoom-aware sprite projection")
 W.indoors=true; frame(); near(g.used,0,"indoor policy")
 Polestar.Set("nav.worldTrailIndoors",true); frame(); ok(g.used>0)
 stub.addonLoaded("ForeverSparkleTrail"); near(g.used,0); ok(not g:GetScript("OnUpdate")); ok(R.Why():find("ForeverSparkleTrail"))
 near(W.writes,0)
 `)>0);
});

test('raw geometry rejects malformed and non-finite points without changing current/jump selection', () => {
 assert.ok(pure(`
 local g={legs={false,{kind="walk",current=true,pts={false,4,"bad",{0,0/0,0},{0,math.huge,0},{0,0,0},{0,10,0}}},
 {kind="portal",pts={{0,0,0},{0,100,0}}}}}
 local p=T.BuildPaths(g,false); near(#p,1); near(p[1].n,2); near(p[1].total,10)
 near(#T.BuildPaths({legs=false},true),0)
 `)>0);
});

test('Never camera follow does not treat walking after free-orbit as camera recovery', () => {
 assert.ok(runtime(`
 stub.cvars.cameraSmoothStyle="0"
 enable(); frame(2.1)
 local g=R.GroundFrame()
 ok(g.used>0,"normal stationary fallback remains available")
 holdLeft(); near(g.used,0,"long unmeasured left hold stays guarded")
 W.left=false; W.speed=7; frame(2)
 near(g.used,0,"Never-follow walking does not establish camera alignment")
 ok(R.CameraState().turned,"do not declare an unobserved re-centre")
 ok(not R.Why():find("walk"),"Never-follow diagnostics must not recommend walking to re-centre")
 ok(GetCVar("cameraSmoothStyle")=="0","player camera preference is not changed")
 W.looking=true; frame(); ok(g.used>0,"existing right-mouselook yaw recovery is unchanged")
 near(W.writes,0)
 `)>0);
});

test('short left clicks keep fallback visible with missing or clamped marker', () => {
 assert.ok(runtime(`
 stub.cvars.cameraSmoothStyle="0"
 GetCursorDelta=function() error("short-click policy must not depend on zero cursor delta") end
 enable(); frame(2.1)
 local g=R.GroundFrame()
 for _,kind in ipairs({"missing","clamped"}) do
  W.looking=true; frame(); W.looking=false
  W.marker=kind=="clamped"; W.clamped=W.marker
  W.pin=W.marker and {uiMapID=947,position={x=.5,y=.5}} or nil
  frame(); ok(g.used>0,"normal fallback before "..kind.." click")
  for i=1,3 do
   W.left=true; frame(.025)
   ok(g.used>0,"short click down keeps fallback: "..kind)
   frame(.075); ok(g.used>0,"short held click keeps fallback: "..kind)
   W.left=false; frame(.05)
   ok(g.used>0 and not R.CameraState().turned,"release must not latch fallback off: "..kind)
  end
 end
 near(W.writes,0)
 `)>0);
});

for (const pause of ['disabled', 'loading']) {
 test('short-click grace restarts after ' + pause + ' without clearing prior invalidity', () => {
  assert.ok(runtime(`
  stub.cvars.cameraSmoothStyle="0"
  enable(); frame(2.1)
  local g=R.GroundFrame()
  local function pauseAndResume()
   ${pause === 'disabled'
    ? 'Polestar.Set("nav.worldTrail",false); W.left=false; frame(1); Polestar.Set("nav.worldTrail",true); W.left=true; frame(.025)'
    : 'stub.fire("LOADING_SCREEN_ENABLED"); W.left=false; frame(1); stub.fire("LOADING_SCREEN_DISABLED"); frame(1.9); W.left=true; frame(.21)'}
  end
  W.left=true; frame(.025); frame(.05)
  ok(g.used>0,"short press before pause")
  pauseAndResume()
  ok(g.used>0 and not R.CameraState().turned,"old press time must not invalidate the new short click")
  W.left=false; frame(.05)
  W.left=true; frame(.05); frame(.30)
  near(g.used,0,"long hold establishes existing suppression")
  pauseAndResume()
  near(g.used,0,"pause must not clear already invalid camera state")
  W.left=false; W.looking=true; frame(); ok(g.used>0,"existing recovery is unchanged")
  near(W.writes,0)
  `)>0);
 });
}

for (const gate of ['indoors', 'taxi', 'unsettled', 'zero-size']) {
 test('short-click grace restarts after painter gate ' + gate, () => {
  assert.ok(runtime(`
  stub.cvars.cameraSmoothStyle="0"
  enable(); frame(2.1)
  local g=R.GroundFrame()
  local function pauseAndResume()
   ${gate === 'unsettled'
    ? 'stub.fire("PLAYER_ENTERING_WORLD"); W.left=false; frame(1.9); W.left=true; frame(.21)'
    : (gate === 'indoors' ? 'W.indoors=true' : gate === 'taxi' ? 'W.taxi=true' : 'g:SetSize(0,0)') + '; W.left=false; frame(.5); near(g.used,0,"fixture must stop painting"); ' + (gate === 'indoors' ? 'W.indoors=false' : gate === 'taxi' ? 'W.taxi=false' : 'g:SetSize(UIParent:GetWidth(),UIParent:GetHeight())') + '; W.left=true; frame(.05)'}
  end
  W.left=true; frame(.05)
  ok(g.used>0,"short click before gate")
  pauseAndResume()
  ok(g.used>0 and not R.CameraState().turned,"gated old press must not invalidate a fresh short click")
  W.left=false; frame(.05); holdLeft(); near(g.used,0)
  pauseAndResume(); near(g.used,0,"a painter gate cannot clear pre-existing invalidity")
  W.left=false; W.looking=true; frame(); ok(g.used>0,"existing recovery remains")
  near(W.writes,0)
  `)>0);
 });
}

test('following recovery does not count skipped taxi time or carry pre-pause movement', () => {
 assert.ok(runtime(`
 stub.cvars.cameraSmoothStyle="4"
 enable(); frame(2.1)
 local g=R.GroundFrame()
 holdLeft(); W.left=false; W.speed=7; frame(.5)
 near(g.used,0,"partial walking interval has not recovered")
 W.taxi=true; W.speed=0; frame(2)
 near(g.used,0,"fixture taxi gate stops drawing")
 W.taxi=false; W.speed=7; frame(.05)
 near(g.used,0,"following recovery must not count time when camera tracking was paused")
 frame(1.1)
 near(g.used,0,"pre-pause walking must not be carried into the fresh interval")
 frame(.5); ok(g.used>0,"legacy following recovery resumes after its fresh interval")
 near(W.writes,0)
 `)>0);
});

test('hidden ground owner forgets gesture time without clearing prior invalidity', () => {
 assert.ok(runtime(`
 stub.cvars.cameraSmoothStyle="0"
 enable(); frame(2.1)
 local g=R.GroundFrame()
 W.left=true; frame(.05)
 g:Hide(); W.left=false; frame(.5)
 g:Show(); W.left=true; frame(.05)
 ok(g.used>0 and not R.CameraState().turned,"hidden owner must forget an old short press")
 W.left=false; frame(.05); holdLeft(); near(g.used,0)
 g:Hide(); W.left=false; frame(.5)
 g:Show(); W.left=true; frame(.05)
 near(g.used,0,"owner visibility cannot clear prior invalidity")
 W.left=false; W.looking=true; frame(); ok(g.used>0)
 near(W.writes,0)
 `)>0);
});

test('long left holds retain suppression and existing measured or mouselook recovery', () => {
 assert.ok(runtime(`
 stub.cvars.cameraSmoothStyle="0"
 enable(); frame(2.1)
 local g=R.GroundFrame()
 W.left=true; frame(.05); frame(.15)
 ok(g.used>0,"short-click grace before a sustained hold")
 frame(.10); near(g.used,0,"sustained observed hold remains guarded")
 ok(R.Why():find("may have been"),"hold diagnostic must not claim a measured camera turn")
 W.left=false; frame(.05); near(g.used,0,"release is not pose recovery after long hold")
 W.left=true; frame(.05); W.left=false; frame(.05)
 near(g.used,0,"a later short click cannot clear earlier invalidity")
 W.speed=7; frame(2); near(g.used,0,"Never-follow walking stays guarded")
 W.speed=0; W.left=true; W.looking=true; frame()
 ok(g.used>0,"mouselook retains precedence over a mixed-button hold")
 W.looking=false; frame(.05); frame(.30); near(g.used,0,"continuing independent hold can become guarded again")
 W.marker=true; W.pin={uiMapID=947,position={x=.5,y=.5}}; W.yaw=.15; W.pitch=.3; frame()
 ok(g.used>0 and R.CameraState().source=="marker","usable marker still recovers during the hold")
 near(W.writes,0)
 `)>0);
});

test('short unmeasured camera flick explicitly retains the accepted best-effort risk', () => {
 assert.ok(runtime(`
 stub.cvars.cameraSmoothStyle="0"
 enable(); frame(2.1)
 local g=R.GroundFrame()
 W.marker=true; W.pin={uiMapID=947,position={x=.5,y=.5}}; W.clamped=true
 W.left=true; W.yaw=.8; frame(.05)
 W.left=false; frame(.05)
 ok(g.used>0 and not R.CameraState().turned,"brief unmeasured gesture is permitted by the chosen policy")
 ok(math.abs(R.CameraState().yaw-W.yaw)>.5,"the retained fallback is NOT proved to match the real camera")
 W.clamped=false; W.yaw=.15; W.pitch=.3; frame()
 ok(g.used>0 and R.CameraState().source=="marker","a usable marker can replace the wrong estimate")
 near(W.writes,0)
 `)>0);
});

test('enabling follow does not reuse movement time accumulated with Never-follow', () => {
 assert.ok(runtime(`
 stub.cvars.cameraSmoothStyle="0"
 enable(); frame(2.1)
 holdLeft(); W.left=false; W.speed=7; frame(2)
 near(R.GroundFrame().used,0)
 stub.cvars.cameraSmoothStyle="4"; frame(.1)
 near(R.GroundFrame().used,0,"new follow mode needs its own recovery interval")
 frame(1.5); ok(R.GroundFrame().used>0,"legacy following estimate resumes after a fresh interval")
 near(W.writes,0)
 `)>0);
});

test('following camera modes and unavailable setting retain existing recovery behavior', () => {
 assert.ok(runtime(`
 enable(); frame(2.1)
 for _,mode in ipairs({"1","2","4","unavailable"}) do
  stub.cvars.cameraSmoothStyle=mode~="unavailable" and mode or nil
  W.speed=7; holdLeft(); near(R.GroundFrame().used,0,"walking begins from a guarded hold"); W.left=false; frame(1.6)
  ok(R.GroundFrame().used>0 and not R.CameraState().turned,"legacy recovery preserved: "..mode)
 end
 near(W.writes,0)
 `)>0);
});

test('restricted following value stays guarded while a usable marker can still recover', () => {
 assert.ok(runtime(`
 local token=setmetatable({}, {__tostring=function() error("no secret conversion") end})
 local original=GetCVar
 GetCVar=function(key) if key=="cameraSmoothStyle" then return token end return original(key) end
 W.secret=token
 enable(); frame(2.1)
 holdLeft(); W.left=false; W.speed=7; frame(2)
 near(R.GroundFrame().used,0,"restricted following value must not imply re-centred camera")
 W.marker=true; W.pin={uiMapID=947,position={x=.5,y=.5}}; W.yaw=.15; W.pitch=.3; frame()
 ok(R.GroundFrame().used>0 and R.CameraState().source=="marker","independent usable-marker recovery is unchanged")
 near(W.writes,0)
 `)>0);
});

test('unmeasured right-drag pitch cannot reuse ground projection in a skyward view', () => {
 assert.ok(runtime(`
 W.marker=true; W.pin={uiMapID=947,position={x=.5,y=.5}}; W.pitch=.3
 enable(); frame(2.1)
 local g=R.GroundFrame()
 ok(g.used>0 and R.CameraState().source=="marker", "normal measured view draws")
 -- The real camera is now looking up; its reference has become clamped.
 -- A near/first-person zoom makes every ground point outside that view.
 W.looking=true; W.right=true; W.clamped=true; W.pitch=-1.1; W.zoom=0
 local actual=T.Camera(W.yaw,W.pitch,W.zoom,T.Focal(90,1080),1920,1080)
 for x=3,100 do
  local sx,sy=T.Project(actual,x,0,0)
  ok(not sx or sx<0 or sx>1920 or sy<0 or sy>1080, "oracle: ground is outside skyward view")
 end
 frame()
 near(g.used,0,"do not draw with the old downward pitch after a right-drag loses measurement")
 ok(R.Why()~=nil,"unmeasured pitch has an explicit reason")
 W.looking=false; W.right=false; frame()
 near(g.used,0,"release does not establish the camera pitch")
 -- Recover through an actual usable marker, without changing user settings.
 W.clamped=false; W.pitch=.3; W.zoom=15; frame()
 ok(g.used>0 and R.CameraState().source=="marker", "normal measured view recovers")
 near(W.writes,0)
 `)>0);
});

test('sight holds unknown reach and requires two nearer evaluations before shrinking', () => {
 assert.ok(runtime(`
 UIParent:SetSize(140,140); NS.ApplyPreset("lantern"); Polestar.Set("nav.worldTrailLength",50)
 W.py=0; W.facing=.6; W.route={legs={{kind="walk",current=true,pts={{0,0,0},{0,60,0},{0,60,60}}}}}
 local wall=false
 local function cellX(x) return math.floor((x+29.5*1600/3)/(1600/3/128)) end
 W.engine(function(c,x,y,out)
  if wall and cellX(x)>=cellX(35) and cellX(x)<=cellX(44) then return 0 end
  out[1],out[-1]=0,0; return 1
 end)
 enable(); frame(2.5); local s=R.Sight(); near(s.drawn,50)
 local function nextSight()
  local at=s.at
  for i=1,20 do frame(.025); if s.at>at then return end end
  error("bounded wait did not reach the next sight evaluation")
 end
 wall=true; NS.Terrain.Reset(); nextSight()
 ok(s.pending~=nil,"first nearer evaluation is pending"); near(s.target,50,"does not shorten on a single sight evaluation")
 nextSight(); ok(s.target<40,"second nearer evaluation accepted"); frame(3)
 local held=s.drawn
 Polestar_NavEngine.SurfacesAt=function() return nil end
 NS.Terrain.Reset(); frame(1)
 near(s.drawn,held,"unknown reader data holds existing reach",.01)
 `)>0);
});
