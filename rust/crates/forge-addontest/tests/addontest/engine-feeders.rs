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
	assert_eq!(out["requires"], json!(["Requires “Off the Route” first"]));
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
	assert_eq!(far["requires"], json!(["Requires “Off the Route” first"]));
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
		saved: vec![("Polestar".to_string(), r#"PolestarCharDB = { schema = 1, tabs = { "test/07" }, activeTab = 1, skipped = { ["test/07"] = { [2] = true } } }"#.to_string())],
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
	shipped_with(faction, race, class, level, done, log, guide, "")
}

// `extra`: Lua run after login, before the quest log is in (stubs for the Codex, ...).
#[allow(clippy::too_many_arguments)]
fn shipped_with(faction: &str, race: &str, class: &str, level: u32, done: &str, log: &str, guide: &str, extra: &str) -> Value {
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
{extra}
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
local collects = {{}}
for _, step in ipairs(g.steps) do
	for _, goal in ipairs(step.goals) do if goal.t == "collect" and not goal.quest and goal.item then collects[#collects + 1] = goal.item end end
end
emit({{ guide = g.title, before = before, after = after, feeders = feeders, outside = outside, hidden = hidden, collects = collects, cost = g.feedCost or 0 }})"#
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
	// The hunt trophies (2, 23, 24) wait in the guide itself for The Ashenvale Hunt (`when turnedin 6383`, #1531,
	// 58d54acf1): never a Requires line, before the plan or after. 6621 still needs the plan.
	assert!(before.contains(&6621), "6621 was passed: {before:?}");
	for q in [2, 23, 24] {
		assert!(!before.contains(&q), "{q} waits in the guide, no Requires line: {before:?}");
	}
	let after = ids(&out["after"]["requires"]);
	for q in [2, 23, 24, 6621] {
		assert!(!after.contains(&q), "{q} is no longer shown as Requires: {after:?}");
	}
	assert_eq!(out["outside"], 0);
	assert_eq!(out["after"]["empty"], 0);
	// #1531: a quest left out goes with the item it starts from (Ursangous's Paw 16303 for 23, Shadumbra's Head
	// 16304 for 24, Sharptalon's Claw 16305 for 2): no kill for an item only a hidden quest wants.
	let hidden = ids(&out["hidden"]);
	let collects = ids(&out["collects"]);
	for (q, item) in [(23, 16303), (24, 16304), (2, 16305)] {
		if hidden.contains(&q) {
			assert!(!collects.contains(&item), "{item} is collected for {q}, which is left out: {out}");
		}
	}

	// A player who did the route: the guide as written.
	let normal = shipped("Horde", "Tauren", "PALADIN", 26, &format!("{MALIFAX_DONE}, 6382, 6383, 216"), "", "forever/horde/07-ashenvale");
	assert!(lines(&normal["feeders"]).is_empty() && ids(&normal["hidden"]).is_empty(), "{normal}");
	assert_eq!(normal["after"], normal["before"]);
}

// The fresh-start sweep (EngineReview036, 0.3.6): an Orc 39 loading Stranglethorn Vale (Horde 40-50) with no
// earlier guides got Bloody Bone Necklace (596) put in as a local feeder for Split Bone Necklace (598), which
// also needs The Vile Reef (629): the plan followed only the first missing prerequisite, so 598 still read
// "Requires The Vile Reef" on its accept, its skulls and its hand-in, and the feeder opened nothing. Same for Big
// Game Hunter (208: 188, 193 and 197). An accept opens only once every missing prerequisite is put in; else it
// is left out, and a chain no accept can use stays out.
//
// And every accept the plan keeps opens in time: Mok'thardin's Enchantment's follow-ups (571, 573) and Panther
// Mastery (193) read "Requires … first" with their chains planned, because the chains' steps went in after them:
// a step another chain had put in later was shared, and the guide's own hand-in of Panther Mastery (192) came
// before the chain's accept of it.
#[test]
fn an_accept_missing_several_prerequisites_is_planned_for_all_of_them_or_left_out() {
	let out = shipped("Horde", "Orc", "WARRIOR", 39, "", "", "forever/horde/40-50/01-stranglethorn-vale");
	let after = ids(&out["after"]["requires"]);
	for q in [598, 208] {
		assert!(!after.contains(&q), "{q} never shows as Requires: {out}");
	}
	let hidden = ids(&out["hidden"]);
	let feeders = lines(&out["feeders"]).join("\n");
	if hidden.contains(&598) {
		assert!(!feeders.contains("accept:596"), "no feeder for 598 when 598 is left out: {out}");
	}
	// No route gap here (every missing chain is in an earlier guide): nothing reads "Requires".
	assert!(after.is_empty(), "{out}");
}

#[test]
fn t_1353_the_alliance_wetlands_for_a_0_3_4_character_through_duskwood() {
	let out = shipped("Alliance", "Dwarf", "WARRIOR", 27, WETLANDS_DONE, WETLANDS_LOG, "forever/alliance/06-wetlands");
	println!("{}", serde_json::to_string_pretty(&out).unwrap());
	assert!(ids(&out["after"]["requires"]).len() < ids(&out["before"]["requires"]).len());
	assert_eq!(out["outside"], 0);
	assert_eq!(out["after"]["empty"], 0);
}

// A quest held for the player's answer (it left the log after the route had passed its accept, #1365) is
// stored with the step the route was on. The plan rebuilding the guide's steps moves that number along with
// the saved ticks: steps put in before it shift it, and the held accept stays held, its giver the arrow's.
const LOST_SAVED: &str = r#"PolestarCharDB = { schema = 1, tabs = { "test/07" }, activeTab = 1, lostQuests = { ["test/07"] = { [25] = 3 } } }"#;

fn run_lost(saved: Option<&str>, before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}w.onQuest(6442, {{ 0 }})\n{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
FUR = {{ {NEAR} }}
{GUIDES}
E = Polestar.Engine
function flush() stub.advance(0.25) end
function lost()
	local q = E.LostQuestion()
	local wp = E.GetWaypoint()
	local held = PolestarCharDB.lostQuests and PolestarCharDB.lostQuests["test/07"]
	return {{ q = q or false, upTo = held and held[25] or false, arrow = wp and {{ x = wp.x, y = wp.y }} or false,
		step = held and held[25] and E.GetStepView(held[25]).title or false }}
end
stub.login(); flush()
{script}"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_lost_quest_held_before_the_plan_keeps_its_step_and_the_arrow_on_its_giver() {
	// Saved last session against the guide as written (Senani Thunderheart, step 3); the plan puts the
	// furbolg chain first and the hunt after Splintertree Post, so Senani is step 7 now.
	let out = run_lost(
		Some(LOST_SAVED),
		"",
		r#"stub.fire("QUEST_LOG_UPDATE"); flush()
emit(lost())"#,
	);
	assert_eq!(out["q"], 25);
	assert_eq!(out["upTo"], 7);
	assert_eq!(out["step"], "Senani Thunderheart");
	assert_eq!(out["arrow"], json!({ "x": 73, "y": 61 }), "the arrow leads to Stonetalon Standstill's giver");
}

#[test]
fn a_lost_quest_held_while_a_guide_is_open_follows_the_steps_when_it_is_planned_again() {
	// Every feeder done but the hunt's, which the plan puts in; Stonetalon Standstill taken, then abandoned
	// with the route at Senani: held there. Opened again with the hunt done, the hunt's steps go: the held
	// step moves back with Senani.
	let out = run_lost(
		None,
		"w.complete({ 216 })\nw.onQuest(25, { 0 })\n",
		r#"Polestar.Set("behavior.autoAccept", false)
stub.fire("QUEST_LOG_UPDATE"); flush()
E.SetGuide("test/07"); flush()
local senani
for i = 1, E.GetStepCount() do if E.GetStepView(i).title == "Senani Thunderheart" then senani = i end end
stub.world.turnIn(6382); stub.world.complete({ 6383 }); stub.fire("QUEST_LOG_UPDATE"); flush()
local live = E.GetLiveStep()
stub.world.abandon(25); flush()
local first = lost()
E.SetGuide("test/04"); flush(); E.SetGuide("test/07"); flush()
emit({ senani = senani, live = live, first = first, again = lost(), steps = E.GetStepCount() })"#,
	);
	assert_eq!(out["live"], out["senani"], "the route is at Senani when Stonetalon Standstill leaves the log");
	assert_eq!(out["first"]["upTo"], out["senani"]);
	assert_eq!(out["steps"], 5, "the hunt's steps went");
	assert_eq!(out["again"]["upTo"], 3);
	assert_eq!(out["again"]["step"], "Senani Thunderheart");
	assert_eq!(out["again"]["q"], 25);
	assert_eq!(out["again"]["arrow"], json!({ "x": 73, "y": 61 }));
}

// #1442: a prerequisite whose every step in the guide is for other races (Washed Ashore in Darkshore, `only`
// the races that did not play the Night Elf's own Darkshore guide) is not "coming" for a character who can
// take it: the follow-up (Beached Sea Turtle) waits on it. Another race's own version of a chain (the quest
// data closes it to the character) still leaves the follow-up to its giver.
const DARKSHORE: &str = r#"
local D = 1439
local OTHERS = { races = { "Human", "Dwarf", "Gnome" } }
Polestar.RegisterGuide({ id = "test/ds", pack = "test", title = "Darkshore", faction = "Alliance", minLevel = 15, maxLevel = 19, steps = {
	{ title = "Auberdine", goals = { { t = "accept", quest = 4681, title = "Washed Ashore", only = OTHERS, map = D, x = 37, y = 44 } } },
	{ title = "The skeletal turtle", goals = { { t = "turnin", quest = 4681, title = "Washed Ashore", only = OTHERS, map = D, x = 36, y = 70 } } },
	{ title = "Cliffspring Falls", goals = {
		{ t = "accept", quest = 4727, title = "Beached Sea Turtle", pre = { 4681 }, preTitles = { [4681] = "Washed Ashore" }, map = D, x = 53, y = 18 },
		{ t = "accept", quest = 999, title = "Fine Crab Chunks", map = D, x = 53, y = 18 },
	} },
} })
"#;

// An earlier guide that gives Washed Ashore to the Night Elf, far from Darkshore's steps.
const NE_DARKSHORE: &str = r#"
Polestar.RegisterGuide({ id = "test/nds", pack = "test", title = "Darkshore (Night Elf)", faction = "Alliance", minLevel = 12, maxLevel = 14, next = "test/ds", steps = {
	{ title = "Far away", goals = { { t = "accept", quest = 4681, title = "Washed Ashore", map = 1429, x = 50, y = 50 } } },
	{ title = "Far away", goals = { { t = "turnin", quest = 4681, title = "Washed Ashore", map = 1429, x = 50, y = 50 } } },
} })
"#;

fn darkshore(race: &str, races: &str, guides: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!(
			r#"local w = stub.world
w.addMap(1439, {{ name = "Darkshore", c = 1, left = 1000, right = -1000, top = 1000, bottom = -3000 }})
w.addMap(1429, {{ name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }})
w.moveTo(1439, 53, 18)
w.race, w.raceName, w.faction, w.class, w.className, w.level = "{race}", "{race}", "Alliance", "HUNTER", "Hunter", 17"#
		),
		addons: vec![Addon::name("Polestar")],
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
{DARKSHORE}
{guides}
E = Polestar.Engine
-- The Codex's records: Washed Ashore's races ({races}: nil = everyone).
Polestar.Codex.Quest = function(id) return {{ id = id, title = "Quest " .. id, faction = "A", races = {races} }} end
stub.login(); stub.advance(0.25)
Polestar.Set("behavior.autoAccept", false)
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.25)
E.SetGuide("test/ds"); stub.advance(0.25)
local out, g = {{}}, E.GetGuide()
for i = 1, E.GetStepCount() do
	local v = E.GetStepView(i)
	for k, goal in ipairs(g.steps[i].goals) do
		if goal.quest == 4727 or goal.quest == 999 then out[#out + 1] = goal.quest .. ":" .. v.goals[k].status .. ":" .. tostring(v.goals[k].unavailableText) end
	end
end
local hidden = {{}}
for q in pairs(g.hidden or {{}}) do hidden[#hidden + 1] = q end
emit({{ goals = out, hidden = hidden }})"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn t_1442_a_prerequisite_the_guide_has_only_for_other_races_is_missing_for_a_character_who_can_take_it() {
	let ne = darkshore("NightElf", "nil", "");
	assert_eq!(ne["goals"], json!(["4727:skipped:Requires “Washed Ashore” first", "999:active:nil"]), "{ne}");
	// A Human has Washed Ashore in the guide: Beached Sea Turtle waits on the route, not passed.
	let human = darkshore("Human", "nil", "");
	assert_eq!(human["goals"][0], "4727:pending:nil", "{human}");
	// Washed Ashore closed to Night Elves by the quest data (another race's version): left to the giver.
	let other = darkshore("NightElf", "69", "");
	assert_eq!(other["goals"][0], "4727:active:nil", "{other}");
	// The Night Elf's own earlier guide gives it, far away: the catch-up leaves Beached Sea Turtle out.
	let planned = darkshore("NightElf", "nil", NE_DARKSHORE);
	assert_eq!(planned["goals"], json!(["999:active:nil"]), "{planned}");
	assert_eq!(planned["hidden"], json!([4727]));
}

// #1442 on the shipped Darkshore (03-darkshore, 15-19) for a Night Elf Hunter at 17. The guide's Washed Ashore,
// How Big a Threat? and Plagued Lands steps are for the other races (a Night Elf does them in its own
// Darkshore guide); the Codex is stubbed to say every quest is the character's (they are open to every
// Alliance race). NE_TELDRASSIL: Teldrassil's hand-ins; NE_DARKSHORE: also the Night Elf's own Darkshore.
const NE_TELDRASSIL: &str = "456, 457, 458, 459, 475, 476, 483, 486, 487, 488, 489, 490, 916, 917, 918, 919, 920, 921, 922, 923, 928, 929, 930, 931, 932, 933, 935, 937, 938, 940, 997, 2159, 2399, 2438, 2459, 2518, 2519, 2520, 2541, 2561, 3519, 3521, 3522, 3524, 4161, 4495, 6341, 6342, 6343, 6344, 7383, 87288, 96606, 96630, 96634, 97236, 97977, 97979, 98046, 98065, 98067, 98391, 98392, 98398, 99046, 99047, 99050, 99053, 99073";
const NE_TELDRASSIL_LOG: &str = "952, 98025, 954, 958, 1141";
const NE_DARKSHORE_DONE: &str = "40, 456, 457, 458, 459, 475, 476, 483, 486, 487, 488, 489, 490, 916, 917, 918, 919, 920, 921, 922, 923, 928, 929, 930, 931, 932, 933, 935, 937, 938, 940, 953, 954, 955, 956, 957, 958, 984, 985, 997, 1141, 2118, 2159, 2399, 2438, 2459, 2518, 2519, 2520, 2541, 2561, 3519, 3521, 3522, 3524, 4161, 4495, 4681, 4722, 4723, 4728, 4811, 4812, 4813, 6341, 6342, 6343, 6344, 7383, 87288, 96606, 96630, 96634, 97220, 97222, 97236, 97977, 97979, 98025, 98046, 98065, 98067, 98391, 98392, 98398, 99046, 99047, 99050, 99053, 99073";
const NE_DARKSHORE_LOG: &str = "952, 983, 399, 35";
const ALL_MINE: &str = "Polestar.Codex = { Quest = function(id) return { id = id } end }\nPolestar.Lookup = { QuestBlock = function() return nil end }";

#[test]
fn t_1442_darkshore_s_follow_ups_for_a_night_elf_who_skipped_its_own_darkshore_are_never_shown_as_ready() {
	// Washed Ashore, How Big a Threat? and Plagued Lands neither done nor in the log.
	let out = shipped_with("Alliance", "NightElf", "HUNTER", 17, NE_TELDRASSIL, NE_TELDRASSIL_LOG, "forever/alliance/03-darkshore", ALL_MINE);
	// Before the plan: Cleansing of the Infected, Thundris Windweaver and what follows wait on Plagued Lands and
	// How Big a Threat? ("Requires … first", no longer "Accept"), whose steps in this guide are for the other
	// races. (Washed Ashore is in the guide for every race since #1442's guide fix, so Beached Sea Turtle
	// waits on nothing.) After: the Night Elf's own Darkshore steps for them go in, all in Darkshore, and
	// nothing waits.
	let before = ids(&out["before"]["requires"]);
	for q in [2138, 4761] {
		assert!(before.contains(&q), "{q} waits on its prerequisite: {before:?}");
	}
	assert!(ids(&out["after"]["requires"]).is_empty(), "{out}");
	let feeders = lines(&out["feeders"]);
	assert!(!feeders.is_empty() && feeders.iter().all(|f| f.contains("[forever/alliance/nightelf/")), "{feeders:?}");
	assert!(feeders.iter().any(|f| f.contains("2118")) && feeders.iter().any(|f| f.contains("984")), "{feeders:?}");

	// A Night Elf who played its own Darkshore: the guide as written, nothing waiting.
	let route = shipped_with("Alliance", "NightElf", "HUNTER", 17, NE_DARKSHORE_DONE, NE_DARKSHORE_LOG, "forever/alliance/03-darkshore", ALL_MINE);
	assert!(lines(&route["feeders"]).is_empty() && ids(&route["hidden"]).is_empty(), "{route}");
}

// Dungeon runs and group content are never feeders. An earlier guide (test/d1) does The Deep Fathoms (7001),
// its steps' `when` WHEN (a dungeon run, or a group quest's question) and its goals' compiled `group` GROUP (KILL
// on the kill alone); the guide after it (test/d2) takes After the Deeps (7002), which needs it, and Naga Scales
// (7003), which needs nothing. Every place is a few yards from the guide's own stop, so only the guard keeps the
// chain out: the copy of a step leaves its `when` behind, and the cost of a dungeon run, its objective at the
// door, reads as a short walk.
const DEEPS: &str = r#"
local A = 1440
local function at(t) t.map, t.x, t.y = A, t.x or 70, t.y or 66 return t end
Polestar.RegisterGuide({ id = "test/d1", pack = "test", title = "Ashenvale Shore", faction = "Horde", minLevel = 20, maxLevel = 22, next = "test/d2", steps = {
	{ title = "Zoram'gar Outpost", when = WHEN, goals = { at({ t = "accept", quest = 7001, title = "The Deep Fathoms", qlvl = 24, group = GROUP }) } },
	{ title = "The Deeps", when = WHEN, goals = { at({ t = "kill", quest = 7001, oi = 1, target = "Twilight Lord", count = 1, x = 71, y = 64, group = KILL or GROUP }) } },
	{ title = "Zoram'gar Outpost", when = WHEN, goals = { at({ t = "turnin", quest = 7001, title = "The Deep Fathoms", group = GROUP }) } },
} })
Polestar.RegisterGuide({ id = "test/d2", pack = "test", title = "Ashenvale Coast", faction = "Horde", minLevel = 22, maxLevel = 26, steps = {
	{ title = "Zoram'gar Outpost", goals = { at({ t = "accept", quest = 7003, title = "Naga Scales", qlvl = 24 }) } },
	{ title = "Zoram'gar Outpost", goals = { at({ t = "accept", quest = 7002, title = "After the Deeps", pre = { 7001 }, qlvl = 24 }) } },
	{ title = "Zoram'gar Outpost", goals = { at({ t = "turnin", quest = 7002, title = "After the Deeps" }), at({ t = "turnin", quest = 7003, title = "Naga Scales" }) } },
} })
"#;

const RUN: &str = r#"WHEN = { { k = "dungeon", name = "Blackfathom Deeps", map = 221 } }; GROUP = { kind = "dungeon", name = "Blackfathom Deeps", map = 221 }"#;

// The guide after the chain, opened by a character fresh at 26 (`chosen`: they run Blackfathom Deeps).
fn deeps(setup: &str, chosen: bool) -> Value {
	let choose = if chosen { "E.ChooseDungeon(221, true)\n" } else { "" };
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
{setup}
{DEEPS}
{HELPERS}
{choose}E.SetGuide("test/d2"); flush()
local g = E.GetGuide()
local r = {{ shape = shape(), feeders = g.feeders or 0, hidden = {{}} }}
for q in pairs(g.hidden or {{}}) do r.hidden[#r.hidden + 1] = q end
table.sort(r.hidden)
emit(r)"#
		),
		..Default::default()
	})
	.remove(0)
}

// (feeder steps put in, quests left out)
fn planned(out: &Value) -> (u64, Vec<u64>) {
	(out["feeders"].as_u64().unwrap_or(0), ids(&out["hidden"]))
}

#[test]
fn a_dungeon_run_s_steps_are_never_feeders_and_what_needs_them_stays_left_out() {
	// The same chain as plain quests: a cheap local feeder, After the Deeps open.
	let plain = deeps("WHEN, GROUP, KILL = nil, nil, nil", false);
	assert_eq!(planned(&plain), (3, vec![]), "{plain}");
	// A character who skips Blackfathom Deeps: none of the run's steps is copied in; After the Deeps is left out.
	let skip = deeps(RUN, false);
	assert_eq!(planned(&skip), (0, vec![7002]), "{skip}");
	assert!(!lines(&skip["shape"]).iter().any(|s| s.contains("<test/d1")), "{skip}");
	// One who runs it: still no feeder (a dungeon quest is group content), After the Deeps still left out.
	let run = deeps(RUN, true);
	assert_eq!(planned(&run), (0, vec![7002]), "{run}");
}

#[test]
fn a_chain_with_a_group_quest_or_an_elite_objective_is_never_a_feeder() {
	// A group quest by its steps' question (`when group`), unanswered: the source guide asks first; no copy.
	let asked = deeps(r#"WHEN = { { k = "group", q = 7001 } }; GROUP, KILL = nil, nil"#, false);
	assert_eq!(planned(&asked), (0, vec![7002]), "{asked}");
	let elite = deeps(r#"WHEN, GROUP = nil, nil; KILL = { kind = "elite", rank = 1, lvl = 25 }"#, false);
	assert_eq!(planned(&elite), (0, vec![7002]), "{elite}");
}
