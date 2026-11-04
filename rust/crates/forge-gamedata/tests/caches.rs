//! The client cache readers on synthetic files built here: WDB quest, creature and gameobject
//! records (bit-packed lengths, counted lists, exact-length checks), a DBCache.bin with two
//! entries, and a hotfix row typed by a tiny definition.

use forge_gamedata::db2::Value;
use forge_gamedata::dbd::Dbd;
use forge_gamedata::hotfix::{self, DbCache};
use forge_gamedata::wdb::{self, Kind, WdbFile};

/// Little-endian bytes plus MSB-first bits, the way the server writes them.
#[derive(Default)]
struct W {
	b: Vec<u8>,
	bit: u32,
}

impl W {
	fn i32(&mut self, v: i32) -> &mut W {
		self.b.extend_from_slice(&v.to_le_bytes());
		self
	}
	fn u32(&mut self, v: u32) -> &mut W {
		self.b.extend_from_slice(&v.to_le_bytes());
		self
	}
	fn f32(&mut self, v: f32) -> &mut W {
		self.b.extend_from_slice(&v.to_le_bytes());
		self
	}
	fn u8(&mut self, v: u8) -> &mut W {
		self.b.push(v);
		self
	}
	fn raw(&mut self, v: &[u8]) -> &mut W {
		self.b.extend_from_slice(v);
		self
	}
	fn cstr(&mut self, s: &str) -> &mut W {
		self.raw(s.as_bytes()).u8(0)
	}
	fn bits(&mut self, n: u32, v: u32) -> &mut W {
		for i in (0..n).rev() {
			if self.bit == 0 {
				self.b.push(0);
				self.bit = 8;
			}
			self.bit -= 1;
			*self.b.last_mut().unwrap() |= (((v >> i) & 1) as u8) << self.bit;
		}
		self
	}
	fn flush(&mut self) -> &mut W {
		self.bit = 0;
		self
	}
}

/// A WDB file of `magic` and record version `version` with `records`, ending in the terminator.
fn wdb_file(magic: &[u8; 4], version: u32, records: &[(u32, &[u8])]) -> Vec<u8> {
	let mut w = W::default();
	w.raw(magic).u32(70450).raw(b"SUne").u32(4096).u32(version).u32(0);
	for (id, d) in records {
		w.u32(*id).u32(d.len() as u32).raw(d);
	}
	w.u32(0).u32(0);
	w.b
}

fn quest_record() -> Vec<u8> {
	let mut w = W::default();
	// QuestID .. RewardXPDifficulty (11 words)
	for v in [1221, 2, 26, 0, 20, 0, 1717, 81, 0, 0, 5] {
		w.i32(v);
	}
	w.f32(2.375).i32(150).i32(0).f32(1.0).i32(0);
	w.i32(1); // NumRewardDisplaySpell
	w.i32(0).i32(0).f32(0.0).i32(0).i32(77).f32(1.0).i32(0); // RewardSpell .. RewardArtifactCategoryID (Unk21 = 77)
	w.i32(0).i32(8).i32(0).i32(0).i32(0); // StartItem, Flags, FlagsEx..3
	w.i32(6755).i32(1); // RewardItems[0] = (6755, 1, 0, 0), then zeros
	for _ in 2..16 {
		w.i32(0);
	}
	for _ in 0..18 {
		w.i32(0);
	}
	w.i32(1).f32(-123.5).f32(456.25).i32(0);
	for _ in 0..8 {
		w.i32(0);
	}
	w.i32(72).i32(250); // RewardFactions[0] = (72, 250, 0, 0), then zeros
	for _ in 2..20 {
		w.i32(0);
	}
	w.i32(0);
	for _ in 0..8 {
		w.i32(0);
	}
	w.i32(890).i32(878).i32(0).i32(0).i32(0);
	w.i32(1); // NumObjectives
	w.raw(&(-1i64).to_le_bytes());
	w.i32(1).i32(0); // NumTreasurePickers, Expansion
	for v in 114..122 {
		w.i32(v);
	}
	w.i32(8690).i32(0).i32(2); // display spell
	w.i32(255000).i32(0).raw(&[0xFF]).i32(4128).i32(8).u32(0).u32(0).i32(1).i32(2).i32(3).i32(4);
	w.bits(8, 13).bits(1, 1).flush().raw(b"Kill a bandit");
	w.i32(4242); // treasure picker
	let texts = ["Bandits", "Kill them.", "Go now.", "", "", "", "", "", "Done$Bthere."];
	for (t, n) in texts.iter().zip([9, 12, 12, 9, 10, 8, 10, 8, 11]) {
		w.bits(n, t.len() as u32);
	}
	w.bits(1, 1).flush();
	for t in texts {
		w.raw(t.as_bytes());
	}
	w.b
}

