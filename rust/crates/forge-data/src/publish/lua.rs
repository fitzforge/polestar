//! `forge data publish --lua <dir>`: the in-game library LibForeverData/ from a release folder.
//!
//! Records are text in long-string chunks (forge_core::luachunks, read by its LuaChunks.lua):
//! nothing is built per record at load; a record is decoded on first read into a weak cache, and
//! every answer is a fresh table. The read API keeps LibDingDB's call shapes where they overlap
//! (Get, Name, Ids), so an addon that reads one can read the other.
//!
//! Payloads (fields by `;`, lists by `,`, parts by `:`, text escaped by luachunks::field):
//! - quest: title;level;minLevel;races;classes;side;xp;money;type;zone;repeatable;start;end;
//!   objectives;prereqs;rewards. start/end: `n<id>`, `o<id>`, `i<id>`; objectives
//!   `<k>:<target>:<count>` (k kill, item, object, event, talk as k i o e t); prereqs
//!   `<quest>:<a|y>:<1|>` (all/any, breadcrumb); rewards `<i|c|r>:<id>:<count>`.
//! - npc: name;subname;levelMin;levelMax;factionTemplate;rank. object: name;type.
//! - item: name;questItem;sources (`<n|o|i><id>:<chance>`).
//! - npcSpawn / objectSpawn: 11-character points, map (2 digits), x and y in half yards + 2^17
//!   (3 each), z in tenths of a yard + 2^17 (3; `///` when unknown), base 64 (luachunks::fixed).
//! - steps / notes, keyed by quest: rows by `|`; a step `n:id:action:targetKind:target:count:
//!   place:text:u`, a note `id:kind:place:text:u` (place `map,x,y`; `u`: unconfirmed).

use std::collections::BTreeMap;
use std::path::Path;

use forge_core::luachunks::{self, field, fixed, Chunk};
use serde_json::{Map, Value};

use super::release::read_table;

pub const ADDON: &str = "LibForeverData";
/// The read API's version (the first part of a lib-v tag).
pub const API: u32 = 1;
/// The client this library loads on (addon/Polestar/Polestar.toc's Interface).
pub const INTERFACE: &str = "16001";

const OFFSET: i64 = 1 << 17;
const NO_Z: u64 = 64 * 64 * 64 - 1;

type Row = Map<String, Value>;

fn io<E: std::fmt::Display>(p: &Path) -> impl Fn(E) -> String + '_ {
	move |e| format!("{}: {e}", p.display())
}

fn int(r: &Row, k: &str) -> Option<i64> {
	r.get(k).and_then(|v| v.as_i64().or_else(|| v.as_u64().map(|u| u as i64)))
}

fn num_text(v: Option<&Value>) -> String {
	match v {
		Some(Value::Number(n)) => n.to_string(),
		Some(Value::Bool(true)) => "1".into(),
		_ => String::new(),
	}
}

fn text(r: &Row, k: &str) -> String {
	r.get(k).and_then(Value::as_str).map(field).unwrap_or_default()
}

fn rows(dir: &Path, table: &str) -> Result<Vec<Row>, String> {
	Ok(read_table(dir, table)?.into_values().collect())
}

/// Rows grouped by `key` (an integer column), in the table's order.
fn by<'a>(rows: &'a [Row], key: &str) -> BTreeMap<i64, Vec<&'a Row>> {
	let mut m: BTreeMap<i64, Vec<&Row>> = BTreeMap::new();
	for r in rows {
		if let Some(k) = int(r, key) {
			m.entry(k).or_default().push(r);
		}
	}
	m
}

fn letter(kind: &str) -> &'static str {
	match kind {
		"npc" => "n",
		"object" => "o",
		"item" => "i",
		"kill" => "k",
		"event" => "e",
		"talk" => "t",
		"choice" => "c",
		"rep" => "r",
		_ => "?",
	}
}

fn place(p: Option<&Value>) -> String {
	match p {
		Some(p) => format!("{},{},{}", num_text(p.get("map")), num_text(p.get("x")), num_text(p.get("y"))),
		None => String::new(),
	}
}

