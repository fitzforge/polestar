//! The client's WDB caches (`<flavor>/Cache/WDB/<locale>/*.wdb`): what the server answered to
//! the client's quest, creature and gameobject queries, kept on disk between sessions. Read-only.
//!
//! A file is a 24-byte header (magic, build, reversed locale, max record size, record version,
//! cache version) then `(id u32, len u32, data[len])` records up to the end or an `(0, 0)`
//! terminator. Integers are little-endian; bit fields are MSB-first within each byte (the
//! server's `WriteBits`), and a flush drops to the next byte boundary. Each record decoder knows
//! one record version (quest 12, creature 4, gameobject 4) and rejects any other, and every
//! decoder must consume its record exactly: an overrun or bytes left over are an error.

use std::path::Path;

use serde_json::{json, Map, Value};

/// A WDB cache file: its header and raw records in file order.
#[derive(Clone, Debug)]
pub struct WdbFile {
	/// The four magic bytes as stored (`TSQW` quest, `BOMW` creature, `BOGW` gameobject, `CPNW` npc).
	pub magic: [u8; 4],
	pub build: u32,
	/// The locale as written in the game's terms (`enUS`; the file stores it reversed).
	pub locale: String,
	pub max_record_size: u32,
	pub record_version: u32,
	pub cache_version: u32,
	/// `(id, data)` per record.
	pub records: Vec<(u32, Vec<u8>)>,
}

/// The kinds of WDB file this module knows, by magic.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Kind {
	Quest,
	Creature,
	GameObject,
	Npc,
	PageText,
	Petition,
}

impl Kind {
	/// The kind of a file with these magic bytes.
	pub fn of_magic(magic: &[u8; 4]) -> Option<Kind> {
		Some(match magic {
			b"TSQW" => Kind::Quest,
			b"BOMW" => Kind::Creature,
			b"BOGW" => Kind::GameObject,
			b"CPNW" => Kind::Npc,
			b"XTPW" => Kind::PageText,
			b"NTPW" => Kind::Petition,
			_ => return None,
		})
	}

	/// The file name the client gives this kind's cache.
	pub fn file_name(self) -> &'static str {
		match self {
			Kind::Quest => "questcache.wdb",
			Kind::Creature => "creaturecache.wdb",
			Kind::GameObject => "gameobjectcache.wdb",
			Kind::Npc => "npccache.wdb",
			Kind::PageText => "pagetextcache.wdb",
			Kind::Petition => "petitioncache.wdb",
		}
	}

	/// The record version this module decodes, None for kinds it does not decode.
	pub fn record_version(self) -> Option<u32> {
		match self {
			Kind::Quest => Some(12),
			Kind::Creature | Kind::GameObject => Some(4),
			_ => None,
		}
	}
}

const HEADER: usize = 24;

impl WdbFile {
	/// Reads a WDB file.
	pub fn read(path: &Path) -> Result<WdbFile, String> {
		let b = std::fs::read(path).map_err(|e| format!("{}: {e}", path.display()))?;
		WdbFile::parse(&b).map_err(|e| format!("{}: {e}", path.display()))
	}

	/// Parses the bytes of a WDB file.
	pub fn parse(b: &[u8]) -> Result<WdbFile, String> {
		if b.len() < HEADER {
			return Err(format!("WDB: {} bytes, shorter than the {HEADER}-byte header", b.len()));
		}
		let u = |o: usize| u32::from_le_bytes(b[o..o + 4].try_into().unwrap());
		let mut locale: Vec<u8> = b[8..12].to_vec();
		locale.reverse();
		let mut f = WdbFile {
			magic: b[0..4].try_into().unwrap(),
			build: u(4),
			locale: String::from_utf8_lossy(&locale).into_owned(),
			max_record_size: u(12),
			record_version: u(16),
			cache_version: u(20),
			records: Vec::new(),
		};
		let mut o = HEADER;
		while o < b.len() {
			if o + 8 > b.len() {
				return Err(format!("WDB: record header at {o} overruns the file ({} bytes)", b.len()));
			}
			let (id, len) = (u(o), u(o + 4) as usize);
			o += 8;
			if id == 0 && len == 0 {
				break;
			}
			let data = b.get(o..o + len).ok_or_else(|| format!("WDB: record {id} at {} ({len} bytes) overruns the file ({} bytes)", o - 8, b.len()))?;
			f.records.push((id, data.to_vec()));
			o += len;
		}
		Ok(f)
	}

