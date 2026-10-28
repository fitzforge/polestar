//! `forge judge report`: one report for a route written into v1's guides, the route loop's JS scripts in
//! one command (the route loop's gmeasure.js, sdiff.js, judge-order2.js, honest-sum.js, honest-diff.js, tcheck.js).
//!
//! - [`measures`]: a judged walk's row (gmeasure.js): hours and level, passed by, avoidable returns, area
//!   visits, deaths, trains, training trips, grind minutes, and the quest log's peak.
//! - [`stream_diff`]: the order's goal stream (forge-sim's judge stream) against the written walk in the
//!   same evaluator (sdiff.js): hours to 30 and 60, quest events in both / out of order / only in one, and
//!   where the written walk loses time.
//! - [`honest_sum`], [`honest_new`]: honest findings (legacy R1-R5, the JS's) of the race on the chain, by
//!   rule, and the distinct ones v1 does not have (honest-diff.js; tcheck.js for the Warrior's R1).

use std::collections::BTreeMap;

use rustc_hash::{FxHashMap, FxHashSet};
use serde::Serialize;

use crate::honest::{Finding, Severity};
use crate::levels::SimLevels;
use crate::walk::{WPt, WalkGoal};

/// One chain's row (gmeasure.js's, with the quest log's peak).
#[derive(Clone, Debug, Default, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Measures {
	pub to: f64,
	pub hours: f64,
	pub end_level: f64,
	pub quests_done: usize,
	pub zone_changes: usize,
	pub passed_by: usize,
	pub pb_never: usize,
	pub pb_later: usize,
	pub q_per_visit: f64,
	pub area_visits: usize,
	pub returns: usize,
	pub wasted_trips: usize,
	pub left_behind: usize,
	pub same_mob: usize,
	pub deaths: usize,
	pub trains: usize,
	pub train_trips: usize,
	/// Minutes on `level` goals (gmeasure.js: their time, travel to the camp included).
	pub grind_min: f64,
	/// The level model's grinding to `to`, every goal's (its evaluator's `grind_sec`): what the walk
	/// grinds, written or not. With a model that gives no grind (a recorded JS walk), `grind_min`.
	pub grind_all_min: f64,
	/// The part of `grind_all_min` on `level` goals: the grind a step tells the player to do.
	pub grind_shown_min: f64,
	/// The most quests held at once along the walk (accepts less turn-ins).
	pub log_peak: usize,
}

#[cfg(feature = "native")]
const SERVICES: [&str; 18] = ["train", "vendor", "sethome", "getfp", "repair", "buy", "learn", "fly", "hearth", "goto", "boat", "note", "level", "die", "use", "equip", "skill", "talk"];

#[cfg(feature = "native")]
fn d(a: Option<WPt>, b: Option<WPt>) -> f64 {
	match (a, b) {
		(Some(a), Some(b)) if a.c == b.c => (a.wx - b.wx).hypot(a.wy - b.wy),
		_ => f64::INFINITY,
	}
}

/// The level model's grind along `goals`, in minutes: (all of it, the part `level` goals write). With no
/// goal carrying the model's grind (a recorded JS walk), both are `fallback` (the `level` goals' time).
pub fn grind_split<'a>(goals: impl IntoIterator<Item = &'a WalkGoal>, fallback: f64) -> (f64, f64) {
	let (mut modelled, mut all, mut shown) = (false, 0.0, 0.0);
	for g in goals.into_iter().filter(|g| g.grind.is_finite()) {
		modelled = true;
		all += g.grind;
		if g.t == "level" {
			shown += g.grind;
		}
	}
	if modelled {
		((all / 60.0).round(), (shown / 60.0).round())
	} else {
		(fallback, fallback)
	}
}

