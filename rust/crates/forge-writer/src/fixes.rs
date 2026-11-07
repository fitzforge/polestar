//! The fix pass: the checkout's `data/places.json` and `data/guide-fixes.json` applied to the written
//! guides after every write, by anchor (a quest and its goal, never a line or a step number), so a fix
//! survives a re-cut, a re-seed or a new writer. Each record comes back with its state for this start.
//!
//! - **places**: where an objective is done, or where the arrow leads for a quest's giver or ender:
//!   `{ id, quest, objective: N | "giver" | "ender", at: { map, x, y, frame: "era" | "live" } }`, or
//!   `path: { map, frame, points: [[x, y], ...] }` for a target that walks a road (written as a
//!   `loop` of `goto`s before the goal). The point goes on the goal line (`@x,y map M frame`), or on
//!   the `goto` right before it when the step leads the arrow there with one. An objective without a
//!   line of its own lands on the quest's bare `complete`; with `write: true` the objective gets its
//!   own goal line from the data (`kill`, `talk`, `interact` or `collect` with `quest Q.N`) before
//!   that `complete`, which goes once every objective has its line. `at` is optional then: the
//!   compiler places a written objective from the data. `label` sets the objective line's goal text.
//! - **guide-fixes**: step content that is neither data nor route, at a goal's step:
//!   `{ id, at: { quest, goal: "accept" | "turnin" | "complete" | "objective", objective? }, tip }`
//!   sets the step's `tip`; `level: N` puts a `level N` gate right before the anchor goal (with
//!   `after: true`, right after it: the hand-ins at the anchor count towards the level). `background` (on an objective,
//!   #1135) makes a slow, zone-wide collection a goal of the whole stay: listed on the way from the
//!   quest's accept to its hand-in, with a finish step before the hand-in (apply_background).
//!
//! A record with `faction` ("Alliance" or "Horde") applies only to that faction's routes (a quest both
//! sides do whose fix holds for one). Every record carries `source` ({ kind, ref }), `issue` and `note`;
//! `forge data check-corrections`
//! checks them. States: `applied` (this write changed a line for it), `redundant` (the written guides
//! already say it: the seed carries the fix), `not for this start` (no line to anchor it on, and its
//! quest is not in the route), `stale` (the quest is in the route but the written guides have no line
//! to anchor it on) and
//! `conflicting` (two records want different things on one anchor; neither is applied).

use std::collections::{BTreeMap, HashSet};

use serde::Serialize;
use serde_json::Value;

use crate::input::Data;
use crate::jsre::{is_step, split_comment, trim, trim_end};
use crate::re;

/// The records: the documents of data/places.json and data/guide-fixes.json (None: no file).
#[derive(Clone, Copy, Default)]
pub struct Records<'a> {
	pub places: Option<&'a Value>,
	pub guide_fixes: Option<&'a Value>,
}

/// One record and what the fix pass did with it.
#[derive(Clone, Debug, Serialize, PartialEq)]
#[serde(rename_all = "camelCase")]
pub struct FixRow {
	/// `places` or `guide-fixes`.
	pub file: String,
	pub id: String,
	pub state: String,
	pub detail: String,
	pub issues: Vec<u32>,
	/// The lines it applies to, `<guide>:<line>` (1-based, in the written guide).
	pub lines: Vec<String>,
}

/// What a goal anchor names.
#[derive(Clone, Debug, PartialEq, Eq, Hash)]
enum Anchor {
	Giver(u32),
	Ender(u32),
	/// A bare `complete Q` (or `complete Q.N`).
	Complete(u32),
	Objective(u32, u32),
}

impl Anchor {
	fn quest(&self) -> u32 {
		match *self {
			Anchor::Giver(q) | Anchor::Ender(q) | Anchor::Complete(q) | Anchor::Objective(q, _) => q,
		}
	}
	fn describe(&self) -> String {
		match *self {
			Anchor::Giver(q) => format!("accept {q}"),
			Anchor::Ender(q) => format!("turnin {q}"),
			Anchor::Complete(q) => format!("complete {q}"),
			Anchor::Objective(q, n) => format!("objective {q}.{n}"),
		}
	}
}

fn issues_of(r: &Value) -> Vec<u32> {
	let mut v: Vec<u32> = r["issue"].as_u64().map(|n| n as u32).into_iter().collect();
	v.extend(r["issues"].as_array().into_iter().flatten().filter_map(|n| n.as_u64().map(|n| n as u32)));
	v
}

fn place_anchor(r: &Value) -> Option<Anchor> {
	let q = r["quest"].as_u64()? as u32;
	match &r["objective"] {
		Value::String(s) if s == "giver" => Some(Anchor::Giver(q)),
		Value::String(s) if s == "ender" => Some(Anchor::Ender(q)),
		Value::Number(n) => Some(Anchor::Objective(q, n.as_u64()? as u32)),
		_ => None,
	}
}

fn fix_anchor(r: &Value) -> Option<Anchor> {
	let at = &r["at"];
	let q = at["quest"].as_u64()? as u32;
	match at["goal"].as_str()? {
		"accept" => Some(Anchor::Giver(q)),
		"turnin" => Some(Anchor::Ender(q)),
		"complete" => Some(Anchor::Complete(q)),
		"objective" => Some(Anchor::Objective(q, at["objective"].as_u64()? as u32)),
		_ => None,
	}
}

/// The goal lines (0-based indices) of `lines` that `a` names.
fn anchor_lines(lines: &[String], a: &Anchor) -> Vec<usize> {
	let code = |l: &String| split_comment(l).0.to_string();
	let find = |f: &dyn Fn(&str) -> bool| -> Vec<usize> { lines.iter().enumerate().filter(|(_, l)| f(&code(l))).map(|(i, _)| i).collect() };
	match *a {
		Anchor::Giver(q) => find(&|c| re!(r"^\s+accept\s+(\d+)(?:\s|$)").captures(c).is_some_and(|m| m[1] == *q.to_string())),
		Anchor::Ender(q) => find(&|c| re!(r"^\s+turnin\s+(\d+)(?:\s|$)").captures(c).is_some_and(|m| m[1] == *q.to_string())),
		Anchor::Complete(q) => find(&|c| re!(r"^\s+complete\s+(\d+)(?:\.\d+)?(?:\s|$)").captures(c).is_some_and(|m| m[1] == *q.to_string())),
		Anchor::Objective(q, n) => {
			let (qs, full) = (q.to_string(), format!("{q}.{n}"));
			// The objective's own goal lines; else the quest's bare `complete`; else, for the first
			// objective, the quest's goal lines without an objective number.
			let exact = find(&|c| {
				re!(r"^\s+(?:kill|collect|interact|use|talk|complete)\b.*?\bquest\s+(\d+\.\d+)(?:\s|$)").captures(c).is_some_and(|m| m[1] == *full)
					|| re!(r"^\s+complete\s+(\d+\.\d+)(?:\s|$)").captures(c).is_some_and(|m| m[1] == *full)
			});
			if !exact.is_empty() {
				return exact;
			}
			let bare = find(&|c| re!(r"^\s+complete\s+(\d+)(?:\s|$)").captures(c).is_some_and(|m| m[1] == *qs));
			if !bare.is_empty() || n != 1 {
				return bare;
			}
			find(&|c| re!(r"^\s+(?:kill|collect|interact|use)\b.*?\bquest\s+(\d+)(?:\s|$)").captures(c).is_some_and(|m| m[1] == *qs))
		}
	}
}

/// The step holding line `i`: (title line, one past its last line).
fn step_of(lines: &[String], i: usize) -> Option<(usize, usize)> {
	let start = (0..=i).rev().find(|&k| is_step(&lines[k]))?;
	let end = (i + 1..lines.len()).find(|&k| is_step(&lines[k]) || (!lines[k].is_empty() && !lines[k].starts_with(|c: char| c.is_whitespace()) && !lines[k].starts_with('#'))).unwrap_or(lines.len());
	Some((start, end))
}

/// The goal line right before `i` in its step, skipping blank and comment lines.
fn prev_goal(lines: &[String], step: (usize, usize), i: usize) -> Option<usize> {
	(step.0 + 1..i).rev().find(|&k| !trim(&lines[k]).is_empty() && !trim(&lines[k]).starts_with('#'))
}

