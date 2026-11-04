//! Port of tools/lib/i18n/guides.js (the read side: what pack_translations needs).
//!
//! A guide pack's texts in other languages (docs/TRANSLATING.md, "Guide
//! texts"): one file per guide and language, <pack>/locales/<locale>/<guide
//! path>.lua, plus <pack>/locales/<locale>/_pack.lua for the pack's own texts
//! (its title and notes, its guides' folders). Each file returns a table that
//! maps the English, with its name tokens (tokens.rs), to the translation:
//!
//!   return {
//!   	-- Step 1: Sentinel Hill
//!   	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin
//!   	["{npc:234} and {npc:821} stand at the top of the stone tower."] = "",
//!   }
//!
//! "" is not translated yet: the English shows. The compiler (project.rs
//! build_pack_files) puts each language's translations into the pack's texts
//! addon for it, <folder>_<locale>. Adapted from Ding! by Yendi (@moust4ki),
//! GPL-3.0: https://github.com/moust4ki/DingGuideWoWForever
//!
//! The write side (`forge i18n guides sync`/stats) is forge-i18n's guides.rs.

#[cfg(feature = "native")]
use crate::js::json_quote;
use crate::js::{cmp_utf16, Obj, V};
use crate::tokens::{fill_tokens, for_each_text, only_tokens, tokens_of, KINDS};
use regex::Regex;
use std::collections::HashSet;
use std::sync::LazyLock;

pub const PACK_FILE: &str = "_pack.lua";
pub const RETIRED: &str = "-- No longer in the guide (its English changed or it went away): reuse or delete.";

static TOKEN_RE: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\{(npc|object|item|quest|zone|area|spell|faction|skill):([0-9]+)\}").unwrap());

/// One text that needs words: { text, where, tokens: [[token, English]],
/// plurals: [[token, English]] (names the text has in the English plural,
/// left as words) }.
#[derive(Clone)]
pub struct Text {
	pub text: String,
	pub where_: String,
	pub tokens: Vec<(String, String)>,
	pub plurals: Vec<(String, String)>,
}

/// A compiled guide's texts that need words, each once, in reading order.
/// `guide` is the compiled guide; its hidden `_localised` copy (project.rs)
/// holds the tokens, and that copy's hidden `_plurals` ({ text: [{ kind, id, name }] }).
pub fn guide_texts(guide: &V) -> Vec<Text> {
	let localised = guide.hidden("_localised");
	let g = if localised.truthy() { localised } else { guide.clone() };
	let names = g.get("names");
	let plurals_of = g.hidden("_plurals");
	let steps = g.get("steps");
	let mut out: Vec<Text> = Vec::new();
	let mut seen: HashSet<String> = HashSet::new();
	for_each_text(&g, true, &mut |text, _holder, _key, _level, si| {
		if seen.contains(text) || only_tokens(text) {
			return;
		}
		seen.insert(text.to_string());
		let where_ = match si {
			None => "Guide".to_string(),
			Some(si) => {
				let title = steps.at(si).get("title");
				if title.truthy() {
					format!("Step {}: {}", si + 1, fill_tokens(&title.to_js_string(), &names))
				} else {
					format!("Step {}", si + 1)
				}
			}
		};
		let mut tokens: Vec<(String, String)> = Vec::new();
		for t in tokens_of(text) {
			if tokens.iter().any(|x| x.0 == t) {
				continue;
			}
			let en = if names.truthy() { names.get(&t) } else { V::Undef };
			let en = if en.truthy() { en.to_js_string() } else { "?".to_string() };
			tokens.push((t, en));
		}
		let mut plurals: Vec<(String, String)> = Vec::new();
		if plurals_of.truthy() {
			for p in plurals_of.get(text).items() {
				let tok = format!("{}:{}", p.get("kind").to_js_string(), p.get("id").to_js_string());
				if !plurals.iter().any(|x| x.0 == tok) {
					plurals.push((tok, p.get("name").to_js_string()));
				}
			}
		}
		out.push(Text { text: text.to_string(), where_, tokens, plurals });
	});
	out
}

