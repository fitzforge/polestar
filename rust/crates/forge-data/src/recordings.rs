//! Recorder overlay (port of tools/lib/data/recordings.js): data/recordings/*.json, live Forever
//! observations, applied over the merged tables. See the JS file's header for every rule.
//!
//! Trust (docs/RECORDING.md "Trust"): sessions from a build older than data/recordings/config.json's
//! `minBuild` are left out; names (quest titles, NPC, object, item, faction, instance and zone names)
//! from a session whose locale is not enUS only fill a missing name; a recorded spawn, a learned path
//! (travel/paths.rs), a drop chance, a quest's XP or a class trainer (trainers.rs) replaces another
//! source's only with the evidence of at least two distinct counted players, or of the
//! maintainer's own (`local`) recordings. A player is a [`Recording::voter`]: the server's cohort
//! (contributors registered from one network on one day share one), else the contributor. A
//! player counts once per fact however many sessions, installs or tokens it has, and only once
//! established ([`establish`]: `local` and `sent-*`, a file the maintainer vouched for, always are).
//! A single or new player still fills gaps no other source has a value for. A number several
//! players recorded (a drop chance, a quest's XP) is the median of each player's own value, so one
//! heavy player cannot pull it. Schema 1 sessions count as `local` and enUS.

use std::path::Path;

use forge_guide::js::{cmp_utf16, parse_json, stringify, Obj, V};
use indexmap::{IndexMap, IndexSet};
use rustc_hash::FxHashMap;
use sha2::{Digest, Sha256};

use crate::jsv::{arr, hypot, nums, round2};
use crate::objectives::parse_progress_text;
use crate::spawns::{points_of, reduce_spawns, spawn_record, SpawnOptions, P};

pub struct Recording {
	pub file: String,
	pub rec: V,
	/// Whether the session's player counts toward the two-player quorum ([`establish`]).
	pub counts: bool,
}

/// The contributor of the maintainer's own recordings (`forge record import`).
pub const LOCAL: &str = "local";

impl Recording {
	/// Who recorded the session (`local` for schema 1 and the maintainer's own imports).
	pub fn contributor(&self) -> String {
		self.rec.get("contributor").as_str().filter(|c| !c.is_empty()).unwrap_or(LOCAL).to_string()
	}

	/// The player the quorum counts: `cohort:<id>` for a pulled session whose header carries the
	/// server's cohort (16 hex digits), else the contributor (`local`, `sent-*`, `anon-*`, and
	/// sessions pulled before the server exported cohorts).
	pub fn voter(&self) -> String {
		match self.rec.get("cohort").as_str().filter(|c| c.len() == 16 && c.bytes().all(|b| b.is_ascii_digit() || (b'a'..=b'f').contains(&b))) {
			Some(c) => format!("cohort:{c}"),
			None => self.contributor(),
		}
	}

	/// Whether the session's names are English (schema 1 sessions carry no locale and are).
	pub fn english(&self) -> bool {
		self.rec.get("locale").as_str().is_none_or(|l| l == "enUS")
	}
}

/// Whether evidence from these counted players may replace another source's value.
pub fn trusted(voters: &IndexSet<String>) -> bool {
	voters.contains(LOCAL) || voters.len() >= 2
}

/// How established a server contributor must be to count toward the quorum (config.json's
/// `minContributorDays`, `minContributorChunks`, `minContributorPlayDays`, `minContributorHours`,
/// `minContributorPos`, `minContributorKills`).
#[derive(Clone, Copy, Debug)]
pub struct Establish {
	/// Days from first seen to its newest session's arrival.
	pub min_days: f64,
	pub min_chunks: f64,
	/// Distinct UTC days its sessions started or ended on.
	pub min_play_days: f64,
	/// Hours its sessions span, summed.
	pub min_hours: f64,
	/// `pos` and `kill` events over its sessions.
	pub min_pos: f64,
	pub min_kills: f64,
}

pub const ESTABLISH: Establish = Establish { min_days: 3.0, min_chunks: 20.0, min_play_days: 3.0, min_hours: 2.0, min_pos: 10.0, min_kills: 5.0 };

/// What a contributor's sessions say about it.
struct Play {
	since: f64,
	newest: f64,
	chunks: f64,
	days: rustc_hash::FxHashSet<i64>,
	secs: f64,
	pos: f64,
	kills: f64,
}

/// Marks the sessions whose player counts toward the quorum. A contributor is established when it
/// is `local` or `sent-*` (a file the maintainer vouched for); `anon-*` (a sent-in file nobody
/// vouched for) never is; a server contributor is once it shows substantive play, by what forge
/// record pull wrote in its sessions' headers: first seen (`contributorSince`, the earliest any of
/// its sessions says) at least `min_days` days before its newest session arrived (`received`), at
/// least `min_chunks` chunks sent (`contributorChunks`, the most any says), sessions on at least
/// `min_play_days` distinct UTC days spanning `min_hours` hours in all, and at least `min_pos`
/// positions and `min_kills` kills recorded. A player ([`Recording::voter`]) counts when any of its
/// contributors is established; every session of it is marked alike.
pub fn establish(recs: &mut [Recording], e: Establish) {
	let mut by: FxHashMap<String, Play> = FxHashMap::default();
	for r in recs.iter() {
		let num = |k: &str| r.rec.get(k).as_num().filter(|n| n.is_finite() && *n > 0.0);
		let s = by.entry(r.contributor()).or_insert_with(|| Play { since: f64::INFINITY, newest: f64::NEG_INFINITY, chunks: 0.0, days: Default::default(), secs: 0.0, pos: 0.0, kills: 0.0 });
		if let Some(x) = num("contributorSince") {
			s.since = s.since.min(x);
		}
		if let Some(x) = num("received") {
			s.newest = s.newest.max(x);
		}
		if let Some(x) = num("contributorChunks") {
			s.chunks = s.chunks.max(x);
		}
		if let (Some(a), Some(b)) = (num("started"), num("ended")) {
			if b >= a {
				s.days.insert((a / 86400.0).floor() as i64);
				s.days.insert((b / 86400.0).floor() as i64);
				s.secs += b - a;
			}
		}
		for ev in r.rec.get("events").items() {
			match ev.get("e").as_str() {
				Some("pos") => s.pos += 1.0,
				Some("kill") => s.kills += 1.0,
				_ => {}
			}
		}
	}
	let established = |c: &str| {
		c == LOCAL
			|| c.starts_with("sent-")
			|| (!c.starts_with("anon-")
				&& by.get(c).is_some_and(|p| {
					p.newest - p.since >= e.min_days * 86400.0
						&& p.chunks >= e.min_chunks
						&& p.days.len() as f64 >= e.min_play_days
						&& p.secs >= e.min_hours * 3600.0
						&& p.pos >= e.min_pos
						&& p.kills >= e.min_kills
				}))
	};
	let mut voters: FxHashMap<String, bool> = FxHashMap::default();
	for r in recs.iter() {
		let ok = established(&r.contributor());
		*voters.entry(r.voter()).or_default() |= ok;
	}
	for r in recs.iter_mut() {
		r.counts = voters[&r.voter()];
	}
}

/// data/recordings/*.json (schema 1 or 2; `config.json` and dot files are not sessions), less the
/// sessions of builds older than `config.json`'s `minBuild`, each marked by [`establish`].
pub fn read_recordings(dir: &Path) -> Result<Vec<Recording>, String> {
	let Ok(rd) = std::fs::read_dir(dir) else { return Ok(Vec::new()) };
	let mut files: Vec<String> = rd.flatten().map(|e| e.file_name().to_string_lossy().to_string()).filter(|f| f.ends_with(".json") && !f.starts_with('.') && f != "config.json").collect();
	files.sort_by(|a, b| cmp_utf16(a, b));
	let (min_build, est) = match std::fs::read_to_string(dir.join("config.json")) {
		Ok(text) => {
			let c = parse_json(&text).map_err(|e| format!("recordings config.json: {e}"))?;
			let at_least_0 = |k: &str, d: f64| c.get(k).as_num().filter(|n| n.is_finite() && *n >= 0.0).unwrap_or(d);
			let d = ESTABLISH;
			(
				c.get("minBuild").as_num().filter(|n| n.is_finite()),
				Establish {
					min_days: at_least_0("minContributorDays", d.min_days),
					min_chunks: at_least_0("minContributorChunks", d.min_chunks),
					min_play_days: at_least_0("minContributorPlayDays", d.min_play_days),
					min_hours: at_least_0("minContributorHours", d.min_hours),
					min_pos: at_least_0("minContributorPos", d.min_pos),
					min_kills: at_least_0("minContributorKills", d.min_kills),
				},
			)
		}
		Err(_) => (None, ESTABLISH),
	};
	let mut out = Vec::new();
	for file in files {
		let text = std::fs::read_to_string(dir.join(&file)).map_err(|e| format!("recording {file}: {e}"))?;
		let rec = parse_json(&text).map_err(|e| format!("recording {file}: {e}"))?;
		if !matches!(rec.get("schema").as_num(), Some(1.0) | Some(2.0)) || !rec.get("events").is_arr() {
			return Err(format!("recording {file}: expected {{ schema: 1 or 2, events: [...] }}"));
		}
		if let (Some(min), Some(build)) = (min_build, rec.get("build").as_num()) {
			if build < min {
				continue;
			}
		}
		out.push(Recording { file, rec, counts: false });
	}
	establish(&mut out, est);
	Ok(out)
}

/// meta.json's revision of the recordings: sha256 over file names and contents, 16 hex digits.
pub fn revision(recs: &[Recording]) -> String {
	let mut h = Sha256::new();
	for r in recs {
		h.update(r.file.as_bytes());
		h.update(b"\0");
		h.update(stringify(&r.rec, None).as_bytes());
		h.update(b"\0");
	}
	h.finalize().iter().map(|b| format!("{b:02x}")).collect::<String>()[..16].to_string()
}

