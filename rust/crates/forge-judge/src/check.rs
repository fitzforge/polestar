//! `forge judge check`: the fast, independent route gate on a build's written guides. Each rule reads
//! the written guides (and the data beside them) and names the line that breaks it, as
//! `<Start> <file>:<line> <rule> blocker|warn: <message>`:
//!
//! 1. [`honest`]: the honest playtest's fail findings (default mode) under R1 (travel), R2 (accept),
//!    R3 (items), R5 (turn-in), R6 (class/race gate) and R10 (never handed in) that v1's guides do not
//!    have, on the start's chain (the report's `honest_new` key).
//! 2. Order rules from the data: [`lock_keys`] (an item looted from a locked object before the key's
//!    holder is killed), [`item_before_use`], [`deliberate`] (route fixes `deliberate` `pairs` and
//!    `after` the written walk breaks) and [`fixes_rows`] (the build's fixes ledger's blocking rows).
//! 3. [`rare_required`]: a required collect or accept that waits on a rare drop: a quest-starting item
//!    whose drops are all under [`RARE_PCT`] % or of unknown chance, a quest objective's item whose
//!    drops are all known and under it, or a quest the route fixes keep optional.
//! 4. [`hearth_cooldown`]: a hearth used while the stone is on cooldown on the walk's modelled time.
//! 5. [`bounces`]: a travel leg to a place where nothing is done for the class before the walk leaves
//!    back toward where it came from.
//! 6. [`round_trip`] (warn): the written walk against the model route (quests only in one, out of
//!    order, hours).
//! 7. [`levels`] (warn): quest work more than [`UNDER_LEVELS`] levels under the quest, turn-ins grey.
//! 8. [`hub_order`], [`walked_past`], [`left_ready`] (warn, `check/hub.rs`): a hub visit walked the
//!    long way round, a ready hand-in walked past, a hub left with a ready line it comes back for.
//!
//! The walk-based rules run on each class's walk; one violation met by several classes is one line
//! listing them (none listed: every class).

use rustc_hash::{FxHashMap, FxHashSet};
use serde::Serialize;
use serde_json::Value;

use crate::honest::Finding;
use crate::walk::{WPt, WalkGoal};

/// A drop under this chance (percent) is rare: nothing required may wait on it.
pub const RARE_PCT: f64 = 5.0;
/// Quest work more than this many levels under the quest's level is under-level work.
pub const UNDER_LEVELS: f64 = 3.0;
/// A travel leg shorter than this is not a trip (a step to a flight master, a dock).
pub const BOUNCE_LEG_YD: f64 = 500.0;
/// Work within this many yards of a travel goal's point is done there.
pub const AT_PLACE_YD: f64 = 400.0;
/// The next place is "back" when it is nearer where the player came from than this share of the leg out
/// (and of the leg on from the place).
pub const BACK_SHARE: f64 = 0.5;
/// The honest rules the check gates on.
pub const HONEST_RULES: [&str; 6] = ["R1", "R2", "R3", "R5", "R6", "R10"];
/// Verbs that move the player rather than do something.
const MOVES: [&str; 5] = ["goto", "fly", "hearth", "die", "enter"];

#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize)]
#[serde(rename_all = "lowercase")]
pub enum Level {
	Blocker,
	Warn,
	/// Shown, never gating (the player view's counts against v1).
	Info,
}

impl Level {
	pub fn as_str(self) -> &'static str {
		match self {
			Level::Blocker => "blocker",
			Level::Warn => "warn",
			Level::Info => "info",
		}
	}
}

/// A flow rule's finding with where it can be fixed (the written-guide check fed back to the routes
/// stage, forge-sim's `flow`): goal indices of the lines to do elsewhere, done after goal `after`
/// (the stop the walk passed), else before goal `before` (where it went on to).
#[derive(Clone, Debug)]
pub struct FlowAt {
	pub v: Violation,
	pub lines: Vec<usize>,
	pub after: usize,
	pub before: usize,
}

/// One broken rule at one line.
#[derive(Clone, Debug, PartialEq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Violation {
	pub start: String,
	/// The guide file under the start's `forever/` (`horde/orc-troll/01-durotar.guide`), or the build
	/// file the rule read (`fixes.json`, `routes/Orc.json`) with line 0.
	pub file: String,
	pub line: u32,
	pub rule: String,
	pub level: Level,
	pub message: String,
	/// The classes it holds for; empty: every class (or the rule has no class).
	#[serde(skip_serializing_if = "Vec::is_empty")]
	pub classes: Vec<String>,
}

impl Violation {
	pub fn new(file: impl Into<String>, line: u32, rule: &str, level: Level, message: impl Into<String>) -> Violation {
		Violation { start: String::new(), file: file.into(), line, rule: rule.into(), level, message: message.into(), classes: Vec::new() }
	}

	fn at(g: &WalkGoal, rule: &str, level: Level, message: impl Into<String>) -> Violation {
		let (f, l) = place(g);
		Violation::new(f, l, rule, level, message)
	}

	/// `<Start> <file>:<line> <rule> blocker|warn: <message>` (and ` [Class, ...]`).
	pub fn text(&self) -> String {
		let cls = if self.classes.is_empty() { String::new() } else { format!(" [{}]", self.classes.join(", ")) };
		format!("{} {}:{} {} {}: {}{cls}", self.start, self.file, self.line, self.rule, self.level.as_str(), self.message)
	}
}

/// A goal's guide file (under `forever/`) and line.
fn place(g: &WalkGoal) -> (String, u32) {
	(guide_file(&g.guide), g.line.unwrap_or(0))
}

fn guide_file(id: &str) -> String {
	format!("{}.guide", id.trim_start_matches("forever/"))
}

fn line_of(g: &WalkGoal) -> String {
	format!("{}:{}", guide_file(&g.guide), g.line.unwrap_or(0))
}

/// Yards between two points (infinite across continents).
fn dist(a: WPt, b: WPt) -> f64 {
	if a.c != b.c {
		return f64::INFINITY;
	}
	(a.wx - b.wx).hypot(a.wy - b.wy)
}

fn is_move(g: &WalkGoal) -> bool {
	MOVES.contains(&g.t.as_str())
}

/// A goal that does something where it stands (not a move, a note or a grind gate).
fn is_work(g: &WalkGoal) -> bool {
	!is_move(g) && g.t != "note"
}

/// An item's sources as the data has them.
#[derive(Clone, Debug, Default)]
pub struct ItemFacts {
	pub name: String,
	/// (npc, chance %; None: unknown).
	pub npc: Vec<(u32, Option<f64>)>,
	/// (object, chance %; None: unknown).
	pub object: Vec<(u32, Option<f64>)>,
	pub vendor: bool,
}

impl ItemFacts {
	/// Only drops, and every one under [`RARE_PCT`], or of unknown chance from one of several NPCs (an
	/// unknown chance from a single NPC is its named holder's loot; an object's is a container you loot).
	pub fn rare(&self) -> bool {
		!self.vendor
			&& !(self.npc.is_empty() && self.object.is_empty())
			&& self.npc.iter().all(|(_, c)| c.map_or(self.npc.len() > 1, |c| c < RARE_PCT))
			&& self.object.iter().all(|(_, c)| c.is_some_and(|c| c < RARE_PCT))
	}

	/// [`ItemFacts::rare`] with every chance known: the bar for a quest objective (the data carries no
	/// chance for most objective items of Forever's own quests, scripted loot included).
	pub fn rare_known(&self) -> bool {
		self.rare() && self.npc.iter().chain(&self.object).all(|(_, c)| c.is_some())
	}

	fn chances(&self) -> String {
		let mut v: Vec<String> = self.npc.iter().chain(&self.object).map(|(_, c)| c.map_or("unknown".to_string(), |c| format!("{c} %"))).collect();
		v.dedup();
		v.join(", ")
	}
}

#[derive(Clone, Debug, Default)]
pub struct QuestFacts {
	pub title: String,
	pub level: Option<f64>,
	/// Items that start it.
	pub start_items: Vec<u32>,
	/// An NPC or object offers it.
	pub start_giver: bool,
	/// The item handed over at the accept.
	pub source_item: Option<u32>,
	pub min_level: Option<f64>,
	/// Quests one of which must be handed in first (the data's `pre` and `preAny`, and the quest whose
	/// `next` this is): the Writhing Haunt Cauldron (5224) opens with Return to Chillwind Camp's hand-in.
	/// Not its breadcrumbs (Taking Back Silithus 8276 only leads to Securing the Supply Lines 8280) nor
	/// its parent ([`quest_pre`]).
	pub pre: Vec<i64>,
	/// The quest that must be in the log, not handed in, for this one to be offered (the data's
	/// `parent`, the TDB's negative PrevQuestID): Stranglethorn Fever's log quest 349 inside 348;
	/// Chapter I-IV (339-342) taken while The Green Hills of Stranglethorn (338) is open.
	pub parent: Option<i64>,
	/// The data's class mask (0: any class) and race mask (0: any race).
	pub classes: u32,
	pub races: u64,
}

/// A quest's hand-in prerequisites: the data's `pre` and `preAny` and the quests whose `next` it is,
/// less its breadcrumbs (optional lead-ins the game does not require) and its parent (needed in the log,
/// not handed in).
pub fn quest_pre(listed: &[i64], next_of: &[i64], breadcrumbs: &[i64], parent: Option<i64>) -> Vec<i64> {
	let mut pre: Vec<i64> = listed.iter().chain(next_of).copied().filter(|p| !breadcrumbs.contains(p) && Some(*p) != parent).collect();
	pre.sort_unstable();
	pre.dedup();
	pre
}

/// What the rules read from the data, the sim world and the route fixes.
#[derive(Clone, Debug, Default)]
pub struct Facts {
	pub items: FxHashMap<u32, ItemFacts>,
	/// Locked object -> its key item.
	pub locks: FxHashMap<u32, u32>,
	pub quests: FxHashMap<i64, QuestFacts>,
	/// The sim's (quest, task index) -> the guide's objective numbers (1-based) worked there.
	pub tasks: FxHashMap<(i64, u32), Vec<i64>>,
	/// Route fixes `deliberate` `optional`: quests no route may count on.
	pub optional: FxHashMap<i64, String>,
}

impl Facts {
	/// From the data the guides compile against, the sim world (task layout) and the route fixes
	/// (`deliberate`).
	pub fn new(data: &forge_guide::data::Data, world: Option<&forge_world::World>, deliberate: &Value) -> Facts {
		use forge_guide::js::V;
		let num = |v: &V| v.as_num().filter(|n| n.is_finite());
		let mut f = Facts::default();
		for (id, it) in data.items.entries() {
			let Ok(id) = id.parse::<u32>() else { continue };
			let src = |k: &str| -> Vec<(u32, Option<f64>)> { it.get("drops").get(k).entries().iter().filter_map(|(n, c)| Some((n.parse().ok()?, num(c)))).collect() };
			f.items.insert(id, ItemFacts { name: it.get("name").as_str().unwrap_or("").to_string(), npc: src("npc"), object: src("object"), vendor: !it.get("vendors").is_empty() });
		}
		for (id, o) in data.objects.entries() {
			if let (Ok(id), Some(k)) = (id.parse::<u32>(), num(&o.get("lock").get("item"))) {
				f.locks.insert(id, k as u32);
			}
		}
		let mut next_of: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
		for (id, q) in data.quests.entries() {
			if let (Ok(id), Some(n)) = (id.parse::<i64>(), num(&q.get("next")).filter(|n| *n > 0.0)) {
				next_of.entry(n as i64).or_default().push(id);
			}
		}
		for (id, q) in data.quests.entries() {
			let Ok(id) = id.parse::<i64>() else { continue };
			let st = q.get("start");
			let listed: Vec<i64> = q.get("pre").items().iter().chain(q.get("preAny").items().iter()).filter_map(|p| num(p).map(|p| p as i64)).collect();
			let breadcrumbs: Vec<i64> = q.get("breadcrumbs").items().iter().filter_map(|p| num(p).map(|p| p as i64)).collect();
			let parent = num(&q.get("parent")).map(|p| p as i64);
			let pre = quest_pre(&listed, next_of.get(&id).map_or(&[][..], Vec::as_slice), &breadcrumbs, parent);
			f.quests.insert(
				id,
				QuestFacts {
					title: q.get("title").as_str().unwrap_or("").to_string(),
					level: num(&q.get("level")).filter(|l| *l > 0.0),
					start_items: st.get("item").items().iter().filter_map(|i| num(i).map(|i| i as u32)).collect(),
					start_giver: !st.get("npc").is_empty() || !st.get("object").is_empty(),
					source_item: num(&q.get("sourceItem")).map(|i| i as u32),
					min_level: num(&q.get("minLevel")),
					pre,
					parent,
					classes: num(&q.get("classes")).map_or(0, |c| c as u32),
					races: num(&q.get("races")).map_or(0, |r| r as u64),
				},
			);
		}
		if let Some(w) = world {
			for q in &w.quests {
				for o in &q.objs {
					if let Some(t) = o.task {
						f.tasks.entry((q.id as i64, t)).or_default().push(o.oi + 1);
					}
				}
			}
		}
		for r in deliberate["optional"].as_array().into_iter().flatten() {
			if let Some(q) = r["q"].as_i64() {
				f.optional.insert(q, r["why"].as_str().unwrap_or("").to_string());
			}
		}
		f
	}

