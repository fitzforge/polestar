//! Port of tools/lib/dsl/escort.js.
//! Escort quests (docs/GUIDE_FORMAT.md, "Escort quests"): the compiled `escort` of a goal, and on its accept
//! what players' recordings say of it (`escortSecs`, `escortFail`, #3439).

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

/// An escort's accept: (`escortSecs`, `escortFail`) from data/recorded/escorts.json's trusted fact for its
/// quest (`forge record learn`): the median seconds a completed run takes, and the share of runs that failed.
/// Undef each without one (another goal, no recordings, too few players).
pub fn recorded_of(goal: &V, data: &Data) -> (V, V) {
	if goal.get("t").as_str() != Some("accept") || !goal.get("escort").truthy() {
		return (V::Undef, V::Undef);
	}
	let f = data.escorts.get(&goal.get("quest").to_js_string());
	if f.get("status").as_str() != Some("trusted") {
		return (V::Undef, V::Undef);
	}
	let secs = f.get("seconds").as_num().filter(|s| s.is_finite() && *s > 0.0).map_or(V::Undef, |s| V::from(s.round()));
	let fail = f.get("failed").as_num().filter(|s| s.is_finite() && (0.0..=1.0).contains(s)).map_or(V::Undef, V::from);
	(secs, fail)
}

/// A guide's escorts the player chooses to do or skip (#3439), as the engine reads its steps (Own.escortChoice):
/// each quest with a required (not `optional`) `accept` carrying `escort`, unless a step's `when` asks about it
/// already (`group <quest>` or `!group <quest>`: the author's own choice). -> (quest, the accept's title) in
/// step order, each quest once.
pub fn choice_quests(steps: &V) -> Vec<(V, V)> {
	let asked = |q: &V| steps.items().iter().any(|s| s.get("when").items().iter().any(|p| p.get("k").as_str() == Some("group") && p.get("q").strict_eq(q)));
	let mut out: Vec<(V, V)> = Vec::new();
	for step in steps.items() {
		for g in step.get("goals").items() {
			let q = g.get("quest");
			if g.get("t").as_str() == Some("accept") && g.get("escort").truthy() && !g.get("optional").truthy() && !q.is_undef() && !out.iter().any(|x| x.0.strict_eq(&q)) && !asked(&q) {
				out.push((q, g.get("title")));
			}
		}
	}
	out
}
