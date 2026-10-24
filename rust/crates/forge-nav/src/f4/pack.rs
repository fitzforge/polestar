//! A format-4 walking-map pack (Leffe's navigation maps: Nav<map>.lua and its part files), read cluster by cluster.
//!
//! A port of tools/lib/nav/nav4/pack.js, itself a port of Leffe's format-4 reader (his Routing/Motion.lua: Decode,
//! Graph, Traces, Bind, and the decoders of Routing/PathGrid.lua: decodeGrid, decodeHeights, decodeFloors,
//! decodeClasses, filterMotionMoves). PathGrid.lua started from Shortest Path Forever v1.16.0 by Cillian Berragan.
//! Copyright (C) 2026 Cillian Berragan; Copyright (c) 2026 The Polestar authors (Leffe's reader). GPL-3.0-or-later.
//!
//! Node indexes are 0-based where the Lua is 1-based. The decoders keep the JS port's arithmetic (f64 heights while
//! decoding, f32 once typed), so a cluster here is the JS port's cluster value for value.

use rustc_hash::{FxHashMap, FxHashSet};
use std::sync::OnceLock;

pub type R<T> = Result<T, String>;

/// The heap bytes of the named Vec fields (capacity x element size).
macro_rules! heap {
	($s:ident; $($f:ident),*) => { 0 $(+ $s.$f.capacity() * elem_size(&$s.$f))* };
}
fn elem_size<T>(_: &Vec<T>) -> usize {
	std::mem::size_of::<T>()
}
/// Shrinks the named Vec fields to their lengths.
macro_rules! shrink {
	($s:ident; $($f:ident),*) => { $($s.$f.shrink_to_fit();)* };
}

pub const TILE: f64 = 1600.0 / 3.0;
pub const STRIDE: i64 = 4_194_304;
/// Math.tan(50 * Math.PI / 180) as V8 computes it (fdlibm), bit for bit.
pub const WALK_TAN: f64 = f64::from_bits(0x3ff3_116c_3711_527e);
pub const SLOPE_EPS: f64 = 1e-12;
pub const DX: [i64; 8] = [1, -1, 0, 0, 1, 1, -1, -1];
pub const DY: [i64; 8] = [0, 0, 1, -1, 1, -1, 1, -1];
const OPPOSITE: [usize; 8] = [1, 0, 3, 2, 7, 6, 5, 4];

pub const B64: [i16; 256] = {
	let mut t = [-1i16; 256];
	let a = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	let mut i = 0;
	while i < 64 {
		t[a[i] as usize] = i as i16;
		i += 1;
	}
	t
};

/// B64 of s[i] (-1 past the end or off the alphabet).
#[inline]
pub fn b64(s: &[u8], i: usize) -> i32 {
	match s.get(i) {
		Some(&c) => B64[c as usize] as i32,
		None => -1,
	}
}

/// Lua's num(s, i, width), 0-based i.
#[inline]
fn num(s: &[u8], i: usize, width: usize) -> i32 {
	let v = b64(s, i) * 64 + b64(s, i + 1);
	if width == 2 {
		v
	} else {
		v * 64 + b64(s, i + 2)
	}
}

pub fn fail<T>(why: impl std::fmt::Display) -> R<T> {
	Err(format!("Path format4: {why}"))
}

// ---- the metadata file ----

/// Byte span [start, end) of part file `part` holding a cluster field's quoted base64 blocks.
#[derive(Clone, Copy, Debug)]
pub struct Span {
	pub part: u32,
	pub start: usize,
	pub end: usize,
}

#[derive(Clone, Debug)]
pub struct HubDef {
	pub id: String,
	pub side: Option<String>,
	pub name: Option<String>,
	/// NaN when the line has none (the JS `+undefined`).
	pub area_id: f64,
	pub disks: Vec<[f64; 3]>,
}

#[derive(Debug)]
pub struct Meta {
	pub map: u32,
	pub movement_identity: Option<String>,
	pub nx: i64,
	pub ny: i64,
	pub c: i64,
	pub swim: f64,
	pub zstep: f64,
	pub x0: f64,
	pub y0: f64,
	pub cs: f64,
	pub gx: i64,
	pub gy: i64,
	/// zone[k]: cluster k's zone runs (None: the file has no zone table; Some with holes: clusters without one).
	pub zone: Option<Vec<Option<Vec<u8>>>>,
	pub hubs: Vec<HubDef>,
	pub counts: Vec<(String, u64)>,
	/// field -> cluster -> spans, in file order.
	pub index: FxHashMap<String, FxHashMap<u32, Vec<Span>>>,
}

impl Meta {
	pub fn spans(&self, field: &str, k: u32) -> Option<&Vec<Span>> {
		self.index.get(field).and_then(|m| m.get(&k))
	}
}

enum Scalar {
	Num(f64),
	Str(String),
}

fn find(h: &[u8], needle: &[u8], from: usize) -> Option<usize> {
	if needle.is_empty() || from > h.len() {
		return None;
	}
	let first = needle[0];
	let mut i = from;
	while i + needle.len() <= h.len() {
		if h[i] == first && &h[i..i + needle.len()] == needle {
			return Some(i);
		}
		i += 1;
	}
	None
}

/// JS Number(string) for the plain decimal forms the files hold (NaN otherwise; "" is 0).
fn js_number(s: &str) -> f64 {
	let t = s.trim();
	if t.is_empty() {
		return 0.0;
	}
	if t.bytes().all(|b| b.is_ascii_digit() || matches!(b, b'.' | b'-' | b'+' | b'e' | b'E')) {
		t.parse::<f64>().unwrap_or(f64::NAN)
	} else {
		f64::NAN
	}
}

/// `\n\t<name> = ("?)([^",\n]*)\1,`
fn scalar(text: &[u8], name: &str) -> Option<Scalar> {
	let pat = format!("\n\t{name} = ");
	let pat = pat.as_bytes();
	let mut from = 0;
	while let Some(p) = find(text, pat, from) {
		from = p + 1;
		let mut i = p + pat.len();
		let quoted = text.get(i) == Some(&b'"');
		if quoted {
			i += 1;
		}
		let start = i;
		while i < text.len() && !matches!(text[i], b'"' | b',' | b'\n') {
			i += 1;
		}
		let val = String::from_utf8_lossy(&text[start..i]).into_owned();
		let ok = if quoted { text.get(i) == Some(&b'"') && text.get(i + 1) == Some(&b',') } else { text.get(i) == Some(&b',') };
		if ok {
			return Some(if quoted { Scalar::Str(val) } else { Scalar::Num(js_number(&val)) });
		}
		if quoted {
			// The regex's other try (empty quote group) needs a ',' where the '"' stands: never.
		}
	}
	None
}

fn is_word(b: u8) -> bool {
	b.is_ascii_alphanumeric() || b == b'_'
}

/// `\b<key> = "([^"]*)"` in line.
fn quoted_field(line: &[u8], key: &str) -> Option<String> {
	let pat = format!("{key} = \"");
	let pat = pat.as_bytes();
	let mut from = 0;
	while let Some(p) = find(line, pat, from) {
		from = p + 1;
		if p > 0 && is_word(line[p - 1]) {
			continue;
		}
		let s = p + pat.len();
		if let Some(e) = line[s..].iter().position(|&b| b == b'"') {
			return Some(String::from_utf8_lossy(&line[s..s + e]).into_owned());
		}
	}
	None
}

/// `-?[\d.]+` at i -> (value, end).
fn number_at(s: &[u8], i: usize) -> Option<(f64, usize)> {
	let mut j = i;
	if s.get(j) == Some(&b'-') {
		j += 1;
	}
	let d = j;
	while j < s.len() && (s[j].is_ascii_digit() || s[j] == b'.') {
		j += 1;
	}
	if j == d {
		return None;
	}
	let txt = std::str::from_utf8(&s[i..j]).ok()?;
	Some((js_number(txt), j))
}

