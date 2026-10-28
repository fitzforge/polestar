//! The planner rules from the route benchmark (where other leveling guides beat us), each on the golden Orc
//! slice world: (1) value a chain, not a quest; (2) stay on the continent; (3) grind checkpoints
//! that guard no gate may go; (6) fold a hub return for one hand-in into the next visit.

mod common;
use forge_sim::chain::Goal;
use forge_sim::guards::{low_trip_count, trips};
use forge_sim::hubs::{visits, HubData};
use forge_sim::order::{deliberate_pairs, Order};
use forge_sim::run::{Run, K_ACCEPT, K_GRIND, K_TASK, K_TURNIN};
use forge_sim::search::edits::{chain_insertion, chain_quests, descend, trip_drops, Mv};
use forge_sim::search::passby::hub_batch;
use forge_sim::search::{pool, runs, Member, Problem};
use forge_sim::Step;

fn problem<'a>(o: &'a common::Orc, m: &'a forge_sim::Model, seed: &Order) -> Problem<'a> {
	let r = &m.run;
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	Problem::single(m, &o.walks, deliberate_pairs(r), pool(r, &rules, seed, &m.tables))
}

#[test]
fn a_quest_is_inserted_with_the_quests_it_opens() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let lv = runs(&p, &seed)[0].levels().to_vec();
	let in_seed = |q: u32| seed.steps.iter().any(|s| s.kind == K_ACCEPT && s.q == q);
	// A quest the route does not take that opens another one it does not take either.
	let (q, mv) = p
		.pool
		.iter()
		.filter(|&&q| p.followers[q as usize].iter().any(|&f| !in_seed(f) && p.pool.contains(&f)))
		.find_map(|&q| chain_insertion(&p, &seed, &lv, seed.len(), q).map(|mv| (q, mv)))
		.expect("a chain the route does not take");
	let qs = chain_quests(&mv);
	assert!(qs.len() >= 2 && qs[0] == q, "the quest first, then what it opens: {qs:?}");
	let (after, _, _) = mv.apply(&seed).expect("applies");
	let pos = |k: u8, q: u32| after.steps.iter().position(|s| s.kind == k && s.q == q).unwrap();
	for &f in &qs[1..] {
		let opener = qs.iter().copied().filter(|&x| r.q_pre[f as usize].contains(&x) || r.q_all[f as usize].contains(&x) || r.q_parent[f as usize] == x as i32).min_by_key(|&x| pos(K_TURNIN, x));
		if let Some(x) = opener {
			assert!(pos(K_ACCEPT, f) > pos(K_TURNIN, x), "{} taken after {} is handed in", r.q_id[f as usize], r.q_id[x as usize]);
		}
	}
	assert_eq!(runs(&p, &after)[0].noops, runs(&p, &seed)[0].noops, "every chain step does something");
}

/// RevNightElf3 (c13 Teldrassil): a lead-in's hand-in comes before its follow-up's accept, also where
/// no prerequisite says so (a breadcrumb): the hub loop keeps them in that order. (The golden slice's
/// lead-ins are all prerequisites too: one made a breadcrumb here.)
#[test]
fn a_lead_in_is_handed_in_before_its_follow_up_is_taken() {
	use forge_sim::search::passby::loop_keep;
	let o = common::orc();
	let mut m = o.model(&[]);
	let seed = o.seed();
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let leads = forge_sim::route::lead_in_pairs(&o.world, &rules, &m.run);
	let lead = *leads.first().expect("a quest whose `next` is in the run");
	let b = lead.qb as usize;
	(m.run.q_pre[b], m.run.q_all[b], m.run.q_after[b], m.run.q_parent[b]) = (Vec::new(), Vec::new(), Vec::new(), -1);
	let r = &m.run;
	let (tin, acc) = (Step { kind: K_TURNIN, q: lead.qa, task: -1, pt: r.q_ender[lead.qa as usize] }, Step { kind: K_ACCEPT, q: lead.qb, task: -1, pt: r.q_giver[b] });
	let mut prob = problem(&o, &m, &seed);
	prob.pairs.retain(|p| !(p.qa == lead.qa && p.qb == lead.qb));
	assert!(!loop_keep(&prob, &tin, &acc), "before: the loop was free to swap them");
	prob.pairs.extend(leads.iter().copied());
	assert!(loop_keep(&prob, &tin, &acc), "the lead-in's hand-in stays ahead of the follow-up's accept");
}

/// RevNightElf3 (c13 Shadowglen, route event 28): a training put between two field tasks away from
/// its town splits the field work; it goes to the hub, before or after the stretch.
#[test]
fn a_training_inside_a_field_stretch_goes_to_the_hub() {
	use forge_sim::order::field_trains;
	use forge_sim::run::K_TRAIN;
	use forge_sim::search::passby::trains_out_of_field;
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let st = &seed.steps;
	let away = |i: usize, t: u32| st[i].kind == K_TASK && r.straight(st[i].pt, t) > forge_sim::hubs::HUB_YD;
	// A training, and two tasks in a row away from its town a few steps on.
	let (k, at) = (0..st.len())
		.filter(|&k| st[k].kind == K_TRAIN)
		.find_map(|k| (k + 2..(k + 12).min(st.len())).find(|&j| away(j - 1, st[k].pt) && away(j, st[k].pt)).map(|j| (k, j)))
		.expect("a training with two field tasks soon after it");
	let mut bad = seed.clone();
	let (s, g) = (bad.steps.remove(k), bad.origin.remove(k));
	bad.steps.insert(at - 1, s);
	bad.origin.insert(at - 1, g);
	assert!(field_trains(r, &bad.steps) > field_trains(r, &seed.steps), "the training sits inside the field stretch");
	let mut mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let kept = trains_out_of_field(&p, &mut mem, &mut |l| eprintln!("{l}"));
	assert!(!kept.is_empty(), "moved");
	assert!(field_trains(r, &mem.order.steps) < field_trains(r, &bad.steps), "out of the field stretch");
}

