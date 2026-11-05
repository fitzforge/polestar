//! The local-extras readers of other addons' data (forge_data::codex::{atlasloot, rarescanner}): synthetic
//! fixtures mimicking each addon's layout (tests/fixtures/codex/addons, made-up ids), then a sanity pass over
//! the real installed addons when they are present.

use std::path::{Path, PathBuf};
use std::sync::LazyLock;

use forge_data::codex::atlasloot::read_atlasloot;
use forge_data::codex::rarescanner::{coord, point, read_rarescanner};
use forge_guide::js::{stringify, V};
use serde_json::{json, Value};

fn fix() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../../tests/fixtures/codex/addons")
}

fn plain(v: &V) -> Value {
	serde_json::from_str(&stringify(v, None)).unwrap()
}

static ATLAS: LazyLock<Value> = LazyLock::new(|| plain(&read_atlasloot(&fix()).unwrap()));

fn instance(key: &str) -> &'static Value {
	ATLAS["instances"].as_array().unwrap().iter().find(|i| i["key"] == key).unwrap_or_else(|| panic!("no instance {key}"))
}

fn boss(key: &str, name: &str) -> &'static Value {
	instance(key)["bosses"].as_array().unwrap().iter().find(|b| b["name"] == name).unwrap_or_else(|| panic!("no boss {name}"))
}

fn item(b: &Value, id: i64) -> &Value {
	b["items"].as_array().unwrap().iter().find(|i| i["item"] == id).unwrap_or_else(|| panic!("no item {id}"))
}

fn all_items() -> Vec<f64> {
	let mut out = Vec::new();
	for i in ATLAS["instances"].as_array().unwrap() {
		for b in i["bosses"].as_array().unwrap() {
			out.extend(b["items"].as_array().unwrap().iter().map(|x| x["item"].as_f64().unwrap()));
		}
	}
	out
}

fn list(v: &Value) -> &Vec<Value> {
	v.as_array().unwrap()
}

/// A tmp AddOns folder holding copies of the named fixture folders, less the `drop` files.
struct Partial(PathBuf);

impl Partial {
	fn new(names: &[&str], drop: &[&str]) -> Partial {
		let dir = Path::new(env!("CARGO_TARGET_TMPDIR")).join(format!("consume-{}-{}", std::process::id(), names.join("-")));
		let _ = std::fs::remove_dir_all(&dir);
		for n in names {
			copy(&fix().join(n), &dir.join(n));
		}
		for f in drop {
			std::fs::remove_file(dir.join(f)).unwrap();
		}
		Partial(dir)
	}
}

impl Drop for Partial {
	fn drop(&mut self) {
		let _ = std::fs::remove_dir_all(&self.0);
	}
}

fn copy(from: &Path, to: &Path) {
	std::fs::create_dir_all(to).unwrap();
	for e in std::fs::read_dir(from).unwrap().flatten() {
		let p = e.path();
		if p.is_dir() {
			copy(&p, &to.join(e.file_name()));
		} else {
			std::fs::copy(&p, to.join(e.file_name())).unwrap();
		}
	}
}

#[test]
fn atlasloot_meta_names_the_source_version_licence_and_the_files_read() {
	let meta = &ATLAS["meta"];
	assert_eq!(meta["source"], "AtlasLootClassic");
	assert_eq!(meta["version"], "Fixture 1.0");
	assert_eq!(meta["licence"], "GPL-2.0");
	assert_eq!(meta["modules"], json!(["DungeonsAndRaids", "Collections", "Crafting", "Factions", "PvP"]));
	assert_eq!(meta["warnings"], json!([]));
	let files: Vec<&str> = list(&meta["files"]).iter().map(|f| f.as_str().unwrap()).collect();
	assert!(files.contains(&"AtlasLootClassic_DungeonsAndRaids/data.lua"));
	assert!(files.contains(&"AtlasLootClassic_DungeonsAndRaids/droprate.lua"));
	assert!(files.contains(&"AtlasLootClassic/Data/Profession.lua"));
	assert!(!files.iter().any(|f| f.ends_with(".xml")), "TOC xml entries are not Lua");
}

