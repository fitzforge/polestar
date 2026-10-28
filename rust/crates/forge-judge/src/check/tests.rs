//! One tiny fixture per rule of the route check.

use super::*;
use crate::honest::Severity;
use serde_json::json;

/// Durotar's world frame: 1 map percent = 10 yd.
fn pt(x: f64, y: f64, map: u32, c: i64) -> WPt {
	WPt { c, wx: x * 10.0, wy: y * 10.0, map }
}

fn goal(t: &str, q: Option<i64>, w: Option<WPt>) -> WalkGoal {
	WalkGoal {
		i: 0,
		guide: "forever/horde/01-durotar".into(),
		file: String::new(),
		line: None,
		step: None,
		t: t.into(),
		q,
		oi: None,
		optional: false,
		passing: false,
		map: w.map(|w| w.map),
		w,
		npc: None,
		level: None,
		title: None,
		lvl: 10.0,
		time: 0.0,
		lvl_after: 10.0,
		time_after: 0.0,
		grind: f64::NAN,
		pos: w,
		along: None,
		label: None,
		item: None,
		spots: Vec::new(),
		class: false,
	}
}

/// Goals numbered in order, line 100 + index.
fn walk(mut g: Vec<WalkGoal>) -> Vec<WalkGoal> {
	for (i, x) in g.iter_mut().enumerate() {
		x.i = i;
		x.line = Some(100 + i as u32);
	}
	g
}

fn with_item(mut g: WalkGoal, item: u32) -> WalkGoal {
	g.item = Some(item);
	g
}

fn item(name: &str, npc: &[(u32, Option<f64>)], object: &[(u32, Option<f64>)]) -> ItemFacts {
	ItemFacts { name: name.into(), npc: npc.to_vec(), object: object.to_vec(), vendor: false }
}

fn quest(title: &str, level: f64) -> QuestFacts {
	QuestFacts { title: title.into(), level: Some(level), start_giver: true, ..Default::default() }
}

fn lines(v: &[Violation]) -> Vec<(String, u32, String)> {
	v.iter().map(|v| (v.file.clone(), v.line, v.rule.clone())).collect()
}

fn finding(rule: &'static str, guide: &str, line: u32, reason: &str, cls: &str) -> Finding {
	Finding {
		rule,
		severity: Severity::Fail,
		guide: guide.into(),
		file: String::new(),
		line,
		step: 1,
		title: "Step".into(),
		reason: reason.into(),
		repair: String::new(),
		race: "Orc".into(),
		cls: cls.into(),
		personas: vec![("Orc".into(), cls.into())],
		moved: None,
		state: None,
	}
}

#[test]
fn honest_keeps_new_gated_fails_on_the_chain() {
	let chain: FxHashSet<String> = ["forever/horde/01-durotar".to_string()].into_iter().collect();
	let written = vec![
		// New: a fly with no flight master (distances do not make it new).
		finding("R1", "forever/horde/01-durotar", 10, "no flight master within 200 yd (812 yd)", "WARRIOR"),
		// v1 has it (another distance): not new.
		finding("R1", "forever/horde/01-durotar", 20, "zone change with no travel line: Durotar to The Barrens (900 yd)", "WARRIOR"),
		// Off the chain, and a rule the check does not gate on.
		finding("R6", "forever/class/warlock/x", 5, "class quest un-gated", "WARRIOR"),
		finding("R4", "forever/horde/01-durotar", 30, "giver nearer", "WARRIOR"),
		// A class's R10.
		finding("R10", "forever/horde/01-durotar", 40, "accepted, never handed in", "DRUID"),
	];
	let v1 = vec![finding("R1", "forever/horde/01-durotar", 22, "zone change with no travel line: Durotar to The Barrens (1200 yd)", "WARRIOR")];
	let all = vec!["WARRIOR".to_string(), "DRUID".to_string()];
	let v = honest(&written, &v1, &chain, &all);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 10, "R1".into()), ("horde/01-durotar.guide".into(), 40, "R10".into())]);
	assert!(v.iter().all(|v| v.level == Level::Blocker));
	assert_eq!(v[1].classes, vec!["Druid".to_string()]);
}

#[test]
fn r6_met_by_several_classes_is_one_line_naming_them() {
	let chain: FxHashSet<String> = ["forever/alliance/50-60/01-burning-steppes".to_string()].into_iter().collect();
	let r6 = |cls: &str, label: &str| {
		finding(
			"R6",
			"forever/alliance/50-60/01-burning-steppes",
			151,
			&format!("turnin The Ichor of Undeath: the data closes it to Human {label} (its class mask), and no `only` gates the line"),
			cls,
		)
	};
	let written = vec![r6("WARLOCK", "Warlock"), r6("WARRIOR", "Warrior"), r6("MAGE", "Mage")];
	let all: Vec<String> = ["WARRIOR", "PRIEST", "MAGE", "WARLOCK"].iter().map(|s| s.to_string()).collect();
	let v = honest(&written, &[], &chain, &all);
	assert_eq!(v.len(), 1);
	assert_eq!(v[0].classes, vec!["Warlock".to_string(), "Warrior".to_string(), "Mage".to_string()]);
	assert!(v[0].message.contains("closes it to Human Warlock, Warrior and Mage (its class mask)"), "{}", v[0].message);
	// Every class but the Priest's: still named; a race mask met by every class names the race only.
	let race = |cls: &str, label: &str| {
		finding("R6", "forever/alliance/50-60/01-burning-steppes", 160, &format!("accept X: the data closes it to Human {label} (its race mask), and no `only` gates the line"), cls)
	};
	let v = honest(&[race("WARRIOR", "Warrior"), race("PRIEST", "Priest"), race("MAGE", "Mage"), race("WARLOCK", "Warlock")], &[], &chain, &all);
	assert!(v[0].classes.is_empty());
	assert!(v[0].message.contains("closes it to Human (its race mask)"), "{}", v[0].message);
}

/// Benedict's Chest (3239) opens with Benedict's Key (4882), dropped by Lieutenant Benedict (3192); it
/// holds the Aged Envelope (4881) that starts 830.
fn chest_facts() -> Facts {
	let mut f = Facts::default();
	f.items.insert(4881, item("Aged Envelope", &[], &[(3239, Some(100.0))]));
	f.items.insert(4882, item("Benedict's Key", &[(3192, Some(100.0))], &[]));
	f.locks.insert(3239, 4882);
	f
}

#[test]
fn lock_key_chest_before_its_key_holder_blocks() {
	let mut kill = goal("kill", Some(784), None);
	kill.npc = Some(3192);
	let f = chest_facts();
	let chest_first = walk(vec![with_item(goal("collect", None, None), 4881), goal("accept", Some(830), None), kill.clone()]);
	let v = lock_keys(&chest_first, &f);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 100, "lock-key".into())]);
	assert!(v[0].message.contains("01-durotar.guide:102"), "{}", v[0].message);
	let key_first = walk(vec![kill, with_item(goal("collect", None, None), 4881)]);
	assert!(lock_keys(&key_first, &f).is_empty());
}

