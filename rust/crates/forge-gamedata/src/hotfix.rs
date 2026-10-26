//! The client's hotfix cache (`<flavor>/Cache/ADB/<locale>/DBCache.bin`, version 9): table rows
//! the server pushed over the shipped DB2s. Read-only.
//!
//! A 44-byte header (`XFTH`, version, build, a 32-byte verification hash), then entries up to
//! the end: `XFTH`, RegionID i32, PushID i32, UniqueID u32, TableHash u32, RecordID u32,
//! DataSize i32, Status u8 + 3 pad bytes, Data. A valid row's data is the table's fields in
//! WoWDBDefs order for the build, each at its declared size (floats 4 bytes, arrays repeated,
//! strings and locstrings inline and NUL-terminated). The `$noninline,id$` field (the DB2's ID
//! list) is not in it, the row's ID being the entry's RecordID; a `$noninline,relation$` field
//! (the DB2's relationship data) is, in its definition position (checked on ItemXItemEffect and
//! SpellEffect rows of build 70450).

use std::path::Path;

use crate::db2::{Column, Table, Value};
use crate::dbd::{Definition, Kind};

/// The DBCache.bin version this module reads.
pub const VERSION: u32 = 9;
const MAGIC: &[u8; 4] = b"XFTH";
const HEADER: usize = 44;
const ENTRY_HEADER: usize = 32;

/// An entry's status byte.
pub mod status {
	/// The data is the row.
	pub const VALID: u8 = 1;
	/// The record is deleted.
	pub const DELETED: u8 = 2;
	/// The hotfix is removed (the shipped row stands again).
	pub const REMOVED: u8 = 3;
	/// Not public (the data is withheld).
	pub const NOT_PUBLIC: u8 = 4;

	/// A status's name.
	pub fn name(s: u8) -> &'static str {
		match s {
			VALID => "valid",
			DELETED => "deleted",
			REMOVED => "removed",
			NOT_PUBLIC => "not public",
			_ => "unknown",
		}
	}
}

/// One hotfix entry; its data is `DbCache::data(entry)`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Entry {
	pub region_id: i32,
	pub push_id: i32,
	pub unique_id: u32,
	pub table_hash: u32,
	pub record_id: u32,
	/// See [`status`].
	pub status: u8,
	/// The data's offset in the file.
	pub data_start: usize,
	pub data_size: usize,
}

/// A parsed DBCache.bin.
pub struct DbCache {
	pub version: u32,
	pub build: u32,
	pub verification_hash: [u8; 32],
	pub entries: Vec<Entry>,
	bytes: Vec<u8>,
}

impl DbCache {
	/// Reads a DBCache.bin.
	pub fn read(path: &Path) -> Result<DbCache, String> {
		let b = std::fs::read(path).map_err(|e| format!("{}: {e}", path.display()))?;
		DbCache::parse(b).map_err(|e| format!("{}: {e}", path.display()))
	}

	/// Parses the bytes of a DBCache.bin (version 9).
	pub fn parse(bytes: Vec<u8>) -> Result<DbCache, String> {
		let b = &bytes[..];
		if b.len() < HEADER || &b[..4] != MAGIC {
			return Err("DBCache: not a hotfix cache (no XFTH header)".into());
		}
		let u = |o: usize| u32::from_le_bytes(b[o..o + 4].try_into().unwrap());
		let version = u(4);
		if version != VERSION {
			return Err(format!("DBCache: version {version}, this reader knows version {VERSION} only"));
		}
		let build = u(8);
		let verification_hash = b[12..44].try_into().unwrap();
		let mut entries = Vec::new();
		let mut o = HEADER;
		while o < b.len() {
			if o + ENTRY_HEADER > b.len() {
				return Err(format!("DBCache: entry header at {o} overruns the file ({} bytes)", b.len()));
			}
			if &b[o..o + 4] != MAGIC {
				return Err(format!("DBCache: no XFTH at entry {} (offset {o})", entries.len()));
			}
			let size = u(o + 24) as i32;
			let data_size = usize::try_from(size).map_err(|_| format!("DBCache: entry at {o}: negative DataSize {size}"))?;
			let data_start = o + ENTRY_HEADER;
			if data_start + data_size > b.len() {
				return Err(format!("DBCache: entry at {o}: {data_size} data bytes overrun the file ({} bytes)", b.len()));
			}
			entries.push(Entry { region_id: u(o + 4) as i32, push_id: u(o + 8) as i32, unique_id: u(o + 12), table_hash: u(o + 16), record_id: u(o + 20), status: b[o + 28], data_start, data_size });
			o = data_start + data_size;
		}
		Ok(DbCache { version, build, verification_hash, entries, bytes })
	}