/// The classes of the game: LOCALIZED_CLASS_NAMES_MALE names them on every client.
const CLASSES: [&str; 9] = ["Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Shaman", "Mage", "Warlock", "Druid"];

/// The pack's own texts: its title and notes, then its guides' folders.
pub fn pack_texts(manifest: &V, guides: &[V]) -> Vec<Text> {
	let mut out: Vec<Text> = Vec::new();
	let mut seen: HashSet<String> = HashSet::new();
	let mut add = |text: &V, where_: &str| {
		let Some(text) = text.as_str() else { return };
		if text.trim_matches(crate::emit::is_js_space).is_empty() || seen.contains(text) {
			return;
		}
		seen.insert(text.to_string());
		out.push(Text { text: text.to_string(), where_: where_.to_string(), tokens: Vec::new(), plurals: Vec::new() });
	};
	add(&manifest.get("title"), "Pack");
	add(&manifest.get("notes"), "Pack");
	// A folder named after a class shows the client's class name (Core/GuideTexts.lua).
	let mut folders: Vec<V> = Vec::new();
	for g in guides {
		let f = g.get("folder");
		if f.truthy() && !folders.iter().any(|x| x.strict_eq(&f)) {
			folders.push(f);
		}
	}
	folders.sort_by(|a, b| cmp_utf16(&a.to_js_string(), &b.to_js_string()));
	for f in &folders {
		if !f.as_str().is_some_and(|s| CLASSES.contains(&s)) {
			add(f, "Folders");
		}
	}
	out
}

/// What is wrong with `translation` as the translation of `english`: [message].
/// `plurals`: tokens the English names in the plural, as words (its
/// "plural, as words" comment): the translation may use them as it likes.
/// `unnamed`: tokens it may leave out, written as words (unnamed_tokens).
pub fn text_problems(english: &str, translation: &str, plurals: &[String], unnamed: &[String]) -> Vec<String> {
	let mut out = Vec::new();
	let mut want = tokens_of(english);
	want.sort_by(|a, b| cmp_utf16(a, b));
	let mut got: Vec<String> = tokens_of(translation).into_iter().filter(|t| !plurals.contains(t) || want.contains(t)).collect();
	got.sort_by(|a, b| cmp_utf16(a, b));
	let count = |list: &[String], t: &str| list.iter().filter(|x| *x == t).count();
	let first = |list: &[String], i: usize| list.iter().position(|x| *x == list[i]) == Some(i);
	let missing: Vec<&String> = (0..want.len()).filter(|&i| first(&want, i) && !unnamed.contains(&want[i]) && count(&got, &want[i]) < count(&want, &want[i])).map(|i| &want[i]).collect();
	let extra: Vec<&String> = (0..got.len()).filter(|&i| first(&got, i) && count(&want, &got[i]) < count(&got, &got[i])).map(|i| &got[i]).collect();
	if !missing.is_empty() {
		out.push(format!("leaves out {}", missing.iter().map(|t| format!("{{{t}}}")).collect::<Vec<_>>().join(", ")));
	}
	if !extra.is_empty() {
		// Both branches of the JS ternary read the same.
		out.push(format!("has {}, which the English has fewer times or not at all", extra.iter().map(|t| format!("{{{t}}}")).collect::<Vec<_>>().join(", ")));
	}
	let stray = TOKEN_RE.replace_all(translation, "");
	if stray.contains(['{', '}']) {
		out.push(format!("has a {{ or }} outside a name token ({{kind:id}}, kind one of {})", KINDS.join(" ")));
	}
	if english.matches('\n').count() != translation.matches('\n').count() {
		out.push("has a different number of line breaks (\\n) than the English".into());
	}
	out
}

