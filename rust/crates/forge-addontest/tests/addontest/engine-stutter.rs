//! Hitches on kills (0.4.1.1): work a fight or a kill repeats for nothing, counted. Each test counts the calls
//! or moments one piece of the kill path costs; the answers the player sees stay the same.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

fn run(addons: Vec<Addon>, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.race, w.faction, w.class, w.className, w.level = "Human", "Alliance", "WARRIOR", "Warrior", 10
w.moveTo(1429, 40, 40)
"#
		.into(),
		addons,
		script: script.into(),
		..Default::default()
	})
	.remove(0)
}

// A fight sends UNIT_AURA and UNIT_SPELLCAST_SUCCEEDED for every nameplate, dozens a second. Every handler of
// either wants the player's alone; each one heard was a new moment (Polestar.Moment), which starts the per-moment
// memos over (quest objectives, the keyring, the shared step view). Now they are heard for the player only.
#[test]
fn a_unit_event_asked_for_the_player_alone_is_heard_only_for_the_player() {
	let out = run(
		vec![Addon::files("Polestar", &["Core/Init.lua"])],
		r#"
		local calls = 0
		Polestar.RegisterEvent("UNIT_AURA", function(_, unit) calls = calls + 1 end, "player")
		local m = Polestar.Moment()
		for i = 1, 30 do stub.fire("UNIT_AURA", "nameplate" .. i) end
		stub.fire("UNIT_AURA", "target")
		local fight = Polestar.Moment() - m
		stub.fire("UNIT_AURA", "player")
		emit({ calls = calls, fight = fight, player = Polestar.Moment() - m - fight })"#,
	);
	assert_eq!(out, json!({ "calls": 1, "fight": 0, "player": 1 }));
}

#[test]
fn a_fights_nameplate_auras_and_casts_start_no_new_moment_and_the_players_still_count() {
	let out = run(
		vec![Addon::name("Polestar")],
		r#"
		stub.login(); stub.advance(0.25)
		local m = Polestar.Moment()
		for i = 1, 40 do stub.fire("UNIT_AURA", "nameplate" .. (i % 8 + 1)) end
		for i = 1, 10 do stub.fire("UNIT_SPELLCAST_SUCCEEDED", "nameplate" .. i, "Cast-3-0-0-0-133-0", 133) end
		local fight = Polestar.Moment() - m
		local rest = 0
		Polestar.On("QOL_REST_UPDATED", function() rest = rest + 1 end)
		m = Polestar.Moment()
		stub.world.setAura(1126, true)
		stub.world.cast(818)
		emit({ fight = fight, player = Polestar.Moment() - m >= 2, watching = Polestar.QoL.Watching("UNIT_AURA") })"#,
	);
	assert_eq!(out, json!({ "fight": 0, "player": true, "watching": true }));
}

// Compat.GetQuestObjectives cleaned each line's placeholder names (ObjectiveLabel, then Placeholder: some 15
// string operations) on every read, and reads start over each moment. A line's text changes only with its count:
// now each text is cleaned once.
#[test]
fn quest_objective_lines_are_cleaned_once_per_text_not_once_per_read() {
	let out = run(
		vec![Addon::files("Polestar", &["Core/Core.xml"])],
		r#"
		local C, w = Polestar.Compat, stub.world
		w.accept(7, { { text = "Kobold Vermin slain: 0/10", required = 10 }, { text = "Kill Credit: 0/1" } })
		local labels, label = 0, C.ObjectiveLabel
		C.ObjectiveLabel = function(t) labels = labels + 1 return label(t) end
		local texts
		for _ = 1, 20 do
			Polestar.NewMoment()
			local o = C.GetQuestObjectives(7)
			texts = { o[1].text, o[2].text }
		end
		local reads = labels
		w.log[7].objectives[1].text = "Kobold Vermin slain: 1/10"
		w.progress(7, 1, 1)
		for _ = 1, 20 do
			Polestar.NewMoment()
			C.GetQuestObjectives(7)
		end
		emit({ texts = texts, reads = reads, after = labels - reads, now = C.GetQuestObjectives(7)[1].text })"#,
	);
	assert_eq!(out, json!({ "texts": ["Kobold Vermin slain: 0/10", ""], "reads": 2, "after": 1, "now": "Kobold Vermin slain: 1/10" }));
}

