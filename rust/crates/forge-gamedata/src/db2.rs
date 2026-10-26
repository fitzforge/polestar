//! DB2 tables (WDC3, WDC4, WDC5) typed by a WoWDBDefs [`Definition`].
//!
//! Layout per wowdev.wiki "DB2" and DBCD (wowdev's reference reader): a header, section
//! headers, field storage info (none / bitpacked / common data / pallet / pallet array /
//! signed bitpacked), pallet and common data, then per section: records (fixed size, strings
//! as offsets into the combined string table) or, for sparse tables, variable records with
//! inline strings; the ID list, copy table, offset map, relationship data. Sections encrypted
//! with a TACT key we do not have arrive zero-filled and are skipped, with a note.

use rustc_hash::FxHashMap;

use crate::dbd::{Definition, Kind};

/// One CSV-level column (array fields expand to `Name_0`, `Name_1`, ...).
#[derive(Clone, Debug)]
pub struct Column {
	pub name: String,
	pub kind: Kind,
	pub bits: u32,
	pub signed: bool,
}

#[derive(Clone, Copy, Debug, PartialEq)]
pub enum Value {
	Int(i64),
	UInt(u64),
	Float(f32),
	/// A string as (start, length) in [`Table::bytes`].
	Str(u32, u32),
}

impl Value {
	/// An int column's value (floats and strings: None).
	pub fn as_i64(&self) -> Option<i64> {
		match *self {
			Value::Int(x) => Some(x),
			Value::UInt(x) => Some(x as i64),
			_ => None,
		}
	}

	/// A number column's value as f64 (strings: None).
	pub fn as_f64(&self) -> Option<f64> {
		match *self {
			Value::Int(x) => Some(x as f64),
			Value::UInt(x) => Some(x as f64),
			Value::Float(x) => Some(x as f64),
			Value::Str(..) => None,
		}
	}
}

/// A decoded table: `rows() * columns.len()` values, row-major, in file order (sections in
/// order, copy-table rows after their section's rows).
pub struct Table {
	pub columns: Vec<Column>,
	pub values: Vec<Value>,
	/// The DB2 file (strings point into it).
	pub bytes: Vec<u8>,
	pub layout_hash: u32,
	pub table_hash: u32,
	/// Index in `columns` of the ID column, if the definition names one.
	pub id_column: Option<usize>,
	/// What was skipped and why (encrypted sections, unreadable strings).
	pub notes: Vec<String>,
	/// IDs of the records in sections encrypted with a key we lack (WDC4+ encrypted_status).
	pub encrypted_ids: Vec<u32>,
}

impl Table {
	pub fn rows(&self) -> usize {
		if self.columns.is_empty() {
			0
		} else {
			self.values.len() / self.columns.len()
		}
	}

	pub fn row(&self, i: usize) -> &[Value] {
		let n = self.columns.len();
		&self.values[i * n..(i + 1) * n]
	}

	pub fn str(&self, v: &Value) -> Option<&[u8]> {
		match *v {
			Value::Str(s, l) => Some(&self.bytes[s as usize..(s + l) as usize]),
			_ => None,
		}
	}

	pub fn column(&self, name: &str) -> Option<usize> {
		self.columns.iter().position(|c| c.name == name)
	}
}

/// The layout hash of a DB2 file (to pick its definition before reading it).
pub fn layout_hash(b: &[u8]) -> Result<u32, String> {
	let h = Header::parse(b)?;
	Ok(h.layout_hash)
}

struct Header {
	start: usize,
	/// WDC4+: per encrypted section, the IDs it holds.
	encrypted_status: bool,
	record_count: u32,
	field_count: u32,
	record_size: u32,
	table_hash: u32,
	layout_hash: u32,
	flags: u16,
	id_index: u16,
	total_field_count: u32,
	field_storage_info_size: u32,
	common_data_size: u32,
	pallet_data_size: u32,
	section_count: u32,
}

const HEADER_LEN: usize = 72;

fn u16at(b: &[u8], o: usize) -> Result<u16, String> {
	b.get(o..o + 2).map(|x| u16::from_le_bytes([x[0], x[1]])).ok_or_else(|| format!("DB2: truncated at {o}"))
}
fn u32at(b: &[u8], o: usize) -> Result<u32, String> {
	b.get(o..o + 4).map(|x| u32::from_le_bytes(x.try_into().unwrap())).ok_or_else(|| format!("DB2: truncated at {o}"))
}

