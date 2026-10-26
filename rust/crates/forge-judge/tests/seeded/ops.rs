//! Defect classes and the mutation operators that seed them into golden guides.
//!
//! A [`Model`] is the baseline guide set read line by line (steps, goals, the zone each line is in, the
//! place and level of each step from the baseline guide-text walk). Each class's [`cands`] lists every
//! site the operator applies to, as a closure that edits an [`Ed`] (the guide files as lines that remember
//! their baseline line number) and says what it did. The edited lines are marked: the site is the steps
//! holding them (plus `spill` following steps, for a defect that shows at the next move).

use super::harness::{Prepared, Shared};
use forge_core::{class_by_file, ALL_CLASSES};
use forge_judge::walk::{self, WPt, WalkGoal};
use forge_world::data::Quest;
use rustc_hash::{FxHashMap, FxHashSet};
use std::collections::BTreeMap;

/// (id, defect class, where it comes from, the check meant to catch it).
pub const CLASSES: [(&str, &str, &str, &str); 29] = [
	("travel", "missing travel line (fly/hearth/walk to a new zone deleted)", "R1; review bad travel", "R1"),
	("itemstart", "item-started accept without the item (its collect deleted)", "R2", "R2"),
	("unsourced", "collect moved away from every source of its item", "R3; review missing step", "R3"),
	("giver", "accept/turn-in at the wrong NPC (`npc` of another quest)", "R4; review wrong data/giver", "R4"),
	("required", "required objective step deleted", "R5; review missing step", "R5"),
	("gating", "class/race `only` removed from a gated quest", "R6", "R6"),
	("count", "goal count x(N+2) against the data's N", "R7; review wrong count", "R7"),
	("textnum", "tip with a wrong count or quest level", "R7; review wordiness", "R7"),
	("levelgate", "second level gate with no quest work between", "R8", "R8"),
	("log20", "accepts pulled forward until the log holds >20", "R9", "R9"),
	("noturnin", "turn-in deleted (accepted, never turned in)", "R10", "R10"),
	("pingpong", "turn-in moved after the route left: a revisit", "§0.1 ping-pong; review wrong order", "returns"),
	("trainer", "class trainer visit at a far trainer, not the nearest", "§0.2 non-nearest trainer", "-"),
	("talkafter", "`talk` to the quest NPC after the quest is credited", "§0.3 talk after credit; review repair made it worse", "-"),
	("gatedwalk", "walk to a place whose only step is `when group`", "§0.4 gated-purpose walk", "-"),
	("rare", "required kill of a rare spawn", "§0.5 rare-spawn required collect", "-"),
	("deathskip", "deathskip inserted before a long move", "§0.6 deathskip", "-"),
	("nofp", "getfp deleted before a flight from/to it", "§0.6 unlearned flight path", "R1"),
	("hearthwalk", "hearth away, then walk back", "§0.6 hearth-then-walk", "-"),
	("grind", "level gate 2 levels above the route (long grind)", "§0.7 long grind; review grinding", "-"),
	("classchain", "class quest chain dropped", "§0.8 dropped class chain; review missing step", "passedby"),
	("tip", "tip copied from a step 40+ steps away", "§0.9 wordiness/wrong tips", "-"),
	("levelcap", "level gate past the beta cap (30+27688)", "§0.10 level-cap blocker", "-"),
	("acceptlate", "accept moved after its quest's work", "review wrong order", "R5"),
	("offspawn", "goal coordinates moved 15 map units off the spawns", "review wrong place", "lint"),
	("duplicate", "goal (buy/collect/train) repeated in the next step", "review repeated/redundant", "-"),
	("elite", "required kill of an elite", "review elite/group content solo", "-"),
	("early", "accept moved to an earlier visit below its level", "review over-level; wrong order", "-"),
	("dropquest", "solo quest on the route dropped (all its lines)", "review missing step; passed-by", "passedby"),
];

pub const GOAL_VERBS: [&str; 31] = [
	"accept", "turnin", "complete", "abandon", "destroy", "kill", "collect", "goto", "talk", "interact", "use", "sethome", "hearth", "die", "getfp", "fly", "enter", "train", "buy", "vendor", "level",
	"money", "task", "note", "skill", "learn", "cast", "craft", "rep", "explore", "achieve",
];
const WORK: [&str; 5] = ["kill", "collect", "interact", "use", "complete"];

/// A goal line, as written.
#[derive(Clone, Debug, Default)]
pub struct G {
	pub verb: String,
	pub id: Option<i64>,
	pub quest: Option<u32>,
	pub oi: Option<u32>,
	pub count: Option<u32>,
	pub at: Option<(f64, f64)>,
	pub xy: Option<(f64, f64)>,
	pub map_mod: bool,
	pub only: bool,
	pub only_list: Option<String>,
	pub optional: bool,
	pub giver_mod: bool,
	pub label: Option<String>,
}

pub struct BLine {
	pub ln: u32,
	pub text: String,
	pub step: Option<usize>,
	pub g: Option<G>,
	/// The `zone` in force at this line.
	pub zone: String,
	/// A goal line the played character (Warrior of the chain's race) has: its own and its step's `only` fit.
	pub fits: bool,
}

pub struct BStep {
	pub file: usize,
	pub start: u32,
	pub end: u32,
	/// The step's last non-blank, non-comment line.
	pub last: u32,
	pub title: String,
	pub goals: Vec<u32>,
	pub only_line: Option<u32>,
	/// The step's `only` (if any) fits the played character.
	pub open: bool,
	pub tips: Vec<u32>,
	pub has_zone: bool,
	pub pos: Option<WPt>,
	pub lvl: f64,
}

pub struct Model {
	pub files: Vec<String>,
	pub lines: Vec<Vec<BLine>>,
	pub steps: Vec<BStep>,
	/// Baseline guide-text goals (every goal, levels and places).
	pub goals: Vec<WalkGoal>,
}

fn tokens(code: &str) -> Vec<String> {
	let mut out = Vec::new();
	let mut cur = String::new();
	let mut q = false;
	for c in code.chars() {
		match c {
			'"' => {
				cur.push(c);
				if q {
					out.push(std::mem::take(&mut cur));
				}
				q = !q;
			}
			c if c.is_whitespace() && !q => {
				if !cur.is_empty() {
					out.push(std::mem::take(&mut cur));
				}
			}
			c => cur.push(c),
		}
	}
	if !cur.is_empty() {
		out.push(cur);
	}
	out
}

fn code_part(text: &str) -> (&str, &str) {
	match text.find(" --") {
		Some(i) => (&text[..i], &text[i..]),
		None => (text, ""),
	}
}

fn xy(s: &str) -> Option<(f64, f64)> {
	let (a, b) = s.split_once(',')?;
	Some((a.parse().ok()?, b.parse().ok()?))
}

