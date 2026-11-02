//! The backend's words in the player's language: the status, the problems and outcomes the window
//! shows, the tray and the notifications. They are written in US English in the code, through
//! [`t!`] and [`tn!`], and looked up in the same catalogs the window reads
//! (`src/locales/<locale>.json`, compiled in), so one file per language holds every translation.
//! A text a catalog leaves out (or as `""`) shows in English. What only goes to the log stays
//! English: it is written with `format!`, not `t!`.
//!
//! The window picks the language (Settings > Language, or the system's: `navigator.languages`)
//! and hands it over with the `set_language` command; until then the one it last chose
//! (`settings.json`'s `locale`) is used.

use std::collections::HashMap;
use std::fmt::Display;
use std::sync::{OnceLock, RwLock};

use serde_json::Value;

/// The languages besides English, by the game's locale codes, with their catalogs.
const CATALOGS: [(&str, &str); 9] = [
	("deDE", include_str!("../../src/locales/deDE.json")),
	("esES", include_str!("../../src/locales/esES.json")),
	("esMX", include_str!("../../src/locales/esMX.json")),
	("frFR", include_str!("../../src/locales/frFR.json")),
	("koKR", include_str!("../../src/locales/koKR.json")),
	("ptBR", include_str!("../../src/locales/ptBR.json")),
	("ruRU", include_str!("../../src/locales/ruRU.json")),
	("zhCN", include_str!("../../src/locales/zhCN.json")),
	("zhTW", include_str!("../../src/locales/zhTW.json")),
];

/// English: the texts as the code has them.
pub const ENGLISH: &str = "enUS";

static LOCALE: RwLock<&'static str> = RwLock::new(ENGLISH);
static PARSED: [OnceLock<Catalog>; 9] = [const { OnceLock::new() }; 9];

/// A catalog's translations: a text, or a plural's forms by CLDR category (`one`, `few`, `many`,
/// `other`). `""` is no translation.
type Catalog = HashMap<String, Value>;

/// `code` when it is one of the client's languages (`enUS` included), else English.
pub fn known(code: &str) -> &'static str {
	CATALOGS.iter().map(|(c, _)| *c).find(|c| *c == code).unwrap_or(ENGLISH)
}

pub fn set_locale(code: &str) {
	*LOCALE.write().unwrap_or_else(|e| e.into_inner()) = known(code);
}

pub fn locale() -> &'static str {
	*LOCALE.read().unwrap_or_else(|e| e.into_inner())
}

fn catalog(code: &str) -> Option<&'static Catalog> {
	let i = CATALOGS.iter().position(|(c, _)| *c == code)?;
	Some(PARSED[i].get_or_init(|| match serde_json::from_str::<Catalog>(CATALOGS[i].1) {
		Ok(catalog) => catalog,
		Err(e) => {
			eprintln!("The {code} translations could not be read, showing English: {e}");
			Catalog::new()
		}
	}))
}

fn lookup(code: &str, key: &str) -> Option<&'static str> {
	match catalog(code)?.get(key)? {
		Value::String(s) if !s.is_empty() => Some(s),
		_ => None,
	}
}

fn lookup_plural(code: &str, other: &str, category: &str) -> Option<&'static str> {
	let Value::Object(forms) = catalog(code)?.get(other)? else { return None };
	[category, "other"].iter().find_map(|c| forms.get(*c).and_then(Value::as_str).filter(|s| !s.is_empty()))
}

/// The CLDR plural category of a whole number `n` in `locale` (Intl.PluralRules in the window):
/// Russian has one, few and many; Chinese and Korean only other; French and Portuguese count 0 as
/// one.
pub fn category(locale: &str, n: u64) -> &'static str {
	match &locale[..2] {
		"ko" | "zh" => "other",
		"ru" => match (n % 10, n % 100) {
			(1, r) if r != 11 => "one",
			(2..=4, r) if !(12..=14).contains(&r) => "few",
			_ => "many",
		},
		"fr" | "pt" if n <= 1 => "one",
		"fr" | "pt" => "other",
		_ if n == 1 => "one",
		_ => "other",
	}
}

