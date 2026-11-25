//! `forge guide legacy-steps` takes an earlier release's steps from the guides it shipped (its addon
//! folder's Polestar_Guides*/Guides.lua), not from its guide sources compiled again: a save holds the keys of
//! the steps as they shipped, and a later compiler or data could name a step differently.

use std::path::{Path, PathBuf};
use std::process::Command;

fn repo() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

/// A fresh scratch folder.
fn tmp(name: &str) -> PathBuf {
	let d = Path::new(env!("CARGO_TARGET_TMPDIR")).join("guide-legacy-steps").join(name);
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

fn write(path: &Path, text: &str) {
	std::fs::create_dir_all(path.parent().unwrap()).unwrap();
	std::fs::write(path, text).unwrap();
}

/// `forge guide legacy-steps` against the compiler's fixture guides and data: (exit code, stderr).
fn legacy_steps(olds: &[&Path], out: &Path) -> (i32, String) {
	let fixtures = repo().join("tests/fixtures/dsl");
	let mut cmd = Command::new(env!("CARGO_BIN_EXE_forge"));
	cmd.current_dir(repo()).args(["guide", "legacy-steps", "--current"]).arg(fixtures.join("guides")).arg("--data").arg(fixtures.join("data")).arg("--out").arg(out);
	for old in olds {
		cmd.arg("--old").arg(old);
	}
	let o = cmd.output().unwrap();
	(o.status.code().unwrap_or(-1), String::from_utf8(o.stderr).unwrap())
}

#[test]
fn an_earlier_release_s_steps_are_keyed_as_its_shipped_guides_have_them() {
	let dir = tmp("shipped");
	let addon = dir.join("v0.0.1/addon");
	write(&addon.join("Polestar_Guides/Pack.lua"), "local ADDON = ...\n\nPolestar.RegisterPack({ addon = ADDON, id = \"guides\", format = 11, title = \"Polestar Guides\", version = \"0.0.1\" })\n");
	// Not a leveling guide: left out.
	write(
		&addon.join("Polestar_Guides/Guides.lua"),
		"do\n\tlocal function register()\n\t\tPolestar.RegisterGuide({ id = \"forever/class/warrior/x\", pack = \"guides\", title = \"X\", category = \"Class\", steps = { { goals = { { t = \"accept\", quest = 1 } } } } })\n\tend\n\tregister()\nend\n",
	);
	// The fixture's Northshire as an earlier release shipped it: its first step as today's (left out), then a
	// step no compile of today's sources gives, and a title it no longer has (shipped as a token, named by the
	// guide's `names`).
	write(
		&addon.join("Polestar_Guides_Alliance/Guides.lua"),
		r#"-- Source: forever/alliance/human/01-northshire.guide
do
	local function register()
		Polestar.RegisterGuide({
			id = "forever/alliance/human/01-northshire",
			pack = "guides",
			title = "{area:9}",
			names = { ["area:9"] = "Northshire" },
			faction = "Alliance",
			steps = {
				{ title = "Deputy Willem", goals = { { t = "accept", quest = 783 }, { t = "turnin", quest = 783 }, { t = "accept", quest = 7 }, { t = "accept", quest = 5261, npc = 196 }, { t = "accept", quest = 33 } } },
				{ title = "Fly to Menethil Harbor", goals = { { t = "goto", text = "{zone:1455} flight master", map = 1455, x = 55.9, y = 47.9, f = "e" }, { t = "fly", location = "Menethil Harbor", node = 7, area = 150 } } },
			},
		})
	end
	register()
end
Polestar.RetireGuides({ "forever/alliance/human/00-old" })
"#,
	);
	// A race folder's routes are not guides: never run.
	write(&addon.join("Polestar_Guides_Human/Legs.lua"), "error(\"Legs.lua was run\")\n");
	let out = dir.join("LegacySteps.lua");
	let (status, stderr) = legacy_steps(&[&addon], &out);
	assert_eq!(status, 0, "{stderr}");
	let lua = std::fs::read_to_string(&out).unwrap();
	assert!(lua.contains("\t[\"forever/alliance/human/01-northshire\"] = {\n\t\ttitles = { [\"0.0.1\"] = \"Northshire\" },\n\t\t[1308409580] = \"goto:1455,fly:Menethil Harbor\",\n\t},\n"), "{lua}");
	assert!(!lua.contains("accept:783,turnin:783"), "{lua}");
	assert!(!lua.contains("forever/class/"), "{lua}");
	assert!(stderr.contains(": 1 steps of 1 guides;"), "{stderr}");
}

#[test]
fn an_old_folder_without_shipped_guides_is_refused() {
	let dir = tmp("sources");
	let guides = repo().join("tests/fixtures/dsl/guides");
	let out = dir.join("LegacySteps.lua");
	let (status, stderr) = legacy_steps(&[&guides], &out);
	assert_eq!(status, 1, "{stderr}");
	assert!(stderr.contains("no Polestar_Guides*/Guides.lua: pass a release's addon folder (git archive <tag> addon)"), "{stderr}");
	assert!(!out.exists());
}
