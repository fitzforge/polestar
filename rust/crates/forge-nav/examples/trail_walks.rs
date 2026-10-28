//! The walking grid's yards between the two ends of each recorded trail (the time model's
//! calibration, RsSim.md "time model"): cargo run --release -p forge-nav --features world
//! --example trail_walks -- <grid> <AreaTable.csv> <zones.json> <faction> <c,wx,wy,c,wx,wy,name>...
//! Prints one JSON line per pair: { name, yards, seconds } (yards as the router walks them).
use forge_nav::legs::SnapAsk;
use forge_nav::walker::{Row, Walker};
use std::path::Path;
use std::sync::Arc;

fn main() {
	let a: Vec<String> = std::env::args().skip(1).collect();
	let grid = Arc::new(forge_nav::grid::Grid::open(Path::new(&a[0]), 1024).expect("grid"));
	let pricing = forge_nav::stage::pricing(&grid, &a[3], Path::new(&a[1]), Path::new(&a[2]), Vec::new()).expect("pricing");
	let p = pricing.profile(&[]);
	let walker = Walker::new(grid);
	let ask = |c: u32, wx: f64, wy: f64| SnapAsk { c, wx, wy, z: None, radius: 20.0, under: false, stand: false };
	for spec in &a[4..] {
		let v: Vec<&str> = spec.split(',').collect();
		let n = |i: usize| v[i].parse::<f64>().unwrap();
		let row = Row { source: ask(n(0) as u32, n(1), n(2)), targets: vec![ask(n(3) as u32, n(4), n(5))] };
		match walker.rows(&[row], &p, &pricing.zones.tag, false) {
			Ok((w, _)) => println!("{}", serde_json::json!({ "name": v[6], "yards": w[0][0].yards, "seconds": w[0][0].seconds })),
			Err(e) => println!("{}", serde_json::json!({ "name": v[6], "error": e })),
		}
	}
}