/// The commented translations a file's retired block holds: { english: translation }.
pub fn retired_entries(text: &str) -> V {
	static RE: LazyLock<Regex> = LazyLock::new(|| Regex::new(r#"(?m)^\s*-- \[("(?:[^"\\]|\\.)*")\] = ("(?:[^"\\]|\\.)*"),\s*$"#).unwrap());
	static DEC: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\\([0-9]{1,3})").unwrap());
	let out = Obj::new();
	let Some(at) = text.find(RETIRED) else { return V::Obj(out) };
	let unq = |s: &str| -> Result<V, String> {
		let s = DEC.replace_all(s, |c: &regex::Captures| format!("\\u{:04x}", c[1].parse::<u32>().unwrap()));
		let s = s.replace("\\'", "'");
		crate::js::parse_json(&s)
	};
	let mut pos = at;
	while let Some(m) = RE.captures_at(text, pos) {
		let whole = m.get(0).unwrap();
		pos = if whole.end() > whole.start() { whole.end() } else { whole.end() + 1 };
		// A line edited by hand that no longer parses: left out.
		let Ok(v) = unq(&m[2]) else { continue };
		let Ok(k) = unq(&m[1]) else { continue };
		if v.as_str() != Some("") {
			out.set(&k.to_js_string(), v);
		}
		if pos > text.len() {
			break;
		}
	}
	V::Obj(out)
}

#[cfg(feature = "native")]
/// Words of the closest current text with the same tokens, for a stale entry:
/// the likely new English of a changed text, or None.
fn successor(stale: &str, texts: &[Text], taken: &HashSet<String>) -> Option<String> {
	static SPLIT: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"[^\p{L}\p{N}']+").unwrap());
	let words = |s: &str| -> HashSet<String> {
		let plain = TOKEN_RE.replace_all(s, " ").to_lowercase();
		SPLIT.split(&plain).filter(|w| !w.is_empty()).map(String::from).collect()
	};
	let sorted_tokens = |s: &str| {
		let mut t = tokens_of(s);
		t.sort_by(|a, b| cmp_utf16(a, b));
		t.join(" ")
	};
	let a = words(stale);
	let tok = sorted_tokens(stale);
	let mut best = None;
	let mut score = 0.5;
	for t in texts {
		if taken.contains(&t.text) || sorted_tokens(&t.text) != tok {
			continue;
		}
		let b = words(&t.text);
		let both = a.iter().filter(|w| b.contains(*w)).count();
		let denom = a.len() + b.len() - both;
		let s = both as f64 / (if denom == 0 { 1 } else { denom }) as f64;
		if s > score {
			score = s;
			best = Some(t.text.clone());
		}
	}
	best
}

// ------------------------------------------------------------ files (native)

/// `path.join` of POSIX-style parts, normalised.
#[cfg(feature = "native")]
fn join(parts: &[&str]) -> String {
	let joined = parts.iter().filter(|p| !p.is_empty()).copied().collect::<Vec<_>>().join("/");
	if joined.is_empty() {
		return ".".into();
	}
	let abs = joined.starts_with('/');
	let mut out: Vec<&str> = Vec::new();
	for seg in joined.split('/') {
		match seg {
			"" | "." => {}
			".." => {
				if out.last().is_some_and(|l| *l != "..") {
					out.pop();
				} else if !abs {
					out.push("..");
				}
			}
			s => out.push(s),
		}
	}
	let body = out.join("/");
	let trailing = joined.ends_with('/') && !body.is_empty();
	let s = if abs {
		format!("/{body}")
	} else if body.is_empty() {
		".".into()
	} else {
		body
	};
	if trailing {
		format!("{s}/")
	} else {
		s
	}
}

#[cfg(feature = "native")]
pub fn locale_dir(pack_dir: &str, locale: &str) -> String {
	join(&[pack_dir, "locales", locale])
}

#[cfg(feature = "native")]
pub fn guide_file(pack_dir: &str, locale: &str, source: &str) -> String {
	let lua = match source.strip_suffix(".guide") {
		Some(s) => format!("{s}.lua"),
		None => source.to_string(),
	};
	join(&[&locale_dir(pack_dir, locale), &lua])
}

