//! Port of tools/lib/game/races.js.
//! Races and classes, once for every tool: their names, the client's file
//! names and their bits in the Blizzard masks quests.json and the client's
//! tables carry (docs/ARCHITECTURE.md).

use crate::js::V;
use crate::obj;

pub struct Class {
	pub name: &'static str,
	pub file: &'static str,
	pub bit: f64,
}

/// CLASSES, in the JS object's order (lowercase name -> { file, bit }).
pub const CLASSES: [Class; 9] = [
	Class { name: "warrior", file: "WARRIOR", bit: 1.0 },
	Class { name: "paladin", file: "PALADIN", bit: 2.0 },
	Class { name: "hunter", file: "HUNTER", bit: 4.0 },
	Class { name: "rogue", file: "ROGUE", bit: 8.0 },
	Class { name: "priest", file: "PRIEST", bit: 16.0 },
	Class { name: "shaman", file: "SHAMAN", bit: 64.0 },
	Class { name: "mage", file: "MAGE", bit: 128.0 },
	Class { name: "warlock", file: "WARLOCK", bit: 256.0 },
	Class { name: "druid", file: "DRUID", bit: 1024.0 },
];
pub const CLASS_FILES: [&str; 9] = ["WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID"];
pub const ALL_CLASSES: f64 = 1503.0;

/// `CLASSES[name]` (an own property: the name is already lower case).
pub fn class(name: &str) -> Option<&'static Class> {
	CLASSES.iter().find(|c| c.name == name)
}

/// `CLASS_BY_FILE[file]`.
pub fn class_by_file(file: &str) -> Option<&'static Class> {
	CLASSES.iter().find(|c| c.file == file)
}

pub struct Race {
	pub name: &'static str,
	pub file: &'static str,
	/// Per side the race can be played on, its bit in quest race masks.
	pub sides: &'static [(&'static str, f64)],
}

// Race names -> the client's race file (UnitRace's second return, ChrRaces
// ClientFileString) and, per side the race can be played on, its bit in quest
// race masks (2^PlayableRaceBit). Skyborne is one race file on both sides
// (ChrRaces 95 Alliance, 96 Horde) with bits past 32-bit bitwise operators.
pub const RACES: [Race; 10] = [
	Race { name: "human", file: "Human", sides: &[("Alliance", 1.0)] },
	Race { name: "orc", file: "Orc", sides: &[("Horde", 2.0)] },
	Race { name: "dwarf", file: "Dwarf", sides: &[("Alliance", 4.0)] },
	Race { name: "nightelf", file: "NightElf", sides: &[("Alliance", 8.0)] },
	Race { name: "undead", file: "Scourge", sides: &[("Horde", 16.0)] },
	Race { name: "scourge", file: "Scourge", sides: &[("Horde", 16.0)] },
	Race { name: "tauren", file: "Tauren", sides: &[("Horde", 32.0)] },
	Race { name: "gnome", file: "Gnome", sides: &[("Alliance", 64.0)] },
	Race { name: "troll", file: "Troll", sides: &[("Horde", 128.0)] },
	Race { name: "skyborne", file: "Skyborne", sides: &[("Alliance", 4294967296.0), ("Horde", 8589934592.0)] },
];
/// Object.keys(RACE_BY_FILE).
pub const RACE_FILES: [&str; 9] = ["Human", "Orc", "Dwarf", "NightElf", "Scourge", "Tauren", "Gnome", "Troll", "Skyborne"];
pub const SIDES: [&str; 2] = ["Alliance", "Horde"];

/// `RACES[name]`.
pub fn race(name: &str) -> Option<&'static Race> {
	RACES.iter().find(|r| r.name == name)
}

/// `RACE_BY_FILE[file]` (the last race with that file, as the JS map keeps).
pub fn race_by_file_ref(file: &str) -> Option<&'static Race> {
	RACES.iter().rev().find(|r| r.file == file)
}

/// `RACE_BY_FILE[file]` as a JS value `{ file, sides: { <side>: bit } }`, Undef if unknown.
pub fn race_by_file(file: &str) -> V {
	match race_by_file_ref(file) {
		Some(r) => {
			let sides = obj! {};
			for (s, b) in r.sides {
				sides.set(s, *b);
			}
			V::Obj(obj! { "file" => r.file, "sides" => sides })
		}
		None => V::Undef,
	}
}

/// Skyborne's bit on each side, past 32 bits: only arithmetic (has_bit) reads it.
pub const SKYBORNE_BIT: [(&str, f64); 2] = [("Alliance", 4294967296.0), ("Horde", 8589934592.0)];
/// The Era races of each side (bits 0-7), safe for 32-bit bitwise operators.
pub const FACTION_RACES: [(&str, f64); 2] = [("Alliance", 77.0), ("Horde", 178.0)];
pub const ALL_RACES: f64 = 255.0;

/// Is a single power-of-two bit set in a mask? Arithmetic, so bits past 2^31 work.
pub fn has_bit(mask: f64, bit: f64) -> bool {
	bit > 0.0 && (mask / bit).floor() % 2.0 == 1.0
}

/// Names as guides and reports write them: race files except Scourge (written Undead).
pub fn race_label(file: &str) -> String {
	if file == "Scourge" {
		"Undead".to_string()
	} else {
		file.to_string()
	}
}

/// Classes in title case.
pub fn class_label(file: &str) -> String {
	let mut u = file.encode_utf16();
	match u.next() {
		None => String::new(),
		Some(first) => {
			let rest: Vec<u16> = u.collect();
			let mut s = String::from_utf16_lossy(&[first]);
			s.push_str(&String::from_utf16_lossy(&rest).to_lowercase());
			s
		}
	}
}