#[test]
fn a_grind_that_guards_no_gate_may_go() {
	let o = common::orc();
	let m = o.model(&[]);
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let low = o.world.quests.iter().find(|q| rules.open.contains_key(&q.id) && q.min_level <= 3.0).expect("a low quest").id;
	let goal = |i: usize, t: &str, step: u32, q: Option<u32>, level: Option<f64>| Goal { i, guide: String::new(), file: "f.guide".into(), line: None, t: t.into(), q, oi: None, level, w: None, npc: None, class: None, step: Some(step), spots: Vec::new() };
	// A level-20 grind before a training (a gate), a level-16 grind before a low quest (none).
	let goals = vec![goal(0, "level", 10, None, Some(20.0)), goal(1, "train", 20, None, None), goal(2, "level", 30, None, Some(16.0)), goal(3, "accept", 40, Some(low), None)];
	let seed = Order { steps: vec![Step::grind(20, 0), Step::grind(16, 0)], origin: vec![0, 2] };
	assert_eq!(forge_sim::route::free_grinds(&o.world, &rules, &goals, &seed), vec![2]);
	let _ = m;
}

/// The golden Orc order with a trip off the continent for `low` (each wholly on the trip) put
/// after step `at`.
fn with_trip(seed: &Order, r: &Run, low: &[u32], at: usize) -> Order {
	let mut o = Order { steps: seed.steps[..=at].to_vec(), origin: seed.origin[..=at].to_vec() };
	for &q in low {
		for s in forge_sim::seq::quest_steps(r, q) {
			o.steps.push(s);
			o.origin.push(forge_sim::order::INSERTED);
		}
	}
	o.steps.extend_from_slice(&seed.steps[at + 1..]);
	o.origin.extend_from_slice(&seed.origin[at + 1..]);
	o
}

#[test]
fn a_trip_off_the_continent_for_low_quests_is_dropped() {
	let o = common::orc();
	let mut m = o.model(&[]);
	// (Without the trainings due: their trips to Razor Hill keep every zone of the slice world in use.)
	let seed = {
		let s = o.seed();
		let keep: Vec<bool> = s.steps.iter().map(|x| !(x.kind == forge_sim::run::K_TRAIN && x.task == forge_sim::order::TRAIN_DUE_TASK)).collect();
		Order { steps: s.steps.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect(), origin: s.origin.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect() }
	};
	let lv = {
		let p = problem(&o, &m, &seed);
		runs(&p, &seed)[0].levels().to_vec()
	};
	// A stop with an on-level quest open (a step of it left after the stop), the latest with a zone
	// the route does not visit after it: that zone stands for another continent (its places moved
	// to continent 999; the slice world is one), with quests the route does not take, each wholly
	// there and four or more levels under the character at the stop.
	let r0 = &m.run;
	let in_seed = |q: u32| seed.steps.iter().any(|s| s.q == q && s.kind == K_ACCEPT);
	let zone_at = |at: usize| -> Option<(u32, Vec<u32>)> {
		let seed_maps: Vec<u32> = seed.steps[at..].iter().filter(|s| s.kind != K_GRIND).map(|s| r0.p_map[s.pt as usize]).collect();
		let done = |q: u32| seed.steps[..=at].iter().any(|s| s.q == q && s.kind == K_TURNIN);
		let open = |q: u32| {
			let qi = q as usize;
			let pre = r0.q_pre[qi].is_empty() || r0.q_pre[qi].iter().any(|&x| done(x));
			!in_seed(q) && pre && r0.q_all[qi].iter().all(|&x| done(x)) && r0.q_parent[qi] < 0 && !r0.q_excl[qi].iter().any(|&x| in_seed(x)) && r0.q_level[qi] as f64 <= lv[at] - 4.0
		};
		let mut by_map: std::collections::BTreeMap<u32, Vec<u32>> = Default::default();
		for q in (0..r0.n_quests() as u32).filter(|&q| open(q)) {
			let st = forge_sim::seq::quest_steps(r0, q);
			let z = r0.p_map[st[0].pt as usize];
			if !seed_maps.contains(&z) && st.iter().all(|s| r0.p_map[s.pt as usize] == z) {
				by_map.entry(z).or_default().push(q);
			}
		}
		by_map.into_iter().max_by_key(|(_, v)| v.len())
	};
	let (at, (zone, qs)) = (1..seed.len() - 1)
		.rev()
		.filter(|&i| {
			lv[i] < 60.0
				&& seed.steps[i].kind != K_GRIND
				&& seed.steps[i + 1].kind != K_GRIND
				&& seed.steps[i + 1..].iter().any(|s| matches!(s.kind, K_TASK | K_TURNIN) && r0.q_level[s.q as usize] as f64 >= lv[i] - 2.0 && seed.steps[..=i].iter().any(|x| x.kind == K_ACCEPT && x.q == s.q))
		})
		.find_map(|i| zone_at(i).map(|z| (i, z)))
		.expect("a stop with an on-level quest open and a zone the route leaves for good, with low quests");
	let low: Vec<u32> = qs.into_iter().take(3).collect();
	for pt in 0..m.run.p_c.len() {
		if m.run.p_map[pt] == zone {
			m.run.p_c[pt] = 999;
		}
	}
	let p = problem(&o, &m, &seed);
	let r = &m.run;
	let bad = with_trip(&seed, r, &low, at);
	let c = &runs(&p, &bad)[0];
	assert_eq!(trips(r, &bad.steps).iter().filter(|t| t.0 == at + 1).count(), 1, "one trip there");
	assert!(low_trip_count(r, &c.steps, c.levels()) >= 1, "a low trip");
	let mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let mv = trip_drops(&p, &mem).into_iter().find(|mv| matches!(mv, Mv::Seq { mvs, .. } if mvs.iter().all(|x| matches!(x, Mv::Drop { q } if low.contains(q))))).expect("the trip's quests dropped together");
	let (after, _, _) = mv.apply(&bad).unwrap();
	let c2 = &runs(&p, &after)[0];
	assert!(low_trip_count(r, &c2.steps, c2.levels()) < low_trip_count(r, &c.steps, c.levels()), "no low trip there after");
	// The trip costs more than its quests give, and the descent takes it out (dropped together, or
	// one at a time when it is one quest).
	assert!(c2.total < c.total, "the drop saves time: {:.0} s -> {:.0} s", c.total, c2.total);
	let d = descend(&p, &bad, 20, 1, false, &mut |_, _, _| {}, None);
	let last = d.orders.last().expect("edits");
	assert!(low.iter().all(|&q| !last.steps.iter().any(|s| s.q == q && s.kind == K_ACCEPT)), "the descent takes the trip out");
}

