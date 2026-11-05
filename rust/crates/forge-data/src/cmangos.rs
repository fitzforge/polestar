//! CMaNGOS classic-db facts (port of tools/lib/travel/cmangos.js, the next and sim-v2 versions):
//! extracts of the pinned dump (data/sources/cmangos/<rev12>/classicdb.sql.gz), cached beside it
//! as the JS writes them and rebuilt from the dump when missing; never fetched here.

use std::io::BufRead;
use std::path::Path;

use forge_guide::js::{json_quote, stringify, Obj, V};
use indexmap::IndexMap;

use crate::extras::read_json;
use crate::jsv::arr;

pub const DB_REV: &str = "22b51464f1625f6ef6275771de1f5466c6f5d19e";
pub fn db_url() -> String {
	format!("https://raw.githubusercontent.com/cmangos/classic-db/{DB_REV}/Full_DB/ClassicDB_1_12_1_z2815.sql.gz")
}
const DB_SHA256_LEN: usize = 12;

pub fn heights_source() -> V {
	let o = Obj::new();
	o.set("name", "CMaNGOS classic-db: creature and gameobject spawn heights");
	o.set("url", db_url());
	o.set("revision", DB_REV);
	o.set("license", "GPL-3.0; spawn heights (z) only, used as facts like the transport periods: a guide goal, spawn spot or smart-target candidate at an NPC or object (and Core/ClassTrainers.lua's class trainers) carries its spawn's height");
	o.set("copyright", "CMaNGOS (https://github.com/cmangos/classic-db)");
	V::Obj(o)
}

pub fn moves_source() -> V {
	let o = Obj::new();
	o.set("name", "CMaNGOS classic-db: creature walks");
	o.set("url", db_url());
	o.set("revision", DB_REV);
	o.set("license", "GPL-3.0; the extent of a creature's walk (its spawn, the centre and radius of the ground its random or waypoint movement covers) only, used as facts: a goal at an NPC who walks around gets that ground as its spawn area, and the guides say so");
	o.set("copyright", "CMaNGOS (https://github.com/cmangos/classic-db)");
	V::Obj(o)
}

pub fn counts_source() -> V {
	let o = Obj::new();
	o.set("name", "CMaNGOS classic-db: quest objective counts");
	o.set("url", db_url());
	o.set("revision", DB_REV);
	o.set("license", "GPL-3.0; quest objective counts only, used as facts: an objective whose count QuestieDB and pfQuest lack takes the matching quest_template count");
	o.set("copyright", "CMaNGOS (https://github.com/cmangos/classic-db)");
	V::Obj(o)
}

/// SQL tuple body -> fields, quoted strings unquoted.
fn sql_fields(body: &str) -> Vec<String> {
	let mut out = Vec::new();
	let mut cur = String::new();
	let mut quoted = false;
	let mut it = body.chars();
	while let Some(ch) = it.next() {
		if quoted {
			if ch == '\\' {
				if let Some(n) = it.next() {
					cur.push(n);
				} else {
					cur.push(ch);
				}
			} else if ch == '\'' {
				quoted = false;
			} else {
				cur.push(ch);
			}
		} else if ch == '\'' {
			quoted = true;
		} else if ch == ',' {
			out.push(cur.trim().to_string());
			cur.clear();
		} else {
			cur.push(ch);
		}
	}
	out.push(cur.trim().to_string());
	out
}

/// The tuple bodies of an `INSERT INTO ... VALUES (...),(...);` line.
fn tuples(line: &str) -> Vec<Vec<String>> {
	let mut out = Vec::new();
	let Some(start) = line.find(" VALUES ") else { return out };
	let b = line.as_bytes();
	let mut i = start;
	while i < b.len() {
		if b[i] != b'(' {
			i += 1;
			continue;
		}
		// (((?:'(?:\\.|[^'\\])*'|[^()'])*)\)
		let mut j = i + 1;
		let mut ok = false;
		while j < b.len() {
			match b[j] {
				b'\'' => {
					j += 1;
					let mut closed = false;
					while j < b.len() {
						if b[j] == b'\\' && j + 1 < b.len() {
							j += 2;
						} else if b[j] == b'\'' {
							closed = true;
							j += 1;
							break;
						} else if b[j] == b'\\' {
							break;
						} else {
							j += 1;
						}
					}
					if !closed {
						break;
					}
				}
				b'(' => break,
				b')' => {
					ok = true;
					break;
				}
				_ => j += 1,
			}
		}
		if ok {
			out.push(sql_fields(&line[i + 1..j]));
			i = j + 1;
		} else {
			i += 1;
		}
	}
	out
}

fn tenth(v: &str) -> f64 {
	let r = crate::jsv::math_round(forge_guide::js::str_to_num(v) * 10.0) / 10.0;
	if r == 0.0 {
		0.0
	} else {
		r
	}
}

fn dump_lines(dump: &Path) -> Result<Box<dyn Iterator<Item = String>>, String> {
	let f = std::fs::File::open(dump).map_err(|e| format!("{}: {e}", dump.display()))?;
	let r = std::io::BufReader::new(flate2::read::GzDecoder::new(f));
	Ok(Box::new(r.split(b'\n').map_while(Result::ok).map(|l| {
		let s = String::from_utf8_lossy(&l).into_owned();
		s.strip_suffix('\r').map(str::to_string).unwrap_or(s)
	})))
}

/// Column names of the dump's tables, from their CREATE TABLE blocks (cmangos.js columnTracker).
#[derive(Default)]
struct Columns {
	cols: rustc_hash::FxHashMap<String, Vec<String>>,
	table: Option<String>,
}

impl Columns {
	/// Takes a CREATE TABLE line or a line inside one (-> true); other lines -> false.
	fn see(&mut self, line: &str) -> bool {
		if let Some(rest) = line.strip_prefix("CREATE TABLE `") {
			if let Some(name) = rest.strip_suffix("` (").filter(|n| !n.is_empty() && n.bytes().all(|b| b.is_ascii_alphanumeric() || b == b'_')) {
				self.cols.insert(name.to_string(), Vec::new());
				self.table = Some(name.to_string());
				return true;
			}
		}
		let Some(t) = self.table.clone() else { return false };
		let trimmed = line.trim_start();
		if trimmed.len() < line.len() {
			if let Some(c) = trimmed.strip_prefix('`').and_then(|r| r.find('`').map(|e| &r[..e])).filter(|c| !c.is_empty() && c.bytes().all(|b| b.is_ascii_alphanumeric() || b == b'_')) {
				self.cols.get_mut(&t).unwrap().push(c.to_string());
			}
		}
		if line.starts_with(')') {
			self.table = None;
		}
		true
	}

