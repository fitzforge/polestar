//! Dungeons in the route, end to end on the shipped guides (#2026; a release gate, #2042). Every guide of
//! guides/ compiled with the reference data (data/forever; skipped with a note without it) and the leveling
//! route played whole, 1-60, by the full addon on the stub world (tests/lua/route_e2e.lua): every start of
//! each faction (one class per race, and a healer), with "Dungeons in my route" (behavior.dungeons) on Skip,
//! the default, on Run them, and on Ask me (Run it for the first dungeon asked, Skip it for the next, and so
//! on); and one character per faction that turns it on mid-route at 18, 26, 34, 42 and 51 (Run them, then
//! off again at the door of the first run it reaches, one of that run's quests done) or turns on Ask me
//! there. The same characters play the route compiled with every dungeon step taken out (the solo route).
//!
//! Checks, FAIL lines in polestar-dungeons-e2e.txt:
//! - every scenario: never stuck (a goal that does not get done, a step that does not move on), the live
//!   step never goes back and no guide comes back once left, the quest log never over 40; no step of a city
//!   dungeon of the other faction comes and none is asked about (Engine.EnemyCityDungeon: Ragefire Chasm and the
//!   Ruins of Lordaeron are the Horde's, The Hall of Thanes and the Stockade the Alliance's);
//! - Skip: no dungeon step is ever live and no dungeon quest is taken; the steps, their numbers and totals,
//!   the accepts and hand-ins are exactly the solo route's, step for step; and each guide compiled with its
//!   dungeon steps holds the solo compile's steps unchanged (the dungeon steps left out, `when !dungeon`
//!   dropped);
//! - Run them: every run comes; its quests are picked up before it and handed in after it; no dungeon quest
//!   is left in the log at the end; the walk to the door crosses no zone whose lowest level is 4 or more above
//!   the character (Nav/Danger.lua's mark);
//! - Ask me: each dungeon is asked about once; after Skip it none of its steps comes, after Run it its run
//!   does;
//! - mid-route: the switch never moves the live step back; no step of a dungeon whose run the route had
//!   passed comes; the first dungeon wholly ahead is offered; off at the door, the run is dropped, its quests
//!   stay in the log, a finished one is handed in and an unfinished one is handed in or listed as room to make
//!   in the quest log (Core/RoutePlan.lua Plan.Unneeded).
//!
//! Quest styles (behavior.dungeonQuests, DUNGEONS_E2E_STYLES, default both): each Run them, Ask me and mid-route
//! scenario is played with every dungeon quest ("all": a run's `when dungeon "<X>" all` steps too) and with only the
//! quests on the way ("way", named "-way"), where no every-quest step may come.
//!
//! WARN lines (a pass all the same): what turns on the level model's pace, which runs about a level under
//! players': a run the model reaches under the dungeon's floor, and a run that never came where the model is
//! under its floor there (the floor's gate holds it).
//!
//! The character's level: DUNGEONS_E2E_LEVELS=<Alliance.json>,<Horde.json>, the calibrated level model's
//! output per faction (the files tools/danger-gate.js takes): the persona's own race and class branch, else
//! the faction's mean, at each guide's start and after each hand-in. Without it the level
//! rises only where a goal waits for one (as tests/lua/simulate.lua does), and the floor and door checks are
//! left out. The floors: the Codex's (data/forever/codex/journal.json, a dungeon page's `floor`), else
//! DUNGEONS_E2E_FLOORS=<file> ({ "<codex key>": { "floor": n } }), else none (the check is left out).
//! DUNGEONS_E2E_ONLY=<part of a scenario name> plays only those; DUNGEONS_E2E_THREADS=<n>; DUNGEONS_E2E_OUT=
//! <dir> (default the temp dir) gets polestar-dungeons-e2e.txt, .md (the report per scenario) and .json (the
//! traces). About 70 whole-route plays: a release gate, run with `--ignored`.

use forge_addontest::dsl::{compile_with, our_manifest, plain, write_test_pack};
use forge_addontest::run::root;
use forge_addontest::{lua_value, run_addon, Addon, RunAddon};
use forge_guide::project::find_guide_files;
use serde_json::{json, Map, Value};
use std::collections::{BTreeMap, BTreeSet, HashMap};
use std::fmt::Write as _;
use std::path::{Path, PathBuf};

struct Persona {
	faction: &'static str,
	race: &'static str,
	class: &'static str,
	start: &'static str,
}

const fn p(faction: &'static str, race: &'static str, class: &'static str, start: &'static str) -> Persona {
	Persona { faction, race, class, start }
}

// One class per race, and a healer per faction (the last of each).
const PERSONAS: &[Persona] = &[
	p("Alliance", "Human", "WARRIOR", "forever/alliance/human/01-elwynn-forest"),
	p("Alliance", "Dwarf", "HUNTER", "forever/alliance/dwarf/01-dun-morogh"),
	p("Alliance", "Gnome", "MAGE", "forever/alliance/gnome/01-dun-morogh"),
	p("Alliance", "NightElf", "DRUID", "forever/alliance/nightelf/01-teldrassil"),
	p("Alliance", "Skyborne", "ROGUE", "forever/alliance/skyborne/01-zephras-isle"),
	p("Alliance", "Human", "PRIEST", "forever/alliance/human/01-elwynn-forest"),
	p("Horde", "Orc", "WARRIOR", "forever/horde/orc/01-durotar"),
	p("Horde", "Troll", "HUNTER", "forever/horde/troll/01-durotar"),
	p("Horde", "Tauren", "DRUID", "forever/horde/tauren/01-mulgore"),
	p("Horde", "Scourge", "MAGE", "forever/horde/undead/01-tirisfal-glades"),
	p("Horde", "Skyborne", "ROGUE", "forever/horde/skyborne/01-zephras-isle"),
	p("Horde", "Orc", "SHAMAN", "forever/horde/orc/01-durotar"),
];

// The levels where a character turns dungeons on mid-route (the first persona of each faction).
const SWITCH_AT: &[f64] = &[18.0, 26.0, 34.0, 42.0, 51.0];

const LOG_CAP: u64 = 40;
// Nav/Danger.lua: a zone is dangerous for level L when its lowest level is at least L + 4.
const DANGEROUS: f64 = 4.0;
const CLASS_IDS: &[(&str, u32)] = &[("WARRIOR", 1), ("PALADIN", 2), ("HUNTER", 3), ("ROGUE", 4), ("PRIEST", 5), ("SHAMAN", 7), ("MAGE", 8), ("WARLOCK", 9), ("DRUID", 11)];

#[derive(Clone, Copy, PartialEq)]
enum Kind {
	Solo,
	Skip,
	Run,
	Ask,
	MidRun(f64),
	MidAsk(f64),
}

struct Scenario {
	name: String,
	persona: usize,
	kind: Kind,
	/// The dungeon quests while dungeons are on (behavior.dungeonQuests): "all", every quest of a dungeon run
	/// (its `when dungeon "<X>" all` steps too), or "way", only the quests on the way.
	style: &'static str,
}

impl Scenario {
	fn label(&self) -> String {
		match self.kind {
			Kind::Solo => "the solo route (no dungeon step compiled)".into(),
			Kind::Skip => "Skip them (the default)".into(),
			Kind::Run => "Run them".into(),
			Kind::Ask => "Ask me (Run it, then Skip it, by turns)".into(),
			Kind::MidRun(l) => format!("Skip, Run them from level {l}, off at the first run's door"),
			Kind::MidAsk(l) => format!("Skip, Ask me from level {l}"),
		}
	}
	fn styled_label(&self) -> String {
		match (self.kind, self.style) {
			(Kind::Solo | Kind::Skip, _) => self.label(),
			(_, "way") => format!("{}; only the quests on the way", self.label()),
			_ => format!("{}; every dungeon quest", self.label()),
		}
	}
}

/// The quest styles played (DUNGEONS_E2E_STYLES, default both): each Run them, Ask me and mid-route scenario once
/// per style, "way" ones named with a "-way" suffix.
fn styles() -> Vec<&'static str> {
	let want = std::env::var("DUNGEONS_E2E_STYLES").unwrap_or_else(|_| "all,way".into());
	["all", "way"].into_iter().filter(|s| want.split(',').any(|w| w.trim() == *s)).collect()
}