/// `path.relative(process.cwd(), file)`, with / separators, unless it leaves the working directory.
#[cfg(feature = "native")]
fn rel(file: &str) -> String {
	let cwd = std::env::current_dir().unwrap_or_default().to_string_lossy().into_owned();
	let abs = if file.starts_with('/') { join(&[file]) } else { join(&[&cwd, file]) };
	let base = join(&[&cwd]);
	let r = if abs == base {
		String::new()
	} else if let Some(r) = abs.strip_prefix(&format!("{}/", base.trim_end_matches('/'))) {
		r.to_string()
	} else {
		// Outside the working directory: path.relative starts with "..".
		return file.to_string();
	};
	r
}

/// Every .lua under dir, relative and with / separators.
#[cfg(feature = "native")]
fn lua_files(dir: &str, prefix: &str) -> Vec<String> {
	let Ok(rd) = std::fs::read_dir(dir) else { return Vec::new() };
	let mut out = Vec::new();
	for e in rd.flatten() {
		let name = e.file_name().to_string_lossy().into_owned();
		let r = if prefix.is_empty() { name.clone() } else { format!("{prefix}/{name}") };
		let Ok(ft) = e.file_type() else { continue };
		if ft.is_dir() {
			out.extend(lua_files(&join(&[dir, &name]), &r));
		} else if ft.is_file() && name.ends_with(".lua") {
			out.push(r);
		}
	}
	out.sort_by(|a, b| cmp_utf16(a, b));
	out
}

/// The languages the pack has a folder for under locales/, known ones only.
#[cfg(feature = "native")]
pub fn pack_locales(pack_dir: &str) -> Vec<String> {
	let Ok(rd) = std::fs::read_dir(join(&[pack_dir, "locales"])) else { return Vec::new() };
	let mut out: Vec<String> =
		rd.flatten().filter(|d| d.file_type().is_ok_and(|t| t.is_dir())).map(|d| d.file_name().to_string_lossy().into_owned()).filter(|n| crate::locales::locale(n).is_some()).collect();
	out.sort_by(|a, b| cmp_utf16(a, b));
	out
}

/// The object ids Polestar's names addon of `locale`
/// (addon/Polestar_<locale>/Names.lua, `forge data names`) names, or None
/// when it has none, cached. The addon folder is the repository's (as the
/// JS finds it from its own file), located from this crate's source path.
#[cfg(feature = "native")]
fn named_objects(locale: &str) -> Option<std::rc::Rc<HashSet<String>>> {
	use std::cell::RefCell;
	use std::collections::HashMap;
	use std::rc::Rc;
	thread_local! {
		static NAMED: RefCell<HashMap<String, Option<Rc<HashSet<String>>>>> = RefCell::new(HashMap::new());
	}
	// R("object", lo, hi, [[ then one "<id>\t<name>" line per name, up to the chunk's ]].
	static ADD: LazyLock<Regex> = LazyLock::new(|| Regex::new(r#"(?s)R\("object", [0-9-]+, [0-9-]+, \[(=*)\[(.*?)\n\]"#).unwrap());
	static ID: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"\n([0-9]+)\t").unwrap());
	if let Some(hit) = NAMED.with(|n| n.borrow().get(locale).cloned()) {
		return hit;
	}
	let root = concat!(env!("CARGO_MANIFEST_DIR"), "/../../../addon");
	let file = join(&[root, &crate::toc::language_addon(locale), "Names.lua"]);
	let ids = std::fs::read_to_string(&file).ok().map(|text| {
		let mut ids = HashSet::new();
		for m in ADD.captures_iter(&text) {
			for e in ID.captures_iter(&m[2]) {
				ids.insert(format!("object:{}", &e[1]));
			}
		}
		Rc::new(ids)
	});
	NAMED.with(|n| n.borrow_mut().insert(locale.to_string(), ids.clone()));
	ids
}

/// The tokens of `english` a translation into `locale` may write as words: the
/// objects no source names in that language (a district's sign, a tavern),
/// which the game would show in English.
#[cfg(feature = "native")]
pub fn unnamed_tokens(english: &str, locale: &str) -> Vec<String> {
	let Some(named) = named_objects(locale) else { return Vec::new() };
	let mut out: Vec<String> = Vec::new();
	for t in tokens_of(english) {
		if !out.contains(&t) && t.starts_with("object:") && !named.contains(&t) {
			out.push(t);
		}
	}
	out
}

