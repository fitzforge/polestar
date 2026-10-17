'use strict';
// Journeys (addon/Polestar/Nav/Journey.lua, Nearby.lua): plan to anywhere
// from the world map and minimap, the public Nav API, the TomTom stand-in and
// following TomTom's arrow, /way, nearby services, and the death helper
// handing a picked point back. Runs Core/Init.lua + Nav/Nav.xml against
// tests/lua/stub_nav.lua, plus a continent map, a world map canvas with click
// handlers and mouse foci. Test names cite the rows of
// docs/NAV_QA.md they guard.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const NAV = { name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] };

// Map 9100 "Testland" (continent type) holds 9000 "Testshire" at x, y 25..75;
// 9002 "The Barrens" lies west of it. The world map canvas records its click
// handlers; stub.canvasClick / stub.pinClick run them as Blizzard_MapCanvas does.
const WORLD = `
local nav = stub.nav
nav.maps[9100] = { c = 0, top = 2000, bottom = -2000, left = 2000, right = -2000, name = "Testland" }
nav.maps[9002] = { c = 0, top = 1000, bottom = -1000, left = 3000, right = 1000, name = "The Barrens" }
nav.Compat.SKILL_LINES = { mining = 186, alchemy = 171, riding = 762 }
local types = { [9100] = 2, [9000] = 3, [9001] = 3, [9002] = 3 }
function C_Map.GetMapInfo(id)
	local m = nav.maps[id]
	if m then return { mapID = id, name = m.name, mapType = types[id], parentMapID = id == 9100 and 0 or 9100 } end
end
function C_Map.GetMapInfoAtPosition(map, x, y)
	if map == 9100 and x >= 0.25 and x <= 0.75 and y >= 0.25 and y <= 0.75 then
		return { mapID = 9000, mapType = 3, name = "Testshire" }
	end
end
function C_Map.GetBestMapForUnit() return 9000 end
function C_Map.GetMapChildrenInfo(root)
	if root ~= 9100 then return {} end
	return { { mapID = 9000, name = "Testshire", mapType = 3 }, { mapID = 9002, name = "The Barrens", mapType = 3 },
		{ mapID = 9003, name = "Test Ridge", mapType = 3 } }
end
stub.canvas = { handlers = {}, pinHandlers = {}, cursor = { 0.5, 0.5 }, over = true }
local map = WorldMapFrame
function map.AddCanvasClickHandler(_, fn) table.insert(stub.canvas.handlers, fn) end
function map.AddGlobalPinMouseActionHandler(_, fn) table.insert(stub.canvas.pinHandlers, fn) end
function map.GetNormalizedCursorPosition() return stub.canvas.cursor[1], stub.canvas.cursor[2] end
function map.ScrollContainer.IsMouseOver() return stub.canvas.over end
MapCanvasMixin = { MouseAction = { Click = 1 } }
stub.foci = {}
function GetMouseFoci() return stub.foci end
function stub.canvasClick(button)
	local took = false
	for _, fn in ipairs(stub.canvas.handlers) do if fn(WorldMapFrame, button or "LeftButton") then took = true end end
	return took
end
function stub.pinClick(button)
	local took = false
	for _, fn in ipairs(stub.canvas.pinHandlers) do if fn(WorldMapFrame, 1, button or "LeftButton") then took = true end end
	return took
end
stub.menus = {}
Menu = { ModifyMenu = function(tag, fn) stub.menus[tag] = fn end }
`;

const PRELUDE = `
local N = Polestar.Nav
local API = N.API
local J = N.journey
local nav = stub.nav
local function label() local t = N.GetTarget(); return t and t.label or false end
local function said(text)
	for _, m in ipairs(stub.messages) do if m:find(text, 1, true) then return true end end
	return false
end
local function keys(shift, alt, ctrl) stub.keys.shift, stub.keys.alt, stub.keys.ctrl = shift or false, alt or false, ctrl or false end
`;

function run(script, opts = {}) {
	return runAddon({
		stubs: ['stub_nav.lua'],
		addons: [NAV],
		before: WORLD + (opts.before || ''),
		saved: opts.saved,
		login: opts.login !== false,
		script: PRELUDE + script,
	}).emitted;
}

const near = (a, b, eps = 1e-6) => Math.abs(a - b) <= eps;

// ---------------------------------------------------------------------------
// Plan to anywhere
// ---------------------------------------------------------------------------

