//! Engine "Smart logic": accepts found unavailable at their giver (with reasons, dependent goals skipped, marks
//! cleared on level-up / turn-in), and farm-spot ranking for `collect … nearest`. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 1000, right = -1000, top = 1000, bottom = -3000 })
w.moveTo(1413, 50, 30)
w.race, w.faction, w.class, w.className, w.level = "Orc", "Horde", "WARRIOR", "Warrior", 12
w.titles[871] = "Disrupt the Attacks"; w.titles[872] = "Supplies for the Crossroads"; w.titles[870] = "The Forgotten Pools"
"#;

// Quest 872 needs 871 done (pre), 880 needs level 14, 870 is simply not offered (another chain), all from Thork
// (3429) at the Crossroads.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Crossroads", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
	{ title = "Thork", goals = {
		{ t = "accept", quest = 872, title = "Supplies for the Crossroads", npc = 3429, npcName = "Thork", pre = { 871 }, map = 1413, x = 51, y = 30 },
		{ t = "accept", quest = 880, title = "Altered Beings", npc = 3429, npcName = "Thork", minLevel = 14 },
		{ t = "accept", quest = 870, title = "The Forgotten Pools", npc = 3429, npcName = "Thork" },
		{ t = "accept", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog" },
	} },
	{ title = "Raptors", goals = {
		{ t = "kill", target = "Sunscale Lashtail", count = 7, quest = 872, oi = 1, map = 1413, x = 45, y = 20 },
		{ t = "collect", item = 5062, itemName = "Raptor Head", count = 12, quest = 869, oi = 1 },
	} },
	{ title = "Back", goals = {
		{ t = "turnin", quest = 872, title = "Supplies for the Crossroads", npc = 3429, npcName = "Thork" },
		{ t = "turnin", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog" },
	} },
	{ goals = { { t = "level", level = 30 } } },
} })
"#;

const HELPERS: &str = r#"			E = Polestar.Engine
			function flush() stub.advance(0.25) end
			function brief(i)
				local out = {}
				for g, v in ipairs(E.GetStepView(i).goals) do out[g] = v.status .. ":" .. tostring(v.unavailable) .. ":" .. tostring(v.unavailableText) end
				return out
			end
			stub.login()
			E.SetGuide("test/xr")
			Polestar.Set("behavior.autoAccept", false) -- the tests take quests themselves
			"#;

