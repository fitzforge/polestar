//! Bags and supplies (addon/Polestar/QoL): bag space and the two-press junk delete (Space.lua and the bag
//! button in Buttons.lua), junk and keep marks (Marks.lua, with the merchant's selling in Vendor.lua), gear
//! from loot or a merchant offered to wear (Wear.lua), restocking at a merchant on a press (Restock.lua), and
//! their guide-window banners (UI/GuideFrame.lua) and per-character option sliders (Theme/Widgets.lua).
//! Section 1 runs the real QoL against tests/lua/stub_qol.lua, as tests/qol.rs does; section 2 the banners on
//! stub_ui.lua with the QoL modules faked, as tests/class-quests.rs does.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 5] = ["Core/Init.lua", "Core/Compat.lua", "Core/Hooks.lua", "Theme/Theme.xml", "QoL/QoL.xml"];

const PRELUDE: &str = r#"
local q = stub.qol
local QoL = Polestar.QoL
local function set(k, v) Polestar.Set("qol." .. k, v); stub.runTimers() end
local function calls(name)
	local out = {}
	for _, c in ipairs(q.calls) do if c[1] == name then out[#out + 1] = c[2] or true end end
	return out
end
local function printed(pattern)
	for _, m in ipairs(stub.messages) do if m:find(pattern) then return true end end
	return false
end
local function bagsChanged() stub.fire("BAG_UPDATE_DELAYED"); stub.advance(0.1) end
"#;

fn run_with(script: &str, before: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_qol.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		before: before.into(),
		saved: vec![],
		login: true,
		script: format!("{PRELUDE}{script}"),
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, "")
}

// ---------------------------------------------------------------------------
// Section 1: QoL
// ---------------------------------------------------------------------------

// Bag 0 (16 slots) holds two fangs (14c), a shell (3c), an uncommon ring and cloth in slots 4..16 less `free`;
// bag 1 is a quiver, whose free slots never count.
const BAGS: &str = r#"
	q.items[1] = { name = "Broken Fang", quality = 0, price = 7 }
	q.items[2] = { name = "Cracked Shell", quality = 0, price = 3 }
	q.items[3] = { name = "Linen Cloth", quality = 1, price = 13 }
	q.items[5] = { name = "Jade Ring", quality = 2, price = 900 }
	q.bags[1] = { size = 6, slots = {}, family = 1 }
	local function fill(free)
		q.bags[0].slots = {}
		q.addItem(0, 1, 1, 2)
		q.addItem(0, 2, 2, 1)
		q.addItem(0, 3, 5, 1)
		for slot = 4, 16 - free do q.addItem(0, slot, 3, 1) end
	end
"#;

#[test]
fn bag_space_counts_free_slots_of_ordinary_bags_only_and_the_bag_button_comes_up_at_the_threshold_with_the_cheapest_junk() {
	let out = run(&[
		BAGS,
		r#"
		local S, b = QoL.Space, QoL.Buttons.bag
		fill(3)
		bagsChanged()
		local f, t = S.Free()
		emit({ free = f, total = t, shown = b:IsShown() and true or false })
		fill(2)
		bagsChanged()
		emit({ free = (S.Free()), shown = b:IsShown() and true or false, junk = S.Junk().id, count = b.Count:GetText() })
		set("bagSpace", false)
		bagsChanged()
		emit(b:IsShown() and true or false)
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "free": 3, "total": 16, "shown": false }), "the quiver's six free slots never count");
	assert_eq!(out[1], json!({ "free": 2, "shown": true, "junk": 2, "count": "2" }), "the shell (3c) is cheaper than two fangs (14c)");
	assert_eq!(out[2], false, "off with qol.bagSpace");
}

