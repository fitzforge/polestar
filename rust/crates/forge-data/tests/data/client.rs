//! The client sources (forge-data client.rs) on synthetic inputs: WDB caches built here (quest,
//! creature and game object records) and the table CSVs of rust/tests/golden/client/tables; no
//! game data.

use crate::common;

use forge_data::client::{self, Area, CacheNpc, Item, Trigger};

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
	fn zeros(&mut self, n: usize) -> &mut W {
		for _ in 0..n {
			self.i32(0);
		}
		self
	}
}

fn wdb_file(magic: &[u8; 4], version: u32, records: &[(u32, Vec<u8>)]) -> Vec<u8> {
	let mut w = W::default();
	w.raw(magic).u32(70450).raw(b"SUne").u32(4096).u32(version).u32(0);
	for (id, d) in records {
		w.u32(*id).u32(d.len() as u32).raw(d);
	}
	w.u32(0).u32(0);
	w.b
}

struct Q<'a> {
	id: i32,
	level: i32,
	min: i32,
	next: i32,
	diff: i32,
	mult: f32,
	start_item: i32,
	races: i64,
	/// (type, object id, amount)
	objectives: &'a [(i32, i32, i32)],
	title: &'a str,
}

/// A questcache record (version 12) with no display spells, treasure pickers or descriptions.
fn quest_record(q: &Q) -> Vec<u8> {
	let mut w = W::default();
	for v in [q.id, 2, q.level, 0, q.min, 0, 40, 0, 0, q.next, q.diff] {
		w.i32(v);
	}
	w.f32(q.mult).i32(150).i32(0).f32(1.0).i32(0);
	w.i32(0); // NumRewardDisplaySpell
	w.i32(0).i32(0).f32(0.0).i32(0).i32(0).f32(1.0).i32(0);
	w.i32(q.start_item).i32(0).i32(0).i32(0).i32(0);
	w.zeros(16 + 18);
	w.i32(0).f32(0.0).f32(0.0).i32(0);
	w.zeros(8 + 20 + 1 + 8);
	w.i32(0).i32(0).i32(0).i32(0).i32(0);
	w.i32(q.objectives.len() as i32);
	w.raw(&q.races.to_le_bytes());
	w.i32(0).i32(0); // NumTreasurePickers, Expansion
	w.zeros(8);
	for (i, &(kind, oid, n)) in q.objectives.iter().enumerate() {
		w.i32(1000 + i as i32).i32(kind).raw(&[i as u8]).i32(oid).i32(n).u32(0).u32(0).i32(0).i32(0).i32(0).i32(0);
		w.bits(8, 0).bits(1, 0).flush();
	}
	let texts = [q.title, "", "", "", "", "", "", "", ""];
	for (t, n) in texts.iter().zip([9, 12, 12, 9, 10, 8, 10, 8, 11]) {
		w.bits(n, t.len() as u32);
	}
	w.bits(1, 1).flush();
	for t in texts {
		w.raw(t.as_bytes());
	}
	w.b
}

fn creature_record() -> Vec<u8> {
	let mut w = W::default();
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
	w.b
}

fn gameobject_record() -> Vec<u8> {
	let mut w = W::default();
	w.u32(3).u32(200).cstr("Chest").cstr("").cstr("").cstr("").cstr("").cstr("Opening").cstr("");
	for i in 0..35 {
		w.i32(i);
	}
	w.f32(1.25).u8(1).i32(1234).i32(55).i32(0);
	w.b
}

const ALLIANCE: i64 = 1 | 4 | 8 | 64 | (1 << 32);

