//! `forge i18n audit`: the names the client has in each language, held against the translations. A
//! text whose English names a spell, a talent, an area or a skill line (a talent tree) should carry
//! the client's name for it, as the player reads it in the game. `i18n check` knows no client table;
//! this does, so it is its own read-only command. The tables come in as maps (forge_data loads and
//! caches them), so everything here runs on fixtures.
//!
//! A name of one word is also an everyday word (Fire, Shadow, Charge): it counts only as the whole
//! English text, never inside a sentence. A name of several words counts wherever the English has it
//! as whole words. A talent tree is also asked for by the first words of its name, as a whole text
//! (the addon's "Shadow" is the client's "Shadow Magic"); a role in brackets after the text ("Holy
//! (healer)") is left out. The translation may inflect it and put it in any case: each word of the
//! client's name needs only its first letters, without the last three, in the text.

use forge_guide::i18n_files::unescape_lua_text;
use regex::Regex;
use std::collections::{BTreeMap, BTreeSet};
use std::path::{Path, PathBuf};
use std::sync::LazyLock;

/// kind -> id -> name, as the client tables hold them.
pub type KindNames = BTreeMap<&'static str, BTreeMap<i64, String>>;

/// A translated line: the English, its translation and where it stands.
pub struct Text {
	pub file: String,
	pub line: usize,
	pub en: String,
	pub tr: String,
}

/// A name the English has, in the client's words.
pub struct Entry {
	pub kind: String,
	pub client: Vec<String>,
}

/// A text that has an English name without the client's name for it.
pub struct Finding {
	pub kind: String,
	pub en: String,
	pub client: Vec<String>,
	pub file: String,
	pub line: usize,
	pub text: String,
	pub tr: String,
}

const MIN_LENGTH: usize = 6;
const ARTICLES: [&str; 10] = ["der", "die", "das", "el", "la", "le", "les", "los", "las", "the"];

// A translation line: L["English"] = "Translation" (the interface) or ["English"] = "Translation",
// (guide texts); one entry per line.
static LINE: LazyLock<Regex> = LazyLock::new(|| Regex::new(r#"^\s*L?\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"\s*,?\s*$"#).unwrap());
static PLACEHOLDERS: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\{[a-z]+:\d+\}|%(?:\d+\$)?[-+ #0-9.]*[a-zA-Z]|\|c[0-9a-fA-F]{8}|\|r|\|T[^|]*\|t").unwrap());
static WORD_BREAKS: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"[^\p{L}\p{N}]+").unwrap());
static FIRST_WORDS: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"[^\p{L}'-]+").unwrap());
static ROLE: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\s*\([^)]*\)$").unwrap());

/// JS \s (String.prototype.trim's white space).
fn js_space(c: char) -> bool {
	matches!(c, '\t' | '\n' | '\u{b}' | '\u{c}' | '\r' | ' ' | '\u{a0}' | '\u{1680}' | '\u{2000}'..='\u{200a}' | '\u{2028}' | '\u{2029}' | '\u{202f}' | '\u{205f}' | '\u{3000}' | '\u{feff}')
}

/// The filled-in lines of Lua files, in the files' order (empty translations are no translation).
/// `shown` is how a file is named in a finding.
pub fn read_texts(files: &[PathBuf], shown: &dyn Fn(&Path) -> String) -> Result<Vec<Text>, String> {
	let mut out = Vec::new();
	for file in files {
		let name = shown(file);
		let text = std::fs::read_to_string(file).map_err(|e| format!("{name}: {e}"))?;
		for (i, line) in text.lines().enumerate() {
			let Some(m) = LINE.captures(line) else { continue };
			let en = unescape_lua_text(&m[1], &name, i + 1)?;
			let tr = unescape_lua_text(&m[2], &name, i + 1)?;
			if !tr.trim_matches(js_space).is_empty() {
				out.push(Text { file: name.clone(), line: i + 1, en, tr });
			}
		}
	}
	Ok(out)
}

