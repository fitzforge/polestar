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
fn no_honor_among_thieves_detour_requires_the_quest_but_pickup_and_main_route_do_not() {
	const BOOTY_BAY: &str = "forever/alliance/30-40/04b-stranglethorn-vale.guide";
	const ARATHI: &str = "forever/alliance/30-40/05-arathi-highlands.guide";
	let all = document("data/guide-fixes.json");
	let fixes = json!({ "fixes": all["fixes"].as_array().unwrap().iter().filter(|r| r["at"]["quest"] == 79242).collect::<Vec<_>>() });
	let mut tree = BTreeMap::from([
		(BOOTY_BAY.into(), "guide forever/alliance/30-40/04b-stranglethorn-vale\nstep Tokal\n  turnin 79236\n  accept 79242\n".into()),
		(
			ARATHI.into(),
			concat!(
				"guide forever/alliance/30-40/05-arathi-highlands\n",
				"step Kor'gresh's cave\n  collect 4525 quest 693\n\n",
				"step Wetlands shore\n  goto 58.2,6.9\n\n",
				"step Portal to The Forbidding Sea\n  goto 58.2,6.9 \"Portal to The Forbidding Sea\"\n\n",
				"step Illari Duskfeather\n  talk 215655 quest 79242.1\n\n",
				"step Illari's Key\n  collect 212347 quest 79242.2\n\n",
				"step Illari's Loot Cache\n  turnin 79242\n\n",
				"step Portal to Thandol Span\n  when subzone \"The Forbidding Sea\"\n  goto 89.6,78 \"Portal to Thandol Span\"\n\n",
				"step Foggy MacKreel\n  only Hunter,Druid\n  accept 647\n\n",
				"step Skuerto\n  turnin 693\n",
			)
			.into(),
		),
	]);
	let records = Records { guide_fixes: Some(&fixes), ..Records::default() };
	let write = |tree: &mut BTreeMap<String, String>| apply(tree, &[BOOTY_BAY.into(), ARATHI.into()], &HashSet::from([79242]), Some("Alliance"), records, None);
	let mut walked = tree.clone();
	walked.insert(
		ARATHI.into(),
		concat!(
			"guide forever/alliance/30-40/05-arathi-highlands\n",
			"step Kor'gresh's cave\n  collect 4525 quest 693\n\n",
			"step Illari Duskfeather\n  talk 215655 quest 79242.1\n  collect 212347 quest 79242.2\n  turnin 79242\n\n",
			"step Foggy MacKreel\n  accept 647 only Hunter,Druid\n",
		)
		.into(),
	);
	assert!(write(&mut walked).iter().all(|r| matches!(r.state.as_str(), "applied" | "redundant")));
	let stops: Vec<_> = walked[ARATHI].split("\nstep ").skip(1).collect();
	assert_eq!(stops.len(), 5);
	assert!(stops[1].starts_with("Portal to The Forbidding Sea\n  when onquest 79242\n"));
	assert!(stops[1].contains("Click the Rowboat at Wetlands 58.2, 6.9"));
	assert!(stops[1].contains("goto 89.52,77.86 map 1417 era"));
	assert!(stops[2].contains("turnin 79242"));
	assert!(stops[3].starts_with("Portal to Thandol Span\n  when subzone \"The Forbidding Sea\"\n"));
	assert!(stops[3].contains("goto 53.62,91.64 map 1417 era"));
	assert!(stops[4].contains("accept 647 only Hunter,Druid"));
	assert!(write(&mut walked).iter().all(|r| r.state == "redundant"));

	assert!(write(&mut tree).iter().all(|r| r.state == "applied" || (r.id == "arathi-no-honor-among-thieves-return-rowboat" && r.state == "redundant")));
	assert!(tree[BOOTY_BAY].contains("turnin 79236\n  accept 79242\n"));
	assert!(!tree[BOOTY_BAY].contains("when onquest 79242"));
	let steps: Vec<_> = tree[ARATHI].split("\nstep ").skip(1).collect();
	assert_eq!(steps.len(), 9);
	assert!(steps[1..=5].iter().all(|step| step.lines().any(|line| line.trim() == "when onquest 79242")), "{steps:?}");
	assert!(steps[6].contains("when subzone \"The Forbidding Sea\"") && !steps[6].contains("when onquest 79242"));
	assert!(steps[7].contains("only Hunter,Druid") && !steps[7].contains("when onquest 79242"));
	assert!(steps[8].contains("turnin 693") && !steps[8].contains("when onquest 79242"));
	assert!(write(&mut tree).iter().all(|r| r.state == "redundant"));
}

#[test]
fn report_2282_does_not_add_the_horde_detour_warning_to_other_routes() {
	let before = format!("guide forever/alliance/test\nzone Thousand Needles\n\nstep Lakota Windsong\n{ARNAK}{LAKOTA}");
	let (after, rows) = written(&before, "Alliance", &[5147, 4904]);
	assert_eq!(after, before);
	assert!(rows.iter().all(|r| r.state == "not for this start"));
}