	fn title(&self, q: i64) -> String {
		self.quests.get(&q).map_or_else(|| q.to_string(), |x| if x.title.is_empty() { q.to_string() } else { format!("{} ({q})", x.title) })
	}

	fn item_name(&self, i: u32) -> String {
		self.items.get(&i).filter(|x| !x.name.is_empty()).map_or_else(|| format!("item {i}"), |x| format!("{} ({i})", x.name))
	}

	fn starts_quest(&self, item: u32) -> bool {
		self.quests.values().any(|q| q.start_items.contains(&item))
	}
}

/// Rule 1: the honest playtest's new fail findings on the chain, under [`HONEST_RULES`]. The classes are
/// the personas' (empty when they are all of `all_classes`).
pub fn honest(written: &[Finding], v1: &[Finding], chain: &FxHashSet<String>, all_classes: &[String]) -> Vec<Violation> {
	let have = honest_keys(v1);
	merge_places(honest_candidates(written, chain, all_classes).into_iter().filter(|(k, _)| !have.contains(k)).map(|(_, v)| v).collect(), all_classes)
}

/// One line per (rule, place): the same finding met by several personas with the class in its reason
/// (R6: "closes it to Human Warlock") is one line naming the classes (none named when they are every
/// class of `all`), its message naming them too ("closes it to Human Warlock, Warrior and Mage").
pub fn merge_places(list: Vec<Violation>, all: &[String]) -> Vec<Violation> {
	// Per line: its first class (as the message names it) and whether a merged message differed.
	let mut out: Vec<(Violation, Option<String>, bool)> = Vec::new();
	for v in list {
		match out.iter_mut().find(|(o, _, _)| o.rule == v.rule && o.file == v.file && o.line == v.line) {
			Some((o, _, differ)) => {
				*differ |= o.message != v.message;
				let every = o.classes.is_empty() || v.classes.is_empty();
				for c in v.classes {
					if !o.classes.contains(&c) {
						o.classes.push(c);
					}
				}
				if every {
					o.classes.clear();
				}
			}
			None => {
				let first = v.classes.first().cloned();
				out.push((v, first, false));
			}
		}
	}
	let labels: Vec<String> = all.iter().map(|c| class_label(c)).collect();
	out.into_iter()
		.map(|(mut v, first, differ)| {
			if !v.classes.is_empty() && labels.iter().all(|c| v.classes.contains(c)) {
				v.classes.clear();
			}
			if let (true, Some(first)) = (differ, first) {
				let at = format!(" {first} ");
				if let Some(i) = v.message.find(&at) {
					let named = match v.classes.as_slice() {
						[] => " ".to_string(),
						[one] => format!(" {one} "),
						[rest @ .., last] => format!(" {} and {last} ", rest.join(", ")),
					};
					v.message.replace_range(i..i + at.len(), &named);
				}
			}
			v
		})
		.collect()
}

/// v1's fail findings by the report's key (rule and reason less its distances).
pub fn honest_keys(v1: &[Finding]) -> FxHashSet<String> {
	v1.iter().filter(|f| f.severity == crate::honest::Severity::Fail).map(crate::report::diff_key).collect()
}

/// The written guides' fail findings on the chain under [`HONEST_RULES`], the first of each key, with
/// their key ([`honest`] less v1's keys).
pub fn honest_candidates(written: &[Finding], chain: &FxHashSet<String>, all_classes: &[String]) -> Vec<(String, Violation)> {
	let mut seen: FxHashSet<String> = FxHashSet::default();
	let mut out = Vec::new();
	for f in written {
		if f.severity != crate::honest::Severity::Fail || !chain.contains(&f.guide) || !HONEST_RULES.contains(&f.rule) {
			continue;
		}
		let k = crate::report::diff_key(f);
		if !seen.insert(k.clone()) {
			continue;
		}
		let mut v = Violation::new(guide_file(&f.guide), f.line, f.rule, Level::Blocker, format!("{}: {}", f.title, f.reason));
		let mut cls: Vec<String> = Vec::new();
		for (_, c) in &f.personas {
			if !c.is_empty() && !cls.contains(c) {
				cls.push(c.clone());
			}
		}
		if !all_classes.iter().all(|c| cls.contains(c)) {
			v.classes = cls.iter().map(|c| class_label(c)).collect();
		}
		out.push((k, v));
	}
	out
}

/// `WARRIOR` -> `Warrior`.
pub fn class_label(file: &str) -> String {
	forge_core::CLASSES.iter().find(|c| c.file.eq_ignore_ascii_case(file)).map_or_else(|| file.to_string(), |c| format!("{}{}", c.key[..1].to_uppercase(), &c.key[1..]))
}

/// Rule 2a: an item looted from a locked object (every source of it is an object whose lock wants a key)
/// before any line gets the key (collects it, or kills the NPC it drops from).
pub fn lock_keys(goals: &[WalkGoal], facts: &Facts) -> Vec<Violation> {
	let mut out = Vec::new();
	for (i, g) in goals.iter().enumerate() {
		let Some(item) = g.item.filter(|_| g.t == "collect") else { continue };
		let Some(it) = facts.items.get(&item) else { continue };
		if !it.npc.is_empty() || it.object.is_empty() {
			continue;
		}
		let keys: Vec<u32> = it.object.iter().filter_map(|(o, _)| facts.locks.get(o).copied()).collect();
		let Some(&key) = keys.first().filter(|_| keys.len() == it.object.len()) else { continue };
		let holders: Vec<u32> = facts.items.get(&key).map(|k| k.npc.iter().map(|(n, _)| *n).collect()).unwrap_or_default();
		let gets = |h: &WalkGoal| (h.t == "collect" && h.item == Some(key)) || h.npc.is_some_and(|n| holders.contains(&n) && h.t != "talk");
		if goals[..i].iter().any(gets) {
			continue;
		}
		let later = goals[i + 1..].iter().find(|h| gets(h));
		let msg = match later {
			Some(h) => format!("{} is looted from a locked chest before {} is had: the key comes at {}", facts.item_name(item), facts.item_name(key), line_of(h)),
			None => format!("{} is looted from a locked chest and no line before it gets {}", facts.item_name(item), facts.item_name(key)),
		};
		out.push(Violation::at(g, "lock-key", Level::Blocker, msg));
	}
	out
}

/// Rule 2b: an item used before the line that gets it (a later collect or buy, none before, and no
/// accept hands it over first).
pub fn item_before_use(goals: &[WalkGoal], facts: &Facts) -> Vec<Violation> {
	let mut out = Vec::new();
	for (i, g) in goals.iter().enumerate() {
		let Some(item) = g.item.filter(|_| g.t == "use") else { continue };
		let gets =
			|h: &WalkGoal| ((h.t == "collect" || h.t == "buy") && h.item == Some(item)) || (h.t == "accept" && h.q.and_then(|q| facts.quests.get(&q)).is_some_and(|q| q.source_item == Some(item)));
		if goals[..i].iter().any(gets) {
			continue;
		}
		if let Some(h) = goals[i + 1..].iter().find(|h| gets(h)) {
			out.push(Violation::at(g, "item-use", Level::Blocker, format!("uses {} before {} gets it", facts.item_name(item), line_of(h))));
		}
	}
	out
}

/// A route-fixes step (`[kind, quest]` or `["task", quest, index]`) matches a walk goal.
fn step_matches(s: &Value, g: &WalkGoal, facts: &Facts) -> bool {
	let (Some(kind), Some(q)) = (s[0].as_str(), s[1].as_i64()) else { return false };
	if g.q != Some(q) {
		return false;
	}
	match kind {
		"accept" | "turnin" => g.t == kind,
		"task" => {
			if g.t == "accept" || g.t == "turnin" || g.t == "abandon" || !is_work(g) {
				return false;
			}
			match s[2].as_u64().and_then(|t| facts.tasks.get(&(q, t as u32))) {
				Some(ois) => g.oi.is_none_or(|oi| ois.contains(&oi)),
				None => true,
			}
		}
		_ => false,
	}
}

fn step_text(s: &Value) -> String {
	match s[2].as_u64() {
		Some(t) => format!("{} {} #{t}", s[0].as_str().unwrap_or(""), s[1]),
		None => format!("{} {}", s[0].as_str().unwrap_or(""), s[1]),
	}
}

/// Rule 2c: route fixes `deliberate` `pairs` and `after`, and `overrides` `pairs` (`a` before `b`), the
/// walk breaks: some step of `a` after the first step of `b`, when both are on the walk. (The overrides'
/// pairs are the maintainer's hard rules: the sim keeps them, so must the written guide, #739's Gordo's
/// Task moved ahead of Vital Intelligence by the writer's hub tour.)
pub fn deliberate(goals: &[WalkGoal], deliberate: &Value, overrides: &Value, facts: &Facts) -> Vec<Violation> {
	let mut out = Vec::new();
	for (doc, name, sec) in [(deliberate, "deliberate", "pairs"), (deliberate, "deliberate", "after"), (overrides, "overrides", "pairs")] {
		for (k, r) in doc[sec].as_array().into_iter().flatten().enumerate() {
			let (a, b) = (&r["a"], &r["b"]);
			let Some(first_b) = goals.iter().position(|g| step_matches(b, g, facts)) else { continue };
			let Some(last_a) = goals.iter().rposition(|g| step_matches(a, g, facts)) else { continue };
			if last_a > first_b {
				let why = r["why"].as_str().unwrap_or("");
				out.push(Violation::at(
					&goals[first_b],
					"deliberate",
					Level::Blocker,
					format!("{} comes before {} ({}), against route fixes {name}.{sec}[{k}]: {why}", step_text(b), step_text(a), line_of(&goals[last_a])),
				));
			}
		}
	}
	out
}

/// Rule 2d: the fixes ledger's (`<out>/fixes.json`) blocking rows for `start` (a row that names no
/// starts is the build's, given with `start` "all").
pub fn fixes_rows(ledger: &Value, start: &str) -> Vec<Violation> {
	let ok = ["applied", "not for this start", "passes", "redundant", "pass"];
	let mut out = Vec::new();
	for f in ledger["files"].as_array().into_iter().flatten() {
		let file = f["file"].as_str().unwrap_or("");
		for r in f["rows"].as_array().into_iter().flatten().filter(|r| r["blocking"].as_bool() == Some(true)) {
			let starts = r["starts"].as_object().filter(|s| !s.is_empty());
			let state = match starts {
				Some(s) => match s.get(start).and_then(Value::as_str) {
					Some(st) if !ok.contains(&st) => st.to_string(),
					_ => continue,
				},
				None if start == "all" => r["state"].as_str().unwrap_or("").to_string(),
				None => continue,
			};
			let detail = r["detail"].as_str().filter(|d| !d.is_empty()).map_or(String::new(), |d| format!(" ({d})"));
			out.push(Violation::new("fixes.json", 0, "fixes", Level::Blocker, format!("{file} {}: {state}{detail}", r["at"].as_str().unwrap_or(""))));
		}
	}
	out
}

