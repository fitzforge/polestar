//! Every guide stands on its own (#1353): a character opens a leveling guide without the guides before it (a
//! fresh start at its level, a skipped guide, or 0.3.5's new route order for a 0.3.4 character). Accepts that
//! wait on an earlier guide's quest are planned for: a feeder chain in the guide's own zones that costs at
//! most 5 minutes goes in beside the guide's nearest step; every other such accept is left out with its
//! quest's goals, and a step left with no quest goal goes. Nothing shows in the guide window; the report names
//! both.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1440, { name = "Ashenvale", c = 1, left = 1000, right = -1000, top = 1000, bottom = -3000 })
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1440, 70, 66)
w.race, w.faction, w.class, w.className, w.level = "Tauren", "Horde", "PALADIN", "Paladin", 26
w.titles[6383] = "The Ashenvale Hunt"; w.titles[216] = "Between a Rock and a Thistlefur"; w.titles[98] = "Off the Route"
w.complete({ 421, 494 })
w.onQuest(6382, {})
"#;

// The route: Ashenvale & Silverpine Forest -> Hillsbrad Foothills -> The Barrens & Stonetalon Mountains ->
// Ashenvale & Thousand Needles. Ashenvale & Thousand Needles goes Zoram'gar Outpost, Splintertree Post (its
// own errand), Senani Thunderheart, Karang Amakkar, Night Run. The furbolgs of Between a Rock and a Thistlefur
// stand at FUR (map, x, y). A side guide off the route takes Off the Route (98), which only it gives.
const GUIDES: &str = r#"
local A = 1440
local function acc(q, title, pre, x, y) return { t = "accept", quest = q, title = title, pre = pre, map = A, x = x or 50, y = y or 50, qlvl = 24 } end
local function hand(q, title, x, y) return { t = "turnin", quest = q, title = title, map = A, x = x or 50, y = y or 50 } end
Polestar.RegisterGuide({ id = "test/side", pack = "test", title = "Side Trip", faction = "Horde", minLevel = 20, maxLevel = 30, steps = {
	{ title = "Elsewhere", goals = { acc(98, "Off the Route") } },
} })
Polestar.RegisterGuide({ id = "test/05", pack = "test", title = "Ashenvale & Silverpine Forest", faction = "Horde", minLevel = 21, maxLevel = 22, next = "test/06", steps = {
	{ title = "The Sepulcher", goals = { acc(421, "Prove Your Worth"), hand(421, "Prove Your Worth") } },
	{ title = "Night Run", note = "Senani Thunderheart stands at Night Run.", goals = {
		hand(6382, "The Ashenvale Hunt", 73, 61), acc(6383, "The Ashenvale Hunt", { 6382 }, 73, 61), hand(6383, "The Ashenvale Hunt", 73, 61),
		acc(997, "Another Errand", nil, 73, 61),
	} },
	{ title = "Zoram'gar Outpost", goals = { acc(216, "Between a Rock and a Thistlefur", nil, 70, 66) } },
	{ title = "Thistlefur Village", goals = { { t = "kill", target = "Thistlefur Avenger", count = 8, quest = 216, oi = 1, map = FUR[1], x = FUR[2], y = FUR[3] } } },
	{ title = "Zoram'gar Outpost", goals = { hand(216, "Between a Rock and a Thistlefur", 70, 66) } },
} })
Polestar.RegisterGuide({ id = "test/06", pack = "test", title = "Hillsbrad Foothills", faction = "Horde", minLevel = 22, maxLevel = 24, next = "test/04", steps = {
	{ title = "Tarren Mill", goals = { acc(494, "Time To Strike"), hand(494, "Time To Strike") } },
} })
Polestar.RegisterGuide({ id = "test/04", pack = "test", title = "The Barrens & Stonetalon Mountains", faction = "Horde", minLevel = 24, maxLevel = 26, next = "test/07", steps = {
	{ title = "Sun Rock", goals = { acc(1087, "Cenarius' Legacy"), hand(1087, "Cenarius' Legacy") } },
} })
Polestar.RegisterGuide({ id = "test/07", pack = "test", title = "Ashenvale & Thousand Needles", faction = "Horde", minLevel = 26, maxLevel = 30, steps = {
	{ title = "Zoram'gar Outpost", goals = { acc(6442, "Naga at the Zoram Strand", nil, 70, 66), acc(99, "After the Detour", { 98 }, 70, 66) } },
	{ title = "Splintertree Post", goals = { acc(25, "Stonetalon Standstill", nil, 73, 61) } },
	{ title = "Senani Thunderheart", goals = {
		{ t = "goto", map = A, x = 73, y = 61 },
		acc(23, "Ursangous's Paw", { 6383 }, 73, 61), acc(24, "Shadumbra's Head", { 6383 }, 73, 61),
	} },
	{ title = "Karang Amakkar", goals = { { t = "goto", map = A, x = 70, y = 66 }, acc(6621, "King of the Foulweald", { 216 }, 70, 66) } },
	{ title = "Night Run", goals = { hand(23, "Ursangous's Paw", 73, 61), hand(24, "Shadumbra's Head", 73, 61), hand(25, "Stonetalon Standstill", 73, 61) } },
} })
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
function brief(i)
	local out = {}
	for g, v in ipairs(E.GetStepView(i).goals) do out[g] = v.status .. ":" .. tostring(v.unavailableText) end
	return out