#[test]
fn item_used_before_it_is_got_blocks() {
	let f = Facts::default();
	let bad = walk(vec![with_item(goal("use", Some(5), None), 77), with_item(goal("collect", Some(5), None), 77)]);
	assert_eq!(lines(&item_before_use(&bad, &f)), vec![("horde/01-durotar.guide".into(), 100, "item-use".into())]);
	let good = walk(vec![with_item(goal("collect", Some(5), None), 77), with_item(goal("use", Some(5), None), 77)]);
	assert!(item_before_use(&good, &f).is_empty());
	// An item handed over at the accept is had.
	let mut f = Facts::default();
	f.quests.insert(6, QuestFacts { source_item: Some(78), ..Default::default() });
	let given = walk(vec![goal("accept", Some(6), None), with_item(goal("use", Some(6), None), 78), with_item(goal("collect", Some(6), None), 78)]);
	assert!(item_before_use(&given, &f).is_empty());
}

#[test]
fn deliberate_after_with_a_task_index_blocks_when_broken() {
	// 784's task 1 (the sim's) is objective 3 (Benedict) in the guide.
	let mut f = chest_facts();
	f.tasks.insert((784, 0), vec![1, 2]);
	f.tasks.insert((784, 1), vec![3]);
	let doc = json!({ "after": [
		{ "a": ["task", 784, 1], "b": ["accept", 830], "why": "Benedict's key opens the chest" },
		{ "a": ["task", 784, 0], "b": ["accept", 830], "why": "the keep's kills first" }
	], "pairs": [{ "a": ["turnin", 788], "b": ["accept", 789], "why": "Tom" }] });
	let obj = |oi: i64| {
		let mut g = goal("kill", Some(784), None);
		g.oi = Some(oi);
		g
	};
	// Sailors and marines before the accept, Benedict after it: only the task-1 rule breaks.
	let w = walk(vec![obj(1), obj(2), goal("accept", Some(830), None), obj(3), goal("accept", Some(789), None), goal("turnin", Some(788), None)]);
	let v = deliberate(&w, &doc, &Value::Null, &f);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 104, "deliberate".into()), ("horde/01-durotar.guide".into(), 102, "deliberate".into())]);
	assert!(v[0].message.contains("deliberate.pairs[0]") && v[1].message.contains("deliberate.after[0]"), "{:?}", v);
}

#[test]
fn overrides_pairs_block_when_the_written_walk_breaks_them() {
	// #739's run: Gordo's Task (5481) taken on the walk in, before Vital Intelligence (383) is handed in,
	// against the maintainer's override pair; the deliberate pair alone saw nothing.
	let f = chest_facts();
	let overrides = json!({ "pairs": [{ "a": ["turnin", 383], "b": ["accept", 5481], "why": "FitzTest c12w" }] });
	let w = walk(vec![goal("accept", Some(5481), None), goal("turnin", Some(383), None)]);
	assert!(deliberate(&w, &json!({}), &Value::Null, &f).is_empty(), "without the overrides nothing is checked");
	let v = deliberate(&w, &json!({}), &overrides, &f);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 100, "deliberate".into())]);
	assert!(v[0].message.contains("overrides.pairs[0]") && v[0].level == Level::Blocker, "{:?}", v);
	// Kept: no violation.
	let kept = walk(vec![goal("turnin", Some(383), None), goal("accept", Some(5481), None)]);
	assert!(deliberate(&kept, &json!({}), &overrides, &f).is_empty());
}

#[test]
fn fixes_ledger_blocking_rows_for_the_start() {
	let ledger = json!({ "files": [
		{ "file": "data/route-fixes.json", "rows": [
			{ "at": "deliberate.after[8]", "state": "left out", "detail": "v1 breaks it", "blocking": true, "starts": { "Orc": "applied", "Human": "left out" } },
			{ "at": "deliberate.after[9]", "state": "applied", "detail": "", "blocking": false, "starts": { "Orc": "applied" } }
		] },
		{ "file": "forever-db/corrections", "rows": [{ "at": "quests.5", "state": "stale", "detail": "", "blocking": true }] }
	] });
	assert!(fixes_rows(&ledger, "Orc").is_empty());
	let h = fixes_rows(&ledger, "Human");
	assert_eq!(h.len(), 1);
	assert_eq!(h[0].message, "data/route-fixes.json deliberate.after[8]: left out (v1 breaks it)");
	let all = fixes_rows(&ledger, "all");
	assert_eq!(all.len(), 1);
	assert!(all[0].message.starts_with("forever-db/corrections quests.5: stale"));
}

#[test]
fn rare_or_unknown_chance_waits_must_be_optional() {
	let mut f = Facts::default();
	// Nibbled-On Book: unknown chance from three NPCs, starts 98000.
	f.items.insert(247834, item("Nibbled-On Book", &[(6, None), (80, None), (257, None)], &[]));
	f.items.insert(100, item("Wolf Fang", &[(5, Some(60.0))], &[]));
	// Objectives: a known 2 % drop is rare; an objective item with no chance in the data is not judged.
	f.items.insert(101, item("Glittering Sunstone", &[(9, Some(2.0))], &[]));
	f.items.insert(102, item("Wildkin Muisek", &[(10, None)], &[]));
	f.quests.insert(98000, QuestFacts { title: "A Nibbled Book".into(), start_items: vec![247834], ..Default::default() });
	let w = walk(vec![
		with_item(goal("collect", None, None), 247834),
		goal("accept", Some(98000), None),
		with_item(goal("collect", Some(7), None), 100),
		with_item(goal("collect", Some(8), None), 101),
		with_item(goal("collect", Some(8), None), 102),
	]);
	assert_eq!(
		lines(&rare_required(&w, &f)),
		vec![("horde/01-durotar.guide".into(), 100, "rare".into()), ("horde/01-durotar.guide".into(), 101, "rare".into()), ("horde/01-durotar.guide".into(), 103, "rare".into())]
	);
	let mut opt = w.clone();
	for g in &mut opt {
		g.optional = true;
	}
	assert!(rare_required(&opt, &f).is_empty());
	// The route fixes keep a quest optional.
	f.optional.insert(123, "rare drop".into());
	assert_eq!(rare_required(&walk(vec![goal("accept", Some(123), None)]), &f).len(), 1);
	// An unknown chance from one named NPC (Githyiss the Vile's fang) is its loot, not rare.
	f.items.insert(277190, item("Fang of Githyiss", &[(1994, None)], &[]));
	f.quests.insert(97236, QuestFacts { start_items: vec![277190], ..Default::default() });
	assert!(rare_required(&walk(vec![with_item(goal("collect", None, None), 277190), goal("accept", Some(97236), None)]), &f).is_empty());
}

