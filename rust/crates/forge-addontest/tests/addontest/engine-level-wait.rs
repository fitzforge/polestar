//! Fitz, 0.3.6: players read the level warnings as being behind. On the shipped guides: an accept waiting for
//! the character's level is no task (status "na", no "Requires level" line); the route moves on as before and the
//! level-up brings it back. An accept-only step says no quest level (Levels.StepHint counts work, not taking a
//! quest early).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

// Guide `guide` for a Horde `race` `class` at `level` and `xp` of `xp_max`, every step before the one titled
// `at` skipped (the player is there), the quest log in. -> the live step's title and index, the step `at`'s
// index, its first accept's status and line, and the step hint on it.
#[allow(clippy::too_many_arguments)]
fn at_step(race: &str, class: &str, level: u32, xp: u32, xp_max: u32, guide: &str, at: &str, done: &str) -> Vec<Value> {
	let dir = forge_addontest::run::addons_dir();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!(
			r#"local w = stub.world
w.race, w.faction, w.class, w.className, w.level = "{race}", "Horde", "{class}", "{class}", {level}
w.setXP({xp}, {xp_max})
w.complete({{ {done} }})"#
		),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"]), Addon::dir("Polestar_Guides", dir.join("Polestar_Guides")), Addon::dir("Polestar_Guides_Horde", dir.join("Polestar_Guides_Horde"))],
		script: format!(
			r#"
E = Polestar.Engine
for id, b in pairs(Polestar.MapFrames.era) do stub.world.addMap(id, b) end
stub.login(); stub.advance(0.25)
Polestar.Set("behavior.autoAccept", false)
E.SetGuide("{guide}"); stub.advance(0.25)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
-- The player is at step `at` (of the guide as planned): the steps before it skipped.
local g = E.GetGuide()
local at
for i, step in ipairs(g.steps) do if step.title == "{at}" and E.Applies(i) then at = i break end end
local sk = {{}}
for i = 1, at - 1 do sk[i] = true end
Polestar.CharState().skipped["{guide}"] = sk
stub.fire("QUEST_LOG_UPDATE"); stub.advance(1)
local live = E.GetLiveStep()
local v = E.GetStepView(at)
local a
for k, gv in ipairs(v.goals) do if g.steps[at].goals[k].t == "accept" then a = gv break end end
local h = Polestar.Levels.StepHint(at)
emit({{ at = at, live = live, title = E.GetGuide().steps[live].title, accept = a.status, line = a.unavailableText or false,
	hint = h and h.level or false }})
-- The level reached: back to the accept.
stub.world.setLevel({level} + 1); stub.advance(1)
emit({{ live = E.GetLiveStep(), accept = E.GetStepView(at).goals[1].status }})"#
		),
		..Default::default()
	})
}

const HILLSBRAD: &str = "forever/horde/30-40/01-hillsbrad-foothills";
const BARRENS: &str = "forever/horde/02-the-barrens";

#[test]
fn hillsbrad_at_28_7_passes_korran_s_level_29_accept_silently_and_the_level_up_brings_it_back() {
	// Level 28, 70% in: The Swarm Grows (1145) asks 29.
	let out = at_step("Orc", "WARRIOR", 28, 53000, 75700, HILLSBRAD, "Korran", "");
	let (low, ding) = (&out[0], &out[1]);
	assert_eq!(low["accept"], "na", "no task, no level text: {low}");
	assert_eq!(low["line"], false);
	assert_eq!(low["hint"], false, "an accept-only step says no quest level");
	assert_eq!(low["title"], "Fly to Orgrimmar", "the route moves on as before: {low}");
	assert_eq!(ding["live"], low["at"], "level 29: back to Korran: {ding}");
	assert_eq!(ding["accept"], "active");
}

#[test]
fn t_1485_a_warlock_at_19_6_moves_on_from_gan_rul_and_comes_back_at_20() {
	let out = at_step("Orc", "WARLOCK", 19, 36000, 60000, BARRENS, "Gan'rul Bloodeye", "");
	let (low, ding) = (&out[0], &out[1]);
	assert_eq!(low["accept"], "na", "{low}");
	assert_eq!(low["line"], false);
	assert_eq!(low["hint"], false);
	assert!(low["live"].as_u64().unwrap() > low["at"].as_u64().unwrap(), "moved on: {low}");
	assert_eq!(ding["live"], low["at"], "level 20: back to Gan'rul: {ding}");
	assert_eq!(ding["accept"], "active");
}

