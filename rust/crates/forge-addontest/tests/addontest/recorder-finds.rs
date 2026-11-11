//! The recorder's fights and loot (addon/Polestar_Recorder/Finds.lua): the unit census, rare and treasure
//! sightings, kills with their XP line, loot windows per source with the open item objectives, instance
//! entrances and encounters, against tests/lua/stub_recorder.lua.

use crate::recorder::{run, strings};
use serde_json::json;

const UNIT: &str = r#"
local function unit(token, guid, name, cls, lvl)
	stub.setUnit(token, guid, name)
	stub.world.units[token].cls, stub.world.units[token].lvl = cls, lvl
end
"#;

fn sorted(v: &serde_json::Value) -> Vec<String> {
	let mut s = strings(v);
	s.sort();
	s
}

#[test]
fn creatures_seen_are_counted_once_per_level_and_100_yards_rares_once_per_50_yards_treasures_behind_vignettes() {
	let out = run(&format!(
		"{UNIT}{}",
		r#"
		local thuros = stub.creature(61, "Thuros Lightfingers")
		stub.moveTo(40, 40)
		unit("nameplate1", thuros, "Thuros Lightfingers", "rare", 11)
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		stub.moveTo(40.5, 40) -- 26 yards on: the same sighting
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		stub.moveTo(42, 40) -- 104 yards on: a new one
		unit("target", thuros, "Thuros Lightfingers", "rare", 11)
		stub.fire("PLAYER_TARGET_CHANGED")
		-- the census: three neutral wolves of one level are one record, another level another
		for i = 1, 3 do
			unit("nameplate" .. (i + 1), (stub.creature(299, "Young Wolf")), "Young Wolf", "normal", 2)
			stub.world.units["nameplate" .. (i + 1)].react = 4
			stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate" .. (i + 1))
		end
		unit("mouseover", (stub.creature(299, "Young Wolf")), "Young Wolf", "normal", 3)
		stub.fire("UPDATE_MOUSEOVER_UNIT")
		stub.moveTo(44.1, 40) -- 109 yards on: the same npc and level again
		unit("mouseover", (stub.creature(299, "Young Wolf")), "Young Wolf", "normal", 2)
		stub.fire("UPDATE_MOUSEOVER_UNIT")
		unit("nameplate5", (stub.creature(116, "Defias Bandit")), "Defias Bandit", "elite", 10)
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate5")
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
		logout()
		emit({ recs = recs("unit rare treasure"), bad = malformed() })"#
	));
	assert_eq!(
		out["recs"],
		json!([
			"unit|61|11|r|h|1429|4000|4000|p",
			"rare|61|11|r|1429|4000|4000|p",
			"unit|61|11|r|h|1429|4200|4000|t",
			"rare|61|11|r|1429|4200|4000|t",
			"unit|299|2|n|n|1429|4200|4000|p",
			"unit|299|3|n|h|1429|4200|4000|m",
			"unit|299|2|n|h|1429|4410|4000|m",
			"unit|116|10|e|h|1429|4410|4000|p",
			"rare|62|||1429|6000|7000|v",
			"treasure|2843|1429|2500|3000",
		])
	);
	assert_eq!(out["bad"], json!({}));
}

