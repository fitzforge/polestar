//! The recorder's finds (addon/Polestar_Recorder/Finds.lua): rare and treasure sightings, kills and loot windows
//! per source, instance entrances and encounters, and the quest frames' rewards, against
//! tests/lua/stub_recorder.lua.

use forge_addontest::{emitted, RunAddon};
use serde_json::{json, Value};

const REC: &str = "Polestar_Recorder";

const PRELUDE: &str = r#"
local function S() return PolestarRecorderDB.sessions[PolestarRecorderDB.current] end
local function events(kind)
	local out = {}
	for _, e in ipairs(S().events) do
		if e.e == kind then
			local c = {}
			for k, v in pairs(e) do if k ~= "t" then c[k] = v end end
			out[#out + 1] = c
		end
	end
	return out
end
local function unit(token, guid, name, cls, lvl)
	stub.setUnit(token, guid, name)
	stub.world.units[token].cls, stub.world.units[token].lvl = cls, lvl
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_recorder.lua"], addons: vec![REC.into()], login: true, script: format!("{PRELUDE}{script}"), ..Default::default() }).remove(0)
}

#[test]
fn rares_are_recorded_once_per_npc_per_50_yards_from_nameplates_target_and_vignettes_treasures_from_vignettes() {
	let out = run(r#"
		local thuros = stub.creature(61, "Thuros Lightfingers")
		stub.moveTo(40, 40)
		unit("nameplate1", thuros, "Thuros Lightfingers", "rare", 11)
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		stub.moveTo(40.5, 40) -- 26 yards on: the same sighting
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		stub.moveTo(42, 40) -- 104 yards on: a new one
		unit("target", thuros, "Thuros Lightfingers", "rare", 11)
		stub.fire("PLAYER_TARGET_CHANGED")
		-- normal and elite mobs are no sightings
		unit("mouseover", (stub.creature(299, "Young Wolf")), "Young Wolf", "normal", 2)
		stub.fire("UPDATE_MOUSEOVER_UNIT")
		unit("nameplate2", (stub.creature(116, "Defias Bandit")), "Defias Bandit", "elite", 10)
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate2")
		-- vignettes: a creature is a rare, a game object a treasure
		local V = {
			["Vignette-1"] = { objectGUID = (stub.creature(62, "Gruff Swiftbite")), name = "Gruff Swiftbite", x = 60, y = 70 },
			["Vignette-2"] = { objectGUID = (stub.gameObject(2843, "Battered Chest")), name = "Battered Chest", x = 25, y = 30 },
		}
		C_VignetteInfo = {
			GetVignetteInfo = function(g) return V[g] end,
			GetVignettePosition = function(g, map) local v = V[g]; return v and map == 1429 and CreateVector2D(v.x / 100, v.y / 100) or nil end,
			GetVignettes = function() return { "Vignette-1", "Vignette-2" } end,
		}
		stub.fire("VIGNETTE_MINIMAP_UPDATED", "Vignette-1", true)
		stub.fire("VIGNETTES_UPDATED")
		emit({ rare = events("rare"), treasure = events("treasure") })"#);

	assert_eq!(
		out["rare"],
		json!([
			{ "e": "rare", "npc": 61, "npcName": "Thuros Lightfingers", "cls": "rare", "npcLvl": 11, "src": "nameplate", "map": 1429, "x": 40, "y": 40 },
			{ "e": "rare", "npc": 61, "npcName": "Thuros Lightfingers", "cls": "rare", "npcLvl": 11, "src": "target", "map": 1429, "x": 42, "y": 40 },
			{ "e": "rare", "npc": 62, "npcName": "Gruff Swiftbite", "src": "vignette", "map": 1429, "x": 60, "y": 70 },
		])
	);
	assert_eq!(out["treasure"], json!([{ "e": "treasure", "object": 2843, "objName": "Battered Chest", "src": "vignette", "map": 1429, "x": 25, "y": 30 }]));
}

#[test]
fn kills_and_loot_windows_items_per_source_corpse_or_object_counts_denied_corpses_skinning_and_herbs_apart() {
	let out = run(r#"
		stub.moveTo(50, 50)
		local w = {}
		for i = 1, 3 do
			w[i] = stub.creature(299, "Young Wolf")
			unit("target", w[i], "Young Wolf", "normal", 3)
			stub.fire("PLAYER_TARGET_CHANGED")
			stub.partyKill(w[i])
		end
		stub.world.lootable = { [w[3]] = { true, false } } -- tapped by someone else
		stub.advance(1.5)
		local function loot(slots) stub.world.loot = slots; stub.fire("LOOT_OPENED", false, false); stub.fire("LOOT_CLOSED") end
		loot({ { name = "Tough Wolf Meat", item = 750, count = 2, src = { w[1], 2 } }, { name = "Ruined Pelt", item = 4865, src = { w[1], 1 } } })
		loot({ { name = "Ruined Pelt", item = 4865, src = { w[1], 1 } } }) -- the same corpse again
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-1", 8613) -- Skinning
		loot({ { name = "Ruined Leather Scraps", item = 2934, src = { w[1], 1 } } })
		-- area loot: wolf 2 and a wolf a party member killed
		local w4 = stub.creature(299)
		loot({ { name = "Tough Wolf Meat", item = 750, count = 3, src = { w[2], 1, w4, 2 } } })
		stub.moveTo(25.1, 30.2)
		local chest = stub.gameObject(2843)
		loot({ { name = "Linen Cloth", item = 2589, count = 2, src = { chest, 2 } }, { name = "Kobold Candle", item = 772, quest = true, src = { chest, 1 } } })
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-2", 2366) -- Herb Gathering
		loot({ { name = "Peacebloom", item = 2447, src = { (stub.gameObject(1617)), 1 } } })
		local slain, drops = {}, {}
		for _, e in ipairs(events("slain")) do slain[#slain + 1] = { e.npc, e.npcName or false, e.npcLvl or false, e.denied or false } end
		for _, e in ipairs(events("drop")) do drops[#drops + 1] = { npc = e.npc, object = e.object, gather = e.gather, items = e.items, x = e.x } end
		emit({ slain = slain, drops = drops })"#);

	assert_eq!(out["slain"], json!([[299, "Young Wolf", 3, false], [299, "Young Wolf", 3, false], [299, "Young Wolf", 3, true], [299, false, false, false],]));
	assert_eq!(
		out["drops"],
		json!([
			{ "npc": 299, "items": [{ "item": 750, "n": 2 }, { "item": 4865, "n": 1 }], "x": 50 },
			{ "npc": 299, "gather": "skin", "items": [{ "item": 2934, "n": 1 }], "x": 50 },
			{ "npc": 299, "items": [{ "item": 750, "n": 1 }], "x": 50 },
			{ "npc": 299, "items": [{ "item": 750, "n": 2 }], "x": 50 },
			{ "object": 2843, "items": [{ "item": 2589, "n": 2 }, { "item": 772, "n": 1, "q": true }], "x": 25.1 },
			{ "object": 1617, "gather": "herb", "items": [{ "item": 2447, "n": 1 }], "x": 25.1 },
		])
	);
}

#[test]
fn instance_entrances_keep_the_last_outdoor_position_encounters_name_their_bosses_and_loot_ties_to_the_instance() {
	let out = run(r#"
		stub.moveTo(42.5, 71.8)
		stub.fire("PLAYER_LEAVING_WORLD")
		stub.world.instance = { id = 36, name = "Deadmines", kind = "party", diff = 1 }
		stub.moveTo(10, 10, 1453)
		stub.fire("PLAYER_ENTERING_WORLD", false, false)
		stub.fire("ZONE_CHANGED_NEW_AREA")
		local boss = stub.creature(639, "Edwin VanCleef")
		unit("target", boss, "Edwin VanCleef", "elite", 21)
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.fire("ENCOUNTER_START", 1736, "Edwin VanCleef", 1, 5)
		stub.unitDied((stub.creature(636, "Defias Blackguard")))
		stub.partyKill(boss)
		stub.unitDied(boss)
		stub.fire("ENCOUNTER_END", 1736, "Edwin VanCleef", 1, 5, 1, { { creatureID = 639, creatureName = "Edwin VanCleef", remainingHealthPercent = 0 } })
		-- no boss list: the creatures that died during the encounter
		stub.fire("ENCOUNTER_START", 1737, "Cookie", 1, 5)
		stub.unitDied((stub.creature(645, "Cookie")))
		stub.fire("ENCOUNTER_END", 1737, "Cookie", 1, 5, 0, {})
		stub.world.loot = { { name = "Cruel Barb", item = 5191, src = { boss, 1 } } }
		stub.fire("LOOT_OPENED", false, false)
		emit({ enter = events("enter"), encounter = events("encounter"), slain = events("slain"), drop = events("drop") })"#);

	assert_eq!(out["enter"], json!([{ "e": "enter", "inst": 36, "instName": "Deadmines", "instType": "party", "diff": 1, "map": 1429, "x": 42.5, "y": 71.8 }]));
	assert_eq!(
		out["encounter"],
		json!([
			{ "e": "encounter", "enc": 1736, "encName": "Edwin VanCleef", "diff": 1, "size": 5, "ok": true, "inst": 36, "npcs": [639], "map": 1453, "x": 10, "y": 10 },
			{ "e": "encounter", "enc": 1737, "encName": "Cookie", "diff": 1, "size": 5, "ok": false, "inst": 36, "npcs": [645], "map": 1453, "x": 10, "y": 10 },
		])
	);
	assert_eq!(out["slain"], json!([{ "e": "slain", "npc": 639, "npcName": "Edwin VanCleef", "cls": "elite", "npcLvl": 21, "inst": 36, "diff": 1, "map": 1453, "x": 10, "y": 10 }]));
	assert_eq!(out["drop"], json!([{ "e": "drop", "npc": 639, "npcName": "Edwin VanCleef", "items": [{ "item": 5191, "n": 1 }], "inst": 36, "diff": 1, "map": 1453, "x": 10, "y": 10 }]));
}

#[test]
fn accept_and_turn_in_carry_the_quest_frame_rewards() {
	let out = run(r#"
		local R = { reward = { 2575 }, choice = { 2577, 2578 } }
		function GetNumQuestRewards() return #R.reward end
		function GetNumQuestChoices() return #R.choice end
		function GetQuestItemInfo(kind, i) return "Item", 134400, 1, 1, true, R[kind][i] end
		function GetRewardMoney() return 75 end
		local willem = stub.creature(823, "Deputy Willem")
		stub.offerQuest(7, willem, "Deputy Willem", "Kobold Camp Cleanup")
		stub.acceptQuest(7, { title = "Kobold Camp Cleanup", level = 2, objectives = {} })
		R.choice = { 2577 } -- what the completion frame shows wins at turn-in
		stub.turnIn(7, willem, "Deputy Willem", 450, 75)
		local a, t = events("accept")[1], events("turnin")[1]
		emit({ accept = { a.items, a.choices, a.rewardMoney }, turnin = { t.items, t.choices, t.rewardMoney, t.money } })"#);

	assert_eq!(out["accept"], json!([[2575], [2577, 2578], 75]));
	assert_eq!(out["turnin"], json!([[2575], [2577], 75, 75]));
}
