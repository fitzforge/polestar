//! Stranded quests (plan 0.3.7, jaff's report: "I always have grey quests that are completed in random spots that I
//! haven't handed in"): finished quests the route no longer hands in. (A) RoutePlan.Carried and the guide window's
//! "Still to do" row, the Quest room's "carried" list (who takes each, Abandon on a grey one, Guide me), the Lookup
//! "carried" hand-in guide, and While-here hand-ins at their enders (Engine Own.hereStranded); (B) the outlevelled
//! banner says what a jump leaves behind and asks once, and suggests the next guide over the level-best one while
//! the guides between still hand in finished quests (RoutePlan.LeftBehind). Full addon, stub world, a stubbed
//! Codex (the quests' XP and enders) and Lookup.QuestEnd.
//!
//! Elwynn here is 3000 yd across (30 yd per map percent on x) and 2000 yd high (20 yd per percent on y).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
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
"#;

// test/a (1-10) -> test/b (8-11) -> test/c (11-15). A Fishy Peril (40, quest level 5, finished) is on no guide:
// Marshal Dughan (240) takes it in at 42.0,35.1, ~25 yd from the player. 41 (finished) is handed in at test/a's
// step 3, 44 (finished) in test/b, 42 is not finished.
const GUIDES: &str = r#"
local E1 = 1429
Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "A", faction = "Alliance", minLevel = 1, maxLevel = 10, next = "test/b", steps = {
	{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = E1, x = 60, y = 60 } } },
	{ title = "Far", goals = { { t = "goto", map = E1, x = 70, y = 70 } } },
	{ title = "Later", goals = { { t = "turnin", quest = 41, title = "Handed In Later", npc = 998, npcName = "Someone", map = E1, x = 70, y = 70 } } },
} })
Polestar.RegisterGuide({ id = "test/b", pack = "test", title = "B", faction = "Alliance", minLevel = 8, maxLevel = 11, next = "test/c", steps = {
	{ title = "Next", goals = { { t = "turnin", quest = 44, title = "Next Guide's", npc = 997, npcName = "Other", map = E1, x = 80, y = 80 } } },
} })
Polestar.RegisterGuide({ id = "test/c", pack = "test", title = "C", faction = "Alliance", minLevel = 11, maxLevel = 15, steps = {
	{ title = "Far", goals = { { t = "goto", map = E1, x = 10, y = 10 } } },
} })
"#;

const STUBS: &str = r#"
E, GF, UI, w = Polestar.Engine, Polestar.UI.GuideFrame, Polestar.UI, stub.world
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
fn a_finished_quest_the_route_never_hands_in_is_listed_with_its_ender_and_handed_in_while_here() {
	let out = run(r#"
		local r = {}
		-- RoutePlan.Carried: only 40 (41 and 44 are handed in ahead, 42 is not finished).
		r.carried = {}
		for _, c in ipairs(Polestar.RoutePlan.Carried()) do r.carried[#r.carried + 1] = { c.quest, c.status, c.grey, c.xp } end
		-- While-here: the hand-in at Marshal Dughan, 25 yd off.
		r.here = {}
		for _, v in ipairs(E.GetWhileHereList()) do r.here[#r.here + 1] = { v.step, v.index, v.hereText, v.hereSub or false } end
		-- The guide window's row.
		GF.Render(); flush()
		r.rows = {}
		for _, row in ipairs(GF.alongRows) do if row:IsShown() then r.rows[#r.rows + 1] = plain(row.Text:GetText()) end end
		r.header = plain(GF.parts.along.Label:GetText())
		-- The Quest room's list.
		UI.ShowQuestRoom("carried")
		local F = PolestarQuestRoom
		r.room = { plain(F.Title:GetText()), plain(F.rows[1].Title:GetText()), plain(F.rows[1].Why:GetText()), F.rows[1].Abandon:IsShown(), F.GuideMe:IsShown() }
		-- Guide me: a hand-in guide, one stop at Dughan.
		F.GuideMe:Click(); flush()
		local g = E.GetGuide()
		r.guide = { g.id, g.steps[1].title, g.steps[1].goals[1].t, g.steps[1].goals[1].quest, #g.steps }
		emit(r)
	"#);
	assert_eq!(out["carried"], json!([[40, "unplanned", true, 800]]), "{out}");
	assert_eq!(out["here"], json!([[-2, 40, "Hand in “A Fishy Peril” to Marshal Dughan", "Not handed in on the route ahead"]]), "{out}");
	assert_eq!(out["header"], "Still to do", "{out}");
	assert_eq!(out["rows"], json!(["1 finished quest to hand in elsewhere, 800 XP"]), "{out}");
	assert_eq!(
		out["room"],
		json!(["Finished quests you're still carrying", "A Fishy Peril", "Grey: no XP any more  ·  Marshal Dughan, Elwynn Forest", true, true]),
		"{out}"
	);
	assert_eq!(out["guide"], json!(["lookup/carried/log", "Marshal Dughan", "turnin", 40, 1]), "{out}");
}

#[test]
fn outlevelled_the_banner_says_the_finished_quests_left_here_asks_once_and_suggests_the_next_guide() {
	let out = run(r#"
		local r, fired = {}, {}
		Polestar.On("GUIDE_OUTLEVELED", function(id, s) fired[#fired + 1] = id .. ">" .. tostring(s) end)
		local P = Polestar.RoutePlan
		r.leftC, r.leftB = P.LeftBehind("test/c").n, P.LeftBehind("test/b").n
		-- Level 12: test/a (max 10) is outlevelled; the level-best guide is test/c, but test/b still hands in 44.
		w.setLevel(12); flush(); flush()
		r.fired = fired
		local B = GF.parts.banner
		local function banner() return { plain(B.Text:GetText()), plain(B.Jump.Label:GetText()) } end
		r.first = banner()
		B.Jump:Click(); flush()
		r.asked = { banner(), E.GetGuide().id }
		B.Jump:Click(); flush()
		r.jumped = E.GetGuide().id
		emit(r)
	"#);
	assert_eq!(json!([out["leftC"], out["leftB"]]), json!([2, 1]), "{out}");
	assert_eq!(out["fired"], json!(["test/a>test/b"]), "{out}");
	assert_eq!(out["first"], json!(["You have outlevelled this guide.\n1 finished quest here first (1000 XP)", "Jump to B"]), "{out}");
	assert_eq!(
		out["asked"],
		json!([["You have outlevelled this guide.\n1 finished quest here first (1000 XP)\nJump anyway? They stay in your log, and the guide lists who takes each in.", "Jump anyway"], "test/a"]),
		"{out}"
	);
	assert_eq!(out["jumped"], "test/b", "{out}");
}