/// A spawn point as 11 base-64 digits.
fn point(map: i64, x: f64, y: f64, z: Option<f64>) -> Result<String, String> {
	let half = |v: f64| -> Result<u64, String> {
		let n = (v * 2.0).round() as i64 + OFFSET;
		u64::try_from(n).ok().filter(|n| *n < NO_Z).ok_or_else(|| format!("spawn coordinate {v} out of range"))
	};
	let zz = match z {
		Some(z) => u64::try_from((z * 10.0).round() as i64 + OFFSET).ok().filter(|n| *n < NO_Z).ok_or_else(|| format!("spawn height {z} out of range"))?,
		None => NO_Z,
	};
	let m = u64::try_from(map).ok().filter(|m| *m < 4096).ok_or_else(|| format!("map {map} out of range"))?;
	Ok(format!("{}{}{}{}", fixed(m, 2), fixed(half(x)?, 3), fixed(half(y)?, 3), fixed(zz, 3)))
}

/// Each kind's records: kind -> [(id, payload)].
fn records(dir: &Path) -> Result<BTreeMap<&'static str, Vec<(i64, String)>>, String> {
	let mut out: BTreeMap<&'static str, Vec<(i64, String)>> = BTreeMap::new();
	let (starts, ends, objs, pres, rews) = (rows(dir, "quest_start")?, rows(dir, "quest_end")?, rows(dir, "quest_objective")?, rows(dir, "quest_prereq")?, rows(dir, "quest_reward")?);
	let (starts, ends, objs, pres, rews) = (by(&starts, "quest"), by(&ends, "quest"), by(&objs, "quest"), by(&pres, "quest"), by(&rews, "quest"));
	let none: Vec<&Row> = Vec::new();
	let list = |m: &BTreeMap<i64, Vec<&Row>>, id: i64, f: &dyn Fn(&Row) -> String| -> String { m.get(&id).unwrap_or(&none).iter().map(|r| f(r)).collect::<Vec<_>>().join(",") };
	for q in rows(dir, "quest")? {
		let Some(id) = int(&q, "id") else { continue };
		let ent = |r: &Row| format!("{}{}", letter(r.get("kind").and_then(Value::as_str).unwrap_or("")), num_text(r.get("id")));
		let mut objectives: Vec<&Row> = objs.get(&id).cloned().unwrap_or_default();
		objectives.sort_by_key(|r| int(r, "n"));
		let fields = [
			text(&q, "title"),
			num_text(q.get("level")),
			num_text(q.get("min_level")),
			num_text(q.get("races")),
			num_text(q.get("classes")),
			num_text(q.get("side")),
			num_text(q.get("xp")),
			num_text(q.get("money_copper")),
			num_text(q.get("type")),
			num_text(q.get("zone_area")),
			num_text(q.get("repeatable")),
			list(&starts, id, &ent),
			list(&ends, id, &ent),
			objectives
				.iter()
				.map(|r| format!("{}:{}:{}", letter(r.get("kind").and_then(Value::as_str).unwrap_or("")), num_text(r.get("target")), num_text(r.get("count"))))
				.collect::<Vec<_>>()
				.join(","),
			list(&pres, id, &|r| format!("{}:{}:{}", num_text(r.get("pre")), if r.get("mode").and_then(Value::as_str) == Some("any") { "y" } else { "a" }, num_text(r.get("breadcrumb")))),
			list(&rews, id, &|r| format!("{}:{}:{}", letter(r.get("kind").and_then(Value::as_str).unwrap_or("")), num_text(r.get("id")), num_text(r.get("count")))),
		];
		out.entry("quest").or_default().push((id, fields.join(";")));
	}
	for n in rows(dir, "npc")? {
		let Some(id) = int(&n, "id") else { continue };
		let f = [text(&n, "name"), text(&n, "subname"), num_text(n.get("level_min")), num_text(n.get("level_max")), num_text(n.get("faction_template")), num_text(n.get("rank"))];
		out.entry("npc").or_default().push((id, f.join(";")));
	}
	for o in rows(dir, "object")? {
		let Some(id) = int(&o, "id") else { continue };
		out.entry("object").or_default().push((id, format!("{};{}", text(&o, "name"), num_text(o.get("type")))));
	}
	let src = rows(dir, "item_source")?;
	let src = by(&src, "item");
	for i in rows(dir, "item")? {
		let Some(id) = int(&i, "id") else { continue };
		let s = list(&src, id, &|r| format!("{}{}:{}", letter(r.get("kind").and_then(Value::as_str).unwrap_or("")), num_text(r.get("id")), num_text(r.get("chance"))));
		out.entry("item").or_default().push((id, format!("{};{};{}", text(&i, "name"), num_text(i.get("quest_item")), s)));
	}
	let mut spawns: BTreeMap<(&'static str, i64), Vec<(i64, i64, String)>> = BTreeMap::new();
	for s in rows(dir, "spawn")? {
		let kind = if s.get("kind").and_then(Value::as_str) == Some("object") { "objectSpawn" } else { "npcSpawn" };
		let (Some(id), Some(map), Some(n)) = (int(&s, "id"), int(&s, "map"), int(&s, "n")) else { continue };
		let (x, y) = (s.get("x").and_then(Value::as_f64).unwrap_or(0.0), s.get("y").and_then(Value::as_f64).unwrap_or(0.0));
		spawns.entry((kind, id)).or_default().push((map, n, point(map, x, y, s.get("z").and_then(Value::as_f64))?));
	}
	for ((kind, id), mut pts) in spawns {
		pts.sort_by_key(|p| (p.0, p.1));
		out.entry(kind).or_default().push((id, pts.into_iter().map(|p| p.2).collect()));
	}
	let steps = rows(dir, "step")?;
	for (q, mut st) in by(&steps, "quest") {
		st.sort_by_key(|r| int(r, "n"));
		let rs: Vec<String> = st
			.iter()
			.map(|r| {
				format!(
					"{}:{}:{}:{}:{}:{}:{}:{}:{}",
					num_text(r.get("n")),
					text(r, "id"),
					text(r, "action"),
					text(r, "target_kind"),
					num_text(r.get("target")),
					num_text(r.get("count")),
					place(r.get("place")),
					text(r, "text"),
					if r.get("confidence").is_some() { "u" } else { "" }
				)
			})
			.collect();
		out.entry("steps").or_default().push((q, rs.join("|")));
	}
	let notes = rows(dir, "note")?;
	for (q, ns) in by(&notes, "quest") {
		let rs: Vec<String> =
			ns.iter().map(|r| format!("{}:{}:{}:{}:{}", text(r, "id"), text(r, "kind"), place(r.get("place")), text(r, "text"), if r.get("confidence").is_some() { "u" } else { "" })).collect();
		out.entry("notes").or_default().push((q, rs.join("|")));
	}
	Ok(out)
}

