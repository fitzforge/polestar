//! Talk objectives the quest data lists as kills. QuestieDB lists a quest done by talking to an
//! NPC (hearing a story, asking for advice, showing an item) as a creature objective of that NPC,
//! the same as a kill, and the Classic server's database gives it no creature count: the server
//! completes it by an event once the talk is over. A kill objective is a talk when:
//! - no source knows how many of the NPC it wants (a kill objective has its count);
//! - its NPC is friendly to every side that can take the quest (nobody taking it can fight it);
//! - the quest's own objective text asks for no fight (defeat, subdue, beat, duel: NPCs that turn
//!   hostile and give in), no item or spell used on the NPC, no emote, and no escort or defence
//!   (each worded as such, and each a different goal).
//!
//! Applied once every source has given its counts (after the knowledge base: a count it fills makes
//! the objective a server-counted credit, as Coming to Terms' Frightened Paladin), and never to a
//! quest whose objectives a correction sets: the correction has the last word (The True Masters'
//! Ragged John, #2543; The Smoldering Ruins of Thaurissan's historian, #2535).

use forge_guide::js::{Obj, V};

use crate::factions::{ALLIANCE_RACES, HORDE_RACES};

/// Words of an objective text that make it something other than a talk (a fight, a use, an
/// escort), matched as whole words, any case.
const NOT_TALK: &[&str] = &[
	"kill",
	"slay",
	"slain",
	"defeat",
	"subdue",
	"beat",
	"duel",
	"fight",
	"engage",
	"destroy",
	"attack",
	"use",
	"using",
	"apply",
	"throw",
	"toss",
	"capture",
	"heal",
	"resurrect",
	"place",
	"mark",
	"feed",
	"scare",
	"free",
	"summon",
	"tame",
	"perform",
	"emote",
	"escort",
	"accompany",
	"protect",
	"defend",
	"lead",
];

/// Skyborne's race bits above the 32-bit mask: 2^32 the High Order (Alliance), 2^33 the
/// Windshapers (Horde).
const HIGH: f64 = 4294967296.0;

/// The sides that can take a quest of race mask `races` ("A", "H"; both when unrestricted).
fn sides(races: &V) -> &'static str {
	let r = races.num();
	if !(r.is_finite() && r > 0.0) {
		return "AH";
	}
	let high = (r / HIGH).trunc() as i64;
	let low = (r - high as f64 * HIGH) as i64;
	let a = low & i64::from(ALLIANCE_RACES) != 0 || high & 1 != 0;
	let h = low & i64::from(HORDE_RACES) != 0 || high & 2 != 0;
	match (a, h) {
		(true, false) => "A",
		(false, true) => "H",
		_ => "AH",
	}
}

/// Whether `text` holds one of [`NOT_TALK`] as a whole word.
pub(crate) fn asks_other(text: &str) -> bool {
	text.split(|c: char| !(c.is_ascii_alphabetic() || c == '\'')).any(|w| NOT_TALK.iter().any(|n| w.eq_ignore_ascii_case(n)))
}

