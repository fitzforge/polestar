//! Engine: a `vendor` check-off beside other work of its step (Own.sideVendor) never holds the step. The
//! step is done once its hand-ins are, merchant window or not; the line is listed while the step is live and
//! the arrow still leads to the vendor in its turn. A step of only vendor goals waits for the merchant window,
//! and a merchant opened during the step still ticks the line. A guide's last step of hand-ins and a vendor
//! ends the guide with the hand-ins. `vendor nearest` ticks at any merchant who repairs in one of its
//! candidates' towns (#1400); a `vendor` naming its NPC only at that NPC. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::Value;

const WORLD: &str = r#"
local w = stub.world
w.addMap(1420, { name = "Tirisfal Glades", c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.moveTo(1420, 60, 52)
w.race, w.faction, w.class, w.className, w.level = "Scourge", "Horde", "WARLOCK", "Warlock", 7
w.titles[404] = "A Putrid Task"; w.titles[367] = "A New Plague"
"#;

// Brill: two quests taken, then their hand-ins with a sell-and-repair stop between them (the vendor first,
// so the arrow's turn is its own), then a vendor-only stop, then a last step of a hand-in and a vendor.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/vendor", pack = "test", title = "Vendor", faction = "Horde", minLevel = 1, maxLevel = 12, steps = {
	{ title = "Take", goals = {
		{ t = "accept", quest = 404, title = "A Putrid Task", npc = 1496, npcName = "Deathguard Dillinger", map = 1420, x = 58.2, y = 51.5 },
		{ t = "accept", quest = 367, title = "A New Plague", npc = 1518, npcName = "Apothecary Johaan", map = 1420, x = 59.4, y = 52.4 },
	} },
	{ title = "Back to Brill", goals = {
		{ t = "vendor", npc = 2134, npcName = "Mrs. Winters", map = 1420, x = 61.4, y = 53.0 },
		{ t = "turnin", quest = 404, title = "A Putrid Task", npc = 1496, npcName = "Deathguard Dillinger", map = 1420, x = 58.2, y = 51.5 },
	} },
	{ title = "Mrs. Winters", goals = { { t = "vendor", npc = 2134, npcName = "Mrs. Winters", map = 1420, x = 61.4, y = 53.0 } } },
	{ title = "Johaan", goals = {
		{ t = "turnin", quest = 367, title = "A New Plague", npc = 1518, npcName = "Apothecary Johaan", map = 1420, x = 59.4, y = 52.4 },
		{ t = "vendor", npc = 2134, npcName = "Mrs. Winters", map = 1420, x = 61.4, y = 53.0 },
	} },
} })
"#;

const HELPERS: &str = r#"			E = Polestar.Engine
			w = stub.world
			function flush() stub.advance(0.25) end
			stub.login()
			Polestar.Set("behavior.autoAccept", false)
			Polestar.Set("behavior.autoTurnin", false)
			ENDS = {}
			Polestar.On("GUIDE_END", function(id) ENDS[#ENDS + 1] = id end)
			E.SetGuide("test/vendor")
			flush()
			w.accept(404, {}); w.accept(367, {}); stub.fire("QUEST_LOG_UPDATE"); flush()
			"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE}\n{HELPERS}{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_step_with_hand_ins_and_a_vendor_is_done_with_the_hand_ins_without_a_merchant() {
	let out = run(r#"
		local r = { start = E.GetStepIndex() }
		local v = E.GetStepView(2).goals[1]
		r.side, r.status = v.side or false, v.status
		local wp = E.GetWaypoint()
		r.arrow = wp and wp.goalIndex or false
		w.turnIn(404); flush()
		r.after = E.GetStepIndex()
		r.passed = E.GetStepView(2).status
		emit(r)
	"#);
	assert_eq!(out["start"], 2);
	assert_eq!(out["side"], true, "the view marks the vendor beside a hand-in as not holding the step");
	assert_eq!(out["status"], "active", "listed while the step is live");
	assert_eq!(out["arrow"], 1, "the arrow still leads to the vendor in its turn");
	assert_eq!(out["after"], 3, "the hand-in done, the step is done without a merchant window");
	assert_eq!(out["passed"], "done");
}

#[test]
fn a_vendor_only_step_waits_for_the_merchant_window() {
	let out = run(r#"
		local r = {}
		w.turnIn(404); flush()
		r.at = E.GetStepIndex()
		r.side = E.GetStepView(3).goals[1].side or false
		stub.advance(5)
		r.waits = E.GetStepIndex()
		w.merchant(2134); flush(); w.close(); flush()
		r.after = E.GetStepIndex()
		emit(r)
	"#);
	assert_eq!(out["at"], 3);
	assert_eq!(out["side"], false, "alone in its step the vendor holds it");
	assert_eq!(out["waits"], 3, "a vendor-only step waits");
	assert_eq!(out["after"], 4, "the merchant window ticks it");
}

#[test]
fn a_merchant_opened_during_the_step_still_ticks_the_vendor_beside_a_hand_in() {
	let out = run(r#"
		local r = {}
		w.merchant(2134); flush(); w.close(); flush()
		r.vendor = E.GetStepView(2).goals[1].status
		r.live = E.GetStepIndex()
		w.turnIn(404); flush()
		r.after = E.GetStepIndex()
		emit(r)
	"#);
	assert_eq!(out["vendor"], "done");
	assert_eq!(out["live"], 2, "the hand-in still holds the step");
	assert_eq!(out["after"], 3);
}

#[test]
fn a_last_step_of_a_hand_in_and_a_vendor_ends_the_guide_with_the_hand_in() {
	let out = run(r#"
		local r = {}
		w.turnIn(404); flush()
		w.merchant(2134); flush(); w.close(); flush()
		r.at = E.GetStepIndex()
		w.turnIn(367); flush(); stub.advance(1)
		r.after = E.GetStepIndex() or false
		r.ended = ENDS[1] or false
		emit(r)
	"#);
	assert_eq!(out["at"], 4);
	assert_eq!(out["after"], false, "the last step is done with its hand-in: the guide is complete");
	assert_eq!(out["ended"], "test/vendor", "and its end is reached");
}

// #1400: `vendor nearest` (candidates, one per town) is a sell-and-repair stop: any merchant who repairs in a
// candidate's town ticks it. Brill's candidate is Mrs. Winters (61.4, 53.0); Morley Bates (2135) stands beside
// her. A `vendor` naming its NPC stays that NPC's. 1% of the test map is 20 yards.
const TOWN_GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/vendor-town", pack = "test", title = "Vendor town", faction = "Horde", minLevel = 1, maxLevel = 12, steps = {
	{ title = "Brill", goals = { { t = "vendor", candidates = {
		{ npc = 2134, npcName = "Mrs. Winters", map = 1420, x = 61.4, y = 53.0, faction = "H" },
		{ npc = 2116, npcName = "Blacksmith Rand", map = 1420, x = 20.0, y = 20.0, faction = "H" },
	} } } },
	{ title = "Named", goals = { { t = "vendor", npc = 2134, npcName = "Mrs. Winters", map = 1420, x = 61.4, y = 53.0 } } },
	{ title = "After", goals = { { t = "goto", map = 1420, x = 10, y = 10 } } },
} })
"#;

fn run_town(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!(
			"{TEST_PACK}\n{TEST_SOURCE}\n{TOWN_GUIDE}\n{}",
			r#"			E = Polestar.Engine
			w = stub.world
			function flush() stub.advance(0.25) end
			stub.login()
			E.SetGuide("test/vendor-town")
			flush()
			"#
		) + script,
		..Default::default()
	})
	.remove(0)
}

