//! Port of tools/lib/dsl/validate.js.
//! Cross-guide validation (docs/GUIDE_FORMAT.md, "Validation"): duplicate ids, `next` targets (known, and
//! followable by the guide's faction, races and classes), quests turned in / worked on without an earlier
//! accept in the guide or any guide chaining into it, accepts the guide's characters can never take, missing
//! prerequisites, accepts above the plausible level, accepts closed by an exclusive quest taken earlier,
//! accepts never turned in on a route, `complete` on quests without objectives, required elite work in
//! Leveling guides, `|` in player-facing text, a `goto` placed right before a goal that already leads to the
//! same place, timed quest items carried longer than they last (timed.rs), turn-ins needing an item no
//! earlier goal gets, and a `complete` without a place on a quest whose objectives have one.
//!
//! Our house rules (required elite work, the solo filter) are errors in our pack (`guides`) and warnings in
//! every other.
//!
//! validate_guides(guides, data, diag) — guides are resolver output (resolve.rs).
//! validate_solo_policy(guides, excluded, diag) — lint only: leveling goals on quests the simulator's solo
//! filter excludes (solo.rs). `excluded`: V object keyed by faction, each a V object keyed by quest id.
//! validate_pack_frames(guides, data, ours, our_data, diag) — another pack's map frames that differ from
//! the ones our guides register.

use std::cell::RefCell;
use std::collections::HashMap;
use std::rc::{Rc, Weak};

use rustc_hash::{FxHashMap, FxHashSet};

use crate::conditions::{applicable, character_keys, mask_excludes, race_sides, who_label};
use crate::data::{objective_label, Data};
use crate::diag::Diagnostics;
use crate::js::{hypot, math_round, str_to_num, stringify, ObjData, Str, V};
use crate::races::{class_label, race_by_file, race_label};
use crate::timed::check_timed_items;
use crate::xp::{CUM_XP, LEVEL_XP, MAX_LEVEL};

/// A JS Map/Set key with SameValueZero semantics (objects and arrays by identity).
#[derive(Clone, PartialEq, Eq, Hash, Debug)]
pub enum Key {
	Undef,
	Null,
	Bool(bool),
	Num(u64),
	Str(Str),
	Ptr(usize),
}

pub fn key(v: &V) -> Key {
	match v {
		V::Undef => Key::Undef,
		V::Null => Key::Null,
		V::Bool(b) => Key::Bool(*b),
		V::Num(n) => Key::Num(if *n == 0.0 {
			0
		} else if n.is_nan() {
			f64::NAN.to_bits()
		} else {
			n.to_bits()
		}),
		V::Str(s) => Key::Str(s.clone()),
		V::Arr(a) => Key::Ptr(Rc::as_ptr(&a.0) as *const u8 as usize),
		V::Obj(o) => Key::Ptr(Rc::as_ptr(&o.0) as *const u8 as usize),
	}
}

/// A goal's character keys ("side|race|class").
pub type CharSet = FxHashSet<String>;

/// `Math.min(a, b)` (NaN propagates).
pub fn jmin(a: f64, b: f64) -> f64 {
	if a.is_nan() || b.is_nan() {
		f64::NAN
	} else {
		a.min(b)
	}
}

/// `Math.max(a, b)` (NaN propagates).
pub fn jmax(a: f64, b: f64) -> f64 {
	if a.is_nan() || b.is_nan() {
		f64::NAN
	} else {
		a.max(b)
	}
}

/// JS `a || b`.
fn or(a: V, b: V) -> V {
	if a.truthy() {
		a
	} else {
		b
	}
}

fn ts(v: &V) -> String {
	v.to_js_string()
}

fn t_of(goal: &V) -> String {
	goal.get("t").as_str().unwrap_or("").to_string()
}

fn line(v: &V) -> f64 {
	v.hidden("_line").num()
}

fn ast_file(g: &V) -> String {
	g.hidden("_ast").get("file").to_js_string()
}

// Quest XP is only part of what a questing route earns; mob kills on the way add roughly as much again.
// Generous on purpose: this only drives a warning.
const ROUTE_XP_FACTOR: f64 = 2.0;

fn cum_xp(i: f64) -> f64 {
	if crate::js::is_integer(i) && i >= 0.0 && (i as usize) < CUM_XP.len() {
		CUM_XP[i as usize]
	} else {
		f64::NAN
	}
}

fn level_xp(i: f64) -> f64 {
	if crate::js::is_integer(i) && i >= 0.0 && (i as usize) < LEVEL_XP.len() {
		LEVEL_XP[i as usize]
	} else {
		f64::NAN
	}
}

pub fn xp_at(level: f64) -> f64 {
	cum_xp(jmax(1.0, jmin(MAX_LEVEL as f64, level)))
}

pub fn level_at(xp: f64) -> f64 {
	let mut l = 1usize;
	while l < MAX_LEVEL && CUM_XP[l + 1] <= xp {
		l += 1;
	}
	l as f64
}

const OBJECTIVE_VERBS: &[&str] = &["kill", "collect", "interact", "use"];

fn guide_layer(g: &V) -> V {
	let l = V::obj();
	let f = g.get("faction");
	l.set("factions", if f.truthy() { V::from(vec![f]) } else { V::Null });
	l.set("races", or(g.get("races"), V::Null));
	l.set("classes", or(g.get("classes"), V::Null));
	l
}

/// A `next` option no character of guide g can follow. -> (message, hint) | None.
fn follow_problem(g: &V, other: &V, data: &Data) -> Option<(String, String)> {
	if [g, other].iter().any(|x| x.get("races").items().iter().any(|r| !race_by_file(&ts(r)).truthy())) {
		return None;
	}
	let classes_of = |r: &str, s: &str| data.race_classes(r, s);
	if character_keys(&[guide_layer(g)], Some(&classes_of)).is_empty() {
		return None;
	}
	if !character_keys(&[guide_layer(g), guide_layer(other)], Some(&classes_of)).is_empty() {
		return None;
	}
	let races = g.get("races");
	let classes = g.get("classes");
	let flags = format!(
		"{}{}",
		if races.truthy() { format!(" --race {}", race_label(&ts(&races.at(0)))) } else { String::new() },
		if classes.truthy() { format!(" --class {}", class_label(&ts(&classes.at(0)))) } else { String::new() }
	);
	let same = if classes.truthy() {
		if races.truthy() {
			"races and classes"
		} else {
			"classes"
		}
	} else {
		"races"
	};
	Some((
		format!("no {} character can follow {} (it is for {} only)", who_label(g), ts(&other.get("id")), who_label(other)),
		format!("pick a guide for the same {same}: `polestar find --kind guide <zone>{flags}`"),
	))
}

