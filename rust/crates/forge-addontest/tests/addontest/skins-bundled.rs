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

// The arrow's lines are drawn over the 3D world, never on a skin's ground. Vellum's dark ink vanished there over a
// night zone (its label read at 1.1:1); on a light skin Polestar draws them in the skin's paper, outlined and
// shadowed in its ink. Every bundled skin's distance and label read at 7:1 on a night zone (#16191f, a dark zone's
// ground as the renders show it), its secondary line at 4.5:1, and the shadow is darker than the text.
#[test]
fn every_bundled_skin_s_arrow_text_reads_over_a_night_zone() {
	let list = SKINS.iter().map(|(id, _, _)| format!("{id:?}")).collect::<Vec<_>>().join(", ");
	let script = format!(
		r#"
local T, N = Polestar.Theme, Polestar.Nav
local A = N.arrow
local out = {{}}
local function rgb(fs) local r, g, b = fs:GetTextColor(); return {{ r, g, b }} end
local NIGHT = {{ 0x16 / 255, 0x19 / 255, 0x1f / 255 }}
local function ratio(c) return math.floor(T.Contrast(c, NIGHT) * 10 + 0.5) / 10 end
for _, id in ipairs({{ "polestar", {list} }}) do
	Polestar.Set("ui.skin", id)
	N.SetTarget(1429, 30, 30, "Somewhere")
	stub.advance(1.1)
	local sr, sg, sb = A.distText:GetShadowColor()
	out[id] = {{ inUse = T.SkinId() == id, distance = ratio(rgb(A.distText)), label = ratio(rgb(A.labelText)), eta = ratio(rgb(A.etaText)),
		shadowDarker = T.Luminance(sr, sg, sb) < T.Luminance(unpack(rgb(A.distText))) }}
	N.ReleaseTarget()
end
emit(out)
"#
	);
	let mut addons = vec![Addon::name("Polestar")];
	addons.extend(SKINS.iter().map(|(_, addon, _)| Addon::name(addon)));
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons, login: true, script, ..Default::default() }).remove(0);
	for id in std::iter::once("polestar").chain(SKINS.iter().map(|(id, _, _)| *id)) {
		let s = &out[id];
		let n = |k: &str| s[k].as_f64().unwrap();
		assert_eq!(s["inUse"], true, "{id}: in use");
		assert!(n("distance") >= 7.0 && n("label") >= 7.0, "{id}: the distance and label read on a night zone: {s}");
		assert!(n("eta") >= 4.5, "{id}: the secondary line too: {s}");
		assert_eq!(s["shadowDarker"], true, "{id}: the shadow under the text is darker than it");
	}
}

// Vellum's check boxes are printed boxes: ruled in its ink on the paper, not the grey square Polestar's own fill of
// shade drew there. The box's inside stays clear: its ground lies over the tick, and a light one paled the tick to a
// faint pink, so a done goal read as barely ticked. The tick is the sealing-wax accent at full strength.
#[test]
fn vellum_s_check_boxes_are_ruled_in_ink_on_the_paper_with_the_tick_whole() {
	let script = r#"
local T = Polestar.Theme
Polestar.Set("ui.skin", "vellum")
local c = Polestar.Widgets.Checkbox(UIParent)
c:SetChecked(true)
local box = c.psSkin.box
local function hex(r, g, b) return string.format("%02x%02x%02x", math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5)) end
local function piece(t) local r, g, b, a = t:GetVertexColor(); return { hex(r, g, b), math.floor((a or 1) * 100 + 0.5) } end
emit({ inUse = T.SkinId() == "vellum", fill = piece(box.psSkin.bg)[2], edge = piece(box.psBorder[1]), tick = piece(c.psSkin.check),
	accent = hex(T.Accent()) })
