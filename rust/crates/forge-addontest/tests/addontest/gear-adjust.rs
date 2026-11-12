//! The player's own changes to the built-in stat weights (addon/Polestar/Gear/Adjust.lua, UI/GearAdjust.lua, #1529):
//! a change kept as a share of the default so it follows the level bands, the spec marked "(adjusted)", one stat or
//! every stat back to its default.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FIXTURE: &str = r#"{
	[9001] = "1 20 15 2 4 3 str5 sta3 armor150",
}"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua", "stub_world.lua", "stub_gear.lua"],
		before: r#"w = stub.world; w.class, w.className, w.classID, w.level = "WARRIOR", "Warrior", 1, 30
w.race, w.raceName, w.raceID, w.faction = "Troll", "Troll", 8, "Horde""#
			.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml", "UI/UI.xml"])],
		login: true,
		script: ["G = Polestar.Gear\nA = G.Adjust\nPolestar.ItemDB.Register({ schema = 1, build = \"test\" }, ", FIXTURE, ")\nPolestar.Set(\"gear.spec.WARRIOR\", \"arms\")\n", script].concat(),
		..Default::default()
	})
}

#[test]
fn a_change_applies_at_once_marks_the_spec_adjusted_and_follows_a_new_default() {
	let out = run(r#"
		local base = G.WeightsFor("WARRIOR", "arms", 30)
		local before = G.ScoreItem("item:9001")
		emit({ A.Set("WARRIOR", "arms", "sta", base.sta * 1.5) })
		local key, label, source = G.GetSpec()
		emit({ label = label, source = source, adjusted = G.GetWeightsInfo().adjusted, sta = G.GetWeights().sta, want = base.sta * 1.5,
			str = G.GetWeights().str == base.str, scored = G.ScoreItem("item:9001") > before, stored = Polestar.DB().gearAdjust.WARRIOR.arms.sta })
		-- The band in use changes the default (an update, or the next band at a level up): the change is half
		-- again of the new one.
		for _, b in ipairs(G.WEIGHT_BANDS.WARRIOR.arms) do
			if 30 <= b.upTo then
				local t = {}
				for k, v in pairs(b.weights) do t[k] = v end
				t.sta = 0.8
				b.weights = t
				break
			end
		end
		G.Invalidate("spec")
		emit({ sta = G.GetWeights().sta, rows = A.Rows("WARRIOR", "arms")[3] })
	"#);
	assert_eq!(out[0], json!([true]));
	assert_eq!(out[1]["label"], "Arms (adjusted)");
	assert_eq!(out[1]["source"], "setting");
	assert_eq!(out[1]["adjusted"], 1);
	assert_eq!(out[1]["sta"], out[1]["want"]);
	assert_eq!(out[1]["str"], true, "the other stats keep their defaults");
	assert_eq!(out[1]["scored"], true, "Stamina counts for more at once");
	assert_eq!(out[1]["stored"], json!({ "x": 1.5 }), "kept as a share of the default");
	let sta = out[2]["sta"].as_f64().unwrap();
	assert!((sta - 1.2).abs() < 1e-9, "1.5 x the new default of 0.8, got {sta}");
	assert_eq!(out[2]["rows"]["key"], "sta");
	assert_eq!(out[2]["rows"]["edited"], true);
}

#[test]
fn a_value_equal_to_the_default_clears_the_change_clear_puts_one_stat_back_revert_puts_them_all_back() {
	let out = run(r#"
		local d = G.WeightsFor("WARRIOR", "arms", 30)
		A.Set("WARRIOR", "arms", "sta", 2)
		A.Set("WARRIOR", "arms", "agi", 0.1)
		A.Set("WARRIOR", "arms", "hp5", d.hp5)
		emit({ count = A.Count("WARRIOR", "arms"), hp5 = (A.Edits("WARRIOR", "arms") or {}).hp5 or false })
		A.Set("WARRIOR", "arms", "sta", d.sta)
		emit({ count = A.Count("WARRIOR", "arms"), sta = G.GetWeights().sta == d.sta })
		emit({ cleared = A.Clear("WARRIOR", "arms", "agi"), again = A.Clear("WARRIOR", "arms", "agi"), count = A.Count("WARRIOR", "arms") })
		A.Set("WARRIOR", "arms", "sta", 3)
		A.Set("WARRIOR", "arms", "str", 3)
		local _, label = G.GetSpec()
		emit({ reverted = A.Revert("WARRIOR", "arms"), none = A.Revert("WARRIOR", "arms"), label = select(2, G.GetSpec()), before = label,
			same = G.GetWeights() == G.WeightsFor("WARRIOR", "arms", 30) or G.GetWeights().sta == d.sta, info = G.GetWeightsInfo().adjusted or false })
	"#);
	assert_eq!(out[0], json!({ "count": 2, "hp5": false }), "typing the default is no change");
	assert_eq!(out[1], json!({ "count": 1, "sta": true }), "typing the default back clears it");
	assert_eq!(out[2], json!({ "cleared": true, "again": false, "count": 0 }));
	assert_eq!(out[3], json!({ "reverted": 2, "none": 0, "label": "Arms", "before": "Arms (adjusted)", "same": true, "info": false }));
}

#[test]
fn a_stat_the_spec_does_not_weigh_is_kept_as_the_value_typed_and_bad_input_is_refused() {
	let out = run(r#"
		emit({ A.Set("WARRIOR", "arms", "spFire", 0.4) })
		emit({ stored = Polestar.DB().gearAdjust.WARRIOR.arms.spFire, w = G.GetWeights().spFire })
		emit({ A.Set("WARRIOR", "arms", "nonsense", 1) })
		emit({ A.Set("WARRIOR", "arms", "str", "lots") })
		emit({ A.Set("WARRIOR", "arms", "str", 1 / 0) })
		emit({ A.Set("WARRIOR", "shadow", "str", 1) })
		emit({ A.Set("NOPE", "arms", "str", 1) })
		emit({ A.Set("WARRIOR", "arms", "str", " 2.5 ") })
		emit({ str = G.GetWeights().str, fury = A.Count("WARRIOR", "fury"), protection = G.WeightsFor("WARRIOR", "protection", 30).str ~= 2.5 })
	"#);
	assert_eq!(out[0], json!([true]));
	assert_eq!(out[1], json!({ "stored": { "v": 0.4 }, "w": 0.4 }));
	assert_eq!(out[2], json!([false, "stat"]));
	assert_eq!(out[3], json!([false, "number"]));
	assert_eq!(out[4], json!([false, "number"]));
	assert_eq!(out[5], json!([false, "class"]), "a spec of another class");
	assert_eq!(out[6], json!([false, "class"]));
	assert_eq!(out[7], json!([true]), "a number in text is read as one");
	assert_eq!(out[8], json!({ "str": 2.5, "fury": 0, "protection": true }), "only that spec changes");
}

#[test]
fn a_custom_scale_in_use_is_not_touched_and_the_dropdown_marks_the_adjusted_spec() {
	let out = run(r#"
		A.Set("WARRIOR", "fury", "sta", 4)
		local _, r = G.Scales.Import('( Pawn: v1: "Mine": Strength=10, Stamina=1 )', "WARRIOR")
		local labels = {}
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			for _, c in ipairs(spec.controls or {}) do
				if c.key == "gear.spec.WARRIOR" then for _, ch in ipairs(c.choices()) do labels[#labels + 1] = ch.label end end
			end
		end
		Polestar.Set("gear.spec.WARRIOR", "custom:" .. r.scale.id)
		A.Set("WARRIOR", "arms", "sta", 9)
		emit({ labels = labels, sta = G.GetWeights().sta, label = select(2, G.GetSpec()) })
	"#);
	assert_eq!(out[0]["labels"], json!(["Automatic (talents)", "Arms", "Fury (adjusted)", "Protection (tank)", "Custom: Mine"]));
	assert_eq!(out[0]["sta"], 1, "the scale's own weights");
	assert_eq!(out[0]["label"], "Custom: Mine");
}

// What the adjust window shows, as plain data.
const VIEW: &str = r#"
local UI = Polestar.UI
local V = UI.AdjustView
local function shown()
	local out = {}
	for _, l in ipairs(V.lines) do
		if l:IsShown() then
			out[#out + 1] = l.Label:GetText() .. "=" .. l.Box:GetText() .. (l.Default:IsShown() and (" (" .. l.Default:GetText() .. ")") or "")
				.. (l.Reset:IsShown() and " reset" or "")
		end
	end
	return out
end
local function line(name)
	for _, l in ipairs(V.lines) do if l:IsShown() and l.Label:GetText() == name then return l end end
end
local function type_(l, text) l.Box:SetFocus(); l.Box:SetText(text); l.Box:GetScript("OnEnterPressed")(l.Box); l.Box:GetScript("OnEditFocusLost")(l.Box) end"#;

fn run_view(script: &str) -> Value {
	run(&[VIEW, script].concat()).remove(0)
}

#[test]
fn the_window_lists_the_spec_s_weights_and_a_typed_change_shows_its_default_and_a_reset() {
	let out = run_view(
		r#"
		UI.ShowAdjust()
		local d = G.WeightsFor("WARRIOR", "arms", 30)
		local first = { spec = V.spec, button = V.frame.Spec.Label:GetText(), revert = V.frame.Revert:IsShown(), n = #shown(), sta = line("Stamina").Box:GetText() }
		type_(line("Stamina"), "2")
		local edited = { line = line("Stamina") and (line("Stamina").Box:GetText() .. " / " .. line("Stamina").Default:GetText()), reset = line("Stamina").Reset:IsShown(),
			button = V.frame.Spec.Label:GetText(), revert = V.frame.Revert:IsShown(), sta = G.GetWeights().sta }
		type_(line("Strength"), "lots")
		local kept = line("Strength").Box:GetText()
		line("Stamina").Reset:Click()
		emit({ first = first, edited = edited, kept = kept, keptWant = tostring(d.str), back = G.GetWeights().sta == d.sta, after = line("Stamina").Reset:IsShown(),
			default = tostring(d.sta) })
	"#,
	);
	assert_eq!(out["first"]["spec"], "arms");
	assert_eq!(out["first"]["button"], "Arms");
	assert_eq!(out["first"]["revert"], false, "nothing to revert yet");
	assert!(out["first"]["n"].as_u64().unwrap() > 5);
	assert_eq!(out["first"]["sta"], out["default"]);
	assert_eq!(out["edited"]["line"], json!(format!("2 / default {}", out["default"].as_str().unwrap())));
	assert_eq!(out["edited"]["reset"], true);
	assert_eq!(out["edited"]["button"], "Arms (adjusted)");
	assert_eq!(out["edited"]["revert"], true);
	assert_eq!(out["edited"]["sta"], 2);
	assert_eq!(out["kept"], out["keptWant"], "text that is no number puts the old value back");
	assert_eq!(out["back"], true);
	assert_eq!(out["after"], false);
}

#[test]
fn revert_to_default_asks_for_a_second_click_then_puts_every_weight_back_add_a_stat_weighs_a_new_one() {
	let out = run_view(
		r#"
		UI.ShowAdjust("fury")
		type_(line("Stamina"), "3")
		type_(line("Strength"), "4")
		local items
		Polestar.Widgets.ShowMenu = function(anchor, list) items = list end
		V.frame.Add:Click()
		local fire
		for _, it in ipairs(items) do if it.text == "Fire spell damage" then fire = it end end
		fire.onClick()
		local added = line("Fire spell damage") and line("Fire spell damage").Box:GetText()
		local count = A.Count("WARRIOR", "fury")
		V.frame.Revert:Click()
		local armed = { label = V.frame.Revert.Label:GetText(), count = A.Count("WARRIOR", "fury") }
		V.frame.Revert:Click()
		emit({ spec = V.spec, added = added, count = count, armed = armed, after = A.Count("WARRIOR", "fury"), revert = V.frame.Revert:IsShown(),
			status = V.frame.Status:GetText(), fire = line("Fire spell damage") == nil, arms = A.Count("WARRIOR", "arms") })
	"#,
	);
	assert_eq!(out["spec"], "fury");
	assert_eq!(out["added"], "1");
	assert_eq!(out["count"], 3);
	assert_eq!(out["armed"], json!({ "label": "Click again to confirm", "count": 3 }), "the first click only asks");
	assert_eq!(out["after"], 0);
	assert_eq!(out["revert"], false);
	assert_eq!(out["status"], "Put back 3 weights.");
	assert_eq!(out["fire"], true, "an added stat goes with the rest");
	assert_eq!(out["arms"], 0);
}

#[test]
fn the_spec_menu_switches_spec_and_names_the_adjusted_ones_and_the_command_opens_the_window() {
	let out = run_view(
		r#"
		A.Set("WARRIOR", "protection", "sta", 5)
		SlashCmdList.POLESTAR("gear adjust")
		local opened = V.frame:IsShown() and V.spec
		local items
		Polestar.Widgets.ShowMenu = function(anchor, list) items = list end
		V.frame.Spec:Click()
		local names = {}
		for _, it in ipairs(items) do names[#names + 1] = it.text end
		items[3].onClick()
		emit({ opened = opened, names = names, spec = V.spec, line = line("Stamina").Box:GetText(), reset = line("Stamina").Reset:IsShown() })
	"#,
	);
	assert_eq!(out["opened"], "arms");
	assert_eq!(out["names"], json!(["Arms", "Fury", "Protection (tank) (adjusted)"]));
	assert_eq!(out["spec"], "protection");
	assert_eq!(out["line"], "5");
	assert_eq!(out["reset"], true);
}
