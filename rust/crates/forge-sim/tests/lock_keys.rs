//! An item that only comes out of a locked object is got after the lock's key (PR #467): Benedict's
//! Chest (object 3239) opens with Benedict's Key (4882), which Lieutenant Benedict (3192) drops,
//! Vanquish the Betrayers' kill (784); the chest's Aged Envelope (4881) starts The Admiral's
//! Orders (830): its accept comes after that kill.

mod common;
use forge_core::Faction;
use forge_sim::needs::{item_needs, Rewards};
use forge_sim::run::{K_ACCEPT, K_TASK};

#[test]
fn the_chest_s_quest_is_taken_after_the_kill_that_drops_its_key() {
	let o = common::orc();
	let m = o.model(&[]);
	let run = &m.run;
	let (_, rules) = forge_sim::route::model_for(&o.world, "Orc", &forge_sim::profile::Profile::average(Faction::Horde), &forge_sim::Params::effective(common::params_doc().as_ref(), None, &[]), &o.walks).unwrap();
	let seed = o.seed();
	let root = common::golden().join("world/root");
	let mut data = forge_world::GameData::from_source(&forge_world::data::DirSource::repo(&root)).unwrap();
	let (q830, q784) = (run.q(830).expect("830 in the run"), run.q(784).expect("784 in the run"));
	let need = |data: &forge_world::GameData| item_needs(&o.world, run, &rules, data, &Rewards::default(), &seed, &[]).into_iter().find(|n| n.qb == q830 && n.kb == K_ACCEPT);
	// The key's data (the slice has no key item), no lock yet: no order.
	data.items.insert(4882, serde_json::from_value(serde_json::json!({ "id": 4882, "name": "Benedict's Key", "drops": { "npc": { "3192": 100 }, "object": {} }, "vendors": [] })).unwrap());
	assert!(need(&data).is_none(), "an unlocked chest needs no key");
	// The lock (forever-db/corrections/objects.json 3239.set.lock).
	data.objects.get_mut(&3239).expect("Benedict's Chest").lock = Some(forge_world::data::Lock { item: Some(4882) });
	let n = need(&data).expect("the accept waits for the key");
	assert_eq!((n.ka, n.qa), (K_TASK, q784), "{}", n.why);
	let t = n.task_a as u32;
	assert!((run.task_w0[t as usize]..run.task_w1[t as usize]).any(|w| run.w_mob[w as usize] == 3192), "the task that kills Lieutenant Benedict");
}
