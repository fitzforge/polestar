//! The data-diff gate (`forge data diff`): a data build (data/forever: npcs, objects, quests, the Codex,
//! spawn heights, travel) against the live release's, per NPC, object and quest, with the invariants a
//! release must hold. A data refresh changes what thousands of players see at once, and a route playtest
//! never stands in a capital: this lists what changed for each NPC and quest, and fails on the changes that
//! reached players in 0.4.1 (faction leaders listed as rares with 127 points over Orgrimmar, #2929 #2942,
//! and Thrall's hand-in point outside his throne room, #2894).
//!
//! Changes listed (the report; none of them fails by itself):
//! - NPCs and objects: spawn points (a big jump: x3 and +10, or every point lost), the farthest new point
//!   from the old ones (over [`MOVE_YD`]), roles gained or lost (rare, vendor, trainer, ...), the Codex's
//!   rare, elite and boss flags, the rank, the faction;
//! - quests: givers and enders gained or lost, an ender's place moved, level and minimum level, `pre` and
//!   `preAny` prerequisites gained or lost;
//! - spawn heights (spawnz.json) and travel (travel.json): what changed, in counts.
//!
//! Invariants (a violation fails the gate):
//! - `friendly-rare`: no NPC on a player faction's side (faction A, H or AH) is a rare in the Codex (its
//!   `rare` flag or `rare` role), the data the rare alert, pins and list read; without a Codex, in npcs.json;
//! - `leader-spawns`: a faction leader (a boss, rank 3, on a player faction's side, standing in a capital)
//!   keeps a small spawn set: at most [`SMALL_SET`] places (or the old count; points within [`PLACE_YD`]
//!   of each other are one place), each point within [`STAY_YD`] of one it had, unless a correction
//!   record names the NPC;
//! - `capital-spawns`: the same for every other NPC on a player faction's side in 1 to [`SMALL_SET`]
//!   places, all of them in a capital: no more than [`SMALL_SET`] places, and no point farther than
//!   [`MOVE_YD`] from where it stood, unless a correction record names it;
//! - `spawn-jump`: no NPC goes from at most [`JUMP_FROM`] points to more than [`JUMP_TO`] unless it is a
//!   known roamer ([`KNOWN_ROAMERS`]);
//! - `ender-moved`: no quest's hand-in moves more than [`MOVE_YD`] (a point of its new enders farther than
//!   that from every point of its old ones) unless a correction record names the quest or the ender.

use serde::Serialize;
use serde_json::{Map, Value};
use std::collections::{BTreeMap, BTreeSet, HashSet};
use std::fmt::Write as _;
use std::path::Path;

/// Yards a quest's hand-in or a capital NPC may move before it needs a correction record.
pub const MOVE_YD: f64 = 200.0;
/// Yards a faction leader's points may be from the ones it had.
pub const STAY_YD: f64 = 60.0;
/// A small spawn set: what leaders and capital NPCs keep.
pub const SMALL_SET: usize = 5;
/// Points this close are one place (players' recorded spots round an NPC that stands still: 30 yd at the
/// median, recordings.rs).
pub const PLACE_YD: f64 = 30.0;
/// `spawn-jump`: from at most this many points...
pub const JUMP_FROM: usize = 3;
/// ...to more than this many.
pub const JUMP_TO: usize = 20;
/// The capitals' maps (UiMapIDs): Stormwind, Orgrimmar, Ironforge, Thunder Bluff, Darnassus, Undercity.
pub const CAPITALS: [u64; 6] = [1453, 1454, 1455, 1456, 1457, 1458];

/// NPCs that walk a long path, reviewed: their points may jump past [`JUMP_TO`], and a quest they end may
/// move its hand-in (id, name, why). Add one only after checking in game or in the recordings that it
/// patrols.
pub const KNOWN_ROAMERS: &[(u64, &str, &str)] = &[(10182, "Rexxar", "walks the road through Desolace, Stonetalon and Feralas; ends The Champion of the Horde")];

/// One data build's files.
pub struct Side {
	pub npcs: Map<String, Value>,
	pub objects: Map<String, Value>,
	pub quests: Map<String, Value>,
	/// map-frames.json: { era: { map: frame }, forever: { map: frame } }.
	pub frames: Value,
	/// codex/npcs.json when the Codex was built.
	pub codex_npcs: Option<Map<String, Value>>,
	pub spawnz: Option<Value>,
	pub travel: Option<Value>,
}

