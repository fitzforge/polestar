//! `forge changelog`: fragments in changes/ are written by add, validated by check, previewed by show,
//! and gathered into CHANGELOG.md by build, which deletes them. Each test works on a checkout of its own
//! (--root).

use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};

const HEAD: &str = "# Changelog\n\n";
const OLD: &str = "## 0.2.4 (2026-10-16)\n\n### For players\n\n- An old entry.\n";

static N: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);

fn checkout(changelog: &str, fragments: &[(&str, String)]) -> PathBuf {
	let n = N.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
	let root = Path::new(env!("CARGO_TARGET_TMPDIR")).join("changelog").join(format!("{}-{n}", std::process::id()));
	let _ = std::fs::remove_dir_all(&root);
	std::fs::create_dir_all(root.join("changes")).unwrap();
	std::fs::write(root.join("CHANGELOG.md"), changelog).unwrap();
	std::fs::write(root.join("changes/README.md"), "# Changelog fragments\n").unwrap();
	for (name, text) in fragments {
		std::fs::write(root.join("changes").join(name), text).unwrap();
	}
	root
}

fn fragment(section: &str, body: &str) -> String {
	format!("---\nsection: {section}\n---\n{body}\n")
}

struct Run {
	status: i32,
	stdout: String,
	stderr: String,
}

fn run_with(root: &Path, args: &[&str], input: Option<&str>) -> Run {
	let mut c = Command::new(env!("CARGO_BIN_EXE_forge"));
	c.arg("changelog").args(args).arg("--root").arg(root).stdout(Stdio::piped()).stderr(Stdio::piped()).stdin(Stdio::piped());
	let mut child = c.spawn().unwrap();
	let mut stdin = child.stdin.take().unwrap();
	if let Some(i) = input {
		stdin.write_all(i.as_bytes()).unwrap();
	}
	drop(stdin);
	let o = child.wait_with_output().unwrap();
	Run { status: o.status.code().unwrap_or(-1), stdout: String::from_utf8(o.stdout).unwrap(), stderr: String::from_utf8(o.stderr).unwrap() }
}

fn run(root: &Path, args: &[&str]) -> Run {
	run_with(root, args, None)
}

fn read(root: &Path, f: &str) -> String {
	std::fs::read_to_string(root.join(f)).unwrap()
}

fn left(root: &Path) -> Vec<String> {
	let mut v: Vec<String> = std::fs::read_dir(root.join("changes")).unwrap().flatten().map(|e| e.file_name().to_string_lossy().into_owned()).filter(|f| f != "README.md").collect();
	v.sort();
	v
}

#[test]
fn build_puts_sections_in_order_entries_by_file_name_above_the_newest_release_and_deletes_the_fragments() {
	let root = checkout(
		&format!("{HEAD}{OLD}"),
		&[
			("a-forge.md", fragment("forge", "- A Forge entry.")),
			("b-tool.md", fragment("contributors", "- A tool entry.")),
			("z-player.md", fragment("players", "- Second player entry, wrapped\n  over two lines.")),
			("a-player.md", fragment("players", "- First player entry.")),
			("m-author.md", fragment("authors", "- An author entry.\n- And another item.")),
		],
	);
	let r = run(&root, &["build", "0.2.5", "--date", "2026-10-20"]);
	assert_eq!(r.status, 0, "{}", r.stderr);
	assert_eq!(
		read(&root, "CHANGELOG.md"),
		format!(
			"{HEAD}## 0.2.5 (2026-10-20)\n\n### For players\n\n- First player entry.\n- Second player entry, wrapped\n  over two lines.\n\n### For guide authors\n\n- An author entry.\n- And another item.\n\n### For contributors\n\n- A tool entry.\n\n### Forge\n\n- A Forge entry.\n\n{OLD}"
		)
	);
	assert!(left(&root).is_empty());
	assert!(root.join("changes/README.md").exists());
}

