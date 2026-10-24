//! route-overrides.json: an include puts a quest in the route (a hard constraint the checker
//! enforces) and a skip keeps one out; each fails on v1's order without the override and passes
//! with it.

mod common;
use forge_sim::order::{apply_overrides, overrides_for, play_order, Checker, Feas};
use forge_sim::run::K_ACCEPT;
use serde_json::json;

#[test]
fn include_override_puts_a_quest_in() {
	let o = common::orc();
	let m = o.model(&[]);
	let run = &m.run;
	let seed = o.seed();
	let has = |ord: &forge_sim::order::Order, q: u32| ord.steps.iter().any(|s| s.kind == K_ACCEPT && s.q == q);
	// A quest v1 leaves out that has no prerequisite and opens early.
	let q = (0..run.n_quests() as u32)
		.find(|&q| {
			!has(&seed, q)
				&& run.q_pre[q as usize].is_empty()
				&& run.q_all[q as usize].is_empty()
				&& run.q_parent[q as usize] < 0
				&& run.q_min_level[q as usize] <= 10
				&& run.q_task0[q as usize] < run.q_task1[q as usize]
		})
		.expect("a quest v1 leaves out");
	let id = run.q_id[q as usize];
	let ovr = overrides_for(run, &json!({ "include": [{ "q": id, "reason": "test", "issue": "#0" }] }));
	let feas = Feas { keep: ovr.include.iter().map(|x| x.0).collect(), ..Default::default() };
	let mut ck = Checker::new(run);
	assert!(!ck.valid(&seed.steps, &[], &feas), "without the include, v1's order breaks the keep");
	let with = apply_overrides(run, &seed, &ovr);
	assert!(has(&with, q), "the include puts the quest in");
	assert!(ck.valid(&with.steps, &[], &feas), "and the order keeps its rules");
	let mut ev = m.evaluator(&o.walks);
	let (_, did) = play_order(&mut ev, &with.steps);
	let acc = with.steps.iter().position(|s| s.kind == K_ACCEPT && s.q == q).unwrap();
	assert!(did[acc], "its accept is played");
}

#[test]
fn skip_override_keeps_a_quest_out() {
	let o = common::orc();
	let m = o.model(&[]);
	let run = &m.run;
	let seed = o.seed();
	let q = seed.steps.iter().rev().find(|s| s.kind == K_ACCEPT).unwrap().q;
	let id = run.q_id[q as usize];
	let ovr = overrides_for(run, &json!({ "skip": [{ "q": id, "reason": "test", "issue": "#0" }] }));
	let feas = Feas { skip: ovr.skip.clone(), ..Default::default() };
	let mut ck = Checker::new(run);
	assert!(!ck.valid(&seed.steps, &[], &feas), "v1's order has the quest: the skip rejects it");
	let without = apply_overrides(run, &seed, &ovr);
	assert!(!without.steps.iter().any(|s| s.q == q && s.kind == K_ACCEPT), "the skip takes it out");
	assert!(ck.valid(&without.steps, &[], &feas), "and the order keeps its rules");
}

/// A `pairs` override v1's order breaks: keep_pairs moves b's steps (and its quest's later ones)
/// after a's last step, and the checker then passes it. No data needed.
#[test]
fn pair_override_moves_b_after_a() {
	use forge_sim::eval::Step;
	use forge_sim::order::{broken_pairs, keep_pairs, Order, Pair};
	use forge_sim::run::{K_TASK, K_TURNIN};
	let st = |kind, q| Step { kind, q, task: -1, pt: 0 };
	// q1 accept, task, turn-in; q2 accept, turn-in; v1 hands q1 in before q2's accept.
	let steps = vec![st(K_ACCEPT, 1), st(K_TASK, 1), st(K_TURNIN, 1), st(K_ACCEPT, 2), st(K_TURNIN, 2)];
	let seed = Order { origin: (0..steps.len() as i64).collect(), steps };
	// A player report: q1's turn-in after q2's accept.
	let pairs = [Pair { ka: K_ACCEPT, qa: 2, kb: K_TURNIN, qb: 1 }];
	assert_eq!(broken_pairs(&seed.steps, &pairs), vec![0]);
	let kept = keep_pairs(&seed, &pairs);
	assert!(broken_pairs(&kept.steps, &pairs).is_empty());
	let got: Vec<(u8, u32)> = kept.steps.iter().map(|s| (s.kind, s.q)).collect();
	assert_eq!(got, vec![(K_ACCEPT, 1), (K_TASK, 1), (K_ACCEPT, 2), (K_TURNIN, 1), (K_TURNIN, 2)]);
	assert_eq!(kept.origin, vec![0, 1, 3, 2, 4]);
}
