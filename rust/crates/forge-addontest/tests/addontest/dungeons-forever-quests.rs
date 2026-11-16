//! Forever's dungeons, their quests as players take them (#2560 and its sweep over every dungeon): the Codex's
//! Dungeons journal (forge_data::codex::journal) built with the committed data/codex/journal-quests.json and the
//! facts forever-db/corrections sets, then the Dungeons page (addon/Polestar/UI/Dungeons.lua) and its pick-up plan
//! (addon/Polestar/Dungeons/Pickup.lua) reading the pack, the way the client loads it.

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::{emitted, is_match, Addon, RunAddon};
use forge_data::codex::client::InstanceMap;
use forge_data::codex::journal::{build_journal, emit_journal, load_journal_quests, Codex, JournalInputs};
use forge_guide::js::{parse_json, V};
use serde_json::{json, Value};

const FILES: [&str; 6] = ["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml", "Lookup/Lookup.xml", "Dungeons/Dungeons.xml", "UI/UI.xml"];
const HORDE: i64 = 8589934770;
const ALLIANCE: i64 = 4294967373;

fn v(x: &Value) -> V {
	if x.is_null() {
		V::obj()
	} else {
		parse_json(&x.to_string()).unwrap()
	}
}

fn repo_json(path: &str) -> Value {
	serde_json::from_str(&std::fs::read_to_string(forge_addontest::run::root().join(path)).unwrap()).unwrap()
}

/// The committed journal-quests.json rows, read by the build's own loader.
fn journal_rows() -> Vec<V> {
	load_journal_quests(&std::fs::read_to_string(forge_addontest::run::root().join("data/codex/journal-quests.json")).unwrap()).unwrap()
}

/// forever-db/corrections/<section>.json's `set` for `id`: what the data build writes over the merged record.
fn corrected(section: &str, id: i64) -> Value {
	repo_json(&format!("forever-db/corrections/{section}.json"))[id.to_string()]["set"].clone()
}

fn npc(id: i64, name: &str, faction: Value, instance: Value, spawn: Option<(i64, f64, f64)>) -> Value {
	let spawns = spawn.map_or(json!([]), |(map, x, y)| json!([{ "map": map, "x": x, "y": y, "f": "e" }]));
	json!({ "id": id, "name": name, "level": 55, "levelMax": null, "faction": faction, "rare": false, "elite": false, "boss": false, "instance": instance, "roles": [], "spawns": spawns })
}

/// A Codex quest as the merged data has it, with forever-db/corrections' `set` over it when `fix`.
fn quest(id: i64, title: &str, races: Value, start: Value, end: Value, pre: Value, objectives: Value, fix: bool) -> Value {
	let faction = match races.as_i64() {
		Some(HORDE) => json!("H"),
		Some(ALLIANCE) => json!("A"),
		_ => Value::Null,
	};
	let mut q = json!({
		"id": id, "title": title, "level": 53, "minLevel": 48, "faction": faction, "races": races, "classes": null,
		"start": { "npc": [], "object": [], "item": [] }, "end": { "npc": [], "object": [] },
		"objectives": objectives, "pre": pre, "preAny": [], "rewards": [], "choices": [], "zone": null,
	});
	for (k, x) in start.as_object().unwrap() {
		q["start"][k] = x.clone();
	}
	for (k, x) in end.as_object().unwrap() {
		q["end"][k] = x.clone();
	}
	if fix {
		for (k, x) in corrected("quests", id).as_object().unwrap_or_else(|| panic!("no correction for quest {id}")) {
			q[k] = x.clone();
		}
	}
	q
}

