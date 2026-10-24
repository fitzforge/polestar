//! A chain's goals in route order (port of the judge's walk.js). Levels and time come from a
//! [`LevelModel`]: forge-sim's evaluator replay ([`crate::levels::SimLevels`]), or [`DumpLevels`],
//! which replays the levels a JS walk recorded.
//!
//! The chain: the default path of the guides' Polestar routes (baselines/polestar.js
//! loadPolestarRoutes: the race's first leveling guide, then `next`), else the faction's lowest
//! leveling guide for the race followed by `next` (walk.js nextChain).

use forge_core::{Frame, Projector, CLASSES, RACES};
use forge_guide::js::{cmp_utf16, V};
use serde::Serialize;

/// Class lists this long came from a negation (`!Druid`) and count as any class.
pub const ANY_CLASS_MIN: usize = 8;

/// A world point (walk.js `wpt`): continent, world x/y, the uiMapID.
#[derive(Clone, Copy, Debug, PartialEq, Serialize)]
pub struct WPt {
	pub c: i64,
	pub wx: f64,
	pub wy: f64,
	pub map: u32,
}

/// One goal of the walk, as walk.js pushes it (then `lvl`, `time`, `lvl_after`, `time_after`, `pos`).
#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct WalkGoal {
	pub i: usize,
	pub guide: String,
	pub file: String,
	pub line: Option<u32>,
	pub step: Option<u32>,
	/// The verb as the compiled goal names it (`t`).
	pub t: String,
	pub q: Option<i64>,
	pub oi: Option<i64>,
	pub optional: bool,
	pub passing: bool,
	pub map: Option<u32>,
	pub w: Option<WPt>,
	pub npc: Option<u32>,
	pub level: Option<f64>,
	pub title: Option<String>,
	pub lvl: f64,
	pub time: f64,
	pub lvl_after: f64,
	pub time_after: f64,
	/// `w`, else the last known point.
	pub pos: Option<WPt>,
	/// The goal's step is `along` (Some(label) for `along until <label>`, Some("") for a bare `along`);
	/// not in walk.js's goal shape.
	#[serde(skip)]
	pub along: Option<String>,
	/// The goal's step's `label` (not in walk.js's goal shape).
	#[serde(skip)]
	pub label: Option<String>,
}

/// Levels and time along a walk: fills `lvl`, `time`, `lvl_after`, `time_after` and returns where the walk
/// is cut (the first goal begun at level >= `to`), as walk.js does after its evaluator replay.
pub trait LevelModel {
	fn replay(&self, goals: &mut [WalkGoal], to: f64) -> usize;
}

/// Levels recorded by a JS walk (`{ i, lvl, time, lvlAfter, timeAfter }` per goal, in order), replayed onto
/// the same goal list. The parity hook until the sim crate's evaluator lands. The walk is cut where the
/// recording ends.
pub struct DumpLevels(pub Vec<[f64; 4]>);

impl LevelModel for DumpLevels {
	fn replay(&self, goals: &mut [WalkGoal], _to: f64) -> usize {
		let n = goals.len().min(self.0.len());
		for (g, l) in goals.iter_mut().zip(&self.0) {
			g.lvl = l[0];
			g.time = l[1];
			g.lvl_after = l[2];
			g.time_after = l[3];
		}
		n
	}
}

/// The character a walk is for: faction name, race file ("Orc", "Scourge"), class file ("WARRIOR") or any.
#[derive(Clone, Debug)]
pub struct Ctx {
	pub faction: String,
	pub race: String,
	pub cls: Option<String>,
	/// `along` steps as the addon plays them (default): their goals are done on the walk the route
	/// already takes (see [`along_on_the_way`]); false: walked to at the along step, as walk.js does.
	pub along_on_the_way: bool,
}

