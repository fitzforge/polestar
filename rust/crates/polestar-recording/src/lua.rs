//! A small reader for the Lua literals the game writes into SavedVariables files: assignments of
//! tables, strings (quoted with every Lua 5.1 escape, or long brackets), numbers, booleans and
//! nil. Nothing is executed; anything else is a syntax error.

use std::fmt;

#[derive(Clone, Debug, PartialEq)]
pub enum Value {
	Nil,
	Bool(bool),
	Num(f64),
	Str(String),
	/// Entries in file order; positional items get the keys 1, 2, ...
	Table(Vec<(Value, Value)>),
}

impl Value {
	/// The entry under a string key.
	pub fn get(&self, key: &str) -> Option<&Value> {
		match self {
			Value::Table(t) => t.iter().find(|(k, _)| matches!(k, Value::Str(s) if s == key)).map(|(_, v)| v),
			_ => None,
		}
	}

	pub fn as_str(&self) -> Option<&str> {
		match self {
			Value::Str(s) => Some(s),
			_ => None,
		}
	}

	pub fn as_num(&self) -> Option<f64> {
		match self {
			Value::Num(n) => Some(*n),
			_ => None,
		}
	}

	/// A non-negative whole number.
	pub fn as_u64(&self) -> Option<u64> {
		self.as_num().filter(|n| n.is_finite() && *n >= 0.0 && n.fract() == 0.0 && *n < 1.8e19).map(|n| n as u64)
	}

	pub fn as_bool(&self) -> Option<bool> {
		match self {
			Value::Bool(b) => Some(*b),
			_ => None,
		}
	}

	pub fn entries(&self) -> &[(Value, Value)] {
		match self {
			Value::Table(t) => t,
			_ => &[],
		}
	}
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct SyntaxError {
	pub line: usize,
	pub message: String,
}

impl fmt::Display for SyntaxError {
	fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
		write!(f, "line {}: {}", self.line, self.message)
	}
}

impl std::error::Error for SyntaxError {}

/// Every top-level `Name = value` of a SavedVariables file, in order.
pub fn parse_assignments(text: &str) -> Result<Vec<(String, Value)>, SyntaxError> {
	let mut p = Parser { s: text.as_bytes(), i: 0 };
	if p.s.starts_with(b"\xEF\xBB\xBF") {
		p.i = 3;
	}
	let mut out = Vec::new();
	loop {
		p.skip_space()?;
		if p.i >= p.s.len() {
			return Ok(out);
		}
		let name = p.name().ok_or_else(|| p.err("expected a variable name"))?;
		p.skip_space()?;
		p.expect(b'=')?;
		let v = p.value(0)?;
		out.push((name, v));
		p.skip_space()?;
		if p.peek() == Some(b';') {
			p.i += 1;
		}
	}
}

/// One Lua literal (the whole text).
pub fn parse_value(text: &str) -> Result<Value, SyntaxError> {
	let mut p = Parser { s: text.as_bytes(), i: 0 };
	let v = p.value(0)?;
	p.skip_space()?;
	if p.i < p.s.len() {
		return Err(p.err("unexpected text after the value"));
	}
	Ok(v)
}

const MAX_DEPTH: usize = 64;

struct Parser<'a> {
	s: &'a [u8],
	i: usize,
}

