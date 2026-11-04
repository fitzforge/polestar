//! Where the nav parity tests read their JS references: the committed goldens (rust/tests/golden/
//! nav-grid, nav-walks, nav-legs, nav-store; their README.md) unless POLESTAR_REF is set, which reads
//! the old local references instead: $POLESTAR_REF (parity/*.js outputs, a scratch folder),
//! $POLESTAR_RESET (a scratch root holding sim/ and cchtest-full/cas/walktable) and $POLESTAR_GRID
//! (default $POLESTAR_CHECKOUT/data/local/nav4). Missing any of them: the goldens, with a note.
#![allow(dead_code)]
use std::path::{Path, PathBuf};

pub struct Refs {
	/// The walking grid (nav4 layout; hubs.json at ../nav-layers).
	pub grid: PathBuf,
	/// asks.js's per-faction dir (ends.json, asks-<band>.{bin,json}) and areazones.json's dir.
	refd: PathBuf,
	/// The saved router tables, <key>.bin.
	tables: PathBuf,
	/// world-<f>.json, walks-<f>.bin, the route, legs and lookup samples.
	worlds: PathBuf,
	walks: PathBuf,
	lookups: PathBuf,
	route: PathBuf,
	legs: PathBuf,
	pub golden: bool,
}

pub fn golden_dir() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden")
}

pub fn refs() -> Refs {
	if let Ok(refd) = std::env::var("POLESTAR_REF") {
		let refd = PathBuf::from(refd);
		let reset = std::env::var_os("POLESTAR_RESET").map(PathBuf::from);
		let grid = std::env::var_os("POLESTAR_GRID").map(PathBuf::from).or_else(|| std::env::var_os("POLESTAR_CHECKOUT").map(|c| PathBuf::from(c).join("data/local/nav4")));
		let (Some(reset), Some(grid)) = (reset, grid) else {
			eprintln!("POLESTAR_REF set without POLESTAR_RESET and POLESTAR_GRID (or POLESTAR_CHECKOUT): reading the goldens");
			return golden_refs();
		};
		return Refs {
			grid,
			tables: reset.join("cchtest-full/cas/walktable"),
			worlds: reset.join("sim"),
			walks: reset.join("sim"),
			lookups: refd.clone(),
			route: reset.join("sim/routes/horde-orc-warrior-smooth2.json"),
			legs: refd.join("legs-horde.json"),
			refd,
			golden: false,
		};
	}
	golden_refs()
}

fn golden_refs() -> Refs {
	let g = golden_dir();
	Refs {
		grid: g.join("nav-grid/nav4"),
		refd: g.join("nav-walks"),
		tables: g.join("nav-walks/walktable"),
		worlds: g.join("nav-walks"),
		walks: g.join("nav-store"),
		lookups: g.join("nav-store"),
		route: g.join("nav-walks/route-horde.json"),
		legs: g.join("nav-legs/legs-horde.json.gz"),
		golden: true,
	}
}

fn read(p: &Path) -> Vec<u8> {
	std::fs::read(p).unwrap_or_else(|e| panic!("{}: {e}", p.display()))
}

impl Refs {
	pub fn areazones(&self) -> Vec<u8> {
		read(&self.refd.join("areazones.json"))
	}
	pub fn ends(&self) -> Vec<u8> {
		read(&self.refd.join("horde/ends.json"))
	}
	pub fn asks_json(&self, band: usize) -> Vec<u8> {
		read(&self.refd.join(format!("horde/asks-{band}.json")))
	}
	pub fn asks_bin(&self, band: usize) -> Vec<u8> {
		read(&self.refd.join(format!("horde/asks-{band}.bin")))
	}
	pub fn table(&self, key: &str) -> Vec<u8> {
		read(&self.tables.join(format!("{key}.bin")))
	}
	pub fn table_path(&self, key: &str) -> PathBuf {
		self.tables.join(format!("{key}.bin"))
	}
	/// world-<faction>.json (lower case).
	pub fn world(&self, faction: &str) -> Vec<u8> {
		read(&self.worlds.join(format!("world-{faction}.json")))
	}
	pub fn walks_bin(&self, faction: &str) -> Vec<u8> {
		read(&self.walks.join(format!("walks-{faction}.bin")))
	}
	pub fn lookup(&self, faction: &str) -> Vec<u8> {
		read(&self.lookups.join(format!("lookup-{faction}.bin")))
	}
	pub fn route(&self) -> Vec<u8> {
		read(&self.route)
	}
	/// legs-ref.js's document (gzipped in the golden).
	pub fn legs(&self) -> Vec<u8> {
		let b = read(&self.legs);
		if self.legs.extension().is_some_and(|e| e == "gz") {
			let mut out = Vec::new();
			std::io::Read::read_to_end(&mut flate2::read::GzDecoder::new(&b[..]), &mut out).unwrap();
			out
		} else {
			b
		}
	}
}
