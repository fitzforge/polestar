//! A world file read back into a `World` (the inverse of `World::to_json`): the sim reads the
//! world its walks were built on, whose point ids the walk tables are keyed by.
//! `World::from_json(&bytes)?.to_json()` gives the same bytes back.

use crate::areas::{Area, AreaKinds};
use crate::camps::{Camp, CampSourceCount};
use crate::data::Kind;
use crate::world::*;
use forge_core::Faction;
use serde_json::{Map, Value};
use std::collections::BTreeMap;

type R<T> = Result<T, String>;

fn obj<'a>(v: &'a Value, what: &str) -> R<&'a Map<String, Value>> {
	v.as_object().ok_or_else(|| format!("{what}: expected an object"))
}
fn arr<'a>(v: &'a Value, what: &str) -> R<&'a Vec<Value>> {
	v.as_array().ok_or_else(|| format!("{what}: expected an array"))
}
fn f(v: &Value, what: &str) -> R<f64> {
	v.as_f64().ok_or_else(|| format!("{what}: expected a number"))
}
fn of(v: Option<&Value>) -> Option<f64> {
	v.and_then(Value::as_f64)
}
fn u(v: &Value, what: &str) -> R<u32> {
	v.as_u64().and_then(|x| u32::try_from(x).ok()).ok_or_else(|| format!("{what}: expected a non-negative integer"))
}
fn i(v: &Value, what: &str) -> R<i64> {
	v.as_i64().ok_or_else(|| format!("{what}: expected an integer"))
}
fn s(v: &Value, what: &str) -> R<String> {
	v.as_str().map(String::from).ok_or_else(|| format!("{what}: expected a string"))
}
fn os(v: Option<&Value>) -> Option<String> {
	v.and_then(Value::as_str).map(String::from)
}
fn b(v: Option<&Value>) -> bool {
	v.and_then(Value::as_bool).unwrap_or(false)
}
fn ids(v: Option<&Value>, what: &str) -> R<Vec<i64>> {
	match v {
		None | Some(Value::Null) => Ok(Vec::new()),
		Some(x) => arr(x, what)?.iter().map(|e| i(e, what)).collect(),
	}
}
fn u32s(v: Option<&Value>, what: &str) -> R<Vec<u32>> {
	match v {
		None | Some(Value::Null) => Ok(Vec::new()),
		Some(x) => arr(x, what)?.iter().map(|e| u(e, what)).collect(),
	}
}
fn get<'a>(m: &'a Map<String, Value>, k: &str) -> &'a Value {
	m.get(k).unwrap_or(&Value::Null)
}