/// Rule `class-lost` (blocker): a class quest the seed guides take (a required `accept` of a quest
/// whose data names classes) that no written guide of the start accepts, for each class of the start's
/// race that can do it and that the quest's races allow: the Dwarf Paladins' Tome of Divinity chain
/// (2999-1785) left c13's Dwarf guides without a word (RevDwarfGnome3). `seed`: (file under the seed's
/// `forever/`, text) of the faction's seed guides; `written`: the start's written guide texts; `race_bit`
/// the race's bit in the data's masks; `classes` the race's playable classes (files). The line is the seed's.
pub fn lost_class_quests(seed: &[(String, String)], written: &[String], facts: &Facts, race_bit: u64, classes: &[String]) -> Vec<Violation> {
	let acc = regex::Regex::new(r"^\s+accept\s+(\d+)\b").unwrap();
	let optional = regex::Regex::new(r"\boptional\b").unwrap();
	let taken: FxHashSet<i64> = written.iter().flat_map(|t| t.lines()).filter_map(|l| acc.captures(l).and_then(|m| m[1].parse().ok())).collect();
	let mut seen: FxHashSet<i64> = FxHashSet::default();
	let mut out = Vec::new();
	for (file, text) in seed {
		for (n, l) in text.lines().enumerate() {
			let code = l.split(" -- ").next().unwrap_or(l);
			let Some(q) = acc.captures(code).and_then(|m| m[1].parse::<i64>().ok()) else { continue };
			if optional.is_match(code) || taken.contains(&q) || !seen.insert(q) {
				continue;
			}
			let Some(f) = facts.quests.get(&q).filter(|f| f.classes != 0 && (f.races == 0 || f.races & race_bit != 0)) else { continue };
			let who: Vec<&String> = classes.iter().filter(|c| forge_core::class_by_file(c).is_some_and(|ci| f.classes & ci.bit != 0)).collect();
			// (A mask that holds every class the race plays is no class gate.)
			if who.is_empty() || who.len() == classes.len() {
				continue;
			}
			let mut v = Violation::new(
				file.clone(),
				n as u32 + 1,
				"class-lost",
				Level::Blocker,
				format!("{} is in the seed guide here, and in no written guide: these characters never get it", facts.title(q)),
			);
			v.classes = who.iter().map(|c| class_label(c)).collect();
			out.push(v);
		}
	}
	out
}

/// Rule 3: a collect or accept no line marks optional that waits on a rare drop: a quest objective's
/// item or a quest-starting item ([`ItemFacts::rare`]), a quest only such items start, or a quest the
/// route fixes keep optional.
pub fn rare_required(goals: &[WalkGoal], facts: &Facts) -> Vec<Violation> {
	let mut out = Vec::new();
	for g in goals.iter().filter(|g| !g.optional) {
		if g.t == "collect" {
			let Some(item) = g.item else { continue };
			let Some(it) = facts.items.get(&item).filter(|it| it.rare()) else { continue };
			let starter = facts.starts_quest(item);
			if starter || (g.q.is_some() && it.rare_known()) {
				let what = g.q.map_or_else(|| "starts a quest".to_string(), |q| format!("is an objective of {}", facts.title(q)));
				out.push(Violation::at(g, "rare", Level::Blocker, format!("{} {what} and drops at {}: required, not optional", facts.item_name(item), it.chances())));
			}
		} else if g.t == "accept" {
			let Some(q) = g.q else { continue };
			if let Some(why) = facts.optional.get(&q) {
				out.push(Violation::at(g, "rare", Level::Blocker, format!("{} is required, but the route fixes keep it optional: {why}", facts.title(q))));
				continue;
			}
			let Some(qf) = facts.quests.get(&q) else { continue };
			if !qf.start_giver && !qf.start_items.is_empty() && qf.start_items.iter().all(|i| facts.items.get(i).is_some_and(ItemFacts::rare)) {
				let chances: Vec<String> = qf.start_items.iter().filter_map(|i| facts.items.get(i)).map(ItemFacts::chances).collect();
				out.push(Violation::at(g, "rare", Level::Blocker, format!("{} starts only from a rare drop ({}): required, not optional", facts.title(q), chances.join("; "))));
			}
		}
	}
	out
}

/// Rule 4: a hearth used less than `cooldown` seconds after the last one, on the walk's modelled time.
pub fn hearth_cooldown(goals: &[WalkGoal], cooldown: f64) -> Vec<Violation> {
	let mut out = Vec::new();
	let mut last: Option<&WalkGoal> = None;
	for g in goals.iter().filter(|g| g.t == "hearth") {
		if let Some(p) = last {
			let gap = g.time - p.time;
			if gap + 1.0 < cooldown {
				out.push(Violation::at(g, "hearth", Level::Blocker, format!("hearth {:.0} min after the one at {} (cooldown {:.0} min)", gap / 60.0, line_of(p), cooldown / 60.0)));
				continue;
			}
		}
		last = Some(g);
	}
	out
}

/// The route's own count of v1 hearth lines it plans on cooldown (`improved.planHearthsOnCooldown`).
pub fn planned_hearths(route: &Value, route_file: &str) -> Option<Violation> {
	let n = route["improved"]["planHearthsOnCooldown"].as_u64().filter(|n| *n > 0)?;
	Some(Violation::new(route_file, 0, "hearth", Level::Blocker, format!("the route plans {n} hearth(s) while the stone is on cooldown (improved.planHearthsOnCooldown)")))
}

/// Rule 5: a travel goal to a place (more than [`BOUNCE_LEG_YD`] from where the player stood) where
/// nothing is done before the walk leaves back toward where it came from: the next place is nearer the
/// one before than either is to it (or it is on another continent than both).
pub fn bounces(goals: &[WalkGoal]) -> Vec<Violation> {
	bounces_at(goals).into_iter().map(|f| f.v).collect()
}

/// [`bounces`] with where: the quest lines of the stop the walk goes back to, done before the trip
/// (after the goal before its travel line).
pub fn bounces_at(goals: &[WalkGoal]) -> Vec<FlowAt> {
	let mut out = Vec::new();
	// Where the player stands before each goal: the last point, the bind after a hearth, unknown after a
	// flight with no point.
	let mut here: Vec<Option<WPt>> = Vec::with_capacity(goals.len());
	let (mut at, mut bind): (Option<WPt>, Option<WPt>) = (None, None);
	for g in goals {
		here.push(at);
		if g.t == "sethome" && g.w.is_some() {
			bind = g.w;
		}
		at = match (g.w, g.t.as_str()) {
			(Some(w), _) => Some(w),
			(None, "hearth") => bind,
			(None, "fly" | "die") => None,
			(None, _) => at,
		};
	}
	for (k, g) in goals.iter().enumerate() {
		let (Some(b), Some(a)) = (g.w.filter(|_| g.t == "goto" && !g.optional), here[k]) else { continue };
		if dist(a, b) < BOUNCE_LEG_YD {
			continue;
		}
		// The first goal after it that is not at it: work there (or work with no point, done where the
		// player stands) ends the search.
		let mut next: Option<(WPt, usize)> = None;
		let mut worked = false;
		for (j, h) in goals.iter().enumerate().skip(k + 1) {
			// Work in the travel goal's own step is what the step went there for, wherever its point is.
			if is_work(h) && h.step.is_some() && h.step == g.step && h.guide == g.guide {
				worked = true;
				break;
			}
			match h.w {
				Some(p) if dist(p, b) <= AT_PLACE_YD => {
					if is_work(h) {
						worked = true;
						break;
					}
				}
				Some(p) => {
					next = Some((p, j));
					break;
				}
				None if is_work(h) => {
					// Work with no point of its own: done here, unless its zone is the place it came from.
					if h.map.is_some_and(|m| m != b.map) && h.map == Some(a.map) {
						next = Some((a, j));
					} else {
						worked = true;
					}
					break;
				}
				None if h.t == "hearth" || h.t == "fly" || h.t == "die" => break,
				None => {}
			}
		}
		let (Some((c, j)), false) = (next, worked) else { continue };
		// Back: the next place is on the continent it came from while this one is not, or much nearer
		// where it came from than to this place (a waypoint on the way sits between, not out to one side).
		// A next place in the same zone as this one is that zone's work reached through its entrance (the
		// Great Lift into Thousand Needles), not a way back.
		let back = if a.c == c.c && a.c != b.c { true } else { c.map != b.map && dist(a, c) < BACK_SHARE * dist(a, b).min(dist(b, c)) };
		if back {
			let what = g.title.clone().unwrap_or_else(|| "this place".into());
			let v = Violation::at(g, "bounce", Level::Blocker, format!("goes to {what} and does nothing there, then back toward where it came from ({})", line_of(&goals[j])));
			// The stop it goes back to: the goals from j at its place.
			let back_stop: Vec<usize> = (j..goals.len()).take_while(|&i| goals[i].w.is_none_or(|w| dist(w, c) <= SAME_PLACE_YD) && !is_move(&goals[i])).collect();
			out.push(FlowAt { v, lines: back_stop, after: k.saturating_sub(1), before: k });
		}
	}
	out
}

/// Rule 6 (warn): the written walk against the model route's stream ([`crate::report::stream_diff`]).
pub fn round_trip(d: &crate::report::StreamDiff, stream_file: &str) -> Option<Violation> {
	let pct = if d.order_h60 > 0.0 { (d.written_h60 - d.order_h60) / d.order_h60 * 100.0 } else { 0.0 };
	if d.only_in_order.is_empty() && d.only_written.is_empty() && d.out_of_order.is_empty() && pct.abs() < 1.0 {
		return None;
	}
	let few = |v: &[String]| if v.is_empty() { String::new() } else { format!(" ({}{})", v.iter().take(3).cloned().collect::<Vec<_>>().join("; "), if v.len() > 3 { "; ..." } else { "" }) };
	Some(Violation::new(
		stream_file,
		0,
		"round-trip",
		Level::Warn,
		format!(
			"{} only in the model{}, {} only written{}, {} out of order{}; hours to 60 model {:.2}, written {:.2} ({pct:+.1} %)",
			d.only_in_order.len(),
			few(&d.only_in_order),
			d.only_written.len(),
			few(&d.only_written),
			d.out_of_order.len(),
			few(&d.out_of_order),
			d.order_h60,
			d.written_h60
		),
	))
}

/// Rule 7 (warn): quest work begun [`UNDER_LEVELS`] or more levels under the quest's level (first goal
/// of each quest), and turn-ins at a level where the quest is grey.
pub fn levels(goals: &[WalkGoal], facts: &Facts) -> Vec<Violation> {
	let mut out = Vec::new();
	let mut seen: FxHashSet<i64> = FxHashSet::default();
	for g in goals {
		let Some(q) = g.q else { continue };
		let Some(ql) = facts.quests.get(&q).and_then(|x| x.level) else { continue };
		if !g.lvl.is_finite() {
			continue;
		}
		if g.t == "turnin" {
			if ql <= forge_sim::xp::grey_level(g.lvl.floor() as i64) as f64 {
				out.push(Violation::at(g, "grey", Level::Warn, format!("{} (level {ql}) handed in grey at {:.1}", facts.title(q), g.lvl)));
			}
		} else if g.t != "accept" && is_work(g) && !g.optional && seen.insert(q) && g.lvl + UNDER_LEVELS < ql {
			out.push(Violation::at(g, "under-level", Level::Warn, format!("{} (level {ql}) worked at {:.1}, {:.1} under", facts.title(q), g.lvl, ql - g.lvl)));
		}
	}
	out
}

/// A walk's numbers as a player feels them (the report's row, to 60).
#[derive(Clone, Debug, Default, PartialEq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Feel {
	pub hours: f64,
	/// All the level model's grinding to 60, written or not ([`crate::report::Measures::grind_all_min`]).
	pub grind_min: f64,
	/// The part on `level` steps (the grind a step tells the player to do), and the rest: grinding the
	/// walk needs that no step writes (an accept or a camp under its level, the model grinds up first).
	pub grind_shown_min: f64,
	pub grind_unwritten_min: f64,
	pub returns: usize,
	pub wasted_trips: usize,
	pub zone_changes: usize,
	pub passed_by: usize,
	pub pb_never: usize,
	pub pb_later: usize,
	pub area_visits: usize,
}