"#;
	let addons = vec![Addon::name("Polestar"), Addon::name("Polestar_Skin_Vellum")];
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons, login: true, script: script.into(), ..Default::default() }).remove(0);
	assert_eq!(out["inUse"], true);
	assert_eq!(out["fill"], 0, "nothing over the tick inside the box");
	assert_eq!(out["edge"], serde_json::json!(["3a2a1a", 85]), "ruled in the ink");
	assert_eq!(out["tick"], serde_json::json!([out["accent"], 100]), "the tick in the accent, whole");
}

// Aurora's active tab stood in the aurora's ribbons, its teal line lost in them: with the band showing, the night
// is drawn over the light behind the active tab (the sky at 60 %, the aurora there at two fifths) and its line is a
// paler accent; without the band the tab keeps Polestar's own wash.
#[test]
fn aurora_s_active_tab_dims_the_aurora_behind_it_and_pales_its_line() {
	let script = r#"
local T = Polestar.Theme
Polestar.Set("ui.shown", true)
Polestar.Set("ui.skin", "aurora")
Polestar.UI.GuideFrame.Layout()
stub.advance(1)
local function hex(t)
	local r, g, b, a = t:GetVertexColor()
	local function h(x) return math.floor(x * 255 + 0.5) end
	return { string.format("%02x%02x%02x", h(r), h(g), h(b)), math.floor(a * 100 + 0.5) }
end
local b = CreateFrame("Button", nil, UIParent)
local parts = { selected = b:CreateTexture(), bar = b:CreateTexture() }
parts.selected:SetVertexColor(1, 1, 1, 0.1)
T.SkinHook("guideTab", b, parts, true)
local out = { inUse = T.SkinId() == "aurora", selected = hex(parts.selected), bar = hex(parts.bar), sky = hex(select(1, (function()
	local t = b:CreateTexture(); t:SetVertexColor(T.Color("sky")); return t end)())) }
Polestar.Set("ui.band", false)
parts.selected:SetVertexColor(1, 1, 1, 0.1)
T.SkinHook("guideTab", b, parts, true)
out.noBand = hex(parts.selected)
emit(out)
"#;
	let addons = vec![Addon::name("Polestar"), Addon::name("Polestar_Skin_Aurora")];
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons, login: true, script: script.into(), ..Default::default() }).remove(0);
	assert_eq!(out["inUse"], true);
	assert_eq!(out["selected"][0], out["sky"][0], "the band's night over the aurora behind the tab");
	assert_eq!(out["selected"][1], 60, "at 60 %: the aurora there at two fifths");
	// The accent #45f2c7 seven tenths of the way to white.
	assert_eq!(out["bar"], serde_json::json!(["c7fbee", 100]), "a paler accent line");
	assert_eq!(out["noBand"], serde_json::json!(["ffffff", 10]), "no band, no night drawn over it");
}

