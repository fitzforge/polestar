//! The checks the seeded-defect test runs on a guide set (baseline or mutant), as hits at guide lines.
//!
//! Every check is run in memory on the compiled sources: honest (default: R1-R10, deduplicated), honest
//! legacy (R1-R5 as the JS), the judge walk's passed-by and avoidable returns, the guide-text metrics, the
//! engine replay (stuck and missing-location events) and the compiler's own diagnostics (lint). Levels for
//! the walk and the guide-text replay come from the JS dumps in $POLESTAR_JSREF, aligned to the goal list by
//! goal key (see [`Aligned`]).

use forge_core::{Faction, Projector};
use forge_guide::data::Data;
use forge_guide::diag::Diagnostics;
use forge_guide::js::V;
use forge_guide::project::{compile_sources, CompileOpts, Source};
use forge_judge::engine::{self, Character, Event, OnStuck, Replay};
use forge_judge::guidetext::{self, Consensus, Inputs, SimView};
use forge_judge::honest::{self, HonestOpts, Persona};
use forge_judge::walk::{self, Chain, Ctx, LevelModel, WalkGoal};
use forge_judge::{passedby, returns};
use forge_world::atlas::GridSubzones;
use forge_world::data::{DirSource, GameData, Quest};
use forge_world::{build_world, Atlas, BuildOptions, NoFloors, Rules};
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::Value;
use std::path::{Path, PathBuf};
use std::time::Instant;

fn env_dir(var: &str) -> PathBuf {
	std::env::var_os(var).map(PathBuf::from).unwrap_or_default()
}
/// A full Polestar checkout with built data/forever and data/sim/export ($POLESTAR_CHECKOUT).
pub fn main_dir() -> PathBuf {
	env_dir("POLESTAR_CHECKOUT")
}
/// The JS dumps: walk levels, gt/ guide-text replays, repaired/ v2 slice ($POLESTAR_JSREF).
pub fn rsj() -> PathBuf {
	env_dir("POLESTAR_JSREF")
}
pub fn v2_dir() -> PathBuf {
	rsj().join("repaired")
}

pub const CHECKS: [&str; 7] = ["honest", "legacy", "passedby", "returns", "guidetext", "engine", "lint"];
pub const HONEST: usize = 0;
pub const LEGACY: usize = 1;
pub const PASSEDBY: usize = 2;
pub const RETURNS: usize = 3;
pub const GUIDETEXT: usize = 4;
pub const ENGINE: usize = 5;
pub const LINT: usize = 6;

/// Gate metrics of the guide-text scorer where a higher value is worse (gate.js rows and their context).
pub const GATE: [&str; 11] = [
	"/pingpong/rawTransitions",
	"/pingpong/substantialVisits",
	"/pingpong/shortABA",
	"/pingpong/returnsWithin3Levels",
	"/pingpong/continentChanges",
	"/log/max",
	"/log/goalsOver20",
	"/log/danglingAtEnd",
	"/missed/le150/eligible",
	"/missed/le300/eligible",
	"/overlap/mergeableNow",
];

/// One thing a check points at: a guide line (file relative to the guides dir), what it says (`key`, compared
/// with the baseline; `.guide:N` references inside it are blanked), text naming quests, quest ids it names.
#[derive(Clone, Debug)]
pub struct Hit {
	pub check: usize,
	pub file: String,
	pub line: u32,
	pub key: String,
	pub text: String,
	pub quests: Vec<u32>,
}

/// Reference data shared by every run (one per thread: the compiler's values are not Send).
pub struct Shared {
	pub data: Data,
	pub d: GameData,
	pub proj: Projector,
	pub kb: Option<honest::Kb>,
	pub eworld: engine::WorldData,
	pub sub: GridSubzones,
	pub root: PathBuf,
}

impl Shared {
	pub fn load() -> Shared {
		let main = main_dir();
		let root = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap();
		let data = forge_guide::data::load_data(&main.join("data/forever")).expect("data");
		let src = DirSource { data: main.join("data/forever"), sources: Some(main.join("data/sources")), rules: Some(root.join("data/rules.json")) };
		let d = GameData::from_source(&src).expect("game data");
		let proj = Projector::new(&d.frames);
		let kb = honest::load_kb(&main.join("data/local/kb/forever-kb.sqlite")).expect("kb");
		let eworld = engine::WorldData::from_data(&data);
		let sub = GridSubzones::open(&main.join("data/local/nav4"), &main.join("data/sources"));
		Shared { data, d, proj, kb, eworld, sub, root }
	}
}

