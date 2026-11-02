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
//!   own goal line from the data (`kill`, `interact` or `collect` with `quest Q.N`) before that
//!   `complete`, which goes once every objective has its line. `at` is optional then: the compiler
//!   places a written objective from the data.
//! - **guide-fixes**: step content that is neither data nor route, at a goal's step:
//!   `{ id, at: { quest, goal: "accept" | "turnin" | "complete" | "objective", objective? }, tip }`
//!   sets the step's `tip`; `level: N` puts a `level N` gate right before the anchor goal.
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
		lines.insert(i, format!("{ind}{v} {} quest {q}.{n}", id as u64));
		let complete = i + 1;
		let step = (step.0, step.1 + 1);
		// Every objective with a target has its own line in the step: the bare complete goes.
		let all = quest.objectives().enumerate().filter(|(_, o)| verb(o.kind.as_deref()).is_some() && o.id.is_some()).count() == quest.objectives().count()
			&& (1..=quest.objectives().count() as u32).all(|k| (step.0..step.1).any(|j| objective_line(&lines[j], q, k)));
		if all {
			lines.remove(complete);
		}
		now.push(i);
		changed.push(i);
	}
	(now, changed)
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
	let found = &found[..];
	if let Some(at) = at_of(&r["at"]) {
		for &i in found.iter().rev() {
			let step = step_of(lines, i);
			// The step leads the arrow with a goto right before the goal: that goto is the place.
			let target = match step.and_then(|s| prev_goal(lines, s, i)) {
				Some(p) if typed_point(&lines[i]).is_none() && re!(r"^\s+goto\s").is_match(&lines[p]) => p,
				_ => i,
			};
			if typed_point(&lines[target]).is_some_and(|p| close(p, (at.x, at.y))) {
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

fn apply_fix(lines: &mut Vec<String>, found: &[usize], r: &Value) -> Vec<usize> {
	let mut changed = Vec::new();
	for &i in found.iter().rev() {
		let Some(step) = step_of(lines, i) else { continue };
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
				}
			}
		}
		if let Some(lv) = r["level"].as_u64() {
			let gate = format!("{ind}level {lv}");
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
	let mut recs: Vec<Rec> = Vec::new();
	for r in rec.places.and_then(|d| d["places"].as_array()).into_iter().flatten() {
		let anchor = place_anchor(r);
		recs.push(Rec { file: "places", r, slot: format!("{anchor:?}"), want: format!("{}{}{}", r["at"], r["path"], r["write"]), anchor });
	}
	for r in rec.guide_fixes.and_then(|d| d["fixes"].as_array()).into_iter().flatten() {
		let anchor = fix_anchor(r);
		let kind = if r.get("tip").is_some() {
			"tip"
		} else if r.get("along").is_some() {
			"along"
		} else {
			"level"
		};
		recs.push(Rec { file: "guide-fixes", r, slot: format!("{anchor:?} {kind}"), want: format!("{}{}{}", r["tip"], r["level"], r["along"]), anchor });
	}
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
			let changed = if x.file == "places" { apply_place(&mut lines, &found, x.r, data) } else { apply_fix(&mut lines, &found, x.r) };
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
		let mut tree = BTreeMap::from([("forever/a.guide".to_string(), text.to_string())]);
		let quest: crate::input::Quest = serde_json::from_value(json!({ "objectives": [{ "type": "kill", "id": 251903 }, { "type": "kill", "id": 254089 }] })).unwrap();
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
}