	/// The file's kind by its magic.
	pub fn kind(&self) -> Option<Kind> {
		Kind::of_magic(&self.magic)
	}

	/// Err unless this is a `kind` file of the record version its decoder knows.
	pub fn check(&self, kind: Kind) -> Result<(), String> {
		if self.kind() != Some(kind) {
			return Err(format!("not a {} (magic {:?})", kind.file_name(), String::from_utf8_lossy(&self.magic)));
		}
		match kind.record_version() {
			Some(v) if v == self.record_version => Ok(()),
			Some(v) => Err(format!("{}: record version {}, the decoder knows version {v} only", kind.file_name(), self.record_version)),
			None => Err(format!("{}: format not decoded", kind.file_name())),
		}
	}

	/// Each record decoded with `decode` once the file passes [`WdbFile::check`].
	pub fn decode<T>(&self, kind: Kind, decode: fn(&[u8]) -> Result<T, String>) -> Result<Vec<(u32, Result<T, String>)>, String> {
		self.check(kind)?;
		Ok(self.records.iter().map(|(id, d)| (*id, decode(d))).collect())
	}
}

/// A little-endian byte reader with an MSB-first bit reader over the same bytes. Byte reads leave
/// the bit state alone; [`BitReader::flush`] drops the rest of a partly read byte.
pub struct BitReader<'a> {
	b: &'a [u8],
	pos: usize,
	/// Bits left in `cur` (0: the next bit read takes a new byte).
	bits_left: u32,
	cur: u8,
}

impl<'a> BitReader<'a> {
	pub fn new(b: &'a [u8]) -> BitReader<'a> {
		BitReader { b, pos: 0, bits_left: 0, cur: 0 }
	}

	/// The byte position (a partly read byte counts as read).
	pub fn pos(&self) -> usize {
		self.pos
	}

	/// The bytes not read yet.
	pub fn remaining(&self) -> usize {
		self.b.len() - self.pos
	}

	/// `n` bytes.
	pub fn bytes(&mut self, n: usize) -> Result<&'a [u8], String> {
		let s = self.b.get(self.pos..self.pos + n).ok_or_else(|| format!("{n} bytes at {} overrun the record ({} bytes)", self.pos, self.b.len()))?;
		self.pos += n;
		Ok(s)
	}

	fn arr<const N: usize>(&mut self) -> Result<[u8; N], String> {
		Ok(self.bytes(N)?.try_into().unwrap())
	}

	pub fn u8(&mut self) -> Result<u8, String> {
		Ok(self.arr::<1>()?[0])
	}
	pub fn i8(&mut self) -> Result<i8, String> {
		Ok(self.u8()? as i8)
	}
	pub fn u32(&mut self) -> Result<u32, String> {
		Ok(u32::from_le_bytes(self.arr()?))
	}
	pub fn i32(&mut self) -> Result<i32, String> {
		Ok(i32::from_le_bytes(self.arr()?))
	}
	pub fn i64(&mut self) -> Result<i64, String> {
		Ok(i64::from_le_bytes(self.arr()?))
	}
	pub fn f32(&mut self) -> Result<f32, String> {
		Ok(f32::from_le_bytes(self.arr()?))
	}

	/// A count read as i32: Err when negative.
	pub fn count(&mut self, what: &str) -> Result<usize, String> {
		let at = self.pos;
		let n = self.i32()?;
		usize::try_from(n).map_err(|_| format!("{what} {n} at {at} is negative"))
	}

	/// `n` bits, most significant first.
	pub fn bits(&mut self, n: u32) -> Result<u32, String> {
		let mut v = 0u32;
		for _ in 0..n {
			if self.bits_left == 0 {
				self.cur = self.u8()?;
				self.bits_left = 8;
			}
			self.bits_left -= 1;
			v = (v << 1) | ((self.cur >> self.bits_left) & 1) as u32;
		}
		Ok(v)
	}

	/// Drops the rest of a partly read byte.
	pub fn flush(&mut self) {
		self.bits_left = 0;
	}