/// A guide set and how it is played and judged.
#[derive(Clone, Debug)]
pub struct ChainDef {
	pub name: String,
	pub faction: Faction,
	/// Race file (`Orc`, `Human`).
	pub race: String,
	/// The guides dir the `files` are relative to.
	pub dir: PathBuf,
	pub files: Vec<String>,
	/// Engine replay start (guide id).
	pub start: String,
	pub walk_ids: Vec<String>,
	pub gt_ids: Vec<String>,
	/// JS judge walk (`{ goals: [{ guide, t, q, lvl, time, lvlAfter, timeAfter }] }`).
	pub walk_dump: PathBuf,
	/// guidetext-dump.js output (`{ goals, sim }`).
	pub gt_dump: PathBuf,
}

/// Levels recorded on one goal list, by goal key.
pub struct BaseLevels {
	pub keys: Vec<u64>,
	pub lv: Vec<[f64; 4]>,
	/// Baseline goals whose (guide, verb, quest) differ from the dump's at the same index (0: the dump fits).
	pub mismatched: usize,
}

pub fn goal_key(g: &WalkGoal) -> u64 {
	use std::hash::{Hash, Hasher};
	let mut h = rustc_hash::FxHasher::default();
	(&g.guide, &g.t, g.q, g.oi, g.npc, &g.title, g.map).hash(&mut h);
	h.finish()
}

/// For each of `new`, its fractional index in `base`: equal keys aligned by a longest common subsequence
/// (common prefix and suffix first), goals between two aligned ones spread evenly between their indices.
pub fn align(base: &[u64], new: &[u64]) -> Vec<f64> {
	let (n, m) = (base.len(), new.len());
	let mut p = 0;
	while p < n && p < m && base[p] == new[p] {
		p += 1;
	}
	let mut s = 0;
	while s < n - p && s < m - p && base[n - 1 - s] == new[m - 1 - s] {
		s += 1;
	}
	let (b, w) = (&base[p..n - s], &new[p..m - s]);
	// LCS on the middle.
	let (bn, wn) = (b.len(), w.len());
	let mut matched: Vec<Option<usize>> = vec![None; wn];
	if bn > 0 && wn > 0 {
		let mut dp = vec![0u32; (bn + 1) * (wn + 1)];
		for i in (0..bn).rev() {
			for j in (0..wn).rev() {
				dp[i * (wn + 1) + j] = if b[i] == w[j] { dp[(i + 1) * (wn + 1) + j + 1] + 1 } else { dp[(i + 1) * (wn + 1) + j].max(dp[i * (wn + 1) + j + 1]) };
			}
		}
		let (mut i, mut j) = (0, 0);
		while i < bn && j < wn {
			if b[i] == w[j] {
				matched[j] = Some(i);
				i += 1;
				j += 1;
			} else if dp[(i + 1) * (wn + 1) + j] >= dp[i * (wn + 1) + j + 1] {
				i += 1;
			} else {
				j += 1;
			}
		}
	}
	let mut out = vec![0.0; m];
	for k in 0..p {
		out[k] = k as f64;
	}
	for k in 0..s {
		out[m - 1 - k] = (n - 1 - k) as f64;
	}
	// Anchors: the prefix end, matched middle goals, the suffix start.
	let mut j = 0;
	while j < wn {
		if let Some(i) = matched[j] {
			out[p + j] = (p + i) as f64;
			j += 1;
			continue;
		}
		let run0 = j;
		while j < wn && matched[j].is_none() {
			j += 1;
		}
		let lo = if run0 == 0 { p as f64 - 1.0 } else { (p + matched[run0 - 1].unwrap()) as f64 };
		let hi = if j == wn { (n - s) as f64 } else { (p + matched[j].unwrap()) as f64 };
		let cnt = (j - run0) as f64;
		for r in run0..j {
			out[p + r] = (lo + (r - run0 + 1) as f64 * (hi - lo) / (cnt + 1.0)).max(0.0);
		}
	}
	out
}

