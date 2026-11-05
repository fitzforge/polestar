//! Small JS idioms shared by the Codex modules (tools/lib/codex/*.js).

use std::cmp::Ordering;
use std::sync::LazyLock;

use forge_guide::js::{cmp_utf16, is_index_key, num_str, str_to_num, Arr, Obj, V};
use regex::Regex;

pub use forge_core::jsnum::{js_hypot as hypot, js_round as math_round};

/// build.js `int(v)`: null for null / undefined / '', else `Number(v)` when finite.
pub fn int(v: &V) -> Option<f64> {
	match v {
		V::Undef | V::Null => None,
		V::Str(s) if s.is_empty() => None,
		_ => {
			let n = v.num();
			n.is_finite().then_some(n)
		}
	}
}

/// `int(row.col)` of a client-table row.
pub fn int_s(s: Option<&String>) -> Option<f64> {
	let s = s?;
	if s.is_empty() {
		return None;
	}
	let n = str_to_num(s);
	n.is_finite().then_some(n)
}

/// `int(x) || null` (0 and NaN to None).
pub fn nz(n: Option<f64>) -> Option<f64> {
	n.filter(|x| *x != 0.0)
}

/// instances.js / journal.js `num(v)`: `Number(v)`, 0 when not finite.
pub fn num0(v: &V) -> f64 {
	let n = v.num();
	if n.is_finite() {
		n
	} else {
		0.0
	}
}

/// `num0` of a client-table column.
pub fn num0_s(s: Option<&String>) -> f64 {
	let n = s.map(|s| str_to_num(s)).unwrap_or(f64::NAN);
	if n.is_finite() {
		n
	} else {
		0.0
	}
}

pub fn round1(v: f64) -> f64 {
	math_round(v * 10.0) / 10.0
}

pub fn opt(n: Option<f64>) -> V {
	n.map(V::Num).unwrap_or(V::Null)
}

pub fn nums(v: &[f64]) -> V {
	V::Arr(Arr::from_vec(v.iter().map(|&x| V::Num(x)).collect()))
}

pub fn arr(v: Vec<V>) -> V {
	V::Arr(Arr::from_vec(v))
}

pub fn key(n: f64) -> String {
	num_str(n)
}

/// `(a, b) => a - b` as an Ordering (NaN as equal).
pub fn by_num(a: f64, b: f64) -> Ordering {
	(a - b).partial_cmp(&0.0).unwrap_or(Ordering::Equal)
}

/// A JS comparator result (a number) as an Ordering.
pub fn ord(d: f64) -> Ordering {
	if d < 0.0 {
		Ordering::Less
	} else if d > 0.0 {
		Ordering::Greater
	} else {
		Ordering::Equal
	}
}

/// `x ?? -1` for a number-or-null value.
pub fn or_m1(v: &V) -> f64 {
	if v.is_nullish() {
		-1.0
	} else {
		v.num()
	}
}

/// `s.normalize('NFKD').replace(/[\u0300-\u036f]/g, '')`.
pub fn strip_accents(s: &str) -> String {
	if s.is_ascii() {
		return s.to_string();
	}
	use unicode_normalization::UnicodeNormalization;
	s.nfkd().filter(|c| !('\u{300}'..='\u{36f}').contains(c)).collect()
}

static NON_ALNUM_RUN: LazyLock<Regex> = LazyLock::new(|| Regex::new("[^a-z0-9]+").unwrap());

/// build.js / instances.js `slug(s)`.
pub fn slug(s: &str) -> String {
	let s = strip_accents(s).to_lowercase().replace(['\'', '\u{2019}'], "");
	let s = NON_ALNUM_RUN.replace_all(&s, "-");
	s.trim_matches('-').to_string()
}

/// build.js `normName(s)`.
pub fn norm_name(s: &str) -> String {
	let s = slug(s);
	let s = s.strip_prefix("the-").unwrap_or(&s);
	s.replace('-', "")
}

/// `.replace(/^the\s+/, '')` then `.replace(/[^a-z0-9]/g, '')` of a lower-cased string.
fn strip_the_alnum(s: &str) -> String {
	let rest = match s.strip_prefix("the") {
		Some(r) if r.starts_with(|c: char| is_js_space(c)) => r.trim_start_matches(is_js_space),
		_ => s,
	};
	rest.chars().filter(|c| c.is_ascii_lowercase() || c.is_ascii_digit()).collect()
}

/// instances.js / parity.js `norm(s)` (NFKD, accents dropped).
pub fn norm(v: &V) -> String {
	let s = if v.truthy() { v.to_js_string() } else { String::new() };
	strip_the_alnum(&js_lower(&strip_accents(&s)))
}

/// instances.js `norm` of a string.
pub fn norm_s(s: &str) -> String {
	strip_the_alnum(&js_lower(&strip_accents(s)))
}