fn read_json(path: &Path) -> Result<Value, String> {
	let text = std::fs::read_to_string(path).map_err(|e| format!("{}: {e}", path.display()))?;
	serde_json::from_str(&text).map_err(|e| format!("{}: {e}", path.display()))
}

fn read_opt(path: &Path) -> Result<Option<Value>, String> {
	if path.exists() {
		read_json(path).map(Some)
	} else {
		Ok(None)
	}
}

fn obj(v: Value, what: &str) -> Result<Map<String, Value>, String> {
	match v {
		Value::Object(m) => Ok(m),
		_ => Err(format!("{what}: not an object of records")),
	}
}

impl Side {
	/// Reads a data/forever folder (npcs, objects, quests and map-frames are needed; the Codex, spawnz and
	/// travel are read when there).
	pub fn load(dir: &Path) -> Result<Side, String> {
		if !dir.join("npcs.json").exists() {
			return Err(format!("{}: no npcs.json (a data/forever folder is needed)", dir.display()));
		}
		Ok(Side {
			npcs: obj(read_json(&dir.join("npcs.json"))?, "npcs.json")?,
			objects: obj(read_json(&dir.join("objects.json"))?, "objects.json")?,
			quests: obj(read_json(&dir.join("quests.json"))?, "quests.json")?,
			frames: read_opt(&dir.join("map-frames.json"))?.unwrap_or(Value::Null),
			codex_npcs: read_opt(&dir.join("codex/npcs.json"))?.map(|v| obj(v, "codex/npcs.json")).transpose()?,
			spawnz: read_opt(&dir.join("spawnz.json"))?,
			travel: read_opt(&dir.join("travel.json"))?,
		})
	}
}

/// The ids correction records name (forever-db/corrections: npcs.json, objects.json, quests.json).
#[derive(Default)]
pub struct Corrections {
	pub npcs: HashSet<String>,
	pub objects: HashSet<String>,
	pub quests: HashSet<String>,
}

impl Corrections {
	pub fn load(dir: &Path) -> Result<Corrections, String> {
		let keys = |f: &str| -> Result<HashSet<String>, String> {
			Ok(match read_opt(&dir.join(f))? {
				Some(Value::Object(m)) => m.keys().cloned().collect(),
				_ => HashSet::new(),
			})
		};
		Ok(Corrections { npcs: keys("npcs.json")?, objects: keys("objects.json")?, quests: keys("quests.json")? })
	}
}

/// A point in world yards: (continent, x, y).
type Pt = (i64, f64, f64);

fn num(v: &Value) -> Option<f64> {
	v.as_f64()
}

fn ids(v: &Value) -> BTreeSet<u64> {
	v.as_array().map(|a| a.iter().filter_map(Value::as_u64).collect()).unwrap_or_default()
}

/// A record's spawn points as world yards (points on a map without a frame are left out of distances but
/// counted).
fn points(rec: &Value, frames: &Value) -> (usize, Vec<Pt>, BTreeSet<u64>) {
	let (mut n, mut out, mut maps) = (0, Vec::new(), BTreeSet::new());
	let Some(spawns) = rec.get("spawns").and_then(Value::as_object) else { return (0, out, maps) };
	for (map, s) in spawns {
		let pts = s.get("pts").and_then(Value::as_array).cloned().unwrap_or_default();
		n += pts.len();
		let Ok(map_id) = map.parse::<u64>() else { continue };
		if !pts.is_empty() {
			maps.insert(map_id);
		}
		let set = if s.get("f").and_then(Value::as_str) == Some("l") { "forever" } else { "era" };
		let f = frames.get(set).and_then(|m| m.get(map)).or_else(|| frames.get("era").and_then(|m| m.get(map)));
		let Some(f) = f else { continue };
		let (Some(c), Some(l), Some(r), Some(t), Some(b)) = (f.get("c").and_then(Value::as_i64), num(&f["left"]), num(&f["right"]), num(&f["top"]), num(&f["bottom"])) else { continue };
		for p in &pts {
			if let (Some(x), Some(y)) = (p.get(0).and_then(num), p.get(1).and_then(num)) {
				out.push((c, l + (r - l) * x / 100.0, t + (b - t) * y / 100.0));
			}
		}
	}
	(n, out, maps)
}

