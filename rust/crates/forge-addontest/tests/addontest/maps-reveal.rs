//! Maps: the world map without fog of war (Maps/Reveal.lua: overlay selection, the tiles on the canvas, tint, the
//! art guard, cost while off), coordinate formatting and the minimap readout (Maps/Coords.lua), and dungeon
//! entrance pins (Maps/Dungeons.lua). Core, Theme, Nav, Maps and UI (for UI.ZoneArt's overlay table) run against
//! stub_world.lua + stub_maps.lua with the map canvas stub.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Maps/Maps.xml", "UI/UI.xml"];

// Zone 9000 shows art 9001 (one 1002 x 668 layer of 256px tiles); the table holds three overlays: a 300 x 200
// one at (600, 100) (two tiles, the second 44 wide), a 100 x 100 one at (50, 300) and a 64 x 64 one at (0, 0).
const SETUP: &str = r#"
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
"#;

fn run(script: &str, saved: Option<&str>) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_maps.lua"],
		before: "stub.maps.useWorld(); stub.maps.withMapCanvas(); stub.maps.place(0, 800); ".into(),
		addons: vec![Addon::files("Polestar", FILES)],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		login: true,
		script: format!("{SETUP}{script}"),
	})
	.remove(0)
}

fn files(list: &Value) -> Value {
	Value::Array(list.as_array().unwrap().iter().map(|t| t["file"].clone()).collect())
}

// ---------------------------------------------------------------------------
// Overlay selection
// ---------------------------------------------------------------------------

#[test]
fn unexplored_every_overlay_of_the_art_minus_the_explored_ones_matched_on_offset_and_size() {
	let out = run(
		r#"
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
			bad = #M.UnexploredOverlays(nil, {}) })"#,
		None,
	);
	assert_eq!(out["none"], json!([501, 503, 504]));
	assert_eq!(out["empty"], json!([501, 503, 504]));
	assert_eq!(out["one"], json!([501, 504]));
	assert_eq!(out["near"], json!([501, 503, 504]));
	assert_eq!(out["hover"], json!([503, 504]), "a hover-only explored overlay is not drawn by the reveal");
	assert_eq!(out["reused"], json!([501, 503]), "a reused list is cleared first");
	assert_eq!(out["bad"], 0);
}

// ---------------------------------------------------------------------------
// The tiles on the canvas
// ---------------------------------------------------------------------------

#[test]
fn the_world_map_shows_unexplored_overlays_tinted_split_into_tiles_as_blizzard_splits_them() {
	let out = run(
		r#"
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
		emit({ tint = tint, plain = plain, after = after, color = { r, g, b } })"#,
		None,
	);
	assert_eq!(files(&out["tint"]), json!([501, 502, 503]), "the explored overlay 504 is the client's");
	let (a, b, c) = (&out["tint"][0], &out["tint"][1], &out["tint"][2]);
	// Canvas units are layer pixels: tile 1 at (600, -100) 256 x 200; tile 2 the 44-wide remainder, from a
	// 64-wide file; the 100 x 100 overlay from a 128 file.
	assert_eq!(json!([a["x"], a["y"], a["w"], a["h"]]), json!([600, -100, 256, 200]));
	assert_eq!(json!([b["x"], b["y"], b["w"], b["h"]]), json!([856, -100, 44, 200]));
	assert_eq!(b["tc"], json!([0, 44.0 / 64.0, 0, 200.0 / 256.0]));
	assert_eq!(json!([c["x"], c["y"], c["w"], c["h"]]), json!([50, -300, 100, 100]));
	assert_eq!(c["tc"], json!([0, 100.0 / 128.0, 0, 100.0 / 128.0]));
	assert_eq!(a["layer"], "ARTWORK");
	let mut vc = out["color"].as_array().unwrap().clone();
	vc.push(json!(1));
	assert_eq!(a["vc"], Value::Array(vc), "tinted with the theme token");
	assert_eq!(out["plain"][0]["vc"], json!([1, 1, 1, 1]), "\"on\" reveals untinted");
	assert_eq!(files(&out["after"]), json!([501, 502]));
}

