//! The hostile hubs layer (port of tools/lib/nav/layers/hubs.js): each faction's towns and outposts,
//! where every guard attacks a player of the other faction. Built from the CMaNGOS classic-db spawns
//! and creature templates, judged by the client's FactionTemplate table and named by its AreaTable:
//!
//! - a creature template is one side's when its faction template is hostile to the other side's
//!   players and not to its own (FactionTemplateEntry::IsHostileTo of mangos-classic, against the player
//!   templates of the side's races);
//! - a guard: one side's, with ExtraFlags CREATURE_EXTRA_FLAG_GUARD (0x400) and at least MIN_GUARD_LEVEL,
//!   or with a guard's name (GUARD_NAMES) and at least MIN_NAMED_GUARD_LEVEL;
//! - a service NPC: one side's, not a guard, with a quest giver, vendor, flight master, trainer,
//!   innkeeper, banker or repair NpcFlag.
//!
//! Guards and service NPCs of one side on one map are clustered by single linkage at LINK yd; a cluster
//! with at least MIN_GUARDS guard or MIN_SERVICES service NPCs is a hub. Hubs of one side within JOIN yd
//! are listed as one (a naming merge only). A hub's disks: one per spawn, GUARD_RADIUS around a guard,
//! SERVICE_RADIUS around a service NPC. Named by the AreaTable: the capital at least half its spawns stand
//! in (by the grid's chunk area or the zone map around them), else the subzone under its centroid, else the
//! most common subzone under its spawns, else the zone.
//!
//! hubs.json: { 0: [hub], 1: [hub], 2991: [hub], build, rev, maps, rules }; hub = { id, side, name, areaId,
//! guards, services, disks: [[x, y, r]] } (x north, y west).

use forge_core::jsnum::{js_hypot, js_round};
use rustc_hash::FxHashMap;
use serde_json::{json, Map, Value};
use std::cmp::Ordering;

/// Maps with hubs: Eastern Kingdoms, Kalimdor, Zephras Isle (no CMaNGOS spawns: always empty).
pub const HUB_MAPS: [u32; 3] = [0, 1, 2991];
/// The player faction templates of each side: Human, Dwarf, Night Elf, Gnome / Orc, Undead, Tauren, Troll.
const PLAYER_ALLIANCE: [u32; 4] = [1, 3, 4, 115];
const PLAYER_HORDE: [u32; 4] = [2, 5, 6, 116];
const EXTRA_INVISIBLE: i64 = 0x80;
pub const EXTRA_GUARD: i64 = 0x400;
const AREA_CAPITAL: i64 = 0x100;
/// Quest giver, vendor, flight master, trainer, innkeeper, banker, repair.
pub const SERVICE_FLAGS: i64 = 0x2 | 0x4 | 0x8 | 0x10 | 0x80 | 0x100 | 0x4000;
pub const GUARD_NAMES: [&str; 13] = ["Guard", "Sentinel", "Grunt", "Protector", "Deathguard", "Brave", "Watcher", "Watchman", "Mountaineer", "Peacekeeper", "Defender", "Enforcer", "Soldier"];
pub const MIN_GUARD_LEVEL: f64 = 10.0;
pub const MIN_NAMED_GUARD_LEVEL: f64 = 20.0;
pub const GUARD_RADIUS: f64 = 50.0;
pub const SERVICE_RADIUS: f64 = 25.0;
const LINK: f64 = 60.0;
const JOIN: f64 = 100.0;
const MIN_GUARDS: usize = 1;
const MIN_SERVICES: usize = 4;

/// CSV text -> rows (header names -> fields).
pub fn csv_rows(text: &str) -> Vec<FxHashMap<String, String>> {
	let split = |line: &str| -> Vec<String> {
		let mut out = Vec::new();
		let mut cur = String::new();
		let mut q = false;
		let mut it = line.chars().peekable();
		while let Some(ch) = it.next() {
			match ch {
				'"' if q && it.peek() == Some(&'"') => {
					cur.push('"');
					it.next();
				}
				'"' => q = !q,
				',' if !q => out.push(std::mem::take(&mut cur)),
				_ => cur.push(ch),
			}
		}
		out.push(cur);
		out
	};
	let mut lines = text.lines();
	let Some(head) = lines.next() else { return Vec::new() };
	let head = split(head);
	lines.filter(|l| !l.is_empty()).map(|l| head.iter().cloned().zip(split(l)).collect()).collect()
}

fn num(r: &FxHashMap<String, String>, k: &str) -> f64 {
	r.get(k).and_then(|v| v.trim().parse::<f64>().ok()).unwrap_or(0.0)
}

