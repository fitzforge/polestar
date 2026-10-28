//! The route profiles hearth where the route chooses too (CriticHorde, c9: long flights taken with
//! the hearthstone ready): with the stone ready and a bind set, a leg the hearth beats by
//! FREE_HEARTH_GAIN_SEC is a hearth, not only at v1's hearth lines.

mod common;
use forge_core::Faction;
use forge_sim::profile::Profile;
use forge_sim::route::model_for;
use forge_sim::run::{TravelPlan, K_ACCEPT};
use forge_sim::{Params, Step};
use std::sync::Arc;

#[test]
fn a_far_leg_home_is_a_hearth() {
	let o = common::orc();
	let base = Params::effective(common::params_doc().as_ref(), None, &[]);
	let pr = Profile { plan: Some(Arc::new(TravelPlan::default())), ..Profile::average(Faction::Horde) };
	let (m, _) = model_for(&o.world, "Orc", &pr, &base, &o.walks).unwrap();
	let r = &m.run;
	// A quest giver beside an inn, and a point far from it on the same continent.
	let (q, inn) = (0..r.n_quests())
		.find_map(|q| (0..r.inn_pt.len()).find(|&i| r.straight(r.q_giver[q], r.inn_pt[i]) <= 100.0).map(|i| (q as u32, i)))
		.expect("a giver at an inn");
	let far = (0..r.pt_list.len() as u32).filter(|&p| r.straight(p, r.inn_pt[inn]).is_finite()).max_by(|&a, &b| r.straight(a, r.inn_pt[inn]).total_cmp(&r.straight(b, r.inn_pt[inn]))).unwrap();
	let mut ev = m.evaluator(&o.walks);
	ev.reset();
	ev.s.level = 20;
	ev.s.pos = far;
	ev.s.bind = inn as i32;
	let t0 = ev.s.time;
	assert!(ev.step(Step { kind: K_ACCEPT, q, task: r.q_accept[q as usize], pt: r.q_giver[q as usize] }));
	assert_eq!(ev.s.hearths, 1, "hearthed home ({:.0} s, {:.0} yd)", ev.s.time - t0, r.straight(far, r.inn_pt[inn]));
}
