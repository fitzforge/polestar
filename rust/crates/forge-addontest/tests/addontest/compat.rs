//! Compat (addon/Polestar/Core/Compat.lua): map frames and world coordinates, quest objective normalization, NPC
//! IDs, player info, against the stub world.

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, Addon, RunAddon};
use regex::Regex;
use serde_json::{json, Value};
use std::path::Path;

const BASE: &str = r#"w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.addMap(1411, { name = "Durotar", c = 1, left = 0, right = -3000, top = 0, bottom = -3000 })
"#;

fn run_with(script: &str, before: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{BASE}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("C = Polestar.Compat\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn run(script: &str) -> Value {
	run_with(script, "")
}

/// Numbers rounded to 3 decimals (JS Math.round), integral ones as integers.
fn round(list: &Value) -> Value {
	Value::Array(
		list.as_array()
			.unwrap()
			.iter()
			.map(|v| match v.as_f64() {
				Some(f) => {
					let r = (f * 1000.0 + 0.5).floor() / 1000.0;
					if r.fract() == 0.0 {
						json!(r as i64)
					} else {
						json!(r)
					}
				}
				None => v.clone(),
			})
			.collect(),
	)
}

#[test]
fn maptoworld_uses_registered_era_bounds_for_frame_e_and_the_live_client_otherwise() {
	let out = run(r#"
		Polestar.RegisterMapFrames({ era = { [1429] = { c = 0, left = 1600, right = -1400, top = 600, bottom = -1400 } } })
		emit({ { C.MapToWorld(1429, 50, 50, "e") }, { C.MapToWorld(1429, 50, 50) }, { C.MapToWorld(9998, 50, 50, "e") },
			{ C.MapToWorld(9999, 50, 50) } })
	"#);
	assert_eq!(round(&out[0]), json!([0, -400, 100]));
	assert_eq!(round(&out[1]), json!([0, -500, 0]));
	assert_eq!(out[2], json!({})); // no Era bounds registered for that map: nothing returned (Lua encodes an empty list as {})
	assert_eq!(out[3], json!({}));
}

#[test]
fn an_era_point_converts_back_to_the_live_map_percent_with_worldtomap_with_or_without_getmapposfromworldpos() {
	let script = r#"
		Polestar.RegisterMapFrames({ era = { [1429] = { c = 0, left = 1600, right = -1400, top = 600, bottom = -1400 } } })
		local c, wx, wy = C.MapToWorld(1429, 50, 50, "e")
		emit({ { C.WorldToMap(c, wx, wy, 1429) }, { C.WorldToMap(1, wx, wy, 1429) } })
	"#;
	let with_api = run(script);
	let fallback = run_with(script, "C_Map.GetMapPosFromWorldPos = nil");
	for out in [with_api, fallback] {
		assert_eq!(round(&out[0]), json!([46.667, 45]));
		assert_eq!(out[1], json!({}));
	}
}

#[test]
fn player_positions_map_percent_world_position_nil_in_instances() {
	let out = run(r#"
		w.moveTo(1429, 25, 75)
		local a = { C.GetPlayerMapPosition() }
		local b = { C.GetPlayerWorldPosition() }
		w.inInstance = true
		emit({ a, b, { C.GetPlayerMapPosition() }, { C.GetPlayerWorldPosition() }, C.IsInInstance(), C.GetPlayerFacing() == nil })
	"#);
	assert_eq!(round(&out[0]), json!([1429, 25, 75]));
	assert_eq!(round(&out[1]), json!([0, -1000, 750]));
	assert_eq!(out[2], json!({}));
	assert_eq!(out[3], json!({}));
	assert_eq!(out[4], true);
	assert_eq!(out[5], true);
}

#[test]
fn isininstance_names_the_instance_type_inside_party_for_a_dungeon_and_nothing_outside() {
	let out = run(r#"
		local outside = { C.IsInInstance() }
		w.inInstance = true
		emit({ outside = outside, inside = { C.IsInInstance() } })
	"#);
	assert_eq!(out, json!({ "outside": [false], "inside": [true, "party"] }));
}

#[test]
fn quest_objectives_normalize_to_text_type_finished_numfulfilled_numrequired() {
	let out = run(r#"
		C_QuestLog.GetQuestObjectives = function(q)
			if q == 1 then
				return {
					{ text = "Kobold Vermin slain: 3/10", type = "monster", finished = false, numFulfilled = 3, numRequired = 10, objectiveType = 0 },
					{ text = "Explore the mine", type = "event", finished = true, numFulfilled = 0, numRequired = 0 },
				}
			end
			return {}
		end
		C_QuestLog.IsOnQuest = function(q) return q == 1 end
		C_QuestLog.ReadyForTurnIn = function() return nil end
		C_QuestLog.IsComplete = function() return false end
		emit({ objs = C.GetQuestObjectives(1), none = C.GetQuestObjectives(2) == nil, ready = C.IsQuestReadyForTurnIn(1) })
	"#);
	assert_eq!(
		out,
		json!({
			"objs": [
				{ "text": "Kobold Vermin slain: 3/10", "type": "monster", "finished": false, "numFulfilled": 3, "numRequired": 10 },
				{ "text": "Explore the mine", "type": "event", "finished": true, "numFulfilled": 1, "numRequired": 1 },
			],
			"none": true,
			"ready": false,
		})
	);
}

#[test]
fn getnpcid_parses_creature_and_object_guids_and_ignores_players() {
	let out = run(r#"
		w.units.npc = "Creature-0-4372-0-17-197-00001A2B3C"
		w.units.target = "GameObject-0-4372-0-17-1617-00001A2B3C"
		w.units.focus = "Player-1-0000ABCD"
		emit({ C.GetNpcID("npc"), C.GetNpcID("target"), C.GetNpcID("focus") or false, C.GetNpcID("mouseover") or false })
	"#);
	assert_eq!(out, json!([197, 1617, false, false]));
}

#[test]
fn player_info_zone_text_bind_location_taxi_and_items_come_from_the_client() {
	let out = run(r#"
		w.race, w.class, w.faction, w.level = "Scourge", "WARLOCK", "Horde", 7
		w.zone, w.subzone = "Tirisfal Glades", ""
		w.bindLocation = ""
		w.items[159] = 4
		w.taxiNodes = { { name = "Undercity, Tirisfal", type = "REACHABLE" }, { name = "The Sepulcher, Silverpine Forest", type = "CURRENT" } }
		local info = C.GetPlayerInfo()
		emit({ race = info.race, class = info.class, faction = info.faction, level = info.level, name = info.name,
			zone = { C.GetZoneText() }, bind = C.GetBindLocation() == nil, items = C.GetItemCount(159), none = C.GetItemCount(1),
			node = C.GetCurrentTaxiNode(), taxi = C.IsOnTaxi() })
	"#);
	assert_eq!(
		out,
		json!({
			"race": "Scourge",
			"class": "WARLOCK",
			"faction": "Horde",
			"level": 7,
			"name": "Testchar",
			"zone": ["Tirisfal Glades"],
			"bind": true,
			"items": 4,
			"none": 0,
			"node": "The Sepulcher, Silverpine Forest",
			"taxi": false,
		})
	);
}

#[test]
fn getareaname_gives_an_area_s_name_in_the_client_s_language_from_c_map_getareainfo_nil_for_no_id_an_unknown_area_or_no_api() {
	let out = run(r#"
		local names = { [42] = "Sombre-Comté" }
		C_Map.GetAreaInfo = function(id) return names[id] end
		local r = { C.GetAreaName(42), C.GetAreaName(43) == nil, C.GetAreaName(nil) == nil, C.GetAreaName("42") == nil }
		C_Map.GetAreaInfo = function() error("no such area") end
		r[5] = C.GetAreaName(42) == nil
		C_Map.GetAreaInfo = nil
		r[6] = C.GetAreaName(42) == nil
		emit(r)
	"#);
	assert_eq!(out, json!(["Sombre-Comté", true, true, true, true, true]));
}

#[test]
fn skill_ranks_by_line_or_name_from_c_skillinfo_or_the_profession_list_unlearned_is_nil() {
	let out = run(r#"
		w.learnSkill(171, "Alchemy", 42, 75)
		w.learnSkill(129, "First Aid", 10, 75)
		local a = { { C.GetSkillRank(171) }, { C.GetSkillRank("alchemy") }, { C.GetSkillRank("First Aid") }, { C.GetSkillRank(186) },
			{ C.GetSkillRank("Mining") } }
		-- A client with only the older profession API.
		C_SkillInfo = nil
		GetProfessions = function() return 3, nil, 1 end
		GetProfessionInfo = function(i)
			if i == 3 then return "Herbalism", 0, 30, 75, 2, 0, 182 end
			if i == 1 then return "First Aid", 0, 10, 75, 1, 0, 129 end
		end
		emit({ a = a, herb = { C.GetSkillRank("Herbalism") }, herbID = { C.GetSkillRank(182) }, aid = { C.GetSkillRank(129) },
			supported = C.Supports("skill") })
	"#);
	assert_eq!(out["a"], json!([[42, 75], [42, 75], [10, 75], {}, {}]));
	assert_eq!(out["herb"], json!([30, 75]));
	assert_eq!(out["herbID"], json!([30, 75]));
	assert_eq!(out["aid"], json!([10, 75]));
	assert_eq!(out["supported"], true);
}

#[test]
fn spells_count_as_known_from_the_spellbook_or_as_learned_recipes() {
	let out = run(r#"
		w.learnSpell(2580)
		w.recipes[2330] = true
		w.recipes[2333] = false
		emit({ C.IsSpellKnown(2580), C.IsSpellKnown(2330), C.IsSpellKnown(2333), C.IsSpellKnown(1) })
	"#);
	assert_eq!(out, json!([true, true, false, false]));
}

#[test]
fn item_and_spell_links_come_from_the_cache_an_uncached_item_or_spell_is_requested() {
	let out = run(r#"
		local cached, asked = { [20536] = true }, {}
		C_Item = {
			IsItemDataCachedByID = function(id) return cached[id] == true end,
			RequestLoadItemDataByID = function(id) asked[#asked + 1] = "item " .. id end,
			GetItemInfo = function(id) if cached[id] then return "Soul Harvester", "|Hitem:" .. id .. "|h[Soul Harvester]|h" end end,
		}
		C_Spell = {
			IsSpellDataCached = function(id) return id == 23161 end,
			RequestLoadSpellData = function(id) asked[#asked + 1] = "spell " .. id end,
			GetSpellLink = function(id) return "|Hspell:" .. id .. "|h[Summon Felhunter]|h" end,
		}
		emit({ C.ItemLink(20536), C.ItemLink(20534) == nil, C.RequestItem(20536), C.RequestItem(20534),
			C.SpellLink(691), C.RequestSpell(23161), C.RequestSpell(691), asked })
	"#);
	assert_eq!(out, json!(["|Hitem:20536|h[Soul Harvester]|h", true, true, false, "|Hspell:691|h[Summon Felhunter]|h", true, false, ["item 20534", "spell 691"]]));
}

#[test]
fn faction_standing_area_exploration_and_achievements_read_the_client() {
	let out = run(r#"
		w.setRep(72, "Stormwind", 6, 4500, 3000, 9000)
		w.addArea(1429, 40, 60, 50, 70, 87)
		w.explore(87)
		w.addAchievement(9001, "Legacy: Northshire", { { "Kill wolves", 10 }, { "Explore", 0 } })
		w.criteria(9001, 1, 4)
		w.achievements[9001].criteria[2].completed = true -- event criterion: 0/0, completed
		emit({ rep = { C.GetFactionStanding(72) }, unknown = { C.GetFactionStanding(1) },
			inside = C.IsAreaExploredAt(1429, 42, 64), outside = C.IsAreaExploredAt(1429, 20, 20),
			ach = C.GetAchievement(9001), none = C.GetAchievement(1) == nil })
	"#);
	assert_eq!(out["rep"], json!([6, 4500, 3000, 9000, "Stormwind"]));
	assert_eq!(out["unknown"], json!({}));
	assert_eq!(out["inside"], true);
	assert_eq!(out["outside"], false);
	assert_eq!(
		out["ach"],
		json!({
			"completed": false,
			"name": "Legacy: Northshire",
			"criteria": [
				{ "text": "Kill wolves", "completed": false, "cur": 4, "max": 10 },
				{ "text": "Explore", "completed": true, "cur": 1, "max": 1 },
			],
		})
	);
	assert_eq!(out["none"], true);
}

#[test]
fn without_the_client_apis_the_new_functions_return_nil_and_supports_says_so() {
	let out = run(r#"
		for _, f in ipairs({ "skill", "spell", "faction", "explore", "achievement" }) do w.unsupport(f) end
		emit({ skill = C.GetSkillRank("Alchemy") == nil, spell = C.IsSpellKnown(2580), rep = C.GetFactionStanding(72) == nil,
			area = C.IsAreaExploredAt(1429, 50, 50) == nil, ach = C.GetAchievement(9001) == nil,
			supports = { C.Supports("skill"), C.Supports("spell"), C.Supports("faction"), C.Supports("explore"), C.Supports("achievement") } })
	"#);
	assert_eq!(out, json!({ "skill": true, "spell": false, "rep": true, "area": true, "ach": true, "supports": [false, false, false, false, false] }));
}

#[test]
fn secret_unit_values_read_as_unknown_instead_of_throwing() {
	let out = run(r#"
		-- Secret values throw when compared or parsed, as in the client.
		local SECRET = setmetatable({}, { __eq = function() error("secret compared") end,
			__index = function() error("secret indexed") end, __tostring = function() return "secret" end })
		function issecretvalue(v) return rawequal(v, SECRET) or (type(v) == "string" and v:find("^Secret") ~= nil) end
		w.units.npc = "Secret-Creature-0-4372-0-17-197-0001"
		w.units.target = "Creature-0-4372-0-17-197-00001A2B3C"
		w.faction = SECRET
		local info = C.GetPlayerInfo()
		emit({ npc = C.GetNpcID("npc") or false, target = C.GetNpcID("target"), faction = info.faction, race = info.race })
	"#);
	assert_eq!(out, json!({ "npc": false, "target": 197, "faction": "Neutral", "race": "Human" }));
}

#[test]
fn c3_nav_qa_the_world_map_opens_through_c_map_openworldmap_when_the_client_has_it_the_global_opener_only_as_a_fallback_never_in_combat() {
	let out = run(r#"
		local calls = {}
		OpenWorldMap = function(map) calls[#calls + 1] = "global " .. tostring(map) end
		C_Map.OpenWorldMap = function(map) calls[#calls + 1] = "C_Map " .. tostring(map) end
		local both = { C.CanOpenWorldMap(), C.OpenWorldMap(1429) }
		stub.inCombat = true
		local combat = C.OpenWorldMap(1429)
		stub.inCombat = false
		C_Map.OpenWorldMap = nil
		local fallback = C.OpenWorldMap(1411)
		OpenWorldMap = nil
		local none = { C.CanOpenWorldMap(), C.OpenWorldMap(1411) }
		C_Map.OpenWorldMap = function() error("blocked") end
		local failed = C.OpenWorldMap(1429)
		emit({ both = both, combat = combat, fallback = fallback, none = none, failed = failed, calls = table.concat(calls, ";") })
	"#);
	assert_eq!(out["both"], json!([true, true]));
	assert_eq!(out["combat"], false, "nothing opens in combat");
	assert_eq!(out["fallback"], true);
	assert_eq!(out["none"], json!([false, false]));
	assert_eq!(out["failed"], false, "an opener that errors is reported, not thrown");
	assert_eq!(out["calls"], "C_Map 1429;global 1411", "C_Map first; the global only without it");
}

fn walk(dir: &Path, root: &Path, bare: &[Regex], comment: &Regex, found: &mut Vec<String>) {
	for e in std::fs::read_dir(dir).unwrap() {
		let e = e.unwrap();
		let p = e.path();
		if e.file_type().unwrap().is_dir() {
			walk(&p, root, bare, comment, found);
		} else {
			let rel = p.strip_prefix(root).unwrap();
			if p.extension().is_some_and(|x| x == "lua") && rel != Path::new("Polestar/Core/Compat.lua") {
				let text = std::fs::read_to_string(&p).unwrap();
				for (i, line) in text.split('\n').enumerate() {
					let code = comment.replace(line, "");
					if bare.iter().any(|re| re.is_match(&code)) {
						found.push(format!("{}:{}", rel.display(), i + 1));
					}
				}
			}
		}
	}
}

#[test]
fn c3_nav_qa_no_addon_code_outside_core_compat_lua_opens_or_moves_the_world_map_itself_openworldmap_toggleworldmap_showuipanel_worldmapframe_worldmapframe_setmapid() {
	let bare: Vec<Regex> =
		[r"(^|[^.:\w])OpenWorldMap\b", r"(^|[^.:\w])ToggleWorldMap\s*\(", r"ShowUIPanel\s*\(\s*WorldMapFrame\b", r"WorldMapFrame\s*:\s*SetMapID\s*\("].iter().map(|p| Regex::new(p).unwrap()).collect();
	let comment = Regex::new(r"--.*$").unwrap();
	let root = addons_dir();
	let mut found = Vec::new();
	walk(&root, &root, &bare, &comment, &mut found);
	assert_eq!(found, Vec::<String>::new());
}

#[test]
fn isindoors_the_client_s_indoor_state_nil_without_isindoors_or_when_it_errors() {
	let out = run(r#"
		local r = {}
		IsIndoors = function() return 1 end
		r.inside = C.IsIndoors()
		IsIndoors = function() return nil end
		r.outside = C.IsIndoors()
		IsIndoors = function() error("no") end
		r.err = C.IsIndoors() == nil
		IsIndoors = nil
		r.none = C.IsIndoors() == nil
		emit(r)
	"#);
	assert_eq!(out, json!({ "inside": true, "outside": false, "err": true, "none": true }));
}
