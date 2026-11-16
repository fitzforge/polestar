//! Timed quests in the route profiles (0.4.0, after Apothecary Zamah ran out on
//! the Barrens route): a hand-in counts as late (Scalars::late, which no kept move adds to) once
//! TIMED_SHARE (60%) of the quest's limit has gone, not 100%: the model's times are a fast player's.
//! A delivery (a limit and no tasks: Run::q_delivery) flies and sails as any leg does; only the other
//! timed quests are walked while they run.

mod common;
use forge_core::Faction;
use forge_sim::eval::TIMED_SHARE;
use forge_sim::profile::Profile;
use forge_sim::route::model_for;
use forge_sim::run::{TravelPlan, K_ACCEPT, K_TURNIN};
use forge_sim::{Model, Params, Step};
use std::sync::Arc;

fn route_model(o: &common::Orc) -> Model {
	let base = Params::effective(common::params_doc().as_ref(), None, &[]);
	let pr = Profile { plan: Some(Arc::new(TravelPlan::default())), ..Profile::average(Faction::Horde) };
	let (m, _) = model_for(&o.world, "Orc", &pr, &base, &o.walks).unwrap();
	assert!(m.tables.p.feasible, "a route profile");
	m
}

/// Quests with no tasks, no prerequisites and no lead-in to wait for: taken and handed in alone.
fn bare(m: &Model) -> Vec<usize> {
	let r = &m.run;
	(0..r.n_quests()).filter(|&q| r.q_task0[q] == r.q_task1[q] && r.q_pre[q].is_empty() && r.q_all[q].is_empty() && r.q_after[q].is_empty() && r.q_parent[q] < 0 && r.q_accept[q] >= 0).collect()
}

/// Takes quest q at its giver, waits `wait` seconds standing at its ender, hands it in: -> late.
fn late_after(m: &Model, o: &common::Orc, q: usize, wait: f64) -> u32 {
	let r = &m.run;
	let mut ev = m.evaluator(&o.walks);
	ev.reset();
	ev.s.level = 40;
	assert!(ev.step(Step { kind: K_ACCEPT, q: q as u32, task: r.q_accept[q], pt: r.q_giver[q] }), "quest {q} taken");
	ev.s.pos = r.q_ender[q];
	ev.s.time += wait;
	assert!(ev.step(Step { kind: K_TURNIN, q: q as u32, task: -1, pt: r.q_ender[q] }), "quest {q} handed in");
	ev.s.late
}

#[test]
fn a_timed_hand_in_is_late_past_sixty_percent_of_its_limit() {
	let o = common::orc();
	let mut m = route_model(&o);
	let q = *bare(&m).first().expect("a bare quest");
	m.run.q_limit[q] = 1000.0;
	m.run.q_delivery[q] = true;
	let talk = m.tables.p.talk_sec;
	assert_eq!(TIMED_SHARE, 0.6);
	assert_eq!(late_after(&m, &o, q, 500.0), 0, "half the limit: in time");
	assert_eq!(late_after(&m, &o, q, 700.0 - talk), 1, "70% of the limit: late, though the clock has not run out");
	m.run.q_limit[q] = 0.0;
	m.run.q_delivery[q] = false;
	assert_eq!(late_after(&m, &o, q, 5000.0), 0, "an untimed quest is never late");
}

#[test]
fn a_delivery_travels_as_an_untimed_quest_while_other_timed_quests_hold_the_legs_to_walking() {
	let o = common::orc();
	let mut m = route_model(&o);
	// The bare quests whose ender is far from the giver (the golden slice worlds know no flight paths at
	// the start, so the travel compared is what the model would plan: the walk-only hold is the rule).
	let mut seen = 0;
	for q in bare(&m) {
		let r = &m.run;
		if r.straight(r.q_giver[q], r.q_ender[q]) < 1500.0 {
			continue;
		}
		let run_leg = |m: &Model| {
			let r = &m.run;
			let mut ev = m.evaluator(&o.walks);
			ev.reset();
			ev.s.level = 40;
			assert!(ev.step(Step { kind: K_ACCEPT, q: q as u32, task: r.q_accept[q], pt: r.q_giver[q] }));
			let held = (ev.s.timed_active, ev.s.timed_until > ev.s.time);
			let t0 = ev.s.time;
			assert!(ev.step(Step { kind: K_TURNIN, q: q as u32, task: -1, pt: r.q_ender[q] }));
			(held, ev.s.flights, ev.s.time - t0, ev.s.timed_active)
		};
		m.run.q_limit[q] = 1.0e6;
		m.run.q_delivery[q] = false;
		let (held, walked_flights, _, after) = run_leg(&m);
		assert_eq!(held, (1, true), "quest {q}: a timed quest with work holds the legs to walking");
		assert_eq!((walked_flights, after), (0, 0), "quest {q}: walked, and released at its hand-in");
		m.run.q_delivery[q] = true;
		let (held, flown_flights, flown, after) = run_leg(&m);
		assert_eq!((held, after), ((0, false), 0), "quest {q}: a delivery holds nothing");
		m.run.q_limit[q] = 0.0;
		m.run.q_delivery[q] = false;
		let (_, free_flights, free, _) = run_leg(&m);
		assert_eq!((flown_flights, flown), (free_flights, free), "quest {q}: a delivery travels as an untimed quest");
		seen += 1;
	}
	assert!(seen > 0, "a bare quest with a far ender in the golden world");
}
