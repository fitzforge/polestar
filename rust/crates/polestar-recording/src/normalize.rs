//! Decoded chunks -> forge's per-session JSON (`data/recordings/<session>.json`, schema 2; see
//! docs/ARCHITECTURE.md "Recordings"). A session is the consecutive chunks of one (contributor,
//! install, character) with gaps under 30 minutes. Event kinds and fields keep the names schema 1
//! used wherever the meaning is unchanged, so the data build, the travel build, the trainer list,
//! the calibration and the route report read both.

use std::collections::{BTreeMap, BTreeSet};

use serde_json::{json, Map, Value};

use crate::record::{Chunk, Kind, Record};

/// The normalized schema.
pub const SCHEMA: u32 = 2;
/// A gap this long (seconds) between chunks starts a new session.
pub const SESSION_GAP: f64 = 1800.0;
/// A loot window this close (seconds) before an objective's progress is that objective's loot.
const LOOT_PROGRESS: f64 = 3.0;

/// Everything read from one install of one contributor.
#[derive(Clone, Debug, Default)]
pub struct Source {
	/// `local` for the maintainer's own files, else the contributor id (16 hex digits of the
	/// upload token's SHA-256).
	pub contributor: String,
	pub install: String,
	pub chunks: Vec<Chunk>,
	/// The SavedVariables `maps` table (uiMapID -> `map` record fields from `id` on), when known.
	pub maps: BTreeMap<u32, String>,
}

/// `YYYYMMDDTHHMMSSZ` for epoch seconds (UTC).
pub fn stamp(epoch: i64) -> String {
	let days = epoch.div_euclid(86400);
	let secs = epoch.rem_euclid(86400);
	// Civil date from days since 1970-01-01 (Howard Hinnant's algorithm).
	let z = days + 719468;
	let era = z.div_euclid(146097);
	let doe = z.rem_euclid(146097);
	let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365;
	let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
	let mp = (5 * doy + 2) / 153;
	let d = doy - (153 * mp + 2) / 5 + 1;
	let m = if mp < 10 { mp + 3 } else { mp - 9 };
	let y = yoe + era * 400 + if m <= 2 { 1 } else { 0 };
	format!("{y:04}{m:02}{d:02}T{:02}{:02}{:02}Z", secs / 3600, secs / 60 % 60, secs % 60)
}

fn round(v: f64, places: i32) -> f64 {
	let k = 10f64.powi(places);
	(v * k).round() / k
}

/// A map record's fields (from `id` on) -> (id, { type, parent, c, left, right, top, bottom }).
fn map_frame(fields: &[&str]) -> Option<(u32, Value)> {
	let id: u32 = fields.first()?.parse().ok().filter(|i| *i > 0)?;
	let int = |i: usize| fields.get(i).and_then(|s| s.parse::<i64>().ok()).map_or(Value::Null, Value::from);
	let num = |i: usize| fields.get(i).and_then(|s| s.parse::<f64>().ok()).map_or(Value::Null, Value::from);
	Some((id, json!({ "type": int(1), "parent": int(2), "c": int(3), "left": num(5), "right": num(7), "top": num(4), "bottom": num(6) })))
}

/// npcKind -> the field the id goes in.
fn who_key(kind: &str) -> Option<&'static str> {
	match kind {
		"c" => Some("npc"),
		"o" => Some("object"),
		"i" => Some("item"),
		_ => None,
	}
}

fn rank(cls: &str) -> Option<&'static str> {
	Some(match cls {
		"n" => "normal",
		"e" => "elite",
		"r" => "rare",
		"R" => "rareelite",
		"b" => "worldboss",
		_ => return None,
	})
}

/// An objective's name from its log text: `Kobold Vermin slain: 0/8`, or as list fields carry it
/// (`:` written as a space) `Kobold Vermin slain  0/8` -> `Kobold Vermin slain`.
fn objective_name(text: &str) -> &str {
	let t = text.trim();
	if let Some((name, count)) = t.rsplit_once(|c: char| c == ':' || c.is_whitespace()) {
		if let Some((a, b)) = count.split_once('/') {
			if !a.is_empty() && !b.is_empty() && a.bytes().chain(b.bytes()).all(|c| c.is_ascii_digit()) {
				return name.trim_end().trim_end_matches(':').trim_end();
			}
		}
	}
	t
}

