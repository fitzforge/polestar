//! Polestar.Pins (addon/Polestar/Nav/Pins.lua): the shared map/minimap pin service. Real Core/Init.lua +
//! Nav/Nav.xml against tests/lua/stub_nav.lua (map 9000: 20 yd per map percent, origin at its centre; map 9001
//! on continent 1).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const PRELUDE: &str = r#"
local Pins = Polestar.Pins
local nav = stub.nav
local function at(wx, wy, extra)
	local m, x, y = nav.mapPoint(wx, wy)
	local p = { map = m, x = x, y = y }
	for k, v in pairs(extra or {}) do p[k] = v end
	return p
end
local function frames(layer) return #Pins.GetMinimapFrames(layer) end
-- Count SetPoint calls on minimap pin frames.
local setPoints = 0
local origSetPoint = stub.Methods.SetPoint
stub.Methods.SetPoint = function(self, ...)
	if self.parent == Minimap then setPoints = setPoints + 1 end
	return origSetPoint(self, ...)
end
local function minimapFrameCount()
	local n = 0
	for _, f in ipairs(stub.frames) do if f.parent == Minimap then n = n + 1 end end
	return n
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		login: true,
		script: format!("{PRELUDE}{script}"),
		..Default::default()
	})
	.remove(0)
}

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}

