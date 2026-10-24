//! RareScanner (All Rights Reserved), a Codex `--local-extras` input (port of
//! the JS importer it replaced): rare NPCs, treasures and what they drop, and which mounts and
//! pets come from a drop, from the installed addon's data tables. Facts only: ids, map ids,
//! coordinates, item ids; names are never read (the Codex names NPCs from its other inputs).
//!
//! Output (JS shapes):
//!   meta      { source, version, licence, files, warnings }
//!   rares     [{ npc, name, map, x, y, points, loot }]  one row per map an NPC is placed on
//!   treasures [{ object, name, map, x, y, points, loot }]
//!   mounts    { "<mountId>": [itemIds] }
//!   pets      { "<speciesId>": [itemIds] }

use std::path::Path;

use forge_guide::js::{Obj, V};
use indexmap::IndexMap;

use crate::gear::addonlua::{addon_version, read_addon_lua};
use crate::jsv::arr;

const ADDON: &str = "RareScanner";
const FILES: [&str; 6] = ["Tables/NpcInfoTables.lua", "Tables/NpcLootTables.lua", "Tables/ContainerInfoTables.lua", "Tables/ContainerLootTables.lua", "Tables/Mounts.lua", "Tables/Pets.lua"];
const EXPR: &str = include_str!("rarescanner.lua");

fn list(v: &V) -> Vec<V> {
	if v.is_arr() {
		v.items()
	} else {
		Vec::new()
	}
}

/// One coordinate -> 0-100 (two decimals), or None. `s`: the value as a string when it was one.
fn coord_of(n: f64, from_string: Option<&str>) -> Option<f64> {
	if !n.is_finite() || n < 0.0 {
		return None;
	}
	let n = match from_string {
		Some(s) if s.contains('.') => {
			if n <= 1.0 {
				n * 100.0
			} else {
				n
			}
		}
		_ => {
			if n <= 1.0 {
				n * 100.0
			} else {
				n / 100.0
			}
		}
	};
	(n <= 100.0).then(|| crate::jsv::math_round(n * 100.0) / 100.0)
}

/// The JS importer's `coord(v)`.
pub fn coord(v: &V) -> Option<f64> {
	match v {
		V::Num(n) => coord_of(*n, None),
		_ => {
			let s = v.as_str()?;
			coord_of(forge_guide::js::str_to_num(s), Some(s))
		}
	}
}

/// "4100-4940" / "41004940" -> [41, 49.4]
pub fn point(v: &V) -> Option<(f64, f64)> {
	let s = v.as_str()?;
	let dash = regex::Regex::new(r"^\s*([0-9.]+)\s*-\s*([0-9.]+)\s*$").unwrap();
	let joined = regex::Regex::new(r"^([0-9]{4})([0-9]{4})$").unwrap();
	let (a, b) = match dash.captures(s) {
		Some(m) => (m[1].to_string(), m[2].to_string()),
		None => {
			let m = joined.captures(forge_guide::lexer::js_trim(s))?;
			(m[1].to_string(), m[2].to_string())
		}
	};
	let one = |t: &str| if t.contains('.') { coord(&V::str(t)) } else { coord(&V::Num(forge_guide::js::str_to_num(t))) };
	Some((one(&a)?, one(&b)?))
}

fn ids(v: &V) -> Vec<V> {
	list(v).into_iter().filter(|n| n.as_num().is_some_and(|x| x > 0.0)).collect()
}

fn loot_map(pairs: &V) -> IndexMap<String, (V, Vec<V>)> {
	let mut m = IndexMap::new();
	for p in list(pairs) {
		m.insert(p.at(0).to_js_string(), (p.at(0), ids(&p.at(1))));
	}
	m
}