struct Objective {
	kind: String,
	max: Option<i64>,
	text: String,
}

/// What a character's chunks say about quests, over every session in the batch: titles (`text`
/// is written once per character and quest) and objectives (written at accept).
#[derive(Default)]
struct Known {
	titles: BTreeMap<i64, String>,
	objectives: BTreeMap<i64, Vec<Objective>>,
}

struct Drop {
	t: f64,
	items: Vec<(i64, i64)>,
	wanted: Vec<(i64, i64)>,
	pos: Option<(u32, f64, f64)>,
	/// The `drop` event's index in the session's events.
	index: usize,
}

#[derive(Default)]
struct State {
	lvl: Option<i64>,
	xp: Option<i64>,
	xp_max: Option<i64>,
	rested: Option<i64>,
	combat: bool,
	inst: Option<i64>,
	drops: Vec<Drop>,
	/// The index the next event gets in the session's events.
	next_index: usize,
	/// (drop event index, quest, objective): its item ticked that objective.
	tags: Vec<(usize, i64, i64)>,
}

struct Ev {
	m: Map<String, Value>,
}

impl Ev {
	fn new(t: f64, e: &str) -> Ev {
		let mut m = Map::new();
		m.insert("t".into(), json!(t));
		m.insert("e".into(), json!(e));
		Ev { m }
	}

	fn set(&mut self, k: &str, v: impl Into<Value>) -> &mut Self {
		self.m.insert(k.into(), v.into());
		self
	}

	fn opt(&mut self, k: &str, v: Option<impl Into<Value>>) -> &mut Self {
		if let Some(v) = v {
			self.m.insert(k.into(), v.into());
		}
		self
	}

	fn int(&mut self, k: &str, r: &Record, field: &str) -> &mut Self {
		self.opt(k, r.int(field))
	}

	fn text(&mut self, k: &str, r: &Record, field: &str) -> &mut Self {
		let s = r.get(field);
		self.opt(k, (!s.is_empty()).then(|| s.to_string()))
	}

	fn pos(&mut self, r: &Record) -> &mut Self {
		if let Some(p) = r.pos() {
			let (x, y) = p.percent();
			self.set("map", p.map).set("x", x).set("y", y);
		}
		self
	}

	/// `npcKind` + id -> `npc`/`object`/`item` (a player is never stored).
	fn who(&mut self, r: &Record, kind_field: &str, id_field: &str, prefix: &str) -> &mut Self {
		if let (Some(k), Some(id)) = (who_key(r.get(kind_field)), r.int(id_field)) {
			if prefix.is_empty() {
				self.set(k, id);
			} else {
				let mut c = k.chars();
				let cap: String = c.next().map(|f| f.to_ascii_uppercase()).into_iter().chain(c).collect();
				self.set(&format!("{prefix}{cap}"), id);
			}
		}
		self
	}

	fn inst(&mut self, s: &State) -> &mut Self {
		self.opt("inst", s.inst)
	}
}

fn pairs(r: &Record, field: &str) -> Vec<(i64, i64)> {
	r.list(field).iter().filter_map(|p| Some((p.first()?.parse().ok()?, p.get(1)?.parse().ok()?))).collect()
}

fn ids(r: &Record, field: &str) -> Value {
	Value::from(r.ids(field))
}

fn flag(r: &Record, field: &str) -> bool {
	r.get(field) == "1"
}