fn pos_int(v: &V) -> Option<i64> {
	let n = v.num();
	(n.is_finite() && n.fract() == 0.0 && n > 0.0).then_some(n as i64)
}

struct Coord {
	map: i64,
	x: f64,
	y: f64,
}

fn coord(ev: &V) -> Option<Coord> {
	let map = pos_int(&ev.get("map"))?;
	let (x, y) = (ev.get("x").num(), ev.get("y").num());
	if !x.is_finite() || !y.is_finite() || !(0.0..=100.0).contains(&x) || !(0.0..=100.0).contains(&y) {
		return None;
	}
	Some(Coord { map, x, y })
}

fn same(a: &V, b: &str) -> bool {
	a.as_str().is_some_and(|a| a.trim().to_lowercase() == b.trim().to_lowercase())
}

fn ids(v: &V) -> Vec<i64> {
	let mut out: Vec<i64> = Vec::new();
	if v.is_arr() {
		for x in v.items() {
			if let Some(n) = pos_int(&x) {
				if !out.contains(&n) {
					out.push(n);
				}
			}
		}
	}
	out
}

fn front(list: &V, id: i64) {
	if !list.items().iter().any(|x| x.as_num() == Some(id as f64)) {
		if let V::Arr(a) = list {
			a.0.borrow_mut().insert(0, V::Num(id as f64));
		}
	}
}

fn new_quest(id: i64) -> Obj {
	let o = Obj::new();
	o.set("id", id as f64);
	for k in ["title", "level", "minLevel", "races", "classes"] {
		o.set(k, V::Null);
	}
	let st = Obj::new();
	st.set("npc", V::arr());
	st.set("object", V::arr());
	st.set("item", V::arr());
	o.set("start", st);
	let en = Obj::new();
	en.set("npc", V::arr());
	en.set("object", V::arr());
	o.set("end", en);
	o.set("pre", V::arr());
	o.set("excl", V::arr());
	o.set("next", V::Null);
	o.set("objectives", V::arr());
	for k in ["objectiveText", "zone", "xp", "skill", "event"] {
		o.set(k, V::Null);
	}
	o.set("source", arr(vec![V::str("recorder")]));
	o
}

fn has_str(list: &V, s: &str) -> bool {
	list.items().iter().any(|x| x.as_str() == Some(s))
}

fn canonical(e: &V, keys: &[&str]) -> V {
	let src = e.as_obj().unwrap();
	let out = Obj::new();
	for k in keys {
		if src.has(k) {
			out.set(k, src.get(k));
		}
	}
	for (k, v) in src.entries() {
		if !out.has(&k) {
			out.set_str(k, v);
		}
	}
	V::Obj(out)
}

const NPC_KEYS: [&str; 10] = ["id", "name", "level", "levelMax", "rank", "faction", "roles", "spawns", "instances", "encounter"];
const OBJECT_KEYS: [&str; 6] = ["id", "name", "roles", "faction", "spawns", "instances"];
/// sim-v2: objects carry no side.
const OBJECT_KEYS_SIM: [&str; 5] = ["id", "name", "roles", "spawns", "instances"];
const QUEST_KEYS: [&str; 20] =
	["id", "title", "level", "minLevel", "races", "classes", "start", "end", "pre", "excl", "next", "objectives", "objectiveText", "zone", "xp", "xpSamples", "rewards", "skill", "event", "source"];
const FACTION_KEYS: [&str; 5] = ["id", "name", "side", "parent", "source"];
const MIN_KILLS: f64 = 10.0;
const ENTRANCE_RADIUS: f64 = 1.5;
const FULL_XP_LEVELS: f64 = 5.0;

fn rank_of(cls: &str) -> Option<f64> {
	Some(match cls {
		"normal" | "trivial" | "minus" => 0.0,
		"elite" => 1.0,
		"rareelite" => 2.0,
		"worldboss" => 3.0,
		"rare" => 4.0,
		_ => return None,
	})
}

pub struct Db<'a> {
	pub quests: &'a Obj,
	pub npcs: &'a Obj,
	pub objects: &'a Obj,
	pub items: &'a Obj,
	pub zones: &'a Obj,
	pub factions: &'a Obj,
	pub instances: &'a Obj,
}

#[derive(Default)]
pub struct Stats {
	pub recordings: usize,
	pub events: usize,
	pub recorder_only_quests: usize,
	pub touched_quests: usize,
	pub recorder_only_factions: usize,
	pub recorded_kills: usize,
	pub recorded_loots: usize,
	pub recorded_sightings: usize,
	pub recorded_drop_chances: usize,
	pub recorded_treasures: usize,
	pub recorded_instances: usize,
	pub recorded_encounters: usize,
}

type ByMap = IndexMap<i64, Vec<P>>;

struct Inst {
	name: Option<String>,
	kind: Option<String>,
	encounters: IndexMap<i64, Enc>,
}

struct Enc {
	name: Option<String>,
	npcs: IndexSet<i64>,
	kills: usize,
}

struct Overlay<'a> {
	db: &'a Db<'a>,
	so: SpawnOptions,
	live_maps: &'a dyn Fn(i64) -> bool,
	stats: Stats,
	touched: IndexSet<i64>,
	touched_entities: IndexMap<String, (&'static str, i64)>,
	live: [IndexMap<i64, ByMap>; 2],
	recorded_objectives: IndexMap<i64, IndexMap<i64, Slot>>,
	/// quest -> (kind, xp, player level, contributor index) observations.
	xp_seen: IndexMap<i64, Vec<(&'static str, i64, Option<i64>, usize)>>,
	faction_parent: IndexMap<i64, i64>,
	faction_side: FxHashMap<i64, String>,
	rewards: FxHashMap<i64, (u8, V)>,
	// finds, counted per contributor index (one contributor's numbers never pool with another's)
	kills: FxHashMap<i64, IndexMap<usize, f64>>,
	windows: [FxHashMap<i64, IndexMap<usize, f64>>; 2],
	/// source -> item -> contributor -> loot windows holding the item.
	loots: [IndexMap<i64, IndexMap<i64, IndexMap<usize, f64>>>; 2],
	found: [IndexMap<i64, ByMap>; 2],
	killed: IndexMap<i64, ByMap>,
	rank: IndexMap<i64, f64>,
	levels: IndexMap<i64, (i64, i64)>,
	roles: [IndexMap<i64, IndexSet<String>>; 2],
	inside: [IndexMap<i64, IndexSet<i64>>; 2],
	encounter_of: IndexMap<i64, i64>,
	entrances: IndexMap<i64, ByMap>,
	inst: IndexMap<i64, Inst>,
	// trust: the current session's contributor, its index, whether it counts toward the quorum
	// and whether its names are English
	contributor: String,
	ci: usize,
	counts: bool,
	english: bool,
	/// Every contributor seen (index -> id) and whether each counts.
	contributors: IndexSet<String>,
	counting: Vec<bool>,
	/// (WHO_LIVE/WHO_FOUND + table index, id, map) -> counted contributors of the points.
	who: FxHashMap<(usize, i64, i64), IndexSet<String>>,
}

const WHO_LIVE: usize = 0;
const WHO_FOUND: usize = 2;

#[derive(Default)]
struct Slot {
	name: Option<String>,
	max: Option<f64>,
	kind: Option<String>,
	id: Option<i64>,
}

fn table_of<'a>(db: &'a Db, kind: &str) -> &'a Obj {
	if kind == "npc" {
		db.npcs
	} else {
		db.objects
	}
}

fn k_ix(kind: &str) -> usize {
	if kind == "npc" {
		0
	} else {
		1
	}
}

fn push_point(m: &mut IndexMap<i64, ByMap>, id: i64, c: &Coord) {
	m.entry(id).or_default().entry(c.map).or_default().push([c.x, c.y]);
}

/// Whether a recorded name may be written over `cur`: English names always, others only where
/// there is none.
fn may_name(english: bool, cur: &V) -> bool {
	english || !cur.truthy()
}

impl<'a> Overlay<'a> {
	fn quest(&mut self, id: i64) -> V {
		let k = id.to_string();
		if !self.db.quests.has(&k) {
			self.db.quests.set(&k, new_quest(id));
			self.stats.recorder_only_quests += 1;
		}
		self.touched.insert(id);
		self.db.quests.get(&k)
	}

	fn entity(&mut self, kind: &'static str, id: i64, name: &V) -> V {
		let t = table_of(self.db, kind);
		let k = id.to_string();
		if !t.has(&k) {
			let o = Obj::new();
			o.set("id", id as f64);
			o.set("name", V::Null);
			if kind == "npc" {
				o.set("level", V::Null);
				o.set("faction", V::Null);
			}
			o.set("spawns", Obj::new());
			t.set(&k, o);
		}
		let e = t.get(&k);
		if let Some(n) = name.as_str().filter(|n| !n.is_empty()) {
			if may_name(self.english, &e.get("name")) {
				e.set("name", n);
			}
		}
		self.touched_entities.insert(format!("{kind}:{id}"), (kind, id));
		e
	}

	fn item_entry(&mut self, id: i64, name: &V) {
		let k = id.to_string();
		if !self.db.items.has(&k) {
			let o = Obj::new();
			o.set("id", id as f64);
			o.set("name", V::Null);
			let d = Obj::new();
			d.set("npc", Obj::new());
			d.set("object", Obj::new());
			o.set("drops", d);
			o.set("vendors", V::arr());
			self.db.items.set(&k, o);
		}
		if let Some(n) = name.as_str().filter(|n| !n.is_empty()) {
			let it = self.db.items.get(&k);
			if may_name(self.english, &it.get("name")) {
				it.set("name", n);
			}
		}
	}

