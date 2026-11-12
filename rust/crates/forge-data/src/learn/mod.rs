//! `forge record learn`: what players' recordings teach about the quests Forever added, as a
//! committed snapshot (docs/forge/learn.md).
//!
//! Reads the re-sessioned recordings archive one session at a time, IngestAudit's verdicts and the
//! current data (data/forever, forever-db/corrections), and learns per Forever-new quest:
//! - where each objective line is done ([`spots`]), from the spots its ticks were recorded at;
//! - its prerequisites (all-of, any-of, exclusive groups) and minimum level from givers' windows,
//!   refusal-backed only ([`offers`]).
//!
//! Trust (docs/RECORDING.md "Trust", recordings.rs): a session counts when its player is
//! established ([`crate::recordings::establish_heads`]); contributors the archive's config.json
//! `exclude` lists, or the verdicts mark `exclude`/`suspect`, never count; a voter is the server's
//! cohort, merged with every contributor the verdicts say is the same person, and gives one vote per
//! fact; a re-rolled character's race and class are ignored. A fact is learned per voter first, then
//! combined ([`quorum`]): `trusted` once enough counted voters agree and at least ⅔ of the counted
//! voters with evidence either way do, `gap` with fewer (a provisional fact, used for Forever-new
//! quests only and never in the public database), `conflict` when the ⅔ rule fails, `stale` when
//! three counted voters recorded the quest on a newer build without confirming it.
//!
//! Each fact is sorted against the current data ([`Class`]); corrections always win: a fact that
//! disagrees with a corrected field is listed (`vs-correction`), never applied (consumers skip
//! corrected fields: [`apply_prereqs`]).
//!
//! The snapshot names no contributor, cohort or character: counts only.

pub mod offers;
pub mod spots;

use std::collections::{BTreeMap, BTreeSet};
use std::fmt::Write as _;
use std::path::{Path, PathBuf};

use forge_guide::js::{cmp_utf16, num_str, parse_json, stringify, Obj, V};
use rustc_hash::{FxHashMap, FxHashSet};
use sha2::{Digest, Sha256};

use crate::recordings::{establish_heads, pos_int, read_config, vouched, Config, Head};
use offers::{Char, PreStatus, QData, Quests, Row, Timed, Window};

/// Counted voters a refusal-backed prerequisite, an exclusive group or a minimum level the data
/// has (or lacks) needs to be trusted.
pub const MIN_OFFER_VOTERS: usize = 2;
/// Counted voters an objective spot needs to be trusted.
pub const MIN_SPOT_VOTERS: usize = 3;
/// A recorded spot this close to where our data places the objective agrees with it.
pub const AGREE_YD: f64 = 100.0;
/// Counted voters on a newer build that make a fact they don't confirm stale.
pub const STALE_VOTERS: usize = 3;
/// An accept with no NPC took it from the window opened this recently.
const ACCEPT_WINDOW: f64 = 60.0;

/// The scope `forge record learn` knows.
pub const SCOPES: [&str; 1] = ["forever-new"];

pub struct Options {
	/// The recordings archive (`rec.py`'s folder: session files + config.json).
	pub archive: PathBuf,
	/// data/forever.
	pub data: PathBuf,
	/// data/sources: the client quest tables that say which quests are new in Forever.
	pub sources: PathBuf,
	/// forever-db/corrections.
	pub corrections: PathBuf,
	/// IngestAudit's verdict.json (None: no merging of people, only config.json's `exclude`).
	pub verdicts: Option<PathBuf>,
	/// The snapshot's last quests.json (what changed since).
	pub previous: Option<PathBuf>,
	pub offline: bool,
}

/// The files `learn` writes: data/recorded/quests.json and meta.json, data/local/recorded/report.md
/// and conflicts.json.
pub struct Output {
	pub quests: String,
	pub meta: String,
	pub report: String,
	pub conflicts: String,
	pub summary: Vec<String>,
}

// ---------------------------------------------------------------- inputs

/// IngestAudit's verdict.json, as far as learning goes.
#[derive(Default)]
pub struct Verdicts {
	/// Contributors marked `exclude` or `suspect`: never counted.
	pub out: FxHashSet<String>,
	pub excluded: usize,
	pub suspect: usize,
	/// contributor -> the person it is (contributors sharing an install, character or cohort).
	pub person: FxHashMap<String, String>,
	/// (contributor, character id) re-rolled: one id, several race/class.
	pub rerolled: FxHashSet<(String, String)>,
	pub generated: Option<String>,
}

pub fn read_verdicts(file: &Path) -> Result<Verdicts, String> {
	let text = std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?;
	let v = parse_json(&text).map_err(|e| format!("{}: {e}", file.display()))?;
	let mut out = Verdicts { generated: v.get("generated").as_str().map(str::to_string), ..Verdicts::default() };
	for (c, x) in v.get("contributors").entries() {
		match x.get("status").as_str() {
			Some("exclude") => {
				out.excluded += 1;
				out.out.insert(c.to_string());
			}
			Some("suspect") => {
				out.suspect += 1;
				out.out.insert(c.to_string());
			}
			_ => {}
		}
		if let Some(p) = x.get("person").as_str().filter(|p| !p.is_empty()) {
			out.person.insert(c.to_string(), p.to_string());
		}
	}
	for (ch, x) in v.get("rerolled").entries() {
		if let Some(c) = x.get("contributor").as_str() {
			out.rerolled.insert((c.to_string(), ch.to_string()));
		}
	}
	Ok(out)
}

/// The current data `learn` compares with.
pub struct Data {
	pub quests: V,
	pub npcs: V,
	pub objects: V,
	pub items: V,
	pub zones: V,
	pub corrections: V,
	/// uiMapID -> (width, height) in yards.
	pub frames: FxHashMap<i64, (f64, f64)>,
	pub built_at: V,
}

fn frame_size(f: &V) -> Option<(f64, f64)> {
	let (l, r, t, b) = (f.get("left").as_num()?, f.get("right").as_num()?, f.get("top").as_num()?, f.get("bottom").as_num()?);
	let (w, h) = ((l - r).abs(), (t - b).abs());
	(w > 0.0 && h > 0.0).then_some((w, h))
}

impl Data {
	pub fn load(dir: &Path, corrections: &Path) -> Result<Data, String> {
		let read = |f: &str, need: bool| -> Result<V, String> {
			let p = dir.join(f);
			match std::fs::read_to_string(&p) {
				Ok(t) => parse_json(&t).map_err(|e| format!("{}: {e}", p.display())),
				Err(_) if !need => Ok(V::obj()),
				Err(e) => Err(format!("{}: {e} (run: forge data build)", p.display())),
			}
		};
		let fr = read("map-frames.json", false)?;
		let mut frames = FxHashMap::default();
		for side in ["era", "forever"] {
			for (m, f) in fr.get(side).entries() {
				if let (Ok(m), Some(s)) = (m.parse::<i64>(), frame_size(&f)) {
					frames.insert(m, s);
				}
			}
		}
		Ok(Data {
			quests: read("quests.json", true)?,
			npcs: read("npcs.json", false)?,
			objects: read("objects.json", false)?,
			items: read("items.json", false)?,
			zones: read("zones.json", false)?,
			corrections: if corrections.exists() { crate::corrections::load(corrections)? } else { V::obj() },
			frames,
			built_at: read("meta.json", false)?.get("builtAt"),
		})
	}
}

fn ids(v: &V) -> Vec<i64> {
	let mut out: Vec<i64> = v.items().iter().filter_map(pos_int).collect();
	out.dedup();
	out
}

fn int(v: &V) -> Option<i64> {
	v.as_num().filter(|n| n.is_finite() && n.fract() == 0.0).map(|n| n as i64)
}

fn qdata(q: &V) -> QData {
	QData {
		pre: ids(&q.get("pre")),
		pre_any: ids(&q.get("preAny")),
		pre_all: ids(&q.get("preAll")),
		excl: ids(&q.get("excl")),
		next: pos_int(&q.get("next")),
		min_level: int(&q.get("minLevel")).filter(|l| *l > 0),
		races: int(&q.get("races")),
		classes: int(&q.get("classes")),
		givers: ids(&q.get("start").get("npc")),
	}
}

// ---------------------------------------------------------------- reading sessions

struct Tick {
	sess: u32,
	map: i64,
	x: f64,
	y: f64,
}

