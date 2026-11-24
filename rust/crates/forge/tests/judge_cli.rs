//! Character labels must select the same honest play and walk as their canonical names.
use serde_json::Value;
use std::path::{Path, PathBuf};
use std::process::{Command, Output};
use std::sync::atomic::{AtomicUsize, Ordering};

fn repo() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

struct Fixture(PathBuf);
impl Fixture {
	fn new(faction: &str, race: &str) -> Self {
		static NEXT: AtomicUsize = AtomicUsize::new(0);
		let dir = Path::new(env!("CARGO_TARGET_TMPDIR")).join(format!("judge-cli-{}-{}", std::process::id(), NEXT.fetch_add(1, Ordering::Relaxed)));
		std::fs::create_dir_all(dir.join("guides")).unwrap();
		// The committed DSL data requires ten kills for quest 7. Omit them so
		// an empty honest run cannot pass an equality assertion unnoticed.
		std::fs::write(
			dir.join("guides/test.guide"),
			format!(
				"guide test/character\ntitle Character fixture\nfaction {faction}\nrace {race}\nclass Priest\nlevels 1-10\nzone Elwynn Forest\n\nstep Kobolds\n  accept 783\n  turnin 783\n  accept 7\n  turnin 7\n"
			),
		)
		.unwrap();
		std::fs::write(dir.join("levels.json"), serde_json::json!({ "goals": vec![serde_json::json!({ "lvl": 2, "time": 0, "lvlAfter": 2, "timeAfter": 0 }); 4] }).to_string()).unwrap();
		Self(dir)
	}
	fn run(&self, faction: &str, race: &str, legacy: bool, levels: bool) -> Output {
		let root = if levels { repo().join("rust/tests/golden/world/root") } else { self.0.clone() };
		let mut cmd = Command::new(env!("CARGO_BIN_EXE_forge"));
		cmd.current_dir(repo()).arg("judge").arg(self.0.join("guides")).arg("--root").arg(root).arg("--data").arg(repo().join("tests/fixtures/dsl/data")).args([
			"--faction",
			faction,
			"--race",
			race,
			"--class",
			"Priest",
			"--json",
		]);
		if legacy {
			cmd.arg("--legacy");
		}
		if levels {
			cmd.arg("--levels").arg(self.0.join("levels.json"));
		}
		cmd.output().unwrap()
	}
}
impl Drop for Fixture {
	fn drop(&mut self) {
		let _ = std::fs::remove_dir_all(&self.0);
	}
}

fn report(out: Output) -> Value {
	assert_eq!(out.status.code(), Some(0), "{}{}", String::from_utf8_lossy(&out.stderr), String::from_utf8_lossy(&out.stdout));
	serde_json::from_slice(&out.stdout).expect("judge JSON")
}

fn assert_played(report: &Value, race: &str) {
	assert_eq!(report["honest"]["played"], 1);
	assert!(
		report["honest"]["findings"].as_array().unwrap().iter().any(|f| f["rule"] == "R5" && f["race"] == race && f["reason"].as_str().unwrap().contains("0/10")),
		"the fixture's missing kills must be found for {race}: {report}"
	);
}

#[test]
fn faction_case_and_short_names_keep_the_honest_findings() {
	for (canonical, race, aliases) in [("Alliance", "Human", ["alliance", "ALLIANCE", "a"]), ("Horde", "Scourge", ["horde", "HORDE", "h"])] {
		let fixture = Fixture::new(canonical, race);
		for legacy in [false, true] {
			let expected = report(fixture.run(canonical, race, legacy, false));
			assert_played(&expected, race);
			for alias in aliases {
				let actual = report(fixture.run(alias, race, legacy, false));
				assert_eq!(actual["faction"], canonical);
				assert_eq!(actual["race"], if race == "Scourge" { "Undead" } else { race });
				assert_eq!(actual["honest"], expected["honest"], "faction {alias}, legacy={legacy}");
			}
		}
	}
}