// ---------------------------------------------------------------------------------------------------------
// The solo route: the guides without their dungeon steps
// ---------------------------------------------------------------------------------------------------------

fn when_dungeon(line: &str, neg: bool) -> bool {
	line.starts_with(char::is_whitespace) && line.trim_start().starts_with(if neg { "when !dungeon " } else { "when dungeon " })
}

/// A guide's text without its dungeons: each step with a `when dungeon "<X>"` line left out whole, each
/// `when !dungeon "<X>"` line dropped from its step (the solo way of a shared stop is that stop's step).
fn solo_text(text: &str) -> String {
	let lines: Vec<&str> = text.split('\n').collect();
	let mut out: Vec<&str> = Vec::with_capacity(lines.len());
	let mut i = 0;
	while i < lines.len() {
		let l = lines[i];
		let is_step = l == "step" || (l.starts_with("step") && l[4..].starts_with(char::is_whitespace));
		if !is_step {
			out.push(l);
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < lines.len() && (lines[j].trim().is_empty() || lines[j].starts_with(char::is_whitespace)) {
			j += 1;
		}
		let block = &lines[i..j];
		if !block.iter().any(|b| when_dungeon(b, false)) {
			out.extend(block.iter().filter(|b| !when_dungeon(b, true)));
		}
		i = j;
	}
	out.join("\n")
}

/// A step's `when dungeon` predicate: Some((map, name, negated)).
fn dungeon_of(step: &Value) -> Option<(i64, String, bool)> {
	step["when"].as_array()?.iter().find(|p| p["k"] == "dungeon").map(|p| (p["map"].as_i64().unwrap_or(0), p["name"].as_str().unwrap_or("").to_string(), p["neg"] == true))
}

/// The steps of a guide as the solo compile should have them: its dungeon steps left out, `when !dungeon`
/// taken off the solo way's steps.
fn without_dungeons(steps: &[Value]) -> Vec<Value> {
	let mut out = Vec::new();
	for s in steps {
		match dungeon_of(s) {
			Some((_, _, false)) => {}
			Some((_, _, true)) => {
				let mut s = s.clone();
				let when: Vec<Value> = s["when"].as_array().unwrap().iter().filter(|p| p["k"] != "dungeon").cloned().collect();
				if when.is_empty() {
					s.as_object_mut().unwrap().remove("when");
				} else {
					s["when"] = Value::Array(when);
				}
				out.push(s);
			}
			None => out.push(s.clone()),
		}
	}
	out
}

/// Where two compiled values first differ: a path and both sides.
fn first_diff(a: &Value, b: &Value, path: &str) -> Option<String> {
	match (a, b) {
		(Value::Object(x), Value::Object(y)) => {
			let keys: BTreeSet<&String> = x.keys().chain(y.keys()).collect();
			keys.into_iter().find_map(|k| first_diff(x.get(k).unwrap_or(&Value::Null), y.get(k).unwrap_or(&Value::Null), &format!("{path}.{k}")))
		}
		(Value::Array(x), Value::Array(y)) if x.len() == y.len() => x.iter().zip(y).enumerate().find_map(|(i, (p, q))| first_diff(p, q, &format!("{path}[{i}]"))),
		_ if a == b => None,
		_ => Some(format!("{path}: {} with the dungeon steps, {} without", short(a), short(b))),
	}
}

fn short(v: &Value) -> String {
	let s = v.to_string();
	if s.len() > 80 {
		format!("{}…", &s[..s.char_indices().nth(77).map_or(s.len(), |(i, _)| i)])
	} else {
		s
	}
}

fn leveling(g: &Value) -> bool {
	matches!(g["category"].as_str(), None | Some("Leveling"))
}

/// Each leveling guide's steps with its dungeons taken out against the solo compile's: "dungeons off is the
/// solo route" at the compiled level.
fn static_diffs(real: &[Value], solo: &[Value]) -> Vec<String> {
	let by: HashMap<&str, &Value> = solo.iter().map(|g| (g["id"].as_str().unwrap_or(""), g)).collect();
	let mut out = Vec::new();
	for g in real.iter().filter(|g| leveling(g)) {
		let id = g["id"].as_str().unwrap_or("");
		let steps = g["steps"].as_array().cloned().unwrap_or_default();
		if !steps.iter().any(|s| dungeon_of(s).is_some()) {
			continue;
		}
		let Some(s) = by.get(id) else {
			out.push(format!("FAIL static {id}: not in the solo compile"));
			continue;
		};
		let want = without_dungeons(&steps);
		let have = s["steps"].as_array().cloned().unwrap_or_default();
		if want.len() != have.len() {
			out.push(format!("FAIL static {id}: {} steps without its dungeon steps, the solo compile has {}", want.len(), have.len()));
			continue;
		}
		let mut n = 0;
		for (k, (a, b)) in want.iter().zip(&have).enumerate() {
			if let Some(d) = first_diff(a, b, "") {
				n += 1;
				if n <= 3 {
					out.push(format!("FAIL static {id} solo step {} \"{}\": {d}", k + 1, a["title"].as_str().unwrap_or("")));
				}
			}
		}
		if n > 3 {
			out.push(format!("FAIL static {id}: {} more steps differ", n - 3));
		}
	}
	out
}

// ---------------------------------------------------------------------------------------------------------
// The route's facts: dungeon steps, floors, zone levels, the level model
// ---------------------------------------------------------------------------------------------------------

#[derive(Clone)]
struct DStep {
	guide: String,
	index: usize, // 1-based, as the engine counts
	role: &'static str,
	map: i64,
	name: String,
	title: String,
	/// A pick-up's: the quests it takes; any other step's (a run's: the quests worked in it): every quest its goals
	/// name.
	quests: Vec<i64>,
}

fn dungeon_steps(guides: &[Value]) -> Vec<DStep> {
	let mut out = Vec::new();
	for g in guides.iter().filter(|g| leveling(g)) {
		let id = g["id"].as_str().unwrap_or("").to_string();
		for (i, s) in g["steps"].as_array().map(|a| a.as_slice()).unwrap_or_default().iter().enumerate() {
			let Some((map, name, neg)) = dungeon_of(s) else { continue };
			let goals = s["goals"].as_array().cloned().unwrap_or_default();
			let has = |t: &str| goals.iter().any(|x| x["t"] == t);
			let role = if neg {
				"solo"
			} else if has("enter") {
				"run"
			} else if has("accept") {
				"pickup"
			} else if has("turnin") {
				"handin"
			} else {
				"other"
			};
			// A pick-up's: the quests it takes; any other step's: every quest its goals name.
			let quests = goals.iter().filter(|x| role != "pickup" || x["t"] == "accept").filter_map(|x| x["quest"].as_i64()).collect();
			out.push(DStep { guide: id.clone(), index: i + 1, role, map, name, title: s["title"].as_str().unwrap_or("").to_string(), quests });
		}
	}
	out
}

struct Floors {
	by_map: HashMap<i64, (f64, String)>,
	names: HashMap<i64, String>,
}

/// The dungeons' floors: the Codex journal's `floor` (data/forever/codex/journal.json), else
/// DUNGEONS_E2E_FLOORS's by the Codex key, by the instance's map.
fn floors(data_dir: &Path) -> Floors {
	let journal: Value = std::fs::read_to_string(data_dir.join("codex/journal.json")).ok().and_then(|t| serde_json::from_str(&t).ok()).unwrap_or(Value::Null);
	let file: Value =
		std::env::var("DUNGEONS_E2E_FLOORS").ok().map(|p| serde_json::from_str(&std::fs::read_to_string(&p).expect("DUNGEONS_E2E_FLOORS")).expect("DUNGEONS_E2E_FLOORS json")).unwrap_or(Value::Null);
	let mut by_map = HashMap::new();
	let mut names = HashMap::new();
	for (key, page) in journal["dungeons"].as_object().into_iter().flatten() {
		let Some(map) = page["map"].as_i64() else { continue };
		names.insert(map, page["name"].as_str().unwrap_or(key).to_string());
		if let Some(f) = page["floor"].as_f64() {
			by_map.insert(map, (f, "the Codex".to_string()));
		} else if let Some(f) = file[key.as_str()]["floor"].as_f64() {
			by_map.insert(map, (f, "DUNGEONS_E2E_FLOORS".to_string()));
		}
	}
	Floors { by_map, names }
}

/// Maps/ZoneLevels.lua: uiMapID -> (lowest level, or the zone's danger floor where it has one).
fn zone_levels() -> HashMap<i64, f64> {
	let text = std::fs::read_to_string(root().join("addon/Polestar/Maps/ZoneLevels.lua")).unwrap_or_default();
	let re = regex::Regex::new(r"\[(\d+)\] = \{ (\d+), (\d+), [-\d.]+, [-\d.]+(?:, (\d+))? \}").unwrap();
	re.captures_iter(&text)
		.map(|c| {
			let lo: f64 = c[2].parse().unwrap();
			let floor = c.get(4).map(|m| m.as_str().parse::<f64>().unwrap()).unwrap_or(lo);
			(c[1].parse().unwrap(), floor)
		})
		.collect()
}

#[derive(Clone, Default)]
struct GuideLevels {
	start: f64,
	q: BTreeMap<i64, f64>,
}

/// The level model's rows -> (per race/class branch, per guide; the faction's mean per guide).
fn model_levels() -> Option<(HashMap<(String, String), HashMap<String, GuideLevels>>, HashMap<String, GuideLevels>)> {
	let files = std::env::var("DUNGEONS_E2E_LEVELS").ok()?;
	let mut branches = HashMap::new();
	let mut sums: HashMap<String, (f64, usize, BTreeMap<i64, (f64, usize)>)> = HashMap::new();
	for f in files.split(',').filter(|f| !f.is_empty()) {
		let v: Value = serde_json::from_str(&std::fs::read_to_string(f).unwrap_or_else(|e| panic!("{f}: {e}"))).unwrap_or_else(|e| panic!("{f}: {e}"));
		for b in v.as_array().into_iter().flatten() {
			let race = b["race"].as_str().unwrap_or("").to_string();
			let cls = b["cls"].as_str().unwrap_or("").to_string();
			let mut per = HashMap::new();
			for r in b["rows"].as_array().into_iter().flatten() {
				let id = r["id"].as_str().unwrap_or("").to_string();
				let start = r["start"].as_f64().unwrap_or(0.0);
				let mut gl = GuideLevels { start, q: BTreeMap::new() };
				let e = sums.entry(id.clone()).or_insert((0.0, 0, BTreeMap::new()));
				e.0 += start;
				e.1 += 1;
				for t in r["tq"].as_array().into_iter().flatten() {
					if let (Some(q), Some(l)) = (t[0].as_i64(), t[1].as_f64()) {
						gl.q.insert(q, l);
						let x = e.2.entry(q).or_insert((0.0, 0));
						x.0 += l;
						x.1 += 1;
					}
				}
				per.insert(id, gl);
			}
			branches.insert((race, cls), per);
		}
	}
	let mean = sums.into_iter().map(|(id, (s, n, q))| (id, GuideLevels { start: s / n as f64, q: q.into_iter().map(|(k, (v, m))| (k, v / m as f64)).collect() })).collect();
	Some((branches, mean))
}

/// The persona's levels as route_e2e.lua takes them: its own branch where the model has it, the faction's
/// mean for the guides it lacks.
fn persona_levels(model: &(HashMap<(String, String), HashMap<String, GuideLevels>>, HashMap<String, GuideLevels>), p: &Persona) -> Value {
	let (branches, mean) = model;
	let races: &[&str] = if p.race == "Scourge" { &["Scourge", "Undead"] } else { &[p.race] };
	let own = races.iter().find_map(|r| branches.get(&(r.to_string(), p.class.to_string())));
	let mut out = Map::new();
	for (id, m) in mean {
		let gl = own.and_then(|o| o.get(id)).unwrap_or(m);
		let q: Map<String, Value> = gl.q.iter().map(|(q, l)| (q.to_string(), json!((l * 100.0).round() / 100.0))).collect();
		out.insert(id.clone(), json!({ "s": (gl.start * 100.0).round() / 100.0, "q": q }));
	}
	Value::Object(out)
}

/// Each quest's objectives as the guides count them (route_e2e.lua E2E.objs): the largest count per
/// objective and the kind of the first goal pointing at it, as simulate.lua builds them per guide. A dungeon's
/// quest (taken in its pick-ups or worked in its run) that no goal counts gets one objective, so it is unfinished
/// until the run does it (its run's `complete`), as in the game; other quests keep none.
fn objectives(guides: &[Value], dsteps: &[DStep]) -> Value {
	let mut objs: BTreeMap<i64, BTreeMap<i64, (i64, &'static str)>> = BTreeMap::new();
	for d in dsteps.iter().filter(|d| d.role == "pickup" || d.role == "run") {
		for &q in &d.quests {
			objs.entry(q).or_default();
		}
	}
	for g in guides {
		for s in g["steps"].as_array().into_iter().flatten() {
			for x in s["goals"].as_array().into_iter().flatten() {
				let (Some(q), Some(oi)) = (x["quest"].as_i64(), x["oi"].as_i64()) else { continue };
				let kind = match x["t"].as_str().unwrap_or("") {
					"kill" | "talk" => "monster",
					"collect" => "item",
					"interact" => "object",
					_ => "event",
				};
				let e = objs.entry(q).or_default().entry(oi).or_insert((1, kind));
				e.0 = e.0.max(x["count"].as_i64().unwrap_or(1));
				if e.1 == "event" {
					e.1 = kind;
				}
			}
		}
	}
	let mut out = Map::new();
	for (q, list) in objs {
		let n = (*list.keys().max().unwrap_or(&0)).max(1);
		let arr: Vec<Value> = (1..=n).map(|i| list.get(&i).map_or(json!([1, "event"]), |(c, k)| json!([c, k]))).collect();
		out.insert(q.to_string(), Value::Array(arr));
	}
	Value::Object(out)
}

// ---------------------------------------------------------------------------------------------------------
// The walk to a run's door: the zones a straight line crosses (Nav/Danger.lua's mark on each)
// ---------------------------------------------------------------------------------------------------------

struct Geo {
	frames: HashMap<i64, [f64; 5]>, // map -> c, left, right, top, bottom
	names: HashMap<i64, String>,
	levels: HashMap<i64, f64>,
}

impl Geo {
	fn new(data: &forge_guide::data::Data) -> Geo {
		let mut frames = HashMap::new();
		for era in ["forever", "era"] {
			let f = plain(&data.map_frames.get(era));
			for (id, v) in f.as_object().into_iter().flatten() {
				let n = |k: &str| v[k].as_f64().unwrap_or(0.0);
				if let Ok(id) = id.parse() {
					frames.insert(id, [n("c"), n("left"), n("right"), n("top"), n("bottom")]);
				}
			}
		}
		let zones = plain(&data.zones);
		let names: HashMap<i64, String> = zones.as_object().into_iter().flatten().filter_map(|(id, z)| Some((id.parse().ok()?, z["name"].as_str()?.to_string()))).collect();
		Geo { frames, names, levels: zone_levels() }
	}

	fn world(&self, map: i64, x: f64, y: f64) -> Option<(f64, f64, f64)> {
		let f = self.frames.get(&map)?;
		Some((f[0], f[1] + (f[2] - f[1]) * x / 100.0, f[3] + (f[4] - f[3]) * y / 100.0))
	}

	/// Zones with a level range whose frame holds world point (c, wy, wx).
	fn zones_at(&self, c: f64, wy: f64, wx: f64) -> Vec<i64> {
		let mut out: Vec<i64> = self
			.levels
			.keys()
			.filter(|z| {
				self.frames.get(z).is_some_and(|f| {
					let x = (wy - f[1]) / (f[2] - f[1]) * 100.0;
					let y = (wx - f[3]) / (f[4] - f[3]) * 100.0;
					f[0] == c && (0.0..=100.0).contains(&x) && (0.0..=100.0).contains(&y)
				})
			})
			.copied()
			.collect();
		out.sort();
		out
	}

	/// The zones (name and lowest level) a straight walk from `from` to `to` crosses at points where every
	/// zone with levels is dangerous at `level`, the door's own zone included; the zone the walk starts in
	/// never counts (the route is there already).
	fn danger(&self, from: &Value, to: &Value, level: f64) -> Vec<String> {
		let pt = |v: &Value| Some((v[0].as_i64()?, v[1].as_f64()?, v[2].as_f64()?));
		let (Some(a), Some(b)) = (pt(from), pt(to)) else { return vec![] };
		let (Some(wa), Some(wb)) = (self.world(a.0, a.1, a.2), self.world(b.0, b.1, b.2)) else { return vec![] };
		if wa.0 != wb.0 {
			return vec![];
		}
		let len = ((wb.1 - wa.1).powi(2) + (wb.2 - wa.2).powi(2)).sqrt();
		let n = ((len / 100.0).ceil() as usize).max(1);
		let mut out = BTreeSet::new();
		for k in 0..=n {
			let t = k as f64 / n as f64;
			let zs: Vec<i64> = self.zones_at(wa.0, wa.1 + (wb.1 - wa.1) * t, wa.2 + (wb.2 - wa.2) * t);
			if zs.is_empty() || zs.contains(&a.0) {
				continue;
			}
			if zs.iter().all(|z| self.levels[z] >= level + DANGEROUS) {
				for z in zs {
					out.insert(format!("{} ({})", self.names.get(&z).cloned().unwrap_or_else(|| z.to_string()), self.levels[&z]));
				}
			}
		}
		out.into_iter().collect()
	}
}

// ---------------------------------------------------------------------------------------------------------
// Checks
// ---------------------------------------------------------------------------------------------------------

#[derive(Default)]
struct Outcome {
	fails: Vec<String>,
	/// The level model's pace (see the module's doc): reported, not failed.
	warns: Vec<String>,
	notes: Vec<String>,
}

impl Outcome {
	/// "pass", "pass, 2 WARN" or "3 FAIL" (bold in the table).
	fn verdict(&self, bold: bool) -> String {
		let b = if bold { "**" } else { "" };
		match (self.fails.len(), self.warns.len()) {
			(0, 0) => "pass".to_string(),
			(0, w) => format!("pass, {w} WARN"),
			(f, _) => format!("{b}{f} FAIL{b}"),
		}
	}
}

fn s<'a>(v: &'a Value, k: &str) -> &'a str {
	v[k].as_str().unwrap_or("")
}
fn n(v: &Value, k: &str) -> f64 {
	v[k].as_f64().unwrap_or(0.0)
}

