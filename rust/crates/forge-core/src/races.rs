//! Races, classes and factions (port of tools/lib/game/races.js). Race masks are u64: Forever's
//! Skyborne bits sit past 32 bits (2^32 Alliance, 2^33 Horde). `None` masks mean unrestricted.

use std::fmt;

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash, PartialOrd, Ord, serde::Serialize, serde::Deserialize)]
pub enum Faction {
	Alliance,
	Horde,
}

impl Faction {
	pub const BOTH: [Faction; 2] = [Faction::Alliance, Faction::Horde];

	/// "Alliance" / "Horde".
	pub fn name(self) -> &'static str {
		match self {
			Faction::Alliance => "Alliance",
			Faction::Horde => "Horde",
		}
	}
	/// "alliance" / "horde" (file names: world-<faction>.json).
	pub fn lower(self) -> &'static str {
		match self {
			Faction::Alliance => "alliance",
			Faction::Horde => "horde",
		}
	}
	/// Parses "Alliance", "alliance", "A", "Horde", "horde", "H".
	pub fn parse(s: &str) -> Option<Faction> {
		match s.to_ascii_lowercase().as_str() {
			"alliance" | "a" => Some(Faction::Alliance),
			"horde" | "h" => Some(Faction::Horde),
			_ => None,
		}
	}
	pub fn other(self) -> Faction {
		match self {
			Faction::Alliance => Faction::Horde,
			Faction::Horde => Faction::Alliance,
		}
	}
	/// Era race bits (0-7) of the faction's races.
	pub fn era_races(self) -> u64 {
		match self {
			Faction::Alliance => 1 | 4 | 8 | 64,
			Faction::Horde => 2 | 16 | 32 | 128,
		}
	}
	/// Skyborne's bit on this side.
	pub fn skyborne_bit(self) -> u64 {
		match self {
			Faction::Alliance => 1 << 32,
			Faction::Horde => 1 << 33,
		}
	}
	/// 1 Alliance, 2 Horde (taxi node faction bits).
	pub fn bit(self) -> u32 {
		match self {
			Faction::Alliance => 1,
			Faction::Horde => 2,
		}
	}
	/// npcs.json faction letter: "A" / "H".
	pub fn letter(self) -> &'static str {
		match self {
			Faction::Alliance => "A",
			Faction::Horde => "H",
		}
	}

	/// Is a race mask open to some race of this faction (world.js maskForFaction)? Era bits
	/// 0-7 of the low 32 bits, or this side's Skyborne bit.
	pub fn mask_open(self, races: u64) -> bool {
		(races & 0xffff_ffff) & self.era_races() != 0 || races & self.skyborne_bit() != 0
	}
}

impl fmt::Display for Faction {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		f.write_str(self.name())
	}
}

/// Is a single bit set in a mask (races.js hasBit)?
pub fn has_bit(mask: u64, bit: u64) -> bool {
	bit > 0 && mask & bit != 0
}

#[derive(Clone, Copy, Debug)]
pub struct ClassInfo {
	pub key: &'static str,
	pub file: &'static str,
	pub bit: u32,
}

/// Classes in races.js order.
pub const CLASSES: [ClassInfo; 9] = [
	ClassInfo { key: "warrior", file: "WARRIOR", bit: 1 },
	ClassInfo { key: "paladin", file: "PALADIN", bit: 2 },
	ClassInfo { key: "hunter", file: "HUNTER", bit: 4 },
	ClassInfo { key: "rogue", file: "ROGUE", bit: 8 },
	ClassInfo { key: "priest", file: "PRIEST", bit: 16 },
	ClassInfo { key: "shaman", file: "SHAMAN", bit: 64 },
	ClassInfo { key: "mage", file: "MAGE", bit: 128 },
	ClassInfo { key: "warlock", file: "WARLOCK", bit: 256 },
	ClassInfo { key: "druid", file: "DRUID", bit: 1024 },
];

pub const ALL_CLASSES: u32 = 1 | 2 | 4 | 8 | 16 | 64 | 128 | 256 | 1024;

pub fn class_by_file(file: &str) -> Option<&'static ClassInfo> {
	CLASSES.iter().find(|c| c.file == file)
}

/// "WARRIOR" -> "Warrior".
pub fn class_label(file: &str) -> String {
	let mut s = String::with_capacity(file.len());
	for (i, ch) in file.chars().enumerate() {
		if i == 0 {
			s.push(ch);
		} else {
			s.extend(ch.to_lowercase());
		}
	}
	s
}

#[derive(Clone, Copy, Debug)]
pub struct RaceInfo {
	pub key: &'static str,
	pub file: &'static str,
	pub alliance: u64,
	pub horde: u64,
}

impl RaceInfo {
	/// The race's bit on a side, 0 when it can't be played there.
	pub fn bit(&self, f: Faction) -> u64 {
		match f {
			Faction::Alliance => self.alliance,
			Faction::Horde => self.horde,
		}
	}
}

/// Races by race file (one entry per file; races.js RACE_BY_FILE order).
pub const RACES: [RaceInfo; 9] = [
	RaceInfo { key: "human", file: "Human", alliance: 1, horde: 0 },
	RaceInfo { key: "orc", file: "Orc", alliance: 0, horde: 2 },
	RaceInfo { key: "dwarf", file: "Dwarf", alliance: 4, horde: 0 },
	RaceInfo { key: "nightelf", file: "NightElf", alliance: 8, horde: 0 },
	RaceInfo { key: "undead", file: "Scourge", alliance: 0, horde: 16 },
	RaceInfo { key: "tauren", file: "Tauren", alliance: 0, horde: 32 },
	RaceInfo { key: "gnome", file: "Gnome", alliance: 64, horde: 0 },
	RaceInfo { key: "troll", file: "Troll", alliance: 0, horde: 128 },
	RaceInfo { key: "skyborne", file: "Skyborne", alliance: 1 << 32, horde: 1 << 33 },
];

pub fn race_by_file(file: &str) -> Option<&'static RaceInfo> {
	RACES.iter().find(|r| r.file == file)
}

/// Race names as guides write them: race files, Scourge written Undead.
pub fn race_label(file: &str) -> &str {
	if file == "Scourge" {
		"Undead"
	} else {
		file
	}
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn skyborne_masks() {
		// quest 783: Human + Skyborne(A) among others.
		assert!(Faction::Alliance.mask_open(4294967373));
		assert!(!Faction::Horde.mask_open(1 << 32));
		assert!(Faction::Horde.mask_open(1 << 33));
		assert_eq!(class_label("WARRIOR"), "Warrior");
		assert_eq!(race_label("Scourge"), "Undead");
	}
}