/// One record -> its events (most records give one; `map` gives none).
fn events_of(r: &Record, t: f64, st: &mut State, known: &Known) -> Vec<Ev> {
	if r.pos().is_some() && r.kind != Kind::Enter {
		// A position means the player is outdoors: no longer in the instance entered last.
		st.inst = None;
	}
	let mut e = Ev::new(t, r.kind.as_str());
	match r.kind {
		Kind::Chunk | Kind::Map => return Vec::new(),
		Kind::Session => {
			if let Some(l) = r.int("level").filter(|l| *l > 0) {
				st.lvl = Some(l);
			}
			e.opt("lvl", st.lvl);
		}
		Kind::Level => {
			st.lvl = r.int("level");
			e.opt("lvl", st.lvl).pos(r).int("played", r, "playedSeconds");
		}
		Kind::Xp => {
			st.xp = r.int("xp");
			st.xp_max = r.int("xpMax");
			st.rested = r.int("rested");
			e.opt("xp", st.xp).opt("xpMax", st.xp_max).opt("rested", st.rested);
		}
		Kind::Dropped => {
			e.int("count", r, "count");
		}
		Kind::Mark => {
			e.text("text", r, "text").pos(r);
		}
		Kind::Pos => {
			let flags = r.int("flags").unwrap_or(0);
			e.pos(r).set("flags", flags).opt("speed", r.int("speed").map(|s| round(s as f64 / 10.0, 1)));
			for (bit, name) in [(1, "mounted"), (2, "swimming"), (4, "indoors"), (8, "flying"), (16, "falling"), (32, "dead"), (64, "trail")] {
				if flags & bit != 0 {
					e.set(name, true);
				}
			}
		}
		Kind::Zone => {
			e.pos(r).text("zone", r, "zoneText").text("subzone", r, "subzoneText");
		}
		Kind::Ride => {
			e.set("on", flag(r, "on")).pos(r);
		}
		Kind::Taxi => {
			e.int("fromNode", r, "fromNode").int("toNode", r, "toNode");
		}
		Kind::Land => {
			e.int("node", r, "node").int("seconds", r, "seconds").pos(r);
		}
		Kind::Death => {
			e.pos(r).int("killer", r, "killerNpc").int("killerLvl", r, "killerLevel");
		}
		Kind::Revive => {
			let how = match r.get("how") {
				"s" => Some("spirit"),
				"c" => Some("corpse"),
				"r" => Some("resurrected"),
				_ => None,
			};
			e.pos(r).opt("how", how);
		}
		Kind::Combat => {
			st.combat = flag(r, "on");
			e.set("on", st.combat).pos(r);
		}
		Kind::Afk => {
			e.set("on", flag(r, "on"));
		}
		Kind::Rest => {
			let kind = match r.get("kind") {
				"f" => "food",
				"d" => "drink",
				_ => "both",
			};
			e.set("kind", kind).int("seconds", r, "seconds");
		}
		Kind::Offer => {
			e.who(r, "npcKind", "npcId", "").pos(r);
			for f in ["available", "active", "log", "done", "notOffered"] {
				e.set(f, ids(r, f));
			}
		}
		Kind::Detail => {
			e.int("q", r, "q").who(r, "npcKind", "npcId", "").pos(r).int("startItem", r, "startItem");
		}
		Kind::Text => {
			e.int("q", r, "q").text("title", r, "title").text("objectiveText", r, "objectiveText").text("detailText", r, "detailText");
		}
		Kind::Accept => {
			let q = r.int("q");
			e.int("q", r, "q").opt("title", q.and_then(|q| known.titles.get(&q).cloned())).who(r, "npcKind", "npcId", "").pos(r);
			if let Some(l) = r.int("level").filter(|l| *l > 0) {
				st.lvl = Some(l);
			}
			e.opt("lvl", st.lvl).int("rewardXp", r, "rewardXp").int("rewardMoney", r, "rewardMoney").set("items", ids(r, "items")).set("choices", ids(r, "choices"));
			let counts = |f: &str| Value::from(pairs(r, f).into_iter().map(|(i, n)| json!({ "item": i, "count": n })).collect::<Vec<_>>());
			e.set("itemCounts", counts("items")).set("choiceCounts", counts("choices"));
		}
		Kind::Objectives => {
			let list: Vec<Value> = r
				.list("list")
				.iter()
				.map(|p| {
					let text = p.get(2).copied().unwrap_or("");
					json!({ "type": p.first().copied().unwrap_or(""), "max": p.get(1).and_then(|m| m.parse::<i64>().ok()), "text": if text.is_empty() { Value::Null } else { Value::from(text) } })
				})
				.collect();
			e.int("q", r, "q").set("objectives", list);
		}
		Kind::Progress => {
			let (q, oi, cur, max) = (r.int("q"), r.int("index"), r.int("cur"), r.int("max"));
			e.opt("q", q).opt("oi", oi).opt("cur", cur).opt("max", max).pos(r);
			let obj = q.zip(oi).and_then(|(q, oi)| known.objectives.get(&q).and_then(|l| l.get((oi - 1).max(0) as usize).filter(|_| oi >= 1)));
			if let Some(o) = obj {
				if !o.kind.is_empty() {
					e.set("type", o.kind.as_str());
				}
				let name = objective_name(&o.text);
				if !name.is_empty() {
					e.set("text", format!("{name}: {}/{}", cur.unwrap_or(0), max.or(o.max).unwrap_or(0)));
				}
			}
			let mut out = vec![e];
			// The loot window just before, when it held one item and this objective was open.
			if let (Some(q), Some(oi)) = (q, oi) {
				if let Some(d) = st.drops.iter().rev().find(|d| r.t - d.t <= LOOT_PROGRESS && d.items.len() == 1 && d.wanted.contains(&(q, oi))) {
					let (item, count) = d.items[0];
					let mut l = Ev::new(t, "loot");
					l.set("item", item).set("count", count).set("q", q).set("oi", oi);
					if let Some((map, x, y)) = d.pos {
						l.set("map", map).set("x", x).set("y", y);
					}
					out.push(l);
					// The window's item was this objective's (the data build tells quest loot apart).
					let index = d.index;
					st.tags.push((index, q, oi));
				}
			}
			return out;
		}
		Kind::Complete | Kind::Abandon => {
			e.int("q", r, "q");
		}
		Kind::Turnin => {
			e.int("q", r, "q").who(r, "npcKind", "npcId", "").pos(r);
			if let Some(l) = r.int("level").filter(|l| *l > 0) {
				st.lvl = Some(l);
			}
			e.opt("lvl", st.lvl).int("xpReward", r, "xp").int("money", r, "money").int("chosen", r, "chosenItem");
		}
		Kind::Gossip => {
			e.who(r, "npcKind", "npcId", "").pos(r).int("option", r, "optionId").text("optionText", r, "optionText");
		}
		Kind::Cast => {
			e.int("spell", r, "spellId").int("item", r, "itemId").pos(r).who(r, "targetKind", "targetId", "target");
		}
		Kind::Escort => {
			e.int("q", r, "q").set("on", flag(r, "on")).pos(r);
		}
		Kind::Kill => {
			e.int("npc", r, "npcId").int("npcLvl", r, "level").opt("cls", rank(r.get("cls"))).pos(r).int("xp", r, "xp").int("rested", r, "rested");
			if flag(r, "tapped") {
				e.set("denied", true);
			}
			if let Some((q, oi)) = pairs(r, "q").first() {
				e.set("q", *q).set("oi", *oi);
			}
			e.inst(st);
		}
		Kind::Loot => {
			let gather = match r.get("gather") {
				"h" => Some("herb"),
				"m" => Some("mine"),
				"s" => Some("skin"),
				"f" => Some("fish"),
				_ => None,
			};
			let items = pairs(r, "items");
			let wanted = pairs(r, "wanted");
			e.who(r, "srcKind", "srcId", "").opt("gather", gather).pos(r);
			e.set("items", items.iter().map(|(i, n)| json!({ "item": i, "count": n })).collect::<Vec<_>>());
			e.set("wanted", wanted.iter().map(|(q, oi)| json!({ "q": q, "oi": oi })).collect::<Vec<_>>());
			e.inst(st);
			e.m.insert("e".into(), json!("drop"));
			st.drops.retain(|d| r.t - d.t <= LOOT_PROGRESS);
			st.drops.push(Drop { t: r.t, items, wanted, pos: r.pos().map(|p| (p.map, p.percent().0, p.percent().1)), index: st.next_index });
		}
		Kind::Unit => {
			let react = match r.get("react") {
				"h" => Some("hostile"),
				"n" => Some("neutral"),
				"f" => Some("friendly"),
				_ => None,
			};
			let src = match r.get("src") {
				"p" => Some("plate"),
				"t" => Some("target"),
				"m" => Some("mouseover"),
				_ => None,
			};
			e.int("npc", r, "npcId").int("npcLvl", r, "level").opt("cls", rank(r.get("cls"))).opt("react", react).opt("src", src).pos(r).inst(st);
		}
		Kind::Rare => {
			e.int("npc", r, "npcId").int("npcLvl", r, "level").opt("cls", rank(r.get("cls"))).text("src", r, "src").pos(r).inst(st);
		}
		Kind::Treasure => {
			e.int("object", r, "objectId").pos(r).inst(st);
		}
		Kind::Enter => {
			st.inst = r.int("instanceId");
			e.opt("inst", st.inst).text("instType", r, "instanceType").int("difficulty", r, "difficulty").pos(r);
		}
		Kind::Encounter => {
			e.int("enc", r, "encounterId").set("ok", flag(r, "ok")).int("difficulty", r, "difficulty").int("size", r, "size").inst(st);
		}
		Kind::Trainer => {
			let services: Vec<Value> = r
				.list("services")
				.iter()
				.map(|p| {
					let n = |i: usize| p.get(i).and_then(|s| s.parse::<i64>().ok());
					let state = match p.get(3).copied() {
						Some("a") => "available",
						Some("u") => "unavailable",
						_ => "known",
					};
					let mut o = json!({ "spell": n(0), "cost": n(1), "reqLevel": n(2), "state": state });
					if let Some(name) = p.get(4).filter(|s| !s.is_empty()) {
						o["name"] = json!(name);
					}
					o
				})
				.collect();
			e.int("npc", r, "npcId").pos(r).set("services", services);
		}
		Kind::Vendor => {
			let items: Vec<Value> = r
				.list("items")
				.iter()
				.map(|p| {
					let n = |i: usize| p.get(i).and_then(|s| s.parse::<i64>().ok());
					json!({ "item": n(0), "price": n(1), "stack": n(2), "qty": n(3) })
				})
				.collect();
			e.int("npc", r, "npcId").pos(r).set("items", items);
		}
		Kind::Flightmaster => {
			e.int("npc", r, "npcId").pos(r).int("node", r, "node").set("known", ids(r, "known"));
			e.m.insert("e".into(), json!("fp"));
		}
		Kind::Bind => {
			e.int("npc", r, "npcId").pos(r);
		}
		Kind::Rep => {
			e.int("faction", r, "factionId").int("standing", r, "standing").int("value", r, "value").int("delta", r, "delta");
		}
		Kind::Skill => {
			e.int("skillLine", r, "skillLineId").int("rank", r, "rank").int("max", r, "max");
		}
		Kind::Explore => {
			e.int("areaID", r, "areaId").int("xp", r, "xp").pos(r);
		}
		Kind::Learn => {
			e.int("spell", r, "spellId");
		}
		Kind::Craft => {
			e.int("spell", r, "recipeSpellId").int("item", r, "itemId").int("count", r, "count");
		}
		Kind::Achieve => {
			e.int("id", r, "id");
		}
		Kind::Step => {
			let how = r.get("reason");
			let reason = match how {
				"done" => "complete",
				"pick" => "guide",
				_ => "step",
			};
			e.text("guide", r, "guide").int("step", r, "step").set("reason", reason).set("how", how).pos(r);
			e.opt("lvl", st.lvl).opt("xp", st.xp).opt("xpMax", st.xp_max).opt("rested", st.rested).set("combat", st.combat);
		}
	}
	vec![e]
}

