//! Tauren's Plainsrunning (params::plainsrunning_sec) against a step-by-step walk at the recorded
//! ramp: +1% run speed every 5 s from the start of the walk, to +30%. The numbers are Fitz's
//! recorded trails (2026-10-23): 7.00 to 9.10 yd/s, 0.07 per 5.0 s.

use forge_sim::params::{plainsrunning_sec, PLAINS_STACK, PLAINS_STACKS, PLAINS_STEP_SEC};

/// Seconds to cover `base` run-speed seconds of walk, 1 ms at a time.
fn walked(base: f64) -> f64 {
	let (mut t, mut d) = (0.0f64, 0.0f64);
	let dt = 0.001;
	while d < base {
		let k = (t / PLAINS_STEP_SEC).floor().min(PLAINS_STACKS);
		d += dt * (1.0 + PLAINS_STACK * k);
		t += dt;
	}
	t
}

#[test]
fn plainsrunning_matches_a_stepwise_walk() {
	for base in [0.0, 3.0, 5.0, 10.0, 47.5, 120.0, 171.75, 300.0, 900.0] {
		let (got, want) = (plainsrunning_sec(base), walked(base));
		assert!((got - want).abs() < 0.01, "{base} s: {got} vs {want}");
	}
	// A walk of 7 minutes at the run speed takes a Tauren 341 s (the cap after 150 s).
	assert!((plainsrunning_sec(420.0) - 340.96).abs() < 0.01, "{}", plainsrunning_sec(420.0));
}