pub fn parse_goal(text: &str) -> Option<G> {
	if !text.starts_with(char::is_whitespace) {
		return None;
	}
	let (code, _) = code_part(text.trim());
	let t = tokens(code);
	let verb = t.first()?.to_lowercase();
	if !GOAL_VERBS.contains(&verb.as_str()) {
		return None;
	}
	let mut g = G { verb: verb.clone(), ..G::default() };
	if let Some(a) = t.get(1) {
		g.id = a.parse().ok();
		if verb == "goto" {
			g.xy = xy(a);
		}
	}
	if matches!(verb.as_str(), "accept" | "turnin" | "complete" | "abandon") {
		g.quest = g.id.map(|q| q as u32);
	}
	let mut i = 1;
	while i < t.len() {
		let w = t[i].as_str();
		match w {
			"quest" => {
				if let Some(v) = t.get(i + 1) {
					let (q, o) = v.split_once('.').map_or((v.as_str(), None), |(a, b)| (a, Some(b)));
					g.quest = q.parse().ok();
					g.oi = o.and_then(|o| o.parse().ok());
				}
			}
			"map" => g.map_mod = true,
			"only" => {
				g.only = true;
				// `only A, B` or `only A,B`: the comma list runs on while items end with a comma.
				let mut list = String::new();
				let mut k = i + 1;
				while let Some(v) = t.get(k) {
					list.push_str(v);
					k += 1;
					if !v.ends_with(',') {
						break;
					}
				}
				g.only_list = Some(list);
			}
			"optional" => g.optional = true,
			"npc" | "object" | "item" if matches!(verb.as_str(), "accept" | "turnin") && i > 1 => g.giver_mod = true,
			_ => {
				if let Some(n) = w.strip_prefix('x').and_then(|n| n.parse().ok()) {
					g.count = Some(n);
				} else if let Some(p) = w.strip_prefix('@') {
					g.at = xy(p);
				} else if w.starts_with('"') && g.label.is_none() {
					g.label = Some(w.trim_matches('"').to_string());
				}
			}
		}
		i += 1;
	}
	Some(g)
}

impl Model {
	pub fn new(files: &[String], texts: &[String], goals: Vec<WalkGoal>, race: &str, faction: &str) -> Model {
		let mut place: FxHashMap<(&str, u32), (Option<WPt>, f64)> = FxHashMap::default();
		for g in &goals {
			if let Some(l) = g.line {
				place.entry((g.file.as_str(), l)).or_insert((g.w.or(g.pos), g.lvl));
			}
		}
		let mut lines = Vec::new();
		let mut steps: Vec<BStep> = Vec::new();
		let mut last_lvl = 1.0;
		let mut last_pos = None;
		for (fi, text) in texts.iter().enumerate() {
			let mut out: Vec<BLine> = Vec::new();
			let mut zone = String::new();
			let mut cur: Option<usize> = None;
			for (i, raw) in text.split('\n').enumerate() {
				let ln = i as u32 + 1;
				let trimmed = raw.trim();
				if raw.starts_with("step") && (raw.len() == 4 || raw[4..].starts_with(char::is_whitespace)) {
					if let Some(c) = cur {
						steps[c].end = ln - 1;
					}
					steps.push(BStep {
						file: fi,
						start: ln,
						end: ln,
						last: ln,
						title: raw[4..].trim().to_string(),
						goals: vec![],
						only_line: None,
						open: true,
						tips: vec![],
						has_zone: false,
						pos: None,
						lvl: last_lvl,
					});
					cur = Some(steps.len() - 1);
				} else if raw.starts_with("zone") {
					zone = trimmed.to_string();
				}
				let g = if cur.is_some() { parse_goal(raw) } else { None };
				if let Some(c) = cur {
					let s = &mut steps[c];
					if !trimmed.is_empty() && !trimmed.starts_with('#') {
						s.last = ln;
					}
					let first = trimmed.split_whitespace().next().unwrap_or("");
					match first {
						"zone" if raw.starts_with(char::is_whitespace) => {
							zone = trimmed.to_string();
							s.has_zone = true;
						}
						"only" => s.only_line = Some(ln),
						"tip" => s.tips.push(ln),
						_ => {}
					}
					if g.is_some() {
						s.goals.push(ln);
						if s.pos.is_none() {
							if let Some(&(p, l)) = place.get(&(files[fi].as_str(), ln)) {
								s.pos = p;
								s.lvl = l;
								last_lvl = l;
							}
						}
					}
				}
				let fits = g.as_ref().is_some_and(|g| g.only_list.as_deref().is_none_or(|l| only_fits(l, race, faction)));
				out.push(BLine { ln, text: raw.to_string(), step: cur, g, zone: zone.clone(), fits });
			}
			if let Some(c) = cur {
				steps[c].end = out.len() as u32;
			}
			lines.push(out);
		}
		for s in &mut steps {
			if let Some(ol) = s.only_line {
				let t = lines[s.file][ol as usize - 1].text.trim().trim_start_matches("only").trim().to_string();
				s.open = only_fits(&t, race, faction);
				for &g in &s.goals {
					lines[s.file][g as usize - 1].fits &= s.open;
				}
			}
		}
		for s in &mut steps {
			if s.pos.is_none() {
				s.pos = last_pos;
			}
			last_pos = s.pos;
		}
		Model { files: files.to_vec(), lines, steps, goals }
	}

	pub fn line(&self, f: usize, ln: u32) -> &BLine {
		&self.lines[f][ln as usize - 1]
	}

	/// Goal lines in chain order: (file, line, goal, step).
	pub fn goal_lines(&self) -> impl Iterator<Item = (usize, u32, &G, usize)> + '_ {
		self.steps.iter().enumerate().flat_map(move |(si, s)| s.goals.iter().map(move |&ln| (s.file, ln, self.line(s.file, ln).g.as_ref().unwrap(), si)))
	}

	/// Goal lines the played character has.
	pub fn open_lines(&self) -> impl Iterator<Item = (usize, u32, &G, usize)> + '_ {
		self.goal_lines().filter(|(f, ln, _, _)| self.line(*f, *ln).fits)
	}

	pub fn quest_lines(&self, q: u32) -> Vec<(usize, u32, &G, usize)> {
		self.open_lines().filter(|(_, _, g, _)| g.quest == Some(q)).collect()
	}
}

/// `only` (a comma list) holds for a Warrior of `race` on `faction`: each group named (classes, races,
/// factions) must hold; `!x` excludes.
pub fn only_fits(list: &str, race: &str, faction: &str) -> bool {
	const CLASSES_: [&str; 9] = ["warrior", "paladin", "hunter", "rogue", "priest", "shaman", "mage", "warlock", "druid"];
	const RACES: [&str; 11] = ["human", "dwarf", "gnome", "nightelf", "orc", "troll", "tauren", "undead", "scourge", "skyborne", "night elf"];
	let (mut cls, mut rc, mut fc) = (Vec::new(), Vec::new(), Vec::new());
	let race = race.to_lowercase();
	for item in list.split(',').map(|s| s.trim().to_lowercase()).filter(|s| !s.is_empty()) {
		let (neg, name) = item.strip_prefix('!').map_or((false, item.as_str()), |n| (true, n));
		let name = name.split_whitespace().next().unwrap_or("");
		if neg {
			if name == "warrior" || name == race || name == faction.to_lowercase() {
				return false;
			}
			continue;
		}
		if CLASSES_.contains(&name) {
			cls.push(name.to_string());
		} else if RACES.contains(&name) {
			rc.push(name.to_string());
		} else if name == "horde" || name == "alliance" {
			fc.push(name.to_string());
		}
	}
	(cls.is_empty() || cls.iter().any(|c| c == "warrior")) && (rc.is_empty() || rc.contains(&race)) && (fc.is_empty() || fc.contains(&faction.to_lowercase()))
}

pub fn dist(a: &WPt, b: &WPt) -> f64 {
	if a.c != b.c {
		f64::INFINITY
	} else {
		(a.wx - b.wx).hypot(a.wy - b.wy)
	}
}

/// One line of an edited file: its text, the baseline line it came from, whether the edit touched it.
#[derive(Clone, Debug)]
pub struct Line {
	pub text: String,
	pub origin: Option<u32>,
	pub mark: bool,
}

