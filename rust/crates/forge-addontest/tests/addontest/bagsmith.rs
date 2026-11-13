use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

// https://github.com/Shweep8/bagsmith/blob/main/docs/API.md#icon-corner-widgets-11
const API: &str = r#"
widgets, registrations, refreshes = {}, 0, 0
BagSmith = { API = {
 RegisterCornerWidget = function(label, id, update, init, position, fast, options)
  assert(not widgets[id], 'duplicate widget')
  registrations = registrations + 1
  widgets[id] = { update = update, init = init, position = position, options = options }
  return true
 end,
 IsCornerWidgetActive = function() return not hidden end,
 RequestItemButtonsRefresh = function(...) assert(select('#', ...) == 0); refreshes = refreshes + 1 end,
} }
"#;

fn run(before: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gear.lua"],
		before: before.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml", "QoL/QoL.xml", "Quests/Quests.xml"])],
		script: script.into(),
		..Default::default()
	})
}

#[test]
fn bagsmith_registers_all_four_widgets_once_before_or_after_polestar_with_list_rows() {
	for late in [false, true] {
		let script = format!(
			r#"
{}
stub.addonLoaded("BagSmith")
stub.addonLoaded("BagSmith")
emit(registrations)
local result = {{}}
for id, w in pairs(widgets) do
 local slot = CreateFrame("Frame", nil, UIParent)
 slot:SetSize(32, 32); slot.bagsmithRowSlot = true
 local t = w.init(slot)
 result[id] = {{ list = w.options.listRows, corner = w.position.corner, texture = type(t.texture) == "string", width = t:GetWidth() }}
end
emit(result)
"#,
			if late { API } else { "" }
		);
		let out = run(if late { "" } else { API }, &script);
		assert_eq!(out[0], 4);
		for (id, corner, width) in
			[("polestar_upgrade", "top_left", 20.0), ("polestar_quest_needed", "top_right", 16.0), ("polestar_step_item", "bottom_left", 19.2), ("polestar_kept_item", "top_left", 14.0)]
		{
			assert_eq!(out[1][id]["list"], true);
			assert_eq!(out[1][id]["corner"], corner);
			assert_eq!(out[1][id]["texture"], true);
			assert!((out[1][id]["width"].as_f64().unwrap() - width).abs() < 0.001);
		}
	}
}

#[test]
fn bagsmith_still_registers_when_baganator_loaded_first() {
	let before = r#"
baganatorRegistrations = 0
Baganator = { API = { RegisterCornerWidget = function() baganatorRegistrations = baganatorRegistrations + 1 end } }
"#;
	let out = run(
		before,
		&format!(
			r#"
{API}
stub.addonLoaded("BagSmith")
stub.addonLoaded("Baganator")
stub.addonLoaded("BagSmith")
emit({{baganatorRegistrations, registrations}})
"#
		),
	);
	assert_eq!(out[0], json!([4, 4]));
}

#[test]
fn bagsmith_verdicts_follow_settings_items_and_refresh_events() {
	let out = run(
		API,
		r#"
local G, Q, QoL = Polestar.Gear, Polestar.QuestDB, Polestar.QoL
assert(widgets.polestar_upgrade and widgets.polestar_quest_needed and widgets.polestar_step_item and widgets.polestar_kept_item)
G.IsUpgrade = function(link) return link == "item:9002" end
G.FillsEmptySlot = function() return false end
Q.IsRunning = function() return true end
Q.IsItemNeeded = function(id) return id == 9002 end
QoL.CurrentStep = function() return { goals = { { t = "use", item = 9002, status = "active" } } }, {} end
Polestar.Engine.KeptItems = function() return { [9003] = 2 } end
QoL.Client.SellPrice = function() return 10 end
QoL.BagGlow.Refresh()
local function verdict(id, details) return widgets[id].update(nil, details) end
emit({verdict("polestar_upgrade", {itemLink = "item:9002"}), verdict("polestar_upgrade", {itemLink = "item:9004"}),
 verdict("polestar_quest_needed", {itemLink = "item:9002"}), verdict("polestar_quest_needed", {}),
 verdict("polestar_step_item", {itemID = 9002}), verdict("polestar_kept_item", {itemID = 9003}),
 verdict("polestar_kept_item", {itemID = 9002})})
for _, w in pairs(widgets) do assert(w.update(nil, nil) == false); assert(w.update(nil, {}) == false) end
refreshes = 0
Polestar.Fire("GEAR_UPDATED"); stub.advance(0.3)
emit(refreshes > 0)
refreshes = 0
Polestar.Fire("QUESTDB_UPDATED")
emit(refreshes > 0)
refreshes = 0
QoL.CurrentStep = function() return { goals = { { t = "use", item = 9003, status = "active" } } }, {} end
Polestar.Fire("STEP_CHANGED"); stub.advance(0.3)
assert(refreshes > 0)
assert(not verdict("polestar_step_item", {itemID = 9002}))
assert(verdict("polestar_step_item", {itemID = 9003}))
assert(not verdict("polestar_kept_item", {itemID = 9003}))
Polestar.Set("gear.bagArrows", false)
Polestar.Set("qol.questBagMarks", false)
Polestar.Set("qol.bagGlow", false)
stub.advance(0.3)
emit({verdict("polestar_upgrade", {itemLink = "item:9002"}), verdict("polestar_quest_needed", {itemLink = "item:9002"}),
 verdict("polestar_step_item", {itemID = 9002}), verdict("polestar_kept_item", {itemID = 9003})})
hidden = true; refreshes = 0
G.Bags.Redraw(); Q.RedrawBagMarks(); QoL.BagGlow.Redraw()
emit(refreshes)
"#,
	);
	assert_eq!(out[0], json!([true, false, true, false, true, true, false]));
	assert_eq!(out[1], true);
	assert_eq!(out[2], true);
	assert_eq!(out[3], json!([false, false, false, false]));
	assert_eq!(out[4], 0);
}