#[test]
fn a_hub_return_for_one_hand_in_is_folded_into_the_next_visit() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let h = HubData::new(r);
	let (vs, _, _) = visits(&h, r, &seed.steps);
	let lv = runs(&p, &seed)[0].levels().to_vec();
	let far = |i: usize, pt: u32| seed.steps[i].kind != K_GRIND && r.straight(seed.steps[i].pt, pt) > 600.0;
	// A hand-in at a hub visit W (with more there), ready well before W while the route is away:
	// handed in on a return of its own there instead.
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
	let visits_at = |o: &Order| {
		let (vs, of, _) = visits(&h, r, &o.steps);
		let i = o.steps.iter().position(|y| *y == s).unwrap();
		vs.iter().filter(|v| v.hub == vs[of[i]].hub).count()
	};
	let mut mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let kept = hub_batch(&p, &mut mem, &mut |l| eprintln!("{l}"));
	assert!(!kept.is_empty(), "the batch keeps a move");
	assert!(visits_at(&mem.order) < visits_at(&bad), "fewer visits to the hub: {} -> {}", visits_at(&bad), visits_at(&mem.order));
	let now = mem.order.steps.iter().position(|y| *y == s).unwrap();
	let (vs2, of2, _) = visits(&h, r, &mem.order.steps);
	let v = vs2[of2[now]];
	assert!(v.e > v.s, "handed in with the visit's other steps");
}

#[test]
fn a_rank_waits_at_most_four_levels_for_its_training() {
	use forge_sim::run::K_TRAIN;
	let o = common::orc();
	let m = o.model(&[]);
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let lv = runs(&p, &seed)[0].levels().to_vec();
	// The order without its trainings from level 8 on: the ranks wait to the end.
	let keep: Vec<bool> = (0..seed.len()).map(|k| seed.steps[k].kind != K_TRAIN || lv[k] < 8.0).collect();
	let mut bare = Order { steps: seed.steps.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect(), origin: seed.origin.iter().zip(&keep).filter(|x| *x.1).map(|x| *x.0).collect() };
	let trains = |o: &Order| o.steps.iter().filter(|s| s.kind == K_TRAIN).count();
	let before = trains(&bare);
	let old: Vec<i64> = bare.origin.clone();
	let mut ev = m.evaluator(&o.walks);
	forge_sim::order::due_trains(&mut ev, &mut bare);
	assert!(trains(&bare) > before, "a training placed where ranks waited: {before} -> {}", trains(&bare));
	// Each added one teaches (none does nothing) and comes right after a flight master stop.
	let (_, did) = forge_sim::order::play_order(&mut ev, &bare.steps);
	for (k, _) in bare.steps.iter().enumerate().filter(|(k, s)| s.kind == K_TRAIN && !old.contains(&bare.origin[*k])) {
		assert!(did[k], "training {k} teaches");
		let prev = bare.steps[..k].iter().rev().find(|x| x.kind != forge_sim::run::K_GRIND).unwrap();
		assert!(m.run.p_fp[prev.pt as usize] >= 0, "training {k} right after a flight master stop");
	}
}

#[test]
fn early_hard_work_waits_for_its_level_instead_of_a_long_grind() {
	use forge_sim::search::passby::defer_hard_work;
	let o = common::orc();
	// Slow grinding (a fifth of the prior rate), so the model's own grind before early work is long.
	let m = o.model(&[("grindEff".to_string(), 0.15)]);
	let seed = {
		let m0 = o.model(&[]);
		let _ = &m0;
		o.seed()
	};
	let p = problem(&o, &m, &seed);
	let r = &m.run;
	let lv = runs(&p, &seed)[0].levels().to_vec();
	let mut ev = m.evaluator(&o.walks);
	// Minutes of grind over 15 in the blocks of a replay (checkpoints and the model's own).
	let excess = |ev: &mut forge_sim::eval::Evaluator, o: &Order| forge_sim::route::grind_blocks(ev, o)["excessMin"].as_f64().unwrap();
	// Each quest of the order whose chain needs nothing, with kill work, taken with its work at
	// level 4: the first that makes the model grind a long block to it.
	let at = (0..seed.len()).find(|&k| lv[k] >= 4.0 && seed.steps[k].kind != forge_sim::run::K_GRIND).unwrap();
	let mut cands: Vec<u32> = seed.steps.iter().filter(|s| s.kind == K_ACCEPT && r.q_pre[s.q as usize].is_empty() && r.q_all[s.q as usize].is_empty() && r.q_parent[s.q as usize] < 0 && r.q_task0[s.q as usize] < r.q_task1[s.q as usize] && r.q_level[s.q as usize] >= 12).map(|s| s.q).collect();
	cands.sort_by_key(|&q| std::cmp::Reverse(r.q_level[q as usize]));
	let base = excess(&mut ev, &seed);
	let (bad, was) = cands
		.iter()
		.find_map(|&q| {
			let mine = |s: &forge_sim::Step| s.q == q && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN);
			let mut bad = Order { steps: Vec::new(), origin: Vec::new() };
			for k in 0..seed.len() {
				if k == at {
					for (j, s) in seed.steps.iter().enumerate().filter(|(_, s)| mine(s)) {
						bad.steps.push(*s);
						bad.origin.push(seed.origin[j]);
					}
				}
				if !mine(&seed.steps[k]) {
					bad.steps.push(seed.steps[k]);
					bad.origin.push(seed.origin[k]);
				}
			}
			let was = excess(&mut ev, &bad);
			(was > base + 15.0).then_some((bad, was))
		})
		.expect("a quest that, taken at level 4, makes a long grind");
	// The pass prices each long grind's work deferred to its level, and keeps only what lowers the
	// route time plus the weighted grind over 15 minutes (in this slice world, which ends near 16,
	// questing seldom reaches the level, so it may keep nothing: the invariant is what holds).
	let mut mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let mut tried = 0;
	let kept = defer_hard_work(&p, &mut mem, &mut |l| {
		tried += usize::from(l.starts_with("defer hard work"));
		eprintln!("{l}");
	});
	assert!(tried > 0, "the long grinds are tried");
	let cost = |mem: &Member| mem.total() + 60.0 * forge_sim::search::passby::GRIND_EXCESS_WEIGHT * excess(&mut m.evaluator(&o.walks), &mem.order);
	let before = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	assert!(kept.iter().all(|k| k.mv.kind() == "defer hard work"));
	assert!(cost(&mem) <= cost(&before) + 1.0, "never worse by its own price");
	let _ = was;
}