fn dist(a: &Pt, b: &Pt) -> f64 {
	if a.0 != b.0 {
		return f64::INFINITY;
	}
	((a.1 - b.1).powi(2) + (a.2 - b.2).powi(2)).sqrt()
}

/// The farthest any point of `new` is from every point of `old` (None when either has none).
fn farthest(old: &[Pt], new: &[Pt]) -> Option<f64> {
	if old.is_empty() || new.is_empty() {
		return None;
	}
	Some(new.iter().map(|p| old.iter().map(|o| dist(o, p)).fold(f64::INFINITY, f64::min)).fold(0.0, f64::max))
}

/// How many places the points are: each point within [`PLACE_YD`] of a place's first point joins it.
fn places(pts: &[Pt]) -> usize {
	let mut centres: Vec<Pt> = Vec::new();
	for p in pts {
		if !centres.iter().any(|c| dist(c, p) <= PLACE_YD) {
			centres.push(*p);
		}
	}
	centres.len()
}

fn strs(v: Option<&Value>) -> BTreeSet<String> {
	v.and_then(Value::as_array).map(|a| a.iter().filter_map(|x| x.as_str().map(String::from)).collect()).unwrap_or_default()
}

fn friendly(fac: Option<&str>) -> bool {
	matches!(fac, Some("A" | "H" | "AH"))
}

/// An NPC's roles with the Codex's flags (`codex:rare`, `codex:elite`, `codex:boss`) and its rank.
fn npc_traits(rec: Option<&Value>, codex: Option<&Value>) -> BTreeSet<String> {
	let mut t = strs(rec.and_then(|r| r.get("roles")));
	if let Some(rank) = rec.and_then(|r| r.get("rank")).and_then(Value::as_i64).filter(|r| *r > 0) {
		t.insert(format!("rank:{rank}"));
	}
	if let Some(c) = codex {
		for flag in ["rare", "elite", "boss"] {
			if c.get(flag).and_then(Value::as_bool) == Some(true) {
				t.insert(format!("codex:{flag}"));
			}
		}
		for r in strs(c.get("roles")) {
			t.insert(format!("codex:{r}"));
		}
	}
	t
}

/// The Codex says it is a rare (or, without a Codex, the data's roles).
fn is_rare(rec: &Value, codex: Option<&Map<String, Value>>, id: &str) -> Option<&'static str> {
	match codex {
		Some(c) => {
			let n = c.get(id)?;
			if n.get("rare").and_then(Value::as_bool) == Some(true) {
				Some("the Codex's rare flag")
			} else if strs(n.get("roles")).contains("rare") {
				Some("the Codex's rare role")
			} else {
				None
			}
		}
		None => strs(rec.get("roles")).contains("rare").then_some("the rare role"),
	}
}

#[derive(Clone, Debug, Serialize)]
pub struct Violation {
	pub rule: &'static str,
	pub kind: &'static str,
	pub id: String,
	pub name: String,
	pub detail: String,
}

#[derive(Clone, Debug, Default, Serialize)]
pub struct Row {
	pub kind: &'static str,
	pub id: String,
	pub name: String,
	/// What changed, one phrase each.
	pub changes: Vec<String>,
	/// A spawn-count jump (x3 and +10, or every point lost), or a move past [`MOVE_YD`].
	pub big: bool,
}

#[derive(Debug, Default, Serialize)]
pub struct Counts {
	pub npcs: [usize; 2],
	pub objects: [usize; 2],
	pub quests: [usize; 2],
	pub npcs_added: usize,
	pub npcs_removed: usize,
	pub objects_added: usize,
	pub objects_removed: usize,
	pub quests_added: usize,
	pub quests_removed: usize,
	pub friendly_rares_in_data: Vec<String>,
}

#[derive(Debug, Default, Serialize)]
pub struct Report {
	pub violations: Vec<Violation>,
	pub npcs: Vec<Row>,
	pub objects: Vec<Row>,
	pub quests: Vec<Row>,
	/// Spawn heights: (section, added, removed, changed).
	pub heights: Vec<(String, usize, usize, usize)>,
	/// Travel: (section, what changed).
	pub travel: Vec<(String, String)>,
	pub counts: Counts,
}

fn name_of(v: Option<&Value>, key: &str) -> String {
	v.and_then(|r| r.get(key)).and_then(Value::as_str).unwrap_or("?").to_string()
}

