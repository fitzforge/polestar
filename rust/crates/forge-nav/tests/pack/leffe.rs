//! `forge nav pack --leffe` (maps format 5): Zephras Isle from Leffe's navigation maps on a real grid, opt-in.
//!
//! PACK_GRID=<grid> PACK_ROOT=<checkout: data/forever, data/sources/wago> PACK_LAYERS=<nav-layers>
//! POLESTAR_LEFFE_NAV=<his Nav folder or the folder holding it> cargo test --profile quick -p forge-nav --test pack
//! -- --ignored leffe

use super::{files_under, tmp};
use forge_nav::pack::{pack_nav, ship_pack, PackIn};
use std::path::PathBuf;

fn pack(leffe: Option<(&std::path::Path, &[u32])>, name: &str) -> PathBuf {
	let env = |k: &str| PathBuf::from(std::env::var(k).unwrap_or_else(|_| panic!("needs {k}")));
	let (grid, root, layers) = (env("PACK_GRID"), env("PACK_ROOT"), env("PACK_LAYERS"));
	let wago = root.join("data/sources/wago");
	let mut builds: Vec<String> = std::fs::read_dir(&wago).unwrap().flatten().map(|e| e.file_name().to_string_lossy().into_owned()).filter(|b| wago.join(b).join("AreaTable.csv").is_file()).collect();
	builds.sort_by_key(|b| b.split('.').map(|p| p.parse::<u64>().unwrap_or(0)).collect::<Vec<_>>());
	let aids = grid.join("aids.json");
	let pack = pack_nav(&PackIn {
		grid: &grid,
		layers: &layers,
		area_table: &wago.join(builds.last().unwrap()).join("AreaTable.csv"),
		zones: &root.join("data/forever/zones.json"),
		map_frames: &root.join("data/forever/map-frames.json"),
		aids: aids.is_file().then_some(aids.as_path()),
		cells: 128,
		date: "2026-10-25",
		continents: &[2991],
		generator: "forge nav pack",
		leffe,
		zlib_literals: true,
		log: &|m| eprintln!("{m}"),
	})
	.unwrap();
	let out = tmp(name);
	ship_pack(&pack, &out).unwrap();
	out
}

#[test]
#[ignore = "needs PACK_GRID, PACK_ROOT, PACK_LAYERS and POLESTAR_LEFFE_NAV"]
fn leffe_zephras_packs_his_maps_as_format_5_and_naming_no_map_of_his_packs_the_grids() {
	let leffe = PathBuf::from(std::env::var("POLESTAR_LEFFE_NAV").expect("needs POLESTAR_LEFFE_NAV"));
	let his = pack(Some((&leffe, &[2991])), "leffe");
	let meta = std::fs::read_to_string(his.join("Nav/Nav2991.lua")).unwrap();
	assert!(meta.lines().any(|l| l == "\tformat = 5,"), "maps format 5");
	assert!(meta.lines().any(|l| l == "\tarc = {},"), "the arc field");
	assert!(meta.lines().any(|l| l == "\tblocks = \"zlib\","), "the blocks as zlib bytes");
	assert!(
		meta.lines().next().unwrap().contains("--leffe` from the navigation grid") && meta.lines().next().unwrap().contains("and Leffe's navigation maps on 2026-10-25."),
		"the header credits his maps"
	);
	let manifest: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(his.join("PACK.json")).unwrap()).unwrap();
	assert_eq!(manifest["format"], 5);
	let m = &manifest["maps"]["2991"];
	// His Zephras Isle (PACK.json of the 70532 candidate): 4,890 entrances, 164,403 floors, 47,951 directed jumps.
	assert_eq!(m["nodes"], 4890, "every entrance of his graph");
	let (kept, dropped) = (m["leffe"]["floors"].as_u64().unwrap(), m["leffe"]["droppedFloors"].as_u64().unwrap());
	assert_eq!(kept + dropped, 164403, "every floor of his, kept or dropped as no walk can use it");
	assert!(dropped > 20000 && dropped < 40000, "about a fifth dropped: {dropped}");
	assert!(m["leffe"]["arcs"].as_u64().unwrap() > 20000, "his jumps and drops as arcs: {}", m["leffe"]["arcs"]);
	assert!(m["leffe"]["areaSurfaces"].as_u64().unwrap() > 10000, "areas carried onto his surfaces");
	let parts: Vec<u8> = files_under(&his.join("Nav")).iter().filter(|f| f.starts_with("Nav2991_")).flat_map(|f| std::fs::read(his.join("Nav").join(f)).unwrap()).collect();
	let text = String::from_utf8_lossy(&parts);
	assert!(text.contains("data.packed.arc["), "arcs packed");
	assert!(parts.iter().any(|&b| b >= 0x80) && !text.contains("{\"eNo"), "zlib bytes in the literals, not base64 (zlib's header in base64 starts eNo)");
	assert!(forge_nav::pack::check_pack(&his).is_empty(), "nav check: {:?}", forge_nav::pack::check_pack(&his));
	// --leffe-maps without this map: the grid's maps, byte for byte.
	let ours = pack(Some((&leffe, &[])), "leffe-none");
	let grid = pack(None, "grid");
	for f in files_under(&grid.join("Nav")) {
		assert!(std::fs::read(ours.join("Nav").join(&f)).unwrap() == std::fs::read(grid.join("Nav").join(&f)).unwrap(), "Nav/{f} differs");
	}
	for d in [his, ours, grid] {
		let _ = std::fs::remove_dir_all(d);
	}
}
