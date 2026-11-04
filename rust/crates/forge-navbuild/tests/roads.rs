//! The roads layer (`forge nav layers roads`): parity with the JS layer (tools/lib/nav/layers/roads.js) on
//! the nav-layers golden's synthetic CASC slice (its README), and the tex0 parser, the weights and the road
//! shapes on their own (ported from tests/nav-roads.test.js).

use forge_navbuild::build::js_json;
use forge_navbuild::geom::{CacheDir, Tables};
use forge_navbuild::roads::{allowlist_doc, build_roads, parse_tex0, road_allowlist, road_by_shape, shape_of, texture_key, tile_road_weights};
use rustc_hash::FxHashSet;
use std::path::{Path, PathBuf};

fn golden() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden/nav-layers")
}

const BUILD: &str = "1.60.0.99999";

fn inputs() -> (CacheDir, Tables, PathBuf, serde_json::Value) {
	let g = golden().join("roads-in");
	let src = CacheDir(g.join("sources/casc/synthetic").join(BUILD));
	let wago = g.join("sources/wago").join(BUILD);
	let tables = Tables::from_csv(|name| if name == "Map" { std::fs::read_to_string(wago.join("Map.csv")).map_err(|e| e.to_string()) } else { Ok("ID\n".into()) }).unwrap();
	let allow: serde_json::Value = serde_json::from_slice(&std::fs::read(g.join("road-textures.json")).unwrap()).unwrap();
	(src, tables, g.join("sources/listfile/community-listfile.csv"), allow)
}

