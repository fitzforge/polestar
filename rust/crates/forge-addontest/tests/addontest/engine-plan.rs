//! The Guide Planner's model (Engine.PlanOf): a guide as this character would play it, read whether it is open
//! or not. A guide that is not open is read as if loaded now (its first open step is where it starts) without
//! opening it, evaluating, firing or saving anything, and the open guide stays the loaded one. A quest hidden
//! (Engine.SkipQuest) reads as skipped with the quests that follow from it, which name it; bringing it back
//! undoes that. An accept waiting for the character's level is part of the plan. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 50, 50)
w.race, w.raceName, w.faction, w.class, w.className, w.level = "Human", "Human", "Alliance", "WARRIOR", "Warrior", 10
"#;

// A -> B -> C with Other beside A, a Mage's step nobody else sees, and a quest for level 14.
const GUIDES: &str = r#"
Polestar.RegisterGuide({ id = "test/plan", pack = "test", title = "Plan", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ title = "Start", goals = { { t = "accept", quest = 1, title = "A", qlvl = 10 }, { t = "accept", quest = 9, title = "Other", qlvl = 10 } } },
	{ title = "Mages", only = { classes = { "MAGE" } }, goals = { { t = "accept", quest = 7, title = "Mage", qlvl = 10 } } },
	{ title = "Second", goals = { { t = "turnin", quest = 1, title = "A" }, { t = "accept", quest = 2, title = "B", qlvl = 10, pre = { 1 } } } },
	{ title = "Third", goals = { { t = "turnin", quest = 2, title = "B" }, { t = "accept", quest = 3, title = "C", qlvl = 10, pre = { 2 } } } },
	{ title = "Later", goals = { { t = "accept", quest = 5, title = "Later", qlvl = 14, minLevel = 14 } } },
	{ title = "End", goals = { { t = "turnin", quest = 3, title = "C" }, { t = "turnin", quest = 9, title = "Other" } } },
} })
Polestar.RegisterGuide({ id = "test/other", pack = "test", title = "Other guide", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ title = "Elsewhere", goals = { { t = "accept", quest = 8, title = "Unrelated", qlvl = 10 } } },
} })
"#;

const HELPERS: &str = r#"
			E = Polestar.Engine
			function flush() stub.advance(0.25) end
			stub.login()
			stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
			-- The plan step by step: "number title: status,status" with what a goal was left out with.
			function plan(id)
				local p = E.PlanOf(id)
				if not p then return false end
				local steps = {}
				for i, v in ipairs(p.steps) do
					local g = {}
					for j, gv in ipairs(v.goals) do
						g[j] = gv.status .. (gv.unavailable and ("/" .. gv.unavailable) or "") .. (gv.skippedWith and ("/" .. gv.skippedWith) or "")
					end
					steps[i] = v.number .. " " .. v.title .. ": " .. table.concat(g, ",")
				end
				return { tab = p.tab or false, at = p.at or false, total = p.total, steps = steps }
			end
			-- What the character has saved about its guides, as one comparable line.
			function saved()
				local s = PolestarCharDB
				local function keys(t)
					local out = {}
					for k in pairs(type(t) == "table" and t or {}) do out[#out + 1] = tostring(k) end
					table.sort(out)
					return table.concat(out, ",")
				end
				return table.concat({ table.concat(s.tabs or {}, ","), keys(s.skipped), keys(s.manual), keys(s.pins), keys((s.flags or {}).started) }, " | ")
			end
"#;

fn run(before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: [TEST_PACK, TEST_SOURCE, GUIDES, HELPERS, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_guide_that_is_not_open_is_planned_as_if_loaded_now_and_nothing_is_opened_or_saved() {
	let out = run(
		"",
		r#"
			E.SetGuide("test/other"); flush()
			local before = saved()
			local events = {}
			for _, m in ipairs({ "GUIDE_CHANGED", "TABS_CHANGED", "GUIDE_COMPLETED", "STEP_CHANGED" }) do
				Polestar.On(m, function() events[#events + 1] = m end)
			end
			local p = plan("test/plan")
			flush()
			emit({ plan = p, guide = E.GetGuide().id, at = E.GetStepIndex(), before = before, after = saved(), events = table.concat(events, ","),
				missing = E.PlanOf("test/none") or false })"#,
	);
	assert_eq!(
		out["plan"],
		json!({
			"tab": false,
			"at": 1,
			"total": 5,
			"steps": ["1 Start: active,active", "2 Second: pending,pending", "3 Third: pending,pending", "4 Later: pending", "5 End: pending,pending"],
		}),
		"the Mage's step is no step of this character's; the quest for level 14 is in the plan"
	);
	assert_eq!(out["guide"], "test/other", "the open guide stays the loaded one");
	assert_eq!(out["at"], 1);
	assert_eq!(out["before"], out["after"], "nothing saved");
	assert!(out["before"].as_str().unwrap().starts_with("test/other |"), "{}", out["before"]);
	assert_eq!(out["events"], "", "nothing fired");
	assert_eq!(out["missing"], false);
}

#[test]
fn a_hidden_quest_goes_with_what_follows_from_it_and_comes_back() {
	let out = run(
		"",
		r#"
			E.SetGuide("test/other"); flush()
			local banners = 0
			Polestar.On("PLAYER_SKIPPED_QUEST", function() banners = banners + 1 end)
			E.SkipQuest(1, true, true); flush()
			local hidden = plan("test/plan")
			local loaded = E.GetGuide().id
			E.SkipQuest(1, false, true); flush()
			emit({ hidden = hidden, back = plan("test/plan"), loaded = loaded, banners = banners, at = E.GetStepIndex() })"#,
	);
	assert_eq!(
		out["hidden"]["steps"],
		json!(["1 Start: skipped/skipped,active", "2 Second: skipped/skipped,skipped/pre/A", "3 Third: skipped/pre/A,skipped/pre/A", "4 Later: pending", "5 End: skipped/pre/A,pending",]),
		"A is hidden; B and C go with it and say so; Other and Later stay"
	);
	assert_eq!(out["back"]["steps"][1], "2 Second: pending,pending");
	assert_eq!(out["loaded"], "test/other", "the open guide stays the loaded one");
	assert_eq!(out["banners"], 0, "a quiet skip offers no undo banner");
	assert_eq!(out["at"], 1);
}

#[test]
fn an_open_guide_is_planned_on_its_own_tab_at_its_live_step() {
	let out = run(
		"stub.world.complete({ 1, 9 })",
		r#"
			E.SetGuide("test/other"); flush()
			E.OpenTab("test/plan", false); flush()
			local p = plan("test/plan")
			emit({ plan = p, active = E.GetGuide().id, live = E.GetStepIndex() })"#,
	);
	assert_eq!(out["plan"]["tab"], 2);
	assert_eq!(out["plan"]["at"], 3, "A and Other are done: the live step is Second (the third step of the guide)");
	assert_eq!(out["plan"]["steps"][0], "1 Start: done,done");
	assert_eq!(out["plan"]["steps"][1], "2 Second: done,active");
	assert_eq!(out["active"], "test/other");
	assert_eq!(out["live"], 1);
}

#[test]
fn the_step_card_still_leaves_out_an_accept_that_waits_for_the_level() {
	let out = run(
		"",
		r#"
			E.SetGuide("test/plan"); flush()
			local p = plan("test/plan")
			emit({ tab = p.tab, planned = p.steps[4], card = E.GetStepView(5).goals[1].status })"#,
	);
	assert_eq!(out["tab"], 1);
	assert_eq!(out["planned"], "4 Later: pending");
	assert_eq!(out["card"], "na", "planning changes nothing on the step card");
}