	/// `n` bytes of text (no terminator), invalid UTF-8 replaced.
	pub fn str(&mut self, n: usize) -> Result<String, String> {
		Ok(String::from_utf8_lossy(self.bytes(n)?).into_owned())
	}

	/// A NUL-terminated string (the NUL consumed).
	pub fn cstr(&mut self) -> Result<String, String> {
		let rest = &self.b[self.pos..];
		let end = rest.iter().position(|&c| c == 0).ok_or_else(|| format!("unterminated string at {}", self.pos))?;
		let s = String::from_utf8_lossy(&rest[..end]).into_owned();
		self.pos += end + 1;
		Ok(s)
	}

	/// Err unless every byte was read.
	pub fn finish(&self) -> Result<(), String> {
		match self.remaining() {
			0 => Ok(()),
			n => Err(format!("{n} bytes left over after {} of {}", self.pos, self.b.len())),
		}
	}
}

/// A float as JSON with its shortest f32 decimal form (2.375, 0.1), not the f64 widening.
pub fn json_f32(v: f32) -> Value {
	v.to_string().parse::<f64>().ok().and_then(serde_json::Number::from_f64).map_or(Value::Null, Value::Number)
}

/// One quest objective of a questcache record.
#[derive(Clone, Debug, PartialEq)]
pub struct QuestObjective {
	pub id: i32,
	/// 0 monster, 1 item, 10 areatrigger, 14 criteria tree, others seen (19).
	pub kind: i32,
	pub storage_index: i8,
	pub object_id: i32,
	pub amount: i32,
	pub flags: u32,
	pub flags2: u32,
	pub u25: i32,
	pub u29: i32,
	pub u33: i32,
	pub u37: i32,
	/// The bit after the description length (meaning unknown).
	pub unk_bit: u32,
	pub description: String,
}

/// A questcache record (version 12).
#[derive(Clone, Debug, PartialEq)]
pub struct Quest {
	pub quest_id: i32,
	pub quest_type: i32,
	pub quest_level: i32,
	pub scaling_faction_group: i32,
	pub min_level: i32,
	pub quest_package_id: i32,
	/// Negative: a QuestSort id; positive: an AreaTable id.
	pub quest_sort_id: i32,
	pub quest_info_id: i32,
	pub suggested_group_num: i32,
	pub reward_next_quest: i32,
	pub reward_xp_difficulty: i32,
	pub reward_xp_multiplier: f32,
	pub reward_money: i32,
	pub reward_money_difficulty: i32,
	pub reward_money_multiplier: f32,
	pub reward_bonus_money: i32,
	pub reward_spell: i32,
	pub reward_honor: i32,
	pub reward_kill_honor: f32,
	pub reward_artifact_xp_difficulty: i32,
	pub unk21: i32,
	pub reward_artifact_xp_multiplier: f32,
	pub reward_artifact_category_id: i32,
	pub start_item: i32,
	pub flags: i32,
	pub flags_ex: i32,
	pub flags_ex2: i32,
	pub flags_ex3: i32,
	/// (ItemID, Amount, ItemDrop, ItemDropQuantity)
	pub reward_items: [[i32; 4]; 4],
	/// (ItemID, Quantity, DisplayID)
	pub reward_choice_items: [[i32; 3]; 6],
	pub poi_continent: i32,
	pub poi_x: f32,
	pub poi_y: f32,
	pub poi_priority: i32,
	pub reward_title: i32,
	pub reward_arena_points: i32,
	pub reward_skill_line_id: i32,
	pub reward_num_skill_ups: i32,
	pub portrait_giver: i32,
	pub portrait_giver_mount: i32,
	pub portrait_turn_in: i32,
	pub unk74: i32,
	/// (FactionID, Value, Override, CapIn)
	pub reward_factions: [[i32; 4]; 5],
	pub reward_faction_flags: i32,
	/// (ID, Qty)
	pub reward_currencies: [[i32; 2]; 4],
	pub accepted_sound_kit_id: i32,
	pub complete_sound_kit_id: i32,
	pub area_group_id: i32,
	pub time_allowed: i32,
	pub unk108: i32,
	/// -1: every race.
	pub allowable_races: i64,
	pub expansion: i32,
	/// Unk114..Unk121.
	pub unk114: [i32; 8],
	/// (SpellID, PlayerConditionID, Type)
	pub reward_display_spells: Vec<[i32; 3]>,
	pub objectives: Vec<QuestObjective>,
	pub treasure_pickers: Vec<i32>,
	pub log_title: String,
	pub log_description: String,
	pub quest_description: String,
	pub area_description: String,
	pub portrait_giver_text: String,
	pub portrait_giver_name: String,
	pub portrait_turn_in_text: String,
	pub portrait_turn_in_name: String,
	pub quest_completion_log: String,
	pub ready_for_translation: u32,
}

