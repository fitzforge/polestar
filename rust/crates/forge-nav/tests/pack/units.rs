//! The writer's rules on their own (ported from tests/navmesh-pack.test.js and navmesh-chokepoints.test.js):
//! ground classes, capitals, zones, place names, the encodings, ship/check, refusing a broken grid, and
//! maps format 3's area field from the grid's area sidecars.

use super::{golden_dir, tmp};
use forge_nav::grid::flag;
use forge_nav::pack::encode::{encode_areas, encode_zones, run_length, BLOCK_BYTES, PART_BYTES};
use forge_nav::pack::layers::{AreaName, AreaTable};
use forge_nav::pack::{check_pack, enc, mult, node_class, own_file, pack_nav, ship_pack, PackIn, CLASS, HUB_ALLIANCE, HUB_HORDE, SLOPE_GENTLE, SLOPE_STEEP};
use std::io::Read;
use std::path::Path;

#[test]
fn node_class_precedence_steep_indoor_road_gentle_normal_city_and_hub_bits() {
	let (steep, gentle) = (SLOPE_STEEP, SLOPE_GENTLE);
	assert_eq!(node_class(0, 0, false, false, 0), CLASS::NORMAL);
	assert_eq!(node_class(0, steep, true, false, 0), CLASS::STEEP, "a steep road stays steep");
	assert_eq!(node_class(flag::INDOOR, steep, false, false, 0), CLASS::STEEP);
	assert_eq!(node_class(flag::INDOOR, 0, true, false, 0), CLASS::INDOOR, "an indoor road is indoor");
	assert_eq!(node_class(flag::INDOOR, 0, false, true, 0), CLASS::CITY, "indoor in a capital is indoor city");
	assert_eq!(node_class(0, 0, false, true, 0), CLASS::NORMAL, "outdoors in a capital is plain ground");
	assert_eq!(node_class(0, gentle, true, false, 0), CLASS::ROAD, "a gentle road is a road");
	assert_eq!(node_class(flag::SWIM, 0, true, false, 0), CLASS::NORMAL, "a road under water is no road");
	assert_eq!(node_class(0, gentle, false, false, 0), CLASS::GENTLE);
	assert_eq!(node_class(0, gentle - 1, false, false, 0), CLASS::NORMAL);
	assert_eq!(node_class(0, steep - 1, false, false, 0), CLASS::GENTLE);
	assert_eq!(node_class(0, 0, true, false, HUB_ALLIANCE | HUB_HORDE | 64), CLASS::ROAD | HUB_ALLIANCE | HUB_HORDE, "both hub bits, nothing else");
}

#[test]
fn multipliers_by_class_and_hostile_hubs() {
	assert_eq!(mult(CLASS::ROAD, None), 0.8);
	assert_eq!(mult(CLASS::STEEP, Some("Alliance")), 2.5);
	assert_eq!(mult(6, None), 1.0, "classes 6 and 7 cost as normal ground");
	assert_eq!(mult(CLASS::ROAD | HUB_ALLIANCE, Some("Horde")), 0.8 * 20.0, "an Alliance hub is hostile to Horde");
	assert_eq!(mult(CLASS::ROAD | HUB_ALLIANCE, Some("Alliance")), 0.8);
	assert_eq!(mult(CLASS::NORMAL | HUB_HORDE, Some("Alliance")), 20.0);
	assert_eq!(mult(CLASS::NORMAL | HUB_HORDE, None), 1.0, "no profile crosses every hub");
}

#[test]
fn capitals_are_the_flagged_areas_and_every_area_under_one() {
	let t = AreaTable::parse("ID,ParentAreaID,Flags_0\n1,0,65\n1519,0,312\n1617,1519,1073741888\n9,1617,0\n809,1,1073741888\n").unwrap();
	let mut c: Vec<u32> = t.capitals().into_iter().collect();
	c.sort();
	assert_eq!(c, [9, 1519, 1617]);
}