/// What the archive holds, kept compact: one session's events are dropped once read.
pub struct Learner<'a> {
	cfg: &'a Config,
	verdicts: &'a Verdicts,
	scope: &'a dyn Fn(i64) -> bool,
	heads: Vec<Head>,
	builds: Vec<i64>,
	chars: Vec<Char>,
	/// Per character: one session of it (its voter).
	char_sess: Vec<u32>,
	char_ix: FxHashMap<String, usize>,
	ticks: FxHashMap<(i64, i64), Vec<Tick>>,
	/// quest -> (session, the game's objective list: (type, count)).
	lists: FxHashMap<i64, Vec<(u32, Vec<(Option<String>, Option<i64>)>)>>,
	/// quest -> sessions that accepted, ticked or handed it in.
	seen: FxHashMap<i64, Vec<u32>>,
	/// quest -> (session, map) of its accepts.
	accept_maps: FxHashMap<i64, Vec<(u32, i64)>>,
	/// Map frames sessions carry (for maps the data lacks).
	session_frames: FxHashMap<i64, (f64, f64)>,
	hash: Sha256,
	files: usize,
	unreadable: usize,
	older_build: usize,
	excluded: usize,
	newest_received: f64,
}

impl<'a> Learner<'a> {
	pub fn new(cfg: &'a Config, verdicts: &'a Verdicts, scope: &'a dyn Fn(i64) -> bool) -> Learner<'a> {
		Learner {
			cfg,
			verdicts,
			scope,
			heads: Vec::new(),
			builds: Vec::new(),
			chars: Vec::new(),
			char_sess: Vec::new(),
			char_ix: FxHashMap::default(),
			ticks: FxHashMap::default(),
			lists: FxHashMap::default(),
			seen: FxHashMap::default(),
			accept_maps: FxHashMap::default(),
			session_frames: FxHashMap::default(),
			hash: Sha256::new(),
			files: 0,
			unreadable: 0,
			older_build: 0,
			excluded: 0,
			newest_received: 0.0,
		}
	}

	/// One session file's text.
	pub fn add(&mut self, file: &str, text: &str) {
		self.files += 1;
		self.hash.update(file.as_bytes());
		self.hash.update(b"\0");
		self.hash.update(text.as_bytes());
		self.hash.update(b"\0");
		let Ok(rec) = parse_json(text) else {
			self.unreadable += 1;
			return;
		};
		if !matches!(rec.get("schema").as_num(), Some(1.0) | Some(2.0)) || !rec.get("events").is_arr() {
			self.unreadable += 1;
			return;
		}
		let build = int(&rec.get("build")).unwrap_or(0);
		if self.cfg.min_build.is_some_and(|m| (build as f64) < m) {
			self.older_build += 1;
			return;
		}
		let head = Head::of(&rec);
		if self.cfg.exclude.contains(&head.contributor) || self.verdicts.out.contains(&head.contributor) {
			self.excluded += 1;
			return;
		}
		self.newest_received = self.newest_received.max(head.received.unwrap_or(0.0));
		let sess = self.heads.len() as u32;
		let ch = rec.get("char");
		let char_id = rec.get("charId").as_str().or(ch.get("id").as_str()).or(rec.get("session").as_str()).unwrap_or(file).to_string();
		let (mut race, mut class) = (ch.get("race").as_str().map(str::to_string), ch.get("class").as_str().map(str::to_string));
		let mut key = format!("{}\0{char_id}", head.contributor);
		if self.verdicts.rerolled.contains(&(head.contributor.clone(), char_id.clone())) {
			// One id, several characters: keep them apart, and trust neither's race or class.
			key.push_str(&format!("\0{}\0{}", race.as_deref().unwrap_or(""), class.as_deref().unwrap_or("")));
			race = None;
			class = None;
		}
		let ci = match self.char_ix.get(&key) {
			Some(i) => *i,
			None => {
				self.chars.push(Char::new(race, class, ch.get("faction").as_str().map(str::to_string)));
				self.char_sess.push(sess);
				self.char_ix.insert(key, self.chars.len() - 1);
				self.chars.len() - 1
			}
		};
		for (m, f) in rec.get("maps").entries() {
			if let (Ok(m), Some(s)) = (m.parse::<i64>(), frame_size(&f)) {
				self.session_frames.entry(m).or_insert(s);
			}
		}
		self.heads.push(head);
		self.builds.push(build);
		let t0 = rec.get("started").as_num().filter(|n| n.is_finite()).unwrap_or(0.0);
		let (mut riding, mut flying) = (false, false);
		let mut last_win: (Option<i64>, f64) = (None, f64::NEG_INFINITY);
		let rows = &mut self.chars[ci].rows;
		for ev in rec.get("events").items() {
			let t = t0 + ev.get("t").as_num().filter(|n| n.is_finite()).unwrap_or(0.0);
			let q = pos_int(&ev.get("q"));
			let npc = pos_int(&ev.get("npc"));
			let row = |row: Row| Timed { t, build, row };
			match ev.get("e").as_str().unwrap_or("") {
				"session" | "level" => {
					if let Some(l) = int(&ev.get("lvl")) {
						rows.push(row(Row::Level(l)));
					}
				}
				"offer" => {
					rows.push(row(Row::Window(Window {
						npc,
						available: ids(&ev.get("available")),
						not_offered: ids(&ev.get("notOffered")),
						active: ids(&ev.get("active")),
						log: ids(&ev.get("log")),
						done: ids(&ev.get("done")),
					})));
					last_win = (npc, t);
				}
				"detail" => {
					rows.push(row(Row::Detail(npc)));
					if npc.is_some() {
						last_win = (npc, t);
					}
				}
				"accept" => {
					if let Some(q) = q {
						let npc = npc.or(if t - last_win.1 <= ACCEPT_WINDOW { last_win.0 } else { None });
						rows.push(row(Row::Accept(q, npc)));
						if (self.scope)(q) {
							self.seen.entry(q).or_default().push(sess);
							if let Some(m) = pos_int(&ev.get("map")) {
								self.accept_maps.entry(q).or_default().push((sess, m));
							}
						}
					}
				}
				"turnin" => {
					if let Some(q) = q {
						rows.push(row(Row::Turnin(q)));
						if (self.scope)(q) {
							self.seen.entry(q).or_default().push(sess);
						}
					}
				}
				"objectives" => {
					if let Some(q) = q.filter(|q| (self.scope)(*q)) {
						let list = ev.get("objectives").items().iter().map(|o| (o.get("type").as_str().map(str::to_string), int(&o.get("max")))).collect();
						self.lists.entry(q).or_default().push((sess, list));
					}
				}
				"progress" => {
					let (Some(q), Some(oi)) = (q, pos_int(&ev.get("oi"))) else { continue };
					if !(self.scope)(q) {
						continue;
					}
					self.seen.entry(q).or_default().push(sess);
					let (Some(map), x, y) = (pos_int(&ev.get("map")), ev.get("x").num(), ev.get("y").num()) else { continue };
					// A tick while riding a boat or lift or on a flight is not where the objective is.
					if riding || flying || !(0.0..=100.0).contains(&x) || !(0.0..=100.0).contains(&y) {
						continue;
					}
					self.ticks.entry((q, oi)).or_default().push(Tick { sess, map, x, y });
				}
				"ride" => riding = ev.get("on").truthy(),
				"taxi" => flying = true,
				"land" => flying = false,
				_ => {}
			}
		}
	}
}

// ---------------------------------------------------------------- facts

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Status {
	Trusted,
	Gap,
	Conflict,
	Stale,
}

impl Status {
	pub fn as_str(self) -> &'static str {
		match self {
			Status::Trusted => "trusted",
			Status::Gap => "gap",
			Status::Conflict => "conflict",
			Status::Stale => "stale",
		}
	}
}

/// A fact against the current data (docs/forge/learn.md "Conflicts").
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub enum Class {
	VsCorrection,
	Conflict,
	Replaces,
	Pending,
	Stale,
	New,
	Confirms,
}

pub const CLASSES: [Class; 7] = [Class::New, Class::Confirms, Class::Replaces, Class::VsCorrection, Class::Conflict, Class::Stale, Class::Pending];

impl Class {
	pub fn as_str(self) -> &'static str {
		match self {
			Class::New => "new",
			Class::Confirms => "confirms",
			Class::Replaces => "replaces",
			Class::VsCorrection => "vs-correction",
			Class::Conflict => "conflict",
			Class::Stale => "stale",
			Class::Pending => "pending",
		}
	}
}

/// How counted voters' evidence combines: none agree -> None; fewer than ⅔ of those with evidence
/// either way agree -> conflict; `need` agree (or a vouched one does) -> trusted; else gap.
pub fn quorum(agree: &FxHashSet<usize>, disagree: usize, need: usize, vouched: &dyn Fn(usize) -> bool) -> Option<Status> {
	let a = agree.len();
	if a == 0 {
		return None;
	}
	if a * 3 < (a + disagree) * 2 {
		return Some(Status::Conflict);
	}
	Some(if a >= need || agree.iter().any(|v| vouched(*v)) { Status::Trusted } else { Status::Gap })
}

/// The kind of fact (a field of the snapshot).
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub enum Kind {
	Spot,
	Pre,
	NotPre,
	PreAny,
	NotPreAny,
	Excl,
	NotExcl,
	MinLevel,
}

