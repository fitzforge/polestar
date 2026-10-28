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
	let pairs = [Pair::new(K_ACCEPT, 2, K_TURNIN, 1)];
	assert_eq!(broken_pairs(&seed.steps, &pairs), vec![0]);
	let kept = keep_pairs(&seed, &pairs, &|_, _| false);
	assert!(broken_pairs(&kept.steps, &pairs).is_empty());
	let got: Vec<(u8, u32)> = kept.steps.iter().map(|s| (s.kind, s.q)).collect();
	assert_eq!(got, vec![(K_ACCEPT, 1), (K_TASK, 1), (K_ACCEPT, 2), (K_TURNIN, 1), (K_TURNIN, 2)]);
	assert_eq!(kept.origin, vec![0, 1, 3, 2, 4]);
}

/// The route benchmark's Buzzbox chain (a pair moved Buzzbox 827's hand-in after Fruit of the
/// Sea; Buzzbox 411, taken right after 827's hand-in, then came before it and did nothing): a
/// quest that needs b's quest handed in moves with it, its steps in their order.
#[test]
fn pair_override_carries_the_follow_ups_of_the_quest_it_moves() {
	use forge_sim::eval::Step;
	use forge_sim::order::{broken_pairs, keep_pairs, Order, Pair};
	use forge_sim::run::{K_TASK, K_TURNIN};
	let st = |kind, q| Step { kind, q, task: -1, pt: 0 };
	// q1 (827) accept, task, turn-in; q3 (411, needs q1) accept, task, turn-in; then q2 (Fruit of
	// the Sea) accept: the pair wants q1's task after q2's accept.
	let steps = vec![st(K_ACCEPT, 1), st(K_TASK, 1), st(K_TURNIN, 1), st(K_ACCEPT, 3), st(K_TASK, 3), st(K_TURNIN, 3), st(K_ACCEPT, 2), st(K_TURNIN, 2)];
	let seed = Order { origin: (0..steps.len() as i64).collect(), steps };
	let pairs = [Pair::new(K_ACCEPT, 2, K_TASK, 1)];
	let kept = keep_pairs(&seed, &pairs, &|f, x| f == 3 && x == 1);
	assert!(broken_pairs(&kept.steps, &pairs).is_empty());
	let got: Vec<(u8, u32)> = kept.steps.iter().map(|s| (s.kind, s.q)).collect();
	assert_eq!(got, vec![(K_ACCEPT, 1), (K_ACCEPT, 2), (K_TASK, 1), (K_TURNIN, 1), (K_ACCEPT, 3), (K_TASK, 3), (K_TURNIN, 3), (K_TURNIN, 2)]);
	// Without the follow-up rule (as before), 411 would be taken before 827 is handed in.
	let old = keep_pairs(&seed, &pairs, &|_, _| false);
	let pos = |o: &Order, k: u8, q: u32| o.steps.iter().position(|s| s.kind == k && s.q == q).unwrap();
	assert!(pos(&old, K_ACCEPT, 3) < pos(&old, K_TURNIN, 1));
}

#[test]
fn an_after_rule_v1_breaks_on_one_map_is_kept_by_moving_its_step() {
	// route-fixes deliberate.after[8]/[12] (the Arcane Quickener's reagents before its quickener):
	// v1 has b before a; the seed moves b (and its quest's turn-in) to just after a.
	let o = common::orc();
	let m = o.model(&[]);
	let run = &m.run;
	let seed = o.seed();
	let st = &seed.steps;
	let task_at = |i: usize| st[i].kind == forge_sim::run::K_TASK;
	// Two tasks of different quests on one map, b before a.
	let (ib, ia) = (0..st.len())
		.filter(|&i| task_at(i))
		.find_map(|ib| (ib + 3..st.len().min(ib + 40)).find(|&ia| task_at(ia) && st[ia].q != st[ib].q && run.p_map[st[ia].pt as usize] == run.p_map[st[ib].pt as usize]).map(|ia| (ib, ia)))
		.expect("two tasks on one map");
	let (a, b) = (st[ia], st[ib]);
	let need = forge_sim::order::Need { kb: b.kind, qb: b.q, task: b.task, ka: a.kind, qa: a.q, task_a: a.task, why: "test".into() };
	let (out, notes) = forge_sim::order::keep_after(run, &seed, &[need]);
	let pos = |s: forge_sim::Step| out.steps.iter().position(|x| *x == s).unwrap();
	assert!(pos(b) > pos(a), "b now after a");
	assert_eq!(pos(b), pos(a) + 1);
	assert_eq!(notes.len(), 1);
	assert_eq!(out.len(), seed.len());
	// b's turn-in, if v1 had it before a, follows b.
	if let Some(t) = st[..ia].iter().position(|x| x.kind == forge_sim::run::K_TURNIN && x.q == b.q) {
		assert!(pos(st[t]) > pos(b));
	}
	// The step it needs missing from v1's order (another task of the same quest, the cauldron's
	// Runecloth): it goes in just before.
	let (i0, i1) = (0..st.len()).filter(|&i| task_at(i)).find_map(|i| (i + 1..st.len()).find(|&j| task_at(j) && st[j].q == st[i].q && st[j].task != st[i].task).map(|j| (i, j))).expect("a quest with two tasks");
	let mut without = seed.clone();
	without.steps.remove(i0);
	without.origin.remove(i0);
	let (a, b) = (st[i0], st[i1]);
	let need = forge_sim::order::Need { kb: b.kind, qb: b.q, task: b.task, ka: a.kind, qa: a.q, task_a: a.task, why: "test".into() };
	let (out, _) = forge_sim::order::keep_after(run, &without, &[need]);
	let at = out.steps.iter().position(|x| *x == b).unwrap();
	let x = out.steps[at - 1];
	assert_eq!((x.kind, x.q, x.task), (a.kind, a.q, a.task), "the missing task just before");
}

