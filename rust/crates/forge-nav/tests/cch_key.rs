//! The CCH bundle a walker reads is the one keyed on its grid's graph (prepare::bundle_file), never
//! another graph's left in cch/ (another build, another link rule: other edges); a bundle at that key
//! built on another edge count fails with "stale cch" instead of a panic in Metric::customize.
//! On the nav-grid golden (rust/tests/golden/nav-grid/nav4) with nav-walks' Horde ends.
#![cfg(feature = "native")]

mod common;

use forge_nav::cch::graph::CoarseGraph;
use forge_nav::cost::{Ground, Profile};
use forge_nav::grid::Grid;
use forge_nav::legs::SnapAsk;
use forge_nav::walker::{hubs_file, Row, Walker, CCH_ROWS};
use serde_json::Value;
use std::path::{Path, PathBuf};
use std::sync::Arc;

/// A copy of the golden grid (graph, tiles, walk/ linked) in a scratch folder with an empty cch/.
fn scratch_grid(name: &str) -> PathBuf {
	let golden = common::golden_dir().join("nav-grid");
	let root = Path::new(env!("CARGO_TARGET_TMPDIR")).join(name);
	let _ = std::fs::remove_dir_all(&root);
	let dir = root.join("nav4");
	std::fs::create_dir_all(dir.join("cch")).unwrap();
	for f in ["index.json", "lifts.json", "graph", "tiles", "walk"] {
		std::os::unix::fs::symlink(std::fs::canonicalize(golden.join("nav4").join(f)).unwrap(), dir.join(f)).unwrap();
	}
	std::os::unix::fs::symlink(std::fs::canonicalize(golden.join("nav-layers")).unwrap(), root.join("nav-layers")).unwrap();
	dir
}

/// Continent 0's graph with the last node's edges cut: another edge set, as a rebuilt graph has.
fn other_graph(dir: &Path) -> (CoarseGraph, usize) {
	let mut g = CoarseGraph::read(&dir.join("graph/0.bin.gz")).unwrap();
	let rg = &mut g.graphs[0];
	let n = g.node_count;
	let u = (0..n).rev().find(|&u| rg.off[u + 1] > rg.off[u]).unwrap();
	let cut = (rg.off[u + 1] - rg.off[u]) as usize;
	let from = rg.off[u] as usize;
	rg.to.drain(from..from + cut);
	for o in &mut rg.off[u + 1..] {
		*o -= cut as u32;
	}
	let e = rg.to.len();
	(g, e)
}

/// Edge yards (f64 each) and cells (cch.js format, no cells) for `e` edges, named as cch.js
/// yardsFile / cellsFile name them beside `bundle`.
fn write_edge_files(bundle: &Path, p: &Profile, e: usize) {
	let tag = &forge_core::key::content_key(p.ground_key.as_bytes())[..12];
	let name = bundle.file_name().unwrap().to_str().unwrap();
	let (y, x) = (bundle.with_file_name(format!("{name}.{tag}.yards")), bundle.with_file_name(format!("{name}.{tag}.cells")));
	std::fs::write(&y, vec![0u8; 8 * e]).unwrap();
	let mut c = Vec::with_capacity(4 * (e + 2));
	c.extend_from_slice(&(e as u32).to_le_bytes());
	c.resize(4 * (e + 2), 0);
	std::fs::write(&x, c).unwrap();
}

struct Setup {
	grid: Arc<Grid>,
	profile: Profile,
	zones_tag: String,
	rows: Vec<Row>,
	edges: usize,
}

fn setup(dir: &Path) -> Setup {
	let refs = common::refs();
	let az: Value = serde_json::from_slice(&refs.areazones()).unwrap();
	let ends: Value = serde_json::from_slice(&refs.ends()).unwrap();
	let ends = ends["ends"].as_array().unwrap();
	let grid = Arc::new(Grid::open(dir, 1024).unwrap());
	let roads_tag = az["groundKey"].as_str().unwrap().split('|').nth(1).unwrap().to_string();
	let ground = Arc::new(Ground::load(dir, &roads_tag, &[0, 1], std::fs::read(hubs_file(dir)).ok().as_deref()).unwrap());
	let profile = Profile::walk(Some("Horde"), ground, None);
	let ask = |i: usize| {
		let e = &ends[i % ends.len()];
		SnapAsk { c: e[0].as_u64().unwrap() as u32, wx: e[1].as_f64().unwrap(), wy: e[2].as_f64().unwrap(), z: e[3].as_f64(), radius: 20.0, under: true, stand: true }
	};
	// Enough rows that the walker customizes a metric on the CCH (CCH_ROWS snapped sources; some ends do not snap).
	let rows = (0..2 * CCH_ROWS).map(|i| Row { source: ask(i), targets: vec![ask(i + 1)] }).collect();
	let edges = grid.graph(0).unwrap().edges();
	Setup { grid, profile, zones_tag: az["tag"].as_str().unwrap().into(), rows, edges }
}

#[test]
fn another_graphs_bundle_is_never_read() {
	let dir = scratch_grid("cch-key-other");
	let s = setup(&dir);
	// A bundle (and Horde yards) of another edge set, named as cch/ names any continent-0 bundle.
	let (g, e) = other_graph(&dir);
	assert!(e < s.edges);
	let decoy = dir.join("cch/0-0-0000000000000000.cch");
	forge_nav::cch::structure::build(&g, 0, &decoy).unwrap();
	write_edge_files(&decoy, &s.profile, e);
	assert_ne!(forge_nav::prepare::bundle_file(&dir, 0).unwrap(), decoy);
	let walker = Walker::new(s.grid.clone());
	let (out, _) = walker.rows(&s.rows, &s.profile, &s.zones_tag, false).expect("the walker routes without the other graph's bundle");
	assert_eq!(out.len(), s.rows.len());
	assert!(out.iter().flatten().any(|w| w.seconds >= 0.0), "some walk is routed");
}

#[test]
fn a_bundle_on_another_edge_count_is_stale_not_a_panic() {
	let dir = scratch_grid("cch-key-stale");
	let s = setup(&dir);
	// At the graph's own key, a bundle built on other edges (yards for the graph's, so only the bundle is off).
	let (g, e) = other_graph(&dir);
	let bundle = forge_nav::prepare::bundle_file(&dir, 0).unwrap();
	forge_nav::cch::structure::build(&g, 0, &bundle).unwrap();
	write_edge_files(&bundle, &s.profile, s.edges);
	let why = forge_nav::prepare::cch_stale(&bundle, s.edges).expect("prepare sees the bundle is stale");
	assert_eq!(why, format!("built on {e} edges, the graph has {}", s.edges));
	let walker = Walker::new(s.grid.clone());
	let err = walker.rows(&s.rows, &s.profile, &s.zones_tag, false).expect_err("a stale bundle is an error");
	assert!(err.contains("stale cch") && err.contains("forge nav prepare rebuilds it"), "{err}");
	// Yards of another edge count at the key: stale too.
	write_edge_files(&bundle, &s.profile, e);
	let err = Walker::new(s.grid.clone()).rows(&s.rows, &s.profile, &s.zones_tag, false).expect_err("stale yards are an error");
	assert!(err.contains("stale cch yards"), "{err}");
}