fn placed_rows(records: &V, loot: &IndexMap<String, (V, Vec<V>)>, id_key: &str) -> Vec<V> {
	let mut out = Vec::new();
	let mut seen: Vec<String> = Vec::new();
	let row = |id: V, map: V, x: V, y: V, points: Vec<V>, items: Vec<V>| {
		let o = Obj::new();
		o.set(id_key, id);
		o.set("name", V::Null);
		o.set("map", map);
		o.set("x", x);
		o.set("y", y);
		o.set("points", arr(points));
		o.set("loot", arr(items));
		V::Obj(o)
	};
	for rec in list(records) {
		let id = rec.get("id");
		seen.push(id.to_js_string());
		let items = loot.get(&id.to_js_string()).map(|l| l.1.clone()).unwrap_or_default();
		let mut zones = list(&rec.get("zones"));
		if zones.is_empty() {
			zones.push(V::obj());
		}
		for z in zones {
			let map = z.get("map").as_num().filter(|m| *m > 0.0);
			let points: Vec<(f64, f64)> = list(&z.get("overlay")).iter().filter_map(point).collect();
			let mut x = map.and(coord(&z.get("x")));
			let mut y = map.and(coord(&z.get("y")));
			if map.is_some() && (x.is_none() || y.is_none()) {
				if let Some(p) = points.first() {
					(x, y) = (Some(p.0), Some(p.1));
				}
			}
			let pts = if map.is_some() { points.iter().map(|p| arr(vec![V::Num(p.0), V::Num(p.1)])).collect() } else { Vec::new() };
			let opt = |n: Option<f64>| n.map(V::Num).unwrap_or(V::Null);
			out.push(row(id.clone(), opt(map), opt(x), opt(y), pts, items.clone()));
		}
	}
	// Loot without a placement record still names a source.
	for (k, (id, items)) in loot {
		if !seen.contains(k) {
			out.push(row(id.clone(), V::Null, V::Null, V::Null, Vec::new(), items.clone()));
		}
	}
	out
}

fn id_lists(pairs: &V) -> Obj {
	let out = Obj::new();
	for p in list(pairs) {
		out.set(&p.at(0).to_js_string(), arr(ids(&p.at(1))));
	}
	out
}

/// readRareScanner(dir): the AddOns folder holding RareScanner.
pub fn read_rarescanner(dir: &Path) -> Result<V, String> {
	let meta = Obj::new();
	meta.set("source", ADDON);
	meta.set("version", V::Null);
	meta.set("licence", "All Rights Reserved");
	meta.set("files", V::arr());
	let mut warnings: Vec<String> = Vec::new();
	let out = Obj::new();
	out.set("meta", V::Obj(meta.clone()));
	out.set("rares", V::arr());
	out.set("treasures", V::arr());
	out.set("mounts", V::obj());
	out.set("pets", V::obj());
	let addon_dir = dir.join(ADDON);
	let done = |warnings: &[String]| meta.set("warnings", arr(warnings.iter().map(|w| V::str(w)).collect()));
	if !addon_dir.exists() {
		warnings.push(format!("{ADDON} not installed in {}", dir.display()));
		done(&warnings);
		return Ok(V::Obj(out));
	}
	meta.set("version", addon_version(&addon_dir).map(|v| V::str(&v)).unwrap_or(V::Null));
	let mut files = Vec::new();
	for f in FILES {
		let p = addon_dir.join(f);
		if p.exists() {
			files.push(p);
		} else {
			warnings.push(format!("{ADDON}/{f} missing"));
		}
	}
	meta.set("files", arr(files.iter().map(|f| V::str(&f.strip_prefix(dir).unwrap_or(f).to_string_lossy().replace('\\', "/"))).collect()));
	done(&warnings);
	if files.is_empty() {
		return Ok(V::Obj(out));
	}
	let res = read_addon_lua(&files, ADDON, "", EXPR)?;
	out.set("rares", arr(placed_rows(&res.get("npcs"), &loot_map(&res.get("npcLoot")), "npc")));
	out.set("treasures", arr(placed_rows(&res.get("containers"), &loot_map(&res.get("containerLoot")), "object")));
	out.set("mounts", V::Obj(id_lists(&res.get("mounts"))));
	out.set("pets", V::Obj(id_lists(&res.get("pets"))));
	Ok(V::Obj(out))
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn coordinates_and_points() {
		assert_eq!(coord(&V::Num(4100.0)), Some(41.0));
		assert_eq!(coord(&V::Num(0.415)), Some(41.5));
		assert_eq!(coord(&V::str("41.5")), Some(41.5));
		assert_eq!(coord(&V::Num(20000.0)), None);
		assert_eq!(point(&V::str("4100-4940")), Some((41.0, 49.4)));
		assert_eq!(point(&V::str("41004940")), Some((41.0, 49.4)));
		assert_eq!(point(&V::str("x")), None);
	}
}
