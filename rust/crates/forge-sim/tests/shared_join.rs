//! The shared route's join on a made-up Horde pair: Orc plays the early Barrens quests in its own
//! orc-troll/02-the-barrens, Tauren inside the shared horde/02-the-barrens. Joined at the first
//! shared guide, Tauren's shared route would lose its Barrens quest (the tail is Orc's, which never
//! had it); joined after horde/02-the-barrens (join_after(Horde)), every quest of Tauren's own
//! order stays, once. And the split is by goal: when Orc's own cut moved a Silverpine step before
//! its last Barrens step, a cut by position would leave that step out of the tail and so out of
//! Tauren's route.

use forge_core::Faction;
use forge_sim::chain::goals_from;
use forge_sim::order::Order;
use forge_sim::run::K_ACCEPT;
use forge_sim::shared::{join_after, join_goal, join_index, joined, split_at_join};
use forge_sim::Step;
use serde_json::json;

const ORC: [(&str, u32); 4] = [("orc-troll/01-durotar", 11), ("orc-troll/02-the-barrens", 12), ("horde/02-the-barrens", 21), ("horde/03-silverpine-forest", 30)];
const TAUREN: [(&str, u32); 4] = [("tauren/01-mulgore", 10), ("horde/02-the-barrens", 20), ("horde/02-the-barrens", 21), ("horde/03-silverpine-forest", 30)];

fn goals(list: &[(&str, u32)]) -> Vec<forge_sim::chain::Goal> {
	let g: Vec<_> =
		list.iter().enumerate().map(|(i, (guide, q))| json!({ "i": i, "guide": format!("forever/horde/{guide}"), "file": format!("{guide}.guide"), "line": i + 1, "t": "accept", "q": q })).collect();
	goals_from(&json!({ "goals": g }))
}

/// An order of one accept per goal, in the goals' order or `perm`'s (run quest index = quest id).
fn order(list: &[(&str, u32)], perm: &[usize]) -> Order {
	Order { steps: perm.iter().map(|&i| Step { kind: K_ACCEPT, q: list[i].1, task: -1, pt: 0 }).collect(), origin: perm.iter().map(|&i| i as i64).collect() }
}

/// Tauren's shared route: its own part + Orc's tail, Orc's own cut in `orc_perm` order.
fn tauren_shared(rule: Option<&str>, orc_perm: &[usize]) -> Vec<u32> {
	let (go, gt) = (goals(&ORC), goals(&TAUREN));
	let (oo, ot) = (order(&ORC, orc_perm), order(&TAUREN, &[0, 1, 2, 3]));
	let (_, tail) = split_at_join(&oo, join_goal(&go, rule));
	let (own, _) = split_at_join(&ot, join_goal(&gt, rule));
	let o = joined(&own, own.len(), &tail, None, gt.len() as i64);
	// The tail's origins index Orc's goals after Tauren's.
	for (s, &g) in o.steps.iter().zip(&o.origin).skip(own.len()) {
		assert_eq!(go[(g - gt.len() as i64) as usize].q, Some(s.q));
	}
	o.steps.iter().map(|s| s.q).collect()
}

#[test]
fn horde_joins_after_the_shared_barrens_guide() {
	// The faction's rule: Tauren keeps its own Barrens order; every quest once.
	assert_eq!(tauren_shared(join_after(Faction::Horde), &[0, 1, 2, 3]), vec![10, 20, 21, 30]);
	// Joined at the first shared guide instead: Tauren's Barrens quest 20 is lost.
	assert_eq!(tauren_shared(None, &[0, 1, 2, 3]), vec![10, 21, 30]);
	assert_eq!(join_after(Faction::Alliance), Some("alliance/02-westfall"));
}

#[test]
fn the_split_is_by_goal_not_position() {
	// Orc's own cut did Silverpine (30) before its last Barrens step (21).
	let perm = [0, 1, 3, 2];
	assert_eq!(tauren_shared(join_after(Faction::Horde), &perm), vec![10, 20, 21, 30]);
	// A cut by position (after the last Barrens step) leaves Orc no tail: Tauren would lose 30.
	let go = goals(&ORC);
	let oo = order(&ORC, &perm);
	assert_eq!(join_index(&oo, &go, join_after(Faction::Horde)), 4);
}

#[test]
fn a_starts_own_quests_of_the_shared_guides_stay() {
	// Tauren's own cut has 31 (a line `only Tauren` of the shared Silverpine guide) after 21; Orc's
	// tail lacks it. Without keep_own_rest Tauren's shared route loses 31.
	let tauren = [("tauren/01-mulgore", 10), ("horde/02-the-barrens", 20), ("horde/02-the-barrens", 21), ("horde/03-silverpine-forest", 31), ("horde/03-silverpine-forest", 30)];
	let (go, gt) = (goals(&ORC), goals(&tauren));
	let oo = order(&ORC, &[0, 1, 2, 3]);
	let ot = order(&tauren, &[0, 1, 2, 3, 4]);
	let rule = join_after(Faction::Horde);
	let (_, tail) = split_at_join(&oo, join_goal(&go, rule));
	let (own, rest) = split_at_join(&ot, join_goal(&gt, rule));
	let mut o = joined(&own, own.len(), &tail, None, gt.len() as i64);
	assert_eq!(o.steps.iter().map(|s| s.q).collect::<Vec<_>>(), vec![10, 20, 21, 30]);
	assert_eq!(forge_sim::shared::keep_own_rest(&mut o, own.len(), &rest), 1);
	assert_eq!(o.steps.iter().map(|s| s.q).collect::<Vec<_>>(), vec![10, 20, 21, 31, 30]);
	// Its origin is its own goal.
	assert_eq!(o.origin[3], 3);
}