impl Header {
	fn parse(b: &[u8]) -> Result<Header, String> {
		let magic = b.get(..4).ok_or("DB2: empty file")?;
		let start = match magic {
			b"WDC3" | b"WDC4" => 4,
			b"WDC5" => 136,
			m => return Err(format!("DB2: unsupported format {:?}", String::from_utf8_lossy(m))),
		};
		let o = start;
		let encrypted_status = magic != b"WDC3";
		Ok(Header {
			start: o,
			encrypted_status,
			record_count: u32at(b, o)?,
			field_count: u32at(b, o + 4)?,
			record_size: u32at(b, o + 8)?,
			table_hash: u32at(b, o + 16)?,
			layout_hash: u32at(b, o + 20)?,
			flags: u16at(b, o + 36)?,
			id_index: u16at(b, o + 38)?,
			total_field_count: u32at(b, o + 40)?,
			field_storage_info_size: u32at(b, o + 52)?,
			common_data_size: u32at(b, o + 56)?,
			pallet_data_size: u32at(b, o + 60)?,
			section_count: u32at(b, o + 64)?,
		})
	}
}

struct Section {
	tact_key_hash: u64,
	file_offset: usize,
	record_count: usize,
	string_table_size: usize,
	offset_records_end: usize,
	id_list_size: usize,
	relationship_data_size: usize,
	offset_map_id_count: usize,
	copy_table_count: usize,
}

#[derive(Clone, Copy, PartialEq)]
enum Storage {
	None,
	Bitpacked { width: u32, signed: bool },
	Common { default: u32 },
	Pallet { width: u32 },
	PalletArray { width: u32, count: u32 },
}

struct FieldInfo {
	offset_bits: u32,
	/// Element size of an uncompressed field (field_structure), else the bitpacked width.
	bits: u32,
	storage: Storage,
	/// Byte offset of this field's block in pallet or common data.
	data_offset: usize,
	data_size: usize,
}

/// Reads `bits` bits at bit `pos` of `rec` (little-endian), zero past its end.
fn read_bits(rec: &[u8], pos: u32, bits: u32) -> u64 {
	let first = (pos / 8) as usize;
	let shift = pos % 8;
	let n = (bits + shift).div_ceil(8) as usize;
	let mut v: u128 = 0;
	for i in 0..n.min(16) {
		v |= (*rec.get(first + i).unwrap_or(&0) as u128) << (8 * i);
	}
	let v = v >> shift;
	if bits >= 64 {
		v as u64
	} else {
		(v as u64) & ((1u64 << bits) - 1)
	}
}

fn sign_extend(v: u64, bits: u32) -> i64 {
	if bits >= 64 {
		v as i64
	} else {
		((v << (64 - bits)) as i64) >> (64 - bits)
	}
}

/// The value of raw bits for a column of this type (strings are resolved by the caller).
fn typed(raw: u64, c: &Column) -> Value {
	match c.kind {
		Kind::Float => Value::Float(f32::from_bits(raw as u32)),
		_ if c.signed => Value::Int(sign_extend(raw, c.bits)),
		_ => Value::UInt(if c.bits >= 64 { raw } else { raw & ((1u64 << c.bits) - 1) }),
	}
}