	fn at(&self, table: &str, name: &str, fallback: i64) -> i64 {
		self.cols.get(table).and_then(|c| c.iter().position(|x| x.eq_ignore_ascii_case(name))).map(|i| i as i64).unwrap_or(fallback)
	}
}

fn num(s: &str) -> f64 {
	forge_guide::js::str_to_num(s)
}

fn get(r: &[String], i: i64) -> &str {
	if i < 0 {
		""
	} else {
		r.get(i as usize).map(String::as_str).unwrap_or("")
	}
}

/// Lines -> { npc: { id: [[map, x, y, z(, respawn)]...] }, object: {...} } on maps 0 and 1;
/// `respawn` (sim-v2's spawnz.2.json): a creature's spawntimesecs(min) as a fifth value, the
/// columns found by name.
fn extract_spawn_heights(lines: impl Iterator<Item = String>, respawn: bool) -> V {
	let mut out: [IndexMap<i64, Vec<Vec<f64>>>; 2] = [IndexMap::new(), IndexMap::new()];
	let mut pooled: [rustc_hash::FxHashMap<i64, Vec<f64>>; 2] = Default::default();
	let mut entries: [Vec<(i64, i64)>; 2] = [Vec::new(), Vec::new()];
	const TABLES: [(&str, usize, bool, &str); 4] = [
		("INSERT INTO `creature` VALUES", 0, false, "creature"),
		("INSERT INTO `gameobject` VALUES", 1, false, "gameobject"),
		("INSERT INTO `creature_spawn_entry` VALUES", 0, true, ""),
		("INSERT INTO `gameobject_spawn_entry` VALUES", 1, true, ""),
	];
	let mut t = Columns::default();
	for line in lines {
		if respawn && t.see(&line) {
			continue;
		}
		let Some(&(_, kind, is_entry, table)) = TABLES.iter().find(|(p, _, _, _)| line.starts_with(p)) else { continue };
		let (im, ix) = if is_entry || !respawn { (2, 4) } else { (t.at(table, "map", 2), t.at(table, "position_x", 4)) };
		let rc = if respawn && kind == 0 && !is_entry { t.at(table, "spawntimesecsmin", t.at(table, "spawntimesecs", -1)) } else { -1 };
		for r in tuples(&line) {
			if is_entry {
				entries[kind].push((num(&r[0]) as i64, num(&r[1]) as i64));
				continue;
			}
			let map = num(get(&r, im));
			if map != 0.0 && map != 1.0 {
				continue;
			}
			let mut pos = vec![map, tenth(get(&r, ix)), tenth(get(&r, ix + 1)), tenth(get(&r, ix + 2))];
			if rc >= 0 && !get(&r, rc).is_empty() && num(get(&r, rc)).is_finite() {
				pos.push(num(get(&r, rc)));
			}
			let id = num(&r[1]);
			if id > 0.0 {
				out[kind].entry(id as i64).or_default().push(pos);
			} else {
				pooled[kind].insert(num(&r[0]) as i64, pos);
			}
		}
	}
	for kind in 0..2 {
		for &(guid, entry) in &entries[kind] {
			if let Some(pos) = pooled[kind].get(&guid) {
				if entry > 0 {
					out[kind].entry(entry).or_default().push(pos.clone());
				}
			}
		}
	}
	let res = Obj::new();
	for (kind, name) in [(0, "npc"), (1, "object")] {
		let mut ids: Vec<i64> = out[kind].keys().copied().collect();
		ids.sort();
		let t = Obj::new();
		for id in ids {
			let mut list = out[kind][&id].clone();
			list.sort_by(|a, b| {
				for k in 0..4 {
					let d = a[k] - b[k];
					if d != 0.0 {
						return d.partial_cmp(&0.0).unwrap();
					}
				}
				std::cmp::Ordering::Equal
			});
			// Consecutive duplicates (every value equal) left out.
			list.dedup_by(|b, a| a.len() == b.len() && a.iter().zip(b.iter()).all(|(x, y)| x == y));
			t.set(&id.to_string(), arr(list.iter().map(|p| crate::jsv::nums(p)).collect()));
		}
		res.set(name, t);
	}
	V::Obj(res)
}

/// Walks reaching less than this many yards from their centre are left out of moves.json (a mob
/// pacing at its camp): the compiler's walkers walk 20 yards or more (forge-guide walks.rs).
pub const MOVE_MIN_YD: f64 = 20.0;

