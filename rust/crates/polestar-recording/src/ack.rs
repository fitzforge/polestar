//! The ack file (docs/RECORDING.md "Ack file"): `Interface/AddOns/Polestar_Recorder/Ack.lua`,
//! written by the Polestar Client so the addon can delete chunks the server has. One game folder
//! holds every WoW account's install, so the file maps each install id to its highest
//! acknowledged chunk: `PolestarRecorderAck = { ["<install>"] = <upto>, ... }`.

use std::collections::BTreeMap;
use std::io::{self, Write};
use std::path::Path;

use crate::lua::{self, Value};
use crate::sv::valid_install;

pub const FILE_NAME: &str = "Ack.lua";

/// Records that `install`'s chunks up to `upto` are on the server: reads the ack file in
/// `addon_dir` (the Polestar_Recorder addon folder), raises this install's entry (never lowers
/// it), keeps the other installs' entries, and writes the file atomically (a temporary file, then
/// a rename).
pub fn write(addon_dir: &Path, install: &str, upto: u64) -> io::Result<()> {
	if !valid_install(install) {
		return Err(io::Error::new(io::ErrorKind::InvalidInput, format!("not an install id: {install:?}")));
	}
	let mut acks = read(addon_dir);
	let e = acks.entry(install.to_string()).or_insert(upto);
	*e = (*e).max(upto);
	let mut text = String::from("PolestarRecorderAck = {\n");
	for (i, n) in &acks {
		text.push_str(&format!("\t[\"{i}\"] = {n},\n"));
	}
	text.push_str("}\n");
	let tmp = addon_dir.join(format!("{FILE_NAME}.tmp"));
	{
		let mut f = std::fs::File::create(&tmp)?;
		f.write_all(text.as_bytes())?;
		f.sync_all()?;
	}
	std::fs::rename(&tmp, addon_dir.join(FILE_NAME)).inspect_err(|_| {
		let _ = std::fs::remove_file(&tmp);
	})
}

/// The acks in `addon_dir`: install id -> highest acknowledged chunk. Empty when there is no
/// file, the release's `PolestarRecorderAck = nil`, or an unreadable file; entries that are not
/// an install id and a whole number are left out.
pub fn read(addon_dir: &Path) -> BTreeMap<String, u64> {
	let mut out = BTreeMap::new();
	let Ok(text) = std::fs::read_to_string(addon_dir.join(FILE_NAME)) else { return out };
	let Ok(vars) = lua::parse_assignments(&text) else { return out };
	let Some((_, v)) = vars.into_iter().rev().find(|(n, _)| n == "PolestarRecorderAck") else { return out };
	for (k, n) in v.entries() {
		if let (Value::Str(k), Some(n)) = (k, n.as_u64()) {
			if valid_install(k) {
				out.insert(k.clone(), n);
			}
		}
	}
	out
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn writes_and_reads_the_ack_map() {
		let dir = std::env::temp_dir().join(format!("polestar-ack-{}", std::process::id()));
		std::fs::create_dir_all(&dir).unwrap();
		std::fs::write(dir.join(FILE_NAME), "PolestarRecorderAck = nil\n").unwrap();
		assert!(read(&dir).is_empty());
		write(&dir, "k3j9x0q2m7ab", 37).unwrap();
		assert_eq!(std::fs::read_to_string(dir.join(FILE_NAME)).unwrap(), "PolestarRecorderAck = {\n\t[\"k3j9x0q2m7ab\"] = 37,\n}\n");
		assert!(!dir.join("Ack.lua.tmp").exists());
		// A second account's install keeps the first's entry.
		write(&dir, "0000aaaabbbb", 5).unwrap();
		let acks = read(&dir);
		assert_eq!((acks["k3j9x0q2m7ab"], acks["0000aaaabbbb"]), (37, 5));
		// Raised, never lowered.
		write(&dir, "k3j9x0q2m7ab", 41).unwrap();
		write(&dir, "k3j9x0q2m7ab", 12).unwrap();
		assert_eq!(read(&dir)["k3j9x0q2m7ab"], 41);
		assert_eq!(write(&dir, "\"; os.exit() --", 1).unwrap_err().kind(), io::ErrorKind::InvalidInput);
		assert_eq!(read(&dir).len(), 2);
		// Junk entries and the old single-install form are not acks.
		std::fs::write(dir.join(FILE_NAME), "PolestarRecorderAck = { install = \"k3j9x0q2m7ab\", upto = 3, [\"BAD\"] = 1 }\n").unwrap();
		assert!(read(&dir).is_empty());
		std::fs::remove_dir_all(&dir).unwrap();
	}
}
