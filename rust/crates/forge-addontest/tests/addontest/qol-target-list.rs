//! The target button's list (addon/Polestar/QoL/Buttons.lua): a row beside the button for each name, with the
//! creature's portrait and the item it drops for the step; a click on a row targets that name, the button itself
//! keeps the list's order, and Options > Questing > Buttons > Simple target button brings back the single button
//! that cycles. Runs the real Core/Init.lua + Compat + Theme + QoL against tests/lua/stub_qol.lua (secure frames
//! refuse changes in combat).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 4] = ["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "QoL/QoL.xml"];

// A step with a kill goal and a collect goal whose item three creatures drop,
// two of them only known to the QuestDB, with their drop chances.
const PRELUDE: &str = r#"
local q = stub.qol
local B = Polestar.QoL.Buttons
local t = PolestarTargetButton
local function set(k, v) Polestar.Set("qol." .. k, v); stub.runTimers() end
local function rows()
	local out = {}
	for i, r in ipairs(B.rows) do
		if r:IsShown() then
			out[#out + 1] = { r.Name:GetText(), r.Note:GetText(), r:GetAttribute("macrotext"), r.npc or false }
		end
	end
	return out
end
local function macro() return t:GetAttribute("macrotext") end
-- A row's face (a portrait, the model's creature id, or false) and the
-- crosshair behind it: green while a living one is close, else red.
local function face(i)
	local r = B.rows[i]
	local g, c = { Polestar.Theme.Color("success") }, { r.Mark:GetVertexColor() }
	local green = c[1] == g[1] and c[2] == g[2] and c[3] == g[3]
	-- The row's green wash shows with the green crosshair, never without.
	assert(r.Near:IsShown() == green, "row wash and crosshair disagree")
	return { tostring(r.Face:GetTexture()):match("portrait:.*") or (r.Model:IsShown() and r.Model.creature) or false,
		green and "green" or "red" }
end
local function faces() return { face(1), face(2), face(3) } end
Polestar.QuestDB = {
	IsLoaded = function() return true end,
	GetObjectiveMobs = function(quest, oi)
		if quest == 7 and oi == 2 then
			return { "Kobold Laborer", "Kobold Vermin" }, { { id = 80, chance = 32.4 }, { id = 6, chance = 4.26 } }
		end
	end,
}
local function kobolds()
	q.step({
		{ t = "kill", target = "Kobold Vermin", npc = 6, quest = 7, oi = 1 },
		{ t = "collect", item = 950, itemName = "Candle", quest = 7, oi = 2,
			fromNpcs = { { npc = 257, npcName = "Kobold Worker" } } },
	})
end
"#;

fn run_with(script: &str, before: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_qol.lua"], addons: vec![Addon::files("Polestar", &FILES)], before: before.into(), saved: vec![], login: true, script: format!("{PRELUDE}{script}") })
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, "")
}

const VERMIN: &str = "/cleartarget [nocombat]\n/targetexact Kobold Vermin\n/cleartarget [dead]";
const WORKER: &str = "/cleartarget [nocombat]\n/targetexact Kobold Worker\n/cleartarget [dead]";
const LABORER: &str = "/cleartarget [nocombat]\n/targetexact Kobold Laborer\n/cleartarget [dead]";