/// Lines -> { npc: { id: [[map, x, y, cx, cy, r]...] } } on maps 0 and 1: every creature spawn that
/// walks (random movement within its `spawndist`, or a waypoint path: `creature_movement` by spawn,
/// else `creature_movement_template` path 0 by creature), with its spawn point, then the centre and
/// radius in yards of the ground the walk covers; walks under MOVE_MIN_YD left out. The columns are
/// found by name.
fn extract_moves(lines: impl Iterator<Item = String>) -> V {
	let mut c = Columns::default();
	// (entry, guid, map, x, y, spawndist, movement type)
	let mut spawns: Vec<(i64, i64, f64, f64, f64, f64, f64)> = Vec::new();
	let mut by_guid: rustc_hash::FxHashMap<i64, Vec<(f64, f64)>> = Default::default();
	let mut by_entry: rustc_hash::FxHashMap<i64, Vec<(f64, f64)>> = Default::default();
	for line in lines {
		if c.see(&line) {
			continue;
		}
		if line.starts_with("INSERT INTO `creature` VALUES") {
			let at = |n: &str, f: i64| c.at("creature", n, f);
			let (ig, ii, im, ix, idist, imt) = (at("guid", 0), at("id", 1), at("map", 2), at("position_x", 4), at("spawndist", 10), at("MovementType", 11));
			for r in tuples(&line) {
				let (map, mt, entry) = (num(get(&r, im)), num(get(&r, imt)), num(get(&r, ii)));
				if (map != 0.0 && map != 1.0) || (mt != 1.0 && mt != 2.0) || entry <= 0.0 {
					continue;
				}
				spawns.push((entry as i64, num(get(&r, ig)) as i64, map, num(get(&r, ix)), num(get(&r, ix + 1)), num(get(&r, idist)), mt));
			}
		} else if line.starts_with("INSERT INTO `creature_movement` VALUES") {
			let (ii, ix) = (c.at("creature_movement", "Id", 0), c.at("creature_movement", "PositionX", 2));
			for r in tuples(&line) {
				by_guid.entry(num(get(&r, ii)) as i64).or_default().push((num(get(&r, ix)), num(get(&r, ix + 1))));
			}
		} else if line.starts_with("INSERT INTO `creature_movement_template` VALUES") {
			let t = "creature_movement_template";
			let (ie, ip, ix) = (c.at(t, "Entry", 0), c.at(t, "PathId", 1), c.at(t, "PositionX", 3));
			for r in tuples(&line) {
				if num(get(&r, ip)) == 0.0 {
					by_entry.entry(num(get(&r, ie)) as i64).or_default().push((num(get(&r, ix)), num(get(&r, ix + 1))));
				}
			}
		}
	}
	let round = |v: f64| {
		let r = crate::jsv::math_round(v * 10.0) / 10.0;
		if r == 0.0 {
			0.0
		} else {
			r
		}
	};
	let mut out: std::collections::BTreeMap<i64, Vec<Vec<f64>>> = std::collections::BTreeMap::new();
	for (entry, guid, map, x, y, dist, mt) in spawns {
		let (cx, cy, r) = if mt == 1.0 {
			(x, y, dist)
		} else {
			let Some(path) = by_guid.get(&guid).or_else(|| by_entry.get(&entry)) else { continue };
			let pts: Vec<(f64, f64)> = path.iter().copied().chain(std::iter::once((x, y))).collect();
			let (x0, x1) = pts.iter().fold((f64::INFINITY, f64::NEG_INFINITY), |(a, b), p| (a.min(p.0), b.max(p.0)));
			let (y0, y1) = pts.iter().fold((f64::INFINITY, f64::NEG_INFINITY), |(a, b), p| (a.min(p.1), b.max(p.1)));
			let (cx, cy) = ((x0 + x1) / 2.0, (y0 + y1) / 2.0);
			(cx, cy, pts.iter().map(|p| (p.0 - cx).hypot(p.1 - cy)).fold(0.0, f64::max))
		};
		if !(r >= MOVE_MIN_YD) {
			continue;
		}
		out.entry(entry).or_default().push(vec![map, round(x), round(y), round(cx), round(cy), (r * 10.0).ceil() / 10.0]);
	}
	let t = Obj::new();
	for (id, mut list) in out {
		list.sort_by(|a, b| a.iter().zip(b.iter()).map(|(p, q)| p.partial_cmp(q).unwrap()).find(|o| o.is_ne()).unwrap_or(std::cmp::Ordering::Equal));
		t.set(&id.to_string(), arr(list.iter().map(|p| crate::jsv::nums(p)).collect()));
	}
	let res = Obj::new();
	res.set("npc", V::Obj(t));
	V::Obj(res)
}

/// moves.json's text: one id per line.
pub fn serialize_moves(db: &V) -> String {
	let part = db
		.get("npc")
		.entries()
		.iter()
		.map(|(id, v)| {
			let mut s = String::new();
			json_quote(&mut s, id);
			format!("{s}:{}", stringify(v, None))
		})
		.collect::<Vec<_>>()
		.join(",\n");
	format!("{{\"npc\":{{\n{part}\n}}}}\n")
}

const CLASS_BY_ID: [(f64, &str); 9] = [(1.0, "WARRIOR"), (2.0, "PALADIN"), (3.0, "HUNTER"), (4.0, "ROGUE"), (5.0, "PRIEST"), (7.0, "SHAMAN"), (8.0, "MAGE"), (9.0, "WARLOCK"), (11.0, "DRUID")];

fn class_of(id: f64) -> Option<&'static str> {
	CLASS_BY_ID.iter().find(|(i, _)| *i == id).map(|(_, c)| *c)
}

/// Lines -> { classes: { CLASS: { reqLevel: copper } }, spells }.
fn extract_training(lines: impl Iterator<Item = String>) -> V {
	let mut t = Columns::default();
	let mut template_class: rustc_hash::FxHashMap<i64, &str> = rustc_hash::FxHashMap::default();
	let mut rows: Vec<[f64; 4]> = Vec::new();
	for line in lines {
		if t.see(&line) {
			continue;
		}
		if line.starts_with("INSERT INTO `creature_template` VALUES") {
			let (ic, it) = (t.at("creature_template", "TrainerClass", -1), t.at("creature_template", "TrainerTemplateId", -1));
			if ic < 0 || it < 0 {
				continue;
			}
			for r in tuples(&line) {
				if let Some(c) = class_of(num(get(&r, ic))) {
					if num(get(&r, it)) > 0.0 {
						template_class.insert(num(get(&r, it)) as i64, c);
					}
				}
			}
		} else if line.starts_with("INSERT INTO `npc_trainer_template` VALUES") {
			let at = |n: &str, f: i64| t.at("npc_trainer_template", n, f);
			let (ie, is, ic, il) = (at("entry", 0), at("spell", 1), at("spellcost", 2), at("reqlevel", 5));
			for r in tuples(&line) {
				rows.push([num(get(&r, ie)), num(get(&r, is)), num(get(&r, ic)), num(get(&r, il))]);
			}
		}
	}
	let classes = Obj::new();
	let mut seen = rustc_hash::FxHashSet::default();
	let mut spells = 0;
	for [tpl, spell, cost, level] in rows {
		let Some(&cls) = template_class.get(&(tpl as i64)) else { continue };
		if !(level > 0.0) || !seen.insert(format!("{cls}:{}", forge_guide::js::num_str(spell))) {
			continue;
		}
		if !classes.has(cls) {
			classes.set(cls, Obj::new());
		}
		let c = classes.get(cls);
		let k = forge_guide::js::num_str(level);
		let cur = c.get(&k).as_num().unwrap_or(0.0);
		c.set(&k, cur + cost);
		spells += 1;
	}
	let o = Obj::new();
	o.set("classes", classes);
	o.set("spells", spells);
	V::Obj(o)
}