fn spawn_changes(row: &mut Row, old: &Value, new: &Value, of: &Side, nf: &Side) -> (usize, usize, Option<f64>) {
	let (on, opts, _) = points(old, &of.frames);
	let (nn, npts, _) = points(new, &nf.frames);
	if on != nn {
		let jump = (nn >= on * 3 && nn >= on + 10) || (on > 0 && nn == 0);
		row.big |= jump;
		row.changes.push(format!("spawn points {on} -> {nn}{}", if jump { " (big jump)" } else { "" }));
	}
	let far = farthest(&opts, &npts);
	if let Some(d) = far.filter(|d| *d > MOVE_YD) {
		row.big = true;
		row.changes.push(if d.is_finite() { format!("a point {d:.0} yd from every old one") } else { "a point on another continent".into() });
	}
	(on, nn, far)
}

fn set_changes(row: &mut Row, what: &str, old: &BTreeSet<String>, new: &BTreeSet<String>) {
	let gained: Vec<&String> = new.difference(old).collect();
	let lost: Vec<&String> = old.difference(new).collect();
	if !gained.is_empty() {
		row.changes.push(format!("{what} gained {}", gained.iter().map(|s| s.as_str()).collect::<Vec<_>>().join(", ")));
	}
	if !lost.is_empty() {
		row.changes.push(format!("{what} lost {}", lost.iter().map(|s| s.as_str()).collect::<Vec<_>>().join(", ")));
	}
}

fn id_changes(row: &mut Row, what: &str, old: &BTreeSet<u64>, new: &BTreeSet<u64>) {
	let s = |v: Vec<&u64>| v.iter().map(|x| x.to_string()).collect::<Vec<_>>().join(", ");
	let gained: Vec<&u64> = new.difference(old).collect();
	let lost: Vec<&u64> = old.difference(new).collect();
	if !gained.is_empty() {
		row.changes.push(format!("{what} gained {}", s(gained)));
	}
	if !lost.is_empty() {
		row.changes.push(format!("{what} lost {}", s(lost)));
	}
}

/// The ender points of a quest in one build.
fn ender_points(q: &Value, side: &Side) -> Vec<Pt> {
	let mut out = Vec::new();
	let end = q.get("end").cloned().unwrap_or(Value::Null);
	for (k, recs) in [("npc", &side.npcs), ("object", &side.objects)] {
		for id in ids(end.get(k).unwrap_or(&Value::Null)) {
			if let Some(r) = recs.get(&id.to_string()) {
				out.extend(points(r, &side.frames).1);
			}
		}
	}
	out
}

