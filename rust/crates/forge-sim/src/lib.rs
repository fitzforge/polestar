//! Route simulation: the evaluator (state and journal, the time model), orders of events, the
//! class-agnostic profile, the search from v1's order and the shared faction route.
//!
//! The model is v1's evaluator (tools/lib/sim/evaluate.js), the one the judge and the gate
//! measure hours in, ported exactly (walks off reproduces the gate's hours). Walks come from a
//! `Walks` store (today `data/sim/walks-<faction>.bin`); they are on for the search and the
//! reported hours.
//!
//! Borrowed from Factoruide (MIT, by Joel, used with his permission): the windowed replay with
//! the at-equal-XP estimate (fg-route plan/evaluate.rs) and the tournament counted in tries with
//! meetings (plan/search.rs, plan/share.rs), adapted in `search.rs`.

pub mod chain;
pub mod eval;
pub mod fixes;
pub mod flow;
pub mod guards;
pub mod hubs;
pub mod insertable;
pub mod ledger;
pub mod needs;
pub mod order;
pub mod params;
pub mod profile;
pub mod resume;
pub mod rng;
pub mod route;
pub mod run;
pub mod search;
pub mod seq;
pub mod shared;
#[cfg(feature = "native")]
pub mod stage;
pub mod travel;
pub mod walks;
pub mod widen;
pub mod xp;

pub use eval::{Evaluator, Step};
pub use params::Params;
pub use run::{compile_run, make_tables, Run, Tables};
pub use seq::{compile_events, Ev, Event};
pub use walks::{NoWalks, WalkTable, Walks};

use std::sync::Arc;
use travel::TravelBase;

/// A character's compiled model: run, tables and travel base (shared by evaluators).
pub struct Model {
	pub run: Run,
	pub tables: Tables,
	pub travel: Arc<TravelBase>,
}

impl Model {
	pub fn new(run: Run, p: &Params, walks: &dyn Walks) -> Model {
		let tables = make_tables(&run, p);
		let travel = Arc::new(TravelBase::new(&run, p, walks));
		Model { run, tables, travel }
	}

	pub fn evaluator<'a>(&'a self, walks: &'a dyn Walks) -> Evaluator<'a> {
		Evaluator::new(&self.run, &self.tables, walks, self.travel.clone())
	}
}

/// The world a sim dir's walks were built on: `<sim_dir>/world-<faction>.json` (the world file
/// as built, so its point ids are the walks' keys).
#[cfg(feature = "native")]
pub fn load_world(sim_dir: &std::path::Path, faction: forge_core::Faction) -> Result<forge_world::World, String> {
	let f = sim_dir.join(format!("world-{}.json", faction.lower()));
	let b = std::fs::read(&f).map_err(|e| format!("{}: {e}", f.display()))?;
	forge_world::World::from_json(&b).map_err(|e| format!("{}: {e}", f.display()))
}
