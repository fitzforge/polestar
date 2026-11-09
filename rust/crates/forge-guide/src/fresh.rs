//! A leveling guide's `fresh` header (0.3.7, FreshStart): how much of its quest XP follows on from earlier
//! guides of the route, for a character who opens it fresh (none of those guides' quests done). Computed
//! here, after validation, from the guides compiled together; written into the compiled guide's header
//! (docs/GUIDE_FORMAT.md, "Compiled fields"). Polestar's Engine reads it for the fresh-start note
//! (Engine.FreshStart) and "Suggested for you" (Guides.Suggestions).
//!
//! For guide G with guides chaining into it (`next`, every route choice; up to FRESH_BACK back), each
//! turn-in of G (its first per quest) counts its quest's XP (the data's, else the turn-in's `xp`) towards
//! `xp`, and towards the dependent XP when the quest needs an earlier guide: G never takes it but an earlier
//! guide does (a carried hand-in), or G's accept of it lacks a prerequisite (`pre`/`preAll`) G does not take
//! before it and an earlier guide does, or such a prerequisite is itself dependent in G. The earlier guide is
//! the nearest that takes the quest. `fresh = { from, share, xp, needs }`: the earlier guide holding the most
//! dependent XP (ties: nearer, then the route's order), the dependent share of `xp` in whole percent, `xp`,
//! and up to FRESH_NEEDS of the earlier guides' quests it hinges on, most XP first (then by id). Only when the
//! share is at least FRESH_MIN.

use rustc_hash::{FxHashMap, FxHashSet};

use crate::data::Data;
use crate::js::{Obj, V};

pub const FRESH_BACK: usize = 8;
pub const FRESH_NEEDS: usize = 8;
pub const FRESH_MIN: f64 = 10.0;

fn id_of(g: &V) -> String {
	g.get("id").to_js_string()
}

fn next_ids(g: &V) -> Vec<String> {
	let nc = g.get("nextChoices");
	if nc.truthy() {
		nc.items().iter().map(|v| v.to_js_string()).collect()
	} else if g.get("next").truthy() {
		vec![g.get("next").to_js_string()]
	} else {
		Vec::new()
	}
}

fn leveling(g: &V) -> bool {
	let c = g.get("category");
	!c.truthy() || c.as_str() == Some("Leveling")
}

fn quest_id(v: &V) -> Option<i64> {
	let n = v.num();
	if n.is_finite() && n > 0.0 {
		Some(n as i64)
	} else {
		None
	}
}

fn quest_xp(data: &Data, goal: &V) -> f64 {
	let q = data.quest(&goal.get("quest"));
	if q.truthy() && q.get("xp").num() > 0.0 {
		return q.get("xp").num();
	}
	let r = goal.get("rewards");
	if r.truthy() && r.get("xp").num() > 0.0 {
		return r.get("xp").num();
	}
	0.0
}

fn pres(goal: &V) -> Vec<i64> {
	let mut out = Vec::new();
	for k in ["preAll", "pre"] {
		for p in goal.get(k).items() {
			if let Some(id) = quest_id(&p) {
				out.push(id);
			}
		}
	}
	out
}

/// Sets `fresh` on each leveling guide of `guides` that has one (see above).
pub fn fresh_guides(guides: &[V], data: &Data) {
	let mut by_id: FxHashMap<String, &V> = FxHashMap::default();
	for g in guides {
		by_id.entry(id_of(g)).or_insert(g);
	}
	let mut preds: FxHashMap<String, Vec<String>> = FxHashMap::default();
	for g in guides {
		if !leveling(g) {
			continue;
		}
		for to in next_ids(g) {
			let list = preds.entry(to).or_default();
			let id = id_of(g);
			if !list.contains(&id) {
				list.push(id);
			}
		}
	}
	for g in guides {
		if !leveling(g) {
			continue;
		}
		if let Some(f) = fresh_of(g, &by_id, &preds, data) {
			g.set("fresh", V::Obj(f));
		}
	}
}

