//! The Dungeons section's data: the builder (tools/lib/codex/journal.js, ported as forge_data::codex::journal) on
//! the synthetic fixture tests/fixtures/codex/dungeons.json, and the runtime (addon/Polestar/Dungeons/Dungeons.lua)
//! reading its pack file inside a Codex pack, the way the client loads it.

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::dsl::plain;
use forge_addontest::{emitted, fake_locale, is_match, text, truthy, Addon, RunAddon};
use forge_data::codex::client::{instance_maps_of, Corpse, InstanceMap};
use forge_data::codex::instances::zone_point;
use forge_data::codex::journal::{build_journal, emit_journal, Codex as JournalCodex, JournalInputs};
use forge_guide::js::{parse_json, V};
use serde_json::{json, Value};

static NULL: Value = Value::Null;

fn codex() -> Value {
	fixture("dungeons.json")["codex"].clone()
}

fn inputs() -> Value {
	fixture("dungeons.json")["inputs"].clone()
}

fn v(x: &Value) -> V {
	parse_json(&x.to_string()).unwrap()
}

fn obj(x: &Value) -> V {
	if x.is_null() {
		V::obj()
	} else {
		v(x)
	}
}

fn pick<'a>(vals: &[&'a Value]) -> &'a Value {
	vals.iter().copied().find(|x| !x.is_null()).unwrap_or(&NULL)
}

fn instance_map(m: &Value) -> InstanceMap {
	let list = |k: &str| m[k].as_array().map(|a| a.iter().filter_map(Value::as_f64).collect()).unwrap_or_default();
	InstanceMap {
		id: m["id"].as_f64().unwrap(),
		name: m["name"].as_str().unwrap_or("").to_string(),
		raid: m["raid"].as_bool().unwrap_or(false),
		players: m["players"].as_f64(),
		area: m["area"].as_f64(),
		areas: list("areas"),
		inner: list("inner"),
		zones: list("zones"),
		corpse: m["corpse"].as_object().map(|_| Corpse { c: m["corpse"]["c"].as_f64().unwrap(), x: m["corpse"]["x"].as_f64().unwrap(), y: m["corpse"]["y"].as_f64().unwrap() }),
	}
}

/// `buildJournal(inputs, codex)` on the JS shapes of the fixture.
fn journal(inputs: &Value, codex: &Value) -> V {
	let maps: Vec<InstanceMap> = pick(&[&inputs["client"]["instanceMaps"], &inputs["maps"], &inputs["instanceMaps"]]).as_array().map(|a| a.iter().map(instance_map).collect()).unwrap_or_default();
	let fv = &inputs["forever"];
	let frames = obj(pick(&[&fv["mapFrames"]["forever"], &inputs["frames"]]));
	let (fq, fo, fz) = (obj(&fv["quests"]), obj(&fv["objects"]), obj(&fv["zones"]));
	let fd = obj(&fv["dungeons"]);
	let jq: Vec<V> = pick(&[&inputs["journalQuests"], &inputs["journal_quests"]]).as_array().map(|a| a.iter().map(v).collect()).unwrap_or_default();
	let att = obj(pick(&[&inputs["attunementTable"], &inputs["attunements"]]));
	let c = JournalCodex {
		instances: obj(&codex["instances"]),
		quests: obj(&codex["quests"]),
		npcs: obj(&codex["npcs"]),
		items: obj(&codex["items"]),
		objects: obj(&codex["objects"]),
		factions: obj(&codex["factions"]),
		zones: obj(&codex["zones"]),
	};
	build_journal(&JournalInputs { maps: &maps, frames: &frames, fv_quests: &fq, fv_objects: &fo, fv_zones: &fz, fv_dungeons: &fd, journal_quests: &jq, attunement_table: &att }, &c).0
}

fn journal_json(inputs: &Value, codex: &Value) -> Value {
	plain(&journal(inputs, codex))
}

fn num(x: f64) -> Value {
	if x.fract() == 0.0 && x.abs() < 1e15 {
		json!(x as i64)
	} else {
		json!(x)
	}
}

fn nums(list: &[f64]) -> Value {
	Value::Array(list.iter().map(|&x| num(x)).collect())
}