/// The bit widths of the nine quest text lengths, in the order the texts follow.
const QUEST_TEXT_BITS: [u32; 9] = [9, 12, 12, 9, 10, 8, 10, 8, 11];

/// Decodes a questcache record (version 12): Err on an overrun or bytes left over.
pub fn decode_quest(b: &[u8]) -> Result<Quest, String> {
	let r = &mut BitReader::new(b);
	let quest_id = r.i32()?;
	let quest_type = r.i32()?;
	let quest_level = r.i32()?;
	let scaling_faction_group = r.i32()?;
	let min_level = r.i32()?;
	let quest_package_id = r.i32()?;
	let quest_sort_id = r.i32()?;
	let quest_info_id = r.i32()?;
	let suggested_group_num = r.i32()?;
	let reward_next_quest = r.i32()?;
	let reward_xp_difficulty = r.i32()?;
	let reward_xp_multiplier = r.f32()?;
	let reward_money = r.i32()?;
	let reward_money_difficulty = r.i32()?;
	let reward_money_multiplier = r.f32()?;
	let reward_bonus_money = r.i32()?;
	let num_display_spells = r.count("NumRewardDisplaySpell")?;
	let reward_spell = r.i32()?;
	let reward_honor = r.i32()?;
	let reward_kill_honor = r.f32()?;
	let reward_artifact_xp_difficulty = r.i32()?;
	let unk21 = r.i32()?;
	let reward_artifact_xp_multiplier = r.f32()?;
	let reward_artifact_category_id = r.i32()?;
	let start_item = r.i32()?;
	let flags = r.i32()?;
	let flags_ex = r.i32()?;
	let flags_ex2 = r.i32()?;
	let flags_ex3 = r.i32()?;
	let mut reward_items = [[0; 4]; 4];
	for it in &mut reward_items {
		for v in it {
			*v = r.i32()?;
		}
	}
	let mut reward_choice_items = [[0; 3]; 6];
	for it in &mut reward_choice_items {
		for v in it {
			*v = r.i32()?;
		}
	}
	let poi_continent = r.i32()?;
	let poi_x = r.f32()?;
	let poi_y = r.f32()?;
	let poi_priority = r.i32()?;
	let reward_title = r.i32()?;
	let reward_arena_points = r.i32()?;
	let reward_skill_line_id = r.i32()?;
	let reward_num_skill_ups = r.i32()?;
	let portrait_giver = r.i32()?;
	let portrait_giver_mount = r.i32()?;
	let portrait_turn_in = r.i32()?;
	let unk74 = r.i32()?;
	let mut reward_factions = [[0; 4]; 5];
	for it in &mut reward_factions {
		for v in it {
			*v = r.i32()?;
		}
	}
	let reward_faction_flags = r.i32()?;
	let mut reward_currencies = [[0; 2]; 4];
	for it in &mut reward_currencies {
		for v in it {
			*v = r.i32()?;
		}
	}
	let accepted_sound_kit_id = r.i32()?;
	let complete_sound_kit_id = r.i32()?;
	let area_group_id = r.i32()?;
	let time_allowed = r.i32()?;
	let unk108 = r.i32()?;
	let num_objectives = r.count("NumObjectives")?;
	let allowable_races = r.i64()?;
	let num_treasure_pickers = r.count("NumTreasurePickers")?;
	let expansion = r.i32()?;
	let mut unk114 = [0; 8];
	for v in &mut unk114 {
		*v = r.i32()?;
	}
	// Counts bound by what is left, so a corrupt count fails fast instead of allocating.
	let cap = |n: usize, each: usize, r: &BitReader| if n.saturating_mul(each) > r.remaining() { Err(format!("{n} entries of {each} bytes overrun the record at {}", r.pos())) } else { Ok(n) };
	let mut reward_display_spells = Vec::with_capacity(cap(num_display_spells, 12, r)?);
	for _ in 0..num_display_spells {
		reward_display_spells.push([r.i32()?, r.i32()?, r.i32()?]);
	}
	let mut objectives = Vec::with_capacity(cap(num_objectives, 43, r)?);
	for _ in 0..num_objectives {
		let mut o = QuestObjective {
			id: r.i32()?,
			kind: r.i32()?,
			storage_index: r.i8()?,
			object_id: r.i32()?,
			amount: r.i32()?,
			flags: r.u32()?,
			flags2: r.u32()?,
			u25: r.i32()?,
			u29: r.i32()?,
			u33: r.i32()?,
			u37: r.i32()?,
			unk_bit: 0,
			description: String::new(),
		};
		let len = r.bits(8)? as usize;
		o.unk_bit = r.bits(1)?;
		r.flush();
		o.description = r.str(len)?;
		objectives.push(o);
	}
	let mut treasure_pickers = Vec::with_capacity(cap(num_treasure_pickers, 4, r)?);
	for _ in 0..num_treasure_pickers {
		treasure_pickers.push(r.i32()?);
	}
	let mut lens = [0usize; 9];
	for (l, bits) in lens.iter_mut().zip(QUEST_TEXT_BITS) {
		*l = r.bits(bits)? as usize;
	}
	let ready_for_translation = r.bits(1)?;
	r.flush();
	let mut texts: [String; 9] = Default::default();
	for (t, l) in texts.iter_mut().zip(lens) {
		*t = r.str(l)?;
	}
	r.finish()?;
	let [log_title, log_description, quest_description, area_description, portrait_giver_text, portrait_giver_name, portrait_turn_in_text, portrait_turn_in_name, quest_completion_log] = texts;
	Ok(Quest {
		quest_id,
		quest_type,
		quest_level,
		scaling_faction_group,
		min_level,
		quest_package_id,
		quest_sort_id,
		quest_info_id,
		suggested_group_num,
		reward_next_quest,
		reward_xp_difficulty,
		reward_xp_multiplier,
		reward_money,
		reward_money_difficulty,
		reward_money_multiplier,
		reward_bonus_money,
		reward_spell,
		reward_honor,
		reward_kill_honor,
		reward_artifact_xp_difficulty,
		unk21,
		reward_artifact_xp_multiplier,
		reward_artifact_category_id,
		start_item,
		flags,
		flags_ex,
		flags_ex2,
		flags_ex3,
		reward_items,
		reward_choice_items,
		poi_continent,
		poi_x,
		poi_y,
		poi_priority,
		reward_title,
		reward_arena_points,
		reward_skill_line_id,
		reward_num_skill_ups,
		portrait_giver,
		portrait_giver_mount,
		portrait_turn_in,
		unk74,
		reward_factions,
		reward_faction_flags,
		reward_currencies,
		accepted_sound_kit_id,
		complete_sound_kit_id,
		area_group_id,
		time_allowed,
		unk108,
		allowable_races,
		expansion,
		unk114,
		reward_display_spells,
		objectives,
		treasure_pickers,
		log_title,
		log_description,
		quest_description,
		area_description,
		portrait_giver_text,
		portrait_giver_name,
		portrait_turn_in_text,
		portrait_turn_in_name,
		quest_completion_log,
		ready_for_translation,
	})
}

