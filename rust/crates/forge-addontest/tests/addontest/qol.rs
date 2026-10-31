//! Quality of Life (addon/Polestar/QoL): action buttons and their combat deferral, XP pace and splits, merchant,
//! quest rewards, flight masters, Hearthstone, death helper, questing toggles and the options page. Runs the real
//! Core/Init.lua + Compat + Theme + QoL against tests/lua/stub_qol.lua (fake Engine, Nav and Pins; secure frames
//! refuse changes in combat).

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, is_match, text, truthy, Addon, RunAddon};
use serde_json::{json, Value};
use std::collections::HashSet;

const FILES: [&str; 4] = ["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "QoL/QoL.xml"];

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
"#;

fn run_with(script: &str, before: &str, saved: Option<&str>) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_qol.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		before: before.into(),
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		login: true,
		script: format!("{PRELUDE}{script}"),
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, "", None)
}

/// The first `n` items of an emitted array (`slice(0, n)`).
fn head(v: &Value, n: usize) -> Value {
	Value::Array(v.as_array().unwrap()[..n].to_vec())
}

fn near(a: &Value, b: f64, eps: f64) {
	let a = a.as_f64().unwrap();
	assert!((a - b).abs() <= eps, "expected {b}, got {a}");
}

// ---------------------------------------------------------------------------
// Options
// ---------------------------------------------------------------------------

