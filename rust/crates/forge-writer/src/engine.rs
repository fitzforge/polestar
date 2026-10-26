//! The engine's features in the written guides (the engine design notes, §4), run on the
//! written chain after the travel repair, in order of player impact:
//!
//! - R1 `along until <label>`: work the route walks past before the step that does it is listed "along the
//!   way" from right after the accept (pattern 1), or, when the work's spawns line the walk on to the
//!   turn-in, the stop for it becomes an along step that ends at the turn-in (pattern 2, Gloom Weed).
//!   Along lists are per guide: a quest carried into another guide gets its along step there, `when
//!   onquest`.
//! - R2 `use <item>`: a quest done by using an item (quest mechanics, high confidence) gets its `use`.
//! - R3 `when` guards: travel steps for quests carried from an earlier guide are `when onquest`; a hearth
//!   to an inn bound in an earlier guide is `when bound`, with the walk there `when !bound`.
//! - R4 fractional `level` (apply.rs: the route's grind items keep their fraction).
//!
//! Pack format 5 (Polestar 0.3.0) rules, off unless `format_0_3`: R5 `when group`, R6 `task`/`cast`,
//! R7 `abandon` when the log would pass 40, R8 `skipto` over blocks for one carried quest.
//!
//! Positions are world yards (the compiler's resolved goals and spots); a passing leg is first found by
//! the straight line (the prefilter), then confirmed by walking yards where the walk store has them.

use crate::jsre::{split_comment, starts_nonspace, trim, trim_end};
use crate::post::no_empty_steps;
use crate::re;
use crate::travel::{component, walk_order, Travel};
use forge_core::jsnum::{js_hypot, js_to_fixed};
use forge_guide::data::Data;
use forge_guide::diag::Diagnostics;
use forge_guide::js::V;
use forge_guide::project::{resolve_sources, Source};
use forge_judge::honest::{fits, goal_lines, Geo, Persona, Wpt};
use rustc_hash::{FxHashMap, FxHashSet};
use serde_json::Value;
use std::collections::BTreeMap;

/// Yards from a walk leg within which an objective's spawn area is passed (edge distance).
pub const PASS_ALONG_YD: f64 = 150.0;
/// Steps the work must lie ahead of the first pass for an along step.
const STEPS_AHEAD: usize = 2;
/// Open along goals the addon lists at once.
const ALONG_CAP: usize = 6;
/// A drop chance (percent) from which a mob's drop is worth listing along the way.
const DROP_MIN: f64 = 10.0;
/// Spawn points of a target below which it is a named single NPC (it patrols, it is not "passed").
const SINGLE_NPC_PTS: usize = 2;
/// The quest log's size in Forever.
const LOG_CAP: usize = 40;
/// An open quest this many levels below the character may be abandoned.
const ABANDON_GAP: f64 = 6.0;
/// Pattern 2: the share of the spawns on the onward walk, the share of its length they spread over, and
/// the shortest walk that counts.
const ONWARD_SHARE: f64 = 0.6;
const ONWARD_SPREAD: f64 = 0.5;
const ONWARD_MIN_YD: f64 = 300.0;
const ONWARD_STEPS: usize = 3;

/// Which rules run.
#[derive(Clone, Debug)]
pub struct Opts {
	pub along: bool,
	pub use_items: bool,
	pub when: bool,
	/// Pack format 5 rules (R5-R8).
	pub format_0_3: bool,
}

impl Default for Opts {
	fn default() -> Self {
		Opts { along: true, use_items: true, when: true, format_0_3: false }
	}
}

/// Routed walking yards between two world points, where the walk store has them.
pub trait WalkYards {
	fn yards(&self, a: Wpt, b: Wpt) -> Option<f64>;
}

/// What the rules read besides the tree.
pub struct Inputs<'a> {
	pub data: &'a Data,
	/// data/local/mechanics/quest-mechanics.json (`quests`), when present.
	pub mechanics: Option<&'a Value>,
	/// data/local/mechanics/quest-steps.json (`quests`), when present.
	pub steps: Option<&'a Value>,
	/// Spell names to ids (the client's SpellName table), for `cast`.
	pub spells: Option<&'a FxHashMap<String, u32>>,
	pub walks: Option<&'a dyn WalkYards>,
	/// The route's character level at each quest's accept (route order `lvl`).
	pub accept_lvl: &'a FxHashMap<u32, f64>,
}

/// Lines written, per rule.
#[derive(Debug, Default, Clone)]
pub struct Report {
	pub counts: BTreeMap<&'static str, usize>,
	pub log: Vec<String>,
	/// Pattern-1 passes confirmed / refuted by walking yards, left to the straight line.
	pub walk_confirmed: usize,
	pub walk_refuted: usize,
	pub walk_unknown: usize,
}

impl Report {
	fn add(&mut self, rule: &'static str, n: usize) {
		*self.counts.entry(rule).or_default() += n;
	}
}

// ---- the chain as the route's character plays it ----

#[derive(Clone, Copy, Debug)]
struct Spot {
	w: Wpt,
	r: f64,
	n: f64,
}

#[derive(Clone, Debug)]
struct G {
	/// Chain guide, its file's text index.
	gi: usize,
	/// Step index in the guide, and its 1-based line.
	si: usize,
	step_line: u32,
	line: u32,
	verb: String,
	quest: Option<u32>,
	oi: Option<u32>,
	w: Option<Wpt>,
	map: f64,
	spots: Vec<Spot>,
	item: Option<u32>,
	location: Option<String>,
	/// The compiler's map percent and frame for the goal.
	xy: Option<(f64, f64, bool)>,
}

struct Chain {
	files: Vec<String>,
	seq: Vec<G>,
	/// Per guide: (step line, has `when`, has `label` value, has `along`, `only` V) by step index.
	steps: Vec<Vec<StepMeta>>,
}

#[derive(Clone, Debug)]
struct StepMeta {
	line: u32,
	when: bool,
	label: Option<String>,
	along: bool,
}

fn num(v: &V) -> Option<f64> {
	let n = v.num();
	(!v.is_nullish() && n.is_finite()).then_some(n)
}

fn id(v: &V) -> Option<u32> {
	num(v).filter(|n| *n >= 0.0 && n.fract() == 0.0).map(|n| n as u32)
}

