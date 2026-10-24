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
fn accepts_their_giver_does_not_offer_are_skipped_with_a_reason_the_same_quest_s_later_goals_too() {
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
			r.atAfter = E.GetStepIndex()
			r.step2 = brief(2)
			r.step3 = brief(3)
			r.wp = E.GetWaypoint() and E.GetWaypoint().goalIndex or false
			emit(r)
		"#,
	);
	assert_eq!(out["step1"], json!(["skipped:pre:Requires Disrupt the Attacks first", "skipped:level:Requires level 14", "skipped:offer:Not offered by Thork", "done:nil:nil",]));
	assert_eq!(out["at"], 1); // Gazrog's accept still open
	assert_eq!(out["atAfter"], 2);
	assert_eq!(out["step2"], json!(["skipped:pre:Requires Disrupt the Attacks first", "active:nil:nil"]));
	assert_eq!(out["step3"], json!(["skipped:pre:Requires Disrupt the Attacks first", "pending:nil:nil"]));
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
	// 872's prerequisite (871) is missing and the guide never turns it in: known before any visit. Thork's window
	// offering it has the last word.
	assert_eq!(out["other"], json!(["skipped:pre:Requires Disrupt the Attacks first", "active:nil:nil", "active:nil:nil", "active:nil:nil"]));
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
	assert_eq!(out["direct"], json!(["skipped:pre:Requires Disrupt the Attacks first", "skipped:level:Requires level 14", "active:nil:nil", "active:nil:nil",]));
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
fn t_161_in_a_step_the_guide_has_moved_past_a_level_up_or_a_turn_in_brings_back_what_the_data_says_has_opened_level_prerequisite_never_what_the_giver_refused() {
	let out = run(
		"",
		GUIDE,
		r#"
			local w = stub.world
			w.gossip(3429, { available = {} }); w.close()
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
	assert_eq!(
		out["level13"],
		json!([2, ["skipped:pre:Requires Disrupt the Attacks first", "skipped:level:Requires level 14", "skipped:offer:Not offered by Thork", "done:nil:nil",]]),
		"still at the raptors: 880 still needs level 14"
	);
	assert_eq!(
		out["level14"],
		json!([1, ["skipped:pre:Requires Disrupt the Attacks first", "active:nil:nil", "skipped:offer:Not offered by Thork", "done:nil:nil",]]),
		"level 14: back to Thork for 880; 870, which he refused, stays passed"
	);
	assert_eq!(out["taken"], 2);
	assert_eq!(out["turnIn"], json!([1, ["active:nil:nil", "done:nil:nil", "skipped:offer:Not offered by Thork", "done:nil:nil",]]), "871 done: back to Thork for 872; 870 stays passed");
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
	// Gazrog's 869 is still to take: Thork's step is the one at hand.
	assert_eq!(out["before"], json!([1, ["skipped:pre:Requires Disrupt the Attacks first", "skipped:level:Requires level 14", "skipped:offer:Not offered by Thork", "active:nil:nil",]]));
	// 872 keeps its missing prerequisite (known from the data) until 871 is done.
	assert_eq!(out["levelUp"], json!([1, ["skipped:pre:Requires Disrupt the Attacks first", "active:nil:nil", "active:nil:nil", "active:nil:nil"]]));
	assert_eq!(out["turnIn"], json!([1, ["active:nil:nil", "active:nil:nil", "active:nil:nil", "active:nil:nil"]]));
}

#[test]
fn t_161_a_quest_the_giver_refused_although_the_data_allows_it_a_server_level_gate_the_data_lacks_is_re_offered_when_the_route_next_meets_that_giver() {
	// Dalar (1938) at the Sepulcher: 98299's data says level 9, the server wants more. The route comes back to
	// Dalar later for a turn-in.
	let guides = r#"
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Silverpine", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
		{ title = "The Sepulcher", goals = {
			{ t = "accept", quest = 98299, title = "Stop the Spread", npc = 1938, npcName = "Dalar Dawnweaver", minLevel = 9 },
		} },
		{ title = "Ambermill", goals = {
			{ t = "collect", item = 5062, itemName = "Raptor Head", count = 12, quest = 869, oi = 1 },
		} },
		{ title = "Back to the Sepulcher", goals = {
			{ t = "turnin", quest = 869, title = "Raptor Thieves", npc = 1938, npcName = "Dalar Dawnweaver" },
		} },
		{ goals = { { t = "level", level = 30 } } },
	} })"#;
	let out = run(
		"w.onQuest(869, { 12 })",
		guides,
		r#"
			local w = stub.world
			Polestar.Set("behavior.autoTurnin", false) -- the player hands 869 in themselves
			w.gossip(1938, { available = {} }); w.close(); flush()
			local r = { refused = E.GetStepIndex() }
			w.setLevel(13); flush()
			r.levelUp = { E.GetStepIndex(), brief(1)[1] }
			w.turnIn(500); flush()
			r.turnIn = E.GetStepIndex()
			w.progress(869, 1, 12); flush()
			r.back = E.GetStepIndex()
			w.gossip(1938, { available = { { questID = 98299 } }, active = { { questID = 869, isComplete = true } } }); flush()
			r.offered = E.GetStepIndex()
			w.accept(98299, {}); w.close(); flush()
			r.taken = E.GetStepIndex()
			emit(r)
		"#,
	);
	assert_eq!(out["refused"], 2);
	assert_eq!(out["levelUp"], json!([2, "skipped:offer:Not offered by Dalar Dawnweaver"]), "the level-up keeps the guide at Ambermill");
	assert_eq!(out["turnIn"], 2, "so does a turn-in elsewhere");
	assert_eq!(out["back"], 3);
	assert_eq!(out["offered"], 1, "Dalar offers it now: the guide goes back to it, the player standing at Dalar");
	assert_eq!(out["taken"], 3);
}

