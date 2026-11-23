//! Binary data files (port of tools/lib/sim/binfile.js): `'PSBN'`, u32 version 1, u32 header bytes,
//! the header JSON, zero padding to 8, then each section's bytes at its offset (8-aligned).
//! The header carries `contentId` (sha1 hex of the sections' bytes and the header without it) and
//! `sections` (`{ name: [type, offset, length] }`). Sections are little-endian typed arrays.

use serde_json::{Map, Value};

const MAGIC: u32 = 0x4e42_5350; // 'PSBN' little-endian
const VERSION: u32 = 1;

/// A section's element type, as binfile.js names it.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Kind {
	I8,
	U8,
	I16,
	U16,
	I32,
	U32,
	F32,
	F64,
}

impl Kind {
	pub fn name(self) -> &'static str {
		match self {
			Kind::I8 => "Int8Array",
			Kind::U8 => "Uint8Array",
			Kind::I16 => "Int16Array",
			Kind::U16 => "Uint16Array",
			Kind::I32 => "Int32Array",
			Kind::U32 => "Uint32Array",
			Kind::F32 => "Float32Array",
			Kind::F64 => "Float64Array",
		}
	}
	pub fn of(name: &str) -> Option<Kind> {
		Some(match name {
			"Int8Array" => Kind::I8,
			"Uint8Array" => Kind::U8,
			"Int16Array" => Kind::I16,
			"Uint16Array" => Kind::U16,
			"Int32Array" => Kind::I32,
			"Uint32Array" => Kind::U32,
			"Float32Array" => Kind::F32,
			"Float64Array" => Kind::F64,
			_ => return None,
		})
	}
	pub fn size(self) -> usize {
		match self {
			Kind::I8 | Kind::U8 => 1,
			Kind::I16 | Kind::U16 => 2,
			Kind::I32 | Kind::U32 | Kind::F32 => 4,
			Kind::F64 => 8,
		}
	}
}

/// A read file: the header (sections removed) and each section's bytes.
pub struct Bin<B: AsRef<[u8]>> {
	pub header: Map<String, Value>,
	bytes: B,
	sections: Vec<(String, Kind, usize, usize)>,
}

#[derive(Debug)]
pub struct Error(pub String);
impl std::fmt::Display for Error {
	fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
		f.write_str(&self.0)
	}
}
impl std::error::Error for Error {}

fn u32_at(b: &[u8], at: usize) -> u32 {
	u32::from_le_bytes(b[at..at + 4].try_into().unwrap())
}

/// The header alone (the file's first bytes), or None when it is no PSBN file of version 1.
pub fn header_of(bytes: &[u8]) -> Option<Map<String, Value>> {
	if bytes.len() < 12 || u32_at(bytes, 0) != MAGIC || u32_at(bytes, 4) != VERSION {
		return None;
	}
	let n = u32_at(bytes, 8) as usize;
	serde_json::from_slice(bytes.get(12..12 + n)?).ok()
}

/// Whether a file is laid out as `encode` writes it, its sections `names` in this order: the header compact JSON
/// with `contentId` first and `sections` last, each section where encode puts it, zero padding, nothing after the
/// last. (Its contentId is not hashed again: taken as written.)
pub fn as_encoded(bytes: &[u8], names: &[&str]) -> bool {
	let Some(head) = header_of(bytes) else { return false };
	let n = u32_at(bytes, 8) as usize;
	let keys: Vec<&str> = head.keys().map(String::as_str).collect();
	if keys.first() != Some(&"contentId") || keys.last() != Some(&"sections") || !head["contentId"].is_string() {
		return false;
	}
	if serde_json::to_vec(&head).ok().as_deref() != bytes.get(12..12 + n) {
		return false;
	}
	let Some(Value::Object(sections)) = head.get("sections") else { return false };
	if sections.len() != names.len() || sections.keys().zip(names).any(|(k, n)| k != n) {
		return false;
	}
	let mut end = 12 + n;
	for v in sections.values() {
		let (Some(kind), Some(at), Some(len)) = (v.get(0).and_then(Value::as_str).and_then(Kind::of), v.get(1).and_then(Value::as_u64), v.get(2).and_then(Value::as_u64)) else { return false };
		let at = at as usize;
		if v.as_array().map_or(0, Vec::len) != 3 || at != align8(end) || bytes.get(end..at).is_none_or(|pad| pad.iter().any(|&b| b != 0)) {
			return false;
		}
		end = at + len as usize * kind.size();
	}
	bytes.len() == end
}