/// Retypes every kill objective of `quests` that is a talk (see the module) as `talk`, count 1,
/// except in the quests whose objectives `corrections` (the merged corrections) set.
/// -> the quests changed.
pub fn retype(quests: &Obj, npcs: &Obj, corrections: &V) -> Vec<String> {
	let mut changed = Vec::new();
	for (id, q) in quests.entries() {
		if corrections.get("quests").get(&id).get("set").has("objectives") {
			continue;
		}
		let text = q.get("objectiveText");
		if asks_other(text.as_str().unwrap_or("")) {
			continue;
		}
		let side = sides(&q.get("races"));
		let mut any = false;
		for o in q.get("objectives").items() {
			if o.get("type").as_str() != Some("kill") || !o.get("count").is_nullish() {
				continue;
			}
			let npc = npcs.get(&o.get("id").to_js_string());
			let faction = npc.get("faction");
			let friendly = faction.as_str().unwrap_or("");
			if friendly.is_empty() || !side.chars().all(|s| friendly.contains(s)) {
				continue;
			}
			o.set("type", "talk");
			o.set("count", 1.0);
			any = true;
		}
		if any {
			changed.push(id.to_string());
		}
	}
	changed
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_guide::js::{parse_json, stringify};

	fn run(quests: &str, npcs: &str) -> (Vec<String>, String) {
		let q = parse_json(quests).unwrap().as_obj().unwrap().clone();
		let n = parse_json(npcs).unwrap().as_obj().unwrap().clone();
		let changed = retype(&q, &n, &V::obj());
		(changed, stringify(&V::Obj(q), None))
	}

	#[test]
	fn a_quest_whose_objectives_a_correction_sets_is_left_to_it() {
		let corrections = parse_json(r#"{"quests":{"4224":{"set":{"objectives":[{"type":"kill","id":9563,"count":1}]}}}}"#).unwrap();
		let q = parse_json(r#"{"4224":{"races":0,"objectiveText":"Speak with Ragged John.","objectives":[{"type":"kill","id":9563,"count":null}]}}"#).unwrap().as_obj().unwrap().clone();
		let n = parse_json(r#"{"9563":{"faction":"AH"}}"#).unwrap().as_obj().unwrap().clone();
		assert!(retype(&q, &n, &corrections).is_empty());
	}

	#[test]
	fn a_story_from_a_friendly_npc_is_a_talk() {
		// The True Masters (4224, #2543): Ragged John, friendly to both sides, tells his story.
		let (changed, out) = run(
			r#"{"4224":{"races":4294967373,"objectiveText":"Speak with Ragged John to learn of Marshal Windsor's fate and return to Marshal Maxwell when you have completed this task.","objectives":[{"type":"kill","id":9563,"count":null,"text":"Ragged John"}]}}"#,
			r#"{"9563":{"name":"Ragged John","faction":"AH"}}"#,
		);
		assert_eq!(changed, vec!["4224"]);
		assert!(out.contains(r#"{"type":"talk","id":9563,"count":1,"text":"Ragged John"}"#), "{out}");
	}

	#[test]
	fn an_npc_friendly_to_the_taker_only() {
		// The Smoldering Ruins of Thaurissan (3702, #2535): an Alliance quest, an Alliance historian.
		let (changed, _) = run(
			r#"{"3702":{"races":4294967373,"objectiveText":"Listen to Royal Historian Archesonus recant the history of Thaurissan.","objectives":[{"type":"kill","id":8879,"count":null}]}}"#,
			r#"{"8879":{"faction":"A"}}"#,
		);
		assert_eq!(changed, vec!["3702"]);
		// A Horde quest's kill of an Alliance NPC stays a kill.
		let (changed, _) = run(
			r#"{"1":{"races":8589934770,"objectiveText":"Slay him.","objectives":[{"type":"kill","id":8879,"count":null}]},"2":{"races":8589934770,"objectiveText":"Find him.","objectives":[{"type":"kill","id":8879,"count":null}]}}"#,
			r#"{"8879":{"faction":"A"}}"#,
		);
		assert!(changed.is_empty());
		// A quest both sides take keeps the kill of an NPC only one side is friendly with.
		let (changed, _) = run(r#"{"1":{"races":0,"objectiveText":"Find him.","objectives":[{"type":"kill","id":8879,"count":null}]}}"#, r#"{"8879":{"faction":"A"}}"#);
		assert!(changed.is_empty());
	}

	#[test]
	fn kills_fights_uses_and_escorts_stay() {
		let npcs = r#"{"1":{"faction":"AH"},"2":{}}"#;
		for text in [
			"Defeat Calvin Montague in Deathknell.",
			"Beat Bartleby, then talk to him.",
			"Use the Frostwolf Muzzle when you are near it.",
			"Defend Gor'shak.",
			"Perform the Shattered Salute on Shenthul.",
		] {
			let (changed, _) = run(&format!(r#"{{"5":{{"objectiveText":"{text}","objectives":[{{"type":"kill","id":1,"count":null}}]}}}}"#), npcs);
			assert!(changed.is_empty(), "{text}");
		}
		// A known count (a server-counted credit), or an NPC no side is friendly with: a kill.
		let (changed, _) = run(r#"{"5":{"objectiveText":"Speak.","objectives":[{"type":"kill","id":1,"count":1},{"type":"kill","id":2,"count":null}]}}"#, npcs);
		assert!(changed.is_empty());
	}

	#[test]
	fn sides_of_race_masks() {
		assert_eq!(sides(&V::Num(4294967373.0)), "A");
		assert_eq!(sides(&V::Num(8589934770.0)), "H");
		assert_eq!(sides(&V::Num(0.0)), "AH");
		assert_eq!(sides(&V::Null), "AH");
		assert_eq!(sides(&V::Num(2.0)), "H");
		assert_eq!(sides(&V::Num(1.0 + 2.0)), "AH");
	}
}
