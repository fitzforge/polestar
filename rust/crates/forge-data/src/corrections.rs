//! Polestar's corrections (forever-db/corrections/<section>.json) applied to the merged tables,
//! with or without Forever's quest data. A correction for a record the build does not have becomes
//! that record when it carries enough fields to stand alone; otherwise it is reported as unused.
//!
//! What "enough" means:
//! - a quest: `set` gives `title`, `start` and `end`;
//! - an NPC or an object: `set` gives `name`, and `addSpawns` (or `set.spawns`) gives where it is;
//! - an item: never (an item correction only removes wrong sources from an existing record).

use forge_guide::js::{num_str, str_to_num, stringify, Obj, Str, V};

use crate::jsv::arr;

/// The source every corrected or created record gains.
pub const SOURCE: &str = "polestar-correction";
/// The kinds of independent evidence a public correction's `source` names.
pub const SOURCE_KINDS: [&str; 9] = ["recording", "in-game-check", "client", "eg", "cmangos", "tdb", "questie", "pfquest", "factoruide"];

/// The sections of the corrections: one file each in forever-db/corrections (`quests.json` holds
/// the `quests` object, ...), one key each in the old single-file form.
pub const SECTIONS: [&str; 5] = ["quests", "npcs", "objects", "items", "mechanics"];

/// The corrections folder of a checkout.
pub const DIR: &str = "forever-db/corrections";

/// The old single-file place, still read for one release when a checkout has no `DIR`.
pub const OLD_FILE: &str = "tools/lib/data/corrections.json";

/// A checkout's corrections: `DIR`, else the old single file when there is one, else `DIR` (absent).
pub fn locate(root: &std::path::Path) -> std::path::PathBuf {
	let dir = root.join(DIR);
	let old = root.join(OLD_FILE);
	if !dir.is_dir() && old.is_file() {
		return old;
	}
	dir
}

/// The corrections as one JSON text `{ "quests": …, … }`: a folder's section files (a missing file
/// is an empty section) joined with each file's text kept as written (so a key written twice is
/// still seen), or a single file's text.
pub fn read_text(path: &std::path::Path) -> Result<String, String> {
	if !path.is_dir() {
		return std::fs::read_to_string(path).map_err(|e| format!("{}: {e}", path.display()));
	}
	let mut s = String::from("{");
	for (i, sec) in SECTIONS.iter().enumerate() {
		let f = path.join(format!("{sec}.json"));
		let text = match std::fs::read_to_string(&f) {
			Ok(t) => t,
			Err(e) if e.kind() == std::io::ErrorKind::NotFound => "{}".into(),
			Err(e) => return Err(format!("{}: {e}", f.display())),
		};
		s.push_str(&format!("{}\n\"{sec}\": {}", if i > 0 { "," } else { "" }, text.trim()));
	}
	s.push_str("\n}\n");
	Ok(s)
}

/// The corrections at `path` (a folder of section files or a single file), parsed.
pub fn load(path: &std::path::Path) -> Result<V, String> {
	forge_guide::js::parse_json(&read_text(path)?).map_err(|e| format!("{}: {e}", path.display()))
}

/// What applying the corrections did.
#[derive(Clone, Debug, Default)]
pub struct Applied {
	/// Records corrected or created.
	pub records: usize,
	/// Records the corrections created (absent from every other source).
	pub created: usize,
	/// Corrections that matched nothing and could not stand alone, as `"<section> <id>: <why>"`.
	pub unused: Vec<String>,
	/// Every correction and what it did, in the file's order (the build's fixes ledger).
	pub entries: Vec<Entry>,
}

/// What one correction did: `applied` (it changed the record), `created` (it is the record),
/// `redundant` (the merged sources already say the same: it can go) or `unused` (it matched nothing
/// and cannot stand alone).
#[derive(Clone, Debug)]
pub struct Entry {
	pub section: &'static str,
	pub id: String,
	pub state: &'static str,
	pub detail: String,
}

/// Whether every field of `set` already has that value in `e`.
fn same_fields(e: &V, set: &V) -> bool {
	set.entries().iter().all(|(k, v)| stringify(&e.get(k), None) == stringify(v, None))
}

fn tag(e: &V) {
	if !e.get("source").is_arr() {
		e.set("source", V::arr());
	}
	let s = e.get("source");
	if !s.items().iter().any(|x| x.as_str() == Some(SOURCE)) {
		s.push(SOURCE);
	}
}

fn has_text(v: &V) -> bool {
	v.as_str().is_some_and(|s| !s.trim().is_empty())
}

/// The fields a quest correction lacks to be a record of its own (empty: it can stand alone).
pub fn quest_lacks(c: &V) -> Vec<&'static str> {
	let set = c.get("set");
	let mut out = Vec::new();
	if !has_text(&set.get("title")) {
		out.push("title");
	}
	for k in ["start", "end"] {
		if !set.get(k).is_obj() {
			out.push(k);
		}
	}
	out
}

/// The fields an NPC or object correction lacks to be a record of its own.
pub fn spawner_lacks(c: &V) -> Vec<&'static str> {
	let mut out = Vec::new();
	if !has_text(&c.get("set").get("name")) {
		out.push("name");
	}
	if !c.get("addSpawns").is_obj() && !c.get("set").get("spawns").is_obj() {
		out.push("addSpawns");
	}
	out
}

/// A new quest record with the fields every quest has (normalize.rs's order), before `set`.
fn new_quest(id: f64) -> V {
	let q = Obj::new();
	q.set("id", id);
	q.set("title", V::Null);
	q.set("level", V::Null);
	q.set("minLevel", V::Null);
	q.set("races", V::Null);
	q.set("classes", V::Null);
	let st = Obj::new();
	st.set("npc", V::arr());
	st.set("object", V::arr());
	st.set("item", V::arr());
	q.set("start", st);
	let en = Obj::new();
	en.set("npc", V::arr());
	en.set("object", V::arr());
	q.set("end", en);
	q.set("pre", V::arr());
	q.set("excl", V::arr());
	q.set("next", V::Null);
	q.set("objectives", V::arr());
	q.set("objectiveText", V::Null);
	q.set("zone", V::Null);
	q.set("xp", V::Null);
	q.set("skill", V::Null);
	q.set("event", V::Null);
	q.set("source", V::arr());
	V::Obj(q)
}

/// A new NPC or object record (normalize.rs's fields), before `set` and `addSpawns`.
fn new_spawner(id: f64, npc: bool) -> V {
	let e = Obj::new();
	e.set("id", id);
	e.set("name", V::Null);
	if npc {
		e.set("level", V::Null);
		e.set("faction", V::Null);
	}
	e.set("spawns", Obj::new());
	e.set("source", V::arr());
	V::Obj(e)
}

fn why(lacks: &[&str]) -> String {
	format!("no such record, and the correction lacks {} to stand alone", lacks.join(", "))
}

