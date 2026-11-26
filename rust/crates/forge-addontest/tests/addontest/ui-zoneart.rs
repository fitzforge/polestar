//! UI.ZoneArt (addon/Polestar/UI/ZoneArt.lua) against the real Core + Theme + UI manifests: the framing (the
//! place lands in the clear stretch of the band, never past the painting's edges), only what the band shows is
//! drawn, and the overlays (UI/ZoneArtOverlays.lua, or the client's explored ones when the table was not built
//! for the map's art) laid over the base tiles the way the world map lays them.

use std::collections::BTreeMap;

use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// A 1002 x 668 painting of 4 x 3 tiles (file 100000 + row-major index) on map 7001, art 9001; a 300 x 200
// overlay at (600, 100): a full tile and a 44-wide partial one; a 100 x 300 overlay at (50, 300): a full-height
// tile and a 44-high partial one under it; one far in the top-left corner.
const SETUP: &str = r#"
C_Map = C_Map or {}
C_Map.GetMapArtLayers = function(id)
	if id == 7001 or id == 7002 then return { { layerWidth = 1002, layerHeight = 668, tileWidth = 256, tileHeight = 256 } } end
	return {}
end
C_Map.GetMapArtLayerTextures = function() local t = {}; for i = 1, 12 do t[i] = 100000 + i end; return t end
C_Map.GetMapArtID = function(id) return id == 7001 and 9001 or 9999 end
EXPLORED = {}
C_MapExplorationInfo = { GetExploredMapTextures = function(id) return EXPLORED end }
ZA = Polestar.UI.ZoneArt
ZA.RegisterOverlays("test", { [9001] = { 256, 256,
	{ 300, 200, 600, 100, 501, 502 },
	{ 100, 300, 50, 300, 503, 504 },
	{ 64, 64, 0, 0, 505 },
} })
art = ZA.Create(UIParent, 372, 172)
function shown(pool)
	local out = {}
	for _, t in ipairs(pool) do
		if t:IsShown() then
			local _, _, _, x, y = t:GetPoint(1)
			local layer, sub = t:GetDrawLayer()
			out[#out + 1] = { file = t:GetTexture(), x = x, y = y, w = t:GetWidth(), h = t:GetHeight(), tc = t.texCoord, sub = sub }
		end
	end
	table.sort(out, function(a, b) return a.file < b.file end)
	return out
end
function canvas()
	local _, _, _, x, y = art.Canvas:GetPoint(1)
	return { x = x, y = y, w = art.Canvas:GetWidth(), h = art.Canvas:GetHeight() }
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", &FILES)], script: format!("uistub.install()\nstub.login()\n{SETUP}\n{script}"), ..Default::default() })
		.remove(0)
}

fn near(a: f64, b: f64) -> bool {
	(a - b).abs() < 0.01
}

fn f(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}

fn files(v: &Value) -> Vec<i64> {
	v.as_array().unwrap().iter().map(|t| t["file"].as_i64().unwrap()).collect()
}

