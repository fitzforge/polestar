'use strict';
// Maps: the world map without fog of war
// (Maps/Reveal.lua: overlay selection, the tiles on the canvas, tint, the
// art guard, cost while off), coordinate formatting and the minimap readout
// (Maps/Coords.lua), and dungeon entrance pins (Maps/Dungeons.lua).
// Core, Theme, Nav, Maps and UI (for UI.ZoneArt's overlay table) run against
// stub_world.lua + stub_maps.lua with the map canvas stub.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Maps/Maps.xml', 'UI/UI.xml'];

// Zone 9000 shows art 9001 (one 1002 x 668 layer of 256px tiles); the table
// holds three overlays: a 300 x 200 one at (600, 100) (two tiles, the second
// 44 wide), a 100 x 100 one at (50, 300) and a 64 x 64 one at (0, 0).
const SETUP = `
local M, m = Polestar.Maps, stub.maps
C_Map.GetMapArtLayers = function(id)
	if id == 9000 then return { { layerWidth = 1002, layerHeight = 668, tileWidth = 256, tileHeight = 256 } } end
	return {}
end
ART = 9001
C_Map.GetMapArtID = function(id) return id == 9000 and ART or nil end
EXPLORED = {}
C_MapExplorationInfo = { GetExploredMapTextures = function() return EXPLORED end }
Polestar.UI.ZoneArt.RegisterOverlays("test", { [9001] = { 256, 256,
	{ 300, 200, 600, 100, 501, 502 },
	{ 100, 100, 50, 300, 503 },
	{ 64, 64, 0, 0, 504 },
} })
-- Every shown texture under a Polestar frame on the canvas.
function revealed()
	local out = {}
	for _, f in ipairs(stub.frames) do
		if f.parent == m.canvas and f.regions and f:IsShown() then
			for _, t in ipairs(f.regions) do
				if t.IsShown and t:IsShown() and t.texture then
					local p = t.points[1]
					out[#out + 1] = { file = t:GetTexture(), x = p.x, y = p.y, w = t:GetWidth(), h = t:GetHeight(),
						tc = t.texCoord, vc = t.vertexColor, layer = t.layer }
				end
			end
		end
	end
	table.sort(out, function(a, b) return a.file < b.file end)
	return out
end
-- Frames of Polestar's on the canvas.
function frameCount()
	return #m.canvas.children
end
`;

function run(script, { before = '', saved } = {}) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_maps.lua'],
		before: `stub.maps.useWorld(); stub.maps.withMapCanvas(); stub.maps.place(0, 800); ${before}`,
		addons: [{ name: 'Polestar', files: FILES }],
		saved,
		login: true,
		script: SETUP + script,
	}).emitted;
}

const files = (list) => list.map((t) => t.file);

// ---------------------------------------------------------------------------
// Overlay selection
// ---------------------------------------------------------------------------

test('unexplored = every overlay of the art minus the explored ones, matched on offset and size', () => {
	const [out] = run(`
		local art = Polestar.UI.ZoneArt.overlays[9001]
		local function ids(list) local t = {}; for i, o in ipairs(list) do t[i] = o[5] end; return t end
		local none = ids(M.UnexploredOverlays(art, nil))
		local empty = ids(M.UnexploredOverlays(art, {}))
		local one = ids(M.UnexploredOverlays(art, {
			{ textureWidth = 100, textureHeight = 100, offsetX = 50, offsetY = 300, isShownByMouseOver = false, fileDataIDs = { 503 } },
		}))
		-- Same offset, other size: a different overlay, not a match.
		local near = ids(M.UnexploredOverlays(art, {
			{ textureWidth = 101, textureHeight = 100, offsetX = 50, offsetY = 300, isShownByMouseOver = false, fileDataIDs = { 9 } },
		}))
		-- An explored overlay the client shows only on mouse-over stays the
		-- client's: never painted permanently here.
		local hover = ids(M.UnexploredOverlays(art, {
			{ textureWidth = 300, textureHeight = 200, offsetX = 600, offsetY = 100, isShownByMouseOver = true, fileDataIDs = { 501, 502 } },
		}))
		local reused = {}
		M.UnexploredOverlays(art, nil, reused)
		M.UnexploredOverlays(art, { { textureWidth = 64, textureHeight = 64, offsetX = 0, offsetY = 0 } }, reused)
		emit({ none = none, empty = empty, one = one, near = near, hover = hover, reused = ids(reused),
			bad = #M.UnexploredOverlays(nil, {}) })`);
	assert.deepEqual(out.none, [501, 503, 504]);
	assert.deepEqual(out.empty, [501, 503, 504]);
	assert.deepEqual(out.one, [501, 504]);
	assert.deepEqual(out.near, [501, 503, 504]);
	assert.deepEqual(out.hover, [503, 504], 'a hover-only explored overlay is not drawn by the reveal');
	assert.deepEqual(out.reused, [501, 503], 'a reused list is cleared first');
	assert.equal(out.bad, 0);
});