impl Ctx {
	/// From labels as walk.js takes them (`Undead`/`undead`/`Night Elf`, `warrior`).
	pub fn new(faction: &str, race: &str, cls: Option<&str>) -> Result<Ctx, String> {
		let key: String = race.to_lowercase().chars().filter(|c| !matches!(c, ' ' | '_' | '-' | '\t')).collect();
		let key = if key == "scourge" { "undead".to_string() } else { key };
		let r = RACES.iter().find(|r| r.key == key).ok_or_else(|| format!("judge: unknown race {race}"))?;
		let cls = cls.map(|c| CLASSES.iter().find(|x| x.key == c.to_lowercase()).map_or_else(|| c.to_uppercase(), |x| x.file.to_string()));
		Ok(Ctx { faction: faction.to_string(), race: r.file.to_string(), cls, along_on_the_way: true })
	}
}

fn strs(v: &V) -> Vec<String> {
	v.items().iter().map(V::to_js_string).collect()
}

/// A step/goal `only` clause holds for this character (class lists of 8+ classes count as any class).
pub fn only_holds(only: &V, ctx: &Ctx) -> bool {
	if !only.truthy() {
		return true;
	}
	let f = only.get("factions");
	if f.truthy() && !strs(&f).contains(&ctx.faction) {
		return false;
	}
	let r = only.get("races");
	if r.truthy() && !strs(&r).contains(&ctx.race) {
		return false;
	}
	let c = only.get("classes");
	if c.truthy() {
		return match &ctx.cls {
			Some(cls) => strs(&c).iter().any(|x| x.to_uppercase() == *cls),
			None => c.len() >= ANY_CLASS_MIN,
		};
	}
	true
}

fn leveling<'a>(guides: &'a [V], faction: &str) -> Vec<&'a V> {
	guides.iter().filter(|g| g.get("category").as_str() == Some("Leveling") && (!g.get("faction").truthy() || g.get("faction").to_js_string() == faction)).collect()
}

fn id_of(g: &V) -> String {
	g.get("id").to_js_string()
}

fn level_or(g: &V, k: &str, d: f64) -> f64 {
	let v = g.get(k);
	if v.is_nullish() {
		d
	} else {
		v.num()
	}
}

/// The faction's lowest leveling guide open to the race, then `next` while it names a compiled guide
/// (walk.js nextChain).
pub fn next_chain(guides: &[V], ctx: &Ctx) -> Vec<String> {
	let lv = leveling(guides, &ctx.faction);
	let fits = |g: &V| {
		let r = g.get("races");
		!r.truthy() || r.is_empty() || strs(&r).contains(&ctx.race)
	};
	let mut pointed: Vec<String> = Vec::new();
	for g in &lv {
		let n = g.get("next");
		if n.truthy() {
			pointed.push(n.to_js_string());
		}
		for c in g.get("nextChoices").items() {
			if c.truthy() {
				pointed.push(c.to_js_string());
			}
		}
	}
	let catch_up = |id: &str| {
		let l = id.to_lowercase();
		l.contains("catchup") || l.contains("catch-up")
	};
	let mut starts: Vec<&V> = lv.iter().copied().filter(|g| fits(g) && !pointed.contains(&id_of(g)) && !catch_up(&id_of(g))).collect();
	// localeCompare on ids: ids are lowercase ASCII paths, where it agrees with code unit order for
	// letters and digits.
	starts.sort_by(|a, b| level_or(a, "minLevel", 1.0).total_cmp(&level_or(b, "minLevel", 1.0)).then_with(|| cmp_utf16(&id_of(a), &id_of(b))));
	let mut chain: Vec<String> = Vec::new();
	let mut g = starts.first().copied();
	while let Some(x) = g {
		let id = id_of(x);
		if chain.contains(&id) {
			break;
		}
		chain.push(id);
		let n = x.get("next");
		g = if n.truthy() { lv.iter().copied().find(|y| id_of(y) == n.to_js_string()) } else { None };
	}
	chain
}

