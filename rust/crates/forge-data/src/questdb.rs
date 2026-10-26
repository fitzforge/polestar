//! `forge data questdb` (ported from the JS questdb build, now retired): data/forever (quests, npcs, objects, items,
//! map-frames) -> the load-on-demand addon addon/Polestar_QuestDB: a compact quest database for Polestar's
//! quest markers, available-quest markers, tooltips and nameplate icons (runtime: addon/Polestar/Quests).
//! Same inputs give byte-identical files.
//!
//! Each kind's records are LuaChunks strings (forge-core luachunks: chunks of lines "<id>\t<payload>",
//! registered with Polestar.QuestDB.AddChunk): nothing is built at load, a record is decoded when it is
//! read (QuestDB.lua). The payload is the record's fields ([`payload`]); decoded, a record is the positional
//! table below, as the table files of schema 1 held it.
//!
//! Records (positional, read by addon/Polestar/Quests/QuestDB.lua):
//!
//!   quests[id]  = { title, level, minLevel, races, classes, faction, start, finish,
//!                   startItem, pre, excl, objectives, zone, events, skill, holiday,
//!                   preAll, raceHigh, items }
//!     races     the race mask's low 32 bits (the Era races), for bit.band
//!     raceHigh  the mask's Skyborne bits as a number: +1 High Order (Alliance,
//!               mask bit 2^32), +2 Windshaper (Horde, 2^33). 3 for a pfQuest-only
//!               (Era) mask, which never excludes Skyborne; nil when races is nil
//!     faction   1 Alliance, 2 Horde, nil either (from the race mask, else the givers)
//!     start/finish  one ref or a list of refs: NPC id > 0, object id < 0
//!     startItem one item id or a list; excl: one id or a list
//!     items     the items the quest hands over (QuestieDB's sourceItemId and
//!               requiredSourceItems: Bethor's Scroll for Thule Ravenclaw), one
//!               id or a list; never its rewards
//!     pre / preAll  blocking prerequisites (forge-guide prereqs, breadcrumbs
//!               dropped): one of `pre` must be done, and every one of `preAll`
//!     objectives  flat triples kind, id, count: kind 1 kill (npc), 2 item, 3 object,
//!                 4 event (id = 1-based group in `events`, count nil)
//!     events    flat quads map, frame, x, y (frame 0 Era, 1 live)
//!     skill     required profession skill line; holiday: event id (never "available")
//!   npcs[id]    = { name, map, frame, n, x1, y1, r1, ..., map, frame, n, ... }
//!   objects[id] = same as npcs
//!     n clusters per map, together covering every known spawn there (the
//!     reference data's `pts` and `more`); x, y map percent (frame 0 = Era,
//!     1 = live), r yards
//!   items[id]   = { name, nNpc, npc, chance, ..., nObj, object, chance, ..., vendor, ... }
//!     chance in percent, best first; vendors to the end of the record

use std::collections::{BTreeMap, BTreeSet};
use std::path::{Path, PathBuf};

use forge_guide::cluster::cluster_points;
use forge_guide::js::{num_str, parse_json, V};
use forge_guide::prereqs::blocking_prereqs;

pub const ADDON: &str = "Polestar_QuestDB";
pub const SCHEMA: u32 = 2;
pub const COMMAND: &str = "forge data questdb";
const DATA_FILES: [&str; 5] = ["MapFrames.lua", "Quests.lua", "Npcs.lua", "Objects.lua", "Items.lua"];

/// FACTION_RACES (forge-guide races): the Era races' mask bits per side.
const ALLIANCE: u32 = 77;
const HORDE: u32 = 178;

/// Tunables (the JS DEFAULTS).
#[derive(Clone, Debug)]
pub struct Options {
	/// yards: points closer than this to a centroid join it
	pub cluster_radius: f64,
	/// NPC drop sources per item (best chance first)
	pub max_droppers: usize,
	/// object sources per item
	pub max_object_sources: usize,
	/// vendors per item
	pub max_vendors: usize,
}

impl Default for Options {
	fn default() -> Self {
		Options { cluster_radius: 70.0, max_droppers: 8, max_object_sources: 6, max_vendors: 4 }
	}
}