impl Kind {
	pub fn as_str(self) -> &'static str {
		match self {
			Kind::Spot => "objective spot",
			Kind::Pre => "prerequisite",
			Kind::NotPre => "not a prerequisite",
			Kind::PreAny => "any-of prerequisites",
			Kind::NotPreAny => "not any-of prerequisites",
			Kind::Excl => "exclusive with",
			Kind::NotExcl => "not exclusive with",
			Kind::MinLevel => "minimum level",
		}
	}
}

pub const KINDS: [Kind; 8] = [Kind::Spot, Kind::Pre, Kind::NotPre, Kind::PreAny, Kind::NotPreAny, Kind::Excl, Kind::NotExcl, Kind::MinLevel];

struct Fact {
	kind: Kind,
	/// The objective line (1-based) of a spot.
	line: Option<usize>,
	value: V,
	bounds: Option<V>,
	voters: usize,
	counted: FxHashSet<usize>,
	disagree: usize,
	status: Status,
	builds: (i64, i64),
	beats: Option<String>,
	class: Class,
	/// The data's value it was compared with (report and conflicts only).
	data: V,
	/// The correction's value, when a correction sets the field.
	correction: V,
}

impl Fact {
	fn json(&self) -> V {
		let o = Obj::new();
		o.set("value", self.value.clone());
		if let Some(b) = &self.bounds {
			o.set("bounds", b.clone());
		}
		o.set("voters", self.voters);
		o.set("counted", self.counted.len());
		o.set("status", self.status.as_str());
		o.set("builds", V::from(vec![V::from(self.builds.0), V::from(self.builds.1)]));
		o.set("beats", self.beats.clone().map_or(V::Null, V::from));
		V::Obj(o)
	}
}

struct Line {
	kind: Option<String>,
	count: Option<i64>,
}

struct QuestOut {
	id: i64,
	zone: Option<i64>,
	lines: Vec<Line>,
	/// Whether `lines` is the game's own list (else only the lines that ticked).
	known: bool,
	facts: Vec<Fact>,
}

fn pct(n: f64) -> f64 {
	(n * 100.0).round() / 100.0
}

fn int_list(v: &[i64]) -> V {
	V::from(v.iter().map(|x| V::from(*x)).collect::<Vec<V>>())
}

/// The data quest's sources a recorded value agrees with or beats (`+`-joined), recordings and
/// corrections aside.
fn sources_of(q: &V) -> Option<String> {
	let s: Vec<String> = q.get("source").items().iter().filter_map(|x| x.as_str().map(str::to_string)).filter(|s| !s.starts_with("recorder") && s != crate::corrections::SOURCE).collect();
	(!s.is_empty()).then(|| s.join("+"))
}

fn classify(status: Status, data_has: bool, same: bool, corrected: bool) -> Class {
	match status {
		Status::Conflict => Class::Conflict,
		Status::Stale => Class::Stale,
		_ if !data_has => Class::New,
		_ if same => Class::Confirms,
		_ if corrected => Class::VsCorrection,
		Status::Trusted => Class::Replaces,
		_ => Class::Pending,
	}
}

struct Ctx<'a> {
	data: &'a Data,
	frames: FxHashMap<i64, (f64, f64)>,
	/// Per voter: vouched (the maintainer's own or vouched-for recordings) and counted.
	vouched: Vec<bool>,
	min_voters: usize,
}

impl Ctx<'_> {
	fn is_vouched(&self, v: usize) -> bool {
		self.vouched[v]
	}

	fn yards(&self, map: i64, x: f64, y: f64) -> Option<(f64, f64)> {
		self.frames.get(&map).map(|(w, h)| (x * w / 100.0, y * h / 100.0))
	}

	/// Where our data places an objective: its NPCs' or objects' spawns, its item's droppers'
	/// spawns, an event's point. -> (map, x%, y%)
	fn data_points(&self, o: &V) -> Vec<(i64, f64, f64)> {
		let mut out = Vec::new();
		let spawns = |out: &mut Vec<(i64, f64, f64)>, table: &V, id: &str| {
			for (m, s) in table.get(id).get("spawns").entries() {
				let Ok(m) = m.parse::<i64>() else { continue };
				for p in s.get("pts").items() {
					let (x, y) = (p.at(0).num(), p.at(1).num());
					if x.is_finite() && y.is_finite() {
						out.push((m, x, y));
					}
				}
			}
		};
		let id = o.get("id");
		let key = |v: &V| num_str(v.num());
		match o.get("type").as_str() {
			Some("kill" | "talk") => {
				for x in std::iter::once(id.clone()).chain(o.get("credit").items()) {
					spawns(&mut out, &self.data.npcs, &key(&x));
				}
			}
			Some("object") => spawns(&mut out, &self.data.objects, &key(&id)),
			Some("item") => {
				let d = self.data.items.get(&key(&id)).get("drops");
				for n in d.get("npc").keys() {
					spawns(&mut out, &self.data.npcs, &n);
				}
				for n in d.get("object").keys() {
					spawns(&mut out, &self.data.objects, &n);
				}
			}
			Some("event") => {
				if let (Some(m), x, y) = (pos_int(&o.get("map")), o.get("x").num(), o.get("y").num()) {
					if x.is_finite() && y.is_finite() {
						out.push((m, x, y));
					}
				}
			}
			_ => {}
		}
		out
	}

	/// Whether a correction gives an objective's NPC or object its spawns.
	fn spawn_corrected(&self, o: &V) -> bool {
		let c = &self.data.corrections;
		let key = num_str(o.get("id").num());
		let has = |sec: &str| c.get(sec).get(&key).get("addSpawns").truthy() || c.get(sec).get(&key).get("set").get("spawns").truthy();
		match o.get("type").as_str() {
			Some("kill" | "talk") => has("npcs"),
			Some("object") => has("objects"),
			_ => false,
		}
	}
}

/// Whether the game's objective list (its lines' types; empty: not recorded) lines up with our
/// data's objectives in order: as many lines, each of a fitting type.
fn lines_up(q: &V, kinds: &[Option<&str>]) -> bool {
	let objs = q.get("objectives").items();
	kinds.is_empty() || (objs.len() == kinds.len() && kinds.iter().zip(&objs).all(|(k, o)| crate::recordings::fits(*k, o.get("type").as_str().unwrap_or(""))))
}

/// The data objective recorded line `i` (0-based) is ([`lines_up`]).
fn data_objective(q: &V, kinds: &[Option<&str>], i: usize) -> Option<V> {
	if !lines_up(q, kinds) {
		return None;
	}
	q.get("objectives").items().get(i).cloned()
}

/// The fields a quest correction sets.
fn corrected_fields(c: &V, q: i64) -> FxHashSet<String> {
	c.get("quests").get(&q.to_string()).get("set").keys().iter().map(|k| k.to_string()).collect()
}

// ---------------------------------------------------------------- learning