fn play_chain(tree: &BTreeMap<String, String>, data: &Data, t: &Travel) -> Chain {
	let mut files: Vec<&String> = tree.keys().filter(|k| k.starts_with("forever/") && k.ends_with(".guide")).collect();
	files.sort_by(|a, b| walk_order(a, b));
	let keep = component(tree, &files, &t.chain);
	files.retain(|f| keep.contains(f.as_str()));
	let sources: Vec<Source> = files.iter().map(|f| Source { file: f.to_string(), source: f.to_string(), text: tree[*f].clone() }).collect();
	let guides = resolve_sources(&sources, data, &mut Diagnostics::new(), None, None);
	let geo = Geo::new(&data.map_frames);
	let persona = Persona { race: t.route_races.first().cloned().unwrap_or_default(), faction: t.faction.clone().unwrap_or_default(), cls: "WARRIOR".into() };
	let world = |map: f64, x: f64, y: f64, f: &V| -> Option<Wpt> { geo.to_world(map as i64, x, y, f.as_str() == Some("e")) };
	let mut out = Chain { files: Vec::new(), seq: Vec::new(), steps: Vec::new() };
	for f in &t.chain {
		let Some(g) = guides.iter().find(|g| g.hidden("_ast").get("file").as_str() == Some(f.as_str())) else { continue };
		let gi = out.files.len();
		out.files.push(f.clone());
		let ast_steps = g.hidden("_ast").get("steps").items();
		let mut metas = Vec::new();
		for (si, s) in g.get("steps").items().iter().enumerate() {
			let ast = ast_steps.get(si).cloned().unwrap_or(V::Undef);
			let step_line = num(&ast.get("line")).unwrap_or(0.0) as u32;
			let visible = fits(&s.get("only"), &persona);
			let label = s.get("label");
			metas.push(StepMeta { line: step_line, when: s.get("when").truthy(), label: label.truthy().then(|| label.to_js_string()), along: s.get("along").truthy() });
			if !visible {
				continue;
			}
			let goals = s.get("goals").items();
			let lines = goal_lines(&ast, &goals);
			for (k, x) in goals.iter().enumerate() {
				if !fits(&x.get("only"), &persona) {
					continue;
				}
				let map = num(&x.get("map"));
				let f = x.get("f");
				let w = match (map, num(&x.get("x")), num(&x.get("y"))) {
					(Some(m), Some(xx), Some(yy)) => world(m, xx, yy, &f),
					_ => None,
				};
				let spots = match map {
					Some(m) => x
						.get("spots")
						.items()
						.iter()
						.filter(|p| !p.get("alt").truthy())
						.filter_map(|p| Some(Spot { w: world(m, num(&p.get("x"))?, num(&p.get("y"))?, &f)?, r: num(&p.get("r")).unwrap_or(0.0), n: num(&p.get("n")).unwrap_or(1.0) }))
						.collect(),
					None => Vec::new(),
				};
				out.seq.push(G {
					gi,
					si,
					step_line,
					line: lines.get(k).copied().unwrap_or(0.0) as u32,
					verb: x.get("t").to_js_string(),
					quest: id(&x.get("quest")),
					oi: id(&x.get("oi")),
					w,
					map: map.unwrap_or(f64::NAN),
					spots,
					item: id(&x.get("item")),
					location: x.get("location").as_str().map(str::to_string),
					xy: num(&x.get("x")).zip(num(&x.get("y"))).map(|(a, b)| (a, b, f.as_str() != Some("e"))),
				});
			}
		}
		out.steps.push(metas);
	}
	out
}

fn dist(a: Wpt, b: Wpt) -> f64 {
	if a.c != b.c {
		return f64::INFINITY;
	}
	js_hypot(a.wx - b.wx, a.wy - b.wy)
}

fn seg_dist(p: Wpt, a: Wpt, b: Wpt) -> f64 {
	if p.c != a.c || p.c != b.c {
		return f64::INFINITY;
	}
	let (dx, dy) = (b.wx - a.wx, b.wy - a.wy);
	let l = dx * dx + dy * dy;
	let t = if l > 0.0 { (((p.wx - a.wx) * dx + (p.wy - a.wy) * dy) / l).clamp(0.0, 1.0) } else { 0.0 };
	js_hypot(p.wx - a.wx - t * dx, p.wy - a.wy - t * dy)
}

// ---- text edits on the chain's files ----

#[derive(Default)]
struct Edits {
	/// line index (0-based) -> lines before it.
	before: BTreeMap<usize, Vec<String>>,
	/// line index -> lines after it.
	after: BTreeMap<usize, Vec<String>>,
	removed: FxHashSet<usize>,
	replaced: FxHashMap<usize, String>,
}

impl Edits {
	fn apply(&self, text: &str) -> String {
		let lines: Vec<&str> = text.split('\n').collect();
		let mut out: Vec<String> = Vec::with_capacity(lines.len() + 16);
		for (i, l) in lines.iter().enumerate() {
			if let Some(b) = self.before.get(&i) {
				out.extend(b.iter().cloned());
			}
			if !self.removed.contains(&i) {
				out.push(self.replaced.get(&i).cloned().unwrap_or_else(|| l.to_string()));
			}
			if let Some(a) = self.after.get(&i) {
				out.extend(a.iter().cloned());
			}
		}
		no_empty_steps(out).join("\n")
	}
}

/// The last line of the step starting at 0-based `s` (its last indented line).
fn step_last(lines: &[&str], s: usize) -> usize {
	let mut e = s;
	let mut j = s + 1;
	while j < lines.len() {
		let l = lines[j];
		if crate::jsre::is_step(l) || (starts_nonspace(l) && !l.is_empty()) {
			break;
		}
		if !trim(l).is_empty() {
			e = j;
		}
		j += 1;
	}
	e
}

fn strip_place(code: &str) -> String {
	let c = re!(r"\s@\s*[\d.]+\s*,\s*[\d.]+(\s+[\d.]+)?").replace(code, "");
	let c = re!(r"\s+map\s+\d+").replace(&c, "");
	let c = re!(r"\s+(live|era)\b").replace(&c, "");
	trim_end(&c).to_string()
}

fn quest_v(data: &Data, q: u32) -> V {
	data.quests.get(&q.to_string())
}

fn name_of(data: &Data, kind: &str, id: u32) -> Option<String> {
	let t = match kind {
		"npc" => &data.npcs,
		"object" => &data.objects,
		_ => &data.items,
	};
	let n = t.get(&id.to_string()).get("name");
	n.truthy().then(|| n.to_js_string())
}