#[test]
fn quest_record_decodes() {
	let rec = quest_record();
	let f = WdbFile::parse(&wdb_file(b"TSQW", 12, &[(1221, &rec)])).unwrap();
	assert_eq!((f.kind(), f.build, f.locale.as_str(), f.record_version, f.records.len()), (Some(Kind::Quest), 70450, "enUS", 12, 1));
	let qs = f.decode(Kind::Quest, wdb::decode_quest).unwrap();
	let q = qs[0].1.as_ref().unwrap();
	assert_eq!((q.quest_id, q.quest_level, q.min_level, q.quest_sort_id, q.reward_money, q.unk21, q.flags), (1221, 26, 20, 1717, 150, 77, 8));
	assert_eq!((q.reward_xp_multiplier, q.poi_continent, q.poi_x, q.poi_y), (2.375, 1, -123.5, 456.25));
	assert_eq!(q.reward_items[0], [6755, 1, 0, 0]);
	assert_eq!(q.reward_factions[0], [72, 250, 0, 0]);
	assert_eq!((q.accepted_sound_kit_id, q.complete_sound_kit_id, q.allowable_races), (890, 878, -1));
	assert_eq!(q.unk114, [114, 115, 116, 117, 118, 119, 120, 121]);
	assert_eq!(q.reward_display_spells, vec![[8690, 0, 2]]);
	assert_eq!(q.treasure_pickers, vec![4242]);
	let o = &q.objectives[0];
	assert_eq!((o.id, o.kind, o.storage_index, o.object_id, o.amount, o.u25, o.u37, o.unk_bit), (255000, 0, -1, 4128, 8, 1, 4, 1));
	assert_eq!(o.description, "Kill a bandit");
	assert_eq!((q.log_title.as_str(), q.log_description.as_str(), q.quest_description.as_str()), ("Bandits", "Kill them.", "Go now."));
	assert_eq!((q.area_description.as_str(), q.quest_completion_log.as_str(), q.ready_for_translation), ("", "Done$Bthere.", 1));
	let j = q.to_json();
	assert_eq!(j["RewardXPMultiplier"], serde_json::json!(2.375));
	assert_eq!(j["Objectives"][0]["Description"], "Kill a bandit");
	assert_eq!(j["Unk121"], 121);

	// A record version the decoder does not know is refused, not guessed.
	let v13 = WdbFile::parse(&wdb_file(b"TSQW", 13, &[(1221, &rec)])).unwrap();
	assert!(v13.decode(Kind::Quest, wdb::decode_quest).unwrap_err().contains("version 13"));
	// Truncated and padded records are errors.
	assert!(wdb::decode_quest(&rec[..rec.len() - 1]).is_err());
	let mut long = rec.clone();
	long.push(0);
	assert!(wdb::decode_quest(&long).unwrap_err().contains("left over"));
}