/// The default route of loadPolestarRoutes (no other pack): the race's first leveling guide (lowest
/// minLevel, a missing one counting 99, then id), then `next` until it ends or would revisit a guide.
/// None when no leveling guide names the race.
pub fn default_route(guides: &[V], ctx: &Ctx) -> Option<Vec<String>> {
	let lv = leveling(guides, &ctx.faction);
	let start = lv
		.iter()
		.copied()
		.filter(|g| g.get("races").is_arr() && strs(&g.get("races")).contains(&ctx.race))
		.min_by(|a, b| level_or(a, "minLevel", 99.0).total_cmp(&level_or(b, "minLevel", 99.0)).then_with(|| cmp_utf16(&id_of(a), &id_of(b))))?;
	let by_id = |id: &str| lv.iter().copied().find(|g| id_of(g) == id);
	let mut ids = vec![id_of(start)];
	let mut g = start;
	loop {
		let n = g.get("next");
		if !n.truthy() {
			break;
		}
		let n = n.to_js_string();
		let Some(x) = by_id(&n) else { break };
		if ids.contains(&n) {
			break;
		}
		ids.push(n);
		g = x;
	}
	Some(ids)
}

/// Which chain to walk.
pub enum Chain {
	/// These guide ids.
	Ids(Vec<String>),
	/// The pack's default Polestar route, else `next` from the lowest guide (a pack folder).
	Routes,
	/// `next` from the lowest guide (a single .guide file).
	Next,
}

/// walkChain's result (without the data, world and run the JS returns alongside).
#[derive(Clone, Debug)]
pub struct Walk {
	pub chain: Vec<String>,
	pub goals: Vec<WalkGoal>,
	/// Goals of quests already taken or turned in, skipped.
	pub skipped: usize,
	pub end_level: f64,
	pub hours: f64,
}

fn opt_u32(v: &V) -> Option<u32> {
	v.as_num().filter(|n| n.is_finite()).map(|n| n as u32)
}

fn opt_num(v: &V) -> Option<f64> {
	if v.is_nullish() {
		None
	} else {
		Some(v.num())
	}
}

fn opt_int(v: &V) -> Option<i64> {
	if v.is_nullish() {
		None
	} else {
		Some(v.num() as i64)
	}
}

/// walk.js wpt: a goal's map percent to a world point.
pub fn wpt(proj: &Projector, map: &V, x: &V, y: &V, f: &V) -> Option<WPt> {
	if map.is_nullish() {
		return None;
	}
	let (x, y) = (x.as_num()?, y.as_num()?);
	if !x.is_finite() || !y.is_finite() {
		return None;
	}
	let m = map.num();
	// No frame: the live map (compiled goals carry `f` only when it is not; walk.js read Era).
	let frame = if f.truthy() { Frame::parse(&f.to_js_string()) } else { Some(Frame::Live) };
	let p = proj.point(m as u32, x, y, frame);
	p.wx.is_finite().then_some(WPt { c: p.c, wx: p.wx, wy: p.wy, map: m as u32 })
}

/// The chain's guide ids (walk.js: the given ids, else the default route for a pack, else nextChain).
pub fn resolve_chain(guides: &[V], chain: Chain, ctx: &Ctx) -> Result<Vec<String>, String> {
	let chain = match chain {
		Chain::Ids(ids) if !ids.is_empty() => ids,
		Chain::Routes => default_route(guides, ctx).filter(|c| !c.is_empty()).unwrap_or_else(|| next_chain(guides, ctx)),
		_ => next_chain(guides, ctx),
	};
	if chain.is_empty() {
		return Err(format!("judge: no leveling chain for {} {}", ctx.faction, ctx.race));
	}
	Ok(chain)
}