fn parse_hub(line: &[u8]) -> Option<HubDef> {
	let id = quoted_field(line, "id")?;
	let side = quoted_field(line, "side");
	let name = quoted_field(line, "name");
	let mut area_id = f64::NAN;
	{
		let pat = b"areaId = ";
		let mut from = 0;
		while let Some(p) = find(line, pat, from) {
			from = p + 1;
			if p > 0 && is_word(line[p - 1]) {
				continue;
			}
			let s = p + pat.len();
			let mut e = s;
			while e < line.len() && line[e].is_ascii_digit() {
				e += 1;
			}
			if e > s {
				area_id = js_number(std::str::from_utf8(&line[s..e]).unwrap());
				break;
			}
		}
	}
	// `\{ (-?[\d.]+), (-?[\d.]+), (-?[\d.]+) \}`
	let mut disks = Vec::new();
	let mut i = 0;
	while i < line.len() {
		if line[i] == b'{' && line.get(i + 1) == Some(&b' ') {
			let try_disk = || -> Option<([f64; 3], usize)> {
				let (a, j) = number_at(line, i + 2)?;
				if line.get(j..j + 2)? != b", " {
					return None;
				}
				let (b, j) = number_at(line, j + 2)?;
				if line.get(j..j + 2)? != b", " {
					return None;
				}
				let (c, j) = number_at(line, j + 2)?;
				if line.get(j..j + 2)? != b" }" {
					return None;
				}
				Some(([a, b, c], j + 2))
			};
			if let Some((d, end)) = try_disk() {
				disks.push(d);
				i = end;
				continue;
			}
		}
		i += 1;
	}
	Some(HubDef { id, side, name, area_id, disks })
}

/// parseMeta: the metadata file's scalars, zone runs, hubs and counts (the part index is scanned apart).
pub fn parse_meta(text: &[u8], map: u32) -> R<Meta> {
	let num = |name: &str| match scalar(text, name) {
		Some(Scalar::Num(v)) => Some(v),
		_ => None,
	};
	match scalar(text, "format") {
		Some(Scalar::Num(4.0)) => {}
		Some(Scalar::Num(v)) => return fail(format!("map {map} is format {v}, not 4")),
		Some(Scalar::Str(s)) => return fail(format!("map {map} is format {s}, not 4")),
		None => return fail(format!("map {map} is format undefined, not 4")),
	}
	let movement_identity = match scalar(text, "movementIdentity") {
		Some(Scalar::Str(s)) => Some(s),
		Some(Scalar::Num(v)) => Some(v.to_string()),
		None => None,
	};
	let mut vals = [0f64; 7];
	for (i, (key, name)) in [("cx0", "cx0"), ("cy0", "cy0"), ("nx", "nx"), ("ny", "ny"), ("C", "cells"), ("swim", "swim"), ("zstep", "zstep")].iter().enumerate() {
		match num(name) {
			Some(v) if v.is_finite() => vals[i] = v,
			_ => return fail(format!("map {map}: bad {key}")),
		}
	}
	let [cx0, cy0, nx, ny, c, swim, zstep] = vals;
	let x0 = cx0 * TILE;
	let y0 = cy0 * TILE;
	let cs = TILE / c;
	let (nx, ny, c) = (nx as i64, ny as i64, c as i64);
	let zone = find(text, b"\n\tzone = {", 0).map(|zs| {
		let ze = find(text, b"\n\t}", zs).unwrap_or(text.len().saturating_sub(1));
		let body = &text[zs..ze.max(zs)];
		let mut out: Vec<Option<Vec<u8>>> = Vec::new();
		// `\[(\d+)\] = "([^"]*)"`
		let mut i = 0;
		while i < body.len() {
			if body[i] == b'[' {
				let mut j = i + 1;
				while j < body.len() && body[j].is_ascii_digit() {
					j += 1;
				}
				if j > i + 1 && body.get(j..j + 5) == Some(b"] = \"") {
					let s = j + 5;
					if let Some(e) = body[s..].iter().position(|&b| b == b'"') {
						let idx: usize = std::str::from_utf8(&body[i + 1..j]).unwrap().parse().unwrap_or(0);
						if idx >= 1 {
							if out.len() < idx {
								out.resize(idx, None);
							}
							out[idx - 1] = Some(body[s..s + e].to_vec());
						}
						i = s + e + 1;
						continue;
					}
				}
			}
			i += 1;
		}
		out
	});
	let mut hubs = Vec::new();
	if let Some(hs) = find(text, b"\n\thubs = {", 0) {
		let he = find(text, b"\n\t}", hs).unwrap_or(text.len().saturating_sub(1));
		for line in text[hs..he.max(hs)].split(|&b| b == b'\n') {
			if let Some(h) = parse_hub(line) {
				hubs.push(h);
			}
		}
	}
	let mut counts = Vec::new();
	if let Some(p) = find(text, b"\n\tcounts = {", 0) {
		let s = p + b"\n\tcounts = {".len();
		if let Some(e) = text[s..].iter().position(|&b| b == b'}') {
			// `(\w+) = (\d+)`
			let body = &text[s..s + e];
			let mut i = 0;
			while i < body.len() {
				if is_word(body[i]) && (i == 0 || !is_word(body[i - 1])) {
					let mut j = i;
					while j < body.len() && is_word(body[j]) {
						j += 1;
					}
					if body.get(j..j + 3) == Some(b" = ") {
						let mut d = j + 3;
						while d < body.len() && body[d].is_ascii_digit() {
							d += 1;
						}
						if d > j + 3 {
							let name = String::from_utf8_lossy(&body[i..j]).into_owned();
							let v: u64 = std::str::from_utf8(&body[j + 3..d]).unwrap().parse().unwrap_or(0);
							if let Some(e) = counts.iter_mut().find(|(n, _): &&mut (String, u64)| *n == name) {
								e.1 = v;
							} else {
								counts.push((name, v));
							}
							i = d;
							continue;
						}
					}
					i = j;
					continue;
				}
				i += 1;
			}
		}
	}
	Ok(Meta { map, movement_identity, nx, ny, c, swim, zstep, x0, y0, cs, gx: nx * c, gy: ny * c, zone, hubs, counts, index: FxHashMap::default() })
}

/// scanPart's assembly state across part files (a field's blocks may continue in the next file).
#[derive(Default)]
pub struct Assembly {
	field: Option<String>,
	k: u32,
	next: u64,
}

fn word_at(s: &[u8], i: usize) -> Option<(String, usize)> {
	let mut j = i;
	while j < s.len() && is_word(s[j]) {
		j += 1;
	}
	(j > i).then(|| (String::from_utf8_lossy(&s[i..j]).into_owned(), j))
}
fn digits_at(s: &[u8], i: usize) -> Option<(u64, usize)> {
	let mut j = i;
	while j < s.len() && s[j].is_ascii_digit() {
		j += 1;
	}
	if j == i {
		return None;
	}
	Some((std::str::from_utf8(&s[i..j]).ok()?.parse().ok()?, j))
}

/// scanPart: index part file `part`'s packed blocks into meta.index.
/// `/data\.packed\.(\w+)\[(\d+)\] = \{|a = \{ field = "(\w+)", key = (\d+), next = 1|a\.blocks\[(\d+)\] = "/g`
pub fn scan_part(s: &[u8], part: u32, index: &mut FxHashMap<String, FxHashMap<u32, Vec<Span>>>, asm: &mut Assembly, name: &str) -> R<()> {
	let mut p = 0;
	while p < s.len() {
		let b = s[p];
		if b == b'd' && s[p..].starts_with(b"data.packed.") {
			if let Some((field, j)) = word_at(s, p + 12) {
				if s.get(j) == Some(&b'[') {
					if let Some((key, j2)) = digits_at(s, j + 1) {
						if s.get(j2..j2 + 5) == Some(b"] = {") {
							let start = j2 + 5;
							let Some(e) = s[start..].iter().position(|&c| c == b'}') else {
								return fail(format!("unterminated packed {field} in {name}"));
							};
							let end = start + e;
							index.entry(field).or_default().insert(key as u32 - 1, vec![Span { part, start, end }]);
							p = end;
							continue;
						}
					}
				}
			}
		}
		if b == b'a' {
			if s[p..].starts_with(b"a = { field = \"") {
				if let Some((field, j)) = word_at(s, p + 15) {
					if s.get(j..j + 9) == Some(b"\", key = ") {
						if let Some((key, j2)) = digits_at(s, j + 9) {
							if s.get(j2..j2 + 10) == Some(b", next = 1") {
								asm.field = Some(field.clone());
								asm.k = key as u32 - 1;
								asm.next = 1;
								index.entry(field).or_default().insert(asm.k, Vec::new());
								p = j2 + 10;
								continue;
							}
						}
					}
				}
			}
			if s[p..].starts_with(b"a.blocks[") {
				if let Some((n, j)) = digits_at(s, p + 9) {
					if s.get(j..j + 5) == Some(b"] = \"") {
						let field = asm.field.clone().unwrap_or_default();
						if n != asm.next {
							return fail(format!("missing or reordered {field}[{}] block {n} in {name}", asm.k + 1));
						}
						asm.next += 1;
						let start = j + 4;
						let end = match s[start + 1..].iter().position(|&c| c == b'"') {
							Some(e) => start + 1 + e + 1,
							None => 0,
						};
						index.entry(field).or_default().entry(asm.k).or_default().push(Span { part, start, end });
						p = end.max(p + 1);
						continue;
					}
				}
			}
		}
		p += 1;
	}
	Ok(())
}

