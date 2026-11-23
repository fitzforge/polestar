//! `forge sim fights`: what recordings say about the kill-time terms `forge sim calibrate` leaves
//! at their priors. calibrate.rs fits `killSec1`/`killSec60` from the seconds between kills, the
//! walk between the mobs included and every class, mob level and rank pooled. This fit takes the
//! walk out and splits the rest by what the model multiplies a kill by (model.md, "Kills"):
//!
//! ```text
//!   t_kill = base(L) * f(M - L) * classFactor [* eliteTime]  +  walk between the mobs
//! ```
//!
//! It writes a report, never params.json: the numbers are for a maintainer to read against the
//! priors before any of them is taken into the model.
//!
//! **A sample** is one kill after another kill of the same session: the seconds between them
//! (over 2 s and at most 180 s, calibrate.rs's window) less the walk from the first kill's place
//! to the second's (straight yards at `runSpeed`), so what is left is the fight and the downtime
//! around it. Left out: a kill in a group, a kill another player tapped, a rare or a boss, a
//! mob more than [`GAP_DOWN`] levels below or [`GAP_UP`] above the character, a pair without both
//! places on one continent, a pair with a death, a flight, a ride or AFK between them, and a
//! pair with under [`MIN_CYCLE`] seconds left after the walk (two mobs fought at once).
//!
//! **Cells.** Samples are pooled per (player, class, level, mob level − level, elite) and a cell
//! counts as its median, at a weight of its samples capped at [`CELL_CAP`], so a player who farms
//! one camp for hours is one cell there. A player is calibrate.rs's: the session's server
//! `cohort`, else its `contributor`, else `local`. Cells of under [`CELL_MIN`] samples are dropped.
//!
//! **The fit** is additive in log seconds: ln(cell) = A[level] + G[gap] + C[class] + E·elite,
//! solved by backfitting (each term in turn the weighted mean of what the others leave), with
//! G[0] = 0 and the classes' C centred on 0. From it:
//! - `classFactor`: exp(C), each class against the geometric mean of the classes recorded;
//! - `killUp`, `killDown`: the slope through 0 of exp(G) − 1 over the levels above, and of
//!   1 − exp(G) over the levels below;
//! - `eliteTime`: exp(E);
//! - `killSec1`, `killSec60`: the weighted line through exp(A) by level, as calibrate.rs fits its
//!   own (these are without the walk, so they read lower than calibrate's).
//!
//! A term with nothing recorded for it (no elite kills, no mobs above the character, one level)
//! is absent from the report.

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

use serde_json::{json, Map, Value};

/// `runSpeed`'s prior (params.rs), yd/s: the walk between two kills is priced at it.
pub const RUN_SPEED: f64 = 7.0;
/// calibrate.rs's window for the seconds between two kills.
pub const GAP_MIN: f64 = 2.0;
pub const GAP_MAX: f64 = 180.0;
/// Seconds that must be left once the walk is taken out.
pub const MIN_CYCLE: f64 = 2.0;
/// Mob levels below and above the character a sample may be.
pub const GAP_DOWN: i64 = 6;
pub const GAP_UP: i64 = 4;
/// A cell needs this many samples, and weighs at most this many.
pub const CELL_MIN: usize = 3;
pub const CELL_CAP: usize = 40;

/// One kill-to-kill sample.
#[derive(Clone, Debug, PartialEq)]
pub struct Sample {
	pub voter: String,
	pub class: String,
	pub level: i64,
	/// Mob level − character level.
	pub gap: i64,
	pub elite: bool,
	/// Seconds between the kills less the walk.
	pub sec: f64,
}

#[derive(Clone, Debug, PartialEq)]
pub struct ClassFit {
	pub class: String,
	pub factor: f64,
	pub samples: usize,
	pub voters: usize,
}

#[derive(Clone, Debug, PartialEq)]
pub struct GapFit {
	pub gap: i64,
	/// exp(G): kill time against an even-level mob.
	pub ratio: f64,
	pub samples: usize,
}

#[derive(Clone, Debug, PartialEq)]
pub struct LevelFit {
	pub level: i64,
	/// exp(A): seconds on an even-level normal mob for the classes' geometric mean.
	pub sec: f64,
	pub samples: usize,
}

#[derive(Clone, Debug, Default, PartialEq)]
pub struct FightFit {
	pub sessions: usize,
	pub samples: usize,
	pub voters: usize,
	pub cells: usize,
	pub kill_sec: Option<(f64, f64)>,
	pub kill_up: Option<f64>,
	pub kill_down: Option<f64>,
	pub elite_time: Option<f64>,
	pub classes: Vec<ClassFit>,
	pub gaps: Vec<GapFit>,
	pub levels: Vec<LevelFit>,
}

