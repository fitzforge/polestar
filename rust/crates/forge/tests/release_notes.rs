//! `forge release notes`: a version's CHANGELOG.md section as the GitHub, CurseForge and Discord notes,
//! lines joined, the requested version only, the same files on every run; the GitHub notes end with the
//! Contributors section, built here from a fixture repository and a stand-in `gh` that answers from
//! fixtures.

#![cfg(unix)]

use std::path::{Path, PathBuf};
use std::process::Command;

const CHANGELOG: &str = "# Changelog

## Unreleased

### For players

- Unreleased entry.

## 1.0.1 (2026-10-16)

### For players

- A fix that wraps
  onto a second line (thanks Ann and Bo).
- A list with
  - a sub-item that
    wraps

A paragraph
over two lines.

### For guide authors

- An authors' entry
  (thanks Cy).

### For contributors

- A contributors' entry.

## 1.0.0 (2026-10-01)

### For players

- Old entry.
";

/// The stand-in `gh`: answers the calls the contributors lookup makes from fixtures (`FAKE_GH_FAIL` makes
/// it fail like a `gh` that is not logged in).
const FAKE_GH: &str = r##"#!/bin/sh
if [ -n "$FAKE_GH_FAIL" ]; then echo "gh: not logged in" >&2; exit 4; fi
case "$*" in
*"pr list"*"--state merged"*)
cat <<'EOF'
[{"number":3,"author":{"login":"ann"},"mergedAt":"2026-11-02T10:00:00Z"},{"number":2,"author":{"login":"old"},"mergedAt":"2026-09-02T10:00:00Z"}]
EOF
;;
*"pr list"*) echo '[]' ;;
*"issue list"*)
cat <<'EOF'
[{"number":7,"author":{"login":"bob"},"body":"It broke.","createdAt":"2026-10-20T10:00:00Z","state":"CLOSED","stateReason":"COMPLETED","labels":[{"name":"bug"}],"closedByPullRequestsReferences":[{"number":3}],"comments":[]},
{"number":8,"author":{"login":"fitzforge"},"body":"**Reported by Zed on [Discord](https://discord.com/channels/1/2)**\n\n> it broke","createdAt":"2026-10-21T10:00:00Z","state":"CLOSED","stateReason":"COMPLETED","labels":[{"name":"bug"}],"closedByPullRequestsReferences":[{"number":3}],"comments":[]},
{"number":9,"author":{"login":"fitzforge"},"body":"**Reported by Pip on [Discord](https://discord.com/channels/1/3)**\n\n> it broke","createdAt":"2026-10-22T10:00:00Z","state":"CLOSED","stateReason":"COMPLETED","labels":[{"name":"bug"}],"closedByPullRequestsReferences":[{"number":3}],"comments":[]},
{"number":10,"author":{"login":"cid"},"body":"Old.","createdAt":"2026-09-20T10:00:00Z","state":"CLOSED","stateReason":"COMPLETED","labels":[{"name":"bug"}],"closedByPullRequestsReferences":[{"number":2}],"comments":[]},
{"number":12,"author":{"login":"fay"},"body":"Fixed straight on the branch.","createdAt":"2026-10-10T10:00:00Z","state":"CLOSED","stateReason":"COMPLETED","labels":[{"name":"bug"},{"name":"confirmed"}],"closedByPullRequestsReferences":[],"comments":[]}]
EOF
;;
*"api graphql"*)
cat <<'EOF'
{"data":{"repository":{
"c0":{"authors":{"nodes":[{"user":{"login":"fitzforge"}},{"user":{"login":"cy"}}]},"associatedPullRequests":{"nodes":[]}},
"c1":{"authors":{"nodes":[{"user":{"login":"ann"}}]},"associatedPullRequests":{"nodes":[
{"number":3,"state":"MERGED","mergedAt":"2026-11-02T10:00:00Z","author":{"__typename":"User","login":"ann"}},
{"number":4,"state":"MERGED","mergedAt":"2026-11-02T11:00:00Z","author":{"__typename":"Bot","login":"dependabot"}}]}}}}}
EOF
;;
*) echo "unexpected gh call: $*" >&2; exit 9 ;;
esac
"##;