/// corrections.json applied to the merged tables (quests, npcs, objects, items).
pub fn apply(c: &V, quests: &Obj, npcs: &Obj, objects: &Obj, items: &Obj, sim: bool) -> Applied {
	let mut a = Applied::default();
	let entry = |a: &mut Applied, section: &'static str, id: &str, state: &'static str, detail: String| a.entries.push(Entry { section, id: id.to_string(), state, detail });
	for (id, cq) in c.get("quests").entries() {
		let mut q = quests.get(&id);
		if q.is_undef() {
			let lacks = quest_lacks(&cq);
			if !lacks.is_empty() {
				a.unused.push(format!("quests {id}: {}", why(&lacks)));
				entry(&mut a, "quests", &id, "unused", why(&lacks));
				continue;
			}
			q = new_quest(str_to_num(&id));
			quests.set(&id, q.clone());
			a.created += 1;
			entry(&mut a, "quests", &id, "created", String::new());
		} else if same_fields(&q, &cq.get("set")) {
			entry(&mut a, "quests", &id, "redundant", "the merged sources already give every field it sets".into());
		} else {
			entry(&mut a, "quests", &id, "applied", String::new());
		}
		for (k, v) in cq.get("set").entries() {
			q.set(&k, v);
		}
		tag(&q);
		a.records += 1;
	}
	for (id, ci) in c.get("items").entries() {
		let it = items.get(&id);
		if it.is_undef() {
			a.unused.push(format!("items {id}: no such item (an item correction only removes sources)"));
			entry(&mut a, "items", &id, "unused", "no such item (an item correction only removes sources)".into());
			continue;
		}
		let drops_left = ["npc", "object"].iter().any(|kind| ci.get("removeDrops").get(kind).items().iter().any(|x| !it.get("drops").get(kind).get(&x.to_js_string()).is_undef()));
		let vendors_left = ci.get("removeVendors").items().iter().any(|r| it.get("vendors").items().iter().any(|v| r.strict_eq(v)));
		if drops_left || vendors_left {
			entry(&mut a, "items", &id, "applied", String::new());
		} else {
			entry(&mut a, "items", &id, "redundant", "no source it removes is in the merged data".into());
		}
		for kind in ["npc", "object"] {
			for x in ci.get("removeDrops").get(kind).items() {
				it.get("drops").get(kind).as_obj().map(|o| o.delete(&x.to_js_string()));
			}
		}
		// sim-v2: no rated dropper left, no scale either.
		if sim && it.has("dropScale") && !it.get("drops").get("npc").values().iter().any(|v| !v.is_nullish()) {
			it.set("dropScale", V::Null);
		}
		let rv = ci.get("removeVendors");
		if rv.truthy() {
			let keep: Vec<V> = it.get("vendors").items().into_iter().filter(|v| !rv.items().iter().any(|r| r.strict_eq(v))).collect();
			it.set("vendors", arr(keep));
		}
		tag(&it);
		a.records += 1;
	}
	for (kind, table) in [("npcs", npcs), ("objects", objects)] {
		for (id, ce) in c.get(kind).entries() {
			let mut e = table.get(&id);
			if e.is_undef() {
				let lacks = spawner_lacks(&ce);
				if !lacks.is_empty() {
					a.unused.push(format!("{kind} {id}: {}", why(&lacks)));
					entry(&mut a, kind, &id, "unused", why(&lacks));
					continue;
				}
				e = new_spawner(str_to_num(&id), kind == "npcs");
				table.set(&id, e.clone());
				a.created += 1;
				entry(&mut a, kind, &id, "created", String::new());
			} else if same_fields(&e, &ce.get("set")) && same_fields(&e.get("spawns"), &ce.get("addSpawns")) {
				entry(&mut a, kind, &id, "redundant", "the merged sources already give every field and spawn it sets".into());
			} else {
				entry(&mut a, kind, &id, "applied", String::new());
			}
			let set = ce.get("set");
			if set.truthy() {
				for (k, v) in set.entries() {
					e.set(&k, v);
				}
			}
			let add = ce.get("addSpawns");
			if add.truthy() {
				let merged = e.get("spawns").as_obj().map(|o| o.spread()).unwrap_or_default();
				for (k, v) in add.entries() {
					merged.set_str(k, v);
				}
				let mut keys: Vec<(f64, Str)> = merged.keys().into_iter().map(|k| (str_to_num(&k), k)).collect();
				keys.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap_or(std::cmp::Ordering::Equal));
				let s = Obj::new();
				for (num, k) in keys {
					s.set(&num_str(num), merged.get(&k));
				}
				e.set("spawns", s);
			}
			tag(&e);
			a.records += 1;
		}
	}
	a
}

// ---------------------------------------------------------------- checking an edit

/// One finding of [`check`].
#[derive(Clone, Debug)]
pub struct Finding {
	/// "error" or "warning".
	pub severity: &'static str,
	/// The file's label (forever-db/corrections, mechanics-public.json, route-fixes.json).
	pub file: String,
	/// Where in it, as a JSON path (`quests.1919.set.races`).
	pub at: String,
	pub message: String,
}

/// What [`check`] reads: each file's text (None: not checked) and the built tables (None: ids are
/// not checked against the data).
pub struct CheckInputs<'a> {
	pub corrections: Option<(&'a str, &'a str)>,
	pub mechanics: Option<(&'a str, &'a str)>,
	/// data/route-fixes.json: `deliberate` and `overrides`.
	pub route_fixes: Option<(&'a str, &'a str)>,
	/// data/places.json and data/guide-fixes.json (applied by forge-writer's fix pass).
	pub places: Option<(&'a str, &'a str)>,
	pub guide_fixes: Option<(&'a str, &'a str)>,
	pub data: Option<&'a Tables>,
}

/// The built tables an edit's ids are checked against (data/forever).
pub struct Tables {
	pub quests: V,
	pub npcs: V,
	pub objects: V,
	pub items: V,
	/// uiMapIDs with a map frame (map-frames.json).
	pub maps: V,
	/// uiMapIDs with Era bounds.
	pub era_maps: V,
}

impl Tables {
	/// The tables of a built data/forever (None when it has no quests.json).
	pub fn load(data_dir: &std::path::Path) -> Result<Option<Tables>, String> {
		if !data_dir.join("quests.json").is_file() {
			return Ok(None);
		}
		let table = |name: &str| -> Result<V, String> {
			let f = data_dir.join(format!("{name}.json"));
			let t = std::fs::read_to_string(&f).map_err(|e| format!("{}: {e}", f.display()))?;
			forge_guide::js::parse_json(&t).map_err(|e| format!("{}: {e}", f.display()))
		};
		let frames = table("map-frames")?;
		let (maps, era_maps) = (Obj::new(), Obj::new());
		for side in ["era", "forever"] {
			for k in frames.get(side).keys() {
				maps.set(&k, true);
				if side == "era" {
					era_maps.set(&k, true);
				}
			}
		}
		Ok(Some(Tables { quests: table("quests")?, npcs: table("npcs")?, objects: table("objects")?, items: table("items")?, maps: V::Obj(maps), era_maps: V::Obj(era_maps) }))
	}
}

/// The mechanics kinds the knowledge base and the simulator know.
pub const KINDS: [&str; 14] = [
	"escort",
	"timed",
	"summon-by-item",
	"use-item-at-place",
	"use-item-on-mob",
	"object-click",
	"vendor-buy",
	"crafted",
	"event-start",
	"group/elite",
	"item-from-other-quest",
	"multi-step-in-one-objective",
	"delayed-offer",
	"other",
];

const QUEST_FIELDS: [&str; 21] = [
	"title",
	"level",
	"minLevel",
	"races",
	"classes",
	"start",
	"end",
	"pre",
	"preAny",
	"preAll",
	"excl",
	"next",
	"objectives",
	"objectiveText",
	"zone",
	"xp",
	"skill",
	"event",
	"escort",
	"breadcrumbFor",
	"breadcrumbs",
];

struct Ck<'a> {
	out: Vec<Finding>,
	file: String,
	data: Option<&'a Tables>,
	/// Records the corrections create (they count as existing for references).
	created: rustc_hash::FxHashSet<(&'static str, String)>,
}

