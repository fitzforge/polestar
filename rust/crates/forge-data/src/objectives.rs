//! Objective counts from quest objective text (port of tools/lib/data/objectives.js): only the
//! patterns that state the count outright; anything else stays None.

use forge_guide::js::cmp_utf16;

const WORDS: [&str; 20] =
	["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen", "twenty"];
const MAX_COUNT: f64 = 250.0;
fn is_js_line_terminator(c: char) -> bool {
	matches!(c, '\n' | '\r' | '\u{2028}' | '\u{2029}')
}

fn is_word_char(c: char) -> bool {
	c.is_ascii_alphabetic() || c == '\''
}

fn plurals(word: &str) -> Vec<String> {
	let lower = word.to_lowercase();
	let mut out = vec![format!("{word}s")];
	let ends = |s: &str| lower.ends_with(s);
	if ["s", "x", "z", "ch", "sh"].iter().any(|s| ends(s)) {
		out.push(format!("{word}es"));
	}
	let lb = lower.as_bytes();
	if lb.len() >= 2 && lb[lb.len() - 1] == b'y' && !b"aeiou".contains(&lb[lb.len() - 2]) {
		out.push(format!("{}ies", &word[..word.len() - 1]));
	}
	if ends("fe") {
		out.push(format!("{}ves", &word[..word.len() - 2]));
	} else if ends("f") {
		out.push(format!("{}ves", &word[..word.len() - 1]));
	}
	if ends("man") {
		out.push(format!("{}men", &word[..word.len() - 3]));
	}
	let first = &word[..1];
	if lower == "tooth" {
		out.push(format!("{first}eeth"));
	}
	if lower == "foot" {
		out.push(format!("{first}eet"));
	}
	if lower == "mouse" {
		out.push(format!("{first}ice"));
	}
	out
}

/// `/^(.*?)([A-Za-z']+)$/`.
fn split_last(name: &str) -> Option<(&str, &str)> {
	let start = name.char_indices().rev().take_while(|(_, c)| is_word_char(*c)).last().map(|(i, _)| i)?;
	let prefix = &name[..start];
	(!prefix.chars().any(is_js_line_terminator)).then_some((prefix, &name[start..]))
}

/// `/^(.*?)([A-Za-z']+)( of .+)$/`.
fn split_of(name: &str) -> Option<(&str, &str, &str)> {
	let idx: Vec<(usize, char)> = name.char_indices().collect();
	for (k, &(p, c)) in idx.iter().enumerate() {
		if name[..p].chars().any(is_js_line_terminator) {
			return None;
		}
		if !is_word_char(c) {
			continue;
		}
		let mut j = k;
		while j < idx.len() && is_word_char(idx[j].1) {
			j += 1;
		}
		let end = if j < idx.len() { idx[j].0 } else { name.len() };
		let rest = &name[end..];
		if let Some(tail) = rest.strip_prefix(" of ") {
			if !tail.is_empty() && !tail.chars().any(is_js_line_terminator) {
				return Some((&name[..p], &name[p..end], rest));
			}
		}
	}
	None
}

/// The name plus plausible plurals, longest first.
pub fn name_forms(name: &str) -> Vec<String> {
	let mut forms: Vec<String> = vec![name.to_string()];
	let mut add = |s: String| {
		if !forms.contains(&s) {
			forms.push(s);
		}
	};
	if let Some((pre, last)) = split_last(name) {
		for p in plurals(last) {
			add(format!("{pre}{p}"));
		}
	}
	if let Some((pre, w, of)) = split_of(name) {
		for p in plurals(w) {
			add(format!("{pre}{p}{of}"));
		}
	}
	forms.sort_by(|a, b| {
		let (la, lb) = (a.encode_utf16().count(), b.encode_utf16().count());
		lb.cmp(&la).then_with(|| if cmp_utf16(a, b) == std::cmp::Ordering::Less { std::cmp::Ordering::Less } else { std::cmp::Ordering::Greater })
	});
	forms
}

