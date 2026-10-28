//! The written guides' travel, played by the route's characters (playtest --honest, R1; port of
//! tools/lib/improve/travel-repair.js): no travel line may leave from a place they are not at,
//! and no move of theirs may lack the travel that makes it. Checked on the written guides:
//! after the route's own travel moved them, v1's travel lines of that stretch start elsewhere.
//!
//! Each round plays the route's chain as its first race (a Warrior) and takes the R1 failures
//! v1's own guides do not have there (same guide, same reason), then:
//!   - a travel line they fail (a hearth to an inn they are not bound at, a flight from no flight
//!     master or to a path never learnt, a far dock) is the other races' (`only`, or gone where
//!     no other race plays the guide); a flight or a hearth gets the route's way to where it lands;
//!   - a flight from a flight master whose path they never learnt gets the `getfp` there;
//!   - a goal they reach across a zone or a continent with no travel gets the route's way there.
//!
//! Until no new failure is left (or MAX_ROUNDS).

use crate::apply::ALL_RACES;
use crate::engine::WalkYards;
use crate::guide::is_goal;
use crate::jsre::{split_comment, trim, trim_end};
use crate::post::no_empty_steps;
use crate::re;
use forge_core::jsnum::{js_hypot, js_to_fixed, js_to_string};
use forge_guide::data::Data;
use forge_guide::diag::Diagnostics;
use forge_guide::js::{str_to_num, V};
use forge_guide::project::{resolve_sources, Source};
use forge_judge::honest::{play_chain, play_chain_traced, Finding, Geo, HonestOpts, NodeKey, Persona, Place, Severity, TraceRow, Wpt};
use rustc_hash::FxHashSet;
use std::collections::BTreeMap;

const MAX_ROUNDS: usize = 6;
/// A flight or hearth later in a goal's step is the goal's own travel (the goal goes after it) when it
/// lands this near the goal.
const LANDS_NEAR_YD: f64 = 1500.0;
// The way's costs (estimates): a walk at 7 yd/s, a flight at 25 yd/s plus a minute at the
// masters, a boat or zeppelin 5 minutes with the wait.
const WALK_YPS: f64 = 7.0;
const FLY_YPS: f64 = 25.0;
const FLY_S: f64 = 60.0;
const RIDE_S: f64 = 300.0;
// A walk to a dock or a flight master longer than this goes into its zone first.
const WALK_YD: f64 = 2000.0;
// A flight is the wrong way when it leaves them this much farther from their next goal.
const WRONG_WAY_YD: f64 = 500.0;

/// What the repair needs of the route (apply_route's Output.travel).
#[derive(Clone, Debug, Default)]
pub struct Travel {
	/// The chain's guides, relative to the guides folder.
	pub chain: Vec<String>,
	pub route_races: Vec<String>,
	pub other_races: Vec<String>,
	/// The chain's guides other races play too.
	pub shared: Vec<String>,
	pub faction: Option<String>,
	/// The class the chain is played as (a class file, `WARLOCK`; None: `WARRIOR`).
	pub cls: Option<String>,
}

#[derive(Debug, Default)]
pub struct Report {
	pub rounds: usize,
	pub fixed: usize,
	/// The failures left: (file, line, reason).
	pub left: Vec<(String, u32, String)>,
	pub log: Vec<String>,
}

/// findGuideFiles order: entries sorted by name per folder, folders walked in place.
pub(crate) fn walk_order(a: &str, b: &str) -> std::cmp::Ordering {
	a.split('/').cmp(b.split('/'))
}

/// A map point `{ map, x, y, f }` (f "e": the Era frame).
#[derive(Clone, Debug)]
struct Pt {
	map: f64,
	x: f64,
	y: f64,
	f: String,
}

impl Pt {
	fn of_place(p: &Place) -> Pt {
		Pt { map: str_to_num(&p.map), x: str_to_num(&p.x), y: str_to_num(&p.y), f: p.f.clone() }
	}
	fn of_v(v: &V) -> Pt {
		Pt { map: v.get("map").num(), x: v.get("x").num(), y: v.get("y").num(), f: v.get("f").to_js_string() }
	}
}

/// Moonglade, and where a Druid's Teleport: Moonglade lands (TravelData.lua, spell 18960).
const MOONGLADE: &str = "Moonglade";
const MOONGLADE_LANDING: &str = "56.3,32.5";

struct WayStep {
	title: String,
	zone: Option<String>,
	lines: Vec<String>,
}

struct Near {
	n: V,
	d: f64,
}

struct Leg {
	s: f64,
	fly: Option<(Near, Near)>,
}

fn wpt(v: &V) -> Option<Wpt> {
	let c = v.get("c");
	if c.is_nullish() {
		return None;
	}
	Some(Wpt { c: c.num(), wx: v.get("wx").num(), wy: v.get("wy").num() })
}

fn dist(a: Option<Wpt>, b: Option<Wpt>) -> f64 {
	match (a, b) {
		(Some(a), Some(b)) if a.c == b.c => js_hypot(a.wx - b.wx, a.wy - b.wy),
		_ => f64::INFINITY,
	}
}

struct Ways<'a> {
	data: &'a Data,
	geo: Geo,
	nodes: Vec<V>,
	side: f64,
	/// Routed walking yards (the walk store), else the straight line.
	walks: Option<&'a dyn WalkYards>,
}

/// Walking yards between two points on one continent: the walk store's routed yards where it has
/// them (round the mountains between the Harborage and Lakeshire), else the straight line.
fn walk_dist(walks: Option<&dyn WalkYards>, a: Option<Wpt>, b: Option<Wpt>) -> f64 {
	match (a, b, walks) {
		(Some(p), Some(q), Some(w)) if p.c == q.c => w.yards(p, q).unwrap_or_else(|| dist(a, b)),
		_ => dist(a, b),
	}
}