end
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
-- The accepts left "Requires ... first".
function requires()
	local out = {}
	for i = 1, E.GetStepCount() do
		for _, v in ipairs(E.GetStepView(i).goals) do
			if v.unavailable == "pre" then out[#out + 1] = v.unavailableText end
		end
	end
	return out
end
stub.login()
Polestar.Set("behavior.autoAccept", false)
stub.fire("QUEST_LOG_UPDATE"); flush()
"#;

fn run(before: &str, fur: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\nFUR = {{ {fur} }}\n{GUIDES}\n{HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

const OPEN: &str = r#"
E.SetGuide("test/07"); flush()
local g = E.GetGuide()
local r = { shape = shape(), requires = requires(), at = E.GetStepIndex(), feeders = g.feeders or 0, hidden = {} }
for q in pairs(g.hidden or {}) do r.hidden[#r.hidden + 1] = q end
table.sort(r.hidden)
"#;

const NEAR: &str = "1440, 71, 64";
const FAR: &str = "1440, 20, 20";
const ELSEWHERE: &str = "1429, 50, 50";

#[test]
fn t_1353_local_feeders_go_in_beside_the_guide_s_nearest_step_in_its_own_zone() {
	let out = run("", NEAR, &format!("{OPEN}\nemit(r)"));
	// The hunt goes in after the guide's own Splintertree Post stop, before Senani's accepts that need it; the
	// furbolg chain at the Zoram'gar start, its kills a short walk away. The off-route quest's accept goes.
	assert_eq!(
		out["shape"],
		json!([
			"Zoram'gar Outpost <test/05 3> accept:216",
			"Thistlefur Village <test/05 4> kill:216",
			"Zoram'gar Outpost <test/05 5> turnin:216",
			"Zoram'gar Outpost accept:6442 accept:99",
			"Splintertree Post accept:25",
			"Night Run <test/05 2> turnin:6382 accept:6383 turnin:6383",
			"Senani Thunderheart goto accept:23 accept:24",
			"Karang Amakkar goto accept:6621",
			"Night Run turnin:23 turnin:24 turnin:25",
		])
	);
	// After the Detour waits on a quest only a guide off the route gives: a gap of the route, left as it is.
	assert_eq!(out["requires"], json!(["Requires Off the Route first"]));
	assert_eq!(out["hidden"].as_array().map_or(0, |a| a.len()), 0);
	assert_eq!(out["at"], 1);
}

#[test]
fn far_or_other_zone_feeders_stay_out_and_their_quests_and_empty_steps_go() {
	// The furbolgs far across the zone: over five minutes, so King of the Foulweald goes, and Karang's step
	// with it (only its walk was left).
	let far = run("", FAR, &format!("{OPEN}\nemit(r)"));
	assert_eq!(
		far["shape"],
		json!([
			"Zoram'gar Outpost accept:6442 accept:99",
			"Splintertree Post accept:25",
			"Night Run <test/05 2> turnin:6382 accept:6383 turnin:6383",
			"Senani Thunderheart goto accept:23 accept:24",
			"Night Run turnin:23 turnin:24 turnin:25",
		])
	);
	assert_eq!(far["hidden"], json!([6621]));
	assert_eq!(far["requires"], json!(["Requires Off the Route first"]));
	// In another zone: the same.
	let other = run("", ELSEWHERE, &format!("{OPEN}\nemit(r)"));
	assert_eq!(other["hidden"], json!([6621]));
}

#[test]
fn a_player_who_did_the_route_gets_the_guide_as_written() {
	let out = run("w.complete({ 6382, 6383, 216, 98 }); w.abandon(6382)\n", NEAR, &format!("{OPEN}\nemit(r)"));
	assert_eq!(json!([out["feeders"], out["shape"].as_array().unwrap().len()]), json!([0, 5]));
	assert_eq!(out["hidden"].as_array().map_or(0, |a| a.len()), 0);
	assert_eq!(out["requires"].as_array().map_or(0, |a| a.len()), 0);
}

#[test]
fn done_feeder_steps_move_on_a_skipped_one_keeps_its_quests_skipped_at_the_next_open() {
	let out = run(
		"",
		NEAR,
		&format!(
			r#"{OPEN}
		-- The furbolg chain: taken, then its kills skipped.
		stub.world.accept(216, {{ 8 }}, "Between a Rock and a Thistlefur"); stub.fire("QUEST_LOG_UPDATE"); flush()
		r.after = E.GetStepIndex()
		E.Skip(); flush()
		r.feedSkips = PolestarCharDB.feedSkips and PolestarCharDB.feedSkips[216] or false
		-- Opened again: the chain the player skipped stays out; King of the Foulweald stays.
		E.SetGuide("test/04"); flush(); E.SetGuide("test/07"); flush()
		r.again = shape()
		r.karang = brief(5)
		emit(r)"#
		),
	);
	assert_eq!(out["after"], 2, "taken: on to the kills");
	assert_eq!(out["feedSkips"], true);
	assert_eq!(
		out["again"],
		json!([
			"Zoram'gar Outpost accept:6442 accept:99",
			"Splintertree Post accept:25",
			"Night Run <test/05 2> turnin:6382 accept:6383 turnin:6383",
			"Senani Thunderheart goto accept:23 accept:24",
			"Karang Amakkar goto accept:6621",
			"Night Run turnin:23 turnin:24 turnin:25",
		])
	);
	// King of the Foulweald is not left out; with Between a Rock and a Thistlefur in the log it stays open
	// (a held prerequisite counts as coming, #1372).
	assert_eq!(out["karang"][1], "pending:nil");
}

#[test]
fn the_report_names_the_planned_steps_and_the_quests_left_out() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::name("Polestar")],
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
FUR = {{ {FAR} }}
{GUIDES}
{HELPERS}
E.SetGuide("test/07"); flush()
E.Goto(3); flush()
emit({{ text = table.concat(Polestar.UI.Report.Details().lines, "\n") }})"#
		),
		..Default::default()
	})
	.remove(0);
	let text = out["text"].as_str().unwrap_or("");
	assert!(text.contains("[planned: 1 feeder steps, ~0 min]"), "{text}");
	assert!(text.contains("King of the Foulweald [hidden: needs Between a Rock and a Thistlefur from Ashenvale & Silverpine Forest]"), "{text}");
	// After the Detour waits on a quest no guide of the route gives: a gap of the route, not left out.
	assert!(!text.contains("After the Detour [hidden"), "{text}");
	assert!(text.contains("[feeder from test/05 step 2]"), "{text}");
}

