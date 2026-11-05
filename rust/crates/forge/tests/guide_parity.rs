//! Byte parity with the JS compiler: compiles each committed input with the Rust binary against the
//! committed data slice (rust/tests/golden/world/root/data/forever) and compares every file and the diagnostics with
//! the JS compiler's output in rust/tests/golden/guide/expected/<name> (made by
//! rust/tests/golden/guide/regen.sh; see its README). Any difference fails. Since format 8 the expected
//! output of Polestar's own pack (both inputs) is forge's: packed spawn spots and faction parts, which the JS
//! compiler never wrote (the README).

use std::path::{Path, PathBuf};
use std::process::Command;

fn repo() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

fn files(dir: &Path, base: &Path, out: &mut Vec<PathBuf>) {
	let mut ents: Vec<_> = std::fs::read_dir(dir).unwrap().flatten().collect();
	ents.sort_by_key(|e| e.file_name());
	for e in ents {
		let p = e.path();
		if p.is_dir() {
			files(&p, base, out);
		} else {
			out.push(p.strip_prefix(base).unwrap().to_path_buf());
		}
	}
}

/// Compiles `guides` (relative to the repo, as the diagnostics name files) and compares with `reference`.
fn check(name: &str, guides: &str, reference: &Path) -> Vec<String> {
	assert!(reference.is_dir(), "parity {name}: no reference at {}", reference.display());
	let got = Path::new(env!("CARGO_TARGET_TMPDIR")).join(format!("guide-parity-{name}"));
	let _ = std::fs::remove_dir_all(&got);
	std::fs::create_dir_all(&got).unwrap();
	let out = Command::new(env!("CARGO_BIN_EXE_forge"))
		.current_dir(repo())
		.args(["guide", "compile", "--guides", guides, "--data", "rust/tests/golden/world/root/data/forever", "--out"])
		.arg(got.join("pack"))
		.args(["--force", "--format", "json"])
		.output()
		.unwrap();
	std::fs::write(got.join("diagnostics.json"), &out.stdout).unwrap();
	let (mut a, mut b) = (Vec::new(), Vec::new());
	files(reference, reference, &mut a);
	files(&got, &got, &mut b);
	let mut diffs = Vec::new();
	for f in a.iter().filter(|f| !b.contains(f)) {
		diffs.push(format!("{name}: only in JS: {}", f.display()));
	}
	for f in b.iter().filter(|f| !a.contains(f)) {
		diffs.push(format!("{name}: only in Rust: {}", f.display()));
	}
	for f in a.iter().filter(|f| b.contains(f)) {
		if std::fs::read(reference.join(f)).unwrap() != std::fs::read(got.join(f)).unwrap() {
			diffs.push(format!("{name}: differs: {} (rust output in {})", f.display(), got.display()));
		}
	}
	diffs
}

#[test]
fn compiled_packs_equal_the_js_compiler() {
	let expected = repo().join("rust/tests/golden/guide/expected");
	let reference = |name: &str| expected.join(name);
	let mut diffs = Vec::new();
	diffs.extend(check("mini", "rust/crates/forge-guide/tests/fixtures/mini", &reference("mini")));
	diffs.extend(check("slice", "rust/tests/golden/guide/slice", &reference("slice")));
	assert!(diffs.is_empty(), "{}", diffs.join("\n"));
}
