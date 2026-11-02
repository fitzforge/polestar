//! Another race's starting zone on the character's side (Guides.OtherStart): a Night Elf may load the Human
//! start. Polestar does not guide them there: while they are outside its zone and none of it is played, the guide
//! window shows a notice instead of the steps and the arrow points nowhere; arriving lifts it. In the guide,
//! steps for the guide's race only and quests the character can never take (the quest database) do not block,
//! and the hand-off goes on to the shared route. The whole addon, the stub world, synthetic guides.

use forge_addontest::{emitted, questdb::ADD_RECORDS_LUA, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.addMap(1438, { name = "Teldrassil", c = 1, left = 3000, right = 1000, top = 11000, bottom = 9000 })
w.moveTo(1438, 58, 40)
w.zone, w.subzone = "Teldrassil", "Shadowglen"
w.race, w.raceName, w.raceID, w.faction = "NightElf", "Night Elf", 4, "Alliance"
w.class, w.className, w.level = "WARRIOR", "Warrior", 1
w.titles[7001] = "Kobold Camp Cleanup"; w.titles[3100] = "Simple Letter"; w.titles[7003] = "Human Errand"
"#;

// 7001: any Alliance race. 3100 (Simple Letter): Human Warriors only, by the quest database; its step is the
// Warriors' (`only Warrior`). 7003: a step for Humans only (`only Human`). Layout: title, level, minLevel, races.
const GUIDES: &str = r#"
AddRecords("quests", {
	[3100] = { "Simple Letter", 1, 1, 1 },
	[7001] = { "Kobold Camp Cleanup", 2, 1 },
})
Polestar.QuestDB.SetMeta({})
Polestar.RegisterGuide({ id = "test/elwynn", pack = "test", title = "Elwynn Forest", faction = "Alliance", races = { "Human" },
	minLevel = 1, maxLevel = 12, category = "Leveling", zone = 1429, zoneName = "Elwynn Forest", next = "test/westfall", steps = {
	{ title = "Marshal McBride", goals = { { t = "accept", quest = 7001, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48, y = 42 } } },
	{ title = "Llane Beshere", only = { classes = { "WARRIOR" } }, goals = {
		{ t = "accept", quest = 3100, title = "Simple Letter", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48, y = 42 },
		{ t = "turnin", quest = 3100, title = "Simple Letter", npc = 911, npcName = "Llane Beshere", map = 1429, x = 50, y = 42 },
	} },
	{ title = "Human errand", only = { races = { "Human" } }, goals = { { t = "accept", quest = 7003, title = "Human Errand", npc = 198, npcName = "Someone", map = 1429, x = 49, y = 41 } } },
	{ title = "Back to McBride", goals = { { t = "turnin", quest = 7001, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48, y = 42 } } },
} })
Polestar.RegisterGuide({ id = "test/westfall", pack = "test", title = "Westfall", faction = "Alliance", minLevel = 10, maxLevel = 15, category = "Leveling",
	zone = 1436, zoneName = "Westfall", steps = {
	{ title = "Gryan", goals = { { t = "level", level = 15 } } },
} })
"#;

const HELPERS: &str = r#"
			E, w = Polestar.Engine, stub.world
			local p = Polestar.UI.GuideFrame.parts
			function shown()
				local wp = E.GetWaypoint()
				return { step = E.GetStepIndex() or false, notice = p.empty:IsShown() and p.empty.Title:GetText() or false,
					text = p.empty:IsShown() and p.empty.Text:GetText() or false, card = p.card:IsShown(), wp = wp and wp.goalIndex or false }
			end
			stub.login()
			stub.fire("QUEST_LOG_UPDATE")
			Polestar.Set("behavior.autoAccept", false)
"#;

fn run(before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec!["Polestar".into()],
		script: [TEST_PACK, TEST_SOURCE, ADD_RECORDS_LUA, GUIDES, HELPERS, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn outside_the_zone_a_night_elf_gets_the_notice_and_no_arrow_arriving_lifts_it() {
	let out = run(
		"",
		r#"
		E.SetGuide("test/elwynn"); stub.advance(0.6)
		local r = { away = shown(), api = E.AwayStart("test/elwynn") }
		w.moveTo(1429, 47, 43); w.setZone("Elwynn Forest", "Northshire Valley"); stub.advance(0.6)
		r.there = shown()
		r.apiThere = E.AwayStart("test/elwynn") or false
		emit(r)"#,
	);
	assert_eq!(
		out["away"],
		json!({
			"step": 1,
			"notice": "Another race's starting zone",
			"text": "This is the Human starting zone. Polestar won't guide you there: make your own way to Elwynn Forest, and the guide picks up when you arrive.\nYour class trainer may be elsewhere (check your capital).",
			"card": false,
			"wp": false,
		})
	);
	assert_eq!(out["api"], json!({ "races": ["Human"], "zone": 1429, "zoneName": "Elwynn Forest" }));
	assert_eq!(out["there"], json!({ "step": 1, "notice": false, "text": false, "card": true, "wp": 1 }));
	assert_eq!(out["apiThere"], false);
}

#[test]
fn once_a_quest_of_it_is_taken_leaving_the_zone_brings_no_notice_back_and_a_human_never_gets_one() {
	let out = run(
		"",
		r#"
		E.SetGuide("test/elwynn"); stub.advance(0.6)
		w.moveTo(1429, 47, 43); w.setZone("Elwynn Forest", "Northshire Valley"); stub.advance(0.6)
		w.accept(7001); stub.advance(0.6)
		w.moveTo(1438, 58, 40); w.setZone("Teldrassil", "Shadowglen"); stub.advance(0.6)
		emit({ left = shown().notice, api = E.AwayStart("test/elwynn") or false })"#,
	);
	assert_eq!(out, json!({ "left": false, "api": false }));
	let human =
		run(r#"w.race, w.raceName, w.raceID = "Human", "Human", 1"#, r#"E.SetGuide("test/elwynn"); stub.advance(0.6); emit({ notice = shown().notice, api = E.AwayStart("test/elwynn") or false })"#);
	assert_eq!(human, json!({ "notice": false, "api": false }));
}

#[test]
fn race_only_steps_and_quests_the_race_cannot_take_do_not_block_and_the_hand_off_reaches_the_shared_route() {
	let out = run(
		"",
		r#"
		E.SetGuide("test/elwynn"); stub.advance(0.6)
		w.moveTo(1429, 47, 43); w.setZone("Elwynn Forest", "Northshire Valley"); stub.advance(0.6)
		w.accept(7001); stub.advance(0.6)
		local r = { afterAccept = E.GetStepIndex(), next = E.NextGuide("test/elwynn") }
		w.turnIn(7001); stub.advance(0.6)
		r.guide = E.GetGuide().id
		r.elwynn = E.GetGuideState("test/elwynn")
		emit(r)"#,
	);
	// Step 2 (Simple Letter: Human Warriors only) and step 3 (only Human) are passed: step 4 is next.
	assert_eq!(out["afterAccept"], 4);
	assert_eq!(out["next"], "test/westfall");
	assert_eq!(out["guide"], "test/westfall");
	assert_eq!(out["elwynn"], "done");
}

#[test]
fn a_human_warrior_in_their_own_start_still_gets_the_letter() {
	let out = run(
		r#"w.race, w.raceName, w.raceID = "Human", "Human", 1; w.moveTo(1429, 47, 43); w.zone, w.subzone = "Elwynn Forest", "Northshire Valley""#,
		r#"
		E.SetGuide("test/elwynn"); stub.advance(0.6)
		w.accept(7001); stub.advance(0.6)
		emit(E.GetStepIndex())"#,
	);
	assert_eq!(out, json!(2));
}
