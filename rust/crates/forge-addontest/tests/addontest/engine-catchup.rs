//! The catch-up, with "Skip grey quests" on (off by default): a character who already did part of the route
//! opens a leveling guide and it resumes where they are, as placement does, leaving out what is too low to be
//! worth it: grey quests anywhere, green ones behind the last quest progress, the way to them, and a whole guide
//! they are past (opened for them, it chains to the next one; opened by them, it stays). A low quest a later
//! quest worth doing needs is kept. Guides that are not leveling ones do every step. Real Core manifest, stub
//! world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

// A level-20 Human: grey at 13 and below, green from 14 to 17, yellow from 18.
const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 50, 50)
w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "WARRIOR", "Warrior"
w.level = 20
"#;

// test/low (1-12): grey for them, done in part, with a grey quest handed in with no accept (`turnin ... direct`,
// as Distracting Jarven in Dun Morogh). test/mid (15-22): a trip to a green quest behind their progress, a grey
// quest a yellow one needs, a green quest still in the log behind it (kept: they chose it), and the last quest
// they did.
const GUIDES: &str = r#"
Polestar.RegisterGuide({ id = "test/low", pack = "test", title = "Low", faction = "Alliance", minLevel = 1, maxLevel = 12, next = "test/mid", steps = {
	{ goals = { { t = "accept", quest = 101, title = "Grey done", qlvl = 5 } } },
	{ goals = { { t = "goto", map = 1429, x = 10, y = 10, label = "Farm" } } },
	{ goals = { { t = "accept", quest = 102, title = "Grey not done", qlvl = 6 } } },
	{ goals = { { t = "turnin", quest = 102, title = "Grey not done" }, { t = "turnin", quest = 101, title = "Grey done" } } },
	{ goals = { { t = "turnin", quest = 104, title = "Grey direct", direct = true, qlvl = 7 } } },
	{ goals = { { t = "fly", location = "Stormwind City" } } },
} })
Polestar.RegisterGuide({ id = "test/mid", pack = "test", title = "Mid", faction = "Alliance", minLevel = 15, maxLevel = 22, steps = {
	{ goals = { { t = "goto", map = 1429, x = 20, y = 20, label = "Town" } } },
	{ goals = { { t = "accept", quest = 201, title = "Green behind", qlvl = 15 } } },
	{ goals = { { t = "goto", map = 1429, x = 30, y = 30, label = "Camp" } } },
	{ goals = { { t = "turnin", quest = 201, title = "Green behind" } } },
	{ goals = { { t = "accept", quest = 202, title = "Grey needed", qlvl = 12 } } },
	{ goals = { { t = "turnin", quest = 202, title = "Grey needed" }, { t = "accept", quest = 203, title = "Yellow", qlvl = 19, pre = { 202 } } } },
	{ goals = { { t = "accept", quest = 206, title = "Green in the log", qlvl = 14 } } },
	{ goals = { { t = "turnin", quest = 206, title = "Green in the log" } } },
	{ goals = { { t = "accept", quest = 204, title = "Done", qlvl = 16 } } },
	{ goals = { { t = "accept", quest = 205, title = "Ahead", qlvl = 20 } } },
	{ goals = { { t = "turnin", quest = 203, title = "Yellow" } } },
} })
"#;

// Saved variables with "Skip grey quests" on (plus `extra` behaviour settings) and the character's own (`db`,
// none by default).
fn catch_up_on(extra: &str, db: &str) -> String {
	format!("PolestarDB = {{ schema = 1, settings = {{ behavior = {{ skipGrey = true{extra} }} }} }}; {db}")
}

fn on() -> String {
	catch_up_on("", "PolestarCharDB = nil")
}

// No guide picked at login: Start guide opens one for the player.
fn pick_off() -> String {
	catch_up_on(", autoSelectGuide = false", "PolestarCharDB = nil")
}

const SETUP: &str = r#"			E = Polestar.Engine
			function flush() stub.advance(0.25) end
			PLACED = {}
			Polestar.On("GUIDE_PLACED", function(id, step, chain)
				PLACED[#PLACED + 1] = { id = id, step = step or false, chain = table.concat(chain or {}, ",") }
			end)
			stub.login()
			stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
			"#;

fn run(before: &str, guides: &str, saved: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), saved.to_string())],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{guides}\n{SETUP}{script}"),
		..Default::default()
	})
	.remove(0)
}