test('plan anywhere: Shift-click on the world map points the arrow there, named after the zone; the same spot again lets it go', () => {
	const [first, again, other] = run(`
		nav.setWaypoint({ map = 9000, x = 50, y = 50, label = "Guide step", stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 })
		nav.showWorldMap(9000)
		keys(true)
		stub.canvas.cursor = { 0.7, 0.3 }
		local took = stub.canvasClick()
		local t = N.GetTarget()
		emit({ took = took, label = t.label, x = t.x, y = t.y, map = t.map, override = N.IsOverride() })
		stub.canvas.cursor = { 0.705, 0.3 } -- 10 yd away: the same spot
		stub.canvasClick()
		emit({ label = label(), override = N.IsOverride() })
		keys(false)
		emit({ took = stub.canvasClick(), label = label() })
	`);
	assert.deepEqual(first, { took: true, label: 'Testshire 70, 30', x: 70, y: 30, map: 9000, override: true });
	assert.deepEqual(again, { label: 'Guide step', override: false });
	assert.deepEqual(other, { took: false, label: 'Guide step' }, 'a plain click stays the map\'s own');
});

test('plan anywhere: a continent click lands on the zone under it (C13: open sea prints a line and plans nothing)', () => {
	const [zone, sea] = run(`
		nav.showWorldMap(9100)
		keys(true)
		stub.canvas.cursor = { 0.6, 0.4 } -- world (400, -400): Testshire (70, 30)
		stub.canvasClick()
		local t = N.GetTarget()
		emit({ map = t.map, x = t.x, y = t.y, label = t.label })
		N.ClearTarget()
		stub.messages = {}
		stub.canvas.cursor = { 0.1, 0.1 }
		emit({ took = stub.canvasClick(), target = N.GetTarget() == nil, said = said("No route can be planned to that spot.") })
	`);
	assert.equal(zone.map, 9000);
	assert.ok(near(zone.x, 70) && near(zone.y, 30), JSON.stringify(zone));
	assert.equal(zone.label, 'Testshire 70, 30');
	assert.deepEqual(sea, { took: true, target: true, said: true });
});

test('plan anywhere: Shift-click with a chat edit box open links into chat and plans nothing (row 8)', () => {
	const [out] = run(`
		ChatEdit_GetActiveWindow = function() return {} end
		nav.showWorldMap(9000)
		keys(true)
		stub.canvas.cursor = { 0.7, 0.3 }
		local canvas = stub.canvasClick()
		N.SetTarget(9000, 60, 60, "Picked")
		local pin = stub.pinClick()
		emit({ canvas = canvas, pin = pin, label = label() })
	`);
	assert.deepEqual(out, { canvas: false, pin: false, label: 'Picked' });
});

test('plan anywhere: Shift-click on the planned spot\'s own pin lets it go (pins take canvas clicks)', () => {
	const [out] = run(`
		nav.showWorldMap(9000)
		keys(true)
		stub.canvas.cursor = { 0.7, 0.3 }
		stub.canvasClick()
		local targetPin
		for _, p in ipairs(nav.pins()) do if p.data.layer.name == "nav.target" then targetPin = p end end
		nav.click(targetPin, "LeftButton")
		emit({ pin = targetPin ~= nil, target = N.GetTarget() == nil })
	`);
	assert.deepEqual(out, { pin: true, target: true });
});

test('plan anywhere: Alt-click plans over map icons by their name and leaves Polestar\'s clickable pins alone (row 9)', () => {
	const [cursor, icon, own, menu] = run(`
		nav.showWorldMap(9000)
		keys(false, true)
		stub.canvas.cursor = { 0.25, 0.75 }
		stub.fire("GLOBAL_MOUSE_DOWN", "LeftButton")
		local t = N.GetTarget()
		emit({ x = t.x, y = t.y, label = t.label })
		stub.foci = { { pinTemplate = "FlightPointPinTemplate", poiInfo = { name = "West Hold" },
			GetMap = function() return WorldMapFrame end, GetPosition = function() return 0.1, 0.5 end } }
		stub.fire("GLOBAL_MOUSE_DOWN", "LeftButton")
		t = N.GetTarget()
		emit({ x = t.x, y = t.y, label = t.label })
		Polestar.Pins.SetLayer("test.click", { { map = 9000, x = 90, y = 90, onClick = function() end } })
		for _, p in ipairs(nav.pins()) do if p.data.layer.name == "test.click" then stub.foci = { p } end end
		stub.canvas.cursor = { 0.9, 0.9 }
		stub.fire("GLOBAL_MOUSE_DOWN", "LeftButton")
		emit(label())
		stub.foci = {}
		keys(true, true) -- Shift with Alt is neither
		stub.fire("GLOBAL_MOUSE_DOWN", "LeftButton")
		emit(label())
	`);
	assert.deepEqual(cursor, { x: 25, y: 75, label: 'Testshire 25, 75' });
	assert.deepEqual(icon, { x: 10, y: 50, label: 'West Hold' });
	assert.equal(own, 'West Hold');
	assert.equal(menu, 'West Hold');
});

