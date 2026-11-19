//! `codex build --offline` (release build: data/forever/codex/*.json, the Polestar_Codex pack and the
//! warnings) on the world slice (+ the professions golden's professions.json), client table slices and
//! the guide slice: rust/tests/golden/codex (README there).

use crate::common;

use forge_data::codex::{self, Options};
use std::path::{Path, PathBuf};

/// The checkout the build reads (data/codex/*.json, guides/) and its data folder, in scratch.
fn setup(name: &str) -> (PathBuf, PathBuf) {
	let root = common::scratch(name);
	let g = common::golden("codex");
	common::copy_tree(&g.join("input/root"), &root);
	common::copy_tree(&common::golden("guide").join("slice/forever"), &root.join("guides/forever"));
	let data = root.join("data/forever");
	common::copy_tree(&common::golden("world").join("root/data/forever"), &data);
	std::fs::copy(common::golden("professions").join("expected/professions.json"), data.join("professions.json")).unwrap();
	(root, data)
}

fn options(root: &Path, data: &Path) -> Options {
	let mut o = Options::new(root);
	o.data_dir = data.to_path_buf();
	o.sources_dir = common::golden("codex").join("input/sources");
	o.version = Some("0.2.6".into());
	o.parity_against = None;
	o.measure = false;
	o.cwd = root.to_path_buf();
	o
}

#[test]
fn loot_source_requirements_survive_the_codex_build_and_pack() {
	let (root, data) = setup("codex-drop-requires");
	let file = data.join("items.json");
	let mut items: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(&file).unwrap()).unwrap();
	items["16790"] = serde_json::json!({ "id":16790, "name":"Damp Note", "source":["pfquest"], "vendors":[4803],
		"drops":{"npc":{"4802":33,"4803":10},"object":{"30":50}}, "dropRequires":{"npc":{"4802":[6563]},"object":{"30":[6563,6564]}} });
	std::fs::write(file, items.to_string()).unwrap();
	let file = data.join("npcs.json");
	let mut npcs: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(&file).unwrap()).unwrap();
	for id in [4802, 4803] {
		npcs[id.to_string()] = serde_json::json!({"id":id,"name":format!("NPC {id}"),"level":20,"spawns":{"1429":{"f":"e","pts":[[50,50]]}},"source":["pfquest"]});
	}
	std::fs::write(file, npcs.to_string()).unwrap();
	let out = codex::build_logged(&options(&root, &data), &|_| {}).unwrap();
	let items: serde_json::Value = serde_json::from_str(&out.json.iter().find(|(n, _)| n == "items.json").unwrap().1).unwrap();
	let sources = items["16790"]["sources"].as_array().unwrap();
	assert_eq!(sources.iter().find(|s| s["type"] == "drop" && s["npc"] == 4802).unwrap()["requiresQuests"], serde_json::json!([6563]));
	assert_eq!(sources.iter().find(|s| s["type"] == "object").unwrap()["requiresQuests"], serde_json::json!([6563, 6564]));
	assert!(sources.iter().filter(|s| s["npc"] == 4803).all(|s| s.get("requiresQuests").is_none()), "alternative drop and vendor stay ungated");
	assert!(out.pack.iter().any(|(_, text)| text.contains("d4802,33,,p,6563")));
	assert!(out.pack.iter().any(|(_, text)| text.contains("o30,50,p,6563%2C6564")));
}

#[test]
fn codex_matches_golden() {
	let (root, data) = setup("codex");
	let out = codex::build_logged(&options(&root, &data), &|_| {}).unwrap();
	let want = common::golden("codex").join("expected");
	let mut check = common::Check::new();
	for (dir, files) in [("codex", &out.json), (codex::pack::ADDON, &out.pack)] {
		let mut names = Vec::new();
		for (n, t) in files {
			check.file(&format!("{dir}/{n}"), t, &want.join(dir).join(n));
			names.push(n.clone());
		}
		check.all_of(&want.join(dir), &names);
	}
	let warnings: String = out.warnings.iter().map(|w| format!("warning: {w}\n")).collect();
	check.file("warnings.txt", &warnings, &want.join("warnings.txt"));
	check.finish("codex build");
}

