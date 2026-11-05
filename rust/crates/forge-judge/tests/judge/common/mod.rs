//! The committed goldens (rust/tests/golden, see their READMEs) the parity tests read: the shareable
//! data slice as a mini repository (golden/world/root), the guide slice (golden/guide/slice), the
//! slice worlds (golden/world/expected), params.json (golden/sim) and the JS references.
#![allow(dead_code)]

use std::io::Read;
use std::path::{Path, PathBuf};

pub fn golden() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden").canonicalize().unwrap()
}

/// The mini repository: data/forever (the slice), data/sources (its client-table and CMaNGOS slices),
/// data/rules.json; no walking grid.
pub fn root() -> PathBuf {
	golden().join("world/root")
}

pub fn data() -> PathBuf {
	root().join("data/forever")
}

/// A grid folder that does not exist: no subzones, as the references were made.
pub fn no_grid() -> PathBuf {
	root().join("data/local/nav4")
}

/// The guide slice (pack.json and the Orc, Troll and Human chains' first guides).
pub fn guides() -> PathBuf {
	golden().join("guide/slice")
}

/// The guide slice made to compile cleanly on the data slice: golden/honest/drop.json's lines (those the
/// slice data cannot resolve, found by its regen.js) blanked, line numbers kept. Written fresh to
/// `<CARGO_TARGET_TMPDIR>/<name>-slice`.
pub fn clean_slice(name: &str) -> PathBuf {
	let drop: serde_json::Value = serde_json::from_slice(&std::fs::read(golden().join("honest/drop.json")).unwrap()).unwrap();
	let pack = Path::new(env!("CARGO_TARGET_TMPDIR")).join(format!("{name}-slice"));
	let _ = std::fs::remove_dir_all(&pack);
	fn copy(from: &Path, to: &Path) {
		std::fs::create_dir_all(to).unwrap();
		for e in std::fs::read_dir(from).unwrap() {
			let e = e.unwrap();
			if e.file_type().unwrap().is_dir() {
				copy(&e.path(), &to.join(e.file_name()));
			} else {
				std::fs::copy(e.path(), to.join(e.file_name())).unwrap();
			}
		}
	}
	copy(&guides(), &pack);
	for (file, lines) in drop["lines"].as_object().unwrap() {
		let p = pack.join(file);
		let mut ls: Vec<String> = std::fs::read_to_string(&p).unwrap().split('\n').map(String::from).collect();
		for n in lines.as_array().unwrap() {
			ls[n.as_u64().unwrap() as usize - 1].clear();
		}
		std::fs::write(&p, ls.join("\n")).unwrap();
	}
	pack
}

/// A gzipped golden file's bytes.
pub fn gunzip(path: &Path) -> Vec<u8> {
	let mut out = Vec::new();
	flate2::read::GzDecoder::new(std::fs::File::open(path).unwrap_or_else(|e| panic!("{}: {e}", path.display()))).read_to_end(&mut out).unwrap();
	out
}

pub fn json_gz(path: &Path) -> serde_json::Value {
	serde_json::from_slice(&gunzip(path)).unwrap()
}

/// The calibration the JS references were made with: golden/sim/params.json, flights at 1 yd/s. The JS
/// read a taxi edge's TaxiPath price (copper) as seconds; at 1 yd/s forge-sim reads v1's world's edges
/// ([`v1_world_file`]) the same way (as forge-sim's own JS-parity test).
pub fn params() -> serde_json::Value {
	let mut p: serde_json::Value = serde_json::from_slice(&std::fs::read(golden().join("sim/params.json")).unwrap()).unwrap();
	p["calibrated"]["flightSpeed"] = serde_json::json!({ "mean": 1.0 });
	p
}

/// The golden sim world the JS references were made on: v1's (taxi edges holding the TaxiPath price,
/// golden/sim/world-<faction>-v1) where the refreshed world differs, else world/expected's.
pub fn v1_world_file(f: forge_core::Faction) -> PathBuf {
	let v1 = golden().join(format!("sim/world-{}-v1.json.gz", f.lower()));
	if v1.is_file() {
		v1
	} else {
		golden().join(format!("world/expected/world-{}.json.gz", f.lower()))
	}
}

pub fn world(f: forge_core::Faction) -> forge_world::World {
	forge_world::World::from_json(&gunzip(&v1_world_file(f))).unwrap()
}

/// `v` with every string's `<prefix>/` cut (file names relative to a folder, as the references hold them).
pub fn strip_prefix(v: serde_json::Value, prefix: &Path) -> serde_json::Value {
	let p = format!("{}/", prefix.display());
	match v {
		serde_json::Value::String(s) => serde_json::Value::String(s.replace(&p, "")),
		serde_json::Value::Array(a) => serde_json::Value::Array(a.into_iter().map(|x| strip_prefix(x, prefix)).collect()),
		serde_json::Value::Object(o) => serde_json::Value::Object(o.into_iter().map(|(k, x)| (k, strip_prefix(x, prefix))).collect()),
		x => x,
	}
}