/// A value of a record.
#[derive(Clone, Debug, PartialEq)]
pub enum Val {
	Nil,
	Num(f64),
	Str(String),
	List(Vec<Val>),
}

pub type Rec = Vec<Val>;

/// The database: records by id (ascending), and the Era frames of the maps it places points on.
#[derive(Clone, Debug, Default)]
pub struct Db {
	pub quests: BTreeMap<i64, Rec>,
	pub npcs: BTreeMap<i64, Rec>,
	pub objects: BTreeMap<i64, Rec>,
	pub items: BTreeMap<i64, Rec>,
	pub map_frames: BTreeMap<i64, V>,
}

#[derive(Clone, Debug, Default)]
pub struct Stats {
	pub quests: usize,
	pub npcs: usize,
	pub objects: usize,
	pub items: usize,
	pub maps: usize,
	pub spawn_points: usize,
	pub clusters: usize,
	pub lua_bytes: usize,
	pub memory_bytes: usize,
}

pub struct Output {
	pub db: Db,
	/// (file name, text), in the order written
	pub files: Vec<(String, String)>,
	pub stats: Stats,
	pub warnings: Vec<String>,
}

fn read_json(file: &Path) -> Result<V, String> {
	if !file.exists() {
		return Err(format!("missing {} (run: forge data build)", file.display()));
	}
	let text = std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?;
	parse_json(&text).map_err(|e| format!("{}: {e}", file.display()))
}

/// `Object.keys(obj).map(Number).filter(Number.isFinite).sort(byNum)`
fn ids(o: &V) -> Vec<i64> {
	let mut out: Vec<f64> = o.keys().iter().map(|k| forge_guide::js::str_to_num(k)).filter(|n| n.is_finite()).collect();
	out.sort_by(|a, b| a.partial_cmp(b).unwrap());
	out.into_iter().map(|n| n as i64).collect()
}

/// `Array.isArray(v) ? v.filter(Number.isFinite) : []`
fn list(v: &V) -> Vec<f64> {
	if !v.is_arr() {
		return Vec::new();
	}
	v.items()
		.iter()
		.filter_map(|x| match x {
			V::Num(n) if n.is_finite() => Some(*n),
			_ => None,
		})
		.collect()
}

fn one_or_list(v: &[f64]) -> Val {
	match v.len() {
		0 => Val::Nil,
		1 => Val::Num(v[0]),
		_ => Val::List(v.iter().map(|n| Val::Num(*n)).collect()),
	}
}

fn finite(v: &V) -> Option<f64> {
	match v {
		V::Num(n) if n.is_finite() => Some(*n),
		_ => None,
	}
}

fn num_or_nil(v: &V) -> Val {
	finite(v).map_or(Val::Nil, Val::Num)
}

fn round_chance(c: f64) -> f64 {
	if !c.is_finite() {
		return 0.0;
	}
	if c < 1.0 {
		forge_guide::js::math_round(c * 100.0) / 100.0
	} else {
		forge_guide::js::math_round(c * 10.0) / 10.0
	}
}

/// Race masks may carry Forever's Skyborne bits, 2^32 (Alliance) and 2^33 (Horde): split arithmetically.
fn race_parts(races: f64) -> (f64, f64) {
	(races.rem_euclid(4294967296.0), (races / 4294967296.0).floor())
}

/// `x & ~mask` in JS (ToInt32 on both) == 0
fn bits_clear(x: f64, allowed: u32) -> bool {
	let i = (x.rem_euclid(4294967296.0)) as u64 as u32;
	i & !allowed == 0
}

pub fn quest_faction(q: &V, npcs: &V) -> Val {
	let races = q.get("races");
	if races.truthy() {
		let (low, high) = race_parts(races.num());
		if bits_clear(low, ALLIANCE) && bits_clear(high, 1) {
			return Val::Num(1.0);
		}
		if bits_clear(low, HORDE) && bits_clear(high, 2) {
			return Val::Num(2.0);
		}
		return Val::Nil;
	}
	let start = q.get("start");
	let givers = if start.truthy() { list(&start.get("npc")) } else { Vec::new() };
	if givers.is_empty() {
		return Val::Nil;
	}
	let mut side = 0;
	for id in givers {
		let n = npcs.get(&num_str(id));
		let f = if n.truthy() { n.get("faction") } else { V::Undef };
		let s = match f.as_str() {
			Some("A") => 1,
			Some("H") => 2,
			_ => 0,
		};
		if s == 0 || (side != 0 && side != s) {
			return Val::Nil;
		}
		side = s;
	}
	Val::Num(side as f64)
}

