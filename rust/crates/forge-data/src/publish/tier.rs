//! The public tier's value selection over the KB's facts: a value is published only when an
//! independent source holds it. The KB winner is kept when it is independently held; otherwise
//! the independent alternative of the best tier is published; otherwise the field is cut.
//! A correction counts only when another independent source holds the same value.
//!
//! The KB's check-only sources (cmangos, tdb.inherited, eg.objectives) never win; a fact whose
//! usable values are all check-only has no facts row, only alternatives, which are candidates.

use rustc_hash::FxHashMap;

use super::inputs::{Factoruide, Kb};

/// KB source labels that always count as independent support.
const ALWAYS: &[&str] = &["recorder", "tdb", "tdb.inherited", "eg", "eg.observed", "eg.objectives", "questie", "factoruide.collector", "pfquest", "cmangos", "client", "client.cache"];

/// Labels the sidecar may name as independent support (the guard's view; Factoruide rows are
/// only written there when they passed the split).
pub fn independent_label(l: &str) -> bool {
	ALWAYS.contains(&l) || l == "factoruide"
}

pub struct Ctx<'a> {
	pub kb: &'a Kb,
	/// Factoruide's own row sources, for a KB without the `factoruide.web` split.
	pub factoruide: Option<&'a Factoruide>,
}

pub enum Pick {
	Keep {
		value: String,
		sources: Vec<String>,
		confidence: String,
	},
	/// No independent source holds any value: the winner (if any) and every source seen.
	Cut {
		value: String,
		sources: Vec<String>,
	},
}

impl Ctx<'_> {
	fn independent(&self, label: &str, kind: &str, id: i64, field: &str) -> bool {
		match label {
			"factoruide" => self.kb.factoruide_split || self.factoruide.is_some_and(|f| f.ok(kind, id, field)),
			l => ALWAYS.contains(&l),
		}
	}

	fn tier(&self, label: &str) -> f64 {
		self.kb.tiers.get(label).copied().unwrap_or(9.0)
	}

	/// The value to publish for one fact; `source` is empty when the KB has no facts row (only
	/// check-only alternatives).
	pub fn pick(&self, kind: &str, id: i64, field: &str, value: &str, source: &str, confidence: &str) -> Pick {
		// value -> labels holding it; the winner first.
		let mut groups: Vec<(String, Vec<String>)> = Vec::new();
		let mut at: FxHashMap<String, usize> = FxHashMap::default();
		let has_winner = !source.is_empty();
		if has_winner {
			groups.push((value.to_string(), vec![source.to_string()]));
			at.insert(value.to_string(), 0);
		}
		for a in self.kb.alts.get(&(kind.to_string(), id, field.to_string())).into_iter().flatten() {
			let v = if a.agrees && has_winner { value.to_string() } else { a.value.clone() };
			let i = *at.entry(v.clone()).or_insert_with(|| {
				groups.push((v, Vec::new()));
				groups.len() - 1
			});
			if !groups[i].1.contains(&a.source) {
				groups[i].1.push(a.source.clone());
			}
		}
		let mut best: Option<(usize, f64, Vec<String>)> = None;
		for (i, (_, labels)) in groups.iter().enumerate() {
			let ind: Vec<String> = labels.iter().filter(|l| self.independent(l, kind, id, field)).cloned().collect();
			if ind.is_empty() {
				continue;
			}
			// A backed correction is named too (it set the value; others confirm it).
			let mut sources = ind.clone();
			if labels.iter().any(|l| l == "correction") {
				sources.insert(0, "correction".into());
			}
			let t = ind.iter().map(|l| self.tier(l)).fold(f64::INFINITY, f64::min);
			if i == 0 && has_winner {
				best = Some((0, t, sources));
				break;
			}
			if best.as_ref().is_none_or(|b| t < b.1 || (t == b.1 && groups[i].0 < groups[b.0].0)) {
				best = Some((i, t, sources));
			}
		}
		match best {
			Some((i, _, sources)) => {
				let winner = i == 0 && has_winner;
				let conf = if !winner {
					"medium".to_string()
				} else if sources.iter().any(|s| s == "recorder" || s == "correction") {
					"high".to_string()
				} else {
					confidence.to_string()
				};
				Pick::Keep { value: groups[i].0.clone(), sources, confidence: conf }
			}
			None => Pick::Cut { value: value.to_string(), sources: groups.iter().flat_map(|g| g.1.iter().cloned()).collect() },
		}
	}
}