#[test]
fn hearth_on_cooldown_blocks() {
	let at = |t: f64| {
		let mut g = goal("hearth", None, None);
		g.time = t;
		g
	};
	let w = walk(vec![at(0.0), at(1800.0), at(4000.0)]);
	let v = hearth_cooldown(&w, 3600.0);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 101, "hearth".into())]);
	assert!(v[0].message.starts_with("hearth 30 min after"), "{}", v[0].message);
	let route = json!({ "improved": { "planHearthsOnCooldown": 5 } });
	assert_eq!(planned_hearths(&route, "routes/Human.json").map(|v| v.rule), Some("hearth".into()));
	assert!(planned_hearths(&json!({ "improved": { "planHearthsOnCooldown": 0 } }), "x").is_none());
}

#[test]
fn bounce_to_a_place_with_nothing_done_blocks() {
	let (org, tb) = (pt(50.0, 45.0, 1454, 1), pt(500.0, 870.0, 1456, 1));
	let mut to_tb = goal("goto", None, Some(tb));
	to_tb.title = Some("Thunder Bluff".into());
	// A1c: Orgrimmar, "Thunder Bluff", back to Orgrimmar to train.
	let w = walk(vec![goal("goto", None, Some(org)), to_tb.clone(), goal("accept", Some(1718), Some(org))]);
	let v = bounces(&w);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 101, "bounce".into())]);
	// The Druid trains there (a pointless `train` in the Thunder Bluff step): no bounce.
	let w = walk(vec![goal("goto", None, Some(org)), to_tb.clone(), goal("train", None, None), goal("accept", Some(1718), Some(org))]);
	assert!(bounces(&w).is_empty());
	// Everyone else trains in the next step, whose zone is Orgrimmar: back where it came from.
	let mut train_org = goal("train", None, None);
	train_org.map = Some(1454);
	let w = walk(vec![goal("goto", None, Some(org)), to_tb, train_org]);
	assert_eq!(lines(&bounces(&w)), vec![("horde/01-durotar.guide".into(), 101, "bounce".into())]);
	// A18: hearth to the bind (Thelsamar), a goto into Searing Gorge, back to Thelsamar: the hearth's
	// landing is the bind's point.
	let (thel, gorge, darn) = (pt(100.0, 100.0, 1432, 0), pt(100.0, 400.0, 1427, 0), pt(10.0, 10.0, 1457, 1));
	let w = walk(vec![goal("sethome", None, Some(thel)), goal("turnin", Some(1), Some(darn)), goal("hearth", None, None), goal("goto", None, Some(gorge)), goal("goto", None, Some(thel))]);
	assert_eq!(lines(&bounces(&w)), vec![("horde/01-durotar.guide".into(), 103, "bounce".into())]);
	// Across the sea and straight back (the Silverpine "To Orgrimmar"), and an on-the-way waypoint is not.
	let (dock, silverpine) = (pt(50.0, 10.0, 1411, 1), pt(400.0, 400.0, 1421, 0));
	assert_eq!(bounces(&walk(vec![goal("goto", None, Some(dock)), goal("goto", None, Some(silverpine)), goal("accept", Some(2), Some(org))])).len(), 1);
	let (a, mid, c) = (pt(0.0, 0.0, 1411, 1), pt(100.0, 0.0, 1411, 1), pt(200.0, 0.0, 1411, 1));
	assert!(bounces(&walk(vec![goal("accept", Some(3), Some(a)), goal("goto", None, Some(mid)), goal("accept", Some(4), Some(c))])).is_empty());
}

#[test]
fn round_trip_warns_with_counts() {
	let d = crate::report::StreamDiff {
		order_h60: 100.0,
		written_h60: 103.0,
		only_in_order: vec!["accept 5052 Blood Shards".into()],
		only_written: vec!["accept 1 A".into(), "turnin 1 A".into()],
		out_of_order: Vec::new(),
		..Default::default()
	};
	let v = round_trip(&d, "routes/Orc.judge-improved.json").unwrap();
	assert_eq!(v.level, Level::Warn);
	assert!(v.message.starts_with("1 only in the model (accept 5052 Blood Shards), 2 only written"), "{}", v.message);
	assert!(v.message.ends_with("(+3.0 %)"), "{}", v.message);
	let same = crate::report::StreamDiff { order_h60: 100.0, written_h60: 100.2, ..Default::default() };
	assert!(round_trip(&same, "x").is_none());
}

#[test]
fn under_level_work_and_grey_turnins_warn() {
	let mut f = Facts::default();
	f.quests.insert(5821, quest("Bodyguard for Hire", 35.0));
	f.quests.insert(3923, quest("Rilli Greasygob", 18.0));
	let at = |t: &str, q: i64, lvl: f64| {
		let mut g = goal(t, Some(q), None);
		g.lvl = lvl;
		g
	};
	let w = walk(vec![at("accept", 5821, 30.3), at("kill", 5821, 30.3), at("kill", 5821, 31.0), at("turnin", 3923, 50.2), at("turnin", 5821, 35.0)]);
	let v = levels(&w, &f);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 101, "under-level".into()), ("horde/01-durotar.guide".into(), 103, "grey".into())]);
	assert!(v.iter().all(|v| v.level == Level::Warn));
}

#[test]
fn class_walks_merge_into_one_line_naming_the_classes() {
	let all = vec!["WARRIOR".to_string(), "MAGE".to_string(), "DRUID".to_string()];
	let v = |line| Violation::new("a.guide", line, "bounce", Level::Blocker, "x");
	let merged = merge_classes(vec![("WARRIOR".into(), vec![v(1), v(2)]), ("MAGE".into(), vec![v(1)]), ("DRUID".into(), vec![v(1)])], &all);
	assert_eq!(merged.len(), 2);
	assert!(merged[0].classes.is_empty());
	assert_eq!(merged[1].classes, vec!["Warrior".to_string()]);
	let mut o = Output { starts: vec![StartSummary { start: "Orc".into(), ..Default::default() }], violations: merged };
	for x in &mut o.violations {
		x.start = "Orc".into();
	}
	o.finish();
	assert_eq!(o.text(), "Orc a.guide:1 bounce blocker: x\nOrc a.guide:2 bounce blocker: x [Warrior]\n");
	assert_eq!(o.starts[0].blockers, 2);
}

fn feel_of(returns: usize, zone_changes: usize, passed_by: usize, area_visits: usize) -> Feel {
	Feel { hours: 120.0, grind_min: 300.0, grind_shown_min: 200.0, grind_unwritten_min: 100.0, returns, wasted_trips: 10, zone_changes, passed_by, pb_never: 50, pb_later: passed_by - 50, area_visits }
}

