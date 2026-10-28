//! Engine: what an NPC's window proves (#741). Opening a chat is not a check-off: a talk goal counts from the
//! player's own act there (a gossip option picked, a quest taken or handed in), an accept only from the quest
//! log, and a giver whose window does not offer the quest skips the accept with its reason, never as done.
//! Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1420, { name = "Tirisfal Glades", c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.moveTo(1420, 60, 52)
w.race, w.faction, w.class, w.className, w.level = "Scourge", "Horde", "WARLOCK", "Warlock", 7
w.titles[86784] = "Sticks and Bones"; w.titles[404] = "A Putrid Task"; w.titles[367] = "A New Plague"
"#;

// The Brill step as the route wrote it: Bartholomew's accept, a talk, Dillinger's accept, Johaan's accept.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/brill", pack = "test", title = "Brill", faction = "Horde", minLevel = 1, maxLevel = 12, steps = {
	{ title = "Brill", goals = {
		{ t = "accept", quest = 86784, title = "Sticks and Bones", npc = 1742, npcName = "Deathguard Bartholomew", map = 1420, x = 58.5, y = 51.4 },
		{ t = "talk", npc = 2127, npcName = "Rupert Boch", map = 1420, x = 61.6, y = 52.4 },
		{ t = "accept", quest = 404, title = "A Putrid Task", npc = 1496, npcName = "Deathguard Dillinger", map = 1420, x = 58.2, y = 51.5 },
		{ t = "accept", quest = 367, title = "A New Plague", npc = 1518, npcName = "Apothecary Johaan", map = 1420, x = 59.4, y = 52.4 },
	} },
	{ title = "Later", goals = { { t = "level", level = 30 } } },
} })
-- The live hub between Deathknell and the field, for the notices while the player pages (Prev/Next).
Polestar.RegisterGuide({ id = "test/paging", pack = "test", title = "Paging", faction = "Horde", minLevel = 1, maxLevel = 12, steps = {
	{ title = "Deathknell", goals = { { t = "turnin", quest = 380, title = "Night Web's Hollow", npc = 1570, npcName = "Executor Arren", map = 1420, x = 32.2, y = 65.9 } } },
	{ title = "Brill", goals = {
		{ t = "accept", quest = 86784, title = "Sticks and Bones", npc = 1742, npcName = "Deathguard Bartholomew", minLevel = 10, map = 1420, x = 58.5, y = 51.4 },
		{ t = "accept", quest = 404, title = "A Putrid Task", npc = 1496, npcName = "Deathguard Dillinger", map = 1420, x = 58.2, y = 51.5 },
	} },
	{ title = "Cold Hearth Manor", goals = { { t = "collect", item = 2855, itemName = "Putrid Claw", count = 7, quest = 404, oi = 1, map = 1420, x = 55, y = 56 } } },
	{ title = "Later", goals = { { t = "level", level = 30 } } },
} })
-- Gordo's Task: taken, worked, handed in (#739).
Polestar.RegisterGuide({ id = "test/ticked", pack = "test", title = "Gordo", faction = "Horde", minLevel = 1, maxLevel = 12, steps = {
	{ title = "Gordo", goals = { { t = "accept", quest = 5481, title = "Gordo's Task", npc = 10665, npcName = "Junior Apothecary Holland", map = 1420, x = 57.4, y = 48.9 } } },
	{ title = "Gloom Weed", goals = { { t = "collect", item = 12737, itemName = "Gloom Weed", count = 3, quest = 5481, oi = 1, map = 1420, x = 43.5, y = 53.3 } } },
	{ title = "Brill", goals = { { t = "turnin", quest = 5481, title = "Gordo's Task", npc = 10665, npcName = "Junior Apothecary Holland", map = 1420, x = 57.4, y = 48.9 } } },
	{ title = "Later", goals = { { t = "level", level = 30 } } },
} })
-- A trainer and a vendor, the vendor twice in a row.
Polestar.RegisterGuide({ id = "test/strict", pack = "test", title = "Strict", faction = "Horde", minLevel = 1, maxLevel = 12, steps = {
	{ title = "Train", goals = { { t = "train", class = true, candidates = {
		{ npc = 2127, npcName = "Rupert Boch", map = 1420, x = 61.6, y = 52.4, f = "e", faction = "H", classes = { "WARLOCK" } },
		{ npc = 2128, npcName = "Cain Firesong", map = 1420, x = 61.6, y = 52.5, f = "e", faction = "H", classes = { "MAGE" } },
	} } } },
	{ title = "Mrs. Winters", goals = { { t = "vendor", npc = 2134, npcName = "Mrs. Winters", map = 1420, x = 61.4, y = 53.0 } } },
	{ title = "Mrs. Winters again", goals = { { t = "vendor", npc = 2134, npcName = "Mrs. Winters", map = 1420, x = 61.4, y = 53.0 } } },
	{ title = "Later", goals = { { t = "level", level = 30 } } },
} })
"#;