/// Compares `new` with `old` (the live release's build).
pub fn diff(old: &Side, new: &Side, corr: &Corrections) -> Report {
	let mut rep = Report::default();
	let c = &mut rep.counts;
	c.npcs = [old.npcs.len(), new.npcs.len()];
	c.objects = [old.objects.len(), new.objects.len()];
	c.quests = [old.quests.len(), new.quests.len()];
	c.npcs_added = new.npcs.keys().filter(|k| !old.npcs.contains_key(*k)).count();
	c.npcs_removed = old.npcs.keys().filter(|k| !new.npcs.contains_key(*k)).count();
	c.objects_added = new.objects.keys().filter(|k| !old.objects.contains_key(*k)).count();
	c.objects_removed = old.objects.keys().filter(|k| !new.objects.contains_key(*k)).count();
	c.quests_added = new.quests.keys().filter(|k| !old.quests.contains_key(*k)).count();
	c.quests_removed = old.quests.keys().filter(|k| !new.quests.contains_key(*k)).count();
	let roamers: HashSet<String> = KNOWN_ROAMERS.iter().map(|r| r.0.to_string()).collect();
	let null = Value::Null;

	// NPCs.
	for (id, n) in &new.npcs {
		let name = name_of(Some(n), "name");
		let fac = n.get("faction").and_then(Value::as_str);
		let ncodex = new.codex_npcs.as_ref().and_then(|c| c.get(id));
		if friendly(fac) {
			if let Some(why) = is_rare(n, new.codex_npcs.as_ref(), id) {
				rep.violations.push(Violation {
					rule: "friendly-rare",
					kind: "npc",
					id: id.clone(),
					name: name.clone(),
					detail: format!("faction {} and {why}: a rare alert and a rare pin for an NPC on the player's side", fac.unwrap_or("")),
				});
			}
			if new.codex_npcs.is_some() && strs(n.get("roles")).contains("rare") {
				rep.counts.friendly_rares_in_data.push(format!("{id} {name}"));
			}
		}
		let Some(o) = old.npcs.get(id) else { continue };
		let ocodex = old.codex_npcs.as_ref().and_then(|c| c.get(id));
		let mut row = Row { kind: "npc", id: id.clone(), name: name.clone(), ..Default::default() };
		let (on, nn, far) = spawn_changes(&mut row, o, n, old, new);
		set_changes(&mut row, "roles", &npc_traits(Some(o), ocodex), &npc_traits(Some(n), ncodex));
		let ofac = o.get("faction").and_then(Value::as_str);
		if ofac != fac {
			row.changes.push(format!("faction {} -> {}", ofac.unwrap_or("none"), fac.unwrap_or("none")));
		}
		match (ocodex.is_some(), ncodex.is_some()) {
			(true, false) if new.codex_npcs.is_some() => row.changes.push("left the Codex".into()),
			(false, true) if old.codex_npcs.is_some() => row.changes.push("joined the Codex".into()),
			_ => {}
		}
		// Invariants on the spawn set. A leader's or capital NPC's set is judged by its places (points within
		// PLACE_YD of each other are one: players' recorded spots round one NPC that stands still), so a vendor
		// seen from twelve spots in its tent keeps one place, and Thrall over all of Orgrimmar has many.
		let (_, opts, omaps) = points(o, &old.frames);
		let (_, npts, _) = points(n, &new.frames);
		let in_capital = !omaps.is_empty() && omaps.iter().all(|m| CAPITALS.contains(m));
		let corrected = corr.npcs.contains(id);
		let boss = |r: &Value, c: Option<&Value>| r.get("rank").and_then(Value::as_i64) == Some(3) || c.and_then(|c| c.get("boss")).and_then(Value::as_bool) == Some(true);
		if friendly(fac) && in_capital && !corrected {
			let leader = boss(o, ocodex) || boss(n, ncodex);
			let (op, np) = (places(&opts), places(&npts));
			if leader || (1..=SMALL_SET).contains(&op) {
				let limit = op.max(SMALL_SET);
				let reach = if leader { STAY_YD } else { MOVE_YD };
				let rule = if leader { "leader-spawns" } else { "capital-spawns" };
				if np > limit {
					rep.violations.push(Violation { rule, kind: "npc", id: id.clone(), name: name.clone(), detail: format!("{op} -> {np} places ({on} -> {nn} points; at most {limit} places)") });
				} else if let Some(d) = far.filter(|d| *d > reach) {
					rep.violations.push(Violation {
						rule,
						kind: "npc",
						id: id.clone(),
						name: name.clone(),
						detail: format!("a point {d:.0} yd from every point it had (at most {reach:.0} yd without a correction record)"),
					});
				}
			}
		}
		if on <= JUMP_FROM && nn > JUMP_TO && !roamers.contains(id) {
			rep.violations.push(Violation { rule: "spawn-jump", kind: "npc", id: id.clone(), name: name.clone(), detail: format!("{on} -> {nn} points, not a known roamer") });
		}
		if !row.changes.is_empty() {
			rep.npcs.push(row);
		}
	}

	// Objects.
	for (id, n) in &new.objects {
		let Some(o) = old.objects.get(id) else { continue };
		let mut row = Row { kind: "object", id: id.clone(), name: name_of(Some(n), "name"), ..Default::default() };
		spawn_changes(&mut row, o, n, old, new);
		set_changes(&mut row, "roles", &strs(o.get("roles")), &strs(n.get("roles")));
		if !row.changes.is_empty() {
			rep.objects.push(row);
		}
	}

	// Quests.
	for (id, q) in &new.quests {
		let Some(o) = old.quests.get(id) else { continue };
		let mut row = Row { kind: "quest", id: id.clone(), name: name_of(Some(q), "title"), ..Default::default() };
		for (part, label) in [("start", "giver"), ("end", "ender")] {
			for k in ["npc", "object", "item"] {
				let (a, b) = (ids(o.get(part).and_then(|p| p.get(k)).unwrap_or(&null)), ids(q.get(part).and_then(|p| p.get(k)).unwrap_or(&null)));
				id_changes(&mut row, &format!("{label} {k}s"), &a, &b);
			}
		}
		for k in ["level", "minLevel"] {
			let (a, b) = (o.get(k).and_then(Value::as_i64), q.get(k).and_then(Value::as_i64));
			if a != b {
				let s = |v: Option<i64>| v.map_or("none".to_string(), |x| x.to_string());
				row.changes.push(format!("{k} {} -> {}", s(a), s(b)));
			}
		}
		for k in ["pre", "preAny"] {
			id_changes(&mut row, k, &ids(o.get(k).unwrap_or(&null)), &ids(q.get(k).unwrap_or(&null)));
		}
		if let Some(d) = farthest(&ender_points(o, old), &ender_points(q, new)).filter(|d| *d > MOVE_YD) {
			row.big = true;
			let at = if d.is_finite() { format!("{d:.0} yd") } else { "to another continent".into() };
			row.changes.push(format!("hand-in moved {at}"));
			let end = q.get("end").cloned().unwrap_or(Value::Null);
			// A correction record, or an ender that is a known roamer (its hand-in is wherever it walks).
			let corrected = corr.quests.contains(id)
				|| ids(end.get("npc").unwrap_or(&null)).iter().any(|n| corr.npcs.contains(&n.to_string()) || roamers.contains(&n.to_string()))
				|| ids(end.get("object").unwrap_or(&null)).iter().any(|n| corr.objects.contains(&n.to_string()));
			if !corrected {
				let enders: Vec<String> = ids(end.get("npc").unwrap_or(&null)).iter().map(|n| format!("{} {n}", name_of(new.npcs.get(&n.to_string()), "name"))).collect();
				rep.violations.push(Violation {
					rule: "ender-moved",
					kind: "quest",
					id: id.clone(),
					name: row.name.clone(),
					detail: format!("a hand-in point {at} from every old one (ender {}), no correction record", if enders.is_empty() { "an object".into() } else { enders.join(", ") }),
				});
			}
		}
		if !row.changes.is_empty() {
			rep.quests.push(row);
		}
	}

	// Spawn heights and travel, in counts.
	if let (Some(a), Some(b)) = (&old.spawnz, &new.spawnz) {
		for k in ["npc", "object"] {
			let (Some(a), Some(b)) = (a.get(k).and_then(Value::as_object), b.get(k).and_then(Value::as_object)) else { continue };
			let added = b.keys().filter(|x| !a.contains_key(*x)).count();
			let removed = a.keys().filter(|x| !b.contains_key(*x)).count();
			let changed = b.iter().filter(|(x, v)| a.get(*x).is_some_and(|o| o != *v)).count();
			rep.heights.push((k.to_string(), added, removed, changed));
		}
	}
	if let (Some(Value::Object(a)), Some(Value::Object(b))) = (&old.travel, &new.travel) {
		let keys: BTreeSet<&String> = a.keys().chain(b.keys()).collect();
		for k in keys {
			let (x, y) = (a.get(k), b.get(k));
			if x == y {
				continue;
			}
			let size = |v: Option<&Value>| match v {
				Some(Value::Array(a)) => a.len().to_string(),
				Some(Value::Object(o)) => o.len().to_string(),
				Some(v) => v.to_string(),
				None => "none".into(),
			};
			let what = match (x, y) {
				(Some(Value::Object(p)), Some(Value::Object(q))) => {
					let changed: Vec<&String> = q.iter().filter(|(k, v)| p.get(*k) != Some(*v)).map(|(k, _)| k).chain(p.keys().filter(|k| !q.contains_key(*k))).collect();
					format!("{} entries, changed: {}", size(y), changed.iter().map(|s| s.as_str()).collect::<Vec<_>>().join(", "))
				}
				_ => format!("{} -> {}", size(x), size(y)),
			};
			rep.travel.push((k.clone(), what));
		}
	}
	rep.violations.sort_by(|a, b| (a.rule, a.kind, a.id.parse::<u64>().unwrap_or(0)).cmp(&(b.rule, b.kind, b.id.parse::<u64>().unwrap_or(0))));
	for rows in [&mut rep.npcs, &mut rep.objects, &mut rep.quests] {
		rows.sort_by_key(|r| (!r.big, r.id.parse::<u64>().unwrap_or(0)));
	}
	rep
}

