//! Night Elves do Darkshore to about 14 with Teldrassil in their own start, then join the Alliance
//! route at Westfall (Fitz, 2026-10-27): their goal stream has the shared 03-darkshore goals of
//! quests of level 14 and under before the join, so their own part holds them; the guide's later
//! quests stay in the shared tail, played with the other starts. (c14 moved the whole guide: the
//! start ran Darkshore to 19.3 and every Westfall quest was grey.) Another start's goal stream is
//! unchanged and plays Darkshore in the shared tail.

use forge_core::Faction;
use forge_sim::chain::goals_from;
use forge_sim::order::Order;
use forge_sim::run::K_ACCEPT;
use forge_sim::shared::{doc_goals, join_at, join_goal, own_quests, split_at_join, with_own_guides};
use forge_sim::Step;
use serde_json::json;

/// Teldrassil 1-2, Westfall 10, Darkshore: 20 (level 12), 21 (level 14, after 20), 22 (level 17),
/// 23 (level 13, after 22: its chain opens only with the later quest), Redridge 30.
const NE: [(&str, u32); 8] = [
	("nightelf/01-teldrassil", 1),
	("nightelf/01-teldrassil", 2),
	("02-westfall", 10),
	("03-darkshore", 20),
	("03-darkshore", 21),
	("03-darkshore", 22),
	("03-darkshore", 23),
	("04-redridge-mountains", 30),
];

fn quest(q: u32) -> Option<(f64, Vec<u32>)> {
	match q {
		20 => Some((12.0, vec![])),
		21 => Some((14.0, vec![20])),
		22 => Some((17.0, vec![])),
		23 => Some((13.0, vec![22])),
		_ => Some((5.0, vec![])),
	}
}

fn doc(list: &[(&str, u32)]) -> serde_json::Value {
	let g: Vec<_> = list
		.iter()
		.enumerate()
		.map(|(i, (guide, q))| json!({ "i": i, "guide": format!("forever/alliance/{guide}"), "file": format!("{guide}.guide"), "line": i + 1, "t": "accept", "q": q }))
		.collect();
	json!({ "goals": g })
}

fn moved(race: &str) -> serde_json::Value {
	let d = doc(&NE);
	let own = own_quests(doc_goals(&d), race, &quest);
	with_own_guides(&d, race, join_at(Faction::Alliance), &own)
}

/// The quests of a start's own part, its goal stream played in order (one accept per goal).
fn own_part(race: &str) -> Vec<u32> {
	let rule = join_at(Faction::Alliance);
	let goals = goals_from(&moved(race));
	let o = Order { steps: goals.iter().map(|g| Step { kind: K_ACCEPT, q: g.q.unwrap(), task: -1, pt: 0 }).collect(), origin: goals.iter().map(|g| g.i as i64).collect() };
	let (own, _) = split_at_join(&o, join_goal(&goals, rule));
	own.steps.iter().map(|s| s.q).collect()
}

#[test]
fn night_elves_do_darkshore_to_14_before_they_join_at_westfall() {
	assert_eq!(own_part("NightElf"), vec![1, 2, 20, 21], "Teldrassil and Darkshore's quests to level 14 are the Night Elf's own part");
	assert_eq!(own_part("Human"), vec![1, 2], "another start joins before Westfall with Darkshore in the shared tail");
	let goals = goals_from(&moved("NightElf"));
	assert_eq!(goals.iter().map(|g| g.q.unwrap()).collect::<Vec<_>>(), vec![1, 2, 20, 21, 10, 22, 23, 30], "Darkshore's later quests stay after Westfall");
	assert!(goals.iter().enumerate().all(|(i, g)| g.i == i), "goals numbered again");
}

#[test]
fn a_low_quest_whose_chain_opens_with_a_later_one_stays_in_the_tail() {
	let d = doc(&NE);
	let mut own: Vec<u32> = own_quests(doc_goals(&d), "NightElf", &quest).into_iter().collect();
	own.sort_unstable();
	assert_eq!(own, vec![20, 21]);
}
