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
use crate::jsre::{split_comment, starts_nonspace, trim, trim_end};
use crate::post::no_empty_steps;
use crate::re;
use forge_core::jsnum::{js_hypot, js_to_fixed, js_to_string};
use forge_guide::conditions::{class_file_of, same_race, Audience};
use forge_guide::data::Data;
use forge_guide::diag::Diagnostics;
use forge_guide::js::{str_to_num, V};
use forge_guide::project::{resolve_sources, Source};
use forge_judge::honest::{play_chain, play_chain_traced, Finding, Geo, HonestOpts, NodeKey, Persona, Place, Severity, TraceRow, Wpt};
use rustc_hash::FxHashSet;
use std::cell::Cell;
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
/// A flight to a path never learnt whose flight master the chain stood this near earlier learns the
/// path there (forge-sim's NEAR_HUB: a flight master this close is learned).
const PASSED_FP_YD: f64 = 200.0;
/// A flight master whose path they never learnt this near where a leg starts is at hand: the way may
/// learn its path there and fly from it, when that beats the walk to the nearest known one (the Tauren
/// and Skyborne Druids off the zeppelin at Orgrimmar, Doras ~480 yd away, walked ~2,400 yd to
/// Ratchet's flight master for Thunder Bluff and back).
const AT_HAND_YD: f64 = 500.0;

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
	/// The flight leaves from a flight master at hand whose path is learnt there first.
	learn: bool,
}

fn wpt(v: &V) -> Option<Wpt> {
	let c = v.get("c");
	if c.is_nullish() {
		return None;
	}
	Some(Wpt { c: c.num(), wx: v.get("wx").num(), wy: v.get("wy").num() })
}

/// A place walked from or to: its world point and zone map (the zone crossings' rule reads it).
#[derive(Clone, Copy)]
struct At {
	w: Wpt,
	map: u32,
}