/// Human's cut skipped A Free Lunch, Raven Hill and Philmor's Favor as player reports: the ledger
/// judged each insertion against the keep of a quest (940) the cleaned order no longer had.
#[test]
fn a_passed_quest_is_judged_only_by_the_rules_the_order_holds() {
	use forge_sim::order::{Checker, Feas};
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let in_seed = |q: u32| seed.steps.iter().any(|s| s.kind == K_ACCEPT && s.q == q);
	let gone = (0..r.q_id.len() as u32).find(|&q| !in_seed(q)).unwrap();
	let feas = Feas { keep: vec![gone], ..Default::default() };
	let mut c = Checker::new(r);
	// An order with nothing wrong but the lost keep.
	let why = c.broken(&seed.steps, &[], &feas).expect("the lost keep reads as broken");
	assert!(why.contains("keep"), "{why}");
	assert_eq!(c.broken(&seed.steps, &[], &feas.held_by(&seed.steps)), None);
	// A keep the order holds still counts.
	let held = seed.steps.iter().find(|s| s.kind == K_ACCEPT).unwrap().q;
	let both = Feas { keep: vec![gone, held], ..Default::default() }.held_by(&seed.steps);
	assert_eq!(both.keep, vec![held]);
	let without: Vec<_> = seed.steps.iter().copied().filter(|s| s.q != held).collect();
	assert!(c.broken(&without, &[], &both).is_some());
}

/// Routes are compared with each grinding second counted `grindWeight` times (params.json's policy,
/// lost in the port: c12 Orc ground 30.7 h, 14 blocks over 15 minutes, while quests at 360-470 XP
/// a minute were left as `low-value` against grinding at ~390). Reported hours stay real; a quest
/// slower than grinding but faster than its weighted price is worth keeping.
#[test]
fn grinding_is_priced_at_its_weight_when_routes_are_compared() {
	let o = common::orc();
	let seed = o.seed();
	let price = |w: f64, order: &Order| {
		let m = o.model(&[("grindWeight".to_string(), w)]);
		let p = problem(&o, &m, &seed);
		let cost = runs(&p, order)[0].total;
		let mut ev = m.evaluator(&o.walks);
		let secs = forge_sim::search::evaluate(&mut ev, order);
		(cost, secs, ev.s.grind_sec)
	};
	let (c1, s1, g1) = price(1.0, &seed);
	let (c25, s25, g25) = price(2.5, &seed);
	assert!(g1 > 0.0 && (g1 - g25).abs() < 1e-6 && (s1 - s25).abs() < 1e-6, "the weight changes no replay");
	assert!((c1 - s1).abs() < 1e-6, "weight 1: the cost is the seconds");
	assert!((c25 - (s25 + 1.5 * g25)).abs() < 1e-6, "weight 2.5: {c25} against {s25} + 1.5 x {g25}");
	// A quest of the order that grinding beats in seconds but not at its weighted price: dropping it
	// is faster, and dearer.
	let r = &o.model(&[]).run;
	let drop = |q: u32| {
		let keep: Vec<usize> = (0..seed.len()).filter(|&k| seed.steps[k].q != q || !matches!(seed.steps[k].kind, K_ACCEPT | K_TASK | K_TURNIN)).collect();
		Order { steps: keep.iter().map(|&k| seed.steps[k]).collect(), origin: keep.iter().map(|&k| seed.origin[k]).collect() }
	};
	let quests: Vec<u32> = seed.steps.iter().filter(|s| s.kind == K_ACCEPT && r.q_task0[s.q as usize] < r.q_task1[s.q as usize]).map(|s| s.q).collect();
	let flipped = quests.iter().find(|&&q| {
		let without = drop(q);
		let (cw, sw, _) = price(2.5, &without);
		sw < s25 - 1.0 && cw > c25 + 1.0
	});
	assert!(flipped.is_some(), "a quest worth keeping only once grinding is priced");
}

/// The seed's zone stays: runs of steps on one map (a grind checkpoint is where the step before it was).
fn zone_stays(r: &Run, o: &Order) -> Vec<(usize, usize)> {
	let mut st: Vec<(usize, usize)> = Vec::new();
	let mut here = u32::MAX;
	for (k, s) in o.steps.iter().enumerate() {
		if s.kind != K_GRIND {
			here = r.p_map[s.pt as usize];
		}
		match st.last_mut() {
			Some(x) if x.1 + 1 == k && (s.kind == K_GRIND || r.p_map[o.steps[x.0].pt as usize] == here) => x.1 = k,
			_ => st.push((k, k)),
		}
	}
	st
}