fn run(before: &str, guides: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{guides}\n{HELPERS}{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn accepts_their_giver_does_not_offer_for_a_reason_the_data_gives_are_skipped_with_it_one_the_data_does_not_explain_stays_open() {
	let out = run(
		"",
		GUIDE,
		r#"
			local w = stub.world
			local r = {}
			w.gossip(3429, { available = {} }); w.close(); flush()
			r.at = E.GetStepIndex()
			w.gossip(3464, { available = { { questID = 869 } } }); w.close(); w.accept(869, { 12 }); flush()
			r.step1 = brief(1)
			r.notice = E.GetStepView(1).goals[3].noticeText
			r.atAfter = E.GetStepIndex()
			r.step2 = brief(2)
			r.step3 = brief(3)
			r.wp = E.GetWaypoint() and E.GetWaypoint().goalIndex or false
			emit(r)
		"#,
	);
	// 870 is simply not offered: never a skip (Fitz, #741); the line asks for a report and the guide stays.
	assert_eq!(out["step1"], json!(["skipped:pre:Requires “Disrupt the Attacks” first", "na:nil:nil", "active:nil:nil", "done:nil:nil",]));
	assert_eq!(out["notice"], "Not offered by Thork? Report it with /polestar");
	assert_eq!(out["at"], 1); // Gazrog's accept still open
	assert_eq!(out["atAfter"], 1, "the guide stays at Thork");
	assert_eq!(out["wp"], 3, "the arrow on Thork's accept");
	assert_eq!(out["step2"], json!(["skipped:pre:Requires “Disrupt the Attacks” first", "pending:nil:nil"]));
	assert_eq!(out["step3"], json!(["skipped:pre:Requires “Disrupt the Attacks” first", "pending:nil:nil"]));
}

#[test]
fn another_npc_s_window_never_marks_an_accept_and_the_giver_offering_a_quest_clears_even_a_missing_prerequisite() {
	let out = run(
		"",
		GUIDE,
		r#"
			local w = stub.world
			w.gossip(9999, { available = {} }); w.close(); flush()
			local other = brief(1)
			w.gossip(3429, { available = { { questID = 872 }, { questID = 880 }, { questID = 870 } } }); w.close(); flush()
			emit({ other = other, offered = brief(1), at = E.GetStepIndex() })
		"#,
	);
	// 872's prerequisite (871) is missing and the guide never turns it in, and 880 needs level 14 (#1320): both
	// known before any visit. Thork's window offering them has the last word.
	assert_eq!(out["other"], json!(["skipped:pre:Requires “Disrupt the Attacks” first", "na:nil:nil", "active:nil:nil", "active:nil:nil"]));
	assert_eq!(out["offered"], json!(["active:nil:nil", "active:nil:nil", "active:nil:nil", "active:nil:nil"]));
	assert_eq!(out["at"], 1);
}

#[test]
fn a_detail_window_opened_from_the_giver_s_list_says_nothing_about_the_others_a_direct_one_does() {
	let out = run(
		"",
		GUIDE,
		r#"
			local w = stub.world
			-- The list offers everything; picking 870 opens its detail window.
			w.gossip(3429, { available = { { questID = 872 }, { questID = 880 }, { questID = 870 } } })
			w.questDetail(3429, 870); w.close(); flush()
			local fromList = brief(1)
			stub.advance(60)
			-- Later, Thork opens a detail window directly: only 870 is offered.
			w.questDetail(3429, 870); w.close(); flush()
			-- An item-started quest says nothing about Thork.
			w.questDetail(3429, 999, { startItem = 1234 }); w.close(); flush()
			emit({ fromList = fromList, direct = brief(1) })
		"#,
	);
	assert_eq!(out["fromList"], json!(["active:nil:nil", "active:nil:nil", "active:nil:nil", "active:nil:nil"]));
	assert_eq!(out["direct"], json!(["skipped:pre:Requires “Disrupt the Attacks” first", "na:nil:nil", "active:nil:nil", "active:nil:nil",]));
}

#[test]
fn the_follow_up_a_turn_in_pops_up_says_nothing_about_the_giver_s_other_quests_however_long_the_reward_was_read_regression_jorn_skyseer_passed_at_sergra_darkthorn() {
	let out = run(
		"w.onQuest(903, { 1 })",
		GUIDE,
		r#"
			local w = stub.world
			-- Thork offers the guide's quests and takes in 903, which is not in the guide.
			w.gossip(3429, { available = { { questID = 872 }, { questID = 880 }, { questID = 870 } }, active = { { questID = 903, isComplete = true } } })
			w.questComplete(3429, 903); flush()
			stub.advance(45) -- reading the reward panel
			w.turnIn(903); flush()
			-- The client then shows 903's follow-up straight away; the player takes it.
			w.questDetail(3429, 904); flush()
			w.accept(904, { 1 }); w.close(); flush()
			emit({ step = brief(1), at = E.GetStepIndex() })
		"#,
	);
	assert_eq!(out["step"], json!(["active:nil:nil", "active:nil:nil", "active:nil:nil", "active:nil:nil"]));
	assert_eq!(out["at"], 1);
}

#[test]
fn t_161_in_a_step_the_guide_has_moved_past_a_level_up_or_a_turn_in_brings_back_what_the_data_says_has_opened_level_prerequisite() {
	let out = run(
		"",
		GUIDE,
		r#"
			local w = stub.world
			w.gossip(3429, { available = { { questID = 870 } } }); w.accept(870, {}); w.close()
			w.gossip(3464, { available = { { questID = 869 } } }); w.close(); w.accept(869, { 12 }); flush()
			local r = { before = E.GetStepIndex() }
			w.setLevel(13); flush()
			r.level13 = { E.GetStepIndex(), brief(1) }
			w.setLevel(14); flush()
			r.level14 = { E.GetStepIndex(), brief(1) }
			w.gossip(3429, { available = { { questID = 880 } } }); w.accept(880, {}); w.close(); flush()
			r.taken = E.GetStepIndex()
			w.complete({ 871 }); w.turnIn(500); flush()
			r.turnIn = { E.GetStepIndex(), brief(1) }
			emit(r)
		"#,
	);
	assert_eq!(out["before"], 2);
	assert_eq!(out["level13"], json!([2, ["skipped:pre:Requires “Disrupt the Attacks” first", "na:nil:nil", "done:nil:nil", "done:nil:nil",]]), "still at the raptors: 880 still needs level 14");
	assert_eq!(out["level14"], json!([1, ["skipped:pre:Requires “Disrupt the Attacks” first", "active:nil:nil", "done:nil:nil", "done:nil:nil",]]), "level 14: back to Thork for 880");
	assert_eq!(out["taken"], 2);
	assert_eq!(out["turnIn"], json!([1, ["active:nil:nil", "done:nil:nil", "done:nil:nil", "done:nil:nil",]]), "871 done: back to Thork for 872");
}

#[test]
fn t_161_a_level_up_or_a_turn_in_clears_the_marks_of_the_step_at_hand_so_its_giver_is_asked_again() {
	let out = run(
		"",
		GUIDE,
		r#"
			local w = stub.world
			w.gossip(3429, { available = {} }); w.close(); flush()
			local r = { before = { E.GetStepIndex(), brief(1) } }
			w.setLevel(14); flush()
			r.levelUp = { E.GetStepIndex(), brief(1) }
			w.gossip(3429, { available = {} }); w.close(); flush()
			w.complete({ 871 }); w.turnIn(500); flush()
			r.turnIn = { E.GetStepIndex(), brief(1) }
			emit(r)
		"#,
	);
	// Gazrog's 869 is still to take: Thork's step is the one at hand. 870, not listed, is never a skip.
	assert_eq!(out["before"], json!([1, ["skipped:pre:Requires “Disrupt the Attacks” first", "na:nil:nil", "active:nil:nil", "active:nil:nil",]]));
	// 872 keeps its missing prerequisite (known from the data) until 871 is done.
	assert_eq!(out["levelUp"], json!([1, ["skipped:pre:Requires “Disrupt the Attacks” first", "active:nil:nil", "active:nil:nil", "active:nil:nil"]]));
	assert_eq!(out["turnIn"], json!([1, ["active:nil:nil", "active:nil:nil", "active:nil:nil", "active:nil:nil"]]));
}

#[test]
fn t_161_741_a_quest_the_giver_refused_although_the_data_allows_it_holds_the_guide_at_that_giver_until_offered() {
	// Dalar (1938) at the Sepulcher: 98299's data says level 9, the server wants more.
	let guides = r#"
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Silverpine", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
		{ title = "The Sepulcher", goals = {
			{ t = "accept", quest = 98299, title = "Stop the Spread", npc = 1938, npcName = "Dalar Dawnweaver", minLevel = 9 },
		} },
		{ goals = { { t = "level", level = 30 } } },
	} })"#;
	let out = run(
		"",
		guides,
		r#"
			local w = stub.world
			w.gossip(1938, { available = {} }); w.close(); flush()
			local r = { refused = { E.GetStepIndex(), brief(1)[1], E.GetStepView(1).goals[1].noticeText } }
			w.setLevel(13); flush()
			r.levelUp = E.GetStepIndex()
			w.gossip(1938, { available = { { questID = 98299 } } }); flush()
			r.offered = E.GetStepView(1).goals[1].noticeText or false
			w.accept(98299, {}); w.close(); flush()
			r.taken = E.GetStepIndex()
			emit(r)
		"#,
	);
	assert_eq!(out["refused"], json!([1, "active:nil:nil", "Not offered by Dalar Dawnweaver? Report it with /polestar"]), "the guide stays at Dalar");
	assert_eq!(out["levelUp"], 1);
	assert_eq!(out["offered"], false, "his window listing it ends the notice");
	assert_eq!(out["taken"], 2);
}

#[test]
fn t_127_a_quest_the_giver_s_window_lists_as_active_is_taken_not_refused_before_the_log_has_it_accepting_clears_the_notice() {
	let out = run(
		"",
		GUIDE,
		r#"
			local w = stub.world
			local r = {}
			local function notice() return E.GetStepView(1).goals[3].noticeText or false end
			-- After Accept, the gossip comes back with 870 active a moment before the quest log has it.
			w.gossip(3429, { available = {}, active = { { questID = 870 } } }); flush()
			r.refresh = { brief(1)[3], notice() }
			w.close(); w.accept(870, {}); flush()
			w.abandon(870); flush()
			r.abandoned = { brief(1)[3], notice() }
			-- A notice set earlier goes when the quest is accepted.
			w.gossip(3429, { available = {} }); w.close(); flush()
			r.marked = { brief(1)[3], notice() }
			w.accept(870, {}); flush()
			w.abandon(870); flush()
			r.reaccepted = { brief(1)[3], notice() }
			emit(r)
		"#,
	);
	assert_eq!(out["refresh"], json!(["active:nil:nil", false]));
	assert_eq!(out["abandoned"], json!(["active:nil:nil", false]));
	assert_eq!(out["marked"], json!(["active:nil:nil", "Not offered by Thork? Report it with /polestar"]));
	assert_eq!(out["reaccepted"], json!(["active:nil:nil", false]));
}

