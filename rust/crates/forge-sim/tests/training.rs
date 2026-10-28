//! Class trainings by rank (RevHumanStart and every start-zone review, c10): a training teaches the
//! ranks between the last one trained and the level (ranks at 1, 4, 6, 8, 10...; every class
//! trainer teaches every rank, a starting valley's too). One with nothing to teach does nothing: Northshire at 3.06, a
//! second Goldshire training at 9.73. The seed keeps none such and adds a stop where a trainer town
//! has a new rank.

mod common;
use forge_sim::order::play_order;
use forge_sim::run::K_TRAIN;
use forge_sim::Step;

#[test]
fn a_training_teaches_only_new_ranks() {
	let o = common::orc();
	let mut m = o.model(&[]);
	// (The golden slice world has no training table: the full world's, every class: 1, 4, 6, 8...)
	m.run.train_ranks = std::iter::once(4).chain((6..=60).step_by(2)).collect();
	let r = &m.run;
	let town = *r.towns.iter().find(|t| !r.valley_towns.contains(t)).expect("a town");
	let mut ev = m.evaluator(&o.walks);
	ev.reset();
	ev.s.level = 3;
	assert_eq!(ev.teaches_at(town), None, "no rank between 1 and 3");
	ev.s.level = 9;
	assert_eq!(ev.teaches_at(town), Some(8));
	// Every class trainer teaches every rank (Fitz, in game): a starting valley's too.
	ev.s.level = 16;
	let valley = *r.valley_towns.first().expect("Orc's own valley");
	assert_eq!(ev.teaches_at(valley), Some(16), "a valley trainer teaches a level-16 rank");
	ev.s.level = 9;
	let t = Step { kind: K_TRAIN, q: 0, task: -1, pt: town };
	assert!(ev.step(t), "ranks 4 to 8");
	assert!(!ev.step(t), "the same visit again: nothing to learn");
	ev.s.level = 10;
	assert!(ev.step(t), "rank 10");
}

#[test]
fn the_seed_trains_only_where_a_rank_is_new() {
	let o = common::orc();
	let m = o.model(&[]);
	let seed = o.seed();
	let mut ev = m.evaluator(&o.walks);
	let (_, did) = play_order(&mut ev, &seed.steps);
	let n = seed.steps.iter().filter(|s| s.kind == K_TRAIN).count();
	assert!(n > 0);
	assert!(seed.steps.iter().zip(&did).all(|(s, &d)| s.kind != K_TRAIN || d), "every training teaches something");
}

#[test]
fn the_ranks_come_from_the_world_s_training_table() {
	let o = common::orc();
	let mut w = o.world.clone();
	w.training = serde_json::json!({ "WARRIOR": { "1": 10, "4": 200, "6": 300 }, "MAGE": { "1": 10, "4": 100, "8": 400 } });
	let base = forge_sim::Params::effective(common::params_doc().as_ref(), None, &[]);
	let (m, _) = forge_sim::route::model_for(&w, "Orc", &forge_sim::profile::Profile::average(forge_core::Faction::Horde), &base, &o.walks).unwrap();
	assert_eq!(m.run.train_ranks, vec![4, 6, 8], "every class's levels above 1");
}

#[test]
fn a_v1_training_is_held_at_its_class_quests_level() {
	// RevA1 (c10): Human's v1 training moved to 9.73 took the Tome of Divinity (2998, 12) with it.
	use forge_sim::chain::goals_from;
	use forge_sim::seq::Ev;
	let o = common::orc();
	let q = o.world.quests.iter().find(|q| q.min_level >= 8.0).expect("a quest of level 8 or more");
	let goals = goals_from(&serde_json::json!({ "goals": [
		{ "i": 0, "file": "a.guide", "step": 10, "t": "train", "class": true },
		{ "i": 1, "file": "a.guide", "step": 10, "t": "accept", "q": q.id },
		{ "i": 2, "file": "a.guide", "step": 20, "t": "train", "class": true },
	] }));
	let events: Vec<_> = goals.iter().filter_map(forge_sim::chain::goal_event).collect();
	let held = forge_sim::route::train_floors(&o.world, &goals, &events);
	assert_eq!(held[0].t, Ev::Train);
	assert_eq!(held[0].level, Some(q.min_level), "held at its step's quest's level");
	assert_eq!(held[2].level, None, "a step with no quest: not held");
	// In the model: below that level the training does nothing.
	let m = o.model(&[]);
	let town = m.run.towns[0];
	let mut ev = m.evaluator(&o.walks);
	ev.reset();
	ev.s.level = q.min_level as usize - 1;
	assert!(!ev.step(Step { kind: K_TRAIN, q: 0, task: q.min_level as i32, pt: town }));
	ev.s.level = q.min_level as usize;
	assert!(ev.step(Step { kind: K_TRAIN, q: 0, task: q.min_level as i32, pt: town }));
}