impl Ways<'_> {
	fn usable(&self, f: &V) -> bool {
		// f !== (side === 1 ? 2 : 1)
		let other = if self.side == 1.0 { 2.0 } else { 1.0 };
		!(f.is_num() && f.num() == other)
	}
	fn zone_of(&self, map: f64) -> Option<String> {
		let n = self.data.zones.get(&js_to_string(map)).get("name");
		n.truthy().then(|| n.to_js_string())
	}
	fn at(&self, p: &Pt) -> Option<Wpt> {
		if p.map.is_nan() {
			return None;
		}
		self.geo.to_world(p.map as _, p.x, p.y, p.f == "e")
	}
	fn xy(x: f64, y: f64) -> String {
		format!("{},{}", js_to_fixed(x, 1), js_to_fixed(y, 1))
	}
	fn live(p: &Pt) -> &'static str {
		if p.f == "e" {
			""
		} else {
			" live"
		}
	}
	fn nearest(list: &[V], p: Option<Wpt>) -> Option<Near> {
		let mut best: Option<Near> = None;
		for n in list {
			let d = dist(wpt(n), p);
			if d < best.as_ref().map_or(f64::INFINITY, |b| b.d) {
				best = Some(Near { n: n.clone(), d });
			}
		}
		best
	}
	/// A leg on one continent: walked, or flown between the known flight paths nearest its ends
	/// when that is quicker.
	fn leg(&self, a: Option<Wpt>, b: Option<Wpt>, kn: &[V]) -> Leg {
		let walk = walk_dist(self.walks, a, b) / WALK_YPS;
		if let (Some(f0), Some(f1)) = (Self::nearest(kn, a), Self::nearest(kn, b)) {
			if !same_node(&f0.n, &f1.n) {
				let fly = (walk_dist(self.walks, a, wpt(&f0.n)) + walk_dist(self.walks, wpt(&f1.n), b)) / WALK_YPS + dist(wpt(&f0.n), wpt(&f1.n)) / FLY_YPS + FLY_S;
				if fly < walk {
					return Leg { s: fly, fly: Some((f0, f1)) };
				}
			}
		}
		Leg { s: walk, fly: None }
	}
	fn fly_steps(&self, (f0, f1): &(Near, Near)) -> Vec<WayStep> {
		let mut out = Vec::new();
		let (fx, fy) = (f0.n.get("x").num(), f0.n.get("y").num());
		let z0 = self.zone_of(f0.n.get("map").num());
		// A long walk to the flight master: into its zone first.
		if f0.d > WALK_YD {
			if let Some(z) = &z0 {
				out.push(WayStep { title: z.clone(), zone: Some(z.clone()), lines: vec![format!("  goto {} \"{z}\"", Self::xy(fx, fy))] });
			}
		}
		let mut lines = Vec::new();
		let s0 = f0.n.get("short").to_js_string();
		if f0.d > 60.0 {
			lines.push(format!("  goto {} \"{s0} flight master\"", Self::xy(fx, fy)));
		}
		lines.push(format!("  fly \"{}\"", f1.n.get("short").to_js_string()));
		out.push(WayStep { title: format!("Fly to {}", f1.n.get("short").to_js_string()), zone: z0, lines });
		out
	}
	fn goto_step(&self, b: &Pt, label: Option<&str>) -> Option<WayStep> {
		let z = self.zone_of(b.map)?;
		let l = label.map_or(z.clone(), str::to_string);
		Some(WayStep { title: l.clone(), zone: Some(z), lines: vec![format!("  goto {} \"{l}\"{}", Self::xy(b.x, b.y), Self::live(b))] })
	}
	fn same_way(&self, a: &Pt, b: &Pt, kn: &[V], label: Option<&str>) -> Vec<WayStep> {
		let l = self.leg(self.at(a), self.at(b), kn);
		if let Some(f) = &l.fly {
			return self.fly_steps(f);
		}
		self.goto_step(b, label).into_iter().collect()
	}
	/// The quickest way, by a boat or zeppelin between the continents.
	fn way(&self, a: &Pt, b: &Pt, kn: &[V], label: Option<&str>) -> Vec<WayStep> {
		let (Some(pa), Some(pb)) = (self.at(a), self.at(b)) else { return Vec::new() };
		if pa.c == pb.c {
			return self.same_way(a, b, kn, label);
		}
		struct Best {
			s: f64,
			dep: V,
			arr: V,
			kind: String,
			l0: Leg,
			l1: Leg,
		}
		let mut best: Option<Best> = None;
		for t in self.data.travel.get("transports").items() {
			if !self.usable(&t.get("faction")) || t.get("kind").to_js_string() == "tram" {
				continue;
			}
			for (dep, arr) in [(t.get("a"), t.get("b")), (t.get("b"), t.get("a"))] {
				if dep.get("c").num() != pa.c || arr.get("c").num() != pb.c {
					continue;
				}
				let l0 = self.leg(Some(pa), wpt(&dep), kn);
				let l1 = self.leg(wpt(&arr), Some(pb), kn);
				let s = l0.s + RIDE_S + l1.s;
				if best.as_ref().is_none_or(|b| s < b.s) {
					best = Some(Best { s, dep, arr, kind: t.get("kind").to_js_string(), l0, l1 });
				}
			}
		}
		let Some(best) = best else { return Vec::new() };
		let mut kind = best.kind[..1].to_uppercase();
		kind.push_str(&best.kind[1..]);
		let ride = format!("{kind} to {}", best.arr.get("name").to_js_string());
		let dep = Pt::of_v(&best.dep);
		let mut steps = Vec::new();
		if let Some(f) = &best.l0.fly {
			steps.extend(self.fly_steps(f));
		} else if dist(Some(pa), wpt(&best.dep)) > WALK_YD {
			if let Some(s) = self.goto_step(&dep, None) {
				steps.push(s);
			}
		}
		steps.push(WayStep { title: ride.clone(), zone: self.zone_of(dep.map), lines: vec![format!("  goto {} \"{ride}\"{}", Self::xy(dep.x, dep.y), Self::live(&dep))] });
		if let Some(f) = &best.l1.fly {
			steps.extend(self.fly_steps(f));
		} else if dist(wpt(&best.arr), Some(pb)) > WALK_YD {
			if let Some(s) = self.goto_step(b, label) {
				steps.push(s);
			}
		}
		steps
	}
}

/// `f0.n !== f1.n`: the nodes are one object only when they are the same entry.
fn same_node(a: &V, b: &V) -> bool {
	match (a.as_obj(), b.as_obj()) {
		(Some(x), Some(y)) => x.ptr_eq(y),
		_ => false,
	}
}

fn step_re(l: &str) -> bool {
	re!(r"^step\s").is_match(l)
}

/// The line for the races it is not the route's: `only` the others (or None where no other race
/// plays the guide); a line already `only` some races loses the route's.
pub fn gate(line: &str, route_races: &[String], other_races: &[String], is_shared: bool) -> Option<String> {
	let (code, rest) = split_comment(line);
	if let Some(m) = re!(r"\sonly\s+([!A-Za-z,]+)\s*$").captures(code) {
		let list: Vec<&str> = m[1].split(',').collect();
		if list.iter().any(|x| x.starts_with('!')) {
			return Some(line.to_string());
		}
		let keep: Vec<&str> = list.iter().copied().filter(|x| !route_races.iter().any(|r| r == x)).collect();
		if keep.len() == list.len() {
			return Some(line.to_string());
		}
		if keep.is_empty() {
			return None;
		}
		return Some(format!("{} only {}{}", &code[..m.get(0).unwrap().start()], keep.join(","), rest));
	}
	if !is_shared || other_races.is_empty() {
		return None;
	}
	Some(format!("{} only {}{}", trim_end(code), other_races.join(","), rest))
}

/// Whether a line's own `only` leaves the route's races out.
fn gated_for(line: &str, route_races: &[String]) -> bool {
	let Some(m) = re!(r"\sonly\s+([!A-Za-z,]+)\s*$").captures(split_comment(line).0) else { return false };
	let list: Vec<&str> = m[1].split(',').collect();
	if list.iter().any(|x| x.starts_with('!')) {
		return list.iter().any(|x| route_races.iter().any(|r| Some(r.as_str()) == x.get(1..)));
	}
	let races: Vec<&str> = list.iter().copied().filter(|x| ALL_RACES.contains(x)).collect();
	!races.is_empty() && !races.iter().any(|x| route_races.iter().any(|r| r == x))
}

/// Whether line i's step is for some of the route's races alone (`only` them).
fn route_step(text: &[String], i: usize, route_races: &[String]) -> bool {
	let mut s = i;
	while s > 0 && !step_re(&text[s]) {
		s -= 1;
	}
	for t in &text[s + 1..i.max(s + 1)] {
		if let Some(m) = re!(r"^\s+only\s+([!A-Za-z,]+)\s*$").captures(t) {
			return m[1].split(',').all(|x| route_races.iter().any(|r| r == x));
		}
		if is_goal(t) {
			break;
		}
	}
	false
}