/// Sorted top-N sources from { "<id>": chance } (ties by id).
fn top_sources(drops: &V, cap: usize) -> Vec<(f64, f64)> {
	let mut out: Vec<(f64, f64)> =
		if drops.is_object() { drops.entries().into_iter().map(|(k, c)| (forge_guide::js::str_to_num(&k), round_chance(c.num()))).filter(|(id, _)| id.is_finite()).collect() } else { Vec::new() };
	out.sort_by(|a, b| {
		let d = b.1 - a.1;
		if d != 0.0 && !d.is_nan() {
			return d.partial_cmp(&0.0).unwrap();
		}
		a.0.partial_cmp(&b.0).unwrap()
	});
	out.truncate(cap);
	out
}

fn field<'a>(v: &V, a: &'a str, b: &'a str) -> V {
	let x = v.get(a);
	if x.truthy() {
		x.get(b)
	} else {
		V::Undef
	}
}

pub fn build(data_dir: &Path, root: &Path, o: &Options) -> Result<Output, String> {
	let quests = read_json(&data_dir.join("quests.json"))?;
	let npcs = read_json(&data_dir.join("npcs.json"))?;
	let objects = read_json(&data_dir.join("objects.json"))?;
	let items = read_json(&data_dir.join("items.json"))?;
	let map_frames_json = read_json(&data_dir.join("map-frames.json"))?;
	let frames = map_frames_json.get("era");
	let frames = if frames.truthy() { frames } else { V::obj() };
	// Live points on a map Forever added (Zephras Isle, Riverglades) are clustered in yards through its
	// Forever frame: it has no Era one.
	let forever = map_frames_json.get("forever");
	let forever = if forever.truthy() { forever } else { V::obj() };
	let meta_file = data_dir.join("meta.json");
	let meta = if meta_file.exists() { read_json(&meta_file)? } else { V::obj() };
	let mut warnings = Vec::new();

	let mut want_npc = BTreeSet::new();
	let mut want_object = BTreeSet::new();
	let mut want_item = BTreeSet::new();
	let mut used_maps = BTreeSet::new();

	// --- quests
	let mut quest_records = BTreeMap::new();
	let quest_of = |p: &V| {
		let q = quests.get(&p.to_js_string());
		if q.truthy() {
			q
		} else {
			V::Null
		}
	};
	let has_quest = |p: f64| quests.get(&num_str(p)).truthy();
	for id in ids(&quests) {
		let q = quests.get(&id.to_string());
		if !q.truthy() || !q.get("title").is_str() {
			continue;
		}
		let neg = |v: Vec<f64>| v.into_iter().map(|o| -o).collect::<Vec<f64>>();
		let mut start = list(&field(&q, "start", "npc"));
		start.extend(neg(list(&field(&q, "start", "object"))));
		let mut finish = list(&field(&q, "end", "npc"));
		finish.extend(neg(list(&field(&q, "end", "object"))));
		for r in start.iter().chain(finish.iter()) {
			if *r > 0.0 {
				want_npc.insert(r.abs() as i64);
			} else {
				want_object.insert(r.abs() as i64);
			}
		}
		let start_items = list(&field(&q, "start", "item"));
		for it in &start_items {
			want_item.insert(*it as i64);
		}

		let mut objectives = Vec::new();
		let mut events = Vec::new();
		let objs = q.get("objectives");
		for ob in if objs.is_arr() { objs.items() } else { Vec::new() } {
			let kind = match ob.get("type").as_str() {
				Some("kill") => 1,
				Some("item") => 2,
				Some("object") => 3,
				Some("event") => 4,
				_ => continue,
			};
			if kind == 4 {
				let (map, x, y) = (finite(&ob.get("map")), finite(&ob.get("x")), finite(&ob.get("y")));
				let (Some(map), Some(x), Some(y)) = (map, x, y) else {
					objectives.extend([Val::Num(4.0), Val::Num(0.0), Val::Nil]);
					continue;
				};
				let live = ob.get("f").as_str() == Some("l");
				events.extend([Val::Num(map), Val::Num(if live { 1.0 } else { 0.0 }), Val::Num(forge_guide::js::math_round(x * 10.0) / 10.0), Val::Num(forge_guide::js::math_round(y * 10.0) / 10.0)]);
				if !live {
					used_maps.insert(map as i64);
				}
				objectives.extend([Val::Num(4.0), Val::Num((events.len() / 4) as f64), Val::Nil]);
				continue;
			}
			let Some(oid) = finite(&ob.get("id")) else { continue };
			objectives.extend([Val::Num(kind as f64), Val::Num(oid), num_or_nil(&ob.get("count"))]);
			match kind {
				1 => want_npc.insert(oid as i64),
				2 => want_item.insert(oid as i64),
				_ => want_object.insert(oid as i64),
			};
		}

		let pre = blocking_prereqs(&q, &quest_of);
		let pre_all: Vec<f64> = list(&pre.get("all")).into_iter().filter(|p| has_quest(*p)).collect();
		let pre_any: Vec<f64> = list(&pre.get("any")).into_iter().filter(|p| has_quest(*p)).collect();
		// Only QuestieDB's Forever store carries the Skyborne bits; a pfQuest mask is an Era mask.
		let source = q.get("source");
		let is_forever = source.is_arr() && source.items().iter().any(|s| s.to_js_string().starts_with("questie"));
		let races = q.get("races");
		let skill = q.get("skill").num();
		let event = q.get("event");
		let mut handed: Vec<f64> = list(&V::from(vec![q.get("sourceItem")]));
		handed.extend(list(&q.get("requiredItems")));
		let mut seen = BTreeSet::new();
		handed.retain(|n| seen.insert(n.to_bits()));
		handed.sort_by(|a, b| a.partial_cmp(b).unwrap());
		let classes = q.get("classes");
		quest_records.insert(
			id,
			vec![
				Val::Str(q.get("title").to_js_string()),
				num_or_nil(&q.get("level")),
				num_or_nil(&q.get("minLevel")),
				if races.truthy() { Val::Num(race_parts(races.num()).0) } else { Val::Nil },
				if classes.truthy() { Val::Num(classes.num()) } else { Val::Nil },
				quest_faction(&q, &npcs),
				one_or_list(&start),
				one_or_list(&finish),
				one_or_list(&start_items),
				one_or_list(&pre_any),
				one_or_list(&list(&q.get("excl")).into_iter().filter(|p| has_quest(*p)).collect::<Vec<f64>>()),
				if objectives.is_empty() { Val::Nil } else { Val::List(objectives) },
				num_or_nil(&q.get("zone")),
				if events.is_empty() { Val::Nil } else { Val::List(events) },
				if skill.is_finite() && q.get("skill").truthy() { Val::Num(skill) } else { Val::Nil },
				if event.truthy() {
					let n = event.num();
					Val::Num(if n != 0.0 && !n.is_nan() { n } else { 1.0 })
				} else {
					Val::Nil
				},
				one_or_list(&pre_all),
				if races.truthy() { Val::Num(if is_forever { race_parts(races.num()).1 } else { 3.0 }) } else { Val::Nil },
				one_or_list(&handed),
			],
		);
	}

	// --- items (their sources pull in more NPCs and objects)
	let mut item_records = BTreeMap::new();
	for id in want_item.clone() {
		let it = items.get(&id.to_string());
		if !it.truthy() {
			warnings.push(format!("item {id} referenced by a quest is missing from items.json"));
			continue;
		}
		let droppers = top_sources(&field(&it, "drops", "npc"), o.max_droppers);
		let obj_sources = top_sources(&field(&it, "drops", "object"), o.max_object_sources);
		let mut vendors = list(&it.get("vendors"));
		vendors.sort_by(|a, b| a.partial_cmp(b).unwrap());
		vendors.truncate(o.max_vendors);
		for (n, _) in &droppers {
			want_npc.insert(*n as i64);
		}
		for (ob, _) in &obj_sources {
			want_object.insert(*ob as i64);
		}
		for v in &vendors {
			want_npc.insert(*v as i64);
		}
		let name = it.get("name");
		let mut rec = vec![Val::Str(if name.truthy() { name.to_js_string() } else { format!("Item {id}") }), Val::Num(droppers.len() as f64)];
		for (a, b) in &droppers {
			rec.extend([Val::Num(*a), Val::Num(*b)]);
		}
		rec.push(Val::Num(obj_sources.len() as f64));
		for (a, b) in &obj_sources {
			rec.extend([Val::Num(*a), Val::Num(*b)]);
		}
		rec.extend(vendors.iter().map(|v| Val::Num(*v)));
		item_records.insert(id, rec);
	}

	// --- NPCs and objects with clustered spawns
	let mut spawn_points = 0;
	let mut cluster_count = 0;
	let mut entity_record = |e: &V, used_maps: &mut BTreeSet<i64>| -> Rec {
		let name = e.get("name");
		let mut rec = vec![if name.is_nullish() { Val::Nil } else { Val::Str(name.to_js_string()) }];
		let spawns = e.get("spawns");
		let spawns = if spawns.truthy() { spawns } else { V::obj() };
		for map in ids(&spawns) {
			let s = spawns.get(&map.to_string());
			let live = s.get("f").as_str() == Some("l");
			let f = frames.get(&map.to_string());
			let frame = if f.truthy() {
				f
			} else if live {
				forever.get(&map.to_string())
			} else {
				V::Undef
			};
			if !live && !frame.truthy() {
				continue; // an Era point without an Era frame cannot be placed
			}
			// Every known spawn, so every place the entity spawns gets a marker.
			let mut pts = if s.get("pts").is_arr() { s.get("pts").items() } else { Vec::new() };
			if s.get("more").is_arr() {
				pts.extend(s.get("more").items());
			}
			let clusters = cluster_points(&pts, &frame, o.cluster_radius, f64::INFINITY, 0.0);
			if clusters.is_empty() {
				continue;
			}
			spawn_points += pts.len();
			cluster_count += clusters.len();
			if !live {
				used_maps.insert(map);
			}
			rec.extend([Val::Num(map as f64), Val::Num(if live { 1.0 } else { 0.0 }), Val::Num(clusters.len() as f64)]);
			for c in &clusters {
				rec.extend([Val::Num(c.get("x").num()), Val::Num(c.get("y").num()), Val::Num(c.get("r").num())]);
			}
		}
		rec
	};
	let mut npc_records = BTreeMap::new();
	for id in &want_npc {
		let n = npcs.get(&id.to_string());
		if n.truthy() {
			npc_records.insert(*id, entity_record(&n, &mut used_maps));
		}
	}
	let mut object_records = BTreeMap::new();
	for id in &want_object {
		let ob = objects.get(&id.to_string());
		if ob.truthy() {
			object_records.insert(*id, entity_record(&ob, &mut used_maps));
		}
	}

	let mut map_frames = BTreeMap::new();
	for map in &used_maps {
		let f = frames.get(&map.to_string());
		if f.truthy() {
			map_frames.insert(*map, f);
		} else {
			warnings.push(format!("map {map} has Era-frame data but no Era frame"));
		}
	}

	let db = Db { quests: quest_records, npcs: npc_records, objects: object_records, items: item_records, map_frames };
	let files = emit_files(&db, &meta, root);
	let lua_bytes = files.iter().filter(|(n, _)| n.ends_with(".lua")).map(|(_, t)| t.len()).sum();
	let stats = Stats {
		quests: db.quests.len(),
		npcs: db.npcs.len(),
		objects: db.objects.len(),
		items: db.items.len(),
		maps: db.map_frames.len(),
		spawn_points,
		clusters: cluster_count,
		lua_bytes,
		memory_bytes: estimate_memory(&db),
	};
	Ok(Output { db, files, stats, warnings })
}