test('plan anywhere: Shift-click on the minimap goes to the spot under the cursor; off its face prints a line (C13)', () => {
	const [spot, again, corner] = run(`
		nav.viewRadius = 200
		keys(true)
		stub.cursor = { 70 + 35, 70 } -- half the radius east of the centre: 100 yd east
		stub.RunScript(Minimap, "OnMouseUp", "LeftButton")
		local t = N.GetTarget()
		emit({ x = t.x, y = t.y, label = t.label })
		stub.cursor = { 70 + 36, 70 } -- 3 yd away: the same spot
		stub.RunScript(Minimap, "OnMouseUp", "LeftButton")
		emit(N.GetTarget() == nil)
		stub.messages = {}
		stub.cursor = { 70 + 65, 70 + 65 } -- the corner of a round minimap
		stub.RunScript(Minimap, "OnMouseUp", "LeftButton")
		emit({ target = N.GetTarget() == nil, said = said("No route can be planned to that spot.") })
	`);
	assert.ok(near(spot.x, 55) && near(spot.y, 50), JSON.stringify(spot));
	assert.equal(spot.label, 'Testshire 55, 50');
	assert.equal(again, true);
	assert.deepEqual(corner, { target: true, said: true });
});

test('plan anywhere: off in settings, map clicks are the map\'s own', () => {
	const [out] = run(`
		Polestar.Set("nav.mapPlan", false)
		nav.showWorldMap(9000)
		keys(true)
		local took = stub.canvasClick()
		stub.RunScript(Minimap, "OnMouseUp", "LeftButton")
		keys(false, true)
		stub.fire("GLOBAL_MOUSE_DOWN", "LeftButton")
		emit({ took = took, target = N.GetTarget() == nil })
	`);
	assert.deepEqual(out, { took: false, target: true });
});

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

test('API: Navigate checks its input, sets the target and names the owner; Cancel only for that owner', () => {
	const [bad, set, cancel] = run(`
		emit({ API.Navigate("", 9000, 0.5, 0.5), API.Navigate("A", 9000, 1.5, 0.5), API.Navigate("A", 12345, 0.5, 0.5),
			API.Navigate("A", 9000, 0.5, 0.5, 7), API.Navigate("A", 9000.5, 0.5, 0.5), N.GetTarget() == nil, API.Active() })
		local ok = API.Navigate("Helper", 9000, 0.25, 0.75, "Camp")
		local t = N.GetTarget()
		local active, owner = API.Active()
		emit({ ok = ok, x = t.x, y = t.y, label = t.label, active = active, owner = owner })
		emit({ other = API.Cancel("Someone"), mine = API.Cancel("Helper"), target = N.GetTarget() == nil, again = API.Cancel("Helper") })
	`);
	assert.deepEqual(bad, [false, false, false, false, false, true, false]);
	assert.deepEqual(set, { ok: true, x: 25, y: 75, label: 'Camp', active: true, owner: 'Helper' });
	assert.deepEqual(cancel, { other: false, mine: true, target: true, again: false });
});

test('API: a target replaced is not the owner\'s until the same spot comes back (the death helper hands it back)', () => {
	const [away, back] = run(`
		API.Navigate("Helper", 9000, 0.25, 0.75, "Camp")
		N.SetTarget(9000, 70, 50, "Your corpse")
		local active, owner = API.Active()
		emit({ active = active, owner = owner or false, cancel = API.Cancel("Helper"), label = label() })
		N.SetTarget(9000, 25, 75, "Camp")
		active, owner = API.Active()
		emit({ owner = owner or false, cancel = API.Cancel("Helper") })
	`);
	assert.deepEqual(away, { active: true, owner: false, cancel: false, label: 'Your corpse' });
	assert.deepEqual(back, { owner: 'Helper', cancel: true });
});

