//! Customizable contraction hierarchies over the navigation grid's coarse graph
//! (the router design notes).

pub mod graph;
pub mod metric;
pub mod query;
pub mod structure;

/// A rayon pool with `threads` threads (0: rayon's default), kept per count.
pub fn pool(threads: usize) -> std::sync::Arc<rayon::ThreadPool> {
	use parking_lot::Mutex;
	use std::collections::HashMap;
	use std::sync::{Arc, LazyLock};
	static POOLS: LazyLock<Mutex<HashMap<usize, Arc<rayon::ThreadPool>>>> = LazyLock::new(|| Mutex::new(HashMap::new()));
	let mut m = POOLS.lock();
	m.entry(threads).or_insert_with(|| Arc::new(rayon::ThreadPoolBuilder::new().num_threads(threads).build().unwrap())).clone()
}