/// A whole zone stay can be moved after the stays that come next, which the 100-yard straight-walk
/// rule for reorders never let any edit do (the route benchmark's 30-40: Desolace at 30.0 and
/// Stranglethorn at 33.5 against 33.2 and 35.3 in a benchmark guide): one `stay later` per place
/// after each following stay, the stay kept whole, and a town stop between not counted against
/// the reach. Whether a move pays is the descent's call.
#[test]
fn a_zone_stay_can_move_whole_after_the_next_stays() {
	use forge_sim::search::edits::{stay_moves, Mv, STAY_LATER, STAY_MIN_STEPS};
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let st = zone_stays(r, &seed);
	let quest = |s: &Step| matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN);
	let mem = Member::new(&p, seed.clone(), &runs(&p, &seed), 0);
	let moves = stay_moves(&p, &mem);
	let b = (0..st.len() - 1).find(|&b| (st[b].0..=st[b].1).filter(|&k| quest(&seed.steps[k])).count() >= STAY_MIN_STEPS).expect("a stay of six or more quest steps with a stay after it");
	let ((s, e), (_, ne)) = (st[b], st[b + 1]);
	let mv = moves
		.iter()
		.find(|mv| matches!(mv, Mv::Move { s: ms, e: me, to, kind } if *ms == s && *me == e && *to == ne + 1 - (e - s + 1) && *kind == STAY_LATER))
		.expect("the stay moved after the next one");
	let (after, _, _) = mv.apply(&seed).unwrap();
	let swapped: Vec<Step> = seed.steps[..s].iter().chain(&seed.steps[e + 1..=ne]).chain(&seed.steps[s..=e]).chain(&seed.steps[ne + 1..]).copied().collect();
	assert_eq!(after.steps, swapped, "the next stay first, then the moved one whole");
	// Small stays (under STAY_MIN_STEPS quest steps) are never moved this way.
	for mv in &moves {
		if let Mv::Move { s, e, kind, .. } = mv {
			if *kind == STAY_LATER {
				assert!((*s..=*e).filter(|&k| quest(&seed.steps[k])).count() >= STAY_MIN_STEPS);
			}
		}
	}
}

/// A zone's quests far under the character where the route does them (Arathi's low half at 38.3 in
/// c12 Orc, done at 31-32 by a benchmark guide) can be done earlier, on level, as their own visit.
#[test]
fn a_zone_s_low_quests_go_earlier_as_their_own_visit() {
	use forge_sim::search::edits::{stay_moves, STAY_SPLIT, STAY_SPLIT_UNDER, UNDER_LEVEL};
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let lv = runs(&p, &seed)[0].levels().to_vec();
	let st = zone_stays(r, &seed);
	let mine = |q: u32, s: &Step| s.q == q && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN);
	// Three quests wholly in one stay, with no prerequisite in it and none opening another there,
	// moved to the start of the first later stay where the character is STAY_SPLIT_UNDER + 1 levels
	// over the highest of them.
	let (low, y) = st
		.iter()
		.find_map(|&(x0, x1)| {
			let qs: Vec<u32> = (x0..=x1)
				.filter(|&k| seed.steps[k].kind == K_ACCEPT)
				.map(|k| seed.steps[k].q)
				.filter(|&q| (0..seed.len()).all(|k| !mine(q, &seed.steps[k]) || (x0..=x1).contains(&k)))
				.filter(|&q| {
					r.q_pre[q as usize].is_empty() && r.q_all[q as usize].is_empty() && r.q_parent[q as usize] < 0 && p.followers[q as usize].iter().all(|&f| !seed.steps.iter().any(|s| s.q == f))
				})
				.take(3)
				.collect();
			let top = qs.iter().map(|&q| r.q_level[q as usize] as f64).fold(0.0, f64::max);
			let y = st.iter().find(|&&(y0, _)| y0 > x1 && lv[y0] >= top + STAY_SPLIT_UNDER + 1.0)?.0;
			(qs.len() == 3).then_some((qs, y))
		})
		.expect("three quests of one stay and a later stay well over them");
	let ks: Vec<usize> = (0..seed.len()).filter(|&k| !low.iter().any(|&q| mine(q, &seed.steps[k]))).collect();
	let moved: Vec<usize> = (0..seed.len()).filter(|&k| low.iter().any(|&q| mine(q, &seed.steps[k]))).collect();
	let mut order: Vec<usize> = Vec::new();
	for &k in &ks {
		if k == y {
			order.extend(&moved);
		}
		order.push(k);
	}
	let bad = Order { steps: order.iter().map(|&k| seed.steps[k]).collect(), origin: order.iter().map(|&k| seed.origin[k]).collect() };
	let mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let blv = runs(&p, &bad)[0].levels().to_vec();
	let splits: Vec<_> = stay_moves(&p, &mem).into_iter().filter(|mv| mv.kind() == STAY_SPLIT).collect();
	let back = splits.iter().find_map(|mv| {
		let (after, _, _) = mv.apply(&bad)?;
		let alv = runs(&p, &after)[0].levels().to_vec();
		let at = |o: &Order, lv: &[f64], q: u32| o.steps.iter().position(|s| s.q == q && s.kind == K_ACCEPT).map(|k| lv[k]).unwrap();
		low.iter().all(|&q| at(&after, &alv, q) < at(&bad, &blv, q) && at(&after, &alv, q) >= r.q_level[q as usize] as f64 - UNDER_LEVEL).then_some(after)
	});
	assert!(back.is_some(), "the low quests done earlier, on level ({} split candidates)", splits.len());
	assert_eq!(back.unwrap().len(), bad.len());
}

/// A breadcrumb is handed in before its follow-up is taken at the same NPC (RevA2: 2872/2873 and
/// 3763/3764 were taken the other way round; taking the follow-up first closes the breadcrumb).
#[test]
fn a_breadcrumb_is_handed_in_before_its_follow_up_is_taken() {
	use forge_sim::order::breadcrumbs_first;
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let (b, f) = o
		.world
		.quests
		.iter()
		.filter(|w| w.breadcrumb)
		.filter_map(|w| Some((r.q(w.id)?, r.q(w.next? as u32)?)))
		.find(|&(b, f)| r.straight(r.q_ender[b as usize], r.q_giver[f as usize]) <= forge_sim::order::SAME_STOP_YD)
		.expect("a breadcrumb ending at its follow-up's giver");
	let at = |k: u8, q: u32, pt: u32| Step { kind: k, q, task: -1, pt };
	let x = r.q_giver[f as usize];
	let order = Order { steps: vec![at(K_ACCEPT, b, r.q_giver[b as usize]), at(K_ACCEPT, f, x), at(K_TURNIN, b, r.q_ender[b as usize])], origin: vec![0, 1, 2] };
	let out = breadcrumbs_first(r, &[(b, f)], &order);
	assert_eq!(out.steps.iter().map(|s| (s.kind, s.q)).collect::<Vec<_>>(), vec![(K_ACCEPT, b), (K_TURNIN, b), (K_ACCEPT, f)]);
	assert_eq!(out.origin, vec![0, 2, 1]);
	// Elsewhere (the follow-up taken at another stop), the order stays.
	let far = Order { steps: vec![order.steps[0], at(K_ACCEPT, f, r.q_giver[b as usize]), order.steps[2]], origin: vec![0, 1, 2] };
	if r.straight(r.q_giver[b as usize], r.q_ender[b as usize]) > forge_sim::order::SAME_STOP_YD {
		assert_eq!(breadcrumbs_first(r, &[(b, f)], &far).origin, vec![0, 1, 2]);
	}
}