impl Feel {
	pub fn of(m: &crate::report::Measures) -> Feel {
		Feel {
			hours: m.hours,
			grind_min: m.grind_all_min,
			grind_shown_min: m.grind_shown_min,
			grind_unwritten_min: (m.grind_all_min - m.grind_shown_min).max(0.0),
			returns: m.returns,
			wasted_trips: m.wasted_trips,
			zone_changes: m.zone_changes,
			passed_by: m.passed_by,
			pb_never: m.pb_never,
			pb_later: m.pb_later,
			area_visits: m.area_visits,
		}
	}

	/// The metrics the gate holds to v1's: (name, value), worse when higher.
	fn gated(&self) -> [(&'static str, usize); 6] {
		[
			("avoidable returns", self.returns),
			("wasted trips", self.wasted_trips),
			("zone changes", self.zone_changes),
			("quests passed by", self.passed_by),
			("quests passed by and never done", self.pb_never),
			("area visits", self.area_visits),
		]
	}
}

/// The per-start player view: v1's guides and the written ones to 60, and where the written guides'
/// added returns and zone changes come from (the model order or the writer). The returns, wasted trips
/// and zone changes in `v1` and `written` leave chain ones out ([`is_chain_return`]); they are counted
/// in `chain_returns` and `chain_zone_changes` (v1's guides, written).
#[derive(Clone, Debug, Default, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct FeelRow {
	pub v1: Feel,
	pub written: Feel,
	/// The model order's numbers (its judge stream, v1's chain stream beside it), chains left out.
	pub order_returns: usize,
	pub v1_order_returns: usize,
	/// Added returns / zone changes of the written guides: (in the model order, the writer's).
	pub added_returns: (usize, usize),
	pub added_zone_changes: (usize, usize),
	pub chain_returns: (usize, usize),
	pub chain_zone_changes: (usize, usize),
}

/// A quest's chain prerequisites: what the data and the rules say must be handed in before it (any or
/// all), the quest whose `next` it is, and its breadcrumbs.
pub type ChainPre<'a> = &'a dyn Fn(i64) -> Vec<i64>;

/// A return is a chain, not avoidable: one of its quests there (`back`: walk index and quest) has a
/// chain prerequisite handed in away from the place, after the last visit's departure (`depart`) and
/// before the walk comes back (the first goal of `back`): the follow-up opened only at that hand-in
/// sends the player back (Brill's camp, hand in at Brill, back for the leaders). A prerequisite handed
/// in on the return itself (a breadcrumb at its giver) opens nothing the last visit could have done.
pub fn is_chain_return(goals: &[WalkGoal], depart: usize, back: &[(usize, i64)], pre: ChainPre) -> bool {
	let Some(arrive) = back.iter().map(|b| b.0).min() else { return false };
	let Some(away) = goals.get(depart + 1..arrive.min(goals.len())) else { return false };
	back.iter().any(|&(_, q)| {
		let ps = pre(q);
		!ps.is_empty() && away.iter().any(|g| g.t == "turnin" && g.q.is_some_and(|p| ps.contains(&p)))
	})
}

/// The zone change arriving at walk index `k` is a chain: a quest of the stay it begins (the located
/// quest goals on its map up to the next change) has a chain prerequisite handed in since the walk was
/// last on that map.
pub fn is_chain_zone(goals: &[WalkGoal], k: usize, pre: ChainPre) -> bool {
	let Some(m) = goals[k].w.map(|w| w.map) else { return false };
	let Some(prev) = goals[..k].iter().rposition(|g| g.w.is_some_and(|w| w.map == m)) else { return false };
	let mut back = Vec::new();
	for (i, g) in goals.iter().enumerate().skip(k) {
		let (Some(w), Some(q)) = (g.w, g.q) else { continue };
		if w.map != m {
			break;
		}
		back.push((i, q));
	}
	is_chain_return(goals, prev, &back, pre)
}

/// Above v1's value by more than this (absolute), a feel metric is worse: the larger of 2 and 2 % of v1.
pub fn feel_tolerance(v1: usize) -> f64 {
	(v1 as f64 * 0.02).max(2.0)
}

/// Goals this close to one another are at one place (one NPC, one board, one camp's centre).
pub const SAME_PLACE_YD: f64 = 60.0;
/// A place this far from another is a trip away from it.
pub const TRIP_YD: f64 = 300.0;
/// A quest giver this close to where the walk stands is one the player stands next to.
pub const NEXT_TO_YD: f64 = 50.0;
/// Two objectives this close are worked in one area (their spawns overlap).
pub const SAME_AREA_YD: f64 = 150.0;
/// Levels under a quest's level it is still on level (red or orange beyond): the model's dangerGap.
pub const ON_LEVEL_GAP: f64 = 5.0;

/// The walk as stops: runs of consecutive non-travel goals at one place (each within
/// [`SAME_PLACE_YD`] of the stop's last placed goal; a goal with no point stays at the current stop).
/// -> (the stop's first point, the goal indices).
pub fn stops(goals: &[WalkGoal]) -> Vec<(WPt, Vec<usize>)> {
	let mut out: Vec<(WPt, Vec<usize>)> = Vec::new();
	let mut last: Option<WPt> = None;
	for (i, g) in goals.iter().enumerate() {
		// (Along goals are done on the way, not at a stop.)
		if is_move(g) || g.t == "note" || g.t == "level" || g.along.is_some() {
			continue;
		}
		match (g.w, out.last_mut()) {
			(Some(w), Some(cur)) if last.is_some_and(|l| dist(l, w) <= SAME_PLACE_YD) => {
				cur.1.push(i);
				last = Some(w);
			}
			(Some(w), _) => {
				out.push((w, vec![i]));
				last = Some(w);
			}
			(None, Some(cur)) => cur.1.push(i),
			(None, None) => {}
		}
	}
	out
}

/// Rule `dup-trip` (blocker): the walk stops at a place, goes on to another place a trip away, and comes
/// straight back to the first, where nothing it does needed the trip: no quest of the return stop was
/// taken, worked or handed in at the other place, opened by a hand-in there, out of level at the first
/// stop, or a training a level later. One stop could do both (train, Regthar, back to train, Regthar).
pub fn dup_trips(goals: &[WalkGoal], facts: &Facts) -> Vec<Violation> {
	dup_trips_at(goals, facts).into_iter().map(|f| f.v).collect()
}

/// [`dup_trips`] with where: the return stop's goals, done at the first stop (after its last goal,
/// before the trip's first).
pub fn dup_trips_at(goals: &[WalkGoal], facts: &Facts) -> Vec<FlowAt> {
	let st = stops(goals);
	let mut out = Vec::new();
	for w in st.windows(3) {
		let ((a, ga), (b, gb), (a2, g2)) = (&w[0], &w[1], &w[2]);
		if dist(*a, *a2) > SAME_PLACE_YD || dist(*a, *b) <= TRIP_YD {
			continue;
		}
		let (a_end, b_first, b_last) = (*ga.last().unwrap(), gb[0], *gb.last().unwrap());
		let lvl_a = goals[a_end].lvl_after;
		let between = &goals[a_end + 1..g2[0]];
		let in_b = |q: i64| gb.iter().any(|&i| goals[i].q == Some(q));
		let mut work = 0;
		let needs_trip = g2.iter().any(|&i| {
			let g = &goals[i];
			if g.t == "train" {
				work += 1;
				return g.lvl.floor() > lvl_a.floor();
			}
			let Some(q) = g.q else { return false };
			if g.optional {
				return false;
			}
			work += 1;
			let f = facts.quests.get(&q);
			let opened = f.is_some_and(|f| !f.pre.is_empty() && between.iter().any(|x| x.t == "turnin" && x.q.is_some_and(|p| f.pre.contains(&p))));
			let level = f.and_then(|f| f.min_level).is_some_and(|m| m > lvl_a) || (g.t == "accept" && f.and_then(|f| f.level).is_some_and(|l| l - ON_LEVEL_GAP > lvl_a));
			// An item got on the trip (bought or collected there) may be what is handed in or used here
			// (a `buy ... npc N` line names no item to the walk: the Arcane Quickener for the cauldrons).
			let item = between.iter().any(|x| x.t == "buy" || (x.t == "collect" && x.item.is_some()));
			in_b(q) || opened || level || item
		});
		if work == 0 || needs_trip {
			continue;
		}
		let g = &goals[g2[0]];
		out.push(FlowAt {
			v: Violation::at(
				g,
				"dup-trip",
				Level::Blocker,
				format!(
					"back at the place left at {} after a trip to {}-{}: nothing done here needed that trip; one stop could do both",
					line_of(&goals[a_end]),
					line_of(&goals[b_first]),
					goals[b_last].line.unwrap_or(0)
				),
			),
			lines: g2.clone(),
			after: a_end,
			before: b_first,
		});
	}
	out
}

/// Whether quest `q` can be taken at walk index `i`: on level (its minimum, and its level less
/// [`ON_LEVEL_GAP`]), a prerequisite handed in before (any of them), its parent in the log, not taken yet.
fn open_at(goals: &[WalkGoal], i: usize, q: i64, facts: &Facts) -> bool {
	let Some(f) = facts.quests.get(&q) else { return false };
	let l = goals[i].lvl;
	if !f.start_giver || f.min_level.is_none_or(|m| m > l) || f.level.is_some_and(|ql| ql - ON_LEVEL_GAP > l) {
		return false;
	}
	let pre_ok = f.pre.is_empty() || goals[..i].iter().any(|g| g.t == "turnin" && g.q.is_some_and(|p| f.pre.contains(&p)));
	let parent_ok = f.parent.is_none_or(|p| in_log(&goals[..i], p));
	pre_ok && parent_ok && !goals[..=i].iter().any(|g| g.t == "accept" && g.q == Some(q))
}

/// Quest `p` is in the log after `goals`: accepted and not handed in since.
fn in_log(goals: &[WalkGoal], p: i64) -> bool {
	let last = |t: &str| goals.iter().rposition(|g| g.t == t && g.q == Some(p));
	last("accept").is_some_and(|a| last("turnin").is_none_or(|h| h < a))
}

/// Rule `not-ready` (blocker): an accept the game refuses there, on this class's walk: a prerequisite
/// the walk hands in later is not handed in yet (The Binding 1471 before Creature of the Void 1473),
/// a parent quest the walk takes is not in the log (taken later, or handed in already), or the walk's level is more than
/// [`READY_LVL_SLACK`] under the quest's minimum (5680 at 16, level 20 needed). A breadcrumb is no
/// prerequisite (8276 for 8280), nor is a parent one to hand in (349 inside 348) ([`quest_pre`]).
pub fn not_ready(goals: &[WalkGoal], facts: &Facts) -> Vec<Violation> {
	const READY_LVL_SLACK: f64 = 1.0;
	let mut out = Vec::new();
	for (i, g) in goals.iter().enumerate() {
		let Some(q) = g.q.filter(|_| g.t == "accept" && !g.optional) else { continue };
		let Some(f) = facts.quests.get(&q) else { continue };
		let handed = |r: std::ops::Range<usize>| goals[r].iter().any(|x| x.t == "turnin" && x.q.is_some_and(|p| f.pre.contains(&p)));
		// The parent must be in the log: taken before, not handed in yet (only on a walk that takes it).
		let parent_out = f.parent.filter(|&p| !in_log(&goals[..i], p) && goals.iter().any(|x| x.t == "accept" && x.q == Some(p)));
		let why = if !f.pre.is_empty() && !handed(0..i) && handed(i + 1..goals.len()) {
			Some("its prerequisite is handed in later".to_string())
		} else if let Some(p) = parent_out {
			let later = goals[i + 1..].iter().any(|x| x.t == "accept" && x.q == Some(p));
			Some(format!("{} must be in the log{}", facts.title(p), if later { ", and is taken later" } else { ", and is handed in already" }))
		} else {
			f.min_level.filter(|&m| g.lvl + READY_LVL_SLACK < m).map(|m| format!("level {:.1}, under its minimum {m}", g.lvl))
		};
		if let Some(why) = why {
			out.push(Violation::at(g, "not-ready", Level::Blocker, format!("{} accepted before it can be: {why}", facts.title(q))));
		}
	}
	out
}