impl Ck<'_> {
	fn err(&mut self, at: impl Into<String>, m: impl Into<String>) {
		self.out.push(Finding { severity: "error", file: self.file.clone(), at: at.into(), message: m.into() });
	}
	fn warn(&mut self, at: impl Into<String>, m: impl Into<String>) {
		self.out.push(Finding { severity: "warning", file: self.file.clone(), at: at.into(), message: m.into() });
	}
	fn table(&self, kind: &str) -> Option<&V> {
		let d = self.data?;
		Some(match kind {
			"quests" => &d.quests,
			"npcs" => &d.npcs,
			"objects" => &d.objects,
			"items" => &d.items,
			_ => return None,
		})
	}
	/// Whether `kind` `id` exists (None: no data to tell).
	fn exists(&self, kind: &'static str, id: &str) -> Option<bool> {
		let t = self.table(kind)?;
		Some(t.get(id).truthy() || self.created.contains(&(kind, id.to_string())))
	}
	/// A reference to `kind` `id` must exist in the data (or be created by a correction).
	fn refers(&mut self, at: &str, kind: &'static str, v: &V) {
		if !is_id(v) {
			self.err(at, format!("{} must be a positive integer id", show(v)));
			return;
		}
		let id = num_str(v.num());
		if self.exists(kind, &id) == Some(false) {
			self.err(at, format!("no {} {id} in the data", singular(kind)));
		}
	}
	fn ids(&mut self, at: &str, kind: &'static str, v: &V) {
		if !v.is_arr() {
			self.err(at, "must be a list of ids");
			return;
		}
		for (i, x) in v.items().iter().enumerate() {
			self.refers(&format!("{at}[{i}]"), kind, x);
		}
	}
	fn note(&mut self, at: &str, e: &V) {
		if !has_text(&e.get("note")) {
			self.err(format!("{at}.note"), "every entry needs a note: what was wrong and how it was checked (an in-game check, a recording, a player report with its issue number, the game's data)");
		}
	}
	/// `source`: the independent evidence for the values an entry sets, `{ kind, ref }` or a list of them
	/// (kind one of SOURCE_KINDS, ref which table, field or issue). A fix without one belongs in the private
	/// overlay (data/local/corrections-private.json), not here.
	fn source(&mut self, at: &str, e: &V) {
		let s = e.get("source");
		let list = if s.is_arr() {
			s.items()
		} else if s.is_undef() {
			Vec::new()
		} else {
			vec![s.clone()]
		};
		if list.is_empty() {
			self.err(
				format!("{at}.source"),
				format!(
					"every entry needs a source: {{ kind, ref }} or a list of them, kind one of {} (a fix with no such source goes in data/local/corrections-private.json)",
					SOURCE_KINDS.join(", ")
				),
			);
			return;
		}
		for (i, x) in list.iter().enumerate() {
			let a = if s.is_arr() { format!("{at}.source[{i}]") } else { format!("{at}.source") };
			self.keys(&a, x, &["kind", "ref"]);
			if !x.get("kind").as_str().is_some_and(|k| SOURCE_KINDS.contains(&k)) {
				self.err(format!("{a}.kind"), format!("{} is none of {}", show(&x.get("kind")), SOURCE_KINDS.join(", ")));
			}
			if !has_text(&x.get("ref")) {
				self.err(format!("{a}.ref"), "ref says which table, field or issue");
			}
		}
	}
	fn keys(&mut self, at: &str, e: &V, allowed: &[&str]) {
		if !e.is_obj() {
			self.err(at, "must be an object");
			return;
		}
		for k in e.keys() {
			if !allowed.contains(&&*k) {
				self.err(format!("{at}.{k}"), format!("unknown key (allowed: {})", allowed.join(", ")));
			}
		}
	}
	fn section_ids(&mut self, at: &str, sec: &V) -> Vec<(String, V)> {
		if sec.is_undef() {
			return Vec::new();
		}
		if !sec.is_obj() {
			self.err(at, "must be an object keyed by id");
			return Vec::new();
		}
		let mut out = Vec::new();
		for (k, v) in sec.entries() {
			if !k.parse::<u64>().is_ok_and(|n| n > 0) {
				self.err(format!("{at}.{k}"), "keys are positive integer ids");
				continue;
			}
			out.push((k.to_string(), v));
		}
		out
	}
	fn spawns(&mut self, at: &str, add: &V) {
		if !add.is_obj() {
			self.err(at, "must be { \"<uiMapID>\": { f, pts } }");
			return;
		}
		for (map, v) in add.entries() {
			let a = format!("{at}.{map}");
			if !map.parse::<u64>().is_ok_and(|n| n > 0) {
				self.err(&a, "keys are uiMapIDs");
				continue;
			}
			if let Some(d) = self.data {
				if d.maps.is_obj() && !d.maps.get(&map).truthy() {
					self.warn(&a, format!("map {map} has no map frame in the data: its points cannot be placed"));
				}
			}
			self.keys(&a, &v, &["f", "pts", "more"]);
			if !matches!(v.get("f").as_str(), Some("e" | "l")) {
				self.err(format!("{a}.f"), "f is \"e\" (Classic frame) or \"l\" (Forever's)");
			}
			if !v.get("pts").is_arr() || v.get("pts").is_empty() {
				self.err(format!("{a}.pts"), "pts is a non-empty list of [x, y] map percentages");
				continue;
			}
			for (i, p) in v.get("pts").items().iter().enumerate() {
				if !point_ok(p) {
					self.err(format!("{a}.pts[{i}]"), format!("{} is not [x, y] with 0..100 map percentages", show(p)));
				}
			}
		}
	}
}

fn is_id(v: &V) -> bool {
	v.as_num().is_some_and(|n| n > 0.0 && n.fract() == 0.0)
}

fn point_ok(p: &V) -> bool {
	p.is_arr() && p.len() == 2 && p.items().iter().all(|x| x.as_num().is_some_and(|n| (0.0..=100.0).contains(&n)))
}

fn show(v: &V) -> String {
	let t = forge_guide::js::stringify(v, None);
	if t.len() > 60 {
		format!("{}…", &t[..t.char_indices().nth(57).map_or(t.len(), |(i, _)| i)])
	} else {
		t
	}
}

fn singular(kind: &str) -> &str {
	match kind {
		"quests" => "quest",
		"npcs" => "NPC",
		"objects" => "object",
		_ => "item",
	}
}

/// Keys written twice in one object (JSON keeps the last silently): (path, key).
fn duplicate_keys(text: &str) -> Vec<(String, String)> {
	let b = text.as_bytes();
	let mut out = Vec::new();
	// Per open container: is it an object, its keys, the key being read, the path.
	let mut stack: Vec<(bool, Vec<String>, Option<String>)> = Vec::new();
	let mut i = 0;
	let mut expect_key = false;
	while i < b.len() {
		match b[i] {
			b'{' => {
				stack.push((true, Vec::new(), None));
				expect_key = true;
			}
			b'[' => {
				stack.push((false, Vec::new(), None));
				expect_key = false;
			}
			b'}' | b']' => {
				stack.pop();
				expect_key = false;
			}
			b',' => expect_key = stack.last().is_some_and(|s| s.0),
			b'"' => {
				let start = i + 1;
				i += 1;
				while i < b.len() && b[i] != b'"' {
					if b[i] == b'\\' {
						i += 1;
					}
					i += 1;
				}
				if expect_key {
					let key = String::from_utf8_lossy(&b[start..i.min(b.len())]).into_owned();
					let path: Vec<String> = stack[..stack.len().saturating_sub(1)].iter().filter_map(|s| s.2.clone()).collect();
					if let Some(top) = stack.last_mut() {
						if top.1.contains(&key) {
							out.push((path.join("."), key.clone()));
						} else {
							top.1.push(key.clone());
						}
						top.2 = Some(key);
					}
					expect_key = false;
				}
			}
			_ => {}
		}
		i += 1;
	}
	out
}

fn parse_doc(ck: &mut Ck, text: &str) -> Option<V> {
	for (path, key) in duplicate_keys(text) {
		ck.err(if path.is_empty() { key.clone() } else { format!("{path}.{key}") }, "written twice in one object: only the last one counts");
	}
	match forge_guide::js::parse_json(text) {
		Ok(v) => Some(v),
		Err(e) => {
			ck.err("", format!("not valid JSON: {e}"));
			None
		}
	}
}