fn high_kinds(m: Option<&Value>, q: u32) -> Vec<String> {
	let Some(e) = m.and_then(|m| m.get(q.to_string())) else { return Vec::new() };
	e.get("kinds")
		.and_then(Value::as_array)
		.map_or(Vec::new(), |ks| ks.iter().filter(|k| k.get("confidence").and_then(Value::as_str) == Some("high")).filter_map(|k| k.get("kind").and_then(Value::as_str).map(str::to_string)).collect())
}

fn params<'v>(m: Option<&'v Value>, q: u32, kind: &str) -> Vec<&'v Value> {
	let Some(e) = m.and_then(|m| m.get(q.to_string())) else { return Vec::new() };
	e.get("params")
		.and_then(Value::as_array)
		.map_or(Vec::new(), |ps| ps.iter().filter(|p| p.get("kind").and_then(Value::as_str) == Some(kind) && p.get("confidence").and_then(Value::as_str).is_none_or(|c| c == "high")).collect())
}

/// The objective's source is worth listing along the way: a regular mob kill, a mob drop of at least
/// DROP_MIN percent (or any chance for one item passed five times), or a gatherable object. Named single
/// NPCs, escorts, quest-active-only drops and use-gated objects are not.
fn along_source(data: &Data, mech: Option<&Value>, q: u32, oi: u32, passes: usize) -> Option<String> {
	let kinds = high_kinds(mech, q);
	if kinds.iter().any(|k| matches!(k.as_str(), "escort" | "use-item-at-place" | "use-item-on-mob" | "summon-by-item" | "event-start")) {
		return None;
	}
	let o = quest_v(data, q).get("objectives").at(oi as usize - 1);
	let oid = id(&o.get("id"))?;
	let count = num(&o.get("count")).unwrap_or(1.0);
	let pts = |kind: &str, n: u32| -> usize { if kind == "npc" { &data.npcs } else { &data.objects }.get(&n.to_string()).get("spawns").entries().iter().map(|(_, s)| s.get("pts").len()).sum() };
	match o.get("type").as_str()? {
		"kill" => (pts("npc", oid) > SINGLE_NPC_PTS).then(|| name_of(data, "npc", oid).unwrap_or_default()),
		"object" => (pts("object", oid) > SINGLE_NPC_PTS).then(|| name_of(data, "object", oid).unwrap_or_default()),
		"item" => {
			let it = data.items.get(&oid.to_string());
			// A drop for more than one quest: it may drop only while another one is held.
			let needing = data.quests.entries().iter().filter(|(_, qq)| qq.get("objectives").items().iter().any(|x| x.get("type").as_str() == Some("item") && id(&x.get("id")) == Some(oid))).count();
			if it.get("questItem").truthy() && needing > 1 {
				return None;
			}
			let drops = it.get("drops");
			let objs = drops.get("object").keys();
			let best = drops.get("npc").entries().iter().filter(|(n, _)| pts("npc", n.parse().unwrap_or(0)) > SINGLE_NPC_PTS).map(|(_, c)| num(c).unwrap_or(0.0)).fold(f64::NEG_INFINITY, f64::max);
			let ok = !objs.is_empty() || best >= DROP_MIN || (best > 0.0 && count <= 1.0 && passes >= 5);
			ok.then(|| name_of(data, "item", oid).unwrap_or_default())
		}
		_ => None,
	}
}

/// A label for step `si` of guide `gi`: its own, else a new `q<Q>` (made unique in the guide).
struct Labels {
	taken: Vec<FxHashSet<String>>,
	new: FxHashMap<(usize, usize), String>,
}

impl Labels {
	fn of(&mut self, ch: &Chain, gi: usize, si: usize, q: u32) -> String {
		if let Some(l) = &ch.steps[gi][si].label {
			return l.clone();
		}
		if let Some(l) = self.new.get(&(gi, si)) {
			return l.clone();
		}
		let mut name = format!("q{q}");
		let mut k = 2;
		while self.taken[gi].contains(&name) {
			name = format!("q{q}-{k}");
			k += 1;
		}
		self.taken[gi].insert(name.clone());
		self.new.insert((gi, si), name.clone());
		name
	}
}

struct AlongStep {
	gi: usize,
	/// 0-based line the step goes after (a step's last line) or before (a step's first line).
	at: usize,
	after: bool,
	until: Option<String>,
	until_si: Option<usize>,
	when: Option<u32>,
	only: Option<String>,
	title: String,
	lines: Vec<String>,
	rank: usize,
	from_si: usize,
}