fn events<'a>(r: &'a Value, e: &str) -> Vec<(usize, &'a Value)> {
	r["trace"].as_array().map(|t| t.iter().enumerate().filter(|(_, x)| x["e"] == e).collect()).unwrap_or_default()
}

/// The guides the route went through, in order.
fn guide_order(r: &Value) -> Vec<String> {
	let mut out: Vec<String> = Vec::new();
	for (_, e) in events(r, "live") {
		let g = s(e, "g");
		if out.last().map(|x| x.as_str()) != Some(g) {
			out.push(g.to_string());
		}
	}
	out
}

/// A step's place on the route: (the guide's place in `order`, its index); None off the route.
fn place(order: &[String], g: &str, s: usize) -> Option<(usize, usize)> {
	order.iter().position(|x| x == g).map(|i| (i, s))
}

fn dname(fl: &Floors, map: i64, fallback: &str) -> String {
	if fallback.is_empty() {
		fl.names.get(&map).cloned().unwrap_or_else(|| format!("map {map}"))
	} else {
		fallback.to_string()
	}
}

#[derive(Clone, Copy)]
struct Ctx<'a> {
	dsteps: &'a [DStep],
	floors: &'a Floors,
	geo: &'a Geo,
	modelled: bool,
}

/// What every scenario must hold: never stuck, never back, the log under the cap.
fn common(r: &Value, out: &mut Outcome) {
	for (_, e) in events(r, "city") {
		out.fails.push(format!("a city dungeon of the other faction ({} step {} \"{}\", map {}): {}", s(e, "g"), e["s"], s(e, "ti"), e["m"], s(e, "why")));
	}
	for (_, e) in events(r, "stuck") {
		out.fails.push(format!("stuck at {} step {} \"{}\": {}", s(e, "g"), e["s"], s(e, "ti"), s(e, "why")));
	}
	let mut last: Option<(String, i64)> = None;
	let mut left: BTreeSet<String> = BTreeSet::new();
	let trace = r["trace"].as_array().cloned().unwrap_or_default();
	let mut prev_live = 0;
	for (k, e) in events(r, "live") {
		let (g, i) = (s(e, "g").to_string(), e["s"].as_i64().unwrap_or(0));
		// The level a goal waited for, raised just before (the model's level rises at hand-ins only, a player's
		// all along): an earlier step's accept then comes, as the Engine brings a level-gated quest back.
		let waited = trace[prev_live..k].iter().any(|x| x["e"] == "lvl" && s(x, "why").starts_with("waits"));
		prev_live = k;
		if let Some((lg, li)) = &last {
			if *lg == g && i < *li && waited {
				out.notes.push(format!("{g}: back from step {li} to {i} \"{}\" once the level its accept waited for came", s(e, "ti")));
			} else if *lg == g && i < *li {
				out.fails.push(format!("the live step went back in {g}: step {li} -> {i} \"{}\"", s(e, "ti")));
			}
			if *lg != g {
				left.insert(lg.clone());
				if left.contains(&g) {
					out.fails.push(format!("{g} came back after the route left it (at step {i} \"{}\")", s(e, "ti")));
				}
			}
		}
		last = Some((g, i));
	}
	let max = r["maxLog"].as_u64().unwrap_or(0);
	if max > LOG_CAP {
		out.fails.push(format!("the quest log held {max} quests (the cap is {LOG_CAP})"));
	}
}