struct Faction {
	faction: u32,
	group: i64,
	enemy_group: i64,
	enemies: Vec<u32>,
	friends: Vec<u32>,
}

/// FactionTemplate rows -> per template: whether it attacks (Alliance, Horde) players.
pub struct Hostility {
	rows: FxHashMap<u32, Faction>,
}

impl Hostility {
	pub fn new(rows: &[FxHashMap<String, String>]) -> Result<Hostility, String> {
		let ids = |r: &FxHashMap<String, String>, key: &str| -> Vec<u32> { (0..8).map(|i| num(r, &format!("{key}_{i}")) as u32).filter(|&v| v != 0).collect() };
		let mut m = FxHashMap::default();
		for r in rows {
			m.insert(
				num(r, "ID") as u32,
				Faction { faction: num(r, "Faction") as u32, group: num(r, "FactionGroup") as i64, enemy_group: num(r, "EnemyGroup") as i64, enemies: ids(r, "Enemies"), friends: ids(r, "Friend") },
			);
		}
		for (side, list) in [("Alliance", PLAYER_ALLIANCE), ("Horde", PLAYER_HORDE)] {
			for id in list {
				if !m.contains_key(&id) {
					return Err(format!("FactionTemplate has no player template {id} ({side})"));
				}
			}
		}
		Ok(Hostility { rows: m })
	}

	fn hostile(a: &Faction, b: &Faction) -> bool {
		if b.faction != 0 {
			if a.enemies.contains(&b.faction) {
				return true;
			}
			if a.friends.contains(&b.faction) {
				return false;
			}
		}
		a.enemy_group & b.group != 0
	}

	/// (hostile to Alliance players, hostile to Horde players), None for an unknown template.
	pub fn of(&self, id: u32) -> Option<(bool, bool)> {
		let a = self.rows.get(&id)?;
		let to = |list: [u32; 4]| list.iter().any(|p| Hostility::hostile(a, &self.rows[p]));
		Some((to(PLAYER_ALLIANCE), to(PLAYER_HORDE)))
	}
}

/// GUARD_NAMES as whole words (JS \b: ASCII word characters).
pub fn guard_name(name: &str) -> bool {
	let b = name.as_bytes();
	let word = |i: usize| b.get(i).is_some_and(|c| c.is_ascii_alphanumeric() || *c == b'_');
	GUARD_NAMES.iter().any(|w| {
		let mut from = 0;
		while let Some(k) = name[from..].find(w) {
			let at = from + k;
			if (at == 0 || !word(at - 1)) && !word(at + w.len()) {
				return true;
			}
			from = at + 1;
		}
		false
	})
}

/// A creature template -> (side, guard) or None (hubs.js roleOf).
pub fn role_of(t: &Value, h: &Hostility) -> Option<(&'static str, bool)> {
	if !t.is_object() {
		return None;
	}
	let n = |k: &str| t[k].as_f64().unwrap_or(f64::NAN);
	let extra = n("extraFlags") as i64;
	if extra & EXTRA_INVISIBLE != 0 {
		return None;
	}
	let (a, hh) = h.of(n("faction") as u32)?;
	if a == hh {
		return None;
	}
	let side = if hh { "Alliance" } else { "Horde" };
	let min = n("minLevel");
	let guard = if extra & EXTRA_GUARD != 0 { min >= MIN_GUARD_LEVEL } else { guard_name(t["name"].as_str().unwrap_or("")) && min >= MIN_NAMED_GUARD_LEVEL };
	if guard {
		return Some((side, true));
	}
	if (n("npcFlags") as i64) & SERVICE_FLAGS != 0 {
		return Some((side, false));
	}
	None
}

#[derive(Clone, Copy, Debug)]
struct Pt {
	x: f64,
	y: f64,
	guard: bool,
}

