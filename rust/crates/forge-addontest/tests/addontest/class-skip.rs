//! #1372, a Horde Shaman at Brine in Call of Water with the chain's earlier part (1530) in the log: every part
//! of the chain is named "Call of Water". The class card stands for the quest in hand until it is handed in
//! (UI/ClassCard.lua cardGoal), not for the next part's accept with an empty tick box; a hand tick on that
//! accept says the one in the log is another quest of that name (Engine, Own.acceptNotice); skipping the step
//! every later one follows from says so, with the undo, instead of "Guide complete" (Engine.SkippedOut,
//! GuideFrame's "skippedout"); and nothing offers a skip that does nothing. Full addon, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::Value;

const WORLD: &str = r#"
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 2000, right = -4000, top = 1000, bottom = -5000 })
w.race, w.raceName = "Orc", "Orc"
w.class, w.className = "SHAMAN", "Shaman"
w.faction = "Horde"
w.level = 21
w.moveTo(1413, 61.99, 39.41)
for _, q in ipairs({ 1530, 1535, 1536 }) do w.titles[q] = "Call of Water" end
w.complete({ 1528 })
w.onQuest(1530, {}, "Call of Water")
"#;

// The Barrens part of the Horde Call of Water guide, as compiled (guides/forever/class/shaman/call-of-water-horde).
const GUIDE: &str = r#"
local function brine(t, q, extra)
	local g = { t = t, quest = q, title = "Call of Water", npc = 5899, npcName = "Brine", map = 1413, x = 43.42, y = 77.41 }
	for k, v in pairs(extra or {}) do g[k] = v end
	return g
end
Polestar.RegisterGuide({
	id = "test/class/call-of-water", pack = "test", title = "Call of Water (Horde)", category = "Class", classes = { "SHAMAN" },
	faction = "Horde", minLevel = 20, maxLevel = 23,
	steps = {
		{ title = "Islen Waterseer", goals = {
			{ t = "accept", quest = 1530, title = "Call of Water", npc = 5901, npcName = "Islen Waterseer", map = 1413, x = 65.8, y = 43.8, minLevel = 20, qlvl = 22 },
		} },
		{ title = "Brine", goals = {
			brine("turnin", 1530),
			brine("accept", 1535, { minLevel = 20, qlvl = 22, pre = { 1530 }, preTitles = { [1530] = "Call of Water" } }),
		} },
		{ title = "The Quilboar Watering Hole", goals = {
			{ t = "use", item = 7766, itemName = "Empty Brown Waterskin", quest = 1535, oi = 1, title = "Call of Water", map = 1413, x = 44.3, y = 76.8 },
			{ t = "collect", item = 7769, itemName = "Filled Brown Waterskin", count = 1, quest = 1535, oi = 1, title = "Call of Water", map = 1413, x = 44.3, y = 76.8 },
		} },
		{ title = "Brine", goals = {
			brine("turnin", 1535),
			brine("accept", 1536, { minLevel = 20, qlvl = 22, pre = { 1535 }, preTitles = { [1535] = "Call of Water" } }),
		} },
		{ title = "Brine", goals = { brine("turnin", 1536) } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
GF = Polestar.UI.GuideFrame
CC = Polestar.UI.ClassCard
w = stub.world
function flush() stub.advance(0.5) end
function plain(t) return t and (t:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) or nil end
function snap()
	local s = E.GetStepIndex()
	local v = s and E.GetStepView(s)
	local notices = {}
	for i, g in ipairs(v and v.goals or {}) do notices[i] = g.noticeText or false end
	local e = GF.parts.empty
	return {
		step = s or false, live = E.GetLiveStep() or false,
		card = v and CC.shown and CC.shown.quest or false,
		fold = v and CC.Fold(E.GetGuide(), v) or false,
		notices = notices,
		empty = e:IsShown() and e.Title:GetText() or false,
		text = e:IsShown() and plain(e.Text:GetText()) or false,
		primary = e:IsShown() and e.Primary:IsShown() and e.Primary.Label and e.Primary.Label:GetText() or false,
	}
end
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			GUIDE,
			HELPERS,
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			r#"Polestar.Set("behavior.autoAccept", false); Polestar.Set("behavior.autoTurnin", false)"#,
			r#"E.SetGuide("test/class/call-of-water"); stub.advance(3)"#,
			script,
		]
		.join("\n"),
		..Default::default()
	})
}

