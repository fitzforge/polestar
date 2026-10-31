//! forge-nav's walking-map writer (`forge nav pack`): parity with the JS writer on the nav-pack golden
//! and, opt-in, on a real grid; ship/check; the ground classes, capitals, zones and encodings; the
//! hand-made fixture maps of the addon router's tests.
#![cfg(feature = "native")]

mod golden;
mod hubs;
mod leffe;
mod units;

use std::path::{Path, PathBuf};

pub fn golden_dir() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden")
}

/// A fresh temporary folder.
pub fn tmp(name: &str) -> PathBuf {
	let d = std::env::temp_dir().join(format!("forge-nav-pack-{name}-{}", std::process::id()));
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

/// Every file under `dir`, relative, sorted.
pub fn files_under(dir: &Path) -> Vec<String> {
	let mut out = Vec::new();
	let mut stack = vec![dir.to_path_buf()];
	while let Some(d) = stack.pop() {
		for e in std::fs::read_dir(&d).unwrap().flatten() {
			let p = e.path();
			if p.is_dir() {
				stack.push(p);
			} else {
				out.push(p.strip_prefix(dir).unwrap().to_string_lossy().into_owned());
			}
		}
	}
	out.sort();
	out
}