#[test]
fn a_chunk_zone_resolves_up_its_parents_to_a_zone_with_no_map_frame() {
	// Riverglades (16591, uiMap 2548) has no Era frame; Sunnyglade (16723) is its subzone; Lakeshire (69) is
	// Redridge's (44, 1433); 7 is no zone's; 900 is an entry of another type inside Riverglades, 901 in it.
	let t = AreaTable::parse("ID,ParentAreaID,Flags_0\n16591,0,0\n16723,16591,0\n44,0,0\n69,44,0\n7,0,0\n900,16591,0\n901,900,0\n").unwrap();
	let zones = serde_json::json!({
		"1415": { "id": 1415, "areaId": null, "type": 2 },
		"1433": { "id": 1433, "areaId": 44, "type": 3 },
		"2548": { "id": 2548, "areaId": 16591, "type": 3 },
		"2600": { "id": 2600, "areaId": 900, "type": 6 },
	});
	let z = t.zone_of(&zones);
	let got: Vec<u32> = [16723, 16591, 69, 44, 7, 0, 900, 901].iter().map(|&a| z(a)).collect();
	assert_eq!(got, [2548, 2548, 1433, 1433, 0, 0, 2548, 2548]);
}

#[test]
fn place_names_name_the_area_and_its_zone_never_empty() {
	let t = AreaTable::parse("ID,AreaName_lang,ZoneName,ParentAreaID\n1,Dun Morogh,,0\n131,Kharanos,,1\n77,,Zone Name,0\n78,,,77\n").unwrap();
	assert_eq!(t.names(131), Some(AreaName { name: "Kharanos".into(), area: 131, zone: "Dun Morogh".into(), zone_area: 1 }));
	assert_eq!(t.names(1), Some(AreaName { name: "Dun Morogh".into(), area: 1, zone: "Dun Morogh".into(), zone_area: 1 }));
	assert_eq!(t.names(78), Some(AreaName { name: "Zone Name".into(), area: 77, zone: "Zone Name".into(), zone_area: 77 }), "a nameless area takes its zone's");
	assert_eq!(t.names(5), None);
}

#[test]
fn encodings_base64_numbers_run_lengths_and_zones() {
	assert_eq!(enc(0.0, 2).unwrap(), "AA");
	assert_eq!(enc(64.0 * 3.0 + 5.0, 2).unwrap(), "DF");
	assert!(enc(4096.0, 2).is_err() && enc(-1.0, 1).is_err() && enc(1.5, 1).is_err());
	// A symbol >= 48 repeats the previous value (symbol - 47) more times, at most 16 at a time.
	assert_eq!(run_length(&[1, 1, 1, 0]), "BxA");
	let mut long = vec![2u8; 18];
	long.push(3);
	assert_eq!(run_length(&long), "C/wD");
	assert_eq!(encode_zones(&[1433, 1433, 0]).unwrap(), "WZwAA");
	assert!(encode_zones(&[48 * 64]).is_err());
	// The area field: 3-symbol WMOAreaTable row ids, run-length as the zone field.
	assert_eq!(encode_areas(&[0, 0, 0, 141120, 141120, 5]).unwrap(), "AAAxidAwAAF");
	assert_eq!(encode_areas(&[0; 18]).unwrap(), "AAA/w");
	assert_eq!(encode_areas(&[48 * 64 * 64 - 1]).unwrap(), "v//");
	assert!(encode_areas(&[48 * 64 * 64]).is_err());
}

#[test]
fn own_files_are_our_maps_and_the_chokepoints() {
	for n in ["Nav0.lua", "Nav0_12.lua", "Nav1_1.lua", "Nav2991.lua", "Chokepoints.lua"] {
		assert!(own_file(n), "{n}");
	}
	for n in ["Nav.xml", "Nav7.lua", "Nav0_.lua", "Nav0_a.lua", "Walk.lua"] {
		assert!(!own_file(n), "{n}");
	}
}

fn pack_into(grid: &Path, out: &Path, cells: usize) -> Result<forge_nav::pack::Pack, String> {
	let p = golden_dir().join("nav-pack");
	let log = |_: &str| {};
	let pack = pack_nav(&PackIn {
		grid,
		layers: &p.join("nav-layers"),
		area_table: &p.join("data/AreaTable.csv"),
		zones: &p.join("data/zones.json"),
		map_frames: &p.join("data/map-frames.json"),
		aids: None,
		cells,
		date: "2026-10-16",
		continents: &[0],
		generator: "forge nav pack",
		log: &log,
	})?;
	ship_pack(&pack, out)?;
	Ok(pack)
}