/// An accept taken under its minimum level (the model lets it through gateGap levels early and
/// grinds there silently; the game refuses it) gets a written level step right before it, however
/// short the grind (RevH2: 4971 at 52.75, minimum 53).
#[test]
fn an_accept_under_its_minimum_level_gets_a_written_gate() {
	use forge_sim::search::passby::grind_topups;
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let lv = runs(&p, &seed)[0].levels().to_vec();
	// A quest's accept moved back to a stop where the character is under its minimum level by
	// less than a level (and no grind of the order's own is between).
	let bad = (0..seed.len())
		.filter(|&a| seed.steps[a].kind == K_ACCEPT && r.q_min_level[seed.steps[a].q as usize] >= 4)
		.find_map(|a| {
			let ml = f64::from(r.q_min_level[seed.steps[a].q as usize]);
			let k = (1..a).rev().find(|&k| lv[k] < ml && lv[k] > ml - 1.0 && seed.steps[k - 1].kind != K_GRIND)?;
			if seed.steps[k..a].iter().any(|s| s.kind == K_GRIND) {
				return None;
			}
			let mut o2 = seed.clone();
			let (s, g) = (o2.steps.remove(a), o2.origin.remove(a));
			o2.steps.insert(k, s);
			o2.origin.insert(k, g);
			(runs(&p, &o2)[0].noops <= runs(&p, &seed)[0].noops).then_some((o2, s.q))
		})
		.expect("an accept that can be taken a little under its minimum level");
	let (bad, q) = bad;
	let mut mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let kept = grind_topups(&p, &mut mem, &mut |_| {});
	assert!(!kept.is_empty(), "the silent grind is written");
	let k = mem.order.steps.iter().position(|s| s.kind == K_ACCEPT && s.q == q).unwrap();
	assert_eq!(mem.order.steps[k - 1].kind, K_GRIND, "a level step right before the accept");
	assert!(f64::from(mem.order.steps[k - 1].q) + 1.0 > f64::from(r.q_min_level[q as usize]), "to its minimum level");
}

/// A long checkpoint's top-ups go where no hand-in waits (the #617 guard): c14 Human's Un'Goro
/// 49.5-51 (488 min) and Burning Steppes 51-52 (293 min) grinds stayed whole because every split put a
/// piece right after a camp whose quest was handed in a few steps on, which the guard refused.
#[test]
fn a_long_grind_is_split_after_the_hand_ins_that_wait() {
	use forge_sim::guards::{grind_before_handin, handin_waits};
	use forge_sim::search::passby::grind_topups;
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let after = |steps: &[Step]| {
		let mut ev = m.evaluator(&o.walks);
		ev.reset();
		steps
			.iter()
			.map(|&s| {
				if !ev.s.finished {
					ev.step(s);
				}
				ev.level_now()
			})
			.collect::<Vec<f64>>()
	};
	let lv = after(&seed.steps);
	let at = |k: usize| seed.steps[..=k].iter().rev().find(|s| s.kind != K_GRIND).map(|s| s.pt);
	let mut tried = 0;
	for e in 2..seed.len() {
		if seed.steps[e - 1].kind == K_GRIND || lv[e - 1] >= 56.0 {
			continue;
		}
		let Some(here) = at(e - 1) else { continue };
		let map = r.p_map[here as usize];
		// The stay's camps, one of them with a hand-in waiting a few steps on.
		let lo = (0..e).rev().take_while(|&k| at(k).is_some_and(|x| r.p_map[x as usize] == map)).last().unwrap_or(e);
		let camps: Vec<usize> = (lo..e).filter(|&k| seed.steps[k].kind == K_TASK).collect();
		let waits = camps.iter().any(|&c| {
			let mut last = vec![-1i64; r.n_quests()];
			for (k, s) in seed.steps[..=c].iter().enumerate() {
				if s.kind == K_TASK {
					last[s.q as usize] = k as i64;
				}
			}
			handin_waits(r, &seed.steps, c + 1, seed.steps[c].pt, &last)
		});
		if camps.len() < 3 || !waits || seed.steps[lo..e].iter().any(|s| s.kind == K_GRIND) {
			continue;
		}
		let mut long = seed.clone();
		long.steps.insert(e, Step::grind(lv[e - 1].floor() as u32 + 2, 0));
		long.origin.insert(e, -1);
		let base = grind_before_handin(r, &long.steps, &after(&long.steps));
		let mut mem = Member::new(&p, long.clone(), &runs(&p, &long), 0);
		grind_topups(&p, &mut mem, &mut |_| {});
		let pieces = |o: &Order| o.steps[lo..].iter().take(e + 40 - lo).filter(|s| s.kind == K_GRIND).count();
		tried += 1;
		if pieces(&mem.order) <= pieces(&long) {
			assert!(tried < 30, "no long grind split in 30 stays");
			continue;
		}
		assert!(grind_before_handin(r, &mem.order.steps, &after(&mem.order.steps)) <= base, "no top-up on the trip of a hand-in that waits (stay at {lo}..{e})");
		return;
	}
	panic!("no stay with camps and a waiting hand-in split");
}

