//! A leveling guide's `fresh` header: how much of its quest XP follows on from earlier guides of the route,
//! for a character who opens it fresh (none of those guides' quests done). Computed after validation from the
//! guides compiled together and written into the compiled guide (docs/GUIDE_FORMAT.md, "What the compiler
//! fills in"). Polestar's Engine reads it for the guide window's fresh-start note (Engine.FreshStart) and
//! "Suggested for you" (Guides.Suggestions).
//!
//! For guide G with leveling guides chaining into it (`next`, every route choice; up to FRESH_BACK guides
//! back), each hand-in of G (its first per quest) counts its quest's XP (the data's, else the hand-in's own
//! `xp`) towards `xp`, and towards the dependent XP when the quest hinges on an earlier guide: G never takes
//! it and an earlier guide does (a carried hand-in), or G's accept of it waits on a prerequisite (each of
//! `preAll`, or one of `pre` when none of them is free) that G does not take before it and an earlier guide
//! does, or that G takes in an accept hinging so itself. The earlier guide is the nearest that takes the
//! quest. `fresh = { from, share, xp, needs }`: the earlier guide holding the most dependent XP (ties: the
//! nearer, then the route's order), the dependent share of `xp` in whole percent, `xp`, and up to FRESH_NEEDS
//! of the earlier guides' quests it hinges on, most XP first (then by id). Only from FRESH_MIN percent.

use rustc_hash::{FxHashMap, FxHashSet};

use crate::data::Data;
use crate::js::{Obj, V};

/// How many guides back the earlier guides are read (the Engine's feeder plan reads as many).
pub const FRESH_BACK: usize = 8;
/// How many of the earlier guides' quests `needs` lists.
pub const FRESH_NEEDS: usize = 8;
/// The dependent share of a guide's quest XP, in percent, from which it gets a `fresh` header.
pub const FRESH_MIN: f64 = 10.0;

fn id_of(g: &V) -> String {
	g.get("id").to_js_string()
}

/// The guides `g` hands off to: its `next` and every route choice.
fn next_ids(g: &V) -> Vec<String> {
	let mut out: Vec<String> = Vec::new();
	let next = g.get("next");
	let first = if next.truthy() { vec![next] } else { Vec::new() };
	for v in first.into_iter().chain(g.get("nextChoices").items()) {
		let id = v.to_js_string();
		if !out.contains(&id) {
			out.push(id);
		}
	}
	out
}

fn leveling(g: &V) -> bool {
	let c = g.get("category");
	!c.truthy() || c.as_str() == Some("Leveling")
}

fn quest_id(v: &V) -> Option<i64> {
	let n = v.num();
	(n.is_finite() && n > 0.0).then_some(n as i64)
}

fn ids(v: &V) -> Vec<i64> {
	v.items().iter().filter_map(quest_id).collect()
}

fn quest_xp(data: &Data, goal: &V) -> f64 {
	let q = data.quest(&goal.get("quest"));
	if q.truthy() && q.get("xp").num() > 0.0 {
		return q.get("xp").num();
	}
	let r = goal.get("rewards").get("xp").num();
	if r > 0.0 {
		r
	} else {
		0.0
	}
}

/// Sets `fresh` on each leveling guide of `guides` that has one (see above).
pub fn fresh_guides(guides: &[V], data: &Data) {
	let mut by_id: FxHashMap<String, &V> = FxHashMap::default();
	for g in guides {
		by_id.entry(id_of(g)).or_insert(g);
	}
	let mut preds: FxHashMap<String, Vec<String>> = FxHashMap::default();
	for g in guides.iter().filter(|g| leveling(g)) {
		let id = id_of(g);
		for to in next_ids(g) {
			let list = preds.entry(to).or_default();
			if !list.contains(&id) {
				list.push(id.clone());
			}
		}
	}
	for g in guides.iter().filter(|g| leveling(g)) {
		if let Some(f) = fresh_of(g, &by_id, &preds, data) {
			g.set("fresh", V::Obj(f));
		}
	}
}