	fn live_point(&mut self, kind: &'static str, id: i64, name: &V, ev: &V) -> V {
		let e = self.entity(kind, id, name);
		if let Some(c) = coord(ev) {
			push_point(&mut self.live[k_ix(kind)], id, &c);
			self.note(WHO_LIVE + k_ix(kind), id, c.map);
		}
		e
	}

	/// The current session's contributor backs the points of (`slot`, `id`, `map`), if it counts.
	fn note(&mut self, slot: usize, id: i64, map: i64) {
		if !self.counts {
			return;
		}
		let who = self.who.entry((slot, id, map)).or_default();
		if !who.contains(&self.contributor) {
			who.insert(self.contributor.clone());
		}
	}

	fn trusted_at(&self, slot: usize, id: i64, map: i64) -> bool {
		self.who.get(&(slot, id, map)).is_some_and(trusted)
	}

	fn xp_obs(&mut self, qid: i64, kind: &'static str, value: &V, lvl: &V) {
		let Some(xp) = pos_int(value) else { return };
		self.xp_seen.entry(qid).or_default().push((kind, xp, pos_int(lvl), self.ci));
	}

	fn slot(&mut self, q: i64, oi: i64) -> &mut Slot {
		self.recorded_objectives.entry(q).or_default().entry(oi).or_default()
	}

	fn faction(&mut self, id: i64, name: &V) -> V {
		let k = id.to_string();
		if !self.db.factions.has(&k) {
			let o = Obj::new();
			o.set("id", id as f64);
			o.set("name", V::Null);
			o.set("side", V::Null);
			o.set("parent", V::Null);
			o.set("source", V::arr());
			self.db.factions.set(&k, o);
			self.stats.recorder_only_factions += 1;
		}
		let f = self.db.factions.get(&k);
		if let Some(n) = name.as_str() {
			if !n.trim().is_empty() && may_name(self.english, &f.get("name")) {
				f.set("name", n.trim());
			}
		}
		let src = f.get("source");
		if !has_str(&src, "recorder") {
			src.push("recorder");
		}
		f
	}

	fn faction_dump(&mut self, dump: &V) {
		let entries: Vec<(V, V)> = match dump {
			V::Arr(_) => dump.items().into_iter().map(|d| (if d.truthy() { d.get("id") } else { d.clone() }, d)).collect(),
			V::Obj(o) => o.entries().into_iter().map(|(k, v)| (V::Str(k), v)).collect(),
			_ => Vec::new(),
		};
		for (key, d) in entries {
			let id = pos_int(&key).or_else(|| {
				if d.truthy() {
					pos_int(&{
						let i = d.get("id");
						if i.is_nullish() {
							d.get("factionID")
						} else {
							i
						}
					})
				} else {
					None
				}
			});
			let Some(id) = id else { continue };
			if !d.is_obj() {
				continue;
			}
			self.faction(id, &d.get("name"));
			let p = {
				let a = d.get("parent");
				if !a.is_nullish() {
					a
				} else {
					let b = d.get("parentID");
					if !b.is_nullish() {
						b
					} else {
						d.get("parentFactionID")
					}
				}
			};
			if let Some(p) = pos_int(&p) {
				if p != id {
					self.faction_parent.insert(id, p);
				}
			}
			if let Some(s) = d.get("side").as_str().filter(|s| *s == "Alliance" || *s == "Horde") {
				self.faction_side.insert(id, s.to_string());
			}
		}
	}

	fn rewards_observe(&mut self, qid: i64, ev: &V, weight: u8) {
		let items = ids(&ev.get("items"));
		let choices = ids(&ev.get("choices"));
		let frame_money = pos_int(&ev.get("rewardMoney"));
		if items.is_empty() && choices.is_empty() && frame_money.is_none() {
			return;
		}
		let money = frame_money.or(if weight == 2 { pos_int(&ev.get("money")) } else { None });
		if let Some((w, _)) = self.rewards.get(&qid) {
			if *w > weight {
				return;
			}
		}
		let o = Obj::new();
		o.set("items", nums(&items.iter().map(|&x| x as f64).collect::<Vec<_>>()));
		o.set("choices", nums(&choices.iter().map(|&x| x as f64).collect::<Vec<_>>()));
		o.set("money", money.map(|m| V::Num(m as f64)).unwrap_or(V::Null));
		self.rewards.insert(qid, (weight, V::Obj(o)));
	}

	// ---- finds
	fn unit(&mut self, id: i64, ev: &V) {
		self.entity("npc", id, &ev.get("npcName"));
		let cls = ev.get("cls").to_js_string();
		if ev.get("cls").is_str() || !ev.get("cls").is_undef() {
			if let Some(r) = rank_of(&cls) {
				self.rank.insert(id, r);
			}
		}
		if cls == "rare" || cls == "rareelite" {
			self.roles[0].entry(id).or_default().insert("rare".into());
		}
		if let Some(l) = pos_int(&ev.get("npcLvl")) {
			let r = self.levels.get(&id).map(|&(a, b)| (a.min(l), b.max(l))).unwrap_or((l, l));
			self.levels.insert(id, r);
		}
		self.where_(0, id, ev);
	}

	fn where_(&mut self, k: usize, id: i64, ev: &V) {
		if let Some(i) = pos_int(&ev.get("inst")) {
			self.inside[k].entry(id).or_default().insert(i);
		}
	}

	fn instance(&mut self, id: i64, ev: &V) -> &mut Inst {
		let english = self.english;
		let i = self.inst.entry(id).or_insert_with(|| Inst { name: None, kind: None, encounters: IndexMap::new() });
		if let Some(n) = ev.get("instName").as_str().filter(|n| !n.is_empty()) {
			if english || i.name.is_none() {
				i.name = Some(n.to_string());
			}
		}
		if let Some(t) = ev.get("instType").as_str().filter(|t| *t == "party" || *t == "raid") {
			i.kind = Some(t.to_string());
		}
		i
	}

	fn handle_find(&mut self, ev: &V) -> bool {
		let npc = pos_int(&ev.get("npc"));
		let obj = pos_int(&ev.get("object"));
		match ev.get("e").as_str().unwrap_or("") {
			"rare" => {
				let Some(npc) = npc else { return true };
				self.unit(npc, ev);
				self.roles[0].entry(npc).or_default().insert("rare".into());
				if let Some(c) = coord(ev) {
					push_point(&mut self.found[0], npc, &c);
					self.note(WHO_FOUND, npc, c.map);
				}
				self.stats.recorded_sightings += 1;
				true
			}
			"treasure" => {
				let Some(obj) = obj else { return true };
				self.entity("object", obj, &ev.get("objName"));
				self.roles[1].entry(obj).or_default().insert("chest".into());
				if let Some(c) = coord(ev) {
					push_point(&mut self.found[1], obj, &c);
					self.note(WHO_FOUND + 1, obj, c.map);
				}
				self.where_(1, obj, ev);
				self.stats.recorded_sightings += 1;
				true
			}
			"slain" => {
				let Some(npc) = npc else { return true };
				self.slain(npc, ev);
				true
			}
			"drop" => {
				let list: Vec<V> = ev.get("items").items().into_iter().filter(|i| i.truthy() && pos_int(&i.get("item")).is_some()).collect();
				let kind = if npc.is_some() {
					Some("npc")
				} else if obj.is_some() {
					Some("object")
				} else {
					None
				};
				let gather = ev.get("gather");
				if kind.is_none() || (kind == Some("npc") && gather.truthy()) {
					if let Some(n) = npc {
						self.unit(n, ev);
					}
					return true;
				}
				let kind = kind.unwrap();
				let id = npc.or(obj).unwrap();
				if kind == "npc" {
					self.unit(id, ev);
				} else {
					self.entity("object", id, &ev.get("objName"));
					self.where_(1, id, ev);
					if let Some(c) = coord(ev) {
						push_point(&mut self.found[1], id, &c);
						self.note(WHO_FOUND + 1, id, c.map);
					}
					let role = match gather.as_str() {
						Some("herb") => Some("herb"),
						Some("mine") => Some("mine"),
						_ if !gather.truthy() && list.iter().any(|i| !i.get("q").truthy()) => Some("chest"),
						_ => None,
					};
					if let Some(r) = role {
						self.roles[1].entry(id).or_default().insert(r.into());
					}
				}
				let k = k_ix(kind);
				let ci = self.ci;
				*self.windows[k].entry(id).or_default().entry(ci).or_insert(0.0) += 1.0;
				let mut seen: IndexSet<i64> = IndexSet::new();
				for i in &list {
					seen.insert(pos_int(&i.get("item")).unwrap());
				}
				for item in seen {
					*self.loots[k].entry(id).or_default().entry(item).or_default().entry(ci).or_insert(0.0) += 1.0;
					self.item_entry(item, &V::Undef);
				}
				self.loots[k].entry(id).or_default();
				self.stats.recorded_loots += 1;
				true
			}
			"enter" => {
				let Some(id) = pos_int(&ev.get("inst")) else { return true };
				self.instance(id, ev);
				if let Some(c) = coord(ev) {
					push_point(&mut self.entrances, id, &c);
				}
				true
			}
			"encounter" => {
				let id = pos_int(&ev.get("inst"));
				let Some(enc) = pos_int(&ev.get("enc")) else { return true };
				let bosses = ids(&ev.get("npcs"));
				for &b in &bosses {
					self.entity("npc", b, &V::Null);
					self.encounter_of.insert(b, enc);
					if let Some(i) = id {
						self.inside[0].entry(b).or_default().insert(i);
					}
				}
				let Some(id) = id else { return true };
				let ok = ev.get("ok").truthy();
				let enc_name = ev.get("encName");
				let english = self.english;
				let e = self.instance(id, ev).encounters.entry(enc).or_insert_with(|| Enc { name: None, npcs: IndexSet::new(), kills: 0 });
				if let Some(n) = enc_name.as_str().filter(|n| !n.is_empty()) {
					if english || e.name.is_none() {
						e.name = Some(n.to_string());
					}
				}
				for b in bosses {
					e.npcs.insert(b);
				}
				if ok {
					e.kills += 1;
				}
				true
			}
			_ => false,
		}
	}

