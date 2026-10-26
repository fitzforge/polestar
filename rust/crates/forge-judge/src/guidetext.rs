//! The gate's guide-text scorer (port of tools/lib/judge/guidetext.js `scoreTarget`, after its goal list
//! and sim replay): route-quality metrics of a leveling chain, read as a player follows it.
//!
//! - pingpong: zone visits, short A→B→A hops, returns to a zone within 3 levels, continent changes;
//! - log: quest-log size along the route, quests still in the log at the end;
//! - missed: quests not taken whose giver stands within 150/300 yd of a hub goal at a fitting level;
//! - overlap: quest pairs sharing a mob/site whose work is split across visits;
//! - bandSplit: how the sim's level-band packages split same-hub/same-mob pairs.
//!
//! The output is guidetext.js's JSON, key for key (the gate's metric names: `rawTransitions`,
//! `returnsWithin3Levels`, `shortABA`, `continentChanges`, `mergeableNow`, `le150.eligible`, ...), so gate
//! history stays comparable. The goals come in with their levels already replayed ([`crate::walk::LevelModel`]);
//! the sim's run and world are read through a [`SimView`].

use crate::walk::WalkGoal;
use forge_core::{has_bit, js_hypot, js_round, js_to_fixed, js_to_string, Faction, Frame, Projector, RaceInfo, RACES};
use forge_world::data::{GameData, Quest};
use forge_world::{blocking_prereqs, World};
use rustc_hash::{FxHashMap, FxHashSet};
use serde::Deserialize;
use serde_json::{json, Map, Value};
use std::cell::RefCell;
use std::rc::Rc;

pub const NEAR: [f64; 2] = [150.0, 300.0];
pub const OVERLAP_YD: f64 = 100.0;

/// One quest of the sim's run (`run.quests`, in run order): its task points as `[c, wx, wy]`.
#[derive(Clone, Debug, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct SimQuest {
	pub id: u32,
	pub title: String,
	pub level: f64,
	pub hub_giver: Option<i64>,
	pub tasks: Vec<[f64; 3]>,
}

#[derive(Clone, Debug, Deserialize)]
pub struct SimExcluded {
	pub id: u32,
	pub category: Option<String>,
	pub reason: String,
}

#[derive(Clone, Debug, Deserialize)]
pub struct SimPackage {
	pub key: String,
	pub zone: u32,
	pub quests: Vec<u32>,
}

/// What the scorer reads of the sim: the solo run's quests, the world's quest ids, exclusions and level-band
/// packages.
#[derive(Clone, Debug, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct SimView {
	pub run: Vec<SimQuest>,
	pub world_quests: Vec<u32>,
	pub excluded: Vec<SimExcluded>,
	pub packages: Vec<SimPackage>,
	pub band_width: Option<f64>,
	pub data_hash: Option<String>,
}

impl SimView {
	/// The view of a world and the ids of its run's quests (the sim's `makeRun(family:'solo')` selection).
	pub fn from_world(world: &World, run: &[u32]) -> SimView {
		let by_id: FxHashMap<u32, usize> = world.quests.iter().enumerate().map(|(k, q)| (q.id, k)).collect();
		let run = run
			.iter()
			.filter_map(|id| by_id.get(id).map(|&k| &world.quests[k]))
			.map(|q| SimQuest {
				id: q.id,
				title: q.title.clone(),
				level: q.level,
				hub_giver: Some(q.hub_giver),
				tasks: q
					.tasks
					.iter()
					.map(|t| {
						let p = &world.points[t.pt as usize];
						[p.c as f64, p.wx, p.wy]
					})
					.collect(),
			})
			.collect();
		SimView {
			run,
			world_quests: world.quests.iter().map(|q| q.id).collect(),
			excluded: world.excluded.iter().map(|e| SimExcluded { id: e.id, category: e.category.clone(), reason: e.reason.clone() }).collect(),
			packages: world.packages.iter().map(|p| SimPackage { key: p.key.clone(), zone: p.zone, quests: p.quests.clone() }).collect(),
			band_width: Some(world.band_width),
			data_hash: world.data_hash.clone(),
		}
	}
}

/// The sim's consensus export (`<export>/consensus-<faction>-<race>/visits.json`), as the scorer sums it.
#[derive(Clone, Debug)]
pub struct Consensus {
	pub summary: Value,
	pub quest_ids: FxHashSet<u32>,
}

impl Consensus {
	pub fn from_json(bytes: &[u8]) -> Result<Consensus, serde_json::Error> {
		let vj: Value = serde_json::from_slice(bytes)?;
		let empty = Vec::new();
		let visits = vj.get("visits").and_then(Value::as_array).unwrap_or(&empty);
		let mut zc: Vec<(String, usize)> = Vec::new();
		let mut quest_ids = FxHashSet::default();
		for v in visits {
			bump(&mut zc, js_key(v.get("zone").unwrap_or(&Value::Null)));
			for q in v.get("quests").and_then(Value::as_array).unwrap_or(&empty) {
				if let Some(id) = q.get("id").and_then(Value::as_f64) {
					quest_ids.insert(id as u32);
				}
			}
		}
		let zc = js_entries(zc);
		let summary = json!({
			"visits": visits.len(),
			"distinct": zc.len(),
			"zones3plus": zc.iter().filter(|(_, n)| *n >= 3).map(|(z, n)| format!("{z} x{n}")).collect::<Vec<_>>(),
			"hours": vj.get("hours").cloned().unwrap_or(Value::Null),
		});
		Ok(Consensus { summary, quest_ids })
	}
}

/// Every quest id documented in guide text: a comment or note line (`#` first, or `--` anywhere) naming the
/// id while the file also holds the first 14 characters of the quest's title. `files`: (path relative to the
/// guides dir's parent, text) in walk order; refs are `path:line`.
pub fn mentions(files: &[(String, String)], data: &GameData) -> FxHashMap<u32, Vec<String>> {
	let mut out: FxHashMap<u32, Vec<String>> = FxHashMap::default();
	for (rel, text) in files {
		let low = text.to_lowercase();
		for (i, l) in text.split('\n').enumerate() {
			if !l.trim_start().starts_with('#') && !l.contains("--") {
				continue;
			}
			let b = l.as_bytes();
			let mut k = 0;
			while k < b.len() {
				if !is_word(b[k]) {
					k += 1;
					continue;
				}
				let s = k;
				while k < b.len() && is_word(b[k]) {
					k += 1;
				}
				let tok = &l[s..k];
				if tok.len() > 6 || !tok.bytes().all(|c| c.is_ascii_digit()) {
					continue;
				}
				let id: u32 = tok.parse().unwrap_or(0);
				if id < 2 {
					continue;
				}
				let Some(q) = data.quests.get(&id) else { continue };
				let t: String = q.title.as_deref().unwrap_or("").to_lowercase().chars().take(14).collect();
				if t.is_empty() || !low.contains(&t) {
					continue;
				}
				out.entry(id).or_default().push(format!("{rel}:{}", i + 1));
			}
		}
	}
	out
}