#[test]
fn creature_record_decodes() {
	let mut w = W::default();
	// TitleLen, TitleAltLen, CursorNameLen (with the NUL), Leader, then 4 x (NameLen, NameAltLen).
	w.bits(11, 8).bits(11, 0).bits(6, 0).bits(1, 1);
	w.bits(11, 7).bits(11, 0);
	for _ in 0..3 {
		w.bits(11, 0).bits(11, 0);
	}
	w.flush().cstr("Gamon");
	w.u32(4096).u32(0).u32(9).u8(7).i32(0).i32(1).i32(0).u8(3);
	w.i32(1).f32(1.0).i32(6095).f32(1.5).f32(1.0);
	w.f32(3.0).f32(2.0).i32(1).i32(0);
	for v in [1693, 0, 0, 0, 2, 3270, 0, 0] {
		w.i32(v);
	}
	w.cstr("Brawler").i32(5060);
	let rec = w.b;
	let f = WdbFile::parse(&wdb_file(b"BOMW", 4, &[(3434, &rec)])).unwrap();
	let c = f.decode(Kind::Creature, wdb::decode_creature).unwrap().remove(0).1.unwrap();
	assert_eq!((c.leader, c.name[0].as_str(), c.title.as_str(), c.cursor_name.as_str()), (1, "Gamon", "Brawler", ""));
	assert_eq!((c.flags, c.unk8, c.creature_type, c.classification, c.unk25), ([4096, 0], 9, 7, 1, 3));
	assert_eq!((c.displays.len(), c.displays[0].display_id, c.displays[0].scale, c.hp_multi), (1, 6095, 1.5, 3.0));
	assert_eq!((c.movement_info_id, c.class, c.creature_difficulty_id), (1693, 2, 3270));
	assert_eq!((c.quest_items.clone(), c.quest_currencies.len()), (vec![5060], 0));
	assert!(wdb::decode_creature(&rec[..rec.len() - 2]).is_err());
	// A quest file is not a creature file.
	assert!(f.decode(Kind::Quest, wdb::decode_quest).is_err());
}

#[test]
fn gameobject_record_decodes() {
	let mut w = W::default();
	w.u32(3).u32(200).cstr("Chest").cstr("").cstr("").cstr("").cstr("").cstr("Opening").cstr("");
	for i in 0..35 {
		w.i32(i);
	}
	w.f32(1.25).u8(1).i32(1234).i32(55).i32(0);
	let rec = w.b;
	let f = WdbFile::parse(&wdb_file(b"BOGW", 4, &[(179000, &rec)])).unwrap();
	let g = f.decode(Kind::GameObject, wdb::decode_gameobject).unwrap().remove(0).1.unwrap();
	assert_eq!((g.kind, g.display_id, g.name[0].as_str(), g.cast_bar_caption.as_str()), (3, 200, "Chest", "Opening"));
	assert_eq!((g.data[34], g.size, g.quest_items.clone(), g.content_tuning_id, g.unk), (34, 1.25, vec![1234], 55, 0));
	assert!(wdb::decode_gameobject(&rec[..rec.len() - 1]).is_err());
}

#[test]
fn wdb_container_edges() {
	// Header + terminator: no records.
	let empty = WdbFile::parse(&wdb_file(b"CPNW", 2, &[])).unwrap();
	assert_eq!((empty.kind(), empty.records.len()), (Some(Kind::Npc), 0));
	assert!(empty.check(Kind::Npc).unwrap_err().contains("not decoded"));
	// A record running past the end of the file.
	let mut b = wdb_file(b"TSQW", 12, &[(1, &[1, 2, 3, 4])]);
	b.truncate(b.len() - 10);
	assert!(WdbFile::parse(&b).is_err());
	assert!(WdbFile::parse(&b[..10]).is_err());
}

fn dbcache(entries: &[(i32, i32, u32, u32, u32, u8, &[u8])]) -> Vec<u8> {
	let mut w = W::default();
	w.raw(b"XFTH").u32(9).u32(70450).raw(&[0xAB; 32]);
	for &(region, push, unique, hash, id, status, data) in entries {
		w.raw(b"XFTH").i32(region).i32(push).u32(unique).u32(hash).u32(id).i32(data.len() as i32).raw(&[status, 0, 0, 0]).raw(data);
	}
	w.b
}

