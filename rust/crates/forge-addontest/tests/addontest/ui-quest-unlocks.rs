//! What a quest unlocks, in the guide window (Core/Unlocks.lua, UI.UnlockLines, Engine.SkipLoses): hovering a
//! quest's line lists its follow-ups ("Leads to", the chain's part, another giver's quest, "+N more") and where
//! its chain ends; Skip and Skip this quest name the later quests that go with them and change nothing; a quest
//! left out because the player skipped its prerequisite says so. Real addon, stub world, a test guide and
//! quest database records copied from the shipped data (the Defias Brotherhood chain, Westfall and Redridge).

use forge_addontest::questdb::ADD_RECORDS_LUA;
use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1436, { name = "Westfall", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1436, 56, 47)
w.race, w.raceName, w.faction, w.class, w.className, w.level = "Human", "Human", "Alliance", "WARRIOR", "Warrior", 16
"#;

// Step 1 takes The People's Militia (12 -> 13 -> 14 in the steps after), The Lost Tools (125 -> The Everstill
// Bridge 89 -> Alther's Mill 98386, Redridge), The Defias Brotherhood part 1 (65) and part 6 (155), and
// Blackrock Bounty (128, which opens nothing).
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/wf", pack = "test", title = "Westfall", faction = "Alliance", minLevel = 10, maxLevel = 20, steps = {
	{ title = "Gryan", goals = {
		{ t = "accept", quest = 12, title = "The People's Militia", npc = 234, npcName = "Gryan Stoutmantle", map = 1436, x = 56.3, y = 47.5 },
		{ t = "accept", quest = 65, title = "The Defias Brotherhood", npc = 234, npcName = "Gryan Stoutmantle", map = 1436, x = 56.3, y = 47.5 },
		{ t = "accept", quest = 155, title = "The Defias Brotherhood", npc = 467, npcName = "The Defias Traitor", map = 1436, x = 56.3, y = 47.5 },
		{ t = "accept", quest = 128, title = "Blackrock Bounty", npc = 903, npcName = "Guard Howe", map = 1436, x = 56.3, y = 47.5 },
		{ t = "accept", quest = 125, title = "The Lost Tools", npc = 341, npcName = "Foreman Oslow", map = 1436, x = 56.3, y = 47.5 },
	} },
	{ title = "Militia 2", goals = {
		{ t = "turnin", quest = 12, title = "The People's Militia", npc = 234, npcName = "Gryan Stoutmantle" },
		{ t = "accept", quest = 13, title = "The People's Militia", npc = 234, npcName = "Gryan Stoutmantle", pre = { 12 } },
	} },
	{ title = "Militia 3", goals = {
		{ t = "turnin", quest = 13, title = "The People's Militia", npc = 234, npcName = "Gryan Stoutmantle" },
		{ t = "accept", quest = 14, title = "The People's Militia", npc = 234, npcName = "Gryan Stoutmantle", pre = { 13 } },
	} },
	{ title = "Militia done", goals = { { t = "turnin", quest = 14, title = "The People's Militia", npc = 234, npcName = "Gryan Stoutmantle" } } },
	{ title = "Oslow", goals = {
		{ t = "turnin", quest = 125, title = "The Lost Tools", npc = 341, npcName = "Foreman Oslow" },
		{ t = "accept", quest = 89, title = "The Everstill Bridge", npc = 341, npcName = "Foreman Oslow", pre = { 125 } },
	} },
	{ title = "Oslow again", goals = {
		{ t = "turnin", quest = 89, title = "The Everstill Bridge", npc = 341, npcName = "Foreman Oslow" },
		{ t = "accept", quest = 98386, title = "Alther's Mill", npc = 341, npcName = "Foreman Oslow", pre = { 89 } },
	} },
	{ title = "Mill", goals = { { t = "turnin", quest = 98386, title = "Alther's Mill", npc = 341, npcName = "Foreman Oslow" } } },
	{ goals = { { t = "level", level = 30 } } },
} })
"#;

