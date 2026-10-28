//! Join: a quest taken on a later visit to its giver although it was open on an earlier one is
//! offered on the earlier visit (its steps kept in order, every other step kept), its objectives
//! beside other work on the same ground (a player review: "Ratchet gives 2 quests while 5 others
//! are available you could do while doing those 2").

mod common;
use forge_sim::order::deliberate_pairs;
use forge_sim::run::{K_ACCEPT, K_TASK, K_TURNIN};
use forge_sim::search::edits::{joins, Mv, JOIN_YD};
use forge_sim::search::{pool, runs, Member, Problem};

#[test]
fn a_quest_taken_on_a_later_visit_is_offered_on_the_earlier_one() {
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, deliberate_pairs(r), pool(r, &rules, &seed, &m.tables));
	let mem = Member::new(&p, seed.clone(), &runs(&p, &seed), 0);
	let js = joins(&p, &mem);
	let Some(Mv::Join { q, at }) = js.first().cloned() else { panic!("no join on v1's Orc order") };
	let (after, _, _) = Mv::Join { q, at: at.clone() }.apply(&seed).expect("applies");
	assert_eq!(after.len(), seed.len());
	let mut a: Vec<_> = after.steps.iter().map(|s| (s.kind, s.q, s.task)).collect();
	let mut b: Vec<_> = seed.steps.iter().map(|s| (s.kind, s.q, s.task)).collect();
	a.sort_unstable();
	b.sort_unstable();
	assert_eq!(a, b, "the same steps");
	let pos = |o: &forge_sim::order::Order, k: u8| o.steps.iter().position(|s| s.q == q && s.kind == k).unwrap();
	let (was, now) = (pos(&seed, K_ACCEPT), pos(&after, K_ACCEPT));
	assert!(now < was, "taken earlier: {now} vs {was}");
	let giver = seed.steps[was].pt;
	let prev = after.steps[..now].iter().rev().find(|s| s.kind != forge_sim::run::K_GRIND).unwrap();
	assert!(r.straight(prev.pt, giver) <= JOIN_YD, "right after a stop at its giver");
	let k = |s: &forge_sim::Step| [K_ACCEPT, K_TASK, K_TURNIN].iter().position(|&x| x == s.kind);
	let ranks: Vec<usize> = after.steps.iter().filter(|s| s.q == q).filter_map(k).collect();
	assert!(ranks.windows(2).all(|w| w[0] <= w[1]), "accept, work, turn-in in order: {ranks:?}");
}

#[test]
fn a_quest_from_the_bags_is_handed_in_at_its_accept() {
	// The cloth donations (7820-7822): accepted in Thunder Bluff at 55, the cloth in the bags, and
	// handed in on a dedicated trip there at 57.
	let o = common::orc();
	let mut m = o.model(&[]);
	let seed = o.seed();
	let st = seed.steps.clone();
	let r = &m.run;
	let near = |a: u32, b: u32| r.straight(a, b) <= JOIN_YD;
	let pos = |k: u8, q: u32| st.iter().position(|s| s.kind == k && s.q == q);
	// A quest with work, handed in where it was taken, steps between its accept and its work.
	let (q, tasks) = (0..st.len())
		.filter(|&i| st[i].kind == K_ACCEPT)
		.find_map(|i| {
			let q = st[i].q;
			let t = pos(K_TASK, q)?;
			(t > i + 1 && near(r.q_ender[q as usize], st[i].pt)).then(|| (q, (r.q_task0[q as usize]..r.q_task1[q as usize]).collect::<Vec<u32>>()))
		})
		.expect("a quest handed in at its giver");
	for &t in &tasks {
		m.run.task_bag[t as usize] = true;
	}
	let r = &m.run;
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, deliberate_pairs(r), pool(r, &rules, &seed, &m.tables));
	let mem = Member::new(&p, seed.clone(), &runs(&p, &seed), 0);
	let mv = joins(&p, &mem).into_iter().find(|x| matches!(x, Mv::Join { q: x, at } if *x == q && at.len() > 1 && at[1].0 == at[0].0 + 1)).expect("its work and hand-in right after its accept");
	let (after, _, _) = mv.apply(&seed).unwrap();
	let a = after.steps.iter().position(|s| s.q == q && s.kind == K_ACCEPT).unwrap();
	assert!(after.steps[a + 1..].iter().take_while(|s| s.q == q).any(|s| s.kind == K_TURNIN), "handed in right after");
}

