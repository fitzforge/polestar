//! links + local components on the JS surfaces and walls of every golden tile: the .nav.gz equals the
//! JS build's byte for byte (rust/tests/golden/nav-grid).
mod common;
use forge_navbuild::format::*;

#[test]
fn links_equal_the_js() {
	let src = common::src();
	let tiles = src.tiles_listed();
	let read = |col: i32, row: i32| -> Option<Tile> {
		let mut t = decode_tile(&std::fs::read(src.surf.join(format!("{col}_{row}.surf.gz"))).ok()?).unwrap();
		t.walls = Some(decode_walls(&std::fs::read(src.surf.join(format!("{col}_{row}.walls.gz"))).unwrap()).unwrap());
		Some(t)
	};
	let mut bad = Vec::new();
	for &(col, row) in &tiles {
		let ar: [Option<Tile>; 9] = std::array::from_fn(|x| read(col + (x % 3) as i32 - 1, row + (x / 3) as i32 - 1));
		let refs: [Option<&Tile>; 9] = std::array::from_fn(|x| ar[x].as_ref());
		let mut t = ar[4].clone().unwrap();
		let lo = forge_navbuild::links::link_tile(&refs);
		t.links = Some(lo.links);
		t.fall_from = lo.fall_from;
		t.fall_to = lo.fall_to;
		t.walls = None;
		let (comp, n) = forge_navbuild::regions::local_components(&t);
		t.comp = Some(comp);
		t.n_comp = n;
		let want = std::fs::read(src.tiles.join(format!("{col}_{row}.nav.gz"))).unwrap();
		if encode_tile(&t).unwrap() != want {
			let w = decode_tile(&want).unwrap();
			let diff = w.links.as_ref().unwrap().iter().zip(t.links.as_ref().unwrap()).position(|(a, b)| a != b);
			bad.push(format!("{col}_{row} links@{diff:?} falls {}/{} comp {}/{}", t.fall_from.len(), w.fall_from.len(), t.n_comp, w.n_comp));
		}
	}
	assert!(bad.is_empty(), "{} tiles; differ: {bad:?}", tiles.len());
}