impl Quest {
	/// The record as a JSON object (field names as in the format notes; arrays of tuples as arrays).
	pub fn to_json(&self) -> Value {
		let mut m = Map::new();
		let mut put = |k: &str, v: Value| {
			m.insert(k.to_string(), v);
		};
		put("QuestID", json!(self.quest_id));
		put("QuestType", json!(self.quest_type));
		put("QuestLevel", json!(self.quest_level));
		put("ScalingFactionGroup", json!(self.scaling_faction_group));
		put("MinLevel", json!(self.min_level));
		put("QuestPackageID", json!(self.quest_package_id));
		put("QuestSortID", json!(self.quest_sort_id));
		put("QuestInfoID", json!(self.quest_info_id));
		put("SuggestedGroupNum", json!(self.suggested_group_num));
		put("RewardNextQuest", json!(self.reward_next_quest));
		put("RewardXPDifficulty", json!(self.reward_xp_difficulty));
		put("RewardXPMultiplier", json_f32(self.reward_xp_multiplier));
		put("RewardMoney", json!(self.reward_money));
		put("RewardMoneyDifficulty", json!(self.reward_money_difficulty));
		put("RewardMoneyMultiplier", json_f32(self.reward_money_multiplier));
		put("RewardBonusMoney", json!(self.reward_bonus_money));
		put("NumRewardDisplaySpell", json!(self.reward_display_spells.len()));
		put("RewardSpell", json!(self.reward_spell));
		put("RewardHonor", json!(self.reward_honor));
		put("RewardKillHonor", json_f32(self.reward_kill_honor));
		put("RewardArtifactXPDifficulty", json!(self.reward_artifact_xp_difficulty));
		put("Unk21", json!(self.unk21));
		put("RewardArtifactXPMultiplier", json_f32(self.reward_artifact_xp_multiplier));
		put("RewardArtifactCategoryID", json!(self.reward_artifact_category_id));
		put("StartItem", json!(self.start_item));
		put("Flags", json!(self.flags));
		put("FlagsEx", json!(self.flags_ex));
		put("FlagsEx2", json!(self.flags_ex2));
		put("FlagsEx3", json!(self.flags_ex3));
		put("RewardItems", json!(self.reward_items));
		put("RewardChoiceItems", json!(self.reward_choice_items));
		put("POIContinent", json!(self.poi_continent));
		put("POIx", json_f32(self.poi_x));
		put("POIy", json_f32(self.poi_y));
		put("POIPriority", json!(self.poi_priority));
		put("RewardTitle", json!(self.reward_title));
		put("RewardArenaPoints", json!(self.reward_arena_points));
		put("RewardSkillLineID", json!(self.reward_skill_line_id));
		put("RewardNumSkillUps", json!(self.reward_num_skill_ups));
		put("PortraitGiver", json!(self.portrait_giver));
		put("PortraitGiverMount", json!(self.portrait_giver_mount));
		put("PortraitTurnIn", json!(self.portrait_turn_in));
		put("Unk74", json!(self.unk74));
		put("RewardFactions", json!(self.reward_factions));
		put("RewardFactionFlags", json!(self.reward_faction_flags));
		put("RewardCurrencies", json!(self.reward_currencies));
		put("AcceptedSoundKitID", json!(self.accepted_sound_kit_id));
		put("CompleteSoundKitID", json!(self.complete_sound_kit_id));
		put("AreaGroupID", json!(self.area_group_id));
		put("TimeAllowed", json!(self.time_allowed));
		put("Unk108", json!(self.unk108));
		put("NumObjectives", json!(self.objectives.len()));
		put("AllowableRaces", json!(self.allowable_races));
		put("NumTreasurePickers", json!(self.treasure_pickers.len()));
		put("Expansion", json!(self.expansion));
		for (i, v) in self.unk114.iter().enumerate() {
			put(&format!("Unk{}", 114 + i), json!(v));
		}
		put("RewardDisplaySpells", json!(self.reward_display_spells));
		let objectives: Vec<Value> = self
			.objectives
			.iter()
			.map(|o| {
				json!({
					"ID": o.id, "Type": o.kind, "StorageIndex": o.storage_index, "ObjectID": o.object_id, "Amount": o.amount,
					"Flags": o.flags, "Flags2": o.flags2, "U25": o.u25, "U29": o.u29, "U33": o.u33, "U37": o.u37,
					"Bit": o.unk_bit, "Description": o.description,
				})
			})
			.collect();
		put("Objectives", Value::Array(objectives));
		put("TreasurePickers", json!(self.treasure_pickers));
		put("ReadyForTranslation", json!(self.ready_for_translation));
		put("LogTitle", json!(self.log_title));
		put("LogDescription", json!(self.log_description));
		put("QuestDescription", json!(self.quest_description));
		put("AreaDescription", json!(self.area_description));
		put("PortraitGiverText", json!(self.portrait_giver_text));
		put("PortraitGiverName", json!(self.portrait_giver_name));
		put("PortraitTurnInText", json!(self.portrait_turn_in_text));
		put("PortraitTurnInName", json!(self.portrait_turn_in_name));
		put("QuestCompletionLog", json!(self.quest_completion_log));
		Value::Object(m)
	}
}

