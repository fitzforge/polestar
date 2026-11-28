//! Polestar on Blizzard's map frames (addon/Polestar/Nav/MapCanvas.lua): the world map and the battlefield map
//! are only read. With the keyboard and mouse interface and with the gamepad one, every drawing Polestar makes on
//! them shows (Nav's pins, areas, regions and trail; Maps' zone levels, info bar, route lines and unexplored
//! areas), and no code of the addon writes into the maps' tables: in game a value it wrote there taints the
//! gamepad interface's secure code, and the game blocks its protected calls as the map opens and closes ("An
//! action was blocked because of taint from Polestar - SetPreferredGamepadInteractTarget()"). stub.guardMap
//! (tests/lua/wow_stub.lua) makes such a write fail and lists what the addon reads. Nor does the addon call
//! CreateFrame with a parent on the maps (or the minimap): the gamepad interface hooks it and rebuilds the open
//! map's buttons in the caller's code, tainted (wow_stub.lua's stub.underGameFrames). Core, Theme, Nav, Maps and
//! UI against stub_world.lua + stub_maps.lua.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 5] = ["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Maps/Maps.xml", "UI/UI.xml"];

// Zone 9000 in continent 9100 (stub_maps.lua's map canvas). Zone 9000 shows art 9001 with two unexplored
// overlays (three tiles); the battlefield map exists before Blizzard_BattlefieldMap reports it loaded, as in the
// client.
const BEFORE: &str = r#"
stub.maps.useWorld(); stub.maps.withMapCanvas(); stub.maps.place(0, 800)
Enum.InputDeviceInterfaceType.Mkb, Enum.InputDeviceInterfaceType.Gamepad = 0, 1
C_InputInterfaceStyle = { GetCurrentStyle = function() return @STYLE@ end }
BattlefieldMapFrame = stub.newMapCanvas("BattlefieldMapFrame")
BattlefieldMapFrame.mapID = 9000
stub.guardMap(BattlefieldMapFrame)
"#;

fn before(style: &str) -> String {
	BEFORE.replace("@STYLE@", if style == "gamepad" { "1" } else { "0" })
}

const SCRIPT: &str = r#"
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
Polestar.Set("nav.navRouting", false) -- Draw the direct way to the mark on both canvases.

local clicked
P.SetLayer("test.marks", {
	{ map = 9000, x = 30, y = 30, area = 60, tooltip = "A mark", onClick = function(button) clicked = button end },
	{ c = 0, wx = 0, wy = 0, hull = { 100, 0, 0, 150, -100, 0, 0, -150 }, areaOnly = true },
})
N.SetTarget(9000, 70, 60, "Somewhere")

-- Polestar's frames under a canvas, at any depth (the map's view frame holds the drawings).
local function under(f, canvas)
	local p = f.parent
	while p do
		if p == canvas then return true end
		p = p.parent
	end
	return false
end
local function tiles(map)
	local n, canvas = 0, map:GetCanvas()
	for _, f in ipairs(stub.frames) do
		if under(f, canvas) then
			for _, t in ipairs(f.regions or {}) do
				if type(t.texture) == "number" and t.texture >= 501 and t.texture <= 503 and t:IsShown() and f:IsVisible() then n = n + 1 end
			end
		end
	end
	return n
end
local function drawn()
	local labels = 0
	for _, f in ipairs(stub.frames) do
		if under(f, m.canvas) and rawget(f, "Range") and f:IsVisible() then labels = labels + 1 end
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
"#;

fn run(style: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_maps.lua"],
		before: before(style),
		addons: vec![Addon::files("Polestar", &FILES)],
		login: true,
		script: script.into(),
		..Default::default()
	})
	.remove(0)
}