/// The session header's fields from a `session` record.
fn header_from(r: &Record, h: &mut Map<String, Value>) {
	let s = |f: &str| {
		let v = r.get(f);
		if v.is_empty() {
			Value::Null
		} else {
			Value::from(v)
		}
	};
	let n = |f: &str| r.int(f).map_or(Value::Null, Value::from);
	let mut packs = Vec::new();
	let mut guide = Value::Null;
	for p in r.list("packs") {
		let (id, version) = (p.first().copied().unwrap_or(""), p.get(1).copied().unwrap_or(""));
		if id == "guide" {
			guide = Value::from(version);
		} else if !id.is_empty() {
			packs.push(json!({ "id": id, "version": if version.is_empty() { Value::Null } else { Value::from(version) } }));
		}
	}
	h.insert("build".into(), n("build"));
	h.insert("interface".into(), n("interface"));
	h.insert("locale".into(), s("locale"));
	h.insert("region".into(), n("region"));
	h.insert("ruleset".into(), Value::from(r.get("ruleset")));
	h.insert("versions".into(), json!({ "recorder": s("recorderVersion"), "polestar": s("polestarVersion") }));
	h.insert("packs".into(), Value::from(packs));
	h.insert("guide".into(), guide);
	h.insert("char".into(), json!({ "id": r.get("charId"), "race": s("race"), "class": s("class"), "faction": s("faction"), "sex": n("sex"), "level": n("level") }));
}