/// The Data/ files: (file name, kinds in it).
const FILES: &[(&str, &[&str])] =
	&[("Quests", &["quest"]), ("Npcs", &["npc"]), ("Objects", &["object"]), ("Items", &["item"]), ("Spawns", &["npcSpawn", "objectSpawn"]), ("Steps", &["steps", "notes"])];

/// Writes `<into>/LibForeverData/` from the release folder `dir`; returns (files, bytes).
pub fn write(dir: &Path, into: &Path) -> Result<(usize, u64), String> {
	let index: Value = serde_json::from_slice(&std::fs::read(dir.join("index.json")).map_err(io(dir))?).map_err(io(dir))?;
	let version = index.get("version").and_then(Value::as_str).ok_or("index.json: no version")?.to_string();
	let client = index.get("clientBuild").and_then(Value::as_str).unwrap_or("unknown").to_string();
	let out = into.join(ADDON);
	if out.exists() {
		std::fs::remove_dir_all(&out).map_err(io(&out))?;
	}
	std::fs::create_dir_all(out.join("Data")).map_err(io(&out))?;
	let recs = records(dir)?;
	let header = format!("-- {ADDON} {version}: generated by forge data publish --lua from the forever-db release. Do not edit.\n");
	// This copy's Core.lua sets ns.LibForeverData only when it is the copy in use.
	let guard = "local _, ns = ...\nlocal L = ns and ns.LibForeverData\nif not L then return end\n";
	let mut files: Vec<(String, String)> = Vec::new();
	files.push(("LuaChunks.lua".into(), luachunks::READER.to_string()));
	files.push(("Core.lua".into(), core(dir, &version, &client)?));
	for (name, kinds) in FILES {
		let mut s = format!("{header}{guard}");
		for kind in *kinds {
			let chunks: Vec<Chunk> = luachunks::chunks(recs.get(kind).map(Vec::as_slice).unwrap_or(&[]), luachunks::Options::default());
			let body = luachunks::data_file("", "L._Add", kind, &chunks);
			s.push_str(&body);
		}
		files.push((format!("Data/{name}.lua"), s));
	}
	let toc = toc(&version, &client, files.iter().map(|(f, _)| f.as_str()));
	files.insert(0, (format!("{ADDON}.toc"), toc));
	for f in ["LICENSE", "LICENSE-CC-BY-4.0.txt", "NOTICE.md"] {
		if let Ok(t) = std::fs::read_to_string(dir.join(f)) {
			files.push((if f == "LICENSE" { "LICENSE.txt".into() } else { f.to_string() }, t));
		}
	}
	let mut bytes = 0u64;
	for (name, text) in &files {
		let p = out.join(name);
		std::fs::write(&p, text).map_err(io(&p))?;
		bytes += text.len() as u64;
	}
	Ok((files.len(), bytes))
}