#[test]
fn grind_is_all_the_models_grinding_with_the_written_part_beside() {
	// GrindWhy (c14): only `level` steps counted, so a route that grinds the same with its `level` lines
	// left out read as grinding less. Every goal's model grind counts; the `level` goals' are the shown part.
	let ground = |t: &str, sec: f64| {
		let mut g = goal(t, None, None);
		g.grind = sec;
		g
	};
	let w = vec![ground("level", 600.0), ground("accept", 1200.0), ground("kill", 0.0), ground("level", 300.0)];
	assert_eq!(crate::report::grind_split(&w, 99.0), (35.0, 15.0));
	// The same grind, unwritten (no `level` goal): all of it still counts.
	let hidden = vec![ground("accept", 1500.0), ground("kill", 600.0)];
	assert_eq!(crate::report::grind_split(&hidden, 0.0), (35.0, 0.0));
	// A recorded JS walk (no model grind): the `level` goals' time, as gmeasure.js.
	assert_eq!(crate::report::grind_split(&[goal("level", None, None)], 12.0), (12.0, 12.0));
	let m = crate::report::Measures { grind_min: 15.0, grind_all_min: 35.0, grind_shown_min: 15.0, ..Default::default() };
	let f = Feel::of(&m);
	assert_eq!((f.grind_min, f.grind_shown_min, f.grind_unwritten_min), (35.0, 15.0, 20.0));
}

#[test]
fn feel_blocks_a_metric_worse_than_v1_beyond_its_tolerance() {
	// c6 Orc: returns 68 -> 84, zone changes 99 -> 108, passed by 146 -> 159, area visits 745 -> 755.
	let (v1, written) = (feel_of(68, 99, 146, 745), feel_of(84, 108, 159, 755));
	let v = feel(&v1, &written, "guides/Orc");
	let msgs: Vec<&str> = v.iter().map(|v| v.message.as_str()).collect();
	assert_eq!(
		msgs,
		vec![
			"avoidable returns: 68 in v1's guides, 84 written (+16, tolerance 2)",
			"zone changes: 99 in v1's guides, 108 written (+9, tolerance 2)",
			"quests passed by: 146 in v1's guides, 159 written (+13, tolerance 2)"
		]
	);
	// A count is shown, never gating.
	assert!(v.iter().all(|v| v.level == Level::Info && v.rule == "feel"));
	// Area visits +10 on 745 is within 2 % (14); returns +2 is within the floor of 2.
	assert!(feel(&v1, &feel_of(70, 101, 148, 759), "x").is_empty());
	// Better than v1: nothing.
	assert!(feel(&written, &v1, "x").is_empty());
}

fn ret(area: &str, at: &str, quests: &[i64]) -> Ret {
	Ret { area: area.into(), zone: "Z".into(), wasted: false, at: at.into(), quests: quests.to_vec(), before: vec![900], names: Vec::new(), chain: false, goals: Vec::new(), depart: 0 }
}

#[test]
fn added_returns_are_the_ones_v1_does_not_make_split_order_and_writer() {
	let v1 = vec![ret("Crossroads", "a.guide:1", &[1]), ret("Ratchet", "a.guide:2", &[2])];
	// Same Crossroads return; a second Crossroads return (new quests); a new Sepulcher return; Ratchet's moved.
	let written = vec![ret("Crossroads", "a.guide:10", &[1]), ret("Crossroads", "a.guide:20", &[3]), ret("Sepulcher", "b.guide:30", &[4]), ret("Ratchet", "a.guide:40", &[5])];
	// The model order adds a Crossroads return over v1's chain, not a Sepulcher one.
	let order_v1 = vec![ret("Crossroads", "goal 1", &[1])];
	let order = vec![ret("Crossroads", "goal 1", &[1]), ret("Crossroads", "goal 9", &[3])];
	let edits = json!({ "list": [{ "n": 7, "kept": true, "q": 3, "steps": [] }, { "n": 8, "kept": false, "q": 3 }, { "n": 9, "kept": true, "q": 77, "steps": [{ "q": 900 }] }] });
	let (v, split) = added_returns(&v1, &written, Some((&order, &order_v1)), &edits);
	assert_eq!(lines(&v), vec![("a.guide".into(), 20, "feel-return".into()), ("b.guide".into(), 30, "feel-return".into())]);
	assert_eq!(split, (1, 1));
	assert!(v[0].message.ends_with("in the model order (route edits #7, #9)"), "{}", v[0].message);
	assert!(v[1].message.contains("the writer's"), "{}", v[1].message);
	assert!(v.iter().all(|v| v.level == Level::Info));
}

#[test]
fn added_zone_changes_name_the_pair_and_its_source() {
	let at = |q: i64, map: u32| goal("accept", Some(q), Some(pt(1.0, 1.0, map, 1)));
	// v1: Durotar -> Barrens once; written: Durotar -> Barrens -> Durotar -> Barrens.
	let v1 = walk(vec![at(1, 1411), at(2, 1413)]);
	let written = walk(vec![at(1, 1411), at(2, 1413), at(3, 1411), at(4, 1413)]);
	let zone = |m: u32| if m == 1411 { "Durotar".to_string() } else { "The Barrens".to_string() };
	let no_pre = |_: i64| Vec::new();
	let (v, split) = added_zone_changes(&v1, &written, None, &zone, &no_pre);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 102, "feel-zone".into()), ("horde/01-durotar.guide".into(), 103, "feel-zone".into())]);
	assert_eq!(v[1].message, "zone change Durotar to The Barrens: 1 in v1's guides, 2 written: the writer's (the model order does not add it)");
	assert_eq!(split, (0, 2));
	// The model order makes the Barrens -> Durotar change too: that one is the order's.
	let (_, split) = added_zone_changes(&v1, &written, Some((&written, &v1)), &zone, &no_pre);
	assert_eq!(split, (2, 0));
	// Quest 4 opens at quest 3's hand-in in Durotar: the second trip into the Barrens is a chain.
	let mut chained = written.clone();
	chained[2].t = "turnin".into();
	let pre = |q: i64| if q == 4 { vec![3] } else { Vec::new() };
	let (v, split) = added_zone_changes(&v1, &chained, None, &zone, &pre);
	assert_eq!((lines(&v).len(), split), (1, (0, 1)));
	assert!(v[0].message.starts_with("zone change The Barrens to Durotar"), "{}", v[0].message);
}