// What Polestar may call or read on a map frame: Blizzard_MapCanvas getters that return a field or work one out
// (Blizzard_MapCanvas.lua, MapCanvas_ScrollContainerMixin.lua, MapCanvas_PinFrameLevelsManager.lua), and the
// client's own frame methods, all reads. The one call that hands the map something is Nav/Journey.lua's
// AddCanvasClickHandler: the map keeps such handlers in Blizzard_MapCanvasSecureUtil's registry, a table of its
// own read and called only through securecallfunction, as it is meant for addons. Nav/Pins.lua's viewRect reads
// where the scroll frame (the canvas's parent) and the canvas sit on screen (GetParent, GetLeft, GetTop,
// GetRight, GetBottom, GetEffectiveScale) to draw the objective areas only around what the view shows (#1622).
// Maps/WorldMap.lua's info bar lists the map's own child frames (GetChildren) to keep its text clear of the buttons
// in the view's bottom corners, reading only their size, place and visibility, again only when the scroll frame's
// size (GetSize) changed.
fn reads() -> Value {
	json!({
		"WorldMapFrame": ["AddCanvasClickHandler", "GetCanvas", "GetCanvasScale", "GetCanvasZoomPercent", "GetChildren", "GetGlobalAlpha", "GetGlobalPinScale", "GetMapID",
			"GetNormalizedCursorPosition", "GetPinFrameLevelsManager", "HasZoomLevels", "IsCanvasMouseFocus", "IsShown", "ScrollContainer"],
		"WorldMapFrame.ScrollContainer": ["GetBottom", "GetEffectiveScale", "GetFrameLevel", "GetLeft", "GetRight", "GetSize", "GetTop"],
		"WorldMapFrame.canvas": ["GetEffectiveScale", "GetHeight", "GetLeft", "GetParent", "GetTop", "GetWidth"],
		"WorldMapFrame.pinFrameLevelsManager": ["GetValidFrameLevel"],
		"BattlefieldMapFrame": ["GetCanvas", "GetCanvasScale", "GetCanvasZoomPercent", "GetGlobalAlpha", "GetGlobalPinScale", "GetMapID",
			"GetPinFrameLevelsManager", "HasZoomLevels"],
		"BattlefieldMapFrame.canvas": ["GetHeight", "GetWidth"],
		"BattlefieldMapFrame.pinFrameLevelsManager": ["GetValidFrameLevel"],
	})
}

fn check(style: &str) {
	let gamepad = style == "gamepad";
	let out = run(if gamepad { "gamepad" } else { "mkb" }, SCRIPT);
	let r = &out["r"];
	assert_eq!(out["writes"], "", "nothing written into the maps");
	assert_eq!(out["under"], "", "every frame on the maps and the minimap is made with no parent, then set under it");
	let mut continent = r["continent"].clone();
	continent["way"] = json!(r["continent"]["way"].as_f64().unwrap() > 0.0);
	assert_eq!(
		continent,
		json!({ "pins": 2, "areas": 1, "hulls": 1, "way": true, "labels": 1, "tiles": 0 }),
		"the continent: its zones' levels, and the zone's pins, area, region and the way to the target"
	);
	assert_eq!(r["bar"], "Testshire  10\u{2013}20", "the info bar: the zone under the cursor");
	assert_eq!(
		r["zone"],
		json!({ "pins": 2, "areas": 1, "hulls": 1, "way": r["zone"]["way"], "labels": 0, "tiles": 3 }),
		"the zone: the mark and the target, its area and region, the unexplored tiles"
	);
	assert!(r["zone"]["way"].as_f64().unwrap() > 0.0, "the way to the target");
	assert_eq!(r["tip"], "A mark");
	assert_eq!(r["clicked"], "LeftButton");
	if gamepad {
		assert_eq!(json!([r["padTip"], r["padClicked"]]), json!(["A mark", "LeftButton"]), "the gamepad's map cursor and A");
	}
	assert!((r["markScale"].as_f64().unwrap() - 0.9 / 2.0).abs() < 1e-9, "zoomed in: counter-scaled, at 0.9 of its size on screen");
	assert_eq!(r["later"]["pins"], 4, "pins drawn in combat");
	assert_eq!(r["battlefield"], 3, "the battlefield map shows the unexplored tiles too");
	let mut reopened = r["reopened"].clone();
	reopened["way"] = json!(0);
	assert_eq!(reopened, json!({ "pins": 4, "areas": 1, "hulls": 1, "way": 0, "labels": 0, "tiles": 3 }), "drawn again as the map reopens");
	let mut expected = reads();
	// No canvas click handler with the gamepad (it clicks with A, Core/Init.lua's GamepadUI); its map cursor reads
	// the canvas's place on screen, as viewRect does.
	if gamepad {
		let list: Vec<Value> = expected["WorldMapFrame"].as_array().unwrap().iter().filter(|k| k.as_str() != Some("AddCanvasClickHandler")).cloned().collect();
		expected["WorldMapFrame"] = Value::Array(list);
	}
	assert_eq!(out["reads"], expected, "what Polestar reads on the maps");
}

