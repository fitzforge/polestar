//! The Skin API (Theme/SkinApi.lua, Theme/Theme.lua; docs/skins): another addon adds a colour scheme and a skin
//! with no change to Polestar. The repository's example (addon/Polestar_Skin_Example, "Moonlit") registers,
//! shows in the pickers with its addon's name and repaints Polestar in its tokens, font and painters, and its
//! hooks run on every surface a skin can reach (the guide window, the arrow, the pins, the cards, the toasts,
//! the buttons) and their pieces go with it; specs that would break the UI or the text's legibility are refused
//! with the reason (or, for grounds too light, corrected and said so); a skin whose painter or hook raises is
//! noted once and Polestar's own look stands in for the session, the saved choice kept; a saved skin whose addon
//! is gone (or loads late) waits for it, and one whose addon loads on demand is loaded; a spec written for an
//! older Skin API keeps working. The example is never in a release, and the install check leaves skin addons alone.

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

// Core and Theme are all the Skin API needs (Theme/Theme.xml loads Theme.lua, the Skin API, the widgets); its
// checks (Polestar_SkinAPI) load on demand with the first registration, the game looks and Hearth
// (Polestar_Looks) the first time one is painted, and the picker's cards and the presets load with the settings
// window (Polestar_Options/Theme/SkinPicker.lua).
const FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml"];

fn picker() -> Addon {
	Addon::files("Polestar_Options", &["Theme/SkinPicker.lua"])
}

