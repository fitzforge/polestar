//! `along` steps at runtime (addon/Polestar/Core/Engine.lua; docs/GUIDE_FORMAT.md, "Along the way"): the route
//! passes over an along step at once; while the live step is past it, Engine.GetAlong lists its open goals,
//! until they are done or, with `along = "<label>"`, until the live step reaches the step so labelled; a quest
//! with work still open keeps its own goals listed past the label until that work is done (#797, #809).
//! Engine.AimAlong leads the arrow to one of them. Core/Guides.lua checks `label` and `along`. Real Core
//! manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"; w.titles[7] = "Kobold Camp Cleanup"
"#;

// 1 accept 7 · 2 along until "back": kill 10 vermin for quest 7 (placed), hold 2 candles (no place) · 3 along:
// hold 1 linen (placed) · 4 accept 783 · 5 "back": turn in 7 · 6 level 6
const ALONG2: &str = r#"along = "back""#;
const ALONG3: &str = "along = true";

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/along", pack = "test", title = "Along", minLevel = 1, maxLevel = 6,
	steps = {
		{ title = "McBride", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Kobolds on the way", ALONG2, goals = {
			{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 },
			{ t = "collect", item = 750, itemName = "Candle", count = 2 },
		} },
		{ title = "Linen", ALONG3, goals = { { t = "collect", item = 2589, itemName = "Linen Cloth", count = 1, map = 1429, x = 40.0, y = 60.0 } } },
		{ title = "Willem", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
		{ title = "Back to McBride", label = "back", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "End", goals = { { t = "level", level = 6 } } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- "<step>:<goal>[:<progress>]" for each goal Engine.GetAlong lists.
function along()
	local out = {}
	for _, s in ipairs(E.GetAlong()) do
		for _, g in ipairs(s.goals) do
			out[#out + 1] = s.index .. ":" .. g.index .. (g.progress and (":" .. g.progress.cur) or "")
		end
	end
	return table.concat(out, " ")
end
function wp()
	local w = E.GetWaypoint()
	return w and (w.stepIndex .. ":" .. w.goalIndex) or "none"
end
"#;

fn run_with(script: &str, along2: &str, along3: &str) -> Vec<Value> {
	let guide = GUIDE.replace("ALONG2", along2).replace("ALONG3", along3);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/along" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, &guide, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, ALONG2, ALONG3)
}

#[test]
fn the_route_passes_over_along_steps_their_open_goals_are_listed_until_done_or_until_the_labelled_step() {
	let out = run(r#"
		local w = stub.world
		emit({ E.GetLiveStep(), along() })              -- before them: nothing along
		w.accept(7, { 10 }); flush()
		emit({ E.GetLiveStep(), along() })              -- live step 4; steps 2 and 3 are along
		w.progress(7, 1, 4); flush()
		emit(along())                                   -- progress shows
		w.progress(7, 1, 10); w.addItem(750, 2); flush()
		emit(along())                                   -- step 2's goals done: gone
		w.addItem(2589, 1); flush()
		emit(along())                                   -- step 3's too
	"#);
	assert_eq!(out, vec![json!([1, ""]), json!([4, "2:1:0 2:2:0 3:1:0"]), json!("2:1:4 2:2:0 3:1:0"), json!("3:1:0"), json!("")]);
}

// Zyd's (#797, Iverron's Antidote) and jkw's (#809, Legging It) reports: the labelled step hands the quest in,
// and its along goals vanished there, leaving "Turn in" for a quest with work left.
#[test]
fn reaching_the_step_until_names_ends_the_list_but_a_quest_with_work_left_keeps_its_goals_until_done() {
	let out = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); flush()
		w.accept(783, {}); flush()
		emit({ E.GetLiveStep(), along() })      -- at the hand-in of 7: its vermin stay, the candles (no quest) end
		w.progress(7, 1, 6); flush()
		emit(along())
		w.progress(7, 1, 10); flush()
		emit(along())                           -- 7 ready to hand in: step 2 is gone, the plain along stays
	"#);
	assert_eq!(out, vec![json!([5, "2:1:0 3:1:0"]), json!("2:1:6 3:1:0"), json!("3:1:0")]);
}

// Bill's (#853, Legging It) and striderZA's (#862, The Battleboars) reports: at the labelled step the arrow stood on the
// turn-in while its along kills were open. Until the quest is ready the arrow leads to that work and the turn-in
// says it is still open.
#[test]
fn before_a_turn_in_that_is_not_ready_the_arrow_leads_to_its_open_along_work_and_the_turn_in_says_so() {
	let out = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); flush()
		w.accept(783, {}); flush()
		emit({ E.GetLiveStep(), wp(), E.GetStepView(5).goals[1].pinOpen or false })
		w.progress(7, 1, 10); flush()
		emit({ wp(), E.GetStepView(5).goals[1].pinOpen or false })
	"#);
	assert_eq!(out, vec![json!([5, "2:1", "along"]), json!(["5:1", false])]);
}

#[test]
fn an_along_step_that_does_not_apply_when_only_or_that_the_player_skipped_is_not_listed() {
	let out = run_with(
		r#"
		stub.world.accept(7, { 10 }); flush()
		emit({ E.GetLiveStep(), along() })
	"#,
		r#"along = "back", only = { classes = { "MAGE" } }"#,
		r#"along = true, when = { { k = "level", op = ">=", n = 50 } }"#,
	);
	assert_eq!(out, vec![json!([4, ""])]);
	// A skip saved before #942: the window no longer pages to an along step, so it is not skipped from there.
	let skipped = run(r#"
		stub.world.accept(7, { 10 }); flush()
		Polestar.CharState().skipped["test/along"] = { [3] = true }
		emit({ E.GetLiveStep(), along() })
	"#);
	assert_eq!(skipped, vec![json!([4, "2:1:0 2:2:0"])]);
}

#[test]
fn the_step_view_says_which_steps_are_along_and_which_carry_a_label_the_list_carries_the_step_title() {
	let out = run(r#"
		stub.world.accept(7, { 10 }); flush()
		emit({ E.GetStepView(2).along, E.GetStepView(3).along, E.GetStepView(5).label, E.GetStepView(4).along == nil })
		emit(E.GetAlong()[1].title)
	"#);
	assert_eq!(out, vec![json!(["back", true, "back", true]), json!("Kobolds on the way")]);
}

#[test]
fn aimalong_leads_the_arrow_to_a_listed_placed_open_along_goal_and_refuses_anything_else() {
	let out = run(r#"
		local w = stub.world
		emit(E.AimAlong(2, 1))                 -- not behind the live step yet
		w.accept(7, { 10 }); flush()
		emit(wp())                             -- Willem
		emit({ E.AimAlong(2, 2), E.AimAlong(4, 1), E.AimAlong(2, 9) })   -- no place, not along, no goal
		emit(E.AimAlong(2, 1)); flush()
		emit(wp())
		local v = E.GetWaypoint()
		emit({ v.x, v.y, v.kind })
	"#);
	assert_eq!(out, vec![json!(false), json!("4:1"), json!([false, false, false]), json!(true), json!("2:1"), json!([47.6, 35.1, "kill"])]);
}

#[test]
fn the_arrow_s_along_choice_lapses_when_the_goal_is_done_and_holds_while_the_route_moves_on() {
	let done = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); flush()
		E.AimAlong(2, 1); flush()
		emit(wp())
		w.progress(7, 1, 10); flush()
		emit(wp())
	"#);
	assert_eq!(done, vec![json!("2:1"), json!("4:1")]);
	let moved = run(r#"
		local w = stub.world
		w.accept(7, { 10 }); flush()
		E.AimAlong(3, 1); flush()
		emit(wp())
		w.accept(783, {}); flush()              -- live step 5; step 3 (no until) is still listed
		emit({ E.GetLiveStep(), wp() })
		emit({ E.AimAlong(2, 2), E.AimAlong(2, 1) })   -- past its label (step 5) step 2 keeps only quest 7's open vermin
	"#);
	assert_eq!(moved, vec![json!("3:1"), json!([5, "3:1"]), json!([false, true])]);
}

#[test]
fn guides_validate_refuses_a_bad_label_or_along() {
	let out = run(r#"
		local function def(steps) return { id = "test/x", pack = "test", title = "X", steps = steps } end
		local G = { { t = "level", level = 2 } }
		emit(Polestar.Guides.Validate(def({ { along = "b", goals = G }, { label = "b", goals = G } })) == nil)
		emit(Polestar.Guides.Validate(def({ { along = true, goals = G } })) == nil)
		emit(Polestar.Guides.Validate(def({ { label = 5, goals = G } })))
		emit(Polestar.Guides.Validate(def({ { label = "a", goals = G }, { label = "a", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { along = "nowhere", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { label = "b", goals = G }, { along = "b", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { along = 3, goals = G } })))
	"#);
	assert_eq!(out, vec![json!(true), json!(true), json!("step 1: bad label"), json!("step 2: duplicate label a"), json!("step 1: bad along"), json!("step 2: bad along"), json!("step 1: bad along")]);
}

// #862, the guide as shipped (guides/forever/horde/tauren/01-mulgore.guide, compiled with data/forever; skipped
// with a note without it). Since #1091 The Battleboars' snouts and flanks are goals 1 and 2 of step 9 (Red Cloud
// Mesa, a step of its own, no longer an along list), and step 11 turns 780 in to Grull Hawkwind (2980). The
// reporter: a level 5 Tauren Druid, 757, 781, 3376 and 1656 ready, 780 at one of two objectives (here the 8
// snouts done, 3 of 8 flanks). Step 9 stays live and the arrow leads to the flanks (9:2), not to Grull (11:1).
#[test]
fn mulgore_the_battleboars_half_done_at_camp_narache_the_arrow_leads_to_the_boars_not_to_grull() {
	use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack};
	use forge_addontest::run::root;
	let data_dir = root().join("data/forever");
	if !data_dir.join("quests.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let file = "guides/forever/horde/tauren/01-mulgore.guide";
	let text = std::fs::read_to_string(root().join(file)).unwrap();
	let compiled = compile_with(&[(file, &text)], &data, None);
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let loads: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let f = data.map_frames.get("forever").get("1412");
	let before = format!(
		r#"local w = stub.world
w.addMap(1412, {{ name = "Mulgore", c = {}, left = {}, right = {}, top = {}, bottom = {} }})
w.race, w.raceName, w.class, w.className, w.faction, w.level = "Tauren", "Tauren", "DRUID", "DRUID", "Horde", 5
w.moveTo(1412, 50.64, 83.03)
w.complete({{ 752, 747, 753, 750, 3094, 755, 95805 }})
w.onQuest(781, {{}}); w.onQuest(757, {{ {{ required = 12, fulfilled = 12 }} }}); w.onQuest(1656, {{}})
w.onQuest(3376, {{ {{ required = 1, fulfilled = 1 }} }})
w.onQuest(780, {{ {{ required = 8, fulfilled = 8 }}, {{ required = 8, fulfilled = 3 }} }})
w.addItem(4770, 12); w.addItem(10459, 1); w.addItem(4848, 8); w.addItem(4849, 3)
"#,
		f.get("c").to_js_string(),
		f.get("left").to_js_string(),
		f.get("right").to_js_string(),
		f.get("top").to_js_string(),
		f.get("bottom").to_js_string()
	);
	let script = format!(
		r#"do local ns = {{}}
{}
end
stub.login()
stub.fire("QUEST_LOG_UPDATE")
{HELPERS}
E.SetGuide("forever/horde/tauren/01-mulgore"); flush()
emit({{ E.GetLiveStep(), wp() }})
"#,
		loads.join("\n")
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script, ..Default::default() });
	assert_eq!(out, vec![json!([9, "9:2"])], "the flanks still to get (step 9 goal 2), not Grull Hawkwind's turn-in (11:1)");
}

// The window's "Along the way, until step N" (#942): each listed along step names the step its list ends at.
#[test]
fn get_along_names_the_step_each_list_ends_at() {
	let out = run(r#"
		stub.world.accept(7, { 10 }); flush()
		local out = {}
		for _, s in ipairs(E.GetAlong()) do out[#out + 1] = { s.index, s.untilStep or false } end
		emit(out)"#);
	assert_eq!(out[0], json!([[2, 5], [3, false]]));
}

// Fitz (#942): an along step is no step of its own. It has no number (it reads as the next step's), the count
// leaves it out, Next, Prev and Goto never land on it, so the arrow never leads to it, and a view of it saved
// before (CharState().pins) opens on the next step instead.
#[test]
fn an_along_step_is_never_looked_at_numbered_or_pointed_at() {
	let out = run(r#"
		stub.world.accept(7, { 10 }); flush()
		local function no(s) local n, hidden = E.StepNumber(s); return { n, hidden } end
		local numbers = { no(1), no(2), no(3), no(4), no(5), no(6) }
		E.Goto(2); flush()
		local goto2 = { E.GetStepIndex(), wp() }
		E.Goto(1); flush()
		E.Next(); flush()
		local after1 = E.GetStepIndex()
		E.Goto(5); flush()
		E.Prev(); flush()
		E.Prev(); flush()
		emit({ numbers = numbers, total = E.StepTotal(), goto2 = goto2, after1 = after1, back = E.GetStepIndex() })"#);
	assert_eq!(out[0]["numbers"], json!([[1, false], [2, true], [2, true], [2, false], [3, false], [4, false]]));
	assert_eq!(out[0]["total"], 4);
	assert_eq!(out[0]["goto2"], json!([4, "4:1"]), "Goto refuses it: the live step and its arrow stay");
	assert_eq!(out[0]["after1"], 4, "Next from step 1 passes over both along steps");
	assert_eq!(out[0]["back"], 1, "Prev from step 5 too");
}

#[test]
fn a_saved_view_of_an_along_step_opens_on_the_next_step() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/along", pins = { ["test/along"] = { step = 3, done = false } } }"#.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			&GUIDE.replace("ALONG2", ALONG2).replace("ALONG3", ALONG3),
			HELPERS,
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			"emit({ E.GetStepIndex(), E.GetLiveStep() })",
		]
		.join("\n"),
		..Default::default()
	});
	assert_eq!(out[0], json!([4, 1]), "the view saved on along step 3 opens on step 4, ahead of the live step 1");
}
