//! A quest started by a rare drop is never added by the search (c7 hybrid inserted The Collector,
//! 123: its Gold Pickup Schedule drops 86 % from Gruff Swiftbite, a rare mob, and 2-3 % from the
//! Riverpaw gnolls): neither when v1 marks it optional (route-fixes `deliberate.optional`) nor,
//! without that record, when its only good source is a rare mob.

mod common;
use forge_core::Faction;
use forge_sim::insertable::Insertable;
use forge_sim::profile::Profile;
use forge_sim::route::model_for;
use forge_sim::Params;
use serde_json::json;

#[test]
fn a_quest_started_by_a_rare_drop_is_not_inserted() {
	let world = common::world(Faction::Alliance);
	let base = Params::effective(common::params_doc().as_ref(), None, &[]);
	let walks = forge_sim::NoWalks;
	let (m, rules) = model_for(&world, "Human", &Profile::average(Faction::Alliance), &base, &walks).unwrap();
	let mut data = forge_world::GameData::from_source(&forge_world::data::DirSource::repo(&common::golden().join("world/root"))).unwrap();
	// (The slice records no reward for 123: give it the game's, so the start is what decides.)
	data.quests.get_mut(&123).expect("The Collector").xp = Some(800.0);
	let q = m.run.q(123).expect("123 in the run");
	let verdict = |data: &forge_world::GameData, fixes: serde_json::Value| {
		forge_sim::fixes::set(fixes);
		let ins = Insertable::new(&world, &m.run, &rules, data, &m.tables.q_full, &Default::default());
		(ins.ok(q), ins.why(q))
	};
	let empty = json!({ "deliberate": {}, "overrides": {} });
	// Optional in v1: refused.
	let (ok, why) = verdict(&data, json!({ "deliberate": { "optional": [{ "q": 123, "why": "rare drop" }] }, "overrides": {} }));
	assert!(!ok && why.contains("optional in v1"), "{why}");
	// No record: the 86 % is a rare mob's, the rest under MIN_START_CHANCE: refused.
	let (ok, why) = verdict(&data, empty.clone());
	assert!(!ok && why.starts_with("started by a rare drop"), "{why}");
	// Gruff Swiftbite an ordinary mob (the data's rank taken away): the 86 % counts.
	data.npcs.get_mut(&100).expect("Gruff Swiftbite").rank = None;
	let (ok, why) = verdict(&data, empty);
	assert!(ok, "{why}");
}