// Goals already reported as elite errors, so the lint solo policy skips them (a JS WeakSet).
thread_local! {
	static ELITE_REPORTED: RefCell<HashMap<usize, Weak<RefCell<ObjData>>>> = RefCell::new(HashMap::new());
}

fn elite_mark(goal: &V) {
	if let V::Obj(o) = goal {
		ELITE_REPORTED.with(|s| {
			let mut s = s.borrow_mut();
			s.retain(|_, w| w.strong_count() > 0);
			s.insert(Rc::as_ptr(&o.0) as usize, Rc::downgrade(&o.0));
		});
	}
}

fn elite_reported(goal: &V) -> bool {
	let V::Obj(o) = goal else { return false };
	ELITE_REPORTED.with(|s| s.borrow().get(&(Rc::as_ptr(&o.0) as usize)).and_then(|w| w.upgrade()).is_some_and(|r| Rc::ptr_eq(&r, &o.0)))
}

fn elite_tip(target: &str) -> String {
	format!("in a Leveling guide put the goal in a step with `when group <quest>` (the player chooses it) or make it `optional`, with the tip \"{target} is elite: grouping up is advised.\"")
}

/// A step the route takes only for a player who chose to do a group quest.
fn group_step(step: &V) -> bool {
	step.get("when").items().iter().any(|p| p.get("k").as_str() == Some("group") && !p.get("neg").truthy())
}

/// The quests of g the player takes only by choosing a group quest.
fn group_quests_of(g: &V) -> FxHashSet<Key> {
	let mut only: FxHashMap<Key, bool> = FxHashMap::default();
	for step in g.get("steps").items() {
		for goal in step.get("goals").items() {
			if goal.get("t").as_str() == Some("accept") && !goal.get("quest").is_undef() {
				let k = key(&goal.get("quest"));
				let prev = only.get(&k).copied();
				only.insert(k, prev != Some(false) && group_step(&step));
			}
		}
	}
	only.into_iter().filter(|(_, yes)| *yes).map(|(q, _)| q).collect()
}

/// A goal for a party, not solo leveling.
fn party_work(step: &V, goal: &V, chosen: &FxHashSet<Key>) -> bool {
	group_step(step) || (!goal.get("quest").is_undef() && chosen.contains(&key(&goal.get("quest"))))
}

/// Our house rules: errors in our pack, warnings in every other.
fn house_rule(diag: &mut Diagnostics, g: &V, file: &str, ln: f64, msg: String) {
	if g.get("pack").as_str() == Some("guides") {
		diag.error(file, ln, msg, None);
	} else {
		diag.warn(file, ln, msg, None);
	}
}

fn has_pipe(s: &V) -> bool {
	s.as_str().is_some_and(|s| s.contains('|'))
}

const PIPE_HEADER: &[(&str, &str)] = &[("title", "title"), ("folder", "folder"), ("pitch", "pitch"), ("pros", "pro"), ("cons", "con"), ("author", "author")];
const PIPE_NAMES: &[(&str, &str)] = &[
	("title", "the quest title"),
	("target", "the target name"),
	("npcName", "the NPC name"),
	("itemName", "the item name"),
	("objName", "the object name"),
	("spellName", "the spell name"),
	("factionName", "the faction name"),
	("achievementName", "the achievement name"),
];

/// Player-facing text exactly as the author wrote it: a `|` prints literally.
fn check_pipes(g: &V, diag: &mut Diagnostics) {
	let ast = g.hidden("_ast");
	let file = ts(&ast.get("file"));
	let mut warn = |ln: V, what: &str| diag.warn(&file, ln.num(), format!("{what} contains \"|\", which prints literally in game"), Some(crate::manifest::PIPE_HINT.to_string()));
	let h = or(ast.get("header"), V::obj());
	let lines = ast.get("lines");
	for (k, keyword) in PIPE_HEADER {
		let v = h.get(k);
		if v.is_arr() {
			// pro and con repeat: each entry at its own line.
			let at = or(lines.get(k), V::arr());
			for (i, x) in v.items().iter().enumerate() {
				if has_pipe(x) {
					warn(or(or(at.at(i), lines.get(keyword)), ast.get("line")), &format!("`{keyword}`"));
				}
			}
		} else if has_pipe(&v) {
			warn(or(lines.get(keyword), ast.get("line")), &format!("`{keyword}`"));
		}
	}
	for s in ast.get("steps").items() {
		if has_pipe(&s.get("title")) {
			warn(s.get("line"), "the step title");
		}
		if has_pipe(&s.get("tip")) {
			warn(s.get("line"), "the step tip");
		}
		for goal in s.get("goals").items() {
			if has_pipe(&goal.get("text")) {
				warn(goal.get("line"), "the goal text");
			}
			if has_pipe(&goal.get("note")) {
				warn(goal.get("line"), "the goal note");
			}
			for (k, what) in PIPE_NAMES {
				if has_pipe(&goal.get(k)) {
					warn(goal.get("line"), what);
				}
			}
			if goal.get("rewardChoices").items().iter().chain(goal.get("rewardItems").items().iter()).any(|r| has_pipe(&r.get("itemName"))) {
				warn(goal.get("line"), "the item name");
			}
		}
	}
}

/// f(map, guide, goal) for every map an emitted coordinate uses: the goal's own map/x/y and any coordinate
/// list on it (smart-target `candidates`).
pub fn for_each_goal_map(guides: &[V], mut f: impl FnMut(&V, &V, &V)) {
	for g in guides {
		for s in g.get("steps").items() {
			for goal in s.get("goals").items() {
				let map = goal.get("map");
				if !map.is_undef() {
					f(&map, g, &goal);
				}
				for v in goal.values() {
					if !v.is_arr() {
						continue;
					}
					for el in v.items() {
						// (A nested array's `el.map` is Array.prototype.map in JS: a key no frame has; skipped.)
						if el.is_obj() && !el.get("map").is_undef() {
							f(&el.get("map"), g, &goal);
						}
					}
				}
			}
		}
	}
}

const FRAME_KEYS: &[&str] = &["c", "left", "right", "top", "bottom"];