fn check_corrections(ck: &mut Ck, c: &V) {
	ck.keys("", c, &["_about", "quests", "npcs", "objects", "items", "mechanics"]);
	// Records the corrections create count as existing for the references below.
	for (id, e) in ck.section_ids("quests", &c.get("quests")) {
		if ck.exists("quests", &id) == Some(false) && quest_lacks(&e).is_empty() {
			ck.created.insert(("quests", id));
		}
	}
	for kind in ["npcs", "objects"] {
		for (id, e) in c.get(kind).entries() {
			if ck.exists(kind, &id) == Some(false) && spawner_lacks(&e).is_empty() {
				ck.created.insert((kind, id.to_string()));
			}
		}
	}
	for (id, e) in ck.section_ids("quests", &c.get("quests")) {
		let at = format!("quests.{id}");
		ck.keys(&at, &e, &["set", "source", "note"]);
		ck.note(&at, &e);
		ck.source(&at, &e);
		if ck.exists("quests", &id) == Some(false) && !ck.created.contains(&("quests", id.clone())) {
			ck.err(&at, why(&quest_lacks(&e)).replace("no such record", &format!("no quest {id} in the data")));
		}
		let set = e.get("set");
		if !set.is_obj() {
			ck.err(format!("{at}.set"), "set is an object of the fields to replace");
			continue;
		}
		for (k, v) in set.entries() {
			let a = format!("{at}.set.{k}");
			match &*k {
				"races" | "classes" | "xp" | "level" | "minLevel" | "zone" | "skill" | "event" => {
					if !(v.is_nullish() || v.as_num().is_some_and(|n| n >= 0.0 && n.fract() == 0.0)) {
						ck.err(&a, format!("{} must be a whole number or null", show(&v)));
					}
				}
				"title" | "objectiveText" => {
					if !(v.is_str() || (k.as_ref() == "objectiveText" && v.is_nullish())) {
						ck.err(&a, "must be text");
					}
				}
				"escort" => {
					if !matches!(v, V::Bool(_)) {
						ck.err(&a, "escort is true or false");
					}
				}
				"start" | "end" => {
					let allowed: &[&str] = if &*k == "start" { &["npc", "object", "item"] } else { &["npc", "object"] };
					ck.keys(&a, &v, allowed);
					for (kk, table) in [("npc", "npcs"), ("object", "objects"), ("item", "items")] {
						if allowed.contains(&kk) && v.has(kk) {
							ck.ids(&format!("{a}.{kk}"), table, &v.get(kk));
						}
					}
				}
				"pre" | "preAny" | "preAll" | "excl" | "breadcrumbs" => ck.ids(&a, "quests", &v),
				"next" | "breadcrumbFor" => {
					if !v.is_nullish() {
						ck.refers(&a, "quests", &v);
					}
				}
				"objectives" => {
					if !v.is_arr() {
						ck.err(&a, "objectives is a list");
						continue;
					}
					for (i, o) in v.items().iter().enumerate() {
						let oa = format!("{a}[{i}]");
						let table = match o.get("type").as_str() {
							Some("kill") => "npcs",
							Some("object") => "objects",
							Some("item") => "items",
							Some("event") => "",
							_ => {
								ck.err(&oa, "type is kill, object, item or event");
								continue;
							}
						};
						if !table.is_empty() {
							let t: &'static str = match table {
								"npcs" => "npcs",
								"objects" => "objects",
								_ => "items",
							};
							ck.refers(&format!("{oa}.id"), t, &o.get("id"));
						}
					}
				}
				_ => ck.err(&a, format!("not a quest field (fields: {})", QUEST_FIELDS.join(", "))),
			}
		}
		// A quest that is both its own prerequisite or excludes itself.
		for k in ["pre", "preAny", "preAll", "excl"] {
			if set.get(k).items().iter().any(|x| num_str(x.num()) == id) {
				ck.err(format!("{at}.set.{k}"), format!("quest {id} cannot list itself"));
			}
		}
	}
	for kind in ["npcs", "objects"] {
		for (id, e) in ck.section_ids(kind, &c.get(kind)) {
			let at = format!("{kind}.{id}");
			ck.keys(&at, &e, &["set", "addSpawns", "source", "note"]);
			ck.note(&at, &e);
			ck.source(&at, &e);
			let k: &'static str = if kind == "npcs" { "npcs" } else { "objects" };
			if ck.exists(k, &id) == Some(false) && !ck.created.contains(&(k, id.clone())) {
				ck.err(&at, why(&spawner_lacks(&e)).replace("no such record", &format!("no {} {id} in the data", singular(kind))));
			}
			let set = e.get("set");
			if set.truthy() {
				for (f, v) in set.entries() {
					let a = format!("{at}.set.{f}");
					match (&*f, kind) {
						("rank", "npcs") if !v.as_num().is_some_and(|n| (0.0..=4.0).contains(&n) && n.fract() == 0.0) => {
							ck.err(&a, "rank is 0 (normal), 1 (elite), 2 (rare elite), 3 (boss) or 4 (rare)")
						}
						("lock", "objects") => {
							ck.keys(&a, &v, &["item"]);
							ck.refers(&format!("{a}.item"), "items", &v.get("item"));
						}
						("name", _) if !v.is_str() => ck.err(&a, "must be text"),
						("subName", _) if !(v.is_str() || v.is_nullish()) => ck.err(&a, "must be text or null"),
						("spawns", _) => ck.spawns(&a, &v),
						_ => {}
					}
				}
			}
			if e.has("addSpawns") {
				ck.spawns(&format!("{at}.addSpawns"), &e.get("addSpawns"));
			}
		}
	}
	for (id, e) in ck.section_ids("items", &c.get("items")) {
		let at = format!("items.{id}");
		ck.keys(&at, &e, &["removeDrops", "removeVendors", "source", "note"]);
		ck.note(&at, &e);
		ck.source(&at, &e);
		if ck.exists("items", &id) == Some(false) {
			ck.err(&at, format!("no item {id} in the data (an item correction only removes sources)"));
		}
		let rd = e.get("removeDrops");
		if !rd.is_undef() {
			ck.keys(&format!("{at}.removeDrops"), &rd, &["npc", "object"]);
			for (k, t) in [("npc", "npcs"), ("object", "objects")] {
				if rd.has(k) {
					ck.ids(&format!("{at}.removeDrops.{k}"), t, &rd.get(k));
				}
			}
		}
		if e.has("removeVendors") {
			ck.ids(&format!("{at}.removeVendors"), "npcs", &e.get("removeVendors"));
		}
	}
}

fn kind_ok(ck: &mut Ck, at: &str, k: &V) {
	match k.as_str() {
		None => ck.err(at, "kind is required"),
		Some(k) if !KINDS.contains(&k) => ck.warn(at, format!("{k} is not a kind the build knows ({}); it is kept but nothing reads it", KINDS.join(", "))),
		_ => {}
	}
}

fn check_mechanics(ck: &mut Ck, m: &V, corrections: Option<&V>) {
	ck.keys("", m, &["_about", "schema", "quests", "corrections"]);
	if m.has("corrections") {
		ck.err("corrections", format!("mechanics corrections live in {DIR}/mechanics.json"));
	}
	if m.get("schema").num() != 1.0 {
		ck.err("schema", "schema is 1");
	}
	for (id, e) in ck.section_ids("quests", &m.get("quests")) {
		let at = format!("quests.{id}");
		ck.keys(&at, &e, &["kinds", "params", "steps", "note"]);
		ck.note(&at, &e);
		if ck.exists("quests", &id) == Some(false) {
			ck.err(&at, format!("no quest {id} in the data"));
		}
		let mut own: Vec<String> = Vec::new();
		for (i, k) in e.get("kinds").items().iter().enumerate() {
			let a = format!("{at}.kinds[{i}]");
			ck.keys(&a, k, &["kind", "confidence"]);
			kind_ok(ck, &format!("{a}.kind"), &k.get("kind"));
			if !matches!(k.get("confidence").as_str(), None | Some("high" | "medium" | "low")) {
				ck.err(format!("{a}.confidence"), "confidence is high, medium or low");
			}
			let kn = k.get("kind").to_js_string();
			if own.contains(&kn) {
				ck.err(&a, format!("{kn} is listed twice"));
			}
			own.push(kn);
		}
		for (i, p) in e.get("params").items().iter().enumerate() {
			let a = format!("{at}.params[{i}]");
			kind_ok(ck, &format!("{a}.kind"), &p.get("kind"));
			let kn = p.get("kind").to_js_string();
			if !own.contains(&kn) {
				ck.warn(&a, format!("{kn} is not in this entry's kinds: the params apply only when another layer keeps that kind"));
			}
			for f in ["npc", "after"] {
				if p.has(f) {
					ck.refers(&format!("{a}.{f}"), if f == "npc" { "npcs" } else { "quests" }, &p.get(f));
				}
			}
			if p.has("item") && !p.get("item").is_nullish() {
				ck.refers(&format!("{a}.item"), "items", &p.get("item"));
			}
			// The same kind and item in the corrections' mechanics: the correction wins.
			let item = p.get("item");
			if corrections.is_some_and(|c| c.get("mechanics").get(&id).get("params").items().iter().any(|x| x.get("kind").to_js_string() == kn && x.get("item").to_js_string() == item.to_js_string()))
			{
				ck.warn(&a, format!("{DIR}/mechanics.json {id} also sets {kn}: the correction wins"));
			}
		}
		let mut ns: Vec<String> = Vec::new();
		for (i, st) in e.get("steps").items().iter().enumerate() {
			let a = format!("{at}.steps[{i}]");
			ck.keys(&a, st, &["n", "action", "target", "item", "count", "place", "fact", "confidence"]);
			if !is_id(&st.get("n")) {
				ck.err(format!("{a}.n"), "n is the step's number (1, 2, ...)");
			} else {
				let n = num_str(st.get("n").num());
				if ns.contains(&n) {
					ck.err(format!("{a}.n"), format!("step {n} is listed twice"));
				}
				ns.push(n);
			}
			if !has_text(&st.get("action")) {
				ck.err(format!("{a}.action"), "action is required (accept, kill, use, summon, escort, interact, buy, make, collect, turnin, ...)");
			}
			if !has_text(&st.get("fact")) {
				ck.err(format!("{a}.fact"), "fact is required: the step in our own words");
			}
			let t = st.get("target");
			if t.truthy() {
				let table = match t.get("type").as_str() {
					Some("npc") => Some("npcs"),
					Some("object") => Some("objects"),
					Some("item") => Some("items"),
					_ => None,
				};
				match table {
					Some(tb) if !t.get("id").is_nullish() => ck.refers(&format!("{a}.target.id"), tb, &t.get("id")),
					Some(_) => {}
					None => ck.err(format!("{a}.target.type"), "target type is npc, object or item"),
				}
			}
			let it = st.get("item");
			if it.truthy() && !it.get("id").is_nullish() {
				ck.refers(&format!("{a}.item.id"), "items", &it.get("id"));
			}
			let pl = st.get("place");
			if pl.truthy() {
				if !is_id(&pl.get("map")) || !point_ok(&arr(vec![pl.get("x"), pl.get("y")])) {
					ck.err(format!("{a}.place"), "place is { map, x, y, f } (uiMapID, map percentages)");
				}
				if !matches!(pl.get("f").as_str(), None | Some("e" | "l")) {
					ck.err(format!("{a}.place.f"), "f is \"e\" (Classic frame) or \"l\" (Forever's)");
				}
			}
			if !matches!(st.get("confidence").as_str(), None | Some("high" | "medium" | "low")) {
				ck.err(format!("{a}.confidence"), "confidence is high, medium or low");
			}
		}
	}
}

