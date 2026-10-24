//! Port of tools/lib/pack/importstring.js.
//! Adler-32 and the zlib framing adapted from Factoruide (https://github.com/brouznouf/factoruide,
//! fg-route export/polestar/mod.rs: import_string, adler32), MIT, used with its author's permission.
//!
//! Import strings (docs/PACK_FORMAT.md, "Import strings"): one compiled guide
//! as one line of text a player pastes into Polestar's Import page, no addon
//! to install.
//!
//!   !PS1!<checksum>!<body>
//!
//! `PS1` is the string format; a later one gets another number so old strings
//! keep their meaning. <checksum> is the Adler-32 of the payload as 8
//! lower-case hex digits. <body> is the payload compressed with zlib and
//! written in base64 (A-Z a-z 0-9 + / and = padding). The payload is JSON:
//!
//!   { "format": 3, "license": "CC-BY-4.0", "guide": { ... }, "frames": { "1429": { ... } } }
//!
//! `guide` is the compiled guide as emit.rs writes it into Guides.lua
//! (guide_data: the same keys, numbers rounded the same way, no `pack`);
//! `frames` the Era map frames its goals use (as MapFrames.lua), left out
//! when none. The addon reads it as data only: Core/Import.lua parses the JSON
//! itself, builds the guide field by field from a fixed set of keys and hands
//! it to the registry's checks. Nothing in a string is ever run.
//!
//! Compression: zlib-rs through flate2 (level 9), whose output equals node's
//! zlib.deflateSync (zlib-ng 1.3.1) byte for byte; miniz_oxide's does not.

use crate::data::Data;
use crate::emit::{frames_data, guide_data, is_js_space};
use crate::format::{format_for, RESERVED_IDS};
use crate::js::{stringify, Obj, V};
use std::io::Write;

pub const PREFIX: &str = "!PS1!";

/// The caps the addon applies too (Core/Import.lua, Import.LIMITS; a test
/// holds the two equal): the whole string, the steps of its guide, the
/// payload once decompressed (bytes), and any one text or object key in it
/// (bytes).
pub struct Limits {
	pub length: usize,
	pub steps: usize,
	pub payload: usize,
	pub text: usize,
	pub names: usize,
	pub goals: usize,
	pub candidates: usize,
}

pub const LIMITS: Limits = Limits { length: 50000, steps: 60, payload: 262144, text: 4096, names: 128, goals: 100, candidates: 128 };

/// The first text or key in v longer than LIMITS.text, as the addon names it
/// (`guide.steps[2].note`), or None.
fn long_text(v: &V, where_: &str) -> Option<String> {
	// names/written map values are capped at LIMITS.names, not LIMITS.text.
	let cap = if where_.starts_with("guide.names.") || where_.starts_with("guide.written.") { LIMITS.names } else { LIMITS.text };
	match v {
		V::Str(s) => (s.len() > cap).then(|| where_.to_string()),
		V::Arr(_) => {
			for (i, x) in v.items().iter().enumerate() {
				if let Some(hit) = long_text(x, &format!("{where_}[{}]", i + 1)) {
					return Some(hit);
				}
			}
			None
		}
		V::Obj(o) => {
			for (k, x) in o.entries() {
				let at = if where_.is_empty() { k.to_string() } else { format!("{where_}.{k}") };
				if k.len() > LIMITS.text {
					return Some(where_.to_string());
				}
				if let Some(hit) = long_text(&x, &at) {
					return Some(hit);
				}
			}
			None
		}
		_ => None,
	}
}

pub fn adler32(buf: &[u8]) -> u32 {
	let mut a: u32 = 1;
	let mut b: u32 = 0;
	for &x in buf {
		a = (a + x as u32) % 65521;
		b = (b + a) % 65521;
	}
	(b << 16) | a
}

fn hex8(n: u32) -> String {
	format!("{n:08x}")
}

const B64: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

fn base64_encode(data: &[u8]) -> String {
	let mut out = String::with_capacity(data.len().div_ceil(3) * 4);
	for c in data.chunks(3) {
		let n = (c[0] as u32) << 16 | (*c.get(1).unwrap_or(&0) as u32) << 8 | *c.get(2).unwrap_or(&0) as u32;
		out.push(B64[(n >> 18) as usize & 63] as char);
		out.push(B64[(n >> 12) as usize & 63] as char);
		out.push(if c.len() > 1 { B64[(n >> 6) as usize & 63] as char } else { '=' });
		out.push(if c.len() > 2 { B64[n as usize & 63] as char } else { '=' });
	}
	out
}