/// The walk's [`LevelModel`] for any goal list: each goal gets the dump's levels at its aligned (fractional)
/// index in the baseline, interpolated by goal index; the walk is cut where the dump ends. On the unmutated
/// list this is the dump itself (DumpLevels).
pub struct Aligned<'a>(pub &'a BaseLevels);

impl LevelModel for Aligned<'_> {
	fn replay(&self, goals: &mut [WalkGoal], _to: f64) -> usize {
		let keys: Vec<u64> = goals.iter().map(goal_key).collect();
		let at = align(&self.0.keys, &keys);
		let lv = &self.0.lv;
		let last = lv.len() as f64 - 1.0;
		for (k, g) in goals.iter_mut().enumerate() {
			let b = at[k];
			if lv.is_empty() || b > last + 1e-9 {
				return k;
			}
			let (i0, fr) = (b.floor() as usize, b - b.floor());
			let i1 = (i0 + 1).min(lv.len() - 1);
			let v = |f: usize| lv[i0][f] + (lv[i1][f] - lv[i0][f]) * fr;
			g.lvl = v(0);
			g.time = v(1);
			g.lvl_after = v(2);
			g.time_after = v(3);
		}
		goals.len()
	}
}

/// Per guide set, made once from its baseline texts.
pub struct Prepared {
	pub def: ChainDef,
	pub texts: Vec<String>,
	pub rules: Rules,
	pub atlas: Atlas,
	pub walk_base: BaseLevels,
	pub gt_base: BaseLevels,
	pub sim: SimView,
	pub consensus: Option<Consensus>,
	/// Every guide text of the dir (mentions: documented cuts), the chain files' indices into it.
	pub mention_files: Vec<(String, String)>,
	pub mention_idx: Vec<Option<usize>>,
}

/// What one run gives.
pub struct Out {
	pub hits: Vec<Hit>,
	pub gt: Value,
	pub walk_goals: Vec<WalkGoal>,
	pub gt_goals: Vec<WalkGoal>,
	/// compile, honest, legacy, engine, walk, guidetext (ms).
	pub ms: [f64; 6],
}

fn read_json(p: &Path) -> Value {
	serde_json::from_slice(&std::fs::read(p).unwrap_or_else(|e| panic!("{}: {e}", p.display()))).unwrap()
}

fn dump_levels(goals: &Value) -> Vec<[f64; 4]> {
	let f = |g: &Value, k: &str| g[k].as_f64().unwrap_or(f64::NAN);
	goals.as_array().unwrap().iter().map(|g| [f(g, "lvl"), f(g, "time"), f(g, "lvlAfter"), f(g, "timeAfter")]).collect()
}

fn mismatches(goals: &[WalkGoal], dump: &Value) -> usize {
	let dg = dump.as_array().unwrap();
	goals.iter().zip(dg).filter(|(g, d)| d["guide"].as_str() != Some(g.guide.as_str()) || d["t"].as_str() != Some(g.t.as_str()) || d["q"].as_i64() != g.q).count()
}

pub fn compile(sh: &Shared, files: &[String], texts: &[String]) -> (Vec<V>, Diagnostics) {
	let sources: Vec<Source> = files.iter().zip(texts).map(|(rel, t)| Source { source: rel.clone(), file: rel.clone(), text: t.clone() }).collect();
	let mut diag = Diagnostics::new();
	let c = compile_sources(&sources, &sh.data, &mut diag, &CompileOpts { pack: None, author: None, context: None, pack_dir: None });
	(c.guides, diag)
}

fn file_of(g: &V) -> String {
	g.hidden("_ast").get("file").to_js_string()
}

fn opt_u32(v: &V) -> Option<u32> {
	v.as_num().filter(|n| n.is_finite()).map(|n| n as u32)
}