#[test]
fn dbcache_entries_and_rows() {
	// Row: inline ID, a string, a u16, a float pair, a signed 8-bit, then the noninline relation
	// (in the bytes, unlike a noninline ID).
	let mut row = W::default();
	row.u32(98245).cstr("Hi").raw(&40000u16.to_le_bytes()).f32(0.5).f32(-2.0).u8(0xFE).i32(12018);
	let c = DbCache::parse(dbcache(&[(1, 7, 11, 0xCAFE, 98245, 1, &row.b), (1, 8, 12, 0xCAFE, 5, 2, &[])])).unwrap();
	assert_eq!((c.version, c.build, c.verification_hash[0], c.entries.len()), (9, 70450, 0xAB, 2));
	let e = c.entries[0];
	assert_eq!((e.region_id, e.push_id, e.unique_id, e.table_hash, e.record_id, e.status, e.data_size), (1, 7, 11, 0xCAFE, 98245, 1, row.b.len()));
	assert_eq!(c.data(&e), &row.b[..]);
	assert_eq!((c.entries[1].push_id, c.entries[1].status, c.entries[1].data_size), (8, hotfix::status::DELETED, 0));

	let dbd = Dbd::parse(
		"COLUMNS\nint ID\nstring Name\nint Count\nfloat Pos\nint Delta\nint ParentID\n\nBUILD 1.60.1.70450\n$id$ID<32>\nName\nCount<u16>\nPos[2]\nDelta<8>\n$noninline,relation$ParentID<32>\n",
	)
	.unwrap();
	let def = dbd.for_build(forge_gamedata::Build::parse("1.60.1.70450").unwrap()).unwrap();
	let rows = hotfix::rows(&c, 0xCAFE, def, false);
	let t = &rows.table;
	assert!(rows.failures.is_empty(), "{:?}", rows.failures);
	let names: Vec<&str> = t.columns.iter().map(|c| c.name.as_str()).collect();
	assert_eq!(names, ["RecordID", "Status", "PushID", "ID", "Name", "Count", "Pos_0", "Pos_1", "Delta", "ParentID"]);
	assert_eq!(t.rows(), 2);
	let r = t.row(0);
	assert_eq!((r[0], r[2], r[3]), (Value::Int(98245), Value::Int(7), Value::Int(98245)));
	assert_eq!(t.str(&r[4]), Some(&b"Hi"[..]));
	assert_eq!((r[5], r[6], r[7], r[8], r[9]), (Value::UInt(40000), Value::Float(0.5), Value::Float(-2.0), Value::Int(-2), Value::Int(12018)));
	assert_eq!(t.str(&t.row(1)[4]), Some(&b""[..]));
	assert_eq!(hotfix::rows(&c, 0xCAFE, def, true).table.rows(), 1);
	assert_eq!(String::from_utf8(forge_gamedata::csv::write_table(t)).unwrap().lines().nth(1), Some("98245,1,7,98245,Hi,40000,0.5,-2,-2,12018"));

	// A row one byte short or long is a failure, not a row.
	let short = DbCache::parse(dbcache(&[(1, 7, 11, 0xCAFE, 98245, 1, &row.b[..row.b.len() - 1])])).unwrap();
	assert_eq!(hotfix::rows(&short, 0xCAFE, def, true).failures.len(), 1);
	let mut long = row.b.clone();
	long.push(0);
	let long = DbCache::parse(dbcache(&[(1, 7, 11, 0xCAFE, 98245, 1, &long)])).unwrap();
	assert!(hotfix::rows(&long, 0xCAFE, def, true).failures[0].1.contains("bytes decoded"));
	// A truncated entry is an error.
	let mut b = dbcache(&[(1, 7, 11, 0xCAFE, 98245, 1, &row.b)]);
	b.pop();
	assert!(DbCache::parse(b).is_err());
}
