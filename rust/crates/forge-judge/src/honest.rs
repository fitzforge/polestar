//! `playtest --honest` (tools/lib/playtest-honest.js, identical in the rust-judge and v2-route trees): the
//! compiled guides played from their lines and the reference data only, with nothing free. The character
//! gains a quest, an item, a flight path or a place only through a line that gives it; each rule a line
//! breaks is a [`Finding`]:
//!
//! - R1 travel: continent change needs a travel line (hearth, die, transport `goto`); a zone change farther
//!   than [`ZONE_STEP_YD`] a travel line; `fly` needs both flight paths learnt and a flight master within
//!   [`AT_FLIGHT_YD`]; `hearth` the bound inn. Goals of an `along` step do not move the player.
//! - R2 accept: an item-started quest needs the item in the bags; the giver stands within [`AT_NPC_YD`].
//! - R3 items: `collect` needs a data source within [`SOURCE_YD`]; quest items drop only while a needing
//!   quest is held; `use` needs the item in the bags.
//! - R4 NPCs: givers/enders from the data; a step titled with an NPC's name has a goal at that NPC; several
//!   givers and no `npc`: none [`GIVER_NEARER_YD`] nearer.
//! - R5 turn-in: the quest is held, every objective credited, and the knowledge base's required steps
//!   ([`Kb`]) each have a line since the accept.
//!
//! A broken line is reported, then played as the stub world would (one cause, one finding). Chains follow
//! `next` (honest:690-714).
//!
//! With [`HonestOpts::legacy`] the output is the JS's row for row (persona duplicates, the R3 cloth warning,
//! R5's missed buy lines). Without it: findings deduplicated across personas and chains, every start's chain
//! played through the shared guides, the "unflagged quest item" R3 warning demoted to info, `buy` lines
//! covering the knowledge base's buy steps, and the rules R6-R10 ([`rules`]):
//!
//! - R6 race/class/faction gating from the data: the quest's masks exclude the persona and no `only` gates
//!   the line (fail); an `only` on a quest the data opens to everyone (warn).
//! - R7 counts and levels in the text equal the data (objective counts, quest levels).
//! - R8 one `level` gate per grind.
//! - R9 quest log at most [`LOG_MAX`] at every point (the peak reported).
//! - R10 every accept is turned in or abandoned later on the chain.

mod play;
pub mod rules;
mod world;
pub use play::{fits, goal_lines};
pub use world::{Geo, NodeKey, Wpt};
#[cfg(test)]
mod tests;

#[cfg(feature = "native")]
mod native;
#[cfg(feature = "native")]
pub use native::*;

use forge_guide::data::Data;
use forge_guide::js::V;
use rustc_hash::{FxHashMap, FxHashSet};
use serde::Serialize;

/// A giver or ender stands at a goal within this many yards of one of its spawns.
pub const AT_NPC_YD: f64 = 80.0;
/// A flight leaves from a flight master within this many yards of where the guide leaves the player.
pub const AT_FLIGHT_YD: f64 = 200.0;
/// A move to another zone on the same continent shorter than this needs no travel line.
pub const ZONE_STEP_YD: f64 = 600.0;
/// A collect's source counts as at the goal within this many yards of one of its spawns.
pub const SOURCE_YD: f64 = 400.0;
/// Another giver this much nearer than the one the line resolves to is the one a player would go to.
pub const GIVER_NEARER_YD: f64 = 500.0;
/// A travel `goto` standing within this many yards of a transport end.
pub const DOCK_YD: f64 = 120.0;
/// A boat or zeppelin goto is taken from about where the guide leaves the player: a dock in another zone
/// farther than this on foot is a ride for someone else (the writer's RIDE_FROM_YD).
pub const RIDE_WALK_YD: f64 = 2000.0;
/// A plain goto into another zone farther than this is a walk across zones, not a way into the next
/// (estimate: two zones' breadth).
pub const WALK_FAR_YD: f64 = 4000.0;
/// The quest log's size (R9).
pub const LOG_MAX: usize = 20;
/// The knowledge base's step kinds a turn-in needs a line for.
pub const KB_ACTIONS: [&str; 6] = ["use-item", "combine", "summon", "escort", "buy", "collect-object"];