/// The report as Markdown: the verdict and the violations first, then every change.
pub fn markdown(rep: &Report, old: &str, new: &str) -> String {
	let mut s = String::new();
	let _ = writeln!(s, "# Data diff: {new} against {old}\n");
	let _ = writeln!(s, "{}\n", verdict(rep));
	if !rep.violations.is_empty() {
		let _ = writeln!(s, "## Violations ({})\n\n| Rule | Kind | Id | Name | What |\n|---|---|---|---|---|", rep.violations.len());
		for v in &rep.violations {
			let _ = writeln!(s, "| {} | {} | {} | {} | {} |", v.rule, v.kind, v.id, v.name, v.detail);
		}
		s.push('\n');
	}
	let c = &rep.counts;
	let _ = writeln!(
		s,
		"## Counts\n\n| | Old | New | Added | Removed | Changed (big) |\n|---|---|---|---|---|---|\n| NPCs | {} | {} | {} | {} | {} ({}) |\n| Objects | {} | {} | {} | {} | {} ({}) |\n| Quests | {} | {} | {} | {} | {} ({}) |\n",
		c.npcs[0],
		c.npcs[1],
		c.npcs_added,
		c.npcs_removed,
		rep.npcs.len(),
		rep.npcs.iter().filter(|r| r.big).count(),
		c.objects[0],
		c.objects[1],
		c.objects_added,
		c.objects_removed,
		rep.objects.len(),
		rep.objects.iter().filter(|r| r.big).count(),
		c.quests[0],
		c.quests[1],
		c.quests_added,
		c.quests_removed,
		rep.quests.len(),
		rep.quests.iter().filter(|r| r.big).count()
	);
	if !c.friendly_rares_in_data.is_empty() {
		let _ =
			writeln!(s, "NPCs on a player faction's side with the source data's rare role, which the Codex leaves out ({}): {}\n", c.friendly_rares_in_data.len(), c.friendly_rares_in_data.join("; "));
	}
	if !rep.heights.is_empty() {
		let _ = writeln!(s, "Spawn heights (spawnz.json): {}\n", rep.heights.iter().map(|(k, a, r, ch)| format!("{k}: {a} added, {r} removed, {ch} changed")).collect::<Vec<_>>().join("; "));
	}
	if !rep.travel.is_empty() {
		let _ = writeln!(s, "## Travel (travel.json)\n");
		for (k, w) in &rep.travel {
			let _ = writeln!(s, "- {k}: {w}");
		}
		s.push('\n');
	}
	for (title, rows) in [("NPCs", &rep.npcs), ("Objects", &rep.objects), ("Quests", &rep.quests)] {
		if rows.is_empty() {
			continue;
		}
		let _ = writeln!(s, "## {title} ({} changed, big changes first)\n\n| Id | Name | Changes |\n|---|---|---|", rows.len());
		for r in rows.iter() {
			let _ = writeln!(s, "| {}{} | {} | {} |", r.id, if r.big { " **big**" } else { "" }, r.name, r.changes.join("; "));
		}
		s.push('\n');
	}
	s
}