fn run_full(script: &str, example: bool, saved: &str) -> Value {
	let mut addons = vec![Addon::files("Polestar", FILES), picker()];
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
		out.info = { info.name, info.addon, info.base, info.scheme, info.builtin, info.api, T.SchemeInfo("moonlit").api }
		out.variants = T.SkinVariants("moonlit")
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
		-- The painter's own pieces: in its store, one per skin (kit.store).
		local moon = win.psSkin.kit and win.psSkin.kit.api and win.psSkin.kit.api.moonlit and win.psSkin.kit.api.moonlit.moon
		out.moon = moon and moon:IsShown() or false
		out.arrow, out.icons = T.SkinArrowStyle(), T.SkinMapIcons()
		-- Its tokens over the scheme, in its default variant and then the other.
		out.full = { T.SkinVariant("moonlit"), hexOf({ T.SkinToken("glow") }), hexOf({ T.SkinToken("pinRing") }), hexOf({ T.SkinToken("pinFill") }) }
		Polestar.Set("ui.skinVariants.moonlit", "new")
		out.new = { T.SkinVariant("moonlit"), hexOf({ T.SkinToken("glow") }), hexOf({ T.SkinToken("pinRing") }), hexOf({ T.SkinToken("pinFill") }) }
		Polestar.Set("ui.skinVariants.moonlit", nil)
		-- The player's own accent still wins over the scheme's moonlight.
		Polestar.Set("ui.accent", { 0.2, 0.6, 1 })
		out.ownAccent = hexOf(T.Palette().accent)
		Polestar.Set("ui.accent", nil)
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
	assert_eq!(out["info"], json!(["Moonlit", "Polestar_Skin_Example", "polestar", "moonlit", false, 2, 2]), "written for Skin API 2");
	assert_eq!(out["variants"], json!([{ "id": "full", "name": "Full moon", "desc": "Silver moonlight." }, { "id": "new", "name": "New moon", "desc": "A darker night, the moonlight blue." }]));
	assert_eq!(out["full"], json!(["full", "c8d4ff", "dfe4f7", "8fa3ff"]), "the skin's own tokens");
	assert_eq!(out["new"], json!(["new", "6f8dff", "9fb4ff", "8fa3ff"]), "the variant's tokens over the skin's, the rest kept");
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
		-- What a scheme may not give, and messages that say the limit.
		out.author = try(S, "a9", scheme(nil, { author = string.rep("x", 41) }))
		out.gameToken = try(S, "a10", scheme({ bgBottom = "#101010" }))
		out.edgeToken = try(S, "a11", scheme({ windowEdge = "#101010" }))
		out.glowScheme = try(S, "a12", scheme({ glow = "#ffffff" }))
		-- White text reads on these grounds; Polestar's own dungeon violet does not.
		local mid = { bg = "#383838", panel = "#383838", panelAlt = "#383838", sidebar = "#383838", footer = "#383838", sky = "#202020",
			textDim = "#cccccc", textMuted = "#a8a8a8" }
		out.subjects = try(S, "a13", scheme(mid, { strict = true }))
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
		out.sizes = try(K, "b8", skin({ fontSizes = { hero = 50 } }))
		out.role = try(K, "b9", skin({ fontSizes = { heor = 20 } }))
		out.skinTokens = try(K, "b10", skin({ tokens = { accent2 = "#a0b0ff", glow = "#ffffff", pinRing = "#ffffff", pinFill = "#ff0000" } }))
		out.hookName = try(K, "b11", skin({ hooks = { cards = function() end } }))
		out.hooks = try(K, "b12", skin({ hooks = { card = function() end, toast = function() end, actionButton = function() end } }))
		out.media = try(K, "b13", skin({ media = { pinFill = "Interface\\AddOns\\Test\\fill", pinRim = "Interface\\AddOns\\Test\\rim" } }))
		out.version = try(K, "b14", skin({ version = string.rep("1", 41) }))
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
	refused("strict", ":1, needs ");
	refused("author", "author must be a string of 40 characters at most");
	refused("gameToken", "tokens.bgBottom belongs to a skin");
	refused("edgeToken", "tokens.windowEdge belongs to a skin");
	refused("glowScheme", "tokens.glow belongs to a skin");
	refused("subjects", "is too light for Polestar's subject colours (");
	refused("sizes", "fontSizes.hero must be a number from 6 to 40");
	refused("role", "unknown fontSizes \"heor\"");
	assert_eq!(out["skinTokens"], json!({ "ok": true, "msg": false }), "the skin-only tokens are known");
	refused("hookName", "unknown hooks \"cards\"");
	assert_eq!(out["hooks"], json!({ "ok": true, "msg": false }), "the cards', toasts' and buttons' hooks");
	assert_eq!(out["media"], json!({ "ok": true, "msg": false }), "the pins' masks");
	refused("version", "version must be a string of 40 characters at most");
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
	assert_eq!(out["after"], json!(["late", "hearth", false]), "applied as it registers; a skin on Hearth draws Polestar's own controls, not the game's");
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
		local caps = {}
		for _, c in ipairs({ "skins", "schemes", "surfaces.window", "surfaces.toast", "surfaces.arrow", "surfaces.pin", "fonts", "preset",
			"lightSchemes", "surfaces.guideTitle", "variants", "resolve", "shadow", "artTint", "media.dart", "guideParts",
			"surfaces.card", "surfaces.actionButton", "surfaces.guideRow", "surfaces.guideLayout", "surfaces.guideRender",
			"surfaces.guideProgress", "surfaces.guideAnchor", "media.pins", "arrow.parts", "pin.parts", "tokens.accent2", "tokens.glow",
			"tokens.pins", "skins.installed", "theme.functions", "kit.color", "kit.glow", "kit.tintArt" }) do
			if not T.HasCapability(c) then caps[#caps + 1] = c end
		end
		emit({ v = T.API_VERSION, missing = table.concat(caps, ","), nope = T.HasCapability("surfaces.nope"), odd = T.HasCapability(nil),
			n = #T.Capabilities(), surfaces = T.SkinSurfaces() })"##);
	assert_eq!(out["v"], 2);
	assert_eq!(out["missing"], "", "every capability of Skin API 2");
	assert_eq!((out["nope"].clone(), out["odd"].clone()), (json!(false), json!(false)));
	assert!(out["n"].as_u64().unwrap() >= 40);
	assert_eq!(
		out["surfaces"]["hooks"],
		json!(["actionButton", "arrow", "card", "guideAnchor", "guideLayout", "guideMenu", "guidePlace", "guideProgress", "guideRender", "guideRow", "guideTab", "guideTitle", "pin", "toast"])
	);
	assert_eq!(out["surfaces"]["paint"], json!(["button", "checkbox", "close", "dropdown", "editbox", "guide", "inset", "panel", "scrollbar", "sidebar", "tab", "tile", "toast", "window"]));
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

// The example skin never ships (Polestar's own skin addons may: they are not the example), and the install check
// leaves another addon's skin alone: its version is its own.
#[test]
fn the_example_is_never_in_a_release_and_the_install_check_leaves_skin_addons_alone() {
	let release = forge_release::addons::release_addons(&addons_dir());
	assert!(!release.names.iter().any(|n| n == "Polestar_Skin_Example"), "{:?}", release.names);
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

// Skin API 2: one design in several versions (spec.variants). Each variant is checked as the skin is (its fields,
// its base, its grounds' legibility); the player's pick is kept per skin (ui.skinVariants.<id>) and repaints at
// once; a variant may draw the skin from another look (its base: the game's art, its own dart); a pick the skin no
// longer has falls back on its default. (Its card: the picker's tests below.)
#[test]
fn a_skin_s_variants_are_checked_picked_per_skin_and_may_change_the_look_it_is_drawn_from() {
	let out = run(r##"
		local function spec(extra)
			local s = { name = "V", addon = "Test" }
			for k, v in pairs(extra or {}) do s[k] = v end
			return s
		end
		local function try(id, sp)
			local ok, msg = T.RegisterSkin(id, sp)
			return { ok = ok, msg = msg or false }
		end
		local out = {}
		out.twice = try("v1", spec({ variants = { { id = "a", name = "A" }, { id = "a", name = "B" } } }))
		out.unknown = try("v2", spec({ variants = { { id = "a", name = "A", colour = 1 } } }))
		out.default = try("v3", spec({ variants = { { id = "a", name = "A" } }, defaultVariant = "b" }))
		out.alone = try("v4", spec({ defaultVariant = "a" }))
		out.vbase = try("v5", spec({ variants = { { id = "a", name = "A", base = "nope" } } }))
		out.shadow = try("v6", spec({ shadow = { size = 8, blur = 2 } }))
		out.tint = try("v7", spec({ artTint = { brightness = 2 } }))
		out.resolve = try("v8", spec({ resolve = "x" }))
		out.dark = try("v9", spec({ strict = true, variants = { { id = "a", name = "A",
			tokens = { text = "#303030", textDim = "#303030", textMuted = "#303030" } } } }))
		out.empty = try("v10", spec({ variants = {} }))
		out.ok = try("duo", spec({ shadow = { size = 20, drop = 4 }, defaultVariant = "flat", variants = {
			{ id = "flat", name = "Flat", desc = "Polestar's own frames", tokens = { accent = "#ff00ff" } },
			{ id = "forever", name = "WoW Forever, dimmed", base = "forever", artTint = { tint = { 0.8, 0.8, 0.9 }, brightness = -0.4, desaturate = 0.8 },
				media = { dart = "Interface\\AddOns\\Test\\dart" } },
		} }))
		Polestar.Set("ui.skin", "duo")
		out.list = T.SkinVariants("duo")
		out.flat = { T.SkinVariant("duo"), T.SkinKey(), T.GameSkin(), hexOf(T.Palette().accent), T.SkinMedia("dart") or false }
		local repaints = 0
		T.OnChanged(function() repaints = repaints + 1 end)
		Polestar.Set("ui.skinVariants.duo", "forever")
		out.forever = { T.SkinVariant("duo"), T.SkinKey(), T.GameSkin(), T.SkinMedia("dart") or false, repaints }
		-- Another skin's pick repaints nothing; a pick the skin no longer has is its default.
		Polestar.Set("ui.skinVariants.halo", "x")
		out.otherSkin = repaints
		Polestar.Set("ui.skinVariants.duo", "gone")
		out.gone = T.SkinVariant("duo")
		-- Kept per skin, through another skin and back.
		Polestar.Set("ui.skinVariants.duo", "forever")
		Polestar.Set("ui.skin", "halo")
		Polestar.Set("ui.skin", "duo")
		out.kept = T.SkinVariant("duo")
		out.none = { T.SkinVariants("halo") == nil, T.SkinVariant("halo") == nil }
		emit(out)"##);
	let refused = |k: &str, pat: &str| {
		assert_eq!(out[k]["ok"], false, "{k}: {}", out[k]);
		let msg = out[k]["msg"].as_str().unwrap_or("");
		assert!(msg.contains(pat), "{k}: {msg:?} should say {pat:?}");
	};
	refused("twice", "the variant id \"a\" is given twice");
	refused("unknown", "unknown field \"colour\" in variants[1]");
	refused("default", "defaultVariant must be one of the variants' ids");
	refused("alone", "defaultVariant goes with variants");
	refused("vbase", "variants[1].base must be one of Polestar's skins");
	refused("shadow", "unknown field \"blur\" in shadow");
	refused("tint", "artTint.brightness must be a number from -1 to 1");
	refused("resolve", "resolve must be a function");
	refused("dark", "variants[1]: ");
	refused("empty", "variants must be a list");
	assert_eq!(out["ok"], json!({ "ok": true, "msg": false }));
	assert_eq!(out["list"], json!([{ "id": "flat", "name": "Flat", "desc": "Polestar's own frames" }, { "id": "forever", "name": "WoW Forever, dimmed" }]));
	assert_eq!(out["flat"], json!(["flat", "polestar", false, "ff00ff", false]), "the default variant: the house style in its accent");
	assert_eq!(out["forever"], json!(["forever", "forever", true, "Interface\\AddOns\\Test\\dart", 1]), "the pick repaints once, drawn from the game's art with the variant's own dart");
	assert_eq!(out["otherSkin"], 1, "another skin's pick repaints nothing");
	assert_eq!(out["gone"], "flat");
	assert_eq!(out["kept"], "forever");
	assert_eq!(out["none"], json!([true, true]));
}

// Skin API 2: a skin's resolver (spec.resolve) is asked with the player's context (faction, class and its colour,
// the zone, the continent and its name); on a new zone it is asked again, and Polestar repaints only when its
// answer changed (a skin keyed to the continent repaints on a new continent, not at every zone border). With no
// such skin in use, a new zone asks nothing.
#[test]
fn a_resolver_is_asked_with_the_player_s_context_and_a_new_zone_repaints_only_when_its_answer_changed() {
	let out = run(r##"
		local MAPS = {
			[1414] = { mapID = 1414, name = "Kalimdor", mapType = 2, parentMapID = 947 },
			[1415] = { mapID = 1415, name = "Eastern Kingdoms", mapType = 2, parentMapID = 947 },
			[1411] = { mapID = 1411, name = "Durotar", mapType = 3, parentMapID = 1414 },
			[1413] = { mapID = 1413, name = "The Barrens", mapType = 3, parentMapID = 1414 },
			[1429] = { mapID = 1429, name = "Elwynn Forest", mapType = 3, parentMapID = 1415 },
		}
		local zone = 1411
		C_Map = { GetBestMapForUnit = function() return zone end, GetMapInfo = function(id) return MAPS[id] end }
		-- The client's class and faction (this run loads Core and Theme only, without the stubbed world).
		UnitClass = function() return "Warrior", "WARRIOR" end
		UnitFactionGroup = function() return "Horde", "Horde" end
		RAID_CLASS_COLORS = { WARRIOR = { r = 0.78, g = 0.61, b = 0.43 } }
		local asks, seen = 0, nil
		local ok, why = T.RegisterSkin("way", { name = "Waymark", addon = "Test", resolve = function(ctx)
			asks = asks + 1
			seen = ctx
			return { accent = ctx.continent == 1414 and "#ff0000" or "#00ff00" }
		end })
		local repaints = 0
		T.OnChanged(function() repaints = repaints + 1 end)
		Polestar.Set("ui.skin", "way")
		local r0 = repaints
		local out = { ok = ok, why = why or false }
		out.first = { hexOf(T.Palette().accent), seen.zone, seen.continent, seen.continentName, type(seen.faction), type(seen.class),
			type(seen.classColor) }
		zone = 1413
		stub.fire("ZONE_CHANGED_NEW_AREA")
		out.sameContinent = { repaints - r0, hexOf(T.Palette().accent), seen.zone }
		zone = 1429
		stub.fire("ZONE_CHANGED_NEW_AREA")
		out.newContinent = { repaints - r0, hexOf(T.Palette().accent), seen.continentName }
		Polestar.Set("ui.skin", "polestar")
		local r1, a1 = repaints, asks
		zone = 1411
		stub.fire("ZONE_CHANGED_NEW_AREA")
		out.plain = { repaints - r1, asks - a1 }
		emit(out)"##);
	assert_eq!(out["ok"], true, "{}", out["why"]);
	assert_eq!(out["first"], json!(["ff0000", 1411, 1414, "Kalimdor", "string", "string", "table"]));
	assert_eq!(out["sameContinent"], json!([0, "ff0000", 1413]), "asked again, the same answer: no repaint");
	assert_eq!(out["newContinent"], json!([1, "00ff00", "Eastern Kingdoms"]), "a new answer: one repaint");
	assert_eq!(out["plain"], json!([0, 0]), "no resolver in use: nothing asked, nothing repainted");
}

// A skin written for Skin API 1 (the API's preview in Polestar 0.3.7's development: the Moonlit example as it was
// then, `api = 1`) registers on Skin API 2 and paints as it did: its scheme, font, painter, arrow and icons; its
// arrow hook, written for two arguments, takes the call that now hands over the arrow's parts too.
#[test]
fn a_skin_written_for_skin_api_1_registers_and_paints_as_it_did() {
	let out = run_full(
		r##"
		local ok1, why1 = T.RegisterScheme("moon1", { api = 1, name = "Moonlit", addon = "Test_Old", author = "Polestar", version = "1.0",
			desc = "Cool indigo grounds under a silver text ladder.",
			tokens = { bg = "#12142af7", panel = "#161937fa", panelAlt = "#1f2347", sidebar = "#0d0f20", footer = "#0f1124", sky = "#2b3060",
				text = "#f2f3fa", textDim = "#c3c7de", textMuted = "#9ca1c0", star = "#e8ecff", scrim = "#06071a", onAccent = "#0e1022" },
			accent = "#afc0ff", washes = { border = 0.1, divider = 0.1, selected = 0.12 } })
		local painted, hooked = 0, nil
		local ok2, why2 = T.RegisterSkin("moon1", { api = 1, name = "Moonlit", addon = "Test_Old", author = "Polestar", version = "1.0",
			base = "polestar", scheme = "moon1", font = "fira", fontSizes = { hero = 24 }, arrow = "halo", mapIcons = "halo",
			paint = { window = function(frame, base, kit)
				base(frame)
				local own = kit.store(frame)
				if not own.moon then
					own.moon = frame:CreateTexture(nil, "BORDER")
					own.moon:SetTexture(T.Media("white"))
				end
				own.moon:Show()
				painted = painted + 1
			end },
			hooks = { arrow = function(frame, style) hooked = style end } })
		local win = CreateFrame("Frame")
		win:SetSize(300, 200)
		T.Skin(win, "window")
		Polestar.Set("ui.skin", "moon1")
		local ran = T.SkinHook("arrow", win, "flat", {})
		emit({ ok = { ok1, ok2 }, why = { why1 or false, why2 or false }, api = { T.SkinInfo("moon1").api, T.SchemeInfo("moon1").api },
			id = T.SkinId(), bg = hexOf(T.Palette().bg), accent = hexOf(T.Palette().accent), body = (T.FontSpec("body")),
			hero = select(2, T.FontSpec("hero")), painted = painted > 0, ran = ran, hooked = hooked or false,
			arrow = T.SkinArrowStyle(), icons = T.SkinMapIcons() })"##,
		false,
		"",
	);
	assert_eq!(out["ok"], json!([true, true]), "{}", out["why"]);
	assert_eq!(out["api"], json!([1, 1]), "the version it was written for, kept");
	assert_eq!(out["id"], "moon1");
	assert_eq!((out["bg"].as_str(), out["accent"].as_str()), (Some("12142a"), Some("afc0ff")));
	assert!(out["body"].as_str().unwrap().ends_with("FiraSans-Medium.ttf"), "{}", out["body"]);
	assert_eq!(out["hero"], 24.0);
	assert_eq!(out["painted"], true, "its painter ran");
	assert_eq!((out["ran"].clone(), out["hooked"].clone()), (json!(true), json!("flat")), "its two-argument arrow hook ran");
	assert_eq!((out["arrow"].as_str(), out["icons"].as_str()), (Some("halo"), Some("halo")));
}

// The whole addon in the stubbed world with the example skin (a Shaman at Call of Water: the guide window, its class
// quest card, the arrow): every hook a skin can have (Theme.SkinSurfaces) runs on its live surface and puts the
// skin's piece there; the cards are the heads-up card and the class quest card, the toasts the rare alert and the
// transport banner, the buttons every action button and the floating one, the pins a step pin and a map mark. With
// Polestar's own look again, every piece goes.
const WORLD: &str = r#"
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 2000, right = -4000, top = 1000, bottom = -5000 })
w.race, w.raceName = "Orc", "Orc"
w.class, w.className = "SHAMAN", "Shaman"
w.faction = "Horde"
w.level = 21
w.moveTo(1413, 61.99, 39.41)
for _, q in ipairs({ 1530, 1535 }) do w.titles[q] = "Call of Water" end
w.complete({ 1528 })
w.onQuest(1530, {}, "Call of Water")
"#;

const GUIDE: &str = r#"
local function brine(t, q, extra)
	local g = { t = t, quest = q, title = "Call of Water", npc = 5899, npcName = "Brine", map = 1413, x = 43.42, y = 77.41 }
	for k, v in pairs(extra or {}) do g[k] = v end
	return g
end
Polestar.RegisterGuide({
	id = "test/class/call-of-water", pack = "test", title = "Call of Water (Horde)", category = "Class", classes = { "SHAMAN" },
	faction = "Horde", minLevel = 20, maxLevel = 23,
	steps = {
		{ title = "Islen Waterseer", goals = {
			{ t = "accept", quest = 1530, title = "Call of Water", npc = 5901, npcName = "Islen Waterseer", map = 1413, x = 65.8, y = 43.8, minLevel = 20, qlvl = 22 },
		} },
		{ title = "Brine", goals = {
			brine("turnin", 1530),
			brine("accept", 1535, { minLevel = 20, qlvl = 22, pre = { 1530 }, preTitles = { [1530] = "Call of Water" } }),
		} },
		{ title = "The Quilboar Watering Hole", goals = {
			{ t = "use", item = 7766, itemName = "Empty Brown Waterskin", quest = 1535, oi = 1, title = "Call of Water", map = 1413, x = 44.3, y = 76.8 },
		} },
	},
})
"#;

#[test]
fn every_hook_of_the_example_skin_runs_on_its_live_surface_and_its_pieces_go_with_it() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar"), Addon::name("Polestar_Skin_Example")],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			GUIDE,
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			r##"
local T, E, GF = Polestar.Theme, Polestar.Engine, Polestar.UI.GuideFrame
-- Which hooks ran (a hook that ran answers true), for which kind of card, toast, button and pin, and the frame
-- each kind was handed in.
local fired, kinds, byKind = {}, { card = {}, toast = {}, actionButton = {}, pin = {} }, {}
local hook, hookValue = T.SkinHook, T.SkinHookValue
T.SkinHook = function(surface, ...)
	local ran = hook(surface, ...)
	if ran then
		fired[surface] = true
		local frame, b, c = ...
		local kind = tostring(surface == "pin" and c or b)
		if kinds[surface] then
			kinds[surface][kind] = true
			byKind[surface .. ":" .. kind] = frame
		end
	end
	return ran
end
T.SkinHookValue = function(surface, ...)
	local ran, v = hookValue(surface, ...)
	if ran then fired[surface] = true end
	return ran, v
end
Polestar.Set("behavior.autoAccept", false)
Polestar.Set("ui.launcher", true)
E.SetGuide("test/class/call-of-water"); stub.advance(3)
-- The skin, chosen with the window on screen.
Polestar.Set("ui.skin", "moonlit")
stub.advance(0.5)
-- The heads-up card on the window; the toasts.
local CT = Polestar.UI.ClassToast
CT.ShowCard({ head = "LEVEL 21 · SHAMAN", title = "Call of Water", act = { label = "Go", run = function() end } })
Polestar.Rares.Toast.Show({ kind = "rare", name = "Mother Fang", map = 1413, x = 50, y = 50 })
Polestar.Nav.alerts.ShowSample()
-- A step pin and a map mark, by the pins' own code (as the map layers draw theirs).
local P = Polestar.Pins
local stepPin, markPin = CreateFrame("Frame", nil, UIParent), CreateFrame("Frame", nil, UIParent)
P.BuildLook(stepPin)
P.BuildLook(markPin)
P.ApplyLook(stepPin, { text = "3" }, 16)
P.ApplyLook(markPin, { icon = "map:quest" }, 16)
-- The window's tab strip, and its menu opened and closed.
GF.RenderTabs()
GF.OpenMenu(T.GuideParts().nav.Menu)
Polestar.Widgets.HideMenu()
stub.advance(0.5)
-- The skin's pieces (its own store on each frame: kit.store), seen while it is in use.
local kit = T.SkinKit
local function own(frame, key) return frame and kit.store(frame)[key] or nil end
local parts = T.GuideParts()
local pieces = {
	title = own(parts.nav, "moon"), progress = own(parts.foot, "done"), rule = own(parts.body, "rule"),
	arrow = own(Polestar.Nav.arrow.dial, "glow:moon"), headsup = own(byKind["card:headsup"], "moon"), classcard = own(byKind["card:classcard"], "moon"),
	rare = own(PolestarRareToast, "moon"), transport = own(PolestarAlert, "moon"), item = own(PolestarQuestItemButton, "moon"),
	target = own(PolestarTargetButton, "moon"), launcher = own(PolestarLauncher, "moon"),
}
local bars = 0
for _, r in ipairs(GF.rows) do
	local b = own(r, "bar")
	if b and b:IsShown() then bars = bars + 1 end
end
local shadowed = stepPin.text.shadowColor ~= nil
local shown, missing = {}, {}
for k, t in pairs(pieces) do
	if t then shown[k] = t:IsShown() else missing[#missing + 1] = k end
end
table.sort(missing)
-- Polestar's own look again: every piece goes.
Polestar.Set("ui.skin", "polestar")
stub.advance(0.5)
local after = {}
for k, t in pairs(pieces) do after[k] = t:IsShown() end
local ran = {}
for name in pairs(fired) do ran[#ran + 1] = name end
table.sort(ran)
local kindLists = {}
for surface, set in pairs(kinds) do
	local list = {}
	for k in pairs(set) do list[#list + 1] = k end
	table.sort(list)
	kindLists[surface] = table.concat(list, ",")
end
emit({ ran = table.concat(ran, ","), hooks = table.concat(T.SkinSurfaces().hooks, ","), kinds = kindLists, shown = shown,
	missing = table.concat(missing, ","), after = after, bars = bars, shadowed = shadowed })"##,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["ran"], out["hooks"], "every hook of the API ran on its surface");
	let has = |surface: &str, kinds: &[&str]| {
		let seen: Vec<&str> = out["kinds"][surface].as_str().unwrap_or("").split(',').collect();
		for k in kinds {
			assert!(seen.contains(k), "{surface}: {k} not among {seen:?}");
		}
	};
	has("card", &["headsup", "classcard"]);
	has("toast", &["rare", "transport"]);
	has("actionButton", &["item", "hearth", "target", "rare", "bag", "launcher"]);
	has("pin", &["pin", "mark"]);
	assert_eq!(out["missing"], "", "every surface got its piece");
	for (k, v) in out["shown"].as_object().unwrap() {
		assert_eq!(v, &json!(true), "{k}: the skin's piece shows while it is in use");
	}
	assert!(out["bars"].as_u64().unwrap() >= 1, "the current goal's row has its bar");
	assert_eq!(out["shadowed"], true, "the step pin's number has its shadow");
	for (k, v) in out["after"].as_object().unwrap() {
		assert_eq!(v, &json!(false), "{k}: gone with Polestar's own look");
	}
}

// Installed skin addons (## X-Polestar-Skin): listed whether loaded or not. One that loads on demand loads at login
// when the saved skin is its own, when the player picks one of its skins, and when the settings list the skins;
// one the client will not load is listed with the client's reason and never loaded.
#[test]
fn installed_skin_addons_are_listed_and_load_on_demand_when_saved_picked_or_listed() {
	let out = emitted(&RunAddon {
		before: r##"
stub.addons = {
	{ name = "Polestar" },
	{ name = "Test_Ember", title = "Ember" },
	{ name = "Test_Glass", title = "Glass", notes = "A glass skin." },
	{ name = "Test_Mist", title = "Mist" },
	{ name = "Test_Off", title = "Off", reason = "DISABLED" },
	{ name = "Test_Plain", title = "Plain" },
}
stub.addonMeta["Test_Ember"] = { ["X-Polestar-Skin"] = "ember, ember-dark" }
stub.addonMeta["Test_Glass"] = { ["X-Polestar-Skin"] = "glass" }
stub.addonMeta["Test_Mist"] = { ["X-Polestar-Skin"] = "mist" }
stub.addonMeta["Test_Off"] = { ["X-Polestar-Skin"] = "off" }
-- What each addon registers when the client loads it.
fakeSkins = {
	Test_Ember = function()
		Polestar.Theme.RegisterSkin("ember", { api = 2, name = "Ember", addon = "Test_Ember", base = "hearth" })
		Polestar.Theme.RegisterSkin("ember-dark", { api = 2, name = "Ember, dark", addon = "Test_Ember", base = "hearth", tokens = { bg = "#100804" } })
	end,
	Test_Glass = function() Polestar.Theme.RegisterSkin("glass", { api = 2, name = "Glass", addon = "Test_Glass", base = "halo" }) end,
	Test_Mist = function() Polestar.Theme.RegisterSkin("mist", { api = 2, name = "Mist", addon = "Test_Mist", base = "polestar" }) end,
}
loads = {}
local load = C_AddOns.LoadAddOn
function C_AddOns.LoadAddOn(name)
	local fn = fakeSkins[name]
	if fn and not stub.addonsLoaded[name] then
		loads[#loads + 1] = name
		stub.addonsLoaded[name] = true
		fn()
		return true, nil
	end
	return load(name)
end"##
			.into(),
		addons: vec![Addon::files("Polestar", FILES)],
		// The world (the player's race, class, zone...): the login handlers before the Skin API's need it.
		stubs: vec!["stub_world.lua"],
		saved: vec![("Polestar".into(), r##"PolestarDB = { schema = 1, settings = { ui = { skin = "ember" } } }"##.into())],
		login: true,
		script: r##"
local T = Polestar.Theme
local out = { login = { T.SkinId(), table.concat(loads, ",") } }
local list = {}
for _, rec in ipairs(T.InstalledSkins()) do list[#list + 1] = { rec.addon, table.concat(rec.ids, ","), rec.loaded, rec.reason or false } end
out.installed = list
-- Picked: its addon loads, and the pick shows.
Polestar.Set("ui.skin", "glass")
out.picked = { T.SkinId(), T.SkinKey(), table.concat(loads, ",") }
-- Listed: the rest load, so every skin is in the picker; the one that cannot load is not.
local values = {}
for _, c in ipairs(T.SkinChoices()) do values[#values + 1] = c.value end
out.choices = table.concat(values, ",")
out.loads = table.concat(loads, ",")
out.off = { T.LoadSkinAddon("off") }
out.nobody = { T.LoadSkinAddon("nobody") }
out.again = { T.LoadSkinAddon("glass") }
emit(out)"##
			.into(),
	})
	.remove(0);
	assert_eq!(out["login"], json!(["ember", "Test_Ember"]), "the saved skin's addon loaded at login, and the choice shows");
	assert_eq!(
		out["installed"],
		json!([["Test_Ember", "ember,ember-dark", true, false], ["Test_Glass", "glass", false, false], ["Test_Mist", "mist", false, false], ["Test_Off", "off", false, "DISABLED"]]),
		"every addon that declares skins, loaded or not; an addon without the line is not one"
	);
	assert_eq!(out["picked"], json!(["glass", "halo", "Test_Ember,Test_Glass"]));
	assert_eq!(out["choices"], "polestar,halo,hearth,forever,blizzard,classic,ember,ember-dark,glass,mist");
	assert_eq!(out["loads"], "Test_Ember,Test_Glass,Test_Mist", "each loaded once");
	assert_eq!(out["off"], json!([false, "DISABLED"]));
	assert_eq!(out["nobody"], json!([false, "no installed addon declares it (## X-Polestar-Skin)"]));
	assert_eq!(out["again"], json!([true]), "registered already");
}

// A skin the player chose (saved) that its addon registers with a spec Polestar refuses: one chat line, naming the
// skin, its addon and the reason, so it reaches the skin's author; nothing for a refused skin the player did not
// choose, and nothing twice.
#[test]
fn a_chosen_skin_that_is_refused_says_so_once_naming_its_addon() {
	let out = run_full(
		r##"
		local ok, why = T.RegisterSkin("brass", { name = "Brass", addon = "Test_Brass", tokens = { bgg = "#000000" } })
		T.RegisterSkin("brass", { name = "Brass", addon = "Test_Brass", tokens = { bgg = "#000000" } })
		T.RegisterSkin("other", { name = "Other", addon = "Test_Other", tokens = { bgg = "#000000" } })
		local brass, other, line = 0, 0, false
		for _, m in ipairs(stub.messages) do
			if m:find("Test_Brass", 1, true) then brass = brass + 1; line = m end
			if m:find("Test_Other", 1, true) then other = other + 1 end
		end
		emit({ ok = ok, why = why, brass = brass, other = other, line = line, id = T.SkinId() })"##,
		false,
		r##"PolestarDB = { schema = 1, settings = { ui = { skin = "brass" } } }"##,
	);
	assert_eq!(out["ok"], false);
	assert_eq!((out["brass"].clone(), out["other"].clone()), (json!(1), json!(0)), "once, and only for the chosen skin");
	let line = out["line"].as_str().unwrap();
	assert!(line.contains("brass") && line.contains("unknown token \"bgg\""), "{line}");
	assert_eq!(out["id"], "polestar", "Polestar's own look stands in");
}

// The game looks draw their art through Theme.TintArt: a skin's artTint (tint, brightness, desaturation) lies over
// every piece while that skin is in use and is drawn from a game look; otherwise each piece is drawn as given.
#[test]
fn a_skin_s_art_tint_lies_over_the_game_looks_art_drawn_through_tint_art_and_goes_with_it() {
	let out = run(r##"
		local t = CreateFrame("Frame"):CreateTexture()
		local function rgb() local r, g, b, a = t:GetVertexColor() return { hexOf({ r, g, b }), math.floor(a * 100 + 0.5) } end
		T.TintArt(t, 1, 0.82, 0, 0.9)
		local out = { plain = rgb(), plainMark = t.psArtTinted or false }
		T.RegisterSkin("dim", { name = "Dim", addon = "Test", base = "forever", artTint = { tint = { 0.5, 0.5, 1 }, brightness = -0.5 } })
		T.RegisterSkin("flat", { name = "Flat", addon = "Test", base = "polestar", artTint = { tint = { 0.5, 0.5, 1 } } })
		Polestar.Set("ui.skin", "dim")
		T.TintArt(t, 1, 0.82, 0, 0.9)
		out.dim, out.dimMark = rgb(), t.psArtTinted or false
		T.TintArt(t)
		out.white = rgb()
		Polestar.Set("ui.skin", "flat")
		T.TintArt(t, 1, 0.82, 0, 0.9)
		out.flat, out.flatMark = rgb(), t.psArtTinted or false
		emit(out)"##);
	assert_eq!(out["plain"], json!(["ffd100", 90]), "no skin: as given");
	assert_eq!(out["plainMark"], false);
	assert_eq!(out["dim"], json!(["403400", 90]), "tinted and darkened: 1 x 0.5 x 0.5, 0.82 x 0.5 x 0.5, 0");
	assert_eq!(out["dimMark"], true);
	assert_eq!(out["white"], json!(["404080", 100]), "white art takes the tint itself");
	assert_eq!(out["flat"], json!(["ffd100", 90]), "a skin on the house style has no game art to tint");
	assert_eq!(out["flatMark"], false);
}

// The guide window on the fake Engine (tests/lua/stub_ui.lua) with the real Core + Theme + UI manifests.
const UI_FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

fn run_ui(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &UI_FILES)],
		script: format!(
			"uistub.install()\nstub.login()\nPolestar.UI.LoadOptions()\nlocal GF = Polestar.UI.GuideFrame\nlocal F = PolestarGuideFrame\nlocal TABS = {{ {{ uistub.elwynn, 3 }}, {{ uistub.tailoring, 2 }}, {{ uistub.stormwindRep, 2 }} }}\nlocal function firstRow()\n\tfor _, r in ipairs(GF.rows) do if r:IsShown() and r.psGoal then return r end end\nend\n{script}"
		),
		..Default::default()
	})
	.remove(0)
}

fn n(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}

// Skin API 2's guide window hooks: a skin dresses each goal row once painted (guideRow), takes room of its own
// under the window's parts (guideLayout: the window grows by its answer), hears every render with the step on
// screen (guideRender), paints its own progress (guideProgress) and gives the heads-up card the frame to sit on
// (guideAnchor). Without the skin, nothing of it stays.
#[test]
fn a_registered_skin_s_guide_window_hooks_dress_rows_add_room_follow_renders_and_anchor_the_heads_up() {
	let out = run_ui(
		r##"
		local T = Polestar.Theme
		local seen = { rows = 0, renders = 0 }
		local cards
		local ok, why = T.RegisterSkin("dense", { name = "Dense", addon = "Test_Dense", base = "polestar",
			hooks = {
				guideRow = function(row, goal, info)
					seen.rows = seen.rows + 1
					row.psDense = goal.t .. (info.current and ":current" or "")
				end,
				guideLayout = function(parts, width, y)
					cards = cards or CreateFrame("Frame", nil, parts.window)
					cards:ClearAllPoints()
					cards:SetPoint("BOTTOMLEFT", parts.window, "TOPLEFT", 0, 0)
					cards:SetSize(width, 30)
					seen.layoutY = y
					return 20
				end,
				guideRender = function(view, parts) seen.renders = seen.renders + 1; seen.step = view and view.index or false; seen.parts = parts.window == F end,
				guideProgress = function(foot, frac) seen.frac = frac end,
				guideAnchor = function() return cards end,
			} })
		uistub.openTabs(TABS, 1)
		local before = math.floor(F:GetHeight() + 0.5)
		Polestar.Set("ui.skin", "dense")
		GF.Render()
		local after = math.floor(F:GetHeight() + 0.5)
		local r = firstRow()
		local CT = Polestar.UI.ClassToast
		CT.ShowCard({ head = "LEVEL 10", title = "Something ready", act = { label = "Go", run = function() end } })
		local _, rel = CT.frame:GetPoint(1)
		local onCards = rel == cards
		CT.Hide()
		Polestar.Set("ui.skin", "polestar")
		GF.Render()
		emit({ ok = ok, why = why or false, before = before, after = after, dense = r.psDense or false, rows = seen.rows > 0,
			renders = seen.renders > 0, step = seen.step, parts = seen.parts, frac = seen.frac ~= nil, layoutY = seen.layoutY ~= nil,
			onCards = onCards, back = math.floor(F:GetHeight() + 0.5), v = T.API_VERSION,
			caps = { T.HasCapability("surfaces.guideRow"), T.HasCapability("surfaces.guideLayout"), T.HasCapability("surfaces.guideRender"),
				T.HasCapability("surfaces.guideProgress"), T.HasCapability("surfaces.guideAnchor"), T.HasCapability("guideParts") } })"##,
	);
	assert_eq!(out["ok"], true, "registered: {}", out["why"]);
	assert_eq!(out["v"], 2);
	assert_eq!(out["caps"], json!([true, true, true, true, true, true]));
	assert_eq!(
		(out["rows"].clone(), out["renders"].clone(), out["parts"].clone(), out["frac"].clone(), out["layoutY"].clone()),
		(json!(true), json!(true), json!(true), json!(true), json!(true)),
		"{out}"
	);
	assert!(out["dense"].as_str().unwrap_or("").len() > 1, "the row was dressed: {}", out["dense"]);
	assert_eq!(out["step"], 3, "the step on screen");
	assert_eq!(n(&out["after"]) - n(&out["before"]), 20.0, "the window grew by the skin's room");
	assert_eq!(out["onCards"], true, "the heads-up card sits on the skin's frame");
	assert_eq!(out["back"], out["before"], "back on the house skin, its own height");
}

// Skin API 2's guidePlace: each part about to be placed is offered to the skin with its height; one the skin claims
// (its answer true) leaves the window: the window is shorter by that part ("Then:" by its height, the card's tip
// with its gap) and the part stays where the skin put it. Claimed no more, the part goes back under its own frame
// and the window gets its height back; a skin that claims nothing changes nothing.
#[test]
fn a_part_a_skin_places_itself_leaves_the_guide_window_s_height_and_comes_back_when_no_skin_claims_it() {
	let out = run_ui(
		r##"
		local T = Polestar.Theme
		local P = GF.parts
		local mine = CreateFrame("Frame", nil, UIParent)
		mine:SetSize(240, 120)
		local claim, offered = {}, {}
		local ok, why = T.RegisterSkin("cards", { name = "Cards", addon = "Test_Cards", base = "polestar",
			hooks = {
				guidePlace = function(name, frame, width, height)
					offered[name] = { width = width, height = height }
					if not claim[name] then return false end
					frame:SetParent(mine)
					frame:ClearAllPoints()
					frame:SetPoint("TOPLEFT", mine, "TOPLEFT", 0, 0)
					return true
				end,
			} })
		uistub.openTabs(TABS, 1)
		local function h() return math.floor(F:GetHeight() + 0.5) end
		local house = h()
		local homes = { after = P.after:GetParent(), tip = P.tip:GetParent() }
		Polestar.Set("ui.skin", "cards")
		GF.Render()
		local hooked = h()
		local function offer(name)
			local o = offered[name]
			return o and o.width > 0 and o.height or false
		end
		local seen = { after = offer("after"), tip = offer("tip") }
		claim.after = true
		GF.Render()
		local _, rel = P.after:GetPoint(1)
		local noAfter = { h = h(), parent = P.after:GetParent() == mine, rel = rel == mine, shown = P.after:IsShown() }
		claim.tip = true
		GF.Render()
		local noTip = { h = h(), parent = P.tip:GetParent() == mine }
		claim.after, claim.tip = nil, nil
		GF.Render()
		local back = { h = h(), after = P.after:GetParent() == homes.after, tip = P.tip:GetParent() == homes.tip }
		Polestar.Set("ui.skin", "polestar")
		GF.Render()
		emit({ ok = ok, why = why or false, house = house, hooked = hooked, seen = seen, noAfter = noAfter, noTip = noTip,
			back = back, off = h() })"##,
	);
	assert_eq!(out["ok"], true, "registered: {}", out["why"]);
	assert_eq!(out["hooked"], out["house"], "a skin that claims nothing leaves the layout as it was");
	let offered = |part: &str| out["seen"][part].as_f64().filter(|h| *h > 0.0);
	let (Some(after), Some(tip)) = (offered("after"), offered("tip")) else {
		panic!("both parts are offered to the skin with their height: {}", out["seen"]);
	};
	let lost = n(&out["hooked"]) - n(&out["noAfter"]["h"]);
	assert!((lost - after).abs() <= 1.0, "\"Then:\" claimed: the window is {lost} shorter, the part is {after} high");
	assert_eq!(
		(out["noAfter"]["parent"].clone(), out["noAfter"]["rel"].clone(), out["noAfter"]["shown"].clone()),
		(json!(true), json!(true), json!(true)),
		"the claimed part stays where the skin put it"
	);
	let lost = n(&out["noAfter"]["h"]) - n(&out["noTip"]["h"]);
	assert!((lost - (tip + 2.0)).abs() <= 1.0, "the tip claimed: the window is {lost} shorter, the tip is {tip} high with its 2 of gap");
	assert_eq!(out["noTip"]["parent"], true);
	assert_eq!(out["back"], json!({ "h": out["house"].clone(), "after": true, "tip": true }), "claimed no more: back under its own frame, the window its height again");
	assert_eq!(out["off"], out["house"], "Polestar's own look: the house layout");
}

// The settings window's Theme page with its picker's cards as a player gets them: the arrow (Nav, with Maps) for
// their dials, the real Nav in place of the UI stub's, and the example skin. `showTheme()` opens the page on its
// Colour tab (it opens on Essentials, whose scheme is a dropdown); `cards(key)`: a card row's cards there by value
// (the Variant row has no key: its label).
const CARD_FILES: [&str; 5] = ["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml", "Maps/Maps.xml", "UI/UI.xml"];

fn run_cards(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &CARD_FILES), Addon::name("Polestar_Skin_Example")],
		script: format!(
			"uistub.install({{ noNav = true }})\nstub.login()\nPolestar.UI.LoadOptions()\nlocal T, UI, O = Polestar.Theme, Polestar.UI, Polestar.UI.Options\nlocal function hexOf(c) return string.format(\"%02x%02x%02x\", math.floor(c[1] * 255 + 0.5), math.floor(c[2] * 255 + 0.5), math.floor(c[3] * 255 + 0.5)) end\nlocal function showTheme() UI.ShowOptions(\"theme\"); O.Select(\"theme\", \"Colour\") end\nlocal function cards(key) return O.Controls(\"theme\", \"Colour\")[key].psCardBy end\n{script}"
		),
		..Default::default()
	})
	.remove(0)
}

// Each skin's card is a small guide window and the arrow, drawn by that skin's own painters, fonts, palette and
// arrow while Polestar's own look is in use: the band and the house's progress line on Polestar's own look, Halo's
// veil and Fira Sans, Hearth's slim line in its own art, the game's status bar on the game's looks, a skin from
// another addon in its font and arrow; each scheme's card is Polestar's own look in that scheme. The live look is
// left as it was.
#[test]
fn the_picker_s_cards_draw_each_skin_s_guide_window_and_arrow_as_it_draws_them_whatever_skin_is_in_use() {
	let out = run_cards(
		r##"
		local arrow = hexOf({ Polestar.Nav.RGB("arrow") })
		showTheme()
		local function card(by, id)
			local p = by[id].Art.psSkinCard
			local bg = p.win.psSkin.bg
			return { look = p.win.psSkin.skin, face = (p.person.Name:GetFont()):match("[^\\]+$"), band = p.sky:IsShown(),
				bar = p.foot.Status:IsShown(), dial = p.dial.style, ground = bg and bg:IsShown() and hexOf({ bg:GetVertexColor() }) or false }
		end
		local out = {}
		for _, id in ipairs({ "polestar", "halo", "hearth", "forever", "blizzard", "classic", "moonlit" }) do out[id] = card(cards("ui.skin"), id) end
		for _, id in ipairs({ "dusk", "night", "graphite", "moonlit" }) do out["scheme " .. id] = card(cards("ui.scheme"), id) end
		out.live = { T.SkinId(), PolestarGuideFrame.psSkin.skin, (T.FontSpec("name")):match("[^\\]+$"), hexOf({ Polestar.Nav.RGB("arrow") }) == arrow }
		emit(out)"##,
	);
	let row = |k: &str| json!([out[k]["look"], out[k]["face"], out[k]["band"], out[k]["bar"], out[k]["dial"]]);
	assert_eq!(row("polestar"), json!(["polestar", "FRIZQT__.TTF", true, false, "3d"]), "Polestar's own: the band, the progress line, the 3D arrow");
	assert_eq!(row("halo"), json!(["halo", "FiraSans-SemiBold.ttf", false, false, "halo"]), "Halo: Fira Sans, no band, its own arrow");
	assert_eq!(row("hearth"), json!(["hearth", "FRIZQT__.TTF", false, false, "hearth"]), "Hearth: its own window paint and slim line, its arrow");
	for id in ["forever", "blizzard", "classic"] {
		assert_eq!(row(id), json!([id, "FRIZQT__.TTF", false, true, "hearth"]), "{id}: its own window paint, the game's status bar and arrow");
	}
	assert_eq!(row("moonlit"), json!(["moonlit/polestar", "FiraSans-SemiBold.ttf", true, false, "halo"]), "a skin from another addon: its font and arrow");
	assert_eq!((out["polestar"]["ground"].clone(), out["moonlit"]["ground"].clone()), (json!("181d2d"), json!("12142a")), "each on its own ground");
	for (id, ground) in [("dusk", "181d2d"), ("night", "0a0d16"), ("graphite", "212325"), ("moonlit", "12142a")] {
		let k = format!("scheme {id}");
		assert_eq!((out[&k]["look"].clone(), out[&k]["ground"].clone()), (json!("polestar"), json!(ground)), "{k}: Polestar's own look in it");
	}
	assert_eq!(out["live"], json!(["polestar", "polestar", "FRIZQT__.TTF", true]), "the live skin, guide window, font and arrow untouched");
}

// A variant's card draws its skin in that variant, from the look the variant is drawn from (WoW Forever's paint and
// status bar); the skin's own card shows the variant in use and follows a new pick, the variant cards staying as
// they are.
#[test]
fn a_variant_s_card_draws_the_variant_and_the_skin_s_card_follows_the_variant_in_use() {
	let out = run_cards(
		r##"
		local ok, why = T.RegisterSkin("duo", { name = "Duo", addon = "Test_Duo", defaultVariant = "flat", variants = {
			{ id = "flat", name = "Flat", tokens = { accent = "#ff00ff" } },
			{ id = "forever", name = "On WoW Forever", base = "forever" },
		} })
		Polestar.Set("ui.skin", "duo")
		showTheme()
		local function look(by, id)
			local p = by[id].Art.psSkinCard
			return { p.win.psSkin.skin, p.foot.Status:IsShown(), hexOf({ p.accent:GetVertexColor() }) }
		end
		local out = { ok = ok, why = why or false, flat = look(cards("Variant"), "flat"), forever = look(cards("Variant"), "forever"),
			skin = look(cards("ui.skin"), "duo"), live = { T.SkinVariant("duo"), T.SkinKey(), PolestarGuideFrame.psSkin.skin } }
		Polestar.Set("ui.skinVariants.duo", "forever")
		out.picked = { skin = look(cards("ui.skin"), "duo"), flat = look(cards("Variant"), "flat"), live = { T.SkinKey(), PolestarGuideFrame.psSkin.skin } }
		emit(out)"##,
	);
	assert_eq!(out["ok"], true, "registered: {}", out["why"]);
	assert_eq!(out["flat"], json!(["duo/polestar", false, "ff00ff"]), "the flat variant: Polestar's own look in its accent");
	assert_eq!(out["forever"], json!(["duo/forever", true, "ffd100"]), "the other: WoW Forever's paint and status bar");
	assert_eq!(out["skin"], out["flat"], "the skin's card: the variant in use");
	assert_eq!(out["live"], json!(["flat", "polestar", "duo/polestar"]), "the cards leave the live variant alone");
	assert_eq!(out["picked"]["skin"], out["forever"], "the skin's card follows the pick");
	assert_eq!(out["picked"]["flat"], out["flat"], "a variant's card stays that variant");
	assert_eq!(out["picked"]["live"], json!(["forever", "duo/forever"]));
}

// A skin from another addon paints its card with its own painters (the window, the tick boxes) while another skin
// is in use. A painter that raises there leaves that card in the base look's paint and the skin on (it is judged
// where it is in use: picked, it raises and Polestar's own look stands in).
#[test]
fn a_skin_s_own_painters_paint_its_card_and_one_that_raises_there_leaves_the_skin_on() {
	let out = run_cards(
		r##"
		local painted, raised = {}, 0
		local function mark(frame, base) base(frame); painted[frame] = true end
		local ok1, why1 = T.RegisterSkin("own", { name = "Own", addon = "Test_Own", base = "polestar", paint = { window = mark, checkbox = mark } })
		local ok2, why2 = T.RegisterSkin("boom", { name = "Boom", addon = "Test_Boom", base = "polestar",
			paint = { window = function() raised = raised + 1; error("boom") end } })
		showTheme()
		local own, boom = cards("ui.skin").own.Art.psSkinCard, cards("ui.skin").boom.Art.psSkinCard
		local out = { ok = { ok1, ok2, why1 or false, why2 or false },
			own = { own.win.psSkin.skin, painted[own.win] or false, painted[own.rows[1].Check] or false },
			boom = { boom.win.psSkin.skin, hexOf({ boom.win.psSkin.bg:GetVertexColor() }), raised > 0, T.SkinInfo("boom").failed or false },
			live = T.SkinId() }
		Polestar.Set("ui.skin", "boom")
		out.picked = { T.SkinId(), T.SkinInfo("boom").failed and true or false }
		emit(out)"##,
	);
	assert_eq!(out["ok"], json!([true, true, false, false]));
	assert_eq!(out["own"], json!(["own/polestar", true, true]), "its window and tick box painters ran on its card");
	assert_eq!(out["boom"], json!(["boom/polestar", "181d2d", true, false]), "the base paint on the card, the skin not failed");
	assert_eq!(out["live"], "polestar");
	assert_eq!(out["picked"], json!(["polestar", true]), "in use, its painter fails it");
}

// The picker's variant cards tell the variants apart at card size: a skin's own second accent and glow sit as
// swatches beside the accent under the arrow (Moonlit's two variants differ there and nowhere else on the card),
// also under the player's own accent, which the cards on screen take at once. A card whose palette only derives
// them (Polestar's own skins, a scheme) shows the accent alone.
#[test]
fn a_variant_s_card_shows_its_own_second_accent_and_glow_beside_the_accent() {
	let out = run_cards(
		r##"
		Polestar.Set("ui.skin", "moonlit")
		showTheme()
		local function swatches(by, id)
			local p = by[id].Art.psSkinCard
			local function shown(t) return t:IsShown() and hexOf({ t:GetVertexColor() }) or false end
			return { accent = shown(p.accent), accent2 = shown(p.accent2), glow = shown(p.glow) }
		end
		local function all()
			local variants, skins = cards("Variant"), cards("ui.skin")
			return { full = swatches(variants, "full"), new = swatches(variants, "new"), halo = swatches(skins, "halo"),
				polestar = swatches(skins, "polestar"), forever = swatches(skins, "forever"), scheme = swatches(cards("ui.scheme"), "moonlit") }
		end
		local out = all()
		Polestar.Set("ui.accent", { 1, 0, 0 })
		local own = all()
		out.fullOwn, out.newOwn = own.full, own.new
		emit(out)"##,
	);
	assert_eq!(out["full"], json!({ "accent": "afc0ff", "accent2": "d8e0ff", "glow": "c8d4ff" }), "Full moon: silver");
	assert_eq!(out["new"], json!({ "accent": "afc0ff", "accent2": "7f9cff", "glow": "6f8dff" }), "New moon: blue");
	assert_eq!(out["fullOwn"], json!({ "accent": "ff0000", "accent2": "d8e0ff", "glow": "c8d4ff" }), "the player's accent, the variant's own swatches");
	assert_eq!(out["newOwn"], json!({ "accent": "ff0000", "accent2": "7f9cff", "glow": "6f8dff" }));
	for k in ["halo", "polestar", "forever", "scheme"] {
		assert_eq!((out[k]["accent2"].clone(), out[k]["glow"].clone()), (json!(false), json!(false)), "{k}: the accent alone");
	}
}

// A variant drawn from another look, picked while its skin is in use and the guide window shows: the window is
// dressed again in that look (the game looks' status bar in place of the house's progress line) and back, though
// the skin in use stays the same.
#[test]
fn a_variant_drawn_from_another_look_dresses_the_open_guide_window_in_it_and_back() {
	let out = run_ui(
		r##"
		local T = Polestar.Theme
		local foot = GF.parts.foot
		local ok, why = T.RegisterSkin("duo", { name = "Duo", addon = "Test_Duo", defaultVariant = "flat", variants = {
			{ id = "flat", name = "Flat" },
			{ id = "forever", name = "On WoW Forever", base = "forever" },
			{ id = "blizzard", name = "On Blizzard", base = "blizzard" },
		} })
		uistub.openTabs(TABS, 1)
		local function look()
			local bar = rawget(foot, "Status")
			return { key = T.SkinKey(), line = foot.Line:IsShown(), bar = bar and bar:IsShown() or false }
		end
		Polestar.Set("ui.skin", "duo")
		local out = { ok = ok, why = why or false, flat = look() }
		Polestar.Set("ui.skinVariants.duo", "forever")
		out.forever = look()
		Polestar.Set("ui.skinVariants.duo", "blizzard")
		out.blizzard = look()
		Polestar.Set("ui.skinVariants.duo", "flat")
		out.back = look()
		emit(out)"##,
	);
	assert_eq!(out["ok"], true, "registered: {}", out["why"]);
	assert_eq!(out["flat"], json!({ "key": "polestar", "line": true, "bar": false }));
	assert_eq!(out["forever"], json!({ "key": "forever", "line": false, "bar": true }), "dressed as WoW Forever: its status bar");
	assert_eq!(out["blizzard"], json!({ "key": "blizzard", "line": false, "bar": true }));
	assert_eq!(out["back"], out["flat"], "back to the house's progress line");
}
