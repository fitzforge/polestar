//! Map tables (UiMap, UiMapAssignment, AreaTable rows) -> zones.json, map frames and an
//! AreaTable-ID -> UiMapID resolver (port of tools/lib/data/maps.js).

use std::cell::RefCell;

use forge_guide::js::{to_fixed, Obj, V};
use indexmap::IndexMap;
use rustc_hash::FxHashMap;

use crate::jsv::{col_num, col_str, math_round, Row};

const ASPECT_MIN: f64 = 1.3;
const ASPECT_MAX: f64 = 1.7;

fn num(r: &Row, c: &str) -> f64 {
	let n = col_num(r, c);
	if n.is_finite() {
		n
	} else {
		0.0
	}
}

fn round3(v: f64) -> f64 {
	math_round(v * 1000.0) / 1000.0
}

#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Frame {
	pub c: f64,
	pub left: f64,
	pub right: f64,
	pub top: f64,
	pub bottom: f64,
}

impl Frame {
	pub fn to_v(&self) -> V {
		let o = Obj::new();
		o.set("c", self.c);
		o.set("left", self.left);
		o.set("right", self.right);
		o.set("top", self.top);
		o.set("bottom", self.bottom);
		V::Obj(o)
	}
}

pub fn frame_from_assignment(a: &Row) -> Option<Frame> {
	let (min_x, min_y, max_x, max_y) = (num(a, "Region_0"), num(a, "Region_1"), num(a, "Region_3"), num(a, "Region_4"));
	let (u0, v0, u1, v1) = (num(a, "UiMin_0"), num(a, "UiMin_1"), num(a, "UiMax_0"), num(a, "UiMax_1"));
	let du = u1 - u0;
	let dv = v1 - v0;
	if !(du > 0.0) || !(dv > 0.0) {
		return None;
	}
	let wy_at = |u: f64| max_y + ((u - u0) * (min_y - max_y)) / du;
	let wx_at = |v: f64| max_x + ((v - v0) * (min_x - max_x)) / dv;
	Some(Frame { c: num(a, "MapID"), left: round3(wy_at(0.0)), right: round3(wy_at(1.0)), top: round3(wx_at(0.0)), bottom: round3(wx_at(1.0)) })
}

fn ui_area(a: &Row) -> f64 {
	(num(a, "UiMax_0") - num(a, "UiMin_0")) * (num(a, "UiMax_1") - num(a, "UiMin_1"))
}

fn compare_assignments(a: &Row, b: &Row) -> std::cmp::Ordering {
	let d = ui_area(b) - ui_area(a);
	let d = if d != 0.0 && !d.is_nan() { d } else { num(a, "OrderIndex") - num(b, "OrderIndex") };
	let d = if d != 0.0 && !d.is_nan() { d } else { num(a, "ID") - num(b, "ID") };
	d.partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal)
}

fn frame_check(id: i64, f: &Frame, full: bool) -> Vec<String> {
	let mut p = Vec::new();
	let width = f.left - f.right;
	let height = f.top - f.bottom;
	if !(width > 0.0) {
		p.push("left <= right (expected west edge to have larger world y)".to_string());
	}
	if !(height > 0.0) {
		p.push("top <= bottom (expected north edge to have larger world x)".to_string());
	}
	if width > 0.0 && height > 0.0 {
		if !(50.0..=60000.0).contains(&width) || !(30.0..=60000.0).contains(&height) {
			p.push(format!("implausible size {} x {} yd", to_fixed(width, 1), to_fixed(height, 1)));
		}
		let aspect = width / height;
		if full && !(ASPECT_MIN..=ASPECT_MAX).contains(&aspect) {
			p.push(format!("aspect {} outside {ASPECT_MIN}-{ASPECT_MAX}", to_fixed(aspect, 3)));
		}
	}
	p.into_iter().map(|s| format!("uiMap {id}: {s}")).collect()
}

pub struct Zone {
	pub id: i64,
	pub name: String,
	pub area_id: Option<i64>,
	pub parent: Option<i64>,
	pub kind: f64,
	pub system: Option<f64>,
}

impl Zone {
	pub fn to_v(&self) -> V {
		let o = Obj::new();
		o.set("id", self.id as f64);
		o.set("name", self.name.as_str());
		o.set("areaId", self.area_id.map(|x| V::Num(x as f64)).unwrap_or(V::Null));
		o.set("parent", self.parent.map(|x| V::Num(x as f64)).unwrap_or(V::Null));
		o.set("type", self.kind);
		if let Some(s) = self.system {
			o.set("system", s);
		}
		V::Obj(o)
	}
}

pub struct Maps {
	/// Ascending UiMapID.
	pub zones: Vec<Zone>,
	/// Ascending UiMapID.
	pub frames: IndexMap<i64, Frame>,
	pub area_names: FxHashMap<i64, String>,
	pub warnings: Vec<String>,
	direct: FxHashMap<i64, i64>,
	parent_area: FxHashMap<i64, i64>,
	memo: RefCell<FxHashMap<i64, Option<i64>>>,
}