/// Every .lua file under `dir`, sorted.
pub fn lua_files(dir: &Path) -> Vec<PathBuf> {
	let mut out = Vec::new();
	let Ok(rd) = std::fs::read_dir(dir) else { return out };
	for e in rd.flatten() {
		let p = e.path();
		if p.is_dir() {
			out.extend(lua_files(&p));
		} else if p.extension().is_some_and(|x| x == "lua") {
			out.push(p);
		}
	}
	out.sort();
	out
}

fn stems(name: &str) -> Vec<String> {
	let lower = name.to_lowercase();
	let mut words: Vec<&str> = WORD_BREAKS.split(&lower).filter(|w| !w.is_empty()).collect();
	if words.len() > 1 && ARTICLES.contains(&words[0]) {
		words.remove(0);
	}
	words
		.into_iter()
		.map(|w| {
			let n = w.chars().count();
			if n > 4 {
				w.chars().take(4.max(n - 3)).collect()
			} else {
				w.to_string()
			}
		})
		.collect()
}

/// The client's name in the text, word by word. Hyphens and spaces of the text are left out first, so
/// "Heilig-Spezialisierung" carries "Heiligspezialisierung". A stem is not word-bounded: "Feuer" is
/// also in "Feuerball". That is the price of letting the endings change.
pub fn carries(tr: &str, name: &str) -> bool {
	let text: String = tr.to_lowercase().chars().filter(|c| !js_space(*c) && *c != '-').collect();
	stems(name).iter().all(|w| text.contains(w.as_str()))
}

/// The English names of one locale: name -> kind and the client's names. A name keeps only the client
/// names that differ from the English; one the client leaves in English somewhere (Ratchet) is none.
/// The talent trees (kind tree) are in `tree_index`.
pub fn name_index(names: &KindNames, english: &KindNames) -> BTreeMap<String, Entry> {
	struct Acc {
		kind: String,
		client: BTreeSet<String>,
		untranslated: bool,
	}
	let mut by: BTreeMap<String, Acc> = BTreeMap::new();
	for kind in ["spell", "area", "skill"] {
		let Some(list) = english.get(kind) else { continue };
		for (id, en) in list {
			let Some(tr) = names.get(kind).and_then(|m| m.get(id)) else { continue };
			if en.chars().count() < 2 {
				continue;
			}
			let e = by.entry(en.clone()).or_insert_with(|| Acc { kind: kind.to_string(), client: BTreeSet::new(), untranslated: false });
			if kind == "skill" {
				e.kind = "skill".to_string();
			}
			if tr == en {
				e.untranslated = true;
			} else {
				e.client.insert(tr.clone());
			}
		}
	}
	by.into_iter().filter(|(_, e)| !e.untranslated && !e.client.is_empty()).map(|(en, e)| (en, Entry { kind: e.kind, client: e.client.into_iter().collect() })).collect()
}

/// The talent trees by the first words of their English name, shorter than the whole: words -> the
/// client's names. A pet's skill line ("Pet - Wolf") is no tree.
pub fn tree_index(names: &KindNames, english: &KindNames) -> BTreeMap<String, Entry> {
	let mut out: BTreeMap<String, Entry> = BTreeMap::new();
	let Some(list) = english.get("tree") else { return out };
	for (id, en) in list {
		let Some(tr) = names.get("tree").and_then(|m| m.get(id)) else { continue };
		if tr == en || en.contains(" - ") {
			continue;
		}
		let words: Vec<&str> = en.split(js_space).filter(|w| !w.is_empty()).collect();
		for n in 1..words.len() {
			let e = out.entry(words[..n].join(" ")).or_insert_with(|| Entry { kind: "tree".to_string(), client: Vec::new() });
			if !e.client.contains(tr) {
				e.client.push(tr.clone());
			}
		}
	}
	out
}

/// `name` stands in `text` as whole words: no letter or apostrophe right before or after it.
fn whole_words(text: &str, name: &str) -> bool {
	text.match_indices(name).any(|(at, _)| {
		let before = text[..at].chars().next_back();
		let after = text[at + name.len()..].chars().next();
		let word = |c: char| c.is_alphabetic() || c == '\'';
		!before.is_some_and(word) && !after.is_some_and(word)
	})
}