/// Lines -> { id: { type, respawn, loot? } } per gameobject template with a spawn or loot.
fn extract_object_facts(lines: impl Iterator<Item = String>) -> Result<V, String> {
	let mut t = Columns::default();
	let mut tpl: IndexMap<i64, (f64, f64)> = IndexMap::new();
	let mut respawn: rustc_hash::FxHashMap<i64, f64> = rustc_hash::FxHashMap::default();
	let mut pooled: rustc_hash::FxHashMap<i64, f64> = rustc_hash::FxHashMap::default();
	let mut entries: Vec<(i64, i64)> = Vec::new();
	let mut loot: rustc_hash::FxHashMap<i64, Obj> = rustc_hash::FxHashMap::default();
	let least = |respawn: &mut rustc_hash::FxHashMap<i64, f64>, id: i64, s: f64| {
		if !s.is_finite() || s <= 0.0 {
			return;
		}
		let e = respawn.entry(id).or_insert(s);
		if s < *e {
			*e = s;
		}
	};
	for line in lines {
		if t.see(&line) {
			continue;
		}
		if line.starts_with("INSERT INTO `gameobject_template` VALUES") {
			let (ie, it, id1) = (t.at("gameobject_template", "entry", 0), t.at("gameobject_template", "type", 1), t.at("gameobject_template", "data1", 9));
			for r in tuples(&line) {
				tpl.insert(num(get(&r, ie)) as i64, (num(get(&r, it)), num(get(&r, id1))));
			}
		} else if line.starts_with("INSERT INTO `gameobject` VALUES") {
			let (ig, ii, is) = (t.at("gameobject", "guid", 0), t.at("gameobject", "id", 1), t.at("gameobject", "spawntimesecsmin", t.at("gameobject", "spawntimesecs", -1)));
			if is < 0 {
				continue;
			}
			for r in tuples(&line) {
				let id = num(get(&r, ii));
				if id > 0.0 {
					least(&mut respawn, id as i64, num(get(&r, is)));
				} else {
					pooled.insert(num(get(&r, ig)) as i64, num(get(&r, is)));
				}
			}
		} else if line.starts_with("INSERT INTO `gameobject_spawn_entry` VALUES") {
			for r in tuples(&line) {
				entries.push((num(&r[0]) as i64, num(&r[1]) as i64));
			}
		} else if line.starts_with("INSERT INTO `gameobject_loot_template` VALUES") {
			let at = |n: &str, f: i64| t.at("gameobject_loot_template", n, f);
			let (ie, ii, ic, imin, imax) = (at("entry", 0), at("item", 1), at("ChanceOrQuestChance", 2), at("mincountOrRef", 4), at("maxcount", 5));
			for r in tuples(&line) {
				let min = num(get(&r, imin));
				if !(min > 0.0) {
					continue;
				}
				let e = num(get(&r, ie)) as i64;
				loot.entry(e).or_default().set(&forge_guide::js::num_str(num(get(&r, ii))), crate::jsv::nums(&[num(get(&r, ic)), min, num(get(&r, imax))]));
			}
		}
	}
	for (guid, entry) in entries {
		if let Some(&s) = pooled.get(&guid) {
			if entry > 0 {
				least(&mut respawn, entry, s);
			}
		}
	}
	let out = Obj::new();
	let mut ids: Vec<i64> = tpl.keys().copied().collect();
	ids.sort();
	for id in ids {
		let (kind, loot_id) = tpl[&id];
		let l = if kind == 3.0 || kind == 25.0 { loot.get(&(loot_id as i64)) } else { None };
		if !respawn.contains_key(&id) && l.is_none() {
			continue;
		}
		let o = Obj::new();
		o.set("type", kind);
		o.set("respawn", respawn.get(&id).map(|&r| V::Num(r)).unwrap_or(V::Null));
		if let Some(l) = l {
			o.set("loot", l.clone());
		}
		out.set(&id.to_string(), o);
	}
	if out.is_empty() {
		return Err(format!("classic-db {}: no gameobject rows", &DB_REV[..8]));
	}
	Ok(V::Obj(out))
}

/// Lines -> { links: [[graveyard, zone, team]], locs: { graveyard: [map, x, y, z, name] } }.
fn extract_graveyards(lines: impl Iterator<Item = String>) -> Result<V, String> {
	let mut t = Columns::default();
	let mut links: Vec<[f64; 3]> = Vec::new();
	let locs = Obj::new();
	for line in lines {
		if t.see(&line) {
			continue;
		}
		if line.starts_with("INSERT INTO `game_graveyard_zone` VALUES") {
			let c: Vec<i64> = ["id", "ghost_loc", "link_kind", "faction"].iter().enumerate().map(|(i, c)| t.at("game_graveyard_zone", c, i as i64)).collect();
			for r in tuples(&line) {
				if num(get(&r, c[2])) == 0.0 {
					links.push([num(get(&r, c[0])), num(get(&r, c[1])), num(get(&r, c[3]))]);
				}
			}
		} else if line.starts_with("INSERT INTO `world_safe_locs` VALUES") {
			let c: Vec<i64> = ["id", "map", "x", "y", "z", "name"].iter().enumerate().map(|(i, c)| t.at("world_safe_locs", c, if i < 5 { i as i64 } else { 6 })).collect();
			for r in tuples(&line) {
				let name = get(&r, c[5]).trim_matches(|ch: char| ch.is_whitespace() || ch == '\u{feff}');
				locs.set(get(&r, c[0]), arr(vec![V::Num(num(get(&r, c[1]))), V::Num(tenth(get(&r, c[2]))), V::Num(tenth(get(&r, c[3]))), V::Num(tenth(get(&r, c[4]))), V::str(name)]));
			}
		}
	}
	if links.is_empty() || locs.is_empty() {
		return Err(format!("classic-db {}: missing game_graveyard_zone or world_safe_locs", &DB_REV[..8]));
	}
	links.sort_by(|a, b| a.iter().zip(b).map(|(x, y)| x.partial_cmp(y).unwrap()).find(|o| o.is_ne()).unwrap_or(std::cmp::Ordering::Equal));
	let o = Obj::new();
	o.set("links", arr(links.iter().map(|l| crate::jsv::nums(l)).collect()));
	o.set("locs", locs);
	Ok(V::Obj(o))
}