/// gmeasure.js on a judged walk cut at `to`.
#[cfg(feature = "native")]
pub fn measures(j: &crate::walk::Judged, to: f64) -> Measures {
	let goals: Vec<&WalkGoal> = j.walk.goals.iter().filter(|g| g.lvl.is_finite() && g.lvl < to).collect();
	let (mut deaths, mut grind, mut trains, mut trips) = (0, 0.0, 0, 0);
	for i in 0..goals.len() {
		let g = goals[i];
		if g.t == "die" {
			deaths += 1;
		}
		if g.t == "level" && g.time_after.is_finite() {
			grind += g.time_after - g.time;
		}
		if g.t != "train" {
			continue;
		}
		trains += 1;
		// The trainer's place: the goal's own, else a goto right before it.
		let at = g.w.or(if i > 0 && goals[i - 1].t == "goto" { goals[i - 1].w } else { None });
		let Some(at) = at else { continue };
		let (mut a, mut b) = (i, i);
		while a > 0 && (goals[a - 1].w.is_none() || d(goals[a - 1].w, Some(at)) <= 400.0) {
			a -= 1;
		}
		while b + 1 < goals.len() && (goals[b + 1].w.is_none() || d(goals[b + 1].w, Some(at)) <= 400.0) {
			b += 1;
		}
		let mut pj = a as i64 - 1;
		while pj >= 0 && (goals[pj as usize].t == "level" || goals[pj as usize].w.is_none()) {
			pj -= 1;
		}
		let mut nk = b + 1;
		while nk < goals.len() && (goals[nk].t == "level" || goals[nk].w.is_none()) {
			nk += 1;
		}
		let prev = if pj >= 0 { goals[pj as usize].w } else { None };
		let next = goals.get(nk).and_then(|g| g.w);
		let back = prev.is_some() && next.is_some() && d(prev, next) < d(prev, Some(at));
		if back && goals[a..=b].iter().all(|x| SERVICES.contains(&x.t.as_str()) || x.q.is_none()) {
			trips += 1;
		}
	}
	let mut held: FxHashSet<i64> = FxHashSet::default();
	let mut peak = 0;
	for g in &goals {
		match (g.t.as_str(), g.q) {
			("accept", Some(q)) => {
				held.insert(q);
				peak = peak.max(held.len());
			}
			("turnin", Some(q)) => {
				held.remove(&q);
			}
			_ => {}
		}
	}
	let s = &j.returns.summary;
	let (grind_all_min, grind_shown_min) = grind_split(goals.iter().copied(), (grind / 60.0).round());
	Measures {
		to,
		hours: (j.walk.hours * 10.0).round() / 10.0,
		end_level: j.walk.end_level,
		quests_done: j.background.quests_done,
		zone_changes: j.background.zone_changes,
		passed_by: j.passed_by.count,
		pb_never: j.passed_by.never,
		pb_later: j.passed_by.later,
		q_per_visit: if s.area_visits > 0 { (j.background.quests_done as f64 / s.area_visits as f64 * 100.0).round() / 100.0 } else { 0.0 },
		area_visits: s.area_visits,
		returns: s.avoidable_returns,
		wasted_trips: s.wasted_trips,
		left_behind: s.left_behind,
		same_mob: s.same_mob_avoidable,
		deaths,
		trains,
		train_trips: trips,
		grind_min: (grind / 60.0).round(),
		grind_all_min,
		grind_shown_min,
		log_peak: peak,
	}
}

/// The order's stream against the written walk (sdiff.js).
#[derive(Clone, Debug, Default, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct StreamDiff {
	pub order_h30: Option<f64>,
	pub order_h60: f64,
	pub order_end: f64,
	pub written_h30: Option<f64>,
	pub written_h60: f64,
	pub written_end: f64,
	pub order_events: usize,
	pub written_events: usize,
	pub in_both: usize,
	pub out_of_order: Vec<String>,
	pub only_in_order: Vec<String>,
	pub only_written: Vec<String>,
	/// The written walk's time lost (minutes) before each common accept/turn-in, biggest first.
	pub losses: Vec<(String, f64)>,
}

/// A goal list's quest events, first of each (`accept Q`, `turnin Q`, `work Q`).
fn events(goals: &[WalkGoal]) -> Vec<String> {
	let mut seen = FxHashSet::default();
	let mut out = Vec::new();
	for g in goals {
		let Some(q) = g.q else { continue };
		if g.t == "level" || g.t == "note" {
			continue;
		}
		let k = if g.t == "accept" || g.t == "turnin" { format!("{} {q}", g.t) } else { format!("work {q}") };
		if seen.insert(k.clone()) {
			out.push(k);
		}
	}
	out
}

/// Hours to 30 and 60 and the end level, and the time of each first accept/turn-in, by sdiff.js's play.
fn hours(model: &SimLevels, goals: &[WalkGoal]) -> (Option<f64>, f64, f64, FxHashMap<String, f64>) {
	let after = model.play(goals);
	let (mut h30, mut h60, mut end) = (None, 0.0, 0.0);
	let mut at: FxHashMap<String, f64> = FxHashMap::default();
	for (g, a) in goals.iter().zip(&after) {
		let Some((lvl, t)) = *a else { continue };
		if h30.is_none() && lvl >= 30.0 {
			h30 = Some(t / 3600.0);
		}
		if let Some(q) = g.q.filter(|_| g.t == "accept" || g.t == "turnin") {
			at.entry(format!("{} {}", g.t, q)).or_insert(t);
		}
		h60 = t / 3600.0;
		end = lvl;
		if lvl >= 60.0 {
			break;
		}
	}
	(h30, h60, end, at)
}

/// Positions of the longest increasing subsequence's members.
fn lis_keep(seq: &[usize]) -> FxHashSet<usize> {
	let mut tails: Vec<usize> = Vec::new();
	let mut prev = vec![usize::MAX; seq.len()];
	for i in 0..seq.len() {
		let (mut lo, mut hi) = (0, tails.len());
		while lo < hi {
			let m = (lo + hi) / 2;
			if seq[tails[m]] < seq[i] {
				lo = m + 1;
			} else {
				hi = m;
			}
		}
		prev[i] = if lo > 0 { tails[lo - 1] } else { usize::MAX };
		if lo == tails.len() {
			tails.push(i);
		} else {
			tails[lo] = i;
		}
	}
	let mut keep = FxHashSet::default();
	let mut i = tails.last().copied().unwrap_or(usize::MAX);
	while i != usize::MAX {
		keep.insert(i);
		i = prev[i];
	}
	keep
}

