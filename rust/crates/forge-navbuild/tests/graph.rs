//! The abstract graph on the JS-linked golden tiles: every .hpa.gz part (the lift's tile with its rides)
//! and the continent's graph (with the lift) equal the JS build's byte for byte
//! (rust/tests/golden/nav-grid).
mod common;
use forge_navbuild::format::*;
use forge_navbuild::graph::*;

#[test]
fn graph_equals_the_js() {
	let src = common::src();
	let tiles = src.tiles_listed();
	let read = |col: i32, row: i32| -> Option<Tile> { std::fs::read(src.tiles.join(format!("{col}_{row}.nav.gz"))).ok().map(|b| decode_tile(&b).unwrap()) };
	let mut bad = Vec::new();
	let mut parts = Vec::new();
	for &(col, row) in &tiles {
		let mut ar: [Option<Tile>; 9] = std::array::from_fn(|x| read(col + (x % 3) as i32 - 1, row + (x / 3) as i32 - 1));
		let froms = src.set_lifts(ar[4].as_mut().unwrap(), col, row);
		let refs: [Option<&Tile>; 9] = std::array::from_fn(|x| ar[x].as_ref());
		let part = tile_graph(&refs, &froms);
		let text = part_json(&part);
		let want = std::fs::read(src.tiles.join(format!("{col}_{row}.hpa.gz"))).unwrap();
		let want_text = String::from_utf8(gunzip(&want).unwrap()).unwrap();
		if text != want_text {
			let at = text.bytes().zip(want_text.bytes()).position(|(a, b)| a != b).unwrap_or(text.len().min(want_text.len()));
			bad.push(format!("{col}_{row} json@{at}: ours {:?} js {:?}", &text[at.saturating_sub(40)..(at + 40).min(text.len())], &want_text[at.saturating_sub(40)..(at + 40).min(want_text.len())]));
		} else if gzip(text.as_bytes()) != want {
			bad.push(format!("{col}_{row} gzip"));
		}
		parts.push(compact_part(parse_part_json(&want_text).unwrap()));
	}
	assert!(bad.is_empty(), "{} tiles; differ: {:?}", tiles.len(), &bad[..bad.len().min(5)]);
	let (g, _) = assemble_graph(src.c, parts, &src.lifts);
	let want = std::fs::read(&src.graph).unwrap();
	assert!(encode_graph(&g) == want, "graph differs");
}
