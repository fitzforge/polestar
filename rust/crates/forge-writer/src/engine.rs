//! The engine's features in the written guides (the engine design notes, §4), run on the
//! written chain after the travel repair, in order of player impact:
//!
//! - R1 `along until <label>`: work the route walks past before the step that does it is listed "along the
//!   way" from the accept on, from the first step that comes within reach of its sources (pattern 1), or,
//!   when the work's spawns line the walk on to the turn-in, the stop for it becomes an along step that
//!   ends at the turn-in (pattern 2, Gloom Weed).
//!   Along lists are per guide: a quest carried into another guide gets its along step there, `when
//!   onquest`.
//! - R2 `use <item>`: a quest done by using an item (quest mechanics, high confidence) gets its `use`.
//! - R3 `when` guards: travel steps for quests carried from an earlier guide are `when onquest`; so are
//!   the hand-ins of quests the player may not have picked up (an `optional` or item-started accept, one
//!   listed along the way, and the quests that follow on from them), split from a step's other work; a
//!   hearth to an inn bound in an earlier guide is `when bound`, with the walk there `when !bound`.
//! - R4 fractional `level` (apply.rs: the route's grind items keep their fraction).
//! - R9 where a goal's NPC or object is ("upstairs", "below ground", "inside <cave>", "underwater") and
//!   who walks around, on the goal's note; R10 warnings from the quest notes (ambushes, stealthed mobs,
//!   adds, attacked when you loot) as a step tip (tips.rs).
//!
//! - Route groups: the elite and group quest families the route takes (its `groups`, each order event's
//!   `group`) are asked: every non-along step of the family's work is `when group <root>`, its first
//!   elite work step says how hard it is, and its kills and collections say the group size.
//!
//! Pack format 5 (Polestar 0.3.0) rules, off unless `format_0_3`: R5 `when group`, R6 `task`/`cast`,
//! R7 `abandon` when the log would pass 40, R8 `skipto` over blocks for one carried quest.
//!
//! Positions are world yards (the compiler's resolved goals and spots); a passing leg is first found by
//! the straight line (the prefilter), then confirmed by walking yards where the walk store has them.

use crate::jsre::{is_step, split_comment, starts_nonspace, trim, trim_end};
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

/// Yards from a walk leg within which an objective's spawn area is passed (edge distance): pattern 2's
/// share of spawns lining the walk, and the walk check's detour.
pub const PASS_ALONG_YD: f64 = 150.0;
/// An `along` line needs one of the objective's own spawn points within this many yards of a leg walked
/// while it is listed (#737: the pumpkin field's wide spot edge was "passed" 130 yd from any pumpkin).
pub const ALONG_SPAWN_YD: f64 = 60.0;
/// Steps the work must lie ahead of the first pass for an along step.
const STEPS_AHEAD: usize = 2;
/// Open along goals the addon lists at once.
const ALONG_CAP: usize = 6;
/// An along list is one only when the walk while it is open passes its work: at least half its legs
/// (straight lines between consecutive placed goals, from the step after it up to its label's step; at
/// least two) pass within this many yards of a spawn of the work's sources. Tirisfal's Doom Weed lines
/// the road; Darkshore's Fine Crab Chunks, open for ten stops of which three have crabs, do not (Fitz).
const ALONG_LEG_YD: f64 = 100.0;
/// Legs shorter than this are steps around one place, not a walk.
const ALONG_LEG_MIN_YD: f64 = 30.0;
/// A list that is not along goes to the stop of its span with the most source spawns this close to its
/// placed goals: its work as ordinary goals there.
const ALONG_STOP_YD: f64 = 200.0;
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
	/// R9: where a goal's NPC or object is, and who walks around.
	pub tips: bool,
	/// R10: warnings from the quest notes.
	pub warnings: bool,
	/// Pack format 5 rules (R5-R8).
	pub format_0_3: bool,
	/// The route's group families asked (`when group`), with their tip and group size.
	pub groups: bool,
}

impl Default for Opts {
	fn default() -> Self {
		Opts { along: true, use_items: true, when: true, tips: true, warnings: true, format_0_3: false, groups: true }
	}
}

/// Routed walking yards between two world points, where the walk store has them.
pub trait WalkYards {
	fn yards(&self, a: Wpt, b: Wpt) -> Option<f64>;
	/// The world's zone crossings the walks are under (None: not known).
	fn borders(&self) -> Option<&crate::borders::Borders> {
		None
	}
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
	/// Objectives (quest, objective) never listed on the way (guide-fixes.json `along: false`).
	pub no_along: &'a FxHashSet<(u32, u32)>,
	/// R9: the walking grid's floors and client areas, and spawn heights beyond spawnz.json (the Forever
	/// server data's own spawns: { npc, object } -> id -> [[map, x, y, z, ...]]).
	pub floors: Option<&'a dyn crate::tips::Floors>,
	pub area_at: Option<&'a dyn forge_world::atlas::SubzoneOf>,
	pub heights: Option<&'a V>,
	/// R10: data/local/mechanics/quest-notes.json (`quests`), when present.
	pub notes: Option<&'a Value>,
	/// The route's group families (route `groups`), and each quest of one -> its root quest.
	pub groups: &'a [crate::input::Group],
	pub group_of: &'a FxHashMap<u32, u32>,
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
	pub(crate) fn add(&mut self, rule: &'static str, n: usize) {
		*self.counts.entry(rule).or_default() += n;
	}
}

// ---- the chain as the route's character plays it ----

#[derive(Clone, Copy, Debug)]
pub(crate) struct Spot {
	pub(crate) w: Wpt,
	pub(crate) r: f64,
	n: f64,
}

#[derive(Clone, Debug)]
pub(crate) struct G {
	/// Chain guide, its file's text index.
	pub(crate) gi: usize,
	/// Step index in the guide, and its 1-based line.
	pub(crate) si: usize,
	pub(crate) step_line: u32,
	pub(crate) line: u32,
	pub(crate) verb: String,
	pub(crate) quest: Option<u32>,
	oi: Option<u32>,
	pub(crate) w: Option<Wpt>,
	pub(crate) map: f64,
	pub(crate) spots: Vec<Spot>,
	/// The objective's own spawn points inside its spots (the spot centres when the data has none).
	pub(crate) spawns: Vec<Wpt>,
	pub(crate) item: Option<u32>,
	location: Option<String>,
	/// The compiler's map percent and frame for the goal.
	xy: Option<(f64, f64, bool)>,
	/// The NPC or object the compiler placed the goal at.
	pub(crate) npc: Option<u32>,
	pub(crate) object: Option<u32>,
	/// The walk of the NPC the goal is at (forge_guide::walks): centre wx, wy and radius, world yards.
	pub(crate) walk: Option<(f64, f64, f64)>,
	/// A `goto` the compiler gave an area (a cave's or subzone's way in): kept wherever it stands.
	pub(crate) area: bool,
}

pub(crate) struct Chain {
	pub(crate) files: Vec<String>,
	pub(crate) seq: Vec<G>,
	/// Per guide: (step line, has `when`, has `label` value, has `along`, `only` V) by step index.
	pub(crate) steps: Vec<Vec<StepMeta>>,
}

#[derive(Clone, Debug)]
pub(crate) struct StepMeta {
	pub(crate) line: u32,
	pub(crate) when: bool,
	label: Option<String>,
	pub(crate) along: bool,
}

fn num(v: &V) -> Option<f64> {
	let n = v.num();
	(!v.is_nullish() && n.is_finite()).then_some(n)
}

fn id(v: &V) -> Option<u32> {
	num(v).filter(|n| *n >= 0.0 && n.fract() == 0.0).map(|n| n as u32)
}

/// A field goal's own spawn points on `map` inside its spots: [`source_spawns`] there. The spot centres
/// when the data places none there.
fn spawn_points(data: &Data, goal: &V, map: f64, spots: &[Spot], world: &dyn Fn(f64, f64, f64, &V) -> Option<Wpt>) -> Vec<Wpt> {
	let mut out = source_spawns(data, id(&goal.get("npc")), id(&goal.get("object")), id(&goal.get("item")), map, world);
	out.retain(|w| spots.iter().any(|sp| dist(sp.w, *w) <= sp.r + 1.0));
	if out.is_empty() {
		out = spots.iter().map(|s| s.w).collect();
	}
	out
}