/// Rule `next-to` (warn): a quest taken at its giver on a later visit, though the walk stood within
/// [`NEXT_TO_YD`] of that giver before, then went more than [`TRIP_YD`] away and came back, while the
/// quest was open (on level, its prerequisite handed in): Ratchet's two quests taken, five others
/// standing by. Only where the walk is counts as leaving: a travel line, or a required quest goal (not an
/// `along` or optional goal, nor a service line such as `vendor nearest`, whose point may be any vendor's).
/// Also, without a trip, an earlier step whose goal stood within [`CLOSE_YD`] of the giver while it
/// was open: Venya's imp quest beside Sarvis, taken three steps later (class lines too).
pub fn next_to(goals: &[WalkGoal], facts: &Facts) -> Vec<Violation> {
	const CLOSE_YD: f64 = 40.0;
	let where_walk_is = |g: &WalkGoal| is_move(g) || (g.q.is_some() && !g.optional && g.along.is_none());
	let mut out = Vec::new();
	for (j, g) in goals.iter().enumerate() {
		let (Some(q), Some(at)) = (g.q.filter(|_| g.t == "accept" && !g.optional), g.w) else { continue };
		// The last time the walk stood by the giver before leaving it for a trip; else the first
		// earlier step close by where it was open.
		let mut left = false;
		let mut seen: Option<usize> = None;
		for i in (0..j).rev() {
			let Some(p) = goals[i].w else { continue };
			let d = dist(p, at);
			if d > TRIP_YD {
				left |= where_walk_is(&goals[i]);
			} else if left && d <= NEXT_TO_YD && !is_move(&goals[i]) {
				seen = Some(i);
				break;
			}
		}
		let seen = seen.filter(|&i| open_at(goals, i, q, facts)).or_else(|| {
			(0..j).find(|&i| (goals[i].file.as_str(), goals[i].step) != (g.file.as_str(), g.step) && !is_move(&goals[i]) && goals[i].w.is_some_and(|p| dist(p, at) <= CLOSE_YD) && open_at(goals, i, q, facts))
		});
		let Some(i) = seen else { continue };
		out.push(Violation::at(
			g,
			"next-to",
			Level::Warn,
			format!("{} taken here at level {:.1}, but the walk stood by its giver at {} (level {:.1}) while it was open", facts.title(q), g.lvl, line_of(&goals[i]), goals[i].lvl),
		));
	}
	out
}

/// Rule `split` (warn): an objective worked after a hand-in trip away, though its quest was in the log
/// when the walk worked another objective within [`SAME_AREA_YD`] of it before the trip: the two share
/// a spawn area and one visit could do both ("kill these as you meet them").
pub fn splits(goals: &[WalkGoal], facts: &Facts) -> Vec<Violation> {
	const WORK: [&str; 5] = ["kill", "collect", "interact", "use", "complete"];
	let mut out = Vec::new();
	let mut seen: FxHashSet<(i64, Option<i64>)> = FxHashSet::default();
	for (k, g) in goals.iter().enumerate() {
		let (Some(q), Some(at)) = (g.q, g.w) else { continue };
		if !WORK.contains(&g.t.as_str()) || g.optional || !seen.insert((q, g.oi)) {
			continue;
		}
		let Some(acc) = goals[..k].iter().position(|x| x.t == "accept" && x.q == Some(q)) else { continue };
		// The first other objective worked near this one while the quest was in the log, before a hand-in
		// trip away from here.
		let Some(i) = (acc + 1..k).find(|&i| {
			let x = &goals[i];
			WORK.contains(&x.t.as_str()) && x.q.is_some_and(|p| p != q || x.oi != g.oi) && x.w.is_some_and(|p| dist(p, at) <= SAME_AREA_YD)
		}) else {
			continue;
		};
		let away = (i + 1..k).find(|&j| goals[j].t == "turnin" && goals[j].w.is_some_and(|p| dist(p, at) > TRIP_YD));
		let Some(h) = away else { continue };
		// Done there already (another goal of the same objective before the trip): not split.
		if goals[acc + 1..h].iter().any(|x| x.q == Some(q) && x.oi == g.oi && WORK.contains(&x.t.as_str())) {
			continue;
		}
		out.push(Violation::at(
			g,
			"split",
			Level::Warn,
			format!(
				"{} worked here after a hand-in trip ({}), though it was in the log at {}, {:.0} yd from here: one visit could do both",
				facts.title(q),
				line_of(&goals[h]),
				line_of(&goals[i]),
				dist(goals[i].w.unwrap(), at)
			),
		));
	}
	out
}

/// Rule `feel` (info): each metric of the written walk worse than v1's beyond [`feel_tolerance`]. A
/// count is no verdict (a return or a zone change that saves time is fine): the specific waste is
/// `bounce`, `dup-trip`, `next-to` and `split`.
pub fn feel(v1: &Feel, written: &Feel, file: &str) -> Vec<Violation> {
	v1.gated()
		.iter()
		.zip(written.gated())
		.filter(|((_, a), (_, b))| *b as f64 > *a as f64 + feel_tolerance(*a))
		.map(|((name, a), (_, b))| Violation::new(file, 0, "feel", Level::Info, format!("{name}: {a} in v1's guides, {b} written (+{}, tolerance {:.0})", b - a, feel_tolerance(*a).floor())))
		.collect()
}

/// One avoidable return, as the added-returns rule matches them across walks.
#[derive(Clone, Debug, PartialEq)]
pub struct Ret {
	pub area: String,
	pub zone: String,
	pub wasted: bool,
	/// Where the return's first avoidable goal is (`file:line`, or `goal N` on a stream).
	pub at: String,
	/// Its avoidable goals' quests, sorted.
	pub quests: Vec<i64>,
	/// The quests of the visit before (titles' `[id]`s), for naming the edits.
	pub before: Vec<i64>,
	/// Each avoidable quest as "Title (id)", in `quests` order.
	pub names: Vec<String>,
	/// A chain return ([`is_chain_return`]): seen, not counted.
	pub chain: bool,
	/// The walk indices of its avoidable goals, and of the last visit's departure (the written check
	/// fed back to the routes stage moves the goals to the visit before it).
	pub goals: Vec<usize>,
	pub depart: usize,
}

impl Ret {
	/// From a returns example of the walk `goals`.
	pub fn from_example(e: &crate::returns::Example, goals: &[WalkGoal], pre: ChainPre) -> Ret {
		let mut quests: Vec<i64> = e.v2.goals.iter().filter(|g| g.avoidable).filter_map(|g| g.q).collect();
		quests.sort_unstable();
		quests.dedup();
		let names = quests
			.iter()
			.map(|q| e.v2.goals.iter().find(|g| g.q == Some(*q)).and_then(|g| g.title.clone()).filter(|t| !t.is_empty()).map_or_else(|| q.to_string(), |t| format!("{t} ({q})")))
			.collect();
		let at = e.v2.goals.iter().find(|g| g.avoidable).map_or_else(|| e.v2.from.clone(), |g| g.ref_.clone());
		let before = e.v1.quests.iter().filter_map(|t| t.rsplit_once('[').and_then(|(_, r)| r.trim_end_matches(']').parse().ok())).collect();
		let back: Vec<(usize, i64)> = e.v2.goals.iter().filter_map(|g| g.q.map(|q| (g.i, q))).collect();
		let chain = is_chain_return(goals, e.depart, &back, pre);
		let avoidable = e.v2.goals.iter().filter(|g| g.avoidable).map(|g| g.i).collect();
		Ret { area: e.area.clone(), zone: e.zone.clone(), wasted: e.wasted, at, quests, before, names, chain, goals: avoidable, depart: e.depart }
	}
}

/// The items of `written` beyond `base`'s count of the same group (`group`): those with no equal item
/// (`same`) in `base` first, then the latest ones (the earlier ones stand for `base`'s): the ones a
/// walk added, in walk order.
fn added<'a, T, K: Eq + std::hash::Hash>(written: &'a [T], base: &[T], group: impl Fn(&T) -> K, same: impl Fn(&T, &T) -> bool) -> Vec<&'a T> {
	let mut counts: FxHashMap<K, (usize, usize)> = FxHashMap::default();
	for x in base {
		counts.entry(group(x)).or_default().0 += 1;
	}
	for x in written {
		counts.entry(group(x)).or_default().1 += 1;
	}
	let mut out: Vec<(usize, &T)> = Vec::new();
	let mut taken: FxHashMap<K, usize> = FxHashMap::default();
	for pass in [true, false] {
		// Novel items in walk order; the rest from the end.
		let idx: Vec<usize> = if pass { (0..written.len()).collect() } else { (0..written.len()).rev().collect() };
		for (i, x) in idx.into_iter().map(|i| (i, &written[i])) {
			let (b, w) = counts[&group(x)];
			let t = taken.entry(group(x)).or_default();
			let novel = !base.iter().any(|y| same(x, y));
			if *t < w.saturating_sub(b) && novel == pass && !out.iter().any(|(j, _)| *j == i) {
				*t += 1;
				out.push((i, x));
			}
		}
	}
	out.sort_by_key(|(i, _)| *i);
	out.into_iter().map(|(_, x)| x).collect()
}

/// `file:line` of a goal reference.
fn split_ref(r: &str) -> (String, u32) {
	match r.rsplit_once(':').and_then(|(f, l)| Some((f, l.parse().ok()?))) {
		Some((f, l)) => (f.to_string(), l),
		None => (r.to_string(), 0),
	}
}

/// The avoidable returns of `written` beyond `v1`'s (per area; [`added_returns`]).
pub fn added_rets<'a>(v1: &[Ret], written: &'a [Ret]) -> Vec<&'a Ret> {
	added(written, v1, |r: &Ret| (r.area.clone(), r.zone.clone()), |a: &Ret, b: &Ret| a.area == b.area && a.quests == b.quests)
}

/// Rule `feel-return` (warn): each avoidable return of the written walk v1's walk does not make (per
/// area, beyond v1's count there), said to be in the model order when the order adds one to that area
/// over v1's chain (with the kept route edits on its quests, `edits`: the route file's edit list), else
/// the writer's. -> (lines, (in the order, the writer's)).
pub fn added_returns(v1: &[Ret], written: &[Ret], order: Option<(&[Ret], &[Ret])>, edits: &Value) -> (Vec<Violation>, (usize, usize)) {
	let mut by_order: Vec<&Ret> = order.map(|(o, b)| added_rets(b, o)).unwrap_or_default();
	let (mut n_order, mut n_writer) = (0, 0);
	let mut out = Vec::new();
	for r in added_rets(v1, written) {
		let (file, line) = split_ref(&r.at);
		let names = if r.names.is_empty() { r.quests.iter().map(|q| q.to_string()).collect::<Vec<_>>().join(", ") } else { r.names.join(", ") };
		let what = format!("an avoidable {} to {} ({}) for {names}, not in v1's guides", if r.wasted { "trip" } else { "return" }, r.area, r.zone);
		let src = match by_order.iter().position(|o| o.area == r.area) {
			Some(k) => {
				by_order.remove(k);
				n_order += 1;
				let qs: FxHashSet<i64> = r.quests.iter().chain(&r.before).copied().collect();
				let on = |e: &Value| e["q"].as_i64().is_some_and(|q| qs.contains(&q)) || e["steps"].as_array().is_some_and(|s| s.iter().any(|x| x["q"].as_i64().is_some_and(|q| qs.contains(&q))));
				let ns: Vec<String> = edits["list"].as_array().into_iter().flatten().filter(|e| e["kept"] == true && on(e)).map(|e| format!("#{}", e["n"])).collect();
				if ns.is_empty() {
					"in the model order".to_string()
				} else {
					format!("in the model order (route edits {})", ns.join(", "))
				}
			}
			None => {
				n_writer += 1;
				"the writer's (the model order does not add it)".to_string()
			}
		};
		out.push(Violation::new(file, line, "feel-return", Level::Info, format!("{what}: {src}")));
	}
	(out, (n_order, n_writer))
}

/// A walk's zone changes between located quest goals (the report's `zoneChanges`): (from map, to map,
/// the goal arriving).
pub fn zone_changes(goals: &[WalkGoal]) -> Vec<(u32, u32, &WalkGoal)> {
	let mut out = Vec::new();
	let mut last: Option<u32> = None;
	for g in goals {
		let (Some(w), Some(_)) = (g.w, g.q) else { continue };
		if let Some(m) = last.filter(|m| *m != w.map) {
			out.push((m, w.map, g));
		}
		last = Some(w.map);
	}
	out
}

