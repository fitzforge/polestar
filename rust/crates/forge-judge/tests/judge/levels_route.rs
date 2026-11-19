//! The route model of the judge's levels (`SimLevels::route`): a written walk priced as the routes stage
//! prices an order. A placed line with no quest costs its travel (the gate's model ignores it); a quest
//! with no kill or escort work is taken without first grinding to its level (G6, the gate's model
//! grinds); on the golden slice's Horde world and v1's Orc chain.

use crate::common;
use forge_judge::levels::SimLevels;
use forge_judge::walk::{LevelModel, WPt, WalkGoal};
use forge_world::world::Work;

fn goal(i: usize, t: &str, q: Option<i64>, oi: Option<i64>, w: Option<WPt>) -> WalkGoal {
	WalkGoal {
		i,
		guide: "forever/horde/orc-troll/01-durotar".into(),
		file: String::new(),
		line: None,
		step: None,
		t: t.into(),
		q,
		oi,
		optional: false,
		passing: false,
		map: w.map(|w| w.map),
		w,
		npc: None,
		class: false,
		level: None,
		title: None,
		lvl: 0.0,
		time: 0.0,
		lvl_after: 0.0,
		time_after: 0.0,
		grind: f64::NAN,
		pos: w,
		along: None,
		label: None,
		item: None,
		spots: Vec::new(),
		location: None,
		land: None,
	}
}

/// v1's Orc chain on the slice, as walk goals (the first `n`).
fn orc_goals(n: usize) -> Vec<WalkGoal> {
	let doc = common::json_gz(&common::golden().join("sim/v1-horde-orc-off.json.gz"));
	doc["goals"].as_array().unwrap()[..n]
		.iter()
		.enumerate()
		.map(|(i, g)| {
			let w = g["w"].as_object().map(|w| WPt { c: w["c"].as_i64().unwrap(), wx: w["wx"].as_f64().unwrap(), wy: w["wy"].as_f64().unwrap(), map: g["map"].as_u64().unwrap_or(0) as u32 });
			goal(i, g["t"].as_str().unwrap(), g["q"].as_i64(), g["oi"].as_i64(), w)
		})
		.collect()
}

fn end_time(lv: &SimLevels, goals: &[WalkGoal]) -> f64 {
	let mut g = goals.to_vec();
	let n = lv.replay(&mut g, 61.0);
	g[n - 1].time_after
}

#[test]
fn a_written_detour_costs_its_travel_in_the_route_model_only() {
	let world = common::world(forge_core::Faction::Horde);
	let params = common::params();
	let base = orc_goals(40);
	// A `goto` 1,500 yd away from where the walk stands, between two quest goals, then back.
	let at = base[20].w.unwrap();
	let mut detour = base.clone();
	detour.insert(21, goal(21, "goto", None, None, Some(WPt { wx: at.wx + 1500.0, ..at })));
	for (i, g) in detour.iter_mut().enumerate() {
		g.i = i;
	}
	let route = SimLevels::route(&world, "Orc", Some(&params), None).unwrap();
	let gate = SimLevels::new(&world, "Orc", Some(&params)).unwrap();
	let extra = end_time(&route, &detour) - end_time(&route, &base);
	// There and back, 3,000 yd at least, on foot at level ~5 (about 7 yd/s): several minutes.
	assert!(extra > 120.0, "the detour costs {extra:.0} s in the route model");
	assert_eq!(end_time(&gate, &detour), end_time(&gate, &base), "the gate's model ignores placed lines with no quest");
}

