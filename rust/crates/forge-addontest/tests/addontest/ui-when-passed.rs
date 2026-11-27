//! #4158: a step the route passed for the character (its `when` failed as the route reached it) is stored as
//! skipped, as the player's own skip is, with the route's mark beside it (CharState().whenPassed, Engine
//! Own.markPassed). The step browser (UI/StepList.lua) says "Not for you: " and why (the view's `passed`,
//! Own.passedLine), naming the guide of the route that takes the quest when it is another guide
//! (RoutePlan.TakenIn), with no Unskip; a step the player skipped keeps "You skipped this step." and its Unskip,
//! whatever its `when` does later. The guide window's banner offers no unskip for a passed step either, and the end
//! card (GF.EndQuestLines) lists the quest chains the guide left out. Full addon, stub world, a fixture route.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "WARRIOR", "Warrior"
w.level = 11
w.zone, w.subzone = "Elwynn Forest", ""
w.moveTo(1429, 42.5, 36.0)
w.onQuest(97, { 1 }, "Carried Errand")
"#;

// test/a ("The Barrens") takes 90, 93 and 89; test/b ("Stonetalon") comes after it. In test/b, steps 2, 4, 5 and 6
// need 90 handed in (test/a's quest), step 3 needs 93 handed in (taken on test/b's step 1 as well: the guide's own
// accept, so no guide is named), step 7 needs 80 (no guide takes it), step 8 is a branch for Durotar, step 9 needs
// 89 ready to hand in, step 10 needs 91 in the log (taken only on step 2), step 11 is for level 50. test/c: steps the player skips while their `when` holds. test/d:
// nothing to leave out.
const GUIDES: &str = r#"
local E1 = 1429
local function at(t) t.npc, t.npcName, t.map, t.x, t.y = 240, "Someone", E1, 42, 35; return t end
local function acc(q, title) return at({ t = "accept", quest = q, title = title }) end
Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "The Barrens", faction = "Alliance", minLevel = 1, maxLevel = 10, next = "test/b", steps = {
	{ title = "Errand", goals = { acc(90, "Goblin Errand"), acc(93, "Own Errand"), acc(89, "Ready Errand") } },
	{ title = "Errand back", goals = { at({ t = "turnin", quest = 90, title = "Goblin Errand" }) } },
} })
local function needs(q) return { { k = "turnedin", q = q } } end
Polestar.RegisterGuide({ id = "test/b", pack = "test", title = "Stonetalon", faction = "Alliance", minLevel = 10, maxLevel = 15, steps = {
	{ title = "Taker", goals = { acc(93, "Own Errand") } },
	{ title = "Seereth Stonebreak", when = needs(90), goals = { acc(91, "Venture Errand") } },
	{ title = "Own chain", when = needs(93), goals = { acc(94, "Own Follow-up") } },
	{ title = "Shredders", when = needs(90), goals = { acc(95, "Shredder Errand") } },
	{ title = "Gerenzo", when = needs(90), goals = { acc(85, "Gerenzo Errand") } },
	{ title = "Flying Machine", when = needs(90), goals = { acc(86, "Machine Errand") } },
	{ title = "Far errand", when = needs(80), goals = { acc(87, "Far Follow-up") } },
	{ title = "Fly to Ratchet", when = { { k = "zone", name = "Durotar" } }, goals = { acc(88, "Ratchet Errand") } },
	{ title = "Ready", when = { { k = "complete", q = 89 } }, goals = { acc(84, "Ready Follow-up") } },
	{ title = "Venture follow-up", when = { { k = "onquest", q = { 91 } } }, goals = { acc(79, "Venture Follow-up") } },
	{ title = "Late", when = { { k = "level", op = ">=", n = 50 } }, goals = { acc(83, "Late Errand") } },
	{ title = "Last", goals = { acc(96, "Last Errand") } },
} })
Polestar.RegisterGuide({ id = "test/c", pack = "test", title = "Skips", faction = "Alliance", minLevel = 10, maxLevel = 15, steps = {
	{ title = "On errand", when = { { k = "onquest", q = { 97 } } }, goals = { acc(98, "Side Errand") } },
	{ title = "Before hand-in", when = { { k = "turnedin", q = 92, neg = true } }, goals = { acc(99, "Other Errand") } },
	{ title = "Last", goals = { acc(96, "Last Errand") } },
} })
Polestar.RegisterGuide({ id = "test/d", pack = "test", title = "Plain", faction = "Alliance", minLevel = 10, maxLevel = 15, steps = {
	{ title = "Only", goals = { acc(82, "Plain Errand") } },
} })
Polestar.RegisterGuide({ id = "test/e", pack = "test", title = "Gates", faction = "Alliance", minLevel = 10, maxLevel = 15, steps = {
	{ title = "Start", goals = { acc(100, "Start Errand") } },
	{ title = "Trainer", when = { { k = "level", op = ">=", n = 12 } }, goals = { acc(106, "Trainer Errand") } },
	{ title = "Gate", when = needs(90), goals = { acc(107, "Gate Errand") } },
	{ title = "Plain", goals = { acc(108, "Plain Errand") } },
	{ title = "Last", goals = { acc(104, "Last Errand") } },
} })
Polestar.RegisterGuide({ id = "test/f", pack = "test", title = "Reset", faction = "Alliance", minLevel = 10, maxLevel = 15, steps = {
	{ title = "Start", goals = { acc(100, "Start Errand") } },
	{ title = "Early gate", when = needs(90), goals = { acc(109, "Early Errand") } },
	{ title = "Plain", goals = { acc(108, "Plain Errand") } },
	{ title = "Gate", when = needs(90), goals = { acc(107, "Gate Errand") } },
	{ title = "Last", goals = { acc(104, "Last Errand") } },
} })
"#;