/// Another pack's Era frame for a map our guides also use, with other bounds. Once per map, at its first use.
pub fn validate_pack_frames(guides: &[V], data: &Data, ours: &[V], our_data: &Data, diag: &mut Diagnostics) {
	let mut our_frames: FxHashMap<Key, V> = FxHashMap::default();
	for_each_goal_map(ours, |map, _, _| {
		our_frames.entry(key(map)).or_insert_with(|| our_data.era_frame(map));
	});
	let mut seen: FxHashSet<Key> = FxHashSet::default();
	for_each_goal_map(guides, |map, g, goal| {
		if !seen.insert(key(map)) {
			return;
		}
		let mine = data.era_frame(map);
		let theirs = our_frames.get(&key(map)).cloned().unwrap_or(V::Undef);
		if !mine.truthy() || !theirs.truthy() || FRAME_KEYS.iter().all(|k| mine.get(k).strict_eq(&theirs.get(k))) {
			return;
		}
		diag.warn(
			&ast_file(g),
			line(goal),
			format!("map {}: this pack's Era frame differs from the one Polestar's guides register; in game Polestar's wins, so coordinates on this map may be off", ts(map)),
			None,
		);
	});
}

/// The message for elite work: a `kill` of an elite, or a `collect` of an item only elites drop.
fn elite_goal(goal: &V, sides: &V, data: &Data) -> Option<String> {
	let elite = crate::group::elite_work(goal, sides, data);
	if !elite.truthy() {
		return None;
	}
	let names = elite.get("names").items();
	let first = ts(&names[0]);
	if goal.get("t").as_str() == Some("kill") {
		return Some(format!("`kill` npc {} ({first}) is elite; {}", ts(&goal.get("npc")), elite_tip(&first)));
	}
	let item_name = goal.get("itemName");
	let item = format!("`collect` item {}{}", ts(&goal.get("item")), if item_name.truthy() { format!(" ({})", ts(&item_name)) } else { String::new() });
	Some(format!("{item} drops only from elites ({}); {}", names.iter().map(ts).collect::<Vec<_>>().join(", "), elite_tip(&first)))
}

/// The characters a goal applies to, as "side|race|class" keys, narrowed by the quest's own masks.
fn characters(layers: &[V], quest: &V) -> CharSet {
	let set = applicable(layers);
	let mut out = CharSet::default();
	for side in set.get("factions").items() {
		let side = ts(&side);
		for race in set.get("races").items() {
			let race = ts(&race);
			if !race_sides(&race).contains(&side) {
				continue;
			}
			for cls in set.get("classes").items() {
				let cls = ts(&cls);
				let one = V::obj();
				one.set("races", V::from(vec![V::str(&race)]));
				one.set("classes", V::from(vec![V::str(&cls)]));
				one.set("factions", V::from(vec![V::str(&side)]));
				one.set("unknownRace", !race_by_file(&race).truthy());
				if !quest.truthy() || mask_excludes(&one, quest).is_none() {
					out.insert(format!("{side}|{race}|{cls}"));
				}
			}
		}
	}
	out
}

pub fn meets(a: &CharSet, b: &CharSet) -> bool {
	a.iter().any(|k| b.contains(k))
}

fn minus(a: &CharSet, b: &CharSet) -> CharSet {
	a.iter().filter(|k| !b.contains(*k)).cloned().collect()
}

fn quest_name(data: &Data, id: &V, title: &V) -> String {
	let q = data.quest(id);
	let t = or(if q.truthy() { q.get("title") } else { q }, title.clone());
	if t.truthy() {
		format!("{} ({})", ts(id), ts(&t))
	} else {
		ts(id)
	}
}

/// Whether the world gives an item: a drop from an npc or object, a vendor, or a container.
fn world_source(it: &V) -> bool {
	if !it.truthy() {
		return false;
	}
	let d = it.get("drops");
	let some = |o: &V| o.truthy() && !o.keys().is_empty();
	some(&d.get("npc")) || some(&d.get("object")) || (it.get("vendors").is_arr() && !it.get("vendors").is_empty()) || (it.get("containers").is_arr() && !it.get("containers").is_empty())
}

/// Items quest q's objectives ask for that the world gives, skipping what the quest hands over itself.
/// -> [(id, name, oi)]
fn needed_items(data: &Data, q: &V) -> Vec<(V, String, V)> {
	let start = q.get("start");
	let start_items = if start.truthy() { or(start.get("item"), V::arr()) } else { V::arr() };
	let own: FxHashSet<Key> = std::iter::once(q.get("sourceItem")).chain(start_items.items()).filter(|x| !x.is_nullish()).map(|x| key(&x)).collect();
	let mut out: Vec<(V, String, V)> = Vec::new();
	for o in data.quest_objectives(&q.get("id")) {
		let id = o.get("id");
		if o.get("kind").as_str() != Some("item") || id.is_nullish() || own.contains(&key(&id)) || out.iter().any(|x| x.0.strict_eq(&id)) {
			continue;
		}
		let it = data.item(&id);
		if world_source(&it) {
			let name = if it.get("name").truthy() { ts(&it.get("name")) } else { format!("item {}", ts(&id)) };
			out.push((id, name, o.get("index")));
		}
	}
	out
}

/// Whether an entity has a known place.
fn placed(data: &Data, kind: &str, id: &V) -> bool {
	if kind == "npc" || kind == "object" {
		return !data.spawns(kind, id).is_empty();
	}
	if kind != "item" {
		return false;
	}
	let it = data.item(id);
	if !it.truthy() {
		return false;
	}
	let d = it.get("drops");
	d.get("npc").keys().iter().any(|n| placed(data, "npc", &V::Num(str_to_num(n))))
		|| d.get("object").keys().iter().any(|o| placed(data, "object", &V::Num(str_to_num(o))))
		|| it.get("vendors").items().iter().any(|n| placed(data, "npc", &V::Num(n.num())))
}

/// The objectives of quest `id` that have a place to point at, as `7.1 = kill …` labels.
fn placed_objectives(data: &Data, id: &V) -> Vec<String> {
	let kind_of = |k: &V| match k.as_str() {
		Some("kill") => Some("npc"),
		Some("object") => Some("object"),
		Some("item") => Some("item"),
		_ => None,
	};
	data.quest_objectives(id).into_iter().filter(|o| kind_of(&o.get("kind")).is_some_and(|k| !o.get("id").is_nullish() && placed(data, k, &o.get("id")))).map(|o| objective_label(id, &o)).collect()
}

const GOTO_REDUNDANT_YARDS: f64 = 200.0;
const TRAVEL_VERBS: &[&str] = &["fly", "hearth"];

/// World position in yards of a compiled point on `map`, or None when the map has no bounds.
fn world_point(data: &Data, map: &V, x: &V, y: &V, f: &V) -> Option<(f64, f64)> {
	let era = data.map_frames.get("era");
	let live = data.map_frames.get("forever");
	let mk = ts(map);
	let b = if f.as_str() == Some("e") { era.get(&mk) } else { or(live.get(&mk), era.get(&mk)) };
	if !b.truthy() {
		return None;
	}
	let (left, right, top, bottom) = (b.get("left").num(), b.get("right").num(), b.get("top").num(), b.get("bottom").num());
	Some((left + ((right - left) * x.num()) / 100.0, top + ((bottom - top) * y.num()) / 100.0))
}

