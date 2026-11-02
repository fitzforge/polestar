//! Riding (Main B: the Orc stood in Orgrimmar at 40.0 but learned to ride at 45.5, at v1's line,
//! while the model rode from 40): with a riding trainer for the start, the route profiles ride only
//! after a riding step at it, played at the mount level or above (below it the step does nothing);
//! place_ride puts v1's riding line on the first visit to the trainer at the mount level.

mod common;
use forge_core::Faction;
use forge_sim::profile::Profile;
use forge_sim::route::{model_for, place_ride};
use forge_sim::run::{K_GRIND, K_RIDE};
use forge_sim::seq::{Ev, Event};
use forge_sim::{Params, Step};
use std::sync::Arc;

#[test]
fn the_route_rides_only_after_learning_at_the_trainer() {
	let o = common::orc();
	let seed = o.seed();
	let m0 = o.model(&[]);
	// A trainer at the world point of a stop the order makes at about a third of its length.
	let k = seed.len() / 3;
	let stop = (k..seed.len()).find(|&i| seed.steps[i].kind != K_GRIND).unwrap();
	let wp = m0.run.pt_list[seed.steps[stop].pt as usize];
	let base = Params::effective(common::params_doc().as_ref(), None, &[("mountLevel".into(), 4.0)]);
	let pr = Profile { rides: Some(Arc::new(vec![(4752, wp)])), ..Profile::average(Faction::Horde) };
	let (m, _) = model_for(&o.world, "Orc", &pr, &base, &o.walks).unwrap();
	let (npc, pt) = m.run.riding[0];
	assert_eq!(npc, 4752);
	let ride = Step { kind: K_RIDE, q: 0, task: 4752, pt };
	let mut ev = m.evaluator(&o.walks);
	ev.reset();
	assert!(!ev.step(ride), "below the mount level the trainer teaches nothing");
	for i in 0..seed.len() {
		ev.step_in(&seed.steps, i);
	}
	assert!(!ev.s.mounted, "no riding step: never mounted, past the mount level ({})", ev.level_now());
	assert!(ev.step(ride) && ev.s.mounted, "learned at the trainer");
	// v1's line placed on the first stop at the trainer at the mount level or above.
	let events = vec![Event { t: Ev::Ride, q: None, level: None, xp: None, src: 7, oi: None, npc: Some(4752) }];
	let (placed, note) = place_ride(&m, &o.walks, &seed, &events);
	assert!(note.is_some());
	let at = placed.steps.iter().position(|s| s.kind == K_RIDE).expect("a riding step");
	assert_eq!(placed.origin[at], 7, "v1's line");
	assert!(m.run.straight(placed.steps[at - 1].pt, pt) <= forge_sim::route::RIDE_VISIT_YD);
	let mut e = m.evaluator(&o.walks);
	e.reset();
	for i in 0..at {
		e.step_in(&placed.steps, i);
	}
	assert!(e.level_now() >= 4.0, "at the mount level");
	assert!(e.step(placed.steps[at]) && e.s.mounted);
}
