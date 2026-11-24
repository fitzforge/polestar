//! A repeatable quest taken from the log (addon/Polestar/Core/Engine.lua, #3334): the client never flags it
//! completed, so its hand-in is stored per turn-in goal (compiled `repeatable`) and the step stays done after a
//! reload, with the accept and work of the same round before it; a later round of the same quest keeps its own
//! hand-in. Zorbin Fandazzle's Again With the Zapped Giants (7725) in Horde 40-50/06 Azshara, the Ultra-Shrinker
//! that makes Muisek's elite giants soloable. Real Core manifest, stub world; the compile check reads the shipped
//! guide with data/forever (skipped with a note without it).

use forge_addontest::dsl::compile_with;
use forge_addontest::run::root;
use forge_addontest::{emitted, lua_value, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1444, { name = "Feralas", c = 1, left = 5000, right = -1000, top = 4000, bottom = -2000 })
w.moveTo(1444, 44, 46)
w.level = 52
w.titles[7725] = "Again With the Zapped Giants"
w.repeatable[7725] = true
"#;

const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/zorbin", pack = "test", title = "Zorbin", minLevel = 45, maxLevel = 60, steps = {
	{ title = "Zorbin Fandazzle", goals = {
		{ t = "accept", quest = 7725, title = "Again With the Zapped Giants", npc = 14637, npcName = "Zorbin Fandazzle", map = 1444, x = 44.8, y = 43.4 },
	} },
	{ title = "Giants", goals = {
		{ t = "collect", item = 18956, itemName = "Miniaturization Residue", count = 10, quest = 7725, oi = 1, map = 1444, x = 44.3, y = 46.6 },
	} },
	{ title = "Zorbin Fandazzle", goals = {
		{ t = "turnin", quest = 7725, title = "Again With the Zapped Giants", npc = 14637, npcName = "Zorbin Fandazzle", map = 1444, x = 44.8, y = 43.4, repeatable = true },
	} },
	{ title = "Camp Mojache", goals = { { t = "goto", map = 1444, x = 75, y = 44, text = "Camp Mojache" } } },
	{ title = "Zorbin again", goals = {
		{ t = "accept", quest = 7725, title = "Again With the Zapped Giants", npc = 14637, npcName = "Zorbin Fandazzle", map = 1444, x = 44.8, y = 43.4 },
		{ t = "turnin", quest = 7725, title = "Again With the Zapped Giants", npc = 14637, npcName = "Zorbin Fandazzle", map = 1444, x = 44.8, y = 43.4, repeatable = true },
	} },
} })
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
function state()
	local out = { live = E.GetLiveStep() }
	for s = 1, 5 do out[s] = E.GetStepView(s).status end
	return out
end
"#;

fn run(before: &str, saved: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), saved.to_string())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

const FRESH: &str = r#"PolestarCharDB = { schema = 1, guide = "test/zorbin" }"#;

/// Hands 7725 in after `setup`, logs out, and returns (the session's state, the state after a reload).
fn hand_in_and_reload(setup: &str) -> (Value, Value) {
	let first = run(
		"",
		FRESH,
		&format!(
			r#"
			local w = stub.world
			w.accept(7725, {{ 10 }}); flush()
			{setup}
			local before = E.GetLiveStep()
			w.turnIn(7725); flush()
			local r = state()
			r.before = before
			stub.fire("PLAYER_LOGOUT")
			emit({{ r = r, db = PolestarCharDB }})
		"#
		),
	);
	let reload = run("", &format!("PolestarCharDB = {}", lua_value(&first["db"])), "emit(state())");
	(first["r"].clone(), reload)
}

#[test]
fn zorbins_hand_in_at_its_step_stays_done_after_a_reload_and_the_route_does_not_go_back_to_his_accept() {
	let (session, reload) = hand_in_and_reload("w.finish(7725); flush()");
	assert_eq!(session["before"], 3, "handed in at the turn-in step: {session}");
	assert_eq!(session["live"], 4, "{session}");
	assert_eq!(reload["live"], 4, "the reload keeps the route past Zorbin: {reload}");
	for s in ["1", "2", "3"] {
		assert_eq!(reload[s], "done", "step {s}: {reload}");
	}
	assert_ne!(reload["5"], "done", "the second round keeps its own accept and hand-in: {reload}");
}

#[test]
fn zorbins_quest_handed_in_ahead_of_its_step_stores_that_rounds_hand_in() {
	// The residue not counted yet in the log (live step 2) when the player hands it in.
	let (session, reload) = hand_in_and_reload("");
	assert_eq!(session["before"], 2, "{session}");
	assert_eq!(session["live"], 4, "{session}");
	assert_eq!(reload["live"], 4, "{reload}");
	assert_ne!(reload["5"], "done", "{reload}");
}

#[test]
fn the_second_round_s_hand_in_closes_only_the_second_round() {
	let out = run(
		"",
		FRESH,
		r#"
			local w = stub.world
			w.accept(7725, { 10 }); w.finish(7725); flush()
			w.turnIn(7725); flush()
			local first = state()
			E.SkipUpTo(5); flush()
			w.accept(7725, { 10 }); w.finish(7725); flush()
			local taken = E.GetStepView(5).status
			w.turnIn(7725); flush()
			emit({ first = first, taken = taken, keys = PolestarCharDB.manual["test/zorbin"] })
		"#,
	);
	assert_eq!(out["first"]["5"], "upcoming", "{out}");
	assert_ne!(out["taken"], "done", "{out}");
	assert_eq!(out["keys"], json!({ "3:1": true, "5:2": true }), "one stored hand-in per round: {out}");
}

#[test]
fn the_shipped_azshara_guide_compiles_zorbins_hand_ins_as_repeatable() {
	let data_dir = root().join("data/forever");
	if !data_dir.exists() {
		eprintln!("skipped: no reference data at data/forever");
		return;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let names = ["forever/horde/40-50/05-the-hinterlands.guide", "forever/horde/40-50/06-azshara.guide"];
	let files: Vec<(String, String)> = names.iter().map(|g| (format!("guides/{g}"), std::fs::read_to_string(root().join("guides").join(g)).unwrap())).collect();
	let refs: Vec<(&str, &str)> = files.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let compiled = compile_with(&refs, &data, None);
	let guide = compiled.guides.iter().find(|g| g.get("id").as_str() == Some("forever/horde/40-50/06-azshara")).expect("06-azshara compiled");
	let mut seen = Vec::new();
	for step in guide.get("steps").items() {
		for goal in step.get("goals").items() {
			if goal.get("t").as_str() == Some("turnin") && matches!(goal.get("quest").num() as u32, 7725 | 7726 | 7738) {
				seen.push((goal.get("quest").num() as u32, goal.get("repeatable").truthy(), goal.get("direct").truthy()));
			}
		}
	}
	seen.sort_unstable();
	assert_eq!(seen, vec![(7725, true, false), (7726, true, false), (7738, true, false)]);
}
