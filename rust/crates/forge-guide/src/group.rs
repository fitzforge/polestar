//! Port of tools/lib/dsl/group.js.
//! Group content (docs/GUIDE_FORMAT.md, "Group content"): the compiled `group` of a goal.
//! `sides` is a JS array of "Alliance" / "Horde" strings.

use crate::data::Data;
use crate::js::V;
use crate::obj;

const RARE_RANK: f64 = 4.0;

fn friendly_to(side: &V) -> &'static [&'static str] {
	match side.as_str() {
		Some("Alliance") => &["A", "AH"],
		Some("Horde") => &["H", "AH"],
		_ => &[],
	}
}

/// Whether an npc of `faction` is hostile to one of `sides`.
pub fn hostile_to(faction: &V, sides: &V) -> bool {
	sides.items().iter().any(|s| !friendly_to(s).iter().any(|f| faction.as_str() == Some(*f)))
}

pub fn is_elite(rank: &V, faction: &V, sides: &V) -> bool {
	let r = rank.num();
	(r == 1.0 || r == 2.0 || r == 3.0) && hostile_to(faction, sides)
}

pub fn is_rare(rank: &V, faction: &V, sides: &V) -> bool {
	rank.num() == RARE_RANK && hostile_to(faction, sides)
}

/// A `kill` of an elite, or a `collect` of an item whose every located dropper is an elite.
/// -> { rank, names } | Null
pub fn elite_work(goal: &V, sides: &V, data: &Data) -> V {
	let t = goal.get("t");
	if t.as_str() == Some("kill") && !goal.get("npc").is_undef() {
		let n = data.npc(&goal.get("npc"));
		return if n.truthy() && is_elite(&n.get("rank"), &n.get("faction"), sides) { obj! { "rank" => n.get("rank").num(), "names" => vec![n.get("name")] }.into() } else { V::Null };
	}
	if t.as_str() != Some("collect") || goal.get("candidates").truthy() {
		return V::Null;
	}
	let it = data.item(&goal.get("item"));
	let mut sources: Vec<(&'static str, f64, f64)> = Vec::new();
	for kind in ["npc", "object"] {
		let d = if it.truthy() && it.get("drops").truthy() { it.get("drops").get(kind) } else { V::Undef };
		for (id, chance) in d.entries() {
			let c = chance.num();
			sources.push((kind, crate::js::str_to_num(&id), if c != 0.0 && !c.is_nan() { c } else { 0.0 }));
		}
	}
	let located: Vec<(&'static str, f64, f64)> = sources.iter().copied().filter(|s| !data.spawns(s.0, &V::Num(s.1)).is_empty()).collect();
	let mut list = if located.is_empty() { sources } else { located };
	list.sort_by(|a, b| {
		let d = b.2 - a.2;
		if d < 0.0 {
			std::cmp::Ordering::Less
		} else if d > 0.0 {
			std::cmp::Ordering::Greater
		} else {
			std::cmp::Ordering::Equal
		}
	});
	if list.is_empty() {
		return V::Null;
	}
	let recs: Vec<V> = list.iter().map(|s| if s.0 == "npc" { data.npc(&V::Num(s.1)) } else { V::Null }).collect();
	if !recs.iter().all(|r| r.truthy() && is_elite(&r.get("rank"), &r.get("faction"), sides)) {
		return V::Null;
	}
	let mut names: Vec<V> = Vec::new();
	for r in &recs {
		let n = r.get("name");
		if !names.iter().any(|x| x.strict_eq(&n)) {
			names.push(n);
		}
	}
	obj! { "rank" => recs[0].get("rank").num(), "names" => names }.into()
}

/// Whether an npc or object spawns in the open world, or an item drops from one that does.
pub fn placed(data: &Data, kind: &str, id: &V) -> bool {
	if kind != "item" {
		return !data.spawns(kind, id).is_empty();
	}
	let item = data.item(id);
	let drops = item.get("drops");
	["npc", "object"].iter().any(|k| drops.get(k).keys().iter().any(|src| !data.spawns(k, &V::Num(crate::js::str_to_num(src))).is_empty()))
}

fn is_run(kind: &V) -> bool {
	matches!(kind.as_str(), Some("dungeon") | Some("raid"))
}

/// The goal's compiled `group`: explicit ({ size? } or Undef/Null) wins; else the dungeon or raid of the
/// goal's quest or of its instance map; else elite work. -> V object | Null
pub fn group_of(goal: &V, explicit: &V, sides: &V, data: &Data) -> V {
	if explicit.truthy() {
		return if !explicit.get("size").is_undef() { obj! { "kind" => "group", "size" => explicit.get("size") }.into() } else { obj! { "kind" => "group" }.into() };
	}
	let inst = &data.instances;
	if inst.truthy() {
		let by_quest =
			if !goal.get("quest").is_undef() { crate::solo::instance_quest(&data.quest(&goal.get("quest")), &inst.get("areas"), &|kind, id| placed(data, kind, id)) } else { V::Bool(false) };
		let mut run = if by_quest.truthy() && is_run(&by_quest.get("kind")) { by_quest } else { V::Bool(false) };
		if !run.truthy() {
			run = if !goal.get("map").is_undef() { inst.get("maps").get(&goal.get("map").to_js_string()) } else { V::Bool(false) };
		}
		if run.truthy() && is_run(&run.get("kind")) {
			return if run.get("map").truthy() {
				obj! { "kind" => run.get("kind"), "name" => run.get("name"), "map" => run.get("map") }.into()
			} else {
				obj! { "kind" => run.get("kind"), "name" => run.get("name") }.into()
			};
		}
	}
	let elite = elite_work(goal, sides, data);
	if elite.truthy() {
		obj! { "kind" => "elite", "rank" => elite.get("rank") }.into()
	} else {
		V::Null
	}
}

/// The dungeon a name stands for: -> { name, map } | Null.
pub fn dungeon_named(data: &Data, name: &V) -> V {
	let inst = &data.instances;
	if !inst.truthy() {
		return V::Null;
	}
	let key = name.to_js_string().trim().to_lowercase();
	let mut runs: Vec<V> = inst.get("areas").values();
	runs.extend(inst.get("maps").values());
	runs.retain(|r| r.truthy() && r.get("kind").as_str() == Some("dungeon") && r.get("map").truthy());
	if let Some(r) = runs.iter().find(|r| r.get("name").to_js_string().to_lowercase() == key) {
		return obj! { "name" => r.get("name"), "map" => r.get("map") }.into();
	}
	let mut maps: Vec<V> = Vec::new();
	let list = if data.areas.truthy() { data.areas.get("byName").get(&key) } else { V::Undef };
	for a in list.items() {
		let r = inst.get("areas").get(&a.get("id").to_js_string());
		if r.truthy() && r.get("kind").as_str() == Some("dungeon") && r.get("map").truthy() {
			let m = r.get("map");
			if !maps.iter().any(|x| x.strict_eq(&m)) {
				maps.push(m);
			}
		}
	}
	if maps.len() != 1 {
		return V::Null;
	}
	let map = maps.pop().unwrap();
	let name = runs.iter().find(|r| r.get("map").strict_eq(&map)).map(|r| r.get("name")).unwrap_or_default();
	obj! { "name" => name, "map" => map }.into()
}