#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize)]
#[serde(rename_all = "lowercase")]
pub enum Severity {
	Info,
	Warn,
	Fail,
}

impl Severity {
	pub fn as_str(self) -> &'static str {
		match self {
			Severity::Info => "info",
			Severity::Warn => "warn",
			Severity::Fail => "fail",
		}
	}
}

/// One character a chain is played as: race file (`Scourge`, `NightElf`), faction, class file (`WARRIOR`).
#[derive(Clone, Debug, PartialEq, Eq, Hash, Serialize)]
pub struct Persona {
	pub race: String,
	pub faction: String,
	pub cls: String,
}

/// A map position as the JS carries it (`{ map, x, y, f }`), values printed as JS prints them.
#[derive(Clone, Debug, PartialEq, Serialize)]
pub struct Place {
	pub map: String,
	pub x: String,
	pub y: String,
	pub f: String,
}

/// An R1 move's ends and whether the jump is inside one step.
#[derive(Clone, Debug, PartialEq, Serialize)]
pub struct Move {
	pub from: Place,
	pub to: Place,
	#[serde(rename = "inStep")]
	pub in_step: bool,
}

#[derive(Clone, Debug, PartialEq, Serialize)]
pub struct Finding {
	pub rule: &'static str,
	pub severity: Severity,
	pub guide: String,
	pub file: String,
	pub line: u32,
	/// 1-based step number.
	pub step: usize,
	pub title: String,
	pub reason: String,
	pub repair: String,
	pub race: String,
	pub cls: String,
	/// Every persona that met the finding (deduplicated output); the one persona in legacy output.
	pub personas: Vec<(String, String)>,
	#[serde(skip_serializing_if = "Option::is_none")]
	pub moved: Option<Move>,
	/// R1: where the guide left the player, the flight paths known and the bind then (the writer's
	/// travel repair builds the way from them).
	#[serde(flatten, skip_serializing_if = "Option::is_none")]
	pub state: Option<R1State>,
}

/// The character's travel state at an R1 finding.
#[derive(Clone, Debug, PartialEq, Serialize)]
pub struct R1State {
	pub at: Option<Place>,
	#[serde(skip)]
	pub known: Vec<NodeKey>,
	#[serde(skip)]
	pub bound: V,
}

/// One knowledge-base step (`steps where drives = 1`).
#[derive(Clone, Debug, PartialEq)]
pub struct KbStep {
	pub n: i64,
	pub action: String,
	pub kind: Option<String>,
	pub target: Option<i64>,
	pub item: Option<i64>,
	pub fact: Option<String>,
}

/// The knowledge base's required steps by quest, in `n` order (only [`KB_ACTIONS`] with a target or item).
pub type Kb = FxHashMap<i64, Vec<KbStep>>;

/// The knowledge base from rows (`quest, n, action, target_kind, target, item, fact`), as loadKb filters them.
pub fn kb_from_rows(rows: impl IntoIterator<Item = (i64, KbStep)>) -> Kb {
	let mut kb = Kb::default();
	for (q, st) in rows {
		if !KB_ACTIONS.contains(&st.action.as_str()) || (st.target.is_none() && st.item.is_none()) {
			continue;
		}
		kb.entry(q).or_default().push(st);
	}
	kb
}

/// `groups`: the answer at group quests (`when group`): skip (the solo route) or do.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Groups {
	Skip,
	Do,
}

#[derive(Clone, Debug)]
pub struct HonestOpts {
	/// The JS's output exactly (R1-R5, persona duplicates, cloth warn, R5's missed buys).
	pub legacy: bool,
	pub groups: Groups,
	/// R1: a plain goto across zones farther than WALK_FAR_YD fails (the writer's travel repair; not in
	/// the JS, so off in legacy).
	pub walk_far: bool,
}

impl Default for HonestOpts {
	fn default() -> Self {
		HonestOpts { legacy: false, groups: Groups::Skip, walk_far: true }
	}
}

