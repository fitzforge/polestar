//! How well a place without a height is put on its floor: each recorded position of a walk is
//! snapped as a heightless end is (Walker::snap with z None) and compared with the floor the walk
//! was followed on (trailfollow's heights). Input: the walks (trailfollow's input) and its output;
//! prints, per walk, the positions on several floors, those snapped to another floor (more than
//! 3 yd off), and the first few of them with their columns.
//!
//! DUMP=<file> appends each such position (walked z, snapped z, the column's open floors) as a line.
//!
//!   cargo run --profile quick -p forge-nav --example snapcheck -- <grid> walks.jsonl follow.jsonl

use forge_nav::grid::{cell_of, flag, Grid, TILE_CELLS};
use forge_nav::legs::{is_open, SnapAsk, SNAP_OPEN, SNAP_REGION};
use forge_nav::walker::Walker;
use serde_json::Value;
use std::path::Path;
use std::sync::Arc;

fn main() -> Result<(), String> {
	let a: Vec<String> = std::env::args().skip(1).collect();
	if a.len() < 3 {
		return Err("usage: snapcheck <grid> walks.jsonl follow.jsonl".into());
	}
	let grid = Arc::new(Grid::open(Path::new(&a[0]), 640)?);
	let walker = Walker::new(grid.clone());
	let lines = |f: &str| -> Result<Vec<Value>, String> {
		Ok(std::fs::read_to_string(f).map_err(|e| e.to_string())?.lines().filter(|l| !l.trim().is_empty()).map(|l| serde_json::from_str(l).unwrap()).collect())
	};
	let walks = lines(&a[1])?;
	let follow = lines(&a[2])?;
	let (mut all_multi, mut all_wrong) = (0usize, 0usize);
	for (w, f) in walks.iter().zip(&follow) {
		let c = w["map"].as_u64().unwrap_or(0) as u32;
		let (mut multi, mut wrong, mut shown) = (0usize, 0usize, 0usize);
		for (p, z) in w["pts"].as_array().unwrap().iter().zip(f["pz"].as_array().unwrap()) {
			let Some(z) = z.as_f64() else { continue };
			let (wx, wy) = (p[0].as_f64().unwrap(), p[1].as_f64().unwrap());
			let (col, row, i, j) = cell_of(wx, wy);
			let Some(t) = grid.tile(c, col, row) else { continue };
			let k = (j * TILE_CELLS as i64 + i) as usize;
			let open: Vec<usize> = (t.first[k] as usize..t.first[k + 1] as usize).filter(|&e| t.flags[e] & flag::BLOCKED == 0).collect();
			if open.len() < 2 {
				continue;
			}
			multi += 1;
			let s = walker.snap(&SnapAsk { c, wx, wy, z: None, radius: 20.0, under: true, stand: true });
			let sz = s.as_ref().map(|s| s.z);
			if let Ok(f) = std::env::var("DUMP") {
				use std::io::Write;
				let floors: Vec<Value> = open
					.iter()
					.map(|&e| {
						let size = grid.region_size(c, col as u32, row as u32, e as u32);
						let strict = size.is_none_or(|n| n >= SNAP_REGION) && is_open(&t, k, e, SNAP_OPEN);
						serde_json::json!([t.z[e], if t.ceil[e].is_finite() { serde_json::json!(t.ceil[e] - t.z[e]) } else { Value::Null }, t.flags[e], t.slope[e], strict, size])
					})
					.collect();
				let mut o = std::fs::OpenOptions::new().create(true).append(true).open(f).map_err(|e| e.to_string())?;
				writeln!(o, "{}", serde_json::json!({ "id": w["id"], "z": z, "snap": sz, "floors": floors })).map_err(|e| e.to_string())?;
			}
			if sz.is_none_or(|sz| (sz - z).abs() > 3.0) {
				wrong += 1;
				if shown < 4 {
					shown += 1;
					let col: Vec<String> = open.iter().map(|&e| format!("{:.1}/{:.1}/{}", t.z[e], t.ceil[e] - t.z[e], t.flags[e])).collect();
					println!("  {} [{wx:.1},{wy:.1}] walked z {z:.1}, snapped {:?}; open floors z/gap/flags {}", w["id"].as_str().unwrap_or(""), sz.map(|v| (v * 10.0).round() / 10.0), col.join(" "));
				}
			}
		}
		all_multi += multi;
		all_wrong += wrong;
		println!("{}: {multi} positions over several floors, {wrong} snapped to another floor", w["id"].as_str().unwrap_or(""));
	}
	println!("all: {all_multi} positions over several floors, {all_wrong} snapped to another floor");
	Ok(())
}