/// The rules on the written chain (`tree` holds every guide; the chain's are edited in place).
pub fn engine_pass(tree: &mut BTreeMap<String, String>, t: &Travel, inp: &Inputs, opts: &Opts) -> Report {
	let mut rep = Report::default();
	let data = inp.data;
	let ch = play_chain(tree, data, t);
	let texts: Vec<Vec<String>> = ch.files.iter().map(|f| tree[f].split('\n').map(str::to_string).collect()).collect();
	let mut edits: Vec<Edits> = ch.files.iter().map(|_| Edits::default()).collect();
	let seq = &ch.seq;
	let mut labels = Labels { taken: ch.steps.iter().map(|ss| ss.iter().filter_map(|s| s.label.clone()).collect()).collect(), new: FxHashMap::default() };
	let first_accept: FxHashMap<u32, usize> = {
		let mut m = FxHashMap::default();
		for (i, g) in seq.iter().enumerate() {
			if g.verb == "accept" {
				if let Some(q) = g.quest {
					m.entry(q).or_insert(i);
				}
			}
		}
		m
	};
	let first_turnin: FxHashMap<u32, usize> = {
		let mut m = FxHashMap::default();
		for (i, g) in seq.iter().enumerate() {
			if g.verb == "turnin" {
				if let Some(q) = g.quest {
					m.entry(q).or_insert(i);
				}
			}
		}
		m
	};
	let line_text = |g: &G| -> &str { texts[g.gi].get((g.line as usize).wrapping_sub(1)).map_or("", String::as_str) };
	let step_only = |gi: usize, step_line: u32| -> Option<String> {
		let lines = &texts[gi];
		let s = step_line as usize - 1;
		lines[s + 1..].iter().take_while(|l| !crate::jsre::is_step(l) && !(starts_nonspace(l) && !l.is_empty())).find(|l| re!(r"^\s+only\s").is_match(l)).cloned()
	};
	// A group or dungeon quest with work (asked for under pack format 5).
	let group = |q: u32| -> bool {
		let qv = quest_v(data, q);
		matches!(num(&qv.get("web").get("type")).map(|t| t as i64), Some(1) | Some(81)) && !qv.get("objectives").is_empty()
	};
	// Steps the rules below edit (one rule per step line).
	let mut touched: FxHashSet<(usize, usize)> = FxHashSet::default();

	// ---- R1: along ----
	if opts.along {
		let mut work: BTreeMap<(u32, u32), Vec<usize>> = BTreeMap::new();
		for (i, g) in seq.iter().enumerate() {
			if matches!(g.verb.as_str(), "kill" | "collect" | "interact") && !g.spots.is_empty() {
				if let (Some(q), Some(oi)) = (g.quest, g.oi) {
					work.entry((q, oi)).or_default().push(i);
				}
			}
		}
		let pos = |i: usize| (seq[i].gi, seq[i].si);
		let mut along: Vec<AlongStep> = Vec::new();
		let mut done_p2: FxHashSet<(u32, u32)> = FxHashSet::default();
		// Pattern 2: the one stop for an objective whose spawns line the walk on to the turn-in.
		for (&(q, oi), idx) in &work {
			if idx.len() != 1 {
				continue;
			}
			let i = idx[0];
			let wg = &seq[i];
			let Some(&ti) = first_turnin.get(&q).filter(|&&ti| ti > i) else { continue };
			// The turn-in a few steps on in the same guide (the walk from Gordo to Brill), not the rest of
			// the zone's route (a camp the route stops at stays a stop).
			if pos(ti) == pos(i) || seq[ti].gi != seq[i].gi || seq[ti].si > seq[i].si + ONWARD_STEPS || first_accept.get(&q).is_none_or(|&a| a >= i) {
				continue;
			}
			// The walk from the stop (its step's first placed goal) on to the turn-in.
			let Some(w0) = seq.iter().find(|g| (g.gi, g.si) == pos(i) && g.w.is_some()).and_then(|g| g.w).or(wg.w) else { continue };
			let mut pts = vec![w0];
			let mut ok = true;
			let mut len = 0.0;
			for g in &seq[i + 1..=ti] {
				if matches!(g.verb.as_str(), "fly" | "hearth") {
					ok = false;
					break;
				}
				let Some(p) = g.w else { continue };
				if g.map != wg.map {
					ok = false;
					break;
				}
				len += dist(*pts.last().unwrap(), p);
				pts.push(p);
			}
			if !ok || pts.len() < 2 || len < ONWARD_MIN_YD {
				continue;
			}
			// The spawns lining that walk: most of them within PASS_ALONG_YD of it, spread over most of its
			// length (a camp at one end is a stop, not the way).
			let tot: f64 = wg.spots.iter().map(|s| s.n).sum();
			let mut on = 0.0;
			let (mut lo, mut hi) = (f64::INFINITY, f64::NEG_INFINITY);
			for s in &wg.spots {
				let mut base = 0.0;
				let mut best: Option<(f64, f64)> = None;
				for ab in pts.windows(2) {
					let d = seg_dist(s.w, ab[0], ab[1]) - s.r;
					let seg = dist(ab[0], ab[1]);
					if d <= PASS_ALONG_YD && best.is_none_or(|b| d < b.0) {
						let t = if seg > 0.0 { (((s.w.wx - ab[0].wx) * (ab[1].wx - ab[0].wx) + (s.w.wy - ab[0].wy) * (ab[1].wy - ab[0].wy)) / (seg * seg)).clamp(0.0, 1.0) } else { 0.0 };
						best = Some((d, base + t * seg));
					}
					base += seg;
				}
				if let Some((_, at)) = best {
					if walk_ok(inp.walks, s.w, &pts, &mut rep) {
						on += s.n;
						lo = lo.min(at);
						hi = hi.max(at);
					}
				}
			}
			if tot <= 0.0 || on / tot < ONWARD_SHARE || hi - lo < ONWARD_SPREAD * len {
				continue;
			}
			if opts.format_0_3 && group(q) {
				continue;
			}
			let Some(src) = along_source(data, inp.mechanics, q, oi, 0) else { continue };
			let tg = &seq[ti];
			let (until, until_si) = if tg.gi == wg.gi { (Some(labels.of(&ch, tg.gi, tg.si, q)), Some(tg.si)) } else { (None, None) };
			let text = line_text(wg).to_string();
			let (code, _) = split_comment(&text);
			let place = seq[ti..].iter().find(|g| g.w.is_some()).and_then(|g| texts[g.gi][g.step_line as usize - 1].strip_prefix("step ").map(str::to_string)).unwrap_or_default();
			let stop = wg.line as usize - 1;
			edits[wg.gi].removed.insert(stop);
			let lines_ = texts[wg.gi].iter().map(String::as_str).collect::<Vec<_>>();
			let at = step_last(&lines_, wg.step_line as usize - 1);
			let line = format!("{}{}", strip_place(code), if place.is_empty() { String::new() } else { format!(" -- {src} along the way to {place}") });
			if let Some(x) = along.iter_mut().find(|x| x.gi == wg.gi && x.at == at && x.until == until) {
				x.lines.push(line);
				x.title = "On the way".into();
				done_p2.insert((q, oi));
				continue;
			}
			along.push(AlongStep {
				gi: wg.gi,
				at,
				after: true,
				until,
				until_si,
				when: None,
				only: step_only(wg.gi, wg.step_line),
				title: format!("{src} on the way"),
				lines: vec![line],
				rank: usize::MAX,
				from_si: wg.si,
			});
			done_p2.insert((q, oi));
			rep.log.push(format!("R1 along (onward to the turn-in): {} quest {q}.{oi} {src}", ch.files[wg.gi]));
		}
		// Pattern 1: legs walked past the objective's spawns before the step that works it.
		struct Pass {
			first_prev: usize,
			first_cur: usize,
			n: usize,
			work: usize,
		}
		let mut passes: BTreeMap<(usize, u32, u32), Pass> = BTreeMap::new();
		let mut prev: Option<usize> = None;
		for i in 0..seq.len() {
			let g = &seq[i];
			if matches!(g.verb.as_str(), "fly" | "hearth") {
				prev = None;
				continue;
			}
			let Some(p) = g.w else { continue };
			if let Some(pi) = prev {
				let a = seq[pi].w.unwrap();
				if seq[pi].map == g.map && dist(a, p) > 20.0 {
					for (&(q, oi), idx) in &work {
						if done_p2.contains(&(q, oi)) {
							continue;
						}
						let Some(&acc) = first_accept.get(&q) else { continue };
						if acc >= pi || first_turnin.get(&q).is_some_and(|&t| t <= i) {
							continue;
						}
						let Some(&w) = idx.iter().find(|&&j| pos(j) > pos(i)) else { continue };
						if idx.iter().any(|&j| pos(j) == pos(i) || pos(j) == pos(pi)) || seq[w].map != g.map {
							continue;
						}
						let best = seq[w].spots.iter().map(|s| (seg_dist(s.w, a, p) - s.r).max(0.0)).fold(f64::INFINITY, f64::min);
						if best > PASS_ALONG_YD {
							continue;
						}
						let near: Vec<Wpt> = seq[w].spots.iter().filter(|s| seg_dist(s.w, a, p) - s.r <= PASS_ALONG_YD).map(|s| s.w).collect();
						if !near.iter().any(|s| walk_ok(inp.walks, *s, &[a, p], &mut rep)) {
							continue;
						}
						let e = passes.entry((g.gi, q, oi)).or_insert(Pass { first_prev: pi, first_cur: i, n: 0, work: w });
						e.n += 1;
					}
				}
			}
			prev = Some(i);
		}
		let mut by_guide: Vec<Vec<AlongStep>> = ch.files.iter().map(|_| Vec::new()).collect();
		for a in along.drain(..) {
			let gi = a.gi;
			by_guide[gi].push(a);
		}
		for (&(gi, q, oi), p) in &passes {
			let wg = &seq[p.work];
			let cur = &seq[p.first_cur];
			let ahead = if wg.gi == gi { wg.si.saturating_sub(cur.si) } else { usize::MAX };
			if ahead < STEPS_AHEAD {
				continue;
			}
			// (A group quest the player is asked about is not listed before they answer.)
			if opts.format_0_3 && group(q) {
				continue;
			}
			let Some(src) = along_source(data, inp.mechanics, q, oi, p.n) else { continue };
			let acc = first_accept[&q];
			let carried = seq[acc].gi != gi;
			let lines_ = texts[gi].iter().map(String::as_str).collect::<Vec<_>>();
			let (at, after, from_si) = if !carried {
				(step_last(&lines_, seq[acc].step_line as usize - 1), true, seq[acc].si)
			} else {
				let pv = &seq[p.first_prev];
				let s = if pv.gi == gi { pv } else { cur };
				(s.step_line as usize - 1, false, s.si.saturating_sub(1))
			};
			let (until, until_si) = if wg.gi == gi { (Some(labels.of(&ch, gi, wg.si, q)), Some(wg.si)) } else { (None, None) };
			let text = line_text(wg).to_string();
			let line = strip_place(split_comment(&text).0);
			let only = step_only(wg.gi, wg.step_line);
			match by_guide[gi].iter_mut().find(|x| x.at == at && x.after == after && x.until == until && x.when == carried.then_some(q) && x.only == only) {
				Some(x) => {
					if !x.lines.contains(&line) {
						x.lines.push(line);
						x.title = "On the way".into();
						x.rank = x.rank.max(p.n);
					}
				}
				None => by_guide[gi].push(AlongStep { gi, at, after, until, until_si, when: carried.then_some(q), only, title: format!("{src} on the way"), lines: vec![line], rank: p.n, from_si }),
			}
		}
		// At most ALONG_CAP open along goals at once, the most-passed first.
		for (gi, steps) in by_guide.iter_mut().enumerate() {
			steps.sort_by_key(|x| std::cmp::Reverse(x.rank));
			let mut kept: Vec<(usize, usize, usize)> = Vec::new(); // (from, to, goals)
			for a in steps.iter() {
				let to = a.until_si.unwrap_or(usize::MAX);
				let open: usize = kept.iter().filter(|(f, t, _)| *f <= to && a.from_si <= *t).map(|x| x.2).sum();
				if open + a.lines.len() > ALONG_CAP {
					rep.log.push(format!("R1 along over the cap of {ALONG_CAP}: {} {}", ch.files[gi], a.title));
					continue;
				}
				kept.push((a.from_si, to, a.lines.len()));
				let mut block = vec![String::new(), format!("step {}", a.title)];
				block.push(match &a.until {
					Some(l) => format!("  along until {l}"),
					None => "  along".into(),
				});
				if let Some(q) = a.when {
					block.push(format!("  when onquest {q}"));
				}
				if let Some(o) = &a.only {
					block.push(o.clone());
				}
				block.extend(a.lines.iter().cloned());
				if a.after {
					edits[gi].after.entry(a.at).or_default().extend(block);
				} else {
					let mut b = block[1..].to_vec();
					b.push(String::new());
					edits[gi].before.entry(a.at).or_default().extend(b);
				}
				rep.add("R1 along", a.lines.len());
			}
		}
		for (&(gi, si), l) in &labels.new {
			let s = ch.steps[gi][si].line as usize - 1;
			edits[gi].after.entry(s).or_default().insert(0, format!("  label {l}"));
			rep.add("R1 label", 1);
		}
	}

	// ---- R2: use ----
	if opts.use_items && inp.mechanics.is_some() {
		let has_use: FxHashSet<u32> = seq.iter().filter(|g| g.verb == "use").filter_map(|g| g.item).collect();
		// (A turn-in written before its accept has no stretch for the item between them.)
		let mut quests: Vec<u32> = first_turnin.keys().copied().filter(|q| first_accept.get(q).is_some_and(|&a| a < first_turnin[q])).collect();
		quests.sort();
		for q in quests {
			let kinds = high_kinds(inp.mechanics, q);
			for kind in ["use-item-at-place", "use-item-on-mob", "summon-by-item"] {
				if !kinds.iter().any(|k| k == kind) {
					continue;
				}
				for p in params(inp.mechanics, q, kind) {
					let Some(item) = p.get("item").and_then(Value::as_u64).map(|x| x as u32) else { continue };
					if has_use.contains(&item) {
						continue;
					}
					let ti = first_turnin[&q];
					// The item in the bags first: the quest hands it over at the accept (its source item), or
					// a line gets it before the turn-in.
					let qv = quest_v(data, q);
					let handed = id(&qv.get("sourceItem")) == Some(item) || qv.get("start").get("item").items().iter().any(|x| id(x) == Some(item));
					let got = seq[first_accept[&q]..ti].iter().any(|g| matches!(g.verb.as_str(), "collect" | "buy") && g.item == Some(item));
					if !handed && !got {
						continue;
					}
					let work: Vec<usize> = (first_accept[&q]..ti).filter(|&i| seq[i].quest == Some(q) && matches!(seq[i].verb.as_str(), "kill" | "collect" | "interact")).collect();
					let pos0 = p
						.get("place")
						.and_then(|pl| pl.get("positions"))
						.and_then(Value::as_array)
						.and_then(|a| a.first())
						.cloned()
						.or_else(|| p.get("place").filter(|pl| pl.get("x").is_some()).cloned());
					let at = pos0
						.as_ref()
						.and_then(|v| Some(format!(" @{},{} map {}", js_to_fixed(v.get("x")?.as_f64()?, 1), js_to_fixed(v.get("y")?.as_f64()?, 1), v.get("map")?.as_u64()?)))
						.unwrap_or_default();
					match kind {
						"use-item-on-mob" => {
							// On the mob: after the kill (or the drop) it is used on, at its place.
							let Some(&i) = work.iter().find(|&&i| matches!(seq[i].verb.as_str(), "kill" | "collect")) else { continue };
							let g = &seq[i];
							let place = goal_at(&texts[g.gi][g.line as usize - 1], data, g);
							edits[g.gi].after.entry(g.line as usize - 1).or_default().push(format!("  use {item} quest {q}.{}{place}", g.oi.unwrap_or(1)));
							rep.add("R2 use", 1);
						}
						_ if !work.is_empty() && !at.is_empty() => {
							// At the place, before the stand-in (kill/collect/interact), which stays: its kill or
							// loot is the objective's credit and the knowledge base's step.
							let g = &seq[work[0]];
							let r = if kind == "summon-by-item" { format!("  use {item}{at}") } else { format!("  use {item} quest {q}.{}{at}", g.oi.unwrap_or(1)) };
							edits[g.gi].before.entry(g.line as usize - 1).or_default().push(r);
							rep.add("R2 use", 1);
						}
						_ if work.is_empty() && !at.is_empty() => {
							// A turn-in-only quest: the use in a step of its own before the turn-in, when
							// the place is by the turn-in (no new journey).
							let tg = &seq[ti];
							let Some(pv) = pos0.as_ref() else { continue };
							let (Some(map), Some(x), Some(y)) = (pv.get("map").and_then(Value::as_f64), pv.get("x").and_then(Value::as_f64), pv.get("y").and_then(Value::as_f64)) else { continue };
							let Some(uw) = Geo::new(&data.map_frames).to_world(map as i64, x, y, true) else { continue };
							if !tg.w.is_some_and(|tw| dist(uw, tw) <= 600.0) {
								continue;
							}
							let objs = quest_v(data, q).get("objectives").len();
							let qref = if objs > 0 { format!(" quest {q}.1") } else { String::new() };
							let name = name_of(data, "item", item).unwrap_or_else(|| format!("Item {item}"));
							let mut b = vec![format!("step {name}")];
							if let Some(o) = step_only(tg.gi, tg.step_line) {
								b.push(o);
							}
							b.push(format!("  use {item}{qref}{at}"));
							b.push(String::new());
							edits[tg.gi].before.entry(tg.step_line as usize - 1).or_default().extend(b);
							rep.add("R2 use", 1);
						}
						_ => {}
					}
				}
			}
		}
	}

	// ---- R3: when guards ----
	if opts.when {
		let skip_blocks: FxHashSet<(usize, usize)> = if opts.format_0_3 { skipto_steps(&ch, seq, &first_accept, &texts) } else { FxHashSet::default() };
		// Travel steps for quests carried from an earlier guide (or accepted optionally).
		let mut by_step: BTreeMap<(usize, usize), Vec<usize>> = BTreeMap::new();
		for (i, g) in seq.iter().enumerate() {
			by_step.entry((g.gi, g.si)).or_default().push(i);
		}
		for (&(gi, si), idx) in &by_step {
			let meta = &ch.steps[gi][si];
			if meta.when || meta.along || skip_blocks.contains(&(gi, si)) {
				continue;
			}
			let travel = idx.iter().any(|&i| matches!(seq[i].verb.as_str(), "goto" | "hearth" | "fly" | "vendor" | "train" | "getfp" | "sethome"));
			let qg: Vec<usize> = idx.iter().copied().filter(|&i| seq[i].quest.is_some() && seq[i].verb != "goto").collect();
			if !travel || qg.is_empty() {
				continue;
			}
			let carried = qg.iter().all(|&i| {
				let g = &seq[i];
				let q = g.quest.unwrap();
				g.verb != "accept" && first_accept.get(&q).is_some_and(|&a| a < i && (seq[a].gi < gi || re!(r"\boptional\b").is_match(split_comment(line_text(&seq[a])).0)))
			});
			if !carried {
				continue;
			}
			let mut qs: Vec<u32> = qg.iter().map(|&i| seq[i].quest.unwrap()).collect();
			qs.dedup();
			let qs: Vec<String> = qs
				.iter()
				.fold(Vec::new(), |mut v: Vec<u32>, q| {
					if !v.contains(q) {
						v.push(*q);
					}
					v
				})
				.iter()
				.map(u32::to_string)
				.collect();
			edits[gi].after.entry(meta.line as usize - 1).or_default().push(format!("  when onquest {}", qs.join(",")));
			touched.insert((gi, si));
			rep.add("R3 when onquest", 1);
		}
		// A hearth to an inn bound in an earlier guide.
		let mut bound: Option<(String, usize)> = None;
		let inns = data.travel.get("inns").items();
		for g in seq.iter() {
			if g.verb == "sethome" {
				bound = g.location.clone().map(|l| (l, g.gi));
				continue;
			}
			if g.verb != "hearth" {
				continue;
			}
			let Some((b, bgi)) = &bound else { continue };
			let Some(loc) = &g.location else { continue };
			if b != loc || *bgi >= g.gi || b == "nearest" || ch.steps[g.gi][g.si].when || touched.contains(&(g.gi, g.si)) {
				continue;
			}
			let inn = inns.iter().find(|i| {
				let names = i.get("names");
				let list = if names.truthy() { names.items() } else { vec![i.get("location")] };
				list.iter().any(|n| n.to_js_string().eq_ignore_ascii_case(loc))
			});
			let Some(inn) = inn else { continue };
			let lines_ = texts[g.gi].iter().map(String::as_str).collect::<Vec<_>>();
			let s = g.step_line as usize - 1;
			let e = step_last(&lines_, s);
			let others = seq.iter().filter(|x| x.gi == g.gi && x.si == g.si && !matches!(x.verb.as_str(), "hearth" | "fly" | "goto")).count();
			let only = step_only(g.gi, g.step_line);
			let zone = data.zones.get(&inn.get("map").to_js_string()).get("name");
			let mut fallback = vec![String::new(), format!("step {}", if zone.truthy() { format!("To {loc}") } else { loc.clone() }), format!("  when !bound \"{loc}\"")];
			if let Some(o) = &only {
				fallback.push(o.clone());
			}
			if zone.truthy() {
				fallback.push(format!("  zone {}", zone.to_js_string()));
			}
			let live = if inn.get("f").as_str() == Some("e") { "" } else { " live" };
			fallback.push(format!("  goto {},{} \"{loc}\"{live}", js_to_fixed(inn.get("x").num(), 1), js_to_fixed(inn.get("y").num(), 1)));
			if others == 0 {
				edits[g.gi].after.entry(s).or_default().push(format!("  when bound \"{loc}\""));
				edits[g.gi].after.entry(e).or_default().extend(fallback);
			} else {
				// The hearth in a step of its own before the rest of its step.
				let hl = g.line as usize - 1;
				edits[g.gi].removed.insert(hl);
				let mut b = vec![format!("step Hearth to {loc}"), format!("  when bound \"{loc}\"")];
				if let Some(o) = &only {
					b.push(o.clone());
				}
				b.push(texts[g.gi][hl].clone());
				b.extend(fallback);
				b.push(String::new());
				edits[g.gi].before.entry(s).or_default().extend(b);
			}
			touched.insert((g.gi, g.si));
			rep.add("R3 when bound", 1);
		}
	}

	// ---- pack format 5 (Polestar 0.3.0) ----
	if opts.format_0_3 {
		// R5: group and dungeon quests' work, asked once.
		let mut by_step: BTreeMap<(usize, usize), Vec<usize>> = BTreeMap::new();
		for (i, g) in seq.iter().enumerate() {
			by_step.entry((g.gi, g.si)).or_default().push(i);
		}
		// Every goal of a group quest the route takes is asked for: the accept, the work and the turn-in
		// (the player who skips it skips all of it).
		let mut groups: Vec<u32> = first_accept.keys().copied().filter(|q| first_turnin.contains_key(q) && group(*q)).collect();
		groups.sort();
		for (&(gi, si), idx) in &by_step {
			let meta = &ch.steps[gi][si];
			let qs: Vec<u32> = idx.iter().filter_map(|&i| seq[i].quest).filter(|q| groups.contains(q)).fold(Vec::new(), |mut v, q| {
				if !v.contains(&q) {
					v.push(q);
				}
				v
			});
			if qs.is_empty() || meta.along {
				continue;
			}
			let all: Vec<usize> = idx.iter().copied().filter(|&i| seq[i].quest.is_some()).collect();
			if qs.len() == 1 && !meta.when && !touched.contains(&(gi, si)) && all.iter().all(|&i| seq[i].quest == Some(qs[0])) {
				edits[gi].after.entry(meta.line as usize - 1).or_default().push(format!("  when group {}", qs[0]));
				touched.insert((gi, si));
				rep.add("R5 when group", 1);
				continue;
			}
			// Its lines in a step of their own after the step, asked for.
			let lines_ = texts[gi].iter().map(String::as_str).collect::<Vec<_>>();
			let s0 = meta.line as usize - 1;
			let e = step_last(&lines_, s0);
			for q in qs {
				let mut b = vec![String::new(), texts[gi][s0].clone(), format!("  when group {q}")];
				if let Some(o) = step_only(gi, meta.line) {
					b.push(o);
				}
				for &i in all.iter().filter(|&&i| seq[i].quest == Some(q)) {
					let l = seq[i].line as usize - 1;
					if edits[gi].removed.insert(l) {
						b.push(edits[gi].replaced.get(&l).cloned().unwrap_or_else(|| texts[gi][l].clone()));
					}
				}
				// Before the along steps that follow the step (their goals come after the accept).
				let at = edits[gi].after.entry(e).or_default();
				let k = at.iter().position(|l| l.starts_with("step ")).map_or(at.len(), |k| k.saturating_sub(1));
				at.splice(k..k, b);
				rep.add("R5 when group", 1);
			}
		}
		// R6: emotes and waits as tasks, class spells as casts, before a turn-in nothing else tracks.
		if let Some(steps) = inp.steps {
			for (&q, &ti) in &first_turnin {
				let tracked = seq.iter().any(|g| g.quest == Some(q) && matches!(g.verb.as_str(), "complete" | "kill" | "collect" | "interact" | "use" | "talk"));
				if tracked || !first_accept.contains_key(&q) {
					continue;
				}
				let Some(qs) = steps.get(q.to_string()).and_then(|e| e.get("steps")).and_then(Value::as_array) else { continue };
				let tg = &seq[ti];
				let mut add = Vec::new();
				for s in qs {
					let action = s.get("action").and_then(Value::as_str).unwrap_or("");
					let target = s.get("target").and_then(|t| t.get("name")).and_then(Value::as_str).unwrap_or("");
					match action {
						"emote" | "wait" if !target.is_empty() => {
							let what = if action == "emote" { format!("Emote at {target}") } else { format!("Wait for {target}") };
							add.push(format!("  task \"{}\"", what.replace('"', "'")));
						}
						"cast-spell" => {
							if let Some(&sp) = inp.spells.and_then(|m| m.get(target)) {
								add.push(format!("  cast {sp} \"{target}\""));
							}
						}
						_ => {}
					}
				}
				if add.is_empty() {
					continue;
				}
				rep.add("R6 task/cast", add.len());
				edits[tg.gi].before.entry(tg.line as usize - 1).or_default().extend(add);
			}
		}
		// R7: the quest log past 40: the lowest open quest well below the character is abandoned first.
		let mut log: Vec<u32> = Vec::new();
		let mut level = 1.0f64;
		for (i, g) in seq.iter().enumerate() {
			let Some(q) = g.quest else { continue };
			match g.verb.as_str() {
				"accept" => {
					if log.contains(&q) {
						continue;
					}
					if let Some(l) = inp.accept_lvl.get(&q) {
						level = level.max(*l);
					}
					if log.len() >= LOG_CAP {
						let qlvl = |q: u32| num(&quest_v(data, q).get("level")).unwrap_or(level);
						let low = log.iter().copied().filter(|&o| qlvl(o) <= level - ABANDON_GAP).min_by(|a, b| qlvl(*a).total_cmp(&qlvl(*b)));
						if let Some(o) = low {
							log.retain(|&x| x != o);
							edits[g.gi].before.entry(g.line as usize - 1).or_default().push(format!("  abandon {o}"));
							rep.add("R7 abandon", 1);
							rep.log.push(format!("R7 abandon {o} before {}:{} (log {} at level {level:.1})", ch.files[g.gi], g.line, LOG_CAP));
						}
					}
					log.push(q);
				}
				"turnin" => log.retain(|&x| x != q),
				_ => {}
			}
			let _ = i;
		}
		// R8: skipto over a block of steps for one carried quest.
		for (gi, si, last_si, q) in skipto_blocks(&ch, seq, &first_accept, &texts) {
			let after = si_after(&ch, gi, last_si);
			let Some(next) = after else { continue };
			let l = labels.of(&ch, gi, next, q);
			let s = ch.steps[gi][si].line as usize - 1;
			edits[gi].after.entry(s).or_default().push(format!("  skipto {l} when !onquest {q}"));
			if ch.steps[gi][next].label.is_none() {
				let ns = ch.steps[gi][next].line as usize - 1;
				edits[gi].after.entry(ns).or_default().insert(0, format!("  label {l}"));
			}
			rep.add("R8 skipto", 1);
		}
	}

	for (gi, e) in edits.iter().enumerate() {
		let f = &ch.files[gi];
		let new = e.apply(&tree[f]);
		tree.insert(f.clone(), new);
	}
	rep
}