impl HonestOpts {
	pub fn legacy() -> Self {
		HonestOpts { legacy: true, groups: Groups::Skip, walk_far: false }
	}
}

fn next_options(g: &V) -> Vec<V> {
	let nc = g.get("nextChoices");
	if nc.is_arr() && !nc.is_empty() {
		nc.items()
	} else if g.get("next").truthy() {
		vec![g.get("next")]
	} else {
		Vec::new()
	}
}

/// `g.nextChoices || (g.next ? [g.next] : [])` (playtest.js arriving: an empty nextChoices counts).
fn next_choices_or_next(g: &V) -> Vec<V> {
	let nc = g.get("nextChoices");
	if nc.truthy() {
		nc.items()
	} else if g.get("next").truthy() {
		vec![g.get("next")]
	} else {
		Vec::new()
	}
}

fn guide_id(g: &V) -> String {
	g.get("id").to_js_string()
}

/// The option a chain follows: the first offered without a `when`, else the first.
fn next_of(g: &V) -> Option<String> {
	let opts = next_options(g);
	let nw = g.get("nextWhen");
	opts.iter().find(|id| !(nw.truthy() && nw.get(&id.to_js_string()).truthy())).or_else(|| opts.first()).filter(|v| v.truthy()).map(V::to_js_string)
}

/// honest:690-714 chains: each guide no option leads into, then each guide its first `when`-less option
/// leads to, once (a guide already in a chain ends it); then every guide not yet in one starts its own.
/// -> chains of indices into `guides`.
pub fn chains(guides: &[V]) -> Vec<Vec<usize>> {
	chains_with(guides, true)
}

/// `shared_once` false (the non-legacy chains): every root's chain runs through the guides it shares with
/// other roots (a cycle still ends it); the rest as [`chains`].
pub fn chains_with(guides: &[V], shared_once: bool) -> Vec<Vec<usize>> {
	let mut by_id: FxHashMap<String, usize> = FxHashMap::default();
	// JS Map: a later guide with the same id replaces the earlier one.
	for (i, g) in guides.iter().enumerate() {
		by_id.insert(guide_id(g), i);
	}
	let into: FxHashSet<String> = guides.iter().flat_map(next_options).map(|v| v.to_js_string()).filter(|id| by_id.contains_key(id)).collect();
	let mut seen: FxHashSet<String> = FxHashSet::default();
	let mut out = Vec::new();
	let mut walk = |start: usize, seen: &mut FxHashSet<String>, root: bool| {
		let mut chain = Vec::new();
		let mut mine: FxHashSet<String> = FxHashSet::default();
		let mut g = Some(start);
		while let Some(i) = g {
			let id = guide_id(&guides[i]);
			let stop = if !shared_once && root { mine.contains(&id) } else { seen.contains(&id) };
			if stop {
				break;
			}
			seen.insert(id.clone());
			mine.insert(id);
			chain.push(i);
			g = next_of(&guides[i]).and_then(|n| by_id.get(&n).copied());
		}
		if !chain.is_empty() {
			out.push(chain);
		}
	};
	for (i, g) in guides.iter().enumerate() {
		if !into.contains(&guide_id(g)) {
			walk(i, &mut seen, true);
		}
	}
	for i in 0..guides.len() {
		walk(i, &mut seen, false);
	}
	out
}

/// The classes every race file can be on each side (races.json), CLASSES order when the data has no table.
const ALL_CLASS_FILES: [&str; 9] = ["WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID"];

/// The class files `race` (a race file: `Scourge`, `NightElf`) can be on `faction`'s side.
pub fn playable_classes(data: &Data, race: &str, faction: &str) -> Vec<String> {
	if !data.races.is_obj() || data.races.is_empty() {
		return ALL_CLASS_FILES.iter().map(|s| s.to_string()).collect();
	}
	let side = data.races.get(race).get(faction);
	if side.truthy() {
		side.get("classes").items().iter().map(V::to_js_string).collect()
	} else {
		Vec::new()
	}
}