fn map_json(m: &InstanceMap) -> Value {
	json!({
		"id": num(m.id), "name": m.name, "raid": m.raid, "players": m.players.map(num), "area": m.area.map(num),
		"areas": nums(&m.areas), "inner": nums(&m.inner), "zones": nums(&m.zones),
		"corpse": m.corpse.as_ref().map(|c| json!({ "c": num(c.c), "x": num(c.x), "y": num(c.y) })),
	})
}

fn rows<R: FromIterator<(String, String)>>(list: &[&[(&str, &str)]]) -> Vec<R> {
	list.iter().map(|r| r.iter().map(|(k, x)| (k.to_string(), x.to_string())).collect()).collect()
}

fn ids(list: &Value) -> Value {
	Value::Array(list.as_array().unwrap().iter().map(|q| q["id"].clone()).collect())
}

fn page_quest(page: &Value, id: i64) -> Value {
	page["quests"].as_array().unwrap().iter().find(|q| q["id"] == id).cloned().unwrap_or_else(|| panic!("quest {id} not on the page"))
}

// ---------------------------------------------------------------------------
// Builder
// ---------------------------------------------------------------------------

#[test]
fn instancemapsof_instances_only_their_areas_inner_on_the_map_itself_the_zone_holding_the_entrance_the_corpse_point() {
	let maps: [&[(&str, &str)]; 3] = [
		&[("ID", "0"), ("MapName_lang", "Eastern Kingdoms"), ("InstanceType", "0"), ("CorpseMapID", "-1")],
		&[("ID", "70"), ("MapName_lang", "Uldaman"), ("InstanceType", "1"), ("AreaTableID", "1337"), ("CorpseMapID", "0"), ("Corpse_0", "-6060.5"), ("Corpse_1", "-2955"), ("MaxPlayers", "10")],
		&[("ID", "409"), ("MapName_lang", "Molten Core"), ("InstanceType", "2"), ("AreaTableID", "2717"), ("CorpseMapID", "0"), ("Corpse_0", "0"), ("Corpse_1", "0"), ("MaxPlayers", "40")],
	];
	let areas: [&[(&str, &str)]; 4] = [
		&[("ID", "1337"), ("AreaName_lang", "Uldaman"), ("ContinentID", "70"), ("ParentAreaID", "0")],
		&[("ID", "1338"), ("AreaName_lang", "Hall of the Keepers"), ("ContinentID", "70"), ("ParentAreaID", "1337")],
		&[("ID", "1517"), ("AreaName_lang", "Uldaman"), ("ContinentID", "0"), ("ParentAreaID", "3")],
		&[("ID", "2717"), ("AreaName_lang", "Molten Core"), ("ContinentID", "409"), ("ParentAreaID", "0")],
	];
	let out: Vec<Value> = instance_maps_of(rows(&maps).as_slice(), rows(&areas).as_slice()).iter().map(map_json).collect();
	assert_eq!(
		Value::Array(out),
		json!([
			{ "id": 70, "name": "Uldaman", "raid": false, "players": 10, "area": 1337, "areas": [1337, 1338, 1517], "inner": [1337, 1338], "zones": [3], "corpse": { "c": 0, "x": -6060.5, "y": -2955 } },
			{ "id": 409, "name": "Molten Core", "raid": true, "players": 40, "area": 2717, "areas": [2717], "inner": [2717], "zones": [], "corpse": null },
		])
	);
	// JS passed undefined for both; the Rust port takes slices, so no rows.
	assert!(instance_maps_of(&[], &[]).is_empty());
}

#[test]
fn zonepoint_the_preferred_zone_holding_the_point_else_the_frame_it_sits_nearest_the_middle_of_continents_skipped() {
	let frames = v(&json!({
		"1": { "c": 0, "left": 1000, "right": 0, "top": 1000, "bottom": 0 },
		"2": { "c": 0, "left": 600, "right": -400, "top": 1000, "bottom": 0 },
		"3": { "c": 0, "left": 30000, "right": -30000, "top": 30000, "bottom": -30000 },
		"4": { "c": 1, "left": 1000, "right": 0, "top": 1000, "bottom": 0 },
	}));
	// The Rust port returns (map, x, y); the JS object's `f` is always null.
	assert_eq!(zone_point(&frames, 0.0, 500.0, 100.0, &[]), Some((2.0, 50.0, 50.0)));
	assert_eq!(zone_point(&frames, 0.0, 500.0, 100.0, &[1.0]), Some((1.0, 90.0, 50.0)));
	assert_eq!(zone_point(&frames, 0.0, 5000.0, 5000.0, &[]), None);
}

