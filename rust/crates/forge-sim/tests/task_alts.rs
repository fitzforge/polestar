//! A task's other places (the world's task `alts`): a buy is made at a vendor the route stands at on
//! the way (c13: Soothing Spices 1218 flown for to the Crossroads after the Dustwallow accept, where v1
//! buys them in Ratchet on the way in), and an object's site is the one by other work (RevTauren3: the
//! Well Stones at Winterhoof, where Rite of Vision's totem is used, not at Thunderhorn).

mod common;
use forge_sim::run::{K_ACCEPT, K_TASK, W_BUY, W_USE};

/// The seconds the step at `i` of the seed takes, played in order.
fn step_secs(m: &forge_sim::Model, o: &common::Orc, steps: &[forge_sim::Step], i: usize) -> f64 {
	let mut ev = m.evaluator(&o.walks);
	ev.reset();
	for k in 0..i {
		ev.step_in(steps, k);
	}
	let t0 = ev.s.time;
	ev.step_in(steps, i);
	ev.s.time - t0
}

#[test]
fn a_buy_is_made_at_a_vendor_the_route_stands_at_before_the_accept() {
	let o = common::orc();
	let mut m = o.model(&[]);
	let mut seed = o.seed();
	let r = &m.run;
	let st = &seed.steps;
	// A task played after its accept (made a buy: the golden slice has none after its accept), its
	// vendor put 500-2000 yd from the giver (another quest's giver there), so going there is a trip.
	let (i, t, giver, far) = (0..st.len())
		.filter(|&i| st[i].kind == K_TASK && st[i].task >= 0 && r.task_w1[st[i].task as usize] > r.task_w0[st[i].task as usize])
		.find_map(|i| {
			let (t, q) = (st[i].task as usize, st[i].q);
			st[..i].iter().any(|s| s.kind == K_ACCEPT && s.q == q).then_some(())?;
			let g = r.q_giver[q as usize];
			let far = r.q_giver.iter().copied().find(|&p| (500.0..2000.0).contains(&r.straight(p, g)))?;
			Some((i, t, g, far))
		})
		.expect("a task after its accept");
	for w in m.run.task_w0[t]..m.run.task_w1[t] {
		m.run.w_kind[w as usize] = W_BUY;
	}
	m.run.task_pt[t] = far;
	seed.steps[i].pt = far;
	m.run.index_buys();
	let st = &seed.steps;
	let before = step_secs(&m, &o, st, i);
	// Its giver's place a vendor too: the accept there buys it.
	m.run.task_alts[t] = vec![giver];
	m.run.index_buys();
	let after = step_secs(&m, &o, st, i);
	assert!(before > 0.0, "the trip to its vendor costs time: {before:.0} s");
	assert!(after < before && after <= m.tables.p.talk_sec + 1e-6, "bought on the way or at the giver's vendor: {before:.0} s -> {after:.0} s");
}

#[test]
fn an_object_site_by_other_work_is_taken() {
	let o = common::orc();
	let mut m = o.model(&[]);
	let r = &m.run;
	let near_other = |t: usize, p: u32| (0..r.task_pt.len()).any(|x| x != t && r.t_quest[x] != r.t_quest[t] && r.p_map[r.task_pt[x] as usize] == r.p_map[p as usize] && r.straight(r.task_pt[x], p) <= forge_sim::route::CO_SITE_YD);
	let use_only = |t: usize| r.task_w1[t] > r.task_w0[t] && (r.task_w0[t]..r.task_w1[t]).all(|w| r.w_kind[w as usize] == W_USE);
	// An object task with no other quest's work by its site, and another quest's task in its zone.
	let (t, p) = (0..r.task_pt.len())
		.filter(|&t| r.t_quest[t] >= 0 && use_only(t) && !near_other(t, r.task_pt[t]))
		.find_map(|t| (0..r.task_pt.len()).find(|&x| r.t_quest[x] >= 0 && r.t_quest[x] != r.t_quest[t] && r.p_map[r.task_pt[x] as usize] == r.p_map[r.task_pt[t] as usize] && r.straight(r.task_pt[x], r.task_pt[t]) > 300.0).map(|x| (t, r.task_pt[x])))
		.expect("an object task alone at its site and another task in its zone");
	let was = m.run.task_pt[t];
	m.run.task_alts[t] = vec![p];
	forge_sim::route::co_sited_tasks(&mut m.run);
	assert_eq!(m.run.task_pt[t], p, "the site by the other quest's work");
	assert_eq!(m.run.task_alts[t], vec![was], "the old site an alternative");
}
