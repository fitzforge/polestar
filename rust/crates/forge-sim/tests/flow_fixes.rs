//! The written guides' check fed back to the route (forge_sim::flow, FlowDiag fixes 4 and 10): a
//! finding the planner's straight-line counts cannot see becomes a move on the order, and a hub
//! batch the check finds walked past is undone; and a whole hub visit within a level of the next one
//! is folded into it (RevA2-3: Stormwind at 58.6 and again at 59.4).

mod common;
use forge_sim::flow::Finding;
use forge_sim::guards::hub_counts;
use forge_sim::hubs::{visits, HubData};
use forge_sim::order::{deliberate_pairs, Order};
use forge_sim::run::{K_ACCEPT, K_GRIND, K_TASK, K_TURNIN};
use forge_sim::search::edits::Mv;
use forge_sim::search::passby::{flow_fixes, hub_batch, hub_sweep, BATCH_STEPS};
use forge_sim::search::{pool, runs, Member, Problem};
use forge_sim::Step;

fn problem<'a>(o: &'a common::Orc, m: &'a forge_sim::Model, seed: &Order) -> Problem<'a> {
	let r = &m.run;
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	Problem::single(m, &o.walks, deliberate_pairs(r), pool(r, &rules, seed, &m.tables))
}

fn finding(lines: Vec<(u8, u32)>, after: Option<(u8, u32)>) -> Finding {
	Finding { start: "Orc".into(), rule: "walked-past".into(), text: "test".into(), lines, after, before: None }
}

/// A ready hand-in the written guide walks past at a stop the planner's straight lines do not see:
/// the hub sweep leaves it, the check's finding hands it in at that stop.
#[test]
fn a_written_walked_past_the_planner_cannot_see_is_handed_in_at_the_passing_stop() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let h = HubData::new(r);
	let c = &runs(&p, &seed)[0];
	let mut fixes = Vec::new();
	hub_counts(&h, r, &c.steps, c.levels(), c.walked(), Some(&mut fixes));
	let st = &seed.steps;
	let unique = |x: &Step| st.iter().filter(|y| y.kind == x.kind && y.q == x.q).count() == 1;
	// A hand-in, ready well before it, the planner seeing nothing of it; a quest stop a few steps
	// earlier (after it is ready, nothing of its quest or its follow-ups between) a short walk from its
	// ender, outside the planner's hub and passing reach (the written walk passes there).
	let cands: Vec<(usize, usize)> = (0..st.len())
		.filter(|&j| st[j].kind == K_TURNIN && unique(&st[j]) && !fixes.iter().any(|f| f.step() == j))
		.filter_map(|j| {
			let s = st[j];
			let ready = st[..j].iter().rposition(|x| x.q == s.q && matches!(x.kind, K_ACCEPT | K_TASK))?;
			let follows = |x: &Step| x.q == s.q || (x.kind == K_ACCEPT && (r.q_pre[x.q as usize].contains(&s.q) || r.q_all[x.q as usize].contains(&s.q)));
			let a = (ready + 1..j.saturating_sub(2)).rev().find(|&a| matches!(st[a].kind, K_ACCEPT | K_TURNIN) && unique(&st[a]) && (130.0..=250.0).contains(&r.straight(st[a].pt, s.pt)))?;
			(!st[a + 1..j].iter().any(follows)).then_some((j, a))
		})
		.collect();
	assert!(!cands.is_empty(), "a hand-in whose ender stands a short walk from an earlier stop after it is ready");
	let pos = |o: &Order, x: Step| o.steps.iter().position(|y| *y == x).unwrap();
	let mut sweep = Member::new(&p, seed.clone(), &runs(&p, &seed), 0);
	hub_sweep(&p, &mut sweep, &mut |l| eprintln!("{l}"));
	// The first the order can take there (its rules, guards and allowance).
	let done = cands.iter().find_map(|&(j, a)| {
		let (s, by) = (st[j], st[a]);
		let mut mem = Member::new(&p, seed.clone(), &runs(&p, &seed), 0);
		let kept = flow_fixes(&p, &mut mem, &[finding(vec![(K_TURNIN, r.q_id[s.q as usize])], Some((by.kind, r.q_id[by.q as usize])))], &[], &mut |l| eprintln!("{l}"));
		(!kept.is_empty()).then_some((s, by, mem.order))
	});
	let (s, by, order) = done.expect("a finding the order takes");
	assert_eq!(pos(&order, s), pos(&order, by) + 1, "handed in right after the passing stop");
	assert_ne!(pos(&sweep.order, s), pos(&sweep.order, by) + 1, "the planner's own sweep does not see it");
}

