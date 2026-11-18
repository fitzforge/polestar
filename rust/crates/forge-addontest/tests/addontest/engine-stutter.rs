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
			{{ title = "Take", goals = {{ {{ t = "accept", quest = 100, title = "Hundred", map = 1429, x = 41, y = 41, npc = 197 }}, {{ t = "accept", quest = 200, title = "Wolves", map = 1429, x = 41, y = 41, npc = 197 }} }} }},
			{{ title = "Back", goals = {{ {{ t = "turnin", quest = 100, title = "Hundred", map = 1429, x = 45, y = 45, npc = 198 }} }} }},
			{{ title = "Wolves", goals = {{ {{ t = "kill", quest = 200, obj = 1, target = "Wolf", map = 1429, x = 60, y = 60, text = "Wolves" }} }} }},
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
	assert_eq!(out, json!({ "step": 2, "plain": 5, "behind": 10, "x1": 45, "x2": 45 }));
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
		local acc = function(q, x) return {{ t = "accept", quest = q, title = "Quest " .. q, qlvl = 10, map = 1429, x = x, y = x, npc = 900 + q }} end
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
	let hint = json!({ "lo": 10, "hi": 10, "near": [302, 304, 307] });
	assert_eq!(out, json!({ "hints": [hint, hint, hint], "later": 2 }));
}

// Install's Groups page asks Engine.GroupQuests on each layout, and Install lays out again after every fight while
// it waits for a new character: each ask walked every step of every guide for the character. Now the list is kept
// while the guides listed and the character stay the same; a guide that comes in is counted.
#[test]
fn group_quests_are_counted_once_until_the_guides_change() {
	let out = run(
		vec![Addon::files("Polestar", &["Core/Core.xml"])],
		&format!(
			r#"
		{TEST_PACK}
		{TEST_SOURCE}
		local G = function(id, q, faction) return {{ id = id, pack = "test", title = id, faction = faction, minLevel = 1, maxLevel = 20, zone = 1429, steps = {{
			{{ title = "Take", goals = {{ {{ t = "accept", quest = q, title = "Group " .. q, map = 1429, x = 41, y = 41, npc = 197 }} }} }},
			{{ title = "Do it", when = {{ {{ k = "group", q = q }} }}, goals = {{ {{ t = "turnin", quest = q, title = "Group " .. q, map = 1429, x = 42, y = 42, npc = 197 }} }} }},
			{{ title = "Solo", goals = {{ {{ t = "accept", quest = q + 1, title = "Solo", map = 1429, x = 43, y = 43, npc = 198 }} }} }},
		}} }} end
		Polestar.RegisterGuide(G("test/g1", 501, "Alliance"))
		Polestar.RegisterGuide(G("test/g2", 601, "Horde"))
		Polestar.RegisterGuide(G("test/g3", 701))
		E = Polestar.Engine
		stub.login(); stub.advance(0.25)
		local walks, matches = 0, Polestar.Guides.Matches
		Polestar.Guides.Matches = function(...) walks = walks + 1 return matches(...) end
		local function quests()
			local out = {{}}
			for _, e in ipairs(E.GroupQuests()) do out[#out + 1] = e.quest .. " " .. tostring(e.title) end
			return out
		end
		local first = quests()
		for _ = 1, 9 do quests() end
		local ten = walks
		Polestar.RegisterGuide(G("test/g4", 801, "Alliance"))
		walks = 0
		local after = quests()
		quests()
		emit({{ first = first, ten = ten, after = after, twice = walks }})"#
		),
	);
	// Base: 60 step checks for ten asks, 18 for two after the new guide.
	assert_eq!(out, json!({ "first": ["501 Group 501", "701 Group 701"], "ten": 6, "after": ["501 Group 501", "701 Group 701", "801 Group 801"], "twice": 9 }));
}

// The guide window's progress bar counts the whole guide after each evaluation (Own.countProgress), and a step
// ahead was asked done several times over: its goals, then its travel checks (Own.transitKind, Own.travelOnto,
// Own.alreadyAcross), each asking the goals again, and the steps after it. Now one count asks each goal, step
// and travel answer once, as a step's view does, and a step with no goto or flight is no travel. The count is
// the same; the quest log is read about a third as often.
#[test]
fn the_progress_count_asks_each_goal_and_step_once() {
	let out = run(
		vec![Addon::files("Polestar", &["Core/Core.xml"])],
		&format!(
			r#"
		{TEST_PACK}
		{TEST_SOURCE}
		local steps = {{}}
		for i = 1, 30 do
			local q = 1000 + i
			if i % 3 == 0 then
				steps[#steps + 1] = {{ title = "Walk " .. i, goals = {{ {{ t = "goto", map = 1429, x = 50 + i % 7, y = 50, text = "Walk" }} }} }}
			else
				steps[#steps + 1] = {{ title = "Step " .. i, goals = {{
					{{ t = "goto", map = 1429, x = 41, y = 41 + i % 5, text = "There" }},
					{{ t = "accept", quest = q, title = "Q" .. q, map = 1429, x = 41, y = 41, npc = 197 }},
					{{ t = "kill", quest = q, obj = 1, target = "Wolf", map = 1429, x = 60, y = 60, text = "Wolves" }},
					{{ t = "turnin", quest = q, title = "Q" .. q, map = 1429, x = 42, y = 42, npc = 197 }},
				}} }}
			end
		end
		Polestar.RegisterGuide({{ id = "test/prog", pack = "test", title = "Prog", faction = "Alliance", minLevel = 1, maxLevel = 20, zone = 1429, steps = steps }})
		E = Polestar.Engine
		stub.world.complete({{ 1004, 1005, 1010, 1020 }})
		stub.login(); stub.advance(0.25)
		E.SetGuide("test/prog"); stub.advance(0.25)
		stub.world.accept(1001, {{ 5 }}); stub.advance(0.25)
		local calls = 0
		for _, name in ipairs({{ "IsOnQuest", "IsQuestFlaggedCompleted", "GetQuestObjectives", "ReadyForTurnIn", "IsComplete" }}) do
			local f = C_QuestLog[name]
			if f then C_QuestLog[name] = function(...) calls = calls + 1 return f(...) end end
		end
		local done, total = E.GetProgress()
		local once = calls
		calls = 0
		Polestar.NewMoment()
		E.RequestUpdate(); stub.advance(0.25)
		calls = 0
		local d2, t2 = E.GetProgress()
		emit({{ done = done, total = total, d2 = d2, t2 = t2, calls = once, calls2 = calls, step = E.GetStepIndex() }})"#
		),
	);
	// Base: 853 quest-log reads per count.
	assert_eq!(out, json!({ "done": 6, "total": 30, "d2": 6, "t2": 30, "calls": 258, "calls2": 258, "step": 1 }));
}