/// The spawn points on `map` of a goal's [`sources`].
fn source_spawns(data: &Data, npc: Option<u32>, object: Option<u32>, item: Option<u32>, map: f64, world: &dyn Fn(f64, f64, f64, &V) -> Option<Wpt>) -> Vec<Wpt> {
	sources(data, npc, object, item).into_iter().flat_map(|(kind, id)| kind_spawns(data, kind, id, map, world)).collect()
}

/// A goal's sources: the target NPC or object, or for an item its droppers (at least [`DROP_MIN`]
/// percent, or of unknown odds) and the objects that hold it.
fn sources(data: &Data, npc: Option<u32>, object: Option<u32>, item: Option<u32>) -> Vec<(&'static str, u32)> {
	let mut out: Vec<(&'static str, u32)> = [("npc", npc), ("object", object)].into_iter().filter_map(|(k, x)| Some((k, x?))).collect();
	if let Some(item) = item {
		let drops = data.item(&V::Num(item as f64)).get("drops");
		for kind in ["npc", "object"] {
			let by = drops.get(kind);
			for k in by.keys() {
				let chance = num(&by.get(&k)).unwrap_or(0.0);
				if chance <= 0.0 || chance >= DROP_MIN {
					out.push((kind, forge_guide::js::str_to_num(&k) as u32));
				}
			}
		}
	}
	out
}

/// The spawn points on `map` of NPC or object `id`.
fn kind_spawns(data: &Data, kind: &str, id: u32, map: f64, world: &dyn Fn(f64, f64, f64, &V) -> Option<Wpt>) -> Vec<Wpt> {
	let mut out = Vec::new();
	for s in data.spawns(kind, &V::Num(id as f64)) {
		if s.get("map").num() != map {
			continue;
		}
		let f = s.get("f");
		for p in s.get("pts").items().into_iter().chain(s.get("more").items()) {
			if let Some(w) = world(map, p.at(0).num(), p.at(1).num(), &f) {
				out.push(w);
			}
		}
	}
	out
}

/// The compass point from `a` to `b` (world yards: x north, y west).
fn compass(a: Wpt, b: Wpt) -> &'static str {
	let deg = (b.wy - a.wy).atan2(b.wx - a.wx).to_degrees(); // 0 north, 90 west
	const POINTS: [&str; 8] = ["north", "north-west", "west", "south-west", "south", "south-east", "east", "north-east"];
	POINTS[(((deg + 360.0 + 22.5) % 360.0) / 45.0) as usize % 8]
}