/// JS `\s` (no `u` flag).
pub fn is_js_space(c: char) -> bool {
	matches!(c, '\t' | '\n' | '\x0B' | '\x0C' | '\r' | ' ' | '\u{a0}' | '\u{1680}' | '\u{2000}'..='\u{200a}' | '\u{2028}' | '\u{2029}' | '\u{202f}' | '\u{205f}' | '\u{3000}' | '\u{feff}')
}

/// JS case-insensitive canonical form of a character (the `i` flag without `u`).
fn canon(c: char) -> char {
	if c.is_ascii() {
		return c.to_ascii_uppercase();
	}
	let mut up = c.to_uppercase();
	match (up.next(), up.next()) {
		(Some(u), None) if (u as u32) >= 128 => u,
		_ => c,
	}
}

fn letter(t: &[char], i: usize) -> bool {
	t.get(i).is_some_and(char::is_ascii_alphabetic)
}

/// Positions after one or more whitespace characters at `i` (every split of the run).
fn after_ws(t: &[char], i: usize) -> impl Iterator<Item = usize> {
	let mut j = i;
	while j < t.len() && is_js_space(t[j]) {
		j += 1;
	}
	(i + 1..=j).filter(move |_| j > i)
}

/// Case-insensitive literal `w` at `i` -> the position after it.
fn lit(t: &[char], i: usize, w: &[char]) -> Option<usize> {
	(i + w.len() <= t.len() && t[i..i + w.len()].iter().zip(w).all(|(a, b)| canon(*a) == canon(*b))).then_some(i + w.len())
}

/// Positions reachable through `(?:(?:[A-Za-z]+\s+)?of\s+)?` from `i`.
fn opt_of(t: &[char], i: usize) -> Vec<usize> {
	let of: Vec<char> = "of".chars().collect();
	let mut out = vec![i];
	let mut starts = vec![i];
	if letter(t, i) {
		let mut j = i;
		while letter(t, j) {
			j += 1;
		}
		// The letters can stop anywhere, but only a full run is followed by whitespace.
		starts.extend(after_ws(t, j));
	}
	for s in starts {
		if let Some(k) = lit(t, s, &of) {
			out.extend(after_ws(t, k));
		}
	}
	out
}

/// Positions reachable through `(?:the\s+)?` from each of `ps`.
fn opt_the(t: &[char], ps: Vec<usize>) -> Vec<usize> {
	let the: Vec<char> = "the".chars().collect();
	let mut out = ps.clone();
	for p in ps {
		if let Some(k) = lit(t, p, &the) {
			out.extend(after_ws(t, k));
		}
	}
	out
}

fn form_at(t: &[char], i: usize, forms: &[Vec<char>], tail_apostrophe: bool) -> bool {
	forms.iter().any(|f| lit(t, i, f).is_some_and(|k| !t.get(k).is_some_and(|c| c.is_ascii_alphabetic() || (tail_apostrophe && *c == '\''))))
}

/// `(?<![A-Za-z0-9])(NUMBER)\s+(?:(?:[A-Za-z]+\s+)?of\s+)?(?:the\s+)?(?:forms)(?![A-Za-z])`, case
/// insensitive: the number of the leftmost match.
fn numeric_count(text: &[char], forms: &[String]) -> Option<f64> {
	let forms: Vec<Vec<char>> = forms.iter().map(|f| f.chars().collect()).collect();
	let words: Vec<Vec<char>> = WORDS.iter().map(|w| w.chars().collect()).collect();
	for i in 0..text.len() {
		if i > 0 && (text[i - 1].is_ascii_alphanumeric()) {
			continue;
		}
		// The number token: digits (all of them: fewer is followed by a digit) or a word.
		let mut tokens: Vec<(usize, f64)> = Vec::new();
		if text[i].is_ascii_digit() {
			let mut j = i;
			while j < text.len() && text[j].is_ascii_digit() {
				j += 1;
			}
			let s: String = text[i..j].iter().collect();
			tokens.push((j, s.parse::<f64>().unwrap_or(f64::INFINITY)));
		} else {
			for (wi, w) in words.iter().enumerate() {
				if let Some(k) = lit(text, i, w) {
					tokens.push((k, (wi + 1) as f64));
				}
			}
		}
		for (k, value) in tokens {
			for p in after_ws(text, k) {
				if opt_the(text, opt_of(text, p)).into_iter().any(|q| form_at(text, q, &forms, false)) {
					return (1.0..=MAX_COUNT).contains(&value).then_some(value);
				}
			}
		}
	}
	None
}