/// Single-linkage clusters of points within r of each other, in first-member order.
fn clusters(points: &[Pt], r: f64) -> Vec<Vec<Pt>> {
	let mut parent: Vec<usize> = (0..points.len()).collect();
	fn find(p: &mut [usize], mut i: usize) -> usize {
		while p[i] != i {
			p[i] = p[p[i]];
			i = p[i];
		}
		i
	}
	let cell = |p: &Pt| ((p.x / r).floor() as i64, (p.y / r).floor() as i64);
	let mut cells: FxHashMap<(i64, i64), Vec<usize>> = FxHashMap::default();
	for (i, p) in points.iter().enumerate() {
		cells.entry(cell(p)).or_default().push(i);
	}
	for (i, p) in points.iter().enumerate() {
		let (gx, gy) = cell(p);
		for dx in -1..=1 {
			for dy in -1..=1 {
				for &j in cells.get(&(gx + dx, gy + dy)).map(Vec::as_slice).unwrap_or(&[]) {
					if j > i && js_hypot(p.x - points[j].x, p.y - points[j].y) <= r {
						let (a, b) = (find(&mut parent, i), find(&mut parent, j));
						parent[a] = b;
					}
				}
			}
		}
	}
	let mut out: Vec<Vec<Pt>> = Vec::new();
	let mut at: FxHashMap<usize, usize> = FxHashMap::default();
	for (i, p) in points.iter().enumerate() {
		let k = find(&mut parent, i);
		let g = *at.entry(k).or_insert_with(|| {
			out.push(Vec::new());
			out.len() - 1
		});
		out[g].push(*p);
	}
	out
}

fn near(a: &[Pt], b: &[Pt], r: f64) -> bool {
	a.iter().any(|p| b.iter().any(|q| js_hypot(p.x - q.x, p.y - q.y) <= r))
}

fn side_hubs(points: &[Pt]) -> Vec<Vec<Pt>> {
	let is_hub = |g: &Vec<Pt>| {
		let guards = g.iter().filter(|p| p.guard).count();
		guards >= MIN_GUARDS || g.len() - guards >= MIN_SERVICES
	};
	let mut hubs: Vec<Vec<Pt>> = clusters(points, LINK).into_iter().filter(is_hub).collect();
	loop {
		let mut changed = false;
		'outer: for a in 0..hubs.len() {
			for b in a + 1..hubs.len() {
				if near(&hubs[a], &hubs[b], JOIN) {
					let mv = hubs.remove(b);
					hubs[a].extend(mv);
					changed = true;
					break 'outer;
				}
			}
		}
		if !changed {
			break;
		}
	}
	hubs
}

struct Area {
	name: String,
	parent: u32,
	capital: bool,
}

/// String.prototype.localeCompare on names (ICU root collation, approximated for Latin text: letters
/// case-blind first, punctuation and spaces before digits and letters, then lowercase before uppercase).
pub fn locale_cmp(a: &str, b: &str) -> Ordering {
	const ORDER: &str = " _-,;:!?.'\"()[]{}@*/\\&#%`^+<=>|~$0123456789abcdefghijklmnopqrstuvwxyz";
	let fold = |c: char| -> char {
		let c = c.to_ascii_lowercase();
		match c {
			'à'..='å' | 'À'..='Å' => 'a',
			'è'..='ë' | 'È'..='Ë' => 'e',
			'ì'..='ï' | 'Ì'..='Ï' => 'i',
			'ò'..='ö' | 'Ò'..='Ö' => 'o',
			'ù'..='ü' | 'Ù'..='Ü' => 'u',
			'ñ' | 'Ñ' => 'n',
			'ç' | 'Ç' => 'c',
			_ => c,
		}
	};
	let w = |c: char| ORDER.find(fold(c)).unwrap_or(ORDER.len() + c as usize);
	a.chars().map(w).cmp(b.chars().map(w)).then_with(|| a.chars().map(|c| c.is_ascii_uppercase()).cmp(b.chars().map(|c| c.is_ascii_uppercase()))).then_with(|| a.cmp(b))
}

/// hubs.js slug.
fn slug(s: &str) -> String {
	let mut out = String::new();
	let mut dash = false;
	for c in s.chars() {
		let c = match c.to_lowercase().next().unwrap_or(c) {
			'à'..='å' => 'a',
			'è'..='ë' => 'e',
			'ì'..='ï' => 'i',
			'ò'..='ö' => 'o',
			'ù'..='ü' => 'u',
			'ñ' => 'n',
			'ç' => 'c',
			c => c,
		};
		if c == '\'' {
			continue;
		}
		if c.is_ascii_lowercase() || c.is_ascii_digit() {
			if dash && !out.is_empty() {
				out.push('-');
			}
			dash = false;
			out.push(c);
		} else {
			dash = true;
		}
	}
	if out.is_empty() {
		"x".into()
	} else {
		out
	}
}

fn tenth(v: f64) -> f64 {
	let r = js_round(v * 10.0) / 10.0;
	if r == 0.0 {
		0.0
	} else {
		r
	}
}

/// A JSON number as JS writes it (integral values without a fraction).
fn jnum(v: f64) -> Value {
	if v.fract() == 0.0 && v.abs() < 1e15 {
		json!(v as i64)
	} else {
		json!(v)
	}
}

