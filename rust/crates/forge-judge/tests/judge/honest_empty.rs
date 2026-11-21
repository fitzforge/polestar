//! An honest pack run must dispatch a character, not just select guide files.
use forge_judge::honest::{play_pack, HonestOpts, PackResult, PackRun};
use std::path::{Path, PathBuf};
use std::sync::atomic::{AtomicUsize, Ordering};

struct Pack(PathBuf);
impl Pack {
	fn new() -> Self {
		static NEXT: AtomicUsize = AtomicUsize::new(0);
		let path = Path::new(env!("CARGO_TARGET_TMPDIR")).join(format!("honest-empty-{}-{}", std::process::id(), NEXT.fetch_add(1, Ordering::Relaxed)));
		std::fs::create_dir_all(&path).unwrap();
		Self(path)
	}
	fn guide(&self, id: &str, header: &str, body: &str) {
		std::fs::write(self.0.join(format!("{id}.guide")), format!("guide test/{id}\ntitle {id}\nfaction Alliance\nrace Human\nlevels 1-10\nzone Elwynn Forest\n{header}\n\nstep Work\n{body}\n"))
			.unwrap();
	}
	fn mage(broken: bool) -> Self {
		let pack = Self::new();
		let kills = if broken { "" } else { "  kill 6 x10 quest 7.1\n" };
		pack.guide("mage", "class Mage", &format!("  accept 783\n  turnin 783\n  accept 7\n{kills}  turnin 7"));
		pack
	}
	fn play(&self, run: &PackRun, opts: &HonestOpts) -> Result<PackResult, String> {
		let data = forge_guide::data::load_data(&Path::new(env!("CARGO_MANIFEST_DIR")).join("../../../tests/fixtures/dsl/data")).unwrap();
		play_pack(&self.0, &data, None, run, opts)
	}
}
impl Drop for Pack {
	fn drop(&mut self) {
		let _ = std::fs::remove_dir_all(&self.0);
	}
}

fn error(result: Result<PackResult, String>) -> String {
	match result {
		Ok(r) => panic!("expected no-play error, got {} guides and {} findings", r.played, r.findings.len()),
		Err(e) => e,
	}
}

#[test]
fn no_character_for_the_selected_class_race_or_faction_is_an_error() {
	let pack = Pack::mage(true);
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		for run in [
			PackRun { classes: Some(vec!["WARRIOR".into()]), ..Default::default() },
			PackRun { race: Some("Orc".into()), ..Default::default() },
			PackRun { faction: Some("Horde".into()), ..Default::default() },
		] {
			let err = error(pack.play(&run, &opts));
			assert!(err.contains("nothing played") && err.contains("no eligible characters"), "{run:?}: {err}");
		}
	}
}

#[test]
fn an_unmatched_guide_filter_has_a_distinct_error() {
	let pack = Pack::mage(true);
	let run = PackRun { filter: Some("missing-guide".into()), classes: Some(vec!["WARRIOR".into()]), ..Default::default() };
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		let err = error(pack.play(&run, &opts));
		assert!(err.contains("no guide matches \"missing-guide\""), "{err}");
		assert!(!err.contains("no eligible characters"), "{err}");
	}
}

#[test]
fn an_empty_pack_has_a_distinct_error() {
	let pack = Pack::new();
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		let err = error(pack.play(&PackRun::default(), &opts));
		assert!(err.contains("no guides in the pack"), "{err}");
		assert!(!err.contains("no eligible characters"), "{err}");
	}
}

#[test]
fn an_unrelated_compatible_guide_does_not_count_as_playing_the_selection() {
	let pack = Pack::mage(true);
	pack.guide("warrior", "class Warrior", "  note Begin");
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		let run = PackRun { classes: Some(vec!["WARRIOR".into()]), ..Default::default() };
		assert!(pack.play(&run, &opts).is_ok(), "the unfiltered pack does dispatch Warrior");
		let selected = PackRun { filter: Some("test/mage".into()), ..run };
		assert!(error(pack.play(&selected, &opts)).contains("nothing played"));
	}
}

#[test]
fn a_compatible_compiled_but_unselected_branch_does_not_count() {
	let pack = Pack::mage(true);
	pack.guide("start", "class Mage\nnext test/mage, test/warrior", "  note Begin");
	pack.guide("warrior", "", "  note Another route");
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		let run = PackRun { filter: Some("test/mage".into()), classes: Some(vec!["WARRIOR".into()]), ..Default::default() };
		// with_chain compiles both choices. Honest play follows the first, so
		// the second choice's compatible Warrior must not satisfy this run.
		let err = error(pack.play(&run, &opts));
		assert!(err.contains("nothing played"), "{err}");
	}
}

#[test]
fn a_selected_later_guide_counts_its_chain_dispatch_and_keeps_the_selected_guide_count() {
	let pack = Pack::new();
	pack.guide("start", "class Mage\nnext test/end", "  note Begin");
	pack.guide("end", "", "  note End");
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		let run = PackRun { filter: Some("test/end".into()), classes: Some(vec!["MAGE".into()]), ..Default::default() };
		let result = pack.play(&run, &opts).expect("the selected guide is played from its chain's root");
		assert_eq!(result.played, 1);
		assert!(result.findings.is_empty());
	}
}

#[test]
fn matching_characters_keep_clean_results_and_real_quest_findings() {
	let clean = Pack::mage(false);
	let broken = Pack::mage(true);
	let run = PackRun { classes: Some(vec!["MAGE".into()]), ..Default::default() };
	for opts in [HonestOpts::default(), HonestOpts::legacy()] {
		let good = clean.play(&run, &opts).expect("play matching character");
		assert_eq!(good.played, 1);
		assert!(good.findings.is_empty(), "{:#?}", good.findings);
		let bad = broken.play(&run, &opts).expect("real findings are still a successful simulation");
		assert_eq!(bad.played, 1);
		assert!(bad.findings.iter().any(|f| f.rule == "R5" && f.cls == "MAGE" && f.reason.contains("0/10")));
	}
}
