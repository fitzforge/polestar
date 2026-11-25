//! Recorder overlay (port of tools/lib/data/recordings.js): data/recordings/*.json, live Forever
//! observations, applied over the merged tables.
//!
//! Trust (docs/RECORDING.md "Trust"): sessions from a build older than data/recordings/config.json's
//! `minBuild` are left out, and so is every session whose player does not count ([`establish`]).
//! Every value a recording writes goes through one rule ([`trusted`]): a value another source
//! already has is replaced (or confirmed) only on trusted evidence, that of at least `minVoters`
//! (config.json, default 3) distinct counted players or of the maintainer's own (`local`) or
//! vouched-for (`sent-*`) recordings; a value no source has is filled by any counted player. Where
//! players disagree, the value most of them recorded wins (vouched evidence first). New quests,
//! NPCs, objects, items, factions and zones are created only from `local` or `sent-*` recordings,
//! and names from a session whose locale is not enUS only fill a missing name. A player is a
//! [`Recording::voter`]: the server's cohort (contributors registered from one network share one),
//! else the contributor; it counts once per fact however many sessions, installs or tokens it has.
//! A number several players recorded (an objective's count, a drop chance, a quest's XP) is the
//! median of each player's own value, so one heavy player cannot pull it (a quest drop's chance
//! pools every player's drops and tries instead: a player stops at the objective's count,
//! [`QuestLoot`]). A quest field recordings set or confirmed on trusted evidence gets the source tag
//! `recorder:<field>` (the knowledge base's `recorder` tier, kb.rs), one a single counted player
//! filled `recorder-gap:<field>` (never published on its own); a record only recordings have
//! carries `recorder`. Schema 1 sessions count as `local` and enUS.

use std::collections::VecDeque;
use std::hash::Hash;
use std::path::Path;

use forge_guide::js::{cmp_utf16, parse_json, stringify, Obj, V};
use indexmap::{IndexMap, IndexSet};
use rustc_hash::{FxHashMap, FxHashSet};
use sha2::{Digest, Sha256};

use crate::jsv::{arr, hypot, nums, round2};
use crate::objectives::parse_progress_text;
use crate::spawns::{points_of, reduce_spawns, spawn_record, SpawnOptions, P};

pub struct Recording {
	pub file: String,
	pub rec: V,
	/// Whether the session's player counts ([`establish`]): a session that doesn't is left out.
	pub counts: bool,
}

/// The sessions of data/recordings and the quorum its config.json sets.
pub struct Recordings {
	pub list: Vec<Recording>,
	/// Distinct counted players whose evidence replaces another source's value (`minVoters`).
	pub min_voters: usize,
}

impl std::ops::Deref for Recordings {
	type Target = [Recording];
	fn deref(&self) -> &[Recording] {
		&self.list
	}
}

/// The contributor of the maintainer's own recordings (`forge record import`).
pub const LOCAL: &str = "local";
/// config.json's `minVoters` when it sets none.
pub const MIN_VOTERS: usize = 3;

fn valid_cohort(c: &str) -> bool {
	c.len() == 16 && c.bytes().all(|b| b.is_ascii_digit() || (b'a'..=b'f').contains(&b))
}

/// The player the quorum counts for a session of `contributor` whose header carries `cohort`.
fn voter_of(cohort: Option<&str>, contributor: &str) -> String {
	match cohort.filter(|c| valid_cohort(c)) {
		Some(c) => format!("cohort:{c}"),
		None => contributor.to_string(),
	}
}

fn contributor_of(rec: &V) -> String {
	rec.get("contributor").as_str().filter(|c| !c.is_empty()).unwrap_or(LOCAL).to_string()
}

impl Recording {
	/// Who recorded the session (`local` for schema 1 and the maintainer's own imports).
	pub fn contributor(&self) -> String {
		contributor_of(&self.rec)
	}

	/// The player the quorum counts: `cohort:<id>` for a pulled session whose header carries the
	/// server's cohort (16 hex digits; [`establish`] gives every session of a contributor the same
	/// one), else the contributor (`local`, `sent-*`, `anon-*`, and contributors pulled before the
	/// server exported cohorts).
	pub fn voter(&self) -> String {
		voter_of(self.rec.get("cohort").as_str(), &self.contributor())
	}

	/// Whether the session's names are English (schema 1 sessions carry no locale and are).
	pub fn english(&self) -> bool {
		self.rec.get("locale").as_str().is_none_or(|l| l == "enUS")
	}
}

/// Whether a player's evidence is the maintainer's own (`local`) or vouched for (`sent-*`).
pub fn vouched(voter: &str) -> bool {
	voter == LOCAL || voter.starts_with("sent-")
}

/// Whether evidence from these counted players may replace another source's value: at least
/// `min_voters` of them, or any vouched one.
pub fn trusted(voters: &IndexSet<String>, min_voters: usize) -> bool {
	voters.iter().any(|v| vouched(v)) || voters.len() >= min_voters
}

/// How established a server contributor must be to count (config.json's `minContributorDays`,
/// `minContributorChunks`, `minContributorUploadDays`, `minContributorPos`, `minContributorKills`).
/// The first three are what the server observed; the client's own session times count for nothing.
#[derive(Clone, Copy, Debug)]
pub struct Establish {
	/// Days from first seen to its newest session's arrival.
	pub min_days: f64,
	pub min_chunks: f64,
	/// Distinct UTC days the server received its chunks on (the export's `uploadDays`).
	pub min_upload_days: f64,
	/// `pos` and `kill` events over its sessions.
	pub min_pos: f64,
	pub min_kills: f64,
}

pub const ESTABLISH: Establish = Establish { min_days: 3.0, min_chunks: 20.0, min_upload_days: 3.0, min_pos: 10.0, min_kills: 5.0 };

/// What [`establish_heads`] reads of a session: its header and how many positions and kills it
/// recorded. `forge record learn` keeps only this of a session once its events are read.
#[derive(Clone, Debug, Default)]
pub struct Head {
	pub contributor: String,
	/// The server's cohort (16 hex digits), after [`establish_heads`] the contributor's one.
	pub cohort: Option<String>,
	pub received: Option<f64>,
	pub since: Option<f64>,
	pub chunks: Option<f64>,
	pub upload_days: Option<f64>,
	pub pos: f64,
	pub kills: f64,
}

impl Head {
	pub fn of(rec: &V) -> Head {
		let num = |k: &str| rec.get(k).as_num().filter(|n| n.is_finite() && *n > 0.0);
		let mut h = Head {
			contributor: contributor_of(rec),
			cohort: rec.get("cohort").as_str().filter(|c| valid_cohort(c)).map(str::to_string),
			received: num("received"),
			since: num("contributorSince"),
			chunks: num("contributorChunks"),
			upload_days: num("uploadDays"),
			pos: 0.0,
			kills: 0.0,
		};
		for ev in rec.get("events").items() {
			match ev.get("e").as_str() {
				Some("pos") => h.pos += 1.0,
				Some("kill") => h.kills += 1.0,
				_ => {}
			}
		}
		h
	}

	/// [`Recording::voter`] of the session.
	pub fn voter(&self) -> String {
		voter_of(self.cohort.as_deref(), &self.contributor)
	}
}

/// What a contributor's sessions say about it.
struct Play {
	since: f64,
	newest: f64,
	chunks: f64,
	upload_days: f64,
	pos: f64,
	kills: f64,
}

/// One cohort per contributor: the one its most recently received session carries, written into
/// every session of it, so a contributor whose sessions were pulled before and after a cohort
/// change (or before cohorts existed) is one player.
fn resolve_cohorts(heads: &mut [Head]) {
	let mut best: FxHashMap<String, (f64, String)> = FxHashMap::default();
	for h in heads.iter() {
		let Some(c) = h.cohort.clone() else { continue };
		let at = h.received.unwrap_or(f64::NEG_INFINITY);
		let e = best.entry(h.contributor.clone()).or_insert((f64::NEG_INFINITY, c.clone()));
		if at >= e.0 {
			*e = (at, c);
		}
	}
	for h in heads.iter_mut() {
		if let Some((_, c)) = best.get(&h.contributor) {
			h.cohort = Some(c.clone());
		}
	}
}

/// Marks the sessions whose player counts. A contributor is established when it is `local` or
/// `sent-*` (a file the maintainer vouched for); `anon-*` (a sent-in file nobody vouched for) never
/// is; a server contributor is once the server has seen enough of it, by what forge record pull
/// wrote in its sessions' headers: first seen (`contributorSince`, the earliest any of its sessions
/// says) at least `min_days` days before its newest session arrived (`received`), at least
/// `min_chunks` chunks sent (`contributorChunks`, the most any says) on at least `min_upload_days`
/// distinct UTC days (`uploadDays`, the most any says), and at least `min_pos` positions and
/// `min_kills` kills recorded. Each contributor's sessions first get one cohort
/// ([`resolve_cohorts`]); a player ([`Recording::voter`]) counts when any of its contributors is
/// established, and every session of it is marked alike.
pub fn establish(recs: &mut [Recording], e: Establish) {
	let mut heads: Vec<Head> = recs.iter().map(|r| Head::of(&r.rec)).collect();
	let counts = establish_heads(&mut heads, e);
	for ((r, h), c) in recs.iter_mut().zip(&heads).zip(counts) {
		if let Some(cohort) = &h.cohort {
			r.rec.set("cohort", cohort.as_str());
		}
		r.counts = c;
	}
}

/// [`establish`] over sessions' headers: resolves each contributor's cohort in place and says, per
/// session, whether its player counts.
pub fn establish_heads(heads: &mut [Head], e: Establish) -> Vec<bool> {
	resolve_cohorts(heads);
	let mut by: FxHashMap<&str, Play> = FxHashMap::default();
	for h in heads.iter() {
		let s = by.entry(&h.contributor).or_insert_with(|| Play { since: f64::INFINITY, newest: f64::NEG_INFINITY, chunks: 0.0, upload_days: 0.0, pos: 0.0, kills: 0.0 });
		if let Some(x) = h.since {
			s.since = s.since.min(x);
		}
		if let Some(x) = h.received {
			s.newest = s.newest.max(x);
		}
		if let Some(x) = h.chunks {
			s.chunks = s.chunks.max(x);
		}
		if let Some(x) = h.upload_days {
			s.upload_days = s.upload_days.max(x);
		}
		s.pos += h.pos;
		s.kills += h.kills;
	}
	let established = |c: &str| {
		vouched(c)
			|| (!c.starts_with("anon-")
				&& by
					.get(c)
					.is_some_and(|p| p.newest - p.since >= e.min_days * 86400.0 && p.chunks >= e.min_chunks && p.upload_days >= e.min_upload_days && p.pos >= e.min_pos && p.kills >= e.min_kills))
	};
	let mut voters: FxHashMap<String, bool> = FxHashMap::default();
	for h in heads.iter() {
		let ok = established(&h.contributor);
		*voters.entry(h.voter()).or_default() |= ok;
	}
	heads.iter().map(|h| voters[&h.voter()]).collect()
}

/// What a recordings folder's config.json sets.
pub struct Config {
	/// Contributors that never count (`exclude`: the maintainer's audit).
	pub exclude: FxHashSet<String>,
	/// Sessions of older builds are left out (`minBuild`).
	pub min_build: Option<f64>,
	pub establish: Establish,
	/// `minVoters`.
	pub min_voters: usize,
}

/// `dir`'s config.json (the defaults when it has none).
pub fn read_config(dir: &Path) -> Result<Config, String> {
	let text = match std::fs::read_to_string(dir.join("config.json")) {
		Ok(t) => t,
		Err(_) => return Ok(Config { exclude: FxHashSet::default(), min_build: None, establish: ESTABLISH, min_voters: MIN_VOTERS }),
	};
	let c = parse_json(&text).map_err(|e| format!("recordings config.json: {e}"))?;
	let at_least_0 = |k: &str, d: f64| c.get(k).as_num().filter(|n| n.is_finite() && *n >= 0.0).unwrap_or(d);
	let d = ESTABLISH;
	Ok(Config {
		exclude: c.get("exclude").items().iter().filter_map(|x| x.as_str().map(str::to_string)).collect(),
		min_build: c.get("minBuild").as_num().filter(|n| n.is_finite()),
		establish: Establish {
			min_days: at_least_0("minContributorDays", d.min_days),
			min_chunks: at_least_0("minContributorChunks", d.min_chunks),
			min_upload_days: at_least_0("minContributorUploadDays", d.min_upload_days),
			min_pos: at_least_0("minContributorPos", d.min_pos),
			min_kills: at_least_0("minContributorKills", d.min_kills),
		},
		min_voters: c.get("minVoters").as_num().filter(|n| n.is_finite() && *n >= 1.0).map_or(MIN_VOTERS, |n| n as usize),
	})
}

/// The session files of a recordings folder (schema 1 or 2; `config.json` and dot files are not
/// sessions), in file order; None when there is no such folder.
fn session_names(dir: &Path) -> Option<Vec<String>> {
	let rd = std::fs::read_dir(dir).ok()?;
	let mut files: Vec<String> = rd.flatten().map(|e| e.file_name().to_string_lossy().to_string()).filter(|f| f.ends_with(".json") && !f.starts_with('.') && f != "config.json").collect();
	files.sort_by(|a, b| cmp_utf16(a, b));
	Some(files)
}

fn load_session(dir: &Path, file: &str) -> Result<V, String> {
	let text = std::fs::read_to_string(dir.join(file)).map_err(|e| format!("recording {file}: {e}"))?;
	let rec = parse_json(&text).map_err(|e| format!("recording {file}: {e}"))?;
	if !matches!(rec.get("schema").as_num(), Some(1.0) | Some(2.0)) || !rec.get("events").is_arr() {
		return Err(format!("recording {file}: expected {{ schema: 1 or 2, events: [...] }}"));
	}
	Ok(rec)
}

/// One session of a [`SessionFiles`]: whether its player counts, and the cohort [`establish`]
/// gave its contributor.
struct SessionFile {
	file: String,
	counts: bool,
	cohort: Option<String>,
}

/// A recordings folder read one session at a time. [`scan_recordings`] reads every session once
/// for its header (who counts); [`SessionFiles::sessions`] reads them again one by one, each as
/// [`read_recordings`] holds it. The release data build reads the maintainer's whole recordings
/// archive this way: gigabytes of sessions, too many to hold at once.
pub struct SessionFiles {
	dir: std::path::PathBuf,
	files: Vec<SessionFile>,
	/// Distinct counted players whose evidence replaces another source's value (`minVoters`).
	pub min_voters: usize,
}

impl SessionFiles {
	/// The sessions, less those of builds older than `minBuild`.
	pub fn len(&self) -> usize {
		self.files.len()
	}

	pub fn is_empty(&self) -> bool {
		self.files.is_empty()
	}

	/// The sessions whose player counts.
	pub fn counted(&self) -> usize {
		self.files.iter().filter(|f| f.counts).count()
	}

	pub fn names(&self) -> impl Iterator<Item = &str> {
		self.files.iter().map(|f| f.file.as_str())
	}

	/// Every session in file order, read from disk as it is reached.
	pub fn sessions(&self) -> impl Iterator<Item = Result<Recording, String>> + '_ {
		self.files.iter().map(|f| {
			let rec = load_session(&self.dir, &f.file)?;
			if let Some(c) = &f.cohort {
				rec.set("cohort", c.as_str());
			}
			Ok(Recording { file: f.file.clone(), rec, counts: f.counts })
		})
	}
}

/// [`read_recordings`]'s reading of `dir`, keeping of each session only whether it counts.
pub fn scan_recordings(dir: &Path) -> Result<SessionFiles, String> {
	let Some(names) = session_names(dir) else { return Ok(SessionFiles { dir: dir.to_path_buf(), files: Vec::new(), min_voters: MIN_VOTERS }) };
	let Config { exclude, min_build, establish: est, min_voters } = read_config(dir)?;
	// Each session file, and whether its contributor may count (`exclude` never does, and plays no
	// part in establishing anyone); the headers of those that may, in the same order.
	let mut kept: Vec<(String, bool)> = Vec::new();
	let mut heads: Vec<Head> = Vec::new();
	for file in names {
		let rec = load_session(dir, &file)?;
		if let (Some(min), Some(build)) = (min_build, rec.get("build").as_num()) {
			if build < min {
				continue;
			}
		}
		let may = !exclude.contains(&contributor_of(&rec));
		if may {
			heads.push(Head::of(&rec));
		}
		kept.push((file, may));
	}
	let counts = establish_heads(&mut heads, est);
	let mut counted = heads.into_iter().zip(counts);
	let mut files = Vec::with_capacity(kept.len());
	for (file, may) in kept {
		let (counts, cohort) = if may {
			let (h, c) = counted.next().expect("one header per session that may count");
			(c, h.cohort)
		} else {
			(false, None)
		};
		files.push(SessionFile { file, counts, cohort });
	}
	Ok(SessionFiles { dir: dir.to_path_buf(), files, min_voters })
}

/// data/recordings/*.json (schema 1 or 2; `config.json` and dot files are not sessions), less the
/// sessions of builds older than `config.json`'s `minBuild`, each marked by [`establish`]. The
/// contributors `config.json`'s `exclude` lists (the maintainer's audit: manipulated or suspect
/// uploads) never count, and play no part in establishing anyone (their cohort-mates count only on
/// their own record).
pub fn read_recordings(dir: &Path) -> Result<Recordings, String> {
	let s = scan_recordings(dir)?;
	Ok(Recordings { list: s.sessions().collect::<Result<_, _>>()?, min_voters: s.min_voters })
}

/// meta.json's revision of the recordings: sha256 over file names and contents, 16 hex digits.
#[derive(Default)]
pub struct Revision(Sha256);

impl Revision {
	pub fn add(&mut self, r: &Recording) {
		self.0.update(r.file.as_bytes());
		self.0.update(b"\0");
		self.0.update(stringify(&r.rec, None).as_bytes());
		self.0.update(b"\0");
	}

	pub fn finish(self) -> String {
		self.0.finalize().iter().map(|b| format!("{b:02x}")).collect::<String>()[..16].to_string()
	}
}

pub fn revision(recs: &[Recording]) -> String {
	let mut h = Revision::default();
	for r in recs {
		h.add(r);
	}
	h.finish()
}

pub(crate) fn pos_int(v: &V) -> Option<i64> {
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

/// Adds `tag` to a record's `source` (made a list when it is none).
fn add_source(rec: &V, tag: &str) {
	if !rec.get("source").is_arr() {
		rec.set("source", V::arr());
	}
	let src = rec.get("source");
	if !has_str(&src, tag) {
		src.push(tag);
	}
}

/// Tags a field recordings set or confirmed: `recorder:<field>` on trusted evidence (implied by a
/// record only recordings have, `recorder`), else `recorder-gap:<field>`.
pub(crate) fn tag_field(rec: &V, field: &str, trusted: bool) {
	if trusted && has_str(&rec.get("source"), "recorder") {
		return;
	}
	add_source(rec, &format!("{}:{field}", if trusted { "recorder" } else { "recorder-gap" }));
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
/// Loot windows of a source a player needs before their share counts toward a trusted drop chance.
pub(crate) const MIN_WINDOWS: f64 = 10.0;
const ENTRANCE_RADIUS: f64 = 1.5;
/// Map percent within which a rare's sightings are one place (#2816). A sighting is where the player
/// stood when the rare's nameplate showed or the cursor or target met it: 30 yd from it at the median,
/// 100 yd at the 90th percentile (2,434 sightings of 26 rares and leaders that stand still, against
/// the Forever TDB's spawn). 2.5% is 60-130 yd across most zone maps (250 on The Barrens', 35 on a
/// capital's).
const SIGHT_RADIUS: f64 = 2.5;
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
	/// The client's gathering spells, (spell, "herb" | "mine") by spell ([`crate::extras::gathering_spells`]):
	/// a loot window right after one is a gather even when the Recorder did not know the spell.
	pub gather_spells: &'a [(i64, &'static str)],
	/// The client's quest items, ascending ([`crate::extras::quest_items`]): a loot window of these only is
	/// no chest's.
	pub quest_items: &'a [i64],
}

/// Which recorded drop chances replace or fill the sources' ([`apply_recordings`]).
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum DropChances {
	/// None: the sources' chances stand.
	Off,
	/// A quest drop's only: counted on the kills while it was wanted ([`QuestLoot`], #2747); any
	/// other drop's still counts loot windows, which read high, so its sources' stands.
	QuestDrops,
	/// The same, written by the caller ([`RecordedDrops::apply`], in [`Stats::recorded_drops`]) once
	/// every source's chance is in (the data build: after the knowledge base's Forever TDB rates).
	QuestDropsLater,
	/// Every drop's.
	All,
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
	/// Quests whose objectives the game's own list restructured ([`game_objectives`]).
	pub game_objective_quests: usize,
	/// Objectives that became `talk`, and objectives the game does not count that were dropped.
	pub talk_objectives: usize,
	pub dropped_objectives: usize,
	/// Quests whose recorded lists disagree: the data's objectives are kept.
	pub objective_conflicts: Vec<i64>,
	/// Corrected values the recordings disagreed with (`"<section> <id>: <field>"`): the
	/// corrections were kept.
	pub overruled: Vec<String>,
	/// Per quest, the NPCs counted players handed it in to (a `turnin` in that NPC's window).
	pub npc_hand_ins: FxHashMap<i64, FxHashSet<i64>>,
	/// The recorded drop chances ([`RecordedDrops`]), written unless [`DropChances::QuestDropsLater`].
	pub recorded_drops: RecordedDrops,
}