/// The stream's goals (`{ goals: [{ t, q, oi, w, lvl, ... }] }`, forge-sim's judge stream) as walk goals,
/// `collect` as `complete`.
pub fn stream_goals(doc: &serde_json::Value) -> Vec<WalkGoal> {
	let mut out = Vec::new();
	let mut last: Option<WPt> = None;
	for (i, g) in doc["goals"].as_array().map_or(&[][..], |v| &v[..]).iter().enumerate() {
		let t = g["t"].as_str().unwrap_or("").to_string();
		let w = g.get("w").filter(|w| w.is_object()).map(|w| WPt {
			c: w["c"].as_i64().unwrap_or(0),
			wx: w["wx"].as_f64().unwrap_or(0.0),
			wy: w["wy"].as_f64().unwrap_or(0.0),
			map: w["map"].as_u64().unwrap_or(0) as u32,
		});
		if w.is_some() {
			last = w;
		}
		out.push(WalkGoal {
			i,
			guide: String::new(),
			file: g["file"].as_str().unwrap_or("").to_string(),
			line: g["line"].as_u64().map(|l| l as u32),
			step: None,
			t: if t == "collect" { "complete".into() } else { t },
			q: g["q"].as_i64(),
			oi: g["oi"].as_i64(),
			optional: false,
			passing: false,
			map: w.map(|w| w.map),
			w,
			npc: None,
			level: g["level"].as_f64(),
			title: None,
			lvl: g["lvl"].as_f64().unwrap_or(f64::NAN),
			time: 0.0,
			lvl_after: g["lvlAfter"].as_f64().unwrap_or(f64::NAN),
			time_after: 0.0,
			grind: f64::NAN,
			pos: w.or(last),
			along: None,
			label: None,
			item: None,
			spots: Vec::new(),
			class: false,
		});
	}
	out
}

/// sdiff.js: the order stream (a level-60 grind appended) and the written walk in one evaluator.
pub fn stream_diff(model: &SimLevels, stream: &[WalkGoal], written: &[WalkGoal], title: &dyn Fn(i64) -> String) -> StreamDiff {
	let mut st: Vec<WalkGoal> = stream.to_vec();
	let mut tail = st.last().cloned().unwrap_or_else(|| written[0].clone());
	tail.t = "level".into();
	tail.q = None;
	tail.level = Some(60.0);
	tail.i = st.len();
	st.push(tail);
	let (a30, a60, aend, ta) = hours(model, &st);
	let (b30, b60, bend, tb) = hours(model, written);
	let ea = events(&st);
	let eb = events(written);
	let ia: FxHashMap<&String, usize> = ea.iter().enumerate().map(|(i, x)| (x, i)).collect();
	let in_both: Vec<&String> = eb.iter().filter(|x| ia.contains_key(x)).collect();
	let sb: FxHashSet<&String> = eb.iter().collect();
	let keep = lis_keep(&in_both.iter().map(|x| ia[x]).collect::<Vec<_>>());
	let nm = |x: &String| -> String { x.split(' ').nth(1).and_then(|q| q.parse::<i64>().ok()).map_or(x.clone(), |q| format!("{x} {}", title(q))) };
	let mut losses: Vec<(String, f64)> = Vec::new();
	let mut last = 0.0;
	for x in &ea {
		let (Some(a), Some(b)) = (ta.get(x), tb.get(x)) else { continue };
		let gap = b - a;
		losses.push((nm(x), (gap - last) / 60.0));
		last = gap;
	}
	losses.sort_by(|p, q| q.1.total_cmp(&p.1));
	losses.truncate(20);
	StreamDiff {
		order_h30: a30,
		order_h60: a60,
		order_end: aend,
		written_h30: b30,
		written_h60: b60,
		written_end: bend,
		order_events: ea.len(),
		written_events: eb.len(),
		in_both: in_both.len(),
		out_of_order: in_both.iter().enumerate().filter(|(i, _)| !keep.contains(i)).map(|(_, x)| nm(x)).collect(),
		only_in_order: ea.iter().filter(|x| !sb.contains(x)).map(nm).collect(),
		only_written: eb.iter().filter(|x| !ia.contains_key(x)).map(nm).collect(),
		losses,
	}
}

/// honest-sum.js: fail findings of the race on the chain's guides, by rule.
pub fn honest_sum(findings: &[Finding], chain: &FxHashSet<String>) -> BTreeMap<String, usize> {
	let mut out = BTreeMap::new();
	for f in findings {
		if f.severity == Severity::Fail && chain.contains(&f.guide) {
			*out.entry(f.rule.to_string()).or_default() += 1;
		}
	}
	out
}

/// honest-diff.js's key: rule and reason less its distances.
pub fn diff_key(f: &Finding) -> String {
	let r = regex_lite_replace(&f.reason);
	format!("{} {r}", f.rule)
}

