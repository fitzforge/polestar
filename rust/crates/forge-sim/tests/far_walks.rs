//! A pair the walk store lacks beyond its radius has no straight walk (travel.rs direct_walk): the
//! straight line there may cross a sea or a range (c13 Human: Dustwallow to Feathermoon on Sardor
//! Isle, 5841 yd; Emerald Sanctuary to Everlook, 4299 yd). The leg goes by the network (walks
//! between nodes, rides, known flights), and the pair is listed as a walk miss so the next build's
//! walks stage routes it. Without a store (NoWalks, the gate's model) every leg stays straight.

mod common;
use forge_core::Faction;
use forge_sim::eval::Trace;
use forge_sim::profile::Profile;
use forge_sim::route::model_for;
use forge_sim::run::K_VISIT;
use forge_sim::{Model, NoWalks, Params, Step, Walks};

/// No routed walk, every pair asked within `RADIUS` (a store that answered nothing).
struct Asked;
const RADIUS: f64 = 4000.0;
impl Walks for Asked {
	fn yards(&self, _: u32, _: u32) -> Option<f64> {
		None
	}
	fn radius(&self) -> Option<f64> {
		Some(RADIUS)
	}
}

fn model(walks: &dyn Walks) -> Model {
	let base = Params::effective(common::params_doc().as_ref(), None, &[]);
	model_for(&common::world(Faction::Horde), "Orc", &Profile::average(Faction::Horde), &base, walks).unwrap().0
}

/// Two run points of one region, 4500 to 7000 yd apart: (from, to, straight yards).
fn far_pair(m: &Model) -> (u32, u32, f64) {
	let r = &m.run;
	let n = r.pt_list.len();
	for a in 0..n {
		for b in 0..n {
			let d = (r.p_x[a] - r.p_x[b]).hypot(r.p_y[a] - r.p_y[b]);
			if r.p_r[a] == r.p_r[b] && r.p_c[a] == 1 && (4500.0..7000.0).contains(&d) {
				return (a as u32, b as u32, d);
			}
		}
	}
	panic!("no far pair in the slice");
}

/// The leg from `a` to `b` at level 30: its trace and the misses listed.
fn leg(m: &Model, walks: &dyn Walks, a: u32, b: u32) -> (Vec<Trace>, Vec<(u32, u32)>) {
	let mut ev = m.evaluator(walks);
	ev.trace = Some(Vec::new());
	ev.misses = Some(Vec::new());
	ev.reset();
	ev.s.level = 30;
	ev.s.pos = a;
	ev.s.bind = -1;
	assert!(ev.step(Step { kind: K_VISIT, q: 0, task: -1, pt: b }));
	(ev.trace.take().unwrap().into_iter().map(|x| x.1).collect(), ev.misses.take().unwrap())
}

#[test]
fn a_pair_beyond_the_radius_goes_by_the_network_and_is_asked_next_build() {
	let m = model(&Asked);
	let (a, b, d) = far_pair(&m);
	let (trace, misses) = leg(&m, &Asked, a, b);
	assert!(trace.iter().any(|t| matches!(t, Trace::Network { .. })), "{d:.0} yd beyond the radius: by the network, not straight: {trace:?}");
	assert!(!trace.iter().any(|t| matches!(t, Trace::Walk { .. })), "no straight walk: {trace:?}");
	assert_eq!(misses, vec![(m.run.pt_list[a as usize], m.run.pt_list[b as usize])], "the pair asked next build");
}

#[test]
fn without_a_store_the_far_pair_is_walked_straight() {
	let m = model(&NoWalks);
	let (a, b, d) = far_pair(&m);
	let (trace, _) = leg(&m, &NoWalks, a, b);
	assert!(trace.iter().any(|t| matches!(t, Trace::Walk { .. })), "{d:.0} yd, no store: straight: {trace:?}");
}