	/// A creature the player killed: its level and rank, where it died (fills spawns only) and
	/// the kill count behind its drop chances.
	fn slain(&mut self, npc: i64, ev: &V) {
		self.unit(npc, ev);
		if let Some(c) = coord(ev) {
			push_point(&mut self.killed, npc, &c);
		}
		if !ev.get("denied").truthy() {
			*self.kills.entry(npc).or_default().entry(self.ci).or_insert(0.0) += 1.0;
		}
		self.stats.recorded_kills += 1;
	}

	/// Recorded points into an entity's spawns: a map without spawns gets them; another source's
	/// spawns on a map Forever did not change are merged with them only on trusted evidence
	/// (`slot`: WHO_FOUND + table index); `fill_only` never touches existing spawns.
	fn join(&self, e: &V, by_map: &ByMap, fill_only: bool, slot: usize, id: i64) {
		let spawns = e.get("spawns");
		for (&map, pts) in by_map {
			let cur = spawns.get(&map.to_string());
			if !cur.is_undef() && (fill_only || (cur.get("f").as_str() != Some("l") && ((self.live_maps)(map) || !self.trusted_at(slot, id, map)))) {
				continue;
			}
			let all: Vec<P> = if cur.is_undef() { pts.clone() } else { points_of(&cur.get("pts")).into_iter().chain(points_of(&cur.get("more"))).chain(pts.iter().copied()).collect() };
			let r = reduce_spawns(&all, self.so);
			if !r.pts.is_empty() {
				let f = if cur.is_undef() { "l".to_string() } else { cur.get("f").to_js_string() };
				spawns.set(&map.to_string(), spawn_record(&f, &r));
			}
		}
	}

	fn apply_finds(&mut self) {
		let db = self.db;
		let mut chances = 0;
		for kind in ["npc", "object"] {
			let k = k_ix(kind);
			for (&id, m) in &self.loots[k] {
				// Each contributor's kills of the source (or loot windows, the more of the two),
				// or its loot windows of an object.
				let mut of_by: IndexMap<usize, f64> = self.windows[k].get(&id).cloned().unwrap_or_default();
				if kind == "npc" {
					for (&c, &n) in self.kills.get(&id).into_iter().flatten() {
						let of = of_by.entry(c).or_insert(0.0);
						*of = of.max(n);
					}
				}
				for (&item, n_by) in m {
					let it = db.items.get(&item.to_string());
					if !it.truthy() {
						continue;
					}
					// From MIN_KILLS of their own, two counted contributors (or `local`) make a
					// trusted chance that replaces another source's; otherwise the chance only
					// fills a gap, from the counted contributors when any saw the source, else
					// from everyone. Either way it is the median of each contributor's chance.
					let all: Vec<usize> = of_by.iter().filter(|(_, of)| **of > 0.0).map(|(c, _)| *c).collect();
					let counted: Vec<usize> = all.iter().copied().filter(|c| self.counting[*c]).collect();
					let strong: Vec<usize> = counted.iter().copied().filter(|c| of_by[c] >= MIN_KILLS).collect();
					let trust = strong.iter().any(|c| self.contributors[*c] == LOCAL) || strong.len() >= 2;
					let group = if trust {
						strong
					} else if !counted.is_empty() {
						counted
					} else {
						all
					};
					let n_of = |c: &usize| n_by.get(c).copied().unwrap_or(0.0);
					let chance = median(group.iter().map(|c| 100.0 * n_of(c) / of_by[c]).collect());
					if chance.is_nan() || chance <= 0.0 {
						continue;
					}
					if !it.get("drops").truthy() {
						let d = Obj::new();
						d.set("npc", Obj::new());
						d.set("object", Obj::new());
						it.set("drops", d);
					}
					if !it.get("drops").get(kind).truthy() {
						it.get("drops").set(kind, Obj::new());
					}
					let cur = it.get("drops").get(kind).get(&id.to_string());
					if cur.is_nullish() || trust {
						it.get("drops").get(kind).set(&id.to_string(), round2(chance));
						chances += 1;
					}
					if !it.get("seen").truthy() {
						it.set("seen", Obj::new());
					}
					if !it.get("seen").get(kind).truthy() {
						it.get("seen").set(kind, Obj::new());
					}
					// The loot and kills behind the chance.
					let s = Obj::new();
					s.set("n", group.iter().map(n_of).sum::<f64>());
					s.set("of", group.iter().map(|c| of_by[c]).sum::<f64>());
					it.get("seen").get(kind).set(&id.to_string(), s);
					let src = it.get("source");
					if src.is_arr() {
						if !has_str(&src, "recorder") {
							src.push("recorder");
						}
					} else if !src.truthy() {
						it.set("source", arr(vec![V::str("recorder")]));
					}
				}
			}
		}
		for (&id, &r) in &self.rank {
			db.npcs.get(&id.to_string()).set("rank", r);
		}
		for (&id, &(lo, hi)) in &self.levels {
			let e = db.npcs.get(&id.to_string());
			let lvl = e.get("level").as_num().filter(|x| x.fract() == 0.0);
			let lmax = e.get("levelMax").as_num().filter(|x| x.fract() == 0.0);
			let min = lvl.map_or(lo as f64, |l| l.min(lo as f64));
			let max = (lmax.or(lvl).unwrap_or(hi as f64)).max(hi as f64);
			e.set("level", min);
			if max > min {
				e.set("levelMax", max);
			} else {
				e.as_obj().unwrap().delete("levelMax");
			}
		}
		let mut treasures = 0;
		for kind in ["npc", "object"] {
			let k = k_ix(kind);
			let t = table_of(db, kind);
			for (&id, set) in &self.roles[k] {
				let e = t.get(&id.to_string());
				let mut all: Vec<String> = e.get("roles").items().iter().map(V::to_js_string).collect();
				for r in set {
					if !all.contains(r) {
						all.push(r.clone());
					}
				}
				let mut dedup: Vec<String> = Vec::new();
				for r in all {
					if !dedup.contains(&r) {
						dedup.push(r);
					}
				}
				dedup.sort_by(|a, b| cmp_utf16(a, b));
				e.set("roles", arr(dedup.into_iter().map(V::from).collect()));
				if kind == "object" && set.contains("chest") {
					treasures += 1;
				}
			}
			for (&id, set) in &self.inside[k] {
				let e = t.get(&id.to_string());
				let mut all: Vec<f64> = e.get("instances").items().iter().map(V::num).collect();
				for &i in set {
					if !all.contains(&(i as f64)) {
						all.push(i as f64);
					}
				}
				all.sort_by(|a, b| a.partial_cmp(b).unwrap());
				e.set("instances", nums(&all));
			}
			for (&id, by_map) in &self.found[k] {
				self.join(&t.get(&id.to_string()), by_map, false, WHO_FOUND + k, id);
			}
		}
		for (&id, by_map) in &self.killed {
			self.join(&db.npcs.get(&id.to_string()), by_map, true, WHO_FOUND, id);
		}
		for (&id, &enc) in &self.encounter_of {
			db.npcs.get(&id.to_string()).set("encounter", enc as f64);
		}
		let mut encounters = 0;
		let mut ids: Vec<i64> = self.inst.keys().copied().collect();
		ids.sort();
		for id in ids {
			let i = &self.inst[&id];
			let cur = db.instances.get(&id.to_string());
			let out = if cur.truthy() {
				cur
			} else {
				let o = Obj::new();
				o.set("id", id as f64);
				o.set("name", V::Null);
				o.set("type", V::Null);
				o.set("entrances", V::arr());
				o.set("encounters", Obj::new());
				o.set("source", V::arr());
				V::Obj(o)
			};
			if let Some(n) = &i.name {
				out.set("name", n.as_str());
			}
			if let Some(t) = &i.kind {
				out.set("type", t.as_str());
			}
			if let Some(pts) = self.entrances.get(&id) {
				let mut maps: Vec<(&i64, &Vec<P>)> = pts.iter().collect();
				maps.sort_by_key(|(m, _)| **m);
				let mut list: Vec<(i64, f64, f64, usize)> = Vec::new();
				for (&map, l) in maps {
					for (x, y, n) in clusters(l, ENTRANCE_RADIUS) {
						list.push((map, x, y, n));
					}
				}
				list.sort_by(|a, b| b.3.cmp(&a.3).then(a.0.cmp(&b.0)));
				out.set(
					"entrances",
					arr(list
						.into_iter()
						.map(|(map, x, y, n)| {
							let o = Obj::new();
							o.set("map", map as f64);
							o.set("x", x);
							o.set("y", y);
							o.set("n", n);
							V::Obj(o)
						})
						.collect()),
				);
			}
			let mut encs: Vec<(&i64, &Enc)> = i.encounters.iter().collect();
			encs.sort_by_key(|(k, _)| **k);
			for (&enc, e) in encs {
				let o = Obj::new();
				o.set("name", e.name.as_deref().map(V::str).unwrap_or(V::Null));
				let mut n: Vec<f64> = e.npcs.iter().map(|&x| x as f64).collect();
				n.sort_by(|a, b| a.partial_cmp(b).unwrap());
				o.set("npcs", nums(&n));
				o.set("kills", e.kills);
				out.get("encounters").set(&enc.to_string(), o);
				encounters += 1;
			}
			let src = out.get("source");
			if !has_str(&src, "recorder") {
				src.push("recorder");
			}
			db.instances.set(&id.to_string(), out);
		}
		self.stats.recorded_drop_chances = chances;
		self.stats.recorded_treasures = treasures;
		self.stats.recorded_instances = self.inst.len();
		self.stats.recorded_encounters = encounters;
	}
}