/// One texts file's state (guide_state).
pub struct FileState {
	pub locale: String,
	/// "guide" | "pack".
	pub kind: &'static str,
	pub id: Option<String>,
	pub source: Option<String>,
	pub file: String,
	pub texts: Vec<Text>,
	pub exists: bool,
	pub error: Option<String>,
	/// { english: translation }, in the file's order.
	pub translated: V,
	pub missing: Vec<String>,
	/// { english: translation } of texts the guide no longer has.
	pub stale: V,
	pub retired: V,
	/// (text, problem).
	pub problems: Vec<(String, String)>,
	/// { stale English: new English }.
	pub successors: V,
}

pub struct LocaleState {
	pub files: Vec<FileState>,
	pub orphans: Vec<String>,
}

/// guides: the pack's compiled guides with `_ast.source`. -> per locale (in
/// `locales` order) its files and orphan files.
#[cfg(feature = "native")]
pub fn guide_state(pack_dir: &str, manifest: &V, guides: &[V], locales: &[String]) -> Result<Vec<(String, LocaleState)>, String> {
	let mut planned: Vec<FileState> = Vec::new();
	let blank = |locale: &str, kind: &'static str, id: Option<String>, source: Option<String>, file: String, texts: Vec<Text>| FileState {
		locale: locale.to_string(),
		kind,
		id,
		source,
		file,
		texts,
		exists: false,
		error: None,
		translated: V::obj(),
		missing: Vec::new(),
		stale: V::obj(),
		retired: V::obj(),
		problems: Vec::new(),
		successors: V::obj(),
	};
	for locale in locales {
		planned.push(blank(locale, "pack", None, None, join(&[&locale_dir(pack_dir, locale), PACK_FILE]), pack_texts(manifest, guides)));
		for g in guides {
			let source = g.hidden("_ast").get("source").to_js_string();
			planned.push(blank(locale, "guide", Some(g.get("id").to_js_string()), Some(source.clone()), guide_file(pack_dir, locale, &source), guide_texts(g)));
		}
	}
	let existing: Vec<(String, String)> = planned.iter().filter(|p| std::path::Path::new(&p.file).exists()).map(|p| (p.file.clone(), p.locale.clone())).collect();
	let read = crate::i18n_files::read_locale_files(&existing)?;
	let mut out: Vec<(String, LocaleState)> = locales.iter().map(|l| (l.clone(), LocaleState { files: Vec::new(), orphans: Vec::new() })).collect();
	for mut s in planned {
		// Map file -> read: the last read of a file wins, as `new Map(...)` keeps it.
		let r = read.iter().rev().find(|r| r.file == s.file);
		s.exists = r.is_some();
		match r {
			Some(r) if !r.ok => s.error = r.error.clone(),
			Some(r) if r.layout.as_deref() != Some("return") => s.error = Some("does not return a table of { [\"English\"] = \"translation\" }".into()),
			Some(r) => {
				let known: HashSet<&str> = s.texts.iter().map(|t| t.text.as_str()).collect();
				for k in &r.bad {
					s.problems.push((k.clone(), "the key or the value is not a string".into()));
				}
				for (k, v) in r.strings.entries() {
					let v = v.to_js_string();
					if !known.contains(&*k) {
						if !v.is_empty() {
							s.stale.set(&k, v);
						}
						continue;
					}
					if v.is_empty() {
						continue;
					}
					s.translated.set(&k, v.clone());
					let plurals: Vec<String> = s.texts.iter().rev().find(|t| t.text == *k).map(|t| t.plurals.iter().map(|p| p.0.clone()).collect()).unwrap_or_default();
					let unnamed = if s.kind == "guide" { unnamed_tokens(&k, &s.locale) } else { Vec::new() };
					for problem in text_problems(&k, &v, &plurals, &unnamed) {
						s.problems.push((k.to_string(), problem));
					}
				}
				s.retired = retired_entries(&std::fs::read_to_string(&s.file).map_err(|e| e.to_string())?);
				let taken: HashSet<String> = s.translated.keys().iter().map(|k| k.to_string()).collect();
				for k in s.stale.keys() {
					if let Some(next) = successor(&k, &s.texts, &taken) {
						s.successors.set(&k, next);
					}
				}
			}
			None => {}
		}
		for t in &s.texts {
			if !s.translated.has(&t.text) {
				s.missing.push(t.text.clone());
			}
		}
		let at = out.iter().position(|(l, _)| *l == s.locale).unwrap();
		out[at].1.files.push(s);
	}
	for (locale, st) in &mut out {
		let dir = locale_dir(pack_dir, locale);
		let want: HashSet<String> = st.files.iter().map(|f| f.file.strip_prefix(&format!("{dir}/")).unwrap_or(&f.file).to_string()).collect();
		st.orphans = lua_files(&dir, "").into_iter().filter(|f| !want.contains(f)).map(|f| join(&[&dir, &f])).collect();
	}
	Ok(out)
}