/// Edits on the baseline files.
pub struct Ed<'a> {
	pub m: &'a Model,
	pub files: BTreeMap<usize, Vec<Line>>,
	gone: FxHashSet<(usize, u32)>,
}

impl<'a> Ed<'a> {
	pub fn new(m: &'a Model) -> Ed<'a> {
		Ed { m, files: BTreeMap::new(), gone: FxHashSet::default() }
	}
	fn file(&mut self, f: usize) -> &mut Vec<Line> {
		let m = self.m;
		self.files.entry(f).or_insert_with(|| m.lines[f].iter().map(|l| Line { text: l.text.clone(), origin: Some(l.ln), mark: false }).collect())
	}
	/// The index of baseline line `ln`, else of the nearest line above it still there.
	fn idx(&mut self, f: usize, ln: u32) -> usize {
		let v = self.file(f);
		v.iter().rposition(|l| l.origin.is_some_and(|o| o <= ln)).unwrap_or(0)
	}
	pub fn mark(&mut self, f: usize, ln: u32) {
		let i = self.idx(f, ln);
		self.file(f)[i].mark = true;
	}
	pub fn replace(&mut self, f: usize, ln: u32, text: String) {
		let i = self.idx(f, ln);
		let l = &mut self.file(f)[i];
		l.text = text;
		l.mark = true;
	}
	pub fn insert_after(&mut self, f: usize, ln: u32, lines: &[String]) {
		let i = self.idx(f, ln) + 1;
		let v = self.file(f);
		for (k, t) in lines.iter().enumerate() {
			v.insert(i + k, Line { text: t.clone(), origin: None, mark: !t.is_empty() });
		}
	}
	pub fn insert_before(&mut self, f: usize, ln: u32, lines: &[String]) {
		let v = self.file(f);
		let i = v.iter().position(|l| l.origin.is_some_and(|o| o >= ln)).unwrap_or(v.len());
		for (k, t) in lines.iter().enumerate() {
			v.insert(i + k, Line { text: t.clone(), origin: None, mark: !t.is_empty() });
		}
	}
	/// Delete a line; the lines either side are marked (the deletion point).
	pub fn remove(&mut self, f: usize, ln: u32) {
		if !self.gone.insert((f, ln)) {
			return;
		}
		let v = self.file(f);
		let Some(i) = v.iter().position(|l| l.origin == Some(ln)) else { return };
		v.remove(i);
		if i > 0 {
			v[i - 1].mark = true;
		}
		if i < v.len() {
			v[i].mark = true;
		}
	}
	/// Delete a goal line, and its whole step when no goal is left in it.
	pub fn delete_goal(&mut self, f: usize, ln: u32) {
		self.remove(f, ln);
		let Some(si) = self.m.line(f, ln).step else { return };
		let s = &self.m.steps[si];
		if s.goals.iter().all(|g| self.gone.contains(&(f, *g))) {
			for l in s.start..=s.end {
				self.remove(f, l);
			}
		}
	}
	pub fn into_files(self) -> Vec<(usize, Vec<Line>)> {
		self.files.into_iter().collect()
	}
}

/// What an operator did at a site.
pub struct Info {
	pub desc: String,
	pub quests: Vec<u32>,
	pub spill: usize,
}

pub type Apply<'a> = Box<dyn Fn(&mut Ed<'a>) -> Option<Info> + 'a>;

/// A site: its priority group (0 first) and the edit.
pub struct Cand<'a> {
	pub pri: u8,
	pub apply: Apply<'a>,
}

pub struct Cx<'a> {
	pub m: &'a Model,
	pub sh: &'a Shared,
	pub prep: &'a Prepared,
}

fn info(desc: String, quests: Vec<u32>, spill: usize) -> Option<Info> {
	Some(Info { desc, quests, spill })
}

/// Add modifiers before a line's `--` comment.
fn add_mod(text: &str, m: &str) -> String {
	let (code, rest) = code_part(text);
	format!("{} {m}{rest}", code.trim_end())
}

fn strip_tokens(text: &str, drop: &dyn Fn(&str, Option<&str>) -> usize) -> String {
	let (code, rest) = code_part(text);
	let indent: String = code.chars().take_while(|c| c.is_whitespace()).collect();
	let t = tokens(code);
	let mut out = Vec::new();
	let mut i = 0;
	while i < t.len() {
		let n = if i == 0 { 0 } else { drop(&t[i], t.get(i + 1).map(String::as_str)) };
		if n == 0 {
			out.push(t[i].clone());
			i += 1;
		} else {
			i += n;
		}
	}
	format!("{indent}{}{rest}", out.join(" "))
}

/// A record's era-frame spawn points: (map, x, y, world point).
fn era_spawns<'e>(cx: &Cx, rec: &'e forge_world::data::Entity) -> Vec<(&'e u32, f64, f64, WPt)> {
	let mut out = Vec::new();
	for (map, sp) in &rec.spawns {
		if sp.f.as_deref().is_some_and(|f| !f.is_empty() && f != "e") {
			continue;
		}
		for p in sp.pts.iter().take(20) {
			let (Some(&x), Some(&y)) = (p.first(), p.get(1)) else { continue };
			let w = cx.sh.proj.point(*map, x, y, Some(forge_core::Frame::Era));
			if w.wx.is_finite() {
				out.push((map, x, y, WPt { c: w.c, wx: w.wx, wy: w.wy, map: *map }));
			}
		}
	}
	out
}

fn npc_pts(cx: &Cx, id: u32) -> Vec<WPt> {
	forge_judge::passedby::spawn_points(cx.sh.d.npcs.get(&id), &cx.sh.proj, 60).into_iter().map(|(c, wx, wy, map)| WPt { c, wx, wy, map }).collect()
}

fn obj_pts(cx: &Cx, id: u32) -> Vec<WPt> {
	forge_judge::passedby::spawn_points(cx.sh.d.objects.get(&id), &cx.sh.proj, 60).into_iter().map(|(c, wx, wy, map)| WPt { c, wx, wy, map }).collect()
}

fn item_sources(cx: &Cx, item: u32) -> Vec<WPt> {
	let Some(it) = cx.sh.d.items.get(&item) else { return vec![] };
	let mut out = Vec::new();
	if let Some(d) = &it.drops {
		for &n in d.npc.keys() {
			out.extend(npc_pts(cx, n));
		}
		for &o in d.object.keys() {
			out.extend(obj_pts(cx, o));
		}
	}
	for &v in it.vendors.iter().flatten() {
		out.extend(npc_pts(cx, v as u32));
	}
	out
}

fn near(p: &WPt, pts: &[WPt]) -> f64 {
	pts.iter().map(|q| dist(p, q)).fold(f64::INFINITY, f64::min)
}

fn quest<'a>(cx: &Cx<'a>, q: u32) -> Option<&'a Quest> {
	cx.sh.d.quests.get(&q)
}

/// A class quest of the Warrior: its class mask names the Warrior and at most two other classes.
fn warrior_only(r: &Quest) -> bool {
	let c = r.classes.unwrap_or(0.0) as u32 & ALL_CLASSES;
	let w = class_by_file("WARRIOR").map_or(1, |c| c.bit);
	c != 0 && c & w != 0 && c.count_ones() <= 3
}

fn ind(s: &str) -> String {
	format!("  {s}")
}

fn s(x: &str) -> String {
	x.to_string()
}

fn later(a: (usize, u32), b: (usize, u32)) -> bool {
	b > a
}

