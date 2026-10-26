//! One walk on our walking grid and on Leffe's navigation maps, side by side: one query per input
//! line, {"id","map","from":[x,y,z|null],"to":[x,y,z|null],"profile":"Alliance"|"Horde"|null,
//! "chain":bool}, one answer per output line, {"id","grid":{..},"leffe":{..}}. Each side is drawn as
//! the guide bake draws a leg (bake.rs: Walker::route_path's cells, Leffe's route), then simplified
//! as a baked leg is; `yards` is the simplified line's 3D length (what the arrow shows), `raw` the
//! unsimplified way's. `chain`: the walk starts at the height the previous line's way (on the same
//! side) ended at, and a goal without a height is looked for at that height too: a recorded trail
//! without heights cut into pieces, walked on as the player did. Leffe's side is left out without
//! his folder. Credit: Leffe's navigation maps and reader.
//!
//!   cargo run --profile quick -p forge-nav --example gridab -- <grid> [<Leffe's Nav folder>] < queries.jsonl > answers.jsonl

use forge_nav::bake::{simplify, Way};
use forge_nav::cost::{Ground, Profile, RUN};
use forge_nav::f4::{Floor, Opts, Style, Validate, F4, P};
use forge_nav::grid::Grid;
use forge_nav::legs::SnapAsk;
use forge_nav::walker::{hubs_file, Walker};
use serde_json::{json, Value};
use std::io::{BufRead, Write};
use std::path::Path;
use std::sync::Arc;

fn pts(w: &Way) -> Value {
	w.pts.iter().map(|p| json!([(p[0] * 10.0).round() / 10.0, (p[1] * 10.0).round() / 10.0, (p[2] * 10.0).round() / 10.0])).collect()
}

fn main() -> Result<(), String> {
	let mut args = std::env::args().skip(1);
	let grid_dir = args.next().ok_or("usage: gridab <grid> [<Leffe's Nav folder>] < queries.jsonl")?;
	let leffe = args.next();
	let grid = Arc::new(Grid::open(Path::new(&grid_dir), 640)?);
	let roads = std::fs::read_dir(grid.dir.join("walk"))
		.map_err(|e| e.to_string())?
		.flatten()
		.filter_map(|e| e.file_name().to_str()?.strip_prefix("roads-0-")?.strip_suffix(".bin").map(String::from))
		.next()
		.ok_or("no walk/roads-0-<tag>.bin: forge nav prepare")?;
	let hubs = std::fs::read(hubs_file(&grid.dir)).ok();
	let ground = Arc::new(Ground::load(&grid.dir, &roads, &[0, 1, 2991], hubs.as_deref())?);
	let profiles: Vec<(Option<&'static str>, Profile)> = [None, Some("Alliance"), Some("Horde")].into_iter().map(|f| (f, Profile::walk(f, ground.clone(), None))).collect();
	let walker = Walker::new(grid.clone());
	let f4 = match &leffe {
		Some(d) => Some(F4::open(Path::new(d), 512)?),
		None => None,
	};
	let stdout = std::io::stdout();
	let mut out = stdout.lock();
	let (mut g_end, mut l_end): (Option<f64>, Option<f64>) = (None, None);
	for line in std::io::stdin().lock().lines() {
		let line = line.map_err(|e| e.to_string())?;
		if line.trim().is_empty() {
			continue;
		}
		let q: Value = serde_json::from_str(&line).map_err(|e| e.to_string())?;
		let c = q["map"].as_u64().unwrap_or(0) as u32;
		let end = |v: &Value| (v[0].as_f64().unwrap_or(0.0), v[1].as_f64().unwrap_or(0.0), v[2].as_f64());
		let (a, b) = (end(&q["from"]), end(&q["to"]));
		let chain = q["chain"].as_bool().unwrap_or(false);
		let (ga, la, gb, lb) = if chain { ((a.0, a.1, g_end), (a.0, a.1, l_end), (b.0, b.1, b.2.or(g_end)), (b.0, b.1, b.2.or(l_end))) } else { (a, a, b, b) };
		let faction = match q["profile"].as_str() {
			Some("Alliance") => Some("Alliance"),
			Some("Horde") => Some("Horde"),
			_ => None,
		};
		let p = &profiles.iter().find(|x| x.0 == faction).unwrap().1;
		let ask = |e: (f64, f64, Option<f64>)| SnapAsk { c, wx: e.0, wy: e.1, z: e.2, radius: 20.0, under: true, stand: true };
		g_end = None;
		let g = match walker.route_path(&ask(ga), &ask(gb), p, "")? {
			Some(w) => {
				let way = Way::from_cells(&w.cells);
				let kept = simplify(&way);
				g_end = kept.pts.last().map(|p| p[2]);
				json!({ "ok": true, "yards": kept.yards(), "raw": way.yards(), "cost": w.seconds * RUN, "settled": w.settled, "points": pts(&kept) })
			}
			None => json!({ "ok": false }),
		};
		l_end = None;
		let l = f4.as_ref().map(|f4| {
			let o = Opts { profile: faction, style: Style::Balanced, validate: Validate::Tolerant, ..Opts::default() };
			let r = f4.route(c, P { x: la.0, y: la.1, z: la.2 }, P { x: lb.0, y: lb.1, z: lb.2 }, &o);
			match Way::from_route(&r, |x, y| f4.height_at(c, x, y, Floor::Base)) {
				Some(way) => {
					let kept = simplify(&way);
					l_end = kept.pts.last().map(|p| p[2]).filter(|z| z.is_finite());
					json!({ "ok": true, "yards": kept.yards(), "raw": way.yards(), "cost": r.cost, "points": pts(&kept) })
				}
				None => json!({ "ok": false, "reason": r.reason }),
			}
		});
		writeln!(out, "{}", json!({ "id": q["id"], "grid": g, "leffe": l })).map_err(|e| e.to_string())?;
	}
	Ok(())
}