fn median(a: &mut [f64]) -> f64 {
	a.sort_by(|x, y| x.total_cmp(y));
	let m = a.len() / 2;
	if a.len() % 2 == 1 {
		a[m]
	} else {
		(a[m - 1] + a[m]) / 2.0
	}
}

/// A map point in world yards with its continent, from the session's own `maps` frames
/// (forge-data build.rs's conversion).
fn world(maps: &Value, e: &Value) -> Option<(i64, f64, f64)> {
	let map = e.get("map").and_then(Value::as_i64)?;
	let (x, y) = (e.get("x").and_then(Value::as_f64)?, e.get("y").and_then(Value::as_f64)?);
	let f = maps.get(map.to_string())?;
	let n = |k: &str| f.get(k).and_then(Value::as_f64);
	let (left, right, top, bottom) = (n("left")?, n("right")?, n("top")?, n("bottom")?);
	Some((f.get("c").and_then(Value::as_i64)?, top + (bottom - top) * y / 100.0, left + (right - left) * x / 100.0))
}

/// The samples of one session document (`forge record import`'s JSON).
pub fn session_samples(doc: &Value) -> Vec<Sample> {
	let Some(events) = doc.get("events").and_then(Value::as_array) else { return Vec::new() };
	let cohort = doc.get("cohort").and_then(Value::as_str).filter(|c| c.len() == 16 && c.bytes().all(|b| b.is_ascii_digit() || (b'a'..=b'f').contains(&b)));
	let voter = match cohort {
		Some(c) => format!("cohort:{c}"),
		None => doc.get("contributor").and_then(Value::as_str).filter(|c| !c.is_empty()).unwrap_or("local").to_string(),
	};
	let Some(class) = doc.get("char").and_then(|c| c.get("class")).and_then(Value::as_str).filter(|c| !c.is_empty()).map(str::to_ascii_uppercase) else { return Vec::new() };
	let maps = doc.get("maps").cloned().unwrap_or(Value::Null);
	let mut out = Vec::new();
	let mut lvl: Option<i64> = None;
	// The last kill: its time and place. None after anything that is no fight or walk.
	let mut last: Option<(f64, Option<(i64, f64, f64)>)> = None;
	for e in events {
		let kind = e.get("e").and_then(Value::as_str).unwrap_or("");
		if let Some(l) = e.get("lvl").and_then(Value::as_i64).filter(|l| *l > 0) {
			lvl = Some(l);
		}
		match kind {
			"death" | "revive" | "taxi" | "land" | "ride" | "enter" => last = None,
			"afk" if e.get("on").and_then(Value::as_bool) == Some(true) => last = None,
			"kill" => {
				let Some(t) = e.get("t").and_then(Value::as_f64) else { continue };
				let at = world(&maps, e);
				let prev = last.replace((t, at));
				let (Some((pt, Some(pa))), Some(a), Some(l)) = (prev, at, lvl) else { continue };
				let gap = t - pt;
				if !(gap > GAP_MIN && gap <= GAP_MAX) || pa.0 != a.0 {
					continue;
				}
				if e.get("group").and_then(Value::as_i64).is_some_and(|g| g > 0) || e.get("denied").and_then(Value::as_bool) == Some(true) {
					continue;
				}
				let elite = match e.get("cls").and_then(Value::as_str) {
					Some("normal") | None => false,
					Some("elite") => true,
					Some(_) => continue,
				};
				let Some(d) = e.get("npcLvl").and_then(Value::as_i64).filter(|m| *m > 0).map(|m| m - l) else { continue };
				if !(-GAP_DOWN..=GAP_UP).contains(&d) {
					continue;
				}
				let sec = gap - (a.1 - pa.1).hypot(a.2 - pa.2) / RUN_SPEED;
				if sec < MIN_CYCLE {
					continue;
				}
				out.push(Sample { voter: voter.clone(), class: class.clone(), level: l, gap: d, elite, sec });
			}
			_ => {}
		}
	}
	out
}

/// Every session in `dir` (`*.json`): its count and samples.
pub fn read_samples(dir: &Path) -> (usize, Vec<Sample>) {
	let Ok(rd) = std::fs::read_dir(dir) else { return (0, Vec::new()) };
	let mut files: Vec<PathBuf> = rd.flatten().map(|e| e.path()).filter(|p| p.to_string_lossy().ends_with(".json")).collect();
	files.sort();
	let (mut sessions, mut out) = (0, Vec::new());
	for f in files {
		let Some(doc) = std::fs::read(&f).ok().and_then(|b| serde_json::from_slice::<Value>(&b).ok()) else { continue };
		if doc.get("events").and_then(Value::as_array).is_none() {
			continue;
		}
		sessions += 1;
		out.extend(session_samples(&doc));
	}
	(sessions, out)
}

