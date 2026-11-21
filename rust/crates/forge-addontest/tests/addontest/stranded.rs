//! Stranded quests (jaff: "I always have grey quests that are completed in random spots that I haven't handed
//! in"): finished quests no open route hands in any more. RoutePlan.Carried, the guide window's "Still to do" row
//! and the Quest room's "carried" list (reached from that row or Make room: who takes each, Abandon on a grey one,
//! Guide me), the Lookup "carried" hand-in guide, and While-here hand-ins at their enders (Engine Own.hereStranded);
//! RoutePlan.LeftBehind: what a jump to another guide leaves (the outlevelled banner says it and asks once), the
//! engine suggesting the next guide over the level-best one while the guides between still hand in finished quests,
//! and the guide menu's Load asking once. Full addon, stub world, a stubbed Codex (the quests' XP and enders) and
//! Lookup.QuestEnd.
//!
//! Elwynn here is 3000 yd across (30 yd per map percent on x) and 2000 yd high (20 yd per percent on y).

use forge_addontest::{emitted, is_match, text, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "WARRIOR", "Warrior"
w.level = 11
w.zone, w.subzone = "Elwynn Forest", ""
w.moveTo(1429, 42.5, 36.0)
w.onQuest(33, { 8 }, "Wolves Across the Border")
w.onQuest(40, {}, "A Fishy Peril")
w.onQuest(41, {}, "Handed In Later")
w.onQuest(42, { 1 }, "Not Done Yet")
w.onQuest(44, {}, "Next Guide's")
w.onQuest(45, {}, "Carried On")
"#;

// test/a (1-10) -> test/b (8-11) -> test/c (11-15). A Fishy Peril (40, quest level 5, finished) is on no guide:
// Marshal Dughan (240) takes it in at 42.0,35.1, ~25 yd from the player. 41 (finished) is handed in at test/a's
// step 3, 44 (finished) in test/b, 42 is not finished; 45 (finished) is worked in test/a and carried to a later
// guide that isn't loaded (`carriedTo`).
const GUIDES: &str = r#"
local E1 = 1429
Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "A", faction = "Alliance", minLevel = 1, maxLevel = 10, next = "test/b", steps = {
	{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = E1, x = 60, y = 60 } } },
	{ title = "Far", goals = { { t = "goto", map = E1, x = 70, y = 70 } } },
	{ title = "Later", goals = { { t = "turnin", quest = 41, title = "Handed In Later", npc = 998, npcName = "Someone", map = E1, x = 70, y = 70 },
		{ t = "kill", target = "Bandit", npc = 116, count = 1, quest = 45, oi = 1, carriedTo = "test/z", map = E1, x = 70, y = 70 } } },
} })
Polestar.RegisterGuide({ id = "test/b", pack = "test", title = "B", faction = "Alliance", minLevel = 8, maxLevel = 11, next = "test/c", steps = {
	{ title = "Next", goals = { { t = "turnin", quest = 44, title = "Next Guide's", npc = 997, npcName = "Other", map = E1, x = 80, y = 80 } } },
} })
Polestar.RegisterGuide({ id = "test/c", pack = "test", title = "C", faction = "Alliance", minLevel = 11, maxLevel = 15, steps = {
	{ title = "Far", goals = { { t = "goto", map = E1, x = 10, y = 10 } } },
} })
"#;

const STUBS: &str = r#"
E, UI, w = Polestar.Engine, Polestar.UI, stub.world
function flush() stub.advance(0.6) end
function plain(t) return t and (t:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) or nil end
local X = Polestar.Codex
X.Load = function() return true end
X.IsLoaded = function() return true end
X.Quest = function(id)
	return { id = id, title = "Quest " .. id, faction = "A", level = id == 40 and 5 or 10, xp = 1000, ["end"] = (id == 40 or id == 46) and { npc = { 240 } } or nil }
end
Polestar.Lookup.QuestEnd = function(ends)
	if ends and ends.npc and ends.npc[1] == 240 then return { npc = 240, name = "Marshal Dughan", spawn = { map = 1429, x = 42.0, y = 35.1 } } end
	return nil
end
C_QuestLog.GetQuestDifficultyLevel = function(q) return q == 40 and 5 or 10 end
"#;

fn run(script: &str) -> Value {
	run_before(WORLD, script)
}

// The gamepad interface on as the addon loads (Core/Init.lua reads C_InputInterfaceStyle once).
const GAMEPAD: &str = "\nEnum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }\nC_InputInterfaceStyle = { GetCurrentStyle = function() return 1 end }\n";

