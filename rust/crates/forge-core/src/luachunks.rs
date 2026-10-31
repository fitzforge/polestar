//! Records as text in long-string chunks for an addon's data files, read in game by
//! [`READER`] (`luachunks.lua`): nothing is parsed at load, a record is found with one plain
//! `string.find` and decoded on first read. AddonSizeOptimisation §2 ("records as strings",
//! "one long string per chunk"): about 1x the bytes resident, against 4-5x for a table per record.
//!
//! Layout. A kind's records are sorted by id and cut into chunks of at most [`Options::per_chunk`]
//! records and [`Options::max_bytes`] bytes. A chunk is one string of lines `"\n" .. id .. "\t" ..
//! payload`, ending in `"\n"`; its file registers it as `R(kind, lo, hi, [=[...]=])` (lo and hi:
//! the chunk's first and last id), where `R` is the store's `Add`. The reader finds a chunk by its
//! id range (a binary search) and the record in it by `"\n" .. id .. "\t"`. A payload is any text
//! without a newline; [`field`] escapes the separators a payload's fields use.

/// The Lua reader every generated addon embeds (a file of its own; returns the `LuaChunks` table).
pub const READER: &str = include_str!("luachunks.lua");

/// How records are cut into chunks.
#[derive(Clone, Copy, Debug)]
pub struct Options {
	pub per_chunk: usize,
	pub max_bytes: usize,
}

impl Default for Options {
	fn default() -> Self {
		Options { per_chunk: 500, max_bytes: 64 * 1024 }
	}
}

/// One chunk: the ids it covers and its text (`"\n<id>\t<payload>"` lines, a final `"\n"`).
#[derive(Clone, Debug, PartialEq)]
pub struct Chunk {
	pub lo: i64,
	pub hi: i64,
	pub text: String,
}

/// The records (any order; ids unique) cut into chunks, by id.
pub fn chunks(records: &[(i64, String)], o: Options) -> Vec<Chunk> {
	let mut recs: Vec<&(i64, String)> = records.iter().collect();
	recs.sort_by_key(|r| r.0);
	let mut out: Vec<Chunk> = Vec::new();
	let mut cur: Option<(Chunk, usize)> = None;
	for (id, payload) in recs {
		debug_assert!(!payload.contains('\n'), "a payload holds no newline");
		let line = format!("\n{id}\t{payload}");
		let full = cur.as_ref().is_some_and(|(c, n)| *n >= o.per_chunk || c.text.len() + line.len() > o.max_bytes);
		if full {
			let (mut c, _) = cur.take().unwrap();
			c.text.push('\n');
			out.push(c);
		}
		let (c, n) = cur.get_or_insert_with(|| (Chunk { lo: *id, hi: *id, text: String::new() }, 0));
		c.hi = *id;
		c.text.push_str(&line);
		*n += 1;
	}
	if let Some((mut c, _)) = cur {
		c.text.push('\n');
		out.push(c);
	}
	out
}

/// `s` as a Lua long string literal (`[==[...]==]`, the level the text never closes early; the
/// newline after the opening bracket, which Lua drops, is written so the text keeps its own).
/// Level 0 only for a text without `[[`: Lua 5.1 refuses `[[` inside `[[...]]` ("nesting of
/// [[...]] is deprecated"), and a level of 1 or more reads it as text.
pub fn long_string(s: &str) -> String {
	let mut level = usize::from(s.contains("[["));
	loop {
		let close = format!("]{}]", "=".repeat(level));
		if !s.contains(&close) && !s.ends_with(&format!("]{}", "=".repeat(level))) {
			let eq = "=".repeat(level);
			return format!("[{eq}[\n{s}]{eq}]");
		}
		level += 1;
	}
}

/// A Lua data file registering `kind`'s chunks: `local R = <add>` then one `R("kind", lo, hi,
/// [[...]])` per chunk. `add` is the expression for the store's Add (e.g. `LibForeverData._Add`).
pub fn data_file(header: &str, add: &str, kind: &str, chunks: &[Chunk]) -> String {
	let mut s = String::new();
	s.push_str(header);
	s.push_str(&format!("local R = {add}\n"));
	for c in chunks {
		s.push_str(&format!("R({:?}, {}, {}, {})\n", kind, c.lo, c.hi, long_string(&c.text)));
	}
	s
}

