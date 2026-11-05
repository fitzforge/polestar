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
pub mod gate;
pub mod group;
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

/// f(i) for i in 0..n, on the threads when built with them (native), in order of i.
#[cfg(feature = "native")]
pub(crate) fn par_map<T: Send, F: Fn(usize) -> T + Sync + Send>(n: usize, f: F) -> Vec<T> {
	use rayon::prelude::*;
	(0..n).into_par_iter().map(f).collect()
}

#[cfg(not(feature = "native"))]
pub(crate) fn par_map<T, F: Fn(usize) -> T>(n: usize, f: F) -> Vec<T> {
	(0..n).map(f).collect()
}

/// par_map with scratch state `init()` per thread's run of items.
#[cfg(feature = "native")]
pub(crate) fn par_map_with<S, T: Send, I: Fn() -> S + Sync + Send, F: Fn(&mut S, usize) -> T + Sync + Send>(n: usize, init: I, f: F) -> Vec<T> {
	use rayon::prelude::*;
	(0..n).into_par_iter().map_init(init, f).collect()
}

#[cfg(not(feature = "native"))]
pub(crate) fn par_map_with<S, T, I: Fn() -> S, F: Fn(&mut S, usize) -> T>(n: usize, init: I, f: F) -> Vec<T> {
	let mut s = init();
	(0..n).map(|i| f(&mut s, i)).collect()
}

/// f(&mut items[i], i) for i in 0..n (n at most items.len()), on the threads, in order of i.
#[cfg(feature = "native")]
pub(crate) fn par_each_mut<S: Send, T: Send, F: Fn(&mut S, usize) -> T + Sync + Send>(items: &mut [S], n: usize, f: F) -> Vec<T> {
	use rayon::prelude::*;
	items[..n].par_iter_mut().with_max_len(1).enumerate().map(|(i, s)| f(s, i)).collect()
}

#[cfg(not(feature = "native"))]
pub(crate) fn par_each_mut<S, T, F: Fn(&mut S, usize) -> T>(items: &mut [S], n: usize, f: F) -> Vec<T> {
	items[..n].iter_mut().enumerate().map(|(i, s)| f(s, i)).collect()
}

/// The threads par_map and its kin run on.
pub(crate) fn threads() -> usize {
	#[cfg(feature = "native")]
	return rayon::current_num_threads();
	#[cfg(not(feature = "native"))]
	1
}

/// The world a sim dir's walks were built on: `<sim_dir>/world-<faction>.json` (the world file
/// as built, so its point ids are the walks' keys).
#[cfg(feature = "native")]
pub fn load_world(sim_dir: &std::path::Path, faction: forge_core::Faction) -> Result<forge_world::World, String> {
	let f = sim_dir.join(format!("world-{}.json", faction.lower()));
	let b = std::fs::read(&f).map_err(|e| format!("{}: {e}", f.display()))?;
	forge_world::World::from_json(&b).map_err(|e| format!("{}: {e}", f.display()))
}
