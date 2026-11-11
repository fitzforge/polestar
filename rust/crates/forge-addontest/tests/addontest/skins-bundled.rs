//! The skins in the download (addon/Polestar_Skin_*: Vellum, Lumen, Beacon, Aurora, Hairline, Umbra, Waymark,
//! Lanterns, Sheen): each registers through the Skin API with nothing refused and nothing corrected (its
//! colours legible as given), is listed in the picker with its addon, and paints the whole addon (the guide
//! window, its progress and title, the arrow, the pins, the toasts) in every variant it has without its
//! painters or hooks raising: a skin that raised would be switched off for the session.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

const SKINS: &[(&str, &str, &[&str])] = &[
	("vellum", "Polestar_Skin_Vellum", &[]),
	("lumen", "Polestar_Skin_Lumen", &[]),
	("beacon", "Polestar_Skin_Beacon", &[]),
	("aurora", "Polestar_Skin_Aurora", &[]),
	("hairline", "Polestar_Skin_Hairline", &[]),
	("umbra", "Polestar_Skin_Umbra", &["flat", "forever", "blizzard", "classic"]),
	("waymark", "Polestar_Skin_Waymark", &[]),
	("lanterns", "Polestar_Skin_Lanterns", &["forge", "tidepool", "glade", "hoarfrost", "duskrose", "starfall", "ashen", "highsun", "gloam", "plain"]),
	("sheen", "Polestar_Skin_Sheen", &[]),
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
	assert_eq!(out["notes"], serde_json::json!([]), "nothing refused or corrected");
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