#[test]
fn race_case_and_aliases_keep_the_honest_findings() {
	for (faction, canonical, aliases) in
		[("Alliance", "Human", vec!["human", "HUMAN"]), ("Alliance", "NightElf", vec!["Night Elf", "nightelf", "night-elf", "night_elf"]), ("Horde", "Scourge", vec!["Undead", "undead", "scourge"])]
	{
		let fixture = Fixture::new(faction, canonical);
		for legacy in [false, true] {
			let expected = report(fixture.run(faction, canonical, legacy, false));
			assert_played(&expected, canonical);
			for alias in &aliases {
				let actual = report(fixture.run(faction, alias, legacy, false));
				assert_eq!(actual["faction"], faction);
				assert_eq!(actual["race"], if canonical == "Scourge" { "Undead" } else { canonical });
				assert_eq!(actual["honest"], expected["honest"], "race {alias}, legacy={legacy}");
			}
		}
	}
}

#[test]
fn undead_aliases_keep_the_simulator_start_label() {
	let fixture = Fixture::new("Horde", "Scourge");
	let sim = fixture.0.join("sim");
	std::fs::create_dir_all(&sim).unwrap();
	let file = std::fs::File::open(repo().join("rust/tests/golden/world/expected/world-horde.json.gz")).unwrap();
	let mut world: Value = serde_json::from_reader(flate2::read::GzDecoder::new(file)).unwrap();
	// This slice contains only Orc/Troll starts. Add a synthetic Undead start
	// at its existing fixture point to exercise the simulator's exact label lookup.
	world["starts"]["Undead"] = world["starts"]["Orc"].clone();
	std::fs::write(sim.join("world-horde.json"), serde_json::to_vec(&world).unwrap()).unwrap();
	let run = |race: &str, legacy: bool| {
		let mut cmd = Command::new(env!("CARGO_BIN_EXE_forge"));
		cmd.current_dir(repo())
			.arg("judge")
			.arg(fixture.0.join("guides"))
			.arg("--root")
			.arg(repo().join("rust/tests/golden/world/root"))
			.arg("--data")
			.arg(repo().join("tests/fixtures/dsl/data"))
			.arg("--sim")
			.arg(&sim)
			.args(["--faction", "Horde", "--race", race, "--class", "Priest", "--json"]);
		if legacy {
			cmd.arg("--legacy");
		}
		report(cmd.output().unwrap())
	};
	for legacy in [false, true] {
		let expected = run("Undead", legacy);
		assert_played(&expected, "Scourge");
		assert!(expected["walk"]["chain"].as_array().is_some_and(|c| !c.is_empty()), "{expected}");
		for alias in ["Scourge", "scourge", "undead"] {
			let actual = run(alias, legacy);
			assert_eq!(actual["race"], "Undead");
			assert_eq!(actual["honest"], expected["honest"]);
			assert_eq!(actual["walk"], expected["walk"]);
		}
	}
}

#[test]
fn unknown_character_names_are_usage_errors_with_or_without_levels() {
	let fixture = Fixture::new("Alliance", "Human");
	for levels in [false, true] {
		for (faction, race, diagnostic) in [("NotAFaction", "Human", "--faction NotAFaction"), ("Alliance", "NotARace", "--race NotARace")] {
			let out = fixture.run(faction, race, false, levels);
			assert_eq!(out.status.code(), Some(2), "{}{}", String::from_utf8_lossy(&out.stderr), String::from_utf8_lossy(&out.stdout));
			assert!(String::from_utf8_lossy(&out.stderr).contains(diagnostic), "{}", String::from_utf8_lossy(&out.stderr));
			assert!(out.stdout.is_empty(), "invalid input must not produce a judge report");
		}
	}
}

#[test]
fn character_labels_match_in_both_honest_and_levels_walk_results() {
	let fixture = Fixture::new("Alliance", "Human");
	for legacy in [false, true] {
		let expected = report(fixture.run("Alliance", "Human", legacy, true));
		assert_played(&expected, "Human");
		assert!(expected["walk"]["chain"].as_array().is_some_and(|c| !c.is_empty()), "{expected}");
		let actual = report(fixture.run("alliance", "human", legacy, true));
		assert_eq!(actual["honest"], expected["honest"]);
		assert_eq!(actual["walk"], expected["walk"]);
	}
}
