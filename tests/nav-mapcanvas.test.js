'use strict';
// Polestar on Blizzard's map frames (addon/Polestar/Nav/MapCanvas.lua): the
// world map and the battlefield map are only read. With the keyboard and
// mouse interface and with the gamepad one, every drawing Polestar makes on
// them shows (Nav's pins, areas, regions and trail; Maps' zone levels, info
// bar, route lines and unexplored areas), and no code of the addon writes into the maps'
// tables: in game a value it wrote there taints the gamepad interface's
// secure code, and the game blocks its protected calls as the map opens and
// closes ("An action was blocked because of taint from Polestar -
// SetPreferredGamepadInteractTarget()"). stub.guardMap (tests/lua/
// wow_stub.lua) makes such a write fail and lists what the addon reads.
// Nor does the addon call CreateFrame with a parent on the maps (or the
// minimap): the gamepad interface hooks it and rebuilds the open map's
// buttons in the caller's code, tainted (wow_stub.lua's stub.underGameFrames).
// Core, Theme, Nav, Maps and UI against stub_world.lua + stub_maps.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Maps/Maps.xml', 'UI/UI.xml'];

// Zone 9000 in continent 9100 (stub_maps.lua's map canvas). Zone 9000 shows
// art 9001 with two unexplored overlays (three tiles); the battlefield map
// exists before Blizzard_BattlefieldMap reports it loaded, as in the client.
const BEFORE = (style) => `
stub.maps.useWorld(); stub.maps.withMapCanvas(); stub.maps.place(0, 800)
Enum.InputDeviceInterfaceType.Mkb, Enum.InputDeviceInterfaceType.Gamepad = 0, 1
C_InputInterfaceStyle = { GetCurrentStyle = function() return ${style === 'gamepad' ? 1 : 0} end }
BattlefieldMapFrame = stub.newMapCanvas("BattlefieldMapFrame")
BattlefieldMapFrame.mapID = 9000
stub.guardMap(BattlefieldMapFrame)
`;