test('API: Estimate answers in seconds, from the player or a given point, and refuses bad input', () => {
	const [out] = run(`
		local a = API.Estimate(nil, nil, nil, 9000, 0.5, 0.6)       -- 200 yd south of the player
		local b = API.Estimate(nil, nil, nil, 9000, 0.5, 0.6)
		local c = API.Estimate(9000, 0.5, 0.1, 9000, 0.5, 0.6)       -- 1000 yd
		local bad, why = API.Estimate(nil, nil, nil, 9000, 2, 0.5)
		local bad2, why2 = API.Estimate(9000, -1, 0.5, 9000, 0.5, 0.5)
		emit({ a = a, b = b, c = c, bad = bad or false, why = why, bad2 = bad2 or false, why2 = why2 })
	`);
	assert.ok(out.a > 0 && Number.isFinite(out.a), `a ${out.a}`);
	assert.equal(out.a, out.b, 'the same question answers the same');
	assert.ok(out.c > out.a, 'a longer walk takes longer');
	assert.deepEqual([out.bad, out.why, out.bad2, out.why2], [false, 'invalid', false, 'invalid']);
});

test('API: a route sent while a ghost is taken without error (C11)', () => {
	const [out] = run(`
		function UnitIsGhost() return true end
		function UnitIsDeadOrGhost() return true end
		emit({ ok = API.Navigate("Helper", 9000, 0.3, 0.3, "Camp"), label = label() })
	`);
	assert.deepEqual(out, { ok: true, label: 'Camp' });
});

// ---------------------------------------------------------------------------
// TomTom stand-in
// ---------------------------------------------------------------------------

// The stand-in is off by default ("Let other addons set waypoints"): these
// tests turn it on as a player would.
const ANSWER = { Polestar: 'PolestarDB = { schema = 1, settings = { nav = { answerTomTom = true } } }' };

test('TomTom stand-in: off by default, so no TomTom global (an addon reading TomTom.db would error) and no /way', () => {
	const [out] = run(`
		emit({ tomtom = TomTom == nil, answering = J.AnsweringTomTom(), way = SLASH_POLESTARWAY1 == nil,
			default = Polestar.Get("nav.answerTomTom") })
	`);
	assert.deepEqual(out, { tomtom: true, answering: false, way: true, default: false });
});

test('TomTom stand-in: other addons\' waypoints point the arrow, one at a time; corpse and Polestar\'s own are ignored (row 7)', () => {
	const [installed, added, removed, ignored, zoned, cleared, off] = run(`
		emit(TomTom == N.tomtomShim)
		local uid = TomTom:AddWaypoint(9000, 0.25, 0.75, { title = "Quest giver", from = "Helper" })
		local t = N.GetTarget()
		local _, owner = API.Active()
		emit({ x = t.x, y = t.y, label = t.label, owner = owner, valid = TomTom:IsValidWaypoint(uid),
			exists = TomTom:WaypointExists(9000, 0.25, 0.75, "Quest giver"), from = uid.from })
		emit({ removed = TomTom:RemoveWaypoint(uid), target = N.GetTarget() == nil, valid = TomTom:IsValidWaypoint(uid) })
		emit({ corpse = TomTom:AddWaypoint(9000, 0.5, 0.5, { title = "My Corpse", corpse = true }) == nil,
			mirror = TomTom:AddWaypoint(9000, 0.5, 0.5, { from = "Polestar" }) == nil, target = N.GetTarget() == nil,
			bad = TomTom:AddWaypoint(9000, 0.5, 0.5, "nope") == nil })
		TomTom:AddZWaypoint(0, 9000, 30, 40, "Old style")
		t = N.GetTarget()
		emit({ x = t.x, y = t.y, label = t.label })
		TomTom:ClearAllWaypoints()
		emit(N.GetTarget() == nil)
		Polestar.Set("nav.answerTomTom", false)
		emit(TomTom == nil)
	`, { saved: ANSWER });
	assert.equal(installed, true);
	assert.deepEqual(added, { x: 25, y: 75, label: 'Quest giver', owner: 'TomTom', valid: true, exists: true, from: 'Helper' });
	assert.deepEqual(removed, { removed: true, target: true, valid: false });
	assert.deepEqual(ignored, { corpse: true, mirror: true, target: true, bad: true });
	assert.deepEqual(zoned, { x: 30, y: 40, label: 'Old style' });
	assert.equal(cleared, true);
	assert.equal(off, true);
});

test('TomTom stand-in: Polestar\'s own targets are never mirrored into it (no loop)', () => {
	const [out] = run(`
		N.SetTarget(9000, 60, 60, "Picked")
		local n = 0
		for _, byKey in pairs(TomTom.waypoints) do for _ in pairs(byKey) do n = n + 1 end end
		local _, owner = API.Active()
		emit({ label = label(), waypoints = n, owner = owner or false })
	`, { saved: ANSWER });
	assert.deepEqual(out, { label: 'Picked', waypoints: 0, owner: false });
});