/// Rule `feel-zone` (warn): each zone change (from, to) the written walk makes more often than v1's,
/// said to be in the model order when the order makes it more often than v1's chain, else the
/// writer's. `zone`: a map's name. -> (lines, (in the order, the writer's)).
pub fn added_zone_changes(v1: &[WalkGoal], written: &[WalkGoal], order: Option<(&[WalkGoal], &[WalkGoal])>, zone: &dyn Fn(u32) -> String, pre: ChainPre) -> (Vec<Violation>, (usize, usize)) {
	let pair = |x: &(u32, u32, &WalkGoal)| (x.0, x.1);
	let same = |a: &(u32, u32, &WalkGoal), b: &(u32, u32, &WalkGoal)| pair(a) == pair(b);
	// Chain zone changes (is_chain_zone) are left out of every walk's list.
	fn unchained<'a>(g: &'a [WalkGoal], pre: ChainPre) -> Vec<(u32, u32, &'a WalkGoal)> {
		zone_changes(g).into_iter().filter(|z| !is_chain_zone(g, z.2.i, pre)).collect()
	}
	let (zv, zw) = (unchained(v1, pre), unchained(written, pre));
	let mut by_order: Vec<(u32, u32)> = match order {
		Some((o, b)) => {
			let (zo, zb) = (unchained(o, pre), unchained(b, pre));
			added(&zo, &zb, pair, same).into_iter().map(pair).collect()
		}
		None => Vec::new(),
	};
	let (mut n_order, mut n_writer) = (0, 0);
	let mut out = Vec::new();
	for z in added(&zw, &zv, pair, same) {
		let src = match by_order.iter().position(|p| *p == pair(z)) {
			Some(k) => {
				by_order.remove(k);
				n_order += 1;
				"in the model order"
			}
			None => {
				n_writer += 1;
				"the writer's (the model order does not add it)"
			}
		};
		let (v, w) = (zv.iter().filter(|x| pair(x) == pair(z)).count(), zw.iter().filter(|x| pair(x) == pair(z)).count());
		out.push(Violation::at(z.2, "feel-zone", Level::Info, format!("zone change {} to {}: {v} in v1's guides, {w} written: {src}", zone(z.0), zone(z.1))));
	}
	(out, (n_order, n_writer))
}

/// Merges one rule set's violations over the class walks: one per (rule, file, line), the classes that
/// met it (none listed when every class did).
pub fn merge_classes(per_class: Vec<(String, Vec<Violation>)>, all: &[String]) -> Vec<Violation> {
	let mut order: Vec<(String, String, u32, String)> = Vec::new();
	let mut by: FxHashMap<(String, String, u32, String), (Violation, Vec<String>)> = FxHashMap::default();
	for (cls, list) in per_class {
		for v in list {
			// One line per place, but every broken order of a place (and every place-less line) its own.
			let k = (v.rule.clone(), v.file.clone(), v.line, if v.line == 0 || v.rule == "deliberate" { v.message.clone() } else { String::new() });
			match by.get_mut(&k) {
				Some((_, c)) => {
					if !c.contains(&cls) {
						c.push(cls.clone());
					}
				}
				None => {
					order.push(k.clone());
					by.insert(k, (v, vec![cls.clone()]));
				}
			}
		}
	}
	order
		.into_iter()
		.filter_map(|k| by.remove(&k))
		.map(|(mut v, cls)| {
			if !all.iter().all(|c| cls.contains(c)) {
				v.classes = all.iter().filter(|c| cls.contains(c)).map(|c| class_label(c)).collect();
			}
			v
		})
		.collect()
}

/// Per start: blockers and warnings, by rule.
#[derive(Clone, Debug, Default, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct StartSummary {
	pub start: String,
	pub blockers: usize,
	pub warns: usize,
	pub by_rule: std::collections::BTreeMap<String, usize>,
	pub ms: u64,
	/// The player view (v1's guides against the written ones).
	#[serde(skip_serializing_if = "Option::is_none")]
	pub feel: Option<FeelRow>,
}

#[derive(Clone, Debug, Default, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Output {
	pub starts: Vec<StartSummary>,
	pub violations: Vec<Violation>,
}

impl Output {
	pub fn blockers(&self) -> usize {
		self.violations.iter().filter(|v| v.level == Level::Blocker).count()
	}

	pub fn warns(&self) -> usize {
		self.violations.iter().filter(|v| v.level == Level::Warn).count()
	}

	/// One line per violation.
	pub fn text(&self) -> String {
		self.violations.iter().map(|v| v.text() + "\n").collect()
	}

	/// The summary line report.md carries.
	pub fn summary(&self) -> String {
		let per: Vec<String> = self.starts.iter().map(|s| format!("{} {}", s.start, s.blockers)).collect();
		format!("Route check: {} blockers, {} warnings (check.md; blockers per start: {}).", self.blockers(), self.warns(), per.join(", "))
	}

	/// check.md.
	pub fn markdown(&self) -> String {
		use std::fmt::Write;
		let mut m = String::new();
		let _ = writeln!(m, "# Route check\n\n{} blockers, {} warnings (`forge judge check`, docs/forge/judge.md).\n", self.blockers(), self.warns());
		if self.starts.iter().any(|s| s.feel.is_some()) {
			let _ = writeln!(m, "## Player view (v1's guides -> written, to 60)\n");
			let _ = writeln!(
				m,
				"| start | hours | grind min: all (on level steps + unwritten) | returns (wasted) | zone changes | passed by (never) | area visits | chain returns (zone changes), not counted | added returns: order / writer | added zone changes: order / writer | merge | along | arrow-order |\n|---|---|---|---|---|---|---|---|---|---|---|---|---|"
			);
			for s in &self.starts {
				let Some(f) = &s.feel else { continue };
				let (a, b) = (&f.v1, &f.written);
				let rule = |r: &str| s.by_rule.get(r).copied().unwrap_or(0);
				let _ = writeln!(
					m,
					"| {} | {:.1} -> {:.1} | {} ({} + {}) -> {} ({} + {}) | {} ({}) -> {} ({}) | {} -> {} | {} ({}) -> {} ({}) | {} -> {} | {} ({}) -> {} ({}) | {} / {} | {} / {} | {} | {} | {} |",
					s.start,
					a.hours,
					b.hours,
					a.grind_min,
					a.grind_shown_min,
					a.grind_unwritten_min,
					b.grind_min,
					b.grind_shown_min,
					b.grind_unwritten_min,
					a.returns,
					a.wasted_trips,
					b.returns,
					b.wasted_trips,
					a.zone_changes,
					b.zone_changes,
					a.passed_by,
					a.pb_never,
					b.passed_by,
					b.pb_never,
					a.area_visits,
					b.area_visits,
					f.chain_returns.0,
					f.chain_zone_changes.0,
					f.chain_returns.1,
					f.chain_zone_changes.1,
					f.added_returns.0,
					f.added_returns.1,
					f.added_zone_changes.0,
					f.added_zone_changes.1,
					rule("merge"),
					rule("along"),
					rule("arrow-order")
				);
			}
			let _ = writeln!(
				m,
				"\nThe model order's avoidable returns, against v1's chain in the same model: {}.\n",
				self.starts.iter().filter_map(|s| s.feel.as_ref().map(|f| format!("{} {} -> {}", s.start, f.v1_order_returns, f.order_returns))).collect::<Vec<_>>().join(", ")
			);
		}
		let _ = writeln!(m, "| start | blockers | warnings | by rule | ms |\n|---|---|---|---|---|");
		for s in &self.starts {
			let rules: Vec<String> = s.by_rule.iter().map(|(r, n)| format!("{r} {n}")).collect();
			let _ = writeln!(m, "| {} | {} | {} | {} | {} |", s.start, s.blockers, s.warns, rules.join(", "), s.ms);
		}
		for s in &self.starts {
			let list: Vec<&Violation> = self.violations.iter().filter(|v| v.start == s.start).collect();
			if list.is_empty() {
				continue;
			}
			let _ = writeln!(m, "\n## {}\n", s.start);
			for level in [Level::Blocker, Level::Warn, Level::Info] {
				for v in list.iter().filter(|v| v.level == level) {
					let cls = if v.classes.is_empty() { String::new() } else { format!(" [{}]", v.classes.join(", ")) };
					let _ = writeln!(m, "- `{}:{}` {} {}: {}{cls}", v.file, v.line, v.rule, v.level.as_str(), v.message);
				}
			}
		}
		m
	}

	/// Sorts violations by start (in `starts` order), level, file and line, and fills the summaries.
	pub fn finish(&mut self) {
		let pos: FxHashMap<String, usize> = self.starts.iter().enumerate().map(|(i, s)| (s.start.clone(), i)).collect();
		self.violations.sort_by(|a, b| {
			(pos.get(&a.start).copied().unwrap_or(usize::MAX), a.level, &a.file, a.line, &a.rule).cmp(&(pos.get(&b.start).copied().unwrap_or(usize::MAX), b.level, &b.file, b.line, &b.rule))
		});
		for s in &mut self.starts {
			s.blockers = 0;
			s.warns = 0;
			s.by_rule.clear();
		}
		for v in &self.violations {
			if let Some(&i) = pos.get(&v.start) {
				let s = &mut self.starts[i];
				match v.level {
					Level::Blocker => s.blockers += 1,
					Level::Warn => s.warns += 1,
					Level::Info => {}
				}
				*s.by_rule.entry(v.rule.clone()).or_default() += 1;
			}
		}
	}
}

#[cfg(feature = "native")]
pub use native::{flow_findings, run, Inputs, Walks};

#[cfg(feature = "native")]
mod native {
	use super::*;
	use std::path::{Path, PathBuf};

	/// What the check reads. [`Inputs::beside`] fills it from a build's guides folder.
	#[derive(Clone, Debug)]
	pub struct Inputs {
		/// The written guides: `<guides>/<Start>/forever`.
		pub guides: PathBuf,
		/// `<Start>.json` and `<Start>.judge-improved.json`.
		pub routes: PathBuf,
		/// The checkout the guides were built with (`data/forever`, the knowledge base).
		pub root: PathBuf,
		/// `world-<faction>.json` and `params.json`.
		pub sim: PathBuf,
		/// v1's guides (default `<root>/guides`).
		pub v1: PathBuf,
		/// The build's fixes ledger (`<out>/fixes.json`), when there is one.
		pub ledger: Option<PathBuf>,
		/// The route fixes whose `deliberate` orders the walk keeps.
		pub route_fixes: Option<PathBuf>,
		/// The starts (empty: every `<guides>/<Start>` with a `forever/` and a route).
		pub starts: Vec<String>,
	}

	impl Inputs {
		/// A build's layout: `../routes`, `../.forge/root`, `../.forge/sim` and `../fixes.json` beside
		/// the guides folder.
		pub fn beside(guides: &Path) -> Inputs {
			let out = guides.parent().map_or_else(|| PathBuf::from(".."), Path::to_path_buf);
			let root = out.join(".forge/root");
			Inputs {
				guides: guides.to_path_buf(),
				routes: out.join("routes"),
				sim: out.join(".forge/sim"),
				v1: root.join("guides"),
				root,
				ledger: Some(out.join("fixes.json")).filter(|f| f.is_file()),
				route_fixes: None,
				starts: Vec::new(),
			}
		}

		fn starts(&self) -> Result<Vec<String>, String> {
			if !self.starts.is_empty() {
				return Ok(self.starts.clone());
			}
			let mut v: Vec<String> = std::fs::read_dir(&self.guides)
				.map_err(|e| format!("{}: {e}", self.guides.display()))?
				.filter_map(|e| e.ok())
				.filter(|e| e.path().join("forever").is_dir())
				.map(|e| e.file_name().to_string_lossy().into_owned())
				.filter(|s| self.routes.join(format!("{s}.json")).is_file())
				.collect();
			// The build's order: Horde starts, then Alliance (routes/starts.json), else by name.
			let table: Value = std::fs::read(self.routes.join("starts.json")).ok().and_then(|b| serde_json::from_slice(&b).ok()).unwrap_or_default();
			let order: Vec<String> = table.as_array().into_iter().flatten().filter_map(|r| r["start"].as_str().map(str::to_string)).collect();
			v.sort_by_key(|s| (order.iter().position(|o| o == s).unwrap_or(usize::MAX), s.clone()));
			Ok(v)
		}
	}

