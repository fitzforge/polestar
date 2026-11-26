//! Player-reported step advice applied by the real writer fix pass, before generated guides are rebuilt.

use forge_writer::fixes::{apply, FixRow, Records};
use serde_json::{json, Value};
use std::collections::{BTreeMap, HashSet};
use std::path::Path;

const FILE: &str = "forever/horde/07-ashenvale.guide";
const ESCORT: &str =
	"Lakota Windsong is held captive beside Arnak Grimtotem (29): clear the guards and Arnak first, then free her and protect her on the walk down; Grimtotem ambushers come at you on the way.";
const ARNAK: &str = "  collect 12884 quest 5147 @38.1,26.9 -- Arnak Grimtotem\n";
const LAKOTA: &str = "  accept 4904 @37.95,26.45 -- Lakota Windsong\n  complete 4904\n";

fn document(file: &str) -> Value {
	let root = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..");
	serde_json::from_slice(&std::fs::read(root.join(file)).unwrap()).unwrap()
}

fn warning_records() -> Value {
	let all = document("data/guide-fixes.json");
	json!({ "fixes": all["fixes"].as_array().unwrap().iter().filter(|r| r["issue"] == 2282).collect::<Vec<_>>() })
}

fn written(text: &str, faction: &str, quests: &[u32]) -> (String, Vec<FixRow>) {
	let mut tree = BTreeMap::from([(FILE.to_string(), text.to_string())]);
	let records = warning_records();
	let rows = apply(&mut tree, &[FILE.into()], &quests.iter().copied().collect::<HashSet<_>>(), Some(faction), Records { places: None, guide_fixes: Some(&records) }, None);
	(tree.remove(FILE).unwrap(), rows)
}

fn without_tips(text: &str) -> Vec<&str> {
	text.lines().filter(|l| !l.trim_start().starts_with("tip ")).collect()
}

fn assert_warning(tip: &str) {
	assert!(tip.starts_with("Great Lift"), "name the detour first, before the default one-line tip is cut short: {tip}");
	assert!(tip.contains("arrow") && tip.contains("canyon floor"), "warn about navigation and qualify the approach by the player's floor: {tip}");
	assert!(tip.contains("rope bridges"), "the existing climb crosses the bridges: {tip}");
	assert!(tip.ends_with(ESCORT), "a replacement tip must retain the combat order and escort/ambusher advice: {tip}");
}

#[test]
fn riverglades_old_rot_chum_hand_in_waits_for_the_harpoon() {
	let root = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..");
	let all = document("data/guide-fixes.json");
	let records = json!({ "fixes": all["fixes"].as_array().unwrap().iter().filter(|r| {
		r["at"]["quest"] == 95120 && r["at"]["goal"] == "turnin"
	}).collect::<Vec<_>>() });
	for (side, faction) in [("alliance", "Alliance"), ("horde", "Horde")] {
		let file = format!("forever/{side}/40-50/01b-riverglades.guide");
		let seed = std::fs::read_to_string(root.join("forge/seed/guides").join(&file)).unwrap();
		// The seed carries the gate since the hand edit; the writer's input before the record is the step without it.
		let before = seed.replace("\r\n", "\n").replacen("  when complete 95120\n", "", 1);
		let mut tree = BTreeMap::from([(file.clone(), before.clone())]);
		let write = |tree: &mut BTreeMap<String, String>| {
			apply(tree, std::slice::from_ref(&file), &HashSet::from([95120]), Some(faction), Records { places: None, guide_fixes: Some(&records) }, None);
		};
		write(&mut tree);
		let after = &tree[&file];
		let hand_in = after.split("\nstep ").find(|step| step.lines().any(|line| line.trim() == "turnin 95120")).unwrap();
		assert!(hand_in.lines().any(|line| line.trim() == "when complete 95120"), "{faction}: {hand_in}");
		assert_eq!(after.replacen("  when complete 95120\n", "", 1), before, "{faction}: only the hand-in gate should change");
		assert_eq!(after, &seed.replace("\r\n", "\n"), "{faction}: the record writes what the seed carries");
		let after = after.clone();
		write(&mut tree);
		assert_eq!(tree[&file], after, "{faction}: the gate should not be duplicated");
	}
}

#[test]
fn report_2282_warns_at_arnak_and_lakota_even_when_the_writer_separates_their_steps() {
	let old = format!("  tip Climb the path to the top of Darkcloud Pinnacle. {ESCORT}\n");
	for (body, quests, tips) in [
		(format!("step Lakota Windsong\n{old}{ARNAK}{LAKOTA}"), vec![5147, 4904], 1),
		(format!("step Arnak Grimtotem\n{old}{ARNAK}\nstep Lakota Windsong\n{LAKOTA}"), vec![5147, 4904], 2),
		(format!("step Arnak Grimtotem\n{old}{ARNAK}"), vec![5147], 1),
		(format!("step Lakota Windsong\n{old}{LAKOTA}"), vec![4904], 1),
	] {
		let before = format!("guide forever/horde/07-ashenvale\nzone Thousand Needles\n\n{body}\nstep Freewind Post\n  turnin 5147\n  turnin 4904\n");
		let (after, rows) = written(&before, "Horde", &quests);
		assert_eq!(without_tips(&after), without_tips(&before), "no new waypoint, changed objective, gate or quest order");
		let actual: Vec<_> = after.lines().filter_map(|l| l.strip_prefix("  tip ")).collect();
		assert_eq!(actual.len(), tips, "one complete tip at each approach, without duplication");
		for tip in actual {
			assert_warning(tip);
		}
		assert_eq!(rows.len(), 2, "both approaches need durable anchors");
		assert!(rows.iter().all(|r| matches!(r.state.as_str(), "applied" | "redundant" | "not for this start")), "{rows:?}");
		let (again, rows) = written(&after, "Horde", &quests);
		assert_eq!(again, after, "another writer pass must not duplicate or change the advice");
		assert!(rows.iter().all(|r| matches!(r.state.as_str(), "redundant" | "not for this start")), "{rows:?}");
	}
}

#[test]
fn report_2282_does_not_add_the_horde_detour_warning_to_other_routes() {
	let before = format!("guide forever/alliance/test\nzone Thousand Needles\n\nstep Lakota Windsong\n{ARNAK}{LAKOTA}");
	let (after, rows) = written(&before, "Alliance", &[5147, 4904]);
	assert_eq!(after, before);
	assert!(rows.iter().all(|r| r.state == "not for this start"));
}