/// The fixture's Codex with Alcaz Prison and its quests: the merged data's facts (QuestieDB, 0.4.0), the
/// corrections of #2560 over them.
fn alcaz() -> (Value, Value) {
	let f = fixture("dungeons.json");
	let (mut c, mut i) = (f["codex"].clone(), f["inputs"].clone());
	c["instances"]["alcaz-prison"] = json!({
		"key": "alcaz-prison", "name": "Alcaz Prison", "kind": "dungeon", "forever": true, "areaId": null, "map": 2994, "entrance": null,
		"levels": [48, 53, 55],
		"bosses": [{ "name": "Tidemistress Ca'zass", "npc": 255997, "items": [] }, { "name": "The Questioner", "npc": 256236, "items": [] }],
	});
	i["client"]["instanceMaps"].as_array_mut().unwrap().push(json!({ "id": 2994, "name": "Alcaz Prison", "raid": false, "players": 5, "area": null, "areas": [16620], "inner": [16620], "zones": [], "corpse": null }));
	let inside = json!("alcaz-prison");
	for n in [
		npc(255997, "Tidemistress Ca'zass", Value::Null, inside.clone(), None),
		npc(256236, "The Questioner", Value::Null, inside.clone(), None),
		npc(3230, "Nazgrel", json!("H"), Value::Null, Some((1454, 32.4, 35.8))),
		npc(4949, "Thrall", json!("H"), Value::Null, Some((1454, 32.0, 37.9))),
		npc(3144, "Eitrigg", json!("H"), Value::Null, Some((1454, 34.3, 36.3))),
		npc(260383, "Sergeant Ulka", json!("H"), Value::Null, Some((1445, 70.3, 18.9))),
		npc(6946, "Renzik \"The Shiv\"", json!("A"), Value::Null, Some((1453, 78.4, 70.9))),
		npc(260271, "Sully McCleary", json!("A"), Value::Null, Some((1445, 63.5, 42.3))),
	] {
		c["npcs"][n["id"].to_string()] = n;
	}
	c["objects"]["611086"] = json!({ "id": 611086, "name": "Connery's Trunk", "spawns": [{ "map": 1436, "x": 43.4, "y": 67.9, "f": "e" }] });
	let item = |id: i64, name: &str, sources: Value| json!({ "id": id, "name": name, "quality": 1, "kind": "item", "spell": null, "reqLevel": null, "sources": sources });
	c["items"]["274029"] = item(274029, "Ornate Shackle Key", json!([{ "type": "drop", "npc": 256236, "chance": 100, "instance": "alcaz-prison" }]));
	c["items"]["273883"] = item(273883, "Ca'zass's Head", json!([{ "type": "drop", "npc": 255997, "chance": 100, "instance": "alcaz-prison" }]));
	c["items"]["274028"] = item(274028, "Blood Red Bandana", json!([]));
	c["items"]["274041"] = item(274041, "Document Box", json!([]));
	c["zones"]["1445"] = json!({ "id": 1445, "name": "Dustwallow Marsh" });
	let none = json!({});
	let at = |kind: &str, id: i64| json!({ kind: [id] });
	let item_obj = |id: i64| json!([{ "type": "item", "id": id, "count": 1 }]);
	for q in [
		// Both factions: Mason Connery, the prisoner, inside.
		quest(96335, "The Man in the Iron Chains", Value::Null, none.clone(), none.clone(), json!([]), item_obj(274029), true),
		quest(96337, "More Valuable Than Gold", Value::Null, none.clone(), at("object", 611086), json!([96335]), json!([]), true),
		// Horde.
		quest(95309, "No Orc Left Behind", json!(HORDE), at("npc", 260383), none.clone(), json!([]), json!([]), false),
		quest(96332, "A Little Payback", json!(HORDE), at("npc", 260383), at("npc", 260383), json!([]), json!([]), true),
		quest(96334, "Blood Red Bandanas", json!(HORDE), at("npc", 260383), at("npc", 3144), json!([]), item_obj(274028), false),
		quest(95454, "The Honor of the Kor'kron", json!(HORDE), none.clone(), none.clone(), json!([95309]), json!([]), false),
		quest(96369, "Bad News for Folkar", json!(HORDE), none.clone(), none.clone(), json!([95454]), json!([]), false),
		quest(95483, "Thrall Needs to Know", json!(HORDE), none.clone(), at("npc", 4949), json!([]), json!([]), true),
		quest(96376, "State Secrets", json!(HORDE), at("npc", 3230), at("npc", 3230), json!([]), item_obj(274041), true),
		// Alliance.
		quest(95262, "The Secret Prison", json!(ALLIANCE), at("npc", 260271), none.clone(), json!([]), json!([]), false),
		quest(95263, "Somber News", json!(ALLIANCE), none.clone(), at("npc", 260271), json!([95262]), json!([]), false),
		quest(96381, "A Bit of Wet Work", json!(ALLIANCE), at("npc", 260271), at("npc", 260271), json!([]), json!([]), true),
		quest(96377, "State Secrets", json!(ALLIANCE), none.clone(), at("npc", 6946), json!([]), item_obj(274041), true),
	] {
		c["quests"][q["id"].to_string()] = q;
	}
	(c, i)
}