const STUBS: &str = r#"
E, UI, w, SL, GF = Polestar.Engine, Polestar.UI, stub.world, Polestar.UI.StepList, Polestar.UI.GuideFrame
function flush() stub.advance(0.6) end
function plain(t) return t and (t:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) or nil end
-- The step browser's cards for steps 1..upto: { tab, lines, the lines' Unskip shown }.
function cards(upto)
	SL.Toggle(true); stub.advance(0.3)
	local out = {}
	for i = 1, SL.n do
		local r = SL.rows[i]
		if r.psIndex and r.psIndex <= upto then
			local lines, unskip = {}, {}
			for j = 1, r.psN do
				lines[j] = plain(r.G[j].Text:GetText())
				unskip[j] = r.G[j].Unskip:IsShown()
			end
			out[#out + 1] = { tab = plain(r.Tab:GetText()), lines = lines, unskip = unskip }
		end
	end
	return out
end
function tabs()
	local out = {}
	for i = 1, SL.n do out[i] = plain(SL.rows[i].Tab:GetText()) end
	return out
end
-- Guide id's saved skips and route marks, as sorted step lists.
function marks(id)
	local st = Polestar.CharState()
	local function keys(t)
		local out = {}
		for k, v in pairs(t or {}) do if type(k) == "number" and v then out[#out + 1] = k end end
		table.sort(out)
		return table.concat(out, ",")
	end
	return { skipped = keys(st.skipped[id]), passed = keys(st.whenPassed[id]) }
end
-- The end card's left-out line: its text when shown, else false.
function leftOut()
	GF.Layout(); flush()
	local l = GF.parts.empty.LeftOut
	return l:IsShown() and plain(l:GetText()) or false
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
			script,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0)
}

// test/b opened fresh: the player skips step 1, so the steps after it whose `when` fails are passed by the route.
const SKIP_FIRST: &str = r#"E.SetGuide("test/b"); flush(); flush()
		local first = E.GetStepIndex()
		E.Skip(); flush(); flush()"#;

const WHY90: &str = "needs \u{201c}Goblin Errand\u{201d} handed in (The Barrens guide)";
const WHY93: &str = "needs \u{201c}Own Errand\u{201d} handed in";

fn not_for_you(why: &str) -> String {
	format!("Not for you: {why}")
}