/// Node's Buffer.from(s, 'base64'): the alphabet's (and the url-safe) symbols, stopping at '='.
pub fn base64(s: &[u8]) -> Vec<u8> {
	let mut out = Vec::with_capacity(s.len() * 3 / 4);
	let (mut acc, mut bits) = (0u32, 0u32);
	for &c in s {
		let v = match c {
			b'-' => 62,
			b'_' => 63,
			b'=' => break,
			_ => B64[c as usize] as i32,
		};
		if v < 0 {
			continue;
		}
		acc = (acc << 6) | v as u32;
		bits += 6;
		if bits >= 8 {
			bits -= 8;
			out.push((acc >> bits) as u8);
			acc &= (1 << bits) - 1;
		}
	}
	out
}

/// The quoted blocks of a span's bytes, each base64-decoded and inflated, concatenated.
pub fn inflate_blocks(buf: &[u8], out: &mut Vec<Vec<u8>>) -> R<()> {
	let mut i = 0;
	while let Some(a) = buf[i..].iter().position(|&c| c == b'"').map(|x| x + i) {
		let Some(b) = buf[a + 1..].iter().position(|&c| c == b'"').map(|x| x + a + 1) else { break };
		let raw = base64(&buf[a + 1..b]);
		let inflated = miniz_oxide::inflate::decompress_to_vec_zlib(&raw).map_err(|e| format!("inflate: {e:?}"))?;
		out.push(inflated);
		i = b + 1;
	}
	Ok(())
}

// ---- Motion.lua: the binary streams ----

struct Rd<'a> {
	b: &'a [u8],
	what: &'static str,
}
impl Rd<'_> {
	fn u8(&self, p: usize) -> R<u8> {
		self.b.get(p).copied().ok_or_else(|| format!("Path format4: truncated {}", self.what))
	}
	fn i8(&self, p: usize) -> R<i8> {
		Ok(self.u8(p)? as i8)
	}
	fn u16(&self, p: usize) -> R<u16> {
		let s = self.b.get(p..p + 2).ok_or_else(|| format!("Path format4: truncated {}", self.what))?;
		Ok(u16::from_le_bytes([s[0], s[1]]))
	}
	fn u32(&self, p: usize) -> R<u32> {
		let s = self.b.get(p..p + 4).ok_or_else(|| format!("Path format4: truncated {}", self.what))?;
		Ok(u32::from_le_bytes([s[0], s[1], s[2], s[3]]))
	}
	/// A finite float32.
	fn f32(&self, p: usize) -> R<f32> {
		let v = f32::from_bits(self.u32(p)?);
		if !v.is_finite() {
			return fail("nonfinite f32");
		}
		Ok(v)
	}
}

/// FNV-1a over n bytes of b at p.
fn fnv(b: &[u8], p: usize, n: usize) -> u32 {
	let mut h: u32 = 0x811c_9dc5;
	for i in 0..n {
		h = (h ^ b[p + i] as u32).wrapping_mul(16_777_619);
	}
	h
}

struct Motion {
	np: usize,
	ov_owner: Vec<u32>,
	ov_column: Vec<u16>,
	ov_layer: Vec<u8>,
	ov_kind: Vec<u8>,
	ov_to_column: Vec<u16>,
	ov_to_layer: Vec<u8>,
	ov_t: Vec<f32>,
	ov_z: Vec<f32>,
	p_owner: Vec<u32>,
	p_column: Vec<u16>,
	p_layer: Vec<u8>,
	p_z: Vec<f32>,
	path_off: Vec<u32>,
	pv_col: Vec<u16>,
	pv_layer: Vec<u8>,
	pv_z: Vec<f32>,
	a_from: Vec<u32>,
	a_to: Vec<u32>,
	a_dx: Vec<i8>,
	a_dy: Vec<i8>,
	a_kind: Vec<u8>,
	a_yards: Vec<f32>,
	a_cost: Vec<f32>,
	a_path: Vec<u32>,
	a_hash: Vec<u32>,
	i_dx: Vec<i8>,
	i_dy: Vec<i8>,
	i_ordinal: Vec<u32>,
	i_to: Vec<u32>,
	i_hash: Vec<u32>,
	inner: Vec<u32>,
}

