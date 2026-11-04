//! `forge data talents`: a made-up two-column tree (A with 3 ranks -> B by an arrow, C gated on 3
//! points in column one, D alone in column two) resolved and replayed under the client's rules, the
//! Lua it writes and how the addon reads it, and the committed plans and Builds.lua checked against
//! each other (and, when the pinned Forever tables are cached, replayed on them).

use std::path::{Path, PathBuf};

use forge_data::talents::{build_all, replay, tree_facts, Pick, Tables, BUILD, PREREQ_RULE, TABLES};
use forge_guide::js::{parse_json, V};

fn rows(header: &str, lines: &[&str]) -> forge_data::jsv::Rows {
	forge_data::tables::parse_csv(&format!("{header}\n{}\n", lines.join("\n"))).unwrap()
}

fn tables() -> Tables {
	let mut t = Tables::default();
	t.insert("SkillLineXTraitTree".into(), rows("ID,SkillLineID,TraitTreeID", &["1,184,1100"]));
	t.insert("TraitNode".into(), rows("ID,TraitTreeID,PosX,PosY", &["1,1100,1000,100", "2,1100,1600,100", "3,1100,1000,700", "4,1100,9000,100", "9,5,0,0"]));
	t.insert("TraitNodeXTraitNodeEntry".into(), rows("ID,TraitNodeID,TraitNodeEntryID,_Index", &["1,1,11,0", "2,2,12,0", "3,3,13,0", "4,4,14,0"]));
	t.insert("TraitNodeEntry".into(), rows("ID,TraitDefinitionID,MaxRanks", &["11,21,3", "12,22,1", "13,23,2", "14,24,5"]));
	t.insert("TraitDefinition".into(), rows("ID,SpellID,OverrideName_lang", &["21,121,", "22,122,", "23,123,", "24,124,"]));
	t.insert("SpellName".into(), rows("ID,Name_lang", &["121,Alpha", "122,Beta", "123,Gamma", "124,Delta"]));
	t.insert("TraitNodeGroupXTraitNode".into(), rows("TraitNodeGroupID,TraitNodeID", &["50,1", "50,2", "50,3", "60,3"]));
	t.insert("TraitNodeGroupXTraitCond".into(), rows("TraitCondID,TraitNodeGroupID", &["70,60"]));
	t.insert("TraitCond".into(), rows("ID,CondType,TraitNodeGroupID,SpentAmountRequired", &["70,0,50,3"]));
	t.insert("TraitEdge".into(), rows("LeftTraitNodeID,RightTraitNodeID,Type", &["1,2,2", "2,1,0"]));
	t
}

/// Appends a row written in the column order `tables()` gives the table.
fn add(t: &mut Tables, table: &str, line: &str) {
	let head = match table {
		"TraitEdge" => "LeftTraitNodeID,RightTraitNodeID,Type",
		"TraitNode" => "ID,TraitTreeID,PosX,PosY",
		"TraitNodeXTraitNodeEntry" => "ID,TraitNodeID,TraitNodeEntryID,_Index",
		"SkillLineXTraitTree" => "ID,SkillLineID,TraitTreeID",
		_ => panic!("{table}"),
	};
	let r = forge_data::tables::parse_csv(&format!("{head}\n{line}\n")).unwrap();
	t.get_mut(table).unwrap().extend(r);
}

fn p(level: i64, node: i64, rank: i64) -> Pick {
	Pick { level, node, rank }
}

fn plan(class: &str, source: &str, picks: &str) -> V {
	parse_json(&format!(
		r#"{{"class":"{class}","source":"{source}","sourceUrl":"https://example.invalid","summary":"s","order":["One","Two"],"builds":[{{"key":"one","spec":"One","split":"3/0","link":"L","picks":[{picks}]}}]}}"#
	))
	.unwrap()
}