#[test]
fn target_list_a_row_per_name_with_its_id_and_drop_and_its_own_macro() {
	let out = run(r#"
		kobolds()
		emit(rows())
		emit({ macro(), t.Label:GetText(), t:IsShown(), B.anchor:IsShown() })
	"#);
	assert_eq!(
		out[0],
		json!([["Kobold Vermin", "Candle", VERMIN, 6], ["Kobold Worker", "Candle", WORKER, 257], ["Kobold Laborer", "Candle", LABORER, 80],]),
		"one row per name in the button's order; the kill target first (it drops the Candle too), then the collect's sources and droppers"
	);
	let m = out[1][0].as_str().unwrap();
	assert!(m.starts_with(VERMIN), "the button tries the list from its first name: {m}");
	assert_eq!(out[1][1], "", "no name beside the button: the rows show them");
	assert_eq!(out[1][2], false, "the small Polestar mark takes the button's place; its binding still targets");
	assert_eq!(out[1][3], true);
}

#[test]
fn target_list_drop_chances_only_in_a_row_s_tooltip_whole_from_ten_percent_else_to_a_tenth() {
	let out = run(r#"
		q.step({
			{ t = "collect", item = 950, itemName = "Candle", quest = 7, oi = 2 },
		})
		emit(rows())
		for i = 1, 2 do
			local r = B.rows[i]
			r:GetScript("OnEnter")(r)
			emit(GameTooltip.lines[2])
			r:GetScript("OnLeave")(r)
		end
	"#);
	assert_eq!(out[0], json!([["Kobold Laborer", "Candle", LABORER, 80], ["Kobold Vermin", "Candle", VERMIN, 6],]), "no chance on the rows");
	assert_eq!(out[1], "Candle · 32%");
	assert_eq!(out[2], "Candle · 4.3%");
}

#[test]
fn target_list_the_button_keeps_its_order_on_every_click() {
	let out = run(r#"
		kobolds()
		local before = macro()
		q.click(t, true)
		q.click(t, false)
		q.click(t, false)
		emit({ macro() == before, t.Label:GetText() })
		emit(rows()[1][1])
	"#);
	assert_eq!(out[0], json!([true, ""]), "no cycling in the list");
	assert_eq!(out[1], "Kobold Vermin");
}

#[test]
fn target_list_a_row_click_with_a_new_mark_each_press_moves_the_mark_on_every_macro() {
	let out = run(r#"
		set("markTarget", true)
		set("markMob", "cycle")
		kobolds()
		local r = B.rows[2]
		emit({ r:GetAttribute("macrotext"):match("~%d$"), macro():match("~%d$") })
		q.click(r, true)
		emit(r:GetAttribute("macrotext"):match("~%d$"))
		q.click(r, false)
		emit({ r:GetAttribute("macrotext"):match("~%d$"), macro():match("~%d$"), B.rows[1]:GetAttribute("macrotext"):match("~%d$") })
	"#);
	assert_eq!(out[0], json!(["~2", "~2"]), "the NPC icon (1) is skipped");
	assert_eq!(out[1], "~2", "a key down does nothing");
	assert_eq!(out[2], json!(["~3", "~3", "~3"]), "the release moves the shared mark");
}

#[test]
fn target_list_simple_target_button_brings_back_the_single_button_that_cycles() {
	let out = run(r#"
		kobolds()
		set("targetSimple", true)
		emit({ #rows(), t.Label:GetText(), macro():match("^[^\n]+\n([^\n]+)") })
		q.click(t, false)
		emit({ t.Label:GetText(), macro():match("^[^\n]+\n([^\n]+)") })
		set("targetSimple", false)
		emit({ #rows(), t.Label:GetText(), macro():match("^[^\n]+\n([^\n]+)") })
	"#);
	assert_eq!(out[0], json!([0, "Kobold Vermin", "/targetexact Kobold Vermin"]));
	assert_eq!(out[1], json!(["Kobold Worker", "/targetexact Kobold Worker"]), "each click moves to the next name");
	assert_eq!(out[2], json!([3, "", "/targetexact Kobold Vermin"]), "back to the list, from its first name");
}

#[test]
fn target_list_rows_follow_the_step_and_wait_for_the_end_of_a_fight() {
	let out = run(r#"
		kobolds()
		q.combat(true)
		q.step({ { t = "kill", target = "Defias Thug", npc = 38 } })
		emit(#rows())
		q.combat(false)
		emit(rows())
		q.step({ { t = "goto", map = 9000, x = 1, y = 1 } })
		emit({ #rows(), t:IsShown() })
	"#);
	assert_eq!(out[0], 3, "no secure change in combat");
	assert_eq!(out[1], json!([["Defias Thug", "", "/cleartarget [nocombat]\n/targetexact Defias Thug\n/cleartarget [dead]", 38]]));
	assert_eq!(out[2], json!([0, false]));
}

#[test]
fn target_list_rows_sit_beside_the_button_on_its_name_side_and_push_the_rare_button_down() {
	let out = run(r#"
		local rare = PolestarRareButton
		local function y(f) return select(5, f:GetPoint(1)) end
		emit(y(rare))
		kobolds()
		local p, rel, rp, x, yy = B.rows[1]:GetPoint(1)
		emit({ p, rel == t, rp, x, yy })
		emit({ select(1, B.rows[2]:GetPoint(1)), B.rows[2]:GetPoint(1) and select(2, B.rows[2]:GetPoint(1)) == B.rows[1] })
		emit(y(rare))
		set("buttonTextSide", "left")
		p, rel, rp, x = B.rows[1]:GetPoint(1)
		emit({ p, rp, x })
		q.step({ { t = "goto", map = 9000, x = 1, y = 1 } })
		emit(y(rare))
	"#);
	assert_eq!(out[0], json!(-88), "slot -2 without rows");
	assert_eq!(out[1], json!(["TOPLEFT", true, "TOPRIGHT", 8, 0]));
	assert_eq!(out[2], json!(["TOP", true]));
	// Three rows of 30 with 2 between end 94 under the target button's top:
	// the rare button goes two slots further down, its top below the rows.
	assert_eq!(out[3], json!(-176));
	assert_eq!(out[4], json!(["TOPRIGHT", "TOPLEFT", -8]));
	assert_eq!(out[5], json!(-88), "back in its slot once the rows go");
}

#[test]
fn target_list_rows_hide_with_the_target_button_setting() {
	let out = run(r#"
		kobolds()
		set("targetButton", false)
		emit({ #rows(), t:IsShown() })
	"#);
	assert_eq!(out[0], json!([0, false]));
}

#[test]
fn target_list_item_names_in_the_client_s_language_else_the_guide_s() {
	let out = run(r#"
		Polestar.Names = {
			Npc = function() return nil end,
			Item = function(id) if id == 950 then return "Kerze" end end,
		}
		kobolds()
		emit(rows()[2][2])
		q.step({ { t = "collect", item = 951, itemName = "Wax", fromNpcs = { { npc = 257, npcName = "Kobold Worker" } } } })
		emit(rows()[1][2])
	"#);
	assert_eq!(out[0], "Kerze");
	assert_eq!(out[1], "Wax", "the guide's own name while the client has none");
}

#[test]
fn target_list_the_set_s_screen_clamp_covers_the_rows_on_their_side_and_the_lowered_rare_button() {
	let out = run_with(
		r#"
		local holder = select(2, PolestarRareButton:GetPoint(1))
		emit(holder.clamp)
		local goals = {}
		for i, n in ipairs({ "Wolf", "Boar", "Bear", "Crab", "Hawk" }) do goals[i] = { t = "kill", target = n, npc = 100 + i } end
		q.step(goals)
		emit({ #rows(), holder.clamp })
		set("buttonTextSide", "left")
		emit(holder.clamp)
		emit(select(5, PolestarRareButton:GetPoint(1)))
	"#,
		r#"stub.Methods.SetClampRectInsets = function(self, ...) self.clamp = { ... } end"#,
	);
	assert_eq!(out[0], json!([0, 0, 44, -88]), "no rows: the hearth slot above, the rare slot below (the bag button has its own spot)");
	// Five rows of 30 with 2 between end 158 under the target button's top:
	// the rare button goes three slots further down (slot -5), and the clamp
	// reaches it; sideways it covers the 180-wide rows and their 8 gap.
	assert_eq!(out[1], json!([5, [0, 188, 44, -220]]));
	assert_eq!(out[2], json!([-188, 0, 44, -220]));
	assert_eq!(out[3], json!(-220));
}

const MODELS: &str = r#"stub.Methods.SetCreature = function(self, id) self.creature = id end"#;

#[test]
fn target_list_faces_are_models_by_id_over_a_crosshair_that_turns_green_while_one_is_close() {
	let out = run_with(
		r#"
		kobolds()
		emit(faces())
		-- Kobold Worker comes close (a nameplate); a dead Kobold Vermin is the target.
		q.units.nameplate3 = { name = "Kobold Worker" }
		q.target = { name = "Kobold Vermin", dead = true }
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate3")
		stub.runTimers()
		emit(faces())
		-- The Vermin comes back to life as the target; the Worker's plate goes.
		q.target = { name = "Kobold Vermin" }
		q.units.nameplate3 = nil
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.runTimers()
		emit(faces())
		-- It dies while targeted: only its health says so.
		q.target.dead = true
		stub.fire("UNIT_HEALTH", "target")
		stub.runTimers()
		emit(face(1))
		-- A player is no mob.
		q.target = { name = "Kobold Laborer", player = true }
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.runTimers()
		emit(face(3))
	"#,
		MODELS,
	);
	assert_eq!(out[0], json!([[6, "red"], [257, "red"], [80, "red"]]), "models by id, none close");
	assert_eq!(out[1], json!([[6, "red"], [257, "green"], [80, "red"]]), "a dead target is passed over");
	assert_eq!(out[2], json!([[6, "green"], [257, "red"], [80, "red"]]));
	assert_eq!(out[3], json!([6, "red"]));
	assert_eq!(out[4], json!([80, "red"]));
}

#[test]
fn target_list_a_row_turning_green_flashes_once_and_keeps_a_thick_green_edge() {
	let out = run_with(
		r#"
		local r -- made with the list
		local g = { Polestar.Theme.Color("success") }
		local function look()
			local e = r.psBorder and r.psBorder[1]
			local c = e and { e:GetVertexColor() } or {}
			return { r.Flash.Pulse.plays or 0, c[1] == g[1] and c[2] == g[2] and c[3] == g[3] and c[4] == 1,
				r.psBorderSize or 0, r.Flash:IsShown() }
		end
		local function worker(close)
			q.units.nameplate3 = close and { name = "Kobold Worker" } or nil
			stub.fire(close and "NAME_PLATE_UNIT_ADDED" or "NAME_PLATE_UNIT_REMOVED", "nameplate3")
			stub.runTimers()
		end
		kobolds()
		r = B.rows[2]
		emit(look())
		worker(true)
		emit(look())
		-- Still close: no second flash.
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.runTimers()
		emit(look())
		worker(false)
		emit(look())
		-- Reduced motion: green edge, no flash.
		Polestar.Set("ui.reduceMotion", true)
		worker(true)
		emit(look())
	"#,
		MODELS,
	);
	assert_eq!(out[0], json!([0, false, 1, false]), "none close: the plain edge");
	assert_eq!(out[1], json!([1, true, 2, false]), "turning green flashes once, then the flash hides");
	assert_eq!(out[2], json!([1, true, 2, false]));
	assert_eq!(out[3], json!([1, false, 1, false]), "back to the plain edge");
	assert_eq!(out[4], json!([1, true, 2, false]), "reduced motion: no flash");
}

#[test]
fn target_list_without_a_model_a_close_mob_shows_its_own_portrait_else_the_crosshair_alone() {
	let out = run_with(
		r#"
		q.step({ { t = "kill", target = "Kobold Vermin" } })
		emit(face(1))
		q.target = { name = "Kobold Vermin" }
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.runTimers()
		emit(face(1))
	"#,
		MODELS,
	);
	assert_eq!(out[0], json!([false, "red"]), "no id: no model, the crosshair alone");
	assert_eq!(out[1], json!(["portrait:Kobold Vermin", "green"]));
}

#[test]
fn target_list_faces_change_in_combat_and_pass_over_what_the_client_keeps_secret() {
	let out = run_with(
		r#"
		kobolds()
		q.combat(true)
		q.units.nameplate2 = { name = "Kobold Worker" }
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate2")
		stub.runTimers()
		emit({ face(1), face(2) })
		q.units.nameplate2 = nil
		stub.fire("NAME_PLATE_UNIT_REMOVED", "nameplate2")
		stub.runTimers()
		emit({ face(1), face(2) })
		-- Secret answers: the unit is passed over, never tested.
		local SECRET = {}
		issecretvalue = function(v) return v == SECRET end
		local exists = UnitExists
		UnitExists = function(unit) if unit == "nameplate1" then return SECRET end return exists(unit) end
		q.units.nameplate3 = { name = SECRET }
		q.units.nameplate4 = { name = "Kobold Vermin", dead = SECRET }
		q.target = { name = "Kobold Laborer", player = SECRET }
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.runTimers()
		emit(faces())
		q.combat(false)
	"#,
		MODELS,
	);
	assert_eq!(out[0], json!([[6, "red"], [257, "green"]]));
	assert_eq!(out[1], json!([[6, "red"], [257, "red"]]));
	assert_eq!(out[2], json!([[6, "red"], [257, "red"], [80, "red"]]));
}

#[test]
fn target_list_the_polestar_mark_on_a_right_click_opens_the_buttons_settings_moves_the_set_and_gives_way_to_the_simple_button() {
	let out = run(r#"
		local a = B.anchor
		local opened = {}
		Polestar.On("SHOW_OPTIONS", function(section) opened[#opened + 1] = section end)
		kobolds()
		local p, rel, rp = a:GetPoint(1)
		emit({ a:IsShown(), p, rel == t, rp })
		a:GetScript("OnClick")(a, "LeftButton")
		emit(#opened)
		a:GetScript("OnClick")(a, "RightButton")
		emit(opened)
		-- A drag's release opens nothing.
		a:GetScript("OnDragStart")(a)
		a:GetScript("OnClick")(a, "RightButton")
		a:GetScript("OnDragStop")(a)
		emit(#opened)
		set("buttonTextSide", "left")
		p, rel, rp = a:GetPoint(1)
		emit({ p, rp })
		-- The button's binding still targets the list's first name while hidden.
		emit({ t:IsShown(), macro():match("^[^\n]+\n([^\n]+)") })
		set("targetSimple", true)
		emit({ a:IsShown(), t:IsShown() })
		q.step({ { t = "goto", map = 9000, x = 1, y = 1 } })
		set("targetSimple", false)
		emit({ a:IsShown(), t:IsShown() })
	"#);
	assert_eq!(out[0], json!([true, "TOPRIGHT", true, "TOPRIGHT"]), "in the target button's slot, on the rows' side");
	assert_eq!(out[1], 0, "a left-click opens nothing");
	assert_eq!(out[2], json!(["buttons"]), "a right-click: Options > Questing > Buttons");
	assert_eq!(out[3], 1, "a drag's release opens nothing");
	assert_eq!(out[4], json!(["TOPLEFT", "TOPLEFT"]));
	assert_eq!(out[5], json!([false, "/targetexact Kobold Vermin"]));
	assert_eq!(out[6], json!([false, true]));
	assert_eq!(out[7], json!([false, false]), "no names: neither");
}

#[test]
fn target_list_names_in_the_target_list_sets_how_many_rows_show_the_simple_button_keeps_five() {
	let out = run(r#"
		local goals = {}
		for i, n in ipairs({ "Wolf", "Boar", "Bear", "Crab", "Hawk", "Lion", "Mole", "Newt", "Owl" }) do
			goals[i] = { t = "kill", target = n, npc = 100 + i }
		end
		q.step(goals)
		emit(#rows())
		set("targetRows", 2)
		emit({ #rows(), rows()[2][1] })
		set("targetRows", 8)
		emit({ #rows(), rows()[8][1], select(5, PolestarRareButton:GetPoint(1)) })
		set("targetRows", 40)
		emit(#rows())
		set("targetSimple", true)
		emit(#B.TargetNames())
	"#);
	assert_eq!(out[0], 5, "five by default");
	assert_eq!(out[1], json!([2, "Boar"]));
	// Eight rows of 30 with 2 between end 254 under the target button's top:
	// the rare button goes five slots further down (slot -7).
	assert_eq!(out[2], json!([8, "Newt", -308]));
	assert_eq!(out[3], 8, "at most eight");
	assert_eq!(out[4], 5, "the single button cycles through five, as before");
}

#[test]
fn target_list_rows_show_their_goal_s_have_and_need_count_and_follow_it_in_combat() {
	let out = run(r#"
		local function counts()
			local out = {}
			for i, r in ipairs(B.rows) do
				if r:IsShown() then out[i] = r.Count:GetText() end
			end
			return out
		end
		local function step(vermin, candles)
			q.step({
				{ t = "kill", target = "Kobold Vermin", npc = 6, quest = 7, oi = 1, progress = { cur = vermin, max = 10, kind = "count" } },
				{ t = "collect", item = 950, itemName = "Candle", quest = 7, oi = 2, progress = { cur = candles, max = 8, kind = "count" },
					fromNpcs = { { npc = 257, npcName = "Kobold Worker" } } },
				{ t = "kill", target = "Defias Thug", npc = 38 },
				{ t = "collect", item = 951, itemName = "Rep", progress = { cur = 5, max = 20, kind = "rep" },
					fromNpcs = { { npc = 39, npcName = "Defias Smuggler" } } },
			})
		end
		step(3, 0)
		emit(counts())
		-- A kill and a loot in a fight: the counts follow, the rows stay.
		q.combat(true)
		step(4, 1)
		emit(counts())
		q.combat(false)
		local r = B.rows[2]
		r:GetScript("OnEnter")(r)
		emit(GameTooltip.lines[2])
	"#);
	// Vermin (kill 3/10), Worker (Candle 0/8), Thug (no count), Smuggler (a
	// reputation bar, not a count), Laborer (a Candle dropper the QuestDB
	// knows, 0/8). The Vermin also drops Candles; its own kill goal's count
	// wins.
	assert_eq!(out[0], json!(["3/10", "0/8", "", "", "0/8"]));
	assert_eq!(out[1], json!(["4/10", "1/8", "", "", "1/8"]));
	assert_eq!(out[2], "Candle · 1/8");
}

#[test]
fn target_list_names_in_the_list_leave_the_step_key_and_its_corpse_check_their_five_names() {
	let out = run(r#"
		local s = PolestarStepButton
		local goals = {}
		for i, n in ipairs({ "Wolf", "Boar", "Bear", "Crab", "Hawk", "Lion", "Mole" }) do
			goals[i] = { t = "kill", target = n, npc = 100 + i }
		end
		local function stepNames()
			local n = 0
			for _ in s:GetAttribute("macrotext"):gmatch("/targetexact") do n = n + 1 end
			return n
		end
		q.step(goals)
		local before = stepNames()
		set("targetRows", 1)
		emit({ #rows(), stepNames() == before, #B.TargetNames() })
		set("targetRows", 8)
		emit({ #rows(), stepNames() == before, #B.TargetNames() })
		set("targetSimple", true)
		emit({ stepNames() == before, #B.TargetNames() })
		-- The step key's loot stage still knows the fifth mob's corpse.
		set("targetSimple", false)
		set("targetRows", 1)
		set("stepInteract", true)
		BINDING_NAME_INTERACTTARGET = BINDING_NAME_INTERACTTARGET or "Interact"
		q.target = { name = "Hawk", dead = true }
		emit(B.InteractStage() or "nil")
	"#);
	assert_eq!(out[0], json!([1, true, 5]), "one row; the step key and TargetNames keep five");
	assert_eq!(out[1], json!([7, true, 5]), "all seven of the step's mobs");
	assert_eq!(out[2], json!([true, 5]));
	assert_eq!(out[3], "interact");
}

#[test]
fn target_list_a_drop_chance_that_arrives_with_the_questdb_reaches_the_row_s_tooltip() {
	let out = run(r#"
		Polestar.QuestDB = nil
		q.step({ { t = "collect", item = 950, itemName = "Candle", quest = 7, oi = 2,
			fromNpcs = { { npc = 257, npcName = "Kobold Worker" } } } })
		local r = B.rows[1]
		local function tip()
			r:GetScript("OnEnter")(r)
			local line = GameTooltip.lines[2]
			r:GetScript("OnLeave")(r)
			return line
		end
		emit({ #rows(), tip() })
		-- The same mob, now with its chance: the row itself does not change.
		Polestar.QuestDB = {
			IsLoaded = function() return true end,
			GetObjectiveMobs = function() return { "Kobold Worker" }, { { id = 257, chance = 32.4 } } end,
		}
		Polestar.Fire("QUESTDB_LOADED")
		stub.runTimers()
		emit({ #rows(), tip() })
	"#);
	assert_eq!(out[0], json!([1, "Candle"]));
	assert_eq!(out[1], json!([1, "Candle · 32%"]));
}

#[test]
fn target_list_a_row_keeps_its_own_count_and_tooltip_while_a_fight_holds_it_on_the_old_step() {
	let out = run(r#"
		local function row(i)
			local r = B.rows[i]
			r:GetScript("OnEnter")(r)
			local tip = GameTooltip.lines[2]
			r:GetScript("OnLeave")(r)
			return { r.Name:GetText(), r.Count:GetText(), tip, r:GetAttribute("macrotext"):match("/targetexact ([^\n]+)") }
		end
		q.step({ { t = "collect", item = 950, itemName = "Candle", progress = { cur = 1, max = 5, kind = "count" },
			fromNpcs = { { npc = 1, npcName = "Wolf" } } } })
		emit(row(1))
		q.combat(true)
		q.step({ { t = "collect", item = 951, itemName = "Tusk", progress = { cur = 2, max = 3, kind = "count" },
			fromNpcs = { { npc = 2, npcName = "Boar" } } } })
		emit(row(1))
		q.combat(false)
		emit(row(1))
	"#);
	assert_eq!(out[0], json!(["Wolf", "1/5", "Candle · 1/5", "Wolf"]));
	assert_eq!(out[1], json!(["Wolf", "1/5", "Candle · 1/5", "Wolf"]), "in the fight the row still targets the Wolf, with its own count");
	assert_eq!(out[2], json!(["Boar", "2/3", "Tusk · 2/3", "Boar"]));
}

#[test]
fn target_list_a_left_click_on_the_polestar_mark_folds_it_to_one_row_that_shows_the_close_one() {
	let out = run_with(
		r#"
		local a = B.anchor
		local function click(which) a:GetScript("OnClick")(a, which) end
		local function targets(r)
			local n = 0
			for _ in r:GetAttribute("macrotext"):gmatch("/targetexact") do n = n + 1 end
			return n
		end
		kobolds()
		click("LeftButton")
		local r = B.rows[1]
		emit({ #rows(), r.Name:GetText(), targets(r), face(1), select(5, PolestarRareButton:GetPoint(1)) })
		-- The Worker comes close: the one row shows it, with its own count and green.
		q.units.nameplate2 = { name = "Kobold Worker" }
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate2")
		stub.runTimers()
		emit({ r.Name:GetText(), r.Note:GetText(), face(1) })
		r:GetScript("OnEnter")(r)
		emit(GameTooltip.lines[3])
		r:GetScript("OnLeave")(r)
		-- In a fight the fold waits; a right-click still opens the settings.
		local opened = 0
		Polestar.On("SHOW_OPTIONS", function() opened = opened + 1 end)
		q.combat(true)
		click("LeftButton")
		emit(#rows())
		q.combat(false)
		emit({ #rows(), Polestar.QoL.State().targetFolded or false })
		click("RightButton")
		emit({ opened, #rows() })
		-- One name: nothing to fold.
		click("LeftButton")
		q.step({ { t = "kill", target = "Defias Thug", npc = 38 } })
		emit({ #rows(), B.rows[1].names == nil })
	"#,
		MODELS,
	);
	assert_eq!(out[0], json!([1, "Kobold Vermin", 3, [6, "red"], -88]), "one row trying all three names; the rare button back in its slot");
	assert_eq!(out[1], json!(["Kobold Worker", "Candle", [257, "green"]]));
	assert_eq!(out[2], "Folded: targets the first of 3 names that is close. Left-click the Polestar mark to show them all.");
	assert_eq!(out[3], 1, "no change in combat");
	assert_eq!(out[4], json!([3, false]), "opened once the fight ended");
	assert_eq!(out[5], json!([1, 3]));
	assert_eq!(out[6], json!([1, true]));
}

#[test]
fn target_list_counts_for_a_step_a_fight_holds_back_follow_it_and_never_reach_the_old_row() {
	let out = run(r#"
		local function row(i)
			local r = B.rows[i]
			r:GetScript("OnEnter")(r)
			local tip = GameTooltip.lines[2]
			r:GetScript("OnLeave")(r)
			return { r.Name:GetText(), r.Count:GetText(), tip }
		end
		local function wolf(item, cur, max)
			q.step({ { t = "collect", item = 950, itemName = item, progress = { cur = cur, max = max, kind = "count" },
				fromNpcs = { { npc = 1, npcName = "Wolf" } } } })
		end
		local function boar(cur)
			q.step({ { t = "collect", item = 951, itemName = "Tusk", progress = { cur = cur, max = 3, kind = "count" },
				fromNpcs = { { npc = 2, npcName = "Boar" } } } })
		end
		-- A step the fight holds back counts on: its rows come with the latest count.
		wolf("Candle", 1, 5)
		q.combat(true)
		boar(1)
		boar(2)
		emit(row(1))
		q.combat(false)
		emit(row(1))
		-- The same mob for another goal: the held row keeps its own count.
		wolf("Candle", 1, 5)
		q.combat(true)
		wolf("Fur", 2, 3)
		emit(row(1))
		q.combat(false)
		emit(row(1))
	"#);
	assert_eq!(out[0], json!(["Wolf", "1/5", "Candle · 1/5"]));
	assert_eq!(out[1], json!(["Boar", "2/3", "Tusk · 2/3"]), "the latest count, not the first held back");
	assert_eq!(out[2], json!(["Wolf", "1/5", "Candle · 1/5"]), "not the Fur goal's 2/3");
	assert_eq!(out[3], json!(["Wolf", "2/3", "Fur · 2/3"]));
}

#[test]
fn target_list_folded_a_close_mob_past_what_the_macro_holds_comes_first_out_of_combat_and_after_a_fight() {
	let out = run_with(
		r#"
		local a = B.anchor
		local names = { "Sunscale Lashtail", "Sunscale Screecher", "Sunscale Scytheclaw", "Takk the Leaper",
			"Ishamuhale", "Kolkar Wrangler", "Kolkar Stormer", "Kolkar Pack Runner" }
		local goals = {}
		for i, n in ipairs(names) do goals[i] = { t = "kill", target = n, npc = 100 + i } end
		set("targetRows", 8)
		q.step(goals)
		a:GetScript("OnClick")(a, "LeftButton")
		local r = B.rows[1]
		local function state()
			local m = r:GetAttribute("macrotext")
			return { r.Name:GetText(), m:match("^[^\n]+\n/targetexact ([^\n]+)"), face(1)[2], #r.names < #names }
		end
		emit(state())
		-- The Stormer (7th, past what one macro holds) is the target.
		q.target = { name = "Kolkar Stormer" }
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.runTimers()
		emit(state())
		-- In a fight the Pack Runner comes close instead: the macro waits for the end of it.
		q.combat(true)
		q.target = { name = "Kolkar Pack Runner" }
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.runTimers()
		emit(state())
		q.combat(false)
		stub.runTimers()
		emit(state())
	"#,
		MODELS,
	);
	assert_eq!(out[0], json!(["Sunscale Lashtail", "Sunscale Lashtail", "red", true]), "a macro holds only some of eight names");
	assert_eq!(out[1], json!(["Kolkar Stormer", "Kolkar Stormer", "green", true]), "the close one shows and is tried first");
	// In the fight the macro still starts with the Stormer and holds a few after it.
	assert_eq!(out[2][1], "Kolkar Stormer");
	assert_eq!(out[3], json!(["Kolkar Pack Runner", "Kolkar Pack Runner", "green", true]));
}

#[test]
fn target_list_folded_it_goes_back_to_the_list_s_first_name_once_none_is_close_and_tells_the_whole_count() {
	let out = run_with(
		r#"
		local a = B.anchor
		local names = { "Sunscale Lashtail", "Sunscale Screecher", "Sunscale Scytheclaw", "Takk the Leaper",
			"Ishamuhale", "Kolkar Wrangler", "Kolkar Stormer", "Kolkar Pack Runner" }
		local goals = {}
		for i, n in ipairs(names) do goals[i] = { t = "kill", target = n, npc = 100 + i } end
		set("targetRows", 8)
		q.step(goals)
		a:GetScript("OnClick")(a, "LeftButton")
		local r = B.rows[1]
		local function state()
			return { r.Name:GetText(), r:GetAttribute("macrotext"):match("^[^\n]+\n/targetexact ([^\n]+)") }
		end
		q.units.nameplate1 = { name = "Kolkar Stormer" }
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		stub.runTimers()
		emit(state())
		r:GetScript("OnEnter")(r)
		emit(GameTooltip.lines[2])
		r:GetScript("OnLeave")(r)
		-- Its nameplate goes: back to the list's first name.
		q.units.nameplate1 = nil
		stub.fire("NAME_PLATE_UNIT_REMOVED", "nameplate1")
		stub.runTimers()
		emit(state())
		-- The same in a fight: the row's text at once, its macro once the fight ends.
		q.units.nameplate1 = { name = "Kolkar Stormer" }
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		stub.runTimers()
		q.combat(true)
		q.units.nameplate1 = nil
		stub.fire("NAME_PLATE_UNIT_REMOVED", "nameplate1")
		stub.runTimers()
		emit(state())
		q.combat(false)
		stub.runTimers()
		emit(state())
	"#,
		MODELS,
	);
	assert_eq!(out[0], json!(["Kolkar Stormer", "Kolkar Stormer"]));
	assert_eq!(out[1], "Folded: targets the first of 8 names that is close. Left-click the Polestar mark to show them all.");
	assert_eq!(out[2], json!(["Sunscale Lashtail", "Sunscale Lashtail"]));
	assert_eq!(out[3], json!(["Kolkar Stormer", "Kolkar Stormer"]), "in the fight neither the macro nor (with none close) its first name changes");
	assert_eq!(out[4], json!(["Sunscale Lashtail", "Sunscale Lashtail"]));
}

#[test]
fn target_list_folded_a_name_too_long_for_a_macro_gives_no_macro() {
	let out = run(r#"
		local long = string.rep("x", 230)
		q.step({ { t = "kill", target = long, npc = 1 }, { t = "kill", target = "Boar", npc = 2 } })
		B.anchor:GetScript("OnClick")(B.anchor, "LeftButton")
		local m = B.rows[1]:GetAttribute("macrotext")
		emit({ m == nil or #m <= 255, #rows() })
	"#);
	assert_eq!(out[0], json!([true, 0]), "nothing over 255 bytes is installed");
}

#[test]
fn target_list_names_the_step_s_npcs_when_it_has_no_mob_with_the_npc_mark_and_no_ping() {
	let out = run_with(
		r#"
		set("markTarget", true)
		set("pingTarget", true)
		q.step({
			{ t = "turnin", quest = 9, npc = 240, npcName = "Marshal Dughan" },
			{ t = "talk", npc = 241, npcName = "Gryan Stoutmantle" },
		})
		emit(rows())
		kobolds()
		local r = rows()
		emit({ #r, r[1][1], r[1][3] })
	"#,
		"SLASH_PING1 = \"/ping\"",
	);
	let npc_mark = "/tm [@target,exists,nodead,nocombat][@target,noharm,nodead] !1";
	assert_eq!(
		out[0],
		json!([
			["Marshal Dughan", "", format!("/cleartarget [nocombat]\n/targetexact Marshal Dughan\n/cleartarget [dead]\n{npc_mark}"), 240],
			["Gryan Stoutmantle", "", format!("/cleartarget [nocombat]\n/targetexact Gryan Stoutmantle\n/cleartarget [dead]\n{npc_mark}"), 241]
		]),
		"no mob: the step's NPCs, each row with the NPC's mark and no ping"
	);
	assert_eq!(out[1], json!([3, "Kobold Vermin", format!("{VERMIN}\n/ping [@target]\n/tm [@target,harm,nodead] !8")]), "mobs: the mob's mark, and the ping");
}

#[test]
fn target_list_while_you_re_here_mobs_follow_the_step_s_own_rows() {
	let out = run(r#"
		local shown = {}
		q.Engine.GetWhileHereList = function() return shown end
		q.Engine.AlongGoal = function(s, g)
			for _, r in ipairs(shown) do
				if r.step == s and r.index == g then return r.raw end
			end
		end
		q.step({ { t = "kill", target = "Mottled Screecher", npc = 1021 } })
		shown = { { t = "kill", subject = "Bluegill Murloc", step = 41, index = 1, status = "active", raw = { npc = 1024 } } }
		Polestar.Fire("WHILE_HERE_CHANGED")
		stub.runTimers()
		local out = {}
		for _, r in ipairs(rows()) do out[#out + 1] = { r[1], r[4] } end
		emit(out)
	"#);
	assert_eq!(out[0], json!([["Mottled Screecher", 1021], ["Bluegill Murloc", 1024]]), "the step's own mob, then the row's");
}

fn run_qkb(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_qol.lua", "stub_quickbind.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		login: true,
		script: format!("{PRELUDE}local k = stub.qkb\n_G[\"BINDING_NAME_CLICK PolestarTargetButton:LeftButton\"] = \"Target quest mob\"\n{script}"),
		..Default::default()
	})
}

#[test]
fn target_list_in_quick_keybind_mode_the_polestar_mark_binds_the_target_button_s_key_and_the_button_stays_hidden() {
	let out = run_qkb(
		r#"
		local a = B.anchor
		kobolds()
		k.open()
		emit({ t:IsShown(), a:IsShown(), a:GetAlpha() or 1 })
		local took = k.hover(a) ~= nil
		emit({ took, QuickKeybindTooltip.lines[1], GameTooltip:GetOwner() == a })
		k.key("F")
		emit({ k.keys("CLICK PolestarTargetButton:LeftButton"), k.keys("CLICK PolestarTargetAnchor:LeftButton") })
		k.leave()
		k.close()
		emit({ t:IsShown(), a:IsShown(), a:GetAlpha() or 1, t.Hotkey:GetText() })
	"#,
	);
	assert_eq!(out[0], json!([false, true, 1]), "the list's own look: the mark, not the button");
	assert_eq!(out[1], json!([true, "highlight: Target quest mob", false]), "the mode's tooltip, for the target button's binding");
	assert_eq!(out[2], json!([["F"], {}]), "the key goes to the target button's binding");
	assert_eq!(out[3], json!([false, true, 1, "F"]));
}

#[test]
fn target_list_in_quick_keybind_mode_with_no_names_the_mark_shows_dimmed_and_goes_when_the_window_closes() {
	let out = run_qkb(
		r#"
		local a = B.anchor
		k.open()
		emit({ t:IsShown(), a:IsShown(), a:GetAlpha() or 1, a.Label:GetText() })
		k.close()
		emit({ t:IsShown(), a:IsShown(), a:GetAlpha() or 1, a.Label:GetText() or "" })
		set("targetSimple", true)
		k.open()
		emit({ t:IsShown(), a:IsShown() })
		k.close()
	"#,
	);
	assert_eq!(out[0], json!([false, true, 0.45, "Target quest mob"]), "no names: the mark, dimmed and named, so the key can be bound");
	assert_eq!(out[1], json!([false, false, 1, ""]), "gone with the window");
	assert_eq!(out[2], json!([true, false]), "Simple target button: the button itself, as before");
}

#[test]
fn target_list_dragging_the_mark_or_a_row_moves_the_set_and_never_the_bag_button() {
	let out = run(r#"
		local a = B.anchor
		local bag = PolestarBagButton
		local function at(f) local p, _, rp, x, y = f:GetPoint(1); return { p, rp, x, y } end
		kobolds()
		local holder = select(2, t:GetPoint(1))
		local bagBefore = at(bag)
		for _, f in ipairs({ a, B.rows[1] }) do
			f:GetScript("OnDragStart")(f)
			holder:ClearAllPoints()
			holder:SetPoint("CENTER", UIParent, "CENTER", -200, 30)
			f:GetScript("OnDragStop")(f)
			stub.runTimers()
			emit({ Polestar.QoL.State().buttonPos, Polestar.QoL.State().bagButtonPos or false, at(bag) })
		end
		emit(bagBefore)
	"#);
	assert_eq!(out[0][0], json!(["CENTER", "CENTER", -200, 30]), "the mark's drag moves the set");
	assert_eq!(out[0][1], json!(false), "the bag button's own spot is not saved");
	assert_eq!(out[0][2], out[2], "and the bag button stays where it was");
	assert_eq!(out[1][0], json!(["CENTER", "CENTER", -200, 30]), "a row's drag too");
	assert_eq!(out[1][2], out[2]);
}

#[test]
fn target_list_a_use_goal_lists_the_creatures_its_item_works_on_with_its_count_and_no_drop_line() {
	let out = run(r#"
		q.step({
			{ t = "use", item = 13892, quest = 5561, progress = { kind = "count", cur = 2, max = 5 },
				fromNpcs = { { npc = 4700, npcName = "Aged Kodo" }, { npc = 4701, npcName = "Dying Kodo" }, { npc = 4702, npcName = "Ancient Kodo" } } },
		})
		local out = {}
		for i, r in ipairs(rows()) do out[i] = { r[1], r[2], r[4], B.rows[i].Count:GetText() } end
		emit(out)
	"#);
	assert_eq!(
		out[0],
		json!([["Aged Kodo", "", 4700, "2/5"], ["Dying Kodo", "", 4701, "2/5"], ["Ancient Kodo", "", 4702, "2/5"]]),
		"every creature the item works on, with the goal's count; nothing is dropped"
	);
}

#[test]
fn target_list_a_collect_through_several_camps_lists_the_mobs_at_the_spot_the_arrow_takes() {
	let out = run(r#"
		local at = 1
		Polestar.Engine.SpotIndexOf = function() return at end
		q.step({
			{ t = "collect", item = 5030, itemName = "Centaur Ear", quest = 1366,
				spots = { { 1, 1 }, { 2, 2 } }, fromNpcsAt = "1;2",
				fromNpcs = { { npc = 4632, npcName = "Kolkar Centaur" }, { npc = 4640, npcName = "Magram Wrangler" } } },
		})
		local function names() local out = {} for i, r in ipairs(rows()) do out[i] = { r[1], r[2] } end return out end
		emit(names())
		at = 2
		Polestar.Fire("WAYPOINT_CHANGED")
		stub.runTimers()
		emit(names())
	"#);
	assert_eq!(out[0], json!([["Kolkar Centaur", "Centaur Ear"]]), "the first camp's mob alone, with what it drops");
	assert_eq!(out[1], json!([["Magram Wrangler", "Centaur Ear"]]), "the arrow moves on: the next camp's");
}

#[test]
fn target_list_in_quick_keybind_mode_the_mark_follows_names_coming_and_going_and_the_simple_setting() {
	let out = run_qkb(
		r#"
		local a = B.anchor
		local function look() return { t:IsShown(), a:IsShown(), a:GetAlpha() or 1, a.Label:GetText() or "" } end
		k.open()
		emit(look())
		kobolds()
		stub.advance(0.3)
		emit(look())
		q.step({ { t = "goto", map = 9000, x = 1, y = 1 } })
		stub.advance(0.3)
		emit(look())
		set("targetSimple", true)
		stub.advance(0.3)
		emit(look())
		k.close()
		emit(look())
	"#,
	);
	assert_eq!(out[0], json!([false, true, 0.45, "Target quest mob"]), "no names: dimmed, named");
	assert_eq!(out[1], json!([false, true, 1, ""]), "names arrive: the mark's own look, its label cleared");
	assert_eq!(out[2], json!([false, true, 0.45, "Target quest mob"]), "names gone: dimmed again");
	assert_eq!(out[3], json!([true, false, 1, ""]), "Simple target button: the button takes over, the mark goes with its own look back");
	assert_eq!(out[4], json!([false, false, 1, ""]), "the window closes: neither stays");
}

#[test]
fn target_list_the_step_key_s_and_while_you_re_here_lookups_leave_the_rows_records_alone() {
	let out = run(r#"
		local shown = {}
		q.Engine.GetWhileHereList = function() return shown end
		q.Engine.AlongGoal = function(s, g)
			for _, r in ipairs(shown) do
				if r.step == s and r.index == g then return r.raw end
			end
		end
		kobolds()
		local function info(n) local i = B.TargetInfo(n); return i and { i.npc or false, i.item or false } or false end
		emit({ info("Kobold Vermin"), info("Kobold Worker") })
		shown = { { t = "collect", npc = 99, npcName = "Kobold Worker", step = 41, index = 1, status = "active", raw = {} } }
		B.StepAction()
		emit({ info("Kobold Vermin"), info("Kobold Worker") })
		B.HereNames()
		emit({ info("Kobold Vermin"), info("Kobold Worker") })
		local before = B.TargetInfo("Kobold Vermin")
		B.TargetNames({ goals = { { t = "kill", target = "Kobold Vermin", npc = 77, status = "active" } } })
		emit({ info("Kobold Vermin"), info("Kobold Worker"), B.TargetInfo("Kobold Vermin") == before })
	"#);
	assert_eq!(out[0], json!([[6, "Candle"], [257, "Candle"]]));
	assert_eq!(out[1], out[0], "after the step key's lookups");
	assert_eq!(out[2], out[0], "after the While you're here lookup");
	assert_eq!(out[3], json!([[6, "Candle"], [257, "Candle"], true]), "after another caller's TargetNames: the same records");
}

// Which theme colour a texture or a text wears (the first that matches), for the rows' colours.
const TONES: &str = r#"
local function tone(region)
	local c
	if region:GetObjectType() == "Texture" then c = { region:GetVertexColor() } else c = { region:GetTextColor() } end
	for _, k in ipairs({ "success", "quest", "danger", "textDim", "text" }) do
		local t = { Polestar.Theme.Color(k) }
		if t[1] == c[1] and t[2] == c[2] and t[3] == c[3] then return k end
	end
	return "other"
end
local function tones(i)
	local r = B.rows[i]
	return { r.Name:GetText(), tone(r.Name), tone(r.Mark), r.Count:GetText() ~= "" and tone(r.Count) or false }
end
"#;

// Review of #1704: a name wears its kind's colour, as the simple button's plate has it (docs/DESIGN.md, the subject
// colours): green for a friendly NPC, gold for an elite, red for a mob. An NPC's crosshair is not red (the NPC is not
// hostile); a count turns green once complete, as in the guide window.
#[test]
fn target_list_names_wear_their_kind_s_colour_an_npc_s_crosshair_is_not_red_a_complete_count_is_green() {
	let out = run(&format!(
		"{TONES}{}",
		r#"
		q.step({
			{ t = "turnin", quest = 9, npc = 240, npcName = "Marshal Dughan" },
		})
		emit(tones(1))
		q.step({
			{ t = "kill", target = "Elder Tiger", npc = 50, group = { kind = "elite", rank = 1 }, progress = { cur = 0, max = 1, kind = "count" } },
			{ t = "kill", target = "Kobold Vermin", npc = 6, progress = { cur = 10, max = 10, kind = "count" } },
		})
		emit({ tones(1), tones(2) })
		Polestar.Set("ui.scheme", "graphite")
		emit({ tones(1), tones(2) })
	"#
	));
	assert_eq!(out[0], json!(["Marshal Dughan", "success", "textDim", false]), "an NPC: green name, a neutral crosshair");
	let mobs = json!([["Elder Tiger", "quest", "danger", "text"], ["Kobold Vermin", "danger", "danger", "success"]]);
	assert_eq!(out[1], mobs, "an elite in gold, a mob in red; 10/10 in green, 0/1 not");
	assert_eq!(out[2], out[1], "the same after a theme change");
}

// #1623 put a step's NPC and the While you're here rows' mobs in one list: each row takes its own name's mark and
// ping, and its click advances that kind's mark.
#[test]
fn target_list_a_step_s_npc_and_while_you_re_here_mobs_each_row_with_its_own_kind_s_mark_and_ping() {
	let out = run_with(
		&format!(
			"{TONES}{}",
			r#"
		set("markTarget", true)
		set("pingTarget", true)
		local shown = {}
		q.Engine.GetWhileHereList = function() return shown end
		q.Engine.AlongGoal = function(s, g)
			for _, r in ipairs(shown) do
				if r.step == s and r.index == g then return r.raw end
			end
		end
		q.step({ { t = "turnin", quest = 9, npc = 240, npcName = "Marshal Dughan" } })
		shown = { { t = "kill", subject = "Bluegill Murloc", step = 41, index = 1, status = "active", raw = { npc = 1024 } } }
		Polestar.Fire("WHILE_HERE_CHANGED")
		stub.runTimers()
		local r = rows()
		emit({ r[1][1], r[1][3], r[2][1], r[2][3] })
		emit({ tones(1), tones(2) })
		local kinds = {}
		local advance = B.AdvanceMark
		B.AdvanceMark = function(kind) kinds[#kinds + 1] = kind; return advance(kind) end
		q.click(B.rows[1], true); q.click(B.rows[1], false)
		q.click(B.rows[2], true); q.click(B.rows[2], false)
		emit(kinds)
	"#
		),
		"SLASH_PING1 = \"/ping\"",
	);
	let npc_mark = "/tm [@target,exists,nodead,nocombat][@target,noharm,nodead] !1";
	assert_eq!(
		out[0],
		json!([
			"Marshal Dughan",
			format!("/cleartarget [nocombat]\n/targetexact Marshal Dughan\n/cleartarget [dead]\n{npc_mark}"),
			"Bluegill Murloc",
			"/cleartarget [nocombat]\n/targetexact Bluegill Murloc\n/cleartarget [dead]\n/ping [@target]\n/tm [@target,harm,nodead] !8"
		]),
		"the NPC first (no place known: near), its mark and no ping; the row's mob after, with the mob's mark and the ping"
	);
	assert_eq!(out[1], json!([["Marshal Dughan", "success", "textDim", false], ["Bluegill Murloc", "danger", "danger", false]]));
	assert_eq!(out[2], json!(["npc", "mob"]), "each row's click advances its own kind's mark");
}

// The preview harness (and any client) without UnitIsDead or UnitIsPlayer: no close mob, and no error (#1704's red
// CI: `node tools/polestar.js preview` stopped in closeUnits).
#[test]
fn target_list_without_unit_is_dead_or_unit_is_player_no_row_is_close_and_nothing_breaks() {
	let out = run(r#"
		UnitIsDead, UnitIsPlayer = nil, nil
		q.units.nameplate1 = { name = "Kobold Worker" }
		kobolds()
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		stub.runTimers()
		emit({ #rows(), face(2)[2] })
	"#);
	assert_eq!(out[0], json!([3, "red"]));
}

// Review of #1704: a left-click on the Polestar mark in a fight changes the setting at once and the rows only when
// it ends, so its tooltip says so.
#[test]
fn target_list_the_polestar_mark_s_tooltip_says_a_fold_clicked_in_a_fight_follows_after_it() {
	let out = run(r#"
		local a = B.anchor
		local function click() a:GetScript("OnClick")(a, "LeftButton") end
		local function line()
			a:GetScript("OnEnter")(a)
			local l = GameTooltip.lines[3]
			a:GetScript("OnLeave")(a)
			return l
		end
		kobolds()
		emit(line())
		q.combat(true)
		click()
		emit({ line(), #rows() })
		click()
		emit(line())
		click()
		q.combat(false)
		emit({ line(), #rows() })
	"#);
	assert_eq!(out[0], "Left-click to fold the list to one row.");
	assert_eq!(out[1], json!(["The list folds to one row after this fight.", 3]));
	assert_eq!(out[2], "Left-click to fold the list to one row.", "clicked back: nothing waits");
	assert_eq!(out[3], json!(["Left-click to show the whole list.", 1]));
}

// Review of the 0.3.7 rebase: a name whose goal changes from an NPC's to a mob's keeps its name and id, so only the
// verb tells them apart; the row must take the mob's mark, ping and colour.
#[test]
fn target_list_a_name_that_turns_from_an_npc_goal_into_a_kill_takes_the_mob_s_mark_ping_and_colour() {
	let out = run_with(
		&format!(
			"{TONES}{}",
			r#"
		set("markTarget", true)
		set("pingTarget", true)
		q.step({ { t = "talk", npc = 77, npcName = "Same Name" } })
		emit({ B.rows[1]:GetAttribute("macrotext"), tones(1) })
		q.step({ { t = "kill", target = "Same Name", npc = 77 } })
		emit({ B.rows[1]:GetAttribute("macrotext"), tones(1) })
	"#
		),
		"SLASH_PING1 = \"/ping\"",
	);
	assert_eq!(
		out[0],
		json!(["/cleartarget [nocombat]\n/targetexact Same Name\n/cleartarget [dead]\n/tm [@target,exists,nodead,nocombat][@target,noharm,nodead] !1", ["Same Name", "success", "textDim", false]])
	);
	assert_eq!(out[1], json!(["/cleartarget [nocombat]\n/targetexact Same Name\n/cleartarget [dead]\n/ping [@target]\n/tm [@target,harm,nodead] !8", ["Same Name", "danger", "danger", false]]));
}

// Review of the 0.3.7 rebase: a mob on the list seen to be elite (the target, a nameplate) turns its row's name gold
// at once, as the simple button's plate does.
#[test]
fn target_list_a_mob_seen_to_be_elite_turns_its_row_gold() {
	let out = run(&format!(
		"{TONES}{}",
		r#"
		q.step({ { t = "kill", target = "Tiger", npc = 90 } })
		emit(tones(1))
		q.units.nameplate1 = { name = "Tiger" }
		UnitClassification = function(u) if u == "nameplate1" then return "elite" end return "normal" end
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		stub.runTimers()
		emit(tones(1)[2])
	"#
	));
	assert_eq!(out[0], json!(["Tiger", "danger", "danger", false]));
	assert_eq!(out[1], "quest");
}

// Review of the 0.3.7 rebase: two goals naming the same creature with different ids (a name shared by two mobs) put
// it once on the list, with the id of the goal the arrow takes; when the arrow moves to the other goal the row's
// face follows its id.
#[test]
fn target_list_a_name_two_goals_share_takes_the_id_of_the_arrow_s_goal_and_follows_the_arrow() {
	let out = run(r#"
		local aim = 2
		q.Engine.GetWaypoint = function() return { stepIndex = q.engine.step, goalIndex = aim } end
		q.step({ { t = "kill", target = "Same", npc = 11 }, { t = "kill", target = "Same", npc = 22 } })
		emit({ #rows(), rows()[1][4] })
		aim = 1
		Polestar.QoL.Buttons.Refresh()
		stub.runTimers()
		emit({ #rows(), rows()[1][4] })
	"#);
	assert_eq!(out[0], json!([1, 22]), "one row, the arrow's goal's id");
	assert_eq!(out[1], json!([1, 11]), "the arrow on the other goal: its id");
}