/// Skip: no dungeon step live, no dungeon quest taken; the same route as the solo compile's, step for step.
fn check_skip(r: &Value, solo: Option<&Value>, out: &mut Outcome) {
	for (_, e) in events(r, "live") {
		if matches!(s(e, "d"), "pickup" | "run" | "handin" | "other") {
			out.fails.push(format!("a dungeon step came with Skip: {} step {} \"{}\" ({})", s(e, "g"), e["s"], s(e, "ti"), s(e, "d")));
		}
	}
	for (_, e) in events(r, "acc") {
		if !e["m"].is_null() {
			out.fails.push(format!("a dungeon quest was taken with Skip: {} at {} step {}", e["q"], s(e, "g"), e["s"]));
		}
	}
	let Some(solo) = solo else { return };
	// A step's identity: its key (Party.StepKey) without the ".N" that tells apart steps of the same content in one
	// guide, as a dungeon's own copy of a stop (its run's flight) makes the solo one the second of two.
	let steps = |r: &Value| {
		events(r, "live")
			.into_iter()
			.map(|(_, e)| (s(e, "g").to_string(), s(e, "k").split('.').next().unwrap_or("").to_string(), e["n"].clone(), e["t"].clone(), e["h"] == true, s(e, "ti").to_string()))
			.collect::<Vec<_>>()
	};
	let (a, b) = (steps(r), steps(solo));
	if let Some(k) = (0..a.len().max(b.len())).find(|&k| a.get(k) != b.get(k)) {
		let at = |v: &Vec<(String, String, Value, Value, bool, String)>| {
			v.get(k).map_or("the route's end".to_string(), |x| format!("{} step {} of {}{} \"{}\"", x.0, x.2, x.3, if x.4 { " (hidden)" } else { "" }, x.5))
		};
		out.fails.push(format!("not the solo route: live step #{} is {}, the solo route's is {}", k + 1, at(&a), at(&b)));
	}
	let deeds =
		|r: &Value| r["trace"].as_array().into_iter().flatten().filter(|e| e["e"] == "acc" || e["e"] == "tin").map(|e| format!("{} {} in {}", s(e, "e"), e["q"], s(e, "g"))).collect::<Vec<_>>();
	let (a, b) = (deeds(r), deeds(solo));
	if let Some(k) = (0..a.len().max(b.len())).find(|&k| a.get(k) != b.get(k)) {
		out.fails.push(format!("not the solo route's quests: #{} is {}, the solo route's is {}", k + 1, a.get(k).map_or("none", |x| x.as_str()), b.get(k).map_or("none", |x| x.as_str())));
	}
	let ends = |r: &Value| r["ended"]["log"].as_array().map(|l| l.iter().map(|q| q["q"].clone()).collect::<Vec<_>>()).unwrap_or_default();
	if ends(r) != ends(solo) {
		out.fails.push(format!("the log at the end differs from the solo route's: {:?} against {:?}", ends(r), ends(solo)));
	}
}