	/// An entry's data bytes.
	pub fn data(&self, e: &Entry) -> &[u8] {
		&self.bytes[e.data_start..e.data_start + e.data_size]
	}
}

/// The decoded hotfix rows of one table: a [`Table`] whose columns are `RecordID`, `Status`,
/// `PushID` then the definition's columns (arrays as `Name_0`, ...), and the rows that failed.
pub struct Rows {
	pub table: Table,
	/// (RecordID, why) per valid row whose data did not decode to exactly its size.
	pub failures: Vec<(u32, String)>,
}

/// The number of leading entry columns of [`Rows::table`].
pub const ENTRY_COLUMNS: usize = 3;

/// Decodes the entries of `table_hash` with `def` (the definition for the cache's build), in
/// file order. `valid_only`: skip entries whose status is not [`status::VALID`]; other entries'
/// table columns are empty strings (their data is not a row), as are those of a valid row that
/// failed to decode (listed in [`Rows::failures`]). A `$noninline,id$` column takes the
/// RecordID.
pub fn rows(cache: &DbCache, table_hash: u32, def: &Definition, valid_only: bool) -> Rows {
	let int = |name: &str| Column { name: name.into(), kind: Kind::Int, bits: 32, signed: true };
	let mut columns = vec![int("RecordID"), int("Status"), int("PushID")];
	for f in &def.fields {
		for e in 0..f.array {
			let name = if f.array > 1 { format!("{}_{e}", f.name) } else { f.name.clone() };
			columns.push(Column { name, kind: f.kind, bits: f.bits, signed: f.signed });
		}
	}
	let id_column = def.fields.iter().position(|f| f.id).map(|i| ENTRY_COLUMNS + def.fields[..i].iter().map(|f| f.array).sum::<usize>());
	let ncols = columns.len();
	let mut values = Vec::new();
	let mut bytes = Vec::new();
	let mut failures = Vec::new();
	for e in cache.entries.iter().filter(|e| e.table_hash == table_hash && (!valid_only || e.status == status::VALID)) {
		let start = values.len();
		values.extend_from_slice(&[Value::Int(e.record_id as i64), Value::Int(e.status as i64), Value::Int(e.push_id as i64)]);
		if e.status == status::VALID {
			let bytes_start = bytes.len();
			match decode_row(def, cache.data(e), e.record_id, &mut values, &mut bytes) {
				Ok(()) => continue,
				Err(why) => {
					failures.push((e.record_id, why));
					values.truncate(start + ENTRY_COLUMNS);
					bytes.truncate(bytes_start);
				}
			}
		}
		values.resize(start + ncols, Value::Str(0, 0));
	}
	let table = Table { columns, values, bytes, layout_hash: 0, table_hash, id_column, notes: Vec::new(), encrypted_ids: Vec::new() };
	Rows { table, failures }
}