/// Motion.Decode (PMM4), with its identity checks.
fn decode_motion(b: Option<&[u8]>) -> R<Motion> {
	let b = match b {
		Some(b) if b.len() >= 4 && &b[0..4] == b"PMM4" => b,
		_ => return fail("missing/bad PMM4 stream"),
	};
	let r = Rd { b, what: "PMM4" };
	let (no, np, nw, ne, ni) = (r.u32(4)? as usize, r.u32(8)? as usize, r.u32(12)? as usize, r.u32(16)? as usize, r.u32(20)? as usize);
	if (no as f64) * 20.0 + (np as f64) * 12.0 + (nw as f64) * 4.0 + ((ne + ni) as f64) * 36.0 > b.len() as f64 - 24.0 {
		return fail("motion counts/length overflow");
	}
	let mut p = 24usize;
	let need = |p: usize, n: usize| -> R<()> {
		if p + n > b.len() {
			fail("truncated PMM4")
		} else {
			Ok(())
		}
	};
	let mut m = Motion {
		np,
		ov_owner: Vec::with_capacity(no),
		ov_column: Vec::with_capacity(no),
		ov_layer: Vec::with_capacity(no),
		ov_kind: Vec::with_capacity(no),
		ov_to_column: Vec::with_capacity(no),
		ov_to_layer: Vec::with_capacity(no),
		ov_t: Vec::with_capacity(no),
		ov_z: Vec::with_capacity(no),
		p_owner: Vec::with_capacity(np),
		p_column: Vec::with_capacity(np),
		p_layer: Vec::with_capacity(np),
		p_z: Vec::with_capacity(np),
		path_off: vec![0; nw + 1],
		pv_col: Vec::new(),
		pv_layer: Vec::new(),
		pv_z: Vec::new(),
		a_from: Vec::with_capacity(ne),
		a_to: Vec::with_capacity(ne),
		a_dx: Vec::with_capacity(ne),
		a_dy: Vec::with_capacity(ne),
		a_kind: Vec::with_capacity(ne),
		a_yards: Vec::with_capacity(ne),
		a_cost: Vec::with_capacity(3 * ne),
		a_path: Vec::with_capacity(ne),
		a_hash: Vec::with_capacity(ne),
		i_dx: Vec::with_capacity(ni),
		i_dy: Vec::with_capacity(ni),
		i_ordinal: Vec::with_capacity(ni),
		i_to: Vec::with_capacity(ni),
		i_hash: Vec::with_capacity(ni),
		inner: Vec::new(),
	};
	for _ in 0..no {
		let owner = r.u32(p)?;
		let column = r.u16(p + 4)?;
		let layer = r.u8(p + 6)?;
		let kind = r.u8(p + 7)?;
		let to_column = r.u16(p + 8)?;
		let to_layer = r.u8(p + 10)?;
		if r.u8(p + 11)? != 0 {
			return fail("reserved byte");
		}
		let bits = r.u32(p + 12)?;
		let t = r.f32(p + 12)?;
		let z = r.f32(p + 16)?;
		if !((owner as i64) < STRIDE && layer <= 30 && to_layer <= 30) {
			return fail("override identity");
		}
		let tt = t as f64;
		if !(((kind == 0 || kind == 2) && column == to_column && layer == to_layer && bits == 0) || (kind == 1 && column != to_column && tt > 0.0 && tt < 1.0)) {
			return fail("override kind/support");
		}
		m.ov_owner.push(owner);
		m.ov_column.push(column);
		m.ov_layer.push(layer);
		m.ov_kind.push(kind);
		m.ov_to_column.push(to_column);
		m.ov_to_layer.push(to_layer);
		m.ov_t.push(t);
		m.ov_z.push(z);
		p += 20;
	}
	for _ in 0..np {
		let owner = r.u32(p)?;
		let column = r.u16(p + 4)?;
		let layer = r.u8(p + 6)?;
		if r.u8(p + 7)? != 0 {
			return fail("reserved byte");
		}
		let z = r.f32(p + 8)?;
		if layer > 30 {
			return fail("raw layer");
		}
		if (owner as i64) >= STRIDE {
			return fail("port owner");
		}
		m.p_owner.push(owner);
		m.p_column.push(column);
		m.p_layer.push(layer);
		m.p_z.push(z);
		p += 12;
	}
	for i in 0..nw {
		need(p, 4)?;
		let n = r.u32(p)? as usize;
		p += 4;
		if n > (b.len() - p) / 8 {
			return fail("count/length overflow");
		}
		for _ in 0..n {
			m.pv_col.push(r.u16(p)?);
			let layer = r.u8(p + 2)?;
			m.pv_layer.push(layer);
			if r.u8(p + 3)? != 0 {
				return fail("reserved byte");
			}
			if layer > 30 {
				return fail("raw layer");
			}
			m.pv_z.push(r.f32(p + 4)?);
			p += 8;
		}
		m.path_off[i + 1] = m.pv_col.len() as u32;
	}
	let arc_check = |q: usize| -> R<()> {
		need(q, 36)?;
		let dx = r.i8(q + 8)?;
		let dy = r.i8(q + 9)?;
		let kind = r.u8(q + 14)?;
		let path = r.u32(q + 32)?;
		if r.u8(q + 15)? != 0 {
			return fail("reserved byte");
		}
		if !(r.u32(q)? > 0 && (r.u32(q + 4)? as i64) < STRIDE && (r.u32(q + 10)? as i64) < STRIDE && dx.unsigned_abs() <= 1 && dy.unsigned_abs() <= 1) {
			return fail("motion arc identity");
		}
		if !(kind == 0 || kind == 1) {
			return fail("motion arc kind");
		}
		if !(r.f32(q + 16)? > 0.0 && r.f32(q + 20)? > 0.0 && r.f32(q + 24)? > 0.0 && r.f32(q + 28)? > 0.0) {
			return fail("nonpositive motion terms");
		}
		if !(path == 0 || (kind == 0 && dx == 0 && dy == 0)) {
			return fail("motion path ownership");
		}
		Ok(())
	};
	for i in 0..ne {
		arc_check(p)?;
		m.a_from.push(r.u32(p + 4)?);
		m.a_dx.push(r.i8(p + 8)?);
		m.a_dy.push(r.i8(p + 9)?);
		m.a_to.push(r.u32(p + 10)?);
		m.a_kind.push(r.u8(p + 14)?);
		m.a_yards.push(r.f32(p + 16)?);
		m.a_cost.push(r.f32(p + 20)?);
		m.a_cost.push(r.f32(p + 24)?);
		m.a_cost.push(r.f32(p + 28)?);
		let path = r.u32(p + 32)?;
		m.a_path.push(path);
		m.a_hash.push(fnv(b, p, 36));
		if !(r.u32(p)? as usize == i + 1 && path as usize <= nw) {
			return fail("outgoing ordinal/path");
		}
		p += 36;
	}
	for _ in 0..ni {
		arc_check(p)?;
		let dx = r.i8(p + 8)?;
		let dy = r.i8(p + 9)?;
		let ordinal = r.u32(p)?;
		m.i_dx.push(dx);
		m.i_dy.push(dy);
		m.i_ordinal.push(ordinal);
		m.i_to.push(r.u32(p + 10)?);
		m.i_hash.push(fnv(b, p, 36));
		if dx == 0 && dy == 0 {
			m.inner.push(ordinal - 1);
		}
		p += 36;
	}
	if p != b.len() {
		return fail("trailing PMM4 bytes");
	}
	Ok(m)
}

/// A cluster's entrance graph (PMG4) and its jump traces (PMT4).
#[derive(Debug, Default)]
pub struct Graph {
	pub rows: usize,
	pub row_node: Vec<u32>,
	pub row_comp: Vec<u32>,
	pub row_out: Vec<u32>,
	pub e_dx: Vec<i8>,
	pub e_dy: Vec<i8>,
	pub e_ent: Vec<u32>,
	pub e_cost: Vec<f32>,
	pub e_yards: Vec<f32>,
	pub e_jumps: Vec<u32>,
	pub e_trace: Vec<u32>,
	pub e_hash: Vec<u32>,
	pub row_in: Vec<u32>,
	pub in_dx: Vec<i8>,
	pub in_dy: Vec<i8>,
	pub in_ent: Vec<u32>,
	pub in_hash: Vec<u32>,
	pub trace_off: Vec<u32>,
	pub trace_val: Vec<u32>,
}

impl Graph {
	/// Its heap bytes (capacities), as the decode cache charges them.
	pub fn bytes(&self) -> usize {
		std::mem::size_of::<Graph>()
			+ heap!(self; row_node, row_comp, row_out, e_dx, e_dy, e_ent, e_cost, e_yards, e_jumps, e_trace, e_hash, row_in, in_dx, in_dy, in_ent, in_hash, trace_off, trace_val)
	}
	fn empty() -> Graph {
		Graph { row_out: vec![0], row_in: vec![0], trace_off: vec![0], ..Default::default() }
	}
}

/// Motion.Graph (PMG4) with its checks.
fn decode_graph4(b: Option<&[u8]>, g: &mut Graph) -> R<()> {
	let b = match b {
		Some(b) if b.len() >= 4 && &b[0..4] == b"PMG4" => b,
		_ => return fail("missing/bad PMG4 stream"),
	};
	let r = Rd { b, what: "PMG4" };
	let n = r.u32(4)? as usize;
	if n > (b.len() - 8) / 16 {
		return fail("count/length overflow");
	}
	if (n as i64) >= STRIDE {
		return fail("entrance count overflow");
	}
	let mut p = 8;
	g.rows = n;
	g.row_node = Vec::with_capacity(n);
	g.row_comp = Vec::with_capacity(n);
	g.row_out = vec![0; n + 1];
	g.row_in = vec![0; n + 1];
	let mut seen = FxHashSet::default();
	let (mut outs, mut ins) = (0u64, 0u64);
	for i in 0..n {
		let node = r.u32(p)?;
		g.row_node.push(node);
		g.row_comp.push(r.u32(p + 4)?);
		if (node as i64) >= STRIDE || !seen.insert(node) {
			return fail("duplicate/overflow entrance");
		}
		outs += r.u32(p + 8)? as u64;
		ins += r.u32(p + 12)? as u64;
		g.row_out[i + 1] = outs as u32;
		g.row_in[i + 1] = ins as u32;
		p += 16;
	}
	if (outs + ins) * 56 != (b.len() - p) as u64 {
		return fail("graph degrees/length");
	}
	let (outs, ins) = (outs as usize, ins as usize);
	let edge = |q: usize| -> R<u32> {
		let dx = r.i8(q)?;
		let dy = r.i8(q + 1)?;
		if r.u8(q + 2)? != 0 || r.u8(q + 3)? != 0 {
			return fail("reserved byte");
		}
		if !(dx.unsigned_abs() <= 1 && dy.unsigned_abs() <= 1 && (r.u32(q + 4)? as i64) < STRIDE) {
			return fail("graph edge identity");
		}
		for k in 0..3 {
			let o = q + 8 + 16 * k;
			let jumps = r.u32(o + 8)?;
			if !(r.f32(o)? > 0.0 && r.f32(o + 4)? > 0.0 && jumps < 4_294_967_295) {
				return fail("graph label");
			}
			if !(r.u32(o + 12)? > 0 || jumps == 0) {
				return fail("missing jump trace");
			}
		}
		Ok(fnv(b, q, 2) ^ fnv(b, q + 8, 48).wrapping_mul(31))
	};
	g.e_dx = Vec::with_capacity(outs);
	g.e_dy = Vec::with_capacity(outs);
	g.e_ent = Vec::with_capacity(outs);
	g.e_cost = Vec::with_capacity(3 * outs);
	g.e_yards = Vec::with_capacity(3 * outs);
	g.e_jumps = Vec::with_capacity(3 * outs);
	g.e_trace = Vec::with_capacity(3 * outs);
	g.e_hash = Vec::with_capacity(outs);
	for _ in 0..outs {
		g.e_hash.push(edge(p)?);
		g.e_dx.push(r.i8(p)?);
		g.e_dy.push(r.i8(p + 1)?);
		g.e_ent.push(r.u32(p + 4)?);
		for q in 0..3 {
			let o = p + 8 + 16 * q;
			g.e_cost.push(r.f32(o)?);
			g.e_yards.push(r.f32(o + 4)?);
			g.e_jumps.push(r.u32(o + 8)?);
			g.e_trace.push(r.u32(o + 12)?);
		}
		p += 56;
	}
	g.in_dx = Vec::with_capacity(ins);
	g.in_dy = Vec::with_capacity(ins);
	g.in_ent = Vec::with_capacity(ins);
	g.in_hash = Vec::with_capacity(ins);
	for _ in 0..ins {
		g.in_hash.push(edge(p)?);
		g.in_dx.push(r.i8(p)?);
		g.in_dy.push(r.i8(p + 1)?);
		g.in_ent.push(r.u32(p + 4)?);
		p += 56;
	}
	Ok(())
}