/// The dungeons whose run steps are on the route this scenario went (its guides).
fn runs_on<'a>(ctx: &'a Ctx, order: &[String]) -> Vec<&'a DStep> {
	ctx.dsteps.iter().filter(|d| d.role == "run" && order.contains(&d.guide)).collect()
}

/// A run reached: its floor (when known, with the model's levels), its pick-ups before and hand-ins after,
/// the walk to its door.
fn check_runs(r: &Value, ctx: &Ctx, out: &mut Outcome) {
	let trace = r["trace"].as_array().cloned().unwrap_or_default();
	for (k, e) in events(r, "door") {
		let map = e["m"].as_i64().unwrap_or(0);
		let name = dname(ctx.floors, map, s(e, "name"));
		let level = n(e, "l");
		if ctx.modelled {
			if let Some((floor, src)) = ctx.floors.by_map.get(&map) {
				if level + 1e-9 < *floor {
					out.warns.push(format!("{name}'s run came at level {level:.2} by the level model, {:.2} under its floor {floor:.1} ({src}): {} step {}", floor - level, s(e, "g"), e["s"]));
				}
			}
			let crossed = ctx.geo.danger(&e["from"], &e["to"], level);
			if !crossed.is_empty() {
				out.fails.push(format!("the walk to {name}'s door at level {level:.2} crosses zones 4+ levels above: {}", crossed.join(", ")));
			}
		}
		// The run's own quests (those its goals work on): picked up before it, handed in after it. A quest the
		// dungeon's stop hands in to open them (the traitor's at Sentinel Hill) is no run quest.
		let run = ctx.dsteps.iter().find(|d| d.role == "run" && d.guide == s(e, "g") && Some(d.index as u64) == e["s"].as_u64());
		let quests: Vec<i64> = run.map(|d| d.quests.clone()).unwrap_or_default();
		for (j, x) in trace.iter().enumerate() {
			let Some(q) = x["q"].as_i64() else { continue };
			if !quests.contains(&q) {
				continue;
			}
			if x["e"] == "acc" && j > k {
				out.fails.push(format!("{name}: quest {q} picked up after its run ({} step {})", s(x, "g"), x["s"]));
			}
			if x["e"] == "tin" && j < k {
				out.fails.push(format!("{name}: quest {q} handed in before its run ({} step {})", s(x, "g"), x["s"]));
			}
		}
	}
}

fn reached(r: &Value, g: &str, i: usize) -> Option<usize> {
	events(r, "live").into_iter().find(|(_, e)| s(e, "g") == g && e["s"].as_u64() == Some(i as u64)).map(|(k, _)| k)
}

/// The level model's level where a dungeon step would have been (the first live step past it in its guide,
/// else the guide's last), with the dungeon's floor, when under it: the floor's gate holds the step.
fn under_floor(r: &Value, ctx: &Ctx, d: &DStep) -> Option<(f64, f64)> {
	let (floor, _) = ctx.floors.by_map.get(&d.map).filter(|_| ctx.modelled)?;
	let lives: Vec<&Value> = events(r, "live").into_iter().map(|(_, e)| e).filter(|e| s(e, "g") == d.guide).collect();
	let level = lives.iter().find(|e| e["s"].as_u64().is_some_and(|i| i as usize > d.index)).or(lives.last()).map(|e| n(e, "l"))?;
	(level + 1e-9 < *floor).then_some((level, *floor))
}

/// Run them: every run on the route comes; nothing of a dungeon is left in the log at the end.
fn check_run(r: &Value, ctx: &Ctx, out: &mut Outcome) {
	let order = guide_order(r);
	for d in runs_on(ctx, &order) {
		if reached(r, &d.guide, d.index).is_none() {
			let name = dname(ctx.floors, d.map, &d.name);
			let taken: Vec<String> = events(r, "acc").into_iter().filter(|(_, e)| e["m"].as_i64() == Some(d.map)).map(|(_, e)| e["q"].to_string()).collect();
			let what =
				format!("{name}'s run ({} step {} \"{}\") never came with Run them (its quests taken: {})", d.guide, d.index, d.title, if taken.is_empty() { "none".into() } else { taken.join(", ") });
			match under_floor(r, ctx, d) {
				Some((level, floor)) => out.warns.push(format!("{what}: the level model's {level:.2} there is under its floor {floor:.1}")),
				None => out.fails.push(what),
			}
		}
	}
	for q in r["ended"]["log"].as_array().into_iter().flatten() {
		if let Some(map) = q["m"].as_i64() {
			out.fails.push(format!("{} quest {} \"{}\" left in the log at the end{}", dname(ctx.floors, map, ""), q["q"], s(q, "title"), if q["ready"] == true { ", finished" } else { "" }));
		}
	}
}

/// Ask me: each dungeon asked once; Skip it keeps its steps away, Run it brings its run.
fn check_ask(r: &Value, ctx: &Ctx, from: usize, out: &mut Outcome) {
	let mut seen: HashMap<i64, usize> = HashMap::new();
	for (k, e) in events(r, "ask").into_iter().filter(|(k, _)| *k >= from) {
		let map = e["m"].as_i64().unwrap_or(0);
		let name = dname(ctx.floors, map, s(e, "name"));
		*seen.entry(map).or_default() += 1;
		if seen[&map] == 2 {
			out.fails.push(format!("{name} was asked about again ({} step {})", s(e, "g"), e["s"]));
		}
		if seen[&map] > 1 {
			continue;
		}
		let later = r["trace"].as_array().map(|t| &t[k + 1..]).unwrap_or_default();
		if e["a"] == false {
			if let Some(x) = later.iter().find(|x| x["e"] == "live" && x["m"].as_i64() == Some(map) && matches!(s(x, "d"), "pickup" | "run")) {
				out.fails.push(format!("{name}: answered Skip it, yet {} step {} \"{}\" ({}) came", s(x, "g"), x["s"], s(x, "ti"), s(x, "d")));
			}
		} else if !later.iter().any(|x| x["e"] == "door" && x["m"].as_i64() == Some(map)) {
			let what = format!("{name}: answered Run it at {} step {}, its run never came", s(e, "g"), e["s"]);
			let order = guide_order(r);
			let run = runs_on(ctx, &order).into_iter().find(|d| d.map == map);
			match run.and_then(|d| under_floor(r, ctx, d)) {
				Some((level, floor)) => out.warns.push(format!("{what}: the level model's {level:.2} at its run is under its floor {floor:.1}")),
				None => out.fails.push(what),
			}
		}
	}
}