#[test]
fn vendor_nearest_ticks_at_another_merchant_who_repairs_in_the_same_town() {
	let out = run_town(
		r#"
		local r = {}
		w.moveTo(1420, 61.0, 53.4); flush()
		r.at = E.GetStepIndex()
		w.merchant(2135, { repair = true }); flush(); w.close(); flush()
		r.after = E.GetStepIndex()
		emit(r)
	"#,
	);
	assert_eq!(out["at"], 1);
	assert_eq!(out["after"], 2, "a merchant who repairs a few yards from the candidate is the same errand");
}

#[test]
fn vendor_nearest_does_not_tick_at_a_merchant_who_cannot_repair() {
	let out = run_town(
		r#"
		local r = {}
		w.moveTo(1420, 61.0, 53.4); flush()
		w.merchant(2135, { repair = false }); flush(); w.close(); flush()
		r.after = E.GetStepIndex()
		r.status = E.GetStepView(1).goals[1].status
		emit(r)
	"#,
	);
	assert_eq!(out["after"], 1, "selling alone is not the sell-and-repair stop");
	assert_ne!(out["status"], "done");
}

#[test]
fn vendor_nearest_does_not_tick_at_a_repairer_outside_every_candidates_town() {
	let out = run_town(
		r#"
		local r = {}
		w.moveTo(1420, 90.0, 90.0); flush()
		w.merchant(2135, { repair = true }); flush(); w.close(); flush()
		r.after = E.GetStepIndex()
		emit(r)
	"#,
	);
	assert_eq!(out["after"], 1, "about 900 yards from Brill and the other candidate: not this stop");
}

#[test]
fn vendor_nearest_still_ticks_at_its_own_candidate() {
	let out = run_town(
		r#"
		local r = {}
		w.moveTo(1420, 61.4, 53.0); flush()
		w.merchant(2134); flush(); w.close(); flush()
		r.after = E.GetStepIndex()
		emit(r)
	"#,
	);
	assert_eq!(out["after"], 2);
}

#[test]
fn a_vendor_naming_its_npc_stays_that_npcs() {
	let out = run_town(
		r#"
		local r = {}
		w.moveTo(1420, 61.0, 53.4); flush()
		w.merchant(2134); flush(); w.close(); flush()
		r.at = E.GetStepIndex()
		w.merchant(2135, { repair = true }); flush(); w.close(); flush()
		r.other = E.GetStepIndex()
		w.merchant(2134); flush(); w.close(); flush()
		r.named = E.GetStepIndex()
		emit(r)
	"#,
	);
	assert_eq!(out["at"], 2);
	assert_eq!(out["other"], 2, "another merchant beside the named one does not tick a named vendor");
	assert_eq!(out["named"], 3);
}
