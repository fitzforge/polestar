//! Changelog fragments: each change is its own file, changes/<slug>.md, so concurrent pull requests never
//! touch the same lines of CHANGELOG.md. A fragment is front matter naming its section, then the entry as
//! CHANGELOG.md writes it:
//!
//! ```text
//! ---
//! section: players
//! ---
//! - Ticking a quest's accept off without taking the quest no longer sends
//!   you to farm for it.
//! ```
//!
//! A release gathers the fragments under one `## <version> (<date>)` heading, above the newest release,
//! and deletes them.

use forge_guide::lexer::js_trim_end;
use std::path::{Path, PathBuf};
use std::sync::LazyLock;

pub const DIR: &str = "changes";
const README: &str = "README.md";

/// The sections, in CHANGELOG.md's order, with their headings.
pub const SECTIONS: [(&str, &str); 4] = [("players", "For players"), ("authors", "For guide authors"), ("contributors", "For contributors"), ("forge", "Forge")];

const WRAP: usize = 78;
const SLUG_WORDS: usize = 6;
const SLUG_MAX: usize = 48;

/// The section keys, comma-joined, for messages.
pub fn section_keys() -> String {
	SECTIONS.iter().map(|(k, _)| *k).collect::<Vec<_>>().join(", ")
}

pub fn is_section(key: &str) -> bool {
	SECTIONS.iter().any(|(k, _)| *k == key)
}

/// A fragment's section and entry (no leading blank lines, no trailing whitespace).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Parsed {
	pub section: String,
	pub body: String,
}

fn lf(text: &str) -> String {
	text.replace("\r\n", "\n").replace('\r', "\n")
}

/// Parses a fragment; Err says what is wrong with it.
pub fn parse_fragment(text: &str) -> Result<Parsed, String> {
	static KEY: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r"^([A-Za-z]+):\s*(.*?)\s*$").unwrap());
	let text = lf(text);
	let lines: Vec<&str> = text.split('\n').collect();
	if lines[0] != "---" {
		return Err("no front matter (a first line \"---\")".into());
	}
	let Some(end) = lines.iter().skip(1).position(|l| *l == "---").map(|i| i + 1) else {
		return Err("front matter not closed by \"---\"".into());
	};
	let mut section = None;
	for line in &lines[1..end] {
		if line.trim().is_empty() {
			continue;
		}
		let Some(m) = KEY.captures(line) else {
			return Err(format!("front matter line \"{line}\" is not \"key: value\""));
		};
		if &m[1] != "section" {
			return Err(format!("unknown front matter key \"{}\"", &m[1]));
		}
		section = Some(m[2].to_string());
	}
	let Some(section) = section else {
		return Err(format!("no section (use {})", section_keys()));
	};
	if !is_section(&section) {
		return Err(format!("unknown section \"{section}\" (use {})", section_keys()));
	}
	let rest = lines[end + 1..].join("\n");
	// Leading blank lines (spaces and tabs only) dropped, trailing whitespace trimmed.
	let mut body: &str = &rest;
	while let Some(nl) = body.find('\n') {
		if body[..nl].chars().all(|c| c == ' ' || c == '\t') {
			body = &body[nl + 1..];
		} else {
			break;
		}
	}
	let body = js_trim_end(body);
	if body.is_empty() {
		return Err("no entry after the front matter".into());
	}
	if !body.starts_with("- ") {
		return Err("the entry does not start with \"- \"".into());
	}
	Ok(Parsed { section, body: body.to_string() })
}

pub fn format_fragment(section: &str, body: &str) -> String {
	format!("---\nsection: {section}\n---\n{}\n", js_trim_end(body))
}

/// A file in changes/: its name (`changes/<file>`), path and parse.
#[derive(Clone, Debug)]
pub struct Fragment {
	pub name: String,
	pub file: PathBuf,
	pub parsed: Result<Parsed, String>,
}

/// Every file in `<root>/changes/` but its README and hidden files, sorted by name (UTF-16 code units,
/// the same order everywhere).
pub fn read_fragments(root: &Path) -> Vec<Fragment> {
	let dir = root.join(DIR);
	let mut names: Vec<String> = std::fs::read_dir(&dir).into_iter().flatten().flatten().map(|e| e.file_name().to_string_lossy().into_owned()).filter(|n| n != README && !n.starts_with('.')).collect();
	names.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
	names
		.into_iter()
		.map(|name| {
			let file = dir.join(&name);
			let parsed = if !name.ends_with(".md") || !file.is_file() {
				Err("not a .md fragment".to_string())
			} else {
				std::fs::read_to_string(&file).map_err(|e| e.to_string()).and_then(|t| parse_fragment(&t))
			};
			Fragment { name: format!("{DIR}/{name}"), file, parsed }
		})
		.collect()
}

/// The `### ...` sections the (valid) fragments fill, in order, each followed by its entries; "" when
/// there are none.
pub fn assemble(fragments: &[Parsed]) -> String {
	let mut parts = Vec::new();
	for (key, heading) in SECTIONS {
		let bodies: Vec<&str> = fragments.iter().filter(|f| f.section == key).map(|f| f.body.as_str()).collect();
		if !bodies.is_empty() {
			parts.push(format!("### {heading}\n\n{}\n", bodies.join("\n")));
		}
	}
	parts.join("\n")
}

/// Whether the changelog has a `## Unreleased` section (its entries belong in fragments).
pub fn has_unreleased(changelog: &str) -> bool {
	static RE: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r"(?m)^## Unreleased[^\S\n]*$").unwrap());
	RE.is_match(&lf(changelog))
}