/// ` @x,y map M` for a goal: its own typed place, else the compiler's.
fn goal_at(text: &str, _data: &Data, g: &G) -> String {
	if let Some(m) = re!(r"@\s*([\d.]+)\s*,\s*([\d.]+)").captures(split_comment(text).0) {
		let map = re!(r"\bmap\s+(\d+)").captures(text).map(|m| m[1].to_string()).or_else(|| g.map.is_finite().then(|| (g.map as i64).to_string()));
		return format!(" @{},{}{}", &m[1], &m[2], map.map_or(String::new(), |m| format!(" map {m}")));
	}
	match (g.xy, g.map.is_finite()) {
		(Some((x, y, live)), true) => format!(" @{},{} map {}{}", js_to_fixed(x, 1), js_to_fixed(y, 1), g.map as i64, if live { " live" } else { "" }),
		_ => String::new(),
	}
}

fn si_after(ch: &Chain, gi: usize, si: usize) -> Option<usize> {
	(si + 1 < ch.steps[gi].len()).then_some(si + 1)
}

/// Blocks of two or more consecutive steps whose quest goals are all for one quest carried from an earlier
/// guide (no accept in them): (guide, first step, last step, quest).
fn skipto_blocks(ch: &Chain, seq: &[G], first_accept: &FxHashMap<u32, usize>, _texts: &[Vec<String>]) -> Vec<(usize, usize, usize, u32)> {
	let mut by_step: BTreeMap<(usize, usize), Vec<usize>> = BTreeMap::new();
	for (i, g) in seq.iter().enumerate() {
		by_step.entry((g.gi, g.si)).or_default().push(i);
	}
	let one = |gi: usize, si: usize| -> Option<u32> {
		let idx = by_step.get(&(gi, si))?;
		if ch.steps[gi][si].when || ch.steps[gi][si].along || ch.steps[gi][si].label.is_some() {
			return None;
		}
		let qs: Vec<usize> = idx.iter().copied().filter(|&i| seq[i].quest.is_some()).collect();
		let q = seq[*qs.first()?].quest?;
		let ok = qs.iter().all(|&i| seq[i].quest == Some(q) && seq[i].verb != "accept") && first_accept.get(&q).is_some_and(|&a| seq[a].gi < gi);
		ok.then_some(q)
	};
	let mut out = Vec::new();
	for gi in 0..ch.steps.len() {
		let n = ch.steps[gi].len();
		let mut si = 0;
		while si < n {
			let Some(q) = one(gi, si) else {
				si += 1;
				continue;
			};
			let mut e = si;
			while e + 1 < n && one(gi, e + 1) == Some(q) {
				e += 1;
			}
			if e > si && e + 1 < n {
				out.push((gi, si, e, q));
			}
			si = e + 1;
		}
	}
	out
}