#[test]
fn t_1762_a_giver_whose_window_lists_no_quest_but_has_a_chat_option_says_to_try_it_its_detail_window_clears_the_line() {
	// #1762 (0.3.6): Sovik's window lists no quest. Chief Engineer Scooty (2842) sits behind his chat option
	// (gossip option 95758; 11 people in the recordings took it that way, none from the list). The line said
	// "Not offered by Sovik? Report it with /polestar".
	let guide = r#"
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Gnomeregan", faction = "Horde", minLevel = 10, maxLevel = 40, steps = {
		{ title = "Sovik", goals = { { t = "accept", quest = 2842, title = "Chief Engineer Scooty", npc = 3413, npcName = "Sovik" } } },
		{ goals = { { t = "level", level = 40 } } },
	} })"#;
	let out = run(
		"",
		guide,
		r#"
			local w = stub.world
			local r = {}
			local function notice() return E.GetStepView(1).goals[1].noticeText or false end
			local goods = { name = "I want to browse your goods.", gossipOptionID = 93031361, icon = 132060 }
			local chat = { name = "Chat", gossipOptionID = 95758, icon = 132053 }
			w.gossip(3413, { options = { goods, chat } }); flush()
			r.list = { brief(1)[1], notice() }
			-- The chat option opens the quest.
			C_GossipInfo.SelectOption(95758); w.questDetail(3413, 2842); flush()
			r.detail = { brief(1)[1], notice() }
			w.close(); flush()
			-- A window with only his goods leaves nothing to try.
			w.gossip(3413, { options = { goods } }); w.close(); flush()
			r.goods = { brief(1)[1], notice() }
			-- A chat option known only by its override icon counts the same.
			w.gossip(3413, { options = { goods, { name = "Chat", gossipOptionID = 95758, icon = 132060, overrideIconID = 132053 } } }); w.close(); flush()
			r.override = { brief(1)[1], notice() }
			emit(r)
		"#,
	);
	let chat = "Not in Sovik's quest list: try a chat option, or report it with /polestar if none offers it";
	assert_eq!(out["list"], json!(["active:nil:nil", chat]), "never a skip; the chat option comes first");
	assert_eq!(out["detail"], json!(["active:nil:nil", false]), "the quest's window from his chat option ends the line");
	assert_eq!(out["goods"], json!(["active:nil:nil", "Not offered by Sovik? Report it with /polestar"]));
	assert_eq!(out["override"], json!(["active:nil:nil", chat]));
}

#[test]
fn prerequisites_every_preall_must_be_done_one_pre_suffices_the_text_names_the_missing_one() {
	// 890 needs 871 and 873 (preAll); 891 needs 871 or 873 (pre). Only 871 is done.
	let guide = r#"
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Crossroads", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
		{ title = "Thork", goals = {
			{ t = "accept", quest = 890, title = "Both First", npc = 3429, npcName = "Thork", preAll = { 871, 873 }, preTitles = { [873] = "The Other Errand" } },
			{ t = "accept", quest = 891, title = "Either First", npc = 3429, npcName = "Thork", pre = { 871, 873 } },
		} },
		{ goals = { { t = "level", level = 30 } } },
	} })"#;
	let out = run(
		"stub.world.complete({ 871 })",
		guide,
		r#"
			local w = stub.world
			w.gossip(3429, { available = {} }); w.close(); flush()
			emit(brief(1))
		"#,
	);
	// 891's one prerequisite is done: its refusal the data does not explain, so it stays open.
	assert_eq!(out, json!(["skipped:pre:Requires “The Other Errand” first", "active:nil:nil"]));
}

// Issue #70 (The Barrens 19-24, step 9): Sergra Darkthorn's Jorn Skyseer (3261) needs The Angry Scytheclaws
// (905), the end of her chain in the earlier Barrens guide. Jorn's Ishamuhale (882) follows Jorn Skyseer.
const CROSSROADS: &str = r#"
Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "The Barrens", faction = "Horde", minLevel = 19, maxLevel = 24, steps = {
	{ title = "The Crossroads", goals = {
		{ t = "accept", quest = 899, title = "Consumed by Hatred", npc = 3432, npcName = "Mankrik", map = 1413, x = 51.95, y = 31.58 },
		{ t = "accept", quest = 3261, title = "Jorn Skyseer", npc = 3338, npcName = "Sergra Darkthorn", pre = { 905 }, preTitles = { [905] = "The Angry Scytheclaws" }, map = 1413, x = 52.23, y = 31.01 },
		{ t = "accept", quest = 3281, title = "Stolen Silver", npc = 3464, npcName = "Gazrog", map = 1413, x = 51.93, y = 30.32 },
	} },
	{ title = "Camp Taurajo", goals = {
		{ t = "turnin", quest = 3261, title = "Jorn Skyseer", npc = 3387, npcName = "Jorn Skyseer", map = 1413, x = 44.86, y = 59.14 },
		{ t = "accept", quest = 882, title = "Ishamuhale", npc = 3387, npcName = "Jorn Skyseer", pre = { 3261 }, map = 1413, x = 44.86, y = 59.14 },
	} },
	{ goals = { { t = "level", level = 30 } } },
} })"#;

const AT_SERGRA: &str = r#"
	local w = stub.world
	local function look()
		local wp = E.GetWaypoint()
		return { E.GetStepIndex(), E.GetStepView(E.GetStepIndex()).focus or false, wp and wp.goalIndex or false }
	end
	-- Placed at the Crossroads (the quest log is read): from here on, live play.
	stub.fire("QUEST_LOG_UPDATE"); flush()
	w.accept(899, {}); flush()
	local r = { mankrikDone = look(), step1 = brief(1), step2 = brief(2) }
	w.accept(3281, {}); flush()
	r.gazrogDone = look()
"#;