#[test]
fn a_quest_with_no_kill_work_is_taken_without_grinding_to_its_level() {
	let world = common::world(forge_core::Faction::Horde);
	let params = common::params();
	// A quest at least 8 levels above its minimum, with no kill or escort work (`use` work only).
	let q = world
		.quests
		.iter()
		.find(|q| {
			q.level - q.min_level >= 8.0
				&& q.pre.is_empty()
				&& q.pre_all.is_empty()
				&& !q.tasks.is_empty()
				&& q.tasks.iter().all(|t| t.work.iter().all(|w| !matches!(w, Work::Kill { .. } | Work::Escort)))
		})
		.expect("a quest with no kill work in the slice");
	// At the level its work opens (its level less dangerGap 5 and gateGap 2), take it and do it.
	let opens = q.level - 7.0;
	let mut at = goal(0, "level", None, None, None);
	at.level = Some(opens);
	let goals = vec![at, goal(1, "accept", Some(q.id as i64), None, None), goal(2, "complete", Some(q.id as i64), None, None)];
	let play = |lv: &SimLevels| {
		let mut g = goals.clone();
		lv.replay(&mut g, 61.0);
		g
	};
	let route = play(&SimLevels::route(&world, "Orc", Some(&params), None).unwrap());
	let gate = play(&SimLevels::new(&world, "Orc", Some(&params)).unwrap());
	// Both models take it where they stand: the game hands a quest over at its minimum level.
	for (name, g) in [("route", &route), ("gate", &gate)] {
		assert!(g[1].lvl_after < opens + 1.0 && g[1].grind == 0.0, "{name} model: taken at level {:.1}, {:.0} s ground (quest {} level {})", g[1].lvl_after, g[1].grind, q.id, q.level);
	}
	// Its work: the route model does it where it stands (no kill work, no danger); the gate model,
	// for which every quest fights, grinds to its level less dangerGap first.
	assert_eq!(route[2].grind, 0.0, "route model: its work at {:.1}", route[2].lvl);
	assert!(gate[2].grind > 60.0 && gate[2].lvl_after >= q.level - 5.0, "gate model: {:.0} s ground, work done at {:.1} (quest {} level {})", gate[2].grind, gate[2].lvl_after, q.id, q.level);
	// That grind is on the work, which no `level` line writes: the replay gives each goal its model
	// grind, so the check counts it as unwritten grind (GrindWhy, c14).
	let (all, shown) = forge_judge::report::grind_split(&gate, 0.0);
	assert!(all > shown, "all {all} min, on level goals {shown} min");
}

#[test]
fn an_optional_accept_above_the_level_is_skipped_not_ground_to() {
	// c17 Horde: Vehena's cloth donations (quest level 60), optional, written in Orgrimmar at 52.9:
	// the walk ground 12 hours on the accept. A player takes an optional line when they can and
	// walks on when they cannot, so the model skips it (and its quest's later lines) instead.
	let world = common::world(forge_core::Faction::Horde);
	let params = common::params();
	// (The G6 test's quest: the gate's model grinds to its level less dangerGap before the accept.)
	let q = world
		.quests
		.iter()
		.find(|q| {
			q.level - q.min_level >= 8.0
				&& q.pre.is_empty()
				&& q.pre_all.is_empty()
				&& !q.tasks.is_empty()
				&& q.tasks.iter().all(|t| t.work.iter().all(|w| !matches!(w, Work::Kill { .. } | Work::Escort)))
		})
		.expect("a quest with no kill work in the slice");
	let mut at = goal(0, "level", None, None, None);
	at.level = Some(q.level - 7.0);
	let gate = SimLevels::new(&world, "Orc", Some(&params)).unwrap();
	let play = |optional: bool| {
		let mut acc = goal(1, "accept", Some(q.id as i64), None, None);
		acc.optional = optional;
		let mut turn = goal(2, "turnin", Some(q.id as i64), None, None);
		turn.optional = optional;
		let mut g = vec![at.clone(), acc, turn];
		gate.replay(&mut g, 61.0);
		(g[1].grind + g[2].grind, g[2].lvl_after)
	};
	let (grind, _) = play(false);
	assert!(grind > 60.0, "a required accept grinds to its level first: {grind:.0} s (quest {} level {})", q.id, q.level);
	let (grind, end) = play(true);
	assert!(grind == 0.0 && end < q.level - 6.0, "an optional one is skipped: {grind:.0} s of grind, level {end:.1} after its hand-in");
}

