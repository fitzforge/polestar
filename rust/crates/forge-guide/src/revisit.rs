//! Second visits (#2635): a leveling guide that comes back to a zone an earlier guide of the route already
//! worked can hold accepts whose prerequisite only that earlier visit brings (Test of Endurance 1150 on the
//! 30-33 Thousand Needles visit needs Test of Faith 1149, done on the 27-29 visit). A character who starts
//! the route between the two visits never sees them: the game does not offer the quest.
//!
//! [`second_visits`] lists those accepts: an accept of guide G (not `optional`) with a prerequisite (each of
//! `preAll`, or one of `pre` when G brings none of them) that G does not bring before it (accept and hand in,
//! or hand in `direct`) and that an earlier leveling guide of the route (through `next` and every route
//! choice, any number of guides back) accepts on the same map as G's accept. Prerequisites an earlier guide
//! takes elsewhere are not a second visit (the guide's `fresh` header and the guide window's "left out"
//! reasons cover them).
//!
//! [`check_second_visits`] is `forge guide lint`'s rule for Polestar's own guides: each case has either a
//! catch-up (G brings the prerequisite itself before the accept, in steps `when !turnedin <last quest of the
//! chain>` so characters who did the first visit see none of it; then it is not a case) or a `leftout` record
//! in data/route-fixes.json naming the guide and the quest with the reason it stays out (too slow, too far,
//! too little XP). A case with neither is an error; a record naming no case is a warning.

use rustc_hash::{FxHashMap, FxHashSet};

use crate::diag::Diagnostics;
use crate::js::V;

/// One accept that hinges on an earlier visit to the zone.
#[derive(Debug, Clone, PartialEq)]
pub struct SecondVisit {
	/// The guide with the accept.
	pub guide: String,
	pub file: String,
	pub line: f64,
	/// The accept's quest and title.
	pub quest: i64,
	pub title: String,
	/// The map (uiMap) of the accept.
	pub map: i64,
	/// The prerequisites only the earlier visit brings, with the nearest earlier guide that accepts each.
	pub needs: Vec<(i64, String)>,
}

