//! The JS-written files of the golden grid (rust/tests/golden/nav-grid: tiles, walls, the continent's
//! graph) decode and re-encode to the same bytes. POLESTAR_NAV4=<grid dir> with POLESTAR_NAV4_C=<map>
//! checks another JS-built grid instead (the old reference: the v1 checkout's data/local/nav4, map 2991).
use forge_navbuild::format::*;
use std::path::PathBuf;

fn grid() -> (PathBuf, String) {
	match std::env::var("POLESTAR_NAV4") {
		Ok(d) => (d.into(), std::env::var("POLESTAR_NAV4_C").unwrap_or_else(|_| "2991".into())),
		Err(_) => (PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden/nav-grid/nav4"), "0".into()),
	}
}

#[test]
fn reference_files_round_trip() {
	let (nav4, c) = grid();
	let dir = nav4.join("tiles").join(&c);
	let (mut tiles, mut walls) = (0, 0);
	for e in std::fs::read_dir(&dir).unwrap_or_else(|e| panic!("{}: {e}", dir.display())) {
		let p = e.unwrap().path();
		let name = p.file_name().unwrap().to_str().unwrap().to_string();
		let gz = std::fs::read(&p).unwrap();
		if name.ends_with(".nav.gz") {
			assert_eq!(encode_tile(&decode_tile(&gz).unwrap()).unwrap(), gz, "{name}");
			tiles += 1;
		} else if name.ends_with(".walls.gz") {
			assert_eq!(encode_walls(&decode_walls(&gz).unwrap()), gz, "{name}");
			// Raw too, and its gzip as the JS's.
			let raw = gunzip(&gz).unwrap();
			assert!(gunzip(&encode_walls(&decode_walls(&gz).unwrap())).unwrap() == raw, "{name}: raw differs");
			assert!(gzip(&raw) == gz, "{name}: gzip differs");
			walls += 1;
		}
	}
	assert!(tiles > 0 && walls > 0, "{}: {tiles} tiles, {walls} walls", dir.display());
	let gz = std::fs::read(nav4.join(format!("graph/{c}.bin.gz"))).unwrap();
	assert_eq!(encode_graph(&decode_graph(&gz).unwrap()), gz);
}