	fn read_json(f: &Path) -> Result<Value, String> {
		serde_json::from_slice(&std::fs::read(f).map_err(|e| format!("{}: {e}", f.display()))?).map_err(|e| format!("{}: {e}", f.display()))
	}

	/// Each step's `zone` (uiMapID) by (guide id, step line), read from the guide text: the compiled goals
	/// carry a map only with a point, so a pointless goal (`train class`) is placed by its step's zone.
	fn step_zones(tree: &Path, data: &forge_guide::data::Data) -> FxHashMap<(String, u32), u32> {
		let mut out = FxHashMap::default();
		for rel in forge_guide::project::find_guide_files(tree, false) {
			let Ok(text) = std::fs::read_to_string(tree.join(&rel)) else { continue };
			let mut id: Option<String> = None;
			let mut step: Option<u32> = None;
			for (n, line) in text.lines().enumerate() {
				if id.is_none() {
					id = line.strip_prefix("guide ").map(|r| r.trim().to_string());
				}
				if line.starts_with("step") {
					step = Some(n as u32 + 1);
				} else if let (Some(s), Some(name), Some(id)) = (step, line.trim_start().strip_prefix("zone ").filter(|_| line.starts_with([' ', '\t'])), &id) {
					if let Some(m) = data.zone_named(name.trim()).get("zone").get("id").as_num() {
						out.insert((id.clone(), s), m as u32);
					}
				}
			}
		}
		out
	}

	/// The `loop` steps of a guides tree, by (guide id, step line), read from the guide text (the compiled
	/// step does not keep the keyword).
	fn loop_steps(tree: &Path) -> FxHashSet<(String, u32)> {
		let mut out = FxHashSet::default();
		for rel in forge_guide::project::find_guide_files(tree, false) {
			let Ok(text) = std::fs::read_to_string(tree.join(&rel)) else { continue };
			let mut id: Option<String> = None;
			let mut step: Option<u32> = None;
			for (n, line) in text.lines().enumerate() {
				if id.is_none() {
					id = line.strip_prefix("guide ").map(|r| r.trim().to_string());
				}
				if line.starts_with("step") {
					step = Some(n as u32 + 1);
				} else if let (Some(s), Some(id), true) = (step, &id, line.starts_with([' ', '\t'])) {
					let t = line.trim();
					if t == "loop" || t.starts_with("loop ") || t.starts_with("loop\t") {
						out.insert((id.clone(), s));
					}
				}
			}
		}
		out
	}

	/// Every start's check, each on its own thread (in the caller's rayon pool).
	pub fn run(inp: &Inputs) -> Result<Output, String> {
		use rayon::prelude::*;
		let starts = inp.starts()?;
		let fixes: Value = match &inp.route_fixes {
			Some(f) => read_json(f)?,
			None => Value::Null,
		};
		let ledger: Value = match &inp.ledger {
			Some(f) => read_json(f)?,
			None => Value::Null,
		};
		// One walk store per faction, shared by its starts.
		let walks: Walks = std::sync::Mutex::new(FxHashMap::default());
		let done: Vec<(StartSummary, Vec<Violation>)> = starts.par_iter().map(|s| check_start(inp, s, &fixes["deliberate"], &fixes["overrides"], &ledger, &walks)).collect::<Result<_, String>>()?;
		let mut o = Output::default();
		for (s, v) in done {
			o.starts.push(s);
			o.violations.extend(v);
		}
		let build = fixes_rows(&ledger, "all");
		if !build.is_empty() {
			o.starts.push(StartSummary { start: "all".into(), ..Default::default() });
			o.violations.extend(build.into_iter().map(|mut v| {
				v.start = "all".into();
				v
			}));
		}
		o.finish();
		Ok(o)
	}

	/// One walk store per faction, loaded once (`levels::walks_for`).
	pub type Walks = std::sync::Mutex<FxHashMap<String, Option<std::sync::Arc<forge_sim::WalkTable>>>>;

	/// The flow rules (forge_sim::flow::FLOW_RULES: [`walked_past`], [`dup_trips`], [`bounces`], and
	/// `feel-return`: [`added_returns`] against `v1`'s guides) on a start's written guides `tree`
	/// (`<tree>/forever`), as the routes stage feeds them back: one finding per (rule, file, line) over the
	/// start's classes, as the check counts them, with its quest lines and the quest lines around the
	/// stop the walk passed (a return: its avoidable goals and the visit before), as the route's steps.
	/// `route`: the start's route (faction, start race); `root`: data/forever; `sim`: world, params, walks.
	pub fn flow_findings(tree: &Path, v1: &Path, route: &Value, root: &Path, sim: &Path, walks: &Walks, start: &str) -> Result<Vec<forge_sim::flow::Finding>, String> {
		use crate::levels::SimLevels;
		use crate::walk::{walk_chain, Chain, Ctx, JudgeEnv, JudgeOpts};
		use forge_sim::run::{K_ACCEPT, K_TASK, K_TURNIN};
		let faction = route["faction"].as_str().ok_or("route: no faction")?.to_string();
		let race = route["start"].as_str().ok_or("route: no start")?.to_string();
		let fac = forge_core::Faction::parse(&faction).ok_or_else(|| format!("unknown faction {faction}"))?;
		let data_dir = root.join("data/forever");
		let data = forge_guide::data::load_data(&data_dir)?;
		let world = forge_sim::load_world(sim, fac)?;
		let params: Option<Value> = std::fs::read(sim.join("params.json")).ok().and_then(|b| serde_json::from_slice(&b).ok());
		let lv = SimLevels::route(&world, &race, params.as_ref(), crate::levels::walks_for(walks, sim, &world))?;
		let facts = Facts::new(&data, Some(&world), &Value::Null);
		let guides = forge_guide::project::compile_project(tree, &forge_guide::js::V::Undef, &data, forge_guide::diag::Diagnostics::new(), false, None).guides;
		let zones = step_zones(tree, &data);
		let frames = forge_core::MapFrames::from_json(&std::fs::read(data_dir.join("map-frames.json")).map_err(|e| format!("map-frames.json: {e}"))?).map_err(|e| e.to_string())?;
		let proj = forge_core::Projector::new(&frames);
		let classes = crate::honest::playable_classes(&data, &Ctx::new(&faction, &race, None)?.race, fac.name());
		// A goal as the route's step: an accept, a hand-in, work.
		let line = |g: &WalkGoal| -> Option<forge_sim::flow::Line> {
			let q = u32::try_from(g.q?).ok().filter(|&q| q > 0 && g.along.is_none())?;
			match g.t.as_str() {
				"accept" => Some((K_ACCEPT, q)),
				"turnin" => Some((K_TURNIN, q)),
				"kill" | "collect" | "interact" | "use" | "complete" => Some((K_TASK, q)),
				_ => None,
			}
		};
		// The nearest quest line from goal `i` back (or on), not across a flight, hearth or death.
		let near = |goals: &[WalkGoal], i: usize, back: bool| -> Option<forge_sim::flow::Line> {
			let mut k = i;
			loop {
				let g = goals.get(k)?;
				if let Some(l) = line(g) {
					return Some(l);
				}
				if matches!(g.t.as_str(), "fly" | "hearth" | "die") || (back && k == 0) {
					return None;
				}
				k = if back { k - 1 } else { k + 1 };
			}
		};
		let mut seen: FxHashSet<(String, String, u32)> = FxHashSet::default();
		let mut out = Vec::new();
		for cls in &classes {
			let ctx = Ctx::new(&faction, &race, Some(cls))?;
			let mut walk = walk_chain(&guides, &|_| String::new(), Chain::Routes, &ctx, &proj, &lv, 61.0)?;
			for g in walk.goals.iter_mut().filter(|g| g.w.is_none()) {
				if let Some(&m) = g.step.and_then(|s| zones.get(&(g.guide.clone(), s))) {
					g.map = Some(m);
				}
			}
			let g = &walk.goals;
			for f in walked_past_at(g).into_iter().chain(dup_trips_at(g, &facts)).chain(bounces_at(g)) {
				if !seen.insert((f.v.rule.clone(), f.v.file.clone(), f.v.line)) {
					continue;
				}
				let lines = f.lines.iter().filter(|&&i| !g[i].optional).filter_map(|&i| line(&g[i])).filter(|l| l.0 != K_TASK).collect();
				out.push(forge_sim::flow::Finding {
					start: start.to_string(),
					rule: f.v.rule.clone(),
					text: format!("{}:{} {}", f.v.file, f.v.line, f.v.rule),
					lines,
					after: near(g, f.after, true),
					before: near(g, f.before, false),
				});
			}
		}
		// Avoidable returns v1 does not make (the any-class walk, as the player view reads it): the
		// return's goals done on the visit before, as one block.
		let mut jo = JudgeOpts::new(tree, &faction, &race, None, root);
		jo.data_dir = data_dir.clone();
		jo.examples = usize::MAX;
		let env = JudgeEnv::new(&jo)?;
		let ctx = Ctx::new(&faction, &race, None)?;
		let walk_of = |dir: &Path| -> Result<crate::walk::Walk, String> {
			let guides = forge_guide::project::compile_project(dir, &forge_guide::js::V::Undef, &data, forge_guide::diag::Diagnostics::new(), false, None).guides;
			walk_chain(&guides, &|_| String::new(), Chain::Routes, &ctx, &env.proj, &lv, 61.0)
		};
		let (jw, jv) = (env.judge(walk_of(tree)?, None), env.judge(walk_of(v1)?, None));
		let pre = chain_pre(&env);
		let rets = |r: &crate::returns::Returns, goals: &[WalkGoal]| r.examples.iter().map(|e| Ret::from_example(e, goals, &pre)).filter(|r| !r.chain).collect::<Vec<Ret>>();
		let (rw, rv) = (rets(&jw.returns, &jw.walk.goals), rets(&jv.returns, &jv.walk.goals));
		let g = &jw.walk.goals;
		for r in added_rets(&rv, &rw) {
			let (file, line_no) = split_ref(&r.at);
			out.push(forge_sim::flow::Finding {
				start: start.to_string(),
				rule: "feel-return".into(),
				text: format!("{file}:{line_no} feel-return ({})", r.area),
				lines: r.goals.iter().filter(|&&i| g.get(i).is_some_and(|x| !x.optional)).filter_map(|&i| line(&g[i])).collect(),
				after: near(g, r.depart, true),
				before: near(g, r.depart + 1, false),
			});
		}
		Ok(out)
	}