#[test]
fn itemdb_fills_missing_codex_item_groups_and_packs_rarity() {
	use serde_json::{json, Value};
	use std::fs;

	let (root, data) = setup("codex-itemdb");
	let mut opts = options(&root, &data);
	let sources = root.join("data/sources");
	common::copy_tree(&opts.sources_dir, &sources);
	opts.sources_dir = sources;
	let file = opts.sources_dir.join("wago/1.60.1.70450/Item.csv");
	let mut client_items = fs::read_to_string(&file).unwrap();
	client_items.push_str("\n12413,4,1,1,5,0,-1,0,0,0,0,0,0,0,0,0,0\n");
	fs::write(file, client_items).unwrap();

	let file = data.join("items.json");
	let mut items: Value = serde_json::from_str(&fs::read_to_string(&file).unwrap()).unwrap();
	for (id, name) in [(645, "Unknown Item"), (647, "Destiny"), (744, "Thunderbrew's Boot Flask"), (3456, "Dog Whistle"), (6948, "Hearthstone"), (12413, "Thorium Leggings"), (246164, "Skullthumper")]
	{
		items[id.to_string()] = json!({ "id": id, "name": name });
	}
	fs::write(file, items.to_string()).unwrap();
	let build = || codex::build_logged(&opts, &|_| {}).unwrap();
	let item_records = |out: &codex::Output| -> Value { serde_json::from_str(&out.json.iter().find(|(name, _)| name == "items.json").unwrap().1).unwrap() };
	let before = build();
	let before_items = item_records(&before);
	let itemdb = root.join("addon/Polestar_ItemDB");
	fs::create_dir_all(&itemdb).unwrap();
	fs::write(
		itemdb.join("Forever.lua"),
		r#"DB.Register(nil, {
[744]="19 44 0 2 9 0 cls0",
[3456]="12 30 25 3 4 0",
[6948]="17 99 99 4 2 8 cls16",
[246164]="21 13 7 2 2 4 dmin12 dmax23 speed2500 cls32",
})
DB.RegisterLeveling({}, { names = { npcs = {
[645]="Cookie",
[647]="Captain Greenskin",
} } })"#,
	)
	.unwrap();
	fs::write(
		itemdb.join("Items.lua"),
		r#"DB.Register({ schema = 1, build = "1.15.9.70576", count = 3 }, {
[647]="17 57 52 4 2 8 dmin112 dmax168 speed2600",
[744]="12 99 10 3 4 1",
[12413]="17 55 45 0 2 8 cls16",
})"#,
	)
	.unwrap();

	let after = build();
	let items = item_records(&after);
	let expect = |id: &str, facts: Value| {
		for (field, value) in facts.as_object().unwrap() {
			assert_eq!(&items[id][field], value, "{id}.{field}");
		}
		for field in ["kind", "status", "sources"] {
			assert_eq!(items[id][field], before_items[id][field], "{id}.{field}");
		}
	};
	expect(
		"647",
		json!({ "levelsSource": "era", "reqLevel": 52, "itemLevel": 57, "quality": 4, "allowClass": 1503,
		"typeSource": "era", "itemClass": 2, "itemSubclass": 8, "slot": 17 }),
	);
	expect("3456", json!({ "levelsSource": "forever", "itemLevel": 30, "typeSource": "forever" }));
	expect(
		"744",
		json!({ "levelsSource": "forever", "reqLevel": 0, "itemLevel": 44, "quality": 2, "allowClass": 1503,
		"typeSource": "forever", "itemClass": 9, "itemSubclass": 0, "slot": 19 }),
	);
	expect(
		"12413",
		json!({ "levelsSource": "era", "quality": 0, "allowClass": 16,
		"typeSource": "client", "itemClass": 4, "itemSubclass": 1, "slot": 5 }),
	);
	expect("246164", json!({ "levelsSource": "forever", "allowClass": 0 }));
	expect("6948", json!({ "levelsSource": "client", "typeSource": "client" }));
	for field in ["reqLevel", "itemLevel", "quality", "allowClass", "itemClass", "itemSubclass", "slot"] {
		assert_eq!(items["6948"][field], before_items["6948"][field], "6948.{field}");
	}
	assert_eq!(items["645"], before_items["645"]);
	assert!(items["645"].get("levelsSource").is_none());
	assert!(items["645"].get("typeSource").is_none());
	for name in ["npcs.json", "objects.json", "instances.json", "journal.json"] {
		assert_eq!(after.json.iter().find(|(n, _)| n == name), before.json.iter().find(|(n, _)| n == name), "{name}");
	}
	let index = &after.pack.iter().find(|(name, _)| name == "Index.lua").unwrap().1;
	assert!(index.contains(r"\002destiny\001647,4,n,7\n"));
}

/// Every quest on the release build's dungeon pages: (id, its XP).
fn page_xp(journal: &str) -> Vec<(i64, Option<f64>)> {
	let j: serde_json::Value = serde_json::from_str(journal).unwrap();
	let mut out = Vec::new();
	for d in j["dungeons"].as_object().unwrap().values() {
		for q in d["quests"].as_array().unwrap() {
			out.push((q["id"].as_i64().unwrap(), q["rewards"]["xp"].as_f64()));
		}
	}
	out
}