/// The drop chances the recordings give ([`apply_recordings`]): (kind, source, item, chance).
#[derive(Default)]
pub struct RecordedDrops(Vec<(usize, i64, i64, DropChance)>);

impl RecordedDrops {
	/// Writes them into `items`: a trusted chance replaces the sources', any other only fills a gap
	/// (with `seen`, the loot and kills behind it). Then an item's chances go on one scale: where players
	/// measured some of its sources, the sources' figures for its others are off by the same factor (the
	/// median of the measured ones' recorded chance over the sources' figure), since the guide picks the
	/// likely droppers by comparing them. The Enchanted Gyrozephyr: the Forever TDB puts it at 100% in
	/// both kinds of Construct Parts; players found it in 30.3% of the 616466 ones, so the other kind,
	/// which nobody looted, reads 30.3% beside them, not the 100% that sent the arrow there alone
	/// (#285). The figures must all be in first: the data build writes these after its knowledge base
	/// has added the TDB's. `removed(item, kind, source)`: a dropper a correction takes away, which no
	/// recorded chance brings back (corrections are the last word). -> the chances written.
	pub fn apply(&self, items: &Obj, removed: &dyn Fn(i64, &str, i64) -> bool) -> usize {
		let mut written = 0;
		// Per item: the recorded chance over the sources' at each source a trusted one replaced, and
		// every source a recorded chance was written for.
		let mut scale: IndexMap<i64, (Vec<f64>, FxHashSet<(usize, i64)>)> = IndexMap::new();
		for (k, id, item, dc) in &self.0 {
			let (k, id) = (*k, *id);
			let kind = ["npc", "object"][k];
			let it = items.get(&item.to_string());
			if !it.truthy() || removed(*item, kind, id) {
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
			if !cur.is_nullish() && !dc.trusted {
				continue;
			}
			let (ratios, measured) = scale.entry(*item).or_default();
			measured.insert((k, id));
			if let Some(was) = cur.as_num().filter(|c| *c > 0.0 && dc.trusted) {
				ratios.push(dc.chance / was);
			}
			it.get("drops").get(kind).set(&id.to_string(), dc.chance);
			written += 1;
			if !it.get("seen").truthy() {
				it.set("seen", Obj::new());
			}
			if !it.get("seen").get(kind).truthy() {
				it.get("seen").set(kind, Obj::new());
			}
			// The loot and kills behind the chance.
			let s = Obj::new();
			s.set("n", dc.n);
			s.set("of", dc.of);
			it.get("seen").get(kind).set(&id.to_string(), s);
			tag_field(&it, "drops", dc.trusted);
		}
		for (item, (ratios, measured)) in scale {
			if ratios.is_empty() {
				continue;
			}
			let f = median(ratios);
			let drops = items.get(&item.to_string()).get("drops");
			for kind in ["npc", "object"] {
				let k = k_ix(kind);
				for (id, v) in drops.get(kind).entries() {
					let (Some(c), Ok(n)) = (v.as_num().filter(|c| *c > 0.0), id.parse::<i64>()) else { continue };
					if !measured.contains(&(k, n)) {
						drops.get(kind).set(&id, round2((c * f).min(100.0)));
					}
				}
			}
		}
		written
	}
}

type ByMap = IndexMap<i64, Vec<P>>;
/// Players behind each value: value -> players.
type Backers<K> = IndexMap<K, IndexSet<String>>;

/// The players behind each value recorded for one field, in the order first recorded.
#[derive(Default)]
pub(crate) struct Ballot(IndexMap<String, (V, IndexSet<String>)>);

/// How strongly a set of players backs a value: vouched evidence first, then the number of players.
fn weight(w: &IndexSet<String>) -> (bool, usize) {
	(w.iter().any(|v| vouched(v)), w.len())
}

impl Ballot {
	pub(crate) fn vote(&mut self, v: V, who: &str) {
		let e = self.0.entry(stringify(&v, None)).or_insert_with(|| (v, IndexSet::new()));
		e.1.insert(who.to_string());
	}

	/// The value the most players back (ties: the first recorded), with its players.
	pub(crate) fn best(&self) -> Option<(&V, &IndexSet<String>)> {
		let mut best: Option<(&V, &IndexSet<String>)> = None;
		for (v, w) in self.0.values() {
			if best.is_none_or(|(_, b)| weight(w) > weight(b)) {
				best = Some((v, w));
			}
		}
		best
	}