/// Greedy clusters within `radius` -> (x, y, n), biggest first, then by x, y.
fn clusters(points: &[P], radius: f64) -> Vec<(f64, f64, usize)> {
	let mut out: Vec<(f64, f64, usize)> = Vec::new();
	for &[x, y] in points {
		match out.iter_mut().find(|k| hypot(k.0 / k.2 as f64 - x, k.1 / k.2 as f64 - y) <= radius) {
			Some(c) => {
				c.0 += x;
				c.1 += y;
				c.2 += 1;
			}
			None => out.push((x, y, 1)),
		}
	}
	let mut r: Vec<(f64, f64, usize)> = out.into_iter().map(|(sx, sy, n)| (round2(sx / n as f64), round2(sy / n as f64), n)).collect();
	r.sort_by(|a, b| b.2.cmp(&a.2).then(a.0.partial_cmp(&b.0).unwrap()).then(a.1.partial_cmp(&b.1).unwrap()));
	r
}

/// Recorded objectives matched to existing ones (by name, else id); recorded counts win and
/// recorded indices reorder; unmatched ones are appended.
fn merge_objectives(q: &V, slots: &IndexMap<i64, Slot>) {
	let objs = q.get("objectives");
	let mut list: Vec<V> = objs.items();
	let mut oi_of: IndexMap<usize, i64> = IndexMap::new();
	let mut keys: Vec<i64> = slots.keys().copied().collect();
	keys.sort();
	for oi in keys {
		let s = &slots[&oi];
		// Nothing to match it by (a non-English session's progress: names are not taken from it).
		if s.name.is_none() && s.id.is_none() {
			continue;
		}
		let mut idx = s.name.as_ref().and_then(|name| {
			list.iter().enumerate().position(|(i, o)| {
				!oi_of.contains_key(&i)
					&& !name.is_empty()
					&& (same(&o.get("text"), name) || o.get("text").as_str().is_some_and(|t| format!("{t}s").trim().to_lowercase() == name.trim().to_lowercase()))
			})
		});
		if idx.is_none() {
			if let Some(id) = s.id {
				idx =
					list.iter().enumerate().position(|(i, o)| !oi_of.contains_key(&i) && o.get("id").as_num() == Some(id as f64) && s.kind.as_ref().is_none_or(|k| o.get("type").as_str() == Some(k)));
			}
		}
		let idx = match idx {
			None => {
				let o = Obj::new();
				o.set("type", s.kind.clone().unwrap_or_else(|| "event".into()));
				o.set("id", s.id.map(|x| V::Num(x as f64)).unwrap_or(V::Null));
				o.set("count", s.max.filter(|m| *m != 0.0).map(V::Num).unwrap_or(V::Null));
				o.set("text", s.name.clone().filter(|n| !n.is_empty()).map(V::from).unwrap_or(V::Null));
				list.push(V::Obj(o));
				list.len() - 1
			}
			Some(i) => {
				if let Some(m) = s.max.filter(|m| *m != 0.0) {
					list[i].set("count", m);
				}
				i
			}
		};
		oi_of.insert(idx, oi);
	}
	let n = list.len();
	let mut result: Vec<Option<V>> = vec![None; n];
	let mut rest: std::collections::VecDeque<V> = std::collections::VecDeque::new();
	for (i, o) in list.into_iter().enumerate() {
		match oi_of.get(&i) {
			Some(&oi) if oi - 1 < n as i64 && result[(oi - 1) as usize].is_none() => result[(oi - 1) as usize] = Some(o),
			_ => rest.push_back(o),
		}
	}
	let out: Vec<V> = result.into_iter().map(|r| r.or_else(|| rest.pop_front()).unwrap_or(V::Undef)).collect();
	q.set("objectives", arr(out));
}

