//! Class macros (addon/Polestar/Macros): the data of every class (specs, origins, keys, one class kept), the
//! filters and counts, the text in the client's names (spells, items, the rank word, English while a name is not
//! cached), writing a macro (character or account, a free name, never in combat, with no free slot or over 255
//! characters), whether one made is current, changed since, edited by hand or deleted, Update, and the hub section
//! (the specs in the sidebar with the player's picked, PvE and PvP tabs, the origin filter, a card's Create). The
//! macro client is tests/lua/stub_macros.lua.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const CORE: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "Macros/Macros.xml"];
const WITH_UI: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml", "Macros/Macros.xml"];

/// A level 30 Warrior who knows Charge, not Intercept; English spell names for what the tests read.
const WORLD: &str = r#"
local w = stub.world
w.class, w.className, w.classID, w.level = "WARRIOR", "Warrior", 1, 30
w.spells[100] = true
w.spells[2457] = true
w.itemInfo[5631] = { name = "Rage Potion" }
"#;

const PRELUDE: &str = r#"
local M, MS = Polestar.Macros, stub.macros
for id, name in pairs({ [100] = "Charge", [20252] = "Intercept", [2457] = "Battle Stance", [2458] = "Berserker Stance",
	[2687] = "Bloodrage", [5308] = "Execute" }) do MS.spellNames[id] = name end
local function byId(id) for _, m in ipairs(M.Data().macros) do if m.id == id then return m end end end
"#;

fn run_in(script: &str, files: &[&str], ui: bool, before: &str) -> Vec<Value> {
	let mut stubs = vec!["stub_world.lua", "stub_macros.lua"];
	if ui {
		stubs.push("stub_ui.lua");
	}
	emitted(&RunAddon { stubs, before: [WORLD, before].concat(), addons: vec![Addon::files("Polestar", files)], login: true, script: [PRELUDE, script].concat(), ..Default::default() })
}

fn run(script: &str) -> Value {
	run_in(script, CORE, false, "").remove(0)
}

fn run_ui(script: &str) -> Value {
	run_in(script, WITH_UI, true, "").remove(0)
}

// ------------------------------------------------------------ the data

