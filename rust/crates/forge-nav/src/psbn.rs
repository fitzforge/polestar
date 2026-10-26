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

impl Section {
	pub fn f64s(name: &str, v: &[f64]) -> Self {
		Section { name: name.into(), kind: Kind::F64, len: v.len(), bytes: v.iter().flat_map(|x| x.to_le_bytes()).collect() }
	}
	pub fn f32s(name: &str, v: &[f32]) -> Self {
		Section { name: name.into(), kind: Kind::F32, len: v.len(), bytes: v.iter().flat_map(|x| x.to_le_bytes()).collect() }
	}
	pub fn u32s(name: &str, v: &[u32]) -> Self {
		Section { name: name.into(), kind: Kind::U32, len: v.len(), bytes: v.iter().flat_map(|x| x.to_le_bytes()).collect() }
	}
	pub fn i32s(name: &str, v: &[i32]) -> Self {
		Section { name: name.into(), kind: Kind::I32, len: v.len(), bytes: v.iter().flat_map(|x| x.to_le_bytes()).collect() }
	}
	pub fn u64s_as_f64(name: &str, v: &[u64]) -> Self {
		// u64 has no typed array in binfile.js: stored as two u32 words each (lo, hi).
		Section { name: name.into(), kind: Kind::U32, len: v.len() * 2, bytes: v.iter().flat_map(|x| x.to_le_bytes()).collect() }
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
	let mut h = forge_core::key::ContentHasher::new();
	for s in sections {
		h.update(format!("{}:{}:{}\n", s.name, s.kind.name(), s.len).as_bytes());
		h.update(&s.bytes);
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
			at = align8(at + s.bytes.len());
		}
		if next == layout {
			break;
		}
		layout = next;
	}
	let head = head_of(&layout);
	let mut out = Vec::new();
	out.extend_from_slice(&MAGIC.to_le_bytes());
	out.extend_from_slice(&VERSION.to_le_bytes());
	out.extend_from_slice(&(head.len() as u32).to_le_bytes());
	out.extend_from_slice(&head);
	for s in sections {
		let at = layout[&s.name][1].as_u64().unwrap() as usize;
		out.resize(at, 0);
		out.extend_from_slice(&s.bytes);
	}
	(out, content_id)
}