fn is_word(c: u8) -> bool {
	c.is_ascii_alphanumeric() || c == b'_'
}

/// The guide files mentions() reads: `<guides>/forever` (else `<guides>`), depth first in name order, paths
/// relative to the guides dir's parent.
#[cfg(feature = "native")]
pub fn guide_texts(guides: &std::path::Path) -> std::io::Result<Vec<(String, String)>> {
	fn walk(d: &std::path::Path, out: &mut Vec<std::path::PathBuf>) -> std::io::Result<()> {
		let mut es: Vec<_> = std::fs::read_dir(d)?.collect::<Result<_, _>>()?;
		es.sort_by_key(|e| e.file_name());
		for e in es {
			let p = e.path();
			if e.file_type()?.is_dir() {
				walk(&p, out)?;
			} else if p.extension().is_some_and(|x| x == "guide") {
				out.push(p);
			}
		}
		Ok(())
	}
	let top = if guides.join("forever").exists() { guides.join("forever") } else { guides.to_path_buf() };
	let root = guides.parent().unwrap_or(guides);
	let mut files = Vec::new();
	walk(&top, &mut files)?;
	files
		.into_iter()
		.map(|f| {
			let rel = f.strip_prefix(root).unwrap_or(&f).to_string_lossy().into_owned();
			Ok((rel, std::fs::read_to_string(&f)?))
		})
		.collect()
}

/// guidetext.js's goal list of a guides dir's chain: every goal for this character's `only` clauses (no
/// turned-in skip, no level cut), `file` relative to the guides dir's parent. Levels and time are left for a
/// [`crate::walk::LevelModel`].
#[cfg(feature = "native")]
pub fn chain_goals(guides_dir: &std::path::Path, data_dir: &std::path::Path, chain: &[String], faction: Faction, race: &str, proj: &Projector) -> Result<Vec<WalkGoal>, String> {
	use forge_guide::js::V;
	let data = forge_guide::data::load_data(data_dir)?;
	let guides = forge_guide::project::compile_project(guides_dir, &V::Undef, &data, forge_guide::diag::Diagnostics::new(), false, None).guides;
	let ctx = crate::walk::Ctx::new(faction.name(), race, None)?;
	let root = guides_dir.parent().unwrap_or(guides_dir).to_path_buf();
	let cwd = std::env::current_dir().unwrap_or_default();
	let file_of = |g: &V| {
		let ast = g.hidden("_ast");
		if ast.is_nullish() {
			return g.get("id").to_js_string();
		}
		let f = cwd.join(ast.get("file").to_js_string());
		f.strip_prefix(&root).unwrap_or(&f).to_string_lossy().into_owned()
	};
	let (mut goals, _) = crate::walk::chain_goals(&guides, &file_of, chain, &ctx, proj, false)?;
	let mut last = None;
	for g in &mut goals {
		if g.w.is_some() {
			last = g.w;
		}
		g.pos = g.w.or(last);
	}
	Ok(goals)
}

/// The consensus export of a faction and race key, None when absent.
#[cfg(feature = "native")]
pub fn load_consensus(export: &std::path::Path, faction: Faction, race_key: &str) -> Option<Consensus> {
	let b = std::fs::read(export.join(format!("consensus-{}-{race_key}", faction.lower())).join("visits.json")).ok()?;
	Consensus::from_json(&b).ok()
}

/// One scoring run.
pub struct Inputs<'a> {
	pub data: &'a GameData,
	pub proj: &'a Projector,
	/// The target's source (`polestar`, `file`, a stream name), faction and race as written.
	pub src: &'a str,
	pub faction: Faction,
	pub race: &'a str,
	pub chain: &'a [String],
	/// The chain's goals in route order, levels and time replayed.
	pub goals: &'a [WalkGoal],
	pub sim: &'a SimView,
	pub consensus: Option<&'a Consensus>,
	pub mentioned: &'a FxHashMap<u32, Vec<String>>,
}

/// guidetext.js raceKey: lower case without spaces, `_` or `-`.
pub fn race_key(race: &str) -> String {
	race.to_lowercase().chars().filter(|c| !c.is_whitespace() && *c != '_' && *c != '-').collect()
}

pub fn race_info(race: &str) -> Option<&'static RaceInfo> {
	let k = race_key(race);
	RACES.iter().find(|r| r.key == k)
}

#[derive(Clone, Copy)]
struct P {
	c: i64,
	wx: f64,
	wy: f64,
}

fn d2(a: Option<P>, b: Option<P>) -> f64 {
	match (a, b) {
		(Some(a), Some(b)) if a.c == b.c => js_hypot(a.wx - b.wx, a.wy - b.wy),
		_ => f64::INFINITY,
	}
}

/// `+x.toFixed(d)` as a JSON number.
fn fx(x: f64, d: usize) -> Value {
	num(js_to_fixed(x, d).parse::<f64>().unwrap_or(f64::NAN))
}

fn num(x: f64) -> Value {
	if x.is_finite() && x == x.trunc() && x.abs() < 9.0e15 {
		Value::from(x as i64)
	} else {
		serde_json::Number::from_f64(x).map(Value::Number).unwrap_or(Value::Null)
	}
}

fn opt_num(x: Option<f64>) -> Value {
	x.map(num).unwrap_or(Value::Null)
}

/// JS `String(v)` of an object key.
fn js_key(v: &Value) -> String {
	match v {
		Value::String(s) => s.clone(),
		Value::Number(n) => js_to_string(n.as_f64().unwrap_or(f64::NAN)),
		Value::Null => "null".into(),
		other => other.to_string(),
	}
}

