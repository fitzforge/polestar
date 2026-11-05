//! Upgrade arrows on bag items (addon/Polestar/Gear/Bags.lua): the reward panel's green arrow on each item in the
//! bags that Gear calls an upgrade, in the client's bags (each container frame's UpdateItems, post-hooked) and in
//! Baganator (a corner widget); redrawn as the verdicts change.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

// Items in the generated ItemDB format (forge-data gear/leveling.rs encode, `forge data itemdb`).
const ITEMS: &str = r#"{
	[9001] = "1 20 15 2 4 3 str5 sta3 armor150",
	[9002] = "1 25 20 2 4 3 str10 sta4 armor170",
	[9004] = "1 20 15 2 4 1 int10 spi5 armor30",
	[9005] = "1 35 30 2 4 4 str8 sta8 armor300",
	[9006] = "1 25 20 2 4 3 str10 sta4 armor170 crit1",
	[9040] = "16 20 15 2 4 1 sta3",
}"#;

// A level 30 Troll Warrior wearing the 9001 helm. In the bags: 9002 (a better helm, +62%), 9004 (a cloth cap, a
// downgrade), 9005 (plate: an upgrade only at level 40) and 9040 (a cloak for the empty back slot).
const BAGS: &str = r#"
g.equip(1, "item:9001")
g.bag(0, 1, "item:9002"); g.bag(0, 2, "item:9004"); g.bag(0, 3, "item:9005"); g.bag(0, 4, "item:9040")
"#;

const HELPERS: &str = r#"
local T = Polestar.Theme
local function arrow(button)
	for _, r in ipairs(button.regions) do
		if type(r.texture) == "string" and r.texture:find("qol%-upgrade$") then return r end
	end
	return nil
