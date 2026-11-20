//! A hand-in of a quest the player carries from an earlier guide, which the guide never works, gets that work
//! back before the hand-in while the quest is unfinished (Engine.lua, Own.workChains in Own.feederPlan). #2871
//! (Shuurajou, Gnome Priest 28, 0.4.1): Wetlands sent them to hand in Fire Taboo at Rethiel the Greenwarden with
//! none of its nine Crude Flint; Ashenvale & Wetlands, the guide before, gets the flint on its Wetlands visit.
//! #2792 (Petsq, Undead Mage 43, 0.4.0.1): Stranglethorn Vale 40-50 sent them to hand in Panther Mastery at
//! Nesingwary's camp with no step for the panthers, which Stranglethorn Vale 30-40 kills. 72 more hand-ins in the
//! leveling guides have the same shape: one engine rule instead of a step in each guide. The guides below are those
//! reports' shape (the work only in the guide before); the shipped guides now also carry their own steps for these
//! two. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1437, { name = "Wetlands", c = 0, left = 1000, right = -1000, top = 1000, bottom = -3000 })
w.addMap(1434, { name = "Stranglethorn Vale", c = 0, left = 4000, right = 2000, top = -3000, bottom = -7000 })
w.titles[277] = "Fire Taboo"; w.titles[192] = "Panther Mastery"; w.titles[464] = "War Banners"; w.titles[201] = "Investigate the Camp"
"#;

const GUIDES: &str = r#"
local W, S = 1437, 1434
Polestar.RegisterGuide({ id = "test/ashenvale", pack = "test", title = "Ashenvale & Wetlands", faction = "Alliance", minLevel = 20, maxLevel = 25, next = "test/wetlands", steps = {
	{ title = "Menethil Harbor", goals = { { t = "accept", quest = 277, title = "Fire Taboo", map = W, x = 10.8, y = 59.6 } } },
	{ title = "Mosshide gnolls", goals = {
		{ t = "collect", item = 2611, itemName = "Crude Flint", count = 9, quest = 277, oi = 1, map = W, x = 51.2, y = 30.9 },
		{ t = "accept", quest = 464, title = "War Banners", map = W, x = 49.4, y = 46.8 },
	} },
} })
Polestar.RegisterGuide({ id = "test/wetlands", pack = "test", title = "Wetlands", faction = "Alliance", minLevel = 25, maxLevel = 28, steps = {
	{ title = "Angerfang Encampment", goals = { { t = "goto", map = W, x = 49.4, y = 46.8 } } },
	{ title = "Rethiel the Greenwarden", goals = { { t = "turnin", quest = 277, title = "Fire Taboo", map = W, x = 56.3, y = 40.4 } } },
} })
Polestar.RegisterGuide({ id = "test/stv30", pack = "test", title = "Stranglethorn Vale", faction = "Horde", minLevel = 30, maxLevel = 40, next = "test/stv40", steps = {
	{ title = "Nesingwary's Expedition", goals = { { t = "accept", quest = 192, title = "Panther Mastery", map = S, x = 35.6, y = 10.8 } } },
	{ title = "Stranglethorn Vale: kill these as you meet them", goals = {
		{ t = "kill", target = "Shadowmaw Panther", npc = 684, count = 10, quest = 192, oi = 1, map = S, x = 41.3, y = 34.8 },
	} },
} })
Polestar.RegisterGuide({ id = "test/stv40", pack = "test", title = "Stranglethorn Vale", faction = "Horde", minLevel = 40, maxLevel = 50, steps = {
	{ title = "Venture Co. Base Camp", goals = { { t = "accept", quest = 201, title = "Investigate the Camp", map = S, x = 43.9, y = 20.0 } } },
	{ title = "Nesingwary's Expedition", goals = { { t = "turnin", quest = 192, title = "Panther Mastery", map = S, x = 35.6, y = 10.8 } } },
} })
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
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
stub.login()
Polestar.Set("behavior.autoAccept", false)
stub.fire("QUEST_LOG_UPDATE"); flush()
"#;

fn run(before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{GUIDES}\n{HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

const ALLIANCE: &str = r#"
local w = stub.world
w.race, w.faction, w.class, w.className, w.level = "Gnome", "Alliance", "PRIEST", "Priest", 28
w.moveTo(1437, 49.4, 46.8)
"#;

const HORDE: &str = r#"
local w = stub.world
w.race, w.faction, w.class, w.className, w.level = "Scourge", "Horde", "MAGE", "Mage", 43
w.moveTo(1434, 43.9, 20.0)
"#;

const OPEN: &str = r#"
E.SetGuide("{GUIDE}"); flush()
emit({ shape = shape(), at = E.GetStepIndex(), feeders = E.GetGuide().feeders or 0 })
"#;

fn open(who: &str, log: &str, guide: &str) -> Value {
	run(&format!("{who}\n{log}"), &OPEN.replace("{GUIDE}", guide))
}

#[test]
fn t_2871_fire_taboo_carried_without_its_flint_gets_the_flint_step_before_rethiel() {
	let out = open(ALLIANCE, "w.onQuest(277, { { required = 9, fulfilled = 0 } })", "test/wetlands");
	// The flint, and only the flint, from the guide before, ahead of the hand-in: beside the guide's own step nearest
	// it (the Angerfang camp; a tie with the start of the guide goes to the start, as for every feeder step).
	assert_eq!(out["shape"], json!(["Mosshide gnolls <test/ashenvale 2> collect:277", "Angerfang Encampment goto", "Rethiel the Greenwarden turnin:277"]), "{out}");
	assert_eq!(out["at"], json!(1), "the arrow on the flint first: {out}");
	assert_eq!(out["feeders"], json!(1));
	// The flint already in the bags: nothing goes in.
	let ready = open(ALLIANCE, "w.onQuest(277, { { required = 9, fulfilled = 9 } })", "test/wetlands");
	assert_eq!(ready["shape"], json!(["Angerfang Encampment goto", "Rethiel the Greenwarden turnin:277"]), "{ready}");
	// Never taken: nothing goes in either (the hand-in is not this character's).
	let none = open(ALLIANCE, "", "test/wetlands");
	assert_eq!(none["feeders"], json!(0), "{none}");
}

#[test]
fn t_2792_panther_mastery_carried_unfinished_gets_the_panthers_before_nesingwary() {
	let out = open(HORDE, "w.onQuest(192, { { required = 10, fulfilled = 3 } })", "test/stv40");
	assert_eq!(
		out["shape"],
		json!(["Stranglethorn Vale: kill these as you meet them <test/stv30 2> kill:192", "Venture Co. Base Camp accept:201", "Nesingwary's Expedition turnin:192"]),
		"the panthers from the 30-40 guide, ahead of the hand-in: {out}"
	);
	let ready = open(HORDE, "w.onQuest(192, { { required = 10, fulfilled = 10 } })", "test/stv40");
	assert_eq!(ready["feeders"], json!(0), "{ready}");
}