#[test]
fn atlasloot_instances_keep_the_forever_toc_content_as_classic_with_forever_lua_filling_gaps_only() {
	let keys: Vec<&Value> = list(&ATLAS["instances"]).iter().map(|i| &i["key"]).collect();
	assert_eq!(keys, vec!["FixtureKeep", "FixtureCore", "FixtureHollow", "FixtureSpire"]);
	let keep = instance("FixtureKeep");
	assert_eq!(keep["name"], "Fixture Keep", "client area name falls back to the key");
	assert_eq!(keep["kind"], "dungeon");
	assert_eq!(keep["forever"], false);
	assert_eq!(keep["areaId"], 9001);
	assert_eq!(keep["levels"], json!([20, 24, 30]), "Classic values of GetForVersion");
	let core = instance("FixtureCore");
	assert_eq!(core["kind"], "raid");
	assert_eq!(core["phase"], 3);
	assert!(core["levels"].is_null());
	let hollow = instance("FixtureHollow");
	assert_eq!(hollow["forever"], true);
	assert_eq!(hollow["name"], "Fixture Hollow", "texture markup stripped");
	let names: Vec<&Value> = list(&hollow["bosses"]).iter().map(|b| &b["name"]).collect();
	assert_eq!(names, vec!["Fixture Hollow Boss"], "data.lua wins over forever.lua; notice rows dropped");
	let spire = instance("FixtureSpire");
	assert_eq!(spire["forever"], true);
	assert_eq!(spire["levels"], json!([40, 44, 48]));
	let ids = all_items();
	assert!(!ids.contains(&900097.0), "stale forever.lua copy ignored");
	assert!(!ids.contains(&900098.0) && !ids.contains(&900099.0), "later-expansion rows skipped");
}

#[test]
fn atlasloot_bosses_carry_npc_object_ids_header_icon_set_and_source_ignored_rows_are_skipped() {
	let names: Vec<&Value> = list(&instance("FixtureKeep")["bosses"]).iter().map(|b| &b["name"]).collect();
	assert_eq!(names, vec!["Warden Fixture", "Fixture Twins", "Fixture Cache"]);
	assert_eq!(boss("FixtureKeep", "Warden Fixture")["npc"], json!([900101]));
	assert_eq!(boss("FixtureKeep", "Fixture Twins")["npc"], json!([900102, 900103]));
	assert_eq!(boss("FixtureKeep", "Fixture Cache")["object"], json!([900201]));
	let ids = all_items();
	assert!(!ids.contains(&0.0), "placeholder item 0 skipped");
	assert!(!ids.contains(&900901.0), "IgnoreAsSource keys table skipped");
	assert!(!ids.contains(&501.0) && !ids.contains(&502.0), "set ids are not items");
	assert!(ids.iter().all(|n| n.fract() == 0.0 && *n > 0.0));
}

#[test]
fn atlasloot_faction_only_rows_are_tagged_a_h_from_both_factions_tables() {
	let warden = boss("FixtureKeep", "Warden Fixture");
	assert_eq!(item(warden, 900004)["faction"], "H");
	assert_eq!(item(warden, 900005)["faction"], "A");
	assert!(item(warden, 900001).get("faction").is_none());
	let cache = boss("FixtureKeep", "Fixture Cache");
	assert!(item(cache, 900008).get("faction").is_none(), "inherited through GetItemsFromDiff -> both");
	assert_eq!(item(cache, 900009)["faction"], "A", "Horde replaced that position");
	assert_eq!(item(cache, 900010)["faction"], "A", "an empty Horde row blocks inheritance");
	assert_eq!(item(cache, 900011)["faction"], "H");
	let col = |id: i64| list(&ATLAS["collections"]).iter().find(|c| c["item"] == id);
	assert_eq!(col(930001).unwrap()["faction"], "A");
	assert_eq!(col(930003).unwrap()["faction"], "H");
	assert_eq!(col(930004).unwrap()["faction"], "H");
	assert!(col(930009).unwrap()["faction"].is_null(), "in both lists");
	assert!(col(930098).is_none());
	assert!(col(930099).is_none());
}