/// `(?<![A-Za-z])(?:an?|the)\s+(?:[A-Za-z]+\s+of\s+)?NAME(?![A-Za-z'])`, case insensitive.
fn article_match(text: &[char], name: &str, item: bool) -> bool {
	let name: Vec<char> = name.chars().collect();
	let arts: Vec<Vec<char>> = (if item { vec!["an", "a", "the"] } else { vec!["an", "a"] }).iter().map(|w| w.chars().collect()).collect();
	let of: Vec<char> = "of".chars().collect();
	for i in 0..text.len() {
		if i > 0 && text[i - 1].is_ascii_alphabetic() {
			continue;
		}
		for a in &arts {
			let Some(k) = lit(text, i, a) else { continue };
			for p in after_ws(text, k) {
				let mut cands = vec![p];
				if letter(text, p) {
					let mut j = p;
					while letter(text, j) {
						j += 1;
					}
					for q in after_ws(text, j) {
						if let Some(r) = lit(text, q, &of) {
							cands.extend(after_ws(text, r));
						}
					}
				}
				if cands.into_iter().any(|c| form_at(text, c, std::slice::from_ref(&name), true)) {
					return true;
				}
			}
		}
	}
	false
}

/// JS `\s+` split.
fn split_ws(s: &str) -> Vec<&str> {
	let ws = |c: char| {
		matches!(c, '\t' | '\n' | '\x0B' | '\x0C' | '\r' | ' ' | '\u{a0}' | '\u{1680}' | '\u{2000}'..='\u{200a}' | '\u{2028}' | '\u{2029}' | '\u{202f}' | '\u{205f}' | '\u{3000}' | '\u{feff}')
	};
	let mut out = Vec::new();
	let mut start = 0;
	let mut in_ws = false;
	let mut ws_start = 0;
	for (i, c) in s.char_indices() {
		if ws(c) {
			if !in_ws {
				ws_start = i;
				in_ws = true;
			}
		} else if in_ws {
			out.push(&s[start..ws_start]);
			start = i;
			in_ws = false;
		}
	}
	out.push(if in_ws { &s[start..ws_start] } else { &s[start..] });
	if in_ws {
		out.push("");
	}
	out
}

fn suffix_aliases(name: &str, others: &[String]) -> Vec<String> {
	let words = split_ws(name);
	let lower_others: Vec<String> = others.iter().filter(|o| !o.is_empty() && o.as_str() != name).map(|o| o.to_lowercase()).collect();
	let mut out = Vec::new();
	for k in 1..words.len() {
		let suffix = words[k..].join(" ");
		if suffix.encode_utf16().count() < 4 {
			continue;
		}
		let lo = suffix.to_lowercase();
		// /^of\b/i
		if lo.starts_with("of") && !suffix[2..].starts_with(|c: char| c.is_ascii_alphanumeric() || c == '_') {
			continue;
		}
		if lower_others.iter().any(|o| *o == lo || o.ends_with(&format!(" {lo}"))) {
			continue;
		}
		out.push(suffix);
	}
	out
}

/// The count `text` states for objective `name` (`kind`: kill, item, object, ...), `others` the
/// quest's other objective names.
pub fn parse_count(text: Option<&str>, name: Option<&str>, kind: &str, others: &[String]) -> Option<f64> {
	let (text, name) = (text?, name?);
	if text.is_empty() || name.is_empty() {
		return None;
	}
	let t: Vec<char> = text.chars().collect();
	let mut count = numeric_count(&t, &name_forms(name));
	if count.is_none() {
		for alias in suffix_aliases(name, others) {
			count = numeric_count(&t, &name_forms(&alias));
			if count.is_some() {
				break;
			}
		}
	}
	if count.is_none() && article_match(&t, name, kind == "item") {
		count = Some(1.0);
	}
	count
}