// Layout: title, level, minLevel, races, classes, faction, start, finish, startItem, pre (one of). As in the
// shipped quest database: The Defias Brotherhood 65 -> 132 -> 135 -> 141 -> 142 -> 155 -> 166, and 155 also
// opens Red Silk Bandanas (214) from Scout Riell.
const RECORDS: &str = r#"
AddRecords("quests", {
	[12] = { "The People's Militia", 12, 9, 77, nil, 1, { 234 }, { 234 } },
	[13] = { "The People's Militia", 14, 9, 77, nil, 1, { 234 }, { 234 }, nil, { 12 } },
	[14] = { "The People's Militia", 17, 9, 77, nil, 1, { 234 }, { 234 }, nil, { 13 } },
	[65] = { "The Defias Brotherhood", 18, 14, 77, nil, 1, { 234 }, { 266 } },
	[128] = { "Blackrock Bounty", 25, 20, 77, nil, 1, { 903 }, { 903 } },
	[132] = { "The Defias Brotherhood", 18, 14, 77, nil, 1, { 266 }, { 234 }, nil, { 65 } },
	[135] = { "The Defias Brotherhood", 18, 14, 77, nil, 1, { 234 }, { 332 }, nil, { 132 } },
	[141] = { "The Defias Brotherhood", 18, 14, 77, nil, 1, { 332 }, { 234 }, nil, { 135 } },
	[142] = { "The Defias Brotherhood", 18, 14, 77, nil, 1, { 234 }, { 234 }, nil, { 141 } },
	[155] = { "The Defias Brotherhood", 18, 14, 77, nil, 1, { 467 }, { 234 }, nil, { 142 } },
	[166] = { "The Defias Brotherhood", 22, 14, 77, nil, 1, { 234 }, { 234 }, nil, { 155 } },
	[214] = { "Red Silk Bandanas", 17, 14, 77, nil, 1, { 820 }, { 820 }, nil, { 155 } },
})
AddRecords("npcs", { [234] = { "Gryan Stoutmantle" }, [266] = { "Wiley the Black" }, [332] = { "Master Mathias Shaw" },
	[467] = { "The Defias Traitor" }, [820] = { "Scout Riell" }, [903] = { "Guard Howe" } })
Polestar.QuestDB.SetMeta({})
"#;

const HELPERS: &str = r#"
E, GF = Polestar.Engine, Polestar.UI.GuideFrame
Polestar.Set("ui.wholeStep", true) -- every goal of the step is a row
Polestar.Set("behavior.autoAccept", false)
stub.login()
E.SetGuide("test/wf")
stub.advance(0.5)
function row(q, t)
	for _, r in ipairs(GF.rows) do
		if r:IsShown() and r.psGoal and r.psGoal.quest == q and r.psGoal.t == (t or "accept") then return r end
	end
end
-- The tooltip of quest q's line: its lines after the title.
function tip(q, t)
	stub.RunScript(row(q, t), "OnEnter")
	local out = {}
	for i, l in ipairs(GameTooltip.lines) do out[i] = l end
	stub.RunScript(row(q, t), "OnLeave")
	return out