// --- Lua emission

fn lua_num(n: f64) -> String {
	assert!(n.is_finite(), "non-finite number in quest data: {n}");
	if n == 0.0 {
		"0".into()
	} else {
		num_str(n)
	}
}

fn header() -> String {
	forge_guide::emit::header("lua", COMMAND, "data/forever")
}

/// A record as one LuaChunks payload (forge-core luachunks): its fields joined by `;`, trailing nils dropped;
/// a field is empty for nil, a number as JS prints it (`String(n)`, the Lua literal the table files had),
/// `'` and the text for a string (separators `%XX`-escaped, luachunks::field), `{` and the elements joined
/// by `,` for a list (numbers or empty for nil, trailing nils dropped). QuestDB.lua's `decode` reads it back
/// into the same positional table.
pub fn payload(rec: &[Val]) -> String {
	fn trimmed(l: &[Val]) -> &[Val] {
		let mut end = l.len();
		while end > 0 && l[end - 1] == Val::Nil {
			end -= 1;
		}
		&l[..end]
	}
	let field = |v: &Val| -> String {
		match v {
			Val::Nil => String::new(),
			Val::Num(n) => lua_num(*n),
			Val::Str(s) => format!("'{}", forge_core::luachunks::field(s)),
			Val::List(l) => {
				let items: Vec<String> = trimmed(l)
					.iter()
					.map(|x| match x {
						Val::Nil => String::new(),
						Val::Num(n) => lua_num(*n),
						other => panic!("questdb: a list holds numbers only, not {other:?}"),
					})
					.collect();
				format!("{{{}", items.join(","))
			}
		}
	};
	trimmed(rec).iter().map(field).collect::<Vec<_>>().join(";")
}