/// The way's steps before line i: before its step when i is the step's first goal, else the
/// step is split there (its title, `only`/`when`/`loop` again). The step after names its zone again.
fn insert_way(text: &mut Vec<String>, i: usize, steps: &[WayStep], only_route: &[String], dest_zone: Option<&str>, route_races: &[String]) {
	// text[k] past the end reads as JS `undefined`.
	let at = |text: &Vec<String>, k: usize| -> String { text.get(k).cloned().unwrap_or_else(|| "undefined".into()) };
	let mut s = i;
	while s > 0 && !step_re(&at(text, s)) {
		s -= 1;
	}
	let mut step_end = s + 1;
	while step_end < text.len() && !step_re(&text[step_end]) {
		step_end += 1;
	}
	let first_goal: Option<usize> = (s + 1..step_end.max(s + 1)).find(|&k| k < text.len() && is_goal(&text[k]));
	let zone_here: Option<String> = (|| {
		for k in (0..=i).rev() {
			let tk = at(text, k);
			if let Some(z) = re!(r"^\s+zone\s+(.+)$").captures(&tk) {
				if k < i {
					// A zone of a step some characters skip does not count.
					let mut t = k;
					while t > 0 && !step_re(&text[t]) {
						t -= 1;
					}
					let end = text.len().min(k + 8);
					let step_only = text[t + 1..k.max(t + 1)].iter().chain(text[(k + 1).min(end)..end].iter()).any(|l| re!(r"^\s+only\s").is_match(l));
					if t == s || !step_only {
						return Some(trim(&z[1]).to_string());
					}
				}
			}
			if let Some(hz) = re!(r"^zone\s+(.+)$").captures(&tk) {
				return Some(trim(&hz[1]).to_string());
			}
		}
		None
	})();
	// The way to a step only some characters play is theirs too (the Undercity leg before the class
	// trainers' step, A9).
	let step_only: Option<String> =
		if only_route.is_empty() { text.get(s + 1..step_end.min(text.len())).and_then(|b| b.iter().take_while(|l| !is_goal(l)).find(|l| re!(r"^\s+only\s").is_match(l)).cloned()) } else { None };
	let mut block: Vec<String> = Vec::new();
	for st in steps {
		block.push(format!("step {}", st.title));
		block.extend(only_route.iter().cloned());
		block.extend(step_only.iter().cloned());
		if let Some(z) = st.zone.as_ref().filter(|z| !z.is_empty()) {
			block.push(format!("  zone {z}"));
		}
		block.extend(st.lines.iter().cloned());
		block.push(String::new());
	}
	let n = text.len();
	let body = (s + 1).min(n)..step_end.max(s + 1).min(n);
	let body0 = (s + 1).min(n)..step_end0(text, s).max(s + 1).min(n);
	let has_zone = text[body0].iter().any(|l| re!(r"^\s+zone\s").is_match(l));
	// Goals before i with no place of their own (train, level): the way goes before the step.
	let placeless = match first_goal {
		Some(fg) => text[fg..i.max(fg).min(text.len())].iter().all(|l| !is_goal(l) || re!(r"^\s+(train|level|note|skill|learn)\b").is_match(l)),
		None => true,
	};
	if first_goal.is_none_or(|fg| fg >= i) || placeless {
		// Before the step, and before the steps right before it in the way's zone with nothing placed of
		// their own (v1's Orgrimmar `train class` step before the turn-ins there).
		let mut s = s;
		let mut q = prev_step(text, s);
		while let Some(qq) = q {
			let st = step_info(text, qq, route_races);
			if st.visible {
				// (A class's own line, `accept 3631 only Warlock` beside the training, is the class's.)
				let class_line = |l: &String| only_list(l).is_some_and(|o| o.split(',').all(|x| !ALL_RACES.contains(&x)));
				let mine: Vec<&String> = st.goals.iter().filter(|l| !class_line(l) || re!(r"^\s+(train|level|note|skill|learn)\b").is_match(l)).collect();
				if dest_zone.is_none() || st.zone.as_deref() != dest_zone || mine.is_empty() || !mine.iter().all(|l| re!(r"^\s+(train|level|note|skill|learn)\b").is_match(l)) {
					break;
				}
				s = qq;
			}
			q = prev_step(text, qq);
		}
		let n = text.len();
		if !has_zone {
			if let Some(z) = &zone_here {
				text.insert((s + 1).min(n), format!("  zone {z}"));
			}
		}
		let s = s.min(text.len());
		text.splice(s..s, block);
		return;
	}
	let mut cont: Vec<String> = vec![at(text, s)];
	cont.extend(text[body].iter().filter(|l| re!(r"^\s+(only|when|loop)\b").is_match(l)).cloned());
	if let Some(z) = &zone_here {
		cont.push(format!("  zone {z}"));
	}
	let mut ins = vec![String::new()];
	ins.extend(block);
	ins.extend(cont);
	let i = i.min(text.len());
	text.splice(i..i, ins);
}

/// The guide files connected to the chain through `next` either way (every id on a `next` line counts,
/// so the set is a union of whole components): the honest play's chains, roots and findings for the
/// chain's guides are the same as with every guide compiled.
/// The start of the step before the one at s (None: none).
fn prev_step(text: &[String], s: usize) -> Option<usize> {
	for k in (0..s).rev() {
		if step_re(&text[k]) {
			return Some(k);
		}
		if crate::jsre::starts_nonspace(&text[k]) && !text[k].starts_with('#') {
			return None;
		}
	}
	None
}

fn step_end0(text: &[String], s: usize) -> usize {
	let mut e = s + 1;
	while e < text.len() && !step_re(&text[e]) && !re!(r"^#\s-{10,}").is_match(&text[e]) {
		e += 1;
	}
	e
}

/// A step's lines for the route's races.
struct StepInfo {
	visible: bool,
	route_own: bool,
	zone: Option<String>,
	goals: Vec<String>,
	lines: Vec<usize>,
}

fn only_list(l: &str) -> Option<String> {
	re!(r"\sonly\s+([A-Za-z,]+)\s*$").captures(split_comment(l).0).map(|m| m[1].to_string())
}

fn step_info(text: &[String], s: usize, route_races: &[String]) -> StepInfo {
	let e = step_end0(text, s);
	let only_line = text[(s + 1).min(e)..e].iter().find(|l| re!(r"^\s+only\s").is_match(l));
	let list: Vec<String> = only_line.map_or(Vec::new(), |l| trim(&re!(r"^\s+only\s+").replace(l, "")).split(',').map(str::to_string).collect());
	let races: Vec<&String> = list.iter().filter(|x| ALL_RACES.contains(&x.as_str())).collect();
	let class_only = !list.is_empty() && races.is_empty();
	let visible = !class_only && (races.is_empty() || races.iter().any(|r| route_races.contains(r)));
	let route_own = !races.is_empty() && races.iter().all(|r| route_races.contains(r));
	let zone = text[(s + 1).min(e)..e].iter().find_map(|l| re!(r"^\s+zone\s+(.+)$").captures(l).map(|m| trim(&m[1]).to_string()));
	let lines: Vec<usize> = (s + 1..e).filter(|&k| is_goal(&text[k]) && !gated_for(&text[k], route_races)).collect();
	StepInfo { visible, route_own, zone, goals: lines.iter().map(|&k| text[k].clone()).collect(), lines }
}

