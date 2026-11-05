//! `forge release notes`: a version's CHANGELOG.md section as the GitHub, CurseForge and Discord notes,
//! lines joined, the requested version only, the same files on every run.

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

fn tmp(name: &str) -> PathBuf {
	let d = Path::new(env!("CARGO_TARGET_TMPDIR")).join("release-notes").join(name);
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

fn notes(root: &Path, version: &str, out: &Path) -> i32 {
	Command::new(env!("CARGO_BIN_EXE_forge")).args(["release", "notes", version, "--root"]).arg(root).arg("--out").arg(out).output().unwrap().status.code().unwrap_or(-1)
}

#[test]
fn notes_write_the_requested_version_only_lines_joined() {
	let dir = tmp("one");
	std::fs::write(dir.join("CHANGELOG.md"), CHANGELOG).unwrap();
	let out = dir.join("out");
	assert_eq!(notes(&dir, "1.0.1", &out), 0);
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
	assert_eq!(notes(&dir, "1.0.1", &again), 0);
	for f in ["notes-1.0.1.md", "notes-curseforge-1.0.1.md", "notes-discord-1.0.1.txt"] {
		assert_eq!(std::fs::read(out.join(f)).unwrap(), std::fs::read(again.join(f)).unwrap(), "{f}");
	}
	assert_eq!(notes(&dir, "9.9.9", &out), 1);
	assert_eq!(notes(&dir, "v1.0.1", &out), 2);
}