#[test]
fn ship_writes_files_pack_json_and_nav_xml_and_check_finds_changed_missing_unlisted() {
	let grid = golden_dir().join("nav-grid/nav4");
	let out = tmp("ship").join("Polestar_Nav");
	std::fs::create_dir_all(out.join("Nav")).unwrap();
	std::fs::write(out.join("Nav/Nav0_9.lua"), "stale\n").unwrap();
	std::fs::write(out.join("Nav/Nav2991_1.lua"), "his old map\n").unwrap();
	std::fs::write(out.join("Nav/Walk.lua"), "not ours\n").unwrap();
	let pack = forge_nav::pack::pack_nav(&PackIn {
		grid: &grid,
		layers: &golden_dir().join("nav-pack/nav-layers"),
		area_table: &golden_dir().join("nav-pack/data/AreaTable.csv"),
		zones: &golden_dir().join("nav-pack/data/zones.json"),
		map_frames: &golden_dir().join("nav-pack/data/map-frames.json"),
		aids: None,
		cells: 67,
		date: "2026-10-16",
		continents: &[0],
		generator: "forge nav pack",
		log: &|_| {},
	})
	.unwrap();
	let (written, removed) = ship_pack(&pack, &out).unwrap();
	assert_eq!(removed, ["Nav/Nav0_9.lua", "Nav/Nav2991_1.lua"], "parts the pack no longer has, of any map of ours");
	assert!(out.join("Nav/Walk.lua").is_file(), "a file not ours stays");
	let m: serde_json::Value = serde_json::from_slice(&std::fs::read(out.join("PACK.json")).unwrap()).unwrap();
	assert_eq!(m["cells"], 67);
	assert_eq!(m["date"], "2026-10-16");
	let listed: Vec<String> = m["files"].as_object().unwrap().keys().cloned().collect();
	assert_eq!(listed, written);
	assert_eq!(listed, pack.files.iter().map(|f| format!("Nav/{}", f.0)).collect::<Vec<_>>());
	assert!(std::fs::read_to_string(out.join("Nav/Nav0.lua")).unwrap().starts_with("-- Generated by `forge nav pack --cells 67` from the navigation grid ("));
	let xml = std::fs::read_to_string(out.join("Nav/Nav.xml")).unwrap();
	let scripts: Vec<&str> = xml.lines().filter_map(|l| l.trim().strip_prefix("<Script file=\"")?.strip_suffix("\"/>")).collect();
	assert_eq!(scripts, pack.files.iter().map(|f| f.0.as_str()).collect::<Vec<_>>(), "the packed maps, the chokepoints last");
	assert_eq!(scripts.last(), Some(&"Chokepoints.lua"));
	assert!(check_pack(&out).is_empty());
	std::fs::write(out.join("Nav/Nav0.lua"), format!("{}-- edited\n", std::fs::read_to_string(out.join("Nav/Nav0.lua")).unwrap())).unwrap();
	std::fs::write(out.join("Nav/Nav0_7.lua"), "\n").unwrap();
	std::fs::remove_file(out.join("Nav/Nav0_1.lua")).unwrap();
	assert_eq!(check_pack(&out), ["Nav/Nav0.lua differs from PACK.json", "Nav/Nav0_1.lua is missing", "Nav/Nav0_7.lua is not listed in PACK.json"]);
	std::fs::write(out.join("Nav/Nav.xml"), "<Ui/>\n").unwrap();
	assert!(check_pack(&out).last().unwrap().starts_with("Nav/Nav.xml does not list the packed maps"));
	std::fs::remove_file(out.join("PACK.json")).unwrap();
	assert!(check_pack(&out)[0].ends_with("PACK.json is missing: run `forge nav pack`"));
	let again = pack_into(&grid, &tmp("ship-again"), 67).unwrap();
	assert_eq!(again.files, pack.files, "deterministic");
}

fn unbase64(s: &str) -> Vec<u8> {
	const A: &[u8] = forge_nav::pack::B64;
	let mut out = Vec::new();
	let (mut acc, mut bits) = (0u32, 0);
	for b in s.bytes().filter(|&b| b != b'=') {
		acc = (acc << 6) | A.iter().position(|&x| x == b).unwrap() as u32;
		bits += 6;
		if bits >= 8 {
			bits -= 8;
			out.push((acc >> bits) as u8);
		}
	}
	out
}