/// `code` without its typed place (`@x,y[ z]`, `map M`, `era`/`live`), outside quoted text.
fn strip_place(code: &str) -> String {
	code.split('"')
		.enumerate()
		.map(|(i, seg)| {
			if i % 2 == 1 {
				return seg.to_string();
			}
			let s = re!(r"\s@\s*[\d.]+\s*,\s*[\d.]+(\s+[\d.]+)?").replace_all(seg, "");
			let s = re!(r"\s+map\s+\d+").replace_all(&s, "");
			re!(r"\s+(live|era)\b").replace_all(&s, "").into_owned()
		})
		.collect::<Vec<_>>()
		.join("\"")
}

fn num(x: f64) -> String {
	let s = format!("{x}");
	s.strip_suffix(".0").map(str::to_string).unwrap_or(s)
}

/// A place: its map, frame and point (None for a path).
struct At {
	map: u64,
	frame: String,
	x: f64,
	y: f64,
}

fn at_of(v: &Value) -> Option<At> {
	Some(At { map: v["map"].as_u64()?, frame: v["frame"].as_str().unwrap_or("era").to_string(), x: v["x"].as_f64()?, y: v["y"].as_f64()? })
}

/// The point typed on a line (`@x,y` on a goal, `x,y` after `goto`).
fn typed_point(line: &str) -> Option<(f64, f64)> {
	let code = split_comment(line).0;
	let m = re!(r"^\s+goto\s+([\d.]+)\s*,\s*([\d.]+)").captures(code).or_else(|| re!(r"\s@\s*([\d.]+)\s*,\s*([\d.]+)").captures(code))?;
	Some((m[1].parse().ok()?, m[2].parse().ok()?))
}

fn close(a: (f64, f64), b: (f64, f64)) -> bool {
	(a.0 - b.0).abs() < 0.005 && (a.1 - b.1).abs() < 0.005
}

/// The map typed on a line's code (`map M`), outside quoted text.
fn typed_map(line: &str) -> Option<u64> {
	let code = split_comment(line).0;
	let outside: String = code.split('"').step_by(2).collect::<Vec<_>>().join(" ");
	re!(r"\smap\s+(\d+)\b").captures(&outside).and_then(|m| m[1].parse().ok())
}

/// The line with `at` as its typed place.
fn placed(line: &str, at: &At) -> String {
	let (code, rest) = split_comment(line);
	let suffix = format!(" map {} {}", at.map, at.frame);
	if let Some(m) = re!(r"^(\s+goto\s+)[\d.]+\s*,\s*[\d.]+(.*)$").captures(code) {
		// A goto keeps its label: `goto x,y map M frame "label"`.
		let tail = strip_place(&m[2]);
		return format!("{}{},{}{suffix}{}{rest}", &m[1], num(at.x), num(at.y), trim_end(&tail));
	}
	format!("{} @{},{}{suffix}{rest}", trim_end(&strip_place(code)), num(at.x), num(at.y))
}

/// `quest Q.N` on a goal line's code.
fn objective_line(line: &str, q: u32, n: u32) -> bool {
	let code = split_comment(line).0;
	let full = format!("{q}.{n}");
	re!(r"\bquest\s+(\d+\.\d+)(?:\s|$)").captures(code).is_some_and(|m| m[1] == *full) || re!(r"^\s+complete\s+(\d+\.\d+)(?:\s|$)").captures(code).is_some_and(|m| m[1] == *full)
}

/// A place with `write: true`: the objective's own goal line, from the data, before each bare
/// `complete` of the quest among `found`; the bare `complete` goes once every objective with a
/// target has its line in that step. -> (the lines the place now applies to, the changed lines).
fn write_objective(lines: &mut Vec<String>, found: &[usize], q: u32, n: u32, data: Option<&Data>) -> (Vec<usize>, Vec<usize>) {
	if found.iter().all(|&i| objective_line(&lines[i], q, n)) {
		return (found.to_vec(), Vec::new());
	}
	let Some(quest) = data.and_then(|d| d.quests.get(&q)) else { return (found.to_vec(), Vec::new()) };
	let verb = |k: Option<&str>| match k {
		Some("kill") => Some("kill"),
		Some("talk") => Some("talk"),
		Some("object") => Some("interact"),
		Some("item") => Some("collect"),
		_ => None,
	};
	let Some(o) = quest.objective(n as usize - 1) else { return (found.to_vec(), Vec::new()) };
	let (Some(v), Some(id)) = (verb(o.kind.as_deref()), o.id) else { return (found.to_vec(), Vec::new()) };
	let (mut now, mut changed) = (Vec::new(), Vec::new());
	for &i in found.iter().rev() {
		if objective_line(&lines[i], q, n) {
			now.push(i);
			continue;
		}
		let Some(step) = step_of(lines, i) else { continue };
		let ind = lines[i][..lines[i].len() - lines[i].trim_start().len()].to_string();
		// In the objectives' order: before the step's first line of a later objective of the quest
		// (Desperate Times' Ayessa before Elaadrin), else before the complete.
		let later = |l: &String| re!(r"\bquest\s+(\d+)\.(\d+)(?:\s|$)").captures(split_comment(l).0).is_some_and(|m| m[1] == *q.to_string() && m[2].parse::<u32>().is_ok_and(|k| k > n));
		let at = (step.0 + 1..i).find(|&j| later(&lines[j])).unwrap_or(i);
		lines.insert(at, format!("{ind}{v} {} quest {q}.{n}", id as u64));
		let complete = i + 1;
		let step = (step.0, step.1 + 1);
		// Every objective with a target has its own line in the step: the bare complete goes.
		let all = quest.objectives().enumerate().filter(|(_, o)| verb(o.kind.as_deref()).is_some() && o.id.is_some()).count() == quest.objectives().count()
			&& (1..=quest.objectives().count() as u32).all(|k| (step.0..step.1).any(|j| objective_line(&lines[j], q, k)));
		if all {
			lines.remove(complete);
		}
		now.push(at);
		changed.push(at);
	}
	(now, changed)
}

