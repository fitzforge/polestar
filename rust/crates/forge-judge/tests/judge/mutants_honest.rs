//! R6-R10 edge cases (src/honest/rules.rs) that cargo-mutants showed the unit and parity tests left open:
//! persona labels, the R6 mask arithmetic, the R7 objective matching, R8's reset, R9's peak and the
//! claim reader's word splitting.

use forge_guide::data::Data;
use forge_guide::diag::Diagnostics;
use forge_guide::js::V;
use forge_guide::project::{compile_sources, CompileOpts, Source};
use forge_judge::honest::rules::{claims, Claim};
use forge_judge::honest::{honest_play, Finding, Groups, HonestOpts, Persona, Severity};
use serde_json::json;

const HORDE_RACES: u64 = 2 | 16 | 32 | 128;
const ALL_CLASSES: u32 = 1 | 2 | 4 | 8 | 16 | 64 | 128 | 256 | 1024;

fn data() -> Data {
	let mut quests = serde_json::Map::new();
	let quest = |id: u32, title: &str, races: Option<u64>, classes: Option<u32>, objectives: serde_json::Value| {
		json!({
			"id": id, "title": title, "level": 3, "minLevel": 2, "races": races, "classes": classes,
			"start": { "npc": [1], "object": [], "item": [] }, "end": { "npc": [1], "object": [] },
			"pre": [], "excl": [], "next": null, "objectives": objectives, "objectiveText": "", "zone": 99101,
			"xp": 100, "skill": null, "event": null, "source": ["test"]
		})
	};
	let mut add = |id: u32, title: &str, races: Option<u64>, classes: Option<u32>, objectives: serde_json::Value| {
		quests.insert(id.to_string(), quest(id, title, races, classes, objectives));
	};
	add(501, "Rat Trouble", None, None, json!([{ "type": "kill", "id": 10, "count": 8 }]));
	add(502, "Fox Pelts", None, None, json!([{ "type": "item", "id": 100, "count": 5 }]));
	add(504, "Orcish Pride", Some(2), None, json!([]));
	add(505, "Orc Hunt", Some(2), None, json!([{ "type": "kill", "id": 10, "count": 8 }]));
	add(506, "Countless", None, None, json!([{ "type": "kill", "id": 10, "count": 0 }]));
	add(507, "Every Class", None, Some(ALL_CLASSES), json!([]));
	add(508, "Every Horde Race", Some(HORDE_RACES), None, json!([]));
	for id in 510..535 {
		add(id, &format!("Errand {id}"), None, None, json!([]));
	}
	let npcs = json!({
		"1": { "id": 1, "name": "Elder Testa", "level": 10, "faction": "AH", "spawns": { "99101": { "f": "e", "pts": [[50, 50]] } } },
		"10": { "id": 10, "name": "Burrow Rat", "level": 2, "faction": null, "spawns": { "99101": { "f": "e", "pts": [[20, 20], [21, 21]] } } },
		"11": { "id": 11, "name": "Red Fox", "level": 3, "faction": null, "spawns": { "99101": { "f": "e", "pts": [[30, 30]] } } },
		"100": { "id": 100, "name": "Pelt Beast", "level": 3, "faction": null, "spawns": { "99101": { "f": "e", "pts": [[31, 31]] } } }
	});
	let items = json!({
		"100": { "id": 100, "name": "Fox Pelt", "questItem": true, "drops": { "npc": { "11": 60, "100": 60 } } },
		"10": { "id": 10, "name": "Rat Tail", "questItem": true, "drops": { "npc": { "10": 60 } } }
	});
	let texts: rustc_hash::FxHashMap<String, String> = [
		("quests", serde_json::Value::Object(quests).to_string()),
		("npcs", npcs.to_string()),
		("objects", "{}".into()),
		("items", items.to_string()),
		("zones", r#"{"99101":{"id":99101,"name":"Testvale","areaId":null,"parent":null,"type":3}}"#.into()),
		("map-frames", r#"{"era":{"99101":{"c":1,"left":0,"right":-1000,"top":1000,"bottom":0}}}"#.into()),
		("meta", "{}".into()),
	]
	.into_iter()
	.map(|(k, v)| (k.to_string(), v))
	.collect();
	Data::from_texts(&texts, V::obj(), V::obj(), None).expect("data")
}

fn persona(race: &str, cls: &str) -> Persona {
	Persona { race: race.into(), faction: "Horde".into(), cls: cls.into() }
}

fn play_as(body: &str, who: Persona) -> Vec<Finding> {
	let data = data();
	let text = format!("guide forever/test/01-vale\ntitle Vale\nlevels 1-10\nzone Testvale\nfaction Horde\n\n{body}");
	let src = Source { source: "forever/test/01-vale.guide".into(), file: "01-vale.guide".into(), text };
	let mut diag = Diagnostics::new();
	let guides = compile_sources(&[src], &data, &mut diag, &CompileOpts { pack: None, author: None, context: None, pack_dir: None }).guides;
	assert_eq!(guides.len(), 1, "{:?}", diag.list);
	let list = vec![who];
	honest_play(&guides, &data, &move |_| list.clone(), None, None, &HonestOpts { legacy: false, groups: Groups::Skip, walk_far: true })
}

fn play(body: &str) -> Vec<Finding> {
	play_as(body, persona("Orc", "WARRIOR"))
}

fn rule(fs: &[Finding], r: &str) -> Vec<Finding> {
	fs.iter().filter(|f| f.rule == r).cloned().collect()
}

#[test]
fn r6_reason_names_the_persona() {
	let r6 = rule(&play_as("step Elder Testa\n  accept 504\n", persona("Troll", "WARRIOR")), "R6");
	assert_eq!(r6.len(), 1, "{r6:#?}");
	assert!(r6[0].reason.contains("closes it to Troll Warrior"), "{}", r6[0].reason);
	let r6 = rule(&play_as("step Elder Testa\n  accept 504\n", persona("Scourge", "WARRIOR")), "R6");
	assert!(r6[0].reason.contains("closes it to Undead Warrior"), "{}", r6[0].reason);
}

#[test]
fn r6_only_judges_accepts_turnins_and_completes() {
	// A kill for a quest the persona's race may not take is no R6 (only accept, turn-in, complete).
	let fs = play_as("step Rats\n  kill 10 x8 quest 505.1\n", persona("Troll", "WARRIOR"));
	assert!(rule(&fs, "R6").is_empty(), "{fs:#?}");
	// The `only` warning is for accepts: a gated turn-in of an open quest says nothing.
	let fs = play("step Elder Testa\n  accept 501\nstep Elder Testa\n  only Warrior\n  turnin 501\n");
	assert!(rule(&fs, "R6").is_empty(), "{fs:#?}");
}

#[test]
fn r6_only_warning_follows_the_masks() {
	// Class mask of every class: open to everyone, so `only Warrior` warns.
	let r6 = rule(&play("step Elder Testa\n  only Warrior\n  accept 507\n"), "R6");
	assert_eq!(r6.len(), 1, "{r6:#?}");
	assert_eq!(r6[0].severity, Severity::Warn);
	// Race mask of every Horde race: open, so `only Orc` warns.
	let r6 = rule(&play("step Elder Testa\n  only Orc\n  accept 508\n"), "R6");
	assert_eq!(r6.len(), 1, "{r6:#?}");
	assert!(r6[0].reason.contains("only Orc"), "{}", r6[0].reason);
	// Orc only in the data: the `only Orc` is the data's own gate.
	assert!(rule(&play("step Elder Testa\n  only Orc\n  accept 504\n"), "R6").is_empty());
}

#[test]
fn r7_objective_matching() {
	let around = |mid: &str| format!("step Elder Testa\n  accept 501\n  accept 502\nstep Field\n{mid}step Elder Testa\n  turnin 501\n  turnin 502\n");
	// A kill goal for another mob, or of the item quest's dropper, is no count of the objective.
	for mid in ["  kill 11 x3 quest 501.1\n", "  kill 100 x3 quest 502.1\n", "  collect 10 x3 quest 501.1\n"] {
		let r7 = rule(&play(&around(mid)), "R7");
		assert!(r7.is_empty(), "{mid}: {r7:#?}");
	}
	// A collect of the objective's item with fewer than asked: warn.
	let r7 = rule(&play(&around("  collect 100 x3 quest 502.1\n")), "R7");
	assert!(r7.iter().any(|f| f.severity == Severity::Warn && f.reason.contains("x3")), "{r7:#?}");
	// The item's name from the data names the objective.
	let r7 = rule(&play(&around("  tip Loot 4 Fox Pelts.\n  collect 100 x5 quest 502.1\n")), "R7");
	assert!(r7.iter().any(|f| f.severity == Severity::Fail && f.reason.contains("says 4")), "{r7:#?}");
	// The objective's last word names it ("rats" for Burrow Rat).
	let r7 = rule(&play(&around("  tip Kill 5 rats.\n  kill 10 x8 quest 501.1\n")), "R7");
	assert!(r7.iter().any(|f| f.reason.contains("says 5")), "{r7:#?}");
	// Words naming no objective of the step: no claim.
	assert!(rule(&play(&around("  tip Kill 3 foxes on the way.\n  kill 10 x8 quest 501.1\n")), "R7").is_empty());
	// Bare counts match any objective's count.
	assert!(rule(&play(&around("  tip Get x8.\n  kill 10 x8 quest 501.1\n")), "R7").is_empty());
	let r7 = rule(&play(&around("  tip Get x6.\n  kill 10 x8 quest 501.1\n")), "R7");
	assert_eq!(r7.len(), 1, "{r7:#?}");
	// An objective with no count compares nothing.
	let r7 = rule(&play("step Elder Testa\n  accept 506\nstep Field\n  kill 10 x3 quest 506.1\nstep Elder Testa\n  turnin 506\n"), "R7");
	assert!(r7.is_empty(), "{r7:#?}");
}

#[test]
fn r7_level_needs_an_accept() {
	assert!(rule(&play("step Elder Testa\n  tip Available from level 5.\n  talk 1\n"), "R7").is_empty());
}

#[test]
fn r8_quest_work_needs_a_quest() {
	// A kill with no quest between two level gates is no quest work.
	let fs = play("step Grind\n  level 3\nstep Foxes\n  kill 11 x3\nstep Grind more\n  level 4\n");
	assert_eq!(rule(&fs, "R8").len(), 1, "{fs:#?}");
}

#[test]
fn r9_reports_the_first_peak() {
	let accepts: String = (510..531).map(|q| format!("  accept {q}\n")).collect();
	let body = format!(
		"step Elder Testa\n{accepts}step Drop\n  abandon 510\nstep Elder Testa\n  accept 531\nstep Elder Testa\n{}  turnin 531\n",
		(511..531).map(|q| format!("  turnin {q}\n")).collect::<String>()
	);
	let r9 = rule(&play(&body), "R9");
	assert_eq!(r9.len(), 1, "{r9:#?}");
	assert!(r9[0].reason.contains("holds 21"), "{}", r9[0].reason);
	// The peak's line is the first 21st accept (line 7 + 20), not the later accept 531.
	assert_eq!(r9[0].step, 1, "{:#?}", r9[0]);
}

#[test]
fn claims_split_words() {
	assert_eq!(claims("x12.5 yards"), vec![]);
	assert_eq!(claims("a.5x"), vec![Claim::Count(5.0, None)]);
	assert_eq!(claims("5.x2"), vec![Claim::Count(2.0, None)]);
	assert_eq!(claims("Kill 8 kobold's well-fed rats"), vec![Claim::Count(8.0, Some("kobold's well-fed rats".into()))]);
	assert_eq!(claims("Pick up any level 5 quests"), vec![Claim::Level(5.0)]);
	assert_eq!(claims("a b c level 6 quest"), vec![Claim::Level(6.0)]);
	assert_eq!(claims("Take 5 of the"), vec![]);
	assert_eq!(claims("8 rats"), vec![]);
}