/// walkChain over compiled guides: the chain's goals in order (for this character's `only`
/// clauses; a quest's goals after its turn-in, and its accepts after the first, skipped), levels from
/// `levels`, cut at the first goal begun at level `to` or above. `file_of` names a guide's source file.
pub fn walk_chain(guides: &[V], file_of: &dyn Fn(&V) -> String, chain: Chain, ctx: &Ctx, proj: &Projector, levels: &dyn LevelModel, to: f64) -> Result<Walk, String> {
	let chain = resolve_chain(guides, chain, ctx)?;
	let (mut goals, skipped) = chain_goals(guides, file_of, &chain, ctx, proj, true)?;
	if ctx.along_on_the_way {
		goals = along_on_the_way(goals);
	}
	let cut = levels.replay(&mut goals, to);
	goals.truncate(cut);
	let mut last: Option<WPt> = None;
	for g in &mut goals {
		if g.w.is_some() {
			last = g.w;
		}
		g.pos = g.w.or(last);
	}
	let (end_level, hours) = goals.last().map_or((1.0, 0.0), |g| (g.lvl_after, g.time_after / 3600.0));
	Ok(Walk { chain, goals, skipped, end_level, hours })
}

/// `along` steps as the addon plays them (GUIDE_FORMAT.md "Along the way"): the route never stops at an
/// along step, its goals are done on the walk under the steps after it. An along goal is not walked to
/// where the along step stands: it is credited where the route does that work — dropped when a later
/// goal of the walk works the same objective (or accepts / turns in the same quest) before the list ends,
/// else played at the start of the `until` label's step (a bare `along`: at the guide's end).
pub fn along_on_the_way(goals: Vec<WalkGoal>) -> Vec<WalkGoal> {
	let key = |g: &WalkGoal| -> Option<String> {
		let q = g.q?;
		Some(match g.t.as_str() {
			"accept" | "turnin" => format!("{} {q}", g.t),
			_ => format!("work {q} {}", g.oi.map_or(String::new(), |o| o.to_string())),
		})
	};
	// Objectives the labelled steps work themselves (an along copy of one goes when the step comes).
	let by_label: rustc_hash::FxHashSet<(String, String)> = goals.iter().filter(|g| g.along.is_none()).filter_map(|g| Some((g.label.clone()?, key(g)?))).collect();
	let mut out: Vec<WalkGoal> = Vec::with_capacity(goals.len());
	// Along goals waiting: (until label, goal).
	let mut pending: Vec<(String, WalkGoal)> = Vec::new();
	let n = goals.len();
	for (k, g) in goals.into_iter().enumerate() {
		let guide_end = |out: &mut Vec<WalkGoal>, pending: &mut Vec<(String, WalkGoal)>, guide: &str| {
			let (flush, keep): (Vec<_>, Vec<_>) = std::mem::take(pending).into_iter().partition(|(_, p)| p.guide == guide);
			out.extend(flush.into_iter().map(|(_, p)| p));
			*pending = keep;
		};
		if let Some(prev) = out.last().map(|p| p.guide.clone()) {
			if prev != g.guide {
				guide_end(&mut out, &mut pending, &prev);
			}
		}
		if let Some(until) = &g.along {
			// No objective (a goto, a note): nothing to credit, no walk.
			if g.q.is_some() || g.t == "level" {
				pending.push((until.clone(), g));
			}
			continue;
		}
		// A later goal working the same objective does it: the along copy goes.
		if let Some(kg) = key(&g) {
			pending.retain(|(_, p)| key(p).as_deref() != Some(kg.as_str()));
		}
		// The until step reached: what is left of its list is done on arrival.
		if let Some(l) = &g.label {
			let (flush, keep): (Vec<_>, Vec<_>) = std::mem::take(&mut pending).into_iter().partition(|(u, _)| u == l);
			out.extend(flush.into_iter().filter(|(_, p)| key(p).is_none_or(|k| !by_label.contains(&(l.clone(), k)))).map(|(_, p)| p));
			pending = keep;
		}
		out.push(g);
		if k + 1 == n {
			out.extend(std::mem::take(&mut pending).into_iter().map(|(_, p)| p));
		}
	}
	out.extend(pending.into_iter().map(|(_, p)| p));
	for (i, g) in out.iter_mut().enumerate() {
		g.i = i;
	}
	out
}