#[test]
fn saved_tabs_get_their_plan_once_the_quest_log_is_in_with_their_skips_carried_along() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![(
			"Polestar".to_string(),
			r#"PolestarCharDB = { schema = 1, tabs = { "test/07" }, activeTab = 1, skipped = { ["test/07"] = { [2] = true } } }"#.to_string(),
		)],
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
FUR = {{ {NEAR} }}
{GUIDES}
E = Polestar.Engine
stub.login(); stub.advance(0.25)
local before = E.GetStepCount()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.25)
emit({{ before = before, after = E.GetStepCount(), first = E.GetStepView(1).title, skipped = PolestarCharDB.skipped["test/07"] }})"#
		),
		..Default::default()
	})
	.remove(0);
	assert_eq!(json!([out["before"], out["after"], out["first"]]), json!([5, 9, "Zoram'gar Outpost"]));
	// The guide's own Splintertree Post, skipped before as step 2, is still the one skipped (now step 5).
	assert_eq!(out["skipped"], json!({ "5": true }));
}

const MALIFAX_DONE: &str = "264, 421, 425, 428, 429, 430, 435, 437, 438, 439, 440, 443, 449, 460, 461, 477, 478, 479, 481, 482, 516, 743,
	744, 745, 746, 747, 748, 749, 750, 751, 752, 753, 754, 755, 756, 757, 758, 759, 760, 761, 763, 764, 765, 766,
	767, 771, 772, 773, 775, 780, 781, 819, 833, 843, 844, 845, 846, 848, 849, 850, 851, 852, 855, 858, 860, 861,
	863, 865, 867, 868, 869, 870, 871, 872, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888,
	890, 891, 892, 893, 894, 895, 896, 898, 899, 900, 901, 902, 903, 905, 906, 907, 913, 1492, 1656, 3221, 3261,
	3281, 3301, 3376, 3921, 3922, 3923, 4921, 5041, 5052, 91920, 91921, 95494, 95495, 95507, 95508, 95621, 95774,
	95805, 95981, 96130, 96605, 96659, 96661, 97242, 97246, 97249, 97253, 97275, 97326, 97485, 98093, 98424,
	98430, 98435, 99079, 99080, 99081, 99082, 99101, 99108, 99411";
