//! Automatic class coverage over a whole chain, using only committed DSL data.
use forge_judge::honest::{play_pack, Finding, HonestOpts, PackRun};
use std::path::{Path, PathBuf};
use std::sync::atomic::{AtomicUsize, Ordering};

const UNFINISHED: &str = "  accept 783\n  turnin 783\n  accept 7\n  turnin 7";

struct Pack(PathBuf);
impl Pack {
	fn new() -> Self {
		static NEXT: AtomicUsize = AtomicUsize::new(0);
		let path = Path::new(env!("CARGO_TARGET_TMPDIR")).join(format!("honest-chain-classes-{}-{}", std::process::id(), NEXT.fetch_add(1, Ordering::Relaxed)));
		std::fs::create_dir_all(&path).unwrap();
		Self(path)
	}
	fn guide(&self, file: &str, id: &str, header: &str, body: &str) {
		std::fs::write(self.0.join(file), format!("guide forever/test/{id}\ntitle {id}\nlevels 1-10\nzone Elwynn Forest\nfaction Alliance\n{header}\n\n{body}\n")).unwrap();
	}
	fn play(&self, run: &PackRun, opts: &HonestOpts) -> Vec<Finding> {
		let data = forge_guide::data::load_data(&Path::new(env!("CARGO_MANIFEST_DIR")).join("../../../tests/fixtures/dsl/data")).unwrap();
		play_pack(&self.0, &data, None, run, opts).expect("compile and play").findings.into_iter().filter(|f| f.rule == "R5").collect()
	}
}
impl Drop for Pack {
	fn drop(&mut self) {
		let _ = std::fs::remove_dir_all(&self.0);
	}
}

fn chain(root_header: &str, end_header: &str, end_body: &str) -> Pack {
	let pack = Pack::new();
	pack.guide("01-start.guide", "start", &format!("next forever/test/end\n{root_header}"), "step Begin\n  note Begin");
	pack.guide("02-end.guide", "end", end_header, end_body);
	pack
}

#[test]
fn late_class_step_goal_and_header_are_sampled_in_both_modes() {
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		for (header, body) in
			[("", format!("step Mage work\n  only Mage\n{UNFINISHED}")), ("", format!("step Mage work\n{UNFINISHED} only Mage")), ("class Mage", format!("step Mage work\n{UNFINISHED}"))]
		{
			let findings = chain("", header, &body).play(&PackRun::default(), &opts);
			let mage = findings.iter().find(|f| f.personas.iter().any(|(_, cls)| cls == "MAGE"));
			assert!(mage.is_some(), "legacy={}, header={header}, body={body}", opts.legacy);
			assert_eq!(mage.unwrap().guide, "forever/test/end");
			assert!(mage.unwrap().reason.contains("has 0/10 from earlier lines"));
			assert!(findings.iter().flat_map(|f| &f.personas).all(|(_, cls)| cls == "MAGE"));
		}
	}
}

#[test]
fn late_class_guide_filter_and_explicit_classes() {
	let pack = chain("", "", &format!("step Mage work\n  only Mage\n{UNFINISHED}"));
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		let run = PackRun { filter: Some("02-end".into()), ..Default::default() };
		assert_eq!(pack.play(&run, &opts)[0].cls, "MAGE");
		assert!(pack.play(&PackRun { classes: Some(vec!["WARRIOR".into()]), ..Default::default() }, &opts).is_empty());
		assert_eq!(pack.play(&PackRun { classes: Some(vec!["MAGE".into()]), ..Default::default() }, &opts)[0].cls, "MAGE");
	}
}

#[test]
fn late_class_adds_an_eligible_race_without_relaxing_root_restrictions() {
	let body = format!("step Druid work\n  only Druid\n{UNFINISHED}");
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		let pack = chain("", "", &body);
		let findings = pack.play(&PackRun::default(), &opts);
		assert_eq!(findings.len(), 1);
		assert_eq!(findings[0].race, "NightElf");
		assert_eq!(findings[0].cls, "DRUID");
		for header in ["race Human", "class Warrior"] {
			assert!(chain(header, "", &body).play(&PackRun::default(), &opts).is_empty(), "{header}");
		}
		assert!(pack.play(&PackRun { race: Some("Human".into()), ..Default::default() }, &opts).is_empty());
		let data = forge_guide::data::load_data(&Path::new(env!("CARGO_MANIFEST_DIR")).join("../../../tests/fixtures/dsl/data")).unwrap();
		let result = play_pack(&pack.0, &data, None, &PackRun { faction: Some("Horde".into()), ..Default::default() }, &opts);
		assert!(matches!(result, Err(e) if e.contains("nothing played")));
	}
}

