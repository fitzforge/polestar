//! Port of tools/lib/sim/solo.js.
//! The compiler's part of the solo filter (docs/SIMULATION.md §1 "Solo filter"): the categories, the
//! instance tables of the Forever client (Map.csv, AreaTable.csv, UiMapAssignment.csv) and the instance
//! rule for one quest. The world builder's overrides and quest-area loader are not part of the compiler.

use crate::js::{num_str, V};
use crate::obj;

pub const CATEGORIES: &[&str] = &["dungeon", "raid", "pvp", "elite", "rareDrop", "reputation", "repeatable"];
pub const FRIENDLY: f64 = 3000.0;
pub const HIGH_DROPPER: f64 = 5.0;
pub const MIN_DROP: f64 = 1.0;

/// Newest cached Forever client build (1.6x) with Map.csv and AreaTable.csv.
#[cfg(feature = "native")]
pub fn forever_build(sources_dir: &std::path::Path) -> Option<std::path::PathBuf> {
	let root = sources_dir.join("wago");
	let rd = std::fs::read_dir(&root).ok()?;
	let mut ok: Vec<String> = rd
		.filter_map(|e| e.ok().map(|e| e.file_name().to_string_lossy().into_owned()))
		.filter(|b| crate::areas::is_forever_family(b) && ["Map.csv", "AreaTable.csv"].iter().all(|f| root.join(b).join(f).exists()))
		.collect();
	ok.sort_by(|a, b| {
		let pa: Vec<f64> = a.split('.').map(crate::js::str_to_num).collect();
		let pb: Vec<f64> = b.split('.').map(crate::js::str_to_num).collect();
		let or0 = |v: &Vec<f64>, i: usize| v.get(i).copied().filter(|x| *x != 0.0 && !x.is_nan()).unwrap_or(0.0);
		for i in 0..4 {
			if or0(&pa, i) != or0(&pb, i) {
				return (or0(&pa, i) - or0(&pb, i)).partial_cmp(&0.0).unwrap();
			}
		}
		std::cmp::Ordering::Equal
	});
	ok.pop().map(|b| root.join(b))
}

fn kind_of(instance_type: &V) -> Option<&'static str> {
	match num_str(instance_type.num()).as_str() {
		"1" => Some("dungeon"),
		"2" => Some("raid"),
		"3" => Some("pvp"),
		_ => None,
	}
}

fn or0(v: &V) -> f64 {
	let n = v.num();
	if n != 0.0 && !n.is_nan() {
		n
	} else {
		0.0
	}
}

/// Instance maps of Map.csv rows, in Map insertion order: (map id, { kind, name, area, map }).
fn instance_maps(map_rows: &[V]) -> Vec<(f64, V)> {
	let mut maps: Vec<(f64, V)> = Vec::new();
	for m in map_rows {
		if let Some(k) = kind_of(&m.get("InstanceType")) {
			let id = m.get("ID").num();
			let rec: V = obj! { "kind" => k, "name" => m.get("MapName_lang"), "area" => or0(&m.get("AreaTableID")), "map" => id }.into();
			match maps.iter_mut().find(|(i, _)| *i == id || (i.is_nan() && id.is_nan())) {
				Some(e) => e.1 = rec,
				None => maps.push((id, rec)),
			}
		}
	}
	maps
}

fn map_get(maps: &[(f64, V)], id: f64) -> V {
	maps.iter().find(|(i, _)| *i == id || (i.is_nan() && id.is_nan())).map(|(_, v)| v.clone()).unwrap_or(V::Null)
}

fn inst(m: &V) -> V {
	obj! { "kind" => m.get("kind"), "name" => m.get("name"), "map" => m.get("map") }.into()
}

