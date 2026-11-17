//! What the guide leaves out, and why (#2634), and "Skip grey quests" by what Forever pays (#2620), on the
//! shipped guides: the guide window's "N left out here" lists each quest the route passes over with the engine's
//! own reason (Engine.LeftOutHere), the bug report carries the same lines, and the catch-up keeps every quest
//! still paying full XP.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const NEEDLES: &str = "forever/horde/30-40/02-thousand-needles";
const ASHENVALE: &str = "forever/horde/07-ashenvale";
const ARATHI: &str = "forever/horde/30-40/05-arathi-highlands";

// Guide `guide` for a Horde `race` `class` at `level`, "Skip grey quests" `grey`, the quests `done` handed in;
// `at`: the title of the step the player is at (the steps before it skipped by them), or "" for where placement
// puts them. `whole`: the whole Polestar addon (the bug report), else its Core. Then `script`, with OUT(i,
// alone) (each quest left out as "quest kind: text [fix]") and STATUS(q) (an accept's status on its first step
// for the character, "none" when it does not apply).
#[allow(clippy::too_many_arguments)]
fn shipped(race: &str, class: &str, level: u32, grey: bool, done: &str, guide: &str, at: &str, whole: bool, script: &str) -> Value {
	let dir = forge_addontest::run::addons_dir();
	let core = if whole { Addon::name("Polestar") } else { Addon::files("Polestar", &["Core/Core.xml"]) };
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!(
			r#"local w = stub.world
w.race, w.faction, w.class, w.className, w.level = "{race}", "Horde", "{class}", "{class}", {level}
w.complete({{ {done} }})"#
		),
		addons: vec![core, Addon::dir("Polestar_Guides", dir.join("Polestar_Guides")), Addon::dir("Polestar_Guides_Horde", dir.join("Polestar_Guides_Horde"))],
		saved: vec![("Polestar".into(), format!("PolestarDB = {{ schema = 1, settings = {{ behavior = {{ skipGrey = {grey} }} }} }}"))],
		script: format!(
			r#"
E = Polestar.Engine
for id, b in pairs(Polestar.MapFrames.era) do stub.world.addMap(id, b) end
stub.login(); stub.advance(0.25)
Polestar.Set("behavior.autoAccept", false)
E.SetGuide("{guide}"); stub.advance(0.25)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
g = E.GetGuide()
local at = "{at}"
if at ~= "" then
	local k
	for i, step in ipairs(g.steps) do if step.title == at and E.Applies(i) then k = i break end end
	local sk = {{}}
	for i = 1, k - 1 do sk[i] = true end
	Polestar.CharState().skipped[g.id] = sk
	stub.fire("QUEST_LOG_UPDATE"); stub.advance(1)
end
function OUT(i, alone)
	local list = {{}}
	for _, o in ipairs(E.LeftOutHere(i, alone)) do
		list[#list + 1] = o.quest .. " " .. o.kind .. ": " .. o.text .. (o.fix and (" [" .. o.fix.kind .. "]") or "")
	end
	return list
end
function STATUS(q)
	for i, step in ipairs(g.steps) do
		for gi, goal in ipairs(step.goals) do
			if goal.t == "accept" and goal.quest == q and E.Applies(i, gi) then return E.GetStepView(i).goals[gi].status end
		end
	end
	return "none"
end
{script}"#
		),
		..Default::default()
	})
	.remove(0)
}

// 16 Nov, Discord: a Horde player at 30 in Thousand Needles without Test of Faith (1149, Ashenvale's guide) saw
// Test of Endurance (1150) vanish. Since #2635 the second visit brings Test of Faith back first, at Dorn
// Plainstalker, for a character without it: Test of Endurance is the route's again, nothing is left out.
#[test]
fn thousand_needles_at_30_without_test_of_faith_brings_it_back_at_dorn_first() {
	let script = r#"local live = E.GetLiveStep()
emit({ title = g.steps[live].title, here = OUT(live), faith = STATUS(1149), endurance = STATUS(1150) })"#;
	let out = shipped("Tauren", "WARRIOR", 30, false, "", NEEDLES, "Dorn Plainstalker", false, script);
	assert_eq!(out["title"], "Dorn Plainstalker", "{out}");
	assert_eq!(out["faith"], "active", "the catch-up step offers Test of Faith: {out}");
	assert_ne!(out["endurance"], "none", "Test of Endurance stays the route's: {out}");
	assert_eq!(out["here"], json!({}), "nothing left out at Dorn: {out}");
	// Test of Faith done (the 27-29 guide): nothing to take again, the player is at Dorn's Test of Endurance.
	let done = shipped("Tauren", "WARRIOR", 30, false, "1149", NEEDLES, "Dorn Plainstalker", false, script);
	assert_ne!(done["faith"], "active", "{done}");
	assert_eq!(done["endurance"], "active", "{done}");
	assert_eq!(done["here"], json!({}), "{done}");
}