#[test]
fn the_place_lands_mid_band_horizontally_and_in_the_clear_stretch_between_the_top_shade_and_the_fade() {
	let out = run(r#"
		local painted, reveal = ZA.Paint(art, 7001, 43.3, 68.5)
		emit({ painted = painted, reveal = reveal, c = canvas(), fy = art.psFocusY, band = art.Band:IsShown() })"#);
	assert_eq!(out["painted"], true);
	assert_eq!(out["reveal"], "full");
	assert_eq!(out["band"], false);
	// Between the 40px top shade and the top of the fade (172 - floor(172 * 0.62) = 66).
	assert_eq!(out["fy"], 53);
	let c = &out["c"];
	let (x, y, w, h) = (f(&c["x"]), f(&c["y"]), f(&c["w"]), f(&c["h"]));
	let s = w / 1002.0;
	assert!(near(h / s, 668.0), "the painting keeps its aspect");
	// Canvas offset y is "up": the place sits at (186, 53) of the band.
	assert!(near(x + 0.433 * w, 186.0), "x {x}");
	assert!(near(0.685 * h - y, 53.0), "place at {}", 0.685 * h - y);
	// Never past the painting's edges.
	assert!(x <= 0.0 && x >= 372.0 - w && y >= 0.0 && y <= h - 172.0, "{}", out["c"]);
}

#[test]
fn a_place_near_an_edge_zooms_in_up_to_za_reframe_then_clamps_to_the_edge_no_focus_means_the_middle() {
	let out = run(r#"
		local base = math.max(372 / 1002, 172 / 668) * ZA.ZOOM
		ZA.Paint(art, 7001, 50, 40)
		local mid = canvas()
		ZA.Paint(art, 7001, 50, 97)
		local low = canvas()
		ZA.Paint(art, 7001, 2, 50)
		local left = canvas()
		ZA.Paint(art, 7001)
		local none = canvas()
		emit({ base = base, reframe = ZA.REFRAME, mid = mid, low = low, left = left, none = none })"#);
	let s = |c: &Value| f(&c["w"]) / 1002.0;
	let base = f(&out["base"]);
	let reframe = f(&out["reframe"]);
	let (mid, low, left, none) = (&out["mid"], &out["low"], &out["left"], &out["none"]);
	assert!(near(s(mid), base), "no edge in the way: the base zoom");
	assert!(near(s(low), base * reframe), "near the bottom: zoomed in to the cap");
	assert!(near(f(&low["y"]), f(&low["h"]) - 172.0), "then clamped to the bottom edge");
	assert!(near(s(left), base * reframe) && near(f(&left["x"]), 0.0), "near the left: capped zoom, clamped");
	assert!(near(f(&none["x"]) + 0.5 * f(&none["w"]), 186.0) && near(0.5 * f(&none["h"]) - f(&none["y"]), 53.0));
}

#[test]
fn only_the_base_tiles_the_band_shows_are_drawn_each_with_its_row_major_file() {
	let out = run(r#"
		ZA.Paint(art, 7001, 90, 90)
		emit({ c = canvas(), tiles = shown(art.Tiles) })"#);
	let c = &out["c"];
	let (x, y, w) = (f(&c["x"]), f(&c["y"]), f(&c["w"]));
	let s = w / 1002.0;
	// Window in layer pixels.
	let x0 = -x / s;
	let x1 = x0 + 372.0 / s;
	let y0 = y / s;
	let y1 = y0 + 172.0 / s;
	let mut expect: Vec<i64> = Vec::new();
	for r in 0..3i64 {
		for col in 0..4i64 {
			let (cx, ry) = ((col * 256) as f64, (r * 256) as f64);
			if cx < x1 && cx + 256.0 > x0 && ry < y1 && ry + 256.0 > y0 {
				expect.push(100000 + r * 4 + col + 1);
			}
		}
	}
	assert!(expect.len() < 12, "the bottom-right corner shows part of the painting");
	assert_eq!(files(&out["tiles"]), expect);
	for t in out["tiles"].as_array().unwrap() {
		let file = t["file"].as_i64().unwrap();
		let i = file - 100001;
		assert!(near(f(&t["x"]), ((i % 4) * 256) as f64 * s) && near(f(&t["y"]), -((i / 4) as f64) * 256.0 * s), "tile {file}");
		assert!(near(f(&t["w"]), 256.0 * s) && t["sub"] == 0);
	}
}

#[test]
fn every_overlay_the_band_meets_is_laid_over_the_base_the_way_the_world_map_lays_it_tiles_partial_tiles_texcoords() {
	let out = run(r#"
		art.psZoom = 0.5 -- the whole painting in view
		ZA.Paint(art, 7001, 50, 50)
		emit({ c = canvas(), shapes = shown(art.Shapes), pool = #art.Shapes })"#);
	let s = f(&out["c"]["w"]) / 1002.0;
	let by_file: BTreeMap<i64, &Value> = out["shapes"].as_array().unwrap().iter().map(|t| (t["file"].as_i64().unwrap(), t)).collect();
	assert_eq!(by_file.keys().copied().collect::<Vec<_>>(), vec![501, 502, 503, 504, 505]);
	// 300 wide over 256px tiles: a full tile, then 44 px cropped from a 64-wide file.
	assert_eq!(by_file[&501]["tc"], json!([0, 1, 0, 200.0 / 256.0]));
	assert!(near(f(&by_file[&501]["x"]), 600.0 * s) && near(f(&by_file[&501]["y"]), -100.0 * s) && near(f(&by_file[&501]["w"]), 256.0 * s) && near(f(&by_file[&501]["h"]), 200.0 * s));
	assert_eq!(by_file[&502]["tc"], json!([0, 44.0 / 64.0, 0, 200.0 / 256.0]));
	assert!(near(f(&by_file[&502]["x"]), (600.0 + 256.0) * s) && near(f(&by_file[&502]["w"]), 44.0 * s));
	// 300 high: row-major, the second file is the partial row under the first.
	assert_eq!(by_file[&503]["tc"], json!([0, 100.0 / 128.0, 0, 1]));
	assert_eq!(by_file[&504]["tc"], json!([0, 100.0 / 128.0, 0, 44.0 / 64.0]));
	assert!(near(f(&by_file[&504]["y"]), -(300.0 + 256.0) * s) && near(f(&by_file[&504]["h"]), 44.0 * s));
	assert!(out["shapes"].as_array().unwrap().iter().all(|t| t["sub"] == 1), "above the base tiles");
}

#[test]
fn overlays_outside_the_band_get_no_texture_and_textures_are_pooled_across_paints() {
	let out = run(r#"
		ZA.Paint(art, 7001, 90, 20) -- right, top: only the (600, 100) overlay is in view
		local a = shown(art.Shapes)
		local poolA = #art.Shapes
		ZA.Paint(art, 7001, 8, 90) -- left, bottom: only the (50, 300) one
		local b = shown(art.Shapes)
		ZA.Paint(art, 7001, 90, 20)
		emit({ a = a, b = b, poolA = poolA, poolAfter = #art.Shapes, again = #shown(art.Shapes) })"#);
	assert_eq!(files(&out["a"]), vec![501, 502]);
	assert_eq!(files(&out["b"]), vec![503, 504]);
	assert_eq!(out["poolA"], 2);
	assert_eq!(out["poolAfter"], 2, "no texture made twice");
	assert_eq!(out["again"], 2);
}

#[test]
fn a_map_whose_art_the_table_was_not_built_for_shows_only_what_the_client_lists_as_explored() {
	let out = run(r#"
		art.psZoom = 0.5
		EXPLORED = {
			{ textureWidth = 128, textureHeight = 128, offsetX = 10, offsetY = 20, fileDataIDs = { 601 }, isShownByMouseOver = false, isDrawOnTopLayer = false },
			{ textureWidth = 128, textureHeight = 128, offsetX = 300, offsetY = 300, fileDataIDs = { 602 }, isShownByMouseOver = true, isDrawOnTopLayer = false },
			{ textureWidth = 64, textureHeight = 64, offsetX = 500, offsetY = 300, fileDataIDs = { 603 }, isShownByMouseOver = false, isDrawOnTopLayer = true },
		}
		local _, reveal = ZA.Paint(art, 7002, 50, 50)
		local r = { reveal = reveal, shapes = shown(art.Shapes) }
		C_MapExplorationInfo = nil
		local _, none = ZA.Paint(art, 7002, 50, 50)
		r.none, r.after = none or false, #shown(art.Shapes)
		emit(r)"#);
	assert_eq!(out["reveal"], "explored");
	let pairs = Value::Array(out["shapes"].as_array().unwrap().iter().map(|t| json!([t["file"], t["sub"]])).collect());
	assert_eq!(pairs, json!([[601, 1], [603, 2]]), "mouse-over-only skipped, draw-on-top above");
	assert_eq!(out["none"], false);
	assert_eq!(out["after"], 0);
}

#[test]
fn no_art_for_the_map_the_night_band_nothing_of_the_painting_left_showing() {
	let out = run(r#"
		ZA.Paint(art, 7001, 50, 50)
		local painted = ZA.Paint(art, 4242, 50, 50, 2)
		emit({ painted = painted, band = art.Band:IsShown(), tiles = #shown(art.Tiles), shapes = #shown(art.Shapes) })"#);
	assert_eq!(out, json!({ "painted": false, "band": true, "tiles": 0, "shapes": 0 }));
}

#[test]
fn the_generated_overlay_table_registers_every_forever_zone_map_art_durotar_among_them() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: concat!(
			"uistub.install()\nstub.login()",
			r#"
			local ZA = Polestar.UI.ZoneArt
			local arts, n = 0, 0
			for _, list in pairs(ZA.overlays) do arts = arts + 1; n = n + #list - 2 end
			local d = ZA.overlays[2169]
			emit({ build = ZA.overlaysBuild, arts = arts, overlays = n, durotar = d and { d[1], d[2], #d - 2 } or false })"#
		)
		.into(),
		..Default::default()
	})
	.remove(0);
	assert!(is_match(text(&out["build"]), r"^1\.60\.1\.\d+$"));
	assert!(f(&out["arts"]) > 40.0 && f(&out["overlays"]) > 500.0, "{out}");
	let d = &out["durotar"];
	assert_eq!(json!([d[0], d[1]]), json!([256, 256]));
	assert!(f(&d[2]) > 10.0);
}