fn quest_def(id: i64, faction: Value, pre: Value, pre_any: Value, objectives: Value) -> Value {
	json!({
		"id": id, "title": format!("Quest {id}"), "level": 60, "minLevel": 1, "faction": faction, "races": null, "classes": null,
		"start": { "npc": [14841], "object": [], "item": [] }, "end": { "npc": [14841], "object": [] },
		"objectives": objectives, "pre": pre, "preAny": pre_any, "rewards": [], "choices": [],
	})
}

#[test]
fn chainof_and_objectivesof() {
	// chainOf and objectivesOf are private in the Rust port (forge_data::codex::journal): their facts are checked
	// through build_journal, on quests filed under the Deadmines' area (1581) whose page carries their chain and
	// objectives.
	let (mut c, mut i) = (codex(), inputs());
	c["npcs"]["14841"] = json!({ "id": 14841, "name": "Rinling", "level": 55, "faction": null, "instance": null, "roles": [], "spawns": [{ "map": 1412, "x": 38, "y": 44.3, "f": "e" }] });
	c["npcs"]["1"] = json!({ "id": 1, "name": "Kresh", "level": 20, "faction": null, "instance": null, "roles": [], "spawns": [] });
	c["items"]["2"] = json!({ "id": 2, "name": "Deviate Hide", "quality": 1, "kind": "item", "sources": [] });
	c["objects"]["3"] = json!({ "id": 3, "name": "Ancient Chest", "spawns": [] });
	let mut add = |id: i64, faction: Value, pre: Value, pre_any: Value, objectives: Value, filed: Option<Value>| {
		c["quests"][id.to_string()] = quest_def(id, faction, pre, pre_any, objectives);
		if let Some(fq) = filed {
			i["forever"]["quests"][id.to_string()] = fq;
		}
	};
	let filed = || Some(json!({ "area": 1581, "source": ["questie-forever"] }));
	// Every prerequisite, depth first, oldest first; cycles stop.
	add(90031, Value::Null, json!([90032]), json!([]), json!([]), filed());
	add(90032, Value::Null, json!([90033]), json!([]), json!([]), None);
	add(90033, Value::Null, json!([90031]), json!([]), json!([]), None);
	// All of `pre`/`preAny` and each `preAny` alternative, not only the first (The Call to Command needs Duskwing
	// and The Corpulent One), and the breadcrumbs; the other side's are left out.
	add(6144, json!("H"), json!([6135, 6136]), json!([]), json!([]), Some(json!({ "area": 1581, "breadcrumbs": [5961], "source": ["questie-forever"] })));
	add(90044, Value::Null, json!([6135, 6136]), json!([]), json!([]), filed());
	add(6135, Value::Null, json!([6022]), json!([]), json!([]), None);
	add(6136, Value::Null, json!([]), json!([6042, 6133]), json!([]), None);
	add(6022, Value::Null, json!([]), json!([]), json!([]), None);
	add(6042, Value::Null, json!([]), json!([]), json!([]), None);
	add(6133, json!("A"), json!([]), json!([]), json!([]), None);
	add(5961, Value::Null, json!([]), json!([]), json!([]), None);
	add(
		90051,
		Value::Null,
		json!([]),
		json!([]),
		json!([{ "type": "item", "id": 2, "count": 20 }, { "type": "kill", "id": 1, "count": 1 }, { "type": "object", "id": 3 }, { "type": "event", "text": "Escort Muyoh" }]),
		filed(),
	);
	add(90052, Value::Null, json!([]), json!([]), json!([]), filed());
	let j = journal_json(&i, &c);
	let dm = &j["dungeons"]["deadmines"];
	assert_eq!(page_quest(dm, 90031)["chain"], json!([90033, 90032]));
	assert_eq!(page_quest(dm, 6144)["chain"], json!([6022, 6135, 6042, 6136, 5961]));
	assert_eq!(page_quest(dm, 90044)["chain"], json!([6022, 6135, 6042, 6133, 6136]));
	assert_eq!(
		page_quest(dm, 90051)["objectives"],
		json!([{ "k": "item", "id": 2, "n": 20, "name": "Deviate Hide" }, { "k": "kill", "id": 1, "name": "Kresh" }, { "k": "object", "id": 3, "name": "Ancient Chest" }, { "k": "event", "name": "Escort Muyoh" }]),
		"the facts, so each client composes the line in its language"
	);
	assert!(page_quest(dm, 90052)["objectives"].is_null());
}

