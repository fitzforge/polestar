//! A save through two pack updates (0.3.5 -> 0.3.6 -> 0.3.7). What the first update passed behind the player
//! (CharState().gone, Own.passAdded) stays passed through the second: the second's pass starts from it
//! (CharState().passedBefore) and adds to it, so the player keeps their place. A guide counts as updated only when
//! its own shape changed (the guide as registered, CharState().ownShapes, Own.updated), not on every pack version
//! change: a guide a pack update left as it was keeps everything as is. A save from before own shapes were stored
//! counts a version change as an update once, as before, and keeps the passes it holds.

use forge_addontest::{emitted, Addon, RunAddon, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 50, 50)
w.race, w.raceName, w.faction, w.class, w.className, w.level = "Human", "Human", "Alliance", "WARRIOR", "Warrior", 10
-- The player did 100 and carries 103 (not done yet): their place is 103's hand-in.
w.complete({ 100 })
w.onQuest(103, { { required = 5, fulfilled = 1 } }, "Quest 103")
"#;

// The guide's steps; each version of the pack registers a list of them.
const START: &str = r#"{ title = "Start", goals = { a(100) } },"#;
const NEW_BEHIND: &str = r#"{ title = "New behind", goals = { a(108, 40) } },"#;
const HAND_IN_100: &str = r#"{ title = "Hand in 100", goals = { t(100) } },"#;
const ALSO_BEHIND: &str = r#"{ title = "Also behind", goals = { a(109, 45) } },"#;
const TAKE_103: &str = r#"{ title = "Take 103", goals = { a(103) } },"#;
const HAND_IN_103: &str = r#"{ title = "Hand in 103", goals = { t(103) } },"#;
const LAST: &str = r#"{ title = "Last", goals = { a(110, 70) } },"#;
const NEW_AHEAD: &str = r#"{ title = "New ahead", goals = { a(111, 75) } },"#;

// 0.3.5 had START, HAND_IN_100, TAKE_103, HAND_IN_103, LAST (FIRST_SAVE). 0.3.6: a new step behind the player (108).
const V2: &[&str] = &[START, NEW_BEHIND, HAND_IN_100, TAKE_103, HAND_IN_103, LAST];

fn pack(version: &str, steps: &[&str]) -> String {
	format!(
		r#"Polestar.RegisterPack({{ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "{version}", license = "MIT" }})
local M = 1429
local function a(q, x) return {{ t = "accept", quest = q, title = "Quest " .. q, map = M, x = x or 50, y = 50 }} end
local function t(q, x) return {{ t = "turnin", quest = q, title = "Quest " .. q, map = M, x = x or 50, y = 50 }} end
local function fp(npc) return {{ t = "getfp", location = "Testpost", node = 1, npc = npc, map = M, x = 41, y = 50 }} end
local function home(npc) return {{ t = "sethome", location = "Testpost", npc = npc, map = M, x = 41, y = 50 }} end
Polestar.RegisterGuide({{ id = "test/up", pack = "test", title = "Upgraded", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {{
	{}
}} }})"#,
		steps.join("\n\t")
	)
}

// The 0.3.5 save: the guide's shape and step keys (djb2 as Own.hash), no pack version.
const FIRST_SAVE: &str = r#"local function h(s) local x = 5381 for i = 1, #s do x = (x * 33 + s:byte(i)) % 4294967296 end return x end
PolestarCharDB = { schema = 1, tabs = { "test/up" }, activeTab = 1, shapes = { ["test/up"] = "5-1" },
	stepKeys = { ["test/up"] = { h("accept:100"), h("turnin:100"), h("accept:103"), h("turnin:103"), h("accept:110") } } }"#;