impl Learner<'_> {
	/// Combines what was read into the snapshot.
	pub fn finish(mut self, data: &Data, verdicts_meta: (Option<String>, usize, usize), previous: Option<&V>) -> Output {
		// Who counts: established players, one vote per merged person.
		let counts = establish_heads(&mut self.heads, self.cfg.establish);
		let mut names: FxHashMap<String, usize> = FxHashMap::default();
		let mut parent: Vec<usize> = Vec::new();
		let id = |names: &mut FxHashMap<String, usize>, parent: &mut Vec<usize>, s: String| -> usize {
			*names.entry(s).or_insert_with(|| {
				parent.push(parent.len());
				parent.len() - 1
			})
		};
		fn find(p: &mut [usize], mut i: usize) -> usize {
			while p[i] != i {
				p[i] = p[p[i]];
				i = p[i];
			}
			i
		}
		let mut base: Vec<usize> = Vec::with_capacity(self.heads.len());
		let mut base_voters: FxHashSet<usize> = FxHashSet::default();
		for h in &self.heads {
			let a = id(&mut names, &mut parent, h.voter());
			base_voters.insert(a);
			if let Some(p) = self.verdicts.person.get(&h.contributor) {
				let b = id(&mut names, &mut parent, format!("person\0{p}"));
				let (ra, rb) = (find(&mut parent, a), find(&mut parent, b));
				if ra != rb {
					parent[ra.max(rb)] = ra.min(rb);
				}
			}
			base.push(a);
		}
		let mut dense: FxHashMap<usize, usize> = FxHashMap::default();
		let sess_voter: Vec<usize> = base
			.iter()
			.map(|a| {
				let r = find(&mut parent, *a);
				let n = dense.len();
				*dense.entry(r).or_insert(n)
			})
			.collect();
		let nv = dense.len();
		let mut counted = vec![false; nv];
		let mut is_vouched = vec![false; nv];
		for (i, h) in self.heads.iter().enumerate() {
			counted[sess_voter[i]] |= counts[i];
			is_vouched[sess_voter[i]] |= counts[i] && vouched(&h.voter());
		}
		let merged = base_voters.len() - nv;
		let mut frames = self.session_frames.clone();
		frames.extend(data.frames.iter().map(|(k, v)| (*k, *v)));
		let ctx = Ctx { data, frames, vouched: is_vouched, min_voters: self.cfg.min_voters };
		let newest_build = self.builds.iter().zip(&counts).filter(|(_, c)| **c).map(|(b, _)| *b).max().unwrap_or(0);

		for (c, s) in self.chars.iter_mut().zip(&self.char_sess) {
			c.voter = sess_voter[*s as usize];
			c.prepare();
		}
		let mut qd: FxHashMap<i64, QData> = FxHashMap::default();
		for (k, q) in data.quests.entries() {
			if let Ok(id) = k.parse::<i64>() {
				qd.insert(id, qdata(&q));
			}
		}
		let quests = Quests::new(qd);
		let givers = offers::giver_map(&quests, &self.chars);
		let scope = self.scope;
		let by_q = offers::observations(&self.chars, &quests, &givers, scope);

		// Per quest: who recorded it on the newest build (stale facts), and its zone.
		let mut on_newest: FxHashMap<i64, FxHashSet<usize>> = FxHashMap::default();
		for (q, ss) in &self.seen {
			let e = on_newest.entry(*q).or_default();
			for s in ss {
				let s = *s as usize;
				if self.builds[s] == newest_build && counts[s] {
					e.insert(sess_voter[s]);
				}
			}
		}
		for (q, obs) in &by_q {
			let e = on_newest.entry(*q).or_default();
			for o in obs {
				let v = self.chars[o.c].voter;
				if o.build == newest_build && counted[v] {
					e.insert(v);
				}
			}
		}

		let mut all_q: BTreeSet<i64> = self.ticks.keys().map(|k| k.0).collect();
		all_q.extend(by_q.keys());
		all_q.extend(self.lists.keys());
		let mut out: Vec<QuestOut> = Vec::new();
		for q in all_q {
			let qv = data.quests.get(&q.to_string());
			let corrected = corrected_fields(&data.corrections, q);
			let src = sources_of(&qv);
			let mut facts: Vec<Fact> = Vec::new();
			// The game's objective list most counted voters recorded.
			let mut sigs: Vec<(Vec<(Option<String>, Option<i64>)>, FxHashSet<usize>, FxHashSet<usize>)> = Vec::new();
			for (s, list) in self.lists.get(&q).into_iter().flatten() {
				let v = sess_voter[*s as usize];
				let i = match sigs.iter().position(|x| x.0 == *list) {
					Some(i) => i,
					None => {
						sigs.push((list.clone(), FxHashSet::default(), FxHashSet::default()));
						sigs.len() - 1
					}
				};
				sigs[i].1.insert(v);
				if counted[v] {
					sigs[i].2.insert(v);
				}
			}
			sigs.sort_by(|a, b| b.2.len().cmp(&a.2.len()).then(b.1.len().cmp(&a.1.len())));
			let mut lines: Vec<Line> = sigs.first().map(|s| s.0.iter().map(|(k, c)| Line { kind: k.clone(), count: *c }).collect()).unwrap_or_default();
			let max_oi = self.ticks.keys().filter(|k| k.0 == q).map(|k| k.1).max().unwrap_or(0);
			let known_list = !lines.is_empty();
			while (lines.len() as i64) < max_oi {
				lines.push(Line { kind: None, count: None });
			}

			// Objective spots.
			for oi in 1..=lines.len() {
				let Some(ticks) = self.ticks.get(&(q, oi as i64)) else { continue };
				let mut pts = Vec::new();
				for t in ticks {
					if let Some((x, y)) = ctx.yards(t.map, t.x, t.y) {
						pts.push(spots::Pt { voter: sess_voter[t.sess as usize], map: t.map, x, y });
					}
				}
				let found = spots::locate(&pts);
				let mut agree: FxHashSet<usize> = FxHashSet::default();
				let mut all: FxHashSet<usize> = FxHashSet::default();
				for s in &found.spots {
					all.extend(&s.voters);
					agree.extend(s.voters.iter().filter(|v| counted[**v]));
				}
				let disagree = found.outliers.iter().filter(|v| counted[**v]).count();
				let Some(status) = quorum(&agree, disagree, MIN_SPOT_VOTERS, &|v| ctx.is_vouched(v)) else { continue };
				let mut builds = (i64::MAX, i64::MIN);
				for t in ticks {
					if agree.contains(&sess_voter[t.sess as usize]) {
						let b = self.builds[t.sess as usize];
						builds = (builds.0.min(b), builds.1.max(b));
					}
				}
				let value: Vec<V> = found
					.spots
					.iter()
					.filter(|s| s.voters.iter().any(|v| counted[*v]))
					.map(|s| {
						let (w, h) = ctx.frames[&s.map];
						let o = Obj::new();
						o.set("map", s.map);
						o.set("x", pct(s.x * 100.0 / w));
						o.set("y", pct(s.y * 100.0 / h));
						o.set("r", s.r.round());
						o.set("voters", s.voters.len());
						o.set("counted", s.voters.iter().filter(|v| counted[**v]).count());
						V::Obj(o)
					})
					.collect();
				let kinds: Vec<Option<&str>> = if known_list { lines.iter().map(|l| l.kind.as_deref()).collect() } else { Vec::new() };
				let dobj = if qv.truthy() { data_objective(&qv, &kinds, oi - 1) } else { None };
				let dpts = dobj.as_ref().map(|o| ctx.data_points(o)).unwrap_or_default();
				let top = found.spots.iter().find(|s| s.voters.iter().any(|v| counted[*v]));
				let same = top.is_some_and(|s| dpts.iter().any(|(m, x, y)| *m == s.map && ctx.yards(*m, *x, *y).is_some_and(|(px, py)| (px - s.x).hypot(py - s.y) <= AGREE_YD)));
				let corr = dobj.as_ref().is_some_and(|o| ctx.spawn_corrected(o)) || corrected.contains("objectives");
				let class = classify(status, !dpts.is_empty(), same, corr);
				let beats = match (&dobj, class) {
					(Some(o), Class::Confirms | Class::Replaces) => Some(
						match o.get("type").as_str() {
							Some("item") => "drop sources",
							Some("object") => "object spawns",
							Some("event") => "event point",
							_ => "npc spawns",
						}
						.to_string(),
					),
					_ => None,
				};
				let data_v = match (&dobj, dpts.first()) {
					(Some(_), Some((m, x, y))) => V::from(format!("{} points, first {m} {:.1},{:.1}", dpts.len(), x, y)),
					_ => V::Null,
				};
				facts.push(Fact {
					kind: Kind::Spot,
					line: Some(oi),
					value: V::from(value),
					bounds: None,
					voters: all.len(),
					counted: agree,
					disagree,
					status,
					builds,
					beats,
					class,
					data: data_v,
					correction: V::Null,
				});
			}

			// Prerequisites, exclusive groups, minimum level.
			if let Some(obs) = by_q.get(&q) {
				let all_refs: Vec<&offers::Obs> = obs.iter().collect();
				let counted_refs: Vec<&offers::Obs> = obs.iter().filter(|o| counted[self.chars[o.c].voter]).collect();
				let ev = offers::quest_evidence(q, &counted_refs, &self.chars, &quests);
				let ev_all = offers::quest_evidence(q, &all_refs, &self.chars, &quests);
				let voters_of = |cs: &FxHashSet<usize>| -> FxHashSet<usize> { cs.iter().map(|c| self.chars[*c].voter).collect() };
				let builds_of = |cs: &FxHashSet<usize>| -> (i64, i64) {
					let mut b = (i64::MAX, i64::MIN);
					for c in cs {
						if let Some((x, y)) = ev.builds.get(c) {
							b = (b.0.min(*x), b.1.max(*y));
						}
					}
					b
				};
				let empty = QData::default();
				let d = quests.q.get(&q).unwrap_or(&empty);
				let (all_of, any_of) = d.split();
				let pre_corrected = ["pre", "preAll", "preAny"].iter().any(|k| corrected.contains(*k));
				let pre_corr_v = || {
					let c = data.corrections.get("quests").get(&q.to_string()).get("set");
					let o = Obj::new();
					for k in ["pre", "preAll", "preAny"] {
						if c.has(k) {
							o.set(k, c.get(k));
						}
					}
					V::Obj(o)
				};
				let all_voters_of = |p: i64, f: &dyn Fn(&offers::PreRow) -> &FxHashSet<usize>| ev_all.prereqs.iter().find(|r| r.p == p).map_or(0, |r| voters_of(f(r)).len());
				for r in &ev.prereqs {
					let backed = voters_of(&r.backed);
					let without = voters_of(&r.offered_without);
					// Refusal-backed. Offered without it too: a conflict while the unlocks still make two
					// thirds, else contradicted like any co-occurrence.
					let conflict = r.unlock && !without.is_empty() && backed.len() * 3 >= (backed.len() + without.len()) * 2;
					if r.status == PreStatus::Confirmed || conflict {
						let status = if conflict { Some(Status::Conflict) } else { quorum(&backed, 0, MIN_OFFER_VOTERS, &|v| ctx.is_vouched(v)) };
						let Some(status) = status else { continue };
						let in_data = all_of.contains(&r.p) || any_of.contains(&r.p);
						let class = classify(status, true, in_data, pre_corrected);
						facts.push(Fact {
							kind: Kind::Pre,
							line: None,
							value: V::from(r.p),
							bounds: None,
							voters: all_voters_of(r.p, &|x| &x.backed),
							counted: backed,
							disagree: without.len(),
							status,
							builds: builds_of(&r.backed),
							beats: if class == Class::Confirms { src.clone() } else { None },
							class,
							data: int_list(&all_of.iter().chain(&any_of).copied().collect::<Vec<_>>()),
							correction: if pre_corrected { pre_corr_v() } else { V::Null },
						});
					} else if r.status == PreStatus::Contradicted && all_of.contains(&r.p) {
						// Our data's all-of prerequisite, offered without it.
						let Some(status) = quorum(&without, backed.len(), ctx.min_voters, &|v| ctx.is_vouched(v)) else { continue };
						let class = classify(status, true, false, pre_corrected);
						facts.push(Fact {
							kind: Kind::NotPre,
							line: None,
							value: V::from(r.p),
							bounds: None,
							voters: all_voters_of(r.p, &|x| &x.offered_without),
							counted: without,
							disagree: backed.len(),
							status,
							builds: builds_of(&r.offered_without),
							beats: if class == Class::Replaces { src.clone() } else { None },
							class,
							data: int_list(&all_of),
							correction: if pre_corrected { pre_corr_v() } else { V::Null },
						});
					}
				}
				if !ev.any_of.is_empty() {
					let members: FxHashSet<usize> = ev.prereqs.iter().filter(|r| ev.any_of.contains(&r.p)).flat_map(|r| r.backed.iter().copied()).collect();
					let backed = voters_of(&members);
					let none = voters_of(&ev.any_of_none);
					if !none.is_empty() {
						if let Some(status) = quorum(&none, backed.len(), ctx.min_voters, &|v| ctx.is_vouched(v)) {
							let class = classify(status, true, false, pre_corrected);
							facts.push(Fact {
								kind: Kind::NotPreAny,
								line: None,
								value: int_list(&ev.any_of),
								bounds: None,
								voters: voters_of(&ev_all.any_of_none).len(),
								counted: none,
								disagree: backed.len(),
								status,
								builds: builds_of(&ev.any_of_none),
								beats: if class == Class::Replaces { src.clone() } else { None },
								class,
								data: int_list(&ev.any_of),
								correction: if pre_corrected { pre_corr_v() } else { V::Null },
							});
						}
					} else if let Some(status) = quorum(&backed, 0, MIN_OFFER_VOTERS, &|v| ctx.is_vouched(v)) {
						let class = classify(status, true, true, pre_corrected);
						facts.push(Fact {
							kind: Kind::PreAny,
							line: None,
							value: int_list(&ev.any_of),
							bounds: None,
							voters: backed.len(),
							counted: backed,
							disagree: 0,
							status,
							builds: builds_of(&members),
							beats: src.clone(),
							class,
							data: int_list(&ev.any_of),
							correction: V::Null,
						});
					}
				}
				let excl_corrected = corrected.contains("excl");
				for x in &ev.excl {
					let closed = voters_of(&x.closed);
					let open = voters_of(&x.open);
					let all_x = ev_all.excl.iter().find(|r| r.x == x.x);
					if !open.is_empty() {
						let Some(status) = quorum(&open, closed.len(), ctx.min_voters, &|v| ctx.is_vouched(v)) else { continue };
						let class = classify(status, true, false, excl_corrected);
						facts.push(Fact {
							kind: Kind::NotExcl,
							line: None,
							value: V::from(x.x),
							bounds: None,
							voters: all_x.map_or(0, |r| voters_of(&r.open).len()),
							counted: open,
							disagree: closed.len(),
							status,
							builds: builds_of(&x.open),
							beats: if class == Class::Replaces { src.clone() } else { None },
							class,
							data: int_list(&d.excl),
							correction: V::Null,
						});
					} else if let Some(status) = quorum(&closed, 0, MIN_OFFER_VOTERS, &|v| ctx.is_vouched(v)) {
						facts.push(Fact {
							kind: Kind::Excl,
							line: None,
							value: V::from(x.x),
							bounds: None,
							voters: all_x.map_or(0, |r| voters_of(&r.closed).len()),
							counted: closed,
							disagree: 0,
							status,
							builds: builds_of(&x.closed),
							beats: src.clone(),
							class: classify(status, true, true, excl_corrected),
							data: int_list(&d.excl),
							correction: V::Null,
						});
					}
				}
				// Minimum level: min <= the lowest offered level (hi); min > the highest clean refusal (lo - 1).
				// A quest that needs a profession skill too: a refusal may be the skill, not the level.
				let skill = qv.get("skill").truthy();
				if let Some((hi, hi_chars)) = ev.min_offered.as_ref().filter(|_| !skill) {
					let lo = ev.max_refused.as_ref().map(|(l, _)| l + 1);
					let lo_chars = ev.max_refused.as_ref().map(|(_, c)| c.clone()).unwrap_or_default();
					let pinned = lo == Some(*hi);
					let data_min = d.min_level;
					let below_data = data_min.is_some_and(|m| *hi < m);
					let above_data = data_min.is_some_and(|m| lo.is_some_and(|l| l > m));
					if pinned || below_data || above_data {
						let mut cs: FxHashSet<usize> = FxHashSet::default();
						if pinned || below_data {
							cs.extend(hi_chars);
						}
						if pinned || above_data {
							cs.extend(&lo_chars);
						}
						let agree = voters_of(&cs);
						let value = if pinned { Some(*hi) } else { None };
						let same = value.is_some() && value == data_min;
						let need = if data_min.is_some() && !same { ctx.min_voters } else { MIN_OFFER_VOTERS };
						if let Some(status) = quorum(&agree, 0, need, &|v| ctx.is_vouched(v)) {
							let class = if value.is_none() && status != Status::Conflict {
								if corrected.contains("minLevel") {
									Class::VsCorrection
								} else {
									Class::Pending
								}
							} else {
								classify(status, data_min.is_some(), same, corrected.contains("minLevel"))
							};
							let all_cs: FxHashSet<usize> = ev_all.min_offered.iter().flat_map(|m| m.1.iter().copied()).chain(ev_all.max_refused.iter().flat_map(|m| m.1.iter().copied())).collect();
							facts.push(Fact {
								kind: Kind::MinLevel,
								line: None,
								value: value.map_or(V::Null, V::from),
								bounds: Some(V::from(vec![lo.map_or(V::Null, V::from), V::from(*hi)])),
								voters: voters_of(&all_cs).len().max(agree.len()),
								counted: agree,
								disagree: 0,
								status,
								builds: builds_of(&cs),
								beats: if matches!(class, Class::Confirms | Class::Replaces) { src.clone() } else { None },
								class,
								data: data_min.map_or(V::Null, V::from),
								correction: if corrected.contains("minLevel") { data.corrections.get("quests").get(&q.to_string()).get("set").get("minLevel") } else { V::Null },
							});
						}
					}
				}
			}

			// Stale: seen only on an older build while three counted voters on the newest didn't confirm it.
			let fresh = on_newest.get(&q);
			for f in facts.iter_mut() {
				if f.builds.1 < newest_build && f.status != Status::Conflict && fresh.is_some_and(|s| s.difference(&f.counted).count() >= STALE_VOTERS) {
					f.status = Status::Stale;
					f.class = Class::Stale;
				}
			}
			if facts.is_empty() {
				continue;
			}
			// The zone: our data's, else where most voters accepted it.
			let zone = int(&qv.get("zone")).filter(|z| *z > 0).or_else(|| {
				let mut by: BTreeMap<i64, FxHashSet<usize>> = BTreeMap::new();
				for (s, m) in self.accept_maps.get(&q).into_iter().flatten() {
					by.entry(*m).or_default().insert(sess_voter[*s as usize]);
				}
				by.iter().max_by(|a, b| a.1.len().cmp(&b.1.len()).then(b.0.cmp(a.0))).map(|(m, _)| *m)
			});
			out.push(QuestOut { id: q, zone, lines, known: known_list, facts });
		}

		let voters_counted = counted.iter().filter(|c| **c).count();
		let archive = ArchiveMeta {
			revision: self.hash.finalize().iter().take(8).map(|b| format!("{b:02x}")).collect(),
			files: self.files,
			sessions: self.heads.len(),
			unreadable: self.unreadable,
			older_build: self.older_build,
			excluded: self.excluded,
			voters: nv,
			counted: voters_counted,
			merged,
			newest_build,
			newest_received: self.newest_received,
		};
		render(&out, &ctx, &archive, verdicts_meta, previous, &|q| (self.scope)(q))
	}
}