/// Appends the definition's columns of one valid hotfix row to `values` (strings copied to the
/// end of `strings`); Err when the fields overrun `data` or leave bytes over.
pub fn decode_row(def: &Definition, data: &[u8], record_id: u32, values: &mut Vec<Value>, strings: &mut Vec<u8>) -> Result<(), String> {
	let mut o = 0usize;
	for f in &def.fields {
		if f.noninline && f.id {
			values.push(Value::Int(record_id as i64));
			continue;
		}
		for _ in 0..f.array {
			match f.kind {
				Kind::String | Kind::LocString => {
					let rest = data.get(o..).unwrap_or_default();
					let len = rest.iter().position(|&c| c == 0).ok_or_else(|| format!("{}: unterminated string at {o} of {}", f.name, data.len()))?;
					values.push(Value::Str(strings.len() as u32, len as u32));
					strings.extend_from_slice(&rest[..len]);
					o += len + 1;
				}
				_ => {
					let n = (f.bits / 8) as usize;
					let raw = data.get(o..o + n).ok_or_else(|| format!("{}: {n} bytes at {o} overrun the {}-byte row", f.name, data.len()))?;
					let mut le = [0u8; 8];
					le[..n].copy_from_slice(raw);
					let u = u64::from_le_bytes(le);
					values.push(match f.kind {
						Kind::Float => Value::Float(f32::from_bits(u as u32)),
						_ if f.signed => Value::Int(if n == 8 { u as i64 } else { ((u << (64 - f.bits)) as i64) >> (64 - f.bits) }),
						_ => Value::UInt(u),
					});
					o += n;
				}
			}
		}
	}
	if o != data.len() {
		return Err(format!("{} of {} bytes decoded", o, data.len()));
	}
	Ok(())
}

/// How decoded hotfix rows compare with the shipped DB2's rows of the same IDs.
#[derive(Clone, Debug, Default)]
pub struct Comparison {
	/// Hotfix rows whose ID the DB2 also holds.
	pub rows: usize,
	/// Hotfix rows whose ID the DB2 lacks (new records).
	pub new_rows: usize,
	/// Values compared (rows x the columns both tables have).
	pub values: usize,
	pub equal: usize,
	/// Per column (by name, in hotfix order): (compared, equal).
	pub per_column: Vec<(String, usize, usize)>,
}

/// Compares the valid rows of `hot` that decoded (failures skipped) with `db2`'s rows of the
/// same ID, column by column (by name). Strings compare by bytes, numbers by value (floats bit
/// for bit).
pub fn compare(hot: &Rows, db2: &Table) -> Comparison {
	let t = &hot.table;
	let mut c = Comparison::default();
	let Some(db2_id) = db2.id_column else { return c };
	let pairs: Vec<(usize, usize)> = (ENTRY_COLUMNS..t.columns.len()).filter_map(|i| db2.column(&t.columns[i].name).map(|j| (i, j))).collect();
	c.per_column = pairs.iter().map(|&(i, _)| (t.columns[i].name.clone(), 0, 0)).collect();
	let mut by_id = rustc_hash::FxHashMap::default();
	for r in 0..db2.rows() {
		if let Some(id) = db2.row(r)[db2_id].as_i64() {
			by_id.insert(id, r);
		}
	}
	let failed: rustc_hash::FxHashSet<u32> = hot.failures.iter().map(|f| f.0).collect();
	for r in 0..t.rows() {
		let row = t.row(r);
		let (id, st) = (row[0].as_i64().unwrap_or(-1), row[1].as_i64().unwrap_or(-1));
		if st != status::VALID as i64 || failed.contains(&(id as u32)) {
			continue;
		}
		let Some(&dr) = by_id.get(&id) else {
			c.new_rows += 1;
			continue;
		};
		c.rows += 1;
		let drow = db2.row(dr);
		for (k, &(i, j)) in pairs.iter().enumerate() {
			let eq = match (&row[i], &drow[j]) {
				(a @ Value::Str(..), b @ Value::Str(..)) => t.str(a) == db2.str(b),
				(Value::Float(a), Value::Float(b)) => a.to_bits() == b.to_bits(),
				(a, b) => a.as_i64().is_some() && a.as_i64() == b.as_i64(),
			};
			c.values += 1;
			c.per_column[k].1 += 1;
			if eq {
				c.equal += 1;
				c.per_column[k].2 += 1;
			}
		}
	}
	c
}