const WETLANDS_DONE: &str = "9, 12, 13, 14, 20, 22, 36, 38, 56, 57, 64, 65, 66, 89, 92, 95, 101, 102, 125, 127, 128, 129, 130, 131, 133, 148, 149, 150, 151, 153, 154, 156, 157, 158, 159, 164, 165, 170, 179, 182, 183, 184, 218, 219, 226, 230, 233, 234, 244, 245, 246, 262, 265, 266, 268, 282, 287, 291, 308, 310, 311, 312, 313, 315, 317, 318, 319, 320, 384, 400, 403, 412, 413, 417, 419, 420, 432, 433, 453, 729, 731, 944, 947, 948, 949, 950, 951, 953, 954, 955, 956, 957, 958, 963, 965, 966, 982, 983, 984, 985, 986, 993, 994, 1001, 1002, 1003, 1138, 1141, 2098, 2118, 2138, 2139, 2160, 3361, 3364, 3365, 3524, 4681, 4722, 4723, 4725, 4727, 4728, 4730, 4731, 4732, 4733, 4740, 4761, 4762, 4763, 4811, 4812, 4813, 5541, 87760, 92742, 92744, 92745, 92747, 92748, 92909, 92910, 95065, 95212, 95213, 95214, 95217, 96139, 96390, 96391, 96392, 96408, 96608, 96628, 96629, 97263, 97277, 97914, 98013, 98025, 98042, 98319, 98321, 98322, 98323, 98326, 98386, 98407, 99158, 99159, 99160, 99161, 99162";
const WETLANDS_LOG: &str = "945, 968, 98461, 967, 990, 97926, 173, 174, 337, 134, 323";

// Joe: a Tauren Warrior at 24 who played only Mulgore (forever/horde/tauren/01-mulgore's hand-ins) and loads
// The Barrens & Stonetalon Mountains (24-26).
const JOE_DONE: &str = "743, 744, 745, 746, 747, 748, 749, 750, 751, 752, 753, 754, 755, 756, 757, 758, 759, 760, 761, 763, 764, 765, 766, 767, 771, 772, 773, 775, 780, 781, 833, 860, 861, 886, 1656, 3376, 95805, 96130, 96605, 96659, 96661, 97485, 98424, 98430, 98435, 99079, 99080, 99081, 99082, 99101, 99108, 99411";