impl Maps {
	/// AreaTable ID -> UiMapID: a direct assignment, else the parent area's.
	pub fn resolve_area(&self, area: f64) -> Option<i64> {
		let start = if area.is_finite() { area } else { 0.0 };
		let key = start as i64;
		if start.fract() != 0.0 {
			return None;
		}
		if let Some(r) = self.memo.borrow().get(&key) {
			return *r;
		}
		let mut cur = key;
		let mut result = None;
		let mut seen = rustc_hash::FxHashSet::default();
		while cur > 0 && seen.insert(cur) {
			if let Some(&m) = self.direct.get(&cur) {
				result = Some(m);
				break;
			}
			cur = self.parent_area.get(&cur).copied().unwrap_or(0);
		}
		self.memo.borrow_mut().insert(key, result);
		result
	}

	pub fn zones_obj(&self) -> Obj {
		let o = Obj::new();
		for z in &self.zones {
			o.set(&z.id.to_string(), z.to_v());
		}
		o
	}

	pub fn frames_v(&self) -> V {
		let o = Obj::new();
		for (id, f) in &self.frames {
			o.set(&id.to_string(), f.to_v());
		}
		V::Obj(o)
	}
}

pub fn build_maps(ui_map: &[Row], assignment: &[Row], area: &[Row]) -> Maps {
	let mut warnings = Vec::new();
	let mut maps: IndexMap<i64, &Row> = IndexMap::new();
	for row in ui_map {
		let id = num(row, "ID");
		if id > 0.0 {
			maps.insert(id as i64, row);
		}
	}
	let mut by_map: IndexMap<i64, Vec<&Row>> = IndexMap::new();
	for a in assignment {
		let id = num(a, "UiMapID") as i64;
		if !maps.contains_key(&id) {
			continue;
		}
		by_map.entry(id).or_default().push(a);
	}
	let mut ids: Vec<i64> = by_map.keys().copied().collect();
	ids.sort();
	let mut frames = IndexMap::new();
	let mut area_of: FxHashMap<i64, i64> = FxHashMap::default();
	let sorted_list = |id: i64| {
		let mut l = by_map[&id].clone();
		l.sort_by(|a, b| compare_assignments(a, b));
		l
	};
	for &id in &ids {
		let list = sorted_list(id);
		if let Some(a0) = list.iter().find(|a| num(a, "AreaID") > 0.0) {
			area_of.insert(id, num(a0, "AreaID") as i64);
		}
		let mut continents: Vec<i64> = Vec::new();
		for a in &list {
			let c = num(a, "MapID") as i64;
			if !continents.contains(&c) {
				continents.push(c);
			}
		}
		if continents.len() > 1 {
			continents.sort();
			let cs: Vec<String> = continents.iter().map(i64::to_string).collect();
			warnings.push(format!("uiMap {id}: spans {} continents ({}); no single Era frame", continents.len(), cs.join(", ")));
			continue;
		}
		let Some(best) = frame_from_assignment(list[0]) else {
			warnings.push(format!("uiMap {id}: degenerate UiMin/UiMax"));
			continue;
		};
		for other in &list[1..] {
			let Some(f) = frame_from_assignment(other) else { continue };
			let d = (f.left - best.left).abs().max((f.right - best.right).abs()).max((f.top - best.top).abs()).max((f.bottom - best.bottom).abs());
			if d > 1.0 {
				warnings.push(format!("uiMap {id}: assignment {} disagrees with {} by {} yd", col_str(other, "ID"), col_str(list[0], "ID"), to_fixed(d, 1)));
			}
		}
		let problems = frame_check(id, &best, ui_area(list[0]) > 0.999 && num(maps[&id], "System") == 0.0);
		if !problems.is_empty() {
			warnings.extend(problems);
			continue;
		}
		frames.insert(id, best);
	}

	let mut zone_ids: Vec<i64> = maps.keys().copied().collect();
	zone_ids.sort();
	let zones: Vec<Zone> = zone_ids
		.iter()
		.map(|&id| {
			let row = maps[&id];
			let parent = num(row, "ParentUiMapID");
			let system = num(row, "System");
			Zone {
				id,
				name: col_str(row, "Name_lang").to_string(),
				area_id: area_of.get(&id).copied().filter(|&a| a != 0),
				parent: (parent > 0.0).then_some(parent as i64),
				kind: num(row, "Type"),
				system: (system != 0.0).then_some(system),
			}
		})
		.collect();
	let kind_of: FxHashMap<i64, f64> = zones.iter().map(|z| (z.id, z.kind)).collect();

	let mut direct = FxHashMap::default();
	for &id in &ids {
		if kind_of[&id] < 3.0 {
			continue;
		}
		for a in sorted_list(id) {
			let aid = num(a, "AreaID");
			if aid > 0.0 {
				direct.entry(aid as i64).or_insert(id);
			}
		}
	}
	let mut parent_area = FxHashMap::default();
	let mut area_names = FxHashMap::default();
	for row in area {
		let aid = num(row, "ID") as i64;
		parent_area.insert(aid, num(row, "ParentAreaID") as i64);
		let n = col_str(row, "AreaName_lang");
		area_names.insert(aid, if n.is_empty() { col_str(row, "ZoneName").to_string() } else { n.to_string() });
	}
	Maps { zones, frames, area_names, warnings, direct, parent_area, memo: RefCell::new(FxHashMap::default()) }
}
