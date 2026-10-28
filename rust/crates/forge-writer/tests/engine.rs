//! The engine rules (src/engine.rs) on small guides over the reference data: by default the committed
//! data slice with the writer golden's synthetic quest mechanics (tests/common, rust/tests/golden/writer);
//! $POLESTAR_V1's full data/forever and data/local/mechanics when set. Each rule: the line is not there
//! with the rule off, and is with it on.
#![cfg(feature = "native")]

mod common;

use common::Ref;
use forge_writer::engine::{engine_pass, Inputs, Opts};
use forge_writer::tips::{Floors, Surface};
use forge_writer::travel::Travel;
use rustc_hash::FxHashMap;
use std::collections::BTreeMap;

thread_local! {
	// The data is not Sync (its tables share Rc); one copy per test thread.
	static REF: &'static Ref = Box::leak(Box::new(common::engine_ref()));
}

fn reference() -> &'static Ref {
	REF.with(|r| *r)
}

fn guide(id: &str, race: &str, faction: &str, zone: &str, next: Option<&str>, body: &[&str]) -> String {
	let mut l = vec![format!("guide forever/t/{id}"), format!("title {id}"), format!("faction {faction}"), format!("race {race}"), "levels 1-60".into(), format!("zone {zone}")];
	if let Some(n) = next {
		l.push(format!("next forever/t/{n}"));
	}
	l.push(String::new());
	l.extend(body.iter().map(|s| s.to_string()));
	l.push(String::new());
	l.join("\n")
}

/// Runs the rules on guides `files` (name, text) as the route's race; -> the files after, as lines.
fn run(files: &[(&str, String)], race: &str, faction: &str, opts: &Opts, accept_lvl: &FxHashMap<u32, f64>) -> BTreeMap<String, Vec<String>> {
	run_on(reference(), files, race, faction, opts, accept_lvl, None, None)
}

/// `run` on the reference `r`, with R9's floors and R10's quest notes.
#[allow(clippy::too_many_arguments)]
fn run_on(r: &Ref, files: &[(&str, String)], race: &str, faction: &str, opts: &Opts, accept_lvl: &FxHashMap<u32, f64>, floors: Option<&dyn Floors>, notes: Option<&serde_json::Value>) -> BTreeMap<String, Vec<String>> {
	let mut tree: BTreeMap<String, String> = files.iter().map(|(n, t)| (format!("forever/t/{n}.guide"), t.clone())).collect();
	let t = Travel {
		chain: files.iter().map(|(n, _)| format!("forever/t/{n}.guide")).collect(),
		route_races: vec![race.into()],
		other_races: Vec::new(),
		shared: Vec::new(),
		faction: Some(faction.into()),
		cls: None,
	};
	let no_along = Default::default();
	let inp = Inputs {
		data: &r.data,
		mechanics: r.mech.as_ref(),
		steps: r.steps.as_ref(),
		spells: None,
		walks: None,
		accept_lvl,
		no_along: &no_along,
		floors,
		area_at: None,
		heights: None,
		notes,
	};
	engine_pass(&mut tree, &t, &inp, opts);
	tree.into_iter().map(|(k, v)| (k.trim_start_matches("forever/t/").trim_end_matches(".guide").to_string(), v.split('\n').map(str::to_string).collect())).collect()
}

fn off() -> Opts {
	Opts { along: false, use_items: false, when: false, tips: false, warnings: false, format_0_3: false }
}