/// Motion.Traces (PMT4).
fn decode_traces(b: Option<&[u8]>, g: &mut Graph) -> R<()> {
	let b = match b {
		Some(b) if b.len() >= 4 && &b[0..4] == b"PMT4" => b,
		_ => return fail("missing/bad PMT4 stream"),
	};
	let r = Rd { b, what: "PMT4" };
	let n = r.u32(4)? as usize;
	if n > (b.len() - 8) / 4 {
		return fail("count/length overflow");
	}
	let mut p = 8;
	g.trace_off = vec![0; n + 1];
	g.trace_val = Vec::new();
	for i in 0..n {
		let len = r.u32(p)? as usize;
		p += 4;
		if len > (b.len() - p) / 4 {
			return fail("count/length overflow");
		}
		for _ in 0..len {
			let v = r.u32(p)?;
			if v == 0 {
				return fail("trace ordinal");
			}
			g.trace_val.push(v);
			p += 4;
		}
		g.trace_off[i + 1] = g.trace_val.len() as u32;
	}
	if p != b.len() {
		return fail("trailing PMT4 bytes");
	}
	Ok(())
}

// ---- PathGrid.lua's decoders ----

/// A node's step links while decoding: Lua's shared step-link sets (one layer's mask) or its own list.
#[derive(Clone)]
enum Link {
	None,
	Shared { layer: i32, mask: i32 },
	List(Vec<i32>),
}

fn shared_set(layer: i32, mask: i32) -> Link {
	if mask == 0 {
		Link::None
	} else {
		Link::Shared { layer, mask }
	}
}

fn link_list(l: &Link) -> Vec<i32> {
	match l {
		Link::None => Vec::new(),
		Link::Shared { layer, mask } => (0..8).filter(|d| (mask >> d) & 1 == 1).map(|d| d + 8 * (layer + 1)).collect(),
		Link::List(v) => v.clone(),
	}
}

fn add_link(links: &mut Vec<Link>, node: i64, d: i32, layer: i32) {
	if node < 0 {
		return;
	}
	let node = node as usize;
	if node >= links.len() {
		links.resize(node + 1, Link::None);
	}
	let l = &links[node];
	let shared_ok = match l {
		Link::None => true,
		Link::Shared { layer: s, .. } => *s == layer,
		Link::List(_) => false,
	};
	if (layer == -1 || layer == 1) && shared_ok {
		let mut mask = if let Link::Shared { mask, .. } = l { *mask } else { 0 };
		if mask.wrapping_shr(d as u32) & 1 == 0 {
			mask = mask.wrapping_add(1i32.wrapping_shl(d as u32));
		}
		links[node] = shared_set(layer, mask);
		return;
	}
	let v = d + 8 * (layer + 1);
	match &mut links[node] {
		Link::None => links[node] = Link::List(vec![v]),
		Link::Shared { .. } => {
			let mut list = link_list(&links[node]);
			list.push(v);
			links[node] = Link::List(list);
		}
		Link::List(list) => list.push(v),
	}
}

struct Dec {
	n_cells: usize,
	val: Vec<i32>,
	m: Vec<i32>,
	/// NaN where the JS array holds undefined.
	z: Vec<f64>,
	/// -1 where undefined.
	at: Vec<i64>,
	links: Vec<Link>,
	first: FxHashMap<i64, i64>,
	cls: Vec<i32>,
}

impl Dec {
	fn at(&self, i: i64) -> i64 {
		if i < 0 {
			-1
		} else {
			self.at.get(i as usize).copied().unwrap_or(-1)
		}
	}
	/// PathGrid.lua surface() while decoding.
	fn surface_of(&self, lc: i64, layer: i64, h: f64) -> Option<i64> {
		let f = self.first.get(&lc).copied();
		let val = |i: i64| self.val.get(i as usize).copied();
		if layer == 0 {
			return if val(lc).is_some_and(|v| v != 0) { Some(lc) } else { None };
		}
		if layer > 0 {
			let f = f?;
			let node = f + layer - 1;
			return if self.at(node) == lc { Some(node) } else { None };
		}
		let mut best = None;
		let mut gap: Option<f64> = None;
		if val(lc).is_some_and(|v| v != 0) {
			best = Some(lc);
			gap = Some((self.z[lc as usize] - h).abs());
		}
		if let Some(mut node) = f {
			while self.at(node) == lc {
				let d = (self.z[node as usize] - h).abs();
				if gap.is_none() || d < gap.unwrap() {
					best = Some(node);
					gap = Some(d);
				}
				node += 1;
			}
		}
		best
	}
}

fn decode_heights(c: usize, step: f64, d: &mut Dec, s: &[u8]) {
	let (mut pos, mut rep, mut delta, mut last) = (0usize, 0i64, 0f64, 0f64);
	for a in 0..c * c {
		if d.val[a] == 0 {
			continue;
		}
		let pred = if a % c > 0 && !d.z[a - 1].is_nan() {
			d.z[a - 1] / step
		} else if a >= c && !d.z[a - c].is_nan() {
			d.z[a - c] / step
		} else {
			last
		};
		let v;
		if rep > 0 {
			rep -= 1;
			v = pred + delta;
		} else {
			let sym = b64(s, pos);
			if sym == 47 {
				v = (num(s, pos + 1, 2) - 2048) as f64;
				pos += 3;
			} else {
				delta = (sym - 23) as f64;
				pos += 1;
				while pos < s.len() && b64(s, pos) >= 48 {
					rep += (b64(s, pos) - 47) as i64;
					pos += 1;
				}
				v = pred + delta;
			}
		}
		last = v;
		d.z[a] = v * step;
	}
}