// Login with `saved`, the quest log in, then where the player is; logout, and the save as Lua for the next run.
// LEGACY: the earlier releases' changed steps (Core/LegacySteps.lua) the run gives the Engine, if any.
const SCRIPT: &str = r#"
E = Polestar.Engine
Polestar.LegacyStepsLoad = function() return LEGACY or {} end
stub.login(); stub.advance(0.25)
local db = PolestarCharDB
local noted = type(db.added) == "table" and db.added["test/up"] ~= nil
stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
local g = E.GetGuide()
local status = {}
for i = 1, #g.steps do status[i] = g.steps[i].title .. "=" .. E.GetStepView(i).status end
emit({ live = g.steps[E.GetLiveStep()].title, status = status, noted = noted })
stub.fire("PLAYER_LOGOUT")
local function ser(v)
	if type(v) == "string" then return string.format("%q", v) end
	if type(v) ~= "table" then return tostring(v) end
	local parts = {}
	for k, x in pairs(v) do
		if type(x) ~= "function" then parts[#parts + 1] = "[" .. ser(k) .. "]=" .. ser(x) end
	end
	return "{" .. table.concat(parts, ",") .. "}"
end
emit({ save = "PolestarCharDB = " .. ser(PolestarCharDB) })
"#;

/// One login of pack `version` with `steps` on `saved` -> (where the player is, the save after logout).
fn login(version: &str, steps: &[&str], saved: String) -> (Value, String) {
	login_with(version, steps, saved, "")
}

/// [`login`] with Lua setting LEGACY first.
fn login_with(version: &str, steps: &[&str], saved: String, legacy: &str) -> (Value, String) {
	let mut out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), saved)],
		login: false,
		script: format!("{}\n{TEST_SOURCE}\n{legacy}\n{SCRIPT}", pack(version, steps)),
	});
	let save = out.remove(1)["save"].as_str().expect("the save").to_string();
	(out.remove(0), save)
}

/// The 0.3.5 save loaded by 0.3.6: 108's new step behind the player passes, the place stays.
fn after_first_update() -> String {
	let (at, save) = login("0.3.6", V2, FIRST_SAVE.to_string());
	assert_eq!(at["live"], "Hand in 103", "{at}");
	assert_eq!(at["status"][1], "New behind=na", "{at}");
	save
}

#[test]
fn a_save_through_two_updates_keeps_its_place_and_what_the_first_passed() {
	let save = after_first_update();
	// 0.3.7 adds a step ahead: an update of the guide. 108's step, passed by 0.3.6, stays passed.
	let (at, _) = login("0.3.7", &[V2, &[NEW_AHEAD]].concat(), save);
	assert_eq!(at["live"], "Hand in 103", "the player stays at 103's hand-in: {at}");
	assert_eq!(at["status"][1], "New behind=na", "{at}");
	assert_eq!(at["status"][6], "New ahead=upcoming", "what the update added ahead stays: {at}");
}

#[test]
fn a_guide_a_pack_update_left_as_it_was_keeps_everything_as_is() {
	let save = after_first_update();
	// 0.3.7 with the same guide. The save's shape is the guide as planned for the character (a leveling guide's
	// feeders in, steps waiting on earlier guides left out), so it differs from the guide as registered at login:
	// still no update of it, nothing noted; the place and 0.3.6's pass stay.
	let planned = format!("{save}\nPolestarCharDB.shapes[\"test/up\"] = \"6-planned\"");
	let (at, _) = login("0.3.7", V2, planned);
	assert_eq!(at["noted"], false, "not an update of this guide: {at}");
	assert_eq!(at["live"], "Hand in 103", "{at}");
	assert_eq!(at["status"][1], "New behind=na", "{at}");
}

#[test]
fn a_guide_the_update_really_changed_still_passes_its_new_steps_behind_the_player() {
	let save = after_first_update();
	// 0.3.7 adds another step behind the player (109) and one ahead (111): 109's passes as 108's did, 108's stays
	// passed, 111's stays ahead.
	let v3 = [START, NEW_BEHIND, HAND_IN_100, ALSO_BEHIND, TAKE_103, HAND_IN_103, LAST, NEW_AHEAD];
	let (at, _) = login("0.3.7", &v3, save);
	assert_eq!(at["noted"], true, "an update of this guide: {at}");
	assert_eq!(at["live"], "Hand in 103", "{at}");
	assert_eq!(at["status"][1], "New behind=na", "{at}");
	assert_eq!(at["status"][3], "Also behind=na", "{at}");
	assert_eq!(at["status"][7], "New ahead=upcoming", "{at}");
}

// A recorded Night Elf Hunter's save, mid Loch Modan: 0.3.6 had loaded their 0.3.5 save and passed the steps of
// Rat Catching (385) it added behind them (`gone`). The save is from before own shapes were stored; its shape is
// the guide as planned for the character (63 steps), the guide as registered has 64. A pack version change
// with the same Loch Modan sent them back to The Farstrider Lodge (Rat Catching's accept, step 16); they stay at
// Lakeshire (step 34).
const LOCH_WORLD: &str = include_str!("engine-upgrade-twice/loch-modan-world.lua");
const LOCH_SAVE: &str = include_str!("engine-upgrade-twice/loch-modan-save.lua");