/// The goals of a chain's guides that hold for the character, in order, levels unset and `pos` None.
/// `skip_done`: walk.js's skip of a quest's goals after its turn-in and of its repeated accepts
/// (guidetext.js lists every goal). -> (goals, skipped count).
pub fn chain_goals(guides: &[V], file_of: &dyn Fn(&V) -> String, chain: &[String], ctx: &Ctx, proj: &Projector, skip_done: bool) -> Result<(Vec<WalkGoal>, usize), String> {
	let mut goals: Vec<WalkGoal> = Vec::new();
	let mut taken = rustc_hash::FxHashSet::default();
	let mut turned_in = rustc_hash::FxHashSet::default();
	let mut skipped = 0;
	for gid in chain {
		let g = guides.iter().find(|g| id_of(g) == *gid).ok_or_else(|| format!("judge: chain names guide {gid}, not compiled"))?;
		let file = file_of(g);
		for step in g.get("steps").items() {
			if !only_holds(&step.get("only"), ctx) {
				continue;
			}
			let step_line = opt_u32(&step.hidden("_line"));
			let along = match step.get("along") {
				V::Bool(true) => Some(String::new()),
				V::Str(l) => Some(l.to_string()),
				_ => None,
			};
			let label = step.get("label").as_str().map(str::to_string);
			for goal in step.get("goals").items() {
				if !only_holds(&goal.get("only"), ctx) {
					continue;
				}
				let t = goal.get("t").to_js_string();
				let q = opt_int(&goal.get("quest"));
				if let Some(q) = q.filter(|_| skip_done) {
					if turned_in.contains(&q) || (t == "accept" && taken.contains(&q)) {
						skipped += 1;
						continue;
					}
					if t == "accept" {
						taken.insert(q);
					}
					if t == "turnin" {
						turned_in.insert(q);
					}
				}
				let gl = goal.hidden("_line");
				let title = ["title", "npcName", "itemName", "text"].iter().map(|k| goal.get(k)).find(V::truthy).map(|v| v.to_js_string());
				goals.push(WalkGoal {
					i: goals.len(),
					guide: gid.clone(),
					file: file.clone(),
					line: if gl.truthy() { opt_u32(&gl) } else { step_line },
					step: step_line,
					t,
					q,
					oi: opt_int(&goal.get("oi")),
					optional: goal.get("optional").truthy(),
					passing: goal.get("passing").truthy(),
					map: opt_num(&goal.get("map")).map(|m| m as u32),
					w: wpt(proj, &goal.get("map"), &goal.get("x"), &goal.get("y"), &goal.get("f")),
					npc: opt_u32(&goal.get("npc")),
					level: opt_num(&goal.get("level")),
					title,
					lvl: 0.0,
					time: 0.0,
					lvl_after: 0.0,
					time_after: 0.0,
					pos: None,
					along: along.clone(),
					label: label.clone(),
				});
			}
		}
	}
	Ok((goals, skipped))
}

/// The walk's goals as the availability rule reads them.
pub fn rule_goals(goals: &[WalkGoal]) -> Vec<forge_world::rules::Goal> {
	goals.iter().map(|g| forge_world::rules::Goal { i: g.i, t: g.t.clone(), q: g.q, oi: g.oi, lvl: g.lvl, lvl_after: Some(g.lvl_after) }).collect()
}

/// index.js soloFilter: the simulator's solo set (simRules over the character's run, any class) and,
/// with a class, open to it (the quest's class mask has its bit).
pub fn solo_filter<'a>(rules: &'a forge_world::Rules, quests: &'a std::collections::BTreeMap<u32, forge_world::data::Quest>, cls: Option<&str>) -> impl Fn(u32) -> bool + 'a {
	let bit = cls.and_then(|c| CLASSES.iter().find(|x| x.file.eq_ignore_ascii_case(c) || x.key.eq_ignore_ascii_case(c))).map(|c| u64::from(c.bit));
	move |q| {
		if !rules.solo_ok(q) {
			return false;
		}
		match (bit, quests.get(&q).and_then(|r| r.classes).filter(|m| *m != 0.0 && !m.is_nan())) {
			(Some(b), Some(m)) => forge_core::has_bit(m as u64, b),
			_ => true,
		}
	}
}