/// What a prerequisite of one of G's accepts hinges on: nothing (G takes it before, on its own), the earlier
/// guides' quests a hinging accept of G's hinges on, the prerequisite itself (an earlier guide takes it), or
/// None when no guide read takes it.
fn hinge(p: i64, own: &FxHashSet<i64>, dep: &FxHashMap<i64, Vec<i64>>, taken: &FxHashMap<i64, usize>) -> Option<Vec<i64>> {
	if own.contains(&p) {
		Some(dep.get(&p).cloned().unwrap_or_default())
	} else if taken.contains_key(&p) {
		Some(vec![p])
	} else {
		None
	}
}

fn add_all(into: &mut Vec<i64>, from: Vec<i64>) {
	for n in from {
		if !into.contains(&n) {
			into.push(n);
		}
	}
}

fn fresh_of(g: &V, by_id: &FxHashMap<String, &V>, preds: &FxHashMap<String, Vec<String>>, data: &Data) -> Option<Obj> {
	// The earlier guides, nearest first (breadth first, in the route's order), and the nearest that takes
	// each quest (its index in `earlier`).
	let mut taken: FxHashMap<i64, usize> = FxHashMap::default();
	let mut earlier: Vec<String> = Vec::new();
	let mut seen: FxHashSet<String> = FxHashSet::default();
	seen.insert(id_of(g));
	let mut frontier = vec![id_of(g)];
	for _ in 0..FRESH_BACK {
		let mut further = Vec::new();
		for id in &frontier {
			for from in preds.get(id).map(Vec::as_slice).unwrap_or_default() {
				if !seen.insert(from.clone()) {
					continue;
				}
				let Some(fg) = by_id.get(from) else { continue };
				let order = earlier.len();
				earlier.push(from.clone());
				further.push(from.clone());
				for step in fg.get("steps").items() {
					for goal in step.get("goals").items() {
						if goal.get("t").as_str() == Some("accept") {
							if let Some(q) = quest_id(&goal.get("quest")) {
								taken.entry(q).or_insert(order);
							}
						}
					}
				}
			}
		}
		if further.is_empty() {
			break;
		}
		frontier = further;
	}
	if earlier.is_empty() {
		return None;
	}
	// G's own accepts in route order, and the earlier guides' quests each hinges on.
	let mut own: FxHashSet<i64> = FxHashSet::default();
	let mut dep: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
	let mut total = 0.0;
	let mut by_need: FxHashMap<i64, f64> = FxHashMap::default();
	let mut handed: FxHashSet<i64> = FxHashSet::default();
	for step in g.get("steps").items() {
		for goal in step.get("goals").items() {
			let Some(q) = quest_id(&goal.get("quest")) else { continue };
			match goal.get("t").as_str() {
				Some("accept") => {
					if own.contains(&q) {
						continue;
					}
					let mut needs: Vec<i64> = Vec::new();
					for p in ids(&goal.get("preAll")) {
						add_all(&mut needs, hinge(p, &own, &dep, &taken).unwrap_or_default());
					}
					// One of `pre` opens it: nothing when G takes one on its own, else the first that hinges.
					let any: Vec<Option<Vec<i64>>> = ids(&goal.get("pre")).into_iter().map(|p| hinge(p, &own, &dep, &taken)).collect();
					if !any.iter().any(|h| h.as_ref().is_some_and(Vec::is_empty)) {
						add_all(&mut needs, any.into_iter().flatten().next().unwrap_or_default());
					}
					own.insert(q);
					if !needs.is_empty() {
						dep.insert(q, needs);
					}
				}
				Some("turnin") => {
					if !handed.insert(q) {
						continue;
					}
					let xp = quest_xp(data, &goal);
					total += xp;
					let needs = if own.contains(&q) {
						dep.get(&q).cloned().unwrap_or_default()
					} else if taken.contains_key(&q) {
						vec![q]
					} else {
						Vec::new()
					};
					// The quest's XP goes to the first quest it hinges on.
					if let Some(n) = needs.first() {
						*by_need.entry(*n).or_insert(0.0) += xp;
					}
				}
				_ => {}
			}
		}
	}
	let dependent: f64 = by_need.values().sum();
	if total <= 0.0 || dependent * 100.0 / total < FRESH_MIN {
		return None;
	}
	// The earlier guide holding the most dependent XP; ties keep the nearer (the breadth-first order).
	let mut per_guide: Vec<f64> = vec![0.0; earlier.len()];
	for (n, xp) in &by_need {
		if let Some(order) = taken.get(n) {
			per_guide[*order] += xp;
		}
	}
	let mut best = 0;
	for (i, xp) in per_guide.iter().enumerate() {
		if *xp > per_guide[best] {
			best = i;
		}
	}
	let mut needs: Vec<(i64, f64)> = by_need.into_iter().collect();
	needs.sort_by(|a, b| b.1.total_cmp(&a.1).then(a.0.cmp(&b.0)));
	needs.truncate(FRESH_NEEDS);
	let out = Obj::new();
	out.set("from", earlier[best].as_str());
	out.set("share", (dependent * 100.0 / total).round());
	out.set("xp", total.round());
	out.set("needs", V::from(needs.iter().map(|(q, _)| V::from(*q as f64)).collect::<Vec<V>>()));
	Some(out)
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::js::parse_json;

	fn guide(json: &str) -> V {
		parse_json(json).expect("json")
	}

	fn needs(f: &V) -> Vec<f64> {
		f.get("needs").items().iter().map(V::num).collect()
	}

	// A (Elwynn) takes 1 and 2; B (Westfall, after A) hands in 1 (carried, 1,000 XP), takes 3 needing 2 and hands
	// it in (500), takes and hands in 4 on its own (500). 1,500 of 2,000 XP (75%) hinge on A's quests.
	#[test]
	fn a_guides_quest_xp_that_hinges_on_an_earlier_guide_is_its_fresh_share() {
		let a = guide(r#"{ "id": "t/a", "next": "t/b", "steps": [ { "goals": [ { "t": "accept", "quest": 1 }, { "t": "accept", "quest": 2 } ] } ] }"#);
		let b = guide(
			r#"{ "id": "t/b", "steps": [ { "goals": [
				{ "t": "turnin", "quest": 1, "rewards": { "xp": 1000 } },
				{ "t": "accept", "quest": 3, "pre": [2] }, { "t": "turnin", "quest": 3, "rewards": { "xp": 500 } },
				{ "t": "accept", "quest": 4 }, { "t": "turnin", "quest": 4, "rewards": { "xp": 500 } } ] } ] }"#,
		);
		fresh_guides(&[a.clone(), b.clone()], &Data::empty());
		assert!(a.get("fresh").is_undef(), "no guide leads to the first one");
		let f = b.get("fresh");
		assert_eq!(f.get("from").as_str(), Some("t/a"));
		assert_eq!(f.get("share").num(), 75.0);
		assert_eq!(f.get("xp").num(), 2000.0);
		assert_eq!(needs(&f), vec![1.0, 2.0], "most XP first");
	}

	// Under FRESH_MIN percent (50 of 1,000 XP), no header.
	#[test]
	fn a_small_share_writes_nothing() {
		let a = guide(r#"{ "id": "t/a", "next": "t/b", "steps": [ { "goals": [ { "t": "accept", "quest": 1 } ] } ] }"#);
		let b = guide(
			r#"{ "id": "t/b", "steps": [ { "goals": [ { "t": "turnin", "quest": 1, "rewards": { "xp": 50 } },
				{ "t": "accept", "quest": 4 }, { "t": "turnin", "quest": 4, "rewards": { "xp": 950 } } ] } ] }"#,
		);
		fresh_guides(&[a, b.clone()], &Data::empty());
		assert!(b.get("fresh").is_undef());
	}

	// Through G's own accepts: 6 needs 5, which G takes needing A's 2, so 6 hinges on 2 as well; 7 needs 5 or
	// 8, and G takes 8 on its own before it, so 7 hinges on nothing. A guide that only reaches G through a route
	// choice (C, two back) counts, and `from` is the guide holding the most dependent XP (C's 9: 3,000) rather
	// than the nearest (A: 1,000 + 1,000).
	#[test]
	fn hinging_runs_through_the_guides_own_accepts_one_free_alternative_opens_a_quest_and_from_holds_the_most_xp() {
		let c = guide(r#"{ "id": "t/c", "nextChoices": ["t/a", "t/x"], "steps": [ { "goals": [ { "t": "accept", "quest": 9 } ] } ] }"#);
		let a = guide(r#"{ "id": "t/a", "next": "t/b", "steps": [ { "goals": [ { "t": "accept", "quest": 2 } ] } ] }"#);
		let b = guide(
			r#"{ "id": "t/b", "steps": [ { "goals": [
				{ "t": "accept", "quest": 5, "preAll": [2] }, { "t": "turnin", "quest": 5, "rewards": { "xp": 1000 } },
				{ "t": "accept", "quest": 6, "pre": [5] }, { "t": "turnin", "quest": 6, "rewards": { "xp": 1000 } },
				{ "t": "accept", "quest": 8 }, { "t": "turnin", "quest": 8, "rewards": { "xp": 1000 } },
				{ "t": "accept", "quest": 7, "pre": [5, 8] }, { "t": "turnin", "quest": 7, "rewards": { "xp": 1000 } },
				{ "t": "turnin", "quest": 9, "rewards": { "xp": 3000 } },
				{ "t": "accept", "quest": 10 }, { "t": "turnin", "quest": 10, "rewards": { "xp": 3000 } } ] } ] }"#,
		);
		fresh_guides(&[c, a, b.clone()], &Data::empty());
		let f = b.get("fresh");
		assert_eq!(f.get("from").as_str(), Some("t/c"));
		assert_eq!(f.get("xp").num(), 10000.0);
		assert_eq!(f.get("share").num(), 50.0, "5, 6 (via 5) and 9; not 7, nor G's own 8 and 10");
		assert_eq!(needs(&f), vec![9.0, 2.0]);
	}

	// A guide past FRESH_BACK guides back is not read; neither is a guide that is not a leveling guide.
	#[test]
	fn guides_too_far_back_or_not_leveling_count_for_nothing() {
		let mut list = vec![guide(r#"{ "id": "t/g0", "next": "t/g1", "steps": [ { "goals": [ { "t": "accept", "quest": 1 } ] } ] }"#)];
		for i in 1..=FRESH_BACK {
			list.push(guide(&format!(r#"{{ "id": "t/g{i}", "next": "t/g{}", "steps": [ {{ "goals": [ {{ "t": "level", "level": 2 }} ] }} ] }}"#, i + 1)));
		}
		let end = format!("t/g{}", FRESH_BACK + 1);
		list.push(guide(&format!(
			r#"{{ "id": "{end}", "steps": [ {{ "goals": [ {{ "t": "turnin", "quest": 1, "rewards": {{ "xp": 100 }} }}, {{ "t": "turnin", "quest": 2, "rewards": {{ "xp": 100 }} }} ] }} ] }}"#
		)));
		list.push(guide(&format!(r#"{{ "id": "t/class", "category": "Class", "next": "{end}", "steps": [ {{ "goals": [ {{ "t": "accept", "quest": 2 }} ] }} ] }}"#)));
		fresh_guides(&list, &Data::empty());
		assert!(list[FRESH_BACK + 1].get("fresh").is_undef());
	}
}