/// v1's travel the route's own way replaces: in a stretch of steps where the route's characters only
/// travel, v1's travel lines before one of the route's own way steps are the other races'. -> lines changed
fn replaced_travel(text: &mut Vec<String>, rr: &[String], others: &[String], is_shared: bool) -> usize {
	const GONE: &str = "\u{0}";
	let mut n = 0;
	let mut stretch: Vec<StepInfo> = Vec::new();
	let close = |text: &mut Vec<String>, stretch: &mut Vec<StepInfo>, n: &mut usize| {
		if let Some(last_own) = stretch.iter().rposition(|st| st.route_own) {
			for st in &stretch[..last_own] {
				if st.route_own {
					continue;
				}
				for &li in &st.lines {
					if !re!(r"^\s+(goto|fly|hearth)\s").is_match(&text[li]) {
						continue;
					}
					let g = gate(&text[li], rr, others, is_shared);
					if g.as_deref() == Some(text[li].as_str()) {
						continue;
					}
					text[li] = g.unwrap_or_else(|| GONE.into());
					*n += 1;
				}
			}
		}
		stretch.clear();
	};
	for s in 0..text.len() {
		if re!(r"^guide\s").is_match(&text[s]) {
			close(text, &mut stretch, &mut n);
		}
		if !step_re(&text[s]) {
			continue;
		}
		let st = step_info(text, s, rr);
		if !st.visible || st.goals.is_empty() {
			continue;
		}
		let travel =
			st.goals.iter().all(|l| re!(r"^\s+(goto|fly|hearth)\s").is_match(l) || re!(r"^\s+(note|level)\b").is_match(l)) && st.goals.iter().any(|l| re!(r"^\s+(goto|fly|hearth)\s").is_match(l));
		if travel {
			stretch.push(st);
		} else {
			close(text, &mut stretch, &mut n);
		}
	}
	close(text, &mut stretch, &mut n);
	text.retain(|l| l != GONE);
	n
}

/// An accept or turn-in the route writes for its own races (`only` them) is theirs there: the same
/// line for everyone earlier in the chain is the other races' (Darsok's Harpy Lieutenants turn-in,
/// moved by the route to the later Crossroads stop, stayed in the earlier guide for everyone and
/// was done there). -> lines changed
fn route_events_first(tree: &mut BTreeMap<String, String>, t: &Travel) -> usize {
	let rr = &t.route_races;
	let mut texts: Vec<Vec<String>> = t.chain.iter().map(|f| tree.get(f).map_or(Vec::new(), |x| x.split('\n').map(str::to_string).collect())).collect();
	let event = |l: &str| re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(l).map(|m| format!("{} {}", &m[1], &m[2]));
	let step_of = |text: &[String], i: usize| -> usize {
		let mut k = i;
		while k > 0 && !step_re(&text[k]) {
			k -= 1;
		}
		k
	};
	let own = |text: &[String], i: usize| -> bool {
		let line_own = only_list(&text[i]).is_some_and(|l| {
			let races: Vec<&str> = l.split(',').filter(|x| ALL_RACES.contains(x)).collect();
			!races.is_empty() && races.iter().all(|r| rr.iter().any(|x| x == r))
		});
		line_own || step_info(text, step_of(text, i), rr).route_own
	};
	let mut firsts: Vec<(usize, usize, String)> = Vec::new();
	for (fi, text) in texts.iter().enumerate() {
		for i in 0..text.len() {
			if let Some(e) = event(&text[i]) {
				if own(text, i) {
					firsts.push((fi, i, e));
				}
			}
		}
	}
	let mut n = 0;
	for (fi, i, e) in firsts {
		for fj in 0..=fi {
			let upto = if fj == fi { i } else { texts[fj].len() };
			let is_shared = t.shared.contains(&t.chain[fj]);
			for k in 0..upto {
				if event(&texts[fj][k]).as_deref() != Some(e.as_str()) || own(&texts[fj], k) || gated_for(&texts[fj][k], rr) {
					continue;
				}
				if !step_info(&texts[fj], step_of(&texts[fj], k), rr).visible {
					continue;
				}
				match gate(&texts[fj][k], rr, &t.other_races, is_shared) {
					Some(g) if g == texts[fj][k] => {}
					Some(g) => {
						texts[fj][k] = g;
						n += 1;
					}
					None => {
						texts[fj][k] = "\u{0}".to_string();
						n += 1;
					}
				}
			}
		}
	}
	if n > 0 {
		for (f, text) in t.chain.iter().zip(texts) {
			if tree.contains_key(f) {
				tree.insert(f.clone(), no_empty_steps(text.into_iter().filter(|l| l != "\u{0}").collect()).join("\n"));
			}
		}
	}
	n
}

/// The zone after steps only some characters see: a step everyone sees, after `only` steps that
/// set a zone, names its zone again (GUIDE_FORMAT.md `zone`): the zone of the last step before it
/// that is not the route's own way (v1's step for the other races carries v1's zone: Feralas after
/// the Orc's flight from Thunder Bluff to Camp Mojache). -> lines added
fn restate_zones(text: &mut Vec<String>, rr: &[String]) -> usize {
	let mut n = 0;
	let mut pending = false;
	let mut last_v1: Option<String> = None;
	let mut s = 0;
	while s < text.len() {
		if let Some(m) = re!(r"^zone\s+(.+)$").captures(&text[s]) {
			last_v1 = Some(trim(&m[1]).to_string());
			pending = false;
		}
		if !step_re(&text[s]) {
			s += 1;
			continue;
		}
		let e = step_end0(text, s);
		let only = text[s + 1..e].iter().find(|l| re!(r"^\s+only\s").is_match(l)).cloned();
		let zone = text[s + 1..e].iter().find_map(|l| re!(r"^\s+zone\s+(.+)$").captures(l).map(|m| trim(&m[1]).to_string()));
		match only {
			Some(o) => {
				let list: Vec<String> = trim(&re!(r"^\s+only\s+").replace(&o, "")).split(',').map(str::to_string).collect();
				let races: Vec<&String> = list.iter().filter(|x| ALL_RACES.contains(&x.as_str())).collect();
				let route_own = !races.is_empty() && races.iter().all(|r| rr.contains(r));
				if let Some(z) = zone {
					pending = true;
					// (A class's own trip is not where everyone is.)
					if !races.is_empty() && !route_own {
						last_v1 = Some(z);
					}
				}
			}
			None => {
				if zone.is_none() && pending {
					if let Some(z) = &last_v1 {
						text.insert(s + 1, format!("  zone {z}"));
						n += 1;
					}
				}
				if let Some(z) = zone {
					last_v1 = Some(z);
				}
				pending = false;
			}
		}
		s += 1;
	}
	n
}

/// A step everyone sees whose goals are all `only` the same other races now: the step is theirs. -> steps changed
fn hide_emptied(text: &mut Vec<String>, rr: &[String]) -> usize {
	let mut n = 0;
	let mut s = 0;
	while s < text.len() {
		if !step_re(&text[s]) {
			s += 1;
			continue;
		}
		let e = step_end0(text, s);
		if text[s + 1..e].iter().any(|l| re!(r"^\s+only\s").is_match(l)) {
			s += 1;
			continue;
		}
		let goals: Vec<usize> = (s + 1..e).filter(|&k| is_goal(&text[k])).collect();
		if goals.is_empty() {
			s += 1;
			continue;
		}
		let lists: Vec<Option<String>> = goals.iter().map(|&k| only_list(&text[k])).collect();
		if lists.iter().any(Option::is_none) || lists.iter().any(|l| l != &lists[0]) {
			s += 1;
			continue;
		}
		let list = lists[0].clone().unwrap();
		let races: Vec<&str> = list.split(',').collect();
		if !races.iter().all(|r| ALL_RACES.contains(r)) || races.iter().any(|r| rr.iter().any(|x| x == r)) {
			s += 1;
			continue;
		}
		for &k in &goals {
			let (code, rest) = split_comment(&text[k]);
			text[k] = format!("{}{}", re!(r"\s+only\s+[A-Za-z,]+\s*$").replace(code, ""), rest);
		}
		text.insert(s + 1, format!("  only {list}"));
		n += 1;
		s += 1;
	}
	n
}