/// Lines -> { paths: { entry: [yd, waitSec] }, summons: { script: n } }.
fn extract_escort_paths(lines: impl Iterator<Item = String>) -> Result<V, String> {
	let mut t = Columns::default();
	let mut pts: IndexMap<i64, IndexMap<i64, Vec<[f64; 5]>>> = IndexMap::new();
	let summons = Obj::new();
	for line in lines {
		if t.see(&line) {
			continue;
		}
		if line.starts_with("INSERT INTO `script_waypoint` VALUES") {
			let c: Vec<i64> =
				["Entry", "PathId", "Point", "PositionX", "PositionY", "PositionZ", "WaitTime"].iter().enumerate().map(|(i, c)| t.at("script_waypoint", c, if i < 6 { i as i64 } else { 7 })).collect();
			for r in tuples(&line) {
				let k = num(get(&r, c[0])) as i64;
				let p = num(get(&r, c[1])) as i64;
				pts.entry(k).or_default().entry(p).or_default().push([num(get(&r, c[2])), num(get(&r, c[3])), num(get(&r, c[4])), num(get(&r, c[5])), num(get(&r, c[6]))]);
			}
		} else if line.starts_with("INSERT INTO `dbscripts_on_quest_start` VALUES") {
			let (id, cmd) = (t.at("dbscripts_on_quest_start", "id", 0), t.at("dbscripts_on_quest_start", "command", 3));
			for r in tuples(&line) {
				if num(get(&r, cmd)) == 10.0 {
					let k = get(&r, id);
					let cur = summons.get(k).as_num().unwrap_or(0.0);
					summons.set(k, cur + 1.0);
				}
			}
		}
	}
	if pts.is_empty() {
		return Err(format!("classic-db {}: missing script_waypoint", &DB_REV[..8]));
	}
	let paths = Obj::new();
	let mut keys: Vec<i64> = pts.keys().copied().collect();
	keys.sort();
	for k in keys {
		let by = &pts[&k];
		let mut list = by.get(&0).cloned().unwrap_or_else(|| by[&by.keys().copied().min().unwrap()].clone());
		list.sort_by(|a, b| a[0].partial_cmp(&b[0]).unwrap());
		let (mut yd, mut wait) = (0.0, 0.0);
		for i in 0..list.len() {
			wait += list[i][4];
			if i > 0 {
				yd += forge_core::jsnum::js_hypot_n(&[list[i][1] - list[i - 1][1], list[i][2] - list[i - 1][2], list[i][3] - list[i - 1][3]]);
			}
		}
		paths.set(&k.to_string(), crate::jsv::nums(&[crate::jsv::math_round(yd), crate::jsv::math_round(wait / 1000.0)]));
	}
	let o = Obj::new();
	o.set("paths", paths);
	o.set("summons", summons);
	Ok(V::Obj(o))
}

/// spawnz.json's text: one id per line.
pub fn serialize_spawn_heights(db: &V) -> String {
	let part = |t: V| {
		t.entries()
			.iter()
			.map(|(id, v)| {
				let mut s = String::new();
				json_quote(&mut s, id);
				format!("{s}:{}", stringify(v, None))
			})
			.collect::<Vec<_>>()
			.join(",\n")
	};
	format!("{{\"npc\":{{\n{}\n}},\"object\":{{\n{}\n}}}}\n", part(db.get("npc")), part(db.get("object")))
}

fn extract_quest_counts(lines: impl Iterator<Item = String>) -> Result<V, String> {
	let out = Obj::new();
	let mut cols: Option<Vec<String>> = None;
	let mut creating = false;
	let n = |s: &str| forge_guide::js::str_to_num(s);
	for line in lines {
		if line.starts_with("CREATE TABLE `quest_template` (") {
			creating = true;
			cols = Some(Vec::new());
		} else if creating {
			let t = line.trim_start();
			match t.strip_prefix('`').and_then(|r| r.find('`').map(|e| &r[..e])).filter(|c| !c.is_empty() && c.bytes().all(|b| b.is_ascii_alphanumeric() || b == b'_')) {
				Some(c) => cols.as_mut().unwrap().push(c.to_string()),
				None => creating = false,
			}
		} else if line.starts_with("INSERT INTO `quest_template` VALUES") {
			let cols = cols.as_ref().ok_or("classic-db: quest_template rows before its CREATE TABLE")?;
			let at = |c: &str| cols.iter().position(|x| x == c).ok_or_else(|| format!("classic-db: quest_template has no {c}"));
			let entry = at("entry")?;
			let kills: Vec<(usize, usize)> = (1..=4).map(|i| Ok((at(&format!("ReqCreatureOrGOId{i}"))?, at(&format!("ReqCreatureOrGOCount{i}"))?))).collect::<Result<_, String>>()?;
			let items: Vec<(usize, usize)> = (1..=4).map(|i| Ok((at(&format!("ReqItemId{i}"))?, at(&format!("ReqItemCount{i}"))?))).collect::<Result<_, String>>()?;
			for r in tuples(&line) {
				let (k, o, it) = (V::arr(), V::arr(), V::arr());
				for &(i, c) in &kills {
					let (id, count) = (n(&r[i]), n(&r[c]));
					if id > 0.0 && count > 0.0 {
						k.push(crate::jsv::nums(&[id, count]));
					} else if id < 0.0 && count > 0.0 {
						o.push(crate::jsv::nums(&[-id, count]));
					}
				}
				for &(i, c) in &items {
					let (id, count) = (n(&r[i]), n(&r[c]));
					if id > 0.0 && count > 0.0 {
						it.push(crate::jsv::nums(&[id, count]));
					}
				}
				if k.len() + o.len() + it.len() > 0 {
					let q = Obj::new();
					q.set("kill", k);
					q.set("object", o);
					q.set("item", it);
					out.set(&forge_guide::js::num_str(n(&r[entry])), q);
				}
			}
		}
	}
	if out.is_empty() {
		return Err(format!("classic-db {}: no quest_template rows", &DB_REV[..8]));
	}
	Ok(V::Obj(out))
}