/// A quest's recorded XP: the base reward when one was seen, else the log or turn-in values of
/// players near the quest's level. Each contributor gives one value (the highest it saw); the
/// quest gets the lower median of the counted contributors' values (of everyone's when none
/// counts), a value a player saw that one outlying contributor cannot move. Another source's XP
/// is replaced only on trusted evidence (two counted contributors, or `local`); otherwise the
/// recorded XP only fills a quest that has none.
fn resolve_xp(q: &V, list: &[(&'static str, i64, Option<i64>, usize)], contributors: &IndexSet<String>, counting: &[bool]) {
	let mut pick: Vec<&(&str, i64, Option<i64>, usize)> = list.iter().filter(|o| o.0 == "base").collect();
	if pick.is_empty() {
		let level = q.get("level");
		pick = list.iter().filter(|o| o.0 != "base" && (matches!(level, V::Null) || o.2.is_some_and(|l| (l as f64) <= level.num() + FULL_XP_LEVELS))).collect();
	}
	let mut per: IndexMap<usize, (&str, i64)> = IndexMap::new();
	for o in &pick {
		let best = per.entry(o.3).or_insert((o.0, o.1));
		if o.1 > best.1 {
			*best = (o.0, o.1);
		}
	}
	let counted: IndexSet<String> = per.keys().filter(|c| counting[**c]).map(|c| contributors[*c].clone()).collect();
	if q.get("xp").as_num().is_some_and(|x| x > 0.0) && !trusted(&counted) {
		return;
	}
	let mut values: Vec<(&str, i64)> = per.iter().filter(|(c, _)| counting[**c]).map(|(_, v)| *v).collect();
	if values.is_empty() {
		values = per.into_values().collect();
	}
	values.sort_by_key(|v| v.1);
	let Some(&(kind, xp)) = values.get(values.len().saturating_sub(1) / 2) else { return };
	q.set("xp", xp as f64);
	q.set("xpSamples", pick.len());
	let tag = format!("recorder:xp-{kind}");
	let src = q.get("source");
	if !has_str(&src, &tag) {
		src.push(tag.as_str());
	}
}

/// The median: the middle value, or the mean of the two middle ones; NaN for none.
fn median(mut v: Vec<f64>) -> f64 {
	if v.is_empty() {
		return f64::NAN;
	}
	v.sort_by(f64::total_cmp);
	let m = v.len() / 2;
	if v.len() % 2 == 1 {
		v[m]
	} else {
		(v[m - 1] + v[m]) / 2.0
	}
}

fn resolve_factions(factions: &Obj, parents: &IndexMap<i64, i64>, sides: &FxHashMap<i64, String>) {
	let parent_of = |id: i64| factions.get(&id.to_string()).get("parent").as_num().map(|p| p as i64);
	let ancestor_of = |id: i64, target: i64| {
		let mut seen = rustc_hash::FxHashSet::default();
		let mut cur = Some(id);
		while let Some(c) = cur.filter(|c| *c != 0 && !seen.contains(c)) {
			if c == target {
				return true;
			}
			seen.insert(c);
			cur = if factions.has(&c.to_string()) { parent_of(c) } else { None };
		}
		false
	};
	let mut ids: Vec<i64> = parents.keys().copied().collect();
	ids.sort();
	for id in ids {
		let f = factions.get(&id.to_string());
		let p = parents[&id];
		if matches!(f.get("parent"), V::Null) && factions.has(&p.to_string()) && !ancestor_of(p, id) {
			f.set("parent", p as f64);
		}
	}
	let side_of = |id: i64| -> V {
		let mut seen = rustc_hash::FxHashSet::default();
		let mut cur = Some(id);
		while let Some(c) = cur.filter(|c| *c != 0 && factions.has(&c.to_string()) && !seen.contains(c)) {
			seen.insert(c);
			let s = factions.get(&c.to_string()).get("side");
			if s.truthy() {
				return s;
			}
			if let Some(x) = sides.get(&c) {
				return V::str(x);
			}
			cur = parent_of(c);
		}
		V::Null
	};
	for key in factions.keys() {
		let f = factions.get(&key);
		if !has_str(&f.get("source"), "recorder") {
			continue;
		}
		if !f.get("side").truthy() {
			f.set("side", side_of(f.get("id").num() as i64));
		}
		factions.set_str(key, canonical(&f, &FACTION_KEYS));
	}
}

pub fn apply_recordings(db: &Db, recordings: &[Recording], so: SpawnOptions, live_maps: &dyn Fn(i64) -> bool, sim: bool) -> Stats {
	let mut ov = Overlay {
		db,
		so,
		live_maps,
		stats: Stats { recordings: recordings.len(), ..Stats::default() },
		touched: IndexSet::new(),
		touched_entities: IndexMap::new(),
		live: Default::default(),
		recorded_objectives: IndexMap::new(),
		xp_seen: IndexMap::new(),
		faction_parent: IndexMap::new(),
		faction_side: FxHashMap::default(),
		rewards: FxHashMap::default(),
		kills: FxHashMap::default(),
		windows: Default::default(),
		loots: Default::default(),
		found: Default::default(),
		killed: IndexMap::new(),
		rank: IndexMap::new(),
		levels: IndexMap::new(),
		roles: Default::default(),
		inside: Default::default(),
		encounter_of: IndexMap::new(),
		entrances: IndexMap::new(),
		inst: IndexMap::new(),
		contributor: LOCAL.to_string(),
		ci: 0,
		counts: true,
		english: true,
		contributors: IndexSet::new(),
		counting: Vec::new(),
		who: FxHashMap::default(),
	};
	for r in recordings {
		let rec = &r.rec;
		ov.contributor = r.voter();
		let (ci, new) = ov.contributors.insert_full(ov.contributor.clone());
		if new {
			ov.counting.push(r.counts);
		}
		ov.ci = ci;
		ov.counts = ov.counting[ci];
		ov.english = r.english();
		// Schema 2 has one `kill` per creature killed (schema 1's `slain`), with the objective it
		// ticked when it did.
		let schema2 = rec.get("schema").as_num() == Some(2.0);
		for (map_id, m) in rec.get("maps").entries() {
			let Some(id) = pos_int(&V::Str(map_id)) else { continue };
			if !db.zones.has(&id.to_string()) && m.truthy() && m.get("name").is_str() {
				let z = Obj::new();
				z.set("id", id as f64);
				z.set("name", m.get("name"));
				z.set("areaId", V::Null);
				z.set("parent", pos_int(&m.get("parent")).map(|p| V::Num(p as f64)).unwrap_or(V::Null));
				let t = m.get("type").num();
				z.set("type", if t.is_finite() { V::Num(t) } else { V::Null });
				db.zones.set(&id.to_string(), z);
			}
		}
		ov.faction_dump(&rec.get("factions"));
		for ev in rec.get("events").items() {
			let Some(e) = ev.get("e").as_rc_str() else { continue };
			if !ev.truthy() {
				continue;
			}
			ov.stats.events += 1;
			let qid = pos_int(&ev.get("q"));
			let npc = pos_int(&ev.get("npc"));
			match (&*e, qid) {
				("accept", Some(qid)) => {
					let q = ov.quest(qid);
					if let Some(t) = ev.get("title").as_str().filter(|t| !t.is_empty()) {
						if may_name(ov.english, &q.get("title")) {
							q.set("title", t);
						}
					}
					if let Some(l) = pos_int(&ev.get("qlvl")) {
						q.set("level", l as f64);
					}
					ov.xp_obs(qid, "base", &ev.get("rewardXpBase"), &ev.get("lvl"));
					ov.xp_obs(qid, "log", &ev.get("rewardXp"), &ev.get("lvl"));
					if let Some(n) = npc {
						front(&q.get("start").get("npc"), n);
						ov.live_point("npc", n, &ev.get("npcName"), &ev);
					}
					if let Some(o) = pos_int(&ev.get("object")) {
						front(&q.get("start").get("object"), o);
						ov.live_point("object", o, &ev.get("objName"), &ev);
					}
					if let Some(i) = pos_int(&ev.get("item")) {
						front(&q.get("start").get("item"), i);
					}
					if let Some(c) = coord(&ev) {
						if !q.get("zone").truthy() {
							q.set("zone", c.map as f64);
						}
					}
					ov.rewards_observe(qid, &ev, 1);
				}
				("turnin", Some(qid)) => {
					let q = ov.quest(qid);
					ov.xp_obs(qid, "turnin", &ev.get("xpReward"), &ev.get("lvl"));
					if let Some(n) = npc {
						front(&q.get("end").get("npc"), n);
						ov.live_point("npc", n, &ev.get("npcName"), &ev);
					}
					if let Some(o) = pos_int(&ev.get("object")) {
						front(&q.get("end").get("object"), o);
						ov.live_point("object", o, &ev.get("objName"), &ev);
					}
					ov.rewards_observe(qid, &ev, 2);
				}
				("text", Some(qid)) => {
					let q = ov.quest(qid);
					if let Some(t) = ev.get("title").as_str().filter(|t| !t.is_empty()) {
						if may_name(ov.english, &q.get("title")) {
							q.set("title", t);
						}
					}
				}
				("reward", Some(qid)) => {
					ov.quest(qid);
					ov.xp_obs(qid, "base", &ev.get("rewardXpBase"), &ev.get("lvl"));
					ov.xp_obs(qid, "log", &ev.get("rewardXp"), &ev.get("lvl"));
				}
				("progress", Some(qid)) => {
					ov.quest(qid);
					let oi = pos_int(&ev.get("oi"));
					let p = ev.get("text").as_str().and_then(parse_progress_text);
					let (Some(oi), Some(p)) = (oi, p) else { continue };
					let kind = match ev.get("type").as_str() {
						Some("monster") => Some("kill"),
						Some("item") => Some("item"),
						Some("object") => Some("object"),
						_ => None,
					};
					let english = ov.english;
					let s = ov.slot(qid, oi);
					if english {
						s.name = Some(p.name);
					}
					s.max = Some(s.max.unwrap_or(0.0).max(p.max));
					s.kind = kind.map(str::to_string).or(s.kind.take()).or(if p.slain { Some("kill".into()) } else { None });
				}
				("kill" | "loot", _) => {
					let id = if &*e == "kill" { npc } else { pos_int(&ev.get("item")) };
					let Some(id) = id else { continue };
					if &*e == "kill" {
						ov.entity("npc", id, &ev.get("npcName"));
					} else {
						ov.item_entry(id, &ev.get("itemName"));
					}
					if let (Some(q), Some(oi)) = (qid, pos_int(&ev.get("oi"))) {
						let kind = if &*e == "kill" { "kill" } else { "item" };
						let s = ov.slot(q, oi);
						s.id = Some(id);
						if s.kind.is_none() {
							s.kind = Some(kind.into());
						}
					}
					if schema2 && &*e == "kill" {
						ov.slain(id, &ev);
					}
				}
				("unit", _) if schema2 => {
					if let Some(n) = npc {
						ov.unit(n, &ev);
					}
				}
				_ => {
					if ov.handle_find(&ev) {
					} else if let (Some(role), Some(n)) = (
						match &*e {
							"gossip" | "offer" => Some(None),
							"trainer" => Some(Some("trainer")),
							"vendor" => Some(Some("vendor")),
							"fp" => Some(Some("flightmaster")),
							_ => None,
						},
						npc,
					) {
						let ent = ov.live_point("npc", n, &ev.get("npcName"), &ev);
						if let Some(r) = role {
							let mut roles: Vec<String> = ent.get("roles").items().iter().map(V::to_js_string).collect();
							if !roles.iter().any(|x| x == r) {
								roles.push(r.into());
							}
							roles.sort_by(|a, b| cmp_utf16(a, b));
							ent.set("roles", arr(roles.into_iter().map(V::from).collect()));
						}
					} else if &*e == "rep" {
						if let Some(id) = pos_int(&ev.get("faction")) {
							ov.faction(id, &ev.get("factionName"));
						}
					}
				}
			}
		}
	}
	let objectives = std::mem::take(&mut ov.recorded_objectives);
	for (qid, slots) in &objectives {
		let q = db.quests.get(&qid.to_string());
		if q.truthy() {
			merge_objectives(&q, slots);
		}
	}
	for kind in ["npc", "object"] {
		let t = table_of(db, kind);
		for (&id, by_map) in &ov.live[k_ix(kind)] {
			let e = t.get(&id.to_string());
			for (&map, pts) in by_map {
				let r = reduce_spawns(pts, so);
				if r.pts.is_empty() {
					continue;
				}
				let cur = e.get("spawns").get(&map.to_string());
				if !cur.is_undef() && cur.get("f").as_str() != Some("l") && !ov.trusted_at(WHO_LIVE + k_ix(kind), id, map) {
					continue;
				}
				e.get("spawns").set(&map.to_string(), spawn_record("l", &r));
			}
		}
	}
	ov.apply_finds();
	for (kind, id) in ov.touched_entities.values() {
		let t = table_of(db, kind);
		let k = id.to_string();
		t.set(
			&k,
			canonical(
				&t.get(&k),
				if *kind == "npc" {
					&NPC_KEYS[..]
				} else if sim {
					&OBJECT_KEYS_SIM[..]
				} else {
					&OBJECT_KEYS[..]
				},
			),
		);
	}
	let mut touched: Vec<i64> = ov.touched.iter().copied().collect();
	touched.sort();
	for id in touched {
		let q = db.quests.get(&id.to_string());
		let src = q.get("source");
		if !has_str(&src, "recorder") {
			src.push("recorder");
		}
		if let Some(list) = ov.xp_seen.get(&id) {
			resolve_xp(&q, list, &ov.contributors, &ov.counting);
		}
		if let Some((_, r)) = ov.rewards.get(&id) {
			q.set("rewards", r.clone());
		}
		db.quests.set(&id.to_string(), canonical(&q, &QUEST_KEYS));
	}
	ov.stats.touched_quests = ov.touched.len();
	resolve_factions(db.factions, &ov.faction_parent, &ov.faction_side);
	ov.stats
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::spawns::DEFAULTS;

	fn obj(json: &str) -> Obj {
		match parse_json(json).unwrap() {
			V::Obj(o) => o,
			_ => panic!("not an object: {json}"),
		}
	}

	/// A session of an established contributor (one that counts).
	fn session(name: &str, contributor: &str, locale: &str, events: &[String]) -> Recording {
		let text = format!(r#"{{"schema":2,"session":"{name}","contributor":"{contributor}","locale":"{locale}","build":62345,"events":[{}],"maps":{{}}}}"#, events.join(","));
		Recording { file: format!("{name}.json"), rec: parse_json(&text).unwrap(), counts: true }
	}

	struct Tables {
		quests: Obj,
		npcs: Obj,
		objects: Obj,
		items: Obj,
		zones: Obj,
		factions: Obj,
		instances: Obj,
	}

	impl Tables {
		fn new(quests: &str, npcs: &str, items: &str) -> Tables {
			Tables { quests: obj(quests), npcs: obj(npcs), objects: obj("{}"), items: obj(items), zones: obj("{}"), factions: obj("{}"), instances: obj("{}") }
		}

		fn apply(&self, recs: &[Recording]) {
			let db = Db { quests: &self.quests, npcs: &self.npcs, objects: &self.objects, items: &self.items, zones: &self.zones, factions: &self.factions, instances: &self.instances };
			apply_recordings(&db, recs, DEFAULTS, &|_| false, false);
		}
	}

	const QUESTS: &str = r#"{"364":{"id":364,"title":"The Damned","level":3,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[],"source":["pfquest"]}}"#;
	const NPCS: &str = r#"{"1568":{"id":1568,"name":"Undertaker Mordo","spawns":{"1420":{"f":"q","pts":[[10,10]]}}},"1569":{"id":1569,"name":"Shadow Priest Sarvis","spawns":{}}}"#;

	#[test]
	fn names_from_a_non_english_client_only_fill_gaps() {
		let t = Tables::new(QUESTS, NPCS, "{}");
		let de = session(
			"de",
			"aaaaaaaaaaaaaaaa",
			"deDE",
			&[
				r#"{"t":1,"e":"text","q":364,"title":"Die Verdammten"}"#.into(),
				r#"{"t":2,"e":"text","q":999,"title":"Nur auf Deutsch"}"#.into(),
				r#"{"t":3,"e":"gossip","npc":1568,"npcName":"Leichenbestatter Mordo"}"#.into(),
			],
		);
		t.apply(&[de]);
		assert_eq!(t.quests.get("364").get("title").as_str(), Some("The Damned"));
		assert_eq!(t.quests.get("999").get("title").as_str(), Some("Nur auf Deutsch"));
		assert_eq!(t.npcs.get("1568").get("name").as_str(), Some("Undertaker Mordo"));

		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(&[session("en", "aaaaaaaaaaaaaaaa", "enUS", &[r#"{"t":1,"e":"text","q":364,"title":"The Damned (Forever)"}"#.into()])]);
		assert_eq!(t.quests.get("364").get("title").as_str(), Some("The Damned (Forever)"));
	}

	#[test]
	fn a_spawn_from_another_source_needs_two_contributors() {
		let accept = |npc: i64| format!(r#"{{"t":1,"e":"accept","q":364,"npc":{npc},"map":1420,"x":31,"y":66}}"#);
		// One player: Mordo keeps the other source's spawn; Sarvis, without one, gets the recorded one.
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(&[session("a", "aaaaaaaaaaaaaaaa", "enUS", &[accept(1568), accept(1569)])]);
		assert_eq!(t.npcs.get("1568").get("spawns").get("1420").get("f").as_str(), Some("q"));
		assert_eq!(t.npcs.get("1569").get("spawns").get("1420").get("f").as_str(), Some("l"));
		// The same player twice is still one contributor.
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(&[session("a", "aaaaaaaaaaaaaaaa", "enUS", &[accept(1568)]), session("a2", "aaaaaaaaaaaaaaaa", "enUS", &[accept(1568)])]);
		assert_eq!(t.npcs.get("1568").get("spawns").get("1420").get("f").as_str(), Some("q"));
		// Two players, or the maintainer's own recording: replaced.
		for second in ["bbbbbbbbbbbbbbbb", LOCAL] {
			let t = Tables::new(QUESTS, NPCS, "{}");
			let recs = if second == LOCAL {
				vec![session("b", LOCAL, "enUS", &[accept(1568)])]
			} else {
				vec![session("a", "aaaaaaaaaaaaaaaa", "enUS", &[accept(1568)]), session("b", second, "enUS", &[accept(1568)])]
			};
			t.apply(&recs);
			assert_eq!(t.npcs.get("1568").get("spawns").get("1420").get("f").as_str(), Some("l"), "{second}");
			assert_eq!(t.npcs.get("1568").get("spawns").get("1420").get("pts").items()[0].num_at(0), 31.0);
		}
	}

	#[test]
	fn a_drop_chance_from_another_source_needs_two_contributors() {
		let items = r#"{"2589":{"id":2589,"name":"Linen Cloth","drops":{"npc":{"1501":5},"object":{}},"vendors":[]}}"#;
		let npcs = r#"{"1501":{"id":1501,"name":"Mindless Zombie","spawns":{}}}"#;
		let kills = |n: usize| -> Vec<String> { loot(1501, 2589, n, n) };
		let t = Tables::new("{}", npcs, items);
		t.apply(&[session("a", "aaaaaaaaaaaaaaaa", "enUS", &kills(12))]);
		assert_eq!(t.items.get("2589").get("drops").get("npc").get("1501").as_num(), Some(5.0));
		// Two players, each under MIN_KILLS of their own: not trusted, however many kills together.
		let t = Tables::new("{}", npcs, items);
		t.apply(&[session("a", "aaaaaaaaaaaaaaaa", "enUS", &kills(6)), session("b", "bbbbbbbbbbbbbbbb", "enUS", &kills(6))]);
		assert_eq!(t.items.get("2589").get("drops").get("npc").get("1501").as_num(), Some(5.0));
		let t = Tables::new("{}", npcs, items);
		t.apply(&[session("a", "aaaaaaaaaaaaaaaa", "enUS", &kills(12)), session("b", "bbbbbbbbbbbbbbbb", "enUS", &kills(12))]);
		assert_eq!(t.items.get("2589").get("drops").get("npc").get("1501").as_num(), Some(100.0));
	}

	/// `n` kills of `npc`, `drops` of them dropping `item`.
	fn loot(npc: i64, item: i64, n: usize, drops: usize) -> Vec<String> {
		(0..n)
			.flat_map(|i| {
				let mut e = vec![format!(r#"{{"t":{i},"e":"kill","npc":{npc},"cls":"normal"}}"#)];
				if i < drops {
					e.push(format!(r#"{{"t":{i},"e":"drop","npc":{npc},"items":[{{"item":{item},"count":1}}]}}"#));
				}
				e
			})
			.collect()
	}

	/// A session pulled from the server: its contributor's first-seen time and chunk count as
	/// forge record pull writes them, `days` before the session arrived.
	fn pulled(name: &str, contributor: &str, install: &str, days: f64, chunks: u64, events: &[String]) -> Recording {
		let received = 1_800_000_000.0;
		let since = received - days * 86400.0;
		let text = format!(
			r#"{{"schema":2,"session":"{name}","contributor":"{contributor}","install":"{install}","contributorSince":{since},"contributorChunks":{chunks},"received":{received},"locale":"enUS","build":62345,"events":[{}],"maps":{{}}}}"#,
			events.join(",")
		);
		Recording { file: format!("{name}.json"), rec: parse_json(&text).unwrap(), counts: false }
	}

	/// The same, with the server's cohort in its header.
	fn in_cohort(r: Recording, cohort: &str) -> Recording {
		r.rec.set("cohort", cohort);
		r
	}

	/// Substantive play of a contributor: an hour on each of the 3 days before 1_800_000_000, with
	/// `pos` positions and `kills` kills in each session.
	fn played(contributor: &str, hours: f64, days: usize, pos: usize, kills: usize) -> Vec<Recording> {
		(1..=days)
			.map(|d| {
				let started = 1_800_000_000.0 - d as f64 * 86400.0;
				let ended = started + hours * 3600.0;
				let events: Vec<String> = (0..pos).map(|i| format!(r#"{{"t":{i},"e":"pos","map":1420,"x":1,"y":1}}"#)).chain((0..kills).map(|i| format!(r#"{{"t":{i},"e":"kill"}}"#))).collect();
				let text = format!(
					r#"{{"schema":2,"session":"{contributor}-play{d}","contributor":"{contributor}","install":"play","started":{started},"ended":{ended},"locale":"enUS","build":62345,"events":[{}],"maps":{{}}}}"#,
					events.join(",")
				);
				Recording { file: format!("{contributor}-play{d}.json"), rec: parse_json(&text).unwrap(), counts: false }
			})
			.collect()
	}

	/// [`played`] enough to be established.
	fn play(contributor: &str) -> Vec<Recording> {
		played(contributor, 1.0, 3, 4, 2)
	}

	const ACCEPT_MORDO: &str = r#"{"t":1,"e":"accept","q":364,"npc":1568,"map":1420,"x":31,"y":66}"#;

	/// Mordo's spawn flag after [`establish`] and the overlay: `q` kept, `l` replaced.
	fn mordo(recs: &mut [Recording]) -> Option<String> {
		establish(recs, ESTABLISH);
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(recs);
		t.npcs.get("1568").get("spawns").get("1420").get("f").as_str().map(str::to_owned)
	}

	#[test]
	fn a_contributor_counts_toward_the_quorum_only_once_established() {
		let (a, b) = ("aaaaaaaaaaaaaaaa", "bbbbbbbbbbbbbbbb");
		let with_play = |mut recs: Vec<Recording>| {
			recs.extend(play(a));
			recs.extend(play(b));
			recs
		};
		let pa = || pulled("a", a, "ia", 4.0, 50, &[ACCEPT_MORDO.into()]);
		// b registered a day ago, or has sent too little: Mordo keeps the other source's spawn.
		for pb in [pulled("b", b, "ib", 1.0, 50, &[ACCEPT_MORDO.into()]), pulled("b", b, "ib", 10.0, 5, &[ACCEPT_MORDO.into()])] {
			let mut recs = with_play(vec![pa(), pb]);
			assert_eq!(mordo(&mut recs).as_deref(), Some("q"));
			assert!(recs[0].counts && !recs[1].counts);
		}
		// Established: its earliest first-seen and its largest chunk count, over all its sessions.
		let mut recs = with_play(vec![pa(), pulled("b1", b, "ib", 10.0, 5, &[]), pulled("b2", b, "ib", 1.0, 30, &[ACCEPT_MORDO.into()])]);
		assert_eq!(mordo(&mut recs).as_deref(), Some("l"));
		// A file the maintainer vouched for and the maintainer's own count without any of it; a
		// sent-in file nobody vouched for never counts.
		let sent = |c: &str| Recording { counts: false, ..session("s", c, "enUS", &[ACCEPT_MORDO.into()]) };
		let mut recs = with_play(vec![pa(), sent("sent-alice")]);
		assert_eq!(mordo(&mut recs).as_deref(), Some("l"));
		let mut recs = with_play(vec![pa(), sent("anon-0123456789abcdef")]);
		assert_eq!(mordo(&mut recs).as_deref(), Some("q"));
		assert!(!recs[1].counts);
		let mut recs = vec![Recording { counts: false, ..session("m", LOCAL, "enUS", &[ACCEPT_MORDO.into()]) }];
		assert_eq!(mordo(&mut recs).as_deref(), Some("l"));
	}

	#[test]
	fn establishing_takes_substantive_play() {
		let (a, b) = ("aaaaaaaaaaaaaaaa", "bbbbbbbbbbbbbbbb");
		let with = |b_play: Vec<Recording>| {
			let mut recs = vec![pulled("a", a, "ia", 30.0, 500, &[ACCEPT_MORDO.into()]), pulled("b", b, "ib", 30.0, 500, &[ACCEPT_MORDO.into()])];
			recs.extend(play(a));
			recs.extend(b_play);
			recs
		};
		// Old and busy enough, but no play, two days, too short, no kills or no positions: b doesn't count.
		for (why, b_play) in [
			("no play", vec![]),
			("two days", played(b, 1.0, 2, 8, 4)),
			("an hour and a half", played(b, 0.5, 3, 4, 2)),
			("no kills", played(b, 1.0, 3, 4, 0)),
			("no positions", played(b, 1.0, 3, 0, 2)),
		] {
			let mut recs = with(b_play);
			assert_eq!(mordo(&mut recs).as_deref(), Some("q"), "{why}");
			assert!(recs[0].counts && !recs[1].counts, "{why}");
		}
		let mut recs = with(play(b));
		assert_eq!(mordo(&mut recs).as_deref(), Some("l"));
	}

	#[test]
	fn contributors_of_one_cohort_count_as_one_player() {
		let (a, b) = ("aaaaaaaaaaaaaaaa", "bbbbbbbbbbbbbbbb");
		let recs = |ca: Option<&str>, cb: Option<&str>| {
			let mut v = vec![pulled("a", a, "ia", 30.0, 500, &[ACCEPT_MORDO.into()]), pulled("b", b, "ib", 30.0, 500, &[ACCEPT_MORDO.into()])];
			v.extend(play(a));
			v.extend(play(b));
			v.into_iter()
				.map(|r| match (r.contributor() == a, ca, cb) {
					(true, Some(c), _) | (false, _, Some(c)) => in_cohort(r, c),
					_ => r,
				})
				.collect::<Vec<_>>()
		};
		// Two established contributors registered from one network on one day: one player.
		let mut v = recs(Some("0000000000000001"), Some("0000000000000001"));
		assert_eq!(mordo(&mut v).as_deref(), Some("q"));
		assert!(v.iter().all(|r| r.counts));
		// Two cohorts, or one pulled before cohorts were exported (it counts as its contributor): two.
		for (ca, cb) in [(Some("0000000000000001"), Some("0000000000000002")), (Some("0000000000000001"), None)] {
			let mut v = recs(ca, cb);
			assert_eq!(mordo(&mut v).as_deref(), Some("l"), "{ca:?} {cb:?}");
		}
		// A cohort counts once any of its contributors is established.
		let mut v = vec![in_cohort(pulled("a", a, "ia", 30.0, 500, &[]), "0000000000000003"), in_cohort(pulled("b", b, "ib", 1.0, 1, &[]), "0000000000000003")];
		v.extend(play(a).into_iter().map(|r| in_cohort(r, "0000000000000003")));
		establish(&mut v, ESTABLISH);
		assert!(v.iter().all(|r| r.counts));
	}

	#[test]
	fn one_contributor_with_many_installs_counts_once() {
		let items = r#"{"2589":{"id":2589,"name":"Linen Cloth","drops":{"npc":{"1501":5},"object":{}},"vendors":[]}}"#;
		let npcs = r#"{"1501":{"id":1501,"name":"Mindless Zombie","spawns":{}},"1568":{"id":1568,"name":"Undertaker Mordo","spawns":{"1420":{"f":"q","pts":[[10,10]]}}}}"#;
		let mut recs: Vec<Recording> = (0..5)
			.map(|i| {
				let mut events = loot(1501, 2589, 40, 40);
				events.push(ACCEPT_MORDO.into());
				pulled(&format!("a{i}"), "aaaaaaaaaaaaaaaa", &format!("install{i}"), 30.0, 500, &events)
			})
			.chain(play("aaaaaaaaaaaaaaaa"))
			.collect();
		establish(&mut recs, ESTABLISH);
		assert!(recs.iter().all(|r| r.counts));
		let t = Tables::new(QUESTS, npcs, items);
		t.apply(&recs);
		assert_eq!(t.npcs.get("1568").get("spawns").get("1420").get("f").as_str(), Some("q"), "one player's spawn, however many installs");
		assert_eq!(t.items.get("2589").get("drops").get("npc").get("1501").as_num(), Some(5.0), "one player's drop chance, however many installs");
	}

	#[test]
	fn the_median_resists_one_outlier_contributor() {
		let items = r#"{"2589":{"id":2589,"name":"Linen Cloth","drops":{"npc":{"1501":5},"object":{}},"vendors":[]}}"#;
		let npcs = r#"{"1501":{"id":1501,"name":"Mindless Zombie","spawns":{}}}"#;
		let xp = |v: i64| format!(r#"{{"t":1,"e":"accept","q":364,"rewardXpBase":{v},"lvl":3}}"#);
		// Two players see 10% and 20% in 20 kills each and 450 XP; a third farms 400 kills at
		// 100% and claims 9999 XP. Pooled the chance would be 81.8%; the median is 20%.
		let player = |name: &str, c: &str, n: usize, d: usize, x: i64| {
			let mut events = loot(1501, 2589, n, d);
			events.push(xp(x));
			session(name, c, "enUS", &events)
		};
		let t = Tables::new(QUESTS, npcs, items);
		t.apply(&[player("a", "aaaaaaaaaaaaaaaa", 20, 2, 450), player("b", "bbbbbbbbbbbbbbbb", 20, 4, 450), player("c", "cccccccccccccccc", 400, 400, 9999)]);
		assert_eq!(t.items.get("2589").get("drops").get("npc").get("1501").as_num(), Some(20.0));
		assert_eq!(t.items.get("2589").get("seen").get("npc").get("1501").get("of").as_num(), Some(440.0));
		assert_eq!(t.quests.get("364").get("xp").as_num(), Some(450.0));
		// With two contributors the XP is the lower of the two: a value a player saw.
		let t = Tables::new(QUESTS, npcs, items);
		t.apply(&[player("a", "aaaaaaaaaaaaaaaa", 20, 2, 450), player("c", "cccccccccccccccc", 400, 400, 9999)]);
		assert_eq!(t.quests.get("364").get("xp").as_num(), Some(450.0));
		assert_eq!(t.items.get("2589").get("drops").get("npc").get("1501").as_num(), Some(55.0));
	}

	#[test]
	fn quest_xp_from_another_source_needs_two_counted_contributors() {
		let quests = r#"{"364":{"id":364,"title":"The Damned","level":3,"xp":400,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[],"source":["pfquest"]}}"#;
		let xp = |v: i64| vec![format!(r#"{{"t":1,"e":"accept","q":364,"rewardXpBase":{v},"lvl":3}}"#)];
		let after = |recs: Vec<Recording>| {
			let mut recs: Vec<Recording> = recs.into_iter().chain(play("aaaaaaaaaaaaaaaa")).chain(play("bbbbbbbbbbbbbbbb")).collect();
			establish(&mut recs, ESTABLISH);
			let t = Tables::new(quests, "{}", "{}");
			t.apply(&recs);
			t.quests.get("364").get("xp").as_num()
		};
		// One established player, the same player on two installs, or two where one is new: kept.
		assert_eq!(after(vec![pulled("a", "aaaaaaaaaaaaaaaa", "ia", 30.0, 50, &xp(450))]), Some(400.0));
		assert_eq!(after(vec![pulled("a", "aaaaaaaaaaaaaaaa", "ia", 30.0, 50, &xp(450)), pulled("a2", "aaaaaaaaaaaaaaaa", "ib", 30.0, 50, &xp(450))]), Some(400.0));
		assert_eq!(after(vec![pulled("a", "aaaaaaaaaaaaaaaa", "ia", 30.0, 50, &xp(450)), pulled("b", "bbbbbbbbbbbbbbbb", "ib", 1.0, 50, &xp(450))]), Some(400.0));
		// Two established players, or the maintainer's own: replaced.
		assert_eq!(after(vec![pulled("a", "aaaaaaaaaaaaaaaa", "ia", 30.0, 50, &xp(450)), pulled("b", "bbbbbbbbbbbbbbbb", "ib", 30.0, 50, &xp(450))]), Some(450.0));
		assert_eq!(after(vec![session("m", LOCAL, "enUS", &xp(450))]), Some(450.0));
		// A quest without XP is filled by a single new player.
		let t = Tables::new(QUESTS, "{}", "{}");
		let mut recs = [pulled("b", "bbbbbbbbbbbbbbbb", "ib", 1.0, 5, &xp(450))];
		establish(&mut recs, ESTABLISH);
		t.apply(&recs);
		assert_eq!(t.quests.get("364").get("xp").as_num(), Some(450.0));
	}

	#[test]
	fn sessions_of_builds_older_than_min_build_are_left_out() {
		let dir = std::env::temp_dir().join(format!("forge-data-recordings-min-build-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&dir);
		std::fs::create_dir_all(&dir).unwrap();
		std::fs::write(dir.join("config.json"), r#"{"minBuild":62000}"#).unwrap();
		std::fs::write(dir.join(".pull-state.json"), r#"{"after":5}"#).unwrap();
		std::fs::write(dir.join("old.json"), r#"{"schema":2,"build":61000,"events":[]}"#).unwrap();
		std::fs::write(dir.join("new.json"), r#"{"schema":2,"build":62345,"events":[]}"#).unwrap();
		std::fs::write(dir.join("v1.json"), r#"{"schema":1,"events":[]}"#).unwrap();
		let files: Vec<String> = read_recordings(&dir).unwrap().into_iter().map(|r| r.file).collect();
		assert_eq!(files, vec!["new.json", "v1.json"]);
		std::fs::remove_dir_all(&dir).unwrap();
	}
}