#[test]
fn a_record_s_task_index_is_the_quest_s_objective_never_another_quest_s_task() {
	// deliberate.after[8]/[12] name ["task", 5218, 2] (the Runecloth, objective 2), which the world
	// works at task 1 with the Osseous Agitators; read as task 0 + 2 it was the next quest's task.
	let o = common::orc();
	let m = o.model(&[]);
	let run = &m.run;
	let (q, t, i) = (0..run.n_quests() as u32)
		.find_map(|q| {
			(run.q_task0[q as usize]..run.q_task1[q as usize]).find_map(|t| {
				let b = run.task_objs[t as usize];
				(b.count_ones() >= 2 && b.trailing_zeros() as u32 != t - run.q_task0[q as usize]).then(|| (q, t, 63 - b.leading_zeros()))
			})
		})
		.expect("a task working two objectives, one of them not its own index");
	assert_eq!(forge_sim::order::rule_task(run, q, u64::from(i)), Some(t as i32), "objective {i} is worked at task {t}");
	let n = (run.q_task1[q as usize] - run.q_task0[q as usize]) as u64;
	assert_eq!(forge_sim::order::rule_task(run, q, 40 + n), None, "no such objective or task: no task");
}

#[test]
fn a_together_rule_v1_breaks_is_kept_by_bringing_b_next_to_a() {
	// A reviewer's "do these together" record (deliberate.together) that v1's order breaks was
	// left out; now b's step comes next to a's.
	let o = common::orc();
	let m = o.model(&[]);
	let run = &m.run;
	let seed = o.seed();
	let st = &seed.steps;
	use forge_sim::run::{K_ACCEPT, K_TURNIN};
	// Two quests' turn-ins far apart in the order, b's earlier quest steps before a.
	let (ia, ib) = (0..st.len())
		.filter(|&i| st[i].kind == K_TURNIN)
		.find_map(|i| (i + 20..st.len()).find(|&j| st[j].kind == K_TURNIN && st[j].q != st[i].q && st[..i].iter().any(|x| x.kind == K_ACCEPT && x.q == st[j].q) && !st[i..j].iter().any(|x| x.q == st[j].q && x.kind != K_TURNIN && x.kind != forge_sim::run::K_GRIND)).map(|j| (i, j)))
		.expect("two turn-ins apart");
	let (a, b) = (st[ia], st[ib]);
	let near: Vec<u32> = (0..run.pt_list.len() as u32).filter(|&p| run.straight(b.pt, p) <= 300.0).collect();
	let t = forge_sim::order::Together { ka: a.kind, qa: a.q, kb: b.kind, qb: b.q, ta: -1, tb: -1, near };
	let (out, notes) = forge_sim::order::keep_together(run, &seed, &[t]);
	let pos = |s: forge_sim::Step| out.steps.iter().position(|x| *x == s).unwrap();
	assert_eq!(notes.len(), 1, "repaired");
	assert_eq!(pos(b), pos(a) + 1, "b right after a");
	assert_eq!(out.len(), seed.len());
}

#[test]
fn a_pair_s_objective_index_names_that_objective_s_task() {
	// IssueSweep (order.rs deliberate_pairs): a record's ["task", Q, objective] was read as every
	// task of Q.
	use forge_sim::order::{broken_pairs, Pair};
	use forge_sim::run::{K_TASK, K_TURNIN};
	use forge_sim::Step;
	let st = |kind, q, task| Step { kind, q, task, pt: 0 };
	let steps = vec![st(K_ACCEPT, 1, -1), st(K_TASK, 1, 5), st(K_ACCEPT, 2, -1), st(K_TASK, 1, 6), st(K_TURNIN, 1, -1), st(K_TURNIN, 2, -1)];
	let one = Pair { ta: 5, ..Pair::new(K_TASK, 1, K_ACCEPT, 2) };
	let any = Pair::new(K_TASK, 1, K_ACCEPT, 2);
	assert!(broken_pairs(&steps, &[one]).is_empty(), "objective 5's task is before 2's accept");
	assert_eq!(broken_pairs(&steps, &[any]), vec![0], "every task is not");
	let o = common::orc();
	let m = o.model(&[]);
	let mut c = Checker::new(&m.run);
	assert!(c.valid(&steps, &[one], &Feas::default()));
	assert!(!c.valid(&steps, &[any], &Feas::default()));
}

#[test]
fn a_quest_the_overrides_skip_is_named_dropped() {
	// RevH2 (c10): overrides.skip 5821/5943 came out before the seed, so the route's diff never
	// named them and the writer kept v1's lines.
	let o = common::orc();
	let m = o.model(&[]);
	let run = &m.run;
	let v1 = o.seed();
	let q = v1.steps.iter().find(|s| s.kind == K_ACCEPT).unwrap().q;
	let ovr = forge_sim::order::Overrides { skip: vec![q], ..Default::default() };
	let seed = apply_overrides(run, &v1, &ovr);
	let d = forge_sim::order::diff(run, &seed, &seed);
	assert!(d.dropped.is_empty(), "the seed's own diff does not see it");
	assert_eq!(forge_sim::route::dropped_from_v1(run, &v1, &seed, &d.dropped), vec![run.q_id[q as usize]]);
}
