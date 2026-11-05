//! Phase timings for the build loop (`POLESTAR_BUILD_TIMES=1`): where a `forge build` spends its minutes,
//! per stage, start and phase (the routes stage's searches, post passes and written-check rounds,
//! the writer per start).
//!
//! Off (the default) a timer is `None` and nothing is measured, logged or kept. On, every phase
//! ends in a `timing: <scope> <phase> <seconds> s` line on stderr and a row kept for
//! [`take`] (forge build writes them to `<out>/timings.json` per stage). Wall-clock seconds:
//! phases that run at once (the factions, a faction's own cuts) overlap.

use std::sync::{LazyLock, Mutex};
use std::time::Instant;

/// One timed phase: who (a stage, a start, a faction), what, seconds of wall clock.
#[derive(Clone, Debug, PartialEq, serde::Serialize)]
pub struct Row {
	pub scope: String,
	pub phase: String,
	pub seconds: f64,
}

static ON: LazyLock<bool> = LazyLock::new(|| std::env::var("POLESTAR_BUILD_TIMES").is_ok_and(|v| !v.is_empty() && v != "0"));
static ROWS: Mutex<Vec<Row>> = Mutex::new(Vec::new());

/// Timings are on: `POLESTAR_BUILD_TIMES` set to anything but empty or `0`.
pub fn on() -> bool {
	*ON
}

/// A running timer (None while timings are off).
pub struct Timer(Option<Instant>);

/// A timer from now.
pub fn start() -> Timer {
	Timer(on().then(Instant::now))
}

impl Timer {
	/// The phase since the timer started (or last lapped) recorded under `scope`, and the timer
	/// started again.
	pub fn lap(&mut self, scope: &str, phase: &str) {
		if let Some(t) = self.0 {
			record(scope, phase, t.elapsed().as_secs_f64());
			self.0 = Some(Instant::now());
		}
	}

	/// The phase since the timer started (or last lapped) recorded under `scope`.
	pub fn done(self, scope: &str, phase: &str) {
		if let Some(t) = self.0 {
			record(scope, phase, t.elapsed().as_secs_f64());
		}
	}
}

/// `f`, timed as `phase` under `scope`.
pub fn timed<T>(scope: &str, phase: &str, f: impl FnOnce() -> T) -> T {
	let t = start();
	let v = f();
	t.done(scope, phase);
	v
}

/// A phase's seconds recorded and logged (timings on).
pub fn record(scope: &str, phase: &str, seconds: f64) {
	if !on() {
		return;
	}
	eprintln!("timing: {scope} {phase} {seconds:.1} s");
	ROWS.lock().unwrap_or_else(|e| e.into_inner()).push(Row { scope: scope.to_string(), phase: phase.to_string(), seconds });
}

/// The rows recorded so far, emptied.
pub fn take() -> Vec<Row> {
	std::mem::take(&mut *ROWS.lock().unwrap_or_else(|e| e.into_inner()))
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn off_by_default_records_nothing() {
		// (POLESTAR_BUILD_TIMES is not set in the test environment.)
		if on() {
			return;
		}
		let mut t = start();
		assert!(t.0.is_none());
		t.lap("routes Orc", "search");
		assert_eq!(timed("routes", "x", || 3), 3);
		record("routes", "y", 1.0);
		assert!(take().is_empty());
	}
}