#[test]
fn t_127_a_quest_the_giver_s_window_lists_as_active_is_taken_not_refused_before_the_log_has_it_accepting_clears_a_mark() {
	let out = run(
		"",
		GUIDE,
		r#"
			local w = stub.world
			local r = {}
			-- After Accept, the gossip comes back with 870 active a moment before the quest log has it.
			w.gossip(3429, { available = {}, active = { { questID = 870 } } }); flush()
			r.refresh = brief(1)[3]
			w.close(); w.accept(870, {}); flush()
			w.abandon(870); flush()
			r.abandoned = brief(1)[3]
			-- A mark set earlier goes when the quest is accepted, and is not saved while it is in the log.
			w.gossip(3429, { available = {} }); w.close(); flush()
			r.marked = brief(1)[3]
			w.accept(870, {}); flush()
			w.abandon(870); flush()
			r.reaccepted = brief(1)[3]
			emit(r)
		"#,
	);
	assert_eq!(out["refresh"], "active:nil:nil");
	assert_eq!(out["abandoned"], "active:nil:nil");
	assert_eq!(out["marked"], "skipped:offer:Not offered by Thork");
	assert_eq!(out["reaccepted"], "active:nil:nil");
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
	assert_eq!(out, json!(["skipped:pre:Requires The Other Errand first", "skipped:offer:Not offered by Thork"]));
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
	assert_eq!(missing["step1"], json!(["done:nil:nil", "skipped:pre:Requires The Angry Scytheclaws first", "active:nil:nil"]));
	// Jorn Skyseer's turn-in goes with it, and so does the quest after it.
	assert_eq!(missing["step2"], json!(["skipped:pre:Requires The Angry Scytheclaws first", "skipped:pre:Requires Jorn Skyseer first"]));
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
	assert_eq!(out["skipped"], json!([3, ["done:nil:nil", "skipped:pre:Requires Disrupt the Attacks first"]]));
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
			"step1": ["skipped:closed:No longer offered: you took Super Reaper 6000", "skipped:closed:No longer offered: you took Devourer of Souls"],
			"step2": ["skipped:closed:No longer offered: you took Super Reaper 6000"],
			"wp": false,
		})
	);
	let open = run("", guide, script);
	assert_eq!(open["step1"], json!(["active:nil:nil", "active:nil:nil"]));
	assert_eq!(open["at"], 1);
}

#[test]
fn when_a_mark_moves_the_guide_on_the_guide_window_says_which_quest_was_skipped_and_why_a_normal_completion_says_nothing() {
	let guide = r#"
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Crossroads", faction = "Horde", minLevel = 10, maxLevel = 30, steps = {
		{ title = "Thork", goals = { { t = "accept", quest = 870, title = "The Forgotten Pools", npc = 3429, npcName = "Thork", map = 1413, x = 51.5, y = 30.3 } } },
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
			w.gossip(3429, { available = {} }); w.close(); stub.advance(0.5)
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
			"skipped": [2, "Skipped The Forgotten Pools  \u{b7}  Not offered by Thork"],
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