/// Brill: five quests at the camp north of town, hand them in at Brill, back to the camp for the
/// leaders the hand-in opened. The return is a chain, not avoidable.
#[test]
fn a_return_for_a_follow_up_opened_since_the_last_visit_is_a_chain() {
	let (camp, brill) = (pt(10.0, 60.0, 1420, 0), pt(40.0, 60.0, 1420, 0));
	let g = walk(vec![goal("kill", Some(370), Some(camp)), goal("turnin", Some(370), Some(brill)), goal("accept", Some(371), Some(brill)), goal("kill", Some(371), Some(camp))]);
	let pre = |q: i64| if q == 371 { vec![370] } else { Vec::new() };
	// The camp's second visit (goal 3) after leaving at goal 0: 371 opened at the hand-in (goal 1).
	assert!(is_chain_return(&g, 0, &[(3, 371)], &pre));
	// A quest with no prerequisite handed in between: avoidable as before.
	assert!(!is_chain_return(&g, 0, &[(3, 372)], &pre));
	// Handed in before the last visit left: not this return's cause.
	assert!(!is_chain_return(&g, 1, &[(3, 371)], &pre));
	// The prerequisite handed in on the return itself (at the camp, goal 1 of a return starting there):
	// the last visit could not have used it either way, but the return is not caused by it.
	assert!(!is_chain_return(&g, 0, &[(1, 370), (3, 371)], &pre));
	// Zones: Durotar, the Barrens hand-in, back to Durotar for the follow-up.
	let (dur, bar) = (pt(1.0, 1.0, 1411, 1), pt(5.0, 5.0, 1413, 1));
	let z = walk(vec![goal("kill", Some(1), Some(dur)), goal("turnin", Some(1), Some(bar)), goal("kill", Some(2), Some(dur))]);
	let pre = |q: i64| if q == 2 { vec![1] } else { Vec::new() };
	assert!(is_chain_zone(&z, 2, &pre));
	assert!(!is_chain_zone(&z, 1, &pre));
}

#[test]
fn player_view_table_tops_check_md() {
	let mut o = Output {
		starts: vec![StartSummary {
			start: "Orc".into(),
			feel: Some(FeelRow {
				v1: feel_of(68, 99, 146, 745),
				written: feel_of(84, 108, 159, 755),
				order_returns: 75,
				v1_order_returns: 70,
				added_returns: (4, 12),
				added_zone_changes: (3, 6),
				chain_returns: (2, 5),
				chain_zone_changes: (1, 3),
			}),
			..Default::default()
		}],
		violations: Vec::new(),
	};
	o.finish();
	let md = o.markdown();
	let view = md.find("## Player view").unwrap();
	assert!(view < md.find("| start | blockers").unwrap());
	assert!(md.contains("| Orc | 120.0 -> 120.0 | 300 (200 + 100) -> 300 (200 + 100) | 68 (10) -> 84 (10) | 99 -> 108 | 146 (50) -> 159 (50) | 745 -> 755 | 2 (1) -> 5 (3) | 4 / 12 | 3 / 6 | 0 | 0 | 0 |"), "{md}");
	assert!(md.contains("Orc 70 -> 75"));
}

/// A goal at a place, level `lvl`.
fn at(t: &str, q: Option<i64>, p: WPt, lvl: f64) -> WalkGoal {
	let mut g = goal(t, q, Some(p));
	g.lvl = lvl;
	g.lvl_after = lvl;
	g
}

/// Open from level 1, level 10, offered by an NPC.
fn open_quest(f: &mut Facts, q: i64, pre: &[i64]) {
	f.quests.insert(q, QuestFacts { title: format!("Q{q}"), level: Some(10.0), min_level: Some(1.0), start_giver: true, pre: pre.to_vec(), ..Default::default() });
}

#[test]
fn dup_trip_is_a_return_nothing_there_needed() {
	// Crossroads trainer, Regthar 1,500 yd away, back to the trainer, back to Regthar.
	let (trainer, regthar) = (pt(50.0, 30.0, 1413, 1), pt(50.0, 180.0, 1413, 1));
	let mut f = Facts::default();
	for q in [852, 1361, 5] {
		open_quest(&mut f, q, &[]);
	}
	let mut train = at("train", None, trainer, 10.2);
	train.w = Some(trainer);
	let w = walk(vec![train.clone(), at("turnin", Some(852), regthar, 10.3), train.clone(), at("accept", Some(1361), regthar, 10.4)]);
	let v = dup_trips(&w, &f);
	// The second training needed nothing from Regthar (same level); the second Regthar stop needed
	// nothing from the trainer either.
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 102, "dup-trip".into()), ("horde/01-durotar.guide".into(), 103, "dup-trip".into())]);
	assert!(v.iter().all(|v| v.level == Level::Blocker));
	// A hand-in at the other place that opens the quest taken back here: a chain, not a dup.
	open_quest(&mut f, 6, &[852]);
	let w = walk(vec![at("accept", Some(5), trainer, 10.0), at("turnin", Some(852), regthar, 10.3), at("accept", Some(6), trainer, 10.4)]);
	assert!(dup_trips(&w, &f).is_empty());
	// A turn-in back here of a quest worked at the other place: needed.
	let w = walk(vec![at("accept", Some(5), trainer, 10.0), at("kill", Some(5), regthar, 10.3), at("turnin", Some(5), trainer, 10.4)]);
	assert!(dup_trips(&w, &f).is_empty());
	// A training a level later: needed.
	let w = walk(vec![at("accept", Some(5), trainer, 10.0), at("turnin", Some(852), regthar, 10.6), at("train", None, trainer, 11.1)]);
	assert!(dup_trips(&w, &f).is_empty());
}

#[test]
fn next_to_is_an_open_quest_whose_giver_the_walk_stood_by_before() {
	// Ratchet: the walk takes 1 at Gazlowe, leaves for the coast, comes back for 2 (open all along).
	let (gazlowe, coast) = (pt(60.0, 60.0, 1413, 1), pt(60.0, 260.0, 1413, 1));
	let mut f = Facts::default();
	open_quest(&mut f, 1, &[]);
	open_quest(&mut f, 2, &[]);
	open_quest(&mut f, 3, &[1]);
	let w = walk(vec![
		at("accept", Some(1), gazlowe, 12.0),
		at("kill", Some(1), coast, 12.5),
		at("turnin", Some(1), gazlowe, 13.0),
		at("accept", Some(2), gazlowe, 13.0),
		at("accept", Some(3), gazlowe, 13.0),
	]);
	let v = next_to(&w, &f);
	// 2 was open at the first visit; 3 opened at 1's hand-in (this visit): not missed.
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 103, "next-to".into())]);
	assert_eq!(v[0].level, Level::Warn);
	assert!(v[0].message.contains("horde/01-durotar.guide:100"), "{}", v[0].message);
	// Out of level at the first visit (quest level 20): not missed.
	f.quests.get_mut(&2).unwrap().level = Some(20.0);
	assert!(next_to(&w, &f).is_empty());
	// Camp Taurajo, one visit: a `vendor nearest` whose point is a vendor far off, an optional goal far
	// off, then 2 taken at the same giver: the walk never left, nothing missed.
	f.quests.get_mut(&2).unwrap().level = Some(10.0);
	let mut far_opt = at("kill", Some(9), coast, 12.0);
	far_opt.optional = true;
	let w = walk(vec![at("accept", Some(1), gazlowe, 12.0), at("vendor", None, coast, 12.0), far_opt, at("accept", Some(2), gazlowe, 12.0)]);
	assert!(next_to(&w, &f).is_empty());
	// Deathknell: Sarvis' step, then Venya's imp quest beside him in a later step with no trip away:
	// flagged at its first step by the giver.
	let (sarvis, venya, zombies) = (pt(30.84, 66.2, 1420, 0), pt(30.98, 66.41, 1420, 0), pt(30.84, 160.0, 1420, 0));
	let mut w = walk(vec![at("accept", Some(1), sarvis, 2.0), at("kill", Some(1), zombies, 2.5), at("turnin", Some(1), sarvis, 3.0), at("accept", Some(2), venya, 3.0)]);
	for (k, s) in [2, 3, 4, 5].into_iter().enumerate() {
		w[k].step = Some(s);
	}
	f.quests.get_mut(&2).unwrap().level = Some(3.0);
	let v = next_to(&w, &f);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 103, "next-to".into())]);
	assert!(v[0].message.contains("horde/01-durotar.guide:100"), "{}", v[0].message);
}