/// playtest.js sideOf: the one side a race file is played on; None for Skyborne or an unknown race.
fn side_of(race: &str) -> Option<&'static str> {
	let r = forge_core::race_by_file(race)?;
	match (r.alliance != 0, r.horde != 0) {
		(true, false) => Some("Alliance"),
		(false, true) => Some("Horde"),
		_ => None,
	}
}

fn strs(v: &V) -> Vec<String> {
	v.items().iter().map(V::to_js_string).collect()
}

fn undead_file(r: &str) -> String {
	if r == "Undead" {
		"Scourge".into()
	} else {
		r.into()
	}
}

/// Named classes of a guide: its `class` header and every `only` (steps and goals), upper case, in order.
fn named_classes(guide: &V) -> Vec<String> {
	let mut named: Vec<String> = Vec::new();
	let mut add = |c: String| {
		if !named.contains(&c) {
			named.push(c);
		}
	};
	for c in strs(&guide.get("classes")) {
		add(c.to_uppercase());
	}
	for s in guide.get("steps").items() {
		for c in strs(&s.get("only").get("classes")) {
			add(c.to_uppercase());
		}
		for g in s.get("goals").items() {
			for c in strs(&g.get("only").get("classes")) {
				add(c.to_uppercase());
			}
		}
	}
	named
}

/// playtest.js personasFor: the races a guide is played as, with their faction.
fn personas_for(guide: &V, arriving: &[String]) -> Vec<(String, String)> {
	let mut named: Vec<String> = Vec::new();
	let mut add = |r: String| {
		if !named.contains(&r) {
			named.push(r);
		}
	};
	for r in strs(&guide.get("races")) {
		add(r);
	}
	for s in guide.get("steps").items() {
		for r in strs(&s.get("only").get("races")) {
			add(r);
		}
		for g in s.get("goals").items() {
			for r in strs(&g.get("only").get("races")) {
				add(r);
			}
		}
	}
	for r in arriving {
		add(r.clone());
	}
	let faction = guide.get("faction");
	let faction = faction.as_str().filter(|f| !f.is_empty());
	let mut races: Vec<String> = Vec::new();
	for r in named.iter().map(|r| undead_file(r)) {
		if !races.contains(&r) {
			races.push(r);
		}
	}
	races.retain(|r| faction.is_none() || side_of(r).is_none() || side_of(r) == faction);
	let guide_races: Vec<String> = strs(&guide.get("races")).iter().map(|r| undead_file(r)).collect();
	if !guide_races.is_empty() {
		races.retain(|r| guide_races.contains(r));
	}
	let sides: Vec<&str> = match faction {
		Some(f) => vec![f],
		None => vec!["Alliance", "Horde"],
	};
	for side in sides {
		if !races.iter().any(|r| side_of(r).unwrap_or(side) == side) {
			races.push(if side == "Horde" { "Orc".into() } else { "Human".into() });
		}
	}
	if faction.is_none() && guide_races.is_empty() {
		for r in ["Scourge", "NightElf"] {
			if !races.iter().any(|x| x == r) {
				races.push(r.into());
			}
		}
	}
	races
		.into_iter()
		.map(|race| {
			let f = side_of(&race).map(str::to_string).or_else(|| faction.map(str::to_string)).unwrap_or_else(|| "Alliance".into());
			(race, f)
		})
		.collect()
}

/// playtest.js classPersonas: a persona for each named class none of `personas` can be.
fn class_personas(data: &Data, guide: &V, personas: &[(String, String)]) -> Vec<(String, String)> {
	if !data.races.is_obj() || data.races.is_empty() {
		return Vec::new();
	}
	let guide_races: Vec<String> = strs(&guide.get("races")).iter().map(|r| undead_file(r)).collect();
	let faction = guide.get("faction");
	let sides: Vec<String> = match faction.as_str().filter(|f| !f.is_empty()) {
		Some(f) => vec![f.into()],
		None => vec!["Alliance".into(), "Horde".into()],
	};
	let mut added: Vec<(String, String)> = Vec::new();
	for cls in named_classes(guide) {
		if personas.iter().chain(added.iter()).any(|(r, f)| playable_classes(data, r, f).contains(&cls)) {
			continue;
		}
		for (race, by_side) in data.races.entries() {
			if !guide_races.is_empty() && !guide_races.iter().any(|r| **r == *race) {
				continue;
			}
			let f = sides.iter().find(|s| {
				let side = by_side.get(s);
				side.truthy() && strs(&side.get("classes")).contains(&cls)
			});
			if let Some(f) = f {
				added.push((race.to_string(), f.clone()));
				break;
			}
		}
	}
	added
}

