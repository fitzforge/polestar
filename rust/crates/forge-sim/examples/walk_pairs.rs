//! Walk-store yards between world points: `walk_pairs <walks.bin> <world.json> a:b ...`.
use forge_sim::walks::{WalkTable, Walks};

fn main() {
	let a: Vec<String> = std::env::args().collect();
	let w: serde_json::Value = serde_json::from_slice(&std::fs::read(&a[2]).unwrap()).unwrap();
	let nw = w["points"].as_array().unwrap().len();
	let t = WalkTable::from_bin(&std::fs::read(&a[1]).unwrap(), nw).unwrap();
	for p in &a[3..] {
		let (x, y) = p.split_once(':').unwrap();
		println!("{p}: {:?}", t.yards(x.parse().unwrap(), y.parse().unwrap()));
	}
}
