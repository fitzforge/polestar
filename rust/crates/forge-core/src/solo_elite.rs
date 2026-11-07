//! Elite quests players finish alone (Fitz, 2026-11-07: a quest players do, the guides do). A quest
//! with elite work is group work (forge_world::Rules: asked with `when group`, or optional with the
//! "grouping up" tip), unless players' recordings show it done solo at about the
//! level the route gets there. The evidence is a route fixes record, `deliberate.solo` in
//! data/route-fixes.json: `{ q, solo: [levels], group: [levels], why }`, one level per character that
//! handed the quest in alone (`solo`) or in a party (`group`). Recorder 0.3.3+ writes the party size;
//! an older recording reads alone when the elite kill's XP is a solo player's and grouped under 60% of
//! it. The planner, the writer and lint read the same records:
//!
//! - the planner takes a qualified quest like any solo quest (no group family, no solo fallback);
//! - the writer writes its goals for everyone, required, where the route's level there qualifies;
//! - lint lets a Leveling guide's required goal on it be elite work.
//!
//! A record qualifies at a visit of level L with [`SOLO_RUNS`] or more solo hand-ins at L +
//! [`SOLO_ABOVE`] or lower (players at or below about that level did it alone), and no more party
//! hand-ins than solo ones at those levels (most players there did not need help).

use rustc_hash::FxHashMap;
use serde_json::Value;

/// Solo hand-ins (different characters) a quest needs to be written for everyone.
pub const SOLO_RUNS: usize = 2;
/// Levels a hand-in may be above the route's level at the quest and still count.
pub const SOLO_ABOVE: f64 = 2.0;

/// A record's hand-in levels: alone, and in a party.
#[derive(Clone, Debug, Default, PartialEq)]
pub struct Runs {
	pub solo: Vec<f64>,
	pub group: Vec<f64>,
}

impl Runs {
	/// Whether these hand-ins let the quest be written for everyone at a visit of level `visit`
	/// (None: any visit, every hand-in counts).
	pub fn qualifies(&self, visit: Option<f64>) -> bool {
		let n = |v: &[f64]| v.iter().filter(|&&l| visit.is_none_or(|x| l <= x + SOLO_ABOVE)).count();
		let (solo, group) = (n(&self.solo), n(&self.group));
		solo >= SOLO_RUNS && solo >= group
	}
}

/// The `deliberate.solo` records of a route fixes document, by quest.
pub fn records(doc: &Value) -> FxHashMap<u32, Runs> {
	let levels = |v: &Value| v.as_array().into_iter().flatten().filter_map(Value::as_f64).collect::<Vec<f64>>();
	doc["deliberate"]["solo"].as_array().into_iter().flatten().filter_map(|r| Some((u32::try_from(r["q"].as_u64()?).ok()?, Runs { solo: levels(&r["solo"]), group: levels(&r["group"]) }))).collect()
}

/// The records that qualify at some visit (planner and lint).
pub fn qualified(doc: &Value) -> FxHashMap<u32, Runs> {
	records(doc).into_iter().filter(|(_, r)| r.qualifies(None)).collect()
}

/// [`qualified`] of a route fixes file's bytes (none when they are not JSON).
pub fn qualified_in(bytes: &[u8]) -> FxHashMap<u32, Runs> {
	serde_json::from_slice::<Value>(bytes).map(|doc| qualified(&doc)).unwrap_or_default()
}

#[cfg(test)]
mod tests {
	use super::*;
	use serde_json::json;

	#[test]
	fn two_solo_hand_ins_at_about_the_visits_level_qualify_unless_most_grouped() {
		let doc = json!({ "deliberate": { "solo": [
			{ "q": 1, "solo": [11, 12], "why": "w" },
			{ "q": 19, "solo": [23], "why": "w" },
			{ "q": 176, "solo": [11, 12], "group": [11, 11, 13], "why": "w" }
		] }, "overrides": {} });
		let r = records(&doc);
		assert_eq!(r[&1], Runs { solo: vec![11.0, 12.0], group: vec![] });
		assert!(r[&1].qualifies(None));
		assert!(!r[&19].qualifies(None), "one hand-in is not enough");
		assert!(r[&1].qualifies(Some(10.0)), "11 and 12 are within two levels of 10");
		assert!(!r[&1].qualifies(Some(9.5)), "12 is 2.5 over");
		assert!(!r[&176].qualifies(None), "three of five players grouped");
		assert!(r[&176].qualifies(Some(10.0)), "at 10, the party at 13 is past the window: two alone, two grouped");
		assert_eq!(qualified(&doc).keys().copied().collect::<Vec<_>>(), [1]);
		assert!(records(&json!({})).is_empty());
	}
}