const SCRIPT = `
local M, m, P, N = Polestar.Maps, stub.maps, Polestar.Pins, Polestar.Nav
C_Map.GetMapArtLayers = function(id)
	if id == 9000 then return { { layerWidth = 1002, layerHeight = 668, tileWidth = 256, tileHeight = 256 } } end
	return {}
end
C_Map.GetMapArtID = function(id) return id == 9000 and 9001 or nil end
C_MapExplorationInfo = { GetExploredMapTextures = function() return {} end }
Polestar.UI.ZoneArt.RegisterOverlays("test", { [9001] = { 256, 256, { 300, 200, 600, 100, 501, 502 }, { 100, 100, 50, 300, 503 } } })
M.RegisterZoneLevels({ [9000] = { 10, 20, 50, 50 } })
Polestar.Set("maps.reveal", "tint")
Polestar.Set("maps.coords", true)
Polestar.Set("maps.zoneLevels", true)
Polestar.Set("maps.dungeonPins", true)

local clicked
P.SetLayer("test.marks", {
	{ map = 9000, x = 30, y = 30, area = 60, tooltip = "A mark", onClick = function(button) clicked = button end },
	{ c = 0, wx = 0, wy = 0, hull = { 100, 0, 0, 150, -100, 0, 0, -150 }, areaOnly = true },
})
N.SetTarget(9000, 70, 60, "Somewhere")

local function tiles(map)
	local n = 0
	for _, f in ipairs(map:GetCanvas().children) do
		for _, t in ipairs(f.regions or {}) do
			if type(t.texture) == "number" and t.texture >= 501 and t.texture <= 503 and t:IsShown() and f:IsVisible() then n = n + 1 end
		end
	end
	return n
end
local function drawn()
	local labels = 0
	for _, f in ipairs(m.canvas.children) do
		if rawget(f, "Range") and f:IsVisible() then labels = labels + 1 end
	end
	-- The way to the target: the route lines (Maps/RouteLines.lua), or the trail's dots while they draw nothing.
	local R = Polestar.RouteLines
	local lines = R and R.GetWorldFrame() and R.GetWorldFrame():IsVisible() and R.GetStrokes("world").n or 0
	-- The marks and the target; the route's steps (pins with a step) come and
	-- go with Nav/Travel.lua's choice of way and are left out.
	local pins = 0
	for _, f in ipairs(P.GetWorldFrames("pins")) do
		if not (f.data and f.data.pin and f.data.pin.step) then pins = pins + 1 end
	end
	return { pins = pins, areas = #P.GetWorldFrames("areas"), hulls = #P.GetWorldFrames("hulls"),
		way = #P.GetTrailFrames("world") + lines, labels = labels, tiles = tiles(WorldMapFrame) }
end

local r = {}
m.showMap(9100)                                      -- the continent: its zones' levels
m.cursor = { 0.4, 0.3 }
stub.advance(0.5)
r.continent = drawn()
r.bar = stub.frame("PolestarMapInfo").Zone:GetText()
m.showMap(9000)                                      -- the zone
stub.advance(0.5)
r.zone = drawn()
local mark
for _, f in ipairs(P.GetWorldFrames("pins")) do
	if f.data.pin.tooltip == "A mark" then mark = f end
end
stub.RunScript(mark, "OnEnter")
r.tip = GameTooltip.lines[1]
stub.fire("GLOBAL_MOUSE_DOWN", "LeftButton")
stub.fire("GLOBAL_MOUSE_UP", "LeftButton")
stub.RunScript(mark, "OnLeave")
r.clicked = clicked
if C_InputInterfaceStyle.GetCurrentStyle() == Enum.InputDeviceInterfaceType.Gamepad then
	-- The gamepad's map cursor on the mark (the canvas's top left on screen at
	-- (0, 1000): map (30, 30) at (300, 700)), then A.
	clicked = nil
	SoftCursor:Show()
	SoftCursor.x, SoftCursor.y = 300, 700
	stub.runMapFrame(WorldMapFrame, 0.06)
	r.padTip = GameTooltip:IsShown() and GameTooltip.lines[1]
	stub.keysDown.PAD1 = true
	stub.runMapFrame(WorldMapFrame, 0.01)
	stub.keysDown.PAD1 = false
	r.padClicked = clicked
	SoftCursor:Hide()
end
m.canvasScale, WorldMapFrame.ScrollContainer.zoomPercent = 2, 1
stub.runMapFrame(WorldMapFrame, 0)                   -- zoomed in
r.markScale = mark:GetScale()
stub.inCombat = true
P.SetLayer("test.more", { { map = 9000, x = 10, y = 10 }, { map = 9000, x = 90, y = 90 } })
stub.runMapFrame(WorldMapFrame, 0)
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
stub.fire("MAP_EXPLORATION_UPDATED")
r.later = drawn()
stub.addonLoaded("Blizzard_BattlefieldMap")
BattlefieldMapFrame:Show()
stub.runMapFrame(BattlefieldMapFrame, 0)
BattlefieldMapFrame.globalAlpha = 0.5                -- its opacity slider
stub.runMapFrame(BattlefieldMapFrame, 0)
r.battlefield = tiles(BattlefieldMapFrame)
WorldMapFrame:Hide()
BattlefieldMapFrame:Hide()
stub.advance(0.5)
WorldMapFrame:Show()
stub.runMapFrame(WorldMapFrame, 0)
r.reopened = drawn()

local reads = {}
for label, keys in pairs(stub.mapReads) do
	local list = {}
	for k in pairs(keys) do list[#list + 1] = tostring(k) end
	table.sort(list)
	reads[label] = list
end
emit({ r = r, writes = table.concat(stub.mapWrites, "; "), under = table.concat(stub.underGameFrames, "; "), reads = reads })
`;

function run(style) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_maps.lua'],
		before: BEFORE(style),
		addons: [{ name: 'Polestar', files: FILES }],
		login: true,
		script: SCRIPT,
	}).emitted[0];
}

// What Polestar may call or read on a map frame: Blizzard_MapCanvas getters
// that return a field or work one out (Blizzard_MapCanvas.lua,
// MapCanvas_ScrollContainerMixin.lua, MapCanvas_PinFrameLevelsManager.lua),
// and the client's own frame methods, all reads. The one call that hands the
// map something is Nav/Journey.lua's AddCanvasClickHandler: the map keeps
// such handlers in Blizzard_MapCanvasSecureUtil's registry, a table of its own
// read and called only through securecallfunction, as it is meant for addons.
const READS = {
	WorldMapFrame: ['AddCanvasClickHandler', 'GetCanvas', 'GetCanvasScale', 'GetCanvasZoomPercent', 'GetGlobalAlpha', 'GetGlobalPinScale', 'GetMapID',
		'GetNormalizedCursorPosition', 'GetPinFrameLevelsManager', 'HasZoomLevels', 'IsCanvasMouseFocus', 'IsShown', 'ScrollContainer'],
	'WorldMapFrame.ScrollContainer': ['GetFrameLevel'],
	'WorldMapFrame.canvas': ['GetHeight', 'GetWidth'],
	'WorldMapFrame.pinFrameLevelsManager': ['GetValidFrameLevel'],
	BattlefieldMapFrame: ['GetCanvas', 'GetCanvasScale', 'GetCanvasZoomPercent', 'GetGlobalAlpha', 'GetGlobalPinScale', 'GetMapID',
		'GetPinFrameLevelsManager', 'HasZoomLevels'],
	'BattlefieldMapFrame.canvas': ['GetHeight', 'GetWidth'],
	'BattlefieldMapFrame.pinFrameLevelsManager': ['GetValidFrameLevel'],
};