#[test]
fn with_the_keyboard_and_mouse_interface_every_drawing_shows_on_the_world_and_battlefield_maps_and_the_maps_are_only_read() {
	check("keyboard and mouse");
}

#[test]
fn with_the_gamepad_interface_every_drawing_shows_on_the_world_and_battlefield_maps_and_the_maps_are_only_read() {
	check("gamepad");
}

// The view fires every frame the map is open: a listener that errors would raise an error a frame, a stream of
// error popups that stalls the client. It is reported once and left out until the map opens again; the others
// keep drawing.
#[test]
fn a_map_listener_that_errors_is_reported_once_left_out_until_the_map_reopens_and_the_others_keep_their_ticks() {
	let r = run(
		"gamepad",
		r#"
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
"#,
	);
	assert_eq!(r["open"]["reported"], 1, "one report while the map stays open");
	assert_eq!(r["open"]["broken"], 1, "the erroring listener is not called again while the map stays open");
	assert!(r["open"]["fine"].as_f64().unwrap() >= 5.0, "the other listener ticks every frame");
	assert_eq!(r["reported"], 2, "called again, and reported again, once the map reopens");
}

// Another addon's map canvas (Polestar: UI's world map), handed over with MapCanvas.Add: Polestar's drawings show
// on it as on the world map, with frames of their own, it is only read, and hiding Polestar takes them off it.
#[test]
fn a_map_canvas_another_addon_adds_shows_polestars_drawings_is_only_read_and_hides_with_polestar() {
	let r = run(
		"keyboard and mouse",
		r#"
local P, M = Polestar.Pins, Polestar.MapCanvas
Polestar.Set("maps.coords", true)
P.SetLayer("test.marks", { { map = 9000, x = 30, y = 30, tooltip = "A mark" } })
local own = stub.newMapCanvas("PolestarUIWorldMapCanvas")
own.mapID = 9000
stub.guardMap(own)
M.Add(own)
M.Add(own)            -- once is enough
M.Add(WorldMapFrame)  -- the world map is watched already
own:Show()
stub.runMapFrame(own, 0.1)
local function under(f, canvas)
	local p = f.parent
	while p do
		if p == canvas then return true end
		p = p.parent
	end
	return false
end
local function marks(map)
	local n = 0
	for _, f in ipairs(stub.frames) do
		if under(f, map:GetCanvas()) and f:IsVisible() and P.WorldPinOf(f) and P.WorldPinOf(f).pin.tooltip == "A mark" then n = n + 1 end
	end
	return n
end
local shown = marks(own)
local onWorldMap = marks(WorldMapFrame)
Polestar.SetHidden(true)
local hidden = marks(own)
Polestar.SetHidden(false)
stub.runMapFrame(own, 0.1)
emit({ shown = shown, onWorldMap = onWorldMap, hidden = hidden, back = marks(own),
	writes = table.concat(stub.mapWrites, "; "), under = table.concat(stub.underGameFrames, "; ") })
"#,
	);
	assert_eq!(r["writes"], "", "nothing written into the added map");
	assert_eq!(r["under"], "", "every frame on it is made with no parent, then set under it");
	assert_eq!(r["shown"], 1, "the mark on the added map");
	assert_eq!(r["onWorldMap"], 0, "a frame of its own: the closed world map shows none");
	assert_eq!(r["hidden"], 0, "hiding Polestar takes it off");
	assert_eq!(r["back"], 1, "and shows it again");
}