/// The hub return of route_rules' hub batch test, folded by hub_batch; the written check names its
/// hand-in (walked past after the batch): back where it was.
#[test]
fn a_hub_batch_the_written_check_finds_walked_past_is_undone() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let h = HubData::new(r);
	let (vs, _, _) = visits(&h, r, &seed.steps);
	let lv = runs(&p, &seed)[0].levels().to_vec();
	let far = |i: usize, pt: u32| seed.steps[i].kind != K_GRIND && r.straight(seed.steps[i].pt, pt) > 600.0;
	let (t, x) = vs
		.iter()
		.filter(|w| w.e > w.s)
		.find_map(|w| {
			(w.s..=w.e).filter(|&t| seed.steps[t].kind == K_TURNIN).find_map(|t| {
				let s = seed.steps[t];
				let ready = seed.steps[..t].iter().rposition(|x| x.q == s.q && matches!(x.kind, K_ACCEPT | K_TASK))?;
				let follows = |x: &Step| x.kind == K_ACCEPT && (r.q_pre[x.q as usize].contains(&s.q) || r.q_all[x.q as usize].contains(&s.q));
				let x = (ready + 2..w.s).find(|&x| far(x - 1, s.pt) && far(x, s.pt) && lv[x] >= lv[t] - 1.0)?;
				(!seed.steps[x..t].iter().any(follows)).then_some((t, x))
			})
		})
		.expect("a hand-in that can be made a return of its own");
	let mut bad = seed.clone();
	let (s, g) = (bad.steps.remove(t), bad.origin.remove(t));
	bad.steps.insert(x, s);
	bad.origin.insert(x, g);
	let mut mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let batches = hub_batch(&p, &mut mem, &mut |l| eprintln!("{l}"));
	let pos = |o: &Order, y: Step| o.steps.iter().position(|z| *z == y).unwrap();
	// The batch that folded it, and the step it followed then.
	let pk = batches.iter().find(|pk| matches!(pk.mv, Mv::Move { s: a, e, .. } if pk.before.steps[a..=e].contains(&s))).expect("the batch folds the return");
	let at = pos(&pk.before, s);
	let prev = *pk.before.steps[..at].iter().rev().find(|y| y.kind != K_GRIND).unwrap();
	assert_ne!(pos(&mem.order, s), pos(&mem.order, prev) + 1, "folded away from its return");
	let kept = flow_fixes(&p, &mut mem, &[finding(vec![(K_TURNIN, r.q_id[s.q as usize])], None)], &batches, &mut |l| eprintln!("{l}"));
	assert!(kept.iter().any(|pk| matches!(pk.mv, Mv::Move { kind: "hub batch undone", .. })), "the batch undone");
	assert_eq!(pos(&mem.order, s), pos(&mem.order, prev) + 1, "back after the step it followed");
}

/// A whole hub visit (more than BATCH_STEPS stops) whose next visit to the hub comes within a level
/// is folded into it.
#[test]
fn a_whole_hub_visit_within_a_level_of_the_next_is_folded_into_it() {
	let o = common::orc();
	let m = o.model(&[]);
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let mut mem = Member::new(&p, seed.clone(), &runs(&p, &seed), 0);
	let kept = hub_batch(&p, &mut mem, &mut |l| eprintln!("{l}"));
	assert!(
		kept.iter().any(|pk| matches!(pk.mv, Mv::Move { s, e, .. } if e + 1 - s > BATCH_STEPS)),
		"a visit of more than {BATCH_STEPS} stops folded: {:?}",
		kept.iter().map(|pk| &pk.mv).collect::<Vec<_>>()
	);
}