/// Quest and creature facts for the knowledge base's independent-source checks and the public
/// tier (quest_facts.json; facts only, no quest text): { quest: { id: { title, level, minLevel,
/// races, classes, prev, src (the starting item), obj: [[c|o|i, id, count]...], start/end:
/// ["npc:ID" | "object:ID" | "item:ID"...], money, items: [[id, count]...], choices, rep: [[faction,
/// value]...], type, zone (ZoneOrSort) } }, npc: { id: [name, subname, minLevel, maxLevel,
/// faction template] } }. Columns are found by name.
fn extract_quest_facts(lines: impl Iterator<Item = String>) -> Result<V, String> {
	let mut c = Columns::default();
	let quests: IndexMap<i64, Obj> = IndexMap::new();
	let mut quests = quests;
	let mut rel: [IndexMap<i64, Vec<String>>; 2] = [IndexMap::new(), IndexMap::new()];
	let npcs = Obj::new();
	let mut item_starts: Vec<(i64, i64)> = Vec::new();
	let n = |s: &str| forge_guide::js::str_to_num(s);
	let pairs = |r: &[String], ids: &[i64], counts: &[i64]| -> V {
		let out = V::arr();
		for (&i, &k) in ids.iter().zip(counts) {
			let (id, count) = (n(get(r, i)), n(get(r, k)));
			if id != 0.0 {
				out.push(crate::jsv::nums(&[id, count]));
			}
		}
		out
	};
	for line in lines {
		if c.see(&line) {
			continue;
		}
		let Some(rest) = line.strip_prefix("INSERT INTO `") else { continue };
		let Some(table) = rest.split('`').next() else { continue };
		match table {
			"quest_template" => {
				let at = |name: &str| c.at("quest_template", name, -1);
				let cols = |pre: &str, k: usize| (1..=k).map(|i| at(&format!("{pre}{i}"))).collect::<Vec<_>>();
				let (kill_id, kill_n, item_id, item_n) = (cols("ReqCreatureOrGOId", 4), cols("ReqCreatureOrGOCount", 4), cols("ReqItemId", 4), cols("ReqItemCount", 4));
				let (ch_id, ch_n, rw_id, rw_n, rep_f, rep_v) =
					(cols("RewChoiceItemId", 6), cols("RewChoiceItemCount", 6), cols("RewItemId", 4), cols("RewItemCount", 4), cols("RewRepFaction", 5), cols("RewRepValue", 5));
				if at("entry") < 0 {
					return Err("classic-db: quest_template has no entry".into());
				}
				for r in tuples(&line) {
					let q = Obj::new();
					q.set("title", V::str(get(&r, at("Title"))));
					for (k, col) in [
						("level", "QuestLevel"),
						("minLevel", "MinLevel"),
						("races", "RequiredRaces"),
						("classes", "RequiredClasses"),
						("prev", "PrevQuestId"),
						("src", "SrcItemId"),
						("money", "RewOrReqMoney"),
						("type", "Type"),
						("zone", "ZoneOrSort"),
					] {
						q.set(k, V::Num(n(get(&r, at(col)))));
					}
					let src = n(get(&r, at("SrcItemId")));
					let obj = V::arr();
					for (&i, &k) in kill_id.iter().zip(&kill_n) {
						let (id, count) = (n(get(&r, i)), n(get(&r, k)));
						if id > 0.0 {
							obj.push(arr(vec![V::str("c"), V::Num(id), V::Num(count)]));
						} else if id < 0.0 {
							obj.push(arr(vec![V::str("o"), V::Num(-id), V::Num(count)]));
						}
					}
					for (&i, &k) in item_id.iter().zip(&item_n) {
						let (id, count) = (n(get(&r, i)), n(get(&r, k)));
						if id > 0.0 && id != src {
							obj.push(arr(vec![V::str("i"), V::Num(id), V::Num(count)]));
						}
					}
					q.set("obj", obj);
					q.set("items", pairs(&r, &rw_id, &rw_n));
					q.set("choices", pairs(&r, &ch_id, &ch_n));
					q.set("rep", pairs(&r, &rep_f, &rep_v));
					quests.insert(n(get(&r, at("entry"))) as i64, q);
				}
			}
			"creature_questrelation" | "gameobject_questrelation" | "creature_involvedrelation" | "gameobject_involvedrelation" => {
				let (kind, side) = (if table.starts_with("creature") { "npc" } else { "object" }, usize::from(table.contains("involved")));
				let (ci, cq) = (c.at(table, "id", 0), c.at(table, "quest", 1));
				for r in tuples(&line) {
					rel[side].entry(n(get(&r, cq)) as i64).or_default().push(format!("{kind}:{}", get(&r, ci)));
				}
			}
			"item_template" => {
				let (ce, cs) = (c.at(table, "entry", 0), c.at(table, "startquest", -1));
				for r in tuples(&line) {
					let q = n(get(&r, cs));
					if q > 0.0 {
						item_starts.push((q as i64, n(get(&r, ce)) as i64));
					}
				}
			}
			"creature_template" => {
				let at = |name: &str| c.at(table, name, -1);
				for r in tuples(&line) {
					let row = arr(vec![
						V::str(get(&r, at("Name"))),
						V::str(get(&r, at("SubName"))),
						V::Num(n(get(&r, at("MinLevel")))),
						V::Num(n(get(&r, at("MaxLevel")))),
						V::Num(n(get(&r, at("Faction")))),
					]);
					npcs.set(get(&r, at("Entry")), row);
				}
			}
			_ => {}
		}
	}
	if quests.is_empty() {
		return Err(format!("classic-db {}: no quest_template rows", &DB_REV[..8]));
	}
	for (q, item) in item_starts {
		rel[0].entry(q).or_default().push(format!("item:{item}"));
	}
	let out = Obj::new();
	for (id, q) in &quests {
		for (side, key) in [(0, "start"), (1, "end")] {
			let mut v = rel[side].get(id).cloned().unwrap_or_default();
			v.sort();
			v.dedup();
			q.set(key, arr(v.iter().map(|s| V::str(s)).collect()));
		}
		out.set(&id.to_string(), V::Obj(q.clone()));
	}
	let all = Obj::new();
	all.set("quest", V::Obj(out));
	all.set("npc", V::Obj(npcs));
	Ok(V::Obj(all))
}

/// The pinned dump's extract `name`, built from the cached dump when missing (`--offline`: never
/// fetched).
fn cached_extract(sources: &Path, name: &str, extract: &dyn Fn(Box<dyn Iterator<Item = String>>) -> Result<String, String>) -> Result<V, String> {
	let dir = sources.join("cmangos").join(&DB_REV[..DB_SHA256_LEN]);
	let file = dir.join(name);
	if !file.exists() {
		let dump = dir.join("classicdb.sql.gz");
		if !dump.exists() {
			return Err(format!("--offline: missing cached {}", file.display()));
		}
		let text = extract(dump_lines(&dump)?)?;
		let tmp = dir.join(format!("{name}.tmp"));
		std::fs::write(&tmp, text).map_err(|e| e.to_string())?;
		std::fs::rename(&tmp, &file).map_err(|e| e.to_string())?;
	}
	read_json(&file)?.ok_or_else(|| format!("{}: missing", file.display()))
}