// OpenMap (an optional world map addon) as its 0.8.13 draws its own views (#4206). With the game's Gamepad UI and
// its "OpenMap's map with the Gamepad UI" switch, its controller view is a frame on the world map over the scroll
// frame whose canvas, anchored by its top left on that frame's centre, is OpenMap's whole stitched world; in a fight
// its usual map moves onto a frame of its own on the scroll frame, its canvas laid out as the map's. Either way it
// makes the map's canvas see-through, so Polestar's drawings there don't show. Its API (stubbed here: zone 9000 at
// u 0.4-0.5, v 0.2-0.3 of the world, continent 9100 at u 0.2-0.7, v 0.1-0.6, as their yards place them) says
// IsStitched false in the controller view and has nothing more for either.
const OPENMAP: &str = r#"
local rects = { [9000] = { 0.4, 0.2, 0.5, 0.3 }, [9100] = { 0.2, 0.1, 0.7, 0.6 } }
OpenMapAPI = {
	major = 1, version = 4,
	IsStitched = function() return stub.omStitched == true end,
	WorldFromMap = function(id, x, y)
		local r = rects[id]
		if r then return r[1] + x * (r[3] - r[1]), r[2] + y * (r[4] - r[2]) end
	end,
	MapFromWorld = function(id, u, v)
		local r = rects[id]
		if r then return (u - r[1]) / (r[3] - r[1]), (v - r[2]) / (r[4] - r[2]) end
	end,
	MapAt = function(u, v)
		for _, id in ipairs({ 9000, 9100 }) do
			local r = rects[id]
			if u >= r[1] and u <= r[3] and v >= r[2] and v <= r[4] then return id end
		end
	end,
	ArtTopLevel = function() return 91 end,
	CanvasFromWorldPos = function() return nil end,
}
"#;

const OPENMAP_SCRIPT: &str = r#"
local P, m = Polestar.Pins, stub.maps
stub.cascadeVisibility = true
Polestar.Set("nav.navRouting", false)
local clicked
P.SetLayer("test.marks", { { map = 9000, x = 30, y = 30, tooltip = "A mark", onClick = function(button) clicked = button end } })
Polestar.Nav.SetTarget(9000, 70, 60, "Somewhere")

-- OpenMap's controller view (its PadView.lua): the stitched world 10000 x 10000 units, the view 800 x 600.
local sc = WorldMapFrame.ScrollContainer
local pad = CreateFrame("Frame", nil, WorldMapFrame)
pad:SetAllPoints(sc)
pad:SetSize(800, 600)
pad:Hide()
local padCanvas = CreateFrame("Frame", nil, pad)
padCanvas:SetSize(10000, 10000)
padCanvas:SetFrameLevel(10)
local function padAt(u, v, px)
	padCanvas:SetScale(px)
	padCanvas:ClearAllPoints()
	padCanvas:SetPoint("TOPLEFT", pad, "CENTER", -u * 10000, v * 10000)
end
-- Its view in a fight (OwnView.lua): its canvas the map canvas's size.
local own = CreateFrame("Frame", nil, sc)
own:SetAllPoints(sc)
own:SetSize(800, 600)
own:Hide()
local ownCanvas = CreateFrame("Frame", nil, own)
ownCanvas:SetSize(1000, 1000)
ownCanvas:SetPoint("TOPLEFT", own, "TOPLEFT", -100, 50)
ownCanvas:SetScale(1.5)
ownCanvas:SetFrameLevel(9201)

local function frames() for _ = 1, 3 do stub.runMapFrame(WorldMapFrame, 0.06) end end
-- On screen: shown, and no frame above it see-through.
local function onScreen(f)
	local p = f
	while p do
		if not p.shown or (p.alpha or 1) <= 0 then return false end
		p = p.parent
	end
	return true
end
local function under(f, top)
	local p = f.parent
	while p do
		if p == top then return true end
		p = p.parent
	end
	return false
end
-- What shows under `top`: the mark, the route line's strokes, and the frame the mark is placed on.
local function seen(top)
	local r = { marks = 0, lines = 0 }
	for _, f in ipairs(stub.frames) do
		if under(f, top) and onScreen(f) then
			local d = P.WorldPinOf(f)
			if d and d.pin.tooltip == "A mark" then
				r.marks = r.marks + 1
				local _, rel = f:GetPoint(1)
				r.host = rel
			end
			if type(rawget(f, "strokes")) == "table" and f.strokes.n then r.lines = r.lines + f.strokes.n end
		end
	end
	return r
