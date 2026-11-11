//! The Skin API (Theme.lua, "The Skin API"; docs/SKINS-API.md): another addon adds a colour scheme and a skin
//! with no change to Polestar. The repository's example (addon/Polestar_Skin_Example, "Moonlit") registers,
//! shows in the pickers with its addon's name and repaints Polestar in its tokens, font and painters; specs that
//! would break the UI or the text's legibility are refused with the reason (or, for grounds too light, corrected
//! and said so); a skin whose painter or hook raises is noted once and Polestar's own look stands in for the
//! session, the saved choice kept; a saved skin whose addon is gone (or loads late) waits for it. The example is
//! never in a release, and the install check leaves skin addons alone.

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

// Core and Theme are all the Skin API needs (Theme/Theme.xml loads Theme.lua, GameSkins.lua, the widgets).
const FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml"];

fn run_full(script: &str, example: bool, saved: &str) -> Value {
	let mut addons = vec![Addon::files("Polestar", FILES)];
	if example {
		addons.push(Addon::name("Polestar_Skin_Example"));
	}
	emitted(&RunAddon {
		addons,
		saved: if saved.is_empty() { vec![] } else { vec![("Polestar".into(), saved.into())] },
		login: true,
		// The test's own frames stand for Polestar's windows; the drop shadow (a child frame Polestar would make
		// under them) is off so the fake client's rule against frames under a game frame does not trip.
		script: format!(
			"local T = Polestar.Theme\nPolestar.Set(\"ui.shadow\", false)\nlocal function hexOf(c) return string.format(\"%02x%02x%02x\", math.floor(c[1] * 255 + 0.5), math.floor(c[2] * 255 + 0.5), math.floor(c[3] * 255 + 0.5)) end\n{script}"
		),
		..Default::default()
	})
	.remove(0)
}

fn run(script: &str) -> Value {
	run_full(script, true, "")
}

