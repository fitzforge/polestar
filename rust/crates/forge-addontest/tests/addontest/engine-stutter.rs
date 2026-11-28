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

// The While-here build (Own.hereBuild, the frame after each evaluation) read the whole quest log (Own.logRoom)
// for each hand-in it weighed; now one build, like a step's view, reads the log's room and each goal's done
// answer once. The lines are the same.
#[test]
fn the_while_here_build_reads_the_quest_log_once() {
	let out = run(
		vec![Addon::files("Polestar", &["Core/Core.xml"])],
		&format!(
			r#"
		{TEST_PACK}
		{TEST_SOURCE}
		local steps = {{ {{ title = "Start", goals = {{ {{ t = "goto", map = 1429, x = 40, y = 40, text = "Here" }}, {{ t = "level", level = 30 }} }} }} }}
		for i = 1, 12 do
			local q = 2000 + i
			steps[#steps + 1] = {{ title = "Hand in " .. i, goals = {{ {{ t = "turnin", quest = q, title = "Q" .. q, map = 1429, x = 40 + i * 0.2, y = 40, npc = 300 + i }} }} }}
		end
		Polestar.RegisterGuide({{ id = "test/here", pack = "test", title = "Here", faction = "Alliance", minLevel = 1, maxLevel = 30, zone = 1429, steps = steps }})
		E = Polestar.Engine
		stub.login(); stub.advance(0.25)
		for i = 1, 12 do stub.world.accept(2000 + i, {{ 1 }}) end
		for i = 1, 12 do stub.world.finish(2000 + i) end
		E.SetGuide("test/here"); stub.advance(0.5)
		local reads, n = 0, C_QuestLog.GetNumQuestLogEntries
		C_QuestLog.GetNumQuestLogEntries = function(...) reads = reads + 1 return n(...) end
		local list = {{}}
		stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.5)
		for _, e in ipairs(E.GetWhileHereList and E.GetWhileHereList() or {{}}) do list[#list + 1] = e.quest or (e.goal and e.goal.quest) or e.kind end
		emit({{ reads = reads, step = E.GetStepIndex(), lines = #list }})"#
		),
	);
	// Base: 7 reads of the log over the update.
	assert_eq!(out, json!({ "reads": 3, "step": 1, "lines": 3 }));
}

// Background tabs and While-here candidate scans wait during combat (Compat.InCombat),
// and on PLAYER_REGEN_ENABLED each catches up once, with the same result.
#[test]
fn in_combat_background_tabs_and_while_here_wait_and_catch_up_on_leaving_combat() {
	let out = run(
		vec![Addon::files("Polestar", &["Core/Core.xml"])],
		&format!(
			r#"
		{TEST_PACK}
		{TEST_SOURCE}
		local steps = {{ {{ title = "Start", goals = {{ {{ t = "goto", map = 1429, x = 40, y = 40, text = "Here" }}, {{ t = "level", level = 30 }} }} }} }}
		for i = 1, 12 do
			local q = 2000 + i
			steps[#steps + 1] = {{ title = "Hand in " .. i, goals = {{ {{ t = "turnin", quest = q, title = "Q" .. q, map = 1429, x = 40 + i * 0.2, y = 40, npc = 300 + i }} }} }}
		end
		Polestar.RegisterGuide({{ id = "test/tab1", pack = "test", title = "Tab 1", faction = "Alliance", minLevel = 1, maxLevel = 30, zone = 1429, steps = steps }})
		Polestar.RegisterGuide({{ id = "test/tab2", pack = "test", title = "Tab 2", faction = "Alliance", minLevel = 1, maxLevel = 30, zone = 1429, steps = {{
			{{ title = "Kill", goals = {{ {{ t = "kill", quest = 3002, oi = 1, target = "Wolf", map = 1429, x = 50, y = 50, text = "Wolves" }} }} }},
			{{ title = "Done", goals = {{ {{ t = "turnin", quest = 3002, title = "Q3002", map = 1429, x = 40, y = 40, npc = 502 }} }} }},
		}} }})
		E = Polestar.Engine
		stub.login(); stub.advance(0.25)
		for i = 1, 12 do stub.world.accept(2000 + i, {{ 1 }}) end
		stub.world.accept(3002, {{ 1 }})
		E.SetGuide("test/tab1"); stub.advance(0.5)
		E.OpenTab("test/tab2", false); stub.advance(0.25)

		-- Start combat
		stub.inCombat = true
		stub.fire("PLAYER_REGEN_DISABLED")

		-- Progress background tab quest 3002 and finish While-here hand-ins during combat
		stub.world.progress(3002, 1, 1)
		for i = 1, 12 do stub.world.finish(2000 + i) end
		stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.5)

		-- While in combat: background tab was not evaluated (still step 1), While-here candidate scan deferred
		local tabsDuring = E.TabLiveSteps()
		local bgStepDuring = tabsDuring[2] and tabsDuring[2].live
		local hereDuring = E.WhileHereState().candidates

		-- Leave combat
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(0.5)

		-- Out of combat: background tab evaluated to step 2, While-here caught up to candidates
		local tabsAfter = E.TabLiveSteps()
		local bgStepAfter = tabsAfter[2] and tabsAfter[2].live
		local hereAfter = E.WhileHereState().candidates

		emit({{
			bgDuring = bgStepDuring,
			bgAfter = bgStepAfter,
			hereDuring = hereDuring,
			hereAfter = hereAfter,
		}})"#
		),
	);
	assert_eq!(out, json!({ "bgDuring": 1, "bgAfter": 2, "hereDuring": 0, "hereAfter": 12 }));
}

// A While-here build already queued before combat enters combat before Own.hereLater runs and waits
// for PLAYER_REGEN_ENABLED; when a build ran inside combat and hit a vendor Codex retry (hereVendorRetry),
// PLAYER_REGEN_ENABLED still marks hereDirty and rebuilds the sell reminder.
#[test]
fn while_here_queued_before_combat_waits_and_vendor_retry_rebuilds_after_combat() {
	let out = run(
		vec![Addon::name("Polestar")],
		&format!(
			r#"
		{TEST_PACK}
		{TEST_SOURCE}
		local w = stub.world
		w.zone, w.subzone, w.resting = "Elwynn Forest", "Goldshire", true
		w.moveTo(1429, 42, 65)
		local bagFree, enterCombatOnCodexCheck, codexLoaded = 12, false, false
		C_Container = C_Container or {{}}
		C_Container.GetContainerNumSlots = function(bag) return bag == 0 and 16 or 0 end
		C_Container.GetContainerNumFreeSlots = function(bag) return bag == 0 and bagFree or 0, 0 end
		Polestar.MapFrames.era[1429] = {{ c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }}
		local npcs = {{ [102] = {{ id = 102, name = "Brog Hamfist", subName = "General Supplies", faction = "A", spawns = {{ {{ map = 1429, x = 43, y = 65 }} }} }} }}
		Polestar.Codex = {{
			IsLoaded = function()
				if enterCombatOnCodexCheck then
					enterCombatOnCodexCheck = false
					stub.inCombat = true
				end
				return codexLoaded
			end,
			Load = function() if stub.inCombat then return false, "combat" end codexLoaded = true return true end,
			WithRole = function(r) return r == "vendor" and {{ 102 }} or {{}} end,
			Npc = function(id) return npcs[id] end,
		}}
		local steps = {{ {{ title = "Out", goals = {{ {{ t = "kill", target = "Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 40 }} }} }} }}
		for i = 1, 6 do
			local q = 2100 + i
			steps[#steps + 1] = {{ title = "Hand in " .. i, goals = {{ {{ t = "turnin", quest = q, title = "Q" .. q, map = 1429, x = 40 + i * 0.2, y = 40, npc = 300 + i }} }} }}
		end
		Polestar.RegisterGuide({{ id = "test/queued", pack = "test", title = "Queued", faction = "Alliance", minLevel = 1, maxLevel = 30, zone = 1429, steps = steps }})
		local E = Polestar.Engine
		stub.login(); stub.advance(0.25)
		w.onQuest(33, {{ 8 }})
		for i = 1, 6 do w.accept(2100 + i, {{ 1 }}) end
		E.SetGuide("test/queued"); stub.advance(0.5)

		-- Queue a While-here build just before combat begins, then enter combat before timers flush.
		for i = 1, 6 do w.finish(2100 + i) end
		stub.fire("QUEST_LOG_UPDATE")
		stub.inCombat = true
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.advance(0.5)
		local preQueuedDuring = E.WhileHereState().candidates

		-- Leave combat: the held build runs after HERE_AFTER_FIGHT (0.2s).
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(0.5)
		local preQueuedAfter = E.WhileHereState().candidates

		-- Now test hereVendorRetry alone: a build starts out of combat, but combat begins before Codex loads.
		enterCombatOnCodexCheck = true
		bagFree = 2
		stub.fire("BAG_UPDATE_DELAYED"); stub.advance(0.5)
		local vendorsDuring = 0
		for _, v in ipairs(E.GetWhileHereList()) do if v.here == "sell" then vendorsDuring = vendorsDuring + 1 end end
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(0.6)
		local vendorsAfter = 0
		for _, v in ipairs(E.GetWhileHereList()) do if v.here == "sell" then vendorsAfter = vendorsAfter + 1 end end

		emit({{
			preQueuedDuring = preQueuedDuring,
			preQueuedAfter = preQueuedAfter,
			vendorsDuring = vendorsDuring,
			vendorsAfter = vendorsAfter,
		}})"#
		),
	);
	assert_eq!(out, json!({ "preQueuedDuring": 0, "preQueuedAfter": 6, "vendorsDuring": 0, "vendorsAfter": 1 }));
}

// In combat, step updates, route changes, and while-here changes leave the map layer's pins on the old step;
// on PLAYER_REGEN_ENABLED, the layer catches up exactly once.
#[test]
fn in_combat_the_map_layer_waits_and_catches_up_on_leaving_combat() {
	let out = run(
		vec![Addon::name("Polestar")],
		&format!(
			r#"
		{TEST_PACK}
		{TEST_SOURCE}
		Polestar.RegisterGuide({{ id = "test/mapstep", pack = "test", title = "Map Step", faction = "Alliance", minLevel = 1, maxLevel = 30, zone = 1429, steps = {{
			{{ title = "Step 1", goals = {{ {{ t = "kill", quest = 4001, count = 2, oi = 1, target = "Wolf", map = 1429, x = 40, y = 40, text = "Wolves" }} }} }},
			{{ title = "Step 2", goals = {{ {{ t = "kill", quest = 4002, oi = 1, target = "Bear", map = 1429, x = 60, y = 60, text = "Bears" }} }} }},
		}} }})
		E = Polestar.Engine
		stub.login(); stub.advance(0.25)
		stub.world.accept(4001, {{ {{ text = "Wolves: 0/2", required = 2 }} }})
		stub.world.accept(4002, {{ 1 }})
		E.SetGuide("test/mapstep"); stub.advance(0.5)

		local updates = 0
		local origUpdate = Polestar.Nav.layers.Update
		Polestar.Nav.layers.Update = function(...)
			updates = updates + 1
			return origUpdate(...)
		end

		-- Start combat
		stub.inCombat = true
		stub.fire("PLAYER_REGEN_DISABLED")
		local beforeFightUpdates = updates

		-- Progress 1 of 2 kills in combat (fires STEP_UPDATED), plus route and while-here updates
		stub.world.progress(4001, 1, 1)
		stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.25)
		Polestar.Fire("ROUTE_CHANGED")
		Polestar.Fire("WHILE_HERE_CHANGED")

		local stepInCombat = E.GetStepIndex()
		local updatesInCombat = updates - beforeFightUpdates

		-- Leave combat
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(0.25)

		local updatesAfterRegen = updates - beforeFightUpdates

		emit({{
			stepInCombat = stepInCombat,
			updatesInCombat = updatesInCombat,
			updatesAfterRegen = updatesAfterRegen,
		}})"#
		),
	);
	assert_eq!(out, json!({ "stepInCombat": 1, "updatesInCombat": 0, "updatesAfterRegen": 1 }));
}