fn goal_label(goal: &V) -> String {
	let what = ["target", "itemName", "npcName", "objName", "title", "text"].iter().fold(V::Undef, |acc, k| or(acc, goal.get(k)));
	format!("`{}{}`", ts(&goal.get("t")), if what.truthy() { format!(" {}", ts(&what)) } else { String::new() })
}

/// A kill or collect whose target spawns nowhere in the data.
fn unspawned_target(data: &Data, goal: &V) -> bool {
	let t = t_of(goal);
	if t == "kill" {
		return goal.get("npc").is_undef() || data.spawns("npc", &goal.get("npc")).is_empty();
	}
	if t != "collect" {
		return false;
	}
	let it = if !goal.get("item").is_undef() { data.item(&goal.get("item")) } else { V::Null };
	let drops = if it.truthy() { it.get("drops") } else { V::Undef };
	!["npc", "object"].iter().any(|kind| drops.get(kind).keys().iter().any(|id| !data.spawns(kind, &V::Num(str_to_num(id))).is_empty()))
}

fn check_redundant_gotos(g: &V, data: &Data, diag: &mut Diagnostics) {
	for step in g.get("steps").items() {
		let goals = step.get("goals").items();
		if goals.iter().any(|goal| TRAVEL_VERBS.contains(&t_of(goal).as_str())) {
			continue;
		}
		for (i, goto) in goals.iter().enumerate() {
			if t_of(goto) != "goto" || goto.get("x").is_undef() {
				continue;
			}
			let Some(next) = goals[i + 1..].iter().find(|goal| t_of(goal) != "note") else { continue };
			if t_of(next) == "goto" || next.get("x").is_undef() || next.get("optional").truthy() || !next.get("map").strict_eq(&goto.get("map")) || unspawned_target(data, next) {
				continue;
			}
			if stringify(&or(next.get("only"), V::Null), None) != stringify(&or(goto.get("only"), V::Null), None) {
				continue;
			}
			let Some(at) = world_point(data, &goto.get("map"), &goto.get("x"), &goto.get("y"), &goto.get("f")) else { continue };
			let mut yards = f64::INFINITY;
			let first = V::obj();
			first.set("x", next.get("x"));
			first.set("y", next.get("y"));
			first.set("r", 0.0);
			for p in std::iter::once(first).chain(next.get("spots").items()) {
				if let Some(w) = world_point(data, &next.get("map"), &p.get("x"), &p.get("y"), &next.get("f")) {
					let r = or(p.get("r"), V::Num(0.0)).num();
					yards = jmin(yards, jmax(0.0, hypot(w.0 - at.0, w.1 - at.1) - r));
				}
			}
			if yards > GOTO_REDUNDANT_YARDS {
				continue;
			}
			let label = goal_label(next);
			let text = goto.get("text");
			diag.warn(
				&ast_file(g),
				line(goto),
				format!(
					"`goto {},{}`{} sends the player where {label} (line {}) already leads, {} yards away",
					ts(&goto.get("x")),
					ts(&goto.get("y")),
					if text.truthy() { format!(" \"{}\"", ts(&text)) } else { String::new() },
					ts(&next.hidden("_line")),
					crate::js::num_str(math_round(yards))
				),
				Some(format!("remove the goto: the arrow leads to {label} directly")),
			);
		}
	}
}

/// A `turnin` whose quest's objectives ask for an item the world gives that no earlier goal in this guide
/// or a guide chaining into it gets. A warning.
fn check_turnin_items(g: &V, before: &[V], data: &Data, diag: &mut Diagnostics) {
	let mut held: FxHashSet<Key> = FxHashSet::default();
	let mut objectives: FxHashSet<String> = FxHashSet::default();
	let mut completed: FxHashSet<Key> = FxHashSet::default();
	let note = |goal: &V, held: &mut FxHashSet<Key>, objectives: &mut FxHashSet<String>, completed: &mut FxHashSet<Key>| {
		if !goal.get("item").is_undef() && t_of(goal) != "use" {
			held.insert(key(&goal.get("item")));
		}
		if !goal.get("quest").is_undef() && !goal.get("oi").is_undef() {
			objectives.insert(format!("{}.{}", ts(&goal.get("quest")), ts(&goal.get("oi"))));
		}
		if t_of(goal) == "complete" {
			completed.insert(key(&goal.get("quest")));
		}
	};
	for a in before {
		for s in a.get("steps").items() {
			for goal in s.get("goals").items() {
				note(&goal, &mut held, &mut objectives, &mut completed);
			}
		}
	}
	let file = ast_file(g);
	for step in g.get("steps").items() {
		for goal in step.get("goals").items() {
			let quest = goal.get("quest");
			let q = if t_of(&goal) == "turnin" && !quest.is_undef() { data.quest(&quest) } else { V::Null };
			if q.truthy() {
				let qs = ts(&quest);
				let missing: Vec<_> =
					needed_items(data, &q).into_iter().filter(|it| !held.contains(&key(&it.0)) && !objectives.contains(&format!("{qs}.{}", ts(&it.2))) && !completed.contains(&key(&quest))).collect();
				if !missing.is_empty() {
					let list = missing.iter().map(|it| format!("{} ({}, objective {qs}.{})", it.1, ts(&it.0), ts(&it.2))).collect::<Vec<_>>().join(", ");
					diag.warn(
						&file,
						line(&goal),
						format!("quest {} is turned in, but no earlier goal in this guide or a guide chaining into it gets {list}", quest_name(data, &quest, &goal.get("title"))),
						Some("add the goal that gets it before the turn-in (`collect <item> quest <Q.O>`, or the `kill`/`interact` that drops it, linked to its objective)".into()),
					);
				}
			}
			note(&goal, &mut held, &mut objectives, &mut completed);
		}
	}
}

/// A `complete` with no place of its own on a quest whose objectives have places. A warning.
fn check_bare_completes(g: &V, data: &Data, diag: &mut Diagnostics) {
	for step in g.get("steps").items() {
		let goals = step.get("goals").items();
		for (i, goal) in goals.iter().enumerate() {
			if t_of(goal) != "complete" || !goal.get("x").is_undef() || goal.get("quest").is_undef() {
				continue;
			}
			if goals[..i].iter().any(|x| t_of(x) == "goto" && !x.get("x").is_undef()) {
				continue;
			}
			let quest = goal.get("quest");
			let places = placed_objectives(data, &quest);
			if places.is_empty() {
				continue;
			}
			let qs = ts(&quest);
			diag.warn(
				&ast_file(g),
				line(goal),
				format!("`complete` for quest {} has no place, but its objectives do ({}): the arrow has nowhere to point", quest_name(data, &quest, &goal.get("title")), places.join(", ")),
				Some(format!("write a goal per objective (`kill <npc> quest {qs}.<n>`, `collect <item> quest {qs}.<n>`), or give the `complete` a `goto` or coordinates")),
			);
		}
	}
}

