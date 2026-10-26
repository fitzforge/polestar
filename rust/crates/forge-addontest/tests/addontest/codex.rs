//! Lookup's Codex: the pack emitter (tools/lib/codex/pack.js) round-trips through the in-game decoder
//! (Lookup/Codex.lua), the merge (tools/lib/codex/build.js) applies precedence and dedupes sources on synthetic
//! importer outputs, and Core/Data.lua loads packs on demand.

use forge_addontest::codex::{sample_codex, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::dsl::plain;
use forge_addontest::run::root;
use forge_addontest::tmp::TempDir;
use forge_addontest::{emitted, is_match, truthy, Addon, RunAddon};
use forge_data::codex::client::{client_facts, ClientFacts, ClientItem, Tables};
use forge_data::codex::merge::{merge_codex, Merged};
use forge_data::codex::pack::{emit_pack, fold_name, PackCodex};
use forge_data::codex::{build_inputs, curated_rep_gates_in, Forever, Inputs, Options};
use forge_guide::js::{parse_json, V};
use regex::Regex;
use serde_json::{json, Value};

fn files() -> Addon {
	Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Core/Data.lua", "Core/LuaChunks.lua", "Core/Names.lua", "Core/GuideTexts.lua", "Core/Guides.lua", "Lookup/Codex.lua"])
}

fn run(script: &str, before: &str, pack: Option<&CodexPack>) -> Vec<Value> {
	emitted(&RunAddon { before: format!("{}\n{}", pack.map_or("", |p| p.stub_lua.as_str()), before), addons: vec![files()], script: script.into(), ..Default::default() })
}

// JSON nulls are absent in Lua and empty lists encode as {} or [].
fn norm(v: &Value) -> Value {
	match v {
		Value::Array(a) => Value::Array(a.iter().map(norm).collect()),
		Value::Object(o) => {
			let m: serde_json::Map<String, Value> = o.iter().filter(|(_, x)| !x.is_null()).map(|(k, x)| (k.clone(), norm(x))).collect();
			if m.is_empty() {
				json!([])
			} else {
				Value::Object(m)
			}
		}
		Value::Number(n) => match n.as_f64() {
			Some(f) if f.fract() == 0.0 && f.abs() < 1e15 => json!(f as i64),
			_ => v.clone(),
		},
		_ => v.clone(),
	}
}

/// The size of an emitted list or table.
fn len(v: &Value) -> usize {
	match v {
		Value::Array(a) => a.len(),
		Value::Object(o) => o.len(),
		_ => panic!("not a list: {v}"),
	}
}

/// emitPack(codex, { version: '1' }).
fn emit_codex(codex: &Value) -> Vec<(String, String)> {
	let c = parse_json(&codex.to_string()).unwrap();
	let part = |k: &str| {
		let v = c.get(k);
		if v.truthy() {
			v
		} else {
			V::obj()
		}
	};
	let (items, npcs, objects, quests, instances, zones, factions, spells, meta, frames) =
		(part("items"), part("npcs"), part("objects"), part("quests"), part("instances"), part("zones"), part("factions"), part("spells"), part("meta"), part("frames"));
	emit_pack(
		&PackCodex { items: &items, npcs: &npcs, objects: &objects, quests: &quests, instances: &instances, zones: &zones, factions: &factions, spells: &spells, meta: &meta, frames: &frames },
		"1",
		&V::Null,
		&[],
	)
	.unwrap_or_else(|e| panic!("{e}"))
}

#[test]
fn emitpack_round_trips_every_record_through_codex_lua() {
	let codex = sample_codex();
	let pack = write_codex_pack(&codex, &CodexOpts::default());
	let keys = |k: &str| -> Vec<String> { codex[k].as_object().map(|o| o.keys().cloned().collect()).unwrap_or_default() };
	let ids = serde_json::to_string(&json!({
		"items": keys("items"),
		"npcs": keys("npcs"),
		"objects": keys("objects"),
		"quests": keys("quests"),
		"zones": keys("zones"),
		"factions": keys("factions"),
		"spells": keys("spells"),
	}))
	.unwrap()
	.replace('[', "{")
	.replace(']', "}");
	let ids = Regex::new(r#""(\w+)":"#).unwrap().replace_all(&ids, "$1=").into_owned();
	let script = String::from(
		r#"
local ok, reason = Polestar.Codex.Load()
emit({ ok = ok, reason = reason, schema = Polestar.Codex.Meta().schema, frame = Polestar.MapFrames.era[1429] ~= nil })
local C = Polestar.Codex
local out = { items = {}, npcs = {}, objects = {}, quests = {}, instances = {}, zones = {}, factions = {}, spells = {} }
local ids = "#,
	) + &ids
		+ r#"
for _, id in ipairs(ids.items) do out.items[id] = C.Item(id) end
for _, id in ipairs(ids.npcs) do out.npcs[id] = C.Npc(id) end
for _, id in ipairs(ids.objects) do out.objects[id] = C.Object(id) end
for _, id in ipairs(ids.quests) do out.quests[id] = C.Quest(id) end
for _, id in ipairs(ids.zones) do out.zones[id] = C.Zone(id) end
for _, id in ipairs(ids.factions) do out.factions[id] = C.Faction(id) end
for _, id in ipairs(ids.spells) do out.spells[id] = C.Spell(id) end
out.instances.stratholme = C.Instance("stratholme")
emit(out)
"#;
	let out = run(&script, "", Some(&pack));
	let (loaded, got) = (&out[0], &out[1]);
	assert_eq!(*loaded, json!({ "ok": true, "schema": 1, "frame": true }));
	let mut spells = serde_json::Map::new();
	if let Some(all) = codex["spells"].as_object() {
		for (id, s) in all {
			let mut r = json!({ "id": id.parse::<i64>().unwrap() });
			for (k, v) in s.as_object().unwrap() {
				r[k] = v.clone();
			}
			spells.insert(id.clone(), r);
		}
	}
	let want = json!({
		"items": codex["items"],
		"npcs": codex["npcs"],
		"objects": codex["objects"],
		"quests": codex["quests"],
		"instances": codex["instances"],
		"zones": codex["zones"],
		"factions": codex["factions"],
		"spells": spells,
	});
	for k in want.as_object().unwrap().keys() {
		assert_eq!(norm(&got[k]), norm(&want[k]), "{k}");
	}
}

#[test]
fn codex_each_walks_one_kind_with_names_and_item_quality_and_stops_on_false() {
	let pack = write_codex_pack(&sample_codex(), &CodexOpts::default());
	let out = run(
		r#"
local C = Polestar.Codex
local out = {}
for _, kind in ipairs({ "item", "mount", "pet", "recipe", "tabard", "npc", "rare", "quest", "zone", "instance", "treasure", "object" }) do
	local list = {}
	C.Each(kind, function(id, name, quality) list[#list + 1] = tostring(id) .. "=" .. name .. (quality and ("/" .. quality) or "") end)
	table.sort(list)
	out[kind] = list
end
emit(out)
local n = 0
C.Each("mount", function() n = n + 1; return false end)
emit(n)
emit({ C.Name("item", 13335), C.Name("npc", 61), C.Name("object", 2843), C.Name("instance", "stratholme"), C.Name("mount", 5976) == nil })
emit({ rare = C.Loot("rare", 61), npc = C.Loot("npc", 61), treasure = C.Loot("treasure", 2843), object = C.Loot("object", 2843),
	plain = #C.Loot("npc", 4730), wrongKind = #C.Loot("rare", 4730), missing = #C.Loot("npc", 1), badKind = #C.Loot("quest", 176) })
"#,
		"",
		Some(&pack),
	);
	let (each, stopped, names, loot) = (&out[0], &out[1], &out[2], &out[3]);
	assert_eq!(
		each["mount"],
		json!([
			"13086=Reins of the Winterspring Frostsaber/4",
			"13335=Deathcharger's Reins/4",
			"18245=Horn of the Black War Wolf/4",
			"8631=Reins of the Striped Frostsaber/3",
			"8632=Reins of the Spotted Frostsaber/3",
		])
	);
	assert_eq!(each["pet"], json!(["8485=Cat Carrier (Bombay)/1"]));
	assert_eq!(each["tabard"], json!(["5976=Guild Tabard/1"]));
	assert_eq!(each["recipe"], json!(["6454=Manual: Strong Anti-Venom/1"]));
	assert_eq!(each["item"].as_array().unwrap().len(), 7);
	assert_eq!(each["rare"], json!(["61=Thuros Lightfingers"]));
	assert_eq!(each["npc"].as_array().unwrap().len(), 9);
	assert_eq!(each["treasure"], json!(["2843=Battered Chest"]));
	assert_eq!(each["object"], json!(["68=Wanted Poster"]));
	assert_eq!(each["quest"], json!(["176=Wanted: \"Hogger\"", "33=Wolves Across the Border"]));
	assert_eq!(each["instance"], json!(["stratholme=Stratholme"]));
	assert_eq!(each["zone"].as_array().unwrap().len(), 7);
	assert_eq!(*stopped, 1);
	assert_eq!(*names, json!(["Deathcharger's Reins", "Thuros Lightfingers", "Battered Chest", "Stratholme", true]));
	assert_eq!(*loot, json!({ "rare": [1933, 2933], "npc": [1933, 2933], "treasure": [1179], "object": [1179], "plain": 0, "wrongKind": 0, "missing": 0, "badKind": 0 }));
}

#[test]
fn emitpack_is_deterministic_and_splits_large_groups_across_files() {
	let codex = sample_codex();
	assert_eq!(emit_codex(&codex), emit_codex(&sample_codex()));
	let mut items = serde_json::Map::new();
	for id in 1..=9000 {
		items.insert(id.to_string(), json!({ "id": id, "name": format!("Item {id}"), "quality": 1, "kind": "item", "spell": null, "reqLevel": null, "sources": [] }));
	}
	let big = json!({ "meta": {}, "items": items });
	let files = emit_codex(&big);
	let file = |n: &str| files.iter().find(|(f, _)| f == n).map(|(_, t)| t.as_str()).unwrap_or_else(|| panic!("no {n}"));
	let toc = file("Polestar_Codex.toc");
	assert!(is_match(toc, r"(?m)^## Interface: 16001$"));
	assert!(is_match(toc, r"(?m)^## LoadOnDemand: 1$"));
	assert!(is_match(toc, r"(?m)^## Dependencies: Polestar$"));
	assert!(is_match(toc, r"(?m)^## Title: Polestar Codex$"));
	assert_eq!(toc.split('\n').filter(|l| l.ends_with(".lua")).collect::<Vec<_>>(), vec!["Meta.lua", "Items1.lua", "Items2.lua", "Items3.lua", "Index.lua"]);
	// Long strings, not table constructors: one Register call per chunk with the id range.
	assert!(is_match(file("Items2.lua"), r#"(?m)^C\.Register\("item", "\\n4001\\t1\\tItem 4001\\n4002\\t"#));
	assert!(is_match(file("Items2.lua"), r"(?m), 4001, 8000\)$"));
	let pack = write_codex_pack(&big, &CodexOpts::default());
	let out = run(
		r#"
local C = Polestar.Codex
local out = {}
for _, id in ipairs({ 1, 4000, 4001, 8000, 8001, 9000 }) do
	local r = C.Item(id)
	out[#out + 1] = C.Name("item", id) .. "|" .. r.name .. "|" .. r.quality
end
out[#out + 1] = tostring(C.Item(9001)) .. "|" .. tostring(C.Name("item", 0)) .. "|" .. tostring(C.Name("item", "x"))
local n = 0
C.Each("item", function() n = n + 1 end)
out[#out + 1] = n
emit(out)
"#,
		"",
		Some(&pack),
	);
	assert_eq!(out[0], json!(["Item 1|Item 1|1", "Item 4000|Item 4000|1", "Item 4001|Item 4001|1", "Item 8000|Item 8000|1", "Item 8001|Item 8001|1", "Item 9000|Item 9000|1", "nil|nil|nil", 9000]));
}

#[test]
fn codex_index_serves_one_search_blob_per_kind_and_never_loads_the_pack() {
	let mut codex = sample_codex();
	codex["items"]["8632"]["status"] = json!("retired");
	let pack = write_codex_pack(&codex, &CodexOpts::default());
	let out = run(
		r#"
local C = Polestar.Codex
emit({ C.Index("mount") == nil, C.IsLoaded() })
C.Load()
local out = {}
for _, k in ipairs({ "item", "mount", "pet", "recipe", "tabard", "npc", "rare", "quest", "zone", "instance", "treasure", "object", "faction", "spell" }) do
	out[k] = C.Index(k) or false
end
emit(out)
"#,
		"",
		Some(&pack),
	);
	let (before, blobs) = (&out[0], &out[1]);
	assert_eq!(*before, json!([true, false]));
	let lines = |k: &str| -> Vec<String> { blobs[k].as_str().unwrap().split('\n').filter(|l| !l.is_empty()).map(String::from).collect() };
	assert_eq!(
		lines("mount"),
		vec![
			"\x02reins of the striped frostsaber\x018631,3,,31",
			"\x02reins of the spotted frostsaber\x018632,3,r,31",
			"\x02reins of the winterspring frostsaber\x0113086,4,,36",
			"\x02deathchargers reins\x0113335,4,,20",
			"\x02horn of the black war wolf\x0118245,4,,26",
		]
	);
	assert_eq!(lines("quest"), vec!["\x02wolves across the border\x0133,,,24", "\x02wanted hogger\x01176,,,16"]);
	assert_eq!(lines("instance"), vec!["\x02stratholme\x01stratholme,,,10"]);
	assert_eq!(lines("rare"), vec!["\x02thuros lightfingers\x0161,,,19"]);
	assert_eq!(lines("treasure"), vec!["\x02battered chest\x012843,,,14"]);
	assert_eq!(lines("zone").len(), 7);
	assert_eq!(lines("npc").len(), 9);
	assert_eq!(lines("item").len(), 7);
	assert_eq!(blobs["object"], false, "objects, factions and spells are not searched");
	assert_eq!(blobs["faction"], false);
	assert_eq!(blobs["spell"], false);
}

#[test]
fn foldname_folds_names_exactly_like_search_fold_without_its_leading_space() {
	let names = [
		"Reins of the Striped Frostsaber",
		"Deathcharger's Reins",
		"Zul'Gurub",
		"Ahn\u{2019}Qiraj",
		"Señor Ñandú",
		"Ægis Øre Straße",
		"Œuvre Ÿ",
		"Хоггер Ёлка ёж",
		"霍格",
		"Ironforge - East",
		"A.B.C. 123",
		"Test×Thing ÷ 2",
		"  spaced  out  ",
		"",
		"[Tag] (Old) 1/2",
		"Ünder-Café",
		"Tab\tName\nNext",
		"ÿþ",
		"ALL CAPS!",
		"\"Quoted\" & co.",
		"Über_Thing~#5",
	];
	let list = names.iter().map(|n| serde_json::to_string(n).unwrap()).collect::<Vec<_>>().join(", ");
	let script = String::from("\nlocal names = { ")
		+ &list
		+ r#" }
local out = {}
for i, n in ipairs(names) do out[i] = (Polestar.Search.Fold(n):gsub("^ ", "")) end
emit(out)
"#;
	let out = emitted(&RunAddon {
		addons: vec![Addon::files(
			"Polestar",
			&["Core/Init.lua", "Core/Compat.lua", "Core/Data.lua", "Core/LuaChunks.lua", "Core/Names.lua", "Core/GuideTexts.lua", "Core/Guides.lua", "Core/Search.lua"],
		)],
		script,
		..Default::default()
	});
	let folded: Vec<Value> = names.iter().map(|n| json!(fold_name(&V::str(n)))).collect();
	assert_eq!(json!(folded), out[0]);
	assert_eq!(fold_name(&V::str("Señor Ñandú")), "senor nandu");
	assert_eq!(fold_name(&V::str("Ahn\u{2019}Qiraj")), "ahnqiraj");
}

// ---------------------------------------------------------------------------
// Data.Pack / Data.Info
// ---------------------------------------------------------------------------

#[test]
fn data_pack_reports_a_missing_pack_once_and_never_retries_it() {
	let out = run(
		r#"
local n = 0
local load = C_AddOns.LoadAddOn
C_AddOns.LoadAddOn = function(name) n = n + 1; return load(name) end
emit({ Polestar.Data.Pack("Polestar_Codex") })
emit({ Polestar.Data.Pack("Polestar_Codex") })
emit(n)
emit(Polestar.Data.Info("Polestar_Codex"))
"#,
		"",
		None,
	);
	assert_eq!(out[0], json!([false, "missing"]));
	assert_eq!(out[1], json!([false, "missing"]));
	assert_eq!(out[2], 1);
	assert_eq!(out[3], json!({ "loaded": false, "reason": "missing" }));
}

#[test]
fn data_pack_waits_out_combat_then_loads_once_and_reports_memory() {
	let pack = write_codex_pack(&sample_codex(), &CodexOpts::default());
	let out = run(
		r#"
local n = 0
local load = C_AddOns.LoadAddOn
C_AddOns.LoadAddOn = function(name) n = n + 1; return load(name) end
function UpdateAddOnMemoryUsage() end
function GetAddOnMemoryUsage(name) return name == "Polestar_Codex" and 1234.5 or 0 end
local fired = 0
Polestar.On("CODEX_LOADED", function(meta) fired = fired + (meta and 1 or 0) end)
stub.inCombat = true
emit({ Polestar.Data.Pack("Polestar_Codex") })
emit({ Polestar.Codex.Load() })
stub.inCombat = false
emit({ Polestar.Data.Pack("Polestar_Codex") })
emit({ Polestar.Codex.Load() })
Polestar.Codex.Load()
emit(n)
emit(Polestar.Data.Info("Polestar_Codex"))
emit(fired)
"#,
		"",
		Some(&pack),
	);
	assert_eq!(out[0], json!([false, "combat"]));
	assert_eq!(out[1], json!([false, "combat"]));
	assert_eq!(out[2], json!([true]));
	assert_eq!(out[3], json!([true]));
	assert_eq!(out[4], 1);
	assert_eq!(out[5], json!({ "loaded": true, "memoryKB": 1234.5 }));
	assert_eq!(out[6], 1);
}

#[test]
fn data_pack_passes_loadaddon_reasons_through_in_lower_case() {
	let out = run(
		r#"
C_AddOns.LoadAddOn = function(name)
	if name == "Broken" then error("boom") end
	return false, "DISABLED"
end
emit({ Polestar.Data.Pack("Polestar_Codex") })
emit({ Polestar.Data.Pack("Broken") })
"#,
		"",
		None,
	);
	assert_eq!(out[0], json!([false, "disabled"]));
	assert_eq!(out[1], json!([false, "error"]));
}

// A player who copies only some of the release zip's folders, or an old one over a new one, is told at login.
// The stub's default TOC version is "0.1.0-test" for every addon, Polestar included.
fn login_with(addons: &[(&str, Option<&str>)]) -> Value {
	let list = addons.iter().map(|(n, _)| format!("{{ name = \"{n}\" }}")).collect::<Vec<_>>().join(", ");
	let meta = addons.iter().filter_map(|(n, v)| v.map(|v| format!("stub.addonMeta[\"{n}\"] = {{ Version = \"{v}\" }}"))).collect::<Vec<_>>().join("\n");
	emitted(&RunAddon {
		before: format!("stub.addons = {{ {list} }}\n{meta}"),
		addons: vec![files()],
		login: true,
		script: r#"
local missing, stale = Polestar.Data.CheckInstall()
local said = {}
for _, m in ipairs(stub.messages) do if m:find("installed incompletely", 1, true) then said[#said + 1] = m end end
emit({ missing = table.concat(missing, ","), stale = table.concat(stale, ","), said = said })"#
			.into(),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_complete_install_of_one_version_says_nothing_at_login_the_optional_data_packs_may_be_absent() {
	let out = login_with(&[("Polestar", None), ("Polestar_Guides", None), ("Polestar_Codex", None)]);
	assert_eq!(out["missing"], "");
	assert_eq!(out["stale"], "");
	assert_eq!(len(&out["said"]), 0);
}

#[test]
fn a_missing_codex_and_a_guides_folder_from_an_old_zip_are_named_once_in_chat_with_how_to_reinstall() {
	let out = login_with(&[("Polestar", None), ("Polestar_Guides", Some("0.2.1")), ("Polestar_QuestDB", None)]);
	assert_eq!(out["missing"], "Polestar_Codex");
	assert_eq!(out["stale"], "Polestar_Guides (0.2.1)");
	assert_eq!(out["said"].as_array().unwrap().len(), 1);
	let said = out["said"][0].as_str().unwrap();
	assert!(is_match(said, r"Polestar_Codex not installed; Polestar_Guides \(0\.2\.1\) from another version"));
	assert!(is_match(said, r#"delete every Polestar folder.*not "Source code""#));
}

// Our guides' part for the player's faction (format 8) ships in every release: without it the player has no
// leveling guides, so a copy that left it out is named like a missing Codex. The other faction's is never.
#[test]
fn a_missing_faction_part_of_our_guides_is_named_at_login_the_other_faction_s_is_not() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: "stub.addons = { { name = \"Polestar\" }, { name = \"Polestar_Guides\" }, { name = \"Polestar_Codex\" }, { name = \"Polestar_Guides_Alliance\" } }\nstub.world.faction = \"Horde\""
			.into(),
		addons: vec![files()],
		login: true,
		script: "local missing = Polestar.Data.CheckInstall()\nemit({ missing = table.concat(missing, \",\") })".into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["missing"], "Polestar_Guides_Horde");
}

// ---------------------------------------------------------------------------
// Merge (forge_data::codex::merge, the port of tools/lib/codex/build.js) on synthetic importer outputs
// ---------------------------------------------------------------------------

/// The synthetic importer outputs. The JS inputs also held AtlasLoot (the Stratholme instance with Baron
/// Rivendare dropping 13335 at 0.1, the Mounts collection listing 13335, the Wintersaber Trainers rewards
/// 13086 at 7, 20000 at 6 and 20001 at 5, the PvP reward 18876 at rank 14) and RareScanner (rare 61 at
/// 89.4,79.3 with points 89.4,79.3 / 89.6,79.5 / 69.6,79.4 and loot 2933, a rare 777777 outside Forever zones,
/// treasure 2843 with loot 2933 and 424242); the Rust merge's Inputs have no such sources, so they are not
/// passed. The assertions on what they gave are kept.
struct Synth {
	forever: Value,
	flbis: Value,
	atlasloot: Option<Value>,
	rarescanner: Option<Value>,
	client: ClientFacts,
	web: Option<Value>,
	curated: Vec<f64>,
}

fn put(t: &mut Tables, name: &'static str, rows: &[&[(&str, &str)]]) {
	t.insert(name, rows.iter().map(|r| r.iter().map(|(k, v)| (k.to_string(), v.to_string())).collect()).collect());
}

fn synthetic() -> Synth {
	// Zone-sized, 4000 x 4000 yd: 50,50 on it is the world point (2000, -2000).
	let era = json!({ "left": 0, "right": -4000, "top": 4000, "bottom": 0, "c": 1 });
	// A capital inside it, 800 yd on its long side, where 50,50 is that same world point: both frames hold the
	// place, and this one is enclosed.
	let city = json!({ "left": -1600, "right": -2400, "top": 2400, "bottom": 1600, "c": 1 });
	// A neighbouring zone, 3000 yd and hanging over the zone's edge, so neither holds the other and neither is
	// enclosed. 83.33,50 is the world point again.
	let neighbour = json!({ "left": 500, "right": -2500, "top": 3500, "bottom": 500, "c": 1 });
	// A capital that overlaps the zone without lying inside it, as the Undercity does with Silverpine Forest
	// (#350). 6.25,50 and the zone's 98.75,50 are both the world point (2000, -3950).
	let sunken = json!({ "left": -3900, "right": -4700, "top": 2400, "bottom": 1600, "c": 1 });
	let zones = json!({
		"1438": { "id": 1438, "name": "Teldrassil" },
		"1457": { "id": 1457, "name": "Darnassus" },
		"1458": { "id": 1458, "name": "Undercity" },
		"1460": { "id": 1460, "name": "Darkshore" },
		"1423": { "id": 1423, "name": "Eastern Plaguelands" },
		"1429": { "id": 1429, "name": "Elwynn Forest" },
	});
	let factions = json!({ "589": { "id": 589, "name": "Wintersaber Trainers", "side": "Alliance" } });
	let map_frames = json!({ "era": { "1438": era.clone(), "1429": era, "1457": city, "1460": neighbour, "1458": sunken } });
	let meta = json!({ "builtAt": "2026-01-01T00:00:00.000Z", "sources": [{ "name": "pfQuest", "revision": "abc", "license": "MIT" }] });
	let npcs = json!({
		"4730": { "id": 4730, "name": "Lelanai", "level": 35, "faction": "A", "roles": ["vendor"], "spawns": { "1438": { "f": "e", "pts": [[25.2, 50.1], [25.3, 50.2], [70, 70]] } }, "source": ["questie-forever"] },
		"7747": { "id": 7747, "name": "World Mount Vendor", "level": 10, "faction": "AH", "roles": ["vendor"], "spawns": {} },
		"10440": { "id": 10440, "name": "Baron Rivendare", "level": 62, "rank": 1, "faction": null, "spawns": {} },
		"61": { "id": 61, "name": "Thuros Lightfingers", "level": 11, "rank": 4, "faction": null, "spawns": {} },
		"99": { "id": 99, "name": "Nobody", "level": 1, "faction": null, "spawns": {} },
		"1": { "id": 1, "name": "Waypoint (Only GM can see it)", "level": 1, "spawns": {} },
		"5164": { "id": 5164, "name": "Grumnus Steelshaper", "level": 60, "faction": "A", "roles": ["trainer"], "spawns": { "1429": { "f": "e", "pts": [[50, 42.8]] } } },
		"198": { "id": 198, "name": "Khelden Bremen", "level": 10, "faction": "A", "roles": ["trainer"], "spawns": { "1429": { "f": "l", "pts": [[49.7, 39.6]] } } },
		// One guard standing in the city, recorded on the city map and on the zone map that holds it, at the
		// same world point (#382).
		"4784": { "id": 4784, "name": "City Guard", "level": 23, "faction": "A", "spawns": { "1438": { "f": "e", "pts": [[50, 50]] }, "1457": { "f": "e", "pts": [[50, 50]] } } },
		// Two real places, one of them in the city: not the same guard twice.
		"4785": { "id": 4785, "name": "Wanderer", "level": 23, "faction": "A", "spawns": { "1438": { "f": "e", "pts": [[50, 50]] }, "1457": { "f": "e", "pts": [[10, 10]] } } },
		// On a zone border: one place on two maps, but neither map is in the other and neither is a place you
		// are inside.
		"4786": { "id": 4786, "name": "Border Mob", "level": 23, "faction": null, "spawns": { "1438": { "f": "e", "pts": [[50, 50]] }, "1460": { "f": "e", "pts": [[83.33, 50]] } } },
		// In a capital the zone's frame overlaps but does not hold (#350).
		"4787": { "id": 4787, "name": "Sunken Guard", "level": 23, "faction": "H", "spawns": { "1438": { "f": "e", "pts": [[98.75, 50]] }, "1458": { "f": "e", "pts": [[6.25, 50]] } } },
	});
	let objects = json!({
		"2843": { "id": 2843, "name": "Battered Chest", "roles": ["chest"], "spawns": { "1429": { "f": "e", "pts": [[63.5, 56.1]] } } },
		"500": { "id": 500, "name": "Some Door", "spawns": { "1429": { "f": "e", "pts": [[1, 1]] } } },
	});
	let items = json!({
		"8631": { "id": 8631, "name": "Reins of the Striped Frostsaber", "drops": { "npc": {}, "object": {} }, "vendors": [4730, 7747], "source": ["pfquest", "questie-forever"] },
		"13335": { "id": 13335, "name": "Deathcharger's Reins", "drops": { "npc": { "10440": 0.02 }, "object": {} }, "vendors": [7747], "source": ["pfquest"] },
		"13086": { "id": 13086, "name": "Reins of the Winterspring Frostsaber", "drops": { "npc": {}, "object": {} }, "vendors": [4730], "source": ["pfquest"] },
		"2933": { "id": 2933, "name": "Seal of Wrynn", "drops": { "npc": {}, "object": {} }, "vendors": [], "source": ["pfquest"] },
		"17": { "id": 17, "name": "Martin Fury", "drops": { "npc": {}, "object": {} }, "vendors": [] },
		"38": { "id": 38, "name": "OLDRecruit's Belt", "drops": { "npc": {}, "object": {} }, "vendors": [] },
		"2862": { "id": 2862, "name": "Rough Sharpening Stone", "drops": { "npc": {}, "object": {} }, "vendors": [] },
		"16342": { "id": 16342, "name": "Sergeant's Cape", "drops": { "npc": {}, "object": {} }, "vendors": [] },
		"20000": { "id": 20000, "name": "Wintersaber Trinket", "drops": { "npc": {}, "object": {} }, "vendors": [4730] },
		"20001": { "id": 20001, "name": "Wintersaber Reward", "drops": { "npc": {}, "object": {} }, "vendors": [] },
		"20002": { "id": 20002, "name": "Wintersaber Hat", "drops": { "npc": {}, "object": {} }, "vendors": [] },
		"1179": { "id": 1179, "name": "Ice Cold Milk", "drops": { "npc": {}, "object": { "2843": 25 } }, "vendors": [] },
	});
	let quests = json!({
		"176": { "id": 176, "title": "Wanted: \"Hogger\"", "level": 11, "minLevel": 5, "races": 77, "classes": null, "start": { "npc": [], "object": [68], "item": [] }, "end": { "npc": [240], "object": [] }, "pre": [1], "preAll": [33], "preAny": [7, 783], "objectives": [{ "type": "item", "id": 1931, "count": null, "text": "Huge Gnoll Claw", "map": 1429, "x": 30, "y": 60 }, { "type": "event", "id": 87, "count": null, "text": "Scout the camp", "map": 1429, "x": 32.04, "y": 61.96, "f": null }], "zone": 1429, "xp": 1050 },
		// A Hunter's Taming the Beast: kill credit on the beast, tamed with the Taming Rod (#565).
		"6063": { "id": 6063, "title": "Taming the Beast", "level": 10, "minLevel": 10, "races": 8, "classes": 4, "start": { "npc": [4730], "object": [], "item": [] }, "end": { "npc": [4730], "object": [] }, "pre": [], "objectives": [{ "type": "kill", "id": 1998, "count": 1, "text": "Webwood Lurker" }], "objectiveText": "Use the Taming Rod to tame a Webwood Lurker. Practice your skills, then return the Taming Rod to Dazalar in Dolanaar.", "zone": 1438 },
		// QuestieDB requiredMinRep 3000 (Friendly) and a reputation objective 9000 (Honored): the rewards need Honored.
		"9002": { "id": 9002, "title": "Protecting the Shipment", "level": 15, "minLevel": 10, "races": 77, "classes": null, "start": { "npc": [4730], "object": [], "item": [] }, "end": { "npc": [4730], "object": [] }, "pre": [], "objectives": [{ "type": "event", "id": null, "count": null, "text": "Escort Miran to the excavation site", "map": 1429, "x": 40, "y": 40 }], "zone": 1429 },
		"9001": { "id": 9001, "title": "Frostsaber Errand", "level": 60, "minLevel": 55, "races": null, "classes": null, "start": { "npc": [4730], "object": [], "item": [] }, "end": { "npc": [4730], "object": [] }, "pre": [], "objectives": [], "zone": 1438, "minRep": { "faction": 589, "value": 3000 }, "reputation": { "faction": 589, "value": 9000 }, "rewards": { "items": [20002] }, "source": ["questie-forever"] },
	});
	let professions = json!({
		"164": { "id": 164, "name": "Blacksmithing", "trainers": { "Alliance": [5164] }, "ranks": [], "recipes": [{ "spell": 2660, "name": "Rough Sharpening Stone", "item": 2862, "learnedAt": 1 }] },
	});
	let trainers = json!({ "198": { "id": 198, "name": "Khelden Bremen", "classes": ["MAGE"] } });
	let dungeons = json!({
		"source": { "name": "ForeverDungeonJournal", "version": "1.0" },
		"dungeons": [{ "key": "stratholme", "name": "Stratholme", "levels": { "min": 45, "max": 60 }, "entrance": { "map": 1423, "x": 27.43, "y": 11.61, "f": "l" }, "bosses": [], "quests": [{ "id": 5212, "title": "The Medallion of Faith", "rewards": { "items": [], "choices": [13335] } }] }],
	});
	let forever = json!({
		"zones": zones,
		"factions": factions,
		"mapFrames": map_frames,
		"meta": meta,
		"npcs": npcs,
		"objects": objects,
		"items": items,
		"quests": quests,
		"professions": professions,
		"trainers": trainers,
		"dungeons": dungeons,
	});
	let atlasloot = json!({
		"meta": { "version": "Forever 1.60.1", "licence": "GPL-2.0" },
		"instances": [
			{ "key": "Stratholme", "name": "Stratholme", "kind": "dungeon", "forever": true, "areaId": 2017, "levels": [37, 58, 60], "bosses": [{ "name": "Baron Rivendare", "npc": [10440], "items": [{ "item": 13335, "chance": 0.1 }] }] },
		],
		"droprates": {},
		"collections": [{ "group": "Mounts", "section": "Drops", "item": 13335, "faction": null }],
		"crafting": [],
		"factions": [{ "factionId": 589, "name": "Wintersaber Trainers", "rewards": [{ "item": 13086, "standing": 7 }, { "item": 20000, "standing": 6 }, { "item": 20001, "standing": 5 }] }],
		"pvp": [{ "group": "PvP", "item": 18876, "faction": "A", "rank": 14, "honor": null }],
	});
	let rarescanner = json!({
		"meta": { "version": "1.60.1.b7", "licence": "All Rights Reserved" },
		"rares": [
			{ "npc": 61, "name": null, "map": 1429, "x": 89.4, "y": 79.3, "points": [[89.4, 79.3], [89.6, 79.5], [69.6, 79.4]], "loot": [2933] },
			{ "npc": 61, "name": null, "map": 100001, "x": 1, "y": 1, "points": [], "loot": [] },
			{ "npc": 777777, "name": "Far Away Rare", "map": 100001, "x": 5, "y": 5, "points": [], "loot": [] },
		],
		"treasures": [{ "object": 2843, "name": null, "map": 1429, "x": 63.5, "y": 56.1, "points": [], "loot": [2933, 424242] }],
		"mounts": {},
		"pets": {},
	});
	let flbis = json!({
		"meta": { "version": "v0.5.1-beta", "licence": "MIT" },
		"items": { "2933": { "name": "Seal of Wrynn", "sources": [{ "type": "quest", "id": 176, "name": "Wanted: \"Hogger\"" }] } },
		"quests": { "176": { "name": "Wanted: \"Hogger\"", "rewards": { "choices": [2933, 1933] } } },
	});
	let mut t = Tables::default();
	put(
		&mut t,
		"Item",
		&[
			&[("ID", "8631"), ("ClassID", "15"), ("SubclassID", "5"), ("InventoryType", "0")],
			&[("ID", "13086"), ("ClassID", "15"), ("SubclassID", "5"), ("InventoryType", "0")],
			&[("ID", "13335"), ("ClassID", "15"), ("SubclassID", "0"), ("InventoryType", "0")],
			&[("ID", "2933"), ("ClassID", "4"), ("SubclassID", "0"), ("InventoryType", "11")],
		],
	);
	put(
		&mut t,
		"ItemSparse",
		&[
			&[("ID", "8631"), ("Display_lang", "Reins of the Striped Frostsaber"), ("OverallQualityID", "3"), ("RequiredLevel", "40"), ("BuyPrice", "800000")],
			&[
				("ID", "13086"),
				("Display_lang", "Reins of the Winterspring Frostsaber"),
				("OverallQualityID", "4"),
				("RequiredLevel", "60"),
				("BuyPrice", "1000000"),
				("MinFactionID", "589"),
				("MinReputation", "7"),
			],
			&[("ID", "13335"), ("Display_lang", "Deathcharger's Reins"), ("OverallQualityID", "4"), ("RequiredLevel", "60")],
			&[("ID", "2933"), ("Display_lang", "Seal of Wrynn"), ("OverallQualityID", "2"), ("RequiredLevel", "0"), ("RequiredSkill", "164"), ("RequiredSkillRank", "150")],
			&[("ID", "18876"), ("Display_lang", "Grand Marshal's Claymore"), ("OverallQualityID", "4"), ("RequiredLevel", "60"), ("RequiredPVPRank", "18")],
			&[("ID", "16342"), ("Display_lang", "Sergeant's Cape"), ("OverallQualityID", "3"), ("RequiredLevel", "30"), ("RequiredPVPRank", "7")],
			&[("ID", "99999"), ("Display_lang", "Dishonoured Thing"), ("OverallQualityID", "1"), ("RequiredLevel", "0"), ("RequiredPVPRank", "1")],
		],
	);
	put(
		&mut t,
		"ItemEffect",
		&[&[("ID", "1"), ("TriggerType", "0"), ("SpellID", "55884")], &[("ID", "2"), ("TriggerType", "6"), ("SpellID", "8394")], &[("ID", "3"), ("TriggerType", "6"), ("SpellID", "17481")]],
	);
	put(&mut t, "ItemXItemEffect", &[&[("ItemID", "8631"), ("ItemEffectID", "1")], &[("ItemID", "8631"), ("ItemEffectID", "2")], &[("ItemID", "13335"), ("ItemEffectID", "3")]]);
	put(
		&mut t,
		"SpellEffect",
		&[
			&[("SpellID", "8394"), ("Effect", "6"), ("EffectAura", "78")],
			&[("SpellID", "17481"), ("Effect", "6"), ("EffectAura", "78")],
			&[("SpellID", "13819"), ("Effect", "6"), ("EffectAura", "78")],
			&[("SpellID", "5784"), ("Effect", "6"), ("EffectAura", "78")],
		],
	);
	put(
		&mut t,
		"SpellName",
		&[
			&[("ID", "8394"), ("Name_lang", "Striped Frostsaber")],
			&[("ID", "17481"), ("Name_lang", "Deathcharger")],
			&[("ID", "13819"), ("Name_lang", "Summon Warhorse")],
			&[("ID", "5784"), ("Name_lang", "Summon Felsteed")],
		],
	);
	put(&mut t, "SkillLine", &[&[("ID", "164"), ("DisplayName_lang", "Blacksmithing")]]);
	put(
		&mut t,
		"SkillLineAbility",
		&[
			&[("SkillLine", "777"), ("Spell", "13819"), ("ClassMask", "2")],
			&[("SkillLine", "777"), ("Spell", "5784"), ("ClassMask", "0")],
			&[("SkillLine", "777"), ("Spell", "8394"), ("ClassMask", "0")],
		],
	);
	let client = client_facts(&t, "1.60.1.70338");
	Synth { forever, flbis, atlasloot: Some(atlasloot), rarescanner: Some(rarescanner), client, web: None, curated: Vec::new() }
}

fn inputs(s: Synth) -> Inputs {
	let v = |x: &Value| parse_json(&x.to_string()).unwrap();
	let f = &s.forever;
	Inputs {
		forever: Forever {
			items: v(&f["items"]),
			npcs: v(&f["npcs"]),
			objects: v(&f["objects"]),
			quests: v(&f["quests"]),
			zones: v(&f["zones"]),
			factions: v(&f["factions"]),
			professions: v(&f["professions"]),
			trainers: v(&f["trainers"]),
			map_frames: v(&f["mapFrames"]),
			meta: v(&f["meta"]),
			instances: V::obj(),
			dungeons: v(&f["dungeons"]),
		},
		atlasloot: s.atlasloot.as_ref().map(v),
		rarescanner: s.rarescanner.as_ref().map(v),
		local_extras: false,
		flbis: Some(v(&s.flbis)),
		client: Some(s.client),
		web: s.web.as_ref().map(v),
		curated: s.curated,
		curated_gates: V::obj(),
		entrances: Vec::new(),
		entrance_table: V::obj(),
		rep_table: V::obj(),
		attunement_table: V::obj(),
		journal_quests: Vec::new(),
		warnings: Vec::new(),
	}
}

fn codex_json(m: &Merged) -> Value {
	json!({
		"items": plain(&V::Obj(m.items.clone())),
		"npcs": plain(&V::Obj(m.npcs.clone())),
		"objects": plain(&V::Obj(m.objects.clone())),
		"quests": plain(&V::Obj(m.quests.clone())),
		"instances": plain(&V::Obj(m.instances.clone())),
		"zones": plain(&V::Obj(m.zones.clone())),
		"factions": plain(&V::Obj(m.factions.clone())),
		"spells": plain(&V::Obj(m.spells.clone())),
		"frames": plain(&V::Obj(m.frames.clone())),
	})
}

fn merged(s: Synth) -> Value {
	codex_json(&merge_codex(&inputs(s)))
}

/// `{ ...b, name }` of a client item.
fn like(b: &ClientItem, name: &str) -> ClientItem {
	ClientItem {
		name: Some(name.to_string()),
		quality: b.quality,
		req_level: b.req_level,
		buy_price: b.buy_price,
		min_faction: b.min_faction,
		min_standing: b.min_standing,
		pvp_rank: b.pvp_rank,
		req_skill: b.req_skill,
		req_skill_rank: b.req_skill_rank,
		class_id: b.class_id,
		subclass_id: b.subclass_id,
		inventory_type: b.inventory_type,
		learn: b.learn,
		use_: b.use_,
		era: b.era,
	}
}

fn find_type(sources: &Value, ty: &str) -> Value {
	sources.as_array().unwrap().iter().find(|s| s["type"] == ty).cloned().unwrap_or(Value::Null)
}

fn maps(spawns: &Value) -> Vec<Value> {
	spawns.as_array().unwrap().iter().map(|s| s["map"].clone()).collect()
}

#[test]
fn mergecodex_applies_precedence_dedupes_sources_and_keeps_provenance() {
	let codex = merged(synthetic());
	let it = &codex["items"];
	// Vendor: the GM vendor without spawns is left out; cost from the client.
	assert_eq!(it["8631"]["sources"], json!([{ "type": "vendor", "npc": 4730, "cost": 800000, "from": ["questie", "pfquest"] }]));
	assert_eq!(it["8631"]["kind"], "mount");
	assert_eq!(it["8631"]["spell"], 8394);
	assert_eq!(it["8631"]["quality"], 3);
	// Drop: data/forever (pfQuest) and AtlasLoot dedupe to one source; AtlasLoot's chance and pfQuest's rank
	// tie (Era), the first-ranked keeps its chance.
	let drops: Vec<&Value> = it["13335"]["sources"].as_array().unwrap().iter().filter(|s| s["type"] == "drop").collect();
	assert_eq!(drops.len(), 1);
	assert_eq!(drops[0]["npc"], 10440);
	assert_eq!(drops[0]["instance"], "stratholme");
	assert_eq!(drops[0]["from"], json!(["atlasloot", "pfquest"]));
	assert_eq!(it["13335"]["kind"], "mount");
	// Quest rewards from dungeons.json; the AtlasLoot Mounts collection makes it a mount.
	assert_eq!(find_type(&it["13335"]["sources"], "quest"), json!({ "type": "quest", "quest": 5212, "choice": true, "from": ["dungeons"] }));
	// Rep: the client's MinReputation (Exalted = 8) beats AtlasLoot's 7; the vendor is the quartermaster.
	assert_eq!(find_type(&it["13086"]["sources"], "rep"), json!({ "type": "rep", "faction": 589, "standing": 8, "npc": 4730, "from": ["client", "atlasloot"] }));
	// Purchase requirements from ItemSparse: MinReputation 7 = Exalted = standing 8.
	assert_eq!(json!([it["13086"]["repFaction"], it["13086"]["repStanding"], it["13086"]["reqSkill"], it["13086"]["reqSkillRank"]]), json!([589, 8, null, null]));
	assert_eq!(json!([it["2933"]["repFaction"], it["2933"]["repStanding"], it["2933"]["reqSkill"], it["2933"]["reqSkillRank"]]), json!([null, null, 164, 150]));
	// Gossip-gated vendor items (nothing in ItemSparse) take the reputation reward's faction and standing.
	assert_eq!(json!([it["20000"]["repFaction"], it["20000"]["repStanding"]]), json!([589, 6]));
	assert_eq!(json!([it["20001"]["repFaction"], it["20001"]["repStanding"]]), json!([null, null]), "a reputation reward nobody sells is not a purchase requirement");
	// A quest's gate (QuestieDB requiredMinRep, a reputation objective: the higher) is a rep source naming no
	// vendor, and stays on the quest, not on the item's purchase.
	assert_eq!(it["20002"]["sources"], json!([{ "type": "quest", "quest": 9001, "from": ["questie"] }, { "type": "rep", "faction": 589, "standing": 6, "from": ["questie"] }]));
	assert_eq!(json!([it["20002"]["repFaction"], it["20002"]["repStanding"]]), json!([null, null]));
	assert_eq!(json!([codex["quests"]["9001"]["repFaction"], codex["quests"]["9001"]["repStanding"]]), json!([589, 6]));
	assert!(codex["quests"]["176"]["repFaction"].is_null(), "an ungated quest carries no standing");
	// A quest's full XP reward comes along from quests.json; none known, none written.
	assert_eq!(codex["quests"]["176"]["xp"], 1050);
	assert!(codex["quests"]["9001"]["xp"].is_null());
	// Quest source from FLB items and FLB quest rewards dedupe (choice kept); RareScanner loot adds a drop.
	assert_eq!(it["2933"]["sources"], json!([{ "type": "quest", "quest": 176, "choice": true, "from": ["flbis"] }, { "type": "drop", "npc": 61, "from": ["rarescanner"] }]));
	assert_eq!(it["17"]["sources"].as_array().unwrap().len(), 0, "source-less items stay searchable");
	// Client RequiredPVPRank (5..18) becomes the title rank (1..14) and dedupes with AtlasLoot's.
	assert_eq!(it["18876"]["sources"], json!([{ "type": "pvp", "rank": 14, "from": ["client", "atlasloot"] }]));
	assert_eq!(it["16342"]["sources"], json!([{ "type": "pvp", "rank": 3, "from": ["client"] }]));
	assert!(it["99999"].is_null(), "dishonoured ranks are not PvP rewards (and the item has no other source or Forever name)");
	assert!(it["38"].is_null(), "junk names without sources are dropped");
	// Craft from professions.json, profession named by its skillLine.
	assert_eq!(it["2862"]["sources"], json!([{ "type": "craft", "spell": 2660, "skillLine": 164, "profession": "Blacksmithing", "skill": 1, "from": ["forever"] }]));
}

#[test]
fn mergecodex_marks_retired_mounts_era_vendor_stock_no_collection_or_curated_guide_lists_and_source_less_items() {
	let mut s = synthetic();
	s.forever["items"]["12302"] = json!({ "id": 12302, "name": "Reins of the Frostsaber", "drops": { "npc": {}, "object": {} }, "vendors": [4730], "source": ["pfquest", "questie-forever"] });
	s.forever["items"]["269681"] = json!({ "id": 269681, "name": "Empyrean Galestrider", "drops": { "npc": {}, "object": {} }, "vendors": [4730], "source": ["questie-forever"] });
	for (id, name) in [(12302, "Reins of the Frostsaber"), (269681, "Empyrean Galestrider")] {
		let item = like(&s.client.items[&8631], name);
		s.client.items.insert(id, item);
	}
	s.curated = vec![8631.0];
	let codex = merged(s);
	let it = &codex["items"];
	assert_eq!(it["12302"]["kind"], "mount");
	assert_eq!(it["12302"]["status"], "retired", "only Era vendor rows, in no collection list and no curated guide");
	assert!(it["8631"]["status"].is_null(), "a curated guide collects it");
	assert!(it["13335"]["status"].is_null(), "listed by AtlasLoot and dropped");
	assert!(it["269681"]["status"].is_null(), "Forever-only vendor rows are trusted");
	assert_eq!(it["17"]["status"], "nosource");
	assert!(it["2933"]["status"].is_null(), "not a collectible: never retired");
}

#[test]
fn item_status_round_trips_through_the_pack_and_reaches_codex_each() {
	let mut codex = sample_codex();
	let mut ids: Vec<String> = codex["items"].as_object().unwrap().iter().filter(|(_, r)| r["kind"] == "mount").map(|(id, _)| id.clone()).collect();
	ids.sort_by_key(|id| id.parse::<i64>().unwrap());
	ids.truncate(2);
	codex["items"][ids[0].as_str()]["status"] = json!("retired");
	codex["items"][ids[1].as_str()]["status"] = json!("nosource");
	let pack = write_codex_pack(&codex, &CodexOpts::default());
	let script = r#"
local C = Polestar.Codex
emit({ C.Item(ID0).status, C.Item(ID1).status, C.Item(ID0).quality })
local out = {}
C.Each("mount", function(id, name, quality, status) out[tostring(id)] = (status or "-") .. "/" .. tostring(quality) end)
emit(out)
"#
	.replace("ID0", &ids[0])
	.replace("ID1", &ids[1]);
	let out = run(&script, "", Some(&pack));
	let (recs, each) = (&out[0], &out[1]);
	let q0 = &codex["items"][ids[0].as_str()]["quality"];
	let q1 = &codex["items"][ids[1].as_str()]["quality"];
	assert_eq!(*recs, json!(["retired", "nosource", q0]));
	assert_eq!(each[ids[0].as_str()], format!("retired/{q0}").as_str());
	assert_eq!(each[ids[1].as_str()], format!("nosource/{q1}").as_str());
	assert!(each.as_object().unwrap().iter().filter(|(id, _)| !ids.contains(id)).all(|(_, v)| v.as_str().unwrap().starts_with("-/")));
}

#[test]
fn mergecodex_builds_npcs_rares_instances_quests_spells_and_frames() {
	let codex = merged(synthetic());
	let n = &codex["npcs"];
	assert!(n["1"].is_null(), "GM npcs are dropped");
	assert!(n["99"].is_null(), "unreferenced npcs without spawns or roles are dropped");
	assert!(n["777777"].is_null(), "RareScanner rows outside Forever zones are dropped");
	assert_eq!(n["61"]["rare"], true);
	assert_eq!(n["61"]["loot"], json!([2933]), "RareScanner loot, items the Codex knows");
	assert_eq!(n["4730"]["loot"], json!([]), "only rares carry loot");
	assert_eq!(n["61"]["spawns"], json!([{ "map": 1429, "x": 89.5, "y": 79.4, "f": null }, { "map": 1429, "x": 69.6, "y": 79.4, "f": null }]));
	assert_eq!(n["4730"]["spawns"], json!([{ "map": 1438, "x": 25.2, "y": 50.1, "f": "e" }, { "map": 1438, "x": 25.3, "y": 50.2, "f": "e" }, { "map": 1438, "x": 70, "y": 70, "f": "e" }]));
	assert_eq!(n["198"]["spawns"], json!([{ "map": 1429, "x": 49.7, "y": 39.6, "f": null }]), "live-frame spawns carry f = null");
	assert_eq!(n["5164"]["roles"], json!(["trainer", "trainer:164"]));
	assert_eq!(n["198"]["roles"], json!(["class:MAGE", "trainer"]));
	assert_eq!(n["10440"]["boss"], true);
	assert_eq!(n["10440"]["instance"], "stratholme");
	let s = &codex["instances"]["stratholme"];
	assert_eq!(s["entrance"], json!({ "map": 1423, "x": 27.4, "y": 11.6, "f": null }));
	assert_eq!(s["bosses"], json!([{ "name": "Baron Rivendare", "npc": 10440, "items": [13335] }]));
	assert_eq!(s["areaId"], 2017);
	let q = &codex["quests"]["176"];
	assert_eq!(q["pre"], json!([33]));
	assert_eq!(q["preAny"], json!([7, 783]));
	assert_eq!(q["faction"], "A");
	assert_eq!(q["choices"], json!([1933, 2933]));
	assert_eq!(
		q["objectives"],
		json!([
			{ "type": "item", "id": 1931, "count": null, "text": "Huge Gnoll Claw" },
			{ "type": "event", "id": 87, "count": null, "text": "Scout the camp", "map": 1429, "x": 32, "y": 62 },
		]),
		"an event keeps its place (#515), other objectives are placed by their spawns"
	);
	assert_eq!(
		codex["quests"]["9002"]["objectives"],
		json!([{ "type": "event", "id": null, "count": null, "text": "Escort Miran to the excavation site" }]),
		"an escort's place is where the walk ends: none, so the arrow stays at its start"
	);
	assert_eq!(
		codex["quests"]["6063"]["objectives"],
		json!([{ "type": "kill", "id": 1998, "count": 1, "text": "Webwood Lurker", "tame": true }]),
		"a beast tamed with the Taming Rod is marked to tame, not kill (#565)"
	);
	assert!(!codex["quests"]["176"]["objectives"].as_array().unwrap().iter().any(|o| truthy(&o["tame"])), "other objectives are not");
	assert_eq!(codex["quests"]["5212"]["title"], "The Medallion of Faith");
	assert_eq!(codex["spells"]["8394"], json!({ "kind": "mount", "item": 8631, "name": "Striped Frostsaber", "class": null }));
	assert_eq!(codex["spells"]["13819"], json!({ "kind": "mount", "item": null, "name": "Summon Warhorse", "class": "PALADIN" }));
	assert_eq!(codex["spells"]["5784"], json!({ "kind": "mount", "item": null, "name": "Summon Felsteed", "class": "WARLOCK" }));
	assert_eq!(codex["objects"].as_object().unwrap().keys().collect::<Vec<_>>(), vec!["2843"]);
	assert_eq!(codex["objects"]["2843"]["treasure"], true);
	assert_eq!(codex["objects"]["2843"]["loot"], json!([1179, 2933]), "known chance first; unknown items (424242) dropped");
	let mut frames: Vec<&String> = codex["frames"].as_object().unwrap().keys().collect();
	frames.sort();
	assert_eq!(frames, vec!["1429", "1438", "1457", "1458", "1460"]);
}

#[test]
fn cluster_merges_nearby_points_biggest_first() {
	// forge_data::codex keeps cluster() private; its effect is asserted on a merged NPC's spawns: the points
	// [[10, 10], [11, 10], [50, 50], [10.5, 11]] cluster to { x: 10.5, y: 10.3, n: 3 } then { x: 50, y: 50, n: 1 }.
	let mut s = synthetic();
	s.forever["npcs"]["4788"] = json!({ "id": 4788, "name": "Clustered Mob", "level": 23, "faction": null, "spawns": { "1438": { "f": "e", "pts": [[10, 10], [11, 10], [50, 50], [10.5, 11]] } } });
	let codex = merged(s);
	assert_eq!(codex["npcs"]["4788"]["spawns"], json!([{ "map": 1438, "x": 10.5, "y": 10.3, "f": "e" }, { "map": 1438, "x": 50, "y": 50, "f": "e" }]));
}

#[test]
fn buildcodex_writes_deterministic_json_and_a_pack_whose_memory_it_measures() {
	let build_n = |n: u32| {
		let mut o = Options::new(root());
		o.version = Some("1.0.0".into());
		o.measure = n == 1;
		build_inputs(&o, &inputs(synthetic())).unwrap_or_else(|e| panic!("{e}"))
	};
	let a = build_n(1);
	let b = build_n(2);
	let mut files: Vec<&str> = a.json.iter().map(|(f, _)| f.as_str()).collect();
	files.sort();
	assert_eq!(files, vec!["factions.json", "frames.json", "instances.json", "items.json", "journal.json", "meta.json", "npcs.json", "objects.json", "quests.json", "spells.json", "zones.json"]);
	for (f, text) in a.json.iter().filter(|(f, _)| f != "meta.json") {
		let other = &b.json.iter().find(|(g, _)| g == f).unwrap_or_else(|| panic!("no {f}")).1;
		assert_eq!(text, other, "{f}");
	}
	for (f, text) in &a.pack {
		let other = &b.pack.iter().find(|(g, _)| g == f).unwrap_or_else(|| panic!("no {f}")).1;
		assert_eq!(text, other, "{f}");
	}
	let meta = plain(&a.meta);
	assert_eq!(meta["counts"]["mount"], 3);
	assert_eq!(meta["counts"]["rare"], 1);
	assert_eq!(meta["counts"]["instance"], 1);
	let share = meta["coverage"]["share"].as_f64().unwrap();
	assert!(share > 0.0 && share < 1.0);
	assert!(meta["pack"]["bytes"].as_f64().unwrap() > 0.0);
	let (kb, decoded) = (meta["pack"]["memoryKB"].as_f64().unwrap_or(0.0), meta["pack"]["memoryKBDecoded"].as_f64().unwrap_or(0.0));
	assert!(kb > 0.0 && decoded > kb, "{}", meta["pack"]);
	assert!(meta["sources"].as_array().unwrap().iter().any(|s| s["name"] == "AtlasLootClassic" && s["licence"] == "GPL-2.0"), "{}", meta["sources"]);
	assert_eq!(meta["localExtras"], true, "AtlasLoot, RareScanner and dungeons.json make a local build");
	let toc = &a.pack.iter().find(|(f, _)| f == "Polestar_Codex.toc").unwrap().1;
	assert!(is_match(toc, r"(?m)^Meta\.lua$"));
	let licence = &a.pack.iter().find(|(f, _)| f == "LICENSE-DATA.txt").unwrap().1;
	assert!(licence.contains("LOCAL BUILD (--local-extras)"), "{licence}");
}

#[test]
fn curatedrepgates_a_collectible_guide_reaching_a_standing_before_it_buys_the_item_gates_that_vendor() {
	let tmp = TempDir::new("polestar-codex-gates-");
	let dir = tmp.path();
	std::fs::write(
		dir.join("saber.guide"),
		[
			"guide x/saber",
			"collects 13086",
			"",
			"step Rep",
			"  rep \"Wintersaber Trainers\" Exalted",
			"  talk 10618",
			"step Buy",
			"  buy 13086 npc 10618                 -- Rivern Frostwind",
			"  buy 99 npc 10618",
		]
		.join("\n"),
	)
	.unwrap();
	std::fs::write(dir.join("plain.guide"), ["guide x/plain", "step A", "  rep 589 Honored", "  buy 5 npc 1"].join("\n")).unwrap();
	assert_eq!(plain(&curated_rep_gates_in(dir)), json!({ "13086": [{ "npc": 10618, "faction": null, "factionName": "Wintersaber Trainers", "standing": 8 }] }));
}

#[test]
fn mergecodex_a_guard_recorded_on_a_city_map_and_on_the_zone_that_holds_it_is_placed_in_the_city_382() {
	let codex = merged(synthetic());
	// The city map comes first, so everything reading spawns[0] (a dungeon page's start and finish, an
	// attunement step, the zone the Codex names) says Darnassus, not Teldrassil. Naming the zone sends the route
	// planner out of the city and back in for someone already standing there.
	assert_eq!(maps(&codex["npcs"]["4784"]["spawns"]), vec![json!(1457), json!(1438)]);
	// Two different places keep their order: an NPC really seen in two zones is not one standing in a city.
	assert_eq!(maps(&codex["npcs"]["4785"]["spawns"]), vec![json!(1438), json!(1457)]);
	// Nor does a smaller frame win on its own: neighbouring zones overlap, and a mob on the border is in the
	// zone it is mostly seen in, as before.
	assert_eq!(maps(&codex["npcs"]["4786"]["spawns"]), vec![json!(1438), json!(1460)]);
	// A capital the zone's frame overlaps without holding wins all the same: the Undercity is recorded with
	// Silverpine Forest, which does not hold it.
	assert_eq!(maps(&codex["npcs"]["4787"]["spawns"]), vec![json!(1458), json!(1438)]);
}

#[test]
fn codex_services_retain_exact_spawns_trainer_titles_and_mailbox_factions_through_the_pack() {
	let mut s = synthetic();
	let points: Vec<Value> = (0..28).map(|i| json!([10 + i, 50])).collect();
	s.forever["npcs"]["4730"]["spawns"]["1438"] = json!({ "f": "e", "pts": points[..24], "more": points[24..] });
	s.forever["npcs"]["198"]["subName"] = json!("Mage Trainer");
	s.forever["npcs"]["77777"] = json!({ "id": 77777, "name": "Town Crier", "subName": "Herald", "level": 30, "faction": "A", "spawns": { "1438": { "f": "e", "pts": [[40, 40]] } } });
	s.forever["objects"]["99999"] =
		json!({ "id": 99999, "name": "Mailbox", "roles": ["mailbox"], "faction": "H", "spawns": { "1438": { "f": "e", "pts": [[25.2, 50.1], [25.3, 50.2]], "more": [[70, 70]] } } });
	let codex = merged(s);
	assert_eq!(codex["npcs"]["4730"]["spawns"].as_array().unwrap().len(), 28, "service points are not capped or averaged");
	assert_eq!(codex["npcs"]["198"]["subName"], "Mage Trainer");
	assert!(codex["npcs"]["198"]["roles"].as_array().unwrap().contains(&json!("class:MAGE")));
	assert!(truthy(&codex["npcs"]["77777"]), "the NPC without services is in the Codex");
	assert!(codex["npcs"]["77777"]["subName"].is_null(), "titles ride only on service NPCs");
	assert_eq!(codex["objects"]["99999"]["spawns"].as_array().unwrap().len(), 3, "unreferenced mailboxes retain every physical point");
	let pack = write_codex_pack(&codex, &CodexOpts::default());
	let out = run("local C=Polestar.Codex; C.Load(); emit({npc=C.Npc(198),box=C.Object(99999),points=#C.Npc(4730).spawns})", "", Some(&pack));
	let out = &out[0];
	assert_eq!(out["npc"]["subName"], "Mage Trainer");
	assert_eq!(out["points"], 28);
	assert_eq!(out["box"]["mailbox"], true);
	assert_eq!(out["box"]["faction"], "H");
	assert_eq!(out["box"]["spawns"].as_array().unwrap().len(), 3);
}

#[test]
fn codex_optional_service_tails_escape_punctuation_and_work_without_any_spawns() {
	let mut codex = sample_codex();
	codex["npcs"]["88888"] = json!({ "id": 88888, "name": "Trainer", "subName": "Mage, Trainer; 100%~", "faction": "A", "roles": ["trainer"], "spawns": [], "loot": [] });
	codex["objects"]["88888"] = json!({ "id": 88888, "name": "Mailbox", "mailbox": true, "faction": null, "spawns": [], "loot": [] });
	let pack = write_codex_pack(&codex, &CodexOpts::default());
	let out = run("local C=Polestar.Codex; C.Load(); emit({npc=C.Npc(88888),box=C.Object(88888)})", "", Some(&pack));
	let out = &out[0];
	assert_eq!(out["npc"]["subName"], "Mage, Trainer; 100%~");
	assert_eq!(len(&out["npc"]["spawns"]), 0);
	assert_eq!(out["box"]["mailbox"], true);
	assert!(out["box"]["faction"].is_null());
	assert_eq!(len(&out["box"]["spawns"]), 0);
}

#[test]
fn codex_services_keep_precise_fallback_positions_when_the_reference_data_has_no_spawns() {
	let mut s = synthetic();
	s.atlasloot = None;
	s.forever["npcs"]["4730"]["spawns"] = json!({});
	s.web = Some(json!({ "npc": { "4730": { "spawns": { "1438": [[25.2, 50.1], [25.3, 50.2]] }, "drops": [] } }, "object": {}, "item": {}, "spell": {} }));
	let codex = merged(s);
	assert_eq!(codex["npcs"]["4730"]["spawns"], json!([{ "map": 1438, "x": 25.2, "y": 50.1, "f": null }, { "map": 1438, "x": 25.3, "y": 50.2, "f": null }]));
}

#[test]
fn mergecodex_an_npc_casting_a_spell_that_creates_the_item_hands_it_out_gift() {
	let mut s = synthetic();
	s.atlasloot = None;
	s.client.creates.clear();
	s.client.creates.insert(20001, vec![21357]);
	s.web = Some(json!({ "npc": {}, "object": {}, "item": {}, "spell": { "21357": { "id": 21357, "usedBy": [4730, 424242] } } }));
	let codex = merged(s);
	assert_eq!(codex["items"]["20001"]["sources"], json!([{ "type": "gift", "npc": 4730, "spell": 21357, "from": ["web"] }]), "an NPC the data does not know is left out");
}

#[test]
fn mergecodex_a_forever_list_row_gives_the_level_of_an_npc_nothing_else_does_only_the_level() {
	let mut s = synthetic();
	s.atlasloot = None;
	s.forever["npcs"]["7747"]["level"] = Value::Null;
	let row = |id: i64, level: [i64; 2]| json!({ "id": id, "name": "x", "location": [1], "level": level, "classification": "rare", "boss": true, "change": { "status": "new", "lines": [] } });
	s.web = Some(json!({ "npc": {}, "object": {}, "item": {}, "spell": {}, "listed": { "npc": { "7747": row(7747, [9, 10]), "4730": row(4730, [50, 50]) } } }));
	let codex = merged(s);
	let npcs = &codex["npcs"];
	assert_eq!(json!([npcs["7747"]["level"], npcs["7747"]["levelMax"], npcs["7747"]["rare"], npcs["7747"]["boss"]]), json!([9, 10, false, false]));
	assert_eq!(npcs["4730"]["level"], 35, "the data's level stays");
}
