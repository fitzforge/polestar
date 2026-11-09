//! A closed guide tab keeps the player's place: closing never loses progress, the closed guide is listed
//! (Engine.ClosedTabs, newest first) and opening it again (Engine.ReopenClosedTab, OpenTab, a Load over another
//! tab, a route chosen again) brings it back as a reload brings a saved tab: the step on screen (its pin, which
//! closing used to drop), the live step, its ticks and skips. A guide loaded over a tab goes to the closed ones
//! too. Real Core manifest, stub world; the window's undo and the guide list's Recently closed run on the full
//! addon.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 20, 80)
"#;

// A one-step leveling guide the login opens, a six-step route of `goto` steps (ticked and skipped by hand),
// and fillers.
const GUIDES: &str = r#"
Polestar.RegisterGuide({ id = "test/lvl", pack = "test", title = "Northshire", faction = "Alliance", minLevel = 1, maxLevel = 6, steps = {
	{ goals = { { t = "level", level = 6 } } },
} })
Polestar.RegisterGuide({ id = "test/route", pack = "test", title = "Goldshire", category = "Exploration", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "goto", map = 1429, x = 40, y = 60 } } },
	{ goals = { { t = "goto", map = 1429, x = 42, y = 62 } } },
	{ goals = { { t = "goto", map = 1429, x = 44, y = 64 } } },
	{ goals = { { t = "goto", map = 1429, x = 46, y = 66 }, { t = "goto", map = 1429, x = 47, y = 67 } } },
	{ goals = { { t = "goto", map = 1429, x = 48, y = 68 } } },
	{ goals = { { t = "goto", map = 1429, x = 50, y = 70 } } },
} })
for i = 1, 5 do
	Polestar.RegisterGuide({ id = "test/f" .. i, pack = "test", title = "Filler " .. i, category = "Exploration", minLevel = 1, maxLevel = 60, steps = {
		{ goals = { { t = "level", level = 60 } } },
	} })
end
Polestar.RegisterGuide({ id = "test/start", pack = "test", title = "Crossroads", minLevel = 30, maxLevel = 40,
	next = "test/route", nextChoices = { "test/route", "test/f1" }, steps = {
	{ goals = { { t = "level", level = 40 } } },
} })
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
function ids()
	local list, active = E.GetTabs()
	local out = {}
	for i, t in ipairs(list) do out[i] = t.guideId end
	return { tabs = out, active = active }
end
function at(id) for i, t in ipairs(E.GetTabs()) do if t.guideId == id then return i end end end
function closedIds() local out = {}; for i, c in ipairs(E.ClosedTabs()) do out[i] = c.guideId end; return out end
-- The route as the player left it: tick goal 1 of steps 1 and 2, skip step 3, tick goal 1 of step 4 (the live
-- step), then look back at step 3.
function play()
	E.ToggleGoal(1, 1); flush()
	E.ToggleGoal(2, 1); flush()
	E.Skip(); flush()
	E.ToggleGoal(4, 1); flush()
	E.Prev(); flush()
end
-- The route tab as the player sees it: the step on screen, the live step, ticks and skips.
function state()
	local manual = (PolestarCharDB.manual or {})["test/route"] or {}
	local skipped = (PolestarCharDB.skipped or {})["test/route"] or {}
	local ticks, skips = {}, {}
	for k in pairs(manual) do ticks[#ticks + 1] = tostring(k) end
	for k in pairs(skipped) do skips[#skips + 1] = tostring(k) end
	table.sort(ticks); table.sort(skips)
	return { guide = E.GetGuide() and E.GetGuide().id or false, step = E.GetStepIndex() or false, live = E.GetLiveStep() or false, ticks = ticks, skips = skips }
end
"#;

const PLAYED: &str = r#"{ "guide": "test/route", "step": 3, "live": 4, "ticks": ["1:1", "2:1", "4:1"], "skips": ["3"] }"#;

fn played() -> Value {
	serde_json::from_str(PLAYED).unwrap()
}

fn run_with(addons: Vec<Addon>, saved: Option<&str>, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons,
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: [TEST_PACK, TEST_SOURCE, GUIDES, HELPERS, "stub.login()", script].join("\n"),
		..Default::default()
	})
}

fn run(saved: Option<&str>, script: &str) -> Value {
	run_with(vec![Addon::files("Polestar", &["Core/Core.xml"])], saved, script).remove(0)
}

