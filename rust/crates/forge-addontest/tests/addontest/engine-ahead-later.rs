//! Accepts ahead in the guides after the loaded one (addon/Polestar/Core/Engine.lua: Own.laterGuides,
//! Own.laterWants, Own.hereNext): at a giver whose quest the next guide of the route takes, auto-accept takes it
//! and While you're here shows it as a pick-up line, under the rules a later step's accept has, while that guide
//! starts at most HERE_ABOVE (2) levels over the player; once the route gets there, its accept reads done and
//! nothing is passed over. Real Core manifest, stub world (a level 5 character in Elwynn Forest).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.addMap(1436, { name = "Westfall", c = 0, left = -1500, right = -4500, top = -1500, bottom = -3500 })
w.level = 5
w.zone, w.subzone = "Elwynn Forest", ""
w.moveTo(1429, 40, 70)
w.onQuest(33, { 8 }, "Wolves Across the Border")
w.titles[9] = "The Killing Fields"
w.titles[61] = "Shipment to Stormwind"
w.titles[106] = "Young Lovers"
"#;

// Elwynn Forest (1-10, live step 1: wolves far from Marshal Dughan; step 2 takes Kobold Camp Cleanup, 7, from him)
// goes on to Westfall (6-14), whose step 2 takes The Killing Fields (9) and the timed Shipment to Stormwind (61)
// from Dughan, after Gryan Stoutmantle's accept in step 1; it goes on to Redridge Mountains (15-20), which takes
// Young Lovers (106) from Dughan: 15 is more than 2 over the player's 5.
const GUIDES: &str = r#"
Polestar.RegisterGuide({
	id = "test/elwynn", pack = "test", title = "Elwynn Forest", minLevel = 1, maxLevel = 10, next = "test/westfall",
	steps = {
		{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } },
		{ title = "Dughan", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 48.5, y = 42 } } },
	},
})
Polestar.RegisterGuide({
	id = "test/westfall", pack = "test", title = "Westfall", minLevel = 6, maxLevel = 14, next = "test/redridge",
	steps = {
		{ title = "Gryan", goals = { { t = "accept", quest = 12, title = "The People's Militia", npc = 234, npcName = "Gryan Stoutmantle", map = 1436, x = 56, y = 47 } } },
		{ title = "Dughan", goals = {
			{ t = "accept", quest = 9, title = "The Killing Fields", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 48.5, y = 42 },
			{ t = "accept", quest = 61, title = "Shipment to Stormwind", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 48.5, y = 42, limit = 6000 },
		} },
		{ title = "Saldean", goals = { { t = "turnin", quest = 9, title = "The Killing Fields", npc = 233, npcName = "Farmer Saldean", map = 1436, x = 50, y = 50 } } },
	},
})
Polestar.RegisterGuide({
	id = "test/redridge", pack = "test", title = "Redridge Mountains", minLevel = 15, maxLevel = 20,
	steps = { { title = "Dughan", goals = { { t = "accept", quest = 106, title = "Young Lovers", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 48.5, y = 42 } } } },
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
function flush() stub.advance(0.25) end
function accepted()
	local c = {}
	for _, x in ipairs(w.calls) do if x[1] == "AcceptQuest" then c[#c + 1] = tostring(x[2]) end end
	return table.concat(c, " ")
end
-- Every While-you're-here line shown: "step:index text | sub-line".
function lines()
	local out = {}
	for _, v in ipairs(E.GetWhileHereList()) do out[#out + 1] = v.step .. ":" .. v.index .. " " .. v.hereText .. " | " .. tostring(v.hereSub) end
	return out
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/elwynn" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDES, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn talking_to_a_giver_whose_quest_the_next_guide_takes_auto_accept_takes_it_and_the_live_step_stays() {
	let out = run(r#"
		local from = #stub.messages
		for _, q in ipairs({ 7, 9, 61, 106 }) do w.questDetail(240, q); flush(); w.close() end
		local said = {}
		for i = from + 1, #stub.messages do said[#said + 1] = tostring(stub.messages[i]) end
		emit({ calls = accepted(), live = E.GetLiveStep(), guide = E.GetGuide().id, said = said })
	"#);
	// 7: the loaded guide's step 2, as before, without a word; 9: Westfall's step 2, with one line saying why. Not 61
	// (timed: never taken for a later guide) nor 106 (Redridge starts at 15).
	assert_eq!(out, json!({ "calls": "7 9", "live": 1, "guide": "test/elwynn", "said": ["|cff4fd1c5Polestar|r: Took “The Killing Fields” now: Westfall does it later, so this saves a trip back."] }));
}

#[test]
fn walking_past_that_giver_shows_the_next_guides_quest_as_a_pick_up_line_naming_the_guide() {
	let out = run(r#"
		Polestar.Set("behavior.autoAccept", false)
		w.moveTo(1429, 48.6, 42.2); stub.advance(0.6); stub.advance(0.6)
		emit(lines())
	"#);
	assert_eq!(
		out,
		json!([
			"2:1 Take “Kobold Camp Cleanup” from Marshal Dughan: saves a trip back | nil",
			"-3:9 Take “The Killing Fields” from Marshal Dughan: saves a trip back | Saves a trip back: Westfall does it later.",
		])
	);
}

// The horizon: a guide starting more than HERE_ABOVE levels over the player is out of reach, said in the debug log
// (Engine.AcceptRefusal) with the guide's name, as is the rule that declines a timed quest of the next guide.
#[test]
fn a_quest_of_a_guide_starting_more_than_two_levels_up_is_neither_taken_nor_shown_and_the_debug_log_says_why() {
	let out = run(r#"
		w.moveTo(1429, 48.6, 42.2); stub.advance(0.6); stub.advance(0.6)
		local shown = {}
		for _, l in ipairs(lines()) do if l:find("Young Lovers", 1, true) or l:find("Shipment", 1, true) then shown[#shown + 1] = l end end
		w.gossip(240, { available = { { questID = 106 }, { questID = 61 } } }); flush()
		local found = {}
		for _, line in ipairs(Polestar.DebugLog()) do if line:find("auto-accept left", 1, true) then found[#found + 1] = line:sub(10) end end
		emit({ shown = table.concat(shown, "; "), lines = found, calls = accepted() })
	"#);
	assert_eq!(
		out,
		json!({
			"shown": "",
			"lines": [
				"auto-accept left 106 (gossip 240): test/redridge starts at level 15 (step 1)",
				"auto-accept left 61 (gossip 240): timed (test/westfall step 2)",
			],
			"calls": "",
		})
	);
}

#[test]
fn once_the_route_reaches_the_next_guide_its_accept_taken_ahead_reads_done_and_nothing_is_passed_over() {
	let out = run(r#"
		w.questDetail(240, 9); flush(); w.close()
		local plan = Polestar.RoutePlan.GetTurnIn(9).status
		local off = {}
		for _, o in ipairs(Polestar.RoutePlan.OffRoute() or {}) do off[#off + 1] = o.quest end
		local skipped = {}
		Polestar.On("STEP_SKIPPED", function(_, _, list) for _, s in ipairs(list or {}) do skipped[#skipped + 1] = s.quest end end)
		local started = E.StartNext("test/elwynn"); stub.advance(0.6); stub.advance(0.6)
		emit({ started = started, guide = E.GetGuide().id, live = E.GetLiveStep(), done = E.GoalDone(2, 1), timed = E.GoalDone(2, 2),
			plan = plan, off = table.concat(off, " "), skipped = table.concat(skipped, " "), onQuest = w.log[9] ~= nil })
	"#);
	// Westfall starts at Gryan (step 1: nothing of it is passed for the quest taken ahead); its step 2 reads The
	// Killing Fields done, the timed quest still to take. Before the hand-off the route plan has the quest handed in
	// later, so it is no quest off the route.
	assert_eq!(out, json!({ "started": true, "guide": "test/westfall", "live": 1, "done": true, "timed": false, "plan": "later", "off": "", "skipped": "", "onQuest": true }));
}
