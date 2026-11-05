//! The translators' glossary (port of tools/lib/i18n/glossary.js): about forty game and Polestar
//! terms, each with one chosen word per locale in data/i18n/glossary/<locale>.json, so a word reads
//! the same on every page. A value comes from the client's own strings first (the GlobalStrings tag is
//! kept in `client`), then from the reviewed translators' choices. `i18n check` warns (never fails)
//! when a translation of a key that holds a term has none of its locale's forms.
//!
//!   { "accept": { "term": "Annehmen", "match": ["annehm", "angenommen", "nimm"], "client": "ACCEPT" } }
//!
//! `match` (default [term]) are the forms that count, compared without case or accents, anywhere in
//! the translation (so "Ruhestein" counts in "Ruhesteins").

use forge_guide::js::parse_json;
use regex::Regex;
use std::path::Path;
use std::sync::LazyLock;
use unicode_normalization::UnicodeNormalization;

/// Term id -> its English forms, matched as whole words without case.
pub const TERMS: &[(&str, &[&str])] = &[
	("guide", &["guide", "guides"]),
	("step", &["step", "steps"]),
	("goal", &["goal", "goals"]),
	("objective", &["objective", "objectives"]),
	("accept", &["accept", "accepts", "accepted"]),
	("turn in", &["turn in", "turn-in", "turn-ins", "turned in", "hand in", "handed in"]),
	("complete", &["complete", "completes", "completed"]),
	("skip", &["skip", "skips", "skipped"]),
	("quest", &["quest", "quests"]),
	("quest log", &["quest log"]),
	("quest giver", &["quest giver", "quest givers"]),
	("NPC", &["NPC", "NPCs"]),
	("hearthstone", &["hearthstone"]),
	("flight master", &["flight master", "flight masters"]),
	("flight path", &["flight path", "flight paths"]),
	("innkeeper", &["innkeeper", "innkeepers"]),
	("inn", &["inn", "inns"]),
	("class trainer", &["class trainer", "class trainers"]),
	("trainer", &["trainer", "trainers"]),
	("vendor", &["vendor", "vendors", "merchant", "merchants"]),
	("arrow", &["arrow"]),
	("waypoint", &["waypoint", "waypoints"]),
	("route", &["route", "routes"]),
	("dungeon", &["dungeon", "dungeons"]),
	("raid", &["raid", "raids"]),
	("rare", &["rare", "rares"]),
	("treasure", &["treasure", "treasures"]),
	("elite", &["elite"]),
	("group", &["group", "groups"]),
	("reputation", &["reputation", "reputations"]),
	("profession", &["profession", "professions"]),
	("talent", &["talent", "talents"]),
	("reward", &["reward", "rewards"]),
	("item", &["item", "items"]),
	("mount", &["mount", "mounts"]),
	("zone", &["zone", "zones"]),
	("minimap", &["minimap"]),
	("world map", &["world map"]),
	("level", &["level", "levels"]),
	("boat", &["boat", "boats"]),
];

/// A term's forms in a locale.
#[derive(Debug)]
pub struct Entry {
	pub id: String,
	pub term: String,
	/// The forms that count, folded.
	pub matches: Vec<String>,
	pub client: Option<String>,
}

/// Without case or accents: NFD, combining marks U+0300-U+036F dropped, lower case.
pub fn fold(s: &str) -> String {
	s.nfd().filter(|c| !('\u{300}'..='\u{36f}').contains(c)).collect::<String>().to_lowercase()
}

fn word_char(b: Option<&u8>) -> bool {
	b.is_some_and(|c| c.is_ascii_alphabetic() || *c == b'_')
}

/// Whether `text` holds one of `forms` as a whole word (no Latin letter or _ on either side), case
/// aside.
fn holds(text: &str, forms: &[&str]) -> bool {
	let b = text.as_bytes();
	(0..b.len()).any(|i| {
		(i == 0 || !word_char(b.get(i - 1)))
			&& forms.iter().any(|f| {
				let f = f.as_bytes();
				b.len() >= i + f.len() && b[i..i + f.len()].eq_ignore_ascii_case(f) && !word_char(b.get(i + f.len()))
			})
	})
}

/// The glossary of `locale` in `dir`, or None when the locale has none. Err: a term id TERMS lacks,
/// an entry without a term, or a file that is not JSON.
pub fn read_glossary(locale: &str, dir: &Path) -> Result<Option<Vec<Entry>>, String> {
	let file = dir.join(format!("{locale}.json"));
	let Ok(text) = std::fs::read_to_string(&file) else { return Ok(None) };
	let shown = file.to_string_lossy();
	let raw = parse_json(&text).map_err(|e| format!("{shown}: {e}"))?;
	let mut out = Vec::new();
	for (id, e) in raw.entries() {
		if !TERMS.iter().any(|(t, _)| *t == &*id) {
			return Err(format!("{shown}: \"{id}\" is not a glossary term (TERMS in rust/crates/forge-i18n/src/glossary.rs)"));
		}
		let term = e.get("term");
		let Some(term) = term.as_str().filter(|t| !t.is_empty()) else { return Err(format!("{shown}: \"{id}\" needs a \"term\"")) };
		let m = e.get("match");
		let forms: Vec<String> = if m.is_arr() && !m.is_empty() { m.items().iter().map(|x| x.to_js_string()).collect() } else { vec![term.to_string()] };
		let client = e.get("client");
		out.push(Entry { id: id.to_string(), term: term.to_string(), matches: forms.iter().map(|f| fold(f)).collect(), client: client.truthy().then(|| client.to_js_string()) });
	}
	Ok(Some(out))
}

/// One glossary warning: a translation of a key holding term `id` without its locale's `term`.
pub struct Warning {
	pub key: String,
	pub value: String,
	pub id: String,
	pub term: String,
}

/// Each translation whose English holds a term (outside a slash command such as "/pole mount") and
/// which has none of that term's forms.
pub fn glossary_warnings(glossary: Option<&[Entry]>, translated: &[(String, String)]) -> Vec<Warning> {
	static SLASH: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"/[A-Za-z0-9_]+ [A-Za-z0-9_]+").unwrap());
	let Some(glossary) = glossary else { return Vec::new() };
	let mut out = Vec::new();
	for (key, value) in translated {
		let english = SLASH.replace_all(key, "");
		let v = fold(value);
		for g in glossary {
			let forms = TERMS.iter().find(|(t, _)| *t == g.id).map_or(&[][..], |(_, f)| *f);
			if holds(&english, forms) && !g.matches.iter().any(|m| v.contains(m.as_str())) {
				out.push(Warning { key: key.clone(), value: value.clone(), id: g.id.clone(), term: g.term.clone() });
			}
		}
	}
	out
}