#[test]
fn blocks_fit_the_clients_16_kb_inflate_buffer_and_parts_stay_under_512_kb() {
	let out = tmp("blocks");
	let pack = pack_into(&golden_dir().join("nav-grid/nav4"), &out, 128).unwrap();
	assert_eq!(pack.files[0].0, "Nav0.lua", "the metadata file first, then its parts");
	assert_eq!(pack.files[1].0, "Nav0_1.lua");
	let mut blocks = 0;
	for (name, src) in &pack.files {
		assert!(src.len() <= PART_BYTES, "{name} within a part");
		for line in src.lines().filter(|l| l.starts_with("data.packed.")) {
			for b in line.split('"').skip(1).step_by(2) {
				let mut raw = Vec::new();
				flate2::read::ZlibDecoder::new(&unbase64(b)[..]).read_to_end(&mut raw).unwrap();
				assert!(raw.len() <= BLOCK_BYTES);
				blocks += 1;
			}
		}
	}
	assert!(blocks > 4);
}

#[test]
fn a_tile_the_grid_lists_but_cannot_read_stops_the_pack_naming_it() {
	let src = golden_dir().join("nav-grid/nav4");
	let copy = |name: &str| -> std::path::PathBuf {
		let d = tmp(name);
		for f in ["index.json", "lifts.json", "graph"] {
			std::os::unix::fs::symlink(src.join(f), d.join(f)).unwrap();
		}
		std::fs::create_dir_all(d.join("tiles/0")).unwrap();
		for e in std::fs::read_dir(src.join("tiles/0")).unwrap().flatten() {
			std::fs::copy(e.path(), d.join("tiles/0").join(e.file_name())).unwrap();
		}
		d
	};
	let tile = |d: &Path| d.join("tiles/0/33_32.nav.gz");
	let missing = copy("missing");
	std::fs::remove_file(tile(&missing)).unwrap();
	let e = pack_into(&missing, &tmp("missing-out"), 32).err().unwrap();
	assert!(e.starts_with("pack: tile 0/33_32: "), "{e}");
	let truncated = copy("truncated");
	let b = std::fs::read(tile(&truncated)).unwrap();
	std::fs::write(tile(&truncated), &b[..100]).unwrap();
	let e = pack_into(&truncated, &tmp("truncated-out"), 32).err().unwrap();
	assert!(e.starts_with("pack: tile 0/33_32: "), "{e}");
	let older = copy("older");
	let mut raw = Vec::new();
	flate2::read::GzDecoder::new(&std::fs::read(tile(&older)).unwrap()[..]).read_to_end(&mut raw).unwrap();
	raw[4..8].copy_from_slice(&2u32.to_le_bytes());
	let mut gz = flate2::write::GzEncoder::new(Vec::new(), flate2::Compression::default());
	std::io::Write::write_all(&mut gz, &raw).unwrap();
	std::fs::write(tile(&older), gz.finish().unwrap()).unwrap();
	let e = pack_into(&older, &tmp("older-out"), 32).err().unwrap();
	assert_eq!(e, "pack: tile 0/33_32: nav tile version 2");
}

/// The area field's run-length (encode_areas): a symbol < 48 starts a 3-symbol row id, one >= 48
/// repeats the previous one (symbol - 47) more times. -> one id per node.
fn decode_areas(s: &str) -> Vec<u32> {
	let at = |b: u8| forge_nav::pack::B64.iter().position(|&x| x == b).unwrap() as u32;
	let b = s.as_bytes();
	let mut out = Vec::new();
	let mut i = 0;
	while i < b.len() {
		let a = at(b[i]);
		if a < 48 {
			out.push((a * 64 + at(b[i + 1])) * 64 + at(b[i + 2]));
			i += 3;
		} else {
			let last = *out.last().unwrap();
			out.extend(std::iter::repeat_n(last, (a - 47) as usize));
			i += 1;
		}
	}
	out
}

/// The grid field's run-length (run_length) -> one value per cell.
fn decode_run_length(s: &str) -> Vec<u32> {
	let mut out = Vec::new();
	for b in s.bytes() {
		let a = forge_nav::pack::B64.iter().position(|&x| x == b).unwrap() as u32;
		if a < 48 {
			out.push(a);
		} else {
			let last = *out.last().unwrap();
			out.extend(std::iter::repeat_n(last, (a - 47) as usize));
		}
	}
	out
}

/// A packed field of cluster k (1-based) from a pack's parts, its blocks inflated and joined.
fn packed(pack: &forge_nav::pack::Pack, field: &str, k: usize) -> Option<String> {
	let head = format!("data.packed.{field}[{k}] = {{");
	let line = pack.files.iter().flat_map(|f| f.1.lines()).find(|l| l.starts_with(&head))?;
	let mut raw = Vec::new();
	for b in line[head.len()..].split('"').skip(1).step_by(2) {
		flate2::read::ZlibDecoder::new(&unbase64(b)[..]).read_to_end(&mut raw).unwrap();
	}
	Some(String::from_utf8(raw).unwrap())
}

