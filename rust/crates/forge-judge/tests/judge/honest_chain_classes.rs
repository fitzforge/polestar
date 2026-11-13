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