/// What build_hubs reads.
pub struct HubsIn<'a> {
	/// spawnz.json's npc table: { entry: [[map, x, y, z], ...] }.
	pub spawns: &'a Value,
	/// creature_template.json: { entry: { name, faction, npcFlags, extraFlags, rank, minLevel } }.
	pub templates: &'a Value,
	pub faction_templates: &'a [FxHashMap<String, String>],
	pub area_table: &'a [FxHashMap<String, String>],
	/// The grid's chunk area at a point (0 none).
	pub area_at: &'a dyn Fn(u32, f64, f64) -> u32,
	/// The area id of the zone map around a point (0 none).
	pub zone_at: Option<&'a dyn Fn(u32, f64, f64) -> u32>,
	pub maps: &'a [u32],
}

/// hubs.js buildHubs -> per map its hubs (JSON, in hubs.json's shape).
pub fn build_hubs(i: &HubsIn) -> Result<Vec<(u32, Vec<Value>)>, String> {
	let h = Hostility::new(i.faction_templates)?;
	let mut areas: FxHashMap<u32, Area> = FxHashMap::default();
	for r in i.area_table {
		let name = r.get("AreaName_lang").map_or("undefined".to_string(), |s| s.trim().to_string());
		areas.insert(num(r, "ID") as u32, Area { name, parent: num(r, "ParentAreaID") as u32, capital: (num(r, "Flags_0") as i64) & AREA_CAPITAL != 0 });
	}
	let mut points: FxHashMap<u32, [Vec<Pt>; 2]> = i.maps.iter().map(|&c| (c, [Vec::new(), Vec::new()])).collect();
	let mut entries: Vec<(i64, &Value)> = i.spawns.as_object().into_iter().flatten().filter_map(|(k, v)| Some((k.parse().ok()?, v))).collect();
	entries.sort_by_key(|e| e.0);
	for (entry, list) in entries {
		let Some((side, guard)) = role_of(&i.templates[entry.to_string()], &h) else { continue };
		for s in list.as_array().into_iter().flatten() {
			let g = |k: usize| s[k].as_f64().unwrap_or(f64::NAN);
			if let Some(at) = points.get_mut(&(g(0) as u32)) {
				at[(side == "Horde") as usize].push(Pt { x: g(1), y: g(2), guard });
			}
		}
	}
	let mut out = Vec::new();
	for &c in i.maps {
		let mut hubs: Vec<(String, String, u32, usize, usize, Vec<[f64; 3]>)> = Vec::new();
		for (si, side) in ["Alliance", "Horde"].into_iter().enumerate() {
			for members in side_hubs(&points[&c][si]) {
				let (area_id, name) = name_of(c, &members, i, &areas);
				let guards = members.iter().filter(|p| p.guard).count();
				let mut seen = rustc_hash::FxHashSet::default();
				let mut disks: Vec<[f64; 3]> = Vec::new();
				for p in &members {
					let d = [tenth(p.x), tenth(p.y), if p.guard { GUARD_RADIUS } else { SERVICE_RADIUS }];
					if seen.insert((d[0].to_bits(), d[1].to_bits(), d[2].to_bits())) {
						disks.push(d);
					}
				}
				disks.sort_by(|a, b| a[0].partial_cmp(&b[0]).unwrap().then(a[1].partial_cmp(&b[1]).unwrap()).then(a[2].partial_cmp(&b[2]).unwrap()));
				hubs.push((side.to_string(), name, area_id, guards, members.len() - guards, disks));
			}
		}
		hubs.sort_by(|a, b| locale_cmp(&a.0, &b.0).then_with(|| locale_cmp(&a.1, &b.1)).then(a.5[0][0].partial_cmp(&b.5[0][0]).unwrap()).then(a.5[0][1].partial_cmp(&b.5[0][1]).unwrap()));
		let mut used: FxHashMap<String, usize> = FxHashMap::default();
		let list = hubs
			.into_iter()
			.map(|(side, name, area_id, guards, services, disks)| {
				let base = format!("{}-{}", slug(&side), slug(&name));
				let n = used.entry(base.clone()).or_default();
				*n += 1;
				let id = if *n == 1 { base } else { format!("{base}-{n}") };
				let mut m = Map::new();
				m.insert("id".into(), json!(id));
				m.insert("side".into(), json!(side));
				m.insert("name".into(), json!(name));
				m.insert("areaId".into(), json!(area_id));
				m.insert("guards".into(), json!(guards));
				m.insert("services".into(), json!(services));
				m.insert("disks".into(), Value::Array(disks.iter().map(|d| Value::Array(d.iter().map(|&v| jnum(v)).collect())).collect()));
				Value::Object(m)
			})
			.collect();
		out.push((c, list));
	}
	Ok(out)
}