#[test]
fn late_class_sampling_keeps_an_unnamed_class() {
	let pack = chain("", "", &format!("step Mage greeting\n  only Mage\n  note Hello\n\nstep Work\n{UNFINISHED}"));
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		let findings = pack.play(&PackRun::default(), &opts);
		let mut classes: Vec<_> = findings.iter().flat_map(|f| f.personas.iter().map(|(_, cls)| cls.as_str())).collect();
		classes.sort();
		assert_eq!(classes, ["MAGE", "WARRIOR"]);
	}
}

#[test]
fn shared_tail_class_sampling_preserves_each_modes_chain_ownership() {
	let pack = Pack::new();
	pack.guide("01-human.guide", "human", "race Human\nnext forever/test/end", "step Begin\n  note Begin");
	pack.guide("02-gnome.guide", "gnome", "race Gnome\nnext forever/test/end", "step Begin\n  note Begin");
	pack.guide("03-end.guide", "end", "", &format!("step Mage work\n  only Mage\n{UNFINISHED}"));
	for (opts, want) in [(HonestOpts::default(), vec!["Gnome", "Human"]), (HonestOpts::legacy(), vec!["Human"])] {
		let findings = pack.play(&PackRun::default(), &opts);
		let mut races: Vec<_> = findings.iter().flat_map(|f| f.personas.iter().map(|(race, _)| race.as_str())).collect();
		races.sort();
		assert_eq!(races, want);
	}
}

fn audience_data() -> forge_guide::data::Data {
	forge_guide::data::load_data(&Path::new(env!("CARGO_MANIFEST_DIR")).join("../../../tests/fixtures/dsl/data")).unwrap()
}

fn audience_tail(broken: bool) -> Pack {
	let kills = if broken { "" } else { "  kill 6 x10 quest 7.1\n" };
	chain("", "class Mage", &format!("step Kobolds\n  accept 783\n  turnin 783\n  accept 7\n{kills}  turnin 7"))
}

#[test]
fn selected_later_header_requires_an_eligible_character() {
	let data = audience_data();
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		for broken in [false, true] {
			let pack = audience_tail(broken);
			let run = PackRun { filter: Some("02-end".into()), classes: Some(vec!["WARRIOR".into()]), ..Default::default() };
			// The context root is compatible, but the only selected guide is not.
			let err = match play_pack(&pack.0, &data, None, &run, &opts) {
				Ok(r) => panic!("legacy={}, broken={broken}: expected no-play error, got {} guides and {} findings", opts.legacy, r.played, r.findings.len()),
				Err(e) => e,
			};
			assert!(err.contains("nothing played") && err.contains("no eligible characters"), "legacy={}, broken={broken}: {err}", opts.legacy);
		}
	}
}

#[test]
fn selected_later_header_keeps_matching_results_and_compatible_root_selection() {
	let data = audience_data();
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		for broken in [false, true] {
			let pack = audience_tail(broken);
			let tail = PackRun { filter: Some("02-end".into()), classes: Some(vec!["MAGE".into()]), ..Default::default() };
			let result = play_pack(&pack.0, &data, None, &tail, &opts).expect("the selected Mage guide is played");
			assert_eq!(result.played, 1);
			if broken {
				assert!(result.findings.iter().any(|f| f.rule == "R5" && f.cls == "MAGE" && f.guide == "forever/test/end" && f.reason.contains("0/10")));
			} else {
				assert!(result.findings.is_empty(), "{:#?}", result.findings);
			}

			let root = PackRun { filter: Some("01-start".into()), classes: Some(vec!["WARRIOR".into()]), ..Default::default() };
			let result = play_pack(&pack.0, &data, None, &root, &opts).expect("the selected root still admits Warrior");
			assert_eq!(result.played, 1);
			assert!(result.findings.is_empty(), "{:#?}", result.findings);
		}
	}
}