/// The corrections' `mechanics` section: { "<quest id>": { params, steps, source, note } }.
fn check_mechanics_corrections(ck: &mut Ck, c: &V) {
	for (id, e) in ck.section_ids("mechanics", &c.get("mechanics")) {
		let at = format!("mechanics.{id}");
		ck.keys(&at, &e, &["params", "steps", "source", "note"]);
		ck.note(&at, &e);
		ck.source(&at, &e);
		if ck.exists("quests", &id) == Some(false) {
			ck.err(&at, format!("no quest {id} in the data: the mechanics correction applies to nothing"));
		}
		for (i, p) in e.get("params").items().iter().enumerate() {
			kind_ok(ck, &format!("{at}.params[{i}].kind"), &p.get("kind"));
		}
		for (n, st) in e.get("steps").entries() {
			if !n.parse::<u64>().is_ok_and(|x| x > 0) {
				ck.err(format!("{at}.steps.{n}"), "steps are keyed by their number n");
			}
			ck.keys(&format!("{at}.steps.{n}"), &st, &["set"]);
		}
	}
}

/// v1's deliberate orders: the keys the routes stage reads, and the quests each rule names.
fn check_deliberate(ck: &mut Ck, d: &V) {
	ck.keys("", d, &["about", "pairs", "notes", "never", "keep", "southward", "together", "after", "stay", "optional"]);
	for sec in ["pairs", "together", "after"] {
		for (i, p) in d.get(sec).items().iter().enumerate() {
			for side in ["a", "b"] {
				let s = p.get(side);
				let a = format!("{sec}[{i}].{side}");
				if s.is_arr() && s.len() >= 2 && matches!(s.items()[0].as_str(), Some("accept" | "task" | "turnin")) {
					ck.refers(&format!("{a}[1]"), "quests", &s.items()[1]);
				} else {
					ck.err(a, format!("{} is not [accept|task|turnin, quest, ...]", show(&s)));
				}
			}
		}
	}
	for sec in ["never", "keep", "optional"] {
		for (i, e) in d.get(sec).items().iter().enumerate() {
			ck.refers(&format!("{sec}[{i}].q"), "quests", &e.get("q"));
		}
	}
}

fn check_overrides(ck: &mut Ck, o: &V) {
	ck.keys("", o, &["about", "_about", "include", "skip", "revert", "pairs"]);
	let step = |ck: &mut Ck, a: &str, s: &V, task: bool| {
		let ok = s.is_arr() && (s.len() == 2 || (task && s.len() == 3)) && matches!(s.items()[0].as_str(), Some("accept" | "task" | "turnin"));
		if !ok {
			ck.err(a, format!("{} is not [accept|task|turnin, quest{}]", show(s), if task { ", task index?" } else { "" }));
			return None;
		}
		ck.refers(&format!("{a}[1]"), "quests", &s.items()[1]);
		Some(num_str(s.items()[1].num()))
	};
	let mut included: Vec<(String, String)> = Vec::new();
	let mut skipped: Vec<(String, String)> = Vec::new();
	for (sec, allowed) in [("include", &["q", "after", "reason", "issue"][..]), ("skip", &["q", "reason", "issue"][..])] {
		let list = o.get(sec);
		if !list.is_undef() && !list.is_arr() {
			ck.err(sec, "must be a list");
			continue;
		}
		for (i, e) in list.items().iter().enumerate() {
			let a = format!("{sec}[{i}]");
			ck.keys(&a, e, allowed);
			ck.refers(&format!("{a}.q"), "quests", &e.get("q"));
			if !has_text(&e.get("reason")) {
				ck.err(format!("{a}.reason"), "reason is required: why the route must (not) take it");
			}
			if e.has("after") {
				step(ck, &format!("{a}.after"), &e.get("after"), false);
			}
			let q = num_str(e.get("q").num());
			let mine = if sec == "include" { &mut included } else { &mut skipped };
			if mine.iter().any(|(x, _)| *x == q) {
				ck.warn(&a, format!("quest {q} is already in {sec}"));
			}
			mine.push((q, a));
		}
	}
	for (q, a) in &included {
		if let Some((_, b)) = skipped.iter().find(|(x, _)| x == q) {
			ck.err(a, format!("quest {q} is both included and skipped ({b})"));
		}
	}
	for (i, e) in o.get("revert").items().iter().enumerate() {
		let a = format!("revert[{i}]");
		ck.keys(&a, e, &["s", "q", "edit", "reason", "issue"]);
		if !has_text(&e.get("reason")) {
			ck.err(format!("{a}.reason"), "reason is required");
		}
		let q = if e.has("s") {
			step(ck, &format!("{a}.s"), &e.get("s"), true)
		} else if e.has("q") {
			if !matches!(e.get("edit").as_str(), Some("drop" | "insert")) {
				ck.err(format!("{a}.edit"), "with q, edit is \"drop\" or \"insert\"");
			}
			ck.refers(&format!("{a}.q"), "quests", &e.get("q"));
			Some(num_str(e.get("q").num()))
		} else {
			ck.err(&a, "a revert names a step (s) or a quest (q, edit)");
			None
		};
		if let Some(q) = q {
			if e.get("edit").as_str() != Some("insert") {
				if let Some((_, b)) = skipped.iter().find(|(x, _)| *x == q) {
					ck.err(&a, format!("quest {q} is skipped ({b}): reverting its step keeps nothing"));
				}
			}
		}
	}
	for (i, p) in o.get("pairs").items().iter().enumerate() {
		let a = format!("pairs[{i}]");
		ck.keys(&a, p, &["a", "b", "why", "source", "applied"]);
		step(ck, &format!("{a}.a"), &p.get("a"), false);
		step(ck, &format!("{a}.b"), &p.get("b"), false);
	}
}

/// Checks an edit of the data files contributors change: their shape, that the ids they name exist
/// in the built data (or are created by a correction), and conflicts within and between them.
pub fn check(inp: &CheckInputs) -> Vec<Finding> {
	let mut out = Vec::new();
	let mut corrections = None;
	if let Some((label, text)) = inp.corrections {
		let mut ck = Ck { out: Vec::new(), file: label.into(), data: inp.data, created: Default::default() };
		if let Some(c) = parse_doc(&mut ck, text) {
			check_corrections(&mut ck, &c);
			check_mechanics_corrections(&mut ck, &c);
			corrections = Some(c);
		}
		out.extend(ck.out);
	}
	if let Some((label, text)) = inp.mechanics {
		let mut ck = Ck { out: Vec::new(), file: label.into(), data: inp.data, created: Default::default() };
		if let Some(m) = parse_doc(&mut ck, text) {
			check_mechanics(&mut ck, &m, corrections.as_ref());
		}
		out.extend(ck.out);
	}
	if let Some((label, text)) = inp.route_fixes {
		let mut ck = Ck { out: Vec::new(), file: label.into(), data: inp.data, created: Default::default() };
		if let Some(d) = parse_doc(&mut ck, text) {
			ck.keys("", &d, &["about", "_about", "deliberate", "overrides"]);
			for (sec, f) in [("deliberate", check_deliberate as fn(&mut Ck, &V)), ("overrides", check_overrides)] {
				let from = ck.out.len();
				f(&mut ck, &d.get(sec));
				for x in &mut ck.out[from..] {
					x.at = if x.at.is_empty() { sec.to_string() } else { format!("{sec}.{}", x.at) };
				}
			}
		}
		out.extend(ck.out);
	}
	if let Some((label, text)) = inp.places {
		let mut ck = Ck { out: Vec::new(), file: label.into(), data: inp.data, created: Default::default() };
		if let Some(d) = parse_doc(&mut ck, text) {
			check_places(&mut ck, &d);
		}
		out.extend(ck.out);
	}
	if let Some((label, text)) = inp.guide_fixes {
		let mut ck = Ck { out: Vec::new(), file: label.into(), data: inp.data, created: Default::default() };
		if let Some(d) = parse_doc(&mut ck, text) {
			check_guide_fixes(&mut ck, &d);
		}
		out.extend(ck.out);
	}
	out
}