#[test]
fn maps_format_3_the_area_sidecars_give_each_node_its_wmo_area_row_and_the_metadata_its_names_a_grid_without_them_stays_format_2() {
	let src = golden_dir().join("nav-grid/nav4");
	let grid = tmp("areas");
	for f in ["index.json", "lifts.json", "graph"] {
		std::os::unix::fs::symlink(src.join(f), grid.join(f)).unwrap();
	}
	std::fs::create_dir_all(grid.join("tiles/0")).unwrap();
	for e in std::fs::read_dir(src.join("tiles/0")).unwrap().flatten() {
		std::fs::copy(e.path(), grid.join("tiles/0").join(e.file_name())).unwrap();
	}
	let before = pack_into(&grid, &tmp("areas-before"), 128).unwrap();
	assert_eq!(before.manifest["format"], 2);
	assert!(before.manifest["maps"]["0"].get("areas").is_none());
	assert!(!before.files[0].1.contains("\n\tarea = ") && !before.files[0].1.contains("\n\tareaNames = ") && before.files[0].1.contains("\n\tformat = 2,\n"));
	assert!(packed(&before, "area", 4).is_none());
	// Tile 32_32 (cluster 4): every entry in the Trade Quarter (row 141120). Tile 33_33 (cluster 1): every other
	// entry in the Canals (row 7), the rest in row 8, which has no name: a surface takes its entries' commonest
	// row, and a row without a name is packed as none (the planner matches areas by name).
	let sidecar = |tile: &str, area: &dyn Fn(usize) -> u32| {
		let t = forge_nav::grid::Tile::decode(&forge_nav::grid::gunzip(&std::fs::read(grid.join(format!("tiles/0/{tile}.nav.gz"))).unwrap()).unwrap()).unwrap();
		let raw: Vec<u8> = (0..t.n).flat_map(|e| area(e).to_le_bytes()).collect();
		let mut gz = flate2::write::GzEncoder::new(Vec::new(), flate2::Compression::default());
		std::io::Write::write_all(&mut gz, &raw).unwrap();
		std::fs::write(grid.join(format!("tiles/0/{tile}.area.gz")), gz.finish().unwrap()).unwrap();
	};
	sidecar("32_32", &|_| 141120);
	sidecar("33_33", &|e| if e % 2 == 0 { 7 } else { 8 });
	std::fs::write(grid.join("areas.json"), r#"{ "7": ["The Canals", 1497], "8": ["", 1497], "141120": ["Trade Quarter", 1497] }"#).unwrap();
	let after = pack_into(&grid, &tmp("areas-after"), 128).unwrap();
	assert_eq!(after.manifest["format"], 3);
	assert_eq!(after.manifest["maps"]["0"]["areas"], 2);
	let meta = &after.files[0].1;
	assert!(meta.contains("\n\tformat = 3,\n"));
	assert!(
		meta.contains("\n\tarea = {},\n\tareaNames = {\n\t\t[7] = \"The Canals\",\n\t\t[141120] = \"Trade Quarter\",\n\t},\n\tcounts = {"),
		"the area field is packed, as the class field is; its named rows named"
	);
	assert!(meta.contains(", area = 2 },\n") && meta.contains(", class = {}, area = {} },\n"), "counted and packed in the parts");
	assert!(packed(&after, "area", 2).is_none() && packed(&after, "area", 3).is_none(), "a cluster without areas has no area field");
	let c2 = 128 * 128;
	// Cluster 4: every node (each walkable base cell and every floor) of row 141120, a blocked cell none.
	let area = decode_areas(&packed(&after, "area", 4).unwrap());
	let cells = decode_run_length(&packed(&after, "grid", 4).unwrap());
	assert_eq!(cells.len(), c2);
	assert!(area.len() > c2, "the tile has floors");
	for (l, &a) in area.iter().enumerate() {
		let walkable = l >= c2 || cells[l] >> 4 != 0;
		assert_eq!(a, if walkable { 141120 } else { 0 }, "node {l}");
	}
	let area = decode_areas(&packed(&after, "area", 1).unwrap());
	assert!(area.contains(&7) && area.iter().all(|&a| a == 0 || a == 7), "row 8, unnamed, is packed as none");
	let again = pack_into(&grid, &tmp("areas-again"), 128).unwrap();
	assert_eq!(again.files, after.files, "deterministic");
}
