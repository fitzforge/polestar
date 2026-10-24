//! Property tests (proptest) on v1's Orc order and the real world: replays are deterministic,
//! snapshots resume exactly, time and level never go back, and the search's windowed replay of a
//! move equals a replay from scratch (fg's FG_VERIFY oracle), for every move kind.

mod common;
use forge_sim::order::{action_hash, deliberate_pairs, play_order, Order};
use forge_sim::search::{pool, runs, Member, Problem, MOVES};
use forge_sim::Model;
use proptest::prelude::*;
use std::sync::OnceLock;

struct Fix {
	o: common::Orc,
	m: Model,
	seed: Order,
}

fn fix() -> &'static Fix {
	static F: OnceLock<Fix> = OnceLock::new();
	F.get_or_init(|| {
		let o = common::orc();
		let m = o.model(&[("camps".into(), 1.0), ("spots".into(), 1.0)]);
		let seed = o.seed();
		Fix { o, m, seed }
	})
}

proptest! {
	#![proptest_config(ProptestConfig { cases: 64, ..ProptestConfig::default() })]

	#[test]
	fn replay_is_deterministic(cut in 0usize..2400) {
		let f = fix();
		let steps = &f.seed.steps[..cut.min(f.seed.len())];
		let mut ev = f.m.evaluator(&f.o.walks);
		let a = action_hash(&mut ev, steps);
		let mut ev2 = f.m.evaluator(&f.o.walks);
		prop_assert_eq!(a, action_hash(&mut ev2, steps));
		prop_assert_eq!(a, action_hash(&mut ev, steps));
	}

	#[test]
	fn snapshot_resumes_exactly(at in 0usize..2400) {
		let f = fix();
		let steps = &f.seed.steps;
		let k = at.min(steps.len());
		let mut ev = f.m.evaluator(&f.o.walks);
		let (full, _) = play_order(&mut ev, steps);
		ev.reset();
		for i in 0..k {
			ev.step_in(steps, i);
		}
		let snap = ev.snapshot();
		ev.reset();
		ev.load(&snap);
		for i in k..steps.len() {
			if !ev.s.finished {
				ev.step_in(steps, i);
			}
		}
		ev.finish();
		prop_assert_eq!(full.to_bits(), ev.seconds().to_bits());
	}

	#[test]
	fn time_and_level_never_go_back(cut in 1usize..2400) {
		let f = fix();
		let steps = &f.seed.steps[..cut.min(f.seed.len())];
		let mut ev = f.m.evaluator(&f.o.walks);
		let (mut t, mut l) = (0.0, 1.0);
		for i in 0..steps.len() {
			ev.step_in(steps, i);
			prop_assert!(ev.s.time >= t && ev.level_now() >= l);
			t = ev.s.time;
			l = ev.level_now();
		}
	}

	#[test]
	fn windowed_replay_equals_full(kind in 0usize..MOVES, rng in any::<u64>()) {
		let f = fix();
		let mut ev = f.m.evaluator(&f.o.walks);
		let rules = forge_world::Rules::new(&f.o.world, "Orc", None, false);
		let _ = &mut ev;
		let p = Problem::single(&f.m, &f.o.walks, deliberate_pairs(&f.m.run), pool(&f.m.run, &rules, &f.seed, &f.m.tables));
		let start = runs(&p, &f.seed);
		let mut mem = Member::new(&p, f.seed.clone(), &start, rng);
		for _ in 0..20 {
			if let Some((inc, full)) = mem.verify_move(&p, kind) {
				prop_assert_eq!(inc.to_bits(), full.to_bits(), "move {}: windowed {} vs full {}", kind, inc, full);
			}
		}
	}
}