/// playtest.js classesFor (no class filter given: `only` None).
fn classes_for(data: &Data, guide: &V, race: &str, faction: &str, only: Option<&[String]>) -> Vec<String> {
	let mut can = playable_classes(data, race, faction);
	let header: Vec<String> = strs(&guide.get("classes")).iter().map(|c| c.to_uppercase()).collect();
	if !header.is_empty() {
		can.retain(|c| header.contains(c));
	}
	if let Some(only) = only {
		return can.into_iter().filter(|c| only.contains(c)).collect();
	}
	let named = named_classes(guide);
	let plain = can.iter().find(|c| !named.contains(c)).cloned();
	let mut out: Vec<String> = named.into_iter().filter(|c| can.contains(c)).collect();
	out.extend(plain);
	out
}

/// Races arriving at each guide from a previous one (any route option): playtest.js honestRun's `arriving`.
pub fn arriving(guides: &[V]) -> FxHashMap<String, Vec<String>> {
	let mut out: FxHashMap<String, Vec<String>> = FxHashMap::default();
	for g in guides {
		for to in next_choices_or_next(g) {
			out.entry(to.to_js_string()).or_default().extend(strs(&g.get("races")));
		}
	}
	out
}

/// honestRun's personas for a chain's first guide: its races (personasFor), the class personas, each with
/// its classes (classesFor; `classes` replaces the guide's choice like `playtest --class`).
pub fn personas(data: &Data, root: &V, arriving: &FxHashMap<String, Vec<String>>, classes: Option<&[String]>) -> Vec<Persona> {
	let arr = arriving.get(&guide_id(root)).map(Vec::as_slice).unwrap_or(&[]);
	let mut list = personas_for(root, arr);
	let extra = class_personas(data, root, &list);
	list.extend(extra);
	let mut out = Vec::new();
	for (race, faction) in list {
		for cls in classes_for(data, root, &race, &faction, classes) {
			out.push(Persona { race: race.clone(), faction: faction.clone(), cls });
		}
	}
	out
}

/// Play one chain (compiled guides in order) as `persona` -> its findings; `report`: the guide ids findings
/// are kept for (None: all).
pub fn play_chain(chain: &[&V], data: &Data, persona: &Persona, kb: Option<&Kb>, report: Option<&FxHashSet<String>>, opts: &HonestOpts) -> Vec<Finding> {
	let ctx = world::Ctx::new(data);
	play_chain_in(&ctx, chain, persona, kb, report, opts)
}

/// One goal played (playChain `trace`): where the character was before and after it.
#[derive(Clone, Debug)]
pub struct TraceRow {
	pub file: String,
	pub line: u32,
	pub verb: String,
	pub before: Option<Wpt>,
	pub after: Option<Wpt>,
	/// The goal moved the character (JS `after !== before`).
	pub moved: bool,
	/// A position before the goal (JS `before` not null).
	pub had_before: bool,
	pub has_after: bool,
}

/// play_chain with each goal played traced.
pub fn play_chain_traced(chain: &[&V], data: &Data, persona: &Persona, opts: &HonestOpts) -> (Vec<Finding>, Vec<TraceRow>) {
	let ctx = world::Ctx::new(data);
	let mut trace = Some(Vec::new());
	let f = play_chain_with(&ctx, chain, persona, None, None, opts, &mut trace);
	(f, trace.unwrap_or_default())
}

