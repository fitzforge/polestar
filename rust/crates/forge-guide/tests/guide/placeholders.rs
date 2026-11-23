//! The game's placeholder names (#2614): a goal never shows one. A `kill` on a credit target is read by its
//! quest-log line (`logLine`) and named by the name the placeholder carries or its objective's words; a
//! `complete`'s `objs` leave a placeholder's text out; lint fails on any left in what a goal shows.

use crate::common::*;
use forge_guide::data::Data;
use serde_json::{json, Map, Value};

/// The fixture data plus Elwynn stand-ins for the shapes the game's data has: Alterac Valley's graveyard credit
/// (95060) for a quest whose objective has its own words (95400), a Riverglades "[DNT] Kill Credit" that carries
/// a creature's name (95061, quest 95401), a bare one (95062) whose quest has only the placeholder's text
/// (95402), and a moonwell's "(DND)" spell focus (95063) that drops an item (95120).
fn data() -> Data {
	let mut t: Map<String, Value> = tables().into_iter().filter(|(k, _)| ["quests", "npcs", "objects", "items", "zones", "map-frames", "meta"].contains(&k.as_str())).collect();
	let one = |x: f64, y: f64| json!({ "1429": { "f": "e", "pts": [[x, y]] } });
	let npcs = t.get_mut("npcs").unwrap();
	npcs["95060"] = json!({ "id": 95060, "name": "PvP Graveyard Credit Marker", "level": 1, "faction": "AH", "spawns": one(40.0, 40.0) });
	npcs["95061"] = json!({ "id": 95061, "name": "[DNT] Kill Credit: Twilight Thrall", "level": 1, "faction": null, "spawns": one(41.0, 41.0) });
	npcs["95062"] = json!({ "id": 95062, "name": "[DNT] Kill Credit", "level": 1, "faction": null, "spawns": one(42.0, 42.0) });
	let quest = |id: u32, title: &str, objectives: Value| {
		json!({ "id": id, "title": title, "level": 5, "minLevel": 1, "races": null, "classes": null, "start": { "npc": [197], "object": [], "item": [] },
			"end": { "npc": [197], "object": [] }, "pre": [], "excl": [], "next": null, "objectiveText": "", "objectives": objectives, "xp": 100, "zone": 1429 })
	};
	let quests = t.get_mut("quests").unwrap();
	quests["95400"] = quest(95400, "Graveyards", json!([{ "type": "event", "id": null, "count": 1, "text": "Graveyard Assaulted" }]));
	quests["95401"] = quest(95401, "A Small Favor", json!([{ "type": "kill", "id": 95061, "count": 1, "text": "[DNT] Kill Credit: Twilight Thrall" }]));
	quests["95402"] = quest(95402, "No Soldier Left Behind", json!([{ "type": "kill", "id": 95062, "count": 5, "text": "[DNT] Kill Credit" }]));
	t.get_mut("objects").unwrap()["95063"] = json!({ "id": 95063, "name": "Corrupted Moonwell Spell Focus (DND)", "spawns": one(43.0, 43.0) });
	t.get_mut("items").unwrap()["95120"] = json!({ "id": 95120, "name": "Filled Flasket", "drops": { "npc": {}, "object": { "95063": 100 } }, "vendors": [] });
	data_from(&t, Value::Null, Value::Null)
}

fn compiled(lines: &[&str]) -> Compiled {
	let mut l = vec!["step One", "  accept 95400", "  accept 95401", "  accept 95402"];
	l.extend_from_slice(lines);
	compile_with(&guide_text(&l), &data())
}

fn last_goal(r: &Compiled) -> Value {
	r.steps()[0]["goals"].as_array().unwrap().last().unwrap().clone()
}

#[test]
fn a_kill_on_a_credit_target_is_read_by_its_quest_log_line_never_by_the_placeholders_name() {
	// Alterac Valley's "kill 13756 quest 7081.1": "Graveyard Assaulted", placed at the credit's spawn.
	let r = compiled(&["  kill 95060 quest 95400.1"]);
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = last_goal(&r);
	assert_eq!(json!([g["t"], g["target"], g["logLine"], g.get("npc"), g["x"], g["y"]]), json!(["kill", "Graveyard Assaulted", true, null, 40, 40]), "{g}");
	// A placeholder that carries a name: that name.
	let g = last_goal(&compiled(&["  kill 95061 quest 95401.1"]));
	assert_eq!(json!([g["target"], g["logLine"], g.get("npc")]), json!(["Twilight Thrall", true, null]), "{g}");
	// Neither: the goal's note, the step's words.
	let g = last_goal(&compiled(&["  kill 95062 quest 95402.1 -- free five captive scouts"]));
	assert_eq!(json!([g["target"], g["logLine"]]), json!(["free five captive scouts", true]), "{g}");
	// Nothing at all names it: an error.
	let r = compiled(&["  kill 95062 quest 95402.1"]);
	assert!(r.errors.iter().any(|e| e.contains("placeholder") && e.contains("[DNT] Kill Credit")), "{}", r.text);
	// A real target is untouched.
	let g = last_goal(&compiled(&["  kill 6 quest 7.1"]));
	assert_eq!(json!([g["target"], g.get("logLine"), g["npc"]]), json!(["Kobold Vermin", null, 6]), "{g}");
}

#[test]
fn a_completes_objective_lines_leave_a_placeholders_text_out() {
	let g = last_goal(&compiled(&["  complete 95401 @41,41"]));
	assert_eq!(g["objs"], json!([{ "text": "Twilight Thrall", "count": 1 }]), "{g}");
	let g = last_goal(&compiled(&["  complete 95402 @42,42 -- free five captive scouts"]));
	assert!(g.get("objs").is_none(), "{g}");
}

#[test]
fn lint_fails_on_a_placeholder_name_a_goal_shows() {
	let r = compiled(&["  collect 95120 quest 95401"]);
	assert!(r.errors.iter().any(|e| e.contains("placeholder name \"Corrupted Moonwell Spell Focus (DND)\" (from)")), "the (DND) object named as the item's source: {}", r.text);
}