fn journal(c: &Value, i: &Value, rows: &[V]) -> (V, Vec<String>) {
	let maps: Vec<InstanceMap> = i["client"]["instanceMaps"]
		.as_array()
		.unwrap()
		.iter()
		.map(|m| {
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
				corpse: None,
				finder: None,
			}
		})
		.collect();
	let fv = &i["forever"];
	let codex = Codex { instances: v(&c["instances"]), quests: v(&c["quests"]), npcs: v(&c["npcs"]), items: v(&c["items"]), objects: v(&c["objects"]), factions: v(&c["factions"]), zones: v(&c["zones"]) };
	build_journal(
		&JournalInputs {
			maps: &maps,
			frames: &v(&fv["mapFrames"]["forever"]),
			fv_quests: &v(&fv["quests"]),
			fv_objects: &v(&fv["objects"]),
			fv_zones: &v(&fv["zones"]),
			fv_dungeons: &v(&fv["dungeons"]),
			journal_quests: rows,
			attunement_table: &v(&i["attunementTable"]),
			store_xp: &Default::default(),
			recorded_dungeons: &V::obj(),
			levels_table: &V::obj(),
		},
		&codex,
	)
}

fn page(j: &V, key: &str) -> Value {
	serde_json::from_str(&forge_guide::js::stringify(&j.get("dungeons").get(key), None)).unwrap()
}

fn page_quest(page: &Value, id: i64) -> Value {
	page["quests"].as_array().unwrap().iter().find(|q| q["id"] == id).cloned().unwrap_or_else(|| panic!("quest {id} not on the page"))
}

fn ids(page: &Value) -> Vec<i64> {
	let mut out: Vec<i64> = page["quests"].as_array().unwrap().iter().map(|q| q["id"].as_i64().unwrap()).collect();
	out.sort();
	out
}

fn pack(c: &Value, i: &Value) -> CodexPack {
	let (j, _) = journal(c, i, &journal_rows());
	write_codex_pack(c, &CodexOpts { extra_files: vec![("Dungeons1.lua".into(), emit_journal(&j))], ..Default::default() })
}

fn run(pack: &CodexPack, setup: &str, script: &str) -> Value {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: pack.stub_lua.clone(),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!(
			r#"uistub.install()
stub.login()
{setup}
local done, log = {{}}, {{}}
Polestar.Compat.IsQuestCompleted = function(id) return done[id] or false end
Polestar.Compat.IsOnQuest = function(id) return log[id] or false end
Polestar.Compat.IsQuestReadyForTurnIn = function() return false end
local DS = Polestar.UI.DungeonsSection
local function block(id)
	for _, b in ipairs(DS.blocks) do if b:IsShown() and b.psQuest == id then return b end end
end
local function plain(s) return (s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end
local function card(id)
	local b = block(id)
	if not b then return false end
	local chain = {{}}
	for _, r in ipairs(b.Chains) do if r:IsShown() then chain[#chain + 1] = r.Title:GetText() end end
	return {{ meta = b.Meta:GetText(), start = plain(b.Start:GetText()), finish = plain(b.End:GetText()), chain = chain }}
end
{script}"#
		),
		..Default::default()
	});
	out[0].clone()
}