fn play_chain_in(ctx: &world::Ctx, chain: &[&V], persona: &Persona, kb: Option<&Kb>, report: Option<&FxHashSet<String>>, opts: &HonestOpts) -> Vec<Finding> {
	play_chain_with(ctx, chain, persona, kb, report, opts, &mut None)
}

fn play_chain_with(ctx: &world::Ctx, chain: &[&V], persona: &Persona, kb: Option<&Kb>, report: Option<&FxHashSet<String>>, opts: &HonestOpts, trace: &mut Option<Vec<TraceRow>>) -> Vec<Finding> {
	let mut w = world::World::new(ctx, persona.clone(), kb, opts);
	w.trace = trace.take();
	for g in chain {
		let reporting = report.is_none_or(|r| r.contains(&guide_id(g)));
		play::play_guide(&mut w, g, reporting);
	}
	if !opts.legacy {
		rules::chain_end(&mut w);
	}
	*trace = w.trace.take();
	let mut out = std::mem::take(&mut w.findings);
	for f in &mut out {
		f.race = persona.race.clone();
		f.cls = persona.cls.clone();
		f.personas = vec![(persona.race.clone(), persona.cls.clone())];
	}
	out
}

/// honestPlay: every chain holding a guide of `play` (ids; None: all) as each persona `personas_of` gives
/// its first guide -> findings of those guides sorted by file, then line (stable). Non-legacy: chains run
/// through shared guides and equal findings (rule, severity, guide, line, reason) are merged across personas.
pub fn honest_play(guides: &[V], data: &Data, personas_of: &dyn Fn(&V) -> Vec<Persona>, kb: Option<&Kb>, play: Option<&[String]>, opts: &HonestOpts) -> Vec<Finding> {
	let ctx = world::Ctx::new(data);
	let report: Option<FxHashSet<String>> = play.map(|p| p.iter().cloned().collect());
	let mut out: Vec<Finding> = Vec::new();
	for chain in chains_with(guides, opts.legacy) {
		if let Some(r) = &report {
			if !chain.iter().any(|&i| r.contains(&guide_id(&guides[i]))) {
				continue;
			}
		}
		let refs: Vec<&V> = chain.iter().map(|&i| &guides[i]).collect();
		for persona in personas_of(refs[0]) {
			out.extend(play_chain_in(&ctx, &refs, &persona, kb, report.as_ref(), opts));
		}
	}
	if !opts.legacy {
		out = dedupe(out);
	}
	out.sort_by(|a, b| forge_guide::js::cmp_utf16(&a.file, &b.file).then(a.line.cmp(&b.line)));
	out
}

/// Merge equal findings (rule, severity, guide, line, reason): the first kept, the personas joined.
pub fn dedupe(list: Vec<Finding>) -> Vec<Finding> {
	let mut at: FxHashMap<(&'static str, Severity, String, u32, String), usize> = FxHashMap::default();
	let mut out: Vec<Finding> = Vec::new();
	for f in list {
		let k = (f.rule, f.severity, f.guide.clone(), f.line, f.reason.clone());
		match at.get(&k) {
			Some(&i) => {
				for p in f.personas {
					if !out[i].personas.contains(&p) {
						out[i].personas.push(p);
					}
				}
			}
			None => {
				at.insert(k, out.len());
				out.push(f);
			}
		}
	}
	out
}

/// "R3 fail forever/x/01.guide:12 (Orc Warrior) step 4 "Title": reason" and "  repair: …" (findingLines).
pub fn finding_lines(f: &Finding) -> [String; 2] {
	let cls = if f.cls.is_empty() {
		String::new()
	} else {
		let mut c = f.cls.chars();
		let first = c.next().map(|x| x.to_string()).unwrap_or_default();
		first + &c.as_str().to_lowercase()
	};
	let title = if f.title.is_empty() { String::new() } else { format!(" \"{}\"", f.title) };
	[format!("{} {} {}:{} ({} {}) step {}{}: {}", f.rule, f.severity.as_str(), f.file, f.line, f.race, cls, f.step, title, f.reason), format!("  repair: {}", f.repair)]
}
