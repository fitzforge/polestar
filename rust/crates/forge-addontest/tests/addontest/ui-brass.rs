//! The Muted brass skin ("brass", Theme.lua "Skins"): a selectable look beside the house style, Halo, Hearth and
//! the game's looks. Polestar's square window and controls in warm brown-black with one brass accent, Inter, the
//! tight step cards, a title bar with a small red close square. Tokens resolve, text holds the DESIGN.md floors on
//! every ground, the window draws no shadow, transparent keeps its bare window, and the other skins are as they were.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", FILES)],
		script: format!("uistub.install()\nstub.login()\nlocal T = Polestar.Theme\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn round(list: &Value) -> Vec<f64> {
	list.as_array().unwrap().iter().map(|v| (v.as_f64().unwrap() * 1000.0).round() / 1000.0).collect()
}

fn lin(c: f64) -> f64 {
	if c <= 0.04045 {
		c / 12.92
	} else {
		((c + 0.055) / 1.055).powf(2.4)
	}
}

fn lum(v: &Value) -> f64 {
	let c = |i: usize| v[i].as_f64().unwrap();
	0.2126 * lin(c(0)) + 0.7152 * lin(c(1)) + 0.0722 * lin(c(2))
}

fn contrast(a: &Value, b: &Value) -> f64 {
	let (p, q) = (lum(a), lum(b));
	let (x, y) = if p >= q { (p, q) } else { (q, p) };
	(x + 0.05) / (y + 0.05)
}

