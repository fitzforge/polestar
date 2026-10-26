//! Checks a translation against its English key (port of tools/lib/i18n/check.js): the format
//! specifiers the code fills (%s, %d, %.1f, %5.2f, %1$s), the client's plural grammar
//! (|4singular:plural;) and its colour, texture and link escapes. A missing translation is fine (the
//! English shows); a broken one is not.

use regex::Regex;
use std::sync::LazyLock;

static SPEC: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"%(?:([0-9]+)\$)?[-+ #0]*[0-9]*(?:\.[0-9]+)?([a-zA-Z%])").unwrap());
/// What a `%` starts when it is a specifier (the JS lookahead after a lone %).
static SPEC_REST: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"^(?:[0-9]+\$)?[-+ #0]*[0-9]*(?:\.[0-9]+)?[a-zA-Z%]").unwrap());

/// One format specifier: its explicit position (%2$s) or None, its type letter and its text.
pub struct Spec {
	pub pos: Option<u64>,
	pub kind: char,
	pub text: String,
}

/// A format string's specifiers (%% left out).
pub fn specifiers(s: &str) -> Vec<Spec> {
	SPEC.captures_iter(s).filter(|m| &m[2] != "%").map(|m| Spec { pos: m.get(1).map(|p| p.as_str().parse().unwrap_or(u64::MAX)), kind: m[2].chars().next().unwrap(), text: m[0].to_string() }).collect()
}

const VALID: &str = "sdifgGeExXocqu";

/// Whether the code passes `english` through string.format, judged from the text alone: it holds %%
/// or a specifier that is not prose. A space flag followed by a word ("10% off", "25% of", "8% to")
/// is a percent sign in a sentence, not "% o" or "% t": a key with only those is shown as it is, and
/// its translations are free text. A formatted key is checked as Lua reads it.
pub fn formatted(english: &str) -> bool {
	english.contains("%%")
		|| SPEC.captures_iter(english).any(|m| {
			let kind = m[2].chars().next().unwrap();
			let whole = m.get(0).unwrap();
			let prose = whole.as_str().contains(' ') && english[whole.end()..].chars().next().is_some_and(char::is_alphabetic);
			kind != '%' && VALID.contains(kind) && !prose
		})
}

/// The escapes counted in both texts: |4one:many; plural grammar, |cAARRGGBB colour and its |r end,
/// |T texture|t, |H link|h and |n.
static ESCAPES: LazyLock<Vec<(&str, Regex)>> = LazyLock::new(|| {
	[("|4singular:plural;", r"\|4[^:;|]*:[^;|]*;"), ("|c colour", r"\|c[0-9a-fA-F]{8}"), ("|r", r"\|r"), ("|T texture", r"\|T"), ("|H link", r"\|H"), ("|n line break", r"\|n")]
		.into_iter()
		.map(|(n, re)| (n, Regex::new(re).unwrap()))
		.collect()
});

/// A `|` that starts no escape the client knows (not `|4` nor `|` and a letter); `||` already cut.
fn has_bare_bar(s: &str) -> bool {
	let b = s.as_bytes();
	(0..b.len()).any(|i| b[i] == b'|' && !b.get(i + 1).is_some_and(|c| *c == b'4' || c.is_ascii_alphabetic()))
}

/// Format problems of `translated` against `english`: none when it fills the same values the same
/// way. Positions (%2$s) may reorder them in the client (its string.format takes them); all or none
/// must carry one.
pub fn format_problems(english: &str, translated: &str) -> Vec<String> {
	let mut problems = Vec::new();
	let formatted = formatted(english);
	let (en, tr) = if formatted { (specifiers(english), specifiers(translated)) } else { (Vec::new(), Vec::new()) };
	for t in &tr {
		if !VALID.contains(t.kind) {
			problems.push(format!("\"{}\" is not a format specifier (write %% for a percent sign)", t.text));
		}
	}
	let positional = tr.iter().filter(|t| t.pos.is_some()).count();
	if positional > 0 && positional != tr.len() {
		problems.push("mixes numbered (%1$s) and plain (%s) specifiers".into());
	} else if positional > 0 {
		let mut seen = std::collections::HashSet::new();
		for t in &tr {
			let pos = t.pos.unwrap();
			match pos.checked_sub(1).and_then(|i| en.get(i as usize)) {
				None => problems.push(format!("{}: the English has no value {pos}", t.text)),
				Some(e) if e.kind != t.kind => problems.push(format!("{}: value {pos} is {} in the English", t.text, e.text)),
				Some(_) => {}
			}
			seen.insert(pos);
		}
		for (i, e) in en.iter().enumerate() {
			if !seen.contains(&(i as u64 + 1)) {
				problems.push(format!("value {} ({}) is never shown", i + 1, e.text));
			}
		}
	} else {
		let kinds = |v: &[Spec]| v.iter().map(|s| s.kind.to_string()).collect::<Vec<_>>().join(" ");
		if kinds(&en) != kinds(&tr) {
			let texts = |v: &[Spec]| {
				let t = v.iter().map(|s| s.text.as_str()).collect::<Vec<_>>().join(" ");
				if t.is_empty() {
					"(none)".to_string()
				} else {
					t
				}
			};
			problems.push(format!("specifiers {} do not match the English {}", texts(&tr), texts(&en)));
		}
	}
	let (en_bare, tr_bare) = (english.replace("||", ""), translated.replace("||", ""));
	for (name, re) in ESCAPES.iter() {
		let a = re.find_iter(&en_bare).count();
		let b = re.find_iter(&tr_bare).count();
		if a != b {
			problems.push(format!("{name}: {b} where the English has {a}"));
		}
	}
	if has_bare_bar(&tr_bare) && !has_bare_bar(&en_bare) {
		problems.push("a lone | (the client reads it as an escape; write || for a bar)".into());
	}
	// A string the code formats (the English has a specifier or %%) cannot hold a lone %:
	// string.format would stop on it.
	if formatted {
		let t = translated.replace("%%", "");
		if t.match_indices('%').any(|(i, _)| !SPEC_REST.is_match(&t[i + 1..])) {
			problems.push("a lone % (write %% for a percent sign)".into());
		}
	}
	problems
}