/// A text field with the separators escaped as `%XX` (`%`, `;`, `,`, `:`, `|`, tab, newline);
/// the reader's `unesc` turns them back.
pub fn field(s: &str) -> String {
	let mut out = String::with_capacity(s.len());
	for ch in s.chars() {
		match ch {
			'%' | ';' | ',' | ':' | '|' | '\t' | '\n' | '\r' => out.push_str(&format!("%{:02X}", ch as u32)),
			c => out.push(c),
		}
	}
	out
}

/// The 64 digits of [`fixed`] (the order the reader's `B64` decodes).
pub const DIGITS: &[u8; 64] = b"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/";

/// `n` (0 ≤ n < 64^width) as `width` base-64 digits, most significant first: fixed-width packed
/// numbers (spawn points), read with `string.byte` arithmetic.
pub fn fixed(n: u64, width: usize) -> String {
	assert!(width >= 8 || n < 64u64.pow(width as u32), "{n} does not fit {width} digits");
	(0..width).rev().map(|i| DIGITS[((n >> (6 * i)) & 63) as usize] as char).collect()
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn chunks_cut_by_count_and_bytes_in_id_order() {
		let recs: Vec<(i64, String)> = (1..=7).rev().map(|i| (i * 10, format!("r{i}"))).collect();
		let c = chunks(&recs, Options { per_chunk: 3, max_bytes: 1 << 20 });
		assert_eq!(c.len(), 3);
		assert_eq!((c[0].lo, c[0].hi), (10, 30));
		assert_eq!(c[0].text, "\n10\tr1\n20\tr2\n30\tr3\n");
		assert_eq!((c[2].lo, c[2].hi), (70, 70));
		let c = chunks(&recs, Options { per_chunk: 100, max_bytes: 14 });
		assert!(c.iter().all(|c| c.text.len() <= 16), "{c:?}");
	}

	#[test]
	fn long_strings_never_close_early() {
		assert_eq!(long_string("\na\n"), "[[\n\na\n]]");
		assert_eq!(long_string("x]]y"), "[=[\nx]]y]=]");
		assert_eq!(long_string("x]=]y]]"), "[==[\nx]=]y]]]==]");
		assert_eq!(long_string("ends]"), "[=[\nends]]=]");
	}

	#[test]
	fn a_text_holding_double_open_brackets_gets_a_level_lua_5_1_reads() {
		assert_eq!(long_string("a[[b"), "[=[\na[[b]=]");
		assert_eq!(long_string("a[[b]=]c"), "[==[\na[[b]=]c]==]");
		assert_eq!(long_string("a[=[b"), "[[\na[=[b]]");
		// Read back by stock Lua 5.1 (built with LUA_COMPAT_LSTR 1) where it is installed.
		let texts = ["a[[b", "[[x]]", "a[[b]=]c]]", "x]]y", "ends]", "[=[ [[ ]=", "plain"];
		let checks: String = texts.iter().map(|t| format!("assert(assert(loadstring('return ' .. {:?}))() == {:?})\n", long_string(t), t)).collect();
		match std::process::Command::new("lua5.1").arg("-e").arg(checks).output() {
			Ok(out) => assert!(out.status.success(), "{}", String::from_utf8_lossy(&out.stderr)),
			Err(_) => eprintln!("lua5.1 not installed: the Lua 5.1 read-back is skipped"),
		}
	}

	#[test]
	fn fields_and_fixed_numbers() {
		assert_eq!(field("A; b, c: 100% | d"), "A%3B b%2C c%3A 100%25 %7C d");
		assert_eq!(fixed(0, 3), "000");
		assert_eq!(fixed(64 * 64 * 64 - 1, 3), "///");
		assert_eq!(fixed(65, 2), "11");
	}
}