struct Cell {
	class: usize,
	level: usize,
	gap: usize,
	elite: bool,
	z: f64,
	w: f64,
	n: usize,
}

/// The slope through 0 of `y` on `x`, weighted.
fn slope0(pts: &[(f64, f64, f64)]) -> Option<f64> {
	let (num, den) = pts.iter().fold((0.0, 0.0), |(n, d), &(x, y, w)| (n + w * x * y, d + w * x * x));
	(den > 0.0).then(|| num / den)
}

/// The fit of `samples` (module docs).
pub fn fit(sessions: usize, samples: &[Sample]) -> FightFit {
	let mut by: BTreeMap<(&str, &str, i64, i64, bool), Vec<f64>> = BTreeMap::new();
	for s in samples {
		by.entry((s.voter.as_str(), s.class.as_str(), s.level, s.gap, s.elite)).or_default().push(s.sec);
	}
	let mut voters: Vec<&str> = samples.iter().map(|s| s.voter.as_str()).collect();
	voters.sort_unstable();
	voters.dedup();
	let mut out = FightFit { sessions, samples: samples.len(), voters: voters.len(), ..FightFit::default() };

	let (mut classes, mut levels, mut gaps): (Vec<&str>, Vec<i64>, Vec<i64>) = (Vec::new(), Vec::new(), Vec::new());
	let idx = |v: &mut Vec<i64>, x: i64| {
		v.iter().position(|y| *y == x).unwrap_or_else(|| {
			v.push(x);
			v.len() - 1
		})
	};
	let mut cells = Vec::new();
	// Per class and per gap: samples kept, and the class's players.
	let mut class_n: Vec<(usize, Vec<&str>)> = Vec::new();
	for (&(voter, class, level, gap, elite), secs) in &mut by {
		if secs.len() < CELL_MIN {
			continue;
		}
		let ci = classes.iter().position(|c| *c == class).unwrap_or_else(|| {
			classes.push(class);
			class_n.push((0, Vec::new()));
			classes.len() - 1
		});
		class_n[ci].0 += secs.len();
		if !class_n[ci].1.contains(&voter) {
			class_n[ci].1.push(voter);
		}
		let n = secs.len();
		cells.push(Cell { class: ci, level: idx(&mut levels, level), gap: idx(&mut gaps, gap), elite, z: median(secs).ln(), w: n.min(CELL_CAP) as f64, n });
	}
	out.cells = cells.len();
	let Some(g0) = gaps.iter().position(|g| *g == 0) else { return out };
	if cells.is_empty() {
		return out;
	}

	let (mut a, mut g, mut c, mut el) = (vec![0.0; levels.len()], vec![0.0; gaps.len()], vec![0.0; classes.len()], 0.0);
	let has_elite = cells.iter().any(|x| x.elite);
	for _ in 0..500 {
		let before = (a.clone(), g.clone(), c.clone(), el);
		let wmean = |n: usize, key: &dyn Fn(&Cell) -> usize, rest: &dyn Fn(&Cell) -> f64| -> Vec<f64> {
			let mut s = vec![(0.0, 0.0); n];
			for x in &cells {
				let k = key(x);
				s[k].0 += x.w * (x.z - rest(x));
				s[k].1 += x.w;
			}
			s.into_iter().map(|(v, w)| if w > 0.0 { v / w } else { 0.0 }).collect()
		};
		let e = |x: &Cell| if x.elite { el } else { 0.0 };
		a = wmean(levels.len(), &|x| x.level, &|x| g[x.gap] + c[x.class] + e(x));
		g = wmean(gaps.len(), &|x| x.gap, &|x| a[x.level] + c[x.class] + e(x));
		// G[0] = 0: what the even-level cells leave goes to the levels.
		let shift = g[g0];
		g.iter_mut().for_each(|v| *v -= shift);
		a.iter_mut().for_each(|v| *v += shift);
		c = wmean(classes.len(), &|x| x.class, &|x| a[x.level] + g[x.gap] + e(x));
		let mean = c.iter().sum::<f64>() / c.len() as f64;
		c.iter_mut().for_each(|v| *v -= mean);
		a.iter_mut().for_each(|v| *v += mean);
		if has_elite {
			let (v, w) = cells.iter().filter(|x| x.elite).fold((0.0, 0.0), |(v, w), x| (v + x.w * (x.z - a[x.level] - g[x.gap] - c[x.class]), w + x.w));
			el = v / w;
		}
		let moved = a.iter().zip(&before.0).chain(g.iter().zip(&before.1)).chain(c.iter().zip(&before.2)).map(|(x, y)| (x - y).abs()).fold((el - before.3).abs(), f64::max);
		if moved < 1e-10 {
			break;
		}
	}

	let weight = |key: &dyn Fn(&Cell) -> bool| cells.iter().filter(|x| key(x)).fold((0.0, 0usize), |(w, n), x| (w + x.w, n + x.n));
	out.classes = classes.iter().enumerate().map(|(i, name)| ClassFit { class: (*name).to_string(), factor: c[i].exp(), samples: class_n[i].0, voters: class_n[i].1.len() }).collect();
	out.classes.sort_by(|x, y| x.class.cmp(&y.class));
	let mut up = Vec::new();
	let mut down = Vec::new();
	for (i, &d) in gaps.iter().enumerate() {
		let (w, n) = weight(&|x| x.gap == i);
		out.gaps.push(GapFit { gap: d, ratio: g[i].exp(), samples: n });
		if d > 0 {
			up.push((d as f64, g[i].exp() - 1.0, w));
		} else if d < 0 {
			down.push((-d as f64, 1.0 - g[i].exp(), w));
		}
	}
	out.gaps.sort_by_key(|x| x.gap);
	out.kill_up = slope0(&up);
	out.kill_down = slope0(&down);
	out.elite_time = has_elite.then(|| el.exp());
	let mut pts = Vec::new();
	for (i, &l) in levels.iter().enumerate() {
		let (w, n) = weight(&|x| x.level == i);
		out.levels.push(LevelFit { level: l, sec: a[i].exp(), samples: n });
		pts.push(((l - 1) as f64, a[i].exp(), w));
	}
	out.levels.sort_by_key(|x| x.level);
	if pts.len() >= 2 {
		// calibrate.rs's weighted line through the levels.
		let (sw, sx, sy, sxx, sxy) = pts.iter().fold((0.0, 0.0, 0.0, 0.0, 0.0), |(sw, sx, sy, sxx, sxy), &(x, s, n)| (sw + n, sx + n * x, sy + n * s, sxx + n * x * x, sxy + n * x * s));
		let den = sw * sxx - sx * sx;
		if den.abs() > 1e-9 {
			let b = (sw * sxy - sx * sy) / den;
			let k1 = (sy - b * sx) / sw;
			out.kill_sec = Some((k1, k1 + 59.0 * b));
		}
	}
	out
}

