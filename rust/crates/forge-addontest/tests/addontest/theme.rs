//! Polestar.Theme (colour schemes, custom colours, legibility, the EllesmereUI path), Polestar.Anim, and the
//! textures the UI shows.

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, is_match, text, truthy, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

fn run_with(script: &str, before: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: before.into(),
		addons: vec![Addon::files("Polestar", FILES)],
		script: format!("uistub.install()\nstub.login()\nlocal T, W = Polestar.Theme, Polestar.Widgets\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn run(script: &str) -> Value {
	run_with(script, "")
}

fn round(list: &Value) -> Vec<f64> {
	list.as_array().unwrap().iter().map(|v| (v.as_f64().unwrap() * 1000.0).round() / 1000.0).collect()
}

// WCAG 2 contrast, computed here independently of Theme.Contrast.
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

const GROUNDS: [&str; 6] = ["bg", "panel", "panelAlt", "sidebar", "footer", "sky"];
const SUBJECTS: [&str; 16] = ["quest", "npc", "item", "place", "object", "level", "skill", "spell", "faction", "area", "achievement", "dungeon", "rare", "success", "warning", "danger"];

// Every ground must carry primary text at 7:1 and the secondary and muted text at 4.5:1; the subject and status
// colours need 4.5:1 on every ground but the header sky (only titles sit on the band).
fn assert_legible(name: &str, pal: &Value) {
	for g in GROUNDS {
		let t = contrast(&pal["text"], &pal[g]);
		assert!(t >= 7.0, "{name}: text on {g} is {t:.2}:1");
		let mut roles = vec!["textDim", "textMuted"];
		if g != "sky" {
			roles.extend(SUBJECTS);
		}
		for role in roles {
			let c = contrast(&pal[role], &pal[g]);
			assert!(c >= 4.5, "{name}: {role} on {g} is {c:.2}:1");
		}
	}
}

fn values(v: &Value) -> Value {
	Value::Array(v.as_array().unwrap().iter().map(|c| c["value"].clone()).collect())
}

#[test]
fn every_colour_scheme_keeps_the_text_ladder_legible_on_every_ground_7_1_primary_4_5_1_the_rest() {
	let out = run(r#"
		local out = {}
		for _, key in ipairs(T.SCHEME_ORDER) do
			Polestar.Set("ui.scheme", key)
			out[key] = T.Palette()
		end
		emit(out)"#);
	let obj = out.as_object().unwrap();
	let mut keys: Vec<&str> = obj.keys().map(|k| k.as_str()).collect();
	keys.sort();
	assert_eq!(keys, vec!["dusk", "graphite", "night"]);
	for (key, pal) in obj {
		assert_legible(key, pal);
	}
}

// Colours from outside the palette go through Theme.Legible: the client's item qualities (Poor..Artifact) and
// quest difficulty colours. A dimmed name keeps that colour (its chip says why), so each must read at 4.5:1 on
// the lightest place a name sits, a selected row on the panel.
#[test]
fn item_quality_and_quest_difficulty_colours_lifted_read_at_4_5_1_on_a_selected_row_in_every_scheme() {
	let out = run(r#"
		local OUTSIDE = {
			{ 0.62, 0.62, 0.62 }, { 1, 1, 1 }, { 0.12, 1, 0 }, { 0, 0.44, 0.87 }, { 0.64, 0.21, 0.93 }, { 1, 0.5, 0 }, { 0.9, 0.8, 0.5 },
			{ 1, 0.1, 0.1 }, { 1, 0.5, 0.25 }, { 1, 0.82, 0 }, { 0.25, 0.75, 0.25 }, { 0.5, 0.5, 0.5 },
		}
		local out = {}
		for _, key in ipairs(T.SCHEME_ORDER) do
			Polestar.Set("ui.scheme", key)
			local o = { ground = T.LightestGround(), panel = T.Palette().panel, lifted = {}, epic = { Polestar.UI.Lookup.QualityColor(4) } }
			for i, c in ipairs(OUTSIDE) do o.lifted[i] = { T.Legible(c[1], c[2], c[3]) } end
			out[key] = o
		end
		emit(out)"#);
	for (key, o) in out.as_object().unwrap() {
		assert!(lum(&o["ground"]) > lum(&o["panel"]), "{key}: a selected row is lighter than the panel");
		for (i, c) in o["lifted"].as_array().unwrap().iter().enumerate() {
			let r = contrast(c, &o["ground"]);
			assert!(r >= 4.5, "{key}: outside colour {} reads {r:.2}:1 on a selected row", i + 1);
		}
		let epic = contrast(&o["epic"], &o["ground"]);
		assert!(epic >= 4.5, "{key}: an epic name (the retired Reins of the Frostsaber) reads {epic:.2}:1");
	}
}

#[test]
fn dusk_is_the_default_and_visibly_lighter_than_night_night_keeps_the_original_palette_exactly() {
	let out = run(r#"
		local dusk = T.Palette()
		Polestar.Set("ui.scheme", "night")
		emit({ key = dusk.scheme, dusk = dusk, night = T.Palette() })"#);
	assert_eq!(out["key"], "dusk");
	for g in ["bg", "panel", "panelAlt", "sidebar", "footer", "sky"] {
		assert!(lum(&out["dusk"][g]) > lum(&out["night"][g]) * 2.0, "Dusk {g} is clearly lighter");
		assert!(out["dusk"][g][2].as_f64().unwrap() > out["dusk"][g][0].as_f64().unwrap(), "Dusk {g} stays navy, not grey");
	}
	let n = &out["night"];
	assert_eq!(round(&n["bg"]), vec![0.039, 0.051, 0.086, 0.97]);
	assert_eq!(round(&n["panel"]), vec![0.051, 0.066, 0.11, 0.98]);
	assert_eq!(round(&n["panelAlt"]), vec![0.075, 0.094, 0.149, 1.0]);
	assert_eq!(round(&n["sidebar"]), vec![0.027, 0.035, 0.063, 1.0]);
	assert_eq!(round(&n["footer"]), vec![0.031, 0.04, 0.071, 1.0]);
	assert_eq!(round(&n["text"]), vec![0.96, 0.97, 0.99, 1.0]);
	assert_eq!(round(&n["textDim"]), vec![0.69, 0.72, 0.8, 1.0]);
	assert_eq!(round(&n["textMuted"]), vec![0.5, 0.54, 0.63, 1.0]);
}

#[test]
fn custom_ground_colour_and_brightness_repaint_live_and_can_never_make_text_illegible() {
	let out = run(r#"
		local tex = W.Tex(UIParent, "ARTWORK", "white", "bg")
		local sky = T.Band(UIParent)
		local before = { tex:GetVertexColor() }
		local skyBefore = { sky:GetVertexColor() }
		Polestar.Set("ui.bgColor", { 0.2, 0.05, 0.1 })
		local custom = { tex:GetVertexColor() }
		local skyCustom = { sky:GetVertexColor() }
		Polestar.Set("ui.brightness", 0.5)
		local lifted = T.Palette()
		Polestar.Set("ui.bgColor", { 1, 1, 1 })
		Polestar.Set("ui.brightness", 1)
		local white = T.Palette()
		Polestar.Set("ui.bgColor", nil)
		Polestar.Set("ui.brightness", -1)
		local low = T.Palette()
		Polestar.Set("ui.brightness", nil)
		emit({ before = before, custom = custom, skyBefore = skyBefore, skyCustom = skyCustom, lifted = lifted, white = white, low = low,
			back = { tex:GetVertexColor() }, legible = T.Legibility(white) })"#);
	assert_ne!(out["custom"], out["before"]);
	assert!(out["custom"][0].as_f64().unwrap() > out["custom"][2].as_f64().unwrap(), "the ground takes the custom hue");
	assert_ne!(out["skyCustom"], out["skyBefore"], "the band follows the ground");
	assert!(lum(&out["lifted"]["bg"]) > lum(&out["custom"]), "brightness lifts the ground");
	assert_legible("custom + lifted", &out["lifted"]);
	assert_legible("white ground at full brightness", &out["white"]);
	assert_legible("darkest", &out["low"]);
	assert!(out["legible"].as_f64().unwrap() >= 1.0);
	assert_eq!(&out["back"].as_array().unwrap()[..3], &out["before"].as_array().unwrap()[..3], "right-click reset (nil) returns to the scheme");
}

#[test]
fn house_style_the_game_s_font_by_default_and_inter_on_request_polestar_gold_a_user_accent_that_repaints_what_follows_it() {
	let out = run(r#"
		local fs = UIParent:CreateFontString()
		T.Font(fs, "title")
		local before = { fs:GetFont() }
		local tex = W.Tex(UIParent, "ARTWORK", "white", "accent")
		local fired = 0
		T.OnChanged(function() fired = fired + 1 end)
		local d = { T.Accent() }
		Polestar.Set("ui.accent", { 1, 0.5, 0 })
		local tr, tg, tb = tex:GetVertexColor()
		Polestar.Set("ui.font", "inter")
		local inter = { fs:GetFont() }
		Polestar.Set("ui.bgOpacity", 0.5)
		local bgAlpha = select(4, PolestarGuideFrame.psSkin.bg:GetVertexColor())
		T.SetOutline(fs, true)
		local outlined = select(3, fs:GetFont())
		emit({ before = before, inter = inter, default = d, tex = { tr, tg, tb }, fired = fired, eui = T.IsEllesmere(),
			border = PolestarGuideFrame.psBorder ~= nil, shadow = PolestarGuideFrame.psShadow:IsShown(), bgAlpha = bgAlpha,
			outlined = outlined, media = T.Media("check"), verb = T.VerbIcon("kill"),
			band = { T.BandCoords(720, 112) }, schemes = T.SchemeChoices() })"#);
	assert_eq!(out["before"], json!(["Fonts\\FRIZQT__.TTF", 15, ""]), "the game's own font by default");
	assert_eq!(out["inter"], json!(["Interface\\AddOns\\Polestar\\Media\\Fonts\\Inter-SemiBold.ttf", 15, ""]), "ui.font = inter re-fonts live");
	assert_eq!(round(&out["default"]), vec![0.9, 0.73, 0.4], "Polestar gold");
	assert_eq!(out["tex"], json!([1, 0.5, 0]));
	assert!(out["fired"].as_f64().unwrap() >= 1.0);
	assert_eq!(out["eui"], false);
	assert_eq!(out["border"], true);
	assert_eq!(out["shadow"], true);
	assert_eq!(out["bgAlpha"], 0.5);
	assert_eq!(out["outlined"], "OUTLINE");
	assert_eq!(out["media"], "Interface\\AddOns\\Polestar\\Media\\UI\\check");
	assert_eq!(out["verb"], "Interface\\AddOns\\Polestar\\Media\\UI\\icon-kill");
	assert_eq!(round(&out["band"]), vec![0.0, 0.703, 0.0, 0.875], "the band is cropped to the header, never stretched");
	assert_eq!(values(&out["schemes"]), json!(["dusk", "night", "graphite"]), "EllesmereUI is offered only when installed");
}

// The ruRU game font has no middle dot, so the skin's face becomes Fira Sans there; a face the player picked,
// and the other locales, are left alone.
#[test]
fn fonts_ruru_swaps_the_skin_s_game_font_for_fira_sans_an_explicit_pick_and_other_locales_keep_theirs() {
	const GAME: &str = "Fonts\\FRIZQT__.TTF";
	const FIRA: &str = "Interface\\AddOns\\Polestar\\Media\\Fonts\\FiraSans-SemiBold.ttf";
	const INTER: &str = "Interface\\AddOns\\Polestar\\Media\\Fonts\\Inter-SemiBold.ttf";
	let faces = |locale: &str| {
		run_with(
			r#"
		local out = {}
		out.default = (T.FontSpec("title"))
		for _, skin in ipairs({ "hearth", "forever", "blizzard", "classic" }) do
			Polestar.Set("ui.skin", skin)
			out[skin] = (T.FontSpec("title"))
		end
		Polestar.Set("ui.skin", "polestar")
		Polestar.Set("ui.font", "skin")
		out.skinChoice = (T.FontSpec("title"))
		Polestar.Set("ui.font", "game")
		out.game = (T.FontSpec("title"))
		Polestar.Set("ui.skin", "blizzard")
		out.gameBlizzard = (T.FontSpec("title"))
		Polestar.Set("ui.skin", "polestar")
		Polestar.Set("ui.font", "inter")
		out.inter = (T.FontSpec("title"))
		emit(out)"#,
			&format!("function GetLocale() return \"{locale}\" end"),
		)
	};

	let ru = faces("ruRU");
	assert_eq!(ru["default"], FIRA, "ruRU default");
	assert_eq!(ru["skinChoice"], FIRA, "ruRU with the skin's own font");
	for skin in ["hearth", "forever", "blizzard", "classic"] {
		assert_eq!(ru[skin], FIRA, "ruRU {skin} by default");
	}
	assert_eq!(ru["game"], GAME, "ruRU with \"the game's\" font picked");
	assert_eq!(ru["gameBlizzard"], GAME, "ruRU with \"the game's\" font picked on a game skin");
	assert_eq!(ru["inter"], INTER, "ruRU with Inter picked");

	for locale in ["zhCN", "koKR"] {
		let cjk = faces(locale);
		assert_eq!(cjk["default"], GAME, "{locale} default");
		assert_eq!(cjk["inter"], GAME, "{locale} with Inter picked");
	}

	let en = faces("enUS");
	assert_eq!(en["default"], GAME, "enUS default");
	assert_eq!(en["game"], GAME, "enUS with the game font picked");
	assert_eq!(en["inter"], INTER, "enUS with Inter picked");
}

#[test]
fn settings_from_before_schemes_a_stored_gold_accent_was_the_old_default_any_other_stays_the_user_s_own() {
	let ui = |accent: &str| format!("PolestarDB = {{ schema = 1, settings = {{ ui = {{ accent = {accent} }} }} }}");
	let script = r#"emit({ accent = Polestar.Get("ui.accent"), live = { T.Accent() } })"#;
	let gold = run_with(script, &ui("{ 0.9, 0.73, 0.4 }"));
	assert_eq!(gold["accent"], false);
	assert_eq!(round(&gold["live"]), vec![0.9, 0.73, 0.4]);
	let own = run_with(script, &ui("{ 0.2, 0.6, 1 }"));
	assert_eq!(own["accent"], json!([0.2, 0.6, 1]));
	assert_eq!(round(&own["live"]), vec![0.2, 0.6, 1.0]);
}

#[test]
fn ellesmereui_an_optional_scheme_and_follow_toggles_never_a_lock() {
	let out = run_with(
		r#"
		local fs = UIParent:CreateFontString()
		T.Font(fs, "body")
		local GF = Polestar.UI.GuideFrame
		uistub.setGuide(uistub.elwynn, 3)
		local function fill() local r, g, b = GF.parts.line.Fill:GetVertexColor() return { r, g, b } end
		local before = fill()
		local fired = 0
		T.OnChanged(function() fired = fired + 1 end)
		stub.setAccent(0.6, 0.48, 1)
		local after = fill()
		local followFont = { fs:GetFont() }
		local schemes = T.SchemeChoices()
		Polestar.Set("ui.scheme", "ellesmere")
		local euiGround = { T.Color("bg") }
		local euiPal = T.Palette()
		Polestar.UI.ShowOptions("appearance")
		local look = Polestar.UI.Options.Controls("appearance")
		local swatch = look["ui.accent"]
		local note = swatch.Note:GetText()
		swatch:Click("LeftButton")
		local opened = ColorPickerFrame.info ~= nil
		ColorPickerFrame.GetColorRGB = function() return 0.1, 0.8, 0.3 end
		ColorPickerFrame.info.swatchFunc()
		local picked = { accent = { T.Accent() }, match = Polestar.Get("ui.matchAccent"), fill = fill() }
		ColorPickerFrame.info.cancelFunc()
		local cancelled = { accent = Polestar.Get("ui.accent"), match = Polestar.Get("ui.matchAccent") }
		Polestar.Set("ui.accent", { 1, 0, 0 })
		local own = Polestar.Get("ui.matchAccent")
		Polestar.UI.ShowOptions("integrations")
		Polestar.UI.Options.Controls("integrations")["ui.matchAccent"]:Click()
		local rematched = { accent = Polestar.Get("ui.accent"), live = { T.Accent() } }
		Polestar.UI.ShowOptions("appearance")
		look = Polestar.UI.Options.Controls("appearance")
		local font = look["ui.font"]
		local fontLabel = font.Button.Label:GetText()
		font.Button:Click()
		local items = {}
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then items[#items + 1] = r.Text:GetText() end end
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Inter" then r:Click() end end
		local inter = { match = Polestar.Get("ui.matchFont"), font = { fs:GetFont() }, label = font.Button.Label:GetText() }
		Polestar.UI.ShowOptions("integrations")
		Polestar.UI.Options.Controls("integrations")["ui.matchFont"]:Click()
		emit({ registered = stub.skinRegistered, eui = T.IsEllesmere(), skinned = #stub.skinned,
			shellArt = PolestarGuideFrame.euiSkin or false, houseBg = PolestarGuideFrame.psSkin.bg:IsShown(),
			band = GF.parts.band:IsShown(), followFont = followFont, before = before, after = after, fired = fired,
			schemes = schemes, euiGround = euiGround, euiPal = euiPal, note = note, opened = opened, enabled = swatch:IsEnabled(),
			picked = picked, cancelled = cancelled, own = own, rematched = rematched, fontLabel = fontLabel, items = items, inter = inter,
			refollow = { fs:GetFont() } })"#,
		"stub.withEllesmere()",
	);
	assert_eq!(out["registered"], "Polestar");
	assert_eq!(out["eui"], true);
	assert_eq!(out["skinned"], 0, "no EllesmereUI primitive replaces Polestar art");
	assert_eq!(out["shellArt"], false);
	assert_eq!(out["houseBg"], true);
	assert_eq!(out["band"], true);
	assert_eq!(out["followFont"], json!(["Fonts\\FRIZQT__.TTF", 13, ""]), "the game's font by default, even with EllesmereUI");
	assert_eq!(round(&out["before"]), vec![0.05, 0.82, 0.62], "follows its accent by default");
	assert_eq!(round(&out["after"]), vec![0.6, 0.48, 1.0], "S.OnLooksChanged repaints accent-coloured elements");
	assert!(out["fired"].as_f64().unwrap() >= 1.0);
	assert_eq!(values(&out["schemes"]), json!(["dusk", "night", "graphite", "ellesmere"]));
	let g = &out["euiGround"];
	assert!((g[0].as_f64().unwrap() - g[2].as_f64().unwrap()).abs() < 0.03, "the EllesmereUI scheme takes its neutral panel colour");
	assert_eq!(g[3], 0.95, "and its opacity");
	assert_legible("ellesmere", &out["euiPal"]);
	assert_eq!(out["note"], "EllesmereUI", "the swatch says where the accent comes from");
	assert_eq!(out["enabled"], true, "the accent is always editable");
	assert_eq!(out["opened"], true);
	assert_eq!(round(&out["picked"]["accent"]), vec![0.1, 0.8, 0.3]);
	assert_eq!(out["picked"]["match"], false, "picking your own accent turns following off");
	assert_eq!(round(&out["picked"]["fill"]), vec![0.1, 0.8, 0.3]);
	assert_eq!(out["cancelled"], json!({ "accent": false, "match": true }), "cancel restores both");
	assert_eq!(out["own"], false);
	assert_eq!(out["rematched"]["accent"], false, "following again drops your own accent");
	assert_eq!(round(&out["rematched"]["live"]), vec![0.6, 0.48, 1.0]);
	assert_eq!(out["fontLabel"], "The skin's font", "the skin picks the font by default: the game's in the house style");
	assert_eq!(out["items"], json!(["The skin's font", "Game font", "Inter", "Fira Sans", "EllesmereUI"]));
	assert_eq!(out["inter"]["match"], false, "choosing another font turns following off");
	assert_eq!(out["inter"]["font"], json!(["Interface\\AddOns\\Polestar\\Media\\Fonts\\Inter-Medium.ttf", 13, ""]));
	assert_eq!(out["inter"]["label"], "Inter");
	assert_eq!(out["refollow"], json!(["Interface\\AddOns\\EllesmereUI\\media\\fonts\\Expressway.ttf", 13, ""]));
}

#[test]
fn ellesmereui_font_with_an_outline_a_primary_button_s_dark_label_on_the_accent_drops_it_other_text_keeps_it_521() {
	let out = run_with(
		r#"
		stub.euiS.GetFont = function() return "Interface\\AddOns\\EllesmereUI\\media\\fonts\\Expressway.ttf", "OUTLINE" end
		Polestar.Set("ui.matchFont", true)
		local fs = UIParent:CreateFontString()
		T.Font(fs, "body")
		local load = W.Button(UIParent, "Load guide", nil, { primary = true })
		local tab = W.Button(UIParent, "Open in new tab", nil, {})
		T.Refresh()
		emit({ body = select(3, fs:GetFont()), primary = select(3, load.Label:GetFont()), other = select(3, tab.Label:GetFont()) })"#,
		"stub.withEllesmere()",
	);
	assert_eq!(out["body"], "OUTLINE", "text on the panels keeps EllesmereUI's outline");
	assert_eq!(out["other"], "OUTLINE", "so does a secondary button's light label");
	assert_eq!(out["primary"], "", "dark ink on the accent has no outline to smear it");
}

#[test]
fn ellesmereui_font_a_refresh_sets_the_text_again_a_frame_later_so_a_string_drawn_at_login_is_not_left_blank() {
	let out = run_with(
		r#"
		local fs = UIParent:CreateFontString()
		T.Font(fs, "body")
		fs:SetText("Innkeeper Heather")
		local sets = 0
		local set = fs.SetText
		fs.SetText = function(self, ...) sets = sets + 1 return set(self, ...) end
		T.Refresh()
		stub.advance(0.1)
		local ownFont = sets
		Polestar.Set("ui.matchFont", true)
		stub.advance(0.1)
		sets = 0
		T.Refresh()
		local sameFrame = sets
		stub.advance(0.1)
		local later = sets - sameFrame
		sets = 0
		T.Refresh()
		T.Refresh()
		local syncTwo = sets
		stub.advance(0.1)
		emit({ ownFont = ownFont, sameFrame = sameFrame, later = later, twiceLater = sets - syncTwo, text = fs:GetText() })"#,
		"stub.withEllesmere()",
	);
	assert_eq!(out["ownFont"], 2, "without EllesmereUI's font the one re-set stands, nothing is queued");
	assert_eq!(out["sameFrame"], 2, "the refresh sets the text again at once");
	assert_eq!(out["later"], 2, "and once more a frame later");
	assert_eq!(out["twiceLater"], 2, "refreshes in one frame share one later pass");
	assert_eq!(out["text"], "Innkeeper Heather");
}

// The class colour as the accent: it follows the player's class, lifted until it reads as text (shaman blue is
// too dark on the night grounds as it is), and it is one source among three: your own colour, your class's,
// EllesmereUI's; choosing one turns the others off.
#[test]
fn class_colour_accent_follows_the_class_lifted_to_read_and_takes_turns_with_your_own_accent_and_ellesmereui_s() {
	let out = run_with(
		r#"
		UnitClass = function() return "Shaman", "SHAMAN", 7 end
		local raw = RAID_CLASS_COLORS.SHAMAN
		Polestar.Set("ui.classAccent", true)
		local shaman = { T.Accent() }
		local pal = T.Palette()
		local panel = pal.panel
		local follows = { class = T.FollowsClassAccent(), eui = T.FollowsEllesmereAccent(), match = Polestar.Get("ui.matchAccent") }
		Polestar.Set("ui.accent", { 1, 0.5, 0 })
		local own = { class = Polestar.Get("ui.classAccent"), accent = { T.Accent() } }
		Polestar.Set("ui.classAccent", true)
		local back = { accent = Polestar.Get("ui.accent"), live = { T.Accent() } }
		emit({ raw = { raw.r, raw.g, raw.b }, shaman = shaman, panel = { panel[1], panel[2], panel[3] }, follows = follows, own = own, back = back })"#,
		"stub.withEllesmere()",
	);
	assert!(contrast(&out["raw"], &out["panel"]) < 4.5, "raw shaman blue does not read on the panel");
	let lifted = contrast(&out["shaman"], &out["panel"]);
	assert!(lifted >= 4.5, "lifted to {lifted:.2}:1");
	assert!(out["shaman"][2].as_f64().unwrap() > out["shaman"][0].as_f64().unwrap(), "still blue");
	assert_eq!(out["follows"], json!({ "class": true, "eui": false, "match": false }), "turning it on stops following EllesmereUI");
	assert_eq!(out["own"], json!({ "class": false, "accent": [1, 0.5, 0] }), "your own accent turns it off");
	assert_eq!(out["back"]["accent"], false, "turning it on again drops your own accent");
	assert_eq!(round(&out["back"]["live"]), round(&out["shaman"]));
}

#[test]
fn anim_onupdate_exists_only_while_a_tween_runs_retargeting_reuses_the_record() {
	let out = run(r#"
		local A = Polestar.Anim
		local f = CreateFrame("Frame")
		A.To(f, "alpha", 0, 1, 0.2, "out")
		local running = A.Active()
		stub.advance(0.1)
		local mid = f:GetAlpha()
		local rec = f.psTweens.alpha
		A.To(f, "alpha", f:GetAlpha(), 0.5, 0.2)
		local reused = f.psTweens.alpha == rec and A.Active() == 1
		local done = false
		A.To(f, "width", 10, 100, 0.2, "out", function() done = true end)
		stub.advance(0.5)
		Polestar.Set("ui.reduceMotion", true)
		A.To(f, "width", 0, 50, 0.2)
		local snapped = f:GetWidth()
		emit({ running = running, mid = mid, reused = reused, done = done, final = f:GetAlpha(), width = snapped, active = A.Active() })"#);
	assert_eq!(out["running"], 1);
	let mid = out["mid"].as_f64().unwrap();
	assert!(mid > 0.5 && mid < 1.0, "ease-out is past halfway at half time ({mid})");
	assert_eq!(out["reused"], true);
	assert_eq!(out["done"], true);
	assert_eq!(out["final"], 0.5);
	assert_eq!(out["width"], 50, "reduced motion: movement lands at once");
	assert_eq!(out["active"], 0);
}

// Every texture the UI sets must exist on disk, or the client draws a green box.
#[test]
fn every_texture_the_ui_shows_and_every_goal_verb_icon_exists_as_a_valid_tga() {
	let verbs = [
		"accept", "turnin", "complete", "kill", "collect", "goto", "talk", "interact", "use", "sethome", "hearth", "getfp", "fly", "train", "buy", "vendor", "level", "note", "skill", "learn",
		"craft", "rep", "explore", "achieve",
	];
	let list = verbs.iter().map(|v| format!("\"{v}\"")).collect::<Vec<_>>().join(", ");
	let script = String::new()
		+ r#"
		local GF, UI = Polestar.UI.GuideFrame, Polestar.UI
		local seen = {}
		local function collect()
			for _, f in ipairs(stub.frames) do
				for _, r in ipairs(f.regions) do
					if type(r.texture) == "string" then seen[r.texture] = true end
				end
			end
		end
		collect()
		uistub.openTabs({ { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }, 1); collect()
		uistub.setStep(4); collect()
		uistub.setStep(8); collect()
		Polestar.Fire("GUIDE_OUTLEVELED", uistub.elwynn, "forever/alliance/02-westfall"); collect()
		GF.menuButton:Click(); collect()
		Polestar.Set("ui.compact", true); collect()
		Polestar.Set("ui.style", "transparent"); collect()
		uistub.complete(); collect()
		Polestar.Engine.SetGuide(nil); collect()
		UI.ShowPicker(); collect()
		for _, p in ipairs(UI.Options.Pages()) do
			UI.ShowOptions(p.key); collect()
			for _, t in ipairs(p.tabs) do UI.Options.Select(p.key, t); collect() end
		end
		for _, v in ipairs({ "#
		+ &list
		+ r#" }) do seen[T.VerbIcon(v)] = true end
		local out = {}
		for p in pairs(seen) do out[#out + 1] = p end
		table.sort(out)
		emit(out)"#;
	let paths = run(&script);
	let paths: Vec<&str> = paths.as_array().unwrap().iter().map(|p| p.as_str().unwrap()).collect();
	let prefix = "Interface\\AddOns\\Polestar\\Media\\UI\\";
	let ours: Vec<&str> = paths.iter().filter_map(|p| p.strip_prefix(prefix)).collect();
	let others: Vec<&str> = paths.iter().copied().filter(|p| !p.starts_with(prefix)).collect();
	assert_eq!(others, Vec::<&str>::new(), "the UI only uses its own textures");
	for v in verbs {
		assert!(ours.contains(&format!("icon-{v}").as_str()));
	}
	for n in ["emblem", "wordmark", "band", "watermark"] {
		assert!(ours.contains(&n), "{n} is used");
	}
	let mut missing: Vec<&str> = Vec::new();
	for n in &ours {
		let file = addons_dir().join("Polestar").join("Media").join("UI").join(format!("{n}.tga"));
		if !file.exists() {
			missing.push(n);
			continue;
		}
		let b = std::fs::read(&file).unwrap();
		let w = u16::from_le_bytes([b[12], b[13]]);
		let h = u16::from_le_bytes([b[14], b[15]]);
		assert_eq!(b[2], 2, "{n}: uncompressed true-colour");
		assert!((w & w.wrapping_sub(1)) == 0 && (h & h.wrapping_sub(1)) == 0, "{n} is {w}x{h}");
		let opaque = b.iter().skip(18 + 3).step_by(4).filter(|&&x| x > 0).count();
		assert!(opaque > 0, "{n} is empty");
	}
	assert_eq!(missing, Vec::<&str>::new());
	assert!(ours.len() > 40, "the UI uses {} textures", ours.len());
}

// Dark ink on the accent fill smears under a drop shadow; light text on the night ground keeps its shadow. Both
// must survive a scheme change (every string's font is repainted) and a button switching between the two looks.
#[test]
fn a_primary_button_label_has_no_drop_shadow_a_secondary_one_keeps_it_across_scheme_changes_and_toggles() {
	let out = run(r#"
		local parent = UIParent
		local primary = W.Button(parent, "Open in new tab", nil, { primary = true, icon = "plus" })
		local secondary = W.Button(parent, "Load guide")
		local function alpha(b) local _, _, _, a = b.Label:GetShadowColor() return a end
		local out = { primary = alpha(primary), secondary = alpha(secondary) }
		Polestar.Set("ui.scheme", "night")
		out.primaryAfterScheme, out.secondaryAfterScheme = alpha(primary), alpha(secondary)
		primary.psPrimary, secondary.psPrimary = false, true
		W.RepaintButton(primary); W.RepaintButton(secondary)
		out.demoted, out.promoted = alpha(primary), alpha(secondary)
		emit(out)"#);
	assert_eq!(out["primary"], 0);
	assert_eq!(out["primaryAfterScheme"], 0);
	assert_eq!(out["promoted"], 0);
	for k in ["secondary", "secondaryAfterScheme", "demoted"] {
		assert!(out[k].as_f64().unwrap() > 0.5, "{k}: {}", out[k]);
	}
}

#[test]
fn w_link_an_address_in_the_accent_with_no_box_under_the_cursor_the_text_colour_an_accent_underline_and_click_to_copy_a_click_runs_its_action() {
	let out = run(r#"
		local parent = UIParent
		local clicked = 0
		local link = W.Link(parent, "discord.gg/example", function() clicked = clicked + 1 end, { role = "note" })
		local function rgb(r, g, b) return { r, g, b } end
		local out = { text = link.Label:GetText(), width = link:GetWidth() > 0, height = link:GetHeight(),
			atRest = rgb(link.Label:GetTextColor()), accent = rgb(T.Color("accent")), line = link.Line:IsShown(),
			skinned = link.psSkin ~= nil }
		stub.RunScript(link, "OnEnter")
		out.hover = { color = rgb(link.Label:GetTextColor()), textColor = rgb(T.Color("text")), line = link.Line:IsShown(),
			lineColor = rgb(link.Line:GetVertexColor()), tip = GameTooltip.owner == link and GameTooltip:IsShown() }
		stub.RunScript(link, "OnLeave")
		out.left = { color = rgb(link.Label:GetTextColor()), line = link.Line:IsShown() }
		link:Click()
		out.clicked = clicked
		W.SetLinkText(link, "a much longer address than before")
		out.grew = link:GetWidth() > 0 and link.Label:GetText()
		emit(out)"#);
	assert_eq!(out["text"], "discord.gg/example");
	assert_eq!(out["width"], true);
	assert_eq!(out["height"], 20);
	assert_eq!(out["atRest"], out["accent"], "the accent at rest");
	assert_eq!(out["line"], false);
	assert_eq!(out["skinned"], false, "no box");
	assert_eq!(out["hover"]["color"], out["hover"]["textColor"], "the text colour under the cursor");
	assert_eq!(out["hover"]["line"], true);
	assert_eq!(out["hover"]["lineColor"], out["accent"], "an accent underline");
	assert_eq!(out["hover"]["tip"], true);
	assert_eq!(out["left"], json!({ "color": out["accent"].clone(), "line": false }));
	assert_eq!(out["clicked"], 1);
	assert_eq!(out["grew"], "a much longer address than before");
}

// The skins (Theme.lua, "Skins"): the handoff's tokens as given, their fonts, sizes and glyphs, and a window
// repainted from one skin to the next and back.
#[test]
fn skins_polestar_by_default_halo_and_hearth_bring_their_tokens_fonts_sizes_and_glyphs_your_own_accent_still_wins() {
	let out = run(r#"
		local function c(name) return { T.Color(name) } end
		local out = { key = T.SkinKey(), choices = {} }
		for i, ch in ipairs(T.SkinChoices()) do out.choices[i] = ch.value end
		out.houseRow, out.houseHero = T.Metric("row", 40), select(2, T.FontSpec("hero"))
		Polestar.Set("ui.skin", "halo")
		out.halo = { key = T.SkinKey(), accent = c("accent"), text = c("text"), textDim = c("textDim"), npc = c("npc"), quest = c("quest"),
			veil = c("veil"), veilWindow = c("veilWindow"), menuBg = c("menuBg"), accentLine = c("accentLine"), manual = c("manual"),
			skipped = c("skipped"), success = c("success"), row = T.Metric("row", 40), font = { T.FontSpec("hero") }, icon = T.Icon("bug") }
		Polestar.Set("ui.accent", { 0.2, 0.6, 1 })
		out.ownAccent = c("accent")
		Polestar.Set("ui.accent", nil)
		Polestar.Set("ui.font", "inter")
		out.haloInter = (T.FontSpec("body"))
		Polestar.Set("ui.font", nil)
		Polestar.Set("ui.skin", "hearth")
		out.bliz = { key = T.SkinKey(), title = c("title"), text = c("text"), success = c("success"), arrive = c("arrive"),
			selected = c("selected"), row = T.Metric("row", 40), font = (T.FontSpec("body")), menuRow = T.Metric("menuRow", 26) }
		Polestar.Set("ui.skin", "nonsense")
		out.unknown = T.SkinKey()
		Polestar.Set("ui.skin", "forever")
		out.savedForever = T.SkinKey()
		emit(out)"#);
	assert_eq!(out["key"], "polestar");
	assert_eq!(out["choices"], json!(["polestar", "halo", "hearth", "forever", "blizzard", "classic"]));
	assert_eq!(out["houseRow"], 40);
	assert_eq!(out["houseHero"], 26, "the house ladder is unchanged");
	let h = &out["halo"];
	assert_eq!(h["key"], "halo");
	assert_eq!(round(&h["accent"]), vec![1.0, 0.82, 0.0, 1.0], "#FFD100");
	assert_eq!(round(&h["text"]), vec![0.957, 0.937, 0.902, 1.0], "#F4EFE6");
	assert_eq!(round(&h["textDim"]), vec![0.761, 0.725, 0.663, 1.0], "#C2B9A9");
	assert_eq!(round(&h["npc"]), vec![0.549, 0.796, 1.0, 1.0], "#8CCBFF");
	assert_eq!(round(&h["quest"]), vec![1.0, 0.878, 0.478, 1.0], "#FFE07A");
	assert_eq!(round(&h["veil"]), vec![0.031, 0.024, 0.016, 0.6], "#080604 at 60 %");
	assert_eq!(round(&h["veilWindow"])[3], 0.84);
	assert_eq!(round(&h["menuBg"])[3], 0.97);
	assert_eq!(round(&h["accentLine"]), vec![1.0, 0.82, 0.0, 0.35]);
	assert_eq!(round(&h["manual"]), vec![0.706, 0.612, 1.0, 1.0], "#B49CFF");
	assert_eq!(round(&h["skipped"]), vec![0.361, 0.784, 0.839, 1.0], "#5CC8D6");
	assert_eq!(round(&h["success"]), vec![0.373, 0.816, 0.408, 1.0], "#5FD068");
	assert_eq!(h["row"], 34);
	assert_eq!(h["font"], json!(["Interface\\AddOns\\Polestar\\Media\\Fonts\\FiraSans-SemiBold.ttf", 24, ""]), "Fira Sans, Hero 24");
	assert_eq!(h["icon"], "flag", "the report flag");
	assert_eq!(round(&out["ownAccent"])[..3], [0.2, 0.6, 1.0], "your own accent wins in a skin");
	assert_eq!(out["haloInter"], "Interface\\AddOns\\Polestar\\Media\\Fonts\\Inter-Medium.ttf", "a font picked by hand wins");
	let b = &out["bliz"];
	assert_eq!(b["key"], "hearth");
	assert_eq!(round(&b["title"]), vec![1.0, 0.82, 0.0, 1.0], "NORMAL_FONT_COLOR");
	assert_eq!(round(&b["text"]), vec![1.0, 1.0, 1.0, 1.0], "HIGHLIGHT_FONT_COLOR");
	assert_eq!(round(&b["success"]), vec![0.118, 1.0, 0.0, 1.0], "#1EFF00");
	assert_eq!(round(&b["arrive"]), vec![0.345, 0.753, 0.29, 1.0], "#58C04A");
	assert_eq!(round(&b["selected"]), vec![0.431, 0.588, 1.0, 0.28], "the options list's blue selection");
	assert_eq!(b["row"], 28);
	assert_eq!(b["menuRow"], 22);
	assert_eq!(b["font"], "Fonts\\FRIZQT__.TTF", "the game's font");
	assert_eq!(out["unknown"], "polestar", "an unknown skin is the house style");
	assert_eq!(out["savedForever"], "forever", "a saved \"forever\" choice draws the WoW Forever skin again (#306)");
}

#[test]
fn skins_a_window_repaints_from_the_house_style_to_halo_veil_no_fill_to_hearth_gradient_and_back_live() {
	let out = run(r#"
		-- A window of Polestar's own (frames a test makes stand for the game's).
		Polestar.UI.ShowOptions()
		local f = PolestarOptions
		local function state()
			local d = f.psSkin
			return { bg = d.bg ~= nil and d.bg:IsShown(), veil = d.veil ~= nil and d.veil:IsShown(),
				border = f.psBorder ~= nil and f.psBorder[1]:IsShown(), shadow = f.psShadow ~= nil and f.psShadow:IsShown() }
		end
		local out = { house = state() }
		Polestar.Set("ui.skin", "halo")
		out.halo = state()
		local v = f.psSkin.veil
		local _, _, _, a = v.parts[5]:GetVertexColor()
		out.veilAlpha = a
		Polestar.Set("ui.skin", "hearth")
		out.bliz = state()
		Polestar.Set("ui.skin", "polestar")
		out.back = state()
		emit(out)"#);
	assert_eq!(out["house"], json!({ "bg": true, "veil": false, "border": true, "shadow": true }));
	assert_eq!(out["halo"], json!({ "bg": false, "veil": true, "border": false, "shadow": false }), "Halo: the soft veil alone");
	assert_eq!((out["veilAlpha"].as_f64().unwrap() * 100.0).round() / 100.0, 0.84, "the big windows' veil");
	assert_eq!(json!({ "bg": out["bliz"]["bg"].clone(), "veil": out["bliz"]["veil"].clone() }), json!({ "bg": true, "veil": false }));
	assert_eq!(out["back"], out["house"], "back to the house style, as it was");
}

// #353: Polestar's faces have no Chinese or Hangul; text with them takes the client's font for that script,
// unless the client's locale already draws it.
#[test]
fn fonts_a_chinese_or_korean_name_takes_the_client_s_font_for_its_script_and_back_when_the_text_changes_353() {
	let out = run(r#"
		local GF = Polestar.UI.GuideFrame
		local fs = W.Text(GF.parts.nav, "hero", "text")
		local function face() return (fs:GetFont()) end
		local out = { latin = face() }
		fs:SetText("Hello, 张伟"); out.han = face()
		fs:SetText("Hello, 김민준"); out.hangul = face()
		fs:SetFormattedText("%s, %s", "Hello", "Tom — Привет"); out.back = face()
		Polestar.Set("ui.skin", "halo"); fs:SetText("Hello, 张伟"); Polestar.Set("ui.skin", "polestar"); out.repaint = face()
		GetLocale = function() return "zhCN" end
		fs:SetText("A"); fs:SetText("Hello, 张伟"); out.zhCN = face()
		fs:SetText("Hello, 김민준"); out.zhCNHangul = face()
		GetLocale = function() return "enUS" end
		uistub.player.name = "张伟"
		Polestar.UI.Welcome.Show("welcome")
		for _, f in ipairs(stub.frames) do
			for _, r in ipairs(f.regions) do
				if r.text == "Hello, 张伟" or (r.GetText and r:GetText() == "Hello, 张伟" and r ~= fs) then out.welcome = (r:GetFont()) end
			end
		end
		emit(out)"#);
	assert!(!is_match(text(&out["latin"]), r"ARKai|2002"));
	assert_eq!(out["han"], "Fonts\\ARKai_T.ttf");
	assert_eq!(out["hangul"], "Fonts\\2002.TTF");
	assert_eq!(out["back"], out["latin"], "Latin and Cyrillic go back to the face");
	assert_eq!(out["repaint"], "Fonts\\ARKai_T.ttf", "a skin change keeps it");
	assert!(!is_match(text(&out["zhCN"]), r"ARKai_T"), "a Chinese client draws it in its own font");
	assert_eq!(out["zhCNHangul"], "Fonts\\2002.TTF");
	assert_eq!(out["welcome"], "Fonts\\ARKai_T.ttf", "the welcome page's greeting");
}

// The game's looks (Theme/GameSkins.lua): each draws its own art source, and a window taken through all three
// comes back to the house style as it was.
#[test]
fn skins_wow_forever_draws_the_client_s_atlas_blizzard_the_retail_sheet_classic_the_vanilla_dialog_a_window_goes_through_them_and_back() {
	let out = run_with(
		r#"
		T._testShowHidden = true
		Polestar.UI.ShowOptions()
		local f = PolestarOptions
		local function state()
			local d = f.psSkin
			return { bg = d.bg ~= nil and d.bg:IsShown(), veil = d.veil ~= nil and d.veil:IsShown(),
				border = f.psBorder ~= nil and f.psBorder[1]:IsShown(), shadow = f.psShadow ~= nil and f.psShadow:IsShown(),
				metal = d.kit ~= nil and d.kit.metalArt ~= nil and d.kit.metal:IsShown() and d.kit.metalArt[1]:IsShown() or false,
				dialog = d.kit ~= nil and d.kit.dialog ~= nil and d.kit.dialog:IsShown() or false }
		end
		local out = { house = state() }
		Polestar.Set("ui.skin", "forever")
		out.forever = state()
		out.foreverCorner = f.psSkin.kit.metalArt[1].texture
		out.title = f.psSkin.kit.title:GetText()
		out.game = T.GameSkin()
		-- The frame's own close button and drag strip; the shell's close steps aside.
		out.close = { frame = f.psSkin.kit.closeButton:IsShown(), shell = f.Close:IsShown() }
		out.drag = f.psSkin.kit.drag:IsShown()
		Polestar.Set("ui.skin", "blizzard")
		out.blizzard = state()
		out.blizzardCorner = f.psSkin.kit.metalArt[1].texture
		Polestar.Set("ui.skin", "classic")
		out.classic = state()
		out.classicEdge = f.psSkin.kit.dialog.backdrop and f.psSkin.kit.dialog.backdrop.edgeFile
		Polestar.Set("ui.skin", "polestar")
		out.back = state()
		out.houseGame = T.GameSkin()
		emit(out)"#,
		r#"C_Texture = { GetAtlasInfo = function(name)
			return { file = "atlas:" .. name, leftTexCoord = 0, rightTexCoord = 1, topTexCoord = 0, bottomTexCoord = 1, width = 95, height = 95 }
		end }"#,
	);
	assert_eq!(out["foreverCorner"], "atlas:UI-Frame-Metal-CornerTopLeft", "Forever: the client's own art for the atlas");
	assert_eq!(out["title"], "Polestar", "the title on the metal bar");
	assert_eq!(out["game"], true);
	assert_eq!(out["close"], json!({ "frame": true, "shell": false }), "the close button sits on the frame corner");
	assert_eq!(out["drag"], true, "the title bar drags the window");
	assert_eq!(out["blizzardCorner"], 2406979, "Blizzard: the retail sheet by file ID (Theme/GameArt.lua)");
	assert_eq!(out["forever"]["metal"], true);
	assert_eq!(out["blizzard"]["metal"], true);
	assert_eq!(json!({ "metal": out["classic"]["metal"].clone(), "dialog": out["classic"]["dialog"].clone() }), json!({ "metal": false, "dialog": true }), "Classic: the dialog box, no metal");
	assert_eq!(out["classicEdge"], "Interface\\DialogFrame\\UI-DialogBox-Border");
	assert_eq!(out["back"], out["house"], "back to the house style, as it was");
	assert_eq!(out["houseGame"], false);
}

// #312: Forever's tab art is an outline. On the guide window's strip its top and left run along the window's
// edge, which left the active tab's right side as a lone line; there the active tab is the Settings list's
// selected row, the resting tabs keep their art, and the Options tabs keep theirs.
#[test]
fn skins_on_forever_the_guide_strip_marks_the_active_tab_with_the_selected_row_art_not_a_half_drawn_outline_312() {
	let out = run_with(
		r#"
		T._testShowHidden = true
		local GF = Polestar.UI.GuideFrame
		Polestar.Set("ui.skin", "forever")
		uistub.openTabs({ { uistub.elwynn, 3 }, { uistub.tailoring, 2 } }, 1)
		local function art(b)
			local k = b.psSkin and b.psSkin.kit or {}
			local lit, three = k.tabLit, k.tabArt
			return { lit = lit ~= nil and lit:IsShown() and lit.atlas or lit and lit:IsShown() and lit.texture or false,
				outline = three ~= nil and three[2]:IsShown() and three[2].texture or false }
		end
		local out = { active = art(GF.tabs[1]), rest = art(GF.tabs[2]) }
		uistub.openTabs({ { uistub.elwynn, 3 }, { uistub.tailoring, 2 } }, 2)
		out.moved = { first = art(GF.tabs[1]), second = art(GF.tabs[2]) }
		-- the Options tabs are not on the window's edge: the tab outline as the client draws it
		Polestar.UI.ShowOptions("guide")
		out.options = {}
		for _, t in ipairs(PolestarOptions.tabButtons) do
			if t:IsShown() then out.options[#out.options + 1] = art(t) end
		end
		emit(out)"#,
		r#"C_Texture = { GetAtlasInfo = function(name)
			return { file = "atlas:" .. name, leftTexCoord = 0, rightTexCoord = 1, topTexCoord = 0, bottomTexCoord = 1, width = 7, height = 26 }
		end }"#,
	);
	assert_eq!(out["active"], json!({ "lit": "atlas:Options_List_Active", "outline": false }));
	assert_eq!(out["rest"], json!({ "lit": false, "outline": "atlas:Options_Tab_Middle" }));
	assert_eq!(out["moved"], json!({ "first": { "lit": false, "outline": "atlas:Options_Tab_Middle" }, "second": { "lit": "atlas:Options_List_Active", "outline": false } }));
	let options = out["options"].as_array().unwrap();
	assert!(options.len() > 1);
	assert!(options.iter().all(|t| t["lit"] == false && truthy(&t["outline"])), "outline tabs");
	assert!(options.iter().any(|t| t["outline"] == "atlas:Options_Tab_Active_Middle"), "the active one in the active outline");
}

// #306: three Forever-skin guide-window bugs confirmed in game by Fitz (rc1).
// (a) body bleed and (b) progress bar offsets are open; fixes deferred to a later release (see #306).
// (c) Hover plates covering button content: plateLit, cardLit, navHover were HIGHLIGHT BLEND (opaque); changed
//     to ADD so hover brightens without hiding.
#[test]
fn skins_forever_hover_plates_use_add_blend_306c() {
	let out = run_with(
		r#"
		T._testShowHidden = true
		local GF = Polestar.UI.GuideFrame
		Polestar.Set("ui.skin", "forever")
		uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
		GF.PaintProgress(true)

		-- (c) hover blend mode
		local cardBtn = CreateFrame("Button")
		T.SKIN_PAINT.forever.button(cardBtn)
		local cl = cardBtn.psSkin and cardBtn.psSkin.kit and cardBtn.psSkin.kit.cardLit
		local navRow = CreateFrame("Button")
		T.KitRowLit(navRow, true, "navLit", 0)
		local hv = navRow.psSkin and navRow.psSkin.kit and navRow.psSkin.kit.navLitHover
		local pl = GF.parts.nav.Prev.psSkin and GF.parts.nav.Prev.psSkin.kit and GF.parts.nav.Prev.psSkin.kit.plateLit

		emit({ cardBlend = cl and cl[2] and cl[2].blend or false,
			navBlend  = hv and hv.blend or false,
			platBlend = pl and pl.blend or false })"#,
		r#"C_Texture = { GetAtlasInfo = function(name)
			return { file = "atlas:" .. name, leftTexCoord = 0, rightTexCoord = 1, topTexCoord = 0, bottomTexCoord = 1, width = 110, height = 110 }
		end }"#,
	);
	assert_eq!(out["cardBlend"], "ADD", "cardLit ADD");
	assert_eq!(out["navBlend"], "ADD", "navHover ADD");
	assert_eq!(out["platBlend"], "ADD", "plateLit ADD");
}

// #306 in game (Forever, after the border fix): the guide window's progress bar showed no fill, its frame
// clipped by the window's foot, and the goals' tick boxes sat on the window's border. The fill is a texture of
// its own, cropped to the value; the frame sits 7 round the bar with its 2x slice margins drawn at half; the
// check art keeps the control's proportion.
#[test]
fn skins_forever_s_progress_bar_draws_its_own_fill_to_the_bar_s_value_the_frame_round_it_at_half_its_2x_margins_the_tick_boxes_fit_their_control_306() {
	let out = run_with(
		r#"
		local GF = Polestar.UI.GuideFrame
		Polestar.Set("ui.skin", "forever")
		uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
		local b = GF.parts.foot.Status
		b:SetWidth(200)
		local k = b.psSkin.kit
		local function fill() return { shown = k.statusFill:IsShown(), w = k.statusFill:GetWidth(), u1 = k.statusFill.texCoord and k.statusFill.texCoord[2] } end
		local out = { own = b:GetStatusBarTexture():GetAlpha() }
		b:SetValue(0.5)
		out.half = fill()
		b:SetValue(0)
		out.none = fill()
		b:SetValue(1)
		out.full = fill()
		-- the frame host and its top-left corner piece
		local o = k.statusFrame
		local p = o:GetPoint(1)
		out.frame = { select(4, o:GetPoint(1)), select(5, o:GetPoint(1)), select(4, o:GetPoint(2)), select(5, o:GetPoint(2)) }
		local corner = k.statusArt[1]
		out.cap = { select(4, corner:GetPoint(2)) - select(4, corner:GetPoint(1)) }
		-- a tick box of the guide window (15) and one of Options (18)
		local small = Polestar.Widgets.Checkbox(UIParent, function() end); small:SetSize(15, 15)
		T.SKIN_PAINT.forever.checkbox(small)
		local big = Polestar.Widgets.Checkbox(UIParent, function() end); big:SetSize(18, 18)
		T.SKIN_PAINT.forever.checkbox(big)
		out.tick = { small = small.psSkin.kit.check:GetWidth(), big = big.psSkin.kit.check:GetWidth() }
		-- the border's frame under the window's content; the rows clear of it
		local F = PolestarGuideFrame
		out.edgeLevel = F.psSkin.kit.edge:GetFrameLevel() - F:GetFrameLevel()
		do
			local p, rel, rp = F.psSkin.kit.edge:GetPoint(1)
			out.edgeTop = { p, rel == F.psStrip, rp }
		end
		out.pad = { T.Metric("guidePad", 14), T.Metric("guideLitInset", 4) }
		local lit, row
		for _, r in ipairs(GF.rows or {}) do
			local t = r.psSkin and r.psSkin.kit and r.psSkin.kit.rowLit
			if t and t:IsShown() then lit, row = select(4, t:GetPoint(1)), r end
		end
		out.lit = lit or false
		-- the lit goal's tick box: its art's right edge, and the text's top, in the row
		if row then
			local cx = select(4, row.Check:GetPoint(1))
			local art = row.Check.psSkin.kit.check:GetWidth()
			out.tickRight = cx + (art - row.Check:GetWidth()) / 2
			out.textTop = select(5, row.Text:GetPoint(1))
			local p, _, rp, _, y = row.Check:GetPoint(1)
			out.tickAnchor = { p, rp, y }
		end
		-- back to the house style: the bar's own fill again
		Polestar.Set("ui.skin", "hearth")
		out.hearth = { own = b:GetStatusBarTexture():GetAlpha(), fill = k.statusFill:IsShown(), pad = T.Metric("guidePad", 14), lit = T.Metric("guideLitInset", 4) }
		emit(out)"#,
		r#"C_Texture = { GetAtlasInfo = function(name)
			local size = { ["Legacy-Progressbar-Frame"] = { 262, 52 }, ["Legacy-Progressbar-Fill"] = { 234, 24 }, ["Legacy-Progressbar-BG"] = { 234, 24 } }
			local s = size[name] or { 30, 29 }
			return { file = "atlas:" .. name, leftTexCoord = 0, rightTexCoord = 1, topTexCoord = 0, bottomTexCoord = 1, width = s[1], height = s[2] }
		end }"#,
	);
	assert_eq!(out["own"], 0, "the bar's own fill is unseen in Forever");
	assert_eq!(out["half"], json!({ "shown": true, "w": 100, "u1": 0.5 }), "half the bar, the left half of the art");
	assert_eq!(out["none"]["shown"], false, "nothing at 0");
	assert_eq!(out["full"], json!({ "shown": true, "w": 200, "u1": 1 }));
	assert_eq!(out["frame"], json!([-7, 6, 7, -7]), "7 round the bar (the art is 14 2x pixels wider than the fill a side)");
	assert_eq!(out["cap"], json!([16.5]), "the 33-pixel 2x cap drawn 16.5 wide");
	assert_eq!(out["tick"]["big"], 26, "the Settings panel box as before");
	assert!((out["tick"]["small"].as_f64().unwrap() - 15.0 * 26.0 / 18.0).abs() < 1e-9, "a 15 box: the art in the same proportion");
	assert_eq!(out["edgeLevel"], 0, "the border's frame at the window's level: the content draws over its inner shade");
	assert_eq!(out["edgeTop"], json!(["TOPLEFT", true, "BOTTOMLEFT"]), "the border hangs from the tab strip's foot, so it follows the strip into and out of compact mode");
	assert_eq!(out["pad"], json!([18, 10]), "Forever pads its rows and the lit goal clear of the border");
	assert_eq!(out["lit"], 10, "the current goal lit 10 in");
	assert!(out["tickRight"].as_f64().unwrap() <= -(10.0 + 10.0), "the tick box's art ends 10 or more inside the lit goal's outline ({})", out["tickRight"]);
	assert_eq!(out["tickAnchor"], json!(["RIGHT", "RIGHT", 0]), "the tick box on the row's middle");
	assert_eq!(out["textTop"], -8, "the lit goal's lines start 8 below its top, not 4");
	assert_eq!(out["hearth"], json!({ "own": 1, "fill": false, "pad": 12, "lit": 4 }), "Hearth: the bar's own fill back, its own sizes");
}

#[test]
fn text_size_scales_every_role_at_once_apart_from_the_window_scale_within_80_to_140_percent() {
	let out = run(r#"
		local fs = UIParent:CreateFontString()
		T.Font(fs, "title")
		local _, base = fs:GetFont()
		Polestar.Set("ui.textSize", 1.2)
		local _, bigger = fs:GetFont()
		local _, spec = T.FontSpec("title")
		Polestar.Set("ui.textSize", 3)
		local _, capped = T.FontSpec("title")
		emit({ grown = bigger / base, spec = spec == bigger, capped = capped / base, scale = Polestar.Get("ui.scale") })"#);
	assert!((out["grown"].as_f64().unwrap() - 1.2).abs() < 0.05, "a text already drawn grows with the setting: {}", out["grown"]);
	assert_eq!(out["spec"], true);
	assert!((out["capped"].as_f64().unwrap() - 1.4).abs() < 0.05, "at most 140%: {}", out["capped"]);
	assert_eq!(out["scale"], 1, "the window scale is left alone");
}