#[test]
fn atlasloot_drop_rates_are_read_and_joined_onto_boss_items_quest_and_price_extras_kept() {
	assert_eq!(ATLAS["droprates"]["900101"], json!({ "900001": 12.5, "900002": 3.25 }), "Classic is past the phase override");
	let warden = boss("FixtureKeep", "Warden Fixture");
	assert_eq!(item(warden, 900001)["chance"], 12.5);
	assert_eq!(item(warden, 900002)["quest"], 990001);
	assert_eq!(item(warden, 900003)["price"], 2500);
	assert!(item(warden, 900003).get("chance").is_none());
	let twins = boss("FixtureKeep", "Fixture Twins");
	assert_eq!(item(twins, 900006)["chance"], 40, "any of the boss npcs");
	assert!(item(twins, 900007).get("chance").is_none());
}

#[test]
fn atlasloot_collections_group_by_content_skip_set_tables() {
	let cols = list(&ATLAS["collections"]);
	let mut groups: Vec<&Value> = Vec::new();
	for c in cols {
		if !groups.contains(&&c["group"]) {
			groups.push(&c["group"]);
		}
	}
	assert_eq!(groups, vec!["Mounts", "Companions"]);
	let drops: Vec<&Value> = cols.iter().filter(|c| c["section"] == "Drops").collect();
	assert_eq!(drops, vec![&json!({ "group": "Mounts", "groupName": "Mounts", "section": "Drops", "item": 930005, "faction": null })]);
	assert!(!cols.iter().any(|c| c["item"] == 601), "TierSets are set ids");
	assert!(cols.iter().find(|c| c["item"] == 930007).unwrap()["section"].is_null(), "client-only faction name dropped");
}

#[test]
fn atlasloot_sets_list_itemset_ids_from_collections_and_pvp_set_tables_sided() {
	assert_eq!(
		ATLAS["sets"],
		json!([
			{ "group": "TierSets", "groupName": "Tier Sets", "section": "Tier 1 Sets", "set": 601, "faction": null },
			{ "group": "TierSets", "groupName": "Tier Sets", "section": "Tier 1 Sets", "set": 602, "faction": null },
			{ "group": "ClassSets", "groupName": "Class Sets", "section": "Epic", "set": 701, "faction": "A" },
			{ "group": "ClassSets", "groupName": "Class Sets", "section": "Epic", "set": 703, "faction": null },
			{ "group": "ClassSets", "groupName": "Class Sets", "section": "Epic", "set": 702, "faction": "H" },
		])
	);
	assert!(!list(&ATLAS["pvp"]).iter().any(|x| x["item"].as_f64().is_some_and(|i| (701.0..=703.0).contains(&i))), "set ids are not pvp items");
}

#[test]
fn atlasloot_crafting_maps_craft_spells_to_created_items_and_skill() {
	assert_eq!(
		ATLAS["crafting"],
		json!([
			{ "profession": "Alchemy", "item": 920001, "spell": 910001, "skill": 150, "group": "Potions" },
			{ "profession": "Alchemy", "item": null, "spell": 910002, "skill": 275, "group": "Potions" },
			{ "profession": "Alchemy", "item": null, "spell": 910003, "skill": null, "group": "Potions" },
			{ "profession": "Herbalism", "item": 920201, "spell": null, "skill": null, "group": "Apprentice" },
			{ "profession": "Herbalism", "item": 920202, "spell": null, "skill": null, "group": "Apprentice" },
		])
	);
}

#[test]
fn atlasloot_faction_rewards_with_standings_from_header_rows_section_names_and_pvp_headers() {
	let f = |id: i64| list(&ATLAS["factions"]).iter().find(|x| x["factionId"] == id).unwrap_or_else(|| panic!("no faction {id}"));
	assert_eq!(f(9501)["name"], "Fixture Wardens");
	assert_eq!(f(9501)["rewards"], json!([{ "item": 950001, "standing": 8 }, { "item": 950002, "standing": 8 }, { "item": 950003, "standing": 8 }, { "item": 950004, "standing": 6 }]));
	assert_eq!(f(9502)["rewards"], json!([{ "item": 950005, "standing": 5, "faction": "A" }, { "item": 950006, "standing": 5, "faction": "H" }]));
	assert!(f(9601)["name"].is_null());
	let items = |id: i64| list(&f(id)["rewards"]).iter().map(|x| x["item"].clone()).collect::<Vec<_>>();
	assert_eq!(items(9601), vec![json!(960001), json!(960003)]);
	assert_eq!(items(9602), vec![json!(960002), json!(960003)]);
}