#[test]
fn zone_only_layers_hide_on_continent_and_world_maps_return_in_narrower_views_and_keep_minimap_icons() {
	let out = run(r#"
		local kinds={ [9000]=3, [9002]=2, [9003]=1, [9004]=5 }
		for _,map in ipairs({9002,9003,9004,9005}) do nav.maps[map]=nav.maps[9000] end
		C_Map.GetMapInfo=function(map) return kinds[map] and {mapType=kinds[map]} end
		Pins.SetLayer("services", {at(0,0)}, {minMapType=3})
		Pins.SetLayer("guide", {at(0,50)})
		local counts={}
		for _,map in ipairs({9000,9002,9003,9004,9005,9000}) do
			nav.showWorldMap(map)
			counts[#counts+1]=#nav.pins()
		end
		emit({world=counts,minimap=frames("services")})
	"#);
	assert_eq!(out, json!({ "world": [2, 1, 1, 2, 1, 2], "minimap": 1 }));
}

#[test]
fn a_500_pin_layer_costs_nothing_per_frame_while_the_player_stands_still() {
	let out = run(r#"
		local pins = {}
		local seed = 7
		local function rnd() seed = (seed * 1103515245 + 12345) % 2147483648; return seed / 2147483648 end
		for i = 1, 500 do pins[i] = at(rnd() * 1600 - 800, rnd() * 1600 - 800, { tooltip = "pin " .. i }) end
		Pins.SetLayer("quests", pins, { world = true, minimap = true })
		local r = {}
		r.drawn = frames("quests")
		stub.advance(1)                                  -- settle
		setPoints = 0
		local updates = 0
		for _, f in ipairs(stub.frames) do
			if f.parent == Minimap and f.scripts.OnUpdate then updates = updates + 1 end
		end
		stub.advance(3)                                  -- stand still for 3 s
		r.stillSetPoints = setPoints
		r.driverShown = Pins.driver:IsShown()
		r.pinOnUpdates = updates
		nav.place(40, 30)                                -- move
		stub.advance(0.3)
		r.movingSetPoints = setPoints
		r.drawnAfterMove = frames("quests")
		r.created = minimapFrameCount()
		for _ = 1, 3 do                                  -- walk back and forth: frames are reused
			nav.place(0, 0); stub.advance(0.3)
			nav.place(40, 30); stub.advance(0.3)
		end
		r.createdAfter = minimapFrameCount()
		stub.advance(1)
		r.driverIdle = not Pins.driver:IsShown()
		local inside = 0
		for _, p in ipairs(pins) do
			local _, wx, wy = nav.Compat.MapToWorld(p.map, p.x, p.y)
			if (wx - 40) ^ 2 + (wy - 30) ^ 2 <= (466 + 2 / 3) ^ 2 / 4 then inside = inside + 1 end
		end
		r.inside = inside
		emit(r)"#);
	assert_eq!(out["stillSetPoints"], 0, "no repositioning while stationary");
	assert_eq!(out["driverShown"], false, "the update driver is asleep");
	assert_eq!(out["pinOnUpdates"], 0, "pin frames have no OnUpdate scripts");
	assert!(num(&out["movingSetPoints"]) > 0.0, "moving repositions pins");
	let drawn = num(&out["drawn"]);
	assert!(drawn > 0.0 && drawn < 500.0, "distance-filtered ({drawn} of 500 drawn)");
	assert_eq!(out["drawnAfterMove"], out["inside"], "exactly the pins within the minimap view radius");
	assert_eq!(out["createdAfter"], out["created"], "pooled: no new frames on repeat visits");
	assert_eq!(out["driverIdle"], true);
}

#[test]
fn layer_changes_in_one_frame_share_one_minimap_redraw_which_visits_only_the_pins_near_the_player() {
	let out = run(r#"
		local seed = 11
		local function rnd() seed = (seed * 1103515245 + 12345) % 2147483648; return seed / 2147483648 end
		local here, there = {}, {}
		for i = 1, 2000 do here[i] = at(rnd() * 2000 - 1000, rnd() * 2000 - 1000) end
		for i = 1, 2000 do there[i] = { map = 9001, x = rnd() * 100, y = rnd() * 100 } end
		nav.place(0, 0)                                  -- a grid corner: four squares around the player
		stub.advance(1)
		local r = {}
		local draws = Pins.stats.draws
		Pins.SetLayer("a", here, { world = true, minimap = true })
		Pins.SetLayer("b", there, { world = true, minimap = true })
		Pins.SetLayer("a", here, { world = true, minimap = true })
		r.sameFrame = Pins.stats.draws - draws
		stub.advance(0.05)
		r.nextFrame = Pins.stats.draws - draws
		local visited = Pins.stats.visited
		nav.place(1, 1)
		stub.advance(0.3)
		r.visited = Pins.stats.visited - visited
		r.draws = Pins.stats.draws - draws - r.nextFrame
		r.drawn = frames("a")
		r.far = frames("b")
		local inside = 0
		for _, p in ipairs(here) do
			local _, wx, wy = nav.Compat.MapToWorld(p.map, p.x, p.y)
			if (wx - 1) ^ 2 + (wy - 1) ^ 2 <= (466 + 2 / 3) ^ 2 / 4 then inside = inside + 1 end
		end
		r.inside = inside
		emit(r)"#);
	assert_eq!(out["sameFrame"], 0, "nothing is drawn while the frame is still changing layers");
	assert_eq!(out["nextFrame"], 1, "one redraw for three layer changes");
	assert_eq!(out["far"], 0, "pins on another continent are not drawn");
	assert_eq!(out["drawn"], out["inside"], "exactly the pins within the minimap view radius");
	let (draws, visited) = (num(&out["draws"]), num(&out["visited"]));
	assert!(draws >= 1.0 && visited / draws < 1000.0, "a redraw examined {} of 4000 pins", visited / draws);
}

#[test]
fn layer_visibility_hides_and_restores_a_layer_on_both_surfaces_even_before_it_exists() {
	let out = run(r#"
		local r = {}
		Pins.SetLayerVisible("maps.inns", false)
		Pins.SetLayer("maps.inns", { at(50, 0, { tooltip = "Inn" }), at(-50, 0) })
		Pins.SetLayer("quests", { at(0, 50) })
		nav.showWorldMap(9000)
		r.hidden = { frames("maps.inns"), frames("quests"), #nav.pins() }
		Pins.SetLayerVisible("maps.inns", true)
		r.shown = { frames("maps.inns"), frames("quests"), #nav.pins() }
		r.visible = Pins.IsLayerVisible("maps.inns")
		Pins.ClearLayer("maps.inns")
		r.cleared = { frames("maps.inns"), #nav.pins(), Pins.IsLayerVisible("maps.inns") }
		emit(r)"#);
	assert_eq!(out["hidden"], json!([0, 1, 1]));
	assert_eq!(out["shown"], json!([2, 1, 3]));
	assert_eq!(out["visible"], true);
	assert_eq!(out["cleared"], json!([0, 1, false]));
}

#[test]
fn edge_clamping_is_per_layer_an_edge_layer_pins_far_targets_to_the_rim_others_drop_them() {
	let out = run(r#"
		nav.viewRadius = 200                             -- 140 px minimap: 0.35 px per yard
		Pins.SetLayer("near", { at(0, -900) }, { edge = false })
		Pins.SetLayer("far", { at(0, -900) }, { edge = true })
		Pins.SetLayer("inside", { at(100, 0) }, { edge = true })
		local f = Pins.GetMinimapFrames("far")[1]
		local _, _, _, x, y = f:GetPoint(1)
		local g = Pins.GetMinimapFrames("inside")[1]
		local _, _, _, ix, iy = g:GetPoint(1)
		emit({ near = #Pins.GetMinimapFrames("near"), x = x, y = y, edge = f.edge:IsShown(), fill = f.fill:IsShown(),
			rot = f.edge:GetRotation(), ix = ix, iy = iy, insideEdge = g.edge:IsShown() })"#);
	assert_eq!(out["near"], 0);
	let limit = 70.0 - 14.0 * 0.35;
	let (x, y) = (num(&out["x"]), num(&out["y"]));
	assert!((x - limit).abs() < 1e-6 && y.abs() < 1e-6, "clamped to the rim: {x},{y}");
	assert_eq!(json!([out["edge"], out["fill"]]), json!([true, false]));
	assert!((num(&out["rot"]) + std::f64::consts::PI / 2.0).abs() < 1e-6, "pointer turned east");
	assert!(num(&out["ix"]).abs() < 1e-6 && (num(&out["iy"]) - 35.0).abs() < 1e-6, "in-range edge pins sit where they are");
	assert_eq!(out["insideEdge"], false);
}

#[test]
fn the_world_map_redraws_for_the_map_being_viewed_converting_world_era_frame_and_other_map_pins() {
	let out = run(r#"
		Polestar.RegisterMapFrames({ era = { [9000] = { c = 0, top = 1030, bottom = -970, left = 960, right = -1040 } } })
		local clicked
		Pins.SetLayer("maps.taxi", {
			{ map = 9000, x = 25, y = 75, tooltip = function(tip) tip:SetText("Flight master"); tip:AddLine("known", 1, 1, 1) end,
				onClick = function(button) clicked = button end },
			{ map = 9000, x = 50, y = 50, f = "e" },            -- Era frame: world (30, -40)
			{ c = 0, wx = 0, wy = 0 },                          -- world position
			{ map = 9001, x = 50, y = 50 },                     -- continent 1
		})
		local function snapshot()
			local out = {}
			for _, pin in ipairs(nav.pins()) do
				local x, y = nav.worldPoint(pin)
				assert(math.abs(x - pin.data.x) < 1e-9 and math.abs(y - pin.data.y) < 1e-9, "drawn where its data says")
				out[#out + 1] = { pin.data.x / 100, pin.data.y / 100 }
			end
			table.sort(out, function(a, b) return a[1] < b[1] end)
			return out
		end
		local r = {}
		nav.showWorldMap(9000)
		r.home = snapshot()
		local pins = nav.pins()
		for _, pin in ipairs(pins) do
			if pin.data.x == 25 then
				r.tooltip = nav.tooltipOf(pin)
				nav.click(pin, "LeftButton")
				stub.RunScript(pin, "OnEnter")            -- pressed on the pin, released off it: no click
				stub.fire("GLOBAL_MOUSE_DOWN", "LeftButton")
				stub.RunScript(pin, "OnLeave")
				stub.fire("GLOBAL_MOUSE_UP", "LeftButton")
				stub.RunScript(pin, "OnEnter")            -- the right button is the map's (zoom out)
				stub.fire("GLOBAL_MOUSE_DOWN", "RightButton")
				stub.fire("GLOBAL_MOUSE_UP", "RightButton")
				stub.RunScript(pin, "OnLeave")
				r.mouse = pin:IsMouseEnabled()
				r.passThrough = pin.passThrough
				r.level = pin:GetFrameLevel()
			end
		end
		r.clicked = clicked
		nav.showWorldMap(9001)
		r.other = snapshot()
		WorldMapFrame:Hide()
		Pins.SetLayer("maps.taxi", { { map = 9001, x = 10, y = 10 } })
		nav.showWorldMap(9001)
		r.reopened = snapshot()
		emit(r)"#);
	assert_eq!(out["home"], json!([[0.25, 0.75], [0.5, 0.5], [0.52, 0.485]]));
	assert_eq!(out["tooltip"], json!(["Flight master", "known"]));
	assert_eq!(out["clicked"], "LeftButton");
	assert_eq!(out["mouse"], true);
	assert_eq!(out["passThrough"], json!(["RightButton"]), "the right button goes through to the map (zoom out)");
	assert_eq!(out["level"], 2060, "at the map's PIN_FRAME_LEVEL_SUPER_TRACKED_QUEST");
	assert_eq!(out["other"], json!([[0.5, 0.5]]));
	assert_eq!(out["reopened"], json!([[0.1, 0.1]]));
}

#[test]
fn a_pin_s_area_draws_a_disc_of_its_radius_in_yards_under_the_world_map_pins() {
	let out = run(r#"
		WorldMapFrame.Child:SetSize(1000, 1000)
		Pins.SetLayer("quests.objectives", {
			{ map = 9000, x = 40, y = 40, area = 60, color = { 1, 0.5, 0.5, 1 } },  -- 60 yd = 3 % of map 9000
			{ map = 9000, x = 60, y = 60 },
		})
		nav.showWorldMap(9000)
		local r = { pins = #nav.pins() }
		local areas = nav.pins("areas")
		r.areas = #areas
		local a = areas[1]
		r.size = { a.width, a.height }
		r.at = { nav.worldPoint(a) }
		r.level = a:GetFrameLevel()
		r.mouse = a:IsMouseEnabled() and true or false
		local _, _, _, alpha = a.tex:GetVertexColor()
		r.alpha = alpha
		Pins.SetLayer("quests.objectives", { { map = 9000, x = 40, y = 40 } })
		r.cleared = #nav.pins("areas")
		emit(r)"#);
	assert_eq!(out["pins"], 2);
	assert_eq!(out["areas"], 1);
	let size: Vec<f64> = out["size"].as_array().unwrap().iter().map(|v| num(v).round()).collect();
	assert_eq!(size, vec![60.0, 60.0], "diameter: 2 x 3 % of a 1000 px canvas");
	assert_eq!(out["at"], json!([40, 40]));
	assert_eq!(out["level"], 2010, "at the map's PIN_FRAME_LEVEL_QUEST_BLOB");
	assert_eq!(out["mouse"], false);
	let alpha = num(&out["alpha"]);
	assert!(alpha > 0.0 && alpha < 0.5, "a faint disc");
	assert_eq!(out["cleared"], 0);
}

#[test]
fn a_layer_with_minimapareas_draws_its_areas_on_the_minimap_too_cut_at_the_rim_areaonly_pins_draw_no_pin() {
	let out = run(r#"
		nav.viewRadius = 200                                             -- 70 px for 200 yd: 0.35 px a yard
		local function areas(layer)
			local r = {}
			for _, t in ipairs(Pins.GetMinimapAreas(layer)) do
				local _, _, _, x, y = t:GetPoint(1)
				r[#r + 1] = { math.floor(x + 0.5), math.floor(y + 0.5), math.floor(t.width + 0.5), t.mask ~= nil }
			end
			table.sort(r, function(a, b) return a[1] > b[1] end)
			return r
		end
		Pins.SetLayer("spawns", {
			at(100, 0, { area = 60, areaOnly = true, color = { 1, 0.5, 0.5, 1 } }),   -- in view
			at(0, 240, { area = 60, areaOnly = true }),                               -- centre past the rim, disc reaching in
			at(0, 300, { area = 60, areaOnly = true }),                               -- out of reach
		}, { minimapAreas = true })
		Pins.SetLayer("quests.objectives", { at(-50, 0, { area = 60 }) })        -- no minimapAreas: the pin only
		stub.advance(0.3)
		local r = { areas = areas("spawns"), pins = frames("spawns"), quests = { frames("quests.objectives"), #Pins.GetMinimapAreas("quests.objectives") } }
		local t = Pins.GetMinimapAreas("spawns")[1]
		local _, _, _, alpha = t:GetVertexColor()
		r.alpha = alpha
		local mask = t.mask
		r.mask = { mask.texture, math.floor(mask.width + 0.5) }
		nav.place(100, 0); stub.advance(0.3)
		r.moved = areas("spawns")
		GetMinimapShape = function() return "SQUARE" end
		nav.place(0, 0); stub.advance(0.3)
		r.square = #areas("spawns")
		r.squareMask = { mask.texture, math.floor(mask.width + 0.5) }
		GetMinimapShape = nil
		nav.showWorldMap(9000)
		r.world = { #nav.pins("areas"), #nav.pins() }
		Pins.ClearLayer("spawns")
		stub.advance(0.3)
		r.cleared = #Pins.GetMinimapAreas("spawns")
		emit(r)"#);
	assert_eq!(out["areas"], json!([[0, 35, 42, true], [-84, 0, 42, true]]), "discs 2 x 60 yd wide where the player sees them, one reaching in past the rim");
	assert_eq!(out["pins"], 0, "areaOnly: no pin frame");
	assert_eq!(out["quests"], json!([1, 0]), "a layer without minimapAreas keeps its areas on the world map");
	let alpha = num(&out["alpha"]);
	assert!(alpha > 0.0 && alpha < 0.5, "a faint disc");
	assert_eq!(out["mask"], json!([r"Interface\AddOns\Polestar\Media\Nav\pin-fill", 213]), "masked to the round minimap: pin-fill's disc over its width");
	assert_eq!(out["moved"][0], json!([0, 0, 42, true]), "the disc follows the player");
	assert_eq!(out["square"], 3, "a square minimap's corners reach further");
	assert_eq!(out["squareMask"], json!([r"Interface\Buttons\WHITE8X8", 140]));
	assert_eq!(out["world"], json!([4, 1]), "every area on the world map; only the plain pin as a pin");
	assert_eq!(out["cleared"], 0);
}

// The corners of each piece a hull is cut from (upper left, upper right, lower right, lower left; local units
// around the rectangle's centre, y up), from the rectangle's size and the pieces' vertex offsets; their areas
// and whether every corner lies inside the outline.
const PIECES: &str = r#"
local function area(pts)
	local a = 0
	for i = 1, #pts, 2 do
		local j = i + 2 > #pts and 1 or i + 2
		a = a + pts[i] * pts[j + 1] - pts[j] * pts[i + 1]
	end
	return math.abs(a) / 2
end
local function inside(outline, x, y)
	local sign = 0
	for i = 1, #outline, 2 do
		local j = i + 2 > #outline and 1 or i + 2
		local c = (outline[j] - outline[i]) * (y - outline[i + 1]) - (outline[j + 1] - outline[i + 1]) * (x - outline[i])
		if math.abs(c) > 1e-6 then
			local s = c > 0 and 1 or -1
			if sign ~= 0 and s ~= sign then return false end
			sign = s
		end
	end
	return true
end
local function pieces(texs, used, w, h, outline)
	local hw, hh = w / 2, h / 2
	local r = { fill = 0, rim = 0, inside = true, alphas = {}, masked = true, shown = true }
	for k = 1, used do
		local t, o = texs[k], texs[k].vertexOffset
		local q = { -hw + o[1], hh + o[2], hw + o[5], hh + o[6], hw + o[7], -hh + o[8], -hw + o[3], -hh + o[4] }
		local _, _, _, a = t:GetVertexColor()
		local key = math.floor(a * 100 + 0.5)
		r.alphas[key] = (r.alphas[key] or 0) + 1
		if a < 0.5 then r.fill = r.fill + area(q) else r.rim = r.rim + area(q) end
		for i = 1, 8, 2 do
			if not inside(outline, q[i], q[i + 1]) then
				local near = false
				for j = 1, #outline, 2 do near = near or (math.abs(outline[j] - q[i]) < 1e-6 and math.abs(outline[j + 1] - q[i + 1]) < 1e-6) end
				if not near then r.inside = false end
			end
		end
		if t.mask == nil then r.masked = false end
		if not t:IsShown() then r.shown = false end
	end
	r.outline = area(outline)
	return r
end
"#;

#[test]
fn a_hull_is_a_region_cut_from_pieces_that_tile_it_exactly_with_a_rim_kept_thin_on_screen_on_the_minimap_walking_only_moves_it() {
	let out = run(&(PIECES.to_string()
		+ r#"
		WorldMapFrame.Child:SetSize(1000, 1000)                          -- map 9000: 0.5 canvas units a yard

		nav.viewRadius = 200                                             -- 0.35 px a yard
		local offsets = 0
		local orig = stub.Methods.SetVertexOffset
		stub.Methods.SetVertexOffset = function(...) offsets = offsets + 1; return orig(...) end
		-- A diamond 200 yd north to south and 300 yd east to west around the origin.
		Pins.SetLayer("spawns", {
			{ c = 0, wx = 0, wy = 0, hull = { 100, 0, 0, 150, -100, 0, 0, -150 }, areaOnly = true, color = { 1, 0.5, 0.5, 0.8 } },
		}, { minimapAreas = true })
		nav.showWorldMap(9000)
		local r = {}
		local hulls = nav.pins("hulls")
		local pin = hulls[1]
		local x, y = nav.worldPoint(pin)
		r.world = { #hulls, #nav.pins(), pin:GetFrameLevel(), pin:IsMouseEnabled() and true or false,
			x / 100, y / 100, pin.width, pin.height, pin.used }
		r.worldPieces = pieces(pin.texs, pin.used, pin.width, pin.height, pin.outline)
		WorldMapFrame.ScrollContainer.currentScale = 2                   -- zoomed in: the rim halves in canvas units
		stub.runMapFrame(WorldMapFrame, 0)
		r.zoomed = pieces(pin.texs, pin.used, pin.width, pin.height, pin.outline)
		stub.advance(0.3)
		local mm = Pins.GetMinimapHulls("spawns")
		local rec = mm[1]
		r.minimap = { #mm, rec.used, rec.texs[1].width, rec.texs[1].height, rec.x, rec.y }
		r.minimapPieces = pieces(rec.texs, rec.used, rec.texs[1].width, rec.texs[1].height, rec.outline)
		offsets = 0
		nav.place(50, 0); stub.advance(0.3)                              -- walk 50 yd north
		r.walked = { offsets, rec.x, rec.y, #Pins.GetMinimapHulls("spawns") }
		nav.viewRadius = 100; stub.advance(0.3)                          -- zoom in: laid out again
		r.zoomedMinimap = { offsets > 0, rec.texs[1].width, rec.texs[1].height }
		r.stats = Pins.AreaStats()
		Pins.ClearLayer("spawns")
		stub.advance(0.3)
		r.cleared = { #nav.pins("hulls"), #Pins.GetMinimapHulls("spawns"), rec.texs[1]:IsShown() }
		emit(r)"#));
	let w = &out["world"];
	assert_eq!(json!([w[0], w[1], w[2], w[3]]), json!([1, 0, 2010, false]), "one region under every pin (PIN_FRAME_LEVEL_QUEST_BLOB), no pin, no mouse");
	assert_eq!(json!([w[4], w[5]]), json!([0.5, 0.5]), "centred on its centre");
	assert_eq!([num(&w[6]).round(), num(&w[7]).round()], [150.0, 100.0], "300 x 200 yd at 0.5 canvas units a yard");
	assert_eq!(w[8], 5, "a 4-gon: one fill quad and a rim quad per side");
	let near = |a: f64, b: f64, eps: f64, msg: &str| assert!((a - b).abs() <= eps, "{msg}: {a} vs {b}");
	let wp = &out["worldPieces"];
	near(num(&wp["outline"]), 7500.0, 1e-6, "the outline is the diamond");
	near(num(&wp["fill"]) + num(&wp["rim"]), num(&wp["outline"]), 1e-6, "fill and rim tile the outline: no gap, no overlap");
	assert_eq!(wp["inside"], true, "every piece lies inside the outline");
	assert_eq!(wp["alphas"], json!({ "16": 1, "56": 4 }), "fill 0.2, rim 0.7, times the colour alpha 0.8");
	let perimeter = 4.0 * 75f64.hypot(50.0);
	near(num(&wp["rim"]) / perimeter, 1.5, 0.05, "the rim is 1.5 units wide");
	let zoomed = &out["zoomed"];
	near(num(&zoomed["rim"]) / perimeter, 0.75, 0.03, "zoomed in twice: 0.75 canvas units, still 1.5 on screen");
	near(num(&zoomed["fill"]) + num(&zoomed["rim"]), num(&zoomed["outline"]), 1e-6, "still tiled exactly");
	let round2 = |v: &Value| -> Vec<f64> { v.as_array().unwrap().iter().map(|x| (num(x) * 100.0).round() / 100.0).collect() };
	assert_eq!(round2(&out["minimap"]), vec![1.0, 5.0, 105.0, 70.0, 0.0, 0.0], "300 x 200 yd at 0.35 px a yard, around the player");
	let mp = &out["minimapPieces"];
	near(num(&mp["fill"]) + num(&mp["rim"]), num(&mp["outline"]), 1e-6, "the minimap pieces tile the outline too");
	assert_eq!(mp["inside"], true);
	assert_eq!(mp["masked"], true, "every piece is cut at the rim");
	assert_eq!(mp["shown"], true);
	assert_eq!(round2(&out["walked"]), vec![0.0, 0.0, -17.5, 1.0], "walking moves the anchor only: no vertex offset set");
	let zm = &out["zoomedMinimap"];
	assert_eq!((zm[0].clone(), num(&zm[1]).round(), num(&zm[2]).round()), (json!(true), 210.0, 140.0));
	assert_eq!(out["stats"], json!({ "world": { "hulls": 1, "pieces": 5, "discs": 0 }, "minimap": { "hulls": 1, "pieces": 5, "discs": 0 } }));
	assert_eq!(out["cleared"], json!([0, 0, false]));
}

// Issue #55: the world map pool released its pins in pairs() order over a frame-keyed table, so which frame
// drew which pin after a redraw (and how many pieces each hull frame had made) hung on table addresses, and
// changed from run to run.
#[test]
fn world_map_redraws_hand_every_pin_frame_back_the_pin_it_showed_and_no_hull_frame_grows_pieces_it_does_not_need() {
	let out = run(r#"
		WorldMapFrame.Child:SetSize(1000, 1000)
		local pins = {}
		for k = 3, 14 do                                                -- hulls of 3 to 14 corners, each with a pin and a disc
			local cx, cy, hull = (k - 8) * 120, (k % 4) * 150 - 200, {}
			for i = 1, k do
				local a = 2 * math.pi * (i - 1) / k
				hull[2 * i - 1], hull[2 * i] = cx + 60 * math.cos(a), cy + 60 * math.sin(a)
			end
			pins[#pins + 1] = { c = 0, wx = cx, wy = cy, hull = hull, area = 40, priority = k % 3 }
		end
		Pins.SetLayer("spawns", pins)
		local kinds = { "pins", "hulls", "areas" }
		local function owners()
			local r, n = {}, 0
			for _, kind in ipairs(kinds) do
				for _, pin in ipairs(Pins.GetWorldFrames(kind)) do
					r[pin], n = pin.data.pin, n + 1
				end
			end
			return r, n
		end
		nav.showWorldMap(9000)
		local first, shown = owners()
		local r = { shown = shown, moved = 0, spare = 0 }
		for _ = 1, 4 do
			WorldMapFrame:Hide()
			nav.showWorldMap(9000)                                      -- the same pins drawn again
			local now = owners()
			for frame, pin in pairs(first) do
				if now[frame] ~= pin then r.moved = r.moved + 1 end
			end
		end
		for frame in pairs(first) do
			if frame.texs and #frame.texs > frame.used then r.spare = r.spare + 1 end
		end
		emit(r)"#);
	assert_eq!(out["shown"], 36, "12 pins, 12 hulls, 12 discs");
	assert_eq!(out["moved"], 0, "every frame draws the pin it drew before");
	assert_eq!(out["spare"], 0, "every hull frame holds exactly the pieces of its own hull");
}

fn parts(v: &Value) -> Value {
	Value::Array(v.as_array().unwrap().iter().map(|f| json!([f["w"], f["back"], f["mark"]])).collect())
}

#[test]
fn icon_pins_may_sit_on_a_dark_disc_carry_a_ring_and_take_their_own_minimap_size() {
	let out = run(r#"
		nav.viewRadius = 200
		Pins.SetLayer("quests.objectives", {
			at(20, 20, { icon = "Interface\\Icons\\kill", size = 20, minimapSize = 12, backdrop = true, ring = { 1, 0.8, 0.3, 1 } }),
			at(-20, -20, { icon = "Interface\\Icons\\kill", size = 20 }),
		})
		stub.advance(0.3)
		local r = {}
		for _, f in ipairs(Pins.GetMinimapFrames("quests.objectives")) do
			r[#r + 1] = { w = f.width, back = f.back:IsShown(), mark = f.mark:IsShown(), backW = f.back.width }
		end
		table.sort(r, function(a, b) return a.w < b.w end)
		nav.showWorldMap(9000)
		local world = {}
		for _, pin in ipairs(nav.pins()) do world[#world + 1] = { w = pin.width, back = pin.back:IsShown(), mark = pin.mark:IsShown() } end
		table.sort(world, function(a, b) return (a.back and 1 or 0) < (b.back and 1 or 0) end)
		emit({ minimap = r, world = world })"#);
	assert_eq!(parts(&out["minimap"]), json!([[12, true, true], [20, false, false]]), "minimapSize on the minimap; parts only where asked");
	assert!((num(&out["minimap"][0]["backW"]) - 14.4).abs() < 1e-9, "the disc is a little wider than the glyph");
	assert_eq!(parts(&out["world"]), json!([[20, false, false], [20, true, true]]), "size on the world map");
}

#[test]
fn minimap_pins_follow_a_rotating_minimap_priority_stacks_tooltips_and_clicks_work() {
	let out = run(r#"
		nav.viewRadius = 200
		SetCVar("rotateMinimap", "1")
		nav.facing = math.pi / 2                          -- facing west
		local clicked
		Pins.SetLayer("quests", {
			at(0, 100, { priority = 1, tooltip = "West", onClick = function(b) clicked = b end }),
			at(100, 0, { priority = 9 }),
		})
		local list = Pins.GetMinimapFrames("quests")
		local r = { pins = {} }
		for _, f in ipairs(list) do
			local _, _, _, x, y = f:GetPoint(1)
			r.pins[#r.pins + 1] = { x = math.floor(x + 0.5), y = math.floor(y + 0.5), level = f:GetFrameLevel(), mouse = f:IsMouseEnabled() }
		end
		table.sort(r.pins, function(a, b) return a.y > b.y end)
		local west = list[1].pin.tooltip and list[1] or list[2]
		r.tip = nav.tooltipOf(west)
		stub.RunScript(west, "OnMouseUp", "RightButton")
		r.clicked = clicked
		nav.facing = 0                                   -- turn north: pins follow
		stub.advance(0.25)
		local _, _, _, wx, wy = west:GetPoint(1)
		r.afterTurn = { math.floor(wx + 0.5), math.floor(wy + 0.5) }
		emit(r)"#);
	// Facing west on a rotating minimap: west is up, north is right.
	let (w, n) = (&out["pins"][0], &out["pins"][1]);
	assert_eq!(json!([w["x"], w["y"]]), json!([0, 35]));
	assert_eq!(json!([n["x"], n["y"]]), json!([35, 0]));
	assert!(num(&n["level"]) > num(&w["level"]), "higher priority draws above");
	assert_eq!(json!([w["mouse"], n["mouse"]]), json!([true, false]), "only interactive pins take the mouse");
	assert_eq!(out["tip"], json!(["West"]));
	assert_eq!(out["clicked"], "RightButton");
	assert_eq!(out["afterTurn"], json!([-35, 0]));
}

// The gamepad interface's map cursor is no mouse (Blizzard_GamepadSoftCursor): the map hovers its own pins near
// it and clicks them on A; Polestar's pins must answer it too, or a gamepad player gets no tooltip and no
// click-to-target on them.
#[test]
fn with_the_gamepad_the_map_cursor_near_a_pin_shows_its_tooltip_and_a_clicks_it_once_a_press() {
	let out = run(r#"
		local clicks = {}
		Pins.SetLayer("quests", {
			at(0, 0, { tooltip = "Here", onClick = function(button) clicks[#clicks + 1] = button end }),
			at(0, -100, {}),                                 -- 5 % east: nothing to show or click
		})
		nav.showWorldMap(9000)
		-- The canvas's top left on screen at (100, 900): map (50, 50) at (600, 400), map (55, 50) at (650, 400).
		local canvas = WorldMapFrame.Child
		canvas.x, canvas.y = 100, -100
		local function at(x, y) SoftCursor.x, SoftCursor.y = x, y; stub.runMapFrame(WorldMapFrame, 0.06) end
		local function press(down) stub.keysDown.PAD1 = down; stub.runMapFrame(WorldMapFrame, 0.01) end
		local function tip() return GameTooltip:IsShown() and GameTooltip.owner and GameTooltip.owner.data.pin.tooltip or false end
		local r = {}
		at(605, 403)
		r.hidden = { tip(), #clicks }                    -- the cursor shows only while the map has the gamepad's focus
		SoftCursor:Show()
		at(605, 403)
		r.near = tip()
		press(true); press(true); press(false); press(true); press(false)
		r.clicks = clicks
		at(650, 400)
		r.plain = tip()                                  -- over the pin with nothing to show
		press(true); press(false)
		r.plainClicks = #clicks
		at(611, 400)
		r.far = tip()                                    -- 11 units away: still in reach
		at(613, 400)
		r.out = tip()
		at(600, 400)
		SoftCursor:Hide()
		stub.runMapFrame(WorldMapFrame, 0.06)
		r.cursorGone = tip()
		emit(r)"#);
	assert_eq!(out["hidden"], json!([false, 0]));
	assert_eq!(out["near"], "Here", "the tooltip of the pin under the cursor");
	assert_eq!(out["clicks"], json!(["LeftButton", "LeftButton"]), "one click a press, none while held");
	assert_eq!(out["plain"], false);
	assert_eq!(out["plainClicks"], 2);
	assert_eq!(out["far"], "Here");
	assert_eq!(out["out"], false, "past 12 units: the tooltip goes");
	assert_eq!(out["cursorGone"], false, "and with the cursor");
}

#[test]
fn a_popup_owns_gamepad_a_until_it_closes_and_the_button_is_released() {
	let out = run(r#"
		local open,clicks=false,0
		Polestar.Widgets={MenuShown=function() return open end}
		Pins.SetLayer("services",{at(0,0,{tooltip="Services",onClick=function() clicks=clicks+1; open=true end})})
		nav.showWorldMap(9000)
		WorldMapFrame.Child.x,WorldMapFrame.Child.y=100,-100
		SoftCursor.x,SoftCursor.y=600,400; SoftCursor:Show()
		local function press(down) stub.keysDown.PAD1=down; stub.runMapFrame(WorldMapFrame,0.06) end
		press(false); press(true)
		press(false); press(true); press(false) -- category menu handles these presses
		open=false
		press(true) -- popup selection closes while A is still down
		local afterPopup=clicks
		press(false); press(true)
		emit({afterPopup=afterPopup,newPress=clicks})
	"#);
	assert_eq!(out, json!({ "afterPopup": 1, "newPress": 2 }));
}

#[test]
fn world_map_pins_never_call_the_combat_restricted_setpassthroughbuttons_in_combat() {
	let out = run(r#"
		local r = {}
		stub.inCombat = true
		Pins.SetLayer("quests", { at(0, 0), at(100, 0) })
		nav.showWorldMap(9000)                           -- opening the map in combat
		Pins.SetLayer("quests", { at(0, 0), at(100, 0), at(-100, 0) })
		r.blockedInCombat = #stub.blocked
		local pending = 0
		for _, pin in ipairs(nav.pins()) do if not pin.passThrough then pending = pending + 1 end end
		r.pendingInCombat = pending
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		local set = 0
		for _, pin in ipairs(nav.pins()) do
			if pin.passThrough and pin.passThrough[1] == "RightButton" then set = set + 1 end
		end
		r.setAfter = set
		Pins.SetLayer("quests", { at(0, 0) })            -- drawn again out of combat: still set, no repeat calls needed
		r.reacquired = nav.pins()[1].passThrough and nav.pins()[1].passThrough[1]
		emit(r)"#);
	assert_eq!(out["blockedInCombat"], 0, "no restricted call while in combat");
	assert_eq!(out["pendingInCombat"], 3);
	assert_eq!(out["setAfter"], 3, "right-click passthrough applied once combat ends");
	assert_eq!(out["reacquired"], "RightButton");
}

// As the gamepad interface focuses the world map, its navigation (Blizzard_GamepadSmartNavigation/Utility.lua,
// SmartNavigation_CanFocusFrame) scans every frame under it and takes a Button or EditBox, or a frame with an
// OnMouseDown or OnMouseUp script, for a button, reading that script back with GetScript: in game Polestar's
// function in its secure code tainted the map's FocusGamepad, and the next close blocked the interface's
// actions.
#[test]
fn no_frame_polestar_puts_on_the_world_map_looks_like_a_button_to_the_gamepad_s_navigation_and_its_pins_still_click() {
	let out = run(r#"
		local clicks = {}
		Pins.SetLayer("quests", {
			at(0, 0, { tooltip = "Here", onClick = function(button) clicks[#clicks + 1] = button end, area = 50 }),
			{ c = 0, wx = 300, wy = 300, hull = { 400, 300, 300, 450, 200, 300, 300, 150 }, areaOnly = true },
		})
		nav.setWaypoint({ map = 9000, x = 70, y = 70, label = "There" })
		nav.showWorldMap(9000)
		stub.advance(0.2)
		local function addon(fn) return fn ~= nil and stub.addonSources[debug.getinfo(fn, "S").source] ~= nil end
		local looks, scanned = {}, 0
		local function scan(f)
			for _, c in ipairs(f.children) do
				scanned = scanned + 1
				local kind = c.kind
				if ((kind == "Button" or kind == "EditBox" or kind == "CheckButton") and next(c.scripts))
					or addon(c.scripts.OnMouseUp) or addon(c.scripts.OnMouseDown) then
					looks[#looks + 1] = kind
				end
				scan(c)
			end
		end
		scan(WorldMapFrame)
		local pin
		for _, f in ipairs(nav.pins()) do if f.data.pin.tooltip == "Here" then pin = f end end
		nav.click(pin, "LeftButton")
		nav.click(pin, "MiddleButton")
		emit({ looks = table.concat(looks, ", "), scanned = scanned, clicks = clicks })"#);
	assert_eq!(out["looks"], "", "no Button, no OnMouseDown or OnMouseUp script of the addon");
	assert!(num(&out["scanned"]) >= 6.0, "the pins, area, region, trail and the view's frame were scanned ({})", out["scanned"]);
	assert_eq!(out["clicks"], json!(["LeftButton", "MiddleButton"]));
}