#[test]
fn split_is_an_objective_left_for_after_a_hand_in_trip() {
	// Plainstriders and zhevra share the plains; the guide kills the striders, walks back to hand in,
	// then returns for the zhevra.
	let (plains, plains2, town) = (pt(40.0, 40.0, 1413, 1), pt(48.0, 40.0, 1413, 1), pt(40.0, 240.0, 1413, 1));
	let mut f = Facts::default();
	for q in [10, 11, 12] {
		open_quest(&mut f, q, &[]);
	}
	let w =
		walk(vec![at("accept", Some(10), town, 10.0), at("accept", Some(11), town, 10.0), at("kill", Some(10), plains, 10.5), at("turnin", Some(10), town, 11.0), at("kill", Some(11), plains2, 11.2)]);
	let v = splits(&w, &f);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 104, "split".into())]);
	assert_eq!(v[0].level, Level::Warn);
	// Taken only after the first visit: nothing to fold.
	let w =
		walk(vec![at("accept", Some(10), town, 10.0), at("kill", Some(10), plains, 10.5), at("turnin", Some(10), town, 11.0), at("accept", Some(11), town, 11.0), at("kill", Some(11), plains2, 11.2)]);
	assert!(splits(&w, &f).is_empty());
}

/// A field goal of `q`.`oi` with spawn spots.
fn field(t: &str, q: i64, oi: i64, spots: &[WPt]) -> WalkGoal {
	let mut g = goal(t, Some(q), spots.first().copied());
	g.oi = Some(oi);
	g.spots = spots.to_vec();
	g
}

/// Goals with their step numbers (the step lines).
fn in_steps(mut g: Vec<WalkGoal>, steps: &[u32]) -> Vec<WalkGoal> {
	g = walk(g);
	for (x, s) in g.iter_mut().zip(steps) {
		x.step = Some(*s);
	}
	g
}

#[test]
fn merge_finds_overlapping_objectives_written_apart_in_one_visit() {
	// Barrens: plainstriders and zhevra on the same ground, each in its own step.
	let (town, plains, plains2, far) = (pt(0.0, 0.0, 1413, 1), pt(100.0, 0.0, 1413, 1), pt(108.0, 0.0, 1413, 1), pt(100.0, 60.0, 1413, 1));
	let none = FxHashSet::default();
	let w = in_steps(vec![goal("accept", Some(1), Some(town)), goal("accept", Some(2), Some(town)), field("kill", 1, 1, &[plains]), field("kill", 2, 1, &[plains2])], &[1, 1, 2, 3]);
	let v = merges(&w, &none);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 103, "merge".into())]);
	assert!(v[0].message.contains("80 yd"), "{}", v[0].message);
	// The second quest taken only after: nothing to merge.
	let w = in_steps(vec![goal("accept", Some(1), Some(town)), field("kill", 1, 1, &[plains]), goal("accept", Some(2), Some(town)), field("kill", 2, 1, &[plains2])], &[1, 2, 3, 4]);
	assert!(merges(&w, &none).is_empty());
	// One step, arrow order: plains, the far hill (600 yd), back to the plains.
	let w = in_steps(
		vec![
			goal("accept", Some(1), Some(town)),
			goal("accept", Some(2), Some(town)),
			goal("accept", Some(3), Some(town)),
			field("kill", 1, 1, &[plains]),
			field("kill", 3, 1, &[far]),
			field("kill", 2, 1, &[plains2]),
		],
		&[1, 1, 1, 2, 2, 2],
	);
	assert_eq!(lines(&merges(&w, &none)), vec![("horde/01-durotar.guide".into(), 105, "merge".into())]);
	// The same step as a `loop`: one circuit, no arrow order.
	let looped: FxHashSet<(String, u32)> = [("forever/horde/01-durotar".to_string(), 2)].into_iter().collect();
	assert!(merges(&w, &looped).is_empty());
}

#[test]
fn along_finds_uncovered_legs_and_lines_off_the_way() {
	// The road from town (0) to the camp (2,000 yd east) passes the spiders' den 40 yd off at 1,000.
	let (town, camp, den, weed) = (pt(0.0, 0.0, 1413, 1), pt(200.0, 0.0, 1413, 1), pt(100.0, 4.0, 1413, 1), pt(100.0, 80.0, 1413, 1));
	let w = in_steps(vec![goal("accept", Some(1), Some(town)), goal("accept", Some(2), Some(camp)), goal("turnin", Some(2), Some(camp)), field("collect", 1, 1, &[den])], &[1, 2, 2, 3]);
	// Taken at the town, the den passed on the way to the camp, worked only after: uncovered.
	let w2 = in_steps(vec![w[0].clone(), goal("goto", None, Some(camp)), w[2].clone(), w[3].clone()], &[1, 2, 2, 3]);
	let v = alongs(&w2);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 100, "along".into())]);
	// An along line until the den's step covers it.
	let mut al = field("collect", 1, 1, &[den]);
	al.along = Some("den".into());
	let mut at_den = field("collect", 1, 1, &[den]);
	at_den.label = Some("den".into());
	let w3 = in_steps(vec![w[0].clone(), al.clone(), goal("goto", None, Some(camp)), w[2].clone(), at_den], &[1, 1, 2, 2, 3]);
	assert!(alongs(&w3).is_empty());
	// An along line whose objective (Doom Weed, 800 yd off the road) no leg passes.
	let mut weed_line = field("collect", 3, 1, &[weed]);
	weed_line.along = Some(String::new());
	let w4 = in_steps(vec![goal("accept", Some(3), Some(town)), weed_line, goal("goto", None, Some(camp))], &[1, 1, 2]);
	let v = alongs(&w4);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 101, "along".into())]);
	assert!(v[0].message.contains("800 yd"), "{}", v[0].message);
}