fn known_of(chunks: &[&Chunk]) -> Known {
	let mut k = Known::default();
	for c in chunks {
		for r in &c.records {
			match r.kind {
				Kind::Text => {
					if let Some(q) = r.int("q") {
						if !r.get("title").is_empty() {
							k.titles.insert(q, r.get("title").to_string());
						}
					}
				}
				Kind::Objectives => {
					if let Some(q) = r.int("q") {
						let list = r
							.list("list")
							.iter()
							.map(|p| Objective { kind: p.first().copied().unwrap_or("").to_string(), max: p.get(1).and_then(|m| m.parse().ok()), text: p.get(2).copied().unwrap_or("").to_string() })
							.collect();
						k.objectives.insert(q, list);
					}
				}
				_ => {}
			}
		}
	}
	k
}

/// A session's id (and file name): `<start stamp>-<install>-<charId>` for the maintainer's own
/// (`local`), `<start stamp>-<contributor>-<install>-<charId>` for anyone else's, so two
/// contributors or installs never share one, whatever install ids or character ids they claim.
pub fn session_id(src: &Source, started: i64, char_id: &str) -> String {
	if src.contributor == "local" {
		format!("{}-{}-{char_id}", stamp(started), src.install)
	} else {
		format!("{}-{}-{}-{char_id}", stamp(started), src.contributor, src.install)
	}
}

