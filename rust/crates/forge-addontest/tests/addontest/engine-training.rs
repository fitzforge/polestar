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
	// Torm Ragetotem in Thunder Bluff: Harutt Thunderhorn, the next by Mulgore's line, is Camp Narache's, whose
	// training stops at 6 (#2477), and this character is 12.
	assert_eq!(pick(true), 3041);
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
fn a_train_goal_that_already_reads_done_is_no_training_stop_ahead_677() {
	// The sixth step's train goal ticked by hand: the guide trains nowhere ahead, so the reminder is due.
	let out = run(
		Some(&on_guide("test/trains-far", 12)),
		"",
		"stub.advance(0.5)
		local before = { Polestar.Engine.GuideTrainStop() }
		Polestar.Engine.ToggleGoal(6, 1); stub.advance(0.5)
		emit({ before = before, after = { Polestar.Engine.GuideTrainStop() } })",
	);
	assert_eq!(out, json!({ "before": [6], "after": [false] }));
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

// A Night Elf Hunter dinged 20 at the Farstrider Lodge, trained with Dargh Trueaim there, and Loch Modan's
// `train class` step still sent him to Regnus Thundergranite in Ironforge (#1507): the class trainer list
// lacked Dargh and the other trainers the trainer data has. Training with any trainer of the class ticks it;
// portal trainers are no class trainers.
#[test]
fn training_with_dargh_trueaim_at_the_farstrider_lodge_ticks_loch_modan_s_train_class_step_1507() {
	let added = [
		("HUNTER", 10930),
		("HUNTER", 987),
		("HUNTER", 1404),
		("HUNTER", 3963),
		("HUNTER", 5501),
		("HUNTER", 8308),
		("DRUID", 8142),
		("DRUID", 9465),
		("DRUID", 270459),
		("MAGE", 331),
		("PALADIN", 8140),
		("PRIEST", 5994),
		("SHAMAN", 986),
		("WARLOCK", 988),
		("WARRIOR", 985),
		("WARRIOR", 8141),
	];
	for (cls, npc) in added {
		let out = run(None, &format!("stub.world.class = \"{cls}\""), &format!("emit({{ yes = Polestar.Engine.IsClassTrainer({npc}) }})"));
		assert_eq!(out["yes"], true, "{cls} {npc}");
	}
	let out = run(None, r#"stub.world.class = "MAGE""#, "emit({ portal = Polestar.Engine.IsClassTrainer(2489) })");
	assert_eq!(out["portal"], false, "Milstaff Stormeye, a portal trainer");

	let out = run(
		None,
		r#"local w = stub.world
		w.addMap(1432, { name = "Loch Modan", c = 0, left = -1993.75, right = -4752.083, top = -4487.5, bottom = -6327.083 })
		w.race, w.raceName, w.faction, w.class = "NightElf", "Night Elf", "Alliance", "HUNTER"
		w.level = 20
		w.moveTo(1432, 82.4, 62.5)
		Polestar.RegisterGuide({ id = "test/loch", pack = "test", title = "Loch Modan", faction = "Alliance", minLevel = 15, maxLevel = 21, steps = {
			{ goals = { { t = "train", class = true, candidates = { { npc = 5117, npcName = "Regnus Thundergranite", map = 1455, x = 69.87, y = 82.9, f = "e", faction = "A", classes = { "HUNTER" } } } } } },
			{ goals = { { t = "level", level = 21 } } },
		} })"#,
		r#"Polestar.Engine.SetGuide("test/loch") stub.advance(0.5)
		local before = Polestar.Engine.GetStepIndex()
		stub.world.trainer(10930); stub.advance(0.5)
		stub.world.learnSpell(14281); stub.advance(0.5)
		emit({ before = before, after = Polestar.Engine.GetStepIndex() })"#,
	);
	assert_eq!(out, json!({ "before": 1, "after": 2 }), "trained with Dargh Trueaim: the step is done");
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

// A Dwarf at 19 stood at Ironforge's trainer with nothing new, and Loch Modan's `train class` step held
// the guide (2026-11-09): no spell was learned, and no visit had been recorded at 18. A class trainer's
// list with no "available" service is the visit for the level; with one, the step waits for the spell.
#[test]
fn train_class_is_done_when_the_class_trainer_lists_nothing_to_learn_and_waits_for_the_spell_when_it_lists_one() {
	let play = |services: &str, filter_off: bool, after: &str| {
		let pre = format!(
			r#"stub.world.level = 19
			SERVICES = {services}
			function GetNumTrainerServices() return #SERVICES end
			function GetTrainerServiceInfo(i) local s = SERVICES[i] if s then return s[1], s[2] end end
			{}"#,
			if filter_off { "function GetTrainerServiceTypeFilter(kind) return kind ~= \"available\" end" } else { "" }
		);
		run(
			None,
			&pre,
			&format!(
				r#"{AGAIN} stub.advance(0.5)
				local before = Polestar.Engine.GetStepIndex()
				stub.world.trainer(3353); stub.advance(0.5)
				local open = Polestar.Engine.GetStepIndex()
				{after}
				emit({{ before = before, open = open, after = Polestar.Engine.GetStepIndex(), visit = PolestarCharDB.classTrainVisit or false }})"#
			),
		)
	};
	let used = r#"{ { "Battle Shout", "used" }, { "Cleave", "unavailable" } }"#;
	assert_eq!(play(used, false, ""), json!({ "before": 1, "open": 2, "after": 2, "visit": 19 }), "nothing to learn at 19: done");
	assert_eq!(play("{}", false, ""), json!({ "before": 1, "open": 2, "after": 2, "visit": 19 }), "an empty list: done");
	let one = r#"{ { "Battle Shout", "used" }, { "Hamstring", "available" } }"#;
	assert_eq!(play(one, false, "stub.world.learnSpell(1715); stub.advance(0.5)"), json!({ "before": 1, "open": 1, "after": 2, "visit": 19 }), "a spell to learn: waits until it is learned");
	assert_eq!(play(one, false, "stub.world.close(); stub.advance(0.5)"), json!({ "before": 1, "open": 1, "after": 1, "visit": false }), "closed without training: still open");
	// With the "available" filter off the list hides what could be learned: no word either way.
	assert_eq!(play(used, true, ""), json!({ "before": 1, "open": 1, "after": 1, "visit": false }), "filter off: unknown");
	// The list after the last purchase (TRAINER_UPDATE) has nothing left.
	assert_eq!(
		play(one, false, r#"SERVICES[2][2] = "used"; stub.fire("TRAINER_UPDATE"); stub.advance(0.5)"#),
		json!({ "before": 1, "open": 1, "after": 2, "visit": 19 }),
		"nothing left after training"
	);
}

// #3608 (JAKEJ): "Sends me to the trainer when I have things to train. It's common, probably typical to skip
// things": the guide's `train class` step stayed open while the trainer listed a new rank of a spell he knows and
// skips. A new rank of a known spell (the spellbook holds one of that name) is nothing new; a new spell still is.
#[test]
fn train_class_is_done_when_the_trainer_lists_only_new_ranks_of_known_spells_3608() {
	let play = |services: &str| {
		let pre = format!(
			r#"stub.world.level = 19
			SERVICES = {services}
			function GetNumTrainerServices() return #SERVICES end
			function GetTrainerServiceInfo(i) local s = SERVICES[i] if s then return s[1], s[2] end end
			C_Spell = C_Spell or {{}}
			C_Spell.GetSpellName = function(id) return id == 78 and "Heroic Strike" or nil end
			C_SpellBook.GetNumSpellBookSkillLines = function() return 1 end
			C_SpellBook.GetSpellBookSkillLineInfo = function() return {{ itemIndexOffset = 0, numSpellBookItems = 1 }} end
			C_SpellBook.GetSpellBookItemInfo = function(k) return k == 1 and {{ spellID = 78, itemType = 1 }} or nil end"#
		);
		run(
			None,
			&pre,
			&format!(
				r#"{AGAIN} stub.advance(0.5)
				stub.world.trainer(3353); stub.advance(0.5)
				stub.world.close(); stub.advance(0.5)
				emit({{ after = Polestar.Engine.GetStepIndex(), visit = PolestarCharDB.classTrainVisit or false }})"#
			),
		)
	};
	let rank = r#"{ { "Battle Shout", "used" }, { "Heroic Strike", "available" } }"#;
	assert_eq!(play(rank), json!({ "after": 2, "visit": 19 }), "only Heroic Strike's next rank: done, closed without training");
	let new = r#"{ { "Heroic Strike", "available" }, { "Hamstring", "available" } }"#;
	assert_eq!(play(new), json!({ "after": 1, "visit": false }), "Hamstring is new: still open");
}

#[test]
fn a_spell_learned_at_a_class_trainer_records_the_visit_s_level_opening_the_window_or_a_first_sight_does_not() {
	let out = run(
		None,
		"",
		r#"
			stub.advance(0.5)
			local before = PolestarCharDB.classTrainVisit
			stub.world.trainer(3353); stub.advance(0.5)
			local opened = PolestarCharDB.classTrainVisit
			stub.world.learnSpell(100); stub.advance(0.5)
			emit({ before = before or false, opened = opened or false, visit = PolestarCharDB.classTrainVisit })"#,
	);
	assert_eq!(out, json!({ "before": false, "opened": false, "visit": 12 }));
}

// The guide's class training stop `at` applicable steps from the first: walks across the Barrens, then Orgrimmar.
fn trains_at(at: usize) -> String {
	let mut steps: Vec<String> = (1..at).map(|i| format!(r#"{{ title = "Walk {i}", goals = {{ {{ t = "goto", map = 1413, x = {}, y = 30 }} }} }}"#, 40 + i)).collect();
	steps.push(
		r#"{ title = "Orgrimmar", goals = { { t = "train", class = true, candidates = { { npc = 3353, npcName = "Grezz Ragefist", map = 1454, x = 79.8, y = 31.4, f = "e", faction = "H", classes = { "WARRIOR" } } } } } }"#
			.into(),
	);
	steps.push(r#"{ goals = { { t = "level", level = 20 } } }"#.into());
	format!(r#"Polestar.RegisterGuide({{ id = "test/orgrimmar-{at}", pack = "test", title = "To Orgrimmar", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {{ {} }} }})"#, steps.join(", "))
}

const ADVICE: &str = r#"stub.advance(0.5)
local a = Polestar.Engine.TrainingAdvice()
local t = Polestar.Engine.NearestClassTrainer(true)
emit({ guide = a.guide or false, steps = a.steps, title = a.title, trainer = a.trainer and a.trainer.npc or false,
	planner = t and t.npc or false, due = #DUE, dueNpc = DUE[1] and DUE[1].npc or false })"#;

#[test]
fn at_the_crossroads_with_the_guide_training_in_orgrimmar_in_10_steps_the_advice_is_the_guide_s_stop_and_names_no_trainer() {
	let out = run(Some(&on_guide("test/orgrimmar-10", 10)), &trains_at(10), ADVICE);
	assert_eq!(out["guide"], true, "{out}");
	assert_eq!(out["steps"], 10);
	assert_eq!(out["title"], "Orgrimmar");
	assert_eq!(out["trainer"], false, "no other trainer named: {out}");
	// The reminder itself still comes (the stop is past its 4-step hold); the banner words it from the advice.
	assert_eq!(out["due"], 1, "{out}");
}

// #2843 (wangcow, a Gnome Warlock at 24 in Darkshore): the reminder sent him to Strahad Farsan in Ratchet while his
// guide trains him in Ironforge after the Wetlands, past the banner's old 10 steps; on Stormwind's Lookup guide,
// the leveling guide in another tab. Fitz: the reminder skips the nearest trainer when the guide has its own trainer
// stop coming up. The guide's stop wins however far ahead, also from the leveling tab while a Lookup guide is
// active; with none ahead, the planner's trainer, as the reminder names it.
#[test]
fn the_guide_s_own_training_stop_ahead_however_far_is_the_advice_and_from_a_lookup_tab_the_leveling_tab_s_2843() {
	let out = run(Some(&on_guide("test/orgrimmar-40", 10)), &trains_at(40), ADVICE);
	assert_eq!(out["guide"], true, "{out}");
	assert_eq!(out["steps"], 40);
	assert_eq!(out["trainer"], false, "no other trainer named: {out}");
	let lookup = r#"Polestar.RegisterGuide({ id = "test/lookup", pack = "test", title = "Lookup", category = "Lookup", faction = "Horde", minLevel = 1, maxLevel = 60, steps = {
		{ goals = { { t = "goto", map = 1413, x = 50, y = 50 } } } } })"#;
	let tabs = r#"PolestarCharDB = { schema = 1, classTrainLevel = 10, tabs = { "test/orgrimmar-40", "test/lookup" }, activeTab = 2 }"#;
	let out = run(Some(tabs), &format!("{}\n{lookup}", trains_at(40)), &format!("emit(Polestar.Engine.GetGuide().id)\n{ADVICE}"));
	assert_eq!(out, json!("test/lookup"));
	let out = run(Some(tabs), &format!("{}\n{lookup}", trains_at(40)), ADVICE);
	assert_eq!((&out["guide"], &out["steps"], &out["title"]), (&json!(true), &json!(40), &json!("Orgrimmar")), "{out}");
	let none = run(Some(&on_guide("test/barrens", 10)), "", ADVICE);
	assert_eq!(none["guide"], false, "{none}");
	assert_eq!(none["steps"], false, "{none}");
	assert_ne!(none["trainer"], false, "{none}");
	assert_eq!(none["trainer"], none["planner"], "ranked by the travel planner on the guide's way: {none}");
	assert_eq!(none["trainer"], none["dueNpc"], "the banner's trainer and the advice agree: {none}");
}

// Kill stutter (0.4.1): the guide window's training banner asks for the trainer on the guide's way on every
// repaint (each kill and loot while training is due), and each answer priced up to four trainers with three
// route plans each; then (#3451) on every zone change and every few yards walked, its relayout in a step
// change's frame. The answer is kept per zone for the guide: ten repaints, a walk across the Barrens, a
// trainer window, a level that is no training level and a flight map that learned nothing plan no route; a
// new zone is priced once, and coming back to the Barrens plans nothing and gives its pick again. The next
// training level and a new flight price it afresh.
#[test]
fn the_banner_s_trainer_on_the_route_is_priced_once_per_zone_until_the_next_training_level_or_a_new_flight_3451() {
	let out = run(
		Some(&on_guide("test/route", 10)),
		"KNOWN = { [1] = true }; Polestar.Nav = { GetKnownTaxiNodes = function() return KNOWN end }",
		r#"
		stub.advance(0.5)
		local E, w = Polestar.Engine, stub.world
		-- Route plans made by the trainer pick only (the reminder's and the banner's, Engine.NearestClassTrainer): a
		-- zone change or a level-up plans other routes of its own, the candidates' re-pick (pickFor's eight) among
		-- them, made here before the counted call.
		local plans, picking = 0, false
		local cost = Polestar.TravelCost
		Polestar.TravelCost = function(...) if picking then plans = plans + 1 end return cost(...) end
		local nearest = E.NearestClassTrainer
		E.NearestClassTrainer = function(...)
			nearest()
			picking = true
			local t = nearest(...)
			picking = false
			return t
		end
		local out = {}
		local function priced(fn)
			local p = plans
			fn()
			return plans - p
		end
		local first
		out.first = priced(function() first = E.TrainingAdvice().trainer.npc end)
		out.repaints = priced(function() for _ = 1, 10 do stub.advance(0.1); E.TrainingAdvice() end end)
		local same = true
		out.walk = priced(function()
			local x, y = 51.9, 30.4
			for _ = 1, 30 do
				x, y = x - 0.3, y + 0.9
				w.moveTo(1413, x, y)
				stub.advance(0.1)
				if E.NearestClassTrainer(true).npc ~= first then same = false end
			end
		end)
		out.same = same
		out.mulgore = priced(function() w.moveTo(1412, 47, 60); stub.fire("ZONE_CHANGED_NEW_AREA"); stub.advance(0.1); E.NearestClassTrainer(true) end)
		out.back = priced(function()
			w.moveTo(1413, 45, 58); stub.fire("ZONE_CHANGED_NEW_AREA"); stub.advance(0.1)
			out.backSame = E.NearestClassTrainer(true).npc == first
		end)
		out.trainer = priced(function() stub.fire("TRAINER_CLOSED"); E.NearestClassTrainer(true) end)
		out.odd = priced(function() w.setLevel(13); stub.advance(0.5); E.NearestClassTrainer(true) end)
		out.map = priced(function() stub.fire("TAXIMAP_CLOSED"); E.NearestClassTrainer(true) end)
		out.flight = priced(function() KNOWN[2] = true; stub.fire("TAXIMAP_CLOSED"); E.NearestClassTrainer(true) end)
		out.even = priced(function() w.setLevel(14); stub.advance(0.5); E.NearestClassTrainer(true) end)
		emit(out)
	"#,
	);
	// Measured: 0.4.1 planned 12 routes for each repaint (120 for the ten); kept, none.
	assert_eq!(out["repaints"], 0, "route plans for ten repaints: {out}");
	assert_eq!(out["walk"], 0, "route plans walking across the zone: {out}");
	assert_eq!(out["same"], true, "{out}");
	assert!(out["mulgore"].as_u64().unwrap() > 0, "a new zone is priced: {out}");
	assert_eq!(out["back"], 0, "back in the Barrens: {out}");
	assert_eq!(out["backSame"], true, "{out}");
	for case in ["trainer", "odd", "map"] {
		assert_eq!(out[case], 0, "{case}: {out}");
	}
	assert!(out["flight"].as_u64().unwrap() > 0, "a new flight prices it afresh: {out}");
	assert!(out["even"].as_u64().unwrap() > 0, "the next training level prices it afresh: {out}");
}

// On a flight the player's spot changes every few seconds, and the banner's trainer on the route was priced
// again at each new spot (up to four trainers with three route plans each: frames of 30 ms and more on a
// flight). The pick of the zone the player boarded in stands for the whole flight, whatever it flies over; the
// zone they land in is priced once they land.
#[test]
fn on_a_flight_the_banner_s_trainer_is_priced_once_and_picked_for_the_landing_zone() {
	let out = run(
		Some(&on_guide("test/route", 10)),
		"",
		r#"
		stub.advance(0.5)
		local E, w = Polestar.Engine, stub.world
		local plans = 0
		local cost = Polestar.TravelCost
		Polestar.TravelCost = function(...) plans = plans + 1; return cost(...) end
		local before = E.TrainingAdvice().trainer.npc
		-- Boards a flight at the Crossroads, then flies south-west for 30 seconds, the window repainting each second.
		w.onTaxi = true
		stub.fire("PLAYER_CONTROL_LOST")
		stub.advance(0.5)
		E.TrainingAdvice()
		local p0 = plans
		local x, y = 51.9, 30.4
		local kept = true
		for k = 1, 30 do
			x, y = x - 0.5, y + 1.4
			if k > 20 then w.moveTo(1412, 47, 40 + k) else w.moveTo(1413, x, y) end
			stub.advance(1)
			if E.TrainingAdvice().trainer.npc ~= before then kept = false end
		end
		local flying = plans - p0
		-- Lands in Mulgore.
		w.onTaxi = false
		stub.fire("PLAYER_CONTROL_GAINED")
		stub.advance(0.5)
		local p1 = plans
		E.NearestClassTrainer(true)
		local landPlans = plans - p1
		emit({ before = before ~= nil, flying = flying, kept = kept, landPlans = landPlans })
	"#,
	);
	assert_eq!(out["before"], true, "{out}");
	// Measured on 0.4.2-rc1: 300 route plans in the 30 seconds of flight (ten a second); kept, none.
	assert_eq!(out["flying"], 0, "route plans for the banner's trainer during a flight: {out}");
	assert_eq!(out["kept"], true, "{out}");
	assert!(out["landPlans"].as_u64().unwrap() > 0, "the landing zone is not priced: {out}");
}