fn data_file(kind: &str, records: &BTreeMap<i64, Rec>, comment: &str) -> String {
	let head = format!("{}\n-- {comment}\n-- One record a line, \"<id>\\t<fields>\" (forge-data questdb.rs payload), read on demand.\n\nlocal Q = Polestar and Polestar.QuestDB\nif not (Q and Q.AddChunk) then return end\n", header());
	let recs: Vec<(i64, String)> = records.iter().map(|(id, rec)| (*id, payload(rec))).collect();
	let chunks = forge_core::luachunks::chunks(&recs, forge_core::luachunks::Options::default());
	forge_core::luachunks::data_file(&head, "Q.AddChunk", kind, &chunks)
}

fn license_text(meta: &V) -> String {
	let mut out: Vec<String> = [
		"Polestar quest database: third-party notices",
		"============================================",
		"",
		"The data in this folder was generated for Polestar from the reference data",
		"sources below (quest, NPC, object and item facts, spawn positions, map frames).",
		"",
	]
	.iter()
	.map(|s| s.to_string())
	.collect();
	let sources = meta.get("sources");
	for s in if sources.is_arr() { sources.items() } else { Vec::new() } {
		let title = if s.get("name").truthy() { s.get("name").to_js_string() } else { "source".into() };
		out.push(title.clone());
		out.push("-".repeat(title.encode_utf16().count()));
		for (k, label) in [("url", "URL"), ("revision", "Revision"), ("license", "License")] {
			if s.get(k).truthy() {
				out.push(format!("{label}: {}", s.get(k).to_js_string()));
			}
		}
		if s.get("notice").truthy() {
			out.push(String::new());
			out.push(s.get("notice").to_js_string().trim().to_string());
		}
		out.push(String::new());
	}
	out.join("\n")
}

