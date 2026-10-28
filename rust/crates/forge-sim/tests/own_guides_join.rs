//! Night Elves do Darkshore with Teldrassil in their own start, then join the Alliance route at
//! Westfall (Fitz, 2026-10-27): their goal stream has the shared 03-darkshore goals before the join, so
//! their own part holds them; another start's goal stream is unchanged and plays Darkshore in the
//! shared tail.

use forge_core::Faction;
use forge_sim::chain::goals_from;
use forge_sim::run::K_ACCEPT;
use forge_sim::shared::{join_at, join_goal, split_at_join, with_own_guides};
use forge_sim::order::Order;
use forge_sim::Step;
use serde_json::json;

const NE: [(&str, u32); 5] = [("nightelf/01-teldrassil", 1), ("nightelf/01-teldrassil", 2), ("02-westfall", 10), ("03-darkshore", 20), ("04-redridge-mountains", 30)];

fn doc(list: &[(&str, u32)]) -> serde_json::Value {
	let g: Vec<_> = list.iter().enumerate().map(|(i, (guide, q))| json!({ "i": i, "guide": format!("forever/alliance/{guide}"), "file": format!("{guide}.guide"), "line": i + 1, "t": "accept", "q": q })).collect();
	json!({ "goals": g })
}

/// The quests of a start's own part, its goal stream played in order (one accept per goal).
fn own_part(race: &str) -> Vec<u32> {
	let rule = join_at(Faction::Alliance);
	let goals = goals_from(&with_own_guides(&doc(&NE), race, rule));
	let o = Order { steps: goals.iter().map(|g| Step { kind: K_ACCEPT, q: g.q.unwrap(), task: -1, pt: 0 }).collect(), origin: goals.iter().map(|g| g.i as i64).collect() };
	let (own, _) = split_at_join(&o, join_goal(&goals, rule));
	own.steps.iter().map(|s| s.q).collect()
}

#[test]
fn night_elves_do_darkshore_before_they_join_at_westfall() {
	assert_eq!(own_part("NightElf"), vec![1, 2, 20], "Teldrassil and Darkshore are the Night Elf's own part");
	assert_eq!(own_part("Human"), vec![1, 2], "another start joins before Westfall with Darkshore in the shared tail");
	let goals = goals_from(&with_own_guides(&doc(&NE), "NightElf", join_at(Faction::Alliance)));
	assert!(goals.iter().enumerate().all(|(i, g)| g.i == i), "goals numbered again");
}