#[test]
fn options_every_qol_setting_is_registered_on_questing_or_quality_of_life_with_label_and_help() {
	let out = run(r#"
		local out = {}
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			if spec.page == "Quality of Life" or spec.page == "Questing" then
				for _, c in ipairs(spec.controls) do
					out[#out + 1] = { key = c.key, kind = c.kind, label = c.label, help = c.help, page = spec.page, tab = spec.tab, section = spec.section }
				end
			end
		end
		emit(out)
		local keys = {}
		for _, k in ipairs({ "itemButton", "targetButton", "hearthButton", "buttonScale", "xpTracker", "sellJunk", "autoRepair",
			"rewardHighlight", "rewardAutoPick", "flightAutoOpen", "flightHighlight", "deathHelper", "instantQuestText",
			"skipGossip", "fastLoot", "declineDuels", "repairGuild", "hideErrors", "autoReleasePvP", "declineGuildInvites",
			"declinePartyStrangers", "acceptPartyFriends", "acceptSummon", "acceptResurrect", "buyGoals", "trainAll",
			"rewardEquip", "autoBind", "hideQuestTracker" }) do keys[k] = Polestar.GetDefault("qol." .. k) end
		emit(keys)
	"#);
	let (specs, defaults) = (&out[0], &out[1]);
	let registered: HashSet<String> = specs
		.as_array()
		.unwrap()
		.iter()
		.filter(|c| truthy(&c["key"]))
		.map(|c| {
			let k = text(&c["key"]);
			k.strip_prefix("qol.").unwrap_or(k).to_string()
		})
		.collect();
	for key in defaults.as_object().unwrap().keys() {
		assert!(registered.contains(key.as_str()), "qol.{key} registered");
	}
	for c in specs.as_array().unwrap() {
		let name = if truthy(&c["key"]) { text(&c["key"]) } else { text(&c["label"]) };
		assert!(truthy(&c["label"]) && truthy(&c["help"]), "{name} has label and help");
		assert!(c["page"] == "Questing" || c["page"] == "Quality of Life");
		assert!(truthy(&c["tab"]) && truthy(&c["section"]));
	}
	assert_eq!(defaults["rewardAutoPick"], false, "auto-pick is off by default");
	assert_eq!(defaults["buyGoals"], false, "buying for the guide is off by default");
	assert_eq!(defaults["trainAll"], false, "learning at trainers is off by default");
	assert_eq!(defaults["rewardEquip"], false, "wearing rewards is off by default");
	assert_eq!(defaults["autoBind"], false, "binding the Hearthstone is off by default");
	assert_eq!(defaults["hideQuestTracker"], false, "the game's quest tracker shows by default");
	assert_eq!(defaults["sellJunk"], true);
}

// ---------------------------------------------------------------------------
// Quest item, Hearthstone and target buttons
// ---------------------------------------------------------------------------

#[test]
fn quest_item_button_the_current_use_goal_item_else_a_quest_log_item_else_a_usable_quest_item_one_of_the_step_s_open_quests_handed_over() {
	let out = run(r#"
		local b = PolestarQuestItemButton
		q.items[900] = { name = "Torch", classID = 12, spell = 11 }
		q.items[901] = { name = "Quest Wand", classID = 12 }
		q.items[902] = { name = "Bag Quest Thing", classID = 12, spell = 12 }
		q.items[903] = { name = "Bethor's Potion", classID = 12, spell = 13 }
		q.addItem(0, 1, 900, 2)
		q.step({ { t = "kill", target = "Wolf", quest = 5, oi = 1 }, { t = "use", item = 900, quest = 7, oi = 1 } })
		emit({ b:GetAttribute("type"), b:GetAttribute("item"), b:IsShown(), b.Count:GetText() })

		-- the use goal is done: the step's other quest has a log item
		q.specialItems[5] = 901
		q.addItem(0, 2, 901, 1)
		q.step({ { t = "kill", target = "Wolf", quest = 5, oi = 1 }, { t = "use", item = 900, quest = 7, status = "done" } })
		emit({ b:GetAttribute("item") or "nil", b:IsShown() })

		-- no log item: another quest's usable item (a reward, Bethor's Potion)
		-- first in the bags is never offered, without the quest database or with it
		q.specialItems[5] = nil
		q.bags[0].slots[1] = nil
		q.bags[0].slots[2] = nil
		q.addItem(0, 1, 903, 10)
		q.step({ { t = "kill", target = "Wolf", quest = 5, oi = 1 } })
		emit({ b:GetAttribute("item") or "nil", b:IsShown() })
		Polestar.QuestDB = { IsLoaded = function() return true end, HandsOver = function(quest, item) return quest == 5 and item == 902 end }
		q.step({ { t = "kill", target = "Wolf", quest = 5, oi = 1 } })
		emit({ b:GetAttribute("item") or "nil", b:IsShown() })

		-- the item quest 5 handed over, behind it in the bags: offered
		q.addItem(0, 3, 902, 1)
		q.step({ { t = "kill", target = "Wolf", quest = 5, oi = 1 } })
		emit({ b:GetAttribute("item") or "nil", b:IsShown() })

		-- a step without open quest goals: hidden
		q.step({ { t = "goto", map = 9000, x = 1, y = 1 } })
		emit({ b:GetAttribute("item") or "nil", b:IsShown() })

		-- setting off: nothing shown even for a use goal
		q.addItem(0, 1, 900, 2)
		set("itemButton", false)
		q.step({ { t = "use", item = 900, quest = 7, oi = 1 } })
		emit({ b:GetAttribute("item") or "nil", b:IsShown() })
	"#);
	assert_eq!(out[0], json!(["item", "item:900", true, "2"]));
	assert_eq!(out[1], json!(["item:901", true]));
	assert_eq!(out[2], json!(["nil", false]), "no quest database: no guess from the bags");
	assert_eq!(out[3], json!(["nil", false]), "another quest's item is never the step's");
	assert_eq!(out[4], json!(["item:902", true]));
	assert_eq!(out[5], json!(["nil", false]));
	assert_eq!(out[6], json!(["nil", false]));
}

#[test]
fn secure_buttons_changes_during_combat_wait_for_player_regen_enabled_display_still_updates() {
	let out = run(r#"
		local b, t = PolestarQuestItemButton, PolestarTargetButton
		q.items[900] = { name = "Torch" }
		q.items[903] = { name = "Bomb" }
		q.addItem(0, 1, 900, 1)
		q.addItem(0, 2, 903, 4)
		q.step({ { t = "use", item = 900, quest = 7 }, { t = "kill", target = "Murloc" } })
		q.combat(true)
		-- The step moves on mid-fight: these would be protected calls.
		q.step({ { t = "use", item = 903, quest = 8 }, { t = "kill", target = "Gnoll" } })
		set("buttonScale", 1.4)
		q.cooldowns[900] = { 100, 30 }
		stub.fire("BAG_UPDATE_COOLDOWN")
		emit({ b:GetAttribute("item"), t:GetAttribute("macrotext"), b:GetScale(), b.itemID })
		q.combat(false)
		emit({ b:GetAttribute("item"), t:GetAttribute("macrotext"), b:GetScale(), b.itemID, b.Count:GetText() })
	"#);
	assert_eq!(out[0], json!(["item:900", "/cleartarget [nocombat]\n/targetexact Murloc\n/cleartarget [dead]", 1, 900]));
	assert_eq!(out[1], json!(["item:903", "/cleartarget [nocombat]\n/targetexact Gnoll\n/cleartarget [dead]", 1.4, 903, "4"]));
}

#[test]
fn secure_buttons_the_name_sits_on_the_chosen_side_of_every_button() {
	let out = run(r#"
		local function side(b) local p, _, rp, x, y = b.Label:GetPoint(1); return { p, rp, x, y } end
		local all = { PolestarQuestItemButton, PolestarTargetButton, PolestarHearthButton }
		for _, v in ipairs({ "right", "left", "above", "below", "nonsense" }) do
			set("buttonTextSide", v)
			emit({ side(all[1]), side(all[2]), side(all[3]) })
		end
	"#);
	let at = |p: &str, rp: &str, x: i32, y: i32| json!([[p, rp, x, y], [p, rp, x, y], [p, rp, x, y]]);
	assert_eq!(out[0], at("LEFT", "RIGHT", 8, 0));
	assert_eq!(out[1], at("RIGHT", "LEFT", -8, 0));
	assert_eq!(out[2], at("BOTTOM", "TOP", 0, 4));
	assert_eq!(out[3], at("TOP", "BOTTOM", 0, -4));
	assert_eq!(out[4], at("LEFT", "RIGHT", 8, 0), "an unknown value falls back to the right");
}

#[test]
fn secure_buttons_an_above_name_sits_over_a_quest_item_button_shown_above_the_target_button() {
	let out = run(r#"
		local t = PolestarTargetButton
		local function over() local _, rel = t.Label:GetPoint(1); return rel and rel:GetName() end
		set("buttonTextSide", "above")
		q.step({ { t = "kill", target = "Murloc" } })
		emit({ over() })
		q.items[900] = { name = "Torch" }
		q.addItem(0, 1, 900, 1)
		q.step({ { t = "use", item = 900, quest = 7 }, { t = "kill", target = "Murloc" } })
		emit({ over() })
		q.step({ { t = "kill", target = "Gnoll" } })
		emit({ over() })
	"#);
	assert_eq!(out[0], json!(["PolestarTargetButton"]));
	assert_eq!(out[1], json!(["PolestarQuestItemButton"]), "clear of the quest item button, not in the gap under it");
	assert_eq!(out[2], json!(["PolestarTargetButton"]), "back on the target button once the item button goes");
}

#[test]
fn secure_buttons_a_login_under_combat_lockdown_reload_mid_fight_defers_every_protected_call() {
	let out = run_with(
		r#"
		q.items[900] = { name = "Torch" }
		q.addItem(0, 1, 900, 1)
		q.step({ { t = "use", item = 900, quest = 7 } })
		emit({ PolestarQuestItemButton:GetAttribute("item") or "nil", QoL.HasQueued("item:PolestarQuestItemButton") })
		q.combat(false)
		emit({ PolestarQuestItemButton:GetAttribute("item"), PolestarQuestItemButton:IsShown(), PolestarTargetButton:IsShown() })
	"#,
		"stub.inCombat = true",
		None,
	);
	assert_eq!(out[0], json!(["nil", true]));
	assert_eq!(out[1], json!(["item:900", true, false]));
}

#[test]
fn quest_item_button_range_tint_and_cooldown_follow_the_item() {
	let out = run_with(
		r#"
		local b = PolestarQuestItemButton
		q.items[900] = { name = "Torch" }
		q.addItem(0, 1, 900, 1)
		q.cooldowns[900] = { 50, 10 }
		q.step({ { t = "use", item = 900, quest = 7 } })
		q.target = true
		q.inRange = false
		stub.advance(0.3)
		emit({ b.Icon:GetVertexColor() })
		q.inRange = true
		stub.advance(0.3)
		emit({ b.Icon:GetVertexColor() })
		emit(b.Cooldown.cooldownSet or "n/a")
	"#,
		r#"local M = stub.Methods; function M.SetCooldown(self, s, d) self.cooldownSet = { s, d } end"#,
		None,
	);
	let (far, near_, cd) = (&out[0], &out[1], &out[2]);
	assert!(far[0].as_f64().unwrap() > 0.9 && far[1].as_f64().unwrap() < 0.6, "red when out of range");
	assert_eq!(*near_, json!([1, 1, 1, 1]));
	assert_eq!(*cd, json!([50, 10]));
}

#[test]
fn target_button_kill_targets_and_questdb_droppers_preferred_name_first_each_click_cycles() {
	let out = run(r#"
		local t = PolestarTargetButton
		q.step({
			{ t = "kill", target = "Kobold Vermin", quest = 7, oi = 1 },
			{ t = "collect", item = 950, itemName = "Candle", quest = 7, oi = 2 },
			{ t = "kill", target = "Done Mob", status = "done" },
		})
		-- no QuestDB yet: kill targets only
		emit(t:GetAttribute("macrotext"))
		Polestar.QuestDB = {
			IsLoaded = function() return true end,
			GetObjectiveMobs = function(quest, oi) if quest == 7 and oi == 2 then return { "Kobold Laborer", "Kobold Vermin" } end end,
		}
		Polestar.Fire("QUESTDB_LOADED")
		stub.runTimers()
		emit({ t:GetAttribute("type"), t:GetAttribute("macrotext"), t.Label:GetText() })
		q.click(t, true)   -- key down: no change
		emit(t:GetAttribute("macrotext"))
		q.click(t, false)  -- release: next name
		emit({ t:GetAttribute("macrotext"), t.Label:GetText() })
		q.combat(true)
		q.click(t, false)
		emit(t:GetAttribute("macrotext"))
		q.combat(false)
		emit(t:GetAttribute("macrotext"))
		q.step({ { t = "goto", map = 9000, x = 1, y = 1 } })
		emit({ t:GetAttribute("macrotext") or "nil", t:IsShown() })
	"#);
	assert_eq!(out[0], "/cleartarget [nocombat]\n/targetexact Kobold Vermin\n/cleartarget [dead]");
	assert_eq!(out[1], json!(["macro", "/cleartarget [nocombat]\n/targetexact Kobold Vermin\n/cleartarget [dead]\n/targetexact [noexists] Kobold Laborer\n/cleartarget [dead]", "Kobold Vermin"]));
	assert_eq!(out[2], out[1][1]);
	assert_eq!(out[3], json!(["/cleartarget [nocombat]\n/targetexact Kobold Laborer\n/cleartarget [dead]\n/targetexact [noexists] Kobold Vermin\n/cleartarget [dead]", "Kobold Laborer"]));
	assert_eq!(out[4], out[3][0], "no macro change in combat");
	assert_eq!(out[5], "/cleartarget [nocombat]\n/targetexact Kobold Vermin\n/cleartarget [dead]\n/targetexact [noexists] Kobold Laborer\n/cleartarget [dead]", "cycled once combat ended");
	assert_eq!(out[6], json!(["nil", false]));
}

#[test]
fn target_button_a_collect_names_the_mobs_the_arrow_leads_to_first_356_then_the_item_s_droppers() {
	let out = run(r#"
		local B = Polestar.QoL.Buttons
		local t = PolestarTargetButton
		local function names()
			local out = {}
			for i, n in ipairs(B.TargetNames()) do out[i] = n end
			return out
		end
		Polestar.QuestDB = {
			IsLoaded = function() return true end,
			-- The item's droppers, ranked by drop chance over the whole world:
			-- none of Small Spider Leg's best five is in Teldrassil.
			GetObjectiveMobs = function(quest, oi) if quest == 7 and oi == 1 then return { "Mother Fang", "Cliff Lurker", "Mist Creeper" } end end,
			GetItemDroppers = function(item) if item == 5465 then return { { name = "Mother Fang" }, { name = "Cliff Lurker" } } end end,
		}
		Polestar.Fire("QUESTDB_LOADED")
		stub.runTimers()
		-- The guide's own sources for this point come first, the one the point
		-- belongs to leading; the item's droppers follow.
		q.step({ { t = "collect", item = 5465, itemName = "Small Spider Leg", quest = 7, oi = 1,
			fromNpcs = { { npc = 1998, npcName = "Webwood Lurker" }, { npc = 2001, npcName = "Giant Webwood Spider" } } } })
		emit({ names(), t.Label:GetText() })
		-- A farm spot the engine chose (`collect … nearest`) comes before them.
		q.step({ { t = "collect", item = 5465, itemName = "Small Spider Leg", npc = 30, npcName = "Forest Spider",
			fromNpcs = { { npc = 1998, npcName = "Webwood Lurker" } } } })
		emit({ names(), t.Label:GetText() })
		-- Without either, the item's droppers alone, as before.
		q.step({ { t = "collect", item = 5465, itemName = "Small Spider Leg", quest = 7, oi = 1 } })
		emit({ names(), t.Label:GetText() })
		-- A name a guide pack could use to smuggle a second macro line is passed over.
		q.step({ { t = "collect", item = 5465, itemName = "Small Spider Leg",
			fromNpcs = { { npc = 1998, npcName = "Webwood Lurker\n/run X()" }, { npc = 2001, npcName = "Giant Webwood Spider" } } } })
		emit({ names(), t:GetAttribute("macrotext") })
		-- Without the quest database the guide's own sources still name the mobs.
		Polestar.QuestDB = nil
		q.step({ { t = "collect", item = 5465, itemName = "Small Spider Leg", quest = 7, oi = 1,
			fromNpcs = { { npc = 1998, npcName = "Webwood Lurker" } } } })
		emit(names())
	"#);
	assert_eq!(out[0], json!([["Webwood Lurker", "Giant Webwood Spider", "Mother Fang", "Cliff Lurker", "Mist Creeper"], "Webwood Lurker"]));
	assert_eq!(out[1], json!([["Forest Spider", "Webwood Lurker", "Mother Fang", "Cliff Lurker"], "Forest Spider"]));
	assert_eq!(out[2], json!([["Mother Fang", "Cliff Lurker", "Mist Creeper"], "Mother Fang"]));
	assert_eq!(out[3][0], json!(["Giant Webwood Spider", "Mother Fang", "Cliff Lurker"]), "the name with a line break is passed over");
	assert!(!text(&out[3][1]).contains("/run X()"), "and never reaches the macro");
	assert_eq!(out[4], json!(["Webwood Lurker"]));
}

#[test]
fn target_button_every_open_goal_gets_a_name_one_goal_s_many_mobs_do_not_crowd_out_the_rest_571() {
	let out = run(r#"
		local B = Polestar.QoL.Buttons
		local t = PolestarTargetButton
		Polestar.QuestDB = {
			IsLoaded = function() return true end,
			GetObjectiveMobs = function(quest, oi)
				if quest ~= 488 then return nil end
				if oi == 1 then return { "Elder Nightsaber", "Feral Nightsaber", "Nightsaber", "Nightsaber Stalker", "Duskstalker" } end
				if oi == 2 then return { "Strigid Owl", "Strigid Screecher", "Strigid Hunter" } end
				if oi == 3 then return { "Webwood Lurker", "Webwood Venomfang", "Webwood Silkspinner", "Giant Webwood Spider" } end
			end,
		}
		Polestar.Fire("QUESTDB_LOADED")
		stub.runTimers()
		-- Zenn's Bidding: the fang's five droppers come first in guide order.
		q.step({
			{ t = "collect", item = 3409, quest = 488, oi = 1, fromNpcs = { { npc = 2042, npcName = "Nightsaber" },
				{ npc = 2033, npcName = "Elder Nightsaber" }, { npc = 2034, npcName = "Feral Nightsaber" },
				{ npc = 2043, npcName = "Nightsaber Stalker" }, { npc = 14430, npcName = "Duskstalker" } } },
			{ t = "collect", item = 3411, quest = 488, oi = 2 },
			{ t = "collect", item = 3412, quest = 488, oi = 3 },
		})
		local out = {}
		for i, n in ipairs(B.TargetNames()) do out[i] = n end
		emit(out)
		emit(t:GetAttribute("macrotext"))
	"#);
	assert_eq!(out[0], json!(["Nightsaber", "Strigid Owl", "Webwood Lurker", "Elder Nightsaber", "Strigid Screecher"]));
	let mac = text(&out[1]);
	for name in ["Nightsaber", "Strigid Owl", "Webwood Lurker"] {
		assert!(mac.contains(&format!("/targetexact {name}\n")) || mac.contains(&format!("/targetexact [noexists] {name}\n")), "the macro tries {name}");
	}
}

#[test]
fn step_key_one_binding_does_the_step_s_next_action_the_npc_the_quest_item_the_mobs_or_the_hearthstone_in_guide_order() {
	let out = run(r#"
		local s = PolestarStepButton
		local function now() return { s:GetAttribute("type") or "nil", s:GetAttribute("item") or s:GetAttribute("macrotext") or "nil" } end
		q.items[900] = { name = "Torch" }
		q.items[901] = { name = "Quest Wand", classID = 12 }
		q.items[6948] = { name = "Hearthstone" }
		q.addItem(0, 1, 900, 1)
		q.addItem(0, 2, 6948, 1)
		-- the NPC of the first open goal
		q.step({ { t = "accept", quest = 7, npc = 197, npcName = "Marshal McBride" }, { t = "kill", target = "Kobold Vermin", quest = 7, oi = 1 } })
		emit(now())
		-- accepted: the mobs, each press the next name
		q.step({ { t = "accept", quest = 7, npc = 197, npcName = "Marshal McBride", status = "done" },
			{ t = "kill", target = "Kobold Vermin", quest = 7, oi = 1 }, { t = "kill", target = "Kobold Worker", quest = 8, oi = 1 } })
		emit(now())
		q.click(s, true)
		q.click(s, false)
		emit(now())
		-- a use goal first: the item
		q.step({ { t = "use", item = 900, quest = 9, oi = 1 }, { t = "kill", target = "Wolf" } })
		emit(now())
		-- a collect with no known mobs does not jump the use goal after it
		q.step({ { t = "collect", item = 950, quest = 9, oi = 2 }, { t = "use", item = 900, quest = 9, oi = 1 }, { t = "kill", target = "Wolf" } })
		emit(now())
		-- a hearth goal
		q.step({ { t = "hearth", location = "Goldshire" }, { t = "turnin", quest = 9, npc = 240, npcName = "Marshal Dughan" } })
		emit(now())
		-- nothing to press for but the quest's log item: that item
		q.specialItems[10] = 901
		q.addItem(0, 3, 901, 1)
		q.step({ { t = "goto", map = 9000, x = 1, y = 1 }, { t = "complete", quest = 10 } })
		emit(now())
		-- nothing at all
		q.step({ { t = "goto", map = 9000, x = 1, y = 1 } })
		emit(now())
		-- the visible buttons off: the key still works
		set("itemButton", false)
		set("targetButton", false)
		q.step({ { t = "kill", target = "Murloc" } })
		emit(now())
		-- mid-fight it keeps what it did until combat ends
		q.combat(true)
		q.step({ { t = "turnin", quest = 9, npc = 240, npcName = "Marshal Dughan" } })
		emit(now())
		q.combat(false)
		emit(now())
		emit(s:IsShown())
	"#);
	assert_eq!(out[0], json!(["macro", "/cleartarget [nocombat]\n/targetexact Marshal McBride\n/cleartarget [dead]"]));
	assert_eq!(out[1], json!(["macro", "/cleartarget [nocombat]\n/targetexact Kobold Vermin\n/cleartarget [dead]\n/targetexact [noexists] Kobold Worker\n/cleartarget [dead]"]));
	assert_eq!(
		out[2],
		json!(["macro", "/cleartarget [nocombat]\n/targetexact Kobold Worker\n/cleartarget [dead]\n/targetexact [noexists] Kobold Vermin\n/cleartarget [dead]"]),
		"a press moves to the next name"
	);
	assert_eq!(out[3], json!(["item", "item:900"]));
	assert_eq!(out[4], json!(["item", "item:900"]), "guide order: the collect has no mobs to target");
	assert_eq!(out[5], json!(["item", "item:6948"]));
	assert_eq!(out[6], json!(["item", "item:901"]));
	assert_eq!(out[7], json!(["nil", "nil"]));
	assert_eq!(out[8], json!(["macro", "/cleartarget [nocombat]\n/targetexact Murloc\n/cleartarget [dead]"]));
	assert_eq!(out[9], json!(["macro", "/cleartarget [nocombat]\n/targetexact Murloc\n/cleartarget [dead]"]), "no change in combat");
	assert_eq!(out[10], json!(["macro", "/cleartarget [nocombat]\n/targetexact Marshal Dughan\n/cleartarget [dead]"]));
	assert_eq!(out[11], false, "a key only: no button on screen");
}

#[test]
fn step_key_the_route_s_own_goals_come_before_optional_ones_and_an_npc_name_with_a_control_character_is_passed_over_never_put_in_the_macro() {
	let out = run(r#"
		local s = PolestarStepButton
		local function now() return { s:GetAttribute("type") or "nil", s:GetAttribute("item") or s:GetAttribute("macrotext") or "nil" } end
		-- an optional accept first: the route's kill takes the key
		q.step({ { t = "accept", quest = 7, npc = 197, npcName = "Marshal McBride", optional = true }, { t = "kill", target = "Kobold Vermin", quest = 8, oi = 1 } })
		emit(now())
		-- the route's own turn-in after an optional accept: the turn-in's NPC
		q.step({ { t = "accept", quest = 7, npc = 197, npcName = "Marshal McBride", optional = true }, { t = "turnin", quest = 9, npc = 240, npcName = "Marshal Dughan" } })
		emit(now())
		-- only optional goals open: the optional one still gets the key
		q.step({ { t = "turnin", quest = 9, npc = 240, npcName = "Marshal Dughan", status = "done" }, { t = "accept", quest = 7, npc = 197, npcName = "Marshal McBride", optional = true } })
		emit(now())
		-- a line break or other control character in the name: that goal is
		-- passed over and the key does the next one
		q.step({ { t = "talk", npc = 241, npcName = "Marshal\r\nDughan\n/run print(1)" }, { t = "kill", target = "Kobold Vermin" } })
		emit(now())
		q.step({ { t = "talk", npc = 241, npcName = "Marshal\tDughan" } })
		emit(now())
	"#);
	assert_eq!(out[0], json!(["macro", "/cleartarget [nocombat]\n/targetexact Kobold Vermin\n/cleartarget [dead]"]), "an optional accept does not take the key");
	assert_eq!(out[1], json!(["macro", "/cleartarget [nocombat]\n/targetexact Marshal Dughan\n/cleartarget [dead]"]));
	assert_eq!(out[2], json!(["macro", "/cleartarget [nocombat]\n/targetexact Marshal McBride\n/cleartarget [dead]"]), "optional goals still count once the route's are done");
	assert_eq!(out[3], json!(["macro", "/cleartarget [nocombat]\n/targetexact Kobold Vermin\n/cleartarget [dead]"]), "the unsafe NPC goal is passed over");
	assert_eq!(out[4], json!(["nil", "nil"]), "a tab is a control character too: no macro");
}

#[test]
fn mark_target_off_by_default_on_the_target_button_and_step_key_put_a_skull_on_a_live_hostile_mob_and_a_star_on_an_npc_friendly_or_neutral_never_take_one_off_and_clear_the_target_only_out_of_combat()
{
	let out = run(r#"
		local t, s = PolestarTargetButton, PolestarStepButton
		q.step({ { t = "kill", target = "Kobold Vermin", quest = 7, oi = 1 } })
		emit({ t:GetAttribute("macrotext"), s:GetAttribute("macrotext") })
		set("markTarget", true)
		emit({ t:GetAttribute("macrotext"), s:GetAttribute("macrotext") })
		q.step({ { t = "turnin", quest = 9, npc = 240, npcName = "Marshal Dughan" } })
		emit(s:GetAttribute("macrotext"))
		set("markTarget", false)
		emit(s:GetAttribute("macrotext"))
		local long = {}
		for i = 1, 5 do long[i] = string.rep("N", 50) .. i end
		emit(Polestar.QoL.Buttons.TargetMacro(long, 1, "/tm [@target,harm,nodead] !8"))
	"#);
	let plain = |name: &str| format!("/cleartarget [nocombat]\n/targetexact {name}\n/cleartarget [dead]");
	assert_eq!(out[0], json!([plain("Kobold Vermin"), plain("Kobold Vermin")]), "off by default");
	// Cleared first: when no name is in range, nothing is left targeted to mark.
	// Not in a fight, where clearing the target would stop melee and Auto Shot.
	let skull = plain("Kobold Vermin") + "\n/tm [@target,harm,nodead] !8";
	assert_eq!(out[1], json!([skull, skull]));
	assert_eq!(out[2], (plain("Marshal Dughan") + "\n/tm [@target,exists,nodead,nocombat][@target,noharm,nodead] !1").as_str());
	assert_eq!(out[3], plain("Marshal Dughan").as_str(), "turned off again");
	let long = text(&out[4]);
	assert!(long.len() <= 255, "fits a macro");
	assert!(long.starts_with(&format!("/cleartarget [nocombat]\n/targetexact {}1\n", "N".repeat(50))), "the preferred name stays first when names are dropped");
	assert!(long.ends_with("\n/cleartarget [dead]\n/tm [@target,harm,nodead] !8"), "and the mark stays last");
}

#[test]
fn mark_target_the_icon_for_mobs_and_for_npcs_is_a_setting_a_new_one_each_press_skips_the_other_s_and_leaves_a_marked_npc_as_it_is() {
	let out = run(r#"
		local t, s = PolestarTargetButton, PolestarStepButton
		set("markTarget", true)
		set("markMob", "7")
		q.step({ { t = "kill", target = "Kobold Vermin", quest = 7, oi = 1 } })
		emit(t:GetAttribute("macrotext"))
		set("markNpc", "cycle")
		q.step({ { t = "turnin", quest = 9, npc = 240, npcName = "Marshal Dughan" } })
		local seen = {}
		for i = 1, 8 do
			seen[i] = s:GetAttribute("macrotext"):match("[~!]%d$")
			q.click(s, true)
			q.click(s, false)
		end
		emit(seen)
		set("markMob", "cycle")
		q.step({ { t = "kill", target = "Kobold Vermin", quest = 7, oi = 1 } })
		q.click(t, false)
		emit({ t:GetAttribute("macrotext"):match("[~!]%d$"), s:GetAttribute("macrotext"):match("[~!]%d$") })
		-- both cycle: the next NPC gets the next icon, not the mob's
		q.step({ { t = "turnin", quest = 9, npc = 240, npcName = "Marshal Dughan" } })
		emit(s:GetAttribute("macrotext"):match("[~!]%d$"))
		set("markNpc", "bogus")
		q.step({ { t = "turnin", quest = 9, npc = 240, npcName = "Marshal Dughan" } })
		emit(s:GetAttribute("macrotext"))
	"#);
	assert_eq!(out[0], "/cleartarget [nocombat]\n/targetexact Kobold Vermin\n/cleartarget [dead]\n/tm [@target,harm,nodead] !7");
	assert_eq!(out[1], json!(["~1", "~2", "~3", "~4", "~5", "~6", "~8", "~1"]), "cycles, skipping the mobs' icon");
	assert_eq!(out[2], json!(["~2", "~2"]), "the target button and the step key share the cycle");
	assert_eq!(out[3], "~2", "one count for both kinds: the NPC press after the mob's goes on from it");
	assert_eq!(
		out[4], "/cleartarget [nocombat]\n/targetexact Marshal Dughan\n/cleartarget [dead]\n/tm [@target,exists,nodead,nocombat][@target,noharm,nodead] !1",
		"an unknown setting falls back to the star"
	);
}

// Every CLICK binding in Bindings.xml shows its label in the key bindings window, and the step key's button is
// there from login (the travel button is made with the route's first cast leg: tests/nav-prompts.rs).
#[test]
fn key_bindings_each_click_binding_has_its_label_and_the_step_key_its_button_from_login() {
	let xml = std::fs::read_to_string(addons_dir().join("Polestar").join("Bindings.xml")).unwrap();
	let re = regex::Regex::new(r#"name="CLICK (\w+):LeftButton""#).unwrap();
	let names: Vec<String> = re.captures_iter(&xml).map(|m| m[1].to_string()).collect();
	assert!(names.iter().any(|n| n == "PolestarStepButton"));
	let list = names.iter().map(|n| format!("'{n}'")).collect::<Vec<_>>().join(", ");
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: r#"
			local labels = {}
			for _, n in ipairs({ __NAMES__ }) do
				local l = _G["BINDING_NAME_CLICK " .. n .. ":LeftButton"]
				labels[n] = type(l) == "string" and l ~= "" and not l:find("^CLICK ")
			end
			emit({ labels = labels, step = PolestarStepButton ~= nil })
		"#
		.replace("__NAMES__", &list),
		..Default::default()
	});
	let r = &out[0];
	for n in &names {
		assert_eq!(r["labels"][n.as_str()], true, "{n} has a label");
	}
	assert_eq!(r["step"], true, "the step key's button exists from login");
}

#[test]
fn target_button_a_name_with_a_line_break_or_other_control_character_never_reaches_the_macro_from_the_guide_or_from_questdb_a_pack_could_hide_run_in_it() {
	let out = run(r#"
		local t = PolestarTargetButton
		q.step({
			{ t = "kill", target = "Kobold Vermin\n/run SendMail(\"Thief\", \"x\", \"\")", quest = 7, oi = 1 },
			{ t = "kill", target = "Kobold Worker\r/script SetSendMailMoney(1)", quest = 7, oi = 2 },
		})
		emit({ t:GetAttribute("macrotext") or "nil", t:IsShown() })
		Polestar.QuestDB = {
			IsLoaded = function() return true end,
			GetObjectiveMobs = function() return { "Kobold Laborer", "Tunnel Rat\n/run X()" } end,
		}
		Polestar.Fire("QUESTDB_LOADED")
		q.step({ { t = "collect", item = 950, itemName = "Candle", quest = 7, oi = 3 } })
		stub.runTimers()
		emit(t:GetAttribute("macrotext"))
		emit(Polestar.QoL.Buttons.TargetMacro({ "Kobold Laborer", "Bad\n/run X()" }, 2))
	"#);
	assert_eq!(out[0], json!(["nil", false]), "only unsafe names: no macro, no button");
	assert_eq!(out[1], "/cleartarget [nocombat]\n/targetexact Kobold Laborer\n/cleartarget [dead]");
	assert_eq!(out[2], "/cleartarget [nocombat]\n/targetexact Kobold Laborer\n/cleartarget [dead]", "TargetMacro itself drops an unsafe name");
}

#[derive(Clone, Copy)]
struct Unit {
	name: &'static str,
	dead: bool,
	harm: bool,
	yd: i32,
}

// Plays a target macro the way the client does: /targetexact takes the nearest unit with the name, alive or
// dead, and keeps the target when none matches; [dead], [noharm], [noexists] and [nocombat] test the current
// target and the fight, and the line runs when any bracket holds.
fn play_macro(text: &str, units: &[Unit], target: Option<Unit>, combat: bool) -> Option<String> {
	let line_re = regex::Regex::new(r"^(/\w+)((?:\s*\[[^\]]*\])*)\s*(.*)$").unwrap();
	let cond_re = regex::Regex::new(r"\[([^\]]*)\]").unwrap();
	let mut target = target;
	for line in text.split('\n') {
		let m = line_re.captures(line).unwrap();
		let holds = |cond: &str| match cond {
			"dead" => target.is_some_and(|t| t.dead),
			"noharm" => target.is_some_and(|t| !t.harm),
			"noexists" => target.is_none(),
			"nocombat" => !combat,
			_ => panic!("unknown condition {cond}"),
		};
		let conds: Vec<&str> = cond_re.captures_iter(m.get(2).unwrap().as_str()).map(|c| c.get(1).unwrap().as_str()).collect();
		if !conds.is_empty() && !conds.iter().any(|c| holds(c)) {
			continue;
		}
		match &m[1] {
			"/cleartarget" => target = None,
			"/targetexact" => {
				let name = &m[3];
				target = units.iter().filter(|u| u.name == name).min_by_key(|u| u.yd).copied().or(target);
			}
			_ => panic!("unexpected command {line}"),
		}
	}
	target.map(|t| format!("{}{}", t.name, if t.dead { " (dead)" } else { "" }))
}

#[test]
fn target_button_a_corpse_is_never_left_selected_the_first_living_match_wins_the_preferred_name_first_355() {
	let out = run(r#"
		local B = Polestar.QoL.Buttons
		emit(B.TargetMacro({ "Nightsaber", "Feral Nightsaber" }, 2))
		emit(B.TargetMacro({ "Webwood Lurker" }, 1))
		emit(B.TargetMacro({ "Defias Pathstalker", "Defias Highwayman", "Defias Pillager", "Defias Looter", "Defias Smuggler" }, 1))
	"#);
	let (two, one, long) = (text(&out[0]), text(&out[1]), text(&out[2]));
	let corpse = Unit { name: "Nightsaber", dead: true, harm: true, yd: 3 };
	let living = Unit { name: "Nightsaber", dead: false, harm: true, yd: 30 };
	let feral = Unit { name: "Feral Nightsaber", dead: false, harm: true, yd: 40 };
	let feral_corpse = Unit { name: "Feral Nightsaber", dead: true, harm: true, yd: 2 };
	let giver = Unit { name: "Tarindrella", dead: false, harm: false, yd: 1 };
	let lurker = Unit { name: "Webwood Lurker", dead: true, harm: true, yd: 5 };
	let ursa = Unit { name: "Gnarlpine Ursa", dead: false, harm: true, yd: 10 };
	let some = |s: &str| Some(s.to_string());

	// The report: the preferred name absent, a Nightsaber corpse nearest.
	assert_eq!(play_macro(two, &[corpse], None, false), None, "only a corpse: nothing selected");
	assert_eq!(play_macro(two, &[corpse, living], None, false), None, "the nearest Nightsaber is the corpse, so /targetexact cannot reach the living one");
	assert_eq!(play_macro(two, &[corpse, feral], None, false), some("Feral Nightsaber"));
	assert_eq!(play_macro(two, &[feral_corpse, corpse, living], None, false), None);
	assert_eq!(play_macro(two, &[feral_corpse, feral, corpse], None, false), None, "a nearer corpse of every name: nothing");
	assert_eq!(play_macro(two, &[feral, living], None, false), some("Feral Nightsaber"), "the preferred name wins when it is alive");
	assert_eq!(play_macro(two, &[feral_corpse, Unit { yd: 1, ..living }], None, false), some("Nightsaber"), "a preferred corpse falls through to the next name");
	assert_eq!(play_macro(two, &[living], Some(giver), false), some("Nightsaber"), "a friendly target does not stop the later names");

	// Out of combat the press starts from nothing, so a target of none of the
	// names -- one clicked by hand, an add -- cannot stop the later names.
	assert_eq!(play_macro(two, &[living], Some(ursa), false), some("Nightsaber"), "a living hostile target of another name is cleared, so the chain reaches the second name");
	assert_eq!(play_macro(two, &[], Some(ursa), false), None, "no match out of combat: the old target goes too");

	// In a fight the target is left alone: clearing it cuts melee swings and
	// Auto Shot, and retargeting does not restart them.
	assert_eq!(play_macro(two, &[], Some(ursa), true), some("Gnarlpine Ursa"), "in combat, no match: the target is kept");
	assert_eq!(play_macro(two, &[living], Some(ursa), true), some("Gnarlpine Ursa"), "in combat a target of another name is kept, swings intact");
	assert_eq!(play_macro(two, &[feral, living], Some(ursa), true), some("Feral Nightsaber"), "in combat the preferred name still wins when it is there");
	assert_eq!(play_macro(two, &[corpse], Some(Unit { yd: 1, ..corpse }), true), None, "in combat a corpse is still cleared");

	// One name (also the step key's NPC): a corpse is cleared, and out of
	// combat so is a target the name never matched.
	assert_eq!(play_macro(one, &[lurker], None, false), None);
	assert_eq!(play_macro(one, &[], Some(giver), false), None);
	assert_eq!(play_macro(one, &[], Some(giver), true), some("Tarindrella"), "in combat the target is kept");
	assert_eq!(play_macro(one, &[Unit { name: "Webwood Lurker", ..giver }], None, false), some("Webwood Lurker"), "a friendly match is kept");

	// Past the macro limit the last names in click order go; the preferred one stays first.
	assert!(long.len() <= 255, "{} characters", long.len());
	assert!(is_match(long, r"^/cleartarget \[nocombat\]\n/targetexact Defias Pathstalker\n/cleartarget \[dead\]\n/targetexact \[noexists\] Defias Highwayman\n"));
	assert!(!is_match(long, r"Defias Smuggler"));
}

#[test]
fn rare_button_targets_the_rares_in_range_comes_up_and_goes_with_them_each_click_cycles_off_with_its_setting() {
	let out = run(r#"
		local b = PolestarRareButton
		local nearby = {}
		Polestar.Rares = { Nearby = function() return nearby end }
		q.step({ { t = "kill", target = "Wolf" } })
		emit({ b:GetAttribute("macrotext") or "nil", b:IsShown() })
		nearby = { "Thuros Lightfingers", "Bad\n/run X()", "Hogger" }
		Polestar.Fire("RARE_NEARBY")
		stub.runTimers()
		emit({ b:GetAttribute("type"), b:GetAttribute("macrotext"), b:IsShown(), b.Label:GetText(), PolestarTargetButton:GetAttribute("macrotext") })
		q.click(b, false)
		emit(b:GetAttribute("macrotext"))
		q.combat(true)
		nearby = { "Hogger" }
		Polestar.Fire("RARE_NEARBY")
		stub.runTimers()
		emit({ b:GetAttribute("macrotext"), b:IsShown() })
		q.combat(false)
		emit({ b:GetAttribute("macrotext"), b:IsShown() })
		set("rareButton", false)
		emit({ b:GetAttribute("macrotext") or "nil", b:IsShown() })
		set("rareButton", true)
		nearby = {}
		Polestar.Fire("RARE_NEARBY")
		stub.runTimers()
		emit({ b:GetAttribute("macrotext") or "nil", b:IsShown() })
	"#);
	assert_eq!(out[0], json!(["nil", false]));
	// #373's macro: from nothing out of combat, the preferred name first, corpses passed over.
	let mac = |names: &[&str]| {
		let mut lines = vec!["/cleartarget [nocombat]".to_string()];
		for (i, n) in names.iter().enumerate() {
			lines.push(format!("/targetexact {}{n}", if i > 0 { "[noexists] " } else { "" }));
			lines.push("/cleartarget [dead]".to_string());
		}
		lines.join("\n")
	};
	assert_eq!(out[1], json!(["macro", mac(&["Thuros Lightfingers", "Hogger"]), true, "Thuros Lightfingers", mac(&["Wolf"])]));
	assert_eq!(out[2], mac(&["Hogger", "Thuros Lightfingers"]).as_str(), "the next click moves on");
	assert_eq!(out[3], json!([mac(&["Hogger", "Thuros Lightfingers"]), true]), "in combat the button keeps what it did");
	assert_eq!(out[4], json!([mac(&["Hogger"]), true]));
	assert_eq!(out[5], json!(["nil", false]));
	assert_eq!(out[6], json!(["nil", false]));
}

#[test]
fn rare_button_its_icon_is_gold_apart_from_the_red_target_button() {
	let out = run(r#"
		emit({ PolestarRareButton.Icon:GetVertexColor() })
		emit({ PolestarTargetButton.Icon:GetVertexColor() })
		emit({ Polestar.Theme.Color("quest") })
	"#);
	let (rare, target, gold) = (&out[0], &out[1], &out[2]);
	assert_eq!(head(rare, 3), head(gold, 3), "the quest gold");
	assert_ne!(head(rare, 3), head(target, 3), "not the Target button color");
}

#[test]
fn hearth_button_while_a_hearth_goal_is_open_gethearth_reports_bind_and_cooldown() {
	let out = run(r#"
		local h = PolestarHearthButton
		q.items[6948] = { name = "Hearthstone" }
		q.addItem(0, 1, 6948, 1)
		q.step({ { t = "kill", target = "Wolf" } })
		emit(h:IsShown())
		q.step({ { t = "hearth", location = "Goldshire" } })
		emit({ h:IsShown(), h:GetAttribute("item") })
		stub.now = 1000
		q.cooldowns[6948] = { 900, 3600 }
		local info = QoL.GetHearth()
		emit({ info.have, info.bind, info.ready, info.remaining })
		q.cooldowns[6948] = { 999, 1.5 } -- global cooldown only
		info = QoL.GetHearth()
		emit({ info.ready, info.remaining })
		set("hearthButton", false)
		emit(h:IsShown())
	"#);
	assert_eq!(out[0], false);
	assert_eq!(out[1], json!([true, "item:6948"]));
	assert_eq!(out[2], json!([true, "Goldshire", false, 3500]));
	assert_eq!(out[3], json!([true, 0]));
	assert_eq!(out[4], false);
}

// The client's choice in SecureActionButton_OnClick (SecureTemplates.lua) for an addon button: act on the press
// when useOnKeyDown (nil: the ActionButtonUseKeyDown CVar) says so, else on the release.
const ACTS: &str = r#"
local acted = 0
local function secureClick(self, _, down)
	local use = self:GetAttribute("useOnKeyDown")
	if use == nil then use = GetCVarBool("ActionButtonUseKeyDown") end
	if (down and use) or (not down and not use) then acted = acted + 1 end
end
local item, hearth, target = PolestarQuestItemButton, PolestarHearthButton, PolestarTargetButton
for _, b in ipairs({ item, hearth, target }) do b:SetScript("OnClick", secureClick) end
local holder = select(2, item:GetPoint(1))
local R = stub.RunScript
for _, b in ipairs({ item, hearth, target }) do b.IsMouseOver = function(self) return self.over == true end end
local function hover(b) b.over = true; R(b, "OnEnter") end
local function leave(b) b.over = false; R(b, "OnLeave") end
local function attr(b) return tostring(b:GetAttribute("useOnKeyDown")) end
-- The client's order of OnMouseDown and the down-click is not documented:
-- try both.
local function press(b, downFirst)
	if downFirst then q.click(b, true); R(b, "OnMouseDown", "LeftButton")
	else R(b, "OnMouseDown", "LeftButton"); q.click(b, true) end
end
local function mouseClick(b, downFirst)
	acted = 0
	hover(b)
	press(b, downFirst)
	R(b, "OnMouseUp", "LeftButton")
	q.click(b, false)
	stub.runTimers()
	leave(b)
	return acted
end
local function keyPress(b) acted = 0; q.click(b, true); local onDown = acted; q.click(b, false); stub.runTimers(); return { onDown, acted } end
-- Hover, press, drag (the user carries the holder to x, y), release: no
-- OnMouseUp after a drag; the release's click is sent anyway in case the
-- client does. Reports whether the set moved, the actions fired and the
-- attribute while the cursor is still on the button; then leaves.
local function drag(b, x, y)
	acted = 0
	hover(b)
	press(b)
	R(b, "OnDragStart", "LeftButton")
	local started = holder.moving
	if started then holder:ClearAllPoints(); holder:SetPoint("CENTER", UIParent, "CENTER", x, y) end
	R(b, "OnDragStop", "LeftButton")
	q.click(b, false)
	stub.runTimers()
	local a = attr(b)
	leave(b)
	return { started == true, acted, a }
end
local function slot(b) local _, rel, _, x, y = b:GetPoint(1); return { rel == holder, x, y } end
local function spot() local p, _, rp, x, y = holder:GetPoint(1); return { p, rp, x, y } end
"#;

#[test]
fn action_buttons_a_left_drag_moves_the_whole_set_and_never_uses_the_item_clicks_and_keys_act_once() {
	let out = run(&[
		ACTS,
		r#"
		q.items[900] = { name = "Torch" }
		q.items[6948] = { name = "Hearthstone" }
		q.addItem(0, 1, 900, 1)
		q.addItem(0, 2, 6948, 1)
		q.step({ { t = "use", item = 900, quest = 7 }, { t = "kill", target = "Wolf" } })
		for _, cvar in ipairs({ "1", "0" }) do
			stub.cvars.ActionButtonUseKeyDown = cvar
			emit({ drag(item, -300, 50), drag(target, -300, 50), mouseClick(item, false), mouseClick(item, true), keyPress(item), attr(item) })
		end
		emit({ spot(), PolestarCharDB.qol.buttonPos, slot(item), slot(target) })

		-- a hearth goal: the Hearthstone button shows above the item, where the set now is
		q.step({ { t = "hearth", location = "Goldshire" }, { t = "use", item = 900, quest = 7 } })
		emit({ hearth:IsShown(), slot(hearth) })

		-- in combat: no move, nothing protected touched
		q.combat(true)
		stub.cvars.ActionButtonUseKeyDown = "1"
		emit(drag(item, 0, 0))
		emit(spot())
		q.combat(false)

		QoL.Buttons.ResetPositions()
		emit({ spot(), PolestarCharDB.qol.buttonPos or false })
	"#,
	]
	.concat());
	assert_eq!(
		out[0],
		json!([[true, 0, "false"], [true, 0, "false"], 1, 1, [1, 1], "nil"]),
		"ActionButtonUseKeyDown on: drags act never; clicks once in either order; a key acts on the press; leaving restores nil"
	);
	assert_eq!(out[1], json!([[true, 0, "false"], [true, 0, "false"], 1, 1, [0, 1], "nil"]), "ActionButtonUseKeyDown off: a key acts on the release");
	assert_eq!(out[2], json!([["CENTER", "CENTER", -300, 50], ["CENTER", "CENTER", -300, 50], [true, 0, 0], [true, 0, -44]]));
	assert_eq!(out[3], json!([true, [true, 0, 44]]));
	assert_eq!(out[4], json!([false, 1, "nil"]), "in combat: no drag, no attribute change; the press acts as before");
	assert_eq!(out[5], json!(["CENTER", "CENTER", -300, 50]));
	assert_eq!(out[6], json!([["CENTER", "CENTER", 260, -140], false]));
}

#[test]
fn action_buttons_with_the_lock_on_only_a_shift_drag_moves_the_set_a_plain_drag_uses_nothing_and_clicks_still_act() {
	let out = run(&[
		ACTS,
		r#"
		q.items[900] = { name = "Torch" }
		q.addItem(0, 1, 900, 1)
		q.step({ { t = "use", item = 900, quest = 7 }, { t = "kill", target = "Wolf" } })
		stub.cvars.ActionButtonUseKeyDown = "1"
		Polestar.Set("ui.lockHud", true)
		emit({ drag(item, -300, 50), drag(target, -300, 50), spot(), mouseClick(item, false), mouseClick(item, true), keyPress(item) })
		hover(target)
		emit(GameTooltip.lines[#GameTooltip.lines])
		leave(target)
		stub.keys.shift = true
		emit({ drag(target, -200, 30), spot() })
		Polestar.Set("ui.lockHud", false)
		stub.keys.shift = false
		emit({ drag(item, -100, 10), spot() })
	"#,
	]
	.concat());
	assert_eq!(
		out[0],
		json!([[false, 0, "false"], [false, 0, "false"], ["CENTER", "CENTER", 260, -140], 1, 1, [1, 1]]),
		"locked, no Shift: neither drag moves the set or uses anything; clicks and keys act once"
	);
	assert_eq!(out[1], "Click again for the next name. Shift-drag to move.");
	assert_eq!(out[2], json!([[true, 0, "false"], ["CENTER", "CENTER", -200, 30]]), "locked, Shift held: the drag moves the set");
	assert_eq!(out[3], json!([[true, 0, "false"], ["CENTER", "CENTER", -100, 10]]), "unlocked: a plain drag moves it again, live");
}

#[test]
fn action_buttons_the_set_comes_back_where_it_was_left_after_a_reload() {
	let out = run_with(&[ACTS, " emit(spot())"].concat(), "", Some(r#"PolestarCharDB = { qol = { buttonPos = { "TOPLEFT", "TOPLEFT", 40, -60 } } }"#));
	assert_eq!(out[0], json!(["TOPLEFT", "TOPLEFT", 40, -60]));
}

// ---------------------------------------------------------------------------
// XP and pace
// ---------------------------------------------------------------------------

#[test]
fn xp_session_and_rolling_rate_time_to_level_kills_and_quests_to_level_rested() {
	let out = run(r#"
		q.rested = 600
		-- 10 kills of 50 XP over 10 minutes, kill message before the gain
		for i = 1, 10 do
			stub.advance(60)
			stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "secret")
			q.gainXP(50)
		end
		-- one quest of 200 XP, turn-in event before the gain
		stub.fire("QUEST_TURNED_IN", 7, 200, 0)
		q.gainXP(200)
		local st = QoL.GetXPStats()
		emit({ xp = st.xp, remaining = st.remaining, sessionXP = st.sessionXP, sessionRate = st.sessionRate,
			rollingRate = st.rollingRate, ttl = st.timeToLevel, kills = st.sessionKills, quests = st.sessionQuests,
			avgKill = st.avgKillXP, avgQuest = st.avgQuestXP, k2l = st.killsToLevel, q2l = st.questsToLevel,
			rested = st.rested, restedPct = st.restedPercent, rate = st.rate })
	"#);
	let s = &out[0];
	assert_eq!(s["xp"], 700);
	assert_eq!(s["remaining"], 300);
	assert_eq!(s["sessionXP"], 700);
	near(&s["sessionRate"], (700.0 / 600.0) * 3600.0, 1e-6);
	assert_eq!(s["rollingRate"], s["sessionRate"], "within the rolling window both agree");
	near(&s["ttl"], (300.0 / s["rate"].as_f64().unwrap()) * 3600.0, 1e-6);
	assert_eq!(s["kills"], 10);
	assert_eq!(s["quests"], 1);
	assert_eq!(s["avgKill"], 50);
	assert_eq!(s["avgQuest"], 200);
	assert_eq!(s["k2l"], 6);
	assert_eq!(s["q2l"], 2);
	assert_eq!(s["rested"], 600);
	assert_eq!(s["restedPct"], 60);
}

#[test]
fn xp_gains_are_attributed_in_either_event_order_the_rolling_rate_forgets_old_xp() {
	let out = run(r#"
		q.gainXP(80)                                 -- gain first, kill message after
		stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "x")
		stub.advance(5)
		q.gainXP(300)                                -- quest gain first, turn-in after
		stub.fire("QUEST_TURNED_IN", 9, 300, 0)
		stub.advance(5)
		stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "x")    -- kill message and quest gain coincide
		q.gainXP(150)
		stub.fire("QUEST_TURNED_IN", 10, 150, 0)
		stub.advance(5)
		q.gainXP(40)                                 -- exploration: no explanation, not a kill
		stub.advance(2)
		local st = QoL.GetXPStats()
		emit({ kills = st.sessionKills, quests = st.sessionQuests, avgKill = st.avgKillXP, avgQuest = st.avgQuestXP })
		stub.advance(1200)
		q.gainXP(10)
		st = QoL.GetXPStats()
		emit({ rolling = st.rollingRate, session = st.sessionRate, rate = st.rate, seconds = st.sessionSeconds })
	"#);
	let (a, b) = (&out[0], &out[1]);
	assert_eq!(*a, json!({ "kills": 1, "quests": 2, "avgKill": 80, "avgQuest": 225 }));
	near(&b["rolling"], (10.0 / 900.0) * 3600.0, 1e-6);
	near(&b["session"], ((80.0 + 300.0 + 150.0 + 40.0 + 10.0) / b["seconds"].as_f64().unwrap()) * 3600.0, 1e-6);
	assert_eq!(b["rate"], b["rolling"]);
}

#[test]
fn xp_level_ups_close_a_split_per_level_in_charstate() {
	let out = run(r#"
		stub.advance(100)
		stub.fire("CHAT_MSG_COMBAT_XP_GAIN", "x")
		q.gainXP(400)
		stub.advance(200)
		stub.fire("QUEST_TURNED_IN", 3, 700, 0)
		q.gainXP(700)                                -- 1100 of 1000: level 11, 100 into it
		stub.advance(50)
		local splits = PolestarCharDB.qol.xp.splits
		emit({ s10 = splits[10], level = PolestarCharDB.qol.xp.level })
		local st = QoL.GetXPStats()
		emit({ level = st.level, xp = st.xp, levelSeconds = math.floor(st.levelSeconds * 1000 + 0.5) / 1000 })
		-- UnitLevel lagging one event: XP dropped at the same level still closes the level
		q.xp = 1150
		stub.fire("PLAYER_XP_UPDATE", "player")
		q.xp = 20
		q.xpMax = 1200
		stub.fire("PLAYER_XP_UPDATE", "player")
		emit({ s11 = PolestarCharDB.qol.xp.splits[11] ~= nil, level = PolestarCharDB.qol.xp.level })
	"#);
	let (splits, st, again) = (&out[0], &out[1], &out[2]);
	assert_eq!(splits["level"], 11);
	assert_eq!(splits["s10"]["seconds"], 300);
	assert_eq!(splits["s10"]["xp"], 1000);
	assert_eq!(splits["s10"]["kills"], 1);
	assert_eq!(splits["s10"]["quests"], 1);
	assert!(splits["s10"]["partial"].is_null(), "tracked from 0 XP: a full level");
	assert!(splits["s10"]["at"].as_f64().unwrap() > 0.0);
	assert_eq!(*st, json!({ "level": 11, "xp": 100, "levelSeconds": 50 }));
	assert_eq!(*again, json!({ "s11": true, "level": 12 }));
}

#[test]
fn xp_tracker_off_returns_nil_and_prints_nothing() {
	let out = run(r#"
		set("xpTracker", false)
		q.gainXP(100)
		emit(QoL.GetXPStats() == nil)
		SlashCmdList.POLESTAR("xp")
		emit(printed("tracker is off"))
	"#);
	assert_eq!(out[0], true);
	assert_eq!(out[1], true);
}

// The guide's level on the game's XP bar (QoL/XPMark.lua).
const XPMARK: &str = r#"
local function mark(bar)
	local f = QoL.XPMark.frame
	if not (f and f:IsShown()) then return { shown = false } end
	local point, rel, relPoint = f:GetPoint(1)
	local tick, tickRel, tickRelPoint = f.Tick:GetPoint(1)
	local r, g, b = f.Tick:GetVertexColor()
	local ar, ag, ab = Polestar.Theme.Accent()
	return {
		shown = true, text = f.Label:GetText(), underBar = f:GetParent() == bar,
		spans = point == "TOPLEFT" and rel == bar.StatusBar and f:GetNumPoints() == 2,
		tick = tick .. ">" .. tickRelPoint, tickOnMark = tickRel == f,
		accent = r == ar and g == ag and b == ab, aboveText = f:GetFrameLevel() > bar.OverlayFrame:GetFrameLevel(),
	}
end
"#;

#[test]
fn xp_mark_the_label_reads_the_next_level_or_the_target_and_how_many_levels_away_it_is() {
	let out = run(r#"
		local M = QoL.XPMark
		emit({ next = M.Label(10, 11), far = M.Label(10, 14), same = M.Label(10, 10) or "nil", below = M.Label(10, 8) or "nil",
			none = M.Label(10, nil) or "nil" })
	"#);
	assert_eq!(out[0], json!({ "next": "Guide: 11", "far": "Guide: 14 (4 levels)", "same": "nil", "below": "nil", "none": "nil" }));
}

#[test]
fn xp_mark_a_tick_at_the_right_end_of_the_shown_xp_bar_labelled_with_the_guide_s_next_level_target_made_through_createframeunder() {
	let out = run(&[
		XPMARK,
		r#"
		local bar = q.xpBar()
		q.engine.levelTarget = 11
		q.step({ { t = "level", level = 11 } })
		emit(mark(bar))
		q.engine.levelTarget = 14
		q.step({ { t = "kill", target = "Wolf", quest = 5, oi = 1 } })
		emit(mark(bar))
		-- a level-up moves the count down without a step change
		stub.fire("PLAYER_LEVEL_UP", 11)
		q.level = 11
		stub.runTimers()
		emit(mark(bar))
		emit(table.concat(stub.underGameFrames, "; "))
	"#,
	]
	.concat());
	let (next, far, levelled, under) = (&out[0], &out[1], &out[2], &out[3]);
	assert_eq!(
		*next,
		json!({
			"shown": true, "text": "Guide: 11", "underBar": true, "spans": true, "tick": "TOPRIGHT>TOPRIGHT", "tickOnMark": true,
			"accent": true, "aboveText": true,
		})
	);
	assert_eq!(far["text"], "Guide: 14 (4 levels)");
	assert_eq!(far["shown"], true);
	assert_eq!(levelled["text"], "Guide: 14 (3 levels)");
	assert_eq!(*under, "", "no frame created with a game frame as its parent");
}

#[test]
fn xp_mark_hidden_with_the_option_off_without_a_target_without_the_xp_bar_or_at_the_maximum_level() {
	let out = run(&[
		XPMARK,
		r#"
		local bar = q.xpBar()
		q.engine.levelTarget = 12
		q.step({ { t = "level", level = 12 } })
		emit(mark(bar).shown)
		set("xpTargetMark", false)
		emit(mark(bar).shown)
		set("xpTargetMark", true)
		emit(mark(bar).shown)
		q.engine.levelTarget = nil
		q.step({ { t = "kill", target = "Wolf", quest = 5, oi = 1 } })
		emit(mark(bar).shown)

		-- no XP bar at all (another addon's, or none)
		q.engine.levelTarget = 12
		StatusTrackingBarManager, StatusTrackingBarInfo = nil, nil
		q.step({ { t = "level", level = 12 } })
		emit(mark(bar).shown)
		-- the game's bar there, but the experience bar not shown
		local hidden = q.xpBar(false)
		q.step({ { t = "level", level = 12 } })
		emit(mark(hidden).shown)
		-- the maximum level
		hidden:Show()
		q.level, q.maxLevel, q.engine.levelTarget = 60, 60, 61
		q.gainXP(0)
		stub.runTimers()
		emit(mark(hidden).shown)
	"#,
	]
	.concat());
	assert_eq!(
		json!({
			"on": out[0].clone(), "off": out[1].clone(), "back": out[2].clone(), "none": out[3].clone(),
			"noBar": out[4].clone(), "hiddenBar": out[5].clone(), "maxed": out[6].clone(),
		}),
		json!({ "on": true, "off": false, "back": true, "none": false, "noBar": false, "hiddenBar": false, "maxed": false })
	);
}

#[test]
fn xp_mark_on_by_default_on_quality_of_life_trackers_experience() {
	let out = run(r#"
		local found
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			for _, c in ipairs(spec.controls) do
				if c.key == "qol.xpTargetMark" then found = { page = spec.page, tab = spec.tab, section = spec.section } end
			end
		end
		emit({ default = Polestar.GetDefault("qol.xpTargetMark"), where = found or "none" })
	"#);
	assert_eq!(out[0], json!({ "default": true, "where": { "page": "Quality of Life", "tab": "Trackers", "section": "Experience" } }));
}

// ---------------------------------------------------------------------------
// Merchant
// ---------------------------------------------------------------------------

const BAGS: &str = r#"
	q.items[1] = { name = "Broken Fang", quality = 0, price = 7 }
	q.items[2] = { name = "Linen Cloth", quality = 1, price = 13 }
	q.items[3] = { name = "Green Sword", quality = 2, price = 500 }
	q.items[4] = { name = "Grey Quest Thing", quality = 0, noValue = true }
	q.items[5] = { name = "Ruined Pelt", quality = 0, price = 25 }
	q.items[6] = { name = "Epic Ring", quality = 4, price = 9000 }
	q.items[7] = { name = "Uncached Grey", quality = 0, uncached = true }
	q.items[8] = { name = "Unknown quality" }
	q.bags[1].size = 8
	q.addItem(0, 1, 1, 3)
	q.addItem(0, 2, 2, 20)
	q.addItem(0, 3, 3, 1)
	q.addItem(0, 4, 4, 1)
	q.addItem(1, 1, 5, 2)
	q.addItem(1, 2, 6, 1)
	q.addItem(1, 3, 7, 1)
	q.addItem(1, 4, 8, 1)
	for i = 5, 8 do q.addItem(1, i, 1, 1) end
"#;

#[test]
fn merchant_sells_only_grey_items_with_a_vendor_price_and_prints_the_total() {
	let out = run(&[
		BAGS,
		r#"
		q.openMerchant()
		stub.advance(2)
		emit(q.sold)
		emit(q.money)
		local left = {}
		for bag = 0, 1 do for slot, s in pairs(q.bags[bag].slots) do left[#left + 1] = s.itemID end end
		table.sort(left)
		emit(left)
		emit(printed("Sold 9 grey items for 99c"))
	"#,
	]
	.concat());
	let mut sold: Vec<i64> = out[0].as_array().unwrap().iter().map(|v| v.as_i64().unwrap()).collect();
	sold.sort();
	assert_eq!(sold, vec![1, 1, 1, 1, 1, 5]);
	assert_eq!(out[1], 3 * 7 + 2 * 25 + 4 * 7);
	assert_eq!(out[2], json!([2, 3, 4, 6, 7, 8]));
	assert_eq!(out[3], true);
}

#[test]
fn merchant_a_slot_changed_between_ticks_is_re_checked_and_never_sold() {
	let out = run(&[
		BAGS,
		r#"
		q.bags[1].size = 12
		for i = 9, 12 do q.addItem(1, i, 1, 1) end
		q.openMerchant()                 -- the first tick sells 6 of the 10 queued slots
		-- swap a still-queued grey slot for the epic ring
		q.bags[1].slots[12] = { itemID = 6, stackCount = 1 }
		stub.advance(1)
		local used = {}
		for _, c in ipairs(q.calls) do if c[1] == "UseContainerItem" then used[#used + 1] = c[2] .. ":" .. c[3] end end
		emit(used)
		emit(q.sold)
	"#,
	]
	.concat());
	let used = out[0].as_array().unwrap();
	let ids = out[1].as_array().unwrap();
	assert!(!used.contains(&json!("1:12")), "the swapped slot is never used");
	assert!(!ids.contains(&json!(6)));
	assert_eq!(ids.len(), 9);
}

#[test]
fn merchant_repairs_after_selling_if_affordable_shift_and_settings_off_do_nothing() {
	let out = run(&[
		BAGS,
		r#"
		q.repair = { can = true, cost = 50 }
		q.money = 0
		q.openMerchant()
		stub.advance(2)
		emit({ repaired = #calls("RepairAllItems"), money = q.money })   -- 66 earned, 50 paid
		q.closeMerchant()

		q.repair = { can = true, cost = 5000 }
		q.openMerchant()
		emit({ repaired = #calls("RepairAllItems"), poor = printed("Not enough money") })
		q.closeMerchant()

		q.calls = {}
		q.addItem(0, 1, 1, 3)
		stub.keys.shift = true
		q.openMerchant()
		stub.advance(2)
		emit(#q.calls)
		q.closeMerchant()
		stub.keys.shift = false

		set("sellJunk", false)
		set("autoRepair", false)
		q.openMerchant()
		stub.advance(2)
		emit(#q.calls)
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "repaired": 1, "money": 49 }));
	assert_eq!(out[1], json!({ "repaired": 1, "poor": true }));
	assert_eq!(out[2], 0, "Shift: nothing");
	assert_eq!(out[3], 0, "off: nothing");
}

#[test]
fn merchant_sales_still_queued_stop_when_junk_sales_are_turned_off_even_back_on_shift_is_held_you_log_out_or_another_merchant_opens_with_shift() {
	let visit = |between: &str| {
		run(&[
			BAGS,
			r#"
		q.bags[1].size = 12
		for i = 9, 12 do q.addItem(1, i, 1, 1) end
		q.money = 1000
		q.repair = { can = true, cost = 50 }
		q.openMerchant()                 -- the first tick sells 6 of the 10 queued slots
		"#,
			between,
			r#"
		stub.advance(2)
		emit({ sold = #q.sold, repaired = #calls("RepairAllItems") })
	"#,
		]
		.concat())[0]
			.clone()
	};
	let got = json!({
		"off": visit(r#"set("sellJunk", false)"#),
		"offOn": visit(r#"set("sellJunk", false); set("sellJunk", true)"#),
		"shift": visit("stub.keys.shift = true"),
		"logout": visit(r#"stub.fire("PLAYER_LOGOUT")"#),
		"nextVisit": visit("stub.keys.shift = true; q.openMerchant()"),
		"left": visit(""),
	});
	assert_eq!(
		got,
		json!({
			"off": { "sold": 6, "repaired": 1 },
			"offOn": { "sold": 6, "repaired": 1 },
			"shift": { "sold": 6, "repaired": 0 },
			"logout": { "sold": 6, "repaired": 0 },
			"nextVisit": { "sold": 6, "repaired": 0 },
			"left": { "sold": 10, "repaired": 1 },
		})
	);
}

// ---------------------------------------------------------------------------
// Buying for the step's buy goals
// ---------------------------------------------------------------------------

const GOODS: &str = r#"
	q.items[20] = { name = "Soothing Spices", quality = 1, price = 10 }
	q.items[21] = { name = "Bronze Tube", quality = 1, price = 100 }
	q.items[22] = { name = "Refreshing Spring Water", quality = 1, price = 1 }
	q.items[23] = { name = "Flagon of Mead", quality = 1, price = 5 }
	q.goods = {
		{ id = 22, price = 25, stackCount = 5, maxStack = 20 },
		{ id = 20, price = 40 },
		{ id = 23, price = 80, numAvailable = 1 },
	}
	local function bought()
		local out = {}
		for _, c in ipairs(q.calls) do if c[1] == "BuyMerchantItem" then out[#out + 1] = c[2] .. "x" .. c[3] end end
		return out
	end
"#;

#[test]
fn buying_buys_what_the_open_buy_goals_still_need_from_this_merchant_after_the_items_land_prints_the_total() {
	let out = run(&[
		GOODS,
		r#"
		set("buyGoals", true)
		q.money = 1000
		q.addItem(0, 1, 20, 1)
		q.step({
			{ t = "buy", item = 20, count = 3, itemName = "Soothing Spices" },
			{ t = "buy", item = 21, count = 1, itemName = "Bronze Tube" },      -- not sold here
			{ t = "buy", item = 23, count = 1, status = "done" },
			{ t = "kill", target = "Kobold Vermin" },
		})
		q.openMerchant()
		emit(bought())
		stub.advance(1)
		emit(bought())
		emit(q.money)
		emit(printed("Bought 2 Soothing Spices for 80c"))
		q.closeMerchant()
		q.openMerchant()                  -- the bags hold three now
		stub.advance(1)
		emit(#bought())
	"#,
	]
	.concat());
	assert_eq!(out[0], json!(["2x2"]), "two more spices, one purchase each");
	assert_eq!(out[1], json!(["2x2"]));
	assert_eq!(out[2], 920);
	assert_eq!(out[3], true);
	assert_eq!(out[4], 1, "nothing more once the goal is met");
}

#[test]
fn buying_spends_nothing_for_an_imported_or_community_guide_and_names_what_to_buy_instead() {
	for pack in ["imported", "yendi"] {
		let out = run(&[
			GOODS,
			format!(
				r#"
		set("buyGoals", true)
		q.money = 1000
		q.guidePack = "{pack}"
		q.step({{ {{ t = "buy", item = 20, count = 3, itemName = "Soothing Spices" }} }})
		q.openMerchant()
		stub.advance(1)
		emit(#bought())
		emit(q.money)
		emit(printed("Left 3 Soothing Spices %(.+%) for you to buy"))
	"#
			)
			.as_str(),
		]
		.concat());
		assert_eq!(out[0], 0, "{pack}: nothing bought");
		assert_eq!(out[1], 1000, "{pack}: no money spent");
		assert_eq!(out[2], true, "{pack}: says what to buy");
	}
}

#[test]
fn buying_a_purchase_still_on_its_way_counts_so_opening_the_merchant_again_before_it_lands_buys_nothing_more() {
	let out = run(&[
		GOODS,
		r#"
		set("buyGoals", true)
		q.money = 1000
		q.landDelay = 0.5
		q.step({
			{ t = "buy", item = 20, count = 3, itemName = "Soothing Spices" },
			{ t = "buy", item = 20, count = 2, itemName = "Soothing Spices" },   -- the same item twice: the larger count
		})
		q.openMerchant()
		emit(#bought())
		q.closeMerchant()
		q.openMerchant()                  -- before the spices land
		emit(#bought())
		stub.advance(2)
		q.closeMerchant()
		q.openMerchant()
		stub.advance(2)
		emit(#bought())
		emit(C_Item.GetItemCount(20))
	"#,
	]
	.concat());
	assert_eq!(out[0], 1);
	assert_eq!(out[1], 1, "not bought twice");
	assert_eq!(out[2], 1);
	assert_eq!(out[3], 3);
}

#[test]
fn buying_a_goal_raised_while_a_purchase_is_on_its_way_buys_only_the_difference_however_often_the_merchant_opens() {
	let out = run(&[
		GOODS,
		r#"
		set("buyGoals", true)
		q.money = 1000
		q.landDelay = 0.5
		q.step({ { t = "buy", item = 20, count = 3, itemName = "Soothing Spices" } })
		q.openMerchant()
		q.closeMerchant()
		q.step({ { t = "buy", item = 20, count = 5, itemName = "Soothing Spices" } })
		q.openMerchant()
		q.closeMerchant()
		q.openMerchant()
		q.closeMerchant()
		stub.advance(2)
		local n = 0
		for _, c in ipairs(q.calls) do if c[1] == "BuyMerchantItem" then n = n + c[3] end end
		emit(n)
		emit(C_Item.GetItemCount(20))
		local n5, other = 0, false
		for _, m in ipairs(stub.messages) do
			if m:find("Bought 5 Soothing Spices for 2s 0c") then n5 = n5 + 1 elseif m:find("Bought") then other = true end
		end
		emit({ n5, other })
	"#,
	]
	.concat());
	assert_eq!(out[0], 5);
	assert_eq!(out[1], 5);
	assert_eq!(out[2], json!([1, false]), "the five that landed, reported once");
}

#[test]
fn buying_a_purchase_the_server_refuses_is_never_reported_as_bought() {
	let out = run(&[
		GOODS,
		r#"
		set("buyGoals", true)
		q.money = 1000
		q.landDelay = 0.5
		q.step({ { t = "buy", item = 20, count = 3, itemName = "Soothing Spices" } })
		q.openMerchant()
		q.closeMerchant()
		local buy = BuyMerchantItem       -- the server refuses the next purchase (sold out meanwhile)
		BuyMerchantItem = function(i, n) table.insert(q.calls, { "BuyMerchantItem", i, n }) end
		q.step({ { t = "buy", item = 20, count = 5, itemName = "Soothing Spices" } })
		q.openMerchant()
		BuyMerchantItem = buy
		emit(bought())                    -- the 3 on their way, then 2 more
		stub.advance(2)
		local out = {}
		for _, m in ipairs(stub.messages) do
			local b = m:match("(Bought.*)")
			if b then out[#out + 1] = b end
		end
		emit(out)
	"#,
	]
	.concat());
	assert_eq!(out[0], json!(["2x3", "2x2"]));
	assert_eq!(out[1], json!(["Bought 3 Soothing Spices for 1s 20c."]));
}

#[test]
fn buying_a_purchase_that_lands_late_on_a_slow_server_is_still_reported_once() {
	let out = run(&[
		GOODS,
		r#"
		set("buyGoals", true)
		q.money = 1000
		q.landDelay = 1.5
		q.step({ { t = "buy", item = 20, count = 3, itemName = "Soothing Spices" } })
		q.openMerchant()
		stub.advance(6)
		local out = {}
		for _, m in ipairs(stub.messages) do
			local b = m:match("(Bought.*)")
			if b then out[#out + 1] = b end
		end
		emit(out)
	"#,
	]
	.concat());
	assert_eq!(out[0], json!(["Bought 3 Soothing Spices for 1s 20c."]));
}

#[test]
fn buying_goods_sold_in_stacks_are_bought_in_whole_stacks_within_the_stack_limit_stock_and_money_cap_the_rest() {
	let out = run(&[
		GOODS,
		r#"
		set("buyGoals", true)
		q.money = 1000
		q.step({ { t = "buy", item = 22, count = 27, itemName = "Refreshing Spring Water" } })
		q.openMerchant()
		stub.advance(1)
		emit(bought())                    -- 30 in calls of at most 20
		q.closeMerchant()

		q.calls = {}
		q.step({ { t = "buy", item = 23, count = 3, itemName = "Flagon of Mead" } })
		q.openMerchant()
		stub.advance(1)
		emit(bought())                    -- one left in stock
		q.closeMerchant()

		q.calls = {}
		q.goods[1].numAvailable = 6       -- six bottles left, sold five at a time
		q.step({ { t = "buy", item = 22, count = 57, itemName = "Refreshing Spring Water" } })
		q.openMerchant()
		stub.advance(1)
		emit(bought())
		emit(q.refused)
		q.closeMerchant()

		q.calls = {}
		q.money = 90
		stub.messages = {}
		q.step({ { t = "buy", item = 20, count = 4, itemName = "Soothing Spices" } })
		q.openMerchant()
		stub.advance(1)
		emit(bought())
		emit(printed("Not enough money to buy 2 Soothing Spices %(80c%)"))
	"#,
	]
	.concat());
	assert_eq!(out[0], json!(["1x20", "1x10"]));
	assert_eq!(out[1], json!(["3x1"]));
	assert_eq!(out[2], json!(["1x5"]), "one whole purchase the stock covers");
	assert_eq!(out[3], 0, "nothing refused");
	assert_eq!(out[4], json!(["2x2"]), "what 90c covers");
	assert_eq!(out[5], true);
}

#[test]
fn buying_reads_the_merchant_through_c_merchantframe_getiteminfo_or_getmerchantiteminfo_whichever_the_client_has_alike() {
	// Forever has both; retail has only the table (RamosJoaquim, #153).
	let visit = |client: &str| {
		run(&[
			GOODS,
			"\n\t\t",
			client,
			r#"
		set("buyGoals", true)
		q.money = 1000
		q.goods[1].numAvailable = 6       -- stack size and stock
		q.goods[2].extendedCost = true    -- another currency: left alone
		q.step({
			{ t = "buy", item = 22, count = 12 },
			{ t = "buy", item = 20, count = 1 },
			{ t = "buy", item = 23, count = 1 },  -- no itemName: the merchant's name
		})
		q.openMerchant()
		stub.advance(1)
		emit(bought())
		emit(q.money)
		emit(printed("Bought 1 Flagon of Mead for 80c"))
	"#,
		]
		.concat())
	};
	let both = visit("");
	assert_eq!(json!(both), json!([["1x5", "3x1"], 895, true]));
	assert_eq!(visit("GetMerchantItemInfo = nil"), both, "retail: the table only");
	assert_eq!(visit("C_MerchantFrame = nil"), both, "without the table: GetMerchantItemInfo");
}

#[test]
fn buying_selling_greys_pays_for_it_first_goods_for_other_currencies_shift_and_the_setting_off_buy_nothing() {
	let out = run(&[
		BAGS,
		GOODS,
		r#"
		set("buyGoals", true)
		q.money = 0
		q.step({ { t = "buy", item = 20, count = 1, itemName = "Soothing Spices" } })
		q.openMerchant()                  -- from 0c: the greys sell for 99c first
		stub.advance(2)
		emit(bought())
		emit(printed("Bought 1 Soothing Spices for 40c"))
		q.closeMerchant()

		q.calls = {}
		q.money = 1000
		q.goods[2].extendedCost = true
		q.step({ { t = "buy", item = 20, count = 3, itemName = "Soothing Spices" } })
		q.openMerchant()
		stub.advance(1)
		emit(#bought())
		q.closeMerchant()
		q.goods[2].extendedCost = false

		stub.keys.shift = true
		q.openMerchant()
		stub.advance(1)
		emit(#bought())
		q.closeMerchant()
		stub.keys.shift = false

		set("buyGoals", false)
		q.openMerchant()
		stub.advance(1)
		emit(#bought())
	"#,
	]
	.concat());
	assert_eq!(out[0], json!(["2x1"]), "the sale paid for it");
	assert_eq!(out[1], true);
	assert_eq!(out[2], 0, "paid in another currency: left alone");
	assert_eq!(out[3], 0, "Shift: nothing");
	assert_eq!(out[4], 0, "off: nothing");
}

#[test]
fn buying_optional_buy_goals_are_left_to_the_player_like_the_raptor_colours_buy_any_you_want_or_none() {
	let out = run(&[
		GOODS,
		r#"
		set("buyGoals", true)
		q.money = 1000000                 -- 100g
		q.items[8588] = { name = "Whistle of the Emerald Raptor", quality = 1, price = 50000 }
		q.items[8591] = { name = "Whistle of the Turquoise Raptor", quality = 1, price = 50000 }
		q.items[8592] = { name = "Whistle of the Violet Raptor", quality = 1, price = 50000 }
		q.goods = { { id = 8588, price = 200000 }, { id = 8591, price = 200000 }, { id = 8592, price = 200000 } }
		q.step({
			{ t = "buy", item = 8588, npc = 7952, optional = true, itemName = "Whistle of the Emerald Raptor" },
			{ t = "buy", item = 8591, npc = 7952, optional = true, itemName = "Whistle of the Turquoise Raptor" },
			{ t = "buy", item = 8592, npc = 7952, optional = true, itemName = "Whistle of the Violet Raptor" },
		})
		q.openMerchant()
		stub.advance(1)
		emit(#bought())
		emit(printed("Raptor"))
	"#,
	]
	.concat());
	assert_eq!(out[0], 0, "no whistle bought");
	assert_eq!(out[1], false, "and nothing said about them");
}

#[test]
fn buying_a_goal_costing_over_50g_is_left_to_the_player_with_a_line_saying_so_a_big_stack_of_thread_under_it_is_bought() {
	let out = run(&[
		GOODS,
		r#"
		set("buyGoals", true)
		q.money = 3000000                 -- 300g
		q.items[19030] = { name = "Stormpike Battle Charger", quality = 3, price = 0 }
		q.items[8343] = { name = "Heavy Silken Thread", quality = 1, price = 500 }
		q.goods = { { id = 19030, price = 2000000 }, { id = 8343, price = 2000, maxStack = 20 } }
		q.step({
			{ t = "buy", item = 19030, npc = 13217, itemName = "Stormpike Battle Charger" },
			{ t = "buy", item = 8343, count = 120, itemName = "Heavy Silken Thread" },   -- 24g
		})
		q.openMerchant()
		stub.advance(1)
		local n = 0
		for _, c in ipairs(q.calls) do if c[1] == "BuyMerchantItem" and c[2] == 1 then n = n + 1 end end
		emit(n)
		emit(q.money)
		emit(printed("Left 1 Stormpike Battle Charger %(200g 0s 0c%) for you to buy"))
		emit(C_Item.GetItemCount(8343))
	"#,
	]
	.concat());
	assert_eq!(out[0], 0, "the 200g mount is not bought");
	assert_eq!(out[1], 3000000 - 240000, "only the thread is paid for");
	assert_eq!(out[2], true);
	assert_eq!(out[3], 120);
}

#[test]
fn buying_the_50g_cap_weighs_the_whole_goal_not_this_visit_s_stock_5_x_20g_with_2_in_stock_is_left_to_the_player() {
	let out = run(&[
		GOODS,
		r#"
		set("buyGoals", true)
		q.money = 3000000                 -- 300g
		q.items[30] = { name = "Gleaming Bauble", quality = 1, price = 0 }
		q.goods = { { id = 30, price = 200000, numAvailable = 2 } }
		q.step({ { t = "buy", item = 30, count = 5, itemName = "Gleaming Bauble" } })
		q.openMerchant()
		stub.advance(1)
		local n = 0
		for _, c in ipairs(q.calls) do if c[1] == "BuyMerchantItem" then n = n + 1 end end
		emit(n)
		emit(q.money)
		emit(printed("Left 5 Gleaming Bauble %(100g 0s 0c%) for you to buy"))
	"#,
	]
	.concat());
	assert_eq!(out[0], 0, "none bought, though the two in stock cost 40g");
	assert_eq!(out[1], 3000000);
	assert_eq!(out[2], true);
}

#[test]
fn buying_the_50g_cap_also_weighs_the_whole_visit_of_three_20g_goals_at_one_merchant_two_are_bought_the_third_left() {
	let out = run(&[
		GOODS,
		r#"
		set("buyGoals", true)
		q.money = 3000000                 -- 300g
		q.items[31] = { name = "Iron Lockbox", quality = 1, price = 0 }
		q.items[32] = { name = "Silver Lockbox", quality = 1, price = 0 }
		q.items[33] = { name = "Gold Lockbox", quality = 1, price = 0 }
		q.goods = { { id = 31, price = 200000 }, { id = 32, price = 200000 }, { id = 33, price = 200000 } }
		q.step({
			{ t = "buy", item = 31, itemName = "Iron Lockbox" },
			{ t = "buy", item = 32, itemName = "Silver Lockbox" },
			{ t = "buy", item = 33, itemName = "Gold Lockbox" },
		})
		q.openMerchant()
		stub.advance(1)
		local n = 0
		for _, c in ipairs(q.calls) do if c[1] == "BuyMerchantItem" then n = n + c[3] end end
		emit(n)
		emit(q.money)
		emit(printed("Left 1 Gold Lockbox %(20g 0s 0c%) for you to buy"))
	"#,
	]
	.concat());
	assert_eq!(out[0], 2, "two lockboxes bought");
	assert_eq!(out[1], 3000000 - 400000);
	assert_eq!(out[2], true);
}

// ---------------------------------------------------------------------------
// Class trainer
// ---------------------------------------------------------------------------

const SPELLS: &str = r#"
	q.trainer = { tradeskill = false, services = {
		{ name = "Fireball", rank = "Rank 1", kind = "used", cost = 0 },
		{ name = "Fireball", rank = "Rank 2", kind = "available", cost = 100 },
		{ name = "Frost Armor", rank = "Rank 1", kind = "available", cost = 200 },
		{ name = "Arcane Missiles", rank = "Rank 1", kind = "unavailable", cost = 50 },
	} }
"#;

#[test]
fn trainer_learns_every_spell_it_offers_now_one_per_list_update_and_prints_the_total() {
	let out = run(&[
		SPELLS,
		r#"
		set("trainAll", true)
		q.money = 1000
		q.openTrainer()
		emit(#calls("BuyTrainerService"))   -- one at a time: the list moves after each
		stub.advance(1)
		local out = {}
		for _, c in ipairs(q.calls) do if c[1] == "BuyTrainerService" then out[#out + 1] = c[2] .. " " .. c[3] end end
		emit(out)
		emit({ money = q.money, msg = printed("Learned 2 spells for 3s 0c") })
	"#,
	]
	.concat());
	assert_eq!(out[0], 1);
	assert_eq!(out[1], json!(["Fireball Rank 2", "Frost Armor Rank 1"]));
	assert_eq!(out[2], json!({ "money": 700, "msg": true }));
}

#[test]
fn trainer_waits_for_each_purchase_to_land_before_the_next_whatever_else_updates_the_list() {
	let out = run(&[
		SPELLS,
		r#"
		set("trainAll", true)
		q.money = 1000
		q.openTrainer()
		stub.fire("TRAINER_UPDATE")      -- not from the purchase, which has not landed yet
		stub.fire("TRAINER_UPDATE")
		local early = #calls("BuyTrainerService")
		stub.advance(1)
		emit({ early = early, bought = #calls("BuyTrainerService"), money = q.money, msg = printed("Learned 2 spells for 3s 0c") })
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "early": 1, "bought": 2, "money": 700, "msg": true }));
}

#[test]
fn trainer_a_refused_purchase_ends_the_run_one_still_on_its_way_at_closing_is_counted() {
	let out = run(&[
		SPELLS,
		r#"
		set("trainAll", true)
		q.money = 1000
		q.trainer.services[3].refuse = true   -- Frost Armor
		q.openTrainer()
		stub.advance(3)
		emit({ bought = #calls("BuyTrainerService"), msg = printed("Learned 1 spell for 1s 0c") })
		q.closeTrainer()

		stub.messages = {}
		q.trainer.services = {
			{ name = "Fireball", rank = "Rank 2", kind = "available", cost = 100 },
			{ name = "Frost Armor", rank = "Rank 1", kind = "available", cost = 200 },
		}
		q.openTrainer()
		q.closeTrainer()                  -- before the first purchase lands
		emit(printed("Learned 1 spell for 1s 0c"))
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "bought": 2, "msg": true }));
	assert_eq!(out[1], true);
}

#[test]
fn trainer_learns_what_you_can_afford_and_says_how_much_more_the_rest_costs() {
	let out = run(&[
		SPELLS,
		r#"
		set("trainAll", true)
		q.money = 150
		q.openTrainer()
		stub.advance(1)
		emit({ bought = #calls("BuyTrainerService"), money = q.money,
			learned = printed("Learned 1 spell for 1s 0c"), short = printed("Not enough money for 1 more %(2s 0c%)") })
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "bought": 1, "money": 50, "learned": true, "short": true }));
}

#[test]
fn trainer_off_by_default_profession_trainers_shift_and_closing_the_window_stop_it() {
	let out = run(&[
		SPELLS,
		r#"
		q.money = 1000
		q.openTrainer(); stub.advance(1)
		emit(#calls("BuyTrainerService"))
		q.closeTrainer()

		set("trainAll", true)
		q.trainer.tradeskill = true
		q.openTrainer(); stub.advance(1)
		emit(#calls("BuyTrainerService"))
		q.closeTrainer()
		q.trainer.tradeskill = false

		stub.keys.shift = true
		q.openTrainer(); stub.advance(1)
		emit(#calls("BuyTrainerService"))
		q.closeTrainer()
		stub.keys.shift = false

		q.openTrainer()
		q.closeTrainer()
		stub.advance(1)
		emit(#calls("BuyTrainerService"))
	"#,
	]
	.concat());
	assert_eq!(out[0], 0, "off by default");
	assert_eq!(out[1], 0, "profession trainer");
	assert_eq!(out[2], 0, "Shift");
	assert_eq!(out[3], 1, "closed after the first purchase: no more");
}

#[test]
fn trainer_riding_weapon_and_pet_trainers_are_left_alone_so_opening_one_to_check_a_price_spends_nothing() {
	let out = run(r#"
		set("trainAll", true)
		for _, t in ipairs({                                            -- none of them a class trainer
			{ npc = 4732, name = "Apprentice Riding", cost = 1000000 },   -- Randal Hunter, riding
			{ npc = 90001, name = "Swords", cost = 1000 },                -- a weapon master
			{ npc = 90002, name = "Bite", cost = 500 },                   -- a pet trainer
		}) do
			q.money, q.calls = 1000000, {}
			q.trainer = { tradeskill = false, services = { { name = t.name, rank = "", kind = "available", cost = t.cost } } }
			q.openTrainer(t.npc); stub.advance(1)
			emit(#calls("BuyTrainerService"))
			q.closeTrainer()
		end
	"#);
	assert_eq!(json!(out), json!([0, 0, 0]));
}

#[test]
fn trainer_turning_training_off_even_back_on_holding_shift_or_logging_out_while_a_purchase_is_on_its_way_buys_nothing_more() {
	let purchases = |between: &str| {
		run(&[
			SPELLS,
			r#"
		set("trainAll", true)
		q.money = 1000
		q.openTrainer()                  -- the first purchase is on its way
		"#,
			between,
			r#"
		stub.advance(3)
		emit(#calls("BuyTrainerService"))
	"#,
		]
		.concat())[0]
			.clone()
	};
	let got = json!({
		"off": purchases(r#"set("trainAll", false)"#),
		"offOn": purchases(r#"set("trainAll", false); set("trainAll", true)"#),
		"shift": purchases("stub.keys.shift = true"),
		"logout": purchases(r#"stub.fire("PLAYER_LOGOUT")"#),
		"closed": purchases("q.closeTrainer()"),
		"left": purchases(""),
	});
	assert_eq!(got, json!({ "off": 1, "offOn": 1, "shift": 1, "logout": 1, "closed": 1, "left": 2 }));
}

#[test]
fn trainer_a_purchase_that_has_landed_when_shift_stops_the_run_is_still_counted_in_the_summary() {
	let out = run(&[
		SPELLS,
		r#"
		set("trainAll", true)
		q.money = 1000
		q.openTrainer()
		stub.keys.shift = true           -- held as the first purchase lands
		stub.advance(3)
		emit({ bought = #calls("BuyTrainerService"), money = q.money, msg = printed("Learned 1 spell for 1s 0c") })
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "bought": 1, "money": 900, "msg": true }));
}

#[test]
fn trainer_a_purchase_still_on_its_way_when_the_setting_is_turned_off_is_counted_in_the_summary_as_on_close() {
	let out = run(&[
		SPELLS,
		r#"
		set("trainAll", true)
		q.money = 1000
		q.openTrainer()                  -- the first purchase is on its way
		set("trainAll", false)
		stub.advance(3)
		emit({ bought = #calls("BuyTrainerService"), money = q.money, msg = printed("Learned 1 spell for 1s 0c") })
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "bought": 1, "money": 900, "msg": true }));
}

// ---------------------------------------------------------------------------
// Quest rewards
// ---------------------------------------------------------------------------

#[test]
fn rewards_ranking_by_gear_upgrade_else_vendor_value_stack_included() {
	let out = run(r#"
		local R = QoL.Rewards
		emit({ R.Rank({ { index = 1, value = 100 }, { index = 2, value = 300 }, { index = 3, value = 300 }, { index = 4, value = 50 } }) })
		emit({ R.Rank({
			{ index = 1, value = 900, upgrade = false, delta = -2 },
			{ index = 2, value = 10, upgrade = true, delta = 4 },
			{ index = 3, value = 20, upgrade = true, delta = 12 },
			{ index = 4, value = 5000 },
		}) })
		emit({ R.Rank({ { index = 1, value = 10, upgrade = false, delta = -1 }, { index = 2, value = 20, upgrade = true, delta = 0 } }) })
	"#);
	assert_eq!(out[0], json!([[2, 3, 1, 4], "value"]));
	assert_eq!(out[1], json!([[3, 2, 4, 1], "upgrade"]));
	assert_eq!(out[2], json!([[2, 1], "value"]), "a zero-delta \"upgrade\" is no upgrade");
}

// The marks on the reward panel, per choice: the upgrade badge ("qol-upgrade" or false) and its tint, the coin
// on the most valuable (true or false), whether the best's hairline is drawn, and whether the mark hangs off
// the item icon (never over the name).
const MARKS: &str = r#"
local T = Polestar.Theme
local function tint(t)
	local r, g, b = t:GetVertexColor()
	local sr, sg, sb = T.Color("success")
	local ar, ag, ab = T.Accent()
	if r == sr and g == sg and b == sb then return "success" end
	if r == ar and g == ag and b == ab then return "accent" end
	return "other"
end
local function marks()
	local out = {}
	for _, b in ipairs(QuestInfoRewardsFrame.RewardButtons) do
		if b:IsShown() then
			local seen = { badge = false, coin = false, best = false }
			for _, c in ipairs(b.children) do
				if c.Badge and c:IsShown() then
					if c.Badge:IsShown() then
						seen.badge = c.Badge:GetTexture():match("([%w-]+)$")
						seen.tint = tint(c.Badge)
					end
					seen.coin = c.Coin:IsShown()
					seen.best = c.Ring[1]:IsShown()
					seen.onIcon = select(2, c:GetPoint(1)) == b.Icon
				end
			end
			out[b:GetID()] = seen
		end
	end
	return out
end"#;

#[test]
fn rewards_a_green_arrow_on_every_upgrade_the_best_framed_on_the_icon_the_coin_always_on_the_most_valuable_no_pick_by_default() {
	let out = run(&[
		MARKS,
		r#"
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Potion", price = 50 }
		q.items[13] = { name = "Boots", price = 90 }
		q.choices = { { id = 11 }, { id = 12, count = 5 }, { id = 13 } }
		q.questComplete()
		stub.runTimers()
		emit({ best = QoL.Rewards.best, reason = QoL.Rewards.reason, picks = #calls("GetQuestReward") })
		emit(marks())

		Polestar.Gear = {
			IsEnabled = function() return true end,
			CompareToEquipped = function() return { usable = true } end,
			IsUpgrade = function(link)
				if link:find("item:13") then return true, 8 end
				if link:find("item:11") then return true, 3 end
				return false, -1
			end,
		}
		q.questComplete()
		stub.runTimers()
		emit({ best = QoL.Rewards.best, reason = QoL.Rewards.reason })
		emit(marks())
		stub.fire("QUEST_FINISHED")
		emit(marks())
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "best": 2, "reason": "value", "picks": 0 }), "five potions sell for most");
	assert_eq!(
		out[1],
		json!([
			{ "badge": false, "coin": false, "best": false },
			{ "badge": false, "coin": true, "best": true, "onIcon": true },
			{ "badge": false, "coin": false, "best": false },
		])
	);
	assert_eq!(out[2], json!({ "best": 3, "reason": "upgrade" }));
	assert_eq!(
		out[3],
		json!([
			{ "badge": "qol-upgrade", "tint": "success", "coin": false, "best": false, "onIcon": true },
			{ "badge": false, "coin": true, "best": false, "onIcon": true },
			{ "badge": "qol-upgrade", "tint": "success", "coin": false, "best": true, "onIcon": true },
		]),
		"both upgrades get the arrow; the bigger one is framed; the five potions still show the coin"
	);
	assert_eq!(out[4], json!([{ "badge": false, "coin": false, "best": false }, { "badge": false, "coin": false, "best": false }, { "badge": false, "coin": false, "best": false }]));
}

#[test]
fn rewards_a_disabled_gear_module_marks_no_upgrades_a_single_choice_gets_its_arrow_but_no_frame() {
	let out = run(&[
		MARKS,
		r#"
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Ring", price = 400 }
		q.choices = { { id = 11 }, { id = 12 } }
		local on = false
		Polestar.Gear = { IsEnabled = function() return on end, IsUpgrade = function(link) return link:find("item:11") ~= nil, 5 end }
		q.questComplete(); stub.runTimers()
		emit(marks())
		on = true
		q.choices = { { id = 11 } }
		q.questComplete(); stub.runTimers()
		emit(marks())
	"#,
	]
	.concat());
	assert_eq!(out[0], json!([{ "badge": false, "coin": false, "best": false }, { "badge": false, "coin": true, "best": true, "onIcon": true }]));
	assert_eq!(out[1], json!([{ "badge": "qol-upgrade", "tint": "success", "coin": false, "best": false, "onIcon": true }]));
}

// The gamepad interface hooks CreateFrame and, for a parent inside the quest frame while it is open, rebuilds
// the quest frame's buttons in the caller's code: a mark made by CreateFrame under a reward button, from
// Polestar's code, blocks the next gamepad action there (the A that takes the reward). wow_stub.lua's
// CreateFrame lists those in stub.underGameFrames.
#[test]
fn rewards_a_mark_is_made_with_no_parent_then_set_on_its_reward_button_so_the_gamepad_interface_never_rebuilds_the_quest_frame_s_buttons_in_polestar_s_code() {
	let out = run(&[
		MARKS,
		r#"
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Potion", price = 50 }
		q.choices = { { id = 11 }, { id = 12, count = 5 } }
		Polestar.Gear = { IsEnabled = function() return true end, CompareToEquipped = function() return { usable = true } end, IsUpgrade = function(link) return link:find("item:11") ~= nil, 4 end }
		q.questComplete()
		stub.runTimers()
		local on = 0
		for _, b in ipairs(QuestInfoRewardsFrame.RewardButtons) do
			for _, c in ipairs(b.children) do
				if c.Badge and c:IsShown() and c:GetParent() == b then on = on + 1 end
			end
		end
		emit({ marks = on, under = table.concat(stub.underGameFrames, "; ") })
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "marks": 2, "under": "" }), "both choices are marked, on their own buttons, and no CreateFrame names a game frame as parent");
}

#[test]
fn rewards_auto_pick_takes_the_best_when_on_shift_quest_cost_and_a_disabled_gear_module_are_respected() {
	let out = run(r#"
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Ring", price = 400 }
		q.choices = { { id = 11 }, { id = 12 } }
		Polestar.Gear = { IsEnabled = function() return false end, IsUpgrade = function() return true, 50 end }
		set("rewardAutoPick", true)
		q.questComplete(); stub.runTimers()
		emit(calls("GetQuestReward"))
		q.calls = {}
		stub.keys.shift = true
		q.questComplete(); stub.runTimers()
		stub.keys.shift = false
		emit(#calls("GetQuestReward"))
		q.questMoney = 100
		q.questComplete(); stub.runTimers()
		emit(#calls("GetQuestReward"))
	"#);
	assert_eq!(out[0], json!([2]), "disabled Gear: vendor value decides");
	assert_eq!(out[1], 0);
	assert_eq!(out[2], 0);
}

#[test]
fn rewards_auto_pick_leaves_the_choice_to_the_player_when_a_price_is_still_unknown_after_every_retry() {
	let out = run(r#"
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Ring" }             -- its price never arrives
		q.choices = { { id = 11 }, { id = 12 } }
		set("rewardAutoPick", true)
		q.questComplete(); stub.advance(5)
		emit({ picks = #calls("GetQuestReward"), best = QoL.Rewards.best or false })
		q.items[12].price = 400                     -- known on the next turn-in
		q.questComplete(); stub.advance(5)
		emit(calls("GetQuestReward"))
	"#);
	assert_eq!(out[0], json!({ "picks": 0, "best": false }), "a retry deadline is no evidence the unpriced ring is worth less");
	assert_eq!(out[1], json!([2]), "with every price known, the most valuable is taken");
}

#[test]
fn rewards_an_unsettled_gear_verdict_keeps_the_coin_on_the_most_valuable_reward_and_picks_nothing() {
	let out = run(&[
		MARKS,
		r#"
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Potion", price = 50 }
		q.choices = { { id = 11 }, { id = 12 } }
		-- Gear is on but has no comparison yet for either choice.
		Polestar.Gear = { IsEnabled = function() return true end, CompareToEquipped = function() return nil end, IsUpgrade = function() return false, nil end }
		q.questComplete(); stub.advance(5)          -- every retry spent
		emit(marks())
		emit(#calls("GetQuestReward"))
	"#,
	]
	.concat());
	assert_eq!(
		out[0],
		json!([
			{ "badge": false, "coin": true, "best": false, "onIcon": true },
			{ "badge": false, "coin": false, "best": false },
		]),
		"every link and price is known: the coin needs no gear verdict; the frame does"
	);
	assert_eq!(out[1], 0);
}

#[test]
fn rewards_auto_pick_never_takes_a_reward_while_a_link_is_missing_with_or_without_retry_timers() {
	let out = run(r#"
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Ring", price = 400, uncached = true }   -- no link, no price yet
		q.choices = { { id = 11 }, { id = 12 } }
		set("rewardAutoPick", true)
		q.questComplete(); stub.advance(5)
		emit(#calls("GetQuestReward"))
		q.calls = {}
		local timer = C_Timer
		C_Timer = nil                               -- no retries: evaluated once, in the event
		q.questComplete()
		C_Timer = timer
		emit(#calls("GetQuestReward"))
	"#);
	assert_eq!(out[0], 0);
	assert_eq!(out[1], 0, "incomplete data with no retry left is not a choice");
}

#[test]
fn rewards_a_deferred_auto_pick_does_not_take_a_reward_for_a_different_quest() {
	let out = run(r#"
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Ring", price = 400 }
		q.choices = { { id = 11 }, { id = 12 } }
		set("rewardAutoPick", true)
		q.questID = 7
		q.questComplete()
		q.questID = 8                               -- another quest's panel, with no QUEST_FINISHED between
		stub.runTimers()
		emit(#calls("GetQuestReward"))
	"#);
	assert_eq!(out[0], 0);
}

#[test]
fn rewards_turning_auto_pick_off_and_on_again_while_a_pick_is_pending_cancels_that_pick() {
	let out = run(r#"
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Ring", price = 400 }
		q.choices = { { id = 11 }, { id = 12 } }
		set("rewardAutoPick", true)
		q.questComplete()                           -- the pick waits for the panel's layout
		Polestar.Set("qol.rewardAutoPick", false)
		Polestar.Set("qol.rewardAutoPick", true)
		stub.runTimers()
		emit(#calls("GetQuestReward"))
	"#);
	assert_eq!(out[0], 0, "the consent given when the panel opened was withdrawn");
}

const WEAR: &str = r#"
	q.items[11] = { name = "Sturdy Boots", quality = 2 }
	q.items[12] = { name = "Light Gloves", quality = 2 }
	q.items[13] = { name = "Old Belt", quality = 1 }
	q.landRewards = true
	-- A quest offering the boots or the gloves, the belt with every turn-in;
	-- the panel empties after each turn-in, as the client's does.
	local function offer(choices, rewards)
		q.choices, q.rewards = choices or { { id = 11 }, { id = 12 } }, rewards or { { id = 13 } }
		q.questComplete(); stub.runTimers()
	end
	local function turnIn(i, choices, rewards)
		offer(choices, rewards)
		GetQuestReward(i)
		stub.advance(1)
	end
	Polestar.Gear = {
		IsEnabled = function() return true end,
		IsUpgrade = function(link)
			if link:find("item:11|", 1, true) then return true, 6, 12.5 end
			if link:find("item:13|", 1, true) then return true, 2, nil end
			return false, -1
		end,
		CompareToEquipped = function(link) return { slot = link:find("item:11|", 1, true) and 8 or 6 } end,
		Client = { InventoryLink = function(slot) return q.worn[slot] and ("|Hitem:" .. q.worn[slot] .. "|h") end },
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
"#;

#[test]
fn rewards_what_a_turn_in_gives_is_worn_once_it_reaches_the_bags_when_it_is_an_upgrade() {
	let out = run(&[
		WEAR,
		r#"
		set("rewardEquip", true)
		offer()
		GetQuestReward(1)                 -- the player's pick; the belt comes with every turn-in
		local early = #worn()
		stub.advance(1)
		emit({ early = early, worn = worn(), boots = printed("Wearing |Hitem:11|h%[Sturdy Boots%]|h %(%+13%%%)"), belt = printed("Wearing |Hitem:13|h%[Old Belt%]|h%.") })
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "early": 0, "worn": ["11@8", "13@6"], "boots": true, "belt": true }));
}

#[test]
fn rewards_wearing_waits_for_combat_to_end_off_by_default_shift_at_the_turn_in_a_pick_that_is_no_upgrade_and_a_disabled_gear_module_wear_nothing() {
	let out = run(&[
		WEAR,
		r#"
		turnIn(1)
		emit(#worn())                       -- off by default

		set("rewardEquip", true)
		q.combat(true)
		turnIn(1)
		local inCombat = #worn()
		q.combat(false)
		stub.advance(1)
		emit({ inCombat = inCombat, after = worn() })

		q.calls = {}
		stub.keys.shift = true
		turnIn(1)
		stub.keys.shift = false
		emit(#worn())

		turnIn(2, nil, {})
		emit(#worn())                       -- the gloves are no upgrade

		Polestar.Gear.IsEnabled = function() return false end
		turnIn(1)
		emit(#worn())
	"#,
	]
	.concat());
	assert_eq!(out[0], 0, "off by default");
	assert_eq!(out[1], json!({ "inCombat": 0, "after": ["11@8", "13@6"] }));
	assert_eq!(out[2], 0, "Shift");
	assert_eq!(out[3], 0, "no upgrade");
	assert_eq!(out[4], 0, "Gear disabled");
}

#[test]
fn rewards_a_turn_in_made_before_anything_else_sees_the_panel_wears_that_quest_s_item_not_the_last_quest_s() {
	let out = run_with(
		&[
			WEAR,
			r#"
		set("rewardEquip", true)
		turnIn(2, nil, {})                  -- the gloves: nothing worn, but this panel offered the boots too
		q.calls = {}
		q.early = true                      -- turns in on QUEST_COMPLETE, ahead of Polestar, as automation does
		offer({ { id = 13 } }, {})          -- the only reward: the belt
		stub.advance(1)
		emit(worn())
	"#,
		]
		.concat(),
		r#"
			local f = CreateFrame("Frame")
			f:RegisterEvent("QUEST_COMPLETE")
			f:SetScript("OnEvent", function() if stub.qol.early then GetQuestReward(1) end end)
		"#,
		None,
	);
	assert_eq!(out[0], json!(["13@6"]));
}

#[test]
fn rewards_only_a_new_copy_counts_an_older_one_in_the_bags_or_a_turn_in_that_never_delivers_wears_nothing() {
	let out = run(&[
		WEAR,
		r#"
		set("rewardEquip", true)
		q.addItem(0, 9, 11, 1)              -- boots from before
		q.landRewards = false               -- the turn-in never delivers
		offer()
		GetQuestReward(1)
		stub.fire("BAG_UPDATE_DELAYED")     -- something else moves in the bags
		stub.advance(12)
		q.addItem(0, 10, 11, 1)             -- boots from elsewhere, long after the turn-in
		stub.fire("BAG_UPDATE_DELAYED")
		emit(worn())
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({}));
}

// Gear answering from what is worn now (q.worn) and fixed scores, as the real one does: a ring replaces the
// weaker finger, and a one-hand or off-hand piece against a worn two-hander is weighed together with the best
// partner in the bags (q.bagPartner).
const GEAR: &str = r#"
	local score, inv = {}, {} -- item ID -> score, inventory type
	local function linkOf(id) return id and ("|Hitem:" .. id .. "|h[" .. ((q.items[id] or {}).name or "?") .. "]|h") end
	local function idOf(link) return tonumber(link:match("item:(%d+)")) end
	local function at(slot) return score[q.worn[slot]] or 0 end
	Polestar.Gear = {
		IsEnabled = function() return true end,
		Client = { InventoryLink = function(slot) return linkOf(q.worn[slot]) end },
		GetItemInfo = function(link) local id = idOf(link); return inv[id] and { id = id, inv = inv[id] } end,
		GainText = function(pct) return "+" .. math.floor(pct + 0.5) .. "%" end,
		CompareToEquipped = function(link)
			local id = idOf(link)
			local s, t, r = score[id], inv[id]
			if t == 11 then
				local slot = at(12) < at(11) and 12 or 11
				r = { slot = slot, old = at(slot), new = s }
			elseif (t == 13 or t == 14) and inv[q.worn[16]] == 17 then
				r = { slot = t == 14 and 17 or 16, old = at(16), new = s + (q.bagPartner or 0) }
			else
				local slot = ({ [8] = 8, [13] = 16, [14] = 17 })[t]
				r = { slot = slot, old = at(slot), new = s }
			end
			r.score, r.delta = s, r.new - r.old
			r.pct = r.old > 0 and r.delta / r.old * 100 or nil
			return r
		end,
	}
	Polestar.Gear.IsUpgrade = function(link)
		local r = Polestar.Gear.CompareToEquipped(link)
		return r.delta > 0, r.delta, r.pct
	end
"#;

#[test]
fn rewards_with_a_two_hander_worn_a_one_hand_reward_is_worn_only_when_it_beats_the_two_hander_by_itself_and_an_off_hand_piece_never() {
	let out = run(&[
		WEAR,
		GEAR,
		r#"
		set("rewardEquip", true)
		q.items[30], q.items[31], q.items[32] = { name = "Greatsword" }, { name = "Short Sword" }, { name = "Buckler" }
		score[30], inv[30] = 10, 17
		score[31], inv[31] = 7, 13
		score[32], inv[32] = 6, 14
		q.worn[16] = 30
		q.bagPartner = 5                    -- 7 + 5 and 6 + 5 beat the 10 only with a bag piece
		turnIn(1, { { id = 31 } }, { { id = 32 } })
		emit({ worn = worn(), main = q.worn[16] })

		score[32] = 12                      -- a buckler that beats the two-hander by itself
		turnIn(1, { { id = 32 } }, {})
		emit({ worn = worn(), main = q.worn[16] })

		score[31] = 11                      -- beats the two-hander by itself
		turnIn(1, { { id = 31 } }, {})
		emit({ worn = worn(), main = q.worn[16], said = printed("Wearing |Hitem:31|h%[Short Sword%]|h %(%+10%%%)") })
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "worn": {}, "main": 30 }), "the two-hander stays on");
	assert_eq!(out[1], json!({ "worn": {}, "main": 30 }), "an off-hand piece would leave the main hand empty: it stays in the bags");
	assert_eq!(out[2], json!({ "worn": ["31@16"], "main": 31, "said": true }));
}

#[test]
fn rewards_with_a_two_hander_worn_a_reward_for_any_other_slot_goes_in_its_own_slot() {
	let out = run(&[
		WEAR,
		GEAR,
		r#"
		set("rewardEquip", true)
		score[30], inv[30] = 10, 17
		score[11], inv[11] = 4, 8           -- the boots, for the feet
		q.worn[16] = 30
		turnIn(1, { { id = 11 } }, {})
		emit(worn())
	"#,
	]
	.concat());
	assert_eq!(out[0], json!(["11@8"]));
}

#[test]
fn rewards_two_rings_from_one_turn_in_go_on_one_at_a_time_the_second_on_the_other_finger_only_when_it_beats_the_ring_there() {
	let fingers = |worn11: i32| {
		run(&[
			WEAR,
			GEAR,
			r#"
		set("rewardEquip", true)
		for id, s in pairs({ [20] = __WORN11__, [21] = 10, [22] = 8, [23] = 3 }) do score[id], inv[id] = s, 11 end
		q.worn[11], q.worn[12] = 20, 23
		turnIn(1, { { id = 21 } }, { { id = 22 } })   -- the pick (10) and a ring every turn-in gives (8)
		emit({ worn = worn(), fingers = { q.worn[11], q.worn[12] } })
	"#,
		]
		.concat()
		.replace("__WORN11__", &worn11.to_string()))
		.remove(0)
	};
	assert_eq!(fingers(5), json!({ "worn": ["21@12", "22@11"], "fingers": [22, 21] }), "the second ring beats the 5 on the other finger");
	assert_eq!(fingers(9), json!({ "worn": ["21@12"], "fingers": [20, 21] }), "the second ring loses to the 9 and leaves the first alone");
}

#[test]
fn rewards_another_slot_changing_while_a_ring_is_still_going_on_does_not_send_the_next_ring_to_the_same_finger() {
	let out = run(&[
		WEAR,
		GEAR,
		r#"
		set("rewardEquip", true)
		for id, s in pairs({ [20] = 5, [21] = 10, [22] = 8, [23] = 3 }) do score[id], inv[id] = s, 11 end
		q.worn[11], q.worn[12] = 20, 23
		offer({ { id = 21 } }, { { id = 22 } })
		GetQuestReward(1)
		stub.advance(0.1)                   -- both rings land; the first is on its way to a finger
		stub.fire("PLAYER_EQUIPMENT_CHANGED", 1, true)
		stub.advance(1)
		emit({ worn = worn(), fingers = { q.worn[11], q.worn[12] } })
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "worn": ["21@12", "22@11"], "fingers": [22, 21] }));
}

#[test]
fn rewards_a_reward_that_never_goes_on_its_bind_confirmation_cancelled_holds_up_the_next_one_only_for_a_while() {
	let out = run(&[
		WEAR,
		GEAR,
		r#"
		set("rewardEquip", true)
		for id, s in pairs({ [20] = 5, [21] = 10, [22] = 8, [23] = 3 }) do score[id], inv[id] = s, 11 end
		q.worn[11], q.worn[12] = 20, 23
		q.refuse[21] = true
		turnIn(1, { { id = 21 } }, { { id = 22 } })
		stub.advance(12)
		emit({ worn = worn(), fingers = { q.worn[11], q.worn[12] },
			refused = printed("Wearing |Hitem:21|"), second = printed("Wearing |Hitem:22|") })
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "worn": ["21@12", "22@12"], "fingers": [20, 22], "refused": false, "second": true }), "only what goes on is announced");
}

// The real Gear module (Arms Warrior, level 30, no Dual Wield) scoring ItemDB entries in the generated format,
// reading what q.worn and q.bags hold.
#[test]
fn rewards_with_the_real_gear_module_a_two_hander_stays_on_against_a_one_hander_that_wins_only_with_a_bag_shield_rings_end_as_the_best_two() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_qol.lua"],
		addons: vec![Addon::files(
			"Polestar",
			&["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "Gear/ItemDB.lua", "Gear/Weights.lua", "Gear/SpecData.lua", "Gear/PawnStats.lua", "Gear/Pawn.lua", "Gear/Gear.lua", "QoL/QoL.xml"],
		)],
		before: r#"
			local q = stub.qol
			q.level = 30
			function UnitClass(unit) return "Warrior", "WARRIOR", 1 end
			function UnitRace(unit) return "Troll", "Troll", 8 end
			function UnitFactionGroup(unit) return "Horde" end
			local function linkOf(id) return id and ("|Hitem:" .. id .. "|h[" .. ((q.items[id] or {}).name or "?") .. "]|h") end
			function GetInventoryItemLink(unit, slot) if unit == "player" then return linkOf(q.worn[slot]) end end
			function C_Container.GetContainerItemLink(bag, slot) local s = q.bags[bag].slots[slot]; return s and linkOf(s.itemID) end
		"#
		.into(),
		login: true,
		script: [
			PRELUDE,
			r#"
			Polestar.ItemDB.Register({ schema = 1, build = "test" }, {
				[9032] = "17 22 17 2 2 8 str10 dmin40 dmax60 speed3000",          -- two-hander: 126.9
				[9033] = "13 22 17 2 2 7 agi3 dmin12 dmax22 speed1800",           -- weak one-hander: 67.6
				[9034] = "14 30 25 3 4 6 sta20 armor3000",                        -- strong shield: 70
				[9035] = "13 30 25 3 2 7 str20 dmin30 dmax50 speed2000",          -- strong one-hander: 160
				[9010] = "11 20 15 2 4 0 sta5", [9011] = "11 20 15 2 4 0 sta2",
				[9012] = "11 20 15 2 4 0 sta4", [9013] = "11 25 20 3 4 0 sta6",
			})
			for _, id in ipairs({ 9032, 9033, 9034, 9035, 9010, 9011, 9012, 9013 }) do q.items[id] = { name = "Item " .. id } end
			q.landRewards = true
			set("rewardEquip", true)
			local function turnIn(choices, rewards)
				q.choices, q.rewards = choices, rewards
				q.questComplete(); stub.runTimers()
				GetQuestReward(1)
				stub.advance(1)
			end
			local function worn()
				local out = {}
				for _, c in ipairs(q.calls) do
					if c[1] == "EquipItemByName" then out[#out + 1] = c[2]:match("item:(%d+)") .. "@" .. tostring(c[3]) end
				end
				return out
			end

			q.worn[16] = 9032
			q.addItem(0, 16, 9034, 1)             -- the shield waits in the bags
			turnIn({ { id = 9033 } }, {})
			emit({ worn = worn(), main = q.worn[16], off = q.worn[17] or false })

			q.calls = {}
			turnIn({ { id = 9035 } }, {})
			emit({ worn = worn(), main = q.worn[16], said = printed("Wearing |Hitem:9035|h%[Item 9035%]|h %(%+26%%%)") })

			q.calls = {}
			q.worn[11], q.worn[12] = 9013, 9011   -- 3 and 1
			turnIn({ { id = 9012 } }, { { id = 9010 } })   -- 2 takes the 1's finger, then 2.5 takes the 2's
			emit({ worn = worn(), fingers = { q.worn[11], q.worn[12] } })
		"#,
		]
		.concat(),
		..Default::default()
	});
	assert_eq!(out[0], json!({ "worn": {}, "main": 9032, "off": false }), "the one-hander beats the two-hander only with the bag shield: nothing goes on");
	assert_eq!(out[1], json!({ "worn": ["9035@16"], "main": 9035, "said": true }), "a one-hander that beats the two-hander by itself goes on");
	assert_eq!(out[2], json!({ "worn": ["9012@12", "9010@12"], "fingers": [9013, 9010] }), "the rings end as the best two");
}

#[test]
fn rewards_turning_wearing_off_while_a_reward_waits_for_combat_to_end_wears_nothing() {
	let out = run(&[
		WEAR,
		r#"
		set("rewardEquip", true)
		q.combat(true)
		turnIn(1)
		set("rewardEquip", false)
		q.combat(false)
		stub.advance(1)
		emit(worn())
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({}));
}

#[test]
fn rewards_waits_for_uncached_item_data_before_ranking_an_upgrade_is_marked_from_its_item_id_meanwhile_the_frame_once_it_settles() {
	let out = run(&[
		MARKS,
		r#"
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Ring", price = 400, uncached = true }
		q.choices = { { id = 11 }, { id = 12 } }
		Polestar.Gear = { IsEnabled = function() return true end, CompareToEquipped = function() return { usable = true } end, IsUpgrade = function(link) return link:find("item:12") ~= nil, 4 end }
		q.questComplete()
		stub.runTimers()
		emit(QoL.Rewards.best or "pending")
		emit(marks())
		q.items[12].uncached = nil
		stub.advance(0.35)
		emit(QoL.Rewards.best)
		emit(marks())
	"#,
	]
	.concat());
	assert_eq!(out[0], "pending");
	assert_eq!(
		out[1],
		json!([{ "badge": false, "coin": false, "best": false }, { "badge": "qol-upgrade", "tint": "success", "coin": false, "best": false, "onIcon": true }]),
		"no coin until every price is known"
	);
	assert_eq!(out[2], 2);
	assert_eq!(out[3][1], json!({ "badge": "qol-upgrade", "tint": "success", "coin": true, "best": true, "onIcon": true }), "the ring is both the upgrade and the best seller");
}

#[test]
fn rewards_marking_off_clears_an_open_panel_both_settings_off_do_nothing() {
	let out = run(&[
		MARKS,
		r#"
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Ring", price = 400 }
		q.choices = { { id = 11 }, { id = 12 } }
		q.questComplete(); stub.runTimers()
		emit(marks())
		set("rewardHighlight", false)
		emit(marks())
		local n0 = #stub.messages
		q.questComplete(); stub.runTimers()
		emit(QoL.Rewards.best or "none")
		emit(marks())
		emit(#stub.messages - n0)
	"#,
	]
	.concat());
	let (before, cleared, best, after, msgs) = (&out[0], &out[1], &out[2], &out[3], &out[4]);
	assert_eq!(before[1], json!({ "badge": false, "coin": true, "best": true, "onIcon": true }));
	assert_eq!(*cleared, json!([{ "badge": false, "coin": false, "best": false }, { "badge": false, "coin": false, "best": false }]));
	assert_eq!(*best, "none");
	assert_eq!(after, cleared);
	assert_eq!(*msgs, 0);
}

// ---------------------------------------------------------------------------
// Flight masters
// ---------------------------------------------------------------------------

#[test]
fn flight_gossip_opens_the_flight_map_taxi_icon_or_known_flight_master_shift_and_quests_suppress() {
	let out = run(r#"
		QoL.SetData({ spiritHealers = {}, flightMasters = { 352 } })
		local TAXI = { gossipOptionID = 77, name = "Show me where I can fly.", icon = 132057, orderIndex = 0 }
		local TALK = { gossipOptionID = 78, name = "Tell me about the gryphons.", icon = 132053, orderIndex = 1 }
		q.openGossip(1, { options = { TALK, TAXI } })
		emit(calls("SelectOption"))
		q.calls = {}
		q.openGossip(352, { options = { { gossipOptionID = 80, name = "?", icon = 0, orderIndex = 0 } } })
		emit(calls("SelectOption"))
		q.calls = {}
		stub.keys.shift = true
		q.openGossip(1, { options = { TAXI } })
		stub.keys.shift = false
		emit(#q.calls)
		q.openGossip(1, { options = { TAXI }, available = 1 })
		emit(#q.calls)
		q.openGossip(1, { options = { TAXI }, active = { { questID = 4, isComplete = true } } })
		emit(#q.calls)
		set("flightAutoOpen", false)
		set("skipGossip", false)
		q.openGossip(1, { options = { TAXI } })
		emit(#q.calls)
	"#);
	assert_eq!(out[0], json!([77]));
	assert_eq!(out[1], json!([80]));
	assert_eq!(out[2], 0);
	assert_eq!(out[3], 0);
	assert_eq!(out[4], 0);
	assert_eq!(out[5], 0);
}

#[test]
fn flight_marks_the_route_s_next_flight_destination_else_the_fly_goal_never_takes_the_flight() {
	let out = run(r#"
		q.nav.route = {
			{ kind = "walk", to = { name = "Stormwind" } },
			{ kind = "fly", to = { name = "Sentinel Hill, Westfall" } },
		}
		q.nav.ci = 1
		q.openTaxi({ "Stormwind, Elwynn", "Lakeshire, Redridge", "Sentinel Hill, Westfall" })
		local function marked()
			for i = 1, 3 do
				local tb = _G["TaxiButton" .. i]
				for _, c in ipairs(tb.children) do if c:IsShown() and c.Label and c:GetParent() == tb then return i end end
			end
		end
		emit({ QoL.Flight.node, QoL.Flight.destination, marked() })
		stub.fire("TAXIMAP_CLOSED")
		q.nav.route = nil
		q.step({ { t = "fly", location = "Lakeshire" } })
		q.openTaxi({ "Stormwind, Elwynn", "Lakeshire, Redridge", "Sentinel Hill, Westfall" })
		emit({ QoL.Flight.node, marked() })
		emit(#calls("TakeTaxiNode"))
		stub.fire("TAXIMAP_CLOSED")
		set("flightHighlight", false)
		q.openTaxi({ "Stormwind, Elwynn", "Lakeshire, Redridge" })
		emit(QoL.Flight.node or "none")
	"#);
	assert_eq!(out[0], json!([3, "Sentinel Hill, Westfall", 3]));
	assert_eq!(out[1], json!([2, 2]));
	assert_eq!(out[2], 0);
	assert_eq!(out[3], "none");
}

#[test]
fn flight_the_mark_names_the_destination_node_and_bobs_unless_motion_is_reduced() {
	let out = run(r#"
		q.step({ { t = "fly", location = "Sentinel Hill" } })
		q.openTaxi({ "Stormwind, Elwynn", "Lakeshire, Redridge", "Sentinel Hill, Westfall" })
		local function theMark()
			for _, c in ipairs(TaxiButton3.children) do if c.Label and c.Bob then return c end end
		end
		local m = theMark()
		emit({ m.Label:GetText(), m.Bob.plays or 0, m.Wave.plays or 0, m.Ripple:IsShown() })
		stub.fire("TAXIMAP_CLOSED")
		Polestar.Set("ui.reduceMotion", true)
		q.openTaxi({ "Stormwind, Elwynn", "Lakeshire, Redridge", "Sentinel Hill, Westfall" })
		emit({ m.Bob.plays or 0, m.Wave.plays or 0, m.Ripple:IsShown() })
	"#);
	assert_eq!(out[0][0], "Sentinel Hill");
	assert!(out[0][1].as_f64().unwrap() > 0.0 && out[0][2].as_f64().unwrap() > 0.0 && truthy(&out[0][3]), "the arrow bobs and the ring ripples");
	assert_eq!(out[1], json!([out[0][1].clone(), out[0][2].clone(), false]), "reduced motion plays neither loop and hides the ripple");
}

// ---------------------------------------------------------------------------
// Binding at the guide's inn
// ---------------------------------------------------------------------------

// An innkeeper's gossip: the bind option (the binder icon, no text read) and the vendor's. visit(npc) returns
// the option picked (0: none); confirm() fires the bind confirmation Blizzard shows its popup for, and counts
// what answered it (binder: the interaction type confirmed, 0: none).
const INN: &str = r#"
local BIND = { gossipOptionID = 90, name = "Make this inn your home.", icon = 132052, orderIndex = 0 }
local SHOP = { gossipOptionID = 91, name = "Let me browse your goods.", icon = 132060, orderIndex = 1 }
local function visit(npc, opts)
	q.calls = {}
	q.openGossip(npc, opts or { options = { SHOP, BIND } })
	return calls("SelectOption")[1] or 0
end
local function confirm()
	q.calls = {}
	q.showPopup("CONFIRM_BINDER"); stub.fire("CONFIRM_BINDER", "Goldshire"); stub.runTimers()
	return { binder = calls("ConfirmationInteraction")[1] or 0, cleared = calls("ClearInteraction")[1] or 0, closed = #calls("StaticPopup_Hide") }
end
"#;

#[test]
fn bind_at_the_step_s_innkeeper_picks_the_bind_option_and_confirms_the_bind_off_by_default() {
	let out = run(&[
		INN,
		r#"
		q.step({ { t = "sethome", location = "Goldshire", npc = 295 } })
		emit({ picked = visit(295), answer = confirm(), watching = QoL.Watching("CONFIRM_BINDER") })
		set("autoBind", true)
		emit({ picked = visit(295), answer = confirm(), said = printed("Bound your Hearthstone to Goldshire"), watching = QoL.Watching("CONFIRM_BINDER") })
		-- The icon as overrideIconID; the gossip already closed at the confirmation.
		emit(visit(295, { options = { { gossipOptionID = 92, name = "?", icon = 0, overrideIconID = 132052, orderIndex = 0 } } }))
		q.npc = nil
		emit(confirm())
		-- sethome nearest: any of its candidates.
		q.step({ { t = "sethome", candidates = { { npc = 6790 }, { npc = 295 } } } })
		emit(visit(6790))
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "picked": 0, "answer": { "binder": 0, "cleared": 0, "closed": 0 }, "watching": false }), "off: nothing");
	assert_eq!(out[1], json!({ "picked": 90, "answer": { "binder": 20, "cleared": 20, "closed": 1 }, "said": true, "watching": true }));
	assert_eq!(out[2], 92);
	assert_eq!(out[3], json!({ "binder": 20, "cleared": 20, "closed": 1 }));
	assert_eq!(out[4], 90);
}

#[test]
fn bind_nothing_at_another_innkeeper_with_shift_with_quests_waiting_without_an_open_sethome_goal_or_when_bound_there() {
	let out = run(&[
		INN,
		r#"
		set("autoBind", true)
		local r = {}
		local function both(npc, opts) local picked = visit(npc, opts); return { picked = picked, binder = confirm().binder } end
		q.step({ { t = "sethome", location = "Goldshire", npc = 295 } })
		r.other = both(6790)
		stub.keys.shift = true; r.shift = both(295); stub.keys.shift = false
		-- Shift held only as the popup shows.
		visit(295); stub.keys.shift = true; r.shiftAtConfirm = confirm().binder; stub.keys.shift = false
		-- Quests to pick up or hand in go first; the player picking the bind
		-- option themselves at the step's innkeeper is still confirmed.
		r.quests = both(295, { options = { SHOP, BIND }, available = 1 })
		r.turnin = visit(295, { options = { SHOP, BIND }, active = { { questID = 4, isComplete = true } } })
		q.step({ { t = "sethome", location = "Goldshire", npc = 295, status = "done" } })
		r.done = both(295)
		q.step({ { t = "talk", npc = 295 } })
		r.noGoal = both(295)
		q.nav.boundInn = 295
		q.step({ { t = "sethome", candidates = { { npc = 295 } } } })
		r.bound = both(295)
		emit(r)
	"#,
	]
	.concat());
	let none = json!({ "picked": 0, "binder": 0 });
	assert_eq!(
		out[0],
		json!({
			"other": none, "shift": none, "shiftAtConfirm": 0, "quests": { "picked": 0, "binder": 20 }, "turnin": 0,
			"done": none, "noGoal": none, "bound": none,
		})
	);
}

// ---------------------------------------------------------------------------
// Death helper
// ---------------------------------------------------------------------------

#[test]
fn death_decision_weighs_the_run_against_resurrection_sickness() {
	let out = run(r#"
		local D = QoL.Death
		emit({ D.Sickness(5), D.Sickness(10), D.Sickness(14), D.Sickness(20), D.Sickness(60) })
		emit({ D.Decide(700, 20, 7, 8) })            -- level 8: no sickness, healer is close
		emit({ D.Decide(700, 20, 7, 30) })           -- level 30: 100 s run beats 600 s sickness
		emit({ (D.Decide(nil, 20, 7, 30)) })         -- corpse elsewhere: healer
		emit({ D.Decide(70, 40, 7, 8, "corpse") })   -- healer wins by under 5 s: keep the corpse
	"#);
	assert_eq!(out[0], json!([0, 0, 600, 600, 600]));
	assert_eq!(head(&out[1], 1), json!(["healer"]));
	assert_eq!(head(&out[2], 2), json!(["corpse", 100]));
	assert_eq!(out[3][0], "healer");
	assert_eq!(out[4][0], "corpse");
}

#[test]
fn death_resurrection_sickness_is_forever_s_ten_minutes_from_level_11_or_what_the_game_last_gave_at_that_level_390() {
	let out = run(r#"
		local D = QoL.Death
		-- level 12, corpse 1050 yd (150 s), healer 20 yd: the Classic rule's
		-- 2 minutes sent you to the Spirit Healer; Forever gives ten
		emit({ D.Sickness(11), D.Sickness(12) })
		emit({ D.Decide(1050, 20, 7, 12) })
		-- back from the Spirit Healer at 12 with the debuff on: its length is kept
		q.level = 12
		q.auras[15007] = { spellId = 15007, duration = 120, expirationTime = 1000 }
		stub.fire("PLAYER_UNGHOST")
		local seen = PolestarCharDB.qol.resSickness
		emit({ seen.level, seen.seconds })
		emit({ D.Sickness(12, seen), D.Sickness(13, seen) })
		emit({ (D.Decide(1050, 20, 7, 12, nil, seen)) })
		-- a ghost at 12: the advice uses the length the game gave
		q.auras[15007] = nil
		QoL.SetData({ spiritHealers = { { 0, 20, 0, 9000, 50, 49 } }, flightMasters = {} })
		q.player = { c = 0, wx = 0, wy = 0 }
		local _, cx, cy = q.mapPoint(0, -1050)
		q.corpse = { cx, cy }
		q.ghost = true
		stub.fire("PLAYER_ALIVE")
		local a = QoL.GetDeathAdvice()
		emit({ a.choice, a.sickness })
	"#);
	assert_eq!(out[0], json!([600, 600]));
	assert_eq!(head(&out[1], 1), json!(["corpse"]));
	assert_eq!(out[2], json!([12, 120]));
	assert_eq!(out[3], json!([120, 600]));
	assert_eq!(out[4], json!(["healer"]));
	assert_eq!(out[5], json!(["healer", 120]));
}

#[test]
fn death_as_a_ghost_the_arrow_points_at_the_faster_choice_resurrection_releases_it() {
	let out = run(r#"
		-- healer 20 yd north of the player; corpse 400 yd east
		QoL.SetData({ spiritHealers = { { 0, 20, 0, 9000, 50, 49 }, { 1, 0, 0, 9001, 50, 50 } }, flightMasters = {} })
		q.player = { c = 0, wx = 0, wy = 0 }
		local _, cx, cy = q.mapPoint(0, -400)
		q.corpse = { cx, cy }
		q.level = 30
		q.ghost = true
		stub.fire("PLAYER_ALIVE")
		local t = q.nav.target
		emit({ label = t.label, x = t.x, y = t.y, choice = QoL.GetDeathAdvice().choice, pins = #q.pins["qol.death"] })
		-- level 8: no sickness, the healer wins
		q.level = 8
		stub.advance(1.1)
		t = q.nav.target
		emit({ label = t.label, x = t.x, y = t.y, note = QoL.GetDeathAdvice().note })
		-- the step changed and Nav dropped our target: it comes back on the next tick
		q.nav.target = nil
		stub.advance(1)
		emit(q.nav.target and q.nav.target.label)
		q.ghost = false
		stub.fire("PLAYER_UNGHOST")
		emit({ releases = q.nav.releases, target = q.nav.target == nil, pins = q.pins["qol.death"] == nil, advice = QoL.GetDeathAdvice() == nil })
		local sets = #q.nav.sets
		stub.advance(3)
		emit(#q.nav.sets == sets)
	"#);
	assert_eq!(out[0]["label"], "Your corpse");
	assert!((out[0]["x"].as_f64().unwrap() - 70.0).abs() < 1e-9 && (out[0]["y"].as_f64().unwrap() - 50.0).abs() < 1e-9);
	assert_eq!(out[0]["choice"], "corpse");
	assert_eq!(out[0]["pins"], 2);
	assert_eq!(out[1]["label"], "Spirit Healer");
	assert!((out[1]["x"].as_f64().unwrap() - 50.0).abs() < 1e-9 && (out[1]["y"].as_f64().unwrap() - 49.0).abs() < 1e-9);
	assert!(is_match(text(&out[1]["note"]), r"no resurrection sickness"));
	assert_eq!(out[2], "Spirit Healer");
	assert_eq!(out[3], json!({ "releases": 1, "target": true, "pins": true, "advice": true }));
	assert_eq!(out[4], true, "no more targets after resurrection");
}

#[test]
fn death_a_ghost_in_the_next_zone_is_led_to_the_corpse_on_its_own_zone_map_not_off_the_edge_of_theirs_270() {
	let out = run(r#"
		-- the corpse in 9000 (50, 80); the ghost 900 yd south in zone 9002, where
		-- the client answers for the corpse off the map's top edge (50, -20)
		QoL.SetData({ spiritHealers = {}, flightMasters = {} })
		q.corpse = { 50, 80 }
		q.player = { c = 0, wx = -1500, wy = 0 }
		q.level = 30
		q.ghost = true
		stub.fire("PLAYER_ALIVE")
		local t = q.nav.target
		emit({ label = t.label, map = t.map, x = t.x, y = t.y, yards = QoL.GetDeathAdvice().corpseYards })
		-- walking north into 9000 keeps the same spot
		q.player = { c = 0, wx = -800, wy = 0 }
		stub.advance(1.1)
		t = q.nav.target
		emit({ map = t.map, x = t.x, y = t.y })
	"#);
	assert_eq!(out[0]["label"], "Your corpse");
	assert_eq!(out[0]["map"], 9000);
	assert!((out[0]["x"].as_f64().unwrap() - 50.0).abs() < 1e-9 && (out[0]["y"].as_f64().unwrap() - 80.0).abs() < 1e-9, "corpse at {}, {}", out[0]["x"], out[0]["y"]);
	assert!((out[0]["yards"].as_f64().unwrap() - 900.0).abs() < 1e-9);
	assert_eq!(out[1]["map"], 9000);
	assert!((out[1]["x"].as_f64().unwrap() - 50.0).abs() < 1e-9 && (out[1]["y"].as_f64().unwrap() - 80.0).abs() < 1e-9);
}

#[test]
fn death_in_metres_the_advice_gives_the_distances_in_metres() {
	let out = run(r#"
		Polestar.Set("nav.distanceUnit", "metres")
		QoL.SetData({ spiritHealers = { { 0, 20, 0, 9000, 50, 49 } }, flightMasters = {} })
		q.player = { c = 0, wx = 0, wy = 0 }
		local _, cx, cy = q.mapPoint(0, -400)
		q.corpse = { cx, cy }
		q.level = 8
		q.ghost = true
		stub.fire("PLAYER_ALIVE")
		emit(QoL.GetDeathAdvice().note)
	"#);
	assert_eq!(out[0], "Resurrect at the Spirit Healer (18 m): no resurrection sickness at your level.");
}

#[test]
fn death_helper_off_does_nothing() {
	let out = run(r#"
		set("deathHelper", false)
		QoL.SetData({ spiritHealers = { { 0, 20, 0, 9000, 50, 49 } }, flightMasters = {} })
		q.ghost = true
		stub.fire("PLAYER_ALIVE")
		stub.advance(3)
		emit(#q.nav.sets)
		emit(q.pins["qol.death"] == nil)
	"#);
	assert_eq!(out[0], 0);
	assert_eq!(out[1], true);
}

// ---------------------------------------------------------------------------
// Questing toggles
// ---------------------------------------------------------------------------

#[test]
fn instant_quest_text_sets_the_cvar_restores_the_player_value_when_turned_off_absent_cvar_left_alone() {
	let out = run_with(
		r#"
		emit(stub.cvars.instantQuestText)
		set("instantQuestText", false)
		emit(stub.cvars.instantQuestText)
		set("instantQuestText", true)
		emit(stub.cvars.instantQuestText)
	"#,
		r#"stub.cvars.instantQuestText = "0""#,
		None,
	);
	assert_eq!(json!(out), json!(["1", "0", "1"]));
	let absent = run("emit(stub.cvars.instantQuestText == nil)");
	assert_eq!(absent[0], true);
	let untouched = run_with("emit(stub.cvars.instantQuestText)", r#"stub.cvars.instantQuestText = "0""#, Some("PolestarDB = { schema = 1, settings = { qol = { instantQuestText = false } } }"));
	assert_eq!(untouched[0], "0", "off: the CVar is never touched");
}

#[test]
fn skip_gossip_picks_the_only_option_of_an_npc_without_quests_never_otherwise() {
	let out = run(r#"
		local ONE = { { gossipOptionID = 5, name = "I want to browse your goods.", icon = 132060, orderIndex = 0, status = 0 } }
		q.openGossip(9, { options = ONE })
		emit(calls("SelectOptionByIndex"))
		q.calls = {}
		q.openGossip(9, { options = { ONE[1], { gossipOptionID = 6, icon = 0, orderIndex = 1 } } })
		q.openGossip(9, { options = ONE, available = 1 })
		q.openGossip(9, { options = ONE, active = { { questID = 2, isComplete = false } } })
		q.openGossip(9, { options = ONE, force = true })
		q.openGossip(9, { options = { { gossipOptionID = 7, icon = 0, orderIndex = 0, selectOptionWhenOnlyOption = true } } })
		stub.keys.shift = true
		q.openGossip(9, { options = ONE })
		stub.keys.shift = false
		emit(#q.calls)
		set("skipGossip", false)
		q.openGossip(9, { options = ONE })
		emit(#q.calls)
	"#);
	assert_eq!(out[0], json!([0]));
	assert_eq!(out[1], 0);
	assert_eq!(out[2], 0);
}

#[test]
fn fast_loot_takes_every_slot_when_auto_loot_applies_off_or_manual_looting_does_nothing() {
	let out = run(r#"
		q.loot = 3
		stub.fire("LOOT_READY", true)
		emit(calls("LootSlot"))
		q.calls = {}
		stub.fire("LOOT_READY", true)        -- repeat for the same corpse
		stub.advance(1)
		stub.fire("LOOT_READY", false)       -- auto-loot not active
		emit(#q.calls)
		set("fastLoot", false)
		stub.advance(1)
		stub.fire("LOOT_READY", true)
		emit(#q.calls)
	"#);
	assert_eq!(out[0], json!([3, 2, 1]));
	assert_eq!(out[1], 0);
	assert_eq!(out[2], 0);
}

#[test]
fn hide_combat_errors_turns_the_spam_types_off_through_uierrorsframe_and_back_on_others_untouched() {
	let out = run(r#"
		local B = BLACK_LISTED_MESSAGE_TYPES
		local function state() return { rage = B[LE_GAME_ERR_OUT_OF_RAGE] or false, range = B[LE_GAME_ERR_OUT_OF_RANGE] or false,
			cd = B[LE_GAME_ERR_SPELL_COOLDOWN] or false, busy = B[LE_GAME_ERR_SPELL_FAILED_ANOTHER_IN_PROGRESS] or false,
			full = B[LE_GAME_ERR_INV_FULL] or false } end
		emit(state())
		set("hideErrors", true)
		emit(state())
		set("hideErrors", false)
		emit(state())
	"#);
	assert_eq!(out[0], json!({ "rage": false, "range": false, "cd": false, "busy": true, "full": false }), "off by default: nothing changed");
	assert_eq!(out[1], json!({ "rage": true, "range": true, "cd": true, "busy": true, "full": false }), "inventory full still shows");
	assert_eq!(out[2], json!({ "rage": false, "range": false, "cd": false, "busy": true, "full": false }), "Blizzard's own blacklist entry is kept");
}

// The game's objective tracker: Update shows it when it has contents, as Blizzard_ObjectiveTrackerContainer.lua
// does.
const TRACKER: &str = r#"
	local f = CreateFrame("Frame", "ObjectiveTrackerFrame", UIParent)
	f.updates, f.hasContents, f.protected = 0, true, false
	function f:Update() self.updates = self.updates + 1; if self.hasContents then self:Show() else self:Hide() end end
	function f:IsProtected() return self.protected end
"#;

#[test]
fn hide_quest_tracker_hides_the_game_s_tracker_and_keeps_it_hidden_off_hands_it_back_to_the_game() {
	let out = run_with(
		r#"
		local f = ObjectiveTrackerFrame
		emit({ shown = f:IsShown(), updates = f.updates })
		set("hideQuestTracker", true)
		emit(f:IsShown())
		f:Update()                            -- a quest update shows it again
		emit(f:IsShown())
		set("hideQuestTracker", false)
		emit({ shown = f:IsShown(), updates = f.updates })
		f.hasContents = false
		set("hideQuestTracker", true)
		set("hideQuestTracker", false)
		emit(f:IsShown())                     -- nothing to track: the game keeps it hidden
	"#,
		TRACKER,
		None,
	);
	assert_eq!(out[0], json!({ "shown": true, "updates": 0 }), "off by default: untouched");
	assert_eq!(out[1], false);
	assert_eq!(out[2], false, "hidden again when the game shows it");
	assert_eq!(out[3], json!({ "shown": true, "updates": 2 }), "off: the game's Update decides");
	assert_eq!(out[4], false);
}

#[test]
fn hide_quest_tracker_a_protected_tracker_waits_for_the_end_of_combat_the_gamepad_interface_keeps_it() {
	let out = run_with(
		r#"
		local f = ObjectiveTrackerFrame
		f.protected = true
		q.combat(true)
		set("hideQuestTracker", true)
		emit(f:IsShown())
		q.combat(false)
		emit(f:IsShown())
		set("hideQuestTracker", false)
		f.protected = false
		Polestar.GamepadUI = function() return true end
		set("hideQuestTracker", true)
		emit(f:IsShown())
	"#,
		TRACKER,
		None,
	);
	assert_eq!(json!(out), json!([true, false, true]));
}

#[test]
fn release_in_battlegrounds_only_in_a_battleground_never_with_a_self_res_an_offer_hardcore_or_shift() {
	let out = run(r#"
		local s = q.social
		local function die() q.calls = {}; stub.fire("PLAYER_DEAD"); return #calls("RepopMe") end
		s.battleground = true
		emit({ off = die(), watching = QoL.Watching("PLAYER_DEAD") })
		set("autoReleasePvP", true)
		local r = { bg = die() }
		s.battleground = false; r.world = die(); s.battleground = true
		s.selfRes = 1; r.soulstone = die(); s.selfRes = 0
		s.offerer = "Priest"; r.offer = die(); s.offerer = nil
		s.hardcore = true; r.hardcore = die(); s.hardcore = false
		stub.keys.shift = true; r.shift = die(); stub.keys.shift = false
		emit(r)
	"#);
	assert_eq!(out[0]["off"], 0);
	assert_eq!(out[1], json!({ "bg": 1, "world": 0, "soulstone": 0, "offer": 0, "hardcore": 0, "shift": 0 }));
}

// ---------------------------------------------------------------------------
// Requests from other players
// ---------------------------------------------------------------------------

#[test]
fn requests_no_event_is_registered_while_every_request_setting_is_off() {
	let out = run(r#"
		local EVENTS = { "CONFIRM_SUMMON", "RESURRECT_REQUEST", "PARTY_INVITE_REQUEST", "GUILD_INVITE_REQUEST", "DUEL_REQUESTED", "PLAYER_DEAD" }
		local function watching() local o = {}; for _, e in ipairs(EVENTS) do o[e] = QoL.Watching(e) end; return o end
		emit(watching())
		for _, k in ipairs({ "acceptSummon", "acceptResurrect", "declinePartyStrangers", "declineGuildInvites", "declineDuels", "autoReleasePvP" }) do set(k, true) end
		emit(watching())
		for _, k in ipairs({ "acceptSummon", "acceptResurrect", "declinePartyStrangers", "declineGuildInvites", "declineDuels", "autoReleasePvP" }) do set(k, false) end
		emit(watching())
	"#);
	let (off, on, again) = (&out[0], &out[1], &out[2]);
	for v in off.as_object().unwrap().values() {
		assert_eq!(*v, false);
	}
	for v in on.as_object().unwrap().values() {
		assert_eq!(*v, true);
	}
	assert_eq!(again, off);
}

#[test]
fn friends_friend_list_battle_net_character_and_guild_by_guid_or_name_realm_suffix_dropped() {
	let out = run(r#"
		local s = q.social
		s.friends["Player-1-A"] = true; s.friends["Ann"] = true
		s.bnet["Player-1-B"] = true
		s.guild["Player-1-C"] = true; s.guild["Cid"] = true
		local F = QoL.Social.IsFriend
		emit({ guid = F(nil, "Player-1-A"), bnet = F("x", "Player-1-B"), guildGuid = F(nil, "Player-1-C"), name = F("Ann"),
			realm = F("Ann-Stormrage"), guildName = F("Cid"), stranger = F("Rando", "Player-1-Z"), none = F(nil, nil) })
	"#);
	assert_eq!(out[0], json!({ "guid": true, "bnet": true, "guildGuid": true, "name": true, "realm": true, "guildName": true, "stranger": false, "none": false }));
}

#[test]
fn summons_accepted_out_of_combat_when_able_to_teleport_the_dialog_closes_shift_combat_and_off_ask() {
	let out = run(r#"
		local s = q.social
		local function summon() q.calls = {}; q.showPopup("CONFIRM_SUMMON"); stub.fire("CONFIRM_SUMMON", 0, false); stub.runTimers(); return #calls("ConfirmSummon") end
		emit(summon())
		set("acceptSummon", true)
		emit({ n = summon(), closed = #calls("StaticPopup_Hide"), msg = printed("Accepted a summon from Mage to Ironforge") })
		s.combat.player = true; local combat = summon(); s.combat.player = false
		s.canTeleport = false; local cannot = summon(); s.canTeleport = true
		stub.keys.shift = true; local shift = summon(); stub.keys.shift = false
		emit({ combat = combat, cannot = cannot, shift = shift })
	"#);
	assert_eq!(out[0], 0, "off by default");
	assert_eq!(out[1], json!({ "n": 1, "closed": 1, "msg": true }));
	assert_eq!(out[2], json!({ "combat": 0, "cannot": 0, "shift": 0 }));
	// The gamepad interface is read as the addon loads (Core/Init.lua).
	let pad = run_with(
		r#"
		q.calls = {}; set("acceptSummon", true)
		q.showPopup("CONFIRM_SUMMON"); stub.fire("CONFIRM_SUMMON", 0, false); stub.runTimers()
		emit({ n = #calls("ConfirmSummon"), closed = #calls("StaticPopup_Hide") })
	"#,
		"stub.qol.social.gamepad = true",
		None,
	);
	assert_eq!(pad[0], json!({ "n": 1, "closed": 0 }), "Gamepad style: accepted, and the dialog left alone");
}

#[test]
fn resurrections_accepted_after_the_corpse_delay_while_still_offered_never_from_a_caster_in_combat_or_in_hardcore() {
	let out = run(r#"
		local s = q.social
		local function offer(caster) q.calls = {}; s.offerer = caster; stub.fire("RESURRECT_REQUEST", caster); stub.runTimers(); return #calls("AcceptResurrect") end
		emit(offer("Priest"))
		set("acceptResurrect", true)
		local r = { now = offer("Priest"), msg = printed("Accepted a resurrection from Priest") }
		s.combat.Druid = true; r.combat = offer("Druid"); s.combat.Druid = nil
		s.hardcore = true; r.hardcore = offer("Priest"); s.hardcore = false
		stub.keys.shift = true; r.shift = offer("Priest"); stub.keys.shift = false
		s.corpseDelay = 5
		r.early = offer("Priest")
		s.corpseDelay = 0        -- the delay runs out
		stub.advance(6)
		r.late = #calls("AcceptResurrect")
		q.calls = {}
		s.corpseDelay = 5
		offer("Priest")
		s.offerer = nil          -- declined or timed out meanwhile
		s.corpseDelay = 0
		stub.advance(6)
		r.withdrawn = #calls("AcceptResurrect")
		emit(r)
	"#);
	assert_eq!(out[0], 0, "off by default");
	assert_eq!(out[1], json!({ "now": 1, "msg": true, "combat": 0, "hardcore": 0, "shift": 0, "early": 0, "late": 1, "withdrawn": 0 }));
}

// One offer from the Priest, waiting out a 5 s corpse delay; `between` runs
// during the wait, then the delay runs out (or `left` seconds remain).
const WAITED: &str = r#"
	local s = q.social
	set("acceptResurrect", true)
	local function waited(between, left)
		q.calls = {}
		s.corpseDelay = 5
		s.offerer = "Priest"; stub.fire("RESURRECT_REQUEST", "Priest")
		between()
		s.corpseDelay = left or 0
		stub.advance(6)
		s.offerer, s.combat.Druid = nil, nil
		return #calls("AcceptResurrect")
	end
"#;

#[test]
fn resurrections_an_old_callback_cannot_accept_another_caster_s_offer_in_combat_changed_without_an_event_or_replacing_it() {
	let out = run(&[
		WAITED,
		r#"
		emit({
			same = waited(function() end),
			combatOffer = waited(function() s.offerer = "Druid"; s.combat.Druid = true; stub.fire("RESURRECT_REQUEST", "Druid") end),
			changed = waited(function() s.offerer = "Druid" end),
			replaced = waited(function() s.offerer = "Druid"; stub.fire("RESURRECT_REQUEST", "Druid") end),
		})
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "same": 1, "combatOffer": 0, "changed": 0, "replaced": 1 }));
}

#[test]
fn resurrections_life_transitions_the_setting_off_and_on_or_a_corpse_delay_still_running_drop_the_waiting_offer() {
	let out = run(&[
		WAITED,
		r#"
		local function fire(e) return function() stub.fire(e) end end
		emit({
			alive = waited(fire("PLAYER_ALIVE")),
			unghost = waited(fire("PLAYER_UNGHOST")),
			dead = waited(fire("PLAYER_DEAD")),
			logout = waited(fire("PLAYER_LOGOUT")),
			offOn = waited(function() set("acceptResurrect", false); set("acceptResurrect", true) end),
			delayed = waited(function() end, 3),
		})
	"#,
	]
	.concat());
	assert_eq!(out[0], json!({ "alive": 0, "unghost": 0, "dead": 0, "logout": 0, "offOn": 0, "delayed": 0 }));
}

#[test]
fn party_invitations_friends_joined_dialog_marked_accepted_strangers_declined_when_asked_role_checks_queues_and_shift_ask() {
	let out = run(r#"
		local s = q.social
		s.friends["Player-1-F"] = true
		s.guild["Player-1-G"] = true
		local function invite(name, guid, tank)
			q.calls = {}; q.showPopup("PARTY_INVITE")
			stub.fire("PARTY_INVITE_REQUEST", name, tank or false, false, false, true, false, guid, false)
			stub.runTimers()
			local marked
			for _, c in ipairs(q.calls) do if c[1] == "StaticPopup_Hide" then marked = c[3] end end
			return { accept = #calls("AcceptGroup"), decline = #calls("DeclineGroup"), marked = marked }
		end
		emit(invite("Fay", "Player-1-F"))
		set("acceptPartyFriends", true)
		local r = { friend = invite("Fay", "Player-1-F"), guild = invite("Gus", "Player-1-G"), stranger = invite("Rando", "Player-1-Z") }
		r.role = invite("Fay", "Player-1-F", true)
		s.queued = true; r.queued = invite("Fay", "Player-1-F"); s.queued = false
		stub.keys.shift = true; r.shift = invite("Fay", "Player-1-F"); stub.keys.shift = false
		set("declinePartyStrangers", true)
		r.declined = invite("Rando", "Player-1-Z")
		r.friendStill = invite("Fay", "Player-1-F")
		emit(r)
	"#);
	assert_eq!(out[0], json!({ "accept": 0, "decline": 0 }), "off by default");
	let r = &out[1];
	assert_eq!(r["friend"], json!({ "accept": 1, "decline": 0, "marked": 1 }), "inviteAccepted set so its OnHide does not decline");
	assert_eq!(r["guild"], json!({ "accept": 1, "decline": 0, "marked": 1 }));
	assert_eq!(r["stranger"], json!({ "accept": 0, "decline": 0 }));
	assert_eq!(r["role"], json!({ "accept": 0, "decline": 0 }));
	assert_eq!(r["queued"], json!({ "accept": 0, "decline": 0 }));
	assert_eq!(r["shift"], json!({ "accept": 0, "decline": 0 }));
	assert_eq!(r["declined"], json!({ "accept": 0, "decline": 1, "marked": false }));
	assert_eq!(r["friendStill"], json!({ "accept": 1, "decline": 0, "marked": 1 }));
}

#[test]
fn guild_invitations_declined_except_from_friends_and_the_invite_window_closes() {
	let out = run(r#"
		local s = q.social
		s.friends["Fay"] = true
		local function invite(who) q.calls = {}; GuildInviteFrame:Show(); stub.fire("GUILD_INVITE_REQUEST", who, "Spam Guild", 0, nil, false); stub.runTimers(); return { n = #calls("DeclineGuild"), shown = GuildInviteFrame:IsShown() } end
		emit(invite("Rando"))
		set("declineGuildInvites", true)
		emit({ stranger = invite("Rando"), friend = invite("Fay"), msg = printed("Declined an invitation to Spam Guild") })
	"#);
	assert_eq!(out[0], json!({ "n": 0, "shown": true }), "off by default");
	assert_eq!(out[1], json!({ "stranger": { "n": 1, "shown": false }, "friend": { "n": 0, "shown": true }, "msg": true }));
}

#[test]
fn duels_declined_only_when_the_setting_is_on_never_from_friends_or_guild() {
	let out = run(r#"
		q.social.guild["Gus"] = true
		stub.fire("DUEL_REQUESTED", "Rando")
		emit(#calls("CancelDuel"))
		set("declineDuels", true)
		stub.fire("DUEL_REQUESTED", "Rando")
		emit({ #calls("CancelDuel"), printed("Declined a duel from Rando") })
		stub.fire("DUEL_REQUESTED", "Gus")
		emit(#calls("CancelDuel"))
	"#);
	assert_eq!(out[0], 0);
	assert_eq!(out[1], json!([1, true]));
	assert_eq!(out[2], 1, "a guild member may duel");
}

// ---------------------------------------------------------------------------
// EllesmereUI
// ---------------------------------------------------------------------------

const COVERED_KEYS: [&str; 7] = ["sellJunk", "autoRepair", "repairGuild", "fastLoot", "skipGossip", "hideErrors", "acceptPartyFriends"];

fn covered_defaults(before: &str, saved: Option<&str>) -> Value {
	let keys = COVERED_KEYS.iter().map(|k| format!("\"{k}\"")).collect::<Vec<_>>().join(", ");
	let script = r#"
		local o = {}
		for _, k in ipairs({ __KEYS__ }) do o[k] = QoL.On(k) end
		o.instantQuestText = QoL.On("instantQuestText")
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			for _, c in ipairs(spec.controls) do if c.key == "qol.sellJunk" then o.help = c.help end end
		end
		emit(o)
	"#
	.replace("__KEYS__", &keys);
	run_with(&script, before, saved).remove(0)
}

#[test]
fn ellesmereui_overlapping_toggles_start_off_while_its_module_is_installed_and_enabled_your_own_choice_wins() {
	let none = covered_defaults("", None);
	assert_eq!(
		json!([none["sellJunk"].clone(), none["autoRepair"].clone(), none["fastLoot"].clone(), none["skipGossip"].clone(), none["instantQuestText"].clone()]),
		json!([true, true, true, true, true])
	);
	assert!(!is_match(text(&none["help"]), r"EllesmereUI"));

	let loaded = covered_defaults("stub.addonsLoaded.EllesmereUI = true; stub.addonsLoaded.EllesmereUIQoL = true", None);
	for k in COVERED_KEYS {
		assert_eq!(loaded[k], false, "{k} off with EllesmereUI QoL");
	}
	assert_eq!(loaded["instantQuestText"], true, "what EllesmereUI does not do stays on");
	assert!(is_match(text(&loaded["help"]), r"Off by default: EllesmereUI QoL does this too\."));

	let later = covered_defaults("stub.qol.installed.EllesmereUIQoL = true", None);
	assert_eq!(later["sellJunk"], false, "enabled but loading after Polestar counts");
	let disabled = covered_defaults("stub.qol.installed.EllesmereUIQoL = false", None);
	assert_eq!(disabled["sellJunk"], true, "installed but disabled does not");

	let mine = covered_defaults("stub.addonsLoaded.EllesmereUIQoL = true", Some("PolestarDB = { schema = 1, settings = { qol = { sellJunk = true } } }"));
	assert_eq!(mine["sellJunk"], true);
}

#[test]
fn merchant_guild_bank_first_when_allowed_no_affordability_gate_as_blizzard_s_button_else_your_own_money() {
	let out = run(r#"
		local function visit() q.calls = {}; q.openMerchant(); stub.advance(1); local c = calls("RepairAllItems"); q.closeMerchant(); return c[1] or "none" end
		q.money = 0
		q.repair = { can = true, cost = 500, guild = true }
		local r = { off = visit() }
		set("repairGuild", true)
		q.repair.cost = 500
		r.guild = visit()
		r.msg = printed("Repaired for 5s 0c, guild bank first")
		q.repair = { can = true, cost = 500, guild = false }
		q.money = 1000
		r.rank = visit()
		emit(r)
	"#);
	assert_eq!(out[0], json!({ "off": "none", "guild": "guild", "msg": true, "rank": "own" }));
}

// ---------------------------------------------------------------------------
// The whole addon
// ---------------------------------------------------------------------------

#[test]
fn full_addon_qol_loads_with_every_module_and_creates_its_buttons_at_login() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: r#"
			local st = Polestar.QoL.GetXPStats()
			emit({ qol = Polestar.QoL ~= nil, item = PolestarQuestItemButton ~= nil, target = PolestarTargetButton ~= nil,
				hearth = PolestarHearthButton ~= nil, xp = st ~= nil and st.level ~= nil, healers = #Polestar.QoL.data.spiritHealers })
		"#
		.into(),
		..Default::default()
	});
	let r = &out[0];
	assert_eq!(*r, json!({ "qol": true, "item": true, "target": true, "hearth": true, "xp": true, "healers": r["healers"].clone() }));
	assert!(r["healers"].as_f64().unwrap() > 50.0, "generated Spirit Healer data loaded");
}