#[test]
fn the_example_addon_registers_moonlit_and_applying_it_repaints_polestar_in_its_tokens_font_and_painters() {
	let out = run(r##"
		local out = { skins = {}, schemes = {} }
		for i, c in ipairs(T.SkinChoices()) do out.skins[i] = { c.value, c.text, c.addon or false } end
		for i, c in ipairs(T.SchemeChoices()) do out.schemes[i] = { c.value, c.text, c.addon or false } end
		local info = T.SkinInfo("moonlit")
		out.info = { info.name, info.addon, info.base, info.scheme, info.builtin }
		local win = CreateFrame("Frame")
		win:SetSize(300, 200)
		T.Skin(win, "window")
		local fs = win:CreateFontString(nil, "OVERLAY")
		T.Font(fs, "body")
		Polestar.Set("ui.skin", "moonlit")
		local pal = T.Palette()
		out.id, out.key = T.SkinId(), T.SkinKey()
		out.bg, out.text, out.accent, out.sky = hexOf(pal.bg), hexOf(pal.text), hexOf(pal.accent), hexOf(pal.sky)
		out.legible = T.Legibility(pal) >= 1
		out.body = (T.FontSpec("body"))
		out.hero = select(2, T.FontSpec("hero"))
		out.fs = (fs:GetFont())
		out.ground = hexOf({ win.psSkin.bg:GetVertexColor() })
		local moon = win.psSkin.kit and win.psSkin.kit.api and win.psSkin.kit.api.moon
		out.moon = moon and moon:IsShown() or false
		out.arrow, out.icons = T.SkinArrowStyle(), T.SkinMapIcons()
		-- The player's own accent still wins over the scheme's moonlight.
		Polestar.Set("ui.accent", { 0.2, 0.6, 1 })
		out.ownAccent = hexOf(T.Palette().accent)
		Polestar.Set("ui.accent", nil)
		-- A picker card draws another skin without touching the live one.
		local card = CreateFrame("Frame")
		card:SetSize(120, 72)
		T.DrawSkinCard(card, "halo")
		out.card = hexOf({ card.psSkinCard.ground:GetVertexColor() })
		T.DrawSchemeCard(card, "night")
		out.schemeCard = hexOf({ card.psSkinCard.ground:GetVertexColor() })
		out.stillMoonlit = T.SkinId() == "moonlit" and hexOf(T.Palette().bg) == out.bg
		-- The Moonlit scheme alone, under Polestar's own skin.
		Polestar.Set("ui.skin", "polestar")
		out.moonAfter = moon:IsShown()
		out.house = hexOf(T.Palette().bg)
		Polestar.Set("ui.scheme", "moonlit")
		out.schemeOnly = { hexOf(T.Palette().bg), hexOf(T.Palette().accent), T.SchemeKey() }
		-- The built-ins went through the same registration with nothing to say
		-- (legible as they are, never corrected).
		local notes = {}
		for _, l in ipairs(Polestar.DebugLog(400)) do
			if tostring(l):find("(nil): ", 1, true) then notes[#notes + 1] = tostring(l) end
		end
		out.builtinNotes = table.concat(notes, " | ")
		emit(out)"##);
	let skins: Vec<Value> = out["skins"].as_array().unwrap().clone();
	let values: Vec<&str> = skins.iter().map(|s| s[0].as_str().unwrap()).collect();
	assert_eq!(values, ["polestar", "halo", "hearth", "forever", "blizzard", "classic", "moonlit"], "the built-ins first, unchanged");
	assert_eq!(skins[6], json!(["moonlit", "Moonlit", "Polestar_Skin_Example"]));
	assert_eq!(skins[0][2], false, "a built-in has no addon");
	let schemes: Vec<&str> = out["schemes"].as_array().unwrap().iter().map(|s| s[0].as_str().unwrap()).collect();
	assert_eq!(schemes, ["dusk", "night", "graphite", "moonlit"]);
	assert_eq!(out["schemes"][3], json!(["moonlit", "Moonlit", "Polestar_Skin_Example"]));
	assert_eq!(out["info"], json!(["Moonlit", "Polestar_Skin_Example", "polestar", "moonlit", false]));
	assert_eq!((out["id"].as_str(), out["key"].as_str()), (Some("moonlit"), Some("polestar")), "SkinKey: the built-in look it extends");
	assert_eq!(out["bg"], "12142a", "the scheme's own grounds, as given (legible as they are)");
	assert_eq!(out["sky"], "2b3060");
	assert_eq!(out["text"], "f2f3fa");
	assert_eq!(out["accent"], "afc0ff", "the scheme's accent stands in for Polestar gold");
	assert_eq!(out["legible"], true);
	assert!(out["body"].as_str().unwrap().ends_with("FiraSans-Medium.ttf"), "{}", out["body"]);
	assert!(out["fs"].as_str().unwrap().ends_with("FiraSans-Medium.ttf"), "live strings repainted: {}", out["fs"]);
	assert_eq!(out["hero"], 24.0);
	assert_eq!(out["ground"], "12142a", "the window repainted in its ground");
	assert_eq!(out["moon"], true, "its window painter ran");
	assert_eq!((out["arrow"].as_str(), out["icons"].as_str()), (Some("halo"), Some("halo")));
	assert_eq!(out["ownAccent"], "3399ff");
	assert_eq!(out["card"], "080604", "Halo's ground on the card");
	assert_eq!(out["schemeCard"], "0a0d16", "Night's ground on the card");
	assert_eq!(out["stillMoonlit"], true);
	assert_eq!(out["moonAfter"], false, "its pieces hidden when another skin paints the window");
	assert_eq!(out["house"], "181d2d", "Dusk again");
	assert_eq!(out["schemeOnly"], json!(["12142a", "afc0ff", "moonlit"]));
	assert_eq!(out["builtinNotes"], "", "a built-in palette fails the legibility rule");
}

#[test]
fn invalid_specs_are_refused_with_the_reason_and_grounds_too_light_are_darkened_and_said_so() {
	let out = run(r##"
		local good = { bg = "#101010", panel = "#141414", panelAlt = "#1a1a1a", sidebar = "#0c0c0c", footer = "#0e0e0e", sky = "#202020",
			text = "#ffffff", textDim = "#cccccc", textMuted = "#a0a0a0" }
		local function scheme(over, extra)
			local t = {}
			for k, v in pairs(good) do t[k] = v end
			for k, v in pairs(over or {}) do t[k] = v ~= false and v or nil end
			local s = { name = "X", addon = "Test", tokens = t }
			for k, v in pairs(extra or {}) do s[k] = v end
			return s
		end
		local function try(fn, id, spec)
			local ok, msg = fn(id, spec)
			return { ok = ok, msg = msg or false }
		end
		local S, K = T.RegisterScheme, T.RegisterSkin
		local out = {}
		out.plain = try(S, "plain", scheme())
		out.missing = try(S, "a1", scheme({ textMuted = false }))
		out.colour = try(S, "a2", scheme({ text = "#zzz" }))
		out.range = try(S, "a3", scheme({ text = { 1.2, 1, 1 } }))
		out.token = try(S, "a4", scheme({ txet = "#ffffff" }))
		out.field = try(S, "a5", scheme(nil, { colour = 1 }))
		out.api = try(S, "a6", scheme(nil, { api = 3 }))
		out.dup = try(S, "plain", scheme())
		out.builtin = try(S, "dusk", scheme())
		out.id = try(S, "1abc", scheme())
		out.addon = try(S, "a7", scheme(nil, { addon = false }))
		out.skinToken = try(S, "a8", scheme({ accent = "#ff0000" }))
		local grey = { bg = "#8a8a8a", panel = "#8a8a8a", panelAlt = "#909090", sidebar = "#858585", footer = "#858585", sky = "#959595" }
		out.light = try(S, "light", scheme(grey))
		out.lightBg = T.SCHEMES.light and hexOf(T.SCHEMES.light.bg) or false
		out.lightLegible = T.SCHEMES.light and T.Contrast(T.SCHEMES.light.textMuted, T.SCHEMES.light.panelAlt) >= 4.5 or false
		out.strict = try(S, "light2", scheme(grey, { strict = true }))
		out.dark = try(S, "dark", scheme({ text = "#303030", textDim = "#303030", textMuted = "#303030" }))
		out.notListed = #T.SchemeChoices()
		local skin = function(extra)
			local s = { name = "Y", addon = "Test" }
			for k, v in pairs(extra or {}) do s[k] = v end
			return s
		end
		out.base = try(K, "b1", skin({ base = "nope" }))
		out.scheme404 = try(K, "b2", skin({ scheme = "nope" }))
		out.schemeOnHalo = try(K, "b3", skin({ base = "halo", scheme = "plain" }))
		out.kind = try(K, "b4", skin({ paint = { windw = function() end } }))
		out.notFn = try(K, "b5", skin({ paint = { window = "red" } }))
		out.font = try(K, "b6", skin({ font = "comic" }))
		out.arrow = try(K, "b7", skin({ arrow = "spiral" }))
		out.skinDup = try(K, "halo", skin())
		out.skinOk = try(K, "pink", skin({ base = "halo", tokens = { accent = "#ff00ff" }, scheme = nil }))
		Polestar.Set("ui.skin", "pink")
		out.pink = { T.SkinKey(), hexOf(T.Palette().accent), hexOf(T.Palette().bg) }
		emit(out)"##);
	let refused = |k: &str, pat: &str| {
		assert_eq!(out[k]["ok"], false, "{k}: {}", out[k]);
		let msg = out[k]["msg"].as_str().unwrap_or("");
		assert!(msg.contains(pat), "{k}: {msg:?} should say {pat:?}");
	};
	assert_eq!(out["plain"], json!({ "ok": true, "msg": false }));
	refused("missing", "tokens.textMuted is missing");
	refused("colour", "token \"text\" is not a colour");
	refused("range", "token \"text\" is not a colour");
	refused("token", "unknown token \"txet\"");
	refused("field", "unknown field \"colour\"");
	refused("api", "needs Skin API 3; this Polestar has 2");
	refused("dup", "the id \"plain\" is taken (Test)");
	refused("builtin", "the id \"dusk\" is taken (Polestar)");
	refused("id", "the id must be a word");
	refused("addon", "addon must be your addon's folder name");
	refused("skinToken", "tokens.accent belongs to a skin");
	assert_eq!(out["light"]["ok"], true, "{}", out["light"]);
	let note = out["light"]["msg"].as_str().unwrap();
	assert!(note.contains("reads") && note.contains("darkened"), "{note}");
	assert_ne!(out["lightBg"], "8a8a8a", "the stored grounds are the corrected ones");
	assert_eq!(out["lightLegible"], true);
	refused("strict", "on ");
	assert!(out["strict"]["msg"].as_str().unwrap().contains(":1, needs "), "{}", out["strict"]);
	refused("dark", "even with the grounds at their darkest");
	assert_eq!(out["notListed"], 6, "dusk, night, graphite, the example's moonlit, plain, light: no refused one listed");
	refused("base", "base must be one of Polestar's skins");
	refused("scheme404", "scheme \"nope\" is not registered");
	refused("schemeOnHalo", "scheme goes with base \"polestar\"");
	refused("kind", "unknown paint \"windw\"");
	refused("notFn", "paint.window has the wrong type");
	refused("font", "font must be");
	refused("arrow", "arrow must be");
	refused("skinDup", "the id \"halo\" is taken (Polestar)");
	assert_eq!(out["skinOk"], json!({ "ok": true, "msg": false }));
	assert_eq!(out["pink"], json!(["halo", "ff00ff", "080604"]), "Halo's palette under its own accent");
}

#[test]
fn a_throwing_painter_or_hook_is_noted_once_and_polestars_own_look_stands_in_for_the_session_keeping_the_choice() {
	let out = run(r##"
		local out = {}
		local calls = 0
		out.reg = { T.RegisterSkin("broken", { name = "Broken", addon = "Test_Broken", tokens = { bg = "#202040" },
			paint = { window = function() calls = calls + 1; error("boom") end } }) }
		local win = CreateFrame("Frame")
		win:SetSize(300, 200)
		T.Skin(win, "window")
		Polestar.Set("ui.skin", "broken")
		out.id, out.saved, out.failed = T.SkinId(), Polestar.Get("ui.skin"), T.SkinInfo("broken").failed or false
		out.ground = hexOf({ win.psSkin.bg:GetVertexColor() })
		local function count(pat, list, field)
			local n = 0
			for _, e in ipairs(list) do if tostring(field and e[field] or e):find(pat, 1, true) then n = n + (field and e.count or 1) end end
			return n
		end
		T.Refresh()
		T.Repaint(win)
		local other = CreateFrame("Frame")
		T.Skin(other, "window")
		out.calls = calls
		out.errors = count("skin broken (Test_Broken)", Polestar.Errors(), "msg")
		out.said = count("Broken (from Test_Broken)", stub.messages)
		-- A hook that raises does the same.
		T.RegisterSkin("hooky", { name = "Hooky", addon = "Test_Hooky", hooks = { arrow = function() error("hook") end } })
		Polestar.Set("ui.skin", "hooky")
		out.hookyOn = T.SkinId()
		out.hook = T.SkinHook("arrow", win, "3d")
		out.hookyAfter = T.SkinId()
		out.hookErrors = count("skin hooky (Test_Hooky)", Polestar.Errors(), "msg")
		-- So does an onApply that raises; a working skin's hook runs.
		T.RegisterSkin("apply", { name = "Apply", addon = "Test_Apply", onApply = function() error("apply") end })
		Polestar.Set("ui.skin", "apply")
		out.applyAfter = T.SkinId()
		local seen
		T.RegisterSkin("fine", { name = "Fine", addon = "Test_Fine", hooks = { pin = function(f) seen = f end } })
		Polestar.Set("ui.skin", "fine")
		out.fineHook = T.SkinHook("pin", win) and seen == win
		out.noHook = T.SkinHook("arrow", win)
		emit(out)"##);
	assert_eq!(out["reg"], json!([true]));
	assert_eq!(out["id"], "polestar", "off for the session");
	assert_eq!(out["saved"], "broken", "the saved choice is kept (a fixed addon gets it back after a reload)");
	assert!(out["failed"].as_str().unwrap().contains("boom"), "{}", out["failed"]);
	assert_eq!(out["ground"], "181d2d", "repainted in Dusk, not the broken skin's ground");
	assert_eq!(out["calls"], 1, "never called again this session");
	assert_eq!(out["errors"], 1, "noted once");
	assert_eq!(out["said"], 1, "one chat line");
	assert_eq!(out["hookyOn"], "hooky");
	assert_eq!(out["hook"], false);
	assert_eq!(out["hookyAfter"], "polestar");
	assert_eq!(out["hookErrors"], 1);
	assert_eq!(out["applyAfter"], "polestar");
	assert_eq!(out["fineHook"], true);
	assert_eq!(out["noHook"], false, "no hook for that surface: nothing runs");
}

#[test]
fn a_saved_skin_whose_addon_is_missing_draws_polestar_keeps_the_choice_and_applies_when_the_addon_registers_late() {
	let out = run_full(
		r##"
		local out = {}
		local win = CreateFrame("Frame")
		win:SetSize(300, 200)
		T.Skin(win, "window")
		out.before = { T.SkinId(), Polestar.Get("ui.skin"), T.SchemeKey(), Polestar.Get("ui.scheme") }
		out.choices = #T.SkinChoices()
		out.reg = { T.RegisterScheme("lateScheme", { name = "Late", addon = "Test_Late", tokens = { bg = "#101828", panel = "#141c30",
			panelAlt = "#1c2640", sidebar = "#0c1220", footer = "#0e1424", sky = "#243050", text = "#ffffff", textDim = "#c8d0e0",
			textMuted = "#a0aac0" } }) }
		out.scheme = T.SchemeKey()
		T.RegisterSkin("late", { name = "Late", addon = "Test_Late", base = "hearth", tokens = { bg = "#301008" } })
		out.after = { T.SkinId(), T.SkinKey(), T.GameSkin() }
		out.ground = win.psSkin.skin
		emit(out)"##,
		false,
		r##"PolestarDB = { schema = 1, settings = { ui = { skin = "late", scheme = "lateScheme" } } }"##,
	);
	assert_eq!(out["before"], json!(["polestar", "late", "dusk", "lateScheme"]), "drawn as Polestar, the choice kept");
	assert_eq!(out["choices"], 6);
	assert_eq!(out["reg"], json!([true]));
	assert_eq!(out["scheme"], "lateScheme");
	assert_eq!(out["after"], json!(["late", "hearth", true]), "applied as it registers; a skin on Hearth is a game skin");
	assert_eq!(out["ground"], "late/hearth", "the window repainted then (the skin and the look it is drawn from)");
}

#[test]
fn a_skin_s_own_window_border_token_edges_its_windows_under_the_player_s_border_colour() {
	let out = run(r##"
		local out = {}
		for _, base in ipairs({ "polestar", "hearth" }) do
			local id = "edged" .. base
			out[base] = { reg = T.RegisterSkin(id, { name = "Edged", addon = "Test_Edged", base = base, tokens = { windowBorder = "#5e4a2c" } }) }
			Polestar.Set("ui.skin", id)
			out[base].own = hexOf(T.Palette().windowBorder)
			Polestar.Set("ui.borderColor", { 0.2, 0.4, 0.6 })
			out[base].player = hexOf(T.Palette().windowBorder)
			Polestar.Set("ui.borderColor", false)
		end
		Polestar.Set("ui.skin", "polestar")
		out.house = hexOf(T.Palette().windowBorder) == hexOf(T.Palette().border)
		emit(out)"##);
	for base in ["polestar", "hearth"] {
		let o = &out[base];
		assert_eq!(o["reg"], true, "{base}");
		assert_eq!(o["own"], "5e4a2c", "the skin's windowBorder on base {base}");
		assert_eq!(o["player"], "336699", "the player's border colour wins on base {base}");
	}
	assert_eq!(out["house"], true, "the house style keeps its hairline");
}

// The guide window's close square (the guideTitle hook shows it) reads closeFill, closeEdge and closeGlyph: a skin's
// own, else danger, border and text on every base.
#[test]
fn the_close_square_tokens_fall_back_on_danger_border_and_text_on_every_base() {
	let out = run(r##"
		local out = {}
		for _, base in ipairs({ "polestar", "hearth", "halo" }) do
			local plain, own = "plain" .. base, "own" .. base
			T.RegisterSkin(plain, { name = "Plain", addon = "Test_Plain", base = base })
			T.RegisterSkin(own, { name = "Own", addon = "Test_Own", base = base, tokens = { closeFill = "#9c211d", closeEdge = "#43331e", closeGlyph = "#f0e6d2" } })
			Polestar.Set("ui.skin", plain)
			local p = T.Palette()
			out[base] = { fill = hexOf(p.closeFill) == hexOf(p.danger), edge = hexOf(p.closeEdge) == hexOf(p.border), glyph = hexOf(p.closeGlyph) == hexOf(p.text) }
			Polestar.Set("ui.skin", own)
			p = T.Palette()
			out[base].own = { hexOf(p.closeFill), hexOf(p.closeEdge), hexOf(p.closeGlyph) }
		end
		Polestar.Set("ui.skin", "polestar")
		emit(out)"##);
	for base in ["polestar", "hearth", "halo"] {
		let o = &out[base];
		assert_eq!((o["fill"].clone(), o["edge"].clone(), o["glyph"].clone()), (json!(true), json!(true), json!(true)), "the fallbacks on base {base}: {o}");
		assert_eq!(o["own"], json!(["9c211d", "43331e", "f0e6d2"]), "the skin's own on base {base}");
	}
}

#[test]
fn api_version_and_capabilities_say_what_this_polestar_offers() {
	let out = run(r##"
		emit({ v = T.API_VERSION, skins = T.HasCapability("skins"), schemes = T.HasCapability("schemes"),
			window = T.HasCapability("surfaces.window"), toast = T.HasCapability("surfaces.toast"),
			arrow = T.HasCapability("surfaces.arrow"), pin = T.HasCapability("surfaces.pin"), fonts = T.HasCapability("fonts"),
			preset = T.HasCapability("preset"), light = T.HasCapability("lightSchemes"), title = T.HasCapability("surfaces.guideTitle"),
			nope = T.HasCapability("surfaces.nope"), odd = T.HasCapability(nil), n = #T.Capabilities() })"##);
	assert_eq!(out["v"], 2);
	for k in ["skins", "schemes", "window", "toast", "arrow", "pin", "fonts", "preset", "light", "title"] {
		assert_eq!(out[k], true, "{k}");
	}
	assert_eq!((out["nope"].clone(), out["odd"].clone()), (json!(false), json!(false)));
	assert!(out["n"].as_u64().unwrap() >= 20);
}

// A skin's preset: the settings it recommends, checked against Polestar's own (the key exists, the value has its
// default's type, a look setting only), never applied by itself; applying it goes through Polestar.Set, repaints
// once, and Undo puts every setting back, also the colour source it turned off.
#[test]
fn a_skin_preset_is_checked_against_the_settings_applied_only_on_request_and_undone() {
	let out = run(r##"
		-- UI/UI.lua's colour-source defaults (not loaded here).
		Polestar.RegisterDefaults("ui", { accent = false, classAccent = false, matchAccent = false })
		local out = {}
		local function try(preset)
			local ok, msg = T.RegisterSkin("p" .. tostring(math.random(1e6)), { name = "P", addon = "Test_P", preset = preset })
			return { ok = ok, msg = msg or false }
		end
		out.unknown = try({ ["ui.nope"] = 1 })
		out.type = try({ ["ui.headingSize"] = "big" })
		out.colour = try({ ["ui.panelColor"] = "red" })
		out.behaviour = try({ ["behavior.autoAccept"] = true })
		out.skin = try({ ["ui.skin"] = "halo" })
		out.path = try({ scale = 1 })
		out.empty = try({})
		out.reg = { T.RegisterSkin("layout", { name = "Layout", addon = "Test_Layout", preset = {
			["ui.fontOutline"] = "outline", ["ui.headingSize"] = 1.2, ["ui.panelColor"] = "#203040", ["ui.haze"] = false,
			["ui.accent"] = { 0.2, 0.6, 1 } } }) }
		out.none = T.SkinPreset("halo") == nil
		local p = T.SkinPreset("layout")
		out.preset = { p["ui.fontOutline"], p["ui.headingSize"], p["ui.haze"], hexOf(p["ui.panelColor"]) }
		p["ui.headingSize"] = 9
		out.copy = T.SkinPreset("layout")["ui.headingSize"]
		-- Choosing the skin applies nothing.
		Polestar.Set("ui.classAccent", true)
		Polestar.Set("ui.skin", "layout")
		out.untouched = { Polestar.Get("ui.fontOutline"), Polestar.Get("ui.headingSize"), Polestar.Get("ui.haze") }
		local refreshes = 0
		T.OnChanged(function() refreshes = refreshes + 1 end)
		out.applied = { T.ApplySkinPreset("layout") }
		out.refreshes = refreshes
		out.after = { Polestar.Get("ui.fontOutline"), Polestar.Get("ui.headingSize"), Polestar.Get("ui.haze"),
			hexOf(Polestar.Get("ui.panelColor")), hexOf(T.Palette().accent), Polestar.Get("ui.classAccent") }
		out.outline = select(3, T.FontSpec("body"))
		out.which = T.SkinPresetApplied()
		out.undo = T.UndoSkinPreset()
		out.back = { Polestar.Get("ui.fontOutline"), Polestar.Get("ui.headingSize"), Polestar.Get("ui.haze"),
			Polestar.Get("ui.panelColor"), Polestar.Get("ui.accent"), Polestar.Get("ui.classAccent") }
		out.stored = PolestarDB.settings.ui.fontOutline == nil and PolestarDB.settings.ui.headingSize == nil
		out.again = T.UndoSkinPreset()
		out.which2 = T.SkinPresetApplied() or false
		out.noPreset = { T.ApplySkinPreset("halo") }
		emit(out)"##);
	let refused = |k: &str, pat: &str| {
		assert_eq!(out[k]["ok"], false, "{k}: {}", out[k]);
		let msg = out[k]["msg"].as_str().unwrap_or("");
		assert!(msg.contains(pat), "{k}: {msg:?} should say {pat:?}");
	};
	refused("unknown", "Polestar has no setting \"ui.nope\"");
	refused("type", "preset.ui.headingSize must be a number");
	refused("colour", "preset.ui.panelColor must be false or a colour");
	refused("behaviour", "not a look setting");
	refused("skin", "not a look setting");
	refused("path", "is not a setting path");
	refused("empty", "preset is empty");
	assert_eq!(out["reg"], json!([true]));
	assert_eq!(out["none"], true);
	assert_eq!(out["preset"], json!(["outline", 1.2, false, "203040"]));
	assert_eq!(out["copy"], 1.2, "SkinPreset hands out a copy");
	assert_eq!(out["untouched"], json!(["none", 1, true]), "never applied by choosing the skin");
	assert_eq!(out["applied"], json!([true]));
	assert_eq!(out["refreshes"], 1, "one repaint for the whole preset");
	assert_eq!(out["after"], json!(["outline", 1.2, false, "203040", "3399ff", false]), "your own accent turned the class accent off");
	assert_eq!(out["outline"], "OUTLINE");
	assert_eq!(out["which"], "layout");
	assert_eq!(out["undo"], true);
	assert_eq!(out["back"], json!(["none", 1, true, false, false, true]), "every setting as it was, the class accent too");
	assert_eq!(out["stored"], true, "values equal to their defaults are not stored");
	assert_eq!((out["again"].clone(), out["which2"].clone()), (json!(false), json!(false)));
	assert_eq!(out["noPreset"], json!([false, "this skin has no preset"]));
}

// A light scheme (dark text on parchment): the guard lifts its grounds instead of darkening them, at registration
// and live, so a negative brightness or a dark ground colour can never send a light palette's grounds to black.
#[test]
fn a_light_scheme_is_lifted_not_darkened_so_brightness_or_a_dark_ground_never_sends_it_to_black() {
	let out = run(r##"
		local tokens = {
			bg = "#f2e8d0", panel = "#f5ecd6", panelAlt = "#e8dcc0", sidebar = "#ebe0c6", footer = "#ece2c9", sky = "#e0d2ae",
			text = "#1e1a14", textDim = "#463e32", textMuted = "#574e40", ink = "#000000", star = "#7a6a40",
			success = "#1f6b2e", warning = "#7a4a00", danger = "#9a1f1f", quest = "#6e4a00", npc = "#1d4f8a", item = "#5a3a9a",
			place = "#8a3f1a", object = "#5a4a2a", level = "#1e1a14", skill = "#2e6a1e", spell = "#1a5a6a", faction = "#8a2a5a",
			area = "#7a4a2a", achievement = "#8a4a00", dungeon = "#4a2a9a", rare = "#9a3a10",
		}
		local out = {}
		out.reg = { T.RegisterScheme("parchment", { name = "Parchment", addon = "Test_Light", tokens = tokens, accent = "#8a5a00" }) }
		local function L(c) return T.Luminance(c[1], c[2], c[3]) end
		local function state()
			local pal = T.Palette()
			return { light = L(pal.bg) > L(pal.text), legible = T.Legibility(pal) >= 1, bg = L(pal.bg), bgHex = hexOf(pal.bg) }
		end
		Polestar.Set("ui.scheme", "parchment")
		out.plain = state()
		Polestar.Set("ui.brightness", -1)
		out.dimmed = state()
		Polestar.Set("ui.brightness", 0)
		Polestar.Set("ui.bgColor", { 0.12, 0.1, 0.08 })
		out.dark = state()
		Polestar.Set("ui.bgColor", false)
		-- Grounds a little too grey for its text: lifted at registration, and said so.
		local grey = {}
		for k, v in pairs(tokens) do grey[k] = v end
		grey.bg, grey.panel, grey.panelAlt, grey.sidebar, grey.footer, grey.sky = "#b8ae96", "#bcb29a", "#b0a68e", "#b4aa92", "#b6ac94", "#aca288"
		local ok, note = T.RegisterScheme("dusty", { name = "Dusty", addon = "Test_Light", tokens = grey })
		out.dusty = { ok, note or false, L(T.SCHEMES.dusty.panelAlt) > L(T.HexColor("b0a68e")) }
		-- A dark scheme is still darkened.
		Polestar.Set("ui.scheme", "dusk")
		Polestar.Set("ui.brightness", 1)
		out.duskBright = { T.Legibility(T.Palette()) >= 1, L(T.Palette().bg) < L(T.Palette().text) }
		emit(out)"##);
	assert_eq!(out["reg"], json!([true]), "legible as given: no note");
	assert_eq!(out["plain"]["bgHex"], "f2e8d0");
	for k in ["plain", "dimmed", "dark"] {
		assert_eq!(out[k]["light"], true, "{k}: {}", out[k]);
		assert_eq!(out[k]["legible"], true, "{k}: {}", out[k]);
		assert!(out[k]["bg"].as_f64().unwrap() > 0.4, "{k}: grounds kept light: {}", out[k]);
	}
	assert_eq!(out["dusty"][0], true);
	let note = out["dusty"][1].as_str().unwrap();
	assert!(note.contains("lightened"), "{note}");
	assert_eq!(out["dusty"][2], true, "the stored grounds are lighter");
	assert_eq!(out["duskBright"], json!([true, true]));
}

#[test]
fn the_example_is_never_in_a_release_and_the_install_check_leaves_skin_addons_alone() {
	let release = forge_release::addons::release_addons(&addons_dir());
	assert!(!release.names.iter().any(|n| n.starts_with("Polestar_Skin_")), "{:?}", release.names);
	assert!(addons_dir().join("Polestar_Skin_Example/Polestar_Skin_Example.toc").exists());
	let out = emitted(&RunAddon {
		before: r##"stub.addons = { { name = "Polestar" }, { name = "Polestar_Nav" }, { name = "Polestar_Skin_Example" }, { name = "Polestar_Skin_Moonlit" } }
stub.addonMeta["Polestar_Nav"] = { Version = "0.0.1" }
stub.addonMeta["Polestar_Skin_Example"] = { Version = "9.9.9" }
stub.addonMeta["Polestar_Skin_Moonlit"] = { Version = "1.0" }"##
			.into(),
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Core/Data.lua"])],
		login: true,
		script: "local _, stale = Polestar.Data.CheckInstall()\nemit(table.concat(stale, \",\"))".into(),
		..Default::default()
	});
	assert_eq!(out[0], "Polestar_Nav 0.0.1", "a skin addon has its own version");
}
