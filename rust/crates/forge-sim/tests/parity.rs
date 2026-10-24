//! Parity of the evaluator with the JS v1 evaluator (tools/lib/sim/evaluate.js): v1's default chain
//! (the committed guide slice, walked by the JS judge) replayed event by event, per-goal level and
//! time, hours to 30 and 60 and steps compared. References: rust/tests/golden/sim (made by its
//! regen.js on the golden slice world and params.json; see its README), walks off.

mod common;
use forge_core::Faction;
use forge_sim::chain::{compare_reference, events_from, replay_events};
use forge_sim::{compile_run, Model, NoWalks, Params};
use forge_world::Rules;

fn case(f: Faction, race: &str) {
	let w = common::world(f);
	let doc = common::seed_doc(f, race);
	let walks = NoWalks;
	let rules = Rules::new(&w, race, None, false);
	let run = compile_run(&w, &rules, race, None, &[]).unwrap();
	let model = Model::new(run, &Params::effective(common::params_doc().as_ref(), None, &[]), &walks);
	let events = events_from(&doc);
	let mut ev = model.evaluator(&walks);
	let rep = replay_events(&mut ev, &model.run, &events);
	let c = compare_reference(&doc, &events, &rep);
	eprintln!("{f} {race}: {:.4} h (js {:.4}), to 30 {:.4} (js {:.4}), {} compared, max Δlevel {:.1e}, max Δt {:.4} s", c.hours60, c.js_hours60, c.to30, c.js_to30, c.compared, c.max_dlevel, c.max_dt);
	assert!(c.compared > 0, "{f} {race}: no event compared");
	assert_eq!(c.first, None, "{f} {race}: first differing event");
	assert!((c.hours60 - c.js_hours60).abs() < 1e-6, "{f} {race}: hours to 60");
	assert_eq!(ev.s.steps as u64, doc["atEnd"]["steps"].as_u64().unwrap(), "{f} {race}: steps done");
}

#[test]
fn parity_horde_orc() {
	case(Faction::Horde, "Orc");
}

#[test]
fn parity_alliance_human() {
	case(Faction::Alliance, "Human");
}