fn next_ids(g: &V) -> Vec<V> {
	let nc = g.get("nextChoices");
	if nc.truthy() {
		nc.items()
	} else if g.get("next").truthy() {
		vec![g.get("next")]
	} else {
		Vec::new()
	}
}

fn goals_of(g: &V) -> Vec<(V, V)> {
	g.get("steps").items().into_iter().flat_map(|s| s.get("goals").items().into_iter().map(move |goal| (s.clone(), goal))).collect()
}

fn closes(goal: &V) -> bool {
	matches!(t_of(goal).as_str(), "turnin" | "abandon")
}

struct QuestGoal {
	goal: V,
	chars: Rc<CharSet>,
}

struct Ctx<'a> {
	data: &'a Data,
	by_id: FxHashMap<Key, V>,
	preds: FxHashMap<Key, Vec<V>>,
	exit_memo: RefCell<FxHashMap<Key, f64>>,
	quest_goal_memo: RefCell<FxHashMap<Key, Rc<Vec<QuestGoal>>>>,
	covered_memo: RefCell<FxHashMap<String, Option<Rc<CharSet>>>>,
}

impl Ctx<'_> {
	fn preds_of(&self, g: &V) -> Vec<V> {
		self.preds.get(&key(&g.get("id"))).cloned().unwrap_or_default()
	}

	fn ancestors(&self, g: &V) -> Vec<V> {
		let mut out: Vec<V> = Vec::new();
		let mut seen: FxHashSet<Key> = FxHashSet::default();
		seen.insert(key(&g.get("id")));
		let mut stack = self.preds_of(g);
		while let Some(p) = stack.pop() {
			let pid = key(&p.get("id"));
			if seen.contains(&pid) {
				if p.get("id").strict_eq(&g.get("id")) && !out.iter().any(|x| x.strict_eq(&p)) {
					out.push(p);
				}
				continue;
			}
			seen.insert(pid);
			out.push(p.clone());
			stack.extend(self.preds_of(&p));
		}
		out
	}

	// Route XP: entry = max(guide minLevel, best exit of any predecessor).
	fn entry_xp(&self, g: &V, visiting: &mut FxHashSet<Key>) -> f64 {
		let mut xp = xp_at(or(g.get("minLevel"), V::Num(1.0)).num());
		for p in self.preds_of(g) {
			if visiting.contains(&key(&p.get("id"))) {
				continue;
			}
			xp = jmax(xp, self.exit_xp(&p, visiting));
		}
		xp
	}

	fn walk_xp(&self, g: &V, start: f64, mut on_goal: Option<&mut dyn FnMut(&V, &V, f64)>) -> f64 {
		let mut xp = start;
		for (step, goal) in goals_of(g) {
			if let Some(f) = on_goal.as_mut() {
				f(&step, &goal, xp);
			}
			let t = t_of(&goal);
			if t == "turnin" {
				let q = self.data.quest(&goal.get("quest"));
				// Data XP, else the XP the turn-in line states (`xp <N>`).
				let rewards = goal.get("rewards");
				let qxp = if q.truthy() && q.get("xp").num() > 0.0 {
					q.get("xp").num()
				} else if rewards.truthy() && rewards.get("xp").num() > 0.0 {
					rewards.get("xp").num()
				} else {
					0.0
				};
				if qxp > 0.0 {
					xp += qxp * ROUTE_XP_FACTOR;
				}
			} else if t == "level" {
				let level = goal.get("level").num();
				let frac = goal.get("frac");
				xp = jmax(xp, xp_at(level) + if frac.truthy() { frac.num() * level_xp(level) } else { 0.0 });
			}
		}
		xp
	}

	fn exit_xp(&self, g: &V, visiting: &mut FxHashSet<Key>) -> f64 {
		let id = key(&g.get("id"));
		if let Some(x) = self.exit_memo.borrow().get(&id) {
			return *x;
		}
		visiting.insert(id.clone());
		let entry = self.entry_xp(g, visiting);
		let out = self.walk_xp(g, entry, None);
		visiting.remove(&id);
		self.exit_memo.borrow_mut().insert(id, out);
		out
	}

	// Accept, turn-in and abandon goals with the characters they apply to, per guide.
	fn quest_goals(&self, g: &V) -> Rc<Vec<QuestGoal>> {
		let id = key(&g.get("id"));
		if let Some(l) = self.quest_goal_memo.borrow().get(&id) {
			return l.clone();
		}
		let gl = guide_layer(g);
		let mut list = Vec::new();
		for (step, goal) in goals_of(g) {
			if goal.get("quest").is_undef() || !matches!(t_of(&goal).as_str(), "accept" | "turnin" | "abandon") {
				continue;
			}
			let chars = characters(&[gl.clone(), step.hidden("_only"), goal.hidden("_only")], &self.data.quest(&goal.get("quest")));
			list.push(QuestGoal { goal, chars: Rc::new(chars) });
		}
		let list = Rc::new(list);
		self.quest_goal_memo.borrow_mut().insert(id, list.clone());
		list
	}

	fn successors(&self, g: &V) -> Vec<V> {
		next_ids(g).iter().filter_map(|id| self.by_id.get(&key(id)).cloned()).collect()
	}

	// Characters for whom every route from the start of guide h turns quest q in (None: every character,
	// for a loop back into a guide being walked).
	fn covered(&self, h: &V, q: &V, visiting: &mut FxHashSet<Key>) -> Option<Rc<CharSet>> {
		let k = format!("{}|{}", ts(&h.get("id")), ts(q));
		if let Some(c) = self.covered_memo.borrow().get(&k) {
			return c.clone();
		}
		let hid = key(&h.get("id"));
		if visiting.contains(&hid) {
			return None;
		}
		visiting.insert(hid.clone());
		let next = self.successors(h);
		let mut after: Option<Rc<CharSet>> = if next.is_empty() { Some(Rc::new(CharSet::default())) } else { None };
		for s in &next {
			if let Some(c) = self.covered(s, q, visiting) {
				after = Some(match after {
					Some(a) => Rc::new(a.iter().filter(|k| c.contains(*k)).cloned().collect()),
					None => c,
				});
			}
		}
		visiting.remove(&hid);
		let out = after.map(|after| {
			let mut out: CharSet = (*after).clone();
			for t in self.quest_goals(h).iter() {
				if closes(&t.goal) && t.goal.get("quest").strict_eq(q) {
					out.extend(t.chars.iter().cloned());
				}
			}
			Rc::new(out)
		});
		self.covered_memo.borrow_mut().insert(k, out.clone());
		out
	}
}