/// The verdict line: `data diff: PASS ...` or `data diff: FAIL <n> violation(s) ...`.
pub fn verdict(rep: &Report) -> String {
	let changed = format!("{} NPCs, {} objects, {} quests changed", rep.npcs.len(), rep.objects.len(), rep.quests.len());
	if rep.violations.is_empty() {
		return format!("data diff: PASS, 0 violations; {changed}");
	}
	let mut by: BTreeMap<&str, usize> = BTreeMap::new();
	for v in &rep.violations {
		*by.entry(v.rule).or_default() += 1;
	}
	format!("data diff: FAIL {} violation(s) ({}); {changed}", rep.violations.len(), by.iter().map(|(r, n)| format!("{r} {n}")).collect::<Vec<_>>().join(", "))
}

#[cfg(test)]
mod tests {
	use super::*;
	use serde_json::json;

	fn side(npcs: Value, quests: Value, codex: Option<Value>) -> Side {
		Side {
			npcs: npcs.as_object().unwrap().clone(),
			objects: Map::new(),
			quests: quests.as_object().unwrap().clone(),
			// Orgrimmar's frame: 1402 x 935 yd.
			frames: json!({ "era": { "1454": { "c": 1, "left": -3680.601, "right": -5083.206, "top": 2273.877, "bottom": 1338.461 } } }),
			codex_npcs: codex.map(|c| c.as_object().unwrap().clone()),
			spawnz: None,
			travel: None,
		}
	}