fn idx(g: &[String], l: &str) -> usize {
	g.iter().position(|x| x == l).unwrap_or_else(|| panic!("no {l:?} in\n{}", g.join("\n")))
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r1_gloom_weed_along_the_road_to_brill() {
	let g = guide("a", "Undead", "Horde", "Tirisfal Glades", None, &["step Gordo", "  accept 5481", "  collect 12737 quest 5481.1", "", "step Brill", "  turnin 5481"]);
	let before = run(&[("a", g.clone())], "Undead", "Horde", &off(), &FxHashMap::default());
	assert!(!before["a"].iter().any(|l| l.contains("along")));
	let after = run(&[("a", g)], "Undead", "Horde", &Opts { along: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	// The weed is listed on the way from Gordo to Brill; the stop for it at Gordo goes.
	let s = idx(a, "step Gloom Weed on the way");
	assert_eq!(a[s + 1], "  along until q5481", "{}", a.join("\n"));
	assert!(a[s + 2].starts_with("  collect 12737 quest 5481.1"), "{}", a.join("\n"));
	assert!(idx(a, "step Gordo") < s && s < idx(a, "step Brill"));
	assert_eq!(a[idx(a, "step Brill") + 1], "  label q5481");
	assert_eq!(a.iter().filter(|l| l.contains("collect 12737")).count(), 1);
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r1_work_walked_past_before_its_step_is_listed_from_the_accept() {
	let r = reference();
	// A Sunscale Scytheclaw spawn in the Barrens: a walk passes right by it.
	let sp = r.data.npcs.get("3256").get("spawns").get("1413").get("pts").at(0);
	let (x, y) = (sp.at(0).num(), sp.at(1).num());
	let at = |dx: f64| format!("{:.1},{:.1}", x + dx, y);
	let body: Vec<String> = vec![
		"step Ratchet".into(),
		"  accept 865".into(),
		"".into(),
		"step Walk".into(),
		format!("  goto {} \"West\"", at(-3.0)),
		"".into(),
		"step Walk on".into(),
		format!("  goto {} \"East\"", at(3.0)),
		"".into(),
		"step Far".into(),
		"  goto 52.0,30.0 \"Crossroads\"".into(),
		"".into(),
		"step Farther".into(),
		"  goto 45.0,60.0 \"South\"".into(),
		"".into(),
		"step Raptor Horns".into(),
		"  collect 5055 quest 865.1".into(),
		"".into(),
		"step Ratchet again".into(),
		"  turnin 865".into(),
	];
	let body: Vec<&str> = body.iter().map(String::as_str).collect();
	let g = guide("a", "Orc", "Horde", "The Barrens", None, &body);
	let before = run(&[("a", g.clone())], "Orc", "Horde", &off(), &FxHashMap::default());
	assert!(!before["a"].iter().any(|l| l.contains("along")));
	let after = run(&[("a", g)], "Orc", "Horde", &Opts { along: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	let s = idx(a, "step Intact Raptor Horn on the way");
	assert!(idx(a, "step Ratchet") < s && s < idx(a, "step Walk"), "{}", a.join("\n"));
	assert_eq!(a[s + 1], "  along until q865");
	assert_eq!(a[idx(a, "step Raptor Horns") + 1], "  label q865");
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r1_carried_quest_gets_its_along_step_in_each_guide_it_crosses() {
	let r = reference();
	let sp = r.data.npcs.get("3256").get("spawns").get("1413").get("pts").at(0);
	let (x, y) = (sp.at(0).num(), sp.at(1).num());
	let a = guide("a", "Orc", "Horde", "The Barrens", Some("b"), &["step Ratchet", "  accept 865"]);
	let bb: Vec<String> = vec![
		"step Walk".into(),
		format!("  goto {:.1},{:.1} \"West\"", x - 3.0, y),
		"".into(),
		"step Walk on".into(),
		format!("  goto {:.1},{:.1} \"East\"", x + 3.0, y),
		"".into(),
		"step Far".into(),
		"  goto 52.0,30.0 \"Crossroads\"".into(),
		"".into(),
		"step Farther".into(),
		"  goto 45.0,60.0 \"South\"".into(),
		"".into(),
		"step Raptor Horns".into(),
		"  collect 5055 quest 865.1".into(),
		"".into(),
		"step Ratchet".into(),
		"  turnin 865".into(),
	];
	let bb: Vec<&str> = bb.iter().map(String::as_str).collect();
	let b = guide("b", "Orc", "Horde", "The Barrens", None, &bb);
	let after = run(&[("a", a), ("b", b)], "Orc", "Horde", &Opts { along: true, ..off() }, &FxHashMap::default());
	let g = &after["b"];
	let s = idx(g, "step Intact Raptor Horn on the way");
	assert!(s < idx(g, "step Walk on"), "{}", g.join("\n"));
	assert_eq!(g[s + 2], "  when onquest 865", "{}", g.join("\n"));
}

#[test]
#[ignore = "needs data/forever and data/local/mechanics (or POLESTAR_V1)"]
fn r2_use_for_an_item_summon() {
	let g = guide(
		"a",
		"Orc",
		"Horde",
		"The Barrens",
		None,
		&["step Thork", "  accept 882", "", "step Horn", "  collect 10338", "", "step Dead Tree", "  collect 5101 quest 882.1", "", "step Thork again", "  turnin 882"],
	);
	let before = run(&[("a", g.clone())], "Orc", "Horde", &off(), &FxHashMap::default());
	assert!(!before["a"].iter().any(|l| l.contains("use 10338")));
	let after = run(&[("a", g)], "Orc", "Horde", &Opts { use_items: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	let u = idx(a, "  use 10338 @60.0,30.2 map 1413");
	assert_eq!(a[u + 1], "  collect 5101 quest 882.1", "the use summons Ishamuhale, the kill drops the fang: {}", a.join("\n"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r3_travel_for_a_carried_quest_is_when_onquest() {
	let a = guide("a", "Orc", "Horde", "Durotar", Some("b"), &["step Gornek", "  accept 788"]);
	let b = guide(
		"b",
		"Orc",
		"Horde",
		"Durotar",
		None,
		&["step The Den", "  goto 42.4,68.6 \"The Den\"", "  turnin 788", "", "step Trainer", "  goto 42.4,68.6 \"The Den\"", "  train class", "  turnin 788", "", "step After", "  accept 789"],
	);
	let before = run(&[("a", a.clone()), ("b", b.clone())], "Orc", "Horde", &off(), &FxHashMap::default());
	assert!(!before["b"].iter().any(|l| l.contains("when")));
	let after = run(&[("a", a), ("b", b)], "Orc", "Horde", &Opts { when: true, ..off() }, &FxHashMap::default());
	let g = &after["b"];
	assert_eq!(g[idx(g, "step The Den") + 1], "  when onquest 788", "{}", g.join("\n"));
	// (Never a step that also trains: everyone trains there.)
	assert!(!g[idx(g, "step Trainer") as usize..].iter().take(3).any(|l| l.contains("when")), "{}", g.join("\n"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r3_hearth_to_an_inn_bound_in_an_earlier_guide_is_when_bound() {
	let a = guide("a", "Orc", "Horde", "Durotar", Some("b"), &["step Razor Hill", "  sethome \"Razor Hill\"", "  accept 788"]);
	let b = guide("b", "Orc", "Horde", "The Barrens", None, &["step Crossroads", "  goto 52.0,30.0 \"Crossroads\"", "", "step Home", "  hearth \"Razor Hill\"", "", "step Gornek", "  turnin 788"]);
	let before = run(&[("a", a.clone()), ("b", b.clone())], "Orc", "Horde", &off(), &FxHashMap::default());
	assert!(!before["b"].iter().any(|l| l.contains("bound")));
	let after = run(&[("a", a), ("b", b)], "Orc", "Horde", &Opts { when: true, ..off() }, &FxHashMap::default());
	let g = &after["b"];
	assert_eq!(g[idx(g, "step Home") + 1], "  when bound \"Razor Hill\"", "{}", g.join("\n"));
	let f = idx(g, "  when !bound \"Razor Hill\"");
	assert!(g[f + 1..f + 3].iter().any(|l| l.starts_with("  goto ") && l.ends_with("\"Razor Hill\"")), "{}", g.join("\n"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r5_group_quest_is_asked_for_under_0_3_only() {
	let a = guide("a", "Orc", "Horde", "Dustwallow Marsh", None, &["step Mok'Morokk", "  accept 1166", "", "step Ogres", "  kill 4344 quest 1166.1", "", "step Back", "  turnin 1166"]);
	let before = run(&[("a", a.clone())], "Orc", "Horde", &Opts { when: true, ..off() }, &FxHashMap::default());
	assert!(!before["a"].iter().any(|l| l.contains("when group")));
	let after = run(&[("a", a)], "Orc", "Horde", &Opts { when: true, format_0_3: true, ..off() }, &FxHashMap::default());
	assert_eq!(after["a"].iter().filter(|l| *l == "  when group 1166").count(), 3, "{}", after["a"].join("\n"));
}

#[test]
#[ignore = "needs data/forever and data/local/mechanics (or POLESTAR_V1)"]
fn r6_emote_before_a_turnin_nothing_else_tracks_is_a_task() {
	let a = guide("a", "Orc", "Horde", "The Barrens", None, &["step Fizzule", "  accept 2458", "", "step Fizzule again", "  turnin 2458"]);
	let before = run(&[("a", a.clone())], "Orc", "Horde", &off(), &FxHashMap::default());
	assert!(!before["a"].iter().any(|l| l.contains("task")));
	let after = run(&[("a", a)], "Orc", "Horde", &Opts { format_0_3: true, ..off() }, &FxHashMap::default());
	let g = &after["a"];
	let t = g.iter().position(|l| l.starts_with("  task \"")).expect("a task");
	assert_eq!(g[t + 1], "  turnin 2458", "{}", g.join("\n"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r7_quest_log_past_forty_abandons_a_low_quest() {
	let r = reference();
	// 41 low Horde quests (Durotar, the Barrens; no Alliance race bit) accepted at level 30: the 41st
	// drops the lowest.
	let horde = |q: &forge_guide::js::V| !q.get("races").truthy() || (q.get("races").num() as u64) & 77 == 0;
	let mut low: Vec<u32> = r
		.data
		.quests
		.entries()
		.iter()
		.filter(|(_, q)| q.get("level").num() <= 10.0 && !q.get("start").get("npc").is_empty() && [1411.0, 1413.0].contains(&q.get("zone").num()) && horde(q))
		.map(|(k, _)| k.parse().unwrap())
		.collect();
	low.sort();
	assert!(low.len() >= 41, "{} low Horde quests", low.len());
	let lines: Vec<String> = std::iter::once("step Many".to_string()).chain(low[..41].iter().map(|q| format!("  accept {q}"))).collect();
	let lines: Vec<&str> = lines.iter().map(String::as_str).collect();
	let a = guide("a", "Orc", "Horde", "The Barrens", None, &lines);
	let lvl: FxHashMap<u32, f64> = low[..41].iter().map(|q| (*q, 30.0)).collect();
	let before = run(&[("a", a.clone())], "Orc", "Horde", &off(), &lvl);
	assert!(!before["a"].iter().any(|l| l.contains("abandon")));
	let after = run(&[("a", a)], "Orc", "Horde", &Opts { format_0_3: true, ..off() }, &lvl);
	assert_eq!(after["a"].iter().filter(|l| l.starts_with("  abandon ")).count(), 1, "{}", after["a"].join("\n"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r8_block_for_a_carried_quest_is_skipped_when_it_is_not_held() {
	let a = guide("a", "Orc", "Horde", "Durotar", Some("b"), &["step Gornek", "  accept 788"]);
	let b = guide(
		"b",
		"Orc",
		"Horde",
		"Durotar",
		None,
		&["step Boars", "  goto 44.0,60.0 \"Boars\"", "  kill 3098 quest 788.1", "", "step More boars", "  goto 46.0,62.0 \"More\"", "  kill 3098 quest 788.1", "", "step Next", "  accept 4402"],
	);
	let before = run(&[("a", a.clone()), ("b", b.clone())], "Orc", "Horde", &off(), &FxHashMap::default());
	assert!(!before["b"].iter().any(|l| l.contains("skipto")));
	let after = run(&[("a", a), ("b", b)], "Orc", "Horde", &Opts { format_0_3: true, ..off() }, &FxHashMap::default());
	let g = &after["b"];
	assert_eq!(g[idx(g, "step Boars") + 1], "  skipto q788 when !onquest 788", "{}", g.join("\n"));
	assert_eq!(g[idx(g, "step Next") + 1], "  label q788");
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r1_onward_along_step_for_a_quest_taken_earlier_goes_before_its_stop() {
	// LD-22 (the Den's mouth): the stop's step ends at the place before the turn-in; listing the work
	// after that step put it between the mouth and Kzan. Taken in an earlier step, the work is listed
	// from the stop's step on: before it, and before the waypoint step leading into it (Shadowthread
	// Cave's mouth before the Webwood Eggs).
	let g = guide(
		"a",
		"Undead",
		"Horde",
		"Tirisfal Glades",
		None,
		&["step Gordo", "  accept 5481", "", "step Way", "  goto 43.1,54.7 \"Gordo\"", "", "step Weed", "  goto 43.1,54.7 \"Gordo\"", "  collect 12737 quest 5481.1", "", "step Brill", "  turnin 5481"],
	);
	let after = run(&[("a", g)], "Undead", "Horde", &Opts { along: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	let s = idx(a, "step Gloom Weed on the way");
	assert!(idx(a, "step Gordo") < s && s < idx(a, "step Way"), "{}", a.join("\n"));
	assert_eq!(a[s + 1], "  along until q5481", "{}", a.join("\n"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r1_a_walk_that_never_comes_within_sixty_yards_of_a_spawn_lists_nothing() {
	// #737: the Tirisfal Pumpkins were listed "on the way" through Brill. The walk from Gordo's road to
	// Calvin comes within about 130 yd of the nearest pumpkin, close to the field's wide spot edge but
	// nowhere near a pumpkin, so nothing is passed.
	let g = guide(
		"a",
		"Undead",
		"Horde",
		"Tirisfal Glades",
		None,
		&[
			"step Simmer",
			"  accept 365",
			"",
			"step Brill",
			"  goto 57.4,48.9 \"Brill\"",
			"",
			"step Gordo's road",
			"  goto 43.1,54.7 \"Gordo\"",
			"",
			"step Calvin",
			"  goto 38.2,56.8 \"Solliden Farmstead\"",
			"",
			"step Back to Brill",
			"  goto 60.0,52.0 \"Brill\"",
			"",
			"step North",
			"  goto 58.0,30.0 \"North\"",
			"",
			"step Pumpkins",
			"  collect 2846 quest 365.1",
			"",
			"step Simmer again",
			"  turnin 365",
		],
	);
	let after = run(&[("a", g)], "Undead", "Horde", &Opts { along: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	assert!(!a.iter().any(|l| l.contains("along")), "{}", a.join("\n"));
}

#[test]
#[ignore = "needs data/forever and data/local/mechanics (or POLESTAR_V1)"]
fn r2_use_at_the_place_nearest_the_routes_work() {
	// The Corrupt Jaedenar Moonwell has a twin in Darkshore: the canteen is filled at Jaedenar, where
	// the route works the quest (LD-R06/R12: a Felwood step sent the arrow to Darkshore).
	let g = guide("a", "Orc", "Horde", "Felwood", None, &["step Greta", "  accept 5157", "", "step Jaedenar", "  collect 12907 quest 5157 @35.2,59.8", "", "step Greta again", "  turnin 5157"]);
	let after = run(&[("a", g)], "Orc", "Horde", &Opts { use_items: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	// (The fill itself gives no credit: not bound to the objective, PR542.)
	assert!(a.iter().any(|l| l == "  use 12922 @35.2,59.8 map 1448"), "{}", a.join("\n"));
}

#[test]
#[ignore = "needs data/forever and data/local/mechanics (or POLESTAR_V1)"]
fn r2_use_that_makes_an_item_goes_before_the_line_that_collects_it() {
	// #302 The Blackwood Corrupted: v1 fills the bowl at the Auberdine moonwell (`collect 12347`);
	// the empty bowl's use went to the furbolg camp, after the filled bowl was in the bags.
	let g = guide("a", "Human", "Alliance", "Darkshore", None, &["step Auberdine", "  accept 4763", "  collect 12347", "", "step Camp", "  collect 12342 quest 4763.2", "", "step Back", "  turnin 4763"]);
	let after = run(&[("a", g)], "Human", "Alliance", &Opts { use_items: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	let (u, c) = (a.iter().position(|l| l.starts_with("  use 12346 ")), a.iter().position(|l| l == "  collect 12347"));
	assert!(u.is_some() && u.unwrap() + 1 == c.unwrap(), "{}", a.join("\n"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r3_hand_in_of_a_quest_picked_up_optionally_is_when_onquest_split_from_other_work() {
	// Cutting Teeth taken optionally: its own hand-in step is guarded; beside training and the follow-up,
	// the hand-in becomes a step of its own in place.
	let g = guide(
		"a",
		"Orc",
		"Horde",
		"Durotar",
		None,
		&[
			"step Gornek",
			"  accept 788 optional",
			"",
			"step Boars",
			"  kill 3098 quest 788.1",
			"",
			"step Back",
			"  turnin 788",
			"",
			"step Den",
			"  tip The trainer stands in the den.",
			"  train class",
			"  turnin 788",
			"  accept 789",
			"",
			"step Gornek again",
			"  tip He stands in the den.",
			"  turnin 788",
			"  accept 789",
		],
	);
	let before = run(&[("a", g.clone())], "Orc", "Horde", &off(), &FxHashMap::default());
	assert!(!before["a"].iter().any(|l| l.contains("when")));
	let after = run(&[("a", g)], "Orc", "Horde", &Opts { when: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	assert_eq!(a[idx(a, "step Back") + 1], "  when onquest 788", "{}", a.join("\n"));
	// (Beside other work at the same NPC, Gornek's follow-up, the hand-in stays in its step, optional:
	// the player stands there anyway, RevOrcTroll3 T7.)
	let den = idx(a, "step Den");
	assert_eq!(a[den..den + 5], ["step Den", "  tip The trainer stands in the den.", "  train class", "  turnin 788 optional", "  accept 789"], "{}", a.join("\n"));
	assert!(!a[idx(a, "step Boars")..].iter().take(2).any(|l| l.contains("when")), "the work is not a hand-in: {}", a.join("\n"));
	let again = idx(a, "step Gornek again");
	assert_eq!(a[again..again + 4], ["step Gornek again", "  tip He stands in the den.", "  turnin 788 optional", "  accept 789"], "{}", a.join("\n"));
}

/// Gornek's den as a cellar: an indoor floor under open ground near his spawn, the open ground elsewhere.
struct Den;

impl Floors for Den {
	fn column(&self, c: i64, wx: f64, wy: f64) -> Vec<Surface> {
		let s = |z: f64, indoor: bool| Surface { z, indoor, terrain: !indoor, swim: false, blocked: false };
		if c == 1 && (wx + 600.1).hypot(wy + 4186.2) < 20.0 {
			vec![s(41.0, true), s(48.0, false)]
		} else {
			vec![s(40.0, false)]
		}
	}
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r9_a_goal_below_ground_says_so_and_one_at_a_walking_npc_says_where_he_walks() {
	let g = guide("a", "Orc", "Horde", "Durotar", None, &["step Gornek", "  accept 788", "", "step Boars", "  kill 3098 quest 788.1"]);
	let before = run_on(reference(), &[("a", g.clone())], "Orc", "Horde", &off(), &FxHashMap::default(), Some(&Den), None);
	assert!(before["a"].iter().any(|l| l == "  accept 788"));
	let after = run_on(reference(), &[("a", g.clone())], "Orc", "Horde", &Opts { tips: true, ..off() }, &FxHashMap::default(), Some(&Den), None);
	let a = &after["a"];
	assert_eq!(a[idx(a, "step Gornek") + 1], format!("{:<37} -- Below ground", "  accept 788"), "{}", a.join("\n"));
	assert!(a.iter().any(|l| l == "  kill 3098 quest 788.1"), "the boars roam the open ground: {}", a.join("\n"));
	// Gornek walking 40 yd round a centre 30 yd off his spawn.
	let mut walker = common::engine_ref();
	walker.data.moves = forge_guide::js::parse_json(r#"{"npc":{"3143":[[1,-600.1,-4186.2,-570.1,-4186.2,40]]}}"#).unwrap();
	let after = run_on(&walker, &[("a", g)], "Orc", "Horde", &Opts { tips: true, ..off() }, &FxHashMap::default(), Some(&Den), None);
	let a = &after["a"];
	assert_eq!(a[idx(a, "step Gornek") + 1], format!("{:<37} -- Gornek walks around here: look inside the circle on the map", "  accept 788"), "{}", a.join("\n"));
	// Alonso, found at three places some 90 yd apart in Astranaar's square: the map marks them.
	let g = guide("b", "Human", "Alliance", "Ashenvale", None, &["step Alonso", "  accept 78132"]);
	let after = run_on(reference(), &[("b", g)], "Human", "Alliance", &Opts { tips: true, ..off() }, &FxHashMap::default(), None, None);
	let b = &after["b"];
	assert_eq!(b[idx(b, "step Alonso") + 1], format!("{:<37} -- Alonso walks around here: the map marks where to look", "  accept 78132"), "{}", b.join("\n"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r10_a_quests_ambush_note_is_a_careful_tip_on_the_step_that_does_its_work() {
	let g = guide("a", "Orc", "Horde", "Durotar", None, &["step Gornek", "  accept 788", "", "step Boars", "  zone Durotar", "  kill 3098 quest 788.1", "", "step Back", "  turnin 788"]);
	let notes = serde_json::json!({ "788": { "notes": [
		{ "kind": "danger", "basis": "game-data", "fact": "Two boars ambush you at the den." },
		{ "kind": "tip", "basis": "game-data", "fact": "The boars are easy." },
	]}});
	let before = run_on(reference(), &[("a", g.clone())], "Orc", "Horde", &off(), &FxHashMap::default(), None, Some(&notes));
	assert!(!before["a"].iter().any(|l| l.contains("Careful")));
	let after = run_on(reference(), &[("a", g)], "Orc", "Horde", &Opts { warnings: true, ..off() }, &FxHashMap::default(), None, Some(&notes));
	let a = &after["a"];
	let b = idx(a, "step Boars");
	assert_eq!(a[b + 1..b + 4], ["  zone Durotar", "  tip Careful: Two boars ambush you at the den.", "  kill 3098 quest 788.1"], "{}", a.join("\n"));
	assert_eq!(a.iter().filter(|l| l.contains("Careful")).count(), 1);
}
