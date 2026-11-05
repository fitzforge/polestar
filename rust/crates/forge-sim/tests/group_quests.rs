//! Elite and group quests in the routes (Fitz, 2026-10-29; crate::group): the planner may take a
//! family it judges (a soloable elite like Hogger, or a group quest a record sizes), prices its
//! group risk, and gives a solo player who skips it the XP back after its hand-in, so the level
//! plan holds. Before, every elite quest was refused as "group work".

mod common;
use forge_core::Faction;
use forge_sim::group::{families, size_of, Groups, Mob, REFUSE_SIZE};
use forge_sim::insertable::Insertable;
use forge_sim::order::Order;
use forge_sim::profile::Profile;
use forge_sim::route::model_for;
use forge_sim::run::{K_ACCEPT, K_GRIND, K_TASK, K_TURNIN};
use forge_sim::search::evaluate;
use forge_sim::{Params, Step};
use serde_json::json;
use std::sync::{Arc, Mutex};

/// The route fixes are one per process: the tests that set them run one at a time.
static FIXES: Mutex<()> = Mutex::new(());

const HOGGER_QUEST: u32 = 176;

fn data() -> forge_world::GameData {
	forge_world::GameData::from_source(&forge_world::data::DirSource::repo(&common::golden().join("world/root"))).unwrap()
}

/// The Human model with the character's group families (as route::prepare sets them).
fn human(groups: bool) -> (forge_world::World, forge_sim::Model, forge_world::Rules, forge_world::GameData, Groups) {
	let world = common::world(Faction::Alliance);
	let mut data = data();
	// (The slice records no reward for 176: give it the game's, so the group rule is what decides.)
	data.quests.get_mut(&HOGGER_QUEST).expect("Hogger's quest").xp = Some(1000.0);
	let rules = forge_world::Rules::new(&world, "Human", None, false);
	let g = families(&world, &rules, &data);
	let base = Params::effective(common::params_doc().as_ref(), None, &[]);
	let profile = Profile { groups: groups.then(|| Arc::new(g.clone())), ..Profile::average(Faction::Alliance) };
	let (m, rules) = model_for(&world, "Human", &profile, &base, &forge_sim::NoWalks).unwrap();
	(world, m, rules, data, g)
}

/// Grind to 11, then Hogger's accept, work and hand-in, then on to 13.
fn hogger_order(m: &forge_sim::Model) -> (Order, usize) {
	let run = &m.run;
	let q = run.q(HOGGER_QUEST).expect("Hogger's quest in the Human run");
	let qi = q as usize;
	let mut steps = vec![Step::grind(11, 0), Step { kind: K_ACCEPT, q, task: -1, pt: run.q_giver[qi] }];
	for t in run.q_task0[qi]..run.q_task1[qi] {
		steps.push(Step { kind: K_TASK, q, task: t as i32, pt: run.task_pt[t as usize] });
	}
	steps.push(Step { kind: K_TURNIN, q, task: -1, pt: run.q_ender[qi] });
	let turnin = steps.len() - 1;
	steps.push(Step::grind(13, 0));
	let n = steps.len();
	(Order { steps, origin: vec![forge_sim::order::INSERTED; n] }, turnin)
}

#[test]
fn hogger_is_a_soloable_elite_the_route_may_insert() {
	let _l = FIXES.lock().unwrap_or_else(|e| e.into_inner());
	forge_sim::fixes::set(json!({ "deliberate": {}, "overrides": {} }));
	let (world, m, rules, data, g) = human(true);
	let f = g.family(HOGGER_QUEST).expect("Hogger's quest is a family root");
	assert_eq!((f.root, f.size, f.take), (HOGGER_QUEST, 1, true), "one elite at the quest's level: soloable ({})", f.why);
	assert!(f.mobs.iter().any(|x| x.name == "Hogger" && x.rank == 1), "{:?}", f.mobs);
	let q = m.run.q(HOGGER_QUEST).unwrap();
	let ins = Insertable::new(&world, &m.run, &rules, &data, &m.tables.q_full, &Default::default());
	assert!(ins.ok(q) && ins.why(q).starts_with("soloable elite"), "{}", ins.why(q));
	// Without the families (the planner before): refused as group work.
	let (world, m, rules, data, _) = human(false);
	let ins = Insertable::new(&world, &m.run, &rules, &data, &m.tables.q_full, &Default::default());
	assert!(!ins.ok(q) && ins.why(q).starts_with("group work"), "{}", ins.why(q));
}

