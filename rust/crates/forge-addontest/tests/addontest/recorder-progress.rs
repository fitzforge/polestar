//! The recorder's character progress (addon/Polestar_Recorder/Progress.lua): reputation, skills, exploration,
//! crafts from the trade skill window only, learned spells, achievements; plus quest givers that are game
//! objects or items, against tests/lua/stub_recorder.lua.

use crate::recorder::{run, run_with};
use serde_json::json;

// Reputation list: Alliance (collapsed) > Stormwind, Ironforge; Classic > Steamwheedle (sub-header with rep,
// collapsed) > Booty Bay.
const FACTIONS: &str = r#"
	stub.faction({ id = 469, name = "Alliance", header = true, collapsed = true })
	stub.faction({ id = 72, name = "Stormwind", depth = 1, child = true, reaction = 5, value = 3100, min = 3000, max = 9000 })
	stub.faction({ id = 47, name = "Ironforge", depth = 1, child = true, reaction = 4, value = 0, min = 0, max = 3000, canToggle = true })
	stub.faction({ id = 1118, name = "Classic", header = true })
	stub.faction({ id = 169, name = "Steamwheedle Cartel", depth = 1, header = true, child = true, headerRep = true, collapsed = true, reaction = 4, value = 500, min = 0, max = 3000 })
	stub.faction({ id = 21, name = "Booty Bay", depth = 2, child = true, reaction = 4, value = 500, min = 0, max = 3000 })
"#;

const SKILLS: &str = r#"
	stub.skill({ name = "Professions", header = true, collapsed = true })
	stub.skill({ id = 186, name = "Mining", rank = 40, max = 75, category = 11 })
	stub.skill({ id = 182, name = "Herbalism", rank = 1, max = 75, category = 11 })
	stub.skill({ name = "Weapon Skills", header = true })
	stub.skill({ id = 43, name = "Swords", rank = 20, max = 25, category = 6 })
"#;

#[test]
fn reputation_and_skill_changes_become_rep_and_skill_records_including_factions_under_collapsed_headers() {
	let out = run_with(
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
		logout()
		emit({ recs = recs("rep skill"), collapsed = stub.collapsedFactions() })"#,
		&format!("{FACTIONS}{SKILLS}"),
		true,
		None,
	);
	assert_eq!(out["recs"], json!(["rep|72|5|3350|250", "rep|21|5|3000|2500", "skill|186|41|75", "skill|186|41|150", "skill|164|1|75"]));
	assert_eq!(out["collapsed"], json!(["Alliance", "Steamwheedle Cartel"]));
}