/// The route's bind at an inn v1 binds at too, written after v1's line: v1's line is everyone's and the
/// route's goes, when no other bind of the route's races comes between.
fn binds_at_v1(text: &mut Vec<String>, rr: &[String]) -> usize {
	let mut n = 0;
	let name = |l: &str| re!(r#"^\s+sethome\s+"([^"]+)""#).captures(l).map(|m| m[1].to_string());
	let mut k = 0;
	while k < text.len() {
		let Some(nm) = name(&text[k]) else {
			k += 1;
			continue;
		};
		let ok = only_list(&text[k]).is_some_and(|l| l.split(',').all(|r| rr.iter().any(|x| x == r)));
		if !ok {
			k += 1;
			continue;
		}
		let mut removed = false;
		for j in (0..k).rev() {
			if re!(r"^guide\s").is_match(&text[j]) {
				break;
			}
			let Some(nj) = name(&text[j]) else { continue };
			if !gated_for(&text[j], rr) {
				break;
			}
			if nj != nm {
				continue;
			}
			let (code, rest) = split_comment(&text[j]);
			text[j] = format!("{}{}", re!(r"\s+only\s+[A-Za-z,]+\s*$").replace(code, ""), rest);
			text.remove(k);
			n += 1;
			removed = true;
			break;
		}
		if !removed {
			k += 1;
		}
	}
	n
}

pub(crate) fn component(tree: &BTreeMap<String, String>, files: &[&String], chain: &[String]) -> FxHashSet<String> {
	use rustc_hash::FxHashMap;
	let mut id_file: FxHashMap<String, &str> = FxHashMap::default();
	let mut nexts: FxHashMap<&str, Vec<String>> = FxHashMap::default();
	for f in files {
		let text = &tree[*f];
		let mut ids = Vec::new();
		for l in text.split('\n') {
			if let Some(m) = re!(r"^guide\s+(\S+)").captures(l) {
				id_file.entry(m[1].to_string()).or_insert(f.as_str());
			}
			if let Some(m) = re!(r"^next\s+(.*)$").captures(l) {
				let list = m[1].split(" when").next().unwrap_or("");
				ids.extend(list.split(|c: char| c == ',' || crate::jsre::is_ws(c)).filter(|x| !x.is_empty()).map(str::to_string));
			}
		}
		nexts.insert(f.as_str(), ids);
	}
	let mut adj: FxHashMap<&str, Vec<&str>> = FxHashMap::default();
	for (f, ids) in &nexts {
		for id in ids {
			if let Some(&g) = id_file.get(id) {
				adj.entry(f).or_default().push(g);
				adj.entry(g).or_default().push(f);
			}
		}
	}
	let mut set: FxHashSet<String> = FxHashSet::default();
	let mut queue: Vec<&str> = chain.iter().map(String::as_str).collect();
	while let Some(f) = queue.pop() {
		if !set.insert(f.to_string()) {
			continue;
		}
		for &g in adj.get(f).map_or(&[][..], |v| &v[..]) {
			if !set.contains(g) {
				queue.push(g);
			}
		}
	}
	set
}

/// The R1 failures of the route's chain played by its race in a guide tree ("forever/..." paths), and the
/// goals played when `traced`.
fn play_traced(tree: &BTreeMap<String, String>, data: &Data, t: &Travel, traced: bool) -> (Vec<Finding>, Vec<TraceRow>) {
	let mut files: Vec<&String> = tree.keys().filter(|k| k.starts_with("forever/") && k.ends_with(".guide")).collect();
	files.sort_by(|a, b| walk_order(a, b));
	let keep = component(tree, &files, &t.chain);
	files.retain(|f| keep.contains(f.as_str()));
	let sources: Vec<Source> = files.iter().map(|f| Source { file: f.to_string(), source: f.to_string(), text: tree[*f].clone() }).collect();
	let mut diag = Diagnostics::new();
	// compileSources' guides: its validation and tokens only add diagnostics.
	let guides = resolve_sources(&sources, data, &mut diag, None, None);
	// The route's chain in its order (a chain the `next` options of another start would pass by other guides).
	let played: Vec<&V> = t
		.chain
		.iter()
		.filter_map(|f| {
			guides.iter().find(|g| {
				let ast = g.hidden("_ast");
				ast.truthy() && ast.get("file").to_js_string() == *f
			})
		})
		.collect();
	// (The persona is a race file: Undead play as `Scourge`, which their `only Undead` lines compile to.)
	let race = t.route_races.first().map(|r| if r == "Undead" { "Scourge".to_string() } else { r.clone() }).unwrap_or_default();
	let persona = Persona { race, faction: t.faction.clone().unwrap_or_default(), cls: t.cls.clone().unwrap_or_else(|| "WARRIOR".into()) };
	let (f, tr) = if traced {
		play_chain_traced(&played, data, &persona, &HonestOpts { walk_far: true, ..HonestOpts::legacy() })
	} else {
		(play_chain(&played, data, &persona, None, None, &HonestOpts { walk_far: true, ..HonestOpts::legacy() }), Vec::new())
	};
	(f.into_iter().filter(|f| f.rule == "R1" && f.severity == Severity::Fail).collect(), tr)
}

fn play(tree: &BTreeMap<String, String>, data: &Data, t: &Travel) -> Vec<Finding> {
	play_traced(tree, data, t, false).0
}

/// A finding's reason less its distances; where the guide leaves the player (`Zone x,y`) stays: v1's
/// flight from the zeppelin's landing does not hide the route's from a camp in Stranglethorn.
fn norm(r: &str) -> String {
	re!(r"\(?-?\d+(\.\d+)? ?yd\)?").replace_all(r, "#").into_owned()
}

fn text_at<'a>(tree: &'a BTreeMap<String, String>, file: &str, line: u32) -> &'a str {
	tree.get(file).and_then(|t| t.split('\n').nth((line as usize).wrapping_sub(1))).map_or("", trim)
}

/// A failure v1 has too: the same guide, reason and line text without its `--` note (v1's own breaks
/// elsewhere in the guide do not hide one the route makes; a note the engine adds does not unhide one).
fn key_of(f: &Finding, tree: &BTreeMap<String, String>) -> String {
	format!("{} {} {}", f.file, norm(&f.reason), crate::jsre::trim_end(crate::jsre::split_comment(text_at(tree, &f.file, f.line)).0))
}

/// The flights that take them away from their next goal (on one continent): (file, line).
fn wrong_way(tree: &BTreeMap<String, String>, data: &Data, t: &Travel, walks: Option<&dyn WalkYards>) -> Vec<(String, u32)> {
	let goals = play_traced(tree, data, t, true).1;
	let mut out = Vec::new();
	for (k, g) in goals.iter().enumerate() {
		let (Some(b), Some(a)) = (g.before, g.after) else { continue };
		if g.verb != "fly" {
			continue;
		}
		let next = goals[k + 1..].iter().find(|x| !matches!(x.verb.as_str(), "goto" | "fly" | "hearth" | "getfp" | "sethome" | "note" | "level") && x.after.is_some() && x.moved);
		let Some(next) = next else { continue };
		let n = next.after.unwrap();
		let (d0, d1) = (walk_dist(walks, Some(b), Some(n)), walk_dist(walks, Some(a), Some(n)));
		if b.c == n.c && a.c == n.c && d1 > d0 + WRONG_WAY_YD {
			out.push((g.file.clone(), g.line));
		}
	}
	out
}

