//! Class-training reminder (Engine "Smart logic"): with the shipped Core/ClassTrainers.lua, a character whose
//! guide does not send them to their class trainer is reminded, with the nearest trainer of their class and
//! faction. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

// An Undead Warrior at the Crossroads (Era frame of the Barrens).
const WORLD: &str = r#"
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 2622.917, right = -7510.417, top = 1612.5, bottom = -5139.583 })
w.addMap(1412, { name = "Mulgore", c = 1, left = 2047.917, right = -3089.583, top = -272.917, bottom = -3697.917 })
w.race, w.raceName, w.faction, w.class = "Scourge", "Undead", "Horde", "WARRIOR"
w.level = 12
w.moveTo(1413, 51.9, 30.4)
"#;

// The Barrens guide trains Orcs and Trolls in Orgrimmar; nothing for an Undead.
const GUIDES: &str = r#"
Polestar.RegisterGuide({ id = "test/barrens", pack = "test", title = "The Barrens", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
	{ goals = { { t = "accept", quest = 870, title = "The Forgotten Pools", map = 1413, x = 52, y = 31 } } },
	{ only = { races = { "Orc", "Troll" } }, goals = { { t = "train", npc = 3353, npcName = "Grezz Ragefist", only = { classes = { "WARRIOR" } } } } },
	{ goals = { { t = "level", level = 20 } } },
} })
Polestar.RegisterGuide({ id = "test/trains", pack = "test", title = "Trains soon", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
	{ goals = { { t = "accept", quest = 870, title = "The Forgotten Pools", map = 1413, x = 52, y = 31 } } },
	{ goals = { { t = "train", class = true, candidates = { { npc = 3353, npcName = "Grezz Ragefist", map = 1454, x = 79.8, y = 31.4, f = "e", faction = "H", classes = { "WARRIOR" } } } } } },
	{ goals = { { t = "level", level = 20 } } },
} })
-- Heads south-west to Mulgore: the nearest trainer from the Crossroads lies the other way.
Polestar.RegisterGuide({ id = "test/route", pack = "test", title = "To Mulgore", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
	{ goals = { { t = "accept", quest = 870, title = "The Forgotten Pools", map = 1413, x = 52, y = 31 } } },
	{ goals = { { t = "goto", map = 1413, x = 45, y = 58 } } },
	{ goals = { { t = "goto", map = 1412, x = 47, y = 60 } } },
	{ goals = { { t = "level", level = 20 } } },
} })
-- Dun Morogh: from the trogg tunnel on to Kharanos (the report in #664).
Polestar.RegisterGuide({ id = "test/tunnel", pack = "test", title = "The tunnel", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ goals = { { t = "accept", quest = 2160, title = "Supplies to Tannok", map = 1426, x = 33.9, y = 72.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 47.2, y = 52.4 } } },
	{ goals = { { t = "goto", map = 1426, x = 47.3, y = 52.9 } } },
	{ goals = { { t = "level", level = 20 } } },
} })
-- A Dwarf near the tunnel with Coldridge work still ahead: Anvilmar, then the tunnel, then Kharanos.
Polestar.RegisterGuide({ id = "test/coldridge", pack = "test", title = "Coldridge", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ goals = { { t = "goto", map = 1426, x = 28.8, y = 66.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 26.9, y = 80.0 } } },
	{ goals = { { t = "goto", map = 1426, x = 28.8, y = 66.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 33.9, y = 72.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 47.2, y = 52.4 } } },
	{ goals = { { t = "level", level = 20 } } },
} })
-- Grik'nir's cave, then (or not) a stop in Anvilmar, the tunnel and Kharanos.
Polestar.RegisterGuide({ id = "test/cave-anvilmar", pack = "test", title = "Cave, Anvilmar", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ goals = { { t = "goto", map = 1426, x = 26.9, y = 80.0 } } },
	{ goals = { { t = "goto", map = 1426, x = 28.8, y = 66.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 33.9, y = 72.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 47.2, y = 52.4 } } },
	{ goals = { { t = "level", level = 20 } } },
} })
Polestar.RegisterGuide({ id = "test/cave-direct", pack = "test", title = "Cave, tunnel", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ goals = { { t = "goto", map = 1426, x = 26.9, y = 80.0 } } },
	{ goals = { { t = "goto", map = 1426, x = 33.9, y = 72.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 47.2, y = 52.4 } } },
	{ goals = { { t = "level", level = 20 } } },
} })
-- The trainer is the sixth step: past the reminder's reach from step 1.
Polestar.RegisterGuide({ id = "test/trains-far", pack = "test", title = "Trains far", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
	{ goals = { { t = "goto", map = 1413, x = 20, y = 20 } } },
	{ goals = { { t = "goto", map = 1413, x = 21, y = 20 } } },
	{ goals = { { t = "goto", map = 1413, x = 22, y = 20 } } },
	{ goals = { { t = "goto", map = 1413, x = 23, y = 20 } } },
	{ goals = { { t = "goto", map = 1413, x = 24, y = 20 } } },
	{ goals = { { t = "train", class = true, candidates = { { npc = 3353, npcName = "Grezz Ragefist", map = 1454, x = 79.8, y = 31.4, f = "e", faction = "H", classes = { "WARRIOR" } } } } } },
	{ goals = { { t = "level", level = 20 } } },
} })
"#;

