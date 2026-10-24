//! `forge release pack` on the compiler's fixtures (tests/fixtures/dsl, tests/fixtures/packs) and fake addon
//! folders: our release's two zips and SHA256SUMS, reproducible, with the GPL and the players' README in
//! Polestar/, the built data addons in and the others named, the Codex refused unless release-safe; another
//! pack's zip with exactly its built files; the missing-data, invalid-pack and foreign-folder refusals.

use forge_release::zip::read_zip;
use std::path::{Path, PathBuf};
use std::process::Command;

fn repo() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

fn fixture(rel: &str) -> String {
	repo().join(rel).to_string_lossy().into_owned()
}

fn tmp(name: &str) -> PathBuf {
	let d = Path::new(env!("CARGO_TARGET_TMPDIR")).join("release-pack").join(name);
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

struct Run {
	status: i32,
	stdout: String,
	stderr: String,
}

impl Run {
	fn out(&self) -> String {
		format!("{}{}", self.stdout, self.stderr)
	}
}

fn forge(cwd: &Path, args: &[&str]) -> Run {
	let o = Command::new(env!("CARGO_BIN_EXE_forge")).current_dir(cwd).arg("release").arg("pack").args(args).output().unwrap();
	Run { status: o.status.code().unwrap_or(-1), stdout: String::from_utf8(o.stdout).unwrap(), stderr: String::from_utf8(o.stderr).unwrap() }
}

const VERSION: &str = "0.1.0";
const RELEASE: [&str; 5] = ["Polestar", "Polestar_Guides", "Polestar_Nav", "Polestar_Recorder", "Polestar_Codex"];

/// Addon folders as the release reads them (tests/helpers/cli.js fakeAddons): a TOC with the version, a
/// Main.lua, a hidden file never shipped, and a release-safe Codex.
fn fake_addons(dir: &Path, names: &[&str]) {
	for n in names {
		let d = dir.join(n);
		std::fs::create_dir_all(&d).unwrap();
		let files = if *n == "Polestar_Guides" { format!("{}\n\nPack.lua\nMapFrames.lua\nGuides.lua", forge_guide::format::toc_marker()) } else { "\nMain.lua".into() };
		std::fs::write(d.join(format!("{n}.toc")), format!("## Interface: 16001\n## Title: {n}\n## Version: {VERSION}\n{files}\n")).unwrap();
		if *n != "Polestar_Guides" {
			std::fs::write(d.join("Main.lua"), format!("local ADDON, ns = ...\n-- {n}\n")).unwrap();
		}
		if *n == "Polestar_Codex" {
			std::fs::write(d.join("Meta.lua"), "C.Register(\"meta\", {\n\tlocalExtras = false,\n\tsources = {\n\t\t{\n\t\t\tname = \"pfQuest\",\n\t\t},\n\t},\n})\n").unwrap();
			std::fs::write(d.join("LICENSE-DATA.txt"), "Polestar Codex: third-party notices\n").unwrap();
		}
		if *n == "Polestar_QuestDB" || *n == "Polestar_ItemDB" || forge_guide::locales::LOCALE_CODES.iter().any(|l| *n == forge_guide::toc::language_addon(l)) {
			std::fs::write(d.join("LICENSE-DATA.txt"), format!("{n}: third-party notices\n")).unwrap();
		}
		std::fs::write(d.join(".hidden"), "not shipped\n").unwrap();
	}
}

/// A checkout of our release: package.json, guides/pack.json, LICENSE and addon/ with `addons`.
fn checkout(name: &str, addons: &[&str]) -> PathBuf {
	let root = tmp(name);
	std::fs::write(root.join("package.json"), format!("{{\n  \"name\": \"polestar\",\n  \"version\": \"{VERSION}\",\n  \"private\": true\n}}\n")).unwrap();
	std::fs::create_dir_all(root.join("guides")).unwrap();
	std::fs::write(root.join("guides/pack.json"), format!("{{\n\t\"id\": \"guides\",\n\t\"title\": \"Polestar Guides\",\n\t\"author\": \"Polestar\",\n\t\"version\": \"{VERSION}\",\n\t\"license\": \"GPL-3.0-only\",\n\t\"folder\": \"Polestar_Guides\"\n}}\n")).unwrap();
	std::fs::copy(repo().join("LICENSE"), root.join("LICENSE")).unwrap();
	fake_addons(&root.join("addon"), addons);
	root
}

/// `forge release pack` of our release from checkout `root` with the fixture guides and data.
fn pack_ours(root: &Path, dist: &Path) -> Run {
	let (g, d) = (fixture("tests/fixtures/dsl/guides"), fixture("tests/fixtures/dsl/data"));
	forge(root, &["--root", &root.to_string_lossy(), "--guides", &g, "--data", &d, "--dist", &dist.to_string_lossy()])
}

fn names(zip: &Path) -> Vec<String> {
	read_zip(&std::fs::read(zip).unwrap(), u64::MAX).unwrap().into_iter().map(|e| e.name).collect()
}

fn list(dir: &Path) -> Vec<String> {
	let mut v: Vec<String> = std::fs::read_dir(dir).unwrap().flatten().map(|e| e.file_name().to_string_lossy().into_owned()).collect();
	v.sort();
	v
}

fn python_ok(args: &[&str]) -> Option<bool> {
	Command::new("python3").arg("-m").arg("zipfile").args(args).output().ok().map(|o| o.status.success())
}

#[test]
fn pack_zips_polestar_guides_nav_and_codex_and_the_recorder_separately_reproducibly() {
	let root = checkout("ours", &RELEASE);
	let dists = [root.join("dist1"), root.join("dist2")];
	for d in &dists {
		let r = pack_ours(&root, d);
		assert_eq!(r.status, 0, "{}", r.out());
		assert_eq!(list(d), [format!("Polestar-{VERSION}.zip"), format!("Polestar_Recorder-{VERSION}.zip"), "SHA256SUMS".into()]);
	}
	for f in [format!("Polestar-{VERSION}.zip"), format!("Polestar_Recorder-{VERSION}.zip"), "SHA256SUMS".into()] {
		assert_eq!(std::fs::read(dists[0].join(&f)).unwrap(), std::fs::read(dists[1].join(&f)).unwrap(), "{f} differs between runs");
	}
	let zip = dists[0].join(format!("Polestar-{VERSION}.zip"));
	assert_eq!(
		names(&zip),
		[
			"Polestar/",
			"Polestar/LICENSE",
			"Polestar/README.txt",
			"Polestar/Main.lua",
			"Polestar/Polestar.toc",
			"Polestar_Guides/",
			"Polestar_Guides/Guides.lua",
			"Polestar_Guides/LICENSE-DATA.txt",
			"Polestar_Guides/MapFrames.lua",
			"Polestar_Guides/Pack.lua",
			"Polestar_Guides/Polestar_Guides.toc",
			"Polestar_Nav/",
			"Polestar_Nav/Main.lua",
			"Polestar_Nav/Polestar_Nav.toc",
			// The fixture guides are Alliance guides: our pack's Alliance part, built by the pack (format 8).
			"Polestar_Guides_Alliance/",
			"Polestar_Guides_Alliance/Guides.lua",
			"Polestar_Guides_Alliance/LICENSE-DATA.txt",
			"Polestar_Guides_Alliance/Polestar_Guides_Alliance.toc",
			"Polestar_Codex/",
			"Polestar_Codex/LICENSE-DATA.txt",
			"Polestar_Codex/Main.lua",
			"Polestar_Codex/Meta.lua",
			"Polestar_Codex/Polestar_Codex.toc",
		]
	);
	assert_eq!(
		names(&dists[0].join(format!("Polestar_Recorder-{VERSION}.zip"))),
		["Polestar_Recorder/", "Polestar_Recorder/LICENSE", "Polestar_Recorder/Main.lua", "Polestar_Recorder/Polestar_Recorder.toc"]
	);
	// Another implementation reads them too, when there is one.
	if python_ok(&["--help"]).is_some() {
		assert_eq!(python_ok(&["-t", &zip.to_string_lossy()]), Some(true));
	}
}

#[test]
fn the_polestar_folder_carries_the_gpl_and_install_steps_naming_every_folder_shipped() {
	let mut addons = RELEASE.to_vec();
	addons.extend(["Polestar_QuestDB", "Polestar_ItemDB"]);
	let root = checkout("readme", &addons);
	let r = pack_ours(&root, &root.join("dist"));
	assert_eq!(r.status, 0, "{}", r.out());
	let files = read_zip(&std::fs::read(root.join(format!("dist/Polestar-{VERSION}.zip"))).unwrap(), u64::MAX).unwrap();
	let get = |n: &str| files.iter().find(|e| e.name == n).unwrap().data.clone();
	assert_eq!(get("Polestar/LICENSE"), std::fs::read(repo().join("LICENSE")).unwrap());
	let readme = String::from_utf8(get("Polestar/README.txt")).unwrap();
	assert!(readme.starts_with(&format!("Polestar {VERSION}\r\n")));
	for n in ["Polestar", "Polestar_Guides", "Polestar_Nav", "Polestar_QuestDB", "Polestar_ItemDB", "Polestar_Codex"] {
		assert!(readme.contains(&format!("\r\n     {n}\r\n")), "{n}");
	}
	assert!(!readme.contains("     Polestar_Recorder\r\n"));
	// The adapted GPL-3.0-or-later code inside Polestar/ is named where it ships.
	assert!(String::from_utf8(get("Polestar/LICENSE")).unwrap().contains("\nPortions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever,\n"));
}

#[test]
fn pack_writes_sha256sums_for_the_zips_it_wrote() {
	let root = checkout("sums", &RELEASE);
	let dist = root.join("dist");
	assert_eq!(pack_ours(&root, &dist).status, 0);
	let want: String = [format!("Polestar-{VERSION}.zip"), format!("Polestar_Recorder-{VERSION}.zip")]
		.iter()
		.map(|f| format!("{}  {f}\n", forge_release::pack::sha256_hex(&std::fs::read(dist.join(f)).unwrap())))
		.collect();
	assert_eq!(std::fs::read_to_string(dist.join("SHA256SUMS")).unwrap(), want);
	if Command::new("sha256sum").arg("--version").output().is_ok() {
		assert!(Command::new("sha256sum").arg("-c").arg("SHA256SUMS").current_dir(&dist).output().unwrap().status.success());
	}
}

#[test]
fn the_release_zip_includes_the_built_data_addons_and_leaves_out_ones_not_built() {
	let mut addons = RELEASE.to_vec();
	addons.push("Polestar_QuestDB");
	let root = checkout("data-addons", &addons);
	let dist = root.join("dist");
	let r = pack_ours(&root, &dist);
	assert_eq!(r.status, 0, "{}", r.out());
	assert!(r.stdout.contains("note: Polestar_ItemDB not built"), "{}", r.out());
	let tops = |zip: &Path| {
		let mut t: Vec<String> = Vec::new();
		for n in names(zip) {
			let top = n.split('/').next().unwrap().to_string();
			if !t.contains(&top) {
				t.push(top);
			}
		}
		t
	};
	let zip = dist.join(format!("Polestar-{VERSION}.zip"));
	assert_eq!(tops(&zip), ["Polestar", "Polestar_Guides", "Polestar_Nav", "Polestar_Guides_Alliance", "Polestar_QuestDB", "Polestar_Codex"]);
	fake_addons(&root.join("addon"), &["Polestar_ItemDB"]);
	assert_eq!(pack_ours(&root, &dist).status, 0);
	assert_eq!(tops(&zip), ["Polestar", "Polestar_Guides", "Polestar_Nav", "Polestar_Guides_Alliance", "Polestar_QuestDB", "Polestar_ItemDB", "Polestar_Codex"]);
	// The language folders last; the folders they replaced are named, never shipped.
	fake_addons(&root.join("addon"), &["Polestar_frFR", "Polestar_Guides_deDE", "Polestar_Names_deDE"]);
	let r = pack_ours(&root, &dist);
	assert_eq!(r.status, 0, "{}", r.out());
	assert_eq!(tops(&zip), ["Polestar", "Polestar_Guides", "Polestar_Nav", "Polestar_Guides_Alliance", "Polestar_QuestDB", "Polestar_ItemDB", "Polestar_Codex", "Polestar_frFR"]);
	for old in ["Polestar_Guides_deDE", "Polestar_Names_deDE"] {
		assert!(r.stdout.contains(&format!("note: {old} is left from before 0.3.0")), "{}", r.out());
	}
}

#[test]
fn pack_refuses_a_release_without_the_codex_or_with_a_local_one_and_writes_no_zip() {
	let none = checkout("no-codex", &["Polestar", "Polestar_Nav", "Polestar_Recorder"]);
	let r = pack_ours(&none, &none.join("dist"));
	assert_eq!(r.status, 1, "{}", r.out());
	assert!(r.stderr.contains("forge release pack: Polestar_Codex not built (run `forge data codex`)"), "{}", r.out());
	assert!(!none.join("dist").exists());

	let local = checkout("local-codex", &RELEASE);
	let meta = local.join("addon/Polestar_Codex/Meta.lua");
	std::fs::write(&meta, std::fs::read_to_string(&meta).unwrap().replace("localExtras = false", "localExtras = true")).unwrap();
	let r = pack_ours(&local, &local.join("dist"));
	assert_eq!(r.status, 1);
	assert!(r.stderr.contains("Polestar_Codex it is a --local-extras build"), "{}", r.out());
	assert!(!local.join("dist").exists());
}

#[test]
fn inside_a_pack_pack_writes_its_zip_with_exactly_its_five_files_reproducibly() {
	let dir = tmp("mini");
	copy_dir(&repo().join("tests/fixtures/packs/mini"), &dir);
	let (d, c) = (fixture("tests/fixtures/dsl/data"), fixture("tests/fixtures/packs/context"));
	let run = || forge(&dir.join("guides"), &["--root", &repo().to_string_lossy(), "--data", &d, "--context", &c, "--context-data", &d]);
	let first = run();
	assert_eq!(first.status, 0, "{}", first.out());
	assert_eq!(list(&dir.join("dist")), ["PolestarPack_MiniPack-0.3.0.zip"]);
	let zip = dir.join("dist/PolestarPack_MiniPack-0.3.0.zip");
	let bytes = std::fs::read(&zip).unwrap();
	let entries = read_zip(&bytes, u64::MAX).unwrap();
	let want: Vec<String> = std::iter::once("PolestarPack_MiniPack/".to_string())
		.chain(["Guides.lua", "LICENSE-DATA.txt", "MapFrames.lua", "Pack.lua", "PolestarPack_MiniPack.toc"].iter().map(|f| format!("PolestarPack_MiniPack/{f}")))
		.collect();
	assert_eq!(entries.iter().map(|e| e.name.clone()).collect::<Vec<_>>(), want);
	assert!(String::from_utf8_lossy(&entries.iter().find(|e| e.name.ends_with(".toc")).unwrap().data).contains("## Version: 0.3.0"));
	assert_eq!(run().status, 0);
	assert_eq!(std::fs::read(&zip).unwrap(), bytes, "identical across runs");
}

#[test]
fn a_packs_license_ships_as_license_txt_byte_for_byte() {
	let dir = tmp("license");
	copy_dir(&repo().join("tests/fixtures/packs/mini"), &dir);
	let text = "Mini Pack by Ann is dedicated to the public domain.\n\nThe full licence text.\n";
	std::fs::write(dir.join("LICENSE"), text).unwrap();
	let (d, c) = (fixture("tests/fixtures/dsl/data"), fixture("tests/fixtures/packs/context"));
	let r = forge(&repo(), &["--pack", &dir.to_string_lossy(), "--data", &d, "--context", &c, "--context-data", &d]);
	assert_eq!(r.status, 0, "{}", r.out());
	let entries = read_zip(&std::fs::read(dir.join("dist/PolestarPack_MiniPack-0.3.0.zip")).unwrap(), u64::MAX).unwrap();
	assert_eq!(entries.iter().find(|e| e.name == "PolestarPack_MiniPack/LICENSE.txt").unwrap().data, text.as_bytes());
}

#[test]
fn pack_refuses_a_pack_with_errors_and_writes_nothing() {
	let dir = tmp("escape");
	copy_dir(&repo().join("tests/fixtures/packs/mini"), &dir);
	std::fs::write(dir.join("pack.json"), r#"{"id":"mini","title":"Mini","author":"Ann","version":"1","license":"CC0-1.0","folder":"../escape"}"#).unwrap();
	let (d, c) = (fixture("tests/fixtures/dsl/data"), fixture("tests/fixtures/packs/context"));
	let r = forge(&repo(), &["--pack", &dir.to_string_lossy(), "--data", &d, "--context", &c, "--context-data", &d]);
	assert_eq!(r.status, 1, "{}", r.out());
	assert!(r.stderr.contains("folder \"../escape\" is malformed"), "{}", r.out());
	assert!(!dir.join("dist").exists());
}

#[test]
fn pack_without_reference_data_stops_with_one_error_and_no_data_is_for_a_pack_only() {
	let dir = tmp("nodata");
	copy_dir(&repo().join("tests/fixtures/packs/mini"), &dir);
	let missing = tmp("nodata-missing").join("nope");
	let (d, c) = (fixture("tests/fixtures/dsl/data"), fixture("tests/fixtures/packs/context"));
	let r = forge(&repo(), &["--pack", &dir.to_string_lossy(), "--data", &missing.to_string_lossy(), "--context", &c, "--context-data", &d]);
	assert_eq!(r.status, 1, "{}", r.out());
	assert_eq!(r.stderr.lines().filter(|l| l.contains("error:")).count(), 1, "{}", r.out());
	assert!(r.stderr.contains("error: no reference data: the folder does not exist"), "{}", r.out());
	assert!(r.stderr.trim_end().ends_with("forge release pack: no reference data"), "{}", r.out());
	assert!(!dir.join("dist").exists());
	let ours = forge(&repo(), &["--no-data", "--guides", &fixture("tests/fixtures/dsl/guides")]);
	assert_eq!(ours.status, 2, "{}", ours.out());
	assert!(ours.stderr.contains("--no-data builds a community addon; our release needs the reference data"));
}

#[test]
fn our_guide_folder_is_generated_before_its_toc_is_checked_and_a_foreign_one_is_refused() {
	let root = checkout("generated", &["Polestar", "Polestar_Nav", "Polestar_Recorder", "Polestar_Codex"]);
	let ok = pack_ours(&root, &root.join("dist"));
	assert_eq!(ok.status, 0, "{}", ok.out());
	assert!(!ok.stderr.contains("Polestar_Guides.toc says version"));
	assert!(root.join("addon/Polestar_Guides/Polestar_Guides.toc").exists());

	let foreign = checkout("foreign", &["Polestar", "Polestar_Nav", "Polestar_Recorder", "Polestar_Codex"]);
	std::fs::create_dir_all(foreign.join("addon/Polestar_Guides")).unwrap();
	std::fs::write(foreign.join("addon/Polestar_Guides/mine.txt"), "mine\n").unwrap();
	let bad = pack_ours(&foreign, &foreign.join("dist"));
	assert_eq!(bad.status, 1, "{}", bad.out());
	assert!(bad.stderr.contains("forge release pack: refusing to write into ") && bad.stderr.contains("Polestar_Guides"), "{}", bad.out());
	assert!(!foreign.join("dist").exists());
}

#[test]
fn a_polestar_toc_without_an_interface_line_is_a_clear_error() {
	let root = checkout("no-interface", &["Polestar", "Polestar_Nav", "Polestar_Recorder", "Polestar_Codex"]);
	std::fs::write(root.join("addon/Polestar/Polestar.toc"), "## Title: Polestar\n## Version: 0.1.0\nMain.lua\n").unwrap();
	let r = pack_ours(&root, &root.join("dist"));
	assert_eq!(r.status, 1, "{}", r.out());
	assert!(r.stderr.lines().any(|l| l.starts_with("forge release pack: ") && l.ends_with("Polestar.toc has no ## Interface line")), "{}", r.out());
}

#[test]
fn a_guides_pack_json_with_another_version_is_a_warning_and_the_zips_are_still_written() {
	let root = checkout("other-version", &RELEASE);
	let file = root.join("guides/pack.json");
	std::fs::write(&file, std::fs::read_to_string(&file).unwrap().replace(VERSION, "0.0.1")).unwrap();
	let r = pack_ours(&root, &root.join("dist"));
	assert_eq!(r.status, 0, "{}", r.out());
	assert!(r.stderr.lines().any(|l| l == format!("warning: guides/pack.json says version 0.0.1, package.json says {VERSION}")), "{}", r.out());
	assert!(r.stdout.contains("SHA256SUMS"));
}

#[test]
fn pack_takes_the_pack_folder_as_its_one_argument_and_two_folders_exit_2() {
	let dir = tmp("joe");
	copy_dir(&repo().join("tests/fixtures/packs/joe"), &dir);
	let other = tmp("joe-other");
	copy_dir(&repo().join("tests/fixtures/packs/joe"), &other);
	let elsewhere = tmp("joe-elsewhere");
	let (d, c) = (fixture("tests/fixtures/dsl/data"), fixture("tests/fixtures/packs/context"));
	let root = repo().to_string_lossy().into_owned();
	let dist_before = std::fs::read_dir(repo().join("dist")).map(|r| r.count()).ok();
	let ctx = ["--root", &root, "--data", &d, "--context", &c, "--context-data", &d];
	let with = |first: &[&str]| forge(&elsewhere, &[first, &ctx[..]].concat());
	let (p, o, e) = (dir.to_string_lossy().into_owned(), other.to_string_lossy().into_owned(), elsewhere.to_string_lossy().into_owned());
	let ok = with(&[&p]);
	assert_eq!(ok.status, 0, "{}", ok.out());
	assert_eq!(list(&dir.join("dist")), ["PolestarPack_Joe-1.2.0.zip"]);
	// Our own release folder and the working directory are left alone.
	assert_eq!(std::fs::read_dir(repo().join("dist")).map(|r| r.count()).ok(), dist_before);
	assert!(list(&elsewhere).is_empty());
	let two = with(&[&p, &o]);
	assert_eq!(two.status, 2, "{}", two.out());
	assert!(two.stderr.contains("one pack folder only, got 2"), "{}", two.out());
	let both = with(&[&p, "--pack", &p]);
	assert_eq!(both.status, 2);
	assert!(both.stderr.contains("the pack folder is named twice"), "{}", both.out());
	let none = with(&[&e]);
	assert_eq!(none.status, 2);
	assert!(none.stderr.contains("no pack.json in "), "{}", none.out());
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