fn tmp(name: &str) -> PathBuf {
	let d = std::env::temp_dir().join(format!("forge-navbuild-roads-{name}-{}", std::process::id()));
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

#[test]
fn roads_layer_matches_the_js() {
	let (src, tables, listfile, allow) = inputs();
	let keys: FxHashSet<String> = allow["textures"].as_array().unwrap().iter().map(|t| texture_key(t.as_str().unwrap())).collect();
	let out = tmp("layer");
	let stats = build_roads(&src, &tables, BUILD, &[0, 1], &out, &listfile, &keys, &|_| {}).unwrap();
	assert_eq!(stats.iter().map(|s| (s.tiles, s.road_tiles, s.big_alpha)).collect::<Vec<_>>(), [(2, 1, true), (1, 1, false)]);
	let want = golden().join("roads-out/roads");
	for f in ["index.json", "0/32_32.bin", "0/33_32.bin", "1/40_40.bin"] {
		assert!(std::fs::read(out.join(f)).unwrap() == std::fs::read(want.join(f)).unwrap(), "{f} differs from the JS's");
	}
	assert!(!out.join("0/34_32.bin").exists(), "a tile without a tex0 has no file");
}

#[test]
fn allowlist_matches_the_js() {
	let (src, tables, listfile, allow) = inputs();
	let reviewed: Vec<String> = allow["reviewed"].as_array().unwrap().iter().map(|r| r["texture"].as_str().unwrap().to_string()).collect();
	let a = road_allowlist(&src, &tables, &[0, 1], &listfile, &reviewed, &|_| {}).unwrap();
	let doc = allowlist_doc(&a, BUILD, &[0, 1], &allow["reviewed"], "node tools/polestar.js nav layers roads --allowlist");
	let got = format!("{}\n", js_json(&doc, Some("\t")));
	assert_eq!(got, std::fs::read_to_string(golden().join("roads-out/road-textures.json")).unwrap());
}

// --- tex0 and weights ----------------------------------------------------------------------------------------

fn chunk(tag: &str, data: &[u8]) -> Vec<u8> {
	let mut out: Vec<u8> = tag.bytes().rev().collect();
	out.extend((data.len() as u32).to_le_bytes());
	out.extend(data);
	out
}

fn u32s(v: &[u32]) -> Vec<u8> {
	v.iter().flat_map(|x| x.to_le_bytes()).collect()
}

const GRASS: u32 = 1000;
const ROAD: u32 = 2000;

fn quarter(v: u8) -> Vec<u8> {
	let mut a = vec![0u8; 4096];
	for y in 0..32 {
		a[y * 64..y * 64 + 32].fill(v);
	}
	a
}

fn rle(a: &[u8]) -> Vec<u8> {
	let mut out = Vec::new();
	let mut o = 0;
	while o < 4096 {
		let mut n = 1;
		while n < 127 && o + n < 4096 && a[o + n] == a[o] {
			n += 1;
		}
		out.push(0x80 | n as u8);
		out.push(a[o]);
		o += n;
	}
	out
}

fn nibbles(a: &[u8]) -> Vec<u8> {
	(0..2048).map(|k| (a[2 * k] >> 4) | (a[2 * k + 1] & 0xf0)).collect()
}

const ROADS: [(usize, usize); 3] = [(0, 0), (3, 2), (15, 15)];

fn tex0(mcal: &[u8], flags: u32) -> Vec<u8> {
	let mut buf = [chunk("MVER", &u32s(&[18])), chunk("MAMP", &u32s(&[0])), chunk("MDID", &u32s(&[GRASS, ROAD])), chunk("MHID", &u32s(&[0, 0]))].concat();
	for n in 0..256 {
		let road = ROADS.iter().any(|&(x, y)| y * 16 + x == n);
		let mcly = if road { u32s(&[0, 0, 0, 0, 1, flags, 0, 0]) } else { u32s(&[0, 0, 0, 0]) };
		buf.extend(chunk("MCNK", &[chunk("MCLY", &mcly), chunk("MCAL", if road { mcal } else { &[] })].concat()));
	}
	buf
}

fn assert_quarters(w: &[u8]) {
	let mut want = vec![0u8; 65536];
	for (x, y) in ROADS {
		for j in 0..8 {
			for i in 0..8 {
				want[(y * 16 + j) * 256 + x * 16 + i] = 255;
			}
		}
	}
	assert!(w == want);
}

fn road_ids() -> FxHashSet<u32> {
	[ROAD].into_iter().collect()
}

#[test]
fn tex0_mdid_textures_and_per_chunk_the_layers_with_their_alpha_maps() {
	let t = parse_tex0(&tex0(&quarter(255), 0x100), true, &|_| false).unwrap();
	assert_eq!(t.textures, [GRASS, ROAD]);
	assert_eq!(t.chunks.len(), 256);
	assert_eq!(t.chunks[0].len(), 2);
	assert!(t.chunks[0][0].alpha.is_none());
	assert_eq!(t.chunks[0][1].tex, 1);
	let a = t.chunks[0][1].alpha.as_ref().unwrap();
	assert_eq!((a.len(), a[0], a[32]), (4096, 255, 0));
	assert_eq!(t.chunks[1].len(), 1);
}

#[test]
fn road_weights_from_raw_rle_and_4_bit_alpha_maps() {
	assert_quarters(&tile_road_weights(&parse_tex0(&tex0(&quarter(255), 0x100), true, &|_| false).unwrap(), &road_ids()));
	let mcal = rle(&quarter(255));
	assert!(mcal.len() < 4096);
	assert_quarters(&tile_road_weights(&parse_tex0(&tex0(&mcal, 0x300), true, &|_| false).unwrap(), &road_ids()));
	let mcal = nibbles(&quarter(255));
	for fix in [false, true] {
		assert_quarters(&tile_road_weights(&parse_tex0(&tex0(&mcal, 0x100), false, &|_| fix).unwrap(), &road_ids()));
	}
}

#[test]
fn the_4_bit_fix_copies_the_63rd_row_and_column_into_the_64th() {
	let mut a = vec![0u8; 4096];
	for y in 0..64 {
		for x in 0..64 {
			a[y * 64 + x] = if x == 62 || y == 62 {
				0xff
			} else if x == 63 || y == 63 {
				0
			} else {
				0x11
			};
		}
	}
	let buf = tex0(&nibbles(&a), 0x100);
	let raw = parse_tex0(&buf, false, &|_| false).unwrap().chunks[0][1].alpha.clone().unwrap();
	let fixed = parse_tex0(&buf, false, &|_| true).unwrap().chunks[0][1].alpha.clone().unwrap();
	assert_eq!(raw[63], 0);
	assert_eq!((fixed[63], fixed[63 * 64], fixed[63 * 64 + 63], fixed[0]), (255, 255, 255, 17));
}

#[test]
fn a_road_base_under_half_a_grass_layer_weighs_half() {
	let mut buf = [chunk("MVER", &u32s(&[18])), chunk("MDID", &u32s(&[GRASS, ROAD]))].concat();
	for _ in 0..256 {
		buf.extend(chunk("MCNK", &[chunk("MCLY", &u32s(&[1, 0, 0, 0, 0, 0x100, 0, 0])), chunk("MCAL", &[128u8; 4096])].concat()));
	}
	let w = tile_road_weights(&parse_tex0(&buf, true, &|_| false).unwrap(), &road_ids());
	assert_eq!((w[0], w[65535]), (127, 127));
}

#[test]
fn texture_keys_fold_case_slashes_and_the_s_and_h_variants() {
	assert_eq!(texture_key("Tileset\\Barrens\\BarrensRoad01_S.blp"), "tileset/barrens/barrensroad01.blp");
	assert_eq!(texture_key("tileset/barrens/barrensroad01_h.blp"), "tileset/barrens/barrensroad01.blp");
	assert_eq!(texture_key("tileset/barrens/barrensgrass01.blp"), "tileset/barrens/barrensgrass01.blp");
}

// --- road by shape -------------------------------------------------------------------------------------------

fn painted(f: impl Fn(usize, usize) -> bool, w: u8) -> Vec<u8> {
	let mut out = vec![0u8; 65536];
	for j in 0..256 {
		for i in 0..256 {
			if f(i, j) {
				out[j * 256 + i] = w;
			}
		}
	}
	out
}

#[test]
fn shapes_area_weight_width_length_and_elongation() {
	let strip = shape_of(&painted(|i, j| (10..14).contains(&i) && (20..120).contains(&j), 200));
	assert_eq!(strip.len(), 1);
	assert_eq!((strip[0].area, strip[0].weight), (400, 400.0 * 200.0));
	assert!((strip[0].width - 400.0 / 104.0).abs() < 1e-9);
	assert!(strip[0].length > 200.0 && strip[0].length < 215.0);
	assert!((strip[0].elongation - (16.0 + 10000.0) / 400.0).abs() < 1e-9);
	let mut two: Vec<u32> = shape_of(&painted(|i, j| (i < 50 && j < 50) || (i == 200 && j == 200), 200)).iter().map(|s| s.area).collect();
	two.sort();
	assert_eq!(two, [1, 2500]);
	assert!(shape_of(&painted(|i, _| i < 50, 127)).is_empty(), "under half: not dominant");
	let diagonal = shape_of(&painted(|i, j| i == j && j < 100, 200));
	assert_eq!((diagonal.len(), diagonal[0].area), (1, 100), "corners touch");
	assert!(road_by_shape(&diagonal).road);
}

#[test]
fn road_by_shape_needs_long_narrow_elongated_strips() {
	let pinholed = shape_of(&painted(|i, j| i < 60 && j < 60 && !(i % 3 == 1 && j % 3 == 1), 200));
	assert_eq!(pinholed.len(), 1);
	assert!(pinholed[0].width < 6.0 && pinholed[0].length > 60.0 && pinholed[0].elongation < 10.0);
	assert!(!road_by_shape(&pinholed).road);
	let strips = shape_of(&painted(|i, j| i % 40 < 5 && j < 200, 200));
	let patches = shape_of(&painted(|i, j| i % 80 < 60 && j % 80 < 60, 200));
	assert!(road_by_shape(&strips).road);
	assert!(!road_by_shape(&patches).road);
	assert!(!road_by_shape(&shape_of(&painted(|i, j| i < 5 && j < 10, 200))).road, "short");
	assert!(!road_by_shape(&[strips.clone(), patches].concat()).road);
	assert!(road_by_shape(&strips).share > 0.99);
}

// --- the built layer (<repo>/data/local/nav-layers/roads, when built) ------------------------------------------

fn built(c: u32) -> Option<PathBuf> {
	let d = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../../data/local/nav-layers/roads");
	d.join(c.to_string()).is_dir().then_some(d)
}

fn weight_at(dir: &Path, c: u32, wx: f64, wy: f64) -> u8 {
	let u = (32.0 * 1600.0 / 3.0 - wy) / (1600.0 / 3.0 / 256.0);
	let v = (32.0 * 1600.0 / 3.0 - wx) / (1600.0 / 3.0 / 256.0);
	let (gi, gj) = (u.floor() as i64, v.floor() as i64);
	let (col, row) = (gi.div_euclid(256), gj.div_euclid(256));
	let w = std::fs::read(dir.join(c.to_string()).join(format!("{col}_{row}.bin"))).unwrap_or_else(|_| panic!("roads tile {c}/{col}_{row} built"));
	w[((gj - row * 256) * 256 + gi - col * 256) as usize]
}

#[test]
fn the_built_layer_goldshires_main_road_is_road_open_grass_in_elwynn_is_not() {
	let Some(d) = built(0) else { return eprintln!("skipped: no roads layer for map 0 (forge nav layers roads --c 0)") };
	assert!(weight_at(&d, 0, -9464.0, 62.0) >= 128);
	assert!(weight_at(&d, 0, -9300.0, -200.0) < 64);
}

#[test]
fn the_built_layer_the_barrens_gold_road_is_road() {
	let Some(d) = built(1) else { return eprintln!("skipped: no roads layer for map 1 (forge nav layers roads --c 1)") };
	assert!(weight_at(&d, 1, -560.0, -2654.0) >= 128);
	let mut near = 0;
	for dx in -8..=8 {
		for dy in -8..=8 {
			if f64::from(dx).hypot(f64::from(dy)) <= 8.0 {
				near = near.max(weight_at(&d, 1, -441.0 + f64::from(dx), -2650.0 + f64::from(dy)));
			}
		}
	}
	assert!(near >= 128, "a road column within 8 yd of the Crossroads' junction");
}

#[test]
fn the_built_layer_desolaces_main_road_has_road_columns_along_it() {
	let Some(d) = built(1) else { return eprintln!("skipped: no roads layer for map 1") };
	let data = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../../data/forever");
	let (Ok(frames), Ok(zones)) = (std::fs::read(data.join("map-frames.json")), std::fs::read(data.join("zones.json"))) else {
		return eprintln!("skipped: no data/forever/map-frames.json (forge data build)");
	};
	let geo = forge_navbuild::build::Geo::new(&serde_json::from_slice(&frames).unwrap(), &serde_json::from_slice(&zones).unwrap());
	let mut misses = Vec::new();
	let mut y = 49.5;
	while y <= 54.5 {
		let (c, wx, wy) = geo.to_world(1443, 49.0, y, 'l').unwrap();
		assert_eq!(c, 1);
		let near = (-10..=10).map(|dd| weight_at(&d, 1, wx, wy + f64::from(dd))).max().unwrap();
		if near < 128 {
			misses.push(y);
		}
		y += 0.5;
	}
	assert!(misses.len() <= 1, "no road near 49,{misses:?}");
}
