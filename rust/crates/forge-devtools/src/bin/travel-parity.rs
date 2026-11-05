//! `travel-parity <checkout> <js-dir> [--out DIR] [--grid DIR|none] [--recordings DIR] [--sources DIR]`: builds `travel build`'s files
//! from a checkout (offline, the command's defaults) and compares each with the JS reference's in
//! <js-dir> (travel.json, TravelData.lua, FlightPaths.lua, Polestar_Travel/*), as written by
//! `node tools/polestar.js travel build --offline --json <js-dir>/travel.json --lua
//! <js-dir>/TravelData.lua --flight-lua <js-dir>/FlightPaths.lua --travel-addon
//! <js-dir>/Polestar_Travel`. --out also writes the Rust files there. Exit 1 on any difference.

use std::path::PathBuf;
use std::time::Instant;

use forge_data::travel::{build, Options};

fn main() {
	match run() {
		Ok(true) => {}
		Ok(false) => std::process::exit(1),
		Err(e) => {
			eprintln!("travel-parity: {e}");
			std::process::exit(2);
		}
	}
}

fn run() -> Result<bool, String> {
	let mut pos = Vec::new();
	let mut out_dir: Option<PathBuf> = None;
	let mut grid: Option<String> = None;
	let mut recordings: Option<PathBuf> = None;
	let mut sources: Option<PathBuf> = None;
	let mut args = std::env::args().skip(1);
	while let Some(a) = args.next() {
		match a.as_str() {
			"--out" => out_dir = args.next().map(PathBuf::from),
			"--grid" => grid = args.next(),
			"--recordings" => recordings = args.next().map(PathBuf::from),
			"--sources" => sources = args.next().map(PathBuf::from),
			_ => pos.push(PathBuf::from(a)),
		}
	}
	let [root, js] = pos.as_slice() else { return Err("usage: travel-parity <checkout> <js-dir> [--out DIR] [--grid DIR|none] [--recordings DIR] [--sources DIR]".into()) };
	let mut o = Options::new(root);
	if let Some(r) = recordings {
		o.recordings_dir = r;
	}
	if let Some(s) = sources {
		o.sources_dir = s;
	}
	match grid.as_deref() {
		Some("none") => o.grid_dir = None,
		Some(g) => o.grid_dir = Some(PathBuf::from(g)),
		None => {}
	}
	let t = Instant::now();
	let out = build(&o)?;
	eprintln!("{}", out.summary);
	for w in &out.warnings {
		eprintln!("warning: {w}");
	}
	for l in &out.local_counts {
		eprintln!("{l}");
	}
	eprintln!("built in {:.2}s", t.elapsed().as_secs_f64());
	let mut ok = true;
	let mut names: Vec<(String, &str)> = out.files();
	// A JS reference with a local addon the Rust build lacks.
	let addon = js.join("Polestar_Travel");
	if out.travel_addon.is_none() && addon.is_dir() {
		for e in std::fs::read_dir(&addon).map_err(|e| e.to_string())?.flatten() {
			names.push((format!("Polestar_Travel/{}", e.file_name().to_string_lossy()), ""));
		}
	}
	for (name, text) in &names {
		if let Some(d) = &out_dir {
			let f = d.join(name);
			std::fs::create_dir_all(f.parent().unwrap()).map_err(|e| e.to_string())?;
			std::fs::write(&f, text).map_err(|e| e.to_string())?;
		}
		let Ok(want) = std::fs::read_to_string(js.join(name)) else {
			println!("{name}: missing in {}", js.display());
			ok = false;
			continue;
		};
		if want == *text {
			println!("{name}: identical ({} bytes)", text.len());
			continue;
		}
		ok = false;
		let line = want.lines().zip(text.lines()).position(|(a, b)| a != b).unwrap_or_else(|| want.lines().count().min(text.lines().count()));
		println!("{name}: DIFFERS at line {} ({} vs {} bytes)", line + 1, want.len(), text.len());
		println!("  js:   {}", want.lines().nth(line).unwrap_or("<eof>"));
		println!("  rust: {}", text.lines().nth(line).unwrap_or("<eof>"));
	}
	Ok(ok)
}