const HELPERS: &str = r#"			E = Polestar.Engine
			function flush() stub.advance(0.25) end
			function brief()
				local out = {}
				for g, v in ipairs(E.GetStepView(1).goals) do out[g] = v.status .. (v.unavailableText and (":" .. v.unavailableText) or "") end
				return out
			end
			stub.login()
			E.SetGuide("test/brill")
			Polestar.Set("behavior.autoAccept", false) -- the tests take quests themselves
			flush()
			"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE}\n{HELPERS}{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn opening_an_unrelated_npc_s_chat_checks_off_no_talk_or_accept_goal() {
	let out = run(r#"
		local w = stub.world
		local r = { start = brief() }
		-- A guard with nothing for the player: gossip, a greeting, another quest's detail window.
		w.gossip(5000, { options = { { name = "Where is the inn?" } } }); flush(); w.close(); flush()
		w.greeting(5001, {}); flush(); w.close(); flush()
		w.questDetail(5002, 9999); flush(); w.close(); flush()
		r.unrelated = brief()
		-- An option picked at the unrelated NPC is that NPC's, not Rupert's.
		w.gossip(5000, { options = { { name = "Where is the inn?" } } }); C_GossipInfo.SelectOption(1); flush(); w.close(); flush()
		r.picked = brief()
		-- Rupert's own chat, opened and closed without a word.
		w.gossip(2127, { options = { { name = "I'd like to train." } } }); flush(); w.close(); flush()
		r.rupertOpened = brief()
		-- A step change while Rupert's chat is still open does not count it either.
		w.gossip(2127, { options = { { name = "I'd like to train." } } }); flush()
		r.rupertOpen = brief()
		C_GossipInfo.SelectOption(1); flush(); w.close(); flush()
		r.rupertPicked = brief()
		r.step = E.GetStepIndex()
		emit(r)
	"#);
	let open = json!(["active", "active", "active", "active"]);
	assert_eq!(out["start"], open);
	assert_eq!(out["unrelated"], open, "an unrelated NPC's gossip, greeting or quest window changes nothing");
	assert_eq!(out["picked"], open, "an option picked at another NPC is not the talk goal's");
	assert_eq!(out["rupertOpened"], open, "opening the talk goal's own NPC is not talking to them");
	assert_eq!(out["rupertOpen"], open);
	assert_eq!(out["rupertPicked"], json!(["active", "done", "active", "active"]), "picking an option there is");
	assert_eq!(out["step"], 1);
}