pub fn validate_guides(guides: &[V], data: &Data, diag: &mut Diagnostics) {
	let mut order: Vec<V> = Vec::new();
	let mut by_id: FxHashMap<Key, V> = FxHashMap::default();
	for g in guides {
		let ast = g.hidden("_ast");
		let id = key(&g.get("id"));
		if let Some(first) = by_id.get(&id) {
			let first = first.hidden("_ast");
			diag.error(&ts(&ast.get("file")), ast.get("line").num(), format!("duplicate guide id \"{}\" (also in {}:{})", ts(&g.get("id")), ts(&first.get("file")), ts(&first.get("line"))), None);
			continue;
		}
		by_id.insert(id, g.clone());
		order.push(g.clone());
	}
	// Predecessors through `next` and every route choice.
	let mut preds: FxHashMap<Key, Vec<V>> = FxHashMap::default();
	for g in &order {
		let ast = g.hidden("_ast");
		let file = ts(&ast.get("file"));
		let lines = ast.get("lines");
		let next_line = |to: &V| {
			let of = lines.get("nextOf");
			let l = if of.truthy() { of.get(&ts(to)) } else { of };
			or(l, lines.get("next")).num()
		};
		for to in next_ids(g) {
			let Some(other) = by_id.get(&key(&to)).cloned() else {
				diag.error(&file, next_line(&to), format!("`next` points to unknown guide \"{}\"", ts(&to)), Some("list guide ids with `polestar find --kind guide <text>`".into()));
				continue;
			};
			let (gf, of) = (g.get("faction"), other.get("faction"));
			if gf.truthy() && of.truthy() && !of.strict_eq(&gf) {
				diag.error(&file, next_line(&to), format!("`next` offers {} guide \"{}\" after a {} guide", ts(&of), ts(&to), ts(&gf)), None);
			} else if let Some((message, hint)) = follow_problem(g, &other, data) {
				diag.error(&file, next_line(&to), message, Some(hint));
			}
			preds.entry(key(&to)).or_default().push(g.clone());
		}
		// A route choice shows its options' pitches; one option is no choice.
		let nc = g.get("nextChoices");
		if nc.truthy() && nc.len() > 1 {
			for to in nc.items() {
				if let Some(other) = by_id.get(&key(&to)) {
					if !other.get("pitch").truthy() {
						let oast = other.hidden("_ast");
						diag.warn(
							&ts(&oast.get("file")),
							oast.get("line").num(),
							format!("\"{}\" is a route choice after \"{}\" but has no `pitch`; the choice window shows its pitch, pros and cons", ts(&to), ts(&g.get("id"))),
							None,
						);
					}
				}
			}
		}
	}

	let ctx = Ctx { data, by_id, preds, exit_memo: RefCell::new(FxHashMap::default()), quest_goal_memo: RefCell::new(FxHashMap::default()), covered_memo: RefCell::new(FxHashMap::default()) };

	for g in &order {
		let file = ast_file(g);
		check_pipes(g, diag);
		check_redundant_gotos(g, data, diag);
		check_turnin_items(g, &ctx.ancestors(g), data, diag);
		check_bare_completes(g, data, diag);
		let mut accepted: FxHashSet<Key> = FxHashSet::default();
		let mut turned_in: FxHashSet<Key> = FxHashSet::default();
		let mut when_only: FxHashSet<Key> = FxHashSet::default();
		let mut learned: FxHashSet<Key> = FxHashSet::default();
		// Quests accepted or turned in earlier on the path -> their character sets.
		let mut taken: FxHashMap<Key, Vec<Rc<CharSet>>> = FxHashMap::default();
		fn take(taken: &mut FxHashMap<Key, Vec<Rc<CharSet>>>, t: &QuestGoal) {
			taken.entry(key(&t.goal.get("quest"))).or_default().push(t.chars.clone());
		}
		for a in ctx.ancestors(g) {
			for (_, goal) in goals_of(&a) {
				match t_of(&goal).as_str() {
					"accept" => {
						accepted.insert(key(&goal.get("quest")));
					}
					"turnin" => {
						turned_in.insert(key(&goal.get("quest")));
					}
					"learn" => {
						learned.insert(key(&goal.get("spell")));
					}
					_ => {}
				}
			}
			for t in ctx.quest_goals(&a).iter() {
				if t_of(&t.goal) != "abandon" {
					take(&mut taken, t);
				}
			}
		}
		let qg = ctx.quest_goals(g);
		let own: FxHashMap<Key, usize> = qg.iter().enumerate().map(|(i, t)| (key(&t.goal), i)).collect();
		// Quests handed in straight from the NPC's window (`turnin <id> direct`), in this guide or the chain into it.
		let mut direct: FxHashSet<Key> = FxHashSet::default();
		for a in ctx.ancestors(g).into_iter().chain(std::iter::once(g.clone())) {
			for (_, goal) in goals_of(&a) {
				if t_of(&goal) == "turnin" && goal.get("direct").truthy() {
					direct.insert(key(&goal.get("quest")));
				}
			}
		}
		let gl = guide_layer(g);
		let leveling = g.get("category").as_str() == Some("Leveling");
		let chosen = group_quests_of(g);
		for (step, goal) in goals_of(g) {
			let ln = line(&goal);
			let quest = goal.get("quest");
			let qk = key(&quest);
			let t = t_of(&goal);
			let q = if !quest.is_undef() { data.quest(&quest) } else { V::Null };
			let layers = [gl.clone(), step.hidden("_only"), goal.hidden("_only")];
			if leveling && !goal.get("optional").truthy() && !party_work(&step, &goal, &chosen) {
				if let Some(elite) = elite_goal(&goal, &applicable(&layers).get("factions"), data) {
					house_rule(diag, g, &file, ln, elite);
					elite_mark(&goal);
				}
			}
			// A direct hand-in is offered like an accept.
			let direct_turnin = t == "turnin" && goal.get("direct").strict_eq(&V::Bool(true));
			if t == "accept" || direct_turnin {
				let set = applicable(&layers);
				if q.truthy() {
					if let Some(why) = mask_excludes(&set, &q) {
						diag.error(
							&file,
							ln,
							format!(
								"quest {} ({}) is not available to any {} this {} applies to",
								ts(&quest),
								ts(&goal.get("title")),
								if why == "race" { "race" } else { "class" },
								if goal.hidden("_only").truthy() { "goal" } else { "step" }
							),
							None,
						);
					}
					// Only blocking prerequisites count: every one of `all`, one of `any`.
					let bp = crate::prereqs::blocking_prereqs(&q, &|id: &V| data.quest(id));
					let (all, any) = (bp.get("all").items(), bp.get("any").items());
					let takeable = |p: &V| {
						let pq = data.quest(p);
						!(pq.truthy() && mask_excludes(&set, &pq).is_some())
					};
					let name = |p: &V| {
						let pq = data.quest(p);
						if pq.truthy() && pq.get("title").truthy() {
							format!("{} ({})", ts(p), ts(&pq.get("title")))
						} else {
							ts(p)
						}
					};
					for p in all.iter().filter(|p| !turned_in.contains(&key(p)) && takeable(p)) {
						diag.warn(&file, ln, format!("quest {} needs {} turned in first, but the chain never turns it in", ts(&quest), name(p)), None);
					}
					if !any.is_empty() && !any.iter().any(|p| turned_in.contains(&key(p))) {
						let open: Vec<String> = any.iter().filter(|p| takeable(p)).map(name).collect();
						if open.len() == 1 {
							diag.warn(&file, ln, format!("quest {} needs {} turned in first, but the chain never turns it in", ts(&quest), open[0]), None);
						} else if open.len() > 1 {
							diag.warn(&file, ln, format!("quest {} needs one of {} turned in first, but the chain turns in none of them", ts(&quest), open.join(", ")), None);
						}
					}
					// Exclusive quests: the game does not offer this one while one of them is in the log or done.
					let mine = &qg[own[&key(&goal)]];
					for e in q.get("excl").items() {
						if taken.get(&key(&e)).is_some_and(|l| l.iter().any(|chars| meets(chars, &mine.chars))) {
							diag.warn(
								&file,
								ln,
								format!(
									"quest {} is not offered once {} is in the log or done, and the chain takes that quest earlier",
									quest_name(data, &quest, &goal.get("title")),
									quest_name(data, &e, &V::Undef)
								),
								None,
							);
						}
					}
				}
				if direct_turnin {
					if accepted.contains(&qk) {
						diag.error(&file, ln, format!("`turnin` for quest {} is marked `direct`, but the chain accepts that quest earlier: drop `direct`", ts(&quest)), None);
					}
					turned_in.insert(qk.clone());
				} else {
					// An accept only in steps with `when` may never happen: noted for the hand-ins after it.
					if step.get("when").truthy() {
						if !accepted.contains(&qk) {
							when_only.insert(qk.clone());
						}
					} else {
						when_only.remove(&qk);
					}
					accepted.insert(qk.clone());
				}
				if let Some(&i) = own.get(&key(&goal)) {
					take(&mut taken, &qg[i]);
				}
			} else if t == "turnin" || t == "complete" || (OBJECTIVE_VERBS.contains(&t.as_str()) && !quest.is_undef()) {
				// `when onquest Q` / `when complete Q`: the step applies only with Q in the log.
				let on_quest = step.get("when").items().iter().any(|p| {
					!p.get("neg").truthy() && {
						let (k, pq) = (p.get("k"), p.get("q"));
						(k.as_str() == Some("onquest") && if pq.is_arr() { pq.items().iter().any(|x| key(x) == qk) } else { key(&pq) == qk })
							|| (k.as_str() == Some("complete") && pq.strict_eq(&quest))
					}
				});
				if !accepted.contains(&qk) && !on_quest {
					if direct.contains(&qk) {
						diag.error(
							&file,
							ln,
							format!(
								"`{t}` for quest {}, which is handed in directly (`turnin {} direct`): it is never in the quest log, so nothing tracks its objectives. Get what it asks for with a plain `buy` or `collect`, without `quest`",
								quest_name(data, &quest, &goal.get("title")),
								ts(&quest)
							),
							None,
						);
					} else {
						// A repeatable its giver takes back: likely handed in from the window.
						let rq = if t == "turnin" { q.clone() } else { V::Null };
						let self_handin = rq.truthy() && rq.get("repeatable").truthy() && rq.get("start").truthy() && rq.get("end").truthy() && {
							let ends = rq.get("end").get("npc").items();
							rq.get("start").get("npc").items().iter().any(|n| ends.iter().any(|e| key(e) == key(n)))
						};
						diag.error(
							&file,
							ln,
							format!("`{t}` for quest {} that is never accepted earlier in this guide or a guide chaining into it", ts(&quest)),
							if self_handin { Some("a repeatable quest its giver takes back straight from the quest window: write `turnin <id> direct`".into()) } else { None },
						);
					}
				}
				if t == "turnin" {
					turned_in.insert(qk.clone());
					if let Some(&i) = own.get(&key(&goal)) {
						take(&mut taken, &qg[i]);
					}
				}
				if t == "turnin" && when_only.contains(&qk) && !on_quest && !step.get("when").truthy() {
					diag.warn(
						&file,
						ln,
						format!(
							"`turnin` for quest {}, which is accepted earlier only in steps with `when`: characters who pass those steps never see this turn-in. Give it the same `when` or a `when onquest {}`",
							quest_name(data, &quest, &goal.get("title")),
							ts(&quest)
						),
						None,
					);
				}
				if t == "complete" && q.truthy() && q.get("objectives").is_arr() && q.get("objectives").is_empty() {
					diag.warn(&file, ln, format!("`complete` for quest {}, which has no objectives: the action is the turn-in; use `turnin`", quest_name(data, &quest, &goal.get("title"))), None);
				}
			} else if t == "learn" {
				learned.insert(key(&goal.get("spell")));
			} else if t == "craft" && !learned.contains(&key(&goal.get("spell"))) {
				let found = data.recipe(&goal.get("spell"));
				let r = if found.truthy() { found.get("recipe") } else { found };
				// Recipes a trainer hands out free with the profession are known without a `learn`.
				let starter = r.truthy() && r.get("source").as_str() == Some("trainer") && r.get("learnedAt").num() <= 1.0 && !r.get("cost").is_undef() && r.get("cost").num() == 0.0;
				if !starter {
					let spell = ts(&goal.get("spell"));
					diag.warn(
						&file,
						ln,
						format!("`craft` {spell} ({}) before any `learn {spell}` earlier in this guide or a guide chaining into it", ts(&or(goal.get("spellName"), V::str("unknown recipe")))),
						None,
					);
				}
			}
		}

		// Accepts (not `optional`) the route never turns in: later in this guide, else on every route after it.
		for (i, a) in qg.iter().enumerate() {
			if t_of(&a.goal) != "accept" || a.goal.get("optional").truthy() || a.chars.is_empty() {
				continue;
			}
			let aq = a.goal.get("quest");
			let mut open: CharSet = (*a.chars).clone();
			for t in &qg[i + 1..] {
				if closes(&t.goal) && t.goal.get("quest").strict_eq(&aq) {
					open = minus(&open, &t.chars);
				}
			}
			if open.is_empty() {
				continue;
			}
			let name = quest_name(data, &aq, &a.goal.get("title"));
			let some = |left: usize| if left < a.chars.len() { " for some of the characters it applies to" } else { "" };
			struct Route {
				s: V,
				left: CharSet,
			}
			let routes: Vec<Route> = ctx
				.successors(g)
				.into_iter()
				.map(|s| {
					let c = ctx.covered(&s, &aq, &mut FxHashSet::default());
					let left = match c {
						Some(c) => minus(&open, &c),
						None => CharSet::default(),
					};
					Route { s, left }
				})
				.collect();
			// A next guide whose race, class or faction leaves out every character still holding the quest.
			let outside = |r: &Route| !meets(&r.left, &characters(&[guide_layer(&r.s)], &V::Undef));
			let why = |r: &Route, it: &str| if outside(r) { format!(" ({it} is for {} only, so its turn-ins do not count)", who_label(&r.s)) } else { String::new() };
			let hint = |excluded: bool| {
				format!(
					"turn it in later in this guide{}, or make the accept `optional` when the player may leave it",
					if excluded { ", or pick a `next` guide these characters can follow" } else { " or in a guide after it" }
				)
			};
			let failing: Vec<&Route> = routes.iter().filter(|r| !r.left.is_empty()).collect();
			if routes.is_empty() || failing.len() == routes.len() {
				let left: CharSet = if !routes.is_empty() { failing.iter().flat_map(|r| r.left.iter().cloned()).collect() } else { open.clone() };
				let reasons: Vec<String> = failing
					.iter()
					.filter(|r| outside(r))
					.map(|r| {
						let w = why(r, &format!("\"{}\"", ts(&r.s.get("id"))));
						w[2..w.len() - 1].to_string()
					})
					.collect();
				let because = if reasons.is_empty() { String::new() } else { format!(" ({})", reasons.join("; ")) };
				diag.warn(
					&file,
					line(&a.goal),
					format!("quest {name} is accepted but never turned in later in this guide or a guide after it{}{because}", some(left.len())),
					Some(hint(!reasons.is_empty())),
				);
				continue;
			}
			for r in failing {
				diag.warn(
					&file,
					line(&a.goal),
					format!("quest {name} is accepted but never turned in on the route through \"{}\"{}{}", ts(&r.s.get("id")), some(r.left.len()), why(r, "it")),
					Some(hint(outside(r))),
				);
			}
		}

		// The route's level at each goal (when XP data exists): accepts above it warn, and the timed-item
		// check times kills at it.
		let mut levels: FxHashMap<Key, f64> = FxHashMap::default();
		if data.has_xp {
			let mut visiting = FxHashSet::default();
			visiting.insert(key(&g.get("id")));
			let entry = ctx.entry_xp(g, &mut visiting);
			let mut on_goal = |_step: &V, goal: &V, xp: f64| {
				let reach = level_at(xp);
				levels.insert(key(goal), reach);
				let min_level = goal.get("minLevel").num();
				if t_of(goal) != "accept" || !(min_level > 0.0) {
					return;
				}
				if min_level > reach {
					diag.warn(
						&file,
						line(goal),
						format!("quest {} needs level {}, but the route plausibly reaches only level {} here", ts(&goal.get("quest")), ts(&goal.get("minLevel")), crate::js::num_str(reach)),
						None,
					);
				}
			};
			ctx.walk_xp(g, entry, Some(&mut on_goal));
		}
		check_timed_items(
			g,
			data,
			diag,
			&|goal: &V| levels.get(&key(goal)).copied(),
			&|step: &V, goal: &V| {
				let quest = goal.get("quest");
				characters(&[gl.clone(), step.hidden("_only"), goal.hidden("_only")], &if !quest.is_undef() { data.quest(&quest) } else { V::Null })
			},
			&meets,
		);
	}
}