#[test]
fn t_70_an_accept_whose_prerequisite_is_missing_does_not_hold_the_focus_or_the_arrow_with_or_without_a_visit_done_it_does() {
	let missing = run(
		"",
		CROSSROADS,
		&(AT_SERGRA.to_string()
			+ r#"
			-- A turn-in that opens nothing here does not bring it back.
			w.turnIn(500); flush()
			r.unrelated = look()
			-- The Angry Scytheclaws handed in: Sergra's quest is live again.
			w.onQuest(905, {}); w.turnIn(905); flush()
			r.preDone = { look(), brief(1)[2] }
			emit(r)"#),
	);
	// Mankrik, Sergra, Gazrog: the focus and the arrow go from Mankrik to Gazrog.
	assert_eq!(missing["mankrikDone"], json!([1, 3, 3]));
	assert_eq!(missing["step1"], json!(["done:nil:nil", "skipped:pre:Requires “The Angry Scytheclaws” first", "active:nil:nil"]));
	// Jorn Skyseer's turn-in goes with it, and so does the quest after it.
	assert_eq!(missing["step2"], json!(["skipped:pre:Requires “The Angry Scytheclaws” first", "skipped:pre:Requires “Jorn Skyseer” first"]));
	assert_eq!(missing["gazrogDone"], json!([3, 1, false]));
	assert_eq!(missing["unrelated"], json!([3, 1, false]));
	assert_eq!(missing["preDone"], json!([[1, 2, 2], "active:nil:nil"]));

	let done = run("stub.world.complete({ 905 })", CROSSROADS, &format!("{AT_SERGRA} emit(r)"));
	assert_eq!(done["mankrikDone"], json!([1, 2, 2]));
	assert_eq!(done["step1"], json!(["done:nil:nil", "active:nil:nil", "active:nil:nil"]));
	assert_eq!(done["step2"], json!(["pending:nil:nil", "pending:nil:nil"]));
	assert_eq!(done["gazrogDone"], json!([1, 2, 2]));
}

#[test]
fn a_missing_prerequisite_the_guide_still_turns_in_before_the_accept_or_after_it_leaves_the_accept_to_its_giver_skipping_that_turn_in_does_not() {
	// Thork's 872 needs 871 (pre). Taken before 871 is handed in (against lint's order: a data error or a
	// guide's), then 5041 after it, by the rule.
	let guide = r#"
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Crossroads", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
		{ title = "Thork", goals = {
			{ t = "accept", quest = 871, title = "Disrupt the Attacks", npc = 3429, npcName = "Thork", map = 1413, x = 51, y = 30 },
			{ t = "accept", quest = 872, title = "Supplies for the Crossroads", npc = 3429, npcName = "Thork", pre = { 871 }, map = 1413, x = 51, y = 30 },
		} },
		{ title = "Back", goals = {
			{ t = "turnin", quest = 871, title = "Disrupt the Attacks", npc = 3429, npcName = "Thork", map = 1413, x = 51, y = 30 },
			{ t = "accept", quest = 5041, title = "Supplies for the Crossroads", npc = 3429, npcName = "Thork", pre = { 871 }, map = 1413, x = 51, y = 30 },
		} },
		{ goals = { { t = "level", level = 30 } } },
	} })"#;
	let out = run(
		"",
		guide,
		r#"
			local w = stub.world
			-- Placed at Thork (the quest log is read), then 871 is taken.
			stub.fire("QUEST_LOG_UPDATE"); flush()
			w.accept(871, {}); flush()
			local r = { step1 = brief(1), step2 = brief(2), wp = E.GetWaypoint().goalIndex }
			-- The player skips the step that hands 871 in.
			E.Next(); E.Skip(); flush()
			r.skipped = { E.GetLiveStep(), brief(1) }
			emit(r)"#,
	);
	assert_eq!(out["step1"], json!(["done:nil:nil", "active:nil:nil"]));
	assert_eq!(out["step2"], json!(["pending:nil:nil", "pending:nil:nil"]));
	assert_eq!(out["wp"], 2);
	// Nothing left to do at Thork: the guide goes past the skipped step.
	assert_eq!(out["skipped"], json!([3, ["done:nil:nil", "skipped:pre:Requires “Disrupt the Attacks” first"]]));
}

#[test]
fn a_prerequisite_the_guide_has_only_for_other_characters_is_another_version_of_the_chain_the_accept_stays_open_for_the_giver_to_decide() {
	// The paladin charger: Emphasis on Sacrifice (7637) names the Human Lord Grayson Shadowbreaker (7638) only;
	// the Dwarf's (7670) is missing from the data. Here the character is an Orc, and 7670 stands for their own
	// version.
	let guide = r#"
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Charger", minLevel = 10, maxLevel = 60, steps = {
		{ title = "Grayson", goals = {
			{ t = "accept", quest = 7638, title = "Lord Grayson Shadowbreaker", npc = 1, npcName = "Duthorian Rall", only = { races = { "Human" } }, map = 1413, x = 51, y = 30 },
			{ t = "turnin", quest = 7638, title = "Lord Grayson Shadowbreaker", npc = 2, npcName = "Lord Grayson", only = { races = { "Human" } }, map = 1413, x = 51, y = 30 },
			{ t = "turnin", quest = 7670, title = "Lord Grayson Shadowbreaker", npc = 2, npcName = "Lord Grayson", only = { races = { "Orc" } }, map = 1413, x = 51, y = 30 },
			{ t = "accept", quest = 7637, title = "Emphasis on Sacrifice", npc = 2, npcName = "Lord Grayson", pre = { 7638 }, map = 1413, x = 51, y = 30 },
		} },
		{ goals = { { t = "level", level = 60 } } },
	} })"#;
	let out = run("stub.world.onQuest(7670, {})", guide, r#"stub.fire("QUEST_LOG_UPDATE"); flush(); emit(brief(1))"#);
	assert_eq!(out, json!(["na:nil:nil", "na:nil:nil", "active:nil:nil", "active:nil:nil"]));
}

#[test]
fn an_accept_closed_for_good_its_breadcrumb_target_or_an_exclusive_quest_taken_or_done_is_skipped_before_any_visit_with_the_quest_s_later_goals() {
	// 1483 leads to 1093 (a breadcrumb); 1507 is exclusive with 1472 (the Undercity version of the chain).
	let guide = r#"
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Ratchet", faction = "Horde", minLevel = 10, maxLevel = 30, steps = {
		{ title = "Givers", goals = {
			{ t = "accept", quest = 1483, title = "Ziz Fizziks", npc = 3442, npcName = "Sputtervalve", closedBy = { 1093 }, preTitles = { [1093] = "Super Reaper 6000" }, map = 1413, x = 62, y = 37 },
			{ t = "accept", quest = 1507, title = "Devourer of Souls", npc = 5875, npcName = "Gan'rul Bloodeye", closedBy = { 1472 }, preTitles = { [1472] = "Devourer of Souls" } },
		} },
		{ title = "Ziz", goals = { { t = "turnin", quest = 1483, title = "Ziz Fizziks", npc = 4201, npcName = "Ziz Fizziks" } } },
		{ goals = { { t = "level", level = 30 } } },
	} })"#;
	let script = "emit({ at = E.GetStepIndex(), step1 = brief(1), step2 = brief(2), wp = E.GetWaypoint() and E.GetWaypoint().stepIndex or false })";
	let closed = run("stub.world.complete({ 1093 }); stub.world.onQuest(1472, {})", guide, script);
	assert_eq!(
		closed,
		json!({
			"at": 3,
			"step1": ["skipped:closed:No longer offered: you took “Super Reaper 6000”", "skipped:closed:No longer offered: you took “Devourer of Souls”"],
			"step2": ["skipped:closed:No longer offered: you took “Super Reaper 6000”"],
			"wp": false,
		})
	);
	let open = run("", guide, script);
	assert_eq!(open["step1"], json!(["active:nil:nil", "active:nil:nil"]));
	assert_eq!(open["at"], 1);
}