end
local function place(f)
	if not f then return false end
	local point, rel, relPoint, x, y = f:GetPoint(1)
	return { point = point, onCanvas = rel == padCanvas or rel == ownCanvas, relPoint = relPoint, x = x, y = y,
		w = f:GetWidth(), h = f:GetHeight(), parent = f.parent == padCanvas and "pad" or f.parent == ownCanvas and "own" or "other",
		level = f:GetFrameLevel(), shown = f:IsShown() }
end
local function tipAt(x, y)
	GameTooltip:Hide()
	clicked = nil
	SoftCursor:Show()
	SoftCursor.x, SoftCursor.y = x, y
	stub.runMapFrame(WorldMapFrame, 0.06)
	local tip = GameTooltip:IsShown() and GameTooltip.lines[1] or false
	stub.keysDown.PAD1 = true
	stub.runMapFrame(WorldMapFrame, 0.01)
	stub.keysDown.PAD1 = false
	SoftCursor:Hide()
	stub.runMapFrame(WorldMapFrame, 0.01)
	return { tip = tip, clicked = clicked or false }
end

local r = {}
m.showMap(9000)
frames()
r.plain = seen(m.canvas)

-- The controller view opens on the zone: the zone 1000 units across at 0.8, 800 px, the whole view.
padAt(0.45, 0.25, 0.8)
m.canvas:SetAlpha(0)
pad:Show()
frames()
r.padSeen, r.blizzardSeen = seen(padCanvas), seen(m.canvas)
r.padHost = place(r.padSeen.host)
-- The gamepad's cursor: on the mark on OpenMap's view (the host's top left at (0, 1000) here, scale 0.8: map (30, 30)
-- at (240, 560)), then where the unseen mark on Blizzard's canvas is ((300, 700)).
r.padMark = tipAt(240, 560)
r.hiddenMark = tipAt(300, 700)
-- Hiding Polestar takes them off OpenMap's view too; showing it puts them back.
Polestar.SetHidden(true)
r.whileHidden = seen(padCanvas)
Polestar.SetHidden(false)
frames()
r.unhidden = seen(padCanvas).marks
-- Zoomed out: the zone 100 px across, the continent 500 of the view's 800.
padAt(0.45, 0.25, 0.1)
frames()
r.zoomedOut = place(seen(padCanvas).host)
-- OpenMap's frames only read.
local point, rel, relPoint, x, y = padCanvas:GetPoint(1)
r.padKept = { point = point, rel = rel == pad, relPoint = relPoint, x = x, y = y, scale = padCanvas:GetScale(), shown = pad:IsShown() }
-- The controller view closes (the Gamepad UI off): back on Blizzard's map.
pad:Hide()
m.canvas:SetAlpha(1)
frames()
r.padClosed = { pad = seen(padCanvas), blizzard = seen(m.canvas) }

-- A fight with OpenMap's usual map open.
stub.omStitched = true
m.canvas:SetAlpha(0)
own:Show()
frames()
r.fightSeen = seen(ownCanvas)
r.fightHost = place(r.fightSeen.host)
WorldMapFrame:Hide()
stub.advance(0.1)
r.closed = { pad = seen(padCanvas), own = seen(ownCanvas) }

emit({ r = r, writes = table.concat(stub.mapWrites, "; "), under = table.concat(stub.underGameFrames, "; ") })
"#;

fn run_openmap() -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_maps.lua"],
		before: format!("{}{OPENMAP}", before("gamepad")),
		addons: vec![Addon::files("Polestar", &FILES)],
		login: true,
		script: OPENMAP_SCRIPT.into(),
		..Default::default()
	})
	.remove(0)
}

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}

