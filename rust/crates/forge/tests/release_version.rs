//! `forge release version`: sets package.json, guides/pack.json and every addon TOC, changing nothing
//! else; names a file that disagrees; refuses a bad version or a file without a version to set. And the
//! checkout itself: every addon TOC and guides/pack.json carry package.json's version.

use std::path::{Path, PathBuf};
use std::process::Command;

fn tmp(name: &str) -> PathBuf {
	let d = Path::new(env!("CARGO_TARGET_TMPDIR")).join("release-version").join(name);
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

struct Run {
	status: i32,
	stdout: String,
	stderr: String,
}

fn forge(args: &[&str]) -> Run {
	let o = Command::new(env!("CARGO_BIN_EXE_forge")).arg("release").arg("version").args(args).output().unwrap();
	Run { status: o.status.code().unwrap_or(-1), stdout: String::from_utf8(o.stdout).unwrap(), stderr: String::from_utf8(o.stderr).unwrap() }
}

fn fake_root(name: &str) -> PathBuf {
	let root = tmp(name);
	std::fs::write(root.join("package.json"), "{\n  \"name\": \"polestar\",\n  \"version\": \"0.1.0\",\n  \"private\": true\n}\n").unwrap();
	for n in ["Polestar", "Polestar_Guides", "Polestar_Recorder"] {
		std::fs::create_dir_all(root.join("addon").join(n)).unwrap();
		std::fs::write(root.join(format!("addon/{n}/{n}.toc")), format!("## Interface: 16001\n## Title: {n}\n## Version: 0.1.0\n\nMain.lua\n")).unwrap();
	}
	std::fs::create_dir_all(root.join("addon/.hidden")).unwrap();
	std::fs::create_dir_all(root.join("guides")).unwrap();
	std::fs::write(root.join("guides/pack.json"), "{\n\t\"id\": \"guides\",\n\t\"title\": \"Polestar Guides\",\n\t\"version\": \"0.1.0\",\n\t\"folder\": \"Polestar_Guides\"\n}\n").unwrap();
	root
}

fn read(root: &Path, rel: &str) -> String {
	std::fs::read_to_string(root.join(rel)).unwrap()
}

#[test]
fn version_sets_package_json_the_manifest_and_every_toc_leaving_the_rest_as_it_was() {
	let root = fake_root("set");
	let r = root.to_string_lossy().into_owned();
	let (pkg, man, toc) = (read(&root, "package.json"), read(&root, "guides/pack.json"), read(&root, "addon/Polestar/Polestar.toc"));
	let set = forge(&["0.2.0-beta.1", "--root", &r]);
	assert_eq!(set.status, 0, "{}", set.stderr);
	assert!(set.stdout.contains("version 0.2.0-beta.1: package.json, guides/pack.json and 3 addon TOCs"), "{}", set.stdout);
	assert_eq!(read(&root, "package.json"), pkg.replace("\"0.1.0\"", "\"0.2.0-beta.1\""));
	assert_eq!(read(&root, "guides/pack.json"), man.replace("\"0.1.0\"", "\"0.2.0-beta.1\""));
	assert_eq!(read(&root, "addon/Polestar/Polestar.toc"), toc.replace("## Version: 0.1.0", "## Version: 0.2.0-beta.1"));
	for n in ["Polestar_Guides", "Polestar_Recorder"] {
		assert!(read(&root, &format!("addon/{n}/{n}.toc")).contains("\n## Version: 0.2.0-beta.1\n"));
	}
	let shown = forge(&["--root", &r]);
	assert_eq!(shown.status, 0, "{}", shown.stderr);
	assert_eq!(shown.stdout, "0.2.0-beta.1\n");
}

#[test]
fn version_names_a_toc_that_disagrees_and_a_bad_version_or_a_toc_without_the_line_changes_nothing() {
	let root = fake_root("toc");
	let r = root.to_string_lossy().into_owned();
	let recorder = root.join("addon/Polestar_Recorder/Polestar_Recorder.toc");
	std::fs::write(&recorder, read(&root, "addon/Polestar_Recorder/Polestar_Recorder.toc").replace("0.1.0", "0.0.9")).unwrap();
	let shown = forge(&["--root", &r]);
	assert_eq!(shown.status, 1);
	assert!(shown.stderr.contains("Polestar_Recorder.toc: version 0.0.9"), "{}", shown.stderr);
	assert_eq!(forge(&["1.0", "--root", &r]).status, 2);
	assert_eq!(forge(&["1.0.0", "2.0.0", "--root", &r]).status, 2);
	std::fs::write(&recorder, "## Interface: 16001\n\nMain.lua\n").unwrap();
	let refused = forge(&["1.0.0", "--root", &r]);
	assert_eq!(refused.status, 1);
	assert!(refused.stderr.contains("Polestar_Recorder.toc: no ## Version line"), "{}", refused.stderr);
	assert!(read(&root, "package.json").contains("\"version\": \"0.1.0\""));
	assert!(read(&root, "addon/Polestar/Polestar.toc").contains("\n## Version: 0.1.0\n"));
}

#[test]
fn version_names_a_manifest_that_disagrees_and_refuses_one_without_a_version() {
	let root = fake_root("manifest");
	let r = root.to_string_lossy().into_owned();
	let file = root.join("guides/pack.json");
	std::fs::write(&file, read(&root, "guides/pack.json").replace("\"0.1.0\"", "\"0.0.9\"")).unwrap();
	let shown = forge(&["--root", &r]);
	assert_eq!(shown.status, 1);
	assert!(shown.stderr.contains("guides/pack.json: version 0.0.9"), "{}", shown.stderr);
	std::fs::write(&file, "{\n\t\"id\": \"guides\"\n}\n").unwrap();
	let refused = forge(&["1.0.0", "--root", &r]);
	assert_eq!(refused.status, 1);
	assert!(refused.stderr.contains("guides/pack.json: no \"version\" field"), "{}", refused.stderr);
	assert!(read(&root, "package.json").contains("\"version\": \"0.1.0\""));
	assert!(read(&root, "addon/Polestar/Polestar.toc").contains("\n## Version: 0.1.0\n"));
}

/// The checkout: every addon TOC and guides/pack.json (compile writes its version into
/// Polestar_Guides.toc) carry package.json's version.
#[test]
fn the_checkout_carries_one_version_everywhere() {
	let repo = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap();
	let files = forge_release::version::files(&repo, &repo.join("addon"));
	assert!(files.manifest.is_some());
	let (_, wrong) = forge_release::version::check(&files).unwrap();
	assert!(wrong.is_empty(), "{wrong:?}");
}