#[test]
fn buildjournal_pages_with_quests_from_dungeonjournal_area_and_objectives_chains_rewards_bosses_with_tied_quests_entrances() {
	let j = journal_json(&inputs(), &codex());
	assert_eq!(j["meta"], json!({ "schema": 3, "counts": { "dungeons": 3, "quests": 5, "entrances": 2, "attunements": 3 } }));
	let wc = &j["dungeons"]["wailing-caverns"];
	assert_eq!(wc["zoneName"], "The Barrens");
	assert_eq!(wc["players"], 10);
	assert_eq!(json!([wc["minLevel"], wc["maxLevel"]]), json!([17, 24]));
	assert_eq!(ids(&wc["quests"]), json!([1486, 959, 914, 6981]), "level order; the hidden quest stays out");
	let qs = wc["quests"].as_array().unwrap();
	let (hides, docks, fang, shard) = (&qs[0], &qs[1], &qs[2], &qs[3]);
	assert_eq!(hides["objectives"], json!([{ "k": "item", "id": 6443, "n": 20, "name": "Deviate Hide" }]));
	assert_eq!(hides["shareable"], true);
	assert_eq!(
		hides["rewards"],
		json!({
			"items": [{ "id": 6480, "name": "Slick Deviate Leggings", "quality": 2, "choice": true }, { "id": 918, "name": "Deviate Hide Pack", "quality": 1, "choice": true }],
			"xp": 1600, "money": 1800, "rep": [],
		})
	);
	assert_eq!(hides["start"], json!({ "kind": "npc", "id": 5767, "name": "Nalpak", "map": 1413, "x": 46, "y": 35.7, "f": "e", "inside": false }));
	assert_eq!(docks["title"], "Trouble at the Docks", "a quest filed under the area, not in DungeonJournal");
	let docks_obj: Vec<Value> = docks["objectives"].as_array().unwrap().iter().map(|o| json!([o["k"], o["name"]])).collect();
	assert_eq!(Value::Array(docks_obj), json!([["kill", "Kresh"]]));
	assert_eq!(docks["start"]["name"], "Tonga Runetotem");
	assert_eq!(fang["faction"], "H");
	assert_eq!(fang["chain"], json!([1490]));
	assert_eq!(fang["rewards"]["rep"], json!([{ "faction": 81, "name": "Thunder Bluff", "value": 250 }]));
	assert_eq!(shard["inside"], true);
	assert_eq!(shard["startItem"], json!({ "id": 10441, "name": "Glowing Shard" }));
	assert_eq!(shard["shareable"], false);
	let chain_keys: Vec<&str> = wc["chain"].as_object().unwrap().keys().map(String::as_str).collect();
	assert_eq!(chain_keys, vec!["1490"]);
	assert_eq!(wc["chain"]["1490"]["start"]["name"], "Tonga Runetotem");
	let bosses: Vec<Value> = wc["bosses"]
		.as_array()
		.unwrap()
		.iter()
		.map(|b| {
			let tied: Vec<String> = b["quests"]
				.as_array()
				.unwrap()
				.iter()
				.map(|t| format!("{}:{}{}", t["id"], text(&t["how"]), if truthy(&t["item"]) { format!(":{}", text(&t["itemName"])) } else { String::new() }))
				.collect();
			json!([b["order"], b["name"], b["level"], tied])
		})
		.collect();
	assert_eq!(
		Value::Array(bosses),
		json!([
			[1, "Lady Anacondra", 20, ["914:item:Gem of Anacondra"]],
			[2, "Kresh", 20, ["959:kill"]],
			[3, "Lord Cobrahn", 20, ["914:item:Gem of Cobrahn"]],
			[4, "Mutanus the Devourer", 22, ["6981:starts:Glowing Shard"]],
		])
	);
	let dm = &j["dungeons"]["deadmines"];
	assert_eq!(dm["entrance"], json!({ "map": 1436, "x": 42.5, "y": 71.7, "f": null }), "the client's corpse point, on its zone");
	let dm_quests: Vec<Value> = dm["quests"].as_array().unwrap().iter().map(|q| json!([q["id"], q["chain"]])).collect();
	assert_eq!(Value::Array(dm_quests), json!([[166, [155]]]));
	assert_eq!(dm["chain"]["155"]["title"], "The Defias Brotherhood");
	let dm_bosses: Vec<Value> = dm["bosses"].as_array().unwrap().iter().map(|b| b["name"].clone()).collect();
	assert_eq!(Value::Array(dm_bosses), json!(["Edwin VanCleef"]), "trash is not a boss");
	let bh = &j["dungeons"]["blackmaw-hold"];
	assert_eq!(bh["forever"], true);
	assert_eq!(json!([bh["quests"], bh["bosses"], bh["entrance"]]), json!([[], [], null]));
}