/// The note of a list's goal made an ordinary goal at a stop (`here`: the stop's placed goals): what
/// drops it, the sources with spawns within ALONG_STOP_YD, and where they are from the stop's goal with
/// most of them near ("Fine Crab Chunks from Reef Crawler and Encrusted Tide Crawler, 90 yd north-west").
fn where_note(data: &Data, world: &dyn Fn(f64, f64, f64, &V) -> Option<Wpt>, wg: &G, here: &[Wpt]) -> Option<String> {
	let item = if wg.verb == "collect" { wg.item.and_then(|it| name_of(data, "item", it)) } else { None };
	let mut names: Vec<String> = Vec::new();
	let mut all: Vec<Wpt> = Vec::new();
	for (k, id) in sources(data, wg.npc, wg.object, wg.item) {
		let pts: Vec<Wpt> = kind_spawns(data, k, id, wg.map, world).into_iter().filter(|s| here.iter().any(|h| dist(*s, *h) <= ALONG_STOP_YD)).collect();
		let Some(nm) = name_of(data, k, id).filter(|_| !pts.is_empty()) else { continue };
		// (Not the item's own name again: a Moonpetal Lily from the Moonpetal Lily.)
		if !names.contains(&nm) && Some(&nm) != item.as_ref() {
			names.push(nm);
		}
		all.extend(pts);
	}
	let h = *here.iter().max_by_key(|h| all.iter().filter(|s| dist(**s, **h) <= ALONG_STOP_YD).count())?;
	let pts: Vec<&Wpt> = all.iter().filter(|s| dist(**s, h) <= ALONG_STOP_YD).collect();
	if pts.is_empty() {
		return None;
	}
	let n = pts.len() as f64;
	let c = Wpt { wx: pts.iter().map(|p| p.wx).sum::<f64>() / n, wy: pts.iter().map(|p| p.wy).sum::<f64>() / n, ..h };
	let d = dist(h, c);
	let place = if d < 60.0 { "by this stop".to_string() } else { format!("{} yd {}", (d / 10.0).round() as i64 * 10, compass(h, c)) };
	let who = match names.len() {
		0 => String::new(),
		1 => names[0].clone(),
		2 | 3 => format!("{} and {}", names[..names.len() - 1].join(", "), names[names.len() - 1]),
		_ => format!("{}, {} and others", names[0], names[1]),
	};
	Some(match (item, who.is_empty()) {
		(Some(it), false) => format!("{it} from {who}, {place}"),
		(Some(it), true) => format!("{it}, {place}"),
		(None, _) => format!("{who}, {place}"),
	})
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
				// (Every spot, the alternatives too, holds spawns the player kills or loots in passing; the
				// arrow walks only the others.)
				let all_spots: Vec<(bool, Spot)> = match map {
					Some(m) => x
						.get("spots")
						.items()
						.iter()
						.filter_map(|p| {
							Some((p.get("alt").truthy(), Spot { w: world(m, num(&p.get("x"))?, num(&p.get("y"))?, &f)?, r: num(&p.get("r")).unwrap_or(0.0), n: num(&p.get("n")).unwrap_or(1.0) }))
						})
						.collect(),
					None => Vec::new(),
				};
				let spawns = map.map(|m| spawn_points(data, x, m, &all_spots.iter().map(|s| s.1).collect::<Vec<_>>(), &world)).unwrap_or_default();
				let spots: Vec<Spot> = all_spots.into_iter().filter(|s| !s.0).map(|s| s.1).collect();
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
					spawns,
					item: id(&x.get("item")),
					location: x.get("location").as_str().map(str::to_string),
					xy: num(&x.get("x")).zip(num(&x.get("y"))).map(|(a, b)| (a, b, f.as_str() != Some("e"))),
					npc: id(&x.get("npc")),
					object: id(&x.get("object")),
					walk: forge_guide::walks::npc_walk(data, x).map(|w| (w.1, w.2, w.3)),
					area: x.get("area").truthy(),
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
pub(crate) struct Edits {
	/// line index (0-based) -> lines before it.
	pub(crate) before: BTreeMap<usize, Vec<String>>,
	/// line index -> lines after it.
	pub(crate) after: BTreeMap<usize, Vec<String>>,
	pub(crate) removed: FxHashSet<usize>,
	pub(crate) replaced: FxHashMap<usize, String>,
	/// line index -> a word the goal gains (` group 3`), before its comment.
	pub(crate) suffix: FxHashMap<usize, String>,
}

impl Edits {
	/// Line `l` of `lines` as written: replaced, with its suffix.
	fn line(&self, lines: &[String], l: usize) -> String {
		let s = self.replaced.get(&l).cloned().unwrap_or_else(|| lines[l].clone());
		match self.suffix.get(&l) {
			Some(w) => with_word(&s, w),
			None => s,
		}
	}

	fn apply(&self, text: &str) -> String {
		let lines: Vec<&str> = text.split('\n').collect();
		let mut out: Vec<String> = Vec::with_capacity(lines.len() + 16);
		for (i, l) in lines.iter().enumerate() {
			if let Some(b) = self.before.get(&i) {
				out.extend(b.iter().cloned());
			}
			if !self.removed.contains(&i) {
				let s = self.replaced.get(&i).cloned().unwrap_or_else(|| l.to_string());
				out.push(match self.suffix.get(&i) {
					Some(w) => with_word(&s, w),
					None => s,
				});
			}
			if let Some(a) = self.after.get(&i) {
				out.extend(a.iter().cloned());
			}
		}
		no_empty_steps(out).join("\n")
	}
}

/// The last line of the step starting at 0-based `s` (its last indented line).
pub(crate) fn step_last(lines: &[&str], s: usize) -> usize {
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

/// The goal lines (0-based) of the step whose header is line `s`.
fn step_goal_lines(lines: &[String], s: usize) -> Vec<usize> {
	let refs: Vec<&str> = lines.iter().map(String::as_str).collect();
	(s + 1..=step_last(&refs, s)).filter(|&l| crate::guide::is_goal(&lines[l])).collect()
}

/// Splits the guarded goal lines `hand` ((0-based line, quest)) of the step whose header is line `s` into
/// steps of their own, in place: each run of them becomes a step with the step's title, its `only`,
/// `zone` and `when` lines and `when onquest <their quests>`; the step's other work after a run, another
/// step with that title. A run that opens the step goes before it, with the step's tip and picture (the
/// step keeps them, and its label, for the player who has no such quest). -> the guarded steps written
/// (none when a line of the step is already edited).
fn split_guarded(lines: &[String], s: usize, hand: &[(usize, u32)], pre_of: &dyn Fn(u32) -> Vec<u32>, e: &mut Edits) -> usize {
	let refs: Vec<&str> = lines.iter().map(String::as_str).collect();
	let end = step_last(&refs, s);
	if (s + 1..=end).any(|l| e.removed.contains(&l) || e.replaced.contains_key(&l) || e.before.contains_key(&l) || e.after.contains_key(&l)) {
		return 0;
	}
	let every: Vec<String> = (s + 1..=end).filter(|&l| matches!(crate::jsre::head(&lines[l]), Some("only" | "zone" | "when"))).map(|l| lines[l].clone()).collect();
	let guarded = |l: usize| hand.iter().find(|h| h.0 == l).map(|h| h.1);
	// (A guarded hand-in that opens an accept written before it in the step goes first: the chain's order,
	// Thrall's 95350 hand-in before his follow-ups 98024 and 93739, c14 Skyborne.)
	let mut goal_lines = step_goal_lines(lines, s);
	let accept_q = |l: usize| re!(r"^\s+accept\s+(\d+)\b").captures(&lines[l]).and_then(|m| m[1].parse::<u32>().ok());
	let opens = |l: usize| guarded(l).is_some_and(|q| goal_lines.iter().take_while(|&&m| m != l).any(|&m| accept_q(m).is_some_and(|a| pre_of(a).contains(&q))));
	let first: Vec<usize> = goal_lines.iter().copied().filter(|&l| opens(l)).collect();
	if !first.is_empty() {
		goal_lines.retain(|l| !first.contains(l));
		goal_lines.splice(0..0, first);
	}
	let mut runs: Vec<(bool, Vec<usize>)> = Vec::new();
	for l in goal_lines {
		let g = guarded(l).is_some();
		match runs.last_mut() {
			Some(r) if r.0 == g => r.1.push(l),
			_ => runs.push((g, vec![l])),
		}
	}
	if runs.len() < 2 {
		return 0;
	}
	let header = |run: &[usize], guard: bool| -> Vec<String> {
		let mut v = vec![lines[s].clone()];
		v.extend(every.iter().cloned());
		if guard {
			let mut qs: Vec<u32> = Vec::new();
			for q in run.iter().filter_map(|&l| guarded(l)) {
				if !qs.contains(&q) {
					qs.push(q);
				}
			}
			v.push(format!("  when onquest {}", qs.iter().map(u32::to_string).collect::<Vec<_>>().join(",")));
		}
		v
	};
	let mut n = 0;
	for (k, (guard, run)) in runs.iter().enumerate() {
		if k == 0 && *guard {
			let mut b = header(run, true);
			b.extend((s + 1..=end).filter(|&l| matches!(crate::jsre::head(&lines[l]), Some("tip" | "image"))).map(|l| lines[l].clone()));
			for &l in run {
				b.push(lines[l].clone());
				e.removed.insert(l);
			}
			b.push(String::new());
			e.before.entry(s).or_default().extend(b);
		} else if k > 0 && !(k == 1 && runs[0].0) {
			let mut b = vec![String::new()];
			b.extend(header(run, *guard));
			e.before.entry(run[0]).or_default().extend(b);
		}
		n += usize::from(*guard);
	}
	n
}

/// `line` with `word` after its code, before its comment (`kill 1234 quest 5 group 3 -- ...`).
fn with_word(line: &str, word: &str) -> String {
	let (c, rest) = split_comment(line);
	format!("{} {word}{rest}", c.trim_end())
}

/// `line` without its `optional` word, its comment where it was (`accept 790 optional   -- x` ->
/// `accept 790            -- x`).
fn required(line: &str) -> String {
	let (code, rest) = split_comment(line);
	let Some(m) = re!(r"\s+optional\b").find(code) else { return line.to_string() };
	let out = format!("{}{}", &code[..m.start()], &code[m.end()..]);
	if rest.is_empty() {
		return trim_end(&out).to_string();
	}
	format!("{out:<w$}{rest}", w = code.chars().count())
}

/// Asked group work (R5, the route's group families): every non-along step holding a goal of a family
/// (`fam`: quest -> the root quest asked about) gets `when group <root>`: in place when the step holds
/// only that family's goals and no `when`, else the family's goals move to a copy of the step right
/// after it, headed `when group <root>` (with the step's `only`). `tips`: the lines a family's step
/// gains after its `when`, by step. `gq`: a goal's quest (a bag collect of the item that starts a family
/// quest is that quest's: Croaky's Head, #977). The family's goals lose `optional`: only a player who
/// chose the group way follows the step, and a step of optional goals only is done at once, so that
/// player got no arrow to the accept, the elite or the hand-in (the Monogrammed Sash, Margol's Horn).
#[allow(clippy::too_many_arguments)]
fn ask_group(
	ch: &Chain,
	texts: &[Vec<String>],
	by_step: &BTreeMap<(usize, usize), Vec<usize>>,
	fam: &dyn Fn(u32) -> Option<u32>,
	gq: &dyn Fn(&G) -> Option<u32>,
	tips: &FxHashMap<(usize, usize), Vec<(u32, String)>>,
	step_only: &dyn Fn(usize, u32) -> Option<String>,
	edits: &mut [Edits],
	touched: &mut FxHashSet<(usize, usize)>,
	rep: &mut Report,
	rule: &'static str,
) {
	let seq = &ch.seq;
	for (&(gi, si), idx) in by_step {
		let meta = &ch.steps[gi][si];
		let mut roots: Vec<u32> = Vec::new();
		for r in idx.iter().filter_map(|&i| gq(&seq[i]).and_then(fam)) {
			if !roots.contains(&r) {
				roots.push(r);
			}
		}
		if roots.is_empty() || meta.along {
			continue;
		}
		let tip = |r: u32| tips.get(&(gi, si)).into_iter().flatten().filter(move |t| t.0 == r).map(|t| t.1.clone());
		let all: Vec<usize> = idx.iter().copied().filter(|&i| gq(&seq[i]).is_some()).collect();
		if roots.len() == 1 && !meta.when && !touched.contains(&(gi, si)) && all.iter().all(|&i| gq(&seq[i]).and_then(fam) == Some(roots[0])) {
			for &i in &all {
				let l = seq[i].line as usize - 1;
				let s = edits[gi].replaced.get(&l).unwrap_or(&texts[gi][l]);
				let r = required(s);
				if r != *s {
					edits[gi].replaced.insert(l, r);
				}
			}
			let at = edits[gi].after.entry(meta.line as usize - 1).or_default();
			at.push(format!("  when group {}", roots[0]));
			at.extend(tip(roots[0]));
			touched.insert((gi, si));
			rep.add(rule, 1);
			continue;
		}
		// Its lines in a step of their own after the step, asked for.
		let lines_ = texts[gi].iter().map(String::as_str).collect::<Vec<_>>();
		let s0 = meta.line as usize - 1;
		let e = step_last(&lines_, s0);
		// (Each family's step after the one before: Sprogger's hand-in of 8553 (8552's family), then
		// his accept of 8554 (its own), not the other way round, c17 not-ready.)
		let mut k = None;
		for r in roots {
			let mut b = vec![String::new(), texts[gi][s0].clone(), format!("  when group {r}")];
			if let Some(o) = step_only(gi, meta.line) {
				b.push(o);
			}
			b.extend(tip(r));
			for &i in all.iter().filter(|&&i| gq(&seq[i]).and_then(fam) == Some(r)) {
				let l = seq[i].line as usize - 1;
				if edits[gi].removed.insert(l) {
					b.push(required(&edits[gi].line(&texts[gi], l)));
				}
			}
			// Before the along steps that follow the step (their goals come after the accept).
			let at = edits[gi].after.entry(e).or_default();
			let k0 = *k.get_or_insert_with(|| at.iter().position(|l| l.starts_with("step ")).map_or(at.len(), |k| k.saturating_sub(1)));
			let n = b.len();
			at.splice(k0..k0, b);
			k = Some(k0 + n);
			rep.add(rule, 1);
		}
	}
}

/// A group family's tip, in plain words: grouping is encouraged, how hard its elites are (`size` 1: one
/// most classes solo two levels above it), and that a player alone may skip it (the route's solo
/// fallback gives the XP back). A family with no mobs placed (its work an event): the quest is named.
fn group_tip(g: Option<&crate::input::Group>) -> String {
	let num = |x: f64| if x.fract() == 0.0 { format!("{}", x as i64) } else { format!("{x}") };
	let mut s = String::from("These are elite mobs: grouping up is encouraged, look for people to do it with.");
	let hard = g.and_then(|g| {
		let names: Vec<&str> = g.mobs.iter().filter_map(|m| m.name.as_deref()).filter(|n| !n.is_empty()).collect();
		let level = g.level.or_else(|| g.mobs.iter().filter_map(|m| m.level).reduce(f64::max));
		let size = g.size.unwrap_or(1);
		let who = match names.as_slice() {
			[] => {
				let title = g.title.as_deref().filter(|t| !t.is_empty())?;
				return Some(match (size, level) {
					(0 | 1, Some(l)) => format!("{title} has level {} elites: most classes solo it at level {}, but you may need help.", num(l), num(l + 2.0)),
					(0 | 1, None) => return None,
					(n, _) => format!("{title} needs a group of {n}."),
				});
			}
			[a] => a.to_string(),
			[a, b] => format!("{a} and {b}"),
			[a, b, ..] => format!("{a}, {b} and others"),
		};
		let level = level?;
		let many = names.len() > 1;
		Some(match size {
			0 | 1 if many => format!("{who} are level {} elites: most classes solo them at level {}, but you may need help.", num(level), num(level + 2.0)),
			0 | 1 => format!("{who} is a level {} elite: most classes solo it at level {}, but you may need help.", num(level), num(level + 2.0)),
			n if many => format!("{who} (level {} elites) need a group of {n}.", num(level)),
			n => format!("{who} (level {} elite) needs a group of {n}.", num(level)),
		})
	});
	if let Some(h) = hard {
		s.push(' ');
		s.push_str(&h);
	}
	s.push_str(" Skip it if you are alone: the route has you grind the XP back.");
	// (A title's or name's double quotes would end the tip's text early: Wanted:  "Hogger".)
	s.replace('"', "'")
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
			// A drop from droppers of several level bands is worked at the low ones' camp, never
			// "on the way" over the whole zone (Bashidian Twotao, #385).
			let qlvl = num(&quest_v(data, q).get("level")).unwrap_or(0.0);
			if drops.get("npc").keys().iter().any(|n| {
				let npc = data.npcs.get(n);
				pts("npc", n.parse().unwrap_or(0)) > 0 && num(&npc.get("level")).is_some_and(|l| l > qlvl + 2.0)
			}) {
				return None;
			}
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
	work: Vec<AlongWork>,
	/// The spawn points of the work's sources (source_spawns, else the objective's own points).
	src: Vec<Wpt>,
	rank: usize,
	from_si: usize,
	/// The goals' zone when it is not the zone in effect where the step goes (Crushridge ogres for
	/// the Recovered Tome in Alterac, the step after Southshore's accept, #246).
	zone: Option<String>,
}

/// A goal an along step lists.
struct AlongWork {
	/// Its line in the along step.
	line: String,
	/// Its line as an ordinary goal (no note), when the list is not along.
	plain: String,
	q: u32,
	oi: u32,
	/// Pattern 2: the stop's own line, taken out for the along step.
	stop: Option<usize>,
	/// The work goal (seq index).
	g: usize,
}

/// The zone in effect at 0-based line `at`: the last `zone` line at or before it.
fn zone_at(lines: &[String], at: usize) -> Option<String> {
	lines[..=at.min(lines.len().saturating_sub(1))].iter().rev().find_map(|l| re!(r"^\s*zone\s+(.+)$").captures(l).map(|m| trim(&m[1]).to_string()))
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
	// A quest the player is asked about (`when group`): R5's, or one of the route's group families.
	let asked = |q: u32| (opts.format_0_3 && group(q)) || (opts.groups && inp.group_of.contains_key(&q));
	// Steps the rules below edit (one rule per step line).
	let mut touched: FxHashSet<(usize, usize)> = FxHashSet::default();

	// ---- R1: along ----
	if opts.along {
		// The route fixes' orders (a before b), which a merge or an along line must not break.
		let pairs = crate::hub::fix_pairs(t.faction.as_deref());
		let geo = Geo::new(&data.map_frames);
		let world = |map: f64, x: f64, y: f64, f: &V| -> Option<Wpt> { geo.to_world(map as i64, x, y, f.as_str() == Some("e")) };
		// The spawn points of a work goal's sources on its map; with no source the data drops it from at
		// DROP_MIN (a Swoop Gizzard), the objective's own points.
		let sources_of = |g: &G| -> Vec<Wpt> {
			let all = source_spawns(data, g.npc, g.object, g.item, g.map, &world);
			if all.is_empty() {
				g.spawns.clone()
			} else {
				all
			}
		};
		let first_of = |t: crate::input::OrderT, qa: u32| -> Option<usize> {
			match t {
				crate::input::OrderT::Accept => first_accept.get(&qa).copied(),
				crate::input::OrderT::Turnin => first_turnin.get(&qa).copied(),
				_ => seq.iter().position(|x| x.quest == Some(qa) && matches!(x.verb.as_str(), "kill" | "collect" | "interact" | "use" | "complete")),
			}
		};
		// (Quest q's work at walk index i is ahead of an event the route fixes put before it: Shaky's
		// giblets listed along the way before Unbagwa's accept, overrides.pairs[54].)
		let held_at = |q: u32, i: usize| pairs.iter().any(|(pa, pb)| *pb == (crate::input::OrderT::Task, q) && first_of(pa.0, pa.1).is_none_or(|ai| ai > i));
		let mut work: BTreeMap<(u32, u32), Vec<usize>> = BTreeMap::new();
		// (A step searched as one circuit, `loop`, keeps its work: made an onward along step (pattern
		// 2), it would leave the circuit with nothing to search for. Listed on the way before it
		// (pattern 1) it stays.)
		let in_loop = |gi: usize, step_line: u32| texts[gi].iter().skip(step_line as usize).take_while(|l| !is_step(l) && !l.trim().is_empty()).any(|l| l.trim() == "loop");
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
			if idx.len() != 1 || in_loop(seq[idx[0]].gi, seq[idx[0]].step_line) {
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
			// (And the walk comes by the work itself, not only by its spots' edges.)
			if !wg.spawns.iter().any(|s| pts.windows(2).any(|ab| seg_dist(*s, ab[0], ab[1]) <= ALONG_SPAWN_YD)) {
				continue;
			}
			if asked(q) {
				continue;
			}
			if inp.no_along.contains(&(q, oi)) || held_at(q, i) {
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
			// Listed from the stop's step on: before it when the quest was taken earlier, so its walk's
			// own end (a cave's mouth, LD-22) stays the last place before the turn-in; after it when the
			// step takes the quest (Gordo).
			let after = first_accept.get(&q).is_some_and(|&a| pos(a) == pos(i));
			let mut at = if after { step_last(&lines_, wg.step_line as usize - 1) } else { wg.step_line as usize - 1 };
			// (Nor between a waypoint step and the stop it leads into: before the way there too, the
			// mouth of Shadowthread Cave before the Webwood Eggs.)
			if !after {
				while let Some(prev) = (0..at).rev().find(|&j| crate::jsre::is_step(lines_[j])) {
					let goals: Vec<&str> = lines_[prev + 1..=step_last(&lines_, prev)].iter().copied().filter(|l| crate::guide::is_goal(l)).collect();
					if goals.is_empty() || !goals.iter().all(|l| re!(r"^\s+goto\s").is_match(l)) {
						break;
					}
					at = prev;
				}
			}
			let line = format!("{}{}", strip_place(code), if place.is_empty() { String::new() } else { format!(" -- {src} along the way to {place}") });
			let work = AlongWork { line, plain: strip_place(code), q, oi, stop: Some(stop), g: i };
			if let Some(x) = along.iter_mut().find(|x| x.gi == wg.gi && x.at == at && x.after == after && x.until == until) {
				x.work.push(work);
				x.src.extend(sources_of(wg));
				x.title = "On the way".into();
				done_p2.insert((q, oi));
				continue;
			}
			along.push(AlongStep {
				gi: wg.gi,
				at,
				after,
				until,
				until_si,
				when: None,
				only: step_only(wg.gi, wg.step_line),
				title: format!("{src} on the way"),
				work: vec![work],
				src: sources_of(wg),
				rank: usize::MAX,
				from_si: wg.si,
				// (Beside the goal's own step: its zone.)
				zone: None,
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
						let near: Vec<Wpt> = seq[w].spawns.iter().copied().filter(|s| seg_dist(*s, a, p) <= ALONG_SPAWN_YD).collect();
						if near.is_empty() {
							continue;
						}
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
			// (Every pass not listed is counted by its reason: what the on-the-way lists miss.)
			if ahead < STEPS_AHEAD {
				rep.add("R1 passed, not listed: worked within two steps", 1);
				continue;
			}
			// (A group quest the player is asked about is not listed before they answer.)
			if asked(q) {
				rep.add("R1 passed, not listed: group quest", 1);
				continue;
			}
			if inp.no_along.contains(&(q, oi)) {
				rep.add("R1 passed, not listed: guide-fixes along false", 1);
				continue;
			}
			if held_at(q, p.first_cur) {
				rep.add("R1 passed, not listed: a route fix orders its work later", 1);
				continue;
			}
			let Some(src) = along_source(data, inp.mechanics, q, oi, p.n) else {
				rep.add("R1 passed, not listed: source (named mob, rare drop, used item)", 1);
				continue;
			};
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
			// (Its spawns on the ground of a step the list would run past, the work there: done in that
			// step, and listed along only up to it. The Graverobbers and their ichor on top of Brill's Doom Weed, Fitz
			// in game c14. The judge's `merge` overlap, so the two agree.)
			let mut host_si: Option<usize> = None;
			if wg.gi == gi && !carried {
				// (The judge's overlap: the nearest spot centres of the two areas.)
				let gap = |a: &G, b: &G| a.spots.iter().flat_map(|s| b.spots.iter().filter(move |t| s.w.c == t.w.c).map(move |t| dist(s.w, t.w))).fold(f64::INFINITY, f64::min);
				let own_only = step_only(wg.gi, wg.step_line);
				let ok = |h: &G| {
					h.gi == gi
						&& h.si > from_si
						&& h.si < wg.si
						&& matches!(h.verb.as_str(), "kill" | "collect" | "interact")
						&& (h.quest, h.oi) != (Some(q), Some(oi))
						&& !re!(r"\boptional\b").is_match(line_text(h))
						&& !ch.steps[gi][h.si].when
						&& !ch.steps[gi][h.si].along
						&& !in_loop(gi, h.step_line)
						&& step_only(gi, h.step_line) == own_only
						&& gap(h, wg) <= forge_judge::check::OVERLAP_YD
				};
				// The first such step, beside its goal nearest the objective's spawns.
				let host = seq.iter().find(|h| ok(h)).and_then(|f| seq.iter().filter(|h| h.si == f.si && ok(h)).min_by(|a, b| gap(a, wg).total_cmp(&gap(b, wg))));
				// (Not ahead of an event the route fixes put before this objective's work: Gold Dust in
				// the Fargodeep Mine after Kobold Candles' accept, pairs[21].)
				let hi = host.and_then(|h| seq.iter().position(|x| std::ptr::eq(x, h)));
				let held = hi.is_some_and(|hi| held_at(q, hi));
				if let Some(h) = host.filter(|_| !held) {
					let line = strip_place(split_comment(line_text(wg)).0);
					let at_line = h.line as usize - 1;
					let e = edits[gi].after.entry(at_line).or_default();
					if !e.contains(&line) {
						e.push(line);
					}
					rep.add("R1 merged into the step on its ground", 1);
					rep.log.push(format!("R1 merged: {} quest {q}.{oi} into the step at line {}", ch.files[gi], h.step_line));
					host_si = Some(h.si);
				}
			}
			let end_si = host_si.unwrap_or(wg.si);
			// (From the accept's step, listed from where the work comes within reach: the first step with a
			// placed goal within a trip (TRIP_YD) of a spawn of the work's sources, or the step the walk
			// passes them on the way to, whichever comes first; right before the list's end at the latest.
			// Darkshore's Fine Crab Chunks drop from the crabs of the north coast and the far south: listed
			// from the southern beaches on, not from Auberdine, whose beach has only Pygmy Tide Crawlers, Fitz.)
			let wsrc = sources_of(wg);
			let (at, after, from_si) = if carried {
				(at, after, from_si)
			} else {
				let end = if wg.gi == gi { end_si } else { ch.steps[gi].len() };
				let near = seq
					.iter()
					.filter(|g| g.gi == gi && g.si >= from_si && g.si < end && !ch.steps[gi][g.si].along)
					.find(|g| g.w.is_some_and(|w| wsrc.iter().any(|s| dist(*s, w) <= forge_judge::check::TRIP_YD)))
					.map(|g| g.si);
				let start = near.unwrap_or(end).min(cur.si).min(end);
				if start <= from_si + 1 {
					(at, after, from_si)
				} else {
					rep.log.push(format!("R1 along from where its work is within reach: {} quest {q}.{oi} from the step at line {}", ch.files[gi], ch.steps[gi][start].line));
					(ch.steps[gi][start].line as usize - 1, false, start - 1)
				}
			};
			let (until, until_si) = if wg.gi == gi { (Some(labels.of(&ch, gi, end_si, q)), Some(end_si)) } else { (None, None) };
			let text = line_text(wg).to_string();
			let line = strip_place(split_comment(&text).0);
			let only = step_only(wg.gi, wg.step_line);
			let here = zone_at(&texts[gi], if after { at } else { at.saturating_sub(1) });
			let own = data.zones.get(&(wg.map as u32).to_string()).get("name");
			let zone = (own.truthy() && Some(own.to_js_string()) != here).then(|| own.to_js_string());
			let work = AlongWork { line: line.clone(), plain: line, q, oi, stop: None, g: p.work };
			match by_guide[gi].iter_mut().find(|x| x.at == at && x.after == after && x.until == until && x.when == carried.then_some(q) && x.only == only && x.zone == zone) {
				Some(x) => {
					if !x.work.iter().any(|w| w.line == work.line) {
						x.work.push(work);
						x.src.extend(wsrc);
						x.title = "On the way".into();
						x.rank = x.rank.max(p.n);
					}
				}
				None => by_guide[gi].push(AlongStep {
					gi,
					at,
					after,
					until,
					until_si,
					when: carried.then_some(q),
					only,
					title: format!("{src} on the way"),
					work: vec![work],
					src: wsrc,
					rank: p.n,
					from_si,
					zone,
				}),
			}
		}
		// At most ALONG_CAP open along goals at once, the most-passed first. A list whose walk does not pass
		// its work (ALONG_LEG_YD) is no list: its goals go to the stop of its span with most of the work near.
		let mut used: FxHashSet<(usize, String)> = FxHashSet::default();
		let mut unlisted: Vec<(usize, String)> = Vec::new();
		for (gi, steps) in by_guide.iter_mut().enumerate() {
			steps.sort_by_key(|x| std::cmp::Reverse(x.rank));
			let mut kept: Vec<(usize, usize, usize)> = Vec::new(); // (from, to, goals)
			for a in steps.iter() {
				// The route while it is open: the placed goals from the step after it up to its label's step
				// (not the stops pattern 2 took out for it).
				let first = ch.steps[gi].iter().position(|m| if a.after { m.line as usize - 1 > a.at } else { m.line as usize > a.at }).unwrap_or(ch.steps[gi].len());
				let last = a.until_si.unwrap_or(ch.steps[gi].len().saturating_sub(1));
				let in_span = |g: &G| g.gi == gi && g.si >= first && g.si <= last && !ch.steps[gi][g.si].along && !edits[gi].removed.contains(&(g.line as usize - 1));
				let span: Vec<(usize, Wpt)> = seq.iter().filter(|g| in_span(g)).filter_map(|g| Some((g.si, g.w?))).collect();
				let (mut legs, mut near) = (0, 0);
				for ab in span.windows(2) {
					let (p, q) = (ab[0].1, ab[1].1);
					if p.c != q.c || dist(p, q) < ALONG_LEG_MIN_YD {
						continue;
					}
					legs += 1;
					if a.src.iter().any(|s| seg_dist(*s, p, q) <= ALONG_LEG_YD) {
						near += 1;
					}
				}
				if legs < 2 || near * 2 < legs {
					// The stop: most source spawns within ALONG_STOP_YD of its placed goals (the earliest of
					// equals; pattern 2's own stop is one), a step for the list's own characters (no `only`,
					// or the list's); without a placed goal in the span, the label's step. With none of the
					// work near any stop the list stays.
					let own = |g: &G| g.gi == gi && a.work.iter().any(|w| w.stop == Some(g.line as usize - 1));
					let for_all = |g: &G| step_only(gi, ch.steps[gi][g.si].line).is_none_or(|o| Some(&o) == a.only.as_ref());
					let stops: Vec<(usize, Wpt)> = seq.iter().filter(|g| (in_span(g) && for_all(g)) || own(g)).filter_map(|g| Some((g.si, g.w?))).collect();
					let mut best: Option<(usize, usize)> = None;
					for &(si, _) in &stops {
						if best.is_some_and(|b| b.0 == si) {
							continue;
						}
						let n = a.src.iter().filter(|s| stops.iter().any(|&(k, w)| k == si && dist(**s, w) <= ALONG_STOP_YD)).count();
						if best.is_none_or(|b| n > b.1) {
							best = Some((si, n));
						}
					}
					let to = match best {
						Some((si, n)) => (n > 0).then_some(si),
						None => a.until_si,
					};
					if to.is_none() {
						rep.log.push(format!("R1 along kept, no stop near its work (its legs pass it {near} of {legs}): {} {}", ch.files[gi], a.title));
					}
					if let Some(si) = to {
						let lines_ = texts[gi].iter().map(String::as_str).collect::<Vec<_>>();
						let head = ch.steps[gi][si].line as usize - 1;
						let end = step_last(&lines_, head);
						for w in &a.work {
							// (Its own stop's line, pattern 2, comes back; an objective the stop works already is
							// not written twice; before the stop's hand-in of its quest.)
							if let Some(s) = w.stop.filter(|&s| s > head && s <= end) {
								edits[gi].removed.remove(&s);
								continue;
							}
							let mine = |g: &&G| g.gi == gi && g.si == si && g.quest == Some(w.q);
							let merged = edits[gi].after.range(head..=end).any(|(_, v)| v.iter().any(|l| split_comment(l).0.trim_end() == w.plain));
							if merged || seq.iter().filter(mine).any(|g| g.oi == Some(w.oi) && matches!(g.verb.as_str(), "kill" | "collect" | "interact")) {
								continue;
							}
							let here: Vec<Wpt> = stops.iter().filter(|x| x.0 == si).map(|x| x.1).collect();
							let line = match where_note(data, &world, &seq[w.g], &here) {
								Some(n) => format!("{:<45} -- {n}", w.plain),
								None => w.plain.clone(),
							};
							match seq.iter().filter(mine).find(|g| g.verb == "turnin") {
								Some(t) => edits[gi].before.entry(t.line as usize - 1).or_default().push(line),
								None => edits[gi].after.entry(end).or_default().push(line),
							}
						}
						rep.log.push(format!("R1 not along (its legs pass the work {near} of {legs}): {} {} into the step at line {}", ch.files[gi], a.title, head + 1));
						rep.add("R1 not along: ordinary goals at its stop", a.work.len());
						if let Some(u) = &a.until {
							unlisted.push((gi, u.clone()));
						}
						continue;
					}
				}
				let to = a.until_si.unwrap_or(usize::MAX);
				let open: usize = kept.iter().filter(|(f, t, _)| *f <= to && a.from_si <= *t).map(|x| x.2).sum();
				if open + a.work.len() > ALONG_CAP {
					rep.log.push(format!("R1 along over the cap of {ALONG_CAP}: {} {}", ch.files[gi], a.title));
					rep.add("R1 passed, not listed: over the cap of open along goals", a.work.len());
					continue;
				}
				kept.push((a.from_si, to, a.work.len()));
				if let Some(u) = &a.until {
					used.insert((gi, u.clone()));
				}
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
				if let Some(z) = &a.zone {
					block.push(format!("  zone {z}"));
				}
				block.extend(a.work.iter().map(|w| w.line.clone()));
				// The step after it reads its own zone again.
				if a.zone.is_some() {
					let lines_ = texts[gi].iter().map(String::as_str).collect::<Vec<_>>();
					let next = if a.after { (a.at + 1..lines_.len()).find(|&j| crate::jsre::is_step(lines_[j])) } else { Some(a.at) };
					if let (Some(n), Some(back)) = (next, zone_at(&texts[gi], if a.after { a.at } else { a.at.saturating_sub(1) })) {
						if !lines_[n + 1..step_last(&lines_, n) + 1].iter().any(|l| re!(r"^\s+zone\s").is_match(l)) {
							edits[gi].after.entry(n).or_default().push(format!("  zone {back}"));
						}
					}
				}
				if a.after {
					edits[gi].after.entry(a.at).or_default().extend(block);
				} else {
					let mut b = block[1..].to_vec();
					b.push(String::new());
					edits[gi].before.entry(a.at).or_default().extend(b);
				}
				rep.add("R1 along", a.work.len());
			}
		}
		// (A label made only for lists that are not along goes.)
		labels.new.retain(|&(gi, _), l| {
			let gone = unlisted.contains(&(gi, l.clone())) && !used.contains(&(gi, l.clone()));
			if gone {
				labels.taken[gi].remove(l.as_str());
			}
			!gone
		});
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
		// (One use per quest and item: the mechanics may list the same use more than once, A Matter of
		// Time's Temporal Displacer three times, #843.)
		let mut written: FxHashSet<(u32, u32)> = FxHashSet::default();
		for q in quests {
			let kinds = high_kinds(inp.mechanics, q);
			for kind in ["use-item-at-place", "use-item-on-mob", "summon-by-item"] {
				if !kinds.iter().any(|k| k == kind) {
					continue;
				}
				for p in params(inp.mechanics, q, kind) {
					let Some(item) = p.get("item").and_then(Value::as_u64).map(|x| x as u32) else { continue };
					if has_use.contains(&item) || written.contains(&(q, item)) {
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
					// (Before the quest's first use too: the bowl is filled at the moonwell before the filled
					// bowl is used at the bonfire, The Blackwood Corrupted.)
					let first_use = (first_accept[&q]..ti).find(|&i| seq[i].quest == Some(q) && seq[i].verb == "use");
					let before_at = match (work.first(), first_use) {
						(Some(&w), Some(u)) => Some(w.min(u)),
						(w, u) => w.copied().or(u),
					};
					// (An item the use makes, collected by a line of its own first: the use goes right before
					// that line, where it is made. The empty bowl at the Auberdine moonwell before v1's
					// "collect 12347", not at the furbolg camp after the filled bowl is in the bags, #302.)
					let produces: Vec<u32> = p.get("produces").and_then(Value::as_array).map(|a| a.iter().filter_map(|v| v.as_u64().map(|x| x as u32)).collect()).unwrap_or_default();
					let made_at = (first_accept[&q]..ti).find(|&i| seq[i].verb == "collect" && seq[i].item.is_some_and(|it| produces.contains(&it)));
					let before_at = made_at.filter(|&m| before_at.is_none_or(|b| m < b)).or(before_at);
					// The place nearest where the route works it (or hands it in): an object with spawns in
					// two zones (the Corrupt Jaedenar Moonwell's Darkshore twin) is used at the route's one.
					let positions: Vec<Value> = match p.get("place") {
						Some(pl) => match pl.get("positions").and_then(Value::as_array) {
							Some(a) => a.clone(),
							None if pl.get("x").is_some() => vec![pl.clone()],
							None => Vec::new(),
						},
						None => Vec::new(),
					};
					let near = seq.get(before_at.or(work.first().copied()).unwrap_or(ti));
					let geo = Geo::new(&data.map_frames);
					let yd = |v: &Value| -> f64 {
						let (Some(map), Some(x), Some(y)) = (v.get("map").and_then(Value::as_f64), v.get("x").and_then(Value::as_f64), v.get("y").and_then(Value::as_f64)) else {
							return f64::INFINITY;
						};
						match (near.and_then(|g| g.w), geo.to_world(map as i64, x, y, true)) {
							(Some(a), Some(b)) => dist(a, b),
							_ if near.is_some_and(|g| g.map == map) => 0.0,
							_ => f64::INFINITY,
						}
					};
					let pos0 = positions.iter().min_by(|a, b| yd(a).total_cmp(&yd(b))).filter(|v| yd(v).is_finite()).or(positions.first()).cloned();
					// (One spot read in two maps' frames, an object by a border: the frame of the map the route is
					// on there. The Jadefire moonwell's focus is Felwood 32.3,66.6 and Darkshore 48.2,85.9 too, and
					// the Darkshore reading, a yard nearer Winna, sent a Felwood step to Darkshore's map, c18.)
					let world_of = |v: &Value| -> Option<Wpt> { geo.to_world(v.get("map")?.as_f64()? as i64, v.get("x")?.as_f64()?, v.get("y")?.as_f64()?, true) };
					let pos0 = pos0.map(|p| {
						let on_map = |v: &Value| near.is_some_and(|g| v.get("map").and_then(Value::as_f64) == Some(g.map));
						if on_map(&p) {
							return p;
						}
						let same_spot = |v: &Value| matches!((world_of(&p), world_of(v)), (Some(a), Some(b)) if dist(a, b) <= 30.0);
						positions.iter().find(|&v| on_map(v) && same_spot(v)).cloned().unwrap_or(p)
					});
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
							written.insert((q, item));
						}
						_ if !work.is_empty() && !at.is_empty() => {
							// At the place, before the stand-in (kill/collect/interact), which stays: its kill or
							// loot is the objective's credit and the knowledge base's step. A use that gives no
							// credit itself (the bowl filled at the moonwell, PR542) is not the objective's line:
							// bound to it, it would hold its step until the objective is done. Unless the line it
							// goes before collects what it makes for the quest: that collect is the objective, and a
							// bare use would hold the step until ticked (the Crystal Phial at the moonwell, #875).
							let g = &seq[before_at.unwrap_or(work[0])];
							let credit = p.get("credit") != Some(&Value::Bool(false));
							let makes_for_q = made_at.is_some() && made_at == before_at && g.quest == Some(q);
							let r = if kind == "summon-by-item" || (!credit && !makes_for_q) { format!("  use {item}{at}") } else { format!("  use {item} quest {q}.{}{at}", g.oi.unwrap_or(1)) };
							edits[g.gi].before.entry(g.line as usize - 1).or_default().push(r);
							rep.add("R2 use", 1);
							written.insert((q, item));
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
							written.insert((q, item));
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
		let code = |g: &G| -> &str { split_comment(line_text(g)).0 };
		// Quests the player may not have picked up: an `optional` or item-started accept, one listed along
		// the way, and the quests that need one of them first.
		let mut maybe: FxHashSet<u32> = FxHashSet::default();
		for g in seq.iter().filter(|g| g.verb == "accept") {
			let Some(q) = g.quest else { continue };
			let start = quest_v(data, q).get("start");
			let from_item = re!(r"\bitem\s+\d").is_match(code(g)) || (!start.get("item").items().is_empty() && start.get("npc").items().is_empty() && start.get("object").items().is_empty());
			if from_item || re!(r"\boptional\b").is_match(code(g)) || ch.steps[g.gi][g.si].along {
				maybe.insert(q);
			}
		}
		loop {
			let before = maybe.len();
			for &q in first_accept.keys() {
				let qv = quest_v(data, q);
				let ids = |k: &str| qv.get(k).items().iter().filter_map(id).collect::<Vec<u32>>();
				let any = ids("preAny");
				if !maybe.contains(&q) && (if any.is_empty() { ids("pre").iter().any(|p| maybe.contains(p)) } else { any.iter().all(|p| maybe.contains(p)) }) {
					maybe.insert(q);
				}
			}
			if maybe.len() == before {
				break;
			}
		}
		// Travel steps for quests carried from an earlier guide (or ones the player may not have).
		let mut by_step: BTreeMap<(usize, usize), Vec<usize>> = BTreeMap::new();
		for (i, g) in seq.iter().enumerate() {
			by_step.entry((g.gi, g.si)).or_default().push(i);
		}
		for (&(gi, si), idx) in &by_step {
			let meta = &ch.steps[gi][si];
			if meta.when || meta.along || skip_blocks.contains(&(gi, si)) {
				continue;
			}
			// (Never a step that also trains, learns a flight path or binds, nor one with lines for some
			// races or classes only: the Ironforge training at 28 behind a 5% book's quest.)
			let service = idx.iter().any(|&i| matches!(seq[i].verb.as_str(), "train" | "getfp" | "sethome"));
			let some_only = idx.iter().any(|&i| re!(r"\sonly\s").is_match(split_comment(line_text(&seq[i])).0));
			let travel = idx.iter().any(|&i| matches!(seq[i].verb.as_str(), "goto" | "hearth" | "fly" | "vendor"));
			let qg: Vec<usize> = idx.iter().copied().filter(|&i| seq[i].quest.is_some() && seq[i].verb != "goto").collect();
			// (Nor one with a ride everyone takes: a travel line never lives only in a gated step.)
			let rides = idx.iter().any(|&i| seq[i].verb == "goto" && ride_goto(line_text(&seq[i])));
			if !travel || service || some_only || rides || qg.is_empty() {
				continue;
			}
			let carried = qg.iter().all(|&i| {
				let g = &seq[i];
				let q = g.quest.unwrap();
				g.verb != "accept" && first_accept.get(&q).is_some_and(|&a| a < i && (seq[a].gi < gi || maybe.contains(&q)))
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
		// Hand-ins of quests the player may not have, accepted in an earlier step: their step is `when
		// onquest`, or (beside other work) their lines become a step of their own `when onquest`, in place,
		// so a player who passed the quest by is never sent to hand it in. (A hand-in already `optional`
		// beside other work never holds the step.)
		for (&(gi, si), idx) in &by_step {
			let meta = &ch.steps[gi][si];
			if meta.when || meta.along || touched.contains(&(gi, si)) || skip_blocks.contains(&(gi, si)) {
				continue;
			}
			let hand: Vec<usize> = idx
				.iter()
				.copied()
				.filter(|&i| {
					let g = &seq[i];
					g.verb == "turnin"
						&& !re!(r"\bdirect\b").is_match(code(g))
						&& g.quest.is_some_and(|q| maybe.contains(&q) && first_accept.get(&q).is_some_and(|&a| a < i && (seq[a].gi, seq[a].si) != (gi, si)))
				})
				.collect();
			if hand.is_empty() {
				continue;
			}
			let quests = |list: &[usize]| -> String {
				let mut qs: Vec<u32> = Vec::new();
				for &i in list {
					let q = seq[i].quest.unwrap();
					if !qs.contains(&q) {
						qs.push(q);
					}
				}
				qs.iter().map(u32::to_string).collect::<Vec<_>>().join(",")
			};
			let s = meta.line as usize - 1;
			let hand_lines: FxHashSet<usize> = hand.iter().map(|&i| seq[i].line as usize - 1).collect();
			// (A step whose other goals are only waypoints is the hand-ins' alone; not one with a ride for
			// everyone, the Deeprun Tram after an optional errand's hand-in, Gnome c14.)
			let goals = step_goal_lines(&texts[gi], s);
			if !goals.iter().any(|&l| ride_goto(&texts[gi][l])) && goals.into_iter().all(|l| hand_lines.contains(&l) || matches!(crate::jsre::head(&texts[gi][l]), Some("goto" | "note"))) {
				edits[gi].after.entry(s).or_default().push(format!("  when onquest {}", quests(&hand)));
				touched.insert((gi, si));
				rep.add("R3 when onquest", 1);
				continue;
			}
			let hand: Vec<usize> = hand.into_iter().filter(|&i| !re!(r"\boptional\b").is_match(code(&seq[i]))).collect();
			// (A hand-in at the NPC another of the step's goals is at stays in the step, optional: the
			// player stands there anyway, Tarshaw's step not split in two at Tarshaw, T7.)
			// (All of them or none: a step split for one is split for all.)
			let at_npc = |i: usize| {
				seq[i]
					.npc
					.is_some_and(|n| idx.iter().any(|&j| j != i && matches!(seq[j].verb.as_str(), "accept" | "turnin") && !hand_lines.contains(&(seq[j].line as usize - 1)) && seq[j].npc == Some(n)))
			};
			if !hand.is_empty() && hand.iter().all(|&i| at_npc(i)) {
				// (Not one the guide takes only `optional` before it: the addon holds that hand-in only for a
				// player who took the quest, and `optional` let one who did walk past its NPC, Harvesting the
				// Harvesters at Ozwin, #298.)
				let opt_taken = |i: usize| {
					let mut acc = seq[..i].iter().filter(|a| a.gi == gi && a.verb == "accept" && a.quest == seq[i].quest).peekable();
					acc.peek().is_some() && acc.all(|a| re!(r"\boptional\b").is_match(code(a)))
				};
				for &i in &hand {
					let l = seq[i].line as usize - 1;
					if edits[gi].replaced.contains_key(&l) || edits[gi].removed.contains(&l) || opt_taken(i) {
						continue;
					}
					let (c, rest) = crate::jsre::split_comment(&texts[gi][l]);
					edits[gi].replaced.insert(l, format!("{} optional{rest}", c.trim_end()));
					touched.insert((gi, si));
					rep.add("R3 optional at its NPC", 1);
				}
				continue;
			}
			let pre_of = |q: u32| -> Vec<u32> {
				let v = quest_v(data, q);
				v.get("pre").items().into_iter().chain(v.get("preAny").items()).map(|x| x.num()).filter(|x| x.is_finite()).map(|x| x as u32).collect()
			};
			if hand.is_empty() || split_guarded(&texts[gi], s, &hand.iter().map(|&i| (seq[i].line as usize - 1, seq[i].quest.unwrap())).collect::<Vec<_>>(), &pre_of, &mut edits[gi]) == 0 {
				continue;
			}
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

	// Steps by their goals (the group rules below).
	let mut by_step: BTreeMap<(usize, usize), Vec<usize>> = BTreeMap::new();
	if opts.groups || opts.format_0_3 {
		for (i, g) in seq.iter().enumerate() {
			by_step.entry((g.gi, g.si)).or_default().push(i);
		}
	}

	// ---- the route's group families: asked, how hard, the group size ----
	if opts.groups && !inp.group_of.is_empty() {
		let fam = |q: u32| inp.group_of.get(&q).copied();
		let mut roots: Vec<u32> = inp.group_of.values().copied().collect();
		roots.sort();
		roots.dedup();
		let mut tips: FxHashMap<(usize, usize), Vec<(u32, String)>> = FxHashMap::default();
		for &root in &roots {
			let info = inp.groups.iter().find(|g| g.q == Some(root));
			// The tip: on the family's first step that does the root's work, else its accept's.
			let first = |verbs: &[&str]| seq.iter().find(|g| g.quest == Some(root) && verbs.contains(&g.verb.as_str()) && !ch.steps[g.gi][g.si].along).map(|g| (g.gi, g.si));
			if let Some(at) = first(&["kill", "collect", "interact", "use", "complete"]).or_else(|| first(&["accept"])) {
				tips.entry(at).or_default().push((root, format!("  tip {}", group_tip(info))));
				rep.add("groups tip", 1);
			}
			// The group size on its kills and collections.
			let Some(n) = info.and_then(|g| g.size).filter(|&n| n >= 2) else { continue };
			for g in seq.iter().filter(|g| g.quest.and_then(fam) == Some(root) && matches!(g.verb.as_str(), "kill" | "collect")) {
				let l = g.line as usize - 1;
				if !re!(r"\sgroup\b").is_match(split_comment(&texts[g.gi][l]).0) && edits[g.gi].suffix.insert(l, format!("group {n}")).is_none() {
					rep.add("groups size", 1);
				}
			}
		}
		// (A bag collect of the item that starts a family quest is that quest's work: Croaky's Head, the
		// level 11 elite's drop, written in Elwynn's solo step for everyone, 12 recorded deaths, #977.)
		let started: FxHashMap<u32, u32> =
			inp.group_of.keys().flat_map(|&q| quest_v(inp.data, q).get("start").get("item").items().iter().filter_map(id).map(move |it| (it, q)).collect::<Vec<_>>()).collect();
		let gq = |g: &G| g.quest.or_else(|| if g.verb == "collect" { g.item.and_then(|it| started.get(&it).copied()) } else { None });
		ask_group(&ch, &texts, &by_step, &fam, &gq, &tips, &step_only, &mut edits, &mut touched, &mut rep, "groups when group");
	}

	// ---- pack format 5 (Polestar 0.3.0) ----
	if opts.format_0_3 {
		// R5: group and dungeon quests' work, asked once. Every goal of a group quest the route takes is
		// asked for: the accept, the work and the turn-in (the player who skips it skips all of it). (A
		// quest of the route's group families is theirs.)
		let groups: FxHashSet<u32> = first_accept.keys().copied().filter(|q| first_turnin.contains_key(q) && group(*q) && !(opts.groups && inp.group_of.contains_key(q))).collect();
		ask_group(&ch, &texts, &by_step, &|q| groups.contains(&q).then_some(q), &|g: &G| g.quest, &FxHashMap::default(), &step_only, &mut edits, &mut touched, &mut rep, "R5 when group");
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

	// ---- R9: where; R10: warnings ----
	if opts.tips {
		crate::tips::place_notes(&ch, &texts, &mut edits, inp, &mut rep);
	}
	// ---- R11: a v1 goto that leads nowhere near the work after it ----
	crate::tips::stray_gotos(&ch, &texts, &mut edits, &mut rep);
	if opts.warnings {
		crate::tips::warnings(&ch, &texts, &mut edits, inp, &mut rep);
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

/// A goto to a boat, zeppelin, ship or tram (`goto 78.0,51.4 "Deeprun Tram"`, `"Boat to Auberdine"`).
pub(crate) fn ride_goto(text: &str) -> bool {
	re!(r#"(?i)^\s+goto\s.*"(?:[^"]*\b(?:Boat|Zeppelin|Ship|Tram)\b[^"]*)""#).is_match(split_comment(text).0)
}

#[cfg(test)]
mod tests {
	use super::group_tip;

	#[test]
	fn a_family_whose_work_places_no_mob_names_its_quest() {
		let g: crate::input::Group = serde_json::from_value(serde_json::json!({ "q": 1173, "title": "Challenge Overlord Mok'Morokk", "size": 3, "level": 43, "mobs": [], "quests": [1173] })).unwrap();
		assert_eq!(
			group_tip(Some(&g)),
			"These are elite mobs: grouping up is encouraged, look for people to do it with. Challenge Overlord Mok'Morokk needs a group of 3. Skip it if you are alone: the route has you grind the XP back."
		);
	}
}