/// `(N yd)` out, `N yd` as `N yd` (honest-diff.js's norm).
fn regex_lite_replace(r: &str) -> String {
	let mut s = String::with_capacity(r.len());
	let b = r.as_bytes();
	let mut i = 0;
	while i < b.len() {
		// A number (digits, dot) followed by " yd": "N yd"; inside parentheses: dropped.
		if b[i].is_ascii_digit() {
			let mut j = i;
			while j < b.len() && (b[j].is_ascii_digit() || b[j] == b'.') {
				j += 1;
			}
			if r[j..].starts_with(" yd") {
				let paren = i > 0 && b[i - 1] == b'(' && r[j + 3..].starts_with(')');
				if paren {
					s.pop();
					i = j + 4;
				} else {
					s.push_str("N yd");
					i = j + 3;
				}
				continue;
			}
			s.push_str(&r[i..j]);
			i = j;
			continue;
		}
		let ch = r[i..].chars().next().unwrap();
		s.push(ch);
		i += ch.len_utf8();
	}
	s
}

/// honest-diff.js: distinct (rule, reason) fail findings on the chain v1's findings do not have, with the
/// first place each is met.
pub fn honest_new(findings: &[Finding], v1: &[Finding], chain: &FxHashSet<String>, rule: Option<&str>) -> Vec<String> {
	honest_new_findings(findings, v1, chain, rule).into_iter().map(|f| format!("{}:{} {}: {}", f.guide.trim_start_matches("forever/"), f.line, f.title, f.reason)).collect()
}

/// [`honest_new`]'s findings themselves (the first of each key).
pub fn honest_new_findings<'a>(findings: &'a [Finding], v1: &[Finding], chain: &FxHashSet<String>, rule: Option<&str>) -> Vec<&'a Finding> {
	let have: FxHashSet<String> = v1.iter().filter(|f| f.severity == Severity::Fail).map(diff_key).collect();
	let mut seen: FxHashSet<String> = FxHashSet::default();
	let mut out = Vec::new();
	for f in findings {
		if f.severity != Severity::Fail || !chain.contains(&f.guide) || rule.is_some_and(|r| r != f.rule) {
			continue;
		}
		let k = diff_key(f);
		if have.contains(&k) || !seen.insert(k) {
			continue;
		}
		out.push(f);
	}
	out
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn diff_key_drops_distances_as_honest_diff_js() {
		assert_eq!(regex_lite_replace("zone change with no travel line: Mulgore to Desolace (1321 yd)"), "zone change with no travel line: Mulgore to Desolace ");
		assert_eq!(regex_lite_replace("nearest is Ratchet, 987 yd away (The Barrens 68.62,49.16)"), "nearest is Ratchet, N yd away (The Barrens 68.62,49.16)");
	}

	#[test]
	fn lis_keeps_the_longest_order() {
		let k = lis_keep(&[0, 2, 1, 3]);
		assert_eq!(k.len(), 3);
		assert!(k.contains(&0) && k.contains(&3));
	}
}

/// One start to report: the route (forge-sim's order), its judge stream (optional) and the written guides.
#[derive(Clone, Debug, Serialize)]
pub struct StartInput {
	pub route: std::path::PathBuf,
	pub stream: Option<std::path::PathBuf>,
	pub guides: std::path::PathBuf,
}

/// What `run` reads: the starts, v1's guides, the checkout the guides were built with (data, sources,
/// data/rules.json, the knowledge base), the data the guides compile against and the sim dir
/// holding `world-<faction>.json` and `params.json` (the world built on that data).
#[derive(Clone, Debug, Serialize)]
pub struct Inputs {
	pub starts: Vec<StartInput>,
	pub v1: std::path::PathBuf,
	pub root: std::path::PathBuf,
	pub data_dir: std::path::PathBuf,
	pub sim_dir: std::path::PathBuf,
	/// `along` steps walked to where they stand, as walk.js does (false: as the addon plays them).
	pub along_walked: bool,
	/// Run v1's player-report guide tests and lint on v1 and each written tree (seed.rs).
	pub checks: bool,
	/// Hours and levels from the routes stage's model ([`SimLevels::route`]: the walk store, the route
	/// profile's accept and bag rules, written travel lines priced); false: the gate's (JS parity).
	pub route_model: bool,
}

/// The seed tests and lint on one guides folder.
#[derive(Clone, Debug, Default, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Checks {
	pub passed: usize,
	pub failed: Vec<String>,
	pub skipped: usize,
	pub lint_errors: usize,
	pub lint_warnings: usize,
	pub lint_first: Vec<String>,
}

#[cfg(feature = "native")]
fn checks(guides: &std::path::Path, inp: &Inputs) -> Result<Checks, String> {
	let ctx = crate::seed::Ctx::new(guides, &inp.data_dir, &inp.root)?;
	let out = crate::seed::run(&ctx, None);
	let (e, w, first) = crate::seed::lint(guides, &ctx.data);
	Ok(Checks {
		passed: out.iter().filter(|o| o.passed).count(),
		failed: out.iter().filter(|o| !o.passed).map(|o| o.name.clone()).collect(),
		skipped: out.iter().filter(|o| o.skipped.is_some()).count(),
		lint_errors: e,
		lint_warnings: w,
		lint_first: first,
	})
}