fn copper_quest(id: i64, title: &str) -> Value {
	json!({
		"id": id, "title": title, "level": 60, "minLevel": 1, "faction": null, "races": null, "classes": null,
		"start": { "npc": [14841], "object": [], "item": [] }, "end": { "npc": [14841], "object": [] },
		"objectives": [{ "type": "item", "id": 4363, "count": null, "text": "Copper Modulator" }], "pre": [], "preAny": [], "rewards": [], "choices": [],
	})
}

#[test]
fn buildjournal_kp_s_report_a_game_event_s_quest_the_darkmoon_faire_s_copper_modulator_is_on_no_page_through_an_item_that_drops_inside() {
	let (mut c, mut i) = (codex(), inputs());
	// Copper Modulator: here only Sneed's Shredder in the Deadmines drops it.
	c["npcs"]["642"] = json!({ "id": 642, "name": "Sneed's Shredder", "level": 20, "faction": null, "instance": "deadmines", "roles": [], "spawns": [] });
	c["npcs"]["14841"] = json!({ "id": 14841, "name": "Rinling", "level": 55, "faction": null, "instance": null, "roles": [], "spawns": [{ "map": 1412, "x": 38, "y": 44.3, "f": "e" }] });
	c["items"]["4363"] = json!({ "id": 4363, "name": "Copper Modulator", "quality": 1, "kind": "item", "sources": [{ "type": "drop", "npc": 642, "instance": "deadmines", "chance": 0.54 }] });
	c["quests"]["7894"] = copper_quest(7894, "Copper Modulator");
	i["forever"]["quests"]["7894"] = json!({ "event": 5, "repeatable": true, "source": ["pfquest", "questie-forever"] });
	c["quests"]["90001"] = copper_quest(90001, "Spare Parts");
	c["quests"]["90002"] = copper_quest(90002, "Filed Under the Mines");
	i["forever"]["quests"]["90002"] = json!({ "area": 1581, "event": 86, "source": ["questie-forever"] });
	let j = journal_json(&i, &c);
	let pages = j["dungeons"].as_object().unwrap();
	let on = |id: i64| -> Vec<&str> { pages.iter().filter(|(_, p)| p["quests"].as_array().unwrap().iter().any(|q| q["id"] == id)).map(|(k, _)| k.as_str()).collect() };
	assert_eq!(on(7894), Vec::<&str>::new(), "the Faire ticket turn-in is on no page");
	assert_eq!(on(90001), vec!["deadmines"], "without an event the same item ties the quest to the Deadmines");
	assert_eq!(on(90002), vec!["deadmines"], "an event quest filed under the instance stays");
}