/// A switch mid-route: never back; no dungeon whose run the route passed comes back; the first dungeon wholly
/// ahead is offered; off at a door: the run dropped, its quests kept and handled.
fn check_switches(r: &Value, ctx: &Ctx, kind: Kind, out: &mut Outcome) {
	let order = guide_order(r);
	let trace = r["trace"].as_array().cloned().unwrap_or_default();
	let sws = events(r, "sw");
	for (_, e) in &sws {
		let (g0, s0, g1) = (s(e, "g0"), e["s0"].as_u64().unwrap_or(0) as usize, s(e, "g1"));
		if let (Some(a), Some(b)) = (place(&order, g0, s0), e["s1"].as_u64().and_then(|s1| place(&order, g1, s1 as usize))) {
			if b < a {
				out.fails.push(format!("turning dungeons to {} moved the live step back: {g0} step {s0} -> {g1} step {}", s(e, "set"), e["s1"]));
			}
		}
	}
	let Some(&(k_on, on)) = sws.first() else {
		out.fails.push("the switch never happened (the route ended first?)".into());
		return;
	};
	let Some(at) = place(&order, s(on, "g0"), on["s0"].as_u64().unwrap_or(0) as usize) else { return };
	// The dungeons by their run's place on the route, and where their pick-ups are.
	let mut dungeons: BTreeMap<(usize, usize), (i64, String, Vec<(usize, usize)>)> = BTreeMap::new();
	for d in ctx.dsteps.iter().filter(|d| d.role == "run") {
		if let Some(pl) = place(&order, &d.guide, d.index) {
			let picks: Vec<(usize, usize)> = ctx.dsteps.iter().filter(|x| x.map == d.map && x.role == "pickup").filter_map(|x| place(&order, &x.guide, x.index)).collect();
			dungeons.insert(pl, (d.map, dname(ctx.floors, d.map, &d.name), picks));
		}
	}
	// Until the next switch (off at a door): what the first one turned on.
	let k_off = sws.get(1).map_or(trace.len(), |(k, _)| *k);
	let off_at = sws.get(1).and_then(|(_, x)| place(&order, s(x, "g0"), x["s0"].as_u64().unwrap_or(0) as usize));
	let after = &trace[k_on + 1..];
	// Passed: its run behind the switch; none of its steps may come after it.
	for (pl, (map, name, _)) in dungeons.iter().filter(|(pl, _)| **pl < at) {
		if let Some(x) = after.iter().find(|x| x["e"] == "live" && x["m"].as_i64() == Some(*map) && s(x, "d") != "solo") {
			out.fails.push(format!("{name}'s run was behind the switch ({} step {}), yet {} step {} \"{}\" came", order[pl.0], pl.1, s(x, "g"), x["s"], s(x, "ti")));
		}
	}
	// The first dungeon wholly ahead (its pick-ups and run after the switch) is offered.
	let first = dungeons.iter().find(|(pl, (_, _, picks))| **pl > at && picks.iter().all(|p| *p > at));
	let before_off = |pl: &(usize, usize), picks: &Vec<(usize, usize)>| off_at.is_none_or(|off| picks.iter().chain(std::iter::once(pl)).min().is_some_and(|p| *p < off));
	if let Some((pl, (map, name, _))) = first.filter(|(pl, (_, _, picks))| before_off(pl, picks)) {
		let offered = trace[k_on + 1..k_off].iter().any(|x| (x["e"] == "ask" || x["e"] == "door" || (x["e"] == "live" && matches!(s(x, "d"), "pickup" | "run"))) && x["m"].as_i64() == Some(*map));
		let under = ctx.modelled
			&& ctx.floors.by_map.get(map).is_some_and(|(f, _)| after.iter().filter(|x| x["e"] == "live" && s(x, "g") == order[pl.0]).map(|x| n(x, "l")).next().is_some_and(|l| l + 1e-9 < *f));
		if !offered && !under {
			out.fails.push(format!("{name}, wholly ahead of the switch at {} step {} (its run at {} step {}), was not offered", s(on, "g0"), on["s0"], order[pl.0], pl.1));
		} else if !offered {
			out.notes.push(format!("{name}, ahead of the switch, was not offered: the route reaches it under its floor"));
		}
	} else if let Some((_, (_, name, _))) = first {
		out.notes.push(format!("{name}, the first dungeon wholly ahead of the switch, comes after dungeons were turned off again"));
	} else {
		out.notes.push("no dungeon wholly ahead of the switch".into());
	}
	if let Kind::MidRun(_) = kind {
		for (k, e) in events(r, "offrun") {
			let map = e["m"].as_i64().unwrap_or(0);
			let name = dname(ctx.floors, map, "");
			// The off switch's own record: what the run's quests were then.
			let Some(sw) = trace[..k].iter().rev().find(|x| x["e"] == "sw") else { continue };
			for q in sw["kept"].as_array().into_iter().flatten() {
				let id = q["q"].as_i64().unwrap_or(0);
				let later = &trace[k..];
				if later.iter().any(|x| x["e"] == "abn" && x["q"].as_i64() == Some(id)) {
					out.fails.push(format!("{name}: quest {id} was abandoned after turning dungeons off"));
				}
				let handed = later.iter().any(|x| x["e"] == "tin" && x["q"].as_i64() == Some(id));
				if q["ready"] == true && !handed {
					out.fails.push(format!("{name}: quest {id}, finished in the run, is never handed in after turning dungeons off (route plan: {})", s(q, "st")));
				} else if q["ready"] != true && !handed && q["un"] == false {
					out.fails.push(format!("{name}: quest {id}, kept after turning dungeons off, has no hand-in ahead and is not listed as room to make (route plan: {})", s(q, "st")));
				} else if !handed && q["un"] == "unknown" {
					out.notes.push(format!("{name}: quest {id} kept after turning dungeons off; the route plan could not say then (a route choice ahead)"));
				} else if !handed {
					out.notes.push(format!("{name}: quest {id} kept after turning dungeons off; the quest room lists it as room to make ({})", q["un"]));
				}
			}
		}
	}
}

/// The dungeon steps of the guides a scenario played, as the engine numbered them (route_e2e.lua's "dstep"
/// events: the pack's guides, where a writer pass may split a step, so the compile's own numbers can differ).
fn played_dungeon_steps(r: &Value) -> Vec<DStep> {
	let role = |x: &str| match x {
		"pickup" => "pickup",
		"run" => "run",
		"handin" => "handin",
		_ => "other",
	};
	events(r, "dstep")
		.into_iter()
		.map(|(_, e)| DStep {
			guide: s(e, "g").to_string(),
			index: e["s"].as_u64().unwrap_or(0) as usize,
			role: role(s(e, "role")),
			map: e["m"].as_i64().unwrap_or(0),
			name: s(e, "name").to_string(),
			title: s(e, "ti").to_string(),
			quests: e["qs"].as_array().into_iter().flatten().filter_map(|q| q.as_i64()).collect(),
		})
		.collect()
}

/// The quest style: under "way" no every-quest step (`when dungeon "<X>" all`) comes; under "all" those that came
/// are counted.
fn check_style(sc: &Scenario, r: &Value, out: &mut Outcome) {
	let all: Vec<&Value> = events(r, "live").into_iter().map(|(_, e)| e).filter(|e| e["da"] == true).collect();
	if sc.style == "way" {
		for e in &all {
			out.fails.push(format!("an every-quest step came with only the quests on the way: {} step {} \"{}\"", s(e, "g"), e["s"], s(e, "ti")));
		}
	} else if !matches!(sc.kind, Kind::Solo | Kind::Skip) {
		out.notes.push(format!("{} every-quest steps came", all.len()));
	}
}

fn check(sc: &Scenario, r: &Value, solo: Option<&Value>, ctx: &Ctx) -> Outcome {
	let played = played_dungeon_steps(r);
	let ctx = &Ctx { dsteps: if played.is_empty() { ctx.dsteps } else { &played }, ..*ctx };
	let mut out = Outcome::default();
	common(r, &mut out);
	check_style(sc, r, &mut out);
	match sc.kind {
		Kind::Solo => {}
		Kind::Skip => check_skip(r, solo, &mut out),
		Kind::Run => {
			check_runs(r, ctx, &mut out);
			check_run(r, ctx, &mut out);
		}
		Kind::Ask => {
			check_runs(r, ctx, &mut out);
			check_ask(r, ctx, 0, &mut out);
		}
		Kind::MidRun(_) | Kind::MidAsk(_) => {
			check_runs(r, ctx, &mut out);
			check_switches(r, ctx, sc.kind, &mut out);
			if let Kind::MidAsk(_) = sc.kind {
				let from = events(r, "sw").first().map_or(0, |(k, _)| *k);
				check_ask(r, ctx, from, &mut out);
			}
		}
	}
	out
}

// ---------------------------------------------------------------------------------------------------------
// The report
// ---------------------------------------------------------------------------------------------------------