// findWaypoint walked the whole guide's behind list (Engine.GetBehind) before every hand-in that is not ready, for
// a character with any quest an update left behind; the list can only name the hand-in's quest when that quest is
// one of them. Now the walk runs for that quest alone. The arrow's place is the same either way.
#[test]
fn an_unready_hand_in_walks_the_behind_list_only_for_a_quest_left_behind() {
	let out = run(
		vec![Addon::files("Polestar", &["Core/Core.xml"])],
		&format!(
			r#"
		{TEST_PACK}
		{TEST_SOURCE}
		local w = stub.world
		Polestar.RegisterGuide({{ id = "test/behind", pack = "test", title = "Behind", faction = "Alliance", minLevel = 1, maxLevel = 12, zone = 1429, steps = {{
			{{ title = "Take", goals = {{ {{ t = "accept", quest = 100, map = 1429, x = 41, y = 41, npc = 197 }}, {{ t = "accept", quest = 200, map = 1429, x = 41, y = 41, npc = 197 }} }} }},
			{{ title = "Back", goals = {{ {{ t = "turnin", quest = 100, map = 1429, x = 45, y = 45, npc = 198 }} }} }},
			{{ title = "Wolves", goals = {{ {{ t = "kill", quest = 200, obj = 1, map = 1429, x = 60, y = 60, text = "Wolves" }} }} }},
		}} }})
		E = Polestar.Engine
		stub.login(); stub.advance(0.25)
		w.accept(100, {{ 9 }}); w.accept(200, {{ 9 }})
		E.SetGuide("test/behind"); stub.advance(0.25)
		Polestar.CharState().behind = {{ ["test/behind"] = {{ [200] = true }} }}
		local walks, get = 0, E.GetBehind
		E.GetBehind = function() walks = walks + 1 return get() end
		for i = 1, 5 do w.progress(100, 1, i); stub.advance(0.25) end
		local plain, wp1 = walks, E.GetWaypoint()
		Polestar.CharState().behind["test/behind"][100] = true
		walks = 0
		for i = 1, 5 do w.progress(200, 1, i); stub.advance(0.25) end
		local wp2 = E.GetWaypoint()
		emit({{ step = E.GetStepIndex(), plain = plain, behind = walks, x1 = wp1 and wp1.x, x2 = wp2 and wp2.x }})"#
		),
	);
	println!("BEHIND {out}");
	assert_eq!(out, json!({ "plain": 5, "behind": true, "x1": 41, "x2": 60 }));
}

// Engine.GrindHint (the guide window on a grind step, again 5 s after its last look, so on nearly every kill):
// every accept left in the guide was judged (greyNeed, unavailableFor, missingPre) and placed on the world map
// (two map vectors each) to find the three quests near the player. Now each giver's place is kept, and the
// judging runs only for a giver near the player. The hint is the same: a quest whose first accept passes stands
// at that accept even when a later one is nearer (303).
#[test]
fn a_grind_steps_hint_judges_and_places_only_the_givers_near_the_player() {
	let out = run(
		vec![Addon::files("Polestar", &["Core/Core.xml"])],
		&format!(
			r#"
		{TEST_PACK}
		{TEST_SOURCE}
		local acc = function(q, x) return {{ t = "accept", quest = q, qlvl = 10, map = 1429, x = x, y = x, npc = 900 + q }} end
		Polestar.RegisterGuide({{ id = "test/grind", pack = "test", title = "Grind", faction = "Alliance", minLevel = 1, maxLevel = 20, zone = 1429, steps = {{
			{{ title = "Level 12", goals = {{ {{ t = "level", level = 12 }} }} }},
			{{ title = "Far", goals = {{ acc(301, 90), acc(303, 85) }} }},
			{{ title = "Near", goals = {{ acc(302, 41), acc(303, 42), acc(304, 39) }} }},
			{{ title = "More", goals = {{ acc(305, 80), acc(306, 10), acc(307, 43), acc(308, 44) }} }},
		}} }})
		E = Polestar.Engine
		stub.login(); stub.advance(0.25)
		E.SetGuide("test/grind"); stub.advance(0.25)
		local C, calls = Polestar.Compat, 0
		local toWorld = C.MapToWorld
		C.MapToWorld = function(...) calls = calls + 1 return toWorld(...) end
		local hints, per = {{}}, {{}}
		for k = 1, 3 do
			calls = 0
			local h = E.GrindHint(1)
			local qs = {{}}
			for _, e in ipairs(h.nearby) do qs[#qs + 1] = e.quest end
			hints[k] = {{ lo = h.lo, hi = h.hi, near = qs }}
			per[k] = calls
			stub.advance(6)
		end
		emit({{ hints = hints, later = per[2] + per[3] }})"#
		),
	);
	println!("GRIND {out}");
	let hint = json!({ "lo": 10, "hi": 10, "near": [302, 304, 307] });
	assert_eq!(out, json!({ "hints": [hint, hint, hint], "later": 2 }));
}