end
-- The lines of a tooltip that come from what the quest unlocks.
function unlockLines(lines)
	local out = {}
	for _, l in ipairs(lines) do
		if l:find("^Leads to |") or l:find("^ |") or l:find("^Chain ends with |") or l:find("^Final reward |") then out[#out + 1] = l end
	end
	return out
end
function statuses()
	local out = {}
	for i = 1, #E.GetGuide().steps do
		local g = {}
		for j, v in ipairs(E.GetStepView(i).goals) do g[j] = v.status end
		out[i] = table.concat(g, ",")
	end
	return out
end
"#;

fn run(records: bool, script: &str) -> Value {
	let records = if records { format!("{ADD_RECORDS_LUA}{RECORDS}") } else { String::new() };
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, &records, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_chain_quest_shows_its_follow_up_numbered_with_where_the_chain_ends_from_the_quest_database_or_the_guide_alone() {
	let with_db = run(true, r#"emit({ defias = unlockLines(tip(65)), militia = unlockLines(tip(12)), tools = unlockLines(tip(125)) })"#);
	assert_eq!(
		with_db,
		json!({
			"defias": ["Leads to | The Defias Brotherhood (part 2 of 7)", "Chain ends with | The Defias Brotherhood (part 7)"],
			"militia": ["Leads to | The People's Militia (part 2 of 3)", "Chain ends with | The People's Militia (part 3)"],
			"tools": ["Leads to | The Everstill Bridge (part 2 of 3)", "Chain ends with | Alther's Mill (part 3)"],
		}),
		"the next part first, numbered; the chain's end once it is further than the next part"
	);
	// Without the quest database, the guide's own accepts (13 needs 12, 14 needs 13) still tell.
	let guide_only = run(false, r#"emit({ militia = unlockLines(tip(12)), defias = unlockLines(tip(65)) })"#);
	assert_eq!(
		guide_only,
		json!({
			"militia": ["Leads to | The People's Militia (part 2 of 3)", "Chain ends with | The People's Militia (part 3)"],
			"defias": {},
		})
	);
}

#[test]
fn a_quest_with_no_follow_up_shows_nothing_extra_and_its_skip_names_nothing() {
	let out = run(
		true,
		r#"
		local lines = tip(128)
		stub.RunScript(row(128), "OnClick", "RightButton")
		local skipTip
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Skip this quest" then skipTip = r.psItem.tip end end
		emit({ unlocks = unlockLines(lines), skipTip = skipTip, loses = E.SkipLoses(128) or false })"#,
	);
	assert_eq!(
		out,
		json!({
			"unlocks": {},
			"skipTip": "This quest and the ones that follow from it are skipped, in every guide. Right-click it again to bring it back.",
			"loses": false,
		})
	);
}

#[test]
fn a_quest_that_another_giver_s_quest_needs_names_that_giver_after_the_chain_s_next_part() {
	let out = run(true, r#"emit(unlockLines(tip(155)))"#);
	assert_eq!(
		out,
		json!(["Leads to | The Defias Brotherhood (part 7 of 7)", " | Red Silk Bandanas, from Scout Riell"]),
		"part 7 is the chain's end: no Chain ends with line; Red Silk Bandanas branches off it"
	);
}

#[test]
fn more_than_four_follow_ups_list_four_then_how_many_more() {
	let out = run(
		true,
		r#"
		AddRecords("quests", {
			[9001] = { "Side One", 18, 14, 77, nil, 1, { 820 }, { 820 }, nil, { 128 } },
			[9002] = { "Side Two", 18, 14, 77, nil, 1, { 820 }, { 820 }, nil, { 128 } },
			[9003] = { "Side Three", 18, 14, 77, nil, 1, { 903 }, { 903 }, nil, { 128 } },
			[9004] = { "Side Four", 18, 14, 77, nil, 1, { 903 }, { 903 }, nil, { 128 } },
			[9005] = { "Side Five", 18, 14, 77, nil, 1, { 903 }, { 903 }, nil, { 128 } },
			[9006] = { "Side Six", 18, 14, 77, nil, 1, { 903 }, { 903 }, nil, { 128 } },
			[9007] = { "Horde Side", 18, 14, 178, nil, 2, { 903 }, { 903 }, nil, { 128 } },
		})
		emit(unlockLines(tip(128)))"#,
	);
	assert_eq!(
		out,
		json!([
			"Leads to | Side One, from Scout Riell",
			" | Side Two, from Scout Riell",
			" | Side Three",
			" | Side Four",
			" | +2 more",
		]),
		"the Horde quest is never this character's"
	);
}

#[test]
fn skip_and_skip_this_quest_name_the_later_quests_that_go_with_them_and_change_nothing() {
	let out = run(
		true,
		r#"
		local before = statuses()
		stub.RunScript(GF.parts.nav.Skip, "OnEnter")
		local skipLines = {}
		for i, l in ipairs(GameTooltip.lines) do skipLines[i] = l end
		stub.RunScript(row(125), "OnClick", "RightButton")
		local quest
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Skip this quest" then quest = r.psItem.tip end end
		emit({ skip = skipLines, quest = quest, same = table.concat(statuses(), "/") == table.concat(before, "/"),
			at = E.GetStepIndex(), saved = PolestarCharDB.skippedQuests or false, steps = PolestarCharDB.skipped and PolestarCharDB.skipped["test/wf"] or false })"#,
	);
	assert_eq!(
		out["skip"],
		json!([
			"Skip this step",
			"The guide moves on and remembers it. Undo in the banner, or go back to the step to unskip it.",
			"Skipping also skips: The People's Militia (2 parts), The Everstill Bridge, Alther's Mill",
		])
	);
	assert_eq!(
		out["quest"],
		"This quest and the ones that follow from it are skipped, in every guide. Right-click it again to bring it back. Skipping also skips: The Everstill Bridge, Alther's Mill"
	);
	assert_eq!(json!([out["same"], out["at"], out["saved"], out["steps"]]), json!([true, 1, false, false]), "only a try: nothing skipped, saved or moved");
}

#[test]
fn a_quest_left_out_because_the_player_skipped_its_prerequisite_names_that_quest_also_down_the_chain() {
	let out = run(
		true,
		r#"
		local function oslow(s) local v = E.GetStepView(s).goals[2]; return { v.status, v.skippedWith or false, v.unavailableText or false } end
		E.SkipQuest(125); stub.advance(0.5)
		local skipped = { bridge = oslow(5), mill = oslow(6) }
		E.SkipQuest(125, false); stub.advance(0.5)
		emit({ skipped = skipped, back = oslow(5) })"#,
	);
	assert_eq!(
		out,
		json!({
			"skipped": {
				"bridge": ["skipped", "The Lost Tools", "Requires The Lost Tools first"],
				"mill": ["skipped", "The Lost Tools", "Requires The Everstill Bridge first"],
			},
			"back": ["pending", false, false],
		}),
		"Alther's Mill needs The Everstill Bridge, left out with The Lost Tools: both name the quest the player skipped"
	);
}

#[test]
fn a_step_the_player_skipped_counts_as_the_skipped_quest_for_what_it_left_out() {
	let out = run(
		true,
		r#"
		E.Goto(5); stub.advance(0.25)
		E.Skip(); stub.advance(0.5) -- the step with The Lost Tools' turn-in and The Everstill Bridge's accept
		local v = E.GetStepView(6).goals[2]
		emit({ v.status, v.skippedWith or false })"#,
	);
	assert_eq!(out, json!(["skipped", "The Everstill Bridge"]));
}