/// One start's report.
#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct StartReport {
	pub route: std::path::PathBuf,
	pub guides: std::path::PathBuf,
	pub faction: String,
	pub race: String,
	/// ("v1" | "written", row) to 30 and to 60.
	pub rows: Vec<(String, Measures)>,
	pub honest_v1: BTreeMap<String, usize>,
	pub honest_written: BTreeMap<String, usize>,
	pub honest_new: Vec<String>,
	pub honest_new_warrior_r1: Vec<String>,
	pub stream: Option<StreamDiff>,
	pub checks: Option<Checks>,
}

/// The data sources a report ran on.
#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Sources {
	pub inputs: Inputs,
	/// data/forever meta.json `builtAt` and `sources` (as recorded by the data build).
	pub data_built: serde_json::Value,
	/// Each faction world's `dataHash` (the data it was built from).
	pub world_hashes: BTreeMap<String, Option<String>>,
}

#[derive(Clone, Debug, Serialize)]
pub struct Output {
	pub sources: Sources,
	/// The seed tests and lint on v1's guides (with `checks`).
	pub v1_checks: Option<Checks>,
	pub starts: Vec<StartReport>,
}

/// The report for every start (the forge `report` stage): each start on its own thread (a start loads
/// its own data and knowledge base, the value model is per thread), then v1's checks; starts in input order.
#[cfg(feature = "native")]
pub fn run(inp: &Inputs) -> Result<Output, String> {
	let mut jobs: Vec<Option<&StartInput>> = inp.starts.iter().map(Some).collect();
	if inp.checks {
		jobs.push(None);
	}
	enum Done {
		Start(String, Option<String>, Box<StartReport>),
		V1(Checks),
	}
	let walks = std::sync::Mutex::new(rustc_hash::FxHashMap::default());
	let one = |job: &Option<&StartInput>| -> Result<Done, String> {
		match job {
			Some(s) => start_report(inp, s, &walks).map(|(f, h, r)| Done::Start(f, h, Box::new(r))),
			None => checks(&inp.v1, inp).map(Done::V1),
		}
	};
	let done: Vec<Done> = {
		use rayon::prelude::*;
		jobs.par_iter().map(one).collect::<Result<_, String>>()?
	};
	let mut world_hashes = BTreeMap::new();
	let mut starts = Vec::new();
	let mut v1_checks = None;
	for d in done {
		match d {
			Done::Start(f, h, r) => {
				world_hashes.insert(f, h);
				starts.push(*r);
			}
			Done::V1(c) => v1_checks = Some(c),
		}
	}
	let meta: serde_json::Value = std::fs::read(inp.data_dir.join("meta.json")).ok().and_then(|b| serde_json::from_slice(&b).ok()).unwrap_or_default();
	let data_built = serde_json::json!({ "builtAt": meta["builtAt"], "sources": meta["sources"] });
	Ok(Output { sources: Sources { inputs: inp.clone(), data_built, world_hashes }, v1_checks, starts })
}

/// The walk stores loaded so far, by faction (every start of a faction shares one).
#[cfg(feature = "native")]
type WalksCache = std::sync::Mutex<rustc_hash::FxHashMap<String, Option<std::sync::Arc<forge_sim::WalkTable>>>>;