// A second visit that leaves its starter out on purpose (data/route-fixes.json overrides.leftout, #2635): Krusk's
// Infiltration (533) on the 37-39 Tarren Mill stop needs The Rescue (498, level 22, half XP at 37) from the 22-25
// guide. Without it the window says why at Tarren Mill and offers a guide to it; with it, nothing to explain.
#[test]
fn tarren_mill_at_37_without_the_rescue_says_infiltration_needs_it_first() {
	let script = r#"local live = E.GetLiveStep()
emit({ title = g.steps[live].title, here = OUT(live), infiltration = STATUS(533) })"#;
	let out = shipped("Tauren", "WARRIOR", 37, false, "", ARATHI, "Tarren Mill", false, script);
	assert_eq!(out["title"], "Tarren Mill", "{out}");
	let here: Vec<&str> = out["here"].as_array().map(|a| a.iter().filter_map(Value::as_str).collect()).unwrap_or_default();
	assert!(here.contains(&"533 pre: Requires \u{201c}The Rescue\u{201d} first [chain]"), "{out}");
	let done = shipped("Tauren", "WARRIOR", 37, false, "498", ARATHI, "Tarren Mill", false, script);
	let here: Vec<&str> = done["here"].as_array().map(|a| a.iter().filter_map(Value::as_str).collect()).unwrap_or_default();
	assert!(!here.iter().any(|h| h.starts_with("533 ")), "{done}");
	assert_ne!(done["infiltration"], "none", "{done}");
}

// The bug report carries the step's reasons, with the quest ids, as the window says them.
#[test]
fn the_bug_report_names_what_is_left_out_here_and_why() {
	let out = shipped("Tauren", "WARRIOR", 37, false, "", ARATHI, "Tarren Mill", true, r#"emit({ text = table.concat(Polestar.UI.Report.Details().lines, "\n") })"#);
	let text = out["text"].as_str().unwrap_or("");
	assert!(text.contains("Infiltration (533) \u{b7} Requires \u{201c}The Rescue\u{201d} first"), "{text}");
	assert!(text.contains("Left out here:"), "{text}");
}

// #2620 (animagic, Donkeyman, Zack, aVikingTrex): at 31, two over Horde Ashenvale's 27-29, "Skip grey quests" left
// out every quest more than 2 levels below, King of the Foulweald (26) and Satyr Horns (26) too, which still pay
// full XP. Now what Forever pays decides: those stay, and the guide is not passed whole. The Thistlefur line (24,
// 60% at 31) is judged by the walk: Between a Rock and a Thistlefur stays, King of the Foulweald needs it; Troll
// Charm and Freedom to Ruul, deeper in Thistlefur Hold, are a detour, and the window says so.
#[test]
fn horde_ashenvale_at_31_with_skip_grey_keeps_full_xp_quests_and_explains_the_rest() {
	let out = shipped(
		"Orc",
		"WARRIOR",
		31,
		true,
		"",
		ASHENVALE,
		"",
		false,
		r#"local why = {}
for i = 1, E.GetStepCount() do
	for _, o in ipairs(E.LeftOutHere(i, true)) do why[tostring(o.quest)] = o.kind .. ": " .. o.text end
end
emit({ guide = E.GetGuide().id, live = E.GetLiveStep() or false, king = STATUS(6621), satyr = STATUS(6441), befouled = STATUS(1918),
	rock = STATUS(216), charm = STATUS(6462), ruul = STATUS(6482), why = why })"#,
	);
	assert_eq!(out["guide"], ASHENVALE, "not passed whole: {out}");
	assert_eq!(out["live"], 1, "{out}");
	for q in ["king", "satyr", "befouled", "rock"] {
		assert!(out[q] == "pending" || out[q] == "active", "{q} stays: {out}");
	}
	assert_eq!(out["charm"], "none", "{out}");
	assert_eq!(out["ruul"], "none", "{out}");
	let detour = "catchup: Pays 60% XP at your level and is out of the way (Skip grey quests)";
	assert_eq!(out["why"]["6462"], detour);
	assert_eq!(out["why"]["6482"], detour);
	assert!(out["why"].get("216").is_none(), "{out}");
	assert!(out["why"].get("6621").is_none(), "{out}");
}

// With "Skip grey quests" off nothing is left out for being low.
#[test]
fn without_skip_grey_quests_nothing_is_left_out_for_being_low() {
	let out = shipped(
		"Orc",
		"WARRIOR",
		31,
		false,
		"",
		ASHENVALE,
		"",
		false,
		r#"local kinds = {}
for i = 1, E.GetStepCount() do
	for _, o in ipairs(E.LeftOutHere(i, true)) do kinds[o.kind] = true end
end
emit({ catchup = kinds.catchup or false, grey = kinds.grey or false, charm = STATUS(6462) })"#,
	);
	assert_eq!(out, json!({ "catchup": false, "grey": false, "charm": "pending" }));
}