// #1661: Valik (535) is a child of Infiltration (533): Henchman Valik offers it only while 533 is in the log. Step 2
// is the Hillsbrad guide's Valik step (`when onquest 533`). ${valik} is step 2's `when`.
const VALIK: &str = r#"
Polestar.RegisterGuide({ id = "test/valik", pack = "test", title = "Hillsbrad", faction = "Horde", minLevel = 10, maxLevel = 40, steps = {
	{ title = "Krusk", goals = { { t = "accept", quest = 533, title = "Infiltration", npc = 2229, npcName = "Krusk", pre = { 498 }, preTitles = { [498] = "The Rescue" }, map = 1413, x = 50, y = 30 } } },
	{ title = "Henchman Valik", when = ${valik}, goals = {
		{ t = "accept", quest = 535, title = "Valik", npc = 2333, npcName = "Henchman Valik", parent = 533, preTitles = { [533] = "Infiltration" }, map = 1413, x = 57, y = 69 },
		{ t = "turnin", quest = 535, title = "Valik", npc = 2333, npcName = "Henchman Valik" },
	} },
	{ title = "Krusk", goals = { { t = "turnin", quest = 533, title = "Infiltration", npc = 2229, npcName = "Krusk" } } },
	{ goals = { { t = "level", level = 40 } } },
} })"#;

// The guide loaded from the saved variables (`saved`: CharState fields), the quest log read.
fn valik(when: &str, before: &str, saved: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), format!(r#"PolestarCharDB = {{ schema = 1, guide = "test/valik"{saved} }}"#))],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			&VALIK.replace("${valik}", when),
			r#"E = Polestar.Engine
			function brief(i)
				local out = {}
				for g, v in ipairs(E.GetStepView(i).goals) do out[g] = v.status .. ":" .. tostring(v.unavailable) .. ":" .. tostring(v.unavailableText) end
				return out
			end
			stub.login(); stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			script,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0)
}

const ONQUEST: &str = r#"{ { k = "onquest", q = { 533 } } }"#;
const SCRIPT: &str = "emit({ at = E.GetLiveStep(), valik = brief(2) })";

#[test]
fn t_1661_a_child_quest_whose_parent_is_handed_in_is_closed_for_good_even_in_a_step_whose_when_was_stored_as_held() {
	// The reporter's route passed the Valik step while carrying Infiltration (stored as held), then handed
	// Infiltration in with the camp's missive: back on the guide, it sent them to "Accept Valik" for good.
	let held = r#", when = { ["test/valik"] = { [2] = true } }"#;
	let closed = valik(ONQUEST, "stub.world.complete({ 533 })", held, SCRIPT);
	let text = "skipped:closed:Only before “Infiltration” is handed in";
	assert_eq!(closed, json!({ "at": 4, "valik": [text, text] }));
	// Carrying Infiltration, Valik is the live step as before.
	let open = valik(ONQUEST, "stub.world.onQuest(533, { 0 })", "", SCRIPT);
	assert_eq!(open["at"], 2);
	assert_eq!(open["valik"][0], "active:nil:nil");
}

#[test]
fn t_1661_a_child_quest_whose_parent_is_not_in_the_log_and_that_the_route_no_longer_brings_is_passed() {
	// No `when` on the step (Chapter I to IV in Stranglethorn are written so); Infiltration left out, its
	// prerequisite The Rescue missing (#1636's player).
	let out = valik("nil", "", "", SCRIPT);
	let text = "skipped:pre:Only with “Infiltration” in your quest log";
	assert_eq!(out, json!({ "at": 4, "valik": [text, text] }));
	// The Rescue done: Infiltration is the route's own business, and Valik keeps his place behind it.
	let rescued = valik("nil", "stub.world.complete({ 498 })", "", SCRIPT);
	assert_eq!(json!([rescued["at"], &rescued["valik"][0]]), json!([1, "pending:nil:nil"]));
}

#[test]
fn when_a_mark_moves_the_guide_on_the_guide_window_says_which_quest_was_skipped_and_why_a_normal_completion_says_nothing() {
	let guide = r#"
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Crossroads", faction = "Horde", minLevel = 10, maxLevel = 30, steps = {
		{ title = "Thork", goals = { { t = "accept", quest = 870, title = "The Forgotten Pools", npc = 3429, npcName = "Thork", closedBy = { 871 }, preTitles = { [871] = "Disrupt the Attacks" }, map = 1413, x = 51.5, y = 30.3 } } },
		{ title = "Gazrog", goals = { { t = "accept", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog", map = 1413, x = 51.9, y = 30.8 } } },
		{ goals = { { t = "level", level = 30 } } },
	} })"#;
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			guide,
			r#"			local E, w = Polestar.Engine, stub.world
			local B = Polestar.UI.GuideFrame.parts.banner
			local function banner() return B:IsShown() and B.Text:GetText() or false end
			stub.login()
			E.SetGuide("test/xr")
			stub.fire("QUEST_LOG_UPDATE") -- the client fills the quest log after login
			Polestar.Set("behavior.autoAccept", false)
			stub.advance(0.5)
			local r = { before = banner() }
			w.accept(871, {}); stub.advance(0.5) -- taken elsewhere: Thork never offers 870 again
			r.skipped = { E.GetStepIndex(), banner() }
			w.accept(869, {}); stub.advance(0.5)
			r.completed = { E.GetStepIndex(), banner() }
			emit(r)"#,
		]
		.join("\n"),
		..Default::default()
	});
	assert_eq!(
		out[0],
		json!({
			"before": false,
			"skipped": [2, "Skipped “The Forgotten Pools”  \u{b7}  No longer offered: you took “Disrupt the Attacks”"],
			"completed": [3, false],
		})
	);
}