fn name_of(c: u32, members: &[Pt], i: &HubsIn, areas: &FxHashMap<u32, Area>) -> (u32, String) {
	let n = members.len() as f64;
	let cx = members.iter().fold(0.0, |a, p| a + p.x) / n;
	let cy = members.iter().fold(0.0, |a, p| a + p.y) / n;
	let is_sub = |id: u32| areas.get(&id).is_some_and(|a| a.parent > 0);
	let capital_of = |id: u32| -> u32 {
		let mut cur = id;
		for _ in 0..8 {
			let Some(a) = areas.get(&cur) else { break };
			if a.capital {
				return cur;
			}
			cur = a.parent;
		}
		0
	};
	let most = |count: &[(u32, usize)]| -> Option<(u32, usize)> { count.iter().copied().min_by(|a, b| b.1.cmp(&a.1).then(a.0.cmp(&b.0))) };
	let bump = |v: &mut Vec<(u32, usize)>, k: u32| match v.iter_mut().find(|x| x.0 == k) {
		Some(x) => x.1 += 1,
		None => v.push((k, 1)),
	};
	let member_areas: Vec<u32> = members.iter().map(|p| (i.area_at)(c, p.x, p.y)).collect();
	let mut capitals = Vec::new();
	let mut subs = Vec::new();
	for (p, &a) in members.iter().zip(&member_areas) {
		let mut cap = capital_of(a);
		if cap == 0 {
			if let Some(z) = i.zone_at {
				cap = capital_of(z(c, p.x, p.y));
			}
		}
		if cap != 0 {
			bump(&mut capitals, cap);
		}
		if is_sub(a) {
			bump(&mut subs, a);
		}
	}
	let mut id = match most(&capitals) {
		Some((k, cnt)) if cnt * 2 >= members.len() => k,
		_ => 0,
	};
	if id == 0 {
		id = (i.area_at)(c, cx, cy);
		if !is_sub(id) {
			let m = most(&subs).map_or(0, |x| x.0);
			id = if m != 0 {
				m
			} else if areas.contains_key(&id) {
				id
			} else {
				member_areas.iter().copied().find(|a| areas.contains_key(a)).unwrap_or(0)
			};
		}
	}
	let name = match areas.get(&id) {
		Some(a) => a.name.clone(),
		None => format!("map {c} ({}, {})", forge_core::jsnum::js_to_string(js_round(cx)), forge_core::jsnum::js_to_string(js_round(cy))),
	};
	(id, name)
}

/// The rules build_hubs applies, for hubs.json.
pub fn rules() -> Value {
	let names = GUARD_NAMES.join("|");
	json!({
		"guard": format!("one side's (hostile to the other side's players only) with ExtraFlags & 0x{EXTRA_GUARD:x} and MinLevel >= {MIN_GUARD_LEVEL}, or named /\\b({names})\\b/ and MinLevel >= {MIN_NAMED_GUARD_LEVEL}"),
		"service": format!("one side's, not a guard, NpcFlags & 0x{SERVICE_FLAGS:x} (quest giver, vendor, flight master, trainer, innkeeper, banker, repair)"),
		"hub": format!("single linkage at {LINK} yd; a cluster with >= {MIN_GUARDS} guard or >= {MIN_SERVICES} service NPCs is a hub; hubs of one side within {JOIN} yd are listed as one (a naming merge: their disks unchanged, none added)"),
		"name": "AreaTable: the capital (Flags_0 & 0x100) at least half the spawns stand in (chunk area or zone map), else the subzone under the centroid, else the most common subzone, else the zone",
		"disks": format!("{GUARD_RADIUS} yd around a guard, {SERVICE_RADIUS} yd around a service NPC"),
	})
}

/// hubs.json: the maps' hubs (integer keys first, as JSON.stringify orders them), build, rev, maps, rules.
pub fn hubs_doc(hubs: &[(u32, Vec<Value>)], build: &str, rev: &str, maps: &[u32]) -> String {
	let mut m = Map::new();
	let mut sorted: Vec<&(u32, Vec<Value>)> = hubs.iter().collect();
	sorted.sort_by_key(|h| h.0);
	for (c, list) in sorted {
		m.insert(c.to_string(), Value::Array(list.clone()));
	}
	m.insert("build".into(), json!(build));
	m.insert("rev".into(), json!(rev));
	m.insert("maps".into(), json!(maps));
	m.insert("rules".into(), rules());
	format!("{}\n", Value::Object(m))
}
