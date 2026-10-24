//! Engine parity: Orc and Human Warrior leveling chains replayed from their first guide through `next` to
//! the end by the Rust engine and by the real addon on the stub world (tests/js/engine-chain.js:
//! playtest.js's SIMULATE with a recorder, lua5.1). The same goals must complete in the same order, with
//! the same ticks, stucks (each skipped, so the whole chain plays) and missing locations. Small fixture
//! guides pin `skipto`, `when`, `only` and `along` the same way.
//!
//! Default: rust/tests/golden/engine (its README and regen.sh): the clean guide slice (common::clean_slice)
//! and the fixtures on the data slice. Optional extra on a full checkout ($POLESTAR_CHECKOUT): the shipped
//! chains, the v2 slice ($POLESTAR_JSREF/repaired) and the fixtures on its data; skipped with a note when
//! the guides, the data, node or lua5.1 are absent. Their JS reference is cached in rust/target/judge-ref/
//! (POLESTAR_REF_REFRESH=1 rebuilds it).

use crate::common;

use forge_guide::data::load_data;
use forge_guide::diag::Diagnostics;
use forge_guide::project::{compile_sources, CompileOpts, Source};
use forge_judge::engine::{self, Character, Event, OnStuck, Replay, WorldData};
use serde_json::Value;
use std::path::{Path, PathBuf};
use std::process::Command;
use std::time::Instant;

/// A full Polestar checkout with built data/forever ($POLESTAR_CHECKOUT): its guides and data.
fn checkout() -> Option<PathBuf> {
	std::env::var_os("POLESTAR_CHECKOUT").map(PathBuf::from)
}

fn data() -> PathBuf {
	checkout().expect("POLESTAR_CHECKOUT").join("data/forever")
}

