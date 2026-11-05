//! Quests/QuestLevels.lua: "[12] " before quest titles in the quest log, the objective tracker, gossip and
//! greeting quest lists and quest detail titles, against fakes of the camelot UI (tests/lua/stub_questlog.lua).
//! Added once, never on top of a level the client drew, never when the level is unknown, never when it would
//! wrap an already laid-out title; qol.questLevels off puts back exactly the text Polestar changed.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const BEFORE: &str = r#"
local ql = stub.questlog
ql.quests[7] = { title = "Kobold Camp Cleanup", level = 12 }
ql.quests[18] = { title = "Gathering Wood", level = 24, elite = true }
ql.quests[33] = { title = "Mystery Errand" } -- level unknown to the client
ql.quests[40] = { title = "Abcdefghijklmnopqrstuvwxyzabc", level = 30 } -- fills the tracker line
ql.quests[61] = { title = "Old Lore" } -- only the quest database knows its level
ql.log = { 7, 18, 33 }
"#;

const PRELUDE: &str = r#"
local ql, sq = stub.questlog, stub.quests
local function texts(buttons)
	local out = {}
	for i, b in ipairs(buttons) do out[i] = b:GetText() end
	return out
end
local function logTexts() return { ql.logText(7), ql.logText(18), ql.logText(33) } end
"#;

fn run_with(script: &str, setup: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_quests.lua", "stub_questlog.lua"],
		before: format!("{BEFORE}{setup}"),
		addons: vec![Addon::name("Polestar")],
		script: format!("{PRELUDE}{script}"),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, "")
}

