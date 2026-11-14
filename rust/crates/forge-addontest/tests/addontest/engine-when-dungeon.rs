//! `when dungeon` during play (addon/Polestar/Core/Engine.lua): the step applies while the character has chosen
//! to run the dungeon (CharState().dungeons[map], Engine.ChooseDungeon; Options, Discovery, Dungeons),
//! `!dungeon` while they have not. None is chosen by default. A choice re-evaluates the guide at once; a step
//! the route has passed keeps its stored outcome. Real Core manifest, stub world (a level 1 Human Warrior in
//! Elwynn Forest), as tests/engine-when.test.js.

use forge_addontest::{emitted, lua_value, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
w.onQuest(783, {})
"#;

// Step 2 is the conditional one, between taking and handing in A Threat Within: @WHEN@ is Lua for its
// predicates.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/dungeon", pack = "test", title = "Dungeon", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Trainer", when = @WHEN@, goals = {
			{ t = "train", npc = 911, npcName = "Llane Beshere" },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
"#;

// Dungeons in the route are held back while Core/Init.lua's switch is off (engine-dungeon-route.rs): turned on here.
const HELPERS: &str = r#"
Polestar.dungeonRoute = true
E = Polestar.Engine
function flush() stub.advance(0.25) end
function state() local v = E.GetStepView(2); return { live = E.GetLiveStep(), status = v.status } end
"#;

const BFD: &str = r#"{ { k = "dungeon", name = "Blackfathom Deeps", map = 48 } }"#;
const NOT_BFD: &str = r#"{ { k = "dungeon", name = "Blackfathom Deeps", map = 48, neg = true } }"#;
const DEFAULT_SAVED: &str = r#"PolestarCharDB = { schema = 1, guide = "test/dungeon" }"#;

fn run(when: &str, saved: &str, login: &str, script: &str) -> Vec<Value> {
	let guide = GUIDE.replace("@WHEN@", when);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), saved.into())],
		script: [TEST_PACK, TEST_SOURCE, &guide, HELPERS, "stub.login()", login, r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

fn chosen_saved() -> String {
	format!("PolestarCharDB = {}", lua_value(&json!({ "schema": 1, "guide": "test/dungeon", "dungeons": { "48": true } })))
}

#[test]
fn by_default_no_dungeon_is_chosen_a_when_dungeon_step_is_passed_a_when_dungeon_step_applies() {
	let out = run(BFD, DEFAULT_SAVED, "", "emit(state()); emit({ dungeons = PolestarCharDB.dungeons, chosen = E.DungeonChosen(48) })");
	assert_eq!(out[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(out[1], json!({ "dungeons": {}, "chosen": false }));
	let not = run(NOT_BFD, DEFAULT_SAVED, "", "emit(state())");
	assert_eq!(not[0], json!({ "live": 2, "status": "current" }));
}

#[test]
fn choosing_the_dungeon_before_the_route_reaches_the_step_makes_it_apply_and_the_choice_is_saved_per_character() {
	let out = run(BFD, &chosen_saved(), "", r#"emit(state()); stub.fire("PLAYER_LOGOUT"); emit(PolestarCharDB.dungeons)"#);
	assert_eq!(out[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(out[1], json!({ "48": true }));
	let not = run(NOT_BFD, &chosen_saved(), "", "emit(state())");
	assert_eq!(not[0], json!({ "live": 3, "status": "skipped" }));
}

#[test]
fn a_choice_re_evaluates_the_guide_at_once_choosedungeon_map_false_takes_it_back() {
	// Before the quest log is read nothing is stored, so step 2 is decided live: it applies while chosen, and
	// does not (na) once taken back.
	let out = run(BFD, DEFAULT_SAVED, "E.ChooseDungeon(48, true); stub.advance(0.25); emit(state()); E.ChooseDungeon(48, false); stub.advance(0.25); emit(state())", "");
	assert_eq!(out[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(out[1], json!({ "live": 3, "status": "na" }));
}

#[test]
fn a_step_the_route_has_passed_keeps_its_stored_outcome_when_the_choice_changes_later() {
	let out = run(
		BFD,
		DEFAULT_SAVED,
		"",
		r#"
			emit(state())
			E.ChooseDungeon(48, true); flush()
			emit(state())
			stub.fire("PLAYER_LOGOUT")
			emit({ skipped = PolestarCharDB.skipped, dungeons = PolestarCharDB.dungeons })
		"#,
	);
	assert_eq!(out[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(out[1], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(out[2], json!({ "skipped": { "test/dungeon": { "2": true } }, "dungeons": { "48": true } }));
}

#[test]
fn a_dungeon_the_compiler_found_no_map_id_for_is_never_chosen_dungeon_never_holds_dungeon_always_does() {
	let saved = format!("{}\n\t\t\tWHEN = {{ {{ k = \"level\", op = \">=\", n = 1 }} }}", chosen_saved());
	let out = run(
		"WHEN",
		&saved,
		"",
		r#"
			local G = Polestar.Guides.Get("test/dungeon")
			local out = {}
			local function check(label, pred) PolestarCharDB.when["test/dungeon"] = nil; PolestarCharDB.skipped["test/dungeon"] = nil; G.steps[2].when = { pred }; flush(); out[#out + 1] = label .. "=" .. E.GetStepView(2).status end
			check("chosen", { k = "dungeon", name = "Blackfathom Deeps", map = 48 })
			check("other", { k = "dungeon", name = "The Deadmines", map = 36 })
			check("!other", { k = "dungeon", name = "The Deadmines", map = 36, neg = true })
			check("no map", { k = "dungeon", name = "Blackfathom Deepss" })
			check("!no map", { k = "dungeon", name = "Blackfathom Deepss", neg = true })
			emit(out)
		"#,
	);
	assert_eq!(out[0], json!(["chosen=current", "other=na", "!other=current", "no map=na", "!no map=current"]));
}

// Options lists only the dungeons the character's guides have steps for (Engine.GuideDungeons, 0.3.6 plan:
// "Options page lists only dungeons with steps"): Blackfathom Deeps from a guide whose steps are read, The
// Deadmines from a compiled guide whose steps are still source (not read for this), never a `!dungeon`
// step's Wailing Caverns nor a Horde guide's Gnomeregan for this Human.
#[test]
fn guide_dungeons_are_the_maps_of_this_characters_guides_when_dungeon_steps_read_from_compiled_source_too() {
	let guides = r#"
Polestar.RegisterGuide({ id = "test/read", pack = "test", title = "Read", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ title = "Run", when = { { k = "dungeon", name = "Blackfathom Deeps", map = 48 } }, goals = { { t = "note", text = "in" } } },
	{ title = "Solo", when = { { k = "dungeon", neg = true, name = "Wailing Caverns", map = 43 } }, goals = { { t = "note", text = "out" } } },
} })
Polestar.RegisterGuide({ id = "test/deferred", pack = "test", title = "Deferred", faction = "Alliance", minLevel = 1, maxLevel = 20, stepCount = 2,
	stepsSrc = 'return {\n{ title = "Run", when = { { k = "dungeon", name = "The Deadmines", map = 36 } }, goals = { { t = "note", text = "in" } } },\n{ title = "Solo", when = { { k = "dungeon", neg = true, name = "Wailing Caverns", map = 43 } }, goals = { { t = "note", text = "out" } } },\n}' })
Polestar.RegisterGuide({ id = "test/horde", pack = "test", title = "Horde", faction = "Horde", minLevel = 1, maxLevel = 20, steps = {
	{ title = "Run", when = { { k = "dungeon", name = "Gnomeregan", map = 90 } }, goals = { { t = "note", text = "in" } } },
} })
"#;
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: [
			TEST_PACK,
			guides,
			"Polestar.dungeonRoute = true",
			"stub.login()",
			r#"
local maps = {}
for m in pairs(Polestar.Engine.GuideDungeons()) do maps[#maps + 1] = m end
table.sort(maps)
emit({ maps = maps, read = rawget(Polestar.Guides.Get("test/deferred"), "steps") ~= nil })"#,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["maps"], json!([36, 48]));
	assert_eq!(out["read"], false, "the compiled guide's steps are not read for the list");
}

// Held back (Core/Init.lua's switch off, as it ships): no dungeon is listed, so nothing offers one, and a step
// for a dungeon saved as chosen is passed as for a character who chose none.
#[test]
fn held_back_no_dungeon_is_listed_and_a_chosen_one_is_passed() {
	let guides = r#"
Polestar.RegisterGuide({ id = "test/read", pack = "test", title = "Read", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ title = "Run", when = { { k = "dungeon", name = "Blackfathom Deeps", map = 48 } }, goals = { { t = "note", text = "in" } } },
} })
"#;
	let listed = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: [TEST_PACK, guides, "stub.login()", "emit({ listed = next(Polestar.Engine.GuideDungeons()) or false })"].join("\n"),
		..Default::default()
	})
	.remove(0);
	assert_eq!(listed, json!({ "listed": false }));
	let guide = GUIDE.replace("@WHEN@", BFD);
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), chosen_saved())],
		script: [TEST_PACK, TEST_SOURCE, &guide, "E = Polestar.Engine", "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			"local v = E.GetStepView(2); emit({ live = E.GetLiveStep(), status = v.status })"].join("\n"),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "live": 3, "status": "skipped" }));
}
