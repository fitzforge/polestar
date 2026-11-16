//! The hybrid walks' two passes (our grid's, Leffe's) side by side by default, one after the other with
//! `WalksIn::serial` (`forge build --walks-serial`): one faction's hybrid walks held both passes' stores, grid
//! and map cache at once and reached 17.8G; one after the other, the peak is the larger pass's. The passes'
//! scheduling is `stage::both`; the walks themselves are the same either way (each pass is deterministic, the
//! merge comes after both).

use forge_nav::stage::both;
use std::sync::atomic::{AtomicUsize, Ordering};
use std::time::Duration;

/// Runs two passes that each note how many passes are running while they work: -> the most at once.
fn most_at_once(serial: bool) -> usize {
	let (running, most) = (AtomicUsize::new(0), AtomicUsize::new(0));
	let work = || {
		let now = running.fetch_add(1, Ordering::SeqCst) + 1;
		most.fetch_max(now, Ordering::SeqCst);
		std::thread::sleep(Duration::from_millis(150));
		running.fetch_sub(1, Ordering::SeqCst);
	};
	let ((), ()) = both(serial, work, work);
	most.load(Ordering::SeqCst)
}

#[test]
fn serial_walk_passes_never_run_at_once_and_the_default_runs_them_side_by_side() {
	assert_eq!(most_at_once(true), 1, "serial: one pass at a time");
	assert_eq!(most_at_once(false), 2, "default: both passes at once");
}

#[test]
fn both_returns_each_pass_s_own_result() {
	for serial in [true, false] {
		assert_eq!(both(serial, || "grid", || 7), ("grid", 7));
	}
}