#[test]
fn a_pack_update_keeps_a_loch_modan_save_where_it_was() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: LOCH_WORLD.to_string(),
		addons: vec![Addon::name("Polestar"), Addon::name("Polestar_Guides"), Addon::name("Polestar_Guides_Alliance"), Addon::name("Polestar_Guides_NightElf")],
		saved: vec![("Polestar".to_string(), LOCH_SAVE.to_string())],
		login: false,
		script: r#"
Polestar.Guides.Pack("guides").version = "0.3.7"
stub.login(); stub.advance(0.25)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
local E = Polestar.Engine
local g = E.GetGuide()
emit({ guide = g.id, live = E.GetLiveStep(), title = g.steps[E.GetLiveStep()].title })"#
			.to_string(),
	});
	assert_eq!(out[0], json!({ "guide": "forever/alliance/03-loch-modan", "live": 34, "title": "Lakeshire" }));
}

// Final 0.3.7 candidate, the upgrade harness: a step the 0.3.5 -> 0.3.6 update had passed behind the player and that
// 0.3.7 changed came back and became the player's place. The pass is noted by step key and the changed step has
// a new one; what was passed in the old step is passed in the step it became (Own.carryGone, with the old step's
// goals from LegacySteps.lua). (0.3.6's step, its goals as LegacySteps.lua names them, 0.3.7's step.)
const LIGHTS_HOPE: (&str, &str, &str) = (
	// Eastern Plaguelands' Light's Hope Chapel: a flight path, the hearth and accepts; 0.3.7 drops one accept.
	r#"{ title = "New behind", goals = { fp(900), home(901), a(120, 40), a(121, 40) } },"#,
	"getfp:900,sethome:901,accept:120,accept:121",
	r#"{ title = "New behind", goals = { fp(900), home(901), a(120, 40) } },"#,
);
const MIRAGE_RACEWAY: (&str, &str, &str) = (
	// Feralas' Mirage Raceway: 0.3.7 drops the accept of a quest it still hands in there.
	r#"{ title = "New behind", goals = { a(122, 40), t(122, 40), a(123, 40) } },"#,
	"accept:122,turnin:122,accept:123",
	r#"{ title = "New behind", goals = { t(122, 40), a(123, 40) } },"#,
);
const SENANI: (&str, &str, &str) = (
	// Ashenvale's Senani Thunderheart: 0.3.7 keeps only the hand-in.
	r#"{ title = "New behind", goals = { a(124, 40), t(124, 40) } },"#,
	"accept:124,turnin:124",
	r#"{ title = "New behind", goals = { t(124, 40) } },"#,
);

fn a_changed_step_the_first_update_passed_stays_passed((was, parts, now): (&str, &str, &str)) {
	let v2 = [START, was, HAND_IN_100, TAKE_103, HAND_IN_103, LAST];
	let (at, save) = login("0.3.6", &v2, FIRST_SAVE.to_string());
	assert_eq!(at["live"], "Hand in 103", "{at}");
	assert_eq!(at["status"][1], "New behind=na", "{at}");
	let v3 = [START, now, HAND_IN_100, TAKE_103, HAND_IN_103, LAST];
	let legacy = format!(
		r#"local function h(s) local x = 5381 for i = 1, #s do x = (x * 33 + s:byte(i)) % 4294967296 end return x end
LEGACY = {{ ["test/up"] = {{ [h("{parts}")] = "{parts}" }} }}"#
	);
	let (at, _) = login_with("0.3.7", &v3, save, &legacy);
	assert_eq!(at["noted"], true, "an update of this guide: {at}");
	assert_eq!(at["live"], "Hand in 103", "the player stays at 103's hand-in: {at}");
	assert_eq!(at["status"][1], "New behind=na", "{at}");
}

#[test]
fn a_changed_step_the_first_update_passed_stays_passed_with_its_errands() {
	a_changed_step_the_first_update_passed_stays_passed(LIGHTS_HOPE);
}

#[test]
fn a_changed_step_the_first_update_passed_stays_passed_with_a_hand_in_whose_accept_went() {
	a_changed_step_the_first_update_passed_stays_passed(MIRAGE_RACEWAY);
}

#[test]
fn a_changed_step_the_first_update_passed_stays_passed_when_only_its_hand_in_is_left() {
	a_changed_step_the_first_update_passed_stays_passed(SENANI);
}