	/// Chain prerequisites as the check reads them: the rules' and the data's, the quest whose `next` it
	/// is, its breadcrumbs.
	fn chain_pre(env: &crate::walk::JudgeEnv) -> impl Fn(i64) -> Vec<i64> + '_ {
		let mut next_of: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
		for (id, q) in &env.d.quests {
			if let Some(n) = q.next.filter(|n| *n > 0.0) {
				next_of.entry(n as i64).or_default().push(i64::from(*id));
			}
		}
		move |q: i64| -> Vec<i64> {
			let Some(rec) = u32::try_from(q).ok().and_then(|i| env.d.quests.get(&i)) else { return Vec::new() };
			let p = env.rules.prereqs_of(rec);
			let mut v: Vec<i64> =
				p.any.iter().chain(&p.all).chain(p.parent.iter()).chain(&rec.pre).chain(rec.pre_any.iter().flatten()).chain(rec.pre_all.iter().flatten()).chain(&rec.breadcrumbs).copied().collect();
			v.extend(next_of.get(&q).into_iter().flatten());
			v.sort_unstable();
			v.dedup();
			v
		}
	}

	fn check_start(inp: &Inputs, start: &str, deliberate_doc: &Value, overrides_doc: &Value, ledger: &Value, walks: &Walks) -> Result<(StartSummary, Vec<Violation>), String> {
		use crate::honest::{self, HonestOpts, PackRun};
		use crate::levels::SimLevels;
		use crate::walk::{walk_chain, Chain, Ctx};
		let t0 = std::time::Instant::now();
		let route_file = inp.routes.join(format!("{start}.json"));
		let route = read_json(&route_file)?;
		let faction = route["faction"].as_str().ok_or_else(|| format!("{}: no faction", route_file.display()))?.to_string();
		let race = route["start"].as_str().ok_or_else(|| format!("{}: no start", route_file.display()))?.to_string();
		let fac = forge_core::Faction::parse(&faction).ok_or_else(|| format!("unknown faction {faction}"))?;
		let tree = inp.guides.join(start);
		let data_dir = inp.root.join("data/forever");
		let kb_file = inp.root.join("data/local/kb/forever-kb.sqlite");
		let run = PackRun { filter: None, faction: Some(faction.clone()), race: Some(race.clone()), classes: None };
		// v1's honest findings on a thread of their own (with its own data: the data is not shared across
		// threads), as keys.
		let (v1, (rest, feel_r)) = rayon::join(
			|| -> Result<FxHashSet<String>, String> {
				let data = forge_guide::data::load_data(&data_dir)?;
				let kb = honest::load_kb(&kb_file)?;
				Ok(honest_keys(&honest::play_pack(&inp.v1, &data, kb.as_ref(), &run, &HonestOpts::default())?.findings))
			},
			|| {
				rayon::join(
					|| -> Result<_, String> {
						let data = forge_guide::data::load_data(&data_dir)?;
						let kb = honest::load_kb(&kb_file)?;
						let written = honest::play_pack(&tree, &data, kb.as_ref(), &run, &HonestOpts::default())?.findings;
						let world = forge_sim::load_world(&inp.sim, fac)?;
						let params: Option<Value> = std::fs::read(inp.sim.join("params.json")).ok().and_then(|b| serde_json::from_slice(&b).ok());
						let lv = SimLevels::route(&world, &race, params.as_ref(), crate::levels::walks_for(walks, &inp.sim, &world))?;
						let cooldown = forge_sim::Params::effective(params.as_ref(), None, &[]).hearth_cooldown;
						let facts = Facts::new(&data, Some(&world), deliberate_doc);
						let guides = forge_guide::project::compile_project(&tree, &forge_guide::js::V::Undef, &data, forge_guide::diag::Diagnostics::new(), false, None).guides;
						let zones = step_zones(&tree, &data);
						let loops = loop_steps(&tree);
						let frames = forge_core::MapFrames::from_json(&std::fs::read(data_dir.join("map-frames.json")).map_err(|e| format!("map-frames.json: {e}"))?).map_err(|e| e.to_string())?;
						let proj = forge_core::Projector::new(&frames);
						let ctx0 = Ctx::new(&faction, &race, None)?;
						let classes = honest::playable_classes(&data, &ctx0.race, fac.name());
						let stream_file = inp.routes.join(format!("{start}.judge-improved.json"));
						let stream = if stream_file.is_file() { Some(crate::report::stream_goals(&read_json(&stream_file)?)) } else { None };
						let title = |q: i64| facts.quests.get(&q).map_or_else(String::new, |x| x.title.clone());
						let mut chain: FxHashSet<String> = FxHashSet::default();
						let mut per: [Vec<(String, Vec<Violation>)>; 16] = Default::default();
						for cls in &classes {
							let ctx = Ctx::new(&faction, &race, Some(cls))?;
							let mut walk = walk_chain(&guides, &|_| String::new(), Chain::Routes, &ctx, &proj, &lv, 61.0)?;
							chain.extend(walk.chain.iter().cloned());
							for g in walk.goals.iter_mut().filter(|g| g.w.is_none()) {
								if let Some(&m) = g.step.and_then(|s| zones.get(&(g.guide.clone(), s))) {
									g.map = Some(m);
								}
							}
							let g = &walk.goals;
							per[0].push((cls.clone(), lock_keys(g, &facts)));
							let mut ib = item_before_use(g, &facts);
							ib.extend(not_ready(g, &facts));
							per[1].push((cls.clone(), ib));
							per[2].push((cls.clone(), if deliberate_doc.is_null() && overrides_doc.is_null() { Vec::new() } else { deliberate(g, deliberate_doc, overrides_doc, &facts) }));
							per[3].push((cls.clone(), rare_required(g, &facts)));
							per[4].push((cls.clone(), hearth_cooldown(g, cooldown)));
							per[5].push((cls.clone(), bounces(g)));
							per[7].push((cls.clone(), dup_trips(g, &facts)));
							per[8].push((cls.clone(), next_to(g, &facts)));
							per[9].push((cls.clone(), splits(g, &facts)));
							per[13].push((cls.clone(), hub_order(g, &facts)));
							per[14].push((cls.clone(), walked_past(g)));
							per[15].push((cls.clone(), left_ready(g, &facts)));
							// The walk as written (along goals at their own steps): how the steps play.
							let (raw, _) = crate::walk::chain_goals(&guides, &|_| String::new(), &walk.chain, &ctx, &proj, true)?;
							per[10].push((cls.clone(), merges(&raw, &loops)));
							per[11].push((cls.clone(), alongs(&raw)));
							per[12].push((cls.clone(), arrow_order(&raw, &loops)));
							let mut warn = levels(g, &facts);
							if let Some(st) = &stream {
								let d = crate::report::stream_diff(&lv, st, g, &title);
								warn.extend(round_trip(&d, &format!("routes/{start}.judge-improved.json")));
							}
							per[6].push((cls.clone(), warn));
						}
						let mut out = Vec::new();
						for p in per {
							out.extend(merge_classes(p, &classes));
						}
						// Class quests of the faction's seed guides that no written guide of the start takes.
						let read_all = |dir: &Path, keep: &dyn Fn(&str) -> bool| -> Vec<(String, String)> {
							forge_guide::project::find_guide_files(dir, false).into_iter().filter(|r| keep(r)).filter_map(|r| std::fs::read_to_string(dir.join(&r)).ok().map(|t| (r, t))).collect()
						};
						let fac_dir = format!("{}/", faction.to_lowercase());
						let seed = read_all(&inp.v1.join("forever"), &|r: &str| r.starts_with(&fac_dir));
						let written_texts: Vec<String> = read_all(&tree, &|_: &str| true).into_iter().map(|(_, t)| t).collect();
						if let Some(bit) = data.races.get(&ctx0.race).get(&faction).get("bit").as_num() {
							out.extend(lost_class_quests(&seed, &written_texts, &facts, bit as u64, &classes));
						}
						Ok((honest_candidates(&written, &chain, &classes), out, classes))
					},
					|| player_view(inp, start, &route, &faction, &race, fac, walks),
				)
			},
		);
		let v1 = v1?;
		let (candidates, mut out, classes) = rest?;
		let (feel_row, feel_lines) = feel_r?;
		out.extend(merge_places(candidates.into_iter().filter(|(k, _)| !v1.contains(k)).map(|(_, v)| v).collect(), &classes));
		out.extend(feel_lines);
		out.extend(planned_hearths(&route, &format!("routes/{start}.json")));
		out.extend(fixes_rows(ledger, start));
		for v in &mut out {
			v.start = start.to_string();
		}
		let summary = StartSummary { start: start.to_string(), ms: t0.elapsed().as_millis() as u64, feel: Some(feel_row), ..Default::default() };
		Ok((summary, out))
	}

	/// The player view of a start: v1's guides and the written ones walked as the report walks them
	/// (any class, to 60), the model order's stream and v1's chain stream judged in the same model, and
	/// rule `feel` with its added returns and zone changes.
	fn player_view(inp: &Inputs, start: &str, route: &Value, faction: &str, race: &str, fac: forge_core::Faction, walks: &Walks) -> Result<(FeelRow, Vec<Violation>), String> {
		use crate::levels::SimLevels;
		use crate::walk::{walk_chain, Chain, Ctx, JudgeEnv, JudgeOpts};
		let tree = inp.guides.join(start);
		let data_dir = inp.root.join("data/forever");
		let data = forge_guide::data::load_data(&data_dir)?;
		let world = forge_sim::load_world(&inp.sim, fac)?;
		let params: Option<Value> = std::fs::read(inp.sim.join("params.json")).ok().and_then(|b| serde_json::from_slice(&b).ok());
		let lv = SimLevels::route(&world, race, params.as_ref(), crate::levels::walks_for(walks, &inp.sim, &world))?;
		let mut jo = JudgeOpts::new(&tree, faction, race, None, &inp.root);
		jo.data_dir = data_dir.clone();
		// Every avoidable return listed, not the report's 15 examples.
		jo.examples = usize::MAX;
		let env = JudgeEnv::new(&jo)?;
		let ctx = Ctx::new(faction, race, None)?;
		let file_of = |g: &forge_guide::js::V| guide_file(&g.get("id").to_js_string());
		let walk_of = |dir: &Path| -> Result<crate::walk::Walk, String> {
			let guides = forge_guide::project::compile_project(dir, &forge_guide::js::V::Undef, &data, forge_guide::diag::Diagnostics::new(), false, None).guides;
			walk_chain(&guides, &file_of, Chain::Routes, &ctx, &env.proj, &lv, 61.0)
		};
		let jw = env.judge(walk_of(&tree)?, None);
		let jv = env.judge(walk_of(&inp.v1)?, None);
		let (mut fw, mut fv) = (Feel::of(&crate::report::measures(&jw, 61.0)), Feel::of(&crate::report::measures(&jv, 61.0)));
		let pre = chain_pre(&env);
		let rets = |r: &crate::returns::Returns, goals: &[WalkGoal]| r.examples.iter().map(|e| Ret::from_example(e, goals, &pre)).collect::<Vec<Ret>>();
		let unchained = |v: Vec<Ret>| v.into_iter().filter(|r| !r.chain).collect::<Vec<Ret>>();
		// The model order (judge-improved) and v1's chain (judge-v1), as the routes stage wrote them.
		let stream = |k: &str| -> Result<Option<Vec<WalkGoal>>, String> {
			let f = inp.routes.join(format!("{start}.judge-{k}.json"));
			Ok(if f.is_file() { Some(crate::report::stream_goals(&read_json(&f)?)) } else { None })
		};
		let (so, sv) = (stream("improved")?, stream("v1")?);
		let order = match (&so, &sv) {
			(Some(o), Some(v)) => Some((unchained(rets(&env.returns(o, None), o)), unchained(rets(&env.returns(v, None), v)))),
			_ => None,
		};
		let (rw, rv) = (rets(&jw.returns, &jw.walk.goals), rets(&jv.returns, &jv.walk.goals));
		// Chain returns and zone changes are seen (the table), not counted.
		let chains = |rs: &[Ret]| (rs.iter().filter(|r| r.chain).count(), rs.iter().filter(|r| r.chain && r.wasted).count());
		let chain_zones = |g: &[WalkGoal]| zone_changes(g).iter().filter(|z| is_chain_zone(g, z.2.i, &pre)).count();
		let ((cw, cww), (cv, cvw)) = (chains(&rw), chains(&rv));
		let (zcw, zcv) = (chain_zones(&jw.walk.goals), chain_zones(&jv.walk.goals));
		for (f, c, cwasted, z) in [(&mut fw, cw, cww, zcw), (&mut fv, cv, cvw, zcv)] {
			f.returns -= c.min(f.returns);
			f.wasted_trips -= cwasted.min(f.wasted_trips);
			f.zone_changes -= z.min(f.zone_changes);
		}
		let (rw, rv) = (unchained(rw), unchained(rv));
		let (mut out, ret_split) = added_returns(&rv, &rw, order.as_ref().map(|(o, v)| (&o[..], &v[..])), &route["edits"]);
		let zone = |m: u32| data.zones.get(&m.to_string()).get("name").as_str().map_or_else(|| format!("map {m}"), str::to_string);
		let (zl, zone_split) = added_zone_changes(&jv.walk.goals, &jw.walk.goals, so.as_deref().zip(sv.as_deref()), &zone, &pre);
		out.extend(zl);
		out.extend(feel(&fv, &fw, &format!("guides/{start}")));
		let row = FeelRow {
			v1: fv,
			written: fw,
			order_returns: order.as_ref().map_or(0, |(o, _)| o.len()),
			v1_order_returns: order.as_ref().map_or(0, |(_, v)| v.len()),
			added_returns: ret_split,
			added_zone_changes: zone_split,
			chain_returns: (cv, cw),
			chain_zone_changes: (zcv, zcw),
		};
		Ok((row, out))
	}
}

mod hub;
mod play;
pub use hub::{best_tour, hub_order, hub_visits, left_ready, walked_past, walked_past_at, EXACT_STOPS};
pub use play::{alongs, arrow_order, merges, ARROW_SLACK_YD};

#[cfg(test)]
mod tests;