fn decode_floors(c: usize, d: &mut Dec, s: Option<&[u8]>) {
	let Some(s) = s else { return };
	let n = c * c;
	let mut node = n;
	let mut pos = 3;
	let nf = num(s, 0, 3);
	for _ in 0..nf.max(0) {
		let lc = num(s, pos, 3) as i64;
		let count = b64(s, pos + 3);
		pos += 4;
		d.first.insert(lc, node as i64);
		for _ in 0..count.max(0) {
			let v = b64(s, pos);
			let z = (num(s, pos + 1, 2) - 2048) as f64;
			let link = shared_set(-1, num(s, pos + 3, 2));
			if d.val.len() <= node {
				d.val.resize(node + 1, 0);
				d.z.resize(node + 1, f64::NAN);
				d.at.resize(node + 1, -1);
			}
			d.val[node] = v;
			d.z[node] = z;
			d.at[node] = lc;
			if d.links.len() <= node {
				d.links.resize(node + 1, Link::None);
			}
			d.links[node] = link;
			pos += 5;
			node += 1;
		}
	}
	let last = node;
	let m = num(s, pos, 3);
	for _ in 0..m.max(0) {
		add_link(&mut d.links, num(s, pos + 3, 3) as i64, b64(s, pos + 6), b64(s, pos + 7));
		pos += 5;
	}
	// A base cell's links to floors inside the cluster are the reverse of the floors' own.
	let ci = c as i64;
	for f in n..last {
		let l = link_list(d.links.get(f).unwrap_or(&Link::None));
		let lc = d.at[f];
		let layer = f as i64 - d.first.get(&lc).copied().unwrap_or(0) + 1;
		for &le in &l {
			let dd = (le % 8) as usize;
			let tx = lc.div_euclid(ci) + DX[dd];
			let ty = lc % ci + DY[dd];
			if tx >= 0 && ty >= 0 && tx < ci && ty < ci {
				let t = d.surface_of(tx * ci + ty, (le / 8 - 1) as i64, d.z[f]);
				if let Some(t) = t {
					if t < (c * c) as i64 {
						add_link(&mut d.links, t, OPPOSITE[dd] as i32, layer as i32);
					}
				}
			}
		}
	}
}

fn decode_classes(s: &[u8], nodes: usize) -> Vec<i32> {
	let mut cls = Vec::with_capacity(nodes);
	let mut value = 0;
	for i in 0..s.len() {
		let sym = b64(s, i);
		if sym < 48 {
			value = sym;
			cls.push(value);
		} else {
			for _ in 48..=sym {
				cls.push(value);
			}
		}
	}
	while cls.len() < nodes {
		cls.push(0);
	}
	cls
}

/// A decoded cluster (pack.js's typed cluster).
#[derive(Debug, Default)]
pub struct Cluster {
	pub k: u32,
	pub n: usize,
	pub n0: usize,
	pub val: Vec<u8>,
	pub moves: Vec<u8>,
	pub z: Vec<f32>,
	pub cls: Vec<u8>,
	pub first_floor: Vec<i32>,
	pub at_cell: Vec<i32>,
	pub link_off: Vec<u32>,
	pub link_val: Vec<u8>,
	pub owner: Vec<i32>,
	pub over_kind: Vec<i8>,
	pub spec_idx: Vec<i32>,
	pub spec_x: Vec<f64>,
	pub spec_y: Vec<f64>,
	pub spec_z: Vec<f32>,
	pub spec_col: Vec<i32>,
	pub spec_layer: Vec<u8>,
	pub over_idx: Vec<i32>,
	pub ov_column: Vec<u16>,
	pub ov_layer: Vec<u8>,
	pub ov_to_column: Vec<u16>,
	pub ov_to_layer: Vec<u8>,
	pub path_off: Vec<u32>,
	pub pv_col: Vec<u16>,
	pub pv_layer: Vec<u8>,
	pub pv_z: Vec<f32>,
	pub a_hash: Vec<u32>,
	pub i_dx: Vec<i8>,
	pub i_dy: Vec<i8>,
	pub i_ordinal: Vec<u32>,
	pub i_hash: Vec<u32>,
	pub a_from: Vec<u32>,
	pub a_to: Vec<u32>,
	pub a_dx: Vec<i8>,
	pub a_dy: Vec<i8>,
	pub a_kind: Vec<u8>,
	pub a_yards: Vec<f32>,
	pub a_cost: Vec<f32>,
	pub a_path: Vec<u32>,
	pub out_off: Vec<u32>,
	pub out_idx: Vec<u32>,
	pub in_off: Vec<u32>,
	pub in_idx: Vec<u32>,
	/// Motion.Validate's incoming-row identities (router: inKeys), built on first use.
	pub in_keys: OnceLock<FxHashMap<i64, u32>>,
}

impl Cluster {
	/// Its heap bytes (capacities, and Motion.Validate's incoming-row table as hashbrown will hold it once built), as
	/// the decode cache charges them.
	pub fn bytes(&self) -> usize {
		let rows = self.i_ordinal.len();
		let in_keys = if rows == 0 { 0 } else { (rows * 8 / 7).next_power_of_two() * (16 + 1) };
		std::mem::size_of::<Cluster>()
			+ in_keys + heap!(self; val, moves, z, cls, first_floor, at_cell, link_off, link_val, owner, over_kind, spec_idx, spec_x, spec_y, spec_z, spec_col, spec_layer, over_idx, ov_column, ov_layer, ov_to_column, ov_to_layer, path_off, pv_col, pv_layer, pv_z, a_hash, i_dx, i_dy, i_ordinal, i_hash, a_from, a_to, a_dx, a_dy, a_kind, a_yards, a_cost, a_path, out_off, out_idx, in_off, in_idx)
	}
}

pub type ReadField<'a> = dyn FnMut(&str, u32) -> R<Option<Vec<u8>>> + 'a;

/// PathGrid.lua decodeGrid + Motion.Bind + filterMotionMoves for cluster k. None when the cluster has no grid.
pub fn decode_cluster(meta: &Meta, k: u32, read: &mut ReadField) -> R<Option<Cluster>> {
	let c = meta.c as usize;
	let step = meta.zstep;
	let Some(s) = read("grid", k)? else { return Ok(None) };
	let Some(height) = read("height", k)? else { return Ok(None) };
	let floors = read("floor", k)?;
	if meta.spans("floor", k).is_some() && floors.is_none() {
		return Ok(None);
	}
	let classes = read("class", k)?;
	let n = c * c;
	let mut d = Dec { n_cells: n, val: Vec::with_capacity(n + 64), m: Vec::with_capacity(n), z: Vec::new(), at: Vec::new(), links: Vec::new(), first: FxHashMap::default(), cls: Vec::new() };
	let (mut value_code, mut move_code) = (0i32, 0i32);
	for i in 0..s.len() {
		let sym = b64(&s, i);
		if sym < 48 {
			value_code = sym >> 4;
			move_code = (sym % 16) * 16;
			d.val.push(value_code);
			d.m.push(move_code);
		} else {
			for _ in 48..=sym {
				d.val.push(value_code);
				d.m.push(move_code);
			}
		}
	}
	if d.val.len() != n {
		return fail(format!("cluster {k}: grid holds {} cells, not {n}", d.val.len()));
	}
	d.z = vec![f64::NAN; n];
	d.at = vec![-1; n];
	decode_heights(c, step, &mut d, &height);
	let straight = meta.cs * WALK_TAN + SLOPE_EPS;
	let diagonal = meta.cs * std::f64::consts::SQRT_2 * WALK_TAN + SLOPE_EPS;
	{
		let (val, m, z) = (&d.val, &mut d.m, &d.z);
		for a in (0..n).rev() {
			let ly = a % c;
			let f = m[a] / 16;
			if val[a] != 0 {
				if a + c < n && val[a + c] != 0 && f % 2 == 0 && (z[a + c] - z[a]).abs() <= straight {
					m[a] += 1;
				}
				if ly < c - 1 && val[a + 1] != 0 && f % 4 < 2 && (z[a + 1] - z[a]).abs() <= straight {
					m[a] += 2;
				}
			}
			if a + c < n && val[a] != 0 {
				if ly < c - 1 && val[a + c + 1] != 0 && (z[a + c + 1] - z[a]).abs() <= diagonal && ((m[a] % 2 == 1 && m[a + c] % 4 >= 2) || (m[a] % 4 >= 2 && m[a + 1] % 2 == 1) || f % 8 >= 4) {
					m[a] += 4;
				}
				if ly > 0
					&& val[a + c - 1] != 0
					&& (z[a + c - 1] - z[a]).abs() <= diagonal
					&& ((m[a] % 2 == 1 && m[a + c - 1] % 4 >= 2)
						|| (val[a - 1] != 0 && m[a - 1] % 64 < 32 && m[a - 1] % 32 < 16 && (z[a] - z[a - 1]).abs() <= straight && (z[a + c - 1] - z[a - 1]).abs() <= straight)
						|| f >= 8)
				{
					m[a] += 8;
				}
			}
		}
	}
	decode_floors(c, &mut d, floors.as_deref());
	let n0 = d.val.len();
	d.cls = match &classes {
		Some(cl) => decode_classes(cl, n0),
		None => vec![0; n0],
	};
	d.cls.truncate(n0);
	d.at.resize(n0, -1);
	d.z.resize(n0, f64::NAN);
	let motion = read("motion", k)?;
	let mo = decode_motion(motion.as_deref())?;
	let mut c = bind(meta, k, d, n0, mo)?;
	shrink!(c; link_val, spec_x, spec_y, spec_z, spec_col, spec_layer, pv_col, pv_layer, pv_z, moves);
	Ok(Some(c))
}