#[test]
fn kills_carry_level_class_and_tap_loot_windows_go_per_source_with_the_open_item_objectives() {
	let out = run(&format!(
		"{UNIT}{}",
		r#"
		stub.acceptQuest(33, { title = "Wolves Across the Border", objectives = { { text = "Tough Wolf Meat: %d/%d", type = "item", numRequired = 8 }, { text = "Ruined Pelt: %d/%d", type = "item", numRequired = 1, numFulfilled = 1 } } })
		stub.moveTo(50, 50)
		local w = {}
		for i = 1, 3 do
			w[i] = stub.creature(299, "Young Wolf")
			unit("target", w[i], "Young Wolf", "normal", 3)
			if i == 2 then stub.world.units.target.tapped = true end -- UnitIsTapDenied
			stub.fire("PLAYER_TARGET_CHANGED")
			stub.partyKill(w[i])
		end
		stub.world.lootable = { [w[3]] = { true, false } } -- its corpse is someone else's loot
		-- a wolf the player never saw dies nearby: someone else's kill, not recorded
		stub.unitDied((stub.creature(299, "Young Wolf")))
		-- an XP line and no death reported: a kill of the creature seen with that name
		local boar = stub.creature(113, "Stonetusk Boar")
		unit("nameplate1", boar, "Stonetusk Boar", "normal", 5)
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		stub.xpLine("Stonetusk Boar", 40)
		stub.advance(4)
		local function loot(slots) stub.world.loot = slots; stub.fire("LOOT_OPENED", false, false); stub.fire("LOOT_CLOSED") end
		loot({ { name = "Tough Wolf Meat", item = 750, count = 2, src = { w[1], 2 } }, { name = "Ruined Pelt", item = 4865, src = { w[1], 1 } } })
		loot({ { name = "Ruined Pelt", item = 4865, src = { w[1], 1 } } }) -- the same corpse again
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-1", 8613) -- Skinning
		loot({ { name = "Ruined Leather Scraps", item = 2934, src = { w[1], 1 } } })
		-- area loot: wolf 2 and a wolf a party member killed (a corpse looted is a kill)
		local w4 = stub.creature(299)
		loot({ { name = "Tough Wolf Meat", item = 750, count = 3, src = { w[2], 1, w4, 2 } } })
		stub.moveTo(25.1, 30.2)
		local chest = stub.gameObject(2843)
		loot({ { name = "Linen Cloth", item = 2589, count = 2, src = { chest, 2 } }, { name = "Kobold Candle", item = 772, quest = true, src = { chest, 1 } } })
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-2", 2366) -- Herb Gathering
		loot({ { name = "Peacebloom", item = 2447, src = { (stub.gameObject(1617)), 1 } } })
		IsFishingLoot = function() return true end
		loot({ { name = "Raw Brilliant Smallfish", item = 6291 } })
		IsFishingLoot = nil
		stub.advance(4)
		logout()
		emit({ kills = recs("kill"), loot = recs("loot"), bad = malformed() })"#
	));
	assert_eq!(
		sorted(&out["kills"]),
		vec!["kill|113|5|n|1429|5000|5000|40||0|", "kill|299|3|n|1429|5000|5000|||0|", "kill|299|3|n|1429|5000|5000|||1|", "kill|299|3|n|1429|5000|5000|||1|", "kill|299|||1429|5000|5000||||",]
	);
	assert_eq!(
		out["loot"],
		json!([
			"loot|c|299|1429|5000|5000||750:2;4865:1|33:1",
			"loot|c|299|1429|5000|5000|s|2934:1|33:1",
			"loot|c|299|1429|5000|5000||750:1|33:1",
			"loot|c|299|1429|5000|5000||750:2|33:1",
			"loot|o|2843|1429|2510|3020||2589:2;772:1|33:1",
			"loot|o|1617|1429|2510|3020|h|2447:1|33:1",
			"loot|||1429|2510|3020|f|6291:1|33:1",
		])
	);
	assert_eq!(out["bad"], json!({}));
}