#[test]
fn replay_levels_ranks_tier_gates_and_arrows() {
	let f = tree_facts(&tables(), "PALADIN").unwrap();
	assert_eq!(PREREQ_RULE, "full", "full rank until checked in game");
	assert!(replay(&f, &[p(10, 1, 1), p(11, 1, 2), p(12, 1, 3), p(13, 2, 1), p(14, 3, 1)], "full").is_empty());
	assert!(replay(&f, &[p(10, 1, 1), p(11, 2, 1)], "full")[0].contains("needs Alpha 3/3"));
	assert!(replay(&f, &[p(10, 1, 1), p(11, 2, 1)], "started").is_empty());
	assert!(replay(&f, &[p(10, 1, 1), p(11, 3, 1)], "full")[0].contains("needs 3 points in its tree, has 1"));
	assert!(replay(&f, &[p(10, 1, 2)], "full")[0].contains("rank 2 after 0"));
	assert!(replay(&f, &[p(11, 4, 1)], "full")[0].contains("expected level 10"));
	assert_eq!(f.specs, vec![vec![1, 2, 3], vec![4]], "the class tree only, spec columns by position");
	assert_eq!((f.nodes[&3].row, f.nodes[&2].col), (2, 2));
}

#[test]
fn of_several_arrows_into_one_talent_any_one_opens_it_and_a_required_one_beside_others_is_refused() {
	let mut t = tables();
	add(&mut t, "TraitEdge", "2,3,2");
	add(&mut t, "TraitEdge", "4,3,2");
	t.insert("TraitNodeGroupXTraitCond".into(), Vec::new());
	let f = tree_facts(&t, "PALADIN").unwrap();
	assert!(replay(&f, &[p(10, 4, 1), p(11, 4, 2), p(12, 4, 3), p(13, 4, 4), p(14, 4, 5), p(15, 3, 1)], "full").is_empty(), "Delta alone is enough");
	assert!(replay(&f, &[p(10, 3, 1)], "full")[0].contains("needs Beta 1/1 or Delta 5/5"));
	let mut t = tables();
	add(&mut t, "TraitEdge", "4,2,3");
	assert!(tree_facts(&t, "PALADIN").err().unwrap().contains("Required arrow beside others"));
}

#[test]
fn strays_far_off_the_grid_are_left_out_and_rows_a_few_units_apart_are_one() {
	let mut t = tables();
	add(&mut t, "TraitNode", "5,1100,90000,100");
	add(&mut t, "TraitNode", "6,1100,9000,700");
	add(&mut t, "TraitNodeXTraitNodeEntry", "5,5,14,0");
	add(&mut t, "TraitNodeXTraitNodeEntry", "6,6,13,0");
	let f = tree_facts(&t, "PALADIN").unwrap();
	assert_eq!(f.strays, vec![5]);
	assert!(!f.nodes.contains_key(&5));
	assert_eq!(f.specs, vec![vec![1, 2, 3], vec![4, 6]], "no fourth column");
	let mut u = tables();
	add(&mut u, "TraitNode", "5,1100,9000,7000");
	add(&mut u, "TraitNodeXTraitNodeEntry", "5,5,11,0");
	let g = tree_facts(&u, "PALADIN").unwrap();
	assert_eq!(g.strays, vec![5]);
	assert_eq!(g.nodes.values().map(|n| n.row).max(), Some(2), "no extra row");
	let mut r = tables();
	r.get_mut("TraitNode").unwrap()[1].insert("PosY".into(), "110".into());
	let h = tree_facts(&r, "PALADIN").unwrap();
	assert_eq!([h.nodes[&1].row, h.nodes[&2].row, h.nodes[&3].row], [1, 1, 2]);
}

#[test]
fn every_class_has_its_tree_by_class_skill_line() {
	let mut t = tables();
	for (cls, line) in [("DRUID", 574), ("HUNTER", 50), ("MAGE", 237), ("PRIEST", 613), ("ROGUE", 38), ("SHAMAN", 373), ("WARLOCK", 354), ("WARRIOR", 26)] {
		add(&mut t, "SkillLineXTraitTree", &format!("9,{line},1100"));
		assert!(tree_facts(&t, cls).is_ok(), "{cls}");
	}
	assert!(tree_facts(&t, "MONK").err().unwrap().contains("no tree known for class MONK"));
}