/// Motion.Bind (with its raw-identity, interpolant and ownership checks), then filterMotionMoves, then the typed
/// cluster.
fn bind(meta: &Meta, k: u32, mut d: Dec, n0: usize, mo: Motion) -> R<Cluster> {
	let (ci, ny, nx, x0, y0, cs) = (meta.c, meta.ny, meta.nx, meta.x0, meta.y0, meta.cs);
	let cf = ci as f64;
	let nn = d.n_cells;
	let n = n0 + mo.np;
	if n as i64 >= STRIDE {
		return fail("local node count overflow");
	}
	let kx = k as i64 / ny;
	let ky = k as i64 % ny;
	let raw_xy = |column: i64| -> (f64, f64) {
		let j = column / 256;
		let i = column % 256;
		(x0 + (kx as f64 + (255.5 - j as f64) / 256.0) * (1600.0 / 3.0), y0 + (ky as f64 + (255.5 - i as f64) / 256.0) * (1600.0 / 3.0))
	};
	let owner_cell = |d: &Dec, owner: i64| -> R<i64> {
		if !(owner >= 0 && (owner as usize) < n0 && d.val.get(owner as usize).is_some_and(|&v| v != 0)) {
			return fail("unpopulated motion owner");
		}
		Ok(if (owner as usize) < nn { owner } else { d.at[owner as usize] })
	};
	struct Raw {
		owner: i64,
		z: f64,
		node: Option<i64>,
	}
	let mut raw_map: FxHashMap<i64, Raw> = FxHashMap::default();
	let raw = |d: &Dec, raw_map: &mut FxHashMap<i64, Raw>, column: i64, layer: i64, rz: f64, owner: i64, node: Option<i64>| -> R<()> {
		let cell = owner_cell(d, owner)?;
		let j = column / 256;
		let i = column % 256;
		if (((255.5 - j as f64) * cf) / 256.0).floor() as i64 * ci + (((255.5 - i as f64) * cf) / 256.0).floor() as i64 != cell {
			return fail("raw entry outside owner cell");
		}
		let key = column * 31 + layer;
		match raw_map.get_mut(&key) {
			Some(prior) => {
				if !(prior.owner == owner && prior.z == rz && (node.is_none() || prior.node.is_none())) {
					return fail("duplicate/inconsistent raw identity");
				}
				if node.is_some() {
					prior.node = node;
				}
			}
			None => {
				raw_map.insert(key, Raw { owner, z: rz, node });
			}
		}
		Ok(())
	};
	let mut owner = vec![-1i32; n];
	let mut over_kind = vec![-1i8; n];
	let mut over_idx = vec![-1i32; n];
	let mut spec_idx = vec![-1i32; n];
	let (mut sx, mut sy, mut sz, mut scol, mut slay) = (Vec::<f64>::new(), Vec::<f64>::new(), Vec::<f64>::new(), Vec::<i32>::new(), Vec::<u8>::new());
	let mut spec = |spec_idx: &mut Vec<i32>, node: usize, x: f64, y: f64, zz: f64, col: i32, lay: u8| {
		if spec_idx[node] < 0 {
			spec_idx[node] = sx.len() as i32;
			sx.push(x);
			sy.push(y);
			sz.push(zz);
			scol.push(col);
			slay.push(lay);
		} else {
			let s = spec_idx[node] as usize;
			sx[s] = x;
			sy[s] = y;
			sz[s] = zz;
			scol[s] = col;
			slay[s] = lay;
		}
	};
	let no = mo.ov_owner.len();
	for i in 0..no {
		let o = mo.ov_owner[i] as i64;
		owner_cell(&d, o)?;
		if over_idx[o as usize] >= 0 {
			return fail("duplicate owner override");
		}
		over_idx[o as usize] = i as i32;
		over_kind[o as usize] = mo.ov_kind[i] as i8;
		if mo.ov_kind[i] == 0 || mo.ov_kind[i] == 2 {
			raw(&d, &mut raw_map, mo.ov_column[i] as i64, mo.ov_layer[i] as i64, mo.ov_z[i] as f64, o, Some(o))?;
		}
	}
	for i in 0..mo.np {
		let node = n0 + i;
		let o = mo.p_owner[i] as i64;
		raw(&d, &mut raw_map, mo.p_column[i] as i64, mo.p_layer[i] as i64, mo.p_z[i] as f64, o, Some(node as i64))?;
		owner[node] = o as i32;
		let vo = d.val[o as usize];
		d.val.push(vo);
		d.z.push(mo.p_z[i] as f64);
		let co = d.cls.get(o as usize).copied().unwrap_or(0);
		d.cls.push(co);
		let (x, y) = raw_xy(mo.p_column[i] as i64);
		spec(&mut spec_idx, node, x, y, mo.p_z[i] as f64, mo.p_column[i] as i32, mo.p_layer[i]);
	}
	for i in 0..no {
		let o = mo.ov_owner[i] as i64;
		let (x, y);
		let kind = mo.ov_kind[i];
		let col = mo.ov_column[i] as i64;
		if kind == 0 || kind == 2 {
			(x, y) = raw_xy(col);
			if kind == 2 {
				let cell = owner_cell(&d, o)?;
				let jn = 511 * ci - 256 * (2 * (cell / ci) + 1);
				let in_ = 511 * ci - 256 * (2 * (cell % ci) + 1);
				if !(jn == (col / 256) * 2 * ci && in_ == (col % 256) * 2 * ci) {
					return fail("coincident raw interface is not at centre");
				}
			}
		} else {
			let to_col = mo.ov_to_column[i] as i64;
			let a = raw_map.get(&(col * 31 + mo.ov_layer[i] as i64));
			let b = raw_map.get(&(to_col * 31 + mo.ov_to_layer[i] as i64));
			let (a, b) = match (a, b) {
				(Some(a), Some(b)) if a.node.is_some() && b.node.is_some() && a.owner == o && b.owner == o => (a, b),
				_ => return fail("interpolant missing same-owner support"),
			};
			let (aj, ai, bj, bi) = (col / 256, col % 256, to_col / 256, to_col % 256);
			let (dj, di) = (bj - aj, bi - ai);
			if !(dj.abs() <= 1 && di.abs() <= 1 && (dj != 0 || di != 0)) {
				return fail("non-neighbor interpolant support");
			}
			let cell = owner_cell(&d, o)?;
			let jn = 511 * ci - 256 * (2 * (cell / ci) + 1);
			let in_ = 511 * ci - 256 * (2 * (cell % ci) + 1);
			let rj = jn - aj * 2 * ci;
			let ri = in_ - ai * 2 * ci;
			if rj * di != ri * dj {
				return fail("centre not on retained support link");
			}
			let t = if dj != 0 { rj as f64 / (2 * ci * dj) as f64 } else { ri as f64 / (2 * ci * di) as f64 };
			if !(t > 0.0 && t < 1.0 && t as f32 == mo.ov_t[i] && ((1.0 - t) * a.z + t * b.z) as f32 == mo.ov_z[i]) {
				return fail("interpolant float32 encoding");
			}
			x = x0 + ((kx * ci + cell / ci) as f64 + 0.5) * cs;
			y = y0 + ((ky * ci + cell % ci) as f64 + 0.5) * cs;
		}
		d.z[o as usize] = mo.ov_z[i] as f64;
		spec(&mut spec_idx, o as usize, x, y, mo.ov_z[i] as f64, if kind != 1 { col as i32 } else { -1 }, mo.ov_layer[i]);
	}
	let ne = mo.a_from.len();
	{
		let local_node = |d: &Dec, node: u32| -> R<()> {
			if !((node as usize) < n && d.val.get(node as usize).is_some_and(|&v| v != 0)) {
				return fail("invalid local motion node");
			}
			Ok(())
		};
		for i in 0..ne {
			local_node(&d, mo.a_from[i])?;
			if mo.a_dx[i] == 0 && mo.a_dy[i] == 0 {
				local_node(&d, mo.a_to[i])?;
			}
			let p = mo.a_path[i] as usize;
			if p > 0 {
				let from = mo.a_from[i] as usize;
				let to = mo.a_to[i] as usize;
				let o = if owner[from] >= 0 { owner[from] as i64 } else { from as i64 };
				let ot = match owner.get(to) {
					Some(&w) if w >= 0 => w as i64,
					_ => to as i64,
				};
				if ot != o {
					return fail("connector crosses owner pieces");
				}
				for v in mo.path_off[p - 1] as usize..mo.path_off[p] as usize {
					raw(&d, &mut raw_map, mo.pv_col[v] as i64, mo.pv_layer[v] as i64, mo.pv_z[v] as f64, o, None)?;
				}
			}
		}
		let mut seen_in = FxHashSet::default();
		for i in 0..mo.i_to.len() {
			local_node(&d, mo.i_to[i])?;
			let x = kx - mo.i_dx[i] as i64;
			let y = ky - mo.i_dy[i] as i64;
			if !(x >= 0 && y >= 0 && x < nx && y < ny) {
				return fail("cluster coordinate wrap");
			}
			let key = (x * ny + y) * STRIDE + mo.i_ordinal[i] as i64;
			if !seen_in.insert(key) {
				return fail("duplicate incoming motion row");
			}
		}
	}
	// filterMotionMoves: the legacy mask filtered at the effective geometry.
	if no > 0 {
		let z = &d.z;
		let m = &mut d.m;
		let safe = |a: usize, b: usize| -> bool {
			if over_kind[a] == 0 || over_kind[b] == 0 {
				return false;
			}
			let dx = (b / ci as usize) as i64 - (a / ci as usize) as i64;
			let dy = (b % ci as usize) as i64 - (a % ci as usize) as i64;
			(z[b] - z[a]).abs() <= cs * ((dx * dx + dy * dy) as f64).sqrt() * WALK_TAN + SLOPE_EPS
		};
		let c = ci as usize;
		let orth = |m: &Vec<i32>, a: usize, b: usize| -> bool {
			let (a, b) = if a > b { (b, a) } else { (a, b) };
			let bit = if b - a == c { 1 } else { 2 };
			(m[a].div_euclid(bit)) % 2 == 1 && safe(a, b)
		};
		for a in (0..nn).rev() {
			let old = m[a] % 16;
			let flags = m[a].div_euclid(16);
			let mut mask = 0;
			if old % 2 == 1 && safe(a, a + c) {
				mask += 1;
			}
			if old % 4 >= 2 && safe(a, a + 1) {
				mask += 2;
			}
			m[a] = flags * 16 + mask;
			if old % 8 >= 4 && safe(a, a + c + 1) && (flags % 8 >= 4 || (orth(m, a, a + c) && orth(m, a + c, a + c + 1)) || (orth(m, a, a + 1) && orth(m, a + 1, a + c + 1))) {
				m[a] += 4;
			}
			if old >= 8 && safe(a, a + c - 1) && (flags >= 8 || (orth(m, a, a + c) && orth(m, a + c - 1, a + c)) || (orth(m, a - 1, a) && orth(m, a - 1, a + c - 1))) {
				m[a] += 8;
			}
		}
	}
	// Typed arrays.
	let mut t_val = vec![0u8; n];
	let mut t_z = vec![f32::NAN; n];
	let mut t_cls = vec![0u8; n];
	let mut at_cell = vec![-1i32; n];
	for i in 0..n {
		t_val[i] = d.val.get(i).copied().unwrap_or(0) as u8;
		if let Some(&zz) = d.z.get(i) {
			if !zz.is_nan() {
				t_z[i] = zz as f32;
			}
		}
		t_cls[i] = d.cls.get(i).copied().unwrap_or(0) as u8;
		if let Some(&a) = d.at.get(i) {
			if a >= 0 {
				at_cell[i] = a as i32;
			}
		}
	}
	let mut first_floor = vec![-1i32; nn];
	for (&lc, &f) in &d.first {
		if lc >= 0 && (lc as usize) < nn {
			first_floor[lc as usize] = f as i32;
		}
	}
	let mut link_off = vec![0u32; n + 1];
	let mut link_val = Vec::new();
	for i in 0..n {
		if let Some(l) = d.links.get(i) {
			for x in link_list(l) {
				link_val.push(x as u8);
			}
		}
		link_off[i + 1] = link_val.len() as u32;
	}
	let csr = |keys: &mut dyn Iterator<Item = (usize, u32)>| -> (Vec<u32>, Vec<u32>) {
		let list: Vec<(usize, u32)> = keys.filter(|&(key, _)| key < n).collect();
		let mut off = vec![0u32; n + 1];
		for &(key, _) in &list {
			off[key + 1] += 1;
		}
		for i in 0..n {
			off[i + 1] += off[i];
		}
		let mut fill = off[..n].to_vec();
		let mut idx = vec![0u32; off[n] as usize];
		for &(key, i) in &list {
			idx[fill[key] as usize] = i;
			fill[key] += 1;
		}
		(off, idx)
	};
	let (out_off, out_idx) = csr(&mut (0..ne).map(|i| (mo.a_from[i] as usize, i as u32)));
	let (in_off, in_idx) = csr(&mut mo.inner.iter().filter(|&&i| (i as usize) < ne).map(|&i| (mo.a_to[i as usize] as usize, i)));
	Ok(Cluster {
		k,
		n,
		n0,
		val: t_val,
		moves: d.m.iter().map(|&v| v as u8).collect(),
		z: t_z,
		cls: t_cls,
		first_floor,
		at_cell,
		link_off,
		link_val,
		owner,
		over_kind,
		spec_idx,
		spec_x: sx,
		spec_y: sy,
		spec_z: sz.iter().map(|&v| v as f32).collect(),
		spec_col: scol,
		spec_layer: slay,
		over_idx,
		ov_column: mo.ov_column,
		ov_layer: mo.ov_layer,
		ov_to_column: mo.ov_to_column,
		ov_to_layer: mo.ov_to_layer,
		path_off: mo.path_off,
		pv_col: mo.pv_col,
		pv_layer: mo.pv_layer,
		pv_z: mo.pv_z,
		a_hash: mo.a_hash,
		i_dx: mo.i_dx,
		i_dy: mo.i_dy,
		i_ordinal: mo.i_ordinal,
		i_hash: mo.i_hash,
		a_from: mo.a_from,
		a_to: mo.a_to,
		a_dx: mo.a_dx,
		a_dy: mo.a_dy,
		a_kind: mo.a_kind,
		a_yards: mo.a_yards,
		a_cost: mo.a_cost,
		a_path: mo.a_path,
		out_off,
		out_idx,
		in_off,
		in_idx,
		in_keys: OnceLock::new(),
	})
}