fn skipto_steps(ch: &Chain, seq: &[G], first_accept: &FxHashMap<u32, usize>, texts: &[Vec<String>]) -> FxHashSet<(usize, usize)> {
	skipto_blocks(ch, seq, first_accept, texts).into_iter().flat_map(|(gi, a, b, _)| (a..=b).map(move |s| (gi, s))).collect()
}

/// A spawn passed by a walk: confirmed by walking yards where the store has them (the detour to the
/// spawn and on is at most twice PASS_ALONG_YD more than the leg), else the straight line's word stands.
fn walk_ok(walks: Option<&dyn WalkYards>, s: Wpt, pts: &[Wpt], rep: &mut Report) -> bool {
	let Some(wk) = walks else { return true };
	for ab in pts.windows(2) {
		if seg_dist(s, ab[0], ab[1]) > PASS_ALONG_YD * 2.0 {
			continue;
		}
		if let (Some(a_s), Some(s_b), Some(a_b)) = (wk.yards(ab[0], s), wk.yards(s, ab[1]), wk.yards(ab[0], ab[1])) {
			if a_s + s_b - a_b <= 2.0 * PASS_ALONG_YD {
				rep.walk_confirmed += 1;
				return true;
			}
			rep.walk_refuted += 1;
			continue;
		}
		rep.walk_unknown += 1;
		return true;
	}
	false
}
