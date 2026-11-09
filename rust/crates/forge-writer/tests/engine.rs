//! The engine rules (src/engine.rs) on small guides over the reference data: by default the committed
//! data slice with the writer golden's synthetic quest mechanics (tests/common, rust/tests/golden/writer);
//! $POLESTAR_V1's full data/forever and data/local/mechanics when set. Each rule: the line is not there
//! with the rule off, and is with it on.
#![cfg(feature = "native")]

mod common;

use common::Ref;
use forge_writer::engine::{engine_pass, Inputs, Opts};
use forge_writer::input::Group;
use forge_writer::tips::{Floors, Surface};
use forge_writer::travel::Travel;
use rustc_hash::FxHashMap;
use std::collections::BTreeMap;
use std::rc::Rc;

thread_local! {
	// The data is not Sync (its tables share Rc): one copy per test thread, dropped when the test's
	// thread ends (libtest runs every test on a thread of its own), so a run holds at most
	// --test-threads copies of $POLESTAR_V1's full data (~0.5 GB each), not one per test.
	static REF: Rc<Ref> = Rc::new(common::engine_ref());
}

fn reference() -> Rc<Ref> {
	REF.with(Rc::clone)
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
	run_on(&reference(), files, race, faction, opts, accept_lvl, None, None)
}

/// `run` on the reference `r`, with R9's floors and R10's quest notes.
#[allow(clippy::too_many_arguments)]
fn run_on(
	r: &Ref,
	files: &[(&str, String)],
	race: &str,
	faction: &str,
	opts: &Opts,
	accept_lvl: &FxHashMap<u32, f64>,
	floors: Option<&dyn Floors>,
	notes: Option<&serde_json::Value>,
) -> BTreeMap<String, Vec<String>> {
	run_groups(r, files, race, faction, opts, accept_lvl, floors, notes, &[], &FxHashMap::default())
}

/// `run_on` with the route's group families (`groups`, each quest of one -> its root).
#[allow(clippy::too_many_arguments)]
fn run_groups(
	r: &Ref,
	files: &[(&str, String)],
	race: &str,
	faction: &str,
	opts: &Opts,
	accept_lvl: &FxHashMap<u32, f64>,
	floors: Option<&dyn Floors>,
	notes: Option<&serde_json::Value>,
	groups: &[Group],
	group_of: &FxHashMap<u32, u32>,
) -> BTreeMap<String, Vec<String>> {
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
		groups,
		group_of,
	};
	engine_pass(&mut tree, &t, &inp, opts);
	tree.into_iter().map(|(k, v)| (k.trim_start_matches("forever/t/").trim_end_matches(".guide").to_string(), v.split('\n').map(str::to_string).collect())).collect()
}

fn off() -> Opts {
	Opts { along: false, use_items: false, when: false, tips: false, warnings: false, format_0_3: false, groups: false }
}

