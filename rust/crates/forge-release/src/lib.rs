//! Building and releasing the addon (docs/RELEASING.md), behind `forge release` and `forge changelog`:
//!
//! - [`zip`]: the deterministic ZIP writer and reader the release archives use.
//! - [`addons`]: which addon folders a release ships, in load order, and whether the Codex may ship.
//! - [`pack`]: the release archives' entries and the players' README.txt.
//! - [`version`]: the version in package.json, guides/pack.json and every addon TOC.
//! - [`changelog`]: the changelog fragments in changes/ and the release section they become.
//! - [`notes`]: the release notes (GitHub, CurseForge, Discord) from a version's changelog section.
//! - [`credits`]: the Guiding Stars page's names (addon/Polestar/Core/Credits.lua).

pub mod addons;
pub mod changelog;
pub mod credits;
pub mod notes;
pub mod pack;
pub mod version;
pub mod zip;

use std::path::{Component, Path, PathBuf};

/// `p` made absolute against the working directory, `.` and `..` resolved by name (Node's
/// `path.resolve`).
pub fn absolute(p: &Path) -> PathBuf {
	let joined = if p.is_absolute() { p.to_path_buf() } else { std::env::current_dir().unwrap_or_default().join(p) };
	let mut out = PathBuf::new();
	for c in joined.components() {
		match c {
			Component::ParentDir => {
				out.pop();
			}
			Component::CurDir => {}
			c => out.push(c),
		}
	}
	out
}

/// `to` relative to `from`, both made absolute first, with `..` where needed and `/` between parts
/// (Node's `path.relative` on POSIX); "" when they are the same folder.
pub fn relative(from: &Path, to: &Path) -> String {
	let (from, to) = (absolute(from), absolute(to));
	let a: Vec<Component> = from.components().collect();
	let b: Vec<Component> = to.components().collect();
	let common = a.iter().zip(&b).take_while(|(x, y)| x == y).count();
	let mut parts: Vec<String> = vec!["..".into(); a.len() - common];
	parts.extend(b[common..].iter().map(|c| c.as_os_str().to_string_lossy().into_owned()));
	parts.join("/")
}

/// `path` as the commands show it: relative to the working directory.
pub fn shown(path: &Path) -> String {
	relative(&std::env::current_dir().unwrap_or_default(), path)
}

/// "1 guide", "2 guides".
pub fn plural(n: usize, word: &str) -> String {
	format!("{n} {word}{}", if n == 1 { "" } else { "s" })
}

/// A release version: `x.y.z`, or `x.y.z-<pre>` for a candidate.
pub fn is_version(s: &str) -> bool {
	static RE: std::sync::LazyLock<regex::Regex> = std::sync::LazyLock::new(|| regex::Regex::new(r"^\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?$").unwrap());
	RE.is_match(s)
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn relative_paths_like_node() {
		assert_eq!(relative(Path::new("/a/b"), Path::new("/a/b/c/d")), "c/d");
		assert_eq!(relative(Path::new("/a/b"), Path::new("/a/x")), "../x");
		assert_eq!(relative(Path::new("/a/b"), Path::new("/a/b")), "");
		assert_eq!(relative(Path::new("/a/b"), Path::new("/a/b/./c/../e")), "e");
	}

	#[test]
	fn versions() {
		for v in ["0.2.0", "10.0.1", "0.3.0-rc.1", "1.0.0-beta-2"] {
			assert!(is_version(v), "{v}");
		}
		for v in ["1.0", "v0.2.0", "0.2.0-", "0.2.0 ", "1.0.0+build"] {
			assert!(!is_version(v), "{v}");
		}
	}
}