/// One display of a creaturecache record.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct CreatureDisplay {
	pub display_id: i32,
	pub scale: f32,
	pub probability: f32,
}

/// A creaturecache record (version 4). No level and no faction in this format.
#[derive(Clone, Debug, PartialEq)]
pub struct Creature {
	pub leader: u32,
	pub name: [String; 4],
	pub name_alt: [String; 4],
	pub flags: [u32; 2],
	pub unk8: u32,
	pub creature_type: u8,
	pub creature_family: i32,
	pub classification: i32,
	pub unk21: i32,
	pub unk25: u8,
	pub total_probability: f32,
	pub displays: Vec<CreatureDisplay>,
	pub hp_multi: f32,
	pub energy_multi: f32,
	pub movement_info_id: i32,
	pub health_scaling_expansion: i32,
	pub required_expansion: i32,
	pub vignette_id: i32,
	pub class: i32,
	pub creature_difficulty_id: i32,
	pub widget_set_id: i32,
	pub widget_set_unit_condition_id: i32,
	pub title: String,
	pub title_alt: String,
	pub cursor_name: String,
	pub quest_items: Vec<i32>,
	pub quest_currencies: Vec<i32>,
}

/// Decodes a creaturecache record (version 4): Err on an overrun or bytes left over.
pub fn decode_creature(b: &[u8]) -> Result<Creature, String> {
	let r = &mut BitReader::new(b);
	let title_len = r.bits(11)?;
	let title_alt_len = r.bits(11)?;
	let cursor_len = r.bits(6)?;
	let leader = r.bits(1)?;
	let mut name_lens = [(0, 0); 4];
	for l in &mut name_lens {
		*l = (r.bits(11)?, r.bits(11)?);
	}
	r.flush();
	let mut name: [String; 4] = Default::default();
	let mut name_alt: [String; 4] = Default::default();
	for (i, (a, b)) in name_lens.into_iter().enumerate() {
		if a > 0 {
			name[i] = r.cstr()?;
		}
		if b > 0 {
			name_alt[i] = r.cstr()?;
		}
	}
	let flags = [r.u32()?, r.u32()?];
	let unk8 = r.u32()?;
	let creature_type = r.u8()?;
	let creature_family = r.i32()?;
	let classification = r.i32()?;
	let unk21 = r.i32()?;
	let unk25 = r.u8()?;
	let num_displays = r.count("NumDisplays")?;
	let total_probability = r.f32()?;
	if num_displays.saturating_mul(12) > r.remaining() {
		return Err(format!("{num_displays} displays overrun the record at {}", r.pos()));
	}
	let mut displays = Vec::with_capacity(num_displays);
	for _ in 0..num_displays {
		displays.push(CreatureDisplay { display_id: r.i32()?, scale: r.f32()?, probability: r.f32()? });
	}
	let hp_multi = r.f32()?;
	let energy_multi = r.f32()?;
	let num_items = r.count("NumQuestItems")?;
	let num_currencies = r.count("NumQuestCurrencies")?;
	let movement_info_id = r.i32()?;
	let health_scaling_expansion = r.i32()?;
	let required_expansion = r.i32()?;
	let vignette_id = r.i32()?;
	let class = r.i32()?;
	let creature_difficulty_id = r.i32()?;
	let widget_set_id = r.i32()?;
	let widget_set_unit_condition_id = r.i32()?;
	let title = if title_len > 0 { r.cstr()? } else { String::new() };
	let title_alt = if title_alt_len > 0 { r.cstr()? } else { String::new() };
	let cursor_name = if cursor_len > 0 { r.cstr()? } else { String::new() };
	if num_items.saturating_add(num_currencies).saturating_mul(4) > r.remaining() {
		return Err(format!("{num_items} quest items and {num_currencies} currencies overrun the record at {}", r.pos()));
	}
	let quest_items = (0..num_items).map(|_| r.i32()).collect::<Result<_, _>>()?;
	let quest_currencies = (0..num_currencies).map(|_| r.i32()).collect::<Result<_, _>>()?;
	r.finish()?;
	Ok(Creature {
		leader,
		name,
		name_alt,
		flags,
		unk8,
		creature_type,
		creature_family,
		classification,
		unk21,
		unk25,
		total_probability,
		displays,
		hp_multi,
		energy_multi,
		movement_info_id,
		health_scaling_expansion,
		required_expansion,
		vignette_id,
		class,
		creature_difficulty_id,
		widget_set_id,
		widget_set_unit_condition_id,
		title,
		title_alt,
		cursor_name,
		quest_items,
		quest_currencies,
	})
}

