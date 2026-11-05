//! `when cooldown` during play (addon/Polestar/Core/Engine.lua, Own.onCooldown): the step applies while the item
//! (Compat.GetItemCooldown) or spell (Compat.GetSpellCooldown) is on cooldown, the global cooldown (1.5 s or
//! less) aside. A cooldown starting re-evaluates the guide (BAG_UPDATE_COOLDOWN, SPELL_UPDATE_COOLDOWN), and so
//! does its end, which has no event (a timer). A step the route has passed keeps its stored outcome. Real Core
//! manifest, stub world (a level 1 Human Warrior in Elwynn Forest), as tests/engine-when-dungeon.rs; the
//! cooldowns are faked here on the stub clock.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

// CD[6948] = { start, duration } for an item, CD["s" .. id] for a spell.
const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
w.onQuest(783, {})
CD = {}
C_Container = C_Container or {}
function C_Container.GetItemCooldown(id) local c = CD[id]; if not c then return 0, 0, 1 end; return c[1], c[2], 1 end
C_Spell = C_Spell or {}
function C_Spell.GetSpellCooldown(id) local c = CD["s" .. id]; return { startTime = c and c[1] or 0, duration = c and c[2] or 0, isEnabled = true, modRate = 1 } end
"#;

// Step 2 is the conditional one, between taking and handing in A Threat Within: WHEN is Lua for its
// predicates.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/cd", pack = "test", title = "Cooldown", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Walk", when = WHEN, goals = {
			{ t = "train", npc = 911, npcName = "Llane Beshere" },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
function state() local v = E.GetStepView(2); return { live = E.GetLiveStep(), status = v.status } end
"#;

const HEARTH: &str = r#"{ { k = "cooldown", item = 6948 } }"#;
const HEARTH_READY: &str = r#"{ { k = "cooldown", item = 6948, neg = true } }"#;

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

fn run(when: &str, login: &str, script: &str) -> Vec<Value> {
	let guide = GUIDE.replace("WHEN", when);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![core()],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/cd" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, &guide, HELPERS, "stub.login()", login, r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

#[test]
fn when_cooldown_item_applies_while_the_item_cools_down_cooldown_while_it_is_ready_the_global_cooldown_does_not_count() {
	assert_eq!(run(HEARTH, "", "emit(state())")[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(run(HEARTH, "CD[6948] = { GetTime(), 1800 }", "emit(state())")[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(run(HEARTH, "CD[6948] = { GetTime(), 1.5 }", "emit(state())")[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(run(HEARTH_READY, "CD[6948] = { GetTime(), 1800 }", "emit(state())")[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(run(HEARTH_READY, "", "emit(state())")[0], json!({ "live": 2, "status": "current" }));
}

#[test]
fn when_cooldown_spell_reads_the_spell_s_cooldown() {
	assert_eq!(run(r#"{ { k = "cooldown", spell = 8690 } }"#, "CD.s8690 = { GetTime(), 600 }", "emit(state())")[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(run(r#"{ { k = "cooldown", spell = 8690 } }"#, "CD.s1234 = { GetTime(), 600 }", "emit(state())")[0], json!({ "live": 3, "status": "skipped" }));
}

#[test]
fn a_cooldown_starting_re_evaluates_the_guide_and_so_does_its_end_before_the_route_has_passed_the_step() {
	// Before the quest log is read nothing is stored, so step 2 is decided live.
	let out = run(
		HEARTH,
		r#"
			flush(); emit(state())
			CD[6948] = { GetTime(), 30 }; stub.fire("BAG_UPDATE_COOLDOWN"); flush(); emit(state())
			stub.advance(31); emit(state())
		"#,
		"",
	);
	assert_eq!(out[0], json!({ "live": 3, "status": "na" }));
	assert_eq!(out[1], json!({ "live": 2, "status": "current" }));
	assert_eq!(out[2], json!({ "live": 3, "status": "na" }));
}

#[test]
fn a_step_the_route_has_passed_keeps_its_stored_outcome_when_the_cooldown_starts_later() {
	let out = run(HEARTH, "", r#"emit(state()); CD[6948] = { GetTime(), 1800 }; stub.fire("BAG_UPDATE_COOLDOWN"); flush(); emit(state())"#);
	assert_eq!(out[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(out[1], json!({ "live": 3, "status": "skipped" }));
}

#[test]
fn guides_validate_takes_a_cooldown_predicate_with_one_item_or_one_spell_and_refuses_others() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![core()],
		script: r#"
			local V = Polestar.Guides.Validate
			local function g(pred) return { id = "t/v", pack = "test", title = "V", minLevel = 1, maxLevel = 10, steps = { { when = { pred }, goals = { { t = "note", text = "x" } } } } } end
			emit({
				item = V(g({ k = "cooldown", item = 6948 })) or "ok",
				spell = V(g({ k = "cooldown", spell = 8690, neg = true })) or "ok",
				both = V(g({ k = "cooldown", item = 6948, spell = 8690 })) or "ok",
				none = V(g({ k = "cooldown" })) or "ok",
			})
		"#
		.into(),
		..Default::default()
	});
	let rows = &out[0];
	assert_eq!(rows["item"], "ok");
	assert_eq!(rows["spell"], "ok");
	assert!(is_match(text(&rows["both"]), "bad when"));
	assert!(is_match(text(&rows["none"]), "bad when"));
}
