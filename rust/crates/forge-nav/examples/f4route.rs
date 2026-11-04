//! Routes on Leffe's navigation maps (format 4) for comparison against recorded walks: one query per input line,
//! {"id","map","from":[x,y,z|null],"to":[x,y,z|null],"profile":"Alliance"|"Horde"|null}, one answer per output line,
//! {"id","ok","reason","yards","cost","points":[[x,y,z],...]}. Credit: Leffe's navigation maps and reader.
//!
//!   cargo run --release -p forge-nav --example f4route -- <Leffe's Nav folder> < queries.jsonl > answers.jsonl

use forge_nav::f4::{Opts, Style, Validate, F4, P};
use std::io::{BufRead, Write};

fn main() -> Result<(), String> {
	let dir = std::env::args().nth(1).ok_or("usage: f4route <Leffe's Nav folder> < queries.jsonl")?;
	let f4 = F4::open(std::path::Path::new(&dir), 512)?;
	let stdout = std::io::stdout();
	let mut out = stdout.lock();
	for line in std::io::stdin().lock().lines() {
		let line = line.map_err(|e| e.to_string())?;
		if line.trim().is_empty() {
			continue;
		}
		let q: serde_json::Value = serde_json::from_str(&line).map_err(|e| e.to_string())?;
		let p = |v: &serde_json::Value| P { x: v[0].as_f64().unwrap_or(0.0), y: v[1].as_f64().unwrap_or(0.0), z: v[2].as_f64() };
		let profile = match q["profile"].as_str() {
			Some("Alliance") => Some("Alliance"),
			Some("Horde") => Some("Horde"),
			_ => None,
		};
		let o = Opts { profile, style: Style::Balanced, danger: Vec::new(), water_walking: false, validate: Validate::Tolerant, limit: None, chains: false };
		let r = f4.route(q["map"].as_u64().unwrap_or(0) as u32, p(&q["from"]), p(&q["to"]), &o);
		let pts: Vec<serde_json::Value> = r.points.iter().map(|a| serde_json::json!([a[0], a[1], if a[2].is_nan() { serde_json::Value::Null } else { serde_json::json!(a[2]) }])).collect();
		let ans = serde_json::json!({ "id": q["id"], "ok": r.ok, "reason": r.reason, "yards": r.yards, "cost": r.cost, "points": pts });
		writeln!(out, "{ans}").map_err(|e| e.to_string())?;
	}
	Ok(())
}