/// One start's report -> (its faction, its world's data hash, the report).
#[cfg(feature = "native")]
fn start_report(inp: &Inputs, s: &StartInput, walks: &WalksCache) -> Result<(String, Option<String>, StartReport), String> {
	use crate::honest::{self, HonestOpts, PackRun};
	use crate::walk::{judge_walk, JudgeOpts};
	let gdata = forge_guide::data::load_data(&inp.data_dir)?;
	let kb = honest::load_kb(&inp.root.join("data/local/kb/forever-kb.sqlite"))?;
	let title = |q: i64| {
		let t = gdata.quests.get(&q.to_string()).get("title");
		if t.truthy() {
			t.to_js_string()
		} else {
			String::new()
		}
	};
	let route: serde_json::Value = serde_json::from_slice(&std::fs::read(&s.route).map_err(|e| format!("{}: {e}", s.route.display()))?).map_err(|e| format!("{}: {e}", s.route.display()))?;
	let faction = route["faction"].as_str().ok_or_else(|| format!("{}: no faction", s.route.display()))?.to_string();
	let race = route["start"].as_str().ok_or_else(|| format!("{}: no start", s.route.display()))?.to_string();
	let fac = forge_core::Faction::parse(&faction).ok_or_else(|| format!("unknown faction {faction}"))?;
	let world = forge_sim::load_world(&inp.sim_dir, fac)?;
	let params: Option<serde_json::Value> = std::fs::read(inp.sim_dir.join("params.json")).ok().and_then(|b| serde_json::from_slice(&b).ok());
	let lv = if inp.route_model { SimLevels::route(&world, &race, params.as_ref(), crate::levels::walks_for(walks, &inp.sim_dir, &world))? } else { SimLevels::new(&world, &race, params.as_ref())? };
	let judge = |tree: &std::path::Path, to: f64| {
		let mut jo = JudgeOpts::new(tree, &faction, &race, None, &inp.root);
		jo.data_dir = inp.data_dir.clone();
		jo.to = to;
		jo.along_on_the_way = !inp.along_walked;
		judge_walk(&jo, &lv)
	};
	let mut rows = Vec::new();
	let mut chains: Vec<FxHashSet<String>> = Vec::new();
	let mut written_goals = Vec::new();
	for (name, tree) in [("v1", &inp.v1), ("written", &s.guides)] {
		for to in [30.0, 61.0] {
			let j = judge(tree, to)?;
			if to == 61.0 {
				chains.push(j.walk.chain.iter().cloned().collect());
				if name == "written" {
					written_goals = j.walk.goals.clone();
				}
			}
			rows.push((name.to_string(), measures(&j, to)));
		}
	}
	let run = PackRun { filter: None, faction: Some(faction.clone()), race: Some(race.clone()), classes: None };
	let hv1 = honest::play_pack(&inp.v1, &gdata, kb.as_ref(), &run, &HonestOpts::legacy())?.findings;
	let hw = honest::play_pack(&s.guides, &gdata, kb.as_ref(), &run, &HonestOpts::legacy())?.findings;
	let warrior = |fs: &[Finding]| -> Vec<Finding> { fs.iter().filter(|f| f.cls.eq_ignore_ascii_case("WARRIOR")).cloned().collect() };
	let stream_f = s.stream.clone().or_else(|| {
		let p = s.route.to_string_lossy().into_owned();
		p.strip_suffix(".json").map(|b| std::path::PathBuf::from(format!("{b}.judge-improved.json"))).filter(|f| f.exists())
	});
	let stream = match &stream_f {
		Some(f) => {
			let doc: serde_json::Value = serde_json::from_slice(&std::fs::read(f).map_err(|e| format!("{}: {e}", f.display()))?).map_err(|e| format!("{}: {e}", f.display()))?;
			Some(stream_diff(&lv, &stream_goals(&doc), &written_goals, &title))
		}
		None => None,
	};
	let report = StartReport {
		route: s.route.clone(),
		guides: s.guides.clone(),
		faction,
		race,
		rows,
		honest_v1: honest_sum(&hv1, &chains[0]),
		honest_written: honest_sum(&hw, &chains[1]),
		honest_new: honest_new(&hw, &hv1, &chains[1], None),
		honest_new_warrior_r1: honest_new(&warrior(&hw), &warrior(&hv1), &chains[1], Some("R1")),
		stream,
		checks: if inp.checks { Some(checks(&s.guides, inp)?) } else { None },
	};
	Ok((report.faction.clone(), world.data_hash.clone(), report))
}

/// report.md.
pub fn markdown(o: &Output) -> String {
	use std::fmt::Write;
	let mut m = String::new();
	let _ = writeln!(m, "# Route report\n");
	let i = &o.sources.inputs;
	let _ = writeln!(
		m,
		"Sources: guides `{}`, data `{}` (built {}), sim `{}`, root `{}`; worlds {}.\n",
		i.v1.display(),
		i.data_dir.display(),
		o.sources.data_built["builtAt"],
		i.sim_dir.display(),
		i.root.display(),
		o.sources.world_hashes.iter().map(|(f, h)| format!("{f} {}", h.as_deref().unwrap_or("-"))).collect::<Vec<_>>().join(", ")
	);
	let _ = writeln!(m, "| start | chain | to | hours | level | quests | zone changes | passed by (never/later) | returns (wasted) | left behind | same mob | area visits | deaths | trains (trips) | grind min | log peak |");
	let _ = writeln!(m, "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|");
	for s in &o.starts {
		for (n, r) in &s.rows {
			let _ = writeln!(
				m,
				"| {} | {} | {} | {:.1} | {:.2} | {} | {} | {} ({}/{}) | {} ({}) | {} | {} | {} | {} | {} ({}) | {} | {} |",
				s.race,
				if n == "v1" { "guides" } else { n.as_str() },
				r.to as u32,
				r.hours,
				r.end_level,
				r.quests_done,
				r.zone_changes,
				r.passed_by,
				r.pb_never,
				r.pb_later,
				r.returns,
				r.wasted_trips,
				r.left_behind,
				r.same_mob,
				r.area_visits,
				r.deaths,
				r.trains,
				r.train_trips,
				r.grind_min,
				r.log_peak
			);
		}
	}
	let ck = |c: &Checks| {
		format!(
			"seed tests {} pass, {} fail{}; lint {} errors, {} warnings",
			c.passed,
			c.failed.len(),
			if c.failed.is_empty() { String::new() } else { format!(" ({})", c.failed.join("; ")) },
			c.lint_errors,
			c.lint_warnings
		)
	};
	if let Some(c) = &o.v1_checks {
		let _ = writeln!(m, "\nThe guides: {}.", ck(c));
	}
	for s in &o.starts {
		let tot = |x: &BTreeMap<String, usize>| x.values().sum::<usize>();
		if let Some(c) = &s.checks {
			let _ = writeln!(m, "\n{} written: {}.", s.race, ck(c));
			for l in &c.lint_first {
				let _ = writeln!(m, "- {l}");
			}
		}
		let _ = writeln!(m, "\n## {} {}\n", s.faction, s.race);
		let _ = writeln!(m, "Route `{}`, written `{}`.\n", s.route.display(), s.guides.display());
		let _ = writeln!(
			m,
			"Rules R1-R5 ({}, chain, fail): the guides {} {:?}; written {} {:?}. New vs the guides: {} distinct; the Warrior's R1: {}.",
			s.race,
			tot(&s.honest_v1),
			s.honest_v1,
			tot(&s.honest_written),
			s.honest_written,
			s.honest_new.len(),
			s.honest_new_warrior_r1.len()
		);
		for l in s.honest_new_warrior_r1.iter().take(30) {
			let _ = writeln!(m, "- {l}");
		}
		if let Some(d) = &s.stream {
			let f = |h: Option<f64>| h.map_or("-".into(), |h| format!("{h:.2}"));
			let _ = writeln!(
				m,
				"\nStream vs written: order {} / {:.2} h (end {:.2}); written {} / {:.2} h (end {:.2}). Events: order {}, written {}, in both {}, out of order {}; only in order {}, only written {}.",
				f(d.order_h30),
				d.order_h60,
				d.order_end,
				f(d.written_h30),
				d.written_h60,
				d.written_end,
				d.order_events,
				d.written_events,
				d.in_both,
				d.out_of_order.len(),
				d.only_in_order.len(),
				d.only_written.len()
			);
			let _ = writeln!(m, "\n- only in order: {}\n- only written: {}", d.only_in_order.join("; "), d.only_written.join("; "));
			let _ = writeln!(m, "- biggest losses: {}", d.losses.iter().take(10).map(|(x, v)| format!("+{v:.1} min before {x}")).collect::<Vec<_>>().join("; "));
		}
	}
	m
}