fn bump(v: &mut Vec<(String, usize)>, k: String) {
	match v.iter_mut().find(|(x, _)| *x == k) {
		Some(e) => e.1 += 1,
		None => v.push((k, 1)),
	}
}

/// `Object.entries` order of an insertion-ordered key list: array-index keys ascending first.
fn js_entries<T>(v: Vec<(String, T)>) -> Vec<(String, T)> {
	let idx = |k: &str| -> Option<u32> {
		let n: u32 = k.parse().ok()?;
		(n != u32::MAX && n.to_string() == k).then_some(n)
	};
	let (mut a, b): (Vec<_>, Vec<_>) = v.into_iter().partition(|(k, _)| idx(k).is_some());
	a.sort_by_key(|(k, _)| idx(k));
	a.extend(b);
	a
}

fn counts_desc(v: Vec<(String, usize)>) -> Vec<String> {
	let mut e: Vec<_> = js_entries(v).into_iter().filter(|(_, n)| *n >= 3).collect();
	e.sort_by_key(|x| std::cmp::Reverse(x.1));
	e.into_iter().map(|(z, n)| format!("{z} x{n}")).collect()
}

fn enemy(faction: &Option<String>) -> bool {
	faction.as_deref().is_some_and(|f| matches!(f.to_uppercase().as_str(), "A" | "H" | "AH"))
}

/// The byWhy key: `why.replace(/:.*?(dungeon|raid|pvp|elite|rareDrop|reputation|repeatable).*/, ': $1')`,
/// cut to 60 characters.
fn why_key(why: &str) -> String {
	const WORDS: [&str; 7] = ["dungeon", "raid", "pvp", "elite", "rareDrop", "reputation", "repeatable"];
	let mut s = why.to_string();
	if let Some(c) = why.find(':') {
		let rest = &why[c + 1..];
		let hit = (0..=rest.len()).filter(|&k| rest.is_char_boundary(k)).find_map(|k| WORDS.iter().find(|w| rest[k..].starts_with(*w)));
		if let Some(w) = hit {
			s = format!("{}: {w}", &why[..c]);
		}
	}
	let u: Vec<u16> = s.encode_utf16().take(60).collect();
	String::from_utf16_lossy(&u)
}

struct Visit {
	zone: u32,
	name: String,
	n: usize,
	start: usize,
	end: usize,
	lvl_in: f64,
	lvl_out: f64,
	hours: f64,
	rf: String,
}

struct Ctx<'a> {
	data: &'a GameData,
	proj: &'a Projector,
	spawns: RefCell<FxHashMap<String, Rc<Vec<P>>>>,
}

impl Ctx<'_> {
	fn zname(&self, m: Option<u32>) -> String {
		match m {
			Some(m) => self.data.zones.get(&m).and_then(|z| z.name.clone()).unwrap_or_else(|| format!("map {m}")),
			None => "map undefined".into(),
		}
	}
	fn q(&self, id: i64) -> Option<&Quest> {
		u32::try_from(id).ok().and_then(|id| self.data.quests.get(&id))
	}
	/// Spawn points (world) of an npc/object, the first 400 per map.
	fn spawn_pts(&self, npc: bool, id: &str) -> Rc<Vec<P>> {
		let key = format!("{}:{id}", if npc { "npc" } else { "obj" });
		if let Some(v) = self.spawns.borrow().get(&key) {
			return v.clone();
		}
		let rec = id.parse::<u32>().ok().and_then(|id| if npc { self.data.npcs.get(&id) } else { self.data.objects.get(&id) });
		let mut out = Vec::new();
		if let Some(rec) = rec {
			for (&map, sp) in &rec.spawns {
				// Era only when the spawn says so; no frame is the live map.
				let f = if sp.f.as_deref() == Some("e") { Frame::Era } else { Frame::Live };
				let more = sp.more.as_deref().unwrap_or(&[]);
				for p in sp.pts.iter().chain(more).take(400) {
					let (Some(&x), Some(&y)) = (p.first(), p.get(1)) else { continue };
					if !x.is_finite() || !y.is_finite() {
						continue;
					}
					let r = self.proj.point(map, x, y, Some(f));
					out.push(P { c: r.c, wx: r.wx, wy: r.wy });
				}
			}
		}
		let out = Rc::new(out);
		self.spawns.borrow_mut().insert(key, out.clone());
		out
	}
	/// Targets of a quest: npc ids killed or looted, object ids used (insertion order).
	fn targets(&self, qid: i64) -> Vec<String> {
		let mut ids: Vec<String> = Vec::new();
		let mut add = |s: String| {
			if !ids.contains(&s) {
				ids.push(s);
			}
		};
		let Some(q) = self.q(qid) else { return ids };
		let idstr = |v: Option<f64>| v.map(js_to_string).unwrap_or_else(|| "null".into());
		for o in q.objectives.iter().flatten() {
			match o.kind.as_str() {
				"kill" => {
					let n = o.id.and_then(|i| self.data.npcs.get(&(i as u32)));
					if n.is_some_and(|n| enemy(&n.faction)) {
						continue;
					}
					add(format!("npc:{}", idstr(o.id)));
				}
				"object" => add(format!("obj:{}", idstr(o.id))),
				"item" => {
					let Some(drops) = o.id.and_then(|i| self.data.items.get(&(i as u32))).and_then(|it| it.drops.as_ref()) else { continue };
					for (nid, ch) in &drops.npc {
						if ch.is_some_and(|c| c < 5.0) {
							continue;
						}
						if self.data.npcs.get(nid).is_some_and(|n| enemy(&n.faction)) {
							continue;
						}
						add(format!("npc:{nid}"));
					}
					for (oid, ch) in &drops.object {
						if ch.is_some_and(|c| c < 5.0) {
							continue;
						}
						add(format!("obj:{oid}"));
					}
				}
				_ => {}
			}
		}
		ids
	}
	fn target_pts(&self, s: &str) -> Option<Rc<Vec<P>>> {
		if let Some(id) = s.strip_prefix("npc:") {
			Some(self.spawn_pts(true, id))
		} else {
			s.strip_prefix("obj:").map(|id| self.spawn_pts(false, id))
		}
	}
}

fn wp(g: &WalkGoal) -> Option<P> {
	g.w.map(|w| P { c: w.c, wx: w.wx, wy: w.wy })
}

