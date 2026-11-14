//! The quests a finished leveling guide leaves in the log, said at its end: the guide window's end card
//! (UI/GuideFrame.lua, GF.EndQuestLines) counts the ones a later guide hands in (Engine.CarriedQuests) and the
//! ones no guide of the route uses (RoutePlan.OffRoute), each line opening its list in the Quest room
//! (UI/QuestRoom.lua, "later" and "offroute"); the guide-end window (UI/GuideEnd.lua) lists the second kind
//! under "Not part of your route". Full addon, stub world, a fixture route.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

// In the log: 50 (worked in test/a, carried to test/c), 44 (handed in by test/b), 70 (test/a's `when onquest`),
// 60 (taken on a Deadmines step of test/a), 33 (a Mage's goal in test/a; this is a Warrior), and two the route
// never names: 19 (unfinished) and 304 (finished). 51 and 52 were turned in already (51 is carried too).
const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "WARRIOR", "Warrior"
w.level = 11
w.zone, w.subzone = "Elwynn Forest", ""
w.moveTo(1429, 42.5, 36.0)
w.onQuest(50, {}, "Kept Errand")
w.onQuest(44, { 1 }, "Next Guide's")
w.onQuest(19, { 1 }, "Tharil'zun")
w.onQuest(70, { 1 }, "Needed Errand")
w.onQuest(60, { 1 }, "Deadmines Errand")
w.onQuest(304, {}, "A Grim Task")
w.onQuest(33, { 1 }, "Wolves Across the Border")
w.complete({ 51, 52 })
"#;

// test/a (1-10) -> test/b (8-11) -> test/c (11-15).
const GUIDES: &str = r#"
local E1 = 1429
Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "A", faction = "Alliance", minLevel = 1, maxLevel = 10, next = "test/b", steps = {
	{ title = "Errands", goals = {
		{ t = "accept", quest = 50, title = "Kept Errand", npc = 240, npcName = "Someone", map = E1, x = 42, y = 35, carriedTo = "test/c" },
		{ t = "accept", quest = 51, title = "Done Errand", npc = 240, npcName = "Someone", map = E1, x = 42, y = 35, carriedTo = "test/c" } } },
	{ title = "Deadmines", when = { { k = "dungeon", name = "The Deadmines", map = 36 } }, goals = {
		{ t = "accept", quest = 60, title = "Deadmines Errand", npc = 241, npcName = "Other", map = E1, x = 50, y = 50 } } },
	{ title = "Needs", when = { { k = "onquest", q = { 70 } } }, goals = {
		{ t = "turnin", quest = 52, title = "Earlier", npc = 240, npcName = "Someone", map = E1, x = 42, y = 35 } } },
	{ title = "Mage", only = { classes = { "MAGE" } }, goals = {
		{ t = "accept", quest = 33, title = "Wolves Across the Border", npc = 240, npcName = "Someone", map = E1, x = 42, y = 35 } } },
} })
Polestar.RegisterGuide({ id = "test/b", pack = "test", title = "B", faction = "Alliance", minLevel = 8, maxLevel = 11, next = "test/c", steps = {
	{ title = "Next", goals = { { t = "turnin", quest = 44, title = "Next Guide's", npc = 997, npcName = "Other", map = E1, x = 80, y = 80 } } },
} })
Polestar.RegisterGuide({ id = "test/c", pack = "test", title = "C", faction = "Alliance", minLevel = 11, maxLevel = 15, steps = {
	{ title = "Kept", goals = { { t = "turnin", quest = 50, title = "Kept Errand", npc = 998, npcName = "Third", map = E1, x = 10, y = 10 } } },
} })
"#;

const STUBS: &str = r#"
E, UI, w, P = Polestar.Engine, Polestar.UI, stub.world, Polestar.RoutePlan
function flush() stub.advance(0.6) end
function plain(t) return t and (t:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) or nil end
function ids(list)
	local out = {}
	for i, c in ipairs(list or {}) do out[i] = c.quest end
	table.sort(out)
	return out