#[test]
fn a_group_quest_costs_its_risk_and_a_solo_player_grinds_its_xp_back_after_the_hand_in() {
	let _l = FIXES.lock().unwrap_or_else(|e| e.into_inner());
	// A record sizes Hogger's quest a group of 3: two players beyond the first.
	forge_sim::fixes::set(json!({ "deliberate": { "group": [{ "q": HOGGER_QUEST, "size": 3, "why": "test" }] }, "overrides": {} }));
	let (_, m, _, _, g) = human(true);
	assert_eq!(g.units(HOGGER_QUEST), 2.0);
	let (order, turnin) = hogger_order(&m);
	let walks = forge_sim::NoWalks;
	let mut ev = m.evaluator(&walks);
	let secs = evaluate(&mut ev, &order);
	let p = &m.tables.p;
	let risk = ev.cost() - secs - (p.grind_weight - 1.0).max(0.0) * ev.s.grind_sec;
	assert!((risk - 2.0 * p.group_risk).abs() < 1e-6, "the hand-in counts groupRisk per extra player: {risk}");
	// The fallback: right after the hand-in, at the level the group player has there.
	let rep = forge_sim::group::report(&mut ev, &order);
	let fb = rep["soloFallback"].as_array().expect("a fallback");
	assert_eq!(fb.len(), 1, "{rep}");
	assert_eq!((fb[0]["root"].as_u64(), fb[0]["after"].as_u64()), (Some(u64::from(HOGGER_QUEST)), Some(turnin as u64)));
	assert!(fb[0]["min"].as_f64().unwrap() > 0.0, "the solo player grinds there: {rep}");
	assert_eq!(rep["list"][0]["size"], json!(3));
	// For the group player the fallback grind does nothing: the order with it plays the same.
	let fbs = forge_sim::group::fallbacks(&mut ev, &order);
	let mut with = order.clone();
	with.steps.insert(turnin + 1, Step::grind(fbs[0].level, fbs[0].xp));
	with.origin.insert(turnin + 1, forge_sim::order::INSERTED);
	assert!((evaluate(&mut ev, &with) - secs).abs() < 1e-6, "a no-op for the group player");
	// The solo player's order: no step of the family, the grind in its place; same level after it.
	let solo = forge_sim::group::solo_order(&m.run, &order, &fbs);
	assert!(!solo.steps.iter().any(|s| s.kind != K_GRIND && s.q == m.run.q(HOGGER_QUEST).unwrap()));
	ev.reset();
	for i in 0..=turnin {
		ev.step_in(&order.steps, i);
	}
	let group_level = ev.level_now();
	ev.reset();
	let at = solo.steps.iter().rposition(|s| s.kind == K_GRIND && s.q == fbs[0].level && s.task == fbs[0].xp).unwrap();
	for i in 0..=at {
		ev.step_in(&solo.steps, i);
	}
	// (The fallback's XP is the whole XP under the group player's: at most one XP short.)
	assert!(ev.level_now() >= group_level - 1e-4, "back on the plan: {} against {group_level}", ev.level_now());
}

#[test]
fn a_dungeon_quest_whose_giver_stands_outside_is_never_taken() {
	let _l = FIXES.lock().unwrap_or_else(|e| e.into_inner());
	forge_sim::fixes::set(json!({ "deliberate": { "group": [{ "q": HOGGER_QUEST, "size": 2, "why": "test" }] }, "overrides": {} }));
	let world = common::world(Faction::Alliance);
	let mut data = data();
	data.quests.get_mut(&HOGGER_QUEST).unwrap().web = Some(forge_world::data::WebQuest { kind: Some(forge_sim::group::DUNGEON_TYPE), ..Default::default() });
	let rules = forge_world::Rules::new(&world, "Human", None, false);
	let f = families(&world, &rules, &data).family(HOGGER_QUEST).cloned().unwrap();
	assert!(!f.take && f.size == REFUSE_SIZE && f.why.contains("dungeon"), "{f:?}");
}

#[test]
fn the_size_reads_the_elites_count_level_and_rank() {
	let mob = |level: f64, rank: u8, count: f64| Mob { npc: 1, name: "X".into(), level, rank, count };
	assert_eq!(size_of(&[mob(40.0, 1, 1.0)], 40.0).0, 1, "one elite at the quest's level");
	assert_eq!(size_of(&[mob(42.0, 1, 1.0)], 40.0).0, 2, "one elite two over");
	assert_eq!(size_of(&[mob(44.0, 1, 1.0)], 40.0).0, 3, "one elite four over");
	assert_eq!(size_of(&[mob(40.0, 1, 4.0)], 40.0).0, 2, "a few elites");
	assert_eq!(size_of(&[mob(40.0, 1, 15.0)], 40.0).0, 3, "a camp of elites");
	assert_eq!(size_of(&[mob(41.0, 1, 15.0)], 40.0).0, 4, "a camp of elites over the level");
	assert_eq!(size_of(&[mob(40.0, 2, 1.0)], 40.0).0, 2, "a rare elite counts one more");
	assert_eq!(size_of(&[mob(40.0, 3, 1.0)], 40.0).0, REFUSE_SIZE, "a boss is never taken");
	assert_eq!(size_of(&[mob(60.0, 2, 1.0)], 55.0).0, REFUSE_SIZE, "a rare elite five over (Teremus) is never taken");
	assert_eq!(size_of(&[], 40.0).0, 2, "elite work the data does not place");
}