// ---------------------------------------------------------------------------
// The tiles on the canvas
// ---------------------------------------------------------------------------

test('the world map shows unexplored overlays tinted, split into tiles as Blizzard splits them', () => {
	const [out] = run(`
		EXPLORED = { { textureWidth = 64, textureHeight = 64, offsetX = 0, offsetY = 0, isShownByMouseOver = false, fileDataIDs = { 504 } } }
		m.showMap(9000)
		local tint = revealed()
		local r, g, b = Polestar.Theme.Color("mapUnexplored")
		Polestar.Set("maps.reveal", "on")
		local plain = revealed()
		-- Exploring an area: the client fires MAP_EXPLORATION_UPDATED.
		table.insert(EXPLORED, { textureWidth = 100, textureHeight = 100, offsetX = 50, offsetY = 300, isShownByMouseOver = false, fileDataIDs = { 503 } })
		stub.fire("MAP_EXPLORATION_UPDATED")
		local after = revealed()
		emit({ tint = tint, plain = plain, after = after, color = { r, g, b } })`);
	assert.deepEqual(files(out.tint), [501, 502, 503], 'the explored overlay 504 is the client\'s');
	const [a, b, c] = out.tint;
	// Canvas units are layer pixels: tile 1 at (600, -100) 256 x 200; tile 2
	// the 44-wide remainder, from a 64-wide file; the 100 x 100 overlay from a 128 file.
	assert.deepEqual([a.x, a.y, a.w, a.h], [600, -100, 256, 200]);
	assert.deepEqual([b.x, b.y, b.w, b.h], [856, -100, 44, 200]);
	assert.deepEqual(b.tc, [0, 44 / 64, 0, 200 / 256]);
	assert.deepEqual([c.x, c.y, c.w, c.h], [50, -300, 100, 100]);
	assert.deepEqual(c.tc, [0, 100 / 128, 0, 100 / 128]);
	assert.equal(a.layer, 'ARTWORK');
	assert.deepEqual(a.vc, [...out.color, 1], 'tinted with the theme token');
	assert.deepEqual(out.plain[0].vc, [1, 1, 1, 1], '"on" reveals untinted');
	assert.deepEqual(files(out.after), [501, 502]);
});

test('off costs nothing: no frames, until it is turned on; a map whose art differs is left alone', () => {
	const [out] = run(`
		local before = frameCount()
		m.showMap(9000)
		local offShown = { #revealed(), frameCount() }
		Polestar.Set("maps.reveal", "tint")
		local on = frameCount()
		local shown = #revealed()
		Polestar.Set("maps.reveal", "off")
		local cleared = #revealed()
		Polestar.Set("maps.reveal", "tint")
		ART = 7777 -- the client shows other art than the table was built for
		WorldMapFrame:Hide()
		m.showMap(9000)
		emit({ before = before, offShown = offShown, on = on, shown = shown, cleared = cleared, other = #revealed() })`,
	{ saved: { Polestar: 'PolestarDB = { schema = 1, settings = { maps = { reveal = "off" } } }' } });
	assert.deepEqual(out.offShown, [0, out.before]);
	assert.equal(out.on, out.before + 1, 'its frame is made when the reveal is first turned on');
	assert.equal(out.shown, 4);
	assert.equal(out.cleared, 0);
	assert.equal(out.other, 0, 'the art guard keeps a stale table off the map');
});

// ---------------------------------------------------------------------------
// Coordinates
// ---------------------------------------------------------------------------

test('coordinates format to one decimal, rounded half up on the tenth; no position is a dash', () => {
	const [out] = run(`
		emit({
			M.FormatCoords(42.04, 30),
			M.FormatCoords(42.06, 30.04),
			M.FormatCoords(0, 100),
			M.FormatCoords(99.96, 0.04),
			M.FormatCoords(nil, 5),
			M.FormatCoords(),
		})`);
	assert.deepEqual(out, ['42.0, 30.0', '42.1, 30.0', '0.0, 100.0', '100.0, 0.0', '—', '—']);
});