// Tincho (Fitz, 0.3.6): a Horde Warrior at 28.7 coming out of Thousand Needles, who did the route before it
// (its hand-ins) and carries Dangerous! (567, done kills) from the 22-24 Hillsbrad visit, loads Hillsbrad 29-32
// (the first load and every reload). Korran's accept (1145, needs 29) and Belgrom's hand-in of it wait for the level; the flight
// to the Crossroads, Orgrimmar, training and the Undercity travel stay: those kills at step 32 (Azurelode Mine) are
// no sign the player is past them. Before: placed at Tarren Mill (step 19), all of those passed.
const TINCHO_DONE: &str = "23, 25, 216, 247, 421, 422, 425, 428, 429, 430, 435, 437, 438, 439, 440, 441, 445, 449, 477, 478, 479, 481, 482, 493, 494, 496, 498, 499, 501, 502, 509, 513, 516, 527, 528, 529, 546, 549, 784, 786, 788, 789, 790, 791, 792, 794, 804, 805, 806, 808, 815, 816, 817, 818, 819, 823, 824, 825, 826, 827, 828, 829, 831, 834, 835, 837, 840, 842, 843, 844, 845, 846, 848, 849, 850, 851, 852, 855, 857, 858, 863, 865, 867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 887, 888, 890, 891, 892, 893, 894, 895, 896, 898, 899, 900, 901, 902, 903, 905, 906, 907, 913, 1058, 1060, 1061, 1062, 1087, 1090, 1092, 1093, 1149, 1150, 1358, 1359, 1483, 1492, 1498, 1502, 1503, 1505, 1525, 1526, 1527, 1823, 1824, 1825, 1918, 2161, 2383, 3087, 3088, 3089, 3090, 3221, 3261, 3281, 3921, 3922, 3923, 4021, 4402, 4542, 4641, 4767, 4770, 4821, 4841, 4865, 4904, 4921, 4966, 5041, 5052, 5064, 5147, 5151, 5441, 5881, 6282, 6301, 6365, 6381, 6382, 6383, 6393, 6394, 6441, 6442, 6461, 6462, 6482, 6503, 6541, 6544, 6548, 6562, 6563, 6621, 6629, 6641, 78132, 78133, 78134, 86576, 91920, 91921, 92706, 95494, 95495, 95507, 95508, 95621, 95774, 95883, 95884, 95981, 96241, 96259, 96260, 96261, 96604, 96652, 96655, 96821, 96822, 96825, 96895, 96897, 96898, 97223, 97225, 97242, 97246, 97249, 97250, 97253, 97275, 97279, 97282, 97326, 97891, 98069, 98070, 98093, 98094, 98095, 98251, 98252, 98576, 99048, 99049, 99051, 99052, 99123";
const TINCHO_LOG: &str = "830, 832, 567, 2, 24, 4881";