// Farm spots for `collect 2589 x20 nearest` (Linen Cloth).
const FARM: &str = r#"
	Polestar.RegisterGuide({ id = "test/farm", pack = "test", title = "Linen", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
		{ goals = { { t = "collect", item = 2589, itemName = "Linen Cloth", count = 20, candidates = { SPOTS } } } },
		{ goals = { { t = "level", level = 60 } } },
	} })
"#;

const FARM_SCRIPT: &str = r#"			E = Polestar.Engine
			stub.login()
			E.SetGuide("test/farm")
			local v = E.GetStepView(1).goals[1]
			emit({ name = v.npcName or false, lvl = v.lvl or false, alts = v.alternatives, detail = v.detail or false })"#;

fn farm_pick(spots: &str, before: &str) -> Value {
	let farm = FARM.replace("SPOTS", spots);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: [TEST_PACK, TEST_SOURCE, &farm, FARM_SCRIPT].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn farm_spots_a_near_spot_at_the_right_level_beats_a_far_one_and_a_red_one() {
	let near = r#"{ npcName = "Near Quilboar", map = 1413, x = 52, y = 32, faction = "AH", lvl = { 11, 13 }, rate = 0.3, spawns = 10 }"#;
	let far = r#"{ npcName = "Far Quilboar", map = 1413, x = 50, y = 95, faction = "AH", lvl = { 11, 13 }, rate = 0.3, spawns = 10 }"#;
	let red = r#"{ npcName = "Red Raptors", map = 1413, x = 50, y = 31, faction = "AH", lvl = { 15, 17 }, rate = 0.9, spawns = 20 }"#;
	let out = farm_pick(&[far, red, near].join(", "), "");
	assert_eq!(out, json!({ "name": "Near Quilboar", "lvl": [11, 13], "alts": 1, "detail": "from Near Quilboar" }));
}

#[test]
fn farm_spots_drop_rate_spawn_density_and_grey_mobs_weigh_against_distance() {
	// Same place: the better drop rate wins.
	let rich = r#"{ npcName = "Rich", map = 1413, x = 55, y = 30, faction = "AH", lvl = { 12, 12 }, rate = 0.6, spawns = 8 }"#;
	let poor = r#"{ npcName = "Poor", map = 1413, x = 51, y = 30, faction = "AH", lvl = { 12, 12 }, rate = 0.1, spawns = 8 }"#;
	assert_eq!(farm_pick(&format!("{poor}, {rich}"), "")["name"], "Rich");
	// Sparse spawns are slower to farm.
	let sparse = r#"{ npcName = "Sparse", map = 1413, x = 51, y = 30, faction = "AH", lvl = { 12, 12 }, rate = 0.3, spawns = 1 }"#;
	let dense = r#"{ npcName = "Dense", map = 1413, x = 56, y = 30, faction = "AH", lvl = { 12, 12 }, rate = 0.3, spawns = 12 }"#;
	assert_eq!(farm_pick(&format!("{sparse}, {dense}"), "")["name"], "Dense");
	// Grey mobs die fast: at level 30 the grey spot beats an even-level one with the same rate.
	let grey = r#"{ npcName = "Grey", map = 1413, x = 56, y = 30, faction = "AH", lvl = { 10, 12 }, rate = 0.3, spawns = 8 }"#;
	let even = r#"{ npcName = "Even", map = 1413, x = 51, y = 30, faction = "AH", lvl = { 29, 31 }, rate = 0.3, spawns = 8 }"#;
	assert_eq!(farm_pick(&format!("{even}, {grey}"), "stub.world.level = 30")["name"], "Grey");
	// Only too-high spots: still a target, the smallest level gap first, then farm cost.
	let higher = r#"{ npcName = "Higher", map = 1413, x = 51, y = 30, faction = "AH", lvl = { 25, 27 }, rate = 0.9, spawns = 20 }"#;
	let high = r#"{ npcName = "High", map = 1413, x = 52, y = 90, faction = "AH", lvl = { 18, 20 }, rate = 0.2, spawns = 4 }"#;
	let alliance = r#"{ npcName = "Alliance only", map = 1413, x = 51, y = 31, faction = "A", lvl = { 12, 12 }, rate = 0.9, spawns = 8 }"#;
	let only_red = farm_pick(&format!("{higher}, {alliance}, {high}"), "");
	assert_eq!(only_red, json!({ "name": "High", "lvl": [18, 20], "alts": 1, "detail": "from High" }));
}

// #1320 (Fall of Dun Modr): at level 24 the arrow led to an accept that needs level 25 until the player clicked
// the giver. An accept above the character's level is known in advance ("Requires level 25"): the route reaching it
// passes it, its objectives and turn-in wait with it, and the level-up brings the guide back to it. With nothing else
// left a leveling guide finishes (its end is its last step); a guide that is no leveling guide waits at the accept.
const DUN_MODR: &str = r#"
Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Wetlands", faction = "Horde", minLevel = 20, maxLevel = 30, steps = {
	{ title = "Gazrog", goals = { { t = "accept", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog", map = 1413, x = 52, y = 31 } } },
	{ title = "Dun Modr", goals = {
		{ t = "accept", quest = 90600, title = "Fall of Dun Modr", npc = 3429, npcName = "Thork", minLevel = 25, map = 1413, x = 51, y = 30 },
	} },
	{ title = "Raptors", goals = { { t = "collect", item = 5062, itemName = "Raptor Head", count = 12, quest = 869, oi = 1, map = 1413, x = 45, y = 20 } } },
	{ title = "Dun Modr's work", goals = { { t = "kill", target = "Dark Iron Raider", count = 8, quest = 90600, oi = 1, map = 1413, x = 40, y = 20 } } },
	{ title = "Back", goals = { { t = "turnin", quest = 90600, title = "Fall of Dun Modr", npc = 3429, npcName = "Thork", map = 1413, x = 51, y = 30 } } },
} })"#;

#[test]
fn an_accept_above_the_character_s_level_is_passed_with_requires_level_its_work_waits_and_the_level_up_brings_it_back_1320() {
	let script = r#"
			local w = stub.world
			local done = 0
			Polestar.On("GUIDE_COMPLETED", function() done = done + 1 end)
			local function wp() local p = E.GetWaypoint(); return p and (p.stepIndex .. ":" .. p.goalIndex) or false end
			local function at() return { E.GetStepIndex(), wp(), brief(2), brief(4), brief(5) } end
			-- The quest log read: placed (placement passes gated accepts before the start on its own), then played on.
			stub.fire("QUEST_LOG_UPDATE"); flush()
			w.accept(869, { 12 }); flush()
			local r = { low = at() }
			w.setLevel(25); flush()
			r.ding = at()
			w.accept(90600, { 8 }); flush()
			r.taken = at()
			r.completed = done
			emit(r)
		"#;
	let out = run("w.level = 24", DUN_MODR, script);
	let held = json!(["skipped:level:Requires level 25"]);
	// Fitz, 0.3.6: the accept itself is no task while it waits (no level text on pick-ups).
	assert_eq!(out["low"], json!([3, "3:1", ["na:nil:nil"], held, held]), "level 24: Thork's accept passed, not shown, on to the raptors; its kill and turn-in wait with it");
	assert_eq!(out["ding"], json!([2, "2:1", ["active:nil:nil"], ["pending:nil:nil"], ["pending:nil:nil"]]), "level 25: back to Thork, the arrow on the accept");
	assert_eq!(out["taken"][0], json!(3), "taken: on to the raptors");
	assert_eq!(json!([out["taken"][3], out["taken"][4]]), json!([["pending:nil:nil"], ["pending:nil:nil"]]), "its kill and turn-in still to do");
	assert_eq!(out["completed"], json!(0));

	// Everything else done at level 24: the leveling guide finishes, and the level-up brings Thork back.
	let finished = run(
		"w.level = 24; w.complete({ 869 })",
		DUN_MODR,
		r#"flush()
			local r = { E.GetStepIndex() or false, brief(2) }
			stub.world.setLevel(25); flush()
			r[3] = E.GetStepIndex() or false
			emit(r)"#,
	);
	assert_eq!(finished, json!([false, ["na:nil:nil"], 2]));
	// The same guide as no leveling guide (a dungeon's or an attunement's): it waits at Thork, not finished.
	let wait = run(
		"w.level = 24; w.complete({ 869 })",
		&DUN_MODR.replace(r#"title = "Wetlands","#, r#"title = "Wetlands", category = "Lookup","#),
		r#"local done = 0
			Polestar.On("GUIDE_COMPLETED", function() done = done + 1 end)
			flush()
			emit({ E.GetStepIndex(), brief(2), done })"#,
	);
	// Waiting there, the accept's level is the one thing the step says.
	assert_eq!(wait, json!([2, ["skipped:level:Requires level 25"], 0]));

	// The level reached: the accept leads as before.
	let level25 = run("w.level = 25", DUN_MODR, r#"stub.world.accept(869, { 12 }); flush(); local p = E.GetWaypoint(); emit({ E.GetStepIndex(), p and p.goalIndex or false, brief(2) })"#);
	assert_eq!(level25, json!([2, 1, ["active:nil:nil"]]));
}

// A leveling guide's dungeon run (`when dungeon`) is no step to move on to past an accept waiting for a level: the
// guide waits at the accept. Without the dungeon chosen the route passes it as above.
const RUN: &str = r#"
Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Orgrimmar", faction = "Horde", minLevel = 10, maxLevel = 30, steps = {
	{ title = "Gazrog", goals = { { t = "accept", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog", map = 1413, x = 52, y = 31 } } },
	{ title = "Thork", goals = {
		{ t = "accept", quest = 90601, title = "Searching for the Lost Satchel", npc = 3429, npcName = "Thork", minLevel = 25, map = 1413, x = 51, y = 30 },
	} },
	{ title = "Ragefire Chasm", when = { { k = "dungeon", map = 389, name = "Ragefire Chasm" } }, goals = {
		{ t = "goto", map = 1413, x = 20, y = 20, text = "Ragefire Chasm" },
	} },
	{ title = "Raptors", goals = { { t = "collect", item = 5062, itemName = "Raptor Head", count = 12, quest = 869, oi = 1, map = 1413, x = 45, y = 20 } } },
} })"#;

#[test]
fn a_dungeon_run_is_not_moved_on_to_past_an_accept_waiting_for_a_level_the_guide_waits_at_the_accept_1320() {
	let script = |chosen: &str| {
		format!(
			r#"
			{chosen}
			stub.fire("QUEST_LOG_UPDATE"); flush()
			stub.world.accept(869, {{ 12 }}); flush()
			emit({{ E.GetStepIndex(), brief(2) }})
		"#
		)
	};
	let run_chosen = run("w.level = 24", RUN, &script("E.ChooseDungeon(389, true)"));
	assert_eq!(run_chosen, json!([2, ["skipped:level:Requires level 25"]]), "the run chosen: the guide waits at Thork, saying why");
	let solo = run("w.level = 24", RUN, &script(""));
	assert_eq!(solo, json!([4, ["na:nil:nil"]]), "no run: on to the raptors");
}

// #1247: Engine.AcceptGate, what an accept's tooltip says the game asks first: the quest's minimum level (and
// whether the character is below it) and the prerequisites not handed in yet, every missing `preAll` by name and
// a `pre` list none of which is done as "A or B". Nothing once the quest is taken; nil for a goal that is no
// accept or an accept with nothing known.
const GATE_GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/gate", pack = "test", title = "Gate", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
	{ title = "Thork", goals = {
		{ t = "accept", quest = 872, title = "Supplies for the Crossroads", npc = 3429, npcName = "Thork", pre = { 871 } },
		{ t = "accept", quest = 880, title = "Altered Beings", npc = 3429, npcName = "Thork", minLevel = 14 },
		{ t = "accept", quest = 881, title = "Echeyakee", npc = 3429, npcName = "Thork", minLevel = 10, preAll = { 871, 875 }, pre = { 876, 877 } },
		{ t = "accept", quest = 870, title = "The Forgotten Pools", npc = 3429, npcName = "Thork" },
		{ t = "accept", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog", minLevel = 1 },
	} },
	{ title = "Raptors", goals = {
		{ t = "kill", target = "Sunscale Lashtail", count = 7, quest = 872, oi = 1, map = 1413, x = 45, y = 20 },
	} },
} })
"#;

const GATE_HELPERS: &str = r#"
	E = Polestar.Engine
	function flush() stub.advance(0.25) end
	function gate(s, g)
		local x = E.AcceptGate(s, g)
		if not x then return "nil" end
		return tostring(x.level) .. ":" .. tostring(x.short) .. ":" .. table.concat(x.needs, " | ")
	end
	stub.login()
	Polestar.Set("behavior.autoAccept", false)
	E.SetGuide("test/gate")
	flush()
"#;

#[test]
fn an_accept_s_gate_is_its_minimum_level_and_the_prerequisites_not_handed_in_yet() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}w.titles[875] = \"Bloodshot\"; w.titles[876] = \"Wharfmaster Dizzywig\"; w.titles[877] = \"Ziz Fizziks\""),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!(
			"{TEST_PACK}\n{TEST_SOURCE}\n{GATE_GUIDE}\n{GATE_HELPERS}{}",
			r#"
			local w = stub.world
			local r = {}
			r.before = { gate(1, 1), gate(1, 2), gate(1, 3), gate(1, 4), gate(1, 5), gate(2, 1), gate(9, 1) }
			w.setLevel(14); flush()
			w.complete({ 871, 877 }); w.accept(880); flush()
			r.after = { gate(1, 1), gate(1, 2), gate(1, 3) }
			emit(r)
		"#
		),
		..Default::default()
	})
	.remove(0);
	assert_eq!(
		out["before"],
		json!(["nil:false:Disrupt the Attacks", "14:true:", "10:false:Disrupt the Attacks | Bloodshot | Wharfmaster Dizzywig or Ziz Fizziks", "nil", "nil", "nil", "nil",]),
		"level 12: 880 needs 14, 881 its prerequisites; no data, a level of 1, a kill and no step: nil"
	);
	assert_eq!(out["after"], json!(["nil", "14:false:", "10:false:Bloodshot"]), "871 and one of 876/877 handed in, level 14 reached, 880 taken: only Bloodshot is left");
}