struct Repair<'a> {
	ways: Ways<'a>,
	t: &'a Travel,
	data: &'a Data,
	v1_keys: FxHashSet<String>,
	tried: FxHashSet<String>,
}

impl Repair<'_> {
	fn rounds(&mut self, tree: &mut BTreeMap<String, String>, rep: &mut Report) {
		let t = self.t;
		let rr = &t.route_races;
		let shared: FxHashSet<&str> = t.shared.iter().map(String::as_str).collect();
		for _ in 0..MAX_ROUNDS {
			rep.rounds += 1;
			// A failure repaired once and back (the repair's own way failing) is left.
			// (A long walk of the route's own way, in a step for its races alone, is no failure of v1's lines.)
			let own_walk = |f: &Finding| -> bool {
				(f.reason.starts_with("walk far ") || f.reason.starts_with("dock far "))
					&& tree.get(&f.file).is_some_and(|tx| {
						let lines: Vec<String> = tx.split('\n').map(str::to_string).collect();
						(f.line as usize).checked_sub(1).is_some_and(|i| i < lines.len() && route_step(&lines, i, rr))
					})
			};
			let all: Vec<Finding> =
				play(tree, self.data, t).into_iter().filter(|f| !self.v1_keys.contains(&key_of(f, tree)) && f.state.as_ref().is_some_and(|s| s.at.is_some()) && !own_walk(f)).collect();
			let found: Vec<&Finding> = all.iter().filter(|f| !self.tried.contains(&key_of(f, tree))).collect();
			for f in &found {
				self.tried.insert(key_of(f, tree));
			}
			rep.left = all.iter().map(|f| (f.file.clone(), f.line, f.reason.clone())).collect();
			if found.is_empty() {
				break;
			}
			// One repair per line, each file from the bottom up (line numbers hold).
			let mut by_file: Vec<(String, Vec<&Finding>)> = Vec::new();
			for f in &found {
				let e = match by_file.iter().position(|(file, _)| *file == f.file) {
					Some(i) => i,
					None => {
						by_file.push((f.file.clone(), Vec::new()));
						by_file.len() - 1
					}
				};
				if !by_file[e].1.iter().any(|g| g.line == f.line) {
					by_file[e].1.push(f);
				}
			}
			let mut did = 0;
			for (file, mut by_line) in by_file {
				let mut text: Vec<String> = tree.get(&file).map_or(String::new(), |s| s.clone()).split('\n').map(str::to_string).collect();
				let is_shared = shared.contains(file.as_str());
				let only_route: Vec<String> = if is_shared && !t.other_races.is_empty() { vec![format!("  only {}", rr.join(","))] } else { Vec::new() };
				by_line.sort_by_key(|x| std::cmp::Reverse(x.line));
				for f in by_line {
					did += self.repair_one(&mut text, &file, f, is_shared, &only_route, rep);
				}
				tree.insert(file, no_empty_steps(text).join("\n"));
			}
			rep.fixed += did;
			rep.log.push(format!("travel repair round {}: {} new R1 failures, {did} repaired", rep.rounds, found.len()));
			if did == 0 {
				break;
			}
		}
	}

	fn repair_one(&self, text: &mut Vec<String>, file: &str, f: &Finding, is_shared: bool, only_route: &[String], rep: &mut Report) -> usize {
		let t = self.t;
		let rr = &t.route_races;
		let ways = &self.ways;
		let mut i = f.line as i64 - 1;
		// A finding on the step (its goal's own line unknown): its first goal.
		if i >= 0 && (i as usize) < text.len() && step_re(&text[i as usize]) {
			let mut k = i as usize + 1;
			while k < text.len() && !step_re(&text[k]) && !is_goal(&text[k]) {
				k += 1;
			}
			if is_goal(text.get(k).map_or("", String::as_str)) {
				i = k as i64;
			}
		}
		if i < 0 || i as usize >= text.len() || !is_goal(&text[i as usize]) {
			return 0;
		}
		let i = i as usize;
		// (A step searched as a circuit, `loop`: its gotos are the search's spots, not travel; the way
		// there is the step before's.)
		let mut s = i;
		while s > 0 && !step_re(&text[s]) {
			s -= 1;
		}
		if text[s + 1..].iter().take_while(|l| !step_re(l) && !l.trim().is_empty()).any(|l| l.trim() == "loop") {
			return 0;
		}
		let line = text[i].clone();
		rep.log.push(format!("  {file}:{} {} | {}", i + 1, f.reason, trim(&line)));
		let change = re!(r"(zone|continent) change with no travel line").is_match(&f.reason);
		// A goal written before its own step's travel: after it. (Not travel that leaves for another map
		// than the goal's: the Druids' flight back to Auberdine at the end of their Moonglade step.)
		if change {
			let mut k = i + 1;
			while k < text.len() && !step_re(&text[k]) && !(re!(r"^\s+(fly|hearth)\s").is_match(&text[k]) && !gated_for(&text[k], rr)) {
				k += 1;
			}
			// (Lands within LANDS_NEAR_YD of the goal; unknown: yes.)
			let lands_there = |l: &str| -> bool {
				let Some(to) = f.moved.as_ref().map(|m| Pt::of_place(&m.to)) else { return true };
				let Some(name) = re!(r#""([^"]+)""#).captures(l).map(|m| m[1].to_lowercase()) else { return true };
				let land = if re!(r"^\s+fly\s").is_match(l) {
					self.ways
						.nodes
						.iter()
						.find(|x| self.ways.usable(&x.get("faction")) && (x.get("short").to_js_string().to_lowercase() == name || x.get("name").to_js_string().to_lowercase() == name))
						.map(|n| Pt { map: n.get("map").num(), x: n.get("x").num(), y: n.get("y").num(), f: "e".into() })
				} else {
					self.data
						.travel
						.get("inns")
						.items()
						.into_iter()
						.find(|x| {
							let names = x.get("names");
							let list = if names.truthy() { names.items() } else { vec![x.get("location")] };
							list.iter().any(|nm| nm.to_js_string().to_lowercase() == name)
						})
						.map(|inn| Pt::of_v(&inn))
				};
				match (land.and_then(|p| self.ways.at(&p)), self.ways.at(&to)) {
					(Some(a), Some(b)) => a.c == b.c && (a.wx - b.wx).hypot(a.wy - b.wy) <= LANDS_NEAR_YD,
					_ => true,
				}
			};
			if k < text.len() && re!(r"^\s+(fly|hearth)\s").is_match(&text[k]) && lands_there(&text[k]) {
				let moved = text.remove(i);
				text.insert(k, moved);
				return 1;
			}
		}
		let state = f.state.as_ref().unwrap();
		let kn: Vec<V> = ways.nodes.iter().filter(|n| state.known.contains(&NodeKey::of(&n.get("id"))) && ways.usable(&n.get("faction"))).cloned().collect();
		let fl = re!(r#"^\s+fly\s+"([^"]+)""#).captures(&line).map(|m| m[1].to_string());
		if let Some(g) = re!(r"^fly from (.+): its flight path was never learnt$").captures(&f.reason) {
			let only = if only_route.is_empty() { String::new() } else { format!(" only {}", rr.join(",")) };
			text.insert(i, format!("  getfp \"{}\"{only}", &g[1]));
			return 1;
		}
		let hearth = re!(r"^\s+hearth\s").is_match(&line);
		if fl.is_some() || hearth || f.reason.starts_with("dock ") || f.reason.starts_with("flight master ") || f.reason.starts_with("walk far ") {
			// A long walk of the route's own way (a step for its races alone) is theirs to make.
			if (f.reason.starts_with("walk far ") || f.reason.starts_with("dock far ")) && route_step(text, i, rr) {
				return 0;
			}
			// v1's travel from where they are not: the other races'.
			let gated = if route_step(text, i, rr) { None } else { gate(&line, rr, &t.other_races, is_shared) };
			if gated.as_deref() == Some(line.as_str()) {
				return 0;
			}
			match gated {
				None => {
					text.remove(i);
				}
				Some(g) => text[i] = g,
			}
			// Where the flight or the hearth lands: the route's way there.
			let mut dest: Option<(Pt, String)> = None;
			if let Some(fl) = &fl {
				let lo = fl.to_lowercase();
				if let Some(n) = ways.nodes.iter().find(|x| ways.usable(&x.get("faction")) && (x.get("short").to_js_string().to_lowercase() == lo || x.get("name").to_js_string().to_lowercase() == lo))
				{
					dest = Some((Pt { map: n.get("map").num(), x: n.get("x").num(), y: n.get("y").num(), f: "e".into() }, n.get("short").to_js_string()));
				}
			} else if hearth {
				if let Some(h) = re!(r#""([^"]+)""#).captures(&line) {
					let lo = h[1].to_lowercase();
					let inn = self.data.travel.get("inns").items().into_iter().find(|x| {
						let names = x.get("names");
						let list = if names.truthy() { names.items() } else { vec![x.get("location")] };
						list.iter().any(|nm| nm.to_js_string().to_lowercase() == lo)
					});
					if let Some(inn) = inn {
						dest = Some((Pt::of_v(&inn), inn.get("location").to_js_string()));
					}
				}
			}
			if let Some((d, name)) = dest {
				let at = Pt::of_place(state.at.as_ref().unwrap());
				let ins = ways.way(&at, &d, &kn, Some(&name));
				if !ins.is_empty() {
					let dz = ways.zone_of(d.map);
					insert_way(text, i, &ins, only_route, dz.as_deref(), rr);
				}
			}
			return 1;
		}
		let Some(to) = f.moved.as_ref().map(|m| &m.to) else { return 0 };
		if !change {
			return 0;
		}
		let to = Pt::of_place(to);
		let dz = ways.zone_of(to.map);
		// (A Druid goes to Moonglade by its own spell, as v1's Moonglade steps say: the Skyborne Druids'
		// teleport, not a flight to Orgrimmar and a 6,500 yd walk, S6.)
		let druid = t.cls.as_deref() == Some("DRUID") || only_list(&text[..=i.min(text.len() - 1)].iter().rev().take_while(|l| !step_re(l)).find(|l| re!(r"^\s+only\s").is_match(l)).cloned().unwrap_or_default()).is_some_and(|o| o.split(',').all(|c| c.trim() == "Druid"));
		if druid && dz.as_deref() == Some(MOONGLADE) {
			let way = WayStep { title: "Moonglade".into(), zone: Some(MOONGLADE.into()), lines: vec![format!("  goto {MOONGLADE_LANDING} \"Cast Teleport: Moonglade\"")] };
			insert_way(text, i, &[way], only_route, dz.as_deref(), rr);
			return 1;
		}
		let steps = ways.way(&Pt::of_place(state.at.as_ref().unwrap()), &to, &kn, None);
		if steps.is_empty() {
			return 0;
		}
		insert_way(text, i, &steps, only_route, dz.as_deref(), rr);
		1
	}
}

/// Text passes over the chain's guides: fn(text, is_shared) -> changes.
fn pass(tree: &mut BTreeMap<String, String>, t: &Travel, f: &mut dyn FnMut(&mut Vec<String>, bool) -> usize) -> usize {
	let mut n = 0;
	for file in &t.chain {
		let Some(text) = tree.get(file) else { continue };
		let mut text: Vec<String> = text.split('\n').map(str::to_string).collect();
		let k = f(&mut text, t.shared.contains(file));
		if k > 0 {
			tree.insert(file.clone(), no_empty_steps(text).join("\n"));
		}
		n += k;
	}
	n
}

/// repairTravel: `tree` is the written guide tree (the guides folder's files with the chain
/// rewritten), `v1` the guides as shipped; the chain's files in `tree` are repaired in place.
pub fn repair_travel(tree: &mut BTreeMap<String, String>, v1: &BTreeMap<String, String>, t: &Travel, data: &Data, walks: Option<&dyn WalkYards>) -> Report {
	let mut rep = Report::default();
	let ways = Ways { data, geo: Geo::new(&data.map_frames), nodes: data.travel.get("taxi").get("nodes").items(), side: if t.faction.as_deref() == Some("Alliance") { 1.0 } else { 2.0 }, walks };
	let v1_keys: FxHashSet<String> = play(v1, data, t).iter().map(|f| key_of(f, v1)).collect();
	let rr = t.route_races.clone();
	rep.fixed = pass(tree, t, &mut |text, _| binds_at_v1(text, &rr));
	rep.fixed += route_events_first(tree, t);
	let mut r = Repair { ways, t, data, v1_keys, tried: FxHashSet::default() };
	r.rounds(tree, &mut rep);
	// v1's travel the route's own way replaces, and steps left with nothing of theirs: the other races'.
	// A flight that takes them away from their next goal: the other races'. Flights v1 makes so too stay.
	let v1_wrong: FxHashSet<String> = wrong_way(v1, data, t, walks).into_iter().map(|(f, l)| format!("{f} {}", text_at(v1, &f, l))).collect();
	let wrong: Vec<(String, u32)> = wrong_way(tree, data, t, walks).into_iter().filter(|(f, l)| !v1_wrong.contains(&format!("{f} {}", text_at(tree, f, *l)))).collect();
	let mut by_file: Vec<(String, Vec<u32>)> = Vec::new();
	for (f, l) in &wrong {
		rep.log.push(format!("  {f}:{l} a flight away from the next goal | {}", text_at(tree, f, *l)));
		match by_file.iter_mut().find(|(x, _)| x == f) {
			Some((_, v)) => v.push(*l),
			None => by_file.push((f.clone(), vec![*l])),
		}
	}
	let mut wrong_fixed = 0;
	for (file, mut lines) in by_file {
		let mut text: Vec<String> = tree[&file].split('\n').map(str::to_string).collect();
		let is_shared = t.shared.contains(&file);
		lines.sort_by(|a, b| b.cmp(a));
		for n in lines {
			let k = n as usize - 1;
			let g = if route_step(&text, k, &rr) { None } else { gate(&text[k], &rr, &t.other_races, is_shared) };
			if g.as_deref() == Some(text[k].as_str()) {
				continue;
			}
			match g {
				None => {
					text.remove(k);
				}
				Some(g) => text[k] = g,
			}
			wrong_fixed += 1;
		}
		tree.insert(file, no_empty_steps(text).join("\n"));
	}
	let gated_now = wrong_fixed + pass(tree, t, &mut |text, sh| replaced_travel(text, &rr, &t.other_races, sh) + hide_emptied(text, &rr));
	if gated_now > 0 {
		rep.fixed += gated_now;
		r.rounds(tree, &mut rep);
	}
	rep.fixed += pass(tree, t, &mut |text, _| restate_zones(text, &rr));
	rep
}

/// The repair's rounds alone on `tree` (no gating of v1's travel for other races): each R1 failure of
/// the chain played as `t`'s race (and class) that `v1` does not have gets that player's way, `only`
/// the route's races (shared.rs: a race's or class's own detour on the one shared route).
pub fn repair_rounds(tree: &mut BTreeMap<String, String>, v1: &BTreeMap<String, String>, t: &Travel, data: &Data, walks: Option<&dyn WalkYards>) -> Report {
	let mut rep = Report::default();
	let ways = Ways { data, geo: Geo::new(&data.map_frames), nodes: data.travel.get("taxi").get("nodes").items(), side: if t.faction.as_deref() == Some("Alliance") { 1.0 } else { 2.0 }, walks };
	let v1_keys: FxHashSet<String> = play(v1, data, t).iter().map(|f| key_of(f, v1)).collect();
	let mut r = Repair { ways, t, data, v1_keys, tried: FxHashSet::default() };
	r.rounds(tree, &mut rep);
	rep
}

/// The route's chain played by its race (legacy honest, walk-far on): R1 failures on the written tree
/// that v1 does not have on the same lines, and all of them. -> (new, all, the new ones).
pub fn r1_check(tree: &BTreeMap<String, String>, v1: &BTreeMap<String, String>, t: &Travel, data: &Data) -> (usize, usize, Vec<(String, u32, String)>) {
	let v1_keys: FxHashSet<String> = play(v1, data, t).iter().map(|f| key_of(f, v1)).collect();
	let rr = &t.route_races;
	// (A long walk of the route's own way, in a step for its races alone, is the route's leg, not a failure.)
	let own_walk = |f: &Finding| -> bool {
		(f.reason.starts_with("walk far ") || f.reason.starts_with("dock far "))
			&& tree.get(&f.file).is_some_and(|tx| {
				let lines: Vec<String> = tx.split('\n').map(str::to_string).collect();
				(f.line as usize).checked_sub(1).is_some_and(|i| i < lines.len() && route_step(&lines, i, rr))
			})
	};
	let all: Vec<Finding> = play(tree, data, t).into_iter().filter(|f| !own_walk(f)).collect();
	let new: Vec<(String, u32, String)> = all.iter().filter(|f| !v1_keys.contains(&key_of(f, tree))).map(|f| (f.file.clone(), f.line, f.reason.clone())).collect();
	(new.len(), all.len(), new)
}

#[cfg(test)]
mod tests {
	use super::*;

	fn v(xs: &[&str]) -> Vec<String> {
		xs.iter().map(|s| s.to_string()).collect()
	}
	fn s(xs: &[&str]) -> Vec<String> {
		v(xs)
	}

	#[test]
	fn replaced_travel_before_the_routes_way() {
		let (or, ot) = (s(&["Orc", "Troll"]), s(&["Tauren", "Undead", "Skyborne"]));
		let mut t = v(&[
			"guide x",
			"",
			"step Jediga",
			"  turnin 3565",
			"",
			"step To Grom'gol",
			"  zone Stranglethorn Vale",
			"  goto 32.2,27.7 \"Grom'gol Base Camp\"",
			"",
			"step Fly to Orgrimmar",
			"  only Orc,Troll",
			"  zone Azshara",
			"  fly \"Orgrimmar\"",
			"",
			"step Grom'gol Base Camp",
			"  zone Stranglethorn Vale",
			"  turnin 2932",
			"",
		]);
		assert_eq!(replaced_travel(&mut t, &or, &ot, true), 1);
		assert!(t.contains(&"  goto 32.2,27.7 \"Grom'gol Base Camp\" only Tauren,Undead,Skyborne".to_string()));
		assert!(t.contains(&"  fly \"Orgrimmar\"".to_string()));
		let mut u = v(&["guide x", "", "step Fly", "  only Orc,Troll", "  fly \"Crossroads\"", "", "step Ratchet", "  fly \"Ratchet\"", "", "step Work", "  accept 1", ""]);
		assert_eq!(replaced_travel(&mut u, &or, &ot, true), 0);
	}

	#[test]
	fn emptied_step_is_the_others() {
		let mut t = v(&["step Aerie Peak", "  tip Hearth to Aerie Peak.", "  hearth \"Aerie Peak\" only Dwarf,Gnome,NightElf,Skyborne", "", "step Next", "  accept 1", ""]);
		assert_eq!(hide_emptied(&mut t, &s(&["Human"])), 1);
		assert_eq!(t[..4], v(&["step Aerie Peak", "  only Dwarf,Gnome,NightElf,Skyborne", "  tip Hearth to Aerie Peak.", "  hearth \"Aerie Peak\""]));
	}

	#[test]
	fn zone_named_again_after_only_steps() {
		let mut t = v(&[
			"zone Thunder Bluff",
			"",
			"step Fly to Camp Mojache",
			"  only Orc,Troll",
			"  zone Thunder Bluff",
			"  fly \"Camp Mojache\"",
			"",
			"step Fly to Camp Mojache",
			"  only Tauren,Undead,Skyborne",
			"  zone Feralas",
			"  fly \"Camp Mojache\"",
			"",
			"step The Videre Elixir",
			"  goto 45.1,25.6 \"Gregan Brewspewer\"",
			"",
		]);
		assert_eq!(restate_zones(&mut t, &s(&["Orc", "Troll"])), 1);
		assert_eq!(t[13], "  zone Feralas");
		// A class's trip does not set the zone it is named again with.
		let mut u = v(&["zone Durotar", "", "step Moonglade", "  only Druid", "  zone Moonglade", "  train class", "", "step Next", "  goto 1,1", ""]);
		restate_zones(&mut u, &s(&["Orc", "Troll"]));
		assert_eq!(u[8], "  zone Durotar");
	}

	#[test]
	fn routes_own_event_takes_the_earlier_copy_from_its_races() {
		let mut tree = BTreeMap::new();
		tree.insert("a".to_string(), v(&["guide a", "", "step The Crossroads", "  turnin 875", "  turnin 7", ""]).join("\n"));
		tree.insert("b".to_string(), v(&["guide b", "", "step The Crossroads", "  only Orc,Troll", "  turnin 875", ""]).join("\n"));
		let t = Travel { chain: s(&["a", "b"]), route_races: s(&["Orc", "Troll"]), other_races: s(&["Tauren", "Undead", "Skyborne"]), shared: s(&["a", "b"]), faction: Some("Horde".into()), cls: None };
		assert_eq!(route_events_first(&mut tree, &t), 1);
		assert!(tree["a"].contains("  turnin 875 only Tauren,Undead,Skyborne"));
		assert!(tree["a"].contains("  turnin 7\n"));
	}

	#[test]
	fn route_bind_goes_to_v1s_line() {
		let mut t = v(&[
			"step Ratchet",
			"  fly \"Ratchet\"",
			"  sethome \"Ratchet\" only Tauren,Undead,Skyborne",
			"",
			"step Fly to Camp Taurajo",
			"  fly \"Camp Taurajo\"",
			"",
			"step Shady Rest Inn",
			"  sethome \"Ratchet\" only Orc,Troll",
			"  accept 1251",
			"",
		]);
		assert_eq!(binds_at_v1(&mut t, &s(&["Orc", "Troll"])), 1);
		assert!(t.contains(&"  sethome \"Ratchet\"".to_string()));
		assert!(!t.iter().any(|l| l.contains("only Orc,Troll")));
	}
}