/// PathGrid.lua decodeGraph for format 4: the entrance rows (nodes checked against the cluster) and the traces.
pub fn decode_graph(k: u32, read: &mut ReadField, cluster: Option<&Cluster>) -> R<Graph> {
	let g = read("graph", k)?;
	let Some(cluster) = cluster else {
		if g.is_some() {
			return fail("graph on empty cluster");
		}
		return Ok(Graph::empty());
	};
	let mut graph = Graph::default();
	decode_graph4(g.as_deref(), &mut graph)?;
	let t = read("motionTrace", k)?;
	decode_traces(t.as_deref(), &mut graph)?;
	for t in 0..graph.trace_off.len() - 1 {
		if graph.trace_off[t + 1] == graph.trace_off[t] {
			return fail("empty trace must use pointer zero");
		}
		for i in graph.trace_off[t]..graph.trace_off[t + 1] {
			if graph.trace_val[i as usize] as usize > cluster.a_from.len() {
				return fail("trace ordinal outside source cluster");
			}
		}
	}
	for i in 0..graph.rows {
		let node = graph.row_node[i] as usize;
		if !(node < cluster.n && cluster.val[node] != 0) {
			return fail("invalid entrance local node");
		}
	}
	shrink!(graph; trace_val);
	Ok(graph)
}