#[test]
fn build_leaves_out_sections_without_entries() {
	let root = checkout(&format!("{HEAD}{OLD}"), &[("x.md", fragment("contributors", "- Only this."))]);
	assert_eq!(run(&root, &["build", "0.2.5", "--date", "2026-10-20"]).status, 0);
	assert_eq!(read(&root, "CHANGELOG.md"), format!("{HEAD}## 0.2.5 (2026-10-20)\n\n### For contributors\n\n- Only this.\n\n{OLD}"));
}

#[test]
fn build_output_is_the_same_whatever_order_the_fragments_were_written_in() {
	let frags = [("c.md", fragment("players", "- C.")), ("a.md", fragment("players", "- A.")), ("b.md", fragment("authors", "- B."))];
	let mut reversed = frags.clone();
	reversed.reverse();
	let (one, two) = (checkout(&format!("{HEAD}{OLD}"), &frags), checkout(&format!("{HEAD}{OLD}"), &reversed));
	run(&one, &["build", "1.0.0", "--date", "2026-01-02"]);
	run(&two, &["build", "1.0.0", "--date", "2026-01-02"]);
	assert_eq!(read(&one, "CHANGELOG.md"), read(&two, "CHANGELOG.md"));
}

#[test]
fn build_refuses_a_released_version_no_fragments_a_faulty_one_or_an_unreleased_section_and_writes_nothing() {
	let a = ("a.md", fragment("players", "- A."));
	let cases = [
		(checkout(&format!("{HEAD}{OLD}"), std::slice::from_ref(&a)), "0.2.4"),
		(checkout(&format!("{HEAD}{OLD}"), &[]), "0.2.5"),
		(checkout(&format!("{HEAD}{OLD}"), &[a.clone(), ("b.md", fragment("everyone", "- B."))]), "0.2.5"),
		(checkout(&format!("{HEAD}## Unreleased\n\n### For players\n\n- U.\n\n{OLD}"), std::slice::from_ref(&a)), "0.2.5"),
	];
	for (i, (root, version)) in cases.iter().enumerate() {
		let (before, frags) = (read(root, "CHANGELOG.md"), left(root));
		let r = run(root, &["build", version, "--date", "2026-10-20"]);
		assert_eq!(r.status, 1, "case {i}: {}{}", r.stdout, r.stderr);
		assert_eq!(read(root, "CHANGELOG.md"), before, "case {i}");
		assert_eq!(left(root), frags, "case {i}");
	}
}

#[test]
fn build_rejects_a_bad_version_or_date_as_a_usage_error() {
	let root = checkout(&format!("{HEAD}{OLD}"), &[("a.md", fragment("players", "- A."))]);
	assert_eq!(run(&root, &["build", "v0.2.5"]).status, 2);
	assert_eq!(run(&root, &["build", "0.2.5", "--date", "20-10-2026"]).status, 2);
	assert_eq!(run(&root, &["build"]).status, 2);
	assert_eq!(run(&root, &["check", "--date", "2026-10-20"]).status, 2);
	assert_eq!(left(&root), ["a.md"]);
}

#[test]
fn build_into_a_changelog_without_releases_appends_the_section() {
	let root = checkout(HEAD, &[("a.md", fragment("players", "- A."))]);
	assert_eq!(run(&root, &["build", "0.1.0", "--date", "2026-01-01"]).status, 0);
	assert_eq!(read(&root, "CHANGELOG.md"), format!("{HEAD}## 0.1.0 (2026-01-01)\n\n### For players\n\n- A.\n"));
}