#[test]
fn buildjournal_a_stray_drop_only_the_forever_item_lists_record_it_under_5_a_quest_drop_does() {
	let (mut c, i) = (codex(), inputs());
	c["npcs"]["16014"] = json!({ "id": 16014, "name": "Mux Manascrambler", "level": 60, "faction": null, "instance": null, "roles": [], "spawns": [{ "map": 1446, "x": 52, "y": 28, "f": "e" }] });
	c["npcs"]["642"] = json!({ "id": 642, "name": "Sneed's Shredder", "level": 20, "faction": null, "instance": "deadmines", "roles": [], "spawns": [] });
	let item = |id: i64, name: &str, from: Value, chance: f64| json!({ "id": id, "name": name, "quality": 1, "kind": "item", "sources": [{ "type": "drop", "npc": 642, "instance": "deadmines", "chance": chance, "from": from }] });
	c["items"]["16203"] = item(16203, "Greater Eternal Essence", json!(["web"]), 1.2);
	c["items"]["90010"] = item(90010, "Shredder Gear", json!(["questie", "pfquest", "web"]), 1.2);
	c["items"]["90011"] = item(90011, "Shredder Plate", json!(["web"]), 40.0);
	let quest = |id: i64, title: &str, item_id: i64| {
		json!({
			"id": id, "title": title, "level": 60, "minLevel": 55, "faction": null, "races": null, "classes": null,
			"start": { "npc": [16014], "object": [], "item": [] }, "end": { "npc": [16014], "object": [] },
			"objectives": [{ "type": "item", "id": item_id, "count": 4 }], "pre": [], "preAny": [], "rewards": [], "choices": [],
		})
	};
	c["quests"]["8921"] = quest(8921, "The Ectoplasmic Distiller", 16203);
	c["quests"]["90012"] = quest(90012, "Gears", 90010);
	c["quests"]["90013"] = quest(90013, "Plates", 90011);
	let j = journal_json(&i, &c);
	let dm: Vec<Value> = j["dungeons"]["deadmines"]["quests"].as_array().unwrap().iter().map(|q| q["id"].clone()).collect();
	assert!(!dm.contains(&json!(8921)), "the essence a boss drops 1.2% of the time on Forever's list ties nothing");
	assert!(dm.contains(&json!(90012)), "a drop QuestieDB or pfQuest records does");
	assert!(dm.contains(&json!(90013)), "and a common one only Forever's lists record");
}