fn session_json(src: &Source, char_id: &str, chunks: &[&Chunk], frames: &BTreeMap<u32, Value>, known: &Known) -> Value {
	let started = chunks.first().map_or(0, |c| c.epoch);
	let mut h = Map::new();
	h.insert("schema".into(), json!(SCHEMA));
	h.insert("session".into(), json!(session_id(src, started, char_id)));
	h.insert("contributor".into(), json!(src.contributor));
	h.insert("install".into(), json!(src.install));
	h.insert("charId".into(), json!(char_id));
	let mut fields = Map::new();
	if let Some(r) = chunks.iter().find_map(|c| c.session()) {
		header_from(r, &mut fields);
	} else {
		header_from(&Record { kind: Kind::Session, t: 0.0, fields: vec![char_id.to_string()] }, &mut fields);
	}
	// The latest versions and packs (a reload after an update changes them).
	if let Some(r) = chunks.iter().rev().find_map(|c| c.records.iter().rev().find(|r| r.kind == Kind::Session)) {
		let mut last = Map::new();
		header_from(r, &mut last);
		for k in ["versions", "packs", "guide"] {
			fields.insert(k.into(), last[k].clone());
		}
	}
	let ch = fields.remove("char").unwrap_or(Value::Null);
	h.extend(fields);
	h.insert("char".into(), ch);
	h.insert("started".into(), json!(started));
	let mut st = State::default();
	let mut events = Vec::new();
	let mut ended = started as f64;
	let mut touched = BTreeSet::new();
	for c in chunks {
		for r in &c.records {
			let t = round(r.t - started as f64, 1);
			ended = ended.max(r.t);
			st.next_index = events.len();
			for e in events_of(r, t, &mut st, known) {
				if let Some(m) = e.m.get("map").and_then(Value::as_u64) {
					touched.insert(m as u32);
				}
				events.push(Value::Object(e.m));
			}
			for (i, q, oi) in std::mem::take(&mut st.tags) {
				if let Some(item) = events.get_mut(i).and_then(|e| e["items"].get_mut(0)) {
					item["q"] = json!(q);
					item["oi"] = json!(oi);
				}
			}
		}
	}
	h.insert("ended".into(), json!(ended.round() as i64));
	h.insert("chunks".into(), Value::from(chunks.iter().map(|c| c.seq).collect::<Vec<_>>()));
	h.insert("events".into(), Value::from(events));
	// The maps the session touched and their parents.
	let mut maps = Map::new();
	let mut queue: Vec<u32> = touched.into_iter().collect();
	let mut seen = BTreeSet::new();
	while let Some(id) = queue.pop() {
		if !seen.insert(id) {
			continue;
		}
		if let Some(f) = frames.get(&id) {
			if let Some(p) = f["parent"].as_u64().filter(|p| *p > 0) {
				queue.push(p as u32);
			}
		}
	}
	for id in seen {
		if let Some(f) = frames.get(&id) {
			maps.insert(id.to_string(), f.clone());
		}
	}
	h.insert("maps".into(), Value::Object(maps));
	Value::Object(h)
}

