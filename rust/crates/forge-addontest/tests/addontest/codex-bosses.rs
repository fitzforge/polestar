//! The Codex's bosses beyond the client's encounters (tools/lib/codex/instances.js): NPCs and chests tied to
//! their instance by Forever's `location` (an area on the instance's map) or npcs.json / objects.json
//! `instances`, with their role (rare, event, optional); an encounter naming no NPC taking its chest; the boss
//! shape { name, npc, items, object?, role? } through the pack (tools/lib/codex/pack.js -> Lookup/Codex.lua, old
//! and new refs), the Dungeons journal (tools/lib/codex/journal.js), the Bosses tab, and parity's reason for a
//! boss Forever's sources do not make one.

use forge_addontest::codex::{fixture, sample_codex, write_codex_pack, CodexOpts};
use forge_addontest::dsl::plain;
use forge_addontest::{emitted, fake_locale, is_match, Addon, RunAddon};
use forge_data::codex::client::{instance_facts, Corpse, InstanceMap, Tables};
use forge_data::codex::instances::{build_instances, Ctx};
use forge_data::codex::journal::{build_journal, emit_journal, Codex, JournalInputs};
use forge_data::codex::parity::{compare_summary, Ours, Verify};
use forge_data::jsv::Row;
use forge_guide::js::{parse_json, V};
use serde_json::{json, Value};

fn v(j: &Value) -> V {
	parse_json(&j.to_string()).unwrap()
}

/// `v`, an empty object for a missing value.
fn vo(j: &Value) -> V {
	if j.is_null() {
		V::obj()
	} else {
		v(j)
	}
}

fn row(cols: &[(&'static str, &'static str)]) -> Row {
	cols.iter().map(|&(k, x)| (k.to_string(), x.to_string())).collect()
}

fn tables() -> Tables {
	[
		(
			"Map",
			vec![row(&[
				("ID", "230"),
				("MapName_lang", "Blackrock Depths"),
				("InstanceType", "1"),
				("MaxPlayers", "5"),
				("AreaTableID", "1584"),
				("CorpseMapID", "-1"),
				("Corpse_0", "0"),
				("Corpse_1", "0"),
			])],
		),
		(
			"AreaTable",
			vec![
				row(&[("ID", "1584"), ("AreaName_lang", "Blackrock Depths"), ("ContinentID", "230"), ("ParentAreaID", "0")]),
				row(&[("ID", "25"), ("AreaName_lang", "Blackrock Mountain"), ("ContinentID", "0"), ("ParentAreaID", "46")]),
			],
		),
		(
			"DungeonEncounter",
			vec![
				row(&[("ID", "1"), ("Name_lang", "Lord Roccor"), ("MapID", "230"), ("DifficultyID", "1"), ("OrderIndex", "0")]),
				row(&[("ID", "2"), ("Name_lang", "The Seven"), ("MapID", "230"), ("DifficultyID", "1"), ("OrderIndex", "1")]),
				row(&[("ID", "3"), ("Name_lang", "Magmus"), ("MapID", "230"), ("DifficultyID", "1"), ("OrderIndex", "2")]),
			],
		),
	]
	.into_iter()
	.collect()
}

fn quality(id: f64) -> Option<f64> {
	match id as i64 {
		11920 | 11945 | 11946 => Some(3.0),
		1000 => Some(1.0),
		1001 | 2776 | 1529 | 7146 => Some(2.0),
		_ => None,
	}
}

