//! A `together` rule whose two ends are the same step (one task named twice) holds, and checking it
//! does not panic (c8 hybrid: "slice index starts at 113 but ends at 112" in Checker::valid).

mod common;
use forge_sim::order::{Checker, Feas, Together};
use forge_sim::run::K_TASK;

#[test]
fn together_with_both_ends_on_one_step_holds() {
	let o = common::orc();
	let m = o.model(&[]);
	let seed = o.seed();
	let run = &m.run;
	let s = *seed.steps.iter().find(|s| s.kind == K_TASK).expect("a task step");
	let mut check = Checker::new(run);
	let base = check.valid(&seed.steps, &[], &Feas::default());
	let feas = Feas { together: vec![Together { ka: K_TASK, qa: s.q, kb: K_TASK, qb: s.q, ta: s.task as i32, tb: s.task as i32, near: Vec::new() }], ..Default::default() };
	assert_eq!(check.valid(&seed.steps, &[], &feas), base);
}
