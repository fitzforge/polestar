//! Temp folders for tests, removed on drop.

use std::path::{Path, PathBuf};
use std::sync::atomic::{AtomicUsize, Ordering};

/// A fresh folder under the OS temp folder, removed (with what is in it) when dropped.
pub struct TempDir(PathBuf);

impl TempDir {
	pub fn new(prefix: &str) -> TempDir {
		static NEXT: AtomicUsize = AtomicUsize::new(0);
		let n = NEXT.fetch_add(1, Ordering::Relaxed);
		let nanos = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).map_or(0, |d| d.subsec_nanos());
		let dir = std::env::temp_dir().join(format!("{prefix}{}-{n}-{nanos}", std::process::id()));
		std::fs::create_dir_all(&dir).unwrap_or_else(|e| panic!("{}: {e}", dir.display()));
		TempDir(dir)
	}
	pub fn path(&self) -> &Path {
		&self.0
	}
}

impl Drop for TempDir {
	fn drop(&mut self) {
		let _ = std::fs::remove_dir_all(&self.0);
	}
}