/// A fix record's envelope: a unique `id`, `note`, `source`, an optional `issue`/`pr` number and
/// `faction` (Alliance or Horde: the record holds for that side's routes only).
fn check_record(ck: &mut Ck, at: &str, r: &V, ids: &mut rustc_hash::FxHashSet<String>) {
	let f = r.get("faction");
	if !(f.is_undef() || matches!(f.as_str(), Some("Alliance" | "Horde"))) {
		ck.err(format!("{at}.faction"), format!("{} is not Alliance or Horde", show(&f)));
	}
	match r.get("id").as_str() {
		Some(id) if !id.trim().is_empty() => {
			if !ids.insert(id.to_string()) {
				ck.err(format!("{at}.id"), format!("id {id:?} is used twice"));
			}
		}
		_ => ck.err(format!("{at}.id"), "every record needs an id (`<issue>-<slug>`)"),
	}
	ck.note(at, r);
	ck.source(at, r);
	for k in ["issue", "pr"] {
		let v = r.get(k);
		if !v.is_undef() && !is_id(&v) {
			ck.err(format!("{at}.{k}"), format!("{} must be an issue or pull request number", show(&v)));
		}
	}
}

/// The quest's objective count (None: no data, or the quest is unknown).
fn objectives(ck: &Ck, q: &V) -> Option<usize> {
	let t = ck.table("quests")?;
	let rec = t.get(&num_str(q.num()));
	rec.truthy().then(|| rec.get("objectives").len())
}

/// A map and frame of a place: `map` a uiMapID with a frame, `frame` era or live.
fn check_map(ck: &mut Ck, at: &str, v: &V) {
	let map = v.get("map");
	if !is_id(&map) {
		ck.err(format!("{at}.map"), format!("{} must be a uiMapID", show(&map)));
	} else if ck.data.is_some_and(|d| !d.maps.get(&num_str(map.num())).truthy()) {
		ck.err(format!("{at}.map"), format!("map {} has no map frame (map-frames.json)", num_str(map.num())));
	}
	let f = v.get("frame");
	if !(f.is_undef() || matches!(f.as_str(), Some("era" | "live"))) {
		ck.err(format!("{at}.frame"), format!("{} is not era or live", show(&f)));
	} else if f.as_str() != Some("live") && is_id(&map) && ck.data.is_some_and(|d| d.maps.get(&num_str(map.num())).truthy() && !d.era_maps.get(&num_str(map.num())).truthy()) {
		ck.err(format!("{at}.frame"), format!("map {} has no Era bounds: its coordinates are live (`\"frame\": \"live\"`)", num_str(map.num())));
	}
}

fn check_xy(ck: &mut Ck, at: &str, x: &V, y: &V) {
	for (k, v) in [("x", x), ("y", y)] {
		if !v.as_num().is_some_and(|n| (0.0..=100.0).contains(&n)) {
			ck.err(format!("{at}.{k}"), format!("{} must be a map coordinate, 0 to 100", show(v)));
		}
	}
}

/// data/places.json: `{ about, places: [{ id, quest, objective: N | "giver" | "ender", write?, at: { map,
/// x, y, frame } | path: { map, frame, points: [[x, y], ...] }, note, source, issue, pr }] }`.
fn check_places(ck: &mut Ck, d: &V) {
	ck.keys("", d, &["about", "_about", "places"]);
	let list = d.get("places");
	if !list.is_arr() {
		ck.err("places", "must be a list");
		return;
	}
	let mut ids = rustc_hash::FxHashSet::default();
	let mut slots: Vec<(String, String)> = Vec::new();
	for (i, r) in list.items().iter().enumerate() {
		let at = format!("places[{i}]");
		ck.keys(&at, r, &["id", "quest", "objective", "write", "at", "path", "faction", "note", "source", "issue", "pr"]);
		let write = r.get("write");
		if !(write.is_undef() || matches!(write, V::Bool(_))) {
			ck.err(format!("{at}.write"), "write is true or false");
		}
		if write.truthy() && !is_id(&r.get("objective")) {
			ck.err(format!("{at}.write"), "only an objective (a number) gets its own goal line");
		}
		check_record(ck, &at, r, &mut ids);
		ck.refers(&format!("{at}.quest"), "quests", &r.get("quest"));
		let o = r.get("objective");
		match o.as_str() {
			Some("giver" | "ender") => {}
			Some(s) => ck.err(format!("{at}.objective"), format!("{s:?}: an objective number, \"giver\" or \"ender\"")),
			None if is_id(&o) => {
				if let Some(n) = objectives(ck, &r.get("quest")) {
					if o.num() as usize > n.max(1) {
						ck.err(format!("{at}.objective"), format!("quest {} has {n} objective(s)", num_str(r.get("quest").num())));
					}
				}
			}
			None => ck.err(format!("{at}.objective"), format!("{}: an objective number, \"giver\" or \"ender\"", show(&o))),
		}
		let (pt, path) = (r.get("at"), r.get("path"));
		match (pt.is_undef(), path.is_undef()) {
			(false, true) => {
				ck.keys(&format!("{at}.at"), &pt, &["map", "x", "y", "frame"]);
				check_map(ck, &format!("{at}.at"), &pt);
				check_xy(ck, &format!("{at}.at"), &pt.get("x"), &pt.get("y"));
			}
			(true, false) => {
				ck.keys(&format!("{at}.path"), &path, &["map", "frame", "points"]);
				check_map(ck, &format!("{at}.path"), &path);
				let pts = path.get("points");
				if !pts.is_arr() || pts.len() < 2 {
					ck.err(format!("{at}.path.points"), "a path is a list of two or more [x, y] points");
				}
				for (j, p) in pts.items().iter().enumerate() {
					if !(p.is_arr() && p.len() == 2) {
						ck.err(format!("{at}.path.points[{j}]"), format!("{} is not [x, y]", show(p)));
						continue;
					}
					check_xy(ck, &format!("{at}.path.points[{j}]"), &p.items()[0], &p.items()[1]);
				}
			}
			(true, true) if write.truthy() => {}
			_ => ck.err(&at, "a place has either `at` (a point) or `path` (or neither, with `write: true`)"),
		}
		let slot = format!("quest {} objective {}{}", num_str(r.get("quest").num()), stringify(&o, None), r.get("faction").as_str().map_or(String::new(), |f| format!(" ({f})")));
		let id = r.get("id").as_str().unwrap_or("?").to_string();
		if let Some((_, other)) = slots.iter().find(|(s, _)| *s == slot) {
			ck.err(&at, format!("{slot} is placed by {other} too: one place per objective"));
		}
		slots.push((slot, id));
	}
}

