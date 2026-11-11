//! The skins in the download (addon/Polestar_Skin_*, forge_release::addons::SKIN_ADDONS): each registers
//! through the Skin API with nothing refused and nothing corrected (its
//! colours legible as given), is listed in the picker with its addon, and paints the whole addon (the guide
//! window, its progress and title, the arrow, the pins, the toasts) in every variant it has without its
//! painters or hooks raising: a skin that raised would be switched off for the session.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

// Each skin's id, its addon, and its variants (none: the skin alone).
const SKINS: &[(&str, &str, &[&str])] = &[
	("vellum", "Polestar_Skin_Vellum", &[]),
	("lumen", "Polestar_Skin_Lumen", &[]),
	("beacon", "Polestar_Skin_Beacon", &[]),
	("aurora", "Polestar_Skin_Aurora", &[]),
];

fn run() -> Value {
	let list = SKINS
		.iter()
		.map(|(id, addon, variants)| {
			let v = variants.iter().map(|v| format!("{v:?}")).collect::<Vec<_>>().join(", ");
			format!("{{ id = {id:?}, addon = {addon:?}, variants = {{ {v} }} }}")
		})
		.collect::<Vec<_>>()
		.join(",\n");
	let script = format!(
		r#"
local T = Polestar.Theme
local SKINS = {{ {list} }}
local out = {{ notes = {{}}, skins = {{}} }}
-- What the registrations said: a refusal, or grounds corrected for legibility.
for _, l in ipairs(Polestar.DebugLog(800)) do
	if tostring(l):find("(Polestar_Skin_", 1, true) then out.notes[#out.notes + 1] = tostring(l) end
end
local listed = {{}}
for _, c in ipairs(T.SkinChoices()) do listed[c.value] = c.addon or false end
Polestar.Set("ui.shown", true)
local function paint()
	Polestar.UI.GuideFrame.Layout()
	if Polestar.Nav and Polestar.Nav.alerts and Polestar.Nav.alerts.ShowSample then Polestar.Nav.alerts.ShowSample() end
	stub.advance(1)
end
for _, s in ipairs(SKINS) do
	local runs = #s.variants > 0 and s.variants or {{ false }}
	for _, v in ipairs(runs) do
		if v then Polestar.Set("ui.skinVariants." .. s.id, v) end
		Polestar.Set("ui.skin", s.id)
		paint()
		local info = T.SkinInfo(s.id)
		out.skins[#out.skins + 1] = {{
			key = s.id .. (v and ("/" .. v) or ""),
			listed = listed[s.id] or false,
			inUse = T.SkinId() == s.id,
			failed = info and info.failed or false,
			legible = T.Legibility(T.Palette()) >= 1,
		}}
	end
	Polestar.Set("ui.skin", "polestar")
	paint()
end
emit(out)
"#
	);
	let mut addons = vec![Addon::name("Polestar")];
	addons.extend(SKINS.iter().map(|(_, addon, _)| Addon::name(addon)));
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons, login: true, script, ..Default::default() }).remove(0)
}

#[test]
fn every_bundled_skin_registers_as_given_and_paints_polestar_in_each_variant_without_raising() {
	let out = run();
	// An empty Lua table comes back as {} or [].
	let notes = &out["notes"];
	assert!(notes.as_array().is_some_and(|a| a.is_empty()) || notes.as_object().is_some_and(|o| o.is_empty()), "nothing refused or corrected: {notes}");
	let skins = out["skins"].as_array().unwrap();
	let runs: usize = SKINS.iter().map(|(_, _, v)| v.len().max(1)).sum();
	assert_eq!(skins.len(), runs);
	for s in skins {
		let key = s["key"].as_str().unwrap();
		let id = key.split('/').next().unwrap();
		let addon = SKINS.iter().find(|(i, _, _)| *i == id).unwrap().1;
		assert_eq!(s["listed"], addon, "{key}: in the picker with its addon");
		assert_eq!(s["inUse"], true, "{key}: in use once picked");
		assert_eq!(s["failed"], false, "{key}: a painter or hook raised");
		assert_eq!(s["legible"], true, "{key}: legible as painted");
	}
}

// Aurora's own light (Polestar_Skin_Aurora/Media): the aurora over the guide window's band, flipped when the bars
// sit at the window's foot, the veil on a window with no band (the transport banner), and both put away by the
// transparent style and by another skin.
#[test]
fn aurora_lays_its_aurora_over_the_band_the_veil_on_other_windows_and_puts_both_away() {
	let script = r#"
local T = Polestar.Theme
Polestar.Set("ui.shown", true)
Polestar.Set("ui.skin", "aurora")
local function layout() Polestar.UI.GuideFrame.Layout(); stub.advance(1) end
layout()
local P = T.GuideParts()
local own = T.SkinKit.store(P.window)
local function on(t) return t ~= nil and t:IsShown() end
local function tex(t) return t and (t:GetTexture() or ""):match("([^\\]+)$") or false end
local out = { inUse = T.SkinId() == "aurora" }
-- The texture's top coordinate as set (SetTexCoord(left, right, top, bottom)): 1 is the picture upside down.
local function top(t) return t and t.texCoord and t.texCoord[3] or false end
out.band = { curtain = on(own.curtain), tex = tex(own.curtain), veil = on(own.veil), top = top(own.curtain) }
Polestar.Set("ui.growUp", true)
Polestar.Set("ui.barsBottom", true)
layout()
out.foot = { curtain = on(own.curtain), top = top(own.curtain) }
Polestar.Set("ui.barsBottom", nil)
Polestar.Set("ui.growUp", nil)
layout()
Polestar.Nav.alerts.ShowSample()
stub.advance(1)
local a = T.SkinKit.store(PolestarAlert)
out.toast = { veil = on(a.veil), tex = tex(a.veil), curtain = on(a.curtain) }
Polestar.Set("ui.style", "transparent")
layout()
out.bare = { curtain = on(own.curtain), veil = on(own.veil), progress = on(own.progress), rule = on(own.ruleLine) }
Polestar.Set("ui.style", nil)
layout()
out.back = on(own.curtain)
Polestar.Set("ui.skin", "polestar")
layout()
out.other = { curtain = on(own.curtain), veil = on(own.veil), toast = on(a.veil) }
emit(out)
"#;
	let addons = vec![Addon::name("Polestar"), Addon::name("Polestar_Skin_Aurora")];
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons, login: true, script: script.into(), ..Default::default() }).remove(0);
	assert_eq!(out["inUse"], true);
	assert_eq!(out["band"], serde_json::json!({ "curtain": true, "tex": "curtain", "veil": false, "top": 0 }), "the aurora over the band, not the veil");
	assert_eq!(out["foot"], serde_json::json!({ "curtain": true, "top": 1 }), "flipped with the bars at the foot");
	assert_eq!(out["toast"], serde_json::json!({ "veil": true, "tex": "veil", "curtain": false }), "a window with no band takes the veil");
	assert_eq!(out["bare"], serde_json::json!({ "curtain": false, "veil": false, "progress": false, "rule": false }), "the transparent style puts it all away");
	assert_eq!(out["back"], true, "back in the standard style, the aurora is back");
	assert_eq!(out["other"], serde_json::json!({ "curtain": false, "veil": false, "toast": false }), "another skin hides every piece");
}