/// journal.js `norm(s)` (no NFKD).
pub fn jnorm(v: &V) -> String {
	let s = if v.truthy() { v.to_js_string() } else { String::new() };
	strip_the_alnum(&js_lower(&s))
}

pub fn jnorm_s(s: &str) -> String {
	strip_the_alnum(&js_lower(s))
}

/// `String.prototype.toLowerCase`.
pub fn js_lower(s: &str) -> String {
	s.to_lowercase()
}

pub fn is_js_space(c: char) -> bool {
	forge_guide::emit::is_js_space(c)
}

/// build.js JUNK.
pub fn junk(s: &str) -> bool {
	static RE: LazyLock<Regex> = LazyLock::new(|| {
		Regex::new(r"^(?:Monster - |Deprecated |zz|\[PH\]|\[UNUSED\]|TEST |Test |OLD ?[A-Z])|(?-u:\b)DEPRECATED(?-u:\b)|Only GM can see|\(DND\)|(?-u:\b)DND(?-u:\b)|\[DNT\]").unwrap()
	});
	RE.is_match(s)
}

/// The value as a JS object key (`String(v)`).
pub fn kstr(v: &V) -> String {
	v.to_js_string()
}

/// build.js `sortKeysDeep(v)`: object keys sorted (numeric-looking ones numerically), deep.
pub fn sort_keys_deep(v: &V) -> V {
	match v {
		V::Arr(a) => V::Arr(Arr::from_vec(a.to_vec().iter().map(sort_keys_deep).collect())),
		V::Obj(o) => {
			let mut keys = o.keys();
			let numeric = |k: &str| -> Option<f64> {
				let n = str_to_num(k);
				(n.is_finite() && num_str(n) == k).then_some(n)
			};
			keys.sort_by(|a, b| match (numeric(a), numeric(b)) {
				(Some(x), Some(y)) => by_num(x, y),
				_ => cmp_utf16(a, b),
			});
			let out = Obj::new();
			for k in keys {
				out.set_str(k.clone(), sort_keys_deep(&o.get(&k)));
			}
			V::Obj(out)
		}
		_ => v.clone(),
	}
}

/// `Object.keys(o)` of an object value (empty for anything else).
pub fn okeys(v: &V) -> Vec<forge_guide::js::Str> {
	match v {
		V::Obj(o) => o.keys(),
		_ => Vec::new(),
	}
}

/// `Object.entries(v || {})`.
pub fn oentries(v: &V) -> Vec<(forge_guide::js::Str, V)> {
	match v {
		V::Obj(o) => o.entries(),
		_ => Vec::new(),
	}
}

/// `(v || [])` items.
pub fn items(v: &V) -> Vec<V> {
	v.items()
}

/// `arr.includes(x)` (SameValueZero) for a number.
pub fn has_num(list: &[V], x: f64) -> bool {
	list.iter().any(|v| matches!(v, V::Num(n) if *n == x))
}

/// Whether a key is an array index (JS integer-like property order).
pub fn index_key(k: &str) -> bool {
	is_index_key(k)
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn slugs_and_norms() {
		assert_eq!(slug("Ahn'Qiraj Temple"), "ahnqiraj-temple");
		assert_eq!(slug("The Temple of Atal'Hakkar"), "the-temple-of-atalhakkar");
		assert_eq!(norm_name("The Stockade"), "stockade");
		assert_eq!(norm_s("The  Deadmines"), "deadmines");
		assert_eq!(slug("Caf\u{e9} \u{c9}lan"), "cafe-elan");
		// node: s.normalize('NFKD').replace(/[\u0300-\u036f]/g, '')
		assert_eq!(strip_accents("\u{1e60}"), "S");
		assert_eq!(strip_accents("\u{1c5}"), "Dz");
		assert_eq!(strip_accents("\u{fb01}"), "fi");
		assert_eq!(strip_accents("\u{216b}"), "XII");
		assert_eq!(strip_accents("\u{d6}lrik\u{2019}s \u{1e60}tand"), "Olrik\u{2019}s Stand");
		assert_eq!(slug("\u{1c5}ungeon \u{1e60}pire"), "dzungeon-spire");
		assert!(junk("OLDSword"));
		assert!(junk("Test Dummy"));
		assert!(!junk("Oldtown Guard"));
		assert!(junk("Foo (DND)"));
	}

	#[test]
	fn sorted_keys() {
		let v = forge_guide::js::parse_json(r#"{"b":1,"10":2,"2":3,"a":{"z":1,"y":2}}"#).unwrap();
		assert_eq!(forge_guide::js::stringify(&sort_keys_deep(&v), None), r#"{"2":3,"10":2,"a":{"y":2,"z":1},"b":1}"#);
	}
}