test('TomTom stand-in: a TomTom switched off in the AddOns list does not count; an enabled one does (row 7)', () => {
	const [disabled] = run('emit(TomTom == N.tomtomShim)', { before: 'stub.addons = { { name = "TomTom", reason = "DISABLED", enabled = false } }', saved: ANSWER });
	const [enabled] = run('emit(TomTom == nil)', { before: 'stub.addons = { { name = "TomTom" } }', saved: ANSWER });
	assert.equal(disabled, true);
	assert.equal(enabled, true);
});

test('TomTom stand-in: other TomTom methods are harmless no-ops; fields such as TomTom.db are not provided (security L7)', () => {
	const [out] = run(`
		local ok, err = pcall(function()
			return TomTom:SetCustomClickCallback("x"), TomTom:AddCustomCallback(), TomTom.GetCurrentWaypoint(TomTom)
		end)
		emit({ ok = ok, err = err or false, db = TomTom.db == nil, profile = TomTom.profile == nil,
			add = type(TomTom.AddWaypoint), target = N.GetTarget() == nil })
	`, { saved: ANSWER });
	assert.deepEqual(out, { ok: true, err: false, db: true, profile: true, add: 'function', target: true });
});

test('TomTom stand-in: the global is taken at login, and an addon\'s own TomTom-compatible global keeps it (security L7)', () => {
	const [beforeLogin, own] = run(`
		emit(TomTom == nil)
		TomTom = { AddWaypoint = function() return "theirs" end, RemoveWaypoint = function() end }
		stub.loggedIn = true
		stub.fire("PLAYER_LOGIN")
		emit({ theirs = TomTom.AddWaypoint() == "theirs", answering = J.AnsweringTomTom() })
	`, { login: false, saved: ANSWER });
	assert.equal(beforeLogin, true, 'nothing set before every addon has loaded');
	assert.deepEqual(own, { theirs: true, answering: false });
});

// A TomTom 4.3.12-shaped fake (its SetCrazyArrow, ClearWaypoint and RemoveWaypoint
// called through the table, AddWaypoint pointing the arrow when crazy).
const REAL_TOMTOM = `
TomTom = { valid = {}, adds = {} }
function TomTom:SetCrazyArrow(uid) self.arrow = uid end
function TomTom:ClearWaypoint(uid) self.valid[uid] = nil end
function TomTom:RemoveWaypoint(uid) self:ClearWaypoint(uid) end
function TomTom:IsValidWaypoint(uid) return self.valid[uid] == true end
function TomTom:AddWaypoint(m, x, y, opts)
	opts = opts or {}
	local uid = { m, x, y, title = opts.title, from = opts.from or "?" }
	for k, v in pairs(opts) do if uid[k] == nil then uid[k] = v end end
	self.valid[uid] = true
	table.insert(self.adds, uid)
	if opts.crazy ~= false then self:SetCrazyArrow(uid) end
	return uid
end
`;
const FOLLOW = { Polestar: 'PolestarDB = { schema = 1, settings = { nav = { followTomTom = true } } }' };

test('follow TomTom: restores the arrow\'s waypoint one frame after PLAYER_ENTERING_WORLD, never mirrored back (row 7)', () => {
	const [early, entered, framed] = run(`
		local uid = TomTom:AddWaypoint(9000, 0.25, 0.75, { title = "Saved", from = "TomTom/way" }) -- TomTom's login restore
		emit(N.GetTarget() == nil)
		stub.loggedIn = true
		stub.fire("PLAYER_LOGIN")
		stub.fire("PLAYER_ENTERING_WORLD", true, false)
		emit(N.GetTarget() == nil)
		stub.runTimers()
		emit({ label = label(), adds = #TomTom.adds, shim = TomTom == N.tomtomShim })
	`, { before: REAL_TOMTOM, saved: FOLLOW, login: false });
	assert.equal(early, true);
	assert.equal(entered, true, 'not before a frame has passed');
	assert.deepEqual(framed, { label: 'Saved', adds: 1, shim: false });
});