impl<B: AsRef<[u8]>> Bin<B> {
	pub fn parse(bytes: B) -> Result<Self, Error> {
		let b = bytes.as_ref();
		let mut header = header_of(b).ok_or_else(|| Error("not a binary data file of version 1".into()))?;
		let mut sections = Vec::new();
		if let Some(Value::Object(s)) = header.remove("sections") {
			for (name, v) in s {
				let a = v.as_array().ok_or_else(|| Error(format!("section {name}: bad entry")))?;
				let kind = a.first().and_then(|t| t.as_str()).and_then(Kind::of).ok_or_else(|| Error(format!("section {name} has unknown type")))?;
				let at = a.get(1).and_then(|v| v.as_u64()).ok_or_else(|| Error(format!("section {name}: no offset")))? as usize;
				let len = a.get(2).and_then(|v| v.as_u64()).ok_or_else(|| Error(format!("section {name}: no length")))? as usize;
				if at + len * kind.size() > b.len() {
					return Err(Error(format!("section {name} runs past the file's end")));
				}
				sections.push((name, kind, at, len));
			}
		}
		Ok(Bin { header, bytes, sections })
	}

	pub fn has(&self, name: &str) -> bool {
		self.sections.iter().any(|s| s.0 == name)
	}

	pub fn names(&self) -> impl Iterator<Item = &str> {
		self.sections.iter().map(|s| s.0.as_str())
	}

	fn raw(&self, name: &str, kind: Kind) -> Result<&[u8], Error> {
		let s = self.sections.iter().find(|s| s.0 == name).ok_or_else(|| Error(format!("no section {name}")))?;
		if s.1 != kind {
			return Err(Error(format!("section {name} is {}, not {}", s.1.name(), kind.name())));
		}
		Ok(&self.bytes.as_ref()[s.2..s.2 + s.3 * kind.size()])
	}

	pub fn f64s(&self, name: &str) -> Result<Vec<f64>, Error> {
		Ok(self.raw(name, Kind::F64)?.chunks_exact(8).map(|c| f64::from_le_bytes(c.try_into().unwrap())).collect())
	}
	pub fn f32s(&self, name: &str) -> Result<Vec<f32>, Error> {
		Ok(self.raw(name, Kind::F32)?.chunks_exact(4).map(|c| f32::from_le_bytes(c.try_into().unwrap())).collect())
	}
	pub fn u32s(&self, name: &str) -> Result<Vec<u32>, Error> {
		Ok(self.raw(name, Kind::U32)?.chunks_exact(4).map(|c| u32::from_le_bytes(c.try_into().unwrap())).collect())
	}
	pub fn i32s(&self, name: &str) -> Result<Vec<i32>, Error> {
		Ok(self.raw(name, Kind::I32)?.chunks_exact(4).map(|c| i32::from_le_bytes(c.try_into().unwrap())).collect())
	}
	pub fn u8s(&self, name: &str) -> Result<Vec<u8>, Error> {
		Ok(self.raw(name, Kind::U8)?.to_vec())
	}
}

/// A section to write: its type and little-endian bytes.
pub struct Section {
	pub name: String,
	pub kind: Kind,
	pub len: usize,
	pub bytes: Vec<u8>,
}

/// The values' little-endian bytes, end to end.
fn le<T: Copy, const N: usize>(v: &[T], f: impl Fn(T) -> [u8; N]) -> Vec<u8> {
	let mut out = vec![0u8; v.len() * N];
	for (o, &x) in out.chunks_exact_mut(N).zip(v) {
		o.copy_from_slice(&f(x));
	}
	out
}

impl Section {
	pub fn f64s(name: &str, v: &[f64]) -> Self {
		Section { name: name.into(), kind: Kind::F64, len: v.len(), bytes: le(v, f64::to_le_bytes) }
	}
	pub fn f32s(name: &str, v: &[f32]) -> Self {
		Section { name: name.into(), kind: Kind::F32, len: v.len(), bytes: le(v, f32::to_le_bytes) }
	}
	pub fn u32s(name: &str, v: &[u32]) -> Self {
		Section { name: name.into(), kind: Kind::U32, len: v.len(), bytes: le(v, u32::to_le_bytes) }
	}
	pub fn i32s(name: &str, v: &[i32]) -> Self {
		Section { name: name.into(), kind: Kind::I32, len: v.len(), bytes: le(v, i32::to_le_bytes) }
	}
	pub fn u64s_as_f64(name: &str, v: &[u64]) -> Self {
		// u64 has no typed array in binfile.js: stored as two u32 words each (lo, hi).
		Section { name: name.into(), kind: Kind::U32, len: v.len() * 2, bytes: le(v, u64::to_le_bytes) }
	}
	pub fn u8s(name: &str, v: &[u8]) -> Self {
		Section { name: name.into(), kind: Kind::U8, len: v.len(), bytes: v.to_vec() }
	}
}