#[test]
fn a_window_fast_loot_empties_is_read_at_loot_ready_with_every_item() {
	// Fast loot calls LootSlot on every slot at LOOT_READY, and the server clears them before
	// LOOT_OPENED: a window read then lost the boar's liver, kept its snout, and the liver's quest
	// tick (Goretusk Liver Pie, 22) was tied to the snout.
	let out = run(r#"
		stub.acceptQuest(22, { title = "Goretusk Liver Pie", objectives = { { text = "Goretusk Liver: %d/%d", type = "item", numRequired = 8 } } })
		local boar = stub.creature(454, "Young Goretusk")
		stub.partyKill(boar)
		stub.advance(1)
		stub.world.loot = { { name = "Goretusk Liver", item = 723, quest = true, src = { boar, 1 } }, { name = "Goretusk Snout", item = 731, src = { boar, 1 } } }
		stub.fire("LOOT_READY", true)
		stub.fire("LOOT_READY", true) -- it can repeat for one corpse
		stub.world.loot[1] = { name = "", count = 0 } -- the liver's slot, cleared by the server
		stub.fire("LOOT_OPENED", true, false)
		stub.fire("LOOT_CLOSED")
		-- a client without LOOT_READY still reads the window at LOOT_OPENED
		local boar2 = stub.creature(454, "Young Goretusk")
		stub.partyKill(boar2)
		stub.world.loot = { { name = "Goretusk Snout", item = 731, src = { boar2, 1 } } }
		stub.fire("LOOT_OPENED", false, false)
		stub.fire("LOOT_CLOSED")
		stub.advance(4)
		logout()
		emit({ loot = recs("loot"), bad = malformed() })"#);
	assert_eq!(out["loot"], json!(["loot|c|454|1429|5000|5000||723:1;731:1|22:1", "loot|c|454|1429|5000|5000||731:1|22:1"]));
	assert_eq!(out["bad"], json!({}));
}

#[test]
fn xp_lines_are_read_in_the_client_s_language_from_its_own_format_strings_positional_arguments_included() {
	let out = run(r#"
		COMBATLOG_XPGAIN_FIRSTPERSON = "%2$d Erfahrung: %1$s stirbt."
		COMBATLOG_XPGAIN_EXHAUSTION1 = "%2$d Erfahrung: %1$s stirbt. (%3$s EP %4$s Bonus)"
		local g = stub.creature(6, "Koboldungeziefer")
		stub.setUnit("target", g, "Koboldungeziefer")
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.partyKill(g)
		stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "52 Erfahrung: Koboldungeziefer stirbt. (+26 EP erholt Bonus)")
		stub.advance(4)
		logout()
		emit(recs("kill"))"#);
	assert_eq!(out, json!(["kill|6|1|n|1429|5000|5000|52|26|0|"]));
}

#[test]
fn instance_entrances_keep_the_last_outdoor_position_inside_positions_are_empty_encounters_are_recorded() {
	let out = run(r#"
		stub.moveTo(42.5, 71.8)
		stub.fire("PLAYER_LEAVING_WORLD")
		stub.world.instance = { id = 36, name = "Deadmines", kind = "party", diff = 1 }
		stub.world.x = nil -- the client gives no position inside
		stub.fire("PLAYER_ENTERING_WORLD", false, false)
		stub.fire("ZONE_CHANGED_NEW_AREA")
		local boss = stub.creature(639, "Edwin VanCleef")
		stub.setUnit("target", boss, "Edwin VanCleef")
		stub.world.units.target.cls, stub.world.units.target.lvl = "elite", 21
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.fire("ENCOUNTER_START", 1736, "Edwin VanCleef", 1, 5)
		stub.partyKill(boss)
		stub.fire("ENCOUNTER_END", 1736, "Edwin VanCleef", 1, 5, 1)
		stub.fire("ENCOUNTER_START", 1737, "Cookie", 1, 5)
		stub.fire("ENCOUNTER_END", 1737, "Cookie", 1, 5, 0)
		stub.world.loot = { { name = "Cruel Barb", item = 5191, src = { boss, 1 } } }
		stub.fire("LOOT_OPENED", false, false)
		stub.advance(4)
		logout()
		emit({ recs = recs("enter encounter kill loot unit"), bad = malformed() })"#);
	assert_eq!(out["recs"], json!(["enter|36|party|1|1429|4250|7180", "unit|639|21|e|h||||t", "encounter|1736|1|1|5", "encounter|1737|0|1|5", "loot|c|639|||||5191:1|", "kill|639|21|e||||||0|",]));
	assert_eq!(out["bad"], json!({}));
}

#[test]
fn a_recorded_kill_carries_its_spawn_the_creature_guid_s_last_part_only_when_it_is_1_to_16_hex_digits() {
	let out = run(r#"
		local function kill(guid, x)
			stub.moveTo(x, 60)
			stub.partyKill(guid)
			stub.advance(0.5)
		end
		stub.moveTo(40, 60)
		local wolf = stub.creature(299, "Young Wolf")
		stub.setUnit("target", wolf, "Young Wolf")
		stub.fire("PLAYER_TARGET_CHANGED")
		kill(wolf, 40)
		kill("Creature-0-4372-0-12-6-0123456789abcdef", 41)   -- 16 hex digits: kept, in capitals
		kill("Creature-0-4372-0-12-6-0123456789ABCDEF0", 42)  -- 17: not a spawn id, no `spawn`
		kill("Creature-0-4372-0-12-6-00000000ZZ", 43)         -- not hex
		kill("Creature-0-4372-0-12-6", 44)                     -- no spawn part
		kill("Creature-0-4372-0-12-6-00000000AB-FF", 45)      -- eight parts: no part of it
		-- a death the player had no part in: no kill, no spawn
		stub.unitDied((stub.creature(113, "Stonetusk Boar")))
		stub.advance(4)
		logout()
		emit({ recs = recs("kill spawn"), bad = malformed() })"#);
	assert_eq!(
		out["recs"],
		json!([
			"kill|299|1|n|1429|4000|6000|||0|",
			"spawn|299|0000000001|1429|4000|6000",
			"kill|6|||1429|4100|6000||||",
			"spawn|6|0123456789ABCDEF|1429|4100|6000",
			"kill|6|||1429|4200|6000||||",
			"kill|6|||1429|4300|6000||||",
			"kill|6|||1429|4400|6000||||",
			"kill|6|||1429|4500|6000||||",
		])
	);
	assert_eq!(out["bad"], json!({}));
}

const SKILLS: &str = r#"
stub.skill({ id = 182, name = "Herbalism", rank = 57, max = 75 })
stub.skill({ id = 186, name = "Mining", rank = 30, max = 75 })
stub.skill({ id = 356, name = "Fishing", rank = 112, max = 150 })
stub.skill({ id = 633, name = "Lockpicking", rank = 80, max = 100 })
local function loot(slots) stub.world.loot = slots; stub.fire("LOOT_OPENED", false, false); stub.fire("LOOT_CLOSED") end
local function cast(spell) stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-1", spell) end
"#;

#[test]
fn gathering_a_herb_ore_a_picked_lock_or_a_fishing_pool_writes_gather_with_the_skill_and_its_rank_read_live() {
	let out = run(&format!(
		"{SKILLS}{}",
		r#"
		stub.moveTo(30, 40)
		local herb = stub.gameObject(1618, "Peacebloom")
		cast(2366) -- Herb Gathering
		loot({ { name = "Peacebloom", item = 2447, count = 2, src = { herb, 2 } } })
		cast(2366) -- the same node again: nothing
		loot({ { name = "Peacebloom", item = 2447, count = 2, src = { herb, 2 } } })
		stub.moveTo(31, 40)
		cast(2575) -- Mining
		loot({ { name = "Copper Ore", item = 2770, src = { (stub.gameObject(1731, "Copper Vein")), 1 } } })
		stub.moveTo(32, 40)
		loot({ { name = "Linen Cloth", item = 2589, count = 2, src = { (stub.gameObject(2843, "Chest")), 2 } } }) -- no cast: a chest
		stub.moveTo(33, 40)
		cast(1804) -- Pick Lock
		loot({ { name = "Silver Bar", item = 2842, src = { (stub.gameObject(2850, "Locked Chest")), 1 } } })
		stub.moveTo(34, 40)
		stub.world.fishing = true
		local pool = stub.gameObject(180582, "Oily Blackmouth School")
		loot({ { name = "Oily Blackmouth", item = 6358, src = { pool, 1 } } })
		stub.advance(30)
		loot({ { name = "Oily Blackmouth", item = 6358, src = { pool, 1 } } }) -- the same pool: loot only
		loot({ { name = "Raw Brilliant Smallfish", item = 6291, src = { (stub.gameObject(35591, "Fishing Bobber")), 1 } } }) -- open water
		stub.advance(300)
		stub.setSkill(356, 113)
		loot({ { name = "Oily Blackmouth", item = 6358, src = { pool, 1 } } }) -- five minutes on: a gather again
		stub.world.fishing = false
		logout()
		emit({ recs = recs("loot gather"), bad = malformed() })"#
	));
	assert_eq!(
		out["recs"],
		json!([
			"loot|o|1618|1429|3000|4000|h|2447:2|",
			"gather|1618|1429|3000|4000|h|182|57",
			"loot|o|1731|1429|3100|4000|m|2770:1|",
			"gather|1731|1429|3100|4000|m|186|30",
			"loot|o|2843|1429|3200|4000||2589:2|",
			"loot|o|2850|1429|3300|4000||2842:1|",
			"gather|2850|1429|3300|4000|l|633|80",
			"loot|o|180582|1429|3400|4000|f|6358:1|",
			"gather|180582|1429|3400|4000|f|356|112",
			"loot|o|180582|1429|3400|4000|f|6358:1|",
			"loot|||1429|3400|4000|f|6291:1|",
			"loot|o|180582|1429|3400|4000|f|6358:1|",
			"gather|180582|1429|3400|4000|f|356|113",
		])
	);
	assert_eq!(out["bad"], json!({}));
}

#[test]
fn at_most_20_gather_records_are_written_in_any_minute() {
	let out = run(&format!(
		"{SKILLS}{}",
		r#"
		for i = 1, 25 do
			stub.moveTo(30 + i, 40)
			cast(2366)
			loot({ { name = "Peacebloom", item = 2447, src = { (stub.gameObject(1617, "Peacebloom")), 1 } } })
			stub.advance(1)
		end
		logout()
		emit({ loot = #recs("loot"), gather = #recs("gather"), bad = malformed() })"#
	));
	assert_eq!(out, json!({ "loot": 25, "gather": 20, "bad": {} }));
}