end
-- The Quest room's rows as shown: { title, why, Abandon shown }, sorted by title.
function room()
	local F, out = PolestarQuestRoom, {}
	for _, r in ipairs(F.rows) do
		if r:IsShown() then out[#out + 1] = { plain(r.Title:GetText()), plain(r.Why:GetText()), r.Abandon:IsShown() } end
	end
	table.sort(out, function(a, b) return a[1] < b[1] end)
	return { title = plain(F.Title:GetText()), rows = out, switch = F.Switch:IsShown(), guideMe = F.GuideMe:IsShown() }
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			GUIDES,
			STUBS,
			"stub.login()",
			r#"Polestar.Set("behavior.autoAccept", false); Polestar.Set("ui.shown", true)"#,
			r#"stub.fire("QUEST_LOG_UPDATE"); flush()"#,
			r#"E.SetGuide("test/a"); flush(); flush()"#,
			script,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_route_lists_carried_quests_and_the_ones_no_guide_of_the_route_uses_the_dungeon_answer_counts() {
	let out = run(r#"
		local r = {}
		r.carried = ids(E.CarriedQuests("test/a"))
		r.off = {}
		for _, c in ipairs(P.OffRoute("test/a")) do r.off[#r.off + 1] = { c.quest, c.title, c.ready } end
		table.sort(r.off, function(a, b) return a[1] < b[1] end)
		-- "Dungeons in my route": Run them makes the Deadmines quest the route's.
		Polestar.Set("behavior.dungeons", "run")
		r.run = ids(P.OffRoute("test/a"))
		Polestar.Set("behavior.dungeons", "skip")
		-- One dungeon answered Skip while every dungeon runs: its quest is not the route's again.
		Polestar.Set("behavior.dungeons", "run")
		E.ChooseDungeon(36, false)
		r.answered = ids(P.OffRoute("test/a"))
		emit(r)
	"#);
	assert_eq!(out["carried"], json!([50]), "51 was turned in: not carried; {out}");
	assert_eq!(
		out["off"],
		json!([[19, "Tharil'zun", false], [33, "Wolves Across the Border", false], [60, "Deadmines Errand", false], [304, "A Grim Task", true]]),
		"44 (test/b), 50 (carried) and 70 (`when onquest`) are the route's; 33 is a Mage's; Deadmines skipped: {out}"
	);
	assert_eq!(out["run"], json!([19, 33, 304]), "{out}");
	assert_eq!(out["answered"], json!([19, 33, 60, 304]), "{out}");
}

#[test]
fn the_end_card_counts_both_kinds_and_each_line_opens_its_list() {
	let out = run(r#"
		local GF = UI.GuideFrame
		GF.Layout(); flush()
		local empty = GF.parts.empty
		local r = { shown = empty:IsShown(), title = plain(empty.Title:GetText()), text = plain(empty.Text:GetText()),
			carried = empty.Carried:IsShown() and plain(empty.Carried.Label:GetText()) or false,
			stray = empty.Stray:IsShown() and plain(empty.Stray.Label:GetText()) or false }
		-- Laid out between the text and the buttons.
		local _, _, _, _, ty = empty.Text:GetPoint(1)
		local _, _, _, _, cy = empty.Carried:GetPoint(1)
		local _, _, _, _, sy = empty.Stray:GetPoint(1)
		local _, _, _, _, py = empty.Primary:GetPoint(1)
		r.order = ty > cy and cy > sy and sy > py
		empty.Stray:Click(); flush()
		r.offroute = room()
		empty.Carried:Click(); flush()
		r.later = room()
		-- Abandoned: the list and the card follow the log.
		PolestarQuestRoom:Hide()
		w.abandon(19); w.abandon(304); w.abandon(33); w.abandon(60); flush()
		GF.Layout(); flush()
		r.after = { carried = empty.Carried:IsShown() and plain(empty.Carried.Label:GetText()) or false, stray = empty.Stray:IsShown() }
		emit(r)
	"#);
	assert_eq!(out["shown"], true, "{out}");
	assert_eq!(out["title"], "Guide complete", "{out}");
	assert_eq!(out["text"], "Up next: B", "{out}");
	assert_eq!(out["carried"], "1 quest in your log carries on to a later guide", "{out}");
	assert_eq!(out["stray"], "4 quests aren't part of your route", "{out}");
	assert_eq!(out["order"], true, "{out}");
	assert_eq!(
		out["offroute"],
		json!({ "title": "Not part of your route", "switch": false, "guideMe": false, "rows": [
			["A Grim Task", "Finished: no guide of your route hands it in", true],
			["Deadmines Errand", "Not in any guide of your route", true],
			["Tharil'zun", "Not in any guide of your route", true],
			["Wolves Across the Border", "Not in any guide of your route", true],
		] }),
		"{out}"
	);
	assert_eq!(out["later"], json!({ "title": "Carried to later guides", "switch": false, "guideMe": false, "rows": [["Kept Errand", "Handed in in C (11–15)", false]] }), "kept: no Abandon; {out}");
	assert_eq!(out["after"], json!({ "carried": "1 quest in your log carries on to a later guide", "stray": false }), "{out}");
}

#[test]
fn the_guide_end_window_lists_the_quests_not_part_of_the_route_and_opens_their_list() {
	let out = run(r#"
		UI.GuideEnd.Show({ guideId = "test/a", next = "test/b", undone = 0 })
		flush()
		local F = PolestarGuideEnd
		local r = { head = F.OffHead:IsShown() and F.OffHead:GetText() or false, list = F.Off:IsShown() and F.Off:GetText() or false,
			link = F.OffLink:IsShown() and F.OffLink.Label:GetText() or false, carried = F.Carried:IsShown() and F.Carried:GetText() or false,
			tall = F:GetHeight() }
		local _, _, _, _, ch = F.CarriedHead:GetPoint(1)
		local _, _, _, _, oh = F.OffHead:GetPoint(1)
		r.below = oh < ch
		F.OffLink:Click(); flush()
		r.room = room().title
		r.stillShown = F:IsShown()
		PolestarQuestRoom:Hide()
		UI.GuideEnd.Hide()
		w.abandon(19); w.abandon(304); w.abandon(33); w.abandon(60); flush()
		UI.GuideEnd.Show({ guideId = "test/a", next = "test/b", undone = 0 })
		flush()
		r.none = { head = F.OffHead:IsShown(), link = F.OffLink:IsShown(), tall = F:GetHeight() }
		emit(r)
	"#);
	assert_eq!(out["head"], "Not part of your route", "{out}");
	let list: Vec<&str> = out["list"].as_str().unwrap_or("").split('\n').collect();
	let mut sorted = list.clone();
	sorted.sort_unstable();
	assert_eq!(sorted, ["A Grim Task", "Deadmines Errand", "Tharil'zun", "Wolves Across the Border"], "{out}");
	assert_eq!(out["link"], "Keep or abandon them", "{out}");
	assert_eq!(out["carried"], "Kept Errand · C (11–15)", "{out}");
	assert_eq!(out["below"], true, "under the carried list; {out}");
	assert_eq!(out["room"], "Not part of your route", "{out}");
	assert_eq!(out["stillShown"], true, "{out}");
	assert_eq!(out["none"]["head"], false, "{out}");
	assert_eq!(out["none"]["link"], false, "{out}");
	assert!(out["tall"].as_f64().unwrap() > out["none"]["tall"].as_f64().unwrap(), "{out}");
}
