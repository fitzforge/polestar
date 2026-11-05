//! JS regular expressions in Rust: the writer's patterns are the JS writer's, translated so
//! `\s`, `\S`, `\d`, `\b` and `.` match what they match in JS (ASCII digits and word
//! boundaries, JS white space, `.` without line terminators).

use forge_guide::lexer::{RE_DOT, RE_NWS, RE_WS};
use regex::Regex;

/// Compiles a JS pattern (no lookaround). `(?i)` and the like go in front as in Rust.
pub fn compile(src: &str) -> Regex {
	Regex::new(&translate(src)).unwrap_or_else(|e| panic!("bad pattern {src}: {e}"))
}

fn translate(src: &str) -> String {
	let ws_inner = &RE_WS[1..RE_WS.len() - 1];
	let mut out = String::with_capacity(src.len() * 2);
	let mut chars = src.chars().peekable();
	let mut class = false;
	let mut class_start = false;
	while let Some(c) = chars.next() {
		let at_start = class_start;
		class_start = false;
		match c {
			'\\' => {
				let e = chars.next().expect("trailing backslash");
				match (e, class) {
					('s', false) => out.push_str(RE_WS),
					('S', false) => out.push_str(RE_NWS),
					('d', false) => out.push_str("[0-9]"),
					('b', false) => out.push_str(r"(?-u:\b)"),
					('s', true) => out.push_str(ws_inner),
					('d', true) => out.push_str("0-9"),
					_ => {
						out.push('\\');
						out.push(e);
					}
				}
			}
			'[' if !class => {
				class = true;
				class_start = true;
				out.push('[');
				if chars.peek() == Some(&'^') {
					out.push(chars.next().unwrap());
				}
			}
			']' if class && !at_start => {
				class = false;
				out.push(']');
			}
			'.' if !class => out.push_str(RE_DOT),
			'(' if !class && chars.peek() == Some(&'?') => {
				let rest: String = chars.clone().take(3).collect();
				assert!(!rest.starts_with("?=") && !rest.starts_with("?!") && !rest.starts_with("?<"), "lookaround in {src}");
				out.push('(');
			}
			_ => out.push(c),
		}
	}
	out
}

/// A regex compiled once.
#[macro_export]
macro_rules! re {
	($s:expr) => {{
		static R: std::sync::LazyLock<regex::Regex> = std::sync::LazyLock::new(|| $crate::jsre::compile($s));
		&*R
	}};
}

/// JS `\s`.
pub fn is_ws(c: char) -> bool {
	forge_guide::lexer::is_js_space(c)
}

/// JS `\w`.
pub fn is_word(c: char) -> bool {
	c.is_ascii_alphanumeric() || c == '_'
}

/// JS `s.trim()`.
pub fn trim(s: &str) -> &str {
	forge_guide::lexer::js_trim(s)
}

/// JS `s.replace(/\s+$/, '')`.
pub fn trim_end(s: &str) -> &str {
	forge_guide::lexer::js_trim_end(s)
}

/// JS `text.split(/(?=\s--\s)/)`: the code before the first ` -- ` comment and the rest
/// (`rest.join('')`); a match at 0 does not split.
pub fn split_comment(text: &str) -> (&str, &str) {
	let r = re!(r"\s--\s");
	let mut from = 0;
	while let Some(m) = r.find_at(text, from) {
		if m.start() > 0 {
			return (&text[..m.start()], &text[m.start()..]);
		}
		// Next char boundary after 0.
		from = text[1..].char_indices().next().map_or(text.len(), |(i, _)| i + 1);
		if from >= text.len() {
			break;
		}
	}
	(text, "")
}

/// JS `text.split(/(?<=[.!?])\s+/)`.
pub fn split_sentences(text: &str) -> Vec<&str> {
	let r = re!(r"[.!?]\s+");
	let mut out = Vec::new();
	let mut prev = 0;
	for m in r.find_iter(text) {
		out.push(&text[prev..m.start() + 1]);
		prev = m.end();
	}
	out.push(&text[prev..]);
	out
}

/// The word after a line's indent (`^\s+(word)\b`): the ASCII word run after at least one
/// white space; None without an indent.
pub fn head(text: &str) -> Option<&str> {
	let body = text.trim_start_matches(is_ws);
	if body.len() == text.len() {
		return None;
	}
	let end = body.find(|c: char| !is_word(c)).unwrap_or(body.len());
	Some(&body[..end])
}

/// `^\s+(word)\s`: the head word followed by white space.
pub fn head_ws(text: &str) -> Option<&str> {
	let h = head(text)?;
	let body = text.trim_start_matches(is_ws);
	body[h.len()..].chars().next().filter(|c| is_ws(*c)).map(|_| h)
}

/// `^step\b`.
pub fn is_step(l: &str) -> bool {
	l.starts_with("step") && !l[4..].chars().next().is_some_and(is_word)
}

/// `/^\S/`.
pub fn starts_nonspace(l: &str) -> bool {
	l.chars().next().is_some_and(|c| !is_ws(c))
}

/// `/^\s+\S/`.
pub fn indented(l: &str) -> bool {
	let body = l.trim_start_matches(is_ws);
	body.len() < l.len() && !body.is_empty()
}

/// JS `Number(s)` for a `[\d.]+` match.
pub fn num(s: &str) -> f64 {
	if s.is_empty() {
		return 0.0;
	}
	s.parse::<f64>().unwrap_or(f64::NAN)
}

/// `s` starts with the digits `q` followed by a word boundary (`q\b`).
pub fn starts_num(s: &str, q: &str) -> bool {
	s.starts_with(q) && !s[q.len()..].chars().next().is_some_and(is_word)
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn translates() {
		let r = compile(r"^\s+(kill|collect)\s+(\d+)\b.*\bquest\s+(\d+)");
		let c = r.captures("  kill 12 x quest 7.1").unwrap();
		assert_eq!(&c[2], "12");
		assert!(compile(r"[\d.]+").is_match("1.5"));
		assert!(compile(r"\boptional\b").is_match("x optional"));
		assert!(!compile(r"^\d").is_match("٣"));
		assert_eq!(split_comment("  kill 1 -- a -- b"), ("  kill 1", " -- a -- b"));
		assert_eq!(split_sentences("A. B! C"), vec!["A.", "B!", "C"]);
		assert_eq!(split_sentences("A. "), vec!["A.", ""]);
		assert_eq!(head("  accept 1"), Some("accept"));
		assert_eq!(head_ws("  hearth \"x\""), Some("hearth"));
		assert_eq!(head_ws("  hearth"), None);
		assert!(is_step("step") && is_step("step X") && !is_step("steps"));
	}
}