#[test]
fn buildinstances_forever_s_location_ties_npcs_and_chests_to_the_instance_bosses_after_the_encounters_carry_their_role_an_npc_less_encounter_takes_its_chest() {
	let era = [row(&[("ID", "230")])];
	let facts = instance_facts(&tables(), Some(&era[..]));
	let npcs = v(&json!({
		"9025": { "id": 9025, "name": "Lord Roccor", "level": 51, "rank": 1, "spawns": {}, "instances": [230] },
		"9476": { "id": 9476, "name": "Watchman Doomgrip", "level": 55, "rank": 1, "spawns": {}, "instances": [230] },
		// No static spawn in QuestieDB or pfQuest: Forever's NPC data alone places it (an event).
		"9027": { "id": 9027, "name": "Gorosh the Dervish", "level": 56, "rank": 1, "spawns": {} },
		"8923": { "id": 8923, "name": "Panzor the Invincible", "level": 57, "rank": 4, "spawns": {}, "instances": [230] },
		"8900": { "id": 8900, "name": "Doomforge Arcanasmith", "level": 52, "rank": 1, "spawns": {}, "instances": [230] },
		"9028": { "id": 9028, "name": "Grizzle", "level": 56, "rank": 1, "spawns": {} },
		// A shorter encounter name: of two spawnless NPCs it starts, the one placed inside.
		"9938": { "id": 9938, "name": "Magmus the Molten", "level": 55, "rank": 1, "spawns": {}, "instances": [230] },
		"9939": { "id": 9939, "name": "Magmus the Molten (Spell Visual)", "level": 55, "rank": 1, "spawns": {} },
	}));
	let objects = v(&json!({
		"169243": { "id": 169243, "name": "Chest of The Seven" },
		"160845": { "id": 160845, "name": "Dark Coffer", "instances": [230] },
		"174565": { "id": 174565, "name": "Dark Coffer" },
		"9000": { "id": 9000, "name": "Ordinary Crate", "instances": [230] },
		// Neither a gathering node nor a one-item quest object is a boss.
		"1734": { "id": 1734, "name": "Gold Vein", "roles": ["mine"], "instances": [230] },
		"103821": { "id": 103821, "name": "Doan's Strongbox", "instances": [230] },
	}));
	let items = v(&json!({
		"11920": { "id": 11920, "drops": { "npc": {}, "object": { "169243": null } } },
		"11945": { "id": 11945, "drops": { "npc": {}, "object": { "160845": 20 } } },
		// Two ids of one chest: still its own loot.
		"11946": { "id": 11946, "drops": { "npc": {}, "object": { "160845": 10, "174565": 10 } } },
		"1000": { "id": 1000, "drops": { "npc": {}, "object": { "9000": 50 } } },
		"1001": { "id": 1001, "drops": { "npc": { "9027": 12 }, "object": {} } },
		"2776": { "id": 2776, "drops": { "npc": {}, "object": { "1734": 100 } } },
		"1529": { "id": 1529, "drops": { "npc": {}, "object": { "1734": 50 } } },
		"7146": { "id": 7146, "drops": { "npc": {}, "object": { "103821": 100 } } },
	}));
	let web = v(&json!({
		"npc": {
			"9476": { "id": 9476, "name": "Watchman Doomgrip", "boss": true, "location": [1584], "spawns": {}, "drops": [] },
			"9027": { "id": 9027, "name": "Gorosh the Dervish", "classification": "elite", "boss": true, "location": [1584], "spawns": {}, "drops": [] },
			"8901": { "id": 8901, "name": "Anvilrage Reservist", "classification": "elite", "boss": false, "location": [1584], "spawns": {}, "drops": [] },
			// Placed somewhere that is no instance of ours.
			"9028": { "id": 9028, "name": "Grizzle", "boss": true, "location": [25], "spawns": {}, "drops": [] },
			// Known to Forever's NPC data only.
			"16059": { "id": 16059, "name": "Theldren", "level": [60, 60], "classification": "elite", "boss": true, "location": [1584], "spawns": {}, "drops": [] },
		},
		"object": { "169243": { "id": 169243, "name": "Chest of The Seven", "location": [1584], "spawns": {}, "drops": [] } },
	}));
	let empty = V::obj();
	let built = build_instances(
		&facts,
		&Ctx { npcs: &npcs, items: &items, objects: &objects, zones: &empty, frames: &empty, recorded: &empty, entrance_table: &empty, curated: &[], quality: &quality, web: Some(&web) },
	);
	let brd = plain(&built.instances.iter().find(|(k, _)| k == "blackrock-depths").unwrap().1);
	assert_eq!(
		brd["bosses"],
		json!([
			{ "name": "Lord Roccor", "npc": 9025, "items": [], "encounter": 1 },
			{ "name": "The Seven", "npc": null, "items": [11920], "object": 169243, "encounter": 2 },
			{ "name": "Magmus", "npc": 9938, "items": [], "encounter": 3 },
			{ "name": "Watchman Doomgrip", "npc": 9476, "items": [], "role": "optional" },
			{ "name": "Gorosh the Dervish", "npc": 9027, "items": [1001], "role": "event" },
			{ "name": "Panzor the Invincible", "npc": 8923, "items": [], "role": "rare" },
			{ "name": "Theldren", "npc": 16059, "items": [], "role": "event" },
			{ "name": "Dark Coffer", "npc": null, "items": [11945, 11946], "object": 160845, "role": "optional" },
		])
	);
	assert_eq!(brd["levels"][2], 60, "the highest boss level, Forever's for an NPC only it knows");
	let of = |list: &[(f64, String)], npc: f64| list.iter().find(|(n, _)| *n == npc).map(|(_, k)| k.clone());
	assert_eq!(of(&built.boss_instance, 9027.0).as_deref(), Some("blackrock-depths"));
	assert_eq!(of(&built.boss_instance, 16059.0).as_deref(), Some("blackrock-depths"));
	assert_eq!(of(&built.boss_instance, 9028.0), None, "Forever's data places Grizzle elsewhere");
	assert_eq!(of(&built.npc_instance, 8901.0).as_deref(), Some("blackrock-depths"), "an NPC Forever's data places inside belongs to the instance");
	assert_eq!(of(&built.boss_instance, 8901.0), None, "neither ranked, flagged nor with loot of its own: no boss");
	assert_eq!(of(&built.npc_instance, 8900.0).as_deref(), Some("blackrock-depths"));
}

