//! The cached web zone quest lists (<sources>/web/zones.json) and what reaches quests.json from them:
//! their rows' zones, Forever's change notes (XP, level, required level, title), the XP of quests still
//! without any, and the list facts (instance, type, side, rewards).

use forge_data::extras::{apply_change_notes, apply_web_zone_facts, fill_web_zone_xp, load_zone_quests};
use forge_guide::js::{parse_json, stringify, Obj, V};
use indexmap::IndexMap;

fn rows(json: &str) -> IndexMap<String, V> {
	parse_json(json).unwrap().entries().into_iter().map(|(k, v)| (k.to_string(), v)).collect()
}

fn quests(json: &str) -> Obj {
	parse_json(json).unwrap().as_obj().unwrap().clone()
}

fn q(id: u32, extra: &str) -> String {
	format!(r#""{id}":{{"id":{id},"title":"Quest {id}","level":20,"minLevel":15,"xp":null,"source":["pfquest","questie-forever"]{extra}}}"#)
}

const NOTES: &str = r#"{
	"606": { "id": 606, "status": "updated", "xp": 3300, "lines": ["Experience 3,300 instead of 820"] },
	"472": { "id": 472, "status": "updated", "xp": 1200, "lines": ["Level 30 instead of 25", "Requires level 26 instead of 28", "Description reworded"] },
	"700": { "id": 700, "status": "updated", "xp": 500, "lines": ["Experience 500 instead of 400"] },
	"7738": { "id": 7738, "status": "unchanged", "xp": 440, "lines": [] },
	"99": { "id": 99, "status": "new", "xp": 630, "lines": ["Experience 630 instead of none"] },
	"5645": { "id": 5645, "name": "Chastise", "status": "updated", "lines": ["Renamed from A Lack of Fear", "Rewards: adds Chastise"] },
	"5641": { "id": 5641, "name": "Chastise", "status": "updated", "lines": ["Renamed from A Lack of Fear"] }
}"#;

#[test]
fn the_cache_gives_each_row_its_zone_and_no_cache_builds_without_them() {
	let d = crate::common::scratch("webzones");
	let none = load_zone_quests(&d).unwrap();
	assert!(none.rows.is_empty());
	assert!(none.warnings.join("\n").contains("no cached web zone lists"));
	std::fs::create_dir_all(d.join("web")).unwrap();
	std::fs::write(d.join("web/zones.json"), r#"{"fetchedAt":"2026-10-14T00:00:00.000Z","zones":{"11":[{"id":5,"xp":100}],"1581":[{"id":166,"zone":1581,"type":81}]}}"#).unwrap();
	let r = load_zone_quests(&d).unwrap();
	assert_eq!((r.rows["5"].get("zone").num(), r.rows["166"].get("zone").num()), (11.0, 1581.0));
	assert_eq!((r.fetched_at.to_js_string(), r.warnings.len()), ("2026-10-14T00:00:00.000Z".to_string(), 0));
}

#[test]
fn a_change_note_replaces_a_value_only_while_we_still_hold_the_old_one() {
	let qs = quests(&format!(
		"{{{},{},{},{},{}}}",
		q(606, "").replace(r#""xp":null"#, r#""xp":820"#),
		q(472, "").replace(r#""level":20,"minLevel":15"#, r#""level":25,"minLevel":20"#),
		q(700, "").replace(r#""xp":null"#, r#""xp":450"#),
		q(5645, "").replace("Quest 5645", "A Lack of Fear"),
		q(5641, "").replace("Quest 5641", "Our Own Name"),
	));
	let c = apply_change_notes(&qs, &rows(NOTES));
	assert_eq!((c.xp, c.level, c.min_level, c.title), (1, 1, 0, 1), "other notes (a description) are ignored");
	let get = |id: &str, k: &str| stringify(&qs.get(id).get(k), None);
	assert_eq!((get("606", "xp"), get("606", "source")), ("3300".into(), r#"["pfquest","questie-forever","web:xp"]"#.into()), "thousands separators read");
	assert_eq!((get("472", "level"), get("472", "minLevel")), ("30".into(), "20".into()), "our 20 is not the noted old 28: left alone");
	assert_eq!(get("700", "xp"), "450", "a value that is neither old nor new is left alone");
	assert_eq!((get("5645", "title"), get("5645", "source")), (r#""Chastise""#.into(), r#"["pfquest","questie-forever","web:title"]"#.into()));
	assert_eq!(get("5641", "title"), r#""Our Own Name""#, "a title that is not the noted old name is left alone");
}

#[test]
fn list_xp_fills_quests_without_any_and_never_overrides_one() {
	let qs = quests(&format!("{{{},{}}}", q(99, "").replace(r#""pfquest","questie-forever""#, r#""questie-forever""#), q(7738, "").replace(r#""xp":null"#, r#""xp":2200"#)));
	assert_eq!(fill_web_zone_xp(&qs, &rows(NOTES)), 1);
	assert_eq!(stringify(&qs.get("99").get("xp"), None), "630");
	assert_eq!(stringify(&qs.get("99").get("source"), None), r#"["questie-forever","web:xp"]"#);
	assert_eq!(stringify(&qs.get("7738").get("xp"), None), "2200", "an unchanged quest whose list XP differs keeps ours");
}

#[test]
fn list_facts_instance_type_side_rewards_and_choices_a_note_undoes() {
	let qs = quests(&format!("{{{},{},{},{},{}}}", q(166, ""), q(962, ""), q(1486, ""), q(1367, ""), q(7, "")));
	let facts = rows(
		r#"{
		"166": { "id": 166, "zone": 1581, "type": 81, "side": 1, "choices": [[6087, 1]], "items": [], "money": 0, "rep": [[72, 200]], "lines": [] },
		"962": { "id": 962, "zone": 718, "type": 81, "side": 3, "choices": [[10919, 1], [270008, 1]], "items": [[10919, 1]], "money": 2000, "rep": [], "lines": ["Rewards: adds Choice of Heat Resistant Mitts"] },
		"1486": { "id": 1486, "zone": 718, "type": 81, "side": 3, "choices": [[918, 1], [6480, 1]], "items": [[918, 1], [6480, 1]], "money": 1800, "rep": [], "lines": ["Rewards: adds Deviate Hide Pack, Slick Deviate Leggings", "Rewards: no longer Choice of Deviate Hide Pack, Choice of Slick Deviate Leggings"] },
		"1367": { "id": 1367, "zone": 405, "type": 0, "side": 3, "choices": [], "items": [], "money": 0, "rep": [[93, 250], [92, 1]], "lines": [] },
		"8": { "id": 8, "zone": 12, "type": 0, "side": 1, "choices": [], "items": [], "money": 0, "rep": [], "lines": [] }
	}"#,
	);
	assert_eq!(apply_web_zone_facts(&qs, &facts), 4, "quest 8 is not ours");
	let web = |id: &str, k: &str| stringify(&qs.get(id).get("web").get(k), None);
	assert_eq!(stringify(&qs.get("166").get("web"), None), r#"{"zone":1581,"type":81,"side":1,"choices":[[6087,1]],"items":[],"money":0,"rep":[[72,200]]}"#);
	assert_eq!((web("962", "choices"), web("962", "items")), ("[[10919,1],[270008,1]]".into(), "[]".into()), "the gloves became one of the choices");
	assert_eq!((web("1486", "choices"), web("1486", "items")), ("[]".into(), "[[918,1],[6480,1]]".into()), "both given now");
	assert_eq!(web("1367", "rep"), "[[93,250]]", "a reputation of 1 is no amount");
	assert!(qs.get("7").get("web").is_undef());
}