// #2560 (Discord: "guide of acaz prison is not correct", "it doesnt let me pick up the orgirmar quest @thrall"): the
// 0.4.0 page had two quests, The Man in the Iron Chains with no giver and The Dragon's Journal. Players' recordings
// (to 2026-11-15) show the prison's story: Sully McCleary's and Sergeant Ulka's quests sent in from Alcaz Island,
// five quests picked up inside at the prisoner Mason Connery and the Kor'kron (whom the recordings meet only as a
// window inside), Thrall Needs to Know handed in to Thrall, and State Secrets at Nazgrel (Horde) or Renzik "The
// Shiv" (Alliance) after More Valuable Than Gold, which is picked up inside. Without the committed rows the page
// had none of it.
#[test]
fn alcaz_prison_lists_the_prison_story_picked_up_inside_and_state_secrets_after_more_valuable_than_gold_2560() {
	let (c, i) = alcaz();
	let (before, _) = journal(&c, &i, &[]);
	assert_eq!(ids(&page(&before, "alcaz-prison")), vec![96332, 96335, 96381], "the boss rules alone: the key and Ca'zass's head");
	let (j, warnings) = journal(&c, &i, &journal_rows());
	assert!(warnings.iter().all(|w| !is_match(w, "journal-quests")), "{warnings:?}");
	let p = page(&j, "alcaz-prison");
	assert_eq!(ids(&p), vec![95262, 95263, 95309, 95454, 95483, 96332, 96334, 96335, 96337, 96369, 96376, 96377, 96381]);
	let inside = json!({ "kind": null, "id": null, "name": null, "map": null, "x": null, "y": null, "f": null, "inside": true });
	for (id, start, finish) in [(96335, true, true), (96337, true, false), (95454, true, true), (96369, true, true), (95483, true, false), (95263, true, false), (95262, false, true), (95309, false, true)] {
		let q = page_quest(&p, id);
		assert_eq!(q["inside"], json!(start), "{id} picked up inside");
		if start {
			assert_eq!(q["start"], inside, "{id}: picked up inside, at no one the data places");
		}
		if finish {
			assert_eq!(q["finish"], inside, "{id}: handed in inside");
		}
	}
	assert_eq!((page_quest(&p, 96337)["finish"]["id"].clone(), page_quest(&p, 96337)["finish"]["inside"].clone()), (json!(611086), json!(false)), "Connery's Trunk, Westfall");
	assert_eq!(page_quest(&p, 95483)["finish"]["id"], 4949, "Thrall, Orgrimmar");
	let horde = page_quest(&p, 96376);
	assert_eq!((horde["faction"].clone(), horde["start"]["id"].clone(), horde["inside"].clone()), (json!("H"), json!(3230), json!(false)), "Nazgrel");
	assert_eq!(horde["chain"], json!([96335, 96337]), "after More Valuable Than Gold, and the key before it");
	let alliance = page_quest(&p, 96377);
	assert_eq!((alliance["faction"].clone(), alliance["start"]["id"].clone(), alliance["finish"]["id"].clone()), (json!("A"), json!(6946), json!(6946)), "Renzik \"The Shiv\"");
	assert_eq!(alliance["chain"], json!([96335, 96337]));
	assert_eq!(page_quest(&p, 96332)["objectives"][2], json!({ "k": "item", "id": 273883, "name": "Ca'zass's Head" }));
	let ties = |name: &str| p["bosses"].as_array().unwrap().iter().find(|b| b["name"] == name).unwrap()["quests"].as_array().unwrap().iter().map(|t| t["id"].clone()).collect::<Vec<_>>();
	assert_eq!(ties("Tidemistress Ca'zass"), vec![json!(96332), json!(96381)], "both sides' head");
	for key in ["wailing-caverns", "deadmines"] {
		assert_eq!(page(&j, key), page(&before, key), "unrelated page {key}");
	}
}

