//! Quest-starting loot on the quest item button (addon/Polestar/QoL/QuestLoot.lua, qol.questLoot) and dungeon-only
//! quest tracking (addon/Polestar/QoL/InstanceTrack.lua, qol.instanceTrack), over tests/lua/stub_qol.lua with a fake
//! quest database and a fake Dungeons journal.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 4] = ["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "QoL/QoL.xml"];

fn run_with(script: &str, before: &str, saved: Option<&str>) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_qol.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		before: before.into(),
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		login: true,
		script: format!("local q = stub.qol\nlocal QoL = Polestar.QoL\n{script}"),
	})
}

// ---------------------------------------------------------------------------
// Quest-starting loot
// ---------------------------------------------------------------------------

// Items: 700 begins 7700 (the client says so), 701 begins 7701 (only the
// quest database knows), 702 begins 7702 (another race's quest), 703 begins
// 7703 but is a level 20 item; 900 is the step's torch. The fake database
// answers CheckAvailable as QuestDB does: eligibility, done, in the log.
const LOOT: &str = r#"
local b = PolestarQuestItemButton
q.items[700] = { name = "A Dusty Letter", classID = 12, questID = 7700 }
q.items[701] = { name = "Torn Page", classID = 12 }
q.items[702] = { name = "Carved Totem", classID = 12, questID = 7702 }
q.items[703] = { name = "Sealed Orders", classID = 12, questID = 7703, minLevel = 20 }
q.items[900] = { name = "Torch", classID = 12, spell = 11 }
local eligible = { [7700] = true, [7701] = true, [7703] = true }
Polestar.QuestDB = {
	IsLoaded = function() return true end,
	PlayerContext = function(_, ctx) ctx = ctx or {}; ctx.level = q.level; return ctx end,
	StartedBy = function(id) if id == 701 then return { 7701 } end end,
	CheckAvailable = function(id, ctx, isDone, isOn)
		if not eligible[id] then return false, "eligibility" end
		if isDone(id) then return false, "done" end
		if isOn(id) then return false, "active" end
		return true
	end,
}
local function bags() stub.fire("BAG_UPDATE_DELAYED"); stub.runTimers() end
local function shown()
	return { b:GetAttribute("item") or "nil", b:IsShown() and true or false, (b.Glow and b.Glow:IsShown()) and true or false }
end
q.step({ { t = "kill", target = "Wolf", quest = 5, oi = 1 } })
"#;

#[test]
fn quest_loot_a_looted_starter_the_character_can_take_goes_on_the_item_button_glowing_oldest_first_until_clicked_or_taken() {
	let out = run_with(
		&format!(
			"{LOOT}{}",
			r#"
		-- another race's quest and a level 20 item: never offered
		q.addItem(0, 1, 702, 1)
		q.addItem(0, 2, 703, 1)
		bags()
		emit(shown())

		-- a starter arrives: on the button, glowing
		q.addItem(0, 5, 700, 1)
		bags()
		emit(shown())

		-- a second one, in an earlier slot: the first keeps the button
		q.addItem(0, 3, 701, 1)
		bags()
		emit(shown())

		-- a step with its own item: the step's item wins, no glow
		q.addItem(0, 6, 900, 1)
		q.step({ { t = "use", item = 900, quest = 7, oi = 1 } })
		emit(shown())

		-- the step done with: the starter is back
		q.step({ { t = "kill", target = "Wolf", quest = 5, oi = 1 } })
		emit(shown())

		-- clicked on the button: it has been read, the next one takes its place
		q.ran = {}
		q.mouseClick(b)
		stub.runTimers()
		emit({ q.ran[1] and q.ran[1][2] or "nil", shown() })

		-- the second one's quest taken: nothing left to offer
		q.log[7701] = true
		stub.fire("QUEST_ACCEPTED", 1, 7701)
		stub.runTimers()
		emit(shown())
		emit({ next(QoL.State().questLoot.used) })

		-- the setting off: never, even for a new starter
		q.log[7701] = nil
		Polestar.Set("qol.questLoot", false)
		stub.runTimers()
		emit(shown())
	"#
		),
		"",
		None,
	);
	assert_eq!(out[0], json!(["nil", false, false]), "another race's quest and an item above the character's level are passed over");
	assert_eq!(out[1], json!(["item:700", true, true]), "the starter goes on the button with a glow");
	assert_eq!(out[2], json!(["item:700", true, true]), "oldest first, whatever the bag slot");
	assert_eq!(out[3], json!(["item:900", true, false]), "the step's own item wins");
	assert_eq!(out[4], json!(["item:700", true, true]));
	assert_eq!(out[5], json!(["item:700", ["item:701", true, true]]), "the click used the starter, then the next one shows");
	assert_eq!(out[6], json!(["nil", false, false]), "a quest in the log is no longer offered");
	assert_eq!(out[7], json!([700, true]), "the clicked one stays read while it is in the bags");
	assert_eq!(out[8], json!(["nil", false, false]));
}

#[test]
fn quest_loot_a_starter_looted_in_a_fight_goes_on_the_button_once_it_ends_and_leaves_with_the_item() {
	let out = run_with(
		&format!(
			"{LOOT}{}",
			r#"
		q.combat(true)
		q.addItem(0, 1, 700, 1)
		bags()
		emit({ b:GetAttribute("item") or "nil", QoL.HasQueued("item:PolestarQuestItemButton") })
		q.combat(false)
		emit(shown())
		-- the item leaves the bags (handed to the quest giver, destroyed): gone, and forgotten
		q.bags[0].slots[1] = nil
		bags()
		emit({ shown(), next(QoL.State().questLoot.seen) or "none" })
	"#
		),
		"",
		None,
	);
	assert_eq!(out[0], json!(["nil", true]), "no secure change in combat");
	assert_eq!(out[1], json!(["item:700", true, true]));
	assert_eq!(out[2], json!([["nil", false, false], "none"]));
}