/// AreaTable ids inside instances -> { kind, name, map }.
pub fn instances_by_area(map_rows: &[V], area_rows: &[V]) -> V {
	let maps = instance_maps(map_rows);
	let mut by_name: Vec<(V, V)> = Vec::new();
	for (_, m) in &maps {
		let n = m.get("name");
		match by_name.iter_mut().find(|(k, _)| k.strict_eq(&n)) {
			Some(e) => e.1 = m.clone(),
			None => by_name.push((n, m.clone())),
		}
	}
	let out = V::obj();
	for (_, m) in &maps {
		if m.get("area").truthy() {
			out.set(&m.get("area").to_js_string(), inst(m));
		}
	}
	for a in area_rows {
		let id = a.get("ID").num();
		let mut m = map_get(&maps, a.get("ContinentID").num());
		if !m.truthy() {
			m = if or0(&a.get("ParentAreaID")) != 0.0 {
				let n = a.get("AreaName_lang");
				by_name.iter().find(|(k, _)| k.strict_eq(&n)).map(|(_, v)| v.clone()).unwrap_or(V::Undef)
			} else {
				V::Null
			};
		}
		if m.truthy() {
			out.set(&num_str(id), inst(&m));
		}
	}
	out
}

/// AreaTable ids inside instances -> 'dungeon' | 'raid' | 'pvp'.
pub fn instance_areas(map_rows: &[V], area_rows: &[V]) -> V {
	let out = V::obj();
	for (id, i) in instances_by_area(map_rows, area_rows).entries() {
		out.set(&id, i.get("kind"));
	}
	out
}

/// UiMap ids drawn only on instance maps (UiMapAssignment.csv) -> { kind, name, map }.
pub fn instances_by_ui_map(map_rows: &[V], assignment_rows: &[V]) -> V {
	let maps = instance_maps(map_rows);
	let mut seen: Vec<(f64, V)> = Vec::new();
	for a in assignment_rows {
		let ui = a.get("UiMapID").num();
		let m = map_get(&maps, a.get("MapID").num());
		match seen.iter_mut().find(|(i, _)| *i == ui || (i.is_nan() && ui.is_nan())) {
			None => seen.push((ui, m)),
			Some(e) => {
				if !e.1.strict_eq(&m) {
					e.1 = V::Null;
				}
			}
		}
	}
	let out = V::obj();
	for (ui, m) in &seen {
		if m.truthy() {
			out.set(&num_str(*ui), inst(m));
		}
	}
	out
}

/// `loadInstances(sourcesDir)` (native): { build, areas, maps } or Null when no Forever build is cached.
/// Panics like the JS throws on an unreadable or malformed table.
#[cfg(feature = "native")]
pub fn load_instances(sources_dir: &std::path::Path) -> V {
	let Some(dir) = forever_build(sources_dir) else { return V::Null };
	let read = |f: &str| -> Vec<V> {
		let file = dir.join(f);
		let text = std::fs::read_to_string(&file).unwrap_or_else(|e| panic!("{}: {e}", file.display()));
		crate::areas::parse_csv(&text).unwrap_or_else(|e| panic!("{e}"))
	};
	let maps = read("Map.csv");
	let assignments = if dir.join("UiMapAssignment.csv").exists() { read("UiMapAssignment.csv") } else { Vec::new() };
	let build = dir.file_name().map(|b| b.to_string_lossy().into_owned()).unwrap_or_default();
	obj! { "build" => build, "areas" => instances_by_area(&maps, &read("AreaTable.csv")), "maps" => instances_by_ui_map(&maps, &assignments) }.into()
}

/// The solo filter's instance rule for one quest: -> { kind, name, map } | Null. `placed(kind, id)` tells
/// whether an npc, object or item has an open-world spawn.
pub fn instance_quest(quest: &V, areas: &V, placed: &dyn Fn(&str, &V) -> bool) -> V {
	if !quest.truthy() || !areas.truthy() {
		return V::Null;
	}
	let inst = areas.get(&quest.get("area").to_js_string());
	if !inst.truthy() {
		return V::Null;
	}
	let any_placed = |ends: &V| ["npc", "object"].iter().any(|kind| ends.get(kind).items().iter().any(|id| placed(kind, id)));
	if !any_placed(&quest.get("start")) || !any_placed(&quest.get("end")) {
		return inst;
	}
	for o in quest.get("objectives").items() {
		if !o.truthy() {
			continue;
		}
		let t = o.get("type");
		let kind = if t.as_str() == Some("kill") { "npc".to_string() } else { t.to_js_string() };
		if if kind == "event" { o.get("map").is_nullish() } else { !placed(&kind, &o.get("id")) } {
			return inst;
		}
	}
	V::Null
}
