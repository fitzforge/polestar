//! Polestar_Nav's maps are used whole or not at all (addon/Polestar_Nav/API.lua): a map whose part file is
//! missing from the folder (or failed to load) is dropped, so the engine reports no data for it and Polestar's
//! arrow points straight, instead of the engine raising a Lua error when a search crosses a cluster whose graph
//! it cannot read. Without the client's decoder (C_EncodingUtil) every map is dropped. Checks from
//! docs/NAV_QA.md name their row (C17: a missing or unloadable map file).

use std::collections::HashSet;
use std::fs;
use std::path::PathBuf;

use forge_addontest::run::{addons_dir, toc_files};
use forge_addontest::{emitted, text, Addon, RunAddon};
use regex::Regex;
use serde_json::json;

const T: f64 = 1600.0 / 3.0;

fn nav() -> PathBuf {
	addons_dir().join("Polestar_Nav")
}

// Where a map's part files are: its part addon (maps format 5: Polestar_Nav_EK, _Kalimdor) or Polestar_Nav/Nav.
fn parts_dir(map: i32) -> (PathBuf, Option<&'static str>) {
	match forge_nav::pack::part_of(map as u32).filter(|p| addons_dir().join(p).is_dir()) {
		Some(p) => (addons_dir().join(p), Some(p)),
		None => (nav().join("Nav"), None),
	}
}

// The cluster of a world point on `map` (its metadata file's frame), and the part file holding its graph.
fn part_of(map: i32, wx: f64, wy: f64) -> Option<String> {
	let meta = fs::read_to_string(nav().join("Nav").join(format!("Nav{map}.lua"))).unwrap();
	let num = |k: &str| -> i64 { Regex::new(&format!(r"\t{k} = (-?\d+),")).unwrap().captures(&meta).unwrap_or_else(|| panic!("no {k} in Nav{map}.lua"))[1].parse().unwrap() };
	let k = ((wx / T).floor() as i64 - num("cx0")) * num("ny") + ((wy / T).floor() as i64 - num("cy0"));
	let re = Regex::new(&format!(r"^Nav{map}_\d+\.lua$")).unwrap();
	let needle = format!(".graph[{}] = ", k + 1);
	let dir = parts_dir(map).0;
	let mut names: Vec<String> = fs::read_dir(&dir).unwrap().map(|e| e.unwrap().file_name().to_string_lossy().into_owned()).collect();
	names.sort();
	names.into_iter().find(|f| re.is_match(f) && String::from_utf8_lossy(&fs::read(dir.join(f)).unwrap()).contains(&needle))
}

// Walks crossing several clusters (and part files): Stranglethorn's jungle to Goldshire, the Crossroads to
// Camp Taurajo.
fn walks(map: i32) -> [[f64; 2]; 2] {
	match map {
		0 => [[-11920.0, -480.0], [-9444.062, 77.667]],
		1 => [[-440.0, -2650.0], [-2373.69, -1835.75]],
		_ => unreachable!(),
	}
}

// A part file of `map` holding a cluster the walk crosses, but neither end's.
fn middle_part(map: i32) -> Option<String> {
	let [a, b] = walks(map);
	let ends: HashSet<Option<String>> = [part_of(map, a[0], a[1]), part_of(map, b[0], b[1])].into_iter().collect();
	for t in [0.5, 0.45, 0.55, 0.4, 0.6, 0.35, 0.65, 0.3, 0.7] {
		let file = part_of(map, a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t);
		if file.is_some() && !ends.contains(&file) {
			return file;
		}
	}
	None
}

// An addon's files without `drop`, relative to its folder.
fn without(addon: &str, drop: &str) -> Vec<String> {
	let dir = addons_dir().join(addon);
	toc_files(addon).unwrap().iter().filter(|f| f.file_name().map(|n| n.to_string_lossy() != drop).unwrap_or(true)).map(|f| f.strip_prefix(&dir).unwrap().to_string_lossy().into_owned()).collect()
}

const WALK_LUA: &str = r#"
local Path = Polestar_NavEngine
local frames = {}
Path.after = function(fn) frames[#frames + 1] = fn end
local ok, pts, why = pcall(Path.FindSync, @MAP@, { x = @AX@, y = @AY@ }, { x = @BX@, y = @BY@ })
local got
Path.Find(@MAP@, { x = @AX@, y = @AY@ }, { x = @BX@, y = @BY@ }, function(points, reason) got = { found = points ~= nil, reason = reason } end)
while #frames > 0 do table.remove(frames, 1)() end
emit({ ok = ok, found = ok and pts ~= nil, why = (ok and not pts) and why or (not ok and tostring(pts)) or nil, available = { Path.Available(0), Path.Available(1), Path.Available(2991) }, async = got })"#;

fn walk(map: i32) -> String {
	let [a, b] = walks(map);
	WALK_LUA.replace("@MAP@", &map.to_string()).replace("@AX@", &a[0].to_string()).replace("@AY@", &a[1].to_string()).replace("@BX@", &b[0].to_string()).replace("@BY@", &b[1].to_string())
}

fn c17(map: i32) {
	let drop = middle_part(map);
	assert!(drop.is_some(), "a part file holding a cluster between the walk's ends (map {map})");
	let drop = drop.unwrap();
	let whole = emitted(&RunAddon { stubs: vec!["stub_encoding.lua"], addons: vec![Addon::name("Polestar_Nav")], script: walk(map), ..Default::default() }).remove(0);
	assert_eq!(whole["found"], true, "with every file the walk routes (map {map})");
	// The file goes missing from Polestar_Nav, or from the map's part addon (which the router loads on demand).
	let (_, part) = parts_dir(map);
	let files = without(part.unwrap_or("Polestar_Nav"), &drop);
	let files: Vec<&str> = files.iter().map(String::as_str).collect();
	let addons = match part {
		Some(p) => vec![Addon::name("Polestar_Nav"), Addon::files(p, &files)],
		None => vec![Addon::files("Polestar_Nav", &files)],
	};
	let out = emitted(&RunAddon { stubs: vec!["stub_encoding.lua"], addons, script: walk(map), ..Default::default() }).remove(0);
	assert_eq!(out["ok"], true, "no Lua error without {drop}: {}", text(&out["why"]));
	assert_eq!(out["found"], false);
	assert_eq!(out["why"], "nodata", "the map is dropped whole");
	assert_eq!(out["async"], json!({ "found": false, "reason": "nodata" }), "a sliced search reports no data, never the error handler");
	assert_eq!(out["available"], json!([map != 0, map != 1, true]), "only that map");
}

#[test]
fn c17_a_part_file_of_map_0_missing_from_the_folder_drops_that_map_no_data_the_straight_arrow_with_no_lua_error_the_other_maps_still_route() {
	c17(0);
}

#[test]
fn c17_a_part_file_of_map_1_missing_from_the_folder_drops_that_map_no_data_the_straight_arrow_with_no_lua_error_the_other_maps_still_route() {
	c17(1);
}

#[test]
fn without_the_client_s_decoder_c_encodingutil_every_map_reports_no_data_with_no_lua_error() {
	let out = emitted(&RunAddon { addons: vec![Addon::name("Polestar_Nav")], before: "C_EncodingUtil = nil".into(), script: walk(0), ..Default::default() }).remove(0);
	assert_eq!(out["ok"], true, "{}", text(&out["why"]));
	assert_eq!(out["why"], "nodata");
	assert_eq!(out["available"], json!([false, false, false]));
}
