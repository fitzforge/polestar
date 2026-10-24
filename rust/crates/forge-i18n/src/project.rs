//! The state of every interface translation of an addon (port of tools/lib/i18n/project.js), per
//! locale: translated, missing, stale and broken entries and glossary warnings; and the files
//! `i18n sync` writes.

use crate::format::format_problems;
use crate::glossary::{glossary_warnings, read_glossary, Warning};
use crate::keys::{extract_keys, Keys};
use crate::rel;
use forge_guide::i18n_files::{locale_file, new_locale_text, read_locale_files, update_locale_text, LocaleUpdate};
use forge_guide::js::V;
use std::collections::HashSet;
use std::path::{Path, PathBuf};

/// One locale's file and what it holds.
pub struct LocaleStatus {
	pub file: PathBuf,
	pub exists: bool,
	pub error: Option<String>,
	/// (key, translation), in the file's order.
	pub translated: Vec<(String, String)>,
	pub missing: Vec<String>,
	/// (key, translation) of keys the code no longer has.
	pub stale: Vec<(String, String)>,
	/// (key, problem).
	pub problems: Vec<(String, String)>,
	pub warnings: Vec<Warning>,
}

impl LocaleStatus {
	pub fn translation(&self, key: &str) -> Option<&str> {
		self.translated.iter().find(|(k, _)| k == key).map(|(_, v)| v.as_str())
	}
}

pub struct State {
	pub keys: Keys,
	/// Per locale asked, in that order.
	pub locales: Vec<(String, LocaleStatus)>,
}

impl State {
	pub fn locale(&self, locale: &str) -> Option<&LocaleStatus> {
		self.locales.iter().find(|(l, _)| l == locale).map(|(_, s)| s)
	}
}

/// The state of `locales` in the addon at `addon_dir` (absolute). `glossary_dir`: the glossaries
/// (default `root`/data/i18n/glossary).
pub fn locale_state(root: &Path, addon_dir: &Path, locales: &[String], glossary_dir: Option<&Path>) -> Result<State, String> {
	let keys = extract_keys(root, addon_dir)?;
	let default_glossary = root.join(crate::DATA_DIR).join("glossary");
	let glossary_dir = glossary_dir.unwrap_or(&default_glossary);
	let entries: Vec<(String, String)> = locales.iter().map(|l| (locale_file(addon_dir, l), l)).filter(|(f, _)| f.exists()).map(|(f, l)| (f.to_string_lossy().into_owned(), l.clone())).collect();
	let read = read_locale_files(&entries)?;
	let mut out = Vec::new();
	for locale in locales {
		let file = locale_file(addon_dir, locale);
		let r = entries.iter().position(|(_, l)| l == locale).map(|i| &read[i]);
		let mut s = LocaleStatus {
			file,
			exists: r.is_some(),
			error: r.filter(|r| !r.ok).map(|r| r.error.clone().unwrap_or_default()),
			translated: Vec::new(),
			missing: Vec::new(),
			stale: Vec::new(),
			problems: Vec::new(),
			warnings: Vec::new(),
		};
		if let Some(r) = r.filter(|r| r.ok) {
			match r.layout.as_deref() {
				Some("L") => {}
				layout => {
					let how = if layout == Some("return") { "a returned table" } else { "ns.AddTranslations(...)" };
					s.error = Some(format!("written as {how}, not as L[\"...\"] = \"...\" lines (docs/TRANSLATING.md; `i18n import` reads such files)"));
				}
			}
			if s.error.is_none() {
				for k in &r.bad {
					s.problems.push((k.clone(), "the key or the value is not a string".into()));
				}
				for k in &r.twice {
					s.problems.push((k.clone(), "set twice (the second wins); keep one line".into()));
				}
				for (k, v) in r.strings.entries() {
					let v = v.to_js_string();
					if !keys.has(&k) {
						s.stale.push((k.to_string(), v));
						continue;
					}
					if v.is_empty() {
						continue;
					}
					for p in format_problems(&k, &v) {
						s.problems.push((k.to_string(), p));
					}
					s.translated.push((k.to_string(), v));
				}
				s.warnings = glossary_warnings(read_glossary(locale, glossary_dir)?.as_deref(), &s.translated);
			}
		}
		let done: HashSet<&str> = s.translated.iter().map(|(k, _)| k.as_str()).collect();
		s.missing = keys.list.iter().filter(|(k, _)| !done.contains(k.as_str())).map(|(k, _)| k.clone()).collect();
		out.push((locale.clone(), s));
	}
	Ok(State { keys, locales: out })
}

/// What sync does to `state`: for each locale that has a file and each locale in `create` that has
/// none (headed "<language> (<locale>): <title>."), its new text and what changed, in locale order.
/// `fill` and `retire` ((locale, { key: value })) are update_locale_text's. A locale whose file has an
/// error is left out.
pub fn sync_files(state: &State, create: &[String], fill: &[(String, V)], retire: &[(String, V)], title: &str) -> Result<Vec<(PathBuf, LocaleUpdate)>, String> {
	let keys = state.keys.by_file();
	let of = |list: &[(String, V)], l: &str| list.iter().find(|(x, _)| x == l).map_or_else(V::obj, |(_, v)| v.clone());
	let mut out = Vec::new();
	for (locale, s) in &state.locales {
		if s.error.is_some() {
			continue;
		}
		let (fill, retire) = (of(fill, locale), of(retire, locale));
		if s.exists {
			let text = std::fs::read_to_string(&s.file).map_err(|e| format!("{}: {e}", s.file.display()))?;
			out.push((s.file.clone(), update_locale_text(&text, &rel(&s.file), &keys, &fill, &retire)?));
		} else if create.contains(locale) {
			out.push((s.file.clone(), new_locale_text(locale, &keys, &fill, &retire, title)?));
		}
	}
	Ok(out)
}