/// The dashboard's route status (data/local/dashboard/routes.json): per start what Fitz looks at first,
/// from a report (and the routes stage's `<start>.skips.json` beside the routes).
#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct RouteStatus {
	/// When the report was written (its file's mtime, RFC 3339 UTC) and what it ran on.
	pub built_at: Option<String>,
	pub report: std::path::PathBuf,
	pub sources: serde_json::Value,
	pub v1_checks: Option<Checks>,
	pub starts: Vec<StartStatus>,
}

#[derive(Clone, Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct StartStatus {
	pub start: String,
	pub faction: String,
	/// [to 30, to 60] hours.
	pub v1_hours: [f64; 2],
	pub new_hours: [f64; 2],
	pub v1_passed_by: usize,
	pub new_passed_by: usize,
	pub v1_returns: usize,
	pub new_returns: usize,
	pub v1_honest_fails: usize,
	pub new_honest_fails: usize,
	pub honest_new: usize,
	pub checks: Option<Checks>,
	/// Quests the route leaves out for missing information (`reason: missing-info` in the skips), and all skips.
	pub skips_missing_info: Option<usize>,
	pub skips: Option<usize>,
	pub guides: std::path::PathBuf,
	pub route: std::path::PathBuf,
}

/// RFC 3339 UTC of a system time (seconds).
fn rfc3339(t: std::time::SystemTime) -> Option<String> {
	let s = t.duration_since(std::time::UNIX_EPOCH).ok()?.as_secs() as i64;
	let (days, rem) = (s.div_euclid(86400), s.rem_euclid(86400));
	// Civil date from days since 1970-01-01 (Howard Hinnant's algorithm).
	let z = days + 719468;
	let era = z.div_euclid(146097);
	let doe = z - era * 146097;
	let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365;
	let y = yoe + era * 400;
	let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
	let mp = (5 * doy + 2) / 153;
	let d = doy - (153 * mp + 2) / 5 + 1;
	let m = if mp < 10 { mp + 3 } else { mp - 9 };
	Some(format!("{:04}-{:02}-{:02}T{:02}:{:02}:{:02}Z", if m <= 2 { y + 1 } else { y }, m, d, rem / 3600, rem % 3600 / 60, rem % 60))
}

