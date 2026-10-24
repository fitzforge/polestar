//! Walking maps for the addon router's tests: hand-made maps written as `forge nav pack` writes a map
//! (forge-nav's fixture writer, `forge_nav::pack::fixture`), in a temp folder the test loads with
//! `dofile` before Polestar_Nav's Routing files.
//!
//! ```ignore
//! let cells = [(20 * 128 + 64, FixtureCell { val: 1, cls: 1 })];
//! let map = write_map(&FixtureMap { map: 7, cells: 128, nx: 1, set: &cells, classes: true, graph: None, hubs: None, zones: None, gen: "-- test" });
//! // map.files: the metadata file, then its parts, in load order
//! ```

use crate::tmp::TempDir;
use std::path::PathBuf;

pub use forge_nav::pack::encode::{encode_areas, encode_zones, run_length};
pub use forge_nav::pack::fixture::{map_files, FixtureCell, FixtureMap};
pub use forge_nav::pack::{enc, B64};

/// A written map: its folder (removed on drop) and its files in load order.
pub struct MapDir {
	pub dir: TempDir,
	pub files: Vec<PathBuf>,
}

impl MapDir {
	/// Lua loading the files in order (a run's `before`).
	pub fn dofiles(&self) -> String {
		self.files.iter().map(|f| format!("dofile({})", crate::lua_string(&f.to_string_lossy()))).collect::<Vec<_>>().join("\n")
	}
}

/// Writes the fixture map's files into a fresh temp folder.
pub fn write_map(f: &FixtureMap) -> MapDir {
	let dir = TempDir::new("polestar-router-");
	let files = map_files(f)
		.unwrap_or_else(|e| panic!("{e}"))
		.into_iter()
		.map(|(name, text)| {
			let p = dir.path().join(name);
			std::fs::write(&p, text).unwrap_or_else(|e| panic!("{}: {e}", p.display()));
			p
		})
		.collect();
	MapDir { dir, files }
}