const CREDITS: &str = r#"{ "supporters": [], "exclude": ["fitzforge"], "names": {}, "ideas": [], "github": { "pip": "PipGH" } }"#;

fn tmp(name: &str) -> PathBuf {
	let d = Path::new(env!("CARGO_TARGET_TMPDIR")).join("release-notes").join(name);
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

fn git(dir: &Path, args: &[&str]) {
	let out = Command::new("git").arg("-C").arg(dir).args(["-c", "user.name=T", "-c", "user.email=t@x.org", "-c", "commit.gpgsign=false", "-c", "tag.gpgsign=false"]).args(args).output().unwrap();
	assert!(out.status.success(), "git {args:?}: {}", String::from_utf8_lossy(&out.stderr));
}

/// A checkout: v1.0.0 at its base, then two commits (the fix of pull request 3 for issue 7, and a
/// maintainer's tidy-up with a co-author) that make the 1.0.1 range; the stand-in `gh` in `.bin`.
fn repo(name: &str) -> PathBuf {
	let dir = tmp(name);
	std::fs::write(dir.join("CHANGELOG.md"), CHANGELOG).unwrap();
	std::fs::create_dir_all(dir.join("data")).unwrap();
	std::fs::write(dir.join("data/credits.json"), CREDITS).unwrap();
	let bin = dir.join(".bin");
	std::fs::create_dir_all(&bin).unwrap();
	let gh = bin.join("gh");
	std::fs::write(&gh, FAKE_GH).unwrap();
	use std::os::unix::fs::PermissionsExt;
	std::fs::set_permissions(&gh, std::fs::Permissions::from_mode(0o755)).unwrap();
	git(&dir, &["init", "-q", "-b", "next"]);
	git(&dir, &["add", "CHANGELOG.md", "data"]);
	git(&dir, &["commit", "-q", "-m", "base"]);
	git(&dir, &["tag", "v1.0.0"]);
	std::fs::write(dir.join("fix.txt"), "fix").unwrap();
	git(&dir, &["add", "fix.txt"]);
	git(&dir, &["commit", "-q", "-m", "Fix the arrow (#7, #12)"]);
	std::fs::write(dir.join("tidy.txt"), "tidy").unwrap();
	git(&dir, &["add", "tidy.txt"]);
	git(&dir, &["commit", "-q", "-m", "Tidy up\n\nCo-authored-by: Cy <cy@x.org>"]);
	dir
}

fn notes(root: &Path, args: &[&str], out: &Path, fail_gh: bool) -> std::process::Output {
	let path = format!("{}:{}", root.join(".bin").display(), std::env::var("PATH").unwrap_or_default());
	let mut cmd = Command::new(env!("CARGO_BIN_EXE_forge"));
	cmd.args(["release", "notes"]).args(args).arg("--root").arg(root).arg("--out").arg(out).env("PATH", path);
	if fail_gh {
		cmd.env("FAKE_GH_FAIL", "1");
	}
	cmd.output().unwrap()
}

fn code(o: &std::process::Output) -> i32 {
	o.status.code().unwrap_or(-1)
}

#[test]
fn notes_write_the_requested_version_only_lines_joined() {
	let dir = repo("one");
	let out = dir.join("out");
	let run = notes(&dir, &["1.0.1"], &out, false);
	assert_eq!(code(&run), 0, "{}", String::from_utf8_lossy(&run.stderr));
	let gh = std::fs::read_to_string(out.join("notes-1.0.1.md")).unwrap();
	assert!(gh.starts_with("[[REPLACE"));
	assert!(gh.contains("- A fix that wraps onto a second line (thanks Ann and Bo).\n"));
	assert!(gh.contains("  - a sub-item that wraps\n"));
	assert!(gh.contains("A paragraph over two lines."));
	assert!(gh.contains("- An authors' entry (thanks Cy)."));
	for absent in ["Unreleased entry", "Old entry", "contributors' entry"] {
		assert!(!gh.contains(absent), "{absent}");
	}
	assert!(gh.contains("Ann, Bo, Cy"));
	let cf = std::fs::read_to_string(out.join("notes-curseforge-1.0.1.md")).unwrap();
	assert!(cf.contains("- A fix that wraps onto a second line"));
	assert!(!cf.contains("authors' entry"));
	let discord = std::fs::read_to_string(out.join("notes-discord-1.0.1.txt")).unwrap();
	assert!(discord.contains("- A fix that wraps onto a second line"));
	assert!(discord.contains("-# October 16, 2026"));
	// Deterministic: a second run writes the same files.
	let again = dir.join("again");
	assert_eq!(code(&notes(&dir, &["1.0.1"], &again, false)), 0);
	for f in ["notes-1.0.1.md", "notes-curseforge-1.0.1.md", "notes-discord-1.0.1.txt"] {
		assert_eq!(std::fs::read(out.join(f)).unwrap(), std::fs::read(again.join(f)).unwrap(), "{f}");
	}
	assert_eq!(code(&notes(&dir, &["9.9.9"], &out, false)), 1);
	assert_eq!(code(&notes(&dir, &["v1.0.1"], &out, false)), 2);
}

#[test]
fn the_github_notes_end_with_the_contributors_of_the_range_and_only_those() {
	let dir = repo("contributors");
	let out = dir.join("out");
	let run = notes(&dir, &["1.0.1"], &out, false);
	assert_eq!(code(&run), 0, "{}", String::from_utf8_lossy(&run.stderr));
	let gh = std::fs::read_to_string(out.join("notes-1.0.1.md")).unwrap();
	// PR author ann (and her commit), co-author cy, reporter bob, and Pip's relayed report through
	// data/credits.json "github"; not the maintainer, the bot, Zed's relayed report (no login), or what
	// the previous release already shipped (old, cid).
	assert!(gh.ends_with("/blob/v1.0.1/CHANGELOG.md).\n\n## Contributors\n\nThanks to everyone who made 1.0.1: @ann, @bob, @cy, @fay, @PipGH.\n"), "{gh}");
	for absent in ["@fitzforge", "@dependabot", "@old", "@cid", "@Zed"] {
		assert!(!gh.contains(absent), "{absent}");
	}
	for f in ["notes-curseforge-1.0.1.md", "notes-discord-1.0.1.txt"] {
		let other = std::fs::read_to_string(out.join(f)).unwrap();
		assert!(!other.contains("## Contributors") && !other.contains("@ann"), "{f}");
	}
	// What was tagged is printed with why, to read before publishing.
	let said = String::from_utf8_lossy(&run.stdout);
	assert!(said.contains("v1.0.0..HEAD, 2 commits") && said.contains("@ann: PR #3") && said.contains("@cy: co-author") && said.contains("@PipGH: reported #9"), "{said}");
	// The range can be named, and a tag that isn't there fails.
	let named = notes(&dir, &["1.0.1", "--since", "v1.0.0", "--release-ref", "HEAD~1"], &dir.join("named"), false);
	assert_eq!(code(&named), 0, "{}", String::from_utf8_lossy(&named.stderr));
	assert!(String::from_utf8_lossy(&named.stdout).contains("v1.0.0..HEAD~1, 1 commit)"));
	assert_eq!(code(&notes(&dir, &["1.0.1", "--since", "v7.7.7"], &dir.join("none"), false)), 1);
}

#[test]
fn notes_are_not_written_without_their_contributors_when_gh_fails() {
	let dir = repo("nogh");
	let out = dir.join("out");
	let run = notes(&dir, &["1.0.1"], &out, true);
	assert_eq!(code(&run), 1);
	assert!(String::from_utf8_lossy(&run.stderr).contains("not logged in"));
	assert!(!out.join("notes-1.0.1.md").exists());
}