/// The route status from a report.json (`report_file`).
pub fn route_status(report_file: &std::path::Path) -> Result<RouteStatus, String> {
	let doc: serde_json::Value = serde_json::from_slice(&std::fs::read(report_file).map_err(|e| format!("{}: {e}", report_file.display()))?).map_err(|e| format!("{}: {e}", report_file.display()))?;
	let built_at = std::fs::metadata(report_file).ok().and_then(|m| m.modified().ok()).and_then(rfc3339);
	let checks = |v: &serde_json::Value| -> Option<Checks> {
		if v.is_null() {
			return None;
		}
		let n = |k: &str| v[k].as_u64().unwrap_or(0) as usize;
		let strs = |k: &str| v[k].as_array().map_or(Vec::new(), |a| a.iter().filter_map(|x| x.as_str().map(str::to_string)).collect());
		Some(Checks { passed: n("passed"), failed: strs("failed"), skipped: n("skipped"), lint_errors: n("lintErrors"), lint_warnings: n("lintWarnings"), lint_first: strs("lintFirst") })
	};
	let mut starts = Vec::new();
	for s in doc["starts"].as_array().map_or(&[][..], |a| &a[..]) {
		let row =
			|chain: &str, to: u64| s["rows"].as_array().and_then(|rs| rs.iter().find(|r| r[0] == chain && r[1]["to"].as_f64().map(|t| t as u64) == Some(to))).map(|r| r[1].clone()).unwrap_or_default();
		let (v30, v60, n30, n60) = (row("v1", 30), row("v1", 61), row("written", 30), row("written", 61));
		let h = |r: &serde_json::Value| r["hours"].as_f64().unwrap_or(f64::NAN);
		let u = |r: &serde_json::Value, k: &str| r[k].as_u64().unwrap_or(0) as usize;
		let tot = |v: &serde_json::Value| v.as_object().map_or(0, |o| o.values().filter_map(|x| x.as_u64()).sum::<u64>() as usize);
		let route = std::path::PathBuf::from(s["route"].as_str().unwrap_or(""));
		// The routes stage writes <start>.skips.json beside <start>.json.
		let skips_doc: Option<serde_json::Value> =
			route.to_str().and_then(|r| r.strip_suffix(".json")).and_then(|b| std::fs::read(format!("{b}.skips.json")).ok()).and_then(|b| serde_json::from_slice(&b).ok());
		let skip_list = skips_doc.as_ref().and_then(|d| d.as_array().cloned().or_else(|| d["skips"].as_array().cloned()));
		starts.push(StartStatus {
			start: s["race"].as_str().unwrap_or("").to_string(),
			faction: s["faction"].as_str().unwrap_or("").to_string(),
			v1_hours: [h(&v30), h(&v60)],
			new_hours: [h(&n30), h(&n60)],
			v1_passed_by: u(&v60, "passedBy"),
			new_passed_by: u(&n60, "passedBy"),
			v1_returns: u(&v60, "returns"),
			new_returns: u(&n60, "returns"),
			v1_honest_fails: tot(&s["honestV1"]),
			new_honest_fails: tot(&s["honestWritten"]),
			honest_new: s["honestNew"].as_array().map_or(0, Vec::len),
			checks: checks(&s["checks"]),
			skips_missing_info: skip_list.as_ref().map(|l| l.iter().filter(|x| x["reason"] == "missing-info").count()),
			skips: skip_list.as_ref().map(Vec::len),
			guides: std::path::PathBuf::from(s["guides"].as_str().unwrap_or("")),
			route,
		});
	}
	Ok(RouteStatus { built_at, report: report_file.to_path_buf(), sources: doc["sources"].clone(), v1_checks: checks(&doc["v1Checks"]), starts })
}

#[cfg(test)]
mod status_tests {
	use super::*;

	#[test]
	fn rfc3339_of_known_times() {
		let t = |s: u64| rfc3339(std::time::UNIX_EPOCH + std::time::Duration::from_secs(s)).unwrap();
		assert_eq!(t(0), "1970-01-01T00:00:00Z");
		assert_eq!(t(1_792_660_000), "2026-10-22T09:06:40Z");
		assert_eq!(t(951_782_400), "2000-02-29T00:00:00Z");
	}

	#[test]
	fn status_reads_a_report() {
		let dir = std::env::temp_dir().join(format!("route-status-{}", std::process::id()));
		std::fs::create_dir_all(&dir).unwrap();
		std::fs::write(dir.join("Orc.skips.json"), r#"[{"q":8,"reason":"missing-info"},{"q":9,"reason":"group"}]"#).unwrap();
		let route = dir.join("Orc.json");
		let rep = serde_json::json!({
			"sources": { "builtAt": "x" },
			"v1Checks": { "passed": 138, "failed": [], "skipped": 1, "lintErrors": 0, "lintWarnings": 191, "lintFirst": [] },
			"starts": [{ "race": "Orc", "faction": "Horde", "route": route, "guides": "g",
				"rows": [["v1", { "to": 30.0, "hours": 24.8 }], ["v1", { "to": 61.0, "hours": 128.3, "passedBy": 144, "returns": 64 }], ["written", { "to": 30.0, "hours": 24.8 }], ["written", { "to": 61.0, "hours": 126.9, "passedBy": 150, "returns": 69 }]],
				"honestV1": { "R1": 493, "R5": 543 }, "honestWritten": { "R1": 191 }, "honestNew": ["a"],
				"checks": { "passed": 137, "failed": ["#171"], "skipped": 1, "lintErrors": 0, "lintWarnings": 199, "lintFirst": [] } }]
		});
		std::fs::write(dir.join("report.json"), rep.to_string()).unwrap();
		let s = route_status(&dir.join("report.json")).unwrap();
		let o = &s.starts[0];
		assert_eq!((o.v1_hours, o.new_hours), ([24.8, 128.3], [24.8, 126.9]));
		assert_eq!((o.v1_passed_by, o.new_passed_by, o.v1_returns, o.new_returns), (144, 150, 64, 69));
		assert_eq!((o.v1_honest_fails, o.new_honest_fails, o.honest_new), (1036, 191, 1));
		assert_eq!((o.skips, o.skips_missing_info), (Some(2), Some(1)));
		assert_eq!(o.checks.as_ref().unwrap().failed, vec!["#171".to_string()]);
		assert!(s.built_at.is_some());
		std::fs::remove_dir_all(&dir).ok();
	}
}
