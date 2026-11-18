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
	near(T.Focal(90, 1080), 60 * math.sqrt(337), "90 degrees from corner to corner of 16:9", 1e-6)
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
 frame(.5); W.route=nil; Polestar.Fire("NAV_ROUTE_GEOMETRY"); frame(); ok(g.used>0 and g:GetScript("OnUpdate"),"a route that ends leaves its trail to fade out")
 frame(.7); ok(g.used==0 and not g:GetScript("OnUpdate"),"faded out: no route stops work")
 W.route={legs={{kind="walk",current=true,pts={{0,0,0},{0,200,0}}}}}; Polestar.Fire("NAV_ROUTE_GEOMETRY"); frame(); ok(g.used>0)
 near(W.writes,0); ok(g:GetParent()==Polestar.UIParent,"on Polestar's layer, so it hides with Polestar")
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

test('actual marker calibration, measured pitch, scale/clamp fallback and unmeasured left-drag recovery', () => {
 assert.ok(runtime(`
 enable(); W.marker=true; W.pin={uiMapID=947,position={x=.5,y=.5}}; W.yaw=.15; W.pitch=.3; frame(2.1)
 near(R.CameraState().yaw,.15,"far marker yaw",1e-3); near(R.CameraState().pitch,.3,"calibrated pitch",1e-3)
 ok(R.CameraState().locked and R.CameraState().source=="marker")
 W.px=110; W.pitch=.5; frame(); near(R.CameraState().pitch,.5,"a near marker measures the pitch too, with no button held",1e-3)
 -- The tilt has settled before the marker leaves the screen.
 frame(.4); W.clamped=true; frame(); ok(R.CameraState().source:find("^facing"))
 near(R.CameraState().pitch,.5,"the measured pitch holds while the marker is off screen",1e-3)
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

// Opt-in only for the three migrated runtime fixtures. This is a mock of an
// accepted walking snapshot, not an integration test of Nav.walk. Heights are
// explicit fixture data: never acquired from Terrain or the engine read spies.
const bakedFixture = `
 local baked, bakedGeneration = nil, 0
 local observedFloor
 local function bake(strip, spacing)
  local leg=W.route.legs[1]
  bakedGeneration=bakedGeneration+1
  local s={c=leg.pts[1][1],xs={},ys={},distances={},n=#leg.pts,generation=bakedGeneration}
  local distance=0
  for i,p in ipairs(leg.pts) do
   s.xs[i],s.ys[i]=p[2],p[3]
   if i>1 then distance=distance+math.sqrt((p[2]-s.xs[i-1])^2+(p[3]-s.ys[i-1])^2) end
   s.distances[i]=distance
  end
  s.strip,s.stripYd=strip or {0,0},spacing or distance
  s.m=#s.strip; baked=s
 end
 Polestar.Nav.walk={WorldTrail=function()
  if not baked or not W.route or W.route.legs[1].kind~="walk" then return nil end
  local c,x,y=Polestar.Compat.GetPlayerWorldPosition()
  if c~=baked.c then return nil end
  -- Fixture-only projection supplies fresh progress as the mock player moves.
  -- Do not call production nearest/height helpers to manufacture input data.
  local best,along=math.huge,0
  for i=2,baked.n do
   local ax,ay=baked.xs[i-1],baked.ys[i-1]
   local dx,dy=baked.xs[i]-ax,baked.ys[i]-ay
   local len2=dx*dx+dy*dy
   local u=len2>0 and math.max(0,math.min(1,((x-ax)*dx+(y-ay)*dy)/len2)) or 0
   local d2=(x-ax-u*dx)^2+(y-ay-u*dy)^2
   if d2<best then best=d2; along=baked.distances[i-1]+u*math.sqrt(len2) end
  end
  return baked,{sourceAlong=along,off=math.sqrt(best),generation=baked.generation}
 end,Floor=function(c,x,y) return observedFloor and observedFloor(c,x,y) end}
`;

test("accepted renderer heights, bridge floor, fixed samples, sight spring and route-reader gates", () => { assert.ok(runtime(bakedFixture + `

 ok(NS.Terrain~=nil,"terrain required")
 UIParent:SetSize(140,140)
 NS.ApplyPreset("lantern")
 W.py=2; W.facing=.6
 W.route={legs={{kind="walk",current=true,pts={{0,0,0},{0,60,0},{0,60,60}}}}}
 bake() -- flat accepted route before the slope comparison
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
	-- The accepted route runs below the overpass; the other surface is LOS data only.
	bake({0,2,4,6,8,10,12,12,12,12,12,12,12},10)
	local hillY = spritesY()
	local pr = NS.Render.Probe()
	ok(pr.heightSource == "baked-strip" and pr.floorSource == "baked-strip estimate", "accepted strip supplies the baseline, not surface selection")
	near(pr.sourceAlong,10,"fresh source progress")
	near(pr.floor,2,"baked lower-route baseline under the bridge")
	near(pr.rise,10,"full accepted coverage rises ahead below the overpass")
	ok(flatY and hillY and hillY > flatY, "the trail climbs on screen: " .. tostring(flatY) .. " -> " .. tostring(hillY))
	-- Known baked samples a yard higher every 4.17 yd: interpolation stays smooth.
	-- Terrain-cell height acquisition/caching is no longer the renderer contract.
	local getPos = Polestar.Compat.GetPlayerWorldPosition
	local function walk()
		local prevY, worst = nil, 0
		for step = 0, 16 do
			local x = 10 + step * 0.25
			Polestar.Compat.GetPlayerWorldPosition = function() return 0, x, 2 end
			local y = spritesY()
			ok(y ~= nil and R.Probe().heightSource == "baked-strip", "walking comparison draws accepted baked heights")
			if prevY and y then worst = math.max(worst, math.abs(y - prevY)) end
			prevY = y
		end
		return worst
	end
	engine(nil); bake()
	local flatWorst = walk()
	bake({0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29},4.17)
	local stepWorst = walk()
	Polestar.Compat.GetPlayerWorldPosition = getPos
	ok(stepWorst < flatWorst + 0.6, "no jumps crossing cells: " .. stepWorst .. " px vs " .. flatWorst .. " on flat ground")
	engine(nil); bake()
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
	bake() -- fresh accepted generation when the walking route resumes
	Polestar.Fire("NAV_ROUTE_GEOMETRY")
	for _ = 1, 10 do frame(0.05) end
	ok(reads > 0, "and read again on a walk")
	-- The accepted ramp/bridge strip and observed walking floor survive a route change.
	local bridgeStrip={0,0,4.5,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9}
	bake(bridgeStrip,4)
	observedFloor=function(c,x,y) return math.max(0,math.min(9,(x-4)*9/8)) end
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
	ok(NS.Render.Probe().heightSource == "baked-strip" and NS.Render.Probe().floorSource == "observed-walk-floor", "bridge baseline comes from the observational getter")
	bake(bridgeStrip,4) -- new accepted snapshot, same bridge rather than the road below
	Polestar.Fire("NAV_ROUTE_GEOMETRY")
	for _ = 1, 5 do frame(0.3) end
	ok(NS.Render.Probe().floor == 9, "still on the bridge after a route change: " .. tostring(NS.Render.Probe().floor))
	engine(function(c, x, y, out) out[1], out[-1] = 0, 0; return 1 end)
	observedFloor=nil; bake()
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
	-- With no LOS maps the accepted baked baseline still draws at full length.
	engine(nil)
	NS.db.groundLength = 40
	for _ = 1, 40 do frame(0.05) end
	ok(S.drawn and math.abs(S.drawn - 40) < 0.5, "no maps: the full length, not cut: " .. tostring(S.drawn))
	ok(R.Probe().heightSource == "baked-strip", "missing LOS maps do not discard accepted heights")
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
 assert.ok(runtime(bakedFixture + `
 bake()
 local reads=0
 enable(); frame(2.1)
 ok(R.Probe().heightSource == "baked-strip", "reader gates start with a valid baked baseline")
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

// In combat the client can keep the player's speed and facing secret: a secret value throws when it is compared
// or worked on, and the client logs the attempt against the addon. Both read as unknown, never touched.
const SECRET = `local function boom() error("secret touched") end
 local token=setmetatable({}, {__add=boom, __sub=boom, __mul=boom, __div=boom, __unm=boom, __lt=boom, __le=boom, __eq=boom, __tostring=boom})`;

test('a speed the client keeps secret is never compared: the hold is not taken for a re-centred view, and walking recovers once it reads again', () => {
 assert.ok(runtime(`
 ${SECRET}
 enable(); frame(2.1)
 W.speed=token; W.secret=token
 holdLeft(); W.left=false; frame(2)
 near(R.GroundFrame().used,0,"a secret speed is no movement: the view is not taken for re-centred")
 ok(R.CameraState().turned,"the hold still stands")
 W.speed=7; W.secret=nil; frame(1.6)
 ok(R.GroundFrame().used>0 and not R.CameraState().turned,"walking recovers once the speed reads again")
 near(W.writes,0)
 `)>0);
});

test("a facing the client keeps secret is never worked on: the view is still solved from the map pin's marker, and the probe reports no facing", () => {
 assert.ok(runtime(`
 ${SECRET}
 W.marker=true; W.pin={uiMapID=947,position={x=.5,y=.5}}; W.yaw=.15; W.pitch=.3
 W.facing=token; W.secret=token
 enable(); frame(2.1)
 ok(R.GroundFrame().used>0 and R.CameraState().source=="marker","the marker alone gives the view")
 ok(R.Probe().facing==nil,"the probe reports no facing")
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
 assert.ok(runtime(bakedFixture + `
 UIParent:SetSize(140,140); NS.ApplyPreset("lantern"); Polestar.Set("nav.worldTrailLength",50)
 W.py=0; W.facing=.6; W.route={legs={{kind="walk",current=true,pts={{0,0,0},{0,60,0},{0,60,60}}}}}
 bake()
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

// Camera tilt. The mock marker is the waypoint at world (200, 0) seen through
// the real camera (W.yaw, W.pitch); the trail's camera must agree with it, or
// draw nothing. Synthetic round-trips share the solver's camera model: they
// show the logic follows the marker, not that the game's camera matches it.
const tiltKit = `
 -- These tests are about where the ground is drawn, not the look. They keep the look they were written
 -- with (30 yd from 3 yd ahead, thin and fully faded), which leaves some of the trail in every view they
 -- turn to: straight down, or from 60 yd beside the route. The default look starts 6.5 yd ahead and is 20
 -- long, so from there it is out of view.
 for key,value in pairs({Ahead=3,Length=30,Gap=1.7,Width=1,Fade=1,Flow=.5}) do Polestar.Set("nav.worldTrail"..key,value) end
 local PIN={uiMapID=1,position={x=.5,y=1}} -- a pin the game can place: world (200, 0)
 local function real() return T.Camera(W.yaw,W.pitch,W.zoom,T.Focal(90,1080),1920,1080) end
 -- Pixels between where the trail's camera and the real one put the ground ahead.
 local function groundError()
  local cam,actual,worst=R.CameraState().cam,real(),0
  for x=5,40,5 do
   local ax,ay=T.Project(actual,x,0,0); local bx,by=T.Project(cam,x,0,0)
   if ax and bx then worst=math.max(worst,math.abs(ax-bx),math.abs(ay-by)) end
  end
  return worst
 end
 -- The same for the ground straight ahead of the view, whichever way it is turned.
 local function aheadError()
  local cam,actual,worst=R.CameraState().cam,real(),0
  for d=5,40,5 do
   local gx,gy=math.cos(W.yaw)*d,math.sin(W.yaw)*d
   local ax,ay=T.Project(actual,gx,gy,0); local bx,by=T.Project(cam,gx,gy,0)
   if ax and bx then worst=math.max(worst,math.abs(ax-bx),math.abs(ay-by)) end
  end
  return worst
 end
 local function drawn() return R.GroundFrame().used>0 end
 local function tiltHidden() return R.GroundFrame().used==0 and (R.Why() or ""):find("tilted")~=nil end
 -- The pinned marker contradicts the tilt held: the tilt is lost, and what is drawn is the short trail.
 local function tiltLost() return R.Probe().tilt=="lost" and R.Probe().trail=="short" end
 local function drag(on) W.looking=on; W.right=on end
`;

test('a usable marker measures the tilt every frame, at any distance, with no button held', () => {
 assert.ok(runtime(tiltKit + `
 W.marker=true; W.pin=PIN; W.yaw=.1; enable(); frame(2.1)
 for _,case in ipairs({{10,{.42,.3,.15,.05,.25,.45}},{150,{.2,.5,.55,.35,.1}},{185,{.3,.6,.9,.5,.2}}}) do
  W.px=case[1]
  for _,pitch in ipairs(case[2]) do
   W.pitch=pitch; frame()
   local note=" at pitch "..pitch..", "..(200-W.px).." yd from the waypoint"
   ok(R.CameraState().source=="marker" and drawn(),"drawn from the marker"..note)
   near(R.CameraState().pitch,pitch,"pitch"..note,1e-3)
   near(R.CameraState().yaw,.1,"yaw"..note,1e-3)
   ok(groundError()<1,"the ground stays put on screen"..note..": "..groundError())
   ok(R.Probe().tilt=="measured")
  end
 end
 near(W.writes,0)
 `)>0);
});

test('walking with the camera untouched holds the pitch and learns the marker height; a drag is then measured against it', () => {
 assert.ok(runtime(tiltKit + `
 W.marker=true; W.pin=PIN; W.pitch=.3; enable(); frame(2.1)
 near(R.CameraState().pitch,.3,"measured standing",1e-3)
 W.speed=7
 for i=1,20 do W.px=W.px+.35; W.markerZ=i*.4; frame() end
 near(R.CameraState().pitch,.3,"a hill walked over does not read as a tilt",1e-3)
 near(R.Probe().lift,8,"the waypoint's height is learnt from the marker",.05)
 ok(R.Probe().tilt=="held" and drawn() and groundError()<1,"and the ground stays put: "..groundError())
 drag(true)
 for _,pitch in ipairs({.35,.45,.2,.1}) do
  W.px=W.px+.35; W.pitch=pitch; frame()
  near(R.CameraState().pitch,pitch,"a drag while walking is measured against the learnt height",1e-3)
  ok(drawn() and groundError()<1,"ground error "..groundError())
 end
 drag(false)
 -- No button, but a tilt no hill explains (a key binding): the camera's, not the ground's.
 W.px=170; frame(); W.pitch=.44; frame()
 near(R.CameraState().pitch,.44,"an unexplained jump of the marker is measured as a tilt",1e-3)
 near(R.Probe().lift,8,"without unlearning the height",.05)
 -- A drag nothing measured (the marker off screen), then the marker back with no button held.
 W.clamped=true; drag(true); frame(); W.pitch=.4; frame(); drag(false); frame()
 W.clamped=false; frame()
 near(R.CameraState().pitch,.4,"a pitch that may have been dragged unmeasured is measured afresh, not held",1e-3)
 near(W.writes,0)
 `)>0);
});

test('a waypoint ending a baked leg is measured against the strip height there', () => {
 assert.ok(runtime(bakedFixture + tiltKit + `
 W.marker=true; W.pin=PIN
 bake({0,5,10,15,20},50) -- the leg climbs 20 yards; the feet are 1 up at 10 yards along
 W.markerZ=19; W.pitch=.3; enable(); frame(2.1)
 ok(R.Probe().heightSource=="baked-strip")
 for _,pitch in ipairs({.3,.15,.35,.25}) do
  W.pitch=pitch; frame()
  near(R.CameraState().pitch,pitch,"pitch against a marker 19 yards above the feet",1e-3)
  ok(drawn())
 end
 near(R.Probe().lift,0,"the strip explains the marker's height",1e-6)
 near(R.Probe().height,19,"the waypoint's height above the feet",1e-6)
 `)>0);
});

for (const clamp of ['axis', 'radial']) {
 test('a marker tilted off the top or bottom of the screen leaves the trail at the tilt last measured (' + clamp + ' pinning)', () => {
  assert.ok(runtime(tiltKit + `
  W.engineClamp="${clamp}"; W.marker=true; W.pin=PIN; W.pitch=.3; enable(); frame(2.1)
  ok(drawn() and R.CameraState().source=="marker")
  for _,step in ipairs({.05,-.06}) do -- down past where the marker shows, then up past it
   drag(true)
   local leftAt
   for i=1,25 do
    W.pitch=.3+i*step; frame()
    ok(R.Probe().tilt~="lost" and not (R.Why() or ""):find("tilted"),"never hidden for the tilt, pitch "..W.pitch..": "..tostring(R.Why()))
    if R.Probe().offScreen then
     leftAt=leftAt or R.CameraState().pitch
     ok(R.Probe().tilt=="held","held once the marker has left")
     near(R.CameraState().pitch,leftAt,"at the pitch it was last measured at",1e-9)
    else
     ok(not leftAt,"the marker does not come back while the tilt goes on")
     near(R.CameraState().pitch,W.pitch,"measured while the marker is on screen",1e-3)
     ok(groundError()<1,"ground error "..groundError())
    end
   end
   ok(leftAt and math.abs(leftAt-.3)>.1,"the trail followed the tilt as far as the marker showed it: "..tostring(leftAt))
   if step>0 then ok(drawn(),"and is still drawn, looking down past it") end
   drag(false); frame(); W.speed=7; frame(2); W.speed=0
   near(R.CameraState().pitch,leftAt,"letting go and walking change nothing",1e-9)
   ok(R.Probe().tilt=="held" and not (R.Why() or ""):find("tilted"),"and the trail is not taken away, however long the marker stays off")
   drag(true); W.pitch=.3; frame(); drag(false)
   ok(drawn() and R.CameraState().source=="marker","back into view: measured and drawn")
   near(R.CameraState().pitch,.3,"pitch",1e-3)
   frame(.5)
  end
  near(W.writes,0)
  `)>0);
 });

 // (A marker clamped toward the centre lies, at this bearing, where the rule would put it too: only the other is told apart.)
 if (clamp === 'axis') test('a client that pins its marker another way: the rule is given up, and a tilt its pinned place contradicts draws the short trail while it does (' + clamp + ' pinning)', () => {
  assert.ok(runtime(tiltKit + `
  W.engineClamp="${clamp}"; W.marker=true; W.pin=PIN; W.pitch=.3; enable(); frame(2.1)
  -- Twice the view is turned (by the keys: the camera is not touched, so the tilt stays exactly
  -- known) until the marker is pinned at the side, where this client puts it somewhere the rule
  -- cannot explain.
  for round=1,2 do
   for i=1,13 do W.yaw=i*.07; W.facing=W.yaw; frame() end
   frame(.4)
   ok(drawn() and R.CameraState().source:find("^facing"),"turned away: the trail stays, at the tilt it had")
   near(R.CameraState().pitch,.3,"which is still exactly known",1e-3)
   for i=12,0,-1 do W.yaw=i*.07; W.facing=W.yaw; frame() end
   ok(R.CameraState().source=="marker")
  end
  ok(R.Probe().pinRule=="given up","the rule disagreed with a known tilt twice and never agreed: "..R.Probe().pinRule)
  -- From here the pinned marker is only evidence: steered off to the side, then tilted.
  drag(true)
  for i=1,13 do W.yaw=i*.07; W.facing=W.yaw; frame() end -- 52 degrees round: the waypoint is off to the side
  ok(drawn() and R.CameraState().source:find("^facing"),"steering away keeps the trail: "..tostring(R.Why()))
  ok(R.Probe().tilt=="held" and R.Probe().offScreen)
  near(R.CameraState().pitch,.3,"at the last measured pitch",1e-3)
  ok(R.Probe().trail=="short","a drag nothing read: the short trail")
  drag(false); frame(.5); ok(drawn(),"and after letting go")
  drag(true); W.pitch=1.2; frame()
  ok(tiltLost() and not tiltHidden(),"looking straight down with the marker pinned at the side: the short trail, not none ("..tostring(R.Why())..")")
  frame(1); ok(tiltLost(),"lost for as long as the marker says so")
  W.pitch=.3; frame(); ok(tiltLost(),"and not taken back the moment it stops")
  frame(.6); ok(drawn() and R.Probe().tilt~="lost","but once the marker has agreed with the held tilt for a moment")
  ok(R.Probe().trail=="short","the trail stays short until something reads the tilt")
  W.pitch=1.2; frame(); ok(tiltLost(),"lost again when it disagrees again")
  W.pitch=.3; W.yaw=0; W.facing=0; frame(); drag(false)
  ok(drawn() and R.CameraState().source=="marker","the marker back in view measures it at once")
  -- A near, low marker swung out of view and back, never tilted: never hidden for tilt.
  W.px=180; W.pitch=.5; frame(.5)
  drag(true)
  for i=1,40 do
   W.yaw=(i<=20 and i or 40-i)*.075; W.facing=W.yaw; frame()
   ok(not (R.Why() or ""):find("tilted") and R.Probe().tilt~="lost","steering alone is not a tilt, yaw "..W.yaw)
  end
  drag(false)
  ok(drawn() and R.CameraState().source=="marker")
  near(W.writes,0)
  `)>0);
 });
}

test('with no marker at all the tilt is never measured and the estimate stays, as before', () => {
 assert.ok(runtime(tiltKit + `
 enable(); frame(2.1)
 ok(drawn() and R.Probe().tilt=="assumed")
 drag(true); W.pitch=1.2; frame(); frame(.5)
 ok(drawn() and R.Probe().tilt=="assumed","no reference: the estimate is drawn, not hidden (known limit)")
 ok(groundError()>100,"and it is NOT where the ground is: "..groundError())
 near(W.writes,0)
 `)>0);
});

test('a contradicted tilt is no longer called lost once the marker that said so is gone', () => {
 assert.ok(runtime(tiltKit + `
 W.engineClamp="axis"; W.marker=true; W.pin=PIN; W.pitch=.3; enable(); frame(2.1)
 for round=1,2 do -- this client pins another way: the rule is given up (see the test before)
  for i=1,13 do W.yaw=i*.07; W.facing=W.yaw; frame() end; frame(.4)
  for i=12,0,-1 do W.yaw=i*.07; W.facing=W.yaw; frame() end
 end
 ok(R.Probe().pinRule=="given up")
 drag(true)
 for i=1,13 do W.yaw=i*.07; W.facing=W.yaw; frame() end -- the waypoint off to the side, its marker pinned there
 W.pitch=1.2; frame()
 ok(tiltLost())
 W.marker=false; W.pin=nil; frame(.3); ok(tiltLost(),"a marker missing for a moment (the pin being moved) does not put the tilt straight back")
 frame(.4); ok(drawn() and R.Probe().tilt~="lost","no marker says otherwise any more: the plain estimate again")
 `)>0);
});

test('a marker the game reports no valid screen position for is not used; walking toward a high waypoint is not a tilt', () => {
 assert.ok(runtime(tiltKit + `
 W.marker=true; W.pin=PIN; W.pitch=.3; enable(); frame(2.1)
 ok(R.CameraState().source=="marker")
 W.validScreen=false; frame(); ok(R.CameraState().source:find("^facing") and drawn(),"invalid position: the estimate")
 W.validScreen=nil; frame(); ok(R.CameraState().source=="marker")
 -- The waypoint is up a cliff: its marker climbs off the top as the player walks, camera untouched.
 W.engineClamp="axis"; W.speed=7
 for i=1,40 do W.px=W.px+.35; W.markerZ=i*2.5; frame() end
 ok(R.Probe().offScreen,"the marker has left the screen")
 ok(drawn() and R.Probe().tilt=="held","and the trail is still drawn: "..tostring(R.Why()))
 near(R.CameraState().pitch,.3,"at the pitch the camera still has",1e-3)
 `)>0);
});

test('/polestar trail probe reports the mode, the tilt state, the marker and whether anything is drawn', () => {
 assert.ok(runtime(tiltKit + `
 W.engineClamp="axis"; W.marker=true; W.pin=PIN; W.pitch=.3; enable(); frame(2.1)
 local function probe() stub.messages={}; SlashCmdList.POLESTAR("trail probe"); return stub.messages[1] or "" end
 local line=probe()
 ok(line:find("tilt measured, pitch 0.30",1,true) and line:find("from marker",1,true) and line:find("; drawn",1,true),line)
 ok(line:find("bearing 0.00",1,true) and line:find("saved pitch nil",1,true),line)
 drag(true); for i=1,12 do W.pitch=.3+i*.05; frame() end; drag(false)
 line=probe()
 ok(line:find("tilt held",1,true) and line:find("(off screen)",1,true) and line:find("; drawn",1,true),line)
 -- A client that pins another way gives the rule up; then, steered off to the side and
 -- tilted, the pinned marker contradicts the held tilt.
 W.pitch=.3; W.yaw=0; W.facing=0; frame(.5)
 for round=1,2 do
  for i=1,13 do W.yaw=i*.07; W.facing=W.yaw; frame() end; frame(.4)
  for i=12,0,-1 do W.yaw=i*.07; W.facing=W.yaw; frame() end
 end
 drag(true); W.pitch=.3; frame(); for i=1,13 do W.yaw=i*.07; W.facing=W.yaw; frame() end
 stub.cvars.cameraSavedPitch="12.5"; W.pitch=1.2; frame(); drag(false)
 line=probe()
 ok(line:find("trail short; tilt lost",1,true) and line:find("; drawn",1,true),line)
 ok(line:find("bearing -0.91",1,true) and line:find("saved pitch 12.5",1,true),line)
 ok(Polestar.Get("nav.worldTrail")==true,"the probe changes nothing")
 near(W.writes,0)
 `)>0);
});

// The client's own pinning, as recorded (the stub's "wowf"): the tilt is read from a marker pinned
// to a side or the bottom of the screen once its place is known.
test("the pinning rule gives the tilt back for every bearing it covers, and says what it cannot read", () => { assert.ok(pure(`
 local hx,hy=1265,705
 local function pinnedAt(b,p) -- the rule, forwards: bearing to the right and tilt, in degrees
  local a=math.abs(b)
  local dx,dy
  if a<p then dx,dy=hx*a/p,hy elseif a<=90+p then dx,dy=hx,hy*(1-(a-p)/45) else dx,dy=hx*(180-a)/(90-p),-hy end
  return b<0 and -dx or dx,dy
 end
 for _,p in ipairs({0,10,19.69,45,64.8,83}) do
  for b=-174,174,3 do
   local a=math.abs(b)
   local dx,dy=pinnedAt(b,p)
   local got,kind=T.PinnedPitch(dx,dy,math.rad(b),hx,hy)
   local corner=math.abs(a-(90+p))<.2 or math.abs(a-p)<.2
   if a<p-.2 then ok(got==nil and kind=="top","the top edge is not read, bearing "..b.." tilt "..p)
   elseif corner then ok(true)
   elseif a>90+p and math.abs(dx)<hx*.08 then ok(got==nil and kind=="behind","too near straight behind to tell")
   else
    ok(got,"read at bearing "..b..", tilt "..p..": "..tostring(kind))
    near(math.deg(got),p,"tilt at bearing "..b,1e-6)
    near(math.deg(T.PinnedBearing(dx,dy,math.rad(p),hx,hy)),b,"and the bearing back from the tilt",1e-6)
   end
  end
 end
 -- The recording's own settled places (2560 x 1440, the place 131.1 and 144.5 degrees round, the client's saved tilt 19.69).
 near(math.deg(T.PinnedPitch(2161.2-1280,15-720,math.rad(131.1),hx,hy)),19.8,"recorded, on the bottom edge",.1)
 near(math.deg(T.PinnedPitch(1919.4-1280,15-720,math.rad(144.5),hx,hy)),19.7,"recorded, further round",.1)
 near(math.deg(T.PinnedPitch(2545-1280,406.5-720,math.rad(129.8),hx,hy)),64.8,"recorded, tilted well down: on the side edge",.1)
 local got,kind=T.PinnedPitch(2545-1280,15-720,math.rad(100),hx,hy); ok(got==nil and kind=="corner")
 got,kind=T.PinnedPitch(300,-705,math.rad(20),hx,hy); ok(got==nil and kind=="ahead under the view","a place ahead pinned at the bottom: the view is turned up")
 got,kind=T.PinnedPitch(-1265,0,math.rad(60),hx,hy); ok(got==nil and kind=="other side")
 got,kind=T.PinnedPitch(400,100,math.rad(60),hx,hy); ok(got==nil and kind=="free")
`) > 0); });

test("a map pin's marker pinned to the edge of the screen still gives the tilt", () => {
 assert.ok(runtime(tiltKit + `
 W.engineClamp="wowf"; W.marker=true; W.pin=PIN; W.pitch=.35; enable(); frame(2.1)
 ok(R.CameraState().source=="marker")
 -- Steering away until the pin is behind, then tilting: the marker is pinned all the while.
 drag(true)
 for i=1,30 do W.yaw=W.yaw-.07; W.facing=W.yaw; frame() end
 frame(.4)
 ok(R.Probe().offScreen and R.Probe().tilt=="read from the pinned marker","pinned, and read: "..tostring(R.Probe().tilt))
 ok(R.CameraState().source:find("pinned marker for the tilt",1,true))
 near(R.CameraState().pitch,.35,"the tilt it had",.01)
 for _,to in ipairs({.6,1.0,1.4,.9,.2}) do
  for i=1,10 do W.pitch=W.pitch+(to-W.pitch)*.4; frame() end
  frame(.4)
  near(R.CameraState().pitch,W.pitch,"followed to "..to,.01)
  ok(aheadError()<12,"the ground ahead stays put on screen at tilt "..to..": "..aheadError())
 end
 -- Round to the side and on round the front: every bearing but the top edge's.
 W.pitch=.5; frame(.4)
 for i=1,60 do
  W.yaw=W.yaw+.07; W.facing=W.yaw; frame()
  if R.Probe().offScreen and R.Probe().tilt=="read from the pinned marker" then near(R.CameraState().pitch,.5,"while turning, yaw "..W.yaw,.03) end
 end
 drag(false)
 near(W.writes,0)
 `)>0);
});

test("after a reload with the marker behind: straight down is followed and a view turned up at the sky is not drawn", () => {
 assert.ok(runtime(tiltKit + `
 -- The client saved the tilt at the reload; Polestar's pin lies behind and to the right, never in view.
 W.engineClamp="wowf"; W.marker=true; W.pin=PIN; W.pitch=math.rad(20); W.yaw=2.3; W.facing=2.3
 enable(); frame(2.6)
 local probe=R.Probe()
 ok(probe.offScreen and probe.tilt=="assumed" and probe.exact,"nothing has measured the tilt: it is the saved one")
 ok(probe.mode=="pin" and probe.tracking=="Polestar's map pin",probe.tracking)
 near(R.CameraState().pitch,math.rad(20),"the saved tilt",1e-9)
 ok(drawn())
 -- Straight down: the tilt is read from the pinned marker and the trail stays on the ground.
 drag(true)
 for i=1,25 do W.pitch=W.pitch+(1.45-W.pitch)*.3; frame() end
 frame(.4)
 ok(R.Probe().tilt=="read from the pinned marker","read: "..tostring(R.Probe().tilt))
 near(R.CameraState().pitch,W.pitch,"straight down",.01)
 ok(aheadError()<12,"on the ground, seen from above: "..aheadError())
 -- Up at the sky: the marker goes to a bottom corner, and nothing is drawn.
 for i=1,25 do W.pitch=W.pitch+(-1.3-W.pitch)*.3; frame() end
 frame(.5)
 ok(R.GroundFrame().used==0 and (R.Why() or ""):find("turned up",1,true),"turned up: "..tostring(R.Why()))
 drag(false); frame(1)
 ok(R.GroundFrame().used==0,"for as long as it is")
 -- And back to an ordinary view.
 drag(true)
 for i=1,25 do W.pitch=W.pitch+(.4-W.pitch)*.3; frame() end
 frame(.4); drag(false)
 ok(drawn() and R.Probe().tilt=="read from the pinned marker")
 near(R.CameraState().pitch,W.pitch,"an ordinary view again",.01)
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

test("the first tilt is the one the client saved, until a marker measures it", () => {
 assert.ok(runtime(tiltKit + `
 enable(); frame(2.1)
 near(R.CameraState().pitch,math.rad(26.5),"taken from the saved view",1e-9)
 ok(drawn() and R.Probe().tilt=="assumed" and R.Probe().anchor=="the view the client saved")
 W.marker=true; W.pin=PIN; W.pitch=.3; frame()
 near(R.CameraState().pitch,.3,"and measured as soon as a marker shows",1e-3)
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="26.5"')>0);
});

test("/polestar trail record keeps what the marker does through four timed steps, and only watches", () => {
 assert.ok(runtime(tiltKit + `
 W.engineClamp="radial"; W.marker=true; W.pin=PIN
 stub.cvars.cameraSavedPitch="26.5"; stub.cvars.cameraSavedDistance="15"
 enable(); frame(2.1)
 stub.messages={}
 SlashCmdList.POLESTAR("trail record")
 ok(R.Recording() and stub.messages[1]:find("trail record: 44 seconds",1,true),tostring(stub.messages[1]))
 frame(1); ok(stub.messages[2]:find("1 of 4",1,true),tostring(stub.messages[2]))
 W.pitch=1.2; frame(10); ok(stub.messages[3]:find("2 of 4",1,true),tostring(stub.messages[3]))
 frame(12); frame(12); frame(10.2)
 ok(not R.Recording(),"it ends by itself")
 local last=stub.messages[#stub.messages]
 ok(last:find("done",1,true) and last:find("/reload",1,true),last)
 local caught,inView=tonumber(last:match("the marker inside the picture in (%d+) of them")),0
 for _,q in ipairs(Polestar.DB().trailRecording.samples) do if q[4] and q[6]==0 then inView=inView+1 end end
 ok(caught==inView and inView>0 and inView<#Polestar.DB().trailRecording.samples,"and says how much of the run caught the marker in view: "..last)
 local rec=Polestar.DB().trailRecording
 ok(rec and rec.version==1 and #rec.samples>400 and rec.width==1920 and rec.height==1080,"kept with the saved variables")
 local fields=0; for _ in rec.fields:gmatch("[^,]+") do fields=fields+1 end
 local first,final=rec.samples[1],rec.samples[#rec.samples]
 near(#first,fields,"a value for every named field")
 ok(first[2]==1 and final[2]==4,"each sample knows its step")
 near(first[11],26.5,"the saved tilt"); near(first[12],15,"the saved distance"); near(first[13],15,"the zoom")
 ok(first[10]==1 and first[6]==0 and first[18]==200 and first[19]==0,"a map pin, in view, with its place in the world")
 local pinned
 for _,q in ipairs(rec.samples) do if q[2]==2 and q[6]==1 then pinned=q end end
 ok(pinned and pinned[4] and pinned[5],"pinned off screen in the steep view, with where the game put it")
 near(W.writes,0)
 -- A second command while one runs stops it, and keeps nothing of that one.
 SlashCmdList.POLESTAR("trail record"); frame(1); SlashCmdList.POLESTAR("trail record")
 ok(not R.Recording() and Polestar.DB().trailRecording==rec)
 -- With the trail off there is no frame to watch from.
 Polestar.Set("nav.worldTrail",false); stub.messages={}
 SlashCmdList.POLESTAR("trail record")
 ok(not R.Recording() and stub.messages[1]:find("turn the ground trail on",1,true))
 -- With nothing tracked the game has no marker: a run would come back empty, so none is begun.
 enable(); frame(.5); W.noFrame=true; stub.messages={}
 SlashCmdList.POLESTAR("trail record")
 ok(not R.Recording() and stub.messages[1]:find("the game shows no waypoint marker to record",1,true),tostring(stub.messages[1]))
 `)>0);
});

// A drag as the game applies it: the mouse pushed right turns the character
// and the view right (the facing falls), pushed up turns the view up (the
// pitch, positive looking down, falls) at half the turn's rate per unit, as
// far as the view goes. The cursor's travel is reported each frame.
const mouseKit = tiltKit + `
 local K=.002 -- radians of turn per cursor unit
 local function mouse(dx,dy,frames,tiltRate)
  for i=1,frames do
   W.cursor={dx,dy}
   W.yaw=W.yaw-dx*K; if W.looking then W.facing=W.yaw end
   W.pitch=math.max(-1.53,math.min(1.53,W.pitch-dy*(tiltRate or K/2)))
   frame()
  end
  W.cursor={0,0}
 end
`;

// A map pin of Polestar's own at a place given from where the player stands. (pinWorld: the pin the stub's map
// puts at a world place.)
const pinKit = tiltKit + `
 local function pinWorld(x,y) return {uiMapID=1,position={x=(200-y)/400,y=(x+200)/400}} end
 -- Polestar's pin \`ahead\` yd ahead and \`side\` yd to the side, its place \`dz\` yd above the player; the
 -- game's distance to it is measured in the air, as the client's is.
 local PLACE,OTHER
 local function pin(ahead,side,dz) PLACE,OTHER={ahead,side,dz},false; W.marker=true end
 -- The same for a quest the game tracks by itself: a marker with no pin behind it.
 local function tracked(ahead,side,dz) PLACE,OTHER={ahead,side,dz},true; W.marker=true end
 local function place()
  W.markerAt={W.px+PLACE[1],W.py+PLACE[2]}; W.markerZ=PLACE[3]
  W.pin=not OTHER and pinWorld(W.markerAt[1],W.markerAt[2]) or nil
  W.distance=math.sqrt(PLACE[1]^2+PLACE[2]^2+PLACE[3]^2)
 end
 local function paint(dt) place(); frame(dt) end
 local function rows()
  local g,lo,hi=R.GroundFrame()
  for i=1,g.used do
   local _,_,_,_,y=g.stars[i]:GetPoint()
   lo,hi=math.min(lo or y,y),math.max(hi or y,y)
  end
  return (hi or 0)-(lo or 0)
 end
`;

// The trail leads to the guide's next step, and whatever the game tracks by itself has no say in it. The game
// takes up a quest when it is accepted (with nothing else tracked) and shows a marker for it at a place and a
// height an addon is not told. Read for the tilt, as it once was, such a marker laid the trail in a clump under
// the character (a place far below read as level) or stood it in the air. So only the marker of a map pin
// Polestar set itself is read, the game's waypoint being switched on: its place is the one Polestar gave it.
test("a marker Polestar did not place is never read: a quest the game tracks by itself, or a map pin of the player's own", () => {
 assert.ok(runtime(pinKit + `
 W.engineClamp="wowf"; W.zoom=39; W.pitch=math.rad(20)
 -- A quest the game tracks, its place 120 yd ahead and far below: the marker shows low on the screen.
 tracked(120,10,-150); enable(); paint(2.1); paint(.3)
 local probe=R.Probe()
 ok(probe.mode=="no pin" and probe.tracking=="something Polestar did not place (not read)",probe.tracking)
 near(R.CameraState().pitch,math.rad(20),"the tilt the client saved stands",1e-9)
 ok(R.CameraState().exact and probe.tilt=="assumed","and is exact still: nothing has moved the view")
 ok(drawn() and groundError()<1,"the trail on the ground: "..groundError())
 -- Wherever the marker shows, level and far off, or pinned to the screen's edge behind the player.
 for _,at in ipairs({{900,0,0},{-300,40,0},{30,200,-80}}) do
  tracked(at[1],at[2],at[3]); paint(); paint(.3)
  near(R.CameraState().pitch,math.rad(20),"not read at "..at[1]..", "..at[2],1e-9)
  ok(R.CameraState().source:find("^facing") and (R.Why()==nil or not R.Why():find("tilted")),R.CameraState().source)
 end
 -- A map pin the player set by hand, or another addon's: its place is on the map, but it is not Polestar's.
 pin(200,0,0); W.foreignPin=true; paint(); paint(.3)
 ok(R.Probe().mode=="no pin" and R.Probe().tracking=="a map pin Polestar did not set (not read)",R.Probe().tracking)
 ok(R.Probe().tilt=="assumed")
 -- Polestar's own pin there: read at once, the turn and the tilt.
 W.foreignPin=nil; W.pitch=math.rad(31); paint(); paint()
 ok(R.Probe().mode=="pin" and R.Probe().tracking=="Polestar's map pin" and R.Probe().tilt=="measured",R.Probe().tracking)
 near(R.CameraState().pitch,math.rad(31),"measured from its marker",1e-3)
 stub.messages={}; SlashCmdList.POLESTAR("trail probe")
 ok(stub.messages[1]:find("trail probe: mode pin (the trail's waypoint on), trail full;",1,true),stub.messages[1])
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

// The screen's scale. Recorded on wowf 1.60.1 at 2560x1440 (/polestar trail record, a marker 1,757 yd off and a
// little below the player): under mouselook the character turns with the view, so the facing gives the turn. Two
// places the marker rested at, the facing 0.0982 rad apart (in steps of 0.0039), have to lie that far apart
// round the view. They do to 0.004 rad with the view's 90 degrees taken from corner to corner; taken from side
// to side they lie 0.009 rad too far apart, the marker having gone a tenth further than the view turned.
test("the screen's scale fits the recorded marker: two places at rest lie as far apart round the view as the facing turned", () => { assert.ok(pure(`
	local w, h = 2560, 1440
	local rest = { { 2.11662, 1159.33, 1146.95 }, { 2.21480, 1303.09, 892.46 } }
	local drop = math.rad(-3.7) -- the marker's place, 113 yd under the camera at 1,757 yd
	local function round(focal, s) -- the marker's bearing to the right of the view
		local dx, dy = s[2] - w / 2, s[3] - h / 2
		return math.asin(dx / math.sqrt(dx * dx + dy * dy + focal * focal) / math.cos(drop))
	end
	local turned = rest[2][1] - rest[1][1]
	local focal = T.Focal(90, h)
	near(focal, 1468.6, "90 degrees from corner to corner at 2560x1440", 0.1)
	near(round(focal, rest[2]) - round(focal, rest[1]), turned, "as far apart as the view turned, within a step of the facing", 0.004)
	ok(math.abs(round(1280, rest[2]) - round(1280, rest[1]) - turned) > 0.008, "which the side-to-side reading misses by twice that")
`) > 0); });

test("the probe gives the screen's scale as the pin's marker shows it, once a right-button drag has set the camera behind the character", () => {
 assert.ok(runtime(pinKit + `
 -- A game whose view is a tenth narrower than the painter takes it to be.
 W.focalScale=1.1; W.zoom=20; W.pitch=math.rad(18)
 pin(400,90,0); enable(); paint(2.1); paint(.3)
 ok(R.Probe().scale==nil,"not before the camera is known to stand behind the character")
 drag(true); paint(); drag(false); paint(); paint(.3)
 local probe=R.Probe()
 near(probe.scaleUsed,T.Focal(90,1080),"what the painter works with",1e-6)
 near(probe.scale,T.Focal(90,1080)*1.1,"what the marker shows",T.Focal(90,1080)*.01)
 stub.messages={}; SlashCmdList.POLESTAR("trail probe")
 ok(stub.messages[1]:find("by the pin's marker)",1,true),stub.messages[1])
 -- A marker near the middle of the screen says nothing of it.
 pin(400,5,0); paint(); paint(.3)
 ok(R.Probe().scale==nil,"too near the middle to tell")
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="18"')>0);
});

// A tilt that is only a guess. With no marker read (the default) the tilt is the one the client saved at the
// login or reload, exact until the view is dragged; after a drag nothing says how the view is tilted. The view
// turns about the character, so the feet show where they are whatever the tilt, and a wrong tilt misplaces the
// ground by more the further it lies from them: believed too steep, the far end lifts into the air. So the
// trail is then drawn short, from nearer the feet, and at the flatter end of the views a player keeps.
const loosePart = `
 for key,value in pairs({Ahead=6.5,Length=20,Gap=1.4,Width=2.6,Fade=.5,Flow=.7}) do Polestar.Set("nav.worldTrail"..key,value) end
 -- How far along the route (it runs east from the player's feet) the drawn sparkles reach, and how far up the
 -- screen the painter puts them over where the game shows the same spots (px; negative: nearer the feet).
 local function reach()
  local _,shown=R.Fades(); local lo,hi,lift=math.huge,0,-math.huge
  local cam,actual=R.CameraState().cam,real()
  for i=1,shown.n do
   local q=shown[i]; local d=q.x-W.px
   lo,hi=math.min(lo,d),math.max(hi,d)
   local _,by=T.Project(cam,q.x-W.px,q.y-W.py,0); local _,ay=T.Project(actual,q.x-W.px,q.y-W.py,0)
   if by and ay then lift=math.max(lift,by-ay) end
  end
  return lo,hi,lift
 end
`;

test("with no marker read: the whole trail at the tilt the client saved until the view is dragged, then a short one from the feet that can only squash", () => {
 assert.ok(runtime(tiltKit + loosePart + `
 W.zoom=39; W.pitch=math.rad(22); W.marker=false
 enable(); frame(2.1); frame(.5)
 local lo,hi,lift=reach()
 ok(R.Probe().mode=="no pin" and R.Probe().trail=="full" and R.CameraState().exact,R.Probe().trail)
 ok(lo>5 and hi>17 and math.abs(lift)<1,"the whole trail, on the ground: "..lo.." to "..hi.." yd, "..lift.." px")
 -- Walking and turning with the keys tilt nothing: the tilt stays exact and the trail whole.
 W.speed=7; for i=1,20 do W.px=W.px+.35; W.yaw=W.yaw+.01; W.facing=W.yaw; frame() end; W.speed=0; frame(.5)
 lo,hi,lift=reach()
 ok(R.Probe().trail=="full" and R.CameraState().exact and hi>17 and math.abs(lift)<1,"still whole: "..hi.." yd, "..lift.." px")
 -- A drag with the right button, the view tilted further down in it: nothing reads that.
 drag(true); for i=1,10 do W.pitch=W.pitch+math.rad(1.8); W.yaw=W.yaw+.02; W.facing=W.yaw; frame() end; drag(false); frame(1)
 near(math.deg(W.pitch),40,"the view now",1e-6)
 lo,hi,lift=reach()
 ok(R.Probe().trail=="short" and not R.CameraState().exact,"the tilt is a guess: "..R.Probe().trail)
 near(R.CameraState().pitch,math.rad(22),"the tilt held is still the saved one",1e-9)
 ok(lo<4 and hi<=.3*39+.5,"from nearer the feet, and no further than 0.3 of the camera's distance: "..lo.." to "..hi.." yd")
 ok(lift<=1,"drawn flatter than the view is, so squashed toward the feet and never lifted: "..lift.." px")
 stub.messages={}; SlashCmdList.POLESTAR("trail probe")
 ok(stub.messages[1]:find("trail probe: mode no pin (the trail's waypoint on), trail short;",1,true),stub.messages[1])
 Polestar.Set("nav.worldTrailWaypoint",false); stub.messages={}; SlashCmdList.POLESTAR("trail probe")
 ok(stub.messages[1]:find("(the trail's waypoint off)",1,true),stub.messages[1])
 -- The other way, the view brought up to five degrees: the far end of the short trail lifts by little.
 drag(true); for i=1,10 do W.pitch=W.pitch-math.rad(3.5); frame() end; drag(false); frame(1)
 lo,hi,lift=reach()
 ok(drawn() and R.Probe().trail=="short" and lift<50,"a view of five degrees: "..lift.." px over the ground at the most")
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="22"')>0);
});

test("with Polestar's own pin: a drag its marker cannot read leaves the short trail, and the whole one is back once the marker reads the tilt", () => {
 assert.ok(runtime(pinKit + loosePart + `
 -- The pin 150 yd along the route, the view turned away from it: pinned to the screen's edge, and too near
 -- for where it is pinned to give the tilt.
 W.engineClamp="wowf"; W.zoom=39; W.pitch=math.rad(22); W.yaw=2.6; W.facing=2.6
 pin(150,0,0); enable(); paint(2.1); paint(.5)
 ok(R.Probe().mode=="pin" and R.Probe().trail=="full" and R.CameraState().exact,R.Probe().trail)
 drag(true); for i=1,10 do W.pitch=W.pitch-math.rad(.8); paint() end; drag(false); paint(1)
 ok(R.Probe().offScreen and R.Probe().trail=="short","a drag nothing read: "..R.Probe().trail)
 near(R.CameraState().pitch,math.rad(22),"the tilt held",2e-3)
 -- Turned with the keys to where the route leads: the pin's marker comes into view and reads the tilt.
 for i=1,26 do W.yaw=W.yaw-.1; W.facing=W.yaw; paint() end
 W.yaw=0; W.facing=0; paint(); paint()
 near(R.CameraState().pitch,W.pitch,"read from the pin's marker: 14 degrees",1e-3)
 ok(R.Probe().trail=="full")
 paint(1)
 local lo,hi,lift=reach()
 ok(lo>5 and hi>17 and math.abs(lift)<1,"the whole trail again, on the ground: "..lo.." to "..hi.." yd, "..lift.." px")
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="22"')>0);
});

test("a drag that takes the pin's marker over the top of the view leaves the whole trail: the tilt held is one the view has at least", () => {
 assert.ok(runtime(pinKit + loosePart + `
 -- The everyday case: a far place ahead, and the view tilted down past it in a drag nothing can follow.
 W.engineClamp="wowf"; W.zoom=21.65; W.pitch=math.rad(20)
 pin(1500,60,0); enable(); paint(2.1); paint(.3)
 drag(true); for i=1,20 do W.pitch=W.pitch+(math.rad(40)-W.pitch)*.4; paint() end; W.pitch=math.rad(40); paint(); drag(false); paint(.5)
 local held=R.CameraState().pitch
 ok(R.Probe().offScreen and R.Probe().trail=="full","pinned over the top: the trail is not cut short ("..R.Probe().trail..")")
 ok(held>math.rad(20) and held<=W.pitch+1e-6,"the tilt it left the view at, no more than the view has: "..math.deg(held))
 local lo,hi,lift=reach()
 ok(hi>17 and lift<=1,"whole, and squashed toward the feet if anything: "..hi.." yd, "..lift.." px")
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

test("a pin whose marker stands far below, a goal in a cave under the hill: pinned to the bottom for a place ahead, it leaves the short trail and not none", () => {
 assert.ok(runtime(pinKit + loosePart + `
 -- 57 yd ahead and 130 yd down: at an ordinary tilt its marker falls under the view, and the game pins it to the
 -- bottom of the screen, where a place ahead is only shown by a view turned up. The tilt held is contradicted.
 UIParent:SetSize(2560,1440)
 W.engineClamp="wowf"; W.zoom=39; W.pitch=math.rad(25.9)
 pin(57,0,-130); enable(); paint(2.1); paint(.5)
 ok(R.Probe().offScreen and R.Probe().mode=="pin","the pin's marker is pinned off the screen")
 ok(drawn() and R.Probe().trail=="short","drawn, as the short trail: "..tostring(R.Why()))
 near(R.CameraState().pitch,math.rad(25.9),"the tilt held is not changed by it",1e-9)
 W.speed=7; for i=1,20 do W.px=W.px+.35; paint() end; W.speed=0; paint(.5)
 ok(drawn() and R.Probe().trail=="short","and walking on over it")
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="25.9"')>0);
});

// The pinning rule was recorded on a marker whose place lay a mile off, which the camera sees where the character
// does. A place near by it does not: the camera stands the zoom's length behind the character, so a place a few
// yards behind the character is ahead of the camera, and one sixty yards off to the side is a good ten degrees
// further round for the one than for the other. Reported from play: with a tracked quest's place a few yards off
// the rule read a tilt of 67 degrees in an ordinary view, and the trail stood in the air as a column.
test("a marker pinned for a place near by gives no tilt, and one far off still does: how the game pins a near place is not known", () => {
 assert.ok(runtime(pinKit + `
 -- A client that pins by the place's bearing from the camera, 15 yd behind the character.
 W.engineClamp="wowf"; W.pinFromCamera=true
 pin(60,0,0); W.pitch=math.rad(20)
 enable(); paint(2.1)
 near(R.CameraState().pitch,math.rad(20),"measured in view",2e-3)
 -- The character turns away by the keys until the place is abeam: the marker goes to the screen's side.
 for i=1,40 do W.facing=W.facing+.04; W.yaw=W.facing; paint() end
 paint(.5)
 ok(R.Probe().offScreen and drawn(),"pinned, and the trail still drawn: "..tostring(R.Why()))
 -- A turn of the mouse the tilt cannot be followed through, in which nothing is tilted.
 drag(true); for i=1,10 do paint() end; drag(false); paint(.4)
 near(R.CameraState().pitch,math.rad(20),"the tilt stands: a place 60 yd off says nothing of it",2e-3)
 ok(drawn() and R.Probe().trail=="short","and the trail is the short one, the drag unread")
 ok(R.Probe().pinNear and R.Probe().pinRule~="given up","too near to go by, and the rule is not given up over it")
 stub.messages={}; SlashCmdList.POLESTAR("trail probe")
 ok(stub.messages[1]:find("the pinned marker reads",1,true) and stub.messages[1]:find("(too near to go by)",1,true),"the probe gives both readings: "..stub.messages[1])
 -- What the rule would have read there: thirteen degrees out by the character's bearing, true by the camera's.
 ok(math.abs(R.Probe().pinReads-W.pitch)>math.rad(10),"by the character's bearing: "..math.deg(R.Probe().pinReads))
 near(R.Probe().pinReadsBack,W.pitch,"by the camera's bearing",math.rad(1))
 -- A place 250 yd off is read as before, and in this client comes out within four degrees.
 pin(250,0,0); W.facing=0; W.yaw=0; paint(); paint(.3)
 for i=1,40 do W.facing=W.facing+.04; W.yaw=W.facing; paint() end
 paint(.5)
 drag(true)
 for i=1,20 do W.pitch=W.pitch+(.6-W.pitch)*.3; paint() end
 paint(.4); drag(false); paint()
 ok(R.Probe().tilt=="read from the pinned marker" and not R.Probe().pinNear,R.Probe().tilt)
 near(R.CameraState().pitch,W.pitch,"followed down by the pinned marker",math.rad(4))
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

test("a view turned up is kept while nothing has dragged the camera since: the marker lost to a turn with the keys", () => {
 assert.ok(runtime(pinKit + `
 W.engineClamp="wowf"; W.zoom=39; W.pitch=math.rad(25)
 pin(120,10,0); enable(); paint(2.1); paint(.3)
 drag(true)
 for i=1,20 do W.pitch=W.pitch+(math.rad(-22)-W.pitch)*.3; paint() end
 drag(false); paint(.3)
 -- The character turned with the keys: the camera has not been touched, and looks up as it did.
 for i=1,25 do W.yaw=W.yaw+.07; W.facing=W.yaw; paint() end
 paint(1)
 ok(R.Probe().offScreen,"the marker is out of view")
 near(R.CameraState().pitch,W.pitch,"still turned up, a second on",math.rad(1))
 -- A drag after that may have brought the view anywhere: once it is over, the ordinary view is the better guess.
 drag(true); for i=1,20 do W.pitch=W.pitch+(math.rad(25)-W.pitch)*.3; paint() end
 drag(false); paint()
 near(R.CameraState().pitch,math.rad(25),"the last view at rest",1e-3)
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="25"')>0);
});

// Polestar's own map pin at a fixed place in the world.
const placeKit = tiltKit + `
 -- The pin's marker at a fixed place in the world, \`z\` above the player; the game's distance through the air.
 local function at(x,y,z) W.marker=true; W.pin={uiMapID=1,position={x=(200-y)/400,y=(x+200)/400}}; W.markerAt={x,y}; W.markerZ=z or 0 end
 local function step(dt)
  if W.markerAt then W.distance=math.sqrt((W.markerAt[1]-W.px)^2+(W.markerAt[2]-W.py)^2+(W.markerZ or 0)^2) end
  frame(dt)
 end
 local function blindTilt(to) drag(true); for i=1,20 do W.pitch=W.pitch+(to-W.pitch)*.4; step() end; W.pitch=to; step(); drag(false); step(.3) end
`;

{
 test("a marker the game pins over the top of the view: the tilt is at least what puts its place there", () => {
  assert.ok(runtime(placeKit + `
 -- The everyday view in the making: the camera well out, the place 250 yd off and behind for now. The view is
 -- tilted from 17 degrees to 42 in a drag that cannot be followed; a place that near, pinned to the bottom
 -- edge, says nothing of it.
 W.engineClamp="wowf"; W.zoom=39; W.pitch=math.rad(17); W.yaw=2.5; W.facing=2.5
 at(260,0,0)
 enable(); step(2.1); step(.3)
 W.speed=7; for i=1,50 do W.px=W.px+.35; step() end; W.speed=0; step(.3)
 blindTilt(math.rad(42))
 near(R.CameraState().pitch,math.rad(17),"nothing measured the tilt: the saved one is held",1e-9)
 -- Turned to face the place with the keys: at 42 degrees it stands over the top of the view, and the game
 -- pins its marker to the top edge. At 17 degrees it would be in view.
 for i=1,30 do W.yaw=W.yaw*.7; W.facing=W.yaw; step() end
 W.yaw=0; W.facing=0; step(); step(.3)
 ok(R.Probe().offScreen,"the marker is pinned over the top of the view")
 local got=R.CameraState().pitch
 ok(got>math.rad(27) and got<=W.pitch,"no longer the 17 degrees of before, nor more than the view has: "..math.deg(got))
 ok(drawn() and R.Probe().anchor:find("over the top",1,true),"and the probe says what it goes by: "..tostring(R.Probe().anchor))
 ok(not R.CameraState().exact,"a bound, not a measurement")
 -- A view known to be steeper still is not taken back to that least tilt.
 at(-600,650,0); step(); step(.3)
 W.speed=7; for i=1,50 do W.px=W.px+.35; step() end; W.speed=0; step(.3)
 blindTilt(math.rad(60)); local steep=R.CameraState().pitch
 near(steep,W.pitch,"read from the side edge, the place 900 yd off",math.rad(1.5))
 at(260,0,0); step(); step(.3)
 near(R.CameraState().pitch,steep,"over the top again: the steeper tilt stands",1e-6)
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="17"')>0);
 });
}

test("a place well above or below, met with the tilt not known: the walking maps say which, and where they do not the tilt is not called exact", () => {
 assert.ok(runtime(placeKit + groundPart + `
 for key,value in pairs({Ahead=3,Length=30,Gap=1.7,Width=1,Fade=1,Flow=.5}) do Polestar.Set("nav.worldTrail"..key,value) end
 -- A quest's place 150 yd ahead in a hollow 45 yd deep. Seen where its marker shows, the tilt is either the
 -- 30 degrees the view has (the place below) or about level (the place as far above).
 local function ground(x) return x>110 and -45 or 0 end
 W.engineClamp="wowf"; W.zoom=20; W.pitch=math.rad(10); W.marker=false
 enable(); frame(2.1); frame(.3)
 -- The view is tilted from 10 degrees to 30 in a drag that cannot be followed. The ordinary view, the 10
 -- degrees of before, is nearer the wrong reading than the right one.
 blindTilt(math.rad(30))
 near(R.CameraState().pitch,math.rad(10),"held",1e-9)
 at(160,0,-45); step(); step(.3)
 ok(R.CameraState().pitch<math.rad(8),"no maps: the reading nearer the ordinary view, the wrong one here: "..math.deg(R.CameraState().pitch))
 ok(not R.CameraState().exact,"and it is not called exact: the tilt is one of two")
 -- Then the walking maps come to hold the place: the ground there lies 45 yd below, so the place does, and
 -- the guess is put right.
 maps(ground); step(2.1); step(.6); step(.6)
 near(R.CameraState().pitch,math.rad(30),"measured, the place below as the maps have it",math.rad(1))
 near(R.CameraState().lift,-45,"its height",2)
 ok(R.CameraState().exact,"and exact")
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="10"')>0);
});

{
 test("walking past a place near by, its marker under the view: nothing is measured from it", () => {
  assert.ok(runtime(placeKit + `
 W.engineClamp="wowf"; W.zoom=39; W.pitch=math.rad(25)
 at(39,3,0)
 enable(); step(2.1); step(.3)
 -- The camera is not touched. The place passes beside the character and falls behind, between it and the camera.
 W.speed=7; local worst=0
 for i=1,170 do W.px=W.px+.35; step(); worst=math.max(worst,math.abs(R.CameraState().pitch-W.pitch)) end
 ok(worst<math.rad(1),"the tilt stays what it is: at worst "..math.deg(worst).." degrees out")
 ok(drawn() and groundError()<12,"and the trail on the ground: "..groundError())
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="25"')>0);
 });
}

test("a tilt far from the ordinary view that a marker showed in the middle of a drag is not kept once nothing shows it and the drag is over", () => {
 assert.ok(runtime(placeKit + `
 W.engineClamp="wowf"; W.zoom=20; W.pitch=math.rad(25)
 at(-600,650,0); enable(); step(2.1); step(.3)
 -- A look steeply down, read from the pinned marker all the way; then the quest is no longer tracked, and the
 -- view comes back up in the same drag.
 drag(true); for i=1,20 do W.pitch=W.pitch+(math.rad(75)-W.pitch)*.4; step() end
 near(R.CameraState().pitch,W.pitch,"read from the pinned marker",math.rad(2))
 W.marker=false
 for i=1,20 do W.pitch=W.pitch+(math.rad(25)-W.pitch)*.4; frame() end
 ok(R.CameraState().pitch>math.rad(70),"held while the drag goes on")
 drag(false); frame()
 near(R.CameraState().pitch,math.rad(25),"the drag over: the ordinary view again",1e-3)
 ok(drawn() and R.Probe().trail=="short","drawn short, and no column in the air")
 -- A steep view the marker bears out is kept: read steep in a drag, and at its end the marker stands pinned over
 -- the top of the view, which a place ahead only does in a view looking well down.
 W.marker=true; step(); step(.3)
 drag(true); for i=1,20 do W.pitch=W.pitch+(math.rad(75)-W.pitch)*.4; step() end
 local steep=R.CameraState().pitch
 near(steep,W.pitch,"read from the pinned marker again",math.rad(2))
 at(800,40,0); step(); step(); drag(false); step(.3)
 near(R.CameraState().pitch,steep,"kept: the marker stands over the top of the view",1e-6)
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="25"')>0);
});

// A walk without a baked leg has no heights of its own (a walk the arrow searches; a guide pack that ships no
// legs). Level from the feet, the trail runs into every slope: reported from play at the foot of a hillside. Where
// the walking maps may be read, the next stretch of the route is sampled from them into a strip (Terrain.Strip).
const groundPart = `
 for key,value in pairs({Ahead=6.5,Length=20,Gap=1.4,Width=0,Fade=.5,Flow=0}) do Polestar.Set("nav.worldTrail"..key,value) end
 -- The maps keep one height a cell, 4.17 yd across: the ground's at the cell's middle.
 local CELL=1600/3/128
 local function middle(x) return (math.floor((x+29.5*1600/3)/CELL)+.5)*CELL-29.5*1600/3 end
 -- The ground: level, then from 2 yd ahead of the player a slope climbing one yard in two.
 local function slope(x) return x>12 and (x-12)*.5 or 0 end
 local function maps(ground,more) W.engine(function(c,x,y,out)
  if more then local n=more(x,y,out); if n~=false then return n end end
  out[1],out[-1]=ground(middle(x)),0; return 1
 end) end
 -- The sparkles drawn with a height of their own: how many, the farthest ahead, and how far the worst lies off the ground.
 local function onGround(ground)
  local _,shown=R.Fades(); local n,far,worst=0,0,0
  for i=1,shown.n do
   local q=shown[i]
   if q.z then n,far,worst=n+1,math.max(far,q.x-W.px),math.max(worst,math.abs(q.z-ground(q.x))) end
  end
  return n,far,worst
 end
 -- The maps as they ship: the ground's height at a cell's middle, rounded to 2 yd.
 local function coarse(ground) return function(x) return 2*math.floor(ground(x)/2+.5) end end
 -- The floor as the arrow follows it (Nav/Walk.lua): the height of the cell under the player on those
 -- maps, read at most every quarter second and only after a yard's walk.
 local function cellFloor(onMap)
  local z,at,when
  Polestar.Nav.walk={Floor=function(c,x,y)
   local now=GetTime()
   if not z or (now-when>=.25 and math.abs(x-at)>=1) then z,at,when=onMap(middle(x)),x,now end
   return z
  end}
 end
 -- What the player sees of it: how far (px, + is above) the sparkles just drawn lie from where the true
 -- ground shows through the true camera, which stands on the true ground under the player; on average
 -- and at worst. And each sparkle's place and height by its number.
 local function seen(ground)
  local g=R.GroundFrame(); local _,shown=R.Fades(); local actual=real()
  local feet=ground(W.px); local worst,sum,n,ids=0,0,0,{}
  for i=1,shown.n do
   local q=shown[i]
   local _,_,_,_,sy=g.stars[i]:GetPoint()
   local _,ey=T.Project(actual,q.x-W.px,q.y-W.py,ground(q.x)-feet)
   if ey then worst,sum,n=math.max(worst,math.abs(sy-ey)),sum+(sy-ey),n+1 end
   ids[q.id]={q.x,q.z}
  end
  return n>0 and sum/n or 0,worst,ids,n
 end
`;
const groundKit = tiltKit + groundPart;

test("after a spell with nothing to paint, in which the view was tilted unseen, the saved tilt is no longer taken for exact", () => {
 assert.ok(runtime(pinKit + groundPart + `
 local function ground(x) return x>60 and 4 or 0 end
 maps(ground); W.marker=false; W.pitch=math.rad(33)
 enable(); frame(2.1); frame(.5)
 ok(R.CameraState().exact,"the tilt the client saved, nothing having moved it")
 -- The trail is turned off for a while: nothing runs, and nothing is dragged. The tilt is what it was.
 Polestar.Set("nav.worldTrail",false); frame(10); enable(); frame(.5)
 ok(drawn() and R.CameraState().exact and R.Probe().trail=="full","a spell with the view untouched costs nothing")
 -- Off again, and this time the view is tilted meanwhile: the client says a drag began.
 Polestar.Set("nav.worldTrail",false); frame(.2)
 stub.fire("PLAYER_STARTED_TURNING"); W.pitch=math.rad(20); frame(5)
 enable(); frame(.5)
 ok(drawn() and not R.CameraState().exact,"drawn again, the tilt no longer called exact")
 ok(R.Probe().trail=="short","and the trail short until something reads the tilt")
 pin(91,5,0); paint(); paint(.3)
 near(R.CameraState().pitch,W.pitch,"the pin's marker measures it afresh",math.rad(1))
 -- A moment with nothing to paint (a route being worked out) costs nothing.
 Polestar.Set("nav.worldTrail",false); frame(.4); enable(); frame(.3)
 drag(true); W.pitch=.3; paint(); drag(false); paint()
 near(R.CameraState().pitch,.3,"the marker measures on",math.rad(1))
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="33"')>0);
});

test("the wait for the first route after a reload does not cost the saved tilt its standing, unless the view is dragged once the world shows", () => {
 for (const [shown, dragged, exact] of [[false, false, true], [true, false, true], [true, true, false]]) assert.ok(runtime(tiltKit + `
 -- The reload's loading screen is still up for three seconds after the login; the route comes in during
 -- it, or three seconds after the world shows, with or without a drag of the view in between.
 W.marker=false; W.pitch=math.rad(20)
 frame(3)
 if ${shown} then stub.fire("LOADING_SCREEN_DISABLED"); frame(1); if ${dragged} then stub.fire("PLAYER_STARTED_LOOKING") end; frame(2) end
 enable()
 if not ${shown} then stub.fire("LOADING_SCREEN_DISABLED") end
 frame(2.6)
 ok(drawn(),"drawn: "..tostring(R.Why()))
 ok(R.CameraState().exact==${exact},"the saved tilt exact: "..tostring(R.CameraState().exact))
 near(R.CameraState().pitch,math.rad(20),"and drawn with either way",1e-9)
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

test("the hillside as it was reported: a far quest tracked below, the view all but level, no baked leg; the trail climbs the slope", () => {
 assert.ok(runtime(pinKit + groundPart + `
 maps(slope); tracked(1594,339,-140); W.pitch=.02; W.zoom=15.7
 enable(); paint(2.1); paint(.5)
 near(R.CameraState().pitch,.02,"the tilt stands",1e-3)
 ok(R.Probe().heightSource=="walking-map samples" and R.Probe().tracking:find("not read",1,true),tostring(R.Probe().tracking))
 local n,far,worst=onGround(slope)
 ok(n>=8 and worst<1.1,"on the slope: "..n.." sparkles, "..worst.." yd off at worst")
 ok(rows()>120,"and up the screen with it, not in a strip at the feet: "..rows().." rows")
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="1.1459"')>0);
});

test("a walk without a baked leg up a hillside: the trail takes the ground's height from the walking maps and climbs it", () => {
 assert.ok(runtime(groundKit + `
 maps(slope); enable(); frame(2.1); frame(.5)
 ok(R.Probe().heightSource=="walking-map samples",tostring(R.Probe().heightSource))
 ok(R.Probe().floorSource=="walking-map estimate","the feet's own height from the same strip: "..tostring(R.Probe().floorSource))
 local n,far,worst=onGround(slope)
 ok(n>=9 and far>18,"the whole trail has its heights: "..n.." sparkles to "..far.." yd")
 ok(worst<1.1,"on the slope, to within a cell's rounding: "..worst)
 -- A slope is not drawn as steps: no sparkle stands more than a yard off the line through its neighbours'.
 local _,shown=R.Fades(); local list={}
 for i=1,shown.n do if shown[i].z then list[#list+1]=shown[i] end end
 table.sort(list,function(a,b) return a.x<b.x end)
 for i=2,#list-1 do
  local a,b,c=list[i-1],list[i],list[i+1]
  local line=a.z+(c.z-a.z)*(b.x-a.x)/(c.x-a.x)
  ok(math.abs(b.z-line)<.8,"evened out at "..b.x..": "..(b.z-line))
 end
 -- Walking up it, the strip is sampled again as it runs short, and the trail neither fades nor leaves the ground.
 local reads=0; local begin=NS.Terrain.Begin
 W.speed=7
 for i=1,60 do
  W.px=W.px+1; frame(.15)
  local fades=R.Fades(); ok(#fades==0,"no fade for a strip sampled again, "..i.." yd on")
  local n2,_,worst2=onGround(slope); ok(n2>=7 and worst2<1.1,"on the ground "..i.." yd on: "..n2..", "..worst2)
 end
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

test("past the last cell that is read the sampled strip carries on at the slope it had; with none read the trail is the level one", () => {
 assert.ok(runtime(groundKit + `
 -- Well up the slope, nothing is read from 14 yd ahead of the player on (the next map tile, until the player is in it).
 W.px=40
 maps(slope,function(x) if middle(x)>54 then return nil end return false end)
 enable(); frame(2.1); frame(.5)
 local n,far,worst=onGround(slope)
 ok(R.Probe().heightSource=="walking-map samples" and n>=9,"drawn: "..n)
 ok(far>18 and worst<1.1,"to the trail's end and on the slope, past what is read: "..far.." yd ahead, "..worst.." yd off")
 ok(R.Probe().ahead<16,"and the probe counts only what is read: "..tostring(R.Probe().ahead))
 maps(slope,function() return nil end); frame(.6)
 ok(R.Probe().heightSource=="camera-estimate" and drawn(),"nothing read: level, as it was")
 local _,shown=R.Fades()
 for i=1,shown.n do ok(shown[i].z==nil and math.abs(shown[i].rel)<1e-9,"level") end
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

test("under a bridge the strip keeps to the ground it is on; a floor a storey up ends it", () => {
 assert.ok(runtime(groundKit + `
 local function flat() return 0 end
 -- A deck 12 yd over the road, 8 to 14 yd ahead; from 24 yd ahead the only surface is a floor 12 yd up.
 -- (By the cell's middle, as the maps have it: a cell is one or the other wherever in it it is read.)
 maps(flat,function(x,y,out)
  local mid=middle(x)
  if mid>=18 and mid<=24 then out[1],out[-1],out[2],out[-2]=0,0,12,0; return 2 end
  if mid>34 then out[1],out[-1]=12,0; return 1 end
  return false
 end)
 enable(); frame(2.1); frame(.5)
 local n,far,worst=onGround(flat)
 ok(R.Probe().heightSource=="walking-map samples" and n>=9,"drawn: "..n)
 ok(worst<.01,"on the road under the deck, not on it: "..worst)
 ok(far>18,"through the stretch under the deck: "..far)
 -- Ten yards on, that floor begins 14 yd ahead: the strip, and the trail, end before it.
 W.px=W.px+10; frame(.6); frame(.3)
 n,far,worst=onGround(flat)
 ok(n>=3 and worst<.01,"still on the road: "..n..", "..worst)
 ok(far<14.5,"and it ends where the only way on is a storey up: "..far.." yd ahead")
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

// The sampled strip as it was first played, up a hillside: "choppy, like it's constantly recalculating", the
// sparkles laid again a little higher with every few yards climbed, and no steady line of them. Three things made
// it so. The feet's height was the floor the arrow follows, which is the height of the map cell under the player:
// the maps round the ground's to 2 yd, so up a slope it rises in steps, and the whole trail hopped with each and
// hung above the ground between them. Sparkles were numbered from where the strip began, so they were all laid
// afresh each time it was sampled again, every thirty yards. And a rounded step of more than 3 yd between two
// cells ended the strip, so on steep ground, or riding fast, the trail fell back to the level one and came again.
test("running and riding up a slope the maps give in steps, the trail stays on the ground and does not hop", () => {
 for (const [speed, yards] of [[7, 70], [14, 140]]) {
  assert.ok(runtime(groundKit + `
  local onMap=coarse(slope)
  maps(onMap); cellFloor(onMap)
  W.pitch=math.rad(20); enable(); frame(2.1); frame(.5)
  W.speed=${speed}
  local frames=${yards}/(${speed}*.05)
  local sum,worstOf,hops,last=0,0,0,nil
  for i=1,frames do
   W.px=W.px+${speed}*.05; frame(.05)
   ok(R.Probe().heightSource=="walking-map samples","heights all the way: "..tostring(R.Probe().heightSource)..", "..i.." frames on")
   local off,worst=seen(slope)
   sum,worstOf=sum+math.abs(off),math.max(worstOf,worst)
   if last and math.abs(off-last)>9.5 then hops=hops+1 end
   last=off
  end
  ok(R.Probe().floorSource=="walking-map estimate","the feet stand on the strip: "..tostring(R.Probe().floorSource))
  ok(sum/frames<20,"on the ground: "..(sum/frames).." px off on average")
  ok(worstOf<70,"no sparkle far off it: "..worstOf.." px at worst")
  ok(hops<=1,"and the trail does not hop: "..hops.." times by more than 9.5 px between two frames")
  near(W.writes,0)
  `, 'stub.cvars.cameraSavedPitch="20"')>0);
 }
});

test("a strip sampled again further on leaves every sparkle its number, its place and its height", () => {
 assert.ok(runtime(groundKit + `
 local onMap=coarse(slope)
 maps(onMap); cellFloor(onMap)
 enable(); frame(2.1); frame(.5)
 W.speed=7
 local last
 local kept,most=0,0
 for i=1,200 do
  W.px=W.px+.35; frame(.05)
  local _,_,ids=seen(slope)
  if last then
   local gone=0
   for id,was in pairs(last) do
    local now=ids[id]
    if now then
     kept=kept+1
     ok(math.abs(now[1]-was[1])<.01 and math.abs(now[2]-was[2])<.05,"sparkle "..id.." stays where it lay: "..was[1]..", "..was[2].." to "..now[1]..", "..now[2])
    else gone=gone+1 end
   end
   most=math.max(most,gone)
  end
  last=ids
 end
 ok(kept>1000,"the same sparkles from frame to frame over 70 yd: "..kept)
 ok(most<=2,"never laid afresh: at most "..most.." gone between two frames")
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

test("ground as steep as is walked keeps its heights", () => {
 assert.ok(runtime(groundKit + `
 -- 42 degrees: 3.8 yd a cell, which the maps' rounding makes 4 and now and then 2 or 6.
 local function steep(x) return x>12 and (x-12)/1.1 or 0 end
 local onMap=coarse(steep)
 maps(onMap); cellFloor(onMap)
 W.pitch=math.rad(20); enable(); frame(2.1); frame(.5)
 W.speed=7
 for i=1,100 do
  W.px=W.px+.35; frame(.05)
  ok(R.Probe().heightSource=="walking-map samples","heights on the steep: "..tostring(R.Probe().heightSource)..", "..i.." frames on")
 end
 local n,far,worst=onGround(steep)
 ok(n>=3 and worst<1.5,"on the slope, to within the maps' rounding: "..n.." sparkles, "..worst.." yd off at worst")
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

// The maps are read a tile at a time (533 yd), and the next tile only once the player is in it. On the real cells
// of a climb the heights dropped out for two seconds at every tile's edge: the trail fell level and jumped back.
test("at the edge of the map tile the trail stays whole and on the slope, and does not jump when the next tile is read", () => {
 assert.ok(runtime(groundKit + `
 local onMap=coarse(slope)
 local open=false
 maps(onMap,function(x) if middle(x)>50 and not open then return nil end return false end)
 cellFloor(onMap)
 W.pitch=math.rad(20); enable(); frame(2.1); frame(.5)
 W.speed=7
 local hops,last=0,nil
 local function step(i,what)
  W.px=W.px+.35; frame(.05)
  ok(R.Probe().heightSource=="walking-map samples",what..": heights, "..tostring(R.Probe().heightSource)..", "..i.." frames on")
  local off,worst,_,n=seen(slope)
  ok(n>=8 and worst<60,what..": the trail whole and on the slope, "..n.." sparkles, "..worst.." px at worst, "..i.." frames on")
  if last and math.abs(off-last)>8 then hops=hops+1 end
  last=off
 end
 -- Up to the edge, 40 yd on, with less and less of the trail's reach read,
 for i=1,110 do step(i,"to the edge") end
 ok(R.Probe().ahead<8,"hardly any of it read by now: "..tostring(R.Probe().ahead))
 -- and on into the next tile, which is read now.
 open=true
 for i=1,40 do step(i,"in the next tile") end
 ok(R.Probe().ahead>25,"read again: "..tostring(R.Probe().ahead))
 ok(hops==0,"no hop on the way: "..hops)
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

test("where the ground past the edge is not as the strip was carried on, the trail glides onto it once it is read", () => {
 assert.ok(runtime(groundKit + `
 -- The slope eases off at the tile's edge, 40 yd on.
 local function eases(x) return x>50 and 19+(x-50)*.2 or slope(x) end
 local onMap=coarse(eases)
 local open=false
 maps(onMap,function(x) if middle(x)>50 and not open then return nil end return false end)
 cellFloor(onMap)
 W.pitch=math.rad(20); enable(); frame(2.1); frame(.5)
 W.speed=7
 for i=1,110 do W.px=W.px+.35; frame(.05) end
 local before=seen(eases)
 ok(before>25,"carried on up the slope it had, the trail hangs over the easier ground: "..before.." px")
 open=true
 local most,last=0,before
 for i=1,30 do
  W.px=W.px+.35; frame(.05)
  local off=seen(eases)
  most,last=math.max(most,math.abs(off-last)),off
 end
 ok(math.abs(last)<18,"on the ground once it is read: "..last.." px")
 ok(most<before*.4,"by a glide, not a jump: "..most.." px at most between two frames, of "..before)
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

test("the strip begins on the floor the player stands on: a bridge's deck, not the road under it", () => {
 assert.ok(runtime(groundKit + `
 -- A deck 10 yd over the road all the way: every cell has both.
 local function flat() return 0 end
 local function both(x,y,out) out[1],out[-1],out[2],out[-2]=0,0,10,0; return 2 end
 Polestar.Nav.walk={Floor=function() return W.floor end}
 W.floor=10; maps(flat,both)
 enable(); frame(2.1); frame(.5)
 local n,far,worst=onGround(function() return 10 end)
 ok(R.Probe().heightSource=="walking-map samples" and n>=9 and worst<.01,"on the deck: "..n.." sparkles, "..worst.." yd off, "..tostring(R.Probe().heightSource))
 -- On the road under it: the road.
 W.floor=0; maps(flat,both); frame(.3); frame(.7)
 n,far,worst=onGround(flat)
 ok(R.Probe().heightSource=="walking-map samples" and n>=9 and worst<.01,"on the road: "..n..", "..worst)
 -- With the floor not known no surface is taken on a guess: the level trail, as it was.
 W.floor=nil; maps(flat,both); frame(.3); frame(.7)
 ok(R.Probe().heightSource=="camera-estimate" and drawn(),"not known: level, "..tostring(R.Probe().heightSource))
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

// A goal the walking router finds no way to (a tower whose ramp the maps cut, a ledge) leaves the arrow pointing
// straight at it, and the route is that straight line. Reported from play at a tower with the quest giver upstairs:
// the trail ran at the wall and up it, and from upstairs through the wall. Such a line is drawn only as far as the
// router's own straight-walk check says it can be walked (Terrain.Clear), and level: it is no stairs to the goal.
const noWayPart = `
 local function flat() return 0 end
 -- The route as the router gives it: straight from the player to the goal 60 yd ahead, no way found (or found).
 local function line(unrouted) W.route={legs={{kind="walk",current=true,straight=true,unrouted=unrouted,pts={{0,W.px,0},{0,W.px+60,0}}}}}; Polestar.Fire("NAV_ROUTE_GEOMETRY") end
 W.floor=0
 Polestar.Nav.walk={Floor=function() return W.floor end}
 -- A wall across the line at world x = \`at\`: no straight walk to a point past it.
 local asked=0
 local function wall(at) W.sight=function(map,x1,y1,z1,x2,y2) asked=asked+1; return x2<=at end end
 -- The sparkles drawn: how many, and how far ahead of the player the farthest lies.
 local function reach()
  local _,shown=R.Fades(); local far=0
  for i=1,shown.n do far=math.max(far,shown[i].x-W.px) end
  return shown.n,far
 end
`;

test("a walk no way was found for is drawn up to the wall its line runs into, and not at all from close to it", () => {
 assert.ok(runtime(groundKit + noWayPart + `
 maps(flat); wall(24); line(true)
 enable(); frame(2.1); frame(.5)
 local n,far=reach()
 ok(R.Probe().noWay and n>=4,"drawn, and known for a line no way was found for: "..n)
 ok(far<=14.01 and far>11,"up to the wall 14 yd ahead and no further: "..far)
 near(R.Probe().clear,14,"the yards that can be walked",.01)
 -- The line is not tried again every frame,
 local before=asked; frame(.05); frame(.05)
 ok(asked==before,"asked once a quarter second: "..(asked-before))
 -- and its end is a place: walking up to it, the trail stops at the wall still.
 W.speed=7
 for i=1,5 do
  W.px=W.px+1; frame(.15); frame(.15)
  local n2,far2=reach()
  ok(n2>=1 and W.px+far2<=24.01,i.." yd on, it ends at the wall: "..(W.px+far2))
 end
 -- From closer to the wall than the trail begins, there is nothing to draw: the arrow has it from here.
 W.px=20; frame(.3); frame(.3)
 ok(R.GroundFrame().used==0 and tostring(R.Why()):find("no way found",1,true),"nothing drawn at the wall: "..tostring(R.Why()))
 stub.messages={}; SlashCmdList.POLESTAR("trail probe")
 ok(stub.messages[1]:find("no way found to the goal, its line walkable for 4.00 yd",1,true),"the probe says so: "..stub.messages[1])
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

test("a line nothing is said against, one the router cannot check, and a route that was found are drawn whole", () => {
 assert.ok(runtime(groundKit + noWayPart + `
 maps(flat); line(true)
 -- Open ground all the way: the line can be walked.
 W.sight=function() asked=asked+1; return true end
 enable(); frame(2.1); frame(.5)
 local n,far=reach()
 ok(asked>0 and n>=9 and far>18,"clear ground: the whole trail, "..n.." sparkles to "..far)
 ok(R.Probe().noWay and R.Probe().clear==nil,"nothing said against it")
 -- A map tile not decoded: the router cannot tell, and nothing is cut on a guess.
 W.sight=function() return nil end; line(true); frame(.3); frame(.7)
 n,far=reach(); ok(n>=9 and far>18,"not told: whole, "..far)
 -- A route the router found is never put to the check, whatever lies beside it.
 asked=0; wall(15); line(nil); frame(.3); frame(.7)
 n,far=reach(); ok(asked==0 and n>=9 and far>18 and not R.Probe().noWay,"a found route: whole and not asked about, "..asked)
 stub.messages={}; SlashCmdList.POLESTAR("trail probe")
 ok(not stub.messages[1]:find("no way found",1,true),"and the probe has nothing to say of it")
 -- No walking maps here (a dungeon): the straight line as it always was.
 W.engine(nil); line(true); frame(.3); frame(.7)
 ok(drawn() and R.Probe().heightSource=="camera-estimate","no maps: drawn level as before")
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

test("with the floor under the player not known, a line no way was found for is not drawn on a guess", () => {
 assert.ok(runtime(groundKit + noWayPart + `
 maps(flat); W.sight=function() return true end; line(true); W.floor=nil
 enable(); frame(2.1); frame(.5)
 ok(R.GroundFrame().used==0 and tostring(R.Why()):find("no way found",1,true),"not drawn: "..tostring(R.Why()))
 -- The floor found (the player walks on to clearer ground): the line is tried, and drawn.
 W.floor=0; frame(.3); frame(.7)
 ok(drawn(),"drawn once the floor is known")
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="20"')>0);
});

test("a goal upstairs no way was found to: the line at it stays on the ground and does not climb to the goal", () => {
 assert.ok(runtime(pinKit + `
 for key,value in pairs({Ahead=6.5,Length=20,Gap=1.4,Width=2.6,Fade=.5,Flow=.7}) do Polestar.Set("nav.worldTrail"..key,value) end
 -- The goal 27 yd ahead and 11 yd up, its own marker tracked; no walking maps to take the ground's height from.
 W.route={legs={{kind="walk",current=true,straight=true,unrouted=true,pts={{0,0,0},{0,W.px+27,0}}}}}
 pin(27,0,11); W.pitch=.3; W.zoom=15.7
 enable(); paint(2.1)
 near(R.CameraState().lift,11,"the goal is 11 yd up",.5)
 local _,shown=R.Fades()
 ok(shown.n>10,"drawn: "..shown.n)
 for i=1,shown.n do ok(math.abs(shown[i].rel)<.05,"level with the feet: "..shown[i].rel) end
 near(W.writes,0)
 `, 'stub.cvars.cameraSavedPitch="17.19"')>0);
});

test('with no marker in view the tilt follows the mouse, learnt from how the character turns with it', () => {
 assert.ok(runtime(mouseKit + `
 W.cursor={0,0}; enable(); frame(2.1)
 ok(R.Probe().tilt=="assumed" and R.Probe().mouseTilt==nil and R.Probe().cursor)
 drag(true)
 mouse(20,0,20) -- steering: 400 units sideways
 ok(R.Probe().mouseFrom=="turning","learnt from the turn")
 near(R.Probe().mouseTilt,-K/2,"half the turn's rate, falling as the mouse goes up",1e-6)
 near(R.CameraState().pitch,.42,"steering alone leaves the pitch",1e-9)
 mouse(0,-30,10) -- the mouse pulled down: looking further down
 near(R.CameraState().pitch,.72,"the pitch follows the mouse",1e-6)
 -- The drag began before the mouse's rate was learnt, so what the tilt was to begin with is a guess still.
 ok(drawn() and R.Probe().tilt=="followed from an assumed tilt" and R.Probe().trail=="short",R.Probe().trail)
 mouse(0,-40,30) -- straight down
 near(R.CameraState().pitch,1.53,"as far down as the view goes",1e-9)
 ok(drawn() and R.Probe().tilt=="followed" and groundError()<1,"seen from above the trail lies on the ground: "..groundError())
 mouse(0,40,80) -- up into the sky
 near(R.CameraState().pitch,-1.53,"as far up as it goes",1e-9)
 ok(not drawn() and R.Why()=="nothing of the route in view","looking up at the sky draws nothing: "..tostring(R.Why()))
 mouse(0,-30,61) -- and back to an ordinary view
 near(R.CameraState().pitch,.3,"back down",1e-6)
 ok(drawn() and groundError()<1,"ground error "..groundError())
 drag(false); frame(.5)
 near(R.CameraState().pitch,.3,"holds once the button is let go",1e-6)
 -- An inverted mouse tilts the other way.
 stub.cvars.mouseInvertPitch="1"
 drag(true); W.cursor={0,50}; W.pitch=.35; frame(); W.cursor={0,0}; drag(false)
 near(R.CameraState().pitch,.35,"inverted: the mouse pushed up looks down",1e-6)
 near(W.writes,0)
 `)>0);
});

test('a drag with the marker in view teaches the tilt per cursor unit outright, and carries the pitch on past the screen edge', () => {
 assert.ok(runtime(mouseKit + `
 W.engineClamp="axis"; W.cursor={0,0}; W.marker=true; W.pin=PIN; W.pitch=.2; enable(); frame(2.1)
 drag(true)
 mouse(0,-10,25,.0008) -- this game tilts .0008 a unit, whatever its settings say
 ok(R.Probe().mouseFrom=="marker","learnt against the marker")
 near(R.Probe().mouseTilt,-.0008,"the measured rate",1e-5)
 ok(R.CameraState().source=="marker")
 local followed=0
 for i=1,40 do -- on down past where the marker leaves the screen, to straight down
  mouse(0,-25,1,.0008)
  ok(not tiltHidden(),"never hidden for tilt while the mouse carries it: "..tostring(R.Why()))
  near(R.CameraState().pitch,W.pitch,"pitch at "..W.pitch,5e-3)
  if R.Probe().offScreen then followed=followed+1; ok(R.Probe().tilt=="followed" and drawn() and groundError()<6,"ground error "..groundError()) end
 end
 ok(followed>10,"the marker was off screen for most of it")
 mouse(0,25,40,.0008); drag(false)
 ok(R.CameraState().source=="marker" and R.Probe().tilt=="measured","the marker measures it again on the way back")
 near(R.CameraState().pitch,W.pitch,"pitch",1e-3)
 near(W.writes,0)
 `)>0);
});

test('a left drag follows the mouse only when it starts on the world, not on a window', () => {
 assert.ok(runtime(mouseKit + `
 local window={}
 GetMouseFoci=function() return W.foci or {} end
 W.cursor={0,0}; enable(); frame(2.1)
 drag(true); mouse(20,0,20); drag(false) -- learn the rate
 ok(R.Probe().mouseTilt~=nil)
 -- Dragging a window about: not the camera.
 W.foci={window}; W.left=true; W.cursor={0,-40}; frame(); frame(); frame(); W.left=false; W.cursor={0,0}; frame()
 near(R.CameraState().pitch,.42,"a window dragged is no tilt",1e-9)
 -- Dragging the world: the camera, pitch and all.
 W.foci={}; W.left=true; mouse(0,-40,5); W.left=false; frame()
 near(R.CameraState().pitch,.62,"a left drag on the world tilts the view: 200 units down",1e-6)
 near(W.writes,0)
 `)>0);
});

test('turned up, the camera stays above the ground and never shows it from underneath', () => { assert.ok(pure(`
 local focal = T.Focal(90, 1080)
 for _, zoom in ipairs({ 5, 15, 27 }) do
  for _, pitch in ipairs({ -1.53, -1.2, -.6, -.2, -.05 }) do
   local cam = T.Camera(.3, pitch, zoom, focal, 1920, 1080)
   ok(cam.z >= T.CAMERA_FLOOR - 1e-9, "camera above the ground at pitch " .. pitch .. ", zoom " .. zoom .. ": " .. cam.z)
  end
  local up = T.Camera(0, -1.2, zoom, focal, 1920, 1080)
  for x = 1, 200 do
   local sx, sy = T.Project(up, x, 0, 0)
   ok(not sx or sy < 0, "no ground ahead in a view turned to the sky")
  end
  local down = T.Camera(0, .5, zoom, focal, 1920, 1080)
  near(math.sqrt(down.x ^ 2 + down.y ^ 2 + (down.z - T.PIVOT) ^ 2), zoom, "looking down the boom keeps its length")
 end
`) > 0); });

test('with Smart Pivot the camera rests where its boom met the ground and turns up there', () => { assert.ok(pure(`
 local focal = T.Focal(90, 1080)
 local drop = T.PIVOT - T.CAMERA_FLOOR
 T.pivotInPlace = true
 for _, zoom in ipairs({ 5, 15, 27 }) do
  local back, meets = math.sqrt(zoom ^ 2 - drop ^ 2), -math.asin(drop / zoom)
  for _, pitch in ipairs({ -1.53, -1, -.4, meets - 1e-6 }) do
   local cam = T.Camera(0, pitch, zoom, focal, 1920, 1080)
   near(cam.z, T.CAMERA_FLOOR, "on the ground at pitch " .. pitch .. ", zoom " .. zoom)
   near(cam.x, -back, "where the boom met it, not drawn in", 1e-3)
   near(cam.fz, -math.sin(pitch), "looking up by the whole pitch")
  end
  local above = T.Camera(0, meets + 1e-6, zoom, focal, 1920, 1080)
  near(above.x, -back, "no jump as the boom meets the ground", 1e-3); near(above.z, T.CAMERA_FLOOR, "nor in height", 1e-3)
  near(T.Camera(0, .5, zoom, focal, 1920, 1080).z, T.PIVOT + zoom * math.sin(.5), "looking down is as before")
 end
 T.pivotInPlace = false
 near(T.Camera(0, -1, 27, focal, 1920, 1080).x, -(drop / math.sin(1)) * math.cos(1), "without it the camera is drawn in along the boom", 1e-9)
`) > 0); });

for (const pivot of ['1', '0']) {
 test('a raised trail is not drawn into a view turned up at the sky (Smart Pivot ' + (pivot === '1' ? 'on' : 'off') + ')', () => {
  assert.ok(runtime(mouseKit + `
  stub.cvars.cameraPivot="${pivot}"
  W.cursor={0,0}; enable(); frame(2.1)
  local g=R.GroundFrame()
  local function height()
   local sum,n=0,0
   for i=1,g.used do local t=g.stars[i]; sum,n=sum+t.points[1].y,n+1 end
   return n>0 and sum/n or nil
  end
  drag(true); mouse(20,0,20) -- learn the mouse
  local flat
  for _,lift in ipairs({0,1.5,3}) do
   Polestar.Set("nav.worldTrailLift",lift)
   mouse(0,-40,80) -- straight down: the pitch is known
   mouse(0,37,30)  -- and back to an ordinary view
   near(R.CameraState().pitch,.42,"an ordinary view",1e-6)
   frame(); local y=height()
   ok(y,"drawn in an ordinary view with the trail raised "..lift)
   if lift==0 then flat=y else ok(y>flat+5,"and raised on screen: "..y.." over "..flat) end
   local skyward=0
   for i=1,50 do
    mouse(0,40,1)
    if R.CameraState().pitch<=-.56 then
     skyward=skyward+1
     near(g.used,0,"nothing of a trail raised "..lift.." in a view turned up "..(-R.CameraState().pitch))
    end
   end
   ok(skyward>20 and R.CameraState().pitch==-1.53,"swept up to the sky")
  end
  near(W.writes,0)
  `)>0);
 });
}

// Flights as the game flies them: up at 7.9555 yd/s for a jump, down by 19.2911 yd/s each second.
const airKit = tiltKit + `
 local function arc(t,jump) return (jump==false and 0 or 7.9555*t)-19.2911*t*t/2 end
 -- The heights the trail's points are drawn at, against the feet.
 local project,drawnAt=T.Project,{}
 T.Project=function(cam,x,y,z) drawnAt[#drawnAt+1]=z; return project(cam,x,y,z) end
 local function paint() drawnAt={}; frame(); return drawnAt[1] end
`;

test('through a jump the trail stays on the ground instead of hopping with the character', () => {
 assert.ok(runtime(airKit + `
 enable(); frame(2.1)
 near(paint(),0,"standing: drawn at the feet")
 -- The keys cannot be read here: leaving the ground is taken for a jump.
 W.falling=true
 local top=0
 for k=1,16 do
  local t=.05*k-.025
  local z=paint()
  near(z,-arc(t),"the ground falls away under the feet by the jump's height, "..t.." s in",1e-6)
  top=math.max(top,-z)
 end
 ok(top>1.6 and top<1.65,"about 1.64 yards at the top: "..top)
 W.falling=false; near(paint(),0,"landed")
 -- With the jump key readable: a jump when it was down, nothing when it was not (a step off a ledge of unknown height).
 W.jumpKey="CTRL-SPACE"; W.keys={}; frame(6)
 W.falling=true; frame(); near(paint(),0,"left the ground with no jump key: not a jump"); W.falling=false; frame()
 W.keys.SPACE=true; frame(); W.keys.SPACE=false; frame(); W.falling=true
 near(paint(),-arc(.025),"a tap of the jump key just before leaving the ground",1e-6)
 W.falling=false; frame()
 -- Held: the game jumps again as it lands, without ever reporting the ground.
 W.keys.SPACE=true; W.falling=true
 for k=1,17 do paint() end
 near(paint(),-arc(.05),"the second jump of a held key",1e-6)
 for k=1,7 do paint() end
 ok(-paint()>1.6,"and its top")
 near(W.writes,0)
 `)>0);
});

test('on known ground a jump lands where the ground is and a step off a ledge falls to it', () => {
 assert.ok(runtime(bakedFixture + airKit + `
 local strip={}
 for i=0,200 do strip[i+1]=i<=50 and 10 or 4 end -- a ledge six yards high, fifty yards along
 bake(strip,1)
 observedFloor=function(c,x,y) return x<=50 and 10 or 4 end
 W.px=20; W.jumpKey="SPACE"; W.keys={}
 enable(); frame(2.1)
 ok(R.Probe().heightSource=="baked-strip")
 near(paint(),0,"the ground ahead is level with the feet")
 -- A jump on the flat.
 W.keys.SPACE=true; frame(); W.keys.SPACE=false; W.falling=true
 for k=1,16 do near(paint(),-arc(.05*k-.025),"a jump over known ground",1e-6) end
 W.falling=false; near(paint(),0,"landed",1e-6)
 -- Off the ledge with no jump: the feet fall by gravity to the ground below, not at once.
 W.px=45; frame(1)
 W.px=52; W.falling=true
 for k=1,16 do -- 0.79 s to fall six yards
  local t=.05*k-.025
  near(paint(),4-(10+arc(t,false)),"falling: the lower ground is "..(6+arc(t,false)).." below the feet, "..t.." s in",1e-6)
 end
 for k=1,3 do near(paint(),0,"down: the feet are on the lower ground",1e-6) end
 W.falling=false
 for k=1,4 do near(paint(),0,"and the drawn floor does not bounce back up",1e-6) end
 near(W.writes,0)
 `)>0);
});

test('a marker in view does not read a jump as a tilt or a hill', () => {
 assert.ok(runtime(airKit + `
 W.marker=true; W.pin=PIN; W.pitch=.3; enable(); frame(2.1) -- the pin's marker, standing on the ground ahead
 near(R.CameraState().pitch,.3,"measured",1e-3)
 local function hop(dragged)
  drag(dragged); W.falling=true
  for k=1,16 do
   local up=arc(.05*k-.025)
   W.markerZ=-up -- the marker stays on the ground as the feet rise
   frame()
   near(R.CameraState().pitch,.3,"the pitch through a jump"..(dragged and " with the camera dragged" or ""),1e-3)
   near(R.Probe().lift,0,"nothing learnt about the marker's height in the air",1e-3)
   ok(drawn() and R.CameraState().source:find("^marker"))
  end
  W.falling=false; W.markerZ=0; drag(false); frame()
  near(R.CameraState().pitch,.3,"and after landing",1e-3)
 end
 hop(false); hop(true)
 near(W.writes,0)
 `)>0);
});

test('whole mouse strokes measure the turn exactly although the view answers a frame late', () => {
 assert.ok(runtime(mouseKit + `
 W.cursor={0,0}; enable(); frame(2.1)
 drag(true)
 local owed=0
 local function late(dx) W.cursor={dx,0}; W.yaw=W.yaw-owed*K; W.facing=W.yaw; owed=dx; frame() end
 for s=1,4 do
  for i=1,12 do late((s%2==0 and -1 or 1)*(8+3*i)) end -- speeding up: a frame's lag would skew a part of a stroke
  late(0); late(0); late(0)
 end
 near(R.Probe().mouseTilt,-K/2,"the rate from whole strokes",K/2*.005)
 near(W.writes,0)
 `)>0);
});
