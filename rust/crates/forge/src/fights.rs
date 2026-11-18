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
//! **The fit** is in log seconds, in two steps. Players choose their fights: a strong character
//! goes for mobs above it and for elites, a weak one does not. Set against each other, the hard
//! mobs then look fast because strong players fought them. So mob level and rank are measured
//! inside one player's kills at one level, and only level and class across players.
//!
//! 1. *Mob level and rank.* The normal cells of one (player, class, level) are a group, and
//!    ln(cell) = S[group] + G[gap] with G[0] = 0, over the groups with two or more mob levels:
//!    S is taken out group by group, which leaves a small linear system in G, solved exactly.
//!    G is how much longer the same character at the same level takes on a mob that many levels
//!    away. A mob level no chain of groups ties to even-level mobs has no G. E is the weighted
//!    mean, over the elite cells, of ln(cell) − G[gap] less the same group's normal cells' mean of
//!    the same; an elite cell without one is left out of E.
//! 2. *Level and class.* ln(cell) − G[gap] − E·elite = A[level] + C[class], by backfitting (each
//!    term in turn the weighted mean of what the other leaves), the classes' C centred on 0. Only
//!    a cell with its G, and for an elite cell an E, can be in it: a cell at a mob level without
//!    a G is in no level or class, and neither is any elite cell when no elite cell gave an E. An
//!    elite cell that was left out of E is in it, with the E of the others taken out. The report
//!    counts the cells this step used (`cellsUsed`) beside all of them (`cells`).
//!
//! From it:
//! - `classFactor`: exp(C), each class against the geometric mean of the classes recorded;
//! - `killUp`, `killDown`: the slope through 0 of exp(G) − 1 over the levels above, and of
//!   1 − exp(G) over the levels below;
//! - `eliteTime`: exp(E);
//! - `killSec1`, `killSec60`: the weighted line through exp(A) by level, as calibrate.rs fits its
//!   own (these are without the walk, so they read lower than calibrate's).
//!
//! A term with nothing recorded for it (no elite kills, no mobs above the character, one level)
//! is absent from the report.
//!
//! What step 1 does not take out: one player's own choice from fight to fight (the mob above
//! that happens to be a weak kind, the elite fought with cooldowns up), and the window (a fight
//! that with the rest after it takes over [`GAP_MAX`] seconds is no sample). `killUp` and
//! `eliteTime` are still the fights players took, not the fights a route would send them to.
//!
//! **Every player against every other.** The report also gives `killUp`, `killDown` and
//! `eliteTime` as one additive fit over every cell reads them, ln(cell) = A[level] + G[gap] +
//! C[class] + E·elite ([`AllPlayers`]). That is how far the choice of fights between players moves
//! the three terms: where the two readings agree, it is not what makes a term read low.

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
	/// Samples of the cells set against another mob level of the same player and level.
	pub samples: usize,
}

#[derive(Clone, Debug, PartialEq)]
pub struct LevelFit {
	pub level: i64,
	/// exp(A): seconds on an even-level normal mob for the classes' geometric mean.
	pub sec: f64,
	pub samples: usize,
}

/// `killUp`, `killDown` and `eliteTime` with every player set against every other: the fit before mob
/// level and rank were measured inside one player's kills. Reported beside those, so one run shows how
/// far apart the two are.
#[derive(Clone, Debug, Default, PartialEq)]
pub struct AllPlayers {
	pub kill_up: Option<f64>,
	pub kill_down: Option<f64>,
	pub elite_time: Option<f64>,
}