/// data/guide-fixes.json: `{ about, fixes: [{ id, at: { quest, goal: accept | turnin | complete |
/// objective, objective? }, tip | level | along: false, note, source, issue, pr }] }`. `along: false` (an
/// objective goal only): the writer never lists the objective "on the way" before its step.
fn check_guide_fixes(ck: &mut Ck, d: &V) {
	ck.keys("", d, &["about", "_about", "fixes"]);
	let list = d.get("fixes");
	if !list.is_arr() {
		ck.err("fixes", "must be a list");
		return;
	}
	let mut ids = rustc_hash::FxHashSet::default();
	let mut slots: Vec<(String, String)> = Vec::new();
	for (i, r) in list.items().iter().enumerate() {
		let at = format!("fixes[{i}]");
		ck.keys(&at, r, &["id", "at", "tip", "level", "along", "faction", "note", "source", "issue", "pr"]);
		check_record(ck, &at, r, &mut ids);
		let a = r.get("at");
		ck.keys(&format!("{at}.at"), &a, &["quest", "goal", "objective"]);
		ck.refers(&format!("{at}.at.quest"), "quests", &a.get("quest"));
		match a.get("goal").as_str() {
			Some("accept" | "turnin" | "complete") => {}
			Some("objective") => {
				let o = a.get("objective");
				if !is_id(&o) {
					ck.err(format!("{at}.at.objective"), "an objective goal names its objective number");
				} else if let Some(n) = objectives(ck, &a.get("quest")) {
					if o.num() as usize > n.max(1) {
						ck.err(format!("{at}.at.objective"), format!("quest {} has {n} objective(s)", num_str(a.get("quest").num())));
					}
				}
			}
			_ => ck.err(format!("{at}.at.goal"), format!("{}: accept, turnin, complete or objective", show(&a.get("goal")))),
		}
		let (tip, level, along) = (r.get("tip"), r.get("level"), r.get("along"));
		let kind = match (tip.is_undef(), level.is_undef()) {
			(true, true) if !along.is_undef() => {
				if !matches!(along, V::Bool(false)) {
					ck.err(format!("{at}.along"), "`along` is false (the objective is never listed on the way)");
				}
				if a.get("goal").as_str() != Some("objective") {
					ck.err(format!("{at}.at.goal"), "an `along` fix is on an objective goal");
				}
				"along"
			}
			(false, true) => {
				if !has_text(&tip) || tip.as_str().is_some_and(|t| t.contains('\n')) {
					ck.err(format!("{at}.tip"), "a tip is one line of text");
				}
				"tip"
			}
			(true, false) => {
				if !level.as_num().is_some_and(|n| n.fract() == 0.0 && (2.0..=60.0).contains(&n)) {
					ck.err(format!("{at}.level"), format!("{} must be a level, 2 to 60", show(&level)));
				}
				"level"
			}
			_ => {
				ck.err(&at, "a guide fix sets a `tip`, a `level` gate or `along: false`");
				"?"
			}
		};
		let slot = format!("{} {}{}", stringify(&a, None), kind, r.get("faction").as_str().map_or(String::new(), |f| format!(" ({f})")));
		let id = r.get("id").as_str().unwrap_or("?").to_string();
		if let Some((_, other)) = slots.iter().find(|(s, _)| *s == slot) {
			ck.err(&at, format!("{} of this goal's step is set by {other} too", kind));
		}
		slots.push((slot, id));
	}
}