#[cfg(feature = "native")]
fn json_str(s: &str) -> String {
	let mut out = String::new();
	json_quote(&mut out, s);
	out
}

/// Translations for the compiler: -> { translations: { [locale]: { pack: {},
/// guides: { [id]: {} } } }, warnings: [{ file, message }] } with only
/// well-formed translations of texts the pack has, and a warning for every
/// problem, stale entry and orphan file. Err: Lua could not run (the JS throws).
#[cfg(feature = "native")]
pub fn pack_translations(pack_dir: &std::path::Path, manifest: &V, guides: &[V]) -> Result<V, String> {
	let pack_dir = &pack_dir.to_string_lossy().into_owned();
	let locales = pack_locales(pack_dir);
	if locales.is_empty() {
		return Ok(V::Obj(crate::obj! { "translations" => V::obj(), "warnings" => V::arr() }));
	}
	let with_source: Vec<V> = guides
		.iter()
		.filter(|g| {
			let ast = g.hidden("_ast");
			ast.truthy() && ast.get("source").truthy()
		})
		.cloned()
		.collect();
	let state = guide_state(pack_dir, manifest, &with_source, &locales)?;
	let translations = Obj::new();
	let mut warnings: Vec<(String, String)> = Vec::new();
	for (locale, st) in &state {
		let pack = Obj::new();
		let guides_out = Obj::new();
		for s in &st.files {
			let file = rel(&s.file);
			if let Some(e) = &s.error {
				warnings.push((file.clone(), format!("not read: {e}")));
			}
			let bad: HashSet<&str> = s.problems.iter().map(|p| p.0.as_str()).collect();
			for (text, problem) in &s.problems {
				warnings.push((file.clone(), format!("{}: the translation {problem}; it is left out, the English shows", json_str(text))));
			}
			for k in s.stale.keys() {
				let next = s.successors.get(&k);
				let why = match next.as_str() {
					Some(n) => format!("its English changed to {}", json_str(n)),
					None => "the guide no longer has that text".to_string(),
				};
				warnings.push((file.clone(), format!("stale translation of {}: {why}; `forge i18n guides sync {locale}` moves it to the end", json_str(&k))));
			}
			let ok = Obj::new();
			for (k, v) in s.translated.entries() {
				if !bad.contains(&*k) {
					ok.set_str(k, v);
				}
			}
			if ok.is_empty() {
				continue;
			}
			if s.kind == "pack" {
				// into.pack = ok
				for (k, v) in ok.entries() {
					pack.set_str(k, v);
				}
			} else {
				guides_out.set(s.id.as_deref().unwrap_or("undefined"), ok);
			}
		}
		for f in &st.orphans {
			warnings.push((rel(f), "no guide of the pack has this path (renamed or removed?)".into()));
		}
		if !pack.is_empty() || !guides_out.is_empty() {
			translations.set(locale, crate::obj! { "pack" => pack, "guides" => guides_out });
		}
	}
	let warnings: Vec<V> = warnings.into_iter().map(|(file, message)| V::Obj(crate::obj! { "file" => file, "message" => message })).collect();
	Ok(V::Obj(crate::obj! { "translations" => V::Obj(translations), "warnings" => V::from(warnings) }))
}