/// FlowDiag fix 5 (c13: Runecloth 7826 accepted at 1788, handed in at 1803): after the search, a
/// quest from the bags still split is taken, done and handed in at once, a tie within BAG_TIE_SEC.
#[test]
fn the_bag_tie_pass_hands_a_quest_from_the_bags_in_at_its_accept() {
	use forge_sim::search::passby::{bag_ties, BAG_TIE_SEC};
	let o = common::orc();
	let mut m = o.model(&[]);
	let seed = o.seed();
	let st = seed.steps.clone();
	let r = &m.run;
	let near = |a: u32, b: u32| r.straight(a, b) <= JOIN_YD;
	let pos = |k: u8, q: u32| st.iter().position(|s| s.kind == k && s.q == q);
	// Quests with work, handed in where they were taken, steps between the accept and the work.
	let cands: Vec<(u32, Vec<u32>)> = (0..st.len())
		.filter(|&i| st[i].kind == K_ACCEPT)
		.filter_map(|i| {
			let q = st[i].q;
			let t = pos(K_TASK, q)?;
			(t > i + 1 && near(r.q_ender[q as usize], st[i].pt)).then(|| (q, (r.q_task0[q as usize]..r.q_task1[q as usize]).collect::<Vec<u32>>()))
		})
		.collect();
	assert!(!cands.is_empty(), "a quest handed in at its giver");
	for (_, tasks) in &cands {
		for &t in tasks {
			m.run.task_bag[t as usize] = true;
		}
	}
	let r = &m.run;
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, deliberate_pairs(r), pool(r, &rules, &seed, &m.tables));
	let mut mem = Member::new(&p, seed.clone(), &runs(&p, &seed), 0);
	let ties = bag_ties(&p, &mut mem, &mut |l| eprintln!("{l}"));
	assert!(!ties.is_empty(), "a quest from the bags handed in at its accept");
	for pk in &ties {
		assert!(pk.added <= BAG_TIE_SEC + 1e-6, "a tie: {:+.1} s", pk.added);
		let Mv::Join { q, .. } = pk.mv else { panic!("a join") };
		let a = mem.order.steps.iter().position(|s| s.q == q && s.kind == K_ACCEPT).unwrap();
		assert!(mem.order.steps[a + 1..].iter().take_while(|s| s.q == q).any(|s| s.kind == K_TURNIN), "{}: handed in right after its accept", r.q_id[q as usize]);
	}
}

#[test]
fn the_hub_pickup_pass_takes_open_quests_on_the_earlier_visit_within_its_allowance() {
	use forge_sim::search::passby::{hub_pickup, HUB_PICKUP_ALLOW_SEC};
	let o = common::orc();
	let m = o.model(&[]);
	let r = &m.run;
	let seed = o.seed();
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, deliberate_pairs(r), pool(r, &rules, &seed, &m.tables));
	let mut mem = Member::new(&p, seed.clone(), &runs(&p, &seed), 0);
	let picks = hub_pickup(&p, &mut mem, &mut |_| {});
	assert!(!picks.is_empty(), "v1's Orc order leaves an open quest for a later visit");
	for pk in &picks {
		assert!(pk.added <= HUB_PICKUP_ALLOW_SEC + 1e-6, "within the allowance: {}", pk.added);
		let Mv::Join { q, .. } = pk.mv else { panic!("a join") };
		let acc = |o: &forge_sim::order::Order| o.steps.iter().position(|s| s.q == q && s.kind == K_ACCEPT).unwrap();
		assert!(acc(&mem.order) < acc(&seed), "taken earlier");
	}
}