pub fn prepare(sh: &Shared, def: ChainDef) -> Prepared {
	let texts: Vec<String> = def.files.iter().map(|f| std::fs::read_to_string(def.dir.join(f)).unwrap_or_else(|e| panic!("{f}: {e}"))).collect();
	let (guides, _) = compile(sh, &def.files, &texts);
	let world = build_world(&GameData::from_source(&DirSource::repo(&sh.root)).expect("world data"), &BuildOptions::new(def.faction), &NoFloors).expect("world").0;
	let rules = Rules::new(&world, forge_core::race_label(&def.race), None, false);
	let mut wctx = Ctx::new(def.faction.name(), &def.race, Some("Warrior")).unwrap();
	wctx.along_on_the_way = false;
	let (wg, _) = walk::chain_goals(&guides, &file_of, &def.walk_ids, &wctx, &sh.proj, true).unwrap();
	let wd = read_json(&def.walk_dump);
	let walk_base = BaseLevels { keys: wg.iter().map(goal_key).collect(), lv: dump_levels(&wd["goals"]), mismatched: mismatches(&wg, &wd["goals"]) };
	let gctx = Ctx::new(def.faction.name(), &def.race, None).unwrap();
	let (gg, _) = walk::chain_goals(&guides, &file_of, &def.gt_ids, &gctx, &sh.proj, false).unwrap();
	let gd = read_json(&def.gt_dump);
	let gt_base = BaseLevels { keys: gg.iter().map(goal_key).collect(), lv: dump_levels(&gd["goals"]), mismatched: mismatches(&gg, &gd["goals"]) };
	let sim: SimView = serde_json::from_value(gd["sim"].clone()).unwrap();
	let consensus = guidetext::load_consensus(&main_dir().join("data/sim/export"), def.faction, &guidetext::race_key(&def.race));
	// The atlas over every map the baseline walk and its guide-text goals touch.
	let mut maps: Vec<u32> = Vec::new();
	for w in wg.iter().chain(&gg).filter_map(|g| g.w) {
		if !maps.contains(&w.map) {
			maps.push(w.map);
		}
	}
	let atlas = Atlas::build_for(def.faction, &sh.d, Some(&sh.sub), Some(&maps));
	let mention_files = guidetext::guide_texts(&def.dir).unwrap_or_default();
	let top = def.dir.file_name().unwrap().to_string_lossy().into_owned();
	let mention_idx = def.files.iter().map(|f| mention_files.iter().position(|(r, _)| *r == format!("{top}/{f}"))).collect();
	Prepared { def, texts, rules, atlas, walk_base, gt_base, sim, consensus, mention_files, mention_idx }
}

/// `.guide:<n>` references blanked, so a finding keeps its key when lines above it move.
pub fn norm_key(s: &str) -> String {
	let mut out = String::with_capacity(s.len());
	let mut rest = s;
	while let Some(i) = rest.find(".guide:") {
		out.push_str(&rest[..i + 7]);
		rest = rest[i + 7..].trim_start_matches(|c: char| c.is_ascii_digit());
		out.push('#');
	}
	out.push_str(rest);
	out
}

/// `<file>.guide:<line>` -> (file, line).
pub fn parse_ref(r: &str) -> Option<(String, u32)> {
	let (f, l) = r.rsplit_once(':')?;
	Some((f.to_string(), l.parse().ok()?))
}

/// Every `….guide:<n>` reference in a JSON value, with the JSON path it sits at (indices dropped).
pub fn refs_in(v: &Value, path: &str, out: &mut Vec<(String, String, u32)>) {
	match v {
		Value::String(s) => {
			let mut rest = s.as_str();
			while let Some(i) = rest.find(".guide:") {
				let start = rest[..i].rfind(|c: char| c.is_whitespace() || c == '(' || c == '"').map_or(0, |k| k + 1);
				let digits: String = rest[i + 7..].chars().take_while(char::is_ascii_digit).collect();
				if let Ok(n) = digits.parse() {
					out.push((path.to_string(), rest[start..i + 6].to_string(), n));
				}
				rest = &rest[i + 7..];
			}
		}
		Value::Array(a) => a.iter().for_each(|x| refs_in(x, path, out)),
		Value::Object(o) => o.iter().for_each(|(k, x)| refs_in(x, &format!("{path}/{k}"), out)),
		_ => {}
	}
}

/// Strip a leading `guides/` or the guides dir's own name, so references read as the compiled sources do.
fn rel(prep: &Prepared, f: &str) -> String {
	let top = format!("{}/", prep.def.dir.file_name().unwrap().to_string_lossy());
	f.strip_prefix(&top).unwrap_or(f).to_string()
}