// #2560 on the page: a quest picked up inside says so, its giver line names the place (no one to name), and State
// Secrets names Nazgrel for the Horde and Renzik for the Alliance with More Valuable Than Gold before it. The
// pick-up guide takes Sergeant Ulka's three on Alcaz Island and nothing from inside, nor State Secrets before the run.
#[test]
fn the_alcaz_prison_page_says_picked_up_inside_and_names_each_sides_state_secrets_giver_2560() {
	let (c, i) = alcaz();
	let pack = pack(&c, &i);
	let out = run(
		&pack,
		r#"uistub.player.level, uistub.player.race, uistub.player.class, uistub.player.faction = 52, "Orc", "WARRIOR", "Horde""#,
		r#"
		Polestar.Dungeons.Open("alcaz-prison")
		local h = { chains = card(96335), gold = card(96337), honor = card(95454), thrall = card(95483), secrets = card(96376), renzik = card(96377) }
		local plan = Polestar.Dungeons.PickupPlan("alcaz-prison")
		local take = {}
		for _, t in ipairs(plan and plan.take or {}) do take[#take + 1] = t.quest.id end
		table.sort(take)
		DS.SetFaction("Alliance")
		Polestar.Dungeons.Open("alcaz-prison")
		emit({ h = h, take = take, a = { somber = card(95263), renzik = card(96377), nazgrel = card(96376) } })"#,
	);
	let h = &out["h"];
	for k in ["chains", "gold", "honor", "thrall"] {
		assert!(is_match(h[k]["meta"].as_str().unwrap(), "Picked up inside the dungeon"), "{k}: {}", h[k]["meta"]);
		assert_eq!(h[k]["start"], "inside the dungeon", "{k}");
	}
	assert_eq!(h["chains"]["finish"], "inside the dungeon");
	assert_eq!(h["gold"]["finish"], "Connery's Trunk  \u{b7}  Westfall");
	assert_eq!(h["thrall"]["finish"], "Thrall  \u{b7}  Orgrimmar");
	assert!(!is_match(h["secrets"]["meta"].as_str().unwrap(), "Picked up inside"), "{}", h["secrets"]["meta"]);
	assert_eq!(h["secrets"]["start"], "Nazgrel  \u{b7}  Orgrimmar");
	assert_eq!(h["secrets"]["chain"], json!(["The Man in the Iron Chains", "More Valuable Than Gold"]));
	assert_eq!(h["renzik"], false, "the Alliance's State Secrets is not on the Horde's page");
	assert_eq!(out["take"], json!([95309, 96332, 96334]), "Sergeant Ulka's three; nothing from inside, no State Secrets before the run");
	let a = &out["a"];
	assert_eq!(a["renzik"]["start"], "Renzik \"The Shiv\"  \u{b7}  Stormwind City");
	assert_eq!(a["renzik"]["chain"], json!(["The Man in the Iron Chains", "More Valuable Than Gold"]));
	assert_eq!(a["somber"]["start"], "inside the dungeon");
	assert_eq!(a["somber"]["finish"], "Sully McCleary  \u{b7}  Dustwallow Marsh");
	assert_eq!(a["nazgrel"], false);
}

// The #2560 sweep, Krol'dok Stronghold: Krol'dok Moulding (94973 Horde, 94980 Alliance) starts from the mould Tunk
// drops; 27 people killed him inside the stronghold, none anywhere else, but the data had him nowhere, so neither
// quest was on the page. forever-db/corrections/npcs.json places him inside (map 3039); the Codex gives his drop the
// instance, and the page takes both quests, picked up inside.
#[test]
fn krol_dok_moulding_from_tunk_inside_is_on_krol_dok_strongholds_page_picked_up_inside() {
	assert_eq!(corrected("npcs", 259256)["instances"], json!([3039]), "Tunk stands inside Krol'dok Stronghold");
	let f = fixture("dungeons.json");
	let (mut c, mut i) = (f["codex"].clone(), f["inputs"].clone());
	c["instances"]["kroldok-stronghold"] = json!({
		"key": "kroldok-stronghold", "name": "Krol'dok Stronghold", "kind": "dungeon", "forever": true, "areaId": null, "map": 3039, "entrance": null,
		"levels": [40, 43, 47], "bosses": [],
	});
	i["client"]["instanceMaps"].as_array_mut().unwrap().push(json!({ "id": 3039, "name": "Krol'dok Stronghold", "raid": false, "players": 5, "area": null, "areas": [], "inner": [], "zones": [], "corpse": null }));
	c["npcs"]["259256"] = npc(259256, "Tunk", Value::Null, json!("kroldok-stronghold"), None);
	c["npcs"]["256657"] = npc(256657, "Kreza Darkthorn", json!("H"), Value::Null, Some((2548, 59.1, 65.7)));
	c["npcs"]["259250"] = npc(259250, "Alphonse Dumas", json!("A"), Value::Null, Some((2548, 30.0, 40.0)));
	for (id, name) in [(267137, "Krol'dok Moulding"), (267138, "Krol'dok Moulding")] {
		c["items"][id.to_string()] = json!({ "id": id, "name": name, "quality": 1, "kind": "item", "spell": null, "reqLevel": null, "sources": [{ "type": "drop", "npc": 259256, "chance": null, "instance": "kroldok-stronghold" }] });
	}
	let moulding = |id: i64, races: i64, item: i64, ender: i64| {
		let mut q = quest(id, "Krol'dok Moulding", json!(races), json!({ "item": [item] }), json!({ "npc": [ender] }), json!([]), json!([]), false);
		q["level"] = json!(41);
		q["minLevel"] = json!(38);
		q
	};
	c["quests"]["94973"] = moulding(94973, HORDE, 267137, 256657);
	c["quests"]["94980"] = moulding(94980, ALLIANCE, 267138, 259250);
	let (j, _) = journal(&c, &i, &journal_rows());
	let p = page(&j, "kroldok-stronghold");
	assert_eq!(ids(&p), vec![94973, 94980]);
	assert_eq!(page_quest(&p, 94973)["startItem"]["id"], 267137);
	let pack = write_codex_pack(&c, &CodexOpts { extra_files: vec![("Dungeons1.lua".into(), emit_journal(&j))], ..Default::default() });
	let out = run(
		&pack,
		r#"uistub.player.level, uistub.player.race, uistub.player.class, uistub.player.faction = 42, "Orc", "WARRIOR", "Horde""#,
		r#"
		Polestar.Dungeons.Open("kroldok-stronghold")
		local plan = Polestar.Dungeons.PickupPlan("kroldok-stronghold")
		emit({ moulding = card(94973), take = plan and #plan.take or 0 })"#,
	);
	assert!(is_match(out["moulding"]["meta"].as_str().unwrap(), "Picked up inside the dungeon"), "{}", out["moulding"]["meta"]);
	assert_eq!(out["moulding"]["start"], "Krol'dok Moulding  \u{b7}  drops from Tunk");
	assert_eq!(out["take"], 0, "nothing to pick up before the run");
}

// The #2560 sweep, Shadowfang Keep and the Scarlet Monastery: an objective item an object holds inside one instance
// only ties its quest to that dungeon, as a drop does: The Horn of Xelthos (the Ornamented Chest, Shadowfang Keep),
// The Test of Righteousness (Jordan's Hammer there), The Eye of Bhossca (the Padlocked Reliquary, the Scarlet
// Monastery); 11, 7 and 7 people progressed them inside. A Moon-Kissed Blade's Enchanted Silver Ingot lies in an
// object the data has not placed: its cited row adds it. An item an object out in the world holds ties nothing.
#[test]
fn objective_items_an_object_holds_inside_one_dungeon_tie_their_quests_to_it_and_a_row_adds_the_moon_kissed_blade() {
	let f = fixture("dungeons.json");
	let (mut c, mut i) = (f["codex"].clone(), f["inputs"].clone());
	for (key, name, map) in [("shadowfang-keep", "Shadowfang Keep", 33), ("scarlet-monastery", "Scarlet Monastery", 189)] {
		c["instances"][key] = json!({ "key": key, "name": name, "kind": "dungeon", "forever": false, "areaId": null, "map": map, "entrance": null, "levels": [20, 25, 30], "bosses": [] });
		i["client"]["instanceMaps"].as_array_mut().unwrap().push(json!({ "id": map, "name": name, "raid": false, "players": 5, "area": null, "areas": [], "inner": [], "zones": [], "corpse": null }));
	}
	let object = |id: i64, name: &str, instances: Value| (id, json!({ "id": id, "name": name, "instances": instances }));
	for (id, o) in [object(410528, "Ornamented Chest", json!([33])), object(91138, "Jordan's Hammer", json!([33])), object(412261, "Padlocked Reliquary", json!([189])), object(92420, "Jordan's Ore Shipment", Value::Null)] {
		i["forever"]["objects"][id.to_string()] = o.clone();
		c["objects"][id.to_string()] = json!({ "id": id, "name": o["name"], "spawns": [] });
	}
	let item = |id: i64, name: &str, object: Option<i64>| {
		let sources = object.map_or(json!([]), |o| json!([{ "type": "object", "object": o, "chance": 100 }]));
		json!({ "id": id, "name": name, "quality": 1, "kind": "item", "spell": null, "reqLevel": null, "sources": sources })
	};
	for (id, name, object) in [(210183, "Horn of Xelthos", Some(410528)), (6895, "Jordan's Smithing Hammer", Some(91138)), (210953, "Eye of Bhossca", Some(412261)), (6992, "Jordan's Ore Shipment", Some(92420)), (267361, "Enchanted Silver Ingot", None)] {
		c["items"][id.to_string()] = item(id, name, object);
	}
	let one = |id: i64, title: &str, races: Value, item: i64| {
		let mut q = quest(id, title, races, json!({ "npc": [1938] }), json!({ "npc": [1938] }), json!([]), json!([{ "type": "item", "id": item, "count": 1 }]), false);
		q["level"] = json!(25);
		q
	};
	c["quests"]["78261"] = one(78261, "The Horn of Xelthos", Value::Null, 210183);
	c["quests"]["1654"] = one(1654, "The Test of Righteousness", json!(ALLIANCE), 6895);
	c["quests"]["78676"] = one(78676, "The Eye of Bhossca", Value::Null, 210953);
	c["quests"]["95036"] = one(95036, "A Moon-Kissed Blade", json!(HORDE), 267361);
	c["quests"]["90100"] = one(90100, "Ore Out in the World", Value::Null, 6992);
	let (j, _) = journal(&c, &i, &journal_rows());
	assert_eq!(ids(&page(&j, "shadowfang-keep")), vec![1654, 78261, 95036]);
	assert_eq!(ids(&page(&j, "scarlet-monastery")), vec![78676]);
	for key in ["wailing-caverns", "deadmines"] {
		assert!(page(&j, key)["quests"].as_array().unwrap().iter().all(|q| q["id"] != 90100), "the ore in the world ties nothing ({key})");
	}
}