/// `line` (a goal line's code and comment) with `label` as its goal text: the quoted text replaced, or
/// put right after `quest Q.N`.
fn labelled(line: &str, label: &str) -> String {
	let (code, rest) = split_comment(line);
	let quoted = format!("\"{label}\"");
	let code = if code.contains('"') {
		re!(r#""[^"]*""#).replace(code, regex::NoExpand(&quoted)).into_owned()
	} else {
		re!(r"\bquest\s+\d+\.\d+").replace(code, |m: &regex::Captures| format!("{} {quoted}", &m[0])).into_owned()
	};
	format!("{code}{rest}")
}

fn apply_place(lines: &mut Vec<String>, found: &[usize], r: &Value, data: Option<&Data>) -> Vec<usize> {
	let mut changed = Vec::new();
	let mut found = found.to_vec();
	if r["write"] == true {
		if let (Some(q), Some(n)) = (r["quest"].as_u64(), r["objective"].as_u64()) {
			let (now, ch) = write_objective(lines, &found, q as u32, n as u32, data);
			found = now;
			changed = ch;
		}
	}
	if let (Some(label), Some(q), Some(n)) = (r["label"].as_str(), r["quest"].as_u64(), r["objective"].as_u64()) {
		for &i in &found {
			if !objective_line(&lines[i], q as u32, n as u32) {
				continue;
			}
			let new = labelled(&lines[i], label);
			if new != lines[i] {
				lines[i] = new;
				if !changed.contains(&i) {
					changed.push(i);
				}
			}
		}
	}
	let found = &found[..];
	if let Some(at) = at_of(&r["at"]) {
		for &i in found.iter().rev() {
			let step = step_of(lines, i);
			// The step leads the arrow with a goto right before the goal: that goto is the place.
			let target = match step.and_then(|s| prev_goal(lines, s, i)) {
				Some(p) if typed_point(&lines[i]).is_none() && re!(r"^\s+goto\s").is_match(&lines[p]) => p,
				_ => i,
			};
			// (Redundant only with the record's map typed too: the same numbers on the step's zone map
			// are another place, Narm Faulk's 78.32,58.09 read in Ironforge's Tinker Town, #303.)
			if typed_point(&lines[target]).is_some_and(|p| close(p, (at.x, at.y))) && typed_map(&lines[target]) == Some(at.map) {
				continue;
			}
			lines[target] = placed(&lines[target], &at);
			changed.push(target);
		}
	} else if let Some(path) = r["path"].as_object() {
		let (map, frame) = (path.get("map").and_then(Value::as_u64).unwrap_or(0), path.get("frame").and_then(Value::as_str).unwrap_or("era"));
		let pts: Vec<(f64, f64)> = path.get("points").and_then(Value::as_array).into_iter().flatten().filter_map(|p| Some((p[0].as_f64()?, p[1].as_f64()?))).collect();
		let indent = |l: &str| l[..l.len() - l.trim_start().len()].to_string();
		for &i in found.iter().rev() {
			// The loop of gotos right before the goal, if any (replaced), and the goal without its own point.
			let Some(step) = step_of(lines, i) else { continue };
			let mut from = i;
			while from > step.0 + 1 && re!(r"^\s+goto\s").is_match(&lines[from - 1]) {
				from -= 1;
			}
			if from > step.0 + 1 && re!(r"^\s+loop\s*$").is_match(&lines[from - 1]) {
				from -= 1;
			}
			let ind = indent(&lines[i]);
			let mut block = vec![format!("{ind}loop")];
			block.extend(pts.iter().map(|&(x, y)| format!("{ind}goto {},{} map {map} {frame}", num(x), num(y))));
			let old: Vec<(f64, f64)> = lines[from..i].iter().filter_map(|l| typed_point(l)).collect();
			let same = old.len() == pts.len() && old.iter().zip(&pts).all(|(a, b)| close(*a, *b)) && typed_point(&lines[i]).is_none();
			if same {
				continue;
			}
			let (code, rest) = split_comment(&lines[i]);
			let goal = format!("{}{rest}", trim_end(&strip_place(code)));
			let n = block.len();
			lines.splice(from..=i, block.into_iter().chain(std::iter::once(goal)));
			changed.push(from + n);
		}
	}
	changed
}

/// Whether the step `s` is an `along` step.
fn along_step(lines: &[String], s: (usize, usize)) -> bool {
	(s.0 + 1..s.1).any(|k| re!(r"^\s+along\b").is_match(&lines[k]))
}

fn apply_fix(lines: &mut Vec<String>, found: &[usize], r: &Value) -> Vec<usize> {
	let mut changed = Vec::new();
	// A tip or gate is for the goal's own step: an along step's copy of it (an `early` take) keeps its
	// own, unless the goal has no other line.
	let own: Vec<usize> = found.iter().copied().filter(|&i| !step_of(lines, i).is_some_and(|s| along_step(lines, s))).collect();
	let found = if own.is_empty() { found } else { &own[..] };
	for &i0 in found.iter().rev() {
		let mut i = i0;
		let Some(mut step) = step_of(lines, i) else { continue };
		let ind = lines[i][..lines[i].len() - lines[i].trim_start().len()].to_string();
		if let Some(tip) = r["tip"].as_str() {
			// (The fix's tip is the step's: it replaces the first, and the step's other tips go, a
			// stale second tip a merged step brought from v1, RevSkyH3 S4.)
			let line = format!("{ind}tip {tip}");
			let tips: Vec<usize> = (step.0 + 1..step.1).filter(|&k| re!(r"^\s+tip\s").is_match(&lines[k])).collect();
			match tips.first() {
				Some(&k) => {
					let extra = &tips[1..];
					if lines[k] != line || !extra.is_empty() {
						// (Marked here, dropped at the end: the found lines' indices hold till then.)
						for &x in extra {
							lines[x] = GONE.to_string();
						}
						lines[k] = line;
						changed.push(k);
					}
				}
				None => {
					// After the title and the step's own `only`/`zone` lines.
					let mut k = step.0 + 1;
					while k < step.1 && re!(r"^\s+(only|zone)\s").is_match(&lines[k]) {
						k += 1;
					}
					lines.insert(k, line);
					changed.push(k);
					// (The anchor and the step's end move down with it: a level gate of the same record.)
					i += 1;
					step.1 += 1;
				}
			}
		}
		// (A `when`: the goal's step shows only from that level, after its title and `only`/`zone`.)
		if let Some(w) = r["when"].as_str() {
			let line = format!("{ind}when {w}");
			if !(step.0 + 1..step.1).any(|k| trim(&lines[k]) == trim(&line)) {
				let mut k = step.0 + 1;
				while k < step.1 && re!(r"^\s+(only|zone|when)\s").is_match(&lines[k]) {
					k += 1;
				}
				lines.insert(k, line);
				changed.push(k);
				i += 1;
				step.1 += 1;
			}
		}
		if let Some(lv) = r["level"].as_u64() {
			let gate = format!("{ind}level {lv}");
			if r["after"] == true {
				// Right after the anchor goal (the hand-ins before it count towards the level).
				let next = (i + 1..step.1).find(|&k| !trim(&lines[k]).is_empty() && !trim(&lines[k]).starts_with('#'));
				if next.is_some_and(|n| trim(split_comment(&lines[n]).0) == trim(&gate)) {
					continue;
				}
				lines.insert(i + 1, gate);
				changed.push(i + 1);
				continue;
			}
			let prev = prev_goal(lines, step, i);
			if prev.is_some_and(|p| trim(split_comment(&lines[p]).0) == trim(&gate)) {
				continue;
			}
			lines.insert(i, gate);
			changed.push(i);
		}
	}
	lines.retain(|l| l != GONE);
	changed
}

/// An `early` guide fix (#798): right after the step holding `early.after` (its last line before the
/// anchor's step), an `along until <label>` step with the record's title, `when` and tip lists the
/// anchor step's lines for the quest (its accept and objectives, without their notes) on the way
/// there; the anchor's step gets `label q<quest>` when it has no label. -> the changed lines.
fn apply_early(lines: &mut Vec<String>, found: &[usize], r: &Value) -> Vec<usize> {
	let e = &r["early"];
	let (Some(q), Some(title)) = (r["at"]["quest"].as_u64(), e["title"].as_str()) else { return Vec::new() };
	let Some(from) = fix_anchor(&serde_json::json!({ "at": e["after"] })) else { return Vec::new() };
	// The quest's own step: its first accept outside an along step (the early step is one).
	let Some((i, step)) = found.iter().filter_map(|&i| step_of(lines, i).map(|s| (i, s))).find(|&(_, s)| !along_step(lines, s)) else { return Vec::new() };
	let Some(astep) = anchor_lines(lines, &from).into_iter().rev().find(|&k| k < step.0).and_then(|a| step_of(lines, a)) else { return Vec::new() };
	let ind = lines[i][..lines[i].len() - lines[i].trim_start().len()].to_string();
	let qs = q.to_string();
	let goals: Vec<String> = (step.0 + 1..step.1)
		.filter_map(|k| {
			let code = split_comment(&lines[k]).0.trim_end().to_string();
			let accept = re!(r"^\s+accept\s+(\d+)(?:\s|$)").captures(&code).is_some_and(|m| m[1] == *qs);
			let work = re!(r"^\s+(?:kill|collect|interact|use)\b.*?\bquest\s+(\d+)(?:\.\d+)?(?:\s|$)").captures(&code).is_some_and(|m| m[1] == *qs);
			(accept || work).then_some(code)
		})
		.collect();
	let label_line = (step.0 + 1..step.1).find(|&k| re!(r"^\s+label\s+\S").is_match(&lines[k]));
	let label = label_line.map_or_else(|| format!("q{q}"), |k| lines[k].trim()["label".len()..].trim().to_string());
	let mut block = vec![format!("step {title}"), format!("{ind}along until {label}")];
	block.extend(e["when"].as_str().map(|w| format!("{ind}when {w}")));
	block.extend(e["tip"].as_str().map(|t| format!("{ind}tip {t}")));
	block.extend(goals);
	let written = lines.windows(block.len()).any(|w| w.iter().zip(&block).all(|(a, b)| a.trim_end() == b));
	if written && label_line.is_some() {
		return Vec::new();
	}
	let mut changed = Vec::new();
	if label_line.is_none() {
		lines.insert(step.0 + 1, format!("{ind}label {label}"));
		changed.push(step.0 + 1);
	}
	if !written {
		// After the step's last line, before the blank and comment lines that close it.
		let mut at = astep.1;
		while at > astep.0 + 1 && (lines[at - 1].trim().is_empty() || lines[at - 1].trim_start().starts_with('#')) {
			at -= 1;
		}
		let n = block.len();
		lines.splice(at..at, std::iter::once(String::new()).chain(block));
		changed.extend(at + 1..at + 1 + n);
	}
	changed
}

/// How near (in map percent) a step's point must lie to a spawn of a background fix's `mobs` for the
/// step to get its `mention` tip.
const MENTION_NEAR: f64 = 2.0;

/// The step's header keys a tip goes after (fixes::apply_background's mention).
fn header_key(line: &str) -> bool {
	re!(r"^\s+(zone|only|when|label|along|background|tip|image|loop|skipto)\b").is_match(line)
}

/// A `background` guide fix (#1135): a zone-wide, slow collection, worked on the way instead of in a
/// step of its own. Between the quest's accept and the step that hands it in (in the same guide), the
/// objective's lines leave the work steps (a step left with no goal goes, unless it carries a label);
/// right after the accept's step an `along until <label>` step marked `background`, with the record's
/// title and tip, lists the objective until that hand-in step (labelled `q<quest>` when it has no
/// label); right before it a finish step with the finish's title and tip leads to its point for
/// whoever is still short (the engine passes it at once when the count is reached); and each step in
/// between with a point within MENTION_NEAR of a spawn of `mobs` on the finish's map gets the tip
/// `mention`. Points without a typed map count on the finish's map unless the step's `zone` names
/// another zone than the guide's. -> the changed lines.
fn apply_background(lines: &mut Vec<String>, r: &Value, data: Option<&Data>) -> Vec<usize> {
	let b = &r["background"];
	let (Some(q), Some(n), Some(title)) = (r["at"]["quest"].as_u64(), r["at"]["objective"].as_u64(), b["title"].as_str()) else { return Vec::new() };
	let (q, n) = (q as u32, n as u32);
	let f = &b["finish"];
	let (Some(ftitle), Some(map), Some(fx), Some(fy)) = (f["title"].as_str(), f["map"].as_u64(), f["x"].as_f64(), f["y"].as_f64()) else { return Vec::new() };
	let qs = q.to_string();
	let is_accept = |l: &String| re!(r"^\s+accept\s+(\d+)(?:\s|$)").captures(split_comment(l).0).is_some_and(|m| m[1] == *qs);
	let is_turnin = |l: &String| re!(r"^\s+turnin\s+(\d+)(?:\s|$)").captures(split_comment(l).0).is_some_and(|m| m[1] == *qs);
	// The step that hands the quest in (the first after its first accept outside an along step), and
	// the last accept's step before it (a race's own lead-in may take the quest earlier).
	let ends = |lines: &[String]| -> Option<((usize, usize), (usize, usize))> {
		let first = (0..lines.len()).filter(|&i| is_accept(&lines[i])).filter_map(|i| step_of(lines, i)).find(|&s| !along_step(lines, s))?;
		let t = (first.1..lines.len()).find(|&i| is_turnin(&lines[i])).and_then(|i| step_of(lines, i))?;
		let a = (first.0..t.0).rev().filter(|&i| is_accept(&lines[i])).filter_map(|i| step_of(lines, i)).find(|&s| !along_step(lines, s))?;
		Some((a, t))
	};
	if ends(lines.as_slice()).is_none() {
		return Vec::new();
	}
	let ind = "  ".to_string();
	// The objective's goal line, from the data (as places' `write`), else from a written line.
	let verb = |k: Option<&str>| match k {
		Some("kill") => Some("kill"),
		Some("object") => Some("interact"),
		Some("item") => Some("collect"),
		_ => None,
	};
	let from_data = data.and_then(|d| d.quests.get(&q)).and_then(|qd| qd.objective(n as usize - 1)).and_then(|o| Some(format!("{} {} quest {q}.{n}", verb(o.kind.as_deref())?, o.id? as u64)));
	let from_line = || lines.iter().find(|l| objective_line(l, q, n)).map(|l| trim(&strip_place(split_comment(l).0)).to_string());
	let Some(goal) = from_data.or_else(from_line) else { return Vec::new() };
	let finish_title = format!("step {ftitle}");
	let mut changed_any = false;
	// 1. The objective's lines leave the work steps between the accept and the hand-in (not the
	//    finish step's, nor along steps').
	loop {
		let Some((a, t)) = ends(lines.as_slice()) else { break };
		let hit = (a.1..t.0).find(|&i| objective_line(&lines[i], q, n) && step_of(lines, i).is_some_and(|s| !along_step(lines, s) && lines[s.0].trim_end() != finish_title));
		let Some(i) = hit else { break };
		let s = step_of(lines, i).unwrap_or((i, i + 1));
		lines.remove(i);
		changed_any = true;
		let body = &lines[s.0 + 1..s.1 - 1];
		let has_goal = body.iter().any(|l| trim(l).split_whitespace().next().is_some_and(|w| forge_guide::parse::VERBS.contains(&w)));
		if !has_goal && !body.iter().any(|l| re!(r"^\s+label\s").is_match(l)) {
			lines.drain(s.0..s.1 - 1);
		}
	}
	let Some((a, t)) = ends(lines.as_slice()) else { return Vec::new() };
	// 2. The hand-in step's label.
	let label_line = (t.0 + 1..t.1).find(|&k| re!(r"^\s+label\s+\S").is_match(&lines[k]));
	let label = label_line.map_or_else(|| format!("q{q}"), |k| lines[k].trim()["label".len()..].trim().to_string());
	if label_line.is_none() {
		lines.insert(t.0 + 1, format!("{ind}label {label}"));
		changed_any = true;
	}
	// 3. The background step after the accept's step.
	let mut block = vec![format!("step {title}"), format!("{ind}along until {label}"), format!("{ind}background")];
	block.extend(b["tip"].as_str().map(|t| format!("{ind}tip {t}")));
	block.push(format!("{ind}{goal}"));
	let has_block = |lines: &[String], block: &[String]| lines.windows(block.len()).any(|w| w.iter().zip(block).all(|(x, y)| x.trim_end() == y));
	if !has_block(lines.as_slice(), block.as_slice()) {
		let mut at = a.1;
		while at > a.0 + 1 && (lines[at - 1].trim().is_empty() || lines[at - 1].trim_start().starts_with('#')) {
			at -= 1;
		}
		lines.splice(at..at, std::iter::once(String::new()).chain(block));
		changed_any = true;
	}
	// 4. The finish step right before the hand-in step.
	let Some((_, t)) = ends(lines.as_slice()) else { return Vec::new() };
	let mut fblock = vec![finish_title.clone()];
	// (An item objective: the step applies only while the bags hold fewer than the count, so a player
	// who has them never sees it; the condition also keeps the engine's merges off it.)
	let item_count = data.and_then(|d| d.quests.get(&q)).and_then(|qd| qd.objective(n as usize - 1)).filter(|o| o.kind.as_deref() == Some("item")).and_then(|o| Some((o.id? as u64, o.count? as u64)));
	fblock.extend(item_count.map(|(id, c)| format!("{ind}when !has {id} x{c}")));
	fblock.extend(f["tip"].as_str().map(|t| format!("{ind}tip {t}")));
	fblock.push(format!("{ind}{goal} @{},{} map {map} era", num(fx), num(fy)));
	if !has_block(lines.as_slice(), fblock.as_slice()) {
		// Before the blank and comment lines that open the hand-in step.
		let mut at = t.0;
		while at > 0 && (lines[at - 1].trim().is_empty() || lines[at - 1].trim_start().starts_with('#')) {
			at -= 1;
		}
		lines.splice(at..at, std::iter::once(String::new()).chain(fblock));
		changed_any = true;
	}
	// 5. The steps in between whose points lie near the droppers get the mention.
	if let (Some(mention), Some(d)) = (b["mention"].as_str(), data) {
		let spawns: Vec<(f64, f64)> = b["mobs"]
			.as_array()
			.into_iter()
			.flatten()
			.filter_map(|m| d.npcs.get(&(m.as_u64()? as u32)))
			.filter_map(|e| e.spawns.get(&(map as u32)))
			.flat_map(|s| s.pts.iter().filter_map(|p| Some((p.first().copied().flatten()?, p.get(1).copied().flatten()?))))
			.collect();
		let header_zone = lines.iter().find_map(|l| l.strip_prefix("zone ").map(|z| z.trim().to_string()));
		let tip = format!("{ind}tip {mention}");
		let bg_start = (0..lines.len()).find(|&i| lines[i].trim_end() == format!("step {title}"));
		let fin_start = (0..lines.len()).rev().find(|&i| lines[i].trim_end() == finish_title);
		if let (Some(from), Some(to)) = (bg_start, fin_start) {
			let mut k = from + 1;
			let mut to = to;
			while k < to {
				if !is_step(&lines[k]) {
					k += 1;
					continue;
				}
				let Some(s) = step_of(lines, k) else { break };
				let other_zone = (s.0 + 1..s.1).any(|j| re!(r"^\s+zone\s").is_match(&lines[j]) && header_zone.as_deref().is_none_or(|z| trim(&lines[j])["zone".len()..].trim() != z));
				let near = (s.0 + 1..s.1).any(|j| {
					let Some(p) = typed_point(&lines[j]) else { return false };
					let on = match typed_map(&lines[j]) {
						Some(m) => m == map,
						None => !other_zone,
					};
					on && spawns.iter().any(|&(x, y)| (x - p.0).hypot(y - p.1) <= MENTION_NEAR)
				});
				if near && !along_step(lines, s) && !(s.0 + 1..s.1).any(|j| lines[j].trim_end() == tip) {
					let mut at = s.0 + 1;
					while at < s.1 && header_key(&lines[at]) {
						at += 1;
					}
					lines.insert(at, tip.clone());
					changed_any = true;
					to += 1;
				}
				k = s.1;
			}
		}
	}
	if !changed_any {
		return Vec::new();
	}
	// The lines the record now stands on: the background, finish and mention lines.
	(0..lines.len()).filter(|&i| objective_line(&lines[i], q, n) || b["mention"].as_str().is_some_and(|m| lines[i].trim() == format!("tip {m}"))).collect()
}

/// A line apply_fix drops once every found line is done.
const GONE: &str = "\u{0}";

/// The objectives (quest, objective number) guide-fixes.json never lets the engine list on the way
/// (`along: false`), for this start's side.
pub fn no_along(rec: &Records, faction: Option<&str>) -> rustc_hash::FxHashSet<(u32, u32)> {
	rec.guide_fixes
		.and_then(|d| d["fixes"].as_array())
		.into_iter()
		.flatten()
		.filter(|r| r["along"] == serde_json::Value::Bool(false))
		.filter(|r| !r["faction"].as_str().zip(faction).is_some_and(|(a, b)| !a.eq_ignore_ascii_case(b)))
		.filter_map(|r| Some((r["at"]["quest"].as_u64()? as u32, r["at"]["objective"].as_u64()? as u32)))
		.collect()
}

/// Objective lines follow the data's objectives (#859): the game's own objective list makes the
/// data's talk credits `talk` objectives and drops those the game does not count (forge-data
/// recordings::game_objectives), and a guide line written before says otherwise. A `kill <npc>
/// quest Q.N` whose objective N is a `talk` on that NPC becomes `talk <npc> quest Q.N` (a `"Talk to
/// …"` text it carried goes: a talk reads so itself; any other text stays); a `kill` or `talk` line
/// of an objective past the quest's last, on an NPC none of its objectives has, goes, and so does a
/// step it leaves without a goal (one with a `label` stays: another step may name it). -> whether a
/// line changed.
fn follow_objectives(lines: &mut Vec<String>, data: &Data) -> bool {
	let mut changed = false;
	let mut i = 0;
	while i < lines.len() {
		let (code, rest) = split_comment(&lines[i]);
		let Some(m) = re!(r"^(\s+)(kill|talk)\s+(\d+)\b").captures(code) else {
			i += 1;
			continue;
		};
		let Some(qm) = re!(r"\bquest\s+(\d+)\.(\d+)(?:\s|$)").captures(code) else {
			i += 1;
			continue;
		};
		let (verb, npc) = (m[2].to_string(), m[3].parse::<f64>().unwrap_or(f64::NAN));
		let (Ok(q), Ok(n)) = (qm[1].parse::<u32>(), qm[2].parse::<usize>()) else {
			i += 1;
			continue;
		};
		let Some(quest) = data.quests.get(&q) else {
			i += 1;
			continue;
		};
		let count = quest.objectives().count();
		if count > 0 && n > count && !quest.objectives().any(|o| o.id == Some(npc)) {
			let step = step_of(lines, i);
			lines.remove(i);
			changed = true;
			if let Some((start, end)) = step.map(|(s, e)| (s, e - 1)) {
				let body = &lines[start + 1..end];
				let goal = |l: &String| trim(l).split_whitespace().next().is_some_and(|w| forge_guide::parse::VERBS.contains(&w));
				if !body.iter().any(goal) && !body.iter().any(|l| re!(r"^\s+label\s").is_match(l)) {
					lines.drain(start..end);
					i = start;
				}
			}
			continue;
		}
		let want = match quest.objective(n.wrapping_sub(1)) {
			Some(o) if o.id == Some(npc) && o.kind.as_deref() == Some("talk") => "talk",
			_ => verb.as_str(),
		};
		if want != verb {
			let mut code = format!("{}{want}{}", &m[1], &code[m[2].len() + m[1].len()..]);
			if want == "talk" {
				code = re!(r#"\s+"Talk to [^"]*""#).replace(&code, "").into_owned();
			}
			lines[i] = format!("{code}{rest}");
			changed = true;
		}
		i += 1;
	}
	changed
}

/// Applies the records to `files` of `tree` (the guides the route was written into); `quests`: the
/// route's quests (a record for another quest is not for this start).
pub fn apply(tree: &mut BTreeMap<String, String>, files: &[String], quests: &HashSet<u32>, faction: Option<&str>, rec: Records, data: Option<&Data>) -> Vec<FixRow> {
	struct Rec<'a> {
		file: &'static str,
		r: &'a Value,
		anchor: Option<Anchor>,
		/// What a conflict compares: the same kind of change on the same anchor.
		slot: String,
		want: String,
	}
	if let Some(d) = data {
		for f in files {
			let Some(text) = tree.get(f) else { continue };
			let mut lines: Vec<String> = text.split('\n').map(str::to_string).collect();
			if follow_objectives(&mut lines, d) {
				tree.insert(f.clone(), lines.join("\n"));
			}
		}
	}
	let mut recs: Vec<Rec> = Vec::new();
	for r in rec.places.and_then(|d| d["places"].as_array()).into_iter().flatten() {
		let anchor = place_anchor(r);
		recs.push(Rec { file: "places", r, slot: format!("{anchor:?}"), want: format!("{}{}{}{}", r["at"], r["path"], r["write"], r["label"]), anchor });
	}
	for r in rec.guide_fixes.and_then(|d| d["fixes"].as_array()).into_iter().flatten() {
		let anchor = fix_anchor(r);
		let kind = if r.get("background").is_some() {
			"background"
		} else if r.get("early").is_some() {
			"early"
		} else if r.get("tip").is_some() {
			"tip"
		} else if r.get("along").is_some() {
			"along"
		} else if r.get("when").is_some() {
			"when"
		} else {
			"level"
		};
		recs.push(Rec { file: "guide-fixes", r, slot: format!("{anchor:?} {kind}"), want: format!("{}{}{}{}{}{}", r["tip"], r["level"], r["along"], r["early"], r["when"], r["background"]), anchor });
	}
	// Background records last: their mention tips join the tips the other records set (a tip record
	// replaces every tip of its step).
	recs.sort_by_key(|x| x.r.get("background").is_some());
	let mut rows = Vec::new();
	for (k, x) in recs.iter().enumerate() {
		let id = x.r["id"].as_str().unwrap_or("").to_string();
		let mut row = FixRow { file: x.file.into(), id, state: String::new(), detail: String::new(), issues: issues_of(x.r), lines: Vec::new() };
		let Some(anchor) = &x.anchor else {
			row.state = "stale".into();
			row.detail = "no anchor (check-corrections names the error)".into();
			rows.push(row);
			continue;
		};
		let other_side = |r: &Value| r["faction"].as_str().zip(faction).is_some_and(|(a, b)| !a.eq_ignore_ascii_case(b));
		if other_side(x.r) {
			row.state = "not for this start".into();
			row.detail = format!("for the {} only", x.r["faction"].as_str().unwrap_or(""));
			rows.push(row);
			continue;
		}
		if let Some(o) = recs.iter().enumerate().find(|(j, y)| *j != k && y.file == x.file && y.slot == x.slot && y.want != x.want && !other_side(y.r)) {
			row.state = "conflicting".into();
			row.detail = format!("{} also sets {}: neither is applied", o.1.r["id"].as_str().unwrap_or("?"), anchor.describe());
			rows.push(row);
			continue;
		}
		let (mut found_any, mut changed_any) = (false, false);
		for f in files {
			let Some(text) = tree.get(f) else { continue };
			let mut lines: Vec<String> = text.split('\n').map(str::to_string).collect();
			let found = anchor_lines(&lines, anchor);
			if found.is_empty() {
				continue;
			}
			found_any = true;
			// `along: false` changes no line here: the engine reads it (no_along).
			if x.r.get("along").is_some() {
				changed_any = true;
				continue;
			}
			let changed = if x.file == "places" {
				apply_place(&mut lines, &found, x.r, data)
			} else if x.r.get("background").is_some() {
				apply_background(&mut lines, x.r, data)
			} else if x.r.get("early").is_some() {
				apply_early(&mut lines, &found, x.r)
			} else {
				apply_fix(&mut lines, &found, x.r)
			};
			if !changed.is_empty() {
				changed_any = true;
				tree.insert(f.clone(), lines.join("\n"));
			}
		}
		// No line to anchor on: stale when the route takes the quest, else not this start's (a line
		// the written guides keep, a class quest's say, is fixed whether the route counts it or not).
		let in_route = quests.is_empty() || quests.contains(&anchor.quest());
		row.state = if !found_any && !in_route {
			"not for this start"
		} else if !found_any {
			"stale"
		} else if changed_any {
			"applied"
		} else {
			"redundant"
		}
		.into();
		if !found_any && !in_route {
			row.detail = format!("quest {} is not in the route", anchor.quest());
		} else if !found_any {
			row.detail = format!("the written guides have no {} line", anchor.describe());
		} else if !changed_any {
			row.detail = "the written guides already say it".into();
		}
		rows.push(row);
	}
	// The anchor lines as the guides stand after every record (a later record may move them).
	for (row, x) in rows.iter_mut().zip(&recs) {
		let Some(anchor) = x.anchor.as_ref().filter(|_| row.state == "applied" || row.state == "redundant") else { continue };
		for f in files {
			let Some(text) = tree.get(f) else { continue };
			let lines: Vec<String> = text.split('\n').map(str::to_string).collect();
			row.lines.extend(anchor_lines(&lines, anchor).iter().map(|i| format!("{f}:{}", i + 1)));
		}
	}
	rows
}

#[cfg(test)]
mod tests {
	use super::*;
	use serde_json::json;

	fn run(text: &str, places: Value, fixes: Value, quests: &[u32]) -> (String, Vec<FixRow>) {
		run_on(text, places, fixes, quests, json!([{ "type": "kill", "id": 251903 }, { "type": "kill", "id": 254089 }]))
	}

	/// `run` with quest 93461's data objectives `objectives`.
	fn run_on(text: &str, places: Value, fixes: Value, quests: &[u32], objectives: Value) -> (String, Vec<FixRow>) {
		let mut tree = BTreeMap::from([("forever/a.guide".to_string(), text.to_string())]);
		let quest: crate::input::Quest = serde_json::from_value(json!({ "objectives": objectives })).unwrap();
		let data = Data { quests: BTreeMap::from([(93461, quest)]), ..Default::default() };
		let rows = apply(&mut tree, &["forever/a.guide".into()], &quests.iter().copied().collect(), Some("Horde"), Records { places: Some(&places), guide_fixes: Some(&fixes) }, Some(&data));
		(tree["forever/a.guide"].clone(), rows)
	}

	const SEED: &str = "guide forever/a\nzone Azshara\n\nstep Magus Rimtori's camp\n  accept 3505\n  complete 3505\n  turnin 3505                 -- Magus\n\nstep Injured Deathguard\n  only Paladin\n  tip Old tip.\n  goto 31.8,63.9 \"Injured Deathguard\"\n  complete 90902\n\nstep Gordo\n  collect 286202 quest 99141.3 npc 10666 @43.1,54.7 -- Ask Gordo for his report\n";

	#[test]
	fn places_put_the_point_on_the_goal_or_its_goto() {
		let places = json!({ "places": [
			{ "id": "646-3505", "quest": 3505, "objective": 1, "at": { "map": 1447, "x": 59.53, "y": 31.47, "frame": "era" }, "issue": 703 },
			{ "id": "672-deathguard", "quest": 90902, "objective": 1, "at": { "map": 1420, "x": 31.6, "y": 65.8, "frame": "era" }, "issue": 672 },
			{ "id": "674-gordo", "quest": 99141, "objective": 3, "path": { "map": 1420, "frame": "era", "points": [[53.8, 53.1], [43.1, 54.7]] }, "issue": 674 },
			{ "id": "elsewhere", "quest": 1, "objective": 1, "at": { "map": 1, "x": 1.0, "y": 1.0 } },
			{ "id": "alliance-only", "quest": 3505, "objective": 1, "faction": "Alliance", "at": { "map": 1447, "x": 1.0, "y": 1.0 } }
		] });
		// 90902 (a class quest) is not in the route, but the written guides keep its step: it is fixed.
		let (out, rows) = run(SEED, places.clone(), json!({}), &[3505, 99141]);
		assert!(out.contains("  complete 3505 @59.53,31.47 map 1447 era\n"), "{out}");
		assert!(out.contains("  goto 31.6,65.8 map 1420 era \"Injured Deathguard\"\n  complete 90902\n"), "{out}");
		assert!(out.contains("  loop\n  goto 53.8,53.1 map 1420 era\n  goto 43.1,54.7 map 1420 era\n  collect 286202 quest 99141.3 npc 10666 -- Ask Gordo for his report"), "{out}");
		let st: Vec<(&str, &str)> = rows.iter().map(|r| (r.id.as_str(), r.state.as_str())).collect();
		assert_eq!(st, [("646-3505", "applied"), ("672-deathguard", "applied"), ("674-gordo", "applied"), ("elsewhere", "not for this start"), ("alliance-only", "not for this start")]);
		// Applied again: nothing left to do.
		let (again, rows) = run(&out, places, json!({}), &[3505, 90902, 99141, 1]);
		assert_eq!(again, out);
		assert_eq!(rows.iter().map(|r| r.state.as_str()).collect::<Vec<_>>(), ["redundant", "redundant", "redundant", "stale", "not for this start"]);
	}

	#[test]
	fn guide_fixes_set_tips_and_gates() {
		let fixes = json!({ "fixes": [
			{ "id": "tip", "at": { "quest": 90902, "goal": "complete" }, "tip": "New tip." },
			{ "id": "gate", "at": { "quest": 3505, "goal": "turnin" }, "level": 52 },
			{ "id": "tip2", "at": { "quest": 3505, "goal": "accept" }, "tip": "Rimtori's camp." }
		] });
		let (out, rows) = run(SEED, json!({}), fixes.clone(), &[]);
		assert!(out.contains("step Injured Deathguard\n  only Paladin\n  tip New tip.\n"), "{out}");
		assert!(out.contains("step Magus Rimtori's camp\n  tip Rimtori's camp.\n  accept 3505\n  complete 3505\n  level 52\n  turnin 3505"), "{out}");
		assert!(rows.iter().all(|r| r.state == "applied"), "{rows:?}");
		let (again, rows) = run(&out, json!({}), fixes, &[]);
		assert_eq!(again, out);
		assert!(rows.iter().all(|r| r.state == "redundant"), "{rows:?}");
	}

	#[test]
	fn a_level_gate_after_its_anchor_lets_the_hand_ins_count() {
		// #617: the grind to 28 for Pilot Longbeard comes after the Menethil hand-ins, in their step.
		let seed = "step Menethil\n  turnin 484\n  turnin 98282                 -- Caitlin\n  vendor nearest\n\nstep Ironforge\n  accept 1179\n";
		let fixes = json!({ "fixes": [
			{ "id": "gate", "at": { "quest": 98282, "goal": "turnin" }, "level": 28, "after": true },
			{ "id": "tip", "at": { "quest": 98282, "goal": "turnin" }, "tip": "Level 28 first." }
		] });
		let (out, rows) = run(seed, json!({}), fixes.clone(), &[]);
		assert_eq!(out, "step Menethil\n  tip Level 28 first.\n  turnin 484\n  turnin 98282                 -- Caitlin\n  level 28\n  vendor nearest\n\nstep Ironforge\n  accept 1179\n");
		assert!(rows.iter().all(|r| r.state == "applied"), "{rows:?}");
		let (again, rows) = run(&out, json!({}), fixes, &[]);
		assert_eq!(again, out);
		assert!(rows.iter().all(|r| r.state == "redundant"), "{rows:?}");
	}

	#[test]
	fn a_when_fix_shows_the_goals_step_only_from_its_level() {
		// #977: the Rogues' Venture Co. tower (Mission: Possible But Not Probable, drones 25 and Gallywix
		// a 23 elite) at the route's 20.3: shown from 23; the class guide Poisons (Horde) holds it before.
		let seed = "step Mission: Possible But Not Probable\n  only Rogue\n  zone The Barrens\n  collect 8072 quest 2478.5 optional\n  kill 7310 quest 2478.1 optional\n";
		let fixes = json!({ "fixes": [{ "id": "977-tower", "at": { "quest": 2478, "goal": "objective", "objective": 1 }, "when": "level>=23" }] });
		let (out, rows) = run(seed, json!({}), fixes.clone(), &[]);
		assert_eq!(out, "step Mission: Possible But Not Probable\n  only Rogue\n  zone The Barrens\n  when level>=23\n  collect 8072 quest 2478.5 optional\n  kill 7310 quest 2478.1 optional\n");
		assert!(rows.iter().all(|r| r.state == "applied"), "{rows:?}");
		let (again, rows) = run(&out, json!({}), fixes, &[]);
		assert_eq!(again, out);
		assert!(rows.iter().all(|r| r.state == "redundant"), "{rows:?}");
	}

	#[test]
	fn a_place_with_the_same_numbers_on_another_map_is_still_applied() {
		// #303: Narm Faulk's 78.32,58.09 is on Dun Morogh's map; typed bare in an Ironforge step it read
		// as Tinker Town, and the record counted as already written.
		let seed = "step The Tome of Divinity\n  zone Ironforge\n  complete 1783 @78.32,58.09 only Paladin -- Narm Faulk\n";
		let places = json!({ "places": [{ "id": "narm", "quest": 1783, "objective": 1, "at": { "map": 1426, "x": 78.32, "y": 58.09, "frame": "era" } }] });
		let (out, rows) = run(seed, places.clone(), json!({}), &[]);
		assert!(out.contains("  complete 1783 only Paladin @78.32,58.09 map 1426 era -- Narm Faulk\n"), "{out}");
		assert_eq!(rows[0].state, "applied");
		let (again, rows) = run(&out, places, json!({}), &[]);
		assert_eq!(again, out);
		assert_eq!(rows[0].state, "redundant");
	}

	#[test]
	fn a_fix_tip_replaces_every_tip_of_its_step() {
		// RevSkyH3 S4: a step merged from two of v1's kept its second (stale) tip beside the fix's.
		let seed = "step Shen'dar\n  tip Old first tip.\n  accept 3505\n  tip Old second tip.\n  complete 3505\n";
		let fixes = json!({ "fixes": [{ "id": "tip", "at": { "quest": 3505, "goal": "complete" }, "tip": "New tip." }] });
		let (out, rows) = run(seed, json!({}), fixes.clone(), &[]);
		assert_eq!(out, "step Shen'dar\n  tip New tip.\n  accept 3505\n  complete 3505\n");
		assert!(rows.iter().all(|r| r.state == "applied"), "{rows:?}");
		let (again, rows) = run(&out, json!({}), fixes, &[]);
		assert_eq!(again, out);
		assert!(rows.iter().all(|r| r.state == "redundant"), "{rows:?}");
	}

	#[test]
	fn an_objective_gets_its_own_line_and_the_bare_complete_goes() {
		let seed = "step Shen'dar\n  accept 93461\n  complete 93461                 -- Speak with both\n  turnin 93461\n";
		let places = json!({ "places": [
			{ "id": "703-a", "quest": 93461, "objective": 1, "write": true },
			{ "id": "703-b", "quest": 93461, "objective": 2, "write": true, "at": { "map": 2521, "x": 43.05, "y": 43.3, "frame": "era" } }
		] });
		let (out, rows) = run(seed, places.clone(), json!({}), &[]);
		assert_eq!(out, "step Shen'dar\n  accept 93461\n  kill 251903 quest 93461.1\n  kill 254089 quest 93461.2 @43.05,43.3 map 2521 era\n  turnin 93461\n");
		assert!(rows.iter().all(|r| r.state == "applied"), "{rows:?}");
		let (again, rows) = run(&out, places, json!({}), &[]);
		assert_eq!(again, out);
		assert!(rows.iter().all(|r| r.state == "redundant"), "{rows:?}");
	}

	#[test]
	fn an_objective_the_game_counts_as_a_talk_gets_a_talk_line() {
		// #859: the data build gives talk credits the type `talk` (forge-data
		// recordings::game_objectives), so a written objective line talks to the NPC.
		let seed = "step Shen'dar\n  accept 93461\n  complete 93461\n  turnin 93461\n";
		let places = json!({ "places": [
			{ "id": "703-a", "quest": 93461, "objective": 1, "write": true },
			{ "id": "703-b", "quest": 93461, "objective": 2, "write": true }
		] });
		let (out, rows) = run_on(seed, places, json!({}), &[], json!([{ "type": "talk", "id": 251903 }, { "type": "talk", "id": 254089 }]));
		assert_eq!(out, "step Shen'dar\n  accept 93461\n  talk 251903 quest 93461.1\n  talk 254089 quest 93461.2\n  turnin 93461\n");
		assert!(rows.iter().all(|r| r.state == "applied"), "{rows:?}");
	}

	#[test]
	fn kill_lines_of_talk_objectives_become_talks_and_lines_the_game_does_not_count_go() {
		// #859: lines written before the data knew (a kill labelled "Talk to", one with its own
		// text) follow the data's talks; a kill line past the quest's last objective (a credit the
		// game never counts, The Cult of the Damned's Darkhounds) goes.
		let seed = "step Shen'dar\n  accept 93461\n  kill 251903 quest 93461.1 \"Talk to Rathiril Sunlance\" -- Upstairs\n  kill 254089 quest 93461.2 \"Tell her you're ready\" @43.05,43.3 map 2521 live\n  kill 1547 quest 93461.3           -- Darkhounds\n  turnin 93461\n";
		let (out, rows) = run_on(seed, json!({}), json!({}), &[], json!([{ "type": "talk", "id": 251903 }, { "type": "talk", "id": 254089 }]));
		assert_eq!(out, "step Shen'dar\n  accept 93461\n  talk 251903 quest 93461.1 -- Upstairs\n  talk 254089 quest 93461.2 \"Tell her you're ready\" @43.05,43.3 map 2521 live\n  turnin 93461\n");
		assert!(rows.is_empty(), "{rows:?}");
		// Kill objectives keep their kill lines.
		let kills = "step Shen'dar\n  kill 251903 quest 93461.1\n  kill 254089 quest 93461.2\n";
		assert_eq!(run(kills, json!({}), json!({}), &[]).0, kills);
		// An along step left with no goal goes; one with a label stays.
		let along = "step Hadric\n  accept 93461\n\nstep Darkhounds on the way\n  along until q1\n  kill 1547 quest 93461.3\n\nstep Farm\n  label q1\n  kill 1547 quest 93461.3 @68.4,57.8 map 1420\n\nstep Back\n  turnin 93461\n";
		let (out, _) = run_on(along, json!({}), json!({}), &[], json!([{ "type": "kill", "id": 267006 }, { "type": "kill", "id": 275437 }]));
		assert_eq!(out, "step Hadric\n  accept 93461\n\nstep Farm\n  label q1\n\nstep Back\n  turnin 93461\n");
	}

	#[test]
	fn a_written_talk_goes_in_the_objectives_order() {
		// #859, Desperate Times: the step had Valennia's and Elaadrin's lines; Ayessa's, written for
		// her place, goes between them (the game reveals Elaadrin's only after hers), and with every
		// objective on a line the bare complete goes.
		let seed = "step Desperate Times\n  kill 252383 quest 93461.1           -- Upstairs\n  kill 252475 quest 93461.3\n  complete 93461 @59.15,79.73 map 2521 live -- Rally them\n  turnin 93461\n";
		let places = json!({ "places": [
			{ "id": "859-ayessa", "quest": 93461, "objective": 2, "write": true, "at": { "map": 2521, "x": 59.15, "y": 79.73, "frame": "live" } }
		] });
		let talks = json!([{ "type": "talk", "id": 252383 }, { "type": "talk", "id": 251968 }, { "type": "talk", "id": 252475 }]);
		let (out, rows) = run_on(seed, places, json!({}), &[], talks);
		assert_eq!(
			out,
			"step Desperate Times\n  talk 252383 quest 93461.1           -- Upstairs\n  talk 251968 quest 93461.2 @59.15,79.73 map 2521 live\n  talk 252475 quest 93461.3\n  turnin 93461\n"
		);
		assert!(rows.iter().all(|r| r.state == "applied"), "{rows:?}");
	}

	#[test]
	fn a_talk_objective_the_data_counts_as_a_kill_reads_talk_to() {
		// Visur's report (#802): Welcome to Shen'dar Village's "Speak with" objectives were written as
		// bare kills ("Kill Coriella Calmbreeze"); the label goes on the written line, before its point.
		let seed = "step Shen'dar\n  accept 93461\n  complete 93461                 -- Speak with both\n  turnin 93461\n";
		let places = json!({ "places": [
			{ "id": "703-a", "quest": 93461, "objective": 1, "write": true, "label": "Talk to Rathiril Sunlance" },
			{ "id": "703-b", "quest": 93461, "objective": 2, "write": true, "label": "Talk to Coriella Calmbreeze", "at": { "map": 2521, "x": 43.05, "y": 43.3, "frame": "live" } }
		] });
		let (out, rows) = run(seed, places.clone(), json!({}), &[]);
		assert_eq!(out, "step Shen'dar\n  accept 93461\n  kill 251903 quest 93461.1 \"Talk to Rathiril Sunlance\"\n  kill 254089 quest 93461.2 \"Talk to Coriella Calmbreeze\" @43.05,43.3 map 2521 live\n  turnin 93461\n");
		assert!(rows.iter().all(|r| r.state == "applied"), "{rows:?}");
		let (again, rows) = run(&out, places.clone(), json!({}), &[]);
		assert_eq!(again, out);
		assert!(rows.iter().all(|r| r.state == "redundant"), "{rows:?}");
		// A guide written before the label: the label joins the line; a different label is replaced.
		let old = "step Shen'dar\n  kill 251903 quest 93461.1           -- Rathiril\n  kill 254089 quest 93461.2 \"Coriella\" @43.05,43.3 map 2521 live\n";
		let (out, _) = run(old, places, json!({}), &[]);
		assert_eq!(
			out,
			"step Shen'dar\n  kill 251903 quest 93461.1 \"Talk to Rathiril Sunlance\"           -- Rathiril\n  kill 254089 quest 93461.2 \"Talk to Coriella Calmbreeze\" @43.05,43.3 map 2521 live\n"
		);
	}

	#[test]
	fn two_records_on_one_anchor_conflict() {
		let places = json!({ "places": [
			{ "id": "a", "quest": 3505, "objective": 1, "at": { "map": 1447, "x": 59.53, "y": 31.47 } },
			{ "id": "b", "quest": 3505, "objective": 1, "at": { "map": 1447, "x": 60.0, "y": 30.0 } }
		] });
		let (out, rows) = run(SEED, places, json!({}), &[]);
		assert_eq!(out, SEED);
		assert!(rows.iter().all(|r| r.state == "conflicting"), "{rows:?}");
	}

	#[test]
	fn an_early_take_lists_the_quest_on_the_way_to_its_own_step() {
		// petllama (#798): a level 5 player walks past Gordo from Calvin to Brill; the route meets him
		// later. An along step after Calvin's lists Gordo's Task until its own step, for level 5 and up.
		let seed = "step Calvin Montague\n  accept 8\n\nstep Brill\n  turnin 8\n\n# ---- Brill\n\nstep Gordo\n  tip Gordo walks the road.\n  accept 5481\n  collect 12737 quest 5481.1          -- Gloom Weed\n\nstep Brill\n  turnin 5481\n";
		let fixes = json!({ "fixes": [
			{ "id": "674-gordo-tip", "at": { "quest": 5481, "goal": "accept" }, "tip": "Gordo walks the road." },
			{ "id": "798", "at": { "quest": 5481, "goal": "accept" }, "early": { "after": { "quest": 8, "goal": "accept" }, "title": "Gordo on the road to Brill", "when": "level>=5", "tip": "Take Gordo's Task if you pass him." } }
		] });
		let (out, rows) = run(seed, json!({}), fixes.clone(), &[]);
		assert_eq!(
			out,
			"step Calvin Montague\n  accept 8\n\nstep Gordo on the road to Brill\n  along until q5481\n  when level>=5\n  tip Take Gordo's Task if you pass him.\n  accept 5481\n  collect 12737 quest 5481.1\n\nstep Brill\n  turnin 8\n\n# ---- Brill\n\nstep Gordo\n  label q5481\n  tip Gordo walks the road.\n  accept 5481\n  collect 12737 quest 5481.1          -- Gloom Weed\n\nstep Brill\n  turnin 5481\n"
		);
		let st: Vec<(&str, &str)> = rows.iter().map(|r| (r.id.as_str(), r.state.as_str())).collect();
		assert_eq!(st, [("674-gordo-tip", "redundant"), ("798", "applied")]);
		let (again, rows) = run(&out, json!({}), fixes, &[]);
		assert_eq!(again, out, "applied again: nothing left to do, the early step's own tip kept");
		assert!(rows.iter().all(|r| r.state == "redundant"), "{rows:?}");
	}

	#[test]
	fn along_false_is_applied_and_listed_for_the_engine() {
		let fixes = json!({ "fixes": [
			{ "id": "621-oats", "at": { "quest": 99141, "goal": "objective", "objective": 3 }, "along": false, "issue": 621 },
			{ "id": "other-side", "at": { "quest": 3505, "goal": "objective", "objective": 1 }, "along": false, "faction": "Alliance" }
		] });
		let (out, rows) = run(SEED, json!({}), fixes.clone(), &[3505, 99141]);
		assert_eq!(out, SEED, "no line changes");
		let st: Vec<(&str, &str)> = rows.iter().map(|r| (r.id.as_str(), r.state.as_str())).collect();
		assert_eq!(st, vec![("621-oats", "applied"), ("other-side", "not for this start")]);
		let recs = Records { places: None, guide_fixes: Some(&fixes) };
		assert_eq!(no_along(&recs, Some("Horde")).into_iter().collect::<Vec<_>>(), vec![(99141, 3)]);
	}

	#[test]
	fn a_background_objective_is_listed_on_the_way_to_its_hand_in_with_a_finish_step_before_it() {
		// #1135: the Plainstrider Beaks (about one in four plainstriders, ~27 kills, plainstriders all over
		// the Barrens) were a step of their own; they are worked on the way until the hand-in, with a
		// finish step for whoever is still short and a word in the steps that pass plainstriders.
		let seed = "guide forever/a\nzone The Barrens\n\nstep The Crossroads\n  accept 844\n  accept 869\n\nstep Raptors\n  tip Raptors.\n  collect 5062 quest 869.1\n  collect 5087 quest 844.1 @53.0,23.7\n\nstep Razormane camp\n  goto 55.0,26.0 \"Razormane camp\"\n  kill 3267 quest 871.1\n\nstep The Crossroads\n  turnin 844\n  accept 845\n";
		let fixes = json!({ "fixes": [{ "id": "1135-beaks", "at": { "quest": 844, "goal": "objective", "objective": 1 }, "background": {
			"title": "Plainstrider Beaks as you go", "tip": "Plainstriders roam the whole Barrens.", "mobs": [3244], "mention": "Plainstriders here count for the beaks.",
			"finish": { "title": "Finish the beaks", "tip": "Plainstriders north of town.", "map": 1413, "x": 53.4, "y": 26.5 }
		}, "issue": 1135 }] });
		let quest: crate::input::Quest = serde_json::from_value(json!({ "objectives": [{ "type": "item", "id": 5087, "count": 7 }] })).unwrap();
		let strider: crate::input::Entity = serde_json::from_value(json!({ "name": "Greater Plainstrider", "spawns": { "1413": { "pts": [[55.2, 26.5], [80.0, 80.0]] } } })).unwrap();
		let data = Data { quests: BTreeMap::from([(844, quest)]), npcs: BTreeMap::from([(3244, strider)]), ..Default::default() };
		let go = |text: &str| {
			let mut tree = BTreeMap::from([("forever/a.guide".to_string(), text.to_string())]);
			let rows = apply(&mut tree, &["forever/a.guide".into()], &HashSet::new(), Some("Horde"), Records { places: None, guide_fixes: Some(&fixes) }, Some(&data));
			(tree["forever/a.guide"].clone(), rows)
		};
		let (out, rows) = go(seed);
		assert_eq!(
			out,
			"guide forever/a\nzone The Barrens\n\nstep The Crossroads\n  accept 844\n  accept 869\n\nstep Plainstrider Beaks as you go\n  along until q844\n  background\n  tip Plainstriders roam the whole Barrens.\n  collect 5087 quest 844.1\n\nstep Raptors\n  tip Raptors.\n  collect 5062 quest 869.1\n\nstep Razormane camp\n  tip Plainstriders here count for the beaks.\n  goto 55.0,26.0 \"Razormane camp\"\n  kill 3267 quest 871.1\n\nstep Finish the beaks\n  when !has 5087 x7\n  tip Plainstriders north of town.\n  collect 5087 quest 844.1 @53.4,26.5 map 1413 era\n\nstep The Crossroads\n  label q844\n  turnin 844\n  accept 845\n"
		);
		assert_eq!(rows.iter().map(|r| r.state.as_str()).collect::<Vec<_>>(), ["applied"]);
		let (again, rows) = go(&out);
		assert_eq!(again, out, "applied again: nothing left to do");
		assert_eq!(rows.iter().map(|r| r.state.as_str()).collect::<Vec<_>>(), ["redundant"]);
	}
}