/// The texts of one locale against its client names: each name the English text has that the
/// translation lacks.
pub fn audit_texts(texts: &[Text], index: &BTreeMap<String, Entry>, trees: &BTreeMap<String, Entry>) -> Vec<Finding> {
	// The names of several words by their first word; the one-word names by themselves.
	let mut multi: BTreeMap<&str, Vec<&str>> = BTreeMap::new();
	let mut single: BTreeMap<&str, &Entry> = BTreeMap::new();
	for (en, e) in index {
		if en.contains(js_space) {
			if en.chars().count() < MIN_LENGTH {
				continue;
			}
			let first = en.split(js_space).next().unwrap_or("");
			multi.entry(first).or_default().push(en);
		} else {
			single.insert(en, e);
		}
	}
	for list in multi.values_mut() {
		list.sort_by_key(|n| std::cmp::Reverse(n.chars().count()));
	}
	let mut rows = Vec::new();
	for t in texts {
		let plain = PLACEHOLDERS.replace_all(&t.en, " ").into_owned();
		let mut found: Vec<(String, &Entry)> = Vec::new();
		let trimmed = plain.trim_matches(js_space);
		let key = ROLE.replace(trimmed, "").into_owned();
		let whole = single.get(key.as_str()).copied();
		if let Some(w) = whole {
			found.push((key.clone(), w));
		}
		// A tree's short name, unless the client names a skill line so.
		if let Some(tree) = trees.get(&key) {
			if !whole.is_some_and(|w| w.kind == "skill") {
				found.push((key.clone(), tree));
			}
		}
		let mut rest = plain.clone();
		let firsts: BTreeSet<&str> = FIRST_WORDS.split(&plain).filter(|w| !w.is_empty()).collect();
		let mut cands: Vec<&str> = firsts.iter().filter_map(|f| multi.get(f)).flatten().copied().collect();
		cands.sort_by_key(|n| std::cmp::Reverse(n.chars().count()));
		for en in cands {
			if !rest.contains(en) || !whole_words(&rest, en) {
				continue;
			}
			found.push((en.to_string(), &index[en]));
			rest = rest.replace(en, " ");
		}
		for (en, e) in found {
			if e.client.iter().any(|c| carries(&t.tr, c)) {
				continue;
			}
			rows.push(Finding { kind: e.kind.clone(), en, client: e.client.clone(), file: t.file.clone(), line: t.line, text: t.en.clone(), tr: t.tr.clone() });
		}
	}
	rows
}

/// Findings -> the lines of their table: kind, English name, the client's name(s), file:line, the
/// English text cut at 60 characters.
pub fn format_table<'a>(rows: impl IntoIterator<Item = &'a Finding>) -> Vec<String> {
	let cut = |t: &str, n: usize| -> String {
		let chars: Vec<char> = t.chars().collect();
		if chars.len() > n {
			format!("{}…", chars[..n - 1].iter().collect::<String>())
		} else {
			t.to_string()
		}
	};
	let mut table: Vec<[String; 5]> = vec![["kind".into(), "English name".into(), "client name".into(), "file:line".into(), "English text".into()]];
	for r in rows {
		let text = r.text.split(js_space).filter(|w| !w.is_empty()).collect::<Vec<_>>().join(" ");
		table.push([r.kind.clone(), r.en.clone(), r.client.join(" | "), format!("{}:{}", r.file, r.line), cut(&text, 60)]);
	}
	let width: Vec<usize> = (0..5).map(|c| table.iter().map(|row| row[c].chars().count()).max().unwrap_or(0)).collect();
	table
		.iter()
		.map(|row| {
			let cells: Vec<String> = row.iter().enumerate().map(|(c, cell)| if c == 4 { cell.clone() } else { format!("{cell}{}", " ".repeat(width[c] - cell.chars().count())) }).collect();
			format!("  {}", cells.join("  "))
		})
		.collect()
}