fn emit_files(db: &Db, meta: &V, root: &Path) -> Vec<(String, String)> {
	let mut files = Vec::new();
	let mut toc = vec![
		"## Interface: 16001".to_string(),
		"## Title: Polestar Quest Database".into(),
		"## Notes: Quest, NPC, object and item data for Polestar's quest markers and tooltips. Loaded on demand.".into(),
	];
	toc.extend(forge_guide::toc::toc_lines(ADDON));
	toc.extend([
		"## Author: Polestar".to_string(),
		format!("## Version: {}", crate::gear::package_version(root)),
		"## Category: Polestar".into(),
		"## Group: Polestar".into(),
		"## LoadOnDemand: 1".into(),
		"## Dependencies: Polestar".into(),
		String::new(),
	]);
	toc.extend(DATA_FILES.iter().map(|s| s.to_string()));
	toc.push(String::new());
	files.push((format!("{ADDON}.toc"), toc.join("\n")));
	let mut frame = vec![
		header(),
		"-- Era map frames for every map this database places points on.".into(),
		String::new(),
		"local Q = Polestar and Polestar.QuestDB".into(),
		"if not (Q and Q.SetMeta) then return end".into(),
		String::new(),
	];
	frame.push(format!("Q.SetMeta({{items={},npcs={},objects={},quests={},schema={SCHEMA}}})", db.items.len(), db.npcs.len(), db.objects.len(), db.quests.len()));
	frame.push(String::new());
	frame.push("if Polestar.RegisterMapFrames then".into());
	frame.push("\tPolestar.RegisterMapFrames({ era = {".into());
	for (map, f) in &db.map_frames {
		let n = |k: &str| lua_num(f.get(k).num());
		frame.push(format!("\t\t[{map}] = {{bottom={},c={},left={},right={},top={}}},", n("bottom"), n("c"), n("left"), n("right"), n("top")));
	}
	frame.push("\t} })".into());
	frame.push("end".into());
	files.push(("MapFrames.lua".into(), frame.join("\n") + "\n"));
	files.push(("Quests.lua".into(), data_file("quests", &db.quests, "title, level, minLevel, races, classes, faction, start, finish, startItem, pre (one of), excl, objectives, zone, events, skill, holiday, preAll (every one), raceHigh, items (handed over)")));
	files.push(("Npcs.lua".into(), data_file("npcs", &db.npcs, "name, then per map: uiMapID, frame (0 Era, 1 live), cluster count, x, y, radius (yd) per cluster")));
	files.push(("Objects.lua".into(), data_file("objects", &db.objects, "name, then per map: uiMapID, frame (0 Era, 1 live), cluster count, x, y, radius (yd) per cluster")));
	files.push(("Items.lua".into(), data_file("items", &db.items, "name, NPC source count, (npc, chance)..., object source count, (object, chance)..., vendors...")));
	files.push(("LICENSE-DATA.txt".into(), license_text(meta)));
	files
}

