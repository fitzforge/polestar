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

#[test]
fn a_skip_with_a_faction_holds_for_that_side_only() {
	// c18: Silver Heart is left out of the Horde's Felwood (v1) and kept in the Alliance's.
	let o = common::orc();
	let m = o.model(&[]);
	let run = &m.run;
	let seed = o.seed();
	let q = seed.steps.iter().rev().find(|s| s.kind == K_ACCEPT).unwrap().q;
	let id = run.q_id[q as usize];
	let skip = |faction: &str| overrides_for(run, &json!({ "skip": [{ "q": id, "reason": "test", "issue": "", "faction": faction }] })).skip;
	assert_eq!(skip("Horde"), vec![q], "the Horde's skip holds on the Horde's route");
	assert!(skip("Alliance").is_empty(), "the Alliance's skip does not");
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

/// The route review's Buzzbox chain (a pair moved Buzzbox 827's hand-in after Fruit of the
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
	let (i0, i1) =
		(0..st.len()).filter(|&i| task_at(i)).find_map(|i| (i + 1..st.len()).find(|&j| task_at(j) && st[j].q == st[i].q && st[j].task != st[i].task).map(|j| (i, j))).expect("a quest with two tasks");
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
				(b.count_ones() >= 2 && b.trailing_zeros() != t - run.q_task0[q as usize]).then(|| (q, t, 63 - b.leading_zeros()))
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
		.find_map(|i| {
			(i + 20..st.len())
				.find(|&j| {
					st[j].kind == K_TURNIN
						&& st[j].q != st[i].q
						&& st[..i].iter().any(|x| x.kind == K_ACCEPT && x.q == st[j].q)
						&& !st[i..j].iter().any(|x| x.q == st[j].q && x.kind != K_TURNIN && x.kind != forge_sim::run::K_GRIND)
				})
				.map(|j| (i, j))
		})
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
fn a_together_rule_whose_b_cannot_move_is_kept_by_bringing_a_to_b() {
	// c14 Night Elf B4: deliberate.together[44] (task 488 Zenn's lurkers, then task 4161 the
	// recipe from the same lurkers) has 4161's accept between them in v1. b moved to a takes its
	// accept along, which then sits between a and b: the repair failed and keep_seed left the
	// record out (one more lurker pass). Now a moves to b instead.
	let o = common::orc();
	let m = o.model(&[]);
	let run = &m.run;
	let seed = o.seed();
	let st = &seed.steps;
	use forge_sim::run::{K_TASK, K_TURNIN};
	let mut c = Checker::new(run);
	let found = (0..st.len()).filter(|&ib| st[ib].kind == K_TASK).find_map(|ib| {
		let qb = st[ib].q;
		// b's accept before b, and a: another quest's task just before that accept, whose quest
		// has nothing between a and b but its turn-in.
		let iacc = (0..ib).rev().find(|&i| st[i].kind == K_ACCEPT && st[i].q == qb)?;
		(iacc.saturating_sub(6)..iacc).rev().find_map(|ia| {
			let (a, b) = (st[ia], st[ib]);
			if a.kind != K_TASK || a.q == qb || st[ia + 1..=ib].iter().any(|x| x.q == a.q && x.kind != K_TURNIN && x.kind != forge_sim::run::K_GRIND) {
				return None;
			}
			let t = forge_sim::order::Together { ka: a.kind, qa: a.q, kb: b.kind, qb, ta: a.task, tb: b.task, near: Vec::new() };
			let (out, notes) = forge_sim::order::keep_together(run, &seed, std::slice::from_ref(&t));
			Some((a, b, t, out, notes))
		})
	});
	let (a, b, t, out, notes) = found.expect("a task, then another quest's accept and task");
	let pos = |s: forge_sim::Step| out.steps.iter().position(|x| *x == s).unwrap();
	assert_eq!(notes.len(), 1, "repaired: {notes:?}");
	assert_eq!(pos(b), pos(a) + 1, "a right before b");
	assert!(out.steps.iter().position(|x| x.kind == K_ACCEPT && x.q == b.q).unwrap() < pos(a), "b's accept stays before");
	assert_eq!(out.len(), seed.len());
	assert!(c.valid(&out.steps, &[], &Feas { together: vec![t], ..Default::default() }));
}

#[test]
fn a_record_another_record_s_repair_breaks_is_repaired_again() {
	// P1 (c14 Human #613): the c13 pairs moved turnin 112 behind the second east trip, breaking
	// the earlier `112 before 76`, which route.rs then left out as "v1 breaks deliberate pair".
	// keep_records repairs every record again until none moves.
	use forge_sim::order::{broken_pairs, keep_pairs, keep_records, Order, Pair};
	use forge_sim::run::K_TURNIN;
	let st = |q| forge_sim::Step { kind: K_TURNIN, q, task: -1, pt: 0 };
	let seed = Order { steps: vec![st(1), st(2), st(3)], origin: vec![0, 1, 2] };
	// 1 before 2 (kept by v1), 3 before 1 (broken by v1): moving 1 behind 3 breaks the first.
	let pairs = [Pair::new(K_TURNIN, 1, K_TURNIN, 2), Pair::new(K_TURNIN, 3, K_TURNIN, 1)];
	assert_eq!(broken_pairs(&keep_pairs(&seed, &pairs, &|_, _| false).steps, &pairs), vec![0], "one pass breaks the first");
	let o = common::orc();
	let m = o.model(&[]);
	let (out, _) = keep_records(&m.run, &seed, &pairs, &[], &[], &[], None);
	assert!(broken_pairs(&out.steps, &pairs).is_empty());
	assert_eq!(out.steps.iter().map(|s| s.q).collect::<Vec<_>>(), vec![3, 1, 2]);
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
	// c10 review: overrides.skip 5821/5943 came out before the seed, so the route's diff never
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

#[test]
fn a_start_s_rule_its_joined_order_breaks_is_left_out_of_its_passes() {
	// P2 (c14 Tauren): the stay need "task 871 after task 903" from Tauren's own v1 Barrens order;
	// the shared tail is Orc's, which has 871's tasks first. Held, the rule refused every move of
	// every pass on Tauren's own part (and every quest the ledger tried). Problem::hold keeps only
	// the rules the joined order keeps.
	let o = common::orc();
	let m = o.model(&[]);
	let seed = o.seed();
	let st = &seed.steps;
	let i = st.iter().position(|s| s.kind == forge_sim::run::K_TASK).unwrap();
	let j = (i + 1..st.len()).find(|&j| st[j].kind == forge_sim::run::K_TASK && st[j].q != st[i].q).unwrap();
	let (a, b) = (st[i], st[j]);
	// Rules the order breaks (b's step before a's) and one it keeps.
	let broken = forge_sim::order::Need { kb: a.kind, qb: a.q, task: a.task, ka: b.kind, qa: b.q, task_a: b.task, why: "test".into() };
	let held = forge_sim::order::Need { kb: b.kind, qb: b.q, task: b.task, ka: a.kind, qa: a.q, task_a: a.task, why: "test".into() };
	use forge_sim::order::Pair;
	let pairs = vec![Pair { ta: b.task, tb: a.task, ..Pair::new(b.kind, b.q, a.kind, a.q) }, Pair { ta: a.task, tb: b.task, ..Pair::new(a.kind, a.q, b.kind, b.q) }];
	let mut p = forge_sim::search::Problem::single(&m, &forge_sim::NoWalks, pairs, Vec::new());
	p.feas = Feas { needs: vec![broken, held], ..Default::default() };
	let mut c = Checker::new(&m.run);
	assert!(!c.valid(st, &p.pairs, &p.feas), "the order breaks two of them");
	assert_eq!(p.hold(st), 2);
	assert_eq!((p.pairs.len(), p.feas.needs.len()), (1, 1), "the held ones stay");
	assert!(c.valid(st, &p.pairs, &p.feas));
}

#[test]
fn a_record_repair_that_breaks_a_chain_is_refused() {
	// c15 Night Elf: together[47]'s repair (Gaerolas moved to the dresser) carried turnin 929 past
	// accept 933; the chain pair was left out and Crown of the Earth 933-98065 fell out of the
	// route. Here an `after` record whose repair would hand X in after Y's accept, Y following X:
	// refused and named, the chain kept.
	use forge_sim::order::{chain_breaks, keep_records, Need};
	use forge_sim::run::{K_TASK, K_TURNIN};
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let st = &seed.steps;
	// X handed in, then Y (following X) taken, then a task W of another quest.
	let (ix, iy, iw) = (0..st.len())
		.filter(|&i| st[i].kind == K_ACCEPT && !r.q_pre[st[i].q as usize].is_empty())
		.find_map(|iy| {
			let y = st[iy].q;
			let ix = (0..iy).rev().find(|&i| st[i].kind == K_TURNIN && r.q_pre[y as usize].contains(&st[i].q))?;
			let iw = (iy + 1..st.len()).find(|&i| st[i].kind == K_TASK && st[i].q != y && st[i].q != st[ix].q)?;
			Some((ix, iy, iw))
		})
		.expect("a chain and a task after it");
	let (x, w) = (st[ix], st[iw]);
	assert!(chain_breaks(r, st, &[]).iter().all(|b| *b != (x.q, st[iy].q)), "v1 keeps it");
	let need = Need { kb: K_TURNIN, qb: x.q, task: -1, ka: K_TASK, qa: w.q, task_a: w.task, why: "test".into() };
	let (out, notes) = keep_records(r, &seed, &[], &[need], &[], &[], None);
	assert!(!chain_breaks(r, &out.steps, &[]).contains(&(x.q, st[iy].q)), "the chain kept");
	assert!(notes.iter().any(|n| n.starts_with("repair refused")), "named: {notes:?}");
}

#[test]
fn a_pair_a_joined_order_breaks_across_its_join_is_repaired() {
	// c15 Night Elf (overrides.pairs[14]): Fruit of the Sea taken before Buzzbox 827's crawler
	// legs; the shared route had the legs in Night Elf's own part at 13.67 and the accept in the
	// tail at 17.31. Here: v1's Orc order joined at 60, a pair "accept X (in the tail) before task
	// Y (in the own part)": repaired, Y in the tail after X, the join one step earlier.
	use forge_sim::order::{broken_pairs, Pair};
	use forge_sim::run::K_TASK;
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let st = &seed.steps;
	let join = 60;
	// Y: a task in the own part whose quest's other steps are all in the own part, nothing follows
	// it; X: an accept in the tail of a quest not following Y's.
	let iy = (10..join - 5)
		.rev()
		.find(|&i| st[i].kind == K_TASK && st.iter().enumerate().all(|(k, x)| x.q != st[i].q || k < join) && (0..r.n_quests() as u32).all(|q| !forge_sim::order::follows(r, q, st[i].q)))
		.expect("an own-part task");
	let y = st[iy];
	let tin = st.iter().position(|x| x.q == y.q && x.kind == forge_sim::run::K_TURNIN).unwrap();
	let ix = (join + 5..st.len()).find(|&i| st[i].kind == K_ACCEPT && !forge_sim::order::follows(r, st[i].q, y.q)).expect("a tail accept");
	let x = st[ix];
	let pair = Pair { tb: y.task, ..Pair::new(K_ACCEPT, x.q, K_TASK, y.q) };
	let mut order = seed.clone();
	assert_eq!(broken_pairs(&order.steps, &[pair]), vec![0]);
	let (new_join, notes) = forge_sim::shared::repair_across_join(r, &[pair], &[], &mut order, join, None);
	assert!(broken_pairs(&order.steps, &[pair]).is_empty(), "{notes:?}");
	let moved = 1 + usize::from(tin < join);
	assert_eq!(new_join, join - moved, "the task (and its hand-in) left the own part");
	assert_eq!(order.steps[new_join], st[join], "the tail starts where it did");
	assert_eq!(order.len(), seed.len());
}
