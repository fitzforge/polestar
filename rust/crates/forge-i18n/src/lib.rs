//! Polestar's translations (docs/TRANSLATING.md), `forge i18n`: the interface strings of each addon
//! (addon/<addon>/Locales/<locale>.lua: their keys, state, sync and import), a guide pack's texts in
//! other languages (`<pack>/locales/<locale>/`) and the English a non-English client would show
//! (`i18n leaks`). Port of tools/commands/i18n.js and tools/lib/i18n. The file layout and the guide
//! texts' read side are forge-guide's (i18n_files, i18n_guides, locales, toc). Adapted from Ding! by
//! Yendi (@moust4ki), GPL-3.0: https://github.com/moust4ki/DingGuideWoWForever

use std::path::{Path, PathBuf};

pub mod format;
pub mod glossary;
pub mod guides;
pub mod keys;
pub mod leaks;
pub mod project;

/// The translations' data, under the checkout: glossary/<locale>.json, leaks-allow.json,
/// leaks-baseline.json.
pub const DATA_DIR: &str = "data/i18n";

/// An addon with interface translations, each with Locales/<locale>.lua: Polestar's own (loaded by
/// Core/Core.xml) and the Recorder's (its TOC).
pub struct Addon {
	pub name: &'static str,
	pub title: &'static str,
}

pub const ADDONS: [Addon; 2] = [Addon { name: "Polestar", title: "Polestar's interface strings" }, Addon { name: "Polestar_Recorder", title: "Polestar Recorder's interface strings" }];

/// `n word` or `n words`.
pub fn plural(n: usize, word: &str) -> String {
	format!("{n} {word}{}", if n == 1 { "" } else { "s" })
}

/// A path as the messages show it: relative to the working directory (with /) when inside it, else
/// as it is.
pub fn rel(file: &Path) -> String {
	forge_guide::project::shown(file)
}

/// `path` made absolute against the working directory, `.` and `..` resolved (Node's path.resolve).
pub fn absolute(path: &Path) -> PathBuf {
	let cwd = std::env::current_dir().unwrap_or_default();
	forge_addontest::run::join(&cwd, &path.to_string_lossy())
}
