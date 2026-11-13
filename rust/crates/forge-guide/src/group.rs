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

/// An npc record's highest level (0: unknown).
fn top_level(n: &V) -> f64 {
	let m = n.get("levelMax").num();
	let l = if m > 0.0 { m } else { n.get("level").num() };
	if l > 0.0 {
		l
	} else {
		0.0
	}
}

/// A `kill` of an elite, or a `collect` of an item whose every located dropper is an elite.
/// -> { rank, names, lvl } | Null (`lvl`: the elites' highest level, 0 when unknown)
pub fn elite_work(goal: &V, sides: &V, data: &Data) -> V {
	let t = goal.get("t");
	if t.as_str() == Some("kill") && !goal.get("npc").is_undef() {
		let n = data.npc(&goal.get("npc"));
		return if n.truthy() && is_elite(&n.get("rank"), &n.get("faction"), sides) {
			obj! { "rank" => n.get("rank").num(), "names" => vec![n.get("name")], "lvl" => top_level(&n) }.into()
		} else {
			V::Null
		};
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
	let lvl = recs.iter().map(top_level).fold(0.0, f64::max);
	obj! { "rank" => recs[0].get("rank").num(), "names" => names, "lvl" => lvl }.into()
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

/// Elites at an object's work (#1778: Berard's Bookshelf in Pyrewood Village, beside Apothecary Berard, 16
/// elite, among the village's elite Watchers, Sentries and Elders), as the Codex build marks Lookup's quest
/// objectives (forge-data codex/elites.rs): a quest's `interact`, or `collect` of an item only objects give (one
/// an npc drops is elite_work's), whose object's spawn points (every one, those the cap left out too) have, at
/// least half of them, an elite (rank 1-3) hostile to a side the goal applies to within NEAR yards. Not one of
/// no real level, nor one of no side that gives or takes a quest or has a role (a friendly NPC whose side the
/// data lacks: Keeper Remulos). -> { rank, lvl } (the highest among them; lvl 0 when unknown) | Null
const NEAR: f64 = 40.0;
const MAX_LEVEL: f64 = 63.0;

fn cell_key(c: &V, wx: f64, wy: f64, dx: f64, dy: f64) -> String {
	format!("{},{},{}", c.to_js_string(), (wx / NEAR).floor() + dx, (wy / NEAR).floor() + dy)
}

/// Every spawn point of an npc or object as world points.
fn world_points(data: &Data, kind: &str, id: &V) -> Vec<crate::candidates::WorldPos> {
	let mut out = Vec::new();
	for s in data.spawns(kind, id) {
		for p in s.get("pts").items().into_iter().chain(s.get("more").items()) {
			if let Some(w) = crate::candidates::world_pos(data, &s.get("map"), p.at(0).num(), p.at(1).num(), &s.get("f")) {
				out.push(w);
			}
		}
	}
	out
}

/// The elites by world cell (memo "group.elites"): cell -> [[wx, wy, rank, lvl, faction], ...].
fn elite_grid(data: &Data) -> V {
	if let Some(v) = data.memo.borrow().get("group.elites") {
		return v.clone();
	}
	let mut givers: rustc_hash::FxHashSet<String> = rustc_hash::FxHashSet::default();
	for q in data.quests.values() {
		for end in ["start", "end"] {
			for n in q.get(end).get("npc").items() {
				givers.insert(n.to_js_string());
			}
		}
	}
	let grid = V::obj();
	for n in data.npcs.values() {
		let rank = n.get("rank").num();
		if !n.truthy() || !(rank == 1.0 || rank == 2.0 || rank == 3.0) {
			continue;
		}
		let lvl = top_level(&n);
		let faction = n.get("faction");
		if lvl > MAX_LEVEL || faction.as_str() == Some("AH") {
			continue;
		}
		if !faction.truthy() && (givers.contains(&n.get("id").to_js_string()) || !n.get("roles").items().is_empty()) {
			continue;
		}
		for w in world_points(data, "npc", &n.get("id")) {
			let key = cell_key(&w.c, w.wx, w.wy, 0.0, 0.0);
			if !grid.has(&key) {
				grid.set(&key, V::arr());
			}
			grid.get(&key).push(V::from(vec![V::Num(w.wx), V::Num(w.wy), V::Num(rank), V::Num(lvl), faction.clone()]));
		}
	}
	data.memo.borrow_mut().insert("group.elites", grid.clone());
	grid
}

pub fn elite_near(goal: &V, sides: &V, data: &Data) -> V {
	if goal.get("quest").is_undef() {
		return V::Null;
	}
	let t = goal.get("t");
	let sources: Vec<V> = if t.as_str() == Some("interact") && !goal.get("object").is_undef() {
		vec![goal.get("object")]
	} else if t.as_str() == Some("collect") && !goal.get("item").is_undef() && !goal.get("candidates").truthy() {
		let drops = data.item(&goal.get("item")).get("drops");
		if !drops.get("npc").keys().is_empty() {
			return V::Null;
		}
		drops.get("object").keys().iter().map(|k| V::Num(crate::js::str_to_num(k))).collect()
	} else {
		return V::Null;
	};
	let pts: Vec<crate::candidates::WorldPos> = sources.iter().flat_map(|id| world_points(data, "object", id)).collect();
	if pts.is_empty() {
		return V::Null;
	}
	let grid = elite_grid(data);
	let (mut hits, mut rank, mut lvl) = (0usize, 0.0f64, 0.0f64);
	for w in &pts {
		let mut hit = false;
		for dx in [-1.0, 0.0, 1.0] {
			for dy in [-1.0, 0.0, 1.0] {
				for e in grid.get(&cell_key(&w.c, w.wx, w.wy, dx, dy)).items() {
					if (e.num_at(0) - w.wx).hypot(e.num_at(1) - w.wy) > NEAR || !hostile_to(&e.at(4), sides) {
						continue;
					}
					hit = true;
					rank = rank.max(e.num_at(2));
					lvl = lvl.max(e.num_at(3));
				}
			}
		}
		if hit {
			hits += 1;
		}
	}
	if hits >= pts.len().div_ceil(2) {
		obj! { "rank" => rank, "lvl" => lvl }.into()
	} else {
		V::Null
	}
}

fn is_run(kind: &V) -> bool {
	matches!(kind.as_str(), Some("dungeon") | Some("raid"))
}

/// The goal's compiled `group`: explicit ({ size? } or Undef/Null) wins; else the dungeon or raid of the
/// goal's quest or of its instance map; else elite work; else an object's work among elites (`near`: the
/// guide menu's "Group" chip leaves it out). -> V object | Null
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
		let out: V = obj! { "kind" => "elite", "rank" => elite.get("rank") }.into();
		if elite.get("lvl").num() > 0.0 {
			out.set("lvl", elite.get("lvl"));
		}
		return out;
	}
	let near = elite_near(goal, sides, data);
	if !near.truthy() {
		return V::Null;
	}
	let out: V = obj! { "kind" => "elite", "rank" => near.get("rank") }.into();
	if near.get("lvl").num() > 0.0 {
		out.set("lvl", near.get("lvl"));
	}
	out.set("near", true);
	out
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