fn id_of(g: &V) -> String {
	g.get("id").to_js_string()
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

fn map_of(goal: &V) -> Option<i64> {
	quest_id(&goal.get("map"))
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

/// Every second-visit accept of the leveling guides in `guides`, in the guides' order.
pub fn second_visits(guides: &[V]) -> Vec<SecondVisit> {
	let mut by_id: FxHashMap<String, &V> = FxHashMap::default();
	for g in guides.iter().filter(|g| leveling(g)) {
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
	let mut out = Vec::new();
	for g in guides.iter().filter(|g| leveling(g)) {
		out.extend(of_guide(g, &by_id, &preds));
	}
	out
}

fn of_guide(g: &V, by_id: &FxHashMap<String, &V>, preds: &FxHashMap<String, Vec<String>>) -> Vec<SecondVisit> {
	// Each quest the earlier guides accept -> the nearest such guide (breadth first) and the maps it takes it on.
	let mut earlier: FxHashMap<i64, (String, Vec<i64>)> = FxHashMap::default();
	let mut seen: FxHashSet<String> = FxHashSet::default();
	seen.insert(id_of(g));
	let mut frontier = vec![id_of(g)];
	while !frontier.is_empty() {
		let mut further = Vec::new();
		for id in &frontier {
			for from in preds.get(id).map(Vec::as_slice).unwrap_or_default() {
				if !seen.insert(from.clone()) {
					continue;
				}
				let Some(fg) = by_id.get(from) else { continue };
				further.push(from.clone());
				let mut here: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
				for step in fg.get("steps").items() {
					for goal in step.get("goals").items() {
						if goal.get("t").as_str() != Some("accept") {
							continue;
						}
						if let Some(q) = quest_id(&goal.get("quest")) {
							let maps = here.entry(q).or_default();
							if let Some(m) = map_of(&goal) {
								maps.push(m);
							}
						}
					}
				}
				for (q, maps) in here {
					earlier.entry(q).or_insert((from.clone(), maps));
				}
			}
		}
		frontier = further;
	}
	if earlier.is_empty() {
		return Vec::new();
	}
	let file = g.hidden("_ast").get("file").to_js_string();
	// Quests G accepts, and those it brings (accepted and handed in, or handed in `direct`), so far.
	let mut accepted: FxHashSet<i64> = FxHashSet::default();
	let mut brought: FxHashSet<i64> = FxHashSet::default();
	let mut checked: FxHashSet<i64> = FxHashSet::default();
	let mut out = Vec::new();
	for step in g.get("steps").items() {
		for goal in step.get("goals").items() {
			let Some(q) = quest_id(&goal.get("quest")) else { continue };
			match goal.get("t").as_str() {
				Some("accept") => {
					accepted.insert(q);
					if goal.get("optional").truthy() || !checked.insert(q) {
						continue;
					}
					let Some(map) = map_of(&goal) else { continue };
					// Brought by the earlier visit to this map: an earlier guide accepts it here and G does not bring it.
					let from_visit = |p: i64| -> Option<(i64, String)> {
						if brought.contains(&p) {
							return None;
						}
						let (from, maps) = earlier.get(&p)?;
						maps.contains(&map).then(|| (p, from.clone()))
					};
					let mut needs: Vec<(i64, String)> = ids(&goal.get("preAll")).into_iter().filter_map(from_visit).collect();
					let any = ids(&goal.get("pre"));
					if !any.iter().any(|p| brought.contains(p)) {
						if let Some(n) = any.iter().find_map(|p| from_visit(*p)) {
							needs.push(n);
						}
					}
					if !needs.is_empty() {
						out.push(SecondVisit { guide: id_of(g), file: file.clone(), line: goal.hidden("_line").num(), quest: q, title: goal.get("title").to_js_string(), map, needs });
					}
				}
				Some("turnin") if accepted.contains(&q) || goal.get("direct").truthy() => {
					brought.insert(q);
				}
				_ => {}
			}
		}
	}
	out
}

/// `forge guide lint`'s second-visit rule (see the module's notes). `leftout`: data/route-fixes.json's
/// `overrides.leftout`, a list of `{ q, guide, reason, issue }`.
pub fn check_second_visits(guides: &[V], leftout: &V, diag: &mut Diagnostics) {
	let records: Vec<(String, i64)> = leftout.items().iter().filter_map(|e| Some((e.get("guide").to_js_string(), quest_id(&e.get("q"))?))).collect();
	let cases = second_visits(guides);
	let title = |guides: &[V], q: i64| -> String {
		for g in guides {
			for step in g.get("steps").items() {
				for goal in step.get("goals").items() {
					if quest_id(&goal.get("quest")) == Some(q) && goal.get("title").truthy() {
						return format!("{q} ({})", goal.get("title").to_js_string());
					}
				}
			}
		}
		q.to_string()
	};
	for c in &cases {
		if records.iter().any(|(g, q)| *g == c.guide && *q == c.quest) {
			continue;
		}
		let needs: Vec<String> = c.needs.iter().map(|(p, from)| format!("{} from \"{from}\"", title(guides, *p))).collect();
		diag.error(
			&c.file,
			c.line,
			format!(
				"quest {} ({}) needs {} first, which only an earlier visit to this zone brings: a character who starts the route after that visit never sees it",
				c.quest,
				c.title,
				needs.join(" and ")
			),
			Some(format!(
				"bring the prerequisite back before it for characters without it (steps `when !turnedin <the chain's last quest>`, as in forever/horde/30-40/01-hillsbrad-foothills), or record why it stays out in data/route-fixes.json overrides.leftout ({{ \"q\": {}, \"guide\": \"{}\", \"reason\": … }})",
				c.quest, c.guide
			)),
		);
	}
	// A record whose guide is in this compile but holds no such case any more.
	let compiled: FxHashMap<String, String> = guides.iter().map(|g| (id_of(g), g.hidden("_ast").get("file").to_js_string())).collect();
	for (g, q) in &records {
		let Some(file) = compiled.get(g) else { continue };
		if !cases.iter().any(|c| c.guide == *g && c.quest == *q) {
			diag.warn(
				file,
				0.0,
				format!("data/route-fixes.json overrides.leftout names quest {q} in \"{g}\", but no accept of it there waits on an earlier visit to the zone"),
				Some("drop the record".into()),
			);
		}
	}
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::js::parse_json;

	fn guide(json: &str) -> V {
		parse_json(json).expect("json")
	}

	fn needs(c: &SecondVisit) -> Vec<i64> {
		c.needs.iter().map(|(p, _)| *p).collect()
	}

	// A works Thousand Needles (map 1441) and takes 1 and 2 there and 3 in Ashenvale (1440); B, two guides on,
	// comes back to 1441: 10 needs 1 (a case), 11 needs 3 (taken elsewhere: not a second visit), 12 needs 2,
	// which B brings itself first (a catch-up), 13 needs 1 or 4, and B brings 4. An `optional` accept is not
	// checked.
	#[test]
	fn an_accept_needing_a_quest_only_the_earlier_visit_to_the_map_brings_is_a_second_visit_case() {
		let a = guide(
			r#"{ "id": "t/a", "next": "t/mid", "steps": [ { "goals": [
				{ "t": "accept", "quest": 1, "map": 1441 }, { "t": "accept", "quest": 2, "map": 1441 }, { "t": "accept", "quest": 3, "map": 1440 } ] } ] }"#,
		);
		let mid = guide(r#"{ "id": "t/mid", "next": "t/b", "steps": [ { "goals": [ { "t": "accept", "quest": 99, "map": 1424 } ] } ] }"#);
		let b = guide(
			r#"{ "id": "t/b", "steps": [ { "goals": [
				{ "t": "accept", "quest": 10, "title": "Ten", "map": 1441, "pre": [1] },
				{ "t": "accept", "quest": 11, "map": 1441, "pre": [3] },
				{ "t": "accept", "quest": 2, "map": 1441 }, { "t": "turnin", "quest": 2 },
				{ "t": "accept", "quest": 12, "map": 1441, "preAll": [2] },
				{ "t": "accept", "quest": 4, "map": 1441 }, { "t": "turnin", "quest": 4 },
				{ "t": "accept", "quest": 13, "map": 1441, "pre": [1, 4] },
				{ "t": "accept", "quest": 14, "map": 1441, "pre": [1], "optional": true } ] } ] }"#,
		);
		let cases = second_visits(&[a, mid, b]);
		assert_eq!(cases.iter().map(|c| c.quest).collect::<Vec<_>>(), vec![10]);
		assert_eq!(needs(&cases[0]), vec![1]);
		assert_eq!(cases[0].needs[0].1, "t/a", "the earlier guide that takes it");
		assert_eq!(cases[0].title, "Ten");
	}

	// A catch-up: B accepts and hands in 1 in steps `when !turnedin 1` before 10; and a prerequisite B accepts
	// only after the accept that needs it does not count.
	#[test]
	fn a_catch_up_before_the_accept_closes_the_case_and_one_after_it_does_not() {
		let a = guide(r#"{ "id": "t/a", "next": "t/b", "steps": [ { "goals": [ { "t": "accept", "quest": 1, "map": 1441 }, { "t": "accept", "quest": 5, "map": 1441 } ] } ] }"#);
		let b = guide(
			r#"{ "id": "t/b", "steps": [
				{ "when": [{ "k": "turnedin", "q": 1, "neg": true }], "goals": [ { "t": "accept", "quest": 1, "map": 1441 }, { "t": "turnin", "quest": 1 } ] },
				{ "goals": [ { "t": "accept", "quest": 10, "map": 1441, "pre": [1] }, { "t": "accept", "quest": 11, "map": 1441, "pre": [5] } ] },
				{ "goals": [ { "t": "accept", "quest": 5, "map": 1441 }, { "t": "turnin", "quest": 5 } ] } ] }"#,
		);
		let cases = second_visits(&[a, b]);
		assert_eq!(cases.iter().map(|c| c.quest).collect::<Vec<_>>(), vec![11]);
	}

	// Only leveling guides count, on either side.
	#[test]
	fn guides_other_than_leveling_are_not_visits() {
		let a = guide(r#"{ "id": "t/a", "category": "Class", "next": "t/b", "steps": [ { "goals": [ { "t": "accept", "quest": 1, "map": 1441 } ] } ] }"#);
		let b = guide(r#"{ "id": "t/b", "steps": [ { "goals": [ { "t": "accept", "quest": 10, "map": 1441, "pre": [1] } ] } ] }"#);
		assert!(second_visits(&[a, b]).is_empty());
	}

	// The lint: an error for a case with no record, nothing for one with a `leftout` record, a warning for a record
	// naming no case in a compiled guide; records for guides not in this compile are not judged.
	#[test]
	fn lint_errors_on_a_case_without_a_catch_up_or_a_leftout_record_and_warns_on_a_stale_record() {
		let a = guide(r#"{ "id": "t/a", "next": "t/b", "steps": [ { "goals": [ { "t": "accept", "quest": 1, "map": 1441, "title": "One" }, { "t": "accept", "quest": 2, "map": 1441 } ] } ] }"#);
		let b = guide(
			r#"{ "id": "t/b", "steps": [ { "goals": [ { "t": "accept", "quest": 10, "title": "Ten", "map": 1441, "pre": [1] }, { "t": "accept", "quest": 11, "title": "Eleven", "map": 1441, "pre": [2] } ] } ] }"#,
		);
		let leftout = guide(r#"[ { "q": 11, "guide": "t/b", "reason": "slow" }, { "q": 12, "guide": "t/b", "reason": "gone" }, { "q": 13, "guide": "t/elsewhere", "reason": "not compiled" } ]"#);
		let mut diag = Diagnostics::new();
		check_second_visits(&[a, b], &leftout, &mut diag);
		let got: Vec<String> = diag.list.iter().map(|d| format!("{}: {}", d.severity, d.message)).collect();
		assert_eq!(
			got,
			vec![
				"error: quest 10 (Ten) needs 1 (One) from \"t/a\" first, which only an earlier visit to this zone brings: a character who starts the route after that visit never sees it".to_string(),
				"warning: data/route-fixes.json overrides.leftout names quest 12 in \"t/b\", but no accept of it there waits on an earlier visit to the zone".to_string(),
			]
		);
	}
}