const fn align8(n: usize) -> usize {
	n.div_ceil(8) * 8
}

/// The file's bytes for `header` (an object; contentId and sections are replaced) and `sections`,
/// laid out as binfile.js writeBin does; returns (bytes, contentId).
pub fn encode(header: &Map<String, Value>, sections: &[Section]) -> (Vec<u8>, String) {
	let streams: Vec<Stream> = sections.iter().map(Stream::of).collect();
	let mut out = Vec::new();
	let content_id = encode_to(&mut out, header, &streams).expect("psbn: writing to memory");
	(out, content_id)
}

/// A section written in pieces ([`encode_to`]): its type, its length in elements and in bytes, and
/// `emit`, which hands its little-endian bytes to the sink in order, whole, each time it is called (twice:
/// once for the content id, once for the file).
pub struct Stream<'a> {
	pub name: String,
	pub kind: Kind,
	pub len: usize,
	pub bytes: usize,
	pub emit: Box<dyn Fn(&mut dyn FnMut(&[u8])) + 'a>,
}

impl<'a> Stream<'a> {
	/// A section already in memory.
	pub fn of(s: &'a Section) -> Self {
		Stream { name: s.name.clone(), kind: s.kind, len: s.len, bytes: s.bytes.len(), emit: Box::new(move |out: &mut dyn FnMut(&[u8])| out(&s.bytes)) }
	}
}

/// [`encode`]'s file, written to `w` as each section emits it: no section's bytes, and not the file's,
/// are held at once (a walk store's sections are generated from the store twice instead). -> contentId.
pub fn encode_to(w: &mut dyn std::io::Write, header: &Map<String, Value>, sections: &[Stream]) -> std::io::Result<String> {
	let mut h = forge_core::key::ContentHasher::new();
	for s in sections {
		h.update(format!("{}:{}:{}\n", s.name, s.kind.name(), s.len).as_bytes());
		(s.emit)(&mut |b: &[u8]| {
			h.update(b);
		});
	}
	let mut rest = header.clone();
	rest.remove("contentId");
	rest.remove("sections");
	h.update(serde_json::to_string(&Value::Object(rest.clone())).unwrap().as_bytes());
	let content_id = h.hex();
	let head_of = |layout: &Map<String, Value>| {
		let mut m = Map::new();
		m.insert("contentId".into(), Value::String(content_id.clone()));
		for (k, v) in &rest {
			m.insert(k.clone(), v.clone());
		}
		m.insert("sections".into(), Value::Object(layout.clone()));
		serde_json::to_vec(&Value::Object(m)).unwrap()
	};
	let mut layout = Map::new();
	for _ in 0..3 {
		let head = head_of(&layout);
		let mut at = align8(12 + head.len());
		let mut next = Map::new();
		for s in sections {
			next.insert(s.name.clone(), serde_json::json!([s.kind.name(), at, s.len]));
			at = align8(at + s.bytes);
		}
		if next == layout {
			break;
		}
		layout = next;
	}
	let head = head_of(&layout);
	w.write_all(&MAGIC.to_le_bytes())?;
	w.write_all(&VERSION.to_le_bytes())?;
	w.write_all(&(head.len() as u32).to_le_bytes())?;
	w.write_all(&head)?;
	let mut pos = 12 + head.len();
	for s in sections {
		let at = layout[&s.name][1].as_u64().unwrap() as usize;
		w.write_all(&[0u8; 8][..at - pos])?;
		let (mut written, mut err) = (0usize, None);
		(s.emit)(&mut |b: &[u8]| {
			if err.is_none() {
				err = w.write_all(b).err();
			}
			written += b.len();
		});
		if let Some(e) = err {
			return Err(e);
		}
		if written != s.bytes {
			return Err(std::io::Error::new(std::io::ErrorKind::InvalidData, format!("psbn section {}: {written} bytes emitted, {} laid out", s.name, s.bytes)));
		}
		pos = at + written;
	}
	Ok(content_id)
}