#[test]
fn the_lua_names_its_rule_snapshot_and_plans_and_the_addon_reads_the_locale() {
	let src = plan("PALADIN", "Example's leveling plans", r#"{"level":10,"tree":"One","talent":"Alpha","rank":1,"note":"Say \"hi\""},{"level":11,"tree":"One","talent":"Alpha","rank":2}"#);
	let r = build_all(std::slice::from_ref(&src), &tables(), "-- H", PREREQ_RULE).unwrap();
	assert!(r.errors.is_empty(), "{:?}", r.errors);
	assert!(r.lua.starts_with("-- H\n"));
	for want in ["prereq = \"full\"", "\t\t[1] = { 11, 3, 121, 1, 1, 1, \"Alpha\" },", "\t\t[3] = { { 50, 3 } },", "\tedges = { { 1, 2 } },", "{ 1, 1 }, { 1, 2 },", "[10] = L[\"Say \\\"hi\\\"\"],"] {
		assert!(r.lua.contains(want), "{want}");
	}
	assert!(build_all(std::slice::from_ref(&src), &tables(), "-- H", "started").unwrap().lua.contains("prereq = \"started\""), "the rule it checked with");
	// The client reads the source in its language and keeps the attribution URL.
	let lua = mlua::Lua::new();
	let got: (String, String) = lua
		.load(format!(
			r#"local captured
			local ns = {{ L = setmetatable({{ ["Example's leveling plans"] = "本地化来源" }}, {{ __index = function(_, k) return k end }}),
				Talents = {{ Register = function(data) captured = data end }} }}
			assert(loadstring({}))("Polestar", ns)
			return captured.source, captured.url"#,
			forge_data::travel::lua_str(&r.lua)
		))
		.eval()
		.unwrap();
	assert_eq!(got, ("本地化来源".to_string(), "https://example.invalid".to_string()));
}

#[test]
fn one_register_per_class_by_class_and_errors_name_the_class() {
	let mut t = tables();
	add(&mut t, "SkillLineXTraitTree", "2,26,1100");
	let pk = r#"{"level":10,"tree":"One","talent":"Alpha","rank":1}"#;
	let r = build_all(&[plan("WARRIOR", "X", pk), plan("PALADIN", "X", pk)], &t, "-- H", PREREQ_RULE).unwrap();
	assert!(r.errors.is_empty());
	assert_eq!(r.lua.lines().filter(|l| *l == "T.Register({").count(), 2);
	assert!(r.lua.find("class = \"PALADIN\"") < r.lua.find("class = \"WARRIOR\""), "sorted by class");
	assert_eq!(r.lua.lines().filter(|l| *l == "local ADDON, ns = ...").count(), 1);
	let two = build_all(&[plan("PALADIN", "X", pk), plan("PALADIN", "X", pk)], &tables(), "-- H", PREREQ_RULE).unwrap();
	assert!(two.errors[0].starts_with("PALADIN: more than one plan file"));
	let bad = build_all(&[plan("PALADIN", "X", r#"{"level":10,"tree":"One","talent":"Nope","rank":1}"#)], &tables(), "-- H", PREREQ_RULE).unwrap();
	assert!(bad.errors[0].starts_with("PALADIN one pick 1") && bad.errors[0].contains("no One talent named \"Nope\""), "{}", bad.errors[0]);
}

fn repo() -> PathBuf {
	super::fixture_build::repo()
}

fn plan_files() -> Vec<String> {
	let mut f: Vec<String> = std::fs::read_dir(repo().join("talents/forever")).unwrap().flatten().map(|e| e.file_name().to_string_lossy().into_owned()).filter(|f| f.ends_with(".json")).collect();
	f.sort();
	f
}

#[test]
fn builds_lua_names_every_plan_file_and_the_pinned_build() {
	let head = std::fs::read_to_string(repo().join("addon/Polestar/Talents/Builds.lua")).unwrap().lines().next().unwrap().to_string();
	assert!(head.contains(&format!("the Forever {BUILD} trait tables")), "{head}");
	let names: Vec<String> = plan_files().iter().map(|f| f.trim_end_matches(".json").to_string()).collect();
	assert!(head.contains(&format!("talents/forever/{{{}}}.json", names.join(","))), "{head}");
}

#[test]
fn every_plan_three_specs_51_picks_from_10_to_60_its_split_checked_on_the_pinned_build() {
	for f in plan_files() {
		let src = parse_json(&std::fs::read_to_string(repo().join("talents/forever").join(&f)).unwrap()).unwrap();
		let order: Vec<String> = src.get("order").items().iter().map(V::to_js_string).collect();
		assert_eq!(order.len(), 3, "{f}");
		let specs: Vec<String> = src.get("builds").items().iter().map(|b| b.get("spec").to_js_string()).collect();
		assert_eq!(specs, order, "{f}: one plan per spec, in order");
		assert_eq!(src.get("checkedOn").to_js_string(), format!("WoW: Forever beta {BUILD}"), "{f}");
		for b in src.get("builds").items() {
			let levels: Vec<f64> = b.get("picks").items().iter().map(|p| p.get("level").num()).collect();
			assert_eq!(levels, (10..=60).map(f64::from).collect::<Vec<_>>(), "{f}: one pick per level");
			let spent: Vec<usize> = order.iter().map(|t| b.get("picks").items().iter().filter(|p| p.get("tree").to_js_string() == *t).count()).collect();
			assert_eq!(spent.iter().map(usize::to_string).collect::<Vec<_>>().join("/"), b.get("split").to_js_string(), "{f}: split");
			let main = order.iter().position(|o| *o == b.get("spec").to_js_string()).unwrap();
			assert_eq!(spent.iter().max(), Some(&spent[main]), "{f}: most points in its spec");
		}
	}
}

/// The pinned Forever tables, when the source cache has them (FORGE_SOURCES, else <repo>/data/sources).
fn cached_tables() -> Option<Tables> {
	let sources = std::env::var_os("FORGE_SOURCES").map(PathBuf::from).unwrap_or_else(|| repo().join("data/sources"));
	let dir = sources.join("wago").join(BUILD);
	if !TABLES.iter().all(|t| dir.join(format!("{t}.csv")).exists()) {
		eprintln!("skipped: no cached Forever {BUILD} trait tables under {}", sources.display());
		return None;
	}
	let read = |t: &str| forge_data::tables::parse_csv(&std::fs::read_to_string(dir.join(format!("{t}.csv"))).unwrap()).unwrap();
	Some(TABLES.iter().map(|t| (t.to_string(), read(t))).collect())
}

#[test]
fn on_the_pinned_tables_every_plan_replays_builds_lua_is_up_to_date_and_the_strays_are_known() {
	let Some(t) = cached_tables() else { return };
	let mut o = forge_data::talents::Options::new(&repo());
	o.sources = std::env::var_os("FORGE_SOURCES").map(PathBuf::from).unwrap_or_else(|| repo().join("data/sources"));
	o.offline = true;
	let (r, _) = forge_data::talents::run(&o, &|_| {}).unwrap();
	assert!(r.errors.is_empty(), "{:?}", r.errors);
	assert_eq!(std::fs::read_to_string(Path::new(&o.out).join("Builds.lua")).unwrap(), r.lua, "run: forge data talents build");
	let mut strays = Vec::new();
	for (cls, _) in [("DRUID", 0), ("HUNTER", 0), ("MAGE", 0), ("PALADIN", 0), ("PRIEST", 0), ("ROGUE", 0), ("SHAMAN", 0), ("WARLOCK", 0), ("WARRIOR", 0)] {
		let f = tree_facts(&t, cls).unwrap();
		assert_eq!(f.specs.len(), 3, "{cls}");
		for col in &f.specs {
			let mut names: Vec<&str> = col.iter().map(|id| f.nodes[id].name.as_str()).collect();
			names.sort();
			let n = names.len();
			names.dedup();
			assert_eq!(names.len(), n, "{cls}: a talent name twice in one column");
		}
		if !f.strays.is_empty() {
			strays.push((cls, f.strays.clone()));
		}
	}
	assert_eq!(strays, vec![("HUNTER", vec![104982]), ("PRIEST", vec![105865])]);
	let druid = tree_facts(&t, "DRUID").unwrap();
	let named = |n: &str| *druid.nodes.iter().find(|(_, x)| x.name == n).unwrap().0;
	let pair: Vec<(i64, i64)> = druid.edges.iter().copied().filter(|e| e.0 == named("Nature's Majesty") || e.1 == named("Nature's Majesty")).collect();
	assert_eq!(pair, vec![(named("Nature's Majesty"), named("Nature's Splendor"))], "the line back is drawn only");
}