// #837: Ruins of Lordaeron's pages said 2,200 XP where forever-db says 4,600, because quests.json
// keeps QuestieDB's number. forever-db's XP comes first; a quest it has none for keeps quests.json's.
#[test]
fn dungeon_pages_take_forever_dbs_xp_first() {
	let (root, data) = setup("codex-store-xp");
	let golden = std::fs::read_to_string(common::golden("codex").join("expected/codex/journal.json")).unwrap();
	let ids: Vec<i64> = page_xp(&golden).into_iter().map(|(id, _)| id).collect();
	let (in_store, not_in_store, corrected) = (ids[0], ids[1], ids[2]);

	// quests.json has an older number for all three; the store has XP for two, and a correction not
	// published into the store yet changes one of those.
	let file = data.join("quests.json");
	let mut quests: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(&file).unwrap()).unwrap();
	for id in [in_store, not_in_store, corrected] {
		quests[id.to_string()]["xp"] = 2200.into();
	}
	std::fs::write(&file, quests.to_string()).unwrap();
	let db = root.join("forever-db");
	std::fs::create_dir_all(db.join("data")).unwrap();
	std::fs::create_dir_all(db.join("corrections")).unwrap();
	let rows = format!("{{\"id\":{in_store},\"xp\":4600}}\n{{\"id\":{not_in_store},\"title\":\"no xp\"}}\n{{\"id\":{corrected},\"xp\":4600}}\n");
	std::fs::write(db.join("data/quest.jsonl"), rows).unwrap();
	let corrections = format!("{{\"_about\":\"not a quest\",\"{in_store}\":{{\"set\":{{\"pre\":[1]}}}},\"{corrected}\":{{\"set\":{{\"xp\":5000}}}}}}");
	std::fs::write(db.join("corrections/quests.json"), corrections).unwrap();

	let out = codex::build_logged(&options(&root, &data), &|_| {}).unwrap();
	let after = page_xp(&out.json.iter().find(|(n, _)| n == "journal.json").unwrap().1);
	let shows = |quest: i64, want: f64| after.iter().filter(|(id, _)| *id == quest).all(|(_, xp)| *xp == Some(want));
	assert!(shows(in_store, 4600.0), "{in_store} takes forever-db's XP: {after:?}");
	assert!(shows(not_in_store, 2200.0), "{not_in_store} keeps quests.json's XP: {after:?}");
	assert!(shows(corrected, 5000.0), "{corrected} takes the unpublished correction: {after:?}");
}

// #1913: Badlands Reagent Run II (2501) needs Alchemy 210 (quests.json skill 171, skillLevel 210), and the dungeon
// hand-in guide offered it to every character. The Codex quest record carries the profession's skill line and rank,
// and the pack writes them as l<line>,<rank> (the rank empty when the data names none) for Lookup's questBlock; a
// quest without a profession carries neither.
#[test]
fn a_quest_carries_the_profession_it_needs() {
	let (root, data) = setup("codex-quest-skill");
	let file = data.join("quests.json");
	let mut quests: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(&file).unwrap()).unwrap();
	quests["2751"]["skillLevel"] = 210.into();
	std::fs::write(&file, quests.to_string()).unwrap();

	let out = codex::build_logged(&options(&root, &data), &|_| {}).unwrap();
	let json: serde_json::Value = serde_json::from_str(&out.json.iter().find(|(n, _)| n == "quests.json").unwrap().1).unwrap();
	let skill = |id: &str| (json[id]["skill"].as_f64(), json[id]["skillLevel"].as_f64());
	assert_eq!(skill("2751"), (Some(164.0), Some(210.0)), "Barbaric Battlements: Blacksmithing at the rank the data names");
	assert_eq!(skill("862"), (Some(185.0), None), "Dig Rat Stew: Cooking, no rank in the data");
	assert!(json["6"].get("skill").is_none() && json["6"].get("skillLevel").is_none(), "a quest without a profession carries neither");
	let pack: String = out.pack.iter().map(|(_, t)| t.as_str()).collect();
	assert_eq!(pack.matches(";l164,210").count(), 1, "2751's pack record");
	assert_eq!(pack.matches(";l185,").count(), 4, "the four Cooking quests (862, 6611, 8763, 8799), no rank");
}