fn crate_dir() -> PathBuf {
	PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn ref_dir() -> PathBuf {
	crate_dir().join("../../target/judge-ref")
}

fn have_tools() -> bool {
	let ok = |c: &str| Command::new(c).arg("-v").output().is_ok();
	ok("node") && Command::new("lua5.1").arg("-v").output().is_ok()
}

/// The JS reference for a chain (cached): { files, trace, level, ms, luaMs }.
fn reference(name: &str, root: &Path, first: &str, race: &str, faction: &str, class: &str) -> Value {
	let out = ref_dir().join(format!("engine-{name}.json"));
	if !out.exists() || std::env::var_os("POLESTAR_REF_REFRESH").is_some() {
		assert!(have_tools(), "engine parity for {name} needs node and lua5.1 on PATH");
		let script = crate_dir().join("tests/js/engine-chain.js");
		let st = Command::new("node").arg(&script).args([root.to_str().unwrap(), first, race, faction, class, data().to_str().unwrap(), out.to_str().unwrap(), "skip"]).status().expect("node runs");
		assert!(st.success(), "engine-chain.js failed for {name}");
	}
	serde_json::from_str(&std::fs::read_to_string(&out).unwrap()).unwrap()
}

fn num(v: &Value, k: &str) -> Option<u64> {
	v.get(k).and_then(Value::as_u64)
}

fn text(v: &Value, k: &str) -> Option<String> {
	v.get(k).and_then(Value::as_str).map(str::to_string)
}

/// The JS trace as engine events.
fn events_of(trace: &Value) -> Vec<Event> {
	let mut out = Vec::new();
	for e in trace.as_array().unwrap() {
		let k = e["k"].as_str().unwrap();
		out.push(match k {
			"login" => Event::Login { guide: text(e, "id").unwrap_or_default() },
			"guide" => Event::Guide { guide: text(e, "id").unwrap() },
			"goal" => Event::Goal {
				guide: text(e, "g").unwrap(),
				step: num(e, "s").unwrap() as usize,
				goal: num(e, "i").unwrap() as usize,
				verb: text(e, "t").unwrap(),
				id: num(e, "id").map(|n| n as u32),
				ticked: e.get("m").and_then(Value::as_bool).unwrap_or(false),
			},
			"stuck" => Event::Stuck {
				guide: text(e, "g").unwrap(),
				step: num(e, "s").unwrap() as usize,
				goal: num(e, "i").map(|n| n as usize),
				verb: text(e, "t"),
				status: text(e, "status"),
				why: text(e, "why"),
			},
			"missing" => {
				Event::Missing { guide: text(e, "g").unwrap(), goals: e["list"].as_array().unwrap().iter().map(|p| (p[0].as_u64().unwrap() as usize, p[1].as_u64().unwrap() as usize)).collect() }
			}
			other => panic!("unknown trace entry {other}"),
		});
	}
	out
}

/// Compile the chain's files (as the JS compiled them) and replay it; -> events, compile ms, replay ms.
fn replay(root: &Path, data_dir: &Path, files: &[String], first_id: &str, race: &str, faction: &str, class: &str, on_stuck: OnStuck) -> (Vec<Event>, u128, u128) {
	let data = load_data(data_dir).expect("data");
	let t0 = Instant::now();
	let sources: Vec<Source> = files
		.iter()
		.map(|rel| {
			let file = format!("guides/{rel}");
			Source { source: file.clone(), file, text: std::fs::read_to_string(root.join(rel)).unwrap() }
		})
		.collect();
	let mut diag = Diagnostics::new();
	let compiled = compile_sources(&sources, &data, &mut diag, &CompileOpts { pack: None, author: None, context: None, pack_dir: None });
	let guides: Vec<engine::Guide> = compiled.guides.iter().map(engine::Guide::read).collect();
	let world = WorldData::from_data(&data);
	let compile_ms = t0.elapsed().as_millis();
	let t1 = Instant::now();
	let first = guides.iter().find(|g| g.id == first_id).expect("first guide");
	let character = Character::new(faction, race, class, engine::start_level(first));
	let events = Replay::new(&guides, &world, character).play(first_id, on_stuck).unwrap();
	(events, compile_ms, t1.elapsed().as_millis())
}

fn first_diff(a: &[Event], b: &[Event]) -> Option<usize> {
	(0..a.len().max(b.len())).find(|&i| a.get(i) != b.get(i))
}

fn check_chain(name: &str, root: &Path, first: &str, race: &str, faction: &str, class: &str) {
	let Some(checkout) = checkout() else {
		eprintln!("note: POLESTAR_CHECKOUT unset: engine parity for {name} skipped");
		return;
	};
	if !root.join(first).exists() || !checkout.join("data/forever").exists() {
		eprintln!("note: {} or POLESTAR_CHECKOUT's data/forever absent (v2 chains read POLESTAR_JSREF/repaired): engine parity for {name} skipped", root.join(first).display());
		return;
	}
	let js = reference(name, root, first, race, faction, class);
	compare_chain(name, root, &data(), &js, race, faction, class);
}

/// A JS reference (engine-chain.js output) against the Rust replay of the same files.
fn compare_chain(name: &str, root: &Path, data_dir: &Path, js: &Value, race: &str, faction: &str, class: &str) {
	let files: Vec<String> = js["files"].as_array().unwrap().iter().map(|f| f.as_str().unwrap().to_string()).collect();
	let want = events_of(&js["trace"]);
	let first_id = match &want[1] {
		Event::Guide { guide } => guide.clone(),
		e => panic!("trace starts with {e:?}"),
	};
	if let Event::Login { guide } = &want[0] {
		assert_eq!(guide, &first_id, "{name}: the login opened another guide than the start");
	}
	let (got, compile_ms, play_ms) = replay(root, data_dir, &files, &first_id, race, faction, class, OnStuck::Skip);
	let goals = want.iter().filter(|e| matches!(e, Event::Goal { .. })).count();
	let stucks = want.iter().filter(|e| matches!(e, Event::Stuck { .. })).count();
	eprintln!("engine parity {name}: {} guides, {goals} goals, {stucks} stuck; JS {} ms (Lua play {} ms), Rust compile {compile_ms} ms + replay {play_ms} ms", files.len(), js["ms"], js["luaMs"]);
	if let Some(i) = first_diff(&want, &got) {
		let lo = i.saturating_sub(4);
		let show = |l: &[Event]| l[lo.min(l.len())..(i + 3).min(l.len())].iter().map(|e| format!("  {e:?}")).collect::<Vec<_>>().join("\n");
		panic!("{name}: replay differs at event {i} of {} (Rust {}):\nJS:\n{}\nRust:\n{}", want.len(), got.len(), show(&want), show(&got));
	}
	// Stopping at the first stuck plays the same prefix.
	let (stopped, _, _) = replay(root, data_dir, &files, &first_id, race, faction, class, OnStuck::Stop);
	let cut = want.iter().position(|e| matches!(e, Event::Stuck { .. })).map_or(want.len(), |p| p + 1);
	assert_eq!(stopped, want[..cut], "{name}: the stopped replay is not the prefix up to the first stuck");
}

/// A committed reference (golden/engine/<name>.json) on the data slice.
fn golden_chain(name: &str, root: &Path, race: &str, faction: &str, class: &str) {
	let js: Value = serde_json::from_slice(&std::fs::read(common::golden().join(format!("engine/{name}.json"))).unwrap()).unwrap();
	compare_chain(name, root, &common::data(), &js, race, faction, class);
}

#[test]
fn slice_orc_warrior_chain() {
	golden_chain("orc", &common::clean_slice("engine-orc"), "Orc", "Horde", "WARRIOR");
}

#[test]
fn slice_human_warrior_chain() {
	golden_chain("human", &common::clean_slice("engine-human"), "Human", "Alliance", "WARRIOR");
}

#[test]
#[ignore = "needs POLESTAR_CHECKOUT (guides, data/forever), node and lua5.1"]
fn orc_warrior_chain() {
	check_chain("orc", &checkout().unwrap_or_default().join("guides"), "forever/horde/orc-troll/01-durotar.guide", "Orc", "Horde", "WARRIOR");
}

#[test]
#[ignore = "needs POLESTAR_CHECKOUT (guides, data/forever), node and lua5.1"]
fn human_warrior_chain() {
	check_chain("human", &checkout().unwrap_or_default().join("guides"), "forever/alliance/human/01-elwynn-forest.guide", "Human", "Alliance", "WARRIOR");
}

/// The v2 slice (repaired writer output, $POLESTAR_JSREF/repaired): conditional `next` options
/// (`next <catchup> when level<N`).
fn v2() -> PathBuf {
	std::env::var_os("POLESTAR_JSREF").map(PathBuf::from).unwrap_or_default().join("repaired")
}

#[test]
#[ignore = "needs POLESTAR_JSREF (repaired guides), POLESTAR_CHECKOUT, node and lua5.1"]
fn v2_orc_warrior_chain() {
	check_chain("v2-orc", &v2().join("horde-orc-troll-warrior"), "forever/horde/orc-troll-warrior/01-durotar.guide", "Orc", "Horde", "WARRIOR");
}

#[test]
#[ignore = "needs POLESTAR_JSREF (repaired guides), POLESTAR_CHECKOUT, node and lua5.1"]
fn v2_human_warrior_chain() {
	check_chain("v2-human", &v2().join("alliance-human-warrior"), "forever/alliance/human-warrior/01-elwynn-forest.guide", "Human", "Alliance", "WARRIOR");
}

/// Edge cases on Northshire quests: a `skipto` taken and one not, `along until`, `only` (class, `!class`,
/// race and class together on a goal), `when` (onquest, level, done), a `next` option whose `when`
/// fails, a level with a share of XP, a goto leading into the next step, placement passing a step,
/// sethome, hearth and `when zone`.
const FIXTURES: [(&str, &str); 3] = [
	(
		"forever/alliance/fx/01-a.guide",
		"guide forever/alliance/fx/01-a
title Fixture A
faction Alliance
levels 1-10
zone Elwynn Forest
next forever/alliance/fx/02-b when turnedin 99999
next forever/alliance/fx/03-c

step Start
  accept 783
  turnin 783
  accept 7
  accept 33

step Jump
  skipto wolves when onquest 33
  goto 40,40 \"Field\"

step Jumped over
  goto 41,41 \"Jumped field\"

step Wolves
  label wolves
  collect 750 quest 33

step Along
  along until kobolds
  accept 5261
  turnin 5261

step Warriors
  only Warrior
  accept 3100

step Mages
  only Mage
  accept 3104

step Not warriors
  only !Warrior
  accept 18

step Not on 7
  when !onquest 7
  accept 15

step Low level
  when level<2
  turnin 33

step Kobolds
  label kobolds
  kill 6 quest 7
  accept 18 only Human,Paladin
  turnin 33

step Wolves done
  when done wolves
  turnin 7

step Jump not taken
  skipto end when turnedin 99999
  skipto end when level>=40
  accept 15

step After
  level 2
  turnin 3100 only Warrior
  turnin 3104 only Mage
  accept 21

step End
  label end
  turnin 15
",
	),
	(
		"forever/alliance/fx/02-b.guide",
		"guide forever/alliance/fx/02-b
title Fixture B
faction Alliance
levels 5-10
zone Elwynn Forest

step B
  accept 18
",
	),
	(
		"forever/alliance/fx/03-c.guide",
		"guide forever/alliance/fx/03-c
title Fixture C
faction Alliance
levels 2-10
zone Elwynn Forest

step Wrong class
  only Rogue
  accept 3102

step The way out
  goto 48.2,42.0 \"Abbey steps\"

step Willem
  accept 18
  talk 823
  train class

step Thieves
  collect 752 quest 18
  level 4.5

step Home
  turnin 18
  accept 21
  sethome \"Goldshire\"
  hearth \"Goldshire\"

step In Goldshire
  when zone \"Goldshire\"
  talk 823

step Not in Goldshire
  when !zone \"Goldshire\"
  talk 197
",
	),
];

/// Write the fixture guides under rust/target/judge-ref/engine-fixtures (a changed text drops the cached
/// references) -> the root.
fn fixtures() -> PathBuf {
	let root = ref_dir().join("engine-fixtures");
	let mut changed = false;
	for (rel, text) in FIXTURES {
		let p = root.join(rel);
		if std::fs::read_to_string(&p).ok().as_deref() != Some(text) {
			std::fs::create_dir_all(p.parent().unwrap()).unwrap();
			std::fs::write(&p, text).unwrap();
			changed = true;
		}
	}
	if changed {
		for name in ["fx-warrior", "fx-mage"] {
			let _ = std::fs::remove_file(ref_dir().join(format!("engine-{name}.json")));
		}
	}
	root
}

#[test]
#[ignore = "needs POLESTAR_CHECKOUT (guides, data/forever), node and lua5.1"]
fn fixtures_warrior() {
	check_chain("fx-warrior", &fixtures(), FIXTURES[0].0, "Human", "Alliance", "WARRIOR");
}

#[test]
#[ignore = "needs POLESTAR_CHECKOUT (guides, data/forever), node and lua5.1"]
fn fixtures_mage() {
	check_chain("fx-mage", &fixtures(), FIXTURES[0].0, "Human", "Alliance", "MAGE");
}

#[test]
fn slice_fixtures_warrior() {
	golden_chain("fx-warrior", &fixtures(), "Human", "Alliance", "WARRIOR");
}

#[test]
fn slice_fixtures_mage() {
	golden_chain("fx-mage", &fixtures(), "Human", "Alliance", "MAGE");
}

// ---------------------------------------------------------------------------------------------------
// Rules without the data: hand-written compiled guides (the compiler's JSON shape), any machine.

fn compiled(json: &str) -> engine::Guide {
	engine::Guide::read(&forge_guide::js::parse_json(json).unwrap())
}

fn elwynn() -> WorldData {
	let mut w = WorldData::default();
	w.frames.era.insert("1429".into(), forge_core::Bounds { c: 0, left: Some(1535.417), right: Some(-1935.417), top: Some(-7939.583), bottom: Some(-10254.166) });
	w
}

/// The goals a replay completes, as "guide step:goal verb".
fn played(guides: &[engine::Guide], class: &str) -> Vec<String> {
	let world = elwynn();
	let events = Replay::new(guides, &world, Character::new("Alliance", "Human", class, 1)).play(&guides[0].id, OnStuck::Stop).unwrap();
	events
		.iter()
		.filter_map(|e| match e {
			Event::Goal { guide, step, goal, verb, .. } => Some(format!("{guide} {step}:{goal} {verb}")),
			Event::Stuck { step, .. } => Some(format!("stuck {step}")),
			_ => None,
		})
		.collect()
}

fn rules_guides() -> Vec<engine::Guide> {
	let a = r#"{ "id": "t/a", "faction": "Alliance", "nextChoices": ["t/b", "t/c"], "nextWhen": { "t/b": [{ "k": "level", "op": "<", "n": 3 }] }, "steps": [
		{ "goals": [{ "t": "accept", "quest": 1, "map": 1429, "x": 50, "y": 50 }] },
		{ "skipto": [{ "to": "none", "when": { "k": "onquest", "q": [1] } }, { "to": "x", "when": { "k": "turnedin", "q": [1], "neg": true } }], "goals": [{ "t": "goto", "map": 1429, "x": 10, "y": 10 }] },
		{ "goals": [{ "t": "goto", "map": 1429, "x": 11, "y": 11 }] },
		{ "label": "x", "goals": [{ "t": "turnin", "quest": 1 }] },
		{ "only": { "classes": ["MAGE"] }, "goals": [{ "t": "accept", "quest": 2 }] },
		{ "goals": [{ "t": "accept", "quest": 3, "only": { "classes": ["!WARRIOR"] } }, { "t": "accept", "quest": 4 }, { "t": "accept", "quest": 5, "only": { "races": ["Human"], "classes": ["PALADIN"] } }] },
		{ "when": [{ "k": "level", "op": ">=", "n": 5 }], "goals": [{ "t": "accept", "quest": 6 }] },
		{ "goals": [{ "t": "level", "level": 5 }] },
		{ "when": [{ "k": "level", "op": "<", "n": 5 }], "goals": [{ "t": "accept", "quest": 7 }] },
		{ "when": [{ "k": "done", "label": "x" }], "goals": [{ "t": "accept", "quest": 8 }] },
		{ "along": true, "goals": [{ "t": "accept", "quest": 9 }] },
		{ "goals": [{ "t": "accept", "quest": 10, "optional": true }, { "t": "turnin", "quest": 4 }, { "t": "note", "text": "done" }] }
	] }"#;
	let b = r#"{ "id": "t/b", "steps": [{ "goals": [{ "t": "accept", "quest": 20 }] }] }"#;
	let c = r#"{ "id": "t/c", "steps": [{ "goals": [{ "t": "accept", "quest": 30 }] }] }"#;
	vec![compiled(a), compiled(b), compiled(c)]
}