/// `Buffer.from(s, 'base64')`: lenient, stops at padding, drops a trailing partial byte.
fn base64_decode(s: &str) -> Vec<u8> {
	let mut out = Vec::with_capacity(s.len() * 3 / 4);
	let (mut acc, mut bits) = (0u32, 0u32);
	for ch in s.bytes() {
		if ch == b'=' {
			break;
		}
		let Some(v) = B64.iter().position(|&c| c == ch) else { continue };
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

fn deflate(bytes: &[u8]) -> Vec<u8> {
	let mut e = flate2::write::ZlibEncoder::new(Vec::new(), flate2::Compression::new(9));
	e.write_all(bytes).expect("deflate into memory");
	e.finish().expect("deflate into memory")
}

/// `zlib.inflateSync(input, { maxOutputLength })`: None when damaged, incomplete or too big.
fn inflate(input: &[u8], max: usize) -> Option<Vec<u8>> {
	use flate2::{Decompress, FlushDecompress, Status};
	let mut d = Decompress::new(true);
	let mut out: Vec<u8> = Vec::with_capacity(input.len().saturating_mul(4).clamp(64, max + 1));
	loop {
		if out.len() == out.capacity() {
			if out.len() > max {
				return None;
			}
			out.reserve((out.capacity()).min(max + 1 - out.len()).max(1));
		}
		let before_in = d.total_in();
		let before_out = d.total_out();
		let status = d.decompress_vec(&input[d.total_in() as usize..], &mut out, FlushDecompress::Finish).ok()?;
		if out.len() > max {
			return None;
		}
		match status {
			Status::StreamEnd => return Some(out),
			_ => {
				let progressed = d.total_in() != before_in || d.total_out() != before_out;
				if !progressed && out.len() < out.capacity() {
					return None;
				}
			}
		}
	}
}

/// payload: { format, license, guide, frames? } -> the string.
pub fn encode_import(payload: &V) -> String {
	let json = stringify(payload, None);
	let bytes = json.as_bytes();
	format!("{PREFIX}{}!{}", hex8(adler32(bytes)), base64_encode(&deflate(bytes)))
}

/// The string -> its payload; Err says what is wrong. For the tools and
/// tests; the addon has its own reader. (A payload that is not JSON gives
/// this crate's JSON parser message, not V8's SyntaxError.)
pub fn decode_import(text: &str) -> Result<V, String> {
	let s: String = text.chars().filter(|c| !is_js_space(*c)).collect();
	if !s.starts_with(PREFIX) {
		return Err(format!("not a Polestar import string: it starts with {PREFIX}"));
	}
	// /^!PS1!([0-9a-f]{8})!([A-Za-z0-9+/]+={0,2})$/
	let rest = &s[PREFIX.len()..];
	let damaged = || "the string is damaged".to_string();
	let (sum, body) = rest.split_once('!').ok_or_else(damaged)?;
	if sum.len() != 8 || !sum.bytes().all(|c| c.is_ascii_digit() || (b'a'..=b'f').contains(&c)) {
		return Err(damaged());
	}
	let core = body.trim_end_matches('=');
	if core.is_empty() || body.len() - core.len() > 2 || !core.bytes().all(|c| c.is_ascii_alphanumeric() || c == b'+' || c == b'/') {
		return Err(damaged());
	}
	let bytes = inflate(&base64_decode(body), LIMITS.payload).ok_or_else(|| "the string is damaged or incomplete".to_string())?;
	if hex8(adler32(&bytes)) != sum {
		return Err("the string is damaged: its checksum does not match".into());
	}
	crate::js::parse_json(&String::from_utf8_lossy(&bytes))
}

/// One compiled guide of a pack (build_pack's guides; manifest its pack.json,
/// data its reference data) as an import string. -> Ok((text, steps)) or
/// Err(error) when the guide cannot go in one: one of Polestar's own guides,
/// too many steps, a text longer than the addon reads, or a string or payload
/// bigger than it reads. `manifest`: Undef/Null for none.
pub fn import_string(guide: &V, manifest: &V, data: Option<&Data>) -> Result<(String, usize), String> {
	let id = guide.get("id").to_js_string();
	let prefix = id.split('/').next().unwrap_or("");
	if !manifest.truthy() || manifest.get("id").as_str() == Some("guides") || RESERVED_IDS.contains(&prefix) {
		return Err(format!("{id} is one of Polestar's own guides; an import string carries a community guide, under its pack's id"));
	}
	let steps = guide.get("steps").len();
	if steps > LIMITS.steps {
		return Err(format!("{id} has {steps} steps; an import string holds a guide of {} steps at most (a longer guide goes in a community addon: forge release pack)", LIMITS.steps));
	}
	let localised = guide.hidden("_localised");
	let source = if localised.truthy() { localised } else { guide.clone() };
	let payload = Obj::new();
	payload.set("format", format_for(std::slice::from_ref(guide)));
	payload.set("license", manifest.get("license"));
	payload.set("guide", guide_data(&source));
	let frames = match data {
		Some(d) => frames_data(&crate::project::referenced_frames(std::slice::from_ref(guide), d)),
		None => V::obj(),
	};
	if !frames.keys().is_empty() {
		payload.set("frames", frames);
	}
	let payload = V::Obj(payload);
	if let Some(long) = long_text(&payload, "") {
		return Err(format!("{id}: {long} is longer than {} bytes, the most Polestar reads in one text of an import string", LIMITS.text));
	}
	let bytes = stringify(&payload, None).len();
	if bytes > LIMITS.payload {
		return Err(format!("{id} holds {bytes} bytes of guide data; Polestar reads {} at most (a guide this big goes in a community addon: forge release pack)", LIMITS.payload));
	}
	let text = encode_import(&payload);
	if text.len() > LIMITS.length {
		return Err(format!("{id} makes a string of {} characters; Polestar reads {} at most (a guide this big goes in a community addon: forge release pack)", text.len(), LIMITS.length));
	}
	Ok((text, steps))
}

/// packImporter(built)(id): the import string of the guide `id` among the
/// community pack's built guides, for the playground's Copy import string.
pub fn pack_import(guides: &[V], manifest: &V, data: Option<&Data>, id: &str) -> Result<(String, usize), String> {
	let Some(guide) = guides.iter().find(|g| g.get("id").as_str() == Some(id)) else {
		return Err(format!("{id} is not one of the community pack's guides"));
	};
	import_string(guide, manifest, data)
}