#[test]
fn atlasloot_pvp_rows_carry_side_and_rank_icon_tables_skipped() {
	let p = |id: i64| list(&ATLAS["pvp"]).iter().find(|x| x["item"] == id).unwrap_or_else(|| panic!("no pvp {id}"));
	assert_eq!(*p(940001), json!({ "group": "PvPMounts", "groupName": "Mounts", "section": "Mounts", "item": 940001, "faction": "A", "rank": 6, "honor": null }));
	assert_eq!(p(940002)["groupName"], "Mounts");
	assert!(p(940002)["rank"].is_null());
	assert!(p(960003)["faction"].is_null());
	assert_eq!(p(960001)["faction"], "A");
	assert!(!list(&ATLAS["pvp"]).iter().any(|x| x["item"] == 136782), "rank icons are not items");
}

#[test]
fn atlasloot_missing_modules_and_core_files_are_tolerated_with_warnings() {
	let dir = Partial::new(&["AtlasLootClassic_DungeonsAndRaids", "AtlasLootClassic_Crafting"], &[]);
	let r = plain(&read_atlasloot(&dir.0).unwrap());
	assert_eq!(r["meta"]["modules"], json!(["DungeonsAndRaids", "Crafting"]));
	assert_eq!(r["meta"]["version"], "Fixture 1.0", "from a module TOC when the core is absent");
	let warnings: Vec<&str> = list(&r["meta"]["warnings"]).iter().map(|w| w.as_str().unwrap()).collect();
	for m in ["Collections", "Factions", "PvP"] {
		assert!(warnings.contains(&format!("AtlasLootClassic_{m} not installed").as_str()), "{m}: {warnings:?}");
	}
	assert!(warnings.iter().any(|w| w.contains("Data/Profession.lua missing")), "{warnings:?}");
	for k in ["collections", "pvp", "sets", "factions"] {
		assert_eq!(r[k], json!([]), "{k}");
	}
	assert_eq!(list(&r["instances"]).len(), 4);
	assert!(list(&r["crafting"]).iter().all(|c| c["profession"] != "Alchemy" || c["item"].is_null()), "no created items without Profession.lua");
	let empty = plain(&read_atlasloot(&fix().join("no-such-folder")).unwrap());
	assert_eq!(json!([empty["instances"], empty["collections"], empty["crafting"]]), json!([[], [], []]));
	assert_eq!(list(&empty["meta"]["warnings"]).len(), 1);
}

#[test]
fn rarescanner_rares_per_map_with_coordinates_normalised_to_0_100() {
	let r = plain(&read_rarescanner(&fix()).unwrap());
	assert_eq!(r["meta"]["source"], "RareScanner");
	assert_eq!(r["meta"]["version"], "0.0.1.fixture");
	assert_eq!(r["meta"]["licence"], "All Rights Reserved");
	assert_eq!(list(&r["meta"]["files"]).len(), 6);
	assert_eq!(r["meta"]["warnings"], json!([]));
	assert_eq!(
		r["rares"],
		json!([
			{ "npc": 970001, "name": null, "map": 1401, "x": 41.25, "y": 60.5, "points": [[41, 60], [41.25, 60.5]], "loot": [980001, 980002] },
			{ "npc": 970002, "name": null, "map": 1402, "x": 10, "y": 20, "points": [[10, 20]], "loot": [] },
			{ "npc": 970002, "name": null, "map": 1403, "x": 50, "y": 25, "points": [], "loot": [] },
			{ "npc": 970003, "name": null, "map": null, "x": null, "y": null, "points": [], "loot": [] },
			{ "npc": 970004, "name": null, "map": 1404, "x": 70, "y": 75, "points": [[70, 75]], "loot": [] },
			{ "npc": 970005, "name": null, "map": null, "x": null, "y": null, "points": [], "loot": [980003] },
		])
	);
	assert_eq!(r["treasures"], json!([{ "object": 975001, "name": null, "map": 1405, "x": 55.5, "y": 33.3, "points": [], "loot": [985001] }]));
	assert_eq!(r["mounts"], json!({ "1": [990001], "2": [990002, 990003], "901": [990004] }));
	assert_eq!(r["pets"], json!({ "9001": [995001] }));
}

