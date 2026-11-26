//! The dungeon entry offer, generated run tab and Options toggle on the real addon.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
function IsInInstance() return w.instanceKind ~= nil, w.instanceKind end
function GetInstanceInfo() return nil, nil, nil, nil, nil, nil, nil, w.instanceMap end
function UnitIsGhost(unit) return unit == "player" and w.ghost end

-- Wailing Caverns quests and IDs from tests/fixtures/codex/dungeons.json.
-- Give the Glowing Shard an inside end to exercise the journal's inside branch.
local page = [=[return { quests = {
	{ id = 1486, title = "Deviate Hides" },
	{ id = 6981, title = "The Glowing Shard", finish = { kind = "npc", id = 5768, inside = true } },
} }]=]
local loaded = stub.addonLoaded
function stub.addonLoaded(name)
	if name == "Polestar" then
		local D, C = Polestar.Dungeons, Polestar.Codex
		D.Register("meta", {})
		D.Register("dungeon", { ["wailing-caverns"] = { name = "Wailing Caverns", map = 43, minLevel = 15, kind = "dungeon" } }, { ["wailing-caverns"] = page })
		C.Load = function() return true end
		C.Quest = function(id)
			if id == 1486 then return { id = id, title = "Deviate Hides", objectives = { { type = "item", id = 6443, count = 20 } } } end
			if id == 6981 then return { id = id, title = "The Glowing Shard", ["end"] = { npc = { 5768 } } } end
		end
		C.Item = function(id)
			if id == 6443 then return { id = id, name = "Deviate Hide", sources = { { type = "drop", npc = 3636, chance = 20, instance = "wailing-caverns" } } } end
		end
		C.Npc = function(id)
			if id == 3636 then
				return { id = id, name = "Deviate Ravager", spawns = { { map = 43, x = 40, y = 40 } } }
			end
		end
	end
	return loaded(name)
end
local function hides()
	w.onQuest(1486, { { type = "item", required = 20, fulfilled = 3, text = "Deviate Hide: 3/20" } }, "Deviate Hides")
end
"#;

const HELPERS: &str = r#"
local w, P = stub.world, Polestar
local E, F = P.Engine, PolestarGuideFrame
local id = "lookup/run/wailing-caverns"
local function enter(kind, map, reload)
	w.instanceKind, w.instanceMap = kind, map
	stub.fire("PLAYER_ENTERING_WORLD", false, reload or false)
	stub.runTimers()
end
local function offer() return stub.frame("PolestarDungeonRunOffer") end
local function asked() return offer() ~= nil and offer():IsShown() end
local function active() return E.GetGuide() and E.GetGuide().id or false end
local function guide(name)
	assert(P.RegisterGuide({ id = "lookup/" .. name, pack = "lookup", title = name, steps = { { goals = { { t = "note", text = name } } } } }))
	return assert(E.OpenTab("lookup/" .. name))
end
"#;

fn run_with(before: &str, saved: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		before: format!("{WORLD}\n{before}"),
		saved: vec![("Polestar".into(), format!("PolestarDB = {{ schema = 1, instanceHint = true }}\n{saved}"))],
		login: true,
		script: format!("{HELPERS}\n{script}"),
	})
	.remove(0)
}