	/// The value to write over `cur` (`present`: another source has one) and whether it is
	/// trusted: the best value fills a gap, and replaces or confirms a present one only on
	/// trusted evidence.
	pub(crate) fn decide(&self, present: bool, min: usize) -> Option<(V, bool)> {
		let (v, who) = self.best()?;
		let t = trusted(who, min);
		(!present || t).then(|| (v.clone(), t))
	}
}

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

/// One recorded objective: its players, and what each recorded.
#[derive(Default)]
struct Slot {
	who: IndexSet<String>,
	name: Ballot,
	kind: Ballot,
	id: Ballot,
	/// Each player's count (the highest it saw).
	max: IndexMap<String, f64>,
	/// Some player's line read "<creature> slain" (a creature's kill line, not a hidden credit).
	slain: bool,
}

/// What players recorded of one quest.
#[derive(Default)]
struct QuestVotes {
	/// [English, other locales].
	title: [Ballot; 2],
	level: Ballot,
	zone: Ballot,
	/// (start|end, npc|object|item) -> id -> players.
	givers: IndexMap<(&'static str, &'static str), Backers<i64>>,
	/// Each player's rewards: (weight, rewards); a turn-in (2) wins over an accept (1).
	rewards: IndexMap<String, (u8, V)>,
}

/// What players' game clients showed of one quest's objectives, its own list ([`game_objectives`]).
#[derive(Default)]
struct ClientList {
	/// Each player's lines at the accept (`objectives`), in the game's order: (type, required).
	listed: IndexMap<String, IndexSet<Vec<(String, i64)>>>,
	/// Each player's number of lines once the quest was complete: those at the accept and every
	/// line the game revealed later (a `progress` of a higher line).
	lines: IndexMap<String, IndexSet<usize>>,
	/// Line number -> what ticked it.
	ticks: IndexMap<i64, Ticks>,
}

/// What ticked one line: kill credits on it (id -> players); the NPCs players talked to where it
/// ticked, around then, or stood by (a friendly NPC whose spawn is where it ticked: some talks count
/// as the player walks up); those whose training or vendor window opened then (a talk to them is
/// training or buying, in any player's session); and players who cast a spell right before. (Loot
/// windows name every item objective open at the time, so they say nothing of one line.)
#[derive(Default)]
struct Ticks {
	kills: Backers<i64>,
	talks: Backers<i64>,
	stood: Backers<i64>,
	services: Backers<i64>,
	casts: IndexSet<String>,
}

impl Ticks {
	/// The players who talked to `id` as the line ticked, none when anyone trained or bought from
	/// it then.
	fn talked(&self, id: i64) -> Option<&IndexSet<String>> {
		self.talks.get(&id).filter(|_| !self.services.contains_key(&id))
	}
}

/// One session's view of a quest since its `objectives` record: its lines at the accept, the
/// highest line it saw tick, and the lines that ticked.
struct Open {
	listed: usize,
	top: i64,
	ticked: FxHashSet<i64>,
}

/// One session's state for [`Overlay::client_event`]: its quests since their `objectives` record,
/// what the player did in the last [`TALK_WINDOW`] seconds, the lines that ticked in the last
/// [`TALK_AFTER`] seconds (time, quest, line, place) and the player's last known place; and the
/// last gathering cast not yet matched to a loot window (time, "herb" | "mine").
#[derive(Default)]
struct Session {
	open: FxHashMap<i64, Open>,
	recent: VecDeque<(f64, Seen)>,
	ticks: VecDeque<(f64, i64, i64, Option<At>)>,
	at: Option<At>,
	gathering: Option<(f64, &'static str)>,
}

/// Seconds between a gathering cast and its loot window (the Recorder's own GATHER_WINDOW).
const GATHER_WINDOW: f64 = 3.0;

impl Session {
	/// A `cast` of one of the client's gathering spells (`spells`, [`Db::gather_spells`]).
	fn cast(&mut self, ev: &V, spells: &[(i64, &'static str)]) {
		let (Some(spell), Some(t)) = (pos_int(&ev.get("spell")), ev.get("t").as_num()) else { return };
		if let Ok(i) = spells.binary_search_by_key(&spell, |s| s.0) {
			self.gathering = Some((t, spells[i].1));
		}
	}

	/// The gather an object's `drop` with no `gather` of its own was: a gathering cast at most
	/// [`GATHER_WINDOW`] seconds before it. The Recorder names a gather only for the casts it knows
	/// (Classic's Herb Gathering and Mining ranks), so Forever's own (Cultivation, 1312650, on its herb
	/// nodes) reach us as a cast and then a plain loot window. One cast opens one loot window.
	fn gathered(&mut self, ev: &V) -> Option<&'static str> {
		if ev.get("e").as_str() != Some("drop") || ev.get("gather").truthy() || pos_int(&ev.get("object")).is_none() {
			return None;
		}
		let (at, kind) = self.gathering.take()?;
		let t = ev.get("t").as_num()?;
		(t >= at && t - at <= GATHER_WINDOW).then_some(kind)
	}
}

/// A place: (map, x, y).
type At = (i64, f64, f64);

/// Something a player did around a line's tick: a conversation, a training or vendor window, or
/// work of its own (a spell cast, a craft, a skill up, a kill, a loot).
#[derive(Clone, Copy)]
enum Seen {
	Talk(i64, Option<At>),
	Service(i64),
	Work,
}

/// A conversation with an NPC counts for a line that ticks up to [`TALK_WINDOW`] seconds later (a
/// "listen to" line ticks after the NPC's speech) with no work of the player's own in between, or
/// [`TALK_AFTER`] seconds earlier (the quest log can update before the window opens), where it
/// ticked ([`TALK_RADIUS`], map percent); work up to [`CAST_WINDOW`] seconds before it ticked
/// is what ticked it.
const TALK_WINDOW: f64 = 30.0;
const TALK_AFTER: f64 = 3.0;
const TALK_RADIUS: f64 = 1.0;
const CAST_WINDOW: f64 = 5.0;

fn near(a: Option<At>, b: Option<At>) -> bool {
	matches!((a, b), (Some(a), Some(b)) if a.0 == b.0 && hypot(a.1 - b.1, a.2 - b.2) <= TALK_RADIUS)
}

fn at_of(ev: &V) -> Option<At> {
	coord(ev).map(|c| (c.map, c.x, c.y))
}

const NPC: usize = 0;
const OBJECT: usize = 1;
const ITEM: usize = 2;
const FACTION: usize = 3;

struct Overlay<'a> {
	db: &'a Db<'a>,
	so: SpawnOptions,
	/// Recorded drop chances on ([`apply_recordings`]).
	drop_chances: DropChances,
	live_maps: &'a dyn Fn(i64) -> bool,
	min: usize,
	stats: Stats,
	touched: IndexSet<i64>,
	touched_entities: IndexMap<String, (&'static str, i64)>,
	quests: IndexMap<i64, QuestVotes>,
	objectives: IndexMap<i64, IndexMap<i64, Slot>>,
	/// quest -> what players' clients listed of its objectives and what ticked each line.
	clients: IndexMap<i64, ClientList>,
	/// NPCs players opened a gossip or quest window with.
	talked_to: FxHashSet<i64>,
	/// (NPC/OBJECT/ITEM/FACTION, id) -> [English, other locales] names.
	names: IndexMap<(usize, i64), [Ballot; 2]>,
	live: [IndexMap<i64, ByMap>; 2],
	/// quest -> (kind, xp, player level, contributor index) observations.
	xp_seen: IndexMap<i64, Vec<(&'static str, i64, Option<i64>, usize)>>,
	/// Factions seen -> their players.
	factions_seen: IndexMap<i64, IndexSet<String>>,
	faction_parent: IndexMap<i64, Ballot>,
	faction_side: IndexMap<i64, Ballot>,
	// finds, counted per player index (`ci`; one player's numbers never pool with another's)
	/// source -> player index -> its loot windows (a drop chance's samples, [`drop_chance`]).
	windows: [FxHashMap<i64, IndexMap<usize, f64>>; 2],
	quest_loot: QuestLoot,
	/// source -> item -> player index -> loot windows holding the item.
	loots: [IndexMap<i64, IndexMap<i64, IndexMap<usize, f64>>>; 2],
	found: [IndexMap<i64, ByMap>; 2],
	killed: IndexMap<i64, ByMap>,
	rank: IndexMap<i64, Ballot>,
	/// npc -> (lowest, highest level, players).
	levels: IndexMap<i64, (i64, i64, IndexSet<String>)>,
	roles: [IndexMap<i64, Backers<String>>; 2],
	inside: [IndexMap<i64, Backers<i64>>; 2],
	encounter_of: IndexMap<i64, Ballot>,
	entrances: IndexMap<i64, ByMap>,
	inst: IndexMap<i64, Inst>,
	// the current session's player, its index, whether it is vouched for and whether its names
	// are English
	voter: String,
	ci: usize,
	vouched: bool,
	english: bool,
	/// Every player seen (index -> voter).
	contributors: IndexSet<String>,
	/// (WHO_LIVE/WHO_FOUND + table index, id, map) -> players of the points.
	who: FxHashMap<(usize, i64, i64), IndexSet<String>>,
	/// (table index, id, map) the overlay gave spawns where there were none.
	filled: FxHashSet<(usize, i64, i64)>,
}

const WHO_LIVE: usize = 0;
const WHO_FOUND: usize = 2;

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

/// The lower median: a value one of them recorded.
fn lower_median(mut v: Vec<f64>) -> Option<f64> {
	v.sort_by(f64::total_cmp);
	v.get(v.len().saturating_sub(1) / 2).copied()
}

impl<'a> Overlay<'a> {
	fn lang(&self) -> usize {
		usize::from(!self.english)
	}

	/// The quest's votes; a quest no source has is created only from vouched evidence.
	fn quest(&mut self, id: i64) -> Option<&mut QuestVotes> {
		let k = id.to_string();
		if !self.db.quests.has(&k) {
			if !self.vouched {
				return None;
			}
			self.db.quests.set(&k, new_quest(id));
			self.stats.recorder_only_quests += 1;
		}
		self.touched.insert(id);
		Some(self.quests.entry(id).or_default())
	}

	fn name_vote(&mut self, table: usize, id: i64, name: &V) {
		let Some(n) = name.as_str().map(str::trim).filter(|n| !n.is_empty()) else { return };
		let (lang, who) = (self.lang(), self.voter.clone());
		self.names.entry((table, id)).or_default()[lang].vote(V::str(n), &who);
	}

	/// The npc or object, when it exists (one no source has is created only from vouched
	/// evidence), with the session's vote for its name.
	fn entity(&mut self, kind: &'static str, id: i64, name: &V) -> bool {
		let t = table_of(self.db, kind);
		let k = id.to_string();
		if !t.has(&k) {
			if !self.vouched {
				return false;
			}
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
		self.name_vote(if kind == "npc" { NPC } else { OBJECT }, id, name);
		self.touched_entities.insert(format!("{kind}:{id}"), (kind, id));
		true
	}

	fn item_entry(&mut self, id: i64, name: &V) -> bool {
		let k = id.to_string();
		if !self.db.items.has(&k) {
			if !self.vouched {
				return false;
			}
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
		self.name_vote(ITEM, id, name);
		true
	}

	fn live_point(&mut self, kind: &'static str, id: i64, name: &V, ev: &V) -> bool {
		if !self.entity(kind, id, name) {
			return false;
		}
		if let Some(c) = coord(ev) {
			push_point(&mut self.live[k_ix(kind)], id, &c);
			self.note(WHO_LIVE + k_ix(kind), id, c.map);
		}
		true
	}

	/// The current session's player backs the points of (`slot`, `id`, `map`).
	fn note(&mut self, slot: usize, id: i64, map: i64) {
		let who = self.who.entry((slot, id, map)).or_default();
		if !who.contains(&self.voter) {
			who.insert(self.voter.clone());
		}
	}

	fn trusted_at(&self, slot: usize, id: i64, map: i64) -> bool {
		self.who.get(&(slot, id, map)).is_some_and(|w| trusted(w, self.min))
	}

	fn role(&mut self, k: usize, id: i64, role: &str) {
		self.roles[k].entry(id).or_default().entry(role.to_string()).or_default().insert(self.voter.clone());
	}

	/// A looted item a player keeps outside a quest: no open objective wanted it (`q`), and it is not of the
	/// client's Quest class.
	fn keepable(&self, i: &V) -> bool {
		!i.get("q").truthy() && !pos_int(&i.get("item")).is_some_and(|item| self.db.quest_items.binary_search(&item).is_ok())
	}

	fn xp_obs(&mut self, qid: i64, kind: &'static str, value: &V, lvl: &V) {
		let Some(xp) = pos_int(value) else { return };
		self.xp_seen.entry(qid).or_default().push((kind, xp, pos_int(lvl), self.ci));
	}

	fn slot(&mut self, q: i64, oi: i64) -> &mut Slot {
		let who = self.voter.clone();
		let s = self.objectives.entry(q).or_default().entry(oi).or_default();
		s.who.insert(who);
		s
	}

	/// Collects what the session's client showed of a quest's objectives ([`ClientList`]): its
	/// `objectives` record at the accept, every line that ticked (a `progress`, or the `complete`
	/// for lines that never counted up) with the talks and casts around it, and the kill and loot
	/// credits on each line. `s`: the session so far.
	fn client_event(&mut self, e: &str, qid: Option<i64>, npc: Option<i64>, ev: &V, s: &mut Session) {
		let t = ev.get("t").as_num().unwrap_or(f64::NAN);
		while s.recent.front().is_some_and(|&(at, _)| !(t - at <= TALK_WINDOW)) {
			s.recent.pop_front();
		}
		while s.ticks.front().is_some_and(|&(at, ..)| !(t - at <= TALK_AFTER)) {
			s.ticks.pop_front();
		}
		let here = at_of(ev);
		if here.is_some() {
			s.at = here;
		}
		let known = qid.is_some_and(|q| self.db.quests.has(&q.to_string()));
		if matches!(e, "cast" | "craft" | "skill" | "learn" | "kill" | "loot") {
			s.recent.push_back((t, Seen::Work));
		}
		match (e, qid) {
			("gossip" | "offer", _) => {
				if let Some(n) = npc {
					s.recent.push_back((t, Seen::Talk(n, here)));
					self.talked_to.insert(n);
					// A line that ticked a moment before the window opened, where it opened.
					let who = self.voter.clone();
					for &(_, q, oi, at) in &s.ticks {
						if near(here, at) {
							self.clients.entry(q).or_default().ticks.entry(oi).or_default().talks.entry(n).or_default().insert(who.clone());
						}
					}
				}
			}
			("trainer" | "vendor", _) => {
				if let Some(n) = npc {
					s.recent.push_back((t, Seen::Service(n)));
				}
			}
			("objectives", Some(q)) if known => {
				let listed: Vec<(String, i64)> = ev
					.get("objectives")
					.items()
					.iter()
					.map(|o| (o.get("type").as_str().unwrap_or("log").to_string(), o.get("max").as_num().filter(|m| m.is_finite()).map_or(0, |m| m as i64)))
					.collect();
				s.open.insert(q, Open { listed: listed.len(), top: 0, ticked: FxHashSet::default() });
				let who = self.voter.clone();
				self.clients.entry(q).or_default().listed.entry(who).or_default().insert(listed);
			}
			("progress", Some(q)) => {
				if let (Some(o), Some(oi)) = (s.open.get_mut(&q), pos_int(&ev.get("oi"))) {
					o.top = o.top.max(oi);
					o.ticked.insert(oi);
					let at = here.or(s.at);
					self.client_tick(q, oi, t, at, &s.recent);
					s.ticks.push_back((t, q, oi, at));
				}
			}
			("complete", Some(q)) => {
				if let Some(o) = s.open.remove(&q) {
					let n = (o.listed as i64).max(o.top);
					let at = here.or(s.at);
					for oi in 1..=n {
						if !o.ticked.contains(&oi) {
							self.client_tick(q, oi, t, at, &s.recent);
							s.ticks.push_back((t, q, oi, at));
						}
					}
					let who = self.voter.clone();
					self.clients.entry(q).or_default().lines.entry(who).or_default().insert(n as usize);
				}
			}
			("abandon" | "turnin", Some(q)) => {
				s.open.remove(&q);
			}
			("kill", Some(q)) if known => {
				if let (Some(id), Some(oi)) = (npc, pos_int(&ev.get("oi"))) {
					let who = self.voter.clone();
					self.clients.entry(q).or_default().ticks.entry(oi).or_default().kills.entry(id).or_default().insert(who);
				}
			}
			_ => {}
		}
	}

	/// Line `oi` of quest `q` ticked at `t`, at `at`: the NPCs talked to there in the
	/// [`TALK_WINDOW`] before, the quest's friendly objective NPCs whose spawn is there, those whose
	/// training or vendor window opened then, and a cast in the [`CAST_WINDOW`] count for it.
	fn client_tick(&mut self, q: i64, oi: i64, t: f64, at: Option<At>, recent: &VecDeque<(f64, Seen)>) {
		let by: Vec<i64> = self
			.db
			.quests
			.get(&q.to_string())
			.get("objectives")
			.items()
			.iter()
			.flat_map(credited)
			.filter(|id| {
				let n = self.db.npcs.get(&id.to_string());
				n.get("faction").as_str().is_some_and(|f| !f.is_empty())
					&& at.is_some_and(|a| points_of(&n.get("spawns").get(&a.0.to_string()).get("pts")).iter().any(|p| near(Some((a.0, p[0], p[1])), at)))
			})
			.collect();
		let who = self.voter.clone();
		let line = self.clients.entry(q).or_default().ticks.entry(oi).or_default();
		for n in by {
			line.stood.entry(n).or_default().insert(who.clone());
		}
		// Latest first: a talk counts only with no work of the player's own after it.
		let mut worked = false;
		for &(when, s) in recent.iter().rev() {
			match s {
				Seen::Talk(n, place) if !worked && near(place, at) => {
					line.talks.entry(n).or_default().insert(who.clone());
				}
				Seen::Service(n) => {
					line.services.entry(n).or_default().insert(who.clone());
				}
				Seen::Work => {
					if t - when <= CAST_WINDOW {
						line.casts.insert(who.clone());
					}
					worked = true;
				}
				_ => {}
			}
		}
	}

	/// The faction, when it exists (one no source has is created only from vouched evidence),
	/// with the session's vote for its name.
	fn faction(&mut self, id: i64, name: &V) -> bool {
		let k = id.to_string();
		if !self.db.factions.has(&k) {
			if !self.vouched {
				return false;
			}
			let o = Obj::new();
			o.set("id", id as f64);
			o.set("name", V::Null);
			o.set("side", V::Null);
			o.set("parent", V::Null);
			o.set("source", arr(vec![V::str("recorder")]));
			self.db.factions.set(&k, o);
			self.stats.recorder_only_factions += 1;
		}
		self.factions_seen.entry(id).or_default().insert(self.voter.clone());
		self.name_vote(FACTION, id, name);
		true
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
			if !d.is_obj() || !self.faction(id, &d.get("name")) {
				continue;
			}
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
			let who = self.voter.clone();
			if let Some(p) = pos_int(&p) {
				if p != id {
					self.faction_parent.entry(id).or_default().vote(V::Num(p as f64), &who);
				}
			}
			if let Some(s) = d.get("side").as_str().filter(|s| *s == "Alliance" || *s == "Horde") {
				self.faction_side.entry(id).or_default().vote(V::str(s), &who);
			}
		}
	}

	// ---- finds
	/// Whether a `rare` sighting is of a true rare: the sighting's classification is rare or rare elite,
	/// or, a vignette's that carries none, the data's rank is (2 or 4). A world boss is none (#2894).
	fn true_rare(&self, id: i64, ev: &V) -> bool {
		match ev.get("cls").as_str() {
			Some(c) => c == "rare" || c == "rareelite",
			None => matches!(self.db.npcs.get(&id.to_string()).get("rank").as_num(), Some(r) if r == 2.0 || r == 4.0),
		}
	}

	fn unit(&mut self, id: i64, ev: &V) -> bool {
		if !self.entity("npc", id, &ev.get("npcName")) {
			return false;
		}
		let who = self.voter.clone();
		let cls = ev.get("cls").to_js_string();
		if ev.get("cls").is_str() || !ev.get("cls").is_undef() {
			if let Some(r) = rank_of(&cls) {
				self.rank.entry(id).or_default().vote(V::Num(r), &who);
			}
		}
		if cls == "rare" || cls == "rareelite" {
			self.role(0, id, "rare");
		}
		if let Some(l) = pos_int(&ev.get("npcLvl")) {
			let e = self.levels.entry(id).or_insert((l, l, IndexSet::new()));
			e.0 = e.0.min(l);
			e.1 = e.1.max(l);
			e.2.insert(who);
		}
		self.where_(0, id, ev);
		true
	}

	fn where_(&mut self, k: usize, id: i64, ev: &V) {
		if let Some(i) = pos_int(&ev.get("inst")) {
			self.inside[k].entry(id).or_default().entry(i).or_default().insert(self.voter.clone());
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

	/// `gathered`: the gather an object's `drop` was by the cast just before it ([`Session::gathered`]).
	fn handle_find(&mut self, ev: &V, gathered: Option<&'static str>) -> bool {
		let npc = pos_int(&ev.get("npc"));
		let obj = pos_int(&ev.get("object"));
		match ev.get("e").as_str().unwrap_or("") {
			"rare" => {
				let Some(npc) = npc else { return true };
				// Only a true rare takes a role and spawn points from its sightings (#2894): the Recorder also
				// logs world bosses this way, and the faction leaders (Thrall, Varimathras) got the spots where
				// players stood when they saw them.
				if self.unit(npc, ev) && self.true_rare(npc, ev) {
					self.role(0, npc, "rare");
					if let Some(c) = coord(ev) {
						push_point(&mut self.found[0], npc, &c);
						self.note(WHO_FOUND, npc, c.map);
					}
				}
				self.stats.recorded_sightings += 1;
				true
			}
			"treasure" => {
				let Some(obj) = obj else { return true };
				if self.entity("object", obj, &ev.get("objName")) {
					self.role(1, obj, "chest");
					if let Some(c) = coord(ev) {
						push_point(&mut self.found[1], obj, &c);
						self.note(WHO_FOUND + 1, obj, c.map);
					}
					self.where_(1, obj, ev);
				}
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
				let exists = if kind == "npc" {
					self.unit(id, ev)
				} else if self.entity("object", id, &ev.get("objName")) {
					self.where_(1, id, ev);
					if let Some(c) = coord(ev) {
						push_point(&mut self.found[1], id, &c);
						self.note(WHO_FOUND + 1, id, c.map);
					}
					// The roles a loot window gives: a gather (the Recorder's, or a gathering cast just
					// before it) makes a herb, an ore node or a fishing pool, never a chest; a chest is a
					// plain loot window with something a player keeps outside a quest (an item no open
					// objective wanted, and no quest item: a quest's plant or crate is no treasure).
					let role = match gather.as_str().or(gathered) {
						Some("herb") => Some("herb"),
						Some("mine") => Some("mine"),
						// A catch the client names a pool as the source of (the Recorder leaves the
						// bobber out): the pool.
						Some("fish") => Some("fishing"),
						None if !gather.truthy() && list.iter().any(|i| self.keepable(i)) => Some("chest"),
						_ => None,
					};
					if let Some(r) = role {
						self.role(1, id, r);
					}
					true
				} else {
					false
				};
				self.stats.recorded_loots += 1;
				if !exists {
					return true;
				}
				let k = k_ix(kind);
				let ci = self.ci;
				*self.windows[k].entry(id).or_default().entry(ci).or_insert(0.0) += 1.0;
				let mut seen: IndexSet<i64> = IndexSet::new();
				for i in &list {
					seen.insert(pos_int(&i.get("item")).unwrap());
				}
				self.quest_loot.window(k, id, ci, ev, &seen);
				for item in seen {
					*self.loots[k].entry(id).or_default().entry(item).or_default().entry(ci).or_insert(0.0) += 1.0;
					self.item_entry(item, &V::Undef);
				}
				self.loots[k].entry(id).or_default();
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
				let who = self.voter.clone();
				for &b in &bosses {
					if !self.entity("npc", b, &V::Null) {
						continue;
					}
					self.encounter_of.entry(b).or_default().vote(V::Num(enc as f64), &who);
					if let Some(i) = id {
						self.inside[0].entry(b).or_default().entry(i).or_default().insert(who.clone());
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

	/// A creature the player saw die: its level and rank, and where it died (fills spawns only). A
	/// death the Recorder names need not be the player's own kill (someone else's kill of a creature
	/// they targeted, a group member's), so drop chances count loot windows, not these.
	fn slain(&mut self, npc: i64, ev: &V) {
		self.stats.recorded_kills += 1;
		if !self.unit(npc, ev) {
			return;
		}
		if let Some(c) = coord(ev) {
			push_point(&mut self.killed, npc, &c);
		}
	}

	/// Recorded points into an entity's spawns: a map without spawns gets them; another source's
	/// spawns are merged with them only on trusted evidence (`slot`: WHO_FOUND + table index), and
	/// on a map Forever changed only when they are live-frame points already; `fill_only` never
	/// touches existing spawns.
	fn join(&self, e: &V, by_map: &ByMap, fill_only: bool, slot: usize, id: i64) {
		let spawns = e.get("spawns");
		for (&map, pts) in by_map {
			let cur = spawns.get(&map.to_string());
			let ours = self.filled.contains(&(slot - WHO_FOUND, id, map));
			if !cur.is_undef() && !ours && (fill_only || !self.trusted_at(slot, id, map) || (cur.get("f").as_str() != Some("l") && (self.live_maps)(map))) {
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

	/// Roles or instances recorded for entities: added where the entity has none, and to another
	/// source's list only on trusted evidence. Returns the ids that got `mark`.
	fn add_to_lists<K: Clone + std::hash::Hash + Eq>(&self, t: &Obj, field: &str, by: &IndexMap<i64, Backers<K>>, to_v: impl Fn(&K) -> V, mark: Option<&K>) -> usize {
		let mut marked = 0;
		for (&id, set) in by {
			let e = t.get(&id.to_string());
			if !e.truthy() {
				continue;
			}
			let mut list: Vec<V> = e.get(field).items();
			let had = !list.is_empty();
			let mut changed = false;
			let mut got_mark = false;
			for (k, who) in set {
				let v = to_v(k);
				let key = stringify(&v, None);
				let present = list.iter().any(|x| stringify(x, None) == key);
				if !present && had && !trusted(who, self.min) {
					continue;
				}
				if mark == Some(k) {
					got_mark = true;
				}
				if !present {
					list.push(v);
					changed = true;
				}
			}
			if got_mark {
				marked += 1;
			}
			if changed {
				list.sort_by(|a, b| match (a.as_num(), b.as_num()) {
					(Some(x), Some(y)) => x.total_cmp(&y),
					_ => cmp_utf16(&a.to_js_string(), &b.to_js_string()),
				});
				e.set(field, arr(list));
			}
		}
		marked
	}

	fn apply_finds(&mut self) {
		let db = self.db;
		let samples = std::mem::take(&mut self.quest_loot).finish();
		let quest_only = matches!(self.drop_chances, DropChances::QuestDrops | DropChances::QuestDropsLater);
		for kind in ["npc", "object"].into_iter().filter(|_| self.drop_chances != DropChances::Off) {
			let k = k_ix(kind);
			for (&id, m) in &self.loots[k] {
				let windows = &self.windows[k][&id];
				for (&item, held) in m {
					if quest_only && !samples.quest_drops.contains(&item) {
						continue;
					}
					if !db.items.get(&item.to_string()).truthy() {
						continue;
					}
					let Some(dc) = samples.chance(k, id, item, windows, held, self.min, |c| self.contributors[*c].clone()) else { continue };
					self.stats.recorded_drops.0.push((k, id, item, dc));
				}
			}
		}
		if self.drop_chances != DropChances::QuestDropsLater {
			self.stats.recorded_drop_chances = self.stats.recorded_drops.apply(db.items, &|_, _, _| false);
		}
		for (&id, b) in &self.rank {
			let e = db.npcs.get(&id.to_string());
			if let Some((r, _)) = b.decide(!e.get("rank").is_nullish(), self.min) {
				e.set("rank", r);
			}
		}
		for (&id, (lo, hi, who)) in &self.levels {
			let e = db.npcs.get(&id.to_string());
			let lvl = e.get("level").as_num().filter(|x| x.fract() == 0.0);
			if lvl.is_some() && !trusted(who, self.min) {
				continue;
			}
			let (lo, hi) = (*lo, *hi);
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
			let chest = "chest".to_string();
			treasures += self.add_to_lists(t, "roles", &self.roles[k], |r: &String| V::str(r), (kind == "object").then_some(&chest));
			self.add_to_lists(t, "instances", &self.inside[k], |i: &i64| V::Num(*i as f64), None);
			for (&id, by_map) in &self.found[k] {
				let e = t.get(&id.to_string());
				if e.truthy() {
					// A rare's sighting is where the player stood, not where the rare is (#2816).
					let places;
					let by_map = if k == 0 {
						places = sighting_places(&e.get("spawns"), by_map);
						&places
					} else {
						by_map
					};
					self.join(&e, by_map, false, WHO_FOUND + k, id);
				}
			}
		}
		for (&id, by_map) in &self.killed {
			let e = db.npcs.get(&id.to_string());
			if e.truthy() {
				self.join(&e, by_map, true, WHO_FOUND, id);
			}
		}
		for (&id, b) in &self.encounter_of {
			let e = db.npcs.get(&id.to_string());
			if let Some((enc, _)) = b.decide(!e.get("encounter").is_nullish(), self.min) {
				e.set("encounter", enc);
			}
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
		self.stats.recorded_treasures = treasures;
		self.stats.recorded_instances = self.inst.len();
		self.stats.recorded_encounters = encounters;
	}

	/// Recorded names: an English one replaces another source's only on trusted evidence; a
	/// name in another language only fills a missing one. A faction recorded on trusted evidence
	/// gains `recorder` in its source.
	fn apply_names(&self) {
		for (&(table, id), [en, other]) in &self.names {
			let t = match table {
				NPC => self.db.npcs,
				OBJECT => self.db.objects,
				ITEM => self.db.items,
				_ => self.db.factions,
			};
			let e = t.get(&id.to_string());
			if !e.truthy() {
				continue;
			}
			let present = e.get("name").truthy();
			let pick = en.decide(present, self.min).or_else(|| if present { None } else { other.decide(false, self.min) });
			if let Some((n, _)) = pick {
				e.set("name", n);
			}
		}
		for (&id, who) in &self.factions_seen {
			if trusted(who, self.min) {
				add_source(&self.db.factions.get(&id.to_string()), "recorder");
			}
		}
	}

	/// What players recorded of a quest, through the trust rule, each field tagged.
	fn apply_quest(&self, q: &V, v: &QuestVotes) {
		let title = q.get("title");
		let present = title.as_str().is_some_and(|t| !t.is_empty());
		if let Some((t, tr)) = v.title[0].decide(present, self.min).or_else(|| if present { None } else { v.title[1].decide(false, self.min) }) {
			q.set("title", t);
			tag_field(q, "title", tr);
		}
		if let Some((l, tr)) = v.level.decide(q.get("level").as_num().is_some_and(|l| l > 0.0), self.min) {
			q.set("level", l);
			tag_field(q, "level", tr);
		}
		if !q.get("zone").truthy() {
			if let Some((z, tr)) = v.zone.decide(false, self.min) {
				q.set("zone", z);
				tag_field(q, "zone", tr);
			}
		}
		for (&(side, kind), backers) in &v.givers {
			let list = q.get(side).get(kind);
			let V::Arr(a) = &list else { continue };
			let had = !list.items().is_empty();
			let mut order: Vec<(&i64, &IndexSet<String>)> = backers.iter().collect();
			order.sort_by_key(|(_, w)| std::cmp::Reverse(weight(w)));
			let mut first: Vec<i64> = Vec::new();
			for (&id, who) in order {
				let tr = trusted(who, self.min);
				if list.items().iter().any(|x| x.as_num() == Some(id as f64)) {
					if tr {
						tag_field(q, side, true);
					}
					continue;
				}
				if had && !tr {
					continue;
				}
				if had {
					first.push(id);
				} else {
					a.0.borrow_mut().push(V::Num(id as f64));
				}
				tag_field(q, side, tr);
			}
			// Trusted givers another source lacks go first, the best backed first.
			for id in first.into_iter().rev() {
				a.0.borrow_mut().insert(0, V::Num(id as f64));
			}
		}
		if let Some((r, tr)) = reward_ballot(&v.rewards).decide(!q.get("rewards").is_nullish(), self.min) {
			q.set("rewards", r);
			tag_field(q, "rewards", tr);
		}
	}
}

pub(crate) struct DropChance {
	pub chance: f64,
	pub trusted: bool,
	pub n: f64,
	pub of: f64,
}

/// An item objective: (quest, objective index), as a `drop`'s `wanted` and an item's tick name it.
type Objective = (i64, i64);

/// One kind of loot window, counted: the source's kind ([`k_ix`]) and id, the player, the item
/// objectives open when it opened, the items it held and the objectives it ticked; whether the player
/// was in a group (`grouped`) and whether the session records each kill (`kills`, schema 2).
#[derive(PartialEq, Eq, Hash)]
struct Window {
	k: usize,
	id: i64,
	who: usize,
	open: Box<[Objective]>,
	items: Box<[i64]>,
	ticks: Box<[Objective]>,
	grouped: bool,
	kills: bool,
}

/// One kind of kill, counted: the creature, the player and the item objectives open when it died.
#[derive(PartialEq, Eq, Hash)]
struct Kill {
	id: i64,
	who: usize,
	open: Box<[Objective]>,
}

/// What a session's quest log, group, loot windows and kills do, read in the order of their times
/// ([`QuestLoot::end`]).
enum Step {
	/// A quest's objective list (`objectives`): the indexes of its item objectives.
	Listed(i64, Vec<i64>),
	/// An objective's tick (`progress`, one per gain): whether the Recorder says it is an item's, and
	/// whether it is done.
	Tick { o: Objective, item: bool, done: bool },
	/// A quest done or gone from the log (`complete`, `abandon`, `turnin`).
	Gone(i64),
	/// A `group`: whether the player is in one.
	Group(bool),
	/// Any loot window: the item objectives open then (its `wanted`).
	Loot(FxHashSet<Objective>),
	/// A loot window a quest drop counts ([`QuestLoot::window`]); `grouped` is read in time order.
	Window(Window),
	/// A `kill`: the creature, and whether the record says a group.
	Kill(i64, bool),
}

/// The loot windows behind the drops that fall only for a quest that wants them (Large Candle, for
/// Kobold Candles). A player's share of every loot window of the source undercounts such a drop by
/// all the windows they opened off the quest, so a quest drop's chance counts only while its
/// objective was open (the Recorder's `wanted`, docs/RECORDING.md). An objective's item is the
/// one its ticks name most (a tick can land on another item of the window); a drop is a quest drop
/// when more than half of the windows that held it had one of its objectives open (Hops, which every
/// Thistle Boar drops, stays a drop like any other). A window that ticked an objective held its
/// item, even when fast loot had taken it before the window was read.
///
/// A creature's quest drop is counted on its kills while the item was wanted, not on the loot
/// windows (#2747): a player opens a window on only some kills (a corpse with nothing on it can't be
/// opened, and many are left), so the windows read the chance 1.2 to 3 times high. The kills are
/// the session's `kill` records (schema 2), solo (in a group another member may loot the corpse);
/// the Recorder's `denied` is no test (it marks as many of the player's own kills, which gave them
/// XP and a loot window, as any other: Grizzled Thistle Bears on Grizzled Scalps, 145 of 266 kills
/// that gave XP, looted as often). The item objectives open then are the session's quest log as its
/// events go (`objectives` at the accept, `progress`, a `drop`'s `wanted`, which also names a quest
/// carried in from an earlier session; gone at `complete`, `abandon` and `turnin`), in the order of
/// their times: the Recorder writes a kill 3 s after the death with the death's time, so a kill
/// looted fast comes after its window and its tick, and the one that finished the objective after
/// the objective was done. A kill dropped the item when a window of it held it, or when the
/// objective ticked before any loot window opened after it (an older Recorder read no window for
/// one scalp in five). A window in a group counts for neither side. A session with no kill records
/// (schema 1) counts its windows, as before. An object's drop stays counted on its windows (opening
/// one is the try).
#[derive(Default)]
pub(crate) struct QuestLoot {
	/// objective -> item -> windows whose tick named the item.
	tick_items: FxHashMap<Objective, FxHashMap<i64, f64>>,
	/// Windows with an objective open -> how many.
	windows: FxHashMap<Window, f64>,
	/// item -> windows holding it, every window.
	held: FxHashMap<i64, f64>,
	/// Kills a player could loot with an item objective open -> how many.
	kills: FxHashMap<Kill, f64>,
	/// (creature, player, objective) -> kills whose drop only the objective's tick tells.
	ticked: FxHashMap<(i64, usize, Objective), f64>,
	/// The session: its player, whether it records each kill (schema 2), whether a loot window of it
	/// named the objectives open, its steps with their times ([`QuestLoot::event`]) and the latest time.
	who: usize,
	counts_kills: bool,
	wanted_seen: bool,
	steps: Vec<(f64, Step)>,
	t: f64,
}

type Samples = IndexMap<usize, f64>;

/// What a drop chance counts ([`DropSamples::chance`]), per player: the loot windows of the source and
/// those of them that held the item; for a quest drop, only while its objective was open.
pub(crate) struct DropSamples {
	/// (kind, source, quest drop) -> per player, the tries counted and those that dropped it.
	quest: FxHashMap<(usize, i64, i64), (Samples, Samples)>,
	quest_drops: FxHashSet<i64>,
	none: Samples,
}

impl DropSamples {
	/// The chance of `item` from source `id` (kind `k`), given every loot window of the source per
	/// player (`windows`) and those that held the item (`held`): a quest drop's pooled
	/// ([`quest_drop_chance`]), any other the median of the players' own ([`drop_chance`]).
	pub(crate) fn chance(&self, k: usize, id: i64, item: i64, windows: &Samples, held: &Samples, min: usize, name: impl Fn(&usize) -> String) -> Option<DropChance> {
		if !self.quest_drops.contains(&item) {
			return drop_chance(windows, held, min, name);
		}
		let (of_by, n_by) = self.quest.get(&(k, id, item)).map_or((&self.none, &self.none), |(of, n)| (of, n));
		quest_drop_chance(of_by, n_by, min, name)
	}
}

impl QuestLoot {
	/// A new session: its quest log read afresh from its events, solo until a `group` says otherwise;
	/// `counts_kills`: it records each kill (schema 2).
	pub(crate) fn begin(&mut self, counts_kills: bool) {
		self.end();
		self.counts_kills = counts_kills;
		self.t = 0.0;
	}

	/// A step of the session at the event's time (an event with none: the latest time).
	fn push(&mut self, ev: &V, step: Step) {
		let t = ev.get("t").as_num().filter(|t| t.is_finite()).unwrap_or(self.t);
		self.t = self.t.max(t);
		self.steps.push((t, step));
	}

	/// The session's steps in the order of their times (see [`QuestLoot`]): its windows, kills and the
	/// drops only a tick tells. They count where its loot windows name the item objectives open
	/// (`wanted`): a Recorder from before that knows of no quest drop's window, so its kills would be
	/// tries with no drop.
	fn end(&mut self) {
		let mut steps = std::mem::take(&mut self.steps);
		if !std::mem::take(&mut self.wanted_seen) {
			return;
		}
		steps.sort_by(|a, b| a.0.total_cmp(&b.0));
		let who = self.who;
		let mut open: FxHashSet<Objective> = FxHashSet::default();
		let mut grouped = false;
		// The latest counted kill no loot window followed yet, and the objectives that ticked since.
		let mut last: Option<(i64, Vec<Objective>)> = None;
		for (_, step) in steps {
			match step {
				Step::Listed(q, ois) => {
					open.retain(|o| o.0 != q);
					open.extend(ois.into_iter().map(|oi| (q, oi)));
				}
				Step::Tick { o, item, done } => {
					if !(item || open.contains(&o)) {
						continue;
					}
					if let Some((id, told)) = &mut last {
						if open.contains(&o) && !told.contains(&o) {
							told.push(o);
							*self.ticked.entry((*id, who, o)).or_default() += 1.0;
						}
					}
					if done {
						open.remove(&o);
					} else {
						open.insert(o);
					}
				}
				Step::Gone(q) => open.retain(|o| o.0 != q),
				Step::Group(g) => grouped = g,
				Step::Loot(wanted) => {
					open = wanted;
					last = None;
				}
				Step::Window(mut w) => {
					w.grouped = grouped;
					*self.windows.entry(w).or_default() += 1.0;
				}
				Step::Kill(id, group) => {
					last = None;
					if open.is_empty() || grouped || group {
						continue;
					}
					let mut o: Vec<Objective> = open.iter().copied().collect();
					o.sort_unstable();
					*self.kills.entry(Kill { id, who, open: o.into() }).or_default() += 1.0;
					last = Some((id, Vec::new()));
				}
			}
		}
	}

	/// Each event of `who`'s session, in order: the quest log, the group, the loot windows and the
	/// kills (see [`QuestLoot`]). A `drop` also goes to [`QuestLoot::window`].
	pub(crate) fn event(&mut self, who: usize, ev: &V) {
		self.who = who;
		let q = pos_int(&ev.get("q"));
		let step = match ev.get("e").as_str() {
			Some("objectives") => {
				let Some(q) = q else { return };
				let items = ev.get("objectives").items().iter().enumerate().filter(|(_, o)| o.get("type").as_str() == Some("item")).map(|(i, _)| i as i64 + 1).collect();
				Step::Listed(q, items)
			}
			Some("progress") => {
				let (Some(q), Some(oi)) = (q, pos_int(&ev.get("oi"))) else { return };
				let (Some(cur), Some(max)) = (ev.get("cur").as_num(), ev.get("max").as_num()) else { return };
				Step::Tick { o: (q, oi), item: ev.get("type").as_str() == Some("item"), done: cur >= max }
			}
			Some("complete" | "abandon" | "turnin") => {
				let Some(q) = q else { return };
				Step::Gone(q)
			}
			Some("group") => Step::Group(ev.get("size").as_num().is_some_and(|s| s > 0.0)),
			// The item objectives open at that moment: the quest log as the client had it (a quest
			// carried in from an earlier session too).
			Some("drop") => Step::Loot(ev.get("wanted").items().iter().filter_map(|o| Some((pos_int(&o.get("q"))?, pos_int(&o.get("oi"))?))).collect()),
			Some("kill") => {
				let Some(id) = pos_int(&ev.get("npc")) else { return };
				Step::Kill(id, ev.get("group").as_num().is_some_and(|g| g > 0.0))
			}
			_ => return,
		};
		self.push(ev, step);
	}

	/// A `drop` of source `id` (kind `k`) that `who` opened, with `items` its held items.
	pub(crate) fn window(&mut self, k: usize, id: i64, who: usize, ev: &V, items: &IndexSet<i64>) {
		self.who = who;
		let objective = |o: &V| Some((pos_int(&o.get("q"))?, pos_int(&o.get("oi"))?));
		let mut ticks: Vec<Objective> = Vec::new();
		for i in ev.get("items").items() {
			if let (Some(item), Some(o)) = (pos_int(&i.get("item")), objective(&i)) {
				*self.tick_items.entry(o).or_default().entry(item).or_default() += 1.0;
				ticks.push(o);
			}
		}
		for &item in items {
			*self.held.entry(item).or_default() += 1.0;
		}
		let mut open: Vec<Objective> = ev.get("wanted").items().iter().filter_map(objective).collect();
		if open.is_empty() {
			return;
		}
		self.wanted_seen = true;
		open.sort_unstable();
		open.dedup();
		ticks.sort_unstable();
		ticks.dedup();
		let mut held: Vec<i64> = items.iter().copied().collect();
		held.sort_unstable();
		let w = Window { k, id, who, open: open.into(), items: held.into(), ticks: ticks.into(), grouped: false, kills: self.counts_kills };
		self.push(ev, Step::Window(w));
	}

	/// What every drop chance counts: a quest drop, only while its objective was open (none at a
	/// source no such window came from), a creature's on its kills then (see [`QuestLoot`]); any other
	/// drop, every window.
	pub(crate) fn finish(mut self) -> DropSamples {
		self.end();
		// The objective's item: the one most of its ticks name (a tie names none).
		let mut objectives_of: FxHashMap<i64, Vec<Objective>> = FxHashMap::default();
		for (o, by) in &self.tick_items {
			let top = by.values().copied().fold(0.0, f64::max);
			let mut best = by.iter().filter(|(_, n)| **n == top);
			if let (Some((&item, _)), None) = (best.next(), best.next()) {
				objectives_of.entry(item).or_default().push(*o);
			}
		}
		let item_of: FxHashMap<Objective, i64> = objectives_of.iter().flat_map(|(&item, os)| os.iter().map(move |&o| (o, item))).collect();
		// The items a window held while one of their objectives was open: its own, and the item of
		// every objective it ticked.
		let held_open = |w: &Window| -> IndexSet<i64> {
			let mut out: IndexSet<i64> = IndexSet::new();
			for &item in w.items.iter().chain(w.ticks.iter().filter_map(|o| item_of.get(o))) {
				if objectives_of.get(&item).is_some_and(|os| os.iter().any(|o| w.open.contains(o))) {
					out.insert(item);
				}
			}
			out
		};
		let mut on: FxHashMap<i64, f64> = FxHashMap::default();
		let mut recovered: FxHashMap<i64, f64> = FxHashMap::default();
		for (w, &n) in &self.windows {
			for item in held_open(w) {
				*on.entry(item).or_default() += n;
				if !w.items.contains(&item) {
					*recovered.entry(item).or_default() += n;
				}
			}
		}
		let quest: FxHashSet<i64> = on
			.iter()
			.filter(|(item, n)| {
				let all = self.held.get(item).copied().unwrap_or(0.0) + recovered.get(item).copied().unwrap_or(0.0);
				**n * 2.0 > all
			})
			.map(|(&item, _)| item)
			.collect();
		let mut samples: FxHashMap<(usize, i64, i64), (Samples, Samples)> = FxHashMap::default();
		let wanted_of = |open: &[Objective]| -> IndexSet<i64> { open.iter().filter_map(|o| item_of.get(o)).copied().filter(|item| quest.contains(item)).collect() };
		for (w, &n) in &self.windows {
			// A group's corpse: neither its window nor its kill is the player's alone.
			if w.k == 0 && w.grouped {
				continue;
			}
			let held = held_open(w);
			for item in wanted_of(&w.open) {
				let (of_by, n_by) = samples.entry((w.k, w.id, item)).or_default();
				// A creature's, where the session records its kills: counted on them below.
				let tries = of_by.entry(w.who).or_insert(0.0);
				if !(w.k == 0 && w.kills) {
					*tries += n;
				}
				if held.contains(&item) {
					*n_by.entry(w.who).or_insert(0.0) += n;
				}
			}
		}
		for (kill, &n) in &self.kills {
			for item in wanted_of(&kill.open) {
				*samples.entry((0, kill.id, item)).or_default().0.entry(kill.who).or_insert(0.0) += n;
			}
		}
		for (&(id, who, o), &n) in &self.ticked {
			if let Some(&item) = item_of.get(&o).filter(|item| quest.contains(item)) {
				*samples.entry((0, id, item)).or_default().1.entry(who).or_insert(0.0) += n;
			}
		}
		// Never fewer tries than drops: a kill the Recorder missed (an unreadable death) still dropped.
		for (of_by, n_by) in samples.values_mut() {
			for (who, &n) in n_by.iter() {
				let of = of_by.entry(*who).or_insert(0.0);
				if *of < n {
					*of = n;
				}
			}
		}
		DropSamples { quest: samples, quest_drops: quest, none: Samples::new() }
	}
}

/// A quest drop's chance: every player's drops over every player's tries, pooled. A player collects
/// until the objective is done, so the tries they needed follow their luck, and a share of their own
/// reads high for the lucky and low for the unlucky; the players with many tries are the unlucky ones
/// (Grizzled Scalp: the three with 10 kills or more, 9.09% at the median; everyone's together, 38.97%).
/// Trusted from `min` players (or a vouched one) with [`MIN_WINDOWS`] tries for each of them
/// together, the evidence a trusted chance of the median needs.
fn quest_drop_chance(of_by: &Samples, n_by: &Samples, min: usize, name: impl Fn(&usize) -> String) -> Option<DropChance> {
	let all: Vec<&usize> = of_by.iter().filter(|(_, of)| **of > 0.0).map(|(c, _)| c).collect();
	let backers: IndexSet<String> = all.iter().map(|c| name(c)).collect();
	let of: f64 = all.iter().map(|c| of_by[*c]).sum();
	let n: f64 = all.iter().map(|c| n_by.get(*c).copied().unwrap_or(0.0)).sum();
	if n <= 0.0 {
		return None;
	}
	let need = if backers.iter().any(|b| vouched(b)) { 1.0 } else { min as f64 };
	let trusted = trusted(&backers, min) && of >= MIN_WINDOWS * need;
	Some(DropChance { chance: round2(100.0 * n / of), trusted, n, of })
}

/// From [`MIN_WINDOWS`] loot windows of their own, `min` players (or a vouched one) make a trusted
/// chance that replaces another source's; otherwise the chance only fills a gap. Either way it is
/// the median of each player's chance. `name` gives the player a key stands for ([`trusted`] reads
/// names).
fn drop_chance<K: Eq + Hash>(of_by: &IndexMap<K, f64>, n_by: &IndexMap<K, f64>, min: usize, name: impl Fn(&K) -> String) -> Option<DropChance> {
	let all: Vec<&K> = of_by.iter().filter(|(_, of)| **of > 0.0).map(|(c, _)| c).collect();
	let strong: Vec<&K> = all.iter().copied().filter(|c| of_by[*c] >= MIN_WINDOWS).collect();
	let backers: IndexSet<String> = strong.iter().map(|c| name(c)).collect();
	let trust = trusted(&backers, min);
	let group = if trust { strong } else { all };
	let n_of = |c: &&K| n_by.get(*c).copied().unwrap_or(0.0);
	let chance = median(group.iter().map(|c| 100.0 * n_of(c) / of_by[*c]).collect());
	if chance.is_nan() || chance <= 0.0 {
		return None;
	}
	Some(DropChance { chance: round2(chance), trusted: trust, n: group.iter().map(n_of).sum(), of: group.iter().map(|c| of_by[*c]).sum() })
}

/// The rewards a quest frame showed (items, choices, money), the player's latest of the highest
/// weight (a turn-in 2 over an accept 1).
pub(crate) fn observe_reward(rewards: &mut IndexMap<String, (u8, V)>, ev: &V, weight: u8, who: &str) {
	let items = ids(&ev.get("items"));
	let choices = ids(&ev.get("choices"));
	let frame_money = pos_int(&ev.get("rewardMoney"));
	if items.is_empty() && choices.is_empty() && frame_money.is_none() {
		return;
	}
	let money = frame_money.or(if weight == 2 { pos_int(&ev.get("money")) } else { None });
	if rewards.get(who).is_some_and(|(w, _)| *w > weight) {
		return;
	}
	let o = Obj::new();
	o.set("items", nums(&items.iter().map(|&x| x as f64).collect::<Vec<_>>()));
	o.set("choices", nums(&choices.iter().map(|&x| x as f64).collect::<Vec<_>>()));
	o.set("money", money.map(|m| V::Num(m as f64)).unwrap_or(V::Null));
	rewards.insert(who.to_string(), (weight, V::Obj(o)));
}

pub(crate) fn reward_ballot(rewards: &IndexMap<String, (u8, V)>) -> Ballot {
	let mut rewards_ballot = Ballot::default();
	for (who, (_, r)) in rewards {
		rewards_ballot.vote(r.clone(), who);
	}
	rewards_ballot
}

impl QuestVotes {
	fn giver(&mut self, side: &'static str, kind: &'static str, id: i64, who: &str) {
		self.givers.entry((side, kind)).or_default().entry(id).or_default().insert(who.to_string());
	}

	fn reward(&mut self, ev: &V, weight: u8, who: &str) {
		observe_reward(&mut self.rewards, ev, weight, who);
	}
}

/// A rare's recorded sightings per map, as places to merge into its spawns (#2816): each map's
/// sightings become the centres of their clusters (SIGHT_RADIUS), and on a map where `spawns` (the
/// other sources) already place the rare, only the centres farther than that from all of its points
/// stay: a place no source knows. Sightings near a known spawn are players standing around it.
fn sighting_places(spawns: &V, by_map: &ByMap) -> ByMap {
	let mut out = ByMap::new();
	for (&map, pts) in by_map {
		let cur = spawns.get(&map.to_string());
		let known: Vec<P> = if cur.is_undef() { Vec::new() } else { points_of(&cur.get("pts")).into_iter().chain(points_of(&cur.get("more"))).collect() };
		let keep: Vec<P> = clusters(pts, SIGHT_RADIUS).into_iter().map(|(x, y, _)| [x, y]).filter(|&[x, y]| known.iter().all(|k| hypot(k[0] - x, k[1] - y) > SIGHT_RADIUS)).collect();
		if !keep.is_empty() {
			out.insert(map, keep);
		}
	}
	out
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

/// Recorded objectives matched to the quest's (by name, else id). Each player gives one count (the
/// highest it saw) and an objective gets the lower median of them. An objective another source
/// has takes the recorded count where it has none, or on trusted evidence; a recorded objective
/// the quest lacks is added, and the recorded order applied, only on trusted evidence or when the
/// quest had no objectives, and never to a quest the game's own list `settled` ([`game_objectives`]).
/// Tags `objectives`.
fn merge_objectives(q: &V, slots: &IndexMap<i64, Slot>, min: usize, settled: bool) {
	let mut list: Vec<V> = q.get("objectives").items();
	let had = !list.is_empty();
	let (mut by_trusted, mut by_gap) = (false, false);
	let mut used: FxHashSet<usize> = FxHashSet::default();
	let mut oi_of: IndexMap<usize, i64> = IndexMap::new();
	let mut keys: Vec<i64> = slots.keys().copied().collect();
	keys.sort();
	for oi in keys {
		let s = &slots[&oi];
		let tr = trusted(&s.who, min);
		let name = s.name.best().and_then(|(v, _)| v.as_str().map(str::to_string));
		let id = s.id.best().map(|(v, _)| v.num() as i64);
		let kind = s.kind.best().and_then(|(v, _)| v.as_str().map(str::to_string));
		let count = lower_median(s.max.values().copied().filter(|m| *m != 0.0).collect());
		// Nothing to match it by (a non-English session's progress: names are not taken from it).
		if name.is_none() && id.is_none() {
			continue;
		}
		// The game's line names the data's objective, its plural, or the objective followed by one word
		// saying what is done to it ("Tarantula Egg destroyed" for the Tarantula Egg object, Alther's
		// Mill 98386; never a longer name: "Black Drake Whelp" is not "Black Drake").
		let matches = |t: &str, name: &str| {
			let (t, name) = (t.trim().to_lowercase(), name.trim().to_lowercase());
			let done = |rest: &str| {
				rest.starts_with(' ') && {
					let w = rest.trim();
					!w.contains(' ') && w.len() > 2 && w.ends_with("ed")
				}
			};
			!t.is_empty() && (format!("{t}s") == name || name.strip_prefix(&t).is_some_and(done))
		};
		let mut idx = name.as_ref().and_then(|name| {
			list.iter().enumerate().position(|(i, o)| !used.contains(&i) && !name.is_empty() && (same(&o.get("text"), name) || o.get("text").as_str().is_some_and(|t| matches(t, name))))
		});
		if idx.is_none() {
			if let Some(id) = id {
				idx = list.iter().enumerate().position(|(i, o)| !used.contains(&i) && o.get("id").as_num() == Some(id as f64) && kind.as_ref().is_none_or(|k| o.get("type").as_str() == Some(k)));
			}
		}
		let idx = match idx {
			None => {
				// A line credited to no creature or object and not a creature's "slain" line (a hidden
				// credit the server counts as a kill: "Find the hottest area of Fire Plume Ridge", "Videre
				// Elixir Used at Gravestone") is never added: beside a quest's objectives it repeats one of
				// them in the game's words, and alone it is a kill no step or route can target (#2585,
				// Finding the Source 974, Meet at the Grave 3912).
				let untargeted = id.is_none() && !s.slain && kind.as_deref().is_some_and(|k| k != "event");
				if (had && !tr) || untargeted || settled {
					continue;
				}
				let o = Obj::new();
				o.set("type", kind.clone().unwrap_or_else(|| "event".into()));
				o.set("id", id.map(|x| V::Num(x as f64)).unwrap_or(V::Null));
				o.set("count", count.map(V::Num).unwrap_or(V::Null));
				o.set("text", name.clone().filter(|n| !n.is_empty()).map(V::from).unwrap_or(V::Null));
				list.push(V::Obj(o));
				if tr {
					by_trusted = true;
				} else {
					by_gap = true;
				}
				list.len() - 1
			}
			Some(i) => {
				if let Some(c) = count {
					let cur = list[i].get("count").as_num();
					if cur.is_none_or(|n| n <= 0.0) || tr {
						if cur != Some(c) {
							list[i].set("count", c);
							if tr {
								by_trusted = true;
							} else {
								by_gap = true;
							}
						} else if tr {
							by_trusted = true;
						}
					}
				}
				i
			}
		};
		used.insert(idx);
		if (tr || !had) && !settled {
			oi_of.insert(idx, oi);
		}
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
	if by_trusted {
		tag_field(q, "objectives", true);
	}
	if by_gap {
		tag_field(q, "objectives", false);
	}
}

/// What [`game_objectives`] did to a quest: kept its objectives (no list, or lines it cannot match),
/// found them the same as the game's, met disagreeing lists, or changed them.
enum Game {
	Kept,
	Same,
	Conflict,
	Changed { talk: usize, dropped: usize },
}

/// The players behind line `tk`'s evidence that a talk to `id` ticked it: a window opened with it
/// where and when the line ticked, or (`stood`) the line ticking at its spawn, for an NPC players
/// open windows with (`windows`: not a credit marker nobody can talk to) on a creature's line or a
/// revealed one, with no spell cast just before (a heal or a ritual is no talk).
fn talk_evidence<'a>(tk: &'a Ticks, id: i64, line: Option<&str>, windows: &FxHashSet<i64>) -> IndexSet<&'a String> {
	let mut who: IndexSet<&String> = tk.talked(id).into_iter().flatten().collect();
	if windows.contains(&id) && tk.casts.is_empty() && matches!(line, None | Some("monster")) && !tk.services.contains_key(&id) {
		who.extend(tk.stood.get(&id).into_iter().flatten());
	}
	who
}

/// The ids an objective is credited on: its own and its `credit` list.
fn credited(o: &V) -> Vec<i64> {
	let mut ids: Vec<i64> = pos_int(&o.get("id")).into_iter().collect();
	ids.extend(o.get("credit").items().iter().filter_map(pos_int));
	ids
}

/// Whether a line the game lists as `line` (none: a line it revealed later) can be a data
/// objective of `kind`.
pub(crate) fn fits(line: Option<&str>, kind: &str) -> bool {
	match line {
		None => true,
		Some("monster") => matches!(kind, "kill" | "talk"),
		Some(t @ ("item" | "object" | "event")) => t == kind,
		_ => false,
	}
}

/// The game's own objective list over the data's ([`ClientList`]): its lines decide how many
/// objectives a quest has, their order and which are kills. It is the client's own list, so one
/// counted player's recording settles it; players whose lists at the accept, or line counts once
/// complete, disagree leave the data's objectives as they are ([`Game::Conflict`]). Texts are never
/// read (any client language counts): a line is matched to the data objective whose NPC its ticks
/// name (kill credits on its ids, a talk to it) when each is the other's clear strongest, and the
/// rest in order by type. When every line has its objective:
/// - the objectives take the game's order;
/// - once a player completed the quest (every line the game reveals one at a time is then known),
///   a data objective no line has is one the game does not count, and goes (The Cult of the
///   Damned's Decrepit Darkhounds);
/// - a kill objective no kill of its NPC ticked becomes `talk` (count 1) when players talked to its
///   NPC as its line ticked ([`talk_evidence`]: Desperate Times' three talks, Welcome to Shen'dar
///   Village's innkeeper, who counts as you walk up to her). Kills of other creatures credited to
///   the line count as killing only from two players (one kill credited as an unrelated line ticks
///   is noise).
///
/// A line of a type no data objective has (a skill to raise, a beast to tame) keeps the data's list.
fn game_objectives(q: &V, c: &ClientList, windows: &FxHashSet<i64>) -> Game {
	let shapes: IndexSet<&Vec<(String, i64)>> = c.listed.values().flatten().collect();
	if shapes.len() > 1 {
		return Game::Conflict;
	}
	let Some(&listed) = shapes.first() else { return Game::Kept };
	if listed.iter().all(|(t, _)| t == "log") {
		return Game::Kept;
	}
	let finals: IndexSet<usize> = c.lines.values().flatten().copied().collect();
	if finals.len() > 1 {
		return Game::Conflict;
	}
	let complete = finals.first().copied();
	let n = complete.unwrap_or(0).max(listed.len());
	let list = q.get("objectives").items();
	if list.is_empty() {
		return Game::Kept;
	}
	let none = Ticks::default();
	let ticks = |oi: usize| c.ticks.get(&(oi as i64)).unwrap_or(&none);
	let kind = |o: &V| o.get("type").as_str().unwrap_or("event").to_string();
	// Players behind each (line, objective) pair; a pair is taken when it is the line's strongest
	// and the objective's strongest, each alone (kill credits a moment off land on a neighbouring
	// line now and then).
	let mut score = vec![vec![0usize; list.len()]; n + 1];
	for (oi, row) in score.iter_mut().enumerate().skip(1) {
		let tk = ticks(oi);
		let line = listed.get(oi - 1).map(|(t, _)| t.as_str());
		for (j, o) in list.iter().enumerate() {
			if matches!(kind(o).as_str(), "kill" | "talk") {
				let ids = credited(o);
				row[j] = ids.iter().flat_map(|&id| tk.kills.get(&id).into_iter().flatten().chain(talk_evidence(tk, id, line, windows))).collect::<IndexSet<_>>().len();
			}
		}
	}
	let mut of_line: Vec<Option<usize>> = vec![None; n + 1];
	let mut taken = vec![false; list.len()];
	for oi in 1..=n {
		for j in 0..list.len() {
			let s = score[oi][j];
			let alone_in_row = (0..list.len()).all(|k| k == j || score[oi][k] < s);
			let alone_in_column = (1..=n).all(|k| k == oi || score[k][j] < s);
			if s > 0 && alone_in_row && alone_in_column {
				of_line[oi] = Some(j);
				taken[j] = true;
			}
		}
	}
	for oi in 1..=n {
		if of_line[oi].is_some() {
			continue;
		}
		let line = listed.get(oi - 1).map(|(t, _)| t.as_str());
		let Some(j) = (0..list.len()).find(|&j| !taken[j] && fits(line, &kind(&list[j]))) else { return Game::Kept };
		of_line[oi] = Some(j);
		taken[j] = true;
	}
	let before = stringify(&q.get("objectives"), None);
	let mut out: Vec<V> = of_line[1..].iter().map(|j| list[j.unwrap()].clone()).collect();
	let rest = (0..list.len()).filter(|&j| !taken[j]).map(|j| list[j].clone());
	let dropped = if complete.is_some() {
		rest.count()
	} else {
		out.extend(rest);
		0
	};
	let mut talk = 0;
	// A quest whose own text asks for a fight, a use or an escort (talk.rs: "Beat Bartleby", "Defeat 3
	// other players in duels or Novice Warriors") keeps its kills: the NPC turns hostile once talked to
	// and gives in, with no kill to record (#2535).
	let fights = crate::talk::asks_other(q.get("objectiveText").as_str().unwrap_or(""));
	for oi in (1..=n).filter(|_| !fights) {
		let o = &out[oi - 1];
		if o.get("type").as_str() != Some("kill") {
			continue;
		}
		let tk = ticks(oi);
		let ids = credited(o);
		let killed = ids.iter().any(|id| tk.kills.contains_key(id)) || tk.kills.values().flatten().collect::<IndexSet<_>>().len() >= 2;
		if killed {
			continue;
		}
		let line = listed.get(oi - 1).map(|(t, _)| t.as_str());
		if ids.iter().any(|&id| !talk_evidence(tk, id, line, windows).is_empty()) {
			let t = Obj::new();
			for (k, v) in o.entries() {
				t.set_str(k, v);
			}
			t.set("type", "talk");
			t.set("count", 1.0);
			out[oi - 1] = V::Obj(t);
			talk += 1;
		}
	}
	let after = arr(out);
	if stringify(&after, None) == before {
		return Game::Same;
	}
	q.set("objectives", after);
	tag_field(q, "objectives", true);
	Game::Changed { talk, dropped }
}

/// A quest's recorded XP: the base reward when one was seen, else the log or turn-in values of
/// players near the quest's level. Each player gives one value: the highest its quest log showed,
/// and only without one the highest it was paid at the turn-in (a turn-in can carry a bonus of the
/// player's own: 4,532 paid where the quest log shows 4,400, #2585). The quest gets the lower
/// median of them, a value a player saw that one outlying player cannot move.
/// Another source's XP is replaced only on trusted evidence (`recorder:xp-<kind>`); otherwise the
/// recorded XP only fills a quest that has none (`recorder-gap:xp`).
fn resolve_xp(q: &V, list: &[(&'static str, i64, Option<i64>, usize)], contributors: &IndexSet<String>, min: usize) {
	let mut pick: Vec<&(&str, i64, Option<i64>, usize)> = list.iter().filter(|o| o.0 == "base").collect();
	if pick.is_empty() {
		let level = q.get("level");
		pick = list.iter().filter(|o| o.0 != "base" && (matches!(level, V::Null) || o.2.is_some_and(|l| (l as f64) <= level.num() + FULL_XP_LEVELS))).collect();
	}
	let rank = |kind: &str| u8::from(kind == "turnin");
	let mut per: IndexMap<usize, (&str, i64)> = IndexMap::new();
	for o in &pick {
		let best = per.entry(o.3).or_insert((o.0, o.1));
		if (rank(o.0), std::cmp::Reverse(o.1)) < (rank(best.0), std::cmp::Reverse(best.1)) {
			*best = (o.0, o.1);
		}
	}
	let who: IndexSet<String> = per.keys().map(|c| contributors[*c].clone()).collect();
	let tr = trusted(&who, min);
	if q.get("xp").as_num().is_some_and(|x| x > 0.0) && !tr {
		return;
	}
	let mut values: Vec<(&str, i64)> = per.into_values().collect();
	values.sort_by_key(|v| v.1);
	let Some(&(kind, xp)) = values.get(values.len().saturating_sub(1) / 2) else { return };
	q.set("xp", xp as f64);
	q.set("xpSamples", pick.len());
	add_source(q, &if tr { format!("recorder:xp-{kind}") } else { "recorder-gap:xp".to_string() });
}

/// The median: the middle value, or the mean of the two middle ones; NaN for none.
pub(crate) fn median(mut v: Vec<f64>) -> f64 {
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

/// Recorded parents and sides fill factions that have none (a parent that would form a cycle is
/// ignored); every faction recordings saw is written in canonical key order.
fn resolve_factions(factions: &Obj, seen: &IndexMap<i64, IndexSet<String>>, parents: &IndexMap<i64, i64>, sides: &FxHashMap<i64, String>) {
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
		if !key.parse::<i64>().is_ok_and(|id| seen.contains_key(&id)) {
			continue;
		}
		let f = factions.get(&key);
		if !f.get("side").truthy() {
			f.set("side", side_of(f.get("id").num() as i64));
		}
		factions.set_str(key, canonical(&f, &FACTION_KEYS));
	}
}

/// A recorded quest title that may vote: not empty, and none of the game's text tokens ($C, $R, $N:
/// the client fills them in for the player, some sessions record them raw: "A $C's Training").
fn plain_title(t: &str) -> bool {
	!t.is_empty() && !t.contains('$')
}

/// Applies the recordings that count over the tables (see the module doc); `min_voters` is
/// [`Recordings::min_voters`]. `corrections` (forever-db/corrections, already applied to the tables)
/// are put back afterwards ([`crate::corrections::reassert`]): a recording never overrides a
/// corrected value, whatever its evidence, and every field it disagreed on is in
/// [`Stats::overruled`]. `recordings` may be read as they are reached ([`SessionFiles::sessions`]):
/// each session is gone once applied. `drop_chances`: which recorded drop chances replace or fill
/// the sources' ([`DropChances`]).
pub fn apply_recordings<R: std::borrow::Borrow<Recording>>(
	db: &Db,
	recordings: impl IntoIterator<Item = R>,
	corrections: &V,
	min_voters: usize,
	so: SpawnOptions,
	live_maps: &dyn Fn(i64) -> bool,
	sim: bool,
	drop_chances: DropChances,
) -> Stats {
	let mut ov = Overlay {
		db,
		so,
		drop_chances,
		live_maps,
		min: min_voters,
		stats: Stats::default(),
		touched: IndexSet::new(),
		touched_entities: IndexMap::new(),
		quests: IndexMap::new(),
		objectives: IndexMap::new(),
		clients: IndexMap::new(),
		talked_to: FxHashSet::default(),
		names: IndexMap::new(),
		live: Default::default(),
		xp_seen: IndexMap::new(),
		factions_seen: IndexMap::new(),
		faction_parent: IndexMap::new(),
		faction_side: IndexMap::new(),
		windows: Default::default(),
		quest_loot: QuestLoot::default(),
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
		voter: LOCAL.to_string(),
		ci: 0,
		vouched: true,
		english: true,
		contributors: IndexSet::new(),
		who: FxHashMap::default(),
		filled: FxHashSet::default(),
	};
	for r in recordings {
		let r = r.borrow();
		ov.stats.recordings += 1;
		if !r.counts {
			continue;
		}
		let rec = &r.rec;
		ov.voter = r.voter();
		ov.ci = ov.contributors.insert_full(ov.voter.clone()).0;
		ov.vouched = vouched(&ov.voter);
		ov.english = r.english();
		let (who, lang) = (ov.voter.clone(), ov.lang());
		// Schema 2 has one `kill` per creature killed (schema 1's `slain`), with the objective it
		// ticked when it did.
		let schema2 = rec.get("schema").as_num() == Some(2.0);
		if ov.vouched {
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
		}
		ov.faction_dump(&rec.get("factions"));
		let mut session = Session::default();
		ov.quest_loot.begin(schema2);
		for ev in rec.get("events").items() {
			let Some(e) = ev.get("e").as_rc_str() else { continue };
			if !ev.truthy() {
				continue;
			}
			ov.stats.events += 1;
			let qid = pos_int(&ev.get("q"));
			let npc = pos_int(&ev.get("npc"));
			ov.client_event(&e, qid, npc, &ev, &mut session);
			ov.quest_loot.event(ov.ci, &ev);
			if &*e == "cast" {
				session.cast(&ev, db.gather_spells);
			}
			match (&*e, qid) {
				("accept", Some(qid)) => {
					if let Some(q) = ov.quest(qid) {
						if let Some(t) = ev.get("title").as_str().filter(|t| plain_title(t)) {
							q.title[lang].vote(V::str(t), &who);
						}
						if let Some(l) = pos_int(&ev.get("qlvl")) {
							q.level.vote(V::Num(l as f64), &who);
						}
						if let Some(n) = npc {
							q.giver("start", "npc", n, &who);
						}
						if let Some(o) = pos_int(&ev.get("object")) {
							q.giver("start", "object", o, &who);
						}
						if let Some(i) = pos_int(&ev.get("item")) {
							q.giver("start", "item", i, &who);
						}
						if let Some(c) = coord(&ev) {
							q.zone.vote(V::Num(c.map as f64), &who);
						}
						q.reward(&ev, 1, &who);
						ov.xp_obs(qid, "base", &ev.get("rewardXpBase"), &ev.get("lvl"));
						ov.xp_obs(qid, "log", &ev.get("rewardXp"), &ev.get("lvl"));
					}
					if let Some(n) = npc {
						ov.live_point("npc", n, &ev.get("npcName"), &ev);
					}
					if let Some(o) = pos_int(&ev.get("object")) {
						ov.live_point("object", o, &ev.get("objName"), &ev);
					}
				}
				("turnin", Some(qid)) => {
					if let Some(q) = ov.quest(qid) {
						if let Some(n) = npc {
							q.giver("end", "npc", n, &who);
						}
						if let Some(o) = pos_int(&ev.get("object")) {
							q.giver("end", "object", o, &who);
						}
						q.reward(&ev, 2, &who);
						ov.xp_obs(qid, "turnin", &ev.get("xpReward"), &ev.get("lvl"));
					}
					if let Some(n) = npc {
						ov.stats.npc_hand_ins.entry(qid).or_default().insert(n);
						ov.live_point("npc", n, &ev.get("npcName"), &ev);
					}
					if let Some(o) = pos_int(&ev.get("object")) {
						ov.live_point("object", o, &ev.get("objName"), &ev);
					}
				}
				("text", Some(qid)) => {
					if let Some(q) = ov.quest(qid) {
						if let Some(t) = ev.get("title").as_str().filter(|t| plain_title(t)) {
							q.title[lang].vote(V::str(t), &who);
						}
					}
				}
				("reward", Some(qid)) => {
					if ov.quest(qid).is_some() {
						ov.xp_obs(qid, "base", &ev.get("rewardXpBase"), &ev.get("lvl"));
						ov.xp_obs(qid, "log", &ev.get("rewardXp"), &ev.get("lvl"));
					}
				}
				("progress", Some(qid)) => {
					if ov.quest(qid).is_none() {
						continue;
					}
					let oi = pos_int(&ev.get("oi"));
					let p = ev.get("text").as_str().and_then(parse_progress_text);
					let (Some(oi), Some(p)) = (oi, p) else { continue };
					// A reputation line ("Neutral / Friendly Gelkis Clan Centaur: 1/1") is a standing the
					// quest requires, never work a step can do: it is no objective (#2585, 1382/1368/1385).
					if ev.get("type").as_str() == Some("reputation") {
						continue;
					}
					let kind = match ev.get("type").as_str() {
						Some("monster") => Some("kill"),
						Some("item") => Some("item"),
						Some("object") => Some("object"),
						_ if p.slain => Some("kill"),
						_ => None,
					};
					let english = ov.english;
					let s = ov.slot(qid, oi);
					if english {
						s.name.vote(V::from(p.name), &who);
					}
					let m = s.max.entry(who.clone()).or_insert(0.0);
					s.slain |= p.slain;
					*m = m.max(p.max);
					if let Some(k) = kind {
						s.kind.vote(V::str(k), &who);
					}
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
						// A loot tied to an item objective counts only when the quest's data has no
						// item objectives or names that item among them: recordings tied the wrong
						// item to about a fifth of their objective ticks (a window read after fast
						// loot had taken the quest item, so a lone other drop took its tick).
						let item_ids: Vec<f64> = if &*e == "loot" {
							db.quests.get(&q.to_string()).get("objectives").items().iter().filter(|o| o.get("type").as_str() == Some("item")).filter_map(|o| o.get("id").as_num()).collect()
						} else {
							Vec::new()
						};
						if db.quests.has(&q.to_string()) && (item_ids.is_empty() || item_ids.contains(&(id as f64))) {
							let s = ov.slot(q, oi);
							s.id.vote(V::Num(id as f64), &who);
							s.kind.vote(V::str(if &*e == "kill" { "kill" } else { "item" }), &who);
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
					if ov.handle_find(&ev, session.gathered(&ev)) {
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
						if ov.live_point("npc", n, &ev.get("npcName"), &ev) {
							if let Some(r) = role {
								ov.role(0, n, r);
							}
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
	ov.apply_names();
	// The game's own list first: a quest it settles keeps that structure, and the recorded
	// progress only fills its counts.
	let clients = std::mem::take(&mut ov.clients);
	let mut settled: FxHashSet<i64> = FxHashSet::default();
	for (&qid, c) in &clients {
		let q = db.quests.get(&qid.to_string());
		if !q.truthy() {
			continue;
		}
		match game_objectives(&q, c, &ov.talked_to) {
			Game::Kept => {}
			Game::Same => {
				settled.insert(qid);
			}
			Game::Conflict => ov.stats.objective_conflicts.push(qid),
			Game::Changed { talk, dropped } => {
				ov.stats.game_objective_quests += 1;
				ov.stats.talk_objectives += talk;
				ov.stats.dropped_objectives += dropped;
				ov.touched.insert(qid);
				settled.insert(qid);
			}
		}
	}
	let objectives = std::mem::take(&mut ov.objectives);
	for (qid, slots) in &objectives {
		let q = db.quests.get(&qid.to_string());
		if q.truthy() {
			merge_objectives(&q, slots, ov.min, settled.contains(qid));
			ov.touched.insert(*qid);
		}
	}
	for kind in ["npc", "object"] {
		let t = table_of(db, kind);
		let k = k_ix(kind);
		for (&id, by_map) in &ov.live[k] {
			let e = t.get(&id.to_string());
			for (&map, pts) in by_map {
				let r = reduce_spawns(pts, so);
				if r.pts.is_empty() {
					continue;
				}
				let cur = e.get("spawns").get(&map.to_string());
				if !cur.is_undef() && !ov.trusted_at(WHO_LIVE + k, id, map) {
					continue;
				}
				if cur.is_undef() {
					ov.filled.insert((k, id, map));
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
		if let Some(v) = ov.quests.get(&id) {
			ov.apply_quest(&q, v);
		}
		if let Some(list) = ov.xp_seen.get(&id) {
			resolve_xp(&q, list, &ov.contributors, ov.min);
		}
		db.quests.set(&id.to_string(), canonical(&q, &QUEST_KEYS));
	}
	ov.stats.touched_quests = ov.touched.len();
	let parents: IndexMap<i64, i64> = ov.faction_parent.iter().filter_map(|(&id, b)| b.best().map(|(p, _)| (id, p.num() as i64))).collect();
	let sides: FxHashMap<i64, String> = ov.faction_side.iter().filter_map(|(&id, b)| b.best().and_then(|(s, _)| s.as_str().map(|s| (id, s.to_string())))).collect();
	resolve_factions(db.factions, &ov.factions_seen, &parents, &sides);
	ov.stats.overruled = crate::corrections::reassert(corrections, db.quests, db.npcs, db.objects, db.items, sim);
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

	fn j(v: &V) -> String {
		stringify(v, None)
	}

	const A: &str = "aaaaaaaaaaaaaaaa";
	const B: &str = "bbbbbbbbbbbbbbbb";
	const C: &str = "cccccccccccccccc";

	/// A session of a player that counts.
	fn session(name: &str, contributor: &str, locale: &str, events: &[String]) -> Recording {
		let text = format!(r#"{{"schema":2,"session":"{name}","contributor":"{contributor}","locale":"{locale}","build":62345,"events":[{}],"maps":{{}}}}"#, events.join(","));
		Recording { file: format!("{name}.json"), rec: parse_json(&text).unwrap(), counts: true }
	}

	/// The same English evidence from each of `who`.
	fn from(who: &[&str], events: &[String]) -> Vec<Recording> {
		who.iter().enumerate().map(|(i, c)| session(&format!("s{i}"), c, "enUS", events)).collect()
	}

	struct Tables {
		quests: Obj,
		npcs: Obj,
		objects: Obj,
		items: Obj,
		zones: Obj,
		factions: Obj,
		instances: Obj,
		gather_spells: Vec<(i64, &'static str)>,
		quest_items: Vec<i64>,
	}

	impl Tables {
		fn new(quests: &str, npcs: &str, items: &str) -> Tables {
			Tables {
				quests: obj(quests),
				npcs: obj(npcs),
				objects: obj("{}"),
				items: obj(items),
				zones: obj("{}"),
				factions: obj("{}"),
				instances: obj("{}"),
				gather_spells: Vec::new(),
				quest_items: Vec::new(),
			}
		}

		fn apply(&self, recs: &[Recording]) -> Stats {
			let db = Db {
				quests: &self.quests,
				npcs: &self.npcs,
				objects: &self.objects,
				items: &self.items,
				zones: &self.zones,
				factions: &self.factions,
				instances: &self.instances,
				gather_spells: &self.gather_spells,
				quest_items: &self.quest_items,
			};
			apply_recordings(&db, recs, &V::obj(), MIN_VOTERS, DEFAULTS, &|_| false, false, DropChances::All)
		}

		fn quest(&self, id: &str) -> V {
			self.quests.get(id)
		}
	}

	const QUESTS: &str = r#"{
		"364":{"id":364,"title":"The Damned","level":3,"start":{"npc":[1568],"object":[],"item":[]},"end":{"npc":[1568],"object":[]},
			"objectives":[{"type":"kill","id":1501,"count":10,"text":"Mindless Zombie"},{"type":"kill","id":1502,"count":10,"text":"Wretched Zombie"}],
			"xp":400,"rewards":{"items":[],"choices":[6275,2654],"money":null},"source":["pfquest"]},
		"365":{"id":365,"title":null,"level":null,"start":{"npc":[],"object":[],"item":[]},"end":{"npc":[],"object":[]},"objectives":[],"xp":null,"source":["pfquest"]}}"#;
	const NPCS: &str = r#"{"1568":{"id":1568,"name":"Undertaker Mordo","spawns":{"1420":{"f":"q","pts":[[10,10]]}}},"1569":{"id":1569,"name":"Shadow Priest Sarvis","spawns":{}}}"#;

	/// A player's evidence against quest 364: a new title, level, giver, ender and reward, the
	/// objectives in the other order with Mindless Zombie's count `mindless`, and 450 XP.
	fn rewrite(mindless: u32) -> Vec<String> {
		vec![
			r#"{"t":1,"e":"text","q":364,"title":"The Damned (Forever)"}"#.into(),
			r#"{"t":2,"e":"accept","q":364,"qlvl":5,"npc":1569,"choices":[9999],"rewardXpBase":450,"lvl":3}"#.into(),
			r#"{"t":3,"e":"progress","q":364,"oi":1,"text":"Wretched Zombie slain: 1/12","type":"monster"}"#.into(),
			format!(r#"{{"t":4,"e":"progress","q":364,"oi":2,"text":"Mindless Zombie slain: 3/{mindless}","type":"monster"}}"#),
			r#"{"t":5,"e":"progress","q":364,"oi":3,"text":"Rotting Ghoul slain: 0/5","type":"monster"}"#.into(),
			r#"{"t":6,"e":"turnin","q":364,"npc":1569}"#.into(),
		]
	}

	const UNCHANGED: &str = r#"{"id":364,"title":"The Damned","level":3,"start":{"npc":[1568],"object":[],"item":[]},"end":{"npc":[1568],"object":[]},"objectives":[{"type":"kill","id":1501,"count":10,"text":"Mindless Zombie"},{"type":"kill","id":1502,"count":10,"text":"Wretched Zombie"}],"xp":400,"rewards":{"items":[],"choices":[6275,2654],"money":null},"source":["pfquest"]}"#;

	#[test]
	fn a_value_another_source_has_changes_only_on_three_players_or_vouched_evidence() {
		// One player who inflates a count, or two: nothing of the quest changes, not even its order.
		for who in [&[A][..], &[A, B]] {
			let t = Tables::new(QUESTS, NPCS, "{}");
			let mut recs = vec![session("a", A, "enUS", &rewrite(99))];
			recs.extend(who[1..].iter().map(|c| session(c, c, "enUS", &rewrite(10))));
			t.apply(&recs);
			assert_eq!(j(&t.quest("364")), j(&parse_json(UNCHANGED).unwrap()), "{who:?}");
		}
		// Three players (one of them inflating), a vouched-for file or the maintainer's own: replaced.
		let three = || {
			let mut v = vec![session("a", A, "enUS", &rewrite(99))];
			v.extend(from(&[B, C], &rewrite(10)));
			v
		};
		for (why, recs) in [("three players", three()), ("sent-alice", from(&["sent-alice"], &rewrite(10))), ("local", from(&[LOCAL], &rewrite(10)))] {
			let t = Tables::new(QUESTS, NPCS, "{}");
			t.apply(&recs);
			let q = t.quest("364");
			assert_eq!(q.get("title").as_str(), Some("The Damned (Forever)"), "{why}");
			assert_eq!(q.get("level").as_num(), Some(5.0), "{why}");
			assert_eq!(j(&q.get("start").get("npc")), "[1569,1568]", "{why}");
			assert_eq!(j(&q.get("end").get("npc")), "[1569,1568]", "{why}");
			assert_eq!(j(&q.get("rewards")), r#"{"items":[],"choices":[9999],"money":null}"#, "{why}");
			assert_eq!(q.get("xp").as_num(), Some(450.0), "{why}");
			// The recorded order, each player's own count and their median (99 is outvoted), and
			// the objective the other source lacked.
			assert_eq!(
				j(&q.get("objectives")),
				r#"[{"type":"kill","id":1502,"count":12,"text":"Wretched Zombie"},{"type":"kill","id":1501,"count":10,"text":"Mindless Zombie"},{"type":"kill","id":null,"count":5,"text":"Rotting Ghoul"}]"#,
				"{why}"
			);
			let src: Vec<String> = q.get("source").items().iter().map(V::to_js_string).collect();
			for tag in ["recorder:title", "recorder:level", "recorder:start", "recorder:end", "recorder:rewards", "recorder:objectives", "recorder:xp-base"] {
				assert!(src.iter().any(|s| s == tag), "{why}: {tag} in {src:?}");
			}
			assert!(!src.iter().any(|s| s == "recorder" || s.starts_with("recorder-gap")), "{why}: {src:?}");
		}
	}

	#[test]
	fn a_correction_stands_against_three_counted_players_and_their_disagreement_is_listed() {
		// forever-db corrections already applied to quest 364 (the build applies them before the
		// overlay): its level, giver, objectives and XP. Three counted players record other values for
		// those and for its title, ender and rewards.
		let corrections = parse_json(
			r#"{"quests":{"364":{"set":{"level":3,"start":{"npc":[1568],"object":[],"item":[]},
				"objectives":[{"type":"kill","id":1501,"count":10,"text":"Mindless Zombie"},{"type":"kill","id":1502,"count":10,"text":"Wretched Zombie"}],"xp":400},
				"source":{"kind":"in-game-check","ref":"test"}}}}"#,
		)
		.unwrap();
		let t = Tables::new(QUESTS, NPCS, "{}");
		let db = Db { quests: &t.quests, npcs: &t.npcs, objects: &t.objects, items: &t.items, zones: &t.zones, factions: &t.factions, instances: &t.instances, gather_spells: &[], quest_items: &[] };
		crate::corrections::apply(&corrections, &t.quests, &t.npcs, &t.objects, &t.items, false);
		let mut recs = vec![session("a", A, "enUS", &rewrite(10))];
		recs.extend(from(&[B, C], &rewrite(10)));
		let st = apply_recordings(&db, &recs, &corrections, MIN_VOTERS, DEFAULTS, &|_| false, false, DropChances::All);
		let q = t.quest("364");
		// Every corrected field stands.
		assert_eq!(q.get("level").as_num(), Some(3.0));
		assert_eq!(j(&q.get("start").get("npc")), "[1568]");
		assert_eq!(j(&q.get("objectives")), j(&corrections.get("quests").get("364").get("set").get("objectives")));
		assert_eq!(q.get("xp").as_num(), Some(400.0));
		// Fields no correction sets still take the trusted recordings.
		assert_eq!(q.get("title").as_str(), Some("The Damned (Forever)"));
		assert_eq!(j(&q.get("end").get("npc")), "[1569,1568]");
		assert_eq!(j(&q.get("rewards")), r#"{"items":[],"choices":[9999],"money":null}"#);
		// The disagreement is listed, and the overruled fields carry no recorder tag.
		assert_eq!(st.overruled, ["quests 364: level", "quests 364: start", "quests 364: objectives", "quests 364: xp"]);
		let src: Vec<String> = q.get("source").items().iter().map(V::to_js_string).collect();
		for gone in ["recorder:level", "recorder:start", "recorder:objectives", "recorder:xp-base"] {
			assert!(!src.iter().any(|s| s == gone), "{gone} in {src:?}");
		}
		for kept in ["recorder:title", "recorder:end", "recorder:rewards", "polestar-correction"] {
			assert!(src.iter().any(|s| s == kept), "{kept} not in {src:?}");
		}
	}

	#[test]
	fn one_counted_player_fills_gaps_and_an_uncounted_one_nothing() {
		let events: Vec<String> = vec![
			r#"{"t":1,"e":"text","q":365,"title":"Rise of the Dead"}"#.into(),
			r#"{"t":2,"e":"accept","q":365,"qlvl":4,"npc":1569,"choices":[1],"map":1420,"x":31,"y":66}"#.into(),
			r#"{"t":3,"e":"progress","q":365,"oi":1,"text":"Rotting Ghoul slain: 2/8","type":"monster"}"#.into(),
			r#"{"t":4,"e":"turnin","q":365,"npc":1569,"xpReward":300,"lvl":4}"#.into(),
		];
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(&[Recording { counts: false, ..session("n", B, "enUS", &events) }]);
		assert_eq!(j(&t.quest("365").get("title")), "null");
		assert_eq!(j(&t.npcs.get("1569").get("spawns")), "{}");
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(&from(&[A], &events));
		let q = t.quest("365");
		assert_eq!(q.get("title").as_str(), Some("Rise of the Dead"));
		assert_eq!(q.get("level").as_num(), Some(4.0));
		assert_eq!(q.get("zone").as_num(), Some(1420.0));
		assert_eq!(j(&q.get("start").get("npc")), "[1569]");
		assert_eq!(j(&q.get("end").get("npc")), "[1569]");
		assert_eq!(j(&q.get("objectives")), r#"[{"type":"kill","id":null,"count":8,"text":"Rotting Ghoul"}]"#);
		assert_eq!(q.get("xp").as_num(), Some(300.0));
		let src: Vec<String> = q.get("source").items().iter().map(V::to_js_string).collect();
		for tag in ["recorder-gap:title", "recorder-gap:level", "recorder-gap:start", "recorder-gap:objectives", "recorder-gap:rewards", "recorder-gap:xp"] {
			assert!(src.iter().any(|s| s == tag), "{tag} in {src:?}");
		}
		assert!(!src.iter().any(|s| s == "recorder" || s.starts_with("recorder:")), "{src:?}");
		assert_eq!(t.npcs.get("1569").get("spawns").get("1420").get("f").as_str(), Some("l"));
	}

	#[test]
	fn quests_npcs_items_and_factions_are_created_only_from_vouched_evidence() {
		let events: Vec<String> = vec![
			r#"{"t":1,"e":"accept","q":999,"title":"A Fake","npc":70001,"npcName":"Fake Warden","map":1420,"x":1,"y":1}"#.into(),
			r#"{"t":2,"e":"kill","npc":70002,"npcName":"Fake Wolf","cls":"normal"}"#.into(),
			r#"{"t":3,"e":"loot","item":80001,"itemName":"Fake Shard"}"#.into(),
			r#"{"t":4,"e":"rep","faction":2700,"factionName":"Fake Accord"}"#.into(),
		];
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(&from(&[A, B, C], &events));
		assert!(!t.quests.has("999") && !t.npcs.has("70001") && !t.npcs.has("70002") && !t.items.has("80001") && !t.factions.has("2700"));
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(&from(&["sent-alice"], &events));
		assert_eq!(t.quest("999").get("title").as_str(), Some("A Fake"));
		assert_eq!(j(&t.quest("999").get("source")), r#"["recorder"]"#);
		assert_eq!(t.npcs.get("70001").get("name").as_str(), Some("Fake Warden"));
		assert_eq!(t.npcs.get("70002").get("name").as_str(), Some("Fake Wolf"));
		assert_eq!(t.items.get("80001").get("name").as_str(), Some("Fake Shard"));
		assert_eq!(t.factions.get("2700").get("name").as_str(), Some("Fake Accord"));
	}

	#[test]
	fn a_fishing_pool_a_catch_names_is_a_fishing_object_where_it_was_fished() {
		let mut t = Tables::new(QUESTS, NPCS, "{}");
		t.objects = obj(r#"{"180582":{"id":180582,"name":"Oily Blackmouth School","spawns":{}}}"#);
		let catch = r#"{"t":1,"e":"drop","object":180582,"gather":"fish","items":[{"item":6358,"count":1}],"map":1413,"x":62.1,"y":45.3}"#;
		let open_water = r#"{"t":2,"e":"drop","gather":"fish","items":[{"item":6291,"count":1}],"map":1413,"x":62.1,"y":45.3}"#;
		t.apply(&from(&["sent-alice"], &[catch.into(), open_water.into()]));
		let pool = t.objects.get("180582");
		assert_eq!(j(&pool.get("roles")), r#"["fishing"]"#);
		assert_eq!(pool.get("spawns").get("1413").get("f").as_str(), Some("l"));
		assert_eq!(j(&t.items.get("6358").get("drops").get("object").get("180582")), "100");
	}

	// Forever's herb nodes (Briarthorn 657385) open with Cultivation (1312650), a cast the Recorder does not count
	// as gathering, so its loot window carries no `gather`: the window right after that cast is a herb's, never a
	// chest's (the Codex listed such herbs as treasures).
	#[test]
	fn a_node_gathered_with_a_cast_the_recorder_does_not_know_is_a_herb_never_a_chest() {
		let cast = r#"{"t":10,"e":"cast","spell":1312650,"map":1421,"x":50.1,"y":40.2}"#;
		let drop = r#"{"t":10.4,"e":"drop","object":657385,"items":[{"item":2450,"count":2}],"map":1421,"x":50.1,"y":40.2}"#;
		let late = r#"{"t":30,"e":"drop","object":657385,"items":[{"item":2450,"count":1}],"map":1421,"x":50.1,"y":40.2}"#;
		let roles = |events: &[&str]| {
			let mut t = Tables::new(QUESTS, NPCS, "{}");
			t.objects = obj(r#"{"657385":{"id":657385,"name":"Briarthorn","spawns":{}}}"#);
			t.gather_spells = vec![(1312650, "herb")];
			t.apply(&from(&["sent-alice"], &events.iter().map(|e| e.to_string()).collect::<Vec<_>>()));
			j(&t.objects.get("657385").get("roles"))
		};
		assert_eq!(roles(&[cast, drop]), r#"["herb"]"#);
		assert_eq!(roles(&[cast, drop, late]), r#"["chest","herb"]"#, "a later window with no cast before it is no gather");
		assert_eq!(roles(&[drop]), r#"["chest"]"#, "no cast before it");
	}

	// Mudsnout Blossom (1723) gives only its quest's item, of the client's Quest class: a quest's plant is no
	// treasure. A loot window that also holds something a player keeps (Copper Ore) is a chest's.
	#[test]
	fn a_loot_window_of_quest_items_only_makes_no_chest() {
		let mut t = Tables::new(QUESTS, NPCS, "{}");
		t.quest_items = vec![3502];
		t.objects = obj(r#"{"1723":{"id":1723,"name":"Mudsnout Blossom","spawns":{}},"2843":{"id":2843,"name":"Battered Chest","spawns":{}}}"#);
		let blossom = r#"{"t":1,"e":"drop","object":1723,"items":[{"item":3502,"count":1}],"map":1424,"x":30,"y":40}"#;
		let chest = r#"{"t":2,"e":"drop","object":2843,"items":[{"item":3502,"count":1},{"item":2770,"count":1}],"map":1424,"x":31,"y":40}"#;
		t.apply(&from(&["sent-alice"], &[blossom.into(), chest.into()]));
		assert!(t.objects.get("1723").get("roles").items().is_empty(), "{}", j(&t.objects.get("1723").get("roles")));
		assert_eq!(j(&t.objects.get("2843").get("roles")), r#"["chest"]"#);
	}

	#[test]
	fn names_from_a_non_english_client_only_fill_gaps() {
		let de =
			|q: i64, title: &str| -> Vec<String> { vec![format!(r#"{{"t":1,"e":"text","q":{q},"title":"{title}"}}"#), r#"{"t":2,"e":"gossip","npc":1568,"npcName":"Leichenbestatter Mordo"}"#.into()] };
		let t = Tables::new(QUESTS, NPCS, "{}");
		let recs: Vec<Recording> = [A, B, C].iter().map(|c| session(c, c, "deDE", &[de(364, "Die Verdammten"), de(365, "Erhebung")].concat())).collect();
		t.apply(&recs);
		assert_eq!(t.quest("364").get("title").as_str(), Some("The Damned"));
		assert_eq!(t.quest("365").get("title").as_str(), Some("Erhebung"));
		assert_eq!(t.npcs.get("1568").get("name").as_str(), Some("Undertaker Mordo"));
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(&from(&[A, B, C], &[r#"{"t":1,"e":"gossip","npc":1568,"npcName":"Undertaker Mordo (Forever)"}"#.into()]));
		assert_eq!(t.npcs.get("1568").get("name").as_str(), Some("Undertaker Mordo (Forever)"));
	}

	#[test]
	fn a_spawn_from_another_source_needs_three_players() {
		let accept = |npc: i64| format!(r#"{{"t":1,"e":"accept","q":364,"npc":{npc},"map":1420,"x":31,"y":66}}"#);
		let mordo = |recs: &[Recording]| {
			let t = Tables::new(QUESTS, NPCS, "{}");
			t.apply(recs);
			(t.npcs.get("1568").get("spawns").get("1420").get("f").as_str().map(str::to_owned), t.npcs.get("1569").get("spawns").get("1420").get("f").as_str().map(str::to_owned))
		};
		// One or two players: Mordo keeps the other source's spawn; Sarvis, without one, gets the recorded one.
		for who in [&[A][..], &[A, B], &[A, A, A]] {
			assert_eq!(mordo(&from(who, &[accept(1568), accept(1569)])), (Some("q".into()), Some("l".into())), "{who:?}");
		}
		// Three players, or the maintainer's own recording: replaced.
		for who in [&[A, B, C][..], &[LOCAL]] {
			let t = Tables::new(QUESTS, NPCS, "{}");
			t.apply(&from(who, &[accept(1568)]));
			assert_eq!(t.npcs.get("1568").get("spawns").get("1420").get("f").as_str(), Some("l"), "{who:?}");
			assert_eq!(t.npcs.get("1568").get("spawns").get("1420").get("pts").items()[0].num_at(0), 31.0);
		}
	}

	#[test]
	fn rare_sightings_become_the_centres_of_places_no_other_source_knows() {
		// #2816: a sighting is where the player stood (the nameplate showed, the cursor met it), all
		// round the rare. Rare 2 has a spawn from another source at 10,10: three players see it from
		// three sides of it and three see it from round 40,40, a place the source lacks. Rare 3 has no
		// spawn: four sightings round 60,60.
		let npcs = r#"{"2":{"id":2,"name":"Old Rare","spawns":{"1420":{"f":"q","pts":[[10,10]]}}},"3":{"id":3,"name":"New Rare","spawns":{}}}"#;
		let seen = |npc: i64, pts: &[(f64, f64)]| -> Vec<String> {
			pts.iter().enumerate().map(|(i, (x, y))| format!(r#"{{"t":{i},"e":"rare","npc":{npc},"npcLvl":30,"cls":"rare","src":"p","map":1420,"x":{x},"y":{y}}}"#)).collect()
		};
		let mut evs = seen(2, &[(10.8, 10.3), (9.4, 9.6), (10.2, 11.1), (40.6, 40.2), (39.5, 40.4), (40.2, 39.4)]);
		evs.extend(seen(3, &[(61.0, 60.0), (59.0, 60.0), (60.0, 61.2), (60.0, 58.8)]));
		let t = Tables::new(QUESTS, npcs, "{}");
		t.apply(&from(&[A, B, C], &evs));
		let pts = |id: &str| t.npcs.get(id).get("spawns").get("1420").get("pts").items().iter().map(|p| (p.num_at(0), p.num_at(1))).collect::<Vec<_>>();
		assert_eq!(pts("2"), [(10.0, 10.0), (40.1, 40.0)], "the source's spawn, and one place for the sightings away from it");
		assert_eq!(pts("3"), [(60.0, 60.0)], "one place, at the sightings' centre");
	}

	#[test]
	fn a_world_boss_sighting_gives_no_spawn_points_and_no_rare_role_2894() {
		// #2894 (Emi): Ragefire Chasm's pick-up guide sent the hand-in to Thrall (4949) to 39.70,61.00 in
		// Orgrimmar, outside his throne room: a spot players stood on when his nameplate showed. The Recorder
		// logs world bosses as `rare` sightings (class worldboss); they are no rares. Three players see him
		// from three far spots: his spawn stays the other source's, and he gets no rare role. A true rare's
		// vignette sighting with no class still counts by the data's rank.
		let npcs = r#"{"4949":{"id":4949,"name":"Thrall","rank":3,"spawns":{"1454":{"f":"l","pts":[[31.9,37.8]]}}},"5":{"id":5,"name":"Old Rare","rank":4,"spawns":{}}}"#;
		let seen = |npc: i64, cls: &str, pts: &[(f64, f64)]| -> Vec<String> {
			pts.iter().enumerate().map(|(i, (x, y))| format!(r#"{{"t":{i},"e":"rare","npc":{npc}{cls},"src":"p","map":1454,"x":{x},"y":{y}}}"#)).collect()
		};
		let mut evs = seen(4949, r#","npcLvl":63,"cls":"worldboss""#, &[(39.7, 61.0), (45.2, 52.1), (50.3, 70.4)]);
		evs.extend(seen(5, "", &[(20.0, 20.0)]));
		let t = Tables::new(QUESTS, npcs, "{}");
		t.apply(&from(&[A, B, C], &evs));
		let thrall = t.npcs.get("4949");
		assert_eq!(j(&thrall.get("spawns")), r#"{"1454":{"f":"l","pts":[[31.9,37.8]]}}"#, "the throne room only");
		assert!(!thrall.get("roles").items().iter().any(|r| r.as_str() == Some("rare")), "no rare role: {}", j(&thrall.get("roles")));
		assert_eq!(j(&t.npcs.get("5").get("spawns").get("1454").get("pts")), "[[20,20]]", "a rare by its rank");
	}

	/// `n` kills of `npc`, each looted, `drops` of the loot windows holding `item`.
	fn loot(npc: i64, item: i64, n: usize, drops: usize) -> Vec<String> {
		(0..n)
			.flat_map(|i| {
				let items = if i < drops { format!(r#"{{"item":{item},"count":1}}"#) } else { String::new() };
				[format!(r#"{{"t":{i},"e":"kill","npc":{npc},"cls":"normal"}}"#), format!(r#"{{"t":{i},"e":"drop","npc":{npc},"items":[{items}]}}"#)]
			})
			.collect()
	}

	const LINEN: &str = r#"{"2589":{"id":2589,"name":"Linen Cloth","drops":{"npc":{"1501":5},"object":{}},"vendors":[]}}"#;
	const ZOMBIE: &str = r#"{"1501":{"id":1501,"name":"Mindless Zombie","spawns":{}}}"#;

	#[test]
	fn a_drop_chance_from_another_source_needs_three_players_with_enough_loot_windows() {
		let chance = |recs: &[Recording]| {
			let t = Tables::new("{}", ZOMBIE, LINEN);
			t.apply(recs);
			t.items.get("2589").get("drops").get("npc").get("1501").as_num()
		};
		assert_eq!(chance(&from(&[A], &loot(1501, 2589, 12, 12))), Some(5.0));
		assert_eq!(chance(&from(&[A, B], &loot(1501, 2589, 12, 12))), Some(5.0));
		// Three players, each under MIN_WINDOWS of their own: not trusted, however many windows together.
		assert_eq!(chance(&from(&[A, B, C], &loot(1501, 2589, 6, 6))), Some(5.0));
		assert_eq!(chance(&from(&[A, B, C], &loot(1501, 2589, 12, 12))), Some(100.0));
	}

	#[test]
	fn with_drop_chances_off_the_sources_chances_stand() {
		// #2585/#2747: loot-window chances read 1.2-3x high, so the data build passes them by: three
		// trusted players looting 12 of 12 leave Linen at its source's 5%, and fill no gap.
		fn db_of(t: &Tables) -> Db<'_> {
			Db { quests: &t.quests, npcs: &t.npcs, objects: &t.objects, items: &t.items, zones: &t.zones, factions: &t.factions, instances: &t.instances, gather_spells: &[], quest_items: &[] }
		}
		let recs = from(&[A, B, C], &loot(1501, 2589, 12, 12));
		let t = Tables::new("{}", ZOMBIE, LINEN);
		let st = apply_recordings(&db_of(&t), &recs, &V::obj(), MIN_VOTERS, DEFAULTS, &|_| false, false, DropChances::Off);
		assert_eq!(t.items.get("2589").get("drops").get("npc").get("1501").as_num(), Some(5.0));
		assert!(t.items.get("2589").get("seen").is_undef());
		assert_eq!(st.recorded_drop_chances, 0);
		let t = Tables::new("{}", ZOMBIE, r#"{"2589":{"id":2589,"name":"Linen Cloth","drops":{"npc":{},"object":{}},"vendors":[]}}"#);
		apply_recordings(&db_of(&t), &recs, &V::obj(), MIN_VOTERS, DEFAULTS, &|_| false, false, DropChances::Off);
		assert!(t.items.get("2589").get("drops").get("npc").get("1501").is_undef());
	}

	#[test]
	fn the_median_resists_one_outlier_player() {
		let xp = |q: i64, v: i64| format!(r#"{{"t":1,"e":"accept","q":{q},"rewardXpBase":{v},"lvl":3}}"#);
		// Two players see 10% and 20% in 20 kills each and 450 XP; a third farms 400 kills at
		// 100% and claims 9999 XP. Pooled the chance would be 81.8%; the median is 20%.
		let player = |c: &str, n: usize, d: usize, x: i64| {
			let mut events = loot(1501, 2589, n, d);
			events.push(xp(364, x));
			events.push(xp(365, x));
			session(c, c, "enUS", &events)
		};
		let t = Tables::new(QUESTS, ZOMBIE, LINEN);
		t.apply(&[player(A, 20, 2, 450), player(B, 20, 4, 450), player(C, 400, 400, 9999)]);
		assert_eq!(t.items.get("2589").get("drops").get("npc").get("1501").as_num(), Some(20.0));
		assert_eq!(t.items.get("2589").get("seen").get("npc").get("1501").get("of").as_num(), Some(440.0));
		assert_eq!(t.quest("364").get("xp").as_num(), Some(450.0));
		// Two players fill only gaps: an item without the source's chance, a quest without XP (the
		// lower of the two: a value a player saw).
		let t = Tables::new(QUESTS, ZOMBIE, r#"{"2589":{"id":2589,"name":"Linen Cloth","drops":{"npc":{},"object":{}},"vendors":[]}}"#);
		t.apply(&[player(A, 20, 2, 450), player(C, 400, 400, 9999)]);
		assert_eq!(t.items.get("2589").get("drops").get("npc").get("1501").as_num(), Some(55.0));
		assert_eq!(t.quest("364").get("xp").as_num(), Some(400.0));
		assert_eq!(t.quest("365").get("xp").as_num(), Some(450.0));
	}

	/// A session pulled from the server: its contributor's first-seen time, chunk count and upload
	/// days as forge record pull writes them, `days` before the session arrived.
	fn pulled(name: &str, contributor: &str, install: &str, days: f64, chunks: u64, upload_days: u64, events: &[String]) -> Recording {
		let received = 1_800_000_000.0;
		let since = received - days * 86400.0;
		let text = format!(
			r#"{{"schema":2,"session":"{name}","contributor":"{contributor}","install":"{install}","contributorSince":{since},"contributorChunks":{chunks},"uploadDays":{upload_days},"received":{received},"locale":"enUS","build":62345,"events":[{}],"maps":{{}}}}"#,
			events.join(",")
		);
		Recording { file: format!("{name}.json"), rec: parse_json(&text).unwrap(), counts: false }
	}

	/// An established pulled session (30 days, 500 chunks on 3 upload days).
	fn old(name: &str, contributor: &str, events: &[String]) -> Recording {
		pulled(name, contributor, name, 30.0, 500, 3, events)
	}

	fn in_cohort(r: Recording, cohort: &str) -> Recording {
		r.rec.set("cohort", cohort);
		r
	}

	/// A contributor's play: `pos` positions and `kills` kills in one session.
	fn played(contributor: &str, pos: usize, kills: usize) -> Recording {
		let events: Vec<String> = (0..pos).map(|i| format!(r#"{{"t":{i},"e":"pos","map":1420,"x":1,"y":1}}"#)).chain((0..kills).map(|i| format!(r#"{{"t":{i},"e":"kill"}}"#))).collect();
		let text = format!(r#"{{"schema":2,"session":"{contributor}-play","contributor":"{contributor}","install":"play","locale":"enUS","build":62345,"events":[{}],"maps":{{}}}}"#, events.join(","));
		Recording { file: format!("{contributor}-play.json"), rec: parse_json(&text).unwrap(), counts: false }
	}

	/// [`played`] enough to be established.
	fn play(contributor: &str) -> Recording {
		played(contributor, 10, 5)
	}

	const ACCEPT_MORDO: &str = r#"{"t":1,"e":"accept","q":364,"npc":1568,"map":1420,"x":31,"y":66}"#;

	/// Mordo's spawn flag after [`establish`] and the overlay: `q` kept, `l` replaced.
	fn mordo(recs: &mut [Recording]) -> Option<String> {
		establish(recs, ESTABLISH);
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(recs);
		t.npcs.get("1568").get("spawns").get("1420").get("f").as_str().map(str::to_owned)
	}

	fn mordo_by(b: Vec<Recording>) -> (Option<String>, bool) {
		let mut recs = vec![old("a", A, &[ACCEPT_MORDO.into()]), old("c", C, &[ACCEPT_MORDO.into()]), play(A), play(C)];
		let n = recs.len();
		recs.extend(b);
		let f = mordo(&mut recs);
		(f, recs[n].counts)
	}

	#[test]
	fn a_contributor_counts_only_once_the_server_has_seen_enough_of_it() {
		let accept = || vec![ACCEPT_MORDO.to_string()];
		// b registered a day ago, sent too little, or on too few days: Mordo keeps the other source's spawn.
		for (why, pb) in
			[("a day", pulled("b", B, "ib", 1.0, 50, 3, &accept())), ("5 chunks", pulled("b", B, "ib", 10.0, 5, 3, &accept())), ("2 upload days", pulled("b", B, "ib", 10.0, 50, 2, &accept()))]
		{
			assert_eq!(mordo_by(vec![pb, play(B)]), (Some("q".into()), false), "{why}");
		}
		// Sessions dated over many days by the client don't stand in for the server's upload days.
		let dated = pulled("b", B, "ib", 10.0, 50, 1, &accept());
		dated.rec.set("started", 1_790_000_000.0);
		dated.rec.set("ended", 1_799_000_000.0);
		assert_eq!(mordo_by(vec![dated, play(B)]), (Some("q".into()), false));
		// No positions or no kills.
		for (why, p) in [("no positions", played(B, 0, 5)), ("no kills", played(B, 10, 0))] {
			assert_eq!(mordo_by(vec![old("b", B, &accept()), p]), (Some("q".into()), false), "{why}");
		}
		// Established: its earliest first-seen, its largest chunk count and upload days, over all its sessions.
		assert_eq!(mordo_by(vec![pulled("b1", B, "ib", 10.0, 5, 1, &[]), pulled("b2", B, "ib", 1.0, 30, 3, &accept()), play(B)]), (Some("l".into()), true));
		// A file the maintainer vouched for and the maintainer's own count, and are trusted, alone; a
		// sent-in file nobody vouched for never counts.
		let sent = |c: &str| Recording { counts: false, ..session("s", c, "enUS", &accept()) };
		assert_eq!(mordo(&mut [sent("sent-alice")]).as_deref(), Some("l"));
		assert_eq!(mordo(&mut [sent(LOCAL)]).as_deref(), Some("l"));
		let mut recs = [sent("anon-0123456789abcdef")];
		assert_eq!(mordo(&mut recs).as_deref(), Some("q"));
		assert!(!recs[0].counts);
	}

	#[test]
	fn contributors_of_one_cohort_count_as_one_player() {
		let recs = |cohorts: [Option<&str>; 3]| {
			let mut v = Vec::new();
			for (c, cohort) in [A, B, C].into_iter().zip(cohorts) {
				for r in [old(c, c, &[ACCEPT_MORDO.into()]), play(c)] {
					v.push(match cohort {
						Some(k) => in_cohort(r, k),
						None => r,
					});
				}
			}
			v
		};
		// Two of three established contributors registered from one network: two players.
		let mut v = recs([Some("0000000000000001"), Some("0000000000000001"), Some("0000000000000002")]);
		assert_eq!(mordo(&mut v).as_deref(), Some("q"));
		assert!(v.iter().all(|r| r.counts));
		// Three cohorts, or one pulled before cohorts were exported (it counts as its contributor): three.
		for c in [[Some("0000000000000001"), Some("0000000000000002"), Some("0000000000000003")], [Some("0000000000000001"), Some("0000000000000002"), None]] {
			let mut v = recs(c);
			assert_eq!(mordo(&mut v).as_deref(), Some("l"), "{c:?}");
		}
		// A contributor is one player across all its sessions: b's older session with another
		// cohort (or none) takes the cohort of its latest one.
		for b_old in [Some("0000000000000009"), None] {
			let mut v = recs([Some("0000000000000001"), None, Some("0000000000000003")]);
			v.retain(|r| r.contributor() != B || r.file.contains("play"));
			let early = old("b-old", B, &[ACCEPT_MORDO.into()]);
			early.rec.set("received", 1_700_000_000.0);
			v.push(match b_old {
				Some(k) => in_cohort(early, k),
				None => early,
			});
			v.push(in_cohort(old("b-new", B, &[]), "0000000000000001"));
			assert_eq!(mordo(&mut v).as_deref(), Some("q"), "{b_old:?}");
			assert!(v.iter().filter(|r| r.contributor() == B).all(|r| r.voter() == "cohort:0000000000000001"));
		}
		// A cohort counts once any of its contributors is established.
		let mut v = vec![in_cohort(old("a", A, &[]), "0000000000000003"), in_cohort(pulled("b", B, "ib", 1.0, 1, 1, &[]), "0000000000000003"), in_cohort(play(A), "0000000000000003")];
		establish(&mut v, ESTABLISH);
		assert!(v.iter().all(|r| r.counts));
	}

	#[test]
	fn one_contributor_with_many_installs_counts_once() {
		let npcs = r#"{"1501":{"id":1501,"name":"Mindless Zombie","spawns":{}},"1568":{"id":1568,"name":"Undertaker Mordo","spawns":{"1420":{"f":"q","pts":[[10,10]]}}}}"#;
		let mut recs: Vec<Recording> = (0..5)
			.map(|i| {
				let mut events = loot(1501, 2589, 40, 40);
				events.push(ACCEPT_MORDO.into());
				pulled(&format!("a{i}"), A, &format!("install{i}"), 30.0, 500, 3, &events)
			})
			.chain([play(A)])
			.collect();
		establish(&mut recs, ESTABLISH);
		assert!(recs.iter().all(|r| r.counts));
		let t = Tables::new(QUESTS, npcs, LINEN);
		t.apply(&recs);
		assert_eq!(t.npcs.get("1568").get("spawns").get("1420").get("f").as_str(), Some("q"), "one player's spawn, however many installs");
		assert_eq!(t.items.get("2589").get("drops").get("npc").get("1501").as_num(), Some(5.0), "one player's drop chance, however many installs");
	}

	#[test]
	fn a_line_naming_an_objective_and_what_is_done_to_it_is_that_objective() {
		// Alther's Mill 98386 (#2585): the game's line "Tarantula Egg destroyed: 6/6" is the data's
		// Tarantula Egg objective; it was added as a third line, a kill no step works. "Mindless Zombie
		// Lord" is a longer name, not the Mindless Zombie.
		let tick = |text: &str| vec![format!(r#"{{"t":3,"e":"progress","q":364,"oi":1,"text":"{text}: 6/6","type":"monster"}}"#)];
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(&from(&[A, B, C], &tick("Mindless Zombie destroyed")));
		let q = t.quest("364");
		assert_eq!(q.get("objectives").len(), 2, "matched, not added");
		assert_eq!(q.get("objectives").items()[0].get("count").num(), 6.0);
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(&from(&[A, B, C], &tick("Mindless Zombie Lord slain")));
		assert_eq!(t.quest("364").get("objectives").len(), 3, "a longer name is another line");
	}

	#[test]
	fn a_reputation_line_is_never_an_objective() {
		// Strange Alliance 1382 (#2585): "Neutral / Friendly Gelkis Clan Centaur: 1/1" is a standing the
		// quest requires; it was added as an event objective no step can work.
		let line = vec![r#"{"t":3,"e":"progress","q":365,"oi":1,"text":"Neutral / Friendly Gelkis Clan Centaur: 1/1","type":"reputation"}"#.to_string()];
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(&from(&[A, B, C], &line));
		assert_eq!(t.quest("365").get("objectives").len(), 0);
	}

	#[test]
	fn a_line_credited_to_nothing_is_never_added_beside_a_quests_objectives() {
		// Finding the Source 974 (#2585): its "Find the hottest area" line ticks on a hidden credit with
		// no creature; three players' line joined the hot spot object as a kill nobody can target, and
		// the route model dropped the quest and its chain (Meet at the Grave 3912: the same line alone).
		let line = vec![r#"{"t":3,"e":"progress","q":364,"oi":1,"text":"Find the hottest area: 1/1","type":"monster"}"#.to_string()];
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(&from(&[A, B, C], &line));
		assert_eq!(t.quest("364").get("objectives").len(), 2, "the two zombie lines only");
		let gap = vec![r#"{"t":3,"e":"progress","q":365,"oi":1,"text":"Find the hottest area: 1/1","type":"monster"}"#.to_string()];
		let t = Tables::new(QUESTS, NPCS, "{}");
		t.apply(&from(&[A, B, C], &gap));
		assert_eq!(t.quest("365").get("objectives").len(), 0, "nor alone");
	}

	#[test]
	fn a_recorded_title_with_the_games_text_tokens_never_replaces_the_title() {
		// #2585: some sessions record a class quest's title raw ("A $C's Training"); players would
		// see "$C". Three players' raw titles leave the title alone; a plain one still replaces it.
		let title = |t: &str| vec![format!(r#"{{"t":1,"e":"text","q":364,"title":"{t}"}}"#)];
		let after = |t: &str| {
			let mut recs: Vec<Recording> = [old("a", A, &title(t)), old("b", B, &title(t)), old("c", C, &title(t))].into_iter().chain([play(A), play(B), play(C)]).collect();
			establish(&mut recs, ESTABLISH);
			let tb = Tables::new(QUESTS, "{}", "{}");
			tb.apply(&recs);
			tb.quest("364").get("title").as_str().map(str::to_string)
		};
		assert_eq!(after("The $C of the Damned").as_deref(), Some("The Damned"));
		assert_eq!(after("The Damned (Forever)").as_deref(), Some("The Damned (Forever)"));
	}

	#[test]
	fn quest_xp_is_what_the_quest_log_shows_not_a_players_bonus_at_the_turn_in() {
		// #2585: most players are paid 3% over the quest's reward at the turn-in (a bonus of their
		// own); the log at the accept shows the quest's reward. A player seen only at the turn-in
		// still counts with that value.
		let both = vec![r#"{"t":1,"e":"accept","q":364,"rewardXp":440,"lvl":3}"#.to_string(), r#"{"t":2,"e":"turnin","q":364,"xpReward":453,"lvl":3}"#.to_string()];
		let turnin_only = vec![r#"{"t":2,"e":"turnin","q":364,"xpReward":453,"lvl":3}"#.to_string()];
		let xp = |recs: Vec<Recording>| {
			let mut recs: Vec<Recording> = recs.into_iter().chain([play(A), play(B), play(C)]).collect();
			establish(&mut recs, ESTABLISH);
			let t = Tables::new(QUESTS, "{}", "{}");
			t.apply(&recs);
			t.quest("364").get("xp").as_num()
		};
		assert_eq!(xp(vec![old("a", A, &both), old("b", B, &both), old("c", C, &both)]), Some(440.0));
		assert_eq!(xp(vec![old("a", A, &turnin_only), old("b", B, &turnin_only), old("c", C, &turnin_only)]), Some(453.0));
	}

	#[test]
	fn quest_xp_from_another_source_needs_three_counted_players() {
		let xp = |q: i64| vec![format!(r#"{{"t":1,"e":"accept","q":{q},"rewardXpBase":450,"lvl":3}}"#)];
		let after = |q: i64, recs: Vec<Recording>| {
			let mut recs: Vec<Recording> = recs.into_iter().chain([play(A), play(B), play(C)]).collect();
			establish(&mut recs, ESTABLISH);
			let t = Tables::new(QUESTS, "{}", "{}");
			t.apply(&recs);
			t.quest(&q.to_string()).get("xp").as_num()
		};
		// One player, the same player on two installs, or three where one is new: kept.
		assert_eq!(after(364, vec![old("a", A, &xp(364))]), Some(400.0));
		assert_eq!(after(364, vec![old("a", A, &xp(364)), old("a2", A, &xp(364))]), Some(400.0));
		assert_eq!(after(364, vec![old("a", A, &xp(364)), old("b", B, &xp(364)), pulled("c", C, "ic", 1.0, 50, 1, &xp(364))]), Some(400.0));
		// Three established players, or the maintainer's own: replaced.
		assert_eq!(after(364, vec![old("a", A, &xp(364)), old("b", B, &xp(364)), old("c", C, &xp(364))]), Some(450.0));
		assert_eq!(after(364, vec![session("m", LOCAL, "enUS", &xp(364))]), Some(450.0));
		// A quest without XP: a single established player fills it, a new one doesn't.
		assert_eq!(after(365, vec![old("a", A, &xp(365))]), Some(450.0));
		assert_eq!(after(365, vec![pulled("b", B, "ib", 1.0, 5, 1, &xp(365))]), None);
	}

	#[test]
	fn contributors_the_audit_excludes_never_count_nor_lift_their_cohort() {
		let dir = std::env::temp_dir().join(format!("forge-data-recordings-exclude-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&dir);
		std::fs::create_dir_all(&dir).unwrap();
		// A and B are established; C (B's cohort-mate) is not on its own record.
		let recs =
			[old("a", A, &[]), play(A), in_cohort(old("b", B, &[]), "beefbeefbeefbeef"), in_cohort(play(B), "beefbeefbeefbeef"), in_cohort(pulled("c", C, "ic", 1.0, 5, 1, &[]), "beefbeefbeefbeef")];
		for r in &recs {
			std::fs::write(dir.join(&r.file), stringify(&r.rec, None)).unwrap();
		}
		let counts = |dir: &Path| -> Vec<(String, bool)> { read_recordings(dir).unwrap().iter().map(|r| (r.file.clone(), r.counts)).collect() };
		assert!(counts(&dir).iter().all(|(_, c)| *c), "without the audit, C counts through B's cohort");
		std::fs::write(dir.join("config.json"), format!(r#"{{"exclude":["{B}"]}}"#)).unwrap();
		let after = counts(&dir);
		assert_eq!(after.len(), 5, "excluded sessions are still read (the record report sees them), only never counted");
		for (f, c) in &after {
			assert_eq!(*c, f.contains(A) || f == "a.json", "{f}");
		}
		std::fs::remove_dir_all(&dir).unwrap();
	}

	#[test]
	fn the_build_reads_a_recordings_folder_one_session_at_a_time_as_it_reads_it_whole() {
		// #2585: the release data build reads the whole archive, too big to hold, through
		// scan_recordings: the same sessions, the same who-counts, the same overlay and revision.
		let dir = std::env::temp_dir().join(format!("forge-data-recordings-stream-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&dir);
		std::fs::create_dir_all(&dir).unwrap();
		const D: &str = "dddddddddddddddd";
		let xp = vec![r#"{"t":1,"e":"accept","q":364,"rewardXpBase":450,"lvl":3}"#.to_string()];
		let recs = [old("a", A, &xp), play(A), old("b", B, &xp), in_cohort(old("c", C, &xp), "beefbeefbeefbeef"), old("d", D, &xp)];
		for r in &recs {
			std::fs::write(dir.join(&r.file), stringify(&r.rec, None)).unwrap();
		}
		std::fs::write(dir.join("config.json"), format!(r#"{{"exclude":["{D}"]}}"#)).unwrap();
		let whole = read_recordings(&dir).unwrap();
		let scan = scan_recordings(&dir).unwrap();
		assert_eq!((scan.len(), scan.counted(), scan.min_voters), (whole.len(), whole.iter().filter(|r| r.counts).count(), whole.min_voters));
		assert_eq!(scan.names().collect::<Vec<_>>(), whole.iter().map(|r| r.file.as_str()).collect::<Vec<_>>());
		let (t1, t2) = (Tables::new(QUESTS, "{}", "{}"), Tables::new(QUESTS, "{}", "{}"));
		let s1 = t1.apply(&whole);
		let db =
			Db { quests: &t2.quests, npcs: &t2.npcs, objects: &t2.objects, items: &t2.items, zones: &t2.zones, factions: &t2.factions, instances: &t2.instances, gather_spells: &[], quest_items: &[] };
		let mut rev = Revision::default();
		let s2 = apply_recordings(
			&db,
			scan.sessions().map(|r| {
				let r = r.unwrap();
				rev.add(&r);
				r
			}),
			&V::obj(),
			MIN_VOTERS,
			DEFAULTS,
			&|_| false,
			false,
			DropChances::All,
		);
		assert_eq!((s1.recordings, s1.events), (s2.recordings, s2.events));
		assert_eq!(stringify(&t1.quest("364"), None), stringify(&t2.quest("364"), None));
		assert_eq!(rev.finish(), revision(&whole));
		std::fs::remove_dir_all(&dir).unwrap();
	}

	#[test]
	fn sessions_of_builds_older_than_min_build_are_left_out_and_the_quorum_is_configurable() {
		let dir = std::env::temp_dir().join(format!("forge-data-recordings-min-build-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&dir);
		std::fs::create_dir_all(&dir).unwrap();
		assert_eq!(read_recordings(&dir).unwrap().min_voters, MIN_VOTERS);
		std::fs::write(dir.join("config.json"), r#"{"minBuild":62000,"minVoters":4}"#).unwrap();
		std::fs::write(dir.join(".pull-state.json"), r#"{"after":5}"#).unwrap();
		std::fs::write(dir.join("old.json"), r#"{"schema":2,"build":61000,"events":[]}"#).unwrap();
		std::fs::write(dir.join("new.json"), r#"{"schema":2,"build":62345,"events":[]}"#).unwrap();
		std::fs::write(dir.join("v1.json"), r#"{"schema":1,"events":[]}"#).unwrap();
		let recs = read_recordings(&dir).unwrap();
		assert_eq!(recs.min_voters, 4);
		let files: Vec<&str> = recs.iter().map(|r| r.file.as_str()).collect();
		assert_eq!(files, vec!["new.json", "v1.json"]);
		std::fs::remove_dir_all(&dir).unwrap();
		let voters = |v: &[&str]| v.iter().map(|s| s.to_string()).collect::<IndexSet<String>>();
		assert!(!trusted(&voters(&[A, B, C]), 4) && trusted(&voters(&[A, B, C]), 3) && trusted(&voters(&["sent-x"]), 4));
	}

	// Desperate Times (#859): the data counts talking to Valennia, Ayessa and Elaadrin as three kills;
	// the game lists one line at the accept and reveals the next as each talk counts.
	const TIMES: &str = r#"{
		"92640":{"id":92640,"title":"Desperate Times","races":null,"objectives":[{"type":"kill","id":252383,"count":null,"text":"Valennia Stormfist"},{"type":"kill","id":251968,"count":null,"text":"Ayessa Dawnsinger"},{"type":"kill","id":252475,"count":null,"text":"Elaadrin Evengale"}],"source":["questie-forever"]},
		"96897":{"id":96897,"title":"The Cult of the Damned","races":8589934770,"objectives":[{"type":"kill","id":267006,"count":8,"text":"Dark Neophyte"},{"type":"kill","id":275437,"count":8,"text":"Dark Enforcer"},{"type":"kill","id":1547,"count":null,"text":"Decrepit Darkhound"}],"source":["questie-forever"]},
		"93461":{"id":93461,"title":"Welcome to Shen'dar Village","races":4294967373,"objectives":[{"type":"kill","id":251903,"count":null,"text":"Rathiril Sunlance"},{"type":"kill","id":254089,"count":null,"text":"Coriella Calmbreeze"}],"source":["questie-forever"]},
		"93927":{"id":93927,"title":"A Last Request","races":null,"objectives":[{"type":"kill","id":256966,"count":null,"text":"Skypriest Aanders"},{"type":"item","id":254871,"count":null,"text":"Bloody Note"}],"source":["questie-forever"]},
		"96626":{"id":96626,"title":"Camping 101: Cooking","races":null,"objectives":[{"type":"kill","id":1430,"count":null,"text":"Tomas"}],"source":["questie-forever"]},
		"98067":{"id":98067,"title":"Eyes of the Sentinels","races":null,"objectives":[{"type":"kill","id":270419,"count":null,"text":"Credit"}],"source":["questie-forever"]}}"#;
	const TIMES_NPCS: &str = r#"{
		"252383":{"id":252383,"name":"Valennia Stormfist","faction":"AH","spawns":{}},"251968":{"id":251968,"name":"Ayessa Dawnsinger","faction":"H","spawns":{}},
		"252475":{"id":252475,"name":"Elaadrin Evengale","faction":"A","spawns":{}},"252476":{"id":252476,"name":"Talaanis Shadowsong","faction":"AH","spawns":{}},
		"267006":{"id":267006,"name":"Dark Neophyte","faction":null,"spawns":{}},"275437":{"id":275437,"name":"Dark Enforcer","faction":null,"spawns":{}},
		"1547":{"id":1547,"name":"Decrepit Darkhound","faction":null,"spawns":{}},"254089":{"id":254089,"name":"Coriella Calmbreeze","faction":"AH","spawns":{"2521":{"f":"l","pts":[[43.05,43.3]]}}},
		"251903":{"id":251903,"name":"Rathiril Sunlance","faction":"A","spawns":{"2521":{"f":"l","pts":[[45.0,46.35]]}}},"256966":{"id":256966,"name":"Skypriest Aanders","faction":null,"spawns":{}},
		"1430":{"id":1430,"name":"Tomas","faction":"A","spawns":{}},"270419":{"id":270419,"name":"Credit","faction":"A","spawns":{"1457":{"f":"l","pts":[[40.0,60.0]]}}}}"#;

	/// A Desperate Times session whose client lists its first line as `text` (texts in any language
	/// never matter): each talk and its line ticking where it was (the later lines carry no text: the
	/// accept listed only the first; Ayessa's ticks a moment before her window opens).
	fn desperate_times(text: &str) -> Vec<String> {
		vec![
			r#"{"t":1,"e":"accept","q":92640,"npc":252476,"map":2521,"x":66.22,"y":76.57}"#.into(),
			format!(r#"{{"t":1,"e":"objectives","q":92640,"objectives":[{{"type":"monster","max":1,"text":"{text}"}}]}}"#),
			r#"{"t":20,"e":"offer","npc":252383,"map":2521,"x":66.23,"y":76.58}"#.into(),
			r#"{"t":22,"e":"gossip","npc":252383,"map":2521,"x":66.23,"y":76.58}"#.into(),
			format!(r#"{{"t":23,"e":"progress","q":92640,"oi":1,"cur":1,"max":1,"map":2521,"x":66.23,"y":76.58,"type":"monster","text":"{text}: 1/1"}}"#),
			r#"{"t":140,"e":"progress","q":92640,"oi":2,"cur":1,"max":1,"map":2521,"x":59.17,"y":79.74}"#.into(),
			r#"{"t":140.5,"e":"offer","npc":251968,"map":2521,"x":59.17,"y":79.74}"#.into(),
			r#"{"t":230,"e":"offer","npc":252475,"map":2521,"x":66.59,"y":80.0}"#.into(),
			r#"{"t":231,"e":"gossip","npc":252475,"map":2521,"x":66.59,"y":80.0}"#.into(),
			r#"{"t":231,"e":"progress","q":92640,"oi":3,"cur":1,"max":1,"map":2521,"x":66.59,"y":80.0}"#.into(),
			r#"{"t":231,"e":"complete","q":92640}"#.into(),
			r#"{"t":300,"e":"turnin","q":92640,"npc":252383,"map":2521,"x":66.23,"y":76.66}"#.into(),
		]
	}

	#[test]
	fn a_kill_credit_on_an_npc_players_talk_to_is_a_talk_in_the_games_order() {
		// One counted player settles it (the game's own list), in any client language; Ayessa and
		// Elaadrin are each friendly to one side only: the talks before their lines say so.
		for (who, lang, text) in [(A, "ruRU", "Поговорите с Валеннией Штормовой Кулак"), (B, "enUS", "Speak with Valennia Stormfist")] {
			let t = Tables::new(TIMES, TIMES_NPCS, "{}");
			let stats = t.apply(&[session("s", who, lang, &desperate_times(text))]);
			let q = t.quest("92640");
			assert_eq!(
				j(&q.get("objectives")),
				r#"[{"type":"talk","id":252383,"count":1,"text":"Valennia Stormfist"},{"type":"talk","id":251968,"count":1,"text":"Ayessa Dawnsinger"},{"type":"talk","id":252475,"count":1,"text":"Elaadrin Evengale"}]"#,
				"{lang}"
			);
			assert!(q.get("source").items().iter().any(|s| s.as_str() == Some("recorder:objectives")), "{lang}");
			assert_eq!((stats.game_objective_quests, stats.talk_objectives, stats.dropped_objectives), (1, 3, 0), "{lang}");
		}
		// A player who does not count changes nothing.
		let t = Tables::new(TIMES, TIMES_NPCS, "{}");
		t.apply(&[Recording { counts: false, ..session("n", A, "enUS", &desperate_times("Speak with Valennia Stormfist")) }]);
		assert_eq!(j(&t.quest("92640").get("objectives")), j(&obj(TIMES).get("92640").get("objectives")));
	}

	#[test]
	fn a_quest_that_asks_for_a_fight_keeps_its_kills() {
		// Beat Bartleby 1640, Sparring Match 99108 (#2535): the NPC turns hostile once talked to and
		// gives in, so no kill is recorded; the quest's own text ("Beat", "Defeat") says it is a fight.
		let fight = TIMES.replace(r#""title":"Desperate Times","#, r#""title":"Desperate Times","objectiveText":"Defeat Valennia Stormfist.","#);
		let t = Tables::new(&fight, TIMES_NPCS, "{}");
		t.apply(&[session("s", B, "enUS", &desperate_times("Speak with Valennia Stormfist"))]);
		let types: Vec<String> = t.quest("92640").get("objectives").items().iter().map(|o| o.get("type").to_js_string()).collect();
		assert_eq!(types, ["kill", "kill", "kill"]);
	}

	#[test]
	fn the_games_lines_set_the_order_and_npcs_talked_to_as_a_line_ticks_are_talks() {
		// Welcome to Shen'dar Village: Rathiril's line ticks a moment before his window opens, and
		// the innkeeper's as the player reaches her (players open her window at other times).
		let events: Vec<String> = vec![
			r#"{"t":1,"e":"accept","q":93461,"npc":251523}"#.into(),
			r#"{"t":1,"e":"objectives","q":93461,"objectives":[{"type":"monster","max":1,"text":"Speak with Rathiril Sunlance"},{"type":"monster","max":1,"text":"Speak with the Innkeeper"}]}"#.into(),
			r#"{"t":200,"e":"progress","q":93461,"oi":1,"cur":1,"max":1,"map":2521,"x":45.01,"y":46.35,"type":"monster","text":"Speak with Rathiril Sunlance: 1/1"}"#.into(),
			r#"{"t":200.2,"e":"offer","npc":251903,"map":2521,"x":45.01,"y":46.35}"#.into(),
			r#"{"t":215,"e":"progress","q":93461,"oi":2,"cur":1,"max":1,"map":2521,"x":43.04,"y":43.3,"type":"monster","text":"Speak with the Innkeeper: 1/1"}"#.into(),
			r#"{"t":900,"e":"offer","npc":254089,"map":2521,"x":43.05,"y":43.31}"#.into(),
		];
		let t = Tables::new(TIMES, TIMES_NPCS, "{}");
		t.apply(&from(&[A], &events));
		assert_eq!(j(&t.quest("93461").get("objectives")), r#"[{"type":"talk","id":251903,"count":1,"text":"Rathiril Sunlance"},{"type":"talk","id":254089,"count":1,"text":"Coriella Calmbreeze"}]"#);
		// Without the window nobody opened (Rathiril's talk elsewhere, 15 s earlier, does not count
		// at the innkeeper's), she stays as the data has her.
		let t = Tables::new(TIMES, TIMES_NPCS, "{}");
		t.apply(&from(&[A], &events[..5]));
		assert_eq!(j(&t.quest("93461").get("objectives").get("1").get("type")), r#""kill""#);
		// A credit marker the line ticks at (an explored spot), whose window nobody opens, stays.
		let marker: Vec<String> = vec![
			r#"{"t":1,"e":"objectives","q":98067,"objectives":[{"type":"monster","max":1,"text":"Darnassus Bank"}]}"#.into(),
			r#"{"t":50,"e":"progress","q":98067,"oi":1,"cur":1,"max":1,"map":1457,"x":40.1,"y":60.0}"#.into(),
			r#"{"t":50,"e":"complete","q":98067}"#.into(),
		];
		let t = Tables::new(TIMES, TIMES_NPCS, "{}");
		t.apply(&from(&[A], &marker));
		assert_eq!(j(&t.quest("98067").get("objectives")), j(&obj(TIMES).get("98067").get("objectives")));
		// A Last Request: the game lists the note first (an item line), then reveals Skypriest
		// Aanders, whose kills tick line 2: the data's order follows, and Aanders stays a kill.
		let request: Vec<String> = vec![
			r#"{"t":1,"e":"objectives","q":93927,"objectives":[{"type":"item","max":1,"text":"Collect and read the note"}]}"#.into(),
			r#"{"t":9,"e":"loot","item":254871,"q":93927,"oi":1}"#.into(),
			r#"{"t":9,"e":"progress","q":93927,"oi":1,"cur":1,"max":1,"type":"item","text":"Collect and read the note: 1/1"}"#.into(),
			r#"{"t":90,"e":"kill","npc":256966,"q":93927,"oi":2}"#.into(),
			r#"{"t":90,"e":"progress","q":93927,"oi":2,"cur":1,"max":1}"#.into(),
			r#"{"t":90,"e":"complete","q":93927}"#.into(),
		];
		let t = Tables::new(TIMES, TIMES_NPCS, "{}");
		t.apply(&from(&[A], &request));
		assert_eq!(j(&t.quest("93927").get("objectives")), r#"[{"type":"item","id":254871,"count":1,"text":"Bloody Note"},{"type":"kill","id":256966,"count":null,"text":"Skypriest Aanders"}]"#);
		// Goretusk Liver Pie in French, accepted before the recording started (no `objectives`
		// record): three players' liver ticks tied to the Boar Intestines lying beside the liver fast
		// loot had taken. The intestines are no item of the quest: no vote, so no objective of theirs
		// is added.
		const PIE: &str = r#"{"22":{"id":22,"title":"Goretusk Liver Pie","races":null,"objectives":[{"type":"item","id":723,"count":8,"text":"Goretusk Liver"}],"source":["questie-forever"]}}"#;
		let pie: Vec<String> = vec![r#"{"t":9,"e":"loot","item":3172,"q":22,"oi":1}"#.into(), r#"{"t":9,"e":"progress","q":22,"oi":1,"cur":1,"max":8,"type":"item"}"#.into()];
		let t = Tables::new(PIE, TIMES_NPCS, "{}");
		t.apply(&[A, B, C].iter().enumerate().map(|(i, c)| session(&format!("s{i}"), c, "frFR", &pie)).collect::<Vec<_>>());
		let ids: Vec<String> = t.quest("22").get("objectives").items().iter().map(|o| j(&o.get("id"))).collect();
		assert_eq!(ids, ["723"]);
		// A trainer's lesson or a skill raised by crafting beside him is no talk, even where and as
		// his window opened (Camping 101: Tomas's line ticks as you learn cooking in his training
		// window, or as a craft right after talking to him raises the skill).
		let lesson: Vec<String> = vec![
			r#"{"t":1,"e":"objectives","q":96626,"objectives":[{"type":"monster","max":1,"text":"Learn cooking from Tomas in Goldshire"}]}"#.into(),
			r#"{"t":10,"e":"gossip","npc":1430,"map":1429,"x":44.4,"y":66.0}"#.into(),
			r#"{"t":11,"e":"trainer","npc":1430,"map":1429,"x":44.4,"y":66.0}"#.into(),
			r#"{"t":13,"e":"complete","q":96626}"#.into(),
		];
		let crafted: Vec<String> = vec![
			r#"{"t":1,"e":"objectives","q":96626,"objectives":[{"type":"monster","max":1,"text":"Learn cooking from Tomas in Goldshire"}]}"#.into(),
			r#"{"t":10,"e":"gossip","npc":1430,"map":1429,"x":44.4,"y":66.0}"#.into(),
			r#"{"t":20,"e":"craft","spell":2538,"map":1429,"x":44.4,"y":66.0}"#.into(),
			r#"{"t":21,"e":"complete","q":96626}"#.into(),
		];
		for events in [lesson, crafted] {
			let t = Tables::new(TIMES, TIMES_NPCS, "{}");
			t.apply(&from(&[A], &events));
			assert_eq!(j(&t.quest("96626").get("objectives")), j(&obj(TIMES).get("96626").get("objectives")));
		}
		// The same talk with nothing after it is a talk.
		let talked: Vec<String> = vec![
			r#"{"t":1,"e":"objectives","q":96626,"objectives":[{"type":"monster","max":1,"text":"Learn cooking from Tomas in Goldshire"}]}"#.into(),
			r#"{"t":10,"e":"gossip","npc":1430,"map":1429,"x":44.4,"y":66.0}"#.into(),
			r#"{"t":11,"e":"complete","q":96626}"#.into(),
		];
		let t = Tables::new(TIMES, TIMES_NPCS, "{}");
		t.apply(&from(&[A], &talked));
		assert_eq!(j(&t.quest("96626").get("objectives").get("0").get("type")), r#""talk""#);
	}

	/// A Cult of the Damned session: eight kills of each, credited to their lines, then (with
	/// `complete`) the quest complete.
	fn cult(complete: bool) -> Vec<String> {
		let mut v: Vec<String> = vec![
			r#"{"t":1,"e":"accept","q":96897,"npc":267009}"#.into(),
			r#"{"t":1,"e":"objectives","q":96897,"objectives":[{"type":"monster","max":8,"text":"Dark Neophyte slain"},{"type":"monster","max":8,"text":"Dark Enforcer slain"}]}"#.into(),
		];
		for i in 1..=8 {
			v.push(format!(r#"{{"t":{},"e":"kill","npc":267006,"q":96897,"oi":1}}"#, 10 * i));
			v.push(format!(r#"{{"t":{},"e":"progress","q":96897,"oi":1,"cur":{i},"max":8,"type":"monster","text":"Dark Neophyte slain: {i}/8"}}"#, 10 * i));
			v.push(format!(r#"{{"t":{},"e":"kill","npc":275437,"q":96897,"oi":2}}"#, 10 * i + 5));
			v.push(format!(r#"{{"t":{},"e":"progress","q":96897,"oi":2,"cur":{i},"max":8,"type":"monster","text":"Dark Enforcer slain: {i}/8"}}"#, 10 * i + 5));
		}
		if complete {
			v.push(r#"{"t":200,"e":"complete","q":96897}"#.into());
		}
		v
	}

	#[test]
	fn an_objective_the_game_does_not_count_goes_once_a_player_completed_the_quest() {
		let t = Tables::new(TIMES, TIMES_NPCS, "{}");
		let stats = t.apply(&from(&[A], &cult(true)));
		assert_eq!(j(&t.quest("96897").get("objectives")), r#"[{"type":"kill","id":267006,"count":8,"text":"Dark Neophyte"},{"type":"kill","id":275437,"count":8,"text":"Dark Enforcer"}]"#);
		assert_eq!((stats.game_objective_quests, stats.talk_objectives, stats.dropped_objectives), (1, 0, 1));
		// Until someone completes it, a later line could still be revealed: nothing goes.
		let t = Tables::new(TIMES, TIMES_NPCS, "{}");
		t.apply(&from(&[A], &cult(false)));
		assert_eq!(j(&t.quest("96897").get("objectives")), j(&obj(TIMES).get("96897").get("objectives")));
	}

	#[test]
	fn players_whose_lists_disagree_leave_the_datas_objectives_and_are_listed() {
		let mut other = cult(true);
		other[1] = r#"{"t":1,"e":"objectives","q":96897,"objectives":[{"type":"monster","max":8,"text":"Dark Neophyte slain"}]}"#.into();
		let t = Tables::new(TIMES, TIMES_NPCS, "{}");
		let stats = t.apply(&[session("a", A, "enUS", &cult(true)), session("b", B, "enUS", &other)]);
		assert_eq!(j(&t.quest("96897").get("objectives")), j(&obj(TIMES).get("96897").get("objectives")));
		assert_eq!(stats.objective_conflicts, vec![96897]);
	}
}