#[test]
fn rarescanner_coordinate_encodings() {
	assert_eq!(coord(&V::Num(4125.0)), Some(41.25));
	assert_eq!(coord(&V::Num(0.5)), Some(50.0));
	assert_eq!(coord(&V::str("0.5")), Some(50.0));
	assert_eq!(coord(&V::str("41.25")), Some(41.25));
	assert_eq!(coord(&V::Num(-1.0)), None);
	assert_eq!(coord(&V::Num(20000.0)), None);
	assert_eq!(point(&V::str("4100-4940")), Some((41.0, 49.4)));
	assert_eq!(point(&V::str("70007500")), Some((70.0, 75.0)));
	assert_eq!(point(&V::str("nope")), None);
}

#[test]
fn rarescanner_missing_tables_and_a_missing_addon_are_tolerated() {
	let dir = Partial::new(&["RareScanner"], &["RareScanner/Tables/Pets.lua", "RareScanner/Tables/ContainerInfoTables.lua"]);
	let r = plain(&read_rarescanner(&dir.0).unwrap());
	assert_eq!(r["pets"], json!({}));
	assert_eq!(list(&r["rares"]).len(), 6);
	let t: Vec<Value> = list(&r["treasures"]).iter().map(|t| json!([t["object"], t["map"]])).collect();
	assert_eq!(t, vec![json!([975001, null])], "loot-only container kept");
	assert_eq!(list(&r["meta"]["warnings"]).len(), 2);
	let none = plain(&read_rarescanner(&fix().join("no-such-folder")).unwrap());
	assert_eq!(json!([none["rares"], none["treasures"], none["mounts"]]), json!([[], [], {}]));
	assert_eq!(list(&none["meta"]["warnings"]).len(), 1);
}

#[test]
fn real_installed_addons_import_with_sane_counts() {
	let Some(real) = forge_data::questie::search_addons_dirs().into_iter().find(|d| d.join("AtlasLootClassic_DungeonsAndRaids").is_dir() && d.join("RareScanner").is_dir()) else {
		eprintln!("skipped: the Forever AddOns (AtlasLoot, RareScanner) are not installed");
		return;
	};
	let r = plain(&read_atlasloot(&real).unwrap());
	let instances = list(&r["instances"]);
	assert!(instances.len() >= 30, "instances {}", instances.len());
	assert!(instances.iter().any(|i| i["forever"] == true), "Forever content marked");
	assert!(r["droprates"].as_object().unwrap().len() >= 100, "drop-rate npcs");
	let strat = instances.iter().find(|i| i["key"] == "Stratholme").expect("Stratholme");
	assert!(list(&strat["bosses"]).iter().any(|b| list(&b["items"]).iter().any(|x| x["item"] == 13335)), "Deathcharger's Reins drop in Stratholme");
	let mounts: Vec<&Value> = list(&r["collections"]).iter().filter(|c| c["group"] == "Mounts").collect();
	assert!(mounts.len() >= 30, "mounts {}", mounts.len());
	assert!(mounts.iter().any(|c| c["item"] == 8631 && c["faction"] == "A"), "a Frostsaber mount, Alliance");
	let crafting = list(&r["crafting"]);
	assert!(crafting.len() >= 500 && crafting.iter().any(|c| !c["item"].is_null() && !c["spell"].is_null()));
	assert!(list(&r["factions"]).len() >= 5 && list(&r["pvp"]).len() >= 100);
	let sets = list(&r["sets"]);
	assert!(sets.len() >= 20 && sets.iter().any(|s| s["group"] == "TierSets"), "sets {}", sets.len());
	let rs = plain(&read_rarescanner(&real).unwrap());
	assert!(list(&rs["rares"]).len() >= 100, "rares {}", list(&rs["rares"]).len());
	assert!(rs["mounts"].as_object().unwrap().len() >= 30);
	assert!(list(&rs["rares"])
		.iter()
		.all(|x| x["x"].is_null() || (x["x"].as_f64().unwrap() >= 0.0 && x["x"].as_f64().unwrap() <= 100.0 && x["y"].as_f64().unwrap() >= 0.0 && x["y"].as_f64().unwrap() <= 100.0)));
}