/// `skipto` takes the first jump whose label exists and predicate holds; `only` on steps and goals (a
/// `!class`, race and class together); a `when` that failed when the route passed stays off after the
/// level-up; `when done`; an along step is passed over; optional goals and notes never hold; the `next`
/// option whose `when` fails is not offered.
#[test]
fn rules_warrior() {
	assert_eq!(played(&rules_guides(), "WARRIOR"), ["t/a 1:1 accept", "t/a 4:1 turnin", "t/a 6:2 accept", "t/a 8:1 level", "t/a 10:1 accept", "t/a 12:2 turnin", "t/c 1:1 accept"]);
}

#[test]
fn rules_mage() {
	assert_eq!(
		played(&rules_guides(), "MAGE"),
		["t/a 1:1 accept", "t/a 4:1 turnin", "t/a 5:1 accept", "t/a 6:1 accept", "t/a 6:2 accept", "t/a 8:1 level", "t/a 10:1 accept", "t/a 12:2 turnin", "t/c 1:1 accept"]
	);
}

/// A kill for a quest taken in an earlier guide (whose goals gave its log entry no objective line) stays
/// open: the play sticks there (with `Skip` the step is skipped); a manual goal is ticked; a goto
/// completes on arrival.
#[test]
fn stuck_and_ticks() {
	let guides = vec![
		compiled(r#"{ "id": "t/s1", "next": "t/s2", "steps": [{ "goals": [{ "t": "accept", "quest": 1 }] }] }"#),
		compiled(
			r#"{ "id": "t/s2", "steps": [
			{ "goals": [{ "t": "kill", "npc": 5, "quest": 1, "oi": 1 }] },
			{ "goals": [{ "t": "goto", "map": 1429, "x": 30, "y": 30 }, { "t": "getfp", "location": "Goldshire" }, { "t": "turnin", "quest": 1 }] }
		] }"#,
		),
	];
	assert_eq!(played(&guides, "WARRIOR"), ["t/s1 1:1 accept", "t/s2 1:1 kill", "stuck 1"]);
	let world = elwynn();
	let events = Replay::new(&guides, &world, Character::new("Alliance", "Human", "WARRIOR", 1)).play("t/s1", OnStuck::Skip).unwrap();
	let goals: Vec<(String, usize, bool)> = events.iter().filter_map(|e| if let Event::Goal { verb, step, ticked, .. } = e { Some((verb.clone(), *step, *ticked)) } else { None }).collect();
	let want = [("accept", 1, false), ("kill", 1, false), ("goto", 2, false), ("getfp", 2, true), ("turnin", 2, false)];
	assert_eq!(goals, want.map(|(v, s, t)| (v.to_string(), s, t)));
}