#[test]
fn brass_is_a_selectable_skin_with_its_tokens_font_and_card_look_and_the_other_skins_are_unchanged() {
	let out = run(r#"
		local function c(name) return { T.Color(name) } end
		local out = { choices = {}, house = { key = T.SkinKey(), accent = c("accent"), card = T.Metric("guideCard", 1), game = T.GameSkin() } }
		for i, ch in ipairs(T.SkinChoices()) do out.choices[i] = ch.value end
		out.order = T.SKIN_ORDER
		Polestar.Set("ui.skin", "halo")
		out.halo = { accent = c("accent"), card = T.Metric("guideCard", 1), game = T.GameSkin(), row = T.Metric("row", 40) }
		Polestar.Set("ui.skin", "hearth")
		out.hearth = { accent = c("accent"), card = T.Metric("guideCard", 1), game = T.GameSkin(), row = T.Metric("row", 40), font = (T.FontSpec("body")) }
		Polestar.Set("ui.skin", "brass")
		out.brass = { key = T.SkinKey(), game = T.GameSkin(), card = T.Metric("guideCard", 1), row = T.Metric("row", 40), button = T.Metric("buttonH", 28),
			font = (T.FontSpec("body")), hero = select(2, T.FontSpec("hero")), icon = T.Icon("bug"),
			bg = c("bg"), panel = c("panel"), panelAlt = c("panelAlt"), sky = c("sky"), skyBottom = c("skyBottom"), border = c("border"),
			windowBorder = c("windowBorder"), accent = c("accent"), quest = c("quest"), npc = c("npc"), item = c("item"),
			text = c("text"), textDim = c("textDim"), textMuted = c("textMuted"), closeFill = c("closeFill"), closeEdge = c("closeEdge"),
			onAccent = c("onAccent"), arrow = c("arrow"), skin = T.Palette().skin }
		Polestar.Set("ui.accent", { 0.2, 0.6, 1 })
		out.ownAccent = c("accent")
		Polestar.Set("ui.accent", nil)
		Polestar.Set("ui.skin", "polestar")
		out.back = { key = T.SkinKey(), accent = c("accent"), card = T.Metric("guideCard", 1) }
		emit(out)"#);
	let all = json!(["polestar", "halo", "hearth", "forever", "blizzard", "classic", "brass"]);
	assert_eq!(out["choices"], all, "the picker lists it, last");
	assert_eq!(out["order"], all);
	assert_eq!(out["house"]["key"], "polestar");
	assert_eq!(round(&out["house"]["accent"]), vec![0.9, 0.73, 0.4, 1.0], "the house gold is unchanged");
	assert_eq!(out["house"]["card"], 1);
	assert_eq!(out["halo"]["card"], 0, "Halo keeps its rows");
	assert_eq!(round(&out["halo"]["accent"]), vec![1.0, 0.82, 0.0, 1.0]);
	assert_eq!(out["halo"]["row"], 34);
	assert_eq!(out["hearth"]["card"], 0, "Hearth keeps its rows");
	assert_eq!(out["hearth"]["game"], true);
	assert_eq!(out["hearth"]["row"], 28);
	assert_eq!(out["hearth"]["font"], "Fonts\\FRIZQT__.TTF");
	assert_eq!(out["back"], json!({ "key": "polestar", "accent": out["house"]["accent"].clone(), "card": 1 }), "back to the house style");
	let b = &out["brass"];
	assert_eq!(b["key"], "brass");
	assert_eq!(b["skin"], "brass");
	assert_eq!(b["game"], false, "Polestar's own controls, not the client's");
	assert_eq!(b["card"], 1, "the tight step cards");
	assert_eq!(b["row"], 40, "the house sizes");
	assert_eq!(b["button"], 28);
	assert_eq!(b["font"], "Interface\\AddOns\\Polestar\\Media\\Fonts\\Inter-Medium.ttf", "sans, no serif");
	assert_eq!(b["hero"], 26);
	assert_eq!(b["icon"], "bug", "the house glyphs");
	assert_eq!(round(&b["bg"]), vec![0.09, 0.067, 0.047, 0.97], "#17110C");
	assert_eq!(round(&b["panel"]), vec![0.071, 0.051, 0.035, 1.0], "#120D09");
	assert_eq!(round(&b["sky"]), vec![0.165, 0.122, 0.078, 1.0], "#2A1F14, the title bar's top");
	assert_eq!(round(&b["skyBottom"]), vec![0.114, 0.082, 0.051, 1.0], "#1D150D");
	assert_eq!(round(&b["windowBorder"]), vec![0.369, 0.29, 0.173, 1.0], "the bronze frame #5E4A2C");
	assert_eq!(round(&b["accent"]), vec![0.725, 0.604, 0.345, 1.0], "the brass #B99A58");
	assert_eq!(round(&b["arrow"]), round(&b["accent"]), "the arrow follows the accent");
	assert_eq!(round(&b["quest"]), vec![0.788, 0.678, 0.431, 1.0], "quest names #C9AD6E");
	assert_eq!(round(&b["npc"]), vec![0.557, 0.757, 1.0, 1.0], "#8EC1FF");
	assert_eq!(round(&b["item"]), vec![0.718, 0.612, 0.941, 1.0], "#B79CF0");
	assert_eq!(round(&b["closeFill"]), vec![0.612, 0.129, 0.114, 1.0], "the red close square #9C211D");
	assert_eq!(round(&b["closeEdge"]), vec![0.302, 0.055, 0.047, 1.0], "#4D0E0C");
	assert_eq!(round(&out["ownAccent"])[..3], [0.2, 0.6, 1.0], "your own accent still wins");
}

#[test]
fn brass_holds_the_legibility_floors_on_every_ground_the_selected_row_and_under_the_accent() {
	let out = run(r#"
		Polestar.Set("ui.skin", "brass")
		local P = T.Palette()
		local out = { pal = {}, lightest = T.LightestGround() }
		for _, k in ipairs({ "bg", "panel", "panelAlt", "sidebar", "footer", "sky", "text", "textDim", "textMuted", "accent", "onAccent",
			"quest", "npc", "item", "place", "object", "level", "skill", "spell", "faction", "area", "achievement", "dungeon", "rare",
			"success", "warning", "danger", "personName", "link", "closeFill", "closeGlyph", "chip", "inputBg" }) do
			out.pal[k] = { P[k][1], P[k][2], P[k][3] }
		end
		out.legibility = T.Legibility(P)
		emit(out)"#);
	let pal = &out["pal"];
	let mut grounds: Vec<(&str, Value)> = ["bg", "panel", "panelAlt", "sidebar", "footer", "sky"].iter().map(|g| (*g, pal[*g].clone())).collect();
	grounds.push(("selected row", out["lightest"].clone()));
	grounds.push(("card chip", pal["chip"].clone()));
	for (name, g) in &grounds {
		let t = contrast(&pal["text"], g);
		assert!(t >= 7.0, "text on {name} is {t:.2}:1");
		for role in ["textDim", "textMuted"] {
			let c = contrast(&pal[role], g);
			assert!(c >= 4.5, "{role} on {name} is {c:.2}:1");
		}
		if *name == "sky" {
			continue;
		}
		for role in ["accent", "quest", "npc", "item", "place", "object", "level", "skill", "spell", "faction", "area", "achievement", "dungeon", "rare", "success", "warning", "danger", "personName", "link"] {
			let c = contrast(&pal[role], g);
			assert!(c >= 4.5, "{role} on {name} is {c:.2}:1");
		}
	}
	let on = contrast(&pal["onAccent"], &pal["accent"]);
	assert!(on >= 4.5, "label on the brass is {on:.2}:1");
	let x = contrast(&pal["closeGlyph"], &pal["closeFill"]);
	assert!(x >= 4.5, "the close glyph on its red is {x:.2}:1");
	assert!(out["legibility"].as_f64().unwrap() >= 1.0, "Theme.Legibility holds: {}", out["legibility"]);
}

#[test]
fn brass_window_has_the_bronze_frame_and_no_shadow_the_title_bar_and_close_square_go_in_transparent_and_other_skins() {
	let out = run(r#"
		Polestar.UI.ShowOptions()
		local f = PolestarOptions
		local function state()
			local d = f.psSkin
			return { bg = d.bg ~= nil and d.bg:IsShown(), border = f.psBorder ~= nil and f.psBorder[1]:IsShown(), shadow = f.psShadow ~= nil and f.psShadow:IsShown() }
		end
		local out = { house = state() }
		Polestar.Set("ui.skin", "brass")
		out.brass = state()
		local r, g, b = f.psBorder[1]:GetVertexColor()
		out.edge = { r, g, b }
		Polestar.Set("ui.skin", "polestar")
		out.back = state()
		-- The guide window's title bar and close square.
		local GF = Polestar.UI.GuideFrame
		local nav = GF.parts.nav
		local function bar() return { title = nav.TitleBar:IsShown(), close = nav.Close:IsShown() } end
		out.guideHouse = bar()
		Polestar.Set("ui.skin", "brass")
		GF.ApplySkin(); GF.ApplyStyle()
		out.guideBrass = bar()
		Polestar.Set("ui.style", "transparent")
		GF.ApplySkin(); GF.ApplyStyle()
		out.guideClear = bar()
		Polestar.Set("ui.style", "standard")
		Polestar.Set("ui.skin", "halo")
		GF.ApplySkin(); GF.ApplyStyle()
		out.guideHalo = bar()
		Polestar.Set("ui.skin", "brass")
		GF.ApplySkin(); GF.ApplyStyle()
		Polestar.Set("ui.shown", true)
		nav.Close:GetScript("OnClick")(nav.Close)
		out.shown = Polestar.Get("ui.shown")
		emit(out)"#);
	assert_eq!(out["house"], json!({ "bg": true, "border": true, "shadow": true }));
	assert_eq!(out["brass"], json!({ "bg": true, "border": true, "shadow": false }), "the ground and the frame, no drop shadow");
	assert_eq!(round(&out["edge"]), vec![0.369, 0.29, 0.173], "the bronze frame");
	assert_eq!(out["back"], out["house"], "back to the house style, as it was");
	assert_eq!(out["guideHouse"], json!({ "title": false, "close": false }));
	assert_eq!(out["guideBrass"], json!({ "title": true, "close": true }));
	assert_eq!(out["guideClear"], json!({ "title": false, "close": false }), "transparent draws no bar or square");
	assert_eq!(out["guideHalo"], json!({ "title": false, "close": false }));
	assert_eq!(out["shown"], false, "the red square hides the window as the menu's Hide window does");
}

// Every colour token the menu and options builders read (Widgets.lua, Options.lua: rows, rail, sidebar, tabs,
// footer, search, dropdowns, sliders, toggles) is a value brass names itself, never the text-colour fallback that
// Theme.Color gives an unknown name, and the labels read on the grounds those windows use.
#[test]
fn brass_names_every_token_the_menu_and_options_read_and_their_labels_read_on_the_menu_grounds() {
	let tokens = [
		"accent", "arrow", "arrowNear", "bg", "border", "buttonText", "chip", "danger", "divider", "footer", "hover", "icon", "iconHover",
		"navRest", "npc", "onAccent", "place", "progress", "rowLabel", "scrim", "selected", "sky", "success", "swatch", "tabRest", "text",
		"textDim", "textMuted", "title", "toggle", "track", "warning", "watermark", "windowBorder", "panel", "panelAlt", "sidebar", "shade",
		"ink", "inputBg", "control", "box", "thumb", "separator", "accentLine", "padSelect", "chipAccent", "textOff", "menuBg", "mover",
	];
	let list = tokens.iter().map(|t| format!("\"{t}\"")).collect::<Vec<_>>().join(", ");
	let out = run(&format!(
		r#"
		Polestar.Set("ui.skin", "brass")
		local P = T.Palette()
		local out = {{ missing = {{}}, pal = {{}} }}
		for _, k in ipairs({{ {list} }}) do
			if P[k] == nil then out.missing[#out.missing + 1] = k else out.pal[k] = {{ P[k][1], P[k][2], P[k][3], P[k][4] }} end
		end
		out.lightest = T.LightestGround()
		-- The options window's ground at the default and a low ground opacity, brass and the house style.
		Polestar.UI.ShowOptions()
		local f = PolestarOptions
		local function alpha() local _, _, _, a = f.psSkin.bg:GetVertexColor() return a end
		out.alpha = {{ brass = alpha() }}
		Polestar.Set("ui.bgOpacity", 0.4)
		out.alpha.brassLow = alpha()
		Polestar.Set("ui.skin", "polestar")
		out.alpha.houseLow = alpha()
		emit(out)"#
	));
	let missing = out["missing"].as_array().map(|a| a.len()).or_else(|| out["missing"].as_object().map(|o| o.len()));
	assert_eq!(missing, Some(0), "tokens brass leaves to the fallback: {}", out["missing"]);
	assert_eq!(out["alpha"]["brass"], 1, "the options window's content ground is solid");
	assert_eq!(out["alpha"]["brassLow"], 1, "and stays solid at a low ground opacity");
	assert!((out["alpha"]["houseLow"].as_f64().unwrap() - 0.4).abs() < 0.001, "the house style still follows the ground opacity");
	let pal = &out["pal"];
	for role in ["rowLabel", "navRest", "tabRest", "buttonText", "icon", "iconHover", "title", "text", "textDim", "textMuted"] {
		for ground in ["panel", "sidebar", "bg", "footer", "panelAlt", "control", "menuBg", "inputBg"] {
			let c = contrast(&pal[role], &pal[ground]);
			assert!(c >= 4.5, "{role} on {ground} is {c:.2}:1");
		}
		let c = contrast(&pal[role], &out["lightest"]);
		assert!(c >= 4.5, "{role} on the selected row is {c:.2}:1");
	}
}

// Forever leaves a string blank after a new font until its text changes (the labels blank on the options window
// after Brass's Inter replaced the game font): a face change sets every string's text again a frame later.
#[test]
fn brass_sets_every_label_again_a_frame_after_the_skin_brings_its_font() {
	let out = run(r#"
		Polestar.UI.ShowOptions("appearance")
		local label
		local function walk(fr)
			for _, r in ipairs({ fr:GetRegions() }) do
				if r.GetObjectType and r:GetObjectType() == "FontString" and r:GetText() == "Map" then label = r end
			end
			for _, c in ipairs({ fr:GetChildren() }) do walk(c) end
		end
		walk(PolestarOptions)
		local sets = 0
		hooksecurefunc(label, "SetText", function() sets = sets + 1 end)
		Polestar.Set("ui.skin", "brass")
		local now = sets
		stub.advance(1)
		emit({ found = label ~= nil, now = now, later = sets - now, font = (label:GetFont()):gsub(".*\\", "") })"#);
	assert_eq!(out["found"], true);
	assert_eq!(out["font"], "Inter-Medium.ttf");
	assert!(out["later"].as_i64().unwrap() >= 2, "set again a frame later: {out}");
}