fn tincho(reload: bool) -> Value {
	let dir = forge_addontest::run::addons_dir();
	// A reload: the guide saved in its tab, started before.
	let saved = if reload {
		vec![("Polestar".to_string(), format!(r#"PolestarCharDB = {{ schema = 1, tabs = {{ "{HILLSBRAD}" }}, activeTab = 1, flags = {{ started = {{ ["{HILLSBRAD}"] = true }} }} }}"#))]
	} else {
		vec![]
	};
	let open = if reload { "" } else { "E.SetGuide(\"forever/horde/30-40/01-hillsbrad-foothills\"); stub.advance(0.25)" };
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!(
			r#"local w = stub.world
w.race, w.faction, w.class, w.className, w.level = "Orc", "Horde", "WARRIOR", "Warrior", 28
w.setXP(53000, 75700)
w.complete({{ {TINCHO_DONE} }})
for _, q in ipairs({{ {TINCHO_LOG} }}) do w.onQuest(q, {{ 0 }}) end"#
		),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"]), Addon::dir("Polestar_Guides", dir.join("Polestar_Guides")), Addon::dir("Polestar_Guides_Horde", dir.join("Polestar_Guides_Horde"))],
		saved,
		script: format!(
			r#"
E = Polestar.Engine
for id, b in pairs(Polestar.MapFrames.era) do stub.world.addMap(id, b) end
stub.world.moveTo(1441, 45.0, 49.1)
stub.login(); stub.advance(0.25)
{open}
stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
local g = E.GetGuide()
-- The steps that apply to him up to the first Tarren Mill stop that does (the catch-up on Battle of Hillsbrad and
-- The Rescue before it, #1660, is for characters without those quests; he handed them in).
local st = {{}}
for i, step in ipairs(g.steps) do
	if E.Applies(i) then
		st[#st + 1] = step.title .. "=" .. E.GetStepView(i).status
		if step.title == "Tarren Mill" then break end
	end
end
local korran
for i, step in ipairs(g.steps) do if step.title == "Korran" then korran = i end end
emit({{ live = g.steps[E.GetLiveStep()].title, steps = st, korran = E.GetStepView(korran).goals[1].status }})"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn tincho_at_28_7_loading_hillsbrad_keeps_orgrimmar_training_and_the_undercity_only_korran_waits() {
	// The first load, and a reload of the saved tab (the skip-ahead sweep: the same placement runs again).
	for reload in [false, true] {
		let out = tincho(reload);
		assert_eq!(out["live"], "Fly to the Crossroads", "reload {reload}: {out}");
		assert_eq!(out["korran"], "na", "Korran's accept waits for 29, no task, no level text: {out}");
		for s in ["Fly to Orgrimmar=upcoming", "Train=upcoming", "Zeppelin to Undercity=upcoming", "The Undercity=upcoming", "Tarren Mill=upcoming"] {
			assert!(out["steps"].as_array().unwrap().iter().any(|v| v == s), "reload {reload}, {s}: {out}");
		}
		for s in ["High Executor Darthalia", "Krusk", "Hillsbrad Fields", "Hillsbrad Peasants", "Durnholde Keep", "The smithy"] {
			let catch_up = out["steps"].as_array().unwrap().iter().any(|v| v.as_str().is_some_and(|v| v.starts_with(&format!("{s}="))));
			assert!(!catch_up, "reload {reload}: the #1660 catch-up ({s}) is not his, he handed those quests in: {out}");
		}
	}
}

// Discord (2026-11-09): a Rogue at 21 at Taskmaster Fizzule (Horde 05-stonetalon-mountains) read "Level 24
// quest" for Mission: Possible But Not Probable (2478, level 24, an optional accept: Gallywix is a 23 elite). Taking a
// quest is no work: the optional accept gives the step no quest-level line, and the pace line names no hard quest for it.
#[test]
fn a_rogue_at_21_at_fizzule_sees_no_level_line_for_the_optional_mission_possible() {
	let dir = forge_addontest::run::addons_dir();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: r#"local w = stub.world
w.race, w.faction, w.class, w.className, w.level = "Orc", "Horde", "ROGUE", "Rogue", 21
w.setXP(20000, 50000)
w.onQuest(2458, { 0 })"#
			.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"]), Addon::dir("Polestar_Guides", dir.join("Polestar_Guides")), Addon::dir("Polestar_Guides_Horde", dir.join("Polestar_Guides_Horde"))],
		script: r#"
E = Polestar.Engine
for id, b in pairs(Polestar.MapFrames.era) do stub.world.addMap(id, b) end
stub.login(); stub.advance(0.25)
Polestar.Set("behavior.autoAccept", false)
E.SetGuide("forever/horde/05-stonetalon-mountains"); stub.advance(0.25)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
local g = E.GetGuide()
local at
for i, step in ipairs(g.steps) do if step.title == "Taskmaster Fizzule" and E.Applies(i) then at = i break end end
local sk = {}
for i = 1, at - 1 do sk[i] = true end
Polestar.CharState().skipped["forever/horde/05-stonetalon-mountains"] = sk
stub.fire("QUEST_LOG_UPDATE"); stub.advance(1)
local v, accept = E.GetStepView(at), nil
for k, gv in ipairs(v.goals) do
	local goal = g.steps[at].goals[k]
	if goal.t == "accept" and goal.quest == 2478 then accept = { optional = goal.optional == true, status = gv.status } end
end
local h = Polestar.Levels.StepHint(at)
local pace = Polestar.Levels.Pace()
local hard = pace and pace.hard and pace.hard.quest or false
emit({ live = E.GetLiveStep(), at = at, accept = accept or false, hint = h and h.level or false, hard = hard })"#
			.to_string(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["live"], out["at"], "the player is at Fizzule: {out}");
	assert_eq!(out["accept"]["optional"], true, "Mission: Possible is an optional accept on the step: {out}");
	assert_eq!(out["hint"], false, "no \"Level 24 quest\" line for taking it: {out}");
	assert_ne!(out["hard"], 2478, "the pace line names no hard quest for the optional accept: {out}");
}