#[test]
fn client_caches_and_tables_derive_facts() {
	let cache = common::scratch("client-cache");
	let wdb = cache.join("WDB").join("enUS");
	std::fs::create_dir_all(&wdb).unwrap();
	let q1221 = Q {
		id: 1221,
		level: 26,
		min: 20,
		next: 0,
		diff: 5,
		mult: 2.375,
		start_item: 6755,
		races: ALLIANCE,
		objectives: &[(0, 4128, 8), (1, 6755, 1), (10, 98, 1), (14, 555, 1)],
		title: "Blueleaf Tubers",
	};
	let q6981 = Q { id: 6981, level: 26, min: 15, next: 6982, diff: 1, mult: 1.0, start_item: 0, races: -1, objectives: &[(1, 10441, 1)], title: "The Glowing Shard" };
	std::fs::write(wdb.join("questcache.wdb"), wdb_file(b"TSQW", 12, &[(1221, quest_record(&q1221)), (6981, quest_record(&q6981))])).unwrap();
	std::fs::write(wdb.join("creaturecache.wdb"), wdb_file(b"BOMW", 4, &[(3434, creature_record())])).unwrap();
	std::fs::write(wdb.join("gameobjectcache.wdb"), wdb_file(b"BOGW", 4, &[(179000, gameobject_record())])).unwrap();

	let o = client::Options { tables: Some(common::golden("client").join("tables")), cache: Some(cache.clone()), ..Default::default() };
	let c = client::load(&o, None, &|_| {}).unwrap().expect("a client");
	assert!(c.warnings.is_empty(), "{:?}", c.warnings);

	// client.cache: the server's answers, the quest record as the EG path reads one.
	let k = c.cache.as_ref().unwrap();
	assert_eq!(k.build, "70450");
	assert_eq!(k.titles[&1221], "Blueleaf Tubers");
	let q = &k.quests[&1221];
	assert_eq!((q.build, q.level, q.min_level, q.next, q.start_item), (Some(70450.0), Some(26.0), Some(20.0), None, Some(6755.0)));
	// QuestXP[26][5] = 2100, x 2.375 = 4987.5, the game's rounding: 5000.
	assert_eq!((q.xp_difficulty, q.xp_multiplier, q.xp), (Some(5.0), Some(2.375), Some(5000.0)));
	assert_eq!(q.races.as_deref(), Some("4294967373"));
	let objs: Vec<(&str, Option<f64>, Option<f64>)> = q.objectives.iter().map(|(k, i, n)| (k.as_str(), *i, *n)).collect();
	assert_eq!(objs, vec![("kill", Some(4128.0), Some(8.0)), ("item", Some(6755.0), Some(1.0)), ("event", Some(98.0), Some(1.0)), ("event", None, Some(1.0))]);
	let q = &k.quests[&6981];
	assert_eq!((q.xp, q.next, q.races.as_deref()), (Some(420.0), Some(6982.0), Some("18446744073709551615")));
	assert_eq!(k.npcs[&3434], CacheNpc { name: "Gamon".into(), subname: "Brawler".into(), rank: 1 });
	assert_eq!(k.objects[&179000], "Chest");

	// client: the tables.
	let t = c.tables.as_ref().unwrap();
	assert_eq!(t.build, None);
	let p = &t.places[&1221];
	assert_eq!(p.start, vec![Area { ui_map: 1436, pts: vec![(-1000.0, 0.0)] }]);
	assert_eq!(p.end, vec![Area { ui_map: 1436, pts: vec![(-1000.0, 0.0)] }]);
	// Points in their own id order.
	assert_eq!(p.objectives[&0], vec![Area { ui_map: 1436, pts: vec![(-500.0, -500.0), (-1500.0, 0.0), (-500.0, 500.0)] }]);
	assert_eq!(p.objectives[&1][0].ui_map, 9999);
	assert_eq!(t.triggers[&98], Trigger { map: 0, x: -400.0, y: 200.0, radius: 30.0, box_size: None });
	assert_eq!(t.triggers[&99].box_size, Some((20.0, 10.0)));
	assert!(t.quests.contains(&1221) && t.quests.contains(&6981) && t.quests.len() == 2);
	assert_eq!(t.items[&10441], Item { name: "Glowing Shard".into(), duration: Some(3600.0), quest_item: Some(true), start_quest: Some(6981) });
	assert_eq!(t.items[&2454], Item { name: "Elixir of Minor Strength".into(), duration: None, quest_item: Some(false), start_quest: None });
	assert_eq!(t.objects[&179000], vec![(0, -1000.0, 0.0)]);
	// A placement at the world origin is no placement.
	assert!(!t.objects.contains_key(&179001));
	assert_eq!(t.quest_xp.as_ref().unwrap()[26].unwrap()[5], 2100.0);
	assert_eq!(t.hotfixes, (0, 0));
}

#[test]
fn no_client_named_is_no_client() {
	assert!(client::load(&client::Options::default(), None, &|_| {}).unwrap().is_none());
}

#[test]
fn a_cache_folder_without_tables_reads_the_caches_alone() {
	let dir = common::scratch("client-cache-flat");
	let q = Q { id: 6981, level: 26, min: 15, next: 0, diff: 1, mult: 1.0, start_item: 0, races: -1, objectives: &[], title: "The Glowing Shard" };
	std::fs::write(dir.join("questcache.wdb"), wdb_file(b"TSQW", 12, &[(6981, quest_record(&q))])).unwrap();
	let o = client::Options { cache: Some(dir), ..Default::default() };
	let c = client::load(&o, None, &|_| {}).unwrap().unwrap();
	assert!(c.tables.is_none());
	let k = c.cache.unwrap();
	// No QuestXP table: no XP, the level and multiplier kept.
	assert_eq!((k.quests[&6981].level, k.quests[&6981].xp), (Some(26.0), None));
	assert!(k.npcs.is_empty() && k.objects.is_empty());
}