#[derive(Clone, Debug, Default, PartialEq)]
pub struct FightFit {
	pub sessions: usize,
	pub samples: usize,
	pub voters: usize,
	pub cells: usize,
	/// The cells in the level and class fit: `cells` less those at a mob level with no ratio, and
	/// the elite cells when there is no `eliteTime` to take out of them.
	pub cells_used: usize,
	/// The (player, class, level) groups with two or more mob levels: what `killUp` and `killDown` rest on.
	pub groups: usize,
	/// The elite cells set against normal kills of the same player and level: what `eliteTime` rests on.
	pub elite_cells: usize,
	pub kill_sec: Option<(f64, f64)>,
	pub kill_up: Option<f64>,
	pub kill_down: Option<f64>,
	pub elite_time: Option<f64>,
	pub all_players: AllPlayers,
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

struct Cell<'a> {
	/// The player, class and level: the group its mob level and rank are compared in.
	group: (&'a str, &'a str, i64),
	gap: i64,
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

fn idx<T: PartialEq>(v: &mut Vec<T>, x: T) -> usize {
	v.iter().position(|y| *y == x).unwrap_or_else(|| {
		v.push(x);
		v.len() - 1
	})
}

fn find(root: &mut [usize], mut i: usize) -> usize {
	while root[i] != i {
		root[i] = root[root[i]];
		i = root[i];
	}
	i
}

/// The solution of a k × k linear system, each row with its right-hand side as column k (Gaussian
/// elimination with partial pivoting). None when the rows do not fix every unknown.
fn solve(mut m: Vec<Vec<f64>>) -> Option<Vec<f64>> {
	let k = m.len();
	for i in 0..k {
		let p = (i..k).max_by(|&a, &b| m[a][i].abs().total_cmp(&m[b][i].abs()))?;
		if m[p][i].abs() < 1e-12 {
			return None;
		}
		m.swap(i, p);
		let pivot = m[i].clone();
		for (r, row) in m.iter_mut().enumerate() {
			let f = row[i] / pivot[i];
			if r != i && f != 0.0 {
				row.iter_mut().zip(&pivot).skip(i).for_each(|(x, p)| *x -= f * p);
			}
		}
	}
	Some(m.iter().enumerate().map(|(i, row)| row[k] / row[i]).collect())
}

/// ln(cell) = A[level] + G[gap] + C[class] + E·elite over every cell, by backfitting, with G[0] = 0
/// and the classes' C centred on 0: mob level and rank read across players (module docs).
fn all_players(cells: &[Cell]) -> AllPlayers {
	let (mut levels, mut gaps, mut classes): (Vec<i64>, Vec<i64>, Vec<&str>) = (Vec::new(), Vec::new(), Vec::new());
	// Per cell: its level, mob level and class.
	let at: Vec<(usize, usize, usize)> = cells.iter().map(|x| (idx(&mut levels, x.group.2), idx(&mut gaps, x.gap), idx(&mut classes, x.group.1))).collect();
	let Some(g0) = gaps.iter().position(|g| *g == 0) else { return AllPlayers::default() };
	let (mut a, mut g, mut c, mut el) = (vec![0.0; levels.len()], vec![0.0; gaps.len()], vec![0.0; classes.len()], 0.0);
	let has_elite = cells.iter().any(|x| x.elite);
	for _ in 0..500 {
		let before = (a.clone(), g.clone(), c.clone(), el);
		let wmean = |n: usize, key: &dyn Fn(usize) -> usize, rest: &dyn Fn(usize) -> f64| -> Vec<f64> {
			let mut s = vec![(0.0, 0.0); n];
			for (i, x) in cells.iter().enumerate() {
				s[key(i)].0 += x.w * (x.z - rest(i));
				s[key(i)].1 += x.w;
			}
			s.into_iter().map(|(v, w)| if w > 0.0 { v / w } else { 0.0 }).collect()
		};
		let e = |i: usize| if cells[i].elite { el } else { 0.0 };
		a = wmean(levels.len(), &|i| at[i].0, &|i| g[at[i].1] + c[at[i].2] + e(i));
		g = wmean(gaps.len(), &|i| at[i].1, &|i| a[at[i].0] + c[at[i].2] + e(i));
		// G[0] = 0: what the even-level cells leave goes to the levels.
		let shift = g[g0];
		g.iter_mut().for_each(|v| *v -= shift);
		a.iter_mut().for_each(|v| *v += shift);
		c = wmean(classes.len(), &|i| at[i].2, &|i| a[at[i].0] + g[at[i].1] + e(i));
		let mean = c.iter().sum::<f64>() / c.len() as f64;
		c.iter_mut().for_each(|v| *v -= mean);
		a.iter_mut().for_each(|v| *v += mean);
		if has_elite {
			let (v, w) = cells.iter().zip(&at).filter(|(x, _)| x.elite).fold((0.0, 0.0), |(v, w), (x, p)| (v + x.w * (x.z - a[p.0] - g[p.1] - c[p.2]), w + x.w));
			el = v / w;
		}
		let moved = a.iter().zip(&before.0).chain(g.iter().zip(&before.1)).chain(c.iter().zip(&before.2)).map(|(x, y)| (x - y).abs()).fold((el - before.3).abs(), f64::max);
		if moved < 1e-10 {
			break;
		}
	}
	let (mut up, mut down) = (Vec::new(), Vec::new());
	for (i, &d) in gaps.iter().enumerate() {
		let w: f64 = cells.iter().zip(&at).filter(|(_, p)| p.1 == i).map(|(x, _)| x.w).sum();
		if d > 0 {
			up.push((d as f64, g[i].exp() - 1.0, w));
		} else if d < 0 {
			down.push((-d as f64, 1.0 - g[i].exp(), w));
		}
	}
	AllPlayers { kill_up: slope0(&up), kill_down: slope0(&down), elite_time: has_elite.then(|| el.exp()) }
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

	let mut cells = Vec::new();
	for (&(voter, class, level, gap, elite), secs) in &mut by {
		let n = secs.len();
		if n >= CELL_MIN {
			cells.push(Cell { group: (voter, class, level), gap, elite, z: median(secs).ln(), w: n.min(CELL_CAP) as f64, n });
		}
	}
	out.cells = cells.len();
	out.all_players = all_players(&cells);

	// Step 1: mob level, inside one player's normal kills at one level.
	let mut groups: BTreeMap<(&str, &str, i64), Vec<&Cell>> = BTreeMap::new();
	for c in cells.iter().filter(|c| !c.elite) {
		groups.entry(c.group).or_default().push(c);
	}
	let mut gaps: Vec<i64> = cells.iter().filter(|c| !c.elite).map(|c| c.gap).collect();
	gaps.sort_unstable();
	gaps.dedup();
	let gi = |gap: i64| gaps.binary_search(&gap).ok();
	let Some(g0) = gi(0) else { return out };
	// The mob levels a chain of groups ties to even-level mobs.
	let mut root: Vec<usize> = (0..gaps.len()).collect();
	for members in groups.values().filter(|m| m.len() >= 2) {
		let first = find(&mut root, gi(members[0].gap).expect("a normal cell's gap"));
		for c in &members[1..] {
			let r = find(&mut root, gi(c.gap).expect("a normal cell's gap"));
			root[r] = first;
		}
	}
	let r0 = find(&mut root, g0);
	let known: Vec<bool> = (0..gaps.len()).map(|i| find(&mut root, i) == r0).collect();
	let compared: Vec<&Vec<&Cell>> = groups.values().filter(|m| m.len() >= 2 && gi(m[0].gap).is_some_and(|i| known[i])).collect();
	out.groups = compared.len();
	// S[group] taken out group by group leaves a linear system in G over the known mob levels but 0.
	let mut col = vec![None; gaps.len()];
	let mut k = 0;
	for i in (0..gaps.len()).filter(|&i| known[i] && i != g0) {
		col[i] = Some(k);
		k += 1;
	}
	let mut m = vec![vec![0.0; k + 1]; k];
	// Per mob level: the weight and samples of the cells that were set against another mob level.
	let mut gap_n = vec![(0.0, 0usize); gaps.len()];
	for members in &compared {
		let wsum: f64 = members.iter().map(|c| c.w).sum();
		let zbar = members.iter().map(|c| c.w * c.z).sum::<f64>() / wsum;
		for a in members.iter() {
			let ia = gi(a.gap).expect("a normal cell's gap");
			gap_n[ia].0 += a.w;
			gap_n[ia].1 += a.n;
			let Some(ra) = col[ia] else { continue };
			m[ra][k] += a.w * (a.z - zbar);
			m[ra][ra] += a.w;
			for b in members.iter() {
				if let Some(cb) = gi(b.gap).and_then(|i| col[i]) {
					m[ra][cb] -= a.w * b.w / wsum;
				}
			}
		}
	}
	let Some(sol) = solve(m) else { return out };
	// G by mob level: 0 for even-level mobs, None where nothing ties the level to them.
	let g = |gap: i64| -> Option<f64> {
		let i = gi(gap).filter(|&i| known[i])?;
		Some(col[i].map_or(0.0, |c| sol[c]))
	};

	// The rank: an elite cell against its own group's normal cells.
	let (mut ev, mut ew) = (0.0, 0.0);
	for c in cells.iter().filter(|c| c.elite) {
		let (Some(ge), Some(members)) = (g(c.gap), groups.get(&c.group)) else { continue };
		let (sv, sw) = members.iter().filter_map(|n| g(n.gap).map(|gn| (n.w * (n.z - gn), n.w))).fold((0.0, 0.0), |(v, w), (x, y)| (v + x, w + y));
		if sw > 0.0 {
			// The weight of a difference of two means: the smaller side counts.
			let w = c.w * sw / (c.w + sw);
			ev += w * (c.z - ge - sv / sw);
			ew += w;
			out.elite_cells += 1;
		}
	}
	let el = (ew > 0.0).then(|| ev / ew);

	// Step 2: level and class, across players, from what step 1 leaves of each cell.
	struct Rest<'a> {
		voter: &'a str,
		class: usize,
		level: usize,
		r: f64,
		w: f64,
		n: usize,
	}
	let (mut classes, mut levels): (Vec<&str>, Vec<i64>) = (Vec::new(), Vec::new());
	let mut rest = Vec::new();
	for c in &cells {
		let (Some(gc), Some(e)) = (g(c.gap), if c.elite { el } else { Some(0.0) }) else { continue };
		rest.push(Rest { voter: c.group.0, class: idx(&mut classes, c.group.1), level: idx(&mut levels, c.group.2), r: c.z - gc - e, w: c.w, n: c.n });
	}
	if rest.is_empty() {
		return out;
	}
	out.cells_used = rest.len();
	let (mut a, mut c) = (vec![0.0; levels.len()], vec![0.0; classes.len()]);
	for _ in 0..500 {
		let before = (a.clone(), c.clone());
		let wmean = |n: usize, key: &dyn Fn(&Rest) -> usize, other: &dyn Fn(&Rest) -> f64| -> Vec<f64> {
			let mut s = vec![(0.0, 0.0); n];
			for x in &rest {
				let k = key(x);
				s[k].0 += x.w * (x.r - other(x));
				s[k].1 += x.w;
			}
			s.into_iter().map(|(v, w)| if w > 0.0 { v / w } else { 0.0 }).collect()
		};
		a = wmean(levels.len(), &|x| x.level, &|x| c[x.class]);
		c = wmean(classes.len(), &|x| x.class, &|x| a[x.level]);
		// The classes centred on 0: their mean goes to the levels.
		let mean = c.iter().sum::<f64>() / c.len() as f64;
		c.iter_mut().for_each(|v| *v -= mean);
		a.iter_mut().for_each(|v| *v += mean);
		let moved = a.iter().zip(&before.0).chain(c.iter().zip(&before.1)).map(|(x, y)| (x - y).abs()).fold(0.0, f64::max);
		if moved < 1e-10 {
			break;
		}
	}