#[test]
fn a_closed_tab_reopens_at_its_place_with_the_step_on_screen_the_live_step_ticks_and_skips() {
	let out = run(
		None,
		r#"
		local r = {}
		local fired = {}
		Polestar.On("TAB_CLOSED", function(id) fired[#fired + 1] = id end)
		E.OpenTab("test/route"); flush()
		E.OpenTab("test/f1", false); flush()
		E.SelectTab(2); flush()
		play()
		r.before = state()
		E.CloseTab(at("test/route")); flush()
		r.closed = { ids = ids(), list = closedIds(), saved = PolestarCharDB.closedTabs, pin = PolestarCharDB.pins["test/route"], fired = fired }
		r.index = E.ReopenClosedTab(); flush()
		r.after = state()
		r.reopened = { ids = ids(), list = closedIds(), saved = PolestarCharDB.closedTabs or false }
		r.again = E.ReopenClosedTab() or false
		emit(r)
	"#,
	);
	assert_eq!(out["before"], played());
	assert_eq!(
		out["closed"],
		json!({ "ids": { "tabs": ["test/lvl", "test/f1"], "active": 2 }, "list": ["test/route"],
			"saved": [{ "id": "test/route", "at": 2 }], "pin": { "step": 3, "done": false }, "fired": ["test/route"] })
	);
	// Back at tab 2, active, as it was: looking at step 3 (skipped), the guide at step 4.
	assert_eq!(out["index"], 2);
	assert_eq!(out["after"], played());
	assert_eq!(out["reopened"], json!({ "ids": { "tabs": ["test/lvl", "test/route", "test/f1"], "active": 2 }, "list": {}, "saved": false }));
	assert_eq!(out["again"], false);
}

#[test]
fn opening_a_closed_guide_from_the_list_or_loading_it_over_a_tab_restores_it_and_the_guide_replaced_is_closed() {
	let out = run(
		None,
		r#"
		local r = {}
		E.OpenTab("test/route"); flush()
		play()
		E.CloseTab(at("test/route")); flush()
		-- The guide list's "Open in new tab".
		E.OpenTab("test/route"); flush()
		r.opened = state()
		-- Its "Load guide" puts another guide in the active tab: the route is closed, not lost.
		E.SetGuide("test/f2"); flush()
		r.replaced = { ids = ids(), list = closedIds() }
		E.SetGuide("test/route"); flush()
		r.loaded = state()
		r.back = { ids = ids(), list = closedIds() }
		emit(r)
	"#,
	);
	assert_eq!(out["opened"], played());
	assert_eq!(out["replaced"], json!({ "ids": { "tabs": ["test/lvl", "test/f2"], "active": 2 }, "list": ["test/route"] }));
	assert_eq!(out["loaded"], played());
	assert_eq!(out["back"], json!({ "ids": { "tabs": ["test/lvl", "test/route"], "active": 2 }, "list": ["test/f2"] }));
}

#[test]
fn closed_tabs_are_saved_with_the_step_on_screen_and_reopen_after_a_reload() {
	let out = run(
		Some(
			r#"PolestarCharDB = { schema = 1, tabs = { "test/lvl" }, activeTab = 1, guide = "test/lvl",
			closedTabs = { { id = "test/route", at = 2 }, { id = "gone/guide", at = 3 } },
			pins = { ["test/route"] = { step = 3, done = false } },
			manual = { ["test/route"] = { ["1:1"] = "tick", ["2:1"] = "tick", ["4:1"] = "tick" } },
			skipped = { ["test/route"] = { [3] = true } } }"#,
		),
		r#"
		local r = { list = closedIds(), saved = PolestarCharDB.closedTabs, pin = PolestarCharDB.pins["test/route"] }
		r.index = E.ReopenClosedTab(); flush(); stub.advance(11); flush()
		r.after = state()
		emit(r)
	"#,
	);
	// A closed guide not registered stays saved (its pack may come back) but is not offered.
	assert_eq!(out["list"], json!(["test/route"]));
	assert_eq!(out["saved"], json!([{ "id": "test/route", "at": 2 }, { "id": "gone/guide", "at": 3 }]));
	assert_eq!(out["pin"], json!({ "step": 3, "done": false }));
	assert_eq!(out["index"], 2);
	assert_eq!(out["after"], played());
}

// Changing route (Engine.ChooseRoute) loads the other option over the open one: that one is closed, not lost,
// and choosing it again brings it back as it was.
#[test]
fn a_route_option_changed_for_another_is_closed_and_choosing_it_again_restores_it() {
	let out = run(
		None,
		r#"
		local r = {}
		E.OpenTab("test/route"); flush()
		play()
		r.chose = E.ChooseRoute("test/start", "test/f1"); flush()
		r.swapped = { ids = ids(), list = closedIds() }
		E.ChooseRoute("test/start", "test/route"); flush()
		r.back = { state(), ids(), closedIds() }
		emit(r)
	"#,
	);
	assert_eq!(out["chose"], true);
	assert_eq!(out["swapped"], json!({ "ids": { "tabs": ["test/lvl", "test/f1"], "active": 2 }, "list": ["test/route"] }));
	assert_eq!(out["back"], json!([played(), { "tabs": ["test/lvl", "test/route"], "active": 2 }, ["test/f1"]]));
}

#[test]
fn a_tab_polestar_closes_itself_is_not_kept_and_six_tabs_leave_no_room_to_reopen() {
	let out = run(
		None,
		r#"
		local r = {}
		local fired = 0
		Polestar.On("TAB_CLOSED", function() fired = fired + 1 end)
		E.OpenTab("test/route"); flush()
		E.CloseTab(at("test/route"), true); flush()
		r.quiet = { list = closedIds(), fired = fired, pin = PolestarCharDB.pins and PolestarCharDB.pins["test/route"] or false }
		E.OpenTab("test/route"); flush()
		E.CloseTab(at("test/route")); flush()
		for i = 1, 5 do E.OpenTab("test/f" .. i); flush() end
		r.full = { n = #E.GetTabs(), reopen = E.ReopenClosedTab() or false, list = closedIds() }
		emit(r)
	"#,
	);
	assert_eq!(out["quiet"], json!({ "list": {}, "fired": 0, "pin": false }));
	assert_eq!(out["full"], json!({ "n": 6, "reopen": false, "list": ["test/route"] }));
}

// The full addon: the tab strip's close button closes the route; the window offers "Closed Goldshire" with
// Reopen for ten seconds, even with no tab left, and Reopen brings it back as it was; the guide list's Recent
// leads with Recently closed; /polestar reopen and the key binding do the same.
#[test]
fn the_window_offers_reopen_after_a_close_and_the_guide_list_lists_it_under_recently_closed() {
	let out = run_with(
		vec![Addon::name("Polestar")],
		None,
		r#"
		local GF, UI = Polestar.UI.GuideFrame, Polestar.UI
		Polestar.Set("ui.shown", true); flush()
		local function closeButton(id)
			for _, f in ipairs(stub.frames) do
				if f.psIndex and f.psTitle and rawget(f, "Close") and f:IsShown() and E.GetTabs()[f.psIndex].guideId == id then return f.Close end
			end
		end
		local function banner()
			local b = GF.parts.banner
			return b:IsShown() and { b.Text:GetText(), b.Jump:IsShown() and b.Jump.Label:GetText() or false } or false
		end
		local function rows()
			local out = {}
			for _, f in ipairs(stub.frames) do
				if f.psGuide and rawget(f, "Range") and f:IsShown() and f:GetParent() == PolestarPicker.Scroll.Child then out[#out + 1] = f end
			end
			table.sort(out, function(a, b) return select(5, a:GetPoint(1)) > select(5, b:GetPoint(1)) end)
			for i, f in ipairs(out) do out[i] = f.Title:GetText() end
			return out
		end
		local function folders()
			local out = {}
			for _, f in ipairs(stub.frames) do
				if rawget(f, "Count") and rawget(f, "Rule") and not rawget(f, "Range") and f:IsShown() and f:GetParent() == PolestarPicker.Scroll.Child then out[#out + 1] = f end
			end
			table.sort(out, function(a, b) return select(5, a:GetPoint(1)) > select(5, b:GetPoint(1)) end)
			for i, f in ipairs(out) do out[i] = f.Text:GetText() .. " " .. f.Count:GetText() end
			return out
		end
		local r = {}
		E.OpenTab("test/route"); flush()
		play()
		closeButton("test/route"):Click(); flush()
		r.toast = banner()
		GF.parts.banner.Jump:Click(); flush()
		r.reopened = { state(), ids(), banner() }
		-- The last tab closed: the window has no guide, and still offers it back.
		E.CloseTab(at("test/lvl")); flush()
		closeButton("test/route"):Click(); flush()
		r.empty = { ids(), banner() }
		stub.advance(10.5)
		r.expired = banner()
		UI.ShowPicker()
		Polestar.UI.Picker.SetView("recent")
		r.recent = { folders(), rows() }
		PolestarPicker:Hide()
		Polestar.Bindings.ReopenTab(); flush()
		r.binding = { ids(), state() }
		emit(r)
	"#,
	)
	.remove(0);
	assert_eq!(out["toast"], json!(["Closed Goldshire", "Reopen"]));
	assert_eq!(out["reopened"][0], played());
	assert_eq!(out["reopened"][1], json!({ "tabs": ["test/lvl", "test/route"], "active": 2 }));
	assert_ne!(out["reopened"][2], json!(["Closed Goldshire", "Reopen"]));
	assert_eq!(out["empty"], json!([{ "tabs": {}, "active": 0 }, ["Closed Goldshire", "Reopen"]]));
	assert_eq!(out["expired"], false);
	// Both closed guides lead, newest first; every guide loaded is among them, so no second folder.
	assert_eq!(out["recent"], json!([["Recently closed 2"], ["Goldshire", "Northshire"]]));
	assert_eq!(out["binding"], json!([{ "tabs": ["test/route"], "active": 1 }, played()]));
}
