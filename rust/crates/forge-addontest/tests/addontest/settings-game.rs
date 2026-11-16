//! Quality of Life > Game (Polestar_Options/QoL/Options.lua): "Increase game image quality" is the game's own
//! setting, the client CVar ResampleAlwaysSharpen, with no Polestar setting behind it. The row shows the client's
//! value and writes it only when the player clicks it: never at login, on a profile switch, a reset, a right-click
//! or an import. In combat the click's write waits for the fight to end; a client without the CVar has no row (the
//! section's other rows, second homes of the client options on Quests, stay). A search for its words finds it first.
//! The whole addon over stub_world.lua, its CVar writes counted from before it loads.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const LABEL: &str = "Increase game image quality";

// The client's writes of the CVar, counted (`writes`), from before the addon loads; `before` first (a client
// without the CVar).
fn run(before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!(
			r#"{before}
writes = {{}}
local set = SetCVar
SetCVar = function(k, v)
	if k == "ResampleAlwaysSharpen" then writes[#writes + 1] = tostring(v) end
	return set(k, v)
end"#
		),
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: format!(
			r#"stub.advance(1)
assert(Polestar.UI.LoadOptions())
local UI, O, P = Polestar.UI, Polestar.UI.Options, Polestar.Profiles
local LABEL = "{LABEL}"
-- The row on Quality of Life > Game, its tab open (nil: not drawn).
local function row()
	UI.ShowOptions("qualityoflife")
	O.Select("qualityoflife", "Game")
	return O.Controls("qualityoflife", "Game")[LABEL]
end
{script}"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn login_profiles_resets_a_right_click_and_an_import_never_write_the_game_s_sharpening() {
	let out = run(
		r#"stub.cvars.ResampleAlwaysSharpen = "1""#,
		r#"
		local login = #writes
		local r = row()
		local shown = { r ~= nil and r:IsShown(), r ~= nil and r.checked }
		-- Profiles: a new one at the defaults, switched to and back; the page and every setting reset.
		P.New("Fresh")
		P.Switch("Fresh")
		P.Switch(P.List()[1])
		r = row()
		local reset = false
		for _, side in ipairs({ "left", "right" }) do
			for _, b in ipairs(PolestarOptions.footerButtons[side]) do
				if b:IsShown() and b.Label:GetText() == "Reset page" then
					b:Click()
					PolestarModal.Box.Action:Click()
					reset = true
				end
			end
		end
		Polestar.ResetSettings()
		-- A right-click on the row (back to its default).
		r = row()
		r:GetScript("OnClick")(r, "RightButton")
		-- A profile string out and in.
		local s = P.Export()
		P.Apply(P.Import(s), P.Active())
		stub.advance(1)
		emit({ login = login, shown = shown, reset = reset, writes = #writes, cvar = GetCVar("ResampleAlwaysSharpen"),
			exported = s:find("Resample", 1, true) == nil })"#,
	);
	assert_eq!(out, json!({ "login": 0, "shown": [true, true], "reset": true, "writes": 0, "cvar": "1", "exported": true }), "the player's own value, untouched");
}

#[test]
fn a_click_writes_it_at_once_and_in_combat_once_the_fight_ends() {
	let out = run(
		"",
		r#"
		local r = row()
		local was = { GetCVar("ResampleAlwaysSharpen"), r.checked }
		r:Click()
		local on = { GetCVar("ResampleAlwaysSharpen"), r.checked }
		stub.inCombat = true
		r:Click()
		local fighting = { GetCVar("ResampleAlwaysSharpen"), r.checked }
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		emit({ was = was, on = on, fighting = fighting, after = GetCVar("ResampleAlwaysSharpen"), writes = writes })"#,
	);
	assert_eq!(out["was"], json!(["0", false]));
	assert_eq!(out["on"], json!(["1", true]));
	assert_eq!(out["fighting"], json!(["1", false]), "in combat it waits, the switch showing the choice");
	assert_eq!(out["after"], "0");
	assert_eq!(out["writes"], json!(["1", "0"]));
}

#[test]
fn a_client_without_the_cvar_has_no_row_and_the_section_keeps_its_other_rows() {
	let out = run(
		"stub.cvars.ResampleAlwaysSharpen = nil",
		r#"
		local found = false
		for _, c in ipairs(O.AllControls()) do
			if c.label == LABEL and (not c.needs or c.needs()) then found = true end
		end
		local r = row()
		local shown = O.Controls("qualityoflife", "Game")
		emit({ row = r ~= nil, available = found, others = { shown["qol.instantQuestText"] ~= nil, shown["qol.hideErrors"] ~= nil,
			shown["qol.hideQuestTracker"] ~= nil }, writes = #writes })"#,
	);
	assert_eq!(out, json!({ "row": false, "available": false, "others": [true, true, true], "writes": 0 }));
}

#[test]
fn a_search_for_its_words_lands_on_its_section_first() {
	let out = run(
		"",
		r#"
		local out = {}
		for _, q in ipairs({ "sharpen", "image quality", "blurry", "render scale", "fsr" }) do
			local first = (O.Search(q))[1]
			out[q] = first and { first.title, first.controls[1] and first.controls[1].label or false } or false
		end
		emit(out)"#,
	);
	for q in ["sharpen", "image quality", "blurry", "render scale", "fsr"] {
		assert_eq!(out[q][1], LABEL, "{q}: {out}");
		assert!(out[q][0].as_str().unwrap().starts_with("Quality of Life  \u{b7}  Game"), "{q}: {out}");
	}
}