const SOLO_GOALS: &[&str] = &["accept", "turnin", "complete", "kill", "collect", "interact", "use"];

fn solo_exclusion(e: &V) -> Option<String> {
	let category = e.get("category");
	if category.truthy() {
		let c = ts(&category);
		return if crate::solo::CATEGORIES.contains(&c.as_str()) { Some(c) } else { None };
	}
	if e.get("reason").as_str() == Some("profession") {
		Some("profession".into())
	} else {
		None
	}
}

/// Leveling guides route solo characters: a goal that needs a quest the simulator's solo filter excludes
/// should be `optional`; an elite one must be. `excluded`: { faction: { questId: { title, reason, category } } }
/// (a missing faction is not checked).
pub fn validate_solo_policy(guides: &[V], excluded: &V, diag: &mut Diagnostics) {
	for g in guides {
		if g.get("category").as_str() != Some("Leveling") {
			continue;
		}
		let gl = guide_layer(g);
		let chosen = group_quests_of(g);
		for step in g.get("steps").items() {
			for goal in step.get("goals").items() {
				let quest = goal.get("quest");
				if goal.get("optional").truthy() || party_work(&step, &goal, &chosen) || quest.is_undef() || !SOLO_GOALS.contains(&t_of(&goal).as_str()) || elite_reported(&goal) {
					continue;
				}
				for side in applicable(&[gl.clone(), step.hidden("_only"), goal.hidden("_only")]).get("factions").items() {
					let ex = excluded.get(&ts(&side));
					let e = if ex.truthy() { ex.get(&ts(&quest)) } else { V::Undef };
					let why = if e.truthy() { solo_exclusion(&e) } else { None };
					let Some(why) = why else { continue };
					if why == "repeatable" && goal.get("direct").truthy() {
						continue;
					}
					let title = ts(&or(e.get("title"), goal.get("title")));
					let reason = ts(&e.get("reason"));
					if why == "elite" {
						house_rule(diag, g, &ast_file(g), line(&goal), format!("quest {} ({title}) is elite (solo filter: {reason}); {}", ts(&quest), elite_tip(&title)));
					} else {
						diag.warn(&ast_file(g), line(&goal), format!("quest {} ({title}) is excluded from solo leveling ({why}: {reason}); make the goal `optional`", ts(&quest)), None);
					}
					break;
				}
			}
		}
	}
}
