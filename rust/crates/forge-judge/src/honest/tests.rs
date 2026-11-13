//! R6-R10 and the non-legacy changes on small guides over a synthetic world (compiled with
//! forge-guide's compile_sources).

use super::*;
use forge_guide::diag::Diagnostics;
use forge_guide::project::{compile_sources, CompileOpts, Source};

fn data() -> Data {
	Data::from_texts(&data_texts(), V::obj(), V::obj(), None).expect("data")
}

fn data_texts() -> rustc_hash::FxHashMap<String, String> {
	let mut quests = serde_json::Map::new();
	let quest = |id: u32, title: &str, races: Option<u64>, classes: Option<u32>, objectives: serde_json::Value| {
		serde_json::json!({
			"id": id, "title": title, "level": 3, "minLevel": 2, "races": races, "classes": classes,
			"start": { "npc": [1], "object": [], "item": [] }, "end": { "npc": [1], "object": [] },
			"pre": [], "excl": [], "next": null, "objectives": objectives, "objectiveText": "", "zone": 99101,
			"xp": 100, "skill": null, "event": null, "source": ["test"]
		})
	};
	quests.insert("501".into(), quest(501, "Rat Trouble", None, None, serde_json::json!([{ "type": "kill", "id": 10, "count": 8 }])));
	quests.insert("502".into(), quest(502, "Fox Pelts", None, None, serde_json::json!([{ "type": "item", "id": 100, "count": 5 }])));
	quests.insert("503".into(), quest(503, "Warrior Calling", None, Some(1), serde_json::json!([])));
	quests.insert("504".into(), quest(504, "Orcish Pride", Some(2), None, serde_json::json!([])));
	// (Started by an item: the Empty Powder Keg pattern, R2.)
	let mut keg = quest(540, "Powder Keg", None, None, serde_json::json!([{ "type": "item", "id": 101, "count": 1 }]));
	keg["start"] = serde_json::json!({ "npc": [], "object": [], "item": [101] });
	quests.insert("540".into(), keg);
	// (Handed in on the spot, `direct`: a crate the data has no source for, a cauldron that gives an essence;
	// and a plain quest that rewards the essence too.)
	let mut sealed = quest(541, "A Sealed Crate", None, None, serde_json::json!([{ "type": "item", "id": 102, "count": 1 }]));
	sealed["direct"] = serde_json::json!(true);
	quests.insert("541".into(), sealed);
	let mut cauldron = quest(542, "The Cauldron", None, None, serde_json::json!([]));
	cauldron["direct"] = serde_json::json!(true);
	cauldron["web"] = serde_json::json!({ "items": [[103, 1]] });
	quests.insert("542".into(), cauldron);
	let mut debts = quest(543, "Old Debts", None, None, serde_json::json!([]));
	debts["web"] = serde_json::json!({ "items": [[103, 1]] });
	quests.insert("543".into(), debts);
	for id in 510..535 {
		quests.insert(id.to_string(), quest(id, &format!("Errand {id}"), None, None, serde_json::json!([])));
	}
	// (Plain errands enough to fill Forever's 40-quest log and one more: R9.)
	for id in 600..641 {
		quests.insert(id.to_string(), quest(id, &format!("Errand {id}"), None, None, serde_json::json!([])));
	}
	let npcs = serde_json::json!({
		"1": { "id": 1, "name": "Elder Testa", "level": 10, "faction": "AH", "spawns": { "99101": { "f": "e", "pts": [[50, 50]] } } },
		"10": { "id": 10, "name": "Burrow Rat", "level": 2, "faction": null, "spawns": { "99101": { "f": "e", "pts": [[20, 20], [21, 21]] } } },
		"11": { "id": 11, "name": "Red Fox", "level": 3, "faction": null, "spawns": { "99101": { "f": "e", "pts": [[30, 30]] } } }
	});
	let items = serde_json::json!({
		"100": { "id": 100, "name": "Fox Pelt", "questItem": true, "drops": { "npc": { "11": 60 } } },
		"101": { "id": 101, "name": "Empty Powder Keg", "drops": { "npc": { "11": 2 } } },
		"102": { "id": 102, "name": "Sealed Crate", "drops": { "npc": {}, "object": {} }, "vendors": [] },
		"103": { "id": 103, "name": "Essence of the Vale", "drops": { "npc": {}, "object": {} }, "vendors": [] }
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
	texts
}

/// `data()` with a taxi: Nighthaven (a Druid's own node, faction 2) and Thunder Bluff, in Testvale.
fn data_with_taxi() -> Data {
	let mut texts = data_texts();
	texts.insert(
		"travel".into(),
		serde_json::json!({ "taxi": { "nodes": [
			{ "id": 63, "name": "Nighthaven, Moonglade", "short": "Nighthaven", "c": 1, "wx": 0, "wy": 0, "map": 99101, "x": 50, "y": 50, "faction": 2, "npc": null, "class": "DRUID" },
			{ "id": 22, "name": "Thunder Bluff, Mulgore", "short": "Thunder Bluff", "c": 1, "wx": 0, "wy": 0, "map": 99101, "x": 90, "y": 90, "faction": 2, "npc": null }
		], "legs": [{ "from": 63, "to": 22, "yards": 900 }] } })
		.to_string(),
	);
	Data::from_texts(&texts, V::obj(), V::obj(), None).expect("data")
}

fn guide(body: &str) -> String {
	format!("guide forever/test/01-vale\ntitle Vale\nlevels 1-10\nzone Testvale\nfaction Horde\n\n{body}")
}

fn persona(race: &str, cls: &str) -> Persona {
	Persona { race: race.into(), faction: "Horde".into(), cls: cls.into() }
}

fn play(body: &str, who: &[Persona], legacy: bool) -> Vec<Finding> {
	let data = data();
	let src = Source { source: "forever/test/01-vale.guide".into(), file: "01-vale.guide".into(), text: guide(body) };
	let mut diag = Diagnostics::new();
	let guides = compile_sources(&[src], &data, &mut diag, &CompileOpts { pack: None, author: None, context: None, pack_dir: None }).guides;
	assert_eq!(guides.len(), 1, "{:?}", diag.list);
	let opts = HonestOpts { legacy, groups: Groups::Skip, walk_far: !legacy };
	let list = who.to_vec();
	honest_play(&guides, &data, &move |_| list.clone(), None, None, &opts)
}

fn rules_of(fs: &[Finding], rule: &str) -> Vec<Finding> {
	fs.iter().filter(|f| f.rule == rule).cloned().collect()
}

#[test]
fn r1_a_druids_own_flight_master_flies_druids_alone_with_no_path_learnt() {
	// Rev14H1 (12b): Bunthen Plainswind flies Horde Druids from Nighthaven to Thunder Bluff; the seed's
	// `fly "Thunder Bluff"` there read as a flight from no flight master, and the repair dropped it.
	let data = data_with_taxi();
	let body = "step Thunder Bluff\n  getfp \"Thunder Bluff\"\n\nstep Nighthaven\n  goto 50,50\n  fly \"Thunder Bluff\"\n";
	let src = Source { source: "forever/test/01-vale.guide".into(), file: "01-vale.guide".into(), text: guide(body) };
	let mut diag = Diagnostics::new();
	let guides = compile_sources(&[src], &data, &mut diag, &CompileOpts { pack: None, author: None, context: None, pack_dir: None }).guides;
	let opts = HonestOpts { legacy: false, groups: Groups::Skip, walk_far: true };
	let r1 = |cls: &str| -> Vec<Finding> {
		let who = vec![persona("Tauren", cls)];
		honest_play(&guides, &data, &move |_| who.clone(), None, None, &opts).into_iter().filter(|f| f.rule == "R1" && f.reason.starts_with("fly")).collect()
	};
	assert!(r1("DRUID").is_empty(), "{:#?}", r1("DRUID"));
	assert!(!r1("WARRIOR").is_empty());
}

#[test]
fn r6_data_mask_excludes_the_persona() {
	let body = "step Elder Testa\n  accept 504\n  accept 503\n";
	let fs = play(body, &[persona("Troll", "WARRIOR")], false);
	let r6 = rules_of(&fs, "R6");
	assert_eq!(r6.len(), 1, "{r6:#?}");
	assert_eq!(r6[0].severity, Severity::Fail);
	assert!(r6[0].reason.contains("Orcish Pride") && r6[0].reason.contains("race mask"), "{}", r6[0].reason);
	// The class mask: a Shaman may not take the Warrior quest.
	let fs = play(body, &[persona("Orc", "SHAMAN")], false);
	let r6 = rules_of(&fs, "R6");
	assert_eq!(r6.len(), 1, "{r6:#?}");
	assert!(r6[0].reason.contains("Warrior Calling") && r6[0].reason.contains("class mask"));
	// Gated by `only`: the excluded persona never plays the line.
	let fs = play("step Elder Testa\n  only Orc\n  accept 504\n", &[persona("Troll", "WARRIOR")], false);
	assert!(rules_of(&fs, "R6").is_empty());
}

#[test]
fn r6_only_on_a_quest_open_to_everyone() {
	let fs = play("step Elder Testa\n  only Warrior\n  accept 501\n", &[persona("Orc", "WARRIOR")], false);
	let r6 = rules_of(&fs, "R6");
	assert_eq!(r6.len(), 1, "{r6:#?}");
	assert_eq!(r6[0].severity, Severity::Warn);
	// The data's own class gate: no warning.
	let fs = play("step Elder Testa\n  only Warrior\n  accept 503\n", &[persona("Orc", "WARRIOR")], false);
	assert!(rules_of(&fs, "R6").is_empty());
}

#[test]
fn r7_counts_and_levels_in_text_equal_the_data() {
	let ok = "step Elder Testa\n  accept 501\nstep Rats\n  tip Kill 8 Burrow Rats in the field.\n  kill 10 x8 quest 501.1\nstep Elder Testa\n  turnin 501\n";
	assert!(rules_of(&play(ok, &[persona("Orc", "WARRIOR")], false), "R7").is_empty());
	let tip = ok.replace("Kill 8 Burrow", "Kill 6 Burrow");
	let r7 = rules_of(&play(&tip, &[persona("Orc", "WARRIOR")], false), "R7");
	assert_eq!(r7.len(), 1, "{r7:#?}");
	assert_eq!(r7[0].severity, Severity::Fail);
	assert!(r7[0].reason.contains("says 6"), "{}", r7[0].reason);
	let more = ok.replace("x8", "x10");
	let r7 = rules_of(&play(&more, &[persona("Orc", "WARRIOR")], false), "R7");
	assert!(r7.iter().any(|f| f.severity == Severity::Fail && f.reason.contains("x10")), "{r7:#?}");
	let fewer = ok.replace("x8", "x5");
	let r7 = rules_of(&play(&fewer, &[persona("Orc", "WARRIOR")], false), "R7");
	assert!(r7.iter().any(|f| f.severity == Severity::Warn && f.reason.contains("x5")), "{r7:#?}");
	let level = "step Elder Testa\n  tip Available from level 5.\n  accept 510\n";
	let r7 = rules_of(&play(level, &[persona("Orc", "WARRIOR")], false), "R7");
	assert_eq!(r7.len(), 1, "{r7:#?}");
	assert!(r7[0].reason.contains("level 5"));
	assert!(rules_of(&play(&level.replace("level 5", "level 2"), &[persona("Orc", "WARRIOR")], false), "R7").is_empty());
}

#[test]
fn r8_one_level_gate_per_grind() {
	let two = "step Grind\n  level 3\nstep Grind more\n  level 4\n";
	let r8 = rules_of(&play(two, &[persona("Orc", "WARRIOR")], false), "R8");
	assert_eq!(r8.len(), 1, "{r8:#?}");
	let split = "step Grind\n  level 3\nstep Elder Testa\n  accept 510\nstep Grind more\n  level 4\n";
	assert!(rules_of(&play(split, &[persona("Orc", "WARRIOR")], false), "R8").is_empty());
}

#[test]
fn r9_log_at_most_forty() {
	let accepts = |n: u32| -> String { (600..600 + n).map(|q| format!("  accept {q}\n")).collect() };
	let turnins: String = (600..641).map(|q| format!("  turnin {q}\n")).collect();
	let r9 = rules_of(&play(&format!("step Elder Testa\n{}step Elder Testa\n{turnins}", accepts(41)), &[persona("Orc", "WARRIOR")], false), "R9");
	assert_eq!(r9.len(), 1, "{r9:#?}");
	assert!(r9[0].reason.contains("holds 41"), "{}", r9[0].reason);
	assert!(r9[0].reason.contains("at most 40"), "{}", r9[0].reason);
	// Forever's log holds 40: a guide holding 21 to 40 at once is within it.
	for n in [21, 40] {
		let body = format!("step Elder Testa\n{}step Elder Testa\n{turnins}", accepts(n));
		assert!(rules_of(&play(&body, &[persona("Orc", "WARRIOR")], false), "R9").is_empty(), "{n} quests");
	}
}

#[test]
fn r10_every_accept_turned_in_or_abandoned() {
	let r10 = rules_of(&play("step Elder Testa\n  accept 510\n  accept 511\nstep Elder Testa\n  turnin 511\n", &[persona("Orc", "WARRIOR")], false), "R10");
	assert_eq!(r10.len(), 1, "{r10:#?}");
	assert!(r10[0].reason.contains("Errand 510"));
	let abandoned = "step Elder Testa\n  accept 510\nstep Drop it\n  abandon 510\n";
	assert!(rules_of(&play(abandoned, &[persona("Orc", "WARRIOR")], false), "R10").is_empty());
}

#[test]
fn legacy_has_no_r6_to_r10_and_duplicates_personas() {
	let body = "step Elder Testa\n  accept 510\nstep Rats\n  kill 10 x8 quest 501.1\nstep Elder Testa\n  turnin 501\n";
	let who = [persona("Orc", "WARRIOR"), persona("Troll", "WARRIOR")];
	let legacy = play(body, &who, true);
	assert!(legacy.iter().all(|f| ["R1", "R2", "R3", "R4", "R5"].contains(&f.rule)), "{legacy:#?}");
	let r5: Vec<_> = rules_of(&legacy, "R5");
	assert_eq!(r5.len(), 2, "one per persona: {r5:#?}");
	let merged = rules_of(&play(body, &who, false), "R5");
	assert_eq!(merged.len(), 1, "{merged:#?}");
	assert_eq!(merged[0].personas.len(), 2);
}

#[test]
fn r3_unflagged_quest_item_warning_is_demoted() {
	// Fox Pelt not flagged as a quest item: legacy warns, the default says info.
	let mut d = data();
	let items = d.items.get("100");
	items.set("questItem", false);
	let _ = &mut d;
	let body = "step Foxes\n  collect 100 x5\n";
	let src = Source { source: "forever/test/01-vale.guide".into(), file: "01-vale.guide".into(), text: guide(body) };
	let guides = compile_sources(&[src], &d, &mut Diagnostics::new(), &CompileOpts { pack: None, author: None, context: None, pack_dir: None }).guides;
	let who = vec![persona("Orc", "WARRIOR")];
	let legacy = honest_play(&guides, &d, &|_| who.clone(), None, None, &HonestOpts::legacy());
	assert!(legacy.iter().any(|f| f.rule == "R3" && f.severity == Severity::Warn), "{legacy:#?}");
	let now = honest_play(&guides, &d, &|_| who.clone(), None, None, &HonestOpts::default());
	assert!(now.iter().any(|f| f.rule == "R3" && f.severity == Severity::Info), "{now:#?}");
	assert!(!now.iter().any(|f| f.rule == "R3" && f.severity == Severity::Warn));
}

#[test]
fn r5_buy_lines_cover_the_kb_buy_step() {
	let body = "step Elder Testa\n  accept 510\nstep Vendor\n  buy 100\nstep Elder Testa\n  turnin 510\n";
	let data = data();
	let src = Source { source: "forever/test/01-vale.guide".into(), file: "01-vale.guide".into(), text: guide(body) };
	let guides = compile_sources(&[src], &data, &mut Diagnostics::new(), &CompileOpts { pack: None, author: None, context: None, pack_dir: None }).guides;
	let kb = kb_from_rows([(510, KbStep { n: 1, action: "buy".into(), kind: Some("npc".into()), target: Some(1), item: Some(100), fact: None })]);
	let who = vec![persona("Orc", "WARRIOR")];
	let legacy = honest_play(&guides, &data, &|_| who.clone(), Some(&kb), None, &HonestOpts::legacy());
	assert!(legacy.iter().any(|f| f.rule == "R5" && f.reason.contains("(buy Fox Pelt) has no line")), "{legacy:#?}");
	let now = honest_play(&guides, &data, &|_| who.clone(), Some(&kb), None, &HonestOpts::default());
	assert!(!now.iter().any(|f| f.rule == "R5"), "{now:#?}");
}

#[test]
fn chains_follow_the_first_option() {
	let data = data();
	let src = |id: &str, next: &str| Source {
		source: format!("forever/test/{id}.guide"),
		file: format!("{id}.guide"),
		text: format!("guide forever/test/{id}\ntitle {id}\nlevels 1-10\nzone Testvale\nfaction Horde\n{next}\nstep Elder Testa\n  talk 1\n"),
	};
	let sources = [src("a", "next forever/test/c"), src("b", "next forever/test/c"), src("c", "")];
	let guides = compile_sources(&sources, &data, &mut Diagnostics::new(), &CompileOpts { pack: None, author: None, context: None, pack_dir: None }).guides;
	assert_eq!(chains(&guides), vec![vec![0, 2], vec![1]]);
	assert_eq!(chains_with(&guides, false), vec![vec![0, 2], vec![1, 2]]);
}

#[test]
fn claims_read_counts_and_levels() {
	use rules::{claims, Claim};
	assert_eq!(claims("Kill 8 Burrow Rats, x5 pelts"), vec![Claim::Count(8.0, Some("burrow rats x5".into())), Claim::Count(5.0, None)]);
	assert_eq!(claims("Requires level 12; walk 200 yd. You should be level 13."), vec![Claim::Level(12.0)]);
	assert_eq!(claims("2 of the 3 totems"), vec![Claim::Count(2.0, Some("3 totems".into()))]);
	// Coordinates, decimals and counts nobody is asked for are no claims.
	assert_eq!(claims("healers around 65,68 and 65,65; each mound gives 1 to 3 eggs, run speed for 10 shards"), vec![]);
}

/// tests/playtest-honest.test.js `play` on the reference data (data/forever).
#[cfg(feature = "native")]
fn play_real(text: &str) -> Vec<Finding> {
	let dir = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../../data/forever");
	assert!(dir.join("travel.json").exists(), "needs the built reference data in data/forever");
	let data = forge_guide::data::load_data(&dir).expect("data");
	let head = "guide test/honest\ntitle Honest\nlevels 1-60\nzone Durotar\n\n";
	let src = Source { file: "honest.guide".into(), source: "honest.guide".into(), text: format!("{head}{text}") };
	let guides = compile_sources(&[src], &data, &mut Diagnostics::new(), &CompileOpts { pack: None, author: None, context: None, pack_dir: None }).guides;
	let refs: Vec<&V> = guides.iter().collect();
	play_chain(&refs, &data, &persona("Orc", "WARRIOR"), None, None, &HonestOpts { walk_far: true, ..HonestOpts::legacy() })
}

#[cfg(feature = "native")]
#[test]
#[ignore = "needs the built reference data in data/forever"]
fn r1_dock_is_walked_to() {
	let other = play_real("step Boars\n  kill 3098 @44.5,70.6\n\nstep Boat\n  zone Stranglethorn Vale\n  goto 26.4,73.6 \"Boat to Ratchet\"\n");
	assert!(rules_of(&other, "R1")[0].reason.contains("dock on another continent with no travel line: Durotar to Stranglethorn Vale"), "{other:?}");
	let far = play_real("step Boars\n  kill 3098 @52.0,10.0\n\nstep Boat\n  zone The Barrens\n  goto 63.4,38.5 \"Ratchet pier\"\n");
	assert!(rules_of(&far, "R1")[0].reason.contains("dock far from where the guide leaves the player: Durotar to The Barrens"), "{far:?}");
	let flown = play_real("step Crossroads\n  zone The Barrens\n  goto 51.5,30.4\n  getfp \"Crossroads\"\n\nstep Ratchet\n  goto 63.1,37.1\n  getfp \"Ratchet\"\n\nstep Back\n  goto 51.5,30.4 \"Walk back to the Crossroads\"\n\nstep Fly\n  fly \"Ratchet\"\n\nstep Boat\n  goto 63.4,38.5 \"Ratchet pier\"\n");
	assert!(rules_of(&flown, "R1").iter().all(|f| !f.reason.contains("dock")), "{flown:?}");
	let fm = play_real("step Boars\n  kill 3098 @52.0,10.0\n\nstep Fly\n  zone The Barrens\n  goto 63.1,37.1 \"Ratchet flight master\"\n");
	assert!(rules_of(&fm, "R1")[0].reason.contains("flight master far from where the guide leaves the player: Durotar to The Barrens"), "{fm:?}");
	// A plain goto across zones (Durotar to Stranglethorn's Booty Bay road... here Durotar to the
	// Thousand Needles' Shimmering Flats) is a walk, not a way into the next zone.
	let walk = play_real("step Boars\n  kill 3098 @52.0,10.0\n\nstep South\n  zone Thousand Needles\n  goto 77.0,77.0 \"Thousand Needles\"\n");
	assert!(rules_of(&walk, "R1").iter().any(|f| f.reason.contains("walk far into another zone: Durotar to Thousand Needles")), "{walk:?}");
	// R1 findings carry where the guide left the player.
	assert!(rules_of(&far, "R1")[0].state.as_ref().is_some_and(|s| s.at.is_some()));
}

#[cfg(feature = "native")]
#[test]
#[ignore = "needs the built reference data in data/forever"]
fn r1_a_class_teleport_goto_is_no_walk() {
	// RevSkyH3 S6: a Druid's Teleport: Moonglade, written as the goto to where it lands, is not a walk
	// from Durotar to Moonglade; the same goto without the teleport is.
	let cast = play_real("step Boars\n  kill 3098 @52.0,10.0\n\nstep Moonglade\n  zone Moonglade\n  goto 56.3,32.5 \"Cast Teleport: Moonglade\"\n");
	assert!(rules_of(&cast, "R1").is_empty(), "{cast:?}");
	let walk = play_real("step Boars\n  kill 3098 @52.0,10.0\n\nstep Moonglade\n  zone Moonglade\n  goto 56.3,32.5 \"Moonglade\"\n");
	assert!(!rules_of(&walk, "R1").is_empty(), "{walk:?}");
}

#[cfg(feature = "native")]
#[test]
#[ignore = "needs the built reference data in data/forever"]
fn r1_a_portal_the_guide_works_is_no_walk() {
	// c17 Skyborne-alliance zephras-isle:702: `interact 631299` (the Skyborne Portal to Stormwind, by
	// Dalaran) takes the player to Stormwind; read as standing in Alterac, the repair wrote a walk
	// through Arathi, the Wetlands, Loch Modan, the Badlands and Redridge to Stormwind.
	let portal = play_real("step Portal\n  zone Alterac Mountains\n  interact 631299\n\nstep Stormwind\n  zone Stormwind City\n  kill 3098 @71.0,72.5\n");
	assert!(rules_of(&portal, "R1").is_empty(), "{portal:?}");
	let herb = play_real("step Herb\n  zone Alterac Mountains\n  interact 1622\n\nstep Stormwind\n  zone Stormwind City\n  kill 3098 @71.0,72.5\n");
	assert!(rules_of(&herb, "R1").iter().any(|f| f.reason.contains("zone change with no travel line: Alterac Mountains to Stormwind City")), "{herb:?}");
}

#[test]
fn r2_an_optional_accept_from_an_item_an_optional_collect_asks_for_is_that_players() {
	// Rev15 R2 (Dun Morogh): `collect 268548 optional` (the Empty Powder Keg) then `accept 95213
	// optional`: the player who loots the keg takes the quest, one who does not skips both.
	let who = [persona("Orc", "WARRIOR")];
	let fs = play("step Quarry\n  collect 101 optional @80,80\n  accept 540 optional\n", &who, false);
	assert!(rules_of(&fs, "R2").is_empty(), "{fs:#?}");
	// (Its hand-in, optional too, has the keg it asks for.)
	let fs = play("step Quarry\n  collect 101 optional @80,80\n  accept 540 optional\n\nstep Thesten\n  turnin 540 optional\n", &who, false);
	assert!(rules_of(&fs, "R2").is_empty() && rules_of(&fs, "R5").is_empty(), "{fs:#?}");
	// (No optional collect for it: the optional accept still has no keg.)
	let fs = play("step Quarry\n  accept 540 optional\n", &who, false);
	assert!(!rules_of(&fs, "R2").is_empty(), "{fs:#?}");
}

#[test]
fn r3_quests_handed_in_on_the_spot_need_no_quest_in_the_log() {
	// #1806: a `turnin … direct` quest is taken straight from the giver's window and never enters the log.
	// Its objective items come without it, and its reward items at the hand-in.
	let who = [persona("Orc", "WARRIOR")];
	let r3 = |body: &str, legacy: bool| rules_of(&play(body, &who, legacy), "R3");
	// A quest item for it: no "drops only while … is held".
	let pelts = "step Foxes\n  collect 100 x5 @30,30\n\nstep Elder Testa\n  turnin 502 direct\n";
	let fs = r3(pelts, false);
	assert!(fs.is_empty(), "{fs:#?}");
	// (Legacy keeps the JS output.)
	assert!(r3(pelts, true).iter().any(|f| f.reason.contains("drops only while Fox Pelts is held")));
	// An objective item the data has no source for.
	let fs = r3("step Elder Testa\n  collect 102 @50,50\n  turnin 541 direct\n", false);
	assert!(fs.is_empty(), "{fs:#?}");
	// A reward item, collected after the hand-in, on the spot or not.
	let fs = r3("step Elder Testa\n  turnin 542 direct\n  collect 103 @50,50\n", false);
	assert!(fs.is_empty(), "{fs:#?}");
	let fs = r3("step Elder Testa\n  accept 543\n  turnin 543\n  collect 103 @50,50\n", false);
	assert!(fs.is_empty(), "{fs:#?}");
	// Without the hand-in in the chain, both collects still fail.
	assert!(r3("step Foxes\n  collect 100 x5 @30,30\n", false).iter().any(|f| f.reason.contains("drops only while")));
	assert!(r3("step Elder Testa\n  collect 102 @50,50\n", false).iter().any(|f| f.reason.contains("no mob, object or vendor")));
}