fn lua_files() -> Addon {
	Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Core/Data.lua", "Core/LuaChunks.lua", "Core/Names.lua", "Core/GuideTexts.lua", "Core/Guides.lua", "Lookup/Codex.lua"])
}

#[test]
fn the_pack_carries_chest_bosses_and_roles_an_encounter_boss_keeps_the_old_bare_npc_ref() {
	let mut codex = sample_codex();
	codex["instances"]["stratholme"]["bosses"] = json!([
		{ "name": "Baron Rivendare", "npc": 10440, "items": [13335] },
		{ "name": "Stratholme Courier", "npc": 11082, "items": [], "role": "event" },
		{ "name": "Skul", "npc": 10393, "items": [], "role": "rare" },
		{ "name": "Postbox", "npc": null, "items": [13335], "object": 176346, "role": "optional" },
	]);
	let pack = write_codex_pack(&codex, &CodexOpts::default());
	let file = pack.files.iter().find(|f| f.file_name().unwrap().to_string_lossy().contains("Instances")).unwrap();
	let content = std::fs::read_to_string(file).unwrap();
	assert!(is_match(&content, r"Baron Rivendare,10440,13335;"), "an encounter boss: the old shape, bare npc id");
	assert!(is_match(&content, r"Postbox,o176346x,13335"));
	let got = emitted(&RunAddon {
		before: pack.stub_lua.clone(),
		addons: vec![lua_files()],
		script: r#"Polestar.Codex.Load()
local out = {}
for i, b in ipairs(Polestar.Codex.Instance("stratholme").bosses) do out[i] = { b.name, b.npc or false, b.object or false, b.role or false, #b.items } end
emit(out)"#
			.into(),
		..Default::default()
	});
	assert_eq!(
		got[0],
		json!([["Baron Rivendare", 10440, false, false, 1], ["Stratholme Courier", 11082, false, "event", 0], ["Skul", 10393, false, "rare", 0], ["Postbox", false, 176346, "optional", 1],])
	);
}

// The Dungeons fixture's Wailing Caverns, built the release way (no dungeons.json): its bosses from the Codex
// instance.
fn release_fixture() -> Value {
	let mut f = fixture("dungeons.json");
	if let Some(o) = f["inputs"]["forever"].as_object_mut() {
		o.remove("dungeons");
	}
	f["codex"]["instances"]["wailing-caverns"]["bosses"] = json!([
		{ "name": "Lady Anacondra", "npc": 3671, "items": [9739] },
		{ "name": "Serpent Cache", "npc": null, "items": [9738], "object": 900300, "role": "optional" },
		{ "name": "Kresh", "npc": 3653, "items": [], "role": "rare" },
	]);
	f
}

fn instance_map(m: &Value) -> InstanceMap {
	let nums = |k: &str| -> Vec<f64> { m[k].as_array().map(|a| a.iter().filter_map(Value::as_f64).collect()).unwrap_or_default() };
	InstanceMap {
		id: m["id"].as_f64().unwrap(),
		name: m["name"].as_str().unwrap_or("").to_string(),
		raid: m["raid"].as_bool().unwrap_or(false),
		players: m["players"].as_f64(),
		area: m["area"].as_f64(),
		areas: nums("areas"),
		inner: nums("inner"),
		zones: nums("zones"),
		corpse: m["corpse"].as_object().map(|c| Corpse {
			c: c.get("c").and_then(Value::as_f64).unwrap_or(0.0),
			x: c.get("x").and_then(Value::as_f64).unwrap_or(0.0),
			y: c.get("y").and_then(Value::as_f64).unwrap_or(0.0),
		}),
	}
}

/// buildJournal(fixture.inputs, fixture.codex)'s journal.
fn journal_of(f: &Value) -> V {
	let inp = &f["inputs"];
	let maps: Vec<InstanceMap> = inp["client"]["instanceMaps"].as_array().map(|a| a.iter().map(instance_map).collect()).unwrap_or_default();
	let frames = vo(&inp["forever"]["mapFrames"]["forever"]);
	let fv_quests = vo(&inp["forever"]["quests"]);
	let fv_objects = vo(&inp["forever"]["objects"]);
	let fv_zones = vo(&inp["forever"]["zones"]);
	let fv_dungeons = vo(&inp["forever"]["dungeons"]);
	let attunement_table = vo(&inp["attunementTable"]);
	let journal_quests: Vec<V> = inp["journalQuests"].as_array().map(|a| a.iter().map(v).collect()).unwrap_or_default();
	let c = &f["codex"];
	let codex = Codex {
		instances: vo(&c["instances"]),
		quests: vo(&c["quests"]),
		npcs: vo(&c["npcs"]),
		items: vo(&c["items"]),
		objects: vo(&c["objects"]),
		factions: vo(&c["factions"]),
		zones: vo(&c["zones"]),
	};
	build_journal(
		&JournalInputs {
			maps: &maps,
			frames: &frames,
			fv_quests: &fv_quests,
			fv_objects: &fv_objects,
			fv_zones: &fv_zones,
			fv_dungeons: &fv_dungeons,
			journal_quests: &journal_quests,
			attunement_table: &attunement_table,
		},
		&codex,
	)
	.0
}

#[test]
fn buildjournal_a_chest_boss_and_the_roles_reach_the_page_the_chest_ties_the_quest_whose_item_it_holds() {
	let j = plain(&journal_of(&release_fixture()));
	let page = &j["dungeons"]["wailing-caverns"];
	let bosses: Vec<Value> = page["bosses"].as_array().unwrap().iter().map(|b| json!([b["name"], b["npc"], b["object"], b["role"]])).collect();
	assert_eq!(json!(bosses), json!([["Lady Anacondra", 3671, null, null], ["Serpent Cache", null, 900300, "optional"], ["Kresh", 3653, null, "rare"],]));
	assert_eq!(page["bosses"][1]["quests"], json!([{ "id": 914, "how": "item", "item": 9738, "itemName": "Gem of Cobrahn" }]));
}

// The Wailing Caverns' Bosses tab, each shown row's name and facts.
fn boss_rows(before: &str) -> Value {
	let f = release_fixture();
	let journal = journal_of(&f);
	let pack = write_codex_pack(&f["codex"], &CodexOpts { extra_files: vec![("Dungeons1.lua".into(), emit_journal(&journal))], ..Default::default() });
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: format!("{}\n{before}", pack.stub_lua),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml", "Lookup/Lookup.xml", "Dungeons/Dungeons.xml", "UI/UI.xml"])],
		script: r#"uistub.install()
stub.login()
local DS = Polestar.UI.DungeonsSection
Polestar.Dungeons.Open("wailing-caverns")
DS.SetTab("bosses")
local out = {}
for _, r in ipairs(DS.bossRows) do if r:IsShown() then out[#out + 1] = { r.Name:GetText(), r.Level:GetText() } end end
emit(out)"#
			.into(),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn bosses_tab_a_chest_says_chest_the_bosses_after_the_encounters_their_role_an_encounter_shows_its_level_alone() {
	assert_eq!(boss_rows(""), json!([["Lady Anacondra", "Level 20"], ["Serpent Cache", "Chest  \u{b7}  Optional"], ["Kresh", "Level 20  \u{b7}  Rare"],]));
}

#[test]
fn bosses_tab_a_chest_boss_is_translated_under_its_own_key_apart_from_the_chest_gear_slot() {
	let rows = boss_rows(&format!("{}\nCHESTSLOT = \"Brust\"", fake_locale("itIT", &[("boss: Chest", "Truhe"), ("Optional", "Optional"), ("Level %d", "Stufe %d")])));
	assert_eq!(rows[1], json!(["Serpent Cache", "Truhe  \u{b7}  Optional"]));
	assert_eq!(rows[0], json!(["Lady Anacondra", "Stufe 20"]));
}

#[test]
fn comparecodex_a_chest_boss_matches_by_its_object_name_a_confirmed_missing_boss_forever_places_outside_or_ranks_ordinary_says_so() {
	// The Rust port computes compareCodex's summary (meta.parity): per kind its match and internalOnly. The
	// per-row reasons stay in the JS `codex parity` report; notBoss counts the confirmed missing bosses they
	// excuse (Techbot placed outside, Fel Steed an ordinary elite), not Gyth (a boss inside: a real gap).
	let ours_instances = v(&json!({ "blackrock-depths": { "name": "Blackrock Depths", "bosses": [{ "name": "The Seven", "npc": null, "object": 169243, "items": [] }] } }));
	let ours_objects = v(&json!({ "169243": { "id": 169243, "name": "Chest of The Seven" } }));
	let empty = V::obj();
	let ours = Ours { instances: &ours_instances, items: &empty, npcs: &empty, objects: &ours_objects, journal: &empty, no_pvp: &[], cut_drop: &empty, cut_rare: &empty, cut_treasure: &empty };
	let theirs = [
		(
			"instances",
			v(&json!({
				"blackrock-depths": {
					"name": "Blackrock Depths",
					"bosses": [
						{ "name": "Chest of The Seven", "npc": 9034, "items": [] },
						{ "name": "Techbot", "npc": 6231, "items": [] },
						{ "name": "Fel Steed", "npc": 3864, "items": [] },
						{ "name": "Gyth", "npc": 10339, "items": [] },
					],
				},
			})),
		),
		("objects", V::obj()),
		("npcs", V::obj()),
		("items", V::obj()),
	]
	.into_iter()
	.collect();
	let npc = json!({
		"6231": { "classification": "elite", "boss": false, "location": [], "spawns": { "1415": [[43.1, 52.8]] }, "drops": [] },
		"3864": { "classification": "elite", "boss": false, "location": [1584], "spawns": {}, "drops": [{ "item": 932, "count": 1, "outof": 10 }] },
		"10339": { "classification": "elite", "boss": true, "location": [1584], "spawns": {}, "drops": [] },
	});
	let verify = Verify { web: v(&json!({ "npc": npc, "object": {}, "item": {} })), client_instances: Default::default(), instance_areas: Some([1584].into_iter().collect()) };
	let r = plain(&compare_summary(&ours, &theirs, Some(&verify)));
	let b = &r["bosses"];
	assert_eq!(b["match"], 1, "The Seven is the Chest of The Seven");
	assert_eq!(b["internalOnly"], json!({ "confirmed": 3, "notInForever": 0, "unverified": 0, "notBoss": 2 }));
}