#[test]
fn buildjournal_tolerates_missing_inputs_emitjournal_writes_one_file_of_summaries_and_page_sources() {
	assert_eq!(journal_json(&json!({}), &json!({}))["dungeons"], json!({}));
	let file = emit_journal(&journal(&inputs(), &codex()));
	// The Rust emit_journal returns the one file's text; its name, Dungeons1.lua, is given to the pack writer, which
	// lists it among the pack's files.
	let p = write_codex_pack(&codex(), &CodexOpts { extra_files: vec![("Dungeons1.lua".into(), file.clone())], ..Default::default() });
	assert!(p.files.iter().any(|f| f.ends_with("Dungeons1.lua")));
	assert!(is_match(&file, r"(?m)^local D = Polestar and Polestar\.Dungeons$"));
	assert!(is_match(&file, r#"\["wailing-caverns"\]="return \{"#));
	let empty = emit_journal(&journal(&json!({}), &json!({})));
	let p = write_codex_pack(&codex(), &CodexOpts { extra_files: vec![("Dungeons1.lua".into(), empty)], ..Default::default() });
	assert!(p.files.iter().any(|f| f.ends_with("Dungeons1.lua")));
}

// ---------------------------------------------------------------------------
// Runtime
// ---------------------------------------------------------------------------

fn pack() -> CodexPack {
	let text = emit_journal(&journal(&inputs(), &codex()));
	write_codex_pack(&codex(), &CodexOpts { extra_files: vec![("Dungeons1.lua".into(), text)], ..Default::default() })
}

const FILES: [&str; 3] = ["Core/Core.xml", "Lookup/Lookup.xml", "Dungeons/Dungeons.xml"];

fn run_with(script: &str, with_pack: bool) -> Value {
	let pack = if with_pack { Some(pack()) } else { None };
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: pack.as_ref().map(|p| p.stub_lua.clone()).unwrap_or_default(),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("stub.login()\nlocal D = Polestar.Dungeons\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn run(script: &str) -> Value {
	run_with(script, true)
}

#[test]
fn runtime_loads_on_demand_list_in_level_order_from_summaries_get_entrance() {
	let out = run(r#"
local before = D.Meta() ~= nil
local ok = D.Load()
local list = {}
for _, d in ipairs(D.List()) do list[#list + 1] = { d.key, d.minLevel, d.quests.A, d.quests.H, d.bosses, d.forever, d.zoneName or false } end
local wc = D.Get("wailing-caverns")
emit({ before = before, ok = ok, list = list, wc = { wc.name, wc.players, wc.entrance.map, wc.entrance.x }, entrance = { D.Entrance("deadmines") },
	none = D.Get("nowhere") == nil, find = D.Find("wailing") })"#);
	assert_eq!(out["before"], false);
	assert_eq!(out["ok"], true);
	assert_eq!(out["list"], json!([["deadmines", 17, 1, 0, 1, false, "Westfall"], ["wailing-caverns", 17, 3, 4, 4, false, "The Barrens"], ["blackmaw-hold", 55, 0, 0, 0, true, false],]));
	assert_eq!(out["wc"], json!(["Wailing Caverns", 10, 1413, 46]));
	assert_eq!(out["entrance"], json!([1436, 42.5, 71.7]));
	assert_eq!(out["none"], true);
	assert_eq!(out["find"], "wailing-caverns");
}

#[test]
fn runtime_quests_by_faction_with_every_field_a_card_needs_quest_resolves_chain_quests_bosses_with_tied_quests() {
	let out = run(r#"
local function ids(list) local t = {} for i, q in ipairs(list) do t[i] = q.id end return t end
local fang = D.Quest("wailing-caverns", 914)
local items = {}
for i, it in ipairs(fang.rewards.items) do items[i] = { it.id, it.name, it.quality, it.choice } end
local pre = D.Quest("wailing-caverns", fang.chain[1])
local bosses = {}
for _, b in ipairs(D.Bosses("wailing-caverns")) do
	local t = {}
	for _, q in ipairs(b.quests) do t[#t + 1] = q.id .. ":" .. q.how end
	bosses[#bosses + 1] = { b.order, b.name, b.level, t }
end
local shard = D.Quest("wailing-caverns", 6981)
emit({ all = ids(D.Quests("wailing-caverns")), a = ids(D.Quests("wailing-caverns", "A")), h = ids(D.Quests("wailing-caverns", "H")),
	fang = { fang.title, fang.level, fang.minLevel, fang.faction, fang.shareable, D.ObjectiveText(fang), fang.start.name, fang.start.map, fang.finish.name,
		fang.rewards.xp, fang.rewards.money, fang.rewards.rep[1].name, fang.rewards.rep[1].value }, items = items,
	pre = { pre.title, pre.start.name, pre.start.x }, shard = { shard.inside, shard.startItem.name, shard.start.kind }, bosses = bosses,
	missing = D.Quest("wailing-caverns", 1) == nil, noPage = #D.Quests("nowhere") })"#);
	assert_eq!(out["all"], json!([1486, 959, 914, 6981]));
	assert_eq!(out["a"], json!([1486, 959, 6981]));
	assert_eq!(out["h"], json!([1486, 959, 914, 6981]));
	assert_eq!(
		out["fang"],
		json!(["Leaders of the Fang", 22, 18, "H", true, "Collect Gem of Cobrahn\nCollect Gem of Anacondra", "Nara Wildmane", 1456, "Nara Wildmane", 2350, 3500, "Thunder Bluff", 250])
	);
	assert_eq!(out["items"], json!([[6505, "Crescent Staff", 3, true], [6504, "Wingblade", 3, true]]));
	assert_eq!(out["pre"], json!(["Nara Wildmane", "Tonga Runetotem", 52.2]));
	assert_eq!(out["shard"], json!([true, "Glowing Shard", "item"]));
	assert_eq!(
		out["bosses"],
		json!([[1, "Lady Anacondra", 20, ["914:item"]], [2, "Kresh", 20, ["959:kill"]], [3, "Lord Cobrahn", 20, ["914:item"]], [4, "Mutanus the Devourer", 22, ["6981:starts"]]])
	);
	assert_eq!(out["missing"], true);
	assert_eq!(out["noPage"], 0);
}

#[test]
fn runtime_another_language_reads_the_objective_line_in_its_own_words_and_names() {
	let pack = pack();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{}\n{}", pack.stub_lua, fake_locale("itIT", &[("Collect %s", "Raccogli %s")])),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: r#"stub.login()
local D = Polestar.Dungeons
Polestar.Names.AddChunk("itIT", "item", 5423, 5423, "\n5423\tGemma di Cobrahn\n")
local fang = D.Quest("wailing-caverns", 914)
local ids = {}
for i, o in ipairs(fang.objectives) do ids[i] = o.id end
Polestar.Names.AddChunk("itIT", "objective", 777, 777, "\n777\tScorta$B$Bil mercante%2C $N.\n")
emit({ D.ObjectiveText(fang), ids, D.ObjectiveText({ id = 777, objectives = { { k = "event", name = "Escort the merchant" } } }) })"#
			.into(),
		..Default::default()
	});
	let out = &out[0];
	let line = if truthy(&out[0]) { text(&out[0]) } else { text(&out[1]) };
	assert!(is_match(line, r"^Raccogli "), "the template is the client language's");
	assert!(is_match(text(&out[2]), r"^Scorta il mercante, [^$]*\.$"), "an event reads the quest's own summary, its tokens filled: {}", out[2]);
}

#[test]
fn runtime_open_fires_show_dungeon_guideto_and_guidetopoint_set_the_arrow_the_setting_stops_it_without_the_pack_it_says_why() {
	let out = run(r#"
local nav = {}
Polestar.Nav = { SetTarget = function(map, x, y, label) nav[#nav + 1] = { map, x, y, label } return true end }
local fired = {}
Polestar.On("SHOW_DUNGEON", function(key) fired[#fired + 1] = key or "home" end)
D.Open("deadmines")
D.Open()
local g1 = D.GuideTo("wailing-caverns")
local g2 = D.GuideToPoint(D.Quest("wailing-caverns", 1486).start)
local g3 = D.GuideTo("blackmaw-hold")
Polestar.Set("dungeons.enabled", false)
local opened = D.Open("deadmines")
local ok, reason = D.Load()
emit({ fired = fired, nav = nav, g = { g1, g2, g3 }, opened = opened, reason = reason, list = #D.List() })"#);
	assert_eq!(out["fired"], json!(["deadmines", "home"]));
	assert_eq!(out["nav"], json!([[1413, 46, 36.4, "Wailing Caverns"], [1413, 46, 35.7, "Nalpak"]]));
	assert_eq!(out["g"], json!([true, true, false]));
	assert_eq!(out["opened"], false);
	assert_eq!(out["reason"], "off");
	assert_eq!(out["list"], 0);
	let none = run_with("local ok, reason = D.Load(); emit({ ok = ok, reason = reason, list = #D.List() })", false);
	assert_eq!(none["ok"], false);
	assert!(none["reason"].is_string());
	assert_eq!(none["list"], 0);
}

#[test]
fn runtime_only_the_open_page_is_decoded_timing_in_the_harness() {
	let out = run(r#"
D.Load()
local t0 = os.clock()
local list = D.List()
local t1 = os.clock()
local q = D.Quests("wailing-caverns", "H")
local b = D.Bosses("wailing-caverns")
local t2 = os.clock()
local same = D.Quests("wailing-caverns") == D.Quests("wailing-caverns")
emit({ list = #list, quests = #q, bosses = #b, listMs = (t1 - t0) * 1000, pageMs = (t2 - t1) * 1000 })"#);
	assert_eq!(out["list"], 3);
	assert_eq!(out["quests"], 4);
	let (list_ms, page_ms) = (out["listMs"].as_f64().unwrap(), out["pageMs"].as_f64().unwrap());
	assert!(list_ms < 50.0 && page_ms < 50.0, "list {list_ms} ms, page {page_ms} ms");
}

#[test]
fn runtime_a_page_without_objective_facts_an_older_codex_pack_keeps_its_english_line() {
	let out = run(r#"
local old = D.ObjectiveText({ id = 1, objective = "Kill 5 Kobolds" })
local none = D.ObjectiveText({ id = 2 }) == nil
emit({ old, none })"#);
	assert_eq!(out, json!(["Kill 5 Kobolds", true]));
}