fn idx(g: &[String], l: &str) -> usize {
	g.iter().position(|x| x == l).unwrap_or_else(|| panic!("no {l:?} in\n{}", g.join("\n")))
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r1_gloom_weed_along_the_road_to_brill() {
	let g = guide(
		"a",
		"Undead",
		"Horde",
		"Tirisfal Glades",
		None,
		&[
			"step Gordo",
			"  accept 5481",
			"  collect 12737 quest 5481.1",
			"",
			"step Road",
			"  goto 48.7,54.9 \"Road\"",
			"",
			"step Road east",
			"  goto 56.19,50.83 \"Road east\"",
			"",
			"step Brill",
			"  turnin 5481",
		],
	);
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
	let g2 = g.clone();
	let before = run(&[("a", g.clone())], "Orc", "Horde", &off(), &FxHashMap::default());
	assert!(!before["a"].iter().any(|l| l.contains("along")));
	let after = run(&[("a", g)], "Orc", "Horde", &Opts { along: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	let s = idx(a, "step Intact Raptor Horn on the way");
	assert!(idx(a, "step Ratchet") < s && s < idx(a, "step Walk"), "{}", a.join("\n"));
	assert_eq!(a[s + 1], "  along until q865");
	assert_eq!(a[idx(a, "step Raptor Horns") + 1], "  label q865");
	// (Not when a route fix puts the horns after an event the walk past comes before: c15 STV, Shaky's
	// giblets listed along the way before Unbagwa's accept, overrides.pairs[54].)
	forge_sim::fixes::set(serde_json::json!({ "overrides": { "pairs": [{ "a": ["accept", 99999], "b": ["task", 865] }] } }));
	let held = run(&[("a", g2)], "Orc", "Horde", &Opts { along: true, ..off() }, &FxHashMap::default());
	forge_sim::fixes::set(serde_json::json!({}));
	assert!(!held["a"].iter().any(|l| l.contains("along")), "{}", held["a"].join("\n"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r1_along_step_opens_where_its_mobs_come_within_reach() {
	// Fitz: Darkshore's Fine Crab Chunks (Fruit of the Sea) were listed from Gubber Blump's accept in
	// Auberdine, but only the Reef and Encrusted Tide Crawlers of the north coast and the far south drop
	// them; the beach south of Auberdine, the next stop, has none. Listed from the first step that comes
	// within reach of a crab: the walk past a Reef Crawler.
	let r = reference();
	let sp = r.data.npcs.get("2235").get("spawns").get("1439").get("pts").at(9);
	let (x, y) = (sp.at(0).num(), sp.at(1).num());
	assert!(y < 30.0, "a Reef Crawler of the north coast: {x},{y}");
	let body: Vec<String> = vec![
		"step Auberdine".into(),
		"  accept 1138".into(),
		"".into(),
		"step The beach".into(),
		"  goto 36.4,50.9 \"Beach\"".into(),
		"".into(),
		"step Back in Auberdine".into(),
		"  goto 37.4,40.1 \"Auberdine\"".into(),
		"".into(),
		"step Walk".into(),
		format!("  goto {:.2},{:.2} \"West\"", x - 1.0, y),
		"".into(),
		"step Walk on".into(),
		format!("  goto {:.2},{:.2} \"East\"", x + 1.0, y),
		"".into(),
		"step Far".into(),
		"  goto 40.0,60.0 \"South\"".into(),
		"".into(),
		"step Crabs".into(),
		"  collect 12237 quest 1138.1".into(),
		"".into(),
		"step Gubber Blump".into(),
		"  turnin 1138".into(),
	];
	let body: Vec<&str> = body.iter().map(String::as_str).collect();
	let g = guide("a", "Human", "Alliance", "Darkshore", None, &body);
	let after = run(&[("a", g)], "Human", "Alliance", &Opts { along: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	let s = idx(a, "step Fine Crab Chunks on the way");
	assert!(idx(a, "step Back in Auberdine") < s && s < idx(a, "step Walk"), "{}", a.join("\n"));
	assert_eq!(a[s + 1], "  along until q1138");
	assert_eq!(a[idx(a, "step Crabs") + 1], "  label q1138");
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r1_a_list_whose_walk_does_not_pass_its_work_is_a_goal_at_the_stop_with_most_of_it() {
	// Fitz in game: Darkshore's Fine Crab Chunks were listed along the way for ten stops of which three
	// had crabs, six walks of nineteen passing one. A list is along only when half its walks (at least
	// two) pass its work; else the chunks are a goal at the stop with most crabs near, saying where.
	let r = reference();
	let sp = r.data.npcs.get("2235").get("spawns").get("1439").get("pts").at(9);
	let (x, y) = (sp.at(0).num(), sp.at(1).num());
	let body: Vec<String> = vec![
		"step Auberdine".into(),
		"  accept 1138".into(),
		"".into(),
		"step The beach".into(),
		"  goto 36.4,50.9 \"Beach\"".into(),
		"".into(),
		"step Back in Auberdine".into(),
		"  goto 37.4,40.1 \"Auberdine\"".into(),
		"".into(),
		"step Cliffspring".into(),
		format!("  goto {:.2},{:.2} \"West\"", x - 1.0, y),
		"".into(),
		"step Cliffspring east".into(),
		format!("  goto {:.2},{:.2} \"East\"", x + 1.0, y),
		"".into(),
		"step Ameth'Aran".into(),
		"  goto 43.0,58.0 \"Ameth'Aran\"".into(),
		"".into(),
		"step Bashal'Aran".into(),
		"  goto 44.6,38.6 \"Bashal'Aran\"".into(),
		"".into(),
		"step Auberdine again".into(),
		"  goto 37.4,40.1 \"Auberdine\"".into(),
		"".into(),
		"step The Grove".into(),
		"  goto 43.5,76.0 \"Grove\"".into(),
		"".into(),
		"step Auberdine once more".into(),
		"  goto 37.4,44.0 \"Auberdine\"".into(),
		"".into(),
		"step Crabs".into(),
		"  collect 12237 quest 1138.1".into(),
		"".into(),
		"step Gubber Blump".into(),
		"  turnin 1138".into(),
	];
	let body: Vec<&str> = body.iter().map(String::as_str).collect();
	let g = guide("a", "Human", "Alliance", "Darkshore", None, &body);
	let after = run(&[("a", g)], "Human", "Alliance", &Opts { along: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	assert!(!a.iter().any(|l| l.contains("along") || l.contains("label q1138")), "{}", a.join("\n"));
	// (At the crawler: the east point, with more of them within 200 yd than the west one.)
	let s = idx(a, "step Cliffspring east");
	let goal = a[s + 1..].iter().take_while(|l| !l.is_empty()).find(|l| l.starts_with("  collect 12237 quest 1138")).unwrap_or_else(|| panic!("the chunks at Cliffspring:\n{}", a.join("\n")));
	assert!(goal.contains("-- Fine Crab Chunks from Reef Crawler"), "{goal}");
	assert_eq!(a.iter().filter(|l| l.starts_with("  collect 12237")).count(), 2, "and still at Crabs, its own step: {}", a.join("\n"));
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
#[ignore = "needs data/forever and data/local/mechanics (or POLESTAR_V1)"]
fn r2_one_use_per_quest_item() {
	// #843: A Matter of Time's mechanics list the Temporal Displacer's summon three times; Andorhal's
	// step had `use 12627` three times.
	let g = guide("a", "Undead", "Horde", "Western Plaguelands", None, &["step Chromie", "  accept 4971", "", "step Andorhal", "  kill 10717 quest 4971.1", "", "step Chromie again", "  turnin 4971"]);
	let after = run(&[("a", g)], "Undead", "Horde", &Opts { use_items: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	assert_eq!(a.iter().filter(|l| l.starts_with("  use 12627")).count(), 1, "{}", a.join("\n"));
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
	assert!(!g[idx(g, "step Trainer")..].iter().take(3).any(|l| l.contains("when")), "{}", g.join("\n"));
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
		&[
			"step Gordo",
			"  accept 5481",
			"",
			"step Way",
			"  goto 43.1,54.7 \"Gordo\"",
			"",
			"step Weed",
			"  goto 43.1,54.7 \"Gordo\"",
			"  collect 12737 quest 5481.1",
			"",
			"step Road",
			"  goto 48.7,54.9 \"Road\"",
			"",
			"step Brill road",
			"  goto 56.19,50.83 \"Brill road\"",
			"",
			"step Brill",
			"  turnin 5481",
		],
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
	// (The fill gives no credit itself, PR542, but the collect it goes before is the objective's: bound
	// to it, #875.)
	assert!(a.iter().any(|l| l == "  use 12922 quest 5157.1 @35.2,59.8 map 1448"), "{}", a.join("\n"));
}

#[test]
#[ignore = "needs data/forever and data/local/mechanics (or POLESTAR_V1)"]
fn r2_use_that_makes_the_quests_collect_is_bound_to_it() {
	// #875 The Balance of Nature's moonwell: the phial filled, collect 5184 done, and a bare
	// `use 5185` held the step until ticked.
	let g = guide(
		"a",
		"NightElf",
		"Alliance",
		"Teldrassil",
		None,
		&["step Tenaron", "  accept 921", "", "step Moonwell", "  collect 5184 quest 921.1 @60.0,33.0", "", "step Tenaron again", "  turnin 921"],
	);
	let after = run(&[("a", g)], "NightElf", "Alliance", &Opts { use_items: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	assert!(a.iter().any(|l| l == "  use 5185 quest 921.1 @60.0,33.0 map 1438"), "{}", a.join("\n"));
}

#[test]
#[ignore = "needs data/forever and data/local/mechanics (or POLESTAR_V1)"]
fn r2_use_at_a_border_object_is_on_the_routes_map() {
	// c18 Orc 50-60/02-felwood: the Jadefire moonwell's spell focus is one spot read in two frames,
	// Felwood 32.3,66.6 and Darkshore 48.2,85.9; the kitten carrier's use went on Darkshore's map.
	let g = guide("a", "Orc", "Horde", "Felwood", None, &["step Winna", "  accept 4506", "", "step Jadefire moonwell", "  goto 32.3,66.6", "  complete 4506", "", "step Winna again", "  turnin 4506"]);
	let after = run(&[("a", g)], "Orc", "Horde", &Opts { use_items: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	assert!(a.iter().any(|l| l == "  use 12565 quest 4506.1 @32.3,66.6 map 1448"), "{}", a.join("\n"));
	assert!(!a.iter().any(|l| l.contains("map 1439")), "{}", a.join("\n"));
}

#[test]
#[ignore = "needs data/forever and data/local/mechanics (or POLESTAR_V1)"]
fn r2_use_that_makes_an_item_goes_before_the_line_that_collects_it() {
	// #302 The Blackwood Corrupted: v1 fills the bowl at the Auberdine moonwell (`collect 12347`);
	// the empty bowl's use went to the furbolg camp, after the filled bowl was in the bags.
	let g =
		guide("a", "Human", "Alliance", "Darkshore", None, &["step Auberdine", "  accept 4763", "  collect 12347", "", "step Camp", "  collect 12342 quest 4763.2", "", "step Back", "  turnin 4763"]);
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
	// (Beside other work at the same NPC, Gornek's follow-up, the hand-in stays in its step, RevOrcTroll3
	// T7, and as written: the addon holds the hand-in of a quest taken with an `optional` accept only for
	// a player who took it, and one who did is not let past its NPC, #298.)
	let den = idx(a, "step Den");
	assert_eq!(a[den..den + 5], ["step Den", "  tip The trainer stands in the den.", "  train class", "  turnin 788", "  accept 789"], "{}", a.join("\n"));
	assert!(!a[idx(a, "step Boars")..].iter().take(2).any(|l| l.contains("when")), "the work is not a hand-in: {}", a.join("\n"));
	let again = idx(a, "step Gornek again");
	assert_eq!(a[again..again + 4], ["step Gornek again", "  tip He stands in the den.", "  turnin 788", "  accept 789"], "{}", a.join("\n"));
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
	let before = run_on(&reference(), &[("a", g.clone())], "Orc", "Horde", &off(), &FxHashMap::default(), Some(&Den), None);
	assert!(before["a"].iter().any(|l| l == "  accept 788"));
	let after = run_on(&reference(), &[("a", g.clone())], "Orc", "Horde", &Opts { tips: true, ..off() }, &FxHashMap::default(), Some(&Den), None);
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
	let after = run_on(&reference(), &[("b", g)], "Human", "Alliance", &Opts { tips: true, ..off() }, &FxHashMap::default(), None, None);
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
	let before = run_on(&reference(), &[("a", g.clone())], "Orc", "Horde", &off(), &FxHashMap::default(), None, Some(&notes));
	assert!(!before["a"].iter().any(|l| l.contains("Careful")));
	let after = run_on(&reference(), &[("a", g)], "Orc", "Horde", &Opts { warnings: true, ..off() }, &FxHashMap::default(), None, Some(&notes));
	let a = &after["a"];
	let b = idx(a, "step Boars");
	assert_eq!(a[b + 1..b + 4], ["  zone Durotar", "  tip Careful: Two boars ambush you at the den.", "  kill 3098 quest 788.1"], "{}", a.join("\n"));
	assert_eq!(a.iter().filter(|l| l.contains("Careful")).count(), 1);
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r3_a_ride_for_everyone_is_never_only_in_a_hand_in_step_for_quest_holders() {
	// c14 Gnome: the Deeprun Tram's goto shared a step with an optional errand's hand-in, which became
	// `when onquest`: a player who skipped the errand got no tram line.
	let g = guide(
		"a",
		"Orc",
		"Horde",
		"Durotar",
		None,
		&["step Gornek", "  accept 788 optional", "", "step Boars", "  kill 3098 quest 788.1", "", "step Back", "  turnin 788", "  goto 50.8,13.5 \"Zeppelin to Undercity\"", ""],
	);
	let after = run(&[("a", g)], "Orc", "Horde", &Opts { when: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	// (The hand-in may become a step of its own for quest holders; the ride stays everyone's.)
	let z = a.iter().position(|l| l.contains("\"Zeppelin to Undercity\"")).unwrap();
	let s = a[..z].iter().rposition(|l| l.starts_with("step ")).unwrap();
	assert!(!a[s..z].iter().any(|l| l.starts_with("  when")), "{}", a.join("\n"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r3_a_guarded_hand_in_goes_before_the_follow_up_it_opens() {
	// c14 Skyborne (Thrall's 95350 before 98024; here Cutting Teeth before Galgar's 4402): a hand-in split
	// into a step for quest holders came after the follow-up's accept in the same visit: not ready.
	let g = guide(
		"a",
		"Orc",
		"Horde",
		"Durotar",
		None,
		&["step Gornek", "  accept 788 optional", "", "step Boars", "  kill 3098 quest 788.1", "", "step The Den", "  train class", "  accept 4402", "  turnin 788", ""],
	);
	let after = run(&[("a", g)], "Orc", "Horde", &Opts { when: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	let t = idx(a, "  turnin 788");
	assert!(t < idx(a, "  accept 4402"), "{}", a.join("\n"));
	assert!(a[..t].iter().rev().take_while(|l| !l.starts_with("step ")).any(|l| l == "  when onquest 788"), "{}", a.join("\n"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn r1_work_on_the_ground_of_a_step_the_list_runs_past_is_done_in_that_step() {
	// Fitz in game, c14 Undead: "Along the way" listed the Rot Hide Graverobbers and their ichor (358)
	// beside the Doom Weed step, whose weed grows among them north of Brill: one step does both, and the
	// list ends there.
	let g = guide(
		"a",
		"Undead",
		"Horde",
		"Tirisfal Glades",
		None,
		&[
			"step Brill",
			"  accept 358",
			"  accept 5482",
			"",
			"step Deathknell road",
			"  goto 40.0,55.0 \"West\"",
			"",
			"step Brill again",
			"  goto 60.6,52.0 \"Brill\"",
			"",
			"step Doom Weed",
			"  collect 13702 quest 5482.1",
			"",
			"step Brill hand-in",
			"  turnin 5482",
			"",
			"step Garren's Haunt",
			"  goto 58.0,30.0 \"Garren's Haunt\"",
			"",
			"step Graverobbers",
			"  kill 1941 quest 358.1",
			"  collect 2834 quest 358.3",
			"",
			"step Brill last",
			"  turnin 358",
		],
	);
	let after = run(&[("a", g)], "Undead", "Horde", &Opts { along: true, ..off() }, &FxHashMap::default());
	let a = &after["a"];
	let w = idx(a, "step Doom Weed");
	let end = a[w + 1..].iter().position(|l| l.starts_with("step ")).map_or(a.len(), |p| w + 1 + p);
	assert!(a[w..end].iter().any(|l| l.starts_with("  kill 1941 quest 358.1")), "{}", a.join("\n"));
	// Listed on the way only up to it.
	let untils: Vec<&String> = a.iter().filter(|l| l.starts_with("  along until ")).collect();
	let label = a[w..end].iter().find_map(|l| l.strip_prefix("  label "));
	assert!(untils.iter().all(|l| Some(&l["  along until ".len()..]) == label), "{}", a.join("\n"));
}

/// Sarkoth (790) and its follow-up (804) as one group family, beside Cutting Teeth (788) in the
/// hand-in step: the guide, and each quest -> the root.
fn sarkoth() -> (String, FxHashMap<u32, u32>) {
	let g = guide(
		"a",
		"Orc",
		"Horde",
		"Durotar",
		None,
		&[
			"step Hana'zua",
			"  accept 790",
			"",
			"step Sarkoth's cave",
			"  collect 4905 quest 790.1",
			"",
			"step Back at Hana'zua",
			"  accept 788",
			"  turnin 790",
			"  accept 804",
			"",
			"step Gornek",
			"  turnin 804",
		],
	);
	(g, [(790, 790), (804, 790)].into_iter().collect())
}

#[test]
fn groups_a_family_is_asked_on_every_step_with_its_size_and_tip() {
	let (g, of) = sarkoth();
	let fam: Group = serde_json::from_value(serde_json::json!({
		"q": 790, "title": "Sarkoth", "size": 3, "level": 10,
		"mobs": [{ "npc": 3281, "name": "Sarkoth", "level": 10, "rank": 1 }, { "npc": 3098, "name": "Mottled Boar", "level": 9, "rank": 1 }, { "npc": 3099, "name": "Dire Mottled Boar", "level": 9, "rank": 1 }],
		"quests": [790, 804]
	}))
	.unwrap();
	let before = run_groups(&reference(), &[("a", g.clone())], "Orc", "Horde", &off(), &FxHashMap::default(), None, None, std::slice::from_ref(&fam), &of);
	assert!(!before["a"].iter().any(|l| l.contains("group")), "{}", before["a"].join("\n"));
	let after = run_groups(&reference(), &[("a", g)], "Orc", "Horde", &Opts { groups: true, ..off() }, &FxHashMap::default(), None, None, &[fam], &of);
	let a = &after["a"];
	let at = |title: &str, n: usize| -> Vec<String> {
		let s = a.iter().enumerate().filter(|(_, l)| *l == &format!("step {title}")).nth(n).map(|(i, _)| i).unwrap_or_else(|| panic!("no step {title} #{n} in\n{}", a.join("\n")));
		a[s + 1..].iter().take_while(|l| !l.starts_with("step ")).filter(|l| !l.is_empty()).cloned().collect()
	};
	// The accept, the work, the hand-in and the follow-up's hand-in: asked; the other quest's accept is not.
	assert_eq!(at("Hana'zua", 0), ["  when group 790", "  accept 790"], "{}", a.join("\n"));
	assert_eq!(
		at("Sarkoth's cave", 0),
		[
			"  when group 790",
			"  tip These are elite mobs: grouping up is encouraged, look for people to do it with. Sarkoth, Mottled Boar and others (level 10 elites) need a group of 3. Skip it if you are alone: the route has you grind the XP back.",
			"  collect 4905 quest 790.1 group 3",
		],
		"{}",
		a.join("\n")
	);
	assert_eq!(at("Back at Hana'zua", 0), ["  accept 788"], "{}", a.join("\n"));
	assert_eq!(at("Back at Hana'zua", 1), ["  when group 790", "  turnin 790", "  accept 804"], "{}", a.join("\n"));
	assert_eq!(at("Gornek", 0), ["  when group 790", "  turnin 804"], "{}", a.join("\n"));
}

#[test]
fn groups_a_familys_goals_are_not_optional_in_its_asked_steps() {
	// The Monogrammed Sash (8552) and Margol's Horn (3181): a step of only optional goals is done at once,
	// so the player who chose the group way got no arrow to the item, the accept or the hand-in. Asked
	// steps (in place, and the family's goals moved out of a shared step) hold them; the other quest's
	// optional accept stays optional.
	let g = guide(
		"a",
		"Orc",
		"Horde",
		"Durotar",
		None,
		&[
			"step Hana'zua",
			"  accept 790 optional",
			"",
			"step Sarkoth's cave",
			"  collect 4905 quest 790.1 optional",
			"",
			"step Back at Hana'zua",
			"  accept 788 optional",
			"  turnin 790 optional",
			"  accept 804",
			"",
			"step Gornek",
			"  turnin 804 optional                -- Gornek, in the den",
		],
	);
	let of: FxHashMap<u32, u32> = [(790, 790), (804, 790)].into_iter().collect();
	let fam: Group =
		serde_json::from_value(serde_json::json!({ "q": 790, "title": "Sarkoth", "size": 3, "level": 10, "mobs": [{ "npc": 3281, "name": "Sarkoth", "level": 10, "rank": 1 }], "quests": [790, 804] }))
			.unwrap();
	let after = run_groups(&reference(), &[("a", g)], "Orc", "Horde", &Opts { groups: true, ..off() }, &FxHashMap::default(), None, None, &[fam], &of);
	let a = &after["a"];
	for l in ["  accept 790", "  collect 4905 quest 790.1 group 3", "  turnin 790", "  turnin 804                         -- Gornek, in the den", "  accept 788 optional"] {
		assert!(a.iter().any(|x| x == l), "no {l:?} in\n{}", a.join("\n"));
	}
	let asked = a.iter().enumerate().filter(|(_, l)| l.starts_with("  when group 790")).count();
	assert_eq!(asked, 4, "{}", a.join("\n"));
	assert_eq!(a.iter().filter(|l| l.contains("optional")).count(), 1, "{}", a.join("\n"));
}

#[test]
fn groups_two_families_on_one_step_keep_the_steps_order() {
	// c17 Azshara (not-ready): Sprogger's hand-in of 8553 (8552's family) and his accept of 8554 (its
	// own family) were split into two asked steps, the accept's first.
	let (g, _) = sarkoth();
	let of: FxHashMap<u32, u32> = [(790, 790), (804, 804)].into_iter().collect();
	let fam = |q: u32| -> Group {
		serde_json::from_value(serde_json::json!({ "q": q, "title": "T", "size": 3, "level": 10, "mobs": [{ "npc": 3281, "name": "Sarkoth", "level": 10, "rank": 1 }], "quests": [q] })).unwrap()
	};
	let after = run_groups(&reference(), &[("a", g)], "Orc", "Horde", &Opts { groups: true, ..off() }, &FxHashMap::default(), None, None, &[fam(790), fam(804)], &of);
	let a = &after["a"];
	let (t, c) = (idx(a, "  turnin 790"), idx(a, "  accept 804"));
	assert!(t < c, "{}", a.join("\n"));
	assert!(a[..c].iter().rev().find(|l| l.starts_with("  when group")).is_some_and(|l| l == "  when group 804"), "{}", a.join("\n"));
}

#[test]
fn groups_a_soloable_elite_says_most_classes_solo_it_two_levels_up() {
	let (g, of) = sarkoth();
	let fam: Group =
		serde_json::from_value(serde_json::json!({ "q": 790, "title": "Sarkoth", "size": 1, "level": 10, "mobs": [{ "npc": 3281, "name": "Sarkoth", "level": 10, "rank": 1 }], "quests": [790, 804] }))
			.unwrap();
	let after = run_groups(&reference(), &[("a", g)], "Orc", "Horde", &Opts { groups: true, ..off() }, &FxHashMap::default(), None, None, &[fam], &of);
	let a = &after["a"];
	let tip = "  tip These are elite mobs: grouping up is encouraged, look for people to do it with. Sarkoth is a level 10 elite: most classes solo it at level 12, but you may need help. Skip it if you are alone: the route has you grind the XP back.";
	assert_eq!(a[idx(a, "step Sarkoth's cave") + 2], tip, "{}", a.join("\n"));
	// No group size on a soloable elite's work.
	assert!(a.iter().any(|l| l == "  collect 4905 quest 790.1"), "{}", a.join("\n"));
}

#[test]
fn groups_a_title_with_double_quotes_is_written_with_single_quotes() {
	// (Wanted:  "Hogger": a tip's text ends at a double quote, and the pack refused the guide.)
	let (g, of) = sarkoth();
	let fam: Group = serde_json::from_value(serde_json::json!({ "q": 790, "title": "Wanted:  \"Sarkoth\"", "size": 3, "level": 10, "mobs": [], "quests": [790, 804] })).unwrap();
	let after = run_groups(&reference(), &[("a", g)], "Orc", "Horde", &Opts { groups: true, ..off() }, &FxHashMap::default(), None, None, &[fam], &of);
	let a = &after["a"];
	let tip = &a[idx(a, "step Sarkoth's cave") + 2];
	assert!(tip.contains("Wanted:  'Sarkoth' needs a group of 3.") && !tip.contains('"'), "{}", a.join("\n"));
}

#[test]
#[ignore = "needs data/forever (forge data build, or POLESTAR_V1)"]
fn groups_the_drop_that_starts_a_family_quest_is_asked_for() {
	// Croaky's Head (#977): the level 11 elite's drop starts Croaky's Head (91740, a group family), but its
	// bag collect sat in Elwynn's step for everyone (12 recorded deaths at 8-9): it goes with the family.
	let g = guide(
		"a",
		"Human",
		"Alliance",
		"Elwynn Forest",
		None,
		&[
			"step Downstream and Princess",
			"  collect 247813 quest 91733",
			"  collect 247826 x1 optional",
			"  collect 247817 quest 91733",
			"",
			"step Downstream and Princess",
			"  when group 91740",
			"  accept 91740 optional",
			"",
			"step Ormin Pelford",
			"  turnin 91733",
		],
	);
	let fam: Group = serde_json::from_value(
		serde_json::json!({ "q": 91740, "title": "Croaky's Head", "size": 2, "level": 11, "mobs": [{ "npc": 330, "name": "Croaky", "level": 11, "rank": 1 }], "quests": [91740] }),
	)
	.unwrap();
	let of: FxHashMap<u32, u32> = [(91740, 91740)].into_iter().collect();
	let before = run_groups(&reference(), &[("a", g.clone())], "Human", "Alliance", &off(), &FxHashMap::default(), None, None, std::slice::from_ref(&fam), &of);
	assert!(before["a"][..idx(&before["a"], "  when group 91740")].iter().any(|l| l == "  collect 247826 x1 optional"), "{}", before["a"].join("\n"));
	let after = run_groups(&reference(), &[("a", g)], "Human", "Alliance", &Opts { groups: true, ..off() }, &FxHashMap::default(), None, None, &[fam], &of);
	let a = &after["a"];
	let head = idx(a, "  collect 247826 x1");
	let asked = a[..head].iter().rposition(|l| l.starts_with("step ")).unwrap();
	assert_eq!(a[asked + 1], "  when group 91740", "{}", a.join("\n"));
	assert!(idx(a, "  collect 247817 quest 91733") < head, "{}", a.join("\n"));
}

#[test]
fn r11_a_v1_goto_far_from_the_work_after_it_goes() {
	// #1149: the Barrens' "Zhevra" goto (52.5,27.5) points 400+ yd from the nearest Zhevra Runner;
	// the step's kill leads to the runners itself. A goto beside the work stays.
	let far = guide("a", "Tauren", "Horde", "The Barrens", None, &["step The Zhevra", "  goto 52.5,27.5 \"Zhevra\"", "  kill 3242"]);
	let near = guide("b", "Tauren", "Horde", "The Barrens", None, &["step The Zhevra", "  goto 43.3,27.4 \"Zhevra\"", "  kill 3242"]);
	let after = run(&[("a", far), ("b", near)], "Tauren", "Horde", &off(), &FxHashMap::default());
	assert!(!after["a"].iter().any(|l| l.trim_start().starts_with("goto 52.5,27.5")), "{:#?}", after["a"]);
	assert!(after["a"].iter().any(|l| l.trim_start().starts_with("kill 3242")), "{:#?}", after["a"]);
	assert!(after["b"].iter().any(|l| l.trim_start().starts_with("goto 43.3,27.4")), "{:#?}", after["b"]);
}
