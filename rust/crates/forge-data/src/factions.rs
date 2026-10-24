//! Faction rows -> factions.json (port of tools/lib/data/factions.js), and ChrRaces/ChrClasses/
//! CharBaseInfo rows -> races.json (tools/lib/data/races.js).

use forge_guide::js::{Obj, V};
use indexmap::IndexMap;
use rustc_hash::{FxHashMap, FxHashSet};

use crate::jsv::{col_num, col_str, strs, to_int32, Row};

pub const ALLIANCE_RACES: i32 = 1 | 4 | 8 | 64;
pub const HORDE_RACES: i32 = 2 | 16 | 32 | 128;
pub const ALL_RACES: i32 = ALLIANCE_RACES | HORDE_RACES;
pub const ALL_CLASSES: i32 = 1 | 2 | 4 | 8 | 16 | 64 | 128 | 256 | 1024;
const LOCKED: f64 = -42000.0;

fn int(r: &Row, c: &str) -> f64 {
	let n = col_num(r, c);
	if n.is_finite() {
		n.trunc()
	} else {
		0.0
	}
}

fn side_header(id: i64) -> Option<&'static str> {
	match id {
		469 | 891 => Some("Alliance"),
		67 | 892 => Some("Horde"),
		_ => None,
	}
}

fn side_from_race_locks(row: &Row) -> Option<&'static str> {
	let (mut locked, mut open) = (0i32, 0i32);
	for i in 0..4 {
		let mask = to_int32(int(row, &format!("ReputationRaceMasks{i}_0"))) & ALL_RACES;
		if mask == 0 {
			continue;
		}
		if int(row, &format!("ReputationBase_{i}")) <= LOCKED {
			locked |= mask;
		} else {
			open |= mask;
		}
	}
	locked &= !open;
	if locked == HORDE_RACES && (open & ALLIANCE_RACES) == ALLIANCE_RACES {
		return Some("Alliance");
	}
	if locked == ALLIANCE_RACES && (open & HORDE_RACES) == HORDE_RACES {
		return Some("Horde");
	}
	None
}

/// rows: Faction rows (Era's, Forever's winning by ID) -> id -> record, ascending.
pub fn build_factions(rows: &[&Row]) -> Obj {
	let mut by_id: IndexMap<i64, &Row> = IndexMap::new();
	for r in rows {
		let id = int(r, "ID");
		if id > 0.0 {
			by_id.insert(id as i64, r);
		}
	}
	let mut keep = FxHashSet::default();
	for (&id, r) in &by_id {
		if int(r, "ReputationIndex") < 0.0 {
			continue;
		}
		let mut cur = id;
		let mut seen = FxHashSet::default();
		while cur > 0 && by_id.contains_key(&cur) && seen.insert(cur) {
			keep.insert(cur);
			cur = int(by_id[&cur], "ParentFactionID") as i64;
		}
	}
	let mut side_of: FxHashMap<i64, Option<&'static str>> = FxHashMap::default();
	fn side(id: i64, by_id: &IndexMap<i64, &Row>, side_of: &mut FxHashMap<i64, Option<&'static str>>, seen: &mut FxHashSet<i64>) -> Option<&'static str> {
		if let Some(s) = side_of.get(&id) {
			return *s;
		}
		if !seen.insert(id) {
			return None;
		}
		let mut s = side_header(id);
		let parent = int(by_id[&id], "ParentFactionID") as i64;
		if s.is_none() && parent > 0 && by_id.contains_key(&parent) {
			s = side(parent, by_id, side_of, seen);
		}
		if s.is_none() {
			s = side_from_race_locks(by_id[&id]);
		}
		side_of.insert(id, s);
		s
	}
	let mut ids: Vec<i64> = keep.iter().copied().collect();
	ids.sort();
	let out = Obj::new();
	for id in ids {
		let r = by_id[&id];
		let parent = int(r, "ParentFactionID") as i64;
		let s = side(id, &by_id, &mut side_of, &mut FxHashSet::default());
		let o = Obj::new();
		o.set("id", id as f64);
		o.set("name", col_str(r, "Name_lang").trim_matches(|c: char| c.is_whitespace() || c == '\u{feff}'));
		o.set("side", s.map(V::str).unwrap_or(V::Null));
		o.set("parent", if parent > 0 && keep.contains(&parent) { V::Num(parent as f64) } else { V::Null });
		o.set("source", strs(&["blizzard"]));
		out.set(&id.to_string(), o);
	}
	out
}

fn int_opt(r: &Row, c: &str) -> Option<f64> {
	let n = col_num(r, c);
	n.is_finite().then(|| n.trunc())
}

/// ChrRaces, ChrClasses, CharBaseInfo -> { raceFile: { side: { id, bit, classes } } }.
pub fn build_races(chr_races: &[Row], chr_classes: &[Row], char_base: &[Row]) -> Obj {
	let mut class_file: IndexMap<i64, String> = IndexMap::new();
	for c in chr_classes {
		if let Some(id) = int_opt(c, "ID") {
			let f = col_str(c, "Filename");
			if !f.is_empty() {
				class_file.insert(id as i64, f.to_string());
			}
		}
	}
	let mut class_order: Vec<i64> = class_file.keys().copied().collect();
	class_order.sort();
	let mut classes_of: FxHashMap<i64, FxHashSet<i64>> = FxHashMap::default();
	for b in char_base {
		let (Some(race), Some(cls)) = (int_opt(b, "RaceID"), int_opt(b, "ClassID")) else { continue };
		if !class_file.contains_key(&(cls as i64)) {
			continue;
		}
		classes_of.entry(race as i64).or_default().insert(cls as i64);
	}
	let mut rows: Vec<&Row> = chr_races.iter().filter(|r| int_opt(r, "ID").is_some_and(|id| classes_of.contains_key(&(id as i64)))).collect();
	rows.sort_by(|a, b| int_opt(a, "ID").unwrap().partial_cmp(&int_opt(b, "ID").unwrap()).unwrap());
	let out = Obj::new();
	for r in rows {
		let side = match int_opt(r, "Alliance") {
			Some(0.0) => "Alliance",
			Some(1.0) => "Horde",
			_ => continue,
		};
		let Some(bit) = int_opt(r, "PlayableRaceBit") else { continue };
		let file = col_str(r, "ClientFileString");
		if bit < 0.0 || file.is_empty() {
			continue;
		}
		let id = int_opt(r, "ID").unwrap() as i64;
		if !out.has(file) {
			out.set(file, Obj::new());
		}
		let e = Obj::new();
		e.set("id", id as f64);
		e.set("bit", 2f64.powf(bit));
		let set = &classes_of[&id];
		e.set("classes", V::from(class_order.iter().filter(|c| set.contains(c)).map(|c| V::str(&class_file[c])).collect::<Vec<_>>()));
		out.get(file).as_obj().unwrap().set(side, e);
	}
	out
}
