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
	// At the level it opens (its level less dangerGap 5 and gateGap 2), take it.
	let opens = q.level - 7.0;
	let mut at = goal(0, "level", None, None, None);
	at.level = Some(opens);
	let goals = vec![at, goal(1, "accept", Some(q.id as i64), None, None)];
	let lvl = |lv: &SimLevels| {
		let mut g = goals.clone();
		lv.replay(&mut g, 61.0);
		g[1].lvl_after
	};
	let route = SimLevels::route(&world, "Orc", Some(&params), None).unwrap();
	let gate = SimLevels::new(&world, "Orc", Some(&params)).unwrap();
	// The route model takes it where it stands; the gate's grinds to its level less dangerGap first.
	assert!(lvl(&route) < opens + 1.0, "route model: taken at level {:.1} (quest {} level {})", lvl(&route), q.id, q.level);
	assert!(lvl(&gate) >= q.level - 5.0, "gate model: {:.1} (quest {} level {})", lvl(&gate), q.id, q.level);
	// The gate model's grinding up to it is on the accept, which no `level` line writes: the replay
	// gives each goal its model grind, so the check counts it as unwritten grind (GrindWhy, c14).
	let mut g = goals.clone();
	gate.replay(&mut g, 61.0);
	assert!(g[1].grind > 60.0, "the gate model's grind before the accept: {:.0} s", g[1].grind);
	let (all, shown) = forge_judge::report::grind_split(&g, 0.0);
	assert!(all > shown, "all {all} min, on level goals {shown} min");
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