#[test]
fn an_item_from_the_bags_costs_no_farming_in_the_route_model() {
	let world = common::world(forge_core::Faction::Horde);
	let params = common::params();
	// A Donation of Wool: wool cloth drops from 66 kinds of mob; the model takes it from the bags.
	let q = world.quests.iter().find(|q| q.id == 7826).expect("A Donation of Wool in the slice");
	assert!(q.objs.iter().any(|o| o.kind == "item" && o.chances.len() > forge_sim::route::BAG_SOURCES));
	let goals = vec![goal(0, "level", None, None, None), goal(1, "accept", Some(7826), None, None), goal(2, "complete", Some(7826), Some(1), None)];
	let work = |lv: &SimLevels| {
		let mut g = goals.clone();
		g[0].level = Some(15.0);
		lv.replay(&mut g, 61.0);
		g[2].time_after - g[2].time
	};
	let route = SimLevels::route(&world, "Orc", Some(&params), None).unwrap();
	let gate = SimLevels::new(&world, "Orc", Some(&params)).unwrap();
	assert!(work(&route) < 1.0, "route model: the wool comes from the bags ({:.0} s)", work(&route));
	assert!(work(&gate) > 60.0, "gate model: the wool is farmed ({:.0} s)", work(&gate));
}

#[test]
fn a_travel_stretch_far_slower_than_the_best_way_is_a_slow_way() {
	// c15w: legal walks over the zone crossings (Stormwind to Menethil through Redridge, Riverglades
	// and Loch Modan) raised no blocker; only the hours showed them. Here: between two quest goals of
	// v1's Durotar, two gotos out 1,500 yd and on, ~3,000 yd on foot where the next goal is near.
	let world = common::world(forge_core::Faction::Horde);
	let params = common::params();
	let base = orc_goals(40);
	let at = base[20].w.unwrap();
	let mut detour = base.clone();
	detour.insert(21, goal(21, "goto", None, None, Some(WPt { wx: at.wx + 1500.0, ..at })));
	detour.insert(22, goal(22, "goto", None, None, Some(WPt { wx: at.wx + 1500.0, wy: at.wy + 100.0, ..at })));
	for (i, g) in detour.iter_mut().enumerate() {
		g.i = i;
	}
	let route = SimLevels::route(&world, "Orc", Some(&params), None).unwrap();
	let slow = |g: &[WalkGoal]| forge_judge::check::slow_ways(g, &route.stretches(g, &forge_judge::check::is_move));
	let v = slow(&detour);
	assert_eq!(v.iter().map(|v| (v.rule.as_str(), v.level)).collect::<Vec<_>>(), vec![("slow-way", forge_judge::check::Level::Warn)], "{v:#?}");
	assert!(v[0].message.contains("best way"), "{}", v[0].message);
	// The stretch is the detour's: from goal 20 to the goal after the gotos.
	let s = route.stretches(&detour, &forge_judge::check::is_move);
	assert!(s.iter().any(|s| s.from == 20 && s.to == 23 && s.written > s.best + 300.0), "{s:#?}");
	// v1's own walk: no slow way.
	assert!(slow(&base).is_empty(), "{:#?}", slow(&base));
}

#[test]
fn work_the_model_does_not_price_is_still_a_stop_of_the_walk() {
	// c15w: the Shamans' Spring Well trip (Brine's class quests, which the average profile has no
	// step for) read as one 40-minute stretch from Merchant Coast to Ratchet, best 1 min. The walk out
	// to work there and back is two stretches, each the best way.
	let world = common::world(forge_core::Faction::Horde);
	let params = common::params();
	let base = orc_goals(40);
	let at = base[20].w.unwrap();
	let there = WPt { wx: at.wx + 1500.0, ..at };
	let mut trip = base.clone();
	trip.insert(21, goal(21, "goto", None, None, Some(there)));
	trip.insert(22, goal(22, "collect", Some(999_999), Some(1), Some(there)));
	trip.insert(23, goal(23, "goto", None, None, Some(at)));
	for (i, g) in trip.iter_mut().enumerate() {
		g.i = i;
	}
	let route = SimLevels::route(&world, "Orc", Some(&params), None).unwrap();
	let s = route.stretches(&trip, &forge_judge::check::is_move);
	assert!(s.iter().any(|s| s.from == 20 && s.to == 22) && s.iter().any(|s| s.from == 22), "{s:#?}");
	assert!(forge_judge::check::slow_ways(&trip, &s).is_empty(), "{:#?}", forge_judge::check::slow_ways(&trip, &s));
}