impl Creature {
	/// The record as a JSON object (displays as `[CreatureDisplayID, Scale, Probability]`).
	pub fn to_json(&self) -> Value {
		let displays: Vec<Value> = self.displays.iter().map(|d| json!([d.display_id, json_f32(d.scale), json_f32(d.probability)])).collect();
		json!({
			"Leader": self.leader, "Name": self.name, "NameAlt": self.name_alt, "Flags": self.flags, "Unk8": self.unk8,
			"CreatureType": self.creature_type, "CreatureFamily": self.creature_family, "Classification": self.classification,
			"Unk21": self.unk21, "Unk25": self.unk25, "TotalProbability": json_f32(self.total_probability), "Displays": displays,
			"HpMulti": json_f32(self.hp_multi), "EnergyMulti": json_f32(self.energy_multi), "MovementInfoID": self.movement_info_id,
			"HealthScalingExpansion": self.health_scaling_expansion, "RequiredExpansion": self.required_expansion,
			"VignetteID": self.vignette_id, "Class": self.class, "CreatureDifficultyID": self.creature_difficulty_id,
			"WidgetSetID": self.widget_set_id, "WidgetSetUnitConditionID": self.widget_set_unit_condition_id,
			"Title": self.title, "TitleAlt": self.title_alt, "CursorName": self.cursor_name,
			"QuestItems": self.quest_items, "QuestCurrencies": self.quest_currencies,
		})
	}
}