#[test]
fn offer_opens_and_rebuilds_the_run_tab_with_live_quest_progress_then_restores_the_previous_tab() {
	let out = run_with(
		"hides(); w.onQuest(166, { 1 }, 'The Defias Brotherhood')",
		"",
		r#"
		guide("leveling")
		guide("another")
		E.SelectTab(1)
		enter("party", 43)
		assert(asked(), "entering with a dungeon quest should ask even with the guide hidden")
		local before = { shown = F:IsShown(), title = offer().Title:GetText() }
		offer().Open:Click()
		local g = E.GetGuide()
		local goal = E.GetStepView(E.GetLiveStep()).goals[1]
		local opened = { id = active(), shown = F:IsShown(), steps = #g.steps, quest = goal.quest,
			goals = #g.steps[1].goals, source = g.steps[1].goals[1].from,
			progress = goal.progress, routed = goal.map ~= nil or E.GetWaypoint() ~= nil }
		w.progress(1486, 1, 4)
		stub.advance(0.25)
		local after = E.GetStepView(E.GetLiveStep()).goals[1].progress
		w.accept(6981, {}, "The Glowing Shard")
		stub.runTimers()
		g = E.GetGuide()
		local turnin = g.steps[2].goals[1]
		local added = { count = #g.steps, turnin = turnin.t, quest = turnin.quest }
		w.turnIn(6981)
		stub.runTimers()
		local removed = #E.GetGuide().steps
		w.abandon(1486)
		stub.runTimers()
		local empty = E.GetGuide().steps[1].goals[1].t
		enter(nil)
		emit({ before = before, opened = opened, after = after, added = added, removed = removed, empty = empty,
			left = active(), tabs = #E.GetTabs(), closed = #E.ClosedTabs() })
	"#,
	);
	assert_eq!(out["before"], json!({ "shown": false, "title": "You've entered Wailing Caverns. Open the step tracker for your quests here?" }));
	assert_eq!(out["opened"]["id"], "lookup/run/wailing-caverns");
	assert_eq!(out["opened"]["shown"], true);
	assert_eq!(out["opened"]["steps"], 1);
	assert_eq!(out["opened"]["goals"], 1);
	assert_eq!(out["opened"]["quest"], 1486);
	assert_eq!(out["opened"]["source"], "Deviate Ravager");
	assert_eq!(out["opened"]["progress"], json!({ "kind": "count", "cur": 3, "max": 20 }));
	assert_eq!(out["opened"]["routed"], false);
	assert_eq!(out["after"], json!({ "kind": "count", "cur": 4, "max": 20 }));
	assert_eq!(out["added"], json!({ "count": 2, "turnin": "turnin", "quest": 6981 }));
	assert_eq!(out["removed"], 1);
	assert_eq!(out["empty"], "note");
	assert_eq!(out["left"], "lookup/leveling");
	assert_eq!(out["tabs"], 2);
	assert_eq!(out["closed"], 0);
}

#[test]
fn offer_waits_for_an_eligible_dungeon_and_combat_to_end_and_not_now_keeps_the_current_tab() {
	let out = run_with(
		"",
		"",
		r#"
		guide("leveling")
		P.Set("ui.instance", "show")
		enter("party", 43)
		local empty = asked()
		enter(nil)
		w.onQuest(1486, { 20 }, "Deviate Hides")
		enter("raid", 43)
		local raid = asked()
		enter("pvp", 43)
		local bg = asked()
		enter("arena", 43)
		local arena = asked()
		stub.inCombat = true
		stub.fire("PLAYER_REGEN_DISABLED")
		enter("party", 43)
		local combat = asked()
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.runTimers()
		local shown = asked() and F:IsShown()
		assert(shown, "Keep visible also shows the offer after combat")
		offer().Later:Click()
		local unchanged = active() == "lookup/leveling" and F:IsShown() and #E.GetTabs() == 1
		w.ghost = true
		enter(nil)
		enter("party", 43)
		w.ghost = false
		stub.fire("PLAYER_UNGHOST")
		stub.runTimers()
		local corpseRun = asked()
		enter(nil)
		enter("party", nil)
		local unreadable = asked()
		w.instanceMap = 43
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.runTimers()
		emit({ empty, raid, bg, arena, combat, shown, unchanged, corpseRun, unreadable, asked() })
	"#,
	);
	assert_eq!(out, json!([false, false, false, false, false, true, true, false, false, true]));
}

#[test]
fn dont_ask_again_saves_from_either_button_and_the_options_checkbox_turns_it_back_on() {
	let out = run_with(
		"hides()",
		"",
		r#"
		P.UI.ShowOptions()
		for _, button in ipairs({ "Later", "Open" }) do
			enter("party", 43)
			assert(asked(), "should offer before opting out")
			offer().Never:SetChecked(true)
			offer()[button]:Click()
			assert(P.Get("dungeons.runOffer") == false and not asked())
			assert((active() == id) == (button == "Open"))
			enter(nil)
			enter("party", 43)
			assert(not asked())
			local O = P.UI.Options
			for _, c in ipairs(O.AllControls()) do
				if c.key == "dungeons.runOffer" then
					O.Select(c.page.key, c.tab or "")
					assert(c.kind == "toggle" and c.help)
					local widget = assert(O.view.cache[c] or O.view.extras[c])
					widget:Click()
					break
				end
			end
			assert(P.Get("dungeons.runOffer") == true)
			enter(nil)
		end
		emit(true)
	"#,
	);
	assert_eq!(out, true);
}

#[test]
fn a_reload_inside_restores_the_run_tab_and_does_not_ask_again() {
	let out = run_with(
		"hides(); w.instanceKind, w.instanceMap = 'party', 43",
		r#"PolestarCharDB = { guide = "lookup/run/wailing-caverns", tabs = { "lookup/run/wailing-caverns" }, activeTab = 1,
			dungeonRun = { map = 43, key = "wailing-caverns", asked = true } }"#,
		r#"
		enter("party", 43, true)
		local restored = active()
		local askedAgain = asked()
		enter(nil)
		emit({ restored, askedAgain, #E.GetTabs() })
	"#,
	);
	assert_eq!(out, json!(["lookup/run/wailing-caverns", false, 0]));
}

#[test]
fn a_visit_waits_for_the_journal_and_leaving_cancels_an_offer_deferred_in_combat() {
	let out = run_with(
		"hides()",
		"",
		r#"
		P.Set("dungeons.enabled", false)
		enter("party", 43)
		local disabled = asked()
		assert(P.Lookup.BuildGuide("run", "wailing-caverns") == nil)
		P.Set("dungeons.enabled", true)
		stub.runTimers()
		local enabled = asked()
		enter(nil)
		stub.inCombat = true
		enter("party", 43)
		enter(nil)
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		stub.runTimers()
		emit({ disabled, enabled, asked() })
	"#,
	);
	assert_eq!(out, json!([false, true, false]));
}