pub struct Progress {
	pub name: String,
	pub slain: bool,
	pub cur: f64,
	pub max: f64,
}

/// "Kobold Vermin slain: 3/10" -> { name, slain, cur, max }
/// (`/^\s*(.*?)\s*:\s*(\d+)\s*\/\s*(\d+)\s*$/`, then `/^(.*?)\s+(slain|killed)$/i` on the name).
pub fn parse_progress_text(text: &str) -> Option<Progress> {
	let t = text.trim_start_matches(is_js_space);
	// The earliest colon whose rest is "<digits> / <digits>".
	let tail = |r: &str| -> Option<(f64, f64)> {
		let r = r.trim_matches(is_js_space);
		let (a, b) = r.split_once('/')?;
		let (a, b) = (a.trim_end_matches(is_js_space), b.trim_start_matches(is_js_space));
		let num = |x: &str| (!x.is_empty() && x.bytes().all(|c| c.is_ascii_digit())).then(|| x.parse::<f64>().unwrap());
		Some((num(a)?, num(b)?))
	};
	let (i, (cur, max)) = t.match_indices(':').find_map(|(i, _)| tail(&t[i + 1..]).map(|v| (i, v)))?;
	if t[..i].trim_end_matches(is_js_space).contains(is_js_line_terminator) {
		return None;
	}
	let mut name = t[..i].trim_end_matches(is_js_space).to_string();
	let mut slain = false;
	for w in ["slain", "killed"] {
		if name.len() >= w.len() && name.is_char_boundary(name.len() - w.len()) && name[name.len() - w.len()..].eq_ignore_ascii_case(w) {
			let head = &name[..name.len() - w.len()];
			let trimmed = head.trim_end_matches(is_js_space);
			if trimmed.len() < head.len() {
				name = trimmed.to_string();
				slain = true;
				break;
			}
		}
	}
	Some(Progress { name, slain, cur, max })
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn counts() {
		let o: Vec<String> = Vec::new();
		assert_eq!(parse_count(Some("Bring 7 pieces of Plainstrider Meat to Bob."), Some("Plainstrider Meat"), "item", &o), Some(7.0));
		assert_eq!(parse_count(Some("Kill 7 Tidehunters."), Some("Murloc Tidehunter"), "kill", &o), Some(7.0));
		assert_eq!(parse_count(Some("Kill ten Kobold Workers."), Some("Kobold Worker"), "kill", &o), Some(10.0));
		assert_eq!(parse_count(Some("Retrieve the Warchief's Orders."), Some("Warchief's Orders"), "item", &o), Some(1.0));
		assert_eq!(parse_count(Some("Bring Idols of Strife."), Some("Idol of Strife"), "item", &o), None);
		assert_eq!(parse_count(Some("Bring 5 Idols of Strife."), Some("Idol of Strife"), "item", &o), Some(5.0));
		assert_eq!(name_forms("Wolf"), vec!["Wolves".to_string(), "Wolfs".into(), "Wolf".into()]);
		let p = parse_progress_text("Kobold Vermin slain: 3/10").unwrap();
		assert_eq!((p.name.as_str(), p.slain, p.cur, p.max), ("Kobold Vermin", true, 3.0, 10.0));
		let p = parse_progress_text(" Sky Shard : 0 / 5 ").unwrap();
		assert_eq!((p.name.as_str(), p.slain, p.cur, p.max), ("Sky Shard", false, 0.0, 5.0));
		let p = parse_progress_text("Time: 12:30: 1/2").unwrap();
		assert_eq!(p.name, "Time: 12:30");
		assert!(parse_progress_text("Slain").is_none());
	}
}