// Menus and popups open over other frames (a panel marked psMenu: the dropdown menu, a setting's cog, Quick
// settings) and the settings window's tooltip are never see-through, in every look the picker lists (the six built
// in and each bundled skin, in each variant): their ground (menuBg) is at least 0.97 opaque, fully solid in the six
// built in (Halo's and Hearth's were 0.97), and the menu draws it (the house fill under every painter that builds on
// it, the game looks' ground under their art, Lanterns' rounded ground). Text under a menu used to show through in
// WoW Forever, Blizzard, Classic, Lumen, Hairline, Lanterns and Sheen.
#[test]
fn menus_popups_and_the_tooltip_are_never_see_through_in_any_look_or_variant() {
	let script = r#"
local T, W = Polestar.Theme, Polestar.Widgets
T._testShowHidden = true
local host = CreateFrame("Frame", nil, UIParent)
host:SetSize(120, 24)
host:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
local function alphaOf(t)
	if not (t and t:IsShown()) then return 0 end
	local _, _, _, a = t:GetVertexColor()
	return (a or 1) * t:GetAlpha()
end
-- The most opaque ground the frame draws: the house fill, or the skin's own (Vellum's paper,
-- Lanterns' rounded ground; a registered skin keeps its pieces under psSkin.kit.api[id]).
local function ground(f)
	local d = f.psSkin or {}
	local best = alphaOf(d.bg)
	local own = d.kit and d.kit.api and d.kit.api[T.SkinId()] or {}
	best = math.max(best, alphaOf(own.paper))
	for _, t in ipairs(own.ground or {}) do best = math.max(best, alphaOf(t)) end
	return best
end
local out = {}
for _, c in ipairs(T.SkinChoices()) do
	local runs = T.SkinVariants(c.value) or { false }
	for _, v in ipairs(runs) do
		if v then Polestar.Set("ui.skinVariants." .. c.value, v.id) end
		Polestar.Set("ui.skin", c.value)
		W.ShowMenu(host, { { text = "One" }, { text = "Two" } })
		W.Tip(host, "Title", { "A line" })
		stub.advance(1)
		local _, _, _, token = T.Color("menuBg")
		out[#out + 1] = { key = c.value .. (v and ("/" .. v.id) or ""), inUse = T.SkinId() == c.value, token = token,
			menu = ground(PolestarMenu), tip = alphaOf(PolestarTip.Ground) }
		W.HideMenu()
		W.TipHide(host)
	end
end
emit(out)
"#;
	let mut addons = vec![Addon::name("Polestar"), Addon::name("Polestar_Looks")];
	addons.extend(SKINS.iter().map(|(_, addon, _)| Addon::name(addon)));
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons, login: true, script: script.to_string(), ..Default::default() }).remove(0);
	let looks = out.as_array().unwrap();
	let runs: usize = 6 + SKINS.iter().map(|(_, _, v)| v.len().max(1)).sum::<usize>();
	assert_eq!(looks.len(), runs, "every look and variant: {out}");
	for l in looks {
		let key = l["key"].as_str().unwrap();
		assert_eq!(l["inUse"], true, "{key}: in use once picked");
		for part in ["token", "menu", "tip"] {
			assert!(l[part].as_f64().unwrap() >= 0.97, "{key}: the {part} ground is see-through: {l}");
		}
		if ["polestar", "halo", "hearth", "forever", "blizzard", "classic"].contains(&key) {
			assert_eq!(l["token"].as_f64().unwrap(), 1.0, "{key}: a built-in look's menus are fully solid: {l}");
		}
	}
}

// The guide list's star on the zone painting keeps a dark ground under its glyphs: the star and the window's close in
// the house look and Halo (68 wide), the star alone in the game looks, whose close is the frame's own on its corner
// (36 wide, on the star): the ground used to run on under nothing where the close had been.
#[test]
fn the_guide_list_s_star_ground_holds_only_the_glyphs_it_backs() {
	let script = r#"
local out = {}
for _, id in ipairs({ "polestar", "halo", "forever", "blizzard", "classic" }) do
	Polestar.Set("ui.skin", id)
	Polestar.UI.ShowPicker()
	stub.advance(0.5)
	local d = Polestar.UI.Picker.details
	local _, rel = d.Scrim:GetPoint(1)
	out[id] = { width = d.Scrim:GetWidth(), on = rel == d.Star and "star" or rel == PolestarPicker.Close and "close" or "other",
		close = PolestarPicker.Close:IsShown() }
end
emit(out)
"#;
	let addons = vec![Addon::name("Polestar"), Addon::name("Polestar_Looks")];
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons, login: true, script: script.into(), ..Default::default() }).remove(0);
	for id in ["polestar", "halo"] {
		assert_eq!(out[id], serde_json::json!({ "width": 68, "on": "close", "close": true }), "{id}: the star and the close: {out}");
	}
	for id in ["forever", "blizzard", "classic"] {
		assert_eq!(out[id], serde_json::json!({ "width": 36, "on": "star", "close": false }), "{id}: the star alone: {out}");
	}
}