/// The number of `Data` words of a gameobjectcache record.
pub const GAMEOBJECT_DATA: usize = 35;

/// A gameobjectcache record (version 4).
#[derive(Clone, Debug, PartialEq)]
pub struct GameObject {
	pub kind: u32,
	pub display_id: u32,
	pub name: [String; 4],
	pub icon_name: String,
	pub cast_bar_caption: String,
	pub unk_string: String,
	pub data: [i32; GAMEOBJECT_DATA],
	pub size: f32,
	pub quest_items: Vec<i32>,
	pub content_tuning_id: i32,
	pub unk: i32,
}

/// Decodes a gameobjectcache record (version 4): Err on an overrun or bytes left over.
pub fn decode_gameobject(b: &[u8]) -> Result<GameObject, String> {
	let r = &mut BitReader::new(b);
	let kind = r.u32()?;
	let display_id = r.u32()?;
	let mut name: [String; 4] = Default::default();
	for n in &mut name {
		*n = r.cstr()?;
	}
	let icon_name = r.cstr()?;
	let cast_bar_caption = r.cstr()?;
	let unk_string = r.cstr()?;
	let mut data = [0; GAMEOBJECT_DATA];
	for d in &mut data {
		*d = r.i32()?;
	}
	let size = r.f32()?;
	let n = r.u8()? as usize;
	let quest_items = (0..n).map(|_| r.i32()).collect::<Result<_, _>>()?;
	let content_tuning_id = r.i32()?;
	let unk = r.i32()?;
	r.finish()?;
	Ok(GameObject { kind, display_id, name, icon_name, cast_bar_caption, unk_string, data, size, quest_items, content_tuning_id, unk })
}

impl GameObject {
	/// The record as a JSON object.
	pub fn to_json(&self) -> Value {
		json!({
			"Type": self.kind, "DisplayID": self.display_id, "Name": self.name, "IconName": self.icon_name,
			"CastBarCaption": self.cast_bar_caption, "UnkString": self.unk_string, "Data": self.data.to_vec(),
			"Size": json_f32(self.size), "QuestItems": self.quest_items, "ContentTuningID": self.content_tuning_id, "Unk": self.unk,
		})
	}
}