fn summary(sc: &Scenario, r: &Value, o: &Outcome, ctx: &Ctx) -> String {
	let p = &PERSONAS[sc.persona];
	let mut md = String::new();
	let _ = writeln!(md, "### {}: {} {} {}, {} ({})\n", sc.name, p.faction, p.race, p.class, sc.styled_label(), o.verdict(false));
	let lives = events(r, "live");
	let ended = &r["ended"];
	let _ = writeln!(
		md,
		"Route: {} steps live over {} guides, ended in {} at level {} with {} quests in the log (the most at once: {}).\n",
		lives.len(),
		guide_order(r).len(),
		s(ended, "guide"),
		ended["level"],
		ended["log"].as_array().map_or(0, |l| l.len()),
		r["maxLog"]
	);
	let mut per: Vec<(String, f64, f64, usize)> = Vec::new();
	for (_, e) in &lives {
		let g = s(e, "g");
		if per.last().map(|x| x.0.as_str()) != Some(g) {
			per.push((g.to_string(), n(e, "l"), n(e, "l"), 0));
		}
		let last = per.last_mut().unwrap();
		last.2 = n(e, "l");
		last.3 += 1;
	}
	let _ = writeln!(md, "<details><summary>Guides</summary>\n");
	for (g, a, b, k) in &per {
		let _ = writeln!(md, "- {g}: {k} steps, level {a:.1} to {b:.1}");
	}
	let _ = writeln!(md, "\n</details>\n");
	let trace = r["trace"].as_array().cloned().unwrap_or_default();
	let mut lines = Vec::new();
	for e in &trace {
		let map = e["m"].as_i64();
		let name = map.map(|m| dname(ctx.floors, m, s(e, "name"))).unwrap_or_default();
		match s(e, "e") {
			"ask" => lines.push(format!("asked about {name} at {} step {} (level {}): {}", s(e, "g"), e["s"], e["l"], if e["a"] == true { "Run it" } else { "Skip it" })),
			"acc" if map.is_some() => lines.push(format!("{name}: picked up {} at {} step {} (level {})", e["q"], s(e, "g"), e["s"], e["l"])),
			"door" => {
				let floor = map.and_then(|m| ctx.floors.by_map.get(&m)).map_or("no floor known".to_string(), |(f, src)| format!("floor {f:.1}, {src}"));
				lines.push(format!("{name}: **run** at {} step {} (level {}; {floor})", s(e, "g"), e["s"], e["l"]))
			}
			"tin" if map.is_some() => lines.push(format!("{name}: handed in {} at {} step {} (level {})", e["q"], s(e, "g"), e["s"], e["l"])),
			"sw" => lines.push(format!(
				"**dungeons set to {}** at level {} ({} step {} -> {} step {}){}",
				s(e, "set"),
				e["l"],
				s(e, "g0"),
				e["s0"],
				s(e, "g1"),
				e["s1"],
				if e["why"].is_string() { format!(", {}", s(e, "why")) } else { String::new() }
			)),
			"offrun" => lines.push(format!("{name}: turned off at the door, {}", if e["did"] == true { "one quest done" } else { "nothing done yet" })),
			_ => {}
		}
	}
	if !lines.is_empty() {
		let _ = writeln!(md, "Dungeons on the way:\n");
		for l in lines {
			let _ = writeln!(md, "- {l}");
		}
		let _ = writeln!(md);
	} else if sc.kind != Kind::Solo {
		let _ = writeln!(md, "Dungeons on the way: none.\n");
	}
	let left: Vec<String> = ended["log"].as_array().into_iter().flatten().map(|q| format!("{} {}{}", q["q"], s(q, "title"), if q["ready"] == true { " (finished)" } else { "" })).collect();
	if !left.is_empty() {
		let _ = writeln!(md, "In the log at the end: {}.\n", left.join(", "));
	}
	if !o.fails.is_empty() || !o.warns.is_empty() || !o.notes.is_empty() {
		let _ = writeln!(md, "Anomalies:\n");
		for f in &o.fails {
			let _ = writeln!(md, "- FAIL {f}");
		}
		for f in &o.warns {
			let _ = writeln!(md, "- WARN {f}");
		}
		for f in &o.notes {
			let _ = writeln!(md, "- note: {f}");
		}
		let _ = writeln!(md);
	}
	md
}

// ---------------------------------------------------------------------------------------------------------
// The test
// ---------------------------------------------------------------------------------------------------------

fn maps_lua(data: &forge_guide::data::Data) -> String {
	let mut maps = String::new();
	for era in ["forever", "era"] {
		let frames = plain(&data.map_frames.get(era));
		for (id, f) in frames.as_object().into_iter().flatten() {
			let name = plain(&data.zones.get(id))["name"].as_str().unwrap_or("").to_string();
			let _ = writeln!(
				maps,
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})",
				serde_json::to_string(&name).unwrap(),
				f["c"],
				f["left"],
				f["right"],
				f["top"],
				f["bottom"]
			);
		}
	}
	maps
}

fn loads_of(pack: &forge_addontest::dsl::TestPack) -> String {
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	format!("do local ns = {{}}\n{}\nend", lines.join("\n"))
}

fn scenarios() -> Vec<Scenario> {
	let mut out = Vec::new();
	let tag = |p: &Persona| format!("{}-{}", p.race.to_lowercase(), p.class.to_lowercase());
	let styles = styles();
	let suffix = |style: &str| if style == "way" { "-way" } else { "" };
	for (i, p) in PERSONAS.iter().enumerate() {
		for (kind, mode) in [(Kind::Solo, "solo"), (Kind::Skip, "skip")] {
			out.push(Scenario { name: format!("{}/{}/{mode}", p.faction.to_lowercase(), tag(p)), persona: i, kind, style: "all" });
		}
		for &style in &styles {
			for (kind, mode) in [(Kind::Run, "run"), (Kind::Ask, "ask")] {
				out.push(Scenario { name: format!("{}/{}/{mode}{}", p.faction.to_lowercase(), tag(p), suffix(style)), persona: i, kind, style });
			}
		}
	}
	for f in ["Alliance", "Horde"] {
		let i = PERSONAS.iter().position(|p| p.faction == f).unwrap();
		for &style in &styles {
			for &l in SWITCH_AT {
				let t = tag(&PERSONAS[i]);
				out.push(Scenario { name: format!("{}/{t}/on-at-{l}{}", f.to_lowercase(), suffix(style)), persona: i, kind: Kind::MidRun(l), style });
				out.push(Scenario { name: format!("{}/{t}/ask-at-{l}{}", f.to_lowercase(), suffix(style)), persona: i, kind: Kind::MidAsk(l), style });
			}
		}
	}
	out
}

fn e2e_table(sc: &Scenario, levels: Option<&Value>) -> Value {
	let p = &PERSONAS[sc.persona];
	let (mode, switches) = match sc.kind {
		Kind::Solo | Kind::Skip => ("skip", json!([])),
		Kind::Run => ("run", json!([])),
		Kind::Ask => ("ask", json!([])),
		Kind::MidRun(l) => ("skip", json!([{ "level": l, "set": "run", "offAtRun": true, "why": "on mid-route" }])),
		Kind::MidAsk(l) => ("skip", json!([{ "level": l, "set": "ask", "why": "Ask me mid-route" }])),
	};
	json!({ "start": p.start, "mode": mode, "style": sc.style, "ask": "alternate", "switches": switches, "levels": levels.cloned().unwrap_or(Value::Null), "maxIter": 150000 })
}