#[test]
fn the_quest_log_gets_the_level_once_a_second_refresh_does_not_double_it() {
	let out = run(r#"
ql.updateLog()
emit(logTexts())
ql.updateLog()
ql.updateLog()
emit(logTexts())"#);
	let want = json!(["[12] Kobold Camp Cleanup", "[24+] Gathering Wood", "Mystery Errand"]);
	assert_eq!(out[0], want);
	assert_eq!(out[1], want);
}

#[test]
fn the_tracker_header_gets_the_level_inside_the_colour_code_in_combat_too() {
	let out = run(r#"
stub.inCombat = true
ql.updateTracker(7)
emit(ql.trackerText(7))
ql.updateTracker(18, true)
emit(ql.trackerText(18, true))
ql.updateTracker(7)
ql.updateTracker(7)
emit(ql.trackerText(7))
ql.updateTracker(33)
emit(ql.trackerText(33))"#);
	assert_eq!(out[0], "|cffffd100[12] Kobold Camp Cleanup|r");
	assert_eq!(out[1], "|cffffd100[24+] Gathering Wood|r");
	assert_eq!(out[2], "|cffffd100[12] Kobold Camp Cleanup|r");
	assert_eq!(out[3], "|cffffd100Mystery Errand|r");
}

#[test]
fn a_prefix_that_would_wrap_a_laid_out_title_onto_another_line_is_not_added() {
	let out = run(r#"
ql.updateTracker(40)
local block = QuestObjectiveTracker:GetExistingBlock(40)
emit(ql.trackerText(40))
emit(block.HeaderText:GetNumLines())"#);
	assert_eq!(out[0], "|cffffd100Abcdefghijklmnopqrstuvwxyzabc|r");
	assert_eq!(out[1], 1);
}

#[test]
fn camelot_a_level_the_client_already_drew_in_the_log_and_tracker_is_left_as_drawn() {
	let out = run_with(
		r#"
ql.updateLog()
emit(logTexts())
ql.updateTracker(18)
emit(ql.trackerText(18))"#,
		"ql.native = true",
	);
	assert_eq!(out[0], json!(["[12] Kobold Camp Cleanup", "[24+] Gathering Wood", "[0] Mystery Errand"]));
	assert_eq!(out[1], "|cffffd100[24+] Gathering Wood (Elite)|r");
}

#[test]
fn gossip_quest_buttons_use_the_gossip_level_and_resize_to_the_new_text() {
	let out = run(r#"
local buttons = ql.gossip({ { 7, level = 12 }, { 33, level = 5 }, { 61, level = 0 }, { 18, active = true, level = 24 } })
emit(texts(buttons))
local h = {}
for i, b in ipairs(buttons) do h[i] = b:GetHeight() == math.max(b:GetTextHeight() + 2, 16) end
emit(h)
buttons[1]:Setup({ questID = 7, title = "Kobold Camp Cleanup", questLevel = 12 })
emit(buttons[1]:GetText())"#);
	assert_eq!(out[0], json!(["|cff000000[12] Kobold Camp Cleanup|r", "|cff000000[5] Mystery Errand|r", "|cff000000Old Lore|r", "|cff000000[24+] Gathering Wood|r"]));
	assert_eq!(out[1], json!([true, true, true, true]));
	assert_eq!(out[2], "|cff000000[12] Kobold Camp Cleanup|r");
}

#[test]
fn greeting_titles_get_the_level_on_show_and_on_a_direct_refresh_from_the_quest_database_when_the_client_has_none() {
	let out = run(&format!(
		"{}{}",
		forge_addontest::questdb::ADD_RECORDS_LUA,
		r#"
local Q = Polestar.QuestDB
Q.SetMeta({})
AddRecords("quests", { [61] = { [Q.F.LEVEL] = 7 } })
emit(texts(ql.greeting({ 18 }, { 7, 61, 33 })))
emit(texts(ql.greetingDirect()))
local h = {}
for i, b in ipairs(ql.greetingDirect()) do h[i] = b:GetHeight() == math.max(b:GetTextHeight() + 2, 16) end
emit(h)"#
	));
	let want = json!(["|cff000000[24+] Gathering Wood|r", "|cff000000[12] Kobold Camp Cleanup|r", "|cff000000[7] Old Lore|r", "|cff000000Mystery Errand|r"]);
	assert_eq!(out[0], want);
	assert_eq!(out[1], want);
	assert_eq!(out[2], json!([true, true, true, true]));
}

#[test]
fn quest_detail_titles_get_the_level_templates_without_a_title_are_ignored() {
	let out = run(r#"
emit(ql.detail(7, true))
emit(ql.detail(18, false))
QuestInfo_Display(QUEST_TEMPLATE_MAP_REWARDS, QuestInfoFrame)
emit(QuestInfoTitleHeader:GetText())
emit(ql.detail(33, false))"#);
	assert_eq!(out[0], "[12] Kobold Camp Cleanup");
	assert_eq!(out[1], "[24+] Gathering Wood");
	assert_eq!(out[2], "[24+] Gathering Wood");
	assert_eq!(out[3], "Mystery Errand");
}

#[test]
fn turning_qol_questlevels_off_restores_every_title_on_or_a_qol_reset_adds_them_back() {
	let out = run(r#"
local function all()
	return { logTexts(), ql.trackerText(7), texts(gossip), texts(greet), QuestInfoTitleHeader:GetText() }
end
ql.updateLog()
ql.updateTracker(7)
gossip = ql.gossip({ { 7, level = 12 } })
greet = ql.greeting({}, { 18 })
ql.detail(7, true)
Polestar.Set("qol.questLevels", false)
emit(all())
ql.updateLog()
ql.updateTracker(7)
emit({ logTexts(), ql.trackerText(7) })
Polestar.Set("qol.questLevels", true)
emit(all())
Polestar.Set("qol.questLevels", false)
Polestar.ResetSettings("qol")
emit(all())"#);
	let plain = json!([
		["Kobold Camp Cleanup", "Gathering Wood", "Mystery Errand"],
		"|cffffd100Kobold Camp Cleanup|r",
		["|cff000000Kobold Camp Cleanup|r"],
		["|cff000000Gathering Wood|r"],
		"Kobold Camp Cleanup"
	]);
	let levels = json!([
		["[12] Kobold Camp Cleanup", "[24+] Gathering Wood", "Mystery Errand"],
		"|cffffd100[12] Kobold Camp Cleanup|r",
		["|cff000000[12] Kobold Camp Cleanup|r"],
		["|cff000000[24+] Gathering Wood|r"],
		"[12] Kobold Camp Cleanup"
	]);
	assert_eq!(out[0], plain);
	assert_eq!(out[1], Value::Array(plain.as_array().unwrap()[..2].to_vec()));
	assert_eq!(out[2], levels);
	assert_eq!(out[3], levels);
}

#[test]
fn turning_it_off_leaves_a_level_the_client_drew_itself() {
	let out = run_with(
		r#"
ql.updateLog()
Polestar.Set("qol.questLevels", false)
emit(logTexts())"#,
		"ql.native = true",
	);
	assert_eq!(out[0], json!(["[12] Kobold Camp Cleanup", "[24+] Gathering Wood", "[0] Mystery Errand"]));
}

#[test]
fn secret_levels_and_quest_ids_leave_the_title_alone() {
	let out = run(r#"
sq.secret(99)
sq.secret(4242)
ql.quests[4242] = { title = "Hidden", level = 3 }
emit(texts(ql.gossip({ { 33, level = 99 }, { 4242, level = 3 } })))"#);
	assert_eq!(out[0], json!(["|cff000000Mystery Errand|r", "|cff000000Hidden|r"]));
}

#[test]
fn a_tracker_that_loads_after_polestar_is_hooked_on_its_addon_loaded() {
	let out = run_with(
		r#"
emit(QuestObjectiveTracker == nil)
ql.installTracker()
stub.addonLoaded("Blizzard_ObjectiveTracker")
ql.updateTracker(7)
emit(ql.trackerText(7))"#,
		"ql.removeTracker()",
	);
	assert_eq!(out[0], true);
	assert_eq!(out[1], "|cffffd100[12] Kobold Camp Cleanup|r");
}