#[test]
fn a_camp_worked_in_two_halves_is_worked_in_one_go() {
	// c10 split camps (63 places): Redridge Goulash, then Guard Parker, then the Everstill Bridge
	// objective on the same ground. Made here: two objectives whose sites lie 200-280 yd apart but
	// whose spawn spots meet (the check's `merge`: spots within 150 yd), an NPC stop near them put
	// between; the gather pass joins them by their spots, and keeps the NPC step.
	use forge_sim::run::K_GRIND;
	use forge_sim::search::passby::{camp_gather, camp_gathers};
	let o = common::orc();
	let mut m = o.model(&[]);
	let seed = o.seed();
	let st = seed.steps.clone();
	let (i, j, k) = {
		let r = &m.run;
		let site = |i: usize| r.task_pt[st[i].task as usize];
		(0..st.len())
			.filter(|&i| st[i].kind == K_TASK)
			.find_map(|i| {
				let j = (i + 1..st.len().min(i + 30)).find(|&j| st[j].kind == K_TASK && st[j].q != st[i].q && (200.0..280.0).contains(&r.straight(site(i), site(j))) && st[..i].iter().any(|s| s.kind == K_ACCEPT && s.q == st[j].q))?;
				let k = (j + 1..st.len().min(j + 40)).find(|&k| st[k].kind != K_GRIND && st[k].kind != K_TASK && st[k].q != st[i].q && st[k].q != st[j].q && r.straight(st[k].pt, site(i)) <= 250.0)?;
				Some((i, j, k))
			})
			.expect("two objectives 200-280 yd apart and a stop beside them")
	};
	let (a, b) = (st[i], st[j]);
	// The order: i, the stop, j (the steps between i and j moved after j).
	let mut split = seed.clone();
	let x = split.steps.remove(k);
	let g = split.origin.remove(k);
	split.steps.insert(i + 1, x);
	split.origin.insert(i + 1, g);
	// (After the stop's insert, step j is at j + 1.)
	let block: Vec<_> = (i + 2..=j + 1).collect();
	let moved: Vec<(forge_sim::Step, i64)> = block.iter().map(|&b| (split.steps[b], split.origin[b])).collect();
	for &b in block.iter().rev() {
		split.steps.remove(b);
		split.origin.remove(b);
	}
	let (sj, gj) = *moved.last().unwrap();
	assert_eq!(sj, b);
	split.steps.insert(i + 2, sj);
	split.origin.insert(i + 2, gj);
	for (n, (s2, g2)) in moved[..moved.len() - 1].iter().enumerate() {
		split.steps.insert(i + 3 + n, *s2);
		split.origin.insert(i + 3 + n, *g2);
	}
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let count = |m: &forge_sim::Model| {
		let p = Problem::single(m, &o.walks, deliberate_pairs(&m.run), pool(&m.run, &rules, &split, &m.tables));
		let mem = Member::new(&p, split.clone(), &runs(&p, &split), 0);
		// (Only this camp's: v1's order has other split camps of its own.)
		let (ia, ib) = (split.steps.iter().position(|y| *y == a).unwrap(), split.steps.iter().position(|y| *y == b).unwrap());
		camp_gathers(&p, &mem).iter().filter(|mv| matches!(**mv, Mv::Move { s, to, .. } if (s == ib && to == ia + 1) || (s == ia && to == ib - 1))).count()
	};
	assert_eq!(count(&m), 0, "by their sites, 200+ yd apart: not one camp");
	// Their spawn spots meet: b has a spot 60 yd from a's site.
	let pa = m.run.task_pt[a.task as usize] as usize;
	let spot = (m.run.p_c[pa], m.run.p_x[pa] + 60.0, m.run.p_y[pa]);
	m.run.task_spots = vec![Vec::new(); m.run.task_pt.len()];
	let pb = m.run.task_pt[b.task as usize] as usize;
	m.run.task_spots[b.task as usize] = vec![spot, (m.run.p_c[pb], m.run.p_x[pb], m.run.p_y[pb])];
	assert!(count(&m) > 0, "by their spawn spots: one camp");
	let p = Problem::single(&m, &o.walks, deliberate_pairs(&m.run), pool(&m.run, &rules, &split, &m.tables));
	let mut mem = Member::new(&p, split.clone(), &runs(&p, &split), 0);
	let kept = camp_gather(&p, &mut mem, &mut |_| {});
	assert!(!kept.is_empty(), "joined");
	let pos = |s: forge_sim::Step| mem.order.steps.iter().position(|y| *y == s).unwrap();
	let between: Vec<_> = mem.order.steps[pos(a).min(pos(b)) + 1..pos(a).max(pos(b))].to_vec();
	// (Only the camp's work between them: another objective the pass gathered there too.)
	assert!(between.iter().all(|s| s.kind == K_GRIND || s.kind == K_TASK), "the camp's objectives together: {between:?}");
	assert!(!between.contains(&x), "the NPC step before or after the camp");
	assert!(mem.order.steps.contains(&x), "the step between kept");
}

