//! The skip ledger names every quest the character could take and the route does not (B2):
//! also one whose chain is closed because a quest before it is left out of the world.

mod common;
use forge_core::Faction;
use forge_sim::ledger::{skips, LedgerIn};
use forge_sim::order::Overrides;
use forge_sim::profile::Profile;
use forge_sim::route::model_for;
use forge_sim::Params;
use forge_world::world::Excluded;

#[test]
fn a_quest_whose_prerequisite_is_out_of_the_world_has_a_reason() {
	let o = common::orc();
	let mut world = o.world.clone();
	// A quest open to the Orc with one prerequisite that is itself a world quest.
	let ids: rustc_hash::FxHashSet<u32> = world.quests.iter().map(|q| q.id).collect();
	let rbit = forge_world::rules::race_bit("Orc", Faction::Horde);
	let q = world
		.quests
		.iter()
		.find(|q| q.dungeon.is_none() && forge_world::rules::quest_open(q, Faction::Horde, rbit, None) && q.pre.len() == 1 && u32::try_from(q.pre[0]).is_ok_and(|p| ids.contains(&p)))
		.expect("a quest with a prerequisite")
		.clone();
	let p = q.pre[0] as u32;
	// The prerequisite left out of the world (its item drops only in an instance); it stays in the
	// quest list (indices unchanged) as another race's.
	let pi = world.quests.iter().position(|x| x.id == p).unwrap();
	world.quests[pi].races = Some(forge_world::rules::race_bit("Troll", Faction::Horde) as f64);
	let title = world.quests[pi].title.clone();
	world.excluded.push(Excluded { id: p, title: Some(title), reason: "item objective 1 drops only outside the open world".into(), category: None, code: "outside" });
	world.excluded_ids.push(p);
	let base = Params::effective(common::params_doc().as_ref(), None, &[]);
	let (model, rules) = model_for(&world, "Orc", &Profile::average(Faction::Horde), &base, &o.walks).unwrap();
	assert!(!rules.open.contains_key(&q.id), "the quest is closed to the character");
	let empty = forge_sim::order::Order { steps: Vec::new(), origin: Vec::new() };
	let refused = Default::default();
	let ovr = Overrides::default();
	let edits = serde_json::Value::Null;
	let l = LedgerIn {
		walks: None,
		world: &world,
		race: "Orc",
		rules: &rules,
		model: &model,
		data: None,
		goals: &[],
		v1: &empty,
		best: &empty,
		lv: &[],
		passed: &[],
		refused: &refused,
		ins: None,
		kb: None,
		ovr: &ovr,
		edits: &edits,
		optional: &[],
		unfinished: &[],
	};
	let rows = skips(&l);
	let row = rows.iter().find(|r| r["q"].as_u64() == Some(u64::from(q.id))).unwrap_or_else(|| panic!("{} {} has no reason in the skips", q.id, q.title));
	assert_eq!(row["reason"], "chain-not-open");
	let detail = row["detail"].as_str().unwrap();
	assert!(detail.contains(&p.to_string()) && detail.contains("left out of the world"), "{detail}");
}

#[test]
fn a_quest_the_route_never_hands_in_is_left_out_unless_v1_carries_it_too() {
	// 5845 Of Lost Honor (c6, every Alliance start): included after 5781's hand-in at 59.9, its
	// work and hand-in fell after 60; the accept alone was written (judge R10).
	use forge_sim::run::{K_ACCEPT, K_TASK, K_TURNIN};
	let o = common::orc();
	let m = o.model(&[]);
	let run = &m.run;
	let v1 = o.seed();
	let tin = |q: u32| v1.steps.iter().position(|s| s.kind == K_TURNIN && s.q == q);
	let quests: Vec<u32> = v1.steps.iter().filter(|s| s.kind == K_ACCEPT && tin(s.q).is_some()).map(|s| s.q).take(2).collect();
	let (a, b) = (quests[0], quests[1]);
	// The route without a's hand-in, and v1 without b's.
	let cut = |o: &forge_sim::order::Order, q: u32| {
		let k = o.steps.iter().position(|s| s.kind == K_TURNIN && s.q == q).unwrap();
		let mut c = o.clone();
		c.steps.remove(k);
		c.origin.remove(k);
		c
	};
	let route = cut(&cut(&v1, a), b);
	let v1b = cut(&v1, b);
	let (out, dropped) = forge_sim::route::drop_unfinished(run, &route, &v1b);
	assert_eq!(dropped, vec![a], "a is never handed in; b is carried as v1 carries it");
	assert!(!out.steps.iter().any(|s| s.q == a && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN)), "every step of a out");
	assert!(out.steps.iter().any(|s| s.q == b && s.kind == K_ACCEPT), "b's accept stays");
	assert_eq!(out.len(), route.len() - route.steps.iter().filter(|s| s.q == a && matches!(s.kind, K_ACCEPT | K_TASK | K_TURNIN)).count());
}

/// c12: Wharfmaster Dizzywig (L36) and Goblin Sponsorship (L37) were `zone-left`, "the route never
/// passes its giver", while the route stood at Kravel Koalbeard at 29.9-30.5 for other quests:
/// passed, but only below their level window.
#[test]
fn a_quest_passed_only_below_its_level_window_is_a_level_skip() {
	use forge_sim::run::{K_ACCEPT, K_GRIND};
	let o = common::orc();
	let base = Params::effective(common::params_doc().as_ref(), None, &[]);
	let (model, rules) = model_for(&o.world, "Orc", &Profile::average(Faction::Horde), &base, &o.walks).unwrap();
	let run = &model.run;
	let seed = o.seed();
	let p = forge_sim::search::Problem::single(&model, &o.walks, Vec::new(), Vec::new());
	let lv = forge_sim::search::runs(&p, &seed)[0].levels().to_vec();
	let in_seed = |q: u32| seed.steps.iter().any(|s| s.kind == K_ACCEPT && s.q == q);
	let near = |q: u32| -> Vec<f64> { (0..seed.len()).filter(|&k| seed.steps[k].kind != K_GRIND && run.straight(seed.steps[k].pt, run.q_giver[q as usize]) <= 500.0).map(|k| lv[k]).collect() };
	// A quest the route does not take, its chain open, whose giver the route stands at only where
	// the quest is more than two levels above the character.
	let q = (0..run.n_quests() as u32)
		.find(|&q| {
			let qi = q as usize;
			let n = near(q);
			!in_seed(q)
				&& rules.open.contains_key(&run.q_id[qi])
				&& run.q_pre[qi].iter().chain(&run.q_all[qi]).all(|&x| in_seed(x))
				&& !n.is_empty()
				&& n.iter().all(|&l| f64::from(run.q_level[qi]) > l.floor() + 2.0)
		})
		.expect("a quest passed only under its level window");
	let refused = Default::default();
	let ovr = Overrides::default();
	let edits = serde_json::Value::Null;
	let l = LedgerIn {
		walks: None,
		world: &o.world,
		race: "Orc",
		rules: &rules,
		model: &model,
		data: None,
		goals: &[],
		v1: &seed,
		best: &seed,
		lv: &lv,
		passed: &[],
		refused: &refused,
		ins: None,
		kb: None,
		ovr: &ovr,
		edits: &edits,
		optional: &[],
		unfinished: &[],
	};
	let rows = skips(&l);
	let row = rows.iter().find(|r| r["q"].as_u64() == Some(u64::from(run.q_id[q as usize]))).expect("a row");
	assert_eq!(row["reason"], "level", "{row}");
	assert!(row["detail"].as_str().unwrap().contains("below its level window"), "{row}");
}