#[test]
fn every_class_has_its_macros_three_specs_and_known_origins_and_keeps_only_its_own() {
	for class in ["WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID"] {
		let before = format!("stub.world.class = {class:?}");
		let out = run_in(
			r#"
local d = M.Data()
local o = { class = d.class, specs = #d.specs, n = #d.macros, bad = {}, ids = {} }
local seen = {}
for _, m in ipairs(d.macros) do
	if seen[m.id] then o.bad[#o.bad + 1] = "twice: " .. m.id end
	seen[m.id] = true
	if m.spec and not d.specByKey[m.spec] then o.bad[#o.bad + 1] = "spec: " .. m.id end
	if m.origin ~= "classic" and m.origin ~= "adapted" and m.origin ~= "forever" then o.bad[#o.bad + 1] = "origin: " .. m.id end
	if type(m.title) ~= "string" or m.title == "" or type(m.use) ~= "string" or m.use == "" then o.bad[#o.bad + 1] = "text: " .. m.id end
	for _, k in ipairs(m.keys or {}) do
		if k[1] ~= false and k[1] ~= "Shift" and k[1] ~= "Ctrl" and k[1] ~= "Alt" then o.bad[#o.bad + 1] = "key: " .. m.id .. " " .. tostring(k[1]) end
	end
	for kind, id in m.code:gmatch("{([si])(%d+)}") do
		if not M.NAMES[kind .. id] then o.bad[#o.bad + 1] = "name: " .. kind .. id end
	end
end
o.bad = table.concat(o.bad, "; ")
emit(o)"#,
			CORE,
			false,
			&before,
		)
		.remove(0);
		assert_eq!(out["class"], class);
		assert_eq!(out["specs"], 3, "{class}");
		assert!(out["n"].as_u64().unwrap() > 50, "{class}: {}", out["n"]);
		assert_eq!(out["bad"], "", "{class}");
	}
}

#[test]
fn list_filters_by_side_spec_and_origin_and_counts_follow_the_side() {
	let out = run(r#"
local n = function(f) return #M.List(f) end
local c = M.Counts(false)
emit({ all = n(), pve = n({ pvp = false }), pvp = n({ pvp = true }), class = n({ pvp = false, spec = "class" }),
	fury = n({ pvp = false, spec = "fury" }), new = n({ origin = "forever" }), counts = c, pvpFury = M.Counts(true).fury })"#);
	assert_eq!(out["all"], 73);
	assert_eq!(json!([out["pve"], out["pvp"]]), json!([36, 37]));
	assert_eq!(json!([out["class"], out["fury"]]), json!([9, 8]));
	assert_eq!(out["counts"], json!({ "pve": 36, "pvp": 37, "class": 9, "arms": 9, "fury": 8, "protection": 10 }));
	assert_eq!(out["pvpFury"], 6);
	assert!(out["new"].as_u64().unwrap() > 0);
}

// ------------------------------------------------------------ the text

#[test]
fn the_text_takes_the_clients_names_and_english_for_a_name_not_cached_yet() {
	let out = run(r#"
local body = M.Body(byId("class-wide-charge-or-intercept"))
MS.spellNames[100] = "Charge (client)"
local renamed = M.Body(byId("class-wide-charge"))
local potion = M.Body(byId("class-wide-bloodrage-rage-potion"))
stub.world.itemInfo[5631] = nil
local english, missing = M.Body(byId("class-wide-bloodrage-rage-potion"))
emit({ body = body, renamed = renamed, potion = potion, english = english, missing = missing,
	asked = stub.world.itemRequests[#stub.world.itemRequests] })"#);
	assert_eq!(
		out["body"],
		"#show [combat] Intercept; Charge\n/startattack\n/cast [nocombat,stance:1] Charge; [combat,stance:3] Intercept; [nocombat,nostance:1] Battle Stance; [combat,nostance:3] Berserker Stance"
	);
	assert_eq!(out["renamed"], "#showtooltip Charge (client)\n/dismount\n/startattack\n/cast Charge (client)");
	assert_eq!(out["potion"], "#showtooltip Bloodrage\n/cast Bloodrage\n/use Rage Potion");
	assert_eq!(out["english"], out["potion"], "the English name stands in");
	assert_eq!(out["missing"], json!(["Rage Potion"]));
	assert_eq!(out["asked"], 5631, "the item is asked for");
}

#[test]
fn a_spell_not_learned_is_named_and_the_highlight_colours_spells_and_items() {
	let out = run(r#"
local known, missing = M.Known(byId("class-wide-charge-or-intercept"))
local hl = M.Highlight(byId("class-wide-bloodrage-rage-potion"), "ff00ffff", "ffff00ff")
emit({ known = known, missing = missing, charge = M.Known(byId("class-wide-charge")), hl = hl })"#);
	assert_eq!(out["known"], false);
	assert_eq!(out["missing"], 20252, "Intercept");
	assert_eq!(out["charge"], true);
	assert_eq!(out["hl"], "#showtooltip |cff00ffffBloodrage|r\n/cast |cff00ffffBloodrage|r\n/use |cffff00ffRage Potion|r");
}

// ------------------------------------------------------------ writing

#[test]
fn create_writes_the_macro_with_a_free_ps_name_in_the_character_or_account_list() {
	let out = run(r#"
MS.add("PS Charge and st", "/say mine", false)
local m = byId("class-wide-charge")
local ok = M.Create(m, true)
local rec = M.Made()[m.id]
local game = MS.byName(rec.name)
local ok2 = M.Create(byId("class-wide-execute"), false)
local acc, accMax, char, charMax = M.Slots()
emit({ ok = ok, name = rec.name, perChar = game.perChar, body = game.body, status = M.Status(m), ok2 = ok2,
	slots = { acc, accMax, char, charMax }, saved = PolestarCharDB.macros.made[m.id].body == game.body })"#);
	assert_eq!(out["ok"], true);
	assert_eq!(out["name"], "PS Charge and 2", "16 characters at most, numbered past the player's own");
	assert_eq!(out["perChar"], true);
	assert_eq!(out["body"], "#showtooltip Charge\n/dismount\n/startattack\n/cast Charge");
	assert_eq!(out["status"], "ok");
	assert_eq!(out["ok2"], true);
	assert_eq!(out["slots"], json!([2, 120, 1, 18]));
	assert_eq!(out["saved"], true);
}

#[test]
fn nothing_is_written_in_combat_without_a_free_slot_or_over_255_characters() {
	let out = run(r#"
local m = byId("class-wide-charge")
stub.inCombat = true
local a = { M.Create(m, true) }
stub.inCombat = false
MS.charMax = 0
MAX_CHARACTER_MACROS = 0
local b = { M.Create(m, true) }
MS.spellNames[100] = string.rep("x", 200)
local c = { M.Create(m, false) }
MS.refuse = true
MS.spellNames[100] = "Charge"
local d = { M.Create(m, false) }
emit({ a = a, b = b, c = c, d = d, n = #MS.list })"#);
	assert_eq!(out["a"], json!([false, "combat"]));
	assert_eq!(out["b"], json!([false, "full"]));
	assert_eq!(out["c"], json!([false, "long"]));
	assert_eq!(out["d"], json!([false, "failed"]));
	assert_eq!(out["n"], 0);
}

#[test]
fn a_macro_made_is_current_changed_since_edited_by_hand_or_deleted_and_update_brings_it_back() {
	let out = run(r#"
local m = byId("class-wide-charge")
local s = { M.Status(m) }
M.Create(m, true)
local rec = M.Made()[m.id]
MS.spellNames[100] = "Charge!"
s[#s + 1] = M.Status(m)
local upd = M.Update(m)
s[#s + 1] = M.Status(m)
MS.byName(rec.name).body = "/say my own"
s[#s + 1] = M.Status(m)
for i, g in ipairs(MS.list) do if g.name == rec.name then table.remove(MS.list, i) end end
s[#s + 1] = M.Status(m)
local again = M.Update(m)
s[#s + 1] = M.Status(m)
emit({ s = s, upd = upd, again = again, body = MS.byName(rec.name).body })"#);
	assert_eq!(out["s"], json!(["new", "outdated", "ok", "edited", "deleted", "ok"]));
	assert_eq!(out["upd"], true);
	assert_eq!(out["again"], true, "a deleted macro is made again");
	assert_eq!(out["body"], "#showtooltip Charge!\n/dismount\n/startattack\n/cast Charge!");
}

#[test]
fn macros_updated_fires_when_the_games_macros_change_and_when_combat_starts_or_ends() {
	let out = run(r#"
local n = 0
Polestar.On("MACROS_UPDATED", function() n = n + 1 end)
stub.fire("UPDATE_MACROS")
stub.fire("PLAYER_REGEN_DISABLED")
stub.fire("PLAYER_REGEN_ENABLED")
emit(n)"#);
	assert_eq!(out, 3);
}

// ------------------------------------------------------------ the hub section

#[test]
fn the_section_specs_in_the_sidebar_the_players_picked_pve_and_pvp_tabs_one_card_per_macro() {
	let out = run_ui(
		r#"
Polestar.Gear = { GetSpec = function() return "fury" end }
Polestar.Fire("SHOW_MACROS")
local win = PolestarPicker
local function keys(list) local o = {} for _, b in ipairs(list) do if b:IsShown() then o[#o + 1] = b.psKey end end return o end
local V = Polestar.UI.MacrosSection
local first = V.Shown()
local o = { tabs = keys(win.tabButtons), nav = keys(win.navButtons), spec = first.spec, rows = first.rows, title = win.Title:GetText() }
V.OnNav("class")
o.classRows = V.Shown().rows
V.SetTab("pvp")
o.pvpRows = V.Shown().rows
V.SetOrigin("forever")
o.newRows = V.Shown().rows
o.saved = { Polestar.Get("macros.tab"), Polestar.Get("macros.origin"), PolestarCharDB.macros.spec }
emit(o)"#,
	);
	assert_eq!(out["tabs"], json!(["pve", "pvp"]));
	assert_eq!(out["nav"], json!(["class", "arms", "fury", "protection"]));
	assert_eq!(out["spec"], "fury", "Gear's spec is picked the first time");
	assert_eq!(out["rows"], 8);
	assert_eq!(out["title"], "Warrior macros");
	assert_eq!(out["classRows"], 9);
	assert_eq!(out["pvpRows"], 15);
	assert!(out["newRows"].as_u64().unwrap() < 15);
	assert_eq!(out["saved"], json!(["pvp", "forever", "class"]));
}

#[test]
fn a_cards_create_puts_the_macro_on_the_list_and_the_card_says_so() {
	let out = run_ui(
		r#"
Polestar.Fire("SHOW_MACROS")
local V = Polestar.UI.MacrosSection
V.OnNav("class")
local c
for _, card in ipairs(V.cards) do if card:IsShown() and card.psMacro.id == "class-wide-charge" then c = card end end
local before = c.Action:GetText() or c.Action.Label:GetText()
local intercept = nil
for _, card in ipairs(V.cards) do if card:IsShown() and card.psMacro.id == "class-wide-charge-or-intercept" then intercept = card.State:GetText() end end
c.Action:Click()
local after
for _, card in ipairs(V.cards) do if card:IsShown() and card.psMacro.id == "class-wide-charge" then after = { card.Done:IsShown(), card.Action:IsShown(), card.Meta:GetText() } end end
V.SetWhere("account")
emit({ before = before, intercept = intercept, after = after, n = #MS.list, perChar = MS.list[1].perChar, where = V.Shown().where })"#,
	);
	assert_eq!(out["before"], "Create");
	assert_eq!(out["intercept"], "Intercept at level 30");
	assert_eq!(out["after"], json!([true, false, "Adapted for Forever  ·  Saved as “PS Charge and st” in your macros"]));
	assert_eq!(out["n"], 1);
	assert_eq!(out["perChar"], true, "the character's list by default");
	assert_eq!(out["where"], "account");
}

#[test]
fn turned_off_nothing_is_written_and_the_section_says_where_to_turn_it_on() {
	let out = run_ui(
		r#"
Polestar.Set("macros.enabled", false)
local ok, why = M.Create(byId("class-wide-charge"), true)
Polestar.Fire("SHOW_MACROS")
local V = Polestar.UI.MacrosSection
emit({ ok = ok, why = why, rows = V.Shown().rows, off = V.Shown().off, n = #MS.list })"#,
	);
	assert_eq!(out, json!({ "ok": false, "why": "off", "rows": 0, "off": true, "n": 0 }));
}

#[test]
fn every_card_labels_its_rows_and_the_players_spec_is_marked_in_the_sidebar() {
	let out = run_ui(
		r#"
Polestar.Gear = { GetSpec = function() return "protection" end }
Polestar.Fire("SHOW_MACROS")
local V = Polestar.UI.MacrosSection
V.OnNav("class")
local labels = {}
for i, c in ipairs(V.cards) do
	if c:IsShown() then labels[i] = { c.DoesLabel:GetText(), c.MacroLabel:GetText(), c.NeedsLabel:IsShown() and c.NeedsLabel:GetText() or false } end
end
local nav = {}
for _, item in ipairs((V.Nav())) do nav[#nav + 1] = { item.label, item.icon or false } end
emit({ first = labels[1], second = labels[2], nav = nav })"#,
	);
	assert_eq!(out["first"], json!(["Does", "Macro", "Needs"]), "the label column is measured without writing a label");
	assert_eq!(out["second"], json!(["Does", "Macro", "Needs"]));
	assert_eq!(out["nav"][0], json!(["Whole class", false]));
	assert_eq!(out["nav"][3][1], "icon-learn");
	assert!(out["nav"][3][0].as_str().unwrap().ends_with("Protection|r"), "the player's spec in the accent: {}", out["nav"][3][0]);
	assert_eq!(out["nav"][1], json!(["Arms", false]));
}