/// Whether the changelog has a `## <version>` heading already.
pub fn has_version(changelog: &str, version: &str) -> bool {
	regex::Regex::new(&format!(r"(?m)^## {}(?:[^\S\n]+\(|[^\S\n]*$)", regex::escape(version))).unwrap().is_match(changelog)
}

/// The changelog with a `## <version> (<date>)` section holding the fragments, above the first `## `
/// heading (the newest release), or at the end when there is none.
pub fn insert_release(changelog: &str, version: &str, date: &str, fragments: &[Parsed]) -> String {
	let section = format!("## {version} ({date})\n\n{}", assemble(fragments));
	static HEAD: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r"(?m)^## ").unwrap());
	if let Some(m) = HEAD.find(changelog) {
		return format!("{}{section}\n{}", &changelog[..m.start()], &changelog[m.start()..]);
	}
	let head = js_trim_end(changelog);
	if head.is_empty() {
		section
	} else {
		format!("{head}\n\n{section}")
	}
}

/// A file name from the first words of `text` (or from a name given): lower case, accents dropped, at
/// most six words and 48 characters.
pub fn slugify(text: &str) -> String {
	use unicode_normalization::UnicodeNormalization;
	static ITEM: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r"^\s*-\s+").unwrap());
	static WORD: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r"[a-z0-9]+").unwrap());
	let folded: String = text.to_lowercase().nfkd().filter(|c| !('\u{300}'..='\u{36f}').contains(c)).collect();
	let folded = ITEM.replace(&folded, "");
	let words: Vec<&str> = WORD.find_iter(&folded).map(|m| m.as_str()).collect();
	let Some(first) = words.first() else { return String::new() };
	let mut slug = String::new();
	for w in words.iter().take(SLUG_WORDS) {
		let next = if slug.is_empty() { w.to_string() } else { format!("{slug}-{w}") };
		if next.len() > SLUG_MAX {
			break;
		}
		slug = next;
	}
	if slug.is_empty() {
		first.chars().take(SLUG_MAX).collect()
	} else {
		slug
	}
}

/// Entry text as a fragment body: text already a list item (`- ...`) is kept as written; plain text
/// becomes one item, wrapped at 78 columns.
pub fn to_entry(text: &str) -> String {
	let lf = lf(text);
	let t = forge_guide::lexer::js_trim(&lf);
	if t.starts_with("- ") {
		return t.to_string();
	}
	let mut lines = Vec::new();
	let mut line = String::from("-");
	let mut words = 0;
	for word in t.split_whitespace() {
		if words > 0 && line.chars().count() + 1 + word.chars().count() > WRAP {
			lines.push(std::mem::replace(&mut line, " ".into()));
			words = 0;
		}
		line.push(' ');
		line.push_str(word);
		words += 1;
	}
	lines.push(line);
	lines.join("\n")
}

#[cfg(test)]
mod tests {
	use super::*;

	fn frag(section: &str, body: &str) -> String {
		format!("---\nsection: {section}\n---\n{body}\n")
	}

	#[test]
	fn fragments_parse_or_say_what_is_wrong() {
		assert_eq!(parse_fragment(&frag("players", "\n- A.\n  b.  \n\n")).unwrap(), Parsed { section: "players".into(), body: "- A.\n  b.".into() });
		let bad = [
			("- No front matter.\n", "no front matter"),
			("---\nsection: players\n- Never closed.\n", "not closed"),
			(&frag("everyone", "- Unknown section."), "unknown section \"everyone\""),
			("---\n---\n- No section.\n", "no section"),
			("---\nsection: players\nauthor: me\n---\n- Unknown key.\n", "unknown front matter key \"author\""),
			(&frag("players", ""), "no entry"),
			(&frag("players", "Not a list item."), "does not start with"),
		];
		for (text, want) in bad {
			let e = parse_fragment(text).unwrap_err();
			assert!(e.contains(want), "{text:?}: {e}");
		}
	}

	#[test]
	fn slugs_from_the_first_words() {
		assert_eq!(slugify("- Walks between zones go through the real tunnels,\n  passes and bridges."), "walks-between-zones-go-through-the");
		assert_eq!(slugify("Évite les détours"), "evite-les-detours");
		assert_eq!(slugify("!!!"), "");
		assert_eq!(slugify(&"x".repeat(60)), "x".repeat(48));
	}

	#[test]
	fn plain_text_becomes_one_item_wrapped_at_78_columns() {
		let words: Vec<String> = (0..40).map(|i| format!("word{i}")).collect();
		let entry = to_entry(&words.join(" "));
		let lines: Vec<&str> = entry.split('\n').collect();
		assert!(lines[0].starts_with("- word0 "));
		for l in &lines[1..] {
			assert!(l.starts_with("  ") && !l[2..].starts_with(' '), "{l}");
		}
		for l in &lines {
			assert!(l.len() <= 78, "{l}");
		}
		assert_eq!(entry.trim_start_matches("- ").split_whitespace().collect::<Vec<_>>(), words);
		assert_eq!(to_entry("  - Kept\n  as written.\n"), "- Kept\n  as written.");
	}

	#[test]
	fn versions_and_unreleased_sections_are_found() {
		let log = "# Changelog\n\n## 0.2.4 (2026-10-16)\n\n- A.\n";
		assert!(has_version(log, "0.2.4"));
		assert!(!has_version(log, "0.2"));
		assert!(!has_unreleased(log));
		assert!(has_unreleased("# Changelog\r\n\r\n## Unreleased \r\n"));
	}
}