for (const style of ['keyboard and mouse', 'gamepad']) {
	test(`with the ${style} interface every drawing shows on the world and battlefield maps, and the maps are only read`, () => {
		const { r, writes, under, reads } = run(style === 'gamepad' ? 'gamepad' : 'mkb');
		assert.equal(writes, '', 'nothing written into the maps');
		assert.equal(under, '', 'every frame on the maps and the minimap is made with no parent, then set under it');
		assert.deepEqual({ ...r.continent, way: r.continent.way > 0 }, { pins: 2, areas: 1, hulls: 1, way: true, labels: 1, tiles: 0 },
			"the continent: its zones' levels, and the zone's pins, area, region and the way to the target");
		assert.equal(r.bar, 'Testshire  10–20', 'the info bar: the zone under the cursor');
		assert.deepEqual(r.zone, { pins: 2, areas: 1, hulls: 1, way: r.zone.way, labels: 0, tiles: 3 }, 'the zone: the mark and the target, its area and region, the unexplored tiles');
		assert.ok(r.zone.way > 0, 'the way to the target');
		assert.equal(r.tip, 'A mark');
		assert.equal(r.clicked, 'LeftButton');
		if (style === 'gamepad') assert.deepEqual([r.padTip, r.padClicked], ['A mark', 'LeftButton'], "the gamepad's map cursor and A");
		assert.ok(Math.abs(r.markScale - 1.25 / 2) < 1e-9, 'zoomed in: counter-scaled, a quarter larger on screen');
		assert.equal(r.later.pins, 4, 'pins drawn in combat');
		assert.equal(r.battlefield, 3, 'the battlefield map shows the unexplored tiles too');
		assert.deepEqual({ ...r.reopened, way: 0 }, { pins: 4, areas: 1, hulls: 1, way: 0, labels: 0, tiles: 3 }, 'drawn again as the map reopens');
		const expected = { ...READS };
		// The gamepad's map cursor: the pins' place on screen from the canvas's;
		// no canvas click handler (the gamepad clicks with A, Core/Init.lua's GamepadUI).
		if (style === 'gamepad') {
			expected['WorldMapFrame.canvas'] = ['GetEffectiveScale', 'GetHeight', 'GetLeft', 'GetTop', 'GetWidth'];
			expected.WorldMapFrame = READS.WorldMapFrame.filter((k) => k !== 'AddCanvasClickHandler');
		}
		assert.deepEqual(reads, expected, 'what Polestar reads on the maps');
	});
}

// The view fires every frame the map is open: a listener that errors would
// raise an error a frame, a stream of error popups that stalls the client.
// It is reported once and left out until the map opens again; the others
// keep drawing.
test('a map listener that errors is reported once, left out until the map reopens, and the others keep their ticks', () => {
	const r = runAddon({
		stubs: ['stub_world.lua', 'stub_maps.lua'],
		before: BEFORE('gamepad'),
		addons: [{ name: 'Polestar', files: FILES }],
		login: true,
		script: `
local reported, broken, fine = 0, 0, 0
geterrorhandler = function() return function() reported = reported + 1 end end
Polestar.MapCanvas.Watch(WorldMapFrame, function(_, what)
	if what == "tick" then broken = broken + 1; error("boom") end
end)
Polestar.MapCanvas.Watch(WorldMapFrame, function(_, what) if what == "tick" then fine = fine + 1 end end)
stub.maps.showMap(9000)
for _ = 1, 5 do stub.runMapFrame(WorldMapFrame, 0.01) end
local open = { reported = reported, broken = broken, fine = fine }
WorldMapFrame:Hide()
stub.advance(0.1)
WorldMapFrame:Show()
for _ = 1, 3 do stub.runMapFrame(WorldMapFrame, 0.01) end
emit({ open = open, reported = reported, broken = broken, fine = fine })
`,
	}).emitted[0];
	assert.equal(r.open.reported, 1, 'one report while the map stays open');
	assert.equal(r.open.broken, 1, 'the erroring listener is not called again while the map stays open');
	assert.ok(r.open.fine >= 5, 'the other listener ticks every frame');
	assert.equal(r.reported, 2, 'called again, and reported again, once the map reopens');
});