#[test]
fn arrow_order_flags_a_far_first_goal() {
	let (entry, near, farther) = (pt(0.0, 0.0, 1413, 1), pt(10.0, 0.0, 1413, 1), pt(60.0, 0.0, 1413, 1));
	let none = FxHashSet::default();
	// Entered at 0: the first goal 600 yd off, the second 100 yd.
	let w = in_steps(vec![goal("accept", Some(1), Some(entry)), field("kill", 1, 1, &[farther]), field("kill", 1, 2, &[near])], &[1, 2, 2]);
	let v = arrow_order(&w, &none);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 101, "arrow-order".into())]);
	// Nearer first: fine.
	let w = in_steps(vec![goal("accept", Some(1), Some(entry)), field("kill", 1, 2, &[near]), field("kill", 1, 1, &[farther])], &[1, 2, 2]);
	assert!(arrow_order(&w, &none).is_empty());
}

#[test]
fn not_ready_is_an_accept_before_its_prerequisite_or_its_level() {
	// The Binding (2) before Creature of the Void (1) is handed in; 3 at level 16 with 20 needed.
	let (a, b) = (pt(10.0, 10.0, 1420, 0), pt(10.0, 30.0, 1420, 0));
	let mut f = Facts::default();
	open_quest(&mut f, 1, &[]);
	open_quest(&mut f, 2, &[1]);
	open_quest(&mut f, 3, &[]);
	f.quests.get_mut(&3).unwrap().min_level = Some(20.0);
	let w = walk(vec![at("accept", Some(1), a, 10.0), at("accept", Some(2), a, 10.0), at("accept", Some(3), b, 16.0), at("turnin", Some(1), a, 11.0)]);
	let v = not_ready(&w, &f);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 101, "not-ready".into()), ("horde/01-durotar.guide".into(), 102, "not-ready".into())]);
	assert_eq!(v[0].level, Level::Blocker);
}

#[test]
fn a_chapter_is_taken_with_its_parent_in_the_log_not_after_its_hand_in() {
	// Chapter I (339): the data's `pre` lists its parent The Green Hills of Stranglethorn (338), which
	// the TDB has as a negative PrevQuestID: in the log, not handed in (c13 STV false not-ready).
	let pre = quest_pre(&[338], &[], &[], Some(338));
	assert!(pre.is_empty(), "the parent is no hand-in prerequisite: {pre:?}");
	let a = pt(10.0, 10.0, 1434, 0);
	let mut f = Facts::default();
	open_quest(&mut f, 338, &[]);
	open_quest(&mut f, 339, &pre);
	f.quests.get_mut(&339).unwrap().parent = Some(338);
	// Taken while 338 is open, handed in before it: fine.
	let w = walk(vec![at("accept", Some(338), a, 34.0), at("accept", Some(339), a, 35.0), at("turnin", Some(339), a, 36.0), at("turnin", Some(338), a, 36.0)]);
	assert!(not_ready(&w, &f).is_empty());
	// Taken after 338 is handed in: the game refuses it.
	let w = walk(vec![at("accept", Some(338), a, 34.0), at("turnin", Some(338), a, 36.0), at("accept", Some(339), a, 36.0)]);
	let v = not_ready(&w, &f);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 102, "not-ready".into())]);
	assert!(v[0].message.contains("Q338 (338) must be in the log, and is handed in already"), "{}", v[0].message);
}

#[test]
fn not_ready_reads_breadcrumbs_and_parents_right() {
	// The data's shapes (RevH2-3, c13): Securing the Supply Lines 8280 lists its breadcrumbs 8275/8276 as
	// `pre`, and 8276's `next` is 8280; Stranglethorn Fever's log quest 349 has its parent 348 as `pre`
	// and 348's `next`.
	assert_eq!(quest_pre(&[8275, 8276], &[8276], &[8275, 8276], None), Vec::<i64>::new());
	assert_eq!(quest_pre(&[348], &[348], &[], Some(348)), Vec::<i64>::new());
	assert_eq!(quest_pre(&[1, 2], &[3], &[2], None), vec![1, 3], "a real prerequisite stays");
	let a = pt(10.0, 10.0, 1420, 0);
	let mut f = Facts::default();
	for (q, pre) in [(8276, &[][..]), (8280, &[][..]), (348, &[][..]), (349, &[][..])] {
		open_quest(&mut f, q, pre);
	}
	f.quests.get_mut(&349).unwrap().parent = Some(348);
	// 8280 without its breadcrumb (handed in later, on another walk's way), 349 with 348 in the log and
	// 348 handed in after: nothing to report.
	let w = walk(vec![
		at("accept", Some(8280), a, 55.0),
		at("accept", Some(8276), a, 55.0),
		at("turnin", Some(8276), a, 55.0),
		at("accept", Some(348), a, 45.0),
		at("accept", Some(349), a, 45.0),
		at("turnin", Some(349), a, 45.0),
		at("turnin", Some(348), a, 45.0),
	]);
	assert!(not_ready(&w, &f).is_empty(), "{:?}", not_ready(&w, &f));
	// 349 taken before its parent is in the log: the game does not offer it.
	let w = walk(vec![at("accept", Some(349), a, 45.0), at("accept", Some(348), a, 45.0)]);
	let v = not_ready(&w, &f);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 100, "not-ready".into())]);
	assert!(v[0].message.contains("must be in the log"), "{:?}", v);
}

#[test]
fn class_lost_is_a_seed_class_quest_no_written_guide_takes() {
	// The Dwarf Paladins' Tome of Divinity (2999, Paladin, Dwarf only) left the written Dun Morogh
	// (RevDwarfGnome3, c13); a Gnome start has no Paladin; an optional or a kept class quest is fine.
	let mut f = Facts::default();
	f.quests.insert(2999, QuestFacts { title: "Tome of Divinity".into(), classes: 2, races: 4, ..Default::default() });
	f.quests.insert(1599, QuestFacts { title: "Beginnings".into(), classes: 256, races: 0, ..Default::default() });
	f.quests.insert(5, QuestFacts { title: "Anyone".into(), ..Default::default() });
	f.quests.insert(7, QuestFacts { title: "Every Dwarf class".into(), classes: 1 | 2 | 4 | 8 | 16 | 64, races: 4, ..Default::default() });
	let seed = vec![(
		"alliance/dwarf-gnome/01-dun-morogh.guide".to_string(),
		"guide x\n\nstep Tome\n  only Paladin\n  accept 2999                -- Brandur Ironhammer\n  accept 1599 optional\n  accept 5\n  accept 7\n".to_string(),
	)];
	let dwarf: Vec<String> = ["WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN"].map(String::from).to_vec();
	let gnome: Vec<String> = ["WARRIOR", "ROGUE", "MAGE", "WARLOCK"].map(String::from).to_vec();
	let none_written = vec!["guide y\n\nstep A\n  accept 5\n".to_string()];
	let v = lost_class_quests(&seed, &none_written, &f, 4, &dwarf);
	assert_eq!(lines(&v), vec![("alliance/dwarf-gnome/01-dun-morogh.guide".into(), 5, "class-lost".into())]);
	assert_eq!((v[0].level, v[0].classes.clone()), (Level::Blocker, vec!["Paladin".to_string()]));
	assert!(v[0].message.contains("Tome of Divinity (2999)"), "{:?}", v);
	// Written somewhere in the start's tree: kept.
	let kept = vec!["guide z\n\nstep B\n  accept 2999 only Paladin\n".to_string()];
	assert!(lost_class_quests(&seed, &kept, &f, 4, &dwarf).is_empty());
	// A Gnome (bit 64) plays no Paladin, and 2999 is for Dwarves only.
	assert!(lost_class_quests(&seed, &none_written, &f, 64, &gnome).is_empty());
}