pub struct Heights {
	pub text: String,
	pub npc: V,
	pub object: V,
}

/// Spawn heights: next's spawnz.json (no respawn) or sim-v2's spawnz.2.json (with respawn).
pub fn load_spawn_heights(sources: &Path, sim: bool) -> Result<Heights, String> {
	let name = if sim { "spawnz.2.json" } else { "spawnz.json" };
	let data = cached_extract(sources, name, &|lines| Ok(serialize_spawn_heights(&extract_spawn_heights(lines, sim))))?;
	Ok(Heights { text: serialize_spawn_heights(&data), npc: data.get("npc"), object: data.get("object") })
}

/// Creature walks: moves.json's text (see extract_moves).
pub fn load_moves(sources: &Path) -> Result<String, String> {
	Ok(serialize_moves(&cached_extract(sources, "moves.json", &|lines| Ok(serialize_moves(&extract_moves(lines))))?))
}

pub fn load_quest_counts(sources: &Path) -> Result<V, String> {
	cached_extract(sources, "quest_counts.json", &|lines| Ok(format!("{}\n", stringify(&extract_quest_counts(lines)?, None))))
}

/// Quest and creature facts (quest_facts.json; see extract_quest_facts).
pub fn load_quest_facts(sources: &Path) -> Result<V, String> {
	cached_extract(sources, "quest_facts.json", &|lines| Ok(format!("{}\n", stringify(&extract_quest_facts(lines)?, None))))
}

/// Class training costs: { classes, spells } (cached as training.json beside the dump).
pub fn load_training(sources: &Path) -> Result<V, String> {
	cached_extract(sources, "training.json", &|lines| Ok(format!("{}\n", stringify(&extract_training(lines), Some("\t")))))
}

/// Gameobject facts for the sim world (gameobject_facts.json).
pub fn load_object_facts(sources: &Path) -> Result<V, String> {
	cached_extract(sources, "gameobject_facts.json", &|lines| Ok(format!("{}\n", stringify(&extract_object_facts(lines)?, None))))
}

/// Graveyards for the sim's deathskip (graveyards.json).
pub fn load_graveyards(sources: &Path) -> Result<V, String> {
	cached_extract(sources, "graveyards.json", &|lines| Ok(format!("{}\n", stringify(&extract_graveyards(lines)?, None))))
}

/// Escort paths and quest-start summons (escort_paths.json).
pub fn load_escort_paths(sources: &Path) -> Result<V, String> {
	cached_extract(sources, "escort_paths.json", &|lines| Ok(format!("{}\n", stringify(&extract_escort_paths(lines)?, None))))
}

/// Lines -> { entry: { name, faction (a FactionTemplate id), npcFlags, extraFlags, rank, minLevel } } for
/// every creature template, the columns found by name (cmangos.js extractCreatureTemplates; the hubs
/// layer's input).
fn extract_creature_templates(lines: impl Iterator<Item = String>) -> Result<V, String> {
	const COLS: [(&str, &str); 6] = [("Name", "name"), ("Faction", "faction"), ("NpcFlags", "npcFlags"), ("ExtraFlags", "extraFlags"), ("Rank", "rank"), ("MinLevel", "minLevel")];
	let mut c = Columns::default();
	let mut rows: std::collections::BTreeMap<i64, Obj> = std::collections::BTreeMap::new();
	for line in lines {
		if c.see(&line) {
			continue;
		}
		if line.starts_with("INSERT INTO `creature_template` VALUES") {
			let at = |name: &str| c.at("creature_template", name, -1);
			let lost: Vec<&str> = std::iter::once("Entry").chain(COLS.iter().map(|x| x.0)).filter(|n| at(n) < 0).collect();
			if !lost.is_empty() {
				return Err(format!("classic-db: creature_template has no {}", lost.join(", ")));
			}
			for r in tuples(&line) {
				let t = Obj::new();
				for (col, key) in COLS {
					t.set(key, if col == "Name" { V::str(get(&r, at(col))) } else { V::Num(num(get(&r, at(col)))) });
				}
				rows.insert(num(get(&r, at("Entry"))) as i64, t);
			}
		}
	}
	if rows.is_empty() {
		return Err(format!("classic-db {}: no creature_template rows", &DB_REV[..8]));
	}
	let out = Obj::new();
	for (k, t) in rows {
		out.set(&k.to_string(), V::Obj(t));
	}
	Ok(V::Obj(out))
}

/// Creature templates (creature_template.json; see extract_creature_templates).
pub fn load_creature_templates(sources: &Path) -> Result<V, String> {
	cached_extract(sources, "creature_template.json", &|lines| Ok(format!("{}\n", stringify(&extract_creature_templates(lines)?, None))))
}

/// One extract's text by its cache file name: the cached file when present, else extracted from the
/// cached dump (never written back).
pub fn extract_text(sources: &Path, name: &str) -> Result<String, String> {
	let dir = sources.join("cmangos").join(&DB_REV[..DB_SHA256_LEN]);
	if let Ok(t) = std::fs::read_to_string(dir.join(name)) {
		return Ok(t);
	}
	let dump = dir.join("classicdb.sql.gz");
	if !dump.exists() {
		return Err(format!("missing cached {} and the dump {}", dir.join(name).display(), dump.display()));
	}
	let lines = dump_lines(&dump)?;
	Ok(match name {
		"spawnz.json" => serialize_spawn_heights(&extract_spawn_heights(lines, false)),
		"spawnz.2.json" => serialize_spawn_heights(&extract_spawn_heights(lines, true)),
		"quest_counts.json" => format!("{}\n", stringify(&extract_quest_counts(lines)?, None)),
		"training.json" => format!("{}\n", stringify(&extract_training(lines), Some("\t"))),
		"gameobject_facts.json" => format!("{}\n", stringify(&extract_object_facts(lines)?, None)),
		"graveyards.json" => format!("{}\n", stringify(&extract_graveyards(lines)?, None)),
		"escort_paths.json" => format!("{}\n", stringify(&extract_escort_paths(lines)?, None)),
		"quest_facts.json" => format!("{}\n", stringify(&extract_quest_facts(lines)?, None)),
		"creature_template.json" => format!("{}\n", stringify(&extract_creature_templates(lines)?, None)),
		"moves.json" => serialize_moves(&extract_moves(lines)),
		_ => return Err(format!("no CMaNGOS extract named {name}")),
	})
}