test('follow TomTom: Remove all ends it, the corpse arrow and Polestar\'s own mirror are ignored, off means never (row 7)', () => {
	const [followed, corpse, mirror, removed, off] = run(`
		stub.runTimers()
		local uid = TomTom:AddWaypoint(9000, 0.25, 0.75, { title = "Guide pin", from = "Helper" })
		emit(label())
		TomTom:AddWaypoint(9000, 0.5, 0.5, { title = "My Corpse", corpse = true })
		emit(label())
		N.SetTarget(9000, 60, 60, "Picked") -- Bridges mirrors it (from = "Polestar", crazy off unless the TomTom arrow is used)
		TomTom:SetCrazyArrow(TomTom.adds[#TomTom.adds])
		emit({ label = label(), from = TomTom.adds[#TomTom.adds].from })
		TomTom:SetCrazyArrow(uid)
		TomTom:ClearWaypoint(uid) -- "Remove all waypoints" clears through ClearWaypoint alone
		emit(N.GetTarget() == nil)
		Polestar.Set("nav.followTomTom", false)
		TomTom:AddWaypoint(9000, 0.1, 0.1, { title = "Ignored", from = "Helper" })
		emit(N.GetTarget() == nil)
	`, { before: REAL_TOMTOM, saved: FOLLOW });
	assert.equal(followed, 'Guide pin');
	assert.equal(corpse, 'Guide pin');
	assert.deepEqual(mirror, { label: 'Picked', from: 'Polestar' });
	assert.equal(removed, true);
	assert.equal(off, true);
});

// ---------------------------------------------------------------------------
// /way
// ---------------------------------------------------------------------------

test('/way: x y on your map, #mapID, a zone named inside its name, an ambiguous name, reset (row 7)', () => {
	const [claimed, here, byId, barrens, ambiguous, reset] = run(`
		emit(SLASH_POLESTARWAY1)
		local way = SlashCmdList.POLESTARWAY
		way("45 61 Camp")
		local t = N.GetTarget()
		emit({ map = t.map, x = t.x, y = t.y, label = t.label })
		way("#9000 10,5 20")
		t = N.GetTarget()
		emit({ map = t.map, x = t.x, y = t.y, label = t.label })
		way("barrens 50, 50")
		t = N.GetTarget()
		emit({ map = t.map, x = t.x, y = t.y })
		stub.messages = {}
		way("test 10 10")
		emit(said("test could be Test Ridge, Testshire."))
		way("reset")
		emit(N.GetTarget() == nil)
	`, { saved: ANSWER });
	assert.equal(claimed, '/way');
	assert.deepEqual(here, { map: 9000, x: 45, y: 61, label: 'Camp' });
	assert.deepEqual(byId, { map: 9000, x: 10.5, y: 20, label: 'Testshire 11, 20' });
	assert.deepEqual(barrens, { map: 9002, x: 50, y: 50 });
	assert.equal(ambiguous, true);
	assert.equal(reset, true);
});

test('/way: left alone when another addon has it', () => {
	const [out] = run('emit(SLASH_POLESTARWAY1 == nil)', { before: 'SLASH_OTHERWAY1 = "/WAY"', saved: ANSWER });
	assert.equal(out, true);
});

// ---------------------------------------------------------------------------
// Nearby services
// ---------------------------------------------------------------------------

const CODEX = `
local npcs = {
	[1] = { id = 1, name = "Near Smith", faction = "A", spawns = { { map = 9000, x = 55, y = 50 } } },
	[2] = { id = 2, name = "Far Smith", faction = "AH", spawns = { { map = 9000, x = 90, y = 50 }, { map = 9000, x = 52, y = 50 } } },
	[3] = { id = 3, name = "Horde Smith", faction = "H", spawns = { { map = 9000, x = 50, y = 51 } } },
	[4] = { id = 4, name = "Deep Smith", instance = "Deadmines", spawns = { { map = 9000, x = 50, y = 50.5 } } },
	[5] = { id = 5, name = "Reagent Ruth", faction = "A", spawns = { { map = 9000, x = 40, y = 50 } } },
	[6] = { id = 6, name = "Miner Mo", spawns = { { map = 9000, x = 60, y = 60 } } },
}
local roles = { repair = { 1, 2, 3, 4 }, vendor = { 1, 5 }, ["trainer:186"] = { 6 } }
stub.codexLoaded = true
Polestar.Codex = {
	IsLoaded = function() return stub.codexLoaded end,
	Load = function() stub.codexLoaded = true; return true end,
	WithRole = function(r) return roles[r] or {} end,
	Npc = function(id) return npcs[id] end,
}
Polestar.QoL = { data = { reagentVendors = { [5] = true } } }
nav.faction = "Alliance"
local Near = N.nearby
`;