fn at_v(v: &V) -> Option<At> {
	wpt(v).map(|w| At { w, map: v.get("map").num() as u32 })
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

/// The flight nodes the repair's characters may use: a class's own node (the Druids' Nighthaven) for
/// that class alone (the played class: a Warrior when none).
fn class_nodes(data: &Data, t: &Travel) -> Vec<V> {
	let cls = t.cls.as_deref().unwrap_or("WARRIOR");
	data.travel.get("taxi").get("nodes").items().into_iter().filter(|n| !n.get("class").truthy() || n.get("class").to_js_string().eq_ignore_ascii_case(cls)).collect()
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
	fn at_pt(&self, p: &Pt) -> Option<At> {
		self.at(p).map(|w| At { w, map: p.map as u32 })
	}
	/// Walking yards from a to b: the walk store's (else the straight line), and never less than the
	/// way over the zone crossings between them (infinite where none joins their zones: no walk from
	/// Azshara into Winterspring).
	fn walk_yd(&self, a: Option<At>, b: Option<At>) -> f64 {
		let y = walk_dist(self.walks, a.map(|x| x.w), b.map(|x| x.w));
		match (a, b, self.walks.and_then(|w| w.borders())) {
			(Some(a), Some(b), Some(bd)) if a.w.c == b.w.c => y.max(bd.walk_yd(a.w.c as i64, (a.w.wx, a.w.wy, a.map), (b.w.wx, b.w.wy, b.map))),
			_ => y,
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
	/// when that is quicker, or from a flight master at hand (`hand`: the paths not learnt) whose path
	/// is learnt there when that is quicker still.
	fn leg(&self, a: Option<At>, b: Option<At>, kn: &[V], hand: &[V]) -> Leg {
		let mut best = Leg { s: self.walk_yd(a, b) / WALK_YPS, fly: None, learn: false };
		let Some(f1) = Self::nearest(kn, b.map(|x| x.w)) else { return best };
		let fly_s = |f0: &V, w0: f64| (w0 + self.walk_yd(at_v(&f1.n), b)) / WALK_YPS + dist(wpt(f0), wpt(&f1.n)) / FLY_YPS + FLY_S;
		if let Some(f0) = Self::nearest(kn, a.map(|x| x.w)).filter(|f0| !same_node(&f0.n, &f1.n)) {
			let s = fly_s(&f0.n, self.walk_yd(a, at_v(&f0.n)));
			if s < best.s {
				best = Leg { s, fly: Some((f0, Near { n: f1.n.clone(), d: f1.d })), learn: false };
			}
		}
		for u in hand {
			let w0 = self.walk_yd(a, at_v(u));
			if w0 > AT_HAND_YD {
				continue;
			}
			let s = fly_s(u, w0);
			if s < best.s {
				best = Leg { s, fly: Some((Near { n: u.clone(), d: dist(a.map(|x| x.w), wpt(u)) }, Near { n: f1.n.clone(), d: f1.d })), learn: true };
			}
		}
		best
	}
	/// The flight from f0 to f1, from `from` (a long walk to the flight master: into its zone first);
	/// `learn`: f0's path is learnt there first.
	fn fly_steps(&self, from: &Pt, (f0, f1): &(Near, Near), learn: bool) -> Vec<WayStep> {
		let mut out = Vec::new();
		let (fx, fy) = (f0.n.get("x").num(), f0.n.get("y").num());
		let z0 = self.zone_of(f0.n.get("map").num());
		// A long walk to the flight master: into its zone first.
		if f0.d > WALK_YD {
			if let Some(z) = &z0 {
				out.extend(self.crossing_steps(from, &Pt { map: f0.n.get("map").num(), x: fx, y: fy, f: "e".into() }));
				let l = format!("To {}", f0.n.get("short").to_js_string());
				out.push(WayStep { title: l.clone(), zone: Some(z.clone()), lines: vec![format!("  goto {} \"{l}\"", Self::xy(fx, fy))] });
			}
		}
		let mut lines = Vec::new();
		let s0 = f0.n.get("short").to_js_string();
		if f0.d > 60.0 || learn {
			lines.push(format!("  goto {} \"{s0} flight master\"", Self::xy(fx, fy)));
		}
		if learn {
			lines.push(format!("  getfp \"{s0}\""));
		}
		lines.push(format!("  fly \"{}\"", f1.n.get("short").to_js_string()));
		out.push(WayStep { title: format!("Fly to {}", f1.n.get("short").to_js_string()), zone: z0, lines });
		out
	}
	/// The zone crossings a walk from a to b passes, as goto steps to their ends in the zones they lead
	/// into (borders.rs), when the straight walk would miss them or is far.
	fn crossing_steps(&self, a: &Pt, b: &Pt) -> Vec<WayStep> {
		let (Some(bd), Some(pa), Some(pb)) = (self.walks.and_then(|w| w.borders()), self.at_pt(a), self.at_pt(b)) else { return Vec::new() };
		if pa.w.c != pb.w.c {
			return Vec::new();
		}
		let pts = bd.waypoints(pa.w.c as i64, (pa.w.wx, pa.w.wy, pa.map), (pb.w.wx, pb.w.wy, pb.map));
		let mut out = Vec::new();
		for (wx, wy, map) in pts {
			// (A crossing a hair outside its zone's map frame cannot be written: c17 Human's "Into
			// Badlands" at 51.7,101.5, refused by the pack check.)
			let Some((x, y)) = self.geo.to_map(map as _, wx, wy, true).filter(|&(x, y)| (0.0..=100.0).contains(&x) && (0.0..=100.0).contains(&y)) else { continue };
			let Some(z) = self.zone_of(map as f64) else { continue };
			let l = format!("Into {z}");
			out.push(WayStep { title: l.clone(), zone: Some(z), lines: vec![format!("  goto {} \"{l}\"", Self::xy(x, y))] });
		}
		out
	}
	fn goto_step(&self, b: &Pt, label: Option<&str>) -> Option<WayStep> {
		let z = self.zone_of(b.map)?;
		let l = label.map_or_else(|| self.dest_label(b, &z), str::to_string);
		Some(WayStep { title: l.clone(), zone: Some(z), lines: vec![format!("  goto {} \"{l}\"{}", Self::xy(b.x, b.y), Self::live(b))] })
	}
	/// A travel-only goto's label, where it leads, never just the zone's name (#1450): the town whose
	/// flight master stands within TOWN_YD of it in its zone ("To Camp Taurajo"), else the zone it
	/// crosses into.
	fn dest_label(&self, b: &Pt, z: &str) -> String {
		const TOWN_YD: f64 = 400.0;
		let at = self.at_pt(b).map(|a| a.w);
		self.nodes
			.iter()
			.filter(|n| n.get("map").num() == b.map)
			.map(|n| (dist(at, wpt(n)), n))
			.filter(|&(d, _)| d <= TOWN_YD)
			.min_by(|a, b| a.0.total_cmp(&b.0))
			.map(|(_, n)| n.get("short").to_js_string())
			.filter(|t| !t.is_empty())
			.map_or_else(|| format!("Into {z}"), |t| format!("To {t}"))
	}
	/// The walk from a to b: over the zone crossings it passes, then to b.
	fn walk_steps(&self, a: &Pt, b: &Pt, label: Option<&str>) -> Vec<WayStep> {
		let mut out = self.crossing_steps(a, b);
		out.extend(self.goto_step(b, label));
		out
	}
	fn same_way(&self, a: &Pt, b: &Pt, kn: &[V], hand: &[V], label: Option<&str>) -> Vec<WayStep> {
		let l = self.leg(self.at_pt(a), self.at_pt(b), kn, hand);
		if let Some(f) = &l.fly {
			return self.fly_steps(a, f, l.learn);
		}
		self.walk_steps(a, b, label)
	}
	/// The quickest way, by a boat or zeppelin between the continents.
	fn way(&self, a: &Pt, b: &Pt, kn: &[V], hand: &[V], label: Option<&str>) -> Vec<WayStep> {
		let (Some(pa), Some(pb)) = (self.at_pt(a), self.at_pt(b)) else { return Vec::new() };
		if pa.w.c == pb.w.c {
			return self.same_way(a, b, kn, hand, label);
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
				if dep.get("c").num() != pa.w.c || arr.get("c").num() != pb.w.c {
					continue;
				}
				let l0 = self.leg(Some(pa), at_v(&dep), kn, hand);
				let l1 = self.leg(at_v(&arr), Some(pb), kn, hand);
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
		let arr = Pt::of_v(&best.arr);
		let mut steps = Vec::new();
		if let Some(f) = &best.l0.fly {
			steps.extend(self.fly_steps(a, f, best.l0.learn));
		} else if dist(Some(pa.w), wpt(&best.dep)) > WALK_YD {
			steps.extend(self.crossing_steps(a, &dep));
			if let Some(s) = self.goto_step(&dep, None) {
				steps.push(s);
			}
		}
		steps.push(WayStep { title: ride.clone(), zone: self.zone_of(dep.map), lines: vec![format!("  goto {} \"{ride}\"{}", Self::xy(dep.x, dep.y), Self::live(&dep))] });
		if let Some(f) = &best.l1.fly {
			steps.extend(self.fly_steps(&arr, f, best.l1.learn));
		} else if dist(wpt(&best.arr), Some(pb.w)) > WALK_YD {
			steps.extend(self.walk_steps(&arr, b, label));
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

/// The characters a repair plays for: the route's races, every class or the one `route_races`
/// names (a class's own way: `Orc,Shaman`).
struct Route<'a> {
	races: Vec<&'a str>,
	class: Option<&'static str>,
}

impl<'a> Route<'a> {
	fn of(route_races: &'a [String]) -> Route<'a> {
		let class = route_races.iter().find_map(|r| class_file_of(r));
		Route { races: route_races.iter().map(String::as_str).filter(|r| class_file_of(r).is_none()).collect(), class }
	}

	/// Some of them are in `a`.
	fn sees(&self, a: &Audience) -> bool {
		self.races.iter().any(|r| a.race_in(r)) && self.class.map_or(a.classes.as_ref().is_none_or(|c| !c.is_empty()), |c| a.class_in(c))
	}

	/// Everyone in `a` is one of them.
	fn holds(&self, a: &Audience) -> bool {
		a.races.as_ref().is_some_and(|rs| rs.iter().all(|r| self.races.iter().any(|x| same_race(x, r))))
			&& self.class.is_none_or(|c| a.classes.as_ref().is_some_and(|cs| !cs.is_empty() && cs.iter().all(|x| *x == c)))
	}
}

/// A line's own `only` list.
fn own_only(line: &str) -> Option<regex::Captures<'_>> {
	re!(r"\sonly\s+([!A-Za-z,]+)\s*$").captures(split_comment(line).0)
}

/// The `only` of line i's step (before its first goal).
fn step_audience(text: &[String], i: usize) -> Audience {
	let mut s = i.min(text.len().saturating_sub(1));
	while s > 0 && !step_re(&text[s]) {
		s -= 1;
	}
	for t in &text[(s + 1).min(i)..i] {
		if let Some(m) = re!(r"^\s+only\s+([!A-Za-z,]+)\s*$").captures(t) {
			return Audience::parse(&m[1]);
		}
		if is_goal(t) {
			break;
		}
	}
	Audience::default()
}

/// Line i for the characters it is not the route's: `only` the others (or None where no other race
/// plays the guide); a line already `only` some races loses the route's. For one class's way the
/// line stays its races' other classes': `only Orc,!Shaman` for the Orc Shamans' (the Orc Warriors'
/// zeppelin to the Undercity stays), beside a line `only` the other races where it has them (two
/// lines, joined by `\n`).
pub fn gate(text: &[String], i: usize, route_races: &[String], other_races: &[String], is_shared: bool) -> Option<String> {
	let line = &text[i];
	let (code, rest) = split_comment(line);
	let route = Route::of(route_races);
	let own = own_only(line);
	let la = own.as_ref().map_or_else(Audience::default, |m| Audience::parse(&m[1]));
	let seen = step_audience(text, i).and(&la);
	if !route.sees(&seen) {
		return Some(line.to_string());
	}
	if route.holds(&seen) {
		return None;
	}
	let head = own.as_ref().map_or(trim_end(code), |m| &code[..m.get(0).unwrap().start()]);
	if let Some(c) = route.class {
		let rs: Vec<String> = seen.races.clone().unwrap_or_else(|| if is_shared { other_races.to_vec() } else { route.races.iter().map(|r| r.to_string()).collect() });
		let (mine, theirs): (Vec<String>, Vec<String>) = rs.into_iter().partition(|r| route.races.iter().any(|x| same_race(x, r)));
		// (Its races only the step's, all the route's: the line names the classes alone.)
		let (step_races, theirs_empty) = (la.races.is_none() && seen.races.is_some(), theirs.is_empty());
		let cs: Vec<&'static str> = seen.classes.clone().unwrap_or_else(|| forge_guide::races::CLASS_FILES.to_vec()).into_iter().filter(|x| *x != c).collect();
		let mut out: Vec<String> = Vec::new();
		for a in [
			(!theirs.is_empty()).then(|| Audience { races: Some(theirs), ..la.clone() }),
			(!mine.is_empty() && !cs.is_empty()).then(|| Audience { races: (!step_races || !theirs_empty).then_some(mine), classes: Some(cs), ..la.clone() }),
		]
		.into_iter()
		.flatten()
		{
			out.push(format!("{head} only {}{rest}", a.render().unwrap_or_default()));
		}
		return (!out.is_empty()).then(|| out.join("\n"));
	}
	match la.races {
		Some(rs) => {
			let keep: Vec<String> = rs.into_iter().filter(|r| !route.races.iter().any(|x| same_race(x, r))).collect();
			if keep.is_empty() {
				return None;
			}
			let list = Audience { races: Some(keep), ..la }.render().unwrap_or_default();
			Some(format!("{head} only {list}{rest}"))
		}
		None if !is_shared || other_races.is_empty() => None,
		None => {
			let list = Audience { races: Some(other_races.to_vec()), ..la }.render().unwrap_or_default();
			Some(format!("{head} only {list}{rest}"))
		}
	}
}

/// Whether a line's own `only` leaves the route's characters out.
fn gated_for(line: &str, route_races: &[String]) -> bool {
	own_only(line).is_some_and(|m| !Route::of(route_races).sees(&Audience::parse(&m[1])))
}

/// Whether line i's step is for some of the route's characters alone (`only` them).
fn route_step(text: &[String], i: usize, route_races: &[String]) -> bool {
	let a = step_audience(text, i);
	a != Audience::default() && Route::of(route_races).holds(&a)
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
	// (With the route's races' own `only`, the step's classes too: the Tauren Druids' walk back to the
	// Crossroads from Dreadmist Peak, not everyone's, Rev14H1 12c.)
	let step_list = text.get(s + 1..step_end.min(text.len())).and_then(|b| b.iter().take_while(|l| !is_goal(l)).find(|l| re!(r"^\s+only\s").is_match(l)).cloned());
	let only: Vec<String> = match (only_route.first(), &step_list) {
		(None, Some(l)) => vec![l.clone()],
		(Some(r), Some(l)) => {
			let list = |x: &str| trim(&re!(r"^\s+only\s+").replace(x, "")).to_string();
			let st = Audience::parse(&list(l));
			match st.classes.as_ref().filter(|_| !st.every_class()) {
				Some(cs) => vec![format!("  only {}", Audience { classes: Some(cs.clone()), ..Audience::parse(&list(r)) }.render().unwrap_or_default())],
				None => only_route.to_vec(),
			}
		}
		_ => only_route.to_vec(),
	};
	let mut block: Vec<String> = Vec::new();
	for st in steps {
		block.push(format!("step {}", st.title));
		block.extend(only.iter().cloned());
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

/// The classes of the trip a player of class `cls` is on at line `i`: the last step before it that
/// they play is some classes' own (v1's Orgrimmar training, `only Warrior,Hunter,...`) while the other
/// classes went their own way meanwhile (steps of theirs alone with travel: the Druids' and Paladins'
/// Thunder Bluff training and flight back to the Crossroads). The way on from where that trip left
/// the player is the trip's classes', not everyone's: everyone's flight from Orgrimmar to the
/// Crossroads was shown to the Druids and Paladins standing there (c19 Horde
/// 30-40/03-arathi-highlands:449, Rev19-H B3).
fn trip_classes(text: &[String], i: usize, cls: &str) -> Option<Vec<&'static str>> {
	let mut s = i.min(text.len().saturating_sub(1));
	while s > 0 && !step_re(&text[s]) {
		s -= 1;
	}
	let mut others: Vec<&'static str> = Vec::new();
	let mut q = prev_step(text, s);
	while let Some(p) = q {
		q = prev_step(text, p);
		let body = &text[p + 1..step_end0(text, p)];
		let goals: Vec<&String> = body.iter().filter(|l| is_goal(l)).collect();
		if goals.is_empty() {
			continue;
		}
		let a = body.iter().take_while(|l| !is_goal(l)).find_map(|l| re!(r"^\s+only\s+([!A-Za-z,]+)\s*$").captures(l).map(|m| Audience::parse(&m[1]))).unwrap_or_default();
		if !a.class_in(cls) {
			if let Some(cs) = a.classes.as_ref().filter(|_| goals.iter().any(|l| re!(r"^\s+(fly|goto|hearth)\s").is_match(l))) {
				others.extend(cs.iter().copied());
			}
			continue;
		}
		let every = a.every_class();
		let cs = a.classes.filter(|_| !every)?;
		return (!others.is_empty() && !cs.iter().any(|c| others.contains(c))).then_some(cs);
	}
	None
}

/// The `only` of the repair's way to line `i` for a player of class `cls`: the route's (`only_route`),
/// narrowed to the classes of the trip that left the player where they are ([`trip_classes`]).
fn way_only(text: &[String], i: usize, cls: &str, only_route: &[String]) -> Vec<String> {
	let Some(cs) = trip_classes(text, i, cls) else { return only_route.to_vec() };
	let base = only_route.first().map_or_else(Audience::default, |r| Audience::parse(trim(&re!(r"^\s+only\s+").replace(r, ""))));
	vec![format!("  only {}", Audience { classes: Some(cs), ..base }.render().unwrap_or_default())]
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
	let a = only_line.map_or_else(Audience::default, |l| Audience::parse(trim(&re!(r"^\s+only\s+").replace(l, ""))));
	let route = Route::of(route_races);
	let visible = route.sees(&a);
	let route_own = route.holds(&a);
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
					let g = gate(text, li, rr, others, is_shared);
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
		let line_own = own_only(&text[i]).is_some_and(|m| Route::of(rr).holds(&Audience::parse(&m[1])));
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
				// (A line gated into two already is done.)
				if texts[fj][k].contains('\n') || event(&texts[fj][k]).as_deref() != Some(e.as_str()) || own(&texts[fj], k) || gated_for(&texts[fj][k], rr) {
					continue;
				}
				if !step_info(&texts[fj], step_of(&texts[fj], k), rr).visible {
					continue;
				}
				match gate(&texts[fj], k, rr, &t.other_races, is_shared) {
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
		// (The zone the step ends in: a flight's step names its landing's zone after the `fly`.)
		let zone = text[s + 1..e].iter().filter_map(|l| re!(r"^\s+zone\s+(.+)$").captures(l).map(|m| trim(&m[1]).to_string())).next_back();
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
			// (Not v1's line in a step the route's characters do not play: everyone's line there still
			// binds only the others; the Night Elves' own Auberdine bind was lost so, Rev15NightElf 24.)
			if !Route::of(rr).sees(&step_audience(text, j)) {
				break;
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
		let rest = || goals[k + 1..].iter().filter(|x| !matches!(x.verb.as_str(), "goto" | "fly" | "hearth" | "getfp" | "sethome" | "note" | "level"));
		// (A flight to a training stop, `train class` with no place of its own, is for it: the flight
		// from Thorium Point to Ironforge's trainers, c17 40-50/06-searing-gorge:221.)
		if rest().next().is_some_and(|x| x.verb == "train" && !x.moved) {
			continue;
		}
		// (Nor one to a boat, tram or portal before the next goal: the way goes on by it, the flight to
		// Rut'theran Village for the Darnassus portal, c17 50-60/04-western-plaguelands:385.)
		let ride = goals[k + 1..]
			.iter()
			.take_while(|x| matches!(x.verb.as_str(), "goto" | "fly" | "hearth" | "getfp" | "sethome" | "note" | "level"))
			.any(|x| x.verb == "goto" && re!(r#"(?i)"[^"]*\b(boat|zeppelin|tram|ship|portal)\b[^"]*""#).is_match(text_at(tree, &x.file, x.line)));
		if ride {
			continue;
		}
		let next = rest().find(|x| x.after.is_some() && x.moved);
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
	/// The last repair's way learnt a flight path at hand.
	learnt: Cell<bool>,
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
			// (On a shared guide, a flight from no flight master is repaired even where v1 has it too: the
			// shared route is the route's, and a start whose v1 broke there kept v1's flight while every
			// other start's way replaced it: c17 30-40/03-ashenvale:81, `fly "Astranaar" only Dwarf` at
			// Maestra's Post after everyone's flight to Astranaar from Nijel's Point.)
			let ours = |f: &Finding| t.cls.is_none() && shared.contains(f.file.as_str()) && f.reason.starts_with("fly to ") && f.reason.contains(" with no flight master where");
			let all: Vec<Finding> =
				play(tree, self.data, t).into_iter().filter(|f| (!self.v1_keys.contains(&key_of(f, tree)) || ours(f)) && f.state.as_ref().is_some_and(|s| s.at.is_some()) && !own_walk(f)).collect();
			let found: Vec<&Finding> = all.iter().filter(|f| !self.tried.contains(&key_of(f, tree))).collect();
			// A flight to a path never learnt, whose flight master the chain stood by earlier: the path is
			// learnt there and the flight stays theirs (the flight path sweep from #939: the Gnome
			// Warlocks boarded the Booty Bay boat at Ratchet's dock, about 100 yd from Bragok, then walked
			// from Theramore to Ratchet for their Felsteed at 44). A round of its own: the lines it adds
			// move the line numbers of the other failures, found again next round.
			let learn = self.passed_flight_masters(tree, &found);
			if !learn.is_empty() {
				let mut by_file: BTreeMap<String, Vec<(u32, String)>> = BTreeMap::new();
				for (key, file, line, l) in learn {
					self.tried.insert(key);
					by_file.entry(file).or_default().push((line, l));
				}
				let mut did = 0;
				for (file, mut ins) in by_file {
					let mut text: Vec<String> = tree[&file].split('\n').map(str::to_string).collect();
					// (From the bottom up: line numbers hold.)
					ins.sort_by(|a, b| b.cmp(a));
					ins.dedup();
					for (line, l) in ins {
						rep.log.push(format!("  {file}:{line} learns the flight path a later flight needs | {}", trim(&l)));
						text.insert(line as usize - 1, l);
						did += 1;
					}
					tree.insert(file, text.join("\n"));
				}
				rep.fixed += did;
				rep.log.push(format!("travel repair round {}: {did} flight paths learnt where the chain stood by their flight masters", rep.rounds));
				continue;
			}
			for f in &found {
				self.tried.insert(key_of(f, tree));
			}
			rep.left = all.iter().map(|f| (f.file.clone(), f.line, f.reason.clone())).collect();
			if found.is_empty() {
				break;
			}
			// One repair per line, each file from the bottom up (line numbers hold). A way that learns a
			// flight path at hand: the failures after it wait for the next round, which plays that path
			// learnt (the Druids' way back from Thunder Bluff to the zeppelin flies to Orgrimmar, whose
			// path their way out learnt off the zeppelin).
			let log0 = rep.log.len();
			let mut upto = found.len();
			let did = loop {
				let (did, learnt, before) = self.repair_some(tree, &found[..upto], &shared, rep);
				match learnt.filter(|&k| k + 1 < upto) {
					Some(k) => {
						tree.extend(before);
						for f in &found[k + 1..upto] {
							self.tried.remove(&key_of(f, tree));
						}
						rep.log.truncate(log0);
						upto = k + 1;
					}
					None => break did,
				}
			};
			rep.fixed += did;
			rep.log.push(format!("travel repair round {}: {upto} new R1 failures, {did} repaired", rep.rounds));
			if did == 0 {
				break;
			}
		}
	}

	/// Each failure `fly to X: its flight path was never learnt` whose flight master X the chain stood
	/// within PASSED_FP_YD of before it (a goal played earlier left the character there): (the
	/// failure's key, the file and line of that goal, the `getfp` line to write before it). A flight in
	/// a shared guide learns its path in a shared guide only (a start's own guide is not kept there).
	fn passed_flight_masters(&self, tree: &BTreeMap<String, String>, found: &[&Finding]) -> Vec<(String, String, u32, String)> {
		let t = self.t;
		let wanted: Vec<(&Finding, String)> = found.iter().filter_map(|f| re!(r"^fly to (.+): its flight path was never learnt$").captures(&f.reason).map(|m| (*f, m[1].to_lowercase()))).collect();
		if wanted.is_empty() {
			return Vec::new();
		}
		let trace = play_traced(tree, self.data, t, true).1;
		let mut out = Vec::new();
		for (f, name) in wanted {
			let ways = &self.ways;
			let Some(node) =
				ways.nodes.iter().find(|x| ways.usable(&x.get("faction")) && (x.get("short").to_js_string().to_lowercase() == name || x.get("name").to_js_string().to_lowercase() == name))
			else {
				continue;
			};
			let Some(k) = trace.iter().position(|r| r.file == f.file && r.line == f.line && r.verb == "fly") else { continue };
			let Some(r) = trace[..k].iter().find(|r| dist(r.after, wpt(node)) <= PASSED_FP_YD) else { continue };
			let shared = t.shared.contains(&r.file);
			if t.shared.contains(&f.file) && !shared {
				continue;
			}
			let only = if shared && !t.other_races.is_empty() { format!(" only {}", t.route_races.join(",")) } else { String::new() };
			out.push((key_of(f, tree), r.file.clone(), r.line, format!("  getfp \"{}\"{only}", node.get("short").to_js_string())));
		}
		out
	}

	/// Repairs `found` (in play order) on `tree`: (the repairs made, the first of `found` whose way
	/// learnt a flight path at hand, the files' texts before).
	fn repair_some(&self, tree: &mut BTreeMap<String, String>, found: &[&Finding], shared: &FxHashSet<&str>, rep: &mut Report) -> (usize, Option<usize>, Vec<(String, String)>) {
		let t = self.t;
		let rr = &t.route_races;
		let mut by_file: Vec<(String, Vec<usize>)> = Vec::new();
		for (k, f) in found.iter().enumerate() {
			let e = match by_file.iter().position(|(file, _)| *file == f.file) {
				Some(i) => i,
				None => {
					by_file.push((f.file.clone(), Vec::new()));
					by_file.len() - 1
				}
			};
			if !by_file[e].1.iter().any(|&g| found[g].line == f.line) {
				by_file[e].1.push(k);
			}
		}
		let (mut did, mut learnt, mut before) = (0, None::<usize>, Vec::new());
		for (file, mut by_line) in by_file {
			let old = tree.get(&file).cloned().unwrap_or_default();
			let mut text: Vec<String> = old.split('\n').map(str::to_string).collect();
			let is_shared = shared.contains(file.as_str());
			let only_route: Vec<String> = if is_shared && !t.other_races.is_empty() { vec![format!("  only {}", rr.join(","))] } else { Vec::new() };
			by_line.sort_by_key(|&k| std::cmp::Reverse(found[k].line));
			for k in by_line {
				self.learnt.set(false);
				did += self.repair_one(&mut text, &file, found[k], is_shared, &only_route, rep);
				if self.learnt.get() {
					learnt = Some(learnt.map_or(k, |l| l.min(k)));
				}
			}
			tree.insert(file.clone(), no_empty_steps(text).join("\n"));
			before.push((file, old));
		}
		(did, learnt, before)
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
		// The flight masters whose paths they have not learnt, for a way that passes one at hand.
		let hand: Vec<V> = ways.nodes.iter().filter(|n| !state.known.contains(&NodeKey::of(&n.get("id"))) && ways.usable(&n.get("faction"))).cloned().collect();
		let learns = |steps: &[WayStep]| steps.iter().any(|s| s.lines.iter().any(|l| l.starts_with("  getfp ")));
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
			let gated = if route_step(text, i, rr) { None } else { gate(text, i, rr, &t.other_races, is_shared) };
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
			// (Only for work of theirs that the flight led to: v1's "Back to the Crossroads" flight, left
			// with the Warlocks' hand-ins alone after the route trained elsewhere, sends no one walking
			// back to the Crossroads from Regthar, Rev14H1 12c.)
			let mut s = i.min(text.len().saturating_sub(1));
			while s > 0 && !step_re(&text[s]) {
				s -= 1;
			}
			let cls = t.cls.as_deref().unwrap_or("WARRIOR");
			let st = step_info(text, s, rr);
			let theirs = step_re(&text[s]) && st.visible && st.goals.iter().any(|l| own_only(l).is_none_or(|m| Audience::parse(&m[1]).class_in(cls)));
			if let Some((d, name)) = dest.filter(|_| theirs) {
				let at = Pt::of_place(state.at.as_ref().unwrap());
				let ins = ways.way(&at, &d, &kn, &hand, Some(&name));
				self.learnt.set(learns(&ins));
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
		let druid = t.cls.as_deref() == Some("DRUID")
			|| only_list(&text[..=i.min(text.len() - 1)].iter().rev().take_while(|l| !step_re(l)).find(|l| re!(r"^\s+only\s").is_match(l)).cloned().unwrap_or_default())
				.is_some_and(|o| o.split(',').all(|c| c.trim() == "Druid"));
		if druid && dz.as_deref() == Some(MOONGLADE) {
			let way = WayStep { title: "Moonglade".into(), zone: Some(MOONGLADE.into()), lines: vec![format!("  goto {MOONGLADE_LANDING} \"Cast Teleport: Moonglade\"")] };
			insert_way(text, i, &[way], only_route, dz.as_deref(), rr);
			return 1;
		}
		let steps = ways.way(&Pt::of_place(state.at.as_ref().unwrap()), &to, &kn, &hand, None);
		self.learnt.set(learns(&steps));
		if steps.is_empty() {
			return 0;
		}
		let only = way_only(text, i, t.cls.as_deref().unwrap_or("WARRIOR"), only_route);
		insert_way(text, i, &steps, &only, dz.as_deref(), rr);
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
	let ways = Ways { data, geo: Geo::new(&data.map_frames), nodes: class_nodes(data, t), side: if t.faction.as_deref() == Some("Alliance") { 1.0 } else { 2.0 }, walks };
	let v1_keys: FxHashSet<String> = play(v1, data, t).iter().map(|f| key_of(f, v1)).collect();
	let rr = t.route_races.clone();
	rep.fixed = pass(tree, t, &mut |text, _| binds_at_v1(text, &rr));
	rep.fixed += route_events_first(tree, t);
	let mut r = Repair { ways, t, data, v1_keys, tried: FxHashSet::default(), learnt: Cell::new(false) };
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
			let g = if route_step(&text, k, &rr) { None } else { gate(&text, k, &rr, &t.other_races, is_shared) };
			if g.as_deref() == Some(text[k].as_str()) {
				continue;
			}
			match g {
				None => {
					text.remove(k);
					// (A flight step left with its flight master's goto alone goes whole: no "Fly to
					// Sentinel Hill" step that walks to the Lakeshire flight master and flies nowhere,
					// c17 05-duskwood:13.)
					let s = (0..k.min(text.len())).rev().find(|&x| step_re(&text[x]));
					if let Some(s) = s.filter(|&s| text[s].starts_with("step Fly to ")) {
						let e = (s + 1..text.len()).find(|&x| step_re(&text[x]) || starts_nonspace(&text[x])).unwrap_or(text.len());
						let goals: Vec<&String> = text[s + 1..e].iter().filter(|l| is_goal(l)).collect();
						if goals.iter().all(|l| re!(r#"^\s+goto\s.*"[^"]* flight master""#).is_match(l)) {
							text.drain(s..e);
						}
					}
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
	let ways = Ways { data, geo: Geo::new(&data.map_frames), nodes: class_nodes(data, t), side: if t.faction.as_deref() == Some("Alliance") { 1.0 } else { 2.0 }, walks };
	let v1_keys: FxHashSet<String> = play(v1, data, t).iter().map(|f| key_of(f, v1)).collect();
	let mut r = Repair { ways, t, data, v1_keys, tried: FxHashSet::default(), learnt: Cell::new(false) };
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

/// How near a travel step's `goto` may end to a flight master of the other faction before the writer
/// warns: the walk from Tarren Mill to Sorrow Hill once ended 42 yd from Chillwind Camp's.
pub const HOSTILE_TOWN_YD: f64 = 120.0;
/// A flight master with one of the route's own faction this near stands in a town both factions use
/// (Booty Bay, Gadgetzan, Everlook): not hostile.
const NEUTRAL_TOWN_YD: f64 = 400.0;
/// A walk that ends this near a goal of the step it leads to ends at that goal's place: Loh'atu, the
/// Horde's quest giver at the Shadowsong Shrine, 36 yd from the Alliance's Talrendis Point.
const AT_GOAL_YD: f64 = 40.0;

/// Travel steps that end in a town of the other faction (the class of #1521 and of the Chillwind Camp
/// waypoint): each `goto` of a step whose goals only travel, within HOSTILE_TOWN_YD of a flight master
/// of the other faction whose town is not neutral, unless it ends at a goal of the step it leads to
/// (`npc_pts`: an accept's giver or a hand-in's ender points; a typed point counts too). Quest goals are
/// left out: a goal stands where its quest is done. A warning for the maintainer, who moves the point
/// with a `way` guide fix (fixes.rs). -> "<file>:<line>: ..." lines.
pub fn hostile_town_ways(tree: &BTreeMap<String, String>, files: &[String], data: &Data, faction: Option<&str>, npc_pts: &dyn Fn(&str) -> Vec<Wpt>) -> Vec<String> {
	let side = match faction.map(str::to_ascii_lowercase).as_deref() {
		Some("alliance") => 1.0,
		Some("horde") => 2.0,
		_ => return Vec::new(),
	};
	let nodes: Vec<(String, f64, Wpt)> = data
		.travel
		.get("taxi")
		.get("nodes")
		.items()
		.iter()
		.map(|n| (n.get("name").to_js_string(), n.get("faction").num(), Wpt { c: n.get("c").num(), wx: n.get("wx").num(), wy: n.get("wy").num() }))
		.collect();
	let hostile = hostile_masters(&nodes, side);
	let geo = Geo::new(&data.map_frames);
	let to_world = |zone: Option<&str>, map: Option<f64>, x: f64, y: f64, live: bool| -> Option<Wpt> {
		let m = map.or_else(|| zone.map(|z| data.zone_named(z).get("zone").get("id")).filter(|id| id.is_num()).map(|id| id.num()))?;
		geo.to_world(m as _, x, y, !live)
	};
	let mut out = Vec::new();
	for f in files {
		let Some(text) = tree.get(f) else { continue };
		for (line, title, yd, name) in ways_near(text, &to_world, npc_pts, &hostile) {
			out.push(format!("{f}:{}: the travel step \"{title}\" ends {yd:.0} yd from the other faction's flight master at {name}", line + 1));
		}
	}
	out
}

/// The flight masters of the other faction than `side` (1 Alliance, 2 Horde) whose towns are not
/// neutral (no flight master of `side` within NEUTRAL_TOWN_YD): (name, point).
fn hostile_masters(nodes: &[(String, f64, Wpt)], side: f64) -> Vec<(String, Wpt)> {
	nodes
		.iter()
		.filter(|(_, f, p)| (*f == 1.0 || *f == 2.0) && *f != side && !nodes.iter().any(|(_, g, q)| *g == side && q.c == p.c && js_hypot(q.wx - p.wx, q.wy - p.wy) <= NEUTRAL_TOWN_YD))
		.map(|(n, _, p)| (n.clone(), *p))
		.collect()
}

/// A guide's travel-only steps' gotos within HOSTILE_TOWN_YD of a `hostile` flight master, each read in
/// the zone its line is in (`to_world`: zone, typed map, x, y, live frame), that do not end at a goal of
/// the next step (its lines' typed points, `npc_pts` for its accepts and hand-ins). -> (line index, step
/// title, yards, the flight master's name).
fn ways_near(
	text: &str,
	to_world: &dyn Fn(Option<&str>, Option<f64>, f64, f64, bool) -> Option<Wpt>,
	npc_pts: &dyn Fn(&str) -> Vec<Wpt>,
	hostile: &[(String, Wpt)],
) -> Vec<(usize, String, f64, String)> {
	let lines: Vec<&str> = text.split('\n').collect();
	let zone_of = |l: &str| re!(r"^\s*zone\s+(.+?)\s*$").captures(split_comment(l).0).map(|m| m[1].to_string());
	let mut out = Vec::new();
	let mut zone: Option<String> = None;
	let mut i = 0;
	while i < lines.len() {
		if !crate::jsre::is_step(lines[i]) {
			zone = zone_of(lines[i]).or(zone);
			i += 1;
			continue;
		}
		let title = trim(lines[i].trim_start_matches("step")).to_string();
		let mut e = i + 1;
		while e < lines.len() && !crate::jsre::is_step(lines[e]) && !starts_nonspace(lines[e]) {
			e += 1;
		}
		let goals: Vec<usize> = (i + 1..e).filter(|&k| is_goal(split_comment(lines[k]).0)).collect();
		let travel = !goals.is_empty() && goals.iter().all(|&k| re!(r"^\s+(goto|fly|hearth)\s").is_match(lines[k]));
		for k in i + 1..e {
			let code = split_comment(lines[k]).0;
			if let Some(z) = zone_of(code) {
				zone = Some(z);
				continue;
			}
			let Some(m) = re!(r"^\s+goto\s+([\d.]+)\s*,\s*([\d.]+)").captures(code).filter(|_| travel) else { continue };
			let Some(p) = typed_at(code, &m, zone.as_deref(), to_world) else { continue };
			let near = hostile.iter().filter(|(_, q)| q.c == p.c).map(|(n, q)| (n, js_hypot(q.wx - p.wx, q.wy - p.wy))).filter(|&(_, d)| d <= HOSTILE_TOWN_YD).min_by(|a, b| a.1.total_cmp(&b.1));
			let Some((name, d)) = near else { continue };
			// (Not when the walk ends at a goal of the step it leads to: the goal is the reason to go.)
			let next_start = (e..lines.len()).find(|&j| crate::jsre::is_step(lines[j]));
			let next_end = next_start.map(|s| (s + 1..lines.len()).find(|&j| crate::jsre::is_step(lines[j]) || starts_nonspace(lines[j])).unwrap_or(lines.len()));
			let mut nz = zone.clone();
			let at_goal = next_start.zip(next_end).is_some_and(|(s, t)| {
				(s + 1..t).any(|j| {
					let c = split_comment(lines[j]).0;
					if let Some(z) = zone_of(c) {
						nz = Some(z);
						return false;
					}
					let typed = re!(r"(?:@\s*|^\s+goto\s+)([\d.]+)\s*,\s*([\d.]+)").captures(c).and_then(|t| typed_at(c, &t, nz.as_deref(), to_world));
					is_goal(c) && typed.into_iter().chain(npc_pts(c)).any(|g| g.c == p.c && js_hypot(g.wx - p.wx, g.wy - p.wy) <= AT_GOAL_YD)
				})
			});
			if !at_goal {
				out.push((k, title.clone(), d, name.clone()));
			}
		}
		i = e;
	}
	out
}

/// The world point a line types (`m`: its x, y captures), read on its typed `map` (outside quoted text)
/// or in `zone`, in the live frame when it says `live`.
fn typed_at(code: &str, m: &regex::Captures, zone: Option<&str>, to_world: &dyn Fn(Option<&str>, Option<f64>, f64, f64, bool) -> Option<Wpt>) -> Option<Wpt> {
	let outside: String = code.split('"').step_by(2).collect::<Vec<_>>().join(" ");
	let map = re!(r"\smap\s+(\d+)").captures(&outside).and_then(|c| c[1].parse::<f64>().ok());
	let live = re!(r"\slive\b").is_match(&outside);
	to_world(zone, map, m[1].parse().ok()?, m[2].parse().ok()?, live)
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
	fn a_way_into_a_class_step_on_a_shared_guide_keeps_the_steps_classes() {
		// Rev14H1 12c: the Tauren Druids' walk back to the Crossroads (written for the route's races on the
		// shared Barrens) lost the step's `only Tauren,Druid`: everyone walked Regthar - Crossroads - Barak.
		let mut t = v(&["step Dreadmist Peak", "  only Tauren,Druid", "  fly \"Crossroads\"", "  turnin 6127", ""]);
		let way = WayStep { title: "Crossroads".into(), zone: Some("The Barrens".into()), lines: vec!["  goto 51.5,30.4 \"Crossroads\"".into()] };
		insert_way(&mut t, 3, &[way], &s(&["  only Tauren"]), Some("The Barrens"), &s(&["Tauren"]));
		let w = t.iter().position(|l| l == "step Crossroads").unwrap();
		assert_eq!(t[w + 1], "  only Tauren,Druid", "{t:#?}");
	}

	#[test]
	fn a_class_way_keeps_its_races_step_for_their_other_classes() {
		// c14 05-stonetalon: the Orc Shamans' way replaced the Orcs' zeppelin to the Undercity, read as
		// theirs alone; the plain Orc Warriors and Hunters were left with no way to Silverpine.
		let t = v(&["step Zeppelin to Undercity", "  only Orc", "  goto 50.8,13.5 \"Zeppelin to Undercity\"", ""]);
		let (shaman, all) = (s(&["Orc", "Shaman"]), s(&["Orc", "Troll", "Tauren", "Undead", "Skyborne"]));
		assert!(!route_step(&t, 2, &shaman) && route_step(&t, 2, &s(&["Orc"])));
		assert_eq!(gate(&t, 2, &shaman, &all, true).as_deref(), Some("  goto 50.8,13.5 \"Zeppelin to Undercity\" only !Shaman"));
		// (Then the Hunters' way: the line stays the Warriors', the Shamans' and Hunters' gone.)
		let t2 = v(&["step Zeppelin to Undercity", "  only Orc", "  goto 50.8,13.5 \"Zeppelin to Undercity\" only !Shaman", ""]);
		assert!(gated_for(&t2[2], &shaman) && !gated_for(&t2[2], &s(&["Orc", "Hunter"])));
		assert_eq!(gate(&t2, 2, &s(&["Orc", "Hunter"]), &all, true).as_deref(), Some("  goto 50.8,13.5 \"Zeppelin to Undercity\" only Warrior,Paladin,Rogue,Priest,Mage,Warlock,Druid"));
		// (A line for everyone: the other races' and the Orcs' other classes'.)
		let t3 = v(&["step Durotar", "  goto 50.7,12.9 \"Durotar\""]);
		assert_eq!(gate(&t3, 1, &shaman, &all, true).as_deref(), Some("  goto 50.7,12.9 \"Durotar\" only Troll,Tauren,Undead,Skyborne\n  goto 50.7,12.9 \"Durotar\" only Orc,!Shaman"));
		let lines = "step Durotar\n  goto 50.7,12.9 \"Durotar\" only Orc,!Shaman\n  goto 50.7,12.9 \"Durotar\" only Troll,!Shaman\n  goto 50.7,12.9 \"Durotar\" only Undead";
		assert_eq!(crate::shared::merge_gated_lines(lines), "step Durotar\n  goto 50.7,12.9 \"Durotar\" only Orc,Troll,!Shaman\n  goto 50.7,12.9 \"Durotar\" only Undead");
	}

	#[test]
	fn the_way_on_from_a_class_trip_is_that_trips_classes() {
		// c19 Horde 30-40/03-arathi-highlands:449: the Orgrimmar training for most classes, the Druids'
		// and Paladins' Thunder Bluff training and flight back to the Crossroads; the repair's flight from
		// Orgrimmar to the Crossroads for Regthar was everyone's, shown to the Druids and Paladins there.
		let t = v(&[
			"step Orgrimmar",
			"  only Warrior,Hunter,Rogue,Priest,Shaman,Mage,Warlock",
			"  zone Orgrimmar",
			"  train class",
			"",
			"step Thunder Bluff",
			"  only Druid,Paladin",
			"  zone Thunder Bluff",
			"  fly \"Thunder Bluff\"",
			"  train class",
			"",
			"step Back to Crossroads",
			"  only Druid,Paladin",
			"  zone Thunder Bluff",
			"  goto 46.7,49.9 \"Thunder Bluff flight master\"",
			"  fly \"Crossroads\"",
			"",
			"step Regthar Deathgate",
			"  zone The Barrens",
			"  turnin 1361",
		]);
		assert_eq!(way_only(&t, 19, "WARRIOR", &s(&["  only Orc"])), s(&["  only Orc,Warrior,Hunter,Rogue,Priest,Shaman,Mage,Warlock"]));
		assert_eq!(way_only(&t, 19, "WARRIOR", &[]), s(&["  only Warrior,Hunter,Rogue,Priest,Shaman,Mage,Warlock"]));
		// (No other class went its own way: everyone's.)
		let t2 = v(&["step Orgrimmar", "  only Warrior", "  train class", "", "step Regthar Deathgate", "  zone The Barrens", "  turnin 1361"]);
		assert_eq!(way_only(&t2, 6, "WARRIOR", &s(&["  only Orc"])), s(&["  only Orc"]));
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
		let t =
			Travel { chain: s(&["a", "b"]), route_races: s(&["Orc", "Troll"]), other_races: s(&["Tauren", "Undead", "Skyborne"]), shared: s(&["a", "b"]), faction: Some("Horde".into()), cls: None };
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

	#[test]
	fn the_routes_bind_stays_when_v1s_line_is_in_a_step_for_the_others_only() {
		// Rev15NightElf (24): v1's Auberdine sethome sat in v1's step left to the other starts
		// (`only Human,Dwarf,Gnome,Skyborne`); made everyone's there, it still bound only them, and the
		// Night Elves' own bind went.
		let mut t = s(&[
			"step Auberdine",
			"  only Human,Dwarf,Gnome,Skyborne",
			"  accept 3524",
			"  sethome \"Auberdine\" only Human,Dwarf,Gnome,Skyborne",
			"",
			"step Auberdine",
			"  accept 4811",
			"  sethome \"Auberdine\" only NightElf",
			"",
		]);
		assert_eq!(binds_at_v1(&mut t, &s(&["NightElf"])), 0);
		assert!(t.contains(&"  sethome \"Auberdine\" only NightElf".to_string()), "{t:#?}");
	}

	#[test]
	fn a_travel_step_into_a_town_of_the_other_faction_is_warned_about() {
		// The walk from Tarren Mill toward Sorrow Hill ended on Argent Officer Pureheart in the middle
		// of the Alliance's Chillwind Camp, 42 yd from its flight master; a quest goal there is the
		// quest's own place and is not warned about, nor is a walk that ends at the next step's quest
		// giver (Loh'atu, 36 yd from the Alliance's Talrendis Point). A map percent is 100 yd here.
		let at = |x: f64, y: f64| Wpt { c: 0.0, wx: x * 100.0, wy: y * 100.0 };
		let to_world =
			|zone: Option<&str>, map: Option<f64>, x: f64, y: f64, _live: bool| -> Option<Wpt> { (matches!(zone, Some("Western Plaguelands" | "Azshara")) || map == Some(1422.0)).then(|| at(x, y)) };
		let npc_pts = |c: &str| -> Vec<Wpt> {
			if c.contains("turnin 5152") {
				vec![at(49.17, 78.57)]
			} else if c.contains("accept 5535") {
				vec![at(11.37, 78.17)]
			} else {
				Vec::new()
			}
		};
		let nodes = vec![
			("Chillwind Camp, Western Plaguelands".to_string(), 1.0, at(43.4, 83.3)),
			("Talrendis Point, Azshara".to_string(), 1.0, at(11.6, 78.0)),
			("Gadgetzan, Tanaris (A)".to_string(), 1.0, at(10.0, 10.0)),
			("Gadgetzan, Tanaris (H)".to_string(), 2.0, at(12.0, 10.0)),
			("Ratchet, The Barrens".to_string(), 3.0, at(50.0, 50.0)),
		];
		// (Gadgetzan has a Horde flight master beside the Alliance one: a town both use.)
		let hostile = hostile_masters(&nodes, 2.0);
		assert_eq!(hostile.iter().map(|h| h.0.as_str()).collect::<Vec<_>>(), ["Chillwind Camp, Western Plaguelands", "Talrendis Point, Azshara"]);
		let text = "guide g\nzone Hillsbrad Foothills\n\nstep Fly to Tarren Mill\n  goto 60.2,18.8 \"Tarren Mill flight master\"\n  fly \"Tarren Mill\"\n\nstep Western Plaguelands\n  zone Western Plaguelands\n  goto 43.0,83.5 \"Western Plaguelands\"\n\nstep Sorrow Hill\n  turnin 5152\n\nstep Argent Officer Pureheart\n  goto 43.0,83.5\n  turnin 5142\n\nstep Azshara\n  zone Azshara\n  goto 11.4,78.2 \"Loh'atu\"\n\nstep Ride into Azshara\n  accept 5535\n";
		let found = ways_near(text, &to_world, &npc_pts, &hostile);
		assert_eq!(found.len(), 1, "{found:?}");
		let (line, title, yd, name) = &found[0];
		assert_eq!((*line, title.as_str(), name.as_str()), (9, "Western Plaguelands", "Chillwind Camp, Western Plaguelands"));
		assert!((*yd - 44.7).abs() < 0.1, "{yd}");
	}
}