struct ArchiveMeta {
	revision: String,
	files: usize,
	sessions: usize,
	unreadable: usize,
	older_build: usize,
	excluded: usize,
	voters: usize,
	counted: usize,
	merged: usize,
	newest_build: i64,
	newest_received: f64,
}

// ---------------------------------------------------------------- output

fn quest_json(q: &QuestOut) -> V {
	let o = Obj::new();
	o.set("zone", q.zone.map_or(V::Null, V::from));
	if q.known {
		// The game's objective list (its lines' types): how lines map to our data's objectives.
		o.set("list", V::from(q.lines.iter().map(|l| l.kind.clone().map_or(V::Null, V::from)).collect::<Vec<V>>()));
	}
	let lines: Vec<V> = q
		.facts
		.iter()
		.filter(|f| f.kind == Kind::Spot)
		.map(|f| {
			let l = Obj::new();
			let line = f.line.unwrap_or(0);
			l.set("line", line);
			let meta = q.lines.get(line.wrapping_sub(1));
			l.set("type", meta.and_then(|m| m.kind.clone()).map_or(V::Null, V::from));
			l.set("count", meta.and_then(|m| m.count).map_or(V::Null, V::from));
			l.set("at", f.json());
			V::Obj(l)
		})
		.collect();
	if !lines.is_empty() {
		o.set("objectives", V::from(lines));
	}
	for (kind, key, list) in [
		(Kind::Pre, "pre", true),
		(Kind::NotPre, "notPre", true),
		(Kind::PreAny, "preAny", false),
		(Kind::NotPreAny, "notPreAny", false),
		(Kind::Excl, "excl", true),
		(Kind::NotExcl, "notExcl", true),
		(Kind::MinLevel, "minLevel", false),
	] {
		let fs: Vec<V> = q.facts.iter().filter(|f| f.kind == kind).map(Fact::json).collect();
		if fs.is_empty() {
			continue;
		}
		if list {
			o.set(key, V::from(fs));
		} else {
			o.set(key, fs[0].clone());
		}
	}
	V::Obj(o)
}