/// The corrections with a private overlay merged over them (data/local/corrections-private.json:
/// corrections whose only support is a local-only source): per section (quests, npcs, objects,
/// items, mechanics) and id, an entry only the overlay has is added; one both have is merged key by
/// key, the overlay's object values merged into ours and its other values replacing ours. The
/// overlay's mechanics may also be nested as `mechanics.quests.<id>`.
pub fn overlay(public: &V, private: &V) -> V {
	fn merge(a: &V, b: &V) -> V {
		if !(a.is_obj() && b.is_obj()) {
			return b.clone();
		}
		let out = Obj::new();
		for (k, v) in a.entries() {
			out.set(&k, v);
		}
		for (k, v) in b.entries() {
			let cur = out.get(&k);
			out.set(&k, if cur.is_undef() { v } else { merge(&cur, &v) });
		}
		V::Obj(out)
	}
	let out = forge_guide::js::parse_json(&forge_guide::js::stringify(public, None)).unwrap_or(V::Null);
	for (section, ids) in private.entries() {
		if section.starts_with('_') || !ids.is_obj() {
			continue;
		}
		let mut entries: Vec<(Str, V)> = ids.entries();
		if &*section == "mechanics" {
			let nested = ids.get("quests");
			entries.retain(|(k, _)| &**k != "quests");
			if nested.is_obj() {
				entries.extend(nested.entries());
			}
		}
		if !out.get(&section).is_obj() {
			out.set(&section, V::obj());
		}
		let dst = out.get(&section);
		for (id, entry) in entries {
			let cur = dst.get(&id);
			dst.set(&id, if cur.is_undef() { entry } else { merge(&cur, &entry) });
		}
	}
	out
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_guide::js::parse_json;

	fn tables() -> Tables {
		Tables {
			quests: parse_json(r#"{ "10": { "id": 10, "objectives": [{ "type": "kill", "id": 20 }, { "type": "object", "id": 30 }] }, "11": { "id": 11 } }"#).unwrap(),
			npcs: parse_json(r#"{ "20": { "id": 20 } }"#).unwrap(),
			objects: parse_json(r#"{ "30": { "id": 30 } }"#).unwrap(),
			items: parse_json(r#"{ "40": { "id": 40 } }"#).unwrap(),
			maps: parse_json(r#"{ "1429": true, "2521": true }"#).unwrap(),
			era_maps: parse_json(r#"{ "1429": true }"#).unwrap(),
		}
	}

	fn findings(c: Option<&str>, m: Option<&str>, o: Option<&str>) -> Vec<String> {
		let t = tables();
		check(&CheckInputs { corrections: c.map(|x| ("c", x)), mechanics: m.map(|x| ("m", x)), route_fixes: o.map(|x| ("o", x)), places: None, guide_fixes: None, data: Some(&t) })
			.into_iter()
			.map(|f| format!("{} {} {}: {}", f.severity, f.file, f.at, f.message))
			.collect()
	}

	#[test]
	fn each_correction_says_what_it_did() {
		let c = parse_json(
			r#"{ "quests": { "10": { "set": { "xp": 440 } }, "11": { "set": { "xp": 100 } }, "12": { "set": { "xp": 1 } },
				"99": { "set": { "title": "New", "start": { "npc": [1], "object": [], "item": [] }, "end": { "npc": [1], "object": [] } } } },
			"items": { "40": { "removeDrops": { "npc": [5] } }, "41": { "removeVendors": [7] } } }"#,
		)
		.unwrap();
		let quests = parse_json(r#"{ "10": { "id": 10, "xp": 220 }, "11": { "id": 11, "xp": 100 } }"#).unwrap();
		let items = parse_json(r#"{ "40": { "id": 40, "drops": { "npc": { "5": 50 } } }, "41": { "id": 41, "vendors": [8] } }"#).unwrap();
		let (Some(q), Some(i)) = (quests.as_obj(), items.as_obj()) else { panic!() };
		let a = apply(&c, q, &Obj::new(), &Obj::new(), i, false);
		let st: Vec<(String, &str)> = a.entries.iter().map(|e| (format!("{} {}", e.section, e.id), e.state)).collect();
		assert_eq!(
			st,
			vec![
				("quests 10".into(), "applied"),
				("quests 11".into(), "redundant"),
				("quests 12".into(), "unused"),
				("quests 99".into(), "created"),
				("items 40".into(), "applied"),
				("items 41".into(), "redundant"),
			]
		);
	}

	#[test]
	fn a_good_edit_passes() {
		let c = r#"{ "quests": {
			"10": { "set": { "pre": [11], "start": { "npc": [20], "object": [], "item": [40] } }, "source": { "kind": "in-game-check", "ref": "issue 1" }, "note": "checked in game" },
			"99": { "set": { "title": "New", "start": { "npc": [98], "object": [], "item": [] }, "end": { "npc": [20], "object": [] } },
				"source": [{ "kind": "recording", "ref": "session 1" }, { "kind": "client", "ref": "QuestCache" }], "note": "created" } },
			"npcs": { "98": { "set": { "name": "Giver" }, "addSpawns": { "1429": { "f": "e", "pts": [[10, 20]] } }, "source": { "kind": "recording", "ref": "session 1" }, "note": "created" } } }"#;
		let m = r#"{ "schema": 1, "quests": { "10": { "kinds": [{ "kind": "object-click", "confidence": "high" }],
			"params": [{ "kind": "object-click", "item": 40 }],
			"steps": [{ "n": 1, "action": "interact", "target": { "type": "object", "id": 30 }, "fact": "Open it.", "confidence": "high" }], "note": "recording" } } }"#;
		let o = r#"{ "about": "", "deliberate": { "pairs": [{ "a": ["turnin", 11], "b": ["task", 10], "why": "a report" }], "keep": [{ "q": 10 }] },
			"overrides": { "include": [{ "q": 10, "after": ["turnin", 11], "reason": "players do" }], "skip": [], "revert": [] } }"#;
		assert_eq!(findings(Some(c), Some(m), Some(o)), Vec::<String>::new());
	}

	fn record_findings(p: Option<&str>, g: Option<&str>) -> Vec<String> {
		let t = tables();
		check(&CheckInputs { corrections: None, mechanics: None, route_fixes: None, places: p.map(|x| ("p", x)), guide_fixes: g.map(|x| ("g", x)), data: Some(&t) })
			.into_iter()
			.map(|f| format!("{} {} {}: {}", f.severity, f.file, f.at, f.message))
			.collect()
	}

	#[test]
	fn places_and_guide_fixes_are_checked() {
		let src = r#""source": { "kind": "in-game-check", "ref": "issue 1" }, "note": "checked""#;
		let p = format!(
			r#"{{ "places": [
				{{ "id": "1-a", "quest": 10, "objective": 1, "at": {{ "map": 1429, "x": 40.1, "y": 70.2, "frame": "era" }}, "issue": 1, {src} }},
				{{ "id": "1-b", "quest": 11, "objective": "ender", "path": {{ "map": 1429, "points": [[1, 2], [3, 4]] }}, {src} }},
				{{ "id": "1-c", "quest": 10, "objective": 2, "write": true, "faction": "Alliance", {src} }},
				{{ "id": "1-d", "quest": 10, "objective": 2, "faction": "Horde", "at": {{ "map": 2521, "x": 1, "y": 1, "frame": "live" }}, {src} }} ] }}"#
		);
		let g = format!(
			r#"{{ "fixes": [ {{ "id": "1-t", "at": {{ "quest": 10, "goal": "accept" }}, "tip": "A tip.", {src} }}, {{ "id": "1-l", "at": {{ "quest": 11, "goal": "objective", "objective": 1 }}, "level": 14, {src} }} ] }}"#
		);
		assert_eq!(record_findings(Some(&p), Some(&g)), Vec::<String>::new());
		let bad_p = r#"{ "places": [
			{ "id": "x", "quest": 77, "objective": "middle", "at": { "map": 9999, "x": 140, "y": 1, "frame": "classic" } },
			{ "id": "x", "quest": 10, "objective": 1, "write": true, "source": { "kind": "in-game-check", "ref": "r" }, "note": "n" },
			{ "id": "y", "quest": 10, "objective": 1, "at": { "map": 1429, "x": 1, "y": 1 }, "path": { "map": 1429, "points": [] }, "source": { "kind": "in-game-check", "ref": "r" }, "note": "n" },
			{ "id": "w", "quest": 10, "objective": 2, "faction": "Both", "at": { "map": 2521, "x": 1, "y": 1, "frame": "era" }, "source": { "kind": "in-game-check", "ref": "r" }, "note": "n" } ] }"#;
		let bad_g = r#"{ "fixes": [ { "id": "z", "at": { "quest": 10, "goal": "pickup" }, "tip": "two\nlines", "level": 70 } ] }"#;
		let f = record_findings(Some(bad_p), Some(bad_g));
		let has = |s: &str| f.iter().any(|x| x.contains(s));
		for s in [
			"error p places[0].quest: no quest 77 in the data",
			"places[0].objective: \"middle\"",
			"places[0].at.map: map 9999 has no map frame",
			"places[0].at.x: 140 must be a map coordinate",
			"places[0].at.frame",
			"places[0].source: every entry needs a source",
			"places[1].id: id \"x\" is used twice",
			"places[2]: a place has either",
			"places[2]: quest 10 objective 1 is placed by x too",
			"places[3].faction: \"Both\" is not Alliance or Horde",
			"places[3].at.frame: map 2521 has no Era bounds",
			"fixes[0].at.goal",
			"fixes[0]: a guide fix sets a `tip`, a `level` gate or `along: false`",
		] {
			assert!(has(s), "{s}: {f:#?}");
		}
	}

	#[test]
	fn mistakes_are_named() {
		let c = r#"{ "quests": {
			"10": { "set": { "pre": [12], "racez": 1 } },
			"10": { "set": {}, "note": "twice" },
			"77": { "set": { "races": 1 }, "note": "absent" } },
			"items": { "41": { "removeDrops": { "npc": [20] }, "note": "absent" } } }"#;
		let f = findings(Some(c), None, None);
		let has = |s: &str| f.iter().any(|x| x.contains(s));
		assert!(has("error c quests.10: written twice"), "{f:#?}");
		assert!(has("no quest 77 in the data, and the correction lacks title, start, end"), "{f:#?}");
		assert!(has("no item 41 in the data"), "{f:#?}");
		assert!(has("error c quests.77.source: every entry needs a source"), "{f:#?}");
		let f = findings(Some(r#"{ "quests": { "10": { "set": { "races": 1 }, "source": { "kind": "website", "ref": "" }, "note": "x" } } }"#), None, None);
		let has = |s: &str| f.iter().any(|x| x.contains(s));
		assert!(has("quests.10.source.kind: \"website\" is none of recording"), "{f:#?}");
		assert!(has("quests.10.source.ref: ref says which table"), "{f:#?}");
		let o = r#"{ "deliberate": { "pairs": [{ "a": ["turnin", 6], "b": ["went", 10] }] },
			"overrides": { "include": [{ "q": 10, "reason": "x" }], "skip": [{ "q": 10, "reason": "y" }, { "q": 5, "reason": "z" }], "revert": [{ "s": ["accept", 10], "reason": "r" }] } }"#;
		let f = findings(None, None, Some(o));
		let has = |s: &str| f.iter().any(|x| x.contains(s));
		assert!(has("quest 10 is both included and skipped"), "{f:#?}");
		assert!(has("overrides.skip[1].q: no quest 5 in the data"), "{f:#?}");
		assert!(has("deliberate.pairs[0].a[1]: no quest 6 in the data"), "{f:#?}");
		assert!(has("error o deliberate.pairs[0].b"), "{f:#?}");
		assert!(has("reverting its step keeps nothing"), "{f:#?}");
		let m = r#"{ "schema": 1, "quests": { "10": { "kinds": [{ "kind": "teleport" }], "steps": [{ "n": 1, "action": "use" }], "note": "x" } }, "corrections": {} }"#;
		let f = findings(Some(r#"{ "mechanics": { "10": { "params": [{ "kind": "delayed-offer" }], "note": "x" } } }"#), Some(m), None);
		let has = |s: &str| f.iter().any(|x| x.contains(s));
		assert!(has("error m corrections: mechanics corrections live in forever-db/corrections/mechanics.json"), "{f:#?}");
		assert!(has("error c mechanics.10.source: every entry needs a source"), "{f:#?}");
		let has = |s: &str| f.iter().any(|x| x.contains(s));
		assert!(has("warning m quests.10.kinds[0].kind: teleport is not a kind"), "{f:#?}");
		assert!(has("error m quests.10.steps[0].fact"), "{f:#?}");
	}

	#[test]
	fn a_folder_of_section_files_reads_as_one_document() {
		let d = std::env::temp_dir().join(format!("forge-corr-dir-{}", std::process::id()));
		std::fs::create_dir_all(&d).unwrap();
		std::fs::write(d.join("quests.json"), "{ \"10\": { \"set\": { \"level\": 3 } },\n \"10\": { \"set\": { \"level\": 4 } } }\n").unwrap();
		std::fs::write(d.join("mechanics.json"), "{ \"10\": { \"params\": [] } }\n").unwrap();
		let text = read_text(&d).unwrap();
		let v = load(&d).unwrap();
		assert_eq!(v.get("quests").get("10").get("set").get("level").num(), 4.0);
		assert!(v.get("npcs").is_obj() && v.get("items").is_obj());
		assert!(v.get("mechanics").get("10").is_obj());
		// a key written twice in a section file is still seen, at its section's path
		assert!(duplicate_keys(&text).contains(&("quests".to_string(), "10".to_string())));
		let _ = std::fs::remove_dir_all(&d);
		// a checkout without the folder: the old single file, for one release
		let root = std::env::temp_dir().join(format!("forge-corr-root-{}", std::process::id()));
		std::fs::create_dir_all(root.join("tools/lib/data")).unwrap();
		std::fs::write(root.join(OLD_FILE), "{ \"quests\": {} }\n").unwrap();
		assert_eq!(locate(&root), root.join(OLD_FILE));
		std::fs::create_dir_all(root.join(DIR)).unwrap();
		assert_eq!(locate(&root), root.join(DIR));
		let _ = std::fs::remove_dir_all(&root);
	}

	#[test]
	fn the_overlay_takes_mechanics_flat_or_under_quests() {
		let public = parse_json(r#"{ "quests": {}, "mechanics": { "114": { "params": [{ "kind": "delayed-offer", "sec": 10 }], "note": "public" } } }"#).unwrap();
		let private =
			parse_json(r#"{ "_about": "x", "mechanics": { "quests": { "603": { "params": [{ "kind": "delayed-offer", "sec": 5 }], "note": "nested" } }, "1064": { "note": "flat" } } }"#).unwrap();
		let m = overlay(&public, &private).get("mechanics");
		assert_eq!(m.get("114").get("note").as_str(), Some("public"));
		assert_eq!(m.get("603").get("params").items()[0].get("sec").num(), 5.0);
		assert_eq!(m.get("1064").get("note").as_str(), Some("flat"));
		assert!(m.get("quests").is_undef(), "the nesting key is not an id");
	}
}