#[test]
#[ignore = "release gate: the whole route 1-60 about 70 times; cargo test ... -- --ignored dungeons_e2e"]
fn dungeons_in_the_route_end_to_end_on_the_shipped_guides() {
	let data_dir = root().join("data/forever");
	if !data_dir.join("quests.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let dir = root().join("guides");
	let files = find_guide_files(&dir, false);
	let texts: Vec<(String, String)> = files.iter().map(|f| (format!("guides/{f}"), std::fs::read_to_string(dir.join(f)).unwrap())).collect();
	let solo_texts: Vec<(String, String)> = texts.iter().map(|(f, t)| (f.clone(), solo_text(t))).collect();
	let sources: Vec<(&str, &str)> = texts.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let solo_sources: Vec<(&str, &str)> = solo_texts.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let real = compile_with(&sources, &data, None);
	let solo = compile_with(&solo_sources, &data, None);
	let real_v: Vec<Value> = real.guides.iter().map(plain).collect();
	let solo_v: Vec<Value> = solo.guides.iter().map(plain).collect();
	let mut fails = static_diffs(&real_v, &solo_v);
	let mut warns: Vec<String> = Vec::new();
	let real_pack = write_test_pack(&real.guides, &data, &our_manifest());
	let solo_pack = write_test_pack(&solo.guides, &data, &our_manifest());
	let (real_loads, solo_loads) = (loads_of(&real_pack), loads_of(&solo_pack));
	let maps = maps_lua(&data);
	let dsteps = dungeon_steps(&real_v);
	let objs = format!("E2E_OBJS = {}\n", lua_value(&objectives(&real_v, &dsteps)));
	let driver = std::fs::read_to_string(root().join("tests/lua/route_e2e.lua")).expect("tests/lua/route_e2e.lua");
	let model = model_levels();
	let fl = floors(&data_dir);
	let geo = Geo::new(&data);
	let only = std::env::var("DUNGEONS_E2E_ONLY").ok();
	let wanted: Vec<Scenario> = scenarios().into_iter().filter(|sc| only.as_ref().is_none_or(|o| sc.name.contains(o.as_str()))).collect();
	// A Skip scenario is compared with its persona's solo run: play that too.
	let list: Vec<Scenario> =
		scenarios().into_iter().filter(|sc| wanted.iter().any(|w| w.name == sc.name) || (sc.kind == Kind::Solo && wanted.iter().any(|w| w.kind == Kind::Skip && w.persona == sc.persona))).collect();
	let jobs: Vec<(String, String)> = list
		.iter()
		.map(|sc| {
			let p = &PERSONAS[sc.persona];
			let levels = model.as_ref().map(|m| persona_levels(m, p));
			let start = real_v
				.iter()
				.find(|g| g["id"] == p.start)
				.and_then(|g| g["steps"].as_array()?.iter().flat_map(|st| st["goals"].as_array().into_iter().flatten()).find(|x| x["map"].is_number() && x["x"].is_number()).cloned());
			let class_id = CLASS_IDS.iter().find(|(c, _)| *c == p.class).map_or(1, |(_, id)| *id);
			let race_name = if p.race == "Scourge" {
				"Undead"
			} else if p.race == "NightElf" {
				"Night Elf"
			} else {
				p.race
			};
			let before = format!(
				"local w = stub.world\n{maps}w.race, w.raceName = {:?}, {race_name:?}\nw.class, w.className, w.classID = {:?}, {:?}, {class_id}\nw.faction = {:?}\nw.level = 1\n{}\n",
				p.race,
				p.class,
				p.class,
				p.faction,
				start.map(|x| format!("w.moveTo({}, {}, {})", x["map"], x["x"], x["y"])).unwrap_or_default()
			);
			let loads = if sc.kind == Kind::Solo { &solo_loads } else { &real_loads };
			let script = format!("{loads}\n{objs}E2E = {}\nE2E.objs = E2E_OBJS\n{driver}", lua_value(&e2e_table(sc, levels.as_ref())));
			(before, script)
		})
		.collect();
	let threads = std::env::var("DUNGEONS_E2E_THREADS").ok().and_then(|t| t.parse().ok()).unwrap_or_else(|| std::thread::available_parallelism().map_or(4, |n| n.get()));
	let next = std::sync::atomic::AtomicUsize::new(0);
	let started = std::time::Instant::now();
	let mut results: Vec<(usize, Result<Value, String>, f64)> = std::thread::scope(|scope| {
		let workers: Vec<_> = (0..threads)
			.map(|_| {
				scope.spawn(|| {
					let mut done = Vec::new();
					loop {
						let i = next.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
						let Some((before, script)) = jobs.get(i) else { break };
						let t0 = std::time::Instant::now();
						let out = run_addon(&RunAddon { stubs: vec!["stub_world.lua"], before: before.clone(), addons: vec![Addon::name("Polestar")], script: script.clone(), ..Default::default() });
						let secs = t0.elapsed().as_secs_f64();
						eprintln!("played {} in {secs:.0} s", list[i].name);
						done.push((i, out.and_then(|v| v.into_iter().next().ok_or_else(|| "nothing emitted".to_string())), secs));
					}
					done
				})
			})
			.collect();
		workers.into_iter().flat_map(|w| w.join().unwrap()).collect()
	});
	results.sort_by_key(|r| r.0);
	let ctx = Ctx { dsteps: &dsteps, floors: &fl, geo: &geo, modelled: model.is_some() };
	let by_name: HashMap<&str, &Value> = results.iter().filter_map(|(i, r, _)| r.as_ref().ok().map(|v| (list[*i].name.as_str(), v))).collect();
	let mut rows = Vec::new();
	let mut md = String::new();
	let mut table = String::new();
	let mut traces = Map::new();
	for (i, r, secs) in &results {
		let sc = &list[*i];
		if !wanted.iter().any(|w| w.name == sc.name) {
			continue;
		}
		match r {
			Err(e) => {
				let line = format!("FAIL  {}: the play stopped: {}", sc.name, e.lines().next().unwrap_or(""));
				fails.push(line.clone());
				rows.push(line);
				let _ = writeln!(table, "| {} | {} | error |", sc.name, sc.styled_label());
			}
			Ok(v) => {
				let solo = if sc.kind == Kind::Skip { by_name.get(sc.name.replace("/skip", "/solo").as_str()).copied() } else { None };
				let o = check(sc, v, solo, &ctx);
				for f in &o.fails {
					fails.push(format!("FAIL  {}: {f}", sc.name));
				}
				for f in &o.warns {
					warns.push(format!("WARN  {}: {f}", sc.name));
				}
				rows.push(if o.fails.is_empty() {
					format!("ok    {} ({secs:.0} s){}", sc.name, if o.warns.is_empty() { String::new() } else { format!(", {} WARN", o.warns.len()) })
				} else {
					format!("FAIL  {}: {} findings", sc.name, o.fails.len())
				});
				let _ = writeln!(table, "| {} | {} | {} |", sc.name, sc.styled_label(), o.verdict(true));
				md.push_str(&summary(sc, v, &o, &ctx));
				traces.insert(sc.name.clone(), v.clone());
			}
		}
	}
	let out_dir = std::env::var("DUNGEONS_E2E_OUT").map(PathBuf::from).unwrap_or_else(|_| std::env::temp_dir());
	let _ = std::fs::create_dir_all(&out_dir);
	let statics: Vec<&String> = fails.iter().filter(|f| f.starts_with("FAIL static")).collect();
	let head = format!(
		"# Dungeons in the route, end to end\n\n{} scenarios on the shipped guides, {:.0} min. Levels: {}. Floors: {} dungeons known ({}).\n\nCompiled with and without the dungeon steps: {}.\n\n| scenario | dungeons | verdict |\n|---|---|---|\n{table}\n",
		results.len(),
		started.elapsed().as_secs_f64() / 60.0,
		if model.is_some() { "the calibrated level model (DUNGEONS_E2E_LEVELS)" } else { "no level model: only goals waiting for a level raise it, the floor and door checks are left out" },
		fl.by_map.len(),
		fl.by_map.values().map(|(_, s)| s.as_str()).collect::<BTreeSet<_>>().into_iter().collect::<Vec<_>>().join(", "),
		if statics.is_empty() { "the solo route's steps are unchanged in every guide".to_string() } else { statics.iter().map(|f| f.trim_start_matches("FAIL static ").to_string()).collect::<Vec<_>>().join("; ") }
	);
	let _ = std::fs::write(out_dir.join("polestar-dungeons-e2e.md"), format!("{head}{md}"));
	let _ = std::fs::write(out_dir.join("polestar-dungeons-e2e.json"), serde_json::to_string(&Value::Object(traces)).unwrap());
	let report = [rows.join("\n"), fails.join("\n"), warns.join("\n")].join("\n");
	let _ = std::fs::write(out_dir.join("polestar-dungeons-e2e.txt"), &report);
	eprintln!("{report}");
	assert!(fails.is_empty(), "{} findings (polestar-dungeons-e2e.txt in {})", fails.len(), out_dir.display());
}

#[test]
fn dungeons_e2e_the_solo_text_leaves_out_every_dungeon_step_and_keeps_the_solo_way() {
	let text = "guide x\n\nstep A\n  accept 1\n\nstep Run\n  when dungeon \"The Deadmines\"\n  when onquest 166\n  enter \"The Deadmines\" @42.5,71.7\n\n# a comment\nstep Solo way\n  when !dungeon \"The Deadmines\"\n  turnin 155\nstep B\n  turnin 1\n";
	assert_eq!(solo_text(text), "guide x\n\nstep A\n  accept 1\n\n# a comment\nstep Solo way\n  turnin 155\nstep B\n  turnin 1\n");
	let steps = vec![json!({ "title": "Run", "when": [{ "k": "dungeon", "map": 36 }], "goals": [] }), json!({ "title": "Way", "when": [{ "k": "dungeon", "map": 36, "neg": true }], "goals": [] })];
	assert_eq!(without_dungeons(&steps), vec![json!({ "title": "Way", "goals": [] })]);
}