/// `template` with each `{name}` replaced by its argument; a `{…}` without one stays as it is.
pub fn fill(template: &str, args: &[(&str, &dyn Display)]) -> String {
	if args.is_empty() {
		return template.to_owned();
	}
	let mut out = String::with_capacity(template.len() + 16);
	let mut rest = template;
	while let Some(open) = rest.find('{') {
		out.push_str(&rest[..open]);
		let after = &rest[open + 1..];
		match after.find('}').and_then(|close| args.iter().find(|(name, _)| *name == &after[..close]).map(|(_, v)| (close, v))) {
			Some((close, value)) => {
				use std::fmt::Write;
				let _ = write!(out, "{value}");
				rest = &after[close + 1..];
			}
			None => {
				out.push('{');
				rest = after;
			}
		}
	}
	out.push_str(rest);
	out
}

/// [`t!`]: `key` (the English text) in the current language, its `{name}`s filled.
pub fn tr(key: &str, args: &[(&str, &dyn Display)]) -> String {
	fill(lookup(locale(), key).unwrap_or(key), args)
}

/// [`tn!`]: the form of `one`/`other` for `count` in the current language, with `{count}` and the
/// other `{name}`s filled. The catalog keys a plural by its English `other`.
pub fn trn(count: u64, one: &str, other: &str, args: &[(&str, &dyn Display)]) -> String {
	let text = match locale() {
		ENGLISH => None,
		code => lookup_plural(code, other, category(code, count)),
	};
	let text = text.unwrap_or(if count == 1 { one } else { other });
	let mut all: Vec<(&str, &dyn Display)> = Vec::with_capacity(args.len() + 1);
	all.push(("count", &count));
	all.extend_from_slice(args);
	fill(text, &all)
}

/// A text the player reads, in their language: `t!("Installed {name}.", name = product.name)`.
/// The first argument must be a string literal (the tests and `pnpm i18n` read the keys from the
/// code); the English is the key.
#[macro_export]
macro_rules! t {
	($key:literal $(, $name:ident = $value:expr)* $(,)?) => {
		$crate::i18n::tr($key, &[$((stringify!($name), &$value as &dyn ::std::fmt::Display)),*])
	};
}

/// A text with a count: `tn!("{count} file", "{count} files", n)`, more `name = value` after.
#[macro_export]
macro_rules! tn {
	($one:literal, $other:literal, $count:expr $(, $name:ident = $value:expr)* $(,)?) => {
		$crate::i18n::trn(($count) as u64, $one, $other, &[$((stringify!($name), &$value as &dyn ::std::fmt::Display)),*])
	};
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn fills_named_arguments() {
		assert_eq!(fill("Installed {name} {version}.", &[("name", &"Polestar"), ("version", &"1.2")]), "Installed Polestar 1.2.");
		assert_eq!(fill("{a} and {b} {", &[("a", &1)]), "1 and {b} {");
		assert_eq!(fill("no {args}", &[]), "no {args}");
	}

	#[test]
	fn plural_categories() {
		assert_eq!([1, 2, 5, 11, 21, 22, 25, 112, 122].map(|n| category("ruRU", n)), ["one", "few", "many", "many", "one", "few", "many", "many", "few"]);
		assert_eq!([0, 1, 2].map(|n| category("frFR", n)), ["one", "one", "other"]);
		assert_eq!([0, 1, 2].map(|n| category("deDE", n)), ["other", "one", "other"]);
		assert_eq!(category("zhCN", 1), "other");
	}

	#[test]
	fn every_catalog_parses_and_translates() {
		for (code, _) in CATALOGS {
			let catalog = catalog(code).unwrap();
			assert!(catalog.contains_key("@meta"), "{code} could not be read");
			assert!(lookup(code, "Pause uploads").is_some_and(|s| s != "Pause uploads"), "{code} has no tray translation");
		}
		// A plural by its English `other`, in the form for the number; English when a key is missing.
		let (few, many) = (lookup_plural("ruRU", "{count} accounts", "few").unwrap(), lookup_plural("ruRU", "{count} accounts", "many").unwrap());
		assert!(few.contains("{count}") && many.contains("{count}") && few != many);
		assert_eq!(lookup("deDE", "No such text in the code"), None);
	}
}