/// Decodes a DB2 file with `def` (which must match its layout).
pub fn read(bytes: Vec<u8>, def: &Definition) -> Result<Table, String> {
	let h = Header::parse(&bytes)?;
	let b = &bytes[..];
	let mut pos = h.start + HEADER_LEN - 4;
	let mut sections = Vec::with_capacity(h.section_count as usize);
	for _ in 0..h.section_count {
		let u = |i: usize| u32at(b, pos + 8 + i * 4).map(|v| v as usize);
		sections.push(Section {
			tact_key_hash: u64::from_le_bytes(b.get(pos..pos + 8).ok_or("DB2: truncated section header")?.try_into().unwrap()),
			file_offset: u(0)?,
			record_count: u(1)?,
			string_table_size: u(2)?,
			offset_records_end: u(3)?,
			id_list_size: u(4)?,
			relationship_data_size: u(5)?,
			offset_map_id_count: u(6)?,
			copy_table_count: u(7)?,
		});
		pos += 40;
	}
	// field_structure: per stored field, 32 minus its size in bits (the element size of
	// uncompressed fields; DBCD reads those with it, not the definition's size).
	let mut field_bits = Vec::with_capacity(h.total_field_count as usize);
	for i in 0..h.total_field_count as usize {
		field_bits.push((32 - u16at(b, pos + i * 4)? as i16 as i32) as u32);
	}
	pos += h.total_field_count as usize * 4;
	let n_info = h.field_storage_info_size as usize / 24;
	let mut infos = Vec::with_capacity(n_info);
	let (mut pallet_off, mut common_off) = (0usize, 0usize);
	for i in 0..n_info {
		let o = pos + i * 24;
		let (offset_bits, data_size, kind) = (u16at(b, o)? as u32, u32at(b, o + 4)? as usize, u32at(b, o + 8)?);
		let (x, y, z) = (u32at(b, o + 12)?, u32at(b, o + 16)?, u32at(b, o + 20)?);
		let storage = match kind {
			0 => Storage::None,
			// DBCD: 1 is "Immediate" (unsigned), 5 "SignedImmediate"; the flags word is not used.
			1 | 5 => Storage::Bitpacked { width: y, signed: kind == 5 },
			2 => Storage::Common { default: x },
			3 => Storage::Pallet { width: y },
			4 => Storage::PalletArray { width: y, count: z },
			k => return Err(format!("DB2: field {i}: unknown storage type {k}")),
		};
		let data_offset = match storage {
			Storage::Pallet { .. } | Storage::PalletArray { .. } => {
				pallet_off += data_size;
				pallet_off - data_size
			}
			Storage::Common { .. } => {
				common_off += data_size;
				common_off - data_size
			}
			_ => 0,
		};
		let bits = match field_bits.get(i) {
			Some(&b) if b > 0 && b <= 64 => b,
			_ => y,
		};
		infos.push(FieldInfo { offset_bits, bits, storage, data_offset, data_size });
	}
	pos += h.field_storage_info_size as usize;
	let pallet = b.get(pos..pos + h.pallet_data_size as usize).ok_or("DB2: truncated pallet data")?;
	pos += h.pallet_data_size as usize;
	let common = b.get(pos..pos + h.common_data_size as usize).ok_or("DB2: truncated common data")?;
	pos += h.common_data_size as usize;
	// encrypted_status: the record IDs each encrypted section holds.
	let mut encrypted_ids = Vec::new();
	if h.encrypted_status {
		for s in sections.iter().filter(|s| s.tact_key_hash != 0) {
			let n = u32at(b, pos)? as usize;
			for i in 0..n {
				encrypted_ids.push((s.file_offset, u32at(b, pos + 4 + i * 4)?));
			}
			pos += 4 + n * 4;
		}
	}
	// Common data: per field, record ID -> value.
	let commons: Vec<FxHashMap<u32, u32>> = infos
		.iter()
		.map(|f| match f.storage {
			Storage::Common { .. } => {
				common[f.data_offset..f.data_offset + f.data_size].chunks_exact(8).map(|e| (u32::from_le_bytes(e[..4].try_into().unwrap()), u32::from_le_bytes(e[4..].try_into().unwrap()))).collect()
			}
			_ => FxHashMap::default(),
		})
		.collect();

	// Definition fields -> columns and storage fields.
	let mut columns = Vec::new();
	let mut first_col = Vec::with_capacity(def.fields.len());
	let mut storage_of = Vec::with_capacity(def.fields.len());
	let mut id_column = None;
	let mut k = 0usize;
	for f in &def.fields {
		first_col.push(columns.len());
		if f.id && id_column.is_none() {
			id_column = Some(columns.len());
		}
		for e in 0..f.array {
			let name = if f.array > 1 { format!("{}_{e}", f.name) } else { f.name.clone() };
			columns.push(Column { name, kind: f.kind, bits: f.bits, signed: f.signed });
		}
		if f.noninline {
			storage_of.push(None);
		} else {
			storage_of.push(Some(k));
			k += 1;
		}
	}
	if k != h.field_count as usize || (k > infos.len() && h.record_count > 0) {
		return Err(format!(
			"DB2: definition has {k} stored fields, the file {} with {} storage infos, {} field structures, record size {}, {} records, flags {:#x} (layout {:08X})",
			h.field_count,
			infos.len(),
			h.total_field_count,
			h.record_size,
			h.record_count,
			h.flags,
			h.layout_hash
		));
	}
	let ncols = columns.len();
	let sparse = h.flags & 1 != 0;
	let secondary_key = h.flags & 2 != 0;
	let rs = h.record_size as usize;
	let total_records_bytes = h.record_count as i64 * rs as i64;

	let mut values: Vec<Value> = Vec::with_capacity(h.record_count as usize * ncols);
	let mut notes = Vec::new();
	let mut bad_strings = 0usize;
	// Combined string table: (start in the combined table, file offset, size) per section.
	let mut strings: Vec<(usize, usize, usize)> = Vec::new();
	let mut string_base = 0usize;
	let mut global_index = 0usize;
	let mut row_ids: Vec<u32> = Vec::with_capacity(h.record_count as usize);
	let mut skipped_ids: Vec<u32> = Vec::new();
	for (si, s) in sections.iter().enumerate() {
		let mut p = s.file_offset;
		let records_end = if sparse { s.offset_records_end } else { p + s.record_count * rs };
		let records = b.get(p..records_end).ok_or_else(|| format!("DB2: section {si}: records overrun the file"))?;
		p = records_end;
		if !sparse {
			strings.push((string_base, p, s.string_table_size));
			p += s.string_table_size;
		}
		string_base += s.string_table_size;
		if s.tact_key_hash != 0 && records.iter().all(|&x| x == 0) {
			notes.push(format!("section {si}: encrypted with TACT key {:016X} (no key here); {} records skipped", s.tact_key_hash, s.record_count));
			skipped_ids.extend(encrypted_ids.iter().filter(|(f, _)| *f == s.file_offset).map(|&(_, id)| id));
			global_index += s.record_count;
			continue;
		}
		let words = |p: usize, n: usize| -> Result<Vec<u32>, String> { (0..n).map(|i| u32at(b, p + i * 4)).collect() };
		let mut ids = words(p, s.id_list_size / 4)?;
		p += s.id_list_size;
		let copies = words(p, s.copy_table_count * 2)?;
		p += s.copy_table_count * 8;
		let mut sizes = Vec::with_capacity(s.offset_map_id_count);
		for i in 0..s.offset_map_id_count {
			sizes.push(u16at(b, p + i * 6 + 4)? as usize);
		}
		p += s.offset_map_id_count * 6;
		if s.offset_map_id_count > 0 && secondary_key {
			ids = words(p, s.offset_map_id_count)?;
			p += s.offset_map_id_count * 4;
		}
		let mut relation: FxHashMap<u32, u32> = FxHashMap::default();
		if s.relationship_data_size > 0 {
			let n = u32at(b, p)? as usize;
			for i in 0..n {
				let e = p + 12 + i * 8;
				relation.insert(u32at(b, e + 4)?, u32at(b, e)?);
			}
			p += 12 + n * 8;
		}
		if s.offset_map_id_count > 0 && !secondary_key {
			ids = words(p, s.offset_map_id_count)?;
		}
		if sparse && sizes.len() != s.record_count {
			return Err(format!("DB2: section {si}: {} offset map entries for {} records", sizes.len(), s.record_count));
		}

		let section_first_row = row_ids.len();
		let mut cursor = 0usize;
		for i in 0..s.record_count {
			let (rec, rec_file_start) = if sparse {
				let r = records.get(cursor..cursor + sizes[i]).ok_or_else(|| format!("DB2: section {si}: sparse record {i} overruns"))?;
				cursor += sizes[i];
				(r, s.file_offset + cursor - sizes[i])
			} else {
				(&records[i * rs..(i + 1) * rs], 0)
			};
			// The record's ID: the ID list, else the inline field at id_index.
			let id = match ids.get(i) {
				Some(&id) => id,
				None if !sparse => {
					let info = infos.get(h.id_index as usize).ok_or("DB2: id_index past the fields")?;
					stored(rec, info, 0, pallet, &commons[h.id_index as usize], 0)? as u32
				}
				None => return Err(format!("DB2: section {si}: sparse record {i} has no ID")),
			};
			row_ids.push(id);
			let row_start = values.len();
			values.resize(row_start + ncols, Value::UInt(0));
			let mut seq = 0usize; // sparse: byte cursor in the record
			for (fi, f) in def.fields.iter().enumerate() {
				let col0 = first_col[fi];
				let Some(k) = storage_of[fi] else {
					let raw = if f.relation {
						relation.get(&if secondary_key { id } else { i as u32 }).copied().unwrap_or(0)
					} else if f.id {
						id
					} else {
						0
					};
					values[row_start + col0] = typed(raw as u64, &columns[col0]);
					continue;
				};
				for e in 0..f.array {
					let col = &columns[col0 + e];
					let is_str = matches!(f.kind, Kind::String | Kind::LocString);
					let v = if sparse {
						let from = seq.min(rec.len());
						if is_str {
							let len = rec[from..].iter().position(|&c| c == 0).unwrap_or(rec.len() - from);
							seq += len + 1;
							Value::Str((rec_file_start + from) as u32, len as u32)
						} else {
							seq += (f.bits / 8) as usize;
							typed(read_bits(rec, (from * 8) as u32, f.bits), col)
						}
					} else {
						let raw = stored(rec, &infos[k], e, pallet, &commons[k], id)?;
						if is_str {
							let field_byte = (infos[k].offset_bits / 8) as i64 + e as i64 * 4;
							let at = (global_index + i) as i64 * rs as i64 + field_byte + (raw as u32 as i32) as i64 - total_records_bytes;
							// Offset 0 is how an empty string is stored (it points nowhere).
							resolve_string(b, &strings, at).unwrap_or_else(|| {
								bad_strings += (raw as u32 != 0) as usize;
								Value::Str(0, 0)
							})
						} else {
							typed(raw, col)
						}
					};
					values[row_start + col0 + e] = v;
				}
			}
		}
		// Copy table: (new ID, source ID), each a copy of the source row under the new ID.
		if !copies.is_empty() {
			let idc = id_column.ok_or("DB2: copy table but the definition names no ID column")?;
			let by_id: FxHashMap<u32, usize> = (section_first_row..row_ids.len()).map(|r| (row_ids[r], r)).collect();
			for c in copies.chunks_exact(2) {
				let (new, src) = (c[0], c[1]);
				let r = *by_id.get(&src).ok_or_else(|| format!("DB2: copy table: source ID {src} not in section {si}"))?;
				values.extend_from_within(r * ncols..(r + 1) * ncols);
				let at = values.len() - ncols;
				values[at + idc] = typed(new as u64, &columns[idc]);
				row_ids.push(new);
			}
		}
		global_index += s.record_count;
	}
	if bad_strings > 0 {
		notes.push(format!("{bad_strings} string offsets outside the string table (read as empty)"));
	}
	Ok(Table { columns, values, bytes, layout_hash: h.layout_hash, table_hash: h.table_hash, id_column, notes, encrypted_ids: skipped_ids })
}

