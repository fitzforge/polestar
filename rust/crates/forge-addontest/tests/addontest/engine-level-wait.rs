//! Fitz, 0.3.6: players read the level warnings as being behind. On the shipped guides: an accept a little
//! under its level (within Own.LEVEL_WAIT, one level) holds its step, reading "Requires level 29: 0.3 levels to
//! go" as a pending goal, never passed; further off, the route moves on to the next step only. An accept-only
//! step says no quest level (Levels.StepHint counts work, not taking a quest early).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

// Guide `guide` for a Horde `race` `class` at `level` and `xp` of `xp_max`, every step before the one titled
// `at` skipped (the player is there), the quest log in. -> the live step's title and index, the step `at`'s
// index, its first accept's status and line, and the step hint on it.
#[allow(clippy::too_many_arguments)]
fn at_step(race: &str, class: &str, level: u32, xp: u32, xp_max: u32, guide: &str, at: &str, done: &str) -> Value {
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
	hint = h and h.level or false }})"#
		),
		..Default::default()
	})
	.remove(0)
}

const HILLSBRAD: &str = "forever/horde/30-40/01-hillsbrad-foothills";
const BARRENS: &str = "forever/horde/02-the-barrens";

#[test]
fn hillsbrad_at_28_7_waits_at_korran_for_the_level_29_quest_and_says_how_far_with_no_level_warning() {
	// Level 28, 70% in: The Swarm Grows (1145) asks 29.
	let out = at_step("Orc", "WARRIOR", 28, 53000, 75700, HILLSBRAD, "Korran", "");
	assert_eq!(out["live"], out["at"], "the route waits at Korran: {out}");
	assert_eq!(out["accept"], "pending", "waited for, not passed: {out}");
	assert_eq!(out["line"], "Requires level 29: 0.3 levels to go");
	assert_eq!(out["hint"], false, "an accept-only step says no quest level");
}

#[test]
fn hillsbrad_at_27_7_moves_on_to_the_next_step_only() {
	let out = at_step("Orc", "WARRIOR", 27, 49000, 70000, HILLSBRAD, "Korran", "");
	assert_eq!(out["accept"], "skipped", "{out}");
	assert_eq!(out["line"], "Requires level 29");
	assert_eq!(out["live"], out["at"].as_u64().unwrap() + 1, "the next step, nothing doable passed: {out}");
	assert_eq!(out["title"], "Fly to Orgrimmar");
}

#[test]
fn t_1485_a_warlock_at_19_6_waits_at_gan_rul_for_devourer_of_souls() {
	let out = at_step("Orc", "WARLOCK", 19, 36000, 60000, BARRENS, "Gan'rul Bloodeye", "");
	assert_eq!(out["live"], out["at"], "{out}");
	assert_eq!(out["accept"], "pending");
	assert_eq!(out["line"], "Requires level 20: 0.4 levels to go");
	assert_eq!(out["hint"], false);
}

#[test]
fn t_1485_a_warlock_at_18_5_moves_on_from_gan_rul_to_the_next_step_for_them() {
	let out = at_step("Orc", "WARLOCK", 18, 25000, 50000, BARRENS, "Gan'rul Bloodeye", "");
	assert_eq!(out["accept"], "skipped", "{out}");
	assert_eq!(out["title"], "Fly to Ratchet", "{out}");
}

// ReleaseFinal036's harness, Horde Ashenvale (zfeuqxcdw7): an accept a little under its level behind the
// player's quest progress (King of the Foulweald, 6621, at Zoram'gar) never moves them back to it; it passes
// as before. Here: Korran's accept (29) behind the player, who has handed in 1145's follow-up work further on.
#[test]
fn an_accept_a_little_under_its_level_behind_the_player_s_progress_passes_and_never_moves_them_back() {
	let dir = forge_addontest::run::addons_dir();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: r#"local w = stub.world
w.race, w.faction, w.class, w.className, w.level = "Orc", "Horde", "WARRIOR", "WARRIOR", 28
w.setXP(53000, 75700)
-- Progress past Korran: Tarren Mill's quests taken.
w.onQuest(552, { 0 }); w.onQuest(533, { 0 }); w.onQuest(532, { 0 })"#
			.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"]), Addon::dir("Polestar_Guides", dir.join("Polestar_Guides")), Addon::dir("Polestar_Guides_Horde", dir.join("Polestar_Guides_Horde"))],
		script: format!(
			r#"
E = Polestar.Engine
for id, b in pairs(Polestar.MapFrames.era) do stub.world.addMap(id, b) end
stub.login(); stub.advance(0.25)
Polestar.Set("behavior.autoAccept", false)
E.SetGuide("{HILLSBRAD}"); stub.advance(0.25)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
local g = E.GetGuide()
local korran
for i, step in ipairs(g.steps) do if step.title == "Korran" then korran = i end end
local live = E.GetLiveStep()
local a = E.GetStepView(korran).goals[1]
emit({{ korran = korran, live = live, accept = a.status, line = a.unavailableText or false }})"#
		),
		..Default::default()
	})
	.remove(0);
	assert!(out["live"].as_u64().unwrap() > out["korran"].as_u64().unwrap(), "never back to Korran: {out}");
	assert_eq!(out["accept"], "skipped", "{out}");
	assert_eq!(out["line"], "Requires level 29", "passed, with its plain line: {out}");
}