#[test]
fn every_camp_gather_leaves_fewer_split_camps() {
	// c11: Book Return moved between steps 87 and 93 of Human's order 199 times each way (joining
	// it to one camp split it from the next); the steps between drifted and Deliver Thomas'
	// Report and Unrequited Love fell out of their chains. Made here: objectives a, b, c in a row
	// on ground where a~b and b~c are one camp but a~c not, a stop x between a and b.
	use forge_sim::run::K_GRIND;
	use forge_sim::search::passby::{camp_gather, camp_gathers};
	let o = common::orc();
	let mut m = o.model(&[]);
	let seed = o.seed();
	let st = &seed.steps;
	let open_at = |q: u32, i: usize| st[..i].iter().any(|s| s.kind == K_ACCEPT && s.q == q);
	// A task a; two later tasks b, c of quests open at a; a later accept x: moved into a, x, b, c.
	let (ia, ib, ic, ix) = (0..st.len())
		.filter(|&i| st[i].kind == K_TASK)
		.find_map(|i| {
			let later: Vec<usize> = (i + 1..st.len().min(i + 60)).filter(|&j| st[j].kind == K_TASK && st[j].q != st[i].q && open_at(st[j].q, i)).collect();
			let ib = *later.first()?;
			let ic = *later.iter().find(|&&j| st[j].q != st[ib].q)?;
			let ix = (i + 1..st.len().min(i + 60)).find(|&j| st[j].kind == K_ACCEPT && ![st[i].q, st[ib].q, st[ic].q].contains(&st[j].q))?;
			Some((i, ib, ic, ix))
		})
		.expect("a task, two later open tasks and a later accept");
	let mut made = seed.clone();
	let mut take = |k: usize, made: &mut forge_sim::order::Order| (made.steps[k], made.origin[k]);
	let moved: Vec<(forge_sim::Step, i64)> = [ix, ib, ic].iter().map(|&k| take(k, &mut made)).collect();
	let mut del = vec![ix, ib, ic];
	del.sort_unstable();
	for &k in del.iter().rev() {
		made.steps.remove(k);
		made.origin.remove(k);
	}
	for (n, (s2, g2)) in moved.into_iter().enumerate() {
		made.steps.insert(ia + 1 + n, s2);
		made.origin.insert(ia + 1 + n, g2);
	}
	let seed = made;
	let st = &seed.steps;
	let i = ia;
	let (a, x, b, c) = (st[i], st[i + 1], st[i + 2], st[i + 3]);
	let r = &m.run;
	let px = x.pt as usize;
	let at = |dx: f64| (r.p_c[px], r.p_x[px] + dx, r.p_y[px]);
	let mut spots = vec![Vec::new(); r.task_pt.len()];
	spots[a.task as usize] = vec![at(0.0)];
	spots[b.task as usize] = vec![at(100.0)];
	spots[c.task as usize] = vec![at(200.0)];
	m.run.task_spots = spots;
	let rules = forge_world::Rules::new(&o.world, "Orc", None, false);
	let p = Problem::single(&m, &o.walks, deliberate_pairs(&m.run), pool(&m.run, &rules, &seed, &m.tables));
	let mut mem = Member::new(&p, seed.clone(), &runs(&p, &seed), 0);
	let kept = camp_gather(&p, &mut mem, &mut |_| {});
	let splits = |ord: &forge_sim::order::Order| {
		let q = Member::new(&p, ord.clone(), &runs(&p, ord), 0);
		camp_gathers(&p, &q).len()
	};
	for k in &kept {
		let after = k.mv.apply(&k.before).unwrap().0;
		assert!(splits(&after) < splits(&k.before), "a kept move leaves fewer split camps: {:?}", k.mv);
	}
	assert!(kept.iter().any(|k| k.before.steps.contains(&a) && k.before.steps.contains(&c)), "the made-up camp is worked on");
	let _ = (b, c);
}