#[test]
fn openmaps_controller_view_and_its_view_in_a_fight_show_the_route_line_and_the_pins_and_take_the_gamepads_cursor() {
	let out = run_openmap();
	let r = &out["r"];
	assert_eq!(out["writes"], "", "nothing written into the maps");
	assert_eq!(out["under"], "", "every frame is made with no parent, then set under its place");
	assert_eq!(r["plain"]["marks"], 1, "Blizzard's map: the mark");
	assert!(num(&r["plain"]["lines"]) > 0.0, "Blizzard's map: the route line");

	// The controller view: Polestar's frame on OpenMap's canvas over zone 9000 (u 0.4-0.5, v 0.2-0.3 of 10000 units),
	// above OpenMap's art (its top level 91), the mark and the route line on it.
	assert_eq!(r["padSeen"]["marks"], 1, "the mark on OpenMap's controller view: {}", r["padSeen"]);
	assert!(num(&r["padSeen"]["lines"]) > 0.0, "the route line on OpenMap's controller view: {}", r["padSeen"]);
	assert_eq!(r["blizzardSeen"], json!({ "marks": 0, "lines": 0 }), "nothing shows on Blizzard's see-through canvas");
	let host = &r["padHost"];
	assert_eq!(json!([host["point"], host["onCanvas"], host["relPoint"], host["parent"], host["shown"]]), json!(["TOPLEFT", true, "TOPLEFT", "pad", true]));
	assert!((num(&host["x"]) - 4000.0).abs() < 1e-6 && (num(&host["y"]) + 2000.0).abs() < 1e-6, "at the zone's place: {host}");
	assert!((num(&host["w"]) - 1000.0).abs() < 1e-6 && (num(&host["h"]) - 1000.0).abs() < 1e-6, "the zone's size: {host}");
	assert!(num(&host["level"]) > 91.0, "over OpenMap's art");
	assert_eq!(r["padMark"], json!({ "tip": "A mark", "clicked": "LeftButton" }), "the gamepad's cursor and A on the mark there");
	assert_eq!(r["hiddenMark"], json!({ "tip": false, "clicked": false }), "the unseen mark under OpenMap's view takes neither");
	assert_eq!(r["whileHidden"], json!({ "marks": 0, "lines": 0 }), "hidden with Polestar");
	assert_eq!(r["unhidden"], 1, "and back");
	let out_host = &r["zoomedOut"];
	assert!((num(&out_host["x"]) - 2000.0).abs() < 1e-6 && (num(&out_host["w"]) - 5000.0).abs() < 1e-6, "zoomed out: the continent, the zone too small to fill the view: {out_host}");
	let kept = &r["padKept"];
	assert_eq!(json!([kept["point"], kept["rel"], kept["relPoint"], kept["shown"]]), json!(["TOPLEFT", true, "CENTER", true]), "OpenMap's frames are only read");
	assert!(num(&kept["x"]) == -4500.0 && num(&kept["y"]) == 2500.0 && (num(&kept["scale"]) - 0.1).abs() < 1e-12, "OpenMap's canvas where it put it: {kept}");
	assert_eq!(r["padClosed"]["pad"], json!({ "marks": 0, "lines": 0 }), "the controller view closed: nothing left on it");
	assert_eq!(r["padClosed"]["blizzard"]["marks"], 1, "and Blizzard's map shows the mark again");

	// In a fight: Polestar's frame over all of OpenMap's canvas, laid out as the map's.
	assert_eq!(r["fightSeen"]["marks"], 1, "the mark on OpenMap's view in a fight: {}", r["fightSeen"]);
	assert!(num(&r["fightSeen"]["lines"]) > 0.0, "the route line there");
	let fight = &r["fightHost"];
	let at: Vec<f64> = ["x", "y", "w", "h"].iter().map(|k| num(&fight[*k])).collect();
	assert_eq!((at, &fight["parent"]), (vec![0.0, 0.0, 1000.0, 1000.0], &json!("own")), "over all of OpenMap's canvas");
	assert!(num(&fight["level"]) > 9201.0 + 80.0, "over OpenMap's art lifted onto its canvas");
	assert_eq!(r["closed"], json!({ "pad": { "marks": 0, "lines": 0 }, "own": { "marks": 0, "lines": 0 } }), "the map closed");
}
