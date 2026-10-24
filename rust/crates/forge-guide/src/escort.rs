//! Port of tools/lib/dsl/escort.js.
//! Escort quests (docs/GUIDE_FORMAT.md, "Escort quests"): the compiled `escort` of a goal.

use crate::data::Data;
use crate::js::V;

/// `/escort/i.test(text)` for a string.
fn says(text: &V) -> bool {
	text.as_str().is_some_and(|t| t.to_ascii_lowercase().contains("escort"))
}

/// Whether a quests.json record is an escort quest.
pub fn is_escort(q: &V) -> bool {
	if !q.truthy() {
		return false;
	}
	if let V::Bool(b) = q.get("escort") {
		return b;
	}
	q.get("objectives").items().iter().any(|o| o.get("type").as_str() == Some("event") && says(&o.get("text"))) || says(&q.get("objectiveText"))
}

/// The goal's compiled `escort`: `true` or Undef.
pub fn escort_of(goal: &V, data: &Data) -> V {
	if goal.get("quest").is_undef() || goal.get("t").as_str() == Some("turnin") {
		return V::Undef;
	}
	if is_escort(&data.quest(&goal.get("quest"))) {
		V::Bool(true)
	} else {
		V::Undef
	}
}