#[test]
fn a_town_without_a_class_s_trainer_costs_its_share_of_the_trip() {
	// RevTroll (c10): Razor Hill has no Mage trainer, so an Orc Mage walks to Sen'jin each time.
	use forge_sim::profile::town_gaps;
	let o = common::orc();
	let mut w = o.world.clone();
	let classes: Vec<String> = w.classes.iter().find(|(r, _)| r == "Orc").unwrap().1.as_array().unwrap().iter().map(|c| c.as_str().unwrap().to_uppercase()).collect();
	// One hub with every Orc class, then the same hub without Mage and a Mage hub 500 yd east.
	let h = w.hubs.iter().position(|h| !w.starts.iter().any(|(_, s)| w.points[s.pt as usize].region == w.points[h.pt as usize].region && (w.points[s.pt as usize].wx - w.points[h.pt as usize].wx).hypot(w.points[s.pt as usize].wy - w.points[h.pt as usize].wy) < 400.0)).unwrap();
	let t = w.hubs[h].pt;
	w.hubs[h].trainers = classes.clone();
	assert_eq!(town_gaps(&w, "Orc", &[t]), vec![0.0], "every class trained there");
	w.hubs[h].trainers = classes.iter().filter(|c| *c != "MAGE").cloned().collect();
	w.hubs.retain(|x| x.pt == t || !x.trainers.iter().any(|c| c == "MAGE"));
	let mut p = w.points[t as usize].clone();
	p.wx += 2000.0;
	w.points.push(p);
	let mage = w.points.len() as u32 - 1;
	let mut hub = w.hubs[h].clone();
	hub.pt = mage;
	hub.trainers = vec!["MAGE".into()];
	w.hubs.push(hub);
	let g = town_gaps(&w, "Orc", &[t])[0];
	assert!((g - 2.0 * 2000.0 / classes.len() as f64).abs() < 1e-6, "the Mage's share of a round trip: {g}");
	assert_eq!(town_gaps(&w, "Nobody", &[t]), vec![0.0]);
}

#[test]
fn a_class_with_no_trainer_in_the_town_s_region_is_priced_by_the_trip_to_a_town_that_trains_it() {
	// c14, Human: Darnassus has no Paladin, Mage or Warlock trainer, and Teldrassil none either, so
	// town_gaps priced those classes at nothing and the route flew from Felwood to Darnassus to train.
	use forge_sim::profile::{town_away, town_gaps, town_points};
	let o = common::orc();
	let mut w = o.world.clone();
	// Orgrimmar's hall with every Orc class; the Mage trainers only in a town on another island.
	let h = w.hubs.iter().position(|h| h.trainers.len() >= 6 && h.trainers.iter().any(|c| c == "MAGE")).expect("a hall with a Mage trainer");
	for x in w.hubs.iter_mut() {
		x.trainers.retain(|c| c != "MAGE");
	}
	let mut p = w.points[w.hubs[h].pt as usize].clone();
	p.region += 1000;
	w.points.push(p);
	let far = w.points.len() as u32 - 1;
	let mut hub = w.hubs[h].clone();
	hub.pt = far;
	hub.trainers = ["MAGE", "WARRIOR", "ROGUE", "HUNTER"].map(String::from).to_vec();
	w.hubs.push(hub);
	let (towns, _) = town_points(&w, None);
	assert!(towns.contains(&far), "the island's hall is a town");
	// Every other town (Orgrimmar, Razor Hill) has no Mage trainer in its region: town_gaps has no
	// straight trip to price, town_away sends the Mage to the island's town.
	let away = town_away(&w, "Orc", &towns);
	let gaps = town_gaps(&w, "Orc", &towns);
	let k = towns.iter().position(|&t| t == far).unwrap();
	assert!(towns.len() > 1);
	for (j, &t) in towns.iter().enumerate().filter(|&(j, _)| j != k) {
		assert!(away[j].contains(&vec![far]), "town {t}: {:?}", away[j]);
		assert!(gaps[j].is_finite());
	}
	assert!(away[k].iter().all(|v| !v.contains(&far)), "not the town itself");
}

#[test]
fn a_training_costs_the_away_classes_their_share_of_the_round_trip() {
	let o = common::orc();
	let mut m = o.model(&[]);
	m.run.train_ranks = std::iter::once(4).chain((6..=60).step_by(2)).collect();
	let r = &m.run;
	let a = *r.towns.iter().find(|t| !r.valley_towns.contains(t)).expect("a town");
	let b = *r.towns.iter().find(|&&t| r.straight(t, a) > 1000.0).expect("a town apart");
	let ka = r.towns.iter().position(|&t| t == a).unwrap();
	let n = r.towns.len();
	m.run.town_gap_yd = vec![0.0; n];
	m.run.town_away = vec![Vec::new(); n];
	m.run.town_away[ka] = vec![vec![b]];
	m.run.town_away_share = 0.25;
	let mut ev = m.evaluator(&o.walks);
	ev.reset();
	ev.s.level = 9;
	ev.s.pos = a;
	let round = ev.leg_now(a, b) + ev.leg_now(b, a);
	assert!(round.is_finite() && round > 0.0);
	assert!((ev.train_price(a) - round / 4.0).abs() < 1e-9, "the price a placement weighs");
	let t0 = ev.s.time;
	assert!(ev.step(Step { kind: K_TRAIN, q: 0, task: -1, pt: a }));
	assert!((ev.s.c.train_away_sec - round / 4.0).abs() < 1e-9, "a quarter of the round trip: {}", ev.s.c.train_away_sec);
	assert!(ev.s.time - t0 >= round / 4.0);
	// A town every class trains at costs nothing more.
	ev.s.level = 12;
	ev.s.pos = b;
	let before = ev.s.c.train_away_sec;
	assert!(ev.step(Step { kind: K_TRAIN, q: 0, task: -1, pt: b }));
	assert_eq!(ev.s.c.train_away_sec, before);
}