#[test]
fn check_passes_valid_fragments_and_names_every_faulty_one_and_an_unreleased_section() {
	let good = checkout(&format!("{HEAD}{OLD}"), &[("a.md", fragment("players", "- A.")), ("b.md", fragment("authors", "- B."))]);
	assert_eq!(run(&good, &["check"]).status, 0);
	let bad = [
		("no-front.md", "- No front matter.\n".to_string()),
		("open.md", "---\nsection: players\n- Never closed.\n".into()),
		("section.md", fragment("everyone", "- Unknown section.")),
		("nosection.md", "---\n---\n- No section.\n".into()),
		("key.md", "---\nsection: players\nauthor: me\n---\n- Unknown key.\n".into()),
		("empty.md", fragment("players", "")),
		("notlist.md", fragment("players", "Not a list item.")),
		("notes.txt", "not markdown\n".into()),
	];
	let mut all = vec![("fine.md", fragment("players", "- Fine."))];
	all.extend(bad.iter().cloned());
	let root = checkout(&format!("{HEAD}## Unreleased\n\n{OLD}"), &all);
	let r = run(&root, &["check"]);
	assert_eq!(r.status, 1);
	let named: Vec<&str> = r.stderr.lines().filter(|l| !l.starts_with("forge changelog:")).map(|l| l.split(':').next().unwrap()).collect();
	let mut want: Vec<String> = bad.iter().map(|(f, _)| format!("changes/{f}")).collect();
	want.sort();
	want.push("CHANGELOG.md".into());
	assert_eq!(named, want);
}

#[test]
fn check_passes_a_checkout_without_changes() {
	let root = checkout(&format!("{HEAD}{OLD}"), &[]);
	std::fs::remove_dir_all(root.join("changes")).unwrap();
	assert_eq!(run(&root, &["check"]).status, 0);
}

#[test]
fn show_prints_the_assembled_entries_and_writes_nothing() {
	let root = checkout(&format!("{HEAD}{OLD}"), &[("b.md", fragment("contributors", "- B.")), ("a.md", fragment("players", "- A.\n  wrapped."))]);
	let r = run(&root, &["show"]);
	assert_eq!(r.status, 0, "{}", r.stderr);
	assert_eq!(r.stdout, "## Unreleased\n\n### For players\n\n- A.\n  wrapped.\n\n### For contributors\n\n- B.\n");
	assert_eq!(read(&root, "CHANGELOG.md"), format!("{HEAD}{OLD}"));
	assert_eq!(left(&root), ["a.md", "b.md"]);
}

#[test]
fn add_writes_a_fragment_named_from_name_or_the_first_words_from_text_or_stdin_never_overwriting() {
	let root = checkout(&format!("{HEAD}{OLD}"), &[]);
	let body = "- Walks between zones go through the real tunnels,\n  passes and bridges.";
	let r = run_with(&root, &["add", "players"], Some(&format!("{body}\n")));
	assert_eq!(r.status, 0, "{}", r.stderr);
	let first = "walks-between-zones-go-through-the.md";
	assert_eq!(left(&root), [first]);
	assert_eq!(read(&root, &format!("changes/{first}")), fragment("players", body));
	assert_eq!(run_with(&root, &["add", "players"], Some(&format!("{body}\n"))).status, 0);
	assert_eq!(left(&root), ["walks-between-zones-go-through-the-2.md", first]);
	assert_eq!(run(&root, &["add", "authors", "--name", "my-fix", "--text", "- A fix."]).status, 0);
	assert_eq!(read(&root, "changes/my-fix.md"), fragment("authors", "- A fix."));
	assert_eq!(run(&root, &["add", "authors", "--name", "my-fix", "--text", "- Another."]).status, 1);
	assert_eq!(read(&root, "changes/my-fix.md"), fragment("authors", "- A fix."));
	assert_eq!(run(&root, &["check"]).status, 0);
}

#[test]
fn add_rejects_an_unknown_section_or_an_empty_entry_and_writes_nothing() {
	let root = checkout(&format!("{HEAD}{OLD}"), &[]);
	assert_eq!(run(&root, &["add", "everyone", "--text", "- A."]).status, 2);
	assert_eq!(run_with(&root, &["add", "players"], Some("  \n")).status, 2);
	assert!(left(&root).is_empty());
}

/// The repository's own fragments pass (CI runs `forge changelog check`).
#[test]
fn the_checkouts_fragments_are_valid() {
	let repo = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap();
	let r = run(&repo, &["check"]);
	assert_eq!(r.status, 0, "{}", r.stderr);
}