test('the minimap readout exists only once turned on, follows the player and blanks without a position', () => {
	const [out] = run(`
		local before = stub.frame("PolestarMinimapCoords")
		Polestar.Set("maps.minimapCoords", true)
		local f = stub.frame("PolestarMinimapCoords")
		local first = f.Text:GetText()
		m.place(0, 600) -- 10 map percent further on
		stub.advance(0.3)
		local moved = f.Text:GetText()
		local getPos = Polestar.Compat.GetPlayerMapPosition
		Polestar.Compat.GetPlayerMapPosition = function() return nil end
		stub.advance(0.3)
		local none = f.Text:GetText()
		Polestar.Compat.GetPlayerMapPosition = getPos
		Polestar.Set("maps.minimapCoords", false)
		emit({ before = before ~= nil, first = first, moved = moved, none = none, hidden = not f:IsShown() })`);
	assert.equal(out.before, false, 'no frame while off');
	assert.equal(out.first, '10.0, 50.0');
	assert.equal(out.moved, '20.0, 50.0');
	assert.equal(out.none, '');
	assert.equal(out.hidden, true);
});

test('the minimap button exists only once turned on: click shows or hides the guide, right-click opens settings, drag moves it around the edge', () => {
	const [out] = run(`
		local fired = {}
		Polestar.On("TOGGLE_FRAME", function() fired[#fired + 1] = "toggle" end)
		Polestar.On("SHOW_OPTIONS", function() fired[#fired + 1] = "options" end)
		local before = stub.frame("PolestarMinimapButton")
		Polestar.Set("maps.minimapButton", true)
		local b = stub.frame("PolestarMinimapButton")
		local function at() local _, rel, _, x, y = b:GetPoint(1); return { rel == Minimap, math.floor(x + 0.5), math.floor(y + 0.5) } end
		local start = at()
		b:Click("LeftButton")
		b:Click("RightButton")
		-- Drag to the right of the minimap's centre (70, 70): east, 0 degrees.
		stub.cursor = { 200, 70 }
		b:GetScript("OnDragStart")(b)
		b:GetScript("OnUpdate")(b, 0.01)
		local dragging = at()
		b:GetScript("OnDragStop")(b)
		local saved, stopped = Polestar.Get("maps.minimapButtonAngle"), b:GetScript("OnUpdate") == nil
		-- A square minimap: straight up rides the square's top edge.
		GetMinimapShape = function() return "SQUARE" end
		Polestar.Set("maps.minimapButtonAngle", 45)
		local corner = at()
		-- The minimap resized (Edit Mode): the button stays on the new edge.
		GetMinimapShape = nil
		Polestar.Set("maps.minimapButtonAngle", 0)
		Minimap:SetSize(280, 280)
		stub.RunScript(Minimap, "OnSizeChanged", 280, 280)
		local resized = at()
		Polestar.Set("maps.minimapButton", false)
		emit({ before = before ~= nil, start = start, fired = fired, dragging = dragging, saved = saved, stopped = stopped,
			corner = corner, resized = resized, hidden = not b:IsShown() })`);
	assert.equal(out.before, false, 'no frame while off');
	// 225 degrees (south-west) at 70 + 5 px from the centre.
	assert.deepEqual(out.start, [true, -53, -53]);
	assert.deepEqual(out.fired, ['toggle', 'options']);
	assert.deepEqual(out.dragging, [true, 75, 0]);
	assert.equal(out.saved, 0);
	assert.equal(out.stopped, true);
	assert.deepEqual(out.corner, [true, 75, 75], 'the square\'s corner, not the circle');
	assert.deepEqual(out.resized, [true, 145, 0], 'on the edge of the resized minimap');
	assert.equal(out.hidden, true);
});

// ---------------------------------------------------------------------------
// Dungeon entrances
// ---------------------------------------------------------------------------