end
local function arrows(bag, combined)
	local out = {}
	for slot = 1, 16 do
		local a = arrow(g.bagButton(bag, slot, combined))
		if a and a:IsShown() then out[#out + 1] = slot end
	end
	return out
end
local function keys(t)
	local out = {}
	for k in pairs(t) do out[#out + 1] = tostring(k) end
	table.sort(out)
	return table.concat(out, ",")
end
"#;

const SCRIPT_HEAD: &str = r#"G = Polestar.Gear
Polestar.ItemDB.Register({ schema = 1, build = "test" }, "#;

fn run(script: &str, before: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gear.lua"],
		before: format!(
			"w = stub.world; g = stub.gear
w.class, w.className, w.classID, w.level = \"WARRIOR\", \"Warrior\", 1, 30
w.race, w.raceName, w.raceID, w.faction = \"Troll\", \"Troll\", 8, \"Horde\"
{before}"
		),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml"])],
		login: true,
		script: [SCRIPT_HEAD, ITEMS, ")\n", HELPERS, "\n", script].concat(),
		..Default::default()
	})
}

fn bags(script: &str) -> String {
	[BAGS, script].concat()
}

#[test]
fn the_client_s_bags_a_green_arrow_on_each_upgrade_top_left_under_the_search_overlay_none_on_a_downgrade_or_an_item_for_a_later_level() {
	let [marked, look, untouched, under]: [Value; 4] = run(
		&bags(
			r#"
		local button = g.bagButton(0, 1)
		local before = keys(button)
		g.openBag(0)
		emit(arrows(0))
		local a = arrow(button)
		local r, gr, b = a:GetVertexColor()
		local sr, sg, sb = T.Color("success")
		local point, rel, relPoint = a:GetPoint(1)
		emit({ tint = r == sr and gr == sg and b == sb, layer = a.layer, sublayer = a.sublayer, size = { a:GetSize() },
			point = point, onButton = rel == button, relPoint = relPoint })
		emit(keys(button) == before)
		emit(table.concat(stub.underGameFrames, "; "))
	"#,
		),
		"",
	)
	.try_into()
	.unwrap();
	assert_eq!(marked, json!([1, 4]), "the better helm and the cloak for the empty slot");
	assert_eq!(look, json!({ "tint": true, "layer": "OVERLAY", "sublayer": 3, "size": [20, 20], "point": "TOPLEFT", "onButton": true, "relPoint": "TOPLEFT" }));
	assert_eq!(untouched, true, "nothing is written into the bag button's table");
	assert_eq!(under, "", "no frame is made under a game frame");
}

#[test]
fn the_client_s_bags_arrows_follow_the_verdict_a_better_piece_worn_a_bag_change_the_setting_gear_advice_off_redrawn_once_per_burst() {
	let [first, worn, added, off, on, gear_off, burst]: [Value; 7] = run(
		&bags(
			r#"
		g.openBag(0)
		emit(arrows(0))
		g.equip(1, "item:9006")
		stub.advance(0.25)
		emit(arrows(0))
		g.bag(0, 5, "item:9040")
		emit(arrows(0))
		Polestar.Set("gear.bagArrows", false); stub.advance(0.25)
		emit(arrows(0))
		Polestar.Set("gear.bagArrows", true); stub.advance(0.25)
		emit(arrows(0))
		Polestar.Set("gear.enabled", false); stub.advance(0.25)
		emit(arrows(0))
		Polestar.Set("gear.enabled", true); stub.advance(0.25)
		local redraws, redraw = 0, G.Bags.Redraw
		G.Bags.Redraw = function() redraws = redraws + 1; redraw() end
		for _ = 1, 10 do stub.fire("GET_ITEM_INFO_RECEIVED", 9002, true) end
		stub.advance(0.25)
		emit(redraws)
	"#,
		),
		"",
	)
	.try_into()
	.unwrap();
	assert_eq!(first, json!([1, 4]));
	assert_eq!(worn, json!([4]), "the 9002 helm is no upgrade over the 9006 helm now worn");
	assert_eq!(added, json!([4, 5]), "a cloak put in the bag gets its arrow as the bag updates");
	assert_eq!(off, json!({}), "gear.bagArrows off (an empty list)");
	assert_eq!(on, json!([4, 5]));
	assert_eq!(gear_off, json!({}), "gear advice off (an empty list)");
	assert_eq!(burst, 1, "ten new verdicts in a burst redraw the bags once");
}

#[test]
fn the_client_s_bags_the_combined_backpack_gets_the_arrows_too_closed_bags_are_left_alone() {
	let [combined, closed]: [Value; 2] = run(
		&bags(
			r#"
		g.openCombined()
		emit(arrows(0, true))
		g.closeBags()
		g.equip(1, "item:9006")
		stub.advance(0.25)
		emit(arrows(0, true))
	"#,
		),
		"",
	)
	.try_into()
	.unwrap();
	assert_eq!(combined, json!([1, 4]));
	assert_eq!(closed, json!([1, 4]), "a closed frame keeps its arrows until the client updates it as it opens");
}

// Baganator's corner widget API (Baganator/API/Main.lua, RegisterCornerWidget: onUpdate(widget, details) -> show,
// onInit(button) -> region; the arrow's place and visibility are Baganator's).
const BAGANATOR: &str = r#"
__widgets, __refreshes = {}, {}
Baganator = {
	API = {
		RegisterCornerWidget = function(label, id, onUpdate, onInit, position, isFast)
			__widgets[#__widgets + 1] = { label = label, id = id, onUpdate = onUpdate, onInit = onInit, position = position }
		end,
		IsCornerWidgetActive = function(id) return id == "polestar_upgrade" end,
		RequestItemButtonsRefresh = function(reasons) __refreshes[#__refreshes + 1] = reasons or "all" end,
	},
	Constants = { RefreshReason = { ItemWidgets = 4, Searches = 16 } },
}"#;

#[test]
fn baganator_a_top_left_corner_widget_shows_the_arrow_on_upgrades_and_is_refreshed_when_the_verdicts_change() {
	let [reg, look, verdicts, refreshes]: [Value; 4] = run(
		&bags(
			r#"
		local w = __widgets[1]
		emit({ count = #__widgets, label = w.label, id = w.id, corner = w.position.corner, priority = w.position.priority })
		local button = CreateFrame("Button", nil, UIParent)
		local a = w.onInit(button)
		emit({ texture = a.texture:match("([%w-]+)$"), size = { a:GetSize() }, layer = a.layer })
		emit({
			w.onUpdate(a, { itemLink = "item:9002" }), w.onUpdate(a, { itemLink = "item:9004" }),
			w.onUpdate(a, { itemLink = "item:9005" }), w.onUpdate(a, { itemLink = "item:9040" }),
			w.onUpdate(a, {}), w.onUpdate(a, nil),
		})
		__refreshes = {}
		g.equip(1, "item:9006")
		stub.advance(0.25)
		emit(__refreshes)
	"#,
		),
		BAGANATOR,
	)
	.try_into()
	.unwrap();
	assert_eq!(reg, json!({ "count": 1, "label": "Polestar", "id": "polestar_upgrade", "corner": "top_left", "priority": 1 }));
	assert_eq!(look, json!({ "texture": "qol-upgrade", "size": [20, 20], "layer": "OVERLAY" }));
	assert_eq!(verdicts, json!([true, false, false, true, false, false]));
	assert_eq!(refreshes, json!([[4]]), "one item-widget refresh for the new verdicts");
}

#[test]
fn baganator_loaded_after_polestar_the_widget_registers_as_it_loads_once() {
	let [before, after]: [Value; 2] = run(
		&[
			r#"
		emit(#(__widgets or {}))
		"#,
			BAGANATOR,
			r#"
		stub.addonLoaded("Baganator")
		stub.addonLoaded("Baganator")
		emit(#__widgets)
	"#,
		]
		.concat(),
		"",
	)
	.try_into()
	.unwrap();
	assert_eq!(before, 0);
	assert_eq!(after, 1);
}

#[test]
fn the_client_s_bags_an_item_for_an_empty_slot_gets_the_arrow_even_when_the_weights_give_it_no_value_a_loss_a_later_level_item_and_a_filled_slot_do_not() {
	let out = run(
		&bags(
			r#"
		-- The wrist slot is empty. A warrior's weights give spell hit nothing.
		local function wrist(id, req, stat, n)
			g.defineItem("item:" .. id, { equipLoc = "INVTYPE_WRIST", classID = 4, subclassID = 3, minLevel = req, stats = { [stat] = n } })
		end
		wrist(8001, 10, "ITEM_MOD_HIT_SPELL_RATING_SHORT", 2) -- worth nothing, no loss
		wrist(8002, 10, "ITEM_MOD_STRENGTH_SHORT", -5) -- a loss
		wrist(8003, 40, "ITEM_MOD_HIT_SPELL_RATING_SHORT", 2) -- for a later level
		g.bag(0, 5, "item:8001"); g.bag(0, 6, "item:8002"); g.bag(0, 7, "item:8003")
		g.openBag(0)
		local empty = arrows(0)
		local verdict = { G.IsUpgrade("item:8001"), G.FillsEmptySlot("item:8001") }
		wrist(8005, 10, "ITEM_MOD_STRENGTH_SHORT", 1)
		g.equip(9, "item:8005")
		stub.advance(0.25)
		emit({ empty = empty, verdict = verdict, filled = arrows(0) })
	"#,
		),
		"",
	)
	.remove(0);
	assert_eq!(out["empty"], json!([1, 4, 5]), "the helm and the cloak as before, and the zero-value bracer; not the loss, not the level 40 one");
	assert_eq!(out["verdict"], json!([false, true]), "IsUpgrade is unchanged: no gain, no upgrade");
	assert_eq!(out["filled"], json!([1, 4]), "with the slot filled, the zero-value bracer is no upgrade");
}

#[test]
fn the_client_s_bags_an_item_the_class_cannot_use_gets_no_empty_slot_arrow_a_wand_for_a_warrior_whose_ranged_slot_is_empty() {
	let out = run(
		&bags(
			r#"
		g.defineItem("item:8101", { equipLoc = "INVTYPE_RANGEDRIGHT", classID = 2, subclassID = 19, minLevel = 10, stats = { ITEM_MOD_INTELLECT_SHORT = 2 } })
		g.bag(0, 5, "item:8101")
		g.openBag(0)
		emit({ arrows = arrows(0), fills = G.FillsEmptySlot("item:8101") })
	"#,
		),
		"",
	)
	.remove(0);
	assert_eq!(out, json!({ "arrows": [1, 4], "fills": false }));
}

// EllesmereUI Bags' item overlay API (EllesmereUIBags/EUI_Bags_Slots.lua): RegisterItemOverlayIcon(name, fn(button,
// data)) runs on every painted slot; the arrow goes on the button's _textOverlay; RefreshInventory rebuilds its
// whole window, which Polestar leaves to it.
const ELLESMERE: &str = r#"
EUI_Bags = { itemOverlayIcons = {}, refreshes = 0, shown = true }
function EUI_Bags.RegisterItemOverlayIcon(name, fn) EUI_Bags.itemOverlayIcons[name] = fn end
function EUI_Bags:IsShown() return self.shown end
function EUI_Bags:RefreshInventory() self.refreshes = self.refreshes + 1 end
function slot(link, bag, n)
	local button = CreateFrame("Button", nil, UIParent)
	button._textOverlay = CreateFrame("Frame", nil, button)
	return button, { bag = bag, slot = n, itemLink = link }
end
function paint(button, data) EUI_Bags.itemOverlayIcons.Polestar(button, data) end
function shown(button)
	for _, r in ipairs(button._textOverlay.regions) do
		if type(r.texture) == "string" and r.texture:find("qol%-upgrade$") then return r:IsShown() end
	end
	return false
end"#;

#[test]
fn ellesmereui_bags_a_painter_puts_the_arrow_bottom_left_on_the_slot_s_overlay_for_upgrades_and_takes_it_off_when_the_verdict_changes() {
	let [reg, verdicts, look, after]: [Value; 4] = run(
		&bags(
			r#"
		emit({ names = keys(EUI_Bags.itemOverlayIcons) })
		local a, da = slot("item:9002", 0, 1)
		local b, db = slot("item:9004", 0, 2)
		local c = slot(nil, 0, 0)
		paint(a, da); paint(b, db); paint(c, {})
		emit({ shown(a), shown(b), shown(c) })
		local r
		for _, x in ipairs(a._textOverlay.regions) do if x.texture then r = x end end
		emit({ size = { r:GetSize() }, layer = r.layer, point = r.points[1].point })
		g.equip(1, "item:9006")
		paint(a, da)
		emit(shown(a))
	"#,
		),
		ELLESMERE,
	)
	.try_into()
	.unwrap();
	assert_eq!(reg, json!({ "names": "Polestar" }));
	assert_eq!(verdicts, json!([true, false, false]));
	assert_eq!(look, json!({ "size": [20, 20], "layer": "OVERLAY", "point": "BOTTOMLEFT" }));
	assert_eq!(after, false, "a better piece worn: the same slot is no upgrade");
}

#[test]
fn ellesmereui_bags_the_link_comes_from_the_bag_slot_when_the_data_has_none_the_setting_and_gear_advice_off_take_the_arrow_off() {
	let [from_slot, off, disabled]: [Value; 3] = run(
		&bags(
			r#"
		local a, da = slot(nil, 0, 1)
		paint(a, da)
		emit(shown(a))
		Polestar.Set("gear.bagArrows", false)
		paint(a, da)
		emit(shown(a))
		Polestar.Set("gear.bagArrows", true)
		Polestar.Set("gear.enabled", false)
		paint(a, da)
		emit(shown(a))
	"#,
		),
		ELLESMERE,
	)
	.try_into()
	.unwrap();
	assert_eq!(from_slot, true);
	assert_eq!(off, false);
	assert_eq!(disabled, false);
}

#[test]
fn ellesmereui_bags_new_verdicts_re_mark_the_shown_slots_from_their_last_painted_link_in_combat_too_without_rebuilding_its_window() {
	let out = run(
		&bags(
			r#"
		local a, da = slot("item:9002", 0, 1)
		paint(a, da)
		local before = shown(a)
		g.equip(1, "item:9006")
		stub.advance(0.25)
		local better = shown(a)
		stub.inCombat = true
		g.equip(1, "item:9001")
		stub.advance(0.25)
		emit({ before = before, better = better, combat = shown(a), refreshes = EUI_Bags.refreshes })
	"#,
		),
		ELLESMERE,
	)
	.remove(0);
	assert_eq!(out, json!({ "before": true, "better": false, "combat": true, "refreshes": 0 }));
}

#[test]
fn ellesmereui_bags_loaded_after_polestar_the_painter_registers_as_it_loads_once() {
	let [before, after]: [Value; 2] = run(
		&[
			r#"
		emit(EUI_Bags == nil)
		"#,
			ELLESMERE,
			r#"
		stub.addonLoaded("EllesmereUIBags")
		stub.addonLoaded("EllesmereUIBags")
		emit(keys(EUI_Bags.itemOverlayIcons))
	"#,
		]
		.concat(),
		"",
	)
	.try_into()
	.unwrap();
	assert_eq!(before, true);
	assert_eq!(after, "Polestar");
}

#[test]
fn leave_bag_arrows_to_pawn_hides_the_bag_arrows_only_while_pawn_is_installed() {
	let [off, with_pawn, hidden, no_pawn]: [Value; 4] = run(
		&bags(
			r#"
		emit(G.Bags.IsOn())
		C_AddOns = { IsAddOnLoaded = function(n) return n == "Pawn" end }
		Polestar.Set("gear.hideForPawn", true)
		emit(G.Bags.IsOn())
		Polestar.Set("gear.hideForPawn", false)
		emit(G.Bags.IsOn())
		C_AddOns = nil
		Polestar.Set("gear.hideForPawn", true)
		emit(G.Bags.IsOn())
	"#,
		),
		"",
	)
	.try_into()
	.unwrap();
	assert_eq!(off, true);
	assert_eq!(with_pawn, false);
	assert_eq!(hidden, true);
	assert_eq!(no_pawn, true);
}

#[test]
fn ellesmereui_bags_the_arrow_takes_the_new_success_colour_when_the_look_changes() {
	let out = run(
		&bags(
			r#"
		local a, da = slot("item:9002", 0, 1)
		paint(a, da)
		local r
		for _, x in ipairs(a._textOverlay.regions) do if x.texture then r = x end end
		Polestar.Set("ui.skin", "halo")
		local want = { T.Color("success") }
		local got = { r:GetVertexColor() }
		emit({ want = { want[1], want[2], want[3] }, got = { got[1], got[2], got[3] } })
	"#,
		),
		ELLESMERE,
	)
	.remove(0);
	assert_eq!(out["got"], out["want"]);
}