#[test]
fn quest_loot_without_the_quest_database_nothing_is_offered_race_and_class_are_unknown() {
	let out = run_with(
		r#"
		q.items[700] = { name = "A Dusty Letter", classID = 12, questID = 7700 }
		q.step({ { t = "kill", target = "Wolf", quest = 5, oi = 1 } })
		q.addItem(0, 1, 700, 1)
		stub.fire("BAG_UPDATE_DELAYED")
		stub.runTimers()
		emit({ PolestarQuestItemButton:GetAttribute("item") or "nil", PolestarQuestItemButton:IsShown() and true or false })
	"#,
		"",
		None,
	);
	assert_eq!(out[0], json!(["nil", false]));
}

// ---------------------------------------------------------------------------
// Dungeon-only quest tracking
// ---------------------------------------------------------------------------

// Ragefire Chasm (instance map 389) and its journal page's quests; the
// character has three of them in the log (5761 is not) and five others, all
// eight watched, interleaved, plus one more quest it doesn't watch.
const DUNGEONS: &str = r#"
local q = stub.qol
local RFC = { { id = 5722 }, { id = 5723 }, { id = 5728 }, { id = 5761 } }
local fake = {
	ForMap = function(map) if map == 389 then return "ragefire-chasm" end end,
	Quests = function(key) return key == "ragefire-chasm" and RFC or {} end,
}
local loaded = stub.addonLoaded
function stub.addonLoaded(name)
	if name == "Polestar" and Polestar then Polestar.Dungeons = fake end
	return loaded(name)
end
for _, id in ipairs({ 100, 5722, 101, 5723, 102, 103, 5728, 104, 105 }) do q.log[id] = true end
"#;

const BEFORE: [i64; 8] = [100, 5722, 101, 5723, 102, 103, 5728, 104];

fn watched_before() -> String {
	format!("{{ {} }}", BEFORE.iter().map(|q| q.to_string()).collect::<Vec<_>>().join(", "))
}

#[test]
fn instance_track_inside_ragefire_only_its_quests_are_watched_leaving_brings_back_all_eight_in_order() {
	let out = run_with(
		&format!(
			r#"
		q.watches = {watched}
		q.enterInstance(389)
		emit(q.watches)
		local s = QoL.InstanceTrack.Saved()
		emit({{ s.key, s.watched }})
		-- a quest watched by hand inside stays until the way out
		C_QuestLog.AddQuestWatch(105)
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.runTimers()
		emit(q.watches)
		q.leaveInstance()
		emit(q.watches)
		emit(QoL.InstanceTrack.Saved() or "none")
		-- outside, nothing changes
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.runTimers()
		emit(q.watches)
		-- a battleground is no dungeon: left alone
		q.enterInstance(30, "pvp")
		emit(q.watches)
	"#,
			watched = watched_before()
		),
		DUNGEONS,
		None,
	);
	assert_eq!(out[0], json!([5722, 5723, 5728]), "only Ragefire Chasm's quests; 5761 isn't in the log");
	assert_eq!(out[1], json!(["ragefire-chasm", BEFORE]), "the list from before is kept per character");
	assert_eq!(out[2], json!([5722, 5723, 5728, 105]));
	assert_eq!(out[3], json!(BEFORE), "all eight back, in their order, and nothing else");
	assert_eq!(out[4], "none");
	assert_eq!(out[5], json!(BEFORE));
	assert_eq!(out[6], json!(BEFORE));
}

#[test]
fn instance_track_after_a_reload_inside_the_kept_list_still_comes_back_on_leaving() {
	let saved = format!(r#"PolestarCharDB = {{ qol = {{ instanceTrack = {{ key = "ragefire-chasm", watched = {} }} }} }}"#, watched_before());
	let out = run_with(
		r#"
		emit(q.watches)
		local s = QoL.InstanceTrack.Saved()
		emit({ s and s.key or "none", s and #s.watched or 0 })
		q.leaveInstance()
		emit(q.watches)
		emit(QoL.InstanceTrack.Saved() or "none")
	"#,
		&format!("{DUNGEONS}\nq.instance = {{ map = 389, kind = \"party\" }}\nq.watches = {{ 5722, 5723, 5728 }}"),
		Some(&saved),
	);
	assert_eq!(out[0], json!([5722, 5723, 5728]), "the reload inside changes nothing");
	assert_eq!(out[1], json!(["ragefire-chasm", 8]));
	assert_eq!(out[2], json!(BEFORE));
	assert_eq!(out[3], "none");
}

#[test]
fn instance_track_turned_off_inside_gives_the_list_back_at_once_and_off_it_never_touches_the_watches() {
	let out = run_with(
		&format!(
			r#"
		q.watches = {watched}
		q.enterInstance(389)
		emit(#q.watches)
		Polestar.Set("qol.instanceTrack", false)
		stub.runTimers()
		emit(q.watches)
		q.leaveInstance()
		q.enterInstance(389)
		emit(q.watches)
	"#,
			watched = watched_before()
		),
		DUNGEONS,
		None,
	);
	assert_eq!(out[0], json!(3));
	assert_eq!(out[1], json!(BEFORE));
	assert_eq!(out[2], json!(BEFORE));
}