// Xaden's case on #1247: Crimson Crate Delivery's guide goal knows neither its level nor that Crocs of the Sky comes
// first; the quest database does, once it is loaded (the gate never loads it).
#[test]
fn an_accept_the_guide_knows_nothing_about_takes_its_level_and_prerequisites_from_the_loaded_quest_database() {
	let guide = r#"
Polestar.RegisterGuide({ id = "test/gate", pack = "test", title = "Wetlands", faction = "Horde", minLevel = 26, maxLevel = 30, steps = {
	{ title = "Halloran", goals = {
		{ t = "accept", quest = 98240, title = "Crimson Crate Delivery", npc = 1, npcName = "James Halloran" },
	} },
} })
"#;
	let script = r#"
			local w = stub.world
			local r = { unloaded = gate(1, 1) }
			-- Layout: title, level, minLevel, races, classes, faction, start, finish, startItem, pre.
			AddRecords("quests", {
				[98240] = { "Crimson Crate Delivery", 30, 29, nil, nil, nil, nil, nil, nil, { 98072 } },
				[98072] = { "Crocs of the Sky", 30, 26 },
			})
			Polestar.QuestDB.SetMeta({})
			r.loaded = gate(1, 1)
			w.complete({ 98072 })
			r.done = gate(1, 1)
			emit(r)
		"#;
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}w.level = 28"),
		addons: vec![Addon::name("Polestar")],
		script: format!("{}\n{TEST_PACK}\n{TEST_SOURCE}\n{guide}\n{GATE_HELPERS}{script}", forge_addontest::questdb::ADD_RECORDS_LUA),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["unloaded"], "nil", "not loaded: nothing known, and nothing loaded for it");
	assert_eq!(out["loaded"], "29:true:Crocs of the Sky");
	assert_eq!(out["done"], "29:true:", "Crocs of the Sky handed in: the level is left");
}