fn fresh_of(g: &V, by_id: &FxHashMap<String, &V>, preds: &FxHashMap<String, Vec<String>>, data: &Data) -> Option<Obj> {
	// The earlier guides, nearest first (breadth first, in the route's order), and the nearest that takes each quest.
	let mut taken: FxHashMap<i64, (usize, usize)> = FxHashMap::default(); // quest -> (distance, order of the guide)
	let mut earlier: Vec<String> = Vec::new();
	let mut seen: FxHashSet<String> = FxHashSet::default();
	seen.insert(id_of(g));
	let mut frontier = vec![id_of(g)];
	for d in 1..=FRESH_BACK {
		let mut further = Vec::new();
		for id in &frontier {
			for from in preds.get(id).map(|v| v.as_slice()).unwrap_or(&[]) {
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
								taken.entry(q).or_insert((d, order));
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
	// G's own accepts, in route order, and what each depends on (earlier-guide quests -> the guide's order).
	let mut own: FxHashSet<i64> = FxHashSet::default();
	let mut dep: FxHashMap<i64, Vec<i64>> = FxHashMap::default(); // a quest of G -> the earlier quests it hinges on
	let mut total = 0.0;
	let mut by_need: FxHashMap<i64, f64> = FxHashMap::default();
	let mut done_turnin: FxHashSet<i64> = FxHashSet::default();
	for step in g.get("steps").items() {
		for goal in step.get("goals").items() {
			let Some(q) = quest_id(&goal.get("quest")) else { continue };
			match goal.get("t").as_str() {
				Some("accept") => {
					if own.contains(&q) {
						continue;
					}
					let mut needs: Vec<i64> = Vec::new();
					for p in pres(&goal) {
						if own.contains(&p) {
							for n in dep.get(&p).cloned().unwrap_or_default() {
								if !needs.contains(&n) {
									needs.push(n);
								}
							}
						} else if taken.contains_key(&p) && !needs.contains(&p) {
							needs.push(p);
						}
					}
					own.insert(q);
					if !needs.is_empty() {
						dep.insert(q, needs);
					}
				}
				Some("turnin") => {
					if !done_turnin.insert(q) {
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
	if total <= 0.0 || dependent <= 0.0 {
		return None;
	}
	let share = (dependent * 100.0 / total).round();
	if share < FRESH_MIN {
		return None;
	}
	// The earlier guide holding the most dependent XP.
	let mut per_guide: Vec<f64> = vec![0.0; earlier.len()];
	for (n, xp) in &by_need {
		if let Some((_, order)) = taken.get(n) {
			per_guide[*order] += xp;
		}
	}
	// Ties: the nearer guide, then the route's order (the breadth-first order).
	let mut best = 0;
	for (i, xp) in per_guide.iter().enumerate() {
		if *xp > per_guide[best] {
			best = i;
		}
	}
	let mut needs: Vec<(i64, f64)> = by_need.into_iter().collect();
	needs.sort_by(|a, b| b.1.partial_cmp(&a.1).unwrap_or(std::cmp::Ordering::Equal).then(a.0.cmp(&b.0)));
	needs.truncate(FRESH_NEEDS);
	let out = Obj::new();
	out.set("from", earlier[best].as_str());
	out.set("share", share);
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

	// A (Elwynn) takes 1 and 2; B (Westfall, after A) hands in 1 (carried, 1,000 XP), takes 3 needing 2 and hands
	// it in (500), takes and hands in 4 on its own (500). 1,500 of 2,000 XP (75%) hinge on A's quests.
	#[test]
	fn a_guide_s_quest_xp_that_hinges_on_an_earlier_guide_is_its_fresh_share() {
		let a = guide(r#"{ "id": "t/a", "next": "t/b", "steps": [ { "goals": [ { "t": "accept", "quest": 1 }, { "t": "accept", "quest": 2 } ] } ] }"#);
		let b = guide(
			r#"{ "id": "t/b", "steps": [ { "goals": [
				{ "t": "turnin", "quest": 1, "rewards": { "xp": 1000 } },
				{ "t": "accept", "quest": 3, "pre": [2] }, { "t": "turnin", "quest": 3, "rewards": { "xp": 500 } },
				{ "t": "accept", "quest": 4 }, { "t": "turnin", "quest": 4, "rewards": { "xp": 500 } } ] } ] }"#,
		);
		let data = Data::empty();
		fresh_guides(&[a.clone(), b.clone()], &data);
		assert!(a.get("fresh").is_undef());
		let f = b.get("fresh");
		assert_eq!(f.get("from").as_str(), Some("t/a"));
		assert_eq!(f.get("share").num(), 75.0);
		assert_eq!(f.get("xp").num(), 2000.0);
		assert_eq!(f.get("needs").items().iter().map(|v| v.num()).collect::<Vec<_>>(), vec![1.0, 2.0]);
	}

	// Under FRESH_MIN percent, no field.
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
}