#[test]
fn a_quest_taken_or_handed_in_at_the_npc_checks_off_their_talk_goal() {
	let out = run(r#"
		local w = stub.world
		local r = {}
		w.titles[1478] = "Halgar's Summons"
		w.gossip(2127, { available = { { questID = 1478 } } }); flush()
		C_GossipInfo.SelectAvailableQuest(1478); flush()
		r.detail = brief()[2]
		AcceptQuest(); flush()
		r.accepted = brief()[2]
		emit(r)
	"#);
	assert_eq!(out["detail"], "active", "picking the quest from the list only opens its window");
	assert_eq!(out["accepted"], "done", "taking a quest there is talking to them");
}

#[test]
fn an_accept_counts_only_from_the_quest_log() {
	let out = run(r#"
		local w = stub.world
		local r = {}
		-- Dillinger offers the quest: listed, its window opened, declined.
		w.gossip(1496, { available = { { questID = 404 } } }); flush()
		r.listed = brief()[3]
		C_GossipInfo.SelectAvailableQuest(404); flush()
		r.detail = brief()[3]
		DeclineQuest(); flush()
		r.declined = brief()[3]
		-- The event alone, with the quest not in the log, proves nothing either.
		stub.fire("QUEST_ACCEPTED", 404); flush()
		r.eventOnly = brief()[3]
		-- Taken: in the log.
		w.gossip(1496, { available = { { questID = 404 } } }); C_GossipInfo.SelectAvailableQuest(404); AcceptQuest(); flush()
		r.taken = brief()[3]
		r.inLog = Polestar.Compat.IsOnQuest(404)
		emit(r)
	"#);
	assert_eq!(out["listed"], "active");
	assert_eq!(out["detail"], "active");
	assert_eq!(out["declined"], "active", "a declined quest is not taken");
	assert_eq!(out["eventOnly"], "active", "only the quest log says a quest is taken");
	assert_eq!(out["taken"], "done");
	assert_eq!(out["inLog"], true);
}

#[test]
fn a_giver_who_does_not_offer_the_quest_never_skips_it_the_line_asks_for_a_report_and_the_arrow_stays() {
	let out = run(r#"
		local w = stub.world
		local r = {}
		-- Bartholomew's chat without his quest (#741: the server's giver offers nothing).
		w.gossip(1742, { options = { { name = "Hello." } } }); flush(); w.close(); flush()
		r.after = brief()
		r.notice = E.GetStepView(1).goals[1].noticeText
		r.step = E.GetStepIndex()
		local wp = E.GetWaypoint()
		r.arrow = wp and wp.goalIndex or false
		-- His window listing it later takes the line back to a plain accept.
		w.gossip(1742, { available = { { questID = 86784 } } }); flush(); w.close(); flush()
		r.listed = E.GetStepView(1).goals[1].noticeText or false
		emit(r)
	"#);
	assert_eq!(out["after"], json!(["active", "active", "active", "active"]), "not skipped: still to do");
	assert_eq!(out["notice"], "Not offered by Deathguard Bartholomew? Report it with /polestar");
	assert_eq!(out["step"], 1);
	assert_eq!(out["arrow"], 1, "the arrow stays on Bartholomew");
	assert_eq!(out["listed"], false);
}

#[test]
fn not_offered_is_never_kept_across_a_logout_and_older_saved_marks_are_dropped() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!(
			"{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE}\n{}",
			r#"
			E = Polestar.Engine
			-- An older save holding Bartholomew's refusal.
			PolestarCharDB = { offers = { [86784] = true } }
			stub.login()
			E.SetGuide("test/brill")
			stub.advance(0.5)
			local g = E.GetStepView(1).goals[1]
			emit({ status = g.status, unavailable = g.unavailable or false, saved = PolestarCharDB.offers or false })
		"#
		),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out, json!({ "status": "active", "unavailable": false, "saved": false }));
}