/// A gate checkpoint moves to just before the first accept it gates (RevA2: Feralas' level-45 grind
/// before Shay's escort and the Feathermoon hand-ins).
#[test]
fn a_gate_waits_until_just_before_the_accept_it_gates() {
	use forge_sim::search::edits::{gate_moves, Mv, GATE_LATER};
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let lv = runs(&p, &seed)[0].levels().to_vec();
	// A gate put at a step under the minimum level of the first accept after it that needs more
	// than the level there (two or more steps on, none of them a training or a grind).
	let (bad, i, a) = (1..seed.len())
		.filter(|&i| seed.steps[i].kind != K_GRIND && seed.steps[i - 1].kind != K_GRIND)
		.find_map(|i| {
			let a = (i + 1..seed.len()).find(|&j| seed.steps[j].kind == K_ACCEPT && f64::from(r.q_min_level[seed.steps[j].q as usize]) > lv[i])?;
			let ml = r.q_min_level[seed.steps[a].q as usize];
			if i + 2 > a || ml < 2 || seed.steps[i..a].iter().any(|s| matches!(s.kind, K_GRIND | forge_sim::run::K_TRAIN)) {
				return None;
			}
			let mut o2 = seed.clone();
			o2.steps.insert(i, Step::grind(ml as u32, 0));
			o2.origin.insert(i, -1);
			Some((o2, i, a + 1))
		})
		.expect("an accept with steps under its minimum level before it");
	let mem = Member::new(&p, bad.clone(), &runs(&p, &bad), 0);
	let mv = gate_moves(&p, &mem).into_iter().find(|mv| matches!(mv, Mv::Move { s, .. } if *s == i)).expect("the gate moved");
	assert_eq!(mv.kind(), GATE_LATER);
	let (after, _, _) = mv.apply(&bad).unwrap();
	assert_eq!(after.steps[a - 1].kind, K_GRIND, "right before the accept it gates");
	assert_eq!(after.steps[a].q, bad.steps[a].q);
}

/// A quest whose work or hand-in is in a zone the route comes back to only after INSERT_REACH steps
/// is inserted with them on that later visit, not refused (c13 Orc: Pawn Captures Queen, Goblin
/// Invaders, Return to the Bulwark were `zone-left`, "not reached soon after", though all fit that later visit).
#[test]
fn a_quest_is_inserted_with_its_hand_in_on_the_next_visit_to_its_zone() {
	use forge_sim::search::edits::{insertion_in, Mv, INSERT_REACH};
	use forge_sim::search::locs;
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let lv0 = runs(&p, &seed)[0].levels().to_vec();
	let mine = |q: u32, s: &Step| s.q == q && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN);
	// A quest of the order with a later step on another map than its giver's, taken out; it inserts.
	let found = seed.steps.iter().filter(|s| s.kind == K_ACCEPT).map(|s| s.q).find_map(|q| {
		let gm = r.p_map[r.q_giver[q as usize] as usize];
		let st = forge_sim::seq::quest_steps(r, q);
		let far = st[1..].iter().map(|s| r.p_map[s.pt as usize]).find(|&mm| mm != gm)?;
		let keep: Vec<usize> = (0..seed.len()).filter(|&k| !mine(q, &seed.steps[k])).collect();
		let o1 = Order { steps: keep.iter().map(|&k| seed.steps[k]).collect(), origin: keep.iter().map(|&k| seed.origin[k]).collect() };
		let lv1: Vec<f64> = keep.iter().map(|&k| lv0[k]).collect();
		let Some(Mv::Insert { at, .. }) = insertion_in(&p, &o1, &lv1, q, &locs(r, &o1.steps), o1.len(), 0) else { return None };
		let acc = at[0].0;
		// Filler: a place on the giver's continent off both maps.
		let c = r.p_c[r.q_giver[q as usize] as usize];
		let other = (0..r.p_map.len() as u32).find(|&pt| r.p_c[pt as usize] == c && r.p_map[pt as usize] != gm && r.p_map[pt as usize] != far)?;
		(r.p_map[o1.steps[acc].pt as usize] == gm && o1.steps[acc..].iter().any(|s| s.kind != K_GRIND && r.p_map[s.pt as usize] == far)).then_some((q, o1, lv1, acc, other, far))
	});
	let (q, o1, lv1, acc, other, far) = found.expect("a quest of the order with work or hand-in in another zone");
	// 2 x INSERT_REACH steps off both maps right after the stop where its accept goes; only that
	// stop's level opens it (the others at 60, past its window).
	let filler = Step { kind: K_ACCEPT, q: 0, task: -1, pt: other };
	let n = 2 * INSERT_REACH;
	let mut o2 = o1.clone();
	for _ in 0..n {
		o2.steps.insert(acc + 1, filler);
		o2.origin.insert(acc + 1, -1);
	}
	let lv2: Vec<f64> = (0..o2.len()).map(|k| if k == acc { lv1[acc] } else { 60.0 }).collect();
	let mv = insertion_in(&p, &o2, &lv2, q, &locs(r, &o2.steps), o2.len(), 0).expect("inserted, its later steps on the next visit");
	let Mv::Insert { at, .. } = mv else { panic!("an insert") };
	assert_eq!(at[0].0, acc, "taken where it is passed");
	for &(j, s) in &at[1..] {
		if r.p_map[s.pt as usize] == far {
			assert!(j > acc + n, "{} on the visit after the filler, not before ({j})", r.q_id[q as usize]);
		}
	}
}

