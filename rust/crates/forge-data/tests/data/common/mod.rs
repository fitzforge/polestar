//! Shared by the golden tests: rust/tests/golden/<stage>/ paths and the byte comparison.
#![allow(dead_code)]

use std::path::{Path, PathBuf};

/// rust/tests/golden/<stage> (canonical: goldens write their input folder's path as `<input>`).
pub fn golden(stage: &str) -> PathBuf {
	let d = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden").join(stage);
	std::fs::canonicalize(&d).unwrap_or_else(|e| panic!("{}: {e}", d.display()))
}

/// A scratch folder under the target dir (emptied), for builds that write.
pub fn scratch(name: &str) -> PathBuf {
	let d = Path::new(env!("CARGO_TARGET_TMPDIR")).join("golden").join(name);
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

/// Copies a folder tree (a golden input a build writes into).
pub fn copy_tree(from: &Path, to: &Path) {
	std::fs::create_dir_all(to).unwrap();
	for e in std::fs::read_dir(from).unwrap_or_else(|e| panic!("{}: {e}", from.display())).flatten() {
		let p = e.path();
		let t = to.join(e.file_name());
		if p.is_dir() {
			copy_tree(&p, &t);
		} else {
			std::fs::copy(&p, &t).unwrap();
		}
	}
}

/// Compares each (name, text) with <dir>/<name> byte for byte; collects every difference.
pub struct Check {
	bad: Vec<String>,
	seen: usize,
}

impl Check {
	pub fn new() -> Check {
		Check { bad: Vec::new(), seen: 0 }
	}

	/// Compares with `want_file`, or with its gzipped `<want_file>.gz` when only that exists. With
	/// FORGE_GOLDEN_BLESS=1 the golden file (gzipped when the golden is) is rewritten with `got`
	/// (review the diff before committing).
	pub fn file(&mut self, name: &str, got: &str, want_file: &Path) {
		self.seen += 1;
		let gz = PathBuf::from(format!("{}.gz", want_file.display()));
		if std::env::var_os("FORGE_GOLDEN_BLESS").is_some() {
			std::fs::create_dir_all(want_file.parent().unwrap()).unwrap();
			if !want_file.exists() && gz.exists() {
				let mut e = flate2::write::GzEncoder::new(Vec::new(), flate2::Compression::best());
				std::io::Write::write_all(&mut e, got.as_bytes()).unwrap();
				std::fs::write(&gz, e.finish().unwrap()).unwrap();
			} else {
				std::fs::write(want_file, got).unwrap();
			}
			return;
		}
		let want = if !want_file.exists() && gz.exists() {
			std::fs::read(&gz).and_then(|b| {
				let mut out = Vec::new();
				std::io::Read::read_to_end(&mut flate2::read::GzDecoder::new(&b[..]), &mut out).map(|_| out)
			})
		} else {
			std::fs::read(want_file)
		};
		match want {
			Ok(want) => self.bytes(name, got.as_bytes(), &want),
			Err(e) => self.bad.push(format!("{name}: golden {} unreadable ({e})", want_file.display())),
		}
	}

	pub fn bytes(&mut self, name: &str, got: &[u8], want: &[u8]) {
		if got == want {
			return;
		}
		let at = got.iter().zip(want).position(|(a, b)| a != b).unwrap_or(got.len().min(want.len()));
		let line = got[..at].iter().filter(|&&c| c == b'\n').count() + 1;
		let ctx = |b: &[u8]| String::from_utf8_lossy(&b[at.saturating_sub(80)..(at + 80).min(b.len())]).into_owned();
		self.bad.push(format!("{name}: differs at byte {at} (line {line}; {} vs golden {} bytes)\n  rust:   {}\n  golden: {}", got.len(), want.len(), ctx(got), ctx(want)));
	}

	pub fn missing(&mut self, what: String) {
		self.bad.push(what);
	}

	/// Every file of `dir` must have been checked (none the build no longer writes); `<name>.gz` is `<name>`.
	pub fn all_of(&mut self, dir: &Path, names: &[String]) {
		for e in std::fs::read_dir(dir).unwrap().flatten() {
			let n = e.file_name().to_string_lossy().to_string();
			if !names.contains(&n) && !n.strip_suffix(".gz").is_some_and(|s| names.iter().any(|x| x == s)) {
				self.bad.push(format!("{n}: in the golden {} but not built", dir.display()));
			}
		}
	}

	pub fn finish(self, what: &str) {
		assert!(self.seen > 0, "{what}: nothing compared");
		assert!(self.bad.is_empty(), "{what}: {} difference(s) from the golden:\n{}", self.bad.len(), self.bad.join("\n"));
	}
}

/// The path text a golden writes as `<input>` (its input folder's absolute path).
pub fn unroot(text: &str, input: &Path) -> String {
	text.replace(&input.display().to_string(), "<input>")
}