#[test]
fn a_hand_ticked_accept_whose_quest_is_not_in_the_log_stays_open_says_so_and_keeps_its_turn_in() {
	let out = run(r#"
		local w = stub.world
		local r = {}
		E.SetGuide("test/ticked"); flush()
		-- Gordo's accept ticked by hand; the quest never reached the log (#739).
		r.tick = E.ToggleGoal(1, 1); flush()
		local v = E.GetStepView(1).goals[1]
		r.accept = v.status
		r.notice = v.noticeText
		r.step = E.GetStepIndex()
		local wp = E.GetWaypoint()
		r.arrow = wp and wp.goalIndex or false
		r.turnin = E.GetStepView(3).goals[1].status
		-- Taken for real: done, the notice gone.
		w.accept(5481, { 3 }); flush()
		r.taken = E.GetStepView(1).goals[1].status
		r.after = E.GetStepView(1).goals[1].noticeText or false
		emit(r)
	"#);
	assert_eq!(out["tick"], true);
	assert_eq!(out["accept"], "active", "a tick never stands for the quest log");
	assert_eq!(out["notice"], "Gordo's Task isn't in your quest log");
	assert_eq!(out["step"], 1, "the guide stays at the giver");
	assert_eq!(out["arrow"], 1, "the accept is the arrow's target again");
	assert_eq!(out["turnin"], "pending", "its hand-in is not hidden as not applying");
	assert_eq!(out["taken"], "done");
	assert_eq!(out["after"], false);
}

#[test]
fn a_train_goal_ticks_only_on_a_spell_learned_at_a_trainer_of_the_character_s_class() {
	let out = run(r#"
		local w = stub.world
		local r = {}
		E.SetGuide("test/strict"); flush()
		local function st() return E.GetStepView(1).goals[1].status end
		w.trainer(2127); flush(); r.opened = st()
		w.close(); flush()
		-- The Mage trainer, a candidate of the goal but not for a Warlock, teaching a spell.
		w.trainer(2128); w.learnSpell(116); flush(); r.otherClass = st()
		w.close(); flush()
		-- A spell learned with no trainer open (a quest reward) is not training.
		w.learnSpell(1454); flush(); r.noTrainer = st()
		-- Rupert teaches one.
		w.trainer(2127); w.learnSpell(172); flush(); r.learned = st()
		w.close(); flush()
		r.step = E.GetStepIndex()
		emit(r)
	"#);
	assert_eq!(out["opened"], "active", "the window opening is not training");
	assert_eq!(out["otherClass"], "active", "another class's trainer does not count");
	assert_eq!(out["noTrainer"], "active");
	assert_eq!(out["learned"], "done");
	assert_eq!(out["step"], 2);
}

#[test]
fn a_vendor_goal_needs_that_vendor_and_no_window_open_at_a_step_change_ticks_the_next_step() {
	let out = run(r#"
		local w = stub.world
		local r = {}
		E.SetGuide("test/strict"); flush()
		E.ToggleGoal(1, 1); flush() -- past the trainer (a train goal ticks by hand)
		r.start = E.GetStepIndex()
		w.merchant(2135); flush(); w.close(); flush()
		r.otherVendor = E.GetStepView(2).goals[1].status
		-- Mrs. Winters' window: step 2 done, step 3 (her again) comes up while it is still open.
		w.merchant(2134); flush(); flush()
		r.live = E.GetStepIndex()
		r.carried = E.GetStepView(3).goals[1].status
		w.close(); flush()
		-- Opened again while step 3 is live: it counts.
		w.merchant(2134); flush(); w.close(); flush()
		r.reopened = E.GetStepView(3).goals[1].status
		emit(r)
	"#);
	assert_eq!(out["start"], 2);
	assert_eq!(out["otherVendor"], "active", "another vendor's window is not this vendor");
	assert_eq!(out["live"], 3);
	assert_eq!(out["carried"], "active", "a window still open at the step change counts for nothing in the new step");
	assert_eq!(out["reopened"], "done");
}

#[test]
fn a_quest_passed_over_while_the_player_looks_at_another_step_is_announced_once_back_on_the_live_step() {
	let out = run(r#"
		local w = stub.world
		local r, events = {}, {}
		Polestar.On("STEP_SKIPPED", function(from, to, skips)
			local quests = {}
			for i, k in ipairs(skips) do quests[i] = k.quest .. ":" .. tostring(k.text) end
			events[#events + 1] = { from = from, to = to, quests = quests, shown = E.GetStepIndex() }
		end)
		w.complete({ 380 })
		E.SetGuide("test/paging"); flush(); flush()
		r.start = E.GetStepIndex()
		-- Bartholomew's window without his quest, the player below its level: skipped in the live hub,
		-- which stays live for Dillinger.
		w.gossip(1742, {}); w.close(); flush()
		r.inStep = #events
		-- The player looks back at Deathknell, and takes Dillinger's quest meanwhile: the live step moves on.
		E.Prev(); flush()
		r.viewing = E.GetStepIndex()
		w.accept(404, { 7 }); flush()
		r.live = E.GetLiveStep()
		r.whileLooking = #events
		-- Back to the live step straight from Deathknell ("Back to step N"): the notice comes with it, once.
		E.Goto(r.live); flush()
		r.back = E.GetStepIndex()
		flush(); flush()
		r.events = events
		emit(r)
	"#);
	assert_eq!(out["start"], 2);
	assert_eq!(out["inStep"], 0, "within the live step the row says it (the card), not a banner");
	assert_eq!(out["viewing"], 1);
	assert_eq!(out["live"], 3);
	assert_eq!(out["whileLooking"], 0, "the notice waits while the player looks elsewhere");
	assert_eq!(out["back"], 3);
	assert_eq!(
		out["events"],
		json!([{ "from": 2, "to": 3, "quests": ["86784:Requires level 10"], "shown": 1 }]),
		"said once, with the live step coming up (STEP_SKIPPED before STEP_CHANGED)"
	);
}
