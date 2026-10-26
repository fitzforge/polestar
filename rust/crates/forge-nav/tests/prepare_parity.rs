//! `forge nav prepare` against Node's `nav prepare` and cch.js `prepare`/`prepareYards`: prepare a
//! grid's continents into an empty walk/ and cch/ and compare every file, name and bytes, with the
//! files Node wrote for that grid (a file Node did not write, e.g. one faction's yards, is skipped).
//!   PREPARE_GRID=<grid Node prepared> PREPARE_ROOT=<checkout> [PREPARE_CONTINENTS=489,529] \
//!     cargo test --release -p forge-nav --test prepare_parity -- --ignored --nocapture
//! (EK and Kalimdor, 0,1: about 45 min on 6 threads; every file identical on 2026-10-21's nav4 grid,
//! including the CCH bundles and the Horde yards and cells.)
#![cfg(feature = "native")]

use std::path::{Path, PathBuf};

#[test]
#[ignore = "needs PREPARE_GRID and PREPARE_ROOT"]
fn prepare_matches_node() {
	let grid = std::env::var("PREPARE_GRID").expect("needs PREPARE_GRID (a grid Node prepared)");
	let root = std::env::var("PREPARE_ROOT").expect("needs PREPARE_ROOT (a checkout)");
	let (grid, root) = (PathBuf::from(grid), PathBuf::from(root));
	let continents: Vec<u32> = std::env::var("PREPARE_CONTINENTS").unwrap_or_else(|_| "489,529".into()).split(',').map(|s| s.trim().parse().unwrap()).collect();
	let tmp = std::env::temp_dir().join(format!("prepare-parity-{}", std::process::id()));
	std::fs::create_dir_all(tmp.join("walk")).unwrap();
	for f in ["index.json", "lifts.json", "graph", "tiles"] {
		std::os::unix::fs::symlink(grid.join(f), tmp.join(f)).unwrap();
	}
	let wago = root.join("data/sources/wago");
	let mut builds: Vec<String> =
		std::fs::read_dir(&wago).unwrap().flatten().map(|e| e.file_name().to_string_lossy().into_owned()).filter(|b| wago.join(b).join("AreaTable.csv").is_file() && b.starts_with("1.6")).collect();
	builds.sort_by_key(|b| b.split('.').map(|p| p.parse::<u64>().unwrap_or(0)).collect::<Vec<_>>());
	let area_table = wago.join(builds.last().expect("no cached AreaTable")).join("AreaTable.csv");
	let layers = root.join("data/local/nav-layers");
	let log = |m: &str| eprintln!("{m}");
	let built = forge_nav::prepare::prepare(&forge_nav::prepare::PrepareIn {
		grid: &tmp,
		roads: &layers.join("roads"),
		hubs: &layers.join("hubs.json"),
		area_table: &area_table,
		zones: &root.join("data/forever/zones.json"),
		continents: Some(continents),
		threads: 6,
		log: &log,
	})
	.unwrap();
	let mut bad = Vec::new();
	for b in &built {
		let name = b.file.file_name().unwrap();
		let sub = if b.file.parent().and_then(|p| p.file_name()).is_some_and(|d| d == "cch") { "cch" } else { "walk" };
		let want = grid.join(sub).join(name);
		if !want.exists() {
			eprintln!("no reference {}", Path::new(name).display());
			continue;
		}
		let same = std::fs::read(&b.file).ok() == std::fs::read(&want).ok();
		eprintln!("{} {}", if same { "same" } else { "DIFFERS" }, Path::new(name).display());
		if !same {
			bad.push(name.to_string_lossy().into_owned());
		}
	}
	let _ = std::fs::remove_dir_all(&tmp);
	assert!(bad.is_empty(), "differ from Node's: {bad:?}");
}