/// A dungeon key as data/codex/levels.json writes it (`the-hall-of-thanes`, `kroldok-stronghold`) for a client
/// map name ("Hall of Thanes", "Krol'dok Stronghold"): lowercase words joined by `-`, apostrophes dropped.
fn level_key(name: &str) -> String {
	let s: String = name.to_lowercase().chars().filter(|c| *c != '\'').map(|c| if c.is_ascii_alphanumeric() { c } else { ' ' }).collect();
	s.split_whitespace().collect::<Vec<_>>().join("-")
}

/// Fitz, 2026-11-13: every dungeon's floor is the highest of the client's Group Finder minimum, its own fixed
/// minimum and players' 25th percentile entry level (5 people with a boss kill or more), and its top the Group
/// Finder's, but for the two named rows of data/codex/levels.json: The Hall of Thanes' top of 18 and Krol'dok
/// Stronghold's floor of 43, so a third exception can't get in uncited. And where 5 or more people were recorded,
/// the Group Finder's minimum is at or under their 25th percentile and their 90th percentile at most
/// `journal::CHECK_SLACK` (8) over the top: a broken join or a wrong client row shows. On the newest Forever
/// client tables with the Group Finder in the source cache (FORGE_SOURCES, else <repo>/data/sources) and this
/// checkout's data/codex/recorded.json and levels.json; a fresh clone has no client tables and skips.
#[test]
fn dungeon_levels_follow_the_group_finder_and_players_recorded_entries() {
	use forge_data::codex::{client, journal};
	use forge_guide::js::V;
	const TABLES: [&str; 7] = ["Map", "AreaTable", "DungeonEncounter", "LFGDungeons", "MapDifficulty", "ContentTuning", "GroupFinderActivity"];
	let repo = super::fixture_build::repo();
	let sources = std::env::var_os("FORGE_SOURCES").map(PathBuf::from).unwrap_or_else(|| repo.join("data/sources"));
	let Ok(build) = client::newest_forever_build(&sources, &TABLES) else {
		eprintln!("skipped: no cached Forever client tables with GroupFinderActivity under {}", sources.display());
		return;
	};
	let tables = client::load_tables(&sources, &build, &TABLES, &repo).unwrap();
	let mut facts = client::instance_facts(&tables, None);
	client::attach_finder(&mut facts.maps, tables.get("GroupFinderActivity").map(Vec::as_slice).unwrap_or(&[]));
	let read = |f: &str| std::fs::read_to_string(repo.join("data/codex").join(f)).unwrap();
	let recorded = forge_guide::js::parse_json(&read("recorded.json")).unwrap().get("dungeons");
	let levels = journal::load_levels_table(&read("levels.json")).unwrap();
	let (mut exceptions, mut checked, mut problems) = (Vec::new(), 0, Vec::new());
	for m in facts.maps.iter().filter(|m| !m.raid) {
		let Some(f) = m.finder.as_ref() else { continue };
		let fixed = facts.rec_min.get(&(m.id as i64)).map_or(V::Null, |n| V::Num(*n));
		let rec = recorded.get(&(m.id as i64).to_string());
		let key = level_key(&m.name);
		let curated = [key.clone(), format!("the-{key}")].iter().map(|k| levels.get(k)).find(V::truthy).unwrap_or_else(V::obj);
		let named = journal::levels_of(fixed.clone(), V::Null, Some(f), &rec, &curated);
		let rule = journal::levels_of(fixed.clone(), V::Null, Some(f), &rec, &V::obj());
		// The rule itself, spelled out: the highest of the three, the recorded one to a tenth of a level.
		let p25 = rec.get("p25").as_num().filter(|_| rec.get("people").as_num().is_some_and(|n| n >= journal::FLOOR_PEOPLE));
		let want = [Some(f.min), fixed.as_num(), p25.map(|p| (p * 10.0).round() / 10.0)].into_iter().flatten().fold(f64::MIN, f64::max);
		assert_eq!((rule.floor.num(), rule.max.num()), (want, f.max), "{}: the rule's floor and top", m.name);
		if named.floor.num() != rule.floor.num() {
			exceptions.push(format!("{}: floor {}", m.name, named.floor.num()));
		}
		if named.max.num() != rule.max.num() {
			exceptions.push(format!("{}: top {}", m.name, named.max.num()));
		}
		if p25.is_some() {
			checked += 1;
		}
		problems.extend(journal::recorded_check(&m.name, Some(f), &named.max, &rec, &curated));
	}
	exceptions.sort();
	assert_eq!(exceptions, ["Krol'dok Stronghold: floor 43", "The Hall of Thanes: top 18"], "the named exceptions, and only those (client build {build})");
	assert!(checked >= 15, "{checked} dungeons with 5 or more people recorded: data/codex/recorded.json has its dungeons block");
	assert!(problems.is_empty(), "{problems:?}");
}