fn rf(g: &WalkGoal) -> String {
	format!("{}:{}", g.file, g.line.map(|l| l.to_string()).unwrap_or_else(|| "undefined".into()))
}

const WORK: [&str; 5] = ["kill", "collect", "interact", "use", "complete"];

/// guidetext.js scoreTarget's result (`{src, faction, race, chain, worldHash, pingpong, log, missed, overlap,
/// bandSplit}`).
pub fn score(inp: &Inputs) -> Value {
	let cx = Ctx { data: inp.data, proj: inp.proj, spawns: RefCell::new(FxHashMap::default()) };
	let goals = inp.goals;
	let sim = inp.sim;
	let pos: Vec<Option<P>> = {
		let mut last = None;
		goals
			.iter()
			.map(|g| {
				if let Some(w) = wp(g) {
					last = Some(w);
				}
				wp(g).or(last)
			})
			.collect()
	};
	let (end_level, end_time) = goals.last().map(|g| (g.lvl_after, g.time_after)).unwrap_or((1.0, 0.0));

	// ================= (a) zone ping-pong =================
	let mut visits: Vec<Visit> = Vec::new();
	for g in goals {
		let Some(z) = g.map else { continue };
		if ["fly", "hearth", "note", "level"].contains(&g.t.as_str()) {
			continue;
		}
		match visits.last_mut() {
			Some(v) if v.zone == z => {
				v.n += 1;
				v.end = g.i;
			}
			_ => visits.push(Visit { zone: z, name: cx.zname(Some(z)), n: 1, start: g.i, end: g.i, lvl_in: 0.0, lvl_out: 0.0, hours: 0.0, rf: String::new() }),
		}
	}
	for v in &mut visits {
		let (s, e) = (&goals[v.start], &goals[v.end]);
		v.lvl_in = s.lvl;
		v.lvl_out = e.lvl_after;
		v.hours = (e.time_after - s.time) / 3600.0;
		v.rf = rf(s);
	}
	let mut zone_count = Vec::new();
	for v in &visits {
		bump(&mut zone_count, v.name.clone());
	}
	let mut sv: Vec<Visit> = Vec::new();
	for v in visits.iter().filter(|v| v.n >= 3 || v.hours >= 0.1) {
		match sv.last_mut() {
			Some(l) if l.zone == v.zone => {
				l.n += v.n;
				l.end = v.end;
				l.lvl_out = v.lvl_out;
				l.hours += v.hours;
			}
			_ => sv.push(Visit { zone: v.zone, name: v.name.clone(), n: v.n, start: v.start, end: v.end, lvl_in: v.lvl_in, lvl_out: v.lvl_out, hours: v.hours, rf: v.rf.clone() }),
		}
	}
	let mut s_count = Vec::new();
	for v in &sv {
		bump(&mut s_count, v.name.clone());
	}
	let mut aba = Vec::new();
	for k in 1..visits.len().saturating_sub(1) {
		let (a, b, c) = (&visits[k - 1], &visits[k], &visits[k + 1]);
		if a.zone == c.zone && (b.n <= 3 || b.hours < 0.25) {
			aba.push(json!({ "A": a.name, "B": b.name, "bGoals": b.n, "bHours": fx(b.hours, 2), "lvl": fx(b.lvl_in, 1), "ref": b.rf }));
		}
	}
	let mut s_aba = Vec::new();
	for k in 0..sv.len() {
		for j in k + 2..sv.len() {
			if sv[j].zone != sv[k].zone {
				continue;
			}
			if sv[j].lvl_in - sv[k].lvl_out < 3.0 {
				s_aba.push(json!({
					"zone": sv[k].name, "leaveLvl": fx(sv[k].lvl_out, 1), "backLvl": fx(sv[j].lvl_in, 1),
					"via": sv[k + 1..j].iter().map(|x| x.name.clone()).collect::<Vec<_>>(),
					"refLeave": rf(&goals[sv[k].end]), "refBack": sv[j].rf,
				}));
			}
			break;
		}
	}
	let (mut cont_changes, mut flights, mut hearths, mut last_c) = (0usize, 0usize, 0usize, None);
	for g in goals {
		if g.t == "fly" {
			flights += 1;
		}
		if g.t == "hearth" {
			hearths += 1;
		}
		if let Some(w) = g.w {
			if last_c.is_some_and(|c| c != w.c) {
				cont_changes += 1;
			}
			last_c = Some(w.c);
		}
	}
	let empty_ids = FxHashSet::default();
	let sim_quest_ids = inp.consensus.map(|c| &c.quest_ids).unwrap_or(&empty_ids);
	let distinct = js_entries(zone_count.clone()).len();
	let pingpong = json!({
		"guides": inp.chain.len(), "goals": goals.len(),
		"rawVisits": visits.len(), "rawTransitions": visits.len() as i64 - 1, "distinctZones": distinct,
		"rawZones3plus": counts_desc(zone_count),
		"substantialVisits": sv.len(),
		"substZones3plus": counts_desc(s_count),
		"shortABA": aba.len(), "returnsWithin3Levels": s_aba.len(), "continentChanges": cont_changes, "flyGoals": flights, "hearthGoals": hearths,
		"endLevel": fx(end_level, 2), "simHours": fx(end_time / 3600.0, 1),
		"simConsensus": inp.consensus.map(|c| c.summary.clone()).unwrap_or(Value::Null),
		"visitsList": sv.iter().map(|v| format!("{} {}-{} ({} goals, {} h) {}", v.name, js_to_fixed(v.lvl_in, 1), js_to_fixed(v.lvl_out, 1), v.n, js_to_fixed(v.hours, 2), v.rf)).collect::<Vec<_>>(),
		"abaExamples": aba, "returnExamples": s_aba,
	});

	// ================= quest log timeline (d) =================
	let mut accept_at: FxHashMap<i64, usize> = FxHashMap::default();
	let mut accept_order: Vec<i64> = Vec::new();
	let mut turnin_at: FxHashMap<i64, usize> = FxHashMap::default();
	let mut turnin_order: Vec<i64> = Vec::new();
	let mut work_goals: Vec<(i64, Vec<usize>)> = Vec::new();
	let mut work_ix: FxHashMap<i64, usize> = FxHashMap::default();
	for g in goals {
		let Some(q) = g.q else { continue };
		if g.t == "accept" && !accept_at.contains_key(&q) {
			accept_at.insert(q, g.i);
			accept_order.push(q);
		} else if g.t == "turnin" {
			if turnin_at.insert(q, g.i).is_none() {
				turnin_order.push(q);
			}
		} else if WORK.contains(&g.t.as_str()) {
			let k = *work_ix.entry(q).or_insert_with(|| {
				work_goals.push((q, Vec::new()));
				work_goals.len() - 1
			});
			work_goals[k].1.push(g.i);
		}
	}
	let mut active: Vec<i64> = Vec::new();
	let (mut max_log, mut max_at, mut over20, mut over25, mut over30) = (0usize, None::<usize>, 0usize, 0usize, 0usize);
	let mut log_at = vec![0usize; goals.len()];
	for g in goals {
		if let Some(q) = g.q {
			if g.t == "accept" && !active.contains(&q) {
				active.push(q);
			}
			if g.t == "turnin" {
				active.retain(|&x| x != q);
			}
		}
		log_at[g.i] = active.len();
		if active.len() > max_log {
			max_log = active.len();
			max_at = Some(g.i);
		}
		over20 += (active.len() > 20) as usize;
		over25 += (active.len() > 25) as usize;
		over30 += (active.len() > 30) as usize;
	}
	let dangling: Vec<Value> = active
		.iter()
		.map(|&q| {
			let mut m = Map::new();
			m.insert("q".into(), json!(q));
			if let Some(t) = cx.q(q).and_then(|r| r.title.clone()) {
				m.insert("title".into(), json!(t));
			}
			m.insert("accepted".into(), json!(rf(&goals[accept_at[&q]])));
			Value::Object(m)
		})
		.collect();
	let mut per_band: Vec<(String, usize)> = Vec::new();
	for g in goals {
		let b = (g.lvl / 10.0).floor() * 10.0;
		let k = format!("{}-{}", js_to_string(b), js_to_string(b + 9.0));
		let l = log_at[g.i];
		match per_band.iter_mut().find(|(x, _)| *x == k) {
			Some(e) => e.1 = e.1.max(l),
			None => per_band.push((k, l)),
		}
	}
	let log_info = json!({
		"max": max_log, "maxAtLevel": max_at.map(|i| fx(goals[i].lvl, 1)).unwrap_or(Value::Null), "maxRef": max_at.map(|i| json!(rf(&goals[i]))).unwrap_or(Value::Null),
		"goalsOver20": over20, "goalsOver25": over25, "goalsOver30": over30, "of": goals.len(),
		"maxPerLevelBand": per_band.into_iter().map(|(k, v)| (k, json!(v))).collect::<Map<_, _>>(),
		"danglingAtEnd": dangling.len(), "dangling": dangling.iter().take(20).cloned().collect::<Vec<_>>(),
		"questsAccepted": accept_at.len(),
		"questsInLogAtMax": Value::Null,
	});

	// ================= (b) missed nearby quests =================
	let mut taken_order = accept_order.clone();
	for &q in &turnin_order {
		if !accept_at.contains_key(&q) {
			taken_order.push(q);
		}
	}
	let taken: FxHashSet<i64> = taken_order.iter().copied().collect();
	let hub_goals: Vec<&WalkGoal> = goals.iter().filter(|g| g.w.is_some() && ["accept", "turnin", "talk", "sethome", "vendor", "train", "getfp"].contains(&g.t.as_str())).collect();
	let run_ids: FxHashSet<u32> = sim.run.iter().map(|q| q.id).collect();
	let world_ids: FxHashSet<u32> = sim.world_quests.iter().copied().collect();
	let mut excl_by_id: FxHashMap<u32, &SimExcluded> = FxHashMap::default();
	for e in &sim.excluded {
		excl_by_id.insert(e.id, e);
	}
	let quest_of = |id: i64| cx.q(id);
	let prereq_ok_at = |b: &forge_world::Blocking, idx: usize| -> bool {
		let done = |p: &i64| turnin_at.get(p).is_some_and(|&t| t < idx);
		if !b.all.iter().all(done) {
			return false;
		}
		b.any.is_empty() || b.any.iter().any(done)
	};
	let race = race_info(inp.race);
	struct Missed {
		v: Map<String, Value>,
		id: u32,
		eligible: bool,
		mentioned: bool,
		dist: f64,
		xp: f64,
	}
	let mut missed: Vec<Missed> = Vec::new();
	for (&id, qrec) in &inp.data.quests {
		if taken.contains(&(id as i64)) {
			continue;
		}
		if let Some(r) = qrec.races.filter(|&r| r != 0.0) {
			if !has_bit(r as u64, race.map(|x| x.bit(inp.faction)).unwrap_or(0)) {
				continue;
			}
		}
		if !matches!(qrec.classes, None | Some(0.0) | Some(1535.0) | Some(2047.0)) {
			continue;
		}
		let level = match qrec.level {
			Some(l) if l != 0.0 && !l.is_nan() && l >= 1.0 => l,
			_ => continue,
		};
		let mut giver: Vec<P> = Vec::new();
		for &n in &qrec.start.npc {
			let f = u32::try_from(n).ok().and_then(|n| inp.data.npcs.get(&n)).and_then(|r| r.faction.as_deref()).filter(|f| !f.is_empty()).map(str::to_uppercase);
			if let Some(f) = f {
				if (inp.faction == Faction::Horde && f == "A") || (inp.faction == Faction::Alliance && f == "H") {
					continue;
				}
			}
			giver.extend(cx.spawn_pts(true, &n.to_string()).iter());
		}
		for &o in &qrec.start.object {
			giver.extend(cx.spawn_pts(false, &o.to_string()).iter());
		}
		if giver.is_empty() {
			continue;
		}
		let min_l = qrec.min_level.filter(|&m| m != 0.0 && !m.is_nan()).unwrap_or_else(|| (level - 5.0).max(1.0));
		let mut blocking = None;
		let mut best: Option<(f64, &WalkGoal, usize)> = None;
		for h in &hub_goals {
			let l = h.lvl;
			if l < min_l || l < level - 3.0 || l > level + 5.0 {
				continue;
			}
			let hw = wp(h);
			let dmin = giver.iter().map(|p| d2(Some(*p), hw)).fold(f64::INFINITY, f64::min);
			if dmin > NEAR[1] {
				continue;
			}
			let b = blocking.get_or_insert_with(|| blocking_prereqs(qrec, &quest_of));
			if !prereq_ok_at(b, h.i) {
				continue;
			}
			// guidetext.js replaces `best` on a closer hub, so `n` counts the hubs since the closest one
			match &mut best {
				Some(b) if dmin >= b.0 => b.2 += 1,
				_ => best = Some((dmin, h, 1)),
			}
		}
		let Some((bd, bh, bn)) = best else { continue };
		if qrec.excl.iter().any(|e| taken.contains(e)) {
			continue;
		}
		let why = if run_ids.contains(&id) {
			"solo-eligible (sim run has it)".to_string()
		} else if let Some(e) = excl_by_id.get(&id) {
			format!("sim-excluded: {} {}", e.category.as_deref().unwrap_or(""), e.reason)
		} else if world_ids.contains(&id) {
			"in world, not open to this race/start".into()
		} else {
			"not in sim world (faction mask/filtered)".into()
		};
		let men: Vec<String> = inp.mentioned.get(&id).map(|v| v.iter().take(3).cloned().collect()).unwrap_or_default();
		let dist = js_round(bd);
		let xp = qrec.xp.filter(|&x| x != 0.0 && !x.is_nan());
		let mut v = Map::new();
		v.insert("id".into(), json!(id));
		if let Some(t) = &qrec.title {
			v.insert("title".into(), json!(t));
		}
		v.insert("level".into(), num(level));
		// quests.json carries `minLevel` on every record (null on some)
		v.insert("minLevel".into(), opt_num(qrec.min_level));
		// zname(null): every record carries `zone`, null on some
		v.insert("zone".into(), json!(qrec.zone.map_or_else(|| "map null".to_string(), |z| cx.zname(Some(z as u32)))));
		v.insert("xp".into(), opt_num(xp));
		v.insert("dist".into(), num(dist));
		v.insert("hubVisitsNear".into(), json!(bn));
		v.insert("atLevel".into(), fx(bh.lvl, 1));
		v.insert("nearRef".into(), json!(rf(bh)));
		v.insert("nearGoal".into(), json!(format!("{} {}", bh.t, bh.title.as_deref().unwrap_or("")).trim()));
		v.insert("why".into(), json!(why));
		v.insert("eligible".into(), json!(run_ids.contains(&id)));
		v.insert("simTakes".into(), json!(sim_quest_ids.contains(&id)));
		v.insert("mentionedIn".into(), json!(men));
		v.insert("repeatable".into(), json!(qrec.repeatable.unwrap_or(false)));
		missed.push(Missed { v, id, eligible: run_ids.contains(&id), mentioned: !men.is_empty(), dist, xp: xp.unwrap_or(0.0) });
	}
	missed.sort_by(|a, b| {
		b.eligible
			.cmp(&a.eligible)
			.then(a.mentioned.cmp(&b.mentioned))
			.then(a.dist.partial_cmp(&b.dist).unwrap_or(std::cmp::Ordering::Equal))
			.then(b.xp.partial_cmp(&a.xp).unwrap_or(std::cmp::Ordering::Equal))
	});
	let summarize = |r: f64| -> Value {
		let list: Vec<&Missed> = missed.iter().filter(|m| m.dist <= r).collect();
		let mut by_why: Vec<(String, usize)> = Vec::new();
		for m in &list {
			bump(&mut by_why, why_key(m.v["why"].as_str().unwrap_or("")));
		}
		json!({
			"total": list.len(),
			"eligible": list.iter().filter(|m| m.eligible).count(),
			"eligibleUndocumented": list.iter().filter(|m| m.eligible && !m.mentioned).count(),
			"eligibleDocumented": list.iter().filter(|m| m.eligible && m.mentioned).count(),
			"eligibleSimTakes": list.iter().filter(|m| m.eligible && sim_quest_ids.contains(&m.id)).count(),
			"byWhy": by_why.into_iter().map(|(k, v)| (k, json!(v))).collect::<Map<_, _>>(),
		})
	};
	let (le0, le1) = (summarize(NEAR[0]), summarize(NEAR[1]));

	// ================= (c) un-merged kill/collect overlap =================
	let mut tg: FxHashMap<i64, Rc<Vec<String>>> = FxHashMap::default();
	for &q in &taken_order {
		tg.insert(q, Rc::new(cx.targets(q)));
	}
	let work_of: Vec<(i64, &Vec<usize>)> = work_goals.iter().filter(|(q, _)| taken.contains(q)).map(|(q, v)| (*q, v)).collect();
	let work_map: FxHashMap<i64, &Vec<usize>> = work_of.iter().copied().collect();
	let lvl_ok = |q: i64, g: &WalkGoal| -> bool {
		cx.q(q).is_some_and(|r| {
			let ml = r.min_level.filter(|&m| m != 0.0 && !m.is_nan()).unwrap_or(1.0);
			g.lvl >= ml && r.level.is_some_and(|l| g.lvl >= l - 4.0)
		})
	};
	let in_log = |q: i64, idx: usize| -> bool {
		match accept_at.get(&q) {
			Some(&a) => a < idx && turnin_at.get(&q).is_none_or(|&t| t > idx),
			None => true,
		}
	};
	let near_work = |s: &str, ws: &[usize]| -> bool {
		let Some(pts) = cx.target_pts(s) else { return false };
		ws.iter().any(|&x| wp(&goals[x]).is_some_and(|w| pts.iter().any(|p| d2(Some(*p), Some(w)) <= 300.0)))
	};
	struct Pair {
		v: Map<String, Value>,
		first: i64,
		second: i64,
		/// guidetext.js `lvl2 && pre2`: undefined (no key) when the second quest has no record.
		avail: Option<bool>,
		site: bool,
		gap: f64,
	}
	let mut pairs: Vec<Pair> = Vec::new();
	for a in 0..work_of.len() {
		for b in a + 1..work_of.len() {
			let (qa, wa) = work_of[a];
			let (qb, wb) = work_of[b];
			let (ta, tb) = (&tg[&qa], &tg[&qb]);
			let shared: Vec<&String> = ta.iter().filter(|x| tb.contains(x) && near_work(x, wa) && near_work(x, wb)).collect();
			let mut near: Option<f64> = None;
			for &x in wa.iter() {
				for &y in wb.iter() {
					let (gx, gy) = (&goals[x], &goals[y]);
					if gx.w.is_none() || gy.w.is_none() || gx.t == "complete" || gy.t == "complete" {
						continue;
					}
					let d = d2(wp(gx), wp(gy));
					if d <= OVERLAP_YD && near.is_none_or(|n| d < n) {
						near = Some(d);
					}
				}
			}
			if shared.is_empty() && near.is_none() {
				continue;
			}
			let (last_a, last_b, first_a, first_b) = (*wa.last().unwrap(), *wb.last().unwrap(), wa[0], wb[0]);
			let same_step = wa.iter().any(|&x| wb.iter().any(|&y| goals[x].file == goals[y].file && goals[x].step == goals[y].step));
			let acc = |q: i64| accept_at.get(&q).map(|&a| a as i64).unwrap_or(-1);
			let overlap_win = wa.iter().any(|&x| in_log(qb, x) && x < last_b && x as i64 > acc(qb)) || wb.iter().any(|&y| in_log(qa, y) && y < last_a && y as i64 > acc(qa));
			let order = if last_a < first_b {
				Some((wa, wb, qa, qb))
			} else if last_b < first_a {
				Some((wb, wa, qb, qa))
			} else {
				None
			};
			if same_step || overlap_win {
				continue;
			}
			let Some((e1, e2, q_first, q_second)) = order else { continue };
			let (end_first, start_second) = (&goals[*e1.last().unwrap()], &goals[e2[0]]);
			let gap_h = (start_second.time - end_first.time_after) / 3600.0;
			let mut max_away = 0.0f64;
			for k in end_first.i + 1..start_second.i {
				let d = d2(pos[k], pos[end_first.i]);
				if d > max_away {
					max_away = d;
				}
			}
			if max_away < 250.0 {
				continue;
			}
			let rec2 = cx.q(q_second);
			let lvl2 = lvl_ok(q_second, end_first);
			let pre2 = rec2.is_some_and(|r| prereq_ok_at(&blocking_prereqs(r, &quest_of), end_first.i));
			let same_visit = visits.iter().any(|v| v.start <= end_first.i && v.end >= start_second.i);
			let kind = if !shared.is_empty() { "same-mob-id" } else { "site<=100yd" };
			let mut v = Map::new();
			v.insert("first".into(), json!(q_first));
			if let Some(t) = cx.q(q_first).and_then(|r| r.title.clone()) {
				v.insert("firstTitle".into(), json!(t));
			}
			v.insert("second".into(), json!(q_second));
			if let Some(t) = rec2.and_then(|r| r.title.clone()) {
				v.insert("secondTitle".into(), json!(t));
			}
			let mobs: Vec<String> = shared
				.iter()
				.take(3)
				.map(|s| match s.strip_prefix("npc:") {
					Some(id) => {
						let name = id.parse::<u32>().ok().and_then(|i| inp.data.npcs.get(&i)).and_then(|n| n.name.clone()).filter(|n| !n.is_empty());
						format!("{} ({id})", name.unwrap_or_else(|| (*s).clone()))
					}
					None => (*s).clone(),
				})
				.collect();
			v.insert("sharedMob".into(), json!(mobs));
			v.insert("siteDist".into(), near.map(|d| num(js_round(d))).unwrap_or(Value::Null));
			v.insert("gapHours".into(), fx(gap_h, 2));
			v.insert("awayYd".into(), if max_away.is_finite() { num(js_round(max_away)) } else { json!("other continent") });
			v.insert("lvlFirst".into(), fx(end_first.lvl, 1));
			v.insert("lvlSecond".into(), fx(start_second.lvl, 1));
			v.insert("zone".into(), json!(cx.zname(end_first.map.or(pos_map(goals, end_first.i)))));
			v.insert("sameZoneVisit".into(), json!(same_visit));
			let avail = rec2.map(|_| lvl2 && pre2);
			if let Some(a) = avail {
				v.insert("secondAvailableAtFirst".into(), json!(a));
			}
			v.insert(
				"blocker".into(),
				json!(if !pre2 {
					"prereq"
				} else if !lvl2 {
					"level"
				} else {
					"none"
				}),
			);
			v.insert("refFirst".into(), json!(rf(end_first)));
			v.insert("refSecond".into(), json!(rf(start_second)));
			v.insert("secondAcceptRef".into(), accept_at.get(&q_second).map(|&a| json!(rf(&goals[a]))).unwrap_or(Value::Null));
			v.insert("kind".into(), json!(kind));
			let gap = js_to_fixed(gap_h, 2).parse::<f64>().unwrap_or(f64::NAN);
			pairs.push(Pair { v, first: q_first, second: q_second, avail, site: kind == "site<=100yd", gap });
		}
	}
	// JS `b.avail - a.avail` is NaN, so falls through, when either is undefined; a total order needs a
	// value, and undefined sorts as false here (the JS order can differ only between an unknown-quest pair
	// and an available one).
	pairs.sort_by(|a, b| {
		let av = |p: &Pair| p.avail.unwrap_or(false);
		av(b).cmp(&av(a)).then(a.site.cmp(&b.site)).then(b.gap.partial_cmp(&a.gap).unwrap_or(std::cmp::Ordering::Equal))
	});

	// ================= band split (sim packages) =================
	let mut pkg_of: FxHashMap<u32, usize> = FxHashMap::default();
	for (k, p) in sim.packages.iter().enumerate() {
		for &q in &p.quests {
			pkg_of.entry(q).or_insert(k);
		}
	}
	let mut by_zone: Vec<(u32, Vec<&SimQuest>)> = Vec::new();
	for q in &sim.run {
		let Some(&p) = pkg_of.get(&q.id) else { continue };
		let z = sim.packages[p].zone;
		match by_zone.iter_mut().find(|(x, _)| *x == z) {
			Some(e) => e.1.push(q),
			None => by_zone.push((z, vec![q])),
		}
	}
	let mut tg_any = |id: i64| -> Rc<Vec<String>> { tg.entry(id).or_insert_with(|| Rc::new(cx.targets(id))).clone() };
	let (mut same_hub_split, mut same_hub_split_close, mut shared_mob_split, mut shared_mob_split_close, mut same_hub_pairs, mut shared_mob_pairs) = (0, 0, 0, 0, 0, 0);
	let (mut guide_split, mut guide_same) = (0, 0);
	let mut split_ex = Vec::new();
	let visit_of_goal = |idx: usize| -> i64 { visits.iter().position(|v| v.start <= idx && v.end >= idx).map(|k| k as i64).unwrap_or(-1) };
	// near(q, npc): some spawn of the npc within 300 yd of a task point of q (memoized per pair)
	let mut near_memo: FxHashMap<(u32, String), bool> = FxHashMap::default();
	for (_, qs) in &by_zone {
		for a in 0..qs.len() {
			for b in a + 1..qs.len() {
				let (qa, qb) = (qs[a], qs[b]);
				let (pa, pb) = (pkg_of[&qa.id], pkg_of[&qb.id]);
				let hub = qa.hub_giver.is_some() && qa.hub_giver == qb.hub_giver;
				let (ta, tb) = (tg_any(qa.id as i64), tg_any(qb.id as i64));
				let mut near = |q: &SimQuest, x: &str| -> bool {
					*near_memo.entry((q.id, x.to_string())).or_insert_with(|| {
						let sp = cx.spawn_pts(true, &x[4..]);
						q.tasks.iter().any(|t| {
							let tp = P { c: t[0] as i64, wx: t[1], wy: t[2] };
							sp.iter().any(|p| d2(Some(*p), Some(tp)) <= 300.0)
						})
					})
				};
				let mob = ta.iter().any(|x| tb.contains(x) && x.starts_with("npc:") && near(qa, x) && near(qb, x));
				if hub {
					same_hub_pairs += 1;
				}
				if mob {
					shared_mob_pairs += 1;
				}
				if pa == pb || (!hub && !mob) {
					continue;
				}
				let close = (qa.level - qb.level).abs() <= 3.0;
				if hub {
					same_hub_split += 1;
					same_hub_split_close += close as usize;
				}
				if mob {
					shared_mob_split += 1;
					shared_mob_split_close += close as usize;
				}
				if !close {
					continue;
				}
				if let (Some(wa), Some(wb)) = (work_map.get(&(qa.id as i64)), work_map.get(&(qb.id as i64))) {
					let (va, vb) = (visit_of_goal(wa[0]), visit_of_goal(wb[0]));
					if va != vb {
						guide_split += 1;
					} else {
						guide_same += 1;
					}
					if va != vb && mob && split_ex.len() < 40 {
						split_ex.push(json!({
							"a": qa.id, "aTitle": qa.title, "aLvl": num(qa.level), "aPkg": sim.packages[pa].key,
							"b": qb.id, "bTitle": qb.title, "bLvl": num(qb.level), "bPkg": sim.packages[pb].key,
							"sameHub": hub, "sharedMob": mob, "guideA": rf(&goals[wa[0]]), "guideB": rf(&goals[wb[0]]),
						}));
					}
				}
			}
		}
	}
	let band_split = json!({
		"packages": sim.packages.len(), "bandWidth": opt_num(sim.band_width),
		"sameHubPairs": same_hub_pairs, "sameHubSplit": same_hub_split, "sameHubSplitClose": same_hub_split_close,
		"sharedMobPairs": shared_mob_pairs, "sharedMobSplit": shared_mob_split, "sharedMobSplitClose": shared_mob_split_close,
		"closePairsBothInGuide_differentVisits": guide_split, "closePairsBothInGuide_sameVisit": guide_same, "examples": split_ex,
	});
	let pkg = |q: i64| u32::try_from(q).ok().and_then(|q| pkg_of.get(&q)).copied();
	let (mut ov_band, mut ov_same, mut ov_not_run) = (0i64, 0i64, 0i64);
	for p in &pairs {
		match (pkg(p.first), pkg(p.second)) {
			(Some(a), Some(b)) => {
				if a == b {
					ov_same += 1;
				} else if sim.packages[a].zone == sim.packages[b].zone {
					ov_band += 1;
				}
			}
			_ => ov_not_run += 1,
		}
	}
	let mut by_kind: Vec<(String, usize)> = Vec::new();
	for p in &pairs {
		bump(&mut by_kind, p.v["kind"].as_str().unwrap_or("").to_string());
	}
	let overlap = json!({
		"pairs": pairs.len(),
		"byKind": by_kind.into_iter().map(|(k, v)| (k, json!(v))).collect::<Map<_, _>>(),
		"mergeableNow": pairs.iter().filter(|p| p.avail == Some(true)).count(),
		"blockedByPrereq": pairs.iter().filter(|p| p.v["blocker"] == "prereq").count(),
		"blockedByLevel": pairs.iter().filter(|p| p.v["blocker"] == "level").count(),
		"sameZoneVisit": pairs.iter().filter(|p| p.v["sameZoneVisit"] == true).count(),
		"list": pairs.iter().map(|p| {
			let mut v = p.v.clone();
			let s = match (pkg(p.first), pkg(p.second)) {
				(Some(a), Some(b)) => json!(format!("{} | {}", sim.packages[a].key, sim.packages[b].key)),
				_ => Value::Null,
			};
			v.insert("simPkgs".into(), s);
			Value::Object(v)
		}).collect::<Vec<_>>(),
		"simPackages": { "sameZoneDifferentBand": ov_band, "samePackage": ov_same, "differentZonePkg": pairs.len() as i64 - ov_band - ov_same - ov_not_run, "notInSim": ov_not_run },
	});
	let list: Vec<Value> = missed
		.iter()
		.map(|m| {
			let mut v = m.v.clone();
			v.insert("simPkg".into(), pkg_of.get(&m.id).map(|&p| json!(sim.packages[p].key)).unwrap_or(Value::Null));
			Value::Object(v)
		})
		.collect();
	let mut missed_info = Map::new();
	missed_info.insert(format!("le{}", NEAR[0]), le0);
	missed_info.insert(format!("le{}", NEAR[1]), le1);
	missed_info.insert("list".into(), Value::Array(list));

	json!({
		"src": inp.src, "faction": inp.faction.name(), "race": inp.race, "chain": inp.chain,
		"worldHash": sim.data_hash, "pingpong": pingpong, "log": log_info, "missed": missed_info, "overlap": overlap, "bandSplit": band_split,
	})
}

/// `pos?.map` of a goal: the map of the last positioned goal at or before it.
fn pos_map(goals: &[WalkGoal], i: usize) -> Option<u32> {
	goals[..=i].iter().rev().find_map(|g| g.w.map(|w| w.map))
}
