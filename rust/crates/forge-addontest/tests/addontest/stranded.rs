//! Stranded quests (jaff: "I always have grey quests that are completed in random spots that I haven't handed
//! in"): finished quests no open route hands in any more. RoutePlan.Carried, the Quest room's "carried" list
//! (reached from Make room: who takes each, Abandon on a grey one, Guide me), the Lookup "carried" hand-in guide,
//! and While-here hand-ins at their enders (Engine Own.hereStranded); RoutePlan.LeftBehind: what a jump to another
//! guide leaves, the engine suggesting the next guide over the level-best one while the guides between still hand
//! in finished quests, and the guide menu's Load asking once. Full addon, stub world, a stubbed Codex (the quests'
//! XP and enders) and Lookup.QuestEnd.
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
	return { id = id, title = "Quest " .. id, faction = "A", level = id == 40 and 5 or 10, xp = 1000, ["end"] = id == 40 and { npc = { 240 } } or nil }
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
		-- Level 12: test/a (max 10) is outlevelled; the level-best guide is test/c, but test/b still hands in 44.
		w.setLevel(12); flush(); flush()
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
	assert!(is_match(text(&out["text"]), r"^2 finished quests in your log are handed in on the route before C \(\d+ XP\)\. Load it anyway\?"), "{out}");
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
	assert!(is_match(text(&out["chat"]), r"2 finished quests in your log are handed in on the route before C \(\d+ XP\)\. They stay in your log, and the guide lists who takes each in\.$"), "{out}");
}