/// Every session of every source, sorted by session id.
pub fn sessions(sources: &[Source]) -> Vec<Value> {
	let mut out = Vec::new();
	for src in sources {
		let mut frames: BTreeMap<u32, Value> = BTreeMap::new();
		for v in src.maps.values() {
			if let Some((id, f)) = map_frame(&v.split('\t').collect::<Vec<_>>()) {
				frames.insert(id, f);
			}
		}
		let mut by_char: BTreeMap<&str, Vec<&Chunk>> = BTreeMap::new();
		for c in &src.chunks {
			for r in c.records.iter().filter(|r| r.kind == Kind::Map) {
				if let Some((id, f)) = map_frame(&r.fields.iter().map(String::as_str).collect::<Vec<_>>()) {
					frames.insert(id, f);
				}
			}
			by_char.entry(c.char_id.as_str()).or_default().push(c);
		}
		for (char_id, mut chunks) in by_char {
			chunks.sort_by_key(|c| (c.epoch, c.seq));
			chunks.dedup_by_key(|c| c.seq);
			let known = known_of(&chunks);
			let mut start = 0;
			for i in 1..=chunks.len() {
				let split = i == chunks.len() || {
					let prev = chunks[i - 1];
					let prev_end = prev.records.last().map_or(prev.epoch as f64, |r| r.t);
					chunks[i].epoch as f64 - prev_end >= SESSION_GAP
				};
				if split {
					out.push(session_json(src, char_id, &chunks[start..i], &frames, &known));
					start = i;
				}
			}
		}
	}
	out.sort_by(|a, b| a["session"].as_str().cmp(&b["session"].as_str()));
	out
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::record::decode_chunk;

	fn chunk(seq: u64, epoch: i64, body: &str) -> Chunk {
		decode_chunk(&format!("chunk\t0\t{seq}\t{epoch}\tabcdefghij\n{body}")).unwrap()
	}

	#[test]
	fn stamps_utc() {
		assert_eq!(stamp(0), "19700101T000000Z");
		assert_eq!(stamp(1700000000), "20231114T221320Z");
		assert_eq!(stamp(951782400), "20000229T000000Z");
	}

	#[test]
	fn splits_sessions_and_maps_events() {
		let session = "session\t0\tabcdefghij\tScourge\tWARRIOR\tHorde\t2\t5\tenUS\t62345\t11508\t3\th\t2.0.0\t1.4.0\tguides:1.4.0;guide:horde/1-12\n";
		let a = chunk(
			1,
			1700000000,
			&format!(
				"{session}map\t0\t1420\t3\t1415\t0\t1000\t1000\t0\t0\nmap\t0\t1415\t2\t\t0\t5\t5\t0\t0\ntext\t5\t364\tThe Damned\tKill 8 zombies.\tGo.\nobjectives\t6\t364\tmonster:8:Mindless Zombie slain  0/8;item:4:Scarlet Insignia  0/4\naccept\t6\t364\tc\t1568\t1420\t3100\t6600\t5\t250\t\t2224:1\t\nkill\t20\t1501\t2\tn\t1420\t3200\t6500\t40\t\t1\t364:1\nprogress\t20\t364\t1\t1\t8\t1420\t3200\t6500\nloot\t30\tc\t1502\t1420\t3300\t6500\t\t3264:1\t364:2\nprogress\t35\t364\t2\t1\t4\t\t\t\nflightmaster\t40\t1572\t1420\t1\t2\t8\t8;11\nstep\t50\thorde/1-12\t4\tdone\t\t\t\n"
			),
		);
		let b = chunk(2, 1700000300, &format!("{session}pos\t10\t1420\t5000\t5000\t65\t71\n"));
		let c = chunk(3, 1700000300 + 4000, &format!("{session}level\t1\t6\t1420\t1\t1\t100\n"));
		let src = Source { contributor: "local".into(), install: "k3j9x0q2m7ab".into(), chunks: vec![c, b, a], maps: BTreeMap::new() };
		let out = sessions(&[src]);
		assert_eq!(out.len(), 2);
		let s = &out[0];
		assert_eq!(s["session"], "20231114T221320Z-k3j9x0q2m7ab-abcdefghij");
		// Anyone else's carries the contributor too: one claiming the same install and character
		// never shares the maintainer's session id.
		let other = Source { contributor: "0123456789abcdef".into(), install: "k3j9x0q2m7ab".into(), ..Source::default() };
		assert_eq!(session_id(&other, 1700000000, "abcdefghij"), "20231114T221320Z-0123456789abcdef-k3j9x0q2m7ab-abcdefghij");
		assert_eq!((s["schema"].as_u64(), s["contributor"].as_str(), s["locale"].as_str(), s["build"].as_u64()), (Some(2), Some("local"), Some("enUS"), Some(62345)));
		assert_eq!(s["char"], json!({ "id": "abcdefghij", "race": "Scourge", "class": "WARRIOR", "faction": "Horde", "sex": 2, "level": 5 }));
		assert_eq!(s["packs"], json!([{ "id": "guides", "version": "1.4.0" }]));
		assert_eq!(s["guide"], "horde/1-12");
		assert_eq!(s["chunks"], json!([1, 2]));
		assert!(s.get("realm").is_none() && s["char"].get("name").is_none());
		let ev = s["events"].as_array().unwrap();
		let find = |e: &str| ev.iter().find(|x| x["e"] == e).unwrap_or_else(|| panic!("no {e}"));
		assert_eq!(find("accept")["title"], "The Damned");
		assert_eq!((find("accept")["npc"].as_u64(), find("accept")["x"].as_f64(), find("accept")["lvl"].as_u64()), (Some(1568), Some(31.0), Some(5)));
		assert_eq!(find("accept")["items"], json!([2224]));
		let kill = find("kill");
		assert_eq!(
			(kill["npc"].as_u64(), kill["npcLvl"].as_u64(), kill["cls"].as_str(), kill["denied"].as_bool(), kill["q"].as_u64(), kill["oi"].as_u64()),
			(Some(1501), Some(2), Some("normal"), Some(true), Some(364), Some(1))
		);
		assert!(kill.get("lvl").is_none());
		assert_eq!(find("progress")["text"], "Mindless Zombie slain: 1/8");
		assert_eq!(find("progress")["type"], "monster");
		assert_eq!(find("drop")["items"], json!([{ "item": 3264, "count": 1, "q": 364, "oi": 2 }]));
		let loot = find("loot");
		assert_eq!((loot["item"].as_u64(), loot["q"].as_u64(), loot["oi"].as_u64(), loot["map"].as_u64()), (Some(3264), Some(364), Some(2), Some(1420)));
		assert_eq!(find("fp")["known"], json!([8, 11]));
		assert_eq!(find("step")["reason"], "complete");
		assert_eq!(find("pos")["t"].as_f64(), Some(301.0));
		assert_eq!((find("pos")["speed"].as_f64(), find("pos")["mounted"].as_bool(), find("pos")["trail"].as_bool()), (Some(7.1), Some(true), Some(true)));
		assert_eq!(s["maps"]["1420"], json!({ "type": 3, "parent": 1415, "c": 0, "left": 1000.0, "right": 0.0, "top": 1000.0, "bottom": 0.0 }));
		assert!(s["maps"].get("1415").is_some());
		assert_eq!(out[1]["events"].as_array().unwrap().iter().find(|e| e["e"] == "level").unwrap()["lvl"], 6);
	}

	#[test]
	fn objective_names() {
		assert_eq!(objective_name("Kobold Vermin slain: 0/8"), "Kobold Vermin slain");
		assert_eq!(objective_name("Kobold Vermin slain  0/8"), "Kobold Vermin slain");
		assert_eq!(objective_name("Find the camp"), "Find the camp");
		assert_eq!(objective_name("Ratio: a/b"), "Ratio: a/b");
	}
}