// #1531 (Horde Ashenvale): "collect Ursangous's Paw" sat beside "accept The Hunt Continues item 16303", a quest that
// needs The Hunt Begins (6383) first: the accept read "Requires The Hunt Begins first", but the arrow still sent the
// player to kill Ursangous for a paw only that quest wants. The item a quest starts from waits with the quest: it
// is unavailable for the same reason, and applies only while the accept does.
#[test]
fn a_quest_s_starting_item_waits_with_a_quest_that_cannot_be_taken_1531() {
	let guide = r#"
Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Ashenvale", faction = "Horde", minLevel = 10, maxLevel = 30, steps = {
	{ title = "Ursangous", goals = {
		{ t = "collect", item = 16303, itemName = "Ursangous's Paw", map = 1413, x = 40, y = 40 },
		{ t = "accept", quest = 23, title = "Ursangous's Paw", item = 16303, pre = { 6383 }, preAll = { 6383 } },
	} },
	{ title = "Trainer", goals = { { t = "train", npc = 3353, npcName = "Trainer", map = 1413, x = 52, y = 31 } } },
} })
"#;
	let out = run(
		"",
		guide,
		r#"
		stub.fire("QUEST_LOG_UPDATE"); flush()
		emit({ live = E.GetLiveStep(), ursangous = brief(1) })
	"#,
	);
	assert_eq!(out["live"], 2, "the paw is no work while its quest can't be taken: {out}");
	assert!(out["ursangous"][0].as_str().unwrap().starts_with("skipped:pre"), "{out}");
}

// #1724 (Fyurie, 0.3.6, Night Elf Warrior 38): "Engine.lua:6765: table index is nil". When the route moved past a
// step whose quest-starting item (a `collect` with no quest, beside its `accept … item`) waited with a quest that
// can't be taken, the passed-over notice keyed the collect's nil quest and stopped the evaluation. The item speaks
// for the quest it starts: the notice names that quest once.
#[test]
fn moving_past_a_quest_s_starting_item_names_the_quest_it_starts_no_nil_index_1724() {
	let guide = r#"
Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Arathi", faction = "Alliance", minLevel = 30, maxLevel = 40, steps = {
	{ title = "Syndicate", goals = {
		{ t = "collect", item = 3668, itemName = "Assassin's Contract", map = 1413, x = 40, y = 40 },
		{ t = "accept", quest = 522, title = "Assassin's Plot", item = 3668, closedBy = { 95 }, preTitles = { [95] = "Sven's Revenge" } },
	} },
	{ title = "Trainer", goals = { { t = "train", npc = 3353, npcName = "Trainer", map = 1413, x = 52, y = 31 } } },
} })
"#;
	let out = run(
		"",
		guide,
		r#"
		local w = stub.world
		local events = {}
		Polestar.On("STEP_SKIPPED", function(from, to, skips)
			local quests = {}
			for i, k in ipairs(skips) do quests[i] = tostring(k.quest) .. ":" .. tostring(k.title) .. ":" .. tostring(k.reason) end
			events[#events + 1] = { from = from, to = to, quests = quests }
		end)
		stub.fire("QUEST_LOG_UPDATE"); flush()
		local start = E.GetLiveStep()
		-- Taking the quest that closes it for good: the contract no longer leads anywhere and the route moves on.
		local ok, err = pcall(function() w.accept(95, { 1 }); flush(); flush() end)
		emit({ start = start, ok = ok, err = tostring(err), live = E.GetLiveStep(), events = events })
	"#,
	);
	assert_eq!(out["start"], 1, "{out}");
	assert_eq!(out["ok"], true, "no Lua error: {out}");
	assert_eq!(out["live"], 2, "{out}");
	assert_eq!(out["events"], json!([{ "from": 1, "to": 2, "quests": ["522:Assassin's Plot:closed"] }]), "{out}");
}