#[test]
fn hub_order_is_a_visit_walked_the_long_way_round() {
	// Brill west to east, Holland, Dillinger, Zygand 100 yd apart; the walk comes in from the west
	// field and leaves for the east one, but goes to Zygand first and back (#740).
	let (field_w, holland, dillinger, zygand, field_e) = (pt(0.0, 0.0, 1420, 0), pt(10.0, 0.0, 1420, 0), pt(20.0, 0.0, 1420, 0), pt(30.0, 0.0, 1420, 0), pt(80.0, 0.0, 1420, 0));
	let mut f = Facts::default();
	for q in [1, 2, 3, 9] {
		open_quest(&mut f, q, &[]);
	}
	let visit = |order: [(i64, WPt); 3]| {
		let mut g = vec![at("kill", Some(9), field_w, 6.0)];
		g.extend(order.iter().map(|&(q, p)| at("accept", Some(q), p, 6.0)));
		g.push(at("kill", Some(9), field_e, 6.0));
		walk(g)
	};
	let v = hub_order(&visit([(3, zygand), (1, holland), (2, dillinger)]), &f);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 101, "hub-order".into())]);
	assert_eq!(v[0].level, Level::Warn);
	assert!(v[0].message.contains("1200 yd") && v[0].message.contains("800 yd"), "{}", v[0].message);
	// One sweep west to east: fine.
	assert!(hub_order(&visit([(1, holland), (2, dillinger), (3, zygand)]), &f).is_empty());
	// Zygand's hand-in opens Dillinger's accept: Zygand first is the quests' own order.
	open_quest(&mut f, 2, &[3]);
	let mut w = visit([(3, zygand), (1, holland), (2, dillinger)]);
	w[1].t = "turnin".into();
	assert!(hub_order(&w, &f).iter().all(|v| v.message.contains("lines 101")), "{:?}", hub_order(&w, &f));
}

#[test]
fn walked_past_is_a_ready_hand_in_passed_and_left_for_later() {
	// Deathknell: the cave's work done, the walk back to the church passes Aramis 30 yd off, goes on
	// to the Scarlet farm and hands A Light in the Darkness in later (#736).
	let (church, cave, aramis, farm) = (pt(0.0, 0.0, 1420, 0), pt(50.0, 0.0, 1420, 0), pt(25.0, 3.0, 1420, 0), pt(0.0, 50.0, 1420, 0));
	let w = walk(vec![at("accept", Some(1), aramis, 4.0), at("kill", Some(1), cave, 4.5), at("accept", Some(2), church, 4.6), at("kill", Some(2), farm, 5.0), at("turnin", Some(1), aramis, 5.5)]);
	let v = walked_past(&w);
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 104, "walked-past".into())]);
	// (Passed on the leg from the cave, 101; on to the church 250 yd from Aramis, 102.)
	assert!(v[0].message.contains("01-durotar.guide:101") && v[0].message.contains("01-durotar.guide:102"), "{}", v[0].message);
	// Where the routes stage hands it in instead (forge_sim::flow): after the cave's goal the leg
	// starts at, else before the church's it ends at.
	let fix = walked_past_at(&w);
	assert_eq!((fix[0].lines.clone(), fix[0].after, fix[0].before), (vec![4], 1, 2));
	// Handed in on the way back: fine.
	let w = walk(vec![at("accept", Some(1), aramis, 4.0), at("kill", Some(1), cave, 4.5), at("turnin", Some(1), aramis, 4.6), at("kill", Some(2), farm, 5.0)]);
	assert!(walked_past(&w).is_empty());
	// Passed before the work was done: not ready, fine.
	let w = walk(vec![at("accept", Some(1), church, 4.0), at("kill", Some(2), cave, 4.5), at("kill", Some(1), farm, 4.6), at("turnin", Some(1), aramis, 5.5)]);
	assert!(walked_past(&w).is_empty());
}

#[test]
fn left_ready_is_a_hub_line_ready_at_a_visit_and_done_on_a_return() {
	// Arren and Aramis 50 yd apart: back from the cave, Arren's hand-in and his follow-up, then off to
	// the farm 400 yd away; Aramis' ready hand-in and an accept open since the first visit taken on
	// the return.
	let (arren, aramis, cave, farm) = (pt(0.0, 0.0, 1420, 0), pt(5.0, 0.0, 1420, 0), pt(-60.0, 0.0, 1420, 0), pt(40.0, 0.0, 1420, 0));
	let mut f = Facts::default();
	for q in [1, 2, 4] {
		open_quest(&mut f, q, &[]);
	}
	open_quest(&mut f, 3, &[2]);
	open_quest(&mut f, 5, &[3]);
	let w = walk(vec![
		at("accept", Some(1), aramis, 6.0),
		at("accept", Some(2), arren, 6.0),
		at("kill", Some(1), cave, 6.5),
		at("kill", Some(2), cave, 6.5),
		at("turnin", Some(2), arren, 6.6),
		at("accept", Some(3), arren, 6.6),
		at("kill", Some(3), farm, 7.0),
		at("turnin", Some(1), aramis, 7.5),
		at("accept", Some(4), aramis, 7.5),
		at("turnin", Some(3), arren, 7.6),
		at("accept", Some(5), arren, 7.7),
	]);
	let mut v = left_ready(&w, &f);
	v.sort_by_key(|v| v.line);
	// The hand-in (ready at the second visit) and the open accept (at the first); not 3's hand-in
	// (worked at the farm) nor 5 (opened by 3's hand-in).
	assert_eq!(lines(&v), vec![("horde/01-durotar.guide".into(), 107, "left-ready".into()), ("horde/01-durotar.guide".into(), 108, "left-ready".into())]);
	assert!(v[0].message.contains("01-durotar.guide:105") && v[1].message.contains("01-durotar.guide:101"), "{v:?}");
	assert!(v.iter().all(|v| v.level == Level::Warn));
}