/// Run every check on `texts` (one per `prep.def.files`).
pub fn run(sh: &Shared, prep: &Prepared, texts: &[String]) -> Out {
	let def = &prep.def;
	let mut ms = [0.0; 6];
	let mut hits: Vec<Hit> = Vec::new();
	let t = Instant::now();
	let (guides, diag) = compile(sh, &def.files, texts);
	ms[0] = t.elapsed().as_secs_f64() * 1e3;
	for dg in &diag.list {
		if let Some(f) = &dg.file {
			hits.push(Hit { check: LINT, file: f.clone(), line: dg.line as u32, key: format!("{} {}", dg.severity, norm_key(&dg.message)), text: dg.message.clone(), quests: vec![] });
		}
	}
	let by_id: FxHashMap<String, &V> = guides.iter().map(|g| (g.get("id").to_js_string(), g)).collect();
	let ids: Vec<String> = guides.iter().map(|g| g.get("id").to_js_string()).collect();

	// Honest, default and legacy.
	let persona = Persona { race: def.race.clone(), faction: def.faction.name().to_string(), cls: "WARRIOR".into() };
	let personas = |_: &V| vec![persona.clone()];
	for (check, opts, slot) in [(HONEST, HonestOpts::default(), 1), (LEGACY, HonestOpts::legacy(), 2)] {
		let t = Instant::now();
		for f in honest::honest_play(&guides, &sh.data, &personas, sh.kb.as_ref(), Some(&ids), &opts) {
			hits.push(Hit {
				check,
				file: f.file.clone(),
				line: f.line,
				key: norm_key(&format!("{} {} {}", f.rule, f.severity.as_str(), f.reason)),
				text: format!("{} {} {}", f.title, f.reason, f.repair),
				quests: vec![],
			});
		}
		ms[slot] = t.elapsed().as_secs_f64() * 1e3;
	}

	// Engine replay: stucks and accept/turn-in goals with no location.
	let t = Instant::now();
	let eg: Vec<engine::Guide> = guides.iter().map(engine::Guide::read).collect();
	if let Some(first) = eg.iter().find(|g| g.id == def.start) {
		let ch = Character::new(def.faction.name(), &def.race, "WARRIOR", engine::start_level(first));
		let events = Replay::new(&eg, &sh.eworld, ch).play(&def.start, OnStuck::Skip).unwrap_or_default();
		let goal_at = |gid: &str, s: usize, gi: Option<usize>| -> Option<(String, u32, Option<u32>)> {
			let g = by_id.get(gid)?;
			let step = g.get("steps").items().get(s.checked_sub(1)?)?.clone();
			let mut line = opt_u32(&step.hidden("_line"))?;
			let mut q = None;
			if let Some(gi) = gi {
				if let Some(x) = step.get("goals").items().get(gi.checked_sub(1)?) {
					line = opt_u32(&x.hidden("_line")).unwrap_or(line);
					q = opt_u32(&x.get("quest"));
				}
			}
			Some((file_of(g), line, q))
		};
		for e in &events {
			match e {
				Event::Stuck { guide, step, goal, verb, status, why } => {
					if let Some((file, line, q)) = goal_at(guide, *step, *goal) {
						hits.push(Hit { check: ENGINE, file, line, key: format!("stuck {verb:?} {status:?} {why:?}"), text: String::new(), quests: q.into_iter().collect() });
					}
				}
				Event::Missing { guide, goals } => {
					for (s, gi) in goals {
						if let Some((file, line, q)) = goal_at(guide, *s, Some(*gi)) {
							hits.push(Hit { check: ENGINE, file, line, key: "missing location".into(), text: String::new(), quests: q.into_iter().collect() });
						}
					}
				}
				_ => {}
			}
		}
	}
	ms[3] = t.elapsed().as_secs_f64() * 1e3;

	// The judge walk: passed by and avoidable returns.
	let t = Instant::now();
	let mut wctx = Ctx::new(def.faction.name(), &def.race, Some("Warrior")).unwrap();
	wctx.along_on_the_way = false;
	let walk = walk::walk_chain(&guides, &file_of, Chain::Ids(def.walk_ids.clone()), &wctx, &sh.proj, &Aligned(&prep.walk_base), 61.0);
	let walk_goals = match walk {
		Ok(w) => {
			let solo = walk::solo_filter(&prep.rules, &sh.d.quests, wctx.cls.as_deref());
			let pre_of = |rec: &Quest| prep.rules.prereqs_of(rec);
			let pb = passedby::passed_by(&w.goals, &sh.d, &sh.proj, &solo, Some(&pre_of), Some(&sh.sub), passedby::Opts::default());
			for p in &pb.list {
				if let Some((file, line)) = parse_ref(&p.ref_) {
					hits.push(Hit { check: PASSEDBY, file: rel(prep, &file), line, key: format!("passed {} {}", p.q, p.status), text: p.title.clone().unwrap_or_default(), quests: vec![p.q] });
				}
			}
			let rt = returns::avoidable_returns(&w.goals, &prep.atlas, &sh.d, &solo, Some(&pre_of), usize::MAX);
			let mut push = |r: &str, key: String, title: Option<&String>, q: Option<i64>| {
				if let Some((file, line)) = parse_ref(r) {
					hits.push(Hit { check: RETURNS, file: rel(prep, &file), line, key, text: title.cloned().unwrap_or_default(), quests: q.map(|q| q as u32).into_iter().collect() });
				}
			};
			for ex in &rt.examples {
				for g in ex.v2.goals.iter().filter(|g| g.avoidable) {
					push(&g.ref_, format!("return {} {} {:?} wasted {}", ex.area, g.t, g.q, ex.wasted), g.title.as_ref(), g.q);
				}
			}
			for lb in &rt.left_behind {
				push(&lb.ref_, format!("left behind {}", lb.q), lb.title.as_ref(), Some(lb.q as i64));
			}
			for sm in &rt.same_mob {
				let key = format!("same mob {} {} {}", sm.mob, sm.first, sm.second);
				let text = format!("{} {}", sm.first, sm.second);
				push(&sm.ref_first, key.clone(), Some(&text), None);
				push(&sm.ref_second, key, Some(&text), None);
			}
			w.goals
		}
		Err(e) => {
			eprintln!("walk failed: {e}");
			Vec::new()
		}
	};
	ms[4] = t.elapsed().as_secs_f64() * 1e3;

	// Guide-text metrics.
	let t = Instant::now();
	let gctx = Ctx::new(def.faction.name(), &def.race, None).unwrap();
	let (mut gg, _) = walk::chain_goals(&guides, &file_of, &def.gt_ids, &gctx, &sh.proj, false).unwrap_or_default();
	let cut = Aligned(&prep.gt_base).replay(&mut gg, 61.0);
	gg.truncate(cut);
	let mut last = None;
	for g in &mut gg {
		if g.w.is_some() {
			last = g.w;
		}
		g.pos = g.w.or(last);
	}
	let mut mfiles = prep.mention_files.clone();
	for (i, mi) in prep.mention_idx.iter().enumerate() {
		if let Some(mi) = mi {
			mfiles[*mi].1 = texts[i].clone();
		}
	}
	let mentioned = guidetext::mentions(&mfiles, &sh.d);
	let gt = guidetext::score(&Inputs {
		data: &sh.d,
		proj: &sh.proj,
		src: "polestar",
		faction: def.faction,
		race: &def.race,
		chain: &def.gt_ids,
		goals: &gg,
		sim: &prep.sim,
		consensus: prep.consensus.as_ref(),
		mentioned: &mentioned,
	});
	let mut refs = Vec::new();
	refs_in(&gt, "", &mut refs);
	for (path, file, line) in refs {
		hits.push(Hit { check: GUIDETEXT, file: rel(prep, &file), line, key: path, text: String::new(), quests: vec![] });
	}
	ms[5] = t.elapsed().as_secs_f64() * 1e3;
	Out { hits, gt, walk_goals, gt_goals: gg, ms }
}

/// The gate metrics that got worse from `base` to `now`: (path, base, now).
pub fn gate_worse(base: &Value, now: &Value) -> Vec<(String, f64, f64)> {
	GATE.iter()
		.filter_map(|p| {
			let (a, b) = (base.pointer(p)?.as_f64()?, now.pointer(p)?.as_f64()?);
			(b > a + 1e-9).then(|| (p.to_string(), a, b))
		})
		.collect()
}

/// The baseline's hits as a set for diffing: (check, file, line, key).
pub fn hit_set(hits: &[Hit]) -> FxHashSet<(usize, String, u32, String)> {
	hits.iter().map(|h| (h.check, h.file.clone(), h.line, h.key.clone())).collect()
}