/// One of a closed set of strings, as the `&'static str` the World holds.
fn known(v: &str, set: &[&'static str], what: &str) -> R<&'static str> {
	set.iter().copied().find(|x| *x == v).ok_or_else(|| format!("{what}: unknown value {v:?}"))
}

const NODE_KINDS: [&str; 4] = ["fp", "dock", "lift", "portal"];
const QUEST_KINDS: [&str; 4] = ["delivery", "startItem", "talk", "work"];
const OBJ_KINDS: [&str; 5] = ["kill", "item", "object", "event", "talk"];
const PRE_RULES: [&str; 3] = ["canonical", "journal", "next"];
const EX_CODES: [&str; 14] =
	["faction", "unused", "event", "profession", "endgame", "listed", "reputation", "dungeon", "no-giver", "no-ender", "unplaceable", "rare-drop", "unsourced-item", "outside"];
const EX_CODES2: [&str; 1] = ["repeatable"];

fn work(v: &Value) -> R<Work> {
	let a = arr(v, "work")?;
	let k = a.first().and_then(Value::as_str).ok_or("work: no kind")?;
	let n = |j: usize| a.get(j).ok_or_else(|| format!("work {k}: missing item {j}")).and_then(|x| f(x, "work"));
	Ok(match k {
		"kill" => Work::Kill { level: n(1)?, count: n(2)?, elite: n(3)? != 0.0, spacing: n(4)?, npc: n(5)? as u32 },
		"use" => Work::Use(n(1)?),
		"escort" => Work::Escort,
		"buy" => Work::Buy,
		"visit" => Work::Visit,
		"dungeon" => Work::Dungeon(n(1)? as u32),
		_ => return Err(format!("work: unknown kind {k}")),
	})
}

fn task(v: &Value) -> R<Task> {
	let m = obj(v, "task")?;
	Ok(Task { pt: u(get(m, "pt"), "task.pt")?, work: arr(get(m, "work"), "task.work")?.iter().map(work).collect::<R<_>>()?, alts: u32s(m.get("alts"), "task.alts")? })
}

fn pos(v: &Value) -> R<Option<Pos>> {
	if v.is_null() {
		return Ok(None);
	}
	let m = obj(v, "pos")?;
	Ok(Some(Pos { map: u(get(m, "map"), "pos.map")?, x: f(get(m, "x"), "pos.x")?, y: f(get(m, "y"), "pos.y")?, in_dungeon: b(m.get("inDungeon")) }))
}

fn chances(v: &Value) -> R<Vec<(String, Option<f64>)>> {
	Ok(obj(v, "chances")?.iter().map(|(k, x)| (k.clone(), x.as_f64())).collect())
}

fn alt(v: Option<&Value>) -> R<Option<Vec<(String, u32)>>> {
	match v {
		None => Ok(None),
		Some(x) => Ok(Some(obj(x, "alt")?.iter().map(|(k, p)| Ok((k.clone(), u(p, "alt")?))).collect::<R<_>>()?)),
	}
}

fn quest(v: &Value) -> R<WQuest> {
	let m = obj(v, "quest")?;
	let id = u(get(m, "id"), "quest.id")?;
	let w = |k: &str| format!("quest {id}.{k}");
	let objs = arr(get(m, "objs"), &w("objs"))?
		.iter()
		.map(|o| {
			let o = obj(o, "obj")?;
			Ok(Obj {
				oi: i(get(o, "oi"), "obj.oi")?,
				kind: known(&s(get(o, "type"), "obj.type")?, &OBJ_KINDS, "obj.type")?,
				id: of(o.get("id")),
				count: f(get(o, "count"), "obj.count")?,
				item: of(o.get("item")),
				quest_item: b(o.get("questItem")),
				camps: u32s(o.get("camps"), "obj.camps")?,
				chances: chances(get(o, "chances"))?,
				task: o.get("task").and_then(Value::as_u64).map(|t| t as u32),
				dur: of(o.get("dur")),
			})
		})
		.collect::<R<_>>()?;
	let obj_camps = match m.get("objCamps") {
		None => None,
		Some(x) => Some(
			arr(x, &w("objCamps"))?
				.iter()
				.map(|e| {
					let e = arr(e, "objCamps entry")?;
					Ok(ObjCamp { oi: i(&e[0], "objCamps.oi")?, camps: u32s(e.get(1), "objCamps.camps")?, chances: chances(&e[2])? })
				})
				.collect::<R<_>>()?,
		),
	};
	let mech = match m.get("mech") {
		None => None,
		Some(x) => {
			let x = obj(x, "mech")?;
			Some(Mech {
				kinds: arr(get(x, "kinds"), "mech.kinds")?.iter().map(|k| s(k, "mech.kinds")).collect::<R<_>>()?,
				params: x.get("params").and_then(Value::as_array).cloned().unwrap_or_default(),
			})
		}
	};
	Ok(WQuest {
		id,
		title: s(get(m, "title"), &w("title"))?,
		level: f(get(m, "level"), &w("level"))?,
		min_level: f(get(m, "minLevel"), &w("minLevel"))?,
		races: of(m.get("races")),
		classes: of(m.get("classes")),
		pre: ids(m.get("pre"), &w("pre"))?,
		excl: ids(m.get("excl"), &w("excl"))?,
		next: of(m.get("next")),
		xp: of(m.get("xp")),
		no_xp: m.get("noXp").and_then(Value::as_bool),
		giver: u(get(m, "giver"), &w("giver"))?,
		ender: u(get(m, "ender"), &w("ender"))?,
		accept: match get(m, "accept") {
			Value::Null => None,
			x => Some(task(x)?),
		},
		tasks: arr(get(m, "tasks"), &w("tasks"))?.iter().map(task).collect::<R<_>>()?,
		zone: u(get(m, "zone"), &w("zone"))?,
		breadcrumb: b(m.get("breadcrumb")),
		kind: known(&s(get(m, "kind"), &w("kind"))?, &QUEST_KINDS, &w("kind"))?,
		objs,
		escort: b(m.get("escort")),
		elite: b(m.get("elite")),
		g_name: os(m.get("gName")),
		e_name: os(m.get("eName")),
		g_pos: pos(get(m, "gPos"))?,
		e_pos: pos(get(m, "ePos"))?,
		g_alt: alt(m.get("gAlt"))?,
		limit: of(m.get("limit")),
		mech,
		e_alt: alt(m.get("eAlt"))?,
		start_from: m.get("startFrom").and_then(Value::as_u64).map(|x| x as u32),
		source_dur: of(m.get("sourceDur")),
		obj_camps,
		in_log: m.get("inLog").and_then(Value::as_i64),
		pre_all: ids(m.get("preAll"), &w("preAll"))?,
		pre_rule: match m.get("preRule").and_then(Value::as_str) {
			None => None,
			Some(r) => Some(known(r, &PRE_RULES, &w("preRule"))?),
		},
		after: match m.get("after") {
			None => None,
			Some(x) => Some(u32s(Some(x), &w("after"))?),
		},
		tier: u(get(m, "tier"), &w("tier"))?,
		hub_giver: i(get(m, "hubGiver"), &w("hubGiver"))?,
		hub_ender: i(get(m, "hubEnder"), &w("hubEnder"))?,
		dungeon: m.get("dungeon").and_then(Value::as_u64).map(|x| x as u32),
		// Dungeon-journal records carry no `noXp` (world.js addQuest).
		from_journal: !m.contains_key("noXp"),
	})
}

fn svc(v: &Value) -> R<Vec<SvcPt>> {
	arr(v, "service")?
		.iter()
		.map(|x| {
			let x = obj(x, "service")?;
			Ok(SvcPt { pt: u(get(x, "pt"), "service.pt")?, npc: x.get("npc").and_then(Value::as_u64).map(|n| n as u32) })
		})
		.collect()
}

impl World {
	/// Reads a world file (as world.js or `to_json` wrote it).
	pub fn from_json(bytes: &[u8]) -> Result<World, String> {
		let v: Value = serde_json::from_slice(bytes).map_err(|e| format!("world file: {e}"))?;
		World::from_value(&v)
	}

	pub fn from_value(v: &Value) -> Result<World, String> {
		let w = obj(v, "world")?;
		if get(w, "schema").as_u64() != Some(1) {
			return Err("world file: expected schema 1".into());
		}
		let faction = Faction::parse(&s(get(w, "faction"), "faction")?).ok_or("world file: unknown faction")?;
		let points = arr(get(w, "points"), "points")?
			.iter()
			.map(|p| {
				let p = arr(p, "point")?;
				Ok(Point {
					c: i(&p[0], "point.c")?,
					region: i(&p[1], "point.region")?,
					wx: f(&p[2], "point.wx")?,
					wy: f(&p[3], "point.wy")?,
					map: u(&p[4], "point.map")?,
					z: p.get(5).and_then(Value::as_f64),
				})
			})
			.collect::<R<Vec<_>>>()?;
		let h = obj(get(w, "heights"), "heights")?;
		let hu = |k: &str| get(h, k).as_u64().unwrap_or(0) as u32;
		let heights = Heights { source: hu("source"), floor: hu("floor"), hinted: hu("hinted"), ambiguous: hu("ambiguous"), none: hu("none") };
		let nodes = arr(get(w, "nodes"), "nodes")?
			.iter()
			.map(|n| {
				let n = obj(n, "node")?;
				Ok(Node { kind: known(&s(get(n, "kind"), "node.kind")?, &NODE_KINDS, "node.kind")?, taxi: of(n.get("taxi")), name: s(get(n, "name"), "node.name")?, pt: u(get(n, "pt"), "node.pt")? })
			})
			.collect::<R<_>>()?;
		let taxi = arr(get(w, "taxi"), "taxi")?
			.iter()
			.map(|t| {
				let t = arr(t, "taxi leg")?;
				Ok((u(&t[0], "taxi.a")?, u(&t[1], "taxi.b")?, t.get(2).cloned().unwrap_or(Value::Null)))
			})
			.collect::<R<_>>()?;
		let rides = arr(get(w, "rides"), "rides")?
			.iter()
			.map(|r| {
				let r = arr(r, "ride")?;
				Ok(Ride { a: u(&r[0], "ride.a")?, b: u(&r[1], "ride.b")?, seconds: f(&r[2], "ride.seconds")?, wait: f(&r[3], "ride.wait")?, id: r.get(4).cloned().unwrap_or(Value::Null) })
			})
			.collect::<R<_>>()?;
		let inns = arr(get(w, "inns"), "inns")?
			.iter()
			.map(|x| {
				let x = obj(x, "inn")?;
				Ok(Inn { name: get(x, "name").clone(), pt: u(get(x, "pt"), "inn.pt")? })
			})
			.collect::<R<_>>()?;
		let hubs = arr(get(w, "hubs"), "hubs")?
			.iter()
			.map(|x| {
				let x = obj(x, "hub")?;
				Ok(Hub {
					pt: u(get(x, "pt"), "hub.pt")?,
					zone: u(get(x, "zone"), "hub.zone")?,
					size: u(get(x, "size"), "hub.size")?,
					fp: i(get(x, "fp"), "hub.fp")?,
					inn: i(get(x, "inn"), "hub.inn")?,
					trainers: arr(get(x, "trainers"), "hub.trainers")?.iter().map(|t| s(t, "hub.trainers")).collect::<R<_>>()?,
				})
			})
			.collect::<R<_>>()?;
		let quests = arr(get(w, "quests"), "quests")?.iter().map(quest).collect::<R<_>>()?;
		let excluded = arr(get(w, "excluded"), "excluded")?
			.iter()
			.map(|x| {
				let x = obj(x, "excluded")?;
				let code = s(get(x, "code"), "excluded.code")?;
				Ok(Excluded {
					id: u(get(x, "id"), "excluded.id")?,
					title: os(x.get("title")),
					reason: s(get(x, "reason"), "excluded.reason")?,
					category: os(x.get("category")),
					code: known(&code, &EX_CODES, "excluded.code").or_else(|_| known(&code, &EX_CODES2, "excluded.code"))?,
				})
			})
			.collect::<R<_>>()?;
		let camps = arr(get(w, "camps"), "camps")?
			.iter()
			.map(|x| {
				let x = obj(x, "camp")?;
				Ok(Camp {
					id: u(get(x, "id"), "camp.id")?,
					pt: u(get(x, "pt"), "camp.pt")?,
					c: i(get(x, "c"), "camp.c")?,
					region: i(get(x, "region"), "camp.region")?,
					radius: f(get(x, "radius"), "camp.radius")?,
					spawns: u(get(x, "spawns"), "camp.spawns")?,
					level_min: of(x.get("levelMin")),
					level_max: of(x.get("levelMax")),
					respawn: of(x.get("respawn")),
					sources: arr(get(x, "sources"), "camp.sources")?
						.iter()
						.map(|s0| {
							let s0 = obj(s0, "camp source")?;
							let kind = match get(s0, "kind").as_str() {
								Some("npc") => Kind::Npc,
								Some("object") => Kind::Object,
								k => return Err(format!("camp source kind {k:?}")),
							};
							Ok(CampSourceCount { kind, id: u(get(s0, "id"), "camp source id")?, spawns: u(get(s0, "spawns"), "camp source spawns")? })
						})
						.collect::<R<_>>()?,
					elite: b(x.get("elite")),
				})
			})
			.collect::<R<_>>()?;
		let sv = obj(get(w, "services"), "services")?;
		let services = Services {
			trainer: obj(get(sv, "trainer"), "services.trainer")?.iter().map(|(k, l)| Ok((k.clone(), svc(l)?))).collect::<R<_>>()?,
			repair: svc(get(sv, "repair"))?,
			food: svc(get(sv, "food"))?,
			ammo: svc(get(sv, "ammo"))?,
			inn: svc(get(sv, "inn"))?,
			flight: svc(get(sv, "flight"))?,
			riding: arr(get(sv, "riding"), "services.riding")?
				.iter()
				.map(|r| {
					let r = obj(r, "riding")?;
					let vendor = match r.get("vendor") {
						None => None,
						Some(v0) => Some((u(v0, "riding.vendor")?, u(get(r, "vendorPt"), "riding.vendorPt")?, get(r, "item").clone(), get(r, "itemCopper").clone())),
					};
					Ok(RidingStop { pt: u(get(r, "pt"), "riding.pt")?, npc: u(get(r, "npc"), "riding.npc")?, races: f(get(r, "races"), "riding.races")?, vendor })
				})
				.collect::<R<_>>()?,
		};
		let service_set = obj(get(w, "serviceSet"), "serviceSet")?
			.iter()
			.map(|(k, l)| Ok((k.parse::<u32>().map_err(|_| format!("serviceSet key {k}"))?, arr(l, "serviceSet")?.iter().map(|x| s(x, "serviceSet")).collect::<R<_>>()?)))
			.collect::<R<BTreeMap<_, _>>>()?;
		let areas = arr(get(w, "areas"), "areas")?
			.iter()
			.map(|x| {
				let x = obj(x, "area")?;
				let k = obj(get(x, "kinds"), "area.kinds")?;
				let ku = |n: &str| get(k, n).as_u64().unwrap_or(0) as u32;
				Ok(Area {
					id: u(get(x, "id"), "area.id")?,
					pt: u(get(x, "pt"), "area.pt")?,
					c: i(get(x, "c"), "area.c")?,
					region: i(get(x, "region"), "area.region")?,
					members: u32s(x.get("members"), "area.members")?,
					hub: b(x.get("hub")),
					kinds: AreaKinds { giver: ku("giver"), ender: ku("ender"), camp: ku("camp"), service: ku("service"), node: ku("node"), task: ku("task") },
				})
			})
			.collect::<R<_>>()?;
		let point_area = arr(get(w, "pointArea"), "pointArea")?.iter().map(|x| i(x, "pointArea").map(|n| n as i32)).collect::<R<_>>()?;
		let so = obj(get(w, "solo"), "solo")?;
		let counts = obj(get(so, "counts"), "solo.counts")?.iter().map(|(k, n)| Ok((known(k, &crate::solo::CATEGORIES, "solo.counts")?, n.as_u64().unwrap_or(0) as u32))).collect::<R<_>>()?;
		let ov = obj(get(so, "overrides"), "solo.overrides")?;
		let ovn = |k: &str| get(ov, k).as_u64().unwrap_or(0) as usize;
		let solo = Solo {
			counts,
			repeat_no_xp: get(so, "repeatNoXp").as_u64().unwrap_or(0) as u32,
			instance_areas: os(so.get("instanceAreas")),
			overrides: (ovn("exclude"), ovn("allow"), ovn("turninAfter")),
		};
		let packages = arr(get(w, "packages"), "packages")?
			.iter()
			.map(|x| {
				let x = obj(x, "package")?;
				let lv = arr(get(x, "levels"), "package.levels")?;
				Ok(Package {
					key: s(get(x, "key"), "package.key")?,
					zone: u(get(x, "zone"), "package.zone")?,
					zone_name: s(get(x, "zoneName"), "package.zoneName")?,
					band: f(get(x, "band"), "package.band")?,
					levels: (f(&lv[0], "package.levels")?, f(&lv[1], "package.levels")?),
					dungeon: x.get("dungeon").and_then(Value::as_u64).map(|d| d as u32),
					quests: u32s(x.get("quests"), "package.quests")?,
					steps: arr(get(x, "steps"), "package.steps")?
						.iter()
						.map(|st| {
							let st = arr(st, "step")?;
							Ok((i(&st[0], "step.kind")? as u8, i(&st[1], "step.q")?, i(&st[2], "step.task")?, u(&st[3], "step.pt")?))
						})
						.collect::<R<_>>()?,
				})
			})
			.collect::<R<_>>()?;
		let dungeons = arr(get(w, "dungeons"), "dungeons")?
			.iter()
			.map(|x| {
				let x = obj(x, "dungeon")?;
				Ok(Dungeon {
					key: get(x, "key").clone(),
					name: get(x, "name").clone(),
					min: get(x, "min").clone(),
					max: get(x, "max").clone(),
					pt: u(get(x, "pt"), "dungeon.pt")?,
					zone: u(get(x, "zone"), "dungeon.zone")?,
					bosses: arr(get(x, "bosses"), "dungeon.bosses")?.iter().map(|b0| f(b0, "dungeon.bosses")).collect::<R<_>>()?,
					boss_count: u(get(x, "bossCount"), "dungeon.bossCount")?,
					quests: u32s(x.get("quests"), "dungeon.quests")?,
				})
			})
			.collect::<R<_>>()?;
		let grind_spacing = arr(get(obj(get(w, "grind"), "grind")?, "spacing"), "grind.spacing")?.iter().map(|x| f(x, "grind.spacing")).collect::<R<_>>()?;
		let zone_min = obj(get(w, "zoneMin"), "zoneMin")?.iter().map(|(k, x)| Ok((k.parse::<u32>().map_err(|_| format!("zoneMin key {k}"))?, f(x, "zoneMin")?))).collect::<R<BTreeMap<_, _>>>()?;
		let danger = arr(get(w, "danger"), "danger")?
			.iter()
			.map(|x| {
				let x = obj(x, "danger")?;
				Ok(Danger {
					region: i(get(x, "region"), "danger.region")?,
					gx0: i(get(x, "gx0"), "danger.gx0")?,
					gy0: i(get(x, "gy0"), "danger.gy0")?,
					nx: i(get(x, "nx"), "danger.nx")?,
					ny: i(get(x, "ny"), "danger.ny")?,
					cell: f(get(x, "cell"), "danger.cell")?,
					z: u32s(x.get("z"), "danger.z")?,
				})
			})
			.collect::<R<_>>()?;
		let graveyards = match w.get("graveyards") {
			None | Some(Value::Null) => Vec::new(),
			Some(x) => arr(x, "graveyards")?
				.iter()
				.map(|x| {
					let x = obj(x, "graveyard")?;
					let l = arr(get(x, "loc"), "graveyard.loc")?;
					let lf = |k: usize| l.get(k).and_then(Value::as_f64).unwrap_or(f64::NAN);
					Ok(Graveyard {
						id: u(get(x, "id"), "graveyard.id")?,
						name: s(get(x, "name"), "graveyard.name")?,
						pt: u(get(x, "pt"), "graveyard.pt")?,
						loc: (i(l.first().unwrap_or(&Value::Null), "graveyard.loc")?, lf(1), lf(2), lf(3)),
						maps: u32s(x.get("maps"), "graveyard.maps")?,
					})
				})
				.collect::<R<_>>()?,
		};
		let starts = obj(get(w, "starts"), "starts")?
			.iter()
			.map(|(race, x)| {
				let x = obj(x, "start")?;
				Ok((race.clone(), Start { zone: s(get(x, "zone"), "start.zone")?, pt: u(get(x, "pt"), "start.pt")?, quest: u(get(x, "quest"), "start.quest")? }))
			})
			.collect::<R<_>>()?;
		let zones = obj(get(w, "zones"), "zones")?.iter().map(|(k, x)| Ok((k.parse::<u32>().map_err(|_| format!("zones key {k}"))?, s(x, "zones")?))).collect::<R<BTreeMap<_, _>>>()?;
		let pr = obj(get(w, "preRules"), "preRules")?;
		let pu = |k: &str| get(pr, k).as_u64().unwrap_or(0) as u32;
		Ok(World {
			faction,
			band_width: f(get(w, "bandWidth"), "bandWidth")?,
			max_open: u(get(w, "maxOpen"), "maxOpen")?,
			points,
			heights,
			nodes,
			taxi,
			rides,
			inns,
			hubs,
			quests,
			excluded,
			camps,
			services,
			service_set,
			areas,
			point_area,
			training: get(w, "training").clone(),
			training_spells: get(w, "trainingSpells").clone(),
			riding: get(w, "riding").clone(),
			classes: obj(get(w, "classes"), "classes")?.iter().map(|(k, x)| (k.clone(), x.clone())).collect(),
			excluded_ids: u32s(w.get("excludedIds"), "excludedIds")?,
			solo,
			packages,
			dungeons,
			grind_spacing,
			zone_min,
			danger,
			graveyards,
			starts,
			zones,
			warnings: arr(get(w, "warnings"), "warnings")?.iter().map(|x| s(x, "warnings")).collect::<R<_>>()?,
			pre_rules: PreRules { canonical: pu("canonical"), journal: pu("journal"), next: pu("next"), children: pu("children") },
			data_hash: os(w.get("dataHash")),
			inputs: match w.get("inputs") {
				None => Vec::new(),
				Some(x) => obj(x, "inputs")?.iter().map(|(k, x)| Ok((k.clone(), s(x, "inputs")?))).collect::<R<_>>()?,
			},
			quest_xp: get(w, "questXp").clone(),
		})
	}
}
