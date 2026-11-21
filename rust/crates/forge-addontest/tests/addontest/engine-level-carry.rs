//! Quests the route passes for the character's level are not lost (Fitz, 2026-11-20: "it skips a huge number of
//! quests"). An accept passed under its quest's level waits for it (Own.waitList, saved by quest id): when the
//! guide ends first, the next guide takes it where its route passes the giver (Own.carryChains, under the feeder
//! rules), and the level-up brings the route back to it there; the skip notice says which. A step whose `when`
//! failed as the route passed it is not stored as skipped while it can still hold in the same guide
//! (Own.whenPending): the route comes back to it ahead of the live step, and behind it the quest's work goes to the
//! "Still to do" row instead of pulling the arrow back (Own.settlePending).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1440, { name = "Ashenvale", c = 1, left = 1000, right = -1000, top = 1000, bottom = -3000 })
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1440, 50, 50)
w.race, w.faction, w.class, w.className, w.level = "Orc", "Horde", "WARRIOR", "Warrior", 11
w.setXP(500, 1000)
"#;

// First Zone ends at Erelas, whose Moontouched Wildkin (20) asks level 12; Second Zone starts at the flight master
// beside Erelas (GIVER: map, x, y of his accept), then works and hands in the wildkin quest far away. Third Zone
// steps: a level-gated accept (40) with its work behind `when onquest`, and a `when level>=12` hunt (50) for a
// quest taken before it.
const GUIDES: &str = r#"
local A = 1440
local function acc(q, title, x, y, min) return { t = "accept", quest = q, title = title, map = A, x = x, y = y, minLevel = min, qlvl = min or 10 } end
local function hand(q, title, x, y) return { t = "turnin", quest = q, title = title, map = A, x = x, y = y } end
local function kill(q, x, y) return { t = "kill", target = "Wildkin", count = 3, quest = q, oi = 1, map = A, x = x, y = y } end
local erelas = { t = "accept", quest = 20, title = "Moontouched Wildkin", minLevel = 12, qlvl = 12, map = GIVER[1], x = GIVER[2], y = GIVER[3] }
Polestar.RegisterGuide({ id = "test/one", pack = "test", title = "First Zone", faction = "Horde", minLevel = 10, maxLevel = 12, next = "test/two", steps = {
	{ title = "Camp", goals = { acc(10, "Camp Work", 40, 40) } },
	{ title = "Erelas", goals = { hand(10, "Camp Work", 60, 60), erelas } },
} })
Polestar.RegisterGuide({ id = "test/two", pack = "test", title = "Second Zone", faction = "Horde", minLevel = 11, maxLevel = 14, steps = {
	{ title = "Flight master", goals = { { t = "goto", map = A, x = 60.5, y = 60.5, text = "Flight master" } } },
	{ title = "Far camp", goals = { acc(30, "Far Away", 20, 20) } },
	{ title = "Wildkin", goals = { kill(20, 25, 25) } },
	{ title = "Far camp", goals = { hand(30, "Far Away", 20, 20), hand(20, "Moontouched Wildkin", 20, 21) } },
} })
Polestar.RegisterGuide({ id = "test/three", pack = "test", title = "Third Zone", faction = "Horde", minLevel = 10, maxLevel = 14, steps = {
	{ title = "Krom'Grul", goals = { acc(40, "Krom'Grul", 40, 40, 12) } },
	{ title = "Krom'Grul's den", when = { { k = "onquest", q = { 40 } } }, goals = { kill(40, 42, 42) } },
	{ title = "Hunter", goals = { acc(50, "Elite Hunt", 44, 44) } },
	{ title = "The elite", when = { { k = "level", op = ">=", n = 12 } }, goals = { kill(50, 46, 46) } },
	{ title = "Road", goals = { acc(51, "Next", 60, 60) } },
	{ title = "Town", goals = { acc(52, "Later", 70, 70) } },
	{ title = "Town", goals = { hand(51, "Next", 70, 70), hand(52, "Later", 70, 70), hand(50, "Elite Hunt", 70, 70), hand(40, "Krom'Grul", 70, 70) } },
} })
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
function flush() stub.advance(0.25) end
SKIPS = {}
Polestar.On("STEP_SKIPPED", function(_, _, skips)
	for _, k in ipairs(skips) do SKIPS[#SKIPS + 1] = k.title .. ": " .. tostring(k.text) end
end)
-- Each step: its title, where it comes from, its goals.
function shape()
	local out = {}
	for i, step in ipairs(E.GetGuide().steps) do
		local q = {}
		for _, goal in ipairs(step.goals) do q[#q + 1] = goal.t .. (goal.quest and (":" .. goal.quest) or "") end
		out[i] = E.GetStepView(i).title .. (step.feeder and (" <" .. step.feeder .. " " .. step.feederStep .. ">") or "") .. " " .. table.concat(q, " ")
	end
	return out
end
function waits()
	local out = {}
	for q, v in pairs(PolestarCharDB.levelWaits or {}) do out[#out + 1] = q .. "@" .. v.level .. " " .. v.guide end
	table.sort(out)
	return out
end
stub.login()
Polestar.Set("behavior.autoAccept", false)
Polestar.Set("behavior.guideEnd", "continue")
stub.fire("QUEST_LOG_UPDATE"); flush()
"#;

fn run(giver: &str, saved: Option<&str>, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\nGIVER = {{ {giver} }}\n{GUIDES}\n{HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

const NEAR: &str = "1440, 60, 60";
const ELSEWHERE: &str = "1429, 50, 50";

// The player at 11 hands in Camp Work at Erelas, the last step of First Zone: Moontouched Wildkin (level 12) is
// passed, and First Zone hands off to Second Zone ("Continue automatically").
const TO_THE_END: &str = r#"
E.SetGuide("test/one"); flush()
w.accept(10, {}); flush()
local r = { live1 = E.GetLiveStep() }
w.turnIn(10); flush()
r.skips, r.waits, r.guide, r.shape, r.live = SKIPS, waits(), E.GetGuide().id, shape(), E.GetLiveStep()
"#;

#[test]
fn an_accept_passed_one_level_low_at_a_guide_s_end_is_carried_into_the_next_guide_and_never_pulls_the_route_back() {
	let out = run(
		NEAR,
		None,
		&format!(
			r#"{TO_THE_END}
-- Level 12 in Second Zone, the route past Erelas' carried step: no jump back. It waits on, and While you're here
-- offers it at Erelas.
w.setLevel(12); flush()
r.back, r.still = E.GetLiveStep(), waits()
local ends = {{}}
for _, q in ipairs(E.WaitingQuests("test/two")) do ends[#ends + 1] = q.quest .. "@" .. q.level end
r.ends = ends
w.moveTo(GIVER[1], GIVER[2], GIVER[3]); flush()
local here = {{}}
for _, c in ipairs(E.GetWhileHereCandidates()) do here[#here + 1] = c.step .. ":" .. c.kind end
r.here = here
w.accept(20, {{ 3 }}); flush()
r.after, r.left = E.GetLiveStep(), waits()
emit(r)"#
		),
	);
	assert_eq!(out["live1"], 2, "at Erelas with Camp Work to hand in: {out}");
	assert_eq!(out["skips"], json!(["Moontouched Wildkin: Requires level 12: kept for a later guide"]), "{out}");
	assert_eq!(out["waits"], json!(["20@12 test/two"]), "noted by quest id, waiting now in Second Zone: {out}");
	assert_eq!(out["guide"], "test/two");
	assert_eq!(
		out["shape"],
		json!(["Erelas <test/one 2> accept:20", "Flight master goto", "Far camp accept:30", "Wildkin kill:20", "Far camp turnin:30 turnin:20",]),
		"Second Zone takes Erelas' accept beside its flight master, before the wildkin: {out}"
	);
	assert_eq!(out["live"], 2, "still 11: passed, on to the flight master: {out}");
	assert_eq!(out["back"], 2, "level 12: the route stays where it is, never back to Erelas: {out}");
	assert_eq!(out["still"], json!(["20@12 test/two"]), "still waiting: {out}");
	assert_eq!(out["ends"], json!(["20@12"]), "listed for the guide-end window: {out}");
	assert!(out["here"].as_array().unwrap().iter().any(|v| v == "1:take"), "at Erelas, While you're here offers it: {out}");
	assert_eq!(out["after"], 2, "taken there: the route goes on: {out}");
	assert_eq!(out["left"], json!({}), "taken: no longer waiting: {out}");
}

// The wait is saved with the character by quest id: a reload (or another tab opening Second Zone) plans it in. A
// character who has the level by then takes it on the way: it is the guide's first step.
#[test]
fn a_waiting_accept_survives_a_reload_and_the_next_guide_opened_later_still_takes_it() {
	let saved = r#"PolestarCharDB = { schema = 1, levelWaits = { [20] = { level = 12, guide = "test/one" } } }"#;
	let out = run(NEAR, Some(saved), r#"E.SetGuide("test/two"); flush(); emit({ shape = shape(), waits = waits() })"#);
	assert_eq!(out["shape"][0], "Erelas <test/one 2> accept:20", "{out}");
	assert_eq!(out["waits"], json!(["20@12 test/two"]), "passed at 11 there, waiting on: {out}");
	let at12 = run(NEAR, Some(saved), r#"w.setLevel(12); flush(); E.SetGuide("test/two"); flush(); emit({ live = E.GetLiveStep(), shape = shape() })"#);
	assert_eq!(at12["shape"][0], "Erelas <test/one 2> accept:20", "{at12}");
	assert_eq!(at12["live"], 1, "at 12 on arrival: Erelas is the live step: {at12}");
	// Passed in Second Zone at 11 (saved), then a reload at 12: the route still never goes back for it.
	let passed = r#"PolestarCharDB = { schema = 1, levelWaits = { [20] = { level = 12, guide = "test/two", passed = "test/two" } } }"#;
	let back = run(NEAR, Some(passed), r#"w.setLevel(12); flush(); E.SetGuide("test/two"); flush(); emit({ live = E.GetLiveStep(), waits = waits() })"#);
	assert_eq!(back["live"], 2, "{back}");
	assert_eq!(back["waits"], json!(["20@12 test/two"]), "{back}");
}

// A giver the next guide's route never comes near (another continent) stays out of it: the guide is as written, and
// the accept waits on for the guides after it.
#[test]
fn a_waiting_accept_whose_giver_the_next_guide_never_passes_leaves_it_as_written_and_waits_on() {
	let out = run(ELSEWHERE, None, &format!("{TO_THE_END}\nemit(r)"));
	assert_eq!(out["guide"], "test/two");
	assert_eq!(out["shape"][0], "Flight master goto", "{out}");
	assert_eq!(out["shape"].as_array().map(Vec::len), Some(4), "{out}");
	assert_eq!(out["waits"], json!(["20@12 test/one"]), "{out}");
}

// The audit's `when onquest` case: Krom'Grul (level 12) is passed at 11, and his den with it (`when onquest`). At 12
// the route comes back for him; once he is taken, the den is the next step, not skipped for good.
#[test]
fn a_when_onquest_step_passed_before_its_quest_comes_back_once_the_quest_is_taken_in_the_same_guide() {
	let out = run(
		NEAR,
		None,
		r#"
E.SetGuide("test/three"); flush()
local r = { live = E.GetLiveStep() }
w.setLevel(12); flush()
r.back = E.GetLiveStep()
w.accept(40, { 1 }); flush()
r.den = E.GetLiveStep()
r.skipped = PolestarCharDB.skipped["test/three"] and PolestarCharDB.skipped["test/three"][2] or false
emit(r)"#,
	);
	assert_eq!(out["live"], 3, "at 11: Krom'Grul and his den passed: {out}");
	assert_eq!(out["back"], 1, "level 12: back to Krom'Grul: {out}");
	assert_eq!(out["den"], 2, "taken: the den comes next: {out}");
	assert_eq!(out["skipped"], false, "{out}");
}

// A `when level>=12` hunt passed at 11 for a quest in the log: the level comes once the route is two steps on. The
// arrow stays where it is; the hunt is a "Still to do" row (and While you're here), stored as skipped.
#[test]
fn a_when_level_step_that_holds_once_the_route_is_past_it_goes_to_still_to_do_not_the_live_step() {
	let out = run(
		NEAR,
		None,
		r#"
E.SetGuide("test/three"); flush()
w.accept(50, { 3 }); flush()
w.accept(51, {}); flush()
local r = { live = E.GetLiveStep() }
-- Krom'Grul's accept is the guide's own level wait: the player skipped it, so the level-up brings nothing else back.
PolestarCharDB.skipped["test/three"] = PolestarCharDB.skipped["test/three"] or {}
PolestarCharDB.skipped["test/three"][1] = true
w.setLevel(12); flush()
local behind = {}
for _, b in ipairs(E.GetBehind()) do behind[#behind + 1] = b.quest .. "@" .. b.step end
r.after, r.behind = E.GetLiveStep(), behind
r.skipped = PolestarCharDB.skipped["test/three"][4] or false
emit(r)"#,
	);
	assert_eq!(out["live"], 6, "{out}");
	assert_eq!(out["after"], 6, "the arrow stays: {out}");
	assert_eq!(out["behind"], json!(["50@4"]), "the hunt is still to do: {out}");
	assert_eq!(out["skipped"], true, "{out}");
}

// The shipped route, a Human Paladin behind it (51): since the 0.4.2 route round Felwood's flight from Everlook to
// Rut'theran Village hands in Favored of Elune? and offers Moontouched Wildkin (978, level 52), the start of a chain
// into Winterspring, the Western Plaguelands and Silithus. At 51 it is passed and waits for 52, listed on Felwood's
// guide-end window. The Winterspring guide after it never passes Erelas, so it takes nothing there, and level 52 in
// Winterspring never sends the route back to Teldrassil: the quest stays waiting for the next pass of Erelas, the
// Plaguelands guide's Rut'theran stop.
#[test]
fn a_paladin_at_51_passes_moontouched_wildkin_at_rut_theran_and_52_in_winterspring_never_pulls_him_back() {
	const FW: &str = "forever/alliance/50-60/02-felwood";
	let dir = forge_addontest::run::addons_dir();
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: r#"local w = stub.world
w.race, w.faction, w.class, w.className, w.level = "Human", "Alliance", "PALADIN", "Paladin", 51
w.setXP(59000, 98000)
w.complete({ 3764, 162, 2944 })
w.onQuest(3661, {})"#
			.to_string(),
		addons: vec![
			Addon::files("Polestar", &["Core/Core.xml"]),
			Addon::dir("Polestar_Guides", dir.join("Polestar_Guides")),
			Addon::dir("Polestar_Guides_Alliance", dir.join("Polestar_Guides_Alliance")),
		],
		script: format!(
			r#"
E = Polestar.Engine
w = stub.world
for id, b in pairs(Polestar.MapFrames.era) do w.addMap(id, b) end
w.moveTo(1438, 55.5, 92.0)
stub.login(); stub.advance(0.25)
Polestar.Set("behavior.autoAccept", false)
E.SetGuide("{FW}"); stub.advance(0.25)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
local g = E.GetGuide()
local at
for i, step in ipairs(g.steps) do
	if step.title == "Rut'theran Village" and E.Applies(i) and not at then at = i end
end
local sk = {{}}
for i = 1, at - 1 do sk[i] = true end
Polestar.CharState().skipped["{FW}"] = sk
stub.fire("QUEST_LOG_UPDATE"); stub.advance(1)
local r = {{ at = E.GetLiveStep() == at }}
w.turnIn(3661); stub.advance(1)
r.moved = E.GetLiveStep() ~= at
local wt = (PolestarCharDB.levelWaits or {{}})[978]
r.waits = wt and (wt.level .. " " .. wt.guide) or false
local ends = {{}}
for _, q in ipairs(E.WaitingQuests(g.id)) do ends[#ends + 1] = q.quest end
r.ends = ends
-- The rest of Felwood done; the guide-end window's Start.
for i = at + 1, #g.steps do sk[i] = true end
stub.fire("QUEST_LOG_UPDATE"); stub.advance(1)
r.started = E.StartNext("{FW}"); stub.advance(1)
g = E.GetGuide()
r.guide = g.id
local carry
for i, step in ipairs(g.steps) do
	for _, goal in ipairs(step.goals) do
		if goal.t == "accept" and goal.quest == 978 then carry = i end
	end
end
r.carry = carry or false
w.moveTo(1452, 31.3, 45.2); stub.fire("QUEST_LOG_UPDATE"); stub.advance(1)
r.live = E.GetLiveStep()
w.setLevel(52); stub.advance(1)
r.back = E.GetLiveStep()
wt = (PolestarCharDB.levelWaits or {{}})[978]
r.still = wt and wt.level or false
emit(r)"#
		),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["at"], true, "at Erelas with Favored of Elune? to hand in: {out}");
	assert_eq!(out["moved"], true, "51: Moontouched Wildkin passed: {out}");
	assert_eq!(out["waits"], format!("52 {FW}"), "{out}");
	assert_eq!(out["ends"], json!([978]), "listed for Felwood's guide-end window: {out}");
	assert_eq!(out["started"], true);
	assert_eq!(out["guide"], "forever/alliance/50-60/03-winterspring");
	assert_eq!(out["carry"], false, "Winterspring never passes Erelas: {out}");
	assert_eq!(out["back"], out["live"], "52 in Winterspring: no jump back to Erelas: {out}");
	assert_eq!(out["still"], 52, "still waiting: {out}");
}