/// The report: the fit beside the priors it would replace (`class_priors`: params.rs's
/// `CLASS_FACTOR`; `priors`: calibrate.rs's `PRIORS`).
pub fn report(f: &FightFit, at: &str, class_priors: &[(&str, f64)], priors: &[(&str, f64, f64, f64, f64, &str)]) -> Value {
	let round = |x: f64| (x * 1000.0).round() / 1000.0;
	let prior = |n: &str| priors.iter().find(|p| p.0 == n).map(|p| p.1);
	let term = |n: &str, fitted: Option<f64>| json!({ "fitted": fitted.map(round), "prior": prior(n) });
	let mut classes = Map::new();
	for c in &f.classes {
		let p = class_priors.iter().find(|(n, _)| n.eq_ignore_ascii_case(&c.class)).map(|(_, v)| *v);
		classes.insert(c.class.clone(), json!({ "factor": round(c.factor), "prior": p, "samples": c.samples, "voters": c.voters }));
	}
	json!({
		"schema": 1,
		"at": at,
		"about": "Kill time with the walk between mobs taken out, split by level, mob level, class and rank (forge sim fights; rust/crates/forge/src/fights.rs). A report to read against the priors, not a params.json.",
		"sessions": f.sessions,
		"samples": f.samples,
		"voters": f.voters,
		"cells": f.cells,
		"killSec1": term("killSec1", f.kill_sec.map(|k| k.0)),
		"killSec60": term("killSec60", f.kill_sec.map(|k| k.1)),
		"killUp": term("killUp", f.kill_up),
		"killDown": term("killDown", f.kill_down),
		"eliteTime": term("eliteTime", f.elite_time),
		"classFactor": classes,
		"byGap": f.gaps.iter().map(|g| json!({ "gap": g.gap, "ratio": round(g.ratio), "samples": g.samples })).collect::<Vec<_>>(),
		"byLevel": f.levels.iter().map(|l| json!({ "level": l.level, "sec": round(l.sec), "samples": l.samples })).collect::<Vec<_>>(),
	})
}
