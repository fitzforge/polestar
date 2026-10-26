//! Lint and compile on another pack: the pack rules, our guides read as context
//! (tests/fixtures/packs/context stands in for them), house rules as warnings, the nearest pack.json, and
//! dist/<folder>/ output. (The release zip of a pack is `forge release pack`'s test.)

use std::path::{Path, PathBuf};
use std::process::Command;

fn repo() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

fn packs() -> PathBuf {
	repo().join("tests/fixtures/packs")
}

fn joe() -> String {
	s(&packs().join("joe"))
}

fn context() -> String {
	s(&packs().join("context"))
}

fn data() -> String {
	s(&repo().join("tests/fixtures/dsl/data"))
}

fn s(p: &Path) -> String {
	p.to_string_lossy().into_owned()
}

fn tmp(name: &str) -> PathBuf {
	let d = Path::new(env!("CARGO_TARGET_TMPDIR")).join("guide-cli-pack").join(name);
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

struct Run {
	status: i32,
	stdout: String,
	stderr: String,
}

fn run_in(args: &[&str], cwd: &Path) -> Run {
	let o = Command::new(env!("CARGO_BIN_EXE_forge")).current_dir(cwd).arg("guide").args(args).output().unwrap();
	Run { status: o.status.code().unwrap_or(-1), stdout: String::from_utf8(o.stdout).unwrap(), stderr: String::from_utf8(o.stderr).unwrap() }
}

fn run(args: &[&str]) -> Run {
	run_in(args, &repo())
}

/// lint/compile on a pack with the fixture data and the context fixture.
fn pack_cmd(cmd: &str, dir: &str, extra: &[&str]) -> Run {
	let (d, c) = (data(), context());
	let mut all = vec![cmd, "--pack", dir, "--data", &d, "--context", &c, "--context-data", &d];
	all.extend_from_slice(extra);
	run(&all)
}

fn copy_dir(from: &Path, to: &Path) {
	std::fs::create_dir_all(to).unwrap();
	for e in std::fs::read_dir(from).unwrap().flatten() {
		let p = e.path();
		if p.is_dir() {
			copy_dir(&p, &to.join(e.file_name()));
		} else {
			std::fs::copy(&p, to.join(e.file_name())).unwrap();
		}
	}
}

/// A scratch copy of the joe pack, with extra guides (name, text).
fn joe_copy(name: &str, extra: &[(&str, String)]) -> String {
	let dir = tmp(name).join("joe");
	copy_dir(&packs().join("joe"), &dir);
	for (n, text) in extra {
		std::fs::write(dir.join("guides").join(n), text).unwrap();
	}
	s(&dir)
}

fn guide(id: &str, body: &[&str]) -> String {
	let mut l = vec![format!("guide {id}"), "title Extra".into(), "faction Alliance".into(), "levels 6-8".into(), "zone Elwynn Forest".into()];
	l.extend(body.iter().map(|b| b.to_string()));
	l.push(String::new());
	l.join("\n")
}

fn re(p: &str) -> regex::Regex {
	regex::Regex::new(p).unwrap()
}

#[track_caller]
fn has(text: &str, p: &str) {
	assert!(re(p).is_match(text), "no /{p}/ in:\n{text}");
}

fn pipes(stderr: &str) -> Vec<String> {
	stderr.lines().filter(|l| l.contains("contains \"|\"")).map(|l| re(r"^.*e\.guide:").replace(l, "e.guide:").into_owned()).collect()
}

#[test]
fn find_pack_dir_walks_up_to_the_nearest_pack_json_resolve_pack_falls_back_to_our_guides() {
	use forge_guide::project::find_pack_dir;
	let joe = packs().join("joe");
	assert_eq!(find_pack_dir(&joe.join("guides")).as_deref(), Some(joe.as_path()));
	let lone = tmp("lone");
	assert_eq!(find_pack_dir(&lone), None);
	// Without a pack.json above the working directory, the command works on our guides (--root's).
	let ours = run_in(&["lint", "--root", &s(&repo()), "--guides", &s(&packs().join("context/guides")), "--data", &data()], &lone);
	assert!(ours.stdout.contains("lint") || ours.stderr.contains("lint"), "{}", ours.stderr);
	let (manifest, diags) = forge_guide::manifest::read_manifest(&lone, false);
	assert!(manifest.is_none());
	has(&diags[0].message, "no pack.json");
}

#[test]
fn the_joe_pack_lints_clean_with_our_guides_as_context() {
	let r = pack_cmd("lint", &joe(), &[]);
	assert_eq!(r.status, 0, "{}", r.stderr);
	has(&r.stdout, r"lint ok: 2 files, 2 guides: 0 errors, 1 warning");
}

#[test]
fn a_pack_owns_only_ids_under_its_id_forever_x_and_joe_routes_x_are_errors() {
	let dir = joe_copy("owns", &[("x.guide", guide("forever/x", &["", "step S", "  level 7"])), ("y.guide", guide("joe-routes/x", &["", "step S", "  level 7"]))]);
	let r = pack_cmd("lint", &dir, &[]);
	assert_eq!(r.status, 1);
	has(&r.stderr, r#"x\.guide:1: error: guide id "forever/x" is outside pack "joe": its guide ids start with "joe/""#);
	has(&r.stderr, r#"y\.guide:1: error: guide id "joe-routes/x" is outside pack "joe": its guide ids start with "joe/""#);
}

#[test]
fn next_may_hand_over_to_our_guides_an_unknown_target_is_an_error() {
	assert!(!pack_cmd("lint", &joe_copy("next-ok", &[]), &[]).stderr.contains("unknown guide"));
	let r = pack_cmd("lint", &joe_copy("next-bad", &[("c.guide", guide("joe/c", &["next forever/nope", "", "step S", "  level 7"]))]), &[]);
	assert_eq!(r.status, 1);
	has(&r.stderr, r#"c\.guide:6: error: `next` points to unknown guide "forever/nope""#);
}

#[test]
fn turnins_one_accepted_earlier_in_the_pack_chain_is_fine_one_no_chain_accepts_is_the_existing_error() {
	assert!(!pack_cmd("lint", &joe(), &[]).stderr.contains("never accepted"));
	let r = pack_cmd("lint", &joe_copy("turnin", &[("d.guide", guide("joe/d", &["", "step S", "  turnin 179"]))]), &[]);
	assert_eq!(r.status, 1);
	has(&r.stderr, r"d\.guide:8: error: `turnin` for quest 179 that is never accepted earlier in this guide or a guide chaining into it");
}

#[test]
fn required_elite_work_is_a_warning_in_a_pack_and_an_error_in_ours() {
	let pack = pack_cmd("lint", &joe(), &[]);
	assert_eq!(pack.status, 0, "{}", pack.stderr);
	has(&pack.stderr, r"joe/guides/b\.guide:12: warning: `kill` npc 95003 \(Elite Kobold\) is elite");
	let ours = run(&["lint", "--guides", &s(&packs().join("context/guides")), "--data", &data()]);
	assert_eq!(ours.status, 1);
	has(&ours.stderr, r"02-next\.guide:12: error: `kill` npc 95003 \(Elite Kobold\) is elite");
}

#[test]
fn a_pipe_in_a_pack_title_prints_literally_a_warning() {
	let text = ["guide joe/e", "title Joe |cffff0000Red", "faction Alliance", "levels 6-8", "zone Elwynn Forest", "", "step S", "  level 7", ""].join("\n");
	let r = pack_cmd("lint", &joe_copy("pipe-title", &[("e.guide", text)]), &[]);
	assert_eq!(r.status, 0, "{}", r.stderr);
	has(&r.stderr, r#"e\.guide:2: warning: `title` contains "\|", which prints literally in game"#);
}

#[test]
fn a_pipe_is_reported_at_the_line_the_author_wrote_it_naming_the_keyword() {
	let text = [
		"guide joe/e",
		"title Extra",
		"faction Alliance",
		"levels 6-8",
		"zone Elwynn Forest",
		"con Slow",
		"pro Fast | fun",
		"",
		"step S",
		"  talk 197 \"Marshal |cffMcBride\"",
		"  accept 783 \"A |cffThreat\"",
		"  turnin 783 choose 6480 \"Bag|x\" common",
		"",
	]
	.join("\n");
	let r = pack_cmd("lint", &joe_copy("pipe-lines", &[("e.guide", text)]), &[]);
	assert_eq!(r.status, 0, "{}", r.stderr);
	assert_eq!(
		pipes(&r.stderr),
		[
			"e.guide:7: warning: `pro` contains \"|\", which prints literally in game",
			"e.guide:10: warning: the NPC name contains \"|\", which prints literally in game",
			"e.guide:11: warning: the quest title contains \"|\", which prints literally in game",
			"e.guide:12: warning: the item name contains \"|\", which prints literally in game",
		]
	);
}

#[test]
fn a_pipe_in_the_pack_author_warns_once_in_pack_json_not_on_every_guide() {
	let dir = joe_copy("pipe-author", &[]);
	let file = Path::new(&dir).join("pack.json");
	let mut m: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(&file).unwrap()).unwrap();
	m["author"] = "Jo|e".into();
	std::fs::write(&file, serde_json::to_string_pretty(&m).unwrap()).unwrap();
	let r = pack_cmd("lint", &dir, &[]);
	assert_eq!(r.status, 0, "{}", r.stderr);
	let p: Vec<&str> = r.stderr.lines().filter(|l| l.contains("contains \"|\"")).collect();
	assert_eq!(p.len(), 1, "{}", r.stderr);
	has(p[0], r"pack\.json:\d+: warning: `author` contains");
}

#[test]
fn a_context_or_context_data_folder_that_does_not_exist_is_a_usage_error() {
	let missing = s(&tmp("ctx-missing").join("missing"));
	let (d, c, j) = (data(), context(), joe());
	for name in ["lint", "compile"] {
		let a = run(&[name, "--pack", &j, "--data", &d, "--context", &missing, "--context-data", &d]);
		assert_eq!(a.status, 2, "{}", a.stderr);
		has(&a.stderr, r"--context .*missing is not a folder");
		let b = run(&[name, "--pack", &j, "--data", &d, "--context", &c, "--context-data", &missing]);
		assert_eq!(b.status, 2, "{}", b.stderr);
		has(&b.stderr, r"--context-data .*missing is not a folder");
	}
}

#[test]
fn another_pack_without_reference_data_stops_with_one_error_the_hint_names_context_data_when_that_data_is_missing_too() {
	let empty = s(&tmp("pack-empty"));
	let (d, c, j) = (data(), context(), joe());
	let none = run(&["lint", "--pack", &j, "--data", &empty, "--context", &c, "--context-data", &empty]);
	assert_eq!(none.status, 1, "{}", none.stderr);
	assert_eq!(none.stderr.lines().filter(|l| l.contains("error:")).count(), 1, "{}", none.stderr);
	has(&none.stderr, r"hint: run `forge data build`, or pass --data <dir>, and --context-data <dir> for our guides read as context;");
	let ctx = run(&["lint", "--pack", &j, "--data", &empty, "--context", &c, "--context-data", &d]);
	assert_eq!(ctx.status, 1, "{}", ctx.stderr);
	assert!(!ctx.stderr.contains("--context-data"), "{}", ctx.stderr);
}

#[test]
fn missing_default_reference_data_no_guide_is_read_without_the_packs_data_missing_context_data_alone_is_a_warning() {
	use forge_guide::project::{load_project_data, no_reference_data};
	let missing = tmp("default-data").join("no-data");
	// The pack's --data and the default context data both missing: one error, on the data folder.
	let both = no_reference_data(&missing, Some(&missing), false).unwrap();
	assert_eq!(both.errors().iter().map(|d| d.file.clone().unwrap()).collect::<Vec<_>>(), [s(&missing)]);
	// The pack's data present: none; the missing context data loads as a warning naming its folder.
	assert!(no_reference_data(Path::new(&data()), Some(&missing), false).is_none());
	let mut diag = forge_guide::diag::Diagnostics::new();
	load_project_data(&missing, &mut diag).unwrap();
	assert_eq!(diag.warnings().iter().filter(|d| d.message.contains("reference data not found")).map(|d| d.file.clone().unwrap()).collect::<Vec<_>>(), [s(&missing)]);
}

#[test]
fn our_guides_own_diagnostics_are_not_reported_for_another_pack() {
	let ours = run(&["lint", "--guides", &s(&packs().join("context/guides")), "--data", &data()]);
	has(&ours.stderr, r"02-next\.guide:11: warning: quest 7 .* is accepted but never turned in");
	let r = pack_cmd("lint", &joe(), &[]);
	assert!(!re("02-next|01-start|never turned in").is_match(&r.stderr), "{}", r.stderr);
}

#[test]
fn without_pack_lint_and_compile_use_the_nearest_pack_json_compile_writes_dist_folder() {
	let dir = joe_copy("nearest", &[]);
	let cwd = Path::new(&dir).join("guides");
	let (d, c) = (data(), context());
	let root = s(&repo());
	let args = ["--root", &root, "--data", &d, "--context", &c, "--context-data", &d];
	let with = |cmd: &str, more: &[&str]| {
		let mut a = vec![cmd];
		a.extend_from_slice(&args);
		a.extend_from_slice(more);
		run_in(&a, &cwd)
	};
	let lint = with("lint", &[]);
	assert_eq!(lint.status, 0, "{}", lint.stderr);
	has(&lint.stdout, "lint ok: 2 files, 2 guides");
	let compile = with("compile", &[]);
	assert_eq!(compile.status, 0, "{}", compile.stderr);
	let out = Path::new(&dir).join("dist/PolestarPack_Joe");
	let mut files: Vec<String> = std::fs::read_dir(&out).unwrap().flatten().map(|e| e.file_name().to_string_lossy().into_owned()).collect();
	files.sort();
	assert_eq!(files, ["Guides.lua", "LICENSE-DATA.txt", "MapFrames.lua", "Pack.lua", "PolestarPack_Joe.toc"]);
	has(&std::fs::read_to_string(out.join("PolestarPack_Joe.toc")).unwrap(), r"(?m)^## X-Polestar-Pack: joe$");
	let lua = std::fs::read_to_string(out.join("Guides.lua")).unwrap();
	has(&lua, r#"id = "joe/a""#);
	assert!(!lua.contains("id = \"forever/"), "nothing of the context is emitted");
	// A second compile finds dist/ is not a pack source and replaces its own output.
	assert_eq!(with("compile", &[]).status, 0);
	// --out still wins.
	let other = tmp("nearest-out").join("out");
	assert_eq!(with("compile", &["--out", &s(&other)]).status, 0);
	assert!(other.join("PolestarPack_Joe.toc").exists());
}

#[test]
fn an_invalid_pack_json_fails_lint_with_its_diagnostic() {
	let dir = joe_copy("invalid", &[]);
	let file = Path::new(&dir).join("pack.json");
	let mut m: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(&file).unwrap()).unwrap();
	m.as_object_mut().unwrap().remove("license");
	std::fs::write(&file, format!("{}\n", serde_json::to_string_pretty(&m).unwrap())).unwrap();
	let r = pack_cmd("lint", &dir, &[]);
	assert_eq!(r.status, 1);
	has(&r.stderr, r"pack\.json:1: error: missing `license`");
	assert_eq!(pack_cmd("compile", &dir, &[]).status, 1);
	assert!(!Path::new(&dir).join("dist").exists());
}

#[test]
fn lint_and_compile_take_the_pack_folder_as_their_one_argument_two_folders_exit_2() {
	let dir = joe_copy("arg", &[]);
	let (d, c) = (data(), context());
	let root = s(&repo());
	let ctx = ["--root", root.as_str(), "--data", &d, "--context", &c, "--context-data", &d];
	let elsewhere = tmp("arg-elsewhere");
	let with = |first: &[&str]| {
		let mut a: Vec<&str> = first.to_vec();
		a.extend_from_slice(&ctx);
		run_in(&a, &elsewhere)
	};
	let lint = with(&["lint", &dir]);
	assert_eq!(lint.status, 0, "{}", lint.stderr);
	has(&lint.stdout, "lint ok: 2 files, 2 guides");
	// Our own build folder is left alone.
	let ours = repo().join("addon/Polestar_Guides/Guides.lua");
	let before = std::fs::metadata(&ours).and_then(|m| m.modified()).ok();
	let compile = with(&["compile", &dir]);
	assert_eq!(compile.status, 0, "{}", compile.stderr);
	assert!(Path::new(&dir).join("dist/PolestarPack_Joe").is_dir());
	assert_eq!(std::fs::metadata(&ours).and_then(|m| m.modified()).ok(), before);
	assert_eq!(std::fs::read_dir(&elsewhere).unwrap().count(), 0);
	let other = joe_copy("arg-other", &[]);
	for name in ["lint", "compile"] {
		let two = with(&[name, &dir, &other]);
		assert_eq!(two.status, 2, "{name}: {}", two.stderr);
		has(&two.stderr, "one pack folder only, got 2");
		let both = with(&[name, &dir, "--pack", &dir]);
		assert_eq!(both.status, 2, "{name}: {}", both.stderr);
		has(&both.stderr, "the pack folder is named twice");
		let none = with(&[name, &s(&elsewhere)]);
		assert_eq!(none.status, 2, "{name}: {}", none.stderr);
		has(&none.stderr, r"no pack\.json in ");
	}
}

#[test]
fn a_pack_json_saved_with_a_byte_order_mark_reads_as_usual() {
	let dir = joe_copy("bom", &[]);
	let file = Path::new(&dir).join("pack.json");
	let text = std::fs::read_to_string(&file).unwrap();
	std::fs::write(&file, format!("\u{FEFF}{text}")).unwrap();
	let r = pack_cmd("lint", &dir, &[]);
	assert_eq!(r.status, 0, "{}", r.stderr);
	has(&r.stdout, "lint ok: 2 files, 2 guides");
}

#[test]
fn a_packs_map_frame_that_differs_from_ours_is_a_warning_naming_the_map() {
	let data_copy = tmp("frames");
	copy_dir(Path::new(&data()), &data_copy);
	let file = data_copy.join("map-frames.json");
	let mut frames: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(&file).unwrap()).unwrap();
	let left = frames["era"]["1429"]["left"].as_f64().unwrap();
	frames["era"]["1429"]["left"] = (left + 10.0).into();
	std::fs::write(&file, frames.to_string()).unwrap();
	let (d, c, j) = (data(), context(), joe());
	let r = run(&["lint", "--pack", &j, "--data", &s(&data_copy), "--context", &c, "--context-data", &d]);
	assert_eq!(r.status, 0, "{}", r.stderr);
	assert_eq!(r.stderr.lines().filter(|l| l.contains("map 1429: this pack's Era frame differs")).count(), 1, "{}", r.stderr);
	assert!(!pack_cmd("lint", &j, &[]).stderr.contains("Era frame differs"));
}

#[test]
fn guides_with_a_pack_folder_is_a_usage_error_that_names_the_pack_folder_given_as_the_argument_or_pack() {
	let dir = joe_copy("guides-pack", &[]);
	let d = data();
	let cwd = tmp("guides-pack-cwd");
	for name in ["lint", "compile"] {
		for args in [vec![dir.as_str()], vec!["--pack", dir.as_str()]] {
			let mut a = vec![name, "--guides", dir.as_str()];
			a.extend(args);
			a.extend(["--data", d.as_str()]);
			let r = run_in(&a, &cwd);
			assert_eq!(r.status, 2, "{name}: {}", r.stderr);
			has(&r.stderr, "--guides and a pack folder cannot be used together");
		}
	}
}

#[test]
fn a_pipe_in_a_later_pro_or_con_is_reported_at_its_own_line_once_per_entry() {
	let text = [
		"guide joe/e",
		"title Extra",
		"faction Alliance",
		"levels 6-8",
		"zone Elwynn Forest",
		"pro Fast",
		"pro Fun | short",
		"con Slow",
		"con Long | dull",
		"con Grey | flat",
		"",
		"step S",
		"  talk 197",
		"",
	]
	.join("\n");
	let r = pack_cmd("lint", &joe_copy("pipe-pros", &[("e.guide", text)]), &[]);
	assert_eq!(r.status, 0, "{}", r.stderr);
	assert_eq!(
		pipes(&r.stderr),
		[
			"e.guide:7: warning: `pro` contains \"|\", which prints literally in game",
			"e.guide:9: warning: `con` contains \"|\", which prints literally in game",
			"e.guide:10: warning: `con` contains \"|\", which prints literally in game",
		]
	);
}

#[test]
fn a_pack_quest_turned_in_by_one_of_our_guides_after_next_is_not_reported_one_our_next_guide_never_turns_in_is() {
	let handed = joe_copy("handed", &[("c.guide", guide("joe/c", &["next forever/alliance/01-start", "", "step Deputy", "  accept 783"]))]);
	let ok = pack_cmd("lint", &handed, &[]);
	assert_eq!(ok.status, 0, "{}", ok.stderr);
	assert!(!re(r"c\.guide.*never turned in").is_match(&ok.stderr), "{}", ok.stderr);
	let dropped = joe_copy("dropped", &[("c.guide", guide("joe/c", &["next forever/alliance/02-next", "", "step Deputy", "  accept 783"]))]);
	has(&pack_cmd("lint", &dropped, &[]).stderr, r"c\.guide:9: warning: quest 783 .*is accepted but never turned in later in this guide or a guide after it");
}

/// The placeholder line `polestar new` writes in LICENSE (for a licence it has no text for) warns until it
/// is replaced: the built addon ships LICENSE as LICENSE.txt.
#[test]
fn a_packs_license_placeholder_line_warns_until_replaced() {
	let dir = joe_copy("license", &[]);
	let file = Path::new(&dir).join("LICENSE");
	let licence = serde_json::from_str::<serde_json::Value>(&std::fs::read_to_string(Path::new(&dir).join("pack.json")).unwrap()).unwrap()["license"].as_str().unwrap().to_string();
	std::fs::write(&file, format!("Licensed under {licence}: replace this line with the full text of that licence.\n")).unwrap();
	let r = pack_cmd("lint", &dir, &[]);
	assert_eq!(r.status, 0, "{}", r.stderr);
	has(
		&r.stderr,
		&format!(
			r"LICENSE:1: warning: LICENSE still holds the placeholder line `polestar new` writes, not the licence text\n {{2}}hint: replace the line with the full text of the {} licence: the built addon ships LICENSE as LICENSE\.txt",
			regex::escape(&licence)
		),
	);
	std::fs::write(&file, "The full licence text.\n").unwrap();
	assert!(!pack_cmd("lint", &dir, &[]).stderr.contains("placeholder"));
}
