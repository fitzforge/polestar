//! The shared route's join on a made-up Horde pair: Orc plays the early Barrens quests in its own
//! orc-troll/02-the-barrens, Tauren inside the shared horde/02-the-barrens. Fitz's structure (each
//! race's own start zone, then one shared route from the Barrens on): the join is before the first
//! goal of either Barrens guide (join_at(Horde)), so Orc's whole Barrens is the shared tail; Tauren's
//! own Barrens quest the tail lacks is put back (keep_own_rest), every quest once. And the split is
//! by goal: when Orc's own cut moved a Barrens step before its last Durotar step, a cut by position
//! would keep that step out of the tail and so out of Tauren's route.

use forge_core::Faction;
use forge_sim::chain::goals_from;
use forge_sim::order::Order;
use forge_sim::run::K_ACCEPT;
use forge_sim::shared::{join_at, join_goal, join_index, joined, keep_own_rest, split_at_join};
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

/// Tauren's shared route: its own part + Orc's tail + its own quests the tail lacks, Orc's own cut
/// in `orc_perm` order.
fn tauren_shared(rule: Option<&str>, orc_perm: &[usize]) -> Vec<u32> {
	let (go, gt) = (goals(&ORC), goals(&TAUREN));
	let (oo, ot) = (order(&ORC, orc_perm), order(&TAUREN, &[0, 1, 2, 3]));
	let (_, tail) = split_at_join(&oo, join_goal(&go, rule));
	let (own, rest) = split_at_join(&ot, join_goal(&gt, rule));
	let mut o = joined(&own, own.len(), &tail, None, gt.len() as i64);
	// The tail's origins index Orc's goals after Tauren's.
	for (s, &g) in o.steps.iter().zip(&o.origin).skip(own.len()) {
		assert_eq!(go[(g - gt.len() as i64) as usize].q, Some(s.q));
	}
	keep_own_rest(&mut o, own.len(), &rest, &|a, b| (a as f64 - b as f64).abs());
	o.steps.iter().map(|s| s.q).collect()
}

#[test]
fn horde_joins_at_the_barrens() {
	// Orc's own part is Durotar only; its Barrens (12, 21) and on are the tail; Tauren's own Barrens
	// quest 20 is put back; every quest once.
	let go = goals(&ORC);
	assert_eq!(join_goal(&go, join_at(Faction::Horde)), 0, "Orc's own part: Durotar");
	assert_eq!(join_goal(&goals(&TAUREN), join_at(Faction::Horde)), 0, "Tauren's: Mulgore");
	let q = tauren_shared(join_at(Faction::Horde), &[0, 1, 2, 3]);
	assert_eq!(q[0], 10);
	let mut sorted = q.clone();
	sorted.sort_unstable();
	assert_eq!(sorted, vec![10, 12, 20, 21, 30]);
	assert_eq!(join_at(Faction::Alliance), Some("02-westfall"));
}

#[test]
fn the_split_is_by_goal_not_position() {
	// Orc's own cut did a Barrens step (12) before its last Durotar step (11).
	let perm = [1, 0, 2, 3];
	let go = goals(&ORC);
	let oo = order(&ORC, &perm);
	let (own, tail) = split_at_join(&oo, join_goal(&go, join_at(Faction::Horde)));
	assert_eq!(own.steps.iter().map(|s| s.q).collect::<Vec<_>>(), vec![11], "Durotar only");
	assert_eq!(tail.steps.iter().map(|s| s.q).collect::<Vec<_>>(), vec![12, 21, 30]);
	assert_eq!(join_index(&order(&ORC, &[0, 1, 2, 3]), &go, join_at(Faction::Horde)), 1);
}

#[test]
fn a_starts_own_quests_of_the_shared_guides_stay() {
	// Tauren's own cut has 31 (a line `only Tauren` of the shared Silverpine guide) after 21; Orc's
	// tail lacks it. Without keep_own_rest Tauren's shared route loses 31.
	let tauren = [("tauren/01-mulgore", 10), ("horde/02-the-barrens", 20), ("horde/02-the-barrens", 21), ("horde/03-silverpine-forest", 31), ("horde/03-silverpine-forest", 30)];
	let (go, gt) = (goals(&ORC), goals(&tauren));
	let oo = order(&ORC, &[0, 1, 2, 3]);
	let ot = order(&tauren, &[0, 1, 2, 3, 4]);
	let rule = join_at(Faction::Horde);
	let (_, tail) = split_at_join(&oo, join_goal(&go, rule));
	let (own, rest) = split_at_join(&ot, join_goal(&gt, rule));
	let mut o = joined(&own, own.len(), &tail, None, gt.len() as i64);
	assert_eq!(o.steps.iter().map(|s| s.q).collect::<Vec<_>>(), vec![10, 12, 21, 30]);
	// Its own Barrens quest 20 and Silverpine 31 put back, each after the steps of its own order
	// the tail has before it.
	assert_eq!(keep_own_rest(&mut o, own.len(), &rest, &|a, b| (a as f64 - b as f64).abs()), 2);
	assert_eq!(o.steps.iter().map(|s| s.q).collect::<Vec<_>>(), vec![10, 20, 12, 21, 31, 30]);
	// Its origin is its own goal.
	assert_eq!(o.origin[4], 3);
}

#[test]
fn a_tail_step_names_the_start_s_own_line_of_the_same_goal() {
	// c11: Tauren's tail steps came from Orc's orc-troll/02-the-barrens lines (accept 875 there),
	// which no Tauren guide has; Tauren's own horde/02-the-barrens has accept 875 too.
	let tauren = [("tauren/01-mulgore", 10), ("horde/02-the-barrens", 21), ("horde/02-the-barrens", 20), ("horde/03-silverpine-forest", 30)];
	let (go, gt) = (goals(&ORC), goals(&tauren));
	let rule = join_at(Faction::Horde);
	let (_, tail) = split_at_join(&order(&ORC, &[0, 1, 2, 3]), join_goal(&go, rule));
	let (own, _) = split_at_join(&order(&tauren, &[0, 1, 2, 3]), join_goal(&gt, rule));
	let off = gt.len() as i64;
	let mut o = joined(&own, own.len(), &tail, None, off);
	// Orc's 12 (orc-troll Barrens), 21 (shared Barrens), 30 (Silverpine): 21 and 30 are Tauren's own lines.
	assert_eq!(forge_sim::shared::own_lines(&mut o, own.len(), &gt, join_goal(&gt, rule), &go, off), 2);
	let from = |q: u32| o.origin[o.steps.iter().position(|s| s.q == q).unwrap()];
	assert_eq!(from(21), 1, "Tauren's own shared-Barrens line");
	assert_eq!(from(30), 3);
	assert_eq!(from(12), off + 1, "Orc's own: no Tauren line");
}