#[test]
fn the_class_card_stands_for_the_call_of_water_in_hand_until_brine_takes_it() {
	let out = run(r#"
		emit(snap())
		w.turnIn(1530); flush()
		emit(snap())"#);
	// With 1530 in the log the card is its turn-in: no tick box for the next part's accept, which shows as a row.
	assert_eq!(out[0]["step"], 2, "{}", out[0]);
	assert_eq!(out[0]["card"], 1530, "the card is the quest in hand, not the next part: {}", out[0]);
	assert_eq!(out[0]["fold"], false, "{}", out[0]);
	// Handed in: Brine gives the next part; the card folds its accept in.
	assert_eq!(out[1]["step"], 2, "{}", out[1]);
	assert_eq!(out[1]["card"], 1535, "{}", out[1]);
	assert_eq!(out[1]["fold"], 2, "{}", out[1]);
}

#[test]
fn a_hand_tick_on_the_next_call_of_water_says_the_one_in_the_log_is_another_quest() {
	let out = run(r#"
		E.ToggleGoal(2, 2); flush()
		emit(snap())
		w.turnIn(1530); flush()
		emit(snap())"#);
	assert_eq!(out[0]["notices"][1], "This Call of Water isn't in your quest log yet: the one you have is another quest of that name", "{}", out[0]);
	// No namesake in the log any more: the plain notice.
	assert_eq!(out[1]["notices"][1], "Call of Water isn't in your quest log", "{}", out[1]);
}

#[test]
fn skipping_the_step_the_rest_follows_from_says_so_and_offers_the_undo_instead_of_guide_complete() {
	let out = run(r#"
		GF.SkipStep(); flush()
		emit(snap())
		local before = #stub.messages
		SlashCmdList.POLESTAR("skip")
		emit({ printed = table.concat(stub.messages, "\n", before + 1) })
		GF.parts.empty.Primary.psAction(); flush()
		emit(snap())"#);
	let skipped = &out[0];
	assert_eq!(skipped["live"], false, "{skipped}");
	assert_eq!(skipped["empty"], "The rest of this guide follows from a skipped step", "{skipped}");
	assert_eq!(
		skipped["text"],
		"You skipped Brine, and the steps after it need its quests. Undo the skip to carry on, or do that step yourself: the guide picks up from there."
	);
	assert_eq!(skipped["primary"], "Undo the skip");
	// /polestar skip with no step open says so instead of doing nothing.
	assert!(out[1]["printed"].as_str().unwrap_or("").ends_with("Nothing to skip: the guide has no step open."), "{}", out[1]);
	// The undo brings Brine back as the live step.
	assert_eq!(out[2]["live"], 2, "{}", out[2]);
	assert_eq!(out[2]["empty"], false, "{}", out[2]);
}

#[test]
fn a_skip_that_leaves_nothing_else_out_still_completes_the_guide() {
	// Everything handed in but the last part: skipping its step leaves no other step out.
	let out = run(r#"
		w.turnIn(1530); w.accept(1535, {}); w.turnIn(1535); w.accept(1536, {}); flush()
		emit(snap())
		GF.SkipStep(); flush()
		emit(snap())"#);
	assert_eq!(out[0]["step"], 5, "{}", out[0]);
	assert_eq!(out[1]["empty"], "Guide complete", "{}", out[1]);
}

// A leveling guide that takes Orgrimmar's Call of Water letter (1528) for every Shaman, as the Barrens does,
// and a Tauren Shaman holding Thunder Bluff's (1529, exclusive with it, handed in to Islen too): Islen's next
// part stays open, not "Requires Call of Water first" with Call of Water in the log (Own.coming).
const LETTERS: &str = r#"
Polestar.RegisterGuide({
	id = "test/barrens", pack = "test", title = "The Barrens", minLevel = 20, maxLevel = 25, faction = "Horde",
	steps = {
		{ title = "Searn Firewarder", goals = {
			{ t = "accept", quest = 1528, title = "Call of Water", npc = 5892, npcName = "Searn Firewarder", map = 1413, x = 50, y = 50, minLevel = 20, closedBy = { 1529, 2985, 2986 }, only = { classes = { "SHAMAN" } } },
		} },
		{ title = "Islen Waterseer", goals = {
			{ t = "turnin", quest = 1528, title = "Call of Water", npc = 5901, npcName = "Islen Waterseer", map = 1413, x = 65.8, y = 43.8, only = { classes = { "SHAMAN" } } },
			{ t = "accept", quest = 1530, title = "Call of Water", npc = 5901, npcName = "Islen Waterseer", map = 1413, x = 65.8, y = 43.8, minLevel = 20, pre = { 1528, 1529, 2985, 2986 }, only = { classes = { "SHAMAN" } } },
		} },
		{ title = "Brine", goals = {
			{ t = "turnin", quest = 1530, title = "Call of Water", npc = 5899, npcName = "Brine", map = 1413, x = 43.42, y = 77.41, only = { classes = { "SHAMAN" } } },
		} },
	},
})
"#;

#[test]
fn a_letter_from_another_giver_in_the_log_keeps_the_next_call_of_water_open() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\nw.race, w.raceName = \"Tauren\", \"Tauren\"\nw.complete({{}}); w.log[1530] = nil\nw.onQuest(1529, {{}}, \"Call of Water\")\nw.completed[1528] = nil"),
		addons: vec![Addon::name("Polestar")],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			LETTERS,
			HELPERS,
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			r#"E.SetGuide("test/barrens"); stub.advance(3)"#,
			r#"local v = E.GetStepView(2)
			emit({ live = E.GetLiveStep() or false, accept = v.goals[2].status, why = v.goals[2].unavailableText or false })"#,
		]
		.join("\n"),
		..Default::default()
	});
	assert_eq!(out[0]["live"], 2, "{}", out[0]);
	assert_eq!(out[0]["accept"], "active", "{}", out[0]);
}