const EVENTS: &str = r#"
DUE = {}
Polestar.On("TRAIN_DUE", function(level, t) DUE[#DUE + 1] = { level = level, npc = t.npc, map = t.map, faction = t.faction, warrior = (function() for _, c in ipairs(t.classes) do if c == "WARRIOR" then return true end end return false end)() } end)
Polestar.On("CLASS_TRAINED", function(level) DUE[#DUE + 1] = { trained = level } end)
"#;

fn run(saved: Option<&str>, pre: &str, script: &str) -> Value {
	run_files(saved, pre, script, &["Core/Core.xml"])
}

fn run_files(saved: Option<&str>, pre: &str, script: &str, files: &[&str]) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", files)],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: [TEST_PACK, TEST_SOURCE, GUIDES, EVENTS, pre, "stub.login()", script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

const TRAINED_AT_10: Option<&str> = Some("PolestarCharDB = { schema = 1, classTrainLevel = 10 }");

#[test]
fn an_undead_in_the_barrens_is_reminded_at_12_with_the_nearest_horde_warrior_trainer_training_clears_it() {
	let out = run(
		TRAINED_AT_10,
		"",
		r#"
			Polestar.Engine.SetGuide("test/barrens"); stub.advance(0.5)
			local first = DUE[1]
			-- Once per level: more evaluations do not repeat it.
			stub.advance(0.5); Polestar.Engine.RequestUpdate(); stub.advance(0.5)
			local count = #DUE
			stub.world.trainer(first.npc); stub.advance(0.5)
			emit({ first = first, count = count, trained = DUE[#DUE], saved = PolestarCharDB.classTrainLevel })"#,
	);
	assert_eq!(out["first"]["level"], 12);
	assert_eq!(out["first"]["faction"], "H");
	assert_eq!(out["first"]["warrior"], true);
	// Kalimdor, near the Crossroads: Orgrimmar or Durotar, never Undercity.
	assert!(out["first"]["map"] == 1411 || out["first"]["map"] == 1454, "trainer on map {}", out["first"]["map"]);
	assert_eq!(out["count"], 1);
	assert_eq!(out["trained"], json!({ "trained": 12 }));
	assert_eq!(out["saved"], 12);
}

#[test]
fn a_warlock_at_the_crossroads_is_reminded_with_strahad_farsan_in_ratchet_not_orgrimmar() {
	let out = run(
		Some("PolestarCharDB = { schema = 1, classTrainLevel = 16 }"),
		r#"stub.world.race, stub.world.raceName, stub.world.class, stub.world.level = "Orc", "Orc", "WARLOCK", 18"#,
		r#"
			Polestar.Engine.SetGuide("test/barrens"); stub.advance(0.5)
			emit({ npc = DUE[1] and DUE[1].npc, trainer = Polestar.Engine.IsClassTrainer(6251) })"#,
	);
	assert_eq!(out, json!({ "npc": 6251, "trainer": true }));
}

#[test]
fn no_reminder_when_the_guide_trains_the_class_within_its_next_steps_on_odd_levels_on_first_sight_or_when_off() {
	// The open guide sends warriors to their trainer two steps ahead.
	let soon = run(
		Some(r#"PolestarCharDB = { schema = 1, classTrainLevel = 10, tabs = { "test/trains" }, activeTab = 1 }"#),
		"",
		"stub.advance(0.5); emit({ due = #DUE, guide = Polestar.Engine.GetGuide().id })",
	);
	assert_eq!(soon, json!({ "due": 0, "guide": "test/trains" }));

	let odd = run(TRAINED_AT_10, "stub.world.level = 11", "stub.advance(0.5); emit({ due = #DUE })");
	assert_eq!(odd["due"], 0);

	// No stored level (new install, or lost saved variables): counts as trained now.
	let fresh = run(None, "", "stub.advance(0.5); emit({ due = #DUE, saved = PolestarCharDB.classTrainLevel })");
	assert_eq!(fresh, json!({ "due": 0, "saved": 12 }));

	let off = run(TRAINED_AT_10, r#"Polestar.Set("behavior.trainReminder", "off")"#, "stub.advance(0.5); emit({ due = #DUE })");
	assert_eq!(off["due"], 0);
}

/// A character with `guide` open, last trained at `trained`.
fn on_guide(guide: &str, trained: i32) -> String {
	format!(r#"PolestarCharDB = {{ schema = 1, classTrainLevel = {trained}, tabs = {{ "{guide}" }}, activeTab = 1 }}"#)
}

// Dun Morogh's Era frame, with a Dwarf Shaman at `level` standing at (x, y).
fn dwarf_shaman(level: i32, x: f64, y: f64) -> String {
	format!(
		r#"local w = stub.world
			w.addMap(1426, {{ name = "Dun Morogh", c = 0, left = 1802.083, right = -3122.917, top = -3877.083, bottom = -7160.417 }})
			w.race, w.raceName, w.faction, w.class, w.level = "Dwarf", "Dwarf", "Alliance", "SHAMAN", {level}
			w.moveTo(1426, {x}, {y})"#
	)
}

#[test]
fn the_reminder_names_the_trainer_on_the_guide_s_route_not_the_nearest_one_behind_it_664() {
	let near = run(TRAINED_AT_10, "", "stub.advance(0.5); emit({ map = DUE[1].map })");
	// With no guide open the nearest trainer is east, in Durotar or Orgrimmar.
	assert!(near["map"] == 1411 || near["map"] == 1454, "trainer on map {}", near["map"]);
	let route = run(Some(&on_guide("test/route", 10)), "", "stub.advance(0.5); emit({ map = DUE[1].map, npc = DUE[1].npc })");
	assert!(route["map"] == 1412 || route["map"] == 1456, "trainer on map {}, npc {}", route["map"], route["npc"]);
}

#[test]
fn the_route_never_leads_to_a_trainer_in_a_zone_far_above_the_character() {
	let out = run_files(
		Some(&on_guide("test/route", 10)),
		"Polestar.Maps.RegisterZoneLevels({ [1413] = { 10, 25, 50, 50 }, [1411] = { 1, 10, 50, 50 }, [1454] = { 1, 20, 50, 50 }, [1412] = { 55, 60, 50, 50 }, [1456] = { 55, 60, 50, 50 } })",
		"stub.advance(0.5); emit({ map = DUE[1].map })",
		&["Core/Core.xml", "Maps/Maps.lua", "Maps/WorldMap.lua"],
	);
	assert!(out["map"] == 1411 || out["map"] == 1454, "trainer on map {}", out["map"]);
}

#[test]
fn a_trainer_close_by_line_but_far_by_the_route_planner_a_mountain_between_loses_to_one_that_is_reachable() {
	let pick = |planner: bool| {
		let pre = if planner {
			r#"Polestar.Nav = { EstimateTravel = function(a, b)
			if a.npc == 3063 or b.npc == 3063 then return 2500 end -- Krang Stonehoof: over the ridge
			return a.map == b.map and 100 or 1000
		end }"#
		} else {
			""
		};
		run(Some(&on_guide("test/route", 10)), pre, "stub.advance(0.5); emit({ npc = DUE[1].npc })")["npc"].clone()
	};
	assert_eq!(pick(false), 3063);
	// Harutt Thunderhorn, the next Mulgore trainer.
	assert_eq!(pick(true), 3059);
}

#[test]
fn a_dwarf_shaman_who_dings_6_in_the_trogg_tunnel_is_sent_on_to_kharanos_not_back_to_anvilmar_664() {
	let out = run(Some(&on_guide("test/tunnel", 4)), &dwarf_shaman(6, 36.5, 71.5), "stub.advance(0.5); emit({ due = #DUE, npc = DUE[1] and DUE[1].npc })");
	// 257446 Teo Hammerstorm (Anvilmar), 258113 Ingrid Dunwald (Kharanos).
	assert_eq!(out, json!({ "due": 1, "npc": 258113 }));
}

#[test]
fn near_the_tunnel_with_coldridge_work_still_ahead_the_reminder_keeps_to_anvilmar_664() {
	let out = run(Some(&on_guide("test/coldridge", 2)), &dwarf_shaman(4, 36.5, 71.5), "stub.advance(0.5); emit({ step = Polestar.Engine.GetStepIndex(), npc = DUE[1] and DUE[1].npc })");
	// 257446 Teo Hammerstorm (Anvilmar).
	assert_eq!(out, json!({ "step": 1, "npc": 257446 }));
}

#[test]
fn a_stop_in_anvilmar_on_the_way_out_of_the_cave_keeps_the_reminder_there_without_it_kharanos_wins_664() {
	let pick = |guide: &str| run(Some(&on_guide(guide, 4)), &dwarf_shaman(6, 27.5, 79.0), "stub.advance(0.5); emit({ npc = DUE[1] and DUE[1].npc })")["npc"].clone();
	// 257446 Teo Hammerstorm (Anvilmar), 258113 Ingrid Dunwald (Kharanos).
	assert_eq!(pick("test/cave-anvilmar"), 257446);
	assert_eq!(pick("test/cave-direct"), 258113);
}

#[test]
fn the_reminder_follows_the_live_step_not_the_step_on_screen_664() {
	// Trained at 12 and at 12 now: nothing due until the level-up to 14 below.
	let level_up = |guide: &str, view: i32| {
		run(
			Some(&on_guide(guide, 12)),
			"",
			&format!(
				"stub.advance(0.5)
			Polestar.Engine.Goto({view}); stub.advance(0.5)
			stub.world.level = 14
			Polestar.Engine.RequestUpdate(); stub.advance(0.5)
			emit({{ due = #DUE, step = Polestar.Engine.GetStepIndex() }})"
			),
		)
	};
	// Live step 1, trainer at 6: out of reach, so it is due, though step 6 is on screen.
	assert_eq!(level_up("test/trains-far", 6), json!({ "due": 1, "step": 6 }));
	// Live step 1, trainer at 2: within reach, so held back, though step 3 is on screen.
	assert_eq!(level_up("test/trains", 3), json!({ "due": 0, "step": 3 }));
}

#[test]
fn the_guide_s_next_training_stop_counts_applicable_steps_from_the_live_step_not_the_step_on_screen_668() {
	let stop = |guide: &str, view: i32| {
		run(
			Some(&on_guide(guide, 12)),
			"",
			&format!(
				"stub.advance(0.5)
			Polestar.Engine.Goto({view}); stub.advance(0.5)
			emit({{ Polestar.Engine.GuideTrainStop() }})"
			),
		)
	};
	// The trainer is the sixth step, counting the live one.
	assert_eq!(stop("test/trains-far", 6), json!([6]));
	assert_eq!(stop("test/trains", 3), json!([2]));
	// The Barrens trains only Orcs and Trolls: nothing ahead for an Undead.
	assert_eq!(stop("test/barrens", 1), json!([false]));
}

#[test]
fn a_class_trainer_is_one_the_registry_holds_for_the_character_s_class_riding_trainers_and_other_classes_are_not() {
	let out = run(
		None,
		"",
		r#"
			local E = Polestar.Engine
			emit({ warrior = E.IsClassTrainer(2119), mage = E.IsClassTrainer(198), riding = E.IsClassTrainer(4732), none = E.IsClassTrainer(nil) })"#,
	);
	// Dannal Stern (warrior, Tirisfal), Khelden Bremen (mage, Northshire), Randal Hunter (riding, Elwynn).
	assert_eq!(out, json!({ "warrior": true, "mage": false, "riding": false, "none": false }));
}

#[test]
fn every_class_trainer_counts_not_only_the_reminder_s_one_per_town_capital_trainers_the_guides_use_pet_and_weapon_trainers_do_not() {
	// Xor'juul (hunter, Orgrimmar), Mirket (warlock, Orgrimmar), Dink (mage, Ironforge), Fenthwick (rogue,
	// Ironforge), Grezz Ragefist and Ander Germaine (warriors, Orgrimmar and Stormwind).
	let cases = [("HUNTER", 3406), ("WARLOCK", 3325), ("MAGE", 7312), ("ROGUE", 5167), ("WARRIOR", 3353), ("WARRIOR", 914)];
	for (cls, npc) in cases {
		let out = run(None, &format!("stub.world.class = \"{cls}\""), &format!("emit({{ yes = Polestar.Engine.IsClassTrainer({npc}) }})"));
		assert_eq!(out["yes"], true, "{cls} {npc}");
	}
	// Pet trainer (Nalesette Wildbringer), weapon master (Hanashi), riding (Randal Hunter), and Ariyell
	// Skyshadow, a Darnassus weapon merchant.
	let out = run(
		None,
		r#"stub.world.class = "HUNTER""#,
		"local E = Polestar.Engine emit({ pet = E.IsClassTrainer(543), weapon = E.IsClassTrainer(2704), riding = E.IsClassTrainer(4732), merchant = E.IsClassTrainer(4203) })",
	);
	assert_eq!(out, json!({ "pet": false, "weapon": false, "riding": false, "merchant": false }));
}

// Grezz trains warriors in step 1; step 2 holds the route; step 3 trains again.
const AGAIN: &str = r#"
local grezz = { { npc = 3353, npcName = "Grezz Ragefist", map = 1454, x = 79.8, y = 31.4, f = "e", faction = "H", classes = { "WARRIOR" } } }
Polestar.RegisterGuide({ id = "test/again", pack = "test", title = "Trains again", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
	{ goals = { { t = "train", class = true, candidates = grezz } } },
	{ goals = { { t = "accept", quest = 870, title = "The Forgotten Pools", map = 1413, x = 52, y = 31 } } },
	{ goals = { { t = "train", class = true, candidates = grezz } } },
	{ goals = { { t = "level", level = 20 } } },
} })
Polestar.Engine.SetGuide("test/again")
"#;

#[test]
fn train_class_asks_nothing_when_there_is_nothing_new_trained_at_this_level_or_at_the_even_level_below_an_odd_one() {
	let at = |level: i32, visit: Option<i32>, extra: &str| {
		let saved = format!("PolestarCharDB = {{ schema = 1, classTrainLevel = {}{} }}", visit.unwrap_or(level), visit.map(|v| format!(", classTrainVisit = {v}")).unwrap_or_default());
		run(Some(&saved), &format!("stub.world.level = {level}"), &format!("{AGAIN} stub.advance(0.5) {extra} emit({{ step = Polestar.Engine.GetStepIndex() }})"))["step"].clone()
	};
	assert_eq!(at(12, Some(12), ""), 2, "trained at 12, still 12");
	assert_eq!(at(13, Some(12), ""), 2, "trained at 12, now 13: classes learn on even levels");
	assert_eq!(at(14, Some(12), ""), 1, "trained at 12, now 14: new spells");
	assert_eq!(at(13, Some(11), ""), 1, "trained at 11, now 13: 12 brought spells");
	// Only a visit counts: a level stored on first sight (no visit) does not.
	assert_eq!(at(12, None, ""), 1, "no visit recorded");
	// Done and passed stays done: the next level does not send the player back.
	assert_eq!(at(13, Some(12), "stub.world.setLevel(14) stub.advance(0.5)"), 2, "passed at 13, then 14");
}

#[test]
fn opening_a_class_trainer_records_the_visit_s_level_a_first_sight_does_not() {
	let out = run(
		None,
		"",
		r#"
			stub.advance(0.5)
			local before = PolestarCharDB.classTrainVisit
			stub.world.trainer(3353); stub.advance(0.5)
			emit({ before = before or false, visit = PolestarCharDB.classTrainVisit })"#,
	);
	assert_eq!(out, json!({ "before": false, "visit": 12 }));
}
