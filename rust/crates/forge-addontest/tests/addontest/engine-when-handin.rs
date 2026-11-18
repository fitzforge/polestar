//! A step that hands in the quest its `when` names keeps what it does after the hand-in (#2888; Engine.lua,
//! Own.predicateFails, Own.handedInHere). Mîku (Scourge Paladin 32, 0.4.1) was never given the last The Swarm Grows
//! (1147): Thousand Needles' Moktar Krin step is `when onquest 1146`, hands in its second part (1146) and takes 1147
//! from him, and the moment 1146 was handed in its `when` failed, the step stopped applying and the route moved on
//! past the accept. Without 1147 the dig site's kills were never the guide's. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1441, { name = "Thousand Needles", c = 1, left = -433.333, right = -4833.333, top = -3966.667, bottom = -6899.999 })
w.race, w.raceName, w.faction, w.class, w.className, w.level = "Scourge", "Undead", "Horde", "PALADIN", "Paladin", 32
w.moveTo(1441, 67.6, 63.9)
"#;

// guides/forever/horde/30-40/02-thousand-needles.guide's Moktar Krin step, the dig site after it and the raceway.
const GUIDE: &str = r#"
assert(Polestar.RegisterGuide({ id = "test/swarm", pack = "test", title = "Thousand Needles", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Moktar Krin", when = { { k = "onquest", q = { 1146 } } }, goals = {
		{ t = "turnin", quest = 1146, title = "The Swarm Grows", npc = 4483, map = 1441, x = 67.6, y = 63.9 },
		{ t = "accept", quest = 1147, title = "The Swarm Grows", npc = 4483, map = 1441, x = 67.6, y = 63.9 },
	} },
	{ title = "The Rustmaul Dig Site", goals = {
		{ t = "kill", quest = 1147, oi = 1, npc = 4130, target = "Silithid Searcher", map = 1441, x = 69.8, y = 83.3 },
	} },
	{ title = "Mirage Raceway", goals = { { t = "accept", quest = 1110, title = "Rocket Car Parts", npc = 4452, map = 1441, x = 77.8, y = 77.3 } } },
} }))
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!(
			"{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE}\nE = Polestar.Engine\nw = stub.world\nfunction flush() stub.advance(0.25) end\nstub.login()\n\
			function snap()\n\
				local v = E.GetStepView(1)\n\
				local st = {{}}\n\
				for i, g in ipairs(v and v.goals or {{}}) do st[i] = g.status end\n\
				return {{ E.GetStepIndex() or false, st }}\n\
			end\n{script}"
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn t_2888_handing_in_the_quest_a_step_s_when_names_keeps_the_step_for_the_follow_up_s_accept() {
	let out = run(r#"
		w.onQuest(1146, { { required = 1, fulfilled = 1 } }, "The Swarm Grows"); stub.fire("QUEST_LOG_UPDATE")
		E.SetGuide("test/swarm"); flush()
		local out = { snap() }
		w.turnIn(1146); flush()
		out[2] = snap()
		w.accept(1147, { { required = 5, fulfilled = 0 } }, "The Swarm Grows"); flush()
		out[3] = snap()
		emit(out)"#);
	assert_eq!(
		out,
		json!([
			[1, ["active", "active"]],
			// Handed in: the step stays, its accept of 1147 next (before: the route moved on to the raceway, 3).
			[1, ["done", "active"]],
			// Taken: on to the dig site.
			[2, ["done", "done"]],
		])
	);
}

#[test]
fn t_2888_a_quest_handed_in_before_the_route_reached_its_step_still_leaves_the_follow_up_there() {
	// 1146 handed in earlier (at Moktar Krin in passing): the step offers 1147.
	let out = run(r#"
		w.complete({ 1146 }); stub.fire("QUEST_LOG_UPDATE")
		E.SetGuide("test/swarm"); flush()
		emit(snap())"#);
	assert_eq!(out, json!([1, ["done", "active"]]));
}

#[test]
fn t_2888_a_step_for_a_quest_never_taken_still_does_not_apply() {
	let out = run(r#"
		stub.fire("QUEST_LOG_UPDATE")
		E.SetGuide("test/swarm"); flush()
		emit(snap())"#);
	assert_eq!(out[0], json!(3), "{out}");
}