fn audience_persona(race: &str, faction: &str, cls: &str) -> forge_judge::honest::Persona {
	forge_judge::honest::Persona { race: race.into(), faction: faction.into(), cls: cls.into() }
}

fn audience_guide(id: &str, header: serde_json::Value, goals: serde_json::Value) -> forge_guide::js::V {
	// Raw compiled guides exercise the public APIs without compiler validation
	// rejecting deliberately incompatible guide/persona combinations first.
	let mut guide = serde_json::json!({ "id": id, "steps": [{ "goals": goals }] });
	guide.as_object_mut().unwrap().extend(header.as_object().unwrap().clone());
	forge_guide::js::parse_json(&guide.to_string()).unwrap()
}

#[test]
fn direct_and_traced_chains_apply_each_guides_header() {
	use forge_judge::honest::{play_chain, play_chain_traced};
	use serde_json::json;
	let data = audience_data();
	let root = audience_guide("test/root", json!({}), json!([]));
	let cases = [
		("class mismatch", json!({ "classes": ["MAGE"] }), audience_persona("Human", "Alliance", "WARRIOR"), false),
		("race mismatch", json!({ "races": ["Orc"] }), audience_persona("Human", "Alliance", "WARRIOR"), false),
		("faction mismatch", json!({ "faction": "Horde" }), audience_persona("Human", "Alliance", "WARRIOR"), false),
		("matching headers", json!({ "classes": ["WARRIOR"], "races": ["Human"], "faction": "Alliance" }), audience_persona("Human", "Alliance", "WARRIOR"), true),
		("Undead header alias", json!({ "classes": ["Mage"], "races": ["Undead"], "faction": "Horde" }), audience_persona("Scourge", "Horde", "MAGE"), true),
		("Undead persona alias", json!({ "classes": ["MAGE"], "races": ["Scourge"], "faction": "Horde" }), audience_persona("Undead", "Horde", "MAGE"), true),
		("absent headers", json!({}), audience_persona("Human", "Alliance", "WARRIOR"), true),
	];
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		for (name, header, persona, admitted) in &cases {
			let tail = audience_guide("test/tail", header.clone(), json!([{ "t": "turnin", "quest": 783 }]));
			let chain = [&root, &tail];
			let direct = play_chain(&chain, &data, persona, None, None, &opts);
			let (traced, trace) = play_chain_traced(&chain, &data, persona, &opts);
			for findings in [&direct, &traced] {
				if *admitted {
					assert!(findings.iter().any(|f| f.rule == "R5" && f.guide == "test/tail" && f.reason.contains("never accepted")), "legacy={}, {name}: {findings:#?}", opts.legacy);
				} else {
					assert!(findings.is_empty(), "legacy={}, {name}: {findings:#?}", opts.legacy);
				}
			}
			let verbs: Vec<_> = trace.iter().map(|row| row.verb.as_str()).collect();
			assert_eq!(verbs, if *admitted { vec!["turnin"] } else { vec![] }, "legacy={}, {name}", opts.legacy);
		}
	}
}

#[test]
fn excluded_middle_guide_cannot_supply_quest_state_to_an_eligible_tail() {
	use forge_judge::honest::{play_chain, play_chain_traced};
	use serde_json::json;
	let data = audience_data();
	let root = audience_guide("test/root", json!({}), json!([]));
	let middle = audience_guide("test/mage-middle", json!({ "classes": ["MAGE"] }), json!([{ "t": "accept", "quest": 783 }]));
	let tail = audience_guide("test/warrior-tail", json!({ "classes": ["WARRIOR"] }), json!([{ "t": "turnin", "quest": 783 }]));
	let chain = [&root, &middle, &tail];
	let persona = audience_persona("Human", "Alliance", "WARRIOR");
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		let direct = play_chain(&chain, &data, &persona, None, None, &opts);
		let (traced, trace) = play_chain_traced(&chain, &data, &persona, &opts);
		for findings in [&direct, &traced] {
			assert!(findings.iter().any(|f| f.rule == "R5" && f.guide == "test/warrior-tail" && f.reason.contains("never accepted")), "legacy={}: {findings:#?}", opts.legacy);
			assert!(!findings.iter().any(|f| f.guide == "test/mage-middle"));
		}
		let goals: Vec<_> = trace.iter().map(|row| (row.file.as_str(), row.verb.as_str())).collect();
		assert_eq!(goals, [("test/warrior-tail", "turnin")], "legacy={}", opts.legacy);
	}
}