/// The sites of class `class` in this guide set.
pub fn cands<'a>(cx: &'a Cx<'a>, class: usize) -> Vec<Cand<'a>> {
	let m = cx.m;
	let mut out: Vec<Cand<'a>> = Vec::new();
	let mut push = |pri: u8, f: Apply<'a>| out.push(Cand { pri, apply: f });
	let steps = &m.steps;
	let fname = move |f: usize| m.files[f].clone();
	match CLASSES[class].0 {
		"travel" => {
			for (f, ln, g, si) in m.open_lines() {
				let st = &steps[si];
				let lab = format!("{} {}", st.title, g.label.clone().unwrap_or_default()).to_lowercase();
				let travel = matches!(g.verb.as_str(), "fly" | "hearth")
					|| (g.verb == "goto" && ["walk to", "travel to", "boat", "zeppelin", "tram", "ship", "ride", "take the", "run to", "head to"].iter().any(|w| lab.contains(w)));
				if !travel || g.only {
					continue;
				}
				// The places before and after the line: a move into another zone (or continent) of 600 yd or more.
				let Some(k) = m.goals.iter().position(|w| w.file == m.files[f] && w.line == Some(ln)) else { continue };
				let (Some(a), Some(b)) = (m.goals[..k].iter().rev().find_map(|w| w.w), m.goals[k + 1..].iter().find_map(|w| w.w)) else { continue };
				if a.map == b.map || dist(&a, &b) < 600.0 {
					continue;
				}
				let (v, d) = (g.verb.clone(), dist(&a, &b));
				push(
					0,
					Box::new(move |ed| {
						ed.delete_goal(f, ln);
						info(format!("delete `{v}` {}:{ln} (map {} -> {}, {d:.0} yd)", fname(f), a.map, b.map), vec![], 1)
					}),
				);
			}
		}
		"itemstart" => {
			let all: Vec<_> = m.open_lines().collect();
			for &(f, ln, g, _) in &all {
				let (Some(q), "accept") = (g.quest, g.verb.as_str()) else { continue };
				let Some(r) = quest(cx, q) else { continue };
				if r.start.item.is_empty() {
					continue;
				}
				let src =
					all.iter().filter(|(f2, l2, g2, _)| (*f2, *l2) < (f, ln) && g2.verb == "collect" && g2.id.is_some_and(|i| r.start.item.contains(&i))).map(|(f2, l2, _, _)| (*f2, *l2)).next_back();
				let Some((fc, lc)) = src else { continue };
				push(
					0,
					Box::new(move |ed| {
						ed.delete_goal(fc, lc);
						ed.mark(f, ln);
						info(format!("delete the starting item's collect {}:{lc} before accept {q}", fname(fc)), vec![q], 0)
					}),
				);
			}
		}
		"unsourced" => {
			for (f, ln, g, _) in m.open_lines() {
				let (Some(q), Some(item), "collect") = (g.quest, g.id, g.verb.as_str()) else { continue };
				if g.only || g.optional || g.map_mod {
					continue;
				}
				let srcs = item_sources(cx, item as u32);
				if srcs.is_empty() {
					continue;
				}
				// Coordinates of another goal of the guide in the same zone, 800 yd or more from every source.
				let zone = m.line(f, ln).zone.clone();
				let far = m.lines[f].iter().find_map(|l| {
					let g2 = l.g.as_ref()?;
					if g2.map_mod || l.zone != zone {
						return None;
					}
					let xy = g2.xy.or(g2.at)?;
					let w = m.goals.iter().find(|w| w.file == m.files[f] && w.line == Some(l.ln))?.w?;
					(near(&w, &srcs) >= 800.0 && near(&w, &srcs).is_finite()).then_some(xy)
				});
				let Some((x, y)) = far else { continue };
				let text = strip_tokens(&m.line(f, ln).text, &|t, _| usize::from(t.starts_with('@')));
				let text = add_mod(&text, &format!("@{x},{y}"));
				push(
					0,
					Box::new(move |ed| {
						ed.replace(f, ln, text.clone());
						info(format!("collect {item} for {q} at {}:{ln} pointed to @{x},{y}, ≥800 yd from its sources", fname(f)), vec![q], 0)
					}),
				);
			}
		}
		"giver" => {
			let gl: Vec<(usize, u32, Option<u32>, String)> = m.goals.iter().map(|g| (0, g.line.unwrap_or(0), g.npc, g.t.clone())).collect();
			for (f, ln, g, _) in m.open_lines() {
				let Some(q) = g.quest else { continue };
				if !matches!(g.verb.as_str(), "accept" | "turnin") || g.giver_mod || g.only {
					continue;
				}
				let Some(r) = quest(cx, q) else { continue };
				let ends = if g.verb == "accept" { &r.start.npc } else { &r.end.npc };
				if ends.is_empty() {
					continue;
				}
				let Some(k) = m.goals.iter().position(|w| w.file == m.files[f] && w.line == Some(ln)) else { continue };
				let other = (1..gl.len()).find_map(|d| {
					[k.checked_sub(d), Some(k + d)]
						.into_iter()
						.flatten()
						.filter_map(|i| gl.get(i))
						.find_map(|(_, _, npc, t)| npc.filter(|n| (t == "accept" || t == "turnin") && !ends.contains(&(*n as i64))))
				});
				let Some(n) = other else { continue };
				let text = add_mod(&m.line(f, ln).text, &format!("npc {n}"));
				push(
					0,
					Box::new(move |ed| {
						ed.replace(f, ln, text.clone());
						info(format!("{}:{ln} at NPC {n}", fname(f)), vec![q], 0)
					}),
				);
			}
		}
		"required" => {
			let all: Vec<_> = m.open_lines().collect();
			for &(f, ln, g, _) in &all {
				let (Some(q), Some(oi)) = (g.quest, g.oi) else { continue };
				if !WORK.contains(&g.verb.as_str()) || g.optional || g.only {
					continue;
				}
				if all.iter().filter(|(_, _, g2, _)| g2.quest == Some(q) && g2.oi == Some(oi)).count() != 1 {
					continue;
				}
				let Some((ft, lt)) = all.iter().find(|(f2, l2, g2, _)| g2.quest == Some(q) && g2.verb == "turnin" && later((f, ln), (*f2, *l2))).map(|x| (x.0, x.1)) else { continue };
				push(
					0,
					Box::new(move |ed| {
						ed.delete_goal(f, ln);
						ed.mark(ft, lt);
						info(format!("delete {q}.{oi} at {}:{ln}", fname(f)), vec![q], 0)
					}),
				);
			}
		}
		"gating" => {
			let w = class_by_file("WARRIOR").map_or(1, |c| c.bit);
			let rbit = forge_world::rules::race_bit(&cx.prep.def.race, cx.prep.def.faction);
			for (f, ln, g, si) in m.goal_lines() {
				let Some(q) = g.quest else { continue };
				if !matches!(g.verb.as_str(), "accept" | "turnin" | "complete") {
					continue;
				}
				let Some(r) = quest(cx, q) else { continue };
				let c = r.classes.unwrap_or(0.0) as u32;
				let races = r.races.unwrap_or(0.0) as u64;
				let out_c = c != 0 && c & ALL_CLASSES != ALL_CLASSES && c & w == 0;
				let out_r = races != 0 && rbit != 0 && races & rbit == 0;
				if !(out_c || out_r) {
					continue;
				}
				let step_only = steps[si].only_line;
				if g.only {
					let text = strip_tokens(&m.line(f, ln).text, &|t, _| if t == "only" { 2 } else { 0 });
					push(
						0,
						Box::new(move |ed| {
							ed.replace(f, ln, text.clone());
							info(format!("drop `only` on {}:{ln} ({q})", fname(f)), vec![q], 0)
						}),
					);
				} else if let Some(ol) = step_only {
					push(
						0,
						Box::new(move |ed| {
							ed.remove(f, ol);
							ed.mark(f, ln);
							info(format!("drop the step's `only` {}:{ol} ({q})", fname(f)), vec![q], 0)
						}),
					);
				}
			}
		}
		"count" | "textnum" => {
			let textnum = CLASSES[class].0 == "textnum";
			let mut levels: Vec<Cand<'a>> = Vec::new();
			let mut counts: Vec<Cand<'a>> = Vec::new();
			for (f, ln, g, si) in m.open_lines() {
				let Some(q) = g.quest else { continue };
				let Some(r) = quest(cx, q) else { continue };
				if g.only {
					continue;
				}
				if textnum && g.verb == "accept" {
					let st = &steps[si];
					let mut lv: Vec<f64> = Vec::new();
					for &gl in &st.goals {
						let g2 = m.line(f, gl).g.as_ref().unwrap();
						if let (Some(q2), "accept") = (g2.quest, g2.verb.as_str()) {
							if let Some(r2) = quest(cx, q2) {
								lv.extend(r2.min_level.iter().chain(r2.level.iter()));
							}
						}
					}
					let n = lv.iter().copied().fold(0.0, f64::max) as u32 + 3;
					let start = st.start;
					levels.push(Cand {
						pri: 0,
						apply: Box::new(move |ed| {
							ed.insert_after(f, start, &[ind(&format!("tip This quest requires level {n}."))]);
							info(format!("tip says level {n} at {}:{start} (accept {q})", fname(f)), vec![q], 0)
						}),
					});
					continue;
				}
				let Some(oi) = g.oi else { continue };
				let Some(Some(o)) = r.objectives.get(oi as usize - 1) else { continue };
				let (Some(c), Some(oid)) = (o.count.filter(|c| *c > 0.0), o.id) else { continue };
				let same = (o.kind == "kill" && g.verb == "kill" && g.id == Some(oid as i64)) || (o.kind == "item" && g.verb == "collect" && g.id == Some(oid as i64));
				if !same {
					continue;
				}
				let c = c as u32;
				let start = steps[si].start;
				if textnum {
					let (verb, name) = if o.kind == "kill" {
						("Kill", cx.sh.d.npcs.get(&(oid as u32)).and_then(|n| n.name.clone()))
					} else {
						("Collect", cx.sh.d.items.get(&(oid as u32)).and_then(|n| n.name.clone()))
					};
					let Some(name) = name else { continue };
					let tip = ind(&format!("tip {verb} {} {name}.", c + 3));
					counts.push(Cand {
						pri: 0,
						apply: Box::new(move |ed| {
							ed.insert_after(f, start, std::slice::from_ref(&tip));
							info(format!("tip says {} for {q}.{oi} (data {c}) at {}:{start}", c + 3, fname(f)), vec![q], 0)
						}),
					});
				} else {
					let text = m.line(f, ln).text.clone();
					let new = if g.count.is_some() { strip_tokens(&text, &|t, _| usize::from(t.starts_with('x') && t[1..].parse::<u32>().is_ok())) } else { text };
					let new = add_mod(&new, &format!("x{}", c + 2));
					counts.push(Cand {
						pri: 0,
						apply: Box::new(move |ed| {
							ed.replace(f, ln, new.clone());
							info(format!("x{} for {q}.{oi} (data {c}) at {}:{ln}", c + 2, fname(f)), vec![q], 0)
						}),
					});
				}
			}
			// textnum: counts and levels alternate (the selector shuffles within a priority group).
			out.extend(counts);
			for c in levels {
				out.push(Cand { pri: 0, apply: c.apply });
			}
			return out;
		}
		"levelgate" | "grind" => {
			let gate = CLASSES[class].0 == "levelgate";
			for (si, st) in steps.iter().enumerate() {
				if si < 3 || st.lvl < 3.0 || st.lvl > 28.0 || st.pos.is_none() || !st.open {
					continue;
				}
				let (f, start, l) = (st.file, st.start, st.lvl.floor() as u32);
				push(
					0,
					Box::new(move |ed| {
						if gate {
							ed.insert_before(f, start, &[s("step Grind"), ind(&format!("level {l}")), s(""), s("step Grind on"), ind(&format!("level {l}")), s("")]);
							info(format!("two `level {l}` gates before {}:{start}", fname(f)), vec![], 0)
						} else {
							ed.insert_before(f, start, &[s("step Grind"), ind(&format!("level {}", l + 2)), s("")]);
							info(format!("`level {}` at level {l} before {}:{start}", l + 2, fname(f)), vec![], 0)
						}
					}),
				);
			}
		}
		"log20" => {
			// The log after each goal of the baseline walk.
			let mut held: FxHashSet<i64> = FxHashSet::default();
			let mut size: FxHashMap<(String, u32), usize> = FxHashMap::default();
			for g in &m.goals {
				match (g.t.as_str(), g.q) {
					("accept", Some(q)) => {
						held.insert(q);
					}
					("turnin" | "abandon", Some(q)) => {
						held.remove(&q);
					}
					_ => {}
				}
				if let Some(l) = g.line {
					size.insert((g.file.clone(), l), held.len());
				}
			}
			let all: Vec<_> = m.open_lines().collect();
			for (k, &(f, ln, g, si)) in all.iter().enumerate() {
				if g.verb != "accept" || g.only {
					continue;
				}
				let Some(&n) = size.get(&(m.files[f].clone(), ln)) else { continue };
				if n > 16 {
					continue;
				}
				let need = 22 - n;
				let mut seen: FxHashSet<u32> = FxHashSet::default();
				let pulled: Vec<(usize, u32)> = all[k + 1..]
					.iter()
					.filter(|(_, _, g2, s2)| *s2 > si && *s2 < si + 60 && g2.verb == "accept" && !g2.only && g2.quest.is_some_and(|q| seen.insert(q)))
					.take(need)
					.map(|(f2, l2, _, _)| (*f2, *l2))
					.collect();
				if pulled.len() < need {
					continue;
				}
				let texts: Vec<String> = pulled.iter().map(|&(f2, l2)| m.line(f2, l2).text.clone()).collect();
				push(
					0,
					Box::new(move |ed| {
						for &(f2, l2) in &pulled {
							ed.delete_goal(f2, l2);
						}
						ed.insert_after(f, ln, &texts);
						info(format!("pull {need} accepts forward to {}:{ln} (log {n} there)", fname(f)), vec![], 0)
					}),
				);
			}
		}
		"noturnin" => {
			for (f, ln, g, _) in m.open_lines() {
				let (Some(q), "turnin") = (g.quest, g.verb.as_str()) else { continue };
				if g.only {
					continue;
				}
				let ql = m.quest_lines(q);
				if ql.iter().filter(|x| x.2.verb == "turnin").count() != 1 {
					continue;
				}
				let Some((fa, la)) = ql.iter().find(|x| x.2.verb == "accept" && later((x.0, x.1), (f, ln))).map(|x| (x.0, x.1)) else { continue };
				push(
					0,
					Box::new(move |ed| {
						ed.delete_goal(f, ln);
						ed.mark(fa, la);
						info(format!("delete turnin {q} at {}:{ln}", fname(f)), vec![q], 0)
					}),
				);
			}
		}
		"pingpong" => {
			for (f, ln, g, si) in m.open_lines() {
				let (Some(q), "turnin") = (g.quest, g.verb.as_str()) else { continue };
				let st = &steps[si];
				if g.only || g.at.is_some() || st.goals.len() < 2 {
					continue;
				}
				let Some(a) = st.pos else { continue };
				let Some(s2) = (si + 3..(si + 16).min(steps.len())).find(|&k| steps[k].file == f && steps[k].pos.is_some_and(|b| dist(&a, &b) >= 800.0 && dist(&a, &b) < 5000.0)) else { continue };
				let (last, t2) = (steps[s2].last, st.title.clone());
				let text = m.line(f, ln).text.trim().to_string();
				push(
					0,
					Box::new(move |ed| {
						ed.delete_goal(f, ln);
						ed.insert_after(f, last, &[s(""), format!("step Back to {t2}"), ind(&text)]);
						info(format!("turnin {q} moved from {}:{ln} to after {last}", fname(f)), vec![q], 0)
					}),
				);
			}
		}
		"trainer" => {
			let fac = if cx.prep.def.faction == forge_core::Faction::Horde { "H" } else { "A" };
			let mut trainers: Vec<(u32, Vec<WPt>)> = Vec::new();
			if let Some(o) = cx.sh.d.trainers.as_ref().and_then(|t| t.as_object()) {
				for (k, t) in o {
					let Ok(id) = k.parse::<u32>() else { continue };
					let war = t["classes"].as_array().is_some_and(|a| a.iter().any(|c| c == "WARRIOR"));
					let faction_ok = cx.sh.d.npcs.get(&id).and_then(|n| n.faction.as_deref()).is_some_and(|f| f.contains(fac));
					if war && faction_ok {
						let p = npc_pts(cx, id);
						if !p.is_empty() {
							trainers.push((id, p));
						}
					}
				}
			}
			for st in steps.iter().filter(|s| s.open) {
				let Some(p) = st.pos else { continue };
				if st.lvl < 4.0 {
					continue;
				}
				let mut d: Vec<(f64, u32)> = trainers.iter().map(|(id, pts)| (near(&p, pts), *id)).filter(|(x, _)| x.is_finite()).collect();
				d.sort_by(|a, b| a.0.total_cmp(&b.0));
				let Some(&(d0, _)) = d.first() else { continue };
				let Some(&(df, id)) = d.iter().rev().find(|(x, _)| *x >= 1200.0_f64.max(d0 + 800.0) && *x <= 5000.0) else { continue };
				let (f, last) = (st.file, st.last);
				push(
					0,
					Box::new(move |ed| {
						ed.insert_after(f, last, &[s(""), s("step Class trainer"), ind(&format!("train {id}"))]);
						info(format!("train {id} ({df:.0} yd; nearest {d0:.0}) after {}:{last}", fname(f)), vec![], 0)
					}),
				);
			}
		}
		"talkafter" => {
			let kb_escort = |q: u32| cx.sh.kb.as_ref().and_then(|k| k.get(&(q as i64))).is_some_and(|v| v.iter().any(|s| s.action == "escort"));
			for (f, ln, g, si) in m.open_lines() {
				let (Some(q), "turnin") = (g.quest, g.verb.as_str()) else { continue };
				let Some(r) = quest(cx, q) else { continue };
				let Some(&npc) = r.start.npc.first() else { continue };
				let sx = si + 2;
				if sx >= steps.len() || steps[sx].file != f {
					continue;
				}
				let escort = r.escort == Some(true) || kb_escort(q);
				let name = cx.sh.d.npcs.get(&(npc as u32)).and_then(|n| n.name.clone()).unwrap_or_else(|| format!("NPC {npc}"));
				let last = steps[sx].last;
				let _ = ln;
				push(
					u8::from(!escort),
					Box::new(move |ed| {
						ed.insert_after(f, last, &[s(""), format!("step {name}"), ind(&format!("talk {npc}"))]);
						info(format!("talk {npc} after turnin {q}{} at {}:{last}", if escort { " (escort)" } else { "" }, fname(f)), vec![q], 0)
					}),
				);
			}
		}
		"gatedwalk" => {
			let solo = walk::solo_filter(&cx.prep.rules, &cx.sh.d.quests, Some("Warrior"));
			let in_chain: FxHashSet<u32> = m.goal_lines().filter_map(|x| x.2.quest).collect();
			// Group quests the chain does not take and that need no other quest, at their giver's first
			// era-frame spawn, with their objectives as goals (the gated step is the whole quest).
			let group: Vec<(u32, f64, String, u32, f64, f64, WPt, Vec<String>)> = cx
				.sh
				.d
				.quests
				.values()
				.filter(|r| r.level.is_some() && cx.prep.rules.open.contains_key(&r.id) && !solo(r.id) && !in_chain.contains(&r.id))
				.filter(|r| r.pre.is_empty() && r.pre_all.as_ref().is_none_or(Vec::is_empty) && r.pre_any.as_ref().is_none_or(Vec::is_empty) && r.parent.is_none())
				.filter_map(|r| {
					let giver = cx.sh.d.npcs.get(&(*r.start.npc.first()? as u32))?;
					let (&map, x, y, w) = era_spawns(cx, giver).into_iter().next()?;
					let mut work = Vec::new();
					for (i, o) in r.objectives.iter().enumerate() {
						let o = o.as_ref()?;
						let verb = match o.kind.as_str() {
							"kill" => "kill",
							"item" => "collect",
							"object" => "interact",
							_ => return None,
						};
						work.push(ind(&format!("{verb} {} quest {}.{}", o.id? as i64, r.id, i + 1)));
					}
					(!work.is_empty() && !r.end.npc.is_empty()).then(|| (r.id, r.level.unwrap(), giver.name.clone().unwrap_or_default(), map, x, y, w, work))
				})
				.collect();
			for st in steps.iter().filter(|s| s.open && !s.has_zone) {
				let Some(p) = st.pos else { continue };
				let near_g = group
					.iter()
					.filter(|g| g.3 == p.map && (800.0..3000.0).contains(&dist(&p, &g.6)) && (g.1 - st.lvl).abs() <= 6.0)
					.min_by(|a, b| (a.1 - st.lvl).abs().total_cmp(&(b.1 - st.lvl).abs()));
				let Some((gq, _, name, map, x, y, w, work)) = near_g.cloned() else { continue };
				let (f, start, d) = (st.file, st.start, dist(&p, &w));
				let mut lines = vec![
					format!("step Walk to {name}"),
					ind(&format!("goto {x},{y} map {map} \"{name}\"")),
					s(""),
					format!("step {name}"),
					ind(&format!("when group {gq}")),
					ind(&format!("accept {gq}")),
				];
				lines.extend(work);
				lines.extend([ind(&format!("turnin {gq}")), s("")]);
				push(
					0,
					Box::new(move |ed| {
						ed.insert_before(f, start, &lines);
						info(format!("walk {d:.0} yd to {name} for `when group {gq}` before {}:{start}", fname(f)), vec![], 0)
					}),
				);
			}
		}
		"rare" | "elite" => {
			let rare = CLASSES[class].0 == "rare";
			let mobs: Vec<(u32, f64, Vec<WPt>)> = cx
				.sh
				.d
				.npcs
				.values()
				.filter(|n| {
					let r = n.rank.unwrap_or(0.0) as i64;
					if rare {
						r == 2 || r == 4
					} else {
						r == 1
					}
				})
				.filter(|n| n.faction.as_deref().is_none_or(|f| f.is_empty()) && n.level.is_some())
				.map(|n| (n.id, n.level.unwrap(), npc_pts(cx, n.id)))
				.filter(|x| !x.2.is_empty())
				.collect();
			for st in steps.iter().filter(|s| s.open) {
				let Some(p) = st.pos else { continue };
				let Some((id, lv, d)) = mobs
					.iter()
					.filter(|(_, lv, _)| *lv >= st.lvl - 3.0 && *lv <= st.lvl + 5.0)
					.map(|(id, lv, pts)| (*id, *lv, near(&p, pts)))
					.filter(|x| x.2 <= 500.0)
					.min_by(|a, b| a.2.total_cmp(&b.2))
				else {
					continue;
				};
				let (f, last) = (st.file, st.last);
				push(
					0,
					Box::new(move |ed| {
						ed.insert_after(f, last, &[ind(&format!("kill {id}"))]);
						info(format!("required kill {id} (level {lv}, {d:.0} yd) at {}:{last}", fname(f)), vec![], 0)
					}),
				);
			}
		}
		"deathskip" => {
			let healers: Vec<(u32, f64, f64, WPt)> = cx
				.sh
				.d
				.npcs
				.values()
				.filter(|n| n.roles.as_ref().is_some_and(|r| r.iter().any(|x| x == "spirithealer")))
				.flat_map(|n| era_spawns(cx, n).into_iter().map(|(&map, x, y, w)| (map, x, y, w)).collect::<Vec<_>>())
				.collect();
			for si in 0..steps.len().saturating_sub(1) {
				let (a, b) = (&steps[si], &steps[si + 1]);
				if a.file != b.file || !a.open || !b.open {
					continue;
				}
				let (Some(p), Some(q)) = (a.pos, b.pos) else { continue };
				if !(800.0..f64::INFINITY).contains(&dist(&p, &q)) {
					continue;
				}
				// The Spirit Healer nearest the next step, on its map.
				let Some(&(map, x, y, w)) = healers.iter().filter(|h| h.0 == q.map && dist(&h.3, &q) <= 1000.0).min_by(|a, b| dist(&a.3, &q).total_cmp(&dist(&b.3, &q))) else { continue };
				let (f, start, t, d) = (b.file, b.start, b.title.replace('"', ""), dist(&p, &w));
				push(
					0,
					Box::new(move |ed| {
						ed.insert_before(f, start, &[s("step Deathskip"), ind(&format!("die \"{t}\" @{x},{y} map {map}")), s("")]);
						info(format!("die before {}:{start} ({d:.0} yd from the last step)", fname(f)), vec![], 0)
					}),
				);
			}
		}
		"nofp" => {
			let all: Vec<_> = m.open_lines().collect();
			for &(f, ln, g, si) in &all {
				if g.verb != "getfp" || g.only {
					continue;
				}
				let Some(lab) = g.label.clone() else { continue };
				let same = |g2: &G| g2.verb == "getfp" && g2.label.as_deref() == Some(lab.as_str());
				// The first getfp of this flight path, and the flight before any other.
				if all.iter().any(|(f2, l2, g2, _)| (*f2, *l2) < (f, ln) && same(g2)) {
					continue;
				}
				let here = steps[si].pos;
				let fly = all.iter().find(|(f2, l2, g2, s2)| {
					later((f, ln), (*f2, *l2))
						&& g2.verb == "fly"
						&& (g2.label.as_deref() == Some(lab.as_str()) || (*s2 > 0 && here.zip(steps[*s2 - 1].pos).is_some_and(|(a, b)| dist(&a, &b) <= 300.0)))
				});
				let Some(&(ff, lf, _, _)) = fly else { continue };
				if all.iter().any(|(f2, l2, g2, _)| later((f, ln), (*f2, *l2)) && (*f2, *l2) < (ff, lf) && same(g2)) {
					continue;
				}
				push(
					0,
					Box::new(move |ed| {
						ed.delete_goal(f, ln);
						ed.mark(ff, lf);
						info(format!("delete getfp \"{lab}\" {}:{ln} (flown at {}:{lf})", fname(f), fname(ff)), vec![], 0)
					}),
				);
			}
		}
		"hearthwalk" => {
			let inns = &cx.sh.eworld.inns;
			let mut bind: Option<(String, WPt)> = None;
			for si in 0..steps.len().saturating_sub(1) {
				let st = &steps[si];
				if !st.open {
					continue;
				}
				for &l in &st.goals {
					let g = m.line(st.file, l).g.as_ref().unwrap();
					if g.verb == "sethome" {
						let found = match &g.label {
							Some(lab) => inns.iter().find(|i| i.names.iter().any(|n| n.eq_ignore_ascii_case(lab))),
							None => {
								st.pos.and_then(|p| inns.iter().min_by(|a, b| dist(&p, &WPt { c: a.c, wx: a.wx, wy: a.wy, map: 0 }).total_cmp(&dist(&p, &WPt { c: b.c, wx: b.wx, wy: b.wy, map: 0 }))))
							}
						};
						if let Some(i) = found {
							bind = Some((i.names[0].clone(), WPt { c: i.c, wx: i.wx, wy: i.wy, map: 0 }));
						}
					}
				}
				let Some((name, inn)) = bind.clone() else { continue };
				let nx = &steps[si + 1];
				if nx.file != st.file {
					continue;
				}
				let (Some(p), Some(b)) = (st.pos, nx.pos) else { continue };
				let (di, dp) = (dist(&inn, &b), dist(&p, &b));
				if !(di >= 1000.0 && di.is_finite() && di >= dp + 800.0) {
					continue;
				}
				let travel = |s2: &BStep| s2.goals.iter().any(|&l| matches!(m.line(s2.file, l).g.as_ref().unwrap().verb.as_str(), "hearth" | "fly"));
				if travel(st) || travel(nx) {
					continue;
				}
				let (f, last) = (st.file, st.last);
				push(
					0,
					Box::new(move |ed| {
						ed.insert_after(f, last, &[s(""), format!("step Hearth to {name}"), ind(&format!("hearth \"{name}\""))]);
						info(format!("hearth to {name} after {}:{last}, next step {di:.0} yd from the inn ({dp:.0} from here)", fname(f)), vec![], 1)
					}),
				);
			}
		}
		"classchain" | "dropquest" => {
			let class_only = CLASSES[class].0 == "classchain";
			let solo = walk::solo_filter(&cx.prep.rules, &cx.sh.d.quests, Some("Warrior"));
			let mut seen: FxHashSet<u32> = FxHashSet::default();
			let accepts: Vec<(u32, bool)> = m
				.open_lines()
				.filter(|x| x.2.verb == "accept")
				.filter_map(|(f, ln, g, si)| {
					let q = g.quest?;
					let gated = m.line(f, ln).text.contains("only Warrior") || steps[si].only_line.is_some_and(|ol| m.line(f, ol).text.contains("Warrior"));
					seen.insert(q).then_some((q, gated))
				})
				.collect();
			let in_chain: FxHashSet<u32> = accepts.iter().map(|x| x.0).collect();
			for &(q, gated) in &accepts {
				let Some(r) = quest(cx, q) else { continue };
				let is_class = warrior_only(r) || gated;
				let ql = m.quest_lines(q);
				let done = ql.iter().any(|x| x.2.verb == "turnin");
				let mut set = vec![q];
				if class_only {
					if !is_class {
						continue;
					}
					// The class quests after it in the chain.
					loop {
						let more: Vec<u32> = in_chain
							.iter()
							.copied()
							.filter(|q2| !set.contains(q2))
							.filter(|q2| {
								quest(cx, *q2)
									.is_some_and(|r2| warrior_only(r2) && r2.pre.iter().chain(r2.pre_all.iter().flatten()).chain(r2.pre_any.iter().flatten()).any(|p| set.contains(&(*p as u32))))
							})
							.collect();
						if more.is_empty() {
							break;
						}
						set.extend(more);
					}
				} else if is_class || !done || r.xp.unwrap_or(0.0) <= 0.0 || !solo(q) || r.repeatable == Some(true) {
					continue;
				}
				set.sort();
				let lines: Vec<(usize, u32)> = set.iter().flat_map(|&q2| m.quest_lines(q2).into_iter().map(|x| (x.0, x.1))).collect();
				push(
					0,
					Box::new(move |ed| {
						for &(f, l) in &lines {
							ed.delete_goal(f, l);
						}
						info(format!("drop quests {set:?} ({} lines)", lines.len()), set.clone(), 0)
					}),
				);
			}
		}
		"tip" => {
			let tips: Vec<(usize, String)> = steps.iter().enumerate().flat_map(|(si, st)| st.tips.iter().map(move |&l| (si, m.line(st.file, l).text.clone()))).collect();
			if tips.is_empty() {
				return out;
			}
			for (si, st) in steps.iter().enumerate() {
				if st.goals.is_empty() || !st.open {
					continue;
				}
				let k = (si * 7919 + 40) % tips.len();
				let Some((_, tip)) = tips[k..].iter().chain(&tips[..k]).find(|(sj, _)| sj.abs_diff(si) >= 40).cloned() else { continue };
				let (f, start) = (st.file, st.start);
				push(
					0,
					Box::new(move |ed| {
						ed.insert_after(f, start, std::slice::from_ref(&tip));
						info(format!("foreign tip into {}:{start}", fname(f)), vec![], 0)
					}),
				);
			}
		}
		"levelcap" => {
			let lastf = m.files.len() - 1;
			for st in steps.iter().filter(|s| s.open && (s.file == lastf || s.lvl >= 27.0)) {
				let (f, last) = (st.file, st.last);
				push(
					0,
					Box::new(move |ed| {
						ed.insert_after(f, last, &[s(""), s("step Grind to the cap"), ind("level 30+27688")]);
						info(format!("`level 30+27688` after {}:{last}", fname(f)), vec![], 0)
					}),
				);
			}
		}
		"acceptlate" => {
			let all: Vec<_> = m.open_lines().collect();
			for &(f, ln, g, si) in &all {
				let (Some(q), "accept") = (g.quest, g.verb.as_str()) else { continue };
				if g.only {
					continue;
				}
				let Some(&(fw, lw, _, sw)) = all.iter().find(|(f2, l2, g2, s2)| g2.quest == Some(q) && WORK.contains(&g2.verb.as_str()) && *s2 > si && *s2 <= si + 30 && later((f, ln), (*f2, *l2)))
				else {
					continue;
				};
				let (last, text) = (steps[sw].last, m.line(f, ln).text.clone());
				push(
					0,
					Box::new(move |ed| {
						ed.delete_goal(f, ln);
						ed.insert_after(fw, last, std::slice::from_ref(&text));
						ed.mark(fw, lw);
						info(format!("accept {q} moved from {}:{ln} after its work at {}:{lw}", fname(f), fname(fw)), vec![q], 0)
					}),
				);
			}
		}
		"offspawn" => {
			for (f, ln, g, _) in m.open_lines() {
				let Some((x, y)) = g.at else { continue };
				if !matches!(g.verb.as_str(), "kill" | "collect" | "interact") || g.only {
					continue;
				}
				// Coordinates on a known spawn of the target, moved off it.
				let Some(id) = g.id.map(|i| i as u32) else { continue };
				let pts = match g.verb.as_str() {
					"kill" => npc_pts(cx, id),
					"interact" => obj_pts(cx, id),
					_ => item_sources(cx, id),
				};
				let Some(w) = m.goals.iter().find(|w| w.file == m.files[f] && w.line == Some(ln)).and_then(|w| w.w) else { continue };
				if pts.is_empty() || near(&w, &pts) > 100.0 {
					continue;
				}
				let nx = if x > 50.0 { x - 15.0 } else { x + 15.0 };
				let text = m.line(f, ln).text.clone();
				let (code, rest) = code_part(&text);
				let new = code.split(' ').map(|t| if t.starts_with('@') { format!("@{nx},{y}") } else { t.to_string() }).collect::<Vec<_>>().join(" ") + rest;
				let q = g.quest;
				push(
					0,
					Box::new(move |ed| {
						ed.replace(f, ln, new.clone());
						info(format!("@{x},{y} -> @{nx},{y} at {}:{ln}", fname(f)), q.into_iter().collect(), 0)
					}),
				);
			}
		}
		"duplicate" => {
			for (f, ln, g, si) in m.open_lines() {
				if !matches!(g.verb.as_str(), "buy" | "collect" | "train") || si + 1 >= steps.len() || steps[si + 1].file != f {
					continue;
				}
				let (start, text, q) = (steps[si + 1].start, m.line(f, ln).text.clone(), g.quest);
				push(
					0,
					Box::new(move |ed| {
						ed.insert_after(f, start, std::slice::from_ref(&text));
						info(format!("{}:{ln} repeated in the next step ({start})", fname(f)), q.into_iter().collect(), 0)
					}),
				);
			}
		}
		"early" => {
			for (f, ln, g, si) in m.open_lines() {
				let (Some(q), "accept") = (g.quest, g.verb.as_str()) else { continue };
				let Some(ml) = quest(cx, q).and_then(|r| r.min_level) else { continue };
				let Some(p2) = steps[si].pos else { continue };
				let Some(s1) = (si.saturating_sub(80)..si).find(|&k| steps[k].lvl <= ml - 3.0 && steps[k].pos.is_some_and(|p| dist(&p, &p2) <= 300.0)) else { continue };
				let (f1, last, text, lv) = (steps[s1].file, steps[s1].last, m.line(f, ln).text.clone(), steps[s1].lvl);
				push(
					0,
					Box::new(move |ed| {
						ed.delete_goal(f, ln);
						ed.insert_after(f1, last, std::slice::from_ref(&text));
						info(format!("accept {q} (min level {ml}) moved from {}:{ln} to level {lv:.1} at {}:{last}", fname(f), fname(f1)), vec![q], 0)
					}),
				);
			}
		}
		other => panic!("no operator for {other}"),
	}
	out
}

/// splitmix64.
pub struct Rng(pub u64);

impl Rng {
	pub fn next(&mut self) -> u64 {
		self.0 = self.0.wrapping_add(0x9E37_79B9_7F4A_7C15);
		let mut z = self.0;
		z = (z ^ (z >> 30)).wrapping_mul(0xBF58_476D_1CE4_E5B9);
		z = (z ^ (z >> 27)).wrapping_mul(0x94D0_49BB_1331_11EB);
		z ^ (z >> 31)
	}
	pub fn shuffle<T>(&mut self, v: &mut [T]) {
		for i in (1..v.len()).rev() {
			let j = (self.next() % (i as u64 + 1)) as usize;
			v.swap(i, j);
		}
	}
}

pub fn seed(class: &str, chain: &str) -> u64 {
	class.bytes().chain(chain.bytes()).fold(0xC0FF_EE00_u64, |h, b| h.wrapping_mul(0x100_0000_01B3).wrapping_add(b as u64))
}