/// (quest, field key) -> (value, status) of a snapshot, for "since the last snapshot".
fn flatten(quests: &V) -> BTreeMap<String, String> {
	let mut out = BTreeMap::new();
	for (q, r) in quests.entries() {
		for l in r.get("objectives").items() {
			out.insert(format!("{q} objective {}", l.get("line").num()), format!("{} {}", stringify(&l.get("at").get("value"), None), l.get("at").get("status").to_js_string()));
		}
		for key in ["pre", "notPre", "excl", "notExcl"] {
			for f in r.get(key).items() {
				out.insert(format!("{q} {key} {}", f.get("value").to_js_string()), f.get("status").to_js_string());
			}
		}
		for key in ["preAny", "notPreAny", "minLevel"] {
			let f = r.get(key);
			if f.truthy() {
				out.insert(format!("{q} {key}"), format!("{} {}", stringify(&f.get("value"), None), f.get("status").to_js_string()));
			}
		}
	}
	out
}

fn zone_name(data: &Data, z: Option<i64>) -> String {
	match z {
		Some(z) => data.zones.get(&z.to_string()).get("name").as_str().map_or_else(|| format!("map {z}"), |n| format!("{n} ({z})")),
		None => "no zone".into(),
	}
}

fn title(data: &Data, q: i64) -> String {
	data.quests.get(&q.to_string()).get("title").as_str().unwrap_or("(not in our data)").to_string()
}

fn describe(f: &Fact) -> String {
	let what = match f.kind {
		Kind::Spot => {
			let spots: Vec<String> = f
				.value
				.items()
				.iter()
				.map(|s| {
					format!(
						"{} {},{} ±{} yd ({} counted)",
						s.get("map").to_js_string(),
						s.get("x").to_js_string(),
						s.get("y").to_js_string(),
						s.get("r").to_js_string(),
						s.get("counted").to_js_string()
					)
				})
				.collect();
			format!("objective {}: {}", f.line.unwrap_or(0), spots.join("; "))
		}
		Kind::MinLevel => {
			format!("minimum level {} (bounds {})", if f.value.is_nullish() { "not pinned".to_string() } else { f.value.to_js_string() }, stringify(f.bounds.as_ref().unwrap_or(&V::Null), None))
		}
		k => format!("{} {}", k.as_str(), stringify(&f.value, None)),
	};
	let mut s = format!("{what}: {} counted of {} voters", f.counted.len(), f.voters);
	if f.disagree > 0 {
		let _ = write!(s, ", {} counted disagree", f.disagree);
	}
	let _ = write!(s, "; {}", f.status.as_str());
	if !f.data.is_nullish() {
		let _ = write!(s, "; data: {}", if f.data.is_str() { f.data.to_js_string() } else { stringify(&f.data, None) });
	}
	if !f.correction.is_nullish() {
		let _ = write!(s, "; correction: {}", stringify(&f.correction, None));
	}
	s
}