/// An insertion takes the cheapest pass of the giver from which its later steps can follow, not the
/// cheapest pass outright: c13 Orc's Goblin Invaders was `zone-left` because its cheapest pass (26.9)
/// came after the route's only Stonetalon visit, where its work is; the 23.5 pass works.
#[test]
fn an_insertion_skips_passes_after_its_work_s_last_visit() {
	use forge_sim::search::edits::{insertion_in, Mv};
	use forge_sim::search::locs;
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let lv0 = runs(&p, &seed)[0].levels().to_vec();
	let mine = |q: u32, s: &Step| s.q == q && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN);
	let straight = |a: u32, b: u32| r.straight(a, b);
	// A quest of the order with a later step on another map than its giver's, taken out; its
	// insertion's accept costs a detour. A stop at its giver appended at the end (no detour, the
	// level as at that accept) is cheaper, and no later step can follow there.
	let found = seed.steps.iter().filter(|s| s.kind == K_ACCEPT).map(|s| s.q).find_map(|q| {
		let g = r.q_giver[q as usize];
		let gm = r.p_map[g as usize];
		let st = forge_sim::seq::quest_steps(r, q);
		st[1..].iter().find(|s| r.p_map[s.pt as usize] != gm)?;
		let keep: Vec<usize> = (0..seed.len()).filter(|&k| !mine(q, &seed.steps[k])).collect();
		let o1 = Order { steps: keep.iter().map(|&k| seed.steps[k]).collect(), origin: keep.iter().map(|&k| seed.origin[k]).collect() };
		let lv1: Vec<f64> = keep.iter().map(|&k| lv0[k]).collect();
		let loc = locs(r, &o1.steps);
		let Some(Mv::Insert { at, .. }) = insertion_in(&p, &o1, &lv1, q, &loc, o1.len(), 0) else { return None };
		let acc = at[0].0;
		let detour = straight(loc[acc - 1], g) + straight(g, loc[acc]) - straight(loc[acc - 1], loc[acc]);
		(detour > 1.0).then_some((q, o1, lv1, acc))
	});
	let (q, mut o2, mut lv2, acc) = found.expect("a quest of the order, its work elsewhere, taken at a detour");
	let g = r.q_giver[q as usize];
	o2.steps.push(Step { kind: K_ACCEPT, q: 0, task: -1, pt: g });
	o2.origin.push(-1);
	lv2.push(lv2[acc]);
	let mv = insertion_in(&p, &o2, &lv2, q, &locs(r, &o2.steps), o2.len(), 0).expect("inserted at the pass its later steps can follow");
	let Mv::Insert { at, .. } = mv else { panic!("an insert") };
	assert_eq!(at[0].0, acc, "the earlier pass, not the end");
}

/// A hub visited again at the level its quests open (c13 Orc: Ratchet passed only at 29.6-30.3,
/// the Shimmering Flats chains at 36-37 left `level`): after the route's stop nearest the giver at
/// that level, the route goes to the giver and takes two or more of its quests (with what they
/// open), none of them before that stop, nothing left doing nothing, the visit's own stop gone.
#[test]
fn a_hub_is_visited_again_at_the_level_its_quests_open() {
	use forge_sim::search::edits::{revisit_moves, revisit_quests, Mv, REVISIT_MIN_QUESTS};
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p0 = problem(&o, &m, &seed);
	let base = runs(&p0, &seed)[0].noops;
	let mem0 = Member::new(&p0, seed.clone(), &runs(&p0, &seed), 0);
	let mvs = revisit_moves(&p0, &mem0);
	let mv = mvs.into_iter().next().expect("a hub the route passes only out of its quests' window");
	let qs = revisit_quests(&mv);
	assert!(qs.len() >= REVISIT_MIN_QUESTS, "{qs:?}");
	let Mv::Seq { mvs: parts, .. } = &mv else { panic!("a sequence") };
	let Mv::Insert { at, .. } = &parts[0] else { panic!("the visit first") };
	let j = at[0].0;
	let (after, _, _) = mv.apply(&seed).unwrap();
	assert!(!after.steps.iter().any(|s| s.kind == forge_sim::run::K_VISIT), "the visit's stop goes");
	for &q in &qs {
		let a = after.steps.iter().position(|s| s.kind == K_ACCEPT && s.q == q).unwrap();
		assert!(a >= j, "{} taken after the stop", r.q_id[q as usize]);
	}
	assert!(runs(&p0, &after)[0].noops <= base, "nothing left doing nothing");
}

/// A quest whose prerequisite the order never hands in is never inserted: it would do nothing (a
/// hub revisit took The Rumormonger without Parts for Kravel, 23 steps doing nothing).
#[test]
fn a_quest_whose_chain_the_order_does_not_take_is_never_inserted() {
	use forge_sim::search::edits::insertion_in;
	use forge_sim::search::locs;
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let p = problem(&o, &m, &seed);
	let lv0 = runs(&p, &seed)[0].levels().to_vec();
	let mine = |q: u32, s: &Step| s.q == q && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN);
	// A follow-up of the order and its only prerequisite, both taken out: the follow-up inserts with
	// the prerequisite in the order, never without it.
	let (f, pre) = seed
		.steps
		.iter()
		.filter(|s| s.kind == K_ACCEPT && r.q_pre[s.q as usize].len() == 1 && r.q_all[s.q as usize].is_empty())
		.map(|s| (s.q, r.q_pre[s.q as usize][0]))
		.find(|&(f, pre)| {
			let keep: Vec<usize> = (0..seed.len()).filter(|&k| !mine(f, &seed.steps[k])).collect();
			let o1 = Order { steps: keep.iter().map(|&k| seed.steps[k]).collect(), origin: keep.iter().map(|&k| seed.origin[k]).collect() };
			let lv1: Vec<f64> = keep.iter().map(|&k| lv0[k]).collect();
			seed.steps.iter().any(|s| s.kind == K_TURNIN && s.q == pre) && insertion_in(&p, &o1, &lv1, f, &locs(r, &o1.steps), o1.len(), 0).is_some()
		})
		.expect("a follow-up that inserts after its prerequisite");
	let keep: Vec<usize> = (0..seed.len()).filter(|&k| !mine(f, &seed.steps[k]) && !mine(pre, &seed.steps[k])).collect();
	let o2 = Order { steps: keep.iter().map(|&k| seed.steps[k]).collect(), origin: keep.iter().map(|&k| seed.origin[k]).collect() };
	let lv2: Vec<f64> = keep.iter().map(|&k| lv0[k]).collect();
	for nth in 0..3 {
		assert!(insertion_in(&p, &o2, &lv2, f, &locs(r, &o2.steps), o2.len(), nth).is_none(), "{} inserted without {}", r.q_id[f as usize], r.q_id[pre as usize]);
	}
}
