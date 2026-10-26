//! Solo feasibility (port of tools/lib/sim/solo.js): categories, thresholds, the explicit
//! overrides (data: solo-overrides.json) and the client's instance areas (Map.csv +
//! AreaTable.csv). The world builder applies the rules while it places each quest.

use crate::data::{Kind, Quest};
use rustc_hash::FxHashMap;
use serde_json::Value;
use std::collections::BTreeMap;

pub const CATEGORIES: [&str; 7] = ["dungeon", "raid", "pvp", "elite", "rareDrop", "reputation", "repeatable"];
/// Reputation points; more needs grinding a faction.
pub const FRIENDLY: f64 = 3000.0;
/// A dropper this many levels above the quest is not soloed.
pub const HIGH_DROPPER: f64 = 5.0;
/// % below which a dropper is not a source.
pub const MIN_DROP: f64 = 1.0;

#[derive(Clone, Debug)]
pub struct Listed {
	pub category: Option<String>,
	pub reason: String,
}

/// solo.js compileOverrides.
#[derive(Clone, Debug, Default)]
pub struct Overrides {
	pub exclude: FxHashMap<u32, Listed>,
	pub allow: FxHashMap<u32, String>,
	pub turnin_after: BTreeMap<u32, Vec<u32>>,
	pub start_item_from: BTreeMap<u32, u32>,
}

pub const OVERRIDES_JSON: &str = include_str!("solo-overrides.json");

impl Overrides {
	/// The shipped overrides.
	pub fn shipped() -> Overrides {
		Overrides::from_json(OVERRIDES_JSON).expect("solo-overrides.json")
	}

	/// ids: numbers or [first, last] ranges.
	pub fn from_json(text: &str) -> Result<Overrides, String> {
		let doc: Value = serde_json::from_str(text).map_err(|e| e.to_string())?;
		let ids = |v: &Value| -> Vec<u32> {
			let mut out = Vec::new();
			for x in v.as_array().into_iter().flatten() {
				match x {
					Value::Array(r) if r.len() == 2 => {
						let (a, b) = (r[0].as_u64().unwrap_or(0) as u32, r[1].as_u64().unwrap_or(0) as u32);
						out.extend(a..=b);
					}
					_ => out.extend(x.as_u64().map(|n| n as u32)),
				}
			}
			out
		};
		let mut o = Overrides::default();
		for e in doc["exclude"].as_array().into_iter().flatten() {
			for id in ids(&e["ids"]) {
				o.exclude.insert(id, Listed { category: e["category"].as_str().map(String::from), reason: e["reason"].as_str().unwrap_or("").into() });
			}
		}
		for e in doc["allow"].as_array().into_iter().flatten() {
			for id in ids(&e["ids"]) {
				o.allow.insert(id, e["reason"].as_str().unwrap_or("").into());
			}
		}
		for (k, v) in doc["turninAfter"].as_object().into_iter().flatten() {
			o.turnin_after.insert(k.parse().map_err(|_| format!("turninAfter key {k}"))?, ids(v));
		}
		for (k, v) in doc["startItemFrom"].as_object().into_iter().flatten() {
			o.start_item_from.insert(k.parse().map_err(|_| format!("startItemFrom key {k}"))?, v.as_u64().unwrap_or(0) as u32);
		}
		Ok(o)
	}
}

/// Instance areas of the client: AreaTable id -> 'dungeon' | 'raid' | 'pvp'.
#[derive(Clone, Debug, Default)]
pub struct InstanceAreas {
	/// The client build read ("1.60.1.70450").
	pub build: String,
	pub areas: FxHashMap<u32, &'static str>,
}

fn kind_of(t: &str) -> Option<&'static str> {
	match t.trim().parse::<f64>().ok()? as i64 {
		1 => Some("dungeon"),
		2 => Some("raid"),
		3 => Some("pvp"),
		_ => None,
	}
}

fn n(s: Option<&String>) -> f64 {
	crate::json::num(s.map(|x| Value::String(x.clone())).as_ref())
}

/// Instance info by AreaTable id: kind, instance name and its Map.csv id (solo.js instancesByArea).
pub fn instances_by_area(maps: &[FxHashMap<String, String>], areas: &[FxHashMap<String, String>]) -> FxHashMap<u32, (&'static str, String, u32)> {
	// map id -> (kind, name, area, map), in Map.csv row order (later rows win, as Map.set).
	let mut by_id: FxHashMap<u32, (&'static str, String, u32, u32)> = FxHashMap::default();
	let mut order: Vec<u32> = Vec::new();
	for m in maps {
		let Some(k) = m.get("InstanceType").and_then(|t| kind_of(t)) else { continue };
		let id = n(m.get("ID")) as u32;
		let area = n(m.get("AreaTableID"));
		let area = if area.is_nan() { 0 } else { area as u32 };
		if !by_id.contains_key(&id) {
			order.push(id);
		}
		by_id.insert(id, (k, m.get("MapName_lang").cloned().unwrap_or_default(), area, id));
	}
	let mut by_name: FxHashMap<String, u32> = FxHashMap::default();
	for id in &order {
		by_name.insert(by_id[id].1.clone(), *id);
	}
	let mut out = FxHashMap::default();
	for id in &order {
		let m = &by_id[id];
		if m.2 != 0 {
			out.insert(m.2, (m.0, m.1.clone(), m.3));
		}
	}
	for a in areas {
		let id = n(a.get("ID")) as u32;
		let cont = n(a.get("ContinentID"));
		let parent = n(a.get("ParentAreaID"));
		let m = by_id.get(&(cont as u32)).filter(|_| cont.is_finite() && cont >= 0.0).or_else(|| {
			if parent.is_finite() && parent != 0.0 {
				a.get("AreaName_lang").and_then(|nm| by_name.get(nm)).map(|i| &by_id[i])
			} else {
				None
			}
		});
		if let Some(m) = m {
			out.insert(id, (m.0, m.1.clone(), m.3));
		}
	}
	out
}

/// AreaTable ids inside instances -> kind (solo.js instanceAreas).
pub fn instance_areas(maps: &[FxHashMap<String, String>], areas: &[FxHashMap<String, String>]) -> FxHashMap<u32, &'static str> {
	instances_by_area(maps, areas).into_iter().map(|(k, v)| (k, v.0)).collect()
}

/// The solo filter's instance rule for one quest (solo.js instanceQuest): its area lies in an
/// instance and its giver, ender or an objective has no open-world place.
/// `placed(kind, id)`: does an npc/object (or item: Kind None) have an open-world spawn.
pub fn instance_quest(quest: &Quest, areas: &FxHashMap<u32, &'static str>, placed: &dyn Fn(Option<Kind>, i64) -> bool) -> Option<&'static str> {
	let area = quest.area?;
	let inst = *areas.get(&(area as u32)).filter(|_| area.fract() == 0.0 && area >= 0.0)?;
	let any_placed = |ends: &crate::data::Ends| Kind::BOTH.iter().any(|&k| ends.of(k).iter().any(|&id| placed(Some(k), id)));
	if !any_placed(&quest.start) || !any_placed(&quest.end) {
		return Some(inst);
	}
	for o in quest.objectives.iter().flatten() {
		let id = o.id.map(|x| x as i64).unwrap_or(-1);
		let ok = match o.kind.as_str() {
			"kill" => placed(Some(Kind::Npc), id),
			"object" => placed(Some(Kind::Object), id),
			"event" => o.map.is_some(),
			_ => placed(None, id),
		};
		if !ok {
			return Some(inst);
		}
	}
	None
}