#[test]
fn a_step_the_route_passed_says_why_with_no_unskip_and_the_player_s_own_skip_keeps_its_unskip_4158() {
	let out = run(&(SKIP_FIRST.to_owned()
		+ r#"
		local r = { first = first, live = E.GetLiveStep(), cards = cards(9), skips = SL.Skips() }
		local v2 = E.GetStepView(2)
		r.view = { skipped = v2.skipped, passed = v2.passed or false, why = v2.why or false }
		-- The player's skip: its Unskip brings step 1 back, and with it the steps the skip passed (Own.skipRestore):
		-- not reached yet, they do not apply (one "Skipped for you" card).
		local u = SL.rows[1].G[1].Unskip
		u:GetScript("OnClick")(u); flush()
		r.unskipped = { live = E.GetLiveStep(), cards = cards(1), tabs = tabs() }
		emit(r)
	"#));
	assert_eq!(out["first"], 1, "{out}");
	assert_eq!(out["live"], 12, "{out}");
	let ready = "Not for you: needs \u{201c}Ready Errand\u{201d} ready to hand in (The Barrens guide)";
	assert_eq!(
		out["cards"],
		json!([
			{ "tab": "1 \u{b7} Taker", "lines": ["You skipped this step."], "unskip": [true] },
			{ "tab": "2 \u{b7} Seereth Stonebreak", "lines": [not_for_you(WHY90)], "unskip": [false] },
			{ "tab": "3 \u{b7} Own chain", "lines": [not_for_you(WHY93)], "unskip": [false] },
			{ "tab": "4 \u{b7} Shredders", "lines": [not_for_you(WHY90)], "unskip": [false] },
			{ "tab": "5 \u{b7} Gerenzo", "lines": [not_for_you(WHY90)], "unskip": [false] },
			{ "tab": "6 \u{b7} Flying Machine", "lines": [not_for_you(WHY90)], "unskip": [false] },
			{ "tab": "7 \u{b7} Far errand", "lines": [not_for_you("needs \u{201c}Quest 80\u{201d} handed in")], "unskip": [false] },
			{ "tab": "8 \u{b7} Fly to Ratchet", "lines": ["Skipped for your character: its conditions do not hold"], "unskip": [false] },
			{ "tab": "9 \u{b7} Ready", "lines": [ready], "unskip": [false] },
		]),
		"the guide that takes the quest is named only when it is another guide: {out}"
	);
	assert_eq!(out["skips"], 1, "only the player's skip is one they set aside: {out}");
	assert_eq!(out["view"], json!({ "skipped": true, "passed": not_for_you(WHY90), "why": not_for_you(WHY90) }), "{out}");
	assert_eq!(out["unskipped"]["live"], 1, "Unskip brings the player's skip back: {out}");
	assert_eq!(out["unskipped"]["cards"][0]["lines"], json!(["Talk to Someone", "Accept \u{201c}Own Errand\u{201d}"]), "{out}");
	assert_eq!(out["unskipped"]["tabs"], json!(["1 \u{b7} Taker", "2\u{2013}11 \u{b7} Skipped for you", "12 \u{b7} Last"]), "{out}");
}

// Fable's review of #4158: a step the player skipped while its `when` held, whose `when` fails later (the quest
// abandoned, the other quest handed in), is still the player's skip: "You skipped this step." and its Unskip, counted
// as set aside, never on the end card.
#[test]
fn a_step_the_player_skipped_stays_theirs_when_its_when_stops_holding_later_4158() {
	let out = run(r#"
		E.SetGuide("test/c"); flush(); flush()
		local r = { at = E.GetStepIndex() }
		-- A route's mark left on step 1 (a save edited by hand, a step moved): the player's skip drops it.
		Polestar.CharState().whenPassed["test/c"] = { [1] = true }
		E.Skip(); flush(); flush()
		E.Skip(); flush(); flush()
		r.live = E.GetLiveStep()
		w.abandon(97); w.complete({ 92 }); stub.fire("QUEST_LOG_UPDATE"); flush(); flush()
		r.cards, r.skips, r.passed = cards(2), SL.Skips(), #E.WhenPassed()
		local u = SL.rows[1].G[1].Unskip
		u:GetScript("OnClick")(u); flush()
		r.unskipped = E.GetLiveStep()
		emit(r)
	"#);
	assert_eq!((out["at"].clone(), out["live"].clone()), (json!(1), json!(3)), "{out}");
	assert_eq!(
		out["cards"],
		json!([
			{ "tab": "1 \u{b7} On errand", "lines": ["You skipped this step."], "unskip": [true] },
			{ "tab": "2 \u{b7} Before hand-in", "lines": ["You skipped this step."], "unskip": [true] },
		]),
		"{out}"
	);
	assert_eq!(out["skips"], 2, "{out}");
	assert_eq!(out["passed"], 0, "{out}");
	assert_eq!(out["unskipped"], 1, "Unskip brings the step back: {out}");
}

// A step the route passed in normal play (not around a skip of the player's) whose `when` holds later is still the
// route's: no "You skipped this step", and not counted as set aside. It says the guide passed it and offers Unskip
// (in the list and the banner), which brings it back and drops the route's mark.
#[test]
fn a_step_the_route_passed_in_play_says_so_once_its_when_holds_and_unskip_brings_it_back_4158() {
	let out = run(r#"
		E.SetGuide("test/b"); flush(); flush()
		w.accept(93); flush(); flush()
		local r = { live = E.GetLiveStep() }
		w.complete({ 90 }); stub.fire("QUEST_LOG_UPDATE"); flush(); flush()
		r.cards, r.skips = cards(2), SL.Skips()
		SL.Toggle(false); stub.advance(0.3)
		GF.Layout(); flush()
		local B = GF.parts.banner
		for _ = 1, 12 do if E.GetStepIndex() > 2 then E.Prev() end end
		flush()
		r.banner = { E.GetStepIndex(), B:IsShown() and plain(B.Text:GetText()) or false, B:IsShown() and plain(B.Jump.Label:GetText()) or false }
		cards(2)
		local u = SL.rows[2].G[1].Unskip
		u:GetScript("OnClick")(u); flush()
		local st = Polestar.CharState()
		r.after = { live = E.GetLiveStep(), skipped = (st.skipped["test/b"] or {})[2] or false, mark = (st.whenPassed["test/b"] or {})[2] or false }
		emit(r)
	"#);
	let held = "Passed by the guide: its condition did not hold when you got there";
	assert_eq!(out["live"], 12, "{out}");
	assert_eq!(out["cards"][1], json!({ "tab": "2 \u{b7} Seereth Stonebreak", "lines": [held], "unskip": [true] }), "{out}");
	assert_eq!(out["skips"], 0, "{out}");
	assert_eq!(out["banner"], json!([2, held, "Unskip it"]), "{out}");
	assert_eq!(out["after"], json!({ "live": 2, "skipped": false, "mark": false }), "{out}");
}

#[test]
fn the_banner_on_a_step_the_route_passed_offers_the_way_back_not_an_unskip_4158() {
	let out = run(&(SKIP_FIRST.to_owned()
		+ r#"
		GF.Layout(); flush()
		local B = GF.parts.banner
		GF.notices.stepSkip = nil
		local function banner() return { B:IsShown() and plain(B.Text:GetText()) or false, B:IsShown() and plain(B.Jump.Label:GetText()) or false } end
		E.Prev(); flush()
		local r = { passed = { E.GetStepIndex(), banner() } }
		for _ = 1, 9 do E.Prev() end
		flush()
		r.mine = { E.GetStepIndex(), banner() }
		emit(r)
	"#));
	assert_eq!(out["passed"], json!([10, ["Looking back. The guide is at step 12.", "Back to step 12"]]), "{out}");
	assert_eq!(out["mine"], json!([1, ["You skipped this step.", "Unskip it"]]), "{out}");
}

#[test]
fn the_end_card_lists_the_chains_left_out_other_guides_first_and_counts_what_it_does_not_show_4158() {
	let out = run(&(SKIP_FIRST.to_owned()
		+ r#"
		w.accept(96); flush(); flush()
		local empty = GF.parts.empty
		local r = { out = leftOut(), title = plain(empty.Title:GetText()), late = cards(11)[11] }
		local _, _, _, _, ty = empty.Text:GetPoint(1)
		local _, _, _, _, ly = empty.LeftOut:GetPoint(1)
		r.below = ly < ty
		emit(r)
	"#));
	assert_eq!(out["title"], "Guide complete", "{out}");
	// Not the Durotar branch (step 8), the level step (11), nor step 10, further down 91's chain whose step 2 is listed;
	// 90's four steps, three named; 80's one step counted.
	assert_eq!(
		out["out"],
		[
			format!("Left out: Seereth Stonebreak, Shredders, Gerenzo +1 more \u{b7} {WHY90}"),
			"Left out: Ready \u{b7} needs \u{201c}Ready Errand\u{201d} ready to hand in (The Barrens guide)".to_owned(),
			format!("Left out: Own chain \u{b7} {WHY93}"),
			"+1 more step left out".to_owned(),
		]
		.join("\n"),
		"{out}"
	);
	assert_eq!(out["late"], json!({ "tab": "11 \u{b7} Late", "lines": ["Only from level 50"], "unskip": [false] }), "{out}");
	assert_eq!(out["below"], true, "{out}");
}

#[test]
fn the_end_card_lists_nothing_left_out_when_no_chain_left_a_step_out_4158() {
	// The card had a line for test/b; test/d, done with nothing passed, has none.
	let out = run(&(SKIP_FIRST.to_owned()
		+ r#"
		w.accept(96); flush(); flush()
		local r = { before = leftOut() ~= false }
		E.SetGuide("test/d"); flush(); flush()
		w.accept(82); flush(); flush()
		r.title, r.out, r.passed = plain(GF.parts.empty.Title:GetText()), leftOut(), #E.WhenPassed()
		emit(r)
	"#));
	assert_eq!(out, json!({ "before": true, "title": "Guide complete", "out": false, "passed": 0 }), "{out}");
}

// Own.settlePending: a `level>=12` step the route passed at 11 waits (Own.whenPending); at 12, behind the live step,
// it is stored as skipped with the route's mark, says the guide passed it and offers Unskip. Engine.Goto on it drops
// the skip and the mark together; the player's Skip of it then is their own (Unskip, no mark).
#[test]
fn a_level_step_settled_behind_the_player_is_the_route_s_and_goto_then_skip_makes_it_the_player_s_4158() {
	let out = run(r#"
		E.SetGuide("test/e"); flush(); flush()
		w.complete({ 100 }); stub.fire("QUEST_LOG_UPDATE"); flush(); flush()
		local r = { live = E.GetLiveStep(), at11 = marks("test/e") }
		w.level = 12; stub.fire("PLAYER_LEVEL_UP", 12, 0, 0, 0, 0, 0, 0, 0, 0); stub.advance(3); flush()
		r.at12, r.card = marks("test/e"), cards(2)[2]
		SL.Toggle(false); stub.advance(0.3)
		E.Goto(2); flush()
		r.goto = { at = E.GetStepIndex(), marks = marks("test/e") }
		E.Skip(); flush()
		r.skip, r.mine = marks("test/e"), cards(2)[2]
		emit(r)
	"#);
	assert_eq!(out["live"], 4, "{out}");
	assert_eq!(out["at11"], json!({ "skipped": "3", "passed": "3" }), "the level step waits at 11: {out}");
	assert_eq!(out["at12"], json!({ "skipped": "2,3", "passed": "2,3" }), "{out}");
	assert_eq!(out["card"], json!({ "tab": "2 \u{b7} Trainer", "lines": ["Passed by the guide: its condition did not hold when you got there"], "unskip": [true] }), "{out}");
	assert_eq!(out["goto"], json!({ "at": 2, "marks": { "skipped": "3", "passed": "3" } }), "{out}");
	assert_eq!(out["skip"], json!({ "skipped": "2,3", "passed": "3" }), "{out}");
	assert_eq!(out["mine"], json!({ "tab": "2 \u{b7} Trainer", "lines": ["You skipped this step."], "unskip": [true] }), "{out}");
}

// Engine.SkipUpTo: a route's mark left on a step it skips goes (the skip is the player's); the `when` step it passes
// is marked; Unskip of the first step takes back the skips and the mark the skip made (Own.skipRestore).
#[test]
fn skip_up_to_skips_as_the_player_marks_what_the_route_passes_and_its_undo_takes_both_back_4158() {
	let out = run(r#"
		E.SetGuide("test/e"); flush(); flush()
		Polestar.CharState().whenPassed["test/e"] = { [1] = true }
		local n = E.SkipUpTo(4); flush()
		local r = { n = n, live = E.GetLiveStep(), skipped = marks("test/e") }
		E.Unskip(1); flush()
		r.undone, r.back = marks("test/e"), E.GetLiveStep()
		emit(r)
	"#);
	assert_eq!(out["live"], 4, "{out}");
	assert_eq!(out["skipped"], json!({ "skipped": "1,3", "passed": "3" }), "{out}");
	assert_eq!(out["undone"], json!({ "skipped": "", "passed": "" }), "{out}");
	assert_eq!(out["back"], 1, "{out}");
}

// Engine.ResetProgress: before the last step with quest progress, the player's skip stays (no mark) and so does the
// route's pass with its mark; after it, everything goes (a stray mark too) and the route passes its gate step again,
// marking it.
#[test]
fn reset_progress_keeps_skips_and_marks_before_the_restart_and_the_gate_after_it_is_marked_again_4158() {
	let out = run(r#"
		E.SetGuide("test/f"); flush(); flush()
		E.Skip(); flush(); flush()
		w.accept(108); flush(); flush()
		local r = { live = E.GetLiveStep(), before = marks("test/f") }
		Polestar.CharState().whenPassed["test/f"][5] = true
		E.ResetProgress(); flush(); flush()
		r.after, r.cards = marks("test/f"), cards(2)
		emit(r)
	"#);
	assert_eq!(out["live"], 5, "{out}");
	assert_eq!(out["before"], json!({ "skipped": "1,2,4", "passed": "2,4" }), "{out}");
	assert_eq!(out["after"], json!({ "skipped": "1,2,4", "passed": "2,4" }), "{out}");
	assert_eq!(
		out["cards"],
		json!([
			{ "tab": "1 \u{b7} Start", "lines": ["You skipped this step."], "unskip": [true] },
			{ "tab": "2 \u{b7} Early gate", "lines": ["Not for you: needs \u{201c}Quest 90\u{201d} handed in"], "unskip": [false] },
		]),
		"{out}"
	);
}

// Own.remap: a pack update that puts a step before the ones skipped moves the skips and the route's marks with
// their steps. The save of a first login (pack 1) loaded by pack 2.
const REMAP_STEPS: [&str; 5] = [
	r#"{ title = "Take", goals = { acc(100, "Take Errand") } },"#,
	r#"{ title = "Gate A", when = { { k = "turnedin", q = 90 } }, goals = { acc(101, "Gate A Errand") } },"#,
	r#"{ title = "Skip me", goals = { acc(102, "Skip Errand") } },"#,
	r#"{ title = "Gate B", when = { { k = "turnedin", q = 90 } }, goals = { acc(103, "Gate B Errand") } },"#,
	r#"{ title = "Last", goals = { acc(104, "Last Errand") } },"#,
];

fn remap_login(version: &str, steps: &[&str], saved: Option<String>, script: &str) -> Vec<Value> {
	let guide = format!(
		r#"Polestar.RegisterPack({{ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "{version}", license = "MIT" }})
local function acc(q, title) return {{ t = "accept", quest = q, title = title, npc = 240, npcName = "Someone", map = 1429, x = 42, y = 35 }} end
Polestar.RegisterGuide({{ id = "test/up", pack = "test", title = "Upgraded", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {{
	{}
}} }})"#,
		steps.join("\n\t")
	);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\nstub.world.complete({{ 100 }})"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: saved.map(|s| vec![("Polestar".to_string(), s)]).unwrap_or_default(),
		login: false,
		script: format!("{guide}\n{TEST_SOURCE}\n{script}"),
	})
}

const REMAP_MARKS: &str = r#"
E = Polestar.Engine
local function keys(t)
	local out = {}
	for k, v in pairs(t or {}) do if type(k) == "number" and v then out[#out + 1] = k end end
	table.sort(out)
	return table.concat(out, ",")
end
function marks() local st = Polestar.CharState(); return { skipped = keys(st.skipped["test/up"]), passed = keys(st.whenPassed["test/up"]) } end
"#;

#[test]
fn a_pack_update_moves_the_route_s_marks_with_their_steps_4158() {
	let first = remap_login(
		"1",
		&REMAP_STEPS,
		None,
		&(REMAP_MARKS.to_owned()
			+ r#"
		stub.login(); stub.advance(0.25)
		stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
		E.SetGuide("test/up"); stub.advance(0.6)
		E.Skip(); stub.advance(0.6)
		emit({ live = E.GetLiveStep(), marks = marks() })
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
	"#),
	);
	assert_eq!(first[0], json!({ "live": 5, "marks": { "skipped": "2,3,4", "passed": "2,4" } }), "{}", first[0]);
	let save = first[1]["save"].as_str().expect("the save").to_string();
	let new = r#"{ title = "New", goals = { acc(105, "New Errand") } },"#;
	let steps = [REMAP_STEPS[0], new, REMAP_STEPS[1], REMAP_STEPS[2], REMAP_STEPS[3], REMAP_STEPS[4]];
	let second = remap_login(
		"2",
		&steps,
		Some(save),
		&(REMAP_MARKS.to_owned()
			+ r#"
		stub.login(); stub.advance(0.25)
		stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
		emit({ live = E.GetLiveStep(), marks = marks() })
	"#),
	);
	assert_eq!(second[0], json!({ "live": 6, "marks": { "skipped": "3,4,5", "passed": "3,5" } }), "{}", second[0]);
}