/// index.js background: zone and continent changes between positioned quest goals, quests turned in.
#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Background {
	pub zone_changes: usize,
	pub continent_changes: usize,
	pub quests_done: usize,
}

pub fn background(goals: &[WalkGoal]) -> Background {
	let (mut zone_changes, mut continent_changes) = (0, 0);
	let (mut last_map, mut last_c): (Option<u32>, Option<i64>) = (None, None);
	let mut done = rustc_hash::FxHashSet::default();
	for g in goals {
		if g.t == "turnin" {
			if let Some(q) = g.q {
				done.insert(q);
			}
		}
		let (Some(w), Some(_)) = (g.w, g.q) else { continue };
		if last_map.is_some_and(|m| m != w.map) {
			zone_changes += 1;
		}
		if last_c.is_some_and(|c| c != w.c) {
			continent_changes += 1;
		}
		last_map = Some(w.map);
		last_c = Some(w.c);
	}
	Background { zone_changes, continent_changes, quests_done: done.len() }
}

#[cfg(feature = "native")]
pub use native::{judge_walk, JudgeOpts, Judged};

#[cfg(feature = "native")]
mod native {
	use super::*;
	use crate::passedby::{passed_by, PassedBy};
	use crate::returns::{avoidable_returns, Returns, EXAMPLES};
	use forge_core::{race_label, Faction, MapFrames};
	use forge_world::atlas::GridSubzones;
	use forge_world::data::{DirSource, GameData};
	use forge_world::{build_world, Atlas, BuildOptions, NoFloors, Rules};
	use std::path::{Path, PathBuf};

	/// judgeWalk's options. `root`: the repository checkout the simulator's world is built from
	/// (data/forever, data/sources, data/rules.json); `data_dir`: the data the guides compile
	/// against and the judge reads quests, NPCs and objects from (default root/data/forever); `grid`:
	/// the walking grid whose tile heads name subzones (default $POLESTAR_GRID, else
	/// root/data/local/nav4). The world is built without heights: the judge reads only its quest set,
	/// prerequisites and solo set, which heights do not change.
	pub struct JudgeOpts {
		pub guides: PathBuf,
		pub faction: String,
		pub race: String,
		pub cls: Option<String>,
		pub to: f64,
		pub root: PathBuf,
		pub data_dir: PathBuf,
		pub grid: PathBuf,
		pub chain: Option<Vec<String>>,
		pub radius: f64,
		pub examples: usize,
		/// `along` steps as the addon plays them (Ctx::along_on_the_way).
		pub along_on_the_way: bool,
	}

	impl JudgeOpts {
		pub fn new(guides: &Path, faction: &str, race: &str, cls: Option<&str>, root: &Path) -> JudgeOpts {
			JudgeOpts {
				guides: guides.to_path_buf(),
				faction: faction.into(),
				race: race.into(),
				cls: cls.map(str::to_string),
				to: 61.0,
				root: root.to_path_buf(),
				data_dir: root.join("data/forever"),
				grid: std::env::var_os("POLESTAR_GRID").map_or_else(|| root.join("data/local/nav4"), PathBuf::from),
				chain: None,
				radius: 500.0,
				examples: EXAMPLES,
				along_on_the_way: true,
			}
		}
	}

	pub struct Judged {
		pub walk: Walk,
		pub background: Background,
		pub passed_by: PassedBy,
		pub returns: Returns,
	}