impl Parser<'_> {
	fn err(&self, message: &str) -> SyntaxError {
		let line = 1 + self.s[..self.i.min(self.s.len())].iter().filter(|&&b| b == b'\n').count();
		SyntaxError { line, message: message.to_string() }
	}

	fn peek(&self) -> Option<u8> {
		self.s.get(self.i).copied()
	}

	fn expect(&mut self, b: u8) -> Result<(), SyntaxError> {
		if self.peek() == Some(b) {
			self.i += 1;
			Ok(())
		} else {
			Err(self.err(&format!("expected '{}'", b as char)))
		}
	}

	/// Whitespace and comments (`-- line`, `--[[ block ]]`, `--[==[ block ]==]`).
	fn skip_space(&mut self) -> Result<(), SyntaxError> {
		loop {
			while self.peek().is_some_and(|b| b.is_ascii_whitespace()) {
				self.i += 1;
			}
			if self.s[self.i..].starts_with(b"--") {
				self.i += 2;
				if let Some(level) = self.long_open() {
					self.long_body(level)?;
				} else {
					while self.peek().is_some_and(|b| b != b'\n') {
						self.i += 1;
					}
				}
			} else {
				return Ok(());
			}
		}
	}

	/// `[[` or `[==[` at the cursor: consumes it and returns the level.
	fn long_open(&mut self) -> Option<usize> {
		if self.peek() != Some(b'[') {
			return None;
		}
		let mut j = self.i + 1;
		while self.s.get(j) == Some(&b'=') {
			j += 1;
		}
		if self.s.get(j) == Some(&b'[') {
			let level = j - self.i - 1;
			self.i = j + 1;
			Some(level)
		} else {
			None
		}
	}

	fn long_body(&mut self, level: usize) -> Result<Vec<u8>, SyntaxError> {
		// A newline right after the opening bracket is not part of the string.
		if self.s[self.i..].starts_with(b"\r\n") {
			self.i += 2;
		} else if self.peek() == Some(b'\n') {
			self.i += 1;
		}
		let start = self.i;
		while self.i < self.s.len() {
			if self.s[self.i] == b']' {
				let mut j = self.i + 1;
				while self.s.get(j) == Some(&b'=') {
					j += 1;
				}
				if j - self.i - 1 == level && self.s.get(j) == Some(&b']') {
					let body = self.s[start..self.i].to_vec();
					self.i = j + 1;
					return Ok(body);
				}
			}
			self.i += 1;
		}
		Err(self.err("unfinished long string or comment"))
	}

	fn name(&mut self) -> Option<String> {
		let start = self.i;
		if !self.peek().is_some_and(|b| b.is_ascii_alphabetic() || b == b'_') {
			return None;
		}
		while self.peek().is_some_and(|b| b.is_ascii_alphanumeric() || b == b'_') {
			self.i += 1;
		}
		Some(String::from_utf8_lossy(&self.s[start..self.i]).into_owned())
	}

	fn value(&mut self, depth: usize) -> Result<Value, SyntaxError> {
		if depth > MAX_DEPTH {
			return Err(self.err("tables nested too deeply"));
		}
		self.skip_space()?;
		match self.peek() {
			None => Err(self.err("expected a value")),
			Some(b'{') => self.table(depth),
			Some(b'"') | Some(b'\'') => Ok(Value::Str(self.quoted()?)),
			Some(b'[') => match self.long_open() {
				Some(level) => Ok(Value::Str(String::from_utf8_lossy(&self.long_body(level)?).into_owned())),
				None => Err(self.err("expected a value")),
			},
			Some(b'-') | Some(b'+') | Some(b'.') | Some(b'0'..=b'9') => Ok(Value::Num(self.number()?)),
			Some(_) => {
				let at = self.i;
				match self.name().as_deref() {
					Some("nil") => Ok(Value::Nil),
					Some("true") => Ok(Value::Bool(true)),
					Some("false") => Ok(Value::Bool(false)),
					_ => {
						self.i = at;
						Err(self.err("expected a value"))
					}
				}
			}
		}
	}

	fn number(&mut self) -> Result<f64, SyntaxError> {
		let mut neg = false;
		while let Some(b) = self.peek().filter(|b| *b == b'-' || *b == b'+') {
			if b == b'-' {
				neg = !neg;
			}
			self.i += 1;
			self.skip_space()?;
		}
		let start = self.i;
		let n = if self.s[self.i..].starts_with(b"0x") || self.s[self.i..].starts_with(b"0X") {
			self.i += 2;
			let hs = self.i;
			while self.peek().is_some_and(|b| b.is_ascii_hexdigit()) {
				self.i += 1;
			}
			let digits = std::str::from_utf8(&self.s[hs..self.i]).unwrap_or("");
			u64::from_str_radix(digits, 16).map_err(|_| self.err("bad hexadecimal number"))? as f64
		} else {
			while self.peek().is_some_and(|b| b.is_ascii_digit() || b == b'.') {
				self.i += 1;
			}
			if self.peek().is_some_and(|b| b == b'e' || b == b'E') {
				self.i += 1;
				if self.peek().is_some_and(|b| b == b'-' || b == b'+') {
					self.i += 1;
				}
				while self.peek().is_some_and(|b| b.is_ascii_digit()) {
					self.i += 1;
				}
			}
			let text = std::str::from_utf8(&self.s[start..self.i]).unwrap_or("");
			text.parse::<f64>().map_err(|_| self.err("bad number"))?
		};
		Ok(if neg { -n } else { n })
	}

	fn quoted(&mut self) -> Result<String, SyntaxError> {
		let q = self.s[self.i];
		self.i += 1;
		let mut out: Vec<u8> = Vec::new();
		loop {
			let Some(b) = self.peek() else { return Err(self.err("unfinished string")) };
			self.i += 1;
			match b {
				_ if b == q => break,
				b'\n' => return Err(self.err("unfinished string")),
				b'\\' => {
					let Some(e) = self.peek() else { return Err(self.err("unfinished string")) };
					self.i += 1;
					match e {
						b'n' => out.push(b'\n'),
						b't' => out.push(b'\t'),
						b'r' => out.push(b'\r'),
						b'a' => out.push(7),
						b'b' => out.push(8),
						b'f' => out.push(12),
						b'v' => out.push(11),
						b'\\' | b'"' | b'\'' => out.push(e),
						b'\n' => {
							out.push(b'\n');
							if self.peek() == Some(b'\r') {
								self.i += 1;
							}
						}
						b'\r' => {
							out.push(b'\n');
							if self.peek() == Some(b'\n') {
								self.i += 1;
							}
						}
						b'0'..=b'9' => {
							let mut n = (e - b'0') as u32;
							for _ in 0..2 {
								match self.peek() {
									Some(d @ b'0'..=b'9') => {
										n = n * 10 + (d - b'0') as u32;
										self.i += 1;
									}
									_ => break,
								}
							}
							if n > 255 {
								return Err(self.err("decimal escape too large"));
							}
							out.push(n as u8);
						}
						b'x' => {
							let h = self.s.get(self.i..self.i + 2).and_then(|h| std::str::from_utf8(h).ok()).and_then(|h| u8::from_str_radix(h, 16).ok());
							let Some(h) = h else { return Err(self.err("bad \\x escape")) };
							self.i += 2;
							out.push(h);
						}
						b'z' => {
							while self.peek().is_some_and(|b| b.is_ascii_whitespace()) {
								self.i += 1;
							}
						}
						b'u' => {
							self.expect(b'{')?;
							let hs = self.i;
							while self.peek().is_some_and(|b| b.is_ascii_hexdigit()) {
								self.i += 1;
							}
							let cp = std::str::from_utf8(&self.s[hs..self.i]).ok().and_then(|h| u32::from_str_radix(h, 16).ok()).and_then(char::from_u32);
							self.expect(b'}')?;
							let Some(c) = cp else { return Err(self.err("bad \\u escape")) };
							let mut buf = [0u8; 4];
							out.extend_from_slice(c.encode_utf8(&mut buf).as_bytes());
						}
						_ => return Err(self.err("invalid escape in string")),
					}
				}
				_ => out.push(b),
			}
		}
		Ok(String::from_utf8_lossy(&out).into_owned())
	}

	fn table(&mut self, depth: usize) -> Result<Value, SyntaxError> {
		self.expect(b'{')?;
		let mut out = Vec::new();
		let mut next_index = 1.0;
		loop {
			self.skip_space()?;
			match self.peek() {
				Some(b'}') => {
					self.i += 1;
					return Ok(Value::Table(out));
				}
				None => return Err(self.err("unfinished table")),
				_ => {}
			}
			let at = self.i;
			let key = if self.peek() == Some(b'[') && self.long_open().is_none() {
				self.i = at + 1;
				let k = self.value(depth + 1)?;
				self.skip_space()?;
				self.expect(b']')?;
				self.skip_space()?;
				self.expect(b'=')?;
				Some(k)
			} else {
				self.i = at;
				match self.name() {
					Some(n) if !matches!(n.as_str(), "nil" | "true" | "false") => {
						self.skip_space()?;
						if self.peek() == Some(b'=') {
							self.i += 1;
							Some(Value::Str(n))
						} else {
							self.i = at;
							None
						}
					}
					_ => {
						self.i = at;
						None
					}
				}
			};
			let v = self.value(depth + 1)?;
			let key = key.unwrap_or_else(|| {
				let k = Value::Num(next_index);
				next_index += 1.0;
				k
			});
			if key == Value::Nil {
				return Err(self.err("table key is nil"));
			}
			out.push((key, v));
			self.skip_space()?;
			match self.peek() {
				Some(b',') | Some(b';') => self.i += 1,
				Some(b'}') => {}
				_ => return Err(self.err("expected ',' or '}' in table")),
			}
		}
	}
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn reads_tables_strings_numbers_and_booleans() {
		let a = parse_assignments("-- comment\nX = {\n\t[\"a\"] = 1,\n\tb = -2.5e1; [3] = true, \"pos\", nil,\n\t--[[ block\n]] c = { [1] = false },\n}\nY = nil\n").unwrap();
		assert_eq!(a.len(), 2);
		let x = &a[0].1;
		assert_eq!(x.get("a"), Some(&Value::Num(1.0)));
		assert_eq!(x.get("b"), Some(&Value::Num(-25.0)));
		assert_eq!(x.entries()[2], (Value::Num(3.0), Value::Bool(true)));
		assert_eq!(x.entries()[3], (Value::Num(1.0), Value::Str("pos".into())));
		assert_eq!(x.entries()[4], (Value::Num(2.0), Value::Nil));
		assert_eq!(x.get("c").unwrap().entries()[0].1, Value::Bool(false));
		assert_eq!(a[1], ("Y".to_string(), Value::Nil));
	}

	#[test]
	fn reads_every_escape() {
		let v = parse_value(
			r#""a\tb\nc\\d\"e\'f\65\066\x41\u{e9}\z   g\
h""#,
		)
		.unwrap();
		assert_eq!(v, Value::Str("a\tb\nc\\d\"e'fABAég\nh".into()));
		assert!(parse_value("'it''s'").is_err());
		assert_eq!(parse_value(r#""\255""#).unwrap(), Value::Str("\u{FFFD}".into()));
		assert!(parse_value(r#""\256""#).is_err());
		assert!(parse_value(r#""\q""#).is_err());
		assert!(parse_value("\"open").is_err());
	}

	#[test]
	fn reads_long_strings() {
		assert_eq!(parse_value("[[\nline1\nline2]]").unwrap(), Value::Str("line1\nline2".into()));
		assert_eq!(parse_value("[==[a]]b]=]c]==]").unwrap(), Value::Str("a]]b]=]c".into()));
		let t = parse_value("{ [ [[k]] ] = [=[v]=] }").unwrap();
		assert_eq!(t.get("k"), Some(&Value::Str("v".into())));
		assert!(parse_value("[[never closed").is_err());
	}

	#[test]
	fn reads_hex_and_rejects_code() {
		assert_eq!(parse_value("0x1F").unwrap(), Value::Num(31.0));
		assert_eq!(parse_value("- 3").unwrap(), Value::Num(-3.0));
		assert!(parse_value("os.exit()").is_err());
		assert!(parse_value("{ 1 2 }").is_err());
		assert!(parse_assignments("X = function() end").is_err());
	}
}
