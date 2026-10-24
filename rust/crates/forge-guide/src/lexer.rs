//! Port of tools/lib/dsl/lexer.js.
//! Line lexer for the .guide format (docs/GUIDE_FORMAT.md, "Lexical rules").
//!
//! lex_line(text) -> Lex { tokens, note, end, error }
//!   tokens: [Tok { text, quoted, start, end }]  (start/end are UTF-16 offsets into text)
//!   note:   text after ` -- ` (trimmed) or None
//!   end:    offset where the line's content stops (comment or note start)
//!   error:  message for the first lexical error, or None
//!
//! `#` starts a comment at line start or after whitespace, outside quotes.
//! ` -- ` (whitespace, two dashes, whitespace) starts a player-facing note;
//! the rest of the line is the note verbatim. Quoted tokens support `\"` and
//! `\\` escapes only.
//!
//! Also the JS whitespace helpers the dsl modules share (`String.prototype.trim`, `\s`).

/// A lazily compiled `regex::Regex` from a `format!` pattern (JS classes via RE_WS etc.).
#[macro_export]
macro_rules! re {
	($($fmt:tt)*) => {{
		static C: std::sync::LazyLock<regex::Regex> = std::sync::LazyLock::new(|| regex::Regex::new(&format!($($fmt)*)).unwrap());
		&*C
	}};
}

#[derive(Clone, Debug, PartialEq)]
pub struct Tok {
	pub text: String,
	pub quoted: bool,
	pub start: usize,
	pub end: usize,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Lex {
	pub tokens: Vec<Tok>,
	pub note: Option<String>,
	pub end: usize,
	pub error: Option<String>,
}

/// JS WhiteSpace + LineTerminator (what `trim()` strips and `\s` matches).
pub fn is_js_space(c: char) -> bool {
	matches!(c, '\t' | '\n' | '\u{0B}' | '\u{0C}' | '\r' | ' ' | '\u{A0}' | '\u{1680}' | '\u{2000}'..='\u{200A}' | '\u{2028}' | '\u{2029}' | '\u{202F}' | '\u{205F}' | '\u{3000}' | '\u{FEFF}')
}

/// JS `s.trim()`.
pub fn js_trim(s: &str) -> &str {
	s.trim_matches(is_js_space)
}

/// JS `s.trimEnd()` / `s.replace(/\s+$/, '')`.
pub fn js_trim_end(s: &str) -> &str {
	s.trim_end_matches(is_js_space)
}

/// A regex character class equal to JS `\s`.
pub const RE_WS: &str = r"[\t\n\x0B\x0C\r \x{A0}\x{1680}\x{2000}-\x{200A}\x{2028}\x{2029}\x{202F}\x{205F}\x{3000}\x{FEFF}]";
/// A regex character class equal to JS `\S`.
pub const RE_NWS: &str = r"[^\t\n\x0B\x0C\r \x{A0}\x{1680}\x{2000}-\x{200A}\x{2028}\x{2029}\x{202F}\x{205F}\x{3000}\x{FEFF}]";
/// A regex character class equal to JS `.` (no `s` flag).
pub const RE_DOT: &str = r"[^\n\r\x{2028}\x{2029}]";

fn is_space(c: u16) -> bool {
	c == b' ' as u16 || c == b'\t' as u16
}

fn s16(u: &[u16]) -> String {
	String::from_utf16_lossy(u)
}

pub fn lex_line(text: &str) -> Lex {
	let u: Vec<u16> = text.encode_utf16().collect();
	lex_units(&u)
}

/// The lexer over a line's UTF-16 code units (offsets are indices into `text`).
pub fn lex_units(text: &[u16]) -> Lex {
	let mut tokens = Vec::new();
	let mut note = None;
	let n = text.len();
	let mut end = n;
	let mut i = 0;
	const Q: u16 = b'"' as u16;
	const BS: u16 = b'\\' as u16;
	const DASH: u16 = b'-' as u16;
	let err = |tokens: Vec<Tok>, note: Option<String>, end: usize, e: String| Lex { tokens, note, end, error: Some(e) };
	while i < n {
		let c = text[i];
		if is_space(c) {
			i += 1;
			continue;
		}
		// Here i is the start of a token, preceded by whitespace or line start.
		if c == b'#' as u16 {
			end = i;
			break;
		}
		if c == DASH && text.get(i + 1) == Some(&DASH) && (i + 2 == n || text.get(i + 2).is_some_and(|&d| is_space(d))) {
			end = i;
			note = Some(js_trim(&s16(&text[i + 2..])).to_string());
			break;
		}
		if c == Q {
			let mut value: Vec<u16> = Vec::new();
			let mut j = i + 1;
			let mut closed = false;
			while j < n {
				let d = text[j];
				if d == BS {
					match text.get(j + 1) {
						Some(&e) if e == Q || e == BS => {
							value.push(e);
							j += 2;
							continue;
						}
						Some(&e) => return err(tokens, note, end, format!("unknown escape \\{} in string (only \\\" and \\\\ are allowed)", s16(&[e]))),
						None => return err(tokens, note, end, "unterminated string".into()),
					}
				}
				if d == Q {
					closed = true;
					break;
				}
				value.push(d);
				j += 1;
			}
			if !closed {
				return err(tokens, note, end, "unterminated string".into());
			}
			if j + 1 < n && !is_space(text[j + 1]) {
				return err(tokens, note, end, format!("unexpected \"{}\" after closing quote", s16(&text[j + 1..j + 2])));
			}
			tokens.push(Tok { text: s16(&value), quoted: true, start: i, end: j + 1 });
			i = j + 1;
			continue;
		}
		let mut j = i;
		while j < n && !is_space(text[j]) {
			if text[j] == Q {
				return err(tokens, note, end, "a quote must start a new token".into());
			}
			j += 1;
		}
		tokens.push(Tok { text: s16(&text[i..j]), quoted: false, start: i, end: j });
		i = j;
	}
	Lex { tokens, note, end, error: None }
}