	for (i, name) in classes.iter().enumerate() {
		let mut players: Vec<&str> = rest.iter().filter(|x| x.class == i).map(|x| x.voter).collect();
		players.sort_unstable();
		players.dedup();
		out.classes.push(ClassFit { class: (*name).to_string(), factor: c[i].exp(), samples: rest.iter().filter(|x| x.class == i).map(|x| x.n).sum(), voters: players.len() });
	}
	out.classes.sort_by(|x, y| x.class.cmp(&y.class));
	let (mut up, mut down) = (Vec::new(), Vec::new());
	for (i, &d) in gaps.iter().enumerate() {
		let Some(gd) = g(d) else { continue };
		out.gaps.push(GapFit { gap: d, ratio: gd.exp(), samples: gap_n[i].1 });
		if d > 0 {
			up.push((d as f64, gd.exp() - 1.0, gap_n[i].0));
		} else if d < 0 {
			down.push((-d as f64, 1.0 - gd.exp(), gap_n[i].0));
		}
	}
	out.kill_up = slope0(&up);
	out.kill_down = slope0(&down);
	out.elite_time = el.map(f64::exp);
	let mut pts = Vec::new();
	for (i, &l) in levels.iter().enumerate() {
		let (w, n) = rest.iter().filter(|x| x.level == i).fold((0.0, 0usize), |(w, n), x| (w + x.w, n + x.n));
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
		"schema": 2,
		"at": at,
		"about": "Kill time with the walk between mobs taken out. Mob level and rank are measured inside one player's kills at one level (groups, eliteCells: how many groups of kills and elite cells that rests on), level and class across players (cellsUsed: how many of the cells are in that fit). allPlayers: killUp, killDown and eliteTime with every player set against every other, as schema 1 fitted them (forge sim fights; rust/crates/forge/src/fights.rs). A report to read against the priors, not a params.json.",
		"sessions": f.sessions,
		"samples": f.samples,
		"voters": f.voters,
		"cells": f.cells,
		"cellsUsed": f.cells_used,
		"groups": f.groups,
		"eliteCells": f.elite_cells,
		"killSec1": term("killSec1", f.kill_sec.map(|k| k.0)),
		"killSec60": term("killSec60", f.kill_sec.map(|k| k.1)),
		"killUp": term("killUp", f.kill_up),
		"killDown": term("killDown", f.kill_down),
		"eliteTime": term("eliteTime", f.elite_time),
		"allPlayers": { "killUp": f.all_players.kill_up.map(round), "killDown": f.all_players.kill_down.map(round), "eliteTime": f.all_players.elite_time.map(round) },
		"classFactor": classes,
		"byGap": f.gaps.iter().map(|g| json!({ "gap": g.gap, "ratio": round(g.ratio), "samples": g.samples })).collect::<Vec<_>>(),
		"byLevel": f.levels.iter().map(|l| json!({ "level": l.level, "sec": round(l.sec), "samples": l.samples })).collect::<Vec<_>>(),
	})
}