/// The raw bits of element `e` of a stored (non-sparse) field.
fn stored(rec: &[u8], info: &FieldInfo, e: usize, pallet: &[u8], common: &FxHashMap<u32, u32>, id: u32) -> Result<u64, String> {
	Ok(match info.storage {
		Storage::None => read_bits(rec, info.offset_bits + e as u32 * info.bits, info.bits),
		Storage::Bitpacked { width, signed } => {
			let r = read_bits(rec, info.offset_bits, width);
			if signed {
				sign_extend(r, width) as u64
			} else {
				r
			}
		}
		Storage::Common { default } => common.get(&id).copied().unwrap_or(default) as u64,
		Storage::Pallet { width } => {
			let idx = read_bits(rec, info.offset_bits, width) as usize;
			u32at(pallet, info.data_offset + idx * 4)? as u64
		}
		Storage::PalletArray { width, count } => {
			let idx = read_bits(rec, info.offset_bits, width) as usize;
			u32at(pallet, info.data_offset + (idx * count as usize + e) * 4)? as u64
		}
	})
}

/// A string at position `at` of the combined string table.
fn resolve_string(b: &[u8], strings: &[(usize, usize, usize)], at: i64) -> Option<Value> {
	if at < 0 {
		return None;
	}
	let at = at as usize;
	let &(base, file, size) = strings.iter().find(|&&(base, _, size)| at >= base && at < base + size)?;
	let start = file + (at - base);
	let len = b.get(start..file + size)?.iter().position(|&c| c == 0)?;
	Some(Value::Str(start as u32, len as u32))
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::dbd::Dbd;

	fn put(b: &mut Vec<u8>, words: &[u32]) {
		for w in words {
			b.extend_from_slice(&w.to_le_bytes());
		}
	}

	/// A one-section WDC5 with an inline ID, a string, a signed bitpacked field, a pallet field,
	/// a common-data field, relationship data and a copy-table row.
	#[test]
	fn reads_every_storage_kind() {
		let mut b = b"WDC5".to_vec();
		put(&mut b, &[5]);
		b.extend_from_slice(&[0; 128]);
		put(&mut b, &[3, 5, 12, 5, 0, 0x1234, 10, 12, 0]);
		b.extend_from_slice(&[0, 0, 0, 0]); // flags, id_index
		put(&mut b, &[5, 8, 0, 5 * 24, 8, 8, 1]);
		let section_header = b.len();
		put(&mut b, &[0, 0, 0, 3, 5, 0, 0, 28, 0, 1]);
		for (size, pos) in [(0i16, 0u16), (0, 4), (28, 8), (30, 8), (32, 8)] {
			b.extend_from_slice(&size.to_le_bytes());
			b.extend_from_slice(&pos.to_le_bytes());
		}
		// offset_bits, size_bits, data size, type, x, y, z
		let info = |b: &mut Vec<u8>, off: u16, size: u16, data: u32, kind: u32, x: u32, y: u32, z: u32| {
			b.extend_from_slice(&off.to_le_bytes());
			b.extend_from_slice(&size.to_le_bytes());
			put(b, &[data, kind, x, y, z]);
		};
		info(&mut b, 0, 32, 0, 0, 0, 0, 0);
		info(&mut b, 32, 32, 0, 0, 0, 0, 0);
		info(&mut b, 64, 4, 0, 5, 0, 4, 1);
		info(&mut b, 68, 2, 8, 3, 0, 2, 0);
		info(&mut b, 70, 0, 8, 2, 7, 0, 0);
		put(&mut b, &[100, 200]); // pallet
		put(&mut b, &[11, 5]); // common: ID 11 -> 5
		let section = b.len() as u32;
		b[section_header + 8..section_header + 12].copy_from_slice(&section.to_le_bytes());
		// Records: ID, string offset, signed (4 bits) | pallet index << 4.
		for (id, s, packed) in [(10u32, 32u32, 0x0fu32), (11, 0, 0x13), (12, 10, 0x18)] {
			put(&mut b, &[id, s, packed]);
		}
		b.extend_from_slice(b"a\0bc\0");
		put(&mut b, &[20, 10]); // copy table: 20 is a copy of 10
		put(&mut b, &[2, 0, 0, 900, 0, 902, 2]); // relationship: record 0 -> 900, record 2 -> 902
		let dbd = Dbd::parse(
			"COLUMNS\nint ID\nstring Name\nint Signed\nint Pal\nint Com\nint ParentID\n\nLAYOUT 00001234\n$id$ID<32>\nName\nSigned<8>\nPal<u16>\nCom<32>\n$noninline,relation$ParentID<32>\n",
		)
		.unwrap();
		let t = read(b, dbd.select(0x1234, None).unwrap()).unwrap();
		let text = String::from_utf8(crate::csv::write_table(&t)).unwrap();
		assert_eq!(text, "ID,Name,Signed,Pal,Com,ParentID\n10,a,-1,100,7,900\n11,,3,200,5,0\n12,bc,-8,200,7,902\n20,a,-1,100,7,900\n");
		assert!(t.notes.is_empty(), "{:?}", t.notes);
	}
}