const CODEX = `
CODEX_LOADS = 0
local recs = {
	deadmines = { key = "deadmines", name = "The Deadmines", kind = "dungeon", levels = { 10, 17, 26 }, entrance = { map = 9000, x = 42.5, y = 71.7 } },
	["hall-of-thanes"] = { key = "hall-of-thanes", name = "Hall of Thanes", kind = "dungeon", levels = { 10, 13, 18 }, entrance = { map = 9000, x = 10, y = 20 } },
	molten = { key = "molten", name = "Molten Core", kind = "raid", levels = { 60, 60, 60 } }, -- no entrance known
}
local loaded = false
Polestar.Codex = {
	IsLoaded = function() return loaded end,
	Load = function() CODEX_LOADS = CODEX_LOADS + 1; loaded = true; Polestar.Fire("CODEX_LOADED", {}); return true end,
	Each = function(kind, fn) if kind == "instance" then for k, r in pairs(recs) do fn(k, r.name) end end end,
	Instance = function(k) return recs[k] end,
}
`;
const DUNGEON_PINS = { saved: { Polestar: 'PolestarDB = { schema = 1, settings = { maps = { dungeonPins = true } } }' } };

test('dungeon pins: the Codex loads only when the world map opens, one pin per known entrance', () => {
	const [out] = run(CODEX + `
		local P = Polestar.Pins
		local atLogin = { loads = CODEX_LOADS, layer = P.GetLayer("maps.dungeons") ~= nil }
		WorldMapFrame:Hide()
		m.showMap(9000)
		local layer = P.GetLayer("maps.dungeons")
		local keys = {}
		for _, p in ipairs(layer) do keys[#keys + 1] = p.key .. "@" .. p.x .. "," .. p.y .. ":" .. p.icon end
		local r, g, b = Polestar.Theme.Color("dungeon")
		local color = layer[1].color[1] == r and layer[1].color[2] == g and layer[1].color[3] == b
		Polestar.Set("maps.dungeonPins", false)
		local off = P.GetLayer("maps.dungeons") == nil
		emit({ atLogin = atLogin, loads = CODEX_LOADS, keys = keys, color = color, off = off })`, DUNGEON_PINS);
	assert.deepEqual(out.atLogin, { loads: 0, layer: false }, 'nothing loads at login');
	assert.equal(out.loads, 1);
	assert.deepEqual(out.keys, ['deadmines@42.5,71.7:icon-dungeon', 'hall-of-thanes@10,20:icon-dungeon']);
	assert.equal(out.color, true);
	assert.equal(out.off, true);
});

test('with dungeon pins off the world map opening never loads the Codex', () => {
	const [out] = run(CODEX + `
		Polestar.Set("maps.dungeonPins", false)
		WorldMapFrame:Hide()
		m.showMap(9000)
		emit({ loads = CODEX_LOADS })`);
	assert.equal(out.loads, 0);
});

test('a dungeon pin opens its dungeon page; without the Dungeons module, or with Shift, it sets a waypoint', () => {
	const [out] = run(CODEX + `
		Polestar.Codex.Load()
		local opened = {}
		Polestar.Dungeons = { IsEnabled = function() return true end, Open = function(key) opened[#opened + 1] = key; return true end }
		local targets = {}
		Polestar.Nav.SetTarget = function(map, x, y, label) targets[#targets + 1] = label .. "@" .. map .. ":" .. x .. "," .. y end
		Polestar.Maps.RefreshDungeonPins()
		local byKey = {}
		for _, p in ipairs(Polestar.Pins.GetLayer("maps.dungeons")) do byKey[p.key] = p end
		local dm, hot = byKey.deadmines, byKey["hall-of-thanes"]
		local tip = {}
		local t = {}
		function t:SetText(s) tip[#tip + 1] = s end
		function t:AddLine(s) tip[#tip + 1] = s end
		dm.tooltip(t)
		dm.onClick("LeftButton")
		hot.onClick("LeftButton")
		stub.keys.shift = true
		dm.onClick("LeftButton")
		stub.keys.shift = false
		Polestar.Dungeons = nil
		Polestar.Maps.RefreshDungeonPins()
		for _, p in ipairs(Polestar.Pins.GetLayer("maps.dungeons")) do if p.key == "deadmines" then p.onClick("LeftButton") end end
		emit({ page = dm.page, opened = opened, targets = targets, tip = tip })`, DUNGEON_PINS);
	assert.equal(out.page, true);
	assert.deepEqual(out.opened, ['deadmines', 'hall-of-thanes']);
	assert.deepEqual(out.targets, ['The Deadmines@9000:42.5,71.7', 'The Deadmines@9000:42.5,71.7']);
	assert.deepEqual(out.tip, ['The Deadmines', 'Dungeon · Levels 17–26', ' ', 'Click to open its page', 'Shift-click to set a waypoint']);
});
