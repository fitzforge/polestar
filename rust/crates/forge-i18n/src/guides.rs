//! A guide pack's texts in other languages, the write side (port of tools/lib/i18n/guides.js
//! writeTextsFile, syncFiles and textStats; the read side is forge-guide's i18n_guides): one file per
//! guide and language, <pack>/locales/<locale>/<guide path>.lua, plus _pack.lua for the pack's own
//! texts. `i18n guides sync` writes the files whole, in reading order, keeping every translation; one
//! whose English the guide no longer has goes, commented out, to a block at the end.

use forge_guide::i18n_files::lua_string;
use forge_guide::i18n_guides::{guide_texts, pack_texts, unnamed_tokens, FileState, LocaleState, RETIRED};
use forge_guide::js::{cmp_utf16, Obj, V};
use forge_guide::tokens::replace_tokens;
use regex::Regex;
use std::collections::HashSet;
use std::sync::LazyLock;

/// `unnamed`: tokens no source names in the file's language (unnamed_tokens).
fn token_line(tokens: &[(String, String)], unnamed: &HashSet<String>) -> String {
	let parts: Vec<String> = tokens.iter().map(|(t, en)| format!("{{{t}}} {en}{}", if unnamed.contains(t) { " (no name in this language: may be words)" } else { "" })).collect();
	format!("\t-- {}", parts.join(" · "))
}

/// A texts file whole: header, every text in reading order (translated or ""), then the retired
/// block (`retired`: { english: translation }).
pub fn write_texts_file(s: &FileState, retired: &V) -> String {
	let lang = forge_guide::locales::locale(&s.locale).map_or(s.locale.as_str(), |l| l.language);
	let locale = &s.locale;
	let what = if s.kind == "pack" {
		"the pack's own texts (its title and notes, its guides' folders)".to_string()
	} else {
		format!("the guide {} ({})", s.id.as_deref().unwrap_or("undefined"), s.source.as_deref().unwrap_or("undefined"))
	};
	let mut lines = vec![
		format!("-- {lang} ({locale}): {what}."),
		format!("-- Written by `forge i18n guides sync {locale}`, which keeps every translation (docs/TRANSLATING.md, \"Guide texts\")."),
		"-- Translate the right-hand sides; \"\" shows the English. Keep each {kind:id} as it is: the game shows its".to_string(),
		format!("-- name there in {lang} (the English is listed above the line). A name the English has in the plural, as words,"),
		"-- may be written with the singular's token from its \"plural, as words\" line: \"Bandidos ({npc:251918})\", \"{npc:251918} ×8\".".to_string(),
		format!("-- A token marked \"no name in this language\" would show in English: write that name in {lang} words instead."),
		"-- The comments are rewritten by sync.".to_string(),
		"return {".to_string(),
	];
	static BREAKS: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"[\r\n]+").unwrap());
	let mut place: Option<&str> = None;
	for t in &s.texts {
		if place != Some(t.where_.as_str()) {
			if place.is_some() {
				lines.push(String::new());
			}
			lines.push(format!("\t-- {}", BREAKS.replace_all(&t.where_, " ")));
			place = Some(&t.where_);
		}
		if !t.tokens.is_empty() {
			let unnamed: HashSet<String> = if s.kind == "guide" { unnamed_tokens(&t.text, locale).into_iter().collect() } else { HashSet::new() };
			lines.push(token_line(&t.tokens, &unnamed));
		}
		if !t.plurals.is_empty() {
			let p: Vec<String> = t.plurals.iter().map(|(tok, en)| format!("{en}s = {{{tok}}} {en}")).collect();
			lines.push(format!("\t-- plural, as words: {}", p.join(" · ")));
		}
		let tr = s.translated.get(&t.text);
		let tr = if tr.truthy() { tr.to_js_string() } else { String::new() };
		lines.push(format!("\t[{}] = {},", lua_string(&t.text), lua_string(&tr)));
	}
	let mut old: Vec<_> = retired.keys().iter().map(|k| k.to_string()).collect();
	old.sort_by(|a, b| cmp_utf16(a, b));
	if !old.is_empty() {
		lines.push(String::new());
		lines.push(format!("\t{RETIRED}"));
		for k in &old {
			lines.push(format!("\t-- [{}] = {},", lua_string(k), lua_string(&retired.get(k).to_js_string())));
		}
	}
	lines.push("}".into());
	lines.push(String::new());
	lines.join("\n")
}

/// The files sync writes, (file, text): each file of `state` that reads (one Lua cannot load is left
/// alone), translations of texts gone moved to the retired block.
pub fn sync_files(state: &[(String, LocaleState)]) -> Vec<(String, String)> {
	let mut out: Vec<(String, String)> = Vec::new();
	for s in state.iter().flat_map(|(_, l)| &l.files) {
		if s.error.is_some() {
			continue;
		}
		let retired = Obj::new();
		for (k, v) in s.retired.entries().into_iter().chain(s.stale.entries()) {
			retired.set_str(k, v);
		}
		let text = write_texts_file(s, &V::Obj(retired));
		match out.iter_mut().find(|(f, _)| *f == s.file) {
			Some(e) => e.1 = text,
			None => out.push((s.file.clone(), text)),
		}
	}
	out
}

/// Counts of texts that need words: texts, words and characters (tokens left out); `guides` per folder.
#[derive(Clone, Copy, Default)]
pub struct Counts {
	pub guides: usize,
	pub texts: usize,
	pub words: usize,
	pub chars: usize,
}

/// The translation wave's size: the texts that need words, unique per language, with their words and
/// characters (tokens left out), in all and by guide folder (the .guide's directory, "(pack)" for the
/// pack's own). `guides`: the compiled guides with `_ast.source`.
pub fn text_stats(manifest: &V, guides: &[V]) -> (Counts, Vec<(String, Counts)>) {
	static LETTER: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\p{L}").unwrap());
	let mut total = Counts::default();
	let mut by_folder: Vec<(String, Counts)> = Vec::new();
	let mut seen: HashSet<String> = HashSet::new();
	fn folder<'a>(list: &'a mut Vec<(String, Counts)>, name: &str) -> &'a mut Counts {
		let i = match list.iter().position(|(f, _)| f == name) {
			Some(i) => i,
			None => {
				list.push((name.to_string(), Counts::default()));
				list.len() - 1
			}
		};
		&mut list[i].1
	}
	let count = |into: &mut Counts, text: &str| {
		let plain = replace_tokens(text, &mut |_, _| String::new());
		into.texts += 1;
		into.words += plain.split(char::is_whitespace).filter(|w| LETTER.is_match(w)).count();
		into.chars += plain.chars().count();
	};
	let mut add = |name: &str, text: &str, total: &mut Counts, by: &mut Vec<(String, Counts)>| {
		if !seen.insert(text.to_string()) {
			return;
		}
		count(total, text);
		count(folder(by, name), text);
	};
	for t in pack_texts(manifest, guides) {
		add("(pack)", &t.text, &mut total, &mut by_folder);
	}
	for g in guides {
		let source = g.hidden("_ast").get("source").to_js_string();
		let name = match source.rfind('/') {
			Some(i) => source[..i].to_string(),
			None => ".".to_string(),
		};
		folder(&mut by_folder, &name).guides += 1;
		for t in guide_texts(g) {
			add(&name, &t.text, &mut total, &mut by_folder);
		}
	}
	(total, by_folder)
}