test('nearby: the nearest spawn of each friendly NPC outside instances, ranked by travel time', () => {
	const [repair, reagents, mining, alone, cls] = run(CODEX + `
		Near.Go("repair")
		emit(label())
		Near.Go("reagents")
		emit(label())
		Near.Command("trainer mining")
		emit(label())
		N.ClearTarget()
		Near.Command("Mining")
		emit(label())
		nav.Engine.NearestClassTrainer = function() return { npc = 9, npcName = "Trainer Tess", map = 9000, x = 45, y = 50 } end
		Near.Command("class")
		emit(label())
	`);
	assert.equal(repair, 'Far Smith', 'its second spawn is 40 yd away; the Horde and dungeon smiths never count');
	assert.equal(reagents, 'Reagent Ruth', 'only vendors listed as reagent vendors');
	assert.equal(mining, 'Miner Mo');
	assert.equal(alone, 'Miner Mo', 'a profession alone means its trainer');
	assert.equal(cls, 'Trainer Tess');
});

// A French client whose names pack lands after the first /polestar near: the
// Codex then names its NPCs in French (Codex drops its records on
// NAMES_LOADED), and so must the places Nearby kept.
test('nearby: a names pack landing late renames the places; a learned NPC name too', () => {
	const [before, after, learned] = run(CODEX + `
		function GetLocale() return "frFR" end
		Near.Go("repair")
		emit(label())
		npcs[2].name = "Forgeron lointain"
		Polestar.Fire("NAMES_LOADED")
		Near.Go("repair")
		emit(label())
		npcs[2].name = "Forgeron du lointain"
		Polestar.Fire("NAME_LEARNED", "npc", 2)
		Near.Go("repair")
		emit(label())
	`);
	assert.equal(before, 'Far Smith');
	assert.equal(after, 'Forgeron lointain');
	assert.equal(learned, 'Forgeron du lointain');
});

test('nearby: Rank estimates only the nearest few, and the quickest by route wins over the nearest by line', () => {
	const [out] = run(`
		local Near = N.nearby
		local places, asked = {}, {}
		for i = 1, 10 do places[i] = { id = i, c = 0, wx = i * 10, wy = 0 } end
		places[11] = { id = 11, c = 1, wx = 0, wy = 0 } -- another continent
		local best, s = Near.Rank(places, { c = 0, wx = 0, wy = 0 }, function(p)
			asked[#asked + 1] = p.id
			return p.id == 3 and 5 or 100
		end)
		local none = Near.Rank({}, { c = 0, wx = 0, wy = 0 }, function() return 1 end)
		local straight, s2 = Near.Rank({ { id = 1, c = 0, wx = 70, wy = 0 } }, { c = 0, wx = 0, wy = 0 }, function() return nil end)
		emit({ best = best.id, s = s, asked = asked, none = none == nil, straight = straight.id, s2 = s2 })
	`);
	assert.deepEqual(out, { best: 3, s: 5, asked: [1, 2, 3, 4, 5, 6], none: true, straight: 1, s2: 10 });
});

test('nearby: no Codex, combat and nothing known each say their own line (C14)', () => {
	const [noCodex, combat, none, usage] = run(`
		Polestar.Codex = nil
		stub.messages = {}
		emit({ ok = N.nearby.Go("bank"), said = said("Nearby services need the Polestar Codex addon, which is not installed") })
	` + CODEX + `
		stub.codexLoaded = false
		stub.inCombat = true
		stub.messages = {}
		emit({ ok = Near.Go("bank"), said = said("Nearby services can be looked up after combat."), loaded = stub.codexLoaded })
		stub.inCombat = false
		stub.messages = {}
		emit({ ok = Near.Go("stable"), said = said("No stable master known for your faction.") })
		stub.messages = {}
		Near.Command("spaceport")
		emit(said("Usage: /polestar near"))
	`);
	assert.deepEqual(noCodex, { ok: false, said: true });
	assert.deepEqual(combat, { ok: false, said: true, loaded: false });
	assert.deepEqual(none, { ok: false, said: true });
	assert.equal(usage, true);
});

test('nearby: each Codex failure says its own line: missing, disabled, empty, any other load reason (review P2-7, C14)', () => {
	const out = run(CODEX + `
		local function try(loadReason, roleList)
			stub.codexLoaded = loadReason == nil
			Polestar.Codex.Load = function() return false, loadReason end
			Polestar.Codex.WithRole = function() return roleList or {} end
			stub.messages = {}
			local _, why = Near.Find("bank")
			Near.Go("bank")
			return { why = why, line = stub.messages[#stub.messages] or false }
		end
		emit(try("missing"))
		emit(try("disabled"))
		emit(try("interface_version"))
		emit(try(nil, {})) -- loaded, but no NPC has any role: a broken Codex
	`);
	const [missing, disabled, other, empty] = out;
	assert.equal(missing.why, 'missing');
	assert.match(missing.line, /need the Polestar Codex addon, which is not installed/);
	assert.equal(disabled.why, 'disabled');
	assert.match(disabled.line, /turn it on in the AddOns list/);
	assert.equal(other.why, 'interface_version');
	assert.match(other.line, /could not load the Polestar Codex \(interface_version\)/);
	assert.equal(empty.why, 'empty');
	assert.match(empty.line, /could not read the Polestar Codex: reinstall Polestar/);
	assert.equal(new Set(out.map((o) => o.line)).size, 4, 'four different lines');
	assert.ok(out.every((o) => !/known for your faction/.test(o.line)), 'never "none known" for a Codex failure');
});