#[test]
fn bag_button_deletes_only_on_a_second_press_within_five_seconds_and_only_the_item_it_armed() {
	let out = run(&[
		BAGS,
		r#"
		local S, b = QoL.Space, QoL.Buttons.bag
		fill(0)
		bagsChanged()
		q.click(b)
		emit({ deleted = #calls("DeleteCursorItem"), label = b.Label:GetText() })
		q.click(b)
		stub.advance(0.1)
		emit({ deleted = q.deleted, said = printed("Deleted |Hitem:2|h%[Cracked Shell%]|h%.") })

		q.click(b)                      -- arms the fangs
		stub.advance(6)                 -- too late: the next press arms again
		q.click(b)
		emit(#q.deleted)

		q.bags[0].slots[1] = { itemID = 5, stackCount = 1 }   -- the ring takes the fangs' slot
		q.click(b)
		emit({ deleted = #q.deleted, shown = b:IsShown() and true or false })

		q.addItem(0, 2, 1, 1)
		bagsChanged()
		q.cursor = { 0, 3 }             -- something already on the cursor
		q.click(b); q.click(b)
		emit(#q.deleted)
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "deleted": 0, "label": "Press again to delete" }), "the first press only arms");
	assert_eq!(out[1], json!({ "deleted": [2], "said": true }));
	assert_eq!(out[2], 1, "an armed item goes back to safe after five seconds");
	assert_eq!(out[3], json!({ "deleted": 1, "shown": false }), "no junk left: the ring is never deleted");
	assert_eq!(out[4], 1, "never with something on the cursor");
}

#[test]
fn marks_ctrl_alt_click_cycles_junk_keep_and_clear_junk_is_sold_kept_greys_are_not_and_never_deleted() {
	let out = run(&[
		BAGS,
		r#"
		local M, S = QoL.Marks, QoL.Space
		local cloth = "|Hitem:3|h[Linen Cloth]|h"
		stub.keys.ctrl, stub.keys.alt = true, true
		Polestar.Hooks.OnItemClick(cloth)
		local first = M.Get(3)
		Polestar.Hooks.OnItemClick(cloth)
		local second = M.Get(3)
		Polestar.Hooks.OnItemClick(cloth)
		local third = M.Get(3)
		stub.keys.ctrl = false
		Polestar.Hooks.OnItemClick(cloth)   -- Alt alone is the Lookup's
		emit({ first = first, second = second, third = third or false, altOnly = M.Get(3) or false,
			said = printed("Linen Cloth%]|h is junk now") })
		stub.keys.alt = false

		fill(0)
		M.Set(3, "junk")
		M.Set(2, "keep")
		bagsChanged()
		emit(S.Junk().id)                    -- the shell is kept: a cloth (13c) beats the two fangs (14c)
		q.openMerchant()
		stub.advance(3)
		local sold = {}
		for _, id in ipairs(q.sold or {}) do sold[id] = (sold[id] or 0) + 1 end
		emit({ fangs = sold[1] or 0, shell = sold[2] or 0, cloth = sold[3] or 0, ring = sold[5] or 0 })
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "first": "junk", "second": "keep", "third": false, "altOnly": false, "said": true }));
	assert_eq!(out[1], 3, "a kept grey is never the one to delete; a junk-marked common one may be");
	assert_eq!(out[2], json!({ "fangs": 1, "shell": 0, "cloth": 13, "ring": 0 }), "junk-marked cloth sells; the kept shell and the ring stay");
}

#[test]
fn bag_banner_only_while_the_live_step_collects_and_dismissed_until_the_bags_have_room_again() {
	let out = run(&[
		BAGS,
		r#"
		local S = QoL.Space
		fill(1)
		bagsChanged()
		q.step({ { t = "kill", target = "Kobold Vermin" } })
		emit(S.Banner() ~= nil)
		q.step({ { t = "collect", item = 900, itemName = "Candle", count = 8, quest = 7, oi = 1 } })
		local b = S.Banner()
		emit({ free = b.free, junk = b.junk.id, armed = b.armed })
		S.Press()
		emit(S.Banner().armed)
		S.Dismiss()
		emit(S.Banner() ~= nil)
		fill(4); bagsChanged()
		fill(1); bagsChanged()
		emit(S.Banner() ~= nil)
	"#,
	]
	.concat());
	assert_eq!(out[0], false, "no collect goal, no banner");
	assert_eq!(out[1], json!({ "free": 1, "junk": 2, "armed": false }));
	assert_eq!(out[2], true, "the banner's link arms like the button");
	assert_eq!(out[3], false, "dismissed");
	assert_eq!(out[4], true, "back once the bags filled up again");
}

const WEAR: &str = r#"
	q.items[11] = { name = "Sturdy Boots", quality = 2, equipLoc = "INVTYPE_FEET" }
	q.items[12] = { name = "Frayed Gloves", quality = 1, equipLoc = "INVTYPE_HAND" }
	q.items[14] = { name = "Ridge Helm", quality = 2, equipLoc = "INVTYPE_HEAD" }
	q.items[15] = { name = "Dusty Cloak", quality = 2, equipLoc = "INVTYPE_CLOAK" }
	q.items[16] = { name = "Rusted Belt", quality = 2, equipLoc = "INVTYPE_WAIST" }
	q.items[17] = { name = "Watcher's Bracers", quality = 2, equipLoc = "INVTYPE_WRIST" }
	local SLOT = { [11] = 8, [12] = 10, [14] = 1, [15] = 15, [16] = 6, [17] = 9 }
	Polestar.Gear = {
		IsEnabled = function() return true end,
		IsUpgrade = function(link)
			if link:find("item:12|", 1, true) then return false, -1 end
			return true, 4, 10
		end,
		CompareToEquipped = function(link) return { slot = SLOT[tonumber(link:match("item:(%d+)"))] } end,
		Client = { InventoryLink = function() return nil end },
		GetItemInfo = function() end,
		GainText = function(pct) return "+" .. math.floor(pct + 0.5) .. "%" end,
	}
	local function worn()
		local out = {}
		for _, c in ipairs(q.calls) do
			if c[1] == "EquipItemByName" then out[#out + 1] = c[2]:match("item:(%d+)") .. "@" .. tostring(c[3]) end
		end
		return out
	end
	local function loot(slot, id) q.addItem(0, slot, id, 1); stub.fire("BAG_UPDATE_DELAYED"); stub.advance(0.1) end
"#;

#[test]
fn wear_offers_new_gear_from_loot_puts_it_on_only_when_taken_and_remembers_a_no() {
	let out = run_with(
		&[
			WEAR,
			r#"
		local Wr = QoL.Wear
		emit(Wr.Offer() == nil)                 -- the boots were in the bags at login
		loot(2, 12)
		emit(Wr.Offer() == nil)                 -- no upgrade
		loot(3, 14)
		local o = Wr.Offer()
		emit({ id = o.id, slot = o.slot, worn = #worn() })
		Wr.Take()
		stub.advance(1)
		emit({ worn = worn(), said = printed("Wearing |Hitem:14|h%[Ridge Helm%]|h %(%+10%%%)"), next = Wr.Offer() == nil })

		loot(4, 15)
		Wr.Decline()
		q.bags[0].slots[4] = nil; bagsChanged()
		loot(4, 15)
		emit({ declined = QoL.State().wearDeclined[15], offered = Wr.Offer() ~= nil })

		QoL.Marks.Set(16, "junk")
		loot(5, 16)
		local kept = QoL.Kept
		QoL.Kept = function(id) if id == 17 then return 12 end end
		loot(6, 17)
		emit(Wr.Offer() == nil)
		QoL.Kept = kept

		Polestar.Gear.IsEnabled = function() return false end
		loot(7, 11)
		emit(Wr.Offer() == nil)
	"#,
		]
		.concat(),
		"stub.qol.addItem(0, 1, 11, 1)",
	);
	assert_eq!(out[0], true, "what the bags held at login is never offered");
	assert_eq!(out[1], true);
	assert_eq!(out[2], json!({ "id": 14, "slot": 1, "worn": 0 }), "offered, nothing worn until the press");
	assert_eq!(out[3], json!({ "worn": ["14@1"], "said": true, "next": true }));
	assert_eq!(out[4], json!({ "declined": true, "offered": false }), "Not this one is remembered for the item");
	assert_eq!(out[5], true, "junk-marked or needed by a later step: left alone");
	assert_eq!(out[6], true, "Gear advice off: no offers");
}

// A level 20 character with a gun: water at three levels, bread, shot, arrows and a reagent for sale.
const GOODS: &str = r#"
	q.level = 20
	q.items[30] = { name = "Refreshing Spring Water", quality = 1, classID = 0, spell = 430, spellName = "Drink", minLevel = 1 }
	q.items[31] = { name = "Melon Juice", quality = 1, classID = 0, spell = 1133, spellName = "Drink", minLevel = 15 }
	q.items[32] = { name = "Morning Glory Dew", quality = 1, classID = 0, spell = 1137, spellName = "Drink", minLevel = 45 }
	q.items[33] = { name = "Tough Hunk of Bread", quality = 1, classID = 0, spell = 433, spellName = "Food", minLevel = 1 }
	q.items[34] = { name = "Light Shot", quality = 1, classID = 6, subclassID = 3 }
	q.items[35] = { name = "Rough Arrow", quality = 1, classID = 6, subclassID = 2 }
	q.items[36] = { name = "Old Blunderbuss", quality = 1, classID = 2, subclassID = 3 }
	q.items[37] = { name = "Arcane Powder", quality = 1, classID = 5 }
	q.worn[18] = 36
	q.goods = {
		{ id = 30, price = 25, stackCount = 5 },
		{ id = 31, price = 100, stackCount = 5 },
		{ id = 32, price = 400, stackCount = 5 },
		{ id = 33, price = 25, stackCount = 5 },
		{ id = 34, price = 10, stackCount = 200, maxStack = 200 },
		{ id = 35, price = 10, stackCount = 200, maxStack = 200 },
		{ id = 37, price = 1000 },
	}
	local function bought()
		local out = {}
		for _, c in ipairs(q.calls) do if c[1] == "BuyMerchantItem" then out[#out + 1] = c[2] .. "x" .. c[3] end end
		return out
	end
"#;

#[test]
fn restock_buys_the_best_drink_for_the_level_the_gun_s_shot_and_set_items_only_when_its_button_is_pressed() {
	let out = run(&[
		GOODS,
		r#"
		local R = QoL.Restock
		R.Set("drink", 20)
		R.Set("ammo", 400)
		R.SetItem(37, 5)
		q.money = 100000
		q.addItem(0, 1, 30, 5)                 -- five waters already count
		q.openMerchant()
		stub.advance(1)
		local buy = R.Plan()
		emit({ bought = #bought(), items = #buy })
		R.Run()
		stub.advance(2)
		emit(bought())
		emit({ juice = printed("Bought 15 Melon Juice for 3s 0c"), shot = printed("Bought 400 Light Shot") })
		q.calls = {}
		R.Run()
		stub.advance(2)
		emit(#bought())
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "bought": 0, "items": 3 }), "nothing without the press");
	assert_eq!(out[1], json!(["2x15", "5x200", "5x200", "7x5"]), "Melon Juice (level 15, not 45), shot for the gun, five powders");
	assert_eq!(out[2], json!({ "juice": true, "shot": true }));
	assert_eq!(out[3], 0, "topped up: a second press buys nothing");
}

#[test]
fn restock_money_short_is_said_and_the_amounts_are_per_character_set_by_command() {
	let out = run(&[
		GOODS,
		r#"
		local R = QoL.Restock
		R.Command("drink 20")
		R.Command("|Hitem:37|h[Arcane Powder]|h 3")
		emit({ drink = R.Get("drink"), powder = R.GetItem(37), saved = QoL.State().restock.drink })
		q.money = 450
		q.openMerchant()
		stub.advance(1)
		R.Run()
		stub.advance(2)
		emit({ bought = bought(), short = printed("Not enough money to buy 3 Arcane Powder") })
		R.Command("|Hitem:37|h[Arcane Powder]|h 0")
		emit(R.GetItem(37))
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "drink": 20, "powder": 3, "saved": 20 }));
	assert_eq!(out[1], json!({ "bought": ["2x20"], "short": true }), "the juice fits the money, the powder does not");
	assert_eq!(out[2], 0, "0 forgets the item");
}

#[test]
fn options_restock_sliders_hold_per_character_amounts_through_get_and_set() {
	let out = run(
		r#"
		local controls
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			if spec.section == "Restock" then controls = spec.controls end
		end
		local kinds = {}
		for i, c in ipairs(controls) do kinds[i] = c.kind .. ":" .. tostring(c.key or "-") end
		emit(kinds)
		local W = Polestar.Widgets
		local drink = controls[2]
		local row = W.Slider(UIParent, drink.label, nil, drink.min, drink.max, drink.step, drink.format, drink.help, nil, { get = drink.get, set = drink.set })
		stub.RunScript(row.Slider, "OnMouseWheel", 1)
		stub.RunScript(row.Slider, "OnMouseWheel", 1)
		emit({ state = QoL.State().restock.drink, shown = row.Value:GetText() })
		stub.RunScript(row, "OnClick", "RightButton")
		emit({ state = QoL.State().restock.drink or false, shown = row.Value:GetText() })
	"#,
	);
	assert_eq!(out[0], json!(["toggle:qol.restock", "slider:-", "slider:-", "slider:-"]));
	assert_eq!(out[1], json!({ "state": 10, "shown": "10" }), "the wheel steps the character's amount, not a setting");
	assert_eq!(out[2], json!({ "state": false, "shown": "Off" }), "right-click clears it");
}

// ---------------------------------------------------------------------------
// Section 2: the guide window's banners
// ---------------------------------------------------------------------------

const UI_FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const UI_PRE: &str = r#"uistub.install()
stub.login()
local GF = Polestar.UI.GuideFrame
local B = GF.parts.banner
uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
local log = {}
local bags, offer
Polestar.QoL = {
	Money = function(c) return c .. "c" end,
	Space = {
		Banner = function() return bags end,
		ItemText = function(j) return j.link .. " x" .. j.count end,
		Press = function() log[#log + 1] = "press"; if bags then bags.armed = true end end,
		Dismiss = function() log[#log + 1] = "dismiss"; bags = nil end,
	},
	Wear = {
		Offer = function() return offer end,
		Take = function() log[#log + 1] = "take"; offer = nil end,
		Decline = function() log[#log + 1] = "decline"; offer = nil end,
		Dismiss = function() log[#log + 1] = "let go"; offer = nil end,
	},
}
Polestar.Gear = { GainText = function(p) return "+" .. p .. "%" end, SlotName = function(s) return s == 1 and "Head" or nil end }
"#;

fn run_ui(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", &UI_FILES)], script: format!("{UI_PRE}{script}"), ..Default::default() })
}

#[test]
fn banner_bags_full_offers_the_two_click_delete_and_close_dismisses_it() {
	let out = run_ui(
		r#"
		bags = { free = 0, junk = { id = 2, count = 2, value = 14, link = "[Broken Fang]" }, armed = false }
		Polestar.Fire("BAG_SPACE")
		emit({ shown = B:IsShown(), text = B.Text:GetText(), jump = B.Jump.Label:GetText(), close = B.Close:IsShown() })
		B.Jump:Click()
		emit(B.Jump.Label:GetText())
		B.Close:Click()
		emit({ shown = B:IsShown(), log = log })
	"#,
	);
	assert_eq!(out[0], json!({ "shown": true, "text": "Your bags are full.\nCheapest junk: [Broken Fang] x2 (14c)", "jump": "Delete it", "close": true }));
	assert_eq!(out[1], "Click again to delete it");
	assert_eq!(out[2], json!({ "shown": false, "log": ["press", "dismiss"] }));
}

#[test]
fn banner_gear_offer_wear_it_or_not_this_one() {
	let out = run_ui(
		r#"
		offer = { id = 14, link = "[Ridge Helm]", slot = 1, pct = 10 }
		Polestar.Fire("WEAR_OFFER")
		emit({ text = B.Text:GetText(), jump = B.Jump.Label:GetText(), later = B.Later.Label:GetText() })
		B.Jump:Click()
		offer = { id = 15, link = "[Dusty Cloak]", slot = 15 }
		Polestar.Fire("WEAR_OFFER")
		B.Later:Click()
		emit({ shown = B:IsShown(), log = log })
	"#,
	);
	assert_eq!(out[0], json!({ "text": "Upgrade: [Ridge Helm]  \u{b7}  +10%  \u{b7}  Head", "jump": "Wear it", "later": "Not this one" }));
	assert_eq!(out[1], json!({ "shown": false, "log": ["take", "decline"] }));
}