fn render(out: &[QuestOut], ctx: &Ctx, a: &ArchiveMeta, verdicts: (Option<String>, usize, usize), previous: Option<&V>, scope: &dyn Fn(i64) -> bool) -> Output {
	let data = ctx.data;
	let quests = Obj::new();
	for q in out {
		quests.set(&q.id.to_string(), quest_json(q));
	}
	let quests_v = V::Obj(quests.clone());
	let quests_text = crate::build::serialize_table(&quests);

	// Counts.
	let mut by_kind: BTreeMap<(Kind, Class), usize> = BTreeMap::new();
	let mut by_status: BTreeMap<(Kind, &str), usize> = BTreeMap::new();
	for q in out {
		for f in &q.facts {
			*by_kind.entry((f.kind, f.class)).or_default() += 1;
			*by_status.entry((f.kind, f.status.as_str())).or_default() += 1;
		}
	}
	let spot_quests_all_trusted =
		out.iter().filter(|q| !q.lines.is_empty() && (1..=q.lines.len()).all(|l| q.facts.iter().any(|f| f.kind == Kind::Spot && f.line == Some(l) && f.status == Status::Trusted))).count();

	// meta.json
	let meta = Obj::new();
	meta.set("scope", "forever-new");
	meta.set("through", a.newest_received);
	let am = Obj::new();
	am.set("revision", a.revision.as_str());
	am.set("files", a.files);
	am.set("sessions", a.sessions);
	let left = Obj::new();
	left.set("excluded", a.excluded);
	left.set("olderBuild", a.older_build);
	left.set("unreadable", a.unreadable);
	am.set("leftOut", V::Obj(left));
	am.set("voters", a.voters);
	am.set("counted", a.counted);
	am.set("mergedPeople", a.merged);
	am.set("newestBuild", a.newest_build);
	meta.set("archive", V::Obj(am));
	let vm = Obj::new();
	vm.set("revision", verdicts.0.clone().map_or(V::Null, V::from));
	vm.set("exclude", verdicts.1);
	vm.set("suspect", verdicts.2);
	meta.set("verdicts", V::Obj(vm));
	meta.set("data", data.built_at.clone());
	let th = Obj::new();
	th.set("overrideVoters", ctx.min_voters);
	th.set("agreement", "2/3");
	th.set("spotVoters", MIN_SPOT_VOTERS);
	th.set("offerVoters", MIN_OFFER_VOTERS);
	th.set("gapVoters", 1);
	th.set("linkYd", spots::LINK_YD);
	th.set("noiseYd", spots::NOISE_YD);
	th.set("outlierMinYd", spots::OUTLIER_MIN_YD);
	th.set("outlierMads", 3);
	th.set("spotRadius", "p80");
	th.set("agreeYd", AGREE_YD);
	th.set("staleVoters", STALE_VOTERS);
	th.set("handInLagS", offers::STALE);
	th.set("detailWindowS", offers::DETAIL_S);
	th.set("voidS", offers::VOID_S);
	th.set("immediateS", offers::IMMEDIATE);
	meta.set("thresholds", V::Obj(th));
	let counts = Obj::new();
	counts.set("quests", out.len());
	for k in KINDS {
		let c = Obj::new();
		for s in ["trusted", "gap", "conflict", "stale"] {
			c.set(s, by_status.get(&(k, s)).copied().unwrap_or(0));
		}
		counts.set(k.as_str(), V::Obj(c));
	}
	counts.set("questsEveryLineTrusted", spot_quests_all_trusted);
	meta.set("counts", V::Obj(counts));
	let meta_text = format!("{}\n", stringify(&V::Obj(meta), Some("\t")));

	// conflicts.json: every fact that is not new or a confirmation.
	let mut conflicts: Vec<V> = Vec::new();
	let mut ordered: Vec<(&QuestOut, &Fact)> = out.iter().flat_map(|q| q.facts.iter().map(move |f| (q, f))).filter(|(_, f)| !matches!(f.class, Class::New | Class::Confirms)).collect();
	ordered.sort_by(|a, b| a.1.class.cmp(&b.1.class).then(a.0.id.cmp(&b.0.id)).then(a.1.kind.cmp(&b.1.kind)).then(a.1.line.cmp(&b.1.line)));
	for (q, f) in &ordered {
		let o = Obj::new();
		o.set("quest", q.id);
		o.set("title", title(data, q.id));
		o.set("zone", q.zone.map_or(V::Null, V::from));
		o.set("class", f.class.as_str());
		o.set("field", f.kind.as_str());
		if let Some(l) = f.line {
			o.set("line", l);
		}
		o.set("recorded", f.json());
		o.set("disagree", f.disagree);
		o.set("data", f.data.clone());
		o.set("correction", f.correction.clone());
		conflicts.push(V::Obj(o));
	}
	let conflicts_text = format!("{}\n", stringify(&V::from(conflicts), Some("\t")));

	// report.md
	let mut r = String::new();
	let _ = writeln!(r, "# What players' recordings teach: Forever-new quests\n");
	let _ = writeln!(r, "`forge record learn --scope forever-new` (docs/forge/learn.md). The snapshot is data/recorded/quests.json; this report and conflicts.json stay local.\n");
	let _ = writeln!(
		r,
		"Archive {}: {} session files, {} used ({} of excluded contributors, {} of older builds, {} unreadable left out); {} voters ({} counted; {} contributors merged into the same person). Newest build {}.",
		a.revision, a.files, a.sessions, a.excluded, a.older_build, a.unreadable, a.voters, a.counted, a.merged, a.newest_build
	);
	let _ = writeln!(r, "Verdicts {}: {} exclude, {} suspect (never counted).\n", verdicts.0.as_deref().unwrap_or("(none)"), verdicts.1, verdicts.2);
	if let Some(prev) = previous {
		let (old, new) = (flatten(prev), flatten(&quests_v));
		let added = new.keys().filter(|k| !old.contains_key(*k)).count();
		let gone = old.keys().filter(|k| !new.contains_key(*k)).count();
		let changed = new.iter().filter(|(k, v)| old.get(*k).is_some_and(|o| o != *v)).count();
		let _ = writeln!(r, "Since the last snapshot: {added} facts added, {changed} changed, {gone} gone.\n");
	} else {
		let _ = writeln!(r, "First snapshot.\n");
	}
	let _ = writeln!(r, "## Facts by class\n");
	let _ = writeln!(r, "| fact | {} |", CLASSES.iter().map(|c| c.as_str()).collect::<Vec<_>>().join(" | "));
	let _ = writeln!(r, "|---|{}", "---|".repeat(CLASSES.len()));
	for k in KINDS {
		let _ = writeln!(r, "| {} | {} |", k.as_str(), CLASSES.iter().map(|c| by_kind.get(&(k, *c)).copied().unwrap_or(0).to_string()).collect::<Vec<_>>().join(" | "));
	}
	let _ = writeln!(r, "\n| fact | trusted | gap (provisional) | conflict | stale |\n|---|---|---|---|---|");
	for k in KINDS {
		let g = |s: &str| by_status.get(&(k, s)).copied().unwrap_or(0);
		let _ = writeln!(r, "| {} | {} | {} | {} | {} |", k.as_str(), g("trusted"), g("gap"), g("conflict"), g("stale"));
	}
	let _ = writeln!(r, "\nQuests with every objective line located on trusted evidence: {spot_quests_all_trusted}.\n");
	let vs: Vec<&(&QuestOut, &Fact)> = ordered.iter().filter(|(_, f)| f.class == Class::VsCorrection).collect();
	let _ = writeln!(r, "## Recordings vs corrections (correction kept)\n");
	if vs.is_empty() {
		let _ = writeln!(r, "None.\n");
	}
	for (q, f) in &vs {
		let _ = writeln!(r, "- {} {}: {}", q.id, title(data, q.id), describe(f));
	}

	// Per zone.
	let mut zones: BTreeMap<String, (Option<i64>, Vec<&QuestOut>)> = BTreeMap::new();
	for q in out {
		zones.entry(zone_name(data, q.zone)).or_insert((q.zone, Vec::new())).1.push(q);
	}
	// Readiness: the zone's Forever-new quests in our data with every objective line trusted-located
	// and no prerequisite or level conflict.
	let mut in_zone: FxHashMap<Option<i64>, Vec<i64>> = FxHashMap::default();
	for (k, q) in data.quests.entries() {
		let Ok(id) = k.parse::<i64>() else { continue };
		if scope(id) {
			in_zone.entry(int(&q.get("zone")).filter(|z| *z > 0)).or_default().push(id);
		}
	}
	let ready = |q: &QuestOut| {
		!q.lines.is_empty()
			&& (1..=q.lines.len()).all(|l| q.facts.iter().any(|f| f.kind == Kind::Spot && f.line == Some(l) && f.status == Status::Trusted))
			&& !q.facts.iter().any(|f| f.kind != Kind::Spot && f.class == Class::Conflict)
	};
	let _ = writeln!(r, "\n## Per zone\n");
	let _ = writeln!(r, "Readiness: Forever-new quests of the zone (in our data) with every objective line located on trusted evidence and no prerequisite or level conflict.\n");
	let _ = writeln!(r, "| zone | Forever-new quests | with recorded facts | ready | {} |", CLASSES.iter().map(|c| c.as_str()).collect::<Vec<_>>().join(" | "));
	let _ = writeln!(r, "|---|---|---|---|{}", "---|".repeat(CLASSES.len()));
	for (name, (z, qs)) in &zones {
		let total = in_zone.get(z).map_or(0, Vec::len);
		let n_ready = qs.iter().filter(|q| ready(q)).count();
		let cls = CLASSES.iter().map(|c| qs.iter().flat_map(|q| &q.facts).filter(|f| f.class == *c).count().to_string()).collect::<Vec<_>>().join(" | ");
		let share = match (n_ready * 100).checked_div(total) {
			Some(p) => format!("{n_ready} ({p}%)"),
			None => n_ready.to_string(),
		};
		let _ = writeln!(r, "| {name} | {total} | {} | {share} | {cls} |", qs.len());
	}
	let _ = writeln!(r, "\n## The lines that matter, per zone\n");
	let _ = writeln!(
		r,
		"Every fact that is not a confirmation: new (applied when trusted, provisional when a gap), replaces, vs correction, conflict, stale, pending (disagrees with our data below the override quorum).\n"
	);
	for (name, (_, qs)) in &zones {
		let mut lines: Vec<String> = Vec::new();
		for q in qs {
			for f in q.facts.iter().filter(|f| f.class != Class::Confirms) {
				lines.push(format!("- [{}] {} {}: {}", f.class.as_str(), q.id, title(data, q.id), describe(f)));
			}
		}
		if lines.is_empty() {
			continue;
		}
		let _ = writeln!(r, "### {name}\n");
		for l in lines {
			let _ = writeln!(r, "{l}");
		}
		let _ = writeln!(r);
	}

	let g = |k: Kind, s: &str| by_status.get(&(k, s)).copied().unwrap_or(0);
	let c = |k: Kind, c: Class| by_kind.get(&(k, c)).copied().unwrap_or(0);
	let summary = vec![
		format!("learn: {} sessions used of {} ({} voters, {} counted); {} Forever-new quests with facts", a.sessions, a.files, a.voters, a.counted, out.len()),
		format!(
			"objective spots: {} lines trusted ({} quests every line), {} provisional, {} conflict, {} stale",
			g(Kind::Spot, "trusted"),
			spot_quests_all_trusted,
			g(Kind::Spot, "gap"),
			g(Kind::Spot, "conflict"),
			g(Kind::Spot, "stale")
		),
		format!(
			"prerequisites: {} confirm our data, {} new ({} trusted), {} conflict; {} of our data's contradicted",
			c(Kind::Pre, Class::Confirms),
			c(Kind::Pre, Class::New) + c(Kind::Pre, Class::Pending) + c(Kind::Pre, Class::Replaces),
			out.iter().flat_map(|q| &q.facts).filter(|f| f.kind == Kind::Pre && f.status == Status::Trusted && f.class != Class::Confirms).count(),
			c(Kind::Pre, Class::Conflict),
			by_status.iter().filter(|((k, _), _)| *k == Kind::NotPre).map(|(_, n)| n).sum::<usize>()
		),
		format!(
			"minimum level: {} confirm, {} pinned changes, {} lower than our data (not pinned), {} conflict",
			c(Kind::MinLevel, Class::Confirms),
			out.iter().flat_map(|q| &q.facts).filter(|f| f.kind == Kind::MinLevel && !f.value.is_nullish() && f.class != Class::Confirms).count(),
			out.iter()
				.flat_map(|q| &q.facts)
				.filter(|f| f.kind == Kind::MinLevel && f.value.is_nullish() && f.data.as_num().is_some_and(|d| f.bounds.as_ref().is_some_and(|b| b.at(1).num() < d)))
				.count(),
			c(Kind::MinLevel, Class::Conflict)
		),
		format!("vs corrections: {}; conflicts: {}", ordered.iter().filter(|(_, f)| f.class == Class::VsCorrection).count(), ordered.iter().filter(|(_, f)| f.class == Class::Conflict).count()),
	];
	Output { quests: quests_text, meta: meta_text, report: r, conflicts: conflicts_text, summary }
}