fn shipped(faction: &str, race: &str, class: &str, level: u32, done: &str, log: &str, guide: &str) -> Value {
	let dir = forge_addontest::run::addons_dir();
	let part = format!("Polestar_Guides_{faction}");
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!(
			r#"local w = stub.world
w.race, w.faction, w.class, w.className, w.level = "{race}", "{faction}", "{class}", "{class}", {level}
w.complete({{ {done} }})
for _, q in ipairs({{ {log} }}) do w.onQuest(q, {{ 1 }}) end"#
		),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"]), Addon::dir("Polestar_Guides", dir.join("Polestar_Guides")), Addon::dir(&part, dir.join(&part))],
		script: format!(
			r#"
E = Polestar.Engine
-- The client's maps as the pack has them (the stub world knows none).
for id, b in pairs(Polestar.MapFrames.era) do stub.world.addMap(id, b) end
stub.login(); stub.advance(0.25)
Polestar.Set("behavior.autoAccept", false)
-- Opened before the quest log is in: the guide as written; then the log, and the plan.
E.SetGuide("{guide}"); stub.advance(0.25)
local function look()
	local g = E.GetGuide()
	local accepts, requires, empty, seen = 0, {{}}, 0, {{}}
	for i = 1, E.GetStepCount() do
		local v = E.GetStepView(i)
		if #g.steps[i].goals == 0 then empty = empty + 1 end
		for gi, goal in ipairs(g.steps[i].goals) do
			if goal.t == "accept" and E.Applies(i, gi) and not seen[goal.quest] then
				seen[goal.quest] = true
				accepts = accepts + 1
				local u = v.goals[gi]
				if u and u.unavailable == "pre" then requires[#requires + 1] = goal.quest end
			end
		end
	end
	table.sort(requires)
	return {{ steps = E.GetStepCount(), accepts = accepts, requires = requires, empty = empty }}
end
local before = look()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.25)
local after, g = look(), E.GetGuide()
local own = {{}}
for i, step in ipairs(g.steps) do
	if not step.feeder then for _, goal in ipairs(step.goals) do if goal.map then own[goal.map] = true end end end
end
local feeders, outside, hidden = {{}}, 0, {{}}
for i, step in ipairs(g.steps) do
	if step.feeder then
		local q = {{}}
		for _, goal in ipairs(step.goals) do
			q[#q + 1] = goal.t .. ":" .. tostring(goal.quest)
			if goal.map and not own[goal.map] then outside = outside + 1 end
		end
		feeders[#feeders + 1] = i .. " " .. step.title .. " [" .. step.feeder .. " " .. step.feederStep .. "] " .. table.concat(q, " ")
	end
end
for q in pairs(g.hidden or {{}}) do hidden[#hidden + 1] = q end
table.sort(hidden)
emit({{ guide = g.title, before = before, after = after, feeders = feeders, outside = outside, hidden = hidden, cost = g.feedCost or 0 }})"#
		),
		..Default::default()
	})
	.remove(0)
}

// A Lua list (an empty one comes out as {}).
fn ids(v: &Value) -> Vec<u64> {
	v.as_array().map(|a| a.iter().map(|x| x.as_u64().unwrap()).collect()).unwrap_or_default()
}

fn lines(v: &Value) -> Vec<String> {
	v.as_array().map(|a| a.iter().map(|x| x.as_str().unwrap().to_string()).collect()).unwrap_or_default()
}

#[test]
fn t_1353_joe_fresh_at_24_in_the_barrens_and_stonetalon_mountains_gets_a_clean_guide() {
	let out = shipped("Horde", "Tauren", "WARRIOR", 24, JOE_DONE, "264", "forever/horde/04-the-barrens");
	println!("{}", serde_json::to_string_pretty(&out).unwrap());
	assert_eq!(out["guide"], "The Barrens & Stonetalon Mountains");
	let before = ids(&out["before"]["requires"]);
	assert!(!before.is_empty(), "a fresh start had accepts passed: {before:?}");
	// After: every such accept either opened by a local feeder or left out; no feeder outside the guide's
	// zones; no empty step.
	let after = ids(&out["after"]["requires"]);
	let hidden = ids(&out["hidden"]);
	assert!(after.len() < before.len(), "{out}");
	for q in &hidden {
		assert!(!after.contains(q), "{q} is left out, never shown as Requires");
	}
	assert_eq!(out["outside"], 0);
	assert_eq!(out["after"]["empty"], 0);
	assert!(out["cost"].as_f64().unwrap() <= 300.0 * lines(&out["feeders"]).len().max(1) as f64);
}

#[test]
fn t_1353_malifax_and_a_player_who_did_the_route_on_the_shipped_ashenvale() {
	let out = shipped("Horde", "Tauren", "PALADIN", 26, MALIFAX_DONE, "6382", "forever/horde/07-ashenvale");
	println!("{}", serde_json::to_string_pretty(&out).unwrap());
	let before = ids(&out["before"]["requires"]);
	for q in [2, 23, 24, 6621] {
		assert!(before.contains(&q), "{q} was passed: {before:?}");
	}
	let after = ids(&out["after"]["requires"]);
	for q in [2, 23, 24, 6621] {
		assert!(!after.contains(&q), "{q} is no longer shown as Requires: {after:?}");
	}
	assert_eq!(out["outside"], 0);
	assert_eq!(out["after"]["empty"], 0);

	// A player who did the route: the guide as written.
	let normal = shipped("Horde", "Tauren", "PALADIN", 26, &format!("{MALIFAX_DONE}, 6382, 6383, 216"), "", "forever/horde/07-ashenvale");
	assert!(lines(&normal["feeders"]).is_empty() && ids(&normal["hidden"]).is_empty(), "{normal}");
	assert_eq!(normal["after"], normal["before"]);
}

#[test]
fn t_1353_the_alliance_wetlands_for_a_0_3_4_character_through_duskwood() {
	let out = shipped("Alliance", "Dwarf", "WARRIOR", 27, WETLANDS_DONE, WETLANDS_LOG, "forever/alliance/06-wetlands");
	println!("{}", serde_json::to_string_pretty(&out).unwrap());
	assert!(ids(&out["after"]["requires"]).len() < ids(&out["before"]["requires"]).len());
	assert_eq!(out["outside"], 0);
	assert_eq!(out["after"]["empty"], 0);
}