test('nearby: the tracking menus carry a Nearby services submenu with every kind; picking one sets the target', () => {
	const [out] = run(CODEX + `
		local function node(text, fn)
			local n = { text = text, fn = fn, kids = {} }
			function n:CreateButton(t, f) local k = node(t, f); table.insert(self.kids, k); return k end
			return n
		end
		local root = node("root")
		stub.menus.MENU_MINIMAP_TRACKING(nil, root)
		local sub = root.kids[1]
		local texts = {}
		for _, k in ipairs(sub.kids) do texts[#texts + 1] = k.text end
		local trainers = {}
		for _, k in ipairs(sub.kids[1].kids) do trainers[#trainers + 1] = k.text end
		sub.kids[3].fn() -- Repair
		local world = stub.menus.MENU_WORLD_MAP_TRACKING ~= nil
		Polestar.Set("nav.nearbyMenu", false)
		local empty = node("root")
		stub.menus.MENU_MINIMAP_TRACKING(nil, empty)
		emit({ title = sub.text, texts = texts, trainers = trainers, label = label(), world = world, off = #empty.kids })
	`);
	assert.equal(out.title, 'Nearby services');
	assert.deepEqual(out.texts, ['Profession trainer', 'Class trainer', 'Repair', 'Reagents', 'Vendor', 'Innkeeper', 'Bank', 'Auction house', 'Flight master', 'Stable master']);
	assert.deepEqual(out.trainers, ['Nearest', 'Alchemy', 'Mining'], 'no riding trainer');
	assert.equal(out.label, 'Far Smith');
	assert.equal(out.world, true);
	assert.equal(out.off, 0);
});

// ---------------------------------------------------------------------------
// Corpse: the death helper hands a picked point back
// ---------------------------------------------------------------------------

test('death helper: a point picked before dying comes back after resurrecting, on the same step only', () => {
	const QOL = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] };
	const run2 = (script) =>
		runAddon({ stubs: ['stub_qol.lua'], addons: [QOL], login: true, script: `local q = stub.qol\nlocal QoL = Polestar.QoL\n${script}` }).emitted;
	const [back, moved] = [
		run2(`
			q.Nav.IsOverride = function() return q.nav.target ~= nil and q.nav.target.label == "Picked" end
			QoL.SetData({ spiritHealers = { { 0, 20, 0, 9000, 50, 49 } }, flightMasters = {} })
			q.player = { c = 0, wx = 0, wy = 0 }
			q.nav.target = { map = 9000, x = 30, y = 30, label = "Picked", kind = "manual", stepIndex = q.engine.step }
			local _, cx, cy = q.mapPoint(0, -400)
			q.corpse = { cx, cy }
			q.level = 30
			q.ghost = true
			stub.fire("PLAYER_ALIVE")
			local during = q.nav.target.label
			q.ghost = false
			stub.fire("PLAYER_UNGHOST")
			emit({ during = during, after = q.nav.target and q.nav.target.label, releases = q.nav.releases })
		`)[0],
		run2(`
			q.Nav.IsOverride = function() return q.nav.target ~= nil and q.nav.target.label == "Picked" end
			QoL.SetData({ spiritHealers = { { 0, 20, 0, 9000, 50, 49 } }, flightMasters = {} })
			q.player = { c = 0, wx = 0, wy = 0 }
			q.nav.target = { map = 9000, x = 30, y = 30, label = "Picked", kind = "manual", stepIndex = -1 }
			q.level = 8
			q.ghost = true
			stub.fire("PLAYER_ALIVE")
			q.ghost = false
			stub.fire("PLAYER_UNGHOST")
			emit({ after = q.nav.target and q.nav.target.label or false, releases = q.nav.releases })
		`)[0],
	];
	assert.deepEqual(back, { during: 'Your corpse', after: 'Picked', releases: 0 });
	assert.deepEqual(moved, { after: false, releases: 1 });
});