/// The extracts from the cached dump, written to `dir` (parity checks against the cached ones).
pub fn extract_all(sources: &Path, dir: &Path) -> Result<(), String> {
	let dump = sources.join("cmangos").join(&DB_REV[..DB_SHA256_LEN]).join("classicdb.sql.gz");
	let w = |name: &str, text: String| std::fs::write(dir.join(name), text).map_err(|e| e.to_string());
	w("spawnz.json", serialize_spawn_heights(&extract_spawn_heights(dump_lines(&dump)?, false)))?;
	w("spawnz.2.json", serialize_spawn_heights(&extract_spawn_heights(dump_lines(&dump)?, true)))?;
	w("quest_counts.json", format!("{}\n", stringify(&extract_quest_counts(dump_lines(&dump)?)?, None)))?;
	w("training.json", format!("{}\n", stringify(&extract_training(dump_lines(&dump)?), Some("\t"))))?;
	w("gameobject_facts.json", format!("{}\n", stringify(&extract_object_facts(dump_lines(&dump)?)?, None)))?;
	w("graveyards.json", format!("{}\n", stringify(&extract_graveyards(dump_lines(&dump)?)?, None)))?;
	w("escort_paths.json", format!("{}\n", stringify(&extract_escort_paths(dump_lines(&dump)?)?, None)))?;
	w("quest_facts.json", format!("{}\n", stringify(&extract_quest_facts(dump_lines(&dump)?)?, None)))?;
	w("moves.json", serialize_moves(&extract_moves(dump_lines(&dump)?)))?;
	Ok(())
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn creature_templates_from_the_dump_columns_by_the_create_table_quoted_names() {
		let lines = [
			"CREATE TABLE `creature_template` (",
			"  `Entry` mediumint unsigned NOT NULL DEFAULT '0',",
			"  `Name` char(100) NOT NULL DEFAULT '',",
			"  `MinLevel` tinyint unsigned NOT NULL DEFAULT '1',",
			"  `Faction` smallint unsigned NOT NULL DEFAULT '0',",
			"  `NpcFlags` int unsigned NOT NULL DEFAULT '0',",
			"  `ExtraFlags` int unsigned NOT NULL DEFAULT '0',",
			"  `Rank` tinyint unsigned NOT NULL DEFAULT '0',",
			"  PRIMARY KEY (`Entry`)",
			") ENGINE=MyISAM;",
			r"INSERT INTO `creature_template` VALUES (68,'Stormwind City Guard',55,11,1,1024,0),(2405,'Tarren Mill Deathguard',55,71,1,1024,0),(9,'O\'Neil, the (Test)',3,7,0,0,1);",
		];
		let t = extract_creature_templates(lines.iter().map(|l| l.to_string())).unwrap();
		assert_eq!(stringify(&t.get("68"), None), r#"{"name":"Stormwind City Guard","faction":11,"npcFlags":1,"extraFlags":1024,"rank":0,"minLevel":55}"#);
		assert_eq!(stringify(&t.get("9").get("name"), None), r#""O'Neil, the (Test)""#);
		assert_eq!(stringify(&t.get("2405").get("faction"), None), "71");
		assert!(stringify(&t, None).starts_with(r#"{"9":"#), "entries in numeric order, as JSON.stringify writes integer keys");
	}

	#[test]
	fn moves_are_each_walking_spawns_ground_by_its_path_or_its_wander_distance() {
		let lines = [
			"CREATE TABLE `creature` (",
			"  `guid` int unsigned NOT NULL AUTO_INCREMENT,",
			"  `id` mediumint unsigned NOT NULL DEFAULT '0',",
			"  `map` smallint unsigned NOT NULL DEFAULT '0',",
			"  `spawnMask` tinyint unsigned NOT NULL DEFAULT '1',",
			"  `position_x` float NOT NULL DEFAULT '0',",
			"  `position_y` float NOT NULL DEFAULT '0',",
			"  `position_z` float NOT NULL DEFAULT '0',",
			"  `orientation` float NOT NULL DEFAULT '0',",
			"  `spawntimesecsmin` int unsigned NOT NULL DEFAULT '120',",
			"  `spawntimesecsmax` int unsigned NOT NULL DEFAULT '120',",
			"  `spawndist` float NOT NULL DEFAULT '5',",
			"  `MovementType` tinyint unsigned NOT NULL DEFAULT '0',",
			"  PRIMARY KEY (`guid`)",
			") ENGINE=MyISAM;",
			// A waypoint walker (template path), a wanderer, one pacing on the spot, one standing, one in a dungeon.
			"INSERT INTO `creature` VALUES (34111,1742,0,1,2289.3,391.421,34.2,3.6,300,300,0,2),(5,100,1,1,10,20,0,0,300,300,25,1),(6,101,0,1,10,20,0,0,300,300,5,1),(7,102,0,1,10,20,0,0,300,300,0,0),(8,103,36,1,10,20,0,0,300,300,30,1);",
			"CREATE TABLE `creature_movement_template` (",
			"  `Entry` mediumint unsigned NOT NULL,",
			"  `PathId` int unsigned NOT NULL DEFAULT '0',",
			"  `Point` mediumint unsigned NOT NULL DEFAULT '0',",
			"  `PositionX` float NOT NULL DEFAULT '0',",
			"  `PositionY` float NOT NULL DEFAULT '0',",
			"  `PositionZ` float NOT NULL DEFAULT '0',",
			"  PRIMARY KEY (`Entry`,`PathId`,`Point`)",
			") ENGINE=MyISAM;",
			"INSERT INTO `creature_movement_template` VALUES (1742,0,1,2289.3,391.4,34.1),(1742,0,2,2349.3,391.4,34),(1742,0,3,2319.3,331.4,37),(1742,1,1,0,0,0);",
		];
		let m = extract_moves(lines.iter().map(|l| l.to_string()));
		assert_eq!(serialize_moves(&m), "{\"npc\":{\n\"100\":[[1,10,20,10,20,25]],\n\"1742\":[[0,2289.3,391.4,2319.3,361.4,42.5]]\n}}\n");
	}
}