#[test]
fn a_profession_learned_under_a_collapsed_header_is_found_its_rank_ups_recorded_and_the_header_left_collapsed() {
	let out = run_with(
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
		stub.setSkill(164, 2)
		stub.fire("SKILL_LINES_CHANGED")
		stub.advance(1)
		local togglesAfter = stub.world.skillToggles
		stub.advance(2) -- the scan's own toggles do not keep re-scanning
		local collapsed = {}
		for _, r in ipairs(stub.world.skills) do if r.isHeader and r.isCollapsed then collapsed[#collapsed + 1] = r.name end end
		logout()
		emit({ skill = recs("skill"), collapsed = collapsed, togglesForLearn = togglesForLearn, settled = stub.world.skillToggles == togglesAfter })"#,
		SKILLS,
		true,
		None,
	);
	assert_eq!(out["skill"], json!(["skill|164|1|75", "skill|164|2|75"]));
	assert_eq!(out["collapsed"], json!(["Professions"]));
	assert_eq!(out["togglesForLearn"], 2); // one expand, one collapse
	assert_eq!(out["settled"], true);
}

#[test]
fn exploration_is_recorded_when_the_discovery_message_or_an_unexplained_xp_gain_confirms_it() {
	let out = run(r#"
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
		logout()
		emit(recs("explore"))"#);
	assert_eq!(out, json!(["explore|87|40|1429|4200|6500", "explore|60|45|1429|6100|5000"]));
}

#[test]
fn exploration_a_discovery_message_before_the_client_adds_the_area_still_records_that_area_two_discoveries_in_one_window_stay_apart() {
	let out = run(r#"
		stub.world.areas = { [12] = "Elwynn Forest", [87] = "Goldshire", [60] = "Jasperlode Mine", [88] = "Fargodeep Mine" }
		stub.world.explored = { 12 }
		stub.fire("MAP_EXPLORATION_UPDATED")
		stub.advance(2)
		stub.moveTo(42, 65)
		stub.fire("UI_INFO_MESSAGE", 372, "Discovered Goldshire: 40 experience gained")
		stub.world.explored = { 12, 87 }
		stub.fire("MAP_EXPLORATION_UPDATED")
		stub.advance(2)
		stub.moveTo(50, 50)
		stub.world.explored = { 12, 60, 88 }
		stub.fire("MAP_EXPLORATION_UPDATED")
		stub.fire("CHAT_MSG_SYSTEM", "Discovered Jasperlode Mine: 45 experience gained")
		stub.fire("CHAT_MSG_SYSTEM", "Discovered Fargodeep Mine: 50 experience gained")
		stub.advance(2)
		logout()
		emit(recs("explore"))"#);
	assert_eq!(out, json!(["explore|87|40|1429|4200|6500", "explore|60|45|1429|5000|5000", "explore|88|50|1429|5000|5000"]));
}

// The schema 1 bug: any spell C_TradeSkillUI.GetRecipeInfo answered for (combat spells, forms) was a craft.
#[test]
fn only_crafts_asked_for_in_the_player_s_own_trade_skill_window_are_crafts_never_forms_or_combat_spells() {
	let out = run(r#"
		stub.world.profession = 164
		stub.world.spellbook[768] = true
		stub.world.recipes = { [2660] = { output = 2862, quantity = 1 }, [3115] = { output = 3239, quantity = 1 }, [768] = { prof = 0 } }
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-0", 2660)   -- the window closed
		stub.fire("TRADE_SKILL_SHOW")
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-1", 768)    -- Cat Form, the window open
		stub.craft(768, 1)                                                -- asked for, but no recipe of the profession
		stub.craft(2660, 2, { itemID = 2862, quantity = 2 })
		stub.craft(3115, 1)                                               -- no result event: the schematic's item
		stub.advance(1.5)
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-3", 2660)   -- not asked for in the window
		stub.fire("UNIT_SPELLCAST_SUCCEEDED", "party1", "Cast-4", 2660)
		stub.world.tradeLinked = true
		stub.craft(2660, 1, { itemID = 2862, quantity = 1 })              -- someone's linked profession
		stub.world.tradeLinked = false
		stub.fire("TRADE_SKILL_CLOSE")
		stub.craft(2660, 1, { itemID = 2862, quantity = 1 })              -- the window closed again
		stub.advance(1.5)
		stub.fire("LEARNED_SPELL_IN_SKILL_LINE", 133, 2, false)
		stub.fire("NEW_RECIPE_LEARNED", 2660)
		stub.fire("LEARNED_SPELL_IN_SKILL_LINE", 2660, 3, false) -- the same recipe again: once
		stub.fire("ACHIEVEMENT_EARNED", 6)
		logout()
		emit({ recs = recs("craft learn achieve cast"), bad = malformed() })"#);
	assert_eq!(out["recs"], json!(["craft|2660|2862|2", "craft|2660|2862|2", "craft|3115|3239|1", "learn|133", "learn|2660", "achieve|6"]));
	assert_eq!(out["bad"], json!({}));
}

#[test]
fn quest_givers_and_enders_that_are_game_objects_or_items_are_recorded_with_their_kind_and_id() {
	let out = run(r#"
		stub.moveTo(41.8, 65.6)
		local poster = stub.gameObject(68, "Wanted Board")
		stub.offerQuest(176, poster, "Wanted Board", "Wanted: \"Hogger\"")
		stub.acceptQuest(176, { title = "Wanted: \"Hogger\"", level = 11, objectives = {} })
		stub.moveTo(50, 50)
		stub.turnIn(176, (stub.gameObject(1593, "Supply Crate")), "Supply Crate", 900, 0)
		-- an item-started quest fires QUEST_DETAIL twice: the item use, then its popup
		stub.moveTo(30, 70)
		stub.world.questID = 123
		stub.world.quests[123] = { title = "The Collector", level = 10, objectives = {} }
		stub.setUnit("npc", nil)
		stub.fire("QUEST_DETAIL", 1307)
		stub.moveTo(31, 71)
		stub.fire("QUEST_DETAIL")
		stub.acceptQuest(123, { title = "The Collector", level = 10, objectives = {} })
		logout()
		emit(recs("offer detail accept turnin"))"#);
	assert_eq!(
		out,
		json!([
			"offer|o|68|1429|4180|6560|176||||",
			"detail|176|o|68|1429|4180|6560|",
			"accept|176|o|68|1429|4180|6560|1||||",
			"turnin|176|o|1593|1429|5000|5000|1|900|0|",
			"detail|123|i|1307|1429|3000|7000|1307",
			"accept|123|i|1307|1429|3000|7000|1||||",
		])
	);
}