#[test]
fn eligible_guide_still_reports_a_wrong_class_quest() {
	use forge_judge::honest::{play_chain, play_chain_traced};
	use serde_json::json;
	let data = audience_data();
	// Committed fixture 9101 is Hunter Training, with the Hunter class mask.
	let guide = audience_guide("test/warrior", json!({ "classes": ["WARRIOR"] }), json!([{ "t": "accept", "quest": 9101 }, { "t": "turnin", "quest": 9101 }]));
	let persona = audience_persona("Human", "Alliance", "WARRIOR");
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		let direct = play_chain(&[&guide], &data, &persona, None, None, &opts);
		let (traced, trace) = play_chain_traced(&[&guide], &data, &persona, &opts);
		for findings in [&direct, &traced] {
			assert_eq!(findings.iter().any(|f| f.rule == "R6" && f.reason.contains("class mask")), !opts.legacy, "legacy={}: {findings:#?}", opts.legacy);
		}
		assert_eq!(trace.iter().map(|row| row.verb.as_str()).collect::<Vec<_>>(), ["accept", "turnin"]);
	}
}

#[test]
fn later_headers_sample_root_compatible_races_on_each_eligible_side() {
	let data = audience_data();
	for (root_header, tail_header, race, faction) in [
		("faction Alliance", "faction Alliance\nrace Dwarf", "Dwarf", "Alliance"),
		("", "faction Horde\nrace Skyborne", "Skyborne", "Horde"),
		("faction Horde", "race Skyborne", "Skyborne", "Horde"),
		("race Skyborne", "faction Horde", "Skyborne", "Horde"),
	] {
		let pack = Pack::new();
		for (file, id, header, body) in [
			("01-start.guide", "start", format!("{root_header}\nnext forever/test/end"), "step Begin\n  note Begin".to_string()),
			("02-end.guide", "end", format!("{tail_header}\nclass Warrior"), format!("step Work\n{UNFINISHED}")),
		] {
			std::fs::write(pack.0.join(file), format!("guide forever/test/{id}\ntitle {id}\nlevels 1-10\nzone Elwynn Forest\n{header}\n\n{body}\n")).unwrap();
		}
		for opts in [HonestOpts::default(), HonestOpts::legacy()] {
			for side in [None, Some(faction.to_string())] {
				let run = PackRun { filter: Some("02-end".into()), faction: side, ..Default::default() };
				let report = play_pack(&pack.0, &data, None, &run, &opts).expect("an eligible race must be sampled");
				let personas: Vec<_> = report.findings.iter().filter(|f| f.rule == "R5").flat_map(|f| f.personas.iter().map(|(r, c)| (r.as_str(), c.as_str()))).collect();
				assert_eq!(personas, [(race, "WARRIOR")], "legacy={}, {root_header} -> {tail_header}", opts.legacy);
			}
		}
	}
}

#[test]
fn named_and_explicit_classes_are_sampled_within_the_later_guides_faction() {
	let data = audience_data();
	for explicit in [false, true] {
		let pack = chain("", "", &format!("step Work\n{UNFINISHED}"));
		for file in ["01-start.guide", "02-end.guide"] {
			let path = pack.0.join(file);
			let header = if file != "02-end.guide" {
				""
			} else if explicit {
				"faction Horde\n"
			} else {
				"faction Horde\nclass Druid\n"
			};
			let text = std::fs::read_to_string(&path).unwrap().replace("faction Alliance\n", header);
			std::fs::write(path, text).unwrap();
		}
		for opts in [HonestOpts::default(), HonestOpts::legacy()] {
			for filter in [None, Some("02-end".into())] {
				let result = play_pack(&pack.0, &data, None, &PackRun { filter, classes: explicit.then(|| vec!["DRUID".into()]), ..Default::default() }, &opts).expect("Horde Druid must be sampled");
				let personas: Vec<_> = result.findings.iter().filter(|f| f.rule == "R5").flat_map(|f| f.personas.iter().map(|(r, c)| (r.as_str(), c.as_str()))).collect();
				assert_eq!(personas, [("Tauren", "DRUID")], "legacy={}", opts.legacy);
			}
		}
	}
}
