//! The settings window's Theme page (addon/Polestar_Options/UI/Looks/Theme.lua) and the theme-wide looks it sets in
//! Polestar.Theme: text outline and shadow, the heading face and size nudges, the player's own text and name
//! colours (held legible), the panel and sidebar grounds, hairlines, shadow, stars, haze, rim and animation speed.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];
// With Rares, for the preview's rare alert.
fn run_with_rares(script: &str) -> Value {
	run_files(&["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml", "Rares/Rares.xml"], script)
}
const INTER_SEMIBOLD: &str = "Interface\\AddOns\\Polestar\\Media\\Fonts\\Inter-SemiBold.ttf";
const GAME_FONT: &str = "Fonts\\FRIZQT__.TTF";

fn run(script: &str) -> Value {
	run_files(FILES, script)
}

fn run_files(files: &[&str], script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", files)],
		script: format!("uistub.install()\nstub.login()\nPolestar.UI.LoadOptions()\nlocal T, W = Polestar.Theme, Polestar.Widgets\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn n(v: &Value) -> f64 {
	v.as_f64().unwrap()
}

fn rounded(v: &Value) -> Vec<f64> {
	v.as_array().unwrap().iter().map(|x| (n(x) * 1000.0).round() / 1000.0).collect()
}

// WCAG 2 contrast, computed here independently of Theme.Contrast.
fn lin(c: f64) -> f64 {
	if c <= 0.04045 {
		c / 12.92
	} else {
		((c + 0.055) / 1.055).powf(2.4)
	}
}

fn contrast(a: &Value, b: &Value) -> f64 {
	let lum = |v: &Value| 0.2126 * lin(n(&v[0])) + 0.7152 * lin(n(&v[1])) + 0.0722 * lin(n(&v[2]));
	let (p, q) = (lum(a), lum(b));
	let (x, y) = if p >= q { (p, q) } else { (q, p) };
	(x + 0.05) / (y + 0.05)
}

const GROUNDS: [&str; 6] = ["bg", "panel", "panelAlt", "sidebar", "footer", "sky"];

#[test]
fn outline_shadow_heading_face_and_size_nudges_reach_every_w_text_live_and_reset_restores_them() {
	let out = run(r#"
		local body = W.Text(UIParent, "body", "text")
		body:SetText("Hello")
		local heading = W.Text(UIParent, "heading", "text")
		heading:SetText("Title")
		local small = W.Text(UIParent, "small", "textDim")
		local onWorld = W.Text(UIParent, "goal", "text")
		T.SetOutline(onWorld, true)
		local function font(fs) local p, s, f = fs:GetFont() return { p, s, f or "" } end
		local function shadow(fs) return select(4, fs:GetShadowColor()) end
		local out = { before = font(body), beforeShadow = shadow(body), beforeHeading = font(heading), beforeSmall = font(small) }
		Polestar.Set("ui.fontOutline", "outline")
		out.outline = font(body)
		Polestar.Set("ui.fontOutline", "thick")
		out.thick, out.thickOnWorld = font(body), font(onWorld)
		Polestar.Set("ui.textShadow", "none")
		out.noShadow = shadow(body)
		Polestar.Set("ui.textShadow", "hard")
		out.hard = shadow(body)
		Polestar.Set("ui.headingFont", "inter")
		out.headingFace, out.bodyFace = font(heading), font(body)
		Polestar.Set("ui.headingSize", 1.4)
		Polestar.Set("ui.smallSize", 1.2)
		out.headingSize, out.smallSize, out.bodySize = font(heading)[2], font(small)[2], font(body)[2]
		-- A surface's own size for one string (a toast's title) survives a repaint.
		T.SetFontScale(body, 1.5)
		Polestar.Set("ui.font", "inter")
		out.scaled = font(body)
		T.SetFontScale(body, nil)
		Polestar.Set("ui.font", nil)
		for _, k in ipairs({ "ui.fontOutline", "ui.textShadow", "ui.headingFont", "ui.headingSize", "ui.smallSize" }) do Polestar.Set(k, nil) end
		out.after, out.afterShadow, out.afterHeading, out.afterSmall = font(body), shadow(body), font(heading), font(small)
		out.stored = Polestar.DB().settings.ui and Polestar.DB().settings.ui.fontOutline or "none stored"
		emit(out)"#);
	assert_eq!(out["before"], json!([GAME_FONT, 13, ""]), "no outline by default");
	assert_eq!(out["outline"][2], "OUTLINE", "ui.fontOutline = outline re-fonts every string at once");
	assert_eq!(out["thick"][2], "THICKOUTLINE");
	assert_eq!(out["thickOnWorld"][2], "THICKOUTLINE", "text outlined for the world takes the thick outline too");
	assert_eq!(out["noShadow"], 0, "ui.textShadow = none drops the shadow");
	assert_eq!(out["hard"], 1, "the game's hard shadow, at full black");
	assert_eq!(out["headingFace"], json!([INTER_SEMIBOLD, 13, "THICKOUTLINE"]), "headings take their own face");
	assert_eq!(out["bodyFace"][0], GAME_FONT, "the body keeps the text's face");
	assert_eq!(out["headingSize"], 18, "13 x 1.4, to half a point");
	assert_eq!(out["smallSize"], 13, "11 x 1.2, to half a point");
	assert_eq!(out["bodySize"], 13, "the body is moved by the text size only");
	assert_eq!(n(&out["scaled"][1]), 19.5, "a string's own scale holds through a font change");
	assert_eq!(out["after"], out["before"], "reset: every look back to the default");
	assert_eq!(out["afterShadow"], out["beforeShadow"]);
	assert_eq!(out["afterHeading"], out["beforeHeading"]);
	assert_eq!(out["afterSmall"], out["beforeSmall"]);
	assert_eq!(out["stored"], "none stored", "a default is not stored");
}

#[test]
fn own_text_and_name_colours_repaint_live_in_any_skin_a_dark_pick_is_lifted_until_it_reads_reset_restores_the_skin_s() {
	let out = run(r#"
		local npc = W.Text(UIParent, "body", "npc")
		local function rgb(fs) local r, g, b = fs:GetTextColor() return { r, g, b } end
		local function pal() local p = T.Palette() local o = {} for k, v in pairs(p) do if type(v) == "table" then o[k] = { v[1], v[2], v[3], v[4] } end end return o end
		local out = { default = rgb(npc), defaultHex = T.Hex("npc") }
		Polestar.Set("ui.colors.npc", { 1, 0.6, 1 })
		out.light, out.lightHex = rgb(npc), T.Hex("npc")
		Polestar.Set("ui.colors.npc", { 0.1, 0, 0.1 })
		Polestar.Set("ui.textColor", { 0.2, 0.2, 0.2 })
		Polestar.Set("ui.textMutedColor", { 0.9, 0.5, 0.5 })
		out.dark = pal()
		Polestar.Set("ui.skin", "halo")
		Polestar.Set("ui.colors.npc", { 1, 0.6, 1 })
		out.halo, out.haloPerson = rgb(npc), { T.Color("personName") }
		Polestar.Set("ui.skin", nil)
		Polestar.Set("ui.panelColor", { 0.3, 0.1, 0.1, 0.5 })
		local panel = T.Skin(CreateFrame("Frame", nil, UIParent), "panel")
		out.panel = { panel.psSkin.bg:GetVertexColor() }
		-- A section's Reset sets each of its keys back; the colour follows.
		Polestar.Set("ui.colors.quest", { 1, 1, 0.8 })
		for _, name in ipairs(T.SUBJECTS) do Polestar.Set("ui.colors." .. name, nil) end
		out.afterReset, out.questStored = rgb(npc), Polestar.Get("ui.colors.quest")
		emit(out)"#);
	assert_eq!(rounded(&out["light"]), vec![1.0, 0.6, 1.0], "a legible pick is drawn as picked, at once");
	assert_eq!(out["lightHex"], "ffff99ff", "|c escapes follow it");
	let dark = &out["dark"];
	for g in GROUNDS {
		let t = contrast(&dark["text"], &dark[g]);
		assert!(t >= 7.0, "own text on {g} is {t:.2}:1");
		let m = contrast(&dark["textMuted"], &dark[g]);
		assert!(m >= 4.5, "own muted text on {g} is {m:.2}:1");
		if g != "sky" {
			let c = contrast(&dark["npc"], &dark[g]);
			assert!(c >= 4.5, "a dark NPC colour on {g} is {c:.2}:1: it must be lifted");
		}
	}
	assert_eq!(rounded(&out["halo"]), vec![1.0, 0.6, 1.0], "the player's colours win in every skin");
	assert_eq!(rounded(&out["haloPerson"])[..3], [1.0, 0.6, 1.0], "a skin's person name is its NPC colour");
	assert_eq!(rounded(&out["panel"]), vec![0.3, 0.1, 0.1, 0.5], "an own panel ground with its opacity");
	assert_eq!(out["afterReset"], out["default"], "reset restores the skin's colour");
	assert_eq!(out["questStored"], false);
}

#[test]
fn hairlines_shadow_stars_haze_rim_and_animation_speed_follow_their_settings() {
	let out = run(r#"
		local out = { border = select(4, T.Wash("border")), shadow = select(4, T.Color("shadow")) }
		local sky = T.Band(UIParent, "BACKGROUND")
		Polestar.UI.ShowOptions("theme")
		local rim = PolestarOptions.Rim
		Polestar.Set("ui.hairlineOpacity", 2)
		Polestar.Set("ui.shadowStrength", 0.5)
		Polestar.Set("ui.starAlpha", 0)
		Polestar.Set("ui.haze", false)
		Polestar.Set("ui.rim", false)
		out.border2, out.shadowHalf = select(4, T.Wash("border")), select(4, T.Color("shadow"))
		out.stars, out.sky = select(4, sky.psStars:GetVertexColor()), select(4, sky:GetVertexColor())
		out.haze, out.rim, out.rimShown = select(4, T.Color("haze")), T.ShowsRim(), rim:IsShown()
		local o = CreateFrame("Frame", nil, UIParent)
		Polestar.Set("ui.animSpeed", 2)
		Polestar.Anim.To(o, "alpha", 0, 1, 0.2)
		out.fast = o.psTweens.alpha.dur
		Polestar.Set("ui.animSpeed", 0.5)
		Polestar.Anim.To(o, "alpha", 0, 1, 0.2)
		out.slow = o.psTweens.alpha.dur
		for _, k in ipairs({ "ui.hairlineOpacity", "ui.shadowStrength", "ui.starAlpha", "ui.haze", "ui.rim", "ui.animSpeed" }) do Polestar.Set(k, nil) end
		out.borderBack, out.starsBack, out.rimBack = select(4, T.Wash("border")), select(4, sky.psStars:GetVertexColor()), rim:IsShown()
		emit(out)"#);
	assert!((n(&out["border2"]) - 2.0 * n(&out["border"])).abs() < 1e-9, "hairlines at twice the skin's opacity");
	assert!((n(&out["shadowHalf"]) - 0.5 * n(&out["shadow"])).abs() < 1e-9, "the shadow at half strength");
	assert_eq!(out["stars"], 0, "no stars");
	assert_eq!(out["sky"], 1, "the sky stays");
	assert_eq!(out["haze"], 0);
	assert_eq!(out["rim"], false);
	assert_eq!(out["rimShown"], false, "the rim goes at once");
	assert!((n(&out["fast"]) - 0.1).abs() < 1e-9, "2x: half the time");
	assert!((n(&out["slow"]) - 0.4).abs() < 1e-9, "0.5x: twice the time");
	assert_eq!(out["borderBack"], out["border"]);
	assert_eq!(out["starsBack"], 1);
	assert_eq!(out["rimBack"], true);
}

#[test]
fn the_theme_page_lays_its_settings_out_by_element_in_full_rows_short_labels_tooltips_and_one_switch_and_swatch_per_row() {
	let out = run(r#"
		local keys, news, bad, tabs, previews, first, infos, toggles, extras, wides = {}, {}, {}, {}, {}, nil, 0, {}, {}, {}
		local function check(c)
			if c.key then
				keys[#keys + 1] = c.key
				if Polestar.GetDefault(c.key) == nil then bad[#bad + 1] = c.key .. ": no default" end
			end
			local name = c.key or c.label
			if type(c.help) ~= "string" or c.help == "" or type(c.search) ~= "string" or c.search == "" then bad[#bad + 1] = name .. ": no help or search" end
			local _, words = tostring(c.label):gsub("%S+", "")
			if words > 3 then bad[#bad + 1] = name .. ": label of " .. words .. " words" end
			if c.info then infos = infos + 1 end
			if c.wide then wides[#wides + 1] = c.key end
			if c.new then
				news[#news + 1] = name
				if c.new ~= "0.3.8" then bad[#bad + 1] = name .. ": new is not 0.3.8" end
			end
			local switches, swatches = 0, 0
			for _, x in ipairs(c.extras or {}) do
				extras[#extras + 1] = x.key
				if x.kind == "toggle" then switches = switches + 1 elseif x.kind == "color" then swatches = swatches + 1 end
				check(x)
			end
			if switches > 1 or swatches > 1 then bad[#bad + 1] = name .. ": more than one switch or swatch beside it" end
			for _, x in ipairs(c.more or {}) do check(x) end
		end
		-- The deep tabs' registrations (Essentials stands for their rows: settings-essentials.rs).
		for _, spec in ipairs(W.OptionsRegistry) do
			if spec.page == "Theme" and spec.tab ~= "Essentials" then
				first = first or spec
				if not tabs[spec.tab] then tabs[spec.tab] = true; tabs[#tabs + 1] = spec.tab end
				if spec.preview then previews[spec.tab] = true end
				if spec.toggle then toggles[#toggles + 1] = spec.toggle.key; check(spec.toggle) end
				-- A section of at least two rows: a wide row is one, the rest two to a row.
				local rows, halves = 0, 0
				for _, c in ipairs(spec.controls) do
					check(c)
					if c.wide then rows = rows + 1 else halves = halves + 1 end
				end
				rows = rows + math.ceil(halves / 2)
				if rows < 2 then bad[#bad + 1] = spec.tab .. " > " .. spec.section .. ": one row" end
			end
		end
		local withPreview = 0
		for i = 1, #tabs do if previews[tabs[i]] then withPreview = withPreview + 1 end end
		emit({ keys = keys, news = #news, bad = table.concat(bad, "; "), tabs = { unpack(tabs) }, withPreview = withPreview,
			infos = infos, toggles = toggles, extras = extras, wides = wides,
			page = { key = first.key, order = first.order, group = first.group } })"#);
	let keys: Vec<&str> = out["keys"].as_array().unwrap().iter().map(|k| k.as_str().unwrap()).collect();
	// The old Appearance > Colour & type and Windows > Frame settings (the menu scale lives in the window's header,
	// the class quest chime on Alerts & toasts).
	for k in [
		"ui.accent",
		"ui.classAccent",
		"ui.scheme",
		"ui.bgColor",
		"ui.brightness",
		"ui.bgOpacity",
		"ui.font",
		"ui.textSize",
		"ui.reduceMotion",
		"ui.skin",
		"ui.border",
		"ui.borderColor",
		"ui.borderAccent",
		"ui.borderSize",
		"ui.band",
		"ui.shadow",
		"ui.gameMenuButton",
	] {
		assert!(keys.contains(&k), "{k} is on the Theme page");
	}
	assert!(!keys.contains(&"ui.menuScale") && !keys.contains(&"ui.classCardSound"), "one home per setting");
	for k in [
		"ui.fontOutline",
		"ui.textShadow",
		"ui.headingFont",
		"ui.textColor",
		"ui.colors.npc",
		"ui.colors.quest",
		"ui.panelColor",
		"ui.hairlineOpacity",
		"ui.shadowStrength",
		"ui.starAlpha",
		"ui.rim",
		"ui.animSpeed",
	] {
		assert!(keys.contains(&k), "{k} is on the Theme page");
	}
	assert_eq!(out["bad"], "");
	assert!(n(&out["news"]) >= 25.0, "many new controls: {}", out["news"]);
	assert_eq!(out["tabs"], json!(["Colour", "Text", "Names", "Frames"]));
	assert_eq!(out["withPreview"], 4, "every tab pins the live preview");
	assert_eq!(out["page"], json!({ "key": "theme", "order": 20, "group": "look" }));
	assert!(n(&out["infos"]) <= 2.0, "an (i) on at most two rows");
	assert_eq!(out["toggles"], json!({}), "no header switches: each on/off sits beside its own row");
	assert_eq!(out["extras"], json!(["ui.bgColor", "ui.border", "ui.borderColor", "ui.shadow", "ui.band"]), "an element's on/off and colour beside its slider");
	assert_eq!(out["wides"], json!(["ui.skin", "ui.scheme"]), "the picture cards span the row");
}

// The preview is Theme v2, a band of the three surfaces the theme styles, drawn by their own code: the guide window
// (the Guide window page's drawing, never the live window, cut under its third goal row), the heads-up card and the
// rare alert (Rares' own card), side by side, feet on one line, a label under each, no loose buttons (the accent
// lights the cards' own); a change repaints them live; real size where the band holds the three, else all three
// smaller alike, never one left out, the hint line saying so.
#[test]
fn the_preview_paints_from_the_theme_and_follows_a_change_live() {
	let out = run_with_rares(
		r#"
		local f = Polestar.UI.ThemePreview(UIParent)
		local h = f:Layout(1600)
		local hots = 0
		for _ in pairs(rawget(f, "Hots") or {}) do hots = hots + 1 end
		-- Each one's foot, in band units.
		local function foot(fr, k)
			local _, _, _, _, y = fr:GetPoint(1)
			local g = k or fr:GetScale()
			return math.floor(-y * g + fr:GetHeight() * g + 0.5)
		end
		local labels = {}
		for i, p in ipairs(f.Parts) do labels[i] = p.label:GetText() end
		local out = { toast = f.Toast ~= nil and f.Toast:IsShown(), heads = f.Heads ~= nil and f.Heads:IsShown(),
			guide = f.Guide ~= nil and f.Guide ~= PolestarGuideFrame, buttons = rawget(f, "Buttons") == nil, hots = hots,
			fit = f.psFit, hint = f.Hint:IsShown(), labels = labels,
			feet = { foot(f.Scene), foot(f.Heads), foot(f.Toast) }, arrow = rawget(f, "Arrow") == nil, tall = h < 400 }
		Polestar.Set("ui.colors.item", { 0.6, 1, 0.6 })
		Polestar.Set("ui.fontOutline", "outline")
		out.item = f.Scene.Rows[3].Text:GetText()
		out.titleFlags = select(3, f.StepTitle:GetFont())
		f:Layout(420)
		out.narrow = { f.Toast:IsShown(), f.Heads:IsShown(), f.Guide:IsShown(), f.psFit < 1, f.Hint:GetText():find("to fit", 1, true) ~= nil }
		emit(out)"#,
	);
	assert_eq!(out["toast"], true);
	assert_eq!(out["heads"], true);
	assert_eq!(out["guide"], true, "the guide window, the preview's own");
	assert_eq!(out["buttons"], true, "no Accept / Skip pair standing alone in the scene");
	assert_eq!(out["arrow"], true, "no arrow: Theme shows the three surfaces it styles");
	assert!(out["hots"].as_f64().unwrap() >= 6.0, "each part of the preview leads to its setting: {}", out["hots"]);
	assert_eq!(out["fit"], 1, "a band wide enough: real size");
	assert_eq!(out["hint"], false);
	assert_eq!(out["labels"], json!(["Guide window", "Heads-up card", "Rare alert"]));
	let feet = out["feet"].as_array().unwrap();
	assert!(feet.iter().all(|f| (f.as_f64().unwrap() - feet[0].as_f64().unwrap()).abs() <= 1.0), "feet on one line: {feet:?}");
	assert_eq!(out["tall"], true);
	assert!(out["item"].as_str().unwrap().contains("|cff99ff99"), "the goal names the item in its own colour: {}", out["item"]);
	assert_eq!(out["titleFlags"], "OUTLINE");
	assert_eq!(out["narrow"], json!([true, true, true, true, true]), "a narrow band shows all three smaller and says so");
}

// The game looks frame a big window with a title (WoW Forever's and Blizzard's bar, Classic's header plate
// on the top edge); the preview's guide window wears the guide window's own paint, so no window title sits
// over the preview's caption and the guide's tab.
#[test]
fn in_every_game_look_the_preview_s_guide_window_wears_the_guide_window_s_paint_no_window_title_over_the_caption() {
	let out = run(r#"
		local function titled(frame)
			for _, r in ipairs({ frame:GetRegions() }) do
				if r.GetText and r:IsShown() and r:GetText() == "Polestar" then return true end
			end
			for _, c in ipairs({ frame:GetChildren() }) do
				if c:IsShown() and titled(c) then return true end
			end
			return false
		end
		local out = {}
		for _, skin in ipairs({ "polestar", "forever", "blizzard", "classic" }) do
			Polestar.Set("ui.skin", skin)
			local f = Polestar.UI.ThemePreview(UIParent)
			f:Layout(900)
			out[skin] = { skin = T.SkinKey(), titled = titled(f.Guide) }
		end
		emit(out)"#);
	for skin in ["polestar", "forever", "blizzard", "classic"] {
		assert_eq!(out[skin], json!({ "skin": skin, "titled": false }), "{skin}: the preview's guide window carries no window title");
	}
}

#[test]
fn a_skin_with_a_preset_offers_apply_and_undo_under_the_skin_cards_which_set_and_put_back_its_settings() {
	let out = run(r#"
		local apply, undo
		for _, spec in ipairs(W.OptionsRegistry) do
			if spec.page == "Theme" then
				for _, c in ipairs(spec.controls) do
					if c.kind == "button" and c.onClick then
						if c.button == "Apply" then apply = c elseif c.button == "Undo" then undo = c end
					end
				end
			end
		end
		local function state()
			return { shown = apply.needs() and undo.needs(), apply = not apply.disabled(), undo = not undo.disabled() }
		end
		local out = { house = { apply.needs(), undo.needs() } }
		local ok, why = T.RegisterSkin("dawn", { name = "Dawn", addon = "Test_Dawn",
			preset = { ["ui.fontOutline"] = "thick", ["ui.headingSize"] = 1.3 } })
		out.registered = ok or why
		Polestar.Set("ui.skin", "dawn")
		out.offered, out.label = state(), apply.label()
		apply.onClick()
		out.applied = { state = state(), outline = Polestar.Get("ui.fontOutline"), heading = Polestar.Get("ui.headingSize") }
		undo.onClick()
		out.undone = { state = state(), outline = Polestar.Get("ui.fontOutline"), heading = Polestar.Get("ui.headingSize") }
		emit(out)"#);
	assert_eq!(out["house"], json!([false, false]), "Polestar's own skin has no preset: no buttons");
	assert_eq!(out["registered"], true);
	assert_eq!(out["offered"], json!({ "shown": true, "apply": true, "undo": false }), "the pair shows; Undo waits for an apply");
	assert_eq!(out["label"], "Apply Dawn's layout");
	assert_eq!(out["applied"], json!({ "state": { "shown": true, "apply": true, "undo": true }, "outline": "thick", "heading": 1.3 }));
	assert_eq!(out["undone"]["state"], json!({ "shown": true, "apply": true, "undo": false }));
	assert_eq!(out["undone"]["outline"], "none", "Undo puts the settings back");
	assert_eq!(out["undone"]["heading"], 1);
}

// A skin addon's card shows the skin's name alone (its folder next to it ran the two together: "Umbrablestar_Skin_
// Umbra"); the folder is in the card's tooltip, after the skin's own description.
#[test]
fn a_skin_addon_s_card_shows_its_name_alone_and_its_folder_in_the_tooltip() {
	let out = run(r#"
		assert(T.RegisterSkin("umbra", { name = "Umbra", addon = "Polestar_Skin_Umbra", desc = "Deep shade, soft light." }))
		local O = Polestar.UI.Options
		Polestar.UI.ShowOptions("theme")
		O.Select("theme", "Colour")
		local row = O.Controls("theme", "Colour")["ui.skin"]
		local card = row.psCardBy.umbra
		emit({ name = card.Name:GetText(), note = card.Note:GetText(), tip = card.psTipLines and card.psTipLines[1] or false })"#);
	assert_eq!(out["name"], "Umbra");
	assert_eq!(out["note"], "", "nothing beside the name");
	assert_eq!(out["tip"], "Deep shade, soft light.\nFrom the addon Polestar_Skin_Umbra", "the folder in the tooltip");
}