	/// judgeWalk: the walk (levels from `levels`), passed by and avoidable returns. Goal files are
	/// absolute.
	pub fn judge_walk(o: &JudgeOpts, levels: &dyn LevelModel) -> Result<Judged, String> {
		let faction = Faction::parse(&o.faction).ok_or_else(|| format!("judge: unknown faction {}", o.faction))?;
		let mut ctx = Ctx::new(faction.name(), &o.race, o.cls.as_deref())?;
		ctx.along_on_the_way = o.along_on_the_way;
		let single = o.guides.is_file();
		let data = forge_guide::data::load_data(&o.data_dir)?;
		let guides = if single {
			// walk.js compiles a single file as a pack of its own, named by its `guide <pack>/<id>` line.
			let text = std::fs::read_to_string(&o.guides).map_err(|e| format!("{}: {e}", o.guides.display()))?;
			let pack = text.lines().find_map(|l| l.strip_prefix("guide").filter(|r| r.starts_with([' ', '\t'])).and_then(|r| r.trim_start().split_once('/')).map(|(p, _)| p.to_string()));
			let src = forge_guide::project::Source { source: o.guides.file_name().unwrap_or_default().to_string_lossy().into_owned(), file: o.guides.to_string_lossy().into_owned(), text };
			let opts = forge_guide::project::CompileOpts { pack: pack.clone(), author: pack, context: None, pack_dir: None };
			forge_guide::project::compile_sources(&[src], &data, &mut forge_guide::diag::Diagnostics::new(), &opts).guides
		} else {
			forge_guide::project::compile_project(&o.guides, &V::Undef, &data, forge_guide::diag::Diagnostics::new(), false, None).guides
		};
		let frames = MapFrames::from_json(&std::fs::read(o.data_dir.join("map-frames.json")).map_err(|e| format!("map-frames.json: {e}"))?).map_err(|e| e.to_string())?;
		let proj = Projector::new(&frames);
		let chain = match &o.chain {
			Some(ids) => Chain::Ids(ids.clone()),
			None if single => Chain::Next,
			None => Chain::Routes,
		};
		let file_of = |g: &V| abs_file(g).to_string_lossy().into_owned();
		let walk = walk_chain(&guides, &file_of, chain, &ctx, &proj, levels, o.to)?;

		// Heights only place points; the rules read the quest set, so no floors source is needed.
		let world = build_world(&GameData::from_source(&DirSource::repo(&o.root)).map_err(|e| e.to_string())?, &BuildOptions::new(faction), &NoFloors).map_err(|e| e.to_string())?.0;
		let src = DirSource { data: o.data_dir.clone(), sources: Some(o.root.join("data/sources")), rules: Some(o.root.join("data/rules.json")) };
		let d = GameData::from_source(&src).map_err(|e| e.to_string())?;
		let rules = Rules::new(&world, race_label(&ctx.race), None, false);
		let solo = solo_filter(&rules, &d.quests, ctx.cls.as_deref());
		let pre_of = |rec: &forge_world::data::Quest| rules.prereqs_of(rec);
		let sub = GridSubzones::open(&o.grid, &o.root.join("data/sources"));
		let popts = crate::passedby::Opts { radius: o.radius, ..Default::default() };
		let pb = passed_by(&walk.goals, &d, &proj, &solo, Some(&pre_of), Some(&sub), popts);
		let mut maps: Vec<u32> = Vec::new();
		for w in walk.goals.iter().filter_map(|g| g.w) {
			if !maps.contains(&w.map) {
				maps.push(w.map);
			}
		}
		let atlas = Atlas::build_for(faction, &d, Some(&sub), Some(&maps));
		let returns = avoidable_returns(&walk.goals, &atlas, &d, &solo, Some(&pre_of), o.examples);
		Ok(Judged { background: background(&walk.goals), walk, passed_by: pb, returns })
	}

	/// A compiled guide's source file, absolute (`_ast.file` is shown relative to the working directory).
	fn abs_file(g: &V) -> PathBuf {
		let f = PathBuf::from(g.hidden("_ast").get("file").to_js_string());
		if f.is_absolute() {
			f
		} else {
			std::env::current_dir().unwrap_or_default().join(f)
		}
	}
}
