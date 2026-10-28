//! Shared loaders for the real-data tests, all from committed goldens (rust/tests/golden, see their
//! READMEs): the slice worlds (golden/world/expected, the JS world builder's output on the shareable
//! data slice), params.json and v1's chain events (golden/sim, the JS judge walk replayed on the JS
//! v1 evaluator, walks off). Walks are off: a walk table needs the walking grid, which is not shareable.
#![allow(dead_code)]

use forge_core::Faction;
use forge_sim::chain::events_from;
use forge_sim::order::{seed_order, Order};
use forge_sim::profile::Profile;
use forge_sim::route::model_for;
use forge_sim::{Model, NoWalks, Params};
use forge_world::World;
use std::io::Read;
use std::path::{Path, PathBuf};

pub mod stage;

pub fn golden() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden").canonicalize().unwrap()
}

/// A gzipped golden file's bytes.
pub fn gunzip(path: &Path) -> Vec<u8> {
	let mut out = Vec::new();
	flate2::read::GzDecoder::new(std::fs::File::open(path).unwrap_or_else(|e| panic!("{}: {e}", path.display()))).read_to_end(&mut out).unwrap();
	out
}

/// The golden slice world of a faction.
/// The golden world as v1 built it (golden/sim/world-<faction>-v1.json.gz when the world's golden has
/// since changed: the horde taxi edges hold v1's TaxiPath prices), else the world golden.
pub fn world(f: Faction) -> World {
	let v1 = golden().join(format!("sim/world-{}-v1.json.gz", f.lower()));
	let path = if v1.is_file() { v1 } else { golden().join(format!("world/expected/world-{}.json.gz", f.lower())) };
	World::from_json(&gunzip(&path)).expect("golden world")
}

/// v1's chain for a start (golden/sim/v1-<faction>-<race>-off.json.gz).
pub fn seed_doc(f: Faction, race: &str) -> serde_json::Value {
	serde_json::from_slice(&gunzip(&golden().join(format!("sim/v1-{}-{}-off.json.gz", f.lower(), race.to_lowercase())))).unwrap()
}

pub fn params_doc() -> Option<serde_json::Value> {
	Some(serde_json::from_slice(&std::fs::read(golden().join("sim/params.json")).unwrap()).unwrap())
}

pub struct Orc {
	pub world: World,
	pub walks: NoWalks,
	pub doc: serde_json::Value,
}

pub fn orc() -> Orc {
	Orc { world: world(Faction::Horde), walks: NoWalks, doc: seed_doc(Faction::Horde, "Orc") }
}

impl Orc {
	pub fn model(&self, over: &[(String, f64)]) -> Model {
		let base = Params::effective(params_doc().as_ref(), None, over);
		model_for(&self.world, "Orc", &Profile::average(Faction::Horde), &base, &self.walks).unwrap().0
	}

	/// v1's order (built in v1's model, so every term plays the same order).
	pub fn seed(&self) -> Order {
		let m = self.model(&[]);
		let mut ev = m.evaluator(&self.walks);
		seed_order(&mut ev, &events_from(&self.doc), true)
	}
}