// ---------------------------------------------------------------- the command

/// The session files of an archive, in name order (config.json and dot files are not sessions).
pub(crate) fn session_files(dir: &Path) -> Result<Vec<String>, String> {
	let rd = std::fs::read_dir(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
	let mut files: Vec<String> = rd.flatten().map(|e| e.file_name().to_string_lossy().to_string()).filter(|f| f.ends_with(".json") && !f.starts_with('.') && f != "config.json").collect();
	files.sort_by(|a, b| cmp_utf16(a, b));
	Ok(files)
}

/// The Forever-new quests: [`crate::newquests`]'s (neither pfQuest's Classic database nor the
/// Classic Era client's quest table holds them), plus quest ids our data lacks that the Era client
/// does not list either.
pub fn forever_new(data: &Path, sources: &Path, offline: bool, log: &dyn Fn(&str)) -> Result<(BTreeSet<i64>, BTreeSet<i64>), String> {
	let file = data.join("quests.json");
	let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e} (run: forge data build)", file.display()))?;
	let quests: serde_json::Value = serde_json::from_str(&text).map_err(|e| format!("{}: {e}", file.display()))?;
	let (era, forever) = crate::newquests::client_ids(sources, offline, log)?;
	Ok((crate::newquests::new_quest_ids(&quests, &era, &forever), era))
}

pub fn run(o: &Options, log: &dyn Fn(&str)) -> Result<Output, String> {
	let cfg = read_config(&o.archive)?;
	let verdicts = match &o.verdicts {
		Some(f) => read_verdicts(f)?,
		None => Verdicts::default(),
	};
	let data = Data::load(&o.data, &o.corrections)?;
	let (new, era) = forever_new(&o.data, &o.sources, o.offline, log)?;
	log(&format!("{} quests new in Forever", new.len()));
	let in_data: FxHashSet<i64> = data.quests.keys().iter().filter_map(|k| k.parse().ok()).collect();
	let scope = |q: i64| new.contains(&q) || (!in_data.contains(&q) && !era.contains(&q));
	let files = session_files(&o.archive)?;
	let mut l = Learner::new(&cfg, &verdicts, &scope);
	for (i, f) in files.iter().enumerate() {
		let p = o.archive.join(f);
		let text = std::fs::read_to_string(&p).map_err(|e| format!("{}: {e}", p.display()))?;
		l.add(f, &text);
		if (i + 1) % 500 == 0 {
			log(&format!("{} / {} sessions read", i + 1, files.len()));
		}
	}
	let previous = match &o.previous {
		Some(p) if p.exists() => Some(parse_json(&std::fs::read_to_string(p).map_err(|e| format!("{}: {e}", p.display()))?).map_err(|e| format!("{}: {e}", p.display()))?),
		_ => None,
	};
	Ok(l.finish(&data, (verdicts.generated.clone(), verdicts.excluded, verdicts.suspect), previous.as_ref()))
}

// ---------------------------------------------------------------- consumers

/// The snapshot's file in data/recorded.
pub const FILE: &str = "quests.json";
/// The snapshot's folder in a checkout.
pub const DIR: &str = "data/recorded";

/// data/recorded/quests.json (an empty object when there is none).
pub fn load(file: &Path) -> Result<V, String> {
	match std::fs::read_to_string(file) {
		Ok(t) => parse_json(&t).map_err(|e| format!("{}: {e}", file.display())),
		Err(e) if e.kind() == std::io::ErrorKind::NotFound => Ok(V::obj()),
		Err(e) => Err(format!("{}: {e}", file.display())),
	}
}

/// Whether a consumer takes a fact: trusted, or (`provisional`: the Codex and the guides, never the
/// public database) a gap or stale one.
pub fn usable(f: &V, provisional: bool) -> bool {
	match f.get("status").as_str() {
		Some("trusted") => true,
		Some("gap" | "stale") => provisional,
		_ => false,
	}
}

/// Applies a quest's recorded prerequisites to its quests.json record `q`: confirmed ones join its
/// all-of list, contradicted ones leave it, a contradicted any-of group goes. Fields a correction sets
/// (`corrected`: the quest's correction `set`) are never touched. -> whether `q` changed.
pub fn apply_prereqs(q: &V, rec: &V, corrected: &V, provisional: bool) -> bool {
	if ["pre", "preAll", "preAny"].iter().any(|k| corrected.has(k)) {
		return false;
	}
	let d = qdata(q);
	let (mut all, mut any) = d.split();
	let before = (all.clone(), any.clone());
	for f in rec.get("pre").items().iter().filter(|f| usable(f, provisional)) {
		if let Some(p) = pos_int(&f.get("value")) {
			if !all.contains(&p) && !any.contains(&p) {
				all.push(p);
			}
		}
	}
	for f in rec.get("notPre").items().iter().filter(|f| usable(f, provisional)) {
		if let Some(p) = pos_int(&f.get("value")) {
			all.retain(|x| *x != p);
			any.retain(|x| *x != p);
		}
	}
	if usable(&rec.get("notPreAny"), provisional) {
		any.clear();
	}
	if (all.clone(), any.clone()) == before {
		return false;
	}
	let mut pre = all.clone();
	pre.extend(any.iter().filter(|p| !all.contains(p)));
	q.set("pre", int_list(&pre));
	q.set("preAll", int_list(&all));
	q.set("preAny", int_list(&any));
	true
}

/// The recorded minimum level a consumer takes (trusted and pinned only), unless a correction sets
/// it.
pub fn min_level(rec: &V, corrected: &V) -> Option<i64> {
	let f = rec.get("minLevel");
	if corrected.has("minLevel") || !usable(&f, false) {
		return None;
	}
	int(&f.get("value")).filter(|l| *l > 0)
}

/// A quest's recorded objective spots by our data's objective (index into `q`'s `objectives`): the
/// best-backed spot of each line a consumer takes -> (map, x, y, provisional). Lines map to our
/// data's objectives in order, only when the game's list the snapshot recorded (`list`) has as many
/// lines, each of a fitting type.
pub fn objective_spots(q: &V, rec: &V, provisional: bool) -> BTreeMap<usize, (i64, f64, f64, bool)> {
	let mut out = BTreeMap::new();
	let list = rec.get("list").items();
	let kinds: Vec<Option<&str>> = list.iter().map(V::as_str).collect();
	let n = q.get("objectives").len();
	if !lines_up(q, &kinds) {
		return out;
	}
	for l in rec.get("objectives").items() {
		let at = l.get("at");
		let (Some(line), true) = (pos_int(&l.get("line")), usable(&at, provisional)) else { continue };
		let s = at.get("value").at(0);
		if let (Some(map), true) = (pos_int(&s.get("map")), (line as usize) <= n) {
			out.insert(line as usize - 1, (map, s.get("x").num(), s.get("y").num(), at.get("status").as_str() != Some("trusted")));
		}
	}
	out
}

/// What the Codex reads of the learned layer: the snapshot and the corrections (whose fields it
/// never changes).
pub struct Snapshot {
	pub quests: V,
	pub corrections: V,
}

impl Default for Snapshot {
	fn default() -> Snapshot {
		Snapshot { quests: V::obj(), corrections: V::obj() }
	}
}

impl Snapshot {
	/// `<root>/data/recorded/quests.json` and `<root>`'s corrections (each empty when absent).
	pub fn load(root: &Path) -> Result<Snapshot, String> {
		let c = crate::corrections::locate(root);
		Ok(Snapshot { quests: load(&root.join(DIR).join(FILE))?, corrections: if c.exists() { crate::corrections::load(&c)? } else { V::obj() } })
	}
}

#[cfg(test)]
mod tests;
