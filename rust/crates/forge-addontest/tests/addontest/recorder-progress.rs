//! The recorder's progress capture (addon/Polestar_Recorder/Progress.lua and the /psrec legacy|factions|skills
//! dumps) plus quest givers that are game objects or items, against tests/lua/stub_recorder.lua.

use forge_addontest::{emitted, RunAddon};
use serde_json::{json, Value};

const REC: &str = "Polestar_Recorder";

const PRELUDE: &str = r#"
local function S() return PolestarRecorderDB.sessions[PolestarRecorderDB.current] end
local function events(kind)
	local out = {}
	for _, e in ipairs(S().events) do
		if kind == nil or e.e == kind then
			local c = {}
			for k, v in pairs(e) do if k ~= "t" then c[k] = v end end
			out[#out + 1] = c
		end
	end
	return out
end
local cmd = SlashCmdList.POLESTARREC
"#;

fn run(script: &str, before: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_recorder.lua"], addons: vec![REC.into()], login: true, before: before.into(), script: format!("{PRELUDE}{script}"), ..Default::default() }).remove(0)
}

// Reputation list: Alliance (collapsed) > Stormwind, Ironforge; Classic > Steamwheedle (sub-header with rep,
// collapsed) > Booty Bay; a legacy header hidden unless legacy reputations are shown.
const FACTIONS: &str = r#"
	stub.faction({ id = 469, name = "Alliance", header = true, collapsed = true })
	stub.faction({ id = 72, name = "Stormwind", depth = 1, child = true, reaction = 5, value = 3100, min = 3000, max = 9000 })
	stub.faction({ id = 47, name = "Ironforge", depth = 1, child = true, reaction = 4, value = 0, min = 0, max = 3000, canToggle = true })
	stub.faction({ id = 1118, name = "Classic", header = true })
	stub.faction({ id = 169, name = "Steamwheedle Cartel", depth = 1, header = true, child = true, headerRep = true, collapsed = true, reaction = 4, value = 500, min = 0, max = 3000 })
	stub.faction({ id = 21, name = "Booty Bay", depth = 2, child = true, reaction = 4, value = 500, min = 0, max = 3000 })
	stub.faction({ id = 1169, name = "Guild", header = true, legacy = true })
	stub.faction({ id = 1168, name = "Guild Rep", depth = 1, child = true, legacy = true, reaction = 4, value = 10, max = 3000 })
"#;

const SKILLS: &str = r#"
	stub.skill({ name = "Professions", header = true, collapsed = true })
	stub.skill({ id = 186, name = "Mining", rank = 40, max = 75, category = 11 })
	stub.skill({ id = 182, name = "Herbalism", rank = 1, max = 75, category = 11 })
	stub.skill({ name = "Weapon Skills", header = true })
	stub.skill({ id = 43, name = "Swords", rank = 20, max = 25, category = 6 })
"#;

#[test]
fn psrec_factions_every_faction_with_hierarchy_standing_and_bounds_collapsed_headers_and_legacy_visibility_restored() {
	let out = run(
		r#"
		cmd("factions")
		emit({ f = S().factions, collapsed = stub.collapsedFactions(), legacyShown = stub.world.showLegacyRep, dumped = type(S().dumped.factions) })"#,
		FACTIONS,
	);

	assert_eq!(out["collapsed"], json!(["Alliance", "Steamwheedle Cartel"]));
	assert_eq!(out["legacyShown"], false);
	assert_eq!(out["dumped"], "number");
	assert_eq!(out["f"]["469"], json!({ "name": "Alliance", "order": 1, "header": true }));
	assert_eq!(out["f"]["72"], json!({ "name": "Stormwind", "order": 2, "parent": 469, "standing": 5, "value": 3100, "min": 3000, "max": 9000 }));
	assert_eq!(out["f"]["47"], json!({ "name": "Ironforge", "order": 3, "parent": 469, "standing": 4, "value": 0, "min": 0, "max": 3000, "canToggleAtWar": true }));
	assert_eq!(out["f"]["169"], json!({ "name": "Steamwheedle Cartel", "order": 5, "parent": 1118, "header": true, "headerRep": true, "standing": 4, "value": 500, "min": 0, "max": 3000 }));
	assert_eq!(out["f"]["21"], json!({ "name": "Booty Bay", "order": 6, "parent": 169, "standing": 4, "value": 500, "min": 0, "max": 3000 }));
	assert_eq!(out["f"]["1168"]["parent"], 1169);
	assert_eq!(out["f"].as_object().unwrap().len(), 8);
}

#[test]
fn psrec_skills_every_skill_line_with_rank_max_and_category_collapsed_headers_restored() {
	let out = run(
		r#"
		cmd("skills")
		local collapsed = {}
		for _, r in ipairs(stub.world.skills) do if r.isHeader and r.isCollapsed then collapsed[#collapsed + 1] = r.name end end
		emit({ s = S().skills, collapsed = collapsed })"#,
		SKILLS,
	);
	assert_eq!(out["collapsed"], json!(["Professions"]));
	assert_eq!(
		out["s"],
		json!({
			"186": { "name": "Mining", "order": 2, "rank": 40, "max": 75, "category": "Professions", "categoryID": 11 },
			"182": { "name": "Herbalism", "order": 3, "rank": 1, "max": 75, "category": "Professions", "categoryID": 11 },
			"43": { "name": "Swords", "order": 5, "rank": 20, "max": 25, "category": "Weapon Skills", "categoryID": 6 },
		})
	);
}

#[test]
fn psrec_legacy_achievement_categories_achievements_with_criteria_and_legacy_points_the_renown_track_and_the_legacy_trees() {
	let out = run(
		r#"
		stub.world.achievements = {
			categories = {
				{ id = 92, name = "General", achievements = { 6, 7 } },
				{ id = 15500, name = "Exploration", parent = 92, achievements = { 760 } },
			},
			list = {
				[6] = { name = "Level 10", points = 10, completed = true, description = "Reach level 10.", legacyPoints = 5,
					criteria = { { text = "Reach level 10", type = 5, completed = true, quantity = 10, required = 10, id = 34 } } },
				[7] = { name = "Level 20", points = 10, description = "Reach level 20.", previous = 6, criteria = {} },
				[760] = { name = "Explore Elwynn Forest", points = 10, description = "Explore Elwynn.", legacyPoints = 10, reward = "Legacy: 10",
					criteria = { { text = "Goldshire", type = 43, quantity = 0, required = 1, assetID = 87, id = 900 },
					             { text = "Northshire Valley", type = 43, completed = true, quantity = 1, required = 1, assetID = 9, id = 901 } } },
			},
		}
		stub.world.majorFactions[2802] = { name = "Legacy", level = 3, maxLevel = 20, earned = 400, threshold = 1000, unlocked = true,
			levels = { { level = 1, milestone = true, rewards = { { renownRewardID = 11, name = "Legacy Tabard", itemID = 999, isAccountUnlock = true } } }, { level = 2, locked = true } } }
		stub.world.trees = {
			[1187] = { configID = 77, groups = {}, nodes = { [5001] = { ID = 5001, posX = 1, posY = 2, maxRanks = 1, type = 0, isVisible = true, entryIDs = {}, groupIDs = {} } },
				currency = { { traitCurrencyID = 4225, quantity = 15, spent = 5, maxQuantity = 100 } } },
		}
		cmd("legacy")
		local l = S().legacy
		emit({
			categories = l.categories, a6 = l.achievements[6], a7 = l.achievements[7], a760 = l.achievements[760],
			renown = l.majorFactions[2802], trees = l.trees, rewardFaction = l.rewardFaction, currency = l.pointsCurrency,
		})"#,
		"",
	);

	assert_eq!(
		out["categories"],
		json!({
			"92": { "name": "General", "order": 1, "legacy": true, "achievements": [6, 7] },
			"15500": { "name": "Exploration", "parent": 92, "order": 2, "legacy": true, "achievements": [760] },
		})
	);
	assert_eq!(
		out["a6"],
		json!({
			"name": "Level 10", "description": "Reach level 10.", "points": 10, "category": 92, "completed": true, "earnedByMe": true,
			"legacyPoints": 5, "legacy": true,
			"criteria": [{ "text": "Reach level 10", "type": 5, "quantity": 10, "required": 10, "completed": true, "id": 34 }],
		})
	);
	assert_eq!(out["a7"], json!({ "name": "Level 20", "description": "Reach level 20.", "points": 10, "category": 92, "completed": false, "previous": 6, "criteria": {} }));
	assert_eq!(
		out["a760"]["criteria"],
		json!([
			{ "text": "Goldshire", "type": 43, "assetID": 87, "quantity": 0, "required": 1, "completed": false, "id": 900 },
			{ "text": "Northshire Valley", "type": 43, "assetID": 9, "quantity": 1, "required": 1, "completed": true, "id": 901 },
		])
	);
	assert_eq!(out["a760"]["reward"], "Legacy: 10");
	assert_eq!(
		out["renown"],
		json!({
			"name": "Legacy", "unlocked": true, "level": 3, "maxLevel": 20, "earned": 400, "threshold": 1000, "legacy": true,
			"levels": [
				{ "level": 1, "locked": false, "milestone": true, "rewards": [{ "id": 11, "name": "Legacy Tabard", "item": 999, "accountUnlock": true }] },
				{ "level": 2, "locked": true, "rewards": {} },
			],
		})
	);
	assert_eq!(out["rewardFaction"], 2802);
	assert_eq!(out["currency"], 4225);
	// (an empty Lua table encodes as {})
	let trees: Vec<Value> = out["trees"]
		.as_array()
		.unwrap()
		.iter()
		.map(|t| {
			let keys = t["nodes"].as_object().map(|o| o.len()).or_else(|| t["nodes"].as_array().map(Vec::len)).unwrap_or(0);
			json!([t["key"], t["id"], t["configID"], keys])
		})
		.collect();
	assert_eq!(json!(trees), json!([["professions", 1187, 77, 1], ["adventure", 1188, null, 0], ["progression", 1189, null, 0]]));
	assert_eq!(out["trees"][0]["currency"], json!([{ "id": 4225, "quantity": 15, "max": 100, "spent": 5 }]));
}

#[test]
fn reputation_and_skill_changes_become_rep_and_skill_events_including_factions_under_collapsed_headers() {
	let out = run(
		r#"
		stub.moveTo(40, 60)
		stub.setRep(72, 3350)            -- Stormwind, under the collapsed Alliance header
		stub.fire("UPDATE_FACTION")
		stub.advance(0.5)
		stub.setRep(21, 3000, 5)         -- Booty Bay crosses into Friendly
		stub.fire("FACTION_STANDING_CHANGED", 21, 5)
		stub.fire("UPDATE_FACTION")
		stub.advance(0.5)
		stub.fire("UPDATE_FACTION")      -- nothing changed: nothing recorded
		stub.advance(0.5)
		stub.setSkill(186, 41)
		stub.fire("SKILL_LINES_CHANGED")
		stub.advance(0.5)
		stub.setSkill(186, 41, 150)      -- journeyman: max rank changes
		stub.skill({ id = 164, name = "Blacksmithing", rank = 1, max = 75, category = 11 })  -- newly learned
		stub.fire("SKILL_LINES_CHANGED")
		stub.advance(0.5)
		emit({ rep = events("rep"), skill = events("skill"), collapsed = stub.collapsedFactions() })"#,
		&format!("{FACTIONS}{SKILLS}"),
	);

	assert_eq!(
		out["rep"],
		json!([
			{ "e": "rep", "faction": 72, "factionName": "Stormwind", "standing": 5, "value": 3350, "delta": 250, "map": 1429, "x": 40, "y": 60 },
			{ "e": "rep", "faction": 21, "factionName": "Booty Bay", "standing": 5, "value": 3000, "delta": 2500, "map": 1429, "x": 40, "y": 60 },
		])
	);
	assert_eq!(
		out["skill"],
		json!([
			{ "e": "skill", "skill": "Mining", "skillLine": 186, "rank": 41, "max": 75, "map": 1429, "x": 40, "y": 60 },
			{ "e": "skill", "skill": "Mining", "skillLine": 186, "rank": 41, "max": 150, "map": 1429, "x": 40, "y": 60 },
			{ "e": "skill", "skill": "Blacksmithing", "skillLine": 164, "rank": 1, "max": 75, "map": 1429, "x": 40, "y": 60 },
		])
	);
	assert_eq!(out["collapsed"], json!(["Alliance", "Steamwheedle Cartel"]));
}

#[test]
fn exploration_is_recorded_when_the_discovery_message_or_an_unexplained_xp_gain_confirms_it() {
	let out = run(
		r#"
		stub.world.areas = { [12] = "Elwynn Forest", [87] = "Goldshire", [60] = "Jasperlode Mine", [88] = "Fargodeep Mine" }
		-- at login the client reports exploration for where the player stands: not a discovery
		stub.world.explored = { 12 }
		stub.fire("MAP_EXPLORATION_UPDATED")
		stub.advance(2)
		-- Goldshire, with the client's message
		stub.moveTo(42, 65)
		stub.world.explored = { 12, 87 }
		stub.fire("MAP_EXPLORATION_UPDATED")
		stub.fire("UI_INFO_MESSAGE", 372, "Discovered Goldshire: 40 experience gained")
		stub.advance(2)
		-- Jasperlode Mine, no message, but an XP gain no kill or turn-in explains
		stub.moveTo(61, 50)
		stub.world.explored = { 12, 60 }
		stub.fire("MAP_EXPLORATION_UPDATED")
		stub.world.xp = stub.world.xp + 45
		stub.fire("PLAYER_XP_UPDATE", "player")
		stub.advance(2)
		-- Fargodeep Mine: the XP comes from a kill at the same moment, so it is not a discovery
		stub.moveTo(39, 82)
		stub.world.explored = { 12, 88 }
		stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "Kobold Miner dies, you gain 50 experience.")
		stub.world.xp = stub.world.xp + 50
		stub.fire("PLAYER_XP_UPDATE", "player")
		stub.fire("MAP_EXPLORATION_UPDATED")
		stub.advance(2)
		emit(events("explore"))"#,
		"",
	);

	assert_eq!(
		out,
		json!([
			{ "e": "explore", "map": 1429, "x": 42, "y": 65, "area": "Goldshire", "areaID": 87, "xp": 40 },
			{ "e": "explore", "map": 1429, "x": 61, "y": 50, "area": "Jasperlode Mine", "areaID": 60, "xp": 45 },
		])
	);
}

#[test]
fn a_profession_learned_under_a_collapsed_header_is_found_its_rank_ups_recorded_and_the_header_left_collapsed() {
	let out = run(
		r#"
		stub.moveTo(40, 60)
		stub.advance(1)
		local togglesBefore = stub.world.skillToggles
		-- learn Blacksmithing at the trainer: it lands under the collapsed "Professions"
		stub.skill({ id = 164, name = "Blacksmithing", rank = 1, max = 75, category = 11 }, 2)
		stub.fire("SKILL_LINES_CHANGED")
		stub.fire("LEARNED_SPELL_IN_SKILL_LINE", 2018, 3, false)
		stub.advance(1)
		local togglesForLearn = stub.world.skillToggles - togglesBefore
		-- later rank-ups (only SKILL_LINES_CHANGED; the header stays collapsed)
		stub.setSkill(164, 2)
		stub.fire("SKILL_LINES_CHANGED")
		stub.advance(1)
		local togglesAfter = stub.world.skillToggles
		stub.advance(2) -- the scan's own toggles do not keep re-scanning
		local collapsed = {}
		for _, r in ipairs(stub.world.skills) do if r.isHeader and r.isCollapsed then collapsed[#collapsed + 1] = r.name end end
		emit({ skill = events("skill"), collapsed = collapsed, togglesForLearn = togglesForLearn, settled = stub.world.skillToggles == togglesAfter })"#,
		SKILLS,
	);

	assert_eq!(
		out["skill"],
		json!([
			{ "e": "skill", "skill": "Blacksmithing", "skillLine": 164, "rank": 1, "max": 75, "map": 1429, "x": 40, "y": 60 },
			{ "e": "skill", "skill": "Blacksmithing", "skillLine": 164, "rank": 2, "max": 75, "map": 1429, "x": 40, "y": 60 },
		])
	);
	assert_eq!(out["collapsed"], json!(["Professions"]));
	assert_eq!(out["togglesForLearn"], 2); // one expand, one collapse
	assert_eq!(out["settled"], true);
}

#[test]
fn exploration_a_discovery_message_before_the_client_adds_the_area_still_records_that_area_two_discoveries_in_one_window_stay_apart() {
	let out = run(
		r#"
		stub.world.areas = { [12] = "Elwynn Forest", [87] = "Goldshire", [60] = "Jasperlode Mine", [88] = "Fargodeep Mine" }
		stub.world.explored = { 12 }
		stub.fire("MAP_EXPLORATION_UPDATED")
		stub.advance(2)
		-- the message comes first; the area appears in the explored list just after
		stub.moveTo(42, 65)
		stub.fire("UI_INFO_MESSAGE", 372, "Discovered Goldshire: 40 experience gained")
		stub.world.explored = { 12, 87 }
		stub.fire("MAP_EXPLORATION_UPDATED")
		stub.advance(2)
		-- two discoveries inside one window
		stub.moveTo(50, 50)
		stub.world.explored = { 12, 60, 88 }
		stub.fire("MAP_EXPLORATION_UPDATED")
		stub.fire("CHAT_MSG_SYSTEM", "Discovered Jasperlode Mine: 45 experience gained")
		stub.fire("CHAT_MSG_SYSTEM", "Discovered Fargodeep Mine: 50 experience gained")
		stub.advance(2)
		emit(events("explore"))"#,
		"",
	);

	assert_eq!(
		out,
		json!([
			{ "e": "explore", "map": 1429, "x": 42, "y": 65, "area": "Goldshire", "areaID": 87, "xp": 40 },
			{ "e": "explore", "map": 1429, "x": 50, "y": 50, "area": "Jasperlode Mine", "areaID": 60, "xp": 45 },
			{ "e": "explore", "map": 1429, "x": 50, "y": 50, "area": "Fargodeep Mine", "areaID": 88, "xp": 50 },
		])
	);
}

#[test]
fn crafts_newly_learned_spells_and_recipes_and_achievements() {
	let out = run(
		r#"
		stub.world.profession = 164
		stub.world.recipes = { [2660] = { output = 2862, quantity = 1 }, [3115] = { output = 3239, quantity = 1 } }
		stub.world.spells = { [133] = "Fireball", [2660] = "Rough Sharpening Stone" }
		-- a craft with its crafted-item result
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-1", 2660)
		stub.fire("TRADE_SKILL_ITEM_CRAFTED_RESULT", { itemID = 2862, quantity = 2 })
		-- a craft without a result event: the recipe's schematic fills the item
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-2", 3115)
		stub.advance(1.5)
		-- not crafts: a combat spell, someone else's cast
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-3", 133)
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "party1", "Cast-4", 2660)
		stub.advance(1.5)
		stub.fire("LEARNED_SPELL_IN_SKILL_LINE", 133, 2, false)
		stub.fire("NEW_RECIPE_LEARNED", 2660)
		stub.fire("LEARNED_SPELL_IN_SKILL_LINE", 2660, 3, false) -- the same recipe again: once
		stub.world.achievements.list[6] = { name = "Level 10", criteria = {} }
		stub.fire("ACHIEVEMENT_EARNED", 6)
		emit({ craft = events("craft"), learn = events("learn"), achieve = events("achieve") })"#,
		"",
	);

	assert_eq!(
		out["craft"],
		json!([
			{ "e": "craft", "spell": 2660, "item": 2862, "count": 2, "skill": 164 },
			{ "e": "craft", "spell": 3115, "item": 3239, "count": 1, "skill": 164 },
		])
	);
	assert_eq!(
		out["learn"],
		json!([
			{ "e": "learn", "spell": 133, "name": "Fireball" },
			{ "e": "learn", "spell": 2660, "name": "Rough Sharpening Stone" },
		])
	);
	assert_eq!(out["achieve"], json!([{ "e": "achieve", "id": 6, "name": "Level 10" }]));
}

#[test]
fn the_new_event_kinds_respect_their_per_session_caps() {
	let out = run(
		r#"
		for id = 1, 1600 do stub.fire("LEARNED_SPELL_IN_SKILL_LINE", 100000 + id, 1, false) end
		for id = 1, 1600 do stub.fire("ACHIEVEMENT_EARNED", id) end
		emit({ learn = #events("learn"), achieve = #events("achieve"), dropped = S().dropped })"#,
		"",
	);
	assert_eq!(out["learn"], 1500);
	assert_eq!(out["achieve"], 1500);
	assert_eq!(out["dropped"]["learn"], 100);
	assert_eq!(out["dropped"]["achieve"], 100);
}

#[test]
fn quest_givers_and_enders_that_are_game_objects_are_recorded_with_their_object_id() {
	let out = run(
		r#"
		stub.moveTo(41.8, 65.6)
		local poster = stub.gameObject(68, "Wanted Board")
		stub.offerQuest(176, poster, "Wanted Board", "Wanted: \"Hogger\"")
		stub.acceptQuest(176, { title = "Wanted: \"Hogger\"", level = 11, objectives = {} })
		stub.moveTo(50, 50)
		local box = stub.gameObject(1593, "Supply Crate")
		stub.turnIn(176, box, "Supply Crate", 900, 0)
		emit({ accept = events("accept")[1], turnin = events("turnin")[1] })"#,
		"",
	);
	assert_eq!(
		out["accept"],
		json!({
			"e": "accept", "q": 176, "title": "Wanted: \"Hogger\"", "qlvl": 11, "lvl": 1, "xp": 0,
			"object": 68, "objName": "Wanted Board", "map": 1429, "x": 41.8, "y": 65.6,
		})
	);
	assert_eq!(out["turnin"], json!({ "e": "turnin", "q": 176, "xpReward": 900, "money": 0, "lvl": 1, "object": 1593, "objName": "Supply Crate", "map": 1429, "x": 50, "y": 50 }));
}

#[test]
fn an_item_started_quest_keeps_its_item_through_the_second_quest_detail_its_popup_fires() {
	let out = run(
		r#"
		stub.moveTo(30, 70)
		stub.world.questID = 123
		stub.world.quests[123] = { title = "The Collector", level = 10, objectives = {} }
		stub.setUnit("npc", nil)
		stub.fire("QUEST_DETAIL", 1307)      -- using the Gold Pickup Schedule
		stub.moveTo(31, 71)
		stub.fire("QUEST_DETAIL")            -- the quest popup, no item id
		stub.acceptQuest(123, { title = "The Collector", level = 10, objectives = {} })
		emit(events("accept")[1])"#,
		"",
	);
	assert_eq!(out, json!({ "e": "accept", "q": 123, "title": "The Collector", "qlvl": 10, "lvl": 1, "xp": 0, "item": 1307, "map": 1429, "x": 30, "y": 70 }));
}