	fn pts(n: usize) -> Value {
		Value::Array((0..n).map(|i| json!([30.0 + i as f64 * 1.3, 37.0 + (i % 7) as f64 * 5.0])).collect())
	}

	/// The 0.4.1 refresh, small: Thrall gains the rare role and 30 points over Orgrimmar, so the hand-in of
	/// his quest moves; a hostile rare's points grow without a violation.
	#[test]
	fn the_0_4_1_faction_leader_rares_fail_every_invariant_they_broke_2929_2942_2894() {
		let old = side(
			json!({ "4949": { "id": 4949, "name": "Thrall", "faction": "H", "rank": 3, "spawns": { "1454": { "f": "e", "pts": [[31.73, 37.82]] } } },
				"61": { "id": 61, "name": "Thuros", "rank": 4, "roles": ["rare"], "spawns": { "1454": { "f": "e", "pts": [[10, 10]] } } } }),
			json!({ "5726": { "id": 5726, "title": "Hidden Enemies", "level": 16, "end": { "npc": [4949], "object": [] }, "pre": [] } }),
			Some(json!({ "4949": { "rare": false, "roles": [] } })),
		);
		let new = side(
			json!({ "4949": { "id": 4949, "name": "Thrall", "faction": "H", "rank": 3, "roles": ["rare"], "spawns": { "1454": { "f": "l", "pts": pts(30) } } },
				"61": { "id": 61, "name": "Thuros", "rank": 4, "roles": ["rare"], "spawns": { "1454": { "f": "e", "pts": [[10, 10], [11, 11]] } } } }),
			json!({ "5726": { "id": 5726, "title": "Hidden Enemies", "level": 16, "end": { "npc": [4949], "object": [] }, "pre": [5727] } }),
			Some(json!({ "4949": { "rare": true, "roles": ["rare"] } })),
		);
		let rep = diff(&old, &new, &Corrections::default());
		let rules: Vec<(&str, &str)> = rep.violations.iter().map(|v| (v.rule, v.id.as_str())).collect();
		assert_eq!(rules, vec![("ender-moved", "5726"), ("friendly-rare", "4949"), ("leader-spawns", "4949"), ("spawn-jump", "4949")], "{rep:#?}");
		assert!(verdict(&rep).starts_with("data diff: FAIL 4 violation(s)"));
		let thrall = rep.npcs.iter().find(|r| r.id == "4949").unwrap();
		assert!(thrall.big && thrall.changes.iter().any(|c| c == "spawn points 1 -> 30 (big jump)"), "{thrall:?}");
		assert!(thrall.changes.iter().any(|c| c.contains("roles gained") && c.contains("codex:rare") && c.contains("rare")), "{thrall:?}");
		let q = &rep.quests[0];
		assert!(q.changes.iter().any(|c| c == "pre gained 5727") && q.changes.iter().any(|c| c.starts_with("hand-in moved")), "{q:?}");
	}

	#[test]
	fn a_correction_record_and_a_known_place_let_a_change_through() {
		let old = side(json!({ "4949": { "id": 4949, "name": "Thrall", "faction": "H", "rank": 3, "spawns": { "1454": { "f": "e", "pts": [[31.73, 37.82]] } } } }), json!({}), None);
		let new = side(json!({ "4949": { "id": 4949, "name": "Thrall", "faction": "H", "rank": 3, "spawns": { "1454": { "f": "e", "pts": [[31.9, 37.9], [55, 72]] } } } }), json!({}), None);
		let rep = diff(&old, &new, &Corrections::default());
		assert_eq!(rep.violations.iter().map(|v| v.rule).collect::<Vec<_>>(), vec!["leader-spawns"]);
		let corr = Corrections { npcs: ["4949".to_string()].into(), ..Default::default() };
		assert!(diff(&old, &new, &corr).violations.is_empty());
		// A few yards over (the same place, the same count): no change to list.
		let same = side(json!({ "4949": { "id": 4949, "name": "Thrall", "faction": "H", "rank": 3, "spawns": { "1454": { "f": "e", "pts": [[31.9, 37.9]] } } } }), json!({}), None);
		assert_eq!(verdict(&diff(&old, &same, &Corrections::default())), "data diff: PASS, 0 violations; 0 NPCs, 0 objects, 0 quests changed");
	}
}