#[test]
fn off_costs_nothing_no_frames_until_it_is_turned_on_a_map_whose_art_differs_is_left_alone() {
	let out = run(
		r#"
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
		emit({ before = before, offShown = offShown, on = on, shown = shown, cleared = cleared, other = #revealed() })"#,
		Some(r#"PolestarDB = { schema = 1, settings = { maps = { reveal = "off" } } }"#),
	);
	assert_eq!(out["offShown"], json!([0, out["before"]]));
	assert_eq!(out["on"], out["before"].as_i64().unwrap() + 1, "its frame is made when the reveal is first turned on");
	assert_eq!(out["shown"], 4);
	assert_eq!(out["cleared"], 0);
	assert_eq!(out["other"], 0, "the art guard keeps a stale table off the map");
}

// ---------------------------------------------------------------------------
// Coordinates
// ---------------------------------------------------------------------------

#[test]
fn coordinates_format_to_one_decimal_rounded_half_up_on_the_tenth_no_position_is_a_dash() {
	let out = run(
		r#"
		emit({
			M.FormatCoords(42.04, 30),
			M.FormatCoords(42.06, 30.04),
			M.FormatCoords(0, 100),
			M.FormatCoords(99.96, 0.04),
			M.FormatCoords(nil, 5),
			M.FormatCoords(),
		})"#,
		None,
	);
	assert_eq!(out, json!(["42.0, 30.0", "42.1, 30.0", "0.0, 100.0", "100.0, 0.0", "—", "—"]));
}

#[test]
fn the_minimap_readout_exists_only_once_turned_on_follows_the_player_and_blanks_without_a_position() {
	let out = run(
		r#"
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
		emit({ before = before ~= nil, first = first, moved = moved, none = none, hidden = not f:IsShown() })"#,
		None,
	);
	assert_eq!(out["before"], false, "no frame while off");
	assert_eq!(out["first"], "10.0, 50.0");
	assert_eq!(out["moved"], "20.0, 50.0");
	assert_eq!(out["none"], "");
	assert_eq!(out["hidden"], true);
}

#[test]
fn the_minimap_button_exists_only_once_turned_on_click_shows_or_hides_the_guide_right_click_opens_polestar_s_menu_drag_moves_it_around_the_edge() {
	let out = run(
		r#"
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
		local menu = Polestar.Widgets.MenuShown(b)
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Settings" then r:Click() end end
		local picked = not PolestarMenu:IsShown()
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
		emit({ before = before ~= nil, start = start, fired = fired, menu = menu, picked = picked, dragging = dragging, saved = saved,
			stopped = stopped, corner = corner, resized = resized, hidden = not b:IsShown() })"#,
		MINIMAP_BUTTON_OFF,
	);
	assert_eq!(out["before"], false, "no frame while turned off");
	// 225 degrees (south-west) at 70 + 5 px from the centre.
	assert_eq!(out["start"], json!([true, -53, -53]));
	assert_eq!(out["menu"], true, "right-click opens Polestar's menu on the button");
	assert_eq!(out["picked"], true, "picking an item closes the menu");
	assert_eq!(out["fired"], json!(["toggle", "options"]));
	assert_eq!(out["dragging"], json!([true, 75, 0]));
	assert_eq!(out["saved"], 0);
	assert_eq!(out["stopped"], true);
	assert_eq!(out["corner"], json!([true, 75, 75]), "the square's corner, not the circle");
	assert_eq!(out["resized"], json!([true, 145, 0]), "on the edge of the resized minimap");
	assert_eq!(out["hidden"], true);
}

const MINIMAP_BUTTON_OFF: Option<&str> = Some("PolestarDB = { schema = 1, settings = { maps = { minimapButton = false } } }");

#[test]
fn the_minimap_button_shows_on_a_fresh_profile_and_turning_it_off_is_stored_so_it_stays_off() {
	let out = run(
		r#"
		local b = stub.frame("PolestarMinimapButton")
		local fresh = { exists = b ~= nil, shown = b and b:IsShown(), parent = b and b:GetParent() == Minimap, stored = (PolestarDB.settings.maps or {}).minimapButton }
		Polestar.Set("maps.minimapButton", false)
		emit({ fresh = fresh, hidden = not b:IsShown(), stored = PolestarDB.settings.maps.minimapButton })"#,
		None,
	);
	assert_eq!(out["fresh"], json!({ "exists": true, "shown": true, "parent": true }), "on by default, nothing stored");
	assert_eq!(out["hidden"], true);
	assert_eq!(out["stored"], false, "an explicit off is stored, so a later default can't turn it back on");
}

#[test]
fn a_minimap_button_turned_off_stays_off_after_a_reload() {
	let out = run(r#"emit({ exists = stub.frame("PolestarMinimapButton") ~= nil, on = Polestar.Get("maps.minimapButton") })"#, MINIMAP_BUTTON_OFF);
	assert_eq!(out, json!({ "exists": false, "on": false }));
}

// 0.3.6 shows the minimap button to every account (Fitz, 2026-11-09): an account from 0.3.5, whose off was the
// default and never stored, gets it on. The 0.3.6 test builds stored false once for such an account
// (PolestarDB.minimapButtonKept): that off and its flag go, once; an off the player stores later stays.
#[test]
fn every_account_gets_the_minimap_button_on_and_the_test_builds_kept_off_is_undone_once() {
	let state = r#"emit({ exists = stub.frame("PolestarMinimapButton") ~= nil, on = Polestar.Get("maps.minimapButton"),
		stored = PolestarDB.settings.maps and PolestarDB.settings.maps.minimapButton, kept = PolestarDB.minimapButtonKept or false })"#;
	let load = |saved: Option<&str>, gamepad: bool| {
		emitted(&RunAddon {
			stubs: vec!["stub_world.lua", "stub_maps.lua"],
			before: String::from("stub.maps.useWorld(); stub.maps.withMapCanvas(); stub.maps.place(0, 800)\n")
				+ if gamepad { "Enum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }\nC_InputInterfaceStyle = { GetCurrentStyle = function() return 1 end }\n" } else { "" },
			addons: vec![Addon::files("Polestar", FILES)],
			saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
			login: true,
			script: state.into(),
		})
		.remove(0)
	};
	let on = json!({ "exists": true, "on": true, "kept": false });
	// A 0.3.5 account: settings of its own, none for the button.
	let old = "PolestarDB = { schema = 1, settings = { ui = { scale = 1.1 }, maps = { minimapButtonAngle = 140 } } }";
	assert_eq!(load(Some(old), false), on, "a 0.3.5 account: on, nothing stored");
	assert_eq!(load(None, false), on, "a new account: on, nothing stored");
	// A test build saved it off once: undone.
	let kept_off = "PolestarDB = { schema = 1, settings = { maps = { minimapButton = false } }, minimapButtonKept = true }";
	assert_eq!(load(Some(kept_off), false), on, "the test builds' saved off goes with its flag");
	assert_eq!(load(Some("PolestarDB = { schema = 1, settings = { maps = {} }, minimapButtonKept = true }"), false), on, "turned on after a test build");
	// The test builds never saved for the gamepad interface: an off there is the player's.
	assert_eq!(load(Some(kept_off), true), json!({ "exists": false, "on": false, "stored": false, "kept": false }), "a gamepad player who turned it off");
	// Without the flag an off is the player's own.
	assert_eq!(
		load(Some("PolestarDB = { schema = 1, settings = { maps = { minimapButton = false } } }"), false),
		json!({ "exists": false, "on": false, "stored": false, "kept": false }),
		"a player who turned it off"
	);
}

// Minimap button collectors gather the minimap's named Button children: a flyout reparents them into its own
// panel, a row re-anchors them on the minimap. Once moved, the button is theirs: a drag, a resized minimap or a
// changed angle leaves it where they put it, and its clicks still work.
#[test]
fn a_minimap_button_collector_owns_its_place_once_it_moves_the_button_and_clicks_still_work() {
	let out = run(
		r#"
		local fired = {}
		Polestar.On("TOGGLE_FRAME", function() fired[#fired + 1] = "toggle" end)
		local b = stub.frame("PolestarMinimapButton")
		local collected = b:IsObjectType("Button") and b:GetParent() == Minimap and not b:GetName():match("%d$") and b:GetWidth() >= 20 and b.Icon ~= nil
		local function at() local p, rel, _, x, y = b:GetPoint(1); return { p, rel == Minimap, x, y } end
		-- A flyout: reparented into the collector's panel, in a grid cell.
		local panel = CreateFrame("Frame", nil, UIParent)
		b:SetParent(panel)
		b:ClearAllPoints()
		b:SetPoint("TOPLEFT", panel, "TOPLEFT", 4, -4)
		b:SetSize(24, 24)
		stub.cursor = { 200, 70 }
		b:GetScript("OnDragStart")(b)
		local dragged = b:GetScript("OnUpdate") ~= nil
		b:GetScript("OnDragStop")(b)
		Minimap:SetSize(280, 280)
		stub.RunScript(Minimap, "OnSizeChanged", 280, 280)
		Polestar.Set("maps.minimapButtonAngle", 90)
		local inFlyout = at()
		b:Click("LeftButton")
		b:Click("RightButton")
		local menu = Polestar.Widgets.MenuShown(b)
		Polestar.Widgets.HideMenu()
		-- A row on the minimap: back on Minimap, anchored by the collector.
		b:SetParent(Minimap)
		b:ClearAllPoints()
		b:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", 0, 30)
		Minimap:SetSize(300, 300)
		stub.RunScript(Minimap, "OnSizeChanged", 300, 300)
		Polestar.Set("maps.minimapButtonAngle", 180)
		emit({ collected = collected, dragged = dragged, angle = Polestar.Get("maps.minimapButtonAngle"), inFlyout = inFlyout,
			parent = b:GetParent() == Minimap, onRow = at(), fired = fired, menu = menu })"#,
		None,
	);
	assert_eq!(out["collected"], true, "a named Button child of Minimap, at least 20 wide, its name not ending in a digit, icon at .Icon");
	assert_eq!(out["dragged"], false, "a drag inside the collector doesn't pull it back to the edge");
	assert_eq!(out["angle"], 180);
	assert_eq!(out["inFlyout"], json!(["TOPLEFT", false, 4, -4]), "neither a resize nor a new angle moves it out of the grid");
	assert_eq!(out["onRow"], json!(["BOTTOMRIGHT", true, 0, 30]), "nor off the collector's row");
	assert_eq!(out["fired"], json!(["toggle"]));
	assert_eq!(out["menu"], true, "right-click still opens Polestar's menu");
}

// ---------------------------------------------------------------------------
// Dungeon entrances
// ---------------------------------------------------------------------------

const CODEX: &str = r#"
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
"#;

const DUNGEON_PINS: Option<&str> = Some("PolestarDB = { schema = 1, settings = { maps = { dungeonPins = true } } }");

#[test]
fn dungeon_pins_the_codex_loads_only_when_the_world_map_opens_one_pin_per_known_entrance() {
	let out = run(
		&(CODEX.to_string()
			+ r#"
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
		emit({ atLogin = atLogin, loads = CODEX_LOADS, keys = keys, color = color, off = off })"#),
		DUNGEON_PINS,
	);
	assert_eq!(out["atLogin"], json!({ "loads": 0, "layer": false }), "nothing loads at login");
	assert_eq!(out["loads"], 1);
	assert_eq!(out["keys"], json!(["deadmines@42.5,71.7:map:dungeon", "hall-of-thanes@10,20:map:dungeon"]));
	assert_eq!(out["color"], true);
	assert_eq!(out["off"], true);
}

#[test]
fn with_dungeon_pins_off_the_world_map_opening_never_loads_the_codex() {
	let out = run(
		&(CODEX.to_string()
			+ r#"
		Polestar.Set("maps.dungeonPins", false)
		WorldMapFrame:Hide()
		m.showMap(9000)
		emit({ loads = CODEX_LOADS })"#),
		None,
	);
	assert_eq!(out["loads"], 0);
}

#[test]
fn a_dungeon_pin_opens_its_dungeon_page_without_the_dungeons_module_or_with_shift_it_sets_a_waypoint() {
	let out = run(
		&(CODEX.to_string()
			+ r#"
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
		emit({ page = dm.page, opened = opened, targets = targets, tip = tip })"#),
		DUNGEON_PINS,
	);
	assert_eq!(out["page"], true);
	assert_eq!(out["opened"], json!(["deadmines", "hall-of-thanes"]));
	assert_eq!(out["targets"], json!(["The Deadmines@9000:42.5,71.7", "The Deadmines@9000:42.5,71.7"]));
	assert_eq!(out["tip"], json!(["The Deadmines", "Dungeon · Levels 17–26", " ", "Click to open its page", "Shift-click to set a waypoint"]));
}

// Fitz in game (0.3.6, the button in EllesmereUIMinimap's button bar): on hover the button showed a flat accent
// disc where its logo was. The logo and the hover resolve to Polestar's own files, and the hover's 25 % is in its
// colour, so a bar that sets our regions back to full alpha cannot turn it into an opaque disc.
#[test]
fn the_minimap_button_s_logo_and_hover_are_polestar_s_files_the_hover_a_quarter_strong_even_shown_at_full_alpha() {
	let out = run(
		r##"
		local b = stub.frame("PolestarMinimapButton")
		local function look()
			local r, g, bl, a = b.Hover:GetVertexColor()
			return { icon = b.Icon:GetTexture(), hover = b.Hover:GetTexture(), layer = b.Hover:GetDrawLayer(),
				strength = (a or 1) * b.Hover:GetAlpha(), iconAlpha = b.Icon:GetAlpha() }
		end
		local r = { rest = look() }
		stub.RunScript(b, "OnEnter")
		r.enter = look()
		stub.RunScript(b, "OnLeave")
		r.leave = look()
		-- A bar showing every region of the button at full alpha.
		for _, region in ipairs({ b:GetRegions() }) do region:SetAlpha(1) end
		r.bar = look()
		Polestar.Theme.Refresh()
		r.repainted = look()
		-- Leatrix Plus's Enhance minimap stands a proxy in for the button, its icon _G[name .. "Icon"]'s texture, else
		-- the last region under 30 wide (CreateBadButton): before the logo was named, that was the hover's circle.
		local function leatrixIcon(name)
			local finalTex = "Interface\\HELPFRAME\\HelpIcon-KnowledgeBase"
			if _G[name .. "Icon"] then
				if _G[name .. "Icon"]:GetObjectType() == "Texture" then
					local gTex = _G[name .. "Icon"]:GetTexture()
					if gTex then finalTex = gTex end
				end
			else
				for i = 1, select("#", _G[name]:GetRegions()) do
					local region = select(i, _G[name]:GetRegions())
					if region.GetTexture then
						local x = region:GetSize()
						if x and x < 30 then finalTex = region:GetTexture() end
					end
				end
			end
			return finalTex
		end
		r.proxy = leatrixIcon("PolestarMinimapButton")
		r.named = _G.PolestarMinimapButtonIcon == b.Icon
		emit(r)"##,
		None,
	);
	assert!(out["proxy"].as_str().unwrap().ends_with("Polestar\\Media\\UI\\logo"), "a proxy shows the logo: {}", out["proxy"]);
	assert_eq!(out["named"], true);
	let rest = &out["rest"];
	assert!(rest["icon"].as_str().unwrap().ends_with("Polestar\\Media\\UI\\logo"), "{rest}");
	assert!(rest["hover"].as_str().unwrap().ends_with("Polestar\\Media\\UI\\circle"));
	assert_eq!(rest["layer"], "HIGHLIGHT");
	for k in ["rest", "enter", "leave", "bar", "repainted"] {
		assert!((out[k]["strength"].as_f64().unwrap() - 0.25).abs() < 1e-6, "{k}: the hover at 25 %: {}", out[k]);
		assert_eq!(out[k]["iconAlpha"], 1, "{k}: the logo shows");
		assert_eq!(out[k]["icon"], rest["icon"]);
	}
}