fn run_before(before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: before.into(),
		addons: vec![Addon::name("Polestar")],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			GUIDES,
			STUBS,
			"stub.login()",
			r#"Polestar.Set("behavior.autoAccept", false); Polestar.Set("behavior.whileHereTurnins", true); Polestar.Set("ui.shown", true)"#,
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
fn a_finished_quest_no_route_hands_in_is_listed_with_its_ender_and_handed_in_while_here() {
	let out = run(r#"
		local r = {}
		-- RoutePlan.Carried: only 40 (41 and 44 are handed in ahead, 45 by a later guide, 42 is not finished).
		r.carried = {}
		for _, c in ipairs(Polestar.RoutePlan.Carried()) do r.carried[#r.carried + 1] = { c.quest, c.status, c.grey, c.xp } end
		-- While-here: the hand-in at Marshal Dughan, 25 yd off.
		r.here = {}
		for _, v in ipairs(E.GetWhileHereList()) do r.here[#r.here + 1] = { v.step, v.index, v.hereText, v.hereSub or false } end
		-- Make room's switch to the carried list.
		UI.ShowQuestRoom()
		local F = PolestarQuestRoom
		r.switch = { F.Switch:IsShown(), plain(F.Switch.Label:GetText()) }
		F.Switch:Click()
		r.room = { plain(F.Title:GetText()), plain(F.rows[1].Title:GetText()), plain(F.rows[1].Why:GetText()), F.rows[1].Abandon:IsShown(), F.GuideMe:IsShown(),
			plain(F.Switch.Label:GetText()) }
		-- Guide me: a hand-in guide, one stop at Dughan.
		F.GuideMe:Click(); flush()
		local g = E.GetGuide()
		r.guide = { g.id, g.steps[1].title, g.steps[1].goals[1].t, g.steps[1].goals[1].quest, #g.steps }
		emit(r)
	"#);
	assert_eq!(out["carried"], json!([[40, "unplanned", true, 800]]), "{out}");
	assert_eq!(out["here"], json!([[-2, 40, "Hand in “A Fishy Peril” to Marshal Dughan", "Not handed in on the route ahead"]]), "{out}");
	assert_eq!(out["switch"], json!([true, "Finished quests you're still carrying (1)"]), "{out}");
	assert_eq!(
		out["room"],
		json!(["Finished quests you're still carrying", "A Fishy Peril", "Grey: no XP any more  ·  Marshal Dughan, Elwynn Forest", true, true, "Make room in your quest log"]),
		"{out}"
	);
	assert_eq!(out["guide"], json!(["lookup/carried/log", "Marshal Dughan", "turnin", 40, 1]), "{out}");
}

// #2918 (Chm137): Auto turn-in hands in the guide's quests. A finished quest's stranded line is handed in by
// automation only when an open guide hands that quest in: A Fishy Peril (40), on no guide, is shown at Marshal
// Dughan and left to the player; 46, finished and handed in to Dughan at step 2 of test/d in another tab (its live
// step is 1), still is, and its line shows too.
#[test]
fn auto_turn_in_leaves_a_finished_quest_no_open_guide_hands_in_and_still_hands_in_another_tab_s_2918() {
	let out = run_before(
		&format!("{WORLD}w.onQuest(46, {{}}, \"Other Tab's\")\n"),
		r#"
		Polestar.RegisterGuide({ id = "test/d", pack = "test", title = "D", faction = "Alliance", minLevel = 1, maxLevel = 15, steps = {
			{ title = "Far", goals = { { t = "goto", map = 1429, x = 10, y = 10 } } },
			{ title = "Dughan", goals = { { t = "turnin", quest = 46, title = "Other Tab's", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 42.0, y = 35.1 } } },
		} })
		E.OpenTab("test/d", false); flush(); flush()
		local r = { guide = E.GetGuide().id, here = {} }
		for _, v in ipairs(E.GetWhileHereList()) do r.here[#r.here + 1] = { v.step, v.index } end
		table.sort(r.here, function(a, b) return a[2] < b[2] end)
		r.wants = { E.WantsQuest("turnin", 40), E.WantsQuest("turnin", 46) }
		emit(r)
	"#,
	);
	assert_eq!(out["guide"], "test/a", "{out}");
	assert_eq!(out["here"], json!([[-2, 40], [-2, 46]]), "{out}");
	assert_eq!(out["wants"], json!([false, true]), "{out}");
}

// LeftBehind counts the hand-ins placed on this route before the guide jumped to (41 in test/a, 44 in test/b),
// never 45, which a later guide beyond the plan hands in (no chapter on this route).
#[test]
fn outlevelled_the_engine_suggests_the_next_guide_while_the_guides_between_hand_in_finished_quests() {
	let out = run(r#"
		local r, fired = {}, {}
		Polestar.On("GUIDE_OUTLEVELED", function(id, s) fired[#fired + 1] = id .. ">" .. tostring(s) end)
		local P = Polestar.RoutePlan
		local c = P.LeftBehind("test/c")
		r.leftC, r.leftB = {}, P.LeftBehind("test/b").n
		for i, q in ipairs(c.quests) do r.leftC[i] = q.quest end
		-- Level 13: test/a (max 10) is outlevelled; the level-best guide is test/c, but test/b still hands in 44.
		w.setLevel(13); flush(); flush()
		r.fired = fired
		emit(r)
	"#);
	assert_eq!(out["leftC"], json!([41, 44]), "{out}");
	assert_eq!(out["leftB"], 1, "{out}");
	assert_eq!(out["fired"], json!(["test/a>test/b"]), "{out}");
}

#[test]
fn the_guide_menu_s_load_over_a_leveling_guide_asks_once_while_the_route_still_hands_in_finished_quests_before_it() {
	let out = run(r#"
		local Pk = Polestar.UI.Picker
		Pk.Load("test/c"); flush()
		local asked = stub.popups[#stub.popups]
		local r = { which = asked and asked.which or false, text = asked and asked.args[1] or false, stayed = E.GetGuide().id }
		Pk.Load("test/c", false, true); flush()
		r.loaded = E.GetGuide().id
		emit(r)
	"#);
	assert_eq!(out["which"], "POLESTAR_LEAVE_HANDINS", "{out}");
	assert!(is_match(text(&out["text"]), r"^2 finished quests in your log are handed in on the route before C \(\d{1,3}(,\d{3})* XP\)\. Load it anyway\?"), "{out}");
	assert_eq!(out["stayed"], "test/a", "{out}");
	assert_eq!(out["loaded"], "test/c", "{out}");
}

// With the gamepad interface its focus owns the game's dialogs: no popup; chat says what the jump leaves and the
// guide loads.
#[test]
fn with_the_gamepad_interface_the_guide_menu_s_load_says_in_chat_what_it_leaves_and_loads_without_a_popup() {
	let out = run_before(
		&[WORLD, GAMEPAD].concat(),
		r#"
		local before = #stub.popups
		Polestar.UI.Picker.Load("test/c"); flush()
		emit({ gamepad = Polestar.GamepadUI(), popups = #stub.popups - before, loaded = E.GetGuide().id,
			chat = plain(stub.messages[#stub.messages]) or false })
	"#,
	);
	assert_eq!(out["gamepad"], true, "{out}");
	assert_eq!(out["popups"], 0, "{out}");
	assert_eq!(out["loaded"], "test/c", "{out}");
	assert!(
		is_match(text(&out["chat"]), r"2 finished quests in your log are handed in on the route before C \(\d{1,3}(,\d{3})* XP\)\. They stay in your log, and the guide lists who takes each in\.$"),
		"{out}"
	);
}

// The guide window's "Still to do" list: one row for the finished quests no open route hands in (40 here; 41 and 44
// are handed in ahead, 45 by a later guide), with what they give, and a click opens the Quest room's carried list.
#[test]
fn the_guide_window_lists_the_finished_quests_no_route_hands_in_in_one_row_that_opens_the_carried_list() {
	let out = run(r#"
		local GF = Polestar.UI.GuideFrame
		GF.Render(); flush()
		local r, row = { rows = {} }, nil
		for _, x in ipairs(GF.alongRows) do
			if x:IsShown() then r.rows[#r.rows + 1] = plain(x.Text:GetText()); row = row or x end
		end
		r.header = plain(GF.parts.along.Label:GetText())
		row:GetScript("OnClick")(row, "LeftButton"); flush()
		local F = PolestarQuestRoom
		r.room = { F:IsShown(), plain(F.Title:GetText()), plain(F.rows[1].Title:GetText()) }
		emit(r)
	"#);
	assert_eq!(out["rows"], json!(["1 finished quest to hand in elsewhere (800 XP)"]), "{out}");
	assert_eq!(out["header"], "Still to do", "{out}");
	assert_eq!(out["room"], json!([true, "Finished quests you're still carrying", "A Fishy Peril"]), "{out}");
}

// A kill that ticks an objective (#2555): the client's burst (the quest log three times, the objective, XP, loot)
// is one evaluation, one step update and one tab update, and the row above is drawn again from the route plan as
// it stands: the plan is not rebuilt, so no walk over every registered guide (Guides.List from RoutePlan). A quest
// finished in the burst still joins the row. A tab opened in the background (other guides open) builds it afresh.
#[test]
fn a_kill_burst_repaints_the_carried_row_without_rebuilding_the_route_plan() {
	let out = run(r#"
		local GF, G = Polestar.UI.GuideFrame, Polestar.Guides
		GF.Render(); flush()
		local count = { plan = 0, STEP_UPDATED = 0, STEP_CHANGED = 0, TABS_CHANGED = 0 }
		local list = G.List
		G.List = function(...)
			if debug.getinfo(2, "S").source:find("RoutePlan.lua", 1, true) then count.plan = count.plan + 1 end
			return list(...)
		end
		for _, msg in ipairs({ "STEP_UPDATED", "STEP_CHANGED", "TABS_CHANGED" }) do
			Polestar.On(msg, function() count[msg] = count[msg] + 1 end)
		end
		local function kill(finish)
			stub.fire("PLAYER_REGEN_DISABLED")
			stub.advance(1)
			stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "Young Wolf dies, you gain 120 experience.")
			w.setXP((w.xp or 0) + 120)
			local o = w.log[33].objectives[1]
			w.progress(33, 1, o.numFulfilled + 1)
			if finish then w.finish(42) end
			stub.fire("QUEST_LOG_UPDATE")
			stub.fire("PLAYER_REGEN_ENABLED")
			stub.fire("LOOT_READY", true)
			stub.fire("LOOT_CLOSED")
			stub.fire("BAG_UPDATE", 0)
			stub.fire("BAG_UPDATE_DELAYED")
			stub.fire("QUEST_LOG_UPDATE")
			flush(); flush()
		end
		local function row()
			for _, x in ipairs(GF.alongRows) do
				if x:IsShown() and x.psCarried then return plain(x.Text:GetText()) end
			end
		end
		local r = { kills = {} }
		for k = 1, 3 do
			for key in pairs(count) do count[key] = 0 end
			kill(k == 3)
			r.kills[k] = { count.plan, count.STEP_UPDATED, count.STEP_CHANGED, count.TABS_CHANGED, row() }
		end
		count.plan = 0
		E.OpenTab("test/c", false); flush()
		local carried = #Polestar.RoutePlan.Carried()
		r.tab = { E.GetGuide().id, E.TabIds()["test/c"] == true, count.plan > 0, carried }
		G.List = list
		emit(r)
	"#);
	let kills = out["kills"].as_array().unwrap();
	for k in &kills[..2] {
		assert_eq!(k, &json!([0, 1, 0, 1, "1 finished quest to hand in elsewhere (800 XP)"]), "{out}");
	}
	assert_eq!(kills[2].as_array().unwrap()[..4], json!([0, 1, 0, 1]).as_array().unwrap()[..], "{out}");
	assert!(is_match(text(&kills[2][4]), r"^2 finished quests to hand in elsewhere \(\d{1,3}(,\d{3})* XP\)$"), "{out}");
	assert_eq!(out["tab"], json!(["test/a", true, true, 2]), "{out}");
}

// Outlevelled at 13, the banner says what the jump to the suggested guide (test/b) leaves behind: 41, handed in
// later in test/a. Its first click asks; the second jumps.
#[test]
fn outlevelled_the_banner_says_the_finished_quests_left_here_and_its_jump_asks_once() {
	let out = run(r#"
		local GF = Polestar.UI.GuideFrame
		w.setLevel(13); flush(); flush()
		GF.Render(); flush()
		local B = GF.parts.banner
		local function banner() return { plain(B.Text:GetText()), plain(B.Jump.Label:GetText()) } end
		local r = { first = banner() }
		B.Jump:Click(); flush()
		r.asked = { banner(), E.GetGuide().id }
		B.Jump:Click(); flush()
		r.jumped = E.GetGuide().id
		emit(r)
	"#);
	assert_eq!(out["first"], json!(["You have outlevelled this guide.\n1 finished quest here first (1,000 XP)", "Jump to B"]), "{out}");
	assert_eq!(
		out["asked"],
		json!([["You have outlevelled this guide.\n1 finished quest here first (1,000 XP)\nJump anyway? They stay in your log, and the guide lists who takes each in.", "Jump anyway"], "test/a"]),
		"{out}"
	);
	assert_eq!(out["jumped"], "test/b", "{out}");
}
