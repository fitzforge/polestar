//! The Recorder's account SavedVariables file (`WTF/Account/<account>/SavedVariables/Polestar_Recorder.lua`):
//! `PolestarRecorderDB` as docs/RECORDING.md describes it (schema 2).

use std::collections::BTreeMap;
use std::fmt;

use crate::lua::{self, Value};

/// The schema this library reads.
pub const SCHEMA: u32 = 2;

/// The file name under `WTF/Account/<account>/SavedVariables/`.
pub const FILE_NAME: &str = "Polestar_Recorder.lua";

#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct SavedVars {
	pub schema: u32,
	pub enabled: bool,
	/// 12 base-36 characters, made once per WoW account folder.
	pub install: String,
	/// The last chunk number used.
	pub seq: u64,
	/// The highest chunk the Polestar Client confirmed (from Ack.lua).
	pub acked: u64,
	/// seq -> chunk text.
	pub chunks: BTreeMap<u64, String>,
	/// uiMapID -> the `map` record's fields from `id` on (`id\ttype\tparent\t...`).
	pub maps: BTreeMap<u32, String>,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub enum Error {
	/// Not a readable Lua SavedVariables file.
	Syntax(lua::SyntaxError),
	/// The file has no `PolestarRecorderDB` (or it is nil): the Recorder has not saved anything.
	Missing,
	/// A schema 1 file (Recorder versions before the recording program): nothing to read.
	OldSchema,
	/// A schema newer than this library reads.
	NewSchema(u32),
	/// A field with the wrong type or value.
	Field(&'static str),
}

impl fmt::Display for Error {
	fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
		match self {
			Error::Syntax(e) => write!(f, "not a readable SavedVariables file ({e})"),
			Error::Missing => write!(f, "the Recorder has saved nothing in this file yet"),
			Error::OldSchema => write!(f, "this file is from an older Recorder (schema 1); update the Recorder and play to record in the new format"),
			Error::NewSchema(n) => write!(f, "this file is from a newer Recorder (schema {n}); update this program"),
			Error::Field(name) => write!(f, "PolestarRecorderDB.{name} has an unexpected value"),
		}
	}
}

impl std::error::Error for Error {}

fn is_base36(s: &str) -> bool {
	!s.is_empty() && s.bytes().all(|b| b.is_ascii_digit() || b.is_ascii_lowercase())
}

/// An install id as the addon makes them: 12 base-36 characters.
pub fn valid_install(s: &str) -> bool {
	s.len() == 12 && is_base36(s)
}

/// A character id as the addon makes them: 10 base-36 characters.
pub fn valid_char_id(s: &str) -> bool {
	s.len() == 10 && is_base36(s)
}

pub fn parse(text: &str) -> Result<SavedVars, Error> {
	let vars = lua::parse_assignments(text).map_err(Error::Syntax)?;
	let db = vars.into_iter().rev().find(|(n, _)| n == "PolestarRecorderDB").map(|(_, v)| v).ok_or(Error::Missing)?;
	if !matches!(db, Value::Table(_)) {
		return Err(Error::Missing);
	}
	let schema = match db.get("schema") {
		None | Some(Value::Nil) => return Err(Error::OldSchema),
		Some(v) => v.as_u64().ok_or(Error::Field("schema"))?,
	};
	if schema < SCHEMA as u64 {
		return Err(Error::OldSchema);
	}
	if schema > SCHEMA as u64 {
		return Err(Error::NewSchema(schema.min(u32::MAX as u64) as u32));
	}
	let enabled = match db.get("enabled") {
		None | Some(Value::Nil) => false,
		Some(v) => v.as_bool().ok_or(Error::Field("enabled"))?,
	};
	let install = db.get("install").and_then(Value::as_str).filter(|s| valid_install(s)).ok_or(Error::Field("install"))?.to_string();
	let count = |name: &'static str| -> Result<u64, Error> {
		match db.get(name) {
			None | Some(Value::Nil) => Ok(0),
			Some(v) => v.as_u64().ok_or(Error::Field(name)),
		}
	};
	let seq = count("seq")?;
	let acked = count("acked")?;
	let mut chunks = BTreeMap::new();
	if let Some(t) = db.get("chunks") {
		if !matches!(t, Value::Table(_) | Value::Nil) {
			return Err(Error::Field("chunks"));
		}
		for (k, v) in t.entries() {
			let k = k.as_u64().filter(|k| *k > 0).ok_or(Error::Field("chunks"))?;
			let v = v.as_str().ok_or(Error::Field("chunks"))?;
			chunks.insert(k, v.to_string());
		}
	}
	let mut maps = BTreeMap::new();
	if let Some(t) = db.get("maps") {
		if !matches!(t, Value::Table(_) | Value::Nil) {
			return Err(Error::Field("maps"));
		}
		for (k, v) in t.entries() {
			let k = k.as_u64().filter(|k| *k > 0 && *k <= u32::MAX as u64).ok_or(Error::Field("maps"))?;
			let v = v.as_str().ok_or(Error::Field("maps"))?;
			maps.insert(k as u32, v.to_string());
		}
	}
	Ok(SavedVars { schema: schema as u32, enabled, install, seq, acked, chunks, maps })
}

#[cfg(test)]
mod tests {
	use super::*;

	const FILE: &str = "\nPolestarRecorderDB = {\n\t[\"schema\"] = 2,\n\t[\"enabled\"] = true,\n\t[\"install\"] = \"k3j9x0q2m7ab\",\n\t[\"seq\"] = 41,\n\t[\"acked\"] = 37,\n\t[\"chunks\"] = {\n\t\t[40] = \"chunk\\t0\\t40\\t1700000000\\tabcdefghij\\npos\\t5\",\n\t\t[41] = \"x\",\n\t},\n\t[\"maps\"] = {\n\t\t[1429] = \"1429\\t3\\t1415\\t0\\t-7939.6\\t1535.4\\t-10135.2\\t-2141.6\",\n\t},\n}\nPolestarRecorderAck = nil\n";

	#[test]
	fn reads_the_db() {
		let sv = parse(FILE).unwrap();
		assert_eq!((sv.schema, sv.enabled, sv.install.as_str(), sv.seq, sv.acked), (2, true, "k3j9x0q2m7ab", 41, 37));
		assert_eq!(sv.chunks[&40], "chunk\t0\t40\t1700000000\tabcdefghij\npos\t5");
		assert_eq!(sv.chunks.len(), 2);
		assert!(sv.maps[&1429].starts_with("1429\t3\t1415"));
	}

	#[test]
	fn schema_one_missing_and_bad_fields() {
		assert_eq!(parse("PolestarRecorderDB = { schema = 1, sessions = {} }"), Err(Error::OldSchema));
		assert_eq!(parse("PolestarRecorderDB = { sessions = {} }"), Err(Error::OldSchema));
		assert_eq!(parse("PolestarRecorderDB = nil"), Err(Error::Missing));
		assert_eq!(parse("Other = {}"), Err(Error::Missing));
		assert_eq!(parse("PolestarRecorderDB = { schema = 3 }"), Err(Error::NewSchema(3)));
		assert_eq!(parse("PolestarRecorderDB = { schema = 2, install = \"BAD\" }"), Err(Error::Field("install")));
		assert_eq!(parse("PolestarRecorderDB = { schema = 2, install = \"k3j9x0q2m7ab\", chunks = { [1] = 5 } }"), Err(Error::Field("chunks")));
		assert!(matches!(parse("PolestarRecorderDB = { schema = 2,"), Err(Error::Syntax(_))));
	}
}