/// In-game memory estimate once loaded (Lua 5.1, 64-bit client): the chunk strings (25 B + length each) and
/// their entries in the store (a 3-slot table each, 56 + 3 x 16 B, and its slot in the kind's list); the
/// records decoded on demand are garbage the weak cache lets go. Plus 10% allocator overhead.
pub fn estimate_memory(db: &Db) -> usize {
	let mut bytes = 0usize;
	for m in [&db.quests, &db.npcs, &db.objects, &db.items] {
		let recs: Vec<(i64, String)> = m.iter().map(|(id, rec)| (*id, payload(rec))).collect();
		for c in forge_core::luachunks::chunks(&recs, forge_core::luachunks::Options::default()) {
			bytes += 25 + c.text.len() + 56 + 3 * 16 + 16;
		}
	}
	forge_guide::js::math_round(bytes as f64 * 1.1) as usize
}

/// Writes the files into `out` and removes any other .lua file there.
pub fn write(out: &Output, dir: &Path) -> Result<(), String> {
	std::fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
	let keep: BTreeSet<&str> = out.files.iter().map(|(n, _)| n.as_str()).collect();
	for e in std::fs::read_dir(dir).map_err(|e| format!("{}: {e}", dir.display()))? {
		let p: PathBuf = e.map_err(|e| e.to_string())?.path();
		let name = p.file_name().and_then(|n| n.to_str()).unwrap_or("").to_string();
		if name.ends_with(".lua") && !keep.contains(name.as_str()) {
			std::fs::remove_file(&p).map_err(|e| format!("{}: {e}", p.display()))?;
		}
	}
	for (name, text) in &out.files {
		std::fs::write(dir.join(name), text).map_err(|e| format!("{name}: {e}"))?;
	}
	Ok(())
}