fn toc<'a>(version: &str, client: &str, files: impl Iterator<Item = &'a str>) -> String {
	let mut s = format!(
		"## Interface: {INTERFACE}\n## Title: LibForeverData\n## Notes: World of Warcraft: Forever quest data (forever-db {version}, client {client}): quests, NPCs, objects, items, spawns and quest steps for other addons.\n## Author: Polestar contributors\n## Version: {API}.{version}\n## X-License: GPL-3.0 (the database); CC BY 4.0 (our own layer: quest steps and notes)\n## X-Credits: EG Link (Efficient Games, CC BY 4.0), CMaNGOS classic-db, VMaNGOS through pfQuest, pfQuest (Shagu, MIT), Factoruide, ForeverTDB, QuestieDB, the game client's tables; see NOTICE.md\n## X-Website: https://github.com/fitzforge/polestar/tree/main/forever-db\n## X-ForeverDB-Version: {version}\n## X-ForeverDB-ClientBuild: {client}\n\n"
	);
	for f in files {
		s.push_str(&f.replace('/', "\\"));
		s.push('\n');
	}
	s
}

/// Core.lua: the API, the map frames, the version guard.
fn core(dir: &Path, version: &str, client: &str) -> Result<String, String> {
	let mut frames = String::new();
	for r in rows(dir, "ui_map")? {
		frames.push_str(&format!(
			"\t{{ {}, {}, {}, {}, {}, {} }},\n",
			num_text(r.get("ui_map")),
			num_text(r.get("map")),
			num_text(r.get("left")),
			num_text(r.get("right")),
			num_text(r.get("top")),
			num_text(r.get("bottom"))
		));
	}
	let (y, m, n) = {
		let p: Vec<u64> = version.split('.').filter_map(|x| x.parse().ok()).collect();
		(p.first().copied().unwrap_or(0), p.get(1).copied().unwrap_or(0), p.get(2).copied().unwrap_or(0))
	};
	let rank = ((u64::from(API) * 10_000 + y) * 100 + m) * 1000 + n;
	Ok(CORE.replace("@VERSION@", version).replace("@CLIENT@", client).replace("@API@", &API.to_string()).replace("@RANK@", &rank.to_string()).replace("@FRAMES@", &frames))
}

const CORE: &str = include_str!("lua_core.lua");

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn points_pack_to_eleven_digits() {
		let p = point(0, -9500.0, -8500.5, Some(40.2)).unwrap();
		assert_eq!(p.len(), 11);
		assert_eq!(point(1, 0.0, 0.0, None).unwrap(), format!("01{}{}///", fixed(OFFSET as u64, 3), fixed(OFFSET as u64, 3)));
		assert!(point(0, 70000.0, 0.0, None).is_err());
	}
}