const DONE: &str = "stub.world.complete({ 101, 204 }); stub.world.onQuest(206, {})";
const OFF: &str = "PolestarDB = { schema = 1, settings = { behavior = { skipGrey = false } } }";

// Each step's status, as the guide window shows it ("na": left out).
const STATUSES: &str = r#"
	local function statuses()
		local out = {}
		for i = 1, #E.GetGuide().steps do
			local goals = E.GetStepView(i).goals
			out[i] = goals[#goals].status
		end
		return out
	end
"#;

#[test]
fn a_level_20_character_given_a_grey_guide_is_taken_through_it_to_the_next_and_resumes_at_the_grey_quest_a_yellow_one_needs() {
	let out = run(
		DONE,
		GUIDES,
		&pick_off(),
		&(STATUSES.to_owned()
			+ r#"
			E.StartGuide(); flush()
			emit({ guide = E.GetGuide().id, at = E.GetStepIndex(), placed = PLACED[#PLACED], statuses = statuses() })
		"#),
	);
	assert_eq!(out["guide"], "test/mid");
	assert_eq!(out["at"], 5, "the grey quest Yellow needs, after the trip to the green quest left behind");
	assert_eq!(out["placed"], json!({ "id": "test/mid", "step": 5, "chain": "test/low" }));
	// Green behind and its turn-in are left out, the trips pass; the quest in the log keeps its turn-in.
	assert_eq!(Value::from(out["statuses"].as_array().unwrap()[..9].to_vec()), json!(["done", "na", "done", "na", "active", "pending", "done", "pending", "done"]));
}

// Yendi at 30 in Duskwood (25-27): Gather Rot Blossoms (24) and The Night Watch (26) in the log, neither done. In
// the log by the same rules as a quest not taken: too low and not done, it goes; done, it stays to be handed in.
#[test]
fn a_low_quest_in_the_log_goes_while_it_is_not_done_and_stays_once_it_only_has_to_be_handed_in() {
	let duskwood = r#"
		Polestar.RegisterGuide({ id = "test/dusk", pack = "test", title = "Duskwood", faction = "Alliance", minLevel = 25, maxLevel = 27, next = "test/mid", steps = {
			{ goals = { { t = "accept", quest = 57, title = "The Night Watch", qlvl = 26 } } },
			{ goals = { { t = "accept", quest = 156, title = "Gather Rot Blossoms", qlvl = 24 } } },
			{ goals = { { t = "collect", item = 1598, itemName = "Rot Blossom", quest = 156, oi = 1, count = 8 } } },
			{ goals = { { t = "kill", target = "Skeletal Horror", npc = 202, quest = 57, oi = 1, count = 15 } } },
			{ goals = { { t = "turnin", quest = 156, title = "Gather Rot Blossoms" }, { t = "turnin", quest = 57, title = "The Night Watch" } } },
		} })
	"#
	.to_owned()
		+ GUIDES;
	let night = "stub.world.onQuest(57, { { required = 15, fulfilled = 1 } })";
	// Opened for the player (as Start guide does, in place of the login's pick), so a guide passed whole chains
	// on.
	let script = r#"E.SetGuide(nil); E.OpenTab("test/dusk", true, true); flush(); emit({ guide = E.GetGuide().id, at = E.GetStepIndex() })"#;
	let not_done = run(
		&[
			r#"stub.world.level = 30
			stub.world.onQuest(156, { { type = "item", required = 8, fulfilled = 0 } })
			"#,
			night,
		]
		.concat(),
		&duskwood,
		&on(),
		script,
	);
	assert_eq!(not_done["guide"], "test/mid", "both too low and not done: the guide passes");
	let ready = run(
		&[
			r#"stub.world.level = 30
			stub.world.onQuest(156, { { type = "item", required = 8, fulfilled = 8 } })
			"#,
			night,
		]
		.concat(),
		&duskwood,
		&on(),
		script,
	);
	assert_eq!(ready, json!({ "guide": "test/dusk", "at": 5 }), "the blossoms gathered: the guide takes them to hand in");
}

#[test]
fn without_skip_grey_quests_the_guide_is_placed_as_before_the_first_quest_not_done_in_the_first_guide() {
	let out = run(DONE, GUIDES, OFF, r#"E.SetGuide("test/low"); flush(); emit({ guide = E.GetGuide().id, at = E.GetStepIndex() })"#);
	assert_eq!(out, json!({ "guide": "test/low", "at": 3 }), "the trip to the farm is behind a quest turned in");
}

#[test]
fn a_guide_that_is_not_a_leveling_one_does_every_step_an_item_guide_keeps_its_quests_grey_or_not() {
	let item = r#"
		Polestar.RegisterGuide({ id = "test/bag", pack = "test", title = "Bag", category = "Collectibles", minLevel = 14, maxLevel = 60, steps = {
			{ goals = { { t = "accept", quest = 301, title = "First clue", qlvl = 8 } } },
			{ goals = { { t = "turnin", quest = 301, title = "First clue" } } },
			{ goals = { { t = "accept", quest = 302, title = "Second clue", qlvl = 9 } } },
		} })
	"#;
	let out = run(
		"",
		item,
		&on(),
		&(STATUSES.to_owned()
			+ r#"
			E.SetGuide("test/bag"); flush()
			emit({ at = E.GetStepIndex(), statuses = statuses() })
		"#),
	);
	assert_eq!(out, json!({ "at": 1, "statuses": ["active", "pending", "pending"] }));
}

#[test]
fn a_quest_left_out_comes_back_when_the_player_takes_it_by_hand_and_a_level_the_guide_waits_for_keeps_it_from_passing_whole() {
	let by_hand = run(
		DONE,
		GUIDES,
		&on(),
		&(STATUSES.to_owned()
			+ r#"
			E.SetGuide("test/mid"); flush()
			stub.world.accept(201, {}, "Green behind"); flush()
			local s = statuses()
			emit({ accept = s[2], turnin = s[4] })
		"#),
	);
	assert_eq!(by_hand, json!({ "accept": "done", "turnin": "active" }), "its turn-in is the step now");

	// test/low with a quest for level 21: the guide is not passed whole.
	let waiting = GUIDES.replacen(r#"{ goals = { { t = "fly", location = "Stormwind City" } } },"#, r#"{ goals = { { t = "accept", quest = 103, title = "Later", qlvl = 21, minLevel = 21 } } },"#, 1);
	let held = run(DONE, &waiting, &on(), r#"E.SetGuide("test/low"); flush(); emit(E.GetGuide().id)"#);
	assert_eq!(held, "test/low");
}

#[test]
fn a_reload_places_the_saved_guide_again_at_the_same_step_without_a_catch_up_to_play_with_nothing_behind_the_player_the_guide_is_placed_as_before() {
	let reload = run(DONE, GUIDES, &catch_up_on("", r#"PolestarCharDB = { schema = 1, tabs = { "test/mid" }, activeTab = 1 }"#), "emit({ at = E.GetStepIndex(), placed = #PLACED })");
	assert_eq!(reload, json!({ "at": 5, "placed": 0 }), "GUIDE_PLACED is for a guide just opened");

	let fresh = run("", GUIDES, &on(), r#"E.SetGuide("test/mid"); flush(); emit(E.GetStepIndex())"#);
	assert_eq!(fresh, 1, "nothing done: the guide starts at its first step");
}

// Yendi: the first time, the guide starts from the race's first guide and goes through every guide to where the
// character is, for them to see.
#[test]
fn with_no_guide_open_at_login_the_catch_up_starts_from_the_first_guide_and_goes_through_to_where_the_character_is() {
	let out = run(
		DONE,
		GUIDES,
		&on(),
		"emit({ guide = E.GetGuide().id, at = E.GetStepIndex(), placed = PLACED[#PLACED], first = Polestar.Guides.FirstGuide(), suggest = Polestar.Guides.Suggest(), start = E.StartingGuide() })",
	);
	// The guide window's and the welcome's Start guide open E.StartingGuide() too.
	assert_eq!(out, json!({ "guide": "test/mid", "at": 5, "placed": { "id": "test/mid", "step": 5, "chain": "test/low" }, "first": "test/low", "suggest": "test/mid", "start": "test/low" }));

	// Without the catch-up, the guide for their level, as before.
	let off = run(DONE, GUIDES, "PolestarDB = { schema = 1, settings = { behavior = { skipGrey = false } } }; PolestarCharDB = nil", "emit(E.GetGuide().id)");
	assert_eq!(off, "test/mid");
}

// Yendi at 30 in Darkshore (15-18): The Tower of Althalaxx, grey and green there, leads to four quests at 28 and
// 31 in Ashenvale. In a guide the character is past, a low chain is worth the detour only when at least three
// quests from yellow up need it.
#[test]
fn in_a_guide_the_character_is_past_a_low_chain_stays_only_when_three_quests_from_yellow_up_need_it() {
	let guides = |worth: bool| {
		r#"
		Polestar.RegisterGuide({ id = "test/dark", pack = "test", title = "Darkshore", faction = "Alliance", minLevel = 10, maxLevel = 15, next = "test/ashen", steps = {
			{ goals = { { t = "accept", quest = 401, title = "Tower 1", qlvl = 12 } } },
			{ goals = { { t = "turnin", quest = 401, title = "Tower 1" }, { t = "accept", quest = 402, title = "Tower 2", qlvl = 14, pre = { 401 } } } },
			{ goals = { { t = "turnin", quest = 402, title = "Tower 2" } } },
			{ goals = { { t = "accept", quest = 403, title = "Lone low", qlvl = 12 } } },
			{ goals = { { t = "turnin", quest = 403, title = "Lone low" } } },
		} })
		Polestar.RegisterGuide({ id = "test/ashen", pack = "test", title = "Ashenvale", faction = "Alliance", minLevel = 18, maxLevel = 25, steps = {
			{ goals = { { t = "accept", quest = 410, title = "Tower 3", qlvl = 19, pre = { 402 } } } },
			{ goals = { { t = "turnin", quest = 410, title = "Tower 3" }, { t = "accept", quest = 411, title = "Tower 4", qlvl = 20, pre = { 410 } } } },
			@WORTH@
			{ goals = { { t = "accept", quest = 420, title = "After the lone one", qlvl = 19, pre = { 403 } } } },
			{ goals = { { t = "accept", quest = 430, title = "Ashenvale", qlvl = 20 } } },
		} })
	"#
		.replace("@WORTH@", if worth { r#"{ goals = { { t = "turnin", quest = 411, title = "Tower 4" }, { t = "accept", quest = 412, title = "Tower 5", qlvl = 21, pre = { 411 } } } },"# } else { "" })
	};
	let script = STATUSES.to_owned()
		+ r#"
		E.SetGuide(nil); E.OpenTab("test/dark", true, true); flush()
		emit({ guide = E.GetGuide().id, at = E.GetStepIndex() or false, statuses = E.GetGuide().id == "test/dark" and statuses() or false })"#;
	let three = run("", &guides(true), &on(), &script);
	assert_eq!(three, json!({ "guide": "test/dark", "at": 1, "statuses": ["active", "pending", "pending", "na", "na"] }), "three quests from yellow up: the chain stays, the lone low quest goes");
	let two = run("", &guides(false), &on(), &script);
	assert_eq!(two["guide"], "test/ashen", "two only: not worth the detour, the guide passes");
}

// Yendi: the guide list's check means every quest of the guide is done; a guide the catch-up passed whole with
// grey quests never done is not checked. A guide all done, opened by the player, stays open, finished.
#[test]
fn a_guide_the_catch_up_passed_whole_is_done_for_the_list_only_once_all_its_quests_are_opened_by_hand_it_stays() {
	let all_done = "stub.world.complete({ 101, 102, 104, 204 }); stub.world.onQuest(206, {})";
	let passed = run(DONE, GUIDES, &pick_off(), r#"E.StartGuide(); flush(); emit({ guide = E.GetGuide().id, low = E.GetGuideState("test/low") })"#);
	assert_eq!(passed, json!({ "guide": "test/mid", "low": "started" }), "passed with a grey quest never done: not done");
	let by_hand = run(DONE, GUIDES, &on(), r#"E.SetGuide("test/low"); flush(); emit({ guide = E.GetGuide().id, at = E.GetStepIndex() or false, low = E.GetGuideState("test/low") })"#);
	assert_eq!(by_hand, json!({ "guide": "test/low", "at": false, "low": "started" }), "opened by hand: it stays, not done for the list");
	let opened = run(all_done, GUIDES, &on(), r#"E.SetGuide("test/low"); flush(); emit({ guide = E.GetGuide().id, at = E.GetStepIndex() or false, low = E.GetGuideState("test/low") })"#);
	assert_eq!(opened, json!({ "guide": "test/low", "at": false, "low": "done" }), "all done and opened by hand: it stays, finished");
}

// Yendi: a catch-up stopped at the end of a guide ("Guide complete, Up next") on a second try in the session
// (the next guide had finished on the first), and on a quest whose prerequisite was a grey one it left out.
#[test]
fn a_catch_up_goes_on_to_the_next_guide_silently_on_a_second_try_and_past_a_quest_whose_prerequisite_it_left_out() {
	let guides = GUIDES.replacen(r#"maxLevel = 12, next = "test/mid""#, r#"maxLevel = 12, next = "test/low2""#, 1)
		+ r#"
		Polestar.RegisterGuide({ id = "test/low2", pack = "test", title = "Low 2", faction = "Alliance", minLevel = 8, maxLevel = 14, next = "test/mid", steps = {
			{ goals = { { t = "accept", quest = 150, title = "Grey start", qlvl = 8 } } },
			{ goals = { { t = "turnin", quest = 150, title = "Grey start" }, { t = "accept", quest = 152, title = "Yellow after it", qlvl = 19, pre = { 150 } } } },
			{ goals = { { t = "turnin", quest = 152, title = "Yellow after it" } } },
		} })
	"#;
	let out = run(
		DONE,
		&guides,
		&on(),
		r#"
			local first = { E.GetGuide().id, PLACED[#PLACED].chain }
			E.SetGuide(nil); E.StartGuide(); flush()
			emit({ first = first, again = { E.GetGuide().id, PLACED[#PLACED].chain } })"#,
	);
	assert_eq!(out["first"], json!(["test/mid", "test/low,test/low2"]), "the first run goes through both");
	assert_eq!(out["again"], json!(["test/mid", "test/low,test/low2"]), "a second try in the session too");
}

// Yendi: Start guide with no guide open stopped on "Guide complete" at the end of Dun Morogh, every quest of it
// done: it goes on to the next guide, as the login's pick does. The list's own open keeps a finished guide.
#[test]
fn start_guide_goes_on_through_guides_with_every_quest_done_the_list_keeps_such_a_guide_open() {
	let all_done = "stub.world.complete({ 101, 102, 104, 204 }); stub.world.onQuest(206, {})";
	let saved = pick_off();
	let start = run(all_done, GUIDES, &saved, "local none = E.GetGuide() == nil; E.StartGuide(); flush(); emit({ none = none, guide = E.GetGuide().id, at = E.GetStepIndex() or false })");
	assert_eq!(start, json!({ "none": true, "guide": "test/mid", "at": 5 }));
	let list = run(all_done, GUIDES, &saved, r#"E.OpenTab("test/low"); flush(); emit({ guide = E.GetGuide().id, at = E.GetStepIndex() or false })"#);
	assert_eq!(list, json!({ "guide": "test/low", "at": false }));
}

// Review of #300: a character who did nothing in a guide got its flight path, hearth and class training stored
// as done, because a grey quest after them was left out. Only travel goes with a quest left out ahead of the
// player's progress; the rest holds, as without the catch-up.
#[test]
fn a_quest_left_out_ahead_of_any_progress_takes_only_the_travel_to_it_no_flight_path_hearth_or_training_stored_as_done() {
	let guides = r#"
		Polestar.RegisterGuide({ id = "test/utility", pack = "test", title = "Utility", faction = "Alliance", minLevel = 15, maxLevel = 25, steps = {
			{ goals = { { t = "getfp", location = "Sentinel Hill" } } },
			{ goals = { { t = "sethome", location = "Lakeshire" } } },
			{ goals = { { t = "train", class = true, npc = 911, npcName = "Trainer" } } },
			{ goals = { { t = "goto", map = 1429, x = 40, y = 40, label = "Grey camp" } } },
			{ goals = { { t = "accept", quest = 501, title = "Grey", qlvl = 8 } } },
			{ goals = { { t = "accept", quest = 502, title = "Yellow", qlvl = 20 } } },
		} })
	"#;
	let out = run(
		"",
		guides,
		&on(),
		r#"E.SetGuide("test/utility"); flush()
			local m = PolestarCharDB.manual["test/utility"] or {}
			local keys = {}
			for k in pairs(m) do keys[#keys + 1] = k end
			table.sort(keys)
			emit({ at = E.GetStepIndex(), manual = table.concat(keys, ",") })"#,
	);
	assert_eq!(out, json!({ "at": 1, "manual": "4:1" }), "the guide starts with its flight path; only the way to the grey quest passes");
}

// Review of #300: with "Skip grey quests" on, a guide finished in normal play with a grey quest left out no
// longer showed as done in the guide list.
#[test]
fn a_guide_finished_in_play_is_done_for_the_list_a_grey_quest_left_out_or_not() {
	let guides = r#"
		Polestar.RegisterGuide({ id = "test/play", pack = "test", title = "Play", faction = "Alliance", minLevel = 18, maxLevel = 22, steps = {
			{ goals = { { t = "accept", quest = 601, title = "Grey", qlvl = 8 } } },
			{ goals = { { t = "accept", quest = 602, title = "Yellow", qlvl = 20 } } },
			{ goals = { { t = "turnin", quest = 602, title = "Yellow" } } },
		} })
	"#;
	let out = run(
		"",
		guides,
		&on(),
		r#"E.SetGuide("test/play"); flush()
			local at = E.GetStepIndex()
			stub.world.accept(602, {}, "Yellow"); flush()
			stub.world.turnIn(602); flush()
			emit({ at = at, finished = E.GetStepIndex() == nil, state = E.GetGuideState("test/play") })"#,
	);
	assert_eq!(out, json!({ "at": 2, "finished": true, "state": "done" }));
}

// Review of #300: levelling past a guide during play showed no outgrown banner (and so no hand-over) until a
// reload.
#[test]
fn levelling_past_a_guide_during_play_shows_the_outgrown_banner_the_catch_up_on_or_not() {
	let guides = r#"
		Polestar.RegisterGuide({ id = "test/young", pack = "test", title = "Young", faction = "Alliance", minLevel = 10, maxLevel = 16, steps = {
			{ goals = { { t = "accept", quest = 701, title = "Yellow then", qlvl = 15 } } },
			{ goals = { { t = "turnin", quest = 701, title = "Yellow then" } } },
		} })
		Polestar.RegisterGuide({ id = "test/older", pack = "test", title = "Older", faction = "Alliance", minLevel = 17, maxLevel = 24, steps = {
			{ goals = { { t = "accept", quest = 702, title = "Next", qlvl = 19 } } },
		} })
	"#;
	for saved in [on(), OFF.to_string()] {
		let out = run(
			"stub.world.level = 16",
			guides,
			&saved,
			r#"OUT = {}
				Polestar.On("GUIDE_OUTLEVELED", function(id, suggested) OUT[#OUT + 1] = id .. ">" .. tostring(suggested) end)
				E.SetGuide("test/young"); flush()
				local before = #OUT
				stub.world.setLevel(19); flush()
				emit({ before = before, banner = table.concat(OUT, ","), guide = E.GetGuide().id })"#,
		);
		assert_eq!(out, json!({ "before": 0, "banner": "test/young>test/older", "guide": "test/young" }));
	}
}

// Maintainer scope on #300: a guide opened by hand is placed within itself; it never jumps to the next guide on
// its own.
#[test]
fn a_guide_opened_by_hand_stays_though_the_catch_up_would_pass_it_whole() {
	let out = run(DONE, GUIDES, &on(), r#"E.SetGuide("test/low"); flush(); emit({ guide = E.GetGuide().id, placed = PLACED[#PLACED] })"#);
	assert_eq!(out["guide"], "test/low");
	assert_eq!(out["placed"], json!({ "id": "test/low", "step": false, "chain": "" }));
}
