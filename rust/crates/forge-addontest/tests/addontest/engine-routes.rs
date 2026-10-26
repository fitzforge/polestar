//! Route choice (Engine "Route choice"): a guide whose `next` names several guides lets the player choose where
//! to level; the Engine asks, remembers, recommends the nearest, and skips quest goals the character never had.
//! Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

// Kalimdor (c = 1): Durotar east of the Barrens; Eastern Kingdoms (c = 0): Tirisfal north of Silverpine.
// Frames are simplified squares.
const WORLD: &str = r#"
local w = stub.world
w.addMap(1411, { name = "Durotar", c = 1, left = -3000, right = -6000, top = 1000, bottom = -2000 })
w.addMap(1413, { name = "The Barrens", c = 1, left = 0, right = -3000, top = 1000, bottom = -2000 })
w.addMap(1420, { name = "Tirisfal Glades", c = 0, left = 3000, right = 0, top = 3000, bottom = 0 })
w.addMap(1421, { name = "Silverpine Forest", c = 0, left = 3000, right = 0, top = 0, bottom = -3000 })
w.race, w.raceName, w.faction, w.class = "Orc", "Orc", "Horde", "WARRIOR"
"#;

const GUIDES: &str = r#"
Polestar.RegisterGuide({ id = "test/durotar", pack = "test", title = "Durotar", faction = "Horde", races = { "Orc", "Troll" }, minLevel = 1, maxLevel = 10,
	next = "test/barrens", nextChoices = { "test/barrens", "test/silverpine", "test/mulgore-only" }, steps = {
	{ goals = { { t = "accept", quest = 1, title = "Your Place In The World", map = 1411, x = 42, y = 68 } } },
	{ goals = { { t = "turnin", quest = 1, title = "Your Place In The World", map = 1411, x = 52, y = 43 } } },
} })
Polestar.RegisterGuide({ id = "test/tirisfal", pack = "test", title = "Tirisfal Glades", faction = "Horde", races = { "Undead" }, minLevel = 1, maxLevel = 10,
	next = "test/silverpine", nextChoices = { "test/silverpine", "test/barrens" }, steps = {
	{ goals = { { t = "accept", quest = 2, title = "Rude Awakening", map = 1420, x = 30, y = 71 } } },
	{ goals = { { t = "turnin", quest = 2, title = "Rude Awakening", map = 1420, x = 61, y = 52 } } },
} })
Polestar.RegisterGuide({ id = "test/barrens", pack = "test", title = "The Barrens", faction = "Horde", minLevel = 10, maxLevel = 20, zone = 1413,
	zoneName = "The Barrens", next = "test/stonetalon", pitch = "Dense quests around a central hub.",
	pros = { "Most quests in one zone", "Crossroads flight path" }, cons = { "Busy at launch" }, steps = {
	{ goals = {
		{ t = "goto", map = 1413, x = 52, y = 30 },
		{ t = "turnin", quest = 50, title = "Tauren Leftover", map = 1413, x = 52, y = 30 },
	} },
	{ goals = { { t = "accept", quest = 60, title = "Kolkar Leaders", map = 1413, x = 52, y = 31 } } },
	{ goals = { { t = "level", level = 20 } } },
} })
Polestar.RegisterGuide({ id = "test/silverpine", pack = "test", title = "Silverpine Forest", faction = "Horde", minLevel = 10, maxLevel = 18, zone = 1421,
	zoneName = "Silverpine Forest", next = "test/stonetalon", pitch = "A quiet zone next to Undercity.", steps = {
	{ goals = { { t = "goto", map = 1421, x = 43, y = 41 } } },
	{ goals = { { t = "level", level = 18 } } },
} })
Polestar.RegisterGuide({ id = "test/mulgore-only", pack = "test", title = "Tauren side road", faction = "Horde", races = { "Tauren" }, minLevel = 10, maxLevel = 20, steps = {
	{ goals = { { t = "level", level = 20 } } },
} })
Polestar.RegisterGuide({ id = "test/stonetalon", pack = "test", title = "Stonetalon Mountains", faction = "Horde", minLevel = 18, maxLevel = 22, steps = {
	{ goals = { { t = "level", level = 22 } } },
} })
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
function flush() stub.advance(0.25) end
LOG = {}
for _, m in ipairs({ "ROUTE_CHOICE", "ROUTE_CHOSEN", "GUIDE_CHANGED" }) do
	Polestar.On(m, function(a, b) LOG[#LOG + 1] = m .. " " .. tostring(a) .. (b and (" " .. tostring(b)) or "") end)
end
function takeLog() local l = LOG; LOG = {}; return l end
function finishStarter(q)
	w.accept(q, {}); flush()
	w.finish(q); w.turnIn(q); flush()
end
function optionIds(c)
	local out = {}
	for i, o in ipairs(c.options) do out[i] = o.id .. (o.recommended and "*" or "") end
	return out
end
"#;

fn run(before: &str, saved: Option<&str>, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: [TEST_PACK, TEST_SOURCE, GUIDES, HELPERS, "stub.login()", script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

/// A log's lines (an empty Lua table may come out as an object: no lines).
fn lines(v: &Value) -> Vec<String> {
	v.as_array().map(|a| a.iter().map(|l| l.as_str().unwrap_or("").to_string()).collect()).unwrap_or_default()
}

#[test]
fn finishing_a_guide_with_a_route_choice_asks_keeps_the_finished_guide_and_loads_the_chosen_route() {
	let out = run(
		"w.moveTo(1411, 52, 43)",
		None,
		r#"
			E.SetGuide("test/durotar"); flush(); takeLog()
			finishStarter(1)
			local r = { asked = takeLog(), guide = E.GetGuide().id, pending = E.PendingRouteChoice() }
			local c = E.GetRouteChoice("test/durotar")
			r.options, r.joinsAt, r.recommended = optionIds(c), c.joinsAt, c.recommended
			r.barrens = { c.options[1].pitch, c.options[1].pros[2], c.options[1].cons[1], c.options[1].quests, c.options[1].minLevel, c.options[1].maxLevel }
			r.nearer = c.options[1].seconds < c.options[2].seconds
			r.chose = E.ChooseRoute("test/durotar", "test/silverpine"); flush()
			r.after = { guide = E.GetGuide().id, log = takeLog(), saved = PolestarCharDB.routes["test/durotar"], pending = E.PendingRouteChoice() }
			r.bad = E.ChooseRoute("test/durotar", "test/stonetalon")
			emit(r)"#,
	);
	// Asked once, after GUIDE_COMPLETED; the finished guide stays loaded.
	assert_eq!(out["asked"], json!(["ROUTE_CHOICE test/durotar"]));
	assert_eq!(out["guide"], "test/durotar");
	assert_eq!(out["pending"], "test/durotar");
	// The Tauren-only option does not fit an Orc; the Barrens is nearest from Durotar.
	assert_eq!(out["options"], json!(["test/barrens*", "test/silverpine"]));
	assert_eq!(out["recommended"], "test/barrens");
	assert_eq!(out["nearer"], true);
	assert_eq!(out["joinsAt"], "Stonetalon Mountains");
	// The Barrens' pitch, pros and cons; one accept is all an Orc gets there.
	assert_eq!(out["barrens"], json!(["Dense quests around a central hub.", "Crossroads flight path", "Busy at launch", 1, 10, 20]));
	assert_eq!(out["chose"], true);
	assert_eq!(out["after"], json!({ "guide": "test/silverpine", "log": ["GUIDE_CHANGED test/silverpine", "ROUTE_CHOSEN test/durotar test/silverpine"], "saved": "test/silverpine" }));
	// Only offered guides can be chosen.
	assert_eq!(out["bad"], false);
}

#[test]
fn a_remembered_choice_or_behavior_routechoice_recommended_continues_without_asking() {
	let remembered = run(
		"w.moveTo(1411, 52, 43)",
		Some(r#"PolestarCharDB = { schema = 1, routes = { ["test/durotar"] = "test/silverpine" } }"#),
		r#"
			E.SetGuide("test/durotar"); flush(); takeLog()
			finishStarter(1)
			emit({ guide = E.GetGuide().id, log = takeLog() })"#,
	);
	assert_eq!(remembered, json!({ "guide": "test/silverpine", "log": ["GUIDE_CHANGED test/silverpine"] }));

	// An Undead in Tirisfal: Silverpine is next door, the Barrens a boat away.
	let recommended = run(
		r#"w.race, w.raceName = "Scourge", "Undead"; w.moveTo(1420, 61, 52)"#,
		None,
		r#"
			Polestar.Set("behavior.routeChoice", "recommended")
			E.SetGuide("test/tirisfal"); flush(); takeLog()
			finishStarter(2)
			emit({ guide = E.GetGuide().id, log = takeLog() })"#,
	);
	assert_eq!(recommended, json!({ "guide": "test/silverpine", "log": ["GUIDE_CHANGED test/silverpine"] }));
}

#[test]
fn turn_ins_and_objectives_of_quests_the_character_never_had_no_longer_block() {
	let out = run(
		"w.level = 10; w.moveTo(1413, 52, 30)",
		None,
		r#"
			E.SetGuide("test/barrens"); stub.advance(1)
			local r = { first = E.GetStepView(1).goals[2].status, step = E.GetStepIndex() }
			-- With the quest in the log the turn-in applies again.
			w.accept(50, {}); flush()
			r.withQuest = E.GetStepView(1).goals[2].status
			emit(r)"#,
	);
	// The goto is reached on arrival; the leftover turn-in is not applicable, so the guide moves on to step 2.
	assert_eq!(out["first"], "na");
	assert_eq!(out["step"], 2);
	assert_ne!(out["withQuest"], "na");
}

#[test]
fn a_fresh_start_at_the_bottom_of_a_bracket_offers_the_choice_later_levels_and_polestar_path() {
	let fresh = run("w.level = 11; w.moveTo(1411, 52, 43)", None, "emit({ guide = E.GetGuide().id, log = takeLog() })");
	// Suggest loads the nearest route; the choice that offered it is asked.
	assert_eq!(fresh["guide"], "test/barrens");
	let fresh_log = lines(&fresh["log"]);
	assert!(fresh_log.iter().any(|l| l == "ROUTE_CHOICE test/durotar"), "{}", fresh_log.join(" | "));

	let later = run(
		"w.level = 15; w.moveTo(1413, 52, 30)",
		None,
		r#"
			local r = { guide = E.GetGuide().id, log = takeLog() }
			r.offer = E.OfferRouteChoice()
			r.log2 = takeLog()
			emit(r)"#,
	);
	assert_eq!(later["guide"], "test/barrens");
	let later_log = lines(&later["log"]);
	assert!(!later_log.iter().any(|l| l.starts_with("ROUTE_CHOICE")), "{}", later_log.join(" | "));
	// The command offers the choice that led here, to change route.
	assert_eq!(later["offer"], "test/durotar");
	assert_eq!(later["log2"], json!(["ROUTE_CHOICE test/durotar"]));
}
